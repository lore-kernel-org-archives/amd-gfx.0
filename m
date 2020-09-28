Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4049C2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 19:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4577B2074A
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 19:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMXYdLXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4577B2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B45F589F3C;
	Mon, 28 Sep 2020 19:31:45 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA61889F3C
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 19:31:44 +0000 (UTC)
Received: by mail-ej1-x643.google.com with SMTP id p15so10501659ejm.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 12:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=qnscpdgLAj4kkHeVRuIgfy6ygA8ftW0KT2DOymw+8xo=;
 b=LMXYdLXZalo4AVuQs+j0LKwfSEmyKIWMUKZYkja6hwWGmKa2u8nU5Rvga1YUNsPx8K
 8XpJbo37GI9FQVSkGWkzSWJBoezzE1oA8aj21oKaAudiOtsrEj2raNcQJLwvlgQTDXbD
 SkfZe9cp17iJbI7wb+uuP0Bj8fHVUndhzh9qwUC/mbZV09DapoywLrnB+KM5J8Fj0uv2
 ykHmRZUHccvGeAlhQwg15sq2pV1UMdc4c/yD9ZHqBxoj+tunp+enKLiOwxjF1lAnnUI8
 WrfkDXCM7vUeUU/x1X3z+On0wa0tjKqNLojz6N/Z1WfpzW/Yrxq6p5GlX7YiVF9zBP5u
 lv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=qnscpdgLAj4kkHeVRuIgfy6ygA8ftW0KT2DOymw+8xo=;
 b=qMZpyShi/R8rhjW/+QkO1XuopZbmwbDtAPfs8LWBhdUfJvLj5dSBF1BCn1whIHgqP5
 pFSu4awAt4YOHJnTIuHcIvqkWSVudnPoyBOKH7BaLrUgtsvTw1wmfCKWcCp3JKvhK1Gx
 5EIg+EdH3QagndWOLatoCeTP7K5Cg8/VbNlZsnedd2/qZgi1gd/loHcNdSYENrCkCUMC
 ebd46fEQWHOsburVUwoeeo9OMIQtdNSwBVdyPvVKudm4jLZ5ip6RvgJOnOXrIqgrBKpf
 x27mdx96s3lZ1Z7Sx8C9/WnN7U0ZXBOYaZOtVRglxRQ4JFYNq8wowdXzPYGqDFYHnTtE
 KmKA==
X-Gm-Message-State: AOAM533dlTTWub4oM19+bZ8AXvHZW5BFVjCnwkUPMUmL5tM/KG6vKTjX
 wobzjcc7MhxxMVvP7m1mHI2JqIWjC9g=
X-Google-Smtp-Source: ABdhPJw0nkrZn9nUHm3JjlLEMbvL/wSduM1p7d6xiEQT1/oHPF8vPsKQXS7gJ7GKTuGdsoHorE1cvA==
X-Received: by 2002:a17:906:715b:: with SMTP id
 z27mr371698ejj.166.1601321502941; 
 Mon, 28 Sep 2020 12:31:42 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id p12sm2406808ejb.42.2020.09.28.12.31.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2020 12:31:38 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/dc: Pixel encoding DRM property and module
 parameter
To: James Ettle <james@ettle.org.uk>, Harry Wentland
 <harry.wentland@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <7cc7d590-f713-2060-6bac-37bed0df618a@ettle.org.uk>
 <CADnq5_OEzoEP93+MsGN1tspy0OrxVTkujKUhs+6LryVApvERkw@mail.gmail.com>
 <286845a3-4903-c169-aa36-1eb986492ea3@ettle.org.uk>
 <CADnq5_O8Wzddr3LryTuQ5Jqc5yt51wqkxv6zbSbr0_RBSQCA4g@mail.gmail.com>
 <967f82b1-cf5b-473b-c9b3-d9f9df588cc7@amd.com>
 <ad59a8c59d52c40a89b7b4fd032df043e0747f27.camel@ettle.org.uk>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6583647a-7147-4f5b-0412-d3be77ca7fe2@gmail.com>
Date: Mon, 28 Sep 2020 21:31:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ad59a8c59d52c40a89b7b4fd032df043e0747f27.camel@ettle.org.uk>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: Harry Wentland <hwentlan@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.09.20 um 19:35 schrieb James Ettle:
> On Mon, 2020-09-28 at 10:26 -0400, Harry Wentland wrote:
>> On 2020-09-25 5:18 p.m., Alex Deucher wrote:
>>> On Tue, Sep 22, 2020 at 4:51 PM James Ettle <james@ettle.org.uk>
>>> wrote:
>>>> On 22/09/2020 21:33, Alex Deucher wrote:
>>>>>> +/**
>>>>>> + * DOC: pixel_encoding (string)
>>>>>> + * Specify the initial pixel encoding used by a connector.
>>>>>> + */
>>>>>> +static char amdgpu_pixel_encoding[MAX_INPUT];
>>>>>> +MODULE_PARM_DESC(pixel_encoding, "Override pixel encoding");
>>>>>> +module_param_string(pixel_encoding, amdgpu_pixel_encoding,
>>>>>> sizeof(amdgpu_pixel_encoding), 0444);
>>>>> You can drop this part.  We don't need a module parameter if we
>>>>> have a
>>>>> kms property.
>>>>>
>>>>> Alex
>>>> OK, but is there then an alternative means of setting the pixel
>>>> encoding to be used immediately on boot or when amdgpu loads?
>>>> Also are there user tools other than xrandr to change a KMS
>>>> property, for Wayland and console users?
>>> You can force some things on the kernel command line, but I don't
>>> recall whether that includes kms properties or not.  As for ways to
>>> change properties, the KMS API provides a way.  those are exposed
>>> via
>>> randr when using X.  When using wayland compositors, it depends on
>>> the
>>> compositor.
>>>
>> I'm not aware of a way to specify KMS properties through the kernel
>> command line. I don't think it's possible.
>>
>> For atomic userspace the userspace wants to be the authority on the
>> KMS
>> config. I'm not sure there's a way to set these properties with
>> Wayland
>> unless a Wayland compositor plumbs them through.
>>
>> Can you summarize on a higher level what problem you're trying to
>> solve?
>> I wonder if it'd be better solved with properties on a DRM level that
>> all drivers can follow if desired.
>>
>> Harry
>>
>>> Alex
>>>
> The problem this is trying to solve is that the pixel format defaults
> to YCbCr444 on HDMI if the monitor claims to support it, in preference
> to RGB. This behaviour is hard-coded (see the
> comment fill_stream_properties_from_drm_display_mode) and there is no
> way for the user to change the pixel format to RGB, other than hacking
> the EDID to disable the YCbCr flags.
>
> Using YCbCr (rather than RGB) has been reported to cause suboptimal
> results for some users: colour quality issues or perceptible conversion
> latency at the monitor end -- see:
>
> https://gitlab.freedesktop.org/drm/amd/-/issues/476
>
> for the full details.
>
> This patch tries to solve this issue by adding a DRM property so Xorg
> users can change the pixel encoding on-the-fly, and a module parameter
> to set the default encoding at amdgpu's init for all users.
>
> [I suppose an alternative here is to look into the rationale of
> defaulting to YCbCr444 on HDMI when the monitor also supports RGB. For
> reference although on my kit I see no detrimental effects from YCbCr,
> I'm using onboard graphics with a motherboard that has just D-sub and
> HDMI -- so DisplayPort's not an option.]

Ah, that problem again. Yes, that's an issue since the early fglrx days 
on linux.

Shouldn't the pixel encoding be part of the mode to run ?

Regards,
Christian.

>
> -James
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
