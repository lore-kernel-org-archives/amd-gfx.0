Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D14C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 02:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53E4A10E4D1;
	Thu, 18 May 2023 02:29:04 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 832F910E4D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 02:29:02 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-199c95698baso1198714fac.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 19:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684376941; x=1686968941;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rx3reIU34X6aeyF/aDJtYwJM5+73svEIocL5Q2SJuPE=;
 b=T/WBlqBUfKhlcM+B3byacW+qAm0eOvFaw5oAUyawLstFpMcJi/N/mE9t546ZiOWefb
 z7UFbU2tCRRnuTUtd5Qgy6Rs9+leaPR5DIik9aU/dHBFBl+PkIPuq/tmV66Qm2pSZcC5
 jKodGVf815HMDcKn+I3GbCjmpHijRsYC/4O2ZeuZbYFv0PrXbiCzHxz8gZXzYgJR3R4w
 ojPBQ64zWFyAXvX3QfxYGQUKrGC46yjSrm/k4epKSTnjZaXE5pE91X7mFYLKqSV+Vfr3
 cOYVE9SViK69pOphPhM+17qOD+qjP5NV5K3i2ZDI1lfeDAyzmrm3PMoNXuPJDBh3FzNO
 5oKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684376941; x=1686968941;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rx3reIU34X6aeyF/aDJtYwJM5+73svEIocL5Q2SJuPE=;
 b=QmacKoefxaGVExTywfgWbCVEMmHjKNJABBm0zdC/rUi3Vt+6m1bOJUealls29nRgzs
 jy//5Q8OEmuO1Lz2ARryKs4XPc27e5fPLZsFnyn8NjZI/FXnYW1r1pEVfGQvM4HuqUQj
 GUZQrpw5c2RWRoNyCjokbiBrh6vk9EbESvQ27K+J40JbHV11DfIvrdUVZW6bHdNBtZzR
 0DLgsuxjUVpWOr4bQDJLrEJWUNYIZXb2Uzg7H3ugd2/xrGNaGFqcPyw6u9QBaXvf+ZRM
 4QIil8vDUhppl5LWRkAwtcYXBm91wE9DjKAr7/UJJMuddUshRBVNVy5r31cWTuRnDnWe
 ybgQ==
X-Gm-Message-State: AC+VfDwV53n0zNTtEvFy5+cUBwMTnFQbPuUg5h9PUvuyivXsj2A4+IKc
 cEpyRDd+eB0V9CZXz8fFDXE59OFw9HvNRtJMD0w=
X-Google-Smtp-Source: ACHHUZ6SP2zTENv+PBC4wtpX5gxs7AJX95miGmjRywemFGSWdvWHbY8er9aXeObe9HR0g4TD/GqsG6RMatf/gnC4L4Q=
X-Received: by 2002:a05:6870:72c2:b0:17e:d17c:1d19 with SMTP id
 o2-20020a05687072c200b0017ed17c1d19mr93543oak.8.1684376940952; Wed, 17 May
 2023 19:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230518022645.2535481-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230518022645.2535481-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 May 2023 22:28:49 -0400
Message-ID: <CADnq5_NqGkHYdWFv-Mtb0C9uWOGkazBoSWsMvUv6stPywabZdw@mail.gmail.com>
Subject: Re: [PATCH] Fix warnings in amdgpu _sdma, _ucode.c
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 17, 2023 at 10:27=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>

Patch title should be prefixed with drm/amdgpu:.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Fix below checkpatch warnings:
>
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> WARNING: Comparisons should place the constant on the right side of the t=
est
> WARNING: Missing a blank line after declarations
>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 231ca06bc9c7..9568adaad5cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -64,7 +64,7 @@ int amdgpu_sdma_get_index_from_ring(struct amdgpu_ring =
*ring, uint32_t *index)
>  }
>
>  uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring,
> -                                    unsigned vmid)
> +                                    unsigned int vmid)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
>         uint64_t csa_mc_addr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ucode.c
> index f76b1cb8baf8..16807ff96dc9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -748,7 +748,7 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_=
device *adev,
>         const struct imu_firmware_header_v1_0 *imu_hdr =3D NULL;
>         u8 *ucode_addr;
>
> -       if (NULL =3D=3D ucode->fw)
> +       if (!ucode->fw)
>                 return 0;
>
>         ucode->mc_addr =3D mc_addr;
> @@ -972,7 +972,7 @@ static int amdgpu_ucode_patch_jt(struct amdgpu_firmwa=
re_info *ucode,
>         uint8_t *src_addr =3D NULL;
>         uint8_t *dst_addr =3D NULL;
>
> -       if (NULL =3D=3D ucode->fw)
> +       if (!ucode->fw)
>                 return 0;
>
>         comm_hdr =3D (const struct common_firmware_header *)ucode->fw->da=
ta;
> @@ -1043,6 +1043,7 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev=
)
>                         if (i =3D=3D AMDGPU_UCODE_ID_CP_MEC1 &&
>                             adev->firmware.load_type !=3D AMDGPU_FW_LOAD_=
PSP) {
>                                 const struct gfx_firmware_header_v1_0 *cp=
_hdr;
> +
>                                 cp_hdr =3D (const struct gfx_firmware_hea=
der_v1_0 *)ucode->fw->data;
>                                 amdgpu_ucode_patch_jt(ucode,  adev->firmw=
are.fw_buf_mc + fw_offset,
>                                                     adev->firmware.fw_buf=
_ptr + fw_offset);
> --
> 2.25.1
>
