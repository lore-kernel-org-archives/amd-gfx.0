Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157E0EE3F2F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 06:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8750010E159;
	Fri, 15 Sep 2023 06:13:38 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA30D10E159
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 06:13:36 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-99bdcade7fbso221450466b.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 23:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694758415; x=1695363215; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ksZf6bEVbP8AX5jktPlAlMXC8Le69ctK49X9uUAFDjQ=;
 b=OeJEE+S52m5PfbE4qtDCXDUczNRjVB/ub8QfWIf2zo03SqciZGFbiH7cXOp2C8yClT
 odD10SxiqHJyRFFV6wrd6+PuekUBcs5ILMa0KyGNa9l8QA98KIvMNaRnwh7L13edU3TI
 cLZRa35gxBlb0xXGR2M+rzYjS628OAUYNk3I6Icvl4lNjRgbLJK8kml5+NEexVVnUOif
 2dVExtwUOzVpqC2YOGefRZl7jsKANrsRmEiVUSmZNxen+KJCu5SP8uT9/45L70gfRYhD
 rzagG55ZFoI19DEWMlivyGuE8mMR5tiHa5L8WSMxJReRD9VHxI2ttEY1ctGO1p7J2X8e
 9Vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694758415; x=1695363215;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ksZf6bEVbP8AX5jktPlAlMXC8Le69ctK49X9uUAFDjQ=;
 b=r9epUuDZQU9djPAyht4jNc06NV2Oa6/pa4MbSYoDEmicTtAZ3PbVzIVUQjCN8ZzN1V
 LJ7VDqFErxUkU00+D26LXxoq7MBAk+6bvR55eVlhMUG53okaQAE0fxmILl3fD0jPw1es
 h/qFaFV7U72WuaxFcT59kS3sKTOPv8+NGHvlssH3uGzeqCQ0sdIBKMZ+d9KTnCE5wrDZ
 mb+RuX1i7s6OBpUScUN9dS00dJfDETyuOFWSXa6+5LKEND4DWOkkOwTKrz4MNHheTzTJ
 ciJw+qA6KrvWBAvIx9ZUqDWml9XGzMHJ32gjxWZUT1Med7MYugYlnf7+ueKNjA2BModo
 sxHg==
X-Gm-Message-State: AOJu0YxAAHryK5ZMZGTdTsF3WT1jF5+bpMA5xbzl8ZcPFzHbz85JBeyn
 r/5jElZjxZ3TemAsEodR304=
X-Google-Smtp-Source: AGHT+IGPQXulOi5dLT7w3gIhX9v6dcv1C+W0MesPxwDemGgoWDbdHKAVlNb1GjIsJmlsTTozF8Mebw==
X-Received: by 2002:a17:907:2c62:b0:9a5:c3fe:a4ef with SMTP id
 ib2-20020a1709072c6200b009a5c3fea4efmr489279ejc.29.1694758414762; 
 Thu, 14 Sep 2023 23:13:34 -0700 (PDT)
Received: from [192.168.178.25] ([185.254.126.106])
 by smtp.gmail.com with ESMTPSA id
 x8-20020a170906298800b009ad778a68c5sm1935616eje.60.2023.09.14.23.13.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 23:13:34 -0700 (PDT)
Message-ID: <9aac2aa5-448d-1abd-6c70-6ec7840e4b12@gmail.com>
Date: Fri, 15 Sep 2023 08:13:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] drm/amdgpu/gmc11: disable AGP on GC 11.5
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230914182200.679059-1-alexander.deucher@amd.com>
 <20230914182200.679059-4-alexander.deucher@amd.com>
 <CADnq5_OucfrjjRtTsV=yiaCcYJT8oADr5xdQLUsrBhfNs_npDw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_OucfrjjRtTsV=yiaCcYJT8oADr5xdQLUsrBhfNs_npDw@mail.gmail.com>
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

Am 14.09.23 um 20:49 schrieb Alex Deucher:
> On Thu, Sep 14, 2023 at 2:31 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>> AGP aperture is deprecated and no longer functional.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> index 6947b598e9b2..7ee91b66f761 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> @@ -745,6 +745,9 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
>>                  adev->gmc.gart_placement = AMDGPU_GART_PLACEMENT_LOW;
>>          else
>>                  adev->gmc.gart_placement = AMDGPU_GART_PLACEMENT_HIGH;
>> +       /* AGP aperture is removed on GC11.5 */
>> +       if (amdgpu_ip_version(adev, GC_HWIP, -2) >= IP_VERSION(11, 5, 0))
> Not sure what happened here.  I've replaced the -2 with 0 locally.

I also don't see patch #1 in the series.

Patch #3 shouldn't be necessary, if the AGP aperture isn't wanted the 
code should just not call amdgpu_gmc_agp_location().

Christian.

>
> Alex
>
>> +               adev->gmc.no_agp = true;
>>
>>          gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
>>
>> --
>> 2.41.0
>>

