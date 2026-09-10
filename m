Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCBBC79FB9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 07:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F81810F330;
	Thu, 10 Sep 2026 07:43:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="m2w45OZX";
	dkim-atps=neutral
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AB4D10F330
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 07:43:52 +0000 (UTC)
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
 by smtp4-g21.free.fr (Postfix) with ESMTP id 6148619F5BA;
 Thu, 10 Sep 2026 09:43:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1789026230;
 bh=9hYuvvJNq7pgkthvvtcJtrd4H7DN61zhRHqZ7Y9RLnQ=;
 h=Date:From:To:Cc:In-Reply-To:Subject:From;
 b=m2w45OZXb+HQZOFxfHc8SG/Tvdl5NEdBx/qQas+BfJiB/9newQFsEJef4HlUg468n
 xvPzr6bl5CBmdjSZ0hvkZEMOq1qZp0J5ze7Vi9rAkZXu+Ao1VsrA9giF5CMOeAbmEe
 PWNuiorNMmC6JGLqgR91ILgjqyBc2SdRF0I0s/HhZcUxu0097tBQavmlKfrcNRsIDQ
 AIj0GLycoyONyj3s/y35+DPMI/S+lWwmkUEecAGsrMGewey4VjlsX3aGuW+7BuDJsp
 Tw+uXJaFxHrsTi10DT9hfFtb7htOxmdRqIAyKi14w4oADPG0FLpoEEZ1sfjJnNgE0b
 oKRQhFgPvto6Q==
Date: Thu, 10 Sep 2026 09:43:50 +0200 (CEST)
From: Yann Dirson <ydirson@free.fr>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Message-ID: <1489315603.1903976133.1789026230363.JavaMail.root@zimbra39-e7.priv.proxad.net>
In-Reply-To: <1412982671.-1692670348.1778698381152.JavaMail.root@zimbra39-e7.priv.proxad.net>
Subject: Re: Need help to dig into X11 display freezing (Renoir, Xen/QubesOS)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [88.161.245.20]
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

And here is another piece of info I think is significant: that's the
first time, but yesterday I actually experienced the issue live, as I
was actively using the machine, as opposed to all previous occurrences
that happened with screen locked.

Like last times, X11 frozen, I can switch to text consoles, which get
flooded by the "vblank wait timed out on crtc 0" oopses:

Sep 06 16:03:17 dom0 kernel: Linux version 7.0.6-1.qubes.fc37.x86_64 (mockb=
uild@0e19319cf3934758b742a72ea248f6bd) (gcc (GCC) 12.3.1 20230508 (Red Hat =
12.3.1-1), GNU ld version 2.38-27.fc37) #1 SMP PREEMPT_DYNAMIC Wed May 13 1=
4:36:07 GMT 2026
...
Sep 09 19:14:37 dom0 kernel: ------------[ cut here ]------------
Sep 09 19:14:37 dom0 kernel: amdgpu 0000:07:00.0: [drm] vblank wait timed o=
ut on crtc 0
Sep 09 19:14:37 dom0 kernel: WARNING: drivers/gpu/drm/drm_vblank.c:1320 at =
drm_crtc_wait_one_vblank+0x180/0x1f0, CPU#6: kworker/6:1/38181
Sep 09 19:14:37 dom0 kernel: Modules linked in: snd_seq_dummy snd_hrtimer v=
fat fat snd_sof_amd_acp70 snd_sof_amd_acp63 snd_sof_amd_vangogh snd_sof_amd=
_rembrandt snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci snd_sof_xtensa_ds=
p snd_sof snd_sof_utils snd_pci_ps snd_soc_acpi_amd_match snd_soc_acpi_amd_=
sdca_quirks snd_hda_codec_alc269 snd_hda_codec_realtek_lib snd_amd_sdw_acpi=
 soundwire_amd soundwire_generic_allocation snd_hda_scodec_component snd_hd=
a_codec_generic soundwire_bus snd_hda_codec_atihdmi snd_hda_codec_hdmi snd_=
soc_sdca snd_hda_intel snd_soc_core snd_hda_codec snd_compress snd_hda_core=
 ac97_bus snd_intel_dspcfg snd_pcm_dmaengine snd_intel_sdw_acpi snd_hwdep s=
nd_rpl_pci_acp6x snd_acp_pci snd_seq snd_amd_acpi_mach snd_acp_legacy_commo=
n snd_pci_acp6x snd_seq_device snd_pci_acp5x snd_pcm iwlwifi snd_rn_pci_acp=
3x snd_timer snd_acp_config r8169 snd snd_soc_acpi intel_rapl_msr amd_atl e=
e1004 cfg80211 gpio_keys msi_ec i2c_piix4 soundcore snd_pci_acp3x msi_wmi r=
ealtek intel_rapl_common k10temp rfkill i2c_smbus soc_button_array
Sep 09 19:14:37 dom0 kernel:  sparse_keymap joydev pcspkr loop fuse xenfs d=
m_thin_pool dm_persistent_data dm_bio_prison dm_crypt amdgpu amdxcp i2c_alg=
o_bit drm_ttm_helper ttm drm_exec drm_panel_backlight_quirks gpu_sched nvme=
 drm_suballoc_helper xhci_pci drm_buddy serio_raw ghash_clmulni_intel xhci_=
hcd nvme_core drm_display_helper nvme_keyring cec nvme_auth sp5100_tco vide=
o hkdf wmi hid_multitouch i2c_hid_acpi i2c_hid xen_acpi_processor xen_privc=
md xen_pciback xen_blkback xen_gntalloc xen_gntdev xen_evtchn scsi_dh_rdac =
scsi_dh_emc scsi_dh_alua uinput dm_multipath
Sep 09 19:14:37 dom0 kernel: CPU: 6 UID: 0 PID: 38181 Comm: kworker/6:1 Not=
 tainted 7.0.6-1.qubes.fc37.x86_64 #1 PREEMPT(full)=20
Sep 09 19:14:37 dom0 kernel: Hardware name: Micro-Star International Co., L=
td. Bravo 17 A4DDK/MS-17FK, BIOS E17FKAMS.117 10/29/2020
Sep 09 19:14:37 dom0 kernel: Workqueue: events drm_fb_helper_damage_work
Sep 09 19:14:37 dom0 kernel: RIP: e030:drm_crtc_wait_one_vblank+0x186/0x1f0
Sep 09 19:14:37 dom0 kernel: Code: ff ff ff 48 85 db 74 7c 48 8b 7b 08 48 8=
b 6f 50 48 85 ed 74 6a e8 0a fe 02 00 48 89 c6 48 8d 3d b0 ec 76 01 44 89 e=
1 48 89 ea <67> 48 0f b9 3a 44 89 e6 48 89 df 41 bd 92 ff ff ff e8 14 fd ff=
 ff
Sep 09 19:14:37 dom0 kernel: RSP: e02b:ffffc9005560bda8 EFLAGS: 00010286
Sep 09 19:14:37 dom0 kernel: RAX: ffffffffc177706b RBX: ffff88811b300010 RC=
X: 0000000000000000
Sep 09 19:14:37 dom0 kernel: RDX: ffff888101920530 RSI: ffffffffc177706b RD=
I: ffffffff828f9d20
Sep 09 19:14:37 dom0 kernel: RBP: ffff888101920530 R08: 0000000000000000 R0=
9: 0000000000000001
Sep 09 19:14:37 dom0 kernel: R10: 0000000000007ff0 R11: ffff88815171e400 R1=
2: 0000000000000000
Sep 09 19:14:37 dom0 kernel: R13: 0000000000000000 R14: ffff888115e55030 R1=
5: 000000000252565a
Sep 09 19:14:37 dom0 kernel: FS:  0000000000000000(0000) GS:ffff8881ce18800=
0(0000) knlGS:0000000000000000
Sep 09 19:14:37 dom0 kernel: CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050=
033
Sep 09 19:14:37 dom0 kernel: CR2: 00007b0c1e5bc008 CR3: 000000010d727000 CR=
4: 0000000000050660
Sep 09 19:14:37 dom0 kernel: Call Trace:
Sep 09 19:14:37 dom0 kernel:  <TASK>
Sep 09 19:14:37 dom0 kernel:  ? __pfx_autoremove_wake_function+0x10/0x10
Sep 09 19:14:37 dom0 kernel:  drm_client_modeset_wait_for_vblank+0x5b/0x70
Sep 09 19:14:37 dom0 kernel:  drm_fb_helper_damage_work+0x7e/0x190
Sep 09 19:14:37 dom0 kernel:  process_one_work+0x1a6/0x410
Sep 09 19:14:37 dom0 kernel:  worker_thread+0x1af/0x320
Sep 09 19:14:37 dom0 kernel:  ? __pfx_worker_thread+0x10/0x10
Sep 09 19:14:37 dom0 kernel:  kthread+0xe3/0x120
Sep 09 19:14:37 dom0 kernel:  ? __pfx_kthread+0x10/0x10
Sep 09 19:14:37 dom0 kernel:  ret_from_fork+0x1be/0x250
Sep 09 19:14:37 dom0 kernel:  ? __pfx_kthread+0x10/0x10
Sep 09 19:14:37 dom0 kernel:  ret_from_fork_asm+0x1a/0x30
Sep 09 19:14:37 dom0 kernel:  </TASK>
Sep 09 19:14:37 dom0 kernel: ---[ end trace 0000000000000000 ]---


----- Mail original -----
> De: "Yann Dirson" <ydirson@free.fr>
> =C3=80: "Alex Deucher" <alexdeucher@gmail.com>
> Cc: "amd-gfx list" <amd-gfx@lists.freedesktop.org>
> Envoy=C3=A9: Mercredi 13 Mai 2026 20:53:01
> Objet: Re: Need help to dig into X11 display freezing (Renoir, Xen/QubesO=
S)
>=20
> Hello there,
>=20
> > De: "Yann Dirson" <ydirson@free.fr>
> > =C3=80: "Alex Deucher" <alexdeucher@gmail.com>
> > Cc: "amd-gfx list" <amd-gfx@lists.freedesktop.org>
> > Envoy=C3=A9: Mardi 29 Juillet 2025 11:49:55
> > Objet: Re: Need help to dig into X11 display freezing (Renoir,
> > Xen/QubesOS)
> >=20
> > > De: "Alex Deucher" <alexdeucher@gmail.com>
> > > =C3=80: "Yann Dirson" <ydirson@free.fr>
> > > Cc: "amd-gfx list" <amd-gfx@lists.freedesktop.org>
> > > Envoy=C3=A9: Lundi 28 Juillet 2025 19:20:13
> > > Objet: Re: Need help to dig into X11 display freezing (Renoir,
> > > Xen/QubesOS)
> > >=20
> > > On Sun, Jul 20, 2025 at 10:39=E2=80=AFAM Yann Dirson <ydirson@free.fr=
>
> > > wrote:
> > > >
> > > > Hello there,
> > > >
> > > > For a few months I've been experiencing occasional freezes of
> > > > the
> > > > X11 display
> > > > on my QubesOS RENOIR laptop.  The setup is pretty much standard
> > > > for
> > > > QubesOS,
> > > > with both GPUs attached to dom0 and XFCE running there (and the
> > > > dGPU being
> > > > mostly not used).  Kernel is QubesOS' kernel-latest-6.15.4.
> > > >
> > > > Those freezes most often occur while the screen is blanked
> > > > by xscreensaver (suspend options fully deactivated here, as
> > > > suspend
> > > > is broken
> > > > on this platform): in this case moving the mouse does not get
> > > > the
> > > > unlock banner
> > > > displayed, the screen stays black... except the mouse pointer
> > > > is
> > > > visible.  I can
> > > > also switch to other virtual consoles and interact with the
> > > > system,
> > > > but was
> > > > never able to collect any evidence of something wrong being
> > > > detected.
> > > >
> > > > Occasionally it also happens (like yesterday) while I'm
> > > > working,
> > > > and the X11
> > > > display just seems frozen, no clue if the input devices trigger
> > > > anything in
> > > > there.
> > > >
> > > > I guess something goes wrong but gets undetected by the driver.
> > > >  Any suggestion
> > > > as to extra logging/debug features to enable?
> > >=20
> > > Is this specific to QubesOS or a general problem even on bare
> > > metal?
> >=20
> > Actually this is my main machine so QubesOS is running most of the
> > time.
> > I'm only booting bare metal on this box for targeted tests, and
> > never use it long enough then to see the problem trigger.
>=20
> There are some possibly good news about this issue: while it has not
> hit me that much for the start of the year, it has started to occur
> more often recently, and there is a recurring oops reproduced below,
> happening every second when X11 stays black.  There are a few
> variations
> between occurrences, every few seconds it is another kworker on a
> different
> core, but "vblank wait timed out on crtc 0" is a constant.  The first
> occurrence happens when I try to wake the screensaver.
>=20
> Does that give any idea to dig further?
>=20
>=20
> (from kernel 6.19.14-1.qubes.fc37.x86_64)
>=20
> May 13 18:44:17 dom0 kernel: ------------[ cut here ]------------
> May 13 18:44:17 dom0 kernel: amdgpu 0000:07:00.0: [drm] vblank wait
> timed out on crtc 0
> May 13 18:44:17 dom0 kernel: WARNING:
> drivers/gpu/drm/drm_vblank.c:1318 at
> drm_wait_one_vblank+0x179/0x230, CPU#3: kworker/3:1/106
> May 13 18:44:17 dom0 kernel: Modules linked in: snd_seq_dummy
> snd_hrtimer vfat fat snd_sof_amd_acp70 snd_sof_amd_acp63
> snd_sof_amd_vangogh snd_sof_amd_rembrandt snd_sof_amd_renoir
> snd_sof_a>
> May 13 18:44:17 dom0 kernel:  xenfs dm_thin_pool dm_persistent_data
> dm_bio_prison dm_crypt amdgpu amdxcp i2c_algo_bit drm_ttm_helper ttm
> drm_exec drm_panel_backlight_quirks gpu_sched nvme d>
> May 13 18:44:17 dom0 kernel: CPU: 3 UID: 0 PID: 106 Comm: kworker/3:1
> Not tainted 6.19.14-1.qubes.fc37.x86_64 #1 PREEMPT(full)
> May 13 18:44:17 dom0 kernel: Hardware name: Micro-Star International
> Co., Ltd. Bravo 17 A4DDK/MS-17FK, BIOS E17FKAMS.117 10/29/2020
> May 13 18:44:17 dom0 kernel: Workqueue: events
> drm_fb_helper_damage_work
> May 13 18:44:17 dom0 kernel: RIP:
> e030:drm_wait_one_vblank+0x17e/0x230
> May 13 18:44:17 dom0 kernel: Code: 84 c5 00 00 00 48 8b 7b 08 4c 8b
> 67 50 4d 85 e4 0f 84 ac 00 00 00 e8 61 00 03 00 48 89 c6 48 8d 3d f7
> bf 76 01 89 e9 4c 89 e2 <67> 48 0f b9 3a e9 e5 fe ff>
> May 13 18:44:17 dom0 kernel: RSP: e02b:ffffc9004060fda0 EFLAGS:
> 00010286
> May 13 18:44:17 dom0 kernel: RAX: ffffffffc16fb03b RBX:
> ffff88811ba00010 RCX: 0000000000000000
> May 13 18:44:17 dom0 kernel: RDX: ffff8881017863f0 RSI:
> ffffffffc16fb03b RDI: ffffffff828c7f60
> May 13 18:44:17 dom0 kernel: RBP: 0000000000000000 R08:
> 0000000000000000 R09: 0000000000000001
> May 13 18:44:17 dom0 kernel: R10: 0000000000007ff0 R11:
> ffff88815579e400 R12: ffff8881017863f0
> May 13 18:44:17 dom0 kernel: R13: 00000000004bc778 R14:
> ffff888101b1f830 R15: ffff8881030a29c0
> May 13 18:44:17 dom0 kernel: FS:  0000000000000000(0000)
> GS:ffff8881d2257000(0000) knlGS:0000000000000000
> May 13 18:44:17 dom0 kernel: CS:  e030 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> May 13 18:44:17 dom0 kernel: CR2: 000059ecfa9f3640 CR3:
> 0000000146bc5000 CR4: 0000000000050660
> May 13 18:44:17 dom0 kernel: Call Trace:
> May 13 18:44:17 dom0 kernel:  <TASK>
> May 13 18:44:17 dom0 kernel:  ?
> __pfx_autoremove_wake_function+0x10/0x10
> May 13 18:44:17 dom0 kernel:
>  drm_client_modeset_wait_for_vblank+0x5b/0x70
> May 13 18:44:17 dom0 kernel:  drm_fb_helper_damage_work+0x7e/0x190
> May 13 18:44:17 dom0 kernel:  process_one_work+0x19b/0x3c0
> May 13 18:44:17 dom0 kernel:  worker_thread+0x196/0x300
> May 13 18:44:17 dom0 kernel:  ? __pfx_worker_thread+0x10/0x10
> May 13 18:44:17 dom0 kernel:  kthread+0xfe/0x240
> May 13 18:44:17 dom0 kernel:  ? __pfx_kthread+0x10/0x10
> May 13 18:44:17 dom0 kernel:  ? __pfx_kthread+0x10/0x10
> May 13 18:44:17 dom0 kernel:  ret_from_fork+0x14a/0x190
> May 13 18:44:17 dom0 kernel:  ? __pfx_kthread+0x10/0x10
> May 13 18:44:17 dom0 kernel:  ret_from_fork_asm+0x1a/0x30
> May 13 18:44:17 dom0 kernel:  </TASK>
> May 13 18:44:17 dom0 kernel: ---[ end trace 0000000000000000 ]---
>=20
