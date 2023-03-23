Describe 'osinfo resource tests' {
    It 'should get osinfo' {
        $out = dsc resource get -r osinfo | ConvertFrom-Json
        $LASTEXITCODE | Should -Be 0
        if ($IsWindows) {
            $out.actual_state.type | Should -BeExactly 'Windows'
        }
        elseif ($IsLinux) {
            $out.actual_state.type | Should -BeExactly 'Ubuntu'
        }
        elseif ($IsMacOS) {
            $out.actual_state.type | Should -BeExactly 'Macos'
        }

        $out.actual_state.version | Should -Not -BeNullOrEmpty
        if ([Environment]::Is64BitProcess) {
            $out.actual_state.bitness | Should -BeExactly 'X64'
        }
        else {
            $out.actual_state.bitness | Should -BeExactly 'X32'
        }
    }

    It 'should perform synthetic test' {
        $out = '{"type": "does_not_exist"}' | dsc resource test -r osinfo | ConvertFrom-Json
        $actual = dsc resource get -r osinfo | ConvertFrom-Json
        $out.actual_state.type | Should -BeExactly $actual.actual_state.type
        $out.actual_state.version | Should -BeExactly $actual.actual_state.version
        $out.actual_state.bitness | Should -BeExactly $actual.actual_state.bitness
        $out.actual_state.edition | Should -BeExactly $actual.actual_state.edition
        $out.diff_properties | Should -Be @('type')
    }
}
