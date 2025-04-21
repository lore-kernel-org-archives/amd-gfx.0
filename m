Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6DCC369AB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Apr 2025 13:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42D8010E393;
	Mon, 21 Apr 2025 13:09:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dVAQLa2i";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B956210E393
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Apr 2025 13:09:34 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2ff6b9a7f91so478089a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Apr 2025 06:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745240974; x=1745845774; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7tji+sxb1BsNuSZUlDxFsVMGAhSxzwcnFwWhIh+X6kY=;
 b=dVAQLa2iIzrgcEGLNjGYtW1rH21uj1izZUL1IRgKa+KHsFtoktP0IbngwPTDhK6mK/
 LljBfdWvs+f4cLUIXTGJIz91dYo8u1AshaPqGFnNspRPPDnDo+Xrw4z4GCagQUa1IJW7
 H8o1VkefnnZbQNWYUjB1bi5OHccDLJ2TmoUh6iIfhk2xUTKPwrh50KjLO0PuZE56arHh
 5alaMsJcMlfGRYEc0imKthzY4hmJDLRdfnsFGxptGDrl1knY90ltRz87cW5Zxjef8dDu
 mf5PcLTFg26V+0/X7zPc474Uv0BhIhH1jsSYpt0bGCoiGyq5pgpAbPNc62BvfJc2LlhP
 mAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745240974; x=1745845774;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7tji+sxb1BsNuSZUlDxFsVMGAhSxzwcnFwWhIh+X6kY=;
 b=D98oP7MOaSfCcMXn8Xr9RZuQfKKZIT+tav82phcR9H6svqhLbUvbMhJf1P5RxiVpOu
 G5BMbXbht6Z2M/qQRMnmuaGVVQqNxyYTs6EGqxJmcoV9pKbKkBGqCC1ZiNbyY9UOfhaO
 2Co9VFCQHLpamV/EED2DRUL6v6Q0fRGamHvKcaUYcbBVnc/PJYOtG7Gw3Ruvz3H1OvJQ
 +RKEPUGw9HAbsF6O7ePCYVh3D8iB0pRQsKnb83kBV78DOKxBaPl7euoed3n1J8jGO5Qp
 cLcD1hgnY0L8Hgcn6Ipjj6xqLTFq2wi3rfdzr1OdNmd8t1SAKYBAp6P5sr26yf3adw6p
 OO5A==
X-Gm-Message-State: AOJu0Ywo9A3dlYDP4NZopFJhmUd2LsMBXV3ivKiFol/yaAM6v6brpmut
 v6bAjXZ/qCNdSfwUaVAVeUDrxl2whcb4Mag2ewhWppLmUXEXZ9nbhlcWgjQwa2/vMWzdTlU13jC
 qmpIIfRmCwlOM9BlfzAunBGk3v77JbA==
X-Gm-Gg: ASbGncsTae22E19dyI2vnXTN+xqjvL97c5+0EMZC695o092ZG7gbpUAl63yI+WGC8Ja
 xaYJERvIF+Rte2LosDHpmKjiTWgrCFahmZvp7X1XjPAymPl5Y2c/r47BUbYR5/pAO02F9zEhTAo
 ioF7VAxdckSQisMHVRZfDwQA==
X-Google-Smtp-Source: AGHT+IGs/W+JlLm2SPpkYtVo+Jl+yVwglKOKa0w/oANcrUMIVKQwUlkezijpiNt0l1dBzmM9vFSJeb16SIX63S0O61U=
X-Received: by 2002:a17:90b:3e85:b0:306:b6ae:4d7a with SMTP id
 98e67ed59e1d1-3087bccb2c1mr6218593a91.3.1745240974178; Mon, 21 Apr 2025
 06:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250421093804.880633-1-lijo.lazar@amd.com>
In-Reply-To: <20250421093804.880633-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Apr 2025 09:09:22 -0400
X-Gm-Features: ATxdqUGdJYsYW-Y3ZEqfXrx03XuRRx-ubZhGcrj1JTLMtwVF1tDjRzXw0Napddw
Message-ID: <CADnq5_PmP9+JM8fLOctX-vuhkUpK03QzbAX21bMag5cg6zMTBw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix offset for HDP remap in nbio v7.11
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com
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

On Mon, Apr 21, 2025 at 5:48=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> APUs in passthrough mode use HDP flush. 0x7F000 offset used for
> remapping HDP flush is mapped to VPE space which could get power gated.
> Use another unused offset in BIF space.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Assuming we have a full 4k at that offset:

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/am=
d/amdgpu/nbio_v7_11.c
> index 2ece3ae75ec1..bed5ef4d8788 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
> @@ -360,7 +360,7 @@ static void nbio_v7_11_get_clockgating_state(struct a=
mdgpu_device *adev,
>                 *flags |=3D AMD_CG_SUPPORT_BIF_LS;
>  }
>
> -#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
> +#define MMIO_REG_HOLE_OFFSET 0x44000
>
>  static void nbio_v7_11_set_reg_remap(struct amdgpu_device *adev)
>  {
> --
> 2.25.1
>
