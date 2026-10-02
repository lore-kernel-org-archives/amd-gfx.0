Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E44CA6001
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 07:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6864D10EBC9;
	Mon,  5 Oct 2026 07:28:13 +0000 (UTC)
Received: from mail.sig21.net (mail.sig21.net [217.197.84.222])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3A6E10E3B6
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 19:25:48 +0000 (UTC)
Received: from localhorst ([127.0.0.1]) by mail.sig21.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96) (envelope-from <js@sig21.net>) id 1xCisz-00089N-1u ;
 Fri, 02 Oct 2026 21:25:41 +0200
Received: from js by abc.local with local (Exim 4.100.1)
 (envelope-from <js@sig21.net>) id 1xCisk-0000000016l-2mms;
 Fri, 02 Oct 2026 21:25:22 +0200
Date: Fri, 2 Oct 2026 21:25:22 +0200
From: Johannes Stezenbach <js@sig21.net>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
Subject: Re: amdgpu causes boot failure after BIOS update AGESA ComboAM5
 1.3.0.1a on Asrock X600
Message-ID: <asAFItSKC74Lm9mT@sig21.net>
References: <ar-GzWfyQMeRTRCt@sig21.net>
 <CADnq5_ODecWYOwbBYDnV-aeAi+pCMoxJvufuzY8_4yf5cF0dEg@mail.gmail.com>
 <2b4560f5-3458-4218-89f7-509c298b2126@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="00jXfCJbUwNZmHBk"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b4560f5-3458-4218-89f7-509c298b2126@amd.com>
X-Mailman-Approved-At: Mon, 05 Oct 2026 07:28:12 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--00jXfCJbUwNZmHBk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Oct 02, 2026 at 11:12:10AM -0500, Mario Limonciello wrote:
> On 10/2/26 10:47, Alex Deucher wrote:
> > On Fri, Oct 2, 2026 at 8:52 AM Johannes Stezenbach <js@sig21.net> wrote:
> > > 
> > > I have one Asrock Deskmini X600 with Ryzen 8700G.
> > > Recently a BIOS update was released which updates
> > > AGESA ComboAM5 from 1.2.0.3g to  1.3.0.1a.
> > > 
> > > https://www.asrock.com/nettop/AMD/DeskMini%20X600%20Series/index.asp#BIOS
> > > 
> > > The result is boot failure before any message could be printed
> > > with my self-built kernel, which has the amdgpu driver built-in.
> > > However, a Debian rescue image with kernel 7.2.8 could boot
> > > (in text mode or vesa graphics mode).
> > > 
> > > Using the rescue system, I installed the Debian kernel 7.2.8,
> > > it can boot but hangs after the amdgpu module is loaded
> > > (no error message or crash output).
> > > It can boot successfully with module_blacklist=amdgpu.
> > > 
> > > https://packages.debian.org/forky/linux-image-7.2.8+deb14-amd64
> > > 
> > > If you have any ideas what to try please let me know soon,
> > > otherwise I'll have to downgrade to the previous BIOS version.
> > 
> > Can you get ssh access to the system?  Can you boot without amdgpu and
> > then log in remotely and manually load amdgpu and get the dmesg
> > output?
> 
> Depending upon how early it hangs, anything saved into the journal from
> previous boot?  You can try:
> 
> # journalctl -k -b-1
> 
> Also; what is the version of your DMCUB
> (/lib/firmware/amdgpu/dcn_3_1_4_dmcub.bin.zst)?
> 
> You can use this script to parse it:
> 
> https://gitlab.com/kernel-firmware/linux-firmware/-/blob/main/contrib/get_amdgpu_fw_version.py?ref_type=heads
> 
> If you upgrade to the latest upstream version does it help?

I have the latest upstream version (it is in Debian sid):

$ ./get_amdgpu_fw_version.py /lib/firmware/amdgpu/dcn_3_1_4_dmcub.bin
dcn_3_1_4_dmcub.bin: DMCUB FW
        ip_major = 3 (0x3)
        ip_minor = 1 (0x1)
   ucode_version = 134242816 (0x8006200)
     ucode_bytes = 350240 (0x55820)
           crc32 = 3448435613 (0xcd8af39d)
--------------------------------
Detailed uCode version:
           major = 8 (0x8)
           minor = 0 (0x0)
        revision = 98 (0x62)
         is_test = 0 (0x0)
        is_vbios = 0 (0x0)
          hotfix = 0 (0x0)

Now it gets a bit mysterious: The Debian kernel booted
successfully a few times in a row, while earlier today it
always failed in a few tries. But eventually I reproduced the
failure and got the attached log.
Screen output stopped after the "[drm] ATOM BIOS:
113-PHXGENERIC-001..." line (i.e. before "Console: switching to
colour dummy device 80x25").

I notice now that I still have the amd_iommu_intr=legacy option
which I needed to fix hibernation, let me know if you think
it's related. For all I know I still need it.
https://bugzilla.kernel.org/show_bug.cgi?id=221036

However, my self-built kernel still crashes early after I changed
amdgpu to be a loadable module. So there is something else going
on, but lets concentrate on the andgpu failure with the Debian kernel.


Best Regards,
Johannes


--00jXfCJbUwNZmHBk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg-debian-7.2.8.txt
Content-Transfer-Encoding: quoted-printable

[    0.008254]   node   0: [mem 0x0000000000100000-0x00000000099fefff]
[    0.008254]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.008255]   node   0: [mem 0x000000000a23c000-0x000000008207efff]
[    0.008255]   node   0: [mem 0x00000000941ff000-0x0000000099326fff]
[    0.008255]   node   0: [mem 0x0000000099329000-0x0000000099ff9fff]
[    0.008256]   node   0: [mem 0x0000000099ffd000-0x0000000099ffffff]
[    0.008256]   node   0: [mem 0x0000000100000000-0x0000000fde2fffff]
[    0.008260] Initmem setup node 0 [mem 0x0000000000001000-0x0000000fde2ff=
fff]
[    0.008265] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.008276] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.008367] On node 0, zone DMA32: 1537 pages in unavailable ranges
[    0.009601] On node 0, zone DMA32: 60 pages in unavailable ranges
[    0.009752] On node 0, zone DMA32: 41344 pages in unavailable ranges
[    0.009762] On node 0, zone DMA32: 2 pages in unavailable ranges
[    0.009762] On node 0, zone DMA32: 3 pages in unavailable ranges
[    0.009923] On node 0, zone Normal: 24576 pages in unavailable ranges
[    0.009940] On node 0, zone Normal: 7424 pages in unavailable ranges
[    0.009950] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16 =
nr_node_ids:1
[    0.010167] percpu: Embedded 63 pages/cpu s221184 r8192 d28672 u262144
[    0.010171] pcpu-alloc: s221184 r8192 d28672 u262144 alloc=3D1*2097152
[    0.010173] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 1=
3 14 15=20
[    0.010192] Kernel command line: BOOT_IMAGE=3D/vmlinuz-7.2.8+deb14-amd64=
 root=3D/dev/mapper/foo--vg-root ro net.ifnames=3Dno amd_iommu_intr=3Dlegacy
[    0.010422] printk: log buffer data + meta data: 131072 + 557056 =3D 688=
128 bytes
[    0.012659] Dentry cache hash table entries: 8388608 (order: 14, 6710886=
4 bytes, linear)
[    0.013806] Inode-cache hash table entries: 4194304 (order: 13, 33554432=
 bytes, linear)
[    0.013923] software IO TLB: area num 16.
[    0.018383] Fallback order for Node 0: 0=20
[    0.018389] Built 1 zonelists, mobility grouping on.  Total pages: 16145=
117
[    0.018390] Policy zone: Normal
[    0.018397] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.024281] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D16, =
Nodes=3D1
[    0.031054] ftrace: allocating 49332 entries in 196 pages
[    0.031056] ftrace: allocated 196 pages with 3 groups
[    0.031405] Dynamic Preempt: lazy
[    0.031452] rcu: Preemptible hierarchical RCU implementation.
[    0.031453] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D16.
[    0.031454] 	Trampoline variant of Tasks RCU enabled.
[    0.031454] 	Rude variant of Tasks RCU enabled.
[    0.031454] 	Tracing variant of Tasks RCU enabled.
[    0.031455] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.
[    0.031455] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D16
[    0.031464] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjus=
t=3D1 rcu_task_cpu_ids=3D16.
[    0.031466] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_=
adjust=3D1 rcu_task_cpu_ids=3D16.
[    0.034131] NR_IRQS: 524544, nr_irqs: 1096, preallocated irqs: 16
[    0.034327] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.034358] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns
[    0.034460] Console: colour dummy device 80x25
[    0.034461] printk: legacy console [tty0] enabled
[    0.034643] ACPI: Core revision 20260408
[    0.034848] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 133484873504 ns
[    0.034868] APIC: Switch to symmetric I/O mode setup
[    0.035102] AMD-Vi: ivrs, add hid:AMDI0020, uid:ID00, rdevid:0xa0
[    0.035105] AMD-Vi: ivrs, add hid:AMDI0020, uid:ID01, rdevid:0xa0
[    0.035106] AMD-Vi: ivrs, add hid:AMDI0020, uid:ID02, rdevid:0xa0
[    0.035107] AMD-Vi: ivrs, add hid:AMDI0020, uid:ID03, rdevid:0x98
[    0.035109] AMD-Vi: ivrs, add hid:AMDI0020, uid:ID04, rdevid:0x98
[    0.035110] AMD-Vi: Using global IVHD EFR:0x246577efa2254afa, EFR2:0x0
[    0.036454] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.054874] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x3c8a3ad9329, max_idle_ns: 440795322761 ns
[    0.054879] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 8399.91 BogoMIPS (lpj=3D16799836)
[    0.054900] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.054931] LVT offset 1 assigned for vector 0xf9
[    0.054933] LVT offset 2 assigned for vector 0xf4
[    0.055136] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
[    0.055137] Last level dTLB entries: 4KB 3072, 2MB 3072, 4MB 1536, 1GB 0
[    0.055141] process: using mwait in idle threads
[    0.055143] mitigations: Enabled attack vectors: user_kernel, user_user,=
 guest_host, guest_guest, SMT mitigations: auto
[    0.055147] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl
[    0.055150] Transient Scheduler Attacks: Mitigation: Clear CPU buffers
[    0.055151] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.055152] Spectre V2 : User space: Mitigation: STIBP always-on protect=
ion
[    0.055154] Speculative Return Stack Overflow: Mitigation: Safe RET
[    0.055155] VMSCAPE: Mitigation: IBPB before exit to userspace
[    0.055156] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.055160] Spectre V2 : Enabling IBPB for BPF
[    0.055162] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.055164] active return thunk: srso_alias_return_thunk
[    0.055173] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.055175] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.055176] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.055177] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.055179] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.055180] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.055181] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys Us=
er registers'
[    0.055182] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User =
registers'
[    0.055184] x86/fpu: Supporting XSAVE feature 0x1000: 'Control-flow Kern=
el registers (KVM only)'
[    0.055186] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.055187] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.055189] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.055190] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.055191] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.055192] x86/fpu: xstate_offset[11]: 2440, xstate_sizes[11]:   16
[    0.055193] x86/fpu: xstate_offset[12]: 2456, xstate_sizes[12]:   24
[    0.055194] x86/fpu: Enabled xstate features 0x1ae7, context size is 248=
0 bytes, using 'compacted' format.
[    0.076832] pid_max: default: 32768 minimum: 301
[    0.076938] landlock: Up and running.
[    0.076941] Yama: disabled by default; enable with sysctl kernel.yama.*
[    0.077013] AppArmor: AppArmor initialized
[    0.077035] TOMOYO Linux initialized
[    0.077197] LSM support for eBPF active
[    0.077287] Mount-cache hash table entries: 131072 (order: 8, 1048576 by=
tes, linear)
[    0.077325] Mountpoint-cache hash table entries: 131072 (order: 8, 10485=
76 bytes, linear)
[    0.077383] VFS: Finished mounting rootfs on nullfs
[    0.185739] smpboot: CPU0: AMD Ryzen 7 8700G w/ Radeon 780M Graphics (fa=
mily: 0x19, model: 0x75, stepping: 0x2)
[    0.185907] Performance Events: Fam17h+ 16-deep LBR, core perfctr, AMD P=
MU driver.
[    0.185937] ... version:                   2
[    0.185940] ... bit width:                 48
[    0.185942] ... generic counters:          6
[    0.185944] ... generic bitmap:            000000000000003f
[    0.185947] ... fixed-purpose counters:    0
[    0.185949] ... fixed-purpose bitmap:      0000000000000000
[    0.185951] ... value mask:                0000ffffffffffff
[    0.185954] ... max period:                00007fffffffffff
[    0.185956] ... global_ctrl mask:          000000000000003f
[    0.186056] signal: max sigframe size: 3376
[    0.186089] rcu: Hierarchical SRCU implementation.
[    0.186092] rcu: 	Max phase no-delay instances is 1000.
[    0.186132] Timer migration: 2 hierarchy levels; 8 children per group; 2=
 crossnode level
[    0.186938] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.187051] smp: Bringing up secondary CPUs ...
[    0.187147] smpboot: x86: Booting SMP configuration:
[    0.187151] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  =
#9 #10 #11 #12 #13 #14 #15
[    0.204878] Spectre V2 : Update user space SMT mitigation: STIBP always-=
on
[    0.220878] smp: Brought up 1 node, 16 CPUs
[    0.220878] smpboot: Total of 16 processors activated (134398.68 BogoMIP=
S)
[    0.254883] node 0 deferred pages initialised in 36ms
[    0.256322] Memory: 63142212K/64580468K available (19221K kernel code, 3=
435K rwdata, 13712K rodata, 4648K init, 3780K bss, 1418560K reserved, 0K cm=
a-reserved)
[    0.256322] devtmpfs: initialized
[    0.256322] x86/mm: Memory block size: 128MB
[    0.262931] ACPI: PM: Registering ACPI NVS region [mem 0x0a200000-0x0a23=
bfff] (245760 bytes)
[    0.262931] ACPI: PM: Registering ACPI NVS region [mem 0x901ff000-0x921f=
efff] (33554432 bytes)
[    0.263144] ACPI: PM: Registering ACPI NVS region [mem 0x99327000-0x9932=
8fff] (8192 bytes)
[    0.263188] posixtimers hash table entries: 8192 (order: 5, 131072 bytes=
, linear)
[    0.263188] futex hash table entries: 4096 (262144 bytes on 1 NUMA nodes=
, total 256 KiB, linear).
[    0.263300] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.263479] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.263539] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.263599] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.263607] audit: initializing netlink subsys (disabled)
[    0.263614] audit: type=3D2000 audit(1790967288.228:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.271499] thermal_sys: Registered thermal governor 'fair_share'
[    0.271500] thermal_sys: Registered thermal governor 'bang_bang'
[    0.271503] thermal_sys: Registered thermal governor 'step_wise'
[    0.271506] thermal_sys: Registered thermal governor 'user_space'
[    0.271509] thermal_sys: Registered thermal governor 'power_allocator'
[    0.271518] cpuidle: using governor ladder
[    0.271518] cpuidle: using governor menu
[    0.271518] Freeing SMP alternatives memory: 48K
[    0.278011] efi: Freeing EFI boot services memory: 167668K
[    0.278016] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.278104] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for =
domain 0000 [bus 00-ff]
[    0.278119] PCI: Using configuration type 1 for base access
[    0.278185] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.278185] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.278185] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.278185] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.278185] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.279298] ACPI: Added _OSI(Module Device)
[    0.279302] ACPI: Added _OSI(Processor Device)
[    0.279305] ACPI: Added _OSI(Processor Aggregator Device)
[    0.290713] ACPI: 13 ACPI AML tables successfully acquired and loaded
[    0.295885] ACPI: \_SB_: platform _OSC: OS support mask [002e7eff]
[    0.295885] ACPI: Interpreter enabled
[    0.295885] ACPI: PM: (supports S0 S3 S4 S5)
[    0.295885] ACPI: Using IOAPIC for interrupt routing
[    0.295963] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.295967] PCI: Ignoring E820 reservations for host bridge windows
[    0.296225] ACPI: Enabled 8 GPEs in block 00 to 1F
[    0.298927] ACPI: \_SB_.PCI0.GP11.PWRS: New power resource
[    0.299360] ACPI: \_SB_.PCI0.GP11.SWUS.PWRS: New power resource
[    0.299789] ACPI: \_SB_.PCI0.GP12.PWRS: New power resource
[    0.300202] ACPI: \_SB_.PCI0.GP12.SWUS.PWRS: New power resource
[    0.300994] ACPI: \_SB_.PCI0.GP17.XHC0.P0U0: New power resource
[    0.303132] ACPI: \_SB_.PCI0.GP17.XHC1.P0U1: New power resource
[    0.305173] ACPI: \_SB_.PCI0.GP19.XHC3.PWRS: New power resource
[    0.305926] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
[    0.306676] ACPI: \_SB_.PCI0.GP19.NHI0.PWRS: New power resource
[    0.307106] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
[    0.307372] ACPI: \_SB_.PCI0.GPP1.P0NV: New power resource
[    0.307930] ACPI: \_SB_.PCI0.GPP5.PWRS: New power resource
[    0.308050] ACPI: \_SB_.PCI0.GPP6.PWR1: New power resource
[    0.311649] ACPI: \_SB_.PRWL: New power resource
[    0.311673] ACPI: \_SB_.PRWB: New power resource
[    0.312213] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.312219] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    0.312314] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME AER PCIeCapability LTR]
[    0.312707] PCI host bridge to bus 0000:00
[    0.312711] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.312715] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.312718] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.312721] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.312725] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dfff=
f window]
[    0.312728] pci_bus 0000:00: root bus resource [mem 0xf2000000-0xf6fffff=
f window]
[    0.312732] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xf1fffff=
f window]
[    0.312735] pci_bus 0000:00: root bus resource [mem 0xa0000000-0xdffffff=
f window]
[    0.312739] pci_bus 0000:00: root bus resource [mem 0x1060000000-0xfcfff=
fffff window]
[    0.312743] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.312758] pci 0000:00:00.0: [1022:14e8] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.312864] pci 0000:00:00.2: [1022:14e9] type 00 class 0x080600 convent=
ional PCI endpoint
[    0.312959] pci 0000:00:01.0: [1022:14ea] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.313062] pci 0000:00:01.1: [1022:14ed] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.313173] pci 0000:00:01.1: PCI bridge to [bus 01-6a]
[    0.313181] pci 0000:00:01.1:   bridge window [io  0xa000-0xcfff]
[    0.313186] pci 0000:00:01.1:   bridge window [mem 0xac000000-0xdc1fffff]
[    0.313212] pci 0000:00:01.1:   bridge window [mem 0xfc80000000-0xfcdfff=
ffff 64bit pref]
[    0.313323] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.313498] pci 0000:00:01.2: [1022:14ee] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.313516] pci 0000:00:01.2: PCI bridge to [bus 6b]
[    0.313522] pci 0000:00:01.2:   bridge window [io  0xf000-0xffff]
[    0.313527] pci 0000:00:01.2:   bridge window [mem 0xdcd00000-0xdcdfffff]
[    0.313613] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.313747] pci 0000:00:02.0: [1022:14ea] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.313841] pci 0000:00:02.3: [1022:14ee] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.313859] pci 0000:00:02.3: PCI bridge to [bus 6c]
[    0.313865] pci 0000:00:02.3:   bridge window [io  0xe000-0xefff]
[    0.313869] pci 0000:00:02.3:   bridge window [mem 0xdcc00000-0xdccfffff]
[    0.313953] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
[    0.314088] pci 0000:00:02.4: [1022:14ee] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.314107] pci 0000:00:02.4: PCI bridge to [bus 6d]
[    0.314114] pci 0000:00:02.4:   bridge window [mem 0xdcb00000-0xdcbfffff]
[    0.314199] pci 0000:00:02.4: PME# supported from D0 D3hot D3cold
[    0.314330] pci 0000:00:03.0: [1022:14ea] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.314416] pci 0000:00:04.0: [1022:14ea] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.314506] pci 0000:00:08.0: [1022:14ea] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.314586] pci 0000:00:08.1: [1022:14eb] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.314602] pci 0000:00:08.1: PCI bridge to [bus 6e]
[    0.314607] pci 0000:00:08.1:   bridge window [io  0xd000-0xdfff]
[    0.314611] pci 0000:00:08.1:   bridge window [mem 0xdc400000-0xdc9fffff]
[    0.314618] pci 0000:00:08.1:   bridge window [mem 0xfce0000000-0xfcefff=
ffff 64bit pref]
[    0.314627] pci 0000:00:08.1: enabling Extended Tags
[    0.314666] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.314796] pci 0000:00:08.2: [1022:14eb] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.314829] pci 0000:00:08.2: PCI bridge to [bus 6f]
[    0.314835] pci 0000:00:08.2:   bridge window [mem 0xdca00000-0xdcafffff]
[    0.314843] pci 0000:00:08.2:   bridge window [mem 0xfcf0000000-0xfcf00f=
ffff 64bit pref]
[    0.314851] pci 0000:00:08.2: enabling Extended Tags
[    0.314910] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
[    0.315006] pci 0000:00:08.3: [1022:14eb] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.315022] pci 0000:00:08.3: PCI bridge to [bus 70]
[    0.315037] pci 0000:00:08.3: enabling Extended Tags
[    0.315076] pci 0000:00:08.3: PME# supported from D0 D3hot D3cold
[    0.315197] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 convent=
ional PCI endpoint
[    0.315313] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 convent=
ional PCI endpoint
[    0.315437] pci 0000:00:18.0: [1022:14f0] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.315476] pci 0000:00:18.1: [1022:14f1] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.315513] pci 0000:00:18.2: [1022:14f2] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.315550] pci 0000:00:18.3: [1022:14f3] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.315586] pci 0000:00:18.4: [1022:14f4] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.315623] pci 0000:00:18.5: [1022:14f5] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.315661] pci 0000:00:18.6: [1022:14f6] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.315698] pci 0000:00:18.7: [1022:14f7] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.315889] pci 0000:01:00.0: [144d:a80c] type 00 class 0x010802 PCIe En=
dpoint
[    0.315924] pci 0000:01:00.0: BAR 0 [mem 0xac000000-0xac003fff 64bit]
[    0.316184] pci 0000:00:01.1: PCI bridge to [bus 01-6a]
[    0.316305] pci 0000:6b:00.0: [1b21:0612] type 00 class 0x010601 PCIe Le=
gacy Endpoint
[    0.316349] pci 0000:6b:00.0: BAR 0 [io  0xf050-0xf057]
[    0.316353] pci 0000:6b:00.0: BAR 1 [io  0xf040-0xf043]
[    0.316357] pci 0000:6b:00.0: BAR 2 [io  0xf030-0xf037]
[    0.316361] pci 0000:6b:00.0: BAR 3 [io  0xf020-0xf023]
[    0.316365] pci 0000:6b:00.0: BAR 4 [io  0xf000-0xf01f]
[    0.316369] pci 0000:6b:00.0: BAR 5 [mem 0xdcd00000-0xdcd001ff]
[    0.316510] pci 0000:00:01.2: PCI bridge to [bus 6b]
[    0.316627] pci 0000:6c:00.0: [10ec:8125] type 00 class 0x020000 PCIe En=
dpoint
[    0.316676] pci 0000:6c:00.0: BAR 0 [io  0xe000-0xe0ff]
[    0.316683] pci 0000:6c:00.0: BAR 2 [mem 0xdcc00000-0xdcc0ffff 64bit]
[    0.316688] pci 0000:6c:00.0: BAR 4 [mem 0xdcc10000-0xdcc13fff 64bit]
[    0.316791] pci 0000:6c:00.0: supports D1 D2
[    0.316794] pci 0000:6c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.316998] pci 0000:00:02.3: PCI bridge to [bus 6c]
[    0.317167] pci 0000:6d:00.0: [8086:2725] type 00 class 0x028000 PCIe En=
dpoint
[    0.317247] pci 0000:6d:00.0: BAR 0 [mem 0xdcb00000-0xdcb03fff 64bit]
[    0.317397] pci 0000:6d:00.0: PME# supported from D0 D3hot D3cold
[    0.317683] pci 0000:00:02.4: PCI bridge to [bus 6d]
[    0.317783] pci 0000:6e:00.0: [1002:15bf] type 00 class 0x030000 PCIe Le=
gacy Endpoint
[    0.317813] pci 0000:6e:00.0: BAR 0 [mem 0xfce0000000-0xfcefffffff 64bit=
 pref]
[    0.317818] pci 0000:6e:00.0: BAR 2 [mem 0xdc400000-0xdc5fffff 64bit pre=
f]
[    0.317822] pci 0000:6e:00.0: BAR 4 [io  0xd000-0xd0ff]
[    0.317825] pci 0000:6e:00.0: BAR 5 [mem 0xdc900000-0xdc97ffff]
[    0.317833] pci 0000:6e:00.0: enabling Extended Tags
[    0.317896] pci 0000:6e:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.318030] pci 0000:6e:00.1: [1002:1640] type 00 class 0x040300 PCIe Le=
gacy Endpoint
[    0.318057] pci 0000:6e:00.1: BAR 0 [mem 0xdc988000-0xdc98bfff]
[    0.318067] pci 0000:6e:00.1: enabling Extended Tags
[    0.318107] pci 0000:6e:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.318200] pci 0000:6e:00.2: [1022:15c7] type 00 class 0x108000 PCIe En=
dpoint
[    0.318229] pci 0000:6e:00.2: BAR 2 [mem 0xdc800000-0xdc8fffff]
[    0.318234] pci 0000:6e:00.2: BAR 5 [mem 0xdc98c000-0xdc98dfff]
[    0.318241] pci 0000:6e:00.2: enabling Extended Tags
[    0.318347] pci 0000:6e:00.3: [1022:15b9] type 00 class 0x0c0330 PCIe En=
dpoint
[    0.318376] pci 0000:6e:00.3: BAR 0 [mem 0xdc700000-0xdc7fffff 64bit]
[    0.318386] pci 0000:6e:00.3: enabling Extended Tags
[    0.318428] pci 0000:6e:00.3: PME# supported from D0 D3hot D3cold
[    0.318528] pci 0000:6e:00.4: [1022:15ba] type 00 class 0x0c0330 PCIe En=
dpoint
[    0.318557] pci 0000:6e:00.4: BAR 0 [mem 0xdc600000-0xdc6fffff 64bit]
[    0.318567] pci 0000:6e:00.4: enabling Extended Tags
[    0.318609] pci 0000:6e:00.4: PME# supported from D0 D3hot D3cold
[    0.318706] pci 0000:6e:00.6: [1022:15e3] type 00 class 0x040300 PCIe En=
dpoint
[    0.318733] pci 0000:6e:00.6: BAR 0 [mem 0xdc980000-0xdc987fff]
[    0.318744] pci 0000:6e:00.6: enabling Extended Tags
[    0.318783] pci 0000:6e:00.6: PME# supported from D0 D3hot D3cold
[    0.318903] pci 0000:00:08.1: PCI bridge to [bus 6e]
[    0.318959] pci 0000:6f:00.0: [1022:14ec] type 00 class 0x130000 PCIe En=
dpoint
[    0.318993] pci 0000:6f:00.0: enabling Extended Tags
[    0.319045] pci 0000:6f:00.0: PME# supported from D3hot D3cold
[    0.319140] pci 0000:6f:00.1: [1022:1502] type 00 class 0x118000 PCIe En=
dpoint
[    0.319175] pci 0000:6f:00.1: BAR 0 [mem 0xdca00000-0xdca7ffff]
[    0.319178] pci 0000:6f:00.1: BAR 1 [mem 0xdcac0000-0xdcac1fff]
[    0.319183] pci 0000:6f:00.1: BAR 2 [mem 0xfcf0000000-0xfcf003ffff 64bit=
 pref]
[    0.319187] pci 0000:6f:00.1: BAR 4 [mem 0xdca80000-0xdcabffff]
[    0.319195] pci 0000:6f:00.1: enabling Extended Tags
[    0.319335] pci 0000:00:08.2: PCI bridge to [bus 6f]
[    0.319405] pci 0000:70:00.0: [1022:14ec] type 00 class 0x130000 PCIe En=
dpoint
[    0.319439] pci 0000:70:00.0: enabling Extended Tags
[    0.319568] pci 0000:00:08.3: PCI bridge to [bus 70]
[    0.322929] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.322966] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.323000] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.323038] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.323073] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.323102] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.323131] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.323161] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.324079] iommu: Default domain type: Translated
[    0.324079] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.331177] pps_core: LinuxPPS API ver. 1 registered
[    0.331181] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    0.331186] PTP clock support registered
[    0.331195] EDAC MC: Ver: 3.0.0
[    0.331370] efivars: Registered efivars operations
[    0.331370] NetLabel: Initializing
[    0.331370] NetLabel:  domain hash size =3D 128
[    0.331370] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.331370] NetLabel:  unlabeled traffic allowed by default
[    0.331370] PCI: Using ACPI for IRQ routing
[    0.339344] PCI: pci_cache_line_size set to 64 bytes
[    0.339569] e820: register RAM buffer resource [mem 0x099ff000-0x0bfffff=
f]
[    0.339573] e820: register RAM buffer resource [mem 0x0a200000-0x0bfffff=
f]
[    0.339576] e820: register RAM buffer resource [mem 0x7b034000-0x7bfffff=
f]
[    0.339579] e820: register RAM buffer resource [mem 0x7d286000-0x7ffffff=
f]
[    0.339581] e820: register RAM buffer resource [mem 0x8207f000-0x83fffff=
f]
[    0.339584] e820: register RAM buffer resource [mem 0x99327000-0x9bfffff=
f]
[    0.339587] e820: register RAM buffer resource [mem 0x99ffa000-0x9bfffff=
f]
[    0.339590] e820: register RAM buffer resource [mem 0x9a000000-0x9bfffff=
f]
[    0.339593] e820: register RAM buffer resource [mem 0xfde300000-0xfdffff=
fff]
[    0.339639] pci 0000:6e:00.0: vgaarb: setting as boot VGA device
[    0.339639] pci 0000:6e:00.0: vgaarb: bridge control possible
[    0.339639] pci 0000:6e:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    0.339639] vgaarb: loaded
[    0.339639] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.339639] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.341008] clocksource: Switched to clocksource tsc-early
[    0.341153] VFS: Disk quotas dquot_6.6.0
[    0.341164] VFS: Dquot-cache hash table entries: 512 (4096 bytes)
[    0.341176] AppArmor: AppArmor Filesystem Enabled
[    0.341176] acpi PNP0C01:00: Reserved [mem 0xe0000000-0xefffffff]
[    0.341176] acpi PNP0C02:00: Could not reserve [mem 0xf7500000-0xf757fff=
f]
[    0.341176] acpi PNP0C02:01: Reserved [mem 0xfe0000000-0x105fffffff]
[    0.341176] acpi PNP0C02:02: Reserved [io  0x0a00-0x0a0f]
[    0.341176] acpi PNP0C02:02: Reserved [io  0x0a10-0x0a1f]
[    0.341176] acpi PNP0C02:02: Reserved [io  0x0a20-0x0a2f]
[    0.341176] acpi PNP0C02:03: Skipped [io  0x0010-0x001f]
[    0.341176] acpi PNP0C02:03: Skipped [io  0x0022-0x003f]
[    0.341176] acpi PNP0C02:03: Skipped [io  0x0063]
[    0.341176] acpi PNP0C02:03: Skipped [io  0x0065]
[    0.341176] acpi PNP0C02:03: Skipped [io  0x0067-0x006f]
[    0.341176] acpi PNP0C02:03: Skipped [io  0x0072-0x007f]
[    0.341176] acpi PNP0C02:03: Skipped [io  0x0080]
[    0.341176] acpi PNP0C02:03: Skipped [io  0x0084-0x0086]
[    0.341176] acpi PNP0C02:03: Skipped [io  0x0088]
[    0.341176] acpi PNP0C02:03: Skipped [io  0x008c-0x008e]
[    0.341176] acpi PNP0C02:03: Skipped [io  0x0090-0x009f]
[    0.341176] acpi PNP0C02:03: Skipped [io  0x00a2-0x00bf]
[    0.341176] acpi PNP0C02:03: Skipped [io  0x00b1]
[    0.341176] acpi PNP0C02:03: Skipped [io  0x00e0-0x00ef]
[    0.341176] acpi PNP0C02:03: Reserved [io  0x04d0-0x04d1]
[    0.341176] acpi PNP0C02:03: Reserved [io  0x040b]
[    0.341176] acpi PNP0C02:03: Reserved [io  0x04d6]
[    0.341176] acpi PNP0C02:03: Reserved [io  0x0c00-0x0c01]
[    0.341176] acpi PNP0C02:03: Reserved [io  0x0c14]
[    0.341176] acpi PNP0C02:03: Reserved [io  0x0c50-0x0c51]
[    0.341176] acpi PNP0C02:03: Reserved [io  0x0c52]
[    0.341176] acpi PNP0C02:03: Reserved [io  0x0c6c]
[    0.341176] acpi PNP0C02:03: Reserved [io  0x0c6f]
[    0.341176] acpi PNP0C02:03: Reserved [io  0x0cd8-0x0cdf]
[    0.341176] acpi PNP0C02:03: Reserved [io  0x0800-0x089f]
[    0.341176] acpi PNP0C02:03: Reserved [io  0x0b00-0x0b0f]
[    0.341176] acpi PNP0C02:03: Reserved [io  0x0b20-0x0b3f]
[    0.341176] acpi PNP0C02:03: Reserved [io  0x0900-0x090f]
[    0.341176] acpi PNP0C02:03: Reserved [io  0x0910-0x091f]
[    0.341176] acpi PNP0C02:03: Reserved [mem 0xfedc0000-0xfedc0fff]
[    0.341176] acpi PNP0C02:03: Reserved [mem 0xfee00000-0xfee00fff]
[    0.341176] acpi PNP0C02:03: Reserved [mem 0xfec10000-0xfec10fff]
[    0.341176] acpi PNP0C02:03: Reserved [mem 0xfeb00000-0xfeb00fff]
[    0.341176] acpi PNP0C02:03: Reserved [mem 0xff000000-0xffffffff]
[    0.341176] pnp: PnP ACPI init
[    0.341176] pnp: PnP ACPI: found 0 devices
[    0.346982] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.347108] NET: Registered PF_INET protocol family
[    0.347286] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    0.349478] tcp_listen_portaddr_hash hash table entries: 32768 (order: 7=
, 524288 bytes, linear)
[    0.349510] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.349572] TCP established hash table entries: 524288 (order: 10, 41943=
04 bytes, linear)
[    0.349863] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.349928] TCP: Hash tables configured (established 524288 bind 65536)
[    0.350046] MPTCP token hash table entries: 65536 (order: 9, 1572864 byt=
es, linear)
[    0.350163] UDP hash table entries: 32768 (order: 9, 2097152 bytes, line=
ar)
[    0.350266] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.350273] NET: Registered PF_XDP protocol family
[    0.350285] pci 0000:00:01.1: PCI bridge to [bus 01-6a]
[    0.350295] pci 0000:00:01.1:   bridge window [io  0xa000-0xcfff]
[    0.350306] pci 0000:00:01.1:   bridge window [mem 0xac000000-0xdc1fffff]
[    0.350319] pci 0000:00:01.1:   bridge window [mem 0xfc80000000-0xfcdfff=
ffff 64bit pref]
[    0.350359] pci 0000:00:01.2: PCI bridge to [bus 6b]
[    0.350362] pci 0000:00:01.2:   bridge window [io  0xf000-0xffff]
[    0.350367] pci 0000:00:01.2:   bridge window [mem 0xdcd00000-0xdcdfffff]
[    0.350393] pci 0000:00:02.3: PCI bridge to [bus 6c]
[    0.350396] pci 0000:00:02.3:   bridge window [io  0xe000-0xefff]
[    0.350401] pci 0000:00:02.3:   bridge window [mem 0xdcc00000-0xdccfffff]
[    0.350428] pci 0000:00:02.4: PCI bridge to [bus 6d]
[    0.350432] pci 0000:00:02.4:   bridge window [mem 0xdcb00000-0xdcbfffff]
[    0.350459] pci 0000:00:08.1: PCI bridge to [bus 6e]
[    0.350462] pci 0000:00:08.1:   bridge window [io  0xd000-0xdfff]
[    0.350468] pci 0000:00:08.1:   bridge window [mem 0xdc400000-0xdc9fffff]
[    0.350472] pci 0000:00:08.1:   bridge window [mem 0xfce0000000-0xfcefff=
ffff 64bit pref]
[    0.350478] pci 0000:00:08.2: PCI bridge to [bus 6f]
[    0.350482] pci 0000:00:08.2:   bridge window [mem 0xdca00000-0xdcafffff]
[    0.350486] pci 0000:00:08.2:   bridge window [mem 0xfcf0000000-0xfcf00f=
ffff 64bit pref]
[    0.350492] pci 0000:00:08.3: PCI bridge to [bus 70]
[    0.350500] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.350503] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.350506] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.350509] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.350512] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff windo=
w]
[    0.350516] pci_bus 0000:00: resource 9 [mem 0xf2000000-0xf6ffffff windo=
w]
[    0.350519] pci_bus 0000:00: resource 10 [mem 0xf0000000-0xf1ffffff wind=
ow]
[    0.350522] pci_bus 0000:00: resource 11 [mem 0xa0000000-0xdfffffff wind=
ow]
[    0.350525] pci_bus 0000:00: resource 12 [mem 0x1060000000-0xfcffffffff =
window]
[    0.350529] pci_bus 0000:01: resource 0 [io  0xa000-0xcfff]
[    0.350532] pci_bus 0000:01: resource 1 [mem 0xac000000-0xdc1fffff]
[    0.350535] pci_bus 0000:01: resource 2 [mem 0xfc80000000-0xfcdfffffff 6=
4bit pref]
[    0.350538] pci_bus 0000:6b: resource 0 [io  0xf000-0xffff]
[    0.350541] pci_bus 0000:6b: resource 1 [mem 0xdcd00000-0xdcdfffff]
[    0.350544] pci_bus 0000:6c: resource 0 [io  0xe000-0xefff]
[    0.350547] pci_bus 0000:6c: resource 1 [mem 0xdcc00000-0xdccfffff]
[    0.350550] pci_bus 0000:6d: resource 1 [mem 0xdcb00000-0xdcbfffff]
[    0.350553] pci_bus 0000:6e: resource 0 [io  0xd000-0xdfff]
[    0.350556] pci_bus 0000:6e: resource 1 [mem 0xdc400000-0xdc9fffff]
[    0.350559] pci_bus 0000:6e: resource 2 [mem 0xfce0000000-0xfcefffffff 6=
4bit pref]
[    0.350563] pci_bus 0000:6f: resource 1 [mem 0xdca00000-0xdcafffff]
[    0.350566] pci_bus 0000:6f: resource 2 [mem 0xfcf0000000-0xfcf00fffff 6=
4bit pref]
[    0.350756] pci 0000:6e:00.1: D0 power state depends on 0000:6e:00.0
[    0.350920] PCI: CLS 64 bytes, default 64
[    0.350972] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters support=
ed
[    0.350980] Trying to unpack rootfs image as initramfs...
[    0.351038] pci 0000:00:01.0: Adding to iommu group 0
[    0.351059] pci 0000:00:01.1: Adding to iommu group 1
[    0.351074] pci 0000:00:01.2: Adding to iommu group 2
[    0.351102] pci 0000:00:02.0: Adding to iommu group 3
[    0.351117] pci 0000:00:02.3: Adding to iommu group 4
[    0.351131] pci 0000:00:02.4: Adding to iommu group 5
[    0.351149] pci 0000:00:03.0: Adding to iommu group 6
[    0.351166] pci 0000:00:04.0: Adding to iommu group 7
[    0.351203] pci 0000:00:08.0: Adding to iommu group 8
[    0.351217] pci 0000:00:08.1: Adding to iommu group 9
[    0.351231] pci 0000:00:08.2: Adding to iommu group 10
[    0.351246] pci 0000:00:08.3: Adding to iommu group 11
[    0.351268] pci 0000:00:14.0: Adding to iommu group 12
[    0.351281] pci 0000:00:14.3: Adding to iommu group 12
[    0.351332] pci 0000:00:18.0: Adding to iommu group 13
[    0.351345] pci 0000:00:18.1: Adding to iommu group 13
[    0.351358] pci 0000:00:18.2: Adding to iommu group 13
[    0.351371] pci 0000:00:18.3: Adding to iommu group 13
[    0.351384] pci 0000:00:18.4: Adding to iommu group 13
[    0.351397] pci 0000:00:18.5: Adding to iommu group 13
[    0.351409] pci 0000:00:18.6: Adding to iommu group 13
[    0.351422] pci 0000:00:18.7: Adding to iommu group 13
[    0.351441] pci 0000:01:00.0: Adding to iommu group 14
[    0.351456] pci 0000:6b:00.0: Adding to iommu group 15
[    0.351470] pci 0000:6c:00.0: Adding to iommu group 16
[    0.351483] pci 0000:6d:00.0: Adding to iommu group 17
[    0.351515] pci 0000:6e:00.0: Adding to iommu group 18
[    0.351530] pci 0000:6e:00.1: Adding to iommu group 19
[    0.351546] pci 0000:6e:00.2: Adding to iommu group 20
[    0.351560] pci 0000:6e:00.3: Adding to iommu group 21
[    0.351575] pci 0000:6e:00.4: Adding to iommu group 22
[    0.351590] pci 0000:6e:00.6: Adding to iommu group 23
[    0.351605] pci 0000:6f:00.0: Adding to iommu group 24
[    0.351621] pci 0000:6f:00.1: Adding to iommu group 25
[    0.351640] pci 0000:70:00.0: Adding to iommu group 26
[    0.353299] AMD-Vi: Extended features (0x246577efa2254afa, 0x0): PPR NX =
GT [5] IA GA PC GA_vAPIC
[    0.353310] AMD-Vi: Interrupt remapping enabled
[    0.353463] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.353467] software IO TLB: mapped [mem 0x0000000075942000-0x0000000079=
942000] (64MB)
[    0.353503] LVT offset 0 assigned for vector 0x400
[    0.359429] perf: AMD IBS detected (0x00000bff)
[    0.363421] amd_uncore: 4 amd_df counters detected
[    0.363433] amd_uncore: 6 amd_l3 counters detected
[    0.363440] amd_uncore: 4 amd_umc_0 counters detected
[    0.363447] amd_uncore: 4 amd_umc_1 counters detected
[    0.364012] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/b=
ank).
[    0.365007] Initialise system trusted keyrings
[    0.365017] Key type blacklist registered
[    0.365046] workingset: timestamp_bits=3D36 (anon: 31) max_order=3D24 bu=
cket_order=3D0 (anon: 0)
[    0.365163] fuse: init (API version 7.45)
[    0.365261] integrity: Platform Keyring initialized
[    0.365266] integrity: Machine keyring initialized
[    0.365282] Key type asymmetric registered
[    0.365284] Asymmetric key parser 'x509' registered
[    0.365526] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 245)
[    0.365566] io scheduler mq-deadline registered
[    0.383415] ledtrig-cpu: registered to indicate activity on CPUs
[    0.383626] pcieport 0000:00:01.1: PME: Signaling with IRQ 32
[    0.383858] pcieport 0000:00:01.2: PME: Signaling with IRQ 33
[    0.384049] pcieport 0000:00:02.3: PME: Signaling with IRQ 34
[    0.384203] pcieport 0000:00:02.4: PME: Signaling with IRQ 35
[    0.384338] pcieport 0000:00:08.1: PME: Signaling with IRQ 36
[    0.384514] pcieport 0000:00:08.2: PME: Signaling with IRQ 37
[    0.384662] pcieport 0000:00:08.3: PME: Signaling with IRQ 38
[    0.384807] Monitor-Mwait will be used to enter C-1 state
[    0.388363] Estimated ratio of average max frequency by base frequency (=
times 1024): 1143
[    0.388659] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.395964] Freeing initrd memory: 16124K
[    0.406170] tpm_crb_acpi MSFT0101:00: Disabling hwrng
[    0.408310] i8042: PNP: No PS/2 controller found.
[    0.408387] mousedev: PS/2 mouse device common for all mice
[    0.408462] rtc_cmos PNP0B00:00: RTC can wake from S4
[    0.408745] rtc_cmos PNP0B00:00: registered as rtc0
[    0.408782] rtc_cmos PNP0B00:00: setting system clock to 2026-10-02T18:5=
4:48 UTC (1790967288)
[    0.408810] rtc_cmos PNP0B00:00: alarms up to one month, y3k, 114 bytes =
nvram
[    0.409839] efifb: probing for efifb
[    0.409848] efifb: framebuffer at 0xfce0000000, using 9000k, total 9000k
[    0.409852] efifb: mode is 1920x1200x32, linelength=3D7680, pages=3D1
[    0.409855] efifb: scrolling: redraw
[    0.409857] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.410753] Console: switching to colour frame buffer device 240x75
[    0.411714] fb0: EFI VGA frame buffer device
[    0.411902] NET: Registered PF_INET6 protocol family
[    0.412277] Segment Routing with IPv6
[    0.412298] RPL Segment Routing with IPv6
[    0.412311] In-situ OAM (IOAM) with IPv6
[    0.412331] mip6: Mobile IPv6
[    0.412338] NET: Registered PF_PACKET protocol family
[    0.412401] mpls_gso: MPLS GSO support
[    0.414322] x86/amd: Previous system reset reason [0x00200800]: ACPI pow=
er state transition occurred
[    0.414349] AGESA: AGESA!V9 ComboAm5PI 1.3.0.1a
[    0.414368] microcode: Current revision: 0x0a70520a
[    0.415098] resctrl: L3 allocation detected
[    0.415115] resctrl: MB allocation detected
[    0.415123] resctrl: SMBA allocation detected
[    0.415131] resctrl: L3 monitoring detected
[    0.415182] IPI shorthand broadcast: enabled
[    0.417806] sched_clock: Marking stable (414568425, 519430)->(420853379,=
 -5765524)
[    0.418128] registered taskstats version 1
[    0.418476] Loading compiled-in X.509 certificates
[    0.442273] Loaded X.509 cert 'Build time autogenerated kernel key: 1170=
895c18d3af9c0ff166efad54609e07de4c80'
[    0.444479] Demotion targets for Node 0: null
[    0.444542] Key type .fscrypt registered
[    0.444562] Key type fscrypt-provisioning registered
[    0.454651] Key type encrypted registered
[    0.454678] AppArmor: AppArmor sha256 policy hashing enabled
[    0.454691] ima: Allocated hash algorithm: sha256
[    0.496080] ima: No architecture policies found
[    0.496143] evm: Initialising EVM extended attributes:
[    0.496167] evm: security.selinux
[    0.496173] evm: security.SMACK64 (disabled)
[    0.496181] evm: security.SMACK64EXEC (disabled)
[    0.496188] evm: security.SMACK64TRANSMUTE (disabled)
[    0.496196] evm: security.SMACK64MMAP (disabled)
[    0.496203] evm: security.apparmor
[    0.496212] evm: security.ima
[    0.496217] evm: security.capability
[    0.496224] evm: HMAC attrs: 0x1
[    0.496405] integrity: Loading X.509 certificate: UEFI:db
[    0.496473] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.496501] integrity: Loading X.509 certificate: UEFI:db
[    0.496523] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.498399] RAS: Correctable Errors collector initialized.
[    0.498932] clk: Disabling unused clocks
[    0.498951] PM: genpd: Disabling unused power domains
[    0.500166] Freeing unused decrypted memory: 2028K
[    0.500631] Freeing unused kernel image (initmem) memory: 4648K
[    0.500672] Write protecting the kernel read-only data: 34816k
[    0.501108] Freeing unused kernel image (text/rodata gap) memory: 1256K
[    0.501261] Freeing unused kernel image (rodata/data gap) memory: 624K
[    0.534308] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.534509] Run /init as init process
[    0.534680]   with arguments:
[    0.534681]     /init
[    0.534682]   with environment:
[    0.534683]     HOME=3D/
[    0.534684]     TERM=3Dlinux
[    0.754247] Key type psk registered
[    0.766841] ACPI: bus type USB registered
[    0.767124] usbcore: registered new interface driver usbfs
[    0.767359] usbcore: registered new interface driver hub
[    0.767614] usbcore: registered new device driver usb
[    0.772876] nvme nvme0: pci function 0000:01:00.0
[    0.779807] nvme nvme0: D3 entry latency set to 10 seconds
[    0.781029] nvme nvme0: passthrough uses implicit buffer lengths
[    0.783461] nvme nvme0: 16/0/0 default/read/poll queues
[    0.786429]  nvme0n1: p1 p2 p3
[    0.789801] xhci_hcd 0000:6e:00.3: xHCI Host Controller
[    0.790002] xhci_hcd 0000:6e:00.3: new USB bus registered, assigned bus =
number 1
[    0.790550] xhci_hcd 0000:6e:00.3: hcc params 0x0128ffc5 hci version 0x1=
20 quirks 0x0000000200000010
[    0.791047] xhci_hcd 0000:6e:00.3: xHCI Host Controller
[    0.791226] xhci_hcd 0000:6e:00.3: new USB bus registered, assigned bus =
number 2
[    0.791409] xhci_hcd 0000:6e:00.3: Host supports USB 3.1 Enhanced SuperS=
peed
[    0.791649] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 7.02
[    0.792042] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.792382] usb usb1: Product: xHCI Host Controller
[    0.792608] usb usb1: Manufacturer: Linux 7.2.8+deb14-amd64 xhci-hcd
[    0.792826] usb usb1: SerialNumber: 0000:6e:00.3
[    0.793165] hub 1-0:1.0: USB hub found
[    0.793357] hub 1-0:1.0: 2 ports detected
[    0.794315] usb usb2: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    0.794504] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 7.02
[    0.794773] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.795097] usb usb2: Product: xHCI Host Controller
[    0.795303] usb usb2: Manufacturer: Linux 7.2.8+deb14-amd64 xhci-hcd
[    0.795516] usb usb2: SerialNumber: 0000:6e:00.3
[    0.795836] hub 2-0:1.0: USB hub found
[    0.796037] hub 2-0:1.0: 2 ports detected
[    0.796867] xhci_hcd 0000:6e:00.4: xHCI Host Controller
[    0.797079] xhci_hcd 0000:6e:00.4: new USB bus registered, assigned bus =
number 3
[    0.797665] xhci_hcd 0000:6e:00.4: USB0 root hub has no ports
[    0.797901] xhci_hcd 0000:6e:00.4: hcc params 0x0110ffc5 hci version 0x1=
20 quirks 0x0000000200000010
[    0.798253] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 7.02
[    0.798605] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.798908] usb usb3: Product: xHCI Host Controller
[    0.799203] usb usb3: Manufacturer: Linux 7.2.8+deb14-amd64 xhci-hcd
[    0.799486] usb usb3: SerialNumber: 0000:6e:00.4
[    0.799830] hub 3-0:1.0: USB hub found
[    0.800137] hub 3-0:1.0: 1 port detected
[    0.821080] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. =
Duplicate IMA measurements will not be recorded in the IMA log.
[    0.821329] device-mapper: uevent: version 1.0.3
[    0.821614] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised:=
 dm-devel@lists.linux.dev
[    1.042310] usb 1-2: new high-speed USB device number 2 using xhci_hcd
[    1.048127] usb 3-1: new high-speed USB device number 2 using xhci_hcd
[    1.182497] usb 1-2: New USB device found, idVendor=3D0bda, idProduct=3D=
5411, bcdDevice=3D 1.01
[    1.186093] usb 3-1: New USB device found, idVendor=3D05e3, idProduct=3D=
0610, bcdDevice=3D60.60
[    1.192458] usb 1-2: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    1.192458] usb 3-1: New USB device strings: Mfr=3D0, Product=3D1, Seria=
lNumber=3D0
[    1.192464] usb 1-2: Product: USB2.1 Hub
[    1.192466] usb 3-1: Product: USB2.0 Hub
[    1.192468] usb 1-2: Manufacturer: Generic
[    1.240627] hub 1-2:1.0: USB hub found
[    1.241453] hub 1-2:1.0: 5 ports detected
[    1.248830] hub 3-1:1.0: USB hub found
[    1.249464] hub 3-1:1.0: 4 ports detected
[    1.304096] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
[    1.307029] usb: port power management may be unreliable
[    1.320356] usb 2-2: New USB device found, idVendor=3D0bda, idProduct=3D=
0411, bcdDevice=3D 1.01
[    1.324830] usb 2-2: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    1.324834] usb 2-2: Product: USB3.2 Hub
[    1.324837] usb 2-2: Manufacturer: Generic
[    1.352635] hub 2-2:1.0: USB hub found
[    1.353531] hub 2-2:1.0: 4 ports detected
[    1.377249] tsc: Refined TSC clocksource calibration: 4200.044 MHz
[    1.377265] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x3c8=
a8b61bab, max_idle_ns: 440795342869 ns
[    1.377375] clocksource: Switched to clocksource tsc
[    1.604975] usb 3-1.1: new full-speed USB device number 3 using xhci_hcd
[    1.608593] usb 1-2.2: new high-speed USB device number 3 using xhci_hcd
[    1.703787] usb 1-2.2: New USB device found, idVendor=3D0424, idProduct=
=3D4206, bcdDevice=3D 6.25
[    1.715833] usb 3-1.1: New USB device found, idVendor=3D8087, idProduct=
=3D0032, bcdDevice=3D 0.00
[    1.718730] usb 1-2.2: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D0
[    1.718737] usb 1-2.2: Product: USB4206 Smart Hub
[    1.718740] usb 1-2.2: Manufacturer: Microchip
[    1.723831] usb 3-1.1: New USB device strings: Mfr=3D0, Product=3D0, Ser=
ialNumber=3D0
[    1.752979] hub 1-2.2:1.0: USB hub found
[    1.753335] hub 1-2.2:1.0: 5 ports detected
[    1.784100] usb 2-2.2: new SuperSpeed USB device number 3 using xhci_hcd
[    1.797653] usb 2-2.2: New USB device found, idVendor=3D0424, idProduct=
=3D7206, bcdDevice=3D 6.25
[    1.797839] usb 2-2.2: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D0
[    1.797843] usb 2-2.2: Product: USB7206 Smart Hub
[    1.797845] usb 2-2.2: Manufacturer: Microchip
[    1.848291] hub 2-2.2:1.0: USB hub found
[    1.848366] hub 2-2.2:1.0: 4 ports detected
[    2.132986] usb 1-2.2.1: new low-speed USB device number 4 using xhci_hcd
[    2.239208] usb 1-2.2.1: New USB device found, idVendor=3D046d, idProduc=
t=3Dc045, bcdDevice=3D27.20
[    2.254723] usb 1-2.2.1: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[    2.254731] usb 1-2.2.1: Product: USB-PS/2 Optical Mouse
[    2.254733] usb 1-2.2.1: Manufacturer: Logitech
[    2.308656] usb 2-2.2.4: new SuperSpeed USB device number 4 using xhci_h=
cd
[    2.309550] hid: raw HID events driver (C) Jiri Kosina
[    2.318791] usbcore: registered new interface driver usbhid
[    2.318795] usbhid: USB HID core driver
[    2.323686] input: Logitech USB-PS/2 Optical Mouse as /devices/pci0000:0=
0/0000:00:08.1/0000:6e:00.3/usb1/1-2/1-2.2/1-2.2.1/1-2.2.1:1.0/0003:046D:C0=
45.0001/input/input0
[    2.323806] hid-generic 0003:046D:C045.0001: input,hidraw0: USB HID v1.1=
0 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:6e:00.3-2.2.1/input0
[    2.328495] usb 2-2.2.4: New USB device found, idVendor=3D0424, idProduc=
t=3D7216, bcdDevice=3D 1.95
[    2.328764] usb 2-2.2.4: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[    2.328767] usb 2-2.2.4: Product: USB7216 Smart Hub
[    2.328768] usb 2-2.2.4: Manufacturer: Microchip
[    2.359757] hub 2-2.2.4:1.0: USB hub found
[    2.359818] hub 2-2.2.4:1.0: 3 ports detected
[    2.404993] usb 1-2.2.2: new low-speed USB device number 5 using xhci_hcd
[    2.501190] usb 1-2.2.2: New USB device found, idVendor=3D04d9, idProduc=
t=3Da02e, bcdDevice=3D 2.60
[    2.532852] usb 1-2.2.2: New USB device strings: Mfr=3D0, Product=3D2, S=
erialNumber=3D0
[    2.532861] usb 1-2.2.2: Product: USB Keyboard
[    2.631490] input: USB Keyboard as /devices/pci0000:00/0000:00:08.1/0000=
:6e:00.3/usb1/1-2/1-2.2/1-2.2.2/1-2.2.2:1.0/0003:04D9:A02E.0002/input/input1
[    2.653015] usb 2-2.2.4.2: new SuperSpeed USB device number 5 using xhci=
_hcd
[    2.669819] usb 2-2.2.4.2: New USB device found, idVendor=3D0bda, idProd=
uct=3D8153, bcdDevice=3D33.10
[    2.670547] usb 2-2.2.4.2: Int endpoint with wBytesPerInterval of 8 in c=
onfig 2 interface 0 altsetting 0 ep 0x83: setting to 16
[    2.670836] usb 2-2.2.4.2: Int endpoint with wBytesPerInterval of 8 in c=
onfig 3 interface 0 altsetting 0 ep 0x83: setting to 16
[    2.671074] usb 2-2.2.4.2: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D6
[    2.671077] usb 2-2.2.4.2: Product: USB 10/100/1000 LAN
[    2.671079] usb 2-2.2.4.2: Manufacturer: Realtek
[    2.671080] usb 2-2.2.4.2: SerialNumber: 0133000001
[    2.717191] hid-generic 0003:04D9:A02E.0002: input,hidraw1: USB HID v1.1=
0 Keyboard [USB Keyboard] on usb-0000:6e:00.3-2.2.2/input0
[    2.733561] input: USB Keyboard System Control as /devices/pci0000:00/00=
00:00:08.1/0000:6e:00.3/usb1/1-2/1-2.2/1-2.2.2/1-2.2.2:1.1/0003:04D9:A02E.0=
003/input/input2
[    2.789165] input: USB Keyboard Consumer Control as /devices/pci0000:00/=
0000:00:08.1/0000:6e:00.3/usb1/1-2/1-2.2/1-2.2.2/1-2.2.2:1.1/0003:04D9:A02E=
=2E0003/input/input3
[    2.789273] hid-generic 0003:04D9:A02E.0003: input,hidraw2: USB HID v1.1=
0 Device [USB Keyboard] on usb-0000:6e:00.3-2.2.2/input1
[    2.877035] usb 1-2.2.4: new high-speed USB device number 6 using xhci_h=
cd
[    2.968952] usb 1-2.2.4: New USB device found, idVendor=3D0424, idProduc=
t=3D4216, bcdDevice=3D 1.95
[    2.975212] usb 1-2.2.4: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[    2.975219] usb 1-2.2.4: Product: USB4216 Smart Hub
[    2.975223] usb 1-2.2.4: Manufacturer: Microchip
[    3.033209] hub 1-2.2.4:1.0: USB hub found
[    3.033580] hub 1-2.2.4:1.0: 4 ports detected
[    3.184984] usb 1-2.2.5: new high-speed USB device number 7 using xhci_h=
cd
[    3.275419] usb 1-2.2.5: New USB device found, idVendor=3D0424, idProduc=
t=3D7260, bcdDevice=3D 6.25
[    3.278486] usb 1-2.2.5: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[    3.278495] usb 1-2.2.5: Product: USB2 Controller Hub
[    3.278498] usb 1-2.2.5: Manufacturer: Microchip Tech
[    3.355504] hid-generic 0003:0424:7260.0004: hiddev0,hidraw3: USB HID v1=
=2E10 Device [Microchip Tech USB2 Controller Hub] on usb-0000:6e:00.3-2.2.5=
/input1
[    3.808974] usb 1-2.2.4.4: new high-speed USB device number 8 using xhci=
_hcd
[    3.919195] usb 1-2.2.4.4: New USB device found, idVendor=3D0424, idProd=
uct=3D7240, bcdDevice=3D 2.07
[    3.928568] usb 1-2.2.4.4: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D0
[    3.928575] usb 1-2.2.4.4: Product: USB2 Controller Hub
[    3.928577] usb 1-2.2.4.4: Manufacturer: Microchip Tech
[    9.597677] PM: Image not found (code -22)
[    9.751964] EXT4-fs (dm-2): mounted filesystem xxxxxxxx-xxxx-xxxx-xxxx-x=
xxxxxxxxxxx ro with ordered data mode. Quota mode: none.
[    9.805121] Not activating Mandatory Access Control as /sbin/tomoyo-init=
 does not exist.
[   10.224295] input: Power Button as /devices/platform/PNP0C0C:00/input/in=
put4
[   10.225935] ACPI: button: Power Button [PWRB]
[   10.225973] pstore: Using crash dump compression: deflate
[   10.226008] input: PC Speaker as /devices/platform/pcspkr/input/input5
[   10.227724] pstore: Registered efi_pstore as persistent store backend
[   10.227950] input: Power Button as /devices/platform/LNXPWRBN:00/input/i=
nput6
[   10.228388] ACPI: button: Power Button [PWRF]
[   10.232021] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, re=
vision 0
[   10.232339] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port=
 selection
[   10.233362] i2c i2c-2: Successfully instantiated SPD at 0x50
[   10.234745] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at=
 0xb20
[   10.237134] i2c i2c-4: Successfully instantiated SPD at 0x50
[   10.238948] i2c i2c-4: Successfully instantiated SPD at 0x51
[   10.240633] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  p=
ost: no)
[   10.241043] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 163840=
 ms ovfl timer
[   10.241395] RAPL PMU: hw unit of domain package 2^-16 Joules
[   10.241723] RAPL PMU: hw unit of domain core 2^-16 Joules
[   10.243887] input: Video Bus as /devices/pci0000:00/0000:00:08.1/acpi.vi=
deo_bus.0/input/input7
[   10.247658] ccp 0000:6e:00.2: enabling device (0000 -> 0002)
[   10.250098] ccp 0000:6e:00.2: tee enabled
[   10.252927] ccp 0000:6e:00.2: psp enabled
[   10.253731] SCSI subsystem initialized
[   10.253838] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[   10.254480] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO ad=
dress
[   10.254890] sp5100-tco sp5100-tco: initialized. heartbeat=3D60 sec (nowa=
yout=3D0)
[   10.279623] ACPI: bus type drm_connector registered
[   10.279813] r8169 0000:6c:00.0 eth0: RTL8125B, xx:xx:xx:xx:xx:xx, XID 64=
1, IRQ 65
[   10.280409] r8169 0000:6c:00.0 eth0: jumbo features [frames: 16362 bytes=
, tx checksumming: ko]
[   10.281659] usbcore: registered new device driver r8152-cfgselector
[   10.281954] libata version 3.00 loaded.
[   10.324136] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[   10.329432] Loaded X.509 cert 'benh@debian.org: 577e021cb980e0e820821ba7=
b54b4961b8b4fadf'
[   10.329993] Loaded X.509 cert 'romain.perier@gmail.com: 3abbc6ec146e09d1=
b6016ab9d6cf71dd233f0328'
[   10.330369] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   10.330744] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db1=
8c600'
[   10.333902] Bluetooth: Core ver 2.22
[   10.334268] NET: Registered PF_BLUETOOTH protocol family
[   10.334566] Bluetooth: HCI device and connection manager initialized
[   10.334907] Bluetooth: HCI socket layer initialized
[   10.335239] Bluetooth: L2CAP socket layer initialized
[   10.335557] Bluetooth: SCO socket layer initialized
[   10.359023] ahci 0000:6b:00.0: enabling device (0000 -> 0003)
[   10.359278] spd5118 2-0050: DDR5 temperature sensor: vendor 0x06:0x32 re=
vision 1.6
[   10.359792] ahci 0000:6b:00.0: SSS flag set, parallel bus scan disabled
[   10.360161] ahci 0000:6b:00.0: AHCI vers 0001.0200, 32 command slots, 6 =
Gbps, SATA mode
[   10.360498] ahci 0000:6b:00.0: 2/2 ports implemented (port mask 0x3)
[   10.360842] ahci 0000:6b:00.0: flags: 64bit ncq sntf stag led clo pmp pi=
o slum part ccc=20
[   10.361531] scsi host0: ahci
[   10.362025] scsi host1: ahci
[   10.362434] ata1: SATA max UDMA/133 abar m512@0xdcd00000 port 0xdcd00100=
 irq 66 lpm-pol 3
[   10.362749] ata2: SATA max UDMA/133 abar m512@0xdcd00000 port 0xdcd00180=
 irq 66 lpm-pol 3
[   10.366374] kvm_amd: TSC scaling supported
[   10.366702] kvm_amd: Nested Virtualization enabled
[   10.367005] kvm_amd: Nested Paging enabled
[   10.367302] kvm_amd: LBR virtualization supported
[   10.367594] kvm_amd: AVIC enabled
[   10.367869] kvm_amd: x2AVIC enabled (max 512 vCPUs)
[   10.368146] kvm_amd: Virtual GIF supported
[   10.368422] kvm_amd: Virtual NMI enabled
[   10.374403] iwlwifi 0000:6d:00.0: enabling device (0000 -> 0002)
[   10.377161] ACPI: \: failed to evaluate _DSM 2c176672-0b22-294b-814f-75e=
4dd26b5fd rev:0 func:0 (0x1001)
[   10.377537] ACPI: \: failed to evaluate _DSM 2c176672-0b22-294b-814f-75e=
4dd26b5fd rev:0 func:0 (0x1001)
[   10.378093] iwlwifi 0000:6d:00.0: Detected crf-id 0x400410, cnv-id 0x400=
410 wfpm id 0x80000000
[   10.378417] iwlwifi 0000:6d:00.0: PCI dev 2725/0024, rev=3D0x420, rfid=
=3D0x10d000
[   10.378698] iwlwifi 0000:6d:00.0: Detected Intel(R) Wi-Fi 6E AX210 160MHz
[   10.383000] iwlwifi 0000:6d:00.0: firmware: failed to load iwl-debug-yoy=
o.bin (-2)
[   10.383318] iwlwifi 0000:6d:00.0: firmware: failed to load iwl-debug-yoy=
o.bin (-2)
[   10.383608] iwlwifi 0000:6d:00.0: firmware: failed to load iwl-debug-yoy=
o.bin (-2)
[   10.383898] iwlwifi 0000:6d:00.0: loaded firmware version 89.d2579d43.0 =
ty-a0-gf-a0-89.ucode op_mode iwlmvm
[   10.456192] r8152-cfgselector 2-2.2.4.2: reset SuperSpeed USB device num=
ber 5 using xhci_hcd
[   10.558166] usbcore: registered new interface driver r8152
[   10.685772] ata1: SATA link down (SStatus 0 SControl 300)
[   11.001628] ata2: SATA link down (SStatus 0 SControl 300)
[   11.007008] MCE: In-kernel MCE decoding enabled.
[   11.009774] usbcore: registered new interface driver btusb
[   11.012455] Bluetooth: hci0: Firmware timestamp 2026.5 buildtype 1 build=
 82122
[   11.012842] Bluetooth: hci0: Firmware SHA1: 0x2925677d
[   11.013201] Bluetooth: hci0: No support for _PRR ACPI method
[   11.014546] usbcore: registered new interface driver cdc_ether
[   11.016607] Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.=
sfi
[   11.016927] Bluetooth: hci0: Boot Address: 0x100800
[   11.017191] Bluetooth: hci0: Firmware Version: 202-5.26
[   11.017452] Bluetooth: hci0: Firmware already loaded
[   11.018598] usbcore: registered new interface driver cdc_ncm
[   11.019758] snd_hda_intel 0000:6e:00.1: enabling device (0000 -> 0002)
[   11.020143] snd_hda_intel 0000:6e:00.1: Handle vga_switcheroo audio clie=
nt
[   11.020429] snd_hda_intel 0000:6e:00.6: enabling device (0000 -> 0002)
[   11.022377] usbcore: registered new interface driver cdc_wdm
[   11.025545] usbcore: registered new interface driver cdc_mbim
[   11.026434] Bluetooth: hci0: Fseq status: Success (0x00)
[   11.026888] Bluetooth: hci0: Fseq executed: 00.00.02.42
[   11.027279] Bluetooth: hci0: Fseq BT Top: 00.00.02.41
[   11.034669] input: HD-Audio Generic HDMI/DP,pcm=3D3 as /devices/pci0000:=
00/0000:00:08.1/0000:6e:00.1/sound/card0/input8
[   11.035059] input: HD-Audio Generic HDMI/DP,pcm=3D7 as /devices/pci0000:=
00/0000:00:08.1/0000:6e:00.1/sound/card0/input9
[   11.035417] input: HD-Audio Generic HDMI/DP,pcm=3D8 as /devices/pci0000:=
00/0000:00:08.1/0000:6e:00.1/sound/card0/input10
[   11.035721] input: HD-Audio Generic HDMI/DP,pcm=3D9 as /devices/pci0000:=
00/0000:00:08.1/0000:6e:00.1/sound/card0/input11
[   11.036343] amdxdna 0000:6f:00.1: [drm] Load firmware amdnpu/1502_00/npu=
_7.sbin
[   11.036638] amdxdna 0000:6f:00.1: enabling device (0000 -> 0002)
[   11.075258] snd_hda_codec_alc269 hdaudioC1D0: autoconfig for ALC269VC: l=
ine_outs=3D1 (0x1b/0x0/0x0/0x0/0x0) type:line
[   11.075509] snd_hda_codec_alc269 hdaudioC1D0:    speaker_outs=3D0 (0x0/0=
x0/0x0/0x0/0x0)
[   11.075730] snd_hda_codec_alc269 hdaudioC1D0:    hp_outs=3D1 (0x15/0x0/0=
x0/0x0/0x0)
[   11.075953] snd_hda_codec_alc269 hdaudioC1D0:    mono: mono_out=3D0x0
[   11.076140] snd_hda_codec_alc269 hdaudioC1D0:    inputs:
[   11.076326] snd_hda_codec_alc269 hdaudioC1D0:      Mic=3D0x18
[   11.076533] snd_hda_codec_alc269 hdaudioC1D0:      Mic=3D0x19
[   11.109278] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:08.=
1/0000:6e:00.6/sound/card1/input12
[   11.109667] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:0=
8.1/0000:6e:00.6/sound/card1/input13
[   11.110029] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:0=
8.1/0000:6e:00.6/sound/card1/input14
[   11.110286] input: HD-Audio Generic Line Out as /devices/pci0000:00/0000=
:00:08.1/0000:6e:00.6/sound/card1/input15
[   11.110610] input: HD-Audio Generic Front Headphone as /devices/pci0000:=
00/0000:00:08.1/0000:6e:00.6/sound/card1/input16
[   11.118034] intel_rapl_common: Found RAPL domain package
[   11.118314] intel_rapl_common: Found RAPL domain core
[   11.128087] amd_atl: AMD Address Translation Library initialized
[   11.188568] [drm] Initialized amdxdna_accel_driver 0.10.0 for 0000:6f:00=
=2E1 on minor 0
[   11.284586] iwlwifi 0000:6d:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
[   11.284900] iwlwifi 0000:6d:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[   11.285213] iwlwifi 0000:6d:00.0: WFPM_AUTH_KEY_0: 0x90
[   11.285498] iwlwifi 0000:6d:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[   11.285846] iwlwifi 0000:6d:00.0: Detected RF GF, rfid=3D0x10d000
[   11.371902] iwlwifi 0000:6d:00.0: base HW address: xx.xx.xx.xx.xx.xx
[   12.064667] clocksource: Watchdog remote CPU 6 read timed out
[   12.453344] amdgpu: Virtual CRAT table created for CPU
[   12.453551] amdgpu: Topology: Add CPU node
[   12.453821] amdgpu 0000:6e:00.0: enabling device (0006 -> 0007)
[   12.454025] amdgpu 0000:6e:00.0: initializing kernel modesetting (IP DIS=
COVERY 0x1002:0x15BF 0x1002:0x15BF 0x06).
[   12.454226] amdgpu 0000:6e:00.0: register mmio base: 0xDC900000
[   12.454403] amdgpu 0000:6e:00.0: register mmio size: 524288
[   12.456911] amdgpu 0000:6e:00.0: detected ip block number 0 <common_v1_0=
_0> (soc21_common)
[   12.457111] amdgpu 0000:6e:00.0: detected ip block number 1 <gmc_v11_0_0=
> (gmc_v11_0)
[   12.457291] amdgpu 0000:6e:00.0: detected ip block number 2 <ih_v6_0_0> =
(ih_v6_0)
[   12.457471] amdgpu 0000:6e:00.0: detected ip block number 3 <psp_v13_0_4=
> (psp)
[   12.457651] amdgpu 0000:6e:00.0: detected ip block number 4 <smu_v13_0_0=
> (smu)
[   12.457832] amdgpu 0000:6e:00.0: detected ip block number 5 <dce_v1_0_0>=
 (dm)
[   12.458009] amdgpu 0000:6e:00.0: detected ip block number 6 <gfx_v11_0_0=
> (gfx_v11_0)
[   12.458190] amdgpu 0000:6e:00.0: detected ip block number 7 <sdma_v6_0_0=
> (sdma_v6_0)
[   12.458364] amdgpu 0000:6e:00.0: detected ip block number 8 <vcn_v4_0_0>=
 (vcn_v4_0)
[   12.458543] amdgpu 0000:6e:00.0: detected ip block number 9 <jpeg_v4_0_0=
> (jpeg_v4_0)
[   12.458719] amdgpu 0000:6e:00.0: detected ip block number 10 <mes_v11_0_=
0> (mes_v11_0)
[   12.458901] amdgpu 0000:6e:00.0: Fetched VBIOS from VFCT
[   12.459075] amdgpu 0000:6e:00.0: [drm] ATOM BIOS: 113-PHXGENERIC-001, bu=
ild: 00132130, ver: 022.012.000.028.000001, 2024/12/10
[   12.471382] Console: switching to colour dummy device 80x25
[   12.471405] amdgpu 0000:6e:00.0: vgaarb: deactivate vga console
[   12.471410] amdgpu 0000:6e:00.0: Trusted Memory Zone (TMZ) feature enabl=
ed
[   12.471450] amdgpu 0000:6e:00.0: vm size is 262144 GB, 4 levels, block s=
ize is 9-bit, fragment size is 9-bit
[   12.471474] amdgpu 0000:6e:00.0: VRAM: 2048M 0x0000008000000000 - 0x0000=
00807FFFFFFF (2048M used)
[   12.471478] amdgpu 0000:6e:00.0: GART: 512M 0x00007FFF00000000 - 0x00007=
FFF1FFFFFFF
[   12.471493] amdgpu 0000:6e:00.0: [drm] Detected VRAM RAM=3D2048M, BAR=3D=
2048M
[   12.471496] amdgpu 0000:6e:00.0: [drm] RAM width 128bits DDR5
[   12.471650] amdgpu 0000:6e:00.0:  2048M of VRAM memory ready
[   12.471653] amdgpu 0000:6e:00.0:  30934M of GTT memory ready.
[   12.471670] amdgpu 0000:6e:00.0: [drm] GART: num cpu pages 131072, num g=
pu pages 131072
[   12.471867] amdgpu 0000:6e:00.0: [drm] PCIE GART of 512M enabled (table =
at 0x0000008000900000).
[   12.472147] amdgpu 0000:6e:00.0: [drm] Loading DMUB firmware via PSP: ve=
rsion=3D0x08006200
[   12.472340] amdgpu 0000:6e:00.0: [VCN instance 0] Found VCN firmware Ver=
sion ENC: 1.24 DEC: 9 VEP: 0 Revision: 34
[   12.472394] amdgpu 0000:6e:00.0: MES: vmid_mask_mmhub 0x0000ff00, vmid_m=
ask_gfxhub 0x0000ff00
[   12.472398] amdgpu 0000:6e:00.0: MES: gfx_hqd_mask 0x00000002, compute_h=
qd_mask 0x0000000c, sdma_hqd_mask 0x000000fc
[   12.495603] amdgpu 0000:6e:00.0: reserve 0x4a00000 from 0x8070000000 for=
 PSP TMR
[   13.140528] amdgpu 0000:6e:00.0: RAS: optional ras ta ucode is not avail=
able
[   13.148149] amdgpu 0000:6e:00.0: RAP: optional rap ta ucode is not avail=
able
[   13.148156] amdgpu 0000:6e:00.0: SECUREDISPLAY: optional securedisplay t=
a ucode is not available
[   13.148195] amdgpu 0000:6e:00.0: smu driver if version =3D 0x00000008, s=
mu fw if version =3D 0x00000008, smu fw program =3D 0, smu fw version =3D 0=
x004c6700 (76.103.0)
[   13.181573] amdgpu 0000:6e:00.0: SMU is initialized successfully!
[   13.181879] amdgpu 0000:6e:00.0: [drm] Display Core v3.2.384 initialized=
 on DCN 3.1.4
[   13.181885] amdgpu 0000:6e:00.0: [drm] DP-HDMI FRL PCON supported
[   13.184402] amdgpu 0000:6e:00.0: [drm] DMUB hardware initialized: versio=
n=3D0x08006200
[   13.186140] workqueue: name exceeds WQ_NAME_LEN. Truncating to: hdmi_frl=
_status_polling_workque
[   13.186325] snd_hda_intel 0000:6e:00.1: bound 0000:6e:00.0 (ops amdgpu_d=
m_audio_component_bind_ops [amdgpu])
[   13.214607] amdgpu 0000:6e:00.0: [drm] HDMI-A-1: PSR support 0, DC PSR v=
er -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[   13.214656] amdgpu 0000:6e:00.0: [drm] DP-1: PSR support 0, DC PSR ver -=
1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[   13.214691] amdgpu 0000:6e:00.0: [drm] DP-2: PSR support 0, DC PSR ver -=
1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[   13.214748] amdgpu 0000:6e:00.0: [drm] DP-3: PSR support 0, DC PSR ver -=
1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[   13.214795] amdgpu 0000:6e:00.0: [drm] DP-4: PSR support 0, DC PSR ver -=
1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[   13.214849] amdgpu 0000:6e:00.0: [drm] DP-5: PSR support 0, DC PSR ver -=
1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[   13.214896] amdgpu 0000:6e:00.0: [drm] DP-6: PSR support 0, DC PSR ver -=
1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[   13.423543] amdgpu 0000:6e:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] =
*ERROR* ring mes_kiq_3.1.0 test failed (-110)
[   13.423719] amdgpu 0000:6e:00.0: hw_init of IP block <gfx_v11_0> failed =
-110
[   13.423723] amdgpu 0000:6e:00.0: amdgpu_device_ip_init failed
[   13.423727] amdgpu 0000:6e:00.0: Fatal error during GPU init
[   13.423732] amdgpu 0000:6e:00.0: finishing device.
[   13.423906] [drm] pre_validate_dsc:1746 MST_DSC dsc precompute is not ne=
eded
[   13.423927] ------------[ cut here ]------------
[   13.423931] WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:670 at amdg=
pu_irq_put+0x5e/0xb0 [amdgpu], CPU#13: (udev-worker)/930
[   13.424121] Modules linked in: amdgpu(+) amd_atl intel_rapl_msr intel_ra=
pl_common iwlmvm snd_hda_codec_alc269 snd_hda_codec_realtek_lib drm_buddy a=
mdxcp snd_hda_scodec_component drm_panel_backlight_quirks mac80211 snd_hda_=
codec_generic drm_ttm_helper ttm snd_hda_codec_atihdmi amdxdna snd_hda_code=
c_hdmi drm_exec cdc_mbim drm_suballoc_helper amd_pmf cdc_wdm drm_display_he=
lper snd_hda_intel cdc_ncm amdtee amd_sfh cdc_ether snd_hda_codec cec btusb=
 usbnet tee edac_mce_amd libarc4 iwlwifi btmtk kvm_amd snd_hda_core gpu_sch=
ed rc_core btrtl drm_shmem_helper ahci drm_client_lib btbcm snd_intel_dspcf=
g btintel snd_intel_sdw_acpi drm_kms_helper spd5118 wmi_bmof libahci blueto=
oth snd_hwdep kvm r8152 cfg80211 libata snd_pcm mii drm r8169 ecdh_generic =
snd_timer sp5100_tco i2c_algo_bit scsi_mod snd irqbypass watchdog realtek c=
cp rfkill rapl soundcore video phy_package scsi_common i2c_piix4 k10temp i2=
c_smbus pcspkr efi_pstore wmi button efivarfs ext4 crc16 mbcache jbd2 crc32=
c_cryptoapi evdev hid_generic usbhid hid dm_crypt dm_mod
[   13.424199]  xhci_pci xhci_hcd nvme nvme_core usbcore aesni_intel gf128m=
ul nvme_keyring nvme_auth usb_common
[   13.424239] CPU: 13 UID: 0 PID: 930 Comm: (udev-worker) Not tainted 7.2.=
8+deb14-amd64 #1 PREEMPT(lazy)  Debian 7.2.8-1=20
[   13.424245] Hardware name: ASRock X600M-STX/X600M-STX, BIOS 4.23 05/25/2=
026
[   13.424250] RIP: 0010:amdgpu_irq_put+0x5e/0xb0 [amdgpu]
[   13.424405] Code: 85 c0 74 28 48 8b 53 10 48 83 3a 00 74 1e 89 ea 48 8d =
04 90 8b 10 85 d2 74 10 f0 ff 08 74 41 31 c0 5b 5d 41 5c e9 bd c3 3d c1 <0f=
> 0b 5b b8 ea ff ff ff 5d 41 5c e9 ad c3 3d c1 84 c0 74 ee 3b 2b
[   13.424413] RSP: 0018:ffffd39d820fb800 EFLAGS: 00010246
[   13.424417] RAX: ffff8b47d54bddc0 RBX: ffff8b4981427258 RCX: ffffd39d820=
fb830
[   13.424421] RDX: 0000000000000000 RSI: ffff8b4981427258 RDI: ffff8b49814=
00000
[   13.424424] RBP: 0000000000000000 R08: ffff8b47d5432780 R09: ffffffffc0a=
188c8
[   13.424428] R10: fffff49fc4550c80 R11: ffff8b47c0042800 R12: ffff8b49814=
00000
[   13.424432] R13: ffff8b4981400000 R14: ffff8b4981427258 R15: ffff8b49814=
00020
[   13.424435] FS:  00007fb212bc8d80(0000) GS:ffff8b56da935000(0000) knlGS:=
0000000000000000
[   13.424440] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.424443] CR2: 000055f1771f0dd8 CR3: 000000010717c000 CR4: 0000000000f=
50ef0
[   13.424447] PKRU: 55555554
[   13.424450] Call Trace:
[   13.424453]  <TASK>
[   13.424457]  amdgpu_fence_driver_hw_fini+0x104/0x160 [amdgpu]
[   13.424619]  amdgpu_device_fini_hw+0xc4/0x445 [amdgpu]
[   13.424849]  amdgpu_driver_load_kms.cold+0x22/0x44 [amdgpu]
[   13.425052]  amdgpu_pci_probe+0x20f/0x5a0 [amdgpu]
[   13.425208]  local_pci_probe+0x4a/0x90
[   13.425214]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.425219]  pci_call_probe+0x5a/0x1a0
[   13.425224]  pci_device_probe+0xdb/0x180
[   13.425228]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.425232]  really_probe+0xe9/0x3a0
[   13.425237]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.425241]  __driver_probe_device+0x90/0x190
[   13.425245]  driver_probe_device+0x1f/0x80
[   13.425249]  ? __pfx___driver_attach+0x10/0x10
[   13.425253]  __driver_attach+0xca/0x1f0
[   13.425257]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.425260]  bus_for_each_dev+0x97/0x100
[   13.425266]  bus_add_driver+0x136/0x240
[   13.425270]  ? __pfx_init_module+0x10/0x10 [amdgpu]
[   13.425415]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.425419]  driver_register+0x75/0xe0
[   13.425423]  ? amdgpu_init+0x24/0xff0 [amdgpu]
[   13.425562]  do_one_initcall+0x8e/0x3d0
[   13.425567]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.425572]  do_init_module+0x6a/0x290
[   13.425577]  init_module_from_file+0xc8/0x180
[   13.425584]  idempotent_init_module+0x23e/0x360
[   13.425590]  __x64_sys_finit_module+0x7f/0x110
[   13.425594]  do_syscall_64+0xe1/0x650
[   13.425600]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.425603]  ? vfs_read+0x34d/0x490
[   13.425610]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.425613]  ? __x64_sys_pread64+0xaa/0x100
[   13.425618]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.425621]  ? do_syscall_64+0x28c/0x650
[   13.425624]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.425628]  ? do_syscall_64+0x11e/0x650
[   13.425632]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.425635]  ? restore_fpregs_from_fpstate+0x46/0xa0
[   13.425640]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.425644]  ? switch_fpu_return+0x6b/0x110
[   13.425648]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.425651]  ? do_syscall_64+0x28c/0x650
[   13.425655]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.425658]  ? do_syscall_64+0x28c/0x650
[   13.425662]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.425665]  ? do_syscall_64+0x11e/0x650
[   13.425668]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.425672]  ? do_syscall_64+0x98/0x650
[   13.425675]  ? exc_page_fault+0x90/0x1e0
[   13.425680]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   13.425684] RIP: 0033:0x7fb21231ae49
[   13.425688] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 5f 0d 00 f7 d8 64 89 01 48
[   13.425695] RSP: 002b:00007ffd868979f8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   13.425699] RAX: ffffffffffffffda RBX: 000055f17723f790 RCX: 00007fb2123=
1ae49
[   13.425703] RDX: 0000000000000004 RSI: 00007fb212a6544d RDI: 00000000000=
0006b
[   13.425706] RBP: 0000000000000004 R08: 0000000000000000 R09: 000055f1771=
46f20
[   13.425710] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
20000
[   13.425713] R13: 00007fb212a6544d R14: 000055f17714cee0 R15: 00000000000=
00000
[   13.425719]  </TASK>
[   13.425721] ---[ end trace 0000000000000000 ]---
[   13.425731] ------------[ cut here ]------------
[   13.425734] WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:670 at amdg=
pu_irq_put+0x5e/0xb0 [amdgpu], CPU#13: (udev-worker)/930
[   13.425903] Modules linked in: amdgpu(+) amd_atl intel_rapl_msr intel_ra=
pl_common iwlmvm snd_hda_codec_alc269 snd_hda_codec_realtek_lib drm_buddy a=
mdxcp snd_hda_scodec_component drm_panel_backlight_quirks mac80211 snd_hda_=
codec_generic drm_ttm_helper ttm snd_hda_codec_atihdmi amdxdna snd_hda_code=
c_hdmi drm_exec cdc_mbim drm_suballoc_helper amd_pmf cdc_wdm drm_display_he=
lper snd_hda_intel cdc_ncm amdtee amd_sfh cdc_ether snd_hda_codec cec btusb=
 usbnet tee edac_mce_amd libarc4 iwlwifi btmtk kvm_amd snd_hda_core gpu_sch=
ed rc_core btrtl drm_shmem_helper ahci drm_client_lib btbcm snd_intel_dspcf=
g btintel snd_intel_sdw_acpi drm_kms_helper spd5118 wmi_bmof libahci blueto=
oth snd_hwdep kvm r8152 cfg80211 libata snd_pcm mii drm r8169 ecdh_generic =
snd_timer sp5100_tco i2c_algo_bit scsi_mod snd irqbypass watchdog realtek c=
cp rfkill rapl soundcore video phy_package scsi_common i2c_piix4 k10temp i2=
c_smbus pcspkr efi_pstore wmi button efivarfs ext4 crc16 mbcache jbd2 crc32=
c_cryptoapi evdev hid_generic usbhid hid dm_crypt dm_mod
[   13.425966]  xhci_pci xhci_hcd nvme nvme_core usbcore aesni_intel gf128m=
ul nvme_keyring nvme_auth usb_common
[   13.426002] CPU: 13 UID: 0 PID: 930 Comm: (udev-worker) Tainted: G      =
  W           7.2.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 7.2.8-1=20
[   13.426009] Tainted: [W]=3DWARN
[   13.426011] Hardware name: ASRock X600M-STX/X600M-STX, BIOS 4.23 05/25/2=
026
[   13.426014] RIP: 0010:amdgpu_irq_put+0x5e/0xb0 [amdgpu]
[   13.426155] Code: 85 c0 74 28 48 8b 53 10 48 83 3a 00 74 1e 89 ea 48 8d =
04 90 8b 10 85 d2 74 10 f0 ff 08 74 41 31 c0 5b 5d 41 5c e9 bd c3 3d c1 <0f=
> 0b 5b b8 ea ff ff ff 5d 41 5c e9 ad c3 3d c1 84 c0 74 ee 3b 2b
[   13.426162] RSP: 0018:ffffd39d820fb800 EFLAGS: 00010246
[   13.426166] RAX: ffff8b47d54bddc8 RBX: ffff8b4981427258 RCX: ffffd39d820=
fb830
[   13.426170] RDX: 0000000000000000 RSI: ffff8b4981427258 RDI: ffff8b49814=
00000
[   13.426173] RBP: 0000000000000002 R08: ffff8b47d5432780 R09: ffffffffc0a=
188c8
[   13.426176] R10: fffff49fc4550c80 R11: ffff8b47c0042800 R12: ffff8b49814=
00000
[   13.426180] R13: ffff8b4981400000 R14: ffff8b4981427258 R15: ffff8b49814=
00020
[   13.426185] FS:  00007fb212bc8d80(0000) GS:ffff8b56da935000(0000) knlGS:=
0000000000000000
[   13.426191] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.426194] CR2: 000055f1771f0dd8 CR3: 000000010717c000 CR4: 0000000000f=
50ef0
[   13.426198] PKRU: 55555554
[   13.426200] Call Trace:
[   13.426203]  <TASK>
[   13.426205]  amdgpu_fence_driver_hw_fini+0x104/0x160 [amdgpu]
[   13.426349]  amdgpu_device_fini_hw+0xc4/0x445 [amdgpu]
[   13.426549]  amdgpu_driver_load_kms.cold+0x22/0x44 [amdgpu]
[   13.426716]  amdgpu_pci_probe+0x20f/0x5a0 [amdgpu]
[   13.426861]  local_pci_probe+0x4a/0x90
[   13.426865]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.426869]  pci_call_probe+0x5a/0x1a0
[   13.426873]  pci_device_probe+0xdb/0x180
[   13.426877]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.426881]  really_probe+0xe9/0x3a0
[   13.426884]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.426888]  __driver_probe_device+0x90/0x190
[   13.426892]  driver_probe_device+0x1f/0x80
[   13.426895]  ? __pfx___driver_attach+0x10/0x10
[   13.426899]  __driver_attach+0xca/0x1f0
[   13.426902]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.426906]  bus_for_each_dev+0x97/0x100
[   13.426910]  bus_add_driver+0x136/0x240
[   13.426913]  ? __pfx_init_module+0x10/0x10 [amdgpu]
[   13.427059]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.427062]  driver_register+0x75/0xe0
[   13.427066]  ? amdgpu_init+0x24/0xff0 [amdgpu]
[   13.427202]  do_one_initcall+0x8e/0x3d0
[   13.427206]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.427211]  do_init_module+0x6a/0x290
[   13.427214]  init_module_from_file+0xc8/0x180
[   13.427221]  idempotent_init_module+0x23e/0x360
[   13.427226]  __x64_sys_finit_module+0x7f/0x110
[   13.427230]  do_syscall_64+0xe1/0x650
[   13.427234]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.427237]  ? vfs_read+0x34d/0x490
[   13.427242]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.427245]  ? __x64_sys_pread64+0xaa/0x100
[   13.427250]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.427253]  ? do_syscall_64+0x28c/0x650
[   13.427256]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.427259]  ? do_syscall_64+0x11e/0x650
[   13.427263]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.427266]  ? restore_fpregs_from_fpstate+0x46/0xa0
[   13.427270]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.427274]  ? switch_fpu_return+0x6b/0x110
[   13.427277]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.427281]  ? do_syscall_64+0x28c/0x650
[   13.427284]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.427287]  ? do_syscall_64+0x28c/0x650
[   13.427291]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.427294]  ? do_syscall_64+0x11e/0x650
[   13.427297]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.427300]  ? do_syscall_64+0x98/0x650
[   13.427303]  ? exc_page_fault+0x90/0x1e0
[   13.427307]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   13.427311] RIP: 0033:0x7fb21231ae49
[   13.427314] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 5f 0d 00 f7 d8 64 89 01 48
[   13.427320] RSP: 002b:00007ffd868979f8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   13.427325] RAX: ffffffffffffffda RBX: 000055f17723f790 RCX: 00007fb2123=
1ae49
[   13.427328] RDX: 0000000000000004 RSI: 00007fb212a6544d RDI: 00000000000=
0006b
[   13.427331] RBP: 0000000000000004 R08: 0000000000000000 R09: 000055f1771=
46f20
[   13.427335] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
20000
[   13.427338] R13: 00007fb212a6544d R14: 000055f17714cee0 R15: 00000000000=
00000
[   13.427343]  </TASK>
[   13.427345] ---[ end trace 0000000000000000 ]---
[   13.427354] ------------[ cut here ]------------
[   13.427356] WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:670 at amdg=
pu_irq_put+0x5e/0xb0 [amdgpu], CPU#13: (udev-worker)/930
[   13.427509] Modules linked in: amdgpu(+) amd_atl intel_rapl_msr intel_ra=
pl_common iwlmvm snd_hda_codec_alc269 snd_hda_codec_realtek_lib drm_buddy a=
mdxcp snd_hda_scodec_component drm_panel_backlight_quirks mac80211 snd_hda_=
codec_generic drm_ttm_helper ttm snd_hda_codec_atihdmi amdxdna snd_hda_code=
c_hdmi drm_exec cdc_mbim drm_suballoc_helper amd_pmf cdc_wdm drm_display_he=
lper snd_hda_intel cdc_ncm amdtee amd_sfh cdc_ether snd_hda_codec cec btusb=
 usbnet tee edac_mce_amd libarc4 iwlwifi btmtk kvm_amd snd_hda_core gpu_sch=
ed rc_core btrtl drm_shmem_helper ahci drm_client_lib btbcm snd_intel_dspcf=
g btintel snd_intel_sdw_acpi drm_kms_helper spd5118 wmi_bmof libahci blueto=
oth snd_hwdep kvm r8152 cfg80211 libata snd_pcm mii drm r8169 ecdh_generic =
snd_timer sp5100_tco i2c_algo_bit scsi_mod snd irqbypass watchdog realtek c=
cp rfkill rapl soundcore video phy_package scsi_common i2c_piix4 k10temp i2=
c_smbus pcspkr efi_pstore wmi button efivarfs ext4 crc16 mbcache jbd2 crc32=
c_cryptoapi evdev hid_generic usbhid hid dm_crypt dm_mod
[   13.427565]  xhci_pci xhci_hcd nvme nvme_core usbcore aesni_intel gf128m=
ul nvme_keyring nvme_auth usb_common
[   13.427597] CPU: 13 UID: 0 PID: 930 Comm: (udev-worker) Tainted: G      =
  W           7.2.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 7.2.8-1=20
[   13.427602] Tainted: [W]=3DWARN
[   13.427604] Hardware name: ASRock X600M-STX/X600M-STX, BIOS 4.23 05/25/2=
026
[   13.427607] RIP: 0010:amdgpu_irq_put+0x5e/0xb0 [amdgpu]
[   13.427733] Code: 85 c0 74 28 48 8b 53 10 48 83 3a 00 74 1e 89 ea 48 8d =
04 90 8b 10 85 d2 74 10 f0 ff 08 74 41 31 c0 5b 5d 41 5c e9 bd c3 3d c1 <0f=
> 0b 5b b8 ea ff ff ff 5d 41 5c e9 ad c3 3d c1 84 c0 74 ee 3b 2b
[   13.427739] RSP: 0018:ffffd39d820fb800 EFLAGS: 00010246
[   13.427742] RAX: ffff8b47d54bddcc RBX: ffff8b4981427258 RCX: ffffd39d820=
fb830
[   13.427745] RDX: 0000000000000000 RSI: ffff8b4981427258 RDI: ffff8b49814=
00000
[   13.427748] RBP: 0000000000000003 R08: ffff8b47d5432780 R09: ffffffffc0a=
188c8
[   13.427751] R10: fffff49fc4550c80 R11: ffff8b47c0042800 R12: ffff8b49814=
00000
[   13.427754] R13: ffff8b4981400000 R14: ffff8b4981427258 R15: ffff8b49814=
00020
[   13.427757] FS:  00007fb212bc8d80(0000) GS:ffff8b56da935000(0000) knlGS:=
0000000000000000
[   13.427761] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.427764] CR2: 000055f1771f0dd8 CR3: 000000010717c000 CR4: 0000000000f=
50ef0
[   13.427767] PKRU: 55555554
[   13.427769] Call Trace:
[   13.427771]  <TASK>
[   13.427774]  amdgpu_fence_driver_hw_fini+0x104/0x160 [amdgpu]
[   13.427908]  amdgpu_device_fini_hw+0xc4/0x445 [amdgpu]
[   13.428085]  amdgpu_driver_load_kms.cold+0x22/0x44 [amdgpu]
[   13.428235]  amdgpu_pci_probe+0x20f/0x5a0 [amdgpu]
[   13.428371]  local_pci_probe+0x4a/0x90
[   13.428375]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.428378]  pci_call_probe+0x5a/0x1a0
[   13.428382]  pci_device_probe+0xdb/0x180
[   13.428385]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.428389]  really_probe+0xe9/0x3a0
[   13.428392]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.428396]  __driver_probe_device+0x90/0x190
[   13.428399]  driver_probe_device+0x1f/0x80
[   13.428403]  ? __pfx___driver_attach+0x10/0x10
[   13.428406]  __driver_attach+0xca/0x1f0
[   13.428409]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.428412]  bus_for_each_dev+0x97/0x100
[   13.428416]  bus_add_driver+0x136/0x240
[   13.428420]  ? __pfx_init_module+0x10/0x10 [amdgpu]
[   13.428550]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.428554]  driver_register+0x75/0xe0
[   13.428558]  ? amdgpu_init+0x24/0xff0 [amdgpu]
[   13.428683]  do_one_initcall+0x8e/0x3d0
[   13.428686]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.428690]  do_init_module+0x6a/0x290
[   13.428694]  init_module_from_file+0xc8/0x180
[   13.428699]  idempotent_init_module+0x23e/0x360
[   13.428704]  __x64_sys_finit_module+0x7f/0x110
[   13.428708]  do_syscall_64+0xe1/0x650
[   13.428711]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.428714]  ? vfs_read+0x34d/0x490
[   13.428719]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.428722]  ? __x64_sys_pread64+0xaa/0x100
[   13.428725]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.428728]  ? do_syscall_64+0x28c/0x650
[   13.428731]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.428734]  ? do_syscall_64+0x11e/0x650
[   13.428737]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.428740]  ? restore_fpregs_from_fpstate+0x46/0xa0
[   13.428744]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.428747]  ? switch_fpu_return+0x6b/0x110
[   13.428750]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.428753]  ? do_syscall_64+0x28c/0x650
[   13.428756]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.428759]  ? do_syscall_64+0x28c/0x650
[   13.428762]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.428765]  ? do_syscall_64+0x11e/0x650
[   13.428768]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.428771]  ? do_syscall_64+0x98/0x650
[   13.428774]  ? exc_page_fault+0x90/0x1e0
[   13.428777]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   13.428780] RIP: 0033:0x7fb21231ae49
[   13.428783] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 5f 0d 00 f7 d8 64 89 01 48
[   13.428789] RSP: 002b:00007ffd868979f8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   13.428792] RAX: ffffffffffffffda RBX: 000055f17723f790 RCX: 00007fb2123=
1ae49
[   13.428795] RDX: 0000000000000004 RSI: 00007fb212a6544d RDI: 00000000000=
0006b
[   13.428798] RBP: 0000000000000004 R08: 0000000000000000 R09: 000055f1771=
46f20
[   13.428801] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
20000
[   13.428804] R13: 00007fb212a6544d R14: 000055f17714cee0 R15: 00000000000=
00000
[   13.428809]  </TASK>
[   13.428811] ---[ end trace 0000000000000000 ]---
[   13.428817] ------------[ cut here ]------------
[   13.428820] WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:670 at amdg=
pu_irq_put+0x5e/0xb0 [amdgpu], CPU#13: (udev-worker)/930
[   13.428956] Modules linked in: amdgpu(+) amd_atl intel_rapl_msr intel_ra=
pl_common iwlmvm snd_hda_codec_alc269 snd_hda_codec_realtek_lib drm_buddy a=
mdxcp snd_hda_scodec_component drm_panel_backlight_quirks mac80211 snd_hda_=
codec_generic drm_ttm_helper ttm snd_hda_codec_atihdmi amdxdna snd_hda_code=
c_hdmi drm_exec cdc_mbim drm_suballoc_helper amd_pmf cdc_wdm drm_display_he=
lper snd_hda_intel cdc_ncm amdtee amd_sfh cdc_ether snd_hda_codec cec btusb=
 usbnet tee edac_mce_amd libarc4 iwlwifi btmtk kvm_amd snd_hda_core gpu_sch=
ed rc_core btrtl drm_shmem_helper ahci drm_client_lib btbcm snd_intel_dspcf=
g btintel snd_intel_sdw_acpi drm_kms_helper spd5118 wmi_bmof libahci blueto=
oth snd_hwdep kvm r8152 cfg80211 libata snd_pcm mii drm r8169 ecdh_generic =
snd_timer sp5100_tco i2c_algo_bit scsi_mod snd irqbypass watchdog realtek c=
cp rfkill rapl soundcore video phy_package scsi_common i2c_piix4 k10temp i2=
c_smbus pcspkr efi_pstore wmi button efivarfs ext4 crc16 mbcache jbd2 crc32=
c_cryptoapi evdev hid_generic usbhid hid dm_crypt dm_mod
[   13.429009]  xhci_pci xhci_hcd nvme nvme_core usbcore aesni_intel gf128m=
ul nvme_keyring nvme_auth usb_common
[   13.429039] CPU: 13 UID: 0 PID: 930 Comm: (udev-worker) Tainted: G      =
  W           7.2.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 7.2.8-1=20
[   13.429044] Tainted: [W]=3DWARN
[   13.429046] Hardware name: ASRock X600M-STX/X600M-STX, BIOS 4.23 05/25/2=
026
[   13.429049] RIP: 0010:amdgpu_irq_put+0x5e/0xb0 [amdgpu]
[   13.429167] Code: 85 c0 74 28 48 8b 53 10 48 83 3a 00 74 1e 89 ea 48 8d =
04 90 8b 10 85 d2 74 10 f0 ff 08 74 41 31 c0 5b 5d 41 5c e9 bd c3 3d c1 <0f=
> 0b 5b b8 ea ff ff ff 5d 41 5c e9 ad c3 3d c1 84 c0 74 ee 3b 2b
[   13.429173] RSP: 0018:ffffd39d820fb800 EFLAGS: 00010246
[   13.429176] RAX: ffff8b47d54bddd0 RBX: ffff8b4981427258 RCX: ffffd39d820=
fb830
[   13.429179] RDX: 0000000000000000 RSI: ffff8b4981427258 RDI: ffff8b49814=
00000
[   13.429182] RBP: 0000000000000004 R08: ffff8b47d5432780 R09: ffffffffc0a=
188c8
[   13.429185] R10: fffff49fc4550c80 R11: ffff8b47c0042800 R12: ffff8b49814=
00000
[   13.429188] R13: ffff8b4981400000 R14: ffff8b4981427258 R15: ffff8b49814=
00020
[   13.429191] FS:  00007fb212bc8d80(0000) GS:ffff8b56da935000(0000) knlGS:=
0000000000000000
[   13.429194] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.429197] CR2: 000055f1771f0dd8 CR3: 000000010717c000 CR4: 0000000000f=
50ef0
[   13.429200] PKRU: 55555554
[   13.429202] Call Trace:
[   13.429204]  <TASK>
[   13.429206]  amdgpu_fence_driver_hw_fini+0x104/0x160 [amdgpu]
[   13.429333]  amdgpu_device_fini_hw+0xc4/0x445 [amdgpu]
[   13.429498]  amdgpu_driver_load_kms.cold+0x22/0x44 [amdgpu]
[   13.429639]  amdgpu_pci_probe+0x20f/0x5a0 [amdgpu]
[   13.429768]  local_pci_probe+0x4a/0x90
[   13.429772]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.429775]  pci_call_probe+0x5a/0x1a0
[   13.429779]  pci_device_probe+0xdb/0x180
[   13.429782]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.429786]  really_probe+0xe9/0x3a0
[   13.429789]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.429792]  __driver_probe_device+0x90/0x190
[   13.429796]  driver_probe_device+0x1f/0x80
[   13.429799]  ? __pfx___driver_attach+0x10/0x10
[   13.429802]  __driver_attach+0xca/0x1f0
[   13.429805]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.429808]  bus_for_each_dev+0x97/0x100
[   13.429812]  bus_add_driver+0x136/0x240
[   13.429815]  ? __pfx_init_module+0x10/0x10 [amdgpu]
[   13.429935]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.429939]  driver_register+0x75/0xe0
[   13.429942]  ? amdgpu_init+0x24/0xff0 [amdgpu]
[   13.430061]  do_one_initcall+0x8e/0x3d0
[   13.430064]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.430068]  do_init_module+0x6a/0x290
[   13.430072]  init_module_from_file+0xc8/0x180
[   13.430077]  idempotent_init_module+0x23e/0x360
[   13.430082]  __x64_sys_finit_module+0x7f/0x110
[   13.430086]  do_syscall_64+0xe1/0x650
[   13.430089]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.430092]  ? vfs_read+0x34d/0x490
[   13.430096]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.430099]  ? __x64_sys_pread64+0xaa/0x100
[   13.430103]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.430106]  ? do_syscall_64+0x28c/0x650
[   13.430109]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.430112]  ? do_syscall_64+0x11e/0x650
[   13.430115]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.430118]  ? restore_fpregs_from_fpstate+0x46/0xa0
[   13.430122]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.430125]  ? switch_fpu_return+0x6b/0x110
[   13.430128]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.430131]  ? do_syscall_64+0x28c/0x650
[   13.430134]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.430137]  ? do_syscall_64+0x28c/0x650
[   13.430140]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.430143]  ? do_syscall_64+0x11e/0x650
[   13.430146]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.430149]  ? do_syscall_64+0x98/0x650
[   13.430151]  ? exc_page_fault+0x90/0x1e0
[   13.430155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   13.430158] RIP: 0033:0x7fb21231ae49
[   13.430160] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 5f 0d 00 f7 d8 64 89 01 48
[   13.430166] RSP: 002b:00007ffd868979f8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   13.430170] RAX: ffffffffffffffda RBX: 000055f17723f790 RCX: 00007fb2123=
1ae49
[   13.430173] RDX: 0000000000000004 RSI: 00007fb212a6544d RDI: 00000000000=
0006b
[   13.430176] RBP: 0000000000000004 R08: 0000000000000000 R09: 000055f1771=
46f20
[   13.430179] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
20000
[   13.430182] R13: 00007fb212a6544d R14: 000055f17714cee0 R15: 00000000000=
00000
[   13.430187]  </TASK>
[   13.430188] ---[ end trace 0000000000000000 ]---
[   13.430193] ------------[ cut here ]------------
[   13.430196] WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:670 at amdg=
pu_irq_put+0x5e/0xb0 [amdgpu], CPU#13: (udev-worker)/930
[   13.430331] Modules linked in: amdgpu(+) amd_atl intel_rapl_msr intel_ra=
pl_common iwlmvm snd_hda_codec_alc269 snd_hda_codec_realtek_lib drm_buddy a=
mdxcp snd_hda_scodec_component drm_panel_backlight_quirks mac80211 snd_hda_=
codec_generic drm_ttm_helper ttm snd_hda_codec_atihdmi amdxdna snd_hda_code=
c_hdmi drm_exec cdc_mbim drm_suballoc_helper amd_pmf cdc_wdm drm_display_he=
lper snd_hda_intel cdc_ncm amdtee amd_sfh cdc_ether snd_hda_codec cec btusb=
 usbnet tee edac_mce_amd libarc4 iwlwifi btmtk kvm_amd snd_hda_core gpu_sch=
ed rc_core btrtl drm_shmem_helper ahci drm_client_lib btbcm snd_intel_dspcf=
g btintel snd_intel_sdw_acpi drm_kms_helper spd5118 wmi_bmof libahci blueto=
oth snd_hwdep kvm r8152 cfg80211 libata snd_pcm mii drm r8169 ecdh_generic =
snd_timer sp5100_tco i2c_algo_bit scsi_mod snd irqbypass watchdog realtek c=
cp rfkill rapl soundcore video phy_package scsi_common i2c_piix4 k10temp i2=
c_smbus pcspkr efi_pstore wmi button efivarfs ext4 crc16 mbcache jbd2 crc32=
c_cryptoapi evdev hid_generic usbhid hid dm_crypt dm_mod
[   13.430384]  xhci_pci xhci_hcd nvme nvme_core usbcore aesni_intel gf128m=
ul nvme_keyring nvme_auth usb_common
[   13.430414] CPU: 13 UID: 0 PID: 930 Comm: (udev-worker) Tainted: G      =
  W           7.2.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 7.2.8-1=20
[   13.430419] Tainted: [W]=3DWARN
[   13.430421] Hardware name: ASRock X600M-STX/X600M-STX, BIOS 4.23 05/25/2=
026
[   13.430424] RIP: 0010:amdgpu_irq_put+0x5e/0xb0 [amdgpu]
[   13.430541] Code: 85 c0 74 28 48 8b 53 10 48 83 3a 00 74 1e 89 ea 48 8d =
04 90 8b 10 85 d2 74 10 f0 ff 08 74 41 31 c0 5b 5d 41 5c e9 bd c3 3d c1 <0f=
> 0b 5b b8 ea ff ff ff 5d 41 5c e9 ad c3 3d c1 84 c0 74 ee 3b 2b
[   13.430547] RSP: 0018:ffffd39d820fb800 EFLAGS: 00010246
[   13.430550] RAX: ffff8b47d54bddd4 RBX: ffff8b4981427258 RCX: ffffd39d820=
fb830
[   13.430553] RDX: 0000000000000000 RSI: ffff8b4981427258 RDI: ffff8b49814=
00000
[   13.430556] RBP: 0000000000000005 R08: ffff8b47d5432780 R09: ffffffffc0a=
188c8
[   13.430559] R10: fffff49fc4550c80 R11: ffff8b47c0042800 R12: ffff8b49814=
00000
[   13.430562] R13: ffff8b4981400000 R14: ffff8b4981427258 R15: ffff8b49814=
00020
[   13.430565] FS:  00007fb212bc8d80(0000) GS:ffff8b56da935000(0000) knlGS:=
0000000000000000
[   13.430568] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.430571] CR2: 000055f1771f0dd8 CR3: 000000010717c000 CR4: 0000000000f=
50ef0
[   13.430574] PKRU: 55555554
[   13.430576] Call Trace:
[   13.430578]  <TASK>
[   13.430580]  amdgpu_fence_driver_hw_fini+0x104/0x160 [amdgpu]
[   13.430706]  amdgpu_device_fini_hw+0xc4/0x445 [amdgpu]
[   13.430870]  amdgpu_driver_load_kms.cold+0x22/0x44 [amdgpu]
[   13.431014]  amdgpu_pci_probe+0x20f/0x5a0 [amdgpu]
[   13.431144]  local_pci_probe+0x4a/0x90
[   13.431147]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.431150]  pci_call_probe+0x5a/0x1a0
[   13.431154]  pci_device_probe+0xdb/0x180
[   13.431157]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.431161]  really_probe+0xe9/0x3a0
[   13.431164]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.431167]  __driver_probe_device+0x90/0x190
[   13.431171]  driver_probe_device+0x1f/0x80
[   13.431174]  ? __pfx___driver_attach+0x10/0x10
[   13.431177]  __driver_attach+0xca/0x1f0
[   13.431180]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.431183]  bus_for_each_dev+0x97/0x100
[   13.431187]  bus_add_driver+0x136/0x240
[   13.431190]  ? __pfx_init_module+0x10/0x10 [amdgpu]
[   13.431311]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.431314]  driver_register+0x75/0xe0
[   13.431317]  ? amdgpu_init+0x24/0xff0 [amdgpu]
[   13.431435]  do_one_initcall+0x8e/0x3d0
[   13.431438]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.431443]  do_init_module+0x6a/0x290
[   13.431446]  init_module_from_file+0xc8/0x180
[   13.431452]  idempotent_init_module+0x23e/0x360
[   13.431456]  __x64_sys_finit_module+0x7f/0x110
[   13.431460]  do_syscall_64+0xe1/0x650
[   13.431463]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.431466]  ? vfs_read+0x34d/0x490
[   13.431471]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.431474]  ? __x64_sys_pread64+0xaa/0x100
[   13.431477]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.431480]  ? do_syscall_64+0x28c/0x650
[   13.431483]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.431486]  ? do_syscall_64+0x11e/0x650
[   13.431490]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.431493]  ? restore_fpregs_from_fpstate+0x46/0xa0
[   13.431496]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.431499]  ? switch_fpu_return+0x6b/0x110
[   13.431502]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.431505]  ? do_syscall_64+0x28c/0x650
[   13.431508]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.431511]  ? do_syscall_64+0x28c/0x650
[   13.431514]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.431517]  ? do_syscall_64+0x11e/0x650
[   13.431520]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.431523]  ? do_syscall_64+0x98/0x650
[   13.431526]  ? exc_page_fault+0x90/0x1e0
[   13.431529]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   13.431532] RIP: 0033:0x7fb21231ae49
[   13.431535] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 5f 0d 00 f7 d8 64 89 01 48
[   13.431541] RSP: 002b:00007ffd868979f8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   13.431545] RAX: ffffffffffffffda RBX: 000055f17723f790 RCX: 00007fb2123=
1ae49
[   13.431548] RDX: 0000000000000004 RSI: 00007fb212a6544d RDI: 00000000000=
0006b
[   13.431551] RBP: 0000000000000004 R08: 0000000000000000 R09: 000055f1771=
46f20
[   13.431553] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
20000
[   13.431556] R13: 00007fb212a6544d R14: 000055f17714cee0 R15: 00000000000=
00000
[   13.431561]  </TASK>
[   13.431563] ---[ end trace 0000000000000000 ]---
[   13.431569] ------------[ cut here ]------------
[   13.431572] WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:670 at amdg=
pu_irq_put+0x5e/0xb0 [amdgpu], CPU#13: (udev-worker)/930
[   13.431706] Modules linked in: amdgpu(+) amd_atl intel_rapl_msr intel_ra=
pl_common iwlmvm snd_hda_codec_alc269 snd_hda_codec_realtek_lib drm_buddy a=
mdxcp snd_hda_scodec_component drm_panel_backlight_quirks mac80211 snd_hda_=
codec_generic drm_ttm_helper ttm snd_hda_codec_atihdmi amdxdna snd_hda_code=
c_hdmi drm_exec cdc_mbim drm_suballoc_helper amd_pmf cdc_wdm drm_display_he=
lper snd_hda_intel cdc_ncm amdtee amd_sfh cdc_ether snd_hda_codec cec btusb=
 usbnet tee edac_mce_amd libarc4 iwlwifi btmtk kvm_amd snd_hda_core gpu_sch=
ed rc_core btrtl drm_shmem_helper ahci drm_client_lib btbcm snd_intel_dspcf=
g btintel snd_intel_sdw_acpi drm_kms_helper spd5118 wmi_bmof libahci blueto=
oth snd_hwdep kvm r8152 cfg80211 libata snd_pcm mii drm r8169 ecdh_generic =
snd_timer sp5100_tco i2c_algo_bit scsi_mod snd irqbypass watchdog realtek c=
cp rfkill rapl soundcore video phy_package scsi_common i2c_piix4 k10temp i2=
c_smbus pcspkr efi_pstore wmi button efivarfs ext4 crc16 mbcache jbd2 crc32=
c_cryptoapi evdev hid_generic usbhid hid dm_crypt dm_mod
[   13.431759]  xhci_pci xhci_hcd nvme nvme_core usbcore aesni_intel gf128m=
ul nvme_keyring nvme_auth usb_common
[   13.431790] CPU: 13 UID: 0 PID: 930 Comm: (udev-worker) Tainted: G      =
  W           7.2.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 7.2.8-1=20
[   13.431795] Tainted: [W]=3DWARN
[   13.431796] Hardware name: ASRock X600M-STX/X600M-STX, BIOS 4.23 05/25/2=
026
[   13.431799] RIP: 0010:amdgpu_irq_put+0x5e/0xb0 [amdgpu]
[   13.431918] Code: 85 c0 74 28 48 8b 53 10 48 83 3a 00 74 1e 89 ea 48 8d =
04 90 8b 10 85 d2 74 10 f0 ff 08 74 41 31 c0 5b 5d 41 5c e9 bd c3 3d c1 <0f=
> 0b 5b b8 ea ff ff ff 5d 41 5c e9 ad c3 3d c1 84 c0 74 ee 3b 2b
[   13.431924] RSP: 0018:ffffd39d820fb800 EFLAGS: 00010246
[   13.431927] RAX: ffff8b47d54bddc8 RBX: ffff8b4981427258 RCX: ffffd39d820=
fb830
[   13.431930] RDX: 0000000000000000 RSI: ffff8b4981427258 RDI: ffff8b49814=
00000
[   13.431933] RBP: 0000000000000002 R08: ffff8b47d5432780 R09: ffffffffc0a=
188c8
[   13.431936] R10: fffff49fc4550c80 R11: ffff8b47c0042800 R12: ffff8b49814=
00000
[   13.431939] R13: ffff8b4981400000 R14: ffff8b4981427258 R15: ffff8b49814=
00020
[   13.431942] FS:  00007fb212bc8d80(0000) GS:ffff8b56da935000(0000) knlGS:=
0000000000000000
[   13.431945] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.431948] CR2: 000055f1771f0dd8 CR3: 000000010717c000 CR4: 0000000000f=
50ef0
[   13.431951] PKRU: 55555554
[   13.431953] Call Trace:
[   13.431955]  <TASK>
[   13.431957]  amdgpu_fence_driver_hw_fini+0x104/0x160 [amdgpu]
[   13.432084]  amdgpu_device_fini_hw+0xc4/0x445 [amdgpu]
[   13.432247]  amdgpu_driver_load_kms.cold+0x22/0x44 [amdgpu]
[   13.432388]  amdgpu_pci_probe+0x20f/0x5a0 [amdgpu]
[   13.432518]  local_pci_probe+0x4a/0x90
[   13.432522]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.432526]  pci_call_probe+0x5a/0x1a0
[   13.432530]  pci_device_probe+0xdb/0x180
[   13.432535]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.432540]  really_probe+0xe9/0x3a0
[   13.432543]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.432546]  __driver_probe_device+0x90/0x190
[   13.432549]  driver_probe_device+0x1f/0x80
[   13.432553]  ? __pfx___driver_attach+0x10/0x10
[   13.432556]  __driver_attach+0xca/0x1f0
[   13.432559]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.432562]  bus_for_each_dev+0x97/0x100
[   13.432566]  bus_add_driver+0x136/0x240
[   13.432569]  ? __pfx_init_module+0x10/0x10 [amdgpu]
[   13.432692]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.432695]  driver_register+0x75/0xe0
[   13.432698]  ? amdgpu_init+0x24/0xff0 [amdgpu]
[   13.432818]  do_one_initcall+0x8e/0x3d0
[   13.432821]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.432825]  do_init_module+0x6a/0x290
[   13.432829]  init_module_from_file+0xc8/0x180
[   13.432834]  idempotent_init_module+0x23e/0x360
[   13.432839]  __x64_sys_finit_module+0x7f/0x110
[   13.432843]  do_syscall_64+0xe1/0x650
[   13.432846]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.432849]  ? vfs_read+0x34d/0x490
[   13.432853]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.432856]  ? __x64_sys_pread64+0xaa/0x100
[   13.432860]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.432863]  ? do_syscall_64+0x28c/0x650
[   13.432866]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.432869]  ? do_syscall_64+0x11e/0x650
[   13.432872]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.432875]  ? restore_fpregs_from_fpstate+0x46/0xa0
[   13.432879]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.432882]  ? switch_fpu_return+0x6b/0x110
[   13.432885]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.432888]  ? do_syscall_64+0x28c/0x650
[   13.432891]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.432894]  ? do_syscall_64+0x28c/0x650
[   13.432897]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.432900]  ? do_syscall_64+0x11e/0x650
[   13.432903]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.432906]  ? do_syscall_64+0x98/0x650
[   13.432909]  ? exc_page_fault+0x90/0x1e0
[   13.432912]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   13.432915] RIP: 0033:0x7fb21231ae49
[   13.432918] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 5f 0d 00 f7 d8 64 89 01 48
[   13.432924] RSP: 002b:00007ffd868979f8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   13.432927] RAX: ffffffffffffffda RBX: 000055f17723f790 RCX: 00007fb2123=
1ae49
[   13.432930] RDX: 0000000000000004 RSI: 00007fb212a6544d RDI: 00000000000=
0006b
[   13.432933] RBP: 0000000000000004 R08: 0000000000000000 R09: 000055f1771=
46f20
[   13.432936] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
20000
[   13.432939] R13: 00007fb212a6544d R14: 000055f17714cee0 R15: 00000000000=
00000
[   13.432944]  </TASK>
[   13.432946] ---[ end trace 0000000000000000 ]---
[   13.432951] ------------[ cut here ]------------
[   13.432953] WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:670 at amdg=
pu_irq_put+0x5e/0xb0 [amdgpu], CPU#13: (udev-worker)/930
[   13.433088] Modules linked in: amdgpu(+) amd_atl intel_rapl_msr intel_ra=
pl_common iwlmvm snd_hda_codec_alc269 snd_hda_codec_realtek_lib drm_buddy a=
mdxcp snd_hda_scodec_component drm_panel_backlight_quirks mac80211 snd_hda_=
codec_generic drm_ttm_helper ttm snd_hda_codec_atihdmi amdxdna snd_hda_code=
c_hdmi drm_exec cdc_mbim drm_suballoc_helper amd_pmf cdc_wdm drm_display_he=
lper snd_hda_intel cdc_ncm amdtee amd_sfh cdc_ether snd_hda_codec cec btusb=
 usbnet tee edac_mce_amd libarc4 iwlwifi btmtk kvm_amd snd_hda_core gpu_sch=
ed rc_core btrtl drm_shmem_helper ahci drm_client_lib btbcm snd_intel_dspcf=
g btintel snd_intel_sdw_acpi drm_kms_helper spd5118 wmi_bmof libahci blueto=
oth snd_hwdep kvm r8152 cfg80211 libata snd_pcm mii drm r8169 ecdh_generic =
snd_timer sp5100_tco i2c_algo_bit scsi_mod snd irqbypass watchdog realtek c=
cp rfkill rapl soundcore video phy_package scsi_common i2c_piix4 k10temp i2=
c_smbus pcspkr efi_pstore wmi button efivarfs ext4 crc16 mbcache jbd2 crc32=
c_cryptoapi evdev hid_generic usbhid hid dm_crypt dm_mod
[   13.433141]  xhci_pci xhci_hcd nvme nvme_core usbcore aesni_intel gf128m=
ul nvme_keyring nvme_auth usb_common
[   13.433171] CPU: 13 UID: 0 PID: 930 Comm: (udev-worker) Tainted: G      =
  W           7.2.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 7.2.8-1=20
[   13.433176] Tainted: [W]=3DWARN
[   13.433178] Hardware name: ASRock X600M-STX/X600M-STX, BIOS 4.23 05/25/2=
026
[   13.433181] RIP: 0010:amdgpu_irq_put+0x5e/0xb0 [amdgpu]
[   13.433298] Code: 85 c0 74 28 48 8b 53 10 48 83 3a 00 74 1e 89 ea 48 8d =
04 90 8b 10 85 d2 74 10 f0 ff 08 74 41 31 c0 5b 5d 41 5c e9 bd c3 3d c1 <0f=
> 0b 5b b8 ea ff ff ff 5d 41 5c e9 ad c3 3d c1 84 c0 74 ee 3b 2b
[   13.433304] RSP: 0018:ffffd39d820fb800 EFLAGS: 00010246
[   13.433307] RAX: ffff8b47d54bddcc RBX: ffff8b4981427258 RCX: ffffd39d820=
fb830
[   13.433310] RDX: 0000000000000000 RSI: ffff8b4981427258 RDI: ffff8b49814=
00000
[   13.433313] RBP: 0000000000000003 R08: ffff8b47d5432780 R09: ffffffffc0a=
188c8
[   13.433316] R10: fffff49fc4550c80 R11: ffff8b47c0042800 R12: ffff8b49814=
00000
[   13.433319] R13: ffff8b4981400000 R14: ffff8b4981427258 R15: ffff8b49814=
00020
[   13.433322] FS:  00007fb212bc8d80(0000) GS:ffff8b56da935000(0000) knlGS:=
0000000000000000
[   13.433325] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.433328] CR2: 000055f1771f0dd8 CR3: 000000010717c000 CR4: 0000000000f=
50ef0
[   13.433331] PKRU: 55555554
[   13.433333] Call Trace:
[   13.433335]  <TASK>
[   13.433337]  amdgpu_fence_driver_hw_fini+0x104/0x160 [amdgpu]
[   13.433464]  amdgpu_device_fini_hw+0xc4/0x445 [amdgpu]
[   13.433626]  amdgpu_driver_load_kms.cold+0x22/0x44 [amdgpu]
[   13.433767]  amdgpu_pci_probe+0x20f/0x5a0 [amdgpu]
[   13.433897]  local_pci_probe+0x4a/0x90
[   13.433900]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.433904]  pci_call_probe+0x5a/0x1a0
[   13.433908]  pci_device_probe+0xdb/0x180
[   13.433911]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.433914]  really_probe+0xe9/0x3a0
[   13.433917]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.433921]  __driver_probe_device+0x90/0x190
[   13.433924]  driver_probe_device+0x1f/0x80
[   13.433927]  ? __pfx___driver_attach+0x10/0x10
[   13.433930]  __driver_attach+0xca/0x1f0
[   13.433933]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.433936]  bus_for_each_dev+0x97/0x100
[   13.433940]  bus_add_driver+0x136/0x240
[   13.433943]  ? __pfx_init_module+0x10/0x10 [amdgpu]
[   13.434064]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.434067]  driver_register+0x75/0xe0
[   13.434071]  ? amdgpu_init+0x24/0xff0 [amdgpu]
[   13.434189]  do_one_initcall+0x8e/0x3d0
[   13.434192]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.434196]  do_init_module+0x6a/0x290
[   13.434199]  init_module_from_file+0xc8/0x180
[   13.434205]  idempotent_init_module+0x23e/0x360
[   13.434210]  __x64_sys_finit_module+0x7f/0x110
[   13.434213]  do_syscall_64+0xe1/0x650
[   13.434216]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.434219]  ? vfs_read+0x34d/0x490
[   13.434224]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.434227]  ? __x64_sys_pread64+0xaa/0x100
[   13.434231]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.434234]  ? do_syscall_64+0x28c/0x650
[   13.434236]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.434239]  ? do_syscall_64+0x11e/0x650
[   13.434243]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.434246]  ? restore_fpregs_from_fpstate+0x46/0xa0
[   13.434249]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.434252]  ? switch_fpu_return+0x6b/0x110
[   13.434256]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.434259]  ? do_syscall_64+0x28c/0x650
[   13.434262]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.434265]  ? do_syscall_64+0x28c/0x650
[   13.434268]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.434271]  ? do_syscall_64+0x11e/0x650
[   13.434273]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.434276]  ? do_syscall_64+0x98/0x650
[   13.434279]  ? exc_page_fault+0x90/0x1e0
[   13.434283]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   13.434285] RIP: 0033:0x7fb21231ae49
[   13.434288] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 5f 0d 00 f7 d8 64 89 01 48
[   13.434294] RSP: 002b:00007ffd868979f8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   13.434298] RAX: ffffffffffffffda RBX: 000055f17723f790 RCX: 00007fb2123=
1ae49
[   13.434301] RDX: 0000000000000004 RSI: 00007fb212a6544d RDI: 00000000000=
0006b
[   13.434304] RBP: 0000000000000004 R08: 0000000000000000 R09: 000055f1771=
46f20
[   13.434307] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
20000
[   13.434309] R13: 00007fb212a6544d R14: 000055f17714cee0 R15: 00000000000=
00000
[   13.434314]  </TASK>
[   13.434316] ---[ end trace 0000000000000000 ]---
[   13.434322] ------------[ cut here ]------------
[   13.434325] WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:670 at amdg=
pu_irq_put+0x5e/0xb0 [amdgpu], CPU#13: (udev-worker)/930
[   13.434458] Modules linked in: amdgpu(+) amd_atl intel_rapl_msr intel_ra=
pl_common iwlmvm snd_hda_codec_alc269 snd_hda_codec_realtek_lib drm_buddy a=
mdxcp snd_hda_scodec_component drm_panel_backlight_quirks mac80211 snd_hda_=
codec_generic drm_ttm_helper ttm snd_hda_codec_atihdmi amdxdna snd_hda_code=
c_hdmi drm_exec cdc_mbim drm_suballoc_helper amd_pmf cdc_wdm drm_display_he=
lper snd_hda_intel cdc_ncm amdtee amd_sfh cdc_ether snd_hda_codec cec btusb=
 usbnet tee edac_mce_amd libarc4 iwlwifi btmtk kvm_amd snd_hda_core gpu_sch=
ed rc_core btrtl drm_shmem_helper ahci drm_client_lib btbcm snd_intel_dspcf=
g btintel snd_intel_sdw_acpi drm_kms_helper spd5118 wmi_bmof libahci blueto=
oth snd_hwdep kvm r8152 cfg80211 libata snd_pcm mii drm r8169 ecdh_generic =
snd_timer sp5100_tco i2c_algo_bit scsi_mod snd irqbypass watchdog realtek c=
cp rfkill rapl soundcore video phy_package scsi_common i2c_piix4 k10temp i2=
c_smbus pcspkr efi_pstore wmi button efivarfs ext4 crc16 mbcache jbd2 crc32=
c_cryptoapi evdev hid_generic usbhid hid dm_crypt dm_mod
[   13.434511]  xhci_pci xhci_hcd nvme nvme_core usbcore aesni_intel gf128m=
ul nvme_keyring nvme_auth usb_common
[   13.434542] CPU: 13 UID: 0 PID: 930 Comm: (udev-worker) Tainted: G      =
  W           7.2.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 7.2.8-1=20
[   13.434547] Tainted: [W]=3DWARN
[   13.434549] Hardware name: ASRock X600M-STX/X600M-STX, BIOS 4.23 05/25/2=
026
[   13.434551] RIP: 0010:amdgpu_irq_put+0x5e/0xb0 [amdgpu]
[   13.434669] Code: 85 c0 74 28 48 8b 53 10 48 83 3a 00 74 1e 89 ea 48 8d =
04 90 8b 10 85 d2 74 10 f0 ff 08 74 41 31 c0 5b 5d 41 5c e9 bd c3 3d c1 <0f=
> 0b 5b b8 ea ff ff ff 5d 41 5c e9 ad c3 3d c1 84 c0 74 ee 3b 2b
[   13.434675] RSP: 0018:ffffd39d820fb800 EFLAGS: 00010246
[   13.434678] RAX: ffff8b47d54bddd0 RBX: ffff8b4981427258 RCX: ffffd39d820=
fb830
[   13.434681] RDX: 0000000000000000 RSI: ffff8b4981427258 RDI: ffff8b49814=
00000
[   13.434683] RBP: 0000000000000004 R08: ffff8b47d5432780 R09: ffffffffc0a=
188c8
[   13.434686] R10: fffff49fc4550c80 R11: ffff8b47c0042800 R12: ffff8b49814=
00000
[   13.434689] R13: ffff8b4981400000 R14: ffff8b4981427258 R15: ffff8b49814=
00020
[   13.434692] FS:  00007fb212bc8d80(0000) GS:ffff8b56da935000(0000) knlGS:=
0000000000000000
[   13.434696] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.434698] CR2: 000055f1771f0dd8 CR3: 000000010717c000 CR4: 0000000000f=
50ef0
[   13.434701] PKRU: 55555554
[   13.434703] Call Trace:
[   13.434705]  <TASK>
[   13.434707]  amdgpu_fence_driver_hw_fini+0x104/0x160 [amdgpu]
[   13.434835]  amdgpu_device_fini_hw+0xc4/0x445 [amdgpu]
[   13.434996]  amdgpu_driver_load_kms.cold+0x22/0x44 [amdgpu]
[   13.435136]  amdgpu_pci_probe+0x20f/0x5a0 [amdgpu]
[   13.435265]  local_pci_probe+0x4a/0x90
[   13.435269]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.435272]  pci_call_probe+0x5a/0x1a0
[   13.435276]  pci_device_probe+0xdb/0x180
[   13.435279]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.435283]  really_probe+0xe9/0x3a0
[   13.435286]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.435289]  __driver_probe_device+0x90/0x190
[   13.435292]  driver_probe_device+0x1f/0x80
[   13.435295]  ? __pfx___driver_attach+0x10/0x10
[   13.435298]  __driver_attach+0xca/0x1f0
[   13.435302]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.435305]  bus_for_each_dev+0x97/0x100
[   13.435309]  bus_add_driver+0x136/0x240
[   13.435312]  ? __pfx_init_module+0x10/0x10 [amdgpu]
[   13.435432]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.435436]  driver_register+0x75/0xe0
[   13.435439]  ? amdgpu_init+0x24/0xff0 [amdgpu]
[   13.435557]  do_one_initcall+0x8e/0x3d0
[   13.435560]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.435564]  do_init_module+0x6a/0x290
[   13.435567]  init_module_from_file+0xc8/0x180
[   13.435573]  idempotent_init_module+0x23e/0x360
[   13.435578]  __x64_sys_finit_module+0x7f/0x110
[   13.435581]  do_syscall_64+0xe1/0x650
[   13.435585]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.435588]  ? vfs_read+0x34d/0x490
[   13.435592]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.435595]  ? __x64_sys_pread64+0xaa/0x100
[   13.435599]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.435602]  ? do_syscall_64+0x28c/0x650
[   13.435605]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.435608]  ? do_syscall_64+0x11e/0x650
[   13.435611]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.435614]  ? restore_fpregs_from_fpstate+0x46/0xa0
[   13.435617]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.435620]  ? switch_fpu_return+0x6b/0x110
[   13.435624]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.435627]  ? do_syscall_64+0x28c/0x650
[   13.435630]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.435633]  ? do_syscall_64+0x28c/0x650
[   13.435636]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.435639]  ? do_syscall_64+0x11e/0x650
[   13.435641]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.435644]  ? do_syscall_64+0x98/0x650
[   13.435647]  ? exc_page_fault+0x90/0x1e0
[   13.435650]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   13.435653] RIP: 0033:0x7fb21231ae49
[   13.435656] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 5f 0d 00 f7 d8 64 89 01 48
[   13.435662] RSP: 002b:00007ffd868979f8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   13.435666] RAX: ffffffffffffffda RBX: 000055f17723f790 RCX: 00007fb2123=
1ae49
[   13.435669] RDX: 0000000000000004 RSI: 00007fb212a6544d RDI: 00000000000=
0006b
[   13.435671] RBP: 0000000000000004 R08: 0000000000000000 R09: 000055f1771=
46f20
[   13.435674] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
20000
[   13.435677] R13: 00007fb212a6544d R14: 000055f17714cee0 R15: 00000000000=
00000
[   13.435682]  </TASK>
[   13.435684] ---[ end trace 0000000000000000 ]---
[   13.435689] ------------[ cut here ]------------
[   13.435691] WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:670 at amdg=
pu_irq_put+0x5e/0xb0 [amdgpu], CPU#13: (udev-worker)/930
[   13.435824] Modules linked in: amdgpu(+) amd_atl intel_rapl_msr intel_ra=
pl_common iwlmvm snd_hda_codec_alc269 snd_hda_codec_realtek_lib drm_buddy a=
mdxcp snd_hda_scodec_component drm_panel_backlight_quirks mac80211 snd_hda_=
codec_generic drm_ttm_helper ttm snd_hda_codec_atihdmi amdxdna snd_hda_code=
c_hdmi drm_exec cdc_mbim drm_suballoc_helper amd_pmf cdc_wdm drm_display_he=
lper snd_hda_intel cdc_ncm amdtee amd_sfh cdc_ether snd_hda_codec cec btusb=
 usbnet tee edac_mce_amd libarc4 iwlwifi btmtk kvm_amd snd_hda_core gpu_sch=
ed rc_core btrtl drm_shmem_helper ahci drm_client_lib btbcm snd_intel_dspcf=
g btintel snd_intel_sdw_acpi drm_kms_helper spd5118 wmi_bmof libahci blueto=
oth snd_hwdep kvm r8152 cfg80211 libata snd_pcm mii drm r8169 ecdh_generic =
snd_timer sp5100_tco i2c_algo_bit scsi_mod snd irqbypass watchdog realtek c=
cp rfkill rapl soundcore video phy_package scsi_common i2c_piix4 k10temp i2=
c_smbus pcspkr efi_pstore wmi button efivarfs ext4 crc16 mbcache jbd2 crc32=
c_cryptoapi evdev hid_generic usbhid hid dm_crypt dm_mod
[   13.435877]  xhci_pci xhci_hcd nvme nvme_core usbcore aesni_intel gf128m=
ul nvme_keyring nvme_auth usb_common
[   13.435908] CPU: 13 UID: 0 PID: 930 Comm: (udev-worker) Tainted: G      =
  W           7.2.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 7.2.8-1=20
[   13.435913] Tainted: [W]=3DWARN
[   13.435914] Hardware name: ASRock X600M-STX/X600M-STX, BIOS 4.23 05/25/2=
026
[   13.435917] RIP: 0010:amdgpu_irq_put+0x5e/0xb0 [amdgpu]
[   13.436036] Code: 85 c0 74 28 48 8b 53 10 48 83 3a 00 74 1e 89 ea 48 8d =
04 90 8b 10 85 d2 74 10 f0 ff 08 74 41 31 c0 5b 5d 41 5c e9 bd c3 3d c1 <0f=
> 0b 5b b8 ea ff ff ff 5d 41 5c e9 ad c3 3d c1 84 c0 74 ee 3b 2b
[   13.436042] RSP: 0018:ffffd39d820fb800 EFLAGS: 00010246
[   13.436045] RAX: ffff8b47d54bddd4 RBX: ffff8b4981427258 RCX: ffffd39d820=
fb830
[   13.436048] RDX: 0000000000000000 RSI: ffff8b4981427258 RDI: ffff8b49814=
00000
[   13.436051] RBP: 0000000000000005 R08: ffff8b47d5432780 R09: ffffffffc0a=
188c8
[   13.436054] R10: fffff49fc4550c80 R11: ffff8b47c0042800 R12: ffff8b49814=
00000
[   13.436057] R13: ffff8b4981400000 R14: ffff8b4981427258 R15: ffff8b49814=
00020
[   13.436060] FS:  00007fb212bc8d80(0000) GS:ffff8b56da935000(0000) knlGS:=
0000000000000000
[   13.436063] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.436066] CR2: 000055f1771f0dd8 CR3: 000000010717c000 CR4: 0000000000f=
50ef0
[   13.436069] PKRU: 55555554
[   13.436071] Call Trace:
[   13.436073]  <TASK>
[   13.436075]  amdgpu_fence_driver_hw_fini+0x104/0x160 [amdgpu]
[   13.436202]  amdgpu_device_fini_hw+0xc4/0x445 [amdgpu]
[   13.436363]  amdgpu_driver_load_kms.cold+0x22/0x44 [amdgpu]
[   13.436503]  amdgpu_pci_probe+0x20f/0x5a0 [amdgpu]
[   13.436635]  local_pci_probe+0x4a/0x90
[   13.436638]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.436642]  pci_call_probe+0x5a/0x1a0
[   13.436646]  pci_device_probe+0xdb/0x180
[   13.436649]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.436653]  really_probe+0xe9/0x3a0
[   13.436655]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.436659]  __driver_probe_device+0x90/0x190
[   13.436662]  driver_probe_device+0x1f/0x80
[   13.436665]  ? __pfx___driver_attach+0x10/0x10
[   13.436668]  __driver_attach+0xca/0x1f0
[   13.436671]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.436674]  bus_for_each_dev+0x97/0x100
[   13.436678]  bus_add_driver+0x136/0x240
[   13.436681]  ? __pfx_init_module+0x10/0x10 [amdgpu]
[   13.436801]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.436805]  driver_register+0x75/0xe0
[   13.436808]  ? amdgpu_init+0x24/0xff0 [amdgpu]
[   13.436926]  do_one_initcall+0x8e/0x3d0
[   13.436929]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.436933]  do_init_module+0x6a/0x290
[   13.436937]  init_module_from_file+0xc8/0x180
[   13.436943]  idempotent_init_module+0x23e/0x360
[   13.436947]  __x64_sys_finit_module+0x7f/0x110
[   13.436951]  do_syscall_64+0xe1/0x650
[   13.436954]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.436957]  ? vfs_read+0x34d/0x490
[   13.436962]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.436965]  ? __x64_sys_pread64+0xaa/0x100
[   13.436968]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.436971]  ? do_syscall_64+0x28c/0x650
[   13.436974]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.436977]  ? do_syscall_64+0x11e/0x650
[   13.436981]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.436984]  ? restore_fpregs_from_fpstate+0x46/0xa0
[   13.436987]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.436990]  ? switch_fpu_return+0x6b/0x110
[   13.436994]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.436996]  ? do_syscall_64+0x28c/0x650
[   13.436999]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.437002]  ? do_syscall_64+0x28c/0x650
[   13.437005]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.437008]  ? do_syscall_64+0x11e/0x650
[   13.437011]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.437014]  ? do_syscall_64+0x98/0x650
[   13.437017]  ? exc_page_fault+0x90/0x1e0
[   13.437020]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   13.437023] RIP: 0033:0x7fb21231ae49
[   13.437026] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 5f 0d 00 f7 d8 64 89 01 48
[   13.437032] RSP: 002b:00007ffd868979f8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   13.437036] RAX: ffffffffffffffda RBX: 000055f17723f790 RCX: 00007fb2123=
1ae49
[   13.437039] RDX: 0000000000000004 RSI: 00007fb212a6544d RDI: 00000000000=
0006b
[   13.437041] RBP: 0000000000000004 R08: 0000000000000000 R09: 000055f1771=
46f20
[   13.437044] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
20000
[   13.437047] R13: 00007fb212a6544d R14: 000055f17714cee0 R15: 00000000000=
00000
[   13.437052]  </TASK>
[   13.437054] ---[ end trace 0000000000000000 ]---
[   13.437060] ------------[ cut here ]------------
[   13.437062] WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:670 at amdg=
pu_irq_put+0x5e/0xb0 [amdgpu], CPU#13: (udev-worker)/930
[   13.437196] Modules linked in: amdgpu(+) amd_atl intel_rapl_msr intel_ra=
pl_common iwlmvm snd_hda_codec_alc269 snd_hda_codec_realtek_lib drm_buddy a=
mdxcp snd_hda_scodec_component drm_panel_backlight_quirks mac80211 snd_hda_=
codec_generic drm_ttm_helper ttm snd_hda_codec_atihdmi amdxdna snd_hda_code=
c_hdmi drm_exec cdc_mbim drm_suballoc_helper amd_pmf cdc_wdm drm_display_he=
lper snd_hda_intel cdc_ncm amdtee amd_sfh cdc_ether snd_hda_codec cec btusb=
 usbnet tee edac_mce_amd libarc4 iwlwifi btmtk kvm_amd snd_hda_core gpu_sch=
ed rc_core btrtl drm_shmem_helper ahci drm_client_lib btbcm snd_intel_dspcf=
g btintel snd_intel_sdw_acpi drm_kms_helper spd5118 wmi_bmof libahci blueto=
oth snd_hwdep kvm r8152 cfg80211 libata snd_pcm mii drm r8169 ecdh_generic =
snd_timer sp5100_tco i2c_algo_bit scsi_mod snd irqbypass watchdog realtek c=
cp rfkill rapl soundcore video phy_package scsi_common i2c_piix4 k10temp i2=
c_smbus pcspkr efi_pstore wmi button efivarfs ext4 crc16 mbcache jbd2 crc32=
c_cryptoapi evdev hid_generic usbhid hid dm_crypt dm_mod
[   13.437249]  xhci_pci xhci_hcd nvme nvme_core usbcore aesni_intel gf128m=
ul nvme_keyring nvme_auth usb_common
[   13.437279] CPU: 13 UID: 0 PID: 930 Comm: (udev-worker) Tainted: G      =
  W           7.2.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 7.2.8-1=20
[   13.437284] Tainted: [W]=3DWARN
[   13.437286] Hardware name: ASRock X600M-STX/X600M-STX, BIOS 4.23 05/25/2=
026
[   13.437289] RIP: 0010:amdgpu_irq_put+0x5e/0xb0 [amdgpu]
[   13.437438] Code: 85 c0 74 28 48 8b 53 10 48 83 3a 00 74 1e 89 ea 48 8d =
04 90 8b 10 85 d2 74 10 f0 ff 08 74 41 31 c0 5b 5d 41 5c e9 bd c3 3d c1 <0f=
> 0b 5b b8 ea ff ff ff 5d 41 5c e9 ad c3 3d c1 84 c0 74 ee 3b 2b
[   13.437444] RSP: 0018:ffffd39d820fb800 EFLAGS: 00010246
[   13.437447] RAX: ffff8b47c5363360 RBX: ffff8b498142ecf0 RCX: ffffd39d820=
fb830
[   13.437450] RDX: 0000000000000000 RSI: ffff8b498142ecf0 RDI: ffff8b49814=
00000
[   13.437453] RBP: 0000000000000000 R08: ffff8b47d5432780 R09: ffffffffc0a=
188c8
[   13.437456] R10: fffff49fc4550c80 R11: ffff8b47c0042800 R12: ffff8b49814=
00000
[   13.437459] R13: ffff8b4981400000 R14: ffff8b498142ecf0 R15: ffff8b49814=
00020
[   13.437462] FS:  00007fb212bc8d80(0000) GS:ffff8b56da935000(0000) knlGS:=
0000000000000000
[   13.437465] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.437468] CR2: 000055f1771f0dd8 CR3: 000000010717c000 CR4: 0000000000f=
50ef0
[   13.437471] PKRU: 55555554
[   13.437473] Call Trace:
[   13.437475]  <TASK>
[   13.437477]  amdgpu_fence_driver_hw_fini+0x104/0x160 [amdgpu]
[   13.437607]  amdgpu_device_fini_hw+0xc4/0x445 [amdgpu]
[   13.437780]  amdgpu_driver_load_kms.cold+0x22/0x44 [amdgpu]
[   13.437926]  amdgpu_pci_probe+0x20f/0x5a0 [amdgpu]
[   13.438057]  local_pci_probe+0x4a/0x90
[   13.438060]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.438063]  pci_call_probe+0x5a/0x1a0
[   13.438068]  pci_device_probe+0xdb/0x180
[   13.438071]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.438074]  really_probe+0xe9/0x3a0
[   13.438077]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.438081]  __driver_probe_device+0x90/0x190
[   13.438084]  driver_probe_device+0x1f/0x80
[   13.438087]  ? __pfx___driver_attach+0x10/0x10
[   13.438090]  __driver_attach+0xca/0x1f0
[   13.438093]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.438097]  bus_for_each_dev+0x97/0x100
[   13.438100]  bus_add_driver+0x136/0x240
[   13.438104]  ? __pfx_init_module+0x10/0x10 [amdgpu]
[   13.438224]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.438228]  driver_register+0x75/0xe0
[   13.438231]  ? amdgpu_init+0x24/0xff0 [amdgpu]
[   13.438349]  do_one_initcall+0x8e/0x3d0
[   13.438352]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.438356]  do_init_module+0x6a/0x290
[   13.438360]  init_module_from_file+0xc8/0x180
[   13.438365]  idempotent_init_module+0x23e/0x360
[   13.438370]  __x64_sys_finit_module+0x7f/0x110
[   13.438374]  do_syscall_64+0xe1/0x650
[   13.438377]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.438380]  ? vfs_read+0x34d/0x490
[   13.438385]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.438388]  ? __x64_sys_pread64+0xaa/0x100
[   13.438391]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.438394]  ? do_syscall_64+0x28c/0x650
[   13.438397]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.438400]  ? do_syscall_64+0x11e/0x650
[   13.438403]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.438406]  ? restore_fpregs_from_fpstate+0x46/0xa0
[   13.438410]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.438413]  ? switch_fpu_return+0x6b/0x110
[   13.438416]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.438419]  ? do_syscall_64+0x28c/0x650
[   13.438422]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.438425]  ? do_syscall_64+0x28c/0x650
[   13.438428]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.438431]  ? do_syscall_64+0x11e/0x650
[   13.438434]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.438437]  ? do_syscall_64+0x98/0x650
[   13.438440]  ? exc_page_fault+0x90/0x1e0
[   13.438443]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   13.438446] RIP: 0033:0x7fb21231ae49
[   13.438449] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 5f 0d 00 f7 d8 64 89 01 48
[   13.438455] RSP: 002b:00007ffd868979f8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   13.438459] RAX: ffffffffffffffda RBX: 000055f17723f790 RCX: 00007fb2123=
1ae49
[   13.438462] RDX: 0000000000000004 RSI: 00007fb212a6544d RDI: 00000000000=
0006b
[   13.438465] RBP: 0000000000000004 R08: 0000000000000000 R09: 000055f1771=
46f20
[   13.438468] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
20000
[   13.438470] R13: 00007fb212a6544d R14: 000055f17714cee0 R15: 00000000000=
00000
[   13.438475]  </TASK>
[   13.438477] ---[ end trace 0000000000000000 ]---
[   13.506019] ------------[ cut here ]------------
[   13.506024] WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:670 at amdg=
pu_irq_put+0x5e/0xb0 [amdgpu], CPU#5: (udev-worker)/930
[   13.506297] Modules linked in: amdgpu(+) amd_atl intel_rapl_msr intel_ra=
pl_common iwlmvm snd_hda_codec_alc269 snd_hda_codec_realtek_lib drm_buddy a=
mdxcp snd_hda_scodec_component drm_panel_backlight_quirks mac80211 snd_hda_=
codec_generic drm_ttm_helper ttm snd_hda_codec_atihdmi amdxdna snd_hda_code=
c_hdmi drm_exec cdc_mbim drm_suballoc_helper amd_pmf cdc_wdm drm_display_he=
lper snd_hda_intel cdc_ncm amdtee amd_sfh cdc_ether snd_hda_codec cec btusb=
 usbnet tee edac_mce_amd libarc4 iwlwifi btmtk kvm_amd snd_hda_core gpu_sch=
ed rc_core btrtl drm_shmem_helper ahci drm_client_lib btbcm snd_intel_dspcf=
g btintel snd_intel_sdw_acpi drm_kms_helper spd5118 wmi_bmof libahci blueto=
oth snd_hwdep kvm r8152 cfg80211 libata snd_pcm mii drm r8169 ecdh_generic =
snd_timer sp5100_tco i2c_algo_bit scsi_mod snd irqbypass watchdog realtek c=
cp rfkill rapl soundcore video phy_package scsi_common i2c_piix4 k10temp i2=
c_smbus pcspkr efi_pstore wmi button efivarfs ext4 crc16 mbcache jbd2 crc32=
c_cryptoapi evdev hid_generic usbhid hid dm_crypt dm_mod
[   13.506388]  xhci_pci xhci_hcd nvme nvme_core usbcore aesni_intel gf128m=
ul nvme_keyring nvme_auth usb_common
[   13.506441] CPU: 5 UID: 0 PID: 930 Comm: (udev-worker) Tainted: G       =
 W           7.2.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 7.2.8-1=20
[   13.506451] Tainted: [W]=3DWARN
[   13.506454] Hardware name: ASRock X600M-STX/X600M-STX, BIOS 4.23 05/25/2=
026
[   13.506459] RIP: 0010:amdgpu_irq_put+0x5e/0xb0 [amdgpu]
[   13.506679] Code: 85 c0 74 28 48 8b 53 10 48 83 3a 00 74 1e 89 ea 48 8d =
04 90 8b 10 85 d2 74 10 f0 ff 08 74 41 31 c0 5b 5d 41 5c e9 bd c3 3d c1 <0f=
> 0b 5b b8 ea ff ff ff 5d 41 5c e9 ad c3 3d c1 84 c0 74 ee 3b 2b
[   13.506690] RSP: 0018:ffffd39d820fb818 EFLAGS: 00010246
[   13.506696] RAX: ffff8b47c5363800 RBX: ffff8b4981400c88 RCX: 00000000000=
00005
[   13.506701] RDX: 0000000000000000 RSI: ffff8b4981400c88 RDI: ffff8b49814=
00000
[   13.506706] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
01124
[   13.506711] R10: fffff49fc5068e00 R11: ffff8b47c0042b00 R12: ffff8b49814=
00000
[   13.506716] R13: ffff8b4981400018 R14: 0000000000000001 R15: ffff8b49814=
00020
[   13.506721] FS:  00007fb212bc8d80(0000) GS:ffff8b56da735000(0000) knlGS:=
0000000000000000
[   13.506727] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.506732] CR2: 00007ffe0c01cff8 CR3: 000000010717c000 CR4: 0000000000f=
50ef0
[   13.506737] PKRU: 55555554
[   13.506740] Call Trace:
[   13.506744]  <TASK>
[   13.506748]  gmc_v11_0_hw_fini+0x28/0x90 [amdgpu]
[   13.506955]  amdgpu_ip_block_hw_fini+0x39/0x7f [amdgpu]
[   13.507294]  amdgpu_device_fini_hw+0x373/0x445 [amdgpu]
[   13.507590]  amdgpu_driver_load_kms.cold+0x22/0x44 [amdgpu]
[   13.507843]  amdgpu_pci_probe+0x20f/0x5a0 [amdgpu]
[   13.508010]  local_pci_probe+0x4a/0x90
[   13.508015]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.508019]  pci_call_probe+0x5a/0x1a0
[   13.508024]  pci_device_probe+0xdb/0x180
[   13.508028]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.508033]  really_probe+0xe9/0x3a0
[   13.508037]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.508041]  __driver_probe_device+0x90/0x190
[   13.508045]  driver_probe_device+0x1f/0x80
[   13.508049]  ? __pfx___driver_attach+0x10/0x10
[   13.508053]  __driver_attach+0xca/0x1f0
[   13.508057]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.508061]  bus_for_each_dev+0x97/0x100
[   13.508066]  bus_add_driver+0x136/0x240
[   13.508070]  ? __pfx_init_module+0x10/0x10 [amdgpu]
[   13.508229]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.508233]  driver_register+0x75/0xe0
[   13.508237]  ? amdgpu_init+0x24/0xff0 [amdgpu]
[   13.508388]  do_one_initcall+0x8e/0x3d0
[   13.508391]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.508397]  do_init_module+0x6a/0x290
[   13.508401]  init_module_from_file+0xc8/0x180
[   13.508408]  idempotent_init_module+0x23e/0x360
[   13.508414]  __x64_sys_finit_module+0x7f/0x110
[   13.508419]  do_syscall_64+0xe1/0x650
[   13.508423]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.508427]  ? vfs_read+0x34d/0x490
[   13.508433]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.508437]  ? __x64_sys_pread64+0xaa/0x100
[   13.508441]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.508445]  ? do_syscall_64+0x28c/0x650
[   13.508448]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.508452]  ? do_syscall_64+0x11e/0x650
[   13.508457]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.508460]  ? restore_fpregs_from_fpstate+0x46/0xa0
[   13.508465]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.508469]  ? switch_fpu_return+0x6b/0x110
[   13.508473]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.508477]  ? do_syscall_64+0x28c/0x650
[   13.508480]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.508484]  ? do_syscall_64+0x28c/0x650
[   13.508488]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.508492]  ? do_syscall_64+0x11e/0x650
[   13.508495]  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.508499]  ? do_syscall_64+0x98/0x650
[   13.508503]  ? exc_page_fault+0x90/0x1e0
[   13.508507]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   13.508511] RIP: 0033:0x7fb21231ae49
[   13.508514] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 5f 0d 00 f7 d8 64 89 01 48
[   13.508525] RSP: 002b:00007ffd868979f8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   13.508530] RAX: ffffffffffffffda RBX: 000055f17723f790 RCX: 00007fb2123=
1ae49
[   13.508534] RDX: 0000000000000004 RSI: 00007fb212a6544d RDI: 00000000000=
0006b
[   13.508538] RBP: 0000000000000004 R08: 0000000000000000 R09: 000055f1771=
46f20
[   13.508542] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
20000
[   13.508545] R13: 00007fb212a6544d R14: 000055f17714cee0 R15: 00000000000=
00000
[   13.508552]  </TASK>
[   13.508554] ---[ end trace 0000000000000000 ]---
[   13.711962] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   13.915323] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   14.118714] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   14.322085] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   14.525437] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   14.728856] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   14.932238] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   15.135590] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   15.338943] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   15.542266] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   15.745652] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   15.948829] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   16.152255] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   16.355447] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   16.558739] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   16.773465] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   16.991246] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   17.209162] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   17.427282] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   17.644921] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   17.862756] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   18.080584] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   18.298366] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   18.516198] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   18.734026] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   18.951816] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   19.169625] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   19.387445] amdgpu 0000:6e:00.0: Timeout waiting for VM flush ACK!
[   19.387592] amdgpu 0000:6e:00.0: probe with driver amdgpu failed with er=
ror -110
[   19.390814] amdgpu 0000:6e:00.0:  ttm finalized
[   19.490271] EXT4-fs (dm-2): re-mounted xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxx=
xxx r/w.
[   19.717003] nct6683: Found NCT6686D or compatible chip at 0x2e:0xa20
[   19.717130] nct6683 nct6683.2592: Enabling support for unknown customer =
ID 0x163c
[   19.719091] nct6683 nct6683.2592: NCT6686D EC firmware version 1.0 build=
 05/22/24
[   19.727202] EXT4-fs (nvme0n1p2): mounting ext2 file system using the ext=
4 subsystem
[   19.735687] EXT4-fs (nvme0n1p2): mounted filesystem xxxxxxxx-xxxx-xxxx-x=
xxx-xxxxxxxxxxxx r/w without journal. Quota mode: none.
[   19.809763] EXT4-fs (dm-3): mounted filesystem xxxxxxxx-xxxx-xxxx-xxxx-x=
xxxxxxxxxxx r/w with ordered data mode. Quota mode: none.

--00jXfCJbUwNZmHBk--
