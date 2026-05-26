Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5085DCD5BC8
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 15:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA73810E1C3;
	Tue, 26 May 2026 15:04:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sbzhrdxn";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9928810E1C3
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 15:04:48 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2f5ae07e2b5so881710eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 08:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779807888; cv=none;
 d=google.com; s=arc-20240605;
 b=Mg3u+r0wKqVEqco/4qlT/dTd8I2sVmm71VNtynvXCxA8/MSzC1FkAaJLXaToZZPZvD
 Ui6c4fnCbpHoiT+y3UD9fUFn3mz1AkUKXxsF/Lkq0xiDrW0y0CWl8Fmr1NJ9EvpL3XSK
 eam8TszAmHeFPJIdngcyJiwYmxra/A3izF6UiMXNfXNQMaXJCbx2S/yeURmv3Ucx8tuY
 hoEk/dNiBwwAqXjmUB0TbamMNDLayVJtCXdwTBcZJkLZ/ql9AW0+5JQrSWFomy1rylWm
 xBOKmqgF7kUMJRj0Me3Ecf3LS1SSJ8Fr6E7DueC3qU0pIqJj3t4QV7AMyGsg1XdAUeRv
 lvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LRV46UQ5JJTLYZr24gSeEgTFm1RWBnAQRM5kpkotgFU=;
 fh=kuXXPNLpbgu+QgSnwjBWFh7Uwlf7nGLz+J8cBaz/V84=;
 b=NKbmvTtTxYwfJNtdIaEFKqXfM5AJwIpyMi6nItUgREGaLL94kTC5O+tW3vHMOhZadc
 iO+OGAZzNmHcFzd2xdwySZP7FgoZszNrzQ+m/A4awIJRewDgItXm61z2s9eDRJT5YqlA
 Q1dhNPUbjxsEnI6eKq81e7fLPq5qjkLwPdS7yK6Tw+DGAJ8ppMWgRpyLNX8zwhCJwadE
 /uVOU42uMI4yqALLEvmyApz+pOgkCUghlp6qa0/rT/tWqdhy4oMJGbRN0+yIOOEQ81Hb
 YIO+oRUyk4gctg7VRXJN8+/vPNvipPqfWgsqJ4iRJ8prfechGFesOzCvMxm1TecmCGwU
 SWmA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779807888; x=1780412688; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LRV46UQ5JJTLYZr24gSeEgTFm1RWBnAQRM5kpkotgFU=;
 b=SbzhrdxnJUFhjhqDhEWbEt6HqXtDdO7Cwye9GLr7qMtG62P27/tNz4gktpJiA/JGTX
 c5eeXPXjORqlVINgPh2Xzw51PartnN+Bd5yqQmfL4bcthLTVuLXHxX4Kgt3bQFb0i/y4
 DWEexIYZ//ScW3MUV9hSdjuNBsQ/rzR2t/5JiQj83u4zttAh2xCwPID+b82cl3HAi5BY
 2prgEDOJuEqRF/FVUtGCh/S4AOdNinP3ompZLe5XM0fjsDmkaQpHy0tU4AlN+6GrOeJn
 t7RCvQ1ioQuRWz2D2FoATrYN5gF1XCPtymkppOhVxOvdI1WLcD0M4JyTC17zHa8630N5
 BTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807888; x=1780412688;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LRV46UQ5JJTLYZr24gSeEgTFm1RWBnAQRM5kpkotgFU=;
 b=JSOQLW8CwA/VMGlz+Lk21/JCay0uonrx8kHSDi3rNlrB15t40KheAAhpqO8Y5HAhUq
 i11nc7ENYpJXeuI/Rh1fyiVL1H1cZH5Y9TJR0Pvq9znRNCusnMjCTGvYZqBZ6S1v8YFQ
 aflPRsynubQ4QyjdrK+rGLbPfl3bqLsPKFQdCmPmq+6Ifi6+59HA7Dp8s+gPjSUqt/M+
 V5hNLr0yBqdAGO/q+zCQM3MSBojQo4woUHTxDXzPIEuuORr4Wm4t1IEDW+brNFpfGCOc
 423UGKoqTy2PDosA+n32Kf/HhcLfEAGq3W+F4tfCLFRrKM9s/RdxJueCw/sikq2jZzOL
 hj4A==
X-Gm-Message-State: AOJu0YxqDwJZHT5l4+9fIDguGznzzU+amap/HADy9wENsqcEMhHOPZ4n
 glwr7D2o6oExpuFRJbRiFbQjr4d2wwcGtShSfFn2e6rVX/jf9Bz3StMr3iZ+yEYQetihlzYWvW9
 FxWRKQpiydFf9qhD3zKv3px/b8cOLG3qnAg==
X-Gm-Gg: Acq92OHrf4O9IJXYzFdO0x8iI/UQbJxFHPPzR7vcbCNjGNXyXIfy7fSH67ptFHIp1rQ
 lNPRlszq/SwMO1qFatC5dxWoisSFRziLzt2cOf/LOtWQnR1PMt5h0OYoee0+KjdygMQvjWCAlSf
 NgH7gAx1xGoWw2rjlsM0YGhmxOyoRvf2TwnV5UuYYCsKIHUN/GyQoEyP0KQ/qvU4bwdNXT5DMBD
 sCFxtAYiK2gkR2v9uf0SNNrM8XqAjW4bpNLUB/vb2n7adU7f7/OD1QMAh0gsJCvL7p5mGXCIRTo
 NrBhqOMnteQNuTp7w+AVodOvp6FX7aW3AWx50pxudb2Cdxj4cMEGR1iy18w/sx/y2g1gqw==
X-Received: by 2002:a05:7022:68a3:b0:135:1b09:db43 with SMTP id
 a92af1059eb24-1365fb651b4mr3219321c88.6.1779807887828; Tue, 26 May 2026
 08:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260526143219.609033-1-chih-wei.chien@amd.com>
 <20260526143219.609033-4-chih-wei.chien@amd.com>
In-Reply-To: <20260526143219.609033-4-chih-wei.chien@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 May 2026 11:04:35 -0400
X-Gm-Features: AVHnY4KzyHsSrN0bYxL3a8VWghYV5hKaWeJd7njgWtQ93x4E8rP4w-0o-huL82U
Message-ID: <CADnq5_Non-70-vYpENW75QfQUm3Pwoh3rbrq_6sD-UoGF3=8-w@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/vpe: add vpe v2.2.0 support
To: Caden Chien <chih-wei.chien@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, 
 Alexander.Deucher@amd.com, Solomon.Chiu@amd.com, Peyton.Lee@amd.com, 
 HaoPing.Liu@amd.com, Yu.Wang4@amd.com
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

On Tue, May 26, 2026 at 10:40=E2=80=AFAM Caden Chien <chih-wei.chien@amd.co=
m> wrote:
>
> This initializes VPE IP version 2.2.0
>
> Signed-off-by: Caden Chien <chih-wei.chien@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       | 1 +
>  drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c         | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 8e3b6a4050e9..9d95a4f915f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2740,6 +2740,7 @@ static int amdgpu_discovery_set_vpe_ip_blocks(struc=
t amdgpu_device *adev)
>                 amdgpu_device_ip_block_add(adev, &vpe_v6_1_ip_block);
>                 break;
>         case IP_VERSION(2, 0, 0):
> +       case IP_VERSION(2, 2, 0):
>                 amdgpu_device_ip_block_add(adev, &vpe_v2_0_ip_block);
>                 break;
>         default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vpe.c
> index 601420491477..7bf74ff93fbd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -312,6 +312,7 @@ static int vpe_early_init(struct amdgpu_ip_block *ip_=
block)
>                 vpe->collaborate_mode =3D true;
>                 break;
>         case IP_VERSION(2, 0, 0):
> +       case IP_VERSION(2, 2, 0):
>                 vpe_v2_0_set_funcs(vpe);
>                 break;
>         default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vpe_v2_0.c
> index 0d91e01fbf3a..c92c5fc59aeb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
> @@ -31,6 +31,7 @@
>  #include "vpe/vpe_2_0_0_sh_mask.h"
>
>  MODULE_FIRMWARE("amdgpu/vpe_2_0_0.bin");
> +MODULE_FIRMWARE("amdgpu/vpe_2_2_0.bin");
>
>  #define VPE_THREAD1_UCODE_OFFSET       0x8000
>
> --
> 2.53.0
>
