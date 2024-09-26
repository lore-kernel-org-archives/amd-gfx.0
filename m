Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DD2CDE00D
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 14:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 253AD10E181;
	Thu, 26 Sep 2024 14:21:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CqNCDTxf";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3DF210E181
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 14:21:09 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-378e902cde8so90411f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727360468; x=1727965268; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zgHAP9GsEIZRTqjBQ16HnYEixJwfyCLbvdK5AuNY/V8=;
 b=CqNCDTxf/HLK6dIwfA3ZyFItRc+R4/t3OM/8likCTiVBqBexKvuX1iKGV5lIwnGXWk
 7bUF8BAqQvEOPcbrWRwadyjkp9/fJpEcQD9nCQkuV1153B3ihCO4coaFgF9GVhXl2ZV4
 1CCtfH6vy4VvIj9E6M75puLJAl6+MpFmVLcZOZguOmtc1T/+peGHHK9NSmLFzXk2eWD4
 9JiNSlN0wKhB3G2/879JSKaxnepIp2QtottWMyIWJOBNg9hf/0OR6x5aKQ2mG91TXgwX
 OrmHZJbm/1Q614M5q5LmKXQ70hmo0SSgJ6QpKyUX0uiHNHF5YKleIAv4rWNzE14yTBqg
 yPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727360468; x=1727965268;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zgHAP9GsEIZRTqjBQ16HnYEixJwfyCLbvdK5AuNY/V8=;
 b=XIS4QjnGLXPnViyl6h5kGNmEBLI1s47syykv/neMOrVIPtS4H0uuEDOk0pce+63HX1
 1qni74dWtVIlD+mCshycU4uneSa4OrSudg9qA8T5027akpjdDVt9wLTZ5Vz63tkloP5h
 2cWZbI628/TeVHZY0u2HfXkOQ95yHfXo3ZL7pPLTyZyvvvk/3QXQsEgHhSPL5RddCw3Z
 cf9Pmbfgy3TLbTW5SWr8W5Ns2Z+1b8Ze74IjaByOtpWyjBvGSc7Ut+BiNiRVUwuozxX8
 nRAeTQQzYcdhaS9wwUq8v/HNNhFJWkSgif/4ZbXMjtyvD/jLn8R2a8zVaAZeKluVImuV
 /tQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1mif2MSeQY1KTmxm3JbSV+vDGer3L+JJMrTaLuyXpWvNQ+QAiBnA6SgMGg7/t/Xfn9ho2EzbY@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjFvZ/eSy9BFfp8tzVveczzhRqTWInUPrxq0G9krw66ZCM/YNb
 +y02yrBRXYPq0dF0dicR7VSbiFJmCMUgmLhXEosqiC1BnvmSDAOxOmXkDblHruPM5ZAqGaX3pi/
 bCYhEvQWu2gOJVHHl+DU20gHyyQs=
X-Google-Smtp-Source: AGHT+IGMPKdObmcww78M1lrE9FG0zn8KaDMWhFXxeDVri5fPLXuy2YyHeCdmWr1ZdhBfPwGK2zZF00KtAaB2Pxg7e1M=
X-Received: by 2002:a5d:5847:0:b0:374:c4c9:d502 with SMTP id
 ffacd0b85a97d-37cc24b1f6amr2377967f8f.9.1727360467788; Thu, 26 Sep 2024
 07:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240906180345.2557849-1-alexander.deucher@amd.com>
 <CADnq5_PT=6Y_+Bbo7gGMgnd0TLq0B9NfvGTuP=PHP7_xUrAT-A@mail.gmail.com>
 <CAAxE2A75nA6=2C2nsg1BNf+5xeB_V0ybtjz6KKWS8=pQOR5XRA@mail.gmail.com>
 <CADnq5_OWVEB3nfyDRwrhqqAtp2CD6i-r44u68AE96O1wxgfDAg@mail.gmail.com>
In-Reply-To: <CADnq5_OWVEB3nfyDRwrhqqAtp2CD6i-r44u68AE96O1wxgfDAg@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 26 Sep 2024 10:20:30 -0400
Message-ID: <CAAxE2A6apfH6QETi871+509oZTpOKR762EhxAwOBrLmYZZMHug@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: bump driver version for cleared VRAM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>, 
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
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

Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>

Marek

On Thu, Sep 26, 2024 at 10:02=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Thu, Sep 26, 2024 at 10:00=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@gm=
ail.com> wrote:
> >
> > Is GTT cleared too?
>
> GTT has always been cleared since it's system memory.
>
> Alex
>
>
> >
> > Marek
> >
> > On Thu, Sep 26, 2024, 09:53 Alex Deucher <alexdeucher@gmail.com> wrote:
> >>
> >> Ping?
> >>
> >> On Fri, Sep 6, 2024 at 2:04=E2=80=AFPM Alex Deucher <alexander.deucher=
@amd.com> wrote:
> >> >
> >> > Driver now clears VRAM on allocation.  Bump the
> >> > driver version so mesa knows when it will get
> >> > cleared vram by default.
> >> >
> >> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> > ---
> >> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
> >> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_drv.c
> >> > index d90473aec942..fad556be840b 100644
> >> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> > @@ -117,9 +117,10 @@
> >> >   * - 3.56.0 - Update IB start address and size alignment for decode=
 and encode
> >> >   * - 3.57.0 - Compute tunneling on GFX10+
> >> >   * - 3.58.0 - Add GFX12 DCC support
> >> > + * - 3.59.0 - Cleared VRAM
> >> >   */
> >> >  #define KMS_DRIVER_MAJOR       3
> >> > -#define KMS_DRIVER_MINOR       58
> >> > +#define KMS_DRIVER_MINOR       59
> >> >  #define KMS_DRIVER_PATCHLEVEL  0
> >> >
> >> >  /*
> >> > --
> >> > 2.46.0
> >> >
