Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1892AECE57E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 21:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B347310E6CE;
	Mon,  9 Sep 2024 21:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ppm5DUt1";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A961C10E6CE
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 21:36:53 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-71829963767so291697b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725917813; x=1726522613; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYBpvSwTmkG0T2ZaIk0/QA4ySWy5IuZZF4kcausKqh8=;
 b=Ppm5DUt1pnXfGeYDeONvIxgH8LgEBjB8mCyfvTvU5gGRh7pv1hj+E77bmtM7AwEsqa
 gmdTZLhGZaP/w0KRKuOX9pObNaAe5XtA+sO5dYKBYY8+z20ZsNww+de04dlhkJSBN2Ai
 stKjyNfFiJoMZ24l8k9/GIiOS4RmZ1sN43Z2ZuhjRgrOrRAdTh77Qwg1Qq0ekZOLLTa0
 amUmZKcSSdNd0/A5xOyX0RcBRMI9+IQWtuhc+kCL0c54q9YQJGqYGFOo+A2aPw9tkqfs
 /e3YIINsF/VWRiSBf/mO/cEyoMoDXCo7ZPzGXPOjx4gK5WvR4QFhhXQW/cFVpE5Pc4kq
 AlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725917813; x=1726522613;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYBpvSwTmkG0T2ZaIk0/QA4ySWy5IuZZF4kcausKqh8=;
 b=uk/W+jfLv2VPqS5uKRCLFB0tY5SpQBlcjOg9LgdNZoplwKeWT2QTTr7o/Gg86Yi+Nb
 D9lbC6zv4evJzOAup3qwhEyyS8ZpADQ/+FpjRv6Ugq24MmKPQsJKW6NS99NUBJJTKICC
 jwdVObt8wAcKh0yFxzvx1/kAEARyMZip5CORJ5Rf/aZs/GHlKDppaWPRc3qX40slmTJH
 Zx4f6aksmoXs9o5hkwmD1RPy0oapHibE/XNQmkOG0T1fWJnUw2etk8/ladyP/7izOkeb
 JJQL4BCw5P6YFv/OCCPq2+JIYMdajTuWWOrdp5qpMD17g/yI2r6mpu0A7AQoq9KWUnXw
 q20g==
X-Gm-Message-State: AOJu0Yw3d9oScm+W/jAxx7hJJRiYH9V8bTZvjl42VfVz7jzRxmQ+dsom
 +pD0kP4ygxqqPmiG/lp0Hs27jvgVHeH+pfZ9N1d5kJ7QTqukBci2GYlzcbPgrdgICaVbu+JP/IY
 EM5CtB+Ai7mQO8uRKxBQCO3BDgmQ=
X-Google-Smtp-Source: AGHT+IGh3QgwqNk7HFwGNo/T2wGF7mCwpG87xUNhmOFwrzOBDRqK9j8wTEXU1CAVKqoHOvXHuhilVz9P2ZDDsLaHRxQ=
X-Received: by 2002:a05:6a00:2193:b0:70a:efec:6b88 with SMTP id
 d2e1a72fcca58-718d5f5ba65mr6692208b3a.3.1725917813080; Mon, 09 Sep 2024
 14:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
 <20240902073417.2025971-8-lijo.lazar@amd.com>
In-Reply-To: <20240902073417.2025971-8-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Sep 2024 17:36:41 -0400
Message-ID: <CADnq5_MoGFgsjqFS1CuuJPapTU3yRUqaTVRbNd3f7mqtpcpT3A@mail.gmail.com>
Subject: Re: [PATCH 07/10] drm/amdgpu: Drop delayed reset work handler
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com
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

On Mon, Sep 2, 2024 at 3:34=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> Drop delayed reset work handler as it is no longer used.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 80 -------------------------
>  2 files changed, 84 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index d17506d9adae..9285108d537f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -131,10 +131,6 @@ struct amdgpu_mgpu_info {
>         uint32_t                        num_gpu;
>         uint32_t                        num_dgpu;
>         uint32_t                        num_apu;
> -
> -       /* delayed reset_func for XGMI configuration if necessary */
> -       struct delayed_work             delayed_reset_work;
> -       bool                            pending_reset;
>  };
>
>  enum amdgpu_ss {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 3dece2e69608..4f644b120df7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -221,8 +221,6 @@ int amdgpu_wbrf =3D -1;
>  int amdgpu_damage_clips =3D -1; /* auto */
>  int amdgpu_umsch_mm_fwlog;
>
> -static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *wo=
rk);
> -
>  DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, =
0,
>                         "DRM_UT_CORE",
>                         "DRM_UT_DRIVER",
> @@ -237,9 +235,6 @@ DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_T=
YPE_DISJOINT_BITS, 0,
>
>  struct amdgpu_mgpu_info mgpu_info =3D {
>         .mutex =3D __MUTEX_INITIALIZER(mgpu_info.mutex),
> -       .delayed_reset_work =3D __DELAYED_WORK_INITIALIZER(
> -                       mgpu_info.delayed_reset_work,
> -                       amdgpu_drv_delayed_reset_work_handler, 0),
>  };
>  int amdgpu_ras_enable =3D -1;
>  uint amdgpu_ras_mask =3D 0xffffffff;
> @@ -2455,81 +2450,6 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
>         adev->mp1_state =3D PP_MP1_STATE_NONE;
>  }
>
> -/**
> - * amdgpu_drv_delayed_reset_work_handler - work handler for reset
> - *
> - * @work: work_struct.
> - */
> -static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *wo=
rk)
> -{
> -       struct list_head device_list;
> -       struct amdgpu_device *adev;
> -       int i, r;
> -       struct amdgpu_reset_context reset_context;
> -
> -       memset(&reset_context, 0, sizeof(reset_context));
> -
> -       mutex_lock(&mgpu_info.mutex);
> -       if (mgpu_info.pending_reset =3D=3D true) {
> -               mutex_unlock(&mgpu_info.mutex);
> -               return;
> -       }
> -       mgpu_info.pending_reset =3D true;
> -       mutex_unlock(&mgpu_info.mutex);
> -
> -       /* Use a common context, just need to make sure full reset is don=
e */
> -       reset_context.method =3D AMD_RESET_METHOD_NONE;
> -       set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
> -
> -       for (i =3D 0; i < mgpu_info.num_dgpu; i++) {
> -               adev =3D mgpu_info.gpu_ins[i].adev;
> -               reset_context.reset_req_dev =3D adev;
> -               r =3D amdgpu_device_pre_asic_reset(adev, &reset_context);
> -               if (r) {
> -                       dev_err(adev->dev, "GPU pre asic reset failed wit=
h err, %d for drm dev, %s ",
> -                               r, adev_to_drm(adev)->unique);
> -               }
> -               if (!queue_work(system_unbound_wq, &adev->xgmi_reset_work=
))
> -                       r =3D -EALREADY;
> -       }
> -       for (i =3D 0; i < mgpu_info.num_dgpu; i++) {
> -               adev =3D mgpu_info.gpu_ins[i].adev;
> -               flush_work(&adev->xgmi_reset_work);
> -       }
> -
> -       /* reset function will rebuild the xgmi hive info , clear it now =
*/
> -       for (i =3D 0; i < mgpu_info.num_dgpu; i++)
> -               amdgpu_xgmi_remove_device(mgpu_info.gpu_ins[i].adev);
> -
> -       INIT_LIST_HEAD(&device_list);
> -
> -       for (i =3D 0; i < mgpu_info.num_dgpu; i++)
> -               list_add_tail(&mgpu_info.gpu_ins[i].adev->reset_list, &de=
vice_list);
> -
> -       /* unregister the GPU first, reset function will add them back */
> -       list_for_each_entry(adev, &device_list, reset_list)
> -               amdgpu_unregister_gpu_instance(adev);
> -
> -       /* Use a common context, just need to make sure full reset is don=
e */
> -       set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
> -       set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
> -       r =3D amdgpu_do_asic_reset(&device_list, &reset_context);
> -
> -       if (r) {
> -               DRM_ERROR("reinit gpus failure");
> -               return;
> -       }
> -       for (i =3D 0; i < mgpu_info.num_dgpu; i++) {
> -               adev =3D mgpu_info.gpu_ins[i].adev;
> -               if (!adev->kfd.init_complete) {
> -                       kgd2kfd_init_zone_device(adev);
> -                       amdgpu_amdkfd_device_init(adev);
> -                       amdgpu_amdkfd_drm_client_create(adev);
> -               }
> -               amdgpu_ttm_set_buffer_funcs_status(adev, true);
> -       }
> -}
> -
>  static int amdgpu_pmops_prepare(struct device *dev)
>  {
>         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> --
> 2.25.1
>
