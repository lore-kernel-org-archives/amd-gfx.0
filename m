Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0740CC10F16
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 07:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D70511288D;
	Fri,  3 May 2024 07:50:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Vvi51ydA";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E4E1123E9
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 14:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CH0ajVpq1IiHvRbZuj+ialM4uEyWAUAtzXlMw3RH30U=; b=Vvi51ydADZIJQTdFKQLQe1yUuh
 BcLZao/uPScYfvCxtiHOZ5Fh+eKJdZmWy1j+3w32ZuLjlQSw/G0s5xNUlMa5MR205hGmY6OGaQYKu
 3VkG3Y3UvR35kHgxAXJ2LTCD6bm2DtqZGQWJZh4HpWjmtXiKhOp5Wx/0Sm6m7OXs5MXXPy5kZVPHX
 /fsrNnPq8D1KeY08QEeXN68oxx6HYjrTo/dKPhOY+nw920lzna80mDPhEKoWMuA7prnVPfdKkyUDq
 /eG0YDMXCTcGfgGUc9cfW8DhJj/XlSyylwyhbLZBWiiQWCwZeibDdUooz+wSKx5EIwLWrrMJe5Y+b
 gQc0tD+g==;
Received: from [84.65.0.132] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1s2Xhg-0031hE-9b; Thu, 02 May 2024 16:46:31 +0200
Message-ID: <d76f9bb6-b5e1-449e-957f-e7fb965e5f9f@igalia.com>
Date: Thu, 2 May 2024 15:46:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/5] drm/amdgpu: Only show VRAM in fdinfo if it exists
Content-Language: en-GB
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com
References: <20240430172748.61576-1-tursulin@igalia.com>
 <20240430172748.61576-6-tursulin@igalia.com>
 <00d43d65-333e-4b2d-861e-11d01e7931b0@gmail.com>
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <00d43d65-333e-4b2d-861e-11d01e7931b0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 May 2024 07:50:52 +0000
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


On 02/05/2024 14:16, Christian König wrote:
> Am 30.04.24 um 19:27 schrieb Tvrtko Ursulin:
>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> Do not emit the key-value pairs if the VRAM does not exist ie. VRAM
>> placement is not valid and accessible.
> 
> Yeah, that's unfortunately rather misleading.
> 
> Even APUs have VRAM or rather stolen system memory which is managed by 
> the graphics driver.
> 
> We only have a single compute model which really doesn't have VRAM at all.

Hm what is misleading and how more precisely? :) Maybe in other words, 
if is_app_apu is not the right criteria to know when TTM_PL_VRAM is 
impossible, what is? Is the compute model you mentio the only thing 
which sets is_app_apu and uses the dummy vram manager?

Regards,

Tvrtko

> Regards,
> Christian.
> 
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 29 +++++++++++++---------
>>   1 file changed, 17 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>> index a09944104c41..603a5c010f5d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>> @@ -83,25 +83,30 @@ void amdgpu_show_fdinfo(struct drm_printer *p, 
>> struct drm_file *file)
>>        */
>>       drm_printf(p, "pasid:\t%u\n", fpriv->vm.pasid);
>> -    drm_printf(p, "drm-memory-vram:\t%llu KiB\n", stats.vram/1024UL);
>>       drm_printf(p, "drm-memory-gtt: \t%llu KiB\n", stats.gtt/1024UL);
>>       drm_printf(p, "drm-memory-cpu: \t%llu KiB\n", stats.cpu/1024UL);
>> -    drm_printf(p, "amd-memory-visible-vram:\t%llu KiB\n",
>> -           stats.visible_vram/1024UL);
>> -    drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
>> -           stats.evicted_vram/1024UL);
>> -    drm_printf(p, "amd-evicted-visible-vram:\t%llu KiB\n",
>> -           stats.evicted_visible_vram/1024UL);
>> -    drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
>> -           stats.requested_vram/1024UL);
>> -    drm_printf(p, "amd-requested-visible-vram:\t%llu KiB\n",
>> -           stats.requested_visible_vram/1024UL);
>>       drm_printf(p, "amd-requested-gtt:\t%llu KiB\n",
>>              stats.requested_gtt/1024UL);
>> -    drm_printf(p, "drm-shared-vram:\t%llu KiB\n", 
>> stats.vram_shared/1024UL);
>>       drm_printf(p, "drm-shared-gtt:\t%llu KiB\n", 
>> stats.gtt_shared/1024UL);
>>       drm_printf(p, "drm-shared-cpu:\t%llu KiB\n", 
>> stats.cpu_shared/1024UL);
>> +    if (!adev->gmc.is_app_apu) {
>> +        drm_printf(p, "drm-memory-vram:\t%llu KiB\n",
>> +               stats.vram/1024UL);
>> +        drm_printf(p, "amd-memory-visible-vram:\t%llu KiB\n",
>> +               stats.visible_vram/1024UL);
>> +        drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
>> +               stats.evicted_vram/1024UL);
>> +        drm_printf(p, "amd-evicted-visible-vram:\t%llu KiB\n",
>> +               stats.evicted_visible_vram/1024UL);
>> +        drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
>> +               stats.requested_vram/1024UL);
>> +        drm_printf(p, "amd-requested-visible-vram:\t%llu KiB\n",
>> +               stats.requested_visible_vram/1024UL);
>> +        drm_printf(p, "drm-shared-vram:\t%llu KiB\n",
>> +               stats.vram_shared/1024UL);
>> +    }
>> +
>>       for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
>>           if (!usage[hw_ip])
>>               continue;
> 
