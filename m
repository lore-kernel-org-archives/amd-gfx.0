Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEC6C35FFC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 08:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91CD010E505;
	Tue, 25 Mar 2025 08:21:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y5RV/eGh";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1C2610E305
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 21:09:44 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-5e83e38d15dso851537a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 14:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742850582; x=1743455382; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XuE4ka5+0QaFAwTie8mDkT0SV4bl2007kkc2u8mE388=;
 b=Y5RV/eGhqs7WZitil5UPt0B8ZxZpyC8iEZdBdHw5+0XGWQDxsrMawE3Kz0Vtp596Gg
 fjOIb1PTfT+27BY1NVpeDdv6HzdClC2f37FE2Ud/WE2cKymFr14pZ65PAWjTpD7RBjhE
 dLASqI9Smwahj/BUB2MO8P/IVwSPGn3I/MBbVWpJ8Vdg1tOWNWcXS1RJ8v6c+8JbGLF8
 GilhkZw5VNeTU+PvPn7qWNbvow4SPsezD/Zjm8MLmGiqSOHyK+aXngtyEkB6KmEwM1cp
 D1VCjilS3hIHfzPX/Ppxa2Huzi0f+yx6kfZU54xpO42ebMmG5yQeioH8x57HHXbNN/vN
 kG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742850582; x=1743455382;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XuE4ka5+0QaFAwTie8mDkT0SV4bl2007kkc2u8mE388=;
 b=JgFNEza6yt68PCDbLiyvJ2ojcNTdyF9IH8xdzFsUyNyLz1e/QP2ZacdA2nQ8iUW0cN
 kFgJ+FsQVFka0GSlyBAtHdaleecAZDXG26e+dAhHmZ9MeWr70aXx004OIo0neopyhIE/
 uStt8kB1Ie7Fy8NKU3VYl+6ome+COjT9xI/VIka4073vAA3Ut87T4u17FdF9njX0ypuP
 gUiRrbI0zIJ1fpgp2kWFec0/ohiQUgQXOXWILVnh1T6IAdJ/bcLEQdU8gkTF4jJ/KebX
 q3KNWdeDw1SnvUptHQ5hFlZ+hCzPS8ugYNyW4ZU4zJ2Pb27ihRGfAQKf53O26Ilj0EFF
 FwJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR/V0R46Ulqi/dGRnoPvb91d+45RvwTnKTA9kGkcKRx21ZybbLR9UXHHZMLAGTu3JjpMxHoj3X@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKixXJbTksWP0qg9ZFJImn0hmw6g1nO6VZmF3fBGZS3gCPAXBP
 zcnxoIQGrZrh1e1HZIyNo1lZNRSlBy8U3f63NHvt/EOV+90vC3UJiV969+bnCFUGReExH6pi5oV
 YPPjsxInm8SUlKY/33a8IDXPjs12wNLkR
X-Gm-Gg: ASbGnctgJ/aaUvhTZmaYPPZDEqCeed0vGstA4ijaUR1UywLoQp0HqjemKI9yfC0Trrd
 BcOnJCWhdlJOdEevyDBeJ8op2AL7N5Ioks8EsPbtEeetYux/Xf6zxZkwGjo+n9FoI0R8eQV7Xkq
 oRJR5ZhEYeOnwB4kHZxEPclAPI
X-Google-Smtp-Source: AGHT+IHmmCdRvypGT/qMhamB0UooULQkA9afJagVAz1l3w+SaNIBhQcO4MuhWinikECgucdcoDIHiBOGxwrqo+5Ebqc=
X-Received: by 2002:aa7:c2d8:0:b0:5eb:ce16:ddbf with SMTP id
 4fb4d7f45d1cf-5ebce16df9emr3755338a12.0.1742850582298; Mon, 24 Mar 2025
 14:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250315201558.339913-1-tomasz.pakula.oficjalny@gmail.com>
 <20250315201558.339913-3-tomasz.pakula.oficjalny@gmail.com>
 <DM4PR12MB5165690B22C63D856BFFD7708ED92@DM4PR12MB5165.namprd12.prod.outlook.com>
 <CAFqprmyv+WXmBWwOa3uPuOkmLtrkfc7jEXquXEyb-Bjuni_jBQ@mail.gmail.com>
 <CADnq5_NV4hiQCHB7-YE=cN2NNS4AeHsnxntJfQ5a+iiYOaiYGA@mail.gmail.com>
 <CADnq5_OxT2qfxdPAg5=w1PeOBhQdCL-He2rBJOireSidBz9DKw@mail.gmail.com>
 <DM4PR12MB51657FD3B25C2F01340701B98ED82@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51657FD3B25C2F01340701B98ED82@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
Date: Mon, 24 Mar 2025 22:09:29 +0100
X-Gm-Features: AQ5f1JpoDCAOFB4hKSorbySjb8uXT5ZjpDZ7bbc9pfsyw_DWCrtznzesvNgkspg
Message-ID: <CAFqprmxwYYRRzv28ETV_fVF2z=saUuSjaY0Z3aTiEefyq9BKYw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: add zero RPM stop temp OD setting support
 for SMU 14.0.2
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 25 Mar 2025 08:21:39 +0000
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

On Thu, 20 Mar 2025 at 03:38, Feng, Kenneth <Kenneth.Feng@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Thanks Tohmasz.
> I confirmed that this change is not in the latest driver-if file.
> However, this is a fw interface provided by firmware team, we can not change it.
> That means the interface is different between the smu13 and smu14.
> Let me check and get back to you.

Hi!

Just checking in if you had the time to follow up with firmware.
Although it works without issues, if there's a need to wait a long
time to get this confirmed
maybe I should just split this into two separate patches and we could
get at least the
Zero RPM on/off setting merged?

Thanks,
Tomasz
