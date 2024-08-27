Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B60BC54734
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 13:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8C3F10E312;
	Tue, 27 Aug 2024 13:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="anwAlDX2";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AB9410E312
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 13:27:17 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-201f83e0d47so3243785ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 06:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724765236; x=1725370036; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFcCeFf3O2+q4CBXLmbQ2IjSyl3Z/cZzHrUxEFVTxuY=;
 b=anwAlDX2eSOoi4nMj+FrTcofr0przJklYJG9ZHjIQKS79yAzNVDeQBeXW5P88V9NzI
 UQtWrgdLcAyBIef5AKqENLURKb3BXdNUFmeDEkJ0G98Iz31dyRPsRA+5untjXfGXFuPz
 jtXx2iRx2kxKk2UMY6PFeefRfu5Hb4WQqwOY4EX1Mu6zlACiqqUXGxN+hUWdOZO6+vqi
 I03dyfGmTHnCLZJ6DyWrPAWAEtJj1FOQXwajWnBvuydeQieX7IYmGWir0uNz8Wcj1SLt
 wTKTU7cHmeDb7Uqnm/jDHDMR0aZoMV0NoaMveT1u9qFBHmr27Zm4chzmIJSVmtWSPFfu
 R2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724765236; x=1725370036;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFcCeFf3O2+q4CBXLmbQ2IjSyl3Z/cZzHrUxEFVTxuY=;
 b=fw0JzCbBeL8DWxsOPbF45XPyAWWdPRbeyxHpjpie8t/WIdPO4jWDJwRh6/B4m2DXjr
 Q640FLpiF/Azkp8kS16zs6TOfmB/6MIPvHBzFA7B6b1oXA+bMRFR69eAI7WRxBPbJTbh
 k/h09ayDiIvkqq+1iUFxBRRhHmLCjpD/zAe2VNTOTxX5tDxPg6cAqTWiJL0ItsAB0TyW
 KHJjuZe60Tsumo12M2zpU9rJkUZxhX1OSFxJgzO9rjCcGFSvPmJsMDe4XIMXNgw7OoVp
 YyT1JZKazu43cGZ1hIrYaQlstws9Cm25tfWtma1c3+QrU84uP08DUZ/TC2KWRuX+8zpJ
 A6BQ==
X-Gm-Message-State: AOJu0YzIYKck7YQyVsyfZp8bKTjaSQUUCdFut+E2zDZQZirKcDa3eubQ
 lNU9JVENqXR4HGwbskvVQ1G45AFf4jMfyPi/Qf9ZBW3ffcmSYe0Od4csIpxg+QXiS/pvrs6GsP6
 gzz08ViLuW36LpEW6/B+HlbDrjc0=
X-Google-Smtp-Source: AGHT+IEEL/KCGrLy3zAyBR7yKkt+1IlcI7AQ4BxLQ+xC5ePOChkGyZOgSRPBWc9HYs1GZOLE1s2dc+jeYBKqRPIMbjQ=
X-Received: by 2002:a17:902:f551:b0:1fb:a38b:c5b6 with SMTP id
 d9443c01a7336-2039e43a895mr94245785ad.1.1724765236305; Tue, 27 Aug 2024
 06:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240827132120.62204-1-yifan1.zhang@amd.com>
In-Reply-To: <20240827132120.62204-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Aug 2024 09:27:04 -0400
Message-ID: <CADnq5_MSOFRLHiaAP0iuOz0yk-=wr=taw6Jr80zaVEfvN-w1Ug@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdkfd: Don't drain ih1 for APU
To: Yifan Zhang <yifan1.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, Xiaogang.Chen@amd.com
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

On Tue, Aug 27, 2024 at 9:21=E2=80=AFAM Yifan Zhang <yifan1.zhang@amd.com> =
wrote:
>
> ih1 is not initialized for APUs. Don't drain it or NULL pointer
> error will be triggered.
>
> Fixes: 490fc21fe97c (drm/amdkfd: Change kfd/svm page fault drain handling=
)
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index b44dec90969f..512cbf9403a3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2458,11 +2458,13 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, st=
ruct svm_range *prange,
>                 adev =3D pdd->dev->adev;
>
>                 /* Check and drain ih1 ring if cam not available */
> -               ih =3D &adev->irq.ih1;
> -               checkpoint_wptr =3D amdgpu_ih_get_wptr(adev, ih);
> -               if (ih->rptr !=3D checkpoint_wptr) {
> -                       svms->checkpoint_ts[i] =3D amdgpu_ih_decode_iv_ts=
(adev, ih, checkpoint_wptr, -1);
> -                       continue;
> +               if (adev->irq.ih1.ring_size) {
> +                       ih =3D &adev->irq.ih1;
> +                       checkpoint_wptr =3D amdgpu_ih_get_wptr(adev, ih);
> +                       if (ih->rptr !=3D checkpoint_wptr) {
> +                               svms->checkpoint_ts[i] =3D amdgpu_ih_deco=
de_iv_ts(adev, ih, checkpoint_wptr, -1);
> +                               continue;
> +                       }
>                 }
>
>                 /* check if dev->irq.ih_soft is not empty */
> --
> 2.37.3
>
