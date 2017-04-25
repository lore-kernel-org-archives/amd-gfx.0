From: Dennis Schridde <dennis.schridde-axtXthT+lymYbFdUjOg7S7NAH6kLmebB@public.gmane.org>
Subject: Re: amdgpu 0000:84:00.0: gpu post error! \\ Fatal error during GPU
 init
Date: Tue, 25 Apr 2017 12:31:00 +0200
Message-ID: <1899542.UKOkCCEGMz@c07060>
References: <6570445.DKuzpyIqJk@c07060> <16054053.I0I8DtKEcm@c07060>
 <1616011.QrQCNzfxXf@c07060>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1899266092=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1616011.QrQCNzfxXf@c07060>
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

--===============1899266092==
Content-Type: multipart/signed; boundary="nextPart2842166.hcU9T0tpOo"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2842166.hcU9T0tpOo
Content-Type: multipart/mixed; boundary="nextPart4354749.MxMgfExfD9"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart4354749.MxMgfExfD9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 25. April 2017 10:51:09 CEST Dennis Schridde wrote:
> I replaced the AMD FirePro S7150X2 card with a AMD Radeon R5 230 (the only
> other AMD card we had available), to see whether the problem was caused by
> another hardware component of the system.
> 
> The kernel boots fine with this card. I see no errors in the log (attached).

The kernel used until now as a 4.10.9.

I tried again using 4.11.0_rc7, which shows the same behaviour.

--Dennis
--nextPart4354749.MxMgfExfD9
Content-Disposition: attachment; filename="node-amd-kernel-v4.11.0_rc7-firepro-s7150x2-oops.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="UTF-8"; name="node-amd-kernel-v4.11.0_rc7-firepro-s7150x2-oops.log"

[    0.000000] Linux version 4.11.0-rc7-coreos (tf128@c07060) (gcc version 4.9.4 (Gentoo Hardened 4.9.4 p1.0, pie-0.6.4) ) #1 SMP Fri Apr 21 22:23:28 CEST 2017
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
[    0.000000] RAMDISK: [mem 0x6ab76000-0x7a1eafff]
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
[    0.000000] percpu: Embedded 37 pages/cpu @ffffa0a83f600000 s112216 r8192 d31144 u262144
[    0.000000] Built 2 zonelists in Node order, mobility grouping on.  Total pages: 66036651
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: rootflags=rw mount.usrflags=ro coreos.config.url=http://192.168.10.27:8080/ignition?uuid=4c4c4544-004c-5610-804c-b8c04f574732&mac=18-66-da-f0-43-18 coreos.autologin coreos.first_boot console=ttyS0,115200n8 console=tty0
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 225280 bytes
[    0.000000] log_buf_len min size: 262144 bytes
[    0.000000] log_buf_len: 524288 bytes
[    0.000000] early log buf free: 235728(89%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Memory: 263771608K/268339504K available (6198K kernel code, 1268K rwdata, 2600K rodata, 31788K init, 736K bss, 4567896K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=56, Nodes=2
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU debugfs-based tracing is enabled.
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
[    0.001000] tsc: Detected 2599.783 MHz processor
[    0.002000] Calibrating delay loop (skipped), value calculated using timer frequency.. 5199.56 BogoMIPS (lpj=2599783)
[    0.003002] pid_max: default: 57344 minimum: 448
[    0.004023] ACPI: Core revision 20170119
[    0.076375] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.077058] Security Framework initialized
[    0.078002] SELinux:  Initializing.
[    0.087655] Dentry cache hash table entries: 33554432 (order: 16, 268435456 bytes)
[    0.132502] Inode-cache hash table entries: 16777216 (order: 15, 134217728 bytes)
[    0.153309] Mount-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.154148] Mountpoint-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.157265] CPU: Physical Processor ID: 0
[    0.158002] CPU: Processor Core ID: 0
[    0.159005] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.160001] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.161004] mce: CPU supports 22 MCE banks
[    0.162015] CPU0: Thermal monitoring enabled (TM1)
[    0.163020] process: using mwait in idle threads
[    0.164003] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.165001] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.167735] Freeing SMP alternatives memory: 24K
[    0.169004] ftrace: allocating 24354 entries in 96 pages
[    0.174082] smpboot: Max logical packages: 4
[    0.175017] DMAR: Host address width 46
[    0.176002] DMAR: DRHD base: 0x000000fbffc000 flags: 0x0
[    0.177005] DMAR: dmar0: reg_base_addr fbffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.178002] DMAR: DRHD base: 0x000000c7ffc000 flags: 0x1
[    0.179007] DMAR: dmar1: reg_base_addr c7ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.180002] DMAR: RMRR base: 0x0000007ae07000 end: 0x0000007af06fff
[    0.181002] DMAR: ATSR flags: 0x0
[    0.182002] DMAR: ATSR flags: 0x0
[    0.183003] DMAR-IR: IOAPIC id 10 under DRHD base  0xfbffc000 IOMMU 0
[    0.184002] DMAR-IR: IOAPIC id 8 under DRHD base  0xc7ffc000 IOMMU 1
[    0.185002] DMAR-IR: IOAPIC id 9 under DRHD base  0xc7ffc000 IOMMU 1
[    0.186001] DMAR-IR: HPET id 0 under DRHD base 0xc7ffc000
[    0.187002] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out bit.
[    0.187002] DMAR-IR: Use 'intremap=no_x2apic_optout' to override the BIOS setting.
[    0.190460] DMAR-IR: Enabled IRQ remapping in xapic mode
[    0.191000] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.191002] Switched APIC routing to physical flat.
[    0.192608] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.202872] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2690 v4 @ 2.60GHz (family: 0x6, model: 0x4f, stepping: 0x1)
[    0.203113] Performance Events: PEBS fmt2+, Broadwell events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.204002] ... version:                3
[    0.205000] ... bit width:              48
[    0.206000] ... generic registers:      4
[    0.207000] ... value mask:             0000ffffffffffff
[    0.208000] ... max period:             00007fffffffffff
[    0.209000] ... fixed-purpose events:   3
[    0.210000] ... event mask:             000000070000000f
[    0.213711] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.214011] smp: Bringing up secondary CPUs ...
[    0.215081] x86: Booting SMP configuration:
[    0.216001] .... node  #1, CPUs:        #1
[    0.279001] .... node  #0, CPUs:    #2
[    0.341001] .... node  #1, CPUs:    #3
[    0.403001] .... node  #0, CPUs:    #4
[    0.465001] .... node  #1, CPUs:    #5
[    0.527000] .... node  #0, CPUs:    #6
[    0.589001] .... node  #1, CPUs:    #7
[    0.651000] .... node  #0, CPUs:    #8
[    0.713001] .... node  #1, CPUs:    #9
[    0.775000] .... node  #0, CPUs:   #10
[    0.837001] .... node  #1, CPUs:   #11
[    0.899000] .... node  #0, CPUs:   #12
[    0.961001] .... node  #1, CPUs:   #13
[    1.023000] .... node  #0, CPUs:   #14
[    1.085001] .... node  #1, CPUs:   #15
[    1.147000] .... node  #0, CPUs:   #16
[    1.209001] .... node  #1, CPUs:   #17
[    1.271000] .... node  #0, CPUs:   #18
[    1.333001] .... node  #1, CPUs:   #19
[    1.395000] .... node  #0, CPUs:   #20
[    1.457001] .... node  #1, CPUs:   #21
[    1.519000] .... node  #0, CPUs:   #22
[    1.581001] .... node  #1, CPUs:   #23
[    1.643000] .... node  #0, CPUs:   #24
[    1.705001] .... node  #1, CPUs:   #25
[    1.767001] .... node  #0, CPUs:   #26
[    1.829001] .... node  #1, CPUs:   #27
[    1.891000] .... node  #0, CPUs:   #28
[    1.953001] .... node  #1, CPUs:   #29
[    2.015000] .... node  #0, CPUs:   #30
[    2.077001] .... node  #1, CPUs:   #31
[    2.139000] .... node  #0, CPUs:   #32
[    2.201001] .... node  #1, CPUs:   #33
[    2.263000] .... node  #0, CPUs:   #34
[    2.325001] .... node  #1, CPUs:   #35
[    2.387000] .... node  #0, CPUs:   #36
[    2.449001] .... node  #1, CPUs:   #37
[    2.511000] .... node  #0, CPUs:   #38
[    2.573001] .... node  #1, CPUs:   #39
[    2.635000] .... node  #0, CPUs:   #40
[    2.697001] .... node  #1, CPUs:   #41
[    2.759001] .... node  #0, CPUs:   #42
[    2.821001] .... node  #1, CPUs:   #43
[    2.883000] .... node  #0, CPUs:   #44
[    2.945001] .... node  #1, CPUs:   #45
[    3.007000] .... node  #0, CPUs:   #46
[    3.069001] .... node  #1, CPUs:   #47
[    3.131000] .... node  #0, CPUs:   #48
[    3.193001] .... node  #1, CPUs:   #49
[    3.255000] .... node  #0, CPUs:   #50
[    3.317001] .... node  #1, CPUs:   #51
[    3.379000] .... node  #0, CPUs:   #52
[    3.441001] .... node  #1, CPUs:   #53
[    3.503001] .... node  #0, CPUs:   #54
[    3.565001] .... node  #1, CPUs:   #55
[    3.626067] smp: Brought up 2 nodes, 56 CPUs
[    3.628001] smpboot: Total of 56 processors activated (291534.73 BogoMIPS)
[    3.631718] sched_clock: Marking stable (3631000000, 0)->(4318250913, -687250913)
[    3.646516] devtmpfs: initialized
[    3.650549] x86/mm: Memory block size: 2048MB
[    3.657392] PM: Registering ACPI NVS region [mem 0x7af0b000-0x7b93afff] (10682368 bytes)
[    3.667179] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    3.678721] futex hash table entries: 16384 (order: 8, 1048576 bytes)
[    3.686657] pinctrl core: initialized pinctrl subsystem
[    3.693450] NET: Registered protocol family 16
[    3.698825] cpuidle: using governor menu
[    3.703501] PCCT header not found.
[    3.707708] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    3.716685] ACPI: bus type PCI registered
[    3.721461] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    3.729021] dca service started, version 1.12.1
[    3.734394] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    3.750700] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
[    3.758584] PCI: Using configuration type 1 for base access
[    3.765108] PCI: Dell System detected, enabling pci=bfsort.
[    3.773670] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    3.781073] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    3.789216] ACPI: Added _OSI(Module Device)
[    3.794192] ACPI: Added _OSI(Processor Device)
[    3.799457] ACPI: Added _OSI(3.0 _SCP Extensions)
[    3.805013] ACPI: Added _OSI(Processor Aggregator Device)
[    3.908933] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    3.926895] ACPI: Interpreter enabled
[    3.931294] ACPI: (supports S0 S5)
[    3.935392] ACPI: Using IOAPIC for interrupt routing
[    3.941272] HEST: Table parsing has been initialized.
[    3.947218] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    3.967005] ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
[    3.973920] acpi PNP0A03:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    3.983644] acpi PNP0A03:02: PCIe AER handled by firmware
[    3.990068] acpi PNP0A03:02: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    3.999151] acpi PNP0A03:02: FADT indicates ASPM is unsupported, using BIOS configuration
[    4.008847] PCI host bridge to bus 0000:ff
[    4.013718] pci_bus 0000:ff: root bus resource [bus ff]
[    4.022265] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus 7f])
[    4.029181] acpi PNP0A03:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    4.038905] acpi PNP0A03:03: PCIe AER handled by firmware
[    4.045332] acpi PNP0A03:03: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    4.054407] acpi PNP0A03:03: FADT indicates ASPM is unsupported, using BIOS configuration
[    4.064102] PCI host bridge to bus 0000:7f
[    4.068976] pci_bus 0000:7f: root bus resource [bus 7f]
[    4.078803] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
[    4.086013] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    4.095733] acpi PNP0A08:00: PCIe AER handled by firmware
[    4.102168] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    4.111250] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    4.121053] PCI host bridge to bus 0000:00
[    4.125931] pci_bus 0000:00: root bus resource [io  0x0000-0x03bb window]
[    4.133818] pci_bus 0000:00: root bus resource [io  0x03bc-0x03df window]
[    4.141705] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    4.149591] pci_bus 0000:00: root bus resource [io  0x1000-0x7fff window]
[    4.157480] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    4.166368] pci_bus 0000:00: root bus resource [mem 0x90000000-0xc7ffbfff window]
[    4.175245] pci_bus 0000:00: root bus resource [mem 0x38000000000-0x3bfffffffff window]
[    4.184720] pci_bus 0000:00: root bus resource [bus 00-7e]
[    4.191393] pci 0000:00:01.0: System wakeup disabled by ACPI
[    4.198159] pci 0000:00:02.0: System wakeup disabled by ACPI
[    4.204914] pci 0000:00:03.0: System wakeup disabled by ACPI
[    4.211657] pci 0000:00:03.1: System wakeup disabled by ACPI
[    4.218416] pci 0000:00:03.2: System wakeup disabled by ACPI
[    4.226292] pci 0000:00:1c.0: Enabling MPC IRBNCE
[    4.231846] pci 0000:00:1c.0: Intel PCH root port ACS workaround enabled
[    4.239788] pci 0000:00:1c.7: Enabling MPC IRBNCE
[    4.245342] pci 0000:00:1c.7: Intel PCH root port ACS workaround enabled
[    4.253164] pci 0000:00:1c.7: System wakeup disabled by ACPI
[    4.260417] pci 0000:00:01.0: PCI bridge to [bus 03]
[    4.266296] pci 0000:00:02.0: PCI bridge to [bus 04]
[    4.276157] pci 0000:00:03.0: PCI bridge to [bus 02]
[    4.286021] pci 0000:00:03.1: PCI bridge to [bus 01]
[    4.291896] pci 0000:00:03.2: PCI bridge to [bus 05]
[    4.297772] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    4.310844] pci 0000:00:1c.7: PCI bridge to [bus 07-0b]
[    4.324715] pci 0000:07:00.0: PCI bridge to [bus 08-0b]
[    4.337376] pci 0000:08:00.0: PCI bridge to [bus 09-0a]
[    4.350542] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    4.357749] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 *15)
[    4.366380] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 *14 15)
[    4.375006] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    4.383634] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 9 10 11 12 14 15)
[    4.392265] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    4.402159] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    4.412048] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    4.421941] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    4.432055] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-fe])
[    4.439264] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    4.448983] acpi PNP0A08:01: PCIe AER handled by firmware
[    4.455409] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    4.464489] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using BIOS configuration
[    4.474340] PCI host bridge to bus 0000:80
[    4.479218] pci_bus 0000:80: root bus resource [io  0x8000-0xffff window]
[    4.487100] pci_bus 0000:80: root bus resource [mem 0xc8000000-0xfbffbfff window]
[    4.495999] pci_bus 0000:80: root bus resource [mem 0x3c000000000-0x3ffffffffff window]
[    4.505473] pci_bus 0000:80: root bus resource [bus 80-fe]
[    4.512014] pci 0000:80:01.0: System wakeup disabled by ACPI
[    4.518762] pci 0000:80:02.0: System wakeup disabled by ACPI
[    4.525505] pci 0000:80:03.0: System wakeup disabled by ACPI
[    4.532248] pci 0000:80:03.2: System wakeup disabled by ACPI
[    4.539220] pci 0000:80:01.0: PCI bridge to [bus 81]
[    4.545230] pci 0000:80:02.0: PCI bridge to [bus 82-85]
[    4.551668] pci 0000:82:00.0: PCI bridge to [bus 83-85]
[    4.557995] pci 0000:84:00.0: VF(n) BAR0 space: [mem 0x00000000-0xffffffff 64bit pref] (contains BAR0 for 16 VFs)
[    4.570000] pci 0000:84:00.0: VF(n) BAR2 space: [mem 0x00000000-0x03ffffff 64bit pref] (contains BAR2 for 16 VFs)
[    4.582005] pci 0000:84:00.0: VF(n) BAR5 space: [mem 0x00000000-0x03ffffff] (contains BAR5 for 16 VFs)
[    4.593018] pci 0000:83:08.0: PCI bridge to [bus 84]
[    4.598860] pci 0000:83:08.0: bridge has subordinate 84 but max busn 85
[    4.606733] pci 0000:85:00.0: VF(n) BAR0 space: [mem 0x00000000-0xffffffff 64bit pref] (contains BAR0 for 16 VFs)
[    4.618825] pci 0000:85:00.0: VF(n) BAR2 space: [mem 0x00000000-0x03ffffff 64bit pref] (contains BAR2 for 16 VFs)
[    4.630828] pci 0000:85:00.0: VF(n) BAR5 space: [mem 0x00000000-0x03ffffff] (contains BAR5 for 16 VFs)
[    4.641830] pci 0000:83:10.0: PCI bridge to [bus 85]
[    4.647685] pci 0000:83:10.0: bridge has subordinate 85 but max busn 86
[    4.657416] pci 0000:80:03.0: PCI bridge to [bus 86]
[    4.665296] pci 0000:80:03.2: PCI bridge to [bus 87]
[    4.671216] ACPI: Enabled 2 GPEs in block 00 to 3F
[    4.696011] pci 0000:0a:00.0: vgaarb: setting as boot VGA device
[    4.703022] pci 0000:0a:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    4.713074] pci 0000:84:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    4.722925] pci 0000:85:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    4.732778] pci 0000:85:00.0: vgaarb: bridge control possible
[    4.739494] pci 0000:84:00.0: vgaarb: bridge control possible
[    4.746210] pci 0000:0a:00.0: vgaarb: bridge control possible
[    4.752925] vgaarb: loaded
[    4.756281] PCI: Using ACPI for IRQ routing
[    4.767548] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    4.774745] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    4.783665] clocksource: Switched to clocksource hpet
[    4.797352] VFS: Disk quotas dquot_6.6.0
[    4.802068] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    4.810134] pnp: PnP ACPI init
[    4.814240] pnp 00:01: disabling [mem 0xfeda8000-0xfedcbfff] because it overlaps 0000:84:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    4.828666] pnp 00:01: disabling [mem 0xff000000-0xffffffff] because it overlaps 0000:84:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    4.843092] pnp 00:01: disabling [mem 0xfee00000-0xfeefffff] because it overlaps 0000:84:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    4.857518] pnp 00:01: disabling [mem 0xfed12000-0xfed1200f] because it overlaps 0000:84:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    4.871943] pnp 00:01: disabling [mem 0xfed12010-0xfed1201f] because it overlaps 0000:84:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    4.886366] pnp 00:01: disabling [mem 0xfed1b000-0xfed1bfff] because it overlaps 0000:84:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    4.900787] pnp 00:01: disabling [mem 0xfeda8000-0xfedcbfff disabled] because it overlaps 0000:85:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    4.916084] pnp 00:01: disabling [mem 0xff000000-0xffffffff disabled] because it overlaps 0000:85:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    4.931381] pnp 00:01: disabling [mem 0xfee00000-0xfeefffff disabled] because it overlaps 0000:85:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    4.946677] pnp 00:01: disabling [mem 0xfed12000-0xfed1200f disabled] because it overlaps 0000:85:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    4.961975] pnp 00:01: disabling [mem 0xfed12010-0xfed1201f disabled] because it overlaps 0000:85:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    4.977274] pnp 00:01: disabling [mem 0xfed1b000-0xfed1bfff disabled] because it overlaps 0000:85:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    4.992733] system 00:01: [io  0x0500-0x053f] has been reserved
[    4.999647] system 00:01: [io  0x0400-0x047f] has been reserved
[    5.006563] system 00:01: [io  0x0540-0x057f] has been reserved
[    5.013470] system 00:01: [io  0x0600-0x061f] has been reserved
[    5.020387] system 00:01: [io  0x0ca0-0x0ca5] has been reserved
[    5.032586] system 00:01: [io  0x0880-0x0883] has been reserved
[    5.039497] system 00:01: [io  0x0800-0x081f] has been reserved
[    5.046711] system 00:04: [io  0x0ca8] has been reserved
[    5.052946] system 00:04: [io  0x0cac] has been reserved
[    5.059250] pnp: PnP ACPI: found 5 devices
[    5.069700] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    5.080140] pci 0000:03:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    5.091743] pci 0000:02:00.0: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no compatible bridge window
[    5.103336] pci 0000:02:00.1: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no compatible bridge window
[    5.114937] pci 0000:01:00.0: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no compatible bridge window
[    5.126540] pci 0000:01:00.1: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no compatible bridge window
[    5.138146] pci 0000:84:00.0: can't claim BAR 6 [mem 0xfffe0000-0xffffffff pref]: no compatible bridge window
[    5.149745] pci 0000:85:00.0: can't claim BAR 6 [mem 0xfffe0000-0xffffffff pref]: no compatible bridge window
[    5.161346] pci 0000:86:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    5.172946] pci 0000:86:00.1: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    5.184544] pci 0000:87:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    5.196153] pci 0000:87:00.1: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    5.208542] pci 0000:00:03.0: BAR 14: assigned [mem 0x91f00000-0x91ffffff]
[    5.216523] pci 0000:00:03.1: BAR 14: assigned [mem 0x92000000-0x920fffff]
[    5.224505] pci 0000:03:00.0: BAR 6: no space for [mem size 0x00100000 pref]
[    5.232684] pci 0000:03:00.0: BAR 6: failed to assign [mem size 0x00100000 pref]
[    5.241471] pci 0000:00:01.0: PCI bridge to [bus 03]
[    5.247309] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    5.254414] pci 0000:00:01.0:   bridge window [mem 0x91c00000-0x91dfffff]
[    5.262301] pci 0000:00:02.0: PCI bridge to [bus 04]
[    5.268142] pci 0000:02:00.0: BAR 6: assigned [mem 0x91f00000-0x91f3ffff pref]
[    5.276731] pci 0000:02:00.1: BAR 6: assigned [mem 0x91f40000-0x91f7ffff pref]
[    5.285310] pci 0000:00:03.0: PCI bridge to [bus 02]
[    5.291151] pci 0000:00:03.0:   bridge window [mem 0x91f00000-0x91ffffff]
[    5.299030] pci 0000:00:03.0:   bridge window [mem 0x91a00000-0x91afffff 64bit pref]
[    5.308208] pci 0000:01:00.0: BAR 6: assigned [mem 0x92000000-0x9203ffff pref]
[    5.316799] pci 0000:01:00.1: BAR 6: assigned [mem 0x92040000-0x9207ffff pref]
[    5.325391] pci 0000:00:03.1: PCI bridge to [bus 01]
[    5.331237] pci 0000:00:03.1:   bridge window [mem 0x92000000-0x920fffff]
[    5.339120] pci 0000:00:03.1:   bridge window [mem 0x91b00000-0x91bfffff 64bit pref]
[    5.348292] pci 0000:00:03.2: PCI bridge to [bus 05]
[    5.354134] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    5.359985] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    5.365977] pci 0000:09:00.0:   bridge window [mem 0x91000000-0x918fffff]
[    5.373959] pci 0000:09:00.0:   bridge window [mem 0x90000000-0x90ffffff 64bit pref]
[    5.383336] pci 0000:08:00.0: PCI bridge to [bus 09-0a]
[    5.389623] pci 0000:08:00.0:   bridge window [mem 0x91000000-0x918fffff]
[    5.397604] pci 0000:08:00.0:   bridge window [mem 0x90000000-0x90ffffff 64bit pref]
[    5.406993] pci 0000:07:00.0: PCI bridge to [bus 08-0b]
[    5.413262] pci 0000:07:00.0:   bridge window [mem 0x91000000-0x919fffff]
[    5.421232] pci 0000:07:00.0:   bridge window [mem 0x90000000-0x90ffffff 64bit pref]
[    5.430627] pci 0000:00:1c.7: PCI bridge to [bus 07-0b]
[    5.436770] pci 0000:00:1c.7:   bridge window [mem 0x91000000-0x919fffff]
[    5.444654] pci 0000:00:1c.7:   bridge window [mem 0x90000000-0x90ffffff 64bit pref]
[    5.453916] pci 0000:80:03.0: BAR 14: assigned [mem 0xd0400000-0xd05fffff]
[    5.461898] pci 0000:80:03.2: BAR 14: assigned [mem 0xd0600000-0xd07fffff]
[    5.469875] pci 0000:80:01.0: PCI bridge to [bus 81]
[    5.475718] pci 0000:84:00.0: BAR 7: no space for [mem size 0x100000000 64bit pref]
[    5.484833] pci 0000:84:00.0: BAR 7: failed to assign [mem size 0x100000000 64bit pref]
[    5.494304] pci 0000:84:00.0: BAR 9: no space for [mem size 0x04000000 64bit pref]
[    5.503285] pci 0000:84:00.0: BAR 9: failed to assign [mem size 0x04000000 64bit pref]
[    5.512653] pci 0000:84:00.0: BAR 12: no space for [mem size 0x04000000]
[    5.520442] pci 0000:84:00.0: BAR 12: failed to assign [mem size 0x04000000]
[    5.528617] pci 0000:84:00.0: BAR 6: assigned [mem 0xd0140000-0xd015ffff pref]
[    5.537207] pci 0000:83:08.0: PCI bridge to [bus 84]
[    5.543045] pci 0000:83:08.0:   bridge window [io  0x9000-0x9fff]
[    5.550152] pci 0000:83:08.0:   bridge window [mem 0xd0100000-0xd01fffff]
[    5.558037] pci 0000:83:08.0:   bridge window [mem 0x3ffe0000000-0x3fff01fffff 64bit pref]
[    5.567792] pci 0000:85:00.0: BAR 7: no space for [mem size 0x100000000 64bit pref]
[    5.576862] pci 0000:85:00.0: BAR 7: failed to assign [mem size 0x100000000 64bit pref]
[    5.586331] pci 0000:85:00.0: BAR 9: no space for [mem size 0x04000000 64bit pref]
[    5.595310] pci 0000:85:00.0: BAR 9: failed to assign [mem size 0x04000000 64bit pref]
[    5.604672] pci 0000:85:00.0: BAR 12: no space for [mem size 0x04000000]
[    5.612453] pci 0000:85:00.0: BAR 12: failed to assign [mem size 0x04000000]
[    5.620629] pci 0000:85:00.0: BAR 6: assigned [mem 0xd0040000-0xd005ffff pref]
[    5.629218] pci 0000:83:10.0: PCI bridge to [bus 85]
[    5.635061] pci 0000:83:10.0:   bridge window [io  0x8000-0x8fff]
[    5.642171] pci 0000:83:10.0:   bridge window [mem 0xd0000000-0xd00fffff]
[    5.650057] pci 0000:83:10.0:   bridge window [mem 0x3ffc0000000-0x3ffd01fffff 64bit pref]
[    5.659814] pci 0000:82:00.0: PCI bridge to [bus 83-85]
[    5.665951] pci 0000:82:00.0:   bridge window [io  0x8000-0x9fff]
[    5.673059] pci 0000:82:00.0:   bridge window [mem 0xd0000000-0xd01fffff]
[    5.680943] pci 0000:82:00.0:   bridge window [mem 0x3ffc0000000-0x3fff01fffff 64bit pref]
[    5.690702] pci 0000:80:02.0: PCI bridge to [bus 82-85]
[    5.696838] pci 0000:80:02.0:   bridge window [io  0x8000-0x9fff]
[    5.703946] pci 0000:80:02.0:   bridge window [mem 0xd0000000-0xd02fffff]
[    5.711827] pci 0000:80:02.0:   bridge window [mem 0x3ffc0000000-0x3fff01fffff 64bit pref]
[    5.721584] pci 0000:86:00.0: BAR 6: assigned [mem 0xd0400000-0xd04fffff pref]
[    5.730179] pci 0000:86:00.1: BAR 6: assigned [mem 0xd0500000-0xd05fffff pref]
[    5.738771] pci 0000:80:03.0: PCI bridge to [bus 86]
[    5.744616] pci 0000:80:03.0:   bridge window [mem 0xd0400000-0xd05fffff]
[    5.752500] pci 0000:80:03.0:   bridge window [mem 0xc8000000-0xcbffffff 64bit pref]
[    5.761677] pci 0000:87:00.0: BAR 6: assigned [mem 0xd0600000-0xd06fffff pref]
[    5.770266] pci 0000:87:00.1: BAR 6: assigned [mem 0xd0700000-0xd07fffff pref]
[    5.778855] pci 0000:80:03.2: PCI bridge to [bus 87]
[    5.784698] pci 0000:80:03.2:   bridge window [mem 0xd0600000-0xd07fffff]
[    5.792585] pci 0000:80:03.2:   bridge window [mem 0xcc000000-0xcfffffff 64bit pref]
[    5.801760] pci_bus 0000:80: Some PCI device resources are unassigned, try booting with pci=realloc
[    5.812482] NET: Registered protocol family 2
[    5.818092] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[    5.827642] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    5.835581] TCP: Hash tables configured (established 524288 bind 65536)
[    5.843418] UDP hash table entries: 65536 (order: 9, 2097152 bytes)
[    5.851064] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes)
[    5.859314] NET: Registered protocol family 1
[    5.878907] pci 0000:03:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
[    5.891535] pci 0000:0a:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    6.255914] Unpacking initramfs...
[    6.746403] Freeing initrd memory: 252372K
[    6.765984] DMAR: dmar0: Using Queued invalidation
[    6.771650] DMAR: dmar1: Using Queued invalidation
[    6.777329] DMAR: Setting RMRR:
[    6.781566] DMAR: Setting identity map for device 0000:00:1a.0 [0x7ae07000 - 0x7af06fff]
[    6.791573] DMAR: Setting identity map for device 0000:00:1d.0 [0x7ae07000 - 0x7af06fff]
[    6.801140] DMAR: Prepare 0-16MiB unity mapping for LPC
[    6.807739] DMAR: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]
[    6.816439] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    6.824028] iommu: Adding device 0000:00:00.0 to group 0
[    6.830284] iommu: Adding device 0000:00:01.0 to group 1
[    6.836542] iommu: Adding device 0000:00:02.0 to group 2
[    6.842807] iommu: Adding device 0000:00:03.0 to group 3
[    6.849059] iommu: Adding device 0000:00:03.1 to group 4
[    6.855315] iommu: Adding device 0000:00:03.2 to group 5
[    6.861647] iommu: Adding device 0000:00:05.0 to group 6
[    6.867900] iommu: Adding device 0000:00:05.1 to group 6
[    6.874155] iommu: Adding device 0000:00:05.2 to group 6
[    6.880408] iommu: Adding device 0000:00:05.4 to group 6
[    6.886700] iommu: Adding device 0000:00:11.0 to group 7
[    6.892952] iommu: Adding device 0000:00:11.4 to group 7
[    6.899245] iommu: Adding device 0000:00:16.0 to group 8
[    6.905593] iommu: Adding device 0000:00:16.1 to group 8
[    6.911847] iommu: Adding device 0000:00:1a.0 to group 9
[    6.918102] iommu: Adding device 0000:00:1c.0 to group 10
[    6.924457] iommu: Adding device 0000:00:1c.7 to group 11
[    6.930809] iommu: Adding device 0000:00:1d.0 to group 12
[    6.942504] iommu: Adding device 0000:00:1f.0 to group 13
[    6.948851] iommu: Adding device 0000:00:1f.2 to group 13
[    6.955249] iommu: Adding device 0000:01:00.0 to group 14
[    6.961608] iommu: Adding device 0000:01:00.1 to group 14
[    6.968012] iommu: Adding device 0000:02:00.0 to group 15
[    6.974370] iommu: Adding device 0000:02:00.1 to group 15
[    6.980723] iommu: Adding device 0000:03:00.0 to group 16
[    6.987081] iommu: Adding device 0000:07:00.0 to group 17
[    6.993431] iommu: Adding device 0000:08:00.0 to group 18
[    6.999801] iommu: Adding device 0000:09:00.0 to group 18
[    7.006132] iommu: Adding device 0000:0a:00.0 to group 18
[    7.012530] iommu: Adding device 0000:7f:08.0 to group 19
[    7.018886] iommu: Adding device 0000:7f:08.2 to group 19
[    7.025243] iommu: Adding device 0000:7f:08.3 to group 19
[    7.031651] iommu: Adding device 0000:7f:09.0 to group 20
[    7.038004] iommu: Adding device 0000:7f:09.2 to group 20
[    7.044360] iommu: Adding device 0000:7f:09.3 to group 20
[    7.050791] iommu: Adding device 0000:7f:0b.0 to group 21
[    7.057146] iommu: Adding device 0000:7f:0b.1 to group 21
[    7.063498] iommu: Adding device 0000:7f:0b.2 to group 21
[    7.069857] iommu: Adding device 0000:7f:0b.3 to group 21
[    7.076356] iommu: Adding device 0000:7f:0c.0 to group 22
[    7.082710] iommu: Adding device 0000:7f:0c.1 to group 22
[    7.089065] iommu: Adding device 0000:7f:0c.2 to group 22
[    7.095430] iommu: Adding device 0000:7f:0c.3 to group 22
[    7.101784] iommu: Adding device 0000:7f:0c.4 to group 22
[    7.108140] iommu: Adding device 0000:7f:0c.5 to group 22
[    7.114495] iommu: Adding device 0000:7f:0c.6 to group 22
[    7.120860] iommu: Adding device 0000:7f:0c.7 to group 22
[    7.127326] iommu: Adding device 0000:7f:0d.0 to group 23
[    7.133704] iommu: Adding device 0000:7f:0d.1 to group 23
[    7.140061] iommu: Adding device 0000:7f:0d.2 to group 23
[    7.146415] iommu: Adding device 0000:7f:0d.3 to group 23
[    7.152770] iommu: Adding device 0000:7f:0d.4 to group 23
[    7.159126] iommu: Adding device 0000:7f:0d.5 to group 23
[    7.165609] iommu: Adding device 0000:7f:0f.0 to group 24
[    7.171962] iommu: Adding device 0000:7f:0f.1 to group 24
[    7.178318] iommu: Adding device 0000:7f:0f.2 to group 24
[    7.184676] iommu: Adding device 0000:7f:0f.3 to group 24
[    7.191035] iommu: Adding device 0000:7f:0f.4 to group 24
[    7.197386] iommu: Adding device 0000:7f:0f.5 to group 24
[    7.203742] iommu: Adding device 0000:7f:0f.6 to group 24
[    7.210185] iommu: Adding device 0000:7f:10.0 to group 25
[    7.216544] iommu: Adding device 0000:7f:10.1 to group 25
[    7.222906] iommu: Adding device 0000:7f:10.5 to group 25
[    7.229266] iommu: Adding device 0000:7f:10.6 to group 25
[    7.235621] iommu: Adding device 0000:7f:10.7 to group 25
[    7.242092] iommu: Adding device 0000:7f:12.0 to group 26
[    7.248444] iommu: Adding device 0000:7f:12.1 to group 26
[    7.254803] iommu: Adding device 0000:7f:12.2 to group 26
[    7.261157] iommu: Adding device 0000:7f:12.4 to group 26
[    7.267508] iommu: Adding device 0000:7f:12.5 to group 26
[    7.273857] iommu: Adding device 0000:7f:12.6 to group 26
[    7.280327] iommu: Adding device 0000:7f:13.0 to group 27
[    7.286685] iommu: Adding device 0000:7f:13.1 to group 27
[    7.293043] iommu: Adding device 0000:7f:13.2 to group 27
[    7.299394] iommu: Adding device 0000:7f:13.3 to group 27
[    7.305750] iommu: Adding device 0000:7f:13.6 to group 27
[    7.312113] iommu: Adding device 0000:7f:13.7 to group 27
[    7.318612] iommu: Adding device 0000:7f:14.0 to group 28
[    7.324969] iommu: Adding device 0000:7f:14.1 to group 28
[    7.331328] iommu: Adding device 0000:7f:14.2 to group 28
[    7.337686] iommu: Adding device 0000:7f:14.3 to group 28
[    7.344044] iommu: Adding device 0000:7f:14.4 to group 28
[    7.350404] iommu: Adding device 0000:7f:14.5 to group 28
[    7.356762] iommu: Adding device 0000:7f:14.6 to group 28
[    7.363126] iommu: Adding device 0000:7f:14.7 to group 28
[    7.369597] iommu: Adding device 0000:7f:16.0 to group 29
[    7.375952] iommu: Adding device 0000:7f:16.1 to group 29
[    7.382315] iommu: Adding device 0000:7f:16.2 to group 29
[    7.388674] iommu: Adding device 0000:7f:16.3 to group 29
[    7.395036] iommu: Adding device 0000:7f:16.6 to group 29
[    7.401396] iommu: Adding device 0000:7f:16.7 to group 29
[    7.407907] iommu: Adding device 0000:7f:17.0 to group 30
[    7.414267] iommu: Adding device 0000:7f:17.1 to group 30
[    7.420629] iommu: Adding device 0000:7f:17.2 to group 30
[    7.426994] iommu: Adding device 0000:7f:17.3 to group 30
[    7.433352] iommu: Adding device 0000:7f:17.4 to group 30
[    7.439714] iommu: Adding device 0000:7f:17.5 to group 30
[    7.446076] iommu: Adding device 0000:7f:17.6 to group 30
[    7.452437] iommu: Adding device 0000:7f:17.7 to group 30
[    7.458888] iommu: Adding device 0000:7f:1e.0 to group 31
[    7.465244] iommu: Adding device 0000:7f:1e.1 to group 31
[    7.471606] iommu: Adding device 0000:7f:1e.2 to group 31
[    7.477966] iommu: Adding device 0000:7f:1e.3 to group 31
[    7.484330] iommu: Adding device 0000:7f:1e.4 to group 31
[    7.490718] iommu: Adding device 0000:7f:1f.0 to group 32
[    7.497078] iommu: Adding device 0000:7f:1f.2 to group 32
[    7.503426] iommu: Adding device 0000:80:01.0 to group 33
[    7.509783] iommu: Adding device 0000:80:02.0 to group 34
[    7.516142] iommu: Adding device 0000:80:03.0 to group 35
[    7.522497] iommu: Adding device 0000:80:03.2 to group 36
[    7.528930] iommu: Adding device 0000:80:05.0 to group 37
[    7.535292] iommu: Adding device 0000:80:05.1 to group 37
[    7.541653] iommu: Adding device 0000:80:05.2 to group 37
[    7.548015] iommu: Adding device 0000:80:05.4 to group 37
[    7.554375] iommu: Adding device 0000:82:00.0 to group 38
[    7.560819] iommu: Adding device 0000:83:08.0 to group 39
[    7.567167] iommu: Adding device 0000:83:10.0 to group 40
[    7.573525] iommu: Adding device 0000:84:00.0 to group 41
[    7.579887] iommu: Adding device 0000:85:00.0 to group 42
[    7.586304] iommu: Adding device 0000:86:00.0 to group 43
[    7.592700] iommu: Adding device 0000:86:00.1 to group 43
[    7.599120] iommu: Adding device 0000:87:00.0 to group 44
[    7.605508] iommu: Adding device 0000:87:00.1 to group 44
[    7.611925] iommu: Adding device 0000:ff:08.0 to group 45
[    7.618283] iommu: Adding device 0000:ff:08.2 to group 45
[    7.624644] iommu: Adding device 0000:ff:08.3 to group 45
[    7.631055] iommu: Adding device 0000:ff:09.0 to group 46
[    7.637418] iommu: Adding device 0000:ff:09.2 to group 46
[    7.643780] iommu: Adding device 0000:ff:09.3 to group 46
[    7.650214] iommu: Adding device 0000:ff:0b.0 to group 47
[    7.656580] iommu: Adding device 0000:ff:0b.1 to group 47
[    7.662948] iommu: Adding device 0000:ff:0b.2 to group 47
[    7.669312] iommu: Adding device 0000:ff:0b.3 to group 47
[    7.675812] iommu: Adding device 0000:ff:0c.0 to group 48
[    7.682175] iommu: Adding device 0000:ff:0c.1 to group 48
[    7.688534] iommu: Adding device 0000:ff:0c.2 to group 48
[    7.694901] iommu: Adding device 0000:ff:0c.3 to group 48
[    7.701264] iommu: Adding device 0000:ff:0c.4 to group 48
[    7.707627] iommu: Adding device 0000:ff:0c.5 to group 48
[    7.714002] iommu: Adding device 0000:ff:0c.6 to group 48
[    7.720364] iommu: Adding device 0000:ff:0c.7 to group 48
[    7.726833] iommu: Adding device 0000:ff:0d.0 to group 49
[    7.733196] iommu: Adding device 0000:ff:0d.1 to group 49
[    7.739564] iommu: Adding device 0000:ff:0d.2 to group 49
[    7.745951] iommu: Adding device 0000:ff:0d.3 to group 49
[    7.752315] iommu: Adding device 0000:ff:0d.4 to group 49
[    7.758678] iommu: Adding device 0000:ff:0d.5 to group 49
[    7.765160] iommu: Adding device 0000:ff:0f.0 to group 50
[    7.771524] iommu: Adding device 0000:ff:0f.1 to group 50
[    7.777885] iommu: Adding device 0000:ff:0f.2 to group 50
[    7.784249] iommu: Adding device 0000:ff:0f.3 to group 50
[    7.790617] iommu: Adding device 0000:ff:0f.4 to group 50
[    7.796986] iommu: Adding device 0000:ff:0f.5 to group 50
[    7.803345] iommu: Adding device 0000:ff:0f.6 to group 50
[    7.809789] iommu: Adding device 0000:ff:10.0 to group 51
[    7.816153] iommu: Adding device 0000:ff:10.1 to group 51
[    7.822518] iommu: Adding device 0000:ff:10.5 to group 51
[    7.828884] iommu: Adding device 0000:ff:10.6 to group 51
[    7.835248] iommu: Adding device 0000:ff:10.7 to group 51
[    7.841711] iommu: Adding device 0000:ff:12.0 to group 52
[    7.848074] iommu: Adding device 0000:ff:12.1 to group 52
[    7.854442] iommu: Adding device 0000:ff:12.2 to group 52
[    7.860803] iommu: Adding device 0000:ff:12.4 to group 52
[    7.867184] iommu: Adding device 0000:ff:12.5 to group 52
[    7.873544] iommu: Adding device 0000:ff:12.6 to group 52
[    7.880009] iommu: Adding device 0000:ff:13.0 to group 53
[    7.886377] iommu: Adding device 0000:ff:13.1 to group 53
[    7.892734] iommu: Adding device 0000:ff:13.2 to group 53
[    7.899103] iommu: Adding device 0000:ff:13.3 to group 53
[    7.905473] iommu: Adding device 0000:ff:13.6 to group 53
[    7.911843] iommu: Adding device 0000:ff:13.7 to group 53
[    7.918348] iommu: Adding device 0000:ff:14.0 to group 54
[    7.924718] iommu: Adding device 0000:ff:14.1 to group 54
[    7.931079] iommu: Adding device 0000:ff:14.2 to group 54
[    7.937436] iommu: Adding device 0000:ff:14.3 to group 54
[    7.943803] iommu: Adding device 0000:ff:14.4 to group 54
[    7.950171] iommu: Adding device 0000:ff:14.5 to group 54
[    7.956542] iommu: Adding device 0000:ff:14.6 to group 54
[    7.962916] iommu: Adding device 0000:ff:14.7 to group 54
[    7.969382] iommu: Adding device 0000:ff:16.0 to group 55
[    7.975746] iommu: Adding device 0000:ff:16.1 to group 55
[    7.982119] iommu: Adding device 0000:ff:16.2 to group 55
[    7.988484] iommu: Adding device 0000:ff:16.3 to group 55
[    7.994853] iommu: Adding device 0000:ff:16.6 to group 55
[    8.001224] iommu: Adding device 0000:ff:16.7 to group 55
[    8.007729] iommu: Adding device 0000:ff:17.0 to group 56
[    8.014101] iommu: Adding device 0000:ff:17.1 to group 56
[    8.020473] iommu: Adding device 0000:ff:17.2 to group 56
[    8.026841] iommu: Adding device 0000:ff:17.3 to group 56
[    8.033210] iommu: Adding device 0000:ff:17.4 to group 56
[    8.039587] iommu: Adding device 0000:ff:17.5 to group 56
[    8.045956] iommu: Adding device 0000:ff:17.6 to group 56
[    8.052326] iommu: Adding device 0000:ff:17.7 to group 56
[    8.058768] iommu: Adding device 0000:ff:1e.0 to group 57
[    8.065137] iommu: Adding device 0000:ff:1e.1 to group 57
[    8.071506] iommu: Adding device 0000:ff:1e.2 to group 57
[    8.077875] iommu: Adding device 0000:ff:1e.3 to group 57
[    8.084241] iommu: Adding device 0000:ff:1e.4 to group 57
[    8.095921] iommu: Adding device 0000:ff:1f.0 to group 58
[    8.102285] iommu: Adding device 0000:ff:1f.2 to group 58
[    8.109484] Intel CQM monitoring enabled
[    8.114246] Intel MBM enabled
[    8.119058] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    8.128444] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    8.135170] RAPL PMU: hw unit of domain package 2^-14 Joules
[    8.141797] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    8.148135] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    8.158128] audit: initializing netlink subsys (disabled)
[    8.164522] audit: type=2000 audit(1493115870.021:1): state=initialized audit_enabled=0 res=1
[    8.165017] Initialise system trusted keyrings
[    8.165098] workingset: timestamp_bits=39 max_order=26 bucket_order=0
[    8.423617] Key type asymmetric registered
[    8.428492] Asymmetric key parser 'x509' registered
[    8.434258] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    8.443158] io scheduler noop registered
[    8.447844] io scheduler deadline registered
[    8.452939] io scheduler cfq registered (default)
[    8.458496] io scheduler mq-deadline registered
[    8.468508] pcieport 0000:00:01.0: Signaling PME with IRQ 26
[    8.475139] pcieport 0000:00:02.0: Signaling PME with IRQ 27
[    8.481779] pcieport 0000:00:03.0: Signaling PME with IRQ 28
[    8.488408] pcieport 0000:00:03.1: Signaling PME with IRQ 29
[    8.495043] pcieport 0000:00:03.2: Signaling PME with IRQ 30
[    8.501676] pcieport 0000:00:1c.0: Signaling PME with IRQ 31
[    8.508319] pcieport 0000:00:1c.7: Signaling PME with IRQ 32
[    8.515051] pcieport 0000:80:01.0: Signaling PME with IRQ 33
[    8.521693] pcieport 0000:80:02.0: Signaling PME with IRQ 34
[    8.528326] pcieport 0000:80:03.0: Signaling PME with IRQ 35
[    8.534965] pcieport 0000:80:03.2: Signaling PME with IRQ 36
[    8.544207] ERST: Error Record Serialization Table (ERST) support is initialized.
[    8.553103] pstore: using zlib compression
[    8.557982] pstore: Registered erst as persistent store backend
[    8.565278] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
[    8.574214] ioatdma: Intel(R) QuickData Technology Driver 4.00
[    8.581129] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    8.608979] 00:02: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    8.638262] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    8.650170] i8042: PNP: No PS/2 controller found.
[    8.655774] rtc_cmos 00:00: RTC can wake from S4
[    8.661379] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    8.668516] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    8.677604] intel_pstate: Intel P-state driver initializing
[    8.686672] NET: Registered protocol family 10
[    8.692350] Segment Routing with IPv6
[    8.696773] NET: Registered protocol family 17
[    8.702046] Key type dns_resolver registered
[    8.712132] microcode: sig=0x406f1, pf=0x1, revision=0xb00001e
[    8.720700] microcode: Microcode Update Driver: v2.2.
[    8.720806] registered taskstats version 1
[    8.731669] Loading compiled-in X.509 certificates
[    8.738825] alg: No test for pkcs1pad(rsa,sha256) (pkcs1pad(rsa-generic,sha256))
[    8.748231] Loaded X.509 cert 'CoreOS, Inc: Module signing key for 4.11.0-rc7-coreos: ea21eedf6d987ed1164de89c738ac1f7e1a2dba9'
[    8.761611] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
[    8.771305] rtc_cmos 00:00: setting system clock to 2017-04-25 10:24:34 UTC (1493115874)
[    8.788243] Freeing unused kernel memory: 31788K
[    8.793702] Write protecting the kernel read-only data: 12288k
[    8.801258] Freeing unused kernel memory: 1980K
[    8.809264] Freeing unused kernel memory: 1496K
[    8.817083] Unable to open file: /etc/ima/ima-policy (-2)
[    8.817087] IMA: policy update failed
[    8.827842] audit: type=1802 audit(1493115874.555:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel op="policy_update" cause="failed" comm="systemd" res=0
[    8.846563] systemd[1]: Failed to insert module 'ip_tables': Function not implemented
[    8.897667] random: systemd: uninitialized urandom read (16 bytes read)
[    8.905682] random: systemd: uninitialized urandom read (16 bytes read)
[    8.913381] random: systemd: uninitialized urandom read (16 bytes read)
[    8.926477] systemd[1]: systemd 233 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT -GNUTLS -ACL +XZ -LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD -IDN default-hierarchy=legacy)
[    8.950409] systemd[1]: Detected architecture x86-64.
[    8.956347] systemd[1]: Running in initial RAM disk.
[    8.963340] systemd[1]: No hostname configured.
[    8.968703] systemd[1]: Set hostname to <localhost>.
[    8.974586] random: systemd: uninitialized urandom read (16 bytes read)
[    8.982279] systemd[1]: Initializing machine ID from random generator.
[    8.992460] random: systemd: uninitialized urandom read (16 bytes read)
[    9.001121] random: systemd: uninitialized urandom read (16 bytes read)
[    9.002310] random: systemd-cryptse: uninitialized urandom read (16 bytes read)
[    9.020674] random: systemd: uninitialized urandom read (16 bytes read)
[    9.028465] random: systemd: uninitialized urandom read (16 bytes read)
[    9.036182] random: systemd: uninitialized urandom read (16 bytes read)
[    9.049035] systemd[1]: Listening on Journal Socket (/dev/log).
[    9.057092] systemd[1]: Created slice System Slice.
[    9.063685] systemd[1]: Listening on udev Control Socket.
[    9.070853] systemd[1]: Listening on udev Kernel Socket.
[    9.090883] audit: type=1130 audit(1493115874.817:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=kmod-static-nodes comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    9.114927] audit: type=1130 audit(1493115874.841:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    9.139794] audit: type=1130 audit(1493115874.866:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    9.164853] audit: type=1130 audit(1493115874.891:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    9.190994] audit: type=1130 audit(1493115874.917:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    9.198042] tsc: Refined TSC clocksource calibration: 2599.995 MHz
[    9.198060] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x257a376535a, max_idle_ns: 440795296166 ns
[    9.234213] device-mapper: uevent: version 1.0.3
[    9.234275] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    9.265846] audit: type=1130 audit(1493115874.992:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    9.293423] audit: type=1130 audit(1493115875.020:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udevd comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    9.325398] audit: type=1130 audit(1493115875.052:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-networkd comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    9.421599] pps_core: LinuxPPS API ver. 1 registered
[    9.421599] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    9.438739] PTP clock support registered
[    9.444427] ACPI: bus type USB registered
[    9.444440] usbcore: registered new interface driver usbfs
[    9.444460] usbcore: registered new interface driver hub
[    9.444639] usbcore: registered new device driver usb
[    9.468371] SCSI subsystem initialized
[    9.474854] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    9.483658] mlx5_core 0000:86:00.0: firmware version: 12.16.1020
[    9.491692] megasas: 07.701.17.00-rc1
[    9.492436] ehci-pci: EHCI PCI platform driver
[    9.492806] tg3.c:v3.137 (May 11, 2014)
[    9.492968] megaraid_sas 0000:03:00.0: FW now in Ready state
[    9.493397] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    9.493405] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    9.493433] ehci-pci 0000:00:1a.0: debug port 2
[    9.493763] megaraid_sas 0000:03:00.0: firmware supports msix        : (96)
[    9.493764] megaraid_sas 0000:03:00.0: current msix/online cpus      : (56/56)
[    9.493765] megaraid_sas 0000:03:00.0: RDPQ mode     : (disabled)
[    9.493768] megaraid_sas 0000:03:00.0: Current firmware maximum commands: 928         LDIO threshold: 0
[    9.495393] AVX2 version of gcm_enc/dec engaged.
[    9.495394] AES CTR mode by8 optimization enabled
[    9.497306] megaraid_sas 0000:03:00.0: FW supports sync cache        : No
[    9.497361] ehci-pci 0000:00:1a.0: irq 18, io mem 0x91e03000
[    9.504057] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    9.504298] hub 1-0:1.0: USB hub found
[    9.504304] hub 1-0:1.0: 2 ports detected
[    9.504653] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    9.504659] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    9.504682] ehci-pci 0000:00:1d.0: debug port 2
[    9.507182] tg3 0000:01:00.0 eth0: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address 18:66:da:f0:43:18
[    9.507183] tg3 0000:01:00.0 eth0: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    9.507184] tg3 0000:01:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[    9.507185] tg3 0000:01:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[    9.508615] ehci-pci 0000:00:1d.0: irq 18, io mem 0x91e02000
[    9.516104] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    9.516224] hub 2-0:1.0: USB hub found
[    9.516227] hub 2-0:1.0: 2 ports detected
[    9.516527] ahci 0000:00:11.4: SSS flag set, parallel bus scan disabled
[    9.516580] ahci 0000:00:11.4: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0xf impl SATA mode
[    9.516582] ahci 0000:00:11.4: flags: 64bit ncq stag led clo pio slum part ems apst
[    9.519107] megaraid_sas 0000:03:00.0: Init cmd success
[    9.520181] tg3 0000:01:00.1 eth1: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address 18:66:da:f0:43:19
[    9.520183] tg3 0000:01:00.1 eth1: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    9.520184] tg3 0000:01:00.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[    9.520185] tg3 0000:01:00.1 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
[    9.525317] scsi host1: ahci
[    9.525470] scsi host2: ahci
[    9.525601] scsi host3: ahci
[    9.525727] scsi host4: ahci
[    9.525749] ata1: SATA max UDMA/133 abar m2048@0x91e01000 port 0x91e01100 irq 103
[    9.525751] ata2: SATA max UDMA/133 abar m2048@0x91e01000 port 0x91e01180 irq 103
[    9.525753] ata3: SATA max UDMA/133 abar m2048@0x91e01000 port 0x91e01200 irq 103
[    9.525755] ata4: SATA max UDMA/133 abar m2048@0x91e01000 port 0x91e01280 irq 103
[    9.525899] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    9.525958] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    9.525960] ahci 0000:00:1f.2: flags: 64bit ncq stag led clo pio slum part ems apst
[    9.532844] tg3 0000:02:00.0 eth2: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address 18:66:da:f0:43:1a
[    9.532845] tg3 0000:02:00.0 eth2: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    9.532846] tg3 0000:02:00.0 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[    9.532847] tg3 0000:02:00.0 eth2: dma_rwctrl[00000001] dma_mask[64-bit]
[    9.542115] megaraid_sas 0000:03:00.0: firmware type : Extended VD(240 VD)firmware
[    9.542116] megaraid_sas 0000:03:00.0: controller type       : MR(1024MB)
[    9.542117] megaraid_sas 0000:03:00.0: Online Controller Reset(OCR)  : Enabled
[    9.542118] megaraid_sas 0000:03:00.0: Secure JBOD support   : No
[    9.542619] scsi host5: ahci
[    9.542887] scsi host6: ahci
[    9.543023] scsi host7: ahci
[    9.543117] scsi host8: ahci
[    9.543196] scsi host9: ahci
[    9.543273] scsi host10: ahci
[    9.543294] ata5: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e00100 irq 105
[    9.543296] ata6: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e00180 irq 105
[    9.543297] ata7: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e00200 irq 105
[    9.543299] ata8: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e00280 irq 105
[    9.543300] ata9: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e00300 irq 105
[    9.543303] ata10: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e00380 irq 105
[    9.544851] tg3 0000:02:00.1 eth3: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address 18:66:da:f0:43:1b
[    9.544853] tg3 0000:02:00.1 eth3: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    9.544854] tg3 0000:02:00.1 eth3: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[    9.544854] tg3 0000:02:00.1 eth3: dma_rwctrl[00000001] dma_mask[64-bit]
[    9.564469] megaraid_sas 0000:03:00.0: INIT adapter done
[    9.564470] megaraid_sas 0000:03:00.0: Jbod map is not supported megasas_setup_jbod_map 5092
[    9.569099] megaraid_sas 0000:03:00.0: pci id                : (0x1000)/(0x005d)/(0x1028)/(0x1f49)
[    9.569100] megaraid_sas 0000:03:00.0: unevenspan support    : yes
[    9.569100] megaraid_sas 0000:03:00.0: firmware crash dump   : no
[    9.569101] megaraid_sas 0000:03:00.0: jbod sync map         : no
[    9.569102] scsi host0: Avago SAS based MegaRAID driver
[    9.570230] scsi 0:0:0:0: Direct-Access     ATA      INTEL SSDSC2BX80 DL2B PQ: 0 ANSI: 6
[    9.696778] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[    9.813117] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    9.829140] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    9.834495] ata1: SATA link down (SStatus 0 SControl 300)
[    9.850520] ata5: SATA link down (SStatus 0 SControl 300)
[    9.931734] hub 1-1:1.0: USB hub found
[    9.931815] hub 1-1:1.0: 6 ports detected
[    9.947578] hub 2-1:1.0: USB hub found
[    9.947703] hub 2-1:1.0: 8 ports detected
[   10.049053] mlx5_core 0000:86:00.1: firmware version: 12.16.1020
[   10.146775] ata2: SATA link down (SStatus 0 SControl 300)
[   10.311739] usb 1-1.6: new high-speed USB device number 3 using ehci-pci
[   10.311745] clocksource: Switched to clocksource tsc
[   10.311754] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   10.382482] random: fast init done
[   10.416365] hub 1-1.6:1.0: USB hub found
[   10.421274] hub 1-1.6:1.0: 6 ports detected
[   10.434862] IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
[   10.458334] ata3: SATA link down (SStatus 0 SControl 300)
[   10.566568] IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
[   10.704778] mlx5_core 0000:87:00.0: firmware version: 12.16.1020
[   10.770960] ata4: SATA link down (SStatus 0 SControl 300)
[   11.083034] ata6: SATA link down (SStatus 0 SControl 300)
[   11.279868] mlx5_core 0000:87:00.1: firmware version: 12.16.1020
[   11.395043] ata7: SATA link down (SStatus 0 SControl 300)
[   11.707037] ata8: SATA link down (SStatus 0 SControl 300)
[   12.019123] ata9: SATA link down (SStatus 0 SControl 300)
[   12.331086] ata10: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   12.341857] ata10.00: ATAPI: PLDS DVD+/-RW DS-8ABSH, LD51, max UDMA/133
[   12.353211] ata10.00: configured for UDMA/133
[   12.367208] scsi 10:0:0:0: CD-ROM            PLDS     DVD+-RW DS-8ABSH LD51 PQ: 0 ANSI: 5
[   12.400336] sd 0:0:0:0: [sda] 1562824368 512-byte logical blocks: (800 GB/745 GiB)
[   12.409316] sd 0:0:0:0: [sda] 4096-byte physical blocks
[   12.416285] sd 0:0:0:0: [sda] Write Protect is off
[   12.420118] sr 10:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[   12.420119] cdrom: Uniform CD-ROM driver Revision: 3.20
[   12.439070] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   12.455940]  sda: sda1 sda2 sda3 sda4 sda6 sda7 sda9
[   12.467181] sd 0:0:0:0: [sda] Attached SCSI disk
[   13.174622] tg3 0000:01:00.1 eth1: Link is up at 1000 Mbps, full duplex
[   13.182306] tg3 0000:01:00.1 eth1: Flow control is off for TX and off for RX
[   13.190480] tg3 0000:01:00.1 eth1: EEE is enabled
[   13.196035] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   13.907947] tg3 0000:01:00.0 eth0: Link is up at 1000 Mbps, full duplex
[   13.915628] tg3 0000:01:00.0 eth0: Flow control is on for TX and on for RX
[   13.923603] tg3 0000:01:00.0 eth0: EEE is disabled
[   13.929251] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   15.628613] kauditd_printk_skb: 9 callbacks suppressed
[   15.628616] audit: type=1130 audit(1493115881.356:16): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=ignition-disks comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.628618] audit: type=1131 audit(1493115881.356:17): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=ignition-disks comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.697077] loop: module loaded
[   15.727607] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   15.755857] audit: type=1130 audit(1493115881.483:18): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-setup-root comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.755859] audit: type=1131 audit(1493115881.483:19): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-setup-root comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.804913] audit: type=1130 audit(1493115881.532:20): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=ignition-files comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.804920] audit: type=1131 audit(1493115881.532:21): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=ignition-files comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.886693] audit: type=1130 audit(1493115881.614:22): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-parse-etc comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.886695] audit: type=1131 audit(1493115881.614:23): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-parse-etc comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.948548] audit: type=1130 audit(1493115881.675:24): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-pivot comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.978244] audit: type=1131 audit(1493115881.705:25): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-pivot comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   16.538820] systemd-journald[499]: Received SIGTERM from PID 1 (systemd).
[   16.550805] systemd: 20 output lines suppressed due to ratelimiting
[   16.623944] SELinux:  Permission validate_trans in class security not defined in policy.
[   16.633602] SELinux:  Permission module_load in class system not defined in policy.
[   16.642729] SELinux:  Class cap_userns not defined in policy.
[   16.649450] SELinux:  Class cap2_userns not defined in policy.
[   16.656265] SELinux:  Class sctp_socket not defined in policy.
[   16.663079] SELinux:  Class icmp_socket not defined in policy.
[   16.669892] SELinux:  Class ax25_socket not defined in policy.
[   16.676708] SELinux:  Class ipx_socket not defined in policy.
[   16.683428] SELinux:  Class netrom_socket not defined in policy.
[   16.690438] SELinux:  Class atmpvc_socket not defined in policy.
[   16.697447] SELinux:  Class x25_socket not defined in policy.
[   16.704164] SELinux:  Class rose_socket not defined in policy.
[   16.710972] SELinux:  Class decnet_socket not defined in policy.
[   16.717989] SELinux:  Class atmsvc_socket not defined in policy.
[   16.725000] SELinux:  Class rds_socket not defined in policy.
[   16.731711] SELinux:  Class irda_socket not defined in policy.
[   16.738532] SELinux:  Class pppox_socket not defined in policy.
[   16.745441] SELinux:  Class llc_socket not defined in policy.
[   16.752160] SELinux:  Class can_socket not defined in policy.
[   16.758894] SELinux:  Class tipc_socket not defined in policy.
[   16.765714] SELinux:  Class bluetooth_socket not defined in policy.
[   16.773015] SELinux:  Class iucv_socket not defined in policy.
[   16.779830] SELinux:  Class rxrpc_socket not defined in policy.
[   16.786748] SELinux:  Class isdn_socket not defined in policy.
[   16.793564] SELinux:  Class phonet_socket not defined in policy.
[   16.800574] SELinux:  Class ieee802154_socket not defined in policy.
[   16.807973] SELinux:  Class caif_socket not defined in policy.
[   16.814789] SELinux:  Class alg_socket not defined in policy.
[   16.821510] SELinux:  Class nfc_socket not defined in policy.
[   16.828228] SELinux:  Class vsock_socket not defined in policy.
[   16.835144] SELinux:  Class kcm_socket not defined in policy.
[   16.841862] SELinux:  Class qipcrtr_socket not defined in policy.
[   16.848970] SELinux:  Class smc_socket not defined in policy.
[   16.855687] SELinux: the above unknown classes and permissions will be allowed
[   16.877210] systemd[1]: Successfully loaded SELinux policy in 270.767ms.
[   16.885016] Unable to open file: /etc/ima/ima-policy (-2)
[   16.885021] IMA: policy update failed
[   16.902896] ip_tables: (C) 2000-2006 Netfilter Core Team
[   16.914773] systemd[1]: Relabelled /dev and /run in 5.211ms.
[   17.034037] mlx5_ib: Mellanox Connect-IB Infiniband driver v2.2-1 (Feb 2014)
[   17.057774] systemd-journald[1586]: Received request to flush runtime journal from PID 1
[   17.177969] random: crng init done
[   17.252911] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[   17.261717] ACPI: Power Button [PWRF]
[   17.305883] tg3 0000:02:00.0 eno3: renamed from eth2
[   17.330881] tg3 0000:02:00.1 eno4: renamed from eth3
[   17.341702] ipmi message handler version 39.2
[   17.349966] ipmi device interface
[   17.350330] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[   17.350644] mei_me 0000:00:16.0: Device doesn't have valid ME Interface
[   17.353711] IPMI System Interface driver.
[   17.353762] ipmi_si: probing via SMBIOS
[   17.353763] ipmi_si: SMBIOS: io 0xca8 regsize 1 spacing 4 irq 10
[   17.353764] ipmi_si: Adding SMBIOS-specified kcs state machine
[   17.353765] ipmi_si: Trying SMBIOS-specified kcs state machine at i/o address 0xca8, slave address 0x20, irq 10
[   17.360247] tg3 0000:01:00.1 eno2: renamed from eth1
[   17.449729] ipmi_si ipmi_si.0: The BMC does not support setting the recv irq bit, compensating, but the BMC needs to be fixed.
[   17.464882] tg3 0000:01:00.0 eno1: renamed from eth0
[   17.480746] ipmi_si ipmi_si.0: Using irq 10
[   17.509741] EDAC MC: Ver: 3.0.0
[   17.516680] ipmi_si ipmi_si.0: Found new BMC (man_id: 0x0002a2, prod_id: 0x0100, dev_id: 0x20)
[   17.517046] EDAC MC0: Giving out device to module sbridge_edac.c controller Broadwell Socket#0: DEV 0000:7f:12.0 (INTERRUPT)
[   17.517145] EDAC MC1: Giving out device to module sbridge_edac.c controller Broadwell Socket#1: DEV 0000:ff:12.0 (INTERRUPT)
[   17.517145] EDAC sbridge:  Ver: 1.1.1
[   17.562722] ipmi_si ipmi_si.0: IPMI kcs interface initialized
[   17.572596] IPMI SSIF Interface driver
[   17.572673] [drm] amdgpu kernel modesetting enabled.
[   17.590787] AMD IOMMUv2 driver by Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
[   17.597810] AMD IOMMUv2 functionality not available on this system
[   17.615729] CRAT table not found
[   17.619635] Finished initializing topology ret=0
[   17.625242] kfd kfd: Initialized module
[   17.630034] amdgpu 0000:84:00.0: enabling device (0000 -> 0003)
[   17.637202] [drm] initializing kernel modesetting (TONGA 0x1002:0x6929 0x1002:0x0334 0x00).
[   17.647112] [drm] register mmio base: 0xD0100000
[   17.652564] [drm] register mmio size: 262144
[   17.657646] [drm] doorbell mmio base: 0xF0000000
[   17.663118] [drm] doorbell mmio size: 2097152
[   17.668377] [drm] probing gen 2 caps for device 10b5:8747 = 8796103/10e
[   17.676068] [drm] probing mlw for device 10b5:8747 = 8796103
[   17.682694] [drm] VCE enabled in physical mode
[   18.676816] ATOM BIOS: C76301
[   18.680457] [drm] GPU posting now...
[   23.690240] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios stuck in loop for more than 5secs aborting
[   23.701895] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios stuck executing F250 (len 334, WS 4, PS 0) @ 0xF365
[   23.714199] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios stuck executing DB34 (len 324, WS 4, PS 0) @ 0xDC2C
[   23.726605] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios stuck executing BCDE (len 254, WS 0, PS 4) @ 0xBDB4
[   23.738892] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios stuck executing B832 (len 143, WS 0, PS 8) @ 0xB8A9
[   23.751192] amdgpu 0000:84:00.0: gpu post error!
[   23.756681] amdgpu 0000:84:00.0: Fatal error during GPU init
[   23.763308] [drm] amdgpu: finishing device.
[   23.768298] ------------[ cut here ]------------
[   23.773774] WARNING: CPU: 0 PID: 1728 at ../../../../../../../../usr/src/linux-4.11-rc7-coreos/drivers/gpu/drm/drm_modeset_lock.c:345 drm_modeset_lock+0xcf/0xe0 [drm]
[   23.791160] Modules linked in: amdkfd sch_fq_codel amd_iommu_v2 coretemp ipmi_ssif amdgpu(+) sb_edac edac_core i2c_algo_bit drm_kms_helper x86_pkg_temp_thermal ttm drm kvm_intel kvm i2c_core ipmi_si syscopyarea sysfillrect mei_me dcdbas ipmi_devintf sysimgblt irqbypass4
[   23.854988] CPU: 0 PID: 1728 Comm: systemd-udevd Not tainted 4.11.0-rc7-coreos #1
[   23.854989] Hardware name: Dell Inc. PowerEdge R730/0WCJNT, BIOS 2.2.5 09/06/2016
[   23.854989] Call Trace:
[   23.854995]  dump_stack+0x63/0x90
[   23.854998]  __warn+0xd1/0xf0
[   23.855000]  warn_slowpath_null+0x1d/0x20
[   23.855005]  drm_modeset_lock+0xcf/0xe0 [drm]
[   23.855009]  drm_modeset_lock_all_ctx+0x22/0xb0 [drm]
[   23.855012]  drm_modeset_lock_all+0x60/0xc0 [drm]
[   23.855017]  drm_crtc_force_disable_all+0x21/0x80 [drm]
[   23.855028]  amdgpu_device_fini+0x2d/0x130 [amdgpu]
[   23.855037]  amdgpu_driver_unload_kms+0x4f/0xa0 [amdgpu]
[   23.855045]  amdgpu_driver_load_kms+0x109/0x1e0 [amdgpu]
[   23.855049]  drm_dev_register+0x148/0x1e0 [drm]
[   23.855053]  drm_get_pci_dev+0xa0/0x160 [drm]
[   23.855063]  amdgpu_drm_ioctl+0x469/0x1800 [amdgpu]
[   23.855066]  local_pci_probe+0x45/0xa0
[   23.855068]  pci_device_probe+0xfa/0x150
[   23.855070]  driver_probe_device+0x2c5/0x470
[   23.855072]  __driver_attach+0xdf/0xf0
[   23.855073]  ? driver_probe_device+0x470/0x470
[   23.855074]  bus_for_each_dev+0x6c/0xc0
[   23.855076]  driver_attach+0x1e/0x20
[   23.855077]  bus_add_driver+0x45/0x270
[   23.855078]  ? 0xffffffffc0769000
[   23.855079]  driver_register+0x60/0xe0
[   23.855080]  ? 0xffffffffc0769000
[   23.855081]  __pci_register_driver+0x4c/0x50
[   23.855086]  drm_pci_init+0xed/0x100 [drm]
[   23.855087]  ? 0xffffffffc0769000
[   23.855096]  init_module+0x92/0x1000 [amdgpu]
[   23.855098]  do_one_initcall+0x53/0x1b0
[   23.855101]  ? __vunmap+0x81/0xd0
[   23.855104]  ? kmem_cache_alloc_trace+0xdb/0x1b0
[   23.855105]  ? kfree+0x161/0x170
[   23.855107]  do_init_module+0x60/0x1fa
[   23.855111]  load_module+0x247b/0x2950
[   23.855113]  SYSC_finit_module+0xa6/0xf0
[   23.855115]  ? SYSC_finit_module+0xa6/0xf0
[   23.855117]  SyS_finit_module+0xe/0x10
[   23.855118]  do_syscall_64+0x5a/0x160
[   23.855120]  entry_SYSCALL64_slow_path+0x25/0x25
[   23.855121] RIP: 0033:0x7f60d03205e9
[   23.855122] RSP: 002b:00007ffe240f1c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   23.855123] RAX: ffffffffffffffda RBX: 000055b05bcb28d0 RCX: 00007f60d03205e9
[   23.855123] RDX: 0000000000000000 RSI: 00007f60d0c3ed24 RDI: 0000000000000017
[   23.855124] RBP: 00007f60d0c3ed24 R08: 0000000000000000 R09: 000055b05bcb52f0
[   23.855125] R10: 0000000000000017 R11: 0000000000000246 R12: 0000000000000000
[   23.855125] R13: 000055b05bcb5020 R14: 0000000000020000 R15: 000000000aba9500
[   23.855127] ---[ end trace cf7afae7f9d7036f ]---
[   23.855158] BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
[   23.855161] IP: ww_mutex_lock+0x24/0x90
[   23.855162] PGD 0
[   23.855162]
[   23.855163] Oops: 0002 [#1] SMP
[   23.855164] Modules linked in: amdkfd sch_fq_codel amd_iommu_v2 coretemp ipmi_ssif amdgpu(+) sb_edac edac_core i2c_algo_bit drm_kms_helper x86_pkg_temp_thermal ttm drm kvm_intel kvm i2c_core ipmi_si syscopyarea sysfillrect mei_me dcdbas ipmi_devintf sysimgblt irqbypass4
[   23.855183] CPU: 0 PID: 1728 Comm: systemd-udevd Tainted: G        W       4.11.0-rc7-coreos #1
[   23.855183] Hardware name: Dell Inc. PowerEdge R730/0WCJNT, BIOS 2.2.5 09/06/2016
[   23.855184] task: ffffa0c7ff8a3b00 task.stack: ffffb21c5ae1c000
[   23.855186] RIP: 0010:ww_mutex_lock+0x24/0x90
[   23.855186] RSP: 0018:ffffb21c5ae1f8c0 EFLAGS: 00010246
[   23.855187] RAX: 0000000000000000 RBX: 0000000000000018 RCX: 0000000000000000
[   23.855188] RDX: ffffa0c7ff8a3b00 RSI: ffffa0c7ff8a5440 RDI: ffffa0a83f61a440
[   23.855188] RBP: ffffb21c5ae1f8d8 R08: 0000000000000001 R09: 0000000000000000
[   23.855189] R10: ffffb21c599cfd70 R11: 0000000000000000 R12: ffffa0a8214eda00
[   23.855190] R13: fffffffffffffff0 R14: ffffa0c8316d1b50 R15: 0000000000000000
[   23.855191] FS:  00007f60d12aa8c0(0000) GS:ffffa0a83f600000(0000) knlGS:0000000000000000
[   23.855191] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.855192] CR2: 0000000000000018 CR3: 0000003fbf8fa000 CR4: 00000000003406f0
[   23.855193] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   23.855193] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   23.855194] Call Trace:
[   23.855199]  drm_modeset_lock+0x35/0xe0 [drm]
[   23.855204]  drm_modeset_lock_all_ctx+0x5a/0xb0 [drm]
[   23.855207]  drm_modeset_lock_all+0x60/0xc0 [drm]
[   23.855211]  drm_crtc_force_disable_all+0x21/0x80 [drm]
[   23.855240]  amdgpu_device_fini+0x2d/0x130 [amdgpu]
[   23.855250]  amdgpu_driver_unload_kms+0x4f/0xa0 [amdgpu]
[   23.855259]  amdgpu_driver_load_kms+0x109/0x1e0 [amdgpu]
[   23.855264]  drm_dev_register+0x148/0x1e0 [drm]
[   23.855269]  drm_get_pci_dev+0xa0/0x160 [drm]
[   23.855278]  amdgpu_drm_ioctl+0x469/0x1800 [amdgpu]
[   23.855280]  local_pci_probe+0x45/0xa0
[   23.855282]  pci_device_probe+0xfa/0x150
[   23.855283]  driver_probe_device+0x2c5/0x470
[   23.855285]  __driver_attach+0xdf/0xf0
[   23.855286]  ? driver_probe_device+0x470/0x470
[   23.855287]  bus_for_each_dev+0x6c/0xc0
[   23.855289]  driver_attach+0x1e/0x20
[   23.855291]  bus_add_driver+0x45/0x270
[   23.855292]  ? 0xffffffffc0769000
[   23.855293]  driver_register+0x60/0xe0
[   23.855294]  ? 0xffffffffc0769000
[   23.855295]  __pci_register_driver+0x4c/0x50
[   23.855300]  drm_pci_init+0xed/0x100 [drm]
[   23.855300]  ? 0xffffffffc0769000
[   23.855310]  init_module+0x92/0x1000 [amdgpu]
[   23.855312]  do_one_initcall+0x53/0x1b0
[   23.855314]  ? __vunmap+0x81/0xd0
[   23.855315]  ? kmem_cache_alloc_trace+0xdb/0x1b0
[   23.855317]  ? kfree+0x161/0x170
[   23.855319]  do_init_module+0x60/0x1fa
[   23.855321]  load_module+0x247b/0x2950
[   23.855324]  SYSC_finit_module+0xa6/0xf0
[   23.855325]  ? SYSC_finit_module+0xa6/0xf0
[   23.855328]  SyS_finit_module+0xe/0x10
[   23.855329]  do_syscall_64+0x5a/0x160
[   23.855330]  entry_SYSCALL64_slow_path+0x25/0x25
[   23.855331] RIP: 0033:0x7f60d03205e9
[   23.855332] RSP: 002b:00007ffe240f1c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   23.855333] RAX: ffffffffffffffda RBX: 000055b05bcb28d0 RCX: 00007f60d03205e9
[   23.855333] RDX: 0000000000000000 RSI: 00007f60d0c3ed24 RDI: 0000000000000017
[   23.855334] RBP: 00007f60d0c3ed24 R08: 0000000000000000 R09: 000055b05bcb52f0
[   23.855335] R10: 0000000000000017 R11: 0000000000000246 R12: 0000000000000000
[   23.855335] R13: 000055b05bcb5020 R14: 0000000000020000 R15: 000000000aba9500
[   23.855336] Code: 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41 55 41 54 53 49 89 f4 48 89 fb e8 07 e4 ff ff 65 48 8b 14 25 40 d4 00 00 31 c0 <f0> 48 0f b1 13 48 85 c0 75 22 4d 85 e4 74 14 41 83 44 24 10 01
[   23.855356] RIP: ww_mutex_lock+0x24/0x90 RSP: ffffb21c5ae1f8c0
[   23.855357] CR2: 0000000000000018
[   23.855379] ---[ end trace cf7afae7f9d70370 ]---
[   23.860599] Kernel panic - not syncing: Fatal exception
[   24.009534] Kernel Offset: 0x25000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   24.776209] Rebooting in 60 seconds..
[   84.783559] ACPI MEMORY or I/O RESET_REG.

--nextPart4354749.MxMgfExfD9
Content-Disposition: attachment; filename="node-amd-kernel-v4.11.0_rc7-radeon-r5-230-no-oops.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="UTF-8"; name="node-amd-kernel-v4.11.0_rc7-radeon-r5-230-no-oops.log"

[    0.000000] Linux version 4.11.0-rc7-coreos (tf128@c07060) (gcc version 4.9.4 (Gentoo Hardened 4.9.4 p1.0, pie-0.6.4) ) #1 SMP Fri Apr 21 22:23:28 CEST 2017
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
[    0.000000] RAMDISK: [mem 0x6ab76000-0x7a1eafff]
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
[    0.000000] percpu: Embedded 37 pages/cpu @ffff95a77f600000 s112216 r8192 d31144 u262144
[    0.000000] Built 2 zonelists in Node order, mobility grouping on.  Total pages: 66036651
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: rootflags=rw mount.usrflags=ro coreos.config.url=http://192.168.10.27:8080/ignition?uuid=4c4c4544-004c-5610-804c-b8c04f574732&mac=18-66-da-f0-43-18 coreos.autologin coreos.first_boot console=ttyS0,115200n8 console=tty0
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 225280 bytes
[    0.000000] log_buf_len min size: 262144 bytes
[    0.000000] log_buf_len: 524288 bytes
[    0.000000] early log buf free: 235728(89%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Memory: 263771608K/268339504K available (6198K kernel code, 1268K rwdata, 2600K rodata, 31788K init, 736K bss, 4567896K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=56, Nodes=2
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU debugfs-based tracing is enabled.
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
[    0.001000] tsc: Detected 2600.269 MHz processor
[    0.002000] Calibrating delay loop (skipped), value calculated using timer frequency.. 5200.53 BogoMIPS (lpj=2600269)
[    0.003002] pid_max: default: 57344 minimum: 448
[    0.004022] ACPI: Core revision 20170119
[    0.076373] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.077059] Security Framework initialized
[    0.078002] SELinux:  Initializing.
[    0.087617] Dentry cache hash table entries: 33554432 (order: 16, 268435456 bytes)
[    0.131830] Inode-cache hash table entries: 16777216 (order: 15, 134217728 bytes)
[    0.152502] Mount-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.153146] Mountpoint-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.156485] CPU: Physical Processor ID: 0
[    0.157002] CPU: Processor Core ID: 0
[    0.158005] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.159001] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.160005] mce: CPU supports 22 MCE banks
[    0.161015] CPU0: Thermal monitoring enabled (TM1)
[    0.162020] process: using mwait in idle threads
[    0.163004] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.164001] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.165556] Freeing SMP alternatives memory: 24K
[    0.168004] ftrace: allocating 24354 entries in 96 pages
[    0.174085] smpboot: Max logical packages: 4
[    0.175019] DMAR: Host address width 46
[    0.176002] DMAR: DRHD base: 0x000000fbffc000 flags: 0x0
[    0.177006] DMAR: dmar0: reg_base_addr fbffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.178002] DMAR: DRHD base: 0x000000c7ffc000 flags: 0x1
[    0.179007] DMAR: dmar1: reg_base_addr c7ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.180002] DMAR: RMRR base: 0x0000007ae07000 end: 0x0000007af06fff
[    0.181002] DMAR: ATSR flags: 0x0
[    0.182002] DMAR: ATSR flags: 0x0
[    0.183003] DMAR-IR: IOAPIC id 10 under DRHD base  0xfbffc000 IOMMU 0
[    0.184002] DMAR-IR: IOAPIC id 8 under DRHD base  0xc7ffc000 IOMMU 1
[    0.185002] DMAR-IR: IOAPIC id 9 under DRHD base  0xc7ffc000 IOMMU 1
[    0.186002] DMAR-IR: HPET id 0 under DRHD base 0xc7ffc000
[    0.187002] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out bit.
[    0.187003] DMAR-IR: Use 'intremap=no_x2apic_optout' to override the BIOS setting.
[    0.190472] DMAR-IR: Enabled IRQ remapping in xapic mode
[    0.191000] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.191002] Switched APIC routing to physical flat.
[    0.192610] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.202793] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2690 v4 @ 2.60GHz (family: 0x6, model: 0x4f, stepping: 0x1)
[    0.203104] Performance Events: PEBS fmt2+, Broadwell events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.204003] ... version:                3
[    0.205000] ... bit width:              48
[    0.206000] ... generic registers:      4
[    0.207000] ... value mask:             0000ffffffffffff
[    0.208000] ... max period:             00007fffffffffff
[    0.209000] ... fixed-purpose events:   3
[    0.210000] ... event mask:             000000070000000f
[    0.213755] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.214013] smp: Bringing up secondary CPUs ...
[    0.215081] x86: Booting SMP configuration:
[    0.216001] .... node  #1, CPUs:        #1
[    0.279001] .... node  #0, CPUs:    #2
[    0.341001] .... node  #1, CPUs:    #3
[    0.403001] .... node  #0, CPUs:    #4
[    0.465001] .... node  #1, CPUs:    #5
[    0.527000] .... node  #0, CPUs:    #6
[    0.589001] .... node  #1, CPUs:    #7
[    0.651000] .... node  #0, CPUs:    #8
[    0.713001] .... node  #1, CPUs:    #9
[    0.775000] .... node  #0, CPUs:   #10
[    0.837001] .... node  #1, CPUs:   #11
[    0.899000] .... node  #0, CPUs:   #12
[    0.961001] .... node  #1, CPUs:   #13
[    1.023000] .... node  #0, CPUs:   #14
[    1.085001] .... node  #1, CPUs:   #15
[    1.147000] .... node  #0, CPUs:   #16
[    1.209001] .... node  #1, CPUs:   #17
[    1.271000] .... node  #0, CPUs:   #18
[    1.333001] .... node  #1, CPUs:   #19
[    1.395000] .... node  #0, CPUs:   #20
[    1.457001] .... node  #1, CPUs:   #21
[    1.519000] .... node  #0, CPUs:   #22
[    1.581001] .... node  #1, CPUs:   #23
[    1.643000] .... node  #0, CPUs:   #24
[    1.705001] .... node  #1, CPUs:   #25
[    1.767001] .... node  #0, CPUs:   #26
[    1.829001] .... node  #1, CPUs:   #27
[    1.891000] .... node  #0, CPUs:   #28
[    1.953002] .... node  #1, CPUs:   #29
[    2.015001] .... node  #0, CPUs:   #30
[    2.077001] .... node  #1, CPUs:   #31
[    2.139000] .... node  #0, CPUs:   #32
[    2.201001] .... node  #1, CPUs:   #33
[    2.263000] .... node  #0, CPUs:   #34
[    2.325001] .... node  #1, CPUs:   #35
[    2.387000] .... node  #0, CPUs:   #36
[    2.449001] .... node  #1, CPUs:   #37
[    2.511000] .... node  #0, CPUs:   #38
[    2.573001] .... node  #1, CPUs:   #39
[    2.635000] .... node  #0, CPUs:   #40
[    2.697001] .... node  #1, CPUs:   #41
[    2.759001] .... node  #0, CPUs:   #42
[    2.821001] .... node  #1, CPUs:   #43
[    2.883000] .... node  #0, CPUs:   #44
[    2.945001] .... node  #1, CPUs:   #45
[    3.007000] .... node  #0, CPUs:   #46
[    3.069001] .... node  #1, CPUs:   #47
[    3.131000] .... node  #0, CPUs:   #48
[    3.193001] .... node  #1, CPUs:   #49
[    3.255000] .... node  #0, CPUs:   #50
[    3.317001] .... node  #1, CPUs:   #51
[    3.379000] .... node  #0, CPUs:   #52
[    3.441001] .... node  #1, CPUs:   #53
[    3.503000] .... node  #0, CPUs:   #54
[    3.565001] .... node  #1, CPUs:   #55
[    3.626066] smp: Brought up 2 nodes, 56 CPUs
[    3.628002] smpboot: Total of 56 processors activated (291567.68 BogoMIPS)
[    3.631696] sched_clock: Marking stable (3631000000, 0)->(4317579098, -686579098)
[    3.646493] devtmpfs: initialized
[    3.650531] x86/mm: Memory block size: 2048MB
[    3.657352] PM: Registering ACPI NVS region [mem 0x7af0b000-0x7b93afff] (10682368 bytes)
[    3.667138] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    3.678594] futex hash table entries: 16384 (order: 8, 1048576 bytes)
[    3.686538] pinctrl core: initialized pinctrl subsystem
[    3.693502] NET: Registered protocol family 16
[    3.698878] cpuidle: using governor menu
[    3.703550] PCCT header not found.
[    3.707752] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    3.716724] ACPI: bus type PCI registered
[    3.721494] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    3.729048] dca service started, version 1.12.1
[    3.734419] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    3.750717] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
[    3.758608] PCI: Using configuration type 1 for base access
[    3.765131] PCI: Dell System detected, enabling pci=bfsort.
[    3.773687] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    3.781093] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    3.789239] ACPI: Added _OSI(Module Device)
[    3.794212] ACPI: Added _OSI(Processor Device)
[    3.799472] ACPI: Added _OSI(3.0 _SCP Extensions)
[    3.805027] ACPI: Added _OSI(Processor Aggregator Device)
[    3.908976] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    3.926964] ACPI: Interpreter enabled
[    3.931354] ACPI: (supports S0 S5)
[    3.935449] ACPI: Using IOAPIC for interrupt routing
[    3.941328] HEST: Table parsing has been initialized.
[    3.947270] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    3.967003] ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
[    3.973917] acpi PNP0A03:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    3.983634] acpi PNP0A03:02: PCIe AER handled by firmware
[    3.990061] acpi PNP0A03:02: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    3.999140] acpi PNP0A03:02: FADT indicates ASPM is unsupported, using BIOS configuration
[    4.008835] PCI host bridge to bus 0000:ff
[    4.013706] pci_bus 0000:ff: root bus resource [bus ff]
[    4.022317] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus 7f])
[    4.029234] acpi PNP0A03:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    4.038954] acpi PNP0A03:03: PCIe AER handled by firmware
[    4.045382] acpi PNP0A03:03: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    4.054475] acpi PNP0A03:03: FADT indicates ASPM is unsupported, using BIOS configuration
[    4.064165] PCI host bridge to bus 0000:7f
[    4.069035] pci_bus 0000:7f: root bus resource [bus 7f]
[    4.078857] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
[    4.086066] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    4.095786] acpi PNP0A08:00: PCIe AER handled by firmware
[    4.102211] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    4.111286] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    4.121083] PCI host bridge to bus 0000:00
[    4.125952] pci_bus 0000:00: root bus resource [io  0x0000-0x03bb window]
[    4.133834] pci_bus 0000:00: root bus resource [io  0x03bc-0x03df window]
[    4.141716] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    4.149598] pci_bus 0000:00: root bus resource [io  0x1000-0x7fff window]
[    4.157482] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    4.166375] pci_bus 0000:00: root bus resource [mem 0x90000000-0xc7ffbfff window]
[    4.175251] pci_bus 0000:00: root bus resource [mem 0x38000000000-0x3bfffffffff window]
[    4.184717] pci_bus 0000:00: root bus resource [bus 00-7e]
[    4.191384] pci 0000:00:01.0: System wakeup disabled by ACPI
[    4.198144] pci 0000:00:02.0: System wakeup disabled by ACPI
[    4.204894] pci 0000:00:03.0: System wakeup disabled by ACPI
[    4.211634] pci 0000:00:03.1: System wakeup disabled by ACPI
[    4.218389] pci 0000:00:03.2: System wakeup disabled by ACPI
[    4.226254] pci 0000:00:1c.0: Enabling MPC IRBNCE
[    4.231806] pci 0000:00:1c.0: Intel PCH root port ACS workaround enabled
[    4.239741] pci 0000:00:1c.7: Enabling MPC IRBNCE
[    4.245293] pci 0000:00:1c.7: Intel PCH root port ACS workaround enabled
[    4.253109] pci 0000:00:1c.7: System wakeup disabled by ACPI
[    4.260354] pci 0000:00:01.0: PCI bridge to [bus 03]
[    4.266230] pci 0000:00:02.0: PCI bridge to [bus 04]
[    4.276088] pci 0000:00:03.0: PCI bridge to [bus 02]
[    4.285951] pci 0000:00:03.1: PCI bridge to [bus 01]
[    4.291823] pci 0000:00:03.2: PCI bridge to [bus 05]
[    4.297699] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    4.310754] pci 0000:00:1c.7: PCI bridge to [bus 07-0b]
[    4.324613] pci 0000:07:00.0: PCI bridge to [bus 08-0b]
[    4.337265] pci 0000:08:00.0: PCI bridge to [bus 09-0a]
[    4.350428] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    4.357634] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 *15)
[    4.366260] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 *14 15)
[    4.374882] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    4.383507] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 9 10 11 12 14 15)
[    4.392128] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    4.402018] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    4.411909] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    4.421798] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    4.431823] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-fe])
[    4.439031] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    4.448742] acpi PNP0A08:01: PCIe AER handled by firmware
[    4.455168] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    4.464245] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using BIOS configuration
[    4.474001] PCI host bridge to bus 0000:80
[    4.478878] pci_bus 0000:80: root bus resource [io  0x8000-0xffff window]
[    4.486751] pci_bus 0000:80: root bus resource [mem 0xc8000000-0xfbffbfff window]
[    4.495642] pci_bus 0000:80: root bus resource [mem 0x3c000000000-0x3ffffffffff window]
[    4.505107] pci_bus 0000:80: root bus resource [bus 80-fe]
[    4.511643] pci 0000:80:01.0: System wakeup disabled by ACPI
[    4.518390] pci 0000:80:02.0: System wakeup disabled by ACPI
[    4.525131] pci 0000:80:03.0: System wakeup disabled by ACPI
[    4.531871] pci 0000:80:03.2: System wakeup disabled by ACPI
[    4.538842] pci 0000:80:01.0: PCI bridge to [bus 81]
[    4.547701] pci 0000:80:02.0: PCI bridge to [bus 82]
[    4.555582] pci 0000:80:03.0: PCI bridge to [bus 83]
[    4.563447] pci 0000:80:03.2: PCI bridge to [bus 84]
[    4.569362] ACPI: Enabled 2 GPEs in block 00 to 3F
[    4.598399] pci 0000:0a:00.0: vgaarb: setting as boot VGA device
[    4.605403] pci 0000:0a:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    4.615451] pci 0000:82:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    4.625305] pci 0000:82:00.0: vgaarb: bridge control possible
[    4.632017] pci 0000:0a:00.0: vgaarb: bridge control possible
[    4.638730] vgaarb: loaded
[    4.642091] PCI: Using ACPI for IRQ routing
[    4.653374] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    4.660573] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    4.669484] clocksource: Switched to clocksource hpet
[    4.683201] VFS: Disk quotas dquot_6.6.0
[    4.687913] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    4.695975] pnp: PnP ACPI init
[    4.700127] system 00:01: [io  0x0500-0x053f] has been reserved
[    4.707039] system 00:01: [io  0x0400-0x047f] has been reserved
[    4.713969] system 00:01: [io  0x0540-0x057f] has been reserved
[    4.720876] system 00:01: [io  0x0600-0x061f] has been reserved
[    4.727783] system 00:01: [io  0x0ca0-0x0ca5] has been reserved
[    4.734697] system 00:01: [io  0x0880-0x0883] has been reserved
[    4.741608] system 00:01: [io  0x0800-0x081f] has been reserved
[    4.748515] system 00:01: [mem 0xfeda8000-0xfedcbfff] could not be reserved
[    4.756589] system 00:01: [mem 0xff000000-0xffffffff] could not be reserved
[    4.764666] system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
[    4.772348] system 00:01: [mem 0xfed12000-0xfed1200f] has been reserved
[    4.780038] system 00:01: [mem 0xfed12010-0xfed1201f] has been reserved
[    4.787725] system 00:01: [mem 0xfed1b000-0xfed1bfff] has been reserved
[    4.795720] system 00:04: [io  0x0ca8] has been reserved
[    4.801952] system 00:04: [io  0x0cac] has been reserved
[    4.808266] pnp: PnP ACPI: found 5 devices
[    4.818829] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    4.829267] pci 0000:03:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    4.840864] pci 0000:02:00.0: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no compatible bridge window
[    4.852460] pci 0000:02:00.1: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no compatible bridge window
[    4.864057] pci 0000:01:00.0: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no compatible bridge window
[    4.875647] pci 0000:01:00.1: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no compatible bridge window
[    4.887239] pci 0000:82:00.0: can't claim BAR 6 [mem 0xfffe0000-0xffffffff pref]: no compatible bridge window
[    4.898839] pci 0000:83:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    4.910439] pci 0000:83:00.1: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    4.922037] pci 0000:84:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    4.933634] pci 0000:84:00.1: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    4.946032] pci 0000:00:03.0: BAR 14: assigned [mem 0x91f00000-0x91ffffff]
[    4.954014] pci 0000:00:03.1: BAR 14: assigned [mem 0x92000000-0x920fffff]
[    4.961994] pci 0000:03:00.0: BAR 6: no space for [mem size 0x00100000 pref]
[    4.970164] pci 0000:03:00.0: BAR 6: failed to assign [mem size 0x00100000 pref]
[    4.978952] pci 0000:00:01.0: PCI bridge to [bus 03]
[    4.984792] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    4.991896] pci 0000:00:01.0:   bridge window [mem 0x91c00000-0x91dfffff]
[    4.999776] pci 0000:00:02.0: PCI bridge to [bus 04]
[    5.005614] pci 0000:02:00.0: BAR 6: assigned [mem 0x91f00000-0x91f3ffff pref]
[    5.019516] pci 0000:02:00.1: BAR 6: assigned [mem 0x91f40000-0x91f7ffff pref]
[    5.028094] pci 0000:00:03.0: PCI bridge to [bus 02]
[    5.033939] pci 0000:00:03.0:   bridge window [mem 0x91f00000-0x91ffffff]
[    5.041815] pci 0000:00:03.0:   bridge window [mem 0x91a00000-0x91afffff 64bit pref]
[    5.050988] pci 0000:01:00.0: BAR 6: assigned [mem 0x92000000-0x9203ffff pref]
[    5.059588] pci 0000:01:00.1: BAR 6: assigned [mem 0x92040000-0x9207ffff pref]
[    5.068182] pci 0000:00:03.1: PCI bridge to [bus 01]
[    5.074025] pci 0000:00:03.1:   bridge window [mem 0x92000000-0x920fffff]
[    5.081908] pci 0000:00:03.1:   bridge window [mem 0x91b00000-0x91bfffff 64bit pref]
[    5.091075] pci 0000:00:03.2: PCI bridge to [bus 05]
[    5.096905] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    5.102754] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    5.108742] pci 0000:09:00.0:   bridge window [mem 0x91000000-0x918fffff]
[    5.116723] pci 0000:09:00.0:   bridge window [mem 0x90000000-0x90ffffff 64bit pref]
[    5.126098] pci 0000:08:00.0: PCI bridge to [bus 09-0a]
[    5.132384] pci 0000:08:00.0:   bridge window [mem 0x91000000-0x918fffff]
[    5.140364] pci 0000:08:00.0:   bridge window [mem 0x90000000-0x90ffffff 64bit pref]
[    5.149742] pci 0000:07:00.0: PCI bridge to [bus 08-0b]
[    5.156006] pci 0000:07:00.0:   bridge window [mem 0x91000000-0x919fffff]
[    5.163978] pci 0000:07:00.0:   bridge window [mem 0x90000000-0x90ffffff 64bit pref]
[    5.173372] pci 0000:00:1c.7: PCI bridge to [bus 07-0b]
[    5.179510] pci 0000:00:1c.7:   bridge window [mem 0x91000000-0x919fffff]
[    5.187383] pci 0000:00:1c.7:   bridge window [mem 0x90000000-0x90ffffff 64bit pref]
[    5.196630] pci 0000:80:03.0: BAR 14: assigned [mem 0xd0200000-0xd03fffff]
[    5.204609] pci 0000:80:03.2: BAR 14: assigned [mem 0xd0400000-0xd05fffff]
[    5.212585] pci 0000:80:01.0: PCI bridge to [bus 81]
[    5.218433] pci 0000:82:00.0: BAR 6: assigned [mem 0xd0040000-0xd005ffff pref]
[    5.227020] pci 0000:80:02.0: PCI bridge to [bus 82]
[    5.232866] pci 0000:80:02.0:   bridge window [io  0x8000-0x8fff]
[    5.239974] pci 0000:80:02.0:   bridge window [mem 0xd0000000-0xd00fffff]
[    5.247857] pci 0000:80:02.0:   bridge window [mem 0x3fff0000000-0x3ffffffffff 64bit pref]
[    5.257701] pci 0000:83:00.0: BAR 6: assigned [mem 0xd0200000-0xd02fffff pref]
[    5.266289] pci 0000:83:00.1: BAR 6: assigned [mem 0xd0300000-0xd03fffff pref]
[    5.274875] pci 0000:80:03.0: PCI bridge to [bus 83]
[    5.280725] pci 0000:80:03.0:   bridge window [mem 0xd0200000-0xd03fffff]
[    5.288609] pci 0000:80:03.0:   bridge window [mem 0xc8000000-0xcbffffff 64bit pref]
[    5.297784] pci 0000:84:00.0: BAR 6: assigned [mem 0xd0400000-0xd04fffff pref]
[    5.306366] pci 0000:84:00.1: BAR 6: assigned [mem 0xd0500000-0xd05fffff pref]
[    5.314950] pci 0000:80:03.2: PCI bridge to [bus 84]
[    5.320793] pci 0000:80:03.2:   bridge window [mem 0xd0400000-0xd05fffff]
[    5.328674] pci 0000:80:03.2:   bridge window [mem 0xcc000000-0xcfffffff 64bit pref]
[    5.337933] NET: Registered protocol family 2
[    5.343539] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[    5.353052] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    5.361002] TCP: Hash tables configured (established 524288 bind 65536)
[    5.368833] UDP hash table entries: 65536 (order: 9, 2097152 bytes)
[    5.376517] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes)
[    5.384767] NET: Registered protocol family 1
[    5.403554] pci 0000:03:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
[    5.416189] pci 0000:0a:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    5.780843] Unpacking initramfs...
[    6.270692] Freeing initrd memory: 252372K
[    6.290297] DMAR: dmar0: Using Queued invalidation
[    6.295957] DMAR: dmar1: Using Queued invalidation
[    6.301632] DMAR: Setting RMRR:
[    6.305875] DMAR: Setting identity map for device 0000:00:1a.0 [0x7ae07000 - 0x7af06fff]
[    6.315932] DMAR: Setting identity map for device 0000:00:1d.0 [0x7ae07000 - 0x7af06fff]
[    6.325492] DMAR: Prepare 0-16MiB unity mapping for LPC
[    6.332091] DMAR: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]
[    6.340786] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    6.348381] iommu: Adding device 0000:00:00.0 to group 0
[    6.354634] iommu: Adding device 0000:00:01.0 to group 1
[    6.360885] iommu: Adding device 0000:00:02.0 to group 2
[    6.367142] iommu: Adding device 0000:00:03.0 to group 3
[    6.373400] iommu: Adding device 0000:00:03.1 to group 4
[    6.379648] iommu: Adding device 0000:00:03.2 to group 5
[    6.385974] iommu: Adding device 0000:00:05.0 to group 6
[    6.392229] iommu: Adding device 0000:00:05.1 to group 6
[    6.398488] iommu: Adding device 0000:00:05.2 to group 6
[    6.404740] iommu: Adding device 0000:00:05.4 to group 6
[    6.411031] iommu: Adding device 0000:00:11.0 to group 7
[    6.417285] iommu: Adding device 0000:00:11.4 to group 7
[    6.423572] iommu: Adding device 0000:00:16.0 to group 8
[    6.429827] iommu: Adding device 0000:00:16.1 to group 8
[    6.436074] iommu: Adding device 0000:00:1a.0 to group 9
[    6.442327] iommu: Adding device 0000:00:1c.0 to group 10
[    6.448677] iommu: Adding device 0000:00:1c.7 to group 11
[    6.455025] iommu: Adding device 0000:00:1d.0 to group 12
[    6.461410] iommu: Adding device 0000:00:1f.0 to group 13
[    6.467759] iommu: Adding device 0000:00:1f.2 to group 13
[    6.474154] iommu: Adding device 0000:01:00.0 to group 14
[    6.480512] iommu: Adding device 0000:01:00.1 to group 14
[    6.486909] iommu: Adding device 0000:02:00.0 to group 15
[    6.493264] iommu: Adding device 0000:02:00.1 to group 15
[    6.499617] iommu: Adding device 0000:03:00.0 to group 16
[    6.505967] iommu: Adding device 0000:07:00.0 to group 17
[    6.512317] iommu: Adding device 0000:08:00.0 to group 18
[    6.518683] iommu: Adding device 0000:09:00.0 to group 18
[    6.525011] iommu: Adding device 0000:0a:00.0 to group 18
[    6.531416] iommu: Adding device 0000:7f:08.0 to group 19
[    6.537761] iommu: Adding device 0000:7f:08.2 to group 19
[    6.544110] iommu: Adding device 0000:7f:08.3 to group 19
[    6.550504] iommu: Adding device 0000:7f:09.0 to group 20
[    6.556860] iommu: Adding device 0000:7f:09.2 to group 20
[    6.563212] iommu: Adding device 0000:7f:09.3 to group 20
[    6.569636] iommu: Adding device 0000:7f:0b.0 to group 21
[    6.575988] iommu: Adding device 0000:7f:0b.1 to group 21
[    6.582342] iommu: Adding device 0000:7f:0b.2 to group 21
[    6.588699] iommu: Adding device 0000:7f:0b.3 to group 21
[    6.595195] iommu: Adding device 0000:7f:0c.0 to group 22
[    6.601548] iommu: Adding device 0000:7f:0c.1 to group 22
[    6.607900] iommu: Adding device 0000:7f:0c.2 to group 22
[    6.614246] iommu: Adding device 0000:7f:0c.3 to group 22
[    6.620593] iommu: Adding device 0000:7f:0c.4 to group 22
[    6.626944] iommu: Adding device 0000:7f:0c.5 to group 22
[    6.633294] iommu: Adding device 0000:7f:0c.6 to group 22
[    6.639646] iommu: Adding device 0000:7f:0c.7 to group 22
[    6.646106] iommu: Adding device 0000:7f:0d.0 to group 23
[    6.652462] iommu: Adding device 0000:7f:0d.1 to group 23
[    6.658813] iommu: Adding device 0000:7f:0d.2 to group 23
[    6.665167] iommu: Adding device 0000:7f:0d.3 to group 23
[    6.671529] iommu: Adding device 0000:7f:0d.4 to group 23
[    6.677876] iommu: Adding device 0000:7f:0d.5 to group 23
[    6.684354] iommu: Adding device 0000:7f:0f.0 to group 24
[    6.690711] iommu: Adding device 0000:7f:0f.1 to group 24
[    6.697060] iommu: Adding device 0000:7f:0f.2 to group 24
[    6.703417] iommu: Adding device 0000:7f:0f.3 to group 24
[    6.709767] iommu: Adding device 0000:7f:0f.4 to group 24
[    6.716118] iommu: Adding device 0000:7f:0f.5 to group 24
[    6.722473] iommu: Adding device 0000:7f:0f.6 to group 24
[    6.728917] iommu: Adding device 0000:7f:10.0 to group 25
[    6.735269] iommu: Adding device 0000:7f:10.1 to group 25
[    6.741623] iommu: Adding device 0000:7f:10.5 to group 25
[    6.747974] iommu: Adding device 0000:7f:10.6 to group 25
[    6.754330] iommu: Adding device 0000:7f:10.7 to group 25
[    6.760790] iommu: Adding device 0000:7f:12.0 to group 26
[    6.767145] iommu: Adding device 0000:7f:12.1 to group 26
[    6.773508] iommu: Adding device 0000:7f:12.2 to group 26
[    6.779854] iommu: Adding device 0000:7f:12.4 to group 26
[    6.786207] iommu: Adding device 0000:7f:12.5 to group 26
[    6.792556] iommu: Adding device 0000:7f:12.6 to group 26
[    6.799016] iommu: Adding device 0000:7f:13.0 to group 27
[    6.805371] iommu: Adding device 0000:7f:13.1 to group 27
[    6.811725] iommu: Adding device 0000:7f:13.2 to group 27
[    6.818077] iommu: Adding device 0000:7f:13.3 to group 27
[    6.824432] iommu: Adding device 0000:7f:13.6 to group 27
[    6.830790] iommu: Adding device 0000:7f:13.7 to group 27
[    6.837290] iommu: Adding device 0000:7f:14.0 to group 28
[    6.843643] iommu: Adding device 0000:7f:14.1 to group 28
[    6.849998] iommu: Adding device 0000:7f:14.2 to group 28
[    6.856355] iommu: Adding device 0000:7f:14.3 to group 28
[    6.862804] iommu: Adding device 0000:7f:14.4 to group 28
[    6.869158] iommu: Adding device 0000:7f:14.5 to group 28
[    6.875515] iommu: Adding device 0000:7f:14.6 to group 28
[    6.881872] iommu: Adding device 0000:7f:14.7 to group 28
[    6.888329] iommu: Adding device 0000:7f:16.0 to group 29
[    6.894687] iommu: Adding device 0000:7f:16.1 to group 29
[    6.901044] iommu: Adding device 0000:7f:16.2 to group 29
[    6.907403] iommu: Adding device 0000:7f:16.3 to group 29
[    6.913775] iommu: Adding device 0000:7f:16.6 to group 29
[    6.920128] iommu: Adding device 0000:7f:16.7 to group 29
[    6.926633] iommu: Adding device 0000:7f:17.0 to group 30
[    6.932988] iommu: Adding device 0000:7f:17.1 to group 30
[    6.939347] iommu: Adding device 0000:7f:17.2 to group 30
[    6.945702] iommu: Adding device 0000:7f:17.3 to group 30
[    6.952064] iommu: Adding device 0000:7f:17.4 to group 30
[    6.958425] iommu: Adding device 0000:7f:17.5 to group 30
[    6.970052] iommu: Adding device 0000:7f:17.6 to group 30
[    6.976408] iommu: Adding device 0000:7f:17.7 to group 30
[    6.982849] iommu: Adding device 0000:7f:1e.0 to group 31
[    6.989207] iommu: Adding device 0000:7f:1e.1 to group 31
[    6.995566] iommu: Adding device 0000:7f:1e.2 to group 31
[    7.001922] iommu: Adding device 0000:7f:1e.3 to group 31
[    7.008282] iommu: Adding device 0000:7f:1e.4 to group 31
[    7.014667] iommu: Adding device 0000:7f:1f.0 to group 32
[    7.021024] iommu: Adding device 0000:7f:1f.2 to group 32
[    7.027377] iommu: Adding device 0000:80:01.0 to group 33
[    7.033750] iommu: Adding device 0000:80:02.0 to group 34
[    7.040109] iommu: Adding device 0000:80:03.0 to group 35
[    7.046462] iommu: Adding device 0000:80:03.2 to group 36
[    7.052886] iommu: Adding device 0000:80:05.0 to group 37
[    7.059243] iommu: Adding device 0000:80:05.1 to group 37
[    7.065601] iommu: Adding device 0000:80:05.2 to group 37
[    7.071962] iommu: Adding device 0000:80:05.4 to group 37
[    7.078353] iommu: Adding device 0000:82:00.0 to group 38
[    7.084716] iommu: Adding device 0000:82:00.1 to group 38
[    7.091125] iommu: Adding device 0000:83:00.0 to group 39
[    7.097517] iommu: Adding device 0000:83:00.1 to group 39
[    7.103931] iommu: Adding device 0000:84:00.0 to group 40
[    7.110312] iommu: Adding device 0000:84:00.1 to group 40
[    7.116717] iommu: Adding device 0000:ff:08.0 to group 41
[    7.123077] iommu: Adding device 0000:ff:08.2 to group 41
[    7.129438] iommu: Adding device 0000:ff:08.3 to group 41
[    7.135845] iommu: Adding device 0000:ff:09.0 to group 42
[    7.142203] iommu: Adding device 0000:ff:09.2 to group 42
[    7.148560] iommu: Adding device 0000:ff:09.3 to group 42
[    7.154987] iommu: Adding device 0000:ff:0b.0 to group 43
[    7.161345] iommu: Adding device 0000:ff:0b.1 to group 43
[    7.167703] iommu: Adding device 0000:ff:0b.2 to group 43
[    7.174063] iommu: Adding device 0000:ff:0b.3 to group 43
[    7.180561] iommu: Adding device 0000:ff:0c.0 to group 44
[    7.186921] iommu: Adding device 0000:ff:0c.1 to group 44
[    7.193290] iommu: Adding device 0000:ff:0c.2 to group 44
[    7.199649] iommu: Adding device 0000:ff:0c.3 to group 44
[    7.206010] iommu: Adding device 0000:ff:0c.4 to group 44
[    7.212373] iommu: Adding device 0000:ff:0c.5 to group 44
[    7.218822] iommu: Adding device 0000:ff:0c.6 to group 44
[    7.225182] iommu: Adding device 0000:ff:0c.7 to group 44
[    7.231645] iommu: Adding device 0000:ff:0d.0 to group 45
[    7.238007] iommu: Adding device 0000:ff:0d.1 to group 45
[    7.244369] iommu: Adding device 0000:ff:0d.2 to group 45
[    7.250729] iommu: Adding device 0000:ff:0d.3 to group 45
[    7.257089] iommu: Adding device 0000:ff:0d.4 to group 45
[    7.263453] iommu: Adding device 0000:ff:0d.5 to group 45
[    7.269924] iommu: Adding device 0000:ff:0f.0 to group 46
[    7.276283] iommu: Adding device 0000:ff:0f.1 to group 46
[    7.282646] iommu: Adding device 0000:ff:0f.2 to group 46
[    7.289005] iommu: Adding device 0000:ff:0f.3 to group 46
[    7.295366] iommu: Adding device 0000:ff:0f.4 to group 46
[    7.301726] iommu: Adding device 0000:ff:0f.5 to group 46
[    7.308086] iommu: Adding device 0000:ff:0f.6 to group 46
[    7.314528] iommu: Adding device 0000:ff:10.0 to group 47
[    7.320890] iommu: Adding device 0000:ff:10.1 to group 47
[    7.327257] iommu: Adding device 0000:ff:10.5 to group 47
[    7.333615] iommu: Adding device 0000:ff:10.6 to group 47
[    7.339978] iommu: Adding device 0000:ff:10.7 to group 47
[    7.346440] iommu: Adding device 0000:ff:12.0 to group 48
[    7.352802] iommu: Adding device 0000:ff:12.1 to group 48
[    7.359164] iommu: Adding device 0000:ff:12.2 to group 48
[    7.365529] iommu: Adding device 0000:ff:12.4 to group 48
[    7.371892] iommu: Adding device 0000:ff:12.5 to group 48
[    7.378256] iommu: Adding device 0000:ff:12.6 to group 48
[    7.384717] iommu: Adding device 0000:ff:13.0 to group 49
[    7.391083] iommu: Adding device 0000:ff:13.1 to group 49
[    7.397452] iommu: Adding device 0000:ff:13.2 to group 49
[    7.403886] iommu: Adding device 0000:ff:13.3 to group 49
[    7.410250] iommu: Adding device 0000:ff:13.6 to group 49
[    7.416614] iommu: Adding device 0000:ff:13.7 to group 49
[    7.423111] iommu: Adding device 0000:ff:14.0 to group 50
[    7.429476] iommu: Adding device 0000:ff:14.1 to group 50
[    7.435838] iommu: Adding device 0000:ff:14.2 to group 50
[    7.442204] iommu: Adding device 0000:ff:14.3 to group 50
[    7.448567] iommu: Adding device 0000:ff:14.4 to group 50
[    7.454933] iommu: Adding device 0000:ff:14.5 to group 50
[    7.461294] iommu: Adding device 0000:ff:14.6 to group 50
[    7.467661] iommu: Adding device 0000:ff:14.7 to group 50
[    7.474125] iommu: Adding device 0000:ff:16.0 to group 51
[    7.480492] iommu: Adding device 0000:ff:16.1 to group 51
[    7.486856] iommu: Adding device 0000:ff:16.2 to group 51
[    7.493223] iommu: Adding device 0000:ff:16.3 to group 51
[    7.499589] iommu: Adding device 0000:ff:16.6 to group 51
[    7.505956] iommu: Adding device 0000:ff:16.7 to group 51
[    7.512462] iommu: Adding device 0000:ff:17.0 to group 52
[    7.518823] iommu: Adding device 0000:ff:17.1 to group 52
[    7.525191] iommu: Adding device 0000:ff:17.2 to group 52
[    7.531551] iommu: Adding device 0000:ff:17.3 to group 52
[    7.537917] iommu: Adding device 0000:ff:17.4 to group 52
[    7.544283] iommu: Adding device 0000:ff:17.5 to group 52
[    7.550647] iommu: Adding device 0000:ff:17.6 to group 52
[    7.557015] iommu: Adding device 0000:ff:17.7 to group 52
[    7.563466] iommu: Adding device 0000:ff:1e.0 to group 53
[    7.569832] iommu: Adding device 0000:ff:1e.1 to group 53
[    7.576193] iommu: Adding device 0000:ff:1e.2 to group 53
[    7.582560] iommu: Adding device 0000:ff:1e.3 to group 53
[    7.588945] iommu: Adding device 0000:ff:1e.4 to group 53
[    7.595331] iommu: Adding device 0000:ff:1f.0 to group 54
[    7.601702] iommu: Adding device 0000:ff:1f.2 to group 54
[    7.608892] Intel CQM monitoring enabled
[    7.613571] Intel MBM enabled
[    7.618356] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    7.627738] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    7.634452] RAPL PMU: hw unit of domain package 2^-14 Joules
[    7.641078] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    7.647411] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    7.657410] audit: initializing netlink subsys (disabled)
[    7.663796] audit: type=2000 audit(1493111471.517:1): state=initialized audit_enabled=0 res=1
[    7.664275] Initialise system trusted keyrings
[    7.664378] workingset: timestamp_bits=39 max_order=26 bucket_order=0
[    7.922929] Key type asymmetric registered
[    7.927811] Asymmetric key parser 'x509' registered
[    7.933566] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    7.942462] io scheduler noop registered
[    7.947134] io scheduler deadline registered
[    7.952226] io scheduler cfq registered (default)
[    7.957767] io scheduler mq-deadline registered
[    7.967514] pcieport 0000:00:01.0: Signaling PME with IRQ 26
[    7.974141] pcieport 0000:00:02.0: Signaling PME with IRQ 27
[    7.980761] pcieport 0000:00:03.0: Signaling PME with IRQ 28
[    7.987386] pcieport 0000:00:03.1: Signaling PME with IRQ 29
[    7.994012] pcieport 0000:00:03.2: Signaling PME with IRQ 30
[    8.000641] pcieport 0000:00:1c.0: Signaling PME with IRQ 31
[    8.007272] pcieport 0000:00:1c.7: Signaling PME with IRQ 32
[    8.013901] pcieport 0000:80:01.0: Signaling PME with IRQ 33
[    8.020530] pcieport 0000:80:02.0: Signaling PME with IRQ 34
[    8.027157] pcieport 0000:80:03.0: Signaling PME with IRQ 35
[    8.033784] pcieport 0000:80:03.2: Signaling PME with IRQ 36
[    8.042991] ERST: Error Record Serialization Table (ERST) support is initialized.
[    8.051889] pstore: using zlib compression
[    8.056763] pstore: Registered erst as persistent store backend
[    8.064068] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
[    8.072891] ioatdma: Intel(R) QuickData Technology Driver 4.00
[    8.079810] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    8.107666] 00:02: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    8.136915] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    8.148759] i8042: PNP: No PS/2 controller found.
[    8.154347] rtc_cmos 00:00: RTC can wake from S4
[    8.159940] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    8.167077] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    8.176151] intel_pstate: Intel P-state driver initializing
[    8.185467] NET: Registered protocol family 10
[    8.191172] Segment Routing with IPv6
[    8.195583] NET: Registered protocol family 17
[    8.200843] Key type dns_resolver registered
[    8.211159] microcode: sig=0x406f1, pf=0x1, revision=0xb00001e
[    8.219705] microcode: Microcode Update Driver: v2.2.
[    8.219798] registered taskstats version 1
[    8.230641] Loading compiled-in X.509 certificates
[    8.237965] alg: No test for pkcs1pad(rsa,sha256) (pkcs1pad(rsa-generic,sha256))
[    8.247421] Loaded X.509 cert 'CoreOS, Inc: Module signing key for 4.11.0-rc7-coreos: ea21eedf6d987ed1164de89c738ac1f7e1a2dba9'
[    8.260775] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
[    8.270397] rtc_cmos 00:00: setting system clock to 2017-04-25 09:11:16 UTC (1493111476)
[    8.289984] Freeing unused kernel memory: 31788K
[    8.295460] Write protecting the kernel read-only data: 12288k
[    8.303192] Freeing unused kernel memory: 1980K
[    8.311314] Freeing unused kernel memory: 1496K
[    8.319391] Unable to open file: /etc/ima/ima-policy (-2)
[    8.319394] IMA: policy update failed
[    8.330149] audit: type=1802 audit(1493111476.558:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel op="policy_update" cause="failed" comm="systemd" res=0
[    8.348873] systemd[1]: Failed to insert module 'ip_tables': Function not implemented
[    8.399818] random: systemd: uninitialized urandom read (16 bytes read)
[    8.407857] random: systemd: uninitialized urandom read (16 bytes read)
[    8.415548] random: systemd: uninitialized urandom read (16 bytes read)
[    8.428502] systemd[1]: systemd 233 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT -GNUTLS -ACL +XZ -LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD -IDN default-hierarchy=legacy)
[    8.457802] systemd[1]: Detected architecture x86-64.
[    8.463746] systemd[1]: Running in initial RAM disk.
[    8.470736] systemd[1]: No hostname configured.
[    8.476114] systemd[1]: Set hostname to <localhost>.
[    8.481974] random: systemd: uninitialized urandom read (16 bytes read)
[    8.489663] systemd[1]: Initializing machine ID from random generator.
[    8.499904] random: systemd: uninitialized urandom read (16 bytes read)
[    8.508543] random: systemd: uninitialized urandom read (16 bytes read)
[    8.509771] random: systemd-cryptse: uninitialized urandom read (16 bytes read)
[    8.527906] random: systemd: uninitialized urandom read (16 bytes read)
[    8.535611] random: systemd: uninitialized urandom read (16 bytes read)
[    8.543325] random: systemd: uninitialized urandom read (16 bytes read)
[    8.555486] systemd[1]: Reached target Swap.
[    8.561417] systemd[1]: Listening on Journal Audit Socket.
[    8.568896] systemd[1]: Created slice System Slice.
[    8.575405] systemd[1]: Reached target Slices.
[    8.598993] audit: type=1130 audit(1493111476.826:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    8.633242] audit: type=1130 audit(1493111476.861:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    8.656474] device-mapper: uevent: version 1.0.3
[    8.656543] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    8.675467] audit: type=1130 audit(1493111476.903:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    8.688057] tsc: Refined TSC clocksource calibration: 2599.997 MHz
[    8.688077] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x257a391c223, max_idle_ns: 440795220104 ns
[    8.719844] audit: type=1130 audit(1493111476.947:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    8.747453] audit: type=1130 audit(1493111476.975:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udevd comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    8.776460] audit: type=1130 audit(1493111477.004:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-networkd comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    8.805457] audit: type=1130 audit(1493111477.033:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-trigger comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    8.867583] audit: type=1130 audit(1493111477.095:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-resolved comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    8.894786] pps_core: LinuxPPS API ver. 1 registered
[    8.894786] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    8.911782] SCSI subsystem initialized
[    8.916653] PTP clock support registered
[    8.923731] ACPI: bus type USB registered
[    8.923747] usbcore: registered new interface driver usbfs
[    8.923754] megasas: 07.701.17.00-rc1
[    8.923756] usbcore: registered new interface driver hub
[    8.923937] usbcore: registered new device driver usb
[    8.925346] megaraid_sas 0000:03:00.0: FW now in Ready state
[    8.926030] megaraid_sas 0000:03:00.0: firmware supports msix        : (96)
[    8.926032] megaraid_sas 0000:03:00.0: current msix/online cpus      : (56/56)
[    8.926033] megaraid_sas 0000:03:00.0: RDPQ mode     : (disabled)
[    8.926035] megaraid_sas 0000:03:00.0: Current firmware maximum commands: 928         LDIO threshold: 0
[    8.929388] megaraid_sas 0000:03:00.0: FW supports sync cache        : No
[    8.951025] megaraid_sas 0000:03:00.0: Init cmd success
[    8.973051] megaraid_sas 0000:03:00.0: firmware type : Extended VD(240 VD)firmware
[    8.973052] megaraid_sas 0000:03:00.0: controller type       : MR(1024MB)
[    8.973053] megaraid_sas 0000:03:00.0: Online Controller Reset(OCR)  : Enabled
[    8.973054] megaraid_sas 0000:03:00.0: Secure JBOD support   : No
[    8.995399] megaraid_sas 0000:03:00.0: INIT adapter done
[    8.995401] megaraid_sas 0000:03:00.0: Jbod map is not supported megasas_setup_jbod_map 5092
[    9.000025] megaraid_sas 0000:03:00.0: pci id                : (0x1000)/(0x005d)/(0x1028)/(0x1f49)
[    9.000026] megaraid_sas 0000:03:00.0: unevenspan support    : yes
[    9.000026] megaraid_sas 0000:03:00.0: firmware crash dump   : no
[    9.000027] megaraid_sas 0000:03:00.0: jbod sync map         : no
[    9.000029] scsi host0: Avago SAS based MegaRAID driver
[    9.001143] scsi 0:0:0:0: Direct-Access     ATA      INTEL SSDSC2BX80 DL2B PQ: 0 ANSI: 6
[    9.098231] tg3.c:v3.137 (May 11, 2014)
[    9.103072] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    9.110342] tg3 0000:01:00.0 eth0: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address 18:66:da:f0:43:18
[    9.110343] tg3 0000:01:00.0 eth0: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    9.110344] tg3 0000:01:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[    9.110345] tg3 0000:01:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[    9.122214] tg3 0000:01:00.1 eth1: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address 18:66:da:f0:43:19
[    9.122216] tg3 0000:01:00.1 eth1: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    9.122217] tg3 0000:01:00.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[    9.122218] tg3 0000:01:00.1 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
[    9.134221] tg3 0000:02:00.0 eth2: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address 18:66:da:f0:43:1a
[    9.134222] tg3 0000:02:00.0 eth2: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    9.134223] tg3 0000:02:00.0 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[    9.134224] tg3 0000:02:00.0 eth2: dma_rwctrl[00000001] dma_mask[64-bit]
[    9.146254] tg3 0000:02:00.1 eth3: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address 18:66:da:f0:43:1b
[    9.146256] tg3 0000:02:00.1 eth3: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    9.146257] tg3 0000:02:00.1 eth3: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[    9.146259] tg3 0000:02:00.1 eth3: dma_rwctrl[00000001] dma_mask[64-bit]
[    9.280004] mlx5_core 0000:83:00.0: firmware version: 12.16.1020
[    9.280310] ehci-pci: EHCI PCI platform driver
[    9.280579] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    9.280588] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    9.280614] ehci-pci 0000:00:1a.0: debug port 2
[    9.281230] AVX2 version of gcm_enc/dec engaged.
[    9.281231] AES CTR mode by8 optimization enabled
[    9.284543] ehci-pci 0000:00:1a.0: irq 18, io mem 0x91e03000
[    9.291992] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    9.292134] hub 1-0:1.0: USB hub found
[    9.292137] hub 1-0:1.0: 2 ports detected
[    9.292388] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    9.292393] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    9.292415] ehci-pci 0000:00:1d.0: debug port 2
[    9.296346] ehci-pci 0000:00:1d.0: irq 18, io mem 0x91e02000
[    9.303040] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    9.303160] hub 2-0:1.0: USB hub found
[    9.303165] hub 2-0:1.0: 2 ports detected
[    9.303591] ahci 0000:00:11.4: SSS flag set, parallel bus scan disabled
[    9.303644] ahci 0000:00:11.4: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0xf impl SATA mode
[    9.303646] ahci 0000:00:11.4: flags: 64bit ncq stag led clo pio slum part ems apst
[    9.314249] scsi host1: ahci
[    9.314393] scsi host2: ahci
[    9.314496] scsi host3: ahci
[    9.314594] scsi host4: ahci
[    9.314616] ata1: SATA max UDMA/133 abar m2048@0x91e01000 port 0x91e01100 irq 106
[    9.314618] ata2: SATA max UDMA/133 abar m2048@0x91e01000 port 0x91e01180 irq 106
[    9.314620] ata3: SATA max UDMA/133 abar m2048@0x91e01000 port 0x91e01200 irq 106
[    9.314621] ata4: SATA max UDMA/133 abar m2048@0x91e01000 port 0x91e01280 irq 106
[    9.314802] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    9.314859] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    9.314860] ahci 0000:00:1f.2: flags: 64bit ncq stag led clo pio slum part ems apst
[    9.332415] scsi host5: ahci
[    9.332546] scsi host6: ahci
[    9.332673] scsi host7: ahci
[    9.332795] scsi host8: ahci
[    9.332921] scsi host9: ahci
[    9.333230] scsi host10: ahci
[    9.333253] ata5: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e00100 irq 107
[    9.333254] ata6: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e00180 irq 107
[    9.333255] ata7: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e00200 irq 107
[    9.333257] ata8: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e00280 irq 107
[    9.333258] ata9: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e00300 irq 107
[    9.333260] ata10: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e00380 irq 107
[    9.408495] IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
[    9.608962] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    9.616958] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    9.621446] ata1: SATA link down (SStatus 0 SControl 300)
[    9.638420] ata5: SATA link down (SStatus 0 SControl 300)
[    9.731701] clocksource: Switched to clocksource tsc
[    9.731724] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    9.747425] hub 1-1:1.0: USB hub found
[    9.750136] random: fast init done
[    9.756012] hub 2-1:1.0: USB hub found
[    9.760533] hub 2-1:1.0: 8 ports detected
[    9.765352] hub 1-1:1.0: 6 ports detected
[    9.855554] IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
[    9.872704] mlx5_core 0000:83:00.1: firmware version: 12.16.1020
[    9.984712] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   10.039956] usb 1-1.6: new high-speed USB device number 3 using ehci-pci
[   10.069575] ata2: SATA link down (SStatus 0 SControl 300)
[   10.127134] hub 1-1.6:1.0: USB hub found
[   10.132069] hub 1-1.6:1.0: 6 ports detected
[   10.381651] ata3: SATA link down (SStatus 0 SControl 300)
[   10.433566] mlx5_core 0000:84:00.0: firmware version: 12.16.1020
[   10.701680] ata4: SATA link down (SStatus 0 SControl 300)
[   11.008193] mlx5_core 0000:84:00.1: firmware version: 12.16.1020
[   11.013684] ata6: SATA link down (SStatus 0 SControl 300)
[   11.325625] ata7: SATA link down (SStatus 0 SControl 300)
[   11.637579] ata8: SATA link down (SStatus 0 SControl 300)
[   11.949597] ata9: SATA link down (SStatus 0 SControl 300)
[   12.261474] ata10: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   12.272293] ata10.00: ATAPI: PLDS DVD+/-RW DS-8ABSH, LD51, max UDMA/133
[   12.283168] ata10.00: configured for UDMA/133
[   12.299959] scsi 10:0:0:0: CD-ROM            PLDS     DVD+-RW DS-8ABSH LD51 PQ: 0 ANSI: 5
[   12.332314] sd 0:0:0:0: [sda] 1562824368 512-byte logical blocks: (800 GB/745 GiB)
[   12.341306] sd 0:0:0:0: [sda] 4096-byte physical blocks
[   12.348229] sd 0:0:0:0: [sda] Write Protect is off
[   12.352236] sr 10:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[   12.352237] cdrom: Uniform CD-ROM driver Revision: 3.20
[   12.371133] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   12.388006]  sda: sda1 sda2 sda3 sda4 sda6 sda7 sda9
[   12.399341] sd 0:0:0:0: [sda] Attached SCSI disk
[   13.347037] tg3 0000:01:00.0 eth0: Link is up at 1000 Mbps, full duplex
[   13.354715] tg3 0000:01:00.0 eth0: Flow control is on for TX and on for RX
[   13.362691] tg3 0000:01:00.0 eth0: EEE is disabled
[   13.368336] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   13.443577] tg3 0000:01:00.1 eth1: Link is up at 1000 Mbps, full duplex
[   13.451264] tg3 0000:01:00.1 eth1: Flow control is off for TX and off for RX
[   13.459436] tg3 0000:01:00.1 eth1: EEE is enabled
[   13.464996] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   15.111652] kauditd_printk_skb: 7 callbacks suppressed
[   15.117682] audit: type=1130 audit(1493111483.341:14): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=ignition-disks comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.140676] audit: type=1131 audit(1493111483.341:15): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=ignition-disks comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.184585] loop: module loaded
[   15.214513] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   15.244178] audit: type=1130 audit(1493111483.473:16): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-setup-root comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.244180] audit: type=1131 audit(1493111483.473:17): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-setup-root comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.293167] audit: type=1130 audit(1493111483.522:18): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=ignition-files comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.293175] audit: type=1131 audit(1493111483.522:19): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=ignition-files comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.374263] audit: type=1130 audit(1493111483.603:20): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-parse-etc comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.374264] audit: type=1131 audit(1493111483.603:21): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-parse-etc comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.435308] audit: type=1130 audit(1493111483.664:22): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-pivot comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.462460] audit: type=1131 audit(1493111483.692:23): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-pivot comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   16.036891] systemd-journald[500]: Received SIGTERM from PID 1 (systemd).
[   16.048151] systemd: 21 output lines suppressed due to ratelimiting
[   16.120544] SELinux:  Permission validate_trans in class security not defined in policy.
[   16.130107] SELinux:  Permission module_load in class system not defined in policy.
[   16.139230] SELinux:  Class cap_userns not defined in policy.
[   16.145942] SELinux:  Class cap2_userns not defined in policy.
[   16.152754] SELinux:  Class sctp_socket not defined in policy.
[   16.159558] SELinux:  Class icmp_socket not defined in policy.
[   16.166368] SELinux:  Class ax25_socket not defined in policy.
[   16.173250] SELinux:  Class ipx_socket not defined in policy.
[   16.179963] SELinux:  Class netrom_socket not defined in policy.
[   16.186968] SELinux:  Class atmpvc_socket not defined in policy.
[   16.193974] SELinux:  Class x25_socket not defined in policy.
[   16.200688] SELinux:  Class rose_socket not defined in policy.
[   16.207496] SELinux:  Class decnet_socket not defined in policy.
[   16.214502] SELinux:  Class atmsvc_socket not defined in policy.
[   16.221506] SELinux:  Class rds_socket not defined in policy.
[   16.228220] SELinux:  Class irda_socket not defined in policy.
[   16.235028] SELinux:  Class pppox_socket not defined in policy.
[   16.241937] SELinux:  Class llc_socket not defined in policy.
[   16.248650] SELinux:  Class can_socket not defined in policy.
[   16.255364] SELinux:  Class tipc_socket not defined in policy.
[   16.262172] SELinux:  Class bluetooth_socket not defined in policy.
[   16.269465] SELinux:  Class iucv_socket not defined in policy.
[   16.276273] SELinux:  Class rxrpc_socket not defined in policy.
[   16.283178] SELinux:  Class isdn_socket not defined in policy.
[   16.289987] SELinux:  Class phonet_socket not defined in policy.
[   16.296990] SELinux:  Class ieee802154_socket not defined in policy.
[   16.304382] SELinux:  Class caif_socket not defined in policy.
[   16.311191] SELinux:  Class alg_socket not defined in policy.
[   16.317903] SELinux:  Class nfc_socket not defined in policy.
[   16.324615] SELinux:  Class vsock_socket not defined in policy.
[   16.331520] SELinux:  Class kcm_socket not defined in policy.
[   16.338233] SELinux:  Class qipcrtr_socket not defined in policy.
[   16.345334] SELinux:  Class smc_socket not defined in policy.
[   16.352051] SELinux: the above unknown classes and permissions will be allowed
[   16.373789] systemd[1]: Successfully loaded SELinux policy in 270.258ms.
[   16.381593] Unable to open file: /etc/ima/ima-policy (-2)
[   16.381597] IMA: policy update failed
[   16.399539] ip_tables: (C) 2000-2006 Netfilter Core Team
[   16.416463] systemd[1]: Relabelled /dev and /run in 4.960ms.
[   16.545232] mlx5_ib: Mellanox Connect-IB Infiniband driver v2.2-1 (Feb 2014)
[   16.560775] systemd-journald[1588]: Received request to flush runtime journal from PID 1
[   16.675432] random: crng init done
[   16.745750] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[   16.754548] ACPI: Power Button [PWRF]
[   16.781051] ipmi message handler version 39.2
[   16.790911] tg3 0000:02:00.0 eno3: renamed from eth2
[   16.812533] tg3 0000:01:00.1 eno2: renamed from eth1
[   16.837825] ipmi device interface
[   16.838836] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[   16.839053] mei_me 0000:00:16.0: Device doesn't have valid ME Interface
[   16.841989] IPMI System Interface driver.
[   16.842017] ipmi_si: probing via SMBIOS
[   16.842018] ipmi_si: SMBIOS: io 0xca8 regsize 1 spacing 4 irq 10
[   16.842019] ipmi_si: Adding SMBIOS-specified kcs state machine
[   16.842020] ipmi_si: Trying SMBIOS-specified kcs state machine at i/o address 0xca8, slave address 0x20, irq 10
[   16.896656] tg3 0000:02:00.1 eno4: renamed from eth3
[   16.934297] tg3 0000:01:00.0 eno1: renamed from eth0
[   16.960258] EDAC MC: Ver: 3.0.0
[   16.965222] ipmi_si ipmi_si.0: The BMC does not support setting the recv irq bit, compensating, but the BMC needs to be fixed.
[   16.983872] [drm] radeon kernel modesetting enabled.
[   16.989879] EDAC MC0: Giving out device to module sbridge_edac.c controller Broadwell Socket#0: DEV 0000:7f:12.0 (INTERRUPT)
[   16.989883] AMD IOMMUv2 driver by Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
[   16.989883] AMD IOMMUv2 functionality not available on this system
[   16.996263] ipmi_si ipmi_si.0: Using irq 10
[   17.022336] EDAC MC1: Giving out device to module sbridge_edac.c controller Broadwell Socket#1: DEV 0000:ff:12.0 (INTERRUPT)
[   17.022484] CRAT table not found
[   17.022484] Finished initializing topology ret=0
[   17.022577] kfd kfd: Initialized module
[   17.039425] ipmi_si ipmi_si.0: Found new BMC (man_id: 0x0002a2, prod_id: 0x0100, dev_id: 0x20)
[   17.039460] ipmi_si ipmi_si.0: IPMI kcs interface initialized
[   17.059585] radeon 0000:82:00.0: enabling device (0000 -> 0003)
[   17.066401] [drm] initializing kernel modesetting (CAICOS 0x1002:0x6779 0x174B:0xA004 0x00).
[   17.066425] [drm] register mmio base: 0xD0000000
[   17.066426] [drm] register mmio size: 131072
[   17.093647] EDAC sbridge:  Ver: 1.1.1
[   17.098288] IPMI SSIF Interface driver
[   18.029334] ATOM BIOS: R5
[   18.032634] [drm] GPU not posted. posting now...
[   18.041052] radeon 0000:82:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[   18.051524] radeon 0000:82:00.0: GTT: 1024M 0x0000000040000000 - 0x000000007FFFFFFF
[   18.060603] [drm] Detected VRAM RAM=1024M, BAR=256M
[   18.066337] [drm] RAM width 64bits DDR
[   18.070993] [TTM] Zone  kernel: Available graphics memory: 132062610 kiB
[   18.078785] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[   18.086407] [TTM] Initializing pool allocator
[   18.091576] [TTM] Initializing DMA pool allocator
[   18.097156] [drm] radeon: 1024M of VRAM memory ready
[   18.103043] [drm] radeon: 1024M of GTT memory ready.
[   18.108924] [drm] Loading CAICOS Microcode
[   18.116062] [drm] Internal thermal controller without fan control
[   18.127467] [drm] radeon: dpm initialized
[   18.134507] [drm] GART: num cpu pages 262144, num gpu pages 262144
[   18.142589] [drm] enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0
[   18.154188] [drm] PCIE GART of 1024M enabled (table at 0x0000000000162000).
[   18.162390] radeon 0000:82:00.0: WB enabled
[   18.167362] radeon 0000:82:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0xffff95c72bbcac00
[   18.179942] radeon 0000:82:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0xffff95c72bbcac0c
[   18.193330] radeon 0000:82:00.0: fence driver on ring 5 use gpu addr 0x0000000000072118 and cpu addr 0xffffb1d25be32118
[   18.205924] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   18.213634] [drm] Driver supports precise vblank timestamp query.
[   18.220741] radeon 0000:82:00.0: radeon: MSI limited to 32-bit
[   18.227604] radeon 0000:82:00.0: radeon: using MSI.
[   18.233389] [drm] radeon: irq initialized.
[   18.254965] [drm] ring test on 0 succeeded in 3 usecs
[   18.260933] [drm] ring test on 3 succeeded in 6 usecs
[   18.444176] [drm] ring test on 5 succeeded in 2 usecs
[   18.450138] [drm] UVD initialized successfully.
[   18.455692] [drm] ib test on ring 0 succeeded in 0 usecs
[   18.461995] [drm] ib test on ring 3 succeeded in 0 usecs
[   19.127018] [drm] ib test on ring 5 succeeded
[   19.132668] [drm] Radeon Display Connectors
[   19.137642] [drm] Connector 0:
[   19.141349] [drm]   HDMI-A-1
[   19.144950] [drm]   HPD2
[   19.148075] [drm]   DDC: 0x6440 0x6440 0x6444 0x6444 0x6448 0x6448 0x644c 0x644c
[   19.156851] [drm]   Encoders:
[   19.160459] [drm]     DFP1: INTERNAL_UNIPHY1
[   19.165526] [drm] Connector 1:
[   19.169234] [drm]   DVI-D-1
[   19.172646] [drm]   HPD4
[   19.175767] [drm]   DDC: 0x6460 0x6460 0x6464 0x6464 0x6468 0x6468 0x646c 0x646c
[   19.184550] [drm]   Encoders:
[   19.188155] [drm]     DFP2: INTERNAL_UNIPHY
[   19.193125] [drm] Connector 2:
[   19.196833] [drm]   VGA-1
[   19.200053] [drm]   DDC: 0x6430 0x6430 0x6434 0x6434 0x6438 0x6438 0x643c 0x643c
[   19.208836] [drm]   Encoders:
[   19.212446] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[   19.233311] [drm] Cannot find any crtc or sizes - going 1024x768
[   19.242339] [drm] fb mappable at 0x3FFF0363000
[   19.247590] [drm] vram apper at 0x3FFF0000000
[   19.252750] [drm] size 3145728
[   19.256456] [drm] fb depth is 24
[   19.260350] [drm]    pitch is 4096
[   19.272098] Console: switching to colour frame buffer device 128x48
[   19.281147] radeon 0000:82:00.0: fb0: radeondrmfb frame buffer device
[   19.289102] [drm] Initialized radeon 2.49.0 20080528 for 0000:82:00.0 on minor 0
[   19.689946] IPv6: ADDRCONF(NETDEV_UP): ib3: link is not ready
[   19.697344] IPv6: ADDRCONF(NETDEV_UP): ib2: link is not ready
[   19.705346] IPv6: ADDRCONF(NETDEV_UP): ib1: link is not ready
[   19.706241] IPv6: ADDRCONF(NETDEV_UP): ib0: link is not ready
[   19.830253] IPv6: ADDRCONF(NETDEV_UP): eno4: link is not ready
[   19.962510] IPv6: ADDRCONF(NETDEV_UP): eno3: link is not ready
[   20.092999] IPv6: ADDRCONF(NETDEV_UP): eno2: link is not ready
[   20.224713] IPv6: ADDRCONF(NETDEV_UP): eno1: link is not ready
[   23.039697] tg3 0000:01:00.1 eno2: Link is up at 1000 Mbps, full duplex
[   23.047506] tg3 0000:01:00.1 eno2: Flow control is off for TX and off for RX
[   23.055788] tg3 0000:01:00.1 eno2: EEE is enabled
[   23.061461] IPv6: ADDRCONF(NETDEV_CHANGE): eno2: link becomes ready
[   23.820038] tg3 0000:01:00.0 eno1: Link is up at 1000 Mbps, full duplex
[   23.827853] tg3 0000:01:00.0 eno1: Flow control is on for TX and on for RX
[   23.835955] tg3 0000:01:00.0 eno1: EEE is disabled
[   23.841741] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready


--nextPart4354749.MxMgfExfD9--

--nextPart2842166.hcU9T0tpOo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQG0BAABCAAGBQJY/yVkAAoJENS5dBsVnRQd4I4MvR2oVArgy19uApCo2AFwW3CW
uw9wb1/JWExr+ag1UEgTLyAU0AilaUWfmiTk5/Vhrejs4d60m/oDTLXUkjBXBGZ+
5XuWrWjYYURFRRELDzcVWqwtyxUTtcT7L6Pf6QoV1Uc6ODqPHBAUEa9zvXR73Vol
zM34eVwNgtWkVszMCq+TQewFnP1N6FnCJV87qBlzip4JCjz6g5Yc2xiaU5PW6xLY
d76MQvSqLiSNFSjhfoQKFwrcvTook3rUHqLj2aZsUIif8zx8hIgBB4Zrmv9q9moT
rgu0bEbqkJqzVt9BE3o6+KEtrJYqhfzqHworMUQx/RM19NcBQyJ2o6ZiXKHR3D/B
e3jlFHhbO5YmqWjU2xfcX96tgA9sWL78ZCHs+Ovvi6Pdts+KnwrMfxXHm5owlOrt
4AxsYJNMzGe6ohTcyfzyBMLEu9Izb5OLi4bloiav8+l7lwWpHAvQCaM5nOIn1DqT
AxJcACxknvW3MTaFhe3Qjdj1aAgCkaq4T5ptwl+r4/S2EHcTqwm3JWnjNn/7BGF8
XJ3dEbgyYw==
=2ZMB
-----END PGP SIGNATURE-----

--nextPart2842166.hcU9T0tpOo--


--===============1899266092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1899266092==--
