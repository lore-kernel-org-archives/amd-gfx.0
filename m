Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF678E85363
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 13:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82E1F10EF95;
	Fri,  3 Apr 2026 13:07:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hJuU6vyt";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A000410EF95
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 13:07:23 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-128eb45835cso84876c88.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2026 06:07:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775221643; cv=none;
 d=google.com; s=arc-20240605;
 b=UyR65LS5wYzwKLG5H8HE1f+sPuAlwcpMXVABHGFG274LpT/XqCH10SxYlOPlsm66Fi
 o/ZekEdVjEQ1maHOMLwid96tP6/I4aeCgxbmKjojQ8sReNEeUJ6QLa9OjgZzZkMM9GT2
 iUs9MMtzAA6r2Er50gVTjmcrh/NJM5AUXCT5b+KcqdckRHUxv9iXLFBenC7pemXoJkh6
 DFU0jq/+u63gNjJ8qPVIPnsI6+ZhtuGqD1DstLYh1/kbyIxezPaQZ2zFEYdGJkTeWLuV
 EoYLC6+Ky/r2Qqr0vteQwsODAqNnPqPlV4MrcuaFvyEVUFaDycHPU09HLPOmNpAC43lE
 mvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FaKgmpls5oB/paV47i3sjZoRWoB6PxmMKo6a2BAg3RM=;
 fh=vwH+z4rW0AhcHXbAs3qH4QlXhPdlWOpRz+aKiYkebl8=;
 b=MjupTAl8RI6B6XKK745dRdUqEU/2Qrq931Bjw+Uij6TN7TPLyB1ZdUqBVUTkuS4Zc0
 yFkWIEjbalQjaoVwUXsgzJKqOj9Ep7iWs2gUEZUAA5XkwTXNyYxxa/DSZBUIemKdoqdi
 ZNNkxxA/S6hIDqezh7qAjD0+srMDgvRvX5infYoeZnXW+jojzU9/Tw/rBb3IhsT8NvQQ
 qwPD18uy8UXwrhqW7RPLgBcWM4lnFgOzLw04Pen4PjvrUiT+e/D70/9eAtabyVOGQWGe
 iczwoDlZmVhFQFzDobKPbIGjRssNWd1d7HBIxZy9bpLmzbfX1xBUfdHJk4cv1fDrl03W
 3+NA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775221643; x=1775826443; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FaKgmpls5oB/paV47i3sjZoRWoB6PxmMKo6a2BAg3RM=;
 b=hJuU6vyt5c/wB1ZiVYGwh6laTUPNFFAn1gIdncOx+16TU8omZqvPEd973sIXIK5rhE
 vDsaLHsbwofJPzF8iy9R3M653Lg4Mr4176OE4p31c6tdcvS2dtI+9KbUvKtjtJalUU3e
 PXsiSvLnEktGvf2fY773RKunJMUO+lbzIqbRtBAF76cStRRpx/fmUnpbzJdX0QgeRpie
 VyhjAk+JvvUKAELA9fYiW5THlKf/Nc0QY1y+atU2n7Qxo5/WmR1iQOI90gT98IfddUiE
 o/3XS/rTSbZga2kQsv2hcvuO14V+nUjfM3q4XsXBJSTZqgRLJhJDJtZOvo44Sjc786rI
 SMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775221643; x=1775826443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FaKgmpls5oB/paV47i3sjZoRWoB6PxmMKo6a2BAg3RM=;
 b=EFPkZ7CD9kDGoCS8GFvrRt9aFrLXuzPuZCVf9FV12WNoqTp/wvq8C8SLh9g2H+X7FP
 R/MxOl9Q2ZeC69uZNvwsJ8BK/+v7sPYQBWlKhRam+z50y1N/JgdR9MtDt1Rh39427MvS
 2G84sV3X1l0c1dB8Gw4OV9TAADpvK4/WYlHOUhWuRyWJ3gk0qC3l0I31yh/Wf9Us/78F
 Y1omS/CyYMMvFDiAxP2BVGR6QO8urv3SPveMmD/B42E+2S3C8I3B8fWyBEXdSWVnCYFy
 gqZIokt4JA0DD+Z/dnSsmrVy7LGAHfGw9C4QZ0qWfyrwhLY8ifnfvXgsiLpXUlOBBLX2
 TkUQ==
X-Gm-Message-State: AOJu0Yy1uQKsXBHiz/zfo9Gu8A5rS72/LF50TZgFNL6xC0YrWOLhgMq1
 f82yL42ltmsMgTAK7O8S3Xzzmz/nCDoq4p6e48LypIcb5YBX2TPkzeyv0gnrVnov2U7yB2qQUVf
 Bo56NBoSK+TLBsrpENbfNT0tY/aUsncY=
X-Gm-Gg: ATEYQzxuB117OnwwbyJCoWYLr8gHpn6a1uyJOauAcPpMeHYg5wmUTUBn8bo4tdGzxJB
 KfxaeRr0AS6AWCSN/AP1F2kp6+ozOoIW7UR2PIKZf5zyW3RKa1KL2O20499J6VW/+2f1NkqLzDU
 30bqf7k7pP/s7fkfiWYX6yQm2pFRXQZVDRb2DfTBEdnLvUr4Eq6DmLMyR9wtVypBHTs+QmX5De4
 OjU30PBFIUZ/kRr7gXB3Vl1yaDiDiK5jLYwNCkML8NFMO5CDg6Fzo42Sxf4LasgggEVIJt2j/SR
 otUHR+hvtLjx0KF99c5IgPds9+Hr6GAsUIDjG3SNfZhfrIK/wAlIW7Li2KVnWiWnuj+5SQ==
X-Received: by 2002:a05:7022:128e:b0:119:e56b:46b6 with SMTP id
 a92af1059eb24-12bfb633be0mr595755c88.0.1775221642751; Fri, 03 Apr 2026
 06:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260403092529.2238333-1-Jesse.Zhang@amd.com>
 <20260403092529.2238333-5-Jesse.Zhang@amd.com>
In-Reply-To: <20260403092529.2238333-5-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Apr 2026 09:07:11 -0400
X-Gm-Features: AQROBzBvAaqvtqbNIvjCWXYavrwZq02LXEKu90uOvs1SNMQ5vc-gwtpX_TLrTxc
Message-ID: <CADnq5_OfUJsZTtHw_sfrfaZwG_8Hjdr4yvdMk2AbLUPzEQLmTA@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/amdgpu/gfx_v12_0: enable compute pipe reset flag
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Prike Liang <Prike.Liang@amd.com>
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

On Fri, Apr 3, 2026 at 5:34=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> wr=
ote:
>
> Previously, the per-pipe reset sequence was incorrect, leading to unrelia=
ble
> recovery and potential firmware hangs. The reset logic has now been fixed
> to properly handle HQD cleanup while the pipe is held in reset before
> bringing it out of reset.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 7aa3853f8db7..17c590444af4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1563,6 +1563,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>                     !amdgpu_sriov_vf(adev) &&
>                     !adev->debug_disable_gpu_ring_reset) {
>                         adev->gfx.compute_supported_reset |=3D AMDGPU_RES=
ET_TYPE_PER_QUEUE;
> +                       adev->gfx.compute_supported_reset |=3D AMDGPU_RES=
ET_TYPE_PER_PIPE;
>                         adev->gfx.gfx_supported_reset |=3D AMDGPU_RESET_T=
YPE_PER_QUEUE;
>                 }
>                 break;
> @@ -5362,6 +5363,11 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring =
*ring,
>         return amdgpu_ring_reset_helper_end(ring, timedout_fence);
>  }
>
> +static bool gfx_v12_compute_pipe_reset_support(struct amdgpu_device *ade=
v)
> +{
> +       return !!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_P=
ER_PIPE);
> +}

I think you can replace both gfx_v12_compute_pipe_reset_support() and
gfx_v12_pipe_reset_support() with
amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_PER_PIPE).

Alex

> +
>  /*
>   * With MEC pipe reset asserted, clear CP_HQD_ACTIVE / CP_HQD_DEQUEUE_RE=
QUEST for
>   * every queue on (me, pipe). HQDs must be torn down while pipe reset st=
ays
> @@ -5396,7 +5402,7 @@ static int gfx_v12_0_reset_compute_pipe(struct amdg=
pu_ring *ring)
>         uint32_t reset_val, clean_val;
>         int r =3D 0;
>
> -       if (!gfx_v12_pipe_reset_support(adev))
> +       if (!gfx_v12_compute_pipe_reset_support(adev))
>                 return -EOPNOTSUPP;
>
>         gfx_v12_0_set_safe_mode(adev, 0);
> --
> 2.49.0
>
