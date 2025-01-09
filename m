Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B555DE77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 14:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B3CC10EDF9;
	Thu,  9 Jan 2025 14:24:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kIqUT4IW";
	dkim-atps=neutral
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AD0310EDF9
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 14:24:07 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2162b5d2e1fso2016575ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jan 2025 06:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736432646; x=1737037446; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=73vv7BpgYnHFQ5+Q01T/6AmEduoNnrjhfDADF1mYKkw=;
 b=kIqUT4IWBzsE9FVdr9Ks7o9e5R9a7QhZs+M4htEWvFf3QZ+ndbEekiqlg37SjGqT4v
 A6CdQsgXEgQyXSjBZbcVimWkjOawZ4ok3LwVp6xMJqFLN9zp+vfRvIYtvBGxfWDNhLx6
 /caI1TYDQ4cO3Lh+0MSbc7faUcYx9Fx3TctVOD39YeO2dwbTLbZhz7Q8TF4Y0TzCpDke
 KJZCzl52xfan2r390rq4D74/+/T1GhRzttBRZ8vJvPBlfgt+xwWf/IEoubpZgfQI2OcN
 d0QN1iopmUx/K+7auN/xl3M5gsUejJYtXISOWQw1yVi+mcCyoxqdvOXtS0LOAo03JIqU
 gX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736432646; x=1737037446;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=73vv7BpgYnHFQ5+Q01T/6AmEduoNnrjhfDADF1mYKkw=;
 b=ezyu9uOQyPbtXzzpG/bbGWQPKooJiTdqH4JGPyLjfCG7FaVa/v6erqsb2tdcds7cEC
 aDvo70Z5rKa9ESJ/Zb1t6IPOSK6chWRxFQyPfeDK40Aue3GJDiycIJ+EBHXDovLZ7Xvi
 4n1sXqXXEIiUx5kMivdKnZm9erPIdkuRxCfMp6ZwJcLLjReztqyFGy/XJxHhWEtXYH6J
 mwYlwhLkhsaOvQoBBu7TlxlRNl18DxtptRFTuaIacucIMVWEGs1peUmFHD1e1YhnAeL1
 6E3APMcPZLytVB5iGNKOgXYF68zcBMGbCfr2WqqOO5RoIO4Jbrh/pFsEAJdQOtYNDS4Q
 L2Kg==
X-Gm-Message-State: AOJu0Ywp92ZB6Kro29TQ1XnX7xH4K4wQxkd7gK+XEBvN6VX6+O15vLPt
 zIbTQcrGS+PwqgDS6WV1wFqWfct060MzHl+nHjDpsPJiSNchFYnt3GejjT6wJ8karx/TT1+FRue
 SKh/2V/c1JQZ5DKMFHBkGEI60QXePsQ==
X-Gm-Gg: ASbGncvap4mW5EO29tCcwLlNJwXjZEsj7qF0Psf8ok56UwwnPqZeq7/Seleejc4UhlG
 y0ThzcQ4YR+1TcVLAPZXwK5WDpapHF1vN1wIh7A==
X-Google-Smtp-Source: AGHT+IFDyZRD3ji5RKlg/8j4kc48ElKuSukNqBfwtXMGRrHR/YXUQNTziQ0HjUbJ3XRTEH/X1JsVdhq3TCIuMotailE=
X-Received: by 2002:a17:902:c945:b0:215:2bfb:3cd7 with SMTP id
 d9443c01a7336-21a83fad103mr39763765ad.10.1736432645065; Thu, 09 Jan 2025
 06:24:05 -0800 (PST)
MIME-Version: 1.0
References: <20250109082524.11102-1-kenneth.feng@amd.com>
In-Reply-To: <20250109082524.11102-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Jan 2025 09:23:53 -0500
X-Gm-Features: AbW1kva7UZn95in3JqMBZD5RRreo5UYlXC46QWqRl5QXyAjFVF12tZagTWfki5k
Message-ID: <CADnq5_MZoby8nOPJGXmST2f9=YkbscOwGVR5w0vaXp9oxKLCug@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable gfxoff with the compute workload on
 gfx12
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kevinyang.wang@amd.com
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

On Thu, Jan 9, 2025 at 3:58=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.com> =
wrote:
>
> Disable gfxoff with the compute workload on gfx12. This is a
> workaround for the opencl test failure.
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index 2e5732dfd425..e4cf25c47509 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -715,8 +715,10 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *ad=
ev,
>  void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idl=
e)
>  {
>         enum amd_powergating_state state =3D idle ? AMD_PG_STATE_GATE : A=
MD_PG_STATE_UNGATE;
> -       if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=3D 11=
 &&
> -           ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <=3D 64)) =
{
> +       if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=3D 1=
1 &&
> +           ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <=3D 64)) =
||
> +               (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=
=3D 12 &&
> +           ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) > 0x6C))) =
{

If this is just a specific FW version that is problematic, we should
just check the particular version.  If this is a general problem, just
check the IP version until the issue is fixed and then we can update
the check for a specific fw version, etc.

Alex

>                 pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled")=
;
>                 amdgpu_gfx_off_ctrl(adev, idle);
>         } else if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =
=3D=3D 9) &&
> --
> 2.34.1
>
