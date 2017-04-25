From: Dennis Schridde <dennis.schridde-axtXthT+lymYbFdUjOg7S7NAH6kLmebB@public.gmane.org>
Subject: Re: amdgpu 0000:84:00.0: gpu post error! \\ Fatal error during GPU
 init
Date: Tue, 25 Apr 2017 10:51:09 +0200
Message-ID: <1616011.QrQCNzfxXf@c07060>
References: <6570445.DKuzpyIqJk@c07060> <2718321.4rFqy0DFN7@c07060>
 <16054053.I0I8DtKEcm@c07060>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0039329088=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <16054053.I0I8DtKEcm@c07060>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============0039329088==
Content-Type: multipart/signed; boundary="nextPart2957866.hxjb1VdSQ4"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2957866.hxjb1VdSQ4
Content-Type: multipart/mixed; boundary="nextPart1513726.M0Aj1V26Xq"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart1513726.M0Aj1V26Xq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi!

I replaced the AMD FirePro S7150X2 card with a AMD Radeon R5 230 (the only 
other AMD card we had available), to see whether the problem was caused by 
another hardware component of the system.

The kernel boots fine with this card. I see no errors in the log (attached).

--Dennis
--nextPart1513726.M0Aj1V26Xq
Content-Disposition: attachment; filename="node-amd-no-kernel-oops.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="UTF-8"; name="node-amd-no-kernel-oops.log"

[    0.000000] Linux version 4.10.9-coreos-r1 (tf128@c07060) (gcc version 4.9.4 (Gentoo Hardened 4.9.4 p1.0, pie-0.6.4) ) #1 SMP Thu Apr 13 19:02:51 CEST 2017
[    0.000000] Command line: coreos.config.url=http://192.168.10.27:8080/ignition?uuid=4c4c4544-004c-5610-804c-b8c04f574732&mac=18-66-da-f0-43-18 coreos.autologin coreos.first_boot console=ttyS0,115200n8 console=tty0
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008e000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007a288fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a289000-0x000000007af0afff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007af0b000-0x000000007b93afff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007b93b000-0x000000007bab3fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007bab4000-0x000000007bae8fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007bae9000-0x000000007bafefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007baff000-0x000000007bafffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007bb00000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feda8000-0x00000000fedabfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff310000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000407fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: Dell Inc. PowerEdge R730/0WCJNT, BIOS 2.2.5 09/06/2016
[    0.000000] e820: last_pfn = 0x4080000 max_arch_pfn = 0x400000000
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT
[    0.000000] e820: last_pfn = 0x7bb00 max_arch_pfn = 0x400000000
[    0.000000] Using GB pages for direct mapping
[    0.000000] RAMDISK: [mem 0x6abee000-0x7a1eafff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000FE320 000024 (v02 DELL  )
[    0.000000] ACPI: XSDT 0x000000007BAF9188 0000D4 (v01 DELL   PE_SC3   00000000      01000013)
[    0.000000] ACPI: FACP 0x000000007BAAC000 0000F4 (v04 DELL   PE_SC3   00000000 DELL 00000001)
[    0.000000] ACPI: DSDT 0x000000007BA94000 0107EF (v02 DELL   PE_SC3   00000003 DELL 00000001)
[    0.000000] ACPI: FACS 0x000000007B8C2000 000040
[    0.000000] ACPI: MCEJ 0x000000007BAB1000 000130 (v01 INTEL           00000001 INTL 0100000D)
[    0.000000] ACPI: SSDT 0x000000007BAB0000 0003C6 (v02 DELL   Tpm2Tabl 00001000 INTL 20121114)
[    0.000000] ACPI: TPM2 0x000000007BAAF000 000038 (v04 DELL   EDK2     00000002      01000013)
[    0.000000] ACPI: WD__ 0x000000007BAAE000 000134 (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: SLIC 0x000000007BAAD000 000024 (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: HPET 0x000000007BAAB000 000038 (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: APIC 0x000000007BAAA000 000AFC (v02 DELL   PE_SC3   00000000 DELL 00000001)
[    0.000000] ACPI: MCFG 0x000000007BAA9000 00003C (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: MSCT 0x000000007BAA8000 000090 (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: SLIT 0x000000007BAA7000 00006C (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: SRAT 0x000000007BAA5000 001130 (v03 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: SSDT 0x000000007B951000 1424A9 (v02 DELL   PE_SC3   00004000 INTL 20121114)
[    0.000000] ACPI: SSDT 0x000000007B94E000 002198 (v02 DELL   PE_SC3   00000002 INTL 20121114)
[    0.000000] ACPI: SSDT 0x000000007B94D000 00006E (v02 DELL   PE_SC3   00000002 INTL 20121114)
[    0.000000] ACPI: PRAD 0x000000007B94C000 000132 (v02 DELL   PE_SC3   00000002 INTL 20121114)
[    0.000000] ACPI: SPCR 0x000000007BAFE000 000050 (v01                 00000000      00000000)
[    0.000000] ACPI: DMAR 0x000000007BAFD000 000120 (v01 DELL   PE_SC3   00000001 DELL 00000001)
[    0.000000] ACPI: HEST 0x000000007BAFC000 00017C (v01 DELL   PE_SC3   00000002 DELL 00000001)
[    0.000000] ACPI: BERT 0x000000007BAFB000 000030 (v01 DELL   PE_SC3   00000002 DELL 00000001)
[    0.000000] ACPI: ERST 0x000000007BAFA000 000230 (v01 DELL   PE_SC3   00000002 DELL 00000001)
[    0.000000] ACPI: EINJ 0x000000007BAF8000 000150 (v01 DELL   PE_SC3   00000002 DELL 00000001)
[    0.000000] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x20 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x22 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x24 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x26 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x08 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x28 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x0a -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x2a -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x0c -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x2c -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x10 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x30 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x12 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x32 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x14 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x34 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x16 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x36 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x18 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x38 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x1a -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x3a -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x1c -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x3c -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x21 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x23 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x25 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x27 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x09 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x29 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x0b -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x2b -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x0d -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x2d -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x11 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x31 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x13 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x33 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x15 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x35 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x17 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x37 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x19 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x39 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x1b -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x3b -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x1d -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x3d -> Node 1
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x207fffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x2080000000-0x407fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x207fffa000-0x207fffffff]
[    0.000000] NODE_DATA(1) allocated [mem 0x407fff9000-0x407fffefff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000407fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000008dfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000007a288fff]
[    0.000000]   node   0: [mem 0x000000007bab4000-0x000000007bae8fff]
[    0.000000]   node   0: [mem 0x000000007baff000-0x000000007bafffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000207fffffff]
[    0.000000]   node   1: [mem 0x0000002080000000-0x000000407fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000207fffffff]
[    0.000000] Initmem setup node 1 [mem 0x0000002080000000-0x000000407fffffff]
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x08] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x09] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x10] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x11] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x12] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x13] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x14] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x15] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x16] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x17] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x18] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x19] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x20] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x21] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x22] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x23] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x24] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x25] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x26] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x27] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x28] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x29] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x30] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x31] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x32] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x33] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x34] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x35] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x36] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x37] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x38] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x39] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x40] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x41] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x42] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x43] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x44] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x45] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x46] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x47] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x48] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x49] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x50] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x51] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x52] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x53] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x54] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x55] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x56] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x57] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x58] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x59] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x60] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x61] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x62] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x63] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x64] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x65] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x66] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x67] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x68] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x69] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x70] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x71] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x72] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x73] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x74] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x75] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x76] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x77] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x78] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x79] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x80] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x81] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x82] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x83] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x84] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x85] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x86] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x87] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x88] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x89] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x90] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x91] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x92] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x93] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x94] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x95] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x96] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x97] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x98] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x99] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa0] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa1] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa2] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa3] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa4] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa5] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa6] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa7] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa8] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa9] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xaa] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xab] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xac] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xad] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xae] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xaf] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb0] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb1] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb2] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb3] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb4] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb5] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb6] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb7] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb8] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb9] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xba] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xbb] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xbc] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xbd] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xbe] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xbf] high level lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI 24-47
[    0.000000] IOAPIC[2]: apic_id 10, version 32, address 0xfec40000, GSI 48-71
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 56 CPUs, 0 hotplug CPUs
[    0.000000] e820: [mem 0x90000000-0xfeda7fff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:56 nr_node_ids:2
[    0.000000] percpu: Embedded 35 pages/cpu @ffff9c437f600000 s104600 r8192 d30568 u262144
[    0.000000] Built 2 zonelists in Node order, mobility grouping on.  Total pages: 66036651
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: rootflags=rw mount.usrflags=ro coreos.config.url=http://192.168.10.27:8080/ignition?uuid=4c4c4544-004c-5610-804c-b8c04f574732&mac=18-66-da-f0-43-18 coreos.autologin coreos.first_boot console=ttyS0,115200n8 console=tty0
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 225280 bytes
[    0.000000] log_buf_len min size: 262144 bytes
[    0.000000] log_buf_len: 524288 bytes
[    0.000000] early log buf free: 235728(89%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Memory: 263774616K/268339504K available (6100K kernel code, 1244K rwdata, 2548K rodata, 31652K init, 864K bss, 4564888K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=56, Nodes=2
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 64.
[    0.000000]  RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=56.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=56
[    0.000000] NR_IRQS:33024 nr_irqs:1688 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] console [ttyS0] enabled
[    0.000000] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2600.110 MHz processor
[    0.000027] Calibrating delay loop (skipped), value calculated using timer frequency.. 5200.22 BogoMIPS (lpj=2600110)
[    0.012408] pid_max: default: 57344 minimum: 448
[    0.017880] ACPI: Core revision 20160930
[    0.094109] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.101566] Security Framework initialized
[    0.106437] SELinux:  Initializing.
[    0.119469] Dentry cache hash table entries: 33554432 (order: 16, 268435456 bytes)
[    0.172551] Inode-cache hash table entries: 16777216 (order: 15, 134217728 bytes)
[    0.201297] Mount-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.209733] Mountpoint-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.220299] CPU: Physical Processor ID: 0
[    0.225075] CPU: Processor Core ID: 0
[    0.229467] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.236476] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.244653] mce: CPU supports 22 MCE banks
[    0.249537] CPU0: Thermal monitoring enabled (TM1)
[    0.255202] process: using mwait in idle threads
[    0.260659] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.266986] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.274215] Freeing SMP alternatives memory: 24K
[    0.281953] ftrace: allocating 24090 entries in 95 pages
[    0.296718] smpboot: Max logical packages: 4
[    0.301803] DMAR: Host address width 46
[    0.306379] DMAR: DRHD base: 0x000000fbffc000 flags: 0x0
[    0.312616] DMAR: dmar0: reg_base_addr fbffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.322076] DMAR: DRHD base: 0x000000c7ffc000 flags: 0x1
[    0.328309] DMAR: dmar1: reg_base_addr c7ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.337773] DMAR: RMRR base: 0x0000007ae07000 end: 0x0000007af06fff
[    0.345079] DMAR: ATSR flags: 0x0
[    0.349071] DMAR: ATSR flags: 0x0
[    0.353068] DMAR-IR: IOAPIC id 10 under DRHD base  0xfbffc000 IOMMU 0
[    0.360566] DMAR-IR: IOAPIC id 8 under DRHD base  0xc7ffc000 IOMMU 1
[    0.367961] DMAR-IR: IOAPIC id 9 under DRHD base  0xc7ffc000 IOMMU 1
[    0.375358] DMAR-IR: HPET id 0 under DRHD base 0xc7ffc000
[    0.381687] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out bit.
[    0.381687] DMAR-IR: Use 'intremap=no_x2apic_optout' to override the BIOS setting.
[    0.399729] DMAR-IR: Enabled IRQ remapping in xapic mode
[    0.405954] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.412675] Switched APIC routing to physical flat.
[    0.419038] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.436052] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2690 v4 @ 2.60GHz (family: 0x6, model: 0x4f, stepping: 0x1)
[    0.447824] Performance Events: PEBS fmt2+, Broadwell events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.459813] ... version:                3
[    0.464579] ... bit width:              48
[    0.469445] ... generic registers:      4
[    0.474208] ... value mask:             0000ffffffffffff
[    0.480432] ... max period:             00007fffffffffff
[    0.486657] ... fixed-purpose events:   3
[    0.491424] ... event mask:             000000070000000f
[    0.500441] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.509905] smp: Bringing up secondary CPUs ...
[    0.515358] x86: Booting SMP configuration:
[    0.520318] .... node  #1, CPUs:        #1
[    0.606454] .... node  #0, CPUs:    #2
[    0.672215] .... node  #1, CPUs:    #3
[    0.737926] .... node  #0, CPUs:    #4
[    0.803676] .... node  #1, CPUs:    #5
[    0.869390] .... node  #0, CPUs:    #6
[    0.935139] .... node  #1, CPUs:    #7
[    1.000839] .... node  #0, CPUs:    #8
[    1.066590] .... node  #1, CPUs:    #9
[    1.132388] .... node  #0, CPUs:   #10
[    1.198133] .... node  #1, CPUs:   #11
[    1.263845] .... node  #0, CPUs:   #12
[    1.329595] .... node  #1, CPUs:   #13
[    1.395316] .... node  #0, CPUs:   #14
[    1.461074] .... node  #1, CPUs:   #15
[    1.526791] .... node  #0, CPUs:   #16
[    1.592539] .... node  #1, CPUs:   #17
[    1.658261] .... node  #0, CPUs:   #18
[    1.724016] .... node  #1, CPUs:   #19
[    1.789744] .... node  #0, CPUs:   #20
[    1.855498] .... node  #1, CPUs:   #21
[    1.921224] .... node  #0, CPUs:   #22
[    1.986975] .... node  #1, CPUs:   #23
[    2.052702] .... node  #0, CPUs:   #24
[    2.118452] .... node  #1, CPUs:   #25
[    2.184169] .... node  #0, CPUs:   #26
[    2.249931] .... node  #1, CPUs:   #27
[    2.315650] .... node  #0, CPUs:   #28
[    2.381650] .... node  #1, CPUs:   #29
[    2.447368] .... node  #0, CPUs:   #30
[    2.513215] .... node  #1, CPUs:   #31
[    2.578928] .... node  #0, CPUs:   #32
[    2.644684] .... node  #1, CPUs:   #33
[    2.710404] .... node  #0, CPUs:   #34
[    2.776149] .... node  #1, CPUs:   #35
[    2.841868] .... node  #0, CPUs:   #36
[    2.907618] .... node  #1, CPUs:   #37
[    2.973337] .... node  #0, CPUs:   #38
[    3.039104] .... node  #1, CPUs:   #39
[    3.104826] .... node  #0, CPUs:   #40
[    3.170580] .... node  #1, CPUs:   #41
[    3.236307] .... node  #0, CPUs:   #42
[    3.302064] .... node  #1, CPUs:   #43
[    3.367776] .... node  #0, CPUs:   #44
[    3.433519] .... node  #1, CPUs:   #45
[    3.499235] .... node  #0, CPUs:   #46
[    3.564995] .... node  #1, CPUs:   #47
[    3.630718] .... node  #0, CPUs:   #48
[    3.696478] .... node  #1, CPUs:   #49
[    3.762202] .... node  #0, CPUs:   #50
[    3.827955] .... node  #1, CPUs:   #51
[    3.893684] .... node  #0, CPUs:   #52
[    3.959444] .... node  #1, CPUs:   #53
[    4.025161] .... node  #0, CPUs:   #54
[    4.090919] .... node  #1, CPUs:   #55
[    4.152079] smp: Brought up 2 nodes, 56 CPUs
[    4.161617] smpboot: Total of 56 processors activated (291562.31 BogoMIPS)
[    4.324748] devtmpfs: initialized
[    4.328792] x86/mm: Memory block size: 2048MB
[    4.335786] PM: Registering ACPI NVS region [mem 0x7af0b000-0x7b93afff] (10682368 bytes)
[    4.345566] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    4.357022] futex hash table entries: 16384 (order: 8, 1048576 bytes)
[    4.364909] pinctrl core: initialized pinctrl subsystem
[    4.371890] NET: Registered protocol family 16
[    4.383154] cpuidle: using governor menu
[    4.387830] PCCT header not found.
[    4.392129] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    4.401102] ACPI: bus type PCI registered
[    4.405863] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    4.413423] dca service started, version 1.12.1
[    4.418794] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    4.429762] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
[    4.437654] PCI: Using configuration type 1 for base access
[    4.444179] PCI: Dell System detected, enabling pci=bfsort.
[    4.463543] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    4.470946] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    4.479022] ACPI: Added _OSI(Module Device)
[    4.483996] ACPI: Added _OSI(Processor Device)
[    4.489257] ACPI: Added _OSI(3.0 _SCP Extensions)
[    4.494809] ACPI: Added _OSI(Processor Aggregator Device)
[    4.598437] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    4.616357] ACPI: Interpreter enabled
[    4.620748] ACPI: (supports S0 S5)
[    4.624844] ACPI: Using IOAPIC for interrupt routing
[    4.630732] HEST: Table parsing has been initialized.
[    4.636671] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    4.656934] ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
[    4.663850] acpi PNP0A03:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    4.673571] acpi PNP0A03:02: PCIe AER handled by firmware
[    4.679990] acpi PNP0A03:02: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    4.689072] acpi PNP0A03:02: FADT indicates ASPM is unsupported, using BIOS configuration
[    4.698765] PCI host bridge to bus 0000:ff
[    4.703634] pci_bus 0000:ff: root bus resource [bus ff]
[    4.712262] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus 7f])
[    4.719170] acpi PNP0A03:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    4.728885] acpi PNP0A03:03: PCIe AER handled by firmware
[    4.735313] acpi PNP0A03:03: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    4.744393] acpi PNP0A03:03: FADT indicates ASPM is unsupported, using BIOS configuration
[    4.754070] PCI host bridge to bus 0000:7f
[    4.758941] pci_bus 0000:7f: root bus resource [bus 7f]
[    4.768808] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
[    4.776018] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    4.785737] acpi PNP0A08:00: PCIe AER handled by firmware
[    4.792165] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    4.801240] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    4.811033] PCI host bridge to bus 0000:00
[    4.815911] pci_bus 0000:00: root bus resource [io  0x0000-0x03bb window]
[    4.823789] pci_bus 0000:00: root bus resource [io  0x03bc-0x03df window]
[    4.831677] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    4.839559] pci_bus 0000:00: root bus resource [io  0x1000-0x7fff window]
[    4.847447] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    4.856334] pci_bus 0000:00: root bus resource [mem 0x90000000-0xc7ffbfff window]
[    4.865221] pci_bus 0000:00: root bus resource [mem 0x38000000000-0x3bfffffffff window]
[    4.874697] pci_bus 0000:00: root bus resource [bus 00-7e]
[    4.881424] pci 0000:00:01.0: System wakeup disabled by ACPI
[    4.888217] pci 0000:00:02.0: System wakeup disabled by ACPI
[    4.894977] pci 0000:00:03.0: System wakeup disabled by ACPI
[    4.901724] pci 0000:00:03.1: System wakeup disabled by ACPI
[    4.908479] pci 0000:00:03.2: System wakeup disabled by ACPI
[    4.916375] pci 0000:00:1c.0: Enabling MPC IRBNCE
[    4.921927] pci 0000:00:1c.0: Intel PCH root port ACS workaround enabled
[    4.929869] pci 0000:00:1c.7: Enabling MPC IRBNCE
[    4.935418] pci 0000:00:1c.7: Intel PCH root port ACS workaround enabled
[    4.943233] pci 0000:00:1c.7: System wakeup disabled by ACPI
[    4.950511] pci 0000:00:01.0: PCI bridge to [bus 03]
[    4.956389] pci 0000:00:02.0: PCI bridge to [bus 04]
[    4.966249] pci 0000:00:03.0: PCI bridge to [bus 02]
[    4.976108] pci 0000:00:03.1: PCI bridge to [bus 01]
[    4.981981] pci 0000:00:03.2: PCI bridge to [bus 05]
[    4.987852] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    5.000843] pci 0000:00:1c.7: PCI bridge to [bus 07-0b]
[    5.014586] pci 0000:07:00.0: PCI bridge to [bus 08-0b]
[    5.027042] pci 0000:08:00.0: PCI bridge to [bus 09-0a]
[    5.040215] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    5.047434] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 *15)
[    5.056056] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 *14 15)
[    5.064680] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    5.073306] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 9 10 11 12 14 15)
[    5.081935] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    5.091822] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    5.101708] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    5.111597] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    5.121640] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-fe])
[    5.128845] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    5.138545] acpi PNP0A08:01: PCIe AER handled by firmware
[    5.144969] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    5.154047] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using BIOS configuration
[    5.163808] PCI host bridge to bus 0000:80
[    5.168683] pci_bus 0000:80: root bus resource [io  0x8000-0xffff window]
[    5.176563] pci_bus 0000:80: root bus resource [mem 0xc8000000-0xfbffbfff window]
[    5.185449] pci_bus 0000:80: root bus resource [mem 0x3c000000000-0x3ffffffffff window]
[    5.194897] pci_bus 0000:80: root bus resource [bus 80-fe]
[    5.201439] pci 0000:80:01.0: System wakeup disabled by ACPI
[    5.208184] pci 0000:80:02.0: System wakeup disabled by ACPI
[    5.214927] pci 0000:80:03.0: System wakeup disabled by ACPI
[    5.221670] pci 0000:80:03.2: System wakeup disabled by ACPI
[    5.228650] pci 0000:80:01.0: PCI bridge to [bus 81]
[    5.237499] pci 0000:80:02.0: PCI bridge to [bus 82]
[    5.245319] pci 0000:80:03.0: PCI bridge to [bus 83]
[    5.253123] pci 0000:80:03.2: PCI bridge to [bus 84]
[    5.259042] ACPI: Enabled 2 GPEs in block 00 to 3F
[    5.288460] pci 0000:0a:00.0: vgaarb: setting as boot VGA device
[    5.295474] pci 0000:0a:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    5.305533] pci 0000:82:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    5.315387] pci 0000:82:00.0: vgaarb: bridge control possible
[    5.322107] pci 0000:0a:00.0: vgaarb: bridge control possible
[    5.328822] vgaarb: loaded
[    5.332164] PCI: Using ACPI for IRQ routing
[    5.343396] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    5.350606] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    5.359527] clocksource: Switched to clocksource hpet
[    5.371614] VFS: Disk quotas dquot_6.6.0
[    5.376328] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    5.384396] pnp: PnP ACPI init
[    5.388696] system 00:01: [io  0x0500-0x053f] has been reserved
[    5.395607] system 00:01: [io  0x0400-0x047f] has been reserved
[    5.402517] system 00:01: [io  0x0540-0x057f] has been reserved
[    5.409430] system 00:01: [io  0x0600-0x061f] has been reserved
[    5.416340] system 00:01: [io  0x0ca0-0x0ca5] has been reserved
[    5.423256] system 00:01: [io  0x0880-0x0883] has been reserved
[    5.430165] system 00:01: [io  0x0800-0x081f] has been reserved
[    5.437078] system 00:01: [mem 0xfeda8000-0xfedcbfff] could not be reserved
[    5.445160] system 00:01: [mem 0xff000000-0xffffffff] could not be reserved
[    5.453238] system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
[    5.460927] system 00:01: [mem 0xfed12000-0xfed1200f] has been reserved
[    5.468613] system 00:01: [mem 0xfed12010-0xfed1201f] has been reserved
[    5.476298] system 00:01: [mem 0xfed1b000-0xfed1bfff] has been reserved
[    5.484289] system 00:04: [io  0x0ca8] has been reserved
[    5.490516] system 00:04: [io  0x0cac] has been reserved
[    5.496837] pnp: PnP ACPI: found 5 devices
[    5.507326] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    5.517795] pci 0000:03:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    5.529401] pci 0000:02:00.0: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no compatible bridge window
[    5.541011] pci 0000:02:00.1: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no compatible bridge window
[    5.552708] pci 0000:01:00.0: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no compatible bridge window
[    5.564317] pci 0000:01:00.1: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no compatible bridge window
[    5.575931] pci 0000:82:00.0: can't claim BAR 6 [mem 0xfffe0000-0xffffffff pref]: no compatible bridge window
[    5.587536] pci 0000:83:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    5.599131] pci 0000:83:00.1: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    5.610740] pci 0000:84:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    5.622351] pci 0000:84:00.1: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    5.634784] pci 0000:00:03.0: BAR 14: assigned [mem 0x91f00000-0x91ffffff]
[    5.642773] pci 0000:00:03.1: BAR 14: assigned [mem 0x92000000-0x920fffff]
[    5.650759] pci 0000:03:00.0: BAR 6: no space for [mem size 0x00100000 pref]
[    5.658939] pci 0000:03:00.0: BAR 6: failed to assign [mem size 0x00100000 pref]
[    5.667730] pci 0000:00:01.0: PCI bridge to [bus 03]
[    5.673578] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    5.680691] pci 0000:00:01.0:   bridge window [mem 0x91c00000-0x91dfffff]
[    5.688574] pci 0000:00:02.0: PCI bridge to [bus 04]
[    5.694423] pci 0000:02:00.0: BAR 6: assigned [mem 0x91f00000-0x91f3ffff pref]
[    5.703019] pci 0000:02:00.1: BAR 6: assigned [mem 0x91f40000-0x91f7ffff pref]
[    5.711615] pci 0000:00:03.0: PCI bridge to [bus 02]
[    5.722902] pci 0000:00:03.0:   bridge window [mem 0x91f00000-0x91ffffff]
[    5.730790] pci 0000:00:03.0:   bridge window [mem 0x91a00000-0x91afffff 64bit pref]
[    5.739968] pci 0000:01:00.0: BAR 6: assigned [mem 0x92000000-0x9203ffff pref]
[    5.748651] pci 0000:01:00.1: BAR 6: assigned [mem 0x92040000-0x9207ffff pref]
[    5.757254] pci 0000:00:03.1: PCI bridge to [bus 01]
[    5.763105] pci 0000:00:03.1:   bridge window [mem 0x92000000-0x920fffff]
[    5.770996] pci 0000:00:03.1:   bridge window [mem 0x91b00000-0x91bfffff 64bit pref]
[    5.780179] pci 0000:00:03.2: PCI bridge to [bus 05]
[    5.786033] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    5.791884] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    5.797881] pci 0000:09:00.0:   bridge window [mem 0x91000000-0x918fffff]
[    5.805862] pci 0000:09:00.0:   bridge window [mem 0x90000000-0x90ffffff 64bit pref]
[    5.815249] pci 0000:08:00.0: PCI bridge to [bus 09-0a]
[    5.821540] pci 0000:08:00.0:   bridge window [mem 0x91000000-0x918fffff]
[    5.829528] pci 0000:08:00.0:   bridge window [mem 0x90000000-0x90ffffff 64bit pref]
[    5.838912] pci 0000:07:00.0: PCI bridge to [bus 08-0b]
[    5.845180] pci 0000:07:00.0:   bridge window [mem 0x91000000-0x919fffff]
[    5.853153] pci 0000:07:00.0:   bridge window [mem 0x90000000-0x90ffffff 64bit pref]
[    5.862563] pci 0000:00:1c.7: PCI bridge to [bus 07-0b]
[    5.868706] pci 0000:00:1c.7:   bridge window [mem 0x91000000-0x919fffff]
[    5.876588] pci 0000:00:1c.7:   bridge window [mem 0x90000000-0x90ffffff 64bit pref]
[    5.885862] pci 0000:80:03.0: BAR 14: assigned [mem 0xd0200000-0xd03fffff]
[    5.893849] pci 0000:80:03.2: BAR 14: assigned [mem 0xd0400000-0xd05fffff]
[    5.901832] pci 0000:80:01.0: PCI bridge to [bus 81]
[    5.907683] pci 0000:82:00.0: BAR 6: assigned [mem 0xd0040000-0xd005ffff pref]
[    5.916280] pci 0000:80:02.0: PCI bridge to [bus 82]
[    5.922126] pci 0000:80:02.0:   bridge window [io  0x8000-0x8fff]
[    5.929236] pci 0000:80:02.0:   bridge window [mem 0xd0000000-0xd00fffff]
[    5.937124] pci 0000:80:02.0:   bridge window [mem 0x3fff0000000-0x3ffffffffff 64bit pref]
[    5.946886] pci 0000:83:00.0: BAR 6: assigned [mem 0xd0200000-0xd02fffff pref]
[    5.955489] pci 0000:83:00.1: BAR 6: assigned [mem 0xd0300000-0xd03fffff pref]
[    5.964089] pci 0000:80:03.0: PCI bridge to [bus 83]
[    5.969936] pci 0000:80:03.0:   bridge window [mem 0xd0200000-0xd03fffff]
[    5.977825] pci 0000:80:03.0:   bridge window [mem 0xc8000000-0xcbffffff 64bit pref]
[    5.987007] pci 0000:84:00.0: BAR 6: assigned [mem 0xd0400000-0xd04fffff pref]
[    5.995608] pci 0000:84:00.1: BAR 6: assigned [mem 0xd0500000-0xd05fffff pref]
[    6.004204] pci 0000:80:03.2: PCI bridge to [bus 84]
[    6.010055] pci 0000:80:03.2:   bridge window [mem 0xd0400000-0xd05fffff]
[    6.017941] pci 0000:80:03.2:   bridge window [mem 0xcc000000-0xcfffffff 64bit pref]
[    6.027195] NET: Registered protocol family 2
[    6.032856] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[    6.042375] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    6.050321] TCP: Hash tables configured (established 524288 bind 65536)
[    6.058106] UDP hash table entries: 65536 (order: 9, 2097152 bytes)
[    6.065765] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes)
[    6.074022] NET: Registered protocol family 1
[    6.092652] pci 0000:03:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
[    6.105274] pci 0000:0a:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    6.467787] Unpacking initramfs...
[    6.981582] Freeing initrd memory: 251892K
[    7.001191] DMAR: dmar0: Using Queued invalidation
[    7.006898] DMAR: dmar1: Using Queued invalidation
[    7.012575] DMAR: Setting RMRR:
[    7.016905] DMAR: Setting identity map for device 0000:00:1a.0 [0x7ae07000 - 0x7af06fff]
[    7.026991] DMAR: Setting identity map for device 0000:00:1d.0 [0x7ae07000 - 0x7af06fff]
[    7.036564] DMAR: Prepare 0-16MiB unity mapping for LPC
[    7.043197] DMAR: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]
[    7.051895] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    7.059513] iommu: Adding device 0000:00:00.0 to group 0
[    7.065773] iommu: Adding device 0000:00:01.0 to group 1
[    7.072039] iommu: Adding device 0000:00:02.0 to group 2
[    7.078292] iommu: Adding device 0000:00:03.0 to group 3
[    7.084545] iommu: Adding device 0000:00:03.1 to group 4
[    7.090804] iommu: Adding device 0000:00:03.2 to group 5
[    7.097128] iommu: Adding device 0000:00:05.0 to group 6
[    7.103387] iommu: Adding device 0000:00:05.1 to group 6
[    7.109645] iommu: Adding device 0000:00:05.2 to group 6
[    7.115899] iommu: Adding device 0000:00:05.4 to group 6
[    7.122189] iommu: Adding device 0000:00:11.0 to group 7
[    7.128442] iommu: Adding device 0000:00:11.4 to group 7
[    7.134732] iommu: Adding device 0000:00:16.0 to group 8
[    7.140990] iommu: Adding device 0000:00:16.1 to group 8
[    7.147247] iommu: Adding device 0000:00:1a.0 to group 9
[    7.153502] iommu: Adding device 0000:00:1c.0 to group 10
[    7.159854] iommu: Adding device 0000:00:1c.7 to group 11
[    7.166204] iommu: Adding device 0000:00:1d.0 to group 12
[    7.172589] iommu: Adding device 0000:00:1f.0 to group 13
[    7.178941] iommu: Adding device 0000:00:1f.2 to group 13
[    7.185328] iommu: Adding device 0000:01:00.0 to group 14
[    7.191679] iommu: Adding device 0000:01:00.1 to group 14
[    7.198068] iommu: Adding device 0000:02:00.0 to group 15
[    7.204431] iommu: Adding device 0000:02:00.1 to group 15
[    7.210778] iommu: Adding device 0000:03:00.0 to group 16
[    7.217124] iommu: Adding device 0000:07:00.0 to group 17
[    7.223476] iommu: Adding device 0000:08:00.0 to group 18
[    7.229847] iommu: Adding device 0000:09:00.0 to group 18
[    7.236190] iommu: Adding device 0000:0a:00.0 to group 18
[    7.242589] iommu: Adding device 0000:7f:08.0 to group 19
[    7.248932] iommu: Adding device 0000:7f:08.2 to group 19
[    7.255283] iommu: Adding device 0000:7f:08.3 to group 19
[    7.261682] iommu: Adding device 0000:7f:09.0 to group 20
[    7.268037] iommu: Adding device 0000:7f:09.2 to group 20
[    7.274390] iommu: Adding device 0000:7f:09.3 to group 20
[    7.280804] iommu: Adding device 0000:7f:0b.0 to group 21
[    7.287162] iommu: Adding device 0000:7f:0b.1 to group 21
[    7.293517] iommu: Adding device 0000:7f:0b.2 to group 21
[    7.299870] iommu: Adding device 0000:7f:0b.3 to group 21
[    7.306342] iommu: Adding device 0000:7f:0c.0 to group 22
[    7.312788] iommu: Adding device 0000:7f:0c.1 to group 22
[    7.319144] iommu: Adding device 0000:7f:0c.2 to group 22
[    7.325498] iommu: Adding device 0000:7f:0c.3 to group 22
[    7.331853] iommu: Adding device 0000:7f:0c.4 to group 22
[    7.338199] iommu: Adding device 0000:7f:0c.5 to group 22
[    7.344555] iommu: Adding device 0000:7f:0c.6 to group 22
[    7.350913] iommu: Adding device 0000:7f:0c.7 to group 22
[    7.357365] iommu: Adding device 0000:7f:0d.0 to group 23
[    7.363724] iommu: Adding device 0000:7f:0d.1 to group 23
[    7.370076] iommu: Adding device 0000:7f:0d.2 to group 23
[    7.376427] iommu: Adding device 0000:7f:0d.3 to group 23
[    7.382783] iommu: Adding device 0000:7f:0d.4 to group 23
[    7.389141] iommu: Adding device 0000:7f:0d.5 to group 23
[    7.395604] iommu: Adding device 0000:7f:0f.0 to group 24
[    7.401951] iommu: Adding device 0000:7f:0f.1 to group 24
[    7.408307] iommu: Adding device 0000:7f:0f.2 to group 24
[    7.414665] iommu: Adding device 0000:7f:0f.3 to group 24
[    7.421026] iommu: Adding device 0000:7f:0f.4 to group 24
[    7.427378] iommu: Adding device 0000:7f:0f.5 to group 24
[    7.433736] iommu: Adding device 0000:7f:0f.6 to group 24
[    7.440158] iommu: Adding device 0000:7f:10.0 to group 25
[    7.446515] iommu: Adding device 0000:7f:10.1 to group 25
[    7.452873] iommu: Adding device 0000:7f:10.5 to group 25
[    7.459219] iommu: Adding device 0000:7f:10.6 to group 25
[    7.465576] iommu: Adding device 0000:7f:10.7 to group 25
[    7.472024] iommu: Adding device 0000:7f:12.0 to group 26
[    7.478383] iommu: Adding device 0000:7f:12.1 to group 26
[    7.484740] iommu: Adding device 0000:7f:12.2 to group 26
[    7.491099] iommu: Adding device 0000:7f:12.4 to group 26
[    7.497453] iommu: Adding device 0000:7f:12.5 to group 26
[    7.503809] iommu: Adding device 0000:7f:12.6 to group 26
[    7.510260] iommu: Adding device 0000:7f:13.0 to group 27
[    7.516610] iommu: Adding device 0000:7f:13.1 to group 27
[    7.522969] iommu: Adding device 0000:7f:13.2 to group 27
[    7.529327] iommu: Adding device 0000:7f:13.3 to group 27
[    7.535685] iommu: Adding device 0000:7f:13.6 to group 27
[    7.542034] iommu: Adding device 0000:7f:13.7 to group 27
[    7.548519] iommu: Adding device 0000:7f:14.0 to group 28
[    7.554873] iommu: Adding device 0000:7f:14.1 to group 28
[    7.561229] iommu: Adding device 0000:7f:14.2 to group 28
[    7.567590] iommu: Adding device 0000:7f:14.3 to group 28
[    7.573955] iommu: Adding device 0000:7f:14.4 to group 28
[    7.580321] iommu: Adding device 0000:7f:14.5 to group 28
[    7.586686] iommu: Adding device 0000:7f:14.6 to group 28
[    7.593046] iommu: Adding device 0000:7f:14.7 to group 28
[    7.599499] iommu: Adding device 0000:7f:16.0 to group 29
[    7.605862] iommu: Adding device 0000:7f:16.1 to group 29
[    7.612218] iommu: Adding device 0000:7f:16.2 to group 29
[    7.618576] iommu: Adding device 0000:7f:16.3 to group 29
[    7.624937] iommu: Adding device 0000:7f:16.6 to group 29
[    7.631297] iommu: Adding device 0000:7f:16.7 to group 29
[    7.637779] iommu: Adding device 0000:7f:17.0 to group 30
[    7.644139] iommu: Adding device 0000:7f:17.1 to group 30
[    7.650498] iommu: Adding device 0000:7f:17.2 to group 30
[    7.656858] iommu: Adding device 0000:7f:17.3 to group 30
[    7.663219] iommu: Adding device 0000:7f:17.4 to group 30
[    7.669572] iommu: Adding device 0000:7f:17.5 to group 30
[    7.675932] iommu: Adding device 0000:7f:17.6 to group 30
[    7.682289] iommu: Adding device 0000:7f:17.7 to group 30
[    7.688721] iommu: Adding device 0000:7f:1e.0 to group 31
[    7.700506] iommu: Adding device 0000:7f:1e.1 to group 31
[    7.706868] iommu: Adding device 0000:7f:1e.2 to group 31
[    7.713226] iommu: Adding device 0000:7f:1e.3 to group 31
[    7.719590] iommu: Adding device 0000:7f:1e.4 to group 31
[    7.725970] iommu: Adding device 0000:7f:1f.0 to group 32
[    7.732330] iommu: Adding device 0000:7f:1f.2 to group 32
[    7.738682] iommu: Adding device 0000:80:01.0 to group 33
[    7.745032] iommu: Adding device 0000:80:02.0 to group 34
[    7.751388] iommu: Adding device 0000:80:03.0 to group 35
[    7.757746] iommu: Adding device 0000:80:03.2 to group 36
[    7.764165] iommu: Adding device 0000:80:05.0 to group 37
[    7.770525] iommu: Adding device 0000:80:05.1 to group 37
[    7.776879] iommu: Adding device 0000:80:05.2 to group 37
[    7.783235] iommu: Adding device 0000:80:05.4 to group 37
[    7.789622] iommu: Adding device 0000:82:00.0 to group 38
[    7.795989] iommu: Adding device 0000:82:00.1 to group 38
[    7.802402] iommu: Adding device 0000:83:00.0 to group 39
[    7.808789] iommu: Adding device 0000:83:00.1 to group 39
[    7.815199] iommu: Adding device 0000:84:00.0 to group 40
[    7.821588] iommu: Adding device 0000:84:00.1 to group 40
[    7.827990] iommu: Adding device 0000:ff:08.0 to group 41
[    7.834354] iommu: Adding device 0000:ff:08.2 to group 41
[    7.840718] iommu: Adding device 0000:ff:08.3 to group 41
[    7.847111] iommu: Adding device 0000:ff:09.0 to group 42
[    7.853567] iommu: Adding device 0000:ff:09.2 to group 42
[    7.859931] iommu: Adding device 0000:ff:09.3 to group 42
[    7.866348] iommu: Adding device 0000:ff:0b.0 to group 43
[    7.872706] iommu: Adding device 0000:ff:0b.1 to group 43
[    7.879067] iommu: Adding device 0000:ff:0b.2 to group 43
[    7.885431] iommu: Adding device 0000:ff:0b.3 to group 43
[    7.891912] iommu: Adding device 0000:ff:0c.0 to group 44
[    7.898270] iommu: Adding device 0000:ff:0c.1 to group 44
[    7.904634] iommu: Adding device 0000:ff:0c.2 to group 44
[    7.910989] iommu: Adding device 0000:ff:0c.3 to group 44
[    7.917355] iommu: Adding device 0000:ff:0c.4 to group 44
[    7.923717] iommu: Adding device 0000:ff:0c.5 to group 44
[    7.930083] iommu: Adding device 0000:ff:0c.6 to group 44
[    7.936445] iommu: Adding device 0000:ff:0c.7 to group 44
[    7.942892] iommu: Adding device 0000:ff:0d.0 to group 45
[    7.949256] iommu: Adding device 0000:ff:0d.1 to group 45
[    7.955611] iommu: Adding device 0000:ff:0d.2 to group 45
[    7.961975] iommu: Adding device 0000:ff:0d.3 to group 45
[    7.968333] iommu: Adding device 0000:ff:0d.4 to group 45
[    7.974696] iommu: Adding device 0000:ff:0d.5 to group 45
[    7.981160] iommu: Adding device 0000:ff:0f.0 to group 46
[    7.987526] iommu: Adding device 0000:ff:0f.1 to group 46
[    7.993889] iommu: Adding device 0000:ff:0f.2 to group 46
[    8.000250] iommu: Adding device 0000:ff:0f.3 to group 46
[    8.006615] iommu: Adding device 0000:ff:0f.4 to group 46
[    8.012975] iommu: Adding device 0000:ff:0f.5 to group 46
[    8.019340] iommu: Adding device 0000:ff:0f.6 to group 46
[    8.025772] iommu: Adding device 0000:ff:10.0 to group 47
[    8.032138] iommu: Adding device 0000:ff:10.1 to group 47
[    8.038498] iommu: Adding device 0000:ff:10.5 to group 47
[    8.044865] iommu: Adding device 0000:ff:10.6 to group 47
[    8.051234] iommu: Adding device 0000:ff:10.7 to group 47
[    8.057674] iommu: Adding device 0000:ff:12.0 to group 48
[    8.064038] iommu: Adding device 0000:ff:12.1 to group 48
[    8.070409] iommu: Adding device 0000:ff:12.2 to group 48
[    8.076773] iommu: Adding device 0000:ff:12.4 to group 48
[    8.083137] iommu: Adding device 0000:ff:12.5 to group 48
[    8.089506] iommu: Adding device 0000:ff:12.6 to group 48
[    8.095953] iommu: Adding device 0000:ff:13.0 to group 49
[    8.102317] iommu: Adding device 0000:ff:13.1 to group 49
[    8.108675] iommu: Adding device 0000:ff:13.2 to group 49
[    8.115042] iommu: Adding device 0000:ff:13.3 to group 49
[    8.121413] iommu: Adding device 0000:ff:13.6 to group 49
[    8.127777] iommu: Adding device 0000:ff:13.7 to group 49
[    8.134262] iommu: Adding device 0000:ff:14.0 to group 50
[    8.140629] iommu: Adding device 0000:ff:14.1 to group 50
[    8.147000] iommu: Adding device 0000:ff:14.2 to group 50
[    8.153361] iommu: Adding device 0000:ff:14.3 to group 50
[    8.159734] iommu: Adding device 0000:ff:14.4 to group 50
[    8.166100] iommu: Adding device 0000:ff:14.5 to group 50
[    8.172465] iommu: Adding device 0000:ff:14.6 to group 50
[    8.178827] iommu: Adding device 0000:ff:14.7 to group 50
[    8.185280] iommu: Adding device 0000:ff:16.0 to group 51
[    8.191649] iommu: Adding device 0000:ff:16.1 to group 51
[    8.198016] iommu: Adding device 0000:ff:16.2 to group 51
[    8.204387] iommu: Adding device 0000:ff:16.3 to group 51
[    8.210754] iommu: Adding device 0000:ff:16.6 to group 51
[    8.217121] iommu: Adding device 0000:ff:16.7 to group 51
[    8.223597] iommu: Adding device 0000:ff:17.0 to group 52
[    8.229966] iommu: Adding device 0000:ff:17.1 to group 52
[    8.236332] iommu: Adding device 0000:ff:17.2 to group 52
[    8.242699] iommu: Adding device 0000:ff:17.3 to group 52
[    8.249067] iommu: Adding device 0000:ff:17.4 to group 52
[    8.255434] iommu: Adding device 0000:ff:17.5 to group 52
[    8.261802] iommu: Adding device 0000:ff:17.6 to group 52
[    8.268172] iommu: Adding device 0000:ff:17.7 to group 52
[    8.274605] iommu: Adding device 0000:ff:1e.0 to group 53
[    8.280964] iommu: Adding device 0000:ff:1e.1 to group 53
[    8.287333] iommu: Adding device 0000:ff:1e.2 to group 53
[    8.293701] iommu: Adding device 0000:ff:1e.3 to group 53
[    8.300070] iommu: Adding device 0000:ff:1e.4 to group 53
[    8.306455] iommu: Adding device 0000:ff:1f.0 to group 54
[    8.312821] iommu: Adding device 0000:ff:1f.2 to group 54
[    8.320300] Intel CQM monitoring enabled
[    8.324982] Intel MBM enabled
[    8.329609] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    8.338995] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    8.345714] RAPL PMU: hw unit of domain package 2^-14 Joules
[    8.352333] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    8.358666] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    8.368605] audit: initializing netlink subsys (disabled)
[    8.375554] Initialise system trusted keyrings
[    8.381037] workingset: timestamp_bits=39 max_order=26 bucket_order=0
[    8.625713] Key type asymmetric registered
[    8.630589] Asymmetric key parser 'x509' registered
[    8.636356] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    8.645251] io scheduler noop registered
[    8.649931] io scheduler deadline registered
[    8.655005] io scheduler cfq registered (default)
[    8.664882] pcieport 0000:00:01.0: Signaling PME with IRQ 26
[    8.671520] pcieport 0000:00:02.0: Signaling PME with IRQ 27
[    8.678159] pcieport 0000:00:03.0: Signaling PME with IRQ 28
[    8.684794] pcieport 0000:00:03.1: Signaling PME with IRQ 29
[    8.691428] pcieport 0000:00:03.2: Signaling PME with IRQ 30
[    8.698065] pcieport 0000:00:1c.0: Signaling PME with IRQ 31
[    8.704708] pcieport 0000:00:1c.7: Signaling PME with IRQ 32
[    8.711336] pcieport 0000:80:01.0: Signaling PME with IRQ 33
[    8.717968] pcieport 0000:80:02.0: Signaling PME with IRQ 34
[    8.724600] pcieport 0000:80:03.0: Signaling PME with IRQ 35
[    8.731233] pcieport 0000:80:03.2: Signaling PME with IRQ 36
[    8.740844] ERST: Error Record Serialization Table (ERST) support is initialized.
[    8.749735] pstore: using zlib compression
[    8.754617] pstore: Registered erst as persistent store backend
[    8.761884] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
[    8.770703] ioatdma: Intel(R) QuickData Technology Driver 4.00
[    8.777633] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    8.805500] 00:02: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    8.834780] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    8.846763] i8042: PNP: No PS/2 controller found.
[    8.852359] rtc_cmos 00:00: RTC can wake from S4
[    8.857959] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    8.865187] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    8.874278] intel_pstate: Intel P-state driver initializing
[    8.883962] NET: Registered protocol family 10
[    8.889671] Segment Routing with IPv6
[    8.894091] NET: Registered protocol family 17
[    8.899362] Key type dns_resolver registered
[    8.909381] microcode: sig=0x406f1, pf=0x1, revision=0xb00001e
[    8.917816] microcode: Microcode Update Driver: v2.2.
[    8.917893] registered taskstats version 1
[    8.928747] Loading compiled-in X.509 certificates
[    8.935866] alg: No test for pkcs1pad(rsa,sha256) (pkcs1pad(rsa-generic,sha256))
[    8.945284] Loaded X.509 cert 'CoreOS, Inc: Module signing key for 4.10.9-coreos-r1: a0690eb783f324cde9a923c40c2f51f1a00a3853'
[    8.958587] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
[    8.968261] rtc_cmos 00:00: setting system clock to 2017-04-25 08:38:40 UTC (1493109520)
[    8.985529] Freeing unused kernel memory: 31652K
[    8.991005] Write protecting the kernel read-only data: 10240k
[    8.998066] Freeing unused kernel memory: 28K
[    9.005958] Freeing unused kernel memory: 1548K
[    9.013912] Unable to open file: /etc/ima/ima-policy (-2)
[    9.013914] IMA: policy update failed
[    9.026344] systemd[1]: Failed to insert module 'ip_tables': Function not implemented
[    9.077543] random: systemd: uninitialized urandom read (16 bytes read)
[    9.085551] random: systemd: uninitialized urandom read (16 bytes read)
[    9.093253] random: systemd: uninitialized urandom read (16 bytes read)
[    9.105769] systemd[1]: systemd 233 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT -GNUTLS -ACL +XZ -LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD -IDN default-hierarchy=legacy)
[    9.129735] systemd[1]: Detected architecture x86-64.
[    9.135678] systemd[1]: Running in initial RAM disk.
[    9.142691] systemd[1]: No hostname configured.
[    9.148148] systemd[1]: Set hostname to <localhost>.
[    9.159362] random: systemd: uninitialized urandom read (16 bytes read)
[    9.167060] systemd[1]: Initializing machine ID from random generator.
[    9.176986] random: systemd: uninitialized urandom read (16 bytes read)
[    9.185559] random: systemd: uninitialized urandom read (16 bytes read)
[    9.186929] random: systemd-cryptse: uninitialized urandom read (16 bytes read)
[    9.204915] random: systemd: uninitialized urandom read (16 bytes read)
[    9.212628] random: systemd: uninitialized urandom read (16 bytes read)
[    9.220383] random: systemd: uninitialized urandom read (16 bytes read)
[    9.232472] systemd[1]: Reached target Swap.
[    9.238318] systemd[1]: Reached target Timers.
[    9.244365] systemd[1]: Listening on Journal Audit Socket.
[    9.251565] systemd[1]: Listening on Network Service Netlink Socket.
[    9.323048] device-mapper: uevent: version 1.0.3
[    9.328604] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    9.404389] tsc: Refined TSC clocksource calibration: 2599.997 MHz
[    9.411690] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x257a391c223, max_idle_ns: 440795220104 ns
[    9.465466] pps_core: LinuxPPS API ver. 1 registered
[    9.471338] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    9.482766] SCSI subsystem initialized
[    9.483034] PTP clock support registered
[    9.493990] ACPI: bus type USB registered
[    9.498810] usbcore: registered new interface driver usbfs
[    9.505276] usbcore: registered new interface driver hub
[    9.505430] usbcore: registered new device driver usb
[    9.517588] megasas: 06.812.07.00-rc1
[    9.518595] megaraid_sas 0000:03:00.0: FW now in Ready state
[    9.519120] megaraid_sas 0000:03:00.0: firmware supports msix        : (96)
[    9.519121] megaraid_sas 0000:03:00.0: current msix/online cpus      : (56/56)
[    9.519122] megaraid_sas 0000:03:00.0: RDPQ mode     : (disabled)
[    9.519124] megaraid_sas 0000:03:00.0: Current firmware maximum commands: 928         LDIO threshold: 0
[    9.520080] megaraid_sas 0000:03:00.0: FW supports sync cache        : No
[    9.540376] megaraid_sas 0000:03:00.0: Init cmd success
[    9.569336] megaraid_sas 0000:03:00.0: firmware type : Extended VD(240 VD)firmware
[    9.569338] megaraid_sas 0000:03:00.0: controller type       : MR(1024MB)
[    9.569339] megaraid_sas 0000:03:00.0: Online Controller Reset(OCR)  : Enabled
[    9.569340] megaraid_sas 0000:03:00.0: Secure JBOD support   : No
[    9.591748] megaraid_sas 0000:03:00.0: INIT adapter done
[    9.591750] megaraid_sas 0000:03:00.0: Jbod map is not supported megasas_setup_jbod_map 4947
[    9.596171] megaraid_sas 0000:03:00.0: pci id                : (0x1000)/(0x005d)/(0x1028)/(0x1f49)
[    9.596172] megaraid_sas 0000:03:00.0: unevenspan support    : yes
[    9.596173] megaraid_sas 0000:03:00.0: firmware crash dump   : no
[    9.596174] megaraid_sas 0000:03:00.0: jbod sync map         : no
[    9.596176] scsi host0: Avago SAS based MegaRAID driver
[    9.597365] scsi 0:0:0:0: Direct-Access     ATA      INTEL SSDSC2BX80 DL2B PQ: 0 ANSI: 6
[    9.668797] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    9.668905] tg3.c:v3.137 (May 11, 2014)
[    9.670106] mlx5_core 0000:83:00.0: firmware version: 12.16.1020
[    9.670670] ehci-pci: EHCI PCI platform driver
[    9.670918] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    9.670925] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    9.670951] ehci-pci 0000:00:1a.0: debug port 2
[    9.672954] AVX2 version of gcm_enc/dec engaged.
[    9.672954] AES CTR mode by8 optimization enabled
[    9.674882] ehci-pci 0000:00:1a.0: irq 18, io mem 0x91e03000
[    9.682437] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    9.682953] hub 1-0:1.0: USB hub found
[    9.682988] hub 1-0:1.0: 2 ports detected
[    9.683279] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    9.683282] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    9.683305] ehci-pci 0000:00:1d.0: debug port 2
[    9.687232] ehci-pci 0000:00:1d.0: irq 18, io mem 0x91e02000
[    9.688382] tg3 0000:01:00.0 eth0: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address 18:66:da:f0:43:18
[    9.688384] tg3 0000:01:00.0 eth0: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    9.688385] tg3 0000:01:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[    9.688386] tg3 0000:01:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[    9.694371] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    9.694529] hub 2-0:1.0: USB hub found
[    9.694531] hub 2-0:1.0: 2 ports detected
[    9.694886] ahci 0000:00:11.4: SSS flag set, parallel bus scan disabled
[    9.694938] ahci 0000:00:11.4: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0xf impl SATA mode
[    9.694939] ahci 0000:00:11.4: flags: 64bit ncq stag led clo pio slum part ems apst
[    9.701403] tg3 0000:01:00.1 eth1: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address 18:66:da:f0:43:19
[    9.701405] tg3 0000:01:00.1 eth1: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    9.701406] tg3 0000:01:00.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[    9.701407] tg3 0000:01:00.1 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
[    9.707624] scsi host1: ahci
[    9.707759] scsi host2: ahci
[    9.707881] scsi host3: ahci
[    9.708004] scsi host4: ahci
[    9.708030] ata1: SATA max UDMA/133 abar m2048@0x91e01000 port 0x91e01100 irq 99
[    9.708032] ata2: SATA max UDMA/133 abar m2048@0x91e01000 port 0x91e01180 irq 99
[    9.708035] ata3: SATA max UDMA/133 abar m2048@0x91e01000 port 0x91e01200 irq 99
[    9.708040] ata4: SATA max UDMA/133 abar m2048@0x91e01000 port 0x91e01280 irq 99
[    9.708215] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    9.708267] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    9.708269] ahci 0000:00:1f.2: flags: 64bit ncq stag led clo pio slum part ems apst
[    9.714583] tg3 0000:02:00.0 eth2: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address 18:66:da:f0:43:1a
[    9.714584] tg3 0000:02:00.0 eth2: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    9.714585] tg3 0000:02:00.0 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[    9.714586] tg3 0000:02:00.0 eth2: dma_rwctrl[00000001] dma_mask[64-bit]
[    9.726828] tg3 0000:02:00.1 eth3: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address 18:66:da:f0:43:1b
[    9.726830] tg3 0000:02:00.1 eth3: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    9.726831] tg3 0000:02:00.1 eth3: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[    9.726832] tg3 0000:02:00.1 eth3: dma_rwctrl[00000001] dma_mask[64-bit]
[    9.728747] scsi host5: ahci
[    9.728872] scsi host6: ahci
[    9.728994] scsi host7: ahci
[    9.729114] scsi host8: ahci
[    9.729208] scsi host9: ahci
[    9.729303] scsi host10: ahci
[    9.729335] ata5: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e00100 irq 101
[    9.729337] ata6: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e00180 irq 101
[    9.729339] ata7: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e00200 irq 101
[    9.729340] ata8: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e00280 irq 101
[    9.729342] ata9: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e00300 irq 101
[    9.729343] ata10: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e00380 irq 101
[    9.869701] IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
[    9.996358] usb 1-1: new high-speed USB device number 2 using ehci-pci
[   10.005389] usb 2-1: new high-speed USB device number 2 using ehci-pci
[   10.018104] ata1: SATA link down (SStatus 0 SControl 300)
[   10.034152] ata5: SATA link down (SStatus 0 SControl 300)
[   10.059547] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   10.114933] hub 1-1:1.0: USB hub found
[   10.115031] hub 1-1:1.0: 6 ports detected
[   10.123925] hub 2-1:1.0: USB hub found
[   10.124029] hub 2-1:1.0: 8 ports detected
[   10.183062] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   10.253834] mlx5_core 0000:83:00.0: Port module event: module 0, Cable plugged
[   10.274662] mlx5_core 0000:83:00.1: firmware version: 12.16.1020
[   10.306435] IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
[   10.379721] random: fast init done
[   10.390299] usb 1-1.6: new high-speed USB device number 3 using ehci-pci
[   10.429701] clocksource: Switched to clocksource tsc
[   10.439134] sd 0:0:0:0: [sda] 1562824368 512-byte logical blocks: (800 GB/745 GiB)
[   10.448148] sd 0:0:0:0: [sda] 4096-byte physical blocks
[   10.455123] sd 0:0:0:0: [sda] Write Protect is off
[   10.461507] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   10.477656] hub 1-1.6:1.0: USB hub found
[   10.478465]  sda: sda1 sda2 sda3 sda4 sda6 sda7 sda9
[   10.483787] sd 0:0:0:0: [sda] Attached SCSI disk
[   10.493891] hub 1-1.6:1.0: 6 ports detected
[   10.738085] ata2: SATA link down (SStatus 0 SControl 300)
[   10.856581] mlx5_core 0000:83:00.1: Port module event: module 1, Cable unplugged
[   10.875825] mlx5_core 0000:84:00.0: firmware version: 12.16.1020
[   11.058091] ata3: SATA link down (SStatus 0 SControl 300)
[   11.377938] ata4: SATA link down (SStatus 0 SControl 300)
[   11.469270] mlx5_core 0000:84:00.0: Port module event: module 0, Cable unplugged
[   11.489174] mlx5_core 0000:84:00.1: firmware version: 12.16.1020
[   11.690132] ata6: SATA link down (SStatus 0 SControl 300)
[   12.002048] ata7: SATA link down (SStatus 0 SControl 300)
[   12.081157] mlx5_core 0000:84:00.1: Port module event: module 1, Cable unplugged
[   12.314029] ata8: SATA link down (SStatus 0 SControl 300)
[   12.626080] ata9: SATA link down (SStatus 0 SControl 300)
[   12.938006] ata10: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   12.948896] ata10.00: ATAPI: PLDS DVD+/-RW DS-8ABSH, LD51, max UDMA/133
[   12.959770] ata10.00: configured for UDMA/133
[   12.973989] scsi 10:0:0:0: CD-ROM            PLDS     DVD+-RW DS-8ABSH LD51 PQ: 0 ANSI: 5
[   13.024815] sr 10:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[   13.035063] cdrom: Uniform CD-ROM driver Revision: 3.20
[   13.635363] tg3 0000:01:00.1 eth1: Link is up at 1000 Mbps, full duplex
[   13.643051] tg3 0000:01:00.1 eth1: Flow control is off for TX and off for RX
[   13.651240] tg3 0000:01:00.1 eth1: EEE is enabled
[   13.664030] tg3 0000:01:00.0 eth0: Link is up at 1000 Mbps, full duplex
[   13.671733] tg3 0000:01:00.0 eth0: Flow control is on for TX and on for RX
[   13.679707] tg3 0000:01:00.0 eth0: EEE is disabled
[   13.685361] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   13.692732] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   15.680544] loop: module loaded
[   15.707997] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   16.336988] systemd-journald[451]: Received SIGTERM from PID 1 (systemd).
[   16.348238] systemd: 21 output lines suppressed due to ratelimiting
[   16.423290] SELinux:  Permission validate_trans in class security not defined in policy.
[   16.432853] SELinux:  Permission module_load in class system not defined in policy.
[   16.441992] SELinux:  Class cap_userns not defined in policy.
[   16.448706] SELinux:  Class cap2_userns not defined in policy.
[   16.455515] SELinux: the above unknown classes and permissions will be allowed
[   16.476426] systemd[1]: Successfully loaded SELinux policy in 70.478ms.
[   16.484134] Unable to open file: /etc/ima/ima-policy (-2)
[   16.484138] IMA: policy update failed
[   16.501443] ip_tables: (C) 2000-2006 Netfilter Core Team
[   16.513069] systemd[1]: Relabelled /dev and /run in 4.975ms.
[   16.619659] mlx5_ib: Mellanox Connect-IB Infiniband driver v2.2-1 (Feb 2014)
[   16.656989] systemd-journald[1561]: Received request to flush runtime journal from PID 1
[   16.765261] random: crng init done
[   16.852945] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[   16.861743] ACPI: Power Button [PWRF]
[   16.905612] tg3 0000:02:00.0 eno3: renamed from eth2
[   16.935137] tg3 0000:02:00.1 eno4: renamed from eth3
[   16.943223] ipmi message handler version 39.2
[   16.943296] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[   16.945869] ipmi device interface
[   16.947033] mei_me 0000:00:16.0: Device doesn't have valid ME Interface
[   16.949218] IPMI System Interface driver.
[   16.949316] ipmi_si: probing via SMBIOS
[   16.949317] ipmi_si: SMBIOS: io 0xca8 regsize 1 spacing 4 irq 10
[   16.949318] ipmi_si: Adding SMBIOS-specified kcs state machine
[   16.949321] ipmi_si: Trying SMBIOS-specified kcs state machine at i/o address 0xca8, slave address 0x20, irq 10
[   16.959775] [drm] Initialized
[   17.005300] tg3 0000:01:00.1 eno2: renamed from eth1
[   17.051146] tg3 0000:01:00.0 eno1: renamed from eth0
[   17.058015] ipmi_si ipmi_si.0: The BMC does not support setting the recv irq bit, compensating, but the BMC needs to be fixed.
[   17.083536] EDAC MC: Ver: 3.0.0
[   17.091448] ipmi_si ipmi_si.0: Using irq 10
[   17.091775] EDAC MC0: Giving out device to module sbridge_edac.c controller Broadwell Socket#0: DEV 0000:7f:12.0 (INTERRUPT)
[   17.091985] EDAC MC1: Giving out device to module sbridge_edac.c controller Broadwell Socket#1: DEV 0000:ff:12.0 (INTERRUPT)
[   17.091986] EDAC sbridge:  Ver: 1.1.1
[   17.134954] [drm] radeon kernel modesetting enabled.
[   17.144289] AMD IOMMUv2 driver by Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
[   17.151299] AMD IOMMUv2 functionality not available on this system
[   17.170657] CRAT table not found
[   17.174569] Finished initializing topology ret=0
[   17.180111] kfd kfd: Initialized module
[   17.184961] radeon 0000:82:00.0: enabling device (0000 -> 0003)
[   17.186889] ipmi_si ipmi_si.0: Found new BMC (man_id: 0x0002a2, prod_id: 0x0100, dev_id: 0x20)
[   17.186943] ipmi_si ipmi_si.0: IPMI kcs interface initialized
[   17.209018] IPMI SSIF Interface driver
[   17.209107] [drm] initializing kernel modesetting (CAICOS 0x1002:0x6779 0x174B:0xA004 0x00).
[   17.209144] [drm] register mmio base: 0xD0000000
[   17.209144] [drm] register mmio size: 131072
[   18.172919] ATOM BIOS: R5
[   18.176214] [drm] GPU not posted. posting now...
[   18.184573] radeon 0000:82:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[   18.195021] radeon 0000:82:00.0: GTT: 1024M 0x0000000040000000 - 0x000000007FFFFFFF
[   18.204126] [drm] Detected VRAM RAM=1024M, BAR=256M
[   18.209899] [drm] RAM width 64bits DDR
[   18.214532] [TTM] Zone  kernel: Available graphics memory: 132062856 kiB
[   18.222343] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[   18.229981] [TTM] Initializing pool allocator
[   18.235174] [TTM] Initializing DMA pool allocator
[   18.240774] [drm] radeon: 1024M of VRAM memory ready
[   18.246636] [drm] radeon: 1024M of GTT memory ready.
[   18.252490] [drm] Loading CAICOS Microcode
[   18.259503] [drm] Internal thermal controller without fan control
[   18.270887] [drm] radeon: dpm initialized
[   18.277980] [drm] GART: num cpu pages 262144, num gpu pages 262144
[   18.286068] [drm] enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0
[   18.297657] [drm] PCIE GART of 1024M enabled (table at 0x0000000000162000).
[   18.305859] radeon 0000:82:00.0: WB enabled
[   18.310848] radeon 0000:82:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0xffff9c632a1c7c00
[   18.323533] radeon 0000:82:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0xffff9c632a1c7c0c
[   18.336888] radeon 0000:82:00.0: fence driver on ring 5 use gpu addr 0x0000000000072118 and cpu addr 0xffffb3c41b632118
[   18.349518] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   18.357211] [drm] Driver supports precise vblank timestamp query.
[   18.364334] radeon 0000:82:00.0: radeon: MSI limited to 32-bit
[   18.371192] radeon 0000:82:00.0: radeon: using MSI.
[   18.376995] [drm] radeon: irq initialized.
[   18.398573] [drm] ring test on 0 succeeded in 3 usecs
[   18.404527] [drm] ring test on 3 succeeded in 6 usecs
[   18.587729] [drm] ring test on 5 succeeded in 2 usecs
[   18.593680] [drm] UVD initialized successfully.
[   18.599212] [drm] ib test on ring 0 succeeded in 0 usecs
[   18.605536] [drm] ib test on ring 3 succeeded in 0 usecs
[   19.267971] [drm] ib test on ring 5 succeeded
[   19.273683] [drm] Radeon Display Connectors
[   19.278659] [drm] Connector 0:
[   19.282363] [drm]   HDMI-A-1
[   19.285863] [drm]   HPD2
[   19.288988] [drm]   DDC: 0x6440 0x6440 0x6444 0x6444 0x6448 0x6448 0x644c 0x644c
[   19.297775] [drm]   Encoders:
[   19.301418] [drm]     DFP1: INTERNAL_UNIPHY1
[   19.306491] [drm] Connector 1:
[   19.310200] [drm]   DVI-D-1
[   19.313618] [drm]   HPD4
[   19.316774] [drm]   DDC: 0x6460 0x6460 0x6464 0x6464 0x6468 0x6468 0x646c 0x646c
[   19.325566] [drm]   Encoders:
[   19.329175] [drm]     DFP2: INTERNAL_UNIPHY
[   19.334155] [drm] Connector 2:
[   19.337862] [drm]   VGA-1
[   19.341075] [drm]   DDC: 0x6430 0x6430 0x6434 0x6434 0x6438 0x6438 0x643c 0x643c
[   19.349862] [drm]   Encoders:
[   19.353468] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[   19.374252] [drm] Cannot find any crtc or sizes - going 1024x768
[   19.383251] [drm] fb mappable at 0x3FFF0363000
[   19.388517] [drm] vram apper at 0x3FFF0000000
[   19.393688] [drm] size 3145728
[   19.397391] [drm] fb depth is 24
[   19.401292] [drm]    pitch is 4096
[   19.412782] Console: switching to colour frame buffer device 128x48
[   19.421772] radeon 0000:82:00.0: fb0: radeondrmfb frame buffer device
[   19.431102] [drm] Initialized radeon 2.49.0 20080528 for 0000:82:00.0 on minor 0
[   19.874687] IPv6: ADDRCONF(NETDEV_UP): ib3: link is not ready
[   19.876200] IPv6: ADDRCONF(NETDEV_UP): ib2: link is not ready
[   19.877276] IPv6: ADDRCONF(NETDEV_UP): ib1: link is not ready
[   19.878130] IPv6: ADDRCONF(NETDEV_UP): ib0: link is not ready
[   20.002251] IPv6: ADDRCONF(NETDEV_UP): eno4: link is not ready
[   20.135749] IPv6: ADDRCONF(NETDEV_UP): eno3: link is not ready
[   20.267014] IPv6: ADDRCONF(NETDEV_UP): eno2: link is not ready
[   20.399747] IPv6: ADDRCONF(NETDEV_UP): eno1: link is not ready
[   23.331196] tg3 0000:01:00.1 eno2: Link is up at 1000 Mbps, full duplex
[   23.339189] tg3 0000:01:00.1 eno2: Flow control is off for TX and off for RX
[   23.347656] tg3 0000:01:00.1 eno2: EEE is enabled
[   23.353546] IPv6: ADDRCONF(NETDEV_CHANGE): eno2: link becomes ready
[   23.974993] tg3 0000:01:00.0 eno1: Link is up at 1000 Mbps, full duplex
[   23.982990] tg3 0000:01:00.0 eno1: Flow control is on for TX and on for RX
[   23.991275] tg3 0000:01:00.0 eno1: EEE is disabled
[   23.997233] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready

--nextPart1513726.M0Aj1V26Xq--

--nextPart2957866.hxjb1VdSQ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQG0BAABCAAGBQJY/w39AAoJENS5dBsVnRQdWegMviJlmpOaZO9K6R24vGE6yRoe
Cu0H59CD1Nd1/Q70Yn4Izx02tYqOMpg0K/Ue01Fcsn7YtcdReg8in6gtzbnsKDjt
7JjdaIu8UBp6YBCOaqT29H6vGN84RqG3TUpJDujPi9DbgQRDdPElSdRCUZVSGul2
UT2YGc2pOlqMwjsoYOdezBqErjNgdSNJgKgHUGe8lRmrsH4zCkvKlFMzpwu9buuY
8SpBv819RczxwesgnuGeFqVuycq8ck/6kFhpV5mlD+p2cXi9PVGjEBOWhX2a6NnP
RkVt7dSAGI0G3TG0c8KA99sICe19JLPSqE/X2W4N45jwUSAtuLEJJSMBg/xjMXVo
2M7TEiC5R6fs40NTOq56yvv6LHbDRz/ty25+Xw680GdcAGV32Mn78Dj88HLaGp9P
QWbyf/Wa3MQZ5gEqpOsC3gkeftcJk65v8AgJeBEvd1Wg9oLmjTq6EKkCwZ3jSD6J
SQuTELTpW/wCa0ao4rXEmBkIq4tGjzDTRE5+eKsMy1PF1dSG9GI6EEr4xgyY9O45
/SL+r4SjJA==
=qiRJ
-----END PGP SIGNATURE-----

--nextPart2957866.hxjb1VdSQ4--


--===============0039329088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0039329088==--
