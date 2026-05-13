Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCC4CD4F3C
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 18:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD65E10E339;
	Wed, 13 May 2026 18:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="QdeiCFcj";
	dkim-atps=neutral
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFC1910E339
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 18:53:02 +0000 (UTC)
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
 by smtp4-g21.free.fr (Postfix) with ESMTP id 2E0A419F59C;
 Wed, 13 May 2026 20:53:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1778698381;
 bh=6OG2rqGVmiryZR1bvMnIJbEfnKWcb9F/cwZ4ETEoYFc=;
 h=Date:From:To:Cc:In-Reply-To:Subject:From;
 b=QdeiCFcj2Y0l6C6KcD7LlLRWiYF2rhkE1OzDSOOVXm28T46kNOaPDHEypkgIXntEc
 AJ5pYgEuphYTR7pRXiAQzj22WUD82DrSPplJubuqkNjba9hOKt3+giOiJK6RmCBapL
 /PCtpPV3lJOtNp6rWjc6GgliNq19se5qPPoqhSbWkjFGJWa7tAfWwLw8nqeq84AGho
 nVZJ0z0faQIpSk1yiWWDQjdYEbGM4JaR+Eij15SWbHp1jSi3vIYiXRGVcP8Z4IlPHU
 17tGcRerPKtupunBnFQWOqcJRyvqhZxRXX+AU6+jqVu5psu5msMdGEmOb3PU72VS6C
 jiWEolbtCEZVA==
Date: Wed, 13 May 2026 20:53:01 +0200 (CEST)
From: Yann Dirson <ydirson@free.fr>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Message-ID: <1412982671.-1692670348.1778698381152.JavaMail.root@zimbra39-e7.priv.proxad.net>
In-Reply-To: <2140760933.194259033.1753782595813.JavaMail.root@zimbra39-e7.priv.proxad.net>
Subject: Re: Need help to dig into X11 display freezing (Renoir, Xen/QubesOS)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [88.120.44.86]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
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

Hello there,

> De: "Yann Dirson" <ydirson@free.fr>
> =C3=80: "Alex Deucher" <alexdeucher@gmail.com>
> Cc: "amd-gfx list" <amd-gfx@lists.freedesktop.org>
> Envoy=C3=A9: Mardi 29 Juillet 2025 11:49:55
> Objet: Re: Need help to dig into X11 display freezing (Renoir, Xen/QubesO=
S)
>=20
> > De: "Alex Deucher" <alexdeucher@gmail.com>
> > =C3=80: "Yann Dirson" <ydirson@free.fr>
> > Cc: "amd-gfx list" <amd-gfx@lists.freedesktop.org>
> > Envoy=C3=A9: Lundi 28 Juillet 2025 19:20:13
> > Objet: Re: Need help to dig into X11 display freezing (Renoir,
> > Xen/QubesOS)
> >=20
> > On Sun, Jul 20, 2025 at 10:39=E2=80=AFAM Yann Dirson <ydirson@free.fr>
> > wrote:
> > >
> > > Hello there,
> > >
> > > For a few months I've been experiencing occasional freezes of the
> > > X11 display
> > > on my QubesOS RENOIR laptop.  The setup is pretty much standard
> > > for
> > > QubesOS,
> > > with both GPUs attached to dom0 and XFCE running there (and the
> > > dGPU being
> > > mostly not used).  Kernel is QubesOS' kernel-latest-6.15.4.
> > >
> > > Those freezes most often occur while the screen is blanked
> > > by xscreensaver (suspend options fully deactivated here, as
> > > suspend
> > > is broken
> > > on this platform): in this case moving the mouse does not get the
> > > unlock banner
> > > displayed, the screen stays black... except the mouse pointer is
> > > visible.  I can
> > > also switch to other virtual consoles and interact with the
> > > system,
> > > but was
> > > never able to collect any evidence of something wrong being
> > > detected.
> > >
> > > Occasionally it also happens (like yesterday) while I'm working,
> > > and the X11
> > > display just seems frozen, no clue if the input devices trigger
> > > anything in
> > > there.
> > >
> > > I guess something goes wrong but gets undetected by the driver.
> > >  Any suggestion
> > > as to extra logging/debug features to enable?
> >=20
> > Is this specific to QubesOS or a general problem even on bare
> > metal?
>=20
> Actually this is my main machine so QubesOS is running most of the
> time.
> I'm only booting bare metal on this box for targeted tests, and
> never use it long enough then to see the problem trigger.

There are some possibly good news about this issue: while it has not
hit me that much for the start of the year, it has started to occur
more often recently, and there is a recurring oops reproduced below,
happening every second when X11 stays black.  There are a few variations
between occurrences, every few seconds it is another kworker on a different
core, but "vblank wait timed out on crtc 0" is a constant.  The first
occurrence happens when I try to wake the screensaver.

Does that give any idea to dig further?


(from kernel 6.19.14-1.qubes.fc37.x86_64)

May 13 18:44:17 dom0 kernel: ------------[ cut here ]------------
May 13 18:44:17 dom0 kernel: amdgpu 0000:07:00.0: [drm] vblank wait timed o=
ut on crtc 0
May 13 18:44:17 dom0 kernel: WARNING: drivers/gpu/drm/drm_vblank.c:1318 at =
drm_wait_one_vblank+0x179/0x230, CPU#3: kworker/3:1/106
May 13 18:44:17 dom0 kernel: Modules linked in: snd_seq_dummy snd_hrtimer v=
fat fat snd_sof_amd_acp70 snd_sof_amd_acp63 snd_sof_amd_vangogh snd_sof_amd=
_rembrandt snd_sof_amd_renoir snd_sof_a>
May 13 18:44:17 dom0 kernel:  xenfs dm_thin_pool dm_persistent_data dm_bio_=
prison dm_crypt amdgpu amdxcp i2c_algo_bit drm_ttm_helper ttm drm_exec drm_=
panel_backlight_quirks gpu_sched nvme d>
May 13 18:44:17 dom0 kernel: CPU: 3 UID: 0 PID: 106 Comm: kworker/3:1 Not t=
ainted 6.19.14-1.qubes.fc37.x86_64 #1 PREEMPT(full)=20
May 13 18:44:17 dom0 kernel: Hardware name: Micro-Star International Co., L=
td. Bravo 17 A4DDK/MS-17FK, BIOS E17FKAMS.117 10/29/2020
May 13 18:44:17 dom0 kernel: Workqueue: events drm_fb_helper_damage_work
May 13 18:44:17 dom0 kernel: RIP: e030:drm_wait_one_vblank+0x17e/0x230
May 13 18:44:17 dom0 kernel: Code: 84 c5 00 00 00 48 8b 7b 08 4c 8b 67 50 4=
d 85 e4 0f 84 ac 00 00 00 e8 61 00 03 00 48 89 c6 48 8d 3d f7 bf 76 01 89 e=
9 4c 89 e2 <67> 48 0f b9 3a e9 e5 fe ff>
May 13 18:44:17 dom0 kernel: RSP: e02b:ffffc9004060fda0 EFLAGS: 00010286
May 13 18:44:17 dom0 kernel: RAX: ffffffffc16fb03b RBX: ffff88811ba00010 RC=
X: 0000000000000000
May 13 18:44:17 dom0 kernel: RDX: ffff8881017863f0 RSI: ffffffffc16fb03b RD=
I: ffffffff828c7f60
May 13 18:44:17 dom0 kernel: RBP: 0000000000000000 R08: 0000000000000000 R0=
9: 0000000000000001
May 13 18:44:17 dom0 kernel: R10: 0000000000007ff0 R11: ffff88815579e400 R1=
2: ffff8881017863f0
May 13 18:44:17 dom0 kernel: R13: 00000000004bc778 R14: ffff888101b1f830 R1=
5: ffff8881030a29c0
May 13 18:44:17 dom0 kernel: FS:  0000000000000000(0000) GS:ffff8881d225700=
0(0000) knlGS:0000000000000000
May 13 18:44:17 dom0 kernel: CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050=
033
May 13 18:44:17 dom0 kernel: CR2: 000059ecfa9f3640 CR3: 0000000146bc5000 CR=
4: 0000000000050660
May 13 18:44:17 dom0 kernel: Call Trace:
May 13 18:44:17 dom0 kernel:  <TASK>
May 13 18:44:17 dom0 kernel:  ? __pfx_autoremove_wake_function+0x10/0x10
May 13 18:44:17 dom0 kernel:  drm_client_modeset_wait_for_vblank+0x5b/0x70
May 13 18:44:17 dom0 kernel:  drm_fb_helper_damage_work+0x7e/0x190
May 13 18:44:17 dom0 kernel:  process_one_work+0x19b/0x3c0
May 13 18:44:17 dom0 kernel:  worker_thread+0x196/0x300
May 13 18:44:17 dom0 kernel:  ? __pfx_worker_thread+0x10/0x10
May 13 18:44:17 dom0 kernel:  kthread+0xfe/0x240
May 13 18:44:17 dom0 kernel:  ? __pfx_kthread+0x10/0x10
May 13 18:44:17 dom0 kernel:  ? __pfx_kthread+0x10/0x10
May 13 18:44:17 dom0 kernel:  ret_from_fork+0x14a/0x190
May 13 18:44:17 dom0 kernel:  ? __pfx_kthread+0x10/0x10
May 13 18:44:17 dom0 kernel:  ret_from_fork_asm+0x1a/0x30
May 13 18:44:17 dom0 kernel:  </TASK>
May 13 18:44:17 dom0 kernel: ---[ end trace 0000000000000000 ]---
