Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B9EC3ABC3
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 12:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 470C510E3EF;
	Mon, 12 May 2025 12:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=nordisch.org header.i=@nordisch.org header.b="/z2RDvyI";
	dkim=pass (1024-bit key; secure) header.d=nordisch.org header.i=@nordisch.org header.b="OeoDqiho";
	dkim-atps=neutral
Received: from tengu.nordisch.org (tengu.nordisch.org [138.201.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE1A10E18F
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 12:03:22 +0000 (UTC)
Received: from [192.168.3.6] (fortress.wg.nordisch.org [192.168.3.6])
 by tengu.nordisch.org (Postfix) with ESMTPSA id 3F47375B78A;
 Mon, 12 May 2025 14:03:19 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=nordisch.org;
 s=tengu_ed25519; t=1747051399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=38Rr2DNZcxLRBB37XzWYuZzKyveMda7TtTWRdUIMEo0=;
 b=/z2RDvyInUzdxmwokLB46zf2pG58TFaHfrVNoaYq+UC7DW2wF5QCt6NyEK78k7FSkhBTX5
 nGeaM+oGzMEa8VDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nordisch.org;
 s=tengu_rsa; t=1747051399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=38Rr2DNZcxLRBB37XzWYuZzKyveMda7TtTWRdUIMEo0=;
 b=OeoDqihoYC0i5978H4xoUq2nLItE/fS9VpcDZPe5gNQu3qaJttbyqmEbEuoNmeHP+Jr3hJ
 z0gexvzUY7IDeoiD2iJzOTjuXHliP6TIgak6wH48tmWPnmk+IzsqhaoDhA6ink6BoTFpnc
 mO8hhGNbekmcsk2zLivV6vkH/K7TRC4=
Message-ID: <6023ab4f8c490594a882704fa0e1afeb076c2ad2.camel@nordisch.org>
Subject: Re: amdgpu: Reproducible soft lockups when playing games
From: Marcus =?ISO-8859-1?Q?R=FCckert?= <amd@nordisch.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, amd-gfx@lists.freedesktop.org
Date: Mon, 12 May 2025 14:03:18 +0200
In-Reply-To: <CADnq5_OfudYrLEf2OWqhaC2LWVOc_rGBs+NaizT2MfmxU=sZsA@mail.gmail.com>
References: <123e013307ad395b3e26c2dd53fb99594191dda0.camel@nordisch.org>
 <20250429130929.GCaBDPiT_CwyKmHB5o@fat_crate.local>
 <CADnq5_PBjOYV5TH5EDXBVvth1ZX6S_TcpDOKOMrbDJUEDzkTww@mail.gmail.com>
 <688457c1079a5cdbb81a0dd21e6d744e72c89101.camel@nordisch.org>
 <CADnq5_OfudYrLEf2OWqhaC2LWVOc_rGBs+NaizT2MfmxU=sZsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 12 May 2025 12:44:26 +0000
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

I had another flip_done hang. even with RADV_DEBUG that didnt result in muc=
h extra details.

The crash details are below. What I am curious about ... currently I am tes=
ting if i can also reproduce those flip_done hangs with a single monitor on=
ly

I had one browser window open with twitch, which was in the background. And=
 another browser window where i was looking something up for a friend.

I seriously wonder if the different framerates of the monitor (144Hz vs 480=
Hz) could have an affect here that could trigger the issue?
Or could this be a bug related to video in a browser? (vivaldi-stable if th=
at matters)
 =20
crash details:
[Sun May 11 02:29:37 2025] [  T30868] amdgpu 0000:03:00.0: [drm] *ERROR* [C=
RTC:85:crtc-0] flip_done timed out

nothing happened here until i logged in via ssh. issued a chvt 1 - which to=
ok 24s to do something.

[Sun May 11 02:41:10 2025] [   T1915] amdgpu 0000:03:00.0: [drm] *ERROR* fl=
ip_done timed out
[Sun May 11 02:41:10 2025] [   T1915] amdgpu 0000:03:00.0: [drm] *ERROR* [C=
RTC:85:crtc-0] commit wait timed out
[Sun May 11 02:41:20 2025] [   T1915] amdgpu 0000:03:00.0: [drm] *ERROR* fl=
ip_done timed out
[Sun May 11 02:41:20 2025] [   T1915] amdgpu 0000:03:00.0: [drm] *ERROR* [P=
LANE:82:plane-7] commit wait timed out
[Sun May 11 02:41:20 2025] [   T1915] ------------[ cut here ]------------
[Sun May 11 02:41:20 2025] [   T1915] WARNING: CPU: 28 PID: 1915 at drivers=
/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8928 amdgpu_dm_atomic_=
commit_tail+0x3c54/0x3d10 [amdgpu]
[Sun May 11 02:41:20 2025] [   T1915] Modules linked in: overlay binfmt_mis=
c nft_masq nft_chain_nat nf_nat nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nf_log_syslog nft_log nft_limit nft_ct nf_conntrack nf_defrag=
_ipv6 nf_defrag_ipv4 af_packet snd_seq_dummy snd_hrtimer snd_seq wireguard =
curve25519_x86_64 libcurve25519_generic ip6_udp_tunnel udp_tunnel cfg80211 =
ext4 mbcache jbd2 nls_iso8859_1 nls_cp437 xfs vfat fat amd_atl intel_rapl_m=
sr intel_rapl_common snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_=
usb_audio snd_intel_sdw_acpi snd_usbmidi_lib snd_hda_codec snd_ump edac_mce=
_amd snd_hda_core snd_rawmidi eeepc_wmi snd_hwdep snd_seq_device snd_pcm sp=
d5118 asus_wmi kvm_amd snd_timer platform_profile raid1 snd battery i2c_pii=
x4 sparse_keymap kvm atlantic md_mod mc cdc_acm thunderbolt gpio_amdpt joyd=
ev soundcore rfkill k10temp igc i2c_smbus irqbypass macsec pcspkr wmi_bmof =
tiny_power_button amd_3d_vcache gpio_generic button acpi_pad nvme_fabrics l=
oop fuse efi_pstore configfs ip_tables x_tables hid_generic amdgpu dm_crypt=
 essiv
[Sun May 11 02:41:20 2025] [   T1915]  authenc trusted crc16 usbhid asn1_en=
coder amdxcp tee i2c_algo_bit ahci drm_ttm_helper libahci polyval_clmulni t=
tm libata polyval_generic drm_exec sd_mod ghash_clmulni_intel gpu_sched scs=
i_dh_emc sha512_ssse3 drm_suballoc_helper scsi_dh_rdac sha256_ssse3 drm_pan=
el_backlight_quirks sha1_ssse3 scsi_dh_alua drm_buddy nvme aesni_intel sg d=
rm_display_helper xhci_pci ucsi_acpi nvme_core crypto_simd scsi_mod cec xhc=
i_hcd typec_ucsi nvme_keyring video cryptd scsi_common rc_core roles usbcor=
e ccp sp5100_tco nvme_auth wmi typec btrfs blake2b_generic xor raid6_pq dm_=
mod br_netfilter bridge stp llc nf_tables ntsync msr nfnetlink efivarfs dmi=
_sysfs
[Sun May 11 02:41:20 2025] [   T1915] CPU: 28 UID: 0 PID: 1915 Comm: system=
d-logind Not tainted 6.15.0-rc5-2.g1950b5b-default #1 PREEMPT(voluntary) op=
enSUSE Tumbleweed (unreleased)  d44620964e89a2d766559e3bdc0fcb5e11898016
[Sun May 11 02:41:20 2025] [   T1915] Hardware name: ASUS System Product Na=
me/ProArt X870E-CREATOR WIFI, BIOS 1303 04/28/2025
[Sun May 11 02:41:20 2025] [   T1915] RIP: 0010:amdgpu_dm_atomic_commit_tai=
l+0x3c54/0x3d10 [amdgpu]
[Sun May 11 02:41:20 2025] [   T1915] Code: c6 85 30 fe ff ff 00 48 89 85 4=
0 fe ff ff e9 e9 c9 ff ff 0f 0b e9 f1 f2 ff ff 0f 0b 31 f6 e9 46 c9 ff ff 0=
f 0b e9 14 ca ff ff <0f> 0b e9 f9 f2 ff ff 48 c7 85 20 fe ff ff 00 00 00 00=
 48 c7 85 f8
[Sun May 11 02:41:20 2025] [   T1915] RSP: 0018:ffffd171c26276e8 EFLAGS: 00=
010086
[Sun May 11 02:41:20 2025] [   T1915] RAX: 0000000000000001 RBX: 0000000000=
000286 RCX: ffff8e625d31f118
[Sun May 11 02:41:20 2025] [   T1915] RDX: 0000000000000001 RSI: 0000000000=
000297 RDI: ffff8e6263580178
[Sun May 11 02:41:20 2025] [   T1915] RBP: ffffd171c2627938 R08: ffffd171c2=
6275dc R09: 0000000000000000
[Sun May 11 02:41:20 2025] [   T1915] R10: ffffd171c2627640 R11: ffffd171c2=
627644 R12: 0000000000000000
[Sun May 11 02:41:20 2025] [   T1915] R13: 0000000000000001 R14: ffff8e6252=
8bc600 R15: ffff8e625d31f000
[Sun May 11 02:41:20 2025] [   T1915] FS:  00007fa05523f9c0(0000) GS:ffff8e=
71dedb0000(0000) knlGS:0000000000000000
[Sun May 11 02:41:20 2025] [   T1915] CS:  0010 DS: 0000 ES: 0000 CR0: 0000=
000080050033
[Sun May 11 02:41:20 2025] [   T1915] CR2: 00007fc0740bb000 CR3: 0000000155=
4e9000 CR4: 0000000000f50ef0
[Sun May 11 02:41:20 2025] [   T1915] PKRU: 55555554
[Sun May 11 02:41:20 2025] [   T1915] Call Trace:
[Sun May 11 02:41:20 2025] [   T1915]  <TASK>
[Sun May 11 02:41:20 2025] [   T1915]  commit_tail+0x91/0x130
[Sun May 11 02:41:20 2025] [   T1915]  drm_atomic_helper_commit+0x11a/0x140
[Sun May 11 02:41:20 2025] [   T1915]  drm_atomic_commit+0xae/0xe0
[Sun May 11 02:41:20 2025] [   T1915]  ? __pfx___drm_printfn_info+0x10/0x10
[Sun May 11 02:41:20 2025] [   T1915]  drm_client_modeset_commit_atomic+0x1=
e0/0x220
[Sun May 11 02:41:20 2025] [   T1915]  drm_client_modeset_commit_locked+0x5=
a/0x160
[Sun May 11 02:41:20 2025] [   T1915]  ? timerqueue_del+0x2e/0x50
[Sun May 11 02:41:20 2025] [   T1915]  __drm_fb_helper_restore_fbdev_mode_u=
nlocked+0x5e/0xd0
[Sun May 11 02:41:20 2025] [   T1915]  drm_fb_helper_set_par+0x30/0x40
[Sun May 11 02:41:20 2025] [   T1915]  fb_set_var+0x22e/0x410
[Sun May 11 02:41:20 2025] [   T1915]  ? update_load_avg+0x80/0x770
[Sun May 11 02:41:20 2025] [   T1915]  ? update_curr+0x1dc/0x260
[Sun May 11 02:41:20 2025] [   T1915]  ? place_entity+0x1b/0x130
[Sun May 11 02:41:20 2025] [   T1915]  ? pick_eevdf+0x15d/0x190
[Sun May 11 02:41:20 2025] [   T1915]  ? update_curr+0x35/0x260
[Sun May 11 02:41:20 2025] [   T1915]  ? update_load_avg+0x80/0x770
[Sun May 11 02:41:20 2025] [   T1915]  fbcon_blank+0x26f/0x330
[Sun May 11 02:41:20 2025] [   T1915]  do_unblank_screen+0xad/0x150
[Sun May 11 02:41:20 2025] [   T1915]  complete_change_console+0x54/0x120
[Sun May 11 02:41:20 2025] [   T1915]  vt_ioctl+0xe55/0x12e0
[Sun May 11 02:41:20 2025] [   T1915]  ? do_syscall_64+0x8e/0x830
[Sun May 11 02:41:20 2025] [   T1915]  ? __wake_up+0x44/0x60
[Sun May 11 02:41:20 2025] [   T1915]  ? evdev_do_ioctl+0x4e0/0xb50
[Sun May 11 02:41:20 2025] [   T1915]  tty_ioctl+0xe8/0x880
[Sun May 11 02:41:20 2025] [   T1915]  ? __seccomp_filter+0x37/0x4f0
[Sun May 11 02:41:20 2025] [   T1915]  __x64_sys_ioctl+0x94/0xc0
[Sun May 11 02:41:20 2025] [   T1915]  do_syscall_64+0x82/0x830
[Sun May 11 02:41:20 2025] [   T1915]  ? do_syscall_64+0x8e/0x830
[Sun May 11 02:41:20 2025] [   T1915]  entry_SYSCALL_64_after_hwframe+0x76/=
0x7e
[Sun May 11 02:41:20 2025] [   T1915] RIP: 0033:0x7fa05511916f
[Sun May 11 02:41:20 2025] [   T1915] Code: 00 48 89 44 24 18 31 c0 48 8d 4=
4 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b=
8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04=
 25 28 00 00
[Sun May 11 02:41:20 2025] [   T1915] RSP: 002b:00007ffd5df8d590 EFLAGS: 00=
000246 ORIG_RAX: 0000000000000010
[Sun May 11 02:41:20 2025] [   T1915] RAX: ffffffffffffffda RBX: 0000000000=
000021 RCX: 00007fa05511916f
[Sun May 11 02:41:20 2025] [   T1915] RDX: 0000000000000001 RSI: 0000000000=
005605 RDI: 0000000000000021
[Sun May 11 02:41:20 2025] [   T1915] RBP: 0000000000000000 R08: 00007ffd5d=
f8d580 R09: 000055a2d16e4cb0
[Sun May 11 02:41:20 2025] [   T1915] R10: 00007ffd5df8d5d0 R11: 0000000000=
000246 R12: 00007ffd5df8d670
[Sun May 11 02:41:20 2025] [   T1915] R13: 00007ffd5df8d668 R14: 000055a2d1=
6e3c70 R15: 0000000000000006
[Sun May 11 02:41:20 2025] [   T1915]  </TASK>
[Sun May 11 02:41:20 2025] [   T1915] ---[ end trace 0000000000000000 ]---

```
--=20
Always remember:
  Never accept the world as it appears to be.
    Dare to see it for what it could be.
      The world can always use more heroes.




```

