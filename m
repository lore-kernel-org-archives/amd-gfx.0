Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94305C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 15:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 319BD10E3E7;
	Wed,  2 Mar 2022 15:01:31 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A45710E5C4
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 15:01:30 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 n33-20020a05600c3ba100b003832caf7f3aso1234852wms.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Mar 2022 07:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=zFGBOObgVpjtOUWZKHiRucOQFbiurrZLujRqnrEMH/k=;
 b=hpY1Q7OZCx4x7isCnu4Wd0mByyI5aIwq0dKIcHUsN9Y8lJlMrsuPKvzdvgG2YCf+kK
 en+/Xd+2UCUYuvVhL++7Tx9VCWhcoKAMCwOR0t2yPRxBJNNDauoftWVtdzSZrg9maOJw
 J2apT2FVMwr3xygfLg8KSk5B6ydM9J5cbfNkd17l2y9K0e/55pxT2RAT8mkM/cPHoRxV
 6Qa2Y/IpN07kepvl7rDknpqIEbiov8wQwDSCa0C9sFlJlzHF2dxE/poGu/x/w31sEXXe
 b01H4Imm0VC5YqtDQhORvk4FI8/uWI/hqRwMJo+vIz+0fRO5u30SwAehCF/rJ23NyB72
 tcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=zFGBOObgVpjtOUWZKHiRucOQFbiurrZLujRqnrEMH/k=;
 b=6OuDYXDrI9kJVaXaxY127qjo3mBrmPAAdkVqgK+G8wvcwPrWurSzvLZXXLELUGabsw
 h11HwSvo0ht3vGUz2F+4OnIXBN3BZHSwjhp5roy94/a0qZA8ctc8aBjT0cb0KDvo0v0a
 VwH/qbhJeOVuoAkR7zokTo4h9USPmVLVV5Z85Ja0KPMa0hUNW7N1Wu9cG1uXoj0ttXYK
 TXGRJ6Q9w0o87BmOvG/mCRrUOorQJw1mvY0lTSfpZs9/U+mGtnIo2p3Hm+uy6wZTeZI5
 PnAWAeQaoItqKKwQ275TVpSY2xeNhjTsW06o7e6cqj7rDzeQykCPrU4w66TdXIVD3bjf
 E5Sg==
X-Gm-Message-State: AOAM5317E9fDx6ZVY7WOkJGsn1ssFeMOcWxtrp5C0/CzV2lpW/DjwNiB
 u9vqteF9a72V4qIrG50jyyA=
X-Google-Smtp-Source: ABdhPJyMVlAQdV+ulKS3CEDHLB1vwM9t5Gcpx8kbPPLjSvSIF0q5iqd8vT3nNz/x1EMnCY+4q9rxGA==
X-Received: by 2002:a05:600c:1592:b0:381:21b4:d1d8 with SMTP id
 r18-20020a05600c159200b0038121b4d1d8mr125792wmf.119.1646233289002; 
 Wed, 02 Mar 2022 07:01:29 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:91d6:cd7c:ea5f:1ff5?
 ([2a02:908:1252:fb60:91d6:cd7c:ea5f:1ff5])
 by smtp.gmail.com with ESMTPSA id
 o12-20020adfa10c000000b001efb97fae48sm11426920wro.80.2022.03.02.07.01.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Mar 2022 07:01:28 -0800 (PST)
Message-ID: <2cf40fb2-6d0f-660b-c238-a8c97511ab22@gmail.com>
Date: Wed, 2 Mar 2022 16:01:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: fix potential null dereference
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Weiguo Li <liwg06@foxmail.com>
References: <tencent_A4D5E94B44BF0EC4B7CE08BA886C0C1B0F06@qq.com>
 <CADnq5_NOGDTnB+YbN2vLm9mNo1sAn4n=Seowk8vd4wuT5krDow@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_NOGDTnB+YbN2vLm9mNo1sAn4n=Seowk8vd4wuT5krDow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks like my response never made it through.

This change and the existing check is nonsense. The caller makes sure 
that ctx is never NULL here.

So the check should probably just be dropped entirely.

Regards,
Christian.

Am 02.03.22 um 15:21 schrieb Alex Deucher:
> Applied.  Thanks!
>
> Alex
>
> On Wed, Mar 2, 2022 at 3:56 AM Weiguo Li <liwg06@foxmail.com> wrote:
>> "ctx" is dereferenced but null checked later. Swap their positions
>> to avoid potential null dereference.
>>
>> Found using a Coccinelle script:
>> https://coccinelle.gitlabpages.inria.fr/website/rules/mini_null_ref.cocci
>>
>> Signed-off-by: Weiguo Li <liwg06@foxmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> index f522b52725e4..b4f035ce44bc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -258,11 +258,12 @@ static void amdgpu_ctx_fini_entity(struct amdgpu_ctx_entity *entity)
>>   static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
>>                                          u32 *stable_pstate)
>>   {
>> -       struct amdgpu_device *adev = ctx->adev;
>> +       struct amdgpu_device *adev;
>>          enum amd_dpm_forced_level current_level;
>>
>>          if (!ctx)
>>                  return -EINVAL;
>> +       adev = ctx->adev;
>>
>>          current_level = amdgpu_dpm_get_performance_level(adev);
>>
>> @@ -289,12 +290,13 @@ static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
>>   static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
>>                                          u32 stable_pstate)
>>   {
>> -       struct amdgpu_device *adev = ctx->adev;
>> +       struct amdgpu_device *adev;
>>          enum amd_dpm_forced_level level;
>>          int r;
>>
>>          if (!ctx)
>>                  return -EINVAL;
>> +       adev = ctx->adev;
>>
>>          mutex_lock(&adev->pm.stable_pstate_ctx_lock);
>>          if (adev->pm.stable_pstate_ctx && adev->pm.stable_pstate_ctx != ctx) {
>> --
>> 2.25.1
>>

