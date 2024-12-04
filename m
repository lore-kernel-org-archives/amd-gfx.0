Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E12E7716E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 16:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECED110E4E3;
	Wed,  4 Dec 2024 16:00:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DIQn7wFH";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD0110E4E3
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 16:00:13 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-724ec0403f9so488295b3a.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Dec 2024 08:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733328013; x=1733932813; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O1StFEuJtWQpAQegh/eDp5Vpupsa/NI0lHA6/oZmB10=;
 b=DIQn7wFHvda+TBADDm8Ydx7g91ScdACJPH8yBtuh/WsFjXCSvE9YLIcOsk1ETYcPBJ
 C7rnOLdPoNNJ9NZI3lSfbUFjmf46Zi57JYm3rM88OPOAzwPK66nkobRO1HwoGGipVFw7
 6yGNzxJosQjPABYtn+JgK9hhmpAA8rV7uWZOVDhzuUfICj5pejkflAK8siK3mbTq3eEY
 HRjpSSxrumimcPEhZeyu9LLBRfUfWpyEL1Gu8KiQRLIXcIoT1unMFa5hiLuJBqM4dtSH
 KqXJE9TeOe3oeaLAjSxQcxw6B2orJYrGP+CVms/YV3nPG8ww4KKiJZrDEDmwbZ6FgMFZ
 RlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733328013; x=1733932813;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O1StFEuJtWQpAQegh/eDp5Vpupsa/NI0lHA6/oZmB10=;
 b=b8KoUJ4oJ1SE22MveHpculppWV+nPq/sr7LbJ3jD6Zc9KYSPS/uZH8mXR/M0UNV3Rw
 M3fsjNgk+BFkIMbsvS9XWiJN05oaHhxp5Cp4gjS2G8m7lpS2ed0JAxCTopv92d7rqFrc
 JV5rUOwxA003zr3IEymJdVHYuf6/kCvzVrkehQ9vdJywR2+/8G224HDMYkNn4b24+mIr
 /S7BJhAqirA9r0sFLZxqLROe2/QNn0Qp1F5RKOy7pLPkCX895n0KGXR6FZN2cP0JmhAx
 bJToJ4ck8KBaCyNpmXrzdt1/LxE8H5Gsw1FV0vjPlntI/HKxv8dktjo7E7bnHfWKwQPZ
 4y0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfKdO4pkrsmTxEaJLOlgQ5JftMsi5lSbXqnyq1JZCAeHMuLboVFb85puxchvCiO/62PSFs2Lhp@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9tcQbA+8zAeDxn4AQoc3NQiySQlMF27otHndWyFEBRmH/nyz1
 lAu9ttV6kVoAXDFNLJOwj5VavFchPyLPDhrw/FqSw/A3CUnGsNHkdkWh3MVEW42FOcjY29s9TA/
 5bXoG7gd1eSFtD8l7av2ybVWl9uP02A==
X-Gm-Gg: ASbGncvPqVrLNa+0+jVyjgg7H3KfJHSnvH2FTlHUlVyDhq8RnPKr97yY8hnDioIBzZx
 8M46x3CY732i6w3dUCKMr7D0DYcwCdc0=
X-Google-Smtp-Source: AGHT+IEhWggHOUvxr2i7ThO2FODfy0jb8crBJW8NhooOX1evJOGMYcl3xgheCcYpDu6EMsHDyRSHM5Opyowjm4edzVI=
X-Received: by 2002:a05:6a00:1826:b0:724:5bc0:26f6 with SMTP id
 d2e1a72fcca58-7257fcac920mr4351879b3a.3.1733328012454; Wed, 04 Dec 2024
 08:00:12 -0800 (PST)
MIME-Version: 1.0
References: <20241203181403.23515-1-mario.limonciello@amd.com>
 <e8ae8d63-44d5-4e77-818f-67cf69d0c8b7@amd.com>
 <c5a7f27c-c676-4e10-83ba-393a4df06ada@amd.com>
 <20d00e76-7ce4-42d0-a968-d7adae616984@amd.com>
 <CADnq5_MPEZA2CYfFnG3u--bDeD3eQyZO6igCQQqHEp-BJNwy-g@mail.gmail.com>
 <2062652c-16f6-4e06-b3d7-73ef6a684aaa@amd.com>
In-Reply-To: <2062652c-16f6-4e06-b3d7-73ef6a684aaa@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Dec 2024 11:00:00 -0500
Message-ID: <CADnq5_MD0wexpOc+mGoXkHMHDv5BxybR+tyowedwxg7vvp6mQg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Add the capability to mark certain firmware as
 "required"
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Dec 4, 2024 at 10:56=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 12/4/2024 7:51 PM, Alex Deucher wrote:
> > On Wed, Dec 4, 2024 at 12:47=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com=
> wrote:
> >>
> >>
> >>
> >> On 12/4/2024 10:44 AM, Mario Limonciello wrote:
> >>>
> >>>>> +enum amdgpu_ucode_required {
> >>>>> +    AMDGPU_UCODE_NOT_REQUIRED,
> >>>>> +    AMDGPU_UCODE_REQUIRED,
> >>>>
> >>>> Couldn't this be handled in another API instead of having to flag ev=
ery
> >>>> load? By default, every ucode is required and if optional may be ski=
pped
> >>>> with amdgpu_ucode_request_optional() API?
> >>>>
> >>>
> >>> I guess this would be a smaller patch, but 6 eggs one hand, half doze=
n
> >>> in the other?
> >>>
> >>
> >> I thought only ISP and gpu_info (no longer there for newer SOCs) fall
> >> into the optional ones so far. The usage is rare, similar to the
> >> nowarn() API usage.
> >>
> >> Also, as far as I know, the cap microcode is a must whenever used. Tha=
t
> >> is not optional.
> >>
> >
> > The cap firmware is definitely optional.  Some customers use it, some d=
on't.
> >
>
> I thought optional is something that can be ignored even if FW is not
> found and then driver load proceeds.
>
> What is the expected driver action if we classify cap firmware as
> optional and then it fails on a customer system that expects it?

I guess if the customer expects it, they can make sure it's there.
I'm not sure how you can have both without it being optional.  For
customers that don't use it, requiring it would break them if it
wasn't present.

Alex

>
> Thanks,
> Lijo
>
>
> > Alex
> >
> >
> >> Thanks,
> >> Lijo
> >>
> >>> Alex - what's your take?
> >>
>
