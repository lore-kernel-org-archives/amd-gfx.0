Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B12C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 10:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5782261073
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 10:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5782261073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3BA46E241;
	Wed, 19 May 2021 10:08:32 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB2A86E241
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 10:08:31 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id s22so18918138ejv.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 03:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=ofoSiiECCxyAstiz5mgfAMbizA6GmH5ZBT/hs+P003I=;
 b=VZgy4CFwJhqQylRJ+eCzN3fJ98m9cjUOFG/3/gos0ffDlf/PC1RRguf79IZ7RkO+u7
 RCQ+AOsb5NOFoSD0HHS/nIC38rnxh9vBBv4c+UMGxnU/Er6Ik1LEydkcNUPqNU7nKbYw
 Sb2AWNqYn7r8WLGsw5bALwRQ5G2TrIhzx14shevYS7RHSK3K9SgJy6MUnNfncZtByzz5
 UrLJL3hwQ57SCr36CWVFDtUshsyGC91u+DyLTCS51bwh1VIjiwVrWu+AO2ufCCArQ+wN
 bkF31sarPp9fB2I/x0Ms8YOe1pV2CMZnDEtmlaYL6QTVJlebTu5obPB2kFrnkfaFyiGy
 DzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ofoSiiECCxyAstiz5mgfAMbizA6GmH5ZBT/hs+P003I=;
 b=CC9eHN2ERUw56+1FWWYRkE2nxqxaYy+leDyoLh2LhyrxsAqu/btuGu9ka/UKNNiOYT
 R1kHMSZL1H4mcTWX/+JVURy6YgbJLn7kVQ2Du0BxWW3Mw2cGmS4D7orrs9pVAiGMT54X
 67/2Z6XvPFwbQdB+9Gcpc7U1/FJLVTOMBSQxiM7haM2MUhrIkwm02znwmY3wWUtqx+Cl
 /azrGEK4PjpgR9NTuUeRkIWPCB7J0sj+XgToUW3lShI24e9doW4ePAWXZrjNbt2wpW0E
 wrm7wGu4TSWpLsVQ6iEaTMUSDkyoVYwMRRGWTlRYdlqacqXsgOCIJTOWJx9HxDXhnQUi
 kg/A==
X-Gm-Message-State: AOAM5309GuLREcwXMMWWoHGuBfbJbekJQOccB3EUF1Bpa9kqo0JdlVNx
 0QgyRZLGsjtEs4bmHVeMXMUEMXNTsjk=
X-Google-Smtp-Source: ABdhPJz7HUsxUddsD+gytkLeK5BxeqN48dXGdxp8JiMxBVxP8PpcRzttoRx3Ate4bqQ3G36IJGWB9g==
X-Received: by 2002:a17:906:2559:: with SMTP id
 j25mr11531484ejb.42.1621418910432; 
 Wed, 19 May 2021 03:08:30 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8e28:1d3:41f3:e15a?
 ([2a02:908:1252:fb60:8e28:1d3:41f3:e15a])
 by smtp.gmail.com with ESMTPSA id p4sm12270859ejr.81.2021.05.19.03.08.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 May 2021 03:08:30 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Increase tlb flush timeout for sriov
To: Chengzhe Liu <ChengZhe.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210519093209.888377-1-ChengZhe.Liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b9d6e51c-b172-9627-799f-937c3e94851a@gmail.com>
Date: Wed, 19 May 2021 12:08:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519093209.888377-1-ChengZhe.Liu@amd.com>
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 19.05.21 um 11:32 schrieb Chengzhe Liu:
> When there is 12 VF, we need to increase the timeout

NAK, 6 seconds is way to long to wait polling on a fence.

Why should an invalidation take that long? The engine are per VF just to 
avoid exactly that problem.

Christian.

>
> Signed-off-by: Chengzhe Liu <ChengZhe.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 6 +++++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 6 +++++-
>   2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index f02dc904e4cf..a5f005c5d0ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -404,6 +404,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   	uint32_t seq;
>   	uint16_t queried_pasid;
>   	bool ret;
> +	uint32_t sriov_usec_timeout = 6000000;  /* wait for 12 * 500ms for SRIOV */
>   	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>   
> @@ -422,7 +423,10 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   
>   		amdgpu_ring_commit(ring);
>   		spin_unlock(&adev->gfx.kiq.ring_lock);
> -		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
> +		if (amdgpu_sriov_vf(adev))
> +			r = amdgpu_fence_wait_polling(ring, seq, sriov_usec_timeout);
> +		else
> +			r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
>   		if (r < 1) {
>   			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
>   			return -ETIME;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index ceb3968d8326..e4a18d8f75c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -857,6 +857,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   	uint32_t seq;
>   	uint16_t queried_pasid;
>   	bool ret;
> +	uint32_t sriov_usec_timeout = 6000000;  /* wait for 12 * 500ms for SRIOV */
>   	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>   
> @@ -896,7 +897,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   
>   		amdgpu_ring_commit(ring);
>   		spin_unlock(&adev->gfx.kiq.ring_lock);
> -		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
> +		if (amdgpu_sriov_vf(adev))
> +			r = amdgpu_fence_wait_polling(ring, seq, sriov_usec_timeout);
> +		else
> +			r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
>   		if (r < 1) {
>   			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
>   			up_read(&adev->reset_sem);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
