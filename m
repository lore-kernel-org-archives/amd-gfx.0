Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E730BC282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 14:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C01B10E9FB;
	Fri, 14 Mar 2025 14:22:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nd0S2tov";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 273CB10E9FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 14:22:01 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-390cf7458f5so1747184f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 07:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741962119; x=1742566919; darn=lists.freedesktop.org;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=HaeJX/kAi7qoA7UFDX2BmIlBWr9I9D5gav0fg3t18BQ=;
 b=Nd0S2tov1OQN75QkE8rFjMGwqWAY7U5kyRi0EoCJQN7yLScxS8PBvEE99tUmL8Woum
 u0H41MRF8CK6vA2/mIwcVSLz4zicx9YKwCt5TFJ54uoBpQg+IxlFXj3onpRRghAUHOiH
 jJnwfOcYT9U0aNSh8kSCt3ooqjtHcjn2yP9yVXbuF2vTWcz5pjcmNGly+mq+92YQKDRx
 roioNZn4kO3nIXgmtVxbpRuoy6dTTVOEVDBxeMoVYk0HcDEW9l+It91bmHXtW+KNAw9Q
 g2tEbqv1la8pymGCF3C6zWCxgdSMvYyLJsGmUrYdMV4yfFWx4yPhXk1lMy8Mye7++8Zs
 NqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741962119; x=1742566919;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=HaeJX/kAi7qoA7UFDX2BmIlBWr9I9D5gav0fg3t18BQ=;
 b=MP3J/MQBQyNpBmJvt/0jqLzI3EbnRwH6kkPy1wm4JwnsE4FUmdanSKGeH9/WEq/jcV
 3I2tFA3IEnuyziRxNMACdIDHVIQW7AXPy0TkidlcjQQkrzilEI6zzQ7NNHNZAEOudtOk
 EHgwHxF0hNN6iV2hDVPPwaV6cKxRwttS44Q3yN2VonxtWuLj5oTUtTW0BuLNJD06tzkm
 dOCNsPcrwEPIA5x+Iti+J4+XwE62xQx3r4eYXnoZJkO1Y5dq7/qnSCBkFaZiopj/JUvH
 hWvfSLGc4Ydcw2MchKXLgGnbC8qMQToIs0PnM7M+wHn/suGA+3uD1JQ4OaGS0ExTmqAn
 fXmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAGyWzTY66dAIeBzGl0wg5K7rGqpaHfl2chdhxNDcr/h44g76LORC2LzUudnaUKXOGwlhbLmjJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwpoFEPzf6riycNa2vsccnMa0qG5YMGprFNutjZ8z47VqZwefaU
 Fp00h5sCVAAeTOGVLTRTm9G2cvfSFS92iXQp1Ir2YlwfL+YLt48T
X-Gm-Gg: ASbGncusRxxA1xnv0rO3u3enOZWTImRVGqP8IC61PpFIX55H/gojgRwTnYxLoBDuCOq
 uAq68en9Iw7ti3/C9Poq+KS58wFEaXGFpyfCnsYLPSDdo+KuyDNtSRdblAtQA1FQBvgz2OSU14Q
 RcdFump7xTWUE2fgmTAPAymw166Iqk6qmEnj/gcpDn76/oSUi5HaMp+O4nhj+xPBbzHeQC37E1Y
 mDd5UeJBzALnWa2CWd77IALBACSoA76YhJrGa4iO4s7HvNFagTKDm8wl9vv2/hQ6UlWB1o5ssuz
 5DWAqLN4k3RlpjtYp9MWaQEROZSslKGXZ3OaAQS+d43jBel2ev0CmG5SII2duBRJynBJXsnJ0g=
 =
X-Google-Smtp-Source: AGHT+IECBSNxB2HnDNeJ2LU3nS6bQFBx+FRQicpjxmPDsv+PF0f9QC3TJQXjy2Gf82aL+DZiSmk4Cg==
X-Received: by 2002:a05:6000:4011:b0:391:3124:f287 with SMTP id
 ffacd0b85a97d-3971e2add48mr3387430f8f.16.1741962118883; 
 Fri, 14 Mar 2025 07:21:58 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdc8e9esm10029245e9.1.2025.03.14.07.21.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 07:21:58 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------F0Y9N0nCyPQfG88B7D6mIUUI"
Message-ID: <34f84531-5de5-41ce-a312-412085fe8b3c@gmail.com>
Date: Fri, 14 Mar 2025 15:21:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] drm/amdgpu: rework how the cleaner shader is emitted
 v3
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20250307134816.1422-1-christian.koenig@amd.com>
 <20250307134816.1422-5-christian.koenig@amd.com>
 <efd0f03f-0261-4f57-96db-4dea2063b329@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <efd0f03f-0261-4f57-96db-4dea2063b329@amd.com>
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
--------------F0Y9N0nCyPQfG88B7D6mIUUI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 14.03.25 um 05:24 schrieb SRINIVASAN SHANMUGAM:
> On 3/7/2025 7:18 PM, Christian König wrote:
>> Instead of emitting the cleaner shader for every job which has the
>> enforce_isolation flag set only emit it for the first submission from
>> every client.
>>
>> v2: add missing NULL check
>> v3: fix another NULL pointer deref
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 27 ++++++++++++++++++++------
>>  1 file changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index ef4fe2df8398..dc10bea836db 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -643,6 +643,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>  		    bool need_pipe_sync)
>>  {
>>  	struct amdgpu_device *adev = ring->adev;
>> +	struct amdgpu_isolation *isolation = &adev->isolation[ring->xcp_id];
>>  	unsigned vmhub = ring->vm_hub;
>>  	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>>  	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
>> @@ -650,8 +651,9 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>  	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
>>  		job->gds_switch_needed;
>>  	bool vm_flush_needed = job->vm_needs_flush;
>> -	struct dma_fence *fence = NULL;
>> +	bool cleaner_shader_needed = false;
>>  	bool pasid_mapping_needed = false;
>> +	struct dma_fence *fence = NULL;
>>  	unsigned int patch;
>>  	int r;
>>  
>> @@ -674,8 +676,12 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>  	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
>>  		ring->funcs->emit_wreg;
>>  
>> +	cleaner_shader_needed = adev->gfx.enable_cleaner_shader &&
>> +		ring->funcs->emit_cleaner_shader && job->base.s_fence &&
>> +		&job->base.s_fence->scheduled == isolation->spearhead;

*here*

>> +
>>  	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
>> -	    !(job->enforce_isolation && !job->vmid))
>> +	    !cleaner_shader_needed)
>>  		return 0;
>>  
>>  	amdgpu_ring_ib_begin(ring);
>> @@ -686,9 +692,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>  	if (need_pipe_sync)
>>  		amdgpu_ring_emit_pipeline_sync(ring);
>>  
>> -	if (adev->gfx.enable_cleaner_shader &&
>> -	    ring->funcs->emit_cleaner_shader &&
>> -	    job->enforce_isolation)
>> +	if (cleaner_shader_needed)
>
> Here should we also need to check, for ring->funcs->emit_cleaner_shader?
>

I moved that up to where cleaner_shader_needed is set. See the *here* above.

That makes it easier to decide if we need fence after the preamble or not.

Regards,
Christian.

> if (cleaner_shader_needed && ring->funcs->emit_cleaner_shader)
>
>>  		ring->funcs->emit_cleaner_shader(ring);
>>  
>>  	if (vm_flush_needed) {
>> @@ -710,7 +714,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>  					    job->oa_size);
>>  	}
>>  
>> -	if (vm_flush_needed || pasid_mapping_needed) {
>> +	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
>>  		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
>>  		if (r)
>>  			return r;
>> @@ -732,6 +736,17 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>  		id->pasid_mapping = dma_fence_get(fence);
>>  		mutex_unlock(&id_mgr->lock);
>>  	}
>> +
>> +	/*
>> +	 * Make sure that all other submissions wait for the cleaner shader to
>> +	 * finish before we push them to the HW.
>> +	 */
>> +	if (cleaner_shader_needed) {
>> +		mutex_lock(&adev->enforce_isolation_mutex);
>> +		dma_fence_put(isolation->spearhead);
>> +		isolation->spearhead = dma_fence_get(fence);
>> +		mutex_unlock(&adev->enforce_isolation_mutex);
>> +	}
>>  	dma_fence_put(fence);
>>  
>>  	amdgpu_ring_patch_cond_exec(ring, patch);

--------------F0Y9N0nCyPQfG88B7D6mIUUI
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 14.03.25 um 05:24 schrieb SRINIVASAN SHANMUGAM:<br>
    <blockquote type="cite"
      cite="mid:efd0f03f-0261-4f57-96db-4dea2063b329@amd.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      On 3/7/2025 7:18 PM, Christian König wrote:
      <blockquote type="cite"
        cite="mid:20250307134816.1422-5-christian.koenig@amd.com">
        <pre class="moz-quote-pre" wrap="">Instead of emitting the cleaner shader for every job which has the
enforce_isolation flag set only emit it for the first submission from
every client.

v2: add missing NULL check
v3: fix another NULL pointer deref

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E"
        href="mailto:christian.koenig@amd.com" moz-do-not-send="true">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 27 ++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ef4fe2df8398..dc10bea836db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -643,6 +643,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		    bool need_pipe_sync)
 {
 	struct amdgpu_device *adev = ring-&gt;adev;
+	struct amdgpu_isolation *isolation = &amp;adev-&gt;isolation[ring-&gt;xcp_id];
 	unsigned vmhub = ring-&gt;vm_hub;
 	struct amdgpu_vmid_mgr *id_mgr = &amp;adev-&gt;vm_manager.id_mgr[vmhub];
 	struct amdgpu_vmid *id = &amp;id_mgr-&gt;ids[job-&gt;vmid];
@@ -650,8 +651,9 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool gds_switch_needed = ring-&gt;funcs-&gt;emit_gds_switch &amp;&amp;
 		job-&gt;gds_switch_needed;
 	bool vm_flush_needed = job-&gt;vm_needs_flush;
-	struct dma_fence *fence = NULL;
+	bool cleaner_shader_needed = false;
 	bool pasid_mapping_needed = false;
+	struct dma_fence *fence = NULL;
 	unsigned int patch;
 	int r;
 
@@ -674,8 +676,12 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	pasid_mapping_needed &amp;= adev-&gt;gmc.gmc_funcs-&gt;emit_pasid_mapping &amp;&amp;
 		ring-&gt;funcs-&gt;emit_wreg;
 
+	cleaner_shader_needed = adev-&gt;gfx.enable_cleaner_shader &amp;&amp;
+		ring-&gt;funcs-&gt;emit_cleaner_shader &amp;&amp; job-&gt;base.s_fence &amp;&amp;
+		&amp;job-&gt;base.s_fence-&gt;scheduled == isolation-&gt;spearhead;</pre>
      </blockquote>
    </blockquote>
    <br>
    *here*<br>
    <br>
    <blockquote type="cite"
      cite="mid:efd0f03f-0261-4f57-96db-4dea2063b329@amd.com">
      <blockquote type="cite"
        cite="mid:20250307134816.1422-5-christian.koenig@amd.com">
        <pre class="moz-quote-pre" wrap="">
+
 	if (!vm_flush_needed &amp;&amp; !gds_switch_needed &amp;&amp; !need_pipe_sync &amp;&amp;
-	    !(job-&gt;enforce_isolation &amp;&amp; !job-&gt;vmid))
+	    !cleaner_shader_needed)
 		return 0;
 
 	amdgpu_ring_ib_begin(ring);
@@ -686,9 +692,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (need_pipe_sync)
 		amdgpu_ring_emit_pipeline_sync(ring);
 
-	if (adev-&gt;gfx.enable_cleaner_shader &amp;&amp;
-	    ring-&gt;funcs-&gt;emit_cleaner_shader &amp;&amp;
-	    job-&gt;enforce_isolation)
+	if (cleaner_shader_needed)</pre>
      </blockquote>
      <p>Here should we also need to check, for <span
        style="white-space: pre-wrap">ring-&gt;funcs-&gt;emit_cleaner_shader?</span></p>
    </blockquote>
    <br>
    I moved that up to where cleaner_shader_needed is set. See the
    *here* above.<br>
    <br>
    That makes it easier to decide if we need fence after the preamble
    or not.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:efd0f03f-0261-4f57-96db-4dea2063b329@amd.com">
      <p><span style="white-space: pre-wrap">if (cleaner_shader_needed &amp;&amp; </span><span
        style="white-space: pre-wrap">ring-&gt;funcs-&gt;emit_cleaner_shader)</span></p>
      <blockquote type="cite"
        cite="mid:20250307134816.1422-5-christian.koenig@amd.com">
        <pre class="moz-quote-pre" wrap=""> 		ring-&gt;funcs-&gt;emit_cleaner_shader(ring);
 
 	if (vm_flush_needed) {
@@ -710,7 +714,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 					    job-&gt;oa_size);
 	}
 
-	if (vm_flush_needed || pasid_mapping_needed) {
+	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
 		r = amdgpu_fence_emit(ring, &amp;fence, NULL, 0);
 		if (r)
 			return r;
@@ -732,6 +736,17 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		id-&gt;pasid_mapping = dma_fence_get(fence);
 		mutex_unlock(&amp;id_mgr-&gt;lock);
 	}
+
+	/*
+	 * Make sure that all other submissions wait for the cleaner shader to
+	 * finish before we push them to the HW.
+	 */
+	if (cleaner_shader_needed) {
+		mutex_lock(&amp;adev-&gt;enforce_isolation_mutex);
+		dma_fence_put(isolation-&gt;spearhead);
+		isolation-&gt;spearhead = dma_fence_get(fence);
+		mutex_unlock(&amp;adev-&gt;enforce_isolation_mutex);
+	}
 	dma_fence_put(fence);
 
 	amdgpu_ring_patch_cond_exec(ring, patch);
</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------F0Y9N0nCyPQfG88B7D6mIUUI--
