Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CE5EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 12:56:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE89910E1A2;
	Fri, 16 Jun 2023 12:56:04 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAB7610E1A2
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 12:56:03 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-558cb7f201cso446799eaf.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 05:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686920163; x=1689512163;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u0xclVm067Rq3S60q+K861ACS344r6ZbmNw4YwSXMzc=;
 b=jGKb8X23WfytRrCyvbi4oyUqahWmkjkfsGMDf1Kc2Voa3scr5P0gdMWE/c//Ke8PKV
 bTm5s1LfESxU8RMtONtiTOQIc0B5GLs23AIFpc9/6OuotHAZtC3X5wk7+OolCywsHA5Z
 vRPBWll5a0+CnKDuXLvBF3P75yu4vzVNliY77Xey5aabCVBKWC+2N+yqyI/GuriTLBnn
 4QuB6z98kaBpQ6Rw6k5PqT5IZTcYzAXkCaLzkZTMKts7vgaBTZRQL0fnyFMQd4da4Jrx
 MjO/3UxFt/jvBISMD5HsltBcrquwndCfdJb4V2pc3m6mK2JkxwBkCarEtzciYCZGTWDB
 tR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686920163; x=1689512163;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u0xclVm067Rq3S60q+K861ACS344r6ZbmNw4YwSXMzc=;
 b=WpyaiS6iIdKUXspKxdzJPEFUoHqGHeIAo5BugfODQTrWdwmlb+WZCRLtou56mtlCrB
 +NFt+meUvgBoG7YE5c+EXj9D+YK5kGHTGYyuPj/QuoCeoo9tZp6Ay4IjazlbkrNPkqw9
 cmPjo3CMrXZnz4R5Sop3xgrTZE4ittFyARoDVrPvioH5BG/6zFMa4L00T2bhdCwZSi5n
 t88V/T71qu983oWv/3jlCIvQyGZT1TkZZ1xreBNKBNZXWHQPuXdfEQwBz42uTqifSFf8
 v1cue+xoDbZcZ/uozeu6xX0Pf8qrph3rAjBGd1YmT1RY/cFjeVflupr93iqVIfROqUlC
 1C8g==
X-Gm-Message-State: AC+VfDwNbcl1Q39p2Nh27ccBxOQXG2PBxKrHdc3ODhl5+gehrd7HP5qL
 7FCdVKW1sBnQ4pA6buIFpXPO0Qnc8nYscSJrcJQ=
X-Google-Smtp-Source: ACHHUZ4Pw/8tdYfPYpiFhqOpUiubnOCRa1wVBLfxUBzgavPeFJS3kBzvfyzOFy6btUDrw1A0f32xS+kVKJhq3/vmR24=
X-Received: by 2002:a4a:a849:0:b0:55e:14a2:e99f with SMTP id
 p9-20020a4aa849000000b0055e14a2e99fmr373626oom.9.1686920162740; Fri, 16 Jun
 2023 05:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230616050725.1464277-1-jiadong.zhu@amd.com>
In-Reply-To: <20230616050725.1464277-1-jiadong.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Jun 2023 08:55:51 -0400
Message-ID: <CADnq5_N5uRd=R_JoTM0trLgF6UZd_Qq-7HvPqTmOKaPpDoj19A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable mcbp by default on gfx9 chips
To: jiadong.zhu@amd.com
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

On Fri, Jun 16, 2023 at 1:07=E2=80=AFAM <jiadong.zhu@amd.com> wrote:
>
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> Gfx9 is using software rings which would trigger mcbp in some cases.
> Thus the parameter amdgpu_mcbp shall be enabled by default.
>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 65577eca58f1..1b3cfda946f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4527,6 +4527,7 @@ static int gfx_v9_0_early_init(void *handle)
>         adev->gfx.xcc_mask =3D 1;
>         adev->gfx.num_compute_rings =3D min(amdgpu_gfx_get_num_kcq(adev),
>                                           AMDGPU_MAX_COMPUTE_RINGS);
> +       amdgpu_mcbp =3D 1;

This will enable it for all chips since it's a global.  You'll need to
store the state in adev->gfx or something like that and enable it on a
per chip basis, or just make it the default everywhere.

Alex

>         gfx_v9_0_set_kiq_pm4_funcs(adev);
>         gfx_v9_0_set_ring_funcs(adev);
>         gfx_v9_0_set_irq_funcs(adev);
> --
> 2.25.1
>
