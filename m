Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739D1C4828F
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Feb 2024 17:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0462010EF90;
	Fri,  2 Feb 2024 17:00:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ofiz5IQQ";
	dkim-atps=neutral
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com
 [209.85.160.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C09110EF90
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Feb 2024 17:00:57 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id
 586e51a60fabf-204f50f305cso1387937fac.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Feb 2024 09:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706893256; x=1707498056; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ebUWWI4+NXeYWoZA6koh5m3TIslHS5C1wTkfH4lQqL0=;
 b=Ofiz5IQQ1VszO4el1VAoT1Fkj4cM/JuEVlhMQp9BPc5WOb16RHORmYg58YqbrDyFQo
 BDV/Tqqg8Khp70Agb3o3Rtoib0nDWcg+4fP+9q5GJks6jQ5K5wwa0ViR0HRdEAM/sS4e
 PecdvBn9kOcIX5obvsdmKT3+qAZCiNR5T+jL6WSVMo5JzEJWkrdDPOciKr+rz9c3PSsa
 9I9EMxnQ5yKzTNZpe+YgmQFX+IWr/27i5IGb70OjYtFw07iTy2Y2f51cOS5U6YqD1i3/
 FGWKLg4qOkz9AfbzRHu0NbYc7/8JcXxHJzNvgUeM/irFC3Sn6JYRjiYWIP1D3PCwRBeV
 MjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706893256; x=1707498056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ebUWWI4+NXeYWoZA6koh5m3TIslHS5C1wTkfH4lQqL0=;
 b=SKm7cDwq1dwPaw4Mmh7b6XG7AE5Ru+uKf/yZpgeEvz6v8O4b130gVf5I+2rAOR6Tts
 /vdgn4yVySfhw9RrSCAvt6czEtdggYtwQ8+wViQVkG8QgcpbwPBhmEXGI8/iNqFklRLH
 WXyVhwdHq+oWtiiu+YqPULhQObvJRnSvxb4rtSz1JfDf9eJRp6EesK+pSILZTuTy1B8T
 tOEe5Ct1jCL+vC2fkVxdbwOJAN29jRNVPzGke0goiJRGeEg31IEO88wtqAsRHePv4wF/
 go2SkL7WagN3Yh7VCULDOGGiqrME2u+KynU6uDEb6sCmgd9wRTtlNEDAoaUIZuAShNDM
 j9JA==
X-Gm-Message-State: AOJu0YzswinDuD6Zh9swMNKMyVJG6zYETnoIAi1U3X1PoHpypE2cFeKZ
 MqQM7sYjDVv/yPqp4NcvXS1qbesWHK2VQCD15Del0WN6uJd8kcQc4U5G/++6NJVysO72D3zS69n
 eZVxjkqeVPnVk4T8riUei0D80yvw=
X-Google-Smtp-Source: AGHT+IG7Ia/xb3jen5JZXXE0D/KdeIUSARgfrPcFPf95oVwldbC4sWXB10nSZMgZoLb1jo7jZiQs78KbZPXy9hnvMNc=
X-Received: by 2002:a05:6871:4e41:b0:219:1a4e:67cf with SMTP id
 uj1-20020a0568714e4100b002191a4e67cfmr280557oab.13.1706893255585; Fri, 02 Feb
 2024 09:00:55 -0800 (PST)
MIME-Version: 1.0
References: <20240202154635.1643762-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240202154635.1643762-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 2 Feb 2024 12:00:44 -0500
Message-ID: <CADnq5_Phbum-OsUa8MQF7e4+dgFksKWKSjhBnkM3T1EVYdNeMg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: Fix potential out-of-bounds access in
 'amdgpu_discovery_reg_base_init()'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Fri, Feb 2, 2024 at 10:53=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> The issue arises when the array 'adev->vcn.vcn_config' is accessed
> before checking if the index 'adev->vcn.num_vcn_inst' is within the
> bounds of the array.
>
> The fix involves moving the bounds check before the array access. This
> ensures that 'adev->vcn.num_vcn_inst' is within the bounds of the array
> before it is used as an index.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1289 amdgpu_discovery_reg_b=
ase_init() error: testing array offset 'adev->vcn.num_vcn_inst' after use.
>
> Fixes: aaf1090a6cb6 ("drm/amdgpu: Add instance mask for VCN and JPEG")

This tag is not correct.  I think it's actually:
Fixes: a0ccc717c4ab ("drm/amdgpu/discovery: validate VCN and SDMA instances=
")

With that fixed, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v3:
>  - Added fixes tag.
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index ef800590c1ab..93c84a1c1d3e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1282,11 +1282,10 @@ static int amdgpu_discovery_reg_base_init(struct =
amdgpu_device *adev)
>                                  *     0b10 : encode is disabled
>                                  *     0b01 : decode is disabled
>                                  */
> -                               adev->vcn.vcn_config[adev->vcn.num_vcn_in=
st] =3D
> -                                       ip->revision & 0xc0;
> -                               ip->revision &=3D ~0xc0;
>                                 if (adev->vcn.num_vcn_inst <
>                                     AMDGPU_MAX_VCN_INSTANCES) {
> +                                       adev->vcn.vcn_config[adev->vcn.nu=
m_vcn_inst] =3D
> +                                               ip->revision & 0xc0;
>                                         adev->vcn.num_vcn_inst++;
>                                         adev->vcn.inst_mask |=3D
>                                                 (1U << ip->instance_numbe=
r);
> @@ -1297,6 +1296,7 @@ static int amdgpu_discovery_reg_base_init(struct am=
dgpu_device *adev)
>                                                 adev->vcn.num_vcn_inst + =
1,
>                                                 AMDGPU_MAX_VCN_INSTANCES)=
;
>                                 }
> +                               ip->revision &=3D ~0xc0;
>                         }
>                         if (le16_to_cpu(ip->hw_id) =3D=3D SDMA0_HWID ||
>                             le16_to_cpu(ip->hw_id) =3D=3D SDMA1_HWID ||
> --
> 2.34.1
>
