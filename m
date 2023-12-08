Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8D0C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 16:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF8D610EAC0;
	Fri,  8 Dec 2023 16:43:04 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3169810EAC0
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 16:43:02 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3316c6e299eso2329407f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Dec 2023 08:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1702053780; x=1702658580; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JeDmW7piUQLAQYMxFz/XOJACePOjYNCLfJDVAIy3HUs=;
 b=YwV5jz6gayQT1Req1udoV1Rw3CdnpBViFXoXxCb4QJni5ACXL5b6mwmoSIc3G0cE41
 y8ZLHxQJG/OxmSQRDbfxn26bx1WOZ+dEpOicPJJ8eKHJatma7j2flOaxo+TN7JR65Knj
 0Bj+6k/Ob2sDNVe+VqZEVzzQvsDfZvOKQQLOmQPIrCb+eZcEMDPRyqflX+0zUX82EV9a
 euw+2c3uFEXKiGLMxFweR+NJZnBloPrGv8qMdORKbICk6tnbanmuv+hNs2Dphz17/8wX
 NGDYSQbX4k4ybPZhshFJN5maNV4Tp/sTuZxyXlPaS3+gBcKyE2B4hriYTFP7JaXk+7qZ
 Mq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702053780; x=1702658580;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JeDmW7piUQLAQYMxFz/XOJACePOjYNCLfJDVAIy3HUs=;
 b=FeQ/whu7Ao1JmXRec1f9tuLJyWWKn5+hHUpQV5DsI9rnr0PHtaCiPPzbsOFSnAzhg6
 gJHFOqPkBcNplHCx4hXyFkKovEjym/+OzMaPaOEtINlIlvkrpYIEjotLVETDSiwpr2r3
 4OFvw5XppPlQ4yPzeWzpD1V6d2L7sCvOOlYn/nifBA9GIdhKWOS25hdQDsTl2hz0tROq
 6uGPn8zJZo2sipIYJoFxhW3JIFi9Ya++kd87XY0Ez8pOzkT4FD/jDynvIxxjiszB18uW
 nkAumIL1QoZn4R5BYDBEV/9nWr/pVCpvp/yKxXbN1z0xprHttqNJl0FLIzcR8T/EqaA7
 w5Mg==
X-Gm-Message-State: AOJu0YyZAzYKgJtuCGsxephN5c5Y35oJwoYYdbCIXP8/kf8kH/T99PQs
 ogyp9PAoGnl9thIyWWqYDiEOd4MIzyI/xzUVI88=
X-Google-Smtp-Source: AGHT+IE6JSMfTWdkAI6pLPp3+CatWzuKs0ZAle8rta7x9459Vd1DpTJBBnrBVLy1jskTAT8fzCg3Zg==
X-Received: by 2002:adf:ecc2:0:b0:333:2fd2:3c0d with SMTP id
 s2-20020adfecc2000000b003332fd23c0dmr130338wro.198.1702053780240; 
 Fri, 08 Dec 2023 08:43:00 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 n13-20020adff08d000000b00333590f3bf9sm2398122wro.19.2023.12.08.08.42.59
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Dec 2023 08:42:59 -0800 (PST)
Message-ID: <5de028e5-d24c-4e98-96aa-e3d18720ab6a@froggi.es>
Date: Fri, 8 Dec 2023 16:42:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Enable tunneling on high-priority compute
 queues
To: amd-gfx@lists.freedesktop.org
References: <20231202001740.120840-1-friedrich.vock@gmx.de>
 <3525f437-9537-4fb4-80d0-65acd9d55d2f@gmx.de>
 <3cf226b8-c80b-43f6-9f6c-9610d224717a@amd.com>
 <1939f568-f780-4e34-b5c5-dab461f93b57@gmx.de>
 <8041be7c-64d5-4b1d-a734-4326db98f256@amd.com>
 <CAAxE2A6Kdj5TBCdZRoT_t+cABzf9tsNCvJLZAVCE66F5pz5yXQ@mail.gmail.com>
Content-Language: en-US
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <CAAxE2A6Kdj5TBCdZRoT_t+cABzf9tsNCvJLZAVCE66F5pz5yXQ@mail.gmail.com>
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

FWIW, we are shipping this right now in SteamOS Preview channel 
(probably going to Stable soon) and it seems to be working as expected 
and fixing issues there in instances we need to composite, compositor 
work we are forced to do would take longer than the compositor redzone 
to vblank.

Previously in high gfx workloads like Cyberpunk using 100% of the GPU, 
we would consistently miss the deadline as composition could take 
anywhere from 2-6ms fairly randomly.

Now it seems the time for the compositor's work to complete is pretty 
consistent and well in-time in gpuvis for every frame.

The only times we are not meeting deadline now is when there is an 
application using very little GPU and finishes incredibly quick, and the 
compositor is doing significantly more work (eg. FSR from 800p -> 4K or 
whatever), but that's a separate problem that can likely be solved by 
inlining some of the composition work with the client's dmabuf work if 
it has focus to avoid those clock bubbles.

I heard some musings about dmabuf deadline kernel work recently, but not 
sure if any of that is applicable to AMD.

- Joshie 🐸✨

On 12/8/23 15:33, Marek Olšák wrote:
> On Fri, Dec 8, 2023 at 9:57 AM Christian König <christian.koenig@amd.com 
> <mailto:christian.koenig@amd.com>> wrote:
> 
>     Am 08.12.23 um 12:43 schrieb Friedrich Vock:
>      > On 08.12.23 10:51, Christian König wrote:
>      >> Well longer story short Alex and I have been digging up the
>      >> documentation for this and as far as we can tell this isn't correct.
>      > Huh. I initially talked to Marek about this, adding him in Cc.
> 
>     Yeah, from the userspace side all you need to do is to set the bit as
>     far as I can tell.
> 
>      >>
>      >> You need to do quite a bit more before you can turn on this feature.
>      >> What userspace side do you refer to?
>      > I was referring to the Mesa merge request I made
>      > (https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/26462
>     <https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/26462>).
>      > If/When you have more details about what else needs to be done, feel
>      > free to let me know.
> 
>     For example from the hardware specification explicitly states that the
>     kernel driver should make sure that only one app/queue is using this at
>     the same time. That might work for now since we should only have a
>     single compute priority queue, but we are not 100% sure yet.
> 
> 
> This is incorrect. While the hw documentation says it's considered 
> "unexpected programming", it also says that the hardware algorithm 
> handles it correctly and it describes what happens in this case: 
> Tunneled waves from different queues are treated as equal.
> 
> Marek

