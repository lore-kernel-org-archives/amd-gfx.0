Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B512EC25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 18:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30FE410E867;
	Thu, 26 Oct 2023 18:59:23 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA5810E867
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 18:59:21 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1e9bb3a0bfeso828097fac.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 11:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698346761; x=1698951561; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yYxtlvRDX7G7RfNAO9bur8y47ToZm/1Z0lun5XK2WAU=;
 b=iz1bP1x07TDjhebokIYXrzB4HWs8glESFTpLrjz4/rOGDYj4sdts7UtlqRxC+mUMQB
 iY8SfPKWZELfb2x6wxWPRj3e/yVmrknN1YNW1i0Q/uazijaB4XbNvSmP13dpN31T8m7H
 H9aBks1hFlyNV5EuUrQsflXPZ2yj0RsH6tSJv6vhV7Il+ze0IVhmHo9ldscInPcvyRR7
 B3TfKGYtgb/aScs/vf+VP8IEJkR3u4svv9DvIpSpWlj2Vlxc3J0pEzp3O/McmoC0Tfj9
 jDPQAlX7N023+NNVwNiMmpkgUV6WNDZUJ0lLVJT6ejkdhDMhTP4kpsscEQGdtTZdGf84
 GxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698346761; x=1698951561;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yYxtlvRDX7G7RfNAO9bur8y47ToZm/1Z0lun5XK2WAU=;
 b=bUgaTx8OxvBxvN+r1g9EoZ/FO67wHf75TEcnpLGdpaNWzDkdB75h3iDXdrkQI3wGtz
 Misy7Q0zz4RUliDQuFMDcPMQsgii3F0w7vfDSVk5E17Aavzd0AhuvcjlLdXHUg4B8g2A
 9/9MvlWYGPldYIzGEdj+Ulwqt2rAWyycIN0szG0YGJzFDcDHz6kybpSWO8AnfWIdEKhK
 1ZARmA1w6IFrkjSvR1vgGZ0VEodKWnVcFdM6umUaewg0OlkulNWY9XMfmgAaI+yW4uAJ
 iPFT3hed8aqcbLM0TlVGHTwFSgSKGerT7zUGVQJLWWxcslmEF4GTgcgtpWKiRf+P7XI4
 w5vA==
X-Gm-Message-State: AOJu0YxXWuRC1JmBqAuH90ri8g0K5HKi/mz/CzyHFrCAoJho+hxxr5w5
 cw6bXicDDIK6Q4PlyZogL03S45rivmIdzSELIxp7EvJI
X-Google-Smtp-Source: AGHT+IGLnZxjEiKxQU/laqHhvVajLkf/okubJTVy5eE7OttPqgjrVLdNou8bACbw5AJC+SBXbeSN4y8K6n02C1eNohs=
X-Received: by 2002:a05:6870:d683:b0:1e9:a741:44f3 with SMTP id
 z3-20020a056870d68300b001e9a74144f3mr646833oap.14.1698346760627; Thu, 26 Oct
 2023 11:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231026182125.264464-1-mukul.joshi@amd.com>
In-Reply-To: <20231026182125.264464-1-mukul.joshi@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Oct 2023 14:59:09 -0400
Message-ID: <CADnq5_MhcHtAfAenbYAQ40X-s_xv9rGGrWGA5CLKFdAMWW9xKQ@mail.gmail.com>
Subject: Re: [PATCHv2] drm/amdgpu: Fix typo in IP discovery parsing
To: Mukul Joshi <mukul.joshi@amd.com>
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
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 26, 2023 at 2:32=E2=80=AFPM Mukul Joshi <mukul.joshi@amd.com> w=
rote:
>
> Fix a typo in parsing of the GC info table header when
> reading the IP discovery table.
>
> Fixes: ecb70926eb86 ("drm/amdgpu: add type conversion for gc info")
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v1->v2:
> - Add the Fixes tag.
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 8d3681172cea..81476cd8461c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1488,7 +1488,7 @@ static int amdgpu_discovery_get_gfx_info(struct amd=
gpu_device *adev)
>                 adev->gfx.config.num_sc_per_sh =3D le32_to_cpu(gc_info->v=
2.gc_num_sc_per_se) /
>                         le32_to_cpu(gc_info->v2.gc_num_sh_per_se);
>                 adev->gfx.config.num_packer_per_sc =3D le32_to_cpu(gc_inf=
o->v2.gc_num_packer_per_sc);
> -               if (le16_to_cpu(gc_info->v2.header.version_minor =3D=3D 1=
)) {
> +               if (le16_to_cpu(gc_info->v2.header.version_minor) =3D=3D =
1) {
>                         adev->gfx.config.gc_num_tcp_per_sa =3D le32_to_cp=
u(gc_info->v2_1.gc_num_tcp_per_sh);
>                         adev->gfx.config.gc_tcp_size_per_cu =3D le32_to_c=
pu(gc_info->v2_1.gc_tcp_size_per_cu);
>                         adev->gfx.config.gc_num_sdp_interface =3D le32_to=
_cpu(gc_info->v2_1.gc_num_sdp_interface); /* per XCD */
> --
> 2.35.1
>
