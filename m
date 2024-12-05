Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2386E77178
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 17:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BAB810EF38;
	Thu,  5 Dec 2024 17:16:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dsxebT1I";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C16B110EF38
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 17:16:09 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-7259473348bso81336b3a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Dec 2024 09:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733418969; x=1734023769; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqfR9YUmBzK01kP820gOAk3CFeitKbz3LWPLBNmD3h4=;
 b=dsxebT1IQw2FnyZUj23bZcGbQ83bKOIv71+Z84ZFyA0OutPsw7IORyYSy9ub+t1jdf
 O7bmTrlHfDIqc2RuHEJwwF+I1cbUeXFzY9u2nVC5/p2/eib679eu+5TERkCHxwBoUZJ5
 pSM/oErfuzakFzRJWrlrWuZHa19QVCoR6g1lHguPgo2y5/n68imNIa9wqe2EwM4b7Ngz
 eMy9LSWncBRyQm8XA47nCmahpJyPLGzTJrfbQ/pei9laSE8YEbdRxfZs5uUqzJTR4J5c
 n+0jiG9dnZWplgGFcKrc0yZ5gLDfvnJYO8bqq73cWiMuT5uez+cXhSt4kG6sFn/WDwxj
 N3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733418969; x=1734023769;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cqfR9YUmBzK01kP820gOAk3CFeitKbz3LWPLBNmD3h4=;
 b=Xm9wDDBrYbayqfwbcSPCrrZP+2eABxwLO/Cw3WOprgagHHyj9QgZjI3yCYqM64TbaF
 Z6/YI/rY9z3D+6Ob7JEX2Tguaysp5T1+K2Rc8kcFBBRrr0bJ21otN816wGvFpKruI7jF
 uCQrnO5THZ93rCf85jPiL1XAC9PMKLyR/lO2ZJQ2m2ovukxZ/ccL4Jjff8bSZj7aMvIw
 5+IpkpaIGLqWjPWbMWeIkK9amzJ2ohpfrHWLeDb533aaocL57RfxnCo0oevamoHVq2LR
 0hwLtwTmwa3o0neQ6LLam0/FxnCLjUYEbrS+TuL6STzRv21GP3I61Auac3soO+IZXfVi
 jxkw==
X-Gm-Message-State: AOJu0Yx8DZtksXoHpPlTNGM7nkz7Bo1wYBsfDoOzLEJCesswT4L4pXvj
 I2VC0GFAi7cDRJTbDNslaQ/pjwDeZSqTEDKBMvKzFSzHy7jAFBEFYiiarbm4bjuKlImHSj0wY1j
 FVwo9Gyi+gQDxWQ3COe3LhbEokMSPkw==
X-Gm-Gg: ASbGncsbOizQZZPOMZ1ZMHuNMbs2Tx7f88ZIS8CCG9MFkAcMhUhjIbYQybY4PF/VYep
 54mRoUc7Dk8dPoy9QNE+1cGYgd2Imsvo=
X-Google-Smtp-Source: AGHT+IFn55vGeOeJkvEExhfNrG9nSXFVyV2TBQi/V6kOAUJ2rhpMoFC6KccNEON3udn8XCDK3tMZpkvl2FpP9Ti21QY=
X-Received: by 2002:a05:6a00:3d4a:b0:725:a8ee:a224 with SMTP id
 d2e1a72fcca58-725a8eea32bmr1266850b3a.5.1733418969166; Thu, 05 Dec 2024
 09:16:09 -0800 (PST)
MIME-Version: 1.0
References: <20241205170507.126585-1-mario.limonciello@amd.com>
In-Reply-To: <20241205170507.126585-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Dec 2024 12:15:56 -0500
Message-ID: <CADnq5_P35-Wij0s36OeK=qGzGoE4xniZhuM3M4vYwMsyDnvevg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Show an info message about optional firmware
 missing
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>
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

On Thu, Dec 5, 2024 at 12:05=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> With the warning from the core about missing firmware gone, users still
> may be notified of missing optional firmware by a more friendly message
> to clarify it's optional.
>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ucode.c
> index ffbb3377e0f6..cf700824b960 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1459,8 +1459,11 @@ int amdgpu_ucode_request(struct amdgpu_device *ade=
v, const struct firmware **fw,
>
>         if (required =3D=3D AMDGPU_UCODE_REQUIRED)
>                 r =3D request_firmware(fw, fname, adev->dev);
> -       else
> +       else {
>                 r =3D firmware_request_nowarn(fw, fname, adev->dev);
> +               if (r)
> +                       drm_info(&adev->ddev, "Optional firmware \"%s\" w=
as not found\n", fname);
> +       }
>         if (r)
>                 return -ENODEV;
>
> --
> 2.34.1
>
