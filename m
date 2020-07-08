Return-Path: <SRS0=Rlnb=AT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E391C433E3
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 17:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 034BA207DA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 17:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vF3iwEBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034BA207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFB9B6E8FF;
	Wed,  8 Jul 2020 17:34:55 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5EA76E8FF
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2020 17:34:53 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id f2so21873515wrp.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jul 2020 10:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j8TLRe9kTiSsJGeNrTd5KGZ06iSu9HGHkfAlXFwi5ew=;
 b=vF3iwEBp3Cr+aYcydHcVA2Zl6kmDwU64r4ld2dL5s0OQzsS3hYUJ1wiBsbKFoDs/TD
 zXlw7JE5UlFbt/cEbEQ4xWOfjkggTSfR4LxEuY9DLsf57auHogLxbbEmP4WVETg4Rfob
 pWIzJbLJ+OF4g6imjNo1/9YHQByVk16XfvAirIF4O2IF6RKkG/zBmRA1UT/OY0RWY7Sz
 QL5NJOu4RvTFDA9bNdljCRBZcqI+Tcw7ZKByalv/IGDgSBao265Qa4et4IoPSm/Rgvdr
 gOMqUM2po6Dfie4CoJMOXdAV2oDU4fLK+1jbCzbX3xbuq2FWGutbqzR6FLr7F+Z161yK
 vCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j8TLRe9kTiSsJGeNrTd5KGZ06iSu9HGHkfAlXFwi5ew=;
 b=DFhkkWnvSj+pt9T3ySH9B4K3rYTC+0aaiFNQtn36ClrvALgI6ZCfIEzykAMp5yq7Q1
 ySLD+NtxbshyO3Tb4ywOsJa0kUpoloacSx9WEgLPWhGWoY31EgJ8MNW0LZAKJQWWIz5I
 cHZOTz00oxaZy0jpLSgZ95ABWNlg+rq25L7Z/ITrV3T3/Ryx4QRc/1alXNBaKckFYmtb
 YEbWjvsyi3xvlK4+aWD1aDlZYwzIa0xGF1RGS43RfjPLqkyU4CoId5KnnJjF58uXowkQ
 Us+etDKlHyO+OfW1l0a6lUk2xq1Pq+Z/BKmfArNPvXLgbbjzoF+OCp3IK402Q8uuzA6b
 fZ2w==
X-Gm-Message-State: AOAM533cU0bQruoBFrDY/3bPUD1DHul6VeVOCNd4GQdNdUE3mWUBIZRr
 Wx/sgrZCRfIHMf2+XoIEPKJTmqRaw5iwq/3FgmM=
X-Google-Smtp-Source: ABdhPJx17/Lj9BcBpcLXcFwEHp5bfXcQPbubOsczIvkHbOtMIh1WUyiC969q6k6JviesSSGkXqo0KHVD2KrNoYkL5F0=
X-Received: by 2002:adf:dd8d:: with SMTP id x13mr58442493wrl.362.1594229692417; 
 Wed, 08 Jul 2020 10:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <3564679.7nI7lTb4kJ@saturn> <2050017.C8eFkqqaof@saturn>
In-Reply-To: <2050017.C8eFkqqaof@saturn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jul 2020 13:34:41 -0400
Message-ID: <CADnq5_N8JQHePKKozV4XUV7LSOLembdr1iReBr8R6vKAZBkM5w@mail.gmail.com>
Subject: Re: Linux 5.7.7 complete system freeze
To: Rigo Reddig <rigo.reddig@gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 8, 2020 at 1:15 PM <rigo.reddig@gmail.com> wrote:
>
> Non HTML email since previous was HTML formatted and likely broken.
>
>
> On Wednesday, 08 July 2020 19:08:49 CAT you wrote:
>
> I get complete and total kernel freezes that result in an entirely
> unresponsive system. This issue as driven me entirely insane since it happens
> at random. It has cost me lost work on my machine and I haven't the energy to
> further troubleshoot, since it took me ages to get just this kernel dump via
> netconsole (which didn't always print before dying).
>
> System is a 1700X with 2X GFX 803 (RX580)

Being debugged here:
https://bugzilla.kernel.org/show_bug.cgi?id=207383
If you can bisect, that would be helpful.

Alex

>
> [ 2203.126193] general protection fault, probably for non-canonical address
> 0x93e3cc5d552d69c3: 0000 [#1] PREEMPT SMP NOPTI
> [ 2203.126218] CPU: 14 PID: 266125 Comm: kworker/u64:5 Tainted: P           OE
> 5.7.6-arch1-1 #1
> [ 2203.126223] Hardware name: System manufacturer System Product Name/ROG
> CROSSHAIR VII HERO (WI-FI), BIOS 3004 12/16/2019
> [ 2203.126240] Workqueue: events_unbound commit_work [drm_kms_helper]
> [ 2203.126339] RIP: 0010:amdgpu_dm_atomic_commit_tail+0x2aa/0x2310 [amdgpu]
> [ 2203.126346] Code: 4f 08 8b 81 e0 02 00 00 41 83 c5 01 44 39 e8 0f 87 46 ff ff
> ff 48 83 bd f0 fc ff ff 00 0f 84 03 01 00 00 48 8b bd f0 fc ff ff <80> bf b0 01 00
> 00 01 0f 86 ac 00 00 00 48 b9 00 00 00 00 01 00 00
> [ 2203.126351] RSP: 0018:ffffbae0e0a6faf8 EFLAGS: 00010286
> [ 2203.126355] RAX: 0000000000000006 RBX: ffff9bb5508dd800 RCX: ffff9bba1affd000
> [ 2203.126359] RDX: ffff9bb8f443c200 RSI: ffffffffc081f1e0 RDI: 93e3cc5d552d69c3
> [ 2203.126361] RBP: ffffbae0e0a6fe60 R08: 0000000000000001 R09: 0000000000000001
> [ 2203.126365] R10: 0000000000000018 R11: 0000000000000018 R12:
> 0000000000000000
> [ 2203.126367] R13: 0000000000000006 R14: ffff9bb467418000 R15: ffff9bb5521f6380
> [ 2203.126371] FS:  0000000000000000(0000) GS:ffff9bba1eb80000(0000) knlGS:
> 0000000000000000
> [ 2203.126375] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2203.126379] CR2: 00007f0402d4c8e0 CR3: 0000000812416000 CR4:
> 00000000003406e0
> [ 2203.126382] Call Trace:
> [ 2203.126405]  commit_tail+0x94/0x130 [drm_kms_helper]
> [ 2203.126415]  process_one_work+0x1da/0x3d0
> [ 2203.126420]  worker_thread+0x4d/0x3e0
> [ 2203.126425]  ? rescuer_thread+0x3f0/0x3f0
> [ 2203.126429]  kthread+0x13e/0x160
> [ 2203.126433]  ? __kthread_bind_mask+0x60/0x60
> [ 2203.126438]  ret_from_fork+0x22/0x40
> [ 2203.126443] Modules linked in: vhost_net vhost tap vhost_iotlb
> snd_seq_dummy snd_hrtimer snd_seq netconsole rpcsec_gss_krb5 rfcomm
> xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT xt_CT nft_counter xt_tcpudp
> nf_nat_tftp nft_masq wireguard curve25519_x86_64 libchacha20poly1305
> chacha_x86_64 poly1305_x86_64 libblake2s blake2s_x86_64 ip6_udp_tunnel
> udp_tunnel libcurve25519_generic libchacha libblake2s_generic fuse veth
> nf_conntrack_tftp nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast
> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib bridge nft_reject_inet
> nf_reject_ipv4 nf_reject_ipv6 nft_reject stp llc nft_ct nft_chain_nat nf_nat
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip6_tables nft_compat
> ip_set nf_tables nfnetlink ccm algif_aead cbc des_generic libdes ecb arc4 bnep
> algif_skcipher cmac md4 algif_hash af_alg hwmon_vid snd_hda_codec_realtek
> snd_hda_codec_generic ledtrig_audio nls_iso8859_1 nls_cp437 vfat rtwpci fat
> squashfs rtw88 edac_mce_amd kvm_amd zfs(POE) mac80211
> [ 2203.126483]  btusb snd_hda_codec_hdmi kvm snd_usb_audio snd_hda_intel
> zunicode(POE) snd_intel_dspcfg btrtl zavl(POE) btbcm snd_usbmidi_lib btintel
> snd_hda_codec uvcvideo irqbypass snd_rawmidi icp(POE) snd_hda_core
> videobuf2_vmalloc bluetooth snd_seq_device videobuf2_memops snd_hwdep
> videobuf2_v4l2 snd_pcm cfg80211 videobuf2_common pcspkr sp5100_tco snd_timer
> igb videodev snd mousedev input_leds joydev i2c_piix4 libarc4 soundcore
> ecdh_generic dca mc ecc pinctrl_amd gpio_amdpt evdev eeepc_wmi mac_hid
> asus_wmi battery acpi_cpufreq sparse_keymap rfkill wmi_bmof mxm_wmi
> zcommon(POE) znvpair(POE) spl(OE) zlua(POE) usbip_host usbip_core
> pkcs8_key_parser i2c_dev zenpower(OE) sg crypto_user nfsd asus_wmi_sensors(OE)
> auth_rpcgss wmi nfs_acl lockd msr cpuid grace acpi_call(OE) sunrpc tun loop
> ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 uas usb_storage
> hid_generic usbhid hid dm_crypt dm_mod crct10dif_pclmul crc32_pclmul
> crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd cryptd
> [ 2203.126534]  glue_helper ccp rng_core xhci_pci xhci_hcd radeon amdgpu
> gpu_sched i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt
> fb_sys_fops cec rc_core ttm drm agpgart
> [ 2203.126553] ---[ end trace 217719b6a37a4071 ]---
> [ 2203.126631] RIP: 0010:amdgpu_dm_atomic_commit_tail+0x2aa/0x2310 [amdgpu]
> [ 2203.126637] Code: 4f 08 8b 81 e0 02 00 00 41 83 c5 01 44 39 e8 0f 87 46 ff ff
> ff 48 83 bd f0 fc ff ff 00 0f 84 03 01 00 00 48 8b bd f0 fc ff ff <80> bf b0 01 00
> 00 01 0f 86 ac 00 00 00 48 b9 00 00 00 00 01 00 00
> [ 2203.126640] RSP: 0018:ffffbae0e0a6faf8 EFLAGS: 00010286
> [ 2203.126643] RAX: 0000000000000006 RBX: ffff9bb5508dd800 RCX: ffff9bba1affd000
> [ 2203.126646] RDX: ffff9bb8f443c200 RSI: ffffffffc081f1e0 RDI: 93e3cc5d552d69c3
> [ 2203.126649] RBP: ffffbae0e0a6fe60 R08: 0000000000000001 R09: 0000000000000001
> [ 2203.126652] R10: 0000000000000018 R11: 0000000000000018 R12:
> 0000000000000000
> [ 2203.126654] R13: 0000000000000006 R14: ffff9bb467418000 R15: ffff9bb5521f6380
> [ 2203.126658] FS:  0000000000000000(0000) GS:ffff9bba1eb80000(0000) knlGS:
> 0000000000000000
> [ 2203.126661] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2203.126664] CR2: 00007f0402d4c8e0 CR3: 0000000812416000 CR4:
> 00000000003406e0
>
>
> Best Regards
> Rigo Reddig
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
