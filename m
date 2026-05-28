Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4ACCD4F54
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 12:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6329C10F0BF;
	Thu, 28 May 2026 12:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="aaktEahp";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 509E010F0BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 12:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dihau0MwzW5himg4xDjH/pWPhr3AwFALPjR7Cz2P5eE=; b=aaktEahpWkwS5qSf4wco3htZl6
 nbZrdJg4gRPysLvUG5ljxxxQSZHRrj0Rph03FNLHpj6LeNmLpwk0XCfVAXvpqsC0CDg6vRe1JEgL6
 pw98YDTHxcYQ6YURtusdwCnsff/HH9POSMR3z1ztktrVZyVUARlTevcxTq5jCw9fle7uvehQZiASO
 Gs5FeAV1Kfs5lp3nhlSONS6rxOVg2ajivlojvKpnc/RiG+7SqFA8DZCu07EJTYuF08Kjt7Vk9Nexk
 HrAHQVpNef8KjKSUYAfa5Ox6L+A7YCqpYFiISPLLjO2N0hFxJGt/rTwmYaMaWZ0NKx7RX3LsCtg4V
 rufra88w==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wSZXR-009M20-Hu; Thu, 28 May 2026 14:08:37 +0200
Message-ID: <31a60cdf-efe0-4bf7-bf27-42ca61053ef7@igalia.com>
Date: Thu, 28 May 2026 13:08:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/5] drm/amdgpu: Add a reserved VM ID query
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260526160630.35562-1-tvrtko.ursulin@igalia.com>
 <20260526160630.35562-3-tvrtko.ursulin@igalia.com>
 <a7dad5d3-57ed-4b71-8503-f56f315dcd0d@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <a7dad5d3-57ed-4b71-8503-f56f315dcd0d@amd.com>
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


On 27/05/2026 11:35, Christian König wrote:
> On 5/26/26 18:06, Tvrtko Ursulin wrote:
>> Add a new query (AMDGPU_VM_OP_QUERY_RESERVED_VMID) to the
>> DRM_IOCTL_AMDGPU_VM ioctl.
>>
>> This is required for the checkpoint and restore to be able to correctly
>> restore the client VM.
> 
> Well that's a complete corner cases for SPM. Why have you implemented that?

I wasn't sure what are the use cases but have just saw some low hanging 
uapi which can be easily handled. Now that you raised it, and I read 
about on the history of the feature, I agree it is not interesting to 
checkpoint and restore things under performance profiling. :)

> On the other hand the patch looks good, so we can probably keep it like it is.

Thanks, but if I don't hear otherwise I will drop it from a future 
re-spin since it really does sound like noise now.

Regards,

Tvrtko

>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++++
>>   include/uapi/drm/amdgpu_drm.h          | 5 ++++-
>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 9ba9de16a27a..ce068e2d32d3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2942,6 +2942,10 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>   	case AMDGPU_VM_OP_UNRESERVE_VMID:
>>   		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
>>   		break;
>> +	case AMDGPU_VM_OP_QUERY_RESERVED_VMID:
>> +		if (vm->reserved_vmid[AMDGPU_GFXHUB(0)])
>> +			args->out.flags = AMDGPU_VM_OUT_FLAG_VMID_RESERVED;
>> +		break;
>>   	default:
>>   		return -EINVAL;
>>   	}
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index 3069560ac26e..8a6f4c558102 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -587,6 +587,7 @@ struct drm_amdgpu_userq_wait {
>>   /* vm ioctl */
>>   #define AMDGPU_VM_OP_RESERVE_VMID	1
>>   #define AMDGPU_VM_OP_UNRESERVE_VMID	2
>> +#define AMDGPU_VM_OP_QUERY_RESERVED_VMID	3
>>   
>>   struct drm_amdgpu_vm_in {
>>   	/** AMDGPU_VM_OP_* */
>> @@ -594,8 +595,10 @@ struct drm_amdgpu_vm_in {
>>   	__u32	flags;
>>   };
>>   
>> +/* drm_amdgpu_vm_out flags */
>> +#define AMDGPU_VM_OUT_FLAG_VMID_RESERVED	(1ul << 63)
>> +
>>   struct drm_amdgpu_vm_out {
>> -	/** For future use, no flags defined so far */
>>   	__u64	flags;
>>   };
>>   
> 

