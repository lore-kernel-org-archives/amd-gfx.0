Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA09FC3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 18:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 336FE10E37A;
	Mon, 15 Jan 2024 18:35:23 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB6610E37A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 18:35:21 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3368b9bbeb4so8186775f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 10:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1705343720; x=1705948520; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V8+w3SmbM2VVP0tTGj46PcPFAbKrGw9VTZYzsU4heAM=;
 b=GQuIspJ/fCSb1NO/OOS6ZJoWH0Lb+ML6Mhr7h2ECGP34MV0RlzUnC0vIzvQy8j38jY
 JRa9ID85Zfi2O+bVg4ZsMqUvbnnvQnUFFIISJdGHdYSa/mbOLJaTX/r3w5X7YtTVlObp
 eo/zL33yHeOE3zPJCC3d2THMFgV0OO3bVd66dsyAoo6qDM5asfwGUG6sy/8PE8Gl6wcw
 Endl5cw5uV8BGKIxcNj5Mcz8qwoOjjHS4tzYLkeDZqZaYn1ifxrYyo0JDbXttYcqr+7i
 fWnybr6JGPd9Vj2MH0fl/a8HX1nGGIahX/X3JCz85OofH1hL08o/TwFiIdAr2n+CDOAu
 8Xcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705343720; x=1705948520;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V8+w3SmbM2VVP0tTGj46PcPFAbKrGw9VTZYzsU4heAM=;
 b=M+jXAK4vk60WYZl6VR3qVgmCTSf6nuGhKbMglOGL6JMm1hhNDE+VMo6OsGgDFM+q49
 R9VcI5jwDZRmx0mS4bH5ufrIRyEzQzdQuLtnK0nuAbpG9xf4tZG54EQp9cGfAl0+abz6
 wqw5u39KybzeXBvtob24q9zx53m4uELRtIHTYMqtA4qMbUSCJIwgrQaZRhA6EPylVNoQ
 cddwdKrQiVXS15L4moQRbZUXYbLZxbDEetc6dC+hAKjLT8wrNT5no6zDAP3nR9wqsv2L
 pZFsEyfndc3TR2iket/4rAS4Kxoa+f6ceL84uSFZaYQM6jhiZ7vg8h1e7dgvQHEhtrHw
 KHAA==
X-Gm-Message-State: AOJu0YzrLfWbLLL27lcq01im3PwVkh7AiBEGhxUYOKYLevvfC1IcGK3u
 O9m3Cob7J4O2ynsOYxi9LeIFKQ9ntEXAKw==
X-Google-Smtp-Source: AGHT+IEoT3u2bC/Upm0liPVS0BWuMzz284crGhHTLg1Pu8hAKS3IYTuBVWY5of5aiwlFlIE8RRcttQ==
X-Received: by 2002:adf:f48b:0:b0:336:7e0f:2b67 with SMTP id
 l11-20020adff48b000000b003367e0f2b67mr1667394wro.44.1705343720400; 
 Mon, 15 Jan 2024 10:35:20 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 v16-20020adfa1d0000000b003379d475928sm7486408wrv.18.2024.01.15.10.35.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 10:35:20 -0800 (PST)
Message-ID: <81a82ffc-c2e6-4ce6-9cc0-4f01dc8b9891@froggi.es>
Date: Mon, 15 Jan 2024 18:35:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Friedrich Vock <friedrich.vock@gmx.de>
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
 <c9b839cd-4c42-42a6-8969-9a7b54d4fbe8@amd.com>
 <0e701278-a633-403c-b397-e4f772d66c5a@froggi.es>
 <aca706e6-58bc-4c38-bbfe-19137f38c897@gmail.com>
 <9a07c4e4-321c-4f75-aeae-81ed90038365@daenzer.net>
 <f2153219-e791-4e97-96eb-26094d7acf87@froggi.es>
 <5c99ec8c-142d-4877-9624-c8ce0373fccd@gmx.de>
 <5ff32f43-46ea-4e74-8db4-c23e0b03b429@daenzer.net>
 <8e5cd59e-075a-480e-8452-87924580122d@froggi.es>
 <1dbe811f-64a0-4ccd-88cf-3fd30f79f7bc@daenzer.net>
 <c36400bd-b8f2-4026-b989-f4e1854b05ca@gmx.de>
 <7194a09a-afe8-4eae-8288-c72e2ac7d0a6@daenzer.net>
 <51b9ffc3-9ab3-4a06-9307-6b2a343f6bc6@gmx.de>
 <CAP+8YyGg91f_z2ktrd7HQMtOSHn34F-8x7O2iRv=TTrXo2NNoA@mail.gmail.com>
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <CAP+8YyGg91f_z2ktrd7HQMtOSHn34F-8x7O2iRv=TTrXo2NNoA@mail.gmail.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/15/24 18:30, Bas Nieuwenhuizen wrote:
> 
> 
> On Mon, Jan 15, 2024 at 7:14 PM Friedrich Vock <friedrich.vock@gmx.de 
> <mailto:friedrich.vock@gmx.de>> wrote:
> 
>     Re-sending as plaintext, sorry about that
> 
>     On 15.01.24 18:54, Michel Dänzer wrote:
>      > On 2024-01-15 18:26, Friedrich Vock wrote:
>      >> [snip]
>      >> The fundamental problem here is that not telling applications that
>      >> something went wrong when you just canceled their work midway is an
>      >> out-of-spec hack.
>      >> When there is a report of real-world apps breaking because of
>     that hack,
>      >> reports of different apps working (even if it's convenient that they
>      >> work) doesn't justify keeping the broken code.
>      > If the breaking apps hit multiple soft resets in a row, I've laid
>     out a pragmatic solution which covers both cases.
>     Hitting soft reset every time is the lucky path. Once GPU work is
>     interrupted out of nowhere, all bets are off and it might as well
>     trigger a full system hang next time. No hang recovery should be able to
>     cause that under any circumstance.
> 
> 
> I think the more insidious situation is no further hangs but wrong 
> results because we skipped some work. That we skipped work may e.g. 
> result in some texture not being uploaded or some GPGPU work not being 
> done and causing further errors downstream (say if a game is doing 
> AI/physics on the GPU not to say anything of actual GPGPU work one might 
> be doing like AI)

Even worse if this is compute on eg. OpenCL for something 
science/math/whatever related, or training a model.

You could randomly just get invalid/wrong results without even knowing!

Now imagine this is VulkanSC displaying something in the car dashboard, 
or some medical device doing some compute work to show something on a 
graph...

I am not saying you should be doing any of that with RADV + AMDGPU, but 
it's just food for thought... :-)

As I have been saying, you simply cannot just violate API contracts like 
this, it's flatout wrong.

- Joshie 🐸✨

> 
>      >
>      >
>      >> If mutter needs to be robust against faults it caused itself, it
>     should be robust
>      >> against GPU resets.
>      > It's unlikely that the hangs I've seen were caused by mutter
>     itself, more likely Mesa or amdgpu.
>      >
>      > Anyway, this will happen at some point, the reality is it hasn't
>     yet though.
>      >
>      >
> 
