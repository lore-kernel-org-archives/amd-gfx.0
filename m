Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375A8D3E2BC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 500E710E53F;
	Mon, 28 Oct 2024 19:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="loGMPNnl";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57F7C10E53F
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:43:03 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-71e4eb91228so327961b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730144583; x=1730749383; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9B2eQxTpuEKGl0PAWsJqClqX9CksyCGAsH4ysZnUpA=;
 b=loGMPNnlCr5ym0PjEDqe8uvZ/lGpRnpxn8RIvNavfQlcBvbWaBnhvIBciaD6W32Asi
 DEfoQD7qJcGCft+yx1/BIP9evfC/aFT77MvPBGqxPMmnvMyjqdIor97Hsjih3zxXBBmm
 EVT9LQuNMdZ0B0XiuW7+V+iGtPk2Wwoul8vu6fENFggL2SRp0EnmFW5faJgdDUne46Kg
 UIc65rct2Tfc5M+N9rMI1xY5MJphj+TDOQVO+s6qDhKu7eBXnfxJjqjwGcOKCcLSUPdr
 TwXybCmJFTheVMFyc0oJQRBZ4LAH8QcfE9Hln0FWNryE7CLNcQ8ADQvN4Xjvp7YNixx6
 WAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730144583; x=1730749383;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W9B2eQxTpuEKGl0PAWsJqClqX9CksyCGAsH4ysZnUpA=;
 b=h+DnrDXdTp2M3mjTwRDAQqFCKdacYxNIg7fkwDpx0ZmNxB+O+BukITw76SkIdIDSMV
 66H5Q7XS8lVl9oD99rRIrGz0EIrtYLrcZNbRi0/q8jiW7KH45BdE75E3hnm1WfUUKD5T
 7RG35bZlDolTZAyo9KEvg0PIjDqmPhmOnG54L4E17PcP5hV+DmQaNAKuEXTeOBUkp+N6
 /fsChNqfI/1pLYBQS3fjgTaS7dxSuS6ulmZ8cEBB2crCQwTZOfKksI9OdOe+xRbFRtVs
 Pe8+1T78LeITLex0MqOlk79HySyGywW3zJg23DUpx5YSXTH0H/RI3uUmkmb4I6H53WrV
 86qA==
X-Gm-Message-State: AOJu0YwbTZkcRFC26hwYrwoq0/5HLaFsn1pRwJSruE61zLybqqr9eXLB
 OcR6DZPpBM6avI0YbC1PtaauQHfErBQwXqT7d6nZ3O/+p2B46fQt77ypE1CaZR6Nu1SaOcQtTA2
 DBkH37I/KEnSwdXHO1dYf7chZ8FpcwX2I
X-Google-Smtp-Source: AGHT+IEzrgbq0z94sM2CfU+Du7VbxGRGLzuXuvxsdtHb9eMmIkXg+J3Wz3E5wtNK6ePNr1lO+AMnAG25cBCMWTURBxo=
X-Received: by 2002:a05:6a00:9aa:b0:71e:66bb:d34a with SMTP id
 d2e1a72fcca58-72062ebaeddmr5460794b3a.2.1730144582737; Mon, 28 Oct 2024
 12:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-26-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-26-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:42:51 -0400
Message-ID: <CADnq5_MDPeLgwr_SzUgEoXKSA40C2FedJPpy+jH09Y_FRvci3w@mail.gmail.com>
Subject: Re: [PATCH 25/29] drm/amdgpu: resume for each vcn instance
To: boyuan.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
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

On Thu, Oct 24, 2024 at 10:48=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Pass instance parameter to amdgpu_vcn_resume(), and perform
> resume ONLY for the given vcn instance, instead of for all
> vcn instances. Modify each vcn generation accordingly.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 60 ++++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  4 +-
>  10 files changed, 47 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 50047c636904..c4e1283aa9a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -335,47 +335,47 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev, =
int inst)
>         return amdgpu_vcn_save_vcpu_bo(adev, inst);
>  }
>
> -int amdgpu_vcn_resume(struct amdgpu_device *adev)
> +int amdgpu_vcn_resume(struct amdgpu_device *adev, int inst)
>  {
>         unsigned int size;
>         void *ptr;
> -       int i, idx;
> +       int idx;
> +
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return 0;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> -               if (adev->vcn.inst[i].vcpu_bo =3D=3D NULL)
> -                       return -EINVAL;
> +       if (adev->vcn.inst[inst].vcpu_bo =3D=3D NULL)
> +               return -EINVAL;
> +
> +       size =3D amdgpu_bo_size(adev->vcn.inst[inst].vcpu_bo);
> +       ptr =3D adev->vcn.inst[inst].cpu_addr;
>
> -               size =3D amdgpu_bo_size(adev->vcn.inst[i].vcpu_bo);
> -               ptr =3D adev->vcn.inst[i].cpu_addr;
> +       if (adev->vcn.inst[inst].saved_bo !=3D NULL) {
> +               if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +                       memcpy_toio(ptr, adev->vcn.inst[inst].saved_bo, s=
ize);
> +                       drm_dev_exit(idx);
> +               }
> +               kvfree(adev->vcn.inst[inst].saved_bo);
> +               adev->vcn.inst[inst].saved_bo =3D NULL;
> +       } else {
> +               const struct common_firmware_header *hdr;
> +               unsigned int offset;
>
> -               if (adev->vcn.inst[i].saved_bo !=3D NULL) {
> +               hdr =3D (const struct common_firmware_header *)adev->vcn.=
inst[inst].fw->data;
> +               if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP) {
> +                       offset =3D le32_to_cpu(hdr->ucode_array_offset_by=
tes);
>                         if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -                               memcpy_toio(ptr, adev->vcn.inst[i].saved_=
bo, size);
> +                               memcpy_toio(adev->vcn.inst[inst].cpu_addr=
,
> +                                               adev->vcn.inst[inst].fw->=
data + offset,
> +                                               le32_to_cpu(hdr->ucode_si=
ze_bytes));
>                                 drm_dev_exit(idx);
>                         }
> -                       kvfree(adev->vcn.inst[i].saved_bo);
> -                       adev->vcn.inst[i].saved_bo =3D NULL;
> -               } else {
> -                       const struct common_firmware_header *hdr;
> -                       unsigned int offset;
> -
> -                       hdr =3D (const struct common_firmware_header *)ad=
ev->vcn.inst[i].fw->data;
> -                       if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_=
PSP) {
> -                               offset =3D le32_to_cpu(hdr->ucode_array_o=
ffset_bytes);
> -                               if (drm_dev_enter(adev_to_drm(adev), &idx=
)) {
> -                                       memcpy_toio(adev->vcn.inst[i].cpu=
_addr,
> -                                                   adev->vcn.inst[i].fw-=
>data + offset,
> -                                                   le32_to_cpu(hdr->ucod=
e_size_bytes));
> -                                       drm_dev_exit(idx);
> -                               }
> -                               size -=3D le32_to_cpu(hdr->ucode_size_byt=
es);
> -                               ptr +=3D le32_to_cpu(hdr->ucode_size_byte=
s);
> -                       }
> -                       memset_io(ptr, 0, size);
> +                       size -=3D le32_to_cpu(hdr->ucode_size_bytes);
> +                       ptr +=3D le32_to_cpu(hdr->ucode_size_bytes);
>                 }
> +               memset_io(ptr, 0, size);
>         }
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index be681bcab184..75cfdb770672 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -487,7 +487,7 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev,=
 int inst);
>  int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
>  int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst);
>  int amdgpu_vcn_suspend(struct amdgpu_device *adev, int inst);
> -int amdgpu_vcn_resume(struct amdgpu_device *adev);
> +int amdgpu_vcn_resume(struct amdgpu_device *adev, int inst);
>  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
>  void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index a3845e7747b0..77f9f34eaca8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -156,7 +156,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *i=
p_block)
>
>         amdgpu_vcn_setup_ucode(adev);
>
> -       r =3D amdgpu_vcn_resume(adev);
> +       r =3D amdgpu_vcn_resume(adev, inst);
>         if (r)
>                 return r;
>
> @@ -331,7 +331,7 @@ static int vcn_v1_0_resume(struct amdgpu_ip_block *ip=
_block)
>  {
>         int r;
>
> -       r =3D amdgpu_vcn_resume(ip_block->adev);
> +       r =3D amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_0.c
> index 8e943d1fae17..87293bb777d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -161,7 +161,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *i=
p_block)
>
>         amdgpu_vcn_setup_ucode(adev);
>
> -       r =3D amdgpu_vcn_resume(adev);
> +       r =3D amdgpu_vcn_resume(adev, inst);
>         if (r)
>                 return r;
>
> @@ -359,7 +359,7 @@ static int vcn_v2_0_resume(struct amdgpu_ip_block *ip=
_block)
>  {
>         int r;
>
> -       r =3D amdgpu_vcn_resume(ip_block->adev);
> +       r =3D amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index 9ca07e56b052..62266db72531 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -191,7 +191,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *i=
p_block)
>
>         amdgpu_vcn_setup_ucode(adev);
>
> -       r =3D amdgpu_vcn_resume(adev);
> +       r =3D amdgpu_vcn_resume(adev, inst);
>         if (r)
>                 return r;
>
> @@ -436,7 +436,7 @@ static int vcn_v2_5_resume(struct amdgpu_ip_block *ip=
_block)
>  {
>         int r;
>
> -       r =3D amdgpu_vcn_resume(ip_block->adev);
> +       r =3D amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index a25d2b9784be..d29c49d061d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -174,7 +174,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *i=
p_block)
>
>         amdgpu_vcn_setup_ucode(adev);
>
> -       r =3D amdgpu_vcn_resume(adev);
> +       r =3D amdgpu_vcn_resume(adev, inst);
>         if (r)
>                 return r;
>
> @@ -468,7 +468,7 @@ static int vcn_v3_0_resume(struct amdgpu_ip_block *ip=
_block)
>  {
>         int r;
>
> -       r =3D amdgpu_vcn_resume(ip_block->adev);
> +       r =3D amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index fcf7b23cca90..509dc6b5f43b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -182,7 +182,7 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *i=
p_block)
>
>         amdgpu_vcn_setup_ucode(adev);
>
> -       r =3D amdgpu_vcn_resume(adev);
> +       r =3D amdgpu_vcn_resume(adev, inst);
>         if (r)
>                 return r;
>
> @@ -396,7 +396,7 @@ static int vcn_v4_0_resume(struct amdgpu_ip_block *ip=
_block)
>  {
>         int r;
>
> -       r =3D amdgpu_vcn_resume(ip_block->adev);
> +       r =3D amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index ece9b1df2743..070cf516f365 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -139,7 +139,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block =
*ip_block)
>
>         amdgpu_vcn_setup_ucode(adev);
>
> -       r =3D amdgpu_vcn_resume(adev);
> +       r =3D amdgpu_vcn_resume(adev, inst);
>         if (r)
>                 return r;
>
> @@ -355,7 +355,7 @@ static int vcn_v4_0_3_resume(struct amdgpu_ip_block *=
ip_block)
>  {
>         int r;
>
> -       r =3D amdgpu_vcn_resume(ip_block->adev);
> +       r =3D amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index f1ec632a9eb8..ad9e67d9134d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -144,7 +144,7 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block =
*ip_block)
>
>         amdgpu_vcn_setup_ucode(adev);
>
> -       r =3D amdgpu_vcn_resume(adev);
> +       r =3D amdgpu_vcn_resume(adev, inst);
>         if (r)
>                 return r;
>
> @@ -347,7 +347,7 @@ static int vcn_v4_0_5_resume(struct amdgpu_ip_block *=
ip_block)
>  {
>         int r;
>
> -       r =3D amdgpu_vcn_resume(ip_block->adev);
> +       r =3D amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index fdfb3084d54e..9999c8094920 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -128,7 +128,7 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block =
*ip_block)
>
>         amdgpu_vcn_setup_ucode(adev);
>
> -       r =3D amdgpu_vcn_resume(adev);
> +       r =3D amdgpu_vcn_resume(adev, inst);
>         if (r)
>                 return r;
>
> @@ -311,7 +311,7 @@ static int vcn_v5_0_0_resume(struct amdgpu_ip_block *=
ip_block)
>  {
>         int r;
>
> -       r =3D amdgpu_vcn_resume(ip_block->adev);
> +       r =3D amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
>         if (r)
>                 return r;
>
> --
> 2.34.1
>
