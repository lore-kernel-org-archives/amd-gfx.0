Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32967C5ED5D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 14:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02AC624656
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 14:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tcuESRwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AC624656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C43DC6E8D8;
	Thu, 27 Feb 2020 14:21:07 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E17AD6E8D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 14:21:06 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id c13so3540857wrq.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 06:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=kceibpr0mgFnHkB9H7OQejN+zde92NxNwzY3PGbvBGM=;
 b=tcuESRwJ4yPjLNuzBEwuGhHgqSEPz/vWFO+NT+e04wIRRRHJhrLvO9cf7NopJEtUCJ
 pch5cfHwRRbZefsYopE6WIU9EKWPE/UecJY+aKXSKSHz0ZPoxk4x0TMsEz7TP2Z5Gry1
 KvNTNC9qP2azHgHG/7Kbj3VelFXfBQgdcErk3DAnpiyesGOggmFuNtuXRk8VIWiQKlE7
 9KxQlwF31ZSOwFH9RswrzoSQQOzUw32FOMT0NsR3oCBVADyahpuGGJjafurwLyyZDrrn
 ZElm2nsR1sFjyf+MvxmZv8flle1bW1dzib3j2cm/tdqdaMmIV5hfIPAEICd4zgEknAru
 3dOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=kceibpr0mgFnHkB9H7OQejN+zde92NxNwzY3PGbvBGM=;
 b=BXaQHIM6+Igi6x/onCjiMj2+7KqB4gqiY0PkVGddlGVLw9TYbXx8YPiF9RVn9D6hAs
 qnJoSWQc3f6runzouoAd6aWm4bHjkMr7hzvt+LTQowV9apCs4dgF/QDAwqxWV5snKKuX
 1uOH+UPBu2b5JKDuJJgdOedXwd0yWuQnXf/Fw+FQXpdVZ5VqL04aDeyuWOLcBKvKro44
 IhflfjFNAiNW8Jx0hmBN3GubPh9F6Y7K2mX2Mm8n4XWl1MoJSQnhuL4NbzwDuHbAELJo
 5g41uTxJ31FGewAMtY3/AT5AIsSRyorR2USPFClWw95akU15iZIlyIMM9gRd3rnv3hHX
 sE+A==
X-Gm-Message-State: APjAAAWg33wXlkQsFx8FzNMwM8jHZmsWBEMHQnc1Nq3Fl6dPyX+r4QoX
 zw7ZkrTz6CPWjd9m9RU1dmI/U6p7
X-Google-Smtp-Source: APXvYqy3i6wFqZsX9sToCAipo9lQ3YzSBjtWehpXVKufQ/pkBpgsrkVkfyHXMvZKav5cCuJz7TXgcw==
X-Received: by 2002:a05:6000:110b:: with SMTP id
 z11mr5279407wrw.252.1582813265315; 
 Thu, 27 Feb 2020 06:21:05 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id a16sm8179412wrx.87.2020.02.27.06.21.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Feb 2020 06:21:04 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: release drm_device after
 amdgpu_driver_unload_kms
To: Yintian Tao <yttao@amd.com>, christian.koenig@amd.com,
 Alexander.Deucher@amd.com
References: <20200227115807.32698-1-yttao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9f4eba96-e0a1-0823-4189-1c9f6d8bd248@gmail.com>
Date: Thu, 27 Feb 2020 15:21:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200227115807.32698-1-yttao@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.02.20 um 12:58 schrieb Yintian Tao:
> If we release drm_device before amdgpu_driver_unload_kms,
> then it will raise the error below. Therefore, we need to
> place it before amdgpu_driver_unload_kms.
> [   43.055736] Memory manager not clean during takedown.
> [   43.055777] WARNING: CPU: 1 PID: 2807 at /build/linux-hwe-9KJ07q/linux-hwe-4.18.0/drivers/gpu/drm/drm_mm.c:913 drm_mm_takedown+0x24/0x30 [drm]
> [   43.055778] Modules linked in: amdgpu(OE-) amd_sched(OE) amdttm(OE) amdkcl(OE) amd_iommu_v2 drm_kms_helper drm i2c_algo_bit fb_sys_fops syscopyarea sysfillrect sysimgblt snd_hda_codec_generic nfit kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep snd_pcm ghash_clmulni_intel snd_seq_midi snd_seq_midi_event pcbc snd_rawmidi snd_seq snd_seq_device aesni_intel snd_timer joydev aes_x86_64 crypto_simd cryptd glue_helper snd soundcore input_leds mac_hid serio_raw qemu_fw_cfg binfmt_misc sch_fq_codel nfsd auth_rpcgss nfs_acl lockd grace sunrpc parport_pc ppdev lp parport ip_tables x_tables autofs4 hid_generic floppy usbhid psmouse hid i2c_piix4 e1000 pata_acpi
> [   43.055819] CPU: 1 PID: 2807 Comm: modprobe Tainted: G           OE     4.18.0-15-generic #16~18.04.1-Ubuntu
> [   43.055820] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   43.055830] RIP: 0010:drm_mm_takedown+0x24/0x30 [drm]
> [   43.055831] Code: 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 47 38 48 83 c7 38 48 39 c7 75 02 f3 c3 55 48 c7 c7 38 33 80 c0 48 89 e5 e8 1c 41 ec d0 <0f> 0b 5d c3 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41
> [   43.055857] RSP: 0018:ffffae33c1393d28 EFLAGS: 00010286
> [   43.055859] RAX: 0000000000000000 RBX: ffff9651b4a29800 RCX: 0000000000000006
> [   43.055860] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff9651bfc964b0
> [   43.055861] RBP: ffffae33c1393d28 R08: 00000000000002a6 R09: 0000000000000004
> [   43.055861] R10: ffffae33c1393d20 R11: 0000000000000001 R12: ffff9651ba6cb000
> [   43.055863] R13: ffff9651b7f40000 R14: ffffffffc0de3a10 R15: ffff9651ba5c6460
> [   43.055864] FS:  00007f1d3c08d540(0000) GS:ffff9651bfc80000(0000) knlGS:0000000000000000
> [   43.055865] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   43.055866] CR2: 00005630a5831640 CR3: 000000012e274004 CR4: 00000000003606e0
> [   43.055870] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   43.055871] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   43.055871] Call Trace:
> [   43.055885]  drm_vma_offset_manager_destroy+0x1b/0x30 [drm]
> [   43.055894]  drm_gem_destroy+0x19/0x40 [drm]
> [   43.055903]  drm_dev_fini+0x7f/0x90 [drm]
> [   43.055911]  drm_dev_release+0x2b/0x40 [drm]
> [   43.055919]  drm_dev_unplug+0x64/0x80 [drm]
> [   43.055994]  amdgpu_pci_remove+0x39/0x70 [amdgpu]
> [   43.055998]  pci_device_remove+0x3e/0xc0
> [   43.056001]  device_release_driver_internal+0x18a/0x260
> [   43.056003]  driver_detach+0x3f/0x80
> [   43.056004]  bus_remove_driver+0x59/0xd0
> [   43.056006]  driver_unregister+0x2c/0x40
> [   43.056008]  pci_unregister_driver+0x22/0xa0
> [   43.056087]  amdgpu_exit+0x15/0x57c [amdgpu]
> [   43.056090]  __x64_sys_delete_module+0x146/0x280
> [   43.056094]  do_syscall_64+0x5a/0x120
>
> Signed-off-by: Yintian Tao <yttao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 02d80b9dbfe1..01a1082b5cab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1138,8 +1138,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>   #endif
>   		DRM_ERROR("Hotplug removal is not supported\n");
>   	drm_dev_unplug(dev);
> -	drm_dev_put(dev);
>   	amdgpu_driver_unload_kms(dev);
> +	drm_dev_put(dev);
>   	pci_disable_device(pdev);
>   	pci_set_drvdata(pdev, NULL);

Maybe even put this after the pci_* functions?

At least pci_set_drvdata() sounds like it needs to come before we 
release the structure.

Christian.

>   }

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
