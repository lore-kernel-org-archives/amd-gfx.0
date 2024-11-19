Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C13D60CEF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 04:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F7A10E5C2;
	Tue, 19 Nov 2024 04:26:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L3hr+KiG";
	dkim-atps=neutral
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 347C710E5B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 04:26:09 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-6d382677c92so21501636d6.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 20:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731990368; x=1732595168; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AK5WzutSqLOtOViCBoZHYe7VbnzH5rpDtrrLlgrlmdo=;
 b=L3hr+KiGnlEF7LzEri4+tv3HjAOS8G0LXcSE44OCFBfjGD0VNMKq+1zwHhzDBsmM89
 ccdUcQf5hQQInz/3gcKKr5sWRQxHD6pTHnZJ1boae3f41EEBQoUS8FplrMBAHUHPVA4H
 oGMeunIPmFu9SlXEEIXdV7GYFG4eMUK72P/VzgBgXyQYhY4NMkb9iUIaM+CWG4ffcYpB
 YddYNgtv7VQ33hrfLx/Qee36XqSR06mCbSYbNiNZtL+IF5sKT+A/Gx+IPYgTVLEmddWG
 q9fIB5KVGHdcuYxx1Qsja9oyOKxUDXpv5Ui3UflcygvUHpoUlfwHamze75WjqN4Y/wqu
 BGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731990368; x=1732595168;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AK5WzutSqLOtOViCBoZHYe7VbnzH5rpDtrrLlgrlmdo=;
 b=wdjjHESkfxRat3awbOm23/BHf4Nbr7MoKpTaNXzApKNYbDizg0klUMedwhFHwPLVAc
 rGEiUlMBqzQ5mRSoGUVVhwek/lUJEky7H6oMndcSGiaN0q02WBzRUIwhcg8tWkSbNMLw
 u6PcbN8gcJOoX34mT7P+/EDYc/E5U6mOmiLzmAQ8WUMsO5QoxhJzedYbVfmAthCj6DPq
 N4NVmb5Goxc7symH4/es4WwiRSJ01EOpDdos3uGychhameHGCgO+A3Eh3m5VExWWHsn9
 IPMSlTDIYXYhYCoND46C4uWJpJw0GGcvSGJx+kuJ2DPG3MAo4a/BFUmLFGafmsBdrtrg
 B5kg==
X-Gm-Message-State: AOJu0YzvOpot+VUhismFMAbSnLIQwlnZIvIb3VtGzAntVvD8lFYbhWx4
 tNazQk2vxoA9Aky1NPuNryWB1UcWbeLvUZ1v19yaLywOhaqnFs0IsAv8QZdv3rcHqNCpDiGMUOa
 oRaKi1seK3wdlYZedqIwNCMOgOKm9f4CZMXo=
X-Google-Smtp-Source: AGHT+IGMzPQcznQXObhKG3ngoauhk6K0Cs9uXcPbqE1xJ7+Za310apa6dON4V5fGUXISgkfyuxDb6+K+3h1K3UoBx9o=
X-Received: by 2002:a05:6214:e67:b0:6d4:19d2:2086 with SMTP id
 6a1803df08f44-6d419d222c5mr148044226d6.36.1731990367822; Mon, 18 Nov 2024
 20:26:07 -0800 (PST)
MIME-Version: 1.0
From: Gregory Carter <gjcarter2@gmail.com>
Date: Mon, 18 Nov 2024 21:25:57 -0700
Message-ID: <CAE4jU7gZPeznzxOZdOqieyH1e-8kD1hKg+NwRGXkTKn4yB_6DQ@mail.gmail.com>
Subject: Vanilla Kernel Build of Recent 6.12.0 Kernel Test Results on M18r1
 AMD Alienware
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000a0ed7106273c6e5c"
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

--000000000000a0ed7106273c6e5c
Content-Type: text/plain; charset="UTF-8"

Nov 18 18:37:33.973691 discernment.aesgi.com kernel: warning:
`QSampleCache::L' uses wireless extensions which will stop working for
Wi-Fi 7 hardware; use nl80211
Nov 18 18:37:35.761857 discernment.aesgi.com kernel: ------------[ cut here
]------------
Nov 18 18:37:35.761928 discernment.aesgi.com kernel: WARNING: CPU: 10 PID:
11 at drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:223
dmub_psr_enable+0xfa/0x110 [amdgpu]
Nov 18 18:37:35.761940 discernment.aesgi.com kernel: Modules linked in:
snd_seq_dummy snd_hrtimer rfcomm nft_masq nft_ct nft_reject_ipv4
nf_reject_ipv4 nft_reject nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 nf_table>
Nov 18 18:37:35.761991 discernment.aesgi.com kernel:  videobuf2_v4l2
btintel videobuf2_common btbcm snd_seq_device libarc4 snd_pcm dell_smbios
btmtk videodev spd5118 snd_timer snd_pci_acp5x dcdbas bluetooth cfg80211
r8169 mc rapl dell_>
Nov 18 18:37:35.762015 discernment.aesgi.com kernel: CPU: 10 UID: 0 PID: 11
Comm: kworker/u128:0 Not tainted 6.12.0-RX7900M #1
Nov 18 18:37:35.762024 discernment.aesgi.com kernel: Hardware name:
Alienware Alienware m18 R1 AMD/049YP9, BIOS 1.15.0 09/09/2024
Nov 18 18:37:35.762038 discernment.aesgi.com kernel: Workqueue:
dm_vblank_control_workqueue amdgpu_dm_crtc_vblank_control_worker [amdgpu]
Nov 18 18:37:35.762047 discernment.aesgi.com kernel: RIP:
0010:dmub_psr_enable+0xfa/0x110 [amdgpu]
Nov 18 18:37:35.762056 discernment.aesgi.com kernel: Code: d1 81 fb e8 03
00 00 74 21 48 8b 44 24 48 65 48 2b 04 25 28 00 00 00 75 15 48 83 c4 50 5b
5d 41 5c 41 5d 41 5e c3 cc cc cc cc <0f> 0b eb db e8 4d 39 27 ee 66 66 2e
0f 1f 84 00 >
Nov 18 18:37:35.762065 discernment.aesgi.com kernel: RSP:
0018:ffffad0dc018fd38 EFLAGS: 00010246
Nov 18 18:37:35.762074 discernment.aesgi.com kernel: RAX: 0000001cb9fdfc52
RBX: 00000000000003e9 RCX: 000000000000000a
Nov 18 18:37:35.762082 discernment.aesgi.com kernel: RDX: 00000000000001f4
RSI: 000000000000004e RDI: 0000001cb9fdfa5e
Nov 18 18:37:35.762090 discernment.aesgi.com kernel: RBP: 0000000000000000
R08: ffff9ee0128a6a00 R09: 0000000000001d00
Nov 18 18:37:35.762098 discernment.aesgi.com kernel: R10: ffffad0e00af3500
R11: 000000000000001c R12: ffff9ee00cef9c90
Nov 18 18:37:35.762105 discernment.aesgi.com kernel: R13: 0000000000000000
R14: ffffad0dc018fd3c R15: ffffad0dc018fe1c
Nov 18 18:37:35.762114 discernment.aesgi.com kernel: FS:
 0000000000000000(0000) GS:ffff9eeebd300000(0000) knlGS:0000000000000000
Nov 18 18:37:35.762121 discernment.aesgi.com kernel: CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033
Nov 18 18:37:35.762129 discernment.aesgi.com kernel: CR2: 00007f0f41031b28
CR3: 0000000abb42a000 CR4: 0000000000f50ef0
Nov 18 18:37:35.762140 discernment.aesgi.com kernel: PKRU: 55555554
Nov 18 18:37:35.762147 discernment.aesgi.com kernel: Call Trace:
Nov 18 18:37:35.762155 discernment.aesgi.com kernel:  <TASK>
Nov 18 18:37:35.762791 discernment.aesgi.com kernel:  ?
dmub_psr_enable+0xfa/0x110 [amdgpu]
Nov 18 18:37:35.762811 discernment.aesgi.com kernel:  ?
__warn.cold+0x93/0xfa
Nov 18 18:37:35.762818 discernment.aesgi.com kernel:  ?
dmub_psr_enable+0xfa/0x110 [amdgpu]
Nov 18 18:37:35.762823 discernment.aesgi.com kernel:  ?
report_bug+0xff/0x140
Nov 18 18:37:35.762830 discernment.aesgi.com kernel:  ? handle_bug+0x58/0x90
Nov 18 18:37:35.762835 discernment.aesgi.com kernel:  ?
exc_invalid_op+0x17/0x70
Nov 18 18:37:35.762840 discernment.aesgi.com kernel:  ?
asm_exc_invalid_op+0x1a/0x20
Nov 18 18:37:35.762847 discernment.aesgi.com kernel:  ?
dmub_psr_enable+0xfa/0x110 [amdgpu]
Nov 18 18:37:35.762852 discernment.aesgi.com kernel:  ?
dmub_psr_enable+0xaf/0x110 [amdgpu]
Nov 18 18:37:35.762858 discernment.aesgi.com kernel:
 edp_set_psr_allow_active+0x27d/0x3b0 [amdgpu]
Nov 18 18:37:35.763760 discernment.aesgi.com kernel:
 amdgpu_dm_psr_disable+0x5b/0x80 [amdgpu]
Nov 18 18:37:35.763807 discernment.aesgi.com kernel:
 amdgpu_dm_crtc_vblank_control_worker+0x257/0x260 [amdgpu]
Nov 18 18:37:35.763838 discernment.aesgi.com kernel:
 process_one_work+0x178/0x330
Nov 18 18:37:35.763850 discernment.aesgi.com kernel:
 worker_thread+0x252/0x390
Nov 18 18:37:35.763861 discernment.aesgi.com kernel:  ?
__pfx_worker_thread+0x10/0x10
Nov 18 18:37:35.763871 discernment.aesgi.com kernel:  kthread+0xcf/0x100
Nov 18 18:37:35.763881 discernment.aesgi.com kernel:  ?
__pfx_kthread+0x10/0x10
Nov 18 18:37:35.763892 discernment.aesgi.com kernel:
 ret_from_fork+0x31/0x50
Nov 18 18:37:35.763906 discernment.aesgi.com kernel:  ?
__pfx_kthread+0x10/0x10
Nov 18 18:37:35.763914 discernment.aesgi.com kernel:
 ret_from_fork_asm+0x1a/0x30
Nov 18 18:37:35.763921 discernment.aesgi.com kernel:  </TASK>
Nov 18 18:37:35.763929 discernment.aesgi.com kernel: ---[ end trace
0000000000000000 ]---

--000000000000a0ed7106273c6e5c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Nov 18 18:37:33.973691 <a href=3D"http://discernment.aesgi=
.com">discernment.aesgi.com</a> kernel: warning: `QSampleCache::L&#39; uses=
 wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80=
211<br>Nov 18 18:37:35.761857 <a href=3D"http://discernment.aesgi.com">disc=
ernment.aesgi.com</a> kernel: ------------[ cut here ]------------<br>Nov 1=
8 18:37:35.761928 <a href=3D"http://discernment.aesgi.com">discernment.aesg=
i.com</a> kernel: WARNING: CPU: 10 PID: 11 at drivers/gpu/drm/amd/amdgpu/..=
/display/dc/dce/dmub_psr.c:223 dmub_psr_enable+0xfa/0x110 [amdgpu]<br>Nov 1=
8 18:37:35.761940 <a href=3D"http://discernment.aesgi.com">discernment.aesg=
i.com</a> kernel: Modules linked in: snd_seq_dummy snd_hrtimer rfcomm nft_m=
asq nft_ct nft_reject_ipv4 nf_reject_ipv4 nft_reject nft_chain_nat nf_nat n=
f_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_table&gt;<br>Nov 18 18:37:35.7=
61991 <a href=3D"http://discernment.aesgi.com">discernment.aesgi.com</a> ke=
rnel: =C2=A0videobuf2_v4l2 btintel videobuf2_common btbcm snd_seq_device li=
barc4 snd_pcm dell_smbios btmtk videodev spd5118 snd_timer snd_pci_acp5x dc=
dbas bluetooth cfg80211 r8169 mc rapl dell_&gt;<br>Nov 18 18:37:35.762015 <=
a href=3D"http://discernment.aesgi.com">discernment.aesgi.com</a> kernel: C=
PU: 10 UID: 0 PID: 11 Comm: kworker/u128:0 Not tainted 6.12.0-RX7900M #1<br=
>Nov 18 18:37:35.762024 <a href=3D"http://discernment.aesgi.com">discernmen=
t.aesgi.com</a> kernel: Hardware name: Alienware Alienware m18 R1 AMD/049YP=
9, BIOS 1.15.0 09/09/2024<br>Nov 18 18:37:35.762038 <a href=3D"http://disce=
rnment.aesgi.com">discernment.aesgi.com</a> kernel: Workqueue: dm_vblank_co=
ntrol_workqueue amdgpu_dm_crtc_vblank_control_worker [amdgpu]<br>Nov 18 18:=
37:35.762047 <a href=3D"http://discernment.aesgi.com">discernment.aesgi.com=
</a> kernel: RIP: 0010:dmub_psr_enable+0xfa/0x110 [amdgpu]<br>Nov 18 18:37:=
35.762056 <a href=3D"http://discernment.aesgi.com">discernment.aesgi.com</a=
> kernel: Code: d1 81 fb e8 03 00 00 74 21 48 8b 44 24 48 65 48 2b 04 25 28=
 00 00 00 75 15 48 83 c4 50 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc &lt;0f&g=
t; 0b eb db e8 4d 39 27 ee 66 66 2e 0f 1f 84 00 &gt;<br>Nov 18 18:37:35.762=
065 <a href=3D"http://discernment.aesgi.com">discernment.aesgi.com</a> kern=
el: RSP: 0018:ffffad0dc018fd38 EFLAGS: 00010246<br>Nov 18 18:37:35.762074 <=
a href=3D"http://discernment.aesgi.com">discernment.aesgi.com</a> kernel: R=
AX: 0000001cb9fdfc52 RBX: 00000000000003e9 RCX: 000000000000000a<br>Nov 18 =
18:37:35.762082 <a href=3D"http://discernment.aesgi.com">discernment.aesgi.=
com</a> kernel: RDX: 00000000000001f4 RSI: 000000000000004e RDI: 0000001cb9=
fdfa5e<br>Nov 18 18:37:35.762090 <a href=3D"http://discernment.aesgi.com">d=
iscernment.aesgi.com</a> kernel: RBP: 0000000000000000 R08: ffff9ee0128a6a0=
0 R09: 0000000000001d00<br>Nov 18 18:37:35.762098 <a href=3D"http://discern=
ment.aesgi.com">discernment.aesgi.com</a> kernel: R10: ffffad0e00af3500 R11=
: 000000000000001c R12: ffff9ee00cef9c90<br>Nov 18 18:37:35.762105 <a href=
=3D"http://discernment.aesgi.com">discernment.aesgi.com</a> kernel: R13: 00=
00000000000000 R14: ffffad0dc018fd3c R15: ffffad0dc018fe1c<br>Nov 18 18:37:=
35.762114 <a href=3D"http://discernment.aesgi.com">discernment.aesgi.com</a=
> kernel: FS: =C2=A00000000000000000(0000) GS:ffff9eeebd300000(0000) knlGS:=
0000000000000000<br>Nov 18 18:37:35.762121 <a href=3D"http://discernment.ae=
sgi.com">discernment.aesgi.com</a> kernel: CS: =C2=A00010 DS: 0000 ES: 0000=
 CR0: 0000000080050033<br>Nov 18 18:37:35.762129 <a href=3D"http://discernm=
ent.aesgi.com">discernment.aesgi.com</a> kernel: CR2: 00007f0f41031b28 CR3:=
 0000000abb42a000 CR4: 0000000000f50ef0<br>Nov 18 18:37:35.762140 <a href=
=3D"http://discernment.aesgi.com">discernment.aesgi.com</a> kernel: PKRU: 5=
5555554<br>Nov 18 18:37:35.762147 <a href=3D"http://discernment.aesgi.com">=
discernment.aesgi.com</a> kernel: Call Trace:<br>Nov 18 18:37:35.762155 <a =
href=3D"http://discernment.aesgi.com">discernment.aesgi.com</a> kernel: =C2=
=A0&lt;TASK&gt;<br>Nov 18 18:37:35.762791 <a href=3D"http://discernment.aes=
gi.com">discernment.aesgi.com</a> kernel: =C2=A0? dmub_psr_enable+0xfa/0x11=
0 [amdgpu]<br>Nov 18 18:37:35.762811 <a href=3D"http://discernment.aesgi.co=
m">discernment.aesgi.com</a> kernel: =C2=A0? __warn.cold+0x93/0xfa<br>Nov 1=
8 18:37:35.762818 <a href=3D"http://discernment.aesgi.com">discernment.aesg=
i.com</a> kernel: =C2=A0? dmub_psr_enable+0xfa/0x110 [amdgpu]<br>Nov 18 18:=
37:35.762823 <a href=3D"http://discernment.aesgi.com">discernment.aesgi.com=
</a> kernel: =C2=A0? report_bug+0xff/0x140<br>Nov 18 18:37:35.762830 <a hre=
f=3D"http://discernment.aesgi.com">discernment.aesgi.com</a> kernel: =C2=A0=
? handle_bug+0x58/0x90<br>Nov 18 18:37:35.762835 <a href=3D"http://discernm=
ent.aesgi.com">discernment.aesgi.com</a> kernel: =C2=A0? exc_invalid_op+0x1=
7/0x70<br>Nov 18 18:37:35.762840 <a href=3D"http://discernment.aesgi.com">d=
iscernment.aesgi.com</a> kernel: =C2=A0? asm_exc_invalid_op+0x1a/0x20<br>No=
v 18 18:37:35.762847 <a href=3D"http://discernment.aesgi.com">discernment.a=
esgi.com</a> kernel: =C2=A0? dmub_psr_enable+0xfa/0x110 [amdgpu]<br>Nov 18 =
18:37:35.762852 <a href=3D"http://discernment.aesgi.com">discernment.aesgi.=
com</a> kernel: =C2=A0? dmub_psr_enable+0xaf/0x110 [amdgpu]<br>Nov 18 18:37=
:35.762858 <a href=3D"http://discernment.aesgi.com">discernment.aesgi.com</=
a> kernel: =C2=A0edp_set_psr_allow_active+0x27d/0x3b0 [amdgpu]<br>Nov 18 18=
:37:35.763760 <a href=3D"http://discernment.aesgi.com">discernment.aesgi.co=
m</a> kernel: =C2=A0amdgpu_dm_psr_disable+0x5b/0x80 [amdgpu]<br>Nov 18 18:3=
7:35.763807 <a href=3D"http://discernment.aesgi.com">discernment.aesgi.com<=
/a> kernel: =C2=A0amdgpu_dm_crtc_vblank_control_worker+0x257/0x260 [amdgpu]=
<br>Nov 18 18:37:35.763838 <a href=3D"http://discernment.aesgi.com">discern=
ment.aesgi.com</a> kernel: =C2=A0process_one_work+0x178/0x330<br>Nov 18 18:=
37:35.763850 <a href=3D"http://discernment.aesgi.com">discernment.aesgi.com=
</a> kernel: =C2=A0worker_thread+0x252/0x390<br>Nov 18 18:37:35.763861 <a h=
ref=3D"http://discernment.aesgi.com">discernment.aesgi.com</a> kernel: =C2=
=A0? __pfx_worker_thread+0x10/0x10<br>Nov 18 18:37:35.763871 <a href=3D"htt=
p://discernment.aesgi.com">discernment.aesgi.com</a> kernel: =C2=A0kthread+=
0xcf/0x100<br>Nov 18 18:37:35.763881 <a href=3D"http://discernment.aesgi.co=
m">discernment.aesgi.com</a> kernel: =C2=A0? __pfx_kthread+0x10/0x10<br>Nov=
 18 18:37:35.763892 <a href=3D"http://discernment.aesgi.com">discernment.ae=
sgi.com</a> kernel: =C2=A0ret_from_fork+0x31/0x50<br>Nov 18 18:37:35.763906=
 <a href=3D"http://discernment.aesgi.com">discernment.aesgi.com</a> kernel:=
 =C2=A0? __pfx_kthread+0x10/0x10<br>Nov 18 18:37:35.763914 <a href=3D"http:=
//discernment.aesgi.com">discernment.aesgi.com</a> kernel: =C2=A0ret_from_f=
ork_asm+0x1a/0x30<br>Nov 18 18:37:35.763921 <a href=3D"http://discernment.a=
esgi.com">discernment.aesgi.com</a> kernel: =C2=A0&lt;/TASK&gt;<br>Nov 18 1=
8:37:35.763929 <a href=3D"http://discernment.aesgi.com">discernment.aesgi.c=
om</a> kernel: ---[ end trace 0000000000000000 ]---<br></div>

--000000000000a0ed7106273c6e5c--
