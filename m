Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF87C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 07:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B71E611CC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 07:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B71E611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABF918914D;
	Mon, 17 May 2021 07:14:02 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB45D6E102
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 07:14:01 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id s6so5546021edu.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 00:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=XhuloAe6IcKpXUbgUSWYf2aBU/UMdfPnh1EqlAkb1C0=;
 b=PyS5v+mEB0H/8OazjpeXDBYfnw90fDpMGXeOuGJ8BxHFuMxdDVBTH+LuI+X4yr23YF
 xXyOv9CSTAIN/KsDevgBCoYWhl8vOO18gaWrRwUJdusrFxlSDk5Z5IRUtIttDsAxb1wG
 aPyj0DsesT9gPmmqoIhzbkRWa00XWtrz663cfybt3xjAx2DTpVLqNlzy+PT8mgOMtSGC
 aRDg+A91aZAgKP08M+u0cXX+x7A/k7k9mVhHpKaYUzt7GOpnsvh/rqZ/5Slnxls1Q2kM
 rZUKEBZUjrDxSg4+XWr6CWch5O3JrPdMVhScV8IR70PRG2S0YxIL9THsKSMyRoGD4aeL
 /kXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=XhuloAe6IcKpXUbgUSWYf2aBU/UMdfPnh1EqlAkb1C0=;
 b=HgJdGzcwAv9KqYd0bC06IGjrkDdfWNMiBLqpvzHqYgUOFvHlQ/djr3ydJVwWkPWYNb
 A8GUfyUabm31qoReShkDDnEQMXeylM8Vbl4/Pdu4yCcFfQumQzwAvmylZh/WhHR8Vdtb
 ZMYw6L8eXkDJbR5r93usYEzpJfarNDTz4Xt599rRhcOXdUh2NYS4J9p+I6EM//r1rY0T
 L8Y/0pBfMfixsRvFDmGv89rkMZty9kAISk5xJrrH2DnlPdpeOmVjEAKDDh/kotsXjZL2
 XeWU74w9LPQb3NTtKiutDv+IE/x0+FAsue/ysRRyVAzwR4qb2dQsfRNobvA8XQwmczmK
 Hh0w==
X-Gm-Message-State: AOAM530LYdwBleSpxUg8aMtRfcul1Ve0aiem8gSuuJUj8OKAgtC9lbHs
 +/mB/LEg7tHXFgV8nMfKb9U=
X-Google-Smtp-Source: ABdhPJx0tS5rxiU/Oj7hvSZVpBe47HhHNM0eEADLLnxbiBhBV540vxb49jKeMZ/gLKTPh6tpl7eB/Q==
X-Received: by 2002:a05:6402:2550:: with SMTP id
 l16mr70518310edb.249.1621235640456; 
 Mon, 17 May 2021 00:14:00 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:6bbe:b48c:2de1:422d?
 ([2a02:908:1252:fb60:6bbe:b48c:2de1:422d])
 by smtp.gmail.com with ESMTPSA id p2sm7956128ejo.108.2021.05.17.00.13.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 00:14:00 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/amdgpu: destroy pinned gem obj according to
 refcount
To: Jingwen Chen <Jingwen.Chen2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210517071125.1513142-1-Jingwen.Chen2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <5a431bf7-48c5-0e3f-9db1-d5e2dcaf5b26@gmail.com>
Date: Mon, 17 May 2021 09:13:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210517071125.1513142-1-Jingwen.Chen2@amd.com>
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
Cc: monk.liu@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.05.21 um 09:11 schrieb Jingwen Chen:
> [Why]
> the fb gem object is get for 4 times when amdgpu_display_framebuffer_init,
> while this object is put for less than 4 times. This can lead to warning trace
> when unloading amdgpu
>
> [How]
> put gem object according to refcount in amdgpufb_destroy_pinned_object

WOW, that is a really big NAK.

Please instead fix the refcount leak.

Christian.

>
> Warning trace attached:
> [324584.505752] amdgpu 0000:00:07.0: amdgpu: amdgpu: finishing device.
> [324584.510737] [drm] clean up the vf2pf work item
> [324584.532205] [drm] free PSP TMR buffer
> [324584.591206] ------------[ cut here ]------------
> [324584.591449] WARNING: CPU: 1 PID: 5800 at /var/lib/dkms/amdgpu/5.11.11.119-1259830/build/include/drm/ttm/ttm_resource.h:196 amdgpu_vram_mgr_fini+0x72/0x150 [amdgpu]
> [324584.591450] Modules linked in: amdgpu(OE-) amd_iommu_v2 amdttm(OE) amd_sched(OE) amdkcl(OE) drm_kms_helper drm i2c_algo_bit fb_sys_fops syscopyarea sysfillrect sysimgblt intel_rapl_msr intel_rapl_common kvm irqbypass snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg crct10dif_pclmul snd_hda_codec crc32_pclmul ghash_clmulni_intel snd_hda_core snd_hwdep snd_pcm aesni_intel aes_x86_64 crypto_simd snd_seq_midi cryptd snd_seq_midi_event glue_helper snd_rawmidi snd_seq input_leds snd_seq_device serio_raw snd_timer snd mac_hid soundcore qemu_fw_cfg sch_fq_codel binfmt_misc parport_pc ppdev lp parport ip_tables x_tables autofs4 8139too psmouse floppy 8139cp mii i2c_piix4 pata_acpi [last unloaded: amd_iommu_v2]
> [324584.591479] CPU: 1 PID: 5800 Comm: modprobe Tainted: G        W  OE     5.3.0-61-generic #55~18.04.1-Ubuntu
> [324584.591480] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> [324584.591538] RIP: 0010:amdgpu_vram_mgr_fini+0x72/0x150 [amdgpu]
> [324584.591540] Code: 00 00 41 c6 84 24 40 5d 00 00 00 4c 89 f6 e8 85 9d fa ff 85 c0 74 17 5b 41 5c 41 5d 41 5e 41 5f 5d c3 4c 89 ff e8 51 d3 a9 dc <0f> 0b eb c3 4d 8d b4 24 90 5e 00 00 4d 8d ac 24 98 5e 00 00 4c 89
> [324584.591541] RSP: 0018:ffff9ce444e7fce8 EFLAGS: 00010282
> [324584.591542] RAX: 0000000000000024 RBX: ffff8e86b02c5d60 RCX: 0000000000000000
> [324584.591543] RDX: 0000000000000000 RSI: ffff8e86b7a97448 RDI: ffff8e86b7a97448
> [324584.591543] RBP: ffff9ce444e7fd10 R08: 0000000000000405 R09: 0000000000000004
> [324584.591544] R10: ffff9ce444e7fcd0 R11: 0000000000000001 R12: ffff8e86b02c0000
> [324584.591544] R13: ffff8e86b02c5da0 R14: ffff8e86b02c5d40 R15: ffffffffc0c702a8
> [324584.591545] FS:  00007fea6fac0540(0000) GS:ffff8e86b7a80000(0000) knlGS:0000000000000000
> [324584.591546] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [324584.591547] CR2: 000055b9092b6048 CR3: 000000022f962004 CR4: 00000000003606e0
> [324584.591550] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [324584.591550] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [324584.591551] Call Trace:
> [324584.591605]  amdgpu_ttm_fini+0xc7/0x230 [amdgpu]
> [324584.591657]  amdgpu_bo_fini+0x12/0x40 [amdgpu]
> [324584.591717]  gmc_v10_0_sw_fini+0x32/0x40 [amdgpu]
> [324584.591767]  amdgpu_device_fini+0x373/0x560 [amdgpu]
> [324584.591831]  amdgpu_driver_unload_kms+0x43/0x70 [amdgpu]
> [324584.591879]  amdgpu_pci_remove+0x3b/0x60 [amdgpu]
> [324584.591950]  pci_device_remove+0x3e/0xc0
> [324584.591981]  device_release_driver_internal+0xe0/0x1b0
> [324584.591982]  driver_detach+0x49/0x90
> [324584.591984]  bus_remove_driver+0x59/0xd0
> [324584.591985]  driver_unregister+0x2c/0x40
> [324584.591986]  pci_unregister_driver+0x22/0xa0
> [324584.592071]  amdgpu_exit+0x15/0x629 [amdgpu]
> [324584.592121]  __x64_sys_delete_module+0x146/0x290
> [324584.592148]  do_syscall_64+0x5a/0x130
> [324584.592165]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [324584.592183] RIP: 0033:0x7fea6f5e4047
> [324584.592185] Code: 73 01 c3 48 8b 0d 41 8e 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 11 8e 2c 00 f7 d8 64 89 01 48
> [324584.592186] RSP: 002b:00007ffdfa3d75a8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> [324584.592187] RAX: ffffffffffffffda RBX: 000055b9092ae120 RCX: 00007fea6f5e4047
> [324584.592187] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055b9092ae188
> [324584.592188] RBP: 000055b9092ae120 R08: 00007ffdfa3d6551 R09: 0000000000000000
> [324584.592188] R10: 00007fea6f660c40 R11: 0000000000000206 R12: 000055b9092ae188
> [324584.592189] R13: 0000000000000001 R14: 000055b9092ae188 R15: 00007ffdfa3d8990
> [324584.592190] ---[ end trace 4ea03bb6309ad6c3 ]---
>
> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> index 4f10c4529840..afdc2c48c060 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> @@ -106,7 +106,7 @@ int amdgpu_align_pitch(struct amdgpu_device *adev, int width, int cpp, bool tile
>   static void amdgpufb_destroy_pinned_object(struct drm_gem_object *gobj)
>   {
>   	struct amdgpu_bo *abo = gem_to_amdgpu_bo(gobj);
> -	int ret;
> +	int ret, refcount, i;
>   
>   	ret = amdgpu_bo_reserve(abo, true);
>   	if (likely(ret == 0)) {
> @@ -114,7 +114,10 @@ static void amdgpufb_destroy_pinned_object(struct drm_gem_object *gobj)
>   		amdgpu_bo_unpin(abo);
>   		amdgpu_bo_unreserve(abo);
>   	}
> -	drm_gem_object_put(gobj);
> +
> +	refcount = kref_read(gobj->refcount);
> +	for (i = 0; i < refcount; i++)
> +		drm_gem_object_put(gobj);
>   }
>   
>   static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
