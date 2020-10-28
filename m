Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E371DC388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 14:59:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E8724724
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 14:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/5iDaVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E8724724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 116266E0C6;
	Wed, 28 Oct 2020 14:59:01 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25A9E6E0C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 14:59:00 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id m65so3710351qte.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 07:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=TWoQUpKkT5lW8WJxFDGBWkW/XezSoQ40dpnPjFtifac=;
 b=e/5iDaVoId6CyIze5WgldXDsLrFo0FKzMKriR5jb1cVUpleh/L/0Z98Q0MSIEzw9M0
 IniHAdRO71DTYXt34HLrj789j4payiwfKWi3bRfb8WKIvDfQBVwxXL1T58StKxZ/z8zl
 10aEJiDH1GBqXf64SkjzxHavV+ZEwQvJ0DyyhufqBS3tbILnkqlH0FhmwKeZD+LKMG24
 XBtBzo3t9a6o1UaSMR/1bppKFtRCPPMvQUAOroKHnYagaEzkOFeTFaYLC+a5uKVtclfM
 qIgSAoZJlKqlRMZKnvYxnn/Roq0jWMsxhk0Y3Xf8w9evq8ELbpue3/eJORkqs9mqN6js
 xQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=TWoQUpKkT5lW8WJxFDGBWkW/XezSoQ40dpnPjFtifac=;
 b=UKAZ86PtnbW3JObM4/GAU4nkFzSKWd2Erzw516oQR9+a0Ea7Rd2DiKDWZa6Rtj6pp4
 pmm7MkT0qto3FUNJ11uBfmF/ECU9428j93719w1h9iTyWyXXcjgoXiXcPmJkJFlRmgN6
 5HYC8HzmuAKzEDnQYZF/LrK69y1/evCrqZqvQ7a8yU2NLkl5Q4q1AzvIJ/ZPGZc72Kdz
 pjREaulqlkEL9ZFev+cFgloZP5w6NQiTFCizgoyryF4APCM37cFZ6cRGA+rVHRaAQLFe
 zGTS9bg9HbpN8m6hc0aMpkz1V9sC0R4AkFATqb6kg4vjjR0CNxSkg5nZrTW6TQd29yAL
 5Z8A==
X-Gm-Message-State: AOAM5333KajlnqJYuPkc/xq5FoOmcqouG8YaZ6S7Xx2b+Rl/gkFAxR30
 lonKlYKwJC4SELgA4yBTBmvN8FLQCVI=
X-Google-Smtp-Source: ABdhPJy6lN1wAdc+tQvWMkUEPa17OA5hfvtK/BB0PnDue32Hzqx3r74zRr9fTLnuCBvKHcx+JvEYPQ==
X-Received: by 2002:ac8:1089:: with SMTP id a9mr7743002qtj.111.1603897139042; 
 Wed, 28 Oct 2020 07:58:59 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id f4sm3063360qtd.35.2020.10.28.07.58.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 07:58:58 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Add kernel parameter to force no xgmi
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201028145502.2703-1-alex.sierra@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7d27dd5f-e178-188a-6537-6b4d6d31b205@gmail.com>
Date: Wed, 28 Oct 2020 15:58:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028145502.2703-1-alex.sierra@amd.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.10.20 um 15:55 schrieb Alex Sierra:
> By enabling this parameter, the system will be forced to use pcie
> interface only for p2p transactions.

Better name that amdgpu_xgmi with a default value of enabled.

Or maybe add another bit value for amdgpu_vm_debug instead.

>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 9 +++++++++
>   3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index ba65d4f2ab67..3645f00e9f61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -188,6 +188,7 @@ extern int amdgpu_discovery;
>   extern int amdgpu_mes;
>   extern int amdgpu_noretry;
>   extern int amdgpu_force_asic_type;
> +extern int amdgpu_force_no_xgmi;
>   #ifdef CONFIG_HSA_AMD
>   extern int sched_policy;
>   extern bool debug_evictions;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1fe850e0a94d..0a5d97a84017 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2257,7 +2257,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>   	if (r)
>   		goto init_failed;
>   
> -	if (adev->gmc.xgmi.num_physical_nodes > 1)
> +	if (!amdgpu_force_no_xgmi && adev->gmc.xgmi.num_physical_nodes > 1)

Mhm, this will most likely cause problems. You still need to add the 
device to the hive because otherwise GPU won't work.

Apart from that sounds like a good idea in general.

Christian.

>   		amdgpu_xgmi_add_device(adev);
>   	amdgpu_amdkfd_device_init(adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4b78ecfd35f7..22485067cf31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -160,6 +160,7 @@ int amdgpu_force_asic_type = -1;
>   int amdgpu_tmz = 0;
>   int amdgpu_reset_method = -1; /* auto */
>   int amdgpu_num_kcq = -1;
> +int amdgpu_force_no_xgmi = 0;
>   
>   struct amdgpu_mgpu_info mgpu_info = {
>   	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
> @@ -522,6 +523,14 @@ module_param_named(ras_enable, amdgpu_ras_enable, int, 0444);
>   MODULE_PARM_DESC(ras_mask, "Mask of RAS features to enable (default 0xffffffff), only valid when ras_enable == 1");
>   module_param_named(ras_mask, amdgpu_ras_mask, uint, 0444);
>   
> +/**
> + * DOC: force_no_xgmi (uint)
> + * Forces not to use xgmi interface (0 = disable, 1 = enable).
> + * Default is 0 (disabled).
> + */
> +MODULE_PARM_DESC(force_no_xgmi, "Force not to use xgmi interface");
> +module_param_named(force_no_xgmi, amdgpu_force_no_xgmi, int, 0600);
> +
>   /**
>    * DOC: si_support (int)
>    * Set SI support driver. This parameter works after set config CONFIG_DRM_AMDGPU_SI. For SI asic, when radeon driver is enabled,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
