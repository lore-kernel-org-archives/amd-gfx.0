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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A286C55ABD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 15:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA58221D7F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 15:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvmRSmqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA58221D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 342BA6E51B;
	Fri, 13 Nov 2020 15:42:32 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 848F66E51B
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 15:42:31 +0000 (UTC)
Received: by mail-ej1-x643.google.com with SMTP id f23so14120772ejk.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 07:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=n+1b4qTTV5FA5YQnTvQWP8xlb8orZ5K92U75WD4Ap2U=;
 b=mvmRSmqNsOKXlzMFZadBgiMqBHylyeKVeGwXXQQjinIxTrMf7x4Dlt4DlGl1T2s4hO
 WCwOQWLHkguFGzpT2g5uIgGqRqe8I5SiVZbuOjXm8qykr2H+V/EJNffnxZiPtAOUbzI2
 /shMdPhrNqXes58oC/7YosNHSy9eEeWsCiS5AUeINJBuY/i9rkNJi4Ru72wNW8rY3oc+
 0EOqwshmUUMCRCnA0fITVpqh5vfs6buEo7LDvxbxS0lfYsIWv3A0+Wq5siMks0SFnodO
 pXthg6mixMLgqQ2YDNdsHsNPZ94GmXdXqtH6iLFnsF2B6jUJQ6HrDLH+78MbC/Co8Ewr
 k7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=n+1b4qTTV5FA5YQnTvQWP8xlb8orZ5K92U75WD4Ap2U=;
 b=DDyLzckEToPIFB913VTvixcb/WfOLS2Jq2u4nvElPzim0+CxqhxA8BiNEjitgKPBuf
 nI3tCzV4zo0W4lWLEMNiDO7SjuKNEdHSjx8HjgCZp+g0N+gqqXXi0GS4DQZuR0FYc2vg
 Iq36FXSu6pLjwn1wHPPzTK8D7s925BAyvTdDUpPcu51UJVDYN1f5S+kI2keXQ27ECqVA
 rYO5vn9twc8sdOIUuOKjiGuQlLBC2tbHL0fijpgPOUDpwDICD5vLuSgRjdNDNAH0Rv0T
 jEqgGltsJwLDDTt+DS7PyJ97jIC7kFY6nXhUDPA8md8ARa8cNWEQ0FM4rNKFQ9Eepx+3
 nZ3g==
X-Gm-Message-State: AOAM5316fkud35OTbLqOgBRUSCHkH1sskdDkd/lKAl3biFmTzNYdr7E7
 WmgL9MksXOeZohmRNOyoV3b/AWySjmQ=
X-Google-Smtp-Source: ABdhPJxE6Ask8qRJTY2Ye2B0vBC1dklVt8fBWmOIyIzAx33ZO6ufx/S172TZvyzWiZ19i8iQUiUarQ==
X-Received: by 2002:a17:906:a195:: with SMTP id
 s21mr2379905ejy.146.1605282145046; 
 Fri, 13 Nov 2020 07:42:25 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id p1sm3896578ejd.33.2020.11.13.07.42.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2020 07:42:24 -0800 (PST)
Subject: Re: [PATCH 3/5] drm/amdgpu/vcn: add test for dec vcn software ring
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1605133674-21093-1-git-send-email-James.Zhu@amd.com>
 <1605133674-21093-3-git-send-email-James.Zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ecb72db6-aee8-6e97-1602-cec8bf314d29@gmail.com>
Date: Mon, 16 Nov 2020 12:42:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1605133674-21093-3-git-send-email-James.Zhu@amd.com>
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

Am 11.11.20 um 23:27 schrieb James Zhu:
> Add vcn software ring decode ring test and decode ib test.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Reviewed-by: Leo Liu <leo.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 138 ++++++++++++++++++++++++++++++--
>   1 file changed, 132 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 7e19a66..e3d54fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -456,6 +456,37 @@ int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
>   	return r;
>   }
>   
> +int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	uint32_t rptr;
> +	unsigned int i;
> +	int r;
> +
> +	if (amdgpu_sriov_vf(adev))
> +		return 0;
> +
> +	r = amdgpu_ring_alloc(ring, 16);
> +	if (r)
> +		return r;
> +
> +	rptr = amdgpu_ring_get_rptr(ring);
> +
> +	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_END);
> +	amdgpu_ring_commit(ring);
> +
> +	for (i = 0; i < adev->usec_timeout; i++) {
> +		if (amdgpu_ring_get_rptr(ring) != rptr)
> +			break;
> +		udelay(1);
> +	}
> +
> +	if (i >= adev->usec_timeout)
> +		r = -ETIMEDOUT;
> +
> +	return r;
> +}
> +
>   static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>   				   struct amdgpu_bo *bo,
>   				   struct dma_fence **fence)
> @@ -510,7 +541,10 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>   }
>   
>   static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> -			      struct dma_fence **fence)
> +			      struct dma_fence **fence,
> +			      int (*send_msg)(struct amdgpu_ring *,
> +	                              struct amdgpu_bo *,
> +	                              struct dma_fence **))
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	struct amdgpu_bo *bo = NULL;
> @@ -540,13 +574,17 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   	for (i = 14; i < 1024; ++i)
>   		msg[i] = cpu_to_le32(0x0);
>   
> -	return amdgpu_vcn_dec_send_msg(ring, bo, fence);
> +	return send_msg(ring, bo, fence);
>   }
>   
>   static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
> -			       struct dma_fence **fence)
> +			      struct dma_fence **fence,
> +			      int (*send_msg)(struct amdgpu_ring *,
> +	                              struct amdgpu_bo *,
> +	                              struct dma_fence **))
>   {
>   	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_send_msg *dec;
>   	struct amdgpu_bo *bo = NULL;
>   	uint32_t *msg;
>   	int r, i;
> @@ -566,19 +604,107 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   	for (i = 6; i < 1024; ++i)
>   		msg[i] = cpu_to_le32(0x0);
>   
> -	return amdgpu_vcn_dec_send_msg(ring, bo, fence);
> +	return send_msg(ring, bo, fence);

You can avoid the send_msg parameter altogether by just doing this in 
the caller of the function.

Christian.

>   }
>   
>   int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
> +	struct amdgpu_device *adev = ring->adev;
>   	struct dma_fence *fence;
>   	long r;
>   
> -	r = amdgpu_vcn_dec_get_create_msg(ring, 1, NULL);
> +	r = amdgpu_vcn_dec_get_create_msg(ring, 1, NULL,
> +				amdgpu_vcn_dec_send_msg);
> +	if (r)
> +		goto error;
> +
> +	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &fence,
> +				amdgpu_vcn_dec_send_msg);
> +	if (r)
> +		goto error;
> +
> +	r = dma_fence_wait_timeout(fence, false, timeout);
> +	if (r == 0)
> +		r = -ETIMEDOUT;
> +	else if (r > 0)
> +		r = 0;
> +
> +	dma_fence_put(fence);
> +error:
> +	return r;
> +}
> +
> +static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
> +				   struct amdgpu_bo *bo,
> +				   struct dma_fence **fence)
> +{
> +	struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
> +	const unsigned int ib_size_dw = 64;
> +	struct amdgpu_device *adev = ring->adev;
> +	struct dma_fence *f = NULL;
> +	struct amdgpu_job *job;
> +	struct amdgpu_ib *ib;
> +	uint64_t addr;
> +	int i, r;
> +
> +	r = amdgpu_job_alloc_with_ib(adev, ib_size_dw * 4,
> +				AMDGPU_IB_POOL_DIRECT, &job);
> +	if (r)
> +		goto err;
> +
> +	ib = &job->ibs[0];
> +	addr = amdgpu_bo_gpu_offset(bo);
> +	ib->length_dw = 0;
> +
> +	ib->ptr[ib->length_dw++] = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
> +	ib->ptr[ib->length_dw++] = cpu_to_le32(AMDGPU_VCN_IB_FLAG_DECODE_BUFFER);
> +	decode_buffer = (struct amdgpu_vcn_decode_buffer *)&(ib->ptr[ib->length_dw]);
> +	ib->length_dw += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
> +	memset(decode_buffer, 0, sizeof(struct amdgpu_vcn_decode_buffer));
> +
> +	decode_buffer->valid_buf_flag |= cpu_to_le32(AMDGPU_VCN_CMD_FLAG_MSG_BUFFER);
> +	decode_buffer->msg_buffer_address_hi = cpu_to_le32(addr >> 32);
> +	decode_buffer->msg_buffer_address_lo = cpu_to_le32(addr);
> +
> +	for (i = ib->length_dw; i < ib_size_dw; ++i)
> +		ib->ptr[i] = 0x0;
> +
> +	r = amdgpu_job_submit_direct(job, ring, &f);
> +	if (r)
> +		goto err_free;
> +
> +	amdgpu_bo_fence(bo, f, false);
> +	amdgpu_bo_unreserve(bo);
> +	amdgpu_bo_unref(&bo);
> +
> +	if (fence)
> +		*fence = dma_fence_get(f);
> +	dma_fence_put(f);
> +
> +	return 0;
> +
> +err_free:
> +	amdgpu_job_free(job);
> +
> +err:
> +	amdgpu_bo_unreserve(bo);
> +	amdgpu_bo_unref(&bo);
> +	return r;
> +}
> +
> +int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct dma_fence *fence = NULL;
> +	long r;
> +
> +	r = amdgpu_vcn_dec_get_create_msg(ring, 1, NULL,
> +				amdgpu_vcn_dec_sw_send_msg);
>   	if (r)
>   		goto error;
>   
> -	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &fence);
> +	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &fence,
> +				amdgpu_vcn_dec_sw_send_msg);
>   	if (r)
>   		goto error;
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
