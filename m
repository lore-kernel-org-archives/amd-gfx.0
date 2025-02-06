Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B0AC02198
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 15:17:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F94A10E899;
	Thu,  6 Feb 2025 15:17:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VriEqu6w";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C0210E892
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 15:04:02 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2fa0f70bfecso131598a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Feb 2025 07:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738854242; x=1739459042; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/HuRIzzfdmsj87tlNNL7V66HKGSebxhgSNXU3UP0hc=;
 b=VriEqu6wju7ZCrctxGT/7su5xGVYSrT1LfIjaE9ZWTlpw4ro+KhiwE7x4dZriGf3fv
 RzhXEs4lJQmYu65jisoBnDtELv8zqM735Ksz4wcDGVROlWLKlA9TdRf5CtxCvf4L6g+0
 ZrATgYrJQjk2zq0OBRxlyx4UuqXS9MY5SjcKj6r7VxNkcpk7SDvxV1gr8S+bWXWr5jhO
 74NGuvBI8nHfDsngyqSZXHvt9bkkzvBDj7rB5p57eRdNdET+LePo2tghpGwanmdc5Nji
 jwJh0WxlhafjaJ85ZPXH75JSk6/eDx+ad+xpcyntn07LxwoMxZVM4ycizoR+oEI7C7oN
 amig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738854242; x=1739459042;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W/HuRIzzfdmsj87tlNNL7V66HKGSebxhgSNXU3UP0hc=;
 b=idrhLRSCFgjyrChrkUBqZ0CUCZpiFCTdW97xXIz9Z9ZeIgScu7BR2X4cKYnbCX2/2z
 ukHiANBltzvzWqOS/t3EdTgYMf1JAIS13KuSSG5Qm3FE7euEyKAWHCCpvDLL6wz+bvvS
 xcXpcgmkFfK8MGSkJ3yA9Jd2xLE54bBm1GjhNoAJQebmoVjcgCUPjnz8RSlWxRRdaFAg
 KwEW/vB/InWaeHU8fdIuG/iMymsicgeJSd2LsSYEzXRCzdOoImSWxO/cLLAenbvJ6fhy
 0vLNy5sZ3FMZKOnlS4/TX/5tuD3RPaBnQA0/mSMV72bwqM3hgfn+C+DHAR9A2xmzdrKE
 /NJQ==
X-Gm-Message-State: AOJu0YylBnnH38U3jj56Z2od3Dw55RQkIJ/VzhTIdh0LjXSDQFjJsklx
 HxJfSQ9PIymKPDBdqg/lFOs8Aa9iXtzUaITrzesuK5+SQo1Mi69koQsCPqJDfDb7RR72kE8WJMe
 ku5E+kLbn7JabrCCZprC7WuuWgT4=
X-Gm-Gg: ASbGnctSON1jFTP8QMZSqo8r/H4hxhIMkJB3IjVJB7oRJ3fw7WoyNBM5iuoS+Aa6k7e
 sL//5/LXpSE8HKeE7206LmwRF1kCOBeYZFwjt5poYp3KYC/F/Omj6U4TGxkpE+dB7Xq85+Sr/
X-Google-Smtp-Source: AGHT+IHD2yaAwXHvOleAwadIpNrtZdoYB6Yvy1tRNn7g44rMx7NhLgt3vvJwBJHJXkHuvgHeM4okycOm25TyNDNO7f4=
X-Received: by 2002:a17:90b:4a8b:b0:2ea:956b:deab with SMTP id
 98e67ed59e1d1-2f9e0825dbdmr4691461a91.4.1738854242243; Thu, 06 Feb 2025
 07:04:02 -0800 (PST)
MIME-Version: 1.0
References: <20250129152029.32275-1-jinhuieric.huang@amd.com>
In-Reply-To: <20250129152029.32275-1-jinhuieric.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Feb 2025 10:03:50 -0500
X-Gm-Features: AWEUYZnbGvthNTE6G2nkEmwYQ5s2wdwX90mNdXXLUGEXmROxHO2oNSx0WqQ9m6Y
Message-ID: <CADnq5_Ob+aVNtwcxrH3BaYSC4FwkHLWcpvRi2ceqL+JiV3Ugjw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix missing L2 cache info in topology
To: Eric Huang <jinhuieric.huang@amd.com>
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jan 29, 2025 at 10:37=E2=80=AFAM Eric Huang <jinhuieric.huang@amd.c=
om> wrote:
>
> In some ASICs L2 cache info may miss in kfd topology,
> because the first bitmap may be empty, that means
> the first cu may be inactive, so to find the first
> active cu will solve the issue.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_topology.c
> index 4936697e6fc2..73d95041a388 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1665,17 +1665,31 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_=
properties **props_ext,
>                                 int cache_type, unsigned int cu_processor=
_id,
>                                 struct kfd_node *knode)
>  {
> -       unsigned int cu_sibling_map_mask;
> +       unsigned int cu_sibling_map_mask =3D 0;
>         int first_active_cu;
>         int i, j, k, xcc, start, end;
>         int num_xcc =3D NUM_XCC(knode->xcc_mask);
>         struct kfd_cache_properties *pcache =3D NULL;
>         enum amdgpu_memory_partition mode;
>         struct amdgpu_device *adev =3D knode->adev;
> +       bool found =3D false;
>
>         start =3D ffs(knode->xcc_mask) - 1;
>         end =3D start + num_xcc;
> -       cu_sibling_map_mask =3D cu_info->bitmap[start][0][0];
> +
> +       /* To find the bitmap in the first active cu */
> +       for (xcc =3D start; xcc < end && !found; xcc++) {
> +               for (i =3D 0; i < gfx_info->max_shader_engines && !found;=
 i++) {
> +                       for (j =3D 0; j < gfx_info->max_sh_per_se && !fou=
nd; j++) {
> +                               if (cu_info->bitmap[xcc][i % 4][j % 4]) {
> +                                       cu_sibling_map_mask =3D
> +                                               cu_info->bitmap[xcc][i % =
4][j % 4];
> +                                       found =3D true;
> +                               }
> +                       }
> +               }
> +       }
> +
>         cu_sibling_map_mask &=3D
>                 ((1 << pcache_info[cache_type].num_cu_shared) - 1);
>         first_active_cu =3D ffs(cu_sibling_map_mask);
> --
> 2.34.1
>
