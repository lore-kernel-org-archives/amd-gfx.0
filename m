Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392F6C3DA7A
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 19:11:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD11610E7F6;
	Thu,  5 Jan 2023 19:11:25 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F350B10E7F6
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 19:11:23 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 k22-20020a05600c1c9600b003d1ee3a6289so2086210wms.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Jan 2023 11:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pb0rdhpHqMJxVJWIuvq2s4B5Rt7gL/fRN/tkE//XeIQ=;
 b=T75QeYYHGaX9WAOEUfqErYmyIi2Wy1m9qxUTlXlHTi7cQGYFLaN6GVoGE2WssKZ0yZ
 HqqmdHq3vGV5bNlcJUHnkcPBvSF88W+h/HFUpZdBhQW1CqNOwEeRYH4e72SVpqha2dRY
 oLoxAJuql3sOkl9SiCMhfEdLamrTl89PUtQ6w3twMO4AY9UjNvnOelRrL1BW/cttsW/y
 3QhYZ7ehGrBs6JcswoBufgid8uPUQat/Jjvg0ZjfRA+lWsbo9AnVG79SsVLgyG092DWU
 hkPAjAq9L0YnNDZfY6JtEoYx24d2NRZSHe3b83YOJ2XjTZmNKUrxActPoW8OzmyFkxeS
 wZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pb0rdhpHqMJxVJWIuvq2s4B5Rt7gL/fRN/tkE//XeIQ=;
 b=iacGepwJZEe8auYbrhBE0C0fgKCjPi+cSm1x94mrR5zxBS/sPjVeCX3k1j3fPny+yn
 YccMZlaVye8ZghrknkgoEmOr8vt8hP+Euhk6TgssiZKcR/T7gPM2OveJIVzVzxL0LeSh
 aFbS1pqxJcemaKVwBjC3FrSpj115XpZW75tGF1XKG7pnDF9Ry7mpGOFjyLQL8Ll5tOTo
 3zhEq2Hijn/z980BOVPKnJDc43aNYdin83WXT4UOqSyyubEWuHgHZIKrc3TELwycX73/
 ERCHg7X43sxSN9LFyvMaEftLZX0H4YIZEELNGiuSQLkJVDWb7rh3geeTjMUWGC817bmz
 IZZg==
X-Gm-Message-State: AFqh2krkoNqn0K8W0smg5exRQR5VFGYiEgM1QB3Aw+rS3CvMvmLLu4jV
 lXLodmUiT6hkW8MVrN3gY5zoO3VrV4o=
X-Google-Smtp-Source: AMrXdXsM6zHCO7CXRCA7iadEUjQMR/sG2Abz8y5BXtbqqfOBGipVOkAw+EB4A/e1VwKqK6Rk+3LI0Q==
X-Received: by 2002:a05:600c:3ba7:b0:3d3:4dac:aa69 with SMTP id
 n39-20020a05600c3ba700b003d34dacaa69mr36864794wms.36.1672945882429; 
 Thu, 05 Jan 2023 11:11:22 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:4186:34e8:5094:6674?
 ([2a02:908:1256:79a0:4186:34e8:5094:6674])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a05600c1d8700b003d973d4fb28sm3510961wms.4.2023.01.05.11.11.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jan 2023 11:11:21 -0800 (PST)
Message-ID: <314b034f-e152-90b4-ce98-f5692f72de79@gmail.com>
Date: Thu, 5 Jan 2023 20:11:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] drm/amdgpu: fix missing dma_fence_put in error path
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230105111703.52695-1-christian.koenig@amd.com>
 <20230105111703.52695-2-christian.koenig@amd.com>
 <CADnq5_OdokG3VZxp0FE-zbvBoLiZcWQkxhcHCwa7ZMCvx2FkOw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_OdokG3VZxp0FE-zbvBoLiZcWQkxhcHCwa7ZMCvx2FkOw@mail.gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.01.23 um 17:50 schrieb Alex Deucher:
> On Thu, Jan 5, 2023 at 6:17 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> When the fence can't be added we need to drop the reference.
>>
>> Suggested-by: Bert Karwatzki <spasswolf@web.de>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
> please add:
> Cc: stable@vger.kernel.org # 6.1.x
> When you push this series.

But none of this is in 6.1? That are pure 6.2 changes or am I missing 
something?

Christian.

>
> Alex
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> index bac7976975bd..dcd8c066bc1f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> @@ -391,8 +391,10 @@ int amdgpu_sync_push_to_job(struct amdgpu_sync *sync, struct amdgpu_job *job)
>>
>>                  dma_fence_get(f);
>>                  r = drm_sched_job_add_dependency(&job->base, f);
>> -               if (r)
>> +               if (r) {
>> +                       dma_fence_put(f);
>>                          return r;
>> +               }
>>          }
>>          return 0;
>>   }
>> --
>> 2.34.1
>>

