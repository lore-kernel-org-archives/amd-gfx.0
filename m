Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7308FD3776
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Feb 2026 17:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 543E610E7CD;
	Wed, 25 Feb 2026 17:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dS0uvxzf";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA1DE10E2BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 17:36:28 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2bda3b4318dso418458eec.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 09:36:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772040988; cv=none;
 d=google.com; s=arc-20240605;
 b=Og/jaUOQgJix/khIs/nUpWZWusBau2tZlsJUqMP0ovUR0ywa0TFqEME6TbraWhuuWU
 vfC+gQ4ZhPdvROIUrJUGXPi/hNFmaPno2trltBu//Fqz9vKWEKhbqT9cyhWo1dT09Vyp
 OdQl0ONBaZbE2Iwpj8PvdHCv28sUMnia4DfLQIuzDx/63MKjYjcat72HCB67mpRtp3m/
 CJWfiTI+I4gO0Se8Es+TZGZibLboHVGzpxlFrDTVtZwPFuW1SeIeC/+qkO2o0LT/g/pB
 hMb8bNHB+dW943uzSabUqeytd2+y9h0w2LW6uW2g1Zd5awgQcMTYqTEfhzZeabeLSjaV
 NvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zLNVEEL2NH3DJMk5q8kBVXqzPRSb7bE1hYpaacAnCdM=;
 fh=/jXuF6kkEzGc76I89MWDwYajZhHhstOH8SMMdzCQivY=;
 b=I8bxE1Dluj0GyzGWLelUXqblBwITzlckujZT4JBovRmCi5KKsuDCjq2bOwzkS08Mu7
 8UWzXHRsKiBpBLICI2zKxInxSco7AeiTGAl/36v6/35clPWrevrcCrICkhFTIUpiXlEQ
 uPC53rXSVAfJiJ12nCNVHt/7O3k2MS/0VxawZxW8+75V4eRKzck4jYzdQUshaZVZ40f1
 9Po4YaX3DUjjNDDI0rKMFtL0+i82s9phOeGOPq6YJbYAYtVvQqARyPoFcQf4/D5Ti/OO
 Q2qcFzjun0PAmiGY/JyF39oM3ZPE/hjBfQSVnL5INskv7UV1qH8AmJAct3XTcyRDH8Hx
 m2Ow==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772040988; x=1772645788; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLNVEEL2NH3DJMk5q8kBVXqzPRSb7bE1hYpaacAnCdM=;
 b=dS0uvxzfYjVv8KpMjGnF4HGUdHrbfChEWgSlrXWxn3wbScOAjRo8Z6OE9rdB7ob9Q8
 TkprbO7TT+viXQFJz9DRYNZyhjUCVJkML+FH4iGK4DB+0mnG02C2MOkQcSYvJQAzwor6
 0IbhsQFzbHo/h6hMAdOD/YTHhyBJY5RC4YTisQgVHFT/jNSm6Uu/VNEG7ojJGtl7t20t
 ludcVo+reXuPVaLa2cG/pQSp2SlyEAbdzoehhWSm6TV0LBUzbL5AoTCdBUtSNgiN5KM7
 8xBu5KM+FyTZsW0S6AW+h7LzazoPqulk9neyVrOm5X0NBT5DKpW9qcP5jo/9dPPYN4CK
 7XYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772040988; x=1772645788;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zLNVEEL2NH3DJMk5q8kBVXqzPRSb7bE1hYpaacAnCdM=;
 b=lZoda+0b2gqS1Toh+BbHn76s4qqOIfl9Kt4d1hafqGTgqjhYYgSbfGhkD60zJVL9Sg
 4sn8FcWj6MIn7MD+yV6fHTlHFalHSsWS95H9OlCfcs3oAvUCEQfzkCAin1+6wVBHJ+Kn
 Thixgtedgg3d+91Sor5PrDYiIZy5/TK+qOKdy+ByVyacPj/4yFrJwZ+Fe/cLp0td6Mmg
 Sak+zrz8iSRCxUaaFfQz0Q+3jUuITa70bMB9yHxlj2rAqGo7WLUEEx8j3ifQawJjT7HR
 Eyzz4mYbD0xfsxtArdZF/2o/NHvIMAeanTTOgEgRYYnTDlwOZbjDxBIQOqNUXe0v0rIB
 iqmQ==
X-Gm-Message-State: AOJu0YykD3BYMDdbPFVUUJhDtSqo4ONNpYZjm8OlD2kt7cf10ULIrmWF
 6hNpTmWglmDz+vURGENiDJzskiT/7qAcFgsg7pLq4bupsLiy2KtJQUI/Hir6+oQT6VvdFOVI73M
 yI16m0Ujp0Whjogg+LNbJ5Qm5hZ5L4TI=
X-Gm-Gg: ATEYQzzaKjP8t65vZw1tY3UlciZVL872dBJ5zqrz65SMfvp5+KTB3sImjyQ/FQ/53nh
 IVkoTHU75HjvSuEDT56gfmygZFi1Jxv2hEGLOgCEAiW1Q3FxbJTEgeZ868ZYlDorwcN6WvBdawO
 t13C/WT4Ivu5ZiCCdskzmieolL5OlrG+pY96dIsyW8g0DlD9ZWrGrYyxAD0k6ljrU5gZy09x+cZ
 mKOt124B98OUdQ5QkUDGNEsWfK7wH55FUn+9dU01+ZFp+ycjLJjDXQgw7hKSxu7T3wX0AnzXbjt
 tVoI/PfGW7Dbtn8DppBTUEY9YOxeZ70uM0EtOXcKLrl5VPVVGEUsnivfIhDezzLTsgc+rQR2Nig
 ergnm
X-Received: by 2002:a05:7022:69a5:b0:127:2d87:f0fa with SMTP id
 a92af1059eb24-1276ad1be5amr3409483c88.4.1772040987923; Wed, 25 Feb 2026
 09:36:27 -0800 (PST)
MIME-Version: 1.0
References: <20260225165116.46224-1-mario.limonciello@amd.com>
In-Reply-To: <20260225165116.46224-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Feb 2026 12:36:14 -0500
X-Gm-Features: AaiRm52sUwSIf3-UJfu4BXxf4gtC41OW4MPuE5Jd2_G3A70Rw9aRqub47M_qavQ
Message-ID: <CADnq5_NHvMu9+g5pOk8ZDcs7XsKUQv6ro31ZbBqG82Vav9gxpQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Disable MES LR compute W/A
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Wed, Feb 25, 2026 at 12:09=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> A workaround was introduced in commit 1fb710793ce2 ("drm/amdgpu: Enable
> MES lr_compute_wa by default") to help with some hangs observed in gfx115=
1.
>
> This WA didn't fully fix the issue.  It was actually fixed by adjusting
> the VGPR size to the correct value that matched the hardware in commit
> cf326449637a5 ("drm/amdkfd: bump minimum vgpr size for gfx1151").
>
> There are reports of instability on other products with newer GC microcod=
e
> versions, and I believe they're caused by this workaround. As we don't
> need the workaround any more, remove it.
>
> Fixes: cf326449637a5 ("drm/amdkfd: bump minimum vgpr size for gfx1151")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 5 -----
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 5 -----
>  2 files changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 09ebb13ca5e81..a926a330700e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -720,11 +720,6 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_=
mes *mes)
>         mes_set_hw_res_pkt.enable_reg_active_poll =3D 1;
>         mes_set_hw_res_pkt.enable_level_process_quantum_check =3D 1;
>         mes_set_hw_res_pkt.oversubscription_timer =3D 50;
> -       if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D=
 0x7f)
> -               mes_set_hw_res_pkt.enable_lr_compute_wa =3D 1;
> -       else
> -               dev_info_once(mes->adev->dev,
> -                             "MES FW version must be >=3D 0x7f to enable=
 LR compute workaround.\n");
>
>         if (amdgpu_mes_log_enable) {
>                 mes_set_hw_res_pkt.enable_mes_event_int_logging =3D 1;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index b1c864dc79a86..5bfa5d1d0b369 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -779,11 +779,6 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_=
mes *mes, int pipe)
>         mes_set_hw_res_pkt.use_different_vmid_compute =3D 1;
>         mes_set_hw_res_pkt.enable_reg_active_poll =3D 1;
>         mes_set_hw_res_pkt.enable_level_process_quantum_check =3D 1;
> -       if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D=
 0x82)
> -               mes_set_hw_res_pkt.enable_lr_compute_wa =3D 1;
> -       else
> -               dev_info_once(adev->dev,
> -                             "MES FW version must be >=3D 0x82 to enable=
 LR compute workaround.\n");
>
>         /*
>          * Keep oversubscribe timer for sdma . When we have unmapped door=
bell
> --
> 2.53.0
>
