Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE818C35274
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 22:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 700E110EA9F;
	Fri, 15 Dec 2023 22:03:32 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E0F410EA9F
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 22:03:30 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1eb39505ba4so699668fac.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 14:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702677809; x=1703282609; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sRTtqXfQ3+omGwSYPzYQBYMGrC38VukfVeTDsV1hz0U=;
 b=PqOzQarJga2d3mRNNjwgcmUcnB94Ra3wYKJkBjpESouiEs10wN2Xn0NYwf6sIVFjfJ
 lETmHtZ6AHABct+krqwvIaatEVt/eCtX0JQ2FQX3P2vPKVuVwLCwt8rjb3epf6BEmiMT
 WtNorqFtG5Cnmj+Ci9HIAdLvuMMvFGCvzNTGOMXmOCL9ypOMkNzEdSCB54WhgHDs2LI+
 C4rrwUBke2douGiaHJL7+3YuwZFFGIPwRj4W0wnrhEkqk/gXKqIvj4h4ZevDz8GrFfqr
 8iBFpvL9e6F7mOm7edbLAvbNXJ+4wDUxSQWgUd++GGvMlJxLPj5pAv8a1DYhVwSLSt9L
 Fj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702677809; x=1703282609;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sRTtqXfQ3+omGwSYPzYQBYMGrC38VukfVeTDsV1hz0U=;
 b=CbN3WgvBRTKOwXlBYsn6YO1Tf25DaHLvT5fp1IrdRoqVV+gDN3Vl/kx5SPPDHkOSeh
 Sxvqai6mK+pKuoRNEfEKbkW3ZuzF8X3xhcVvU7qUHf4K8MD+XEJtMiMy3AkJHpkgRgOH
 piEb3vVgUg6lpRi7bcJNY4TJPOHGuC6vuUCrRm0dmbZk0nQVNClmxy59JmDJBy7J1LYP
 kpr46XBurG3VzKSnIzfJCh2RPVEVqbcAWwy1zwpjdJSzsl/zbUOohr9pAQBQmuel+Mf/
 r7rjJDE0RwxXNXQaEPsFdUynuwksNlZlZjwnGHg7nAEX9j90kzX3zPceoMLmm/y4oviO
 zMVQ==
X-Gm-Message-State: AOJu0Yz61aY50wyoPFjmhfq73k6SGIZsN48VPM6WihJ2m0QLhP+j2HNq
 Jt/dccwPRTL9Npka55OoGyIKBQPDwMuV5w6me60=
X-Google-Smtp-Source: AGHT+IHVAfdEbTrzqgOk1N6vkHrGSIbVPa2qe34IEgzKzg/z8cNo3tZz8BVnsXLoHcLtlxa124kMNfKfgeoOsS20RRw=
X-Received: by 2002:a05:6870:b4a2:b0:203:2ea9:ef21 with SMTP id
 y34-20020a056870b4a200b002032ea9ef21mr4846046oap.96.1702677809468; Fri, 15
 Dec 2023 14:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20231215211736.139200-1-Ori.Messinger@amd.com>
In-Reply-To: <20231215211736.139200-1-Ori.Messinger@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 15 Dec 2023 17:03:18 -0500
Message-ID: <CADnq5_PRhULAv9BFeHWnvLZGtOHoXYEinMSBPnouQfuOCdo=7w@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amdgpu: Enable GFXOFF for Compute on GFX11
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

On Fri, Dec 15, 2023 at 4:35=E2=80=AFPM Ori Messinger <Ori.Messinger@amd.co=
m> wrote:
>
> GFXOFF was previously disabled as a temporary workaround for GFX11
> due to issues in some compute applications.
> This patch re-enables GFXOFF for GFX version 11.
>
> V2: Keep GFXOFF disabled on GFX11 if MES KIQ is below version 64.
> V3: Add parentheses to avoid GCC warning for parentheses:
> "suggest parentheses around comparison in operand of =E2=80=98&=E2=80=99"
> V4: Remove "V3" from commit title
>
> Signed-off-by: Ori Messinger <Ori.Messinger@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index 067690ba7bff..04494b385493 100644
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
> +           ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <=3D 64)) =
{
>                 pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled")=
;
>                 amdgpu_gfx_off_ctrl(adev, idle);
>         } else if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =
=3D=3D 9) &&
> --
> 2.25.1
>
