Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF740C0218D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 18:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6678810E12A;
	Wed, 29 Jan 2025 18:14:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZTFwX1aC";
	dkim-atps=neutral
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com
 [209.85.161.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3330510E12A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 18:14:01 +0000 (UTC)
Received: by mail-oo1-f43.google.com with SMTP id
 006d021491bc7-5fc00d5150cso151603eaf.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 10:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738174440; x=1738779240; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BYF50Mny/9N5b3gRZG3W8aD392Q+yHnGb2DnC07NmRk=;
 b=ZTFwX1aCnES1EtUrZp6lV/YbkqJ02D21LOILBNlw3VtQhgvHJSOXgYTn594MPaxH6q
 9rpg1qrHVWYfV0QQs1r2rglMAcLCVPJORaFYErgxhDoM0+P4n8vbXZRjEORVwJaBf0Wu
 zFq1mapWVe0PWVKjKDW+qEImyNZbZbY8XUOwUdOnVnihrCH+/qVWsXP0Kbu6LASwnlQl
 El8CP0Q9v9dpyd9dVtj5fdQ4a8Nku1pi7pj/AkaBfB+aGpYXNcAYabjM0OkXZEqsVjv3
 1+gSuRW6WZJCDVOKKrYy7NL5wSPTZY4sYo0ym8GH+ywXnPGdQs9ubWzwPRF+3NUW/oq6
 bZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738174440; x=1738779240;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BYF50Mny/9N5b3gRZG3W8aD392Q+yHnGb2DnC07NmRk=;
 b=CcxLZaUv1XNnujaa4WIkbUvX06FiuKDpG7G639r/Ek0bbBAbk8DqAwWJm3CUeTs+cH
 dD7O2SW2YXGwxn3nF0qqjjnTK+wRBQCUbq+vuPgrxPd8cbnwE99d23MwajtovCU0iI7C
 BgMzoDWGr47YbVvxK9Jb6k2S7Xb8TQQzyIg6r6efLUWyfGg9eTk4wGHYxePvdU4vs9XR
 5lSy0ZEqSoHzZa0Z3dcR5k5Uqks1kOP/Pvfu0Vr4jbV+Y5W4nt1XDzcXLzL8OIJX9SAu
 PIsIaLJydBnZhadjxrg5no9MF4p92/TZzZB6ZoHGhptNt89LegqIafLPdAQgs80lCl2m
 ykeA==
X-Gm-Message-State: AOJu0Yzr2xKrqp6tKk93J7xegkrLMglmnUOcyxVYgifM7H/07IUCPbXb
 yFglOB/YK0q3ashYvRIZ3DZVXlfQvOR6V3Wx/u8mNg+pyIW3hp79laD8WMejn6pDyvzhpaFdBxK
 NspbjV4r6EX89d/EOQ+MG/ZEup3E0pQ==
X-Gm-Gg: ASbGnctpX67DbYDi9v9eQupShT0k8vj2IOI+sRR6iz2jjivzeL+yoq2wwsIHImlT1xN
 vDy7QDi/ZmERhTno+u4zf7lTdbN7qvW3h3uYGVlTr3oBDNpu1hq6DmMqQMRjUDmAyt6HfLQ0ATw
 ==
X-Google-Smtp-Source: AGHT+IEIYt/tlEym3gDbYVhVMX4OTHM1d56exI5A4MK0p8f1QollvojQ1Fh26DiyBFV37RtJIASOuYyEEnIxOjgnf7M=
X-Received: by 2002:a05:6870:c8c:b0:29a:ec04:aa18 with SMTP id
 586e51a60fabf-2b32f0009d9mr858989fac.5.1738174440035; Wed, 29 Jan 2025
 10:14:00 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A42f1uH_1esfXn-BsPEzbMeuev4TAFfG9DYDc01xS=g8Q@mail.gmail.com>
 <CAAxE2A60-sJkNLrh0bVVpi35h1PZREbeb+9cpZBjmcBgfW2wrw@mail.gmail.com>
In-Reply-To: <CAAxE2A60-sJkNLrh0bVVpi35h1PZREbeb+9cpZBjmcBgfW2wrw@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 29 Jan 2025 13:13:24 -0500
X-Gm-Features: AWEUYZmKWsgD9rL7D9suRCsZgtpBCL9u5o8xOFNlY-Zvtd4q_oV85Q521kmWgpQ
Message-ID: <CAAxE2A6oBwCvVaPe_oxMRmFFdvZkUM-oHHJhc+tConM=5niqZg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add a BO metadata flag to disable write
 compression for Vulkan
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="0000000000000e5fca062cdc4640"
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

--0000000000000e5fca062cdc4640
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping. This is urgent.

Marek

On Mon, Jan 27, 2025 at 10:52=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@gmai=
l.com> wrote:

> Updated patch attached.
>
> Vulkan can't support DCC and Z/S compression on GFX12 without this.
>
> Marek
>
> On Fri, Jan 24, 2025 at 10:15=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@gm=
ail.com> wrote:
>
>> Required by Vulkan because it can allocate whole VRAM as 1 BO and parts
>> of it bypass compression and read raw data.
>>
>> Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
>>
>

--0000000000000e5fca062cdc4640
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Ping. This is urgent.</div><div><br></div><div>Marek<=
br></div></div><br><div class=3D"gmail_quote gmail_quote_container"><div di=
r=3D"ltr" class=3D"gmail_attr">On Mon, Jan 27, 2025 at 10:52=E2=80=AFAM Mar=
ek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmail.com">maraeo@gmail.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
<div dir=3D"ltr"><div>Updated patch attached.</div><div><br></div><div>Vulk=
an can&#39;t support DCC and Z/S compression on GFX12 without this.</div><d=
iv><br></div><div>Marek<br></div></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 24, 2025 at 10:15=E2=80=AFAM M=
arek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmail.com" target=3D"_bla=
nk">maraeo@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><div dir=3D"ltr">Required by Vulkan because it can allo=
cate whole VRAM as 1 BO and parts<br>of it bypass compression and read raw =
data.<br><br>Signed-off-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:mar=
ek.olsak@amd.com" target=3D"_blank">marek.olsak@amd.com</a>&gt;</div>
</blockquote></div>
</blockquote></div>

--0000000000000e5fca062cdc4640--
