Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DB3E95A91
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 09:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6A3310E251;
	Mon,  9 Oct 2023 09:25:31 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77F6710E251
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 09:25:30 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40572aeb73cso39229855e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Oct 2023 02:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696843529; x=1697448329; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7h1NZGl08WMHM6sHBFAad7NX0zz3x4XjSJ//OWnR0C8=;
 b=Qfc8t2ldLPCF+kIO1NpG4XtuO9H2D0VuDgOeoVNsQ79DBTSa8xiGFt+XGit8FVjBmO
 ZoTiZvuAp0udER3fEy6r8o3fPyuhmYS2PMgTT61jJKaxq8T5anbW/IHe0ucQJeu2X1aP
 WPaC++gTX/K49p1aKQrFnatEdPbOREaKw0bi8YNpNQi612RYjweCdiX6Eo0hsa9hQPGP
 pdpRV0zFm6Rjsqxqrg7p4YrKTkhC2f2p9KsQ81gt5tSD6XPUZ23BI9U4OihNkqgFgf9Y
 sjNENMtRstrlYxuahrqITjneRLLaYiGXQ1gXxUfF9mFL9zGlnHopEc+eaeyy12DFmplv
 JmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696843529; x=1697448329;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7h1NZGl08WMHM6sHBFAad7NX0zz3x4XjSJ//OWnR0C8=;
 b=ci/5ks1wPu8tYrNO8gc2CUFzeR0DWfn8vHgI7WLB0Q7AT+A4m5Fv5VKWdnJe803bGK
 SFFrMcs5dz/oepkhc/g2cch+qGpTHZsOKtl2gFZwjI+pZ9usXenKMqUfwN+2MfBeNGxB
 HiKZmizu5NJv3n9jJ6kmIwI+hxjU3Zx16RaTBQmI5ltL43flDfcKgFuSWuS6NGJW02Ee
 9vTAY9dnaCKa2IYaDLX7hEWbIHlqDwiUAGcUrKikkG66tIPBDMAid301W5jhNfNY720U
 G8VswTwNH2e/uNjrzieGlSSVNe7zNeP+MVyXG9sTGxAi9voBhiTZ2i1FC4PQMsgCFqsQ
 XZ3g==
X-Gm-Message-State: AOJu0Yza9gMK2fIvM3G74OLWD3eTaSjIQjvwwzL2/geNpbSSZ+E8+2nc
 hII6B1Fk/E/RjxIul2Ttzb4=
X-Google-Smtp-Source: AGHT+IEa0oCaWZVzdJhPulsamt8Z8Gwkzkj/yCtupcqZaI/ypxQL3MlAtD1urWJUrLyaQ9icQnob1A==
X-Received: by 2002:a5d:4087:0:b0:31f:ec06:204 with SMTP id
 o7-20020a5d4087000000b0031fec060204mr12051378wrp.52.1696843528657; 
 Mon, 09 Oct 2023 02:25:28 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 d9-20020adff2c9000000b00324887a13f7sm9103845wrp.0.2023.10.09.02.25.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 02:25:28 -0700 (PDT)
Message-ID: <6898e504-c460-4756-9f6b-5dad0bbb87a5@gmail.com>
Date: Mon, 9 Oct 2023 11:25:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add missing NULL check
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20231006121151.1502-1-christian.koenig@amd.com>
 <CADnq5_OWrymPNsokVdM1gSjc168k2VKzKoZfV8q6TW9BXYpeuw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_OWrymPNsokVdM1gSjc168k2VKzKoZfV8q6TW9BXYpeuw@mail.gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org, samuel.pitoiset@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.10.23 um 16:41 schrieb Alex Deucher:
> On Fri, Oct 6, 2023 at 9:07 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> bo->tbo.resource can easily be NULL here.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
> Add a link to the bug report?

Ah, crap. Forgotten to add the link before pushing that. But I've added 
a CC stable.

Apart from that I suspect that this doesn't fix the real issue here, it 
just mitigates the problem.

For some reason we can't allocate OA resources, but also doesn't fail 
and instead keep working with an empty BO.

Regards,
Christian.

> With that:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> index f3ee83cdf97e..d28e21baef16 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> @@ -252,7 +252,7 @@ static inline bool amdgpu_bo_in_cpu_visible_vram(struct amdgpu_bo *bo)
>>          struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>          struct amdgpu_res_cursor cursor;
>>
>> -       if (bo->tbo.resource->mem_type != TTM_PL_VRAM)
>> +       if (!bo->tbo.resource || bo->tbo.resource->mem_type != TTM_PL_VRAM)
>>                  return false;
>>
>>          amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &cursor);
>> --
>> 2.34.1
>>

