Return-Path: <SRS0=6vDE=62=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6D4C54E4B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 08:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C2452078E
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 08:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJgtVvUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2452078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FFC86E865;
	Tue, 12 May 2020 08:11:48 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF6F36E865;
 Tue, 12 May 2020 08:11:46 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id w19so7436407wmc.1;
 Tue, 12 May 2020 01:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=qF7Shrx1TQyNZee+zwTlCbN+EEOjMmwCAV1oyGKvE1o=;
 b=KJgtVvUP/hMvgrFxSXS18lilSrg04fBPYEG3mf2tp0iZAEeyvf1OBhq5IKOQkv900m
 KLaIe4rhLllaawMidYSOUIfxCTfT9Pfoqwp+OqpRMiNfAXgbSTQcJpCCscJ81Riminkw
 f5zItlr6dbqOwPz3/podY0Kku4rTC9qErZM0TVSGMoUve0GOSIk+557FQolQQKQI/9Ku
 7DRZ3PTq4M4DRXCZGqHWpbjXJecPW2+OeW1nxLkodAFI7msc0N5u5GdI+3dxdJZslO+B
 MkAbtt8nuaibytUEWXO12j+EBbgZIupamz8Hl+4OwK+W0xZrbuir9NJGN+p/grodvndR
 0xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=qF7Shrx1TQyNZee+zwTlCbN+EEOjMmwCAV1oyGKvE1o=;
 b=I6duEg3QTw4aJTk3nprvhuyY0aAXVdR9//Iv8SPy2KmBc8w3j80fYmogbVnn2Yr7tT
 Sj034zkraWADXZ/UF4iZff+WyM1KnVEKpqGkMX/EkLRuWm6V0IYHVYfH/zOAhROHBsNL
 v7zZdC0RhIwltrR6rMlJ8xuv6b+shlPPEsw9tWCaa4lYuuGXzAIHrtOmmzPgYZ3Wq5qp
 1BYpEpZ9elFudclBf512K+CNpVgIIaoh/IqfOZQ1Caqcq/D9JyVR+QsTqSwPu3ifbjou
 qgaxPP4454IQ3rHd97iHMZs5F+9dkFDBeJta8hQy7c2i4wRSGy73kh/ICeXHjWqsKuNF
 zHfA==
X-Gm-Message-State: AGi0Pub16Q6MJ04jD8viD/uYCHpTjqRK9hmlBmuuaGAoiQj8eEhIMbgJ
 JevHD4k0M7AsmAs3A1KRwBdt/d52
X-Google-Smtp-Source: APiQypJK4KFbzAbpXsacXsh8WrIZpsdiMI3gZucK8r4OSRLQc3MHwOKQwD4YN5tn3TMFp4AXSbfC0w==
X-Received: by 2002:a1c:f712:: with SMTP id v18mr16471174wmh.27.1589271105126; 
 Tue, 12 May 2020 01:11:45 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id 77sm22108480wrc.6.2020.05.12.01.11.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 May 2020 01:11:44 -0700 (PDT)
Subject: Re: [RFC] Remove AGP support from Radeon/Nouveau/TTM
To: Al Dunsmuir <al.dunsmuir@sympatico.ca>, Dave Airlie <airlied@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20200511171722.96576-1-christian.koenig@amd.com>
 <1815605280.20200511161440@sympatico.ca>
 <CADnq5_MYPcAoWzCcBkJAkd858gCVbJpCJobiwH_BBbwgEdx5rA@mail.gmail.com>
 <CAPM=9tysbcgQ-KR8+icQ=3e6+SECxkwHdVpP8=w0Pmh9ML_+Lw@mail.gmail.com>
 <1266714942.20200511165648@sympatico.ca>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7a506bb2-1bde-ebde-9bf1-bc115b99e873@gmail.com>
Date: Tue, 12 May 2020 10:11:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1266714942.20200511165648@sympatico.ca>
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
Cc: nouveau <nouveau@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.05.20 um 22:56 schrieb Al Dunsmuir:
> Hello Dave,
>
> On Monday, May 11, 2020, 4:43:01 PM, Dave Airlie wrote:
>> On Tue, 12 May 2020 at 06:28, Alex Deucher <alexdeucher@gmail.com> wrote:
>>> [SNIP]
>> Maybe we can find some way to compartmentalise AGP further?
>> Dave.
> Significantly   reduced  caching  on memory accesses definitely sounds
> like something that would be noticeable and objectionable.
>
> I would speculate that this would also vary a lot across chipsets,
> depending on the capabilities of the PCI MMU vs the AGP MMU.
>
> In the end, it may be best to leave things as is, or as Dave suggested
> try to keep AGP in the picture.

The problem is that AGP was never really supported/implemented that well 
in the first place.

The fact that the core linux kernel and the DMA API doesn't support 
uncached memory and we had to change the caching attributes of pages 
under the hood has resulted in a huge number of problems over the years.

Keeping it as it is is also not a really doable option because TTM 
already has major problems keeping up with the requirements for modern 
hardware, see my presentation here as well: 
https://fosdem.org/2020/schedule/event/ttm/

Redesigning the old AGP support into something which isn't so ugly and 
doesn't blocks the new requirements has the huge risk of breaking things 
even harder, e.g. black screen instead of just reduced performance.

So removing/disabling AGP by default still sounds like the best option 
to me for end users.

> Nothing is ever simple, is it?

At least not with AGP, no :) It has been a total beast to support and 
keep working.

Do I get this right that I can ping you to test things?

Thanks for the feedback,
Christian.

> Al
>
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
