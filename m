Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184D6C197BF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 19:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9B3310E00B;
	Thu, 27 Feb 2025 19:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="epbpH4Ft";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D92010E00B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 19:14:45 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2fe851fa123so343023a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 11:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740683685; x=1741288485; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r4+avpSbbzWYkNaeDhSuqdxVwdzpBCsCOAQajLWFpJI=;
 b=epbpH4FtnOehUaKDSpKLFFPa/8q+cmCKpywSJjA1NjYJkDBHdueCCPa2voNkjFJIhi
 E0K4RCFz0RmDUQYFGfUUIKkhRJtZGy6GQ01qa1mfibuJFpid7sF/C9y+lzEwEx5MGr4V
 VfInQTD/yWlXrJ/3EBWBie3cDB4Z8aa3/Fe8MsiiQZE/JbWlslHPAKNhfCn8uyNoKtsl
 C0pb8tb6/UdBXYgCATuLzL3JzdI/zxEXWmx1n5DqWQDhMVeTOztY6GMeycIA2sbOuXp4
 d8s7UxD2RbEqRVTD11ZbsDpeZeqHmkXek8JShma/RwYs4VrkqNieyXxDpt9ZBtmUkqoJ
 V6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740683685; x=1741288485;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r4+avpSbbzWYkNaeDhSuqdxVwdzpBCsCOAQajLWFpJI=;
 b=j3h2DYT7cuzvme+6PstKKDzNY1zBAx0NYglK5QfT0inpRumZF/pHzrfJYmgh4CxUDq
 mUqqghfMCp4qgyof8Pe5Qcyp/WyX67EpQKTnTPfk6VN8nRFQaw/JHRfyzNz6bRdVj86S
 eFn+Yp0cAyOUysp12osrmPeCXjkvSZGO4oPt4OcSzLI+c0GoqB65AeFCYSJ1bHH0dU6/
 Da+/pvDy3pAdggnx0OcPLJUkY9h4ZqThFrzTdbxIwXo+Jtkw4seSic5LM2GStPKrYuMC
 IB1JKaCwT6sYGQ+200F0wlrSr8ixGELQYeHx8XZdO0LHVlweW0J+pNIkqmGbtudvANSz
 Nf+w==
X-Gm-Message-State: AOJu0YzVkAkuOyy8Z+K3o1mLfwMOcNKdN8HfMnhuM9GgZsCraAzN0CWF
 bTkQIoaSBC/eVB1cPvU7bi5dgoLK347g0thSf4RXfaJVkmWu8ufXl+AOzQPj38N7hD6tXJSCMzq
 Zoa8eAc0cKUZO0PvCCrxlqNvy94k=
X-Gm-Gg: ASbGnctBTsjyGr1kIWAm2AiLqLp8E97wBYBWMZS4W4IkEQ/Zz+abrgQ33NhYYgibsqc
 UHOw2dM8GgM7MnSU83heIPRJR6N5dToS0EXm5S4gP9SYxmJPZJX8onWXdM7hnYvy86lo1UDaI+J
 74pmuplfc=
X-Google-Smtp-Source: AGHT+IFuLF1vTc7pdxIzs6/X0+QtRGdqI7zAOLsJsUmnY+E77ch+YGar20AYzveFzDseXuCkBdS4r65b+XHzJ4Xbnyw=
X-Received: by 2002:a17:90b:1c0e:b0:2fc:25b3:6a91 with SMTP id
 98e67ed59e1d1-2febac0576amr283854a91.5.1740683684742; Thu, 27 Feb 2025
 11:14:44 -0800 (PST)
MIME-Version: 1.0
References: <20250227050506.167299-1-alexandre.f.demers@gmail.com>
 <20250227050506.167299-3-alexandre.f.demers@gmail.com>
In-Reply-To: <20250227050506.167299-3-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Feb 2025 14:14:32 -0500
X-Gm-Features: AQ5f1JpULObU2UWce3NfWXKBVneZfe7CRfKh_hBl0064QgTF_jGOk5zEcNnq3mM
Message-ID: <CADnq5_Ooc=VM3xw3F+FFEiXdNMcGX9eEiZsH3EWH8s91+bjfDg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: fix typos in SI
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

Applied this series with some minor changes.

Thanks!

Alex

On Thu, Feb 27, 2025 at 12:14=E2=80=AFAM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> Fix typos
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/si.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu=
/si.c
> index d1c06d0d6a2d..68f6f4ec8a47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -919,7 +919,7 @@ static const u32 hainan_mgcg_cgcg_init[] =3D
>
>  /* XXX: update when we support VCE */
>  #if 0
> -/* tahiti, pitcarin, verde */
> +/* tahiti, pitcairn, verde */
>  static const struct amdgpu_video_codec_info tahiti_video_codecs_encode_a=
rray[] =3D
>  {
>         {
> @@ -950,7 +950,7 @@ static const struct amdgpu_video_codecs hainan_video_=
codecs_encode =3D
>         .codec_array =3D NULL,
>  };
>
> -/* tahiti, pitcarin, verde, oland */
> +/* tahiti, pitcairn, verde, oland */
>  static const struct amdgpu_video_codec_info tahiti_video_codecs_decode_a=
rray[] =3D
>  {
>         {
> @@ -1898,7 +1898,7 @@ static int si_vce_send_vcepll_ctlreq(struct amdgpu_=
device *adev)
>         WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~UPLL_CTLREQ_MASK);
>
>         if (i =3D=3D SI_MAX_CTLACKS_ASSERTION_WAIT) {
> -               DRM_ERROR("Timeout setting UVD clocks!\n");
> +               DRM_ERROR("Timeout setting VCE clocks!\n");
>                 return -ETIMEDOUT;
>         }
>
> --
> 2.48.1
>
