Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5F0C02180
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 17:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3429510E22A;
	Mon, 13 Jan 2025 17:34:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VJI+agHl";
	dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02A1610E22A
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 17:34:52 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2f45526dea0so1067035a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 09:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736789692; x=1737394492; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u4VD+g6YAyls/86uB4E50awY38MCvsuold7xQ0/Q64U=;
 b=VJI+agHl+6P4Y0Fnzh8rY8ghq3WTFEUfDsk9dJUsFUj6xU9YkPrbsyIn4ao+oj1JIv
 hWD0x8Rdg6NSWkhVZpWl3mI3fuHLpIHC/KT8wP6tj13PtRlQrY1KgOCvsqekrc+9HkAo
 PxapExWw2eu+MuaYK2kFnnwTzB0+ZY4Zt/ADl89AQ26hYiwL8WQe9PCo411o9UhAYGvJ
 G3/1FIkFwB2qVhF+aRZXHR+4d7ZSvdyvP1ADlboQ/hhKtLBt4WQ81oJ9c9ZecSI5Nqb8
 tL6kCUiQxU2Hk0+XuAikeugvwTlb2tfUP7AYbdue2te6xzcgOGh5eEcRqKHQPe2BiV8Z
 CFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736789692; x=1737394492;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u4VD+g6YAyls/86uB4E50awY38MCvsuold7xQ0/Q64U=;
 b=sFJTjz+wzpZWYIXgzrY4tFraCld4iXIeAY2yIQbs85qZHVwhEEtBlQ6S3bqdDuHfGD
 c0AdPDyMdAA0YBjy586fc0V9Y7eqWRHrZPH6pVGTANrKJZ4lHatkmQakf1U6jkfkbaqB
 HvnEcvZ4uysxsdlxDXw7rl450Lbn1KB7GT40agYCawV43QsezKpZoAIHNHb56J7IK3ef
 X1SNOwKOF+udz6mc/0YVr86Q7KZEvxd0CU2ngwo3+UENha3G0M6kgCHlpyXJedu3Yxq5
 a98GfbNqPrq1drxZECilj5AXLahLgOm+MqBCwQrlA1G9dg2gyaTejvHRhrilBoEAaMlN
 6m7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkclkQhfbrckJphvVZ0qUCZXEhX4RdzdacZItsycHE5pDR0Kll25qS4hkj4rFMv7jntKN7a9ZO@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzleL9WlnesKFTcTgOGOQPWEiK3T4CMNcdZ6bioBDfpTJz7rdma
 kdlSmYT0HjoS2LOKN59vfz8JALaSfr+Gov4KGoaLwDzfzkiH5F75JjRhbMjdwB+rreTkmaUMH1d
 ed5sWI3M6GhiK/F9C0A98pJ/n+tpIiQ==
X-Gm-Gg: ASbGncu4+deao9ASQpEv+lUdl4DAtUhZIm2FHZYLW1Q43dvme8VC5W02wvcARpeGj/8
 912ao6piSt9xLy5mgwnPDCnqEHAd97kGVX5EzTw==
X-Google-Smtp-Source: AGHT+IELgMJrX6s8C4EAtlhJ9PBpbghOWb7ZRBBO2v72wIc0nYxy3Qissn+AcAjavj28fjodZMJzQMZNebOzkjMXLtE=
X-Received: by 2002:a17:90b:2c8c:b0:2ee:b665:12ce with SMTP id
 98e67ed59e1d1-2f548f05913mr12270768a91.1.1736789692474; Mon, 13 Jan 2025
 09:34:52 -0800 (PST)
MIME-Version: 1.0
References: <20250113172237.472236-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250113172237.472236-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jan 2025 12:34:41 -0500
X-Gm-Features: AbW1kvZ-citoVmPvujMe1Uo58rWyubP3V4GzaNFkZ8T9Z0z1MMwXYDPfHG3y7SU
Message-ID: <CADnq5_Mk_0WG_8YW2zp3+xOkAVaJTkSooKGGXjBkoCeiQVVp3g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx12: Add Cleaner Shader Support for GFX12.0
 GPUs
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Mon, Jan 13, 2025 at 12:32=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This commit enables the cleaner shader feature for GFX12.0 and GFX12.0.1
> GPUs. The cleaner shader is important for clearing GPU resources such as
> Local Data Share (LDS), Vector General Purpose Registers (VGPRs), and
> Scalar General Purpose Registers (SGPRs) between workloads.
>
> - This feature ensures that GPU resources are reset between workloads,
>   preventing data leaks and ensuring accurate computation.
>
> By enabling the cleaner shader, this update enhances the security and
> reliability of GPU operations on GFX12.0 hardware.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 69941442f00b..fc75af08a7fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1387,6 +1387,14 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>         }
>
>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +       case IP_VERSION(12, 0, 0):
> +       case IP_VERSION(12, 0, 1):
> +               if (adev->gfx.me_fw_version  >=3D 2480 &&
> +                   adev->gfx.pfp_fw_version >=3D 2530 &&
> +                   adev->gfx.mec_fw_version >=3D 2680 &&
> +                   adev->mes.fw_version[0] >=3D 100)
> +                       adev->gfx.enable_cleaner_shader =3D true;
> +               break;
>         default:
>                 adev->gfx.enable_cleaner_shader =3D false;
>                 break;
> --
> 2.34.1
>
