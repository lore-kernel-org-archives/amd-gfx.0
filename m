Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87630C10F16
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 15:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F368610F097;
	Mon,  6 May 2024 15:14:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hNsCNhKZ";
	dkim-atps=neutral
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com
 [209.85.219.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CAB11218C
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 15:14:02 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id
 3f1490d57ef6-de45385a1b4so1861598276.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 May 2024 08:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715008441; x=1715613241; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sBV+wvo3Dx400lcrvjWYZywLwC+DJj7pjLSXbqZx7sI=;
 b=hNsCNhKZTN9CQSwXisXxRRNHBXVu67dBaKkOLtKECFQPAN81/XjF13J/naPzS8cAfP
 xf0iMIAeTu9aOX7Xs3EJORjFlmc3jOLRnoDYUXapYIXW3fnhlMswDn6b8we0LsLvSYnp
 qMDY/dDlCJI6cB7YUYbxbUBoPThgigKbkaYPvUZMGX/2FutNATCSA1qqxHC2NyQPFtMC
 7YM4e1hi3pbZu/KTUbISHsdK17ka9cjNEQ6DGtCj8MxxDz0p/Usm4lHhJIeJRQYgFr+6
 tlpgwxwouElkJ0PB3siMVnXpVbV/nr8t6B0CCHXD5FrYW4ue/0/VCbXEZU/bRcY5Dryu
 2qKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715008441; x=1715613241;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sBV+wvo3Dx400lcrvjWYZywLwC+DJj7pjLSXbqZx7sI=;
 b=BOugGzeteTibSEXXqTDoPGMaqBCGmVeLbIASnLz4nLi3xGYTdO9QDK+3roELNdqXKJ
 9PNYLErpdimeNPYYypOuIPHosdyr98kH7lmHo2WJXWWTxsPp+b8XaDh7oJnGRI909uqy
 puHvTHR1Q3A2xMxUnVCfpLbG2AgZyMiXVm8cTY19aqJjcDBJS9ZHMg858CKV69QhJcf2
 6yCEz570ZCpQ+PJyQnOgMzSs6kVPsaNsIwOW4F29fMrx15AOX+YcKoFxeLstV5ecS/Ap
 JP9rHxnbRa7QoXLMicrm/WfUPfbME0DdNaYg/z8iW9CN6vl4SeJPD3B4lCEwtmXZ8cND
 mU6g==
X-Gm-Message-State: AOJu0YyoHtgIhQwYokTilOLhHNlkNurYzzuJugpAvY6BdgIiPFbUtLtO
 Iuc1zUtNCp9xuILbvNjZZvSxtBPyvzmmFEkhaiEsLYnIAxqPF+krhZa0olJTTIxqBMvxVVGMKLG
 Wd8MfBwnGWI2GDFPAz/ej+yywb2z2Sg==
X-Google-Smtp-Source: AGHT+IF9b7sGHj/7a2FgLUsrDDVDSiQVIB6+dxhrRyOqHwGypwvSzBnai6b1OgREQTlcoI6feTIHHX3AlOzS2IzPthg=
X-Received: by 2002:a25:aae6:0:b0:deb:438a:43b9 with SMTP id
 t93-20020a25aae6000000b00deb438a43b9mr10391278ybi.39.1715008441354; Mon, 06
 May 2024 08:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240506061207.2017901-1-Tim.Huang@amd.com>
 <20240506061207.2017901-3-Tim.Huang@amd.com>
In-Reply-To: <20240506061207.2017901-3-Tim.Huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 May 2024 11:13:49 -0400
Message-ID: <CADnq5_MGr-R6KUo=gT7ysBeg8T9sXHZipDpwtYsGpqw5n2ocmw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: fix uninitialized variable warning for
 jpeg_v4
To: Tim Huang <Tim.Huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 christian.koenig@amd.com
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

On Mon, May 6, 2024 at 2:32=E2=80=AFAM Tim Huang <Tim.Huang@amd.com> wrote:
>
> Clear warning that using uninitialized variable r.
>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v4_0_5.c
> index da6bb9022b80..4c8f9772437b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -187,7 +187,7 @@ static int jpeg_v4_0_5_hw_init(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>         struct amdgpu_ring *ring;
> -       int r, i;
> +       int i, r =3D 0;
>
>         // TODO: Enable ring test with DPG support
>         if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
> --
> 2.39.2
>
