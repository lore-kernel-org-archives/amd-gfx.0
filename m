Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF745FD5319
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 09:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7441410EA6C;
	Fri, 27 Feb 2026 09:13:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="RR19/ozw";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 724AB10EA6C
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 09:13:10 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fMjKb0ksQz9tDY;
 Fri, 27 Feb 2026 10:13:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772183587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q4/8dNuHXUKEAUKzROoYkovUvlv/BEs4pWqQ1BUyT+Y=;
 b=RR19/ozwvWmFBV72nxc2Wu5hzWp9jRFY2cOUlmDv9aGY0tI3ZfHY+aeiotMhR3s76NxgDg
 uakH9d96gXMczupnk128aGuYrkgnbT4ocZyuBUmzB8kFIpJJwwK99MsLGjaiB3quH1zLRo
 6t22Y7CbsXZofAGK8XeyTfVu3NUyeulZEC+bvncM3IVEsyS36q3WmjJBUv3jTCDEUFf1mm
 Wgzn+kVZexI7ggwSLUlGC6mcP29u+KnYlqXzKZZd2qke7Xj1B/l7y9A/5v7skwVRdmXjYA
 unNkJdEh4iNAkDaEv4CYAa+oBiN2rcHERd2cRwIziOa+uKUD34nbaRxRX+xGvA==
Message-ID: <490f80ef-6614-4ba3-8183-fbca7698f8da@mailbox.org>
Date: Fri, 27 Feb 2026 10:13:03 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/2] drm/amdgpu: update type for num_syncobj_handles in
 drm_amdgpu_userq_signal
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260226155146.3727191-1-sunil.khatri@amd.com>
 <e93f64b2-8157-4cc8-b4b9-16572a8cd022@igalia.com>
Content-Language: de-CH-frami, en-CA
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <e93f64b2-8157-4cc8-b4b9-16572a8cd022@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ccb5291e1f1db66e0cc
X-MBO-RS-META: 4mekw3ycctfqzoszies1ffzcg6ffsqx5
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

On 2/26/26 17:05, Tvrtko Ursulin wrote:
> On 26/02/2026 15:51, Sunil Khatri wrote:
>> update the type for num_syncobj_handles from __u64 to _u16 with
>> required padding.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   include/uapi/drm/amdgpu_drm.h | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index 33e8738ce91f..42b4c0f6746b 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -479,7 +479,9 @@ struct drm_amdgpu_userq_signal {
>>        * @num_syncobj_handles: A count that represents the number of syncobj handles in
>>        * @syncobj_handles.
>>        */
>> -    __u64    num_syncobj_handles;
>> +    __u16    num_syncobj_handles;
> 
> Could probably cause build warnings/errors for something which builds fine today. Hm on big endian it actually breaks completely.

Yeah this is a clear UAPI break, no go.


>> +    __u16    pad0;
>> +    __u32    pad1;
>>       /**
>>        * @bo_read_handles: The list of BO handles that the submitted user queue job
>>        * is using for read only. This will update BO fences in the kernel.
> 


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
