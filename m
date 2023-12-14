Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D82C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 20:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F129910E21E;
	Thu, 14 Dec 2023 20:08:03 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E1BC10E21E
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 20:08:02 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3ba2dd905f9so1152376b6e.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 12:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702584481; x=1703189281; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUSUsWZdOni/0nYK6n1CT8m1ckD86672nAlbpuUoVLg=;
 b=eHkCT97EcejUoVVXte+KJzQJRihZgvbZ5esG3xk66SJyf4REmTMMcGVZPsojMM2i+o
 7la1OOdTCSclLvh/Cg/suv+aNtur/rO6x1685rURw41KE04/VZ+aPT91OQphWvRCR1A/
 yEdSkkOzEAyh7zU/Iz6NYP+UCUX3wS6z+3Afi/5y4R67ZCtJ5UV3ojGE5XTCdY6BA6/i
 clJdd371xr9eMEnyujKzNfVrir8S/ALB2nh9PAE4K2VRYaVrsNVAVwqg/ExE6kaVDLmP
 A2YjatQPGu1KTet7D4/uHlxGLNm4ijZ+2Bx1Iv88/U0BiEaI0CkJL95qP6Q0h18zghvC
 0xpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702584481; x=1703189281;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JUSUsWZdOni/0nYK6n1CT8m1ckD86672nAlbpuUoVLg=;
 b=rRvLlxt1SLOB2Mf06QkYpvOdQ7tCiTrjFNyruXBzckMOy/JujHtLZlWm2TiVKdtMlf
 XCwyaAMl0snawUIH12uzq/t6Jdkt1bsLKfuZBE4oXhVmDANdGpHlrDrymWL0fDJmN7VG
 IZeCXoxicY13+azEGisFvCDjPiJMGSKu2VlH8cg5clNxVdK9OYQ/5rqH/K6SCQJ7b8rw
 SeRdSDvLF8YrOnCWUdf8RvGbu4Wlljc3t+2i1236x0CZ798Xi6iJsUVEmOc18z6KmBNT
 18JMhtXlIV8kw7K4ZIVuQv9bcdO1/tTSdVEGyaMfUBzdm1Q2iFkQ5MdNtMgIrw3elcBA
 06QA==
X-Gm-Message-State: AOJu0YxWbeGG+MgYY6f7LzMIFV8rJ6OEFGiQEavuVupQmZp+Vjaw4kHk
 7Vwj63C7XL+bsEl8V+Ydhm4P8sH+xZZr4REJ+7s=
X-Google-Smtp-Source: AGHT+IHcbd1IPZw7rcoACtUMWio5d9RtEg+2J69G3M+WZ/kx4tVE4tL/o+0aVazFHerOOursXchY4Ijjsgj38hzq/5Q=
X-Received: by 2002:a05:6871:7584:b0:1fa:e993:d09e with SMTP id
 nz4-20020a056871758400b001fae993d09emr11677098oac.38.1702584481186; Thu, 14
 Dec 2023 12:08:01 -0800 (PST)
MIME-Version: 1.0
References: <20231214194725.136840-1-Ori.Messinger@amd.com>
In-Reply-To: <20231214194725.136840-1-Ori.Messinger@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Dec 2023 15:07:50 -0500
Message-ID: <CADnq5_NxdeM=nnmLn2vt0zKjEzwrNUswGFVTqUOk90YuYTRFWw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Enable GFXOFF for Compute on GFX11 V2
To: Ori Messinger <Ori.Messinger@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 14, 2023 at 3:06=E2=80=AFPM Ori Messinger <Ori.Messinger@amd.co=
m> wrote:
>
> GFXOFF was previously disabled as a temporary workaround for GFX11
> due to issues in some compute applications.
> This patch re-enables GFXOFF for GFX version 11.
>
> V2: keep GFXOFF disabled on GFX11 if MES KIQ is below version 64.
>
> Signed-off-by: Ori Messinger <Ori.Messinger@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index 067690ba7bff..6586b00c3b2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -695,10 +695,8 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *ad=
ev,
>  void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idl=
e)
>  {
>         enum amd_powergating_state state =3D idle ? AMD_PG_STATE_GATE : A=
MD_PG_STATE_UNGATE;
> -       /* Temporary workaround to fix issues observed in some
> -        * compute applications when GFXOFF is enabled on GFX11.
> -        */
> -       if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=3D 11=
) {
> +       if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=3D 11=
 &&
> +           (adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK <=3D 64)) {
>                 pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled")=
;
>                 amdgpu_gfx_off_ctrl(adev, idle);
>         } else if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =
=3D=3D 9) &&
> --
> 2.25.1
>
