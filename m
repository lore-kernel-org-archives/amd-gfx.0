Return-Path: <SRS0=Rlnb=AT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C900AC433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 17:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3202065F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 17:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnyTRbp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3202065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D9696E8FC;
	Wed,  8 Jul 2020 17:15:35 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50C056E8FC
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2020 17:15:34 +0000 (UTC)
Received: by mail-ej1-x643.google.com with SMTP id lx13so32703755ejb.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jul 2020 10:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=XHHYFyxVdadFJA72IEAc4CqMA2XIjnzFBZNrS3tRa+M=;
 b=YnyTRbp2GFe/k+an7vWDuT0lDplx/lcub1godeEcGZ9K9H1RXx0QQvxxD3OXoRbT6K
 LW62SifWwwDLes0/VLd0Nh1Q6lvdX98HS+40KqND1dXHyz9I3gG4f08G2NKmvkMwQy6f
 QfIDKJNfDhc7LDGBGlf5d3qUSSE9+52ch+q3ofQbwUzsnD7vGVBQGVlh/JcA94DunUjY
 VqpKlEJryV8Kx8ek58Da3qWk+9aa/lj7+NOWqh1oyv9DA6TbujLksZp1rbOilasR/iO+
 7T3RPBvqe/h0psLysTrkZEG2BbZrIJ7CJrQOBQEO/xDgr9R8pHF3SKy+cVVObXRthYr5
 9LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XHHYFyxVdadFJA72IEAc4CqMA2XIjnzFBZNrS3tRa+M=;
 b=rxigu1GZ+0w0Nd0MJMhwusZ1iFtVGLdwdUYrxK9h2r9hc8XJ/+UGnNHKocfHd1pa6q
 TFlndK9J7e1TbLY3xFKWhftHBwm4R352SX8w9A/U0cy0kM65BfTZZQ7zpkPTrxVyEeFS
 K8XMTBr69e3rtum8KsXppj1dMu3Xg9x7B7OC8SvAxP2mGFBD5e8EmiV/0QrbzdStDT+W
 ZbJ6ct4xdWySkHIfjSUDv2P14mwiXRhrmUzEmjM/FdwSafVrdXaIDbrihP2jTQTEOD7h
 fX0XxFOj0/6mTQ6HfQnjSojR+YC6z4MhzhX9WtpzhxsKz+BpFK3wRdjWfJ3PEL0GoaYQ
 E+rQ==
X-Gm-Message-State: AOAM533g58YUADYvU6OGKY+ONIIN3VGQDwEdHV5X3Vzf6NYMTpykbovC
 jTp8KbGnXwPXcnvbGQIu8j3sXWJIgFU=
X-Google-Smtp-Source: ABdhPJyRo5Sgz2eWIUSjQ+MZufe3lV0jANH8gyMA9aW6sG1oyh7804DxFSIMrk8fxo0OWusEY8aj5w==
X-Received: by 2002:a17:906:a058:: with SMTP id
 bg24mr54472874ejb.370.1594228532688; 
 Wed, 08 Jul 2020 10:15:32 -0700 (PDT)
Received: from saturn.localnet ([41.182.130.16])
 by smtp.gmail.com with ESMTPSA id y22sm108477ejf.108.2020.07.08.10.15.31
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 10:15:32 -0700 (PDT)
From: rigo.reddig@gmail.com
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: Linux 5.7.7 complete system freeze
Date: Wed, 08 Jul 2020 19:15:30 +0200
Message-ID: <2050017.C8eFkqqaof@saturn>
In-Reply-To: <3564679.7nI7lTb4kJ@saturn>
References: <3564679.7nI7lTb4kJ@saturn>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Non HTML email since previous was HTML formatted and likely broken.


On Wednesday, 08 July 2020 19:08:49 CAT you wrote:

I get complete and total kernel freezes that result in an entirely 
unresponsive system. This issue as driven me entirely insane since it happens 
at random. It has cost me lost work on my machine and I haven't the energy to 
further troubleshoot, since it took me ages to get just this kernel dump via 
netconsole (which didn't always print before dying).
 
System is a 1700X with 2X GFX 803 (RX580)
 
[ 2203.126193] general protection fault, probably for non-canonical address 
0x93e3cc5d552d69c3: 0000 [#1] PREEMPT SMP NOPTI
[ 2203.126218] CPU: 14 PID: 266125 Comm: kworker/u64:5 Tainted: P           OE     
5.7.6-arch1-1 #1
[ 2203.126223] Hardware name: System manufacturer System Product Name/ROG 
CROSSHAIR VII HERO (WI-FI), BIOS 3004 12/16/2019
[ 2203.126240] Workqueue: events_unbound commit_work [drm_kms_helper]
[ 2203.126339] RIP: 0010:amdgpu_dm_atomic_commit_tail+0x2aa/0x2310 [amdgpu]
[ 2203.126346] Code: 4f 08 8b 81 e0 02 00 00 41 83 c5 01 44 39 e8 0f 87 46 ff ff 
ff 48 83 bd f0 fc ff ff 00 0f 84 03 01 00 00 48 8b bd f0 fc ff ff <80> bf b0 01 00 
00 01 0f 86 ac 00 00 00 48 b9 00 00 00 00 01 00 00
[ 2203.126351] RSP: 0018:ffffbae0e0a6faf8 EFLAGS: 00010286
[ 2203.126355] RAX: 0000000000000006 RBX: ffff9bb5508dd800 RCX: ffff9bba1affd000
[ 2203.126359] RDX: ffff9bb8f443c200 RSI: ffffffffc081f1e0 RDI: 93e3cc5d552d69c3
[ 2203.126361] RBP: ffffbae0e0a6fe60 R08: 0000000000000001 R09: 0000000000000001
[ 2203.126365] R10: 0000000000000018 R11: 0000000000000018 R12: 
0000000000000000
[ 2203.126367] R13: 0000000000000006 R14: ffff9bb467418000 R15: ffff9bb5521f6380
[ 2203.126371] FS:  0000000000000000(0000) GS:ffff9bba1eb80000(0000) knlGS:
0000000000000000
[ 2203.126375] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2203.126379] CR2: 00007f0402d4c8e0 CR3: 0000000812416000 CR4: 
00000000003406e0
[ 2203.126382] Call Trace:
[ 2203.126405]  commit_tail+0x94/0x130 [drm_kms_helper]
[ 2203.126415]  process_one_work+0x1da/0x3d0
[ 2203.126420]  worker_thread+0x4d/0x3e0
[ 2203.126425]  ? rescuer_thread+0x3f0/0x3f0
[ 2203.126429]  kthread+0x13e/0x160
[ 2203.126433]  ? __kthread_bind_mask+0x60/0x60
[ 2203.126438]  ret_from_fork+0x22/0x40
[ 2203.126443] Modules linked in: vhost_net vhost tap vhost_iotlb 
snd_seq_dummy snd_hrtimer snd_seq netconsole rpcsec_gss_krb5 rfcomm 
xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT xt_CT nft_counter xt_tcpudp 
nf_nat_tftp nft_masq wireguard curve25519_x86_64 libchacha20poly1305 
chacha_x86_64 poly1305_x86_64 libblake2s blake2s_x86_64 ip6_udp_tunnel 
udp_tunnel libcurve25519_generic libchacha libblake2s_generic fuse veth 
nf_conntrack_tftp nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast 
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib bridge nft_reject_inet 
nf_reject_ipv4 nf_reject_ipv6 nft_reject stp llc nft_ct nft_chain_nat nf_nat 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip6_tables nft_compat 
ip_set nf_tables nfnetlink ccm algif_aead cbc des_generic libdes ecb arc4 bnep 
algif_skcipher cmac md4 algif_hash af_alg hwmon_vid snd_hda_codec_realtek 
snd_hda_codec_generic ledtrig_audio nls_iso8859_1 nls_cp437 vfat rtwpci fat 
squashfs rtw88 edac_mce_amd kvm_amd zfs(POE) mac80211
[ 2203.126483]  btusb snd_hda_codec_hdmi kvm snd_usb_audio snd_hda_intel 
zunicode(POE) snd_intel_dspcfg btrtl zavl(POE) btbcm snd_usbmidi_lib btintel 
snd_hda_codec uvcvideo irqbypass snd_rawmidi icp(POE) snd_hda_core 
videobuf2_vmalloc bluetooth snd_seq_device videobuf2_memops snd_hwdep 
videobuf2_v4l2 snd_pcm cfg80211 videobuf2_common pcspkr sp5100_tco snd_timer 
igb videodev snd mousedev input_leds joydev i2c_piix4 libarc4 soundcore 
ecdh_generic dca mc ecc pinctrl_amd gpio_amdpt evdev eeepc_wmi mac_hid 
asus_wmi battery acpi_cpufreq sparse_keymap rfkill wmi_bmof mxm_wmi 
zcommon(POE) znvpair(POE) spl(OE) zlua(POE) usbip_host usbip_core 
pkcs8_key_parser i2c_dev zenpower(OE) sg crypto_user nfsd asus_wmi_sensors(OE) 
auth_rpcgss wmi nfs_acl lockd msr cpuid grace acpi_call(OE) sunrpc tun loop 
ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 uas usb_storage 
hid_generic usbhid hid dm_crypt dm_mod crct10dif_pclmul crc32_pclmul 
crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd cryptd
[ 2203.126534]  glue_helper ccp rng_core xhci_pci xhci_hcd radeon amdgpu 
gpu_sched i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt 
fb_sys_fops cec rc_core ttm drm agpgart
[ 2203.126553] ---[ end trace 217719b6a37a4071 ]---
[ 2203.126631] RIP: 0010:amdgpu_dm_atomic_commit_tail+0x2aa/0x2310 [amdgpu]
[ 2203.126637] Code: 4f 08 8b 81 e0 02 00 00 41 83 c5 01 44 39 e8 0f 87 46 ff ff 
ff 48 83 bd f0 fc ff ff 00 0f 84 03 01 00 00 48 8b bd f0 fc ff ff <80> bf b0 01 00 
00 01 0f 86 ac 00 00 00 48 b9 00 00 00 00 01 00 00
[ 2203.126640] RSP: 0018:ffffbae0e0a6faf8 EFLAGS: 00010286
[ 2203.126643] RAX: 0000000000000006 RBX: ffff9bb5508dd800 RCX: ffff9bba1affd000
[ 2203.126646] RDX: ffff9bb8f443c200 RSI: ffffffffc081f1e0 RDI: 93e3cc5d552d69c3
[ 2203.126649] RBP: ffffbae0e0a6fe60 R08: 0000000000000001 R09: 0000000000000001
[ 2203.126652] R10: 0000000000000018 R11: 0000000000000018 R12: 
0000000000000000
[ 2203.126654] R13: 0000000000000006 R14: ffff9bb467418000 R15: ffff9bb5521f6380
[ 2203.126658] FS:  0000000000000000(0000) GS:ffff9bba1eb80000(0000) knlGS:
0000000000000000
[ 2203.126661] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2203.126664] CR2: 00007f0402d4c8e0 CR3: 0000000812416000 CR4: 
00000000003406e0

 
Best Regards
Rigo Reddig
  



_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
