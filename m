Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20174D6CFA3
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 20:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FE4310E170;
	Thu, 22 Jan 2026 20:08:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EgMjj9en";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8B8410E170
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 20:08:06 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-123387e3151so121711c88.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 12:08:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769112486; cv=none;
 d=google.com; s=arc-20240605;
 b=H7RWZnMg8zK+F0PBhbPGe/nPOlX54Y1HgvvzGreZ7Abc4iCsPBajrKIKs0SnOB7sTa
 Gj+VTA2lgxTfVloYeAzcMjnUy8fFnGPrEww23ipehD2uOHiTJD8Sy+lwcBPjql6rl90I
 3E82jFiBebbg2uhl1cxypPZL/5dtwa3lcDD4n0zDvlBADNDGMd6HBdP3zabVNGXT0o+I
 9+v5Dz61tN+KT/Xzrrly0tfziNq7NEW2sret3xGgjkQ5ZBfG6hlcs2MkGCwkVIbow/3U
 PuznWI3HJcrJYgqxxd/Xq8A7mrBpzfkKJpGGub4wJY55i213+t9YgYkMdc8t8hM3tgfX
 E6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yyAmnNdRWvONhy6vsf3TP0Av5GZyroS7vTlji/KfZgA=;
 fh=eLETJQUWJWAkOM2sXDzFT8JBP8bLYFHao9rHC9tL2hQ=;
 b=dxOKMFAWZ5s21hC0UBATX0Awcx8Do7sKO/PAatO9uS4WEmATImQleAc0TI18NSCFns
 sbGVU+//ylgPyS30YXiLZEzq87CqUKGqo1t+jpDPZVNZmVOQ13PLcd74SxIeLPGBsfvO
 YbVL6c45xfvL62MC9nSl6Z+2D194iUqBuDT3qKBKqD+DkKxx6RigWEev1kC/uxl/CqFB
 //5UYHe4Rxsd67LcX5Fzf/7lN4pA64DCiyYHGryFldcADqzTc0rsZZ40EK24VSpSqKly
 q/r8J+HOuDAPBOKW0Cz3s3pa5sXqIhY8nOWvM5S6UqU0bJ76SMd0clKNLSaFTpNATHG8
 S1Dg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769112486; x=1769717286; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yyAmnNdRWvONhy6vsf3TP0Av5GZyroS7vTlji/KfZgA=;
 b=EgMjj9enLdu27W9lX4xSwxGHrMV32wtPfZXqN0kXjLDfifAQpQOLRy2rux3Yn824wv
 +tm5Ij0f0+QWA4pMdiawK7fRKPi8SSH+omvXqgatyL7Tzjhxf+K0J4qsFsFemFWOJCAx
 zSxfrN65fFnwUwNAR9/L5Q/p72Q7Dqch6JT5v2lKmbkUobO6lUwgyJeyXAs6e4buFSjb
 N9pcNMna926rS23SMSIB8grzYGnZNBotlIIZenXplvJfUT55JRKsNS/9vn/4X98xh3U9
 tTeH0TzagcF6cDpFDc4MlaaogBVeAMaLD8/yWOAU9PmcwRYgUlyTiQ/zrYiLH28Qw1XG
 3Jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769112486; x=1769717286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yyAmnNdRWvONhy6vsf3TP0Av5GZyroS7vTlji/KfZgA=;
 b=R2S2yUd2dWdpLR7UlpZ3kfJwgcblGhXQBzVOPnk79yjlGZwapv4TlbBDwrMU0uPEnf
 xEOhaONmiAl6Q808pCqitG9OnPDx9WbBGQkdJhYq70gXCa6VElihwBitfv4cnXEwp3ac
 OYDkoUQNkdrBd4mZyQRhYRHAn4plXG2vSZK+tOVn+qP/ryP7qpxkd/or5Hjy/59o/k1U
 MJ5QTcgrBoLX9854HSVaU8wMxHnPN0d9R5SH3x8+rUwKDEwbRjllT0V8Hl9gPr7K/0Rf
 M9BFAno7LdRPQJhoXh5RZLS5ixYQnKURCpZEtcQxJS1r3c5oymMD7e0IP/GT/CZyLs2g
 9X4w==
X-Gm-Message-State: AOJu0YwmQAXvixozcnezubHrYNX6KfV7k096GG/n0IJtwgS8eLMGtZ6k
 2lZ1J3zLBtUqTq9z++X6+n18pgvPh8C93Baag2qYq37cLxn4GSOL0sIAsjTxO3Lo/K53QkoWF9n
 87Wuyuwzn/yNZ07Z2CiA+AXh70y2fcEA=
X-Gm-Gg: AZuq6aLcKaLzWh6nQXhU08gfXiDBTIaTKsCsFBfgKE7tBGMh4+qusmf2SzGdx3qe4J/
 a0u3dPOIfZ9uqMpAPPGqkrdGZYx39XRwlhXcXnhV7eKQKG/xaXFdhN0ilim4blXkr7GPbwrZnDD
 4N5ZY7tjprcDpFm8UMwo8601DsRbBdYgIJNwv80AIytc23JLYVzG6FIWwK+uGFvN/fc1Pc2L1vU
 g2S49gGSwMHrN4YABRSoFXzTexed+8/1gYy9mGTp3eEDDXRNInhzJSHW9IZaxAG8CiUPRjo
X-Received: by 2002:a05:7022:2385:b0:123:2d38:929b with SMTP id
 a92af1059eb24-1247dc01168mr153429c88.6.1769112485766; Thu, 22 Jan 2026
 12:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
 <20260122085738.1542800-4-Jesse.Zhang@amd.com>
In-Reply-To: <20260122085738.1542800-4-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Jan 2026 15:07:52 -0500
X-Gm-Features: AZwV_QhiCQ9O79CJpRfBS9ocBiZR2mILnkAOtIuUAes2dYRQNqc0wfqykIAYPi4
Message-ID: <CADnq5_Mch58uOteE-0Hpj28zkLBS9_z=WLHv+jA6pjfixbH0dg@mail.gmail.com>
Subject: Re: [PATCH 4/9] drm/amd/amdgpu/gfx11: Add CU mask and priority
 support to GFX11 compute MQD update
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Thu, Jan 22, 2026 at 4:17=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> - Extend amdgpu_mqd_prop with CU mask fields and debug WA flags
> - Implement GFX11 CU mask mapping (WGP mode) and MQD setters for CU mask/=
priority
> - Integrate setters into gfx_v11_0_compute_mqd_update() to apply runtime =
changes
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h    |  4 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 82 ++++++++++++++++++++++++++
>  2 files changed, 86 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 64e69f0f9a02..246d74205b48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -809,6 +809,10 @@ struct amdgpu_mqd_prop {
>         uint64_t fence_address;
>         bool tmz_queue;
>         bool kernel_queue;
> +       uint32_t *cu_mask;
> +       uint32_t cu_mask_count;
> +       uint32_t cu_flags;
> +       bool is_user_cu_masked;
>  };
>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index a47c91d33846..d807d77c56b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4238,6 +4238,87 @@ static int gfx_v11_0_cp_async_gfx_ring_resume(stru=
ct amdgpu_device *adev)
>         return gfx_v11_0_cp_gfx_start(adev);
>  }
>
> +static void gfx_v11_0_mqd_symmetrically_map_cu_mask(struct amdgpu_device=
 *adev,
> +                                                   const uint32_t *cu_ma=
sk,
> +                                                   uint32_t cu_mask_coun=
t,
> +                                                   uint32_t *se_mask)

This looks generic.  We could probably make this
amdgpu_gfx_mqd_symmetrically_map_cu_mask() and use it for both gfx11
and 12.

Alex

> +{
> +       struct amdgpu_cu_info *cu_info =3D &adev->gfx.cu_info;
> +       struct amdgpu_gfx_config *gfx_info =3D &adev->gfx.config;
> +       uint32_t cu_per_sh[8][4] =3D {0};
> +       int i, se, sh, cu, cu_bitmap_sh_mul;
> +       int xcc_inst =3D ffs(adev->gfx.xcc_mask) - 1;
> +       int cu_inc =3D 2; /* WGP mode */
> +       int num_xcc, inc, inst =3D 0;
> +       uint32_t en_mask =3D 3;
> +
> +       if (xcc_inst < 0)
> +               xcc_inst =3D 0;
> +
> +       num_xcc =3D hweight16(adev->gfx.xcc_mask);
> +       if (!num_xcc)
> +               num_xcc =3D 1;
> +
> +       inc =3D cu_inc * num_xcc;
> +
> +       cu_bitmap_sh_mul =3D 2;
> +
> +       for (se =3D 0; se < gfx_info->max_shader_engines; se++)
> +               for (sh =3D 0; sh < gfx_info->max_sh_per_se; sh++)
> +                       cu_per_sh[se][sh] =3D hweight32(
> +                               cu_info->bitmap[xcc_inst][se % 4][sh + (s=
e / 4) *
> +                               cu_bitmap_sh_mul]);
> +
> +       for (i =3D 0; i < gfx_info->max_shader_engines; i++)
> +               se_mask[i] =3D 0;
> +
> +       i =3D inst;
> +       for (cu =3D 0; cu < 16; cu +=3D cu_inc) {
> +               for (sh =3D 0; sh < gfx_info->max_sh_per_se; sh++) {
> +                       for (se =3D 0; se < gfx_info->max_shader_engines;=
 se++) {
> +                               if (cu_per_sh[se][sh] > cu) {
> +                                       if ((i / 32) < cu_mask_count && (=
cu_mask[i / 32] & (1 << (i % 32))))
> +                                               se_mask[se] |=3D en_mask =
<< (cu + sh * 16);
> +                                       i +=3D inc;
> +                                       if (i >=3D cu_mask_count * 32)
> +                                               return;
> +                               }
> +                       }
> +               }
> +       }
> +}
> +
> +static void gfx_v11_0_compute_mqd_set_cu_mask(struct amdgpu_device *adev=
,
> +                                             struct v11_compute_mqd *mqd=
,
> +                                             struct amdgpu_mqd_prop *pro=
p)
> +{
> +       uint32_t se_mask[8] =3D {0};
> +       uint32_t wa_mask;
> +       bool has_wa_flag =3D prop->cu_flags & (AMDGPU_UPDATE_FLAG_DBG_WA_=
ENABLE |
> +                                         AMDGPU_UPDATE_FLAG_DBG_WA_DISAB=
LE);
> +
> +       if (!has_wa_flag && (!prop->cu_mask || !prop->cu_mask_count))
> +               return;
> +
> +       if (has_wa_flag) {
> +               wa_mask =3D (prop->cu_flags & AMDGPU_UPDATE_FLAG_DBG_WA_E=
NABLE) ?
> +                         0xffff : 0xffffffff;
> +               mqd->compute_static_thread_mgmt_se0 =3D wa_mask;
> +               mqd->compute_static_thread_mgmt_se1 =3D wa_mask;
> +               mqd->compute_static_thread_mgmt_se2 =3D wa_mask;
> +               mqd->compute_static_thread_mgmt_se3 =3D wa_mask;
> +               return;
> +       }
> +
> +       gfx_v11_0_mqd_symmetrically_map_cu_mask(adev, prop->cu_mask,
> +                                               prop->cu_mask_count, se_m=
ask);
> +
> +       mqd->compute_static_thread_mgmt_se0 =3D se_mask[0];
> +       mqd->compute_static_thread_mgmt_se1 =3D se_mask[1];
> +       mqd->compute_static_thread_mgmt_se2 =3D se_mask[2];
> +       mqd->compute_static_thread_mgmt_se3 =3D se_mask[3];
> +}
> +
>  /**
>   * gfx_v11_0_compute_update_queue - Update runtime-configurable queue pa=
rameters
>   * @adev: amdgpu device pointer
> @@ -4278,6 +4359,7 @@ static int gfx_v11_0_compute_mqd_update(struct amdg=
pu_device *adev, void *m,
>         mqd->cp_hqd_queue_priority =3D prop->hqd_queue_priority;
>
>         mqd->cp_hqd_active =3D prop->hqd_active;
> +       gfx_v11_0_compute_mqd_set_cu_mask(adev, mqd, prop);
>
>         return 0;
>  }
> --
> 2.49.0
>
