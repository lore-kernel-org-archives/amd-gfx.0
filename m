Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6A5C19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 20:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42F6611A22A;
	Thu, 11 Aug 2022 20:56:27 +0000 (UTC)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622CC112089
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 20:56:05 +0000 (UTC)
Received: by mail-ua1-x930.google.com with SMTP id z5so7430947uav.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 13:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:reply-to:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=FpXV43rYVwtCc4OkQtNbuvw3flsOACfVewIS5GxEyQA=;
 b=QAh5kkGUuPYgdPzdxJU7sSpKjR5bQG0IKUKLubxIXpRyMsoZ0gaYyAcihiVXOdNW4Y
 gwQkjjvIsvelXU/hoi5fYXXGBD6UoU+JiDpikQwxts28c/80bNNzyfy3Ev8s6lL9sZPM
 aZUYmrg6GyrXFOMv+nHlEi7s+L5aBoJq9hFFOnNBWqj4DSszE5C48AXXDv/YeplEgGyZ
 fddrpud89CXDzBryiC7V/Xicjz5vNWKbe/HAeX2b2CPecal5yfCFAIWxbOUnTjm39/0+
 PXzee5dQXv/pE5QWHI0ykaBYJJ1ryQmSvSD82cLvVJFTduMXdiE+Aq1/dr+UGJYswy7g
 EK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:reply-to:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=FpXV43rYVwtCc4OkQtNbuvw3flsOACfVewIS5GxEyQA=;
 b=3QvOUKTR7Xpt0Ge66KiKiTJ6D8FZzKkclwFkpjg+PVd7Lg87b/dov8BQYAjzKOsflr
 5ncl2TPyVGRIsx36p+F537Cwopj16EBxIQqO5L72Xx6W4664vXpOH4V0BIpbyJiJFQ03
 Zc6/RKOwBlCbmM3V4wfLhL3GPkez0NOHYSH84ubOXk6FsPvhrGWI2DRPzYHHoeRBOMSb
 HR+1nVsvQhNwStuETznHeMa1w98cmgtGIMU8KBaZ4uINria/HNgWYHe9Fbigw+7V7dEi
 DAcNrlct+A+6EQ7CRHi2ettKpovhB68gcEx9cI1a5P05IRLK0YNj92NOHsUPiXzDoWjh
 OTRw==
X-Gm-Message-State: ACgBeo29hayipxV24cbDukr9/znTGfO/JLAuUR/g8gA9Q1l0MNipy8OT
 kEeZbtUaHINWtsvm+jtpj90=
X-Google-Smtp-Source: AA6agR5ScplJthLN5oASn5Uh9QrpdowjsYIuR/IW6f2MNjwkGT1GCyoiQJGafmoEvHgh3rnTaNsnWA==
X-Received: by 2002:a05:6130:1102:b0:38c:49b4:bbc3 with SMTP id
 ce2-20020a056130110200b0038c49b4bbc3mr557776uab.107.1660251364387; 
 Thu, 11 Aug 2022 13:56:04 -0700 (PDT)
Received: from ?IPV6:2804:14c:4c2:8202::1003? ([2804:14c:4c2:8202::1003])
 by smtp.gmail.com with ESMTPSA id
 s11-20020ab02bcb000000b003842250a024sm416896uar.10.2022.08.11.13.55.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Aug 2022 13:56:03 -0700 (PDT)
Message-ID: <99b7b8e5-983b-5e69-3d93-ca68356cc2aa@gmail.com>
Date: Thu, 11 Aug 2022 17:55:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/8] drm/amd/display: Introduce KUnit tests to the
 bw_fixed library
Content-Language: en-US
To: David Gow <davidgow@google.com>
References: <20220811004010.61299-1-tales.aparecida@gmail.com>
 <20220811004010.61299-3-tales.aparecida@gmail.com>
 <CABVgOSmkeybnR2sGEEgn1Cb0cR2eKxW=vhXkHjC5xCuhaxsqVg@mail.gmail.com>
From: Tales Lelo da Aparecida <tales.aparecida@gmail.com>
In-Reply-To: <CABVgOSmkeybnR2sGEEgn1Cb0cR2eKxW=vhXkHjC5xCuhaxsqVg@mail.gmail.com>
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
Reply-To: CABVgOSmkeybnR2sGEEgn1Cb0cR2eKxW=vhXkHjC5xCuhaxsqVg@mail.gmail.com
Cc: siqueirajordao@riseup.net, David Airlie <airlied@linux.ie>,
 =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net,
 Jonathan Corbet <corbet@lwn.net>, magalilemes00@gmail.com,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 KUnit Development <kunit-dev@googlegroups.com>,
 Harry Wentland <harry.wentland@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Leo Li <sunpeng.li@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, mwen@igalia.com,
 Trevor Woerner <twoerner@gmail.com>,
 =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/08/2022 04:34, David Gow wrote:
> On Thu, Aug 11, 2022 at 8:40 AM Tales Aparecida
> <tales.aparecida@gmail.com> wrote:
>>
>> From: Maíra Canal <maira.canal@usp.br>
>>
>> KUnit unifies the test structure and provides helper tools that simplify
>> the development of tests. Basic use case allows running tests as regular
>> processes, which makes easier to run unit tests on a development machine
>> and to integrate the tests in a CI system.
>>
>> This commit introduces a unit test to the bw_fixed library, which
>> performs a lot of the mathematical operations involving fixed-point
>> arithmetic and the conversion of integers to fixed-point representation
>> inside the Display Mode Library.
>>
>> As fixed-point representation is the base foundation of the DML calcs
>> operations, this unit tests intend to assure the proper functioning of
>> the basic mathematical operations of fixed-point arithmetic, such as
>> multiplication, conversion from fractional to fixed-point number, and
>> more.  You can run it with: ./tools/testing/kunit/kunit.py run \
>>          --arch=x86_64 \
>>          --kunitconfig=drivers/gpu/drm/amd/display/tests/
>>
>> Signed-off-by: Maíra Canal <maira.canal@usp.br>
>> Co-developed-by: Magali Lemes <magalilemes00@gmail.com>
>> Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
>> Co-developed-by: Tales Aparecida <tales.aparecida@gmail.com>
>> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
>> ---
> 
> Not directly related to this patch, but I get a whole stack of
> warnings about the definition of MIN_I64 causing integer overflow:
> ../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/calcs/../../../tests/dc/dml/calcs/bw_fixed_test.c:214:31:
> note: in expansion of macro ‘MIN_I64’
>   214 |         KUNIT_EXPECT_EQ(test, MIN_I64 + 1, res.value);
>       |                               ^~~~~~~
> ../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/calcs/bw_fixed.c:30:19:
> warning: integer overflow in expression ‘-9223372036854775808’ of type
> ‘long long int’ results in ‘-9223372036854775808’ [-Woverflow]
>    30 |         (int64_t)(-(1LL << 63))
>       |                   ^
> 
> This seems to fix it (I'll re-send it out as a separate patch so gmail
> doesn't mangle it once I'm a bit more convinced it's the best
> implementation):

Thanks!

We were aware of this warnings, in fact there was a patch fixing this 
that got dropped in the last minute to expedite its review as a 
standalone patch, I'm sorry I didn't mention it in the cover letter.

To make amends I've sent your approach to the mailing list, hope you 
don't mind!

https://lore.kernel.org/all/20220811204327.411709-1-tales.aparecida@gmail.com/

> 
> --- 8< ---
>  From 84e84664873dc9e98dff5ee9f74d95872e6cd423 Mon Sep 17 00:00:00 2001
> From: David Gow <davidgow@google.com>
> Date: Thu, 11 Aug 2022 15:21:02 +0800
> Subject: [PATCH] drm/amd/display: MIN_I64 definition causes overflow
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> The definition of MIN_I64 in bw_fixed.c can cause gcc to whinge about
> integer overflow, because it is treated as a positive value, which is
> then negated. The temporary postive value is not necessarily
> representable.
> 
> This causes the following warning:
> ../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/calcs/bw_fixed.c:30:19:
> warning: integer overflow in expression ‘-9223372036854775808’ of type
> ‘long long int’ results in ‘-9223372036854775808’ [-Woverflow]
>    30 |         (int64_t)(-(1LL << 63))
>       |                   ^
> 
> Writing out (INT_MIN - 1) - 1 works instead.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
> b/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
> index fbe8d0661396..3850f7f0f679 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
> @@ -26,12 +26,12 @@
> #include "bw_fixed.h"
> 
> 
> -#define MIN_I64 \
> -       (int64_t)(-(1LL << 63))
> -
> #define MAX_I64 \
>         (int64_t)((1ULL << 63) - 1)
> 
> +#define MIN_I64 \
> +       (-MAX_I64 - 1)
> +
> #define FRACTIONAL_PART_MASK \
>         ((1ULL << BW_FIXED_BITS_PER_FRACTIONAL_PART) - 1)
> 
> --
> 2.37.1.595.g718a3a8f04-goog
> --- 8< ---
> 
> Otherwise, this test seems to okay. I'll review it (and the series)
> more properly over then next few days.
> 
> Cheers,
> -- David

Thanks for reviewing,
Tales
