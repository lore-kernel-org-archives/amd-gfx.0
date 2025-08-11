Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01273C87FDB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 13:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC62E10E10E;
	Mon, 11 Aug 2025 13:46:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K8OZtYCH";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82C6A10E10E
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 13:46:53 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b422499c9deso221179a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 06:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754920013; x=1755524813; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nxyFdtUpDWoHsuWZXWtqzWyyBAbBtUUZyqOvG2kFW64=;
 b=K8OZtYCHgt0wDpR+jpfhHsAOqDOu1tceWs2jqTcVxwnr8wjPOqi4b8pTLhte2xmklw
 ickTpvOOgH0SeEPUd1aEjFpKYtK39OtE+1SpijjC6Xug7lGScEAsmt81CBHXq81MXvBC
 8YsNEb1V5e5jHLgyBW4Wbg56W/tZV3fhLwzXDvwi2zLuq9kA0U59+orVwAyVoTkIbcwk
 KNLCFn2MFIcLpbfLcxXXp3irC1xin9CAIlFA8bEDgRJVR7Vj6evDpBJQoTV9mEX/oq2L
 2dD4ulbxYEuiKvrdLurHqhuwlTHchtHW7O8m7X1Zb9GV/QRjQPt5qAdxtOsDUWXvyI2X
 Zbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754920013; x=1755524813;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nxyFdtUpDWoHsuWZXWtqzWyyBAbBtUUZyqOvG2kFW64=;
 b=fJ/WTuds72UBF1ptnr7GkUsiHl2wHRgz8accK/JT27HuQCYG6KNWXSQd+CPQVVjAGG
 1pNf83vcM9jWMKFox757qleUfCFs4ZFKjKmFPY7onlRA72aL0SMdGLr0hc2IGN5Zorum
 nVnJzC0y0PCVwIcjSRN93eWtvcS1vU6A8bgHfL/beUFWKwFIPaz6YkxlW6p9UT5dZXFQ
 YCP+0g2F1YOsEeFITQe0xOvfgjvhDb3cM5acEw0ajQ3c6wrq68oiqWqnN8//ZYKVlzd+
 jKAU6HJE2LU2TyYTS8khna/Gh05afdeioTLXO1nfE6HHACyeiu7/bdG4Eenps6/Vsi8L
 0TUw==
X-Gm-Message-State: AOJu0Yx6Rfwqopsz6sz9fML25WxxKGu8EHZA+pUlLD18bZBaIiMLLyeC
 lRIIxKwXozUyMU0Xfn9tT4iFkVreC/oTgmF0TE3zKNdmt5G5tdhNPj5nZ7Zp9s/o2i9+p4Tfx0K
 frFDsO7Dz01U3Gy9SrrVUNCJkYctdn+0=
X-Gm-Gg: ASbGnct8MjssUiWCysP8JImhPNBZj9kRvfraokNHTK6lL5HOohriB4h+d0LPkn94tj3
 40xkokIa/pCayeC0/fvSePtDOoiaB2r/4RiSXw3Rjmq79zF4YtDd64rN+dd/QYaxHgXQ8eOE72w
 NgvWUx4zi7iD4a4SjzZxF/W8QlsFS3xvhG+nMhNQ3OSsRS0lzTZuaPZjxDZuxO5zcDF9mxYSPQ6
 V4P4Yc=
X-Google-Smtp-Source: AGHT+IGjUFJGdlN4C1ptJ9DysdB5cZM5YlzgiWS3xZ67cOgcW+R1ZKN4Y3KL8gG7NqfdiYL+oPWr7hCw9d+ckU3R51Q=
X-Received: by 2002:a17:902:f548:b0:240:79df:48b0 with SMTP id
 d9443c01a7336-242d35721f7mr60328585ad.0.1754920012793; Mon, 11 Aug 2025
 06:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250811010437.1895121-1-Jesse.Zhang@amd.com>
 <20250811010437.1895121-2-Jesse.Zhang@amd.com>
In-Reply-To: <20250811010437.1895121-2-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Aug 2025 09:46:41 -0400
X-Gm-Features: Ac12FXyU4OcFbmXQPNlKhCU8G1hAndfDL-Xd2VMupd7mXD9wNNdNYkVpBIu4RcU
Message-ID: <CADnq5_Oc00VofksgcmpERTda_B-b2wG5gLvqrR-e7Vn6BZsDDw@mail.gmail.com>
Subject: Re: [v2 2/2] drm/amd/vcn: Add late_init callback for VCN v4.0.3 reset
 handling
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Ruili Ji <ruiliji2@amd.com>
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

On Sun, Aug 10, 2025 at 9:05=E2=80=AFPM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> From: Ruili Ji <ruiliji2@amd.com>
>
> This change reorganizes VCN reset capability detection by:
>
> 1. Moving reset mask configuration from sw_init to new late_init phase
> 2. Adding vcn_v4_0_3_late_init() to properly check for per-queue reset su=
pport
> 3. Only setting soft full reset mask as fallback when per-queue reset isn=
't supported
> 4. Removing TODO comment now that queue reset support is implemented
>
> V2: Removed unrelated changes. Keep amdgpu_get_soft_full_reset_mask in pl=
ace
>     and remove TODO comment. (ALex)
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Ruili Ji <ruiliji2@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

This patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index 019bd362edb2..03fcd6833c26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -134,6 +134,16 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_bl=
ock *ip_block)
>         return 0;
>  }
>
> +static int vcn_v4_0_3_late_init(struct amdgpu_ip_block *ip_block)
> +{
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +
> +       if (amdgpu_dpm_reset_vcn_is_supported(adev))
> +               adev->vcn.supported_reset |=3D AMDGPU_RESET_TYPE_PER_QUEU=
E;
> +
> +       return 0;
> +}
> +
>  static int vcn_v4_0_3_fw_shared_init(struct amdgpu_device *adev, int ins=
t_idx)
>  {
>         struct amdgpu_vcn4_fw_shared *fw_shared;
> @@ -211,7 +221,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block =
*ip_block)
>                         adev->vcn.inst[i].pause_dpg_mode =3D vcn_v4_0_3_p=
ause_dpg_mode;
>         }
>
> -       /* TODO: Add queue reset mask when FW fully supports it */
>         adev->vcn.supported_reset =3D
>                 amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_e=
nc[0]);
>
> @@ -1871,6 +1880,7 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_=
device *adev)
>  static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs =3D {
>         .name =3D "vcn_v4_0_3",
>         .early_init =3D vcn_v4_0_3_early_init,
> +       .late_init =3D vcn_v4_0_3_late_init,
>         .sw_init =3D vcn_v4_0_3_sw_init,
>         .sw_fini =3D vcn_v4_0_3_sw_fini,
>         .hw_init =3D vcn_v4_0_3_hw_init,
> --
> 2.49.0
>
