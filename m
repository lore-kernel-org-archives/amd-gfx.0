Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DACC54EBD
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 12:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 373FC10E16D;
	Thu, 12 Jan 2023 12:05:49 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D38C10E16D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 12:05:47 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id hw16so32358725ejc.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 04:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IAVp4cGzc8ptPOJDGpiYjhqVP6BpuWQdw6GGc/EH+H8=;
 b=f79F8olQT5gPtDh9n/jb1OC9/s4dLQLPzon4Xz+pz9Z2Yyb1DhQ/vRhHOM+pjgqlx5
 NOL/9i6xc7MQq9oyYKxux4/7EYLwIFZuBOwNA4an2kj1pRPc1uyapuCkWjXm3Pqz18Sc
 Be0KLEzC5ebVaLsA6Hu59Z1Q1z9VcXQIR4EfhIqNxSKZjlADUO7wcxjkB0u1+wHZo5A8
 mSs2KZCaxK6qmbPXNKl6jNAIHZo6sWiC469PsnPBNrvjKp1huop8Z9rGZnIl5J3/knX6
 H574DtEuGyVqO4fLD8d3BTezRYJNhJQP+AN0lAEddPrMIbjM17LVbrckdd7WoxMfRa2E
 dhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IAVp4cGzc8ptPOJDGpiYjhqVP6BpuWQdw6GGc/EH+H8=;
 b=RMbbLVVylZQC/zeNHGxG0CSFQZwgW2Bx8M0sFC6YTPMd930XCIMoF07iX/++wHIyo0
 eovvph8gqHC73js29SwBAWYcV3P57+ncHIaF5g+aE3/wjtFr84P7I0LnxFGhynK/uiot
 LRHtYgx64RWYeNO0sTwe2PbRjSyki8l8yVnRT8Stq3NjXie+nMJRWCk0klA5FKYjveH2
 ecQJiQvcpKu6KoL+Cwg269fFg7JZRlYY4EaMegED12eC0bGWYeWXg/LriZm5huWJmniW
 KW9OK2nVI7aOuoqglzZqgKTyB0SMSjvW6zYAmQ0yUX6K8yLPJcznfdoh3zM3CQMmKdpx
 SrOw==
X-Gm-Message-State: AFqh2krzWy00JWGJjJbeKniqCGum7v2te3gAO5zgvA51x5WxBejQX4Su
 bsNzeFUDLYvEgq1/1xQnQhc=
X-Google-Smtp-Source: AMrXdXt+MK8JKUoD/jqbD/kL22v5cfzDr/YOV1pE2odNL8/z7Xo7mtT/PlqhOtjdhZRlnBZbUqNoXg==
X-Received: by 2002:a17:906:9f20:b0:84d:43a0:7090 with SMTP id
 fy32-20020a1709069f2000b0084d43a07090mr13594262ejc.77.1673525145640; 
 Thu, 12 Jan 2023 04:05:45 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de.
 [91.14.162.231]) by smtp.gmail.com with ESMTPSA id
 hq15-20020a1709073f0f00b0084c7029b24dsm7387394ejc.151.2023.01.12.04.05.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Jan 2023 04:05:44 -0800 (PST)
Message-ID: <b2608d35-00e6-3935-3f87-297270be7073@gmail.com>
Date: Thu, 12 Jan 2023 13:05:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: grab extra fence reference for
 drm_sched_job_add_dependency
Content-Language: en-US
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <20221219104718.21677-1-christian.koenig@amd.com>
 <Y6BuZ2jv8n9dEVxS@zn.tnic>
 <CADnq5_M+TgiYw84meQNRJKnKYmr9V4v-scWZRAeFtG1o=aEeCw@mail.gmail.com>
 <7275efdb-4d22-eb76-cea3-333391472853@gmail.com>
 <CADnq5_NxbAgF6sXF6HuGzgcOoY8QOHU-0d9ghuKarx0jpt3Vog@mail.gmail.com>
 <CABXGCsOmtfo=7YWUv0QmGGrCat1Md59oz7UWw9-7MPn7f6AAdA@mail.gmail.com>
 <e6b6a599-8fdd-a4fc-a2bb-d0750e6d477d@gmail.com>
 <CABXGCsOL2SVg=FSOfhzo3wFHB9DqU=B34x+grCxQMhJsmTCMnw@mail.gmail.com>
 <CADnq5_P0Nq-y1U5X4EgYyPSKXOdVsjxX+UOCmzZKnX8FfHC86w@mail.gmail.com>
 <f4c965d9-d985-0030-7411-6d8d0f750058@gmail.com>
 <CABXGCsMJxX3wo8yhQA=nOk0ouzh-WGp_65DJBYb_9v2m4kk7Mw@mail.gmail.com>
 <82c8b18d-4e51-a137-6078-43b380661c37@gmail.com>
 <CABXGCsPpTTVXMTtZi_Yw_27VHHnPL_XSidMENzRniWZgZXd_NA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CABXGCsPpTTVXMTtZi_Yw_27VHHnPL_XSidMENzRniWZgZXd_NA@mail.gmail.com>
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
Cc: Alex Deucher <alexdeucher@gmail.com>, michel@daenzer.net,
 Borislav Petkov <bp@alien8.de>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 10.01.23 um 19:21 schrieb Mikhail Gavrilov:
> On Mon, Jan 9, 2023 at 6:40 PM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> That looks like an out of memory situation is not gracefully handled.
>>
>> In other words we have a missing NULL check in drm_sched_job_cleanup().
>>
>> Going to take a look.
> Very strange because it just reproduced again. Almost no memory leaked.
>
> ❯ free
>                 total        used        free      shared  buff/cache   available
> Mem:        65589600    34060388     1520668     3033284    30008544    27767260
> Swap:       75497464      994560    74502904

Mhm, our UVD guys reported similar problems when they open up to many 
concurrent streams.

Most likely some random issue cause by one of the gang submit patches.

Could you try to better reproduce this? If we can reproduce this 
reliable compiling the kernel with KASAN might help figuring out where 
exactly something goes wrong.

Christian.

>
>
>
>
>
> --
> Best Regards,
> Mike Gavrilov.

