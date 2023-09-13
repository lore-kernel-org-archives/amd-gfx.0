Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C07FEE0204
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 21:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB32210E0B9;
	Wed, 13 Sep 2023 21:12:58 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 138A410E0B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 21:12:58 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1d5a1965a9aso182420fac.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 14:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694639577; x=1695244377; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NMglWYzdpYibJBxzxyCtb1Bca/HVLZzYDdx1UvlbKsU=;
 b=QEMO9zWpvaTAcwfSz0BI2hVxL+WO4oT9tyGDyqor+qMUYQyQwFAS3yngYbaHSns5jW
 /XvgIbj77bZWoeUDfiEG+kVqwwQbeBq3eRKvIeW9UEXMgcMHayq+wResuxjFvuQr/WgU
 Mc7o1oibwhuQGJwpc+sjVEbfVLgQCOFki5pDeoxBqBOUhCQzZMVg3DSZUZ82bnAlhVKl
 RwWO97eCpz5Kjl9LkigQ0Q3grNX+K9ipDN8D6laajmPMgKS1y3Yh6wV+vdqAmKZcSfv6
 9YNm7vZtaNvi6eGSiHxQ2TZfg6QwBhiSyoRUGuz5tg3PHhxFG6xhEpyttxxovYa7i1KW
 pBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694639577; x=1695244377;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NMglWYzdpYibJBxzxyCtb1Bca/HVLZzYDdx1UvlbKsU=;
 b=TOau75VE22i6uGv3brkgfXSVQ2neK7jf/VGr3Gj7XZdzyNfZ049Am7kTSpfADG35OV
 lzZCyfESdad1wpGsW+cMpTp8OWpP0VSsp757rzp48wupVdn4vR/J0TRISN0+RUL40lH7
 E3UoL8M+wQbP0PdmWI/aVnqkyCEJbtaOpPLX5kQzo0ELknFTqYy67oKXjVPFOPqgMBeZ
 Q/hrb3JEdnkTf0UViAbZ0WDqmx8zt1cIQEqKjv0VZCIArDmbVU2wWEnqASHbJJ6T1/BY
 7COzW/3N9dNyxVbTVOXaYlWKVzNgaB256+QiavJCHB3ZdOXU6OkxyjNTYAthqMURieu6
 zcdA==
X-Gm-Message-State: AOJu0YymcuGDCJKoqFwROaTCpfjdXEJPuf1QKHDHVuALXHqDj4ga+p6s
 PB1UCWLoJBzo46YzWGB4Esj+Fac7GUUchG0ZRaHAs/im
X-Google-Smtp-Source: AGHT+IG1IMLAPDeJGha0SDNdbJinuPi/+nfN+dhf4JwsxRD06D/jLg7RHXTW0/nU1MbNfUn4ryXLKGDCMtOatkajQZw=
X-Received: by 2002:a05:6870:472c:b0:1d5:da78:5c7d with SMTP id
 b44-20020a056870472c00b001d5da785c7dmr4471500oaq.50.1694639577113; Wed, 13
 Sep 2023 14:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230913055744.1162406-1-lijo.lazar@amd.com>
 <20230913055744.1162406-2-lijo.lazar@amd.com>
 <BN9PR12MB52576A87C96AAC49CE9A7A78FCF0A@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52576A87C96AAC49CE9A7A78FCF0A@BN9PR12MB5257.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Sep 2023 17:12:45 -0400
Message-ID: <CADnq5_PLwNBMUvpXjuUWgr41Fgqp3kLFabuU3KuLcfOLbZV4PQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add more fields to IP version
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 13, 2023 at 3:31=E2=80=AFAM Zhang, Hawking <Hawking.Zhang@amd.c=
om> wrote:
>
> [AMD Official Use Only - General]
>
> Series is
>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>
> Regards,
> Hawking
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, September 13, 2023 13:58
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander=
.Deucher@amd.com>; Olsak, Marek <Marek.Olsak@amd.com>; Deucher, Alexander <=
Alexander.Deucher@amd.com>
> Subject: [PATCH v2 2/2] drm/amdgpu: Add more fields to IP version
>
> Include subrevision and variant fileds also to IP version.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
> v2:
>         Use major/min/rev format in drm_amdgpu_info_hw_ip discovery versi=
on
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 18 ++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 20 ++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  8 ++++----
>  3 files changed, 34 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 30f44db6c9c5..d62c245d8ad7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -681,10 +681,15 @@ enum amd_hw_ip_block_type {
>  #define HWIP_MAX_INSTANCE      44
>
>  #define HW_ID_MAX              300
> -#define IP_VERSION(mj, mn, rv) (((mj) << 16) | ((mn) << 8) | (rv)) -#def=
ine IP_VERSION_MAJ(ver) ((ver) >> 16) -#define IP_VERSION_MIN(ver) (((ver) =
>> 8) & 0xFF) -#define IP_VERSION_REV(ver) ((ver) & 0xFF)
> +#define IP_VERSION_FULL(mj, mn, rv, var, srev) \
> +       (((mj) << 24) | ((mn) << 16) | ((rv) << 8) | ((var) << 4) | (srev=
))
> +#define IP_VERSION(mj, mn, rv)         IP_VERSION_FULL(mj, mn, rv, 0, 0)
> +#define IP_VERSION_MAJ(ver)            ((ver) >> 24)
> +#define IP_VERSION_MIN(ver)            (((ver) >> 16) & 0xFF)
> +#define IP_VERSION_REV(ver)            (((ver) >> 8) & 0xFF)
> +#define IP_VERSION_VARIANT(ver)                (((ver) >> 4) & 0xF)
> +#define IP_VERSION_SUBREV(ver)         ((ver) & 0xF)
> +#define IP_VERSION_MAJ_MIN_REV(ver)    ((ver) >> 8)
>
>  struct amdgpu_ip_map_info {
>         /* Map of logical to actual dev instances/mask */ @@ -1109,7 +111=
4,10 @@ struct amdgpu_device {  static inline uint32_t amdgpu_ip_version(co=
nst struct amdgpu_device *adev,
>                                          uint8_t ip, uint8_t inst)
>  {
> -       return adev->ip_versions[ip][inst];
> +       /* This considers only major/minor/rev and ignores
> +        * subrevision/variant fields.
> +        */
> +       return adev->ip_versions[ip][inst] & ~0xFFU;
>  }
>
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)=
 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_discovery.c
> index 430ee7f64a97..42d379956ef3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1191,6 +1191,7 @@ static void amdgpu_discovery_sysfs_fini(struct amdg=
pu_device *adev)
>
>  static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)  {
> +       uint8_t num_base_address, subrev, variant;
>         struct binary_header *bhdr;
>         struct ip_discovery_header *ihdr;
>         struct die_header *dhdr;
> @@ -1199,7 +1200,6 @@ static int amdgpu_discovery_reg_base_init(struct am=
dgpu_device *adev)
>         uint16_t ip_offset;
>         uint16_t num_dies;
>         uint16_t num_ips;
> -       uint8_t num_base_address;
>         int hw_ip;
>         int i, j, k;
>         int r;
> @@ -1337,8 +1337,22 @@ static int amdgpu_discovery_reg_base_init(struct a=
mdgpu_device *adev)
>                                          * example.  On most chips there =
are multiple instances
>                                          * with the same HWID.
>                                          */
> -                                       adev->ip_versions[hw_ip][ip->inst=
ance_number] =3D
> -                                               IP_VERSION(ip->major, ip-=
>minor, ip->revision);
> +
> +                                       if (ihdr->version < 3) {
> +                                               subrev =3D 0;
> +                                               variant =3D 0;
> +                                       } else {
> +                                               subrev =3D ip->sub_revisi=
on;
> +                                               variant =3D ip->variant;
> +                                       }
> +
> +                                       adev->ip_versions[hw_ip]
> +                                                        [ip->instance_nu=
mber] =3D
> +                                               IP_VERSION_FULL(ip->major=
,
> +                                                               ip->minor=
,
> +                                                               ip->revis=
ion,
> +                                                               variant,
> +                                                               subrev);
>                                 }
>                         }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index dfd24a582391..1bf545154e8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -502,21 +502,21 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *=
adev,
>                 switch (type) {
>                 case AMD_IP_BLOCK_TYPE_GFX:
>                         result->ip_discovery_version =3D
> -                               amdgpu_ip_version(adev, GC_HWIP, 0);
> +                               IP_VERSION_MAJ_MIN_REV(amdgpu_ip_version(=
adev, GC_HWIP, 0));
>                         break;
>                 case AMD_IP_BLOCK_TYPE_SDMA:
>                         result->ip_discovery_version =3D
> -                               amdgpu_ip_version(adev, SDMA0_HWIP, 0);
> +                               IP_VERSION_MAJ_MIN_REV(amdgpu_ip_version(=
adev, SDMA0_HWIP, 0));
>                         break;
>                 case AMD_IP_BLOCK_TYPE_UVD:
>                 case AMD_IP_BLOCK_TYPE_VCN:
>                 case AMD_IP_BLOCK_TYPE_JPEG:
>                         result->ip_discovery_version =3D
> -                               amdgpu_ip_version(adev, UVD_HWIP, 0);
> +                               IP_VERSION_MAJ_MIN_REV(amdgpu_ip_version(=
adev, UVD_HWIP, 0));
>                         break;
>                 case AMD_IP_BLOCK_TYPE_VCE:
>                         result->ip_discovery_version =3D
> -                               amdgpu_ip_version(adev, VCE_HWIP, 0);
> +                               IP_VERSION_MAJ_MIN_REV(amdgpu_ip_version(=
adev, VCE_HWIP, 0));
>                         break;

Just a heads up that I just pushed a patch which added a case for VPE
here, so please make sure that gets fixed too when you push this.

Thanks,

Alex
