Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D28C282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 14:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D66510E984;
	Fri, 14 Mar 2025 14:15:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U+KZGpYz";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED66D10E984
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 14:15:09 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso19576545e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 07:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741961708; x=1742566508; darn=lists.freedesktop.org;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=tWcEyeXI96OLM4BNDtKO43SNPKt0DrOWxAnFhzmi0Fs=;
 b=U+KZGpYz7uoq1+Yy95hsabgYfBFdQKth8fIZTNkLlbsp0bqmcDSEX7rPUnjtJGuw2z
 TGSXx8jTvYjnzUwrRlRcsWcVMH0GCfhCWhTQoBat658fiMOTljZX6Legv2RZrPBd9SQ8
 uNVYhUgTcu0s5vqhrWNcyvGRMpm1q+YAHXQdzoHJtf2sBIJcs8EXd8z/EhlmFe8wiUKp
 F8canuEXgEn/TF7AgPpB5yeMJOILgJeXWYjEXU5ZnwqIoDem11ruEq4b5+LHUSNypPLw
 RldrXfmqpmR2G+s1dT68URXbW3kuTQPg+5G1Ezax54BWcN5TIUiJYqWL2S/Mfr5s1zfh
 IMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741961708; x=1742566508;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tWcEyeXI96OLM4BNDtKO43SNPKt0DrOWxAnFhzmi0Fs=;
 b=HqEV0TVHJ2iZIjU+5TpMmd6N0kBUaKCB/DBLd60qu0GtHoyk3T+8wAnFL5ef8w3Sq2
 ysEO7cyMC7qQQM/u5DWf96gKKiE3ccTBwaZYbB/mmH0swuh3pvRK3zzEkhS6iYCd1qR7
 Bmdgf757FHdiEBGHuQ2PPQQ58a6zqmTxHNuc0j3rGuqlCj+TkUpoN2KgCdwkaKOQdFwW
 Xo5IzmJzW5lYYKSnEIARokZvztMyxKpwPz8AJZRwa/UfB/NZ4ihZM+S2fAIzUp6YVugW
 MJ8KOdE/1gCUokHWHt1V7tkJnchEFiHV1O535Xwjn29w03oWCunT6bBCyWEuUQ224azz
 PaKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBsPuXR+mwZYWS23+wqn7R9Geev7OELhTQYBfwkC0e+0J99hV4pzVa/al/z+XVF+QA1qRgvNmm@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQxq/kL9vDmFhe1yQ5GcxNrHB0p6gmolad9j3Ax3Pplr+YR4Kh
 GnJAsZ2DwpTdzFFcogpefaisz7soTD5lQip39Zxm8lZZwhNnlE5adHCFIORK
X-Gm-Gg: ASbGncsMuEtunMIQE6D0BfpGVU6jhFe7SSbxGpU9OJdqJ6YzA/6B5qZgVa9gtXmLRqE
 B/VAeZLnUlqaTzXlRGG0esGUI/rO0l5nf5m1IrCOwKEPKaCUaMK0pzHDg1kXS0UiA0JbiNgp9OW
 CxhMSgxdwt5F/DrrOfHLVhu44iY49HNP06ey9DuETj0DDX3/vuvkWVztoRdg/4GG8o4RftpXkUs
 fLK5zi9c/ynyxA4iuYIPiEV5tEraxWbyYWn5wyPJZEyQcqssjF6n0EfWX05T/7XisJKrMN6MlW8
 /2CcbNv6C4yTcH/IRjbHSU1s6Ooyh9raZfAPjZVVEJYhz5p/hw+GdpPYnfaoMu/ip7Mu+29EDQ=
 =
X-Google-Smtp-Source: AGHT+IFh4Ql+oRLqeVb0xDdRMwfcHoAh2UTMmwonFvzTemxuF5KV2e/vUn/2KsA4flZmf4lA+Bz5+w==
X-Received: by 2002:a05:600c:314b:b0:43c:fbbf:7bf1 with SMTP id
 5b1f17b1804b1-43d1ecd894fmr36622135e9.30.1741961707876; 
 Fri, 14 Mar 2025 07:15:07 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe524ccsm18837875e9.0.2025.03.14.07.15.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 07:15:07 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------rPS2v0AvK4xUn9QWTkxeKMTv"
Message-ID: <f2956e7e-0c56-4ab7-a7b7-383282c0911d@gmail.com>
Date: Fri, 14 Mar 2025 15:15:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] drm/amdgpu: stop reserving VMIDs to enforce isolation
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20250307134816.1422-1-christian.koenig@amd.com>
 <20250307134816.1422-6-christian.koenig@amd.com>
 <f42ac493-af98-468b-912d-af4b9f821449@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <f42ac493-af98-468b-912d-af4b9f821449@amd.com>
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

This is a multi-part message in MIME format.
--------------rPS2v0AvK4xUn9QWTkxeKMTv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 12.03.25 um 16:10 schrieb SRINIVASAN SHANMUGAM:
> On 3/7/2025 7:18 PM, Christian König wrote:
>> That was quite troublesome for gang submit. Completely drop this
>> approach and enforce the isolation separately.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  2 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  9 +--------
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 11 +++--------
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  3 +--
>>  4 files changed, 6 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index 2ce0c6a152a6..4375e5019418 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -1111,7 +1111,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>>  			struct drm_gpu_scheduler *sched = entity->rq->sched;
>>  			struct amdgpu_ring *ring = to_amdgpu_ring(sched);
>>  
>> -			if (amdgpu_vmid_uses_reserved(adev, vm, ring->vm_hub))
>> +			if (amdgpu_vmid_uses_reserved(vm, ring->vm_hub))
>>  				return -EINVAL;
>>  		}
>>  	}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index a194bf3347cb..9e5f6b11d923 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -1665,15 +1665,8 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
>>  	}
>>  
>>  	mutex_lock(&adev->enforce_isolation_mutex);
>> -	for (i = 0; i < num_partitions; i++) {
>> -		if (adev->enforce_isolation[i] && !partition_values[i])
>> -			/* Going from enabled to disabled */
>> -			amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(i));
>> -		else if (!adev->enforce_isolation[i] && partition_values[i])
>> -			/* Going from disabled to enabled */
>> -			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
>> +	for (i = 0; i < num_partitions; i++)
>>  		adev->enforce_isolation[i] = partition_values[i];
>> -	}
>>  	mutex_unlock(&adev->enforce_isolation_mutex);
>>  
>>  	amdgpu_mes_update_enforce_isolation(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> index 92ab821afc06..4c4e087230ac 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> @@ -411,7 +411,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>>  	if (r || !idle)
>>  		goto error;
>>  
>> -	if (amdgpu_vmid_uses_reserved(adev, vm, vmhub)) {
>> +	if (amdgpu_vmid_uses_reserved(vm, vmhub)) {
>>  		r = amdgpu_vmid_grab_reserved(vm, ring, job, &id, fence);
>>  		if (r || !id)
>>  			goto error;
>> @@ -464,19 +464,14 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>>  
>>  /*
>>   * amdgpu_vmid_uses_reserved - check if a VM will use a reserved VMID
>> - * @adev: amdgpu_device pointer
>>   * @vm: the VM to check
>>   * @vmhub: the VMHUB which will be used
>>   *
>>   * Returns: True if the VM will use a reserved VMID.
>>   */
>> -bool amdgpu_vmid_uses_reserved(struct amdgpu_device *adev,
>> -			       struct amdgpu_vm *vm, unsigned int vmhub)
>> +bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)
>>  {
>> -	return vm->reserved_vmid[vmhub] ||
>> -		(adev->enforce_isolation[(vm->root.bo->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
>> -					 vm->root.bo->xcp_id : 0] &&
>> -		 AMDGPU_IS_GFXHUB(vmhub));
>> +	return vm->reserved_vmid[vmhub];
>>  }
>>  
>>  int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>> index 4012fb2dd08a..240fa6751260 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>> @@ -78,8 +78,7 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,
>>  
>>  bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
>>  			       struct amdgpu_vmid *id);
>> -bool amdgpu_vmid_uses_reserved(struct amdgpu_device *adev,
>> -			       struct amdgpu_vm *vm, unsigned int vmhub);
>> +bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub);
>>  int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
>>  				unsigned vmhub);
>>  void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
> here we are trying to remove process isolation based on VMID's  this is because the constraints that we have limited number of vimids, that could be assigned to limited number of clients, now we have switched one level above, that is rather than enforcing isolation on client VMID's , we are directly applying enforce_isolation onto clients, but not on client's vmids,?

Exactly that, yes. We basically separate the two features.

> so based on my this understanding we have removed the enforce_isolation based on vmids in this patch6 & now we are doing process isolation directly on client based on https://patchwork.freedesktop.org/patch/638081/?series=145031&rev=1 <https://patchwork.freedesktop.org/patch/638081/?series=145031&rev=1> ie., based on patch4
> [4/8] drm/amdgpu: rework how isolation is enforced v2, we are doing process isolation directly based on first client ie., based on who is the first client or first owner & then after completing all jobs wrt first client or owner , then it is switched to second client or next owner? is my understanding is right please? ie., based on "amdgpu_device_enforce_isolation()" function

Yes, exactly that.

Regards,
Christian.


--------------rPS2v0AvK4xUn9QWTkxeKMTv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 12.03.25 um 16:10 schrieb SRINIVASAN SHANMUGAM:<br>
    <blockquote type="cite"
      cite="mid:f42ac493-af98-468b-912d-af4b9f821449@amd.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      On 3/7/2025 7:18 PM, Christian König wrote:
      <blockquote type="cite"
        cite="mid:20250307134816.1422-6-christian.koenig@amd.com">
        <pre class="moz-quote-pre" wrap="">That was quite troublesome for gang submit. Completely drop this
approach and enforce the isolation separately.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E"
        href="mailto:christian.koenig@amd.com" moz-do-not-send="true">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  9 +--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 11 +++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  3 +--
 4 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 2ce0c6a152a6..4375e5019418 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1111,7 +1111,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 			struct drm_gpu_scheduler *sched = entity-&gt;rq-&gt;sched;
 			struct amdgpu_ring *ring = to_amdgpu_ring(sched);
 
-			if (amdgpu_vmid_uses_reserved(adev, vm, ring-&gt;vm_hub))
+			if (amdgpu_vmid_uses_reserved(vm, ring-&gt;vm_hub))
 				return -EINVAL;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a194bf3347cb..9e5f6b11d923 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1665,15 +1665,8 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
 	}
 
 	mutex_lock(&amp;adev-&gt;enforce_isolation_mutex);
-	for (i = 0; i &lt; num_partitions; i++) {
-		if (adev-&gt;enforce_isolation[i] &amp;&amp; !partition_values[i])
-			/* Going from enabled to disabled */
-			amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(i));
-		else if (!adev-&gt;enforce_isolation[i] &amp;&amp; partition_values[i])
-			/* Going from disabled to enabled */
-			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
+	for (i = 0; i &lt; num_partitions; i++)
 		adev-&gt;enforce_isolation[i] = partition_values[i];
-	}
 	mutex_unlock(&amp;adev-&gt;enforce_isolation_mutex);
 
 	amdgpu_mes_update_enforce_isolation(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 92ab821afc06..4c4e087230ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -411,7 +411,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 	if (r || !idle)
 		goto error;
 
-	if (amdgpu_vmid_uses_reserved(adev, vm, vmhub)) {
+	if (amdgpu_vmid_uses_reserved(vm, vmhub)) {
 		r = amdgpu_vmid_grab_reserved(vm, ring, job, &amp;id, fence);
 		if (r || !id)
 			goto error;
@@ -464,19 +464,14 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 
 /*
  * amdgpu_vmid_uses_reserved - check if a VM will use a reserved VMID
- * @adev: amdgpu_device pointer
  * @vm: the VM to check
  * @vmhub: the VMHUB which will be used
  *
  * Returns: True if the VM will use a reserved VMID.
  */
-bool amdgpu_vmid_uses_reserved(struct amdgpu_device *adev,
-			       struct amdgpu_vm *vm, unsigned int vmhub)
+bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)
 {
-	return vm-&gt;reserved_vmid[vmhub] ||
-		(adev-&gt;enforce_isolation[(vm-&gt;root.bo-&gt;xcp_id != AMDGPU_XCP_NO_PARTITION) ?
-					 vm-&gt;root.bo-&gt;xcp_id : 0] &amp;&amp;
-		 AMDGPU_IS_GFXHUB(vmhub));
+	return vm-&gt;reserved_vmid[vmhub];
 }
 
 int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index 4012fb2dd08a..240fa6751260 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -78,8 +78,7 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,
 
 bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
 			       struct amdgpu_vmid *id);
-bool amdgpu_vmid_uses_reserved(struct amdgpu_device *adev,
-			       struct amdgpu_vm *vm, unsigned int vmhub);
+bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub);
 int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
 				unsigned vmhub);
 void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,</pre>
      </blockquote>
      <span data-teams="true">here we are trying to remove process
        isolation based on VMID's  this is because the constraints that
        we have limited number of vimids, that could be assigned to
        limited number of clients, now we have switched one level above,
        that is rather than enforcing isolation on client VMID's , we
        are directly applying enforce_isolation onto clients, but not on
        client's vmids,?</span></blockquote>
    <br>
    Exactly that, yes. We basically separate the two features.<br>
    <br>
    <blockquote type="cite"
      cite="mid:f42ac493-af98-468b-912d-af4b9f821449@amd.com"><span
        data-teams="true"> so based on my this understanding we have
        removed the enforce_isolation based on vmids in this patch6
        &amp; now we are doing process isolation directly on client
        based on <a
aria-label="Link https://patchwork.freedesktop.org/patch/638081/?series=145031&amp;rev=1"
          id="menurlkr"
href="https://patchwork.freedesktop.org/patch/638081/?series=145031&amp;rev=1"
          rel="noreferrer noopener" target="_blank"
class="fui-Link ___1q1shib f2hkw1w f3rmtva f1ewtqcl fyind8e f1k6fduh f1w7gpdv fk6fouc fjoy568 figsok6 f1s184ao f1mk8lai fnbmjn9 f1o700av f13mvf36 f1cmlufx f9n3di6 f1ids18y f1tx3yz7 f1deo86v f1eh06m1 f1iescvh fhgqx19 f1olyrje f1p93eir f1nev41a f1h8hb77 f1lqvz6u f10aw75t fsle3fq f17ae5zn"
title="https://patchwork.freedesktop.org/patch/638081/?series=145031&amp;rev=1"
          moz-do-not-send="true">https://patchwork.freedesktop.org/patch/638081/?series=145031&amp;rev=1</a>
        ie., based on patch4<br>
        [4/8] drm/amdgpu: rework how isolation is enforced v2, we are
        doing process isolation directly based on first client ie.,
        based on who is the first client or first owner &amp; then after
        completing all jobs wrt first client or owner , then it is
        switched to second client or next owner? is my understanding is
        right please? ie., based on "amdgpu_device_enforce_isolation()"
        function</span>
      <blockquote type="cite"
        cite="mid:20250307134816.1422-6-christian.koenig@amd.com"> </blockquote>
    </blockquote>
    <br>
    Yes, exactly that.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <br>
  </body>
</html>

--------------rPS2v0AvK4xUn9QWTkxeKMTv--
