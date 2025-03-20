Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE15C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 12:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2683710E28E;
	Thu, 20 Mar 2025 12:58:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CfKMxeD9";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1208F10E28E
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 12:58:47 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-301317939a0so189572a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 05:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742475526; x=1743080326; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=096poNbUe2/TVbBbY8qpQrbDMqYp4JacMmFpuZ4W0Dw=;
 b=CfKMxeD9qTswtjqF7oDuHdfiG2CH4sm19Mmt4UKN67MGWJqQo9kOl3m9mwexejpyIG
 3keAaMpuno8jyaP4dUEub/iPvZXSwwjFHKJ1Qk4E9X68dLvwf5wI/8RebzpsRlC1EHiv
 Rp7EUD9xd+5VuYdrLvP60rEKpkI8pQr7vsldIB+qu63EfPpKu0NwpMV7OdejZcSLvDAK
 fYBdoB71EI6HgFfOr8pujigQKviV/k+1LY/ptt5Bx0+V6kzpBy1Z+EJCXfTbb8cFaFxk
 BcZrW5QUhHqSF6X7j5R1gjLegiLjE9a7O+vmxHiQRWm6D/hju1Tiz/9mISJgWhQctFHF
 Wqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742475526; x=1743080326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=096poNbUe2/TVbBbY8qpQrbDMqYp4JacMmFpuZ4W0Dw=;
 b=Ioy/7oERCuiWnqka6/vldUSCfjnEx2PGyHEqHWcNADOWfGLf53bA2Lrugh8qjOXhNP
 SVrylT/sH3SCSoDxgjriHWrn+g3RFwvoieL10RNT4hBHSHuS0lR3MS+Hm1m9a2fPfk1w
 qb5M7QDiCrBHdo/tAr9pv3abzjM/xaFs39tUOaK18qr2694Tk8xuU6DQ1kYRk6zLQ0P8
 Fn0haRr1rIv/aVwVZgT3lCBxf6l1FIbMXpMMy360ebrqNFGuBBFkpF3xFp+Ss8c1ZmL5
 v0KiaQx372KaiK8ygQh+F3/wY3CUESJyMSAbyd3GFb/y7bhdQcb1/VBa6cWuPClqatLD
 dHHw==
X-Gm-Message-State: AOJu0YyIHMK6/SE0oTz6TQpFFv4Uz3zqeZvz10uaMlGyDImf7UHutdIr
 lWguP6vTJlwVEtkxerRr+0n0LcfMeXD4nHrBghYIa2JupXVfK69XvxfTccz9CyTHBYbMGHCaByg
 qcOXxK0QFDP0R2tEB2vMBgOA6RsyZ8zgO
X-Gm-Gg: ASbGnctYWFGLuRlFOftkqIykBLBC6TsGUF6hjcSk7OtjWcZzRaHoEGUBYqdoVGbWa5Y
 rJneMAoa0wb+7dMZrlnmxIJ2mBxRpnzBAATVlY+ETDA7ZhrKp9mR/GEuR6z0hbM71vCHl32lkbp
 yhvRvdemJrOTOszb0syuw/jJ/Wjg==
X-Google-Smtp-Source: AGHT+IFFxe1ybChh5QczGgXDymCmO81z5eogBBscMRvsHmkwPwL0Ge9WhVGcrRgzosFZDct5OVegHQ4mumNOc571JGY=
X-Received: by 2002:a17:90b:38c7:b0:2fe:a747:935a with SMTP id
 98e67ed59e1d1-301bfce880fmr3809687a91.4.1742475526364; Thu, 20 Mar 2025
 05:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250319063811.680138-1-kenneth.feng@amd.com>
 <CADnq5_Nx2FGd66uwkmV6Hhrvdfc+VTO=OafZJDK=AVXhBKQM7Q@mail.gmail.com>
 <BL1PR12MB51589B39082C439AAC8E19048ED82@BL1PR12MB5158.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51589B39082C439AAC8E19048ED82@BL1PR12MB5158.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Mar 2025 08:58:34 -0400
X-Gm-Features: AQ5f1Jphh54mwz0UBwOYTxNahHqG3su11z_uXTNUZdaQeQzXTGUSOah2Nwwo2Cs
Message-ID: <CADnq5_NwGh2HJN2o8XqiHH2FtqTaOecdj0jTAQ=XpuM+_d=X1A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Revert "drm/amd/amdgpu: shorten the gfx
 idle worker timeout"
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Mar 20, 2025 at 4:29=E2=80=AFAM Feng, Kenneth <Kenneth.Feng@amd.com=
> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Alex,
> The call trace is generated when the gdm is launched, as below.
> I tried running on a standalone workqueue but still see the workqueue is =
flushed.

I think that should be fixed by this patch:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dde35994ecd2dd6148ab5a6c5050a1670a04dec77

Alex

> Thanks.
>
> [   21.558439] ------------[ cut here ]------------
> [   21.558443] workqueue: WQ_MEM_RECLAIM gfx_0.0.0:drm_sched_run_job_work=
 [amd_sched] is flushing !WQ_MEM_RECLAIM events:amdgpu_gfx_profile_idle_wor=
k_handler [amdgpu]
> [   21.558716] WARNING: CPU: 0 PID: 115 at kernel/workqueue.c:3706 check_=
flush_dependency+0x151/0x180
> [   21.558724] Modules linked in: snd_seq_dummy snd_hrtimer qrtr sunrpc a=
md_atl intel_rapl_msr intel_rapl_common snd_hda_codec_hdmi snd_hda_intel sn=
d_intel_dspcfg edac_mce_amd snd_intel_sdw_acpi snd_usb_audio snd_hda_codec =
kvm_amd snd_usbmidi_lib snd_hda_core snd_ump mc snd_hwdep snd_pcm kvm snd_s=
eq_midi snd_seq_midi_event crct10dif_pclmul snd_rawmidi polyval_clmulni pol=
yval_generic ghash_clmulni_intel spd5118 sha256_ssse3 sha1_ssse3 snd_seq ae=
sni_intel crypto_simd cryptd snd_seq_device snd_timer rapl wmi_bmof ccp snd=
 i2c_piix4 k10temp i2c_smbus soundcore input_leds joydev gpio_amdpt mac_hid=
 binfmt_misc sch_fq_codel msr parport_pc ppdev lp parport efi_pstore nfnetl=
ink dmi_sysfs ip_tables x_tables autofs4 hid_generic usbhid hid amdgpu(OE) =
amddrm_ttm_helper(OE) amdttm(OE) amddrm_buddy(OE) amdxcp(OE) drm_exec drm_s=
uballoc_helper amd_sched(OE) amdkcl(OE) drm_display_helper cec rc_core nvme=
 i2c_algo_bit drm_ttm_helper crc32_pclmul r8169 xhci_pci nvme_core ahci ttm=
 xhci_pci_renesas libahci realtek nvme_auth video wmi
> [   21.558817] CPU: 0 UID: 0 PID: 115 Comm: kworker/u64:1 Tainted: G     =
      OE      6.11.0-17-generic #17~24.04.2-Ubuntu
> [   21.558822] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> [   21.558823] Hardware name: Micro-Star International Co., Ltd. MS-7D76/=
MAG B650M MORTAR WIFI (MS-7D76), BIOS A.J0 12/17/2024
> [   21.558825] Workqueue: gfx_0.0.0 drm_sched_run_job_work [amd_sched]
> [   21.558830] RIP: 0010:check_flush_dependency+0x151/0x180
> [   21.558833] Code: 56 18 4d 89 e0 48 8d 8b c0 00 00 00 48 c7 c7 e8 88 0=
9 a1 c6 05 e8 4d 8d 02 01 48 8b 70 08 48 81 c6 c0 00 00 00 e8 6f 54 fd ff <=
0f> 0b e9 d2 fe ff ff 44 0f b6 3d ca 4d 8d 02 41 80 ff 01 77 0f 41
> [   21.558836] RSP: 0018:ffffae930051fbe8 EFLAGS: 00010046
> [   21.558838] RAX: 0000000000000000 RBX: ffff9abf80201400 RCX: 000000000=
0000000
> [   21.558840] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [   21.558842] RBP: ffffae930051fc10 R08: 0000000000000000 R09: 000000000=
0000000
> [   21.558843] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffc=
0992ad0
> [   21.558844] R13: 0000000000000000 R14: ffff9abf8030d440 R15: ffffae930=
051fc40
> [   21.558846] FS:  0000000000000000(0000) GS:ffff9ace9d800000(0000) knlG=
S:0000000000000000
> [   21.558848] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   21.558850] CR2: 0000073bf2b6c000 CR3: 000000004623e000 CR4: 000000000=
0f50ef0
> [   21.558852] PKRU: 55555554
> [   21.558853] Call Trace:
> [   21.558855]  <TASK>
> [   21.558859]  ? show_regs+0x6c/0x80
> [   21.558864]  ? __warn+0x88/0x140
> [   21.558867]  ? check_flush_dependency+0x151/0x180
> [   21.558870]  ? report_bug+0x182/0x1b0
> [   21.558875]  ? handle_bug+0x6e/0xb0
> [   21.558880]  ? exc_invalid_op+0x18/0x80
> [   21.558883]  ? asm_exc_invalid_op+0x1b/0x20
> [   21.558888]  ? __pfx_amdgpu_gfx_profile_idle_work_handler+0x10/0x10 [a=
mdgpu]
> [   21.559113]  ? check_flush_dependency+0x151/0x180
> [   21.559116]  ? check_flush_dependency+0x151/0x180
> [   21.559120]  __flush_work+0x238/0x310
> [   21.559124]  ? __mod_timer+0x122/0x340
> [   21.559129]  cancel_delayed_work_sync+0x76/0x80
> [   21.559133]  amdgpu_gfx_profile_ring_begin_use+0x34/0xa0 [amdgpu]
> [   21.559341]  gfx_v12_0_ring_begin_use+0x12/0x30 [amdgpu]
> [   21.559531]  amdgpu_ring_alloc+0x40/0x70 [amdgpu]
> [   21.559675]  amdgpu_ib_schedule+0x172/0x830 [amdgpu]
> [   21.559821]  amdgpu_job_run+0x8d/0x200 [amdgpu]
> [   21.559994]  drm_sched_run_job_work+0x2bb/0x450 [amd_sched]
> [   21.559997]  process_one_work+0x178/0x3d0
> [   21.560000]  worker_thread+0x2de/0x410
> [   21.560002]  ? __pfx_worker_thread+0x10/0x10
> [   21.560004]  kthread+0xe1/0x110
> [   21.560006]  ? __pfx_kthread+0x10/0x10
> [   21.560008]  ret_from_fork+0x44/0x70
> [   21.560010]  ? __pfx_kthread+0x10/0x10
> [   21.560012]  ret_from_fork_asm+0x1a/0x30
> [   21.560017]  </TASK>
> [   21.560017] ---[ end trace 0000000000000000 ]---
>
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, March 19, 2025 8:54 PM
> To: Feng, Kenneth <Kenneth.Feng@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>
> Subject: Re: [PATCH] drm/amd/amdgpu: Revert "drm/amd/amdgpu: shorten the =
gfx idle worker timeout"
>
> Caution: This message originated from an External Source. Use proper caut=
ion when opening attachments, clicking links, or responding.
>
>
> On Wed, Mar 19, 2025 at 2:38=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.co=
m> wrote:
> >
> > This reverts commit b00fb9765ea4b05198d67256118445c6f13f9ddf.
> >
> > Reason for revert: this causes some tests fail with call trace.
>
> Do you have a copy of the call trace?  I can't see how this would be an i=
ssue?
>
> Alex
>
> >
> > Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > index a6d3a4554caa..75af4f25a133 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -57,8 +57,8 @@ enum amdgpu_gfx_pipe_priority {  #define
> > AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0  #define
> > AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
> >
> > -/* 10 millisecond timeout */
> > -#define GFX_PROFILE_IDLE_TIMEOUT       msecs_to_jiffies(10)
> > +/* 1 second timeout */
> > +#define GFX_PROFILE_IDLE_TIMEOUT       msecs_to_jiffies(1000)
> >
> >  enum amdgpu_gfx_partition {
> >         AMDGPU_SPX_PARTITION_MODE =3D 0,
> > --
> > 2.34.1
> >
