Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE566C433E6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 07:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD6A208DB
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 07:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMJbKbhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD6A208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB5DB89218;
	Tue,  1 Sep 2020 07:11:45 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6F9489218
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 07:11:44 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id x14so231250wrl.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2020 00:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=JsdsoU3ShJGdZpCuok9x27V00S6Qupz1xW/BFAqBCQo=;
 b=gMJbKbhQLwxSJmJXPRqHbm+S3H6M1EWPJSJtKjAWx73oALcMqONGLu6Xqkk9jYY4in
 GSDiGJq7vftEpQegm/cWPo1/JPxYiqoEo5Hf3TFykYHiZ6cxoyuxDQlhfFPuCecYnLIw
 lyiFt3bXO+qs6d7vFbr4a3CT4ws2t+EXmiL2K/Z24EwVKntvypWqAXnTU8YJUGjD3rew
 UQ+7HrrNI5VHvdmRh2eg0PkqLm1wT9P/XhMzQYKzSW3lPG+5jEyljW8zM652pXGKAEXn
 3yZup1UyHxSxoi4rN1FUTMlBDXe4nCmG0uGWE6G6bgZu8SPreoea3z2mBZ4ZlkFZuBP4
 Ufdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=JsdsoU3ShJGdZpCuok9x27V00S6Qupz1xW/BFAqBCQo=;
 b=r6OfcjU9DJpblW5MJYbuXK01OtlPoRRpICVI9hWoHA4CGz5DF3NKfgf9psrX7A4p2c
 vLIr5HyJUKDluM7NzyoVvBW2aQk3uILVbDmvHlrTn1nsInmfWAt784ou8o2r+8dCpG/H
 0pjU7i44HhIVxZ4H0IUquhxJD/5RuwGTY3yaLoltkQcPRVaEWT630wPWpE4IUJ0i0bz0
 7eKWdnkKtybAmRvwpeGusZhxkbabr+Dgz6brhKzVzwXmGb+hZ+lEnwu1ux03zKxsWf/d
 IWaWA8VXojemifPlS5QlLwYFR+5e8UMdE5hz062nIsT+FsegrcZaptajzWCfii7wDOQk
 cI5w==
X-Gm-Message-State: AOAM530U3q+aUEtXu0T9sTU22aClB264kZHfcSayWkV8IJHv9mEBOmxG
 pUy63iQ3iX/FhlGmJg8DFCk=
X-Google-Smtp-Source: ABdhPJwxDL7v5icJcT1tzrmC9YYLuCA/kylryYvmXBeS63xI6xa7Zscm0S/t4/fZcl4kNyz0LIwAgg==
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr310272wrt.84.1598944303258;
 Tue, 01 Sep 2020 00:11:43 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id q12sm697113wrn.94.2020.09.01.00.11.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 00:11:42 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: block ring buffer access during GPU recovery
To: "Li, Dennis" <Dennis.Li@amd.com>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20200901011727.14059-1-Dennis.Li@amd.com>
 <41d0b931-653a-0aba-2ab8-b51c459b2012@amd.com>
 <DM5PR12MB25336BB24DD7E7E6BCD04A4AED2E0@DM5PR12MB2533.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <15899c62-5e58-c13a-b01b-9e6a811ac6c4@gmail.com>
Date: Tue, 1 Sep 2020 09:11:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB25336BB24DD7E7E6BCD04A4AED2E0@DM5PR12MB2533.namprd12.prod.outlook.com>
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

Yeah, correct.

What we maybe should do is to add a WARN_ON() which tests if the current 
thread is the one which has locked the semaphore to catch this case.

Regards,
Christian.

Am 01.09.20 um 04:45 schrieb Li, Dennis:
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi, Andrey,
>      
> RE- Isn't adev->reset_sem non-recursive ? How this works when you try to access registers from within GPU reset thread while adev->reset_sem is already write locked from amdgpu_device_lock_adev earlier in the same thread ?
>
> Deli: down_read_trylock will fail in this case, return false immediately and will not lock adev->reset_sem. In GPU reset thread, we should use MMIO instead of KIQ to access registers.
>
> Best Regards
> Dennis Li
> -----Original Message-----
> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Sent: Tuesday, September 1, 2020 9:40 AM
> To: Li, Dennis <Dennis.Li@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: block ring buffer access during GPU recovery
>
>
> On 8/31/20 9:17 PM, Dennis Li wrote:
>> When GPU is in reset, its status isn't stable and ring buffer also
>> need be reset when resuming. Therefore driver should protect GPU
>> recovery thread from ring buffer accessed by other threads. Otherwise
>> GPU will randomly hang during recovery.
>>
>> Signed-off-by: Dennis Li <Dennis.Li@amd.com>
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 172dc47b7f39..8db56a22cd1b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -319,8 +319,13 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>>    {
>>    	uint32_t ret;
>>    
>> -	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>> -		return amdgpu_kiq_rreg(adev, reg);
>> +	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>> +		amdgpu_sriov_runtime(adev) &&
>> +		down_read_trylock(&adev->reset_sem)) {
>> +		ret = amdgpu_kiq_rreg(adev, reg);
>> +		up_read(&adev->reset_sem);
>> +		return ret;
>> +	}
>
> Isn't adev->reset_sem non-recursive ? How this works when you try to access registers from within GPU reset thread while adev->reset_sem is already write locked from amdgpu_device_lock_adev earlier in the same thread ?
>
> Andrey
>
>
>>    
>>    	if ((reg * 4) < adev->rmmio_size)
>>    		ret = readl(((void __iomem *)adev->rmmio) + (reg * 4)); @@ -332,6
>> +337,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>>    		ret = readl(((void __iomem *)adev->rmmio) + (mmMM_DATA * 4));
>>    		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
>>    	}
>> +
>>    	trace_amdgpu_mm_rreg(adev->pdev->device, reg, ret);
>>    	return ret;
>>    }
>> @@ -407,8 +413,13 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
>>    void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>>    		    uint32_t acc_flags)
>>    {
>> -	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>> -		return amdgpu_kiq_wreg(adev, reg, v);
>> +	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>> +		amdgpu_sriov_runtime(adev) &&
>> +		down_read_trylock(&adev->reset_sem)) {
>> +		amdgpu_kiq_wreg(adev, reg, v);
>> +		up_read(&adev->reset_sem);
>> +		return;
>> +	}
>>    
>>    	amdgpu_mm_wreg_mmio(adev, reg, v, acc_flags);
>>    }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index ad9ad622ccce..4ea2a065daa9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -287,7 +287,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>    	 */
>>    	if (adev->gfx.kiq.ring.sched.ready &&
>>    	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
>> -	    !amdgpu_in_reset(adev)) {
>> +	    down_read_trylock(&adev->reset_sem)) {
>>    
>>    		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>>    		const unsigned eng = 17;
>> @@ -297,6 +297,8 @@ static void gmc_v10_0_flush_gpu_tlb(struct
>> amdgpu_device *adev, uint32_t vmid,
>>    
>>    		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
>>    				1 << vmid);
>> +
>> +		up_read(&adev->reset_sem);
>>    		return;
>>    	}
>>    
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index e1a0ae327cf5..33b7cf1c79ec 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -501,12 +501,13 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>    	 */
>>    	if (adev->gfx.kiq.ring.sched.ready &&
>>    			(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
>> -			!amdgpu_in_reset(adev)) {
>> +			down_read_trylock(&adev->reset_sem)) {
>>    		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
>>    		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>>    
>>    		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
>>    						   1 << vmid);
>> +		up_read(&adev->reset_sem);
>>    		return;
>>    	}
>>    
>> @@ -599,7 +600,8 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>>    	if (amdgpu_in_reset(adev))
>>    		return -EIO;
>>    
>> -	if (ring->sched.ready) {
>> +	if (ring->sched.ready &&
>> +		 down_read_trylock(&adev->reset_sem)) {
>>    		/* Vega20+XGMI caches PTEs in TC and TLB. Add a
>>    		 * heavy-weight TLB flush (type 2), which flushes
>>    		 * both. Due to a race condition with concurrent @@ -626,6 +628,7
>> @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>>    		if (r) {
>>    			amdgpu_ring_undo(ring);
>>    			spin_unlock(&adev->gfx.kiq.ring_lock);
>> +			up_read(&adev->reset_sem);
>>    			return -ETIME;
>>    		}
>>    
>> @@ -634,9 +637,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>>    		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
>>    		if (r < 1) {
>>    			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
>> +			up_read(&adev->reset_sem);
>>    			return -ETIME;
>>    		}
>> -
>> +		up_read(&adev->reset_sem);
>>    		return 0;
>>    	}
>>    
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
