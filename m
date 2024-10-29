Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4B9D5B176
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 13:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8498910E05E;
	Tue, 29 Oct 2024 13:30:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YOjiGSfQ";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8638310E05E
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 13:30:07 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-7ea6a4b3807so668336a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 06:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730208607; x=1730813407; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=difGgD5l1DnmGx6f668EEE5Oz/97OOpuOLlwJ75jb6s=;
 b=YOjiGSfQ+SuCZYZFRPJPgrRw5Pkzk8/PjuzdYdI1Xs3Go7K+YidPFDIpDN2RGcyr5t
 DD9F5nh3gRwebzoy03pJHNt2aIx34OtDK8ofRxvN67v4UhFpVf8CDRfSH6r8mvJmmzFn
 cYRCQYIImXeQz/tvZtoafNNuU71NuXudIrKLxAtwdLJvzmllPt2W/3ti7dsuPtdSvYe7
 2d1ys8yrKRkF59jAdouWDagi4ltJb1iqv65SD7tD6aGyCRYqLbf5xok7bPMWvcU5gW9D
 WRzWFG0DljYaLwJY9wWJfLzHOK2zGlvPhJjCitBqOAQ+bh2bOTJTbOE/JLrROO2no0h4
 1Bdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730208607; x=1730813407;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=difGgD5l1DnmGx6f668EEE5Oz/97OOpuOLlwJ75jb6s=;
 b=ceB6Mm93dF9iyFBo220YUTIzyeQ2DJ+nuwy68k/730eubzkhiOJLS9MIXXjPME26dI
 rUk10Ej6LzdfaQNafYqDrxS0FIQqjQ7ZKzejOsFQW2W7eeQl/u6n6UhUlI2NwTjVAcAt
 IyuIvEDEpFLf9zZvcdyapTnKYr/NAVjg0Y0IdNWWV/La7/iV97syfDYQad6uKYwdhSPD
 JOuO2CZdWalRxaI4GTG4xX5HRxlKhSW5XiH1WbzgED1kY4tMfjaV0ldDe2E+Tu0b77yo
 MyrqRliS/FnMiIoWBOaxw/VGgjJwOfHcnbXFn3ueTQ+kcXuHLJ88Pf7hgBUt5culwbyF
 wWDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+ltupYI2pAkNCbRF65iuSPfehutkzI2vNcMCXURbc0YItjThJW3gt1Uct6ni699mbLzvnkbvb@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHbQ4pP5ElvnNKlspmaNG/hiZPRQhSzY0r+WqPaNi81ox+MHMG
 nO/659rys83OXdjiyb9jyGbtuLtDvzr0A0a2Mw/4FffTnZuKaZqeqQR7LPMeebqJKzWdK2ksp6R
 uIkHhdjqco1JsiUBVEE9LPPdwaJQ9fw==
X-Google-Smtp-Source: AGHT+IGe7PUOYWFYWsi9YQ71jkf5xyDQYbhBugo9HA6h/yTh1kQ6S65M8Ak3m/LEpqmIioMOOvlKOfdDsVBv90va4YU=
X-Received: by 2002:a05:6a21:33a5:b0:1cf:4e49:bc74 with SMTP id
 adf61e73a8af0-1d9a84d79a1mr8031487637.9.1730208606720; Tue, 29 Oct 2024
 06:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241029052700.3164571-1-lijo.lazar@amd.com>
 <93ad9f9b-9803-4ba3-b29a-06b5c53b5ccd@amd.com>
 <c401ea1c-0b2f-4591-abe9-6a911c55b3a0@amd.com>
In-Reply-To: <c401ea1c-0b2f-4591-abe9-6a911c55b3a0@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Oct 2024 09:29:55 -0400
Message-ID: <CADnq5_NhWmJh-4uePmx3biZSAQT26nM_oyQoYzOrm2FQTMnikw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Group gfx sysfs functions
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org, 
 Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com
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

On Tue, Oct 29, 2024 at 2:58=E2=80=AFAM SRINIVASAN SHANMUGAM
<srinivasan.shanmugam@amd.com> wrote:
>
>
> On 10/29/2024 12:07 PM, SRINIVASAN SHANMUGAM wrote:
>
>
> On 10/29/2024 10:57 AM, Lijo Lazar wrote:
>
> Make amdgpu_gfx_sysfs_init/fini functions as common entry points for all
> gfx related sysfs nodes.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 37 ++++++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 --
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  5 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  4 +--
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |  4 +--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  4 +--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  5 ----
>  7 files changed, 42 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index e96984c53e72..86a6fd3015c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1602,7 +1602,7 @@ static DEVICE_ATTR(current_compute_partition, 0644,
>  static DEVICE_ATTR(available_compute_partition, 0444,
>     amdgpu_gfx_get_available_compute_partition, NULL);
>
> -int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
> +static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
>  {
>   struct amdgpu_xcp_mgr *xcp_mgr =3D adev->xcp_mgr;
>   bool xcp_switch_supported;
> @@ -1629,7 +1629,7 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *ade=
v)
>   return r;
>  }
>
> -void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
> +static void amdgpu_gfx_sysfs_xcp_fini(struct amdgpu_device *adev)
>  {
>   struct amdgpu_xcp_mgr *xcp_mgr =3D adev->xcp_mgr;
>   bool xcp_switch_supported;
> @@ -1646,10 +1646,13 @@ void amdgpu_gfx_sysfs_fini(struct amdgpu_device *=
adev)
>     &dev_attr_available_compute_partition);
>  }
>
> -int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
> +static int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *=
adev)
>  {
>   int r;
>
> + if (!adev->gfx.enable_cleaner_shader)
> + return 0;
> +
>
> This check seems to be incorrect here, because enforce_isolation and clea=
ner shader are two different entities, with this check enforce_isolation no=
de won't be created for some of the ASIC's where we don't load cleaner shad=
er explictly.
>
> Correction, this check "
>
> !adev->gfx.enable_cleaner_shader" handles for ASIC's where we don't load =
cleaner shader explictly, but having it here I'm not certain cz I think we =
expect enforce_isolation node to be created independent of run_cleaner_shad=
er, would request Alex/Christian, to comment onto it further.
>

We want sysfs enforce_isolation whether or not there is a cleaner
shader for a chip yet or not.  It's useful for serializing access to
gfx.  Before we added the cleaner shader stuff it was still a useful
option for certain use cases.

Alex

> -Srini
>
> And moreover this grouping, its better to be done for all sysfs entires i=
n amdgpu ie., not only gfx, for other modules like even pm etc., so that we=
 can have one common sysfs amdgpu framework, improving code consistency and=
 maintainability
>
> I had initiated this https://patchwork.freedesktop.org/patch/595215/ , bu=
t I couldn't finish it because of other work commitments.
>
>   r =3D device_create_file(adev->dev, &dev_attr_enforce_isolation);
>   if (r)
>   return r;
> @@ -1661,12 +1664,38 @@ int amdgpu_gfx_sysfs_isolation_shader_init(struct=
 amdgpu_device *adev)
>   return 0;
>  }
>
> -void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
> +static void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device =
*adev)
>  {
> + if (!adev->gfx.enable_cleaner_shader)
> + return;
> +
>
> Same here
>
> -Srini
>
>   device_remove_file(adev->dev, &dev_attr_enforce_isolation);
>   device_remove_file(adev->dev, &dev_attr_run_cleaner_shader);
>  }
>
> +int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
> +{
> + int r;
> +
> + r =3D amdgpu_gfx_sysfs_xcp_init(adev);
> + if (r) {
> + dev_err(adev->dev, "failed to create xcp sysfs files");
> + return r;
> + }
> +
> + r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> + if (r)
> + dev_err(adev->dev, "failed to create isolation sysfs files");
> +
> + return r;
> +}
> +
> +void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
> +{
> + amdgpu_gfx_sysfs_xcp_fini(adev);
> + amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +}
> +
>  int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
>        unsigned int cleaner_shader_size)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index f710178a21bc..b8a2f60688dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -577,8 +577,6 @@ void amdgpu_gfx_cleaner_shader_sw_fini(struct amdgpu_=
device *adev);
>  void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
>      unsigned int cleaner_shader_size,
>      const void *cleaner_shader_ptr);
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
>   gfx_v10_0_alloc_ip_dump(adev);
>
> - r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> + r =3D amdgpu_gfx_sysfs_init(adev);
>   if (r)
>   return r;
> +
>   return 0;
>  }
>
> @@ -4907,7 +4908,7 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>   gfx_v10_0_rlc_backdoor_autoload_buffer_fini(adev);
>
>   gfx_v10_0_free_microcode(adev);
> - amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> + amdgpu_gfx_sysfs_fini(adev);
>
>   kfree(adev->gfx.ip_dump_core);
>   kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 5aff8f72de9c..22811b624532 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1717,7 +1717,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>
>   gfx_v11_0_alloc_ip_dump(adev);
>
> - r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> + r =3D amdgpu_gfx_sysfs_init(adev);
>   if (r)
>   return r;
>
> @@ -1782,7 +1782,7 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>
>   gfx_v11_0_free_microcode(adev);
>
> - amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> + amdgpu_gfx_sysfs_fini(adev);
>
>   kfree(adev->gfx.ip_dump_core);
>   kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 9fec28d8a5fc..1b99f90cd193 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1466,7 +1466,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>
>   gfx_v12_0_alloc_ip_dump(adev);
>
> - r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> + r =3D amdgpu_gfx_sysfs_init(adev);
>   if (r)
>   return r;
>
> @@ -1529,7 +1529,7 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>
>   gfx_v12_0_free_microcode(adev);
>
> - amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> + amdgpu_gfx_sysfs_fini(adev);
>
>   kfree(adev->gfx.ip_dump_core);
>   kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 66947850d7e4..987e52c47635 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2402,7 +2402,7 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block =
*ip_block)
>
>   gfx_v9_0_alloc_ip_dump(adev);
>
> - r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> + r =3D amdgpu_gfx_sysfs_init(adev);
>   if (r)
>   return r;
>
> @@ -2443,7 +2443,7 @@ static int gfx_v9_0_sw_fini(struct amdgpu_ip_block =
*ip_block)
>   }
>   gfx_v9_0_free_microcode(adev);
>
> - amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> + amdgpu_gfx_sysfs_fini(adev);
>
>   kfree(adev->gfx.ip_dump_core);
>   kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index 016290f00592..983088805c3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1171,10 +1171,6 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
>
>   gfx_v9_4_3_alloc_ip_dump(adev);
>
> - r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> - if (r)
> - return r;
> -
>   return 0;
>  }
>
> @@ -1199,7 +1195,6 @@ static int gfx_v9_4_3_sw_fini(struct amdgpu_ip_bloc=
k *ip_block)
>   amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
>   gfx_v9_4_3_free_microcode(adev);
>   amdgpu_gfx_sysfs_fini(adev);
> - amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>
>   kfree(adev->gfx.ip_dump_core);
>   kfree(adev->gfx.ip_dump_compute_queues);
