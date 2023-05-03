Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489A0C77B75
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 15:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2C7710E2DC;
	Wed,  3 May 2023 15:02:47 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B6A10E2DC
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 15:02:46 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1929d8c009cso965545fac.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 May 2023 08:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683126166; x=1685718166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dUDkGZWtITvK3DiuMqTGBqypBgqTXe1YKRXtdkjNFjA=;
 b=WSVQ0dVfuf2JPMqG53H1s+gtceEL/krws3CB6vS0RaOFG85+cligKHP+E8zUDiprVa
 1wWhFubfhqtdgaURKsA4CUTXhy34E5wjkws8+w2DeCpl7GfVeEl71DEZ3p537+QR9AA1
 DGPNhtUHNx+9B5LNCb/G7A8Ku2P2ZWZ6af8e2dJ8koKT4QiJvaScPv3zg8B6xtDFO1R6
 z87iHwyNDUEMM0r+nqHbftWxI+t4s89JPs42RRjEZ/44IYDmwd9Syupnz+DdonyUw5ys
 nnZL8i7zzOIuUx9eAiQ5oCr92gmPHlf0EZ39KBTiIfvV+YaUxyRTXcwnLkNf2hPyAmf6
 qxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683126166; x=1685718166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dUDkGZWtITvK3DiuMqTGBqypBgqTXe1YKRXtdkjNFjA=;
 b=PQNo3y9lhwS5s/tIvLfKPZBsDIf1YNaZ8rIfSliddNSVSahiuJ4Zch2exylJvyyDeL
 RG9N6ZhTIw901MdCENeMvt+Rq2KHLjHUq0Y1KR/SOtEYjmDwuFihCDnB7IwtVQCa9yKj
 EY2y82wA9Xt32B8MykbeyMzGn90KDwdonoJUyTi7QjYJDkZhmpQ/CUT0dXlHZbkE4rU+
 uFbmUoNaWELK7G/zE7/akJA8M0qJNy2Mlw7rmdlH/pj85csCug9PYl+oPLuufaHILEt7
 NqRsp6lnkMWPS3HHWjX0yFvdCQHzst9hZR5iKWph9sUQ2HkSs95rtgV7oESv4BWrGtY5
 WqMw==
X-Gm-Message-State: AC+VfDxC675HMJpDqya4C1dbjECX8vNfZNd+B5vQ/wGEtK3m8IoVi7AA
 LejPvJNbIj0ptEbxQmycQavouirzjbJ5wCYEDR7DupXK
X-Google-Smtp-Source: ACHHUZ6JDHhdELnGWEaiWQnkEoDoS2+gnI2DhyTpQEtA9/JxJ9i5M8I/QXqCN9Fiuz3nqhNi51E4YLHjHUvkRw1EEUo=
X-Received: by 2002:a05:6870:e2c2:b0:187:93d0:985d with SMTP id
 w2-20020a056870e2c200b0018793d0985dmr9958478oad.35.1683126165644; Wed, 03 May
 2023 08:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230427183429.599578-1-alexander.deucher@amd.com>
 <20230427183429.599578-2-alexander.deucher@amd.com>
In-Reply-To: <20230427183429.599578-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 May 2023 11:02:34 -0400
Message-ID: <CADnq5_MAiEcCAE79NoeC5FU9eh+kgYBjD0azagRyaDvuXSEGcA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: drop unused function
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Thu, Apr 27, 2023 at 2:34=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> amdgpu_discovery_get_ip_version() has not been used since
> commit c40bdfb2ffa4 ("drm/amdgpu: fix incorrect VCN revision in SRIOV")
> so drop it.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 48 -------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  2 -
>  2 files changed, 50 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 76ceca05452e..b58d94dc1924 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1208,54 +1208,6 @@ static int amdgpu_discovery_reg_base_init(struct a=
mdgpu_device *adev)
>         return 0;
>  }
>
> -int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_i=
d, int number_instance,
> -                                   int *major, int *minor, int *revision=
)
> -{
> -       struct binary_header *bhdr;
> -       struct ip_discovery_header *ihdr;
> -       struct die_header *dhdr;
> -       struct ip *ip;
> -       uint16_t die_offset;
> -       uint16_t ip_offset;
> -       uint16_t num_dies;
> -       uint16_t num_ips;
> -       int i, j;
> -
> -       if (!adev->mman.discovery_bin) {
> -               DRM_ERROR("ip discovery uninitialized\n");
> -               return -EINVAL;
> -       }
> -
> -       bhdr =3D (struct binary_header *)adev->mman.discovery_bin;
> -       ihdr =3D (struct ip_discovery_header *)(adev->mman.discovery_bin =
+
> -                       le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset=
));
> -       num_dies =3D le16_to_cpu(ihdr->num_dies);
> -
> -       for (i =3D 0; i < num_dies; i++) {
> -               die_offset =3D le16_to_cpu(ihdr->die_info[i].die_offset);
> -               dhdr =3D (struct die_header *)(adev->mman.discovery_bin +=
 die_offset);
> -               num_ips =3D le16_to_cpu(dhdr->num_ips);
> -               ip_offset =3D die_offset + sizeof(*dhdr);
> -
> -               for (j =3D 0; j < num_ips; j++) {
> -                       ip =3D (struct ip *)(adev->mman.discovery_bin + i=
p_offset);
> -
> -                       if ((le16_to_cpu(ip->hw_id) =3D=3D hw_id) && (ip-=
>number_instance =3D=3D number_instance)) {
> -                               if (major)
> -                                       *major =3D ip->major;
> -                               if (minor)
> -                                       *minor =3D ip->minor;
> -                               if (revision)
> -                                       *revision =3D ip->revision;
> -                               return 0;
> -                       }
> -                       ip_offset +=3D struct_size(ip, base_address, ip->=
num_base_address);
> -               }
> -       }
> -
> -       return -EINVAL;
> -}
> -
>  static void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
>  {
>         int vcn_harvest_count =3D 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.h
> index 8563dd4a7dc2..63ec6924b907 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> @@ -28,8 +28,6 @@
>  #define DISCOVERY_TMR_OFFSET    (64 << 10)
>
>  void amdgpu_discovery_fini(struct amdgpu_device *adev);
> -int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_i=
d, int number_instance,
> -                                    int *major, int *minor, int *revisio=
n);
>  int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
>
>  #endif /* __AMDGPU_DISCOVERY__ */
> --
> 2.40.0
>
