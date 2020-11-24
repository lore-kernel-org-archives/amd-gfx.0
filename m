Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0895C63777
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 15:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB3F20684
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 15:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ufdxgJYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB3F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED5166E44F;
	Tue, 24 Nov 2020 15:47:01 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0947C6E44F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 15:47:01 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id s8so22753083wrw.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 07:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LYXRtd7RJ24Z2Pm7hYXybO3RyvAw0ZhWg2DLcNtZgLI=;
 b=ufdxgJYCU6VajcE6sN+18JOnYubD/iLwiqg5U7q1sN3m/nCZ/y1ewwv0fAAE9Tjc+T
 cU7ZsgJKqgN/5B0Of0tUFqt/jb4MtYIDeK2aPfB5aH74iSBweK0epPzUeJd80FJ4pjxd
 c1dKEchjzGpiFkz6pDVRN+ZOwRvcrTmotwvBnqcLNbhrr+hHaMkfC7bUqr+eqMzXOnpx
 EBv7xk+GJKcpeApvCYYv1FyQNZtAodCxKewvekZtPXXAyZzzyc8ks+soanw+IuRujCy+
 vRcUcgy/Nya1lUzduN9k926dJpYDxMifmNsWoL84Lo7Jje2nXQIIsCEyYaNlz25FpptN
 cnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LYXRtd7RJ24Z2Pm7hYXybO3RyvAw0ZhWg2DLcNtZgLI=;
 b=TcJ/x/R7SZKabDXGJFrufKMgx4e88sTLVoev7NoAuGfiWh22/98snyVNOXIZAil7lH
 mX1jsmbz4hTbusEZ0XLfJJrQFB/faG/tCudqZNNn5mpX1bWp7t0q+L2qEMJlM8OpiCgM
 RPZ5M8HLNJCPmggsCYygi02dwzXKr01iR046FHYDzKAWk6X+WS09F0eLPu/oKktBR21J
 bbtZLeY9BlPmx+adwdjkngEP3xM9QOP/vMxUhT7LNlg4pZmdyQlOOwI8i6G1HUCFNGkE
 18wkaHK2wszgpArUZwxdMlC27LWmHeUgndKs77mFEbuMa/KqqqiU/1rfffPpLVknSDhr
 BKQg==
X-Gm-Message-State: AOAM530p22XAXJx841XD2qcNJAU41CPILlLgrIs53egxRYamVfZhvbwU
 fcZuSJsiJydiQkIX7QbqCKy34u6PdNPXhojI6Mc=
X-Google-Smtp-Source: ABdhPJy04ub9G35W/7NgC/Vb10ciXusP6Lks8fG+PrgK7SL3rBg3oDI92sfEAHDjwzfCg27KTac9Qfr5G2yrczAFDck=
X-Received: by 2002:a5d:400a:: with SMTP id n10mr5927074wrp.362.1606232819772; 
 Tue, 24 Nov 2020 07:46:59 -0800 (PST)
MIME-Version: 1.0
References: <ou0uzBHIyn5i1sQXWfXck2EDBtFXVmfBnGJXF7Rqo@cp4-web-027.plabs.ch>
In-Reply-To: <ou0uzBHIyn5i1sQXWfXck2EDBtFXVmfBnGJXF7Rqo@cp4-web-027.plabs.ch>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Nov 2020 10:46:48 -0500
Message-ID: <CADnq5_MyoV8Q9_s+2p37CKAWkAxZkjqeR9AWazLTjc8fLCO8Vg@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amd/display: don't expose rotation prop for
 cursor plane
To: Simon Ser <contact@emersion.fr>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Nov 20, 2020 at 3:19 PM Simon Ser <contact@emersion.fr> wrote:
>
> Setting any rotation on the cursor plane is ignored by amdgpu.
> Because of DCE/DCN design, it's not possible to rotate the cursor.
> Instead of displaying the wrong result, stop advertising the rotation
> property for the cursor plane.
>
> Now that we check all cursor plane properties in amdgpu_dm_atomic_check,
> remove the TODO.
>
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Applied the series.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2542571a8993..3283e22241d7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6592,7 +6592,8 @@ static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>                 DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 |
>                 DRM_MODE_ROTATE_180 | DRM_MODE_ROTATE_270;
>
> -       if (dm->adev->asic_type >= CHIP_BONAIRE)
> +       if (dm->adev->asic_type >= CHIP_BONAIRE &&
> +           plane->type != DRM_PLANE_TYPE_CURSOR)
>                 drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
>                                                    supported_rotations);
>
> @@ -8887,7 +8888,6 @@ static int dm_update_plane_state(struct dc *dc,
>         dm_new_plane_state = to_dm_plane_state(new_plane_state);
>         dm_old_plane_state = to_dm_plane_state(old_plane_state);
>
> -       /*TODO Implement better atomic check for cursor plane */
>         if (plane->type == DRM_PLANE_TYPE_CURSOR) {
>                 if (!enable || !new_plane_crtc ||
>                         drm_atomic_plane_disabling(plane->state, new_plane_state))
> --
> 2.29.2
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
