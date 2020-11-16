Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_48_96,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840B8C388F7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 15:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC8B208D5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 15:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvXaDLPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC8B208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2A206E520;
	Fri, 13 Nov 2020 15:31:26 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 770E36E520
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 15:31:25 +0000 (UTC)
Received: by mail-ed1-x542.google.com with SMTP id v4so11169931edi.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 07:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=dmHwV8jGyqavOn9yOmghQFbgE92fWOlXz+zm+qg1xSw=;
 b=SvXaDLPnqeKOIDu82Jn56vIgIYSacJL1lt7bY+SgNJNOgz5BWOYdLh4IKyWYKZ9zhW
 LWhjNb0vh9j9laN1ibex093ehNYCbC4c+VqeTqzCvjJ0Iqf2bSxMvZM3I2XK7tqPiuIT
 Dd76ry+hdWa0BJCZV/nYgu1I33BFUhM5v27OZ+mwU8inIauLLiqhu7MZm1kkIOMSsg/g
 1qkNLOMYd5HE/HVj2zyfvo8JknT4LjKzFSCoa2eTz2xQWsDMORlHeiY4Lf2piD1FY1py
 d1wMn/FM11jI1PbAJtHGp9VRPWtb8ALOi/UkktI2R19zwJTRV89m+KDxvxJbGO7uM4LI
 O8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=dmHwV8jGyqavOn9yOmghQFbgE92fWOlXz+zm+qg1xSw=;
 b=rI/D20awdf0TEl1hCFz2aiCGR7Nhg+iBE4Mp2LTuFqV5UaZe9KI/JiB5zNN0Xu9f0W
 1XcbMuFTGI2NP8RPdkUFmmk6gL+KkAZk4Pmw5PVjn2gPO0hzAUeHPp2mIGY+YousqoLT
 oZWnDKd7p30/q6T8akwmdBN+mSe8Y85x+bx6wTM8PTjb0C2zhtdAQAANzL4qU9YvjpmH
 QANv2vVOxpFTDpHT/mOFQa2vI3n3Vi4BsNO5fsk/f+NPSfFlBoTvJp0WM9FwkCpZYdOm
 Q/4oQ46T6WWltkGVZx6iQLS0TgnDKoo05iz4fFX2y0YyiLt2r6YfLyVviwuPQeahZkzg
 hYpg==
X-Gm-Message-State: AOAM532JoBbdREtS6I4pG2MU0kEvT1KXS7K+NJqreMuiaBUsnlFN63Ja
 dZbygBdeSOU4HwVdFCdXRzlqMhUOggA=
X-Google-Smtp-Source: ABdhPJyPytOAs9d0rS2xxvfKLRHfCF5MWp2eemPX5BmVQrD+shfAZH3p/D5ZlWVQ/SIyewdLjo2fLg==
X-Received: by 2002:a50:cf82:: with SMTP id h2mr3003119edk.142.1605281481960; 
 Fri, 13 Nov 2020 07:31:21 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id dn16sm4297129edb.19.2020.11.13.07.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2020 07:31:21 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: enable 48-bit IH timestamp counter
To: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20201110175519.21308-1-alex.sierra@amd.com>
 <SA0PR12MB4430DF99234F8097DE57FBF5FDE90@SA0PR12MB4430.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <288f55c4-62a4-0249-7a9c-9dc417caa462@gmail.com>
Date: Mon, 16 Nov 2020 12:31:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <SA0PR12MB4430DF99234F8097DE57FBF5FDE90@SA0PR12MB4430.namprd12.prod.outlook.com>
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Feel free to keep my rb for this, but is 455 days enough in general or 
should we add wrap around handling?

Christian.

Am 10.11.20 um 18:57 schrieb Sierra Guiza, Alejandro (Alex):
> [AMD Public Use]
>
> I just added support for vega10_ih too.
>
> Regards,
> Alex
>
>> -----Original Message-----
>> From: Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>
>> Sent: Tuesday, November 10, 2020 11:55 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix
>> <Felix.Kuehling@amd.com>; Sierra Guiza, Alejandro (Alex)
>> <Alex.Sierra@amd.com>
>> Subject: [PATCH] drm/amdgpu: enable 48-bit IH timestamp counter
>>
>> By default this timestamp is based on a 32 bit counter.
>> This is used by the amdgpu_gmc_filter_faults, to avoid process the same
>> interrupt in retry configuration.
>> Apparently there's a problem when the timestamp coming from IH overflows
>> and compares against timestamp coming from the the hash table.
>> This patch only extends the time overflow from 10 minutes to aprx 455 days.
>>
>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 6 ++++++
>> drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 6 ++++++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> index 837769fcb35b..bda916f33805 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> @@ -94,6 +94,8 @@ static void navi10_ih_enable_interrupts(struct
>> amdgpu_device *adev)
>>
>>   	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 1);
>>   	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR,
>> 1);
>> +	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
>> +				   RB_GPU_TS_ENABLE, 1);
>>   	if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
>>   		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL,
>> ih_rb_cntl)) {
>>   			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
>> @@ -109,6 +111,8 @@ static void navi10_ih_enable_interrupts(struct
>> amdgpu_device *adev)
>>   		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0,
>> mmIH_RB_CNTL_RING1);
>>   		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
>>   					   RB_ENABLE, 1);
>> +		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
>> +					   RB_GPU_TS_ENABLE, 1);
>>   		if (amdgpu_sriov_vf(adev) && adev->asic_type <
>> CHIP_NAVI10) {
>>   			if (psp_reg_program(&adev->psp,
>> PSP_REG_IH_RB_CNTL_RING1,
>>   						ih_rb_cntl)) {
>> @@ -125,6 +129,8 @@ static void navi10_ih_enable_interrupts(struct
>> amdgpu_device *adev)
>>   		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0,
>> mmIH_RB_CNTL_RING2);
>>   		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
>>   					   RB_ENABLE, 1);
>> +		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
>> +					   RB_GPU_TS_ENABLE, 1);
>>   		if (amdgpu_sriov_vf(adev) && adev->asic_type <
>> CHIP_NAVI10) {
>>   			if (psp_reg_program(&adev->psp,
>> PSP_REG_IH_RB_CNTL_RING2,
>>   						ih_rb_cntl)) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> index 407c6093c2ec..35d68bc5d95e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> @@ -50,6 +50,8 @@ static void vega10_ih_enable_interrupts(struct
>> amdgpu_device *adev)
>>
>>   	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 1);
>>   	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR,
>> 1);
>> +	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
>> +				   RB_GPU_TS_ENABLE, 1);
>>   	if (amdgpu_sriov_vf(adev)) {
>>   		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL,
>> ih_rb_cntl)) {
>>   			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
>> @@ -64,6 +66,8 @@ static void vega10_ih_enable_interrupts(struct
>> amdgpu_device *adev)
>>   		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0,
>> mmIH_RB_CNTL_RING1);
>>   		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
>>   					   RB_ENABLE, 1);
>> +		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
>> +					   RB_GPU_TS_ENABLE, 1);
>>   		if (amdgpu_sriov_vf(adev)) {
>>   			if (psp_reg_program(&adev->psp,
>> PSP_REG_IH_RB_CNTL_RING1,
>>   						ih_rb_cntl)) {
>> @@ -80,6 +84,8 @@ static void vega10_ih_enable_interrupts(struct
>> amdgpu_device *adev)
>>   		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0,
>> mmIH_RB_CNTL_RING2);
>>   		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
>>   					   RB_ENABLE, 1);
>> +		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
>> +					   RB_GPU_TS_ENABLE, 1);
>>   		if (amdgpu_sriov_vf(adev)) {
>>   			if (psp_reg_program(&adev->psp,
>> PSP_REG_IH_RB_CNTL_RING2,
>>   						ih_rb_cntl)) {
>> --
>> 2.17.1
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
