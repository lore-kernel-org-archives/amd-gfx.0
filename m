Return-Path: <SRS0=BIvg=DA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58794C4363D
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 01:48:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08FF2371F
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 01:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teqHAPRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08FF2371F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43EED6E0E0;
	Wed, 23 Sep 2020 01:48:57 +0000 (UTC)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92B9C6E0E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2020 01:41:00 +0000 (UTC)
Received: by mail-vk1-xa30.google.com with SMTP id h23so4772082vkn.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 18:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=sQ2hnyE9WHB2+vsIY8b33SnZtnsTWwbVthk8vwUVK30=;
 b=teqHAPRTdMbRRhO2h6RHqtzwfgjmr6urbQJ3iBM6XfZhtEeVv5hXHGX+UXmHeshFou
 DvYwQ5pxkfUDkzvnRgONiJFx6Zy2t+vYOyDVhjJEgf15t8rOoMuxYKG0hOUXnC8KtIrq
 i6DWXiblCgygR2lhoYkgkCKvqucUZu2yKrCMXYzLgvY0nSWCIx32TPUSmDZ9UMPLdR/f
 kLPq9LIxmoSNWZRPtnu4iaIIdArcDcAGTW7ASSc3jpQmDqIQZ4gVt/HHFcn+jBcYdc7R
 AWt6XFqvGx3it7svbSgeNBM57+vRFz06ZJaaeF4qxF8nHAKmED6kc+Yy8YHEKuXt4jB9
 v/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=sQ2hnyE9WHB2+vsIY8b33SnZtnsTWwbVthk8vwUVK30=;
 b=ggZHWsGn8Lv5u0CmuvZFu+tplJzE0wwgN7c3DSLFPRmgiFJ4CEMlpeKSp5H0f89PD1
 w/pCa7+ejSHOOke18NS70DwAYaSlhVifkN/iFEMoGm/LIo0EeuxZdwVxrZx5PLjwsM+L
 08ysN9ymmyOlWIoCdTGAP7k+H8gNSLwYm6g5a9Z8Du0HXbFdP4aosruIMgCpYFmp6ymF
 YTt3TyG/dVTcvEYMe4gsWfHToFgonSdOiEFwT5PV0BODmsjRaKvShoX3FiOiZ6YntpmC
 dtTU1wixZQgmAIvcqSXNuc89rEvVt+AttwAQQ4i4vlcabZpU4Mb++9MOUlCsBsLKhxqd
 jnxQ==
X-Gm-Message-State: AOAM532Maalod9DxHjA5GMlBW3jpTOrmS2P2LsOLTqTpD/EvlbxJ7uQB
 TQMpoeDkzgCbkrWNO/NqgV8uddFZO7kOqCHEBbdjd7uNsLOSSw==
X-Google-Smtp-Source: ABdhPJzlr+WwGygsGxxl1VSJrSSIBqcTZOupPJlXFNJBdxznVsLjBkfzfz4LjFhL7SoFHNbL/kL05r7Ni7/qtW9/v28=
X-Received: by 2002:a1f:fe46:: with SMTP id l67mr5330253vki.23.1600825259156; 
 Tue, 22 Sep 2020 18:40:59 -0700 (PDT)
MIME-Version: 1.0
From: Bram Stolk <b.stolk@gmail.com>
Date: Tue, 22 Sep 2020 18:40:48 -0700
Message-ID: <CABYXEkvjfd5Cu6_UdEWf=UykLDyCBXNCme-2xKCvC5ab7Os04A@mail.gmail.com>
Subject: dcn20_validate_bandwidth warnings.
To: amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Wed, 23 Sep 2020 01:48:55 +0000
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
Content-Type: multipart/mixed; boundary="===============1968650262=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1968650262==
Content-Type: multipart/alternative; boundary="000000000000eb6c4b05aff12c74"

--000000000000eb6c4b05aff12c74
Content-Type: text/plain; charset="UTF-8"

My system log is full of warnings about dcn20_validate_bandwidth (see
below.)

This is with RX 5500 XT device running amd gpupro driver. 20.30-1109583
amdgpu-dkms 1:5.6.5.24-1109583

This seems to coincide with a screen full of pixel noise, and seems
triggered when going in, or out of a sleep/idle mode?

[184701.291613] ------------[ cut here ]------------
[184701.291740] WARNING: CPU: 12 PID: 1567 at
/var/lib/dkms/amdgpu/5.6.5.24-1109583/build/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:3250
dcn20_validate_bandwidth_fp+0x8a/0xd0 [amdgpu]
[184701.291741] Modules linked in: AMDPowerProfiler(OE) btrfs xor
zstd_compress raid6_pq ufs qnx4 hfsplus hfs minix ntfs msdos jfs xfs
libcrc32c cpuid netlink_diag intel_rapl_msr intel_rapl_common
isst_if_common skx_edac nfit x86_pkg_temp_thermal intel_powerclamp
ipmi_ssif snd_hda_codec_hdmi binfmt_misc uas usb_storage coretemp
snd_hda_intel snd_intel_dspcfg kvm_intel snd_hda_codec kvm snd_hda_core
amdgpu(OE) nls_iso8859_1 snd_hwdep snd_pcm amd_iommu_v2 snd_seq_midi
amd_sched(OE) snd_seq_midi_event amdttm(OE) snd_rawmidi crct10dif_pclmul
snd_seq ghash_clmulni_intel aesni_intel snd_seq_device crypto_simd
snd_timer amdkcl(OE) cryptd glue_helper drm_kms_helper snd fb_sys_fops rapl
mei_me syscopyarea xpad ipmi_si sysfillrect intel_cstate input_leds joydev
ff_memless sysimgblt soundcore mei ioatdma ipmi_devintf ipmi_msghandler
mac_hid acpi_tad sch_fq_codel parport_pc ppdev lp parport drm ip_tables
x_tables autofs4 hid_generic usbhid hid crc32_pclmul igb nvme nvme_core
i2c_algo_bit i2c_i801 dca wmi
[184701.291776]  [last unloaded: AMDPowerProfiler]
[184701.291780] CPU: 12 PID: 1567 Comm: Xorg Tainted: G        W  OE
5.4.0-47-generic #51-Ubuntu
[184701.291781] Hardware name: Supermicro Super Server/X11SRM-F, BIOS 2.2
09/03/2020
[184701.291888] RIP: 0010:dcn20_validate_bandwidth_fp+0x8a/0xd0 [amdgpu]
[184701.291890] Code: 24 08 1f 00 00 75 29 31 d2 4c 89 e6 4c 89 ef f2 41 0f
11 84 24 50 26 00 00 e8 f2 f5 ff ff 89 c2 41 22 94 24 08 1f 00 00 75 33
<0f> 0b eb 02 75 cd f2 0f 10 55 e8 f2 41 0f 11 94 24 50 26 00 00 48
[184701.291891] RSP: 0018:ffffb46b4298fa20 EFLAGS: 00010246
[184701.291893] RAX: 0000000000000001 RBX: 0000000000000000 RCX:
00000000000ea272
[184701.291893] RDX: 0000000000000000 RSI: af2e92a2240f908b RDI:
000000000002f1a0
[184701.291894] RBP: ffffb46b4298fa38 R08: 0000000000000005 R09:
0000000000000000
[184701.291895] R10: 0000000000000004 R11: 0000000100000001 R12:
ffff986787960000
[184701.291896] R13: ffff986992740000 R14: ffff986917709830 R15:
ffff986787960000
[184701.291897] FS:  00007f9fd16f5a80(0000) GS:ffff98699ff00000(0000)
knlGS:0000000000000000
[184701.291898] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[184701.291899] CR2: 00007fb240ca20c0 CR3: 0000000806c6c004 CR4:
00000000003606e0
[184701.291900] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[184701.291901] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[184701.291901] Call Trace:
[184701.292005]  dcn20_validate_bandwidth+0x29/0x40 [amdgpu]
[184701.292099]  dc_validate_global_state+0x260/0x2d0 [amdgpu]
[184701.292196]  amdgpu_dm_atomic_check+0xcd3/0xd10 [amdgpu]
[184701.292215]  drm_atomic_check_only+0x2b1/0x450 [drm]
[184701.292227]  drm_atomic_commit+0x18/0x50 [drm]
[184701.292239]  drm_atomic_connector_commit_dpms+0xdf/0x100 [drm]
[184701.292252]  drm_mode_obj_set_property_ioctl+0x156/0x2a0 [drm]
[184701.292265]  ? drm_connector_set_obj_prop+0x90/0x90 [drm]
[184701.292277]  drm_connector_property_set_ioctl+0x3b/0x60 [drm]
[184701.292286]  drm_ioctl_kernel+0xae/0xf0 [drm]
[184701.292295]  drm_ioctl+0x234/0x3d0 [drm]
[184701.292306]  ? drm_connector_set_obj_prop+0x90/0x90 [drm]
[184701.292310]  ? ___sys_recvmsg+0x88/0xc0
[184701.292354]  amdgpu_drm_ioctl+0x4e/0x80 [amdgpu]
[184701.292356]  do_vfs_ioctl+0x407/0x670
[184701.292359]  ? fput+0x13/0x15
[184701.292361]  ? __sys_recvmsg+0x88/0xa0
[184701.292363]  ksys_ioctl+0x67/0x90
[184701.292364]  __x64_sys_ioctl+0x1a/0x20
[184701.292367]  do_syscall_64+0x57/0x190
[184701.292370]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[184701.292372] RIP: 0033:0x7f9fd1a5537b
[184701.292373] Code: 0f 1e fa 48 8b 05 15 3b 0d 00 64 c7 00 26 00 00 00 48
c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05
<48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e5 3a 0d 00 f7 d8 64 89 01 48
[184701.292374] RSP: 002b:00007ffc96832f98 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[184701.292376] RAX: ffffffffffffffda RBX: 00007ffc96832fd0 RCX:
00007f9fd1a5537b
[184701.292376] RDX: 00007ffc96832fd0 RSI: 00000000c01064ab RDI:
000000000000000d
[184701.292377] RBP: 00000000c01064ab R08: 00007ffc96895090 R09:
00007ffc96832eb8
[184701.292378] R10: 00007ffc96832eb0 R11: 0000000000000246 R12:
0000557656b2fb40
[184701.292379] R13: 000000000000000d R14: 0000000000000000 R15:
0000557656a46980
[184701.292381] ---[ end trace 91d0e0d7876bea26 ]---


-- 
Owner/Director of Game Studio Abraham Stolk Inc.
Vancouver BC, Canada
b.stolk@gmail.com

--000000000000eb6c4b05aff12c74
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>My system log is full of warnings about dcn20_validat=
e_bandwidth (see below.)</div><div><br></div><div>This is with RX 5500 XT d=
evice running amd gpupro driver. 20.30-1109583</div><div>amdgpu-dkms 1:5.6.=
5.24-1109583</div><div><br></div><div>This seems to coincide with a screen =
full of pixel noise, and seems triggered when going in, or out of a sleep/i=
dle mode?</div><div><br></div><div><font size=3D"1">[184701.291613] -------=
-----[ cut here ]------------<br>[184701.291740] WARNING: CPU: 12 PID: 1567=
 at /var/lib/dkms/amdgpu/5.6.5.24-1109583/build/amd/amdgpu/../display/dc/dc=
n20/dcn20_resource.c:3250 dcn20_validate_bandwidth_fp+0x8a/0xd0 [amdgpu]<br=
>[184701.291741] Modules linked in: AMDPowerProfiler(OE) btrfs xor zstd_com=
press raid6_pq ufs qnx4 hfsplus hfs minix ntfs msdos jfs xfs libcrc32c cpui=
d netlink_diag intel_rapl_msr intel_rapl_common isst_if_common skx_edac nfi=
t x86_pkg_temp_thermal intel_powerclamp ipmi_ssif snd_hda_codec_hdmi binfmt=
_misc uas usb_storage coretemp snd_hda_intel snd_intel_dspcfg kvm_intel snd=
_hda_codec kvm snd_hda_core amdgpu(OE) nls_iso8859_1 snd_hwdep snd_pcm amd_=
iommu_v2 snd_seq_midi amd_sched(OE) snd_seq_midi_event amdttm(OE) snd_rawmi=
di crct10dif_pclmul snd_seq ghash_clmulni_intel aesni_intel snd_seq_device =
crypto_simd snd_timer amdkcl(OE) cryptd glue_helper drm_kms_helper snd fb_s=
ys_fops rapl mei_me syscopyarea xpad ipmi_si sysfillrect intel_cstate input=
_leds joydev ff_memless sysimgblt soundcore mei ioatdma ipmi_devintf ipmi_m=
sghandler mac_hid acpi_tad sch_fq_codel parport_pc ppdev lp parport drm ip_=
tables x_tables autofs4 hid_generic usbhid hid crc32_pclmul igb nvme nvme_c=
ore i2c_algo_bit i2c_i801 dca wmi<br>[184701.291776] =C2=A0[last unloaded: =
AMDPowerProfiler]<br>[184701.291780] CPU: 12 PID: 1567 Comm: Xorg Tainted: =
G =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0OE =C2=A0 =C2=A0 5.4.0-47-generic #51-=
Ubuntu<br>[184701.291781] Hardware name: Supermicro Super Server/X11SRM-F, =
BIOS 2.2 09/03/2020<br>[184701.291888] RIP: 0010:dcn20_validate_bandwidth_f=
p+0x8a/0xd0 [amdgpu]<br>[184701.291890] Code: 24 08 1f 00 00 75 29 31 d2 4c=
 89 e6 4c 89 ef f2 41 0f 11 84 24 50 26 00 00 e8 f2 f5 ff ff 89 c2 41 22 94=
 24 08 1f 00 00 75 33 &lt;0f&gt; 0b eb 02 75 cd f2 0f 10 55 e8 f2 41 0f 11 =
94 24 50 26 00 00 48<br>[184701.291891] RSP: 0018:ffffb46b4298fa20 EFLAGS: =
00010246<br>[184701.291893] RAX: 0000000000000001 RBX: 0000000000000000 RCX=
: 00000000000ea272<br>[184701.291893] RDX: 0000000000000000 RSI: af2e92a224=
0f908b RDI: 000000000002f1a0<br>[184701.291894] RBP: ffffb46b4298fa38 R08: =
0000000000000005 R09: 0000000000000000<br>[184701.291895] R10: 000000000000=
0004 R11: 0000000100000001 R12: ffff986787960000<br>[184701.291896] R13: ff=
ff986992740000 R14: ffff986917709830 R15: ffff986787960000<br>[184701.29189=
7] FS: =C2=A000007f9fd16f5a80(0000) GS:ffff98699ff00000(0000) knlGS:0000000=
000000000<br>[184701.291898] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 00000000=
80050033<br>[184701.291899] CR2: 00007fb240ca20c0 CR3: 0000000806c6c004 CR4=
: 00000000003606e0<br>[184701.291900] DR0: 0000000000000000 DR1: 0000000000=
000000 DR2: 0000000000000000<br>[184701.291901] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400<br>[184701.291901] Call Trace:<br>[1=
84701.292005] =C2=A0dcn20_validate_bandwidth+0x29/0x40 [amdgpu]<br>[184701.=
292099] =C2=A0dc_validate_global_state+0x260/0x2d0 [amdgpu]<br>[184701.2921=
96] =C2=A0amdgpu_dm_atomic_check+0xcd3/0xd10 [amdgpu]<br>[184701.292215] =
=C2=A0drm_atomic_check_only+0x2b1/0x450 [drm]<br>[184701.292227] =C2=A0drm_=
atomic_commit+0x18/0x50 [drm]<br>[184701.292239] =C2=A0drm_atomic_connector=
_commit_dpms+0xdf/0x100 [drm]<br>[184701.292252] =C2=A0drm_mode_obj_set_pro=
perty_ioctl+0x156/0x2a0 [drm]<br>[184701.292265] =C2=A0? drm_connector_set_=
obj_prop+0x90/0x90 [drm]<br>[184701.292277] =C2=A0drm_connector_property_se=
t_ioctl+0x3b/0x60 [drm]<br>[184701.292286] =C2=A0drm_ioctl_kernel+0xae/0xf0=
 [drm]<br>[184701.292295] =C2=A0drm_ioctl+0x234/0x3d0 [drm]<br>[184701.2923=
06] =C2=A0? drm_connector_set_obj_prop+0x90/0x90 [drm]<br>[184701.292310] =
=C2=A0? ___sys_recvmsg+0x88/0xc0<br>[184701.292354] =C2=A0amdgpu_drm_ioctl+=
0x4e/0x80 [amdgpu]<br>[184701.292356] =C2=A0do_vfs_ioctl+0x407/0x670<br>[18=
4701.292359] =C2=A0? fput+0x13/0x15<br>[184701.292361] =C2=A0? __sys_recvms=
g+0x88/0xa0<br>[184701.292363] =C2=A0ksys_ioctl+0x67/0x90<br>[184701.292364=
] =C2=A0__x64_sys_ioctl+0x1a/0x20<br>[184701.292367] =C2=A0do_syscall_64+0x=
57/0x190<br>[184701.292370] =C2=A0entry_SYSCALL_64_after_hwframe+0x44/0xa9<=
br>[184701.292372] RIP: 0033:0x7f9fd1a5537b<br>[184701.292373] Code: 0f 1e =
fa 48 8b 05 15 3b 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f =
1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 &lt;48&gt; 3d 01 f0 ff ff 73 0=
1 c3 48 8b 0d e5 3a 0d 00 f7 d8 64 89 01 48<br>[184701.292374] RSP: 002b:00=
007ffc96832f98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010<br>[184701.29237=
6] RAX: ffffffffffffffda RBX: 00007ffc96832fd0 RCX: 00007f9fd1a5537b<br>[18=
4701.292376] RDX: 00007ffc96832fd0 RSI: 00000000c01064ab RDI: 0000000000000=
00d<br>[184701.292377] RBP: 00000000c01064ab R08: 00007ffc96895090 R09: 000=
07ffc96832eb8<br>[184701.292378] R10: 00007ffc96832eb0 R11: 000000000000024=
6 R12: 0000557656b2fb40<br>[184701.292379] R13: 000000000000000d R14: 00000=
00000000000 R15: 0000557656a46980<br>[184701.292381] ---[ end trace 91d0e0d=
7876bea26 ]---</font><br></div><div><br></div><div><br>-- <br><div dir=3D"l=
tr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div>Owner/Director of Game Studio Abraham Stolk Inc.</div><div>Va=
ncouver BC, Canada</div><div><a href=3D"mailto:b.stolk@gmail.com" target=3D=
"_blank">b.stolk@gmail.com</a></div><div><br></div></div></div></div></div>

--000000000000eb6c4b05aff12c74--

--===============1968650262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1968650262==--
