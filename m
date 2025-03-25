Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DA8C3600B
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 12:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8899610E572;
	Tue, 25 Mar 2025 12:42:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gJHACkYl";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 663C810E1C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 09:55:09 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-5e8484bb895so1570723a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 02:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742896508; x=1743501308; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e46YpXruJuoobysGWwDzJX1JxIE+YHsBIBB83NovnA4=;
 b=gJHACkYlNrKxN2gh0ME/u3b4nt6lVMdfT8HLLEnjb6vonX4e0Uw+18ujmM/9HsGc7b
 ciHXpiLTuT8X9cqa7nrbev/UjxEtx1YXGr787s/Zhyl+j8ZCbNDHlDGCYF5M2c3Vh6FC
 meDPJk/tbQn0xvY4sukYo7Vmg8Xk3wRskrqhhnXfIDJf3l4oXCq2ccO/Xf9oc9Ry/WSn
 TdpCY7uMUkbskFvvRkGtQ24chSWt1edrHJOVJJqVpfyqZniaX3vVzFHk7wo7o/JHX5xo
 ZY5UyEZvF5gmiE/LHnPtYJTuCfjp0v9k6PffoYi9MtWSv2D9XP+t3m4aY8SmCfqtRcLN
 JbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742896508; x=1743501308;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e46YpXruJuoobysGWwDzJX1JxIE+YHsBIBB83NovnA4=;
 b=hL+/yJWiz2obtN0k4kJKY79pwOsSjHfST73RrqE9AIS57Xm8zAYF8el9++TezuWIn4
 6S4DwKrNN1pTV96HopnLuNAnHGd4pxLqGls2pIvaZ7RBpbBqM7g8/JA8t7saoXKsWIfT
 B8c60NCbn/57YTtWH2TMkiEqX6rT8lA7BDckv5XKzcnT27Aee1lmB0kFfXI2cgRkAvzn
 QeeIrN2A7uUM+yrELR6unjBa2MygeVCqGpC/Xlt5rkyymZpJFpJwC2zkouwlu+Rknbi+
 XtPamdz2of30XVplRhCi0+NLwx70Yxs/zLmsO/sYeoo7l/AXs9hS2JTjkqUtIqdMF0bp
 Unmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcs2pQDoszXjJfFSaq6f7+dccn5wP07gGJWIDFccq5TkHWSLhhjdofqefzgfr36d/cXDg/yfQz@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx07nEmoycJ9otHuYCvxtb3FgoacMEIIRCIPRUr+tr0AH4jjvVN
 KkMNz5T4ucWr2WHxMLZ5yt7Sge/B4ySBV1QGZWiGBFJznbLIx1eqKuW0MTousEo9O4W4Snc24EP
 i7RiMjFaasC1bBjjlnb1ZfKs9ptXzH+bs
X-Gm-Gg: ASbGncu9SrNwR8a4UjDK1NOxX0IYZYZGatkL3XCNymnIPeNawgbtduX0wnwfRIlb8Pv
 4gdl1Sxw7k379kMktGLuEOey8VwwE2bsvSjgbGCuwhIMBXocU9NMwIkXFBIrG0AFSntCafI8DOi
 1IcEO7apmLZj/hdRvbqFz6Syzb
X-Google-Smtp-Source: AGHT+IHWe2iEBhIkaQanpziBrSZsxBmToPejcbiurYgttyKZ7GOkF0hP2dcFhdEQ+nohbU/SrPC9Hj8uNMlegan8KI4=
X-Received: by 2002:a05:6402:354e:b0:5dc:cea7:4e2 with SMTP id
 4fb4d7f45d1cf-5ebcd4337d7mr5226605a12.4.1742896507617; Tue, 25 Mar 2025
 02:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250315201558.339913-1-tomasz.pakula.oficjalny@gmail.com>
 <20250315201558.339913-3-tomasz.pakula.oficjalny@gmail.com>
 <DM4PR12MB5165690B22C63D856BFFD7708ED92@DM4PR12MB5165.namprd12.prod.outlook.com>
 <CAFqprmyv+WXmBWwOa3uPuOkmLtrkfc7jEXquXEyb-Bjuni_jBQ@mail.gmail.com>
 <CADnq5_NV4hiQCHB7-YE=cN2NNS4AeHsnxntJfQ5a+iiYOaiYGA@mail.gmail.com>
 <CADnq5_OxT2qfxdPAg5=w1PeOBhQdCL-He2rBJOireSidBz9DKw@mail.gmail.com>
 <DM4PR12MB51657FD3B25C2F01340701B98ED82@DM4PR12MB5165.namprd12.prod.outlook.com>
 <CAFqprmxwYYRRzv28ETV_fVF2z=saUuSjaY0Z3aTiEefyq9BKYw@mail.gmail.com>
 <DM4PR12MB516540EA11DBB4E08C4003DE8EA72@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB516540EA11DBB4E08C4003DE8EA72@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
Date: Tue, 25 Mar 2025 10:54:54 +0100
X-Gm-Features: AQ5f1JpmKq__C3PnZ9V727ENi8VsHz-_VGBE2akDpaCJIu6JJmialgkqE_0F6MM
Message-ID: <CAFqprmxrGQri3Lnk8HaGYW_cXD_JR8Fvfa+8_a6ee25qjqLJoA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: add zero RPM stop temp OD setting support
 for SMU 14.0.2
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 25 Mar 2025 12:41:59 +0000
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

On Tue, 25 Mar 2025 at 05:36, Feng, Kenneth <Kenneth.Feng@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Tomasz,
> We can only have zero rpm on/off setting.
> After confirmation, the fan stop temperature setting is not exposed to algin windows driver.
> So the fw always pick the default value. I know it may be not reasonable but it is the truth.
> Thanks.

Yeah, no problem. I just hooked it up as I've seen the interface
but I don't mind it not being accepted. Actually, I tested this setting
a bunch yesterday and it seems like it's not actually working. It
accepts values, exposes limits etc but it has no actual effect on the
stop temperature. It's always 50.

To be perfectly honest, I never actually understood why this setting
lets people adjust temperature up, instead of down. I don't think I would
ever want my fans to only engage when my GPU hits 110 degrees :)
If I ever wanted to adjust this, I'd like to lower it instead.

Still, thanks and I'll send the first patch as a standalone one.

Best regards,
Tomasz
