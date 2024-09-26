Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C167FCDE009
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 14:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A05310E309;
	Thu, 26 Sep 2024 14:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BmU0Q5hG";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1238610E309
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 14:02:17 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-20b05ba4192so750855ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 07:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727359336; x=1727964136; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TRvbHXH8cTCL0H0pf5Zu5BXtPq9CyGozOR32roo4E6c=;
 b=BmU0Q5hGzM1f2qFdwwue5Stec5FrvVbzTRwNz+dMKcFUzyvBiOM0qrh5LbpIObchj6
 RtWu0e2ampi+BFepmOXQHwH3wxsyQEgBxpjDW6yb/VPJAKo12m4tFeVB8vblZkcgFvje
 ABE29KoxlliMlQKsDeaeccrFJPEU9Whfqx8KiRQ9n+ieFeoqmHsMHHO0r8W/Ckb+1Msm
 t43KNbzDkA0uUl5BsTHtVUKzjoGvBumziiP20PNgN8U7l5IWPY9i8v6wSSc4RUGgYrda
 0s2k1ortWrPpufI/5CULSgWtPhyBIYx5q/1HdZvfbMAT7VHOzjc9DS0GVnKbN04RlmIJ
 AD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727359336; x=1727964136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TRvbHXH8cTCL0H0pf5Zu5BXtPq9CyGozOR32roo4E6c=;
 b=C9FYzgjgxF4Jn0lYwdZ7JZaFOTXDAtluvMFJ1qGztwWyOOc860+jt7YcwXICeB3EOc
 T5wQ3+m6a86y0eA/SFaNaIvm8JqDV1FQOoHMi7/f3IG1mc9wWfwQoZDpNaBdUrWvG4t+
 i+da0kF2LyUfI5hbsqhKB2+jFlKys3sKcUAwiRJCtJrFDYWNXRdErgoM+e64POD40USm
 yN04tB5CNYWJHSYds6EEtbWf1xtE8NN3x+6cAqVN0Dd3ik4Vo3yzkHEw7gBS9P06vxSH
 4Mo+Pvh4fUFNxj1HUV53ZuR3ge7qSk7SpmzdZyjYA1J5fl6bEerO+MrUj9VRHTJan2bN
 h9hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV85VrSR41jq0HeR033hTWSxzIYlW3Q5WqhAhrgkNzPcB8F+THbph70hiFoRjdvU06VFAEc3m7T@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqiZILwyz/ZUgXj4J/W5zdnN3wEFkB6mli4C/T4+ZCRl/Inmun
 xVN/nUVzxHPMQA+oky1Of8o1SnJxSP6Xz8u4IRK1kSztsLJi+kTlW6DtKh9uvNLGv3pLf1xDdUE
 UhRQvGXKBWaphEdUzUR86Ei86nLQ=
X-Google-Smtp-Source: AGHT+IEgjMCq0TE6lhVGyRazYolqnMIGX0ibpIfnJe+UZ5Pd31hjxu6C8KohoYlTkT1/G6g39VxsT5yj7+PQ4PrgOEc=
X-Received: by 2002:a17:902:e811:b0:205:76c9:795d with SMTP id
 d9443c01a7336-20afc4ab948mr41261615ad.6.1727359336442; Thu, 26 Sep 2024
 07:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240906180345.2557849-1-alexander.deucher@amd.com>
 <CADnq5_PT=6Y_+Bbo7gGMgnd0TLq0B9NfvGTuP=PHP7_xUrAT-A@mail.gmail.com>
 <CAAxE2A75nA6=2C2nsg1BNf+5xeB_V0ybtjz6KKWS8=pQOR5XRA@mail.gmail.com>
In-Reply-To: <CAAxE2A75nA6=2C2nsg1BNf+5xeB_V0ybtjz6KKWS8=pQOR5XRA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Sep 2024 10:02:02 -0400
Message-ID: <CADnq5_OWVEB3nfyDRwrhqqAtp2CD6i-r44u68AE96O1wxgfDAg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: bump driver version for cleared VRAM
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
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

On Thu, Sep 26, 2024 at 10:00=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@gmai=
l.com> wrote:
>
> Is GTT cleared too?

GTT has always been cleared since it's system memory.

Alex


>
> Marek
>
> On Thu, Sep 26, 2024, 09:53 Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> Ping?
>>
>> On Fri, Sep 6, 2024 at 2:04=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com> wrote:
>> >
>> > Driver now clears VRAM on allocation.  Bump the
>> > driver version so mesa knows when it will get
>> > cleared vram by default.
>> >
>> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> > ---
>> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c
>> > index d90473aec942..fad556be840b 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> > @@ -117,9 +117,10 @@
>> >   * - 3.56.0 - Update IB start address and size alignment for decode a=
nd encode
>> >   * - 3.57.0 - Compute tunneling on GFX10+
>> >   * - 3.58.0 - Add GFX12 DCC support
>> > + * - 3.59.0 - Cleared VRAM
>> >   */
>> >  #define KMS_DRIVER_MAJOR       3
>> > -#define KMS_DRIVER_MINOR       58
>> > +#define KMS_DRIVER_MINOR       59
>> >  #define KMS_DRIVER_PATCHLEVEL  0
>> >
>> >  /*
>> > --
>> > 2.46.0
>> >
