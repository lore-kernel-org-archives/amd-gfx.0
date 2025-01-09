Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C76AE77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 10:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F8310ED41;
	Thu,  9 Jan 2025 10:18:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z40Pv8DD";
	dkim-atps=neutral
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5909910ED41
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 10:18:54 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-3003c0c43c0so6476001fa.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jan 2025 02:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736417872; x=1737022672; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76gKxHI9JJUP3Qx1H3eml37ViHNe4SXC3moDZ54oDcI=;
 b=Z40Pv8DDfDCFKljIgdd4HQksP94WGgUg32KXmg2nV96aRBiCNkNEaL3Vd0Lu44FKYp
 WCRDsp82BIBg6s4hKdhIgQUnulrExYfZjBaZXVVWoWDWkdX2JjB2pHv0kE+K3RatouYr
 MJQ+gWZut1CjNq2IXb+ciY9TWq07iXx4rLzc+ip/M5i8AYNEdhLNx0HPdFQakRlrXkFO
 Y4ufwaLDTc9XO560I9X5aNPg2xvZtLV7EKF96TXeKDKRqmnL+xgfo/IJS+FqyNFXWvY5
 bcb+ZPGO6QfizzPakQl7ivLP/QQn2kXezOcv6xkiOPGBmlo93xRrLOrV5iyLoKDKlP1S
 RIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736417872; x=1737022672;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=76gKxHI9JJUP3Qx1H3eml37ViHNe4SXC3moDZ54oDcI=;
 b=e0KJZI3oC0Lr2Ae9KoZEGoTV3fp7u9+YWZoy6x6Kr5QTofmEFXgbodmYCamMAYUYhj
 ngAue3xVOwnmdgyXLjAghPRyScYoXJFjmgHWTddhRRhp12+e4ZE6fVsWyZDzjStXsjoH
 AWJ7SU/MnTacYO4ftIE7kK3JcSSqQlQjkLUXegs7yVzrRrGvgXkwv6gSKkAeAQ/0jzTS
 YxfstWXinmjKsRKUJy9O+ydTi3clwjrFwjWUfjmASRBeVKFLuVwvG17R3BCi3iai+Q0y
 RfIBe4FWZJpdldIcw8jpSi4oC6WMPzwbIDkoi2Dn+PJfIV1KgfyDvNq+jCHdYVKT2htr
 RDpg==
X-Gm-Message-State: AOJu0YwVKn4Bs+cZG8HdwhZ5ErgYcL9VWJ6wkHduXiFgmW8dPopaUqLx
 R0OH08G9dFtXKH4pqRTWbC32IhkJEF8tAMGhLagYv21QlGKMBThwUMYhPvhzBrsAzs/bp0vBOXu
 R37ecVJS108lh3W0sYWfkk/PuIe20+VWExRw=
X-Gm-Gg: ASbGncvdm1U1sqKCoSWoK+/kHNdADZt9sDk1V04V6dLvE0XNemrg+VCEcSiJ+POm6Bo
 OqFn+EhmEXsCQMQgSevMoLk/ebEaDHpnox9gQ2TU=
X-Google-Smtp-Source: AGHT+IFCYXYcm4dlkX6v8QO8Ci/WzRDS/DvKT7D/2shMuQfSja0g90LpmCEzKVe0TXLxY5SR3lTdZ3s5fhQyW9B4w6c=
X-Received: by 2002:a05:600c:6c0b:b0:434:ff25:199f with SMTP id
 5b1f17b1804b1-436e2707f07mr46234465e9.26.1736414394922; Thu, 09 Jan 2025
 01:19:54 -0800 (PST)
MIME-Version: 1.0
References: <CA+b5WFEXPJ==vruf-6DHrhS7j3pnTaj_EQE08BimxqyaNvktQQ@mail.gmail.com>
 <d1028755-6a7a-4db4-bd4b-e5a2d682af61@amd.com>
 <CA+b5WFFa4hMeGnN0J2xd=FpU2Cxe_AjapWBpTFjfNhzUSOUAzA@mail.gmail.com>
 <0281e6f7-4ccd-4369-9182-d1580c9e6bc5@amd.com>
 <CA+b5WFEv1Qj3NYcwXaZz1EYW9omj7FmB8FdSKZnixsMNoi1+DQ@mail.gmail.com>
 <ddd7bf09-31aa-4e4a-93ea-b1336ced8578@amd.com>
 <CA+b5WFGDstoJTjgaT+hm4r-78zup1pLa2Ada7PqbTY=wCutSbA@mail.gmail.com>
 <98b3392f-2860-4a32-a769-b4dcd3f5dbbe@amd.com>
 <CA+b5WFGkDJhpRRywQLx2okttXGasBu6K8ScLZyakKrk1+FZWAw@mail.gmail.com>
 <5321c9af-6df7-4bf0-98b2-d6c4b2861374@mailbox.org>
In-Reply-To: <5321c9af-6df7-4bf0-98b2-d6c4b2861374@mailbox.org>
From: Mischa Baars <mjbaars1977.backup@gmail.com>
Date: Thu, 9 Jan 2025 10:19:44 +0100
X-Gm-Features: AbW1kvY5ih317HV1EysU9odFq3nUNHLJ3-uHcKau6uWQLPNehm_B17IbdKyOVMY
Message-ID: <CA+b5WFFkhQUcFO_45_6xmC4fk_GEFqbASt9rhGqBBYsothsHxQ@mail.gmail.com>
Subject: Re: amdgpu 4k@120Hz / HDMI 2.1
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 platform-driver-x86@vger.kernel.org
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

On Mon, Jan 6, 2025 at 4:30=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> When new specifications are made available it's not like the old one
> suddenly becomes "open", so I don't see any reason that a new
> specification would change anything.

I paid about =E2=82=AC3000 for my new PC, including =E2=82=AC300 for the gr=
aphics card
with HDMI 2.1 output and about =E2=82=AC2000 for my new Samsung OLED TV wit=
h 4
HDMI 2.1 inputs, and now you are telling me that I will not be able to
utilize them fully because the cable specification has not been made
publicly available?

Did someone forget to pay the people that design the cables? Because
that is what it sounds like. Why does Linux stay behind?

On Mon, Jan 6, 2025 at 4:41=E2=80=AFPM Michel D=C3=A4nzer <michel.daenzer@m=
ailbox.org> wrote:
>
> On 2024-12-31 13:42, Mischa Baars wrote:
> >
> > In the meantime I also checked the framerate synchronization through
> > glxgears at different resolutions and framerates. This does function
> > as expected. Although I haven't yet inspected the glxgears source
> > codes in detail, the OpenGL double buffering must be functional up to
> > some level. This means that the problem must be confined to GTK and
> > the GtkGLArea widget. Using GDK_BACKEND=3Dx11 I do get a double buffere=
d
> > context, but the default buffer does not alternate between GL_FRONT
> > and GL_BACK.
>
> Yeah, that's not how double-buffering works in GL. The draw buffer is alw=
ays GL_BACK, SwapBuffers doesn't affect that (it just may internally change=
 which actual buffer GL_BACK refers to).
>
> I don't see more context about the issue you're investigating, any pointe=
rs?
>
>
> --
> Earthling Michel D=C3=A4nzer       \        GNOME / Xwayland / Mesa devel=
oper
> https://redhat.com             \               Libre software enthusiast
