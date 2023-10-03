Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD670E7AD77
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 16:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E16B10E2EA;
	Tue,  3 Oct 2023 16:31:50 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4CD810E2E3
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 16:31:48 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1dcbd8a56d6so714137fac.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Oct 2023 09:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696350708; x=1696955508; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xeeK35tqCiojtPxDKIApWZ9uecQ8HUhVX7hx+iiwjrU=;
 b=QKwiS4qXKuU2tXXNtaqa+KIrD8i3PD60aucZk3b8yPRi2fEE7Nn9GrGgfZZ7Vnj6fW
 480fNgaukprmLgKCXuH0RfMmN/RE6mntq4RS/zANas0T1H5zEdx5hYI0AiugA24ND2bd
 7t3I9Bl1aYnVBMST1qplIVYsx8dVH4GUZdk7OAFZwHLmBAyhvEgdJP8OtzQz24QWCiPF
 hocHvxxxtCb4hf0ZbsiDDB2Yqsx3am6UoL42M3wsz1VulCQe8qGY38jWmiUOwkBTAkoR
 V71PE+yKqDH9KXo1miKqy+U8CpLG0dwGDSRKUEAuhTweRN4zvTF2LKaAQ+6jXS2Rcb+b
 OyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696350708; x=1696955508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xeeK35tqCiojtPxDKIApWZ9uecQ8HUhVX7hx+iiwjrU=;
 b=kONG2Q4OlIgSwWtZTBS9Tp4Ri9wt31pwEKZ/COkMJ9/pYdfKXaRJWQOL6ootv/sUzj
 jBSe9ilvEqQFhZ+KYNwZeQf1fH2Ty6ZujRpSMODvnsGqsJ518jKxKmCsyFsYRs5avRA8
 ZMQwy1fbVkNO6nz4rYronB3+zUWNuR3KN9kfiX90bWb9ijxoLY5I7kWvDzaN1/pyJ/Pt
 tb1LLTjh3/eSxmSQVlx1BXV7/Ayqw1NR8hj4AwIhY7L5d2WunkxVitSbL+k0UEXRFNvA
 OvhdWThYIxuKqaQxWJcjr18YYEBon63M1PTjBeCYzzBXB9DruhBlhCxxtpJjfC8nsmvh
 HD8w==
X-Gm-Message-State: AOJu0Yy2tV7HDiuI0BDXA2yePZ3xVC+27OaXILOIEsHuxPx76JjiF25x
 il10UGyr7kEOopCGvGNDiVJD1FQySScNkkXiQlQ=
X-Google-Smtp-Source: AGHT+IGcZjN+ljh+q5v3ikyLPpsNEmmDGSR8Dm4EiofULcsXSt1d+UNcg+jLz+UoTJD5zE3SGc3CBXkpEzN+ySvWGpE=
X-Received: by 2002:a05:6870:d0c5:b0:1e1:372:1f7a with SMTP id
 k5-20020a056870d0c500b001e103721f7amr118651oaa.8.1696350708069; Tue, 03 Oct
 2023 09:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124929.1965750-1-sathishkumar.sundararaju@amd.com>
 <CADnq5_NTHMU5OAb_Rw1iWyHB0ksgv8v7C2J7A9TnUdgRt-1_Yg@mail.gmail.com>
 <d96ed183-6806-c2a8-7972-fab3944aa02a@amd.com>
In-Reply-To: <d96ed183-6806-c2a8-7972-fab3944aa02a@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Oct 2023 12:31:36 -0400
Message-ID: <CADnq5_MM-_zR6_nDdfejpoC=m0Xv4eM5ZQkoVZH6qnChfcaWCA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix ip count query for xcp partitions
To: "Sundararaju, Sathishkumar" <sasundar@amd.com>
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
Cc: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org,
 Alexander Deucher <Alexander.Deucher@amd.com>, James.Zhu@amd.com, "Liu,
 Leo" <Leo.Liu@amd.com>, Koenig Christian <Christian.Koenig@amd.com>,
 Srinath Rao <Srinath.rao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Oct 3, 2023 at 12:22=E2=80=AFPM Sundararaju, Sathishkumar
<sasundar@amd.com> wrote:
>
> Hi ,
>
> Kind request to help review the change. Thank you.

I acked this change back when you sent it out, but if it didn't come
through for some reason:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Regards,
>
> Sathish
>
> On 9/21/2023 8:17 PM, Alex Deucher wrote:
> > On Thu, Sep 21, 2023 at 9:07=E2=80=AFAM Sathishkumar S
> > <sathishkumar.sundararaju@amd.com> wrote:
> >> fix wrong ip count INFO on spatial partitions. update the query
> >> to return the instance count corresponding to the partition id.
> >>
> >> v2:
> >>   initialize variables only when required to be (Christian)
> >>   move variable declarations to the beginning of function (Christian)
> >>
> >> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> >
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 44 ++++++++++++++++++++---=
--
> >>   1 file changed, 36 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_kms.c
> >> index 081bd28e2443..d4ccbe7c78d6 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >> @@ -595,11 +595,16 @@ int amdgpu_info_ioctl(struct drm_device *dev, vo=
id *data, struct drm_file *filp)
> >>          struct drm_amdgpu_info *info =3D data;
> >>          struct amdgpu_mode_info *minfo =3D &adev->mode_info;
> >>          void __user *out =3D (void __user *)(uintptr_t)info->return_p=
ointer;
> >> +       struct amdgpu_fpriv *fpriv;
> >> +       struct amdgpu_ip_block *ip_block;
> >> +       enum amd_ip_block_type type;
> >> +       struct amdgpu_xcp *xcp;
> >> +       uint32_t count, inst_mask;
> >>          uint32_t size =3D info->return_size;
> >>          struct drm_crtc *crtc;
> >>          uint32_t ui32 =3D 0;
> >>          uint64_t ui64 =3D 0;
> >> -       int i, found;
> >> +       int i, found, ret;
> >>          int ui32_size =3D sizeof(ui32);
> >>
> >>          if (!info->return_size || !info->return_pointer)
> >> @@ -627,7 +632,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *filp)
> >>                  return copy_to_user(out, &ui32, min(size, 4u)) ? -EFA=
ULT : 0;
> >>          case AMDGPU_INFO_HW_IP_INFO: {
> >>                  struct drm_amdgpu_info_hw_ip ip =3D {};
> >> -               int ret;
> >>
> >>                  ret =3D amdgpu_hw_ip_info(adev, info, &ip);
> >>                  if (ret)
> >> @@ -637,15 +641,41 @@ int amdgpu_info_ioctl(struct drm_device *dev, vo=
id *data, struct drm_file *filp)
> >>                  return ret ? -EFAULT : 0;
> >>          }
> >>          case AMDGPU_INFO_HW_IP_COUNT: {
> >> -               enum amd_ip_block_type type;
> >> -               struct amdgpu_ip_block *ip_block =3D NULL;
> >> -               uint32_t count =3D 0;
> >> -
> >> +               fpriv =3D (struct amdgpu_fpriv *) filp->driver_priv;
> >>                  type =3D amdgpu_ip_get_block_type(adev, info->query_h=
w_ip.type);
> >>                  ip_block =3D amdgpu_device_ip_get_ip_block(adev, type=
);
> >> +
> >>                  if (!ip_block || !ip_block->status.valid)
> >>                          return -EINVAL;
> >>
> >> +               if (adev->xcp_mgr && adev->xcp_mgr->num_xcps > 0 &&
> >> +                       fpriv->xcp_id >=3D 0 && fpriv->xcp_id < adev->=
xcp_mgr->num_xcps) {
> >> +                       xcp =3D &adev->xcp_mgr->xcp[fpriv->xcp_id];
> >> +                       switch (type) {
> >> +                       case AMD_IP_BLOCK_TYPE_GFX:
> >> +                               ret =3D amdgpu_xcp_get_inst_details(xc=
p, AMDGPU_XCP_GFX, &inst_mask);
> >> +                               count =3D hweight32(inst_mask);
> >> +                               break;
> >> +                       case AMD_IP_BLOCK_TYPE_SDMA:
> >> +                               ret =3D amdgpu_xcp_get_inst_details(xc=
p, AMDGPU_XCP_SDMA, &inst_mask);
> >> +                               count =3D hweight32(inst_mask);
> >> +                               break;
> >> +                       case AMD_IP_BLOCK_TYPE_JPEG:
> >> +                               ret =3D amdgpu_xcp_get_inst_details(xc=
p, AMDGPU_XCP_VCN, &inst_mask);
> >> +                               count =3D hweight32(inst_mask) * adev-=
>jpeg.num_jpeg_rings;
> >> +                               break;
> >> +                       case AMD_IP_BLOCK_TYPE_VCN:
> >> +                               ret =3D amdgpu_xcp_get_inst_details(xc=
p, AMDGPU_XCP_VCN, &inst_mask);
> >> +                               count =3D hweight32(inst_mask);
> >> +                               break;
> >> +                       default:
> >> +                               return -EINVAL;
> >> +                       }
> >> +                       if (ret)
> >> +                               return ret;
> >> +                       return copy_to_user(out, &count, min(size, 4u)=
) ? -EFAULT : 0;
> >> +               }
> >> +
> >>                  switch (type) {
> >>                  case AMD_IP_BLOCK_TYPE_GFX:
> >>                  case AMD_IP_BLOCK_TYPE_VCE:
> >> @@ -678,7 +708,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *filp)
> >>                  return copy_to_user(out, &ui64, min(size, 8u)) ? -EFA=
ULT : 0;
> >>          case AMDGPU_INFO_FW_VERSION: {
> >>                  struct drm_amdgpu_info_firmware fw_info;
> >> -               int ret;
> >>
> >>                  /* We only support one instance of each IP block righ=
t now. */
> >>                  if (info->query_fw.ip_instance !=3D 0)
> >> @@ -823,7 +852,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *filp)
> >>                  struct drm_amdgpu_info_device *dev_info;
> >>                  uint64_t vm_size;
> >>                  uint32_t pcie_gen_mask;
> >> -               int ret;
> >>
> >>                  dev_info =3D kzalloc(sizeof(*dev_info), GFP_KERNEL);
> >>                  if (!dev_info)
> >> --
> >> 2.25.1
> >>
