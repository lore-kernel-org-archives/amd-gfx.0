Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A116EC282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 19:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DA7710E09C;
	Thu,  6 Mar 2025 19:19:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="daccSdFj";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AA7910E09C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 19:19:25 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2ff7255b8c6so162205a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Mar 2025 11:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741288765; x=1741893565; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j8n7VTv1pNI+ZdE0gF08V/O1smcpYtOtequ9Hy4yPjY=;
 b=daccSdFjFHsjD0O95Gkt+2sQ/7sxW//1LySFY4X1K6jeHiCnoRin5B5Z1lO8q/iu2F
 38XBMsoe6pnPCGoyY9wbgXStNjMgJWjKV5+JifVcdV4JXoFzON6Vdx+oLJtF3CrFtGSt
 J7aLsUmzWRLZfqs520QSGSxpoFMG6HfXJYuu6p787cdr9l798uS7vK7/Wo66mYzYxxMU
 NQc8E++s/OQGke9Ggqc3SbT81EvTf3RL6wu1pbtD+1lbkutXqlPTljvYy2cCzw6WBRiV
 wL31+YtXCIi480wQwUnzXJnqdzDGGtn0nkstUu5jDKK6E72WMVJUCVU6iPfKK1WKoKbH
 ySIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741288765; x=1741893565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j8n7VTv1pNI+ZdE0gF08V/O1smcpYtOtequ9Hy4yPjY=;
 b=JPznshlrvFAC5x8sRrdQ/epkJjibar00FBd98CvOzjxxxq9aIGcwMoLe3heBcNjaNt
 d7GJMLwC6f8Z9Y9U8LNxsNTCfJV9KH2WB5zNz1FV/3YzvyWYYxfCpFeJDFzvTBRXpLt9
 yYm3dKUOk1S40LzCBnMJJ9UocYaJP82uENaFJwsnyV6Ph54cRNdy47eExTQMoDxKjJ5e
 q1ymDCYG1WmhOkLYd3eerLaROweXaO5xM7nP9L2ArUB5hCosGll3iLKCQEnJTB8k/MwG
 OqitMSTx6rGPcO7R+e3kKy5DEhyzcPJ2Abdt7hNwVgTNMM9CKe97DgaySfnCHkH2PU8q
 dmhQ==
X-Gm-Message-State: AOJu0YzwE2XqqHn4wgGkB0tqst35IFx8P/t1S5QA/UxiIGo36BP0N9xO
 YJCgvkMEDXvI05N0mQ0uj7W82FXDAc0aU7diok2peZMElpVQHxqLWmQjNLhkrGF7i+JXjXKjL2d
 CxW5E4Uhpqz2+LbMdaYLXZhOOqM8jb1Ks
X-Gm-Gg: ASbGncssNhgBfm7m/CEsfzfMpXRNm4u66yn7KTM2LL6g0dWesOt7kPr8jnWLc5ehhM3
 L8/DCsXRQb1gV6UnLBef6iGKX8Vx6C+JozLvgzsDY5rjRMqDRj5dF5TBGQ7cZ2Y1XG+HibvO/zt
 mCBg+6ZqYEFZKZc6bX0EcHE885ng==
X-Google-Smtp-Source: AGHT+IFS1Zn+mAe+zhKWfJbRpqCnOMXayPtN45WyQm9kf3G8SnjN6DQGF7ySNliZcvCSvrz37VPh6BTWQUAJto5RTi0=
X-Received: by 2002:a17:90b:350d:b0:2ff:4b7a:f0a4 with SMTP id
 98e67ed59e1d1-2ff7cf13ae5mr246678a91.3.1741288764692; Thu, 06 Mar 2025
 11:19:24 -0800 (PST)
MIME-Version: 1.0
References: <20250306185752.50871-1-mario.limonciello@amd.com>
In-Reply-To: <20250306185752.50871-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Mar 2025 14:19:12 -0500
X-Gm-Features: AQ5f1JpHd8V91e9Vv4FFG81hIpkgc7eA0zA2sB9XntU0GLNgRTYi8jeHcylRFbE
Message-ID: <CADnq5_NUZwNK_h05mbAD7iba1JjDj=CtQ5=fRb_0VDpgaFzG6g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd: Fail initialization earlier when DC is
 disabled
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

On Thu, Mar 6, 2025 at 1:58=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Modern APU and dGPU require DC support to be able to light up the
> display.  If DC support has been disabled either by kernel config
> or by kernel command line the screen will visibly freeze when the
> driver finishes early init.
>
> As it's known before early init is done whether DC support is required
> detect this during discovery and bail if DC support was disabled
> for any reason.  This will ensure that the existing framebuffer
> provided by efifb or simpledrm keeps working.

I think there are a couple of corner cases we need to handle:
1. if adev->enable_virtual_display is set.  The user has configured
virtual displays and hence they want to use them rather than the
actual physical displays.  This is useful with GPUs in servers or for
early bring up.
2. If the board supports DCN IP, but all it's been fused off due to
silicon flaws (e.g., adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK).
In that case, we don't want to fail.

Alex

>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Update commit message justification
>  * Add correct "default" handling
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 46 +++++++++++++------
>  1 file changed, 33 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index a4258127083d..24f532de6322 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2139,10 +2139,6 @@ static int amdgpu_discovery_set_display_ip_blocks(=
struct amdgpu_device *adev)
>                 return 0;
>         }
>
> -       if (!amdgpu_device_has_dc_support(adev))
> -               return 0;
> -
> -#if defined(CONFIG_DRM_AMD_DC)
>         if (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
>                 switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
>                 case IP_VERSION(1, 0, 0):
> @@ -2166,39 +2162,63 @@ static int amdgpu_discovery_set_display_ip_blocks=
(struct amdgpu_device *adev)
>                 case IP_VERSION(3, 5, 1):
>                 case IP_VERSION(3, 6, 0):
>                 case IP_VERSION(4, 1, 0):
> +                       if (!amdgpu_device_has_dc_support(adev)) {
> +                               dev_err(adev->dev,
> +                                       "DC support is required for dm ip=
 block(DCE_HWIP:0x%x)\n",
> +                                       amdgpu_ip_version(adev, DCE_HWIP,=
 0));
> +                               return -EINVAL;
> +                       }
> +
>                         /* TODO: Fix IP version. DC code expects version =
4.0.1 */
>                         if (adev->ip_versions[DCE_HWIP][0] =3D=3D IP_VERS=
ION(4, 1, 0))
>                                 adev->ip_versions[DCE_HWIP][0] =3D IP_VER=
SION(4, 0, 1);
>
> +#if defined(CONFIG_DRM_AMD_DC)
>                         if (amdgpu_sriov_vf(adev))
>                                 amdgpu_discovery_set_sriov_display(adev);
>                         else
>                                 amdgpu_device_ip_block_add(adev, &dm_ip_b=
lock);
>                         break;
> +#endif
>                 default:
> -                       dev_err(adev->dev,
> -                               "Failed to add dm ip block(DCE_HWIP:0x%x)=
\n",
> -                               amdgpu_ip_version(adev, DCE_HWIP, 0));
> -                       return -EINVAL;
> +                       if (amdgpu_device_has_dc_support(adev)) {
> +                               dev_err(adev->dev,
> +                                       "Failed to add dm ip block(DCE_HW=
IP:0x%x)\n",
> +                                       amdgpu_ip_version(adev, DCE_HWIP,=
 0));
> +                               return -EINVAL;
> +                       }
> +                       return 0;
>                 }
>         } else if (amdgpu_ip_version(adev, DCI_HWIP, 0)) {
>                 switch (amdgpu_ip_version(adev, DCI_HWIP, 0)) {
>                 case IP_VERSION(12, 0, 0):
>                 case IP_VERSION(12, 0, 1):
>                 case IP_VERSION(12, 1, 0):
> +
> +               if (!amdgpu_device_has_dc_support(adev)) {
> +                       dev_err(adev->dev,
> +                               "DC support is required for dm ip block(D=
CI_HWIP:0x%x)\n",
> +                               amdgpu_ip_version(adev, DCI_HWIP, 0));
> +                       return -EINVAL;
> +               }
> +
> +#if defined(CONFIG_DRM_AMD_DC)
>                         if (amdgpu_sriov_vf(adev))
>                                 amdgpu_discovery_set_sriov_display(adev);
>                         else
>                                 amdgpu_device_ip_block_add(adev, &dm_ip_b=
lock);
>                         break;
> +#endif
>                 default:
> -                       dev_err(adev->dev,
> -                               "Failed to add dm ip block(DCI_HWIP:0x%x)=
\n",
> -                               amdgpu_ip_version(adev, DCI_HWIP, 0));
> -                       return -EINVAL;
> +                       if (amdgpu_device_has_dc_support(adev)) {
> +                               dev_err(adev->dev,
> +                                       "Failed to add dm ip block(DCI_HW=
IP:0x%x)\n",
> +                                       amdgpu_ip_version(adev, DCI_HWIP,=
 0));
> +                               return -EINVAL;
> +                       }
> +                       return 0;
>                 }
>         }
> -#endif
>         return 0;
>  }
>
> --
> 2.48.1
>
