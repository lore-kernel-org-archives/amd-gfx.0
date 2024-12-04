Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC28E77170
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 16:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0729489167;
	Wed,  4 Dec 2024 16:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FGuGqK9P";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E384989167
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 16:45:16 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-724e24ab195so2572b3a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Dec 2024 08:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733330716; x=1733935516; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KqzaH5dVcIc4AD57JsNH4z+TgOXdpcm2S+g6Fr9RsdE=;
 b=FGuGqK9PpLSC7OpYqH42NYPvwuhiYurltRgfzXn2hN27gf07Sk9/ATqQr2E5HkhVY8
 GDk5v0lcMS78fE8dugSjL5TVlIQnQRh9ejuPpqKMSF+InxgiMTi/Imvf5PTuUi9k87ci
 82gPwrvmmWC/5bK5CmxtXwgZLzhR7GEK1ItB9HhwzBb5RI83epWgvgzIGToJXCh0O9Yr
 77zwA/Rua6RzCcmwsGDul02oFQ2vOELnW0RE7eXHvD33zgL3EmHtLJvv/XeYq0DnEDw4
 fL6VFV3x2aSGEaA6XuRaYMgVn2Hr5t+ZG8HcLR2/IQGhrBLBz8KY7DwPew9aIAZlNZls
 +JFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733330716; x=1733935516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KqzaH5dVcIc4AD57JsNH4z+TgOXdpcm2S+g6Fr9RsdE=;
 b=nVLuJvgae4MsV05G2yBS2fGgl7+TQt/ujHttVZGXLu4wqy4L6CIVVA8PEwL5xl6loY
 QwDcxLXdYPNngZJvft0LVLBk6VGvB6ra33O0pKArYJBQHWcD53Bc2eT7WH4Bv+IlSrcA
 re8pfv3JXgL5Y0xlbsBFWL7J5vB1VeHKhTVlH9pCWXVX4FEv7zhHsP+oeIAi/80DJAzu
 xpydXDqz1U8e3OEX300JZtKtIa83cIYAdpD9aeBRpDO3hw3f2hkffNQW9JVYTe2PQ7ek
 PKgKK4Ajmd9j8zqPY5OAesIB3LHpRvPnX0hY3bBXb7UeGpdsA/Z6rs7EcAiyxY9DRRFa
 Mvzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWvWTY3+e3kaNTBkKFfiU6XITT4N+j5rgKFPD5zvFtLXyouD4f96YdKiPcg20MKEMJxhRlHw4T@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCz03jwHYwOnhIze03YDT7+hlWy5XzkBy2PFCYGKkfH4dd9dUu
 XoVLxJ95OFby0p6QCtgpH0N7idRZ3kWz/gR2RJmMtRjOjTHFRq7Q2xGyJlTzYwt5ai6Xv0zr8Ht
 d7EqlsP0FZTZq1FapICwT9V1P0po=
X-Gm-Gg: ASbGnculiqqsgj2ik33Zng+3kjxNH2IINNxLZJC34V6BLEb/UAoLKs1skRSd1WL+DO/
 b8BUBibvqWfkcTNSooslVorrLoh3uu8s=
X-Google-Smtp-Source: AGHT+IEA/o5ovRvuiNivskj0cvhuypuJ6zrDPsk/r46HXNkmvjCpqiihG29Jq1Q41RPyVPzTyMzikNcX1kTyvY4ZRDc=
X-Received: by 2002:a05:6a00:b53:b0:725:2927:d89d with SMTP id
 d2e1a72fcca58-7257fa42516mr4572328b3a.2.1733330714735; Wed, 04 Dec 2024
 08:45:14 -0800 (PST)
MIME-Version: 1.0
References: <20241203181403.23515-1-mario.limonciello@amd.com>
 <e8ae8d63-44d5-4e77-818f-67cf69d0c8b7@amd.com>
 <c5a7f27c-c676-4e10-83ba-393a4df06ada@amd.com>
 <20d00e76-7ce4-42d0-a968-d7adae616984@amd.com>
 <CADnq5_MPEZA2CYfFnG3u--bDeD3eQyZO6igCQQqHEp-BJNwy-g@mail.gmail.com>
 <2062652c-16f6-4e06-b3d7-73ef6a684aaa@amd.com>
 <CADnq5_MD0wexpOc+mGoXkHMHDv5BxybR+tyowedwxg7vvp6mQg@mail.gmail.com>
 <9f85de41-5574-4e83-b5ed-1640e45e90e9@amd.com>
In-Reply-To: <9f85de41-5574-4e83-b5ed-1640e45e90e9@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Dec 2024 11:45:03 -0500
Message-ID: <CADnq5_PvErRnCQp-oTR1Qw46H6vo9BuWzH76ERqQ5XDzA1dkoQ@mail.gmail.com>
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

On Wed, Dec 4, 2024 at 11:18=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 12/4/2024 9:30 PM, Alex Deucher wrote:
> > On Wed, Dec 4, 2024 at 10:56=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com=
> wrote:
> >>
> >>
> >>
> >> On 12/4/2024 7:51 PM, Alex Deucher wrote:
> >>> On Wed, Dec 4, 2024 at 12:47=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.c=
om> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 12/4/2024 10:44 AM, Mario Limonciello wrote:
> >>>>>
> >>>>>>> +enum amdgpu_ucode_required {
> >>>>>>> +    AMDGPU_UCODE_NOT_REQUIRED,
> >>>>>>> +    AMDGPU_UCODE_REQUIRED,
> >>>>>>
> >>>>>> Couldn't this be handled in another API instead of having to flag =
every
> >>>>>> load? By default, every ucode is required and if optional may be s=
kipped
> >>>>>> with amdgpu_ucode_request_optional() API?
> >>>>>>
> >>>>>
> >>>>> I guess this would be a smaller patch, but 6 eggs one hand, half do=
zen
> >>>>> in the other?
> >>>>>
> >>>>
> >>>> I thought only ISP and gpu_info (no longer there for newer SOCs) fal=
l
> >>>> into the optional ones so far. The usage is rare, similar to the
> >>>> nowarn() API usage.
> >>>>
> >>>> Also, as far as I know, the cap microcode is a must whenever used. T=
hat
> >>>> is not optional.
> >>>>
> >>>
> >>> The cap firmware is definitely optional.  Some customers use it, some=
 don't.
> >>>
> >>
> >> I thought optional is something that can be ignored even if FW is not
> >> found and then driver load proceeds.
> >>
> >> What is the expected driver action if we classify cap firmware as
> >> optional and then it fails on a customer system that expects it?
> >
> > I guess if the customer expects it, they can make sure it's there.
>
> I don't think customer really can do that without any diagnostic message
> from the driver. Driver has to show the right message. If it passes that
> silently and fails at some other point, it could be a totally different
> signature.

yeah, I haven't seen any bug reports about the cap firmware so the
current behavior seems to be fine.

Alex

>
> > I'm not sure how you can have both without it being optional.  For
> > customers that don't use it, requiring it would break them if it
> > wasn't present.
> >
>
> It's working so far. Having all is better as long as loading that is
> harmless.
>
> Thanks,
> Lijo
>
> > Alex
> >
> >>
> >> Thanks,
> >> Lijo
> >>
> >>
> >>> Alex
> >>>
> >>>
> >>>> Thanks,
> >>>> Lijo
> >>>>
> >>>>> Alex - what's your take?
> >>>>
> >>
>
