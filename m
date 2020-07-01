Return-Path: <SRS0=Kf1d=AM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0571BC433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 08:20:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E2120722
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 08:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1wVWIGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E2120722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69FBA6E3F3;
	Wed,  1 Jul 2020 08:20:08 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EAAA6E3F3
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2020 08:20:07 +0000 (UTC)
Received: by mail-ej1-x644.google.com with SMTP id ga4so23543488ejb.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jul 2020 01:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=hNQ82aexnIC/SDld+1D00JpUUMvGscoQo1iUw5OxgOA=;
 b=Y1wVWIGEl3WkBlXBcqrK8NV3GyGRoTNSmUrYZC2V5synxL4LmYem+fk7IX8dEpsNa+
 AhSKYKcfKewAIy9dWLp28mtf8NokIQcJgBE65mrX9kkpiD4UlIrMEevAOGpkSy8ymPbP
 4f4oMvhu2DdC02y0MMBkYB6PvF/cy1kLO6B6hmwUnVGTbpoxkWNER+4IXFD0MrGzpEZV
 XDAct63UPSUANe7K8Mxq28uZfNdiHUY5eilzPX1x3sVxxNsw9i+1P9kiohLMPDKmmlzt
 3ru26mlW3fCrGs6YKzbLYB1mdGdg1xNTkpu+lFPjx38v0M1VOWh6WD2OQFt/Y7J0Lnok
 e/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=hNQ82aexnIC/SDld+1D00JpUUMvGscoQo1iUw5OxgOA=;
 b=oYUxgAUWbY3/fy2t6VZlQ8hcJKoOjP2Te3uIIF/zF1SvrZXvc8pdfAiYp+w/f0KPgR
 T3fvqJiHd7OtkZzXinoU5lV86D0ck4oBxDtxJ5SwuD4bHvbcgSGaGtNxurVzy5XiJjWD
 pF9kdg1mbGdf9TVKzgeHFxjdHJHpQ2i4XFrX78GnP1MXScCbEcJF7TyIvjxmuiJQvjrY
 +T/buiNwSzy60P9OhoJlE0wXy84m8716J3FMctrcX+BRGoapu/7GQWN0s7X8uCqyLQwP
 XHpe4YEuwWyJUW7XWeiint5a7p9DKkbER2a1SV3ARetoYph+fhBINvqww8T3PEoTKUDI
 UVQg==
X-Gm-Message-State: AOAM532WzurazoEUeQhaxD1CQEg2BfIZX3ap1aM+4XaaU73USt/RfzPZ
 XB8yyYmhBARqFJzybYJWdts=
X-Google-Smtp-Source: ABdhPJwZ229x3+up9rqZPIGRrmSjtpUOkfutfKl/QtIrceqlrjWITAcaIGMC3SkLYMhir4t7r6jiew==
X-Received: by 2002:a17:906:fcb1:: with SMTP id
 qw17mr21073742ejb.445.1593591605773; 
 Wed, 01 Jul 2020 01:20:05 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u2sm5750390edq.29.2020.07.01.01.20.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 01 Jul 2020 01:20:04 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: return an error for hw access in INFO ioctl
 when in reset
To: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20200626140423.1425349-1-alexander.deucher@amd.com>
 <CADnq5_MzKqWxOdzGSVUWU3cJaXwXNNB3T0igMP8dyRpLMGpgEw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <50d38fa7-5efd-e6ec-d3bd-313cc0138666@gmail.com>
Date: Wed, 1 Jul 2020 10:20:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_MzKqWxOdzGSVUWU3cJaXwXNNB3T0igMP8dyRpLMGpgEw@mail.gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I don't think this is a good idea, we should probably rather wait for 
the GPU reset to finish by taking the appropriate lock.

Christian.

Am 01.07.20 um 07:33 schrieb Alex Deucher:
> ping?
>
> On Fri, Jun 26, 2020 at 10:04 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>> When the GPU is in reset, accessing the hw is unreliable and could
>> interfere with the reset.  Return an error in those cases.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 341d072edd95..fd51d6554ee2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -684,6 +684,9 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
>>                  if (info->read_mmr_reg.count > 128)
>>                          return -EINVAL;
>>
>> +               if (adev->in_gpu_reset)
>> +                       return -EPERM;
>> +
>>                  regs = kmalloc_array(info->read_mmr_reg.count, sizeof(*regs), GFP_KERNEL);
>>                  if (!regs)
>>                          return -ENOMEM;
>> @@ -854,6 +857,9 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
>>                  if (!adev->pm.dpm_enabled)
>>                          return -ENOENT;
>>
>> +               if (adev->in_gpu_reset)
>> +                       return -EPERM;
>> +
>>                  switch (info->sensor_info.type) {
>>                  case AMDGPU_INFO_SENSOR_GFX_SCLK:
>>                          /* get sclk in Mhz */
>> --
>> 2.25.4
>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
