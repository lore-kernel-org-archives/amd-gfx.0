Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D37C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 13:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B759211BEB7;
	Thu, 30 May 2024 13:02:24 +0000 (UTC)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8635F10E626
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 21:42:57 +0000 (UTC)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id DA06610087B46;
 Thu, 30 May 2024 05:42:49 +0800 (CST)
Received: from [192.168.1.120] (unknown [59.78.30.29])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id E0DFE37C91F;
 Thu, 30 May 2024 05:42:43 +0800 (CST)
Message-ID: <3dd9d2f2fc773609fdd82f7ad5f32ece8761cb58.camel@sjtu.edu.cn>
Subject: Re: [bug report] drm/amdgpu: amdgpu crash on playing videos, linux
 6.10-rc
From: Wang Yunchen <mac-wang@sjtu.edu.cn>
To: Alex Deucher <alexdeucher@gmail.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Xinhui.Pan@amd.com, 
 alexander.deucher@amd.com, Felix.Kuehling@amd.com, "Liu, Leo"
 <Leo.Liu@amd.com>
Date: Thu, 30 May 2024 05:42:42 +0800
In-Reply-To: <CADnq5_MT-h2AfG1VxTXAOU+FTdDYogO9xt=udYw11fuTawY3Uw@mail.gmail.com>
References: <ebb3b35e631169041e70eb0a7efd6cecef609833.camel@sjtu.edu.cn>
 <6ad1e363-5f22-46ac-b9de-9e4e87a59e9c@amd.com>
 <CADnq5_MT-h2AfG1VxTXAOU+FTdDYogO9xt=udYw11fuTawY3Uw@mail.gmail.com>
Organization: Shanghai Jiao Tong University
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 30 May 2024 13:02:22 +0000
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

Hi Cristian and Alex, two things to clarify:

First is that I didn't update Mesa for a week or so. The problem disappears=
 when I switch back to a 6.9 kernel.

Second is that sorry I couldn't bisect the troublesome commit. The problem =
takes some time to reproduce, there were
just too many of the commits, and my laptop is performance limited. Even wi=
th the help of ccache and reconfiguring a
minimal kernel I could only bisect 6 steps during the whole night.

Nevertheless I managed to get a (somewhat) more detailed crash log:

May 30 00:54:48 kernel: gmc_v11_0_process_interrupt: 968153 callbacks suppr=
essed
May 30 00:54:48 kernel: (mmhub page faults omitted)
......
May 30 00:54:48 kernel: rcu: INFO: rcu_preempt detected stalls on CPUs/task=
s:
May 30 00:54:48 kernel: rcu:       2-...0: (1 GPs behind) idle=3Dc41c/1/0x4=
000000000000002 softirq=3D14625/14626 fqs=3D3542
May 30 00:54:48 kernel: rcu:         (detected by 15, t=3D18003 jiffies, g=
=3D22213, q=3D1880 ncpus=3D16)
May 30 00:54:48 kernel: Sending NMI from CPU 15 to CPUs 2:
May 30 00:54:48 kernel: NMI backtrace for cpu 2
May 30 00:54:48 kernel: CPU: 2 PID: 0 Comm: swapper/2 Tainted: G        W  =
        6.10.0-rc1-g1613e604df0c #1
3500dba526772e025a7ded6753ccaffa9601f40c
May 30 00:54:48 kernel: Hardware name: WUJIE 14/WUJIE 14, BIOS 2.26 12/12/2=
023
May 30 00:54:48 kernel: RIP: 0010:amdgpu_device_rreg+0x99/0x100 [amdgpu]
May 30 00:54:48 kernel: Code: 18 e8 bb 56 10 d5 eb 22 4d 8b 9e 28 09 00 00 =
4c 89 f7 44 89 fe 41 ff d3 0f 1f 00 89 c5
eb 0b 49 8b 86 e8 08 00 00 42 8b 2c 38 <49> 8b 46 08 0f b7 70 3e 66 90 89 e=
8 5b 41 5e 41 5f 5d e9 2b 25 0b
May 30 00:54:48 kernel: RSP: 0018:ffffb861c02a8e48 EFLAGS: 00000046
May 30 00:54:48 kernel: RAX: ffffb861c9780000 RBX: 000000000001a70c RCX: ff=
ff9e5ac5201800
May 30 00:54:48 kernel: RDX: 0000000000000000 RSI: 000000000001a70c RDI: ff=
ff9e5adb180000
May 30 00:54:48 kernel: RBP: 0000000000000000 R08: 0000000000000012 R09: 00=
00000000000000
May 30 00:54:48 kernel: R10: 0000000000008009 R11: ffffffffc092c960 R12: 00=
00000000000280
May 30 00:54:48 kernel: R13: 0000000000000008 R14: ffff9e5adb180000 R15: 00=
00000000069c30
May 30 00:54:48 kernel: FS:  0000000000000000(0000) GS:ffff9e5dae300000(000=
0) knlGS:0000000000000000
May 30 00:54:48 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
May 30 00:54:48 kernel: CR2: 00007f0362390000 CR3: 000000010511c000 CR4: 00=
00000000f50ef0
May 30 00:54:48 kernel: PKRU: 55555554
May 30 00:54:48 kernel: Call Trace:
May 30 00:54:48 kernel:  <NMI>
May 30 00:54:48 kernel:  ? nmi_cpu_backtrace+0xd8/0x100
May 30 00:54:48 kernel:  ? nmi_cpu_backtrace_handler+0x11/0x20
May 30 00:54:48 kernel:  ? nmi_handle+0x68/0x160
May 30 00:54:48 kernel:  ? amdgpu_device_rreg+0x99/0x100 [amdgpu fc50d11d95=
4da0d1786cd1c90214e275728ba9ae]
May 30 00:54:48 kernel:  ? default_do_nmi+0x41/0x100
May 30 00:54:48 kernel:  ? exc_nmi+0x106/0x190
May 30 00:54:48 kernel:  ? end_repeat_nmi+0xf/0x53
May 30 00:54:48 kernel:  ? __pfx_gmc_v11_0_process_interrupt+0x10/0x10 [amd=
gpu
fc50d11d954da0d1786cd1c90214e275728ba9ae]
May 30 00:54:48 kernel:  ? amdgpu_device_rreg+0x99/0x100 [amdgpu fc50d11d95=
4da0d1786cd1c90214e275728ba9ae]
May 30 00:54:48 kernel:  ? amdgpu_device_rreg+0x99/0x100 [amdgpu fc50d11d95=
4da0d1786cd1c90214e275728ba9ae]
May 30 00:54:48 kernel:  ? amdgpu_device_rreg+0x99/0x100 [amdgpu fc50d11d95=
4da0d1786cd1c90214e275728ba9ae]
May 30 00:54:48 kernel:  </NMI>
May 30 00:54:48 kernel:  <IRQ>
May 30 00:54:48 kernel:  gmc_v11_0_process_interrupt+0x95/0x1d0 [amdgpu fc5=
0d11d954da0d1786cd1c90214e275728ba9ae]
May 30 00:54:48 kernel:  amdgpu_irq_dispatch+0x124/0x230 [amdgpu fc50d11d95=
4da0d1786cd1c90214e275728ba9ae]
May 30 00:54:48 kernel:  amdgpu_ih_process+0xd0/0x100 [amdgpu fc50d11d954da=
0d1786cd1c90214e275728ba9ae]
May 30 00:54:48 kernel:  amdgpu_irq_handler+0x23/0x50 [amdgpu fc50d11d954da=
0d1786cd1c90214e275728ba9ae]
May 30 00:54:48 kernel:  __handle_irq_event_percpu+0x65/0x1c0
May 30 00:54:48 kernel:  handle_irq_event+0x38/0x80
May 30 00:54:48 kernel:  handle_edge_irq+0xdf/0x230
May 30 00:54:48 kernel:  __common_interrupt+0x42/0xb0
May 30 00:54:48 kernel:  common_interrupt+0x81/0xa0
May 30 00:54:48 kernel:  </IRQ>
May 30 00:54:48 kernel:  <TASK>
May 30 00:54:48 kernel:  asm_common_interrupt+0x26/0x40
May 30 00:54:48 kernel: RIP: 0010:cpuidle_enter_state+0x127/0x230
May 30 00:54:48 kernel: Code: f1 ff ff 49 89 c4 8b 73 04 bf ff ff ff ff e8 =
60 5b cf ff 31 ff e8 29 7b 29 ff 45 84 ed
74 05 e8 bf 5b cf ff fb 0f 1f 44 00 00 <85> ed 78 58 89 e9 48 6b f1 68 49 8=
b 54 36 48 4c 2b 24 24 4c 89 63
May 30 00:54:48 kernel: RSP: 0018:ffffb861c01cfe98 EFLAGS: 00000246
May 30 00:54:48 kernel: RAX: ffff9e5dae300000 RBX: ffff9e5ac1caa000 RCX: 00=
00001b69a639e4
May 30 00:54:48 kernel: RDX: 000000000000000f RSI: 0000000000000002 RDI: 00=
00000000000000
May 30 00:54:48 kernel: RBP: 0000000000000001 R08: 0000000000000002 R09: 00=
00000000000002
May 30 00:54:48 kernel: R10: 0000000000000014 R11: ffffffff9669f910 R12: 00=
00001b69a639e4
May 30 00:54:48 kernel: R13: 0000000000000000 R14: ffffffff9794eb68 R15: 00=
00000000000001
May 30 00:54:48 kernel:  ? __pfx_acpi_idle_enter+0x10/0x10
May 30 00:54:48 kernel:  ? cpuidle_enter_state+0x117/0x230
May 30 00:54:48 kernel:  cpuidle_enter+0x2c/0x40
May 30 00:54:48 kernel:  do_idle+0x1ba/0x260
May 30 00:54:48 kernel:  cpu_startup_entry+0x2a/0x30
May 30 00:54:48 kernel:  start_secondary+0x9c/0xa0
May 30 00:54:48 kernel:  common_startup_64+0x13e/0x140
May 30 00:54:48 kernel:  </TASK>
May 30 00:54:48 kernel: INFO: NMI handler (nmi_cpu_backtrace_handler) took =
too long to run: 1.154 msecs

This time the GPU couldn't brought itself back and the system hangs complet=
ely.

Again, if you need a kdump or a process dump please contact me.

On Wed, 2024-05-29 at 09:48 -0400, Alex Deucher wrote:
> DId you also update mesa?=C2=A0 There could be a UMD change that causes t=
he
> page faults.
>=20
> Alex
>=20
> On Wed, May 29, 2024 at 3:37=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >=20
> > Hi,
> >=20
> > when the issue is easy to reproduce I suggest to bisect the changes
> > between 6.9 and 6.10-rc1.
> >=20
> > On the other hand it's not unlikely that we have a known bug in -rc1
> > which will be fixed by -rc2.
> >=20
> > Anyway added Leo to the mail thread since he is the one responsible for
> > the video decoding engines.
> >=20
> > Regards,
> > Christian.
> >=20
> > Am 29.05.24 um 06:05 schrieb Wang Yunchen:
> > > Hello,
> > >=20
> > > After upgrading to Linux 6.10-rc1 (Mesa is left untouched) I identifi=
ed a strange bug that could cause the GPU
> > > to
> > > crash and reset while playing videos online with VA-API. The screen w=
ould first start to jitter, then flicker
> > > once or
> > > twice, but the desktop session couldn't be brought back. After a rebo=
ot I find the following messages in system
> > > logs:
> > >=20
> > > 10:13:05 kernel: gmc_v11_0_process_interrupt: 52 callbacks suppressed
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103b05000 from client 18
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00103A11
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: unknown (0x1d)
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x1
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x1
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103b00000 from client 18
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103be8000 from client 18
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103be6000 from client 18
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103be6000 from client 18
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00103A11
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: unknown (0x1d)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x1
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x1
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103be8000 from client 18
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00103A11
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: unknown (0x1d)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x1
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x1
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103b05000 from client 18
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00103A11
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: unknown (0x1d)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x1
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x1
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103b00000 from client 18
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103be6000 from client 18
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103b01000 from client 18
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:10 kernel: gmc_v11_0_process_interrupt: 222971 callbacks suppre=
ssed
> > > 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103b05000 from client 18
> > > 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00103A11
> > > 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: unknown (0x1d)
> > > 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x1
> > > 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x1
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103b00000 from client 18
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00103A11
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: unknown (0x1d)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x1
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x1
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103be6000 from client 18
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103be8000 from client 18
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103b05000 from client 18
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103be6000 from client 18
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103b00000 from client 18
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103b01000 from client 18
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103be6000 from client 18
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103b01000 from client 18
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:15 kernel: gmc_v11_0_process_interrupt: 236783 callbacks suppre=
ssed
> > > 10:13:15 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103b05000 from client 18
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00103A11
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: unknown (0x1d)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x1
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x1
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103b00000 from client 18
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103be6000 from client 18
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103be8000 from client 18
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103b05000 from client 18
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103be6000 from client 18
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103b01000 from client 18
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103b00000 from client 18
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103be6000 from client 18
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src=
_id:0 ring:8 vmid:1 pasid:32777)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0 in process RDD Pr=
ocess pid 2857 thread firefox:cs0 pid 2909)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0 in page sta=
rting at address 0x0000800103b01000 from client 18
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAUL=
T_STATUS:0x00000000
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faulty UTCL2 client ID: VMC (0x0)
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALKER_ERROR: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERROR: 0x0
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW: 0x0
> > > 10:13:16 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring vcn_=
unified_0 timeout, signaled seq=3D5197,
> > > emitted
> > > seq=3D5200
> > > 10:13:16 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process i=
nformation: process RDD Process pid 2857
> > > thread
> > > firefox:cs0 pid 2909
> > > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset begin!
> > > 10:13:16 kernel: [drm] Register(0) [regUVD_POWER_STATUS] failed to re=
ach value 0x00000001 !=3D 0x00000002n
> > > 10:13:17 kernel: [drm] Register(0) [regUVD_RB_RPTR] failed to reach v=
alue 0x00000340 !=3D 0x000002c0n
> > > 10:13:17 kernel: [drm] Register(0) [regUVD_POWER_STATUS] failed to re=
ach value 0x00000001 !=3D 0x00000002n
> > > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: MODE2 reset
> > > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset succeeded, tr=
ying to resume
> > > 10:13:17 kernel: [drm] PCIE GART of 512M enabled (table at 0x00000080=
1FD00000).
> > > 10:13:17 kernel: [drm] VRAM is lost due to GPU reset!
> > > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
> > > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: SMU is resumed successf=
ully!
> > > 10:13:17 kernel: [drm] DMUB hardware initialized: version=3D0x08003A0=
0
> > > 10:13:17 kernel: [drm] kiq ring mec 3 pipe 1 q 0
> > > 10:13:17 kernel: amdgpu 0000:03:00.0: [drm:jpeg_v4_0_hw_init [amdgpu]=
] JPEG decode initialized successfully.
> > > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM =
inv eng 0 on hub 0
> > > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM=
 inv eng 1 on hub 0
> > > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM=
 inv eng 4 on hub 0
> > > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM=
 inv eng 6 on hub 0
> > > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM=
 inv eng 7 on hub 0
> > > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM=
 inv eng 8 on hub 0
> > > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM=
 inv eng 9 on hub 0
> > > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM=
 inv eng 10 on hub 0
> > > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM=
 inv eng 11 on hub 0
> > > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv =
eng 12 on hub 0
> > > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring vcn_unified_0 uses=
 VM inv eng 0 on hub 8
> > > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM i=
nv eng 1 on hub 8
> > > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring mes_kiq_3.1.0 uses=
 VM inv eng 13 on hub 0
> > > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: recover vram bo from sh=
adow start
> > > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: recover vram bo from sh=
adow done
> > > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset(1) succeeded!
> > > 10:13:17 kernel: [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to ini=
tialize parser -125!
> > >=20
> > > A crash of the program playing video (Firefox) is then triggered. It =
could happen any moment while playing
> > > videos. The
> > > problem is not observed in Linux 6.9, it appeared only after upgradin=
g to 6.10-rc1.
> > >=20
> > > I'm new to amdgpu and I've peeked into source codes but couldn't find=
 a call chain for the error reporting code.
> > > I've
> > > also went through drm-next commit logs, and from my understanding the=
 updates introduced to 6.10 are many and I
> > > couldn't bisect them all. However, I'm happy to provide you with a kd=
ump or a process dump if you request so.
> > > Please
> > > also allow me to know how I can provide you with more information.
> > >=20
> > > My system information: Ryzen 7840 HS, 512MB dedicated VRAM configured=
, Mesa 24.0.8, kernel 6.10-rc1.
> > >=20
> > > Hoping to hear from you soon.
> > >=20
> >=20
