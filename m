Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CA4CC6B1D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 13:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D97410E5EE;
	Wed, 14 Oct 2026 13:25:14 +0000 (UTC)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DB0B10E5EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 13:25:08 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-14a51c8ea7fso79386c88.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 06:25:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791984307; cv=none;
 d=google.com; s=arc-20260327;
 b=lyNm8xi8t/pIEDJ5UFDFql5R+PvN9+EUXVxltQJN3xA4nqJkUTB8p1Nzbw+XOxQ2po
 eWNxDIByVO0iOWcLEH7zD4xUkBdJNe3TQ1ZP0XHdQ+QihF9yoOlVAwsabP5k5uRgv5+M
 OyA4f/crOf6p0AnHz8Xi+J8Knu+wHxblxDPBVtbW95Wl2pRx41b3BRLl2EbWAxnHjFmJ
 4h+AgAkFFBmzV0OcNnR2Y2lo+tw6mx6fmtaPL5ZR/hl6Xr6dsGrz25x0z5DUoFPjKS2h
 vJJt/koTpb+lukmwjoz6CUSjsmikH/wmDvDdxmIutEw7V/b8emQfECjtdOUG0RJWMxDE
 aTdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BldPZ0P5F3Pg+pdT1U8xeUmlRdpnGGLa0ugFhNCUBf0=;
 fh=aVfKs0NI43n3ZkDGw2yb7fFc6JQ9Y1q6mj6efKYf6ZA=;
 b=BQXdjKPNTNUGHHdanYD1hhONDO5dwQqiZU64GFdQmbd1MTS0TIKy0cZhG5OU88iKoq
 JrMS51XQjZwfrfkbdEtlyReQM94gENIMDgafSX/X8oXaagQX4InpfrlJLh/EmeJ63304
 DNb3Pzd3Q/vDQkeBxXhh+LxFarEunRmBpzDXpklvmlxVC/PU/s+YDIfTJYkiW40uxdCR
 1v/BslsPePCEUnvJLlw/h/5zc5Ee4MGimy/cI/P4rgoPJLpNeFNEJiIPndsG2G2OgHbJ
 85mmxIiqzuaXm+4ojx3d9wNaeGWKjKBk4cTbhwd+YMlH6j7cegKFjxaz2iSiN5YcMQmE
 d5hA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791984307; x=1792589107; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BldPZ0P5F3Pg+pdT1U8xeUmlRdpnGGLa0ugFhNCUBf0=;
 b=krDUem2HOSzzBiL8Gm8j1awjlPQTJxUns3POmSkatb1msvGd6qMzF0NPktNwguLzoY
 ce5koFAhNngUsEM/0qTYX0sGULvPxZk2Y4qjWiMNOqkmOAVntHnlGyf5XIlbZ0drhxeo
 eeE7MquQ6VsSx6oU/QQkDQid9PzYG6ZZim19bh2ZW3kHTK7KKV9HNhTZeI6X+RH9WLte
 z84sd1/5MWq2GKAaObAWVgt4sk+FEww8R6o0zJNLxb5ztmHlO4fAyeVr2HdZbpZs7eq8
 +7tDfqfnR4bF1dtgmhB+sUy7Z441qs6NJDy1l+ebUuBRNBqIDLFMD/QeBXu1ImAkroAN
 T6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791984307; x=1792589107;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BldPZ0P5F3Pg+pdT1U8xeUmlRdpnGGLa0ugFhNCUBf0=;
 b=G6fEAoYzcs6HoO4VshIPpqO15/ltlswSiCFTIWpZbwPIu6KD2c1Qfa6zEaMDZi7nWV
 KV1BLS3sX9BWvdc9ApfVXLqkUxRJEZjik3n7hkBLvLhgge5vkR0vWq3NnLoHnRFvhSDs
 IcAkMgPFSg/5mUXVmn0oS5UfyNMIspDyUUjtsZdW3bdPGB1uZl1s88jEKqcBWL8SkRiZ
 7MPcqi1kXaI3A3DueA8oXPx38K6w0SLRthSQe263bCGW961dJKHLA4BeI1sib77BP5HP
 IFChPmkVK6KwRUKlV8y0CXNldKQ6ToRIGOZsEnUN0ZC9e74tA1IaGaayfr+59cWtyLFE
 xyuA==
X-Gm-Message-State: AFq9FYJoHRkgv27abwtiREBimgn7QjauDXwUSEBfnnCnziOpzEVvVUwZ
 Xpupkp3d+Apl+ZR4IKHgQWAbr7qHPLoNzdfC+vT+mdIWleepDlG4iuCNN/gZIC/FCull+g0zRuJ
 grgo2XD8WMA1G3tALO7Pls95e1ywOyIkCeDuu
X-Gm-Gg: AYBFou0N3fWGeq59L3nR7RwzOwubW9Qtltn6VrdP4MXkOFMWfLA29eK8UpcbZdagkfb
 4JFbey0BW6/HXIQNBrdL1MYNAZwcKJbvjYPh7ohcYaIy98AMyfwsM6WgDlTF6iymO2dYyuUHpct
 HEnZliEgt4ij1hJLLgZGJ0oE0+dYm4A1zw2Xi6yuzfNS/F0rJhA7s/9Sos54+v4Vw4kFuM/RFz0
 6OebA/BQ5AvDqOwCAat1iExDpHNpbR1Ho1jj3xSndixmLZ1O1h37+ft0wriEFF3+fhJU9kKs+gB
 5AtrhrNWShKct8bSmwqRAS/jY18kHjo16Q/rc0vrfR2sa5w16OSPQ5jx0LQ7HQxnjHAhb0emBk9
 o6tTYgfuA8C9KLAJHo/PTSQCYT75IwwTiKn300ewkLQ==
X-Received: by 2002:a05:701b:450d:20b0:143:5c2a:e45f with SMTP id
 a92af1059eb24-16a4e6cc453mr32231335c88.0.1791984307416; Wed, 14 Oct 2026
 06:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20261013174330.20307-1-will.aitken@amd.com>
In-Reply-To: <20261013174330.20307-1-will.aitken@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Oct 2026 09:24:54 -0400
X-Gm-Features: AclHuK9kXEGFOCt0oKA5zlWFGLJKQhed0v91YYcQ7Kml_Sx6DVU3-m_1cuE7rqI
Message-ID: <CADnq5_PnzUQx7B1A2BZ=+cp_TAhGk9dG4uaE14obk9JDNE5dLQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Ensure fb-sharing is enabled for xgmi same
 hive check
To: will.aitken@amd.com
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

On Tue, Oct 13, 2026 at 2:01=E2=80=AFPM <will.aitken@amd.com> wrote:
>
> From: Will Aitken <will.aitken@amd.com>
>
> In sriov, fb-sharing can be disabled via the xgmi ta. For this scenario,
> hive_id alone is insufficient for determining peer accessibility.
> fb-sharing enable flag needs to be checked as well.
>
> v2: Move fb-sharing gate to amdgpu_xgmi_same_hive from
> amdgpu_dmabuf_is_xgmi_accessible. All xgmi connectivity checks need it.
>
> Signed-off-by: Will Aitken <will.aitken@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.c
> index 45e31b3daf06..ccd6429ad7b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -349,6 +349,9 @@ int amdgpu_get_xgmi_link_status(struct amdgpu_device =
*adev, int global_link_num)
>   * The XGMI memory space is built by contiguously adding the power of
>   * two padded VRAM space from each node to each other.
>   *
> + * Note that even if multiple GPUs have the same hive ID, sharing betwee=
n their
> + * memory spaces via XGMI links can be disabled in firmware, i.e. hive
> + * membership does not guarantee connectivity.
>   */
>
>  static struct attribute amdgpu_xgmi_hive_id =3D {
> @@ -1484,7 +1487,8 @@ bool amdgpu_xgmi_same_hive(struct amdgpu_device *ad=
ev,
>  {
>         return (amdgpu_use_xgmi_p2p && adev !=3D bo_adev &&
>                 adev->gmc.xgmi.hive_id &&
> -               adev->gmc.xgmi.hive_id =3D=3D bo_adev->gmc.xgmi.hive_id);
> +               adev->gmc.xgmi.hive_id =3D=3D bo_adev->gmc.xgmi.hive_id &=
&
> +               amdgpu_xgmi_get_is_sharing_enabled(adev, bo_adev));
>  }
>
>  void amdgpu_xgmi_early_init(struct amdgpu_device *adev)
> --
> 2.43.0
>
