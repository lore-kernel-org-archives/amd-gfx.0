Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E558ACDB483
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 11:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6415A10E4C8;
	Thu, 19 Oct 2023 11:22:02 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD82A10E4C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 11:22:00 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40837ebba42so18056345e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 04:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697714519; x=1698319319; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WGPRkDvzalo2oqt+qob7yujk9E/FXRYX/PiJDv6BgtE=;
 b=gtWWcskeU4i7k+VBrqLRcE3c/9qiD8cgCkAqjiWiuCzvq/ZI62C4IOLPIC9J0SEEYk
 UVUn40CvaRTDiMhrga8Ojzv0uwtFEpT0UlTIED4VCOzJcyaq85wyWLM/g+5w9XWQdtM8
 Qy/ZRzMxK0jMvwq4s4xqX4vb90MEly88pxYWQVTqQeHiYWiWaKoyW6be+YPip3Qjq/Uk
 CvG9O08fs78diCkyBIY6i2Px6MoDyI6votX5XkqmlKJOlGiGbSCr2tbZ6Av+0c4c7rBe
 LuN8B6QIeORi9nP4zy3Lq+nYaAQQo2VYUW7V9MJWU3d18bzmAgUrXwl9ZcXWJUdcQkW/
 UqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697714519; x=1698319319;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WGPRkDvzalo2oqt+qob7yujk9E/FXRYX/PiJDv6BgtE=;
 b=ogwIXXzC7EIUfDFOEb0Pydjieay3v7ntD3cK2eAtPOqM404eq667Cq2XVAhJhkChfZ
 Zip8U9sGhi+k/RD+Dz+rK0FJ/a1NH6KmrtVF6RHsSyLbTm4Tj7eDCXAGfq49K/4DOOfi
 /zJDQ6rESKXI1q9UQ0DiYXYzqeaF2b3AY2HyUh3ULarI8opjv1R+RG6ayXEeq7PTU5n7
 wTY8Hvlpri8xlSpuJNHh1UXM+/vT7Rv1s7NV7r7o+0MvifOBQEdJNgeTMB923ZvTaV05
 hlULOTA7OnNCsou2izfJ/ahuYokB9hyrbDe3iLoCD5x82s9PrRUMojbQWu3aO6IQkiuF
 DC7w==
X-Gm-Message-State: AOJu0YyDrt5MBB90Ybd/8tT06cyKhUTLCBquOLKPl0/rT7+pA7EkkuU9
 NgW3Tz8FYbk7BeUSp3hOsjI=
X-Google-Smtp-Source: AGHT+IG2EQXFM3icrPnsdySPYdhb1clkuYaNQd9CE4sH7soRwzhRzKj+SOaQPO3xEeq3PCGrUD7Zqw==
X-Received: by 2002:a05:600c:3b19:b0:401:73b2:f043 with SMTP id
 m25-20020a05600c3b1900b0040173b2f043mr1693107wms.1.1697714519094; 
 Thu, 19 Oct 2023 04:21:59 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 fc8-20020a05600c524800b0040535648639sm4237224wmb.36.2023.10.19.04.21.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 04:21:58 -0700 (PDT)
Message-ID: <1aecc871-de53-48a9-bc25-657383de78bf@gmail.com>
Date: Thu, 19 Oct 2023 13:21:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: ignore duplicate BOs again
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20231017121015.1336786-1-christian.koenig@amd.com>
 <CADnq5_PY7RRL7Xp7Ju14yqBRBdBcxWuR0+H-ysDtZCZzdUrkXg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_PY7RRL7Xp7Ju14yqBRBdBcxWuR0+H-ysDtZCZzdUrkXg@mail.gmail.com>
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
Cc: alexander.deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.10.23 um 15:04 schrieb Alex Deucher:
> On Tue, Oct 17, 2023 at 8:22 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Looks like RADV is actually hitting this.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Fixes: ca6c1e210aa7 ("drm/amdgpu: use the new drm_exec object for CS v3")
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Pushed to drm-misc-fixes since the original patch causing the problems 
isn't even merged into amd-staging-drm-next yet.

Regards,
Christian.

>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index efdb1c48f431..d93a8961274c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -65,7 +65,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
>>          }
>>
>>          amdgpu_sync_create(&p->sync);
>> -       drm_exec_init(&p->exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
>> +       drm_exec_init(&p->exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
>> +                     DRM_EXEC_IGNORE_DUPLICATES);
>>          return 0;
>>   }
>>
>> --
>> 2.34.1
>>

