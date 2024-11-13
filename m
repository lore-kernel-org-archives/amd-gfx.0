Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6712BD41C07
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 06:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12B6610E1CA;
	Wed, 13 Nov 2024 06:11:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ksxBNdCI";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0991610E1CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 06:11:56 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2e9a5ee0384so161922a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 22:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731478315; x=1732083115; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nH94kpo1yN9Kg0Ka1xwg9YyTpyD5i/OgylvVHOUBd0g=;
 b=ksxBNdCI01gj9pFRNz74IJmuUOY65M709+O7EIQwawzXxYRhFWZdjKTIOWcKJgegeb
 xkDHN+AuRp1+YK7twZXtfQ8tlsFmT2dsBNWDHKjQvQdQDW8tNTHyobJYbS/0lbFwJEWW
 PKoG4oRGeoOzzJFI++yD60bHS9xRbFaNhkGngFibvvoGAzqYK1v0iOM720y3iaM7ZFEn
 mA96PUDIDWcBiJZfKwNz+Y/C6ctkAdns/bGVuPSGVHKhqS1TNxgtACTCWDh84k4ThL+S
 9zt3yRFOcMCAGGMb4m0yGsRxtO+lVU5StokMvD44d1eenk9JPGdBDpFaLxD65SK6f9IM
 Fpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731478315; x=1732083115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nH94kpo1yN9Kg0Ka1xwg9YyTpyD5i/OgylvVHOUBd0g=;
 b=UrlSAIjOMkedWyXsfFFGZk1Ji1KJBXCYnWEU9HF3yXFErsq2xpJ3PTiXwZ9Ou5RVbh
 Q002kq5YnWvzxX48yF42txTiOVYQioPq0Q272RK06Mvuox9YHTjiesvBcoS4YWXt0IkB
 O1k2byJ8crikDZp7SbYpR2gyvYLemyFGf/pblaWeJzjH68nYgr4bz9mmNi5Q03A+6J5y
 Wg5jbcUQMz27sIpv91qL9mgb4rbCxDCi8GUlM/pEU8slY0ciza80B/JVgo9Vn5jOCx93
 Daisjsp62sySkzoj/68YVjkDLELh5Sub6ggNPeMDIiYr8culMjCSGjPOuXRYs3lwzBxY
 2Fdw==
X-Gm-Message-State: AOJu0YxNmU/CNwkw+J92+x6z2wSf1kSKJPO0Bg2XPTasv2qslBYALpke
 0S9NYXzOKKDi7gWsFgcUIbGQv8vyyxf0JYnYl4yQdOGu2sCJtVvA1CXLvhdF7ZZebvWfXmpAzDv
 IWGGhvYwGbdiegsGIfq91QhBXHRY=
X-Google-Smtp-Source: AGHT+IET30F+OTrE1eqVOdZTzQ8xQYmAhQ95b7XJAQ0jrcbCrPUS0zFWKdJoZrk9lAMa8wEj8ngLLpTaTa06quFj5GM=
X-Received: by 2002:a17:90b:3ec4:b0:2e2:c423:8e16 with SMTP id
 98e67ed59e1d1-2e9b14c7c8amr10565777a91.1.1731478315278; Tue, 12 Nov 2024
 22:11:55 -0800 (PST)
MIME-Version: 1.0
References: <20241113053221.1992865-1-jesse.zhang@amd.com>
In-Reply-To: <20241113053221.1992865-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Nov 2024 01:11:43 -0500
Message-ID: <CADnq5_OZkM7LqxcNh7rAE1PwnBp_RoD3UEFP=AKuOy7am6YvPg@mail.gmail.com>
Subject: Re: [PATCH V2] drm/admgpu: fix vcn reset sysfs warning
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, vitaly.prosyak@amd.com,
 Tim.Huang@amd.com
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

On Wed, Nov 13, 2024 at 12:44=E2=80=AFAM Jesse.zhang@amd.com
<jesse.zhang@amd.com> wrote:
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:01.1=
/0000:01:00.0/0000:02:00.0/0000:03:00.0/vcn_reset_mask'
> [  562.443738] CPU: 13 PID: 4888 Comm: modprobe Tainted: G            E  =
    6.10.0+ #51
> [  562.443740] Hardware name: AMD Splinter/Splinter-RPL, BIOS VS2683299N.=
FD 05/10/2023
> [  562.443741] Call Trace:
> [  562.443743]  <TASK>
> [  562.443746]  dump_stack_lvl+0x70/0x90
> [  562.443751]  dump_stack+0x14/0x20
> [  562.443753]  sysfs_warn_dup+0x60/0x80
> [  562.443757]  sysfs_add_file_mode_ns+0x126/0x130
> [  562.443760]  sysfs_create_file_ns+0x68/0xa0
> [  562.443762]  device_create_file+0x46/0x90
> [  562.443766]  amdgpu_vcn_sysfs_reset_mask_init+0x1c/0x30 [amdgpu]
> [  562.443991]  vcn_v4_0_3_sw_init+0x270/0x3e0 [amdgpu]
> [  562.444120]  amdgpu_device_init+0x1a0e/0x35a0 [amdgpu]
> [  562.444227]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  562.444230]  ? pci_read_config_word+0x2d/0x50
> [  562.444235]  amdgpu_driver_load_kms+0x1e/0xc0 [amdgpu]
> [  562.444340]  amdgpu_pci_probe+0x1c3/0x660 [amdgpu]
> [  562.444451]  local_pci_probe+0x4c/0xb0
>
> For multiple vcn instances, to avoid creating reset sysfs multiple times,
> add the instance paramter in reset mask init.

parameter.

>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

What changed with V2?  This looks the same as the original patch.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  8 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 10 ++++------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  4 ++--
>  5 files changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 25f490ad3a85..1d4eda649845 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1295,11 +1295,11 @@ static ssize_t amdgpu_get_vcn_reset_mask(struct d=
evice *dev,
>  static DEVICE_ATTR(vcn_reset_mask, 0444,
>                    amdgpu_get_vcn_reset_mask, NULL);
>
> -int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
> +int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev, int ins=
t)
>  {
>         int r =3D 0;
>
> -       if (adev->vcn.num_vcn_inst) {
> +       if (inst =3D=3D 0) {
>                 r =3D device_create_file(adev->dev, &dev_attr_vcn_reset_m=
ask);
>                 if (r)
>                         return r;
> @@ -1308,12 +1308,12 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct amdgp=
u_device *adev)
>         return r;
>  }
>
> -void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
> +void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev, int in=
st)
>  {
>         int idx;
>
>         if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -               if (adev->vcn.num_vcn_inst)
> +               if (inst =3D=3D 0)
>                         device_remove_file(adev->dev, &dev_attr_vcn_reset=
_mask);
>                 drm_dev_exit(idx);
>         }

I was thinking something more like:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 25f490ad3a85..5e6cf8d08a6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1295,26 +1295,49 @@ static ssize_t
amdgpu_get_vcn_reset_mask(struct device *dev,
 static DEVICE_ATTR(vcn_reset_mask, 0444,
                   amdgpu_get_vcn_reset_mask, NULL);

-int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
+int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev, int inst)
 {
        int r =3D 0;

        if (adev->vcn.num_vcn_inst) {
-               r =3D device_create_file(adev->dev, &dev_attr_vcn_reset_mas=
k);
-               if (r)
-                       return r;
+               switch (inst) {
+               case 0:
+                       r =3D device_create_file(adev->dev,
&dev_attr_vcn_reset_mask);
+                       if (r)
+                               return r;
+                       break;
+               case 1:
+                       r =3D device_create_file(adev->dev,
&dev_attr_vcn1_reset_mask);
+                       if (r)
+                               return r;
+                       break;
+               case 2:
+                       r =3D device_create_file(adev->dev,
&dev_attr_vcn2_reset_mask);
+                       if (r)
+                               return r;
+                       break;
+                       ...
+               }
        }

        return r;
 }

-void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
+void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev, int inst=
)
 {
        int idx;

        if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-               if (adev->vcn.num_vcn_inst)
-                       device_remove_file(adev->dev, &dev_attr_vcn_reset_m=
ask);
+               if (adev->vcn.num_vcn_inst) {
+                       switch (inst) {
+                       case 0:
+                               device_remove_file(adev->dev,
&dev_attr_vcn_reset_mask);
+                               break;
+                       case 1:
+                               device_remove_file(adev->dev,
&dev_attr_vcn1_reset_mask);
+                               break;
+                               ...
+                       }
                drm_dev_exit(idx);
        }
 }

Alex


> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index 7ff4ae2a0432..9b10044c61a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -519,7 +519,7 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev=
);
>  int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
>                                enum AMDGPU_UCODE_ID ucode_id);
>  int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev, int inst);
> -int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev);
> -void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev);
> +int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev, int ins=
t);
> +void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev, int in=
st);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 59f83409d323..109b27904984 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -250,11 +250,9 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *=
ip_block)
>                 ip_block->ip_dump =3D ptr;
>         }
>
> -       if (inst =3D=3D 0) {
> -               r =3D amdgpu_vcn_sysfs_reset_mask_init(adev);
> -               if (r)
> -                       return r;
> -       }
> +       r =3D amdgpu_vcn_sysfs_reset_mask_init(adev, inst);
> +       if (r)
> +               return r;
>
>         return 0;
>  }
> @@ -292,7 +290,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *i=
p_block)
>         if (r)
>                 return r;
>
> -       amdgpu_vcn_sysfs_reset_mask_fini(adev);
> +       amdgpu_vcn_sysfs_reset_mask_fini(adev, inst);
>         r =3D amdgpu_vcn_sw_fini(adev, inst);
>
>         kfree(ip_block->ip_dump);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index e9b869f373c9..ef3dfd44a022 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -217,7 +217,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block =
*ip_block)
>                 ip_block->ip_dump =3D ptr;
>         }
>
> -       r =3D amdgpu_vcn_sysfs_reset_mask_init(adev);
> +       r =3D amdgpu_vcn_sysfs_reset_mask_init(adev, inst);
>         if (r)
>                 return r;
>
> @@ -254,7 +254,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block =
*ip_block)
>         if (r)
>                 return r;
>
> -       amdgpu_vcn_sysfs_reset_mask_fini(adev);
> +       amdgpu_vcn_sysfs_reset_mask_fini(adev, inst);
>         r =3D amdgpu_vcn_sw_fini(adev, inst);
>
>         kfree(ip_block->ip_dump);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 96ec01cffea3..8f9c19c68d88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -186,7 +186,7 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block =
*ip_block)
>                 ip_block->ip_dump =3D ptr;
>         }
>
> -       r =3D amdgpu_vcn_sysfs_reset_mask_init(adev);
> +       r =3D amdgpu_vcn_sysfs_reset_mask_init(adev, inst);
>         if (r)
>                 return r;
>
> @@ -223,7 +223,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block =
*ip_block)
>         if (r)
>                 return r;
>
> -       amdgpu_vcn_sysfs_reset_mask_fini(adev);
> +       amdgpu_vcn_sysfs_reset_mask_fini(adev, inst);
>         r =3D amdgpu_vcn_sw_fini(adev, inst);
>
>         kfree(ip_block->ip_dump);
> --
> 2.25.1
>
