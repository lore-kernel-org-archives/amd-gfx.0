Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA83EB64DA
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 13:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAAD310E21E;
	Mon, 26 Jun 2023 13:58:13 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD70410E218
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 13:58:12 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-312824aa384so2821824f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 06:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687787891; x=1690379891;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fLRlDz08KHWgNCLkqt3Vpju4vWNEa+9O95DiHazwBbU=;
 b=pAwMnuPDaZczSa2Djx9j7xlQ+mCbtxH1iB/hoeT2gBLXeMdnW2YgFmzlbP03Y5N7bd
 RkZqZ1HWgIunedwVscMTB7KWB/At77ByJFoYqm9lqS7jvqYp5ufPl5Jma1Jz095N5Paq
 vKJ1lwUTAemld2iaiQM1vnTBrPck20GWdORXzfr+rTKCd6syGRdzq8G6i4APrbgrO5ML
 yISBhnwrOZk4RqVCrOVXX7olxGdP1nuhTYLnAFMskVv3AG72TPVayTep2njclkTZT59w
 GaPdtl3d2ccQJMzayDQLKQyvJd/tNcP4vyFZuRUmLlGjrMD7ZT2wVBxklbGe+5ltUWhx
 q6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687787891; x=1690379891;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fLRlDz08KHWgNCLkqt3Vpju4vWNEa+9O95DiHazwBbU=;
 b=WZITYSDmubBzS+W83ln7i1qzXM8X8rFeWVIVa7epk/O4OxXYBLeE/2DD1m2W3zAMQg
 SsDw226JRWKRVk+M5f0PD0yBPgo0eaBsl2nNMcdTU+Rv7x8TgwVDdNkFqS23jL3gtqhf
 wOCFbSrLqsqZWIMDCADoFVanBKXCUbxb8KXeMv+d3lZhl1DAeRVEG9U/QjkzOgtUmEbR
 218DB6QGaOKCPMJ1TV+pg032+4tF1P18hej3VULieOggRPg3PccGyE8J1wLMCmpRRlV7
 MMky9bu2/qf9ueljpPh7vHRmvGB4vup4z18y20pSj6z+cz6gkhGJ9GeAwXMgNJQxGma7
 Dmsg==
X-Gm-Message-State: AC+VfDy6Oj0HoWK1yUYaTi6/6CU8nVWFlWkLydiBsOcH0KSvcwPYd54W
 A92/HdnaZaKwslrBQEEqfoqZDeV0RSo=
X-Google-Smtp-Source: ACHHUZ7CI5n81rrnBT9zGdxMJSQhvrFNOKZo11HwI4snMxSkrDKyu6335qmOcnSnwwkxcIV3Mim52w==
X-Received: by 2002:adf:e408:0:b0:313:ec90:ac25 with SMTP id
 g8-20020adfe408000000b00313ec90ac25mr3014738wrm.11.1687787890803; 
 Mon, 26 Jun 2023 06:58:10 -0700 (PDT)
Received: from ?IPV6:2a00:e180:158d:7600:862:d9d5:c1f7:84a1?
 ([2a00:e180:158d:7600:862:d9d5:c1f7:84a1])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a5d5682000000b00313ec7dd652sm4629541wrv.44.2023.06.26.06.58.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 06:58:10 -0700 (PDT)
Message-ID: <6fd2e4d2-bcb6-052c-031e-6ff9aa04d9a5@gmail.com>
Date: Mon, 26 Jun 2023 15:58:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] Revert "drm/amdgpu: change the reference clock for
 raven/raven2"
Content-Language: en-US
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230602184312.752618-1-alexander.deucher@amd.com>
 <85ae153f-357b-53b9-e987-c6aafa425299@daenzer.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <85ae153f-357b-53b9-e987-c6aafa425299@daenzer.net>
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
Cc: "Chen, Jasber" <yipeng.chen@amd.com>, Jesse.Zhang@amd.com, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi guys,

Vitaly and Jasber have been recently working on disabling the IGT tests 
for the TSC query on RV/RV2 (which I'm not very keen on).

And additional to that we have this RADV merge request here: 
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23481

What exactly is going on here? That sounds like we are working around a 
FW or more specific GFXOFF bug in userspace.

Regards,
Christian.

Am 05.06.23 um 10:57 schrieb Michel Dänzer:
> On 6/2/23 20:43, Alex Deucher wrote:
>> This reverts commit fbc24293ca16b3b9ef891fe32ccd04735a6f8dc1.
>>
>> This results in inconsistent timing reported via asynchronous
>> GPU queries.
>>
>> Link: https://lists.freedesktop.org/archives/amd-gfx/2023-May/093731.html
>> Cc: Jesse.Zhang@amd.com
>> Cc: michel@daenzer.net
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> The series is
>
> Reviewed-by: Michel Dänzer <mdaenzer@redhat.com>
>
> Thanks!
>
>

