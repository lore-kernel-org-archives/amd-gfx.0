Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120EAD74964
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 08:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B5710EC7F;
	Fri, 19 Dec 2025 08:40:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="sZTUwdI/";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1B6610EC7F
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 08:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jou2I+XmQxvVnzwcDzSNsdM1xGo48BRxOXM7uqEfMCw=; b=sZTUwdI/krcpULZ+1/88BH5JQM
 X5CYIDC9f5RPMlxEdaztv3Anj2A3QrbfLpq2SvPl8TFxFA27YGtXiohkt3d+esEkNIj2oOscSpHBi
 zEJ+cHH5Jzmm2690D13sRcY9tk05WQ2Y2nBN4XFaQoo+gqKxAueCkhFDvhbWhskBkILnFGLnyMEiX
 mIVnWag+IIMdUBtYiv3D3gYfOzQrEZq4M9o9/YQOWAEQW0TlrQGmCgCRBVQV+hlfmSpnWIeqLPXqR
 Xq7IUwc741fRCtmtNww5oHaqbxOF1+TSqu2unoDy8FP8qIWhYoh6J05x5sAzMT9X14LkT1fs6d+O2
 +jb2kq2A==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1vWW1j-00EYau-5n; Fri, 19 Dec 2025 09:39:55 +0100
Message-ID: <6d84c467-f401-4460-8cf6-62c5fab341c3@igalia.com>
Date: Fri, 19 Dec 2025 08:39:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/5] drm/amdgpu/mes: Remove idr leftovers
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251218150405.80502-1-tvrtko.ursulin@igalia.com>
 <20251218150405.80502-6-tvrtko.ursulin@igalia.com>
 <164893d3-e8dd-4a39-998c-bdb7a328168d@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <164893d3-e8dd-4a39-998c-bdb7a328168d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 19/12/2025 08:29, Christian König wrote:
> 
> 
> On 12/18/25 16:04, Tvrtko Ursulin wrote:
>> Commit
>> cb17fff3a254 ("drm/amdgpu/mes: remove unused functions")
>> removed most of the code using these IDRs but forgot to remove the struct
>> members and init/destroy paths.
>>
>> There is also interrupt handling code in SDMA 5.0 and 5.2 which appears to
>> be using it, but is is unreachable since nothing ever allocates the
>> relevant IDR. We replace those with one time warnings just to avoid any
>> functional difference, but it is also possible they should be removed.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> References: cb17fff3a254 ("drm/amdgpu/mes: remove unused functions")
>> Cc: Alex Deucher <alexander.deucher@amd.com>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>

Thanks!

Do you think the drm_WARN_ON_ONCE's are worth keeping or I should remove 
that completely? I wasn't sure if there is a code path or not to enable 
the required condition:

  adev->enable_mes && (entry->src_data[0] & AMDGPU_FENCE_MES_QUEUE_FLAG))

If there is interrupts would get silently not processed. Although that 
is currently in the code as well. Maybe it is impossible?

Regards,

Tvrtko

> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  9 ---------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 ---
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c  | 18 +++---------------
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c  | 18 +++---------------
>>   4 files changed, 6 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index 9c182ce501af..505619d504ea 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -94,9 +94,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>   
>>   	adev->mes.adev = adev;
>>   
>> -	idr_init(&adev->mes.pasid_idr);
>> -	idr_init(&adev->mes.gang_id_idr);
>> -	idr_init(&adev->mes.queue_id_idr);
>>   	ida_init(&adev->mes.doorbell_ida);
>>   	spin_lock_init(&adev->mes.queue_id_lock);
>>   	mutex_init(&adev->mes.mutex_hidden);
>> @@ -218,9 +215,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>   				      adev->mes.query_status_fence_offs[i]);
>>   	}
>>   
>> -	idr_destroy(&adev->mes.pasid_idr);
>> -	idr_destroy(&adev->mes.gang_id_idr);
>> -	idr_destroy(&adev->mes.queue_id_idr);
>>   	ida_destroy(&adev->mes.doorbell_ida);
>>   	mutex_destroy(&adev->mes.mutex_hidden);
>>   	return r;
>> @@ -248,9 +242,6 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>>   
>>   	amdgpu_mes_doorbell_free(adev);
>>   
>> -	idr_destroy(&adev->mes.pasid_idr);
>> -	idr_destroy(&adev->mes.gang_id_idr);
>> -	idr_destroy(&adev->mes.queue_id_idr);
>>   	ida_destroy(&adev->mes.doorbell_ida);
>>   	mutex_destroy(&adev->mes.mutex_hidden);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> index e989225b354b..f45129277479 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> @@ -68,9 +68,6 @@ struct amdgpu_mes {
>>   
>>   	struct mutex                    mutex_hidden;
>>   
>> -	struct idr                      pasid_idr;
>> -	struct idr                      gang_id_idr;
>> -	struct idr                      queue_id_idr;
>>   	struct ida                      doorbell_ida;
>>   
>>   	spinlock_t                      queue_id_lock;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> index 8ddc4df06a1f..ab9e6199b01d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> @@ -1704,24 +1704,12 @@ static int sdma_v5_0_process_trap_irq(struct amdgpu_device *adev,
>>   				      struct amdgpu_irq_src *source,
>>   				      struct amdgpu_iv_entry *entry)
>>   {
>> -	uint32_t mes_queue_id = entry->src_data[0];
>> -
>>   	DRM_DEBUG("IH: SDMA trap\n");
>>   
>> -	if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FLAG)) {
>> -		struct amdgpu_mes_queue *queue;
>> -
>> -		mes_queue_id &= AMDGPU_FENCE_MES_QUEUE_ID_MASK;
>> -
>> -		spin_lock(&adev->mes.queue_id_lock);
>> -		queue = idr_find(&adev->mes.queue_id_idr, mes_queue_id);
>> -		if (queue) {
>> -			DRM_DEBUG("process smda queue id = %d\n", mes_queue_id);
>> -			amdgpu_fence_process(queue->ring);
>> -		}
>> -		spin_unlock(&adev->mes.queue_id_lock);
>> +	if (drm_WARN_ON_ONCE(&adev->ddev,
>> +			     adev->enable_mes &&
>> +			     (entry->src_data[0] & AMDGPU_FENCE_MES_QUEUE_FLAG)))
>>   		return 0;
>> -	}
>>   
>>   	switch (entry->client_id) {
>>   	case SOC15_IH_CLIENTID_SDMA0:
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> index 51101b0aa2fa..4f78dd93939c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> @@ -1617,24 +1617,12 @@ static int sdma_v5_2_process_trap_irq(struct amdgpu_device *adev,
>>   				      struct amdgpu_irq_src *source,
>>   				      struct amdgpu_iv_entry *entry)
>>   {
>> -	uint32_t mes_queue_id = entry->src_data[0];
>> -
>>   	DRM_DEBUG("IH: SDMA trap\n");
>>   
>> -	if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FLAG)) {
>> -		struct amdgpu_mes_queue *queue;
>> -
>> -		mes_queue_id &= AMDGPU_FENCE_MES_QUEUE_ID_MASK;
>> -
>> -		spin_lock(&adev->mes.queue_id_lock);
>> -		queue = idr_find(&adev->mes.queue_id_idr, mes_queue_id);
>> -		if (queue) {
>> -			DRM_DEBUG("process smda queue id = %d\n", mes_queue_id);
>> -			amdgpu_fence_process(queue->ring);
>> -		}
>> -		spin_unlock(&adev->mes.queue_id_lock);
>> +	if (drm_WARN_ON_ONCE(&adev->ddev,
>> +			     adev->enable_mes &&
>> +			     (entry->src_data[0] & AMDGPU_FENCE_MES_QUEUE_FLAG)))
>>   		return 0;
>> -	}
>>   
>>   	switch (entry->client_id) {
>>   	case SOC15_IH_CLIENTID_SDMA0:
> 

