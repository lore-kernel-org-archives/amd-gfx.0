Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F47C98314
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 12:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F0CA10E395;
	Thu, 24 Sep 2026 12:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kJEpZnC0";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E59D10E395
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 12:55:18 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-33e4e75342aso87722eec.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 05:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790254518; cv=none;
 d=google.com; s=arc-20260327;
 b=g7nKMcXMoAKUw8ark9BQFSUCN+JzttVf5qxbC7lrUniW7oDWtfDrfMtVaZP3L1Df+o
 Z94gKC8rs8aBoBlcrkrwbJBlyRho7lqr+DOYtPVNm1Lof83W8DuClefk2daxr2oq+wbE
 PiUXcF760RpVdawhDi+omkbJyDlHDR17owmfHZhCEQ38lSQdASNJlx+ZTxDthivF8/2E
 86mDhGkHzJ4u3uWd/y1/NyseLhSdhYt4XXV2KsSdYxMtXg782JPfs8coYUGs4tFkv64J
 tV62ev+DCS4Qva0NXj0uGr6DY0CzpNj5fVnprJAENY4P8mBcQ1Nx4F50LJkGSdEQdCvU
 XQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6rCToHssiWETE8fAeMLU9/8ZLT7uDkl37EA8Ng9jTuk=;
 fh=WH2OxmH5V70+t7ZvgJjiGXhIYY3RL14Y8H+G2WxDujE=;
 b=VOA6Sm0mfQuKkan2a2VLOAW2VLLlBtMZbpdLG8lCJYM0GyBc5VNNh2JzV3yh4FOdFk
 04vfBPz/cGAig2e/k4MPHo1CBXJK9mqDReUvBQXEbj3Y6/or3MDUzAk+yr8tmI+HpLXe
 Uj5JxoIjD3TAnaq8C3JV++3SDkA7lEIRN7SPcANSG7Ih7MUAgDckWfn08/2EpzRBTf3b
 6XAoi1jgYZLsA8k7p35gSLVRpSEcsovVqK7JP5gXPJVKy8h/H4N8e1yq2ddytUL8xNOb
 GQhzcnXYdpXD04CE8DImdYSsZl6nOppx6M11PJQO40OuwYnpt2iGmNFKt25Nw+3AlSyC
 ZJGw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790254518; x=1790859318; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6rCToHssiWETE8fAeMLU9/8ZLT7uDkl37EA8Ng9jTuk=;
 b=kJEpZnC0gnpJ3ZfY3qBq1f0dsepi+/86XCRqXOSHK7Nnd4GSCNYerbLjtJxlTUryJo
 s8Ww4PLeyw36YBUxNESNECorGOB+2wj4g53s1fNuygwsMsOv/mKSvSmwtvenyBRnZ4fw
 sRk08jVKGe/eH0KyyeDLz52j1lMZ/AqrTGmuvN+yhrc82nR6lklDJqwEI00gQLi+mb4i
 F++QQYokbv2Y6HUPtjmihzWApLXCjovyrL6Og9CE9yNz438XfCr+qeRrJW8ZbBfZ8Gmu
 3a9EFk69pWZNZwP1OKOQ2LhmCIW3RperUVhGJ8OkQ4ltfbGP+na6jTK/VjJ+atBheL3q
 rK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790254518; x=1790859318;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6rCToHssiWETE8fAeMLU9/8ZLT7uDkl37EA8Ng9jTuk=;
 b=IuWeiM2wfdJkC0b1NaF+PP4yJwV34BA+KKveUYmUI8tFa6+yulBx6bRtCqtG9bkfE2
 4/6tyO1ZF6fxc1+jir3nwb3S4/0OqT7L+0TeYiVilM8RFbqDAJ6kj2cfWhko3Py6qRTz
 bKHmUFguZQd6rDOivznbNzYsybh7MDilSEZk2uopnmoy/WSVXF6xcckyXw9RGpGYLKu6
 2eF0IRYqMp9xyaO2MBpJgeCAQaQhqiYbgu+y9D7/0le1r0cuUC9IWjJVUYHbZ1S+mzUO
 MkniKBLNA2NPjvXjLeOcpRXPhAG7uKC4yo8SA8EiYMLpMzrEdiC/9fQzS8ePhOpqurQ4
 +ItA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLPorOi9dpK8BB4ZEKMBCCX1f3we5ByHY+I0rgKzvZpzpXMNWkQrbYRCfmi61+i13cVNX6wmFd@lists.freedesktop.org
X-Gm-Message-State: AFuF++kx9UYuW2k6UpbfkuyaN47+1PynoiWhe9aDOazOOQLVI3QHEwEu
 uGDIdbHfz54GoCmBrUHdj8mW2aGm8l8KElhUVyV/nAPRbu3aDjb5KEAVaGlQeuC1coiTxCTVmBc
 +JVHy6jNObjFWQC3I7jlLyfaugIHl0gI=
X-Gm-Gg: AYBFou3M52s0hWI+QB17uXkKNKFHFoXAC1wPZQLNXaRWQNuWzaEhLusdHfLPlAE291S
 qCXpGvoQMILenS7Rp4QwcGnBzBGbgkKqOb3m4tFgHDno1Xtep0z1L8WfkO8nyiBlk5S6LkHOcOX
 W2L3geN7PuriOBLyhVc1jY/xfGAP1hYCwA2r8bM7FoRhjgdlniR7Dmw4tNM6D6ttjHzxGBqihEx
 NjovZYljQ9Uk4ux9MgByECy43DenWrvtVtpBdZPn/opzM9XFxE78agFsp9PaLKCFwIKqHbb/zXt
 lLS+aeSTeb3CL0zVhDd9pI0rZrKW3Q57FbpuDs1W6ObcCLKh03zt19Dzokh31O+Yumim8TtTALl
 TN+DY9GNJum4XJ9guMmSe8xG474tvOgomP4RbMsI4Mw==
X-Received: by 2002:a05:701b:450c:20b0:144:ff51:2d73 with SMTP id
 a92af1059eb24-14503f1814fmr2776445c88.2.1790254517596; Thu, 24 Sep 2026
 05:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260924124319.1895-1-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20260924124319.1895-1-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Sep 2026 08:55:06 -0400
X-Gm-Features: AclHuK8rawtFh8RIfYGUl6NWaHxeKlnzIhQDBr80jpvjqrvakm50HhNAyVvXVcE
Message-ID: <CADnq5_MFzY4EQBeDQcR+Ca9y5GXXseKbuKyLgvu_wcmpHLaPaw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amdgpu: implement workaround for sdma dcc
 corruption
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Thu, Sep 24, 2026 at 8:44=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> For unknown reasons, on gfx12 using multiple entities can causes
> random corruption of BOs with DCC.
> This workaround seems to prevent the issue until the root cause
> is understood and fixed.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5663
> Fixes: 3a6f6eeb3db5 ("drm/amdgpu: give ttm entities access to all the sdm=
a scheds")
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 3d620ec2937f..a826e091ea58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2392,6 +2392,11 @@ void amdgpu_ttm_enable_buffer_funcs(struct amdgpu_=
device *adev)
>
>         num_clear_entities =3D MIN(adev->mman.num_buffer_funcs_scheds, TT=
M_NUM_MOVE_FENCES);
>         num_move_entities =3D MIN(adev->mman.num_buffer_funcs_scheds, TTM=
_NUM_MOVE_FENCES);
> +        /* TODO: workaround for DCC corruption when moving BOs from mult=
iple queues at
> +         * the same time: use a single queue until the root cause is ide=
ntified and fixed.
> +         */
> +       if (IP_VERSION_MAJ(amdgpu_ip_version(adev, SDMA0_HWIP, 0)) =3D=3D=
 7)

Probably just limit this to 7.0.0 and 7.0.1.  sdma 7.1 doesn't have
DCC.  WIth that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex

> +               num_move_entities =3D 1;
>
>         adev->mman.clear_entities =3D kcalloc(num_clear_entities,
>                                                 sizeof(struct amdgpu_ttm_=
buffer_entity),
> --
> 2.43.0
>
