Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1F1CCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 13:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEEE710E8C8;
	Thu,  6 Nov 2025 13:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nMclLQ3o";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 369DB10E0AE
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 03:24:26 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-429c8632fcbso324180f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Nov 2025 19:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762399465; x=1763004265; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XWriRyYYR8ghNgV297L9OCEioZWlmVeoKEJ1s2bnlQ8=;
 b=nMclLQ3oGVdqvBGPHEPJYEMA6hEVfr9gO+p+Hd6A4qzwpMeIuSZRVGhn5IzV6JWwd7
 Y0KG/n+zfMARyUSahsM4hW40IVSonBIRHFVLRiGu7ttIIlDR4rmr73SCLfVcnPaIgkXB
 CQVyAEwdNw/Yy+cbyeolkf/CiCrRUzeasY6GyUlvLsCS0jFNdbBytKxSfLj5s/6F4pLf
 jkWbyHOBfU4ZW8vLQej+f2CIEkPktvIDrL9Z/y0UrFf4uo1vE3ykTYyAlm2KjL2OIQpK
 FFyO1E1EU9a9pdbcLB4RaiYNmvn3tX0c1LquXbKHk/3AHOzTDtSpPFoz5DQ7+eT7dhWu
 1qqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762399465; x=1763004265;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XWriRyYYR8ghNgV297L9OCEioZWlmVeoKEJ1s2bnlQ8=;
 b=IzIVd5nThn+UsIZjb4jI/pFM3qgRwU5CmHEdPUF0ZnMV7OGrgo35yD4z9vyC4cTNUH
 bEc8qUVG0QIFDsouGYLir+jEnj05ZfQQRVoSS5wt7fEJuyohEDkyo+/LsN/gllrMoiQX
 yiav5gZDsi4+rQsXdN9L+bJ7VHrMDl12QxPH2rPyioXr9JaKoyjUfN2I+oF3YF/0XOxp
 unM7C9t/393D739sHTwRPbKWl+8TCSKD4Hb+MTNDS28hkBn2lY+4ub736IQY8DELNbSk
 70mVboHLJnMcEVrnrcC4KUqQII6+1BdQVWJtQDhxn1ZowZA3/rJwuDPxjw3jKgylbN+C
 PfKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBlHe8Eg2qWIh36vSh5MhKIEIQ5QPyjCKYvbzk2nTR+MB85BoPeL7QtD72HIjA6eeaLFpEW3LB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhzGDT6EWFjU50SPKCEQohSw+f1C2pfOHZKIbnANuHibYan72m
 UOkkvhr6z5aQJPtjjcBufDH6EFh+HwI6DBhH+zg5iKtZlU1awgp74UrCB0VS3LtncbuPMAAFfb2
 XpPs62GJjZgDcAkrFh3xSprOKw7k3D1w=
X-Gm-Gg: ASbGncvJLH1LTXGxSHj6GJhwvNIoLEQ9Q5z03OdFER+xFGIx5ID1OT8mnOqIy74SwDu
 /ToVXl6S8ryOoXZg/0XQuOGNApZX5XRpVi4G2yMDqENq+yyU+k9R4ynDYnM/GOI7nOy71MiOebm
 oPhy+cdUl/y1fbp2dimrGXkJ1qFf+SYfc1X6tGih5ucryl31QhcKYuLVDHLZSLjYrmoj+YQGppa
 by4OySEbSzc+PRAlViUTD1IORmlPsXTvL44ydAoQT8WSEL+U0a8yb3+FstQ
X-Google-Smtp-Source: AGHT+IH0vBqmN+LTAnJJzTmqxPzFdBvxXGxIJUipsj9IOUkXfyL3ZCw2Oj0hPsddXQWER7iw5AD7RTA8CqGrUJA6+tI=
X-Received: by 2002:a05:6000:184a:b0:426:ff8f:a0a3 with SMTP id
 ffacd0b85a97d-429e33079d0mr4277837f8f.34.1762399464476; Wed, 05 Nov 2025
 19:24:24 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Nov 2025 19:24:22 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Nov 2025 19:24:22 -0800
From: Amit Dhingra <mechanicalamit@gmail.com>
References: <1043551.1761844832@turing-police>
 <32ed124e9d603cad950c4836c7a14a3ba8bc2068.camel@gmail.com>
 <1296761.1762045181@turing-police>
 <CAFF-SiU3XL5pZAzsB=eXi7e1LKzx5XwiNOyfGpPXOnnc6uo2cw@mail.gmail.com>
 <CAO=gReF+sWpKZFa+wbtGxa3+wSjAQG1UMG3iJaDt2EOPmH-7mQ@mail.gmail.com>
 <149f5bb52a21becedc17a5b0bf1a586672940af6.camel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <149f5bb52a21becedc17a5b0bf1a586672940af6.camel@gmail.com>
Date: Wed, 5 Nov 2025 19:24:22 -0800
X-Gm-Features: AWmQ_bm9b1RXq8yhr8e0aiNKvpL0O5UD001Mf3JquUOc7CURAMP3z_K9Ea3kHh0
Message-ID: <CAO=gReERBacxH6SjLrcCNcStiAzMosR=aW5D4W925CJ_yjzbhA@mail.gmail.com>
Subject: Re: linux-next-20251029 - build error in amdgpu
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>, 
 Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 David Airlie <airlied@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 06 Nov 2025 13:41:01 +0000
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

On Thu, Nov 06, 2025 at 03:40:52AM +0100, Timur Krist=C3=B3f wrote:
> On Wed, 2025-11-05 at 18:34 -0800, Amit Dhingra wrote:
> >
> > >
> > > What do I need to do to trigger the warning?
> > >
> > I have the same problem.
> >
> > linux-next on Arch Linux
> > GCC : 15.2.1 20250813
> >
> >
> > Steps to reproduce the error
> > - make mrproper
> > - make allmodconfig
> > - make drivers/gpu/drm/amd/amdgpu/
> >
> > Turns out its due to randconfig, See [1]
> >
> > Setting RANDSTRUCT_NONE=3Dy seems to stop the error.
>
> Can you please try and see if this fixes the warning?
> https://pastebin.com/raw/b8j3UABj

The patch above defining all fields seems to fix the error.

>
> Alternatively, if anyone has other recommendations on how to fix it,
> I'm also open to suggestions.
>

What seemed to also work for me is to defining the struct as below
without an initialization.

static const struct stream_encoder_funcs dce110_an_str_enc_funcs;

Its static so should be initialized zeroed out. objdump shows correct size
allocation.

objdump -x dce_stream_encoder.o

  0000000000000b60 l     O .rodata	0000000000000130 dce110_str_enc_funcs
  0000000000000a00 l     O .rodata	0000000000000130 dce110_an_str_enc_funcs


> Thanks,
> Timur
>
>
> > >
> > > Valdis Kl=C4=93tnieks <valdis.kletnieks@vt.edu> ezt =C3=ADrta (id=C5=
=91pont: 2025.
> > > nov.
> > > 2., Vas 1:59):
> > >
> > > > On Thu, 30 Oct 2025 19:05:30 +0100, Timur Krist=C3=B3f said:
> > > >
> > > > > Can you say how to reproduce that?
> > > > > I use the same version of GCC but it hasn't given me any
> > > > > warning or
> > > > > error for that patch.
> > > >
> > > > Upon further testing,
> > > >
> > > > [/usr/src/linux-next] make
> > > >
> > > > is sufficient on my system. Turns out that it errors out even
> > > > without W=3D1.
> > > > My
> > > > next guess was that it had to do with -Werror, which would cause
> > > > warnings
> > > > to
> > > > be treated as errors, but my .config has
> > > >
> > > > # CONFIG_WERROR is not set
> > > > # CONFIG_DRM_WERROR is not set
> > > > # CONFIG_DRM_AMDGPU_WERROR is not set
> > > >
> > > > Do you perhaps have patches in your tree that aren't in next-
> > > > 20251029?
> > > >
> > > > I wonder if Fedora's build of gcc 15.2.1 is different somehow
> > > > from the
> > > > build you're using....
> > > >
> > > >
> > > >
> > > >
