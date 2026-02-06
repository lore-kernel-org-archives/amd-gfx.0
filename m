Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302D1EB28F1
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 08:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1B2810E5BE;
	Fri,  6 Feb 2026 08:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="nZvzWU0m";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CF8910E5D0
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 08:50:06 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so3855115e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Feb 2026 00:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1770367805; x=1770972605; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tHlK973Ey81Wj/d00/lSW5LjxdZrZHEalvUFfxeAv8E=;
 b=nZvzWU0m+cunfpnyndDilNrZjg7vLQWKnC9OmyKy0w0jx82Stlkji8c57rcYN6ssbX
 k/+hlEOYuOUqovJ8bjRp6s08QObuNk4aM3CrjMEMy/aqeTaxB+mNS5umviuUBuo1g5wg
 vIRt0VgIuXnhCVBg7AynTRry9pqC8m9vZSLwuURCWL8hiQU3UQf09LMoWBGc32x/BD3p
 Mc6zDKZIEGYR0JqWfE6+CO4qoL9ZZpr2Y86sWo5ea8EnCWAxtx7fcMhvtR0YW6IX482b
 o/2j3mH0Xapt7qN67Tz/jDufbgcmXKo8fE1fLJO755ghn5xDLIWP6sQNApXizFxf+1Vy
 Ws7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770367805; x=1770972605;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tHlK973Ey81Wj/d00/lSW5LjxdZrZHEalvUFfxeAv8E=;
 b=GwWJF860cxGWCrjv8srPs1dzgHDvoPZmeF1JtnPC4SdcExU9bJMBvwt8prYH1MMCYW
 jsZ+VsDF0/doGzoEVPUh+fq68mMq/WjX8zTuKgcDARNb6FgqKvWd0uLY6C18DrzwkNth
 HtdFFyuqB50pKjAeRPaI7wIlJCHzagVcBOD+Xm73kRHlhfr941p2PiV1NC0mykboVb6k
 VOm+RB8WrN6H74VUREWWTqvZA8CsPRmDFNyg6qXQo3uN9w1h6J+CbzAXrrCP71GKCPdk
 nheHV91Gzx8NIO2FsXsoqwC1b0C8YwKInRvxan8UXWyfJsiY/kfnSuVgQEMzdTeV/Zxc
 exNQ==
X-Gm-Message-State: AOJu0YzJL4j3Af/wPNud0RA8pDpHYLybq2drkhpjtiIOztCkLuV5ptxc
 8GgPf+r3X7OC595z49Ta4YSuPzkHVifZuWoXzzl4t0Kscfv0y9LjoN0pTym+Sx4thOA=
X-Gm-Gg: AZuq6aIMFEzzbDn62HNBYb3IbQqEes8LJDfFlii3Pr3uscnc7Ml+snGeLo0ZG4xKPYf
 +hJ44DQk2Mr4kvodV0+vtn+8uRkgdcgYd/UDJYRBUizlYPo/KqE3+4nQR9YA9DgZPj7uCDBB3Ai
 reczpgRFHQA7Lg3lEzZlFhEhBnLEs23cSc5Ny03BJziaw2UNp36v+sJ68rwjCMwkzP2DmS+kAqN
 AHvphI7p6+bSbJu+ukQ6XESMtyHMJzpCnoOD40XpfOooGCyZifUyfx1Xfhh0TX0vCmthhTAZ48f
 yI2Vrj3Pps3rQbBhWuJUmlDEg1yJRlW+7Eh8B9EYk4t3qvSGMlg7r9hZjWwk09IGr09uOKfb0//
 RRYxbkz+PuH57Zb8qOS0WFljagNFIBmna5ZXzayDMnAa5n4Ug3ZELEYwhJeBb0EFpeN6xNII6Pu
 y20IcgBu1kUu2DnarLmUOk+0WbebvvTAtkS98RRBY2xIxx
X-Received: by 2002:a05:600c:3e12:b0:476:d494:41d2 with SMTP id
 5b1f17b1804b1-4832021d67dmr22837885e9.29.1770367804831; 
 Fri, 06 Feb 2026 00:50:04 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483179dbdcfsm144385355e9.0.2026.02.06.00.50.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 00:50:04 -0800 (PST)
Message-ID: <8bf7b705-bfcd-4e8e-b9d1-2bb82268d490@ursulin.net>
Date: Fri, 6 Feb 2026 08:50:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/gem: Make drm_gem_objects_lookup() self-cleaning
 on failure v5
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260205154215.1460845-1-srinivasan.shanmugam@amd.com>
 <321402ae-bb5f-44e5-b7ac-a775c5cf0ab4@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <321402ae-bb5f-44e5-b7ac-a775c5cf0ab4@amd.com>
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


On 06/02/2026 08:09, Christian König wrote:
> On 2/5/26 16:42, Srinivasan Shanmugam wrote:
>> drm_gem_objects_lookup() can allocate the output array and take
>> references on GEM objects before it fails.
>>
>> If an error happens part-way through, callers previously had to clean up
>> partially created results themselves. This relied on subtle and
>> undocumented behavior and was easy to get wrong.
>>
>> Make drm_gem_objects_lookup() clean up on failure. The function now
>> drops any references it already took, frees the array, and sets
>> *objs_out to NULL before returning an error.
>>
>> On success, behavior is unchanged. Existing callers remain correct and
>> their error cleanup paths simply do nothing when *objs_out is NULL.
>>
>> v3: Move partial-lookup cleanup into objects_lookup(), perform reference
>> dropping outside the lock, and remove reliance on __GFP_ZERO or implicit
>> NULL handling. (Christian)
>>
>> v4: Use goto-style error handling in objects_lookup(), drop partial
>> references outside the lock, and simplify drm_gem_objects_lookup()
>> cleanup by routing failures through err_free_handles as suggested.
>> (Christian)
>>
>> v5: Rebase on drm-misc-next, drop the ret local variable. (Christian)
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Suggested-by: Tvrtko Ursulin <tursulin@ursulin.net>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> 
> One little nit pick below, apart from that:
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>

Same opinion on the nit pick as Christian and with that the rest LGTM:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

> 
>> ---
>>   drivers/gpu/drm/drm_gem.c | 45 +++++++++++++++++++++++++++------------
>>   1 file changed, 31 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
>> index 7ff6b7bbeb73..5895ae09c27d 100644
>> --- a/drivers/gpu/drm/drm_gem.c
>> +++ b/drivers/gpu/drm/drm_gem.c
>> @@ -783,7 +783,7 @@ EXPORT_SYMBOL(drm_gem_put_pages);
>>   static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
>>   			  struct drm_gem_object **objs)
>>   {
>> -	int i, ret = 0;
>> +	int i;
>>   	struct drm_gem_object *obj;
>>   
>>   	spin_lock(&filp->table_lock);
>> @@ -791,16 +791,23 @@ static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
>>   	for (i = 0; i < count; i++) {
>>   		/* Check if we currently have a reference on the object */
>>   		obj = idr_find(&filp->object_idr, handle[i]);
>> -		if (!obj) {
>> -			ret = -ENOENT;
>> -			break;
>> -		}
>> +		if (!obj)
>> +			goto err;
>> +
>>   		drm_gem_object_get(obj);
>>   		objs[i] = obj;
>>   	}
>> +
>>   	spin_unlock(&filp->table_lock);
>> +	return 0;
>>   
>> -	return ret;
>> +err:
>> +	spin_unlock(&filp->table_lock);
>> +
>> +	while (i--)
>> +		drm_gem_object_put(objs[i]);
>> +
>> +	return -ENOENT;
>>   }
>>   
>>   /**
>> @@ -825,27 +832,37 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
>>   			   int count, struct drm_gem_object ***objs_out)
>>   {
>>   	struct drm_gem_object **objs;
>> -	u32 *handles;
>> +	u32 *handles = NULL;
> 
> I might be missing something but setting handles to NULL looks superfluous to me and we now have static checkers warning about superfluous initialization.
> 
> Regards,
> Christian.
> 
>>   	int ret;
>>   
>> +	*objs_out = NULL;
>> +
>>   	if (!count)
>>   		return 0;
>>   
>> -	objs = kvmalloc_array(count, sizeof(struct drm_gem_object *),
>> -			     GFP_KERNEL | __GFP_ZERO);
>> +	objs = kvmalloc_array(count, sizeof(*objs), GFP_KERNEL);
>>   	if (!objs)
>>   		return -ENOMEM;
>>   
>> -	*objs_out = objs;
>> -
>>   	handles = vmemdup_array_user(bo_handles, count, sizeof(u32));
>> -	if (IS_ERR(handles))
>> -		return PTR_ERR(handles);
>> +	if (IS_ERR(handles)) {
>> +		ret = PTR_ERR(handles);
>> +		goto err_free_objs;
>> +	}
>>   
>>   	ret = objects_lookup(filp, handles, count, objs);
>> +	if (ret)
>> +		goto err_free_handles;
>> +
>>   	kvfree(handles);
>> -	return ret;
>> +	*objs_out = objs;
>> +	return 0;
>>   
>> +err_free_handles:
>> +	kvfree(handles);
>> +err_free_objs:
>> +	kvfree(objs);
>> +	return ret;
>>   }
>>   EXPORT_SYMBOL(drm_gem_objects_lookup);
>>   
> 

