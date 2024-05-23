Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E50CC25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 18:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C566D10E7F8;
	Thu, 23 May 2024 18:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kpYrMBOS";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5269C10E7F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 18:45:26 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-681907aebebso67105a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 11:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716489925; x=1717094725; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWxAcSiZX2XLOMYw8TeqkHmIf09eBTUKagaxwSUUJII=;
 b=kpYrMBOSa3+mAi3YQV4Se4CUPsNp4xvn2bjNoJqp07Skbgv0gCwQ78foT4OAKIIQqs
 HxYt+9UrDgvuPrztbIUaJz2vwfFeo2/hzdUUvtBUYl5sVwcabdJQoCEgbRr5TZMM/0GP
 D0qLLdcpbuQ3gpRv+1E/T90J5Z6zPXcdtBvwhK72stqQANXM+PUvAqCCAS1IKoY2aJRH
 ow2tr6s2S3JOkI7JTgN69h0GOgnegt4pRWSMbSG4fve31E8IygrvIfeM3kHDJCt+uYLm
 BPA5VzVVpVvv1Ef1ujZBPqKD9mWhps2EPdr9NYm8piGK0yjKWmUjr8e7Ao3NQ0J6wNLE
 bBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716489925; x=1717094725;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GWxAcSiZX2XLOMYw8TeqkHmIf09eBTUKagaxwSUUJII=;
 b=bgFWvbLD51oKh3z55OTETB2CNBVOQaaEEtz6y4bOwe4cAwjw7pfdhwWtUt39xoCpVK
 arAT0OdLlTX2j7Lh5cGicblIVFxzdYNhkrP2ov0PetvZzDxlnYMkjXWfJ9AgRn1PE4jX
 oDbDA0OMzUNUWsBLq5t898e2UlOruYIP2WkenwB/QK9y/GLxyDEQDLD6UWjMDSJNOx+0
 FdezIObkkrXw5EvWCTyXOEN/ooRNvbyo7XWEVe3hSAjSflaLLT4zjoxvvbSVU69OTgPa
 z/Rl22+lPTNELbW1EyX4nhi0Lg8rDGRrM9F9woLzPOB4kaG6GJz2EeaZl4nhBEBnRKbf
 MlYg==
X-Gm-Message-State: AOJu0Yyy/j1nwl97euoL+N2XaBjl1UW2Rl4CjjdJ3y+bdG8O3hllGscz
 vKBO0eZZSBX8j3TEpge27ki5fZedBoYzNdvs1km6CWnPTJosuW4OFM5fc9NaA7a98qq/LHHsBEF
 1DKanIn5pjU/0uJCr32apseEZ73AC3g==
X-Google-Smtp-Source: AGHT+IFVy9jdI7/pXpo77bhsc7c+30F6ZR6x54JOrVUMqPl4PY4NNZXG/308qaCWA/CikayGcGa7Oyvpv5B8Z7AjpcE=
X-Received: by 2002:a17:90b:3593:b0:2b9:e3:3561 with SMTP id
 98e67ed59e1d1-2bf5ee24d2cmr4325a91.43.1716489925517; Thu, 23 May 2024
 11:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240513202514.141828-1-alexander.deucher@amd.com>
In-Reply-To: <20240513202514.141828-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 May 2024 14:45:13 -0400
Message-ID: <CADnq5_NXvdP0xfvMRP+APu5a6eVXaiLYcCqQ3ajMLEPNbXryTw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/gfx11: select HDP ref/mask according to
 gfx ring pipe
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping on this series?

Alex

On Mon, May 13, 2024 at 4:32=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Use correct ref/mask for differnent gfx ring pipe. Ported from
> ZhenGuo's patch for gfx10.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index c87943f6c4436..c8c055ef2f3c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5294,7 +5294,7 @@ static void gfx_v11_0_ring_emit_hdp_flush(struct am=
dgpu_ring *ring)
>                 }
>                 reg_mem_engine =3D 0;
>         } else {
> -               ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0;
> +               ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0 << ring->p=
ipe;
>                 reg_mem_engine =3D 1; /* pfp */
>         }
>
> --
> 2.45.0
>
