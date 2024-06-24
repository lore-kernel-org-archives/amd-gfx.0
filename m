Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9D7C2BD05
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 09:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECD9210E3D9;
	Mon, 24 Jun 2024 09:38:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lndtnt+g";
	dkim-atps=neutral
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1E5C10E3D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 09:38:05 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-2ec3f875e68so46421881fa.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 02:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719221884; x=1719826684; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R9Gf9NyzAXF9ZB+nOI1uIChDoyaKiQ2DBODVD+nmwaA=;
 b=lndtnt+gg4IextvGuBgYMPcmV/eeaFgTedfmL8x008QkNQcXu9zj1pvjZVcJgUcqX3
 gvvs6Wt2hX1whrI2debg+yWERmH1thbHEjlALiIQbLSSKRjpUzcbkFZy5DHFH095sRE9
 QNo7CNtyLAUBxB558NZpenAtHetRfZif33J3M0k/5wJcQWQx1hbmsmu12S+JkDNmMq45
 TEH9IPbzKRM5gfnIOlFXSQ30CTUvqu5e+2I7AAPmo4Pkm3dTqk7TAxcdy4Z3Zsonk5Qa
 MZPP06fA6S40c+8Nvq89otmzP3oZfW4+psUglyYIZ5vFiNgrqt+fChFLdT5HArnrsPpf
 Rf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719221884; x=1719826684;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R9Gf9NyzAXF9ZB+nOI1uIChDoyaKiQ2DBODVD+nmwaA=;
 b=j83qsTb9h6reemTeVhxMaMGnol48OWuVAg+LgFRjXT/eXM9zjVNW49r9et8skitMku
 CvWO89IpIvcGToEcR2vW64qY4CNlxt+VT86bedyOwwPXx04V6EVr5RjdHQ1L5/J91Jgl
 BbB0WGMRBRIwAQx0+m4ORQMyUEp5qzuPMektoTM4Qlce2Pw1AnhpyazRvk/k1Li4gg8n
 2AxtdoydDYDIks5NObA9qHYsZ+HF5WXxg5NFb7GBaajcJb9yZjOmJthVH2EmHyu5IyzB
 wqz3y7FsXnmoQP4PFcs0CrySoeGFhhtyroZpz/ykdcn1Vvz7RSD7pKe8wBVmREFeDNn0
 CIDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3qyippgwy+tkVzqP3JIsQNLijHhSMG8jFVvReZ4NPyObbgHltzqno0P0rYWniyTsQdI0VzyL8Tu1z9AX1VD9kbysG91DCgiOR0Y0TpQ==
X-Gm-Message-State: AOJu0YysxuQobq2Uhd3g1R8FqrGh8E+kGYk1NSB3W1nV9EOreD2MGL9R
 9+qh7ndVFseSC0C5L7Q14TPn7zPzY7Kt6bDp7DA2GAh+CflsVLvj
X-Google-Smtp-Source: AGHT+IEVLrNN0Vms6OJyx3rdLS/qOcvpihk5nVBbt3MNWumk9qmuTqf1/MSjPSYQVBFmYKR/c6kR4w==
X-Received: by 2002:a2e:8608:0:b0:2ec:5102:4a6b with SMTP id
 38308e7fff4ca-2ec5b3e35a6mr19590651fa.53.1719221883334; 
 Mon, 24 Jun 2024 02:38:03 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d21225fsm165033905e9.42.2024.06.24.02.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 02:38:02 -0700 (PDT)
Message-ID: <5d63de6b-0d46-422f-bc6e-6f59fce6104a@gmail.com>
Date: Mon, 24 Jun 2024 11:38:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drop kiq access while in reset
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Vignesh Chander <Vignesh.Chander@amd.com>, amd-gfx@lists.freedesktop.org
Cc: jeffrey.chan@amd.com, zhigang.luo@amd.com
References: <20240624063109.655690-1-Vignesh.Chander@amd.com>
 <6f21496a-282c-428e-b66d-92edb82b21d8@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <6f21496a-282c-428e-b66d-92edb82b21d8@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.06.24 um 08:34 schrieb Lazar, Lijo:
>
> On 6/24/2024 12:01 PM, Vignesh Chander wrote:
>> correctly handle the case when trylock fails when gpu is
>> about to be reset by dropping the request instead of using mmio
>>
>> Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Thanks,
> Lijo
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38 ++++++++++++----------
>>   1 file changed, 21 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index a7ce8280b17ce7..3cfd24699d691d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -613,10 +613,11 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
>>   
>>   	if ((reg * 4) < adev->rmmio_size) {
>>   		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>> -		    amdgpu_sriov_runtime(adev) &&
>> -		    down_read_trylock(&adev->reset_domain->sem)) {
>> -			ret = amdgpu_kiq_rreg(adev, reg, 0);
>> -			up_read(&adev->reset_domain->sem);
>> +		    amdgpu_sriov_runtime(adev) {
>> +			if (down_read_trylock(&adev->reset_domain->sem)) {
>> +				ret = amdgpu_kiq_rreg(adev, reg, 0);
>> +				up_read(&adev->reset_domain->sem);
>> +			}

What has actually changed here? As far as I can see that isn't 
functionally different to the existing code.

Regards,
Christian.

>>   		} else {
>>   			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
>>   		}
>> @@ -681,10 +682,11 @@ uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev,
>>   							 &rlcg_flag)) {
>>   			ret = amdgpu_virt_rlcg_reg_rw(adev, reg, 0, rlcg_flag, GET_INST(GC, xcc_id));
>>   		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>> -		    amdgpu_sriov_runtime(adev) &&
>> -		    down_read_trylock(&adev->reset_domain->sem)) {
>> -			ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
>> -			up_read(&adev->reset_domain->sem);
>> +		    amdgpu_sriov_runtime(adev) {
>> +			if (down_read_trylock(&adev->reset_domain->sem)) {
>> +				ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
>> +				up_read(&adev->reset_domain->sem);
>> +			}
>>   		} else {
>>   			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
>>   		}
>> @@ -740,10 +742,11 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
>>   
>>   	if ((reg * 4) < adev->rmmio_size) {
>>   		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>> -		    amdgpu_sriov_runtime(adev) &&
>> -		    down_read_trylock(&adev->reset_domain->sem)) {
>> -			amdgpu_kiq_wreg(adev, reg, v, 0);
>> -			up_read(&adev->reset_domain->sem);
>> +		    amdgpu_sriov_runtime(adev) {
>> +			if (down_read_trylock(&adev->reset_domain->sem)) {
>> +				amdgpu_kiq_wreg(adev, reg, v, 0);
>> +				up_read(&adev->reset_domain->sem);
>> +			}
>>   		} else {
>>   			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
>>   		}
>> @@ -812,11 +815,12 @@ void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,
>>   							 &rlcg_flag)) {
>>   			amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag, GET_INST(GC, xcc_id));
>>   		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>> -		    amdgpu_sriov_runtime(adev) &&
>> -		    down_read_trylock(&adev->reset_domain->sem)) {
>> -			amdgpu_kiq_wreg(adev, reg, v, xcc_id);
>> -			up_read(&adev->reset_domain->sem);
>> -		} else {
>> +		    amdgpu_sriov_runtime(adev) {
>> +			if (down_read_trylock(&adev->reset_domain->sem)) {
>> +				amdgpu_kiq_wreg(adev, reg, v, xcc_id);
>> +				up_read(&adev->reset_domain->sem);
>> +			}
>> +		    } else {
>>   			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
>>   		}
>>   	} else {

