Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8A4C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 17:37:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A086135D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 17:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 43A086135D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=froggi.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F1366EC39;
	Thu, 30 Sep 2021 17:37:13 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23B286EC39
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 17:37:12 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id s21so11363740wra.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=froggi.es; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=wacmp0Jhqt+6kuppPQrZR6hUDIFz8LetkGlBKTuPG2g=;
 b=KPnScAwjgN3rs1QBiU3QxJjT7q3zahH1m0o2h/PRjxZdBGevKRPfJZsLiZt8q83RkZ
 LDpaeJ+XUcA2thKuYmkfcfNKWoMnpCEBdJH6bVCqjPoqRBgK4P+lHOXVfYwjYPrBoSBU
 Fk7D3S4jS5tqsipMpLPcilpUWw5MNY+gi5ur/sKSwg6qVOeAgvG0WFOvOpNwWygfjVvo
 50mDZLH9u86/WSfBMbc4mrLz8a//KC+D3HSDmUsL70G14Sy1j6j7eVaxr6Qg1E51y7Bb
 rES3RlbaXFVAqoAAxAG5kfiJqH40G8zlvobYsGdOHPLEPmwN/SdfYDn1pFYWYK1XIS0+
 kWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=wacmp0Jhqt+6kuppPQrZR6hUDIFz8LetkGlBKTuPG2g=;
 b=52XGB11o8ikxJ42S9QWecw8Qv+IEOZ/8UgWST9Kvql//yBZZp2DlsU/pWpEWW+niit
 TFfans7DdPYZJefR/7aBMTY7vDCgJLuTDlLux6tOdw0pZWXjaJMSpG9KOra0pKPgYWXF
 M6NYirg+zvBXCy7lyNoUEXokrLcwbYVF1bsZdYeEaHCIdgo97sKNjK3fML4T9MT4j/ZM
 eSksA3PhacJl9GypiE5jcGwkZ2y67qW/EW8/VGHNumTTYGt1KZChklbJH3DwtzpmKm3B
 EdfLKcVe9hBZBKOV16YPR0GucOSZlDGTZYCwe2As2803pms3a5UvMLw+cVTraf8L5e8S
 Bn+Q==
X-Gm-Message-State: AOAM532T3wsBxNefa6xRg7lc6pmL/w5Qn+NbmDDnOUeB3xz1r39Vm5mH
 UKdcX+kxRQohz2O0rCz9dJXUB/GfBpGUh7BxHHk=
X-Google-Smtp-Source: ABdhPJxo1C6cwHgGP1VgaRQjg7UHxAAJ++G5JBUEOqMF57KdP63oXjom9jcNeKyma139vhCZDYDfvA==
X-Received: by 2002:adf:ee4d:: with SMTP id w13mr7272386wro.223.1633023430583; 
 Thu, 30 Sep 2021 10:37:10 -0700 (PDT)
Received: from [192.168.0.61]
 (cpc89720-darl9-2-0-cust754.11-2.cable.virginm.net. [86.2.110.243])
 by smtp.gmail.com with ESMTPSA id r16sm2259885wrw.74.2021.09.30.10.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Sep 2021 10:37:10 -0700 (PDT)
Message-ID: <9c57cceb-5a33-e1fe-de76-adf0992067c0@froggi.es>
Date: Thu, 30 Sep 2021 18:37:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] drm/amd/display: fix DCC settings for DCN3
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
References: <CAAxE2A6a45Vebk4FhH__FG66zDn0m6GbJgK3Bz3o8obePW5P_w@mail.gmail.com>
 <CADnq5_Ps0j20jOkEuU3xJi=v6Qbvp66dFdZOdYrCSn6Q6uknSQ@mail.gmail.com>
 <CAAxE2A6mjGL27dGpq1GCGspsa7CffSGO9MhW8LmFmbZ=JzTr_g@mail.gmail.com>
 <63cbb603-88d4-c1ac-0ead-fd4e0132aa1c@froggi.es>
 <CAAxE2A7d4gsSiGv+JSnfrK4RudRKzmLd86gjLZkMJcjzoGXzXQ@mail.gmail.com>
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <CAAxE2A7d4gsSiGv+JSnfrK4RudRKzmLd86gjLZkMJcjzoGXzXQ@mail.gmail.com>
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

Thanks for the info!

- Joshie 🐸✨

On 9/30/21 18:33, Marek Olšák wrote:
> The name is kind of correct. It means "64B with no 128B cache line 
> straddling", which really means just 64B independent blocks with a small 
> modification to support DCC image stores.  They are not true 128B 
> independent blocks.
> 
> Marek
> 
> On Thu, Sep 30, 2021 at 12:35 PM Joshua Ashton <joshua@froggi.es 
> <mailto:joshua@froggi.es>> wrote:
> 
>     Can we please add documentation for this enum?
> 
>     This was not necessarily a typo, but me misunderstanding and stuff it
>     working in my testing.
> 
>     I guess I don't understand why hubp_ind_block_64b_no_128bcl is for 64b
>     && 128b when it specifically says "no_128" in the name.
> 
>     Is there something about it I am missing or is it just misleading
>     naming?
> 
>     - Joshie 🐸✨
> 
>     On 9/30/21 17:14, Marek Olšák wrote:
>      > I've also amended the version bump that I forgot to do:
>      >
>      > -#define KMS_DRIVER_MINOR       43
>      > +#define KMS_DRIVER_MINOR       44
>      >
>      > Marek
>      >
>      > On Thu, Sep 30, 2021 at 12:06 PM Alex Deucher
>     <alexdeucher@gmail.com <mailto:alexdeucher@gmail.com>
>      > <mailto:alexdeucher@gmail.com <mailto:alexdeucher@gmail.com>>> wrote:
>      >
>      >     Acked-by: Alex Deucher <alexander.deucher@amd.com
>     <mailto:alexander.deucher@amd.com>
>      >     <mailto:alexander.deucher@amd.com
>     <mailto:alexander.deucher@amd.com>>>
>      >
>      >     On Thu, Sep 30, 2021 at 11:50 AM Marek Olšák
>     <maraeo@gmail.com <mailto:maraeo@gmail.com>
>      >     <mailto:maraeo@gmail.com <mailto:maraeo@gmail.com>>> wrote:
>      >      >
>      >      > Hi,
>      >      >
>      >      > Just discovered this typo. Please review.
>      >      >
>      >      > Thanks,
>      >      > Marek
>      >
> 
