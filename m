Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24E2D6B6D1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2024 20:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6987C10E7F9;
	Wed, 30 Oct 2024 20:11:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GklhMRW0";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 343A810E7F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2024 20:11:22 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-7ee36621734so38151a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2024 13:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730319081; x=1730923881; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bj0b5WkO3/3y0cEjgaM8LVufAxr7V5ZvKvdXjUHMIC0=;
 b=GklhMRW0vvCRkzu40YJzBaTwgAKS7Lz0j6HAVtplj56+ZYLvXN8Z/2LIqf3QhXnWlb
 eUfJdjUXCNWOuQor40Zm7Hp1Roci2QVOcYhT9SlXDpZTYtX6H8tuJs3KImmFLqxB21el
 ZnNSlcGyj0QexydEIoxOxjE1lpXjUeN+qPYj/0DmJuaXBdfVDcSu9UkaOgApAJLtFtbK
 XO44Dvf+CU4UW+Zik2bUC3OA/Q4o+AB8D4Dx1HltpNOZp8sRjnQdpLKUIShBtefoSQzj
 s3oTB9UM3Vw4Pc9MpKNSzSTTKOgB/+c3PtLs81gGwFWkgcBLc/eH1EWK8DvWxk9lrf1Z
 DT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730319081; x=1730923881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bj0b5WkO3/3y0cEjgaM8LVufAxr7V5ZvKvdXjUHMIC0=;
 b=EYFzBWi9E5TIC4LjIDiTCliA0kfENLvXUoKM4TLGyknsNxLH31npXJuwmYxRIbam+r
 3UQCH2OsQTm2rmxZr4tQZpn92iEFkWSVx2SDtsN0lgHFFgt1QkLx/sB9sRkIhWUWLL4W
 7UdTf8m0Umvet8YQryKNLeMRSZwE3rpgDhFbtJcH8EXkIoeBqUGicIu/U8v4xMX1hVtA
 jxUrUZExHH4nAzVho5HrYp7Ko23UCh9ShB3JNIQdr1b+ccNBPxjtDPzCGHmMhkEo82nw
 gQgkKFyl880Mc6A44GrVjNiCU8wi14UtTLDtvZVqwGcu4EWQRD/BiMXpnCXKtb02855t
 eU4A==
X-Gm-Message-State: AOJu0YySPHbVDvMfh3IbJkD8oq7UYziuJL410Mx+WAwkNaMFsltAbvq2
 bR2/svmf+klk4YRvgTj5MLctnmlh+3lFosgZ7C9ttvVhIEJptvELyye2cIDMkXZgTTJf9umXiF8
 jKNWEjmT7mc/FNkwZ6bDb+ocFWls=
X-Google-Smtp-Source: AGHT+IG9rUCgHYBH9gOQGyhF30eTbtwFUh6Ooui7/DoYYg4hOaIkCYKOl2vERAOExQpPOV+ZBPjlwWsoc1RaVSY02yQ=
X-Received: by 2002:a05:6a00:2392:b0:71e:7bcc:a0de with SMTP id
 d2e1a72fcca58-72063028f5cmr9726475b3a.3.1730319081437; Wed, 30 Oct 2024
 13:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20241030041832.3179034-1-lijo.lazar@amd.com>
In-Reply-To: <20241030041832.3179034-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Oct 2024 16:11:09 -0400
Message-ID: <CADnq5_P6gczLZo0KQ_U_2GqiWMMXRQohUEG7Oh7CAg1f_-aySQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Group gfx sysfs functions
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, 
 srinivasan.shanmugam@amd.com
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

On Wed, Oct 30, 2024 at 12:19=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wr=
ote:
>
> Make amdgpu_gfx_sysfs_init/fini functions as common entry points for all
> gfx related sysfs nodes.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
> v2: Check cleaner shader capability only for creation of run_cleaner_shad=
er
> attribute.
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 36 ++++++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 --
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  5 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  4 +--
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |  4 +--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  4 +--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  5 ----
>  7 files changed, 39 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index e96984c53e72..9ede3fbba54d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1602,7 +1602,7 @@ static DEVICE_ATTR(current_compute_partition, 0644,
>  static DEVICE_ATTR(available_compute_partition, 0444,
>                    amdgpu_gfx_get_available_compute_partition, NULL);
>
> -int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
> +static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
>  {
>         struct amdgpu_xcp_mgr *xcp_mgr =3D adev->xcp_mgr;
>         bool xcp_switch_supported;
> @@ -1629,7 +1629,7 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *ade=
v)
>         return r;
>  }
>
> -void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
> +static void amdgpu_gfx_sysfs_xcp_fini(struct amdgpu_device *adev)
>  {
>         struct amdgpu_xcp_mgr *xcp_mgr =3D adev->xcp_mgr;
>         bool xcp_switch_supported;
> @@ -1646,14 +1646,13 @@ void amdgpu_gfx_sysfs_fini(struct amdgpu_device *=
adev)
>                                    &dev_attr_available_compute_partition)=
;
>  }
>
> -int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
> +static int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *=
adev)
>  {
>         int r;
>
>         r =3D device_create_file(adev->dev, &dev_attr_enforce_isolation);
> -       if (r)
> +       if (r || !adev->gfx.enable_cleaner_shader)
>                 return r;
> -

Would be easier to read as:

if (adev->gfx.enable_cleaner_shader) {
    r =3D device_create_file(adev->dev, &dev_attr_run_cleaner_shader);
    if (r)
        return r;
}

>         r =3D device_create_file(adev->dev, &dev_attr_run_cleaner_shader)=
;
>         if (r)
>                 return r;
> @@ -1661,12 +1660,37 @@ int amdgpu_gfx_sysfs_isolation_shader_init(struct=
 amdgpu_device *adev)
>         return 0;
>  }
>
> -void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
> +static void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device =
*adev)
>  {
>         device_remove_file(adev->dev, &dev_attr_enforce_isolation);
> +       if (!adev->gfx.enable_cleaner_shader)
> +               return;

similarly here:

if (adev->gfx.enable_cleaner_shader)
    device_remove_file(adev->dev, &dev_attr_run_cleaner_shader);

With that changed, patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>         device_remove_file(adev->dev, &dev_attr_run_cleaner_shader);
>  }
>
> +int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
> +{
> +       int r;
> +
> +       r =3D amdgpu_gfx_sysfs_xcp_init(adev);
> +       if (r) {
> +               dev_err(adev->dev, "failed to create xcp sysfs files");
> +               return r;
> +       }
> +
> +       r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +       if (r)
> +               dev_err(adev->dev, "failed to create isolation sysfs file=
s");
> +
> +       return r;
> +}
> +
> +void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
> +{
> +       amdgpu_gfx_sysfs_xcp_fini(adev);
> +       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +}
> +
>  int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
>                                       unsigned int cleaner_shader_size)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index f710178a21bc..b8a2f60688dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -577,8 +577,6 @@ void amdgpu_gfx_cleaner_shader_sw_fini(struct amdgpu_=
device *adev);
>  void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
>                                     unsigned int cleaner_shader_size,
>                                     const void *cleaner_shader_ptr);
> -int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev);
> -void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev);
>  void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
>  void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *rin=
g);
>  void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)=
;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 9da95b25e158..d1a18ca584dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4853,9 +4853,10 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>         gfx_v10_0_alloc_ip_dump(adev);
>
> -       r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +       r =3D amdgpu_gfx_sysfs_init(adev);
>         if (r)
>                 return r;
> +
>         return 0;
>  }
>
> @@ -4907,7 +4908,7 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>                 gfx_v10_0_rlc_backdoor_autoload_buffer_fini(adev);
>
>         gfx_v10_0_free_microcode(adev);
> -       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +       amdgpu_gfx_sysfs_fini(adev);
>
>         kfree(adev->gfx.ip_dump_core);
>         kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 5aff8f72de9c..22811b624532 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1717,7 +1717,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>
>         gfx_v11_0_alloc_ip_dump(adev);
>
> -       r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +       r =3D amdgpu_gfx_sysfs_init(adev);
>         if (r)
>                 return r;
>
> @@ -1782,7 +1782,7 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>
>         gfx_v11_0_free_microcode(adev);
>
> -       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +       amdgpu_gfx_sysfs_fini(adev);
>
>         kfree(adev->gfx.ip_dump_core);
>         kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 9fec28d8a5fc..1b99f90cd193 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1466,7 +1466,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>
>         gfx_v12_0_alloc_ip_dump(adev);
>
> -       r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +       r =3D amdgpu_gfx_sysfs_init(adev);
>         if (r)
>                 return r;
>
> @@ -1529,7 +1529,7 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>
>         gfx_v12_0_free_microcode(adev);
>
> -       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +       amdgpu_gfx_sysfs_fini(adev);
>
>         kfree(adev->gfx.ip_dump_core);
>         kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index e9248a855ba7..a880dce16ae2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2402,7 +2402,7 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block =
*ip_block)
>
>         gfx_v9_0_alloc_ip_dump(adev);
>
> -       r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +       r =3D amdgpu_gfx_sysfs_init(adev);
>         if (r)
>                 return r;
>
> @@ -2443,7 +2443,7 @@ static int gfx_v9_0_sw_fini(struct amdgpu_ip_block =
*ip_block)
>         }
>         gfx_v9_0_free_microcode(adev);
>
> -       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +       amdgpu_gfx_sysfs_fini(adev);
>
>         kfree(adev->gfx.ip_dump_core);
>         kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index 016290f00592..983088805c3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1171,10 +1171,6 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
>
>         gfx_v9_4_3_alloc_ip_dump(adev);
>
> -       r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> -       if (r)
> -               return r;
> -
>         return 0;
>  }
>
> @@ -1199,7 +1195,6 @@ static int gfx_v9_4_3_sw_fini(struct amdgpu_ip_bloc=
k *ip_block)
>         amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
>         gfx_v9_4_3_free_microcode(adev);
>         amdgpu_gfx_sysfs_fini(adev);
> -       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>
>         kfree(adev->gfx.ip_dump_core);
>         kfree(adev->gfx.ip_dump_compute_queues);
> --
> 2.25.1
>
