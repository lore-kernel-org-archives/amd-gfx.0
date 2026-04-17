Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4FAF436BF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 18:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44CD910E242;
	Fri, 17 Apr 2026 18:19:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pjmgz64g";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B50510E242
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 18:19:10 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-124a7216c9cso56878c88.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 11:19:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776449949; cv=none;
 d=google.com; s=arc-20240605;
 b=XmiqR48aVuejOJCiX7JZojffQkteD0VxFcSVJzp9fkZc9p1gGFq16jKQ8JhbTu9Dtv
 XwOOTCWRnpeP/p8/D8OSzhEvFIQQNAc9oOVCnwxDC4k3Khq+jHeJ/O++qM26YvgUV1II
 XMKM2CSjsVHlkVkuxFYtpkydDzYYw0/P13EynFEl4MLXmJz9gqVW9MXKrP/cpBDLPsvd
 uXSsPLFgURjdmwzKVb5+ydN4K/C6rYKuVSlZrxl3o+70LTxCVcE1xlosTI+g9LvHbNUD
 nVGI8M4btGZ07KG41dWqC5NkajDlRi72/zTALJ8/rWIx/lsDy6pTf18xX5BWq8fxm+Ah
 rN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=txOclYSC6zX9LYwuRA8pE9GKJ0EaAdBt+yCPe1oQGkk=;
 fh=NV6aZkRhQcdAsrCXMQB33+zPVXa/qECin2dIvBig3jo=;
 b=HDuOfSsJRuwbjdpL6hvzI78K7XW+NCDKxvHUq7ll3bPPmHB7JpdmTiQ6xX96NMhlIY
 3sbT3Rk0qLdzSBXbg06t3ITNIGFJ7uVfyrO+/fYYRu5ARVvR6iIni653B2KLDSFgnG9/
 sAOT0GKCg9CSta/o27fwmH1f55nH3NBNTAF8R0gHc/nJhavix9+mULC4WAP9Nj9XHlRz
 +b2xCcoyGIMa7t4q8HybxaNX8TXXgyvX8qBt71ZHe0bgWl7WLX2Qy6pM6Pst4/nKNnGr
 FLuhcdWI676XUrFRhefB2sPE87JebWTuqDc/1T8gEh6OMGHPjC1/saleBrf9ns5RWpbS
 q6RQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776449949; x=1777054749; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=txOclYSC6zX9LYwuRA8pE9GKJ0EaAdBt+yCPe1oQGkk=;
 b=pjmgz64gDV+gr8sjsZu1R1aVTqUPHklzYMZ8VqZgRuFQZBfzxtzkUzMx1B2xsfNYsM
 UxGll3JTVlNZnpldkinwiL5ZLELialw+4rXXd7igO9CMTHEM8oBlaHeoikssBP8dUz2a
 EyVaTgR2q8bOYdSai3+H3Czz3XjKbilhMxbitjrmQxyD1YW5G8YgJyCyDbnNiwaZOn+f
 94j/SeIKY9NSIqR6A0MElYodvCgpVBsb8L1sFM1sH0+9UPpe37VAuq66zZu9HSDeiH39
 oS9XN1YmKZnQiLcX99d8qBg4BLb7nQLlhiV7ffzJMZNHYfx+VFcOHsJTk1Bdq8NFb+cC
 47yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776449949; x=1777054749;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=txOclYSC6zX9LYwuRA8pE9GKJ0EaAdBt+yCPe1oQGkk=;
 b=PISlS21aWbTUFqWW8oS9vlUqNHfz4V2U+4A1KTAjXEX4oTZinbLmooGjzCkw4ZimAy
 0dlf2C7KoicIzjO1pvk9dnVZh5KIaWSuRQHARO1VPlivv10SURkQDGWWd5tt5ifih0Vf
 iFwVABDLh2KLETMFr+bjKR6PRVJyYHzxYZWSFBlysPaQQG5VXCeyR7fQbuMuNWdfSTRU
 JgpmyliuTgNINMhqsaNBrm9VJJxGaJsp5DnbtWKrAOT/5cx5s8fq27C+63dzgBDo04CV
 meE1Q7Xt1Y+zNmj8M5slozCT12Uqgl7TlHYoaq6fslMd4yv0bYg6dwDexNI+IdVWRzzc
 P6lA==
X-Gm-Message-State: AOJu0YyNVLKXUSlTah0UuAORlqHaN+Ng3wTcZm3X2Y8UE06MuylSIQ5Y
 YxdSihHCkbh5vZ9X0HNai6uVU99920XpDCn20WBVR+Gbal0cy2BxycXLvf/cY12IOnfDa5wscaS
 5hv4Wf/QCLUpqgmm4EZncfPWXnKlO5/8=
X-Gm-Gg: AeBDiet6n1xOcrQhk0//PPrw9etRBpJZlgRBOlq2bVatb+q7l1IhbFh/a0xka02HhbA
 lEV5wlTHiuRARjyu0Obsugr0/j6otiey3pyNRTQuckszlzQvxhZw8xjVsxKOjjmbXEMouT56Zr3
 ANk/R1R4zzS179ndhUsRW22j3adWZUHbD/Zasl6v9mKx5sawhZDv+xKTY8nm4OixdxzJo1NqWSZ
 Mp1Iuc62ei3IZb3HafcfmV1mR/ss4o4U5p4WP3JPBy7mYnWc93/9tOsoBgqLPXGrRtLVlETwFp8
 CQsl7n9JUk8Agk9VGMkyt+ZsLUbuJVdHxAJS82SK6BDuUjVfmdJj3lNEd8+FtnNgqA9X/9yx7PZ
 a6+68
X-Received: by 2002:a05:7022:6b97:b0:12c:3ef2:ef0b with SMTP id
 a92af1059eb24-12c73f9b550mr633219c88.6.1776449949188; Fri, 17 Apr 2026
 11:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260417175430.47434-1-sunpeng.li@amd.com>
In-Reply-To: <20260417175430.47434-1-sunpeng.li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Apr 2026 14:18:56 -0400
X-Gm-Features: AQROBzCVoROn-3NnyFmvoB98KApge-hgSBE_msMjvoO8uHM-RGcrOtFsuCWMb3U
Message-ID: <CADnq5_M+DfU0_PO7DW-q3hCJzCWDa2kngG5onds_5XJqQO--tA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Undo accidental fix revert in
 amdgpu_dm_ism.c
To: sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com, superm1@kernel.org, 
 Ray.Wu@amd.com
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

On Fri, Apr 17, 2026 at 2:14=E2=80=AFPM <sunpeng.li@amd.com> wrote:
>
> From: Leo Li <sunpeng.li@amd.com>
>
> [Why]
>
> Pausing DPM power profiles during static screen caused a bunch of
> audio/performance/clock issues that were addressed in this fix:
> 1412482b7143 ("Revert "drm/amd/display: pause the workload setting in dm"=
")
>
> This logic in function amdgpu_dm_crtc_vblank_control_worker() was moved
> to amdgpu_dm_ism.c, but the fix was lost in the process.

Do you think ISM will fix this so we can re-enable pausing the power profil=
e?

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> [How]
>
> Reapply the fix to amdgpu_dm_ism.c
>
> Fixes: 0b572a6bf04a ("drm/amd/display: Add Idle state manager(ISM)")
> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> index d2f47c69921d4..d03ea3bafd469 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> @@ -270,7 +270,6 @@ static void dm_ism_commit_idle_optimization_state(str=
uct amdgpu_dm_ism *ism,
>         struct amdgpu_crtc *acrtc =3D ism_to_amdgpu_crtc(ism);
>         struct amdgpu_device *adev =3D drm_to_adev(acrtc->base.dev);
>         struct amdgpu_display_manager *dm =3D &adev->dm;
> -       int r;
>
>         trace_amdgpu_dm_ism_commit(dm->active_vblank_irq_count,
>                                    vblank_enabled,
> @@ -315,16 +314,7 @@ static void dm_ism_commit_idle_optimization_state(st=
ruct amdgpu_dm_ism *ism,
>          */
>         if (!vblank_enabled && dm->active_vblank_irq_count =3D=3D 0) {
>                 dc_post_update_surfaces_to_stream(dm->dc);
> -
> -               r =3D amdgpu_dpm_pause_power_profile(adev, true);
> -               if (r)
> -                       dev_warn(adev->dev, "failed to set default power =
profile mode\n");
> -
>                 dc_allow_idle_optimizations(dm->dc, true);
> -
> -               r =3D amdgpu_dpm_pause_power_profile(adev, false);
> -               if (r)
> -                       dev_warn(adev->dev, "failed to restore the power =
profile mode\n");
>         }
>  }
>
> --
> 2.53.0
>
