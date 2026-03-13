Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA1C107BCD0
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 18:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04C0910E47C;
	Fri, 13 Mar 2026 18:25:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fkix8BLk";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B5D410E47C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 18:25:24 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2bda3b4318dso185515eec.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 11:25:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773426323; cv=none;
 d=google.com; s=arc-20240605;
 b=kykqbxw/GCbw31nOGcM6eOuL1iZJmQkrPF38sTNdATI4eKZTvCZsEyWoQy57eKcNtX
 HtFxw7DPC/zHxRwHRBubPIADZkqucE7h6/oRUTXMrD1IPvJWem3uWhYNq7F6nkzdAiLR
 uRpkaSODUUoHoftFlUz2+fAuyXu2DVrmfgSWueKJz0a2LQJ+KzTCsi9iOhWAgj0xs3NP
 DGeQi/1k0SVW4PLSN/V23GIEiGBagOeE3ZqPUS7NyxsittP8Xk9NXsfAp+zyJ8GglX7h
 P7R7U5GUFl48Rf1JeJRsTn/gC/x0E6PV2QursUo8Yb5k+6XFEV1lp0wNr+tTZAV9xbn4
 Qd3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CR0LOi9Vmq3LBu9ylfFwnq6YMFBnw48uN51/cftdcPU=;
 fh=PMJv6ooPwA9MYGpUwV88bcIdo4vS13F61F4a4/AM3Y8=;
 b=deTCjVq9TJZd6fjnB5IwgeTzw3t3LLFMMFJ5jTZvF8K/As/kuulcUzEoRPZG0Iz36i
 XFLKutGEe4GHQtlOofegfLHhLBWufuolq5TT0CrcoBvUjl+s0SUy/PA3M0BS1b4DlY9v
 sIqrmDvuasWDjpEOy56iO0xF1rH3yKmsE2mu6L2tV01IvWNkjiHOrgndBVjR+rVRK6ga
 UCsOMOURlQPNbDxll4/Zxw9zV0z6e31O1Lqk1ChVdFgMAsbVsiWgIpbBSxu+eNm9n9c+
 HlhROVjcuZsJER26sRqzEuu6PRuA6lqcbfAKhlw7jDB8ATIt3AopOBv0JveFNdsY7E4t
 L1Eg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773426323; x=1774031123; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CR0LOi9Vmq3LBu9ylfFwnq6YMFBnw48uN51/cftdcPU=;
 b=Fkix8BLk1OOIkZWO+dkroBLYQDvYn3wLkynH3ympe/XMWA5/CTiT+uq9bXcq9hO+Dq
 IbChIiysxz5/rEVGprT62EC6aSWCDOD4CeX45xV3H4d55/+OOOAF22ByF/829DrQ/rxP
 ZWSPRdM5dyLGOuc5872sv6IEjRCJfhpEOU83r3zJ50pjfznl1Cyvzxg/DB1ly/TWpuHv
 kVJ1EpryT3rQoj+sHzc5ONytrQG/GMQTzxqCqueBXb2zbLLvLQLcShPuNnpnS9pzbgY7
 dGsSBMiX1ugSGEtQ8Xj7l6zbvQzE4Eqbi82N3hFtM+ja38vK/AgUHA3kU7MkaTYu4AX6
 Dw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773426323; x=1774031123;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CR0LOi9Vmq3LBu9ylfFwnq6YMFBnw48uN51/cftdcPU=;
 b=Jfk8v/o5GgDwqYoeHenzJgl6LmOSY6tUUEVltjGLsSvhC63E2dB5ucNFKRGMk7Oyvb
 b8hyBDlRAtKvWcNGb6N8KaMmHowu7lm4PInSLGQvHwNKneuwJpRgSLodP8G2z7r2akiL
 ggTwUlZT3lvLMIoTvkDvI1gycVUC0ZqHD6WJ/PrsP8ol209r5Tugw056SCLbRy/hZ8xY
 9QbvQh3ZObGogm0uykfk8E5YpPiwTVPlzji5nIAe2thKnXwM5knhe84+HvEWpTfRaanK
 5y+Fw7D8mArncjU3mL1mAfITImPSV/TfQYw0BMpLmBJYkiFa2HFO67uuH//n+b1aNS2U
 BNpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMsrHlCVh1P2V27/9S9NWb6sXtN6ujuGJmoj5fQzP1GSXQOUb6Bj+DBesuuN82MumaOPljRTMK@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6NGipAahVIs9WpXZ/Rox34ex1IPlzLHNj27L+sR3Df7gFPLKG
 LYwnm564o9SVPMTyuf6ISMEPDGgW3w36QFTtjK5pEVpIP4gopl/LXwXMO7syDTbai24UVy08Hz+
 QCZTB/F4beJNIxO+tu2SAr2wyM8tUiGg=
X-Gm-Gg: ATEYQzw6kufo3ZUyTibfMyj5odL1DELNlx++lZLODz7ZZBQ3hIin/hG0jDL8XoxLpJE
 G23+9dmdME1qyg82BI/lkgI0X7XXGtUOd2o3kRVswIeennZ14fNlffGW+h7iz+XDiSRtDOlAYB7
 vbMgkKplnM75kg4GCoAfwc4VaE2lfNwNB+S1cOJMu1BrU1OI5q8ArLQuWOf4AT4BPxk0QPMUokh
 MZIAnoO5uh4bp6cn2bxKUhKjbkJLXOAWlbhJYkkb4pf8iMzeM1gAu3YxEICiMtKqgigYdt4zL3Q
 ktexEEzXng0+CPt8XTNTxHVHEvMac85FJ4v1XTEfn8Fq1xtFiiex2wbcPH8JC+I3TSkPoA==
X-Received: by 2002:a05:7022:e1d:b0:124:af80:9d0c with SMTP id
 a92af1059eb24-128f3c54944mr1003487c88.0.1773426322984; Fri, 13 Mar 2026
 11:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260311211837.2482799-1-alex.hung@amd.com>
 <15e4fec4-0bb7-41e2-9543-1b1df3905172@amd.com>
In-Reply-To: <15e4fec4-0bb7-41e2-9543-1b1df3905172@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Mar 2026 14:25:11 -0400
X-Gm-Features: AaiRm50caL1unr1QUXWg4Ne6w2il78NkCemnwIzCnwTbVvp2BgSUj7srZqa2V3k
Message-ID: <CADnq5_MhmgB0PzkpBqC33MoeEBDgYAghN=9LUBmczNeVat4AEw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix gamma 2.2 colorop TFs
To: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Hung <alex.hung@amd.com>, sunpeng.li@amd.com,
 alexander.deucher@amd.com, 
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
 contact@emersion.fr, daniels@collabora.com, mwen@igalia.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Xaver Hugl <xaver.hugl@kde.org>
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

Applied.  Thanks!

Alex

On Fri, Mar 13, 2026 at 10:44=E2=80=AFAM Harry Wentland <harry.wentland@amd=
.com> wrote:
>
>
>
> On 2026-03-11 17:18, Alex Hung wrote:
> > Use GAMMA22 for degamma/blend and GAMMA22_INV for shaper so
> > curves match the color pipeline.
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5016
> > Tested-by: Xaver Hugl <xaver.hugl@kde.org>
> > Signed-off-by: Alex Hung <alex.hung@amd.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> > index d59ba82d3d7c..aa4658867e55 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> > @@ -37,19 +37,19 @@ const u64 amdgpu_dm_supported_degam_tfs =3D
> >       BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
> >       BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
> >       BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
> > -     BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
> > +     BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
> >
> >  const u64 amdgpu_dm_supported_shaper_tfs =3D
> >       BIT(DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF) |
> >       BIT(DRM_COLOROP_1D_CURVE_PQ_125_INV_EOTF) |
> >       BIT(DRM_COLOROP_1D_CURVE_BT2020_OETF) |
> > -     BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
> > +     BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
> >
> >  const u64 amdgpu_dm_supported_blnd_tfs =3D
> >       BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
> >       BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
> >       BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
> > -     BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
> > +     BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
> >
> >  #define MAX_COLOR_PIPELINE_OPS 10
> >
>
