Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CD4C433E5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 13:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA6820714
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 13:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oquQCtXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA6820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0AE889B99;
	Thu, 23 Jul 2020 13:10:28 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C585D89B99
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 13:10:26 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id gg18so2932624ejb.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=XSqHq8X+z+eqgZAUwAnsLVeGI2qe7R34nvlom6fKZgk=;
 b=oquQCtXUYf3uEi0nHoa5YkBc1bm8FJJDUPBRC4RprHBnNQJVoUafyOUXrlmRiqsVv1
 vWNSHtLmS2bjlOU7tRT0u5rxlIO0tON9IvgT4fEddeViYzsMqpBmxaWDZEgDIh4GdkGD
 BwFf0lIXI5r2amq97X0ipV4T87sP/aEz4ViEzCvl7a+gO9KaJVxZ/2xREPLAgN2Pun9f
 AH7HAPEmzVyTK0x9B5wQzGPF/EaU5rttXmgT42vezEqizppe0cTtHe8d4F+yPEyyCPUs
 7uY7f5IvRLs0MshxlfDgxJXcWy7DGTruJlOhs+5HLPcDdA8bhLIwt3R3OXNE9L1Oorye
 EYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=XSqHq8X+z+eqgZAUwAnsLVeGI2qe7R34nvlom6fKZgk=;
 b=LHIKgOnbcUhGeNpZlM8alKX6xGCsFsmZw2I23SuzfUDcFvBZQ/NXiq3v8GVB4/nKhK
 v7Bow4CP95mklxAiRuNRUb31Hba+Hn+dkLdesc9aUlYvnv7qyPhP5YYuOFcsGEU5jHy+
 hxvUX0VVWffJ52TNJ611i9CA0/6Nuu5skZA6dWU97zX492w4zbiPkSYqBnZHSIesL8FC
 QX7jfcJeupSX18f4+kcLEkEeN66AXL8C0dHtuUDlfOvxMK9n0UuQy0pmAES4MVXt/47R
 8Gb+QtNWh+e++fAC30r5dY/lVo5cQNTWRNl1rMjYpnrUZMZ0jUVtIWhhCIy/W9oMSM+P
 l2aA==
X-Gm-Message-State: AOAM5310hoSqoVIgOKivzC355ubkERGclNlvQ2My+TFGFpEy0tNTVV83
 XWTCxKTqdnp0iQM9I7txJvo=
X-Google-Smtp-Source: ABdhPJwBZQRt9HkjIC68V3BWFBbdR5GmPcnqJbJoaIfQlqw7BlejJfZfqhiJ5/E8hsxzPJG3wvRnJA==
X-Received: by 2002:a17:906:2c53:: with SMTP id
 f19mr4448307ejh.523.1595509825422; 
 Thu, 23 Jul 2020 06:10:25 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id lc18sm1414680ejb.29.2020.07.23.06.10.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jul 2020 06:10:24 -0700 (PDT)
Subject: Re: [PATCH 1/5] drm/amdgpu: add bad page count threshold in module
 parameter
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Clements, John" <John.Clements@amd.com>
References: <20200722031415.4792-1-guchun.chen@amd.com>
 <20200722031415.4792-2-guchun.chen@amd.com>
 <DM5PR12MB25332D58B47ABB52BFBD1A4DED760@DM5PR12MB2533.namprd12.prod.outlook.com>
 <BN6PR12MB128336C43F529CC62BEB4281F1760@BN6PR12MB1283.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <040f8c43-758d-e937-1d00-2ff4b118bde1@gmail.com>
Date: Thu, 23 Jul 2020 15:10:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BN6PR12MB128336C43F529CC62BEB4281F1760@BN6PR12MB1283.namprd12.prod.outlook.com>
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

I agree with Guchun as well.

When you have a dynamic module parameter and change the bad page 
threshold the GPU might just stop working suddenly.

That is not a good idea as far as I can see.

Regards,
Christian.

Am 23.07.20 um 05:47 schrieb Chen, Guchun:
> [AMD Public Use]
>
> Hi Dennis,
>
> To be honest, your suggestion is considered when I start the design. My thought is in actual world, bad page threshold is one static configuration, it should be set once when probing.
> So module parameter is one ideal choice for this.
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Li, Dennis <Dennis.Li@amd.com>
> Sent: Thursday, July 23, 2020 8:32 AM
> To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
> Subject: RE: [PATCH 1/5] drm/amdgpu: add bad page count threshold in module parameter
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi, Guchun,
>        It is better to let user be able to change amdgpu_bad_page_threshold with sysfs, so that users no need to reboot system when they want to change their strategy.
>
> Best Regards
> Dennis Li
> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Wednesday, July 22, 2020 11:14 AM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH 1/5] drm/amdgpu: add bad page count threshold in module parameter
>
> bad_page_threshold could be specified to detect and retire bad GPU if faulty bad pages exceed it.
>
> When it's -1, ras will use typical bad page failure value.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 11 +++++++++++
>   2 files changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 06bfb8658dec..bb83ffb5e26a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -181,6 +181,7 @@ extern uint amdgpu_dm_abm_level;  extern struct amdgpu_mgpu_info mgpu_info;  extern int amdgpu_ras_enable;  extern uint amdgpu_ras_mask;
> +extern int amdgpu_bad_page_threshold;
>   extern int amdgpu_async_gfx_ring;
>   extern int amdgpu_mcbp;
>   extern int amdgpu_discovery;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index d28b95f721c4..f99671101746 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -161,6 +161,7 @@ struct amdgpu_mgpu_info mgpu_info = {  };  int amdgpu_ras_enable = -1;  uint amdgpu_ras_mask = 0xffffffff;
> +int amdgpu_bad_page_threshold = -1;
>   
>   /**
>    * DOC: vramlimit (int)
> @@ -801,6 +802,16 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);  MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");  module_param_named(reset_method, amdgpu_reset_method, int, 0444);
>   
> +/**
> + * DOC: bad_page_threshold (int)
> + * Bad page threshold configuration is driven by RMA(Return Merchandise
> + * Authorization) policy, which is to specify the threshold value of
> +faulty
> + * pages detected by ECC, which may result in GPU's retirement if total
> + * faulty pages by ECC exceed threshold value.
> + */
> +MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 =
> +auto(default typical value))"); module_param_named(bad_page_threshold,
> +amdgpu_bad_page_threshold, int, 0444);
> +
>   static const struct pci_device_id pciidlist[] = {  #ifdef  CONFIG_DRM_AMDGPU_SI
>   	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
> --
> 2.17.1
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
