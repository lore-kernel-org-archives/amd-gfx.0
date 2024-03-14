Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC87C54E60
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 13:17:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D8E810FB0C;
	Thu, 14 Mar 2024 13:17:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cd6Q8d0b";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 239CC10FB09
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 13:17:16 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso690889a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 06:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710422235; x=1711027035; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=npN9tw7zdaaNZSnth85nlhwxRT6Vtth/2fX+UrTvoyg=;
 b=Cd6Q8d0bUzfNgwP3FNW5YbrT4qM6heKa4Zm2MBuuSxP9HBrh0g55WeRiGTCLvicMmr
 U6M5ippwvwC9kvXrh3H/aV+RaUzmsgGC5Af77rrJbfXvivZ3hW58cwX6hdsXe61CcY+K
 hFiZgfOa8HMv3HmvFYb9/SIZayPc04q+HWLqgOPGhPvUGO2cQtXNznnDbHGuvHzd0VmM
 xd3leja2Y77sKLELPkni8iw/GdR/0wMMj0kNtB2IYexHxdfDhTISwMsBOpl/jR4jHBeL
 zUM4D3nwgHYam1T5Uoi7+J75N+6Waow2Wvp8RfbWLLoG05WJmx2yl9Ajxe+nIG/28bVO
 3LuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710422235; x=1711027035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=npN9tw7zdaaNZSnth85nlhwxRT6Vtth/2fX+UrTvoyg=;
 b=oUiFE6o4sMYDiw7qSAWrjssFvmrrLNyQiTeY2lwqlUD+FceZ7FFopjGSGr5lOZ9uuH
 dz4Qc2GW8FLd5t3ngul0y0DHJcQuRA+7nHtS5/R+KhVjDsfxl5iO3Bg6Fotv1c2PIvPt
 bUYOMwFenRp3d3xr7QiH8IfI81YcyGd2VG4m07eL7cXQ3ouVn4oU3hLZVzfyYWCYS64n
 lLqVvLtdtpV0SxKJ15xz5JKQsi60UEYSmeOIdKIjBMkSTHEdZuMYK9FZJnmxj0Fq40tX
 EsMBBAtuYVsMyUs3LKJScS/gd6qBswUqEbTOQgJXxYKOVBGJBueDB9PL7mOvyth8L3qu
 WtIg==
X-Gm-Message-State: AOJu0YyLXEr9VYCX9cDKLdq9XJRUeFM482nbVd1+R8r8X5H8pzsCZ7mi
 Njf5k81+eKDjHqEqaR7eOD5KJNRUcZZ949B455ZpGVF8JnynqzunFF9qizjOUrnFQTJkwSqAm88
 rqwZsFt5mVJFf26ssmixNvcJHkVtrkSWw5Tk=
X-Google-Smtp-Source: AGHT+IEMaEzE/n22MkLwgXKID0Gr9OtY7w4VZypEFYhB0tLPLP2zt+iZwO6a6UMF4+1yAtBiUUjhKcpnXA0RUZd/nNs=
X-Received: by 2002:a17:902:ee52:b0:1dc:a832:7e14 with SMTP id
 18-20020a170902ee5200b001dca8327e14mr1997030plo.64.1710422235335; Thu, 14 Mar
 2024 06:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240314103620.27165-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240314103620.27165-1-Hawking.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Mar 2024 09:17:03 -0400
Message-ID: <CADnq5_NmJDvia+jL1Zy97=QSnjauX-p-_61CeDmDqPhxPNeN-g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Bypass display ta if it is harvested
To: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Kenneth Feng <Kenneth.Feng@amd.com>
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

On Thu, Mar 14, 2024 at 6:47=E2=80=AFAM Hawking Zhang <Hawking.Zhang@amd.co=
m> wrote:
>
> Display TA doesn't need to be loaded/invoked if it
> is harvested.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 867397fe2e9d..bb4988c45ca9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1830,6 +1830,10 @@ static int psp_hdcp_initialize(struct psp_context =
*psp)
>         if (amdgpu_sriov_vf(psp->adev))
>                 return 0;
>
> +       /* bypass hdcp initialization if dmu is harvested */
> +       if (psp->adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK)
> +               return 0;
> +
>         if (!psp->hdcp_context.context.bin_desc.size_bytes ||
>             !psp->hdcp_context.context.bin_desc.start_addr) {
>                 dev_info(psp->adev->dev, "HDCP: optional hdcp ta ucode is=
 not available\n");
> @@ -1862,6 +1866,9 @@ int psp_hdcp_invoke(struct psp_context *psp, uint32=
_t ta_cmd_id)
>         if (amdgpu_sriov_vf(psp->adev))
>                 return 0;
>
> +       if (!psp->hdcp_context.context.initialized)
> +               return 0;
> +
>         return psp_ta_invoke(psp, ta_cmd_id, &psp->hdcp_context.context);
>  }
>
> @@ -1897,6 +1904,10 @@ static int psp_dtm_initialize(struct psp_context *=
psp)
>         if (amdgpu_sriov_vf(psp->adev))
>                 return 0;
>
> +       /* bypass dtm initialization if dmu is harvested */
> +       if (psp->adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK)
> +               return 0;

I think there may be some SKUs where the display blocks are not
harvested, but they are not used so the atombios tables are empty.
This gets fixed up in dm_early_init() so the harvest flag should be
set by the end of early_init.  That should come before this code gets
called so I think we should be fine.

> +
>         if (!psp->dtm_context.context.bin_desc.size_bytes ||
>             !psp->dtm_context.context.bin_desc.start_addr) {
>                 dev_info(psp->adev->dev, "DTM: optional dtm ta ucode is n=
ot available\n");
> @@ -1929,6 +1940,9 @@ int psp_dtm_invoke(struct psp_context *psp, uint32_=
t ta_cmd_id)
>         if (amdgpu_sriov_vf(psp->adev))
>                 return 0;
>
> +       if (!psp->dtm_context.context.initialized)
> +               return 0;

Doesn't the dtm_initialize function need a harvest check?

> +
>         return psp_ta_invoke(psp, ta_cmd_id, &psp->dtm_context.context);
>  }
>
> @@ -2063,6 +2077,10 @@ static int psp_securedisplay_initialize(struct psp=
_context *psp)
>         if (amdgpu_sriov_vf(psp->adev))
>                 return 0;
>
> +       /* bypass securedisplay initialization if dmu is harvested */
> +       if (psp->adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK)
> +                return 0;

Don't we need to check if the context is initialized in
psp_securedisplay_invoke()?

> +
>         if (!psp->securedisplay_context.context.bin_desc.size_bytes ||
>             !psp->securedisplay_context.context.bin_desc.start_addr) {
>                 dev_info(psp->adev->dev, "SECUREDISPLAY: securedisplay ta=
 ucode is not available\n");
> --
> 2.17.1
>
