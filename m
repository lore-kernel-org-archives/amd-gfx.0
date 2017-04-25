From: Dennis Schridde <dennis.schridde-axtXthT+lymYbFdUjOg7S7NAH6kLmebB@public.gmane.org>
Subject: Re: amdgpu 0000:84:00.0: gpu post error! \\ Fatal error during GPU
 init
Date: Tue, 25 Apr 2017 18:04:41 +0200
Message-ID: <4561792.YoK0i4xGe1@c07060>
References: <6570445.DKuzpyIqJk@c07060> <1899542.UKOkCCEGMz@c07060>
 <BN6PR12MB1652379C4E200C105F186921F71E0@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0066720288=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652379C4E200C105F186921F71E0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0066720288==
Content-Type: multipart/signed; boundary="nextPart1793462.Hr3FWkTLFR"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart1793462.Hr3FWkTLFR
Content-Type: multipart/mixed; boundary="nextPart4324970.2gPpy4JKQ1"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart4324970.2gPpy4JKQ1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 25. April 2017 16:02:11 CEST Deucher, Alexander wrote:
> > On Dienstag, 25. April 2017 10:51:09 CEST Dennis Schridde wrote:
> > > I replaced the AMD FirePro S7150X2 card with a AMD Radeon R5 230 (the
> > > only
> > > other AMD card we had available), to see whether the problem was caused
> > > by
> > > another hardware component of the system.
> > > 
> > > The kernel boots fine with this card. I see no errors in the log
> > > (attached).> 
> > The kernel used until now as a 4.10.9.
> > 
> > I tried again using 4.11.0_rc7, which shows the same behaviour.
> 
> Does the card work in a different system?

I only have an identical Dell PowerEdge R730xd system that is able to hold 
this card. On that other machine, the same error occurs.

--Dennis
--nextPart4324970.2gPpy4JKQ1
Content-Disposition: attachment; filename="node-amd-kernel-v4.11.0_rc7-firepro-s7150x2-oops-other-machine.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="UTF-8"; name="node-amd-kernel-v4.11.0_rc7-firepro-s7150x2-oops-other-machine.log"

[    0.000000] Linux version 4.11.0-rc7-coreos (tf128@c07060) (gcc version 4.9.4 (Gentoo Hardened 4.9.4 p1.0, pie-0.6.4) ) #1 SMP Fri Apr 21 22:23:28 CEST 2017
[    0.000000] Command line: coreos.config.url=http://192.168.10.27:8080/ignition?uuid=4c4c4544-0034-3510-8052-b9c04f574732&mac=18-66-da-f0-0d-5c coreos.autologin coreos.first_boot console=ttyS0,115200n8 console=tty0
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
[    0.000000] percpu: Embedded 37 pages/cpu @ffff964dbf600000 s112216 r8192 d31144 u262144
[    0.000000] Built 2 zonelists in Node order, mobility grouping on.  Total pages: 66036651
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: rootflags=rw mount.usrflags=ro coreos.config.url=http://192.168.10.27:8080/ignition?uuid=4c4c4544-0034-3510-8052-b9c04f574732&mac=18-66-da-f0-0d-5c coreos.autologin coreos.first_boot console=ttyS0,115200n8 console=tty0
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
[    0.001000] tsc: Detected 2599.892 MHz processor
[    0.002000] Calibrating delay loop (skipped), value calculated using timer frequency.. 5199.78 BogoMIPS (lpj=2599892)
[    0.003002] pid_max: default: 57344 minimum: 448
[    0.004022] ACPI: Core revision 20170119
[    0.076656] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.077058] Security Framework initialized
[    0.078003] SELinux:  Initializing.
[    0.086915] Dentry cache hash table entries: 33554432 (order: 16, 268435456 bytes)
[    0.131768] Inode-cache hash table entries: 16777216 (order: 15, 134217728 bytes)
[    0.152712] Mount-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.154137] Mountpoint-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.156676] CPU: Physical Processor ID: 0
[    0.157002] CPU: Processor Core ID: 0
[    0.158005] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.159001] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.160005] mce: CPU supports 22 MCE banks
[    0.161016] CPU0: Thermal monitoring enabled (TM1)
[    0.162020] process: using mwait in idle threads
[    0.163004] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.164001] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.165546] Freeing SMP alternatives memory: 24K
[    0.168004] ftrace: allocating 24354 entries in 96 pages
[    0.174084] smpboot: Max logical packages: 4
[    0.175019] DMAR: Host address width 46
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
[    0.186002] DMAR-IR: HPET id 0 under DRHD base 0xc7ffc000
[    0.187002] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out bit.
[    0.187003] DMAR-IR: Use 'intremap=no_x2apic_optout' to override the BIOS setting.
[    0.190620] DMAR-IR: Enabled IRQ remapping in xapic mode
[    0.191000] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.191002] Switched APIC routing to physical flat.
[    0.192620] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.202950] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2690 v4 @ 2.60GHz (family: 0x6, model: 0x4f, stepping: 0x1)
[    0.203106] Performance Events: PEBS fmt2+, Broadwell events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.204002] ... version:                3
[    0.205000] ... bit width:              48
[    0.206000] ... generic registers:      4
[    0.207000] ... value mask:             0000ffffffffffff
[    0.208000] ... max period:             00007fffffffffff
[    0.209000] ... fixed-purpose events:   3
[    0.210000] ... event mask:             000000070000000f
[    0.213761] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.214013] smp: Bringing up secondary CPUs ...
[    0.215079] x86: Booting SMP configuration:
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
[    2.635001] .... node  #0, CPUs:   #40
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
[    3.379001] .... node  #0, CPUs:   #52
[    3.441001] .... node  #1, CPUs:   #53
[    3.503001] .... node  #0, CPUs:   #54
[    3.565001] .... node  #1, CPUs:   #55
[    3.626066] smp: Brought up 2 nodes, 56 CPUs
[    3.628002] smpboot: Total of 56 processors activated (291524.86 BogoMIPS)
[    3.631698] sched_clock: Marking stable (3631000000, 0)->(4322013399, -691013399)
[    3.646502] devtmpfs: initialized
[    3.650538] x86/mm: Memory block size: 2048MB
[    3.657375] PM: Registering ACPI NVS region [mem 0x7af0b000-0x7b93afff] (10682368 bytes)
[    3.667165] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    3.678633] futex hash table entries: 16384 (order: 8, 1048576 bytes)
[    3.686546] pinctrl core: initialized pinctrl subsystem
[    3.693402] NET: Registered protocol family 16
[    3.698777] cpuidle: using governor menu
[    3.703449] PCCT header not found.
[    3.707667] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    3.716644] ACPI: bus type PCI registered
[    3.721416] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    3.728971] dca service started, version 1.12.1
[    3.734342] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    3.750632] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
[    3.758526] PCI: Using configuration type 1 for base access
[    3.765046] PCI: Dell System detected, enabling pci=bfsort.
[    3.773607] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    3.781011] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    3.789137] ACPI: Added _OSI(Module Device)
[    3.794113] ACPI: Added _OSI(Processor Device)
[    3.799382] ACPI: Added _OSI(3.0 _SCP Extensions)
[    3.804936] ACPI: Added _OSI(Processor Aggregator Device)
[    3.907234] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    3.925199] ACPI: Interpreter enabled
[    3.929687] ACPI: (supports S0 S5)
[    3.933782] ACPI: Using IOAPIC for interrupt routing
[    3.939666] HEST: Table parsing has been initialized.
[    3.945607] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    3.965323] ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
[    3.972245] acpi PNP0A03:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    3.981974] acpi PNP0A03:02: PCIe AER handled by firmware
[    3.988396] acpi PNP0A03:02: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    3.997473] acpi PNP0A03:02: FADT indicates ASPM is unsupported, using BIOS configuration
[    4.007160] PCI host bridge to bus 0000:ff
[    4.012035] pci_bus 0000:ff: root bus resource [bus ff]
[    4.020668] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus 7f])
[    4.027587] acpi PNP0A03:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    4.037306] acpi PNP0A03:03: PCIe AER handled by firmware
[    4.043735] acpi PNP0A03:03: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    4.052816] acpi PNP0A03:03: FADT indicates ASPM is unsupported, using BIOS configuration
[    4.062499] PCI host bridge to bus 0000:7f
[    4.067374] pci_bus 0000:7f: root bus resource [bus 7f]
[    4.077229] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
[    4.084437] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    4.094152] acpi PNP0A08:00: PCIe AER handled by firmware
[    4.100581] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    4.109661] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    4.119459] PCI host bridge to bus 0000:00
[    4.124336] pci_bus 0000:00: root bus resource [io  0x0000-0x03bb window]
[    4.132218] pci_bus 0000:00: root bus resource [io  0x03bc-0x03df window]
[    4.140104] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    4.147990] pci_bus 0000:00: root bus resource [io  0x1000-0x7fff window]
[    4.155876] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    4.164767] pci_bus 0000:00: root bus resource [mem 0x90000000-0xc7ffbfff window]
[    4.173642] pci_bus 0000:00: root bus resource [mem 0x38000000000-0x3bfffffffff window]
[    4.183113] pci_bus 0000:00: root bus resource [bus 00-7e]
[    4.189783] pci 0000:00:01.0: System wakeup disabled by ACPI
[    4.196550] pci 0000:00:02.0: System wakeup disabled by ACPI
[    4.203300] pci 0000:00:03.0: System wakeup disabled by ACPI
[    4.210043] pci 0000:00:03.1: System wakeup disabled by ACPI
[    4.216863] pci 0000:00:03.2: System wakeup disabled by ACPI
[    4.224742] pci 0000:00:1c.0: Enabling MPC IRBNCE
[    4.230294] pci 0000:00:1c.0: Intel PCH root port ACS workaround enabled
[    4.238234] pci 0000:00:1c.7: Enabling MPC IRBNCE
[    4.243784] pci 0000:00:1c.7: Intel PCH root port ACS workaround enabled
[    4.251600] pci 0000:00:1c.7: System wakeup disabled by ACPI
[    4.258852] pci 0000:00:01.0: PCI bridge to [bus 03]
[    4.264876] pci 0000:00:02.0: PCI bridge to [bus 04-07]
[    4.271339] pci 0000:04:00.0: PCI bridge to [bus 05-07]
[    4.277676] pci 0000:05:08.0: PCI bridge to [bus 06]
[    4.283717] pci 0000:05:10.0: PCI bridge to [bus 07]
[    4.292580] pci 0000:00:03.0: PCI bridge to [bus 02]
[    4.301447] pci 0000:00:03.1: PCI bridge to [bus 01]
[    4.307319] pci 0000:00:03.2: PCI bridge to [bus 08]
[    4.313195] pci 0000:00:1c.0: PCI bridge to [bus 09]
[    4.327255] pci 0000:00:1c.7: PCI bridge to [bus 0a-0e]
[    4.341129] pci 0000:0a:00.0: PCI bridge to [bus 0b-0e]
[    4.353774] pci 0000:0b:00.0: PCI bridge to [bus 0c-0d]
[    4.366939] pci 0000:0c:00.0: PCI bridge to [bus 0d]
[    4.374143] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 *15)
[    4.382778] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 *14 15)
[    4.391405] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    4.400031] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 9 10 11 12 14 15)
[    4.408655] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    4.418539] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    4.428428] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    4.438313] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    4.448342] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-fe])
[    4.455550] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    4.465257] acpi PNP0A08:01: PCIe AER handled by firmware
[    4.471683] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    4.480760] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using BIOS configuration
[    4.490512] PCI host bridge to bus 0000:80
[    4.495384] pci_bus 0000:80: root bus resource [io  0x8000-0xffff window]
[    4.503266] pci_bus 0000:80: root bus resource [mem 0xc8000000-0xfbffbfff window]
[    4.512173] pci_bus 0000:80: root bus resource [mem 0x3c000000000-0x3ffffffffff window]
[    4.521647] pci_bus 0000:80: root bus resource [bus 80-fe]
[    4.528188] pci 0000:80:01.0: System wakeup disabled by ACPI
[    4.534930] pci 0000:80:02.0: System wakeup disabled by ACPI
[    4.541672] pci 0000:80:03.0: System wakeup disabled by ACPI
[    4.548414] pci 0000:80:03.2: System wakeup disabled by ACPI
[    4.555391] pci 0000:80:01.0: PCI bridge to [bus 81]
[    4.561399] pci 0000:80:02.0: PCI bridge to [bus 82-85]
[    4.567843] pci 0000:82:00.0: PCI bridge to [bus 83-85]
[    4.574169] pci 0000:84:00.0: VF(n) BAR0 space: [mem 0x00000000-0xffffffff 64bit pref] (contains BAR0 for 16 VFs)
[    4.586177] pci 0000:84:00.0: VF(n) BAR2 space: [mem 0x00000000-0x03ffffff 64bit pref] (contains BAR2 for 16 VFs)
[    4.598184] pci 0000:84:00.0: VF(n) BAR5 space: [mem 0x00000000-0x03ffffff] (contains BAR5 for 16 VFs)
[    4.609192] pci 0000:83:08.0: PCI bridge to [bus 84]
[    4.615040] pci 0000:83:08.0: bridge has subordinate 84 but max busn 85
[    4.622914] pci 0000:85:00.0: VF(n) BAR0 space: [mem 0x00000000-0xffffffff 64bit pref] (contains BAR0 for 16 VFs)
[    4.634996] pci 0000:85:00.0: VF(n) BAR2 space: [mem 0x00000000-0x03ffffff 64bit pref] (contains BAR2 for 16 VFs)
[    4.646997] pci 0000:85:00.0: VF(n) BAR5 space: [mem 0x00000000-0x03ffffff] (contains BAR5 for 16 VFs)
[    4.658006] pci 0000:83:10.0: PCI bridge to [bus 85]
[    4.663858] pci 0000:83:10.0: bridge has subordinate 85 but max busn 86
[    4.673586] pci 0000:80:03.0: PCI bridge to [bus 86]
[    4.681453] pci 0000:80:03.2: PCI bridge to [bus 87]
[    4.687366] ACPI: Enabled 2 GPEs in block 00 to 3F
[    4.713162] pci 0000:06:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    4.723026] pci 0000:07:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    4.733019] pci 0000:0d:00.0: vgaarb: setting as boot VGA device
[    4.740027] pci 0000:0d:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    4.750073] pci 0000:84:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    4.759924] pci 0000:85:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    4.769774] pci 0000:85:00.0: vgaarb: bridge control possible
[    4.776489] pci 0000:84:00.0: vgaarb: bridge control possible
[    4.783201] pci 0000:0d:00.0: vgaarb: bridge control possible
[    4.789915] pci 0000:07:00.0: vgaarb: bridge control possible
[    4.796627] pci 0000:06:00.0: vgaarb: bridge control possible
[    4.803340] vgaarb: loaded
[    4.806702] PCI: Using ACPI for IRQ routing
[    4.817942] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    4.825145] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    4.834061] clocksource: Switched to clocksource hpet
[    4.847807] VFS: Disk quotas dquot_6.6.0
[    4.852520] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    4.860582] pnp: PnP ACPI init
[    4.864694] pnp 00:01: disabling [mem 0xfeda8000-0xfedcbfff] because it overlaps 0000:84:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    4.879203] pnp 00:01: disabling [mem 0xff000000-0xffffffff] because it overlaps 0000:84:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    4.893684] pnp 00:01: disabling [mem 0xfee00000-0xfeefffff] because it overlaps 0000:84:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    4.908095] pnp 00:01: disabling [mem 0xfed12000-0xfed1200f] because it overlaps 0000:84:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    4.922510] pnp 00:01: disabling [mem 0xfed12010-0xfed1201f] because it overlaps 0000:84:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    4.936924] pnp 00:01: disabling [mem 0xfed1b000-0xfed1bfff] because it overlaps 0000:84:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    4.951341] pnp 00:01: disabling [mem 0xfeda8000-0xfedcbfff disabled] because it overlaps 0000:85:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    4.966632] pnp 00:01: disabling [mem 0xff000000-0xffffffff disabled] because it overlaps 0000:85:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    4.981927] pnp 00:01: disabling [mem 0xfee00000-0xfeefffff disabled] because it overlaps 0000:85:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    4.997222] pnp 00:01: disabling [mem 0xfed12000-0xfed1200f disabled] because it overlaps 0000:85:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    5.017738] pnp 00:01: disabling [mem 0xfed12010-0xfed1201f disabled] because it overlaps 0000:85:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    5.033030] pnp 00:01: disabling [mem 0xfed1b000-0xfed1bfff disabled] because it overlaps 0000:85:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    5.048395] system 00:01: [io  0x0500-0x053f] has been reserved
[    5.055309] system 00:01: [io  0x0400-0x047f] has been reserved
[    5.062225] system 00:01: [io  0x0540-0x057f] has been reserved
[    5.069138] system 00:01: [io  0x0600-0x061f] has been reserved
[    5.076047] system 00:01: [io  0x0ca0-0x0ca5] has been reserved
[    5.082950] system 00:01: [io  0x0880-0x0883] has been reserved
[    5.089860] system 00:01: [io  0x0800-0x081f] has been reserved
[    5.097070] system 00:04: [io  0x0ca8] has been reserved
[    5.103300] system 00:04: [io  0x0cac] has been reserved
[    5.109616] pnp: PnP ACPI: found 5 devices
[    5.120083] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    5.130520] pci 0000:03:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    5.142119] pci 0000:02:00.0: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no compatible bridge window
[    5.153724] pci 0000:02:00.1: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no compatible bridge window
[    5.165323] pci 0000:01:00.0: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no compatible bridge window
[    5.176924] pci 0000:01:00.1: can't claim BAR 6 [mem 0xfffc0000-0xffffffff pref]: no compatible bridge window
[    5.188513] pci 0000:84:00.0: can't claim BAR 6 [mem 0xfffe0000-0xffffffff pref]: no compatible bridge window
[    5.200101] pci 0000:85:00.0: can't claim BAR 6 [mem 0xfffe0000-0xffffffff pref]: no compatible bridge window
[    5.211704] pci 0000:86:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    5.223301] pci 0000:86:00.1: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    5.234905] pci 0000:87:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    5.246588] pci 0000:87:00.1: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[    5.258988] pci 0000:00:03.0: BAR 14: assigned [mem 0x93f00000-0x93ffffff]
[    5.266972] pci 0000:00:03.1: BAR 14: assigned [mem 0x94000000-0x940fffff]
[    5.274955] pci 0000:03:00.0: BAR 6: no space for [mem size 0x00100000 pref]
[    5.283131] pci 0000:03:00.0: BAR 6: failed to assign [mem size 0x00100000 pref]
[    5.291917] pci 0000:00:01.0: PCI bridge to [bus 03]
[    5.297851] pci 0000:00:01.0:   bridge window [io  0x4000-0x4fff]
[    5.304951] pci 0000:00:01.0:   bridge window [mem 0x93c00000-0x93dfffff]
[    5.312839] pci 0000:05:08.0: PCI bridge to [bus 06]
[    5.318683] pci 0000:05:08.0:   bridge window [io  0x3000-0x3fff]
[    5.325792] pci 0000:05:08.0:   bridge window [mem 0x92000000-0x92ffffff]
[    5.333680] pci 0000:05:08.0:   bridge window [mem 0x3bfe0000000-0x3bff1ffffff 64bit pref]
[    5.343440] pci 0000:05:10.0: PCI bridge to [bus 07]
[    5.349281] pci 0000:05:10.0:   bridge window [io  0x2000-0x2fff]
[    5.356384] pci 0000:05:10.0:   bridge window [mem 0x91000000-0x91ffffff]
[    5.364271] pci 0000:05:10.0:   bridge window [mem 0x3bfc0000000-0x3bfd1ffffff 64bit pref]
[    5.374016] pci 0000:04:00.0: PCI bridge to [bus 05-07]
[    5.380152] pci 0000:04:00.0:   bridge window [io  0x2000-0x3fff]
[    5.387253] pci 0000:04:00.0:   bridge window [mem 0x91000000-0x92ffffff]
[    5.395137] pci 0000:04:00.0:   bridge window [mem 0x3bfc0000000-0x3bff1ffffff 64bit pref]
[    5.404897] pci 0000:00:02.0: PCI bridge to [bus 04-07]
[    5.411030] pci 0000:00:02.0:   bridge window [io  0x2000-0x3fff]
[    5.418134] pci 0000:00:02.0:   bridge window [mem 0x91000000-0x92ffffff]
[    5.426021] pci 0000:00:02.0:   bridge window [mem 0x3bfc0000000-0x3bff1ffffff 64bit pref]
[    5.435777] pci 0000:02:00.0: BAR 6: assigned [mem 0x93f00000-0x93f3ffff pref]
[    5.444368] pci 0000:02:00.1: BAR 6: assigned [mem 0x93f40000-0x93f7ffff pref]
[    5.452951] pci 0000:00:03.0: PCI bridge to [bus 02]
[    5.458797] pci 0000:00:03.0:   bridge window [mem 0x93f00000-0x93ffffff]
[    5.466679] pci 0000:00:03.0:   bridge window [mem 0x93a00000-0x93afffff 64bit pref]
[    5.475853] pci 0000:01:00.0: BAR 6: assigned [mem 0x94000000-0x9403ffff pref]
[    5.484442] pci 0000:01:00.1: BAR 6: assigned [mem 0x94040000-0x9407ffff pref]
[    5.493047] pci 0000:00:03.1: PCI bridge to [bus 01]
[    5.498890] pci 0000:00:03.1:   bridge window [mem 0x94000000-0x940fffff]
[    5.506778] pci 0000:00:03.1:   bridge window [mem 0x93b00000-0x93bfffff 64bit pref]
[    5.515948] pci 0000:00:03.2: PCI bridge to [bus 08]
[    5.521795] pci 0000:00:1c.0: PCI bridge to [bus 09]
[    5.527644] pci 0000:0c:00.0: PCI bridge to [bus 0d]
[    5.533637] pci 0000:0c:00.0:   bridge window [mem 0x93000000-0x938fffff]
[    5.541614] pci 0000:0c:00.0:   bridge window [mem 0x90000000-0x90ffffff 64bit pref]
[    5.551003] pci 0000:0b:00.0: PCI bridge to [bus 0c-0d]
[    5.557289] pci 0000:0b:00.0:   bridge window [mem 0x93000000-0x938fffff]
[    5.565275] pci 0000:0b:00.0:   bridge window [mem 0x90000000-0x90ffffff 64bit pref]
[    5.574654] pci 0000:0a:00.0: PCI bridge to [bus 0b-0e]
[    5.580923] pci 0000:0a:00.0:   bridge window [mem 0x93000000-0x939fffff]
[    5.588897] pci 0000:0a:00.0:   bridge window [mem 0x90000000-0x90ffffff 64bit pref]
[    5.598296] pci 0000:00:1c.7: PCI bridge to [bus 0a-0e]
[    5.604439] pci 0000:00:1c.7:   bridge window [mem 0x93000000-0x939fffff]
[    5.612324] pci 0000:00:1c.7:   bridge window [mem 0x90000000-0x90ffffff 64bit pref]
[    5.621600] pci 0000:80:03.0: BAR 14: assigned [mem 0xd0400000-0xd05fffff]
[    5.629585] pci 0000:80:03.2: BAR 14: assigned [mem 0xd0600000-0xd07fffff]
[    5.637565] pci 0000:80:01.0: PCI bridge to [bus 81]
[    5.643416] pci 0000:84:00.0: BAR 7: no space for [mem size 0x100000000 64bit pref]
[    5.652487] pci 0000:84:00.0: BAR 7: failed to assign [mem size 0x100000000 64bit pref]
[    5.661944] pci 0000:84:00.0: BAR 9: no space for [mem size 0x04000000 64bit pref]
[    5.671013] pci 0000:84:00.0: BAR 9: failed to assign [mem size 0x04000000 64bit pref]
[    5.680388] pci 0000:84:00.0: BAR 12: no space for [mem size 0x04000000]
[    5.688174] pci 0000:84:00.0: BAR 12: failed to assign [mem size 0x04000000]
[    5.696349] pci 0000:84:00.0: BAR 6: assigned [mem 0xd0140000-0xd015ffff pref]
[    5.704943] pci 0000:83:08.0: PCI bridge to [bus 84]
[    5.710876] pci 0000:83:08.0:   bridge window [io  0x9000-0x9fff]
[    5.717975] pci 0000:83:08.0:   bridge window [mem 0xd0100000-0xd01fffff]
[    5.725862] pci 0000:83:08.0:   bridge window [mem 0x3ffe0000000-0x3fff01fffff 64bit pref]
[    5.735626] pci 0000:85:00.0: BAR 7: no space for [mem size 0x100000000 64bit pref]
[    5.744711] pci 0000:85:00.0: BAR 7: failed to assign [mem size 0x100000000 64bit pref]
[    5.754180] pci 0000:85:00.0: BAR 9: no space for [mem size 0x04000000 64bit pref]
[    5.763161] pci 0000:85:00.0: BAR 9: failed to assign [mem size 0x04000000 64bit pref]
[    5.772524] pci 0000:85:00.0: BAR 12: no space for [mem size 0x04000000]
[    5.780311] pci 0000:85:00.0: BAR 12: failed to assign [mem size 0x04000000]
[    5.788487] pci 0000:85:00.0: BAR 6: assigned [mem 0xd0040000-0xd005ffff pref]
[    5.797079] pci 0000:83:10.0: PCI bridge to [bus 85]
[    5.802923] pci 0000:83:10.0:   bridge window [io  0x8000-0x8fff]
[    5.810023] pci 0000:83:10.0:   bridge window [mem 0xd0000000-0xd00fffff]
[    5.817907] pci 0000:83:10.0:   bridge window [mem 0x3ffc0000000-0x3ffd01fffff 64bit pref]
[    5.827662] pci 0000:82:00.0: PCI bridge to [bus 83-85]
[    5.833798] pci 0000:82:00.0:   bridge window [io  0x8000-0x9fff]
[    5.840900] pci 0000:82:00.0:   bridge window [mem 0xd0000000-0xd01fffff]
[    5.848787] pci 0000:82:00.0:   bridge window [mem 0x3ffc0000000-0x3fff01fffff 64bit pref]
[    5.858545] pci 0000:80:02.0: PCI bridge to [bus 82-85]
[    5.864690] pci 0000:80:02.0:   bridge window [io  0x8000-0x9fff]
[    5.871799] pci 0000:80:02.0:   bridge window [mem 0xd0000000-0xd02fffff]
[    5.879688] pci 0000:80:02.0:   bridge window [mem 0x3ffc0000000-0x3fff01fffff 64bit pref]
[    5.889452] pci 0000:86:00.0: BAR 6: assigned [mem 0xd0400000-0xd04fffff pref]
[    5.898035] pci 0000:86:00.1: BAR 6: assigned [mem 0xd0500000-0xd05fffff pref]
[    5.906625] pci 0000:80:03.0: PCI bridge to [bus 86]
[    5.912469] pci 0000:80:03.0:   bridge window [mem 0xd0400000-0xd05fffff]
[    5.920357] pci 0000:80:03.0:   bridge window [mem 0xc8000000-0xcbffffff 64bit pref]
[    5.929531] pci 0000:87:00.0: BAR 6: assigned [mem 0xd0600000-0xd06fffff pref]
[    5.938118] pci 0000:87:00.1: BAR 6: assigned [mem 0xd0700000-0xd07fffff pref]
[    5.946712] pci 0000:80:03.2: PCI bridge to [bus 87]
[    5.952551] pci 0000:80:03.2:   bridge window [mem 0xd0600000-0xd07fffff]
[    5.960437] pci 0000:80:03.2:   bridge window [mem 0xcc000000-0xcfffffff 64bit pref]
[    5.969608] pci_bus 0000:80: Some PCI device resources are unassigned, try booting with pci=realloc
[    5.980332] NET: Registered protocol family 2
[    5.985945] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[    5.995471] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    6.003425] TCP: Hash tables configured (established 524288 bind 65536)
[    6.011263] UDP hash table entries: 65536 (order: 9, 2097152 bytes)
[    6.018910] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes)
[    6.027178] NET: Registered protocol family 1
[    6.046258] pci 0000:03:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
[    6.058991] pci 0000:0d:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    6.423863] Unpacking initramfs...
[    6.913506] Freeing initrd memory: 252372K
[    6.933130] DMAR: dmar0: Using Queued invalidation
[    6.944109] DMAR: dmar1: Using Queued invalidation
[    6.949785] DMAR: Setting RMRR:
[    6.954022] DMAR: Setting identity map for device 0000:00:1a.0 [0x7ae07000 - 0x7af06fff]
[    6.963992] DMAR: Setting identity map for device 0000:00:1d.0 [0x7ae07000 - 0x7af06fff]
[    6.973572] DMAR: Prepare 0-16MiB unity mapping for LPC
[    6.980195] DMAR: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]
[    6.988899] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    6.996496] iommu: Adding device 0000:00:00.0 to group 0
[    7.002756] iommu: Adding device 0000:00:01.0 to group 1
[    7.009018] iommu: Adding device 0000:00:02.0 to group 2
[    7.015285] iommu: Adding device 0000:00:03.0 to group 3
[    7.021542] iommu: Adding device 0000:00:03.1 to group 4
[    7.027806] iommu: Adding device 0000:00:03.2 to group 5
[    7.034153] iommu: Adding device 0000:00:05.0 to group 6
[    7.040417] iommu: Adding device 0000:00:05.1 to group 6
[    7.046681] iommu: Adding device 0000:00:05.2 to group 6
[    7.052945] iommu: Adding device 0000:00:05.4 to group 6
[    7.059258] iommu: Adding device 0000:00:11.0 to group 7
[    7.065517] iommu: Adding device 0000:00:11.4 to group 7
[    7.071817] iommu: Adding device 0000:00:16.0 to group 8
[    7.078073] iommu: Adding device 0000:00:16.1 to group 8
[    7.084333] iommu: Adding device 0000:00:1a.0 to group 9
[    7.090594] iommu: Adding device 0000:00:1c.0 to group 10
[    7.096944] iommu: Adding device 0000:00:1c.7 to group 11
[    7.103306] iommu: Adding device 0000:00:1d.0 to group 12
[    7.109700] iommu: Adding device 0000:00:1f.0 to group 13
[    7.116056] iommu: Adding device 0000:00:1f.2 to group 13
[    7.122465] iommu: Adding device 0000:01:00.0 to group 14
[    7.128832] iommu: Adding device 0000:01:00.1 to group 14
[    7.135233] iommu: Adding device 0000:02:00.0 to group 15
[    7.141600] iommu: Adding device 0000:02:00.1 to group 15
[    7.147959] iommu: Adding device 0000:03:00.0 to group 16
[    7.154318] iommu: Adding device 0000:04:00.0 to group 17
[    7.160680] iommu: Adding device 0000:05:08.0 to group 18
[    7.167041] iommu: Adding device 0000:05:10.0 to group 19
[    7.173406] iommu: Adding device 0000:06:00.0 to group 20
[    7.179769] iommu: Adding device 0000:07:00.0 to group 21
[    7.186126] iommu: Adding device 0000:0a:00.0 to group 22
[    7.192481] iommu: Adding device 0000:0b:00.0 to group 23
[    7.198857] iommu: Adding device 0000:0c:00.0 to group 23
[    7.205197] iommu: Adding device 0000:0d:00.0 to group 23
[    7.211611] iommu: Adding device 0000:7f:08.0 to group 24
[    7.217968] iommu: Adding device 0000:7f:08.2 to group 24
[    7.224330] iommu: Adding device 0000:7f:08.3 to group 24
[    7.230735] iommu: Adding device 0000:7f:09.0 to group 25
[    7.237091] iommu: Adding device 0000:7f:09.2 to group 25
[    7.243443] iommu: Adding device 0000:7f:09.3 to group 25
[    7.249872] iommu: Adding device 0000:7f:0b.0 to group 26
[    7.256235] iommu: Adding device 0000:7f:0b.1 to group 26
[    7.262595] iommu: Adding device 0000:7f:0b.2 to group 26
[    7.268957] iommu: Adding device 0000:7f:0b.3 to group 26
[    7.275469] iommu: Adding device 0000:7f:0c.0 to group 27
[    7.281827] iommu: Adding device 0000:7f:0c.1 to group 27
[    7.288187] iommu: Adding device 0000:7f:0c.2 to group 27
[    7.294544] iommu: Adding device 0000:7f:0c.3 to group 27
[    7.300905] iommu: Adding device 0000:7f:0c.4 to group 27
[    7.307266] iommu: Adding device 0000:7f:0c.5 to group 27
[    7.313626] iommu: Adding device 0000:7f:0c.6 to group 27
[    7.320074] iommu: Adding device 0000:7f:0c.7 to group 27
[    7.326553] iommu: Adding device 0000:7f:0d.0 to group 28
[    7.332911] iommu: Adding device 0000:7f:0d.1 to group 28
[    7.339273] iommu: Adding device 0000:7f:0d.2 to group 28
[    7.345636] iommu: Adding device 0000:7f:0d.3 to group 28
[    7.351996] iommu: Adding device 0000:7f:0d.4 to group 28
[    7.358361] iommu: Adding device 0000:7f:0d.5 to group 28
[    7.364852] iommu: Adding device 0000:7f:0f.0 to group 29
[    7.371217] iommu: Adding device 0000:7f:0f.1 to group 29
[    7.377570] iommu: Adding device 0000:7f:0f.2 to group 29
[    7.383930] iommu: Adding device 0000:7f:0f.3 to group 29
[    7.390296] iommu: Adding device 0000:7f:0f.4 to group 29
[    7.396656] iommu: Adding device 0000:7f:0f.5 to group 29
[    7.403019] iommu: Adding device 0000:7f:0f.6 to group 29
[    7.409477] iommu: Adding device 0000:7f:10.0 to group 30
[    7.415836] iommu: Adding device 0000:7f:10.1 to group 30
[    7.422197] iommu: Adding device 0000:7f:10.5 to group 30
[    7.428561] iommu: Adding device 0000:7f:10.6 to group 30
[    7.434919] iommu: Adding device 0000:7f:10.7 to group 30
[    7.441399] iommu: Adding device 0000:7f:12.0 to group 31
[    7.447760] iommu: Adding device 0000:7f:12.1 to group 31
[    7.454120] iommu: Adding device 0000:7f:12.2 to group 31
[    7.460485] iommu: Adding device 0000:7f:12.4 to group 31
[    7.466846] iommu: Adding device 0000:7f:12.5 to group 31
[    7.473209] iommu: Adding device 0000:7f:12.6 to group 31
[    7.479701] iommu: Adding device 0000:7f:13.0 to group 32
[    7.486064] iommu: Adding device 0000:7f:13.1 to group 32
[    7.492431] iommu: Adding device 0000:7f:13.2 to group 32
[    7.498799] iommu: Adding device 0000:7f:13.3 to group 32
[    7.505254] iommu: Adding device 0000:7f:13.6 to group 32
[    7.511615] iommu: Adding device 0000:7f:13.7 to group 32
[    7.518128] iommu: Adding device 0000:7f:14.0 to group 33
[    7.524495] iommu: Adding device 0000:7f:14.1 to group 33
[    7.530863] iommu: Adding device 0000:7f:14.2 to group 33
[    7.537231] iommu: Adding device 0000:7f:14.3 to group 33
[    7.543597] iommu: Adding device 0000:7f:14.4 to group 33
[    7.549953] iommu: Adding device 0000:7f:14.5 to group 33
[    7.556318] iommu: Adding device 0000:7f:14.6 to group 33
[    7.562677] iommu: Adding device 0000:7f:14.7 to group 33
[    7.569169] iommu: Adding device 0000:7f:16.0 to group 34
[    7.575537] iommu: Adding device 0000:7f:16.1 to group 34
[    7.581905] iommu: Adding device 0000:7f:16.2 to group 34
[    7.588274] iommu: Adding device 0000:7f:16.3 to group 34
[    7.594639] iommu: Adding device 0000:7f:16.6 to group 34
[    7.601005] iommu: Adding device 0000:7f:16.7 to group 34
[    7.607534] iommu: Adding device 0000:7f:17.0 to group 35
[    7.613899] iommu: Adding device 0000:7f:17.1 to group 35
[    7.620256] iommu: Adding device 0000:7f:17.2 to group 35
[    7.626624] iommu: Adding device 0000:7f:17.3 to group 35
[    7.632984] iommu: Adding device 0000:7f:17.4 to group 35
[    7.639353] iommu: Adding device 0000:7f:17.5 to group 35
[    7.645721] iommu: Adding device 0000:7f:17.6 to group 35
[    7.652077] iommu: Adding device 0000:7f:17.7 to group 35
[    7.658528] iommu: Adding device 0000:7f:1e.0 to group 36
[    7.664895] iommu: Adding device 0000:7f:1e.1 to group 36
[    7.671258] iommu: Adding device 0000:7f:1e.2 to group 36
[    7.677623] iommu: Adding device 0000:7f:1e.3 to group 36
[    7.683991] iommu: Adding device 0000:7f:1e.4 to group 36
[    7.690410] iommu: Adding device 0000:7f:1f.0 to group 37
[    7.696774] iommu: Adding device 0000:7f:1f.2 to group 37
[    7.703130] iommu: Adding device 0000:80:01.0 to group 38
[    7.709488] iommu: Adding device 0000:80:02.0 to group 39
[    7.715847] iommu: Adding device 0000:80:03.0 to group 40
[    7.722208] iommu: Adding device 0000:80:03.2 to group 41
[    7.728642] iommu: Adding device 0000:80:05.0 to group 42
[    7.735011] iommu: Adding device 0000:80:05.1 to group 42
[    7.741376] iommu: Adding device 0000:80:05.2 to group 42
[    7.747740] iommu: Adding device 0000:80:05.4 to group 42
[    7.754098] iommu: Adding device 0000:82:00.0 to group 43
[    7.760458] iommu: Adding device 0000:83:08.0 to group 44
[    7.766806] iommu: Adding device 0000:83:10.0 to group 45
[    7.773170] iommu: Adding device 0000:84:00.0 to group 46
[    7.779535] iommu: Adding device 0000:85:00.0 to group 47
[    7.785959] iommu: Adding device 0000:86:00.0 to group 48
[    7.792358] iommu: Adding device 0000:86:00.1 to group 48
[    7.798776] iommu: Adding device 0000:87:00.0 to group 49
[    7.805169] iommu: Adding device 0000:87:00.1 to group 49
[    7.811582] iommu: Adding device 0000:ff:08.0 to group 50
[    7.817947] iommu: Adding device 0000:ff:08.2 to group 50
[    7.824317] iommu: Adding device 0000:ff:08.3 to group 50
[    7.830734] iommu: Adding device 0000:ff:09.0 to group 51
[    7.837100] iommu: Adding device 0000:ff:09.2 to group 51
[    7.843469] iommu: Adding device 0000:ff:09.3 to group 51
[    7.849899] iommu: Adding device 0000:ff:0b.0 to group 52
[    7.856267] iommu: Adding device 0000:ff:0b.1 to group 52
[    7.862631] iommu: Adding device 0000:ff:0b.2 to group 52
[    7.869001] iommu: Adding device 0000:ff:0b.3 to group 52
[    7.875611] iommu: Adding device 0000:ff:0c.0 to group 53
[    7.881979] iommu: Adding device 0000:ff:0c.1 to group 53
[    7.888346] iommu: Adding device 0000:ff:0c.2 to group 53
[    7.894718] iommu: Adding device 0000:ff:0c.3 to group 53
[    7.901092] iommu: Adding device 0000:ff:0c.4 to group 53
[    7.907462] iommu: Adding device 0000:ff:0c.5 to group 53
[    7.913833] iommu: Adding device 0000:ff:0c.6 to group 53
[    7.920202] iommu: Adding device 0000:ff:0c.7 to group 53
[    7.926675] iommu: Adding device 0000:ff:0d.0 to group 54
[    7.933039] iommu: Adding device 0000:ff:0d.1 to group 54
[    7.939412] iommu: Adding device 0000:ff:0d.2 to group 54
[    7.945779] iommu: Adding device 0000:ff:0d.3 to group 54
[    7.952147] iommu: Adding device 0000:ff:0d.4 to group 54
[    7.958518] iommu: Adding device 0000:ff:0d.5 to group 54
[    7.965009] iommu: Adding device 0000:ff:0f.0 to group 55
[    7.971387] iommu: Adding device 0000:ff:0f.1 to group 55
[    7.977760] iommu: Adding device 0000:ff:0f.2 to group 55
[    7.984126] iommu: Adding device 0000:ff:0f.3 to group 55
[    7.990492] iommu: Adding device 0000:ff:0f.4 to group 55
[    7.996863] iommu: Adding device 0000:ff:0f.5 to group 55
[    8.003231] iommu: Adding device 0000:ff:0f.6 to group 55
[    8.009687] iommu: Adding device 0000:ff:10.0 to group 56
[    8.016058] iommu: Adding device 0000:ff:10.1 to group 56
[    8.022429] iommu: Adding device 0000:ff:10.5 to group 56
[    8.028801] iommu: Adding device 0000:ff:10.6 to group 56
[    8.035176] iommu: Adding device 0000:ff:10.7 to group 56
[    8.041653] iommu: Adding device 0000:ff:12.0 to group 57
[    8.048024] iommu: Adding device 0000:ff:12.1 to group 57
[    8.054399] iommu: Adding device 0000:ff:12.2 to group 57
[    8.060766] iommu: Adding device 0000:ff:12.4 to group 57
[    8.067141] iommu: Adding device 0000:ff:12.5 to group 57
[    8.073515] iommu: Adding device 0000:ff:12.6 to group 57
[    8.085434] iommu: Adding device 0000:ff:13.0 to group 58
[    8.091808] iommu: Adding device 0000:ff:13.1 to group 58
[    8.098186] iommu: Adding device 0000:ff:13.2 to group 58
[    8.104559] iommu: Adding device 0000:ff:13.3 to group 58
[    8.110933] iommu: Adding device 0000:ff:13.6 to group 58
[    8.117398] iommu: Adding device 0000:ff:13.7 to group 58
[    8.123917] iommu: Adding device 0000:ff:14.0 to group 59
[    8.130293] iommu: Adding device 0000:ff:14.1 to group 59
[    8.136665] iommu: Adding device 0000:ff:14.2 to group 59
[    8.143039] iommu: Adding device 0000:ff:14.3 to group 59
[    8.149415] iommu: Adding device 0000:ff:14.4 to group 59
[    8.155781] iommu: Adding device 0000:ff:14.5 to group 59
[    8.162153] iommu: Adding device 0000:ff:14.6 to group 59
[    8.168531] iommu: Adding device 0000:ff:14.7 to group 59
[    8.175009] iommu: Adding device 0000:ff:16.0 to group 60
[    8.181385] iommu: Adding device 0000:ff:16.1 to group 60
[    8.187761] iommu: Adding device 0000:ff:16.2 to group 60
[    8.194129] iommu: Adding device 0000:ff:16.3 to group 60
[    8.200501] iommu: Adding device 0000:ff:16.6 to group 60
[    8.206876] iommu: Adding device 0000:ff:16.7 to group 60
[    8.213397] iommu: Adding device 0000:ff:17.0 to group 61
[    8.219771] iommu: Adding device 0000:ff:17.1 to group 61
[    8.226150] iommu: Adding device 0000:ff:17.2 to group 61
[    8.232523] iommu: Adding device 0000:ff:17.3 to group 61
[    8.238901] iommu: Adding device 0000:ff:17.4 to group 61
[    8.245275] iommu: Adding device 0000:ff:17.5 to group 61
[    8.251650] iommu: Adding device 0000:ff:17.6 to group 61
[    8.258026] iommu: Adding device 0000:ff:17.7 to group 61
[    8.264480] iommu: Adding device 0000:ff:1e.0 to group 62
[    8.270855] iommu: Adding device 0000:ff:1e.1 to group 62
[    8.277230] iommu: Adding device 0000:ff:1e.2 to group 62
[    8.283600] iommu: Adding device 0000:ff:1e.3 to group 62
[    8.289975] iommu: Adding device 0000:ff:1e.4 to group 62
[    8.296375] iommu: Adding device 0000:ff:1f.0 to group 63
[    8.302746] iommu: Adding device 0000:ff:1f.2 to group 63
[    8.309947] Intel CQM monitoring enabled
[    8.314628] Intel MBM enabled
[    8.319481] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    8.328868] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    8.335592] RAPL PMU: hw unit of domain package 2^-14 Joules
[    8.342218] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    8.348554] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    8.358606] audit: initializing netlink subsys (disabled)
[    8.364994] audit: type=2000 audit(1493135653.220:1): state=initialized audit_enabled=0 res=1
[    8.365470] Initialise system trusted keyrings
[    8.365559] workingset: timestamp_bits=39 max_order=26 bucket_order=0
[    8.624054] Key type asymmetric registered
[    8.628934] Asymmetric key parser 'x509' registered
[    8.634700] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    8.643594] io scheduler noop registered
[    8.648277] io scheduler deadline registered
[    8.653372] io scheduler cfq registered (default)
[    8.658926] io scheduler mq-deadline registered
[    8.669240] pcieport 0000:00:01.0: Signaling PME with IRQ 26
[    8.675880] pcieport 0000:00:02.0: Signaling PME with IRQ 27
[    8.682518] pcieport 0000:00:03.0: Signaling PME with IRQ 28
[    8.689146] pcieport 0000:00:03.1: Signaling PME with IRQ 29
[    8.695787] pcieport 0000:00:03.2: Signaling PME with IRQ 30
[    8.702422] pcieport 0000:00:1c.0: Signaling PME with IRQ 31
[    8.709064] pcieport 0000:00:1c.7: Signaling PME with IRQ 32
[    8.715739] pcieport 0000:80:01.0: Signaling PME with IRQ 37
[    8.722369] pcieport 0000:80:02.0: Signaling PME with IRQ 38
[    8.729006] pcieport 0000:80:03.0: Signaling PME with IRQ 39
[    8.735646] pcieport 0000:80:03.2: Signaling PME with IRQ 40
[    8.745069] ERST: Error Record Serialization Table (ERST) support is initialized.
[    8.753970] pstore: using zlib compression
[    8.758849] pstore: Registered erst as persistent store backend
[    8.766153] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
[    8.775002] ioatdma: Intel(R) QuickData Technology Driver 4.00
[    8.781914] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    8.809789] 00:02: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    8.839063] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    8.850833] i8042: PNP: No PS/2 controller found.
[    8.856442] rtc_cmos 00:00: RTC can wake from S4
[    8.862067] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    8.869213] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    8.878313] intel_pstate: Intel P-state driver initializing
[    8.887771] NET: Registered protocol family 10
[    8.893475] Segment Routing with IPv6
[    8.897893] NET: Registered protocol family 17
[    8.903165] Key type dns_resolver registered
[    8.913471] microcode: sig=0x406f1, pf=0x1, revision=0xb00001e
[    8.922014] microcode: Microcode Update Driver: v2.2.
[    8.922143] registered taskstats version 1
[    8.932994] Loading compiled-in X.509 certificates
[    8.940309] alg: No test for pkcs1pad(rsa,sha256) (pkcs1pad(rsa-generic,sha256))
[    8.949727] Loaded X.509 cert 'CoreOS, Inc: Module signing key for 4.11.0-rc7-coreos: ea21eedf6d987ed1164de89c738ac1f7e1a2dba9'
[    8.963107] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
[    8.972920] rtc_cmos 00:00: setting system clock to 2017-04-25 15:54:17 UTC (1493135657)
[    8.992492] Freeing unused kernel memory: 31788K
[    8.997965] Write protecting the kernel read-only data: 12288k
[    9.005719] Freeing unused kernel memory: 1980K
[    9.013828] Freeing unused kernel memory: 1496K
[    9.021975] Unable to open file: /etc/ima/ima-policy (-2)
[    9.021979] IMA: policy update failed
[    9.032733] audit: type=1802 audit(1493135657.558:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel op="policy_update" cause="failed" comm="systemd" res=0
[    9.052321] systemd[1]: Failed to insert module 'ip_tables': Function not implemented
[    9.062292] random: systemd: uninitialized urandom read (16 bytes read)
[    9.070322] random: systemd: uninitialized urandom read (16 bytes read)
[    9.078022] random: systemd: uninitialized urandom read (16 bytes read)
[    9.091094] systemd[1]: systemd 233 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT -GNUTLS -ACL +XZ -LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD -IDN default-hierarchy=legacy)
[    9.115039] systemd[1]: Detected architecture x86-64.
[    9.120974] systemd[1]: Running in initial RAM disk.
[    9.127978] systemd[1]: No hostname configured.
[    9.133348] systemd[1]: Set hostname to <localhost>.
[    9.139234] random: systemd: uninitialized urandom read (16 bytes read)
[    9.146927] systemd[1]: Initializing machine ID from random generator.
[    9.157119] random: systemd: uninitialized urandom read (16 bytes read)
[    9.165763] random: systemd: uninitialized urandom read (16 bytes read)
[    9.167146] random: systemd-cryptse: uninitialized urandom read (16 bytes read)
[    9.185274] random: systemd: uninitialized urandom read (16 bytes read)
[    9.192988] random: systemd: uninitialized urandom read (16 bytes read)
[    9.200798] random: systemd: uninitialized urandom read (16 bytes read)
[    9.213149] systemd[1]: Reached target Swap.
[    9.219064] systemd[1]: Listening on Journal Socket (/dev/log).
[    9.226783] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    9.236952] systemd[1]: Listening on Journal Socket.
[    9.256823] audit: type=1130 audit(1493135657.782:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    9.280632] audit: type=1130 audit(1493135657.806:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=kmod-static-nodes comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    9.305816] audit: type=1130 audit(1493135657.831:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    9.330507] audit: type=1130 audit(1493135657.856:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    9.355779] audit: type=1130 audit(1493135657.881:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    9.385065] device-mapper: uevent: version 1.0.3
[    9.385159] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    9.391282] tsc: Refined TSC clocksource calibration: 2599.995 MHz
[    9.391301] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x257a376535a, max_idle_ns: 440795296166 ns
[    9.434160] audit: type=1130 audit(1493135657.959:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    9.461913] audit: type=1130 audit(1493135657.987:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udevd comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    9.493368] audit: type=1130 audit(1493135658.019:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-networkd comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    9.595106] pps_core: LinuxPPS API ver. 1 registered
[    9.600978] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    9.612490] PTP clock support registered
[    9.618040] SCSI subsystem initialized
[    9.624540] ACPI: bus type USB registered
[    9.629351] usbcore: registered new interface driver usbfs
[    9.635795] usbcore: registered new interface driver hub
[    9.642193] usbcore: registered new device driver usb
[    9.643087] mlx5_core 0000:86:00.0: firmware version: 12.16.1020
[    9.656500] tg3.c:v3.137 (May 11, 2014)
[    9.661393] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    9.669724] AVX2 version of gcm_enc/dec engaged.
[    9.669725] AES CTR mode by8 optimization enabled
[    9.672763] tg3 0000:01:00.0 eth0: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address 18:66:da:f0:0d:5c
[    9.672765] tg3 0000:01:00.0 eth0: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    9.672767] tg3 0000:01:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[    9.672768] tg3 0000:01:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[    9.683793] tg3 0000:01:00.1 eth1: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address 18:66:da:f0:0d:5d
[    9.683795] tg3 0000:01:00.1 eth1: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    9.683797] tg3 0000:01:00.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[    9.683798] tg3 0000:01:00.1 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
[    9.694785] tg3 0000:02:00.0 eth2: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address 18:66:da:f0:0d:5e
[    9.694787] tg3 0000:02:00.0 eth2: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    9.694788] tg3 0000:02:00.0 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[    9.694789] tg3 0000:02:00.0 eth2: dma_rwctrl[00000001] dma_mask[64-bit]
[    9.705773] tg3 0000:02:00.1 eth3: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address 18:66:da:f0:0d:5f
[    9.705774] tg3 0000:02:00.1 eth3: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    9.705776] tg3 0000:02:00.1 eth3: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
[    9.705777] tg3 0000:02:00.1 eth3: dma_rwctrl[00000001] dma_mask[64-bit]
[    9.844751] ehci-pci: EHCI PCI platform driver
[    9.844761] megasas: 07.701.17.00-rc1
[    9.845108] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    9.845116] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    9.845141] ehci-pci 0000:00:1a.0: debug port 2
[    9.846230] megaraid_sas 0000:03:00.0: FW now in Ready state
[    9.846803] megaraid_sas 0000:03:00.0: firmware supports msix        : (96)
[    9.846804] megaraid_sas 0000:03:00.0: current msix/online cpus      : (56/56)
[    9.846805] megaraid_sas 0000:03:00.0: RDPQ mode     : (disabled)
[    9.846807] megaraid_sas 0000:03:00.0: Current firmware maximum commands: 928         LDIO threshold: 0
[    9.849084] ehci-pci 0000:00:1a.0: irq 18, io mem 0x93e03000
[    9.849837] megaraid_sas 0000:03:00.0: FW supports sync cache        : No
[    9.856290] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    9.856438] hub 1-0:1.0: USB hub found
[    9.856441] hub 1-0:1.0: 2 ports detected
[    9.856760] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    9.856765] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    9.856786] ehci-pci 0000:00:1d.0: debug port 2
[    9.860701] ehci-pci 0000:00:1d.0: irq 18, io mem 0x93e02000
[    9.867315] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    9.867548] hub 2-0:1.0: USB hub found
[    9.867551] hub 2-0:1.0: 2 ports detected
[    9.867897] ahci 0000:00:11.4: SSS flag set, parallel bus scan disabled
[    9.867953] ahci 0000:00:11.4: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0xf impl SATA mode
[    9.867954] ahci 0000:00:11.4: flags: 64bit ncq stag led clo pio slum part ems apst
[    9.871319] megaraid_sas 0000:03:00.0: Init cmd success
[    9.877666] scsi host1: ahci
[    9.877835] scsi host2: ahci
[    9.877983] scsi host3: ahci
[    9.878105] scsi host4: ahci
[    9.878128] ata1: SATA max UDMA/133 abar m2048@0x93e01000 port 0x93e01100 irq 114
[    9.878130] ata2: SATA max UDMA/133 abar m2048@0x93e01000 port 0x93e01180 irq 114
[    9.878132] ata3: SATA max UDMA/133 abar m2048@0x93e01000 port 0x93e01200 irq 114
[    9.878133] ata4: SATA max UDMA/133 abar m2048@0x93e01000 port 0x93e01280 irq 114
[    9.878328] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    9.878380] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    9.878381] ahci 0000:00:1f.2: flags: 64bit ncq stag led clo pio slum part ems apst
[    9.893295] megaraid_sas 0000:03:00.0: firmware type : Extended VD(240 VD)firmware
[    9.893296] megaraid_sas 0000:03:00.0: controller type       : MR(1024MB)
[    9.893297] megaraid_sas 0000:03:00.0: Online Controller Reset(OCR)  : Enabled
[    9.893297] megaraid_sas 0000:03:00.0: Secure JBOD support   : No
[    9.893656] scsi host5: ahci
[    9.893747] scsi host6: ahci
[    9.893874] scsi host7: ahci
[    9.894006] scsi host8: ahci
[    9.894106] scsi host9: ahci
[    9.894204] scsi host10: ahci
[    9.894224] ata5: SATA max UDMA/133 abar m2048@0x93e00000 port 0x93e00100 irq 115
[    9.894225] ata6: SATA max UDMA/133 abar m2048@0x93e00000 port 0x93e00180 irq 115
[    9.894226] ata7: SATA max UDMA/133 abar m2048@0x93e00000 port 0x93e00200 irq 115
[    9.894228] ata8: SATA max UDMA/133 abar m2048@0x93e00000 port 0x93e00280 irq 115
[    9.894229] ata9: SATA max UDMA/133 abar m2048@0x93e00000 port 0x93e00300 irq 115
[    9.894231] ata10: SATA max UDMA/133 abar m2048@0x93e00000 port 0x93e00380 irq 115
[    9.917626] megaraid_sas 0000:03:00.0: INIT adapter done
[    9.917628] megaraid_sas 0000:03:00.0: Jbod map is not supported megasas_setup_jbod_map 5092
[    9.922308] megaraid_sas 0000:03:00.0: pci id                : (0x1000)/(0x005d)/(0x1028)/(0x1f49)
[    9.922309] megaraid_sas 0000:03:00.0: unevenspan support    : yes
[    9.922310] megaraid_sas 0000:03:00.0: firmware crash dump   : no
[    9.922311] megaraid_sas 0000:03:00.0: jbod sync map         : no
[    9.922312] scsi host0: Avago SAS based MegaRAID driver
[    9.923408] scsi 0:0:0:0: Direct-Access     ATA      INTEL SSDSC2BX80 DL2B PQ: 0 ANSI: 6
[    9.975680] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   10.167307] usb 1-1: new high-speed USB device number 2 using ehci-pci
[   10.182319] usb 2-1: new high-speed USB device number 2 using ehci-pci
[   10.187952] ata1: SATA link down (SStatus 0 SControl 300)
[   10.204764] ata5: SATA link down (SStatus 0 SControl 300)
[   10.206687] mlx5_core 0000:86:00.1: firmware version: 12.16.1020
[   10.287783] hub 1-1:1.0: USB hub found
[   10.287892] hub 1-1:1.0: 6 ports detected
[   10.302908] hub 2-1:1.0: USB hub found
[   10.303018] hub 2-1:1.0: 8 ports detected
[   10.486857] clocksource: Switched to clocksource tsc
[   10.486867] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   10.502011] ata2: SATA link down (SStatus 0 SControl 300)
[   10.559272] usb 1-1.4: new low-speed USB device number 3 using ehci-pci
[   10.571234] random: fast init done
[   10.611735] IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
[   10.661336] hidraw: raw HID events driver (C) Jiri Kosina
[   10.675932] usbcore: registered new interface driver usbhid
[   10.682454] usbhid: USB HID core driver
[   10.688355] input: Avocent IBM 73P5832 as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4/1-1.4:1.0/0003:0624:0296.0001/input/input0
[   10.722312] usb 1-1.6: new high-speed USB device number 4 using ehci-pci
[   10.741701] IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
[   10.753399] hid-generic 0003:0624:0296.0001: input,hidraw0: USB HID v1.10 Keyboard [Avocent IBM 73P5832] on usb-0000:00:1a.0-1.4/input0
[   10.757570] mlx5_core 0000:87:00.0: firmware version: 12.16.1020
[   10.774753] input: Avocent IBM 73P5832 as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4/1-1.4:1.1/0003:0624:0296.0002/input/input1
[   10.810555] hub 1-1.6:1.0: USB hub found
[   10.815447] hub 1-1.6:1.0: 6 ports detected
[   10.819823] ata3: SATA link down (SStatus 0 SControl 300)
[   10.840422] hid-generic 0003:0624:0296.0002: input,hidraw1: USB HID v1.10 Mouse [Avocent IBM 73P5832] on usb-0000:00:1a.0-1.4/input1
[   11.132066] ata4: SATA link down (SStatus 0 SControl 300)
[   11.323021] mlx5_core 0000:87:00.1: firmware version: 12.16.1020
[   11.444106] ata6: SATA link down (SStatus 0 SControl 300)
[   11.756170] ata7: SATA link down (SStatus 0 SControl 300)
[   12.068130] ata8: SATA link down (SStatus 0 SControl 300)
[   12.380170] ata9: SATA link down (SStatus 0 SControl 300)
[   12.692204] ata10: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   12.703261] ata10.00: ATAPI: PLDS DVD+/-RW DS-8ABSH, LD51, max UDMA/133
[   12.714232] ata10.00: configured for UDMA/133
[   12.728699] scsi 10:0:0:0: CD-ROM            PLDS     DVD+-RW DS-8ABSH LD51 PQ: 0 ANSI: 5
[   12.762286] sd 0:0:0:0: [sda] 1562824368 512-byte logical blocks: (800 GB/745 GiB)
[   12.771269] sd 0:0:0:0: [sda] 4096-byte physical blocks
[   12.778196] sd 0:0:0:0: [sda] Write Protect is off
[   12.784362] sr 10:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[   12.784506] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   12.790438]  sda: sda1 sda2 sda3 sda4 sda6 sda7 sda9
[   12.795260] sd 0:0:0:0: [sda] Attached SCSI disk
[   12.815980] cdrom: Uniform CD-ROM driver Revision: 3.20
[   13.472933] tg3 0000:01:00.0 eth0: Link is up at 1000 Mbps, full duplex
[   13.480622] tg3 0000:01:00.0 eth0: Flow control is on for TX and on for RX
[   13.488589] tg3 0000:01:00.0 eth0: EEE is disabled
[   13.494247] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   13.965123] tg3 0000:01:00.1 eth1: Link is up at 1000 Mbps, full duplex
[   13.972812] tg3 0000:01:00.1 eth1: Flow control is off for TX and off for RX
[   13.980985] tg3 0000:01:00.1 eth1: EEE is enabled
[   13.986540] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   15.941363] kauditd_printk_skb: 9 callbacks suppressed
[   15.947497] audit: type=1130 audit(1493135664.466:16): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=ignition-disks comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.970492] audit: type=1131 audit(1493135664.466:17): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=ignition-disks comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   16.009995] loop: module loaded
[   16.031465] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   16.060382] audit: type=1130 audit(1493135664.585:18): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-setup-root comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   16.083669] audit: type=1131 audit(1493135664.585:19): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-setup-root comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   16.109356] audit: type=1130 audit(1493135664.634:20): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=ignition-files comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   16.109359] audit: type=1131 audit(1493135664.634:21): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=ignition-files comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   16.190253] audit: type=1130 audit(1493135664.715:22): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-parse-etc comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   16.190255] audit: type=1131 audit(1493135664.715:23): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-parse-etc comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   16.252062] audit: type=1130 audit(1493135664.777:24): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-pivot comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   16.281796] audit: type=1131 audit(1493135664.807:25): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-pre-pivot comm="systemd" exe="/usr/lib64/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   16.842848] systemd-journald[493]: Received SIGTERM from PID 1 (systemd).
[   16.854744] systemd: 20 output lines suppressed due to ratelimiting
[   16.927796] SELinux:  Permission validate_trans in class security not defined in policy.
[   16.937366] SELinux:  Permission module_load in class system not defined in policy.
[   16.946491] SELinux:  Class cap_userns not defined in policy.
[   16.953212] SELinux:  Class cap2_userns not defined in policy.
[   16.960025] SELinux:  Class sctp_socket not defined in policy.
[   16.966844] SELinux:  Class icmp_socket not defined in policy.
[   16.973656] SELinux:  Class ax25_socket not defined in policy.
[   16.980477] SELinux:  Class ipx_socket not defined in policy.
[   16.987191] SELinux:  Class netrom_socket not defined in policy.
[   16.994203] SELinux:  Class atmpvc_socket not defined in policy.
[   17.001216] SELinux:  Class x25_socket not defined in policy.
[   17.007937] SELinux:  Class rose_socket not defined in policy.
[   17.014755] SELinux:  Class decnet_socket not defined in policy.
[   17.021765] SELinux:  Class atmsvc_socket not defined in policy.
[   17.028786] SELinux:  Class rds_socket not defined in policy.
[   17.035506] SELinux:  Class irda_socket not defined in policy.
[   17.042313] SELinux:  Class pppox_socket not defined in policy.
[   17.049228] SELinux:  Class llc_socket not defined in policy.
[   17.055945] SELinux:  Class can_socket not defined in policy.
[   17.062665] SELinux:  Class tipc_socket not defined in policy.
[   17.069483] SELinux:  Class bluetooth_socket not defined in policy.
[   17.076803] SELinux:  Class iucv_socket not defined in policy.
[   17.083620] SELinux:  Class rxrpc_socket not defined in policy.
[   17.090533] SELinux:  Class isdn_socket not defined in policy.
[   17.097349] SELinux:  Class phonet_socket not defined in policy.
[   17.104358] SELinux:  Class ieee802154_socket not defined in policy.
[   17.111760] SELinux:  Class caif_socket not defined in policy.
[   17.118577] SELinux:  Class alg_socket not defined in policy.
[   17.125319] SELinux:  Class nfc_socket not defined in policy.
[   17.132038] SELinux:  Class vsock_socket not defined in policy.
[   17.138951] SELinux:  Class kcm_socket not defined in policy.
[   17.145675] SELinux:  Class qipcrtr_socket not defined in policy.
[   17.152788] SELinux:  Class smc_socket not defined in policy.
[   17.159497] SELinux: the above unknown classes and permissions will be allowed
[   17.181057] systemd[1]: Successfully loaded SELinux policy in 270.411ms.
[   17.188854] Unable to open file: /etc/ima/ima-policy (-2)
[   17.188858] IMA: policy update failed
[   17.206750] ip_tables: (C) 2000-2006 Netfilter Core Team
[   17.218602] systemd[1]: Relabelled /dev and /run in 5.196ms.
[   17.350230] mlx5_ib: Mellanox Connect-IB Infiniband driver v2.2-1 (Feb 2014)
[   17.367819] systemd-journald[1610]: Received request to flush runtime journal from PID 1
[   17.463768] random: crng init done
[   17.536118] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[   17.545003] ACPI: Power Button [PWRF]
[   17.588861] tg3 0000:02:00.1 eno4: renamed from eth3
[   17.610753] tg3 0000:01:00.1 eno2: renamed from eth1
[   17.631403] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[   17.631840] ipmi message handler version 39.2
[   17.632668] mousedev: PS/2 mouse device common for all mice
[   17.635244] ipmi device interface
[   17.636800] mei_me 0000:00:16.0: Device doesn't have valid ME Interface
[   17.638501] IPMI System Interface driver.
[   17.638523] ipmi_si: probing via SMBIOS
[   17.638524] ipmi_si: SMBIOS: io 0xca8 regsize 1 spacing 4 irq 10
[   17.638524] ipmi_si: Adding SMBIOS-specified kcs state machine
[   17.638526] ipmi_si: Trying SMBIOS-specified kcs state machine at i/o address 0xca8, slave address 0x20, irq 10
[   17.642716] tg3 0000:02:00.0 eno3: renamed from eth2
[   17.689790] tg3 0000:01:00.0 eno1: renamed from eth0
[   17.733569] ipmi_si ipmi_si.0: The BMC does not support setting the recv irq bit, compensating, but the BMC needs to be fixed.
[   17.752832] EDAC MC: Ver: 3.0.0
[   17.760211] EDAC MC0: Giving out device to module sbridge_edac.c controller Broadwell Socket#0: DEV 0000:7f:12.0 (INTERRUPT)
[   17.763664] ipmi_si ipmi_si.0: Using irq 10
[   17.778343] EDAC MC1: Giving out device to module sbridge_edac.c controller Broadwell Socket#1: DEV 0000:ff:12.0 (INTERRUPT)
[   17.791397] EDAC sbridge:  Ver: 1.1.1
[   17.796766] [drm] amdgpu kernel modesetting enabled.
[   17.804851] ipmi_si ipmi_si.0: Found new BMC (man_id: 0x0002a2, prod_id: 0x0100, dev_id: 0x20)
[   17.815087] ipmi_si ipmi_si.0: IPMI kcs interface initialized
[   17.822166] AMD IOMMUv2 driver by Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
[   17.829182] AMD IOMMUv2 functionality not available on this system
[   17.848493] IPMI SSIF Interface driver
[   17.853288] CRAT table not found
[   17.857194] Finished initializing topology ret=0
[   17.862746] kfd kfd: Initialized module
[   17.867608] amdgpu 0000:84:00.0: enabling device (0000 -> 0003)
[   17.867751] [drm] initializing kernel modesetting (TONGA 0x1002:0x6929 0x1002:0x0334 0x00).
[   17.867774] [drm] register mmio base: 0xD0100000
[   17.867774] [drm] register mmio size: 262144
[   17.867779] [drm] doorbell mmio base: 0xF0000000
[   17.867779] [drm] doorbell mmio size: 2097152
[   17.867787] [drm] probing gen 2 caps for device 10b5:8747 = 8796103/10e
[   17.867787] [drm] probing mlw for device 10b5:8747 = 8796103
[   17.867800] [drm] VCE enabled in physical mode
[   18.815737] ATOM BIOS: C76301
[   18.819362] [drm] GPU posting now...
[   23.828834] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios stuck in loop for more than 5secs aborting
[   23.840560] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios stuck executing F250 (len 334, WS 4, PS 0) @ 0xF365
[   23.852854] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios stuck executing DB34 (len 324, WS 4, PS 0) @ 0xDC2C
[   23.865158] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios stuck executing BCDE (len 254, WS 0, PS 4) @ 0xBDB4
[   23.877460] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios stuck executing B832 (len 143, WS 0, PS 8) @ 0xB8A9
[   23.889753] amdgpu 0000:84:00.0: gpu post error!
[   23.895213] amdgpu 0000:84:00.0: Fatal error during GPU init
[   23.901842] [drm] amdgpu: finishing device.
[   23.906818] ------------[ cut here ]------------
[   23.912282] WARNING: CPU: 1 PID: 414 at ../../../../../../../../usr/src/linux-4.11-rc7-coreos/drivers/gpu/drm/drm_modeset_lock.c:345 drm_modeset_lock+0xcf/0xe0 [drm]
[   23.929623] Modules linked in: sch_fq_codel amdkfd ipmi_ssif amd_iommu_v2 coretemp amdgpu(+) sb_edac edac_core i2c_algo_bit x86_pkg_temp_thermal drm_kms_helper ib_ipoib ttm kvm_intel drm kvm i2c_core ipmi_si syscopyarea mei_me sysfillrect ipmi_devintf sysimgblt fb_sys_4
[   23.996836] CPU: 1 PID: 414 Comm: kworker/1:1 Not tainted 4.11.0-rc7-coreos #1
[   24.005416] Hardware name: Dell Inc. PowerEdge R730/0WCJNT, BIOS 2.2.5 09/06/2016
[   24.014324] Workqueue: events work_for_cpu_fn
[   24.019483] Call Trace:
[   24.022517]  dump_stack+0x63/0x90
[   24.026538]  __warn+0xd1/0xf0
[   24.030166]  warn_slowpath_null+0x1d/0x20
[   24.034944]  drm_modeset_lock+0xcf/0xe0 [drm]
[   24.040127]  drm_modeset_lock_all_ctx+0x22/0xb0 [drm]
[   24.046062]  drm_modeset_lock_all+0x60/0xc0 [drm]
[   24.051631]  drm_crtc_force_disable_all+0x21/0x80 [drm]
[   24.057788]  amdgpu_device_fini+0x2d/0x130 [amdgpu]
[   24.063564]  amdgpu_driver_unload_kms+0x4f/0xa0 [amdgpu]
[   24.069837]  amdgpu_driver_load_kms+0x109/0x1e0 [amdgpu]
[   24.076090]  drm_dev_register+0x148/0x1e0 [drm]
[   24.081466]  drm_get_pci_dev+0xa0/0x160 [drm]
[   24.086638]  amdgpu_drm_ioctl+0x469/0x1800 [amdgpu]
[   24.092401]  local_pci_probe+0x45/0xa0
[   24.096884]  work_for_cpu_fn+0x14/0x20
[   24.101372]  process_one_work+0x156/0x400
[   24.106143]  worker_thread+0x1d7/0x4a0
[   24.110627]  kthread+0x109/0x140
[   24.110628]  ? rescuer_thread+0x370/0x370
[   24.110629]  ? kthread_park+0x90/0x90
[   24.110632]  ret_from_fork+0x2c/0x40
[   24.110638] ---[ end trace d07c4173d99584dd ]---
[   24.110641] BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
[   24.110643] IP: ww_mutex_lock+0x24/0x90
[   24.110644] PGD 0
[   24.110644]
[   24.110645] Oops: 0002 [#1] SMP
[   24.110646] Modules linked in: sch_fq_codel amdkfd ipmi_ssif amd_iommu_v2 coretemp amdgpu(+) sb_edac edac_core i2c_algo_bit x86_pkg_temp_thermal drm_kms_helper ib_ipoib ttm kvm_intel drm kvm i2c_core ipmi_si syscopyarea mei_me sysfillrect ipmi_devintf sysimgblt fb_sys_4
[   24.110661] CPU: 1 PID: 414 Comm: kworker/1:1 Tainted: G        W       4.11.0-rc7-coreos #1
[   24.110662] Hardware name: Dell Inc. PowerEdge R730/0WCJNT, BIOS 2.2.5 09/06/2016
[   24.110663] Workqueue: events work_for_cpu_fn
[   24.110663] task: ffff966db0e3bb00 task.stack: ffffbc73d99c4000
[   24.110665] RIP: 0010:ww_mutex_lock+0x24/0x90
[   24.110665] RSP: 0018:ffffbc73d99c7c38 EFLAGS: 00010246
[   24.110666] RAX: 0000000000000000 RBX: 0000000000000018 RCX: 000000000000001f
[   24.110666] RDX: ffff966db0e3bb00 RSI: ffff966d704d3e40 RDI: 0000000000000018
[   24.110667] RBP: ffffbc73d99c7c50 R08: 0000000000000000 R09: 0000000000000024
[   24.110667] R10: ffffbc73d8c5bda8 R11: 0000000000000000 R12: ffff966d704d3e40
[   24.110668] R13: fffffffffffffff0 R14: ffff966d772c4b50 R15: 0000000000000000
[   24.110668] FS:  0000000000000000(0000) GS:ffff966dbee00000(0000) knlGS:0000000000000000
[   24.110669] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.110669] CR2: 0000000000000018 CR3: 00000031a7c09000 CR4: 00000000003406e0
[   24.110670] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   24.110671] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   24.110671] Call Trace:
[   24.110675]  drm_modeset_lock+0x35/0xe0 [drm]
[   24.110678]  drm_modeset_lock_all_ctx+0x5a/0xb0 [drm]
[   24.110682]  drm_modeset_lock_all+0x60/0xc0 [drm]
[   24.110685]  drm_crtc_force_disable_all+0x21/0x80 [drm]
[   24.110692]  amdgpu_device_fini+0x2d/0x130 [amdgpu]
[   24.110699]  amdgpu_driver_unload_kms+0x4f/0xa0 [amdgpu]
[   24.110705]  amdgpu_driver_load_kms+0x109/0x1e0 [amdgpu]
[   24.110708]  drm_dev_register+0x148/0x1e0 [drm]
[   24.110711]  drm_get_pci_dev+0xa0/0x160 [drm]
[   24.110717]  amdgpu_drm_ioctl+0x469/0x1800 [amdgpu]
[   24.110719]  local_pci_probe+0x45/0xa0
[   24.110720]  work_for_cpu_fn+0x14/0x20
[   24.110721]  process_one_work+0x156/0x400
[   24.110724]  worker_thread+0x1d7/0x4a0
[   24.110725]  kthread+0x109/0x140
[   24.110726]  ? rescuer_thread+0x370/0x370
[   24.110727]  ? kthread_park+0x90/0x90
[   24.110728]  ret_from_fork+0x2c/0x40
[   24.110728] Code: 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41 55 41 54 53 49 89 f4 48 89 fb e8 07 e4 ff ff 65 48 8b 14 25 40 d4 00 00 31 c0 <f0> 48 0f b1 13 48 85 c0 75 22 4d 85 e4 74 14 41 83 44 24 10 01
[   24.110741] RIP: ww_mutex_lock+0x24/0x90 RSP: ffffbc73d99c7c38
[   24.110741] CR2: 0000000000000018
[   24.110761] ---[ end trace d07c4173d99584de ]---
[   24.152994] Kernel panic - not syncing: Fatal exception
[   24.271827] Kernel Offset: 0x3b000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   24.704781] Rebooting in 60 seconds..


--nextPart4324970.2gPpy4JKQ1--

--nextPart1793462.Hr3FWkTLFR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQG0BAABCAAGBQJY/3OZAAoJENS5dBsVnRQdinwMwKDiUMsiROiwyKgrbyfCj/pX
Y1RGcWHEBhsnyA5EQk6LsKIWAwPjxtHM0f7MDOiWx+HcD9jjb6BU+OXFq4jbrDmY
xX6SCGyGusqLFxrm/3HFv3t0nDo/HvUaYizkc+EWGvt90sjO4dRcqDg9wrjEL4wr
xUBEq3b/P0CKEi+xwDQGsPpM+Mpp3LEZ6a/FnpjUqeFtvCsqf3S3FMqeKfW3UdTL
yx3D3d9HbcUjCR954BzncUZirDBB57BjJlUp7tDT83tnvlJR6/yX3gmwJozp/WGe
1Afaq7ODHS/DIFUY9X5M2QwyMiul/t3VupbZfZJ6L3T6GUetx7EnPLy+QMgyCwdu
hEkuL8TxktCbC+oxlv1G4QZhxfBfU0iauviCsoUg13cNBGZGNcymrbYEWQXGli38
QxLsbQXQa1xFdn7h9SRrreBV+BTllXaeANoqZqDUiXDiwzcC022ez5+/6p3UxAK0
xzPTbbbbWDvRGuLUedWl0qWjITuuLaLkMtHjAZx9UTqyXPWIMMrIBgYDMSYnqJUw
v1h9X1zpog==
=3ph+
-----END PGP SIGNATURE-----

--nextPart1793462.Hr3FWkTLFR--


--===============0066720288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0066720288==--
