Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BD3FD7070
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 10:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D1FB10E3E8;
	Tue, 17 Mar 2026 10:19:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BypbOCdO";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9201510E3E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 10:19:25 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fZnxj5Zjgz9tp3;
 Tue, 17 Mar 2026 11:19:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773742761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wU2YIfZ+sROEiUzqa2Y4ruLm7Tj1E/9YKuSp40fQ8BM=;
 b=BypbOCdO463dhYQnVPh6WvpI/mvv/OHkSsbp+tmpN14JROZjOGjj88vMKervvEkQ73gk4K
 HhyB1TZSY/oNgrLQ3SH9X82fdGnCRN6S979xRvg8lCMD1y2hlojNLxQH2zAR47w8ZnJlMI
 K7sd1cTL6eCc32EpL0I6RKvsQ1Xtgt9i6RlbJnUviZhaxYajwxwp2qIWn6s/mQmqJPho6g
 VGMTEJd9o2qp3E1OQA9rM01NMXoYsR0WPA2bsklUPFj7Zg7WzjG5q1OfM1wlqHjN/5XtH6
 Awc+Ss+JLkwsWdW9u2wJb7AkTNjZyaiQbvQ3FraXBIWvjuWyfoJX5oVOkiMNgg==
Message-ID: <011ff8c6-9f85-4e69-bb6c-109ad388ab4d@mailbox.org>
Date: Tue, 17 Mar 2026 11:19:18 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] drm/amdgpu: replace WARN with DRM_ERROR for invalid
 sched priority
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: Alexander.Deucher@amd.com, Vitaly Prosyak <vitaly.prosyak@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260317011713.1812421-1-Jesse.Zhang@amd.com>
 <20260317011713.1812421-2-Jesse.Zhang@amd.com>
 <8b986315-3dcf-4fb5-8a0b-96575f0f5302@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <8b986315-3dcf-4fb5-8a0b-96575f0f5302@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: i5i7ww6u1jrng9bra4hzqfnqrgtz3wsc
X-MBO-RS-ID: 3ca9b9fd8a03770513a
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

On 3/17/26 08:05, Christian König wrote:
> On 3/17/26 02:17, Jesse.Zhang wrote:
>> amdgpu_sched_ioctl() currently uses WARN(1, ...) when userspace passes
>> an out-of-range context priority value. WARN(1, ...) is unconditional
>> and produces a full stack trace, which is disproportionate for a simple
>> input validation failure -- the invalid value is already rejected with
>> -EINVAL on the next line.
>>
>> Replace WARN(1, ...) with DRM_ERROR() to log the invalid value at an
>> appropriate level without generating a stack dump. The -EINVAL return
>> to userspace is unchanged.
>>
>> No functional change for well-formed userspace callers.
>>
>> v2:
>> - Reworked commit message to focus on appropriate log level for
>>   parameter validation
>> - Clarified that -EINVAL behavior is preserved
>>
>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>> Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>> index 341beec59537..4126e5026c20 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>> @@ -104,7 +104,7 @@ int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
>>  	}
>>  
>>  	if (!amdgpu_ctx_priority_is_valid(args->in.priority)) {
>> -		WARN(1, "Invalid context priority %d\n", args->in.priority);
>> +		DRM_ERROR("Invalid context priority %d\n", args->in.priority);
> 
> Please completely drop that warning. Invalid parameters should never clutter the system log.

Or make it drm_dbg(_driver).


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
