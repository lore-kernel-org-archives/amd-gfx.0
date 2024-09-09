Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D430ECE589
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 21:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2DEB10E6C9;
	Mon,  9 Sep 2024 21:25:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FhrfVPQY";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B02710E6C9
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 21:25:30 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-718e0421143so597185b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 14:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725917130; x=1726521930; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=le56xZAXtWC3oNdIyLUtNoQuaF//k2Ob3bd2QOLQqpg=;
 b=FhrfVPQY8jkxVnQ6HDF94hq4JcOg7//MAgTZcON8AuWIStocxCTYjZAnLmT97aVVQZ
 wrI3mQgDpgkglehXAfGwCpNquCa3X9VI9ZLeCJPw24JsZo/JzdF5rQC4HOBADmrtNmvK
 bw9ECjNzhz2w5LxjCKjv5QCQfs7+Q+4Bp+ieoRdxLTGcsZa5eU4FTsc6iMXK2lMRiFDE
 03rOvjQv7VKijQegMOJKWmc8DMPPP5kR00kvHClSzDfaBHXtdCdImSOrAoD47jsa1J5e
 vdjT19vL2xC6IXPzsAc1VjkC6UeNa/l9qtPxT15CL5BCu5iXt8VH1It9YKNUHwAN1I9+
 sgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725917130; x=1726521930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=le56xZAXtWC3oNdIyLUtNoQuaF//k2Ob3bd2QOLQqpg=;
 b=dyyVbuKZAZhJGZA6yo9h3tDpqHDDfOivHRErbWvD9xamqKRO61J+DG7EMC7sza5iX0
 bQCZzZaPAMWjWK3toX9tNgZik2cNTB5spsCgsYrdTsHK36w/YnaOoXzGLbn0UV/pp+PZ
 8t730mLyuNue789a9QFlTHaaRp43PGkKWgtEIc4QoPutU94xnKtTMOLJ72ZKigbKd6xX
 +Me3AFnWNdUZwShtnz7WE2HnNRcpTYQCYgmHXD+pfxUVD7DnNkWJLzAKHqm0qVIzg9ya
 lvx2swwQTziDMlicIiYcYODVOLolm/wkjT+WWJ/pHdf4v03subIhYuOXURMgRYKhqhME
 JNTQ==
X-Gm-Message-State: AOJu0YwDFylQdLxoveZn7WPKXUCj8hELVsWyaCh5v/J7f3vIQRtLL+Do
 H1nXNcLpsd17QfrVJYHeoC+V7vN1h1NgwHAmBpWgp10YSyHVRWpLFmcu1itlSnaOUgdXZlp3Vzn
 bBfT2UsMlBdj/0AylU6vLAwZA3vjqxQ==
X-Google-Smtp-Source: AGHT+IH7FU8Nk8uM9M+PO1D4Rh4HDWRvyngT5fJoGtUXTi4y6cb6gWEPLcmErpSBFGD7uUgZNQT0JhOl32wHTuZdVLA=
X-Received: by 2002:a05:6a21:78a6:b0:1cf:52f5:dc with SMTP id
 adf61e73a8af0-1cf52f504e3mr197601637.1.1725917129513; Mon, 09 Sep 2024
 14:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
 <20240902073417.2025971-5-lijo.lazar@amd.com>
In-Reply-To: <20240902073417.2025971-5-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Sep 2024 17:25:17 -0400
Message-ID: <CADnq5_NNfmhi2NBZHtWnKoUmKydwEDDacmPh+aaKO++LckZrsA@mail.gmail.com>
Subject: Re: [PATCH 04/10] drm/amdgpu: Add reset on init handler for XGMI
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
> In some cases, device needs to be reset before first use. Add handlers
> for doing device reset during driver init sequence.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h       |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 148 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |   4 +
>  3 files changed, 153 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index e1ae898b42eb..d17506d9adae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -562,6 +562,7 @@ enum amd_reset_method {
>         AMD_RESET_METHOD_MODE2,
>         AMD_RESET_METHOD_BACO,
>         AMD_RESET_METHOD_PCI,
> +       AMD_RESET_METHOD_ON_INIT,
>  };
>
>  struct amdgpu_video_codec_info {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_reset.c
> index 66c1a868c0e1..29128d5edf14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -26,6 +26,154 @@
>  #include "sienna_cichlid.h"
>  #include "smu_v13_0_10.h"
>
> +static int amdgpu_reset_xgmi_rst_on_init_suspend(struct amdgpu_device *a=
dev)

maybe write out reset_on_init rather than rst_on_init?  or use the roi
or r_o_i for consistency?

> +{
> +       int i, r;
> +
> +       for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
> +               if (!adev->ip_blocks[i].status.valid)
> +                       continue;
> +               if (!adev->ip_blocks[i].status.hw)
> +                       continue;
> +               /* displays are handled in phase1 */
> +               if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_=
TYPE_DCE)
> +                       continue;
> +
> +               /* XXX handle errors */
> +               r =3D adev->ip_blocks[i].version->funcs->suspend(adev);
> +               /* XXX handle errors */
> +               if (r) {
> +                       dev_err(adev->dev, "suspend of IP block <%s> fail=
ed %d",
> +                               adev->ip_blocks[i].version->funcs->name, =
r);
> +               }
> +               adev->ip_blocks[i].status.hw =3D false;
> +       }
> +
> +       return 0;
> +}
> +
> +static int
> +amdgpu_reset_xgmi_roi_prep_hwctxt(struct amdgpu_reset_control *reset_ctl=
,
> +                                 struct amdgpu_reset_context *reset_cont=
ext)

use consistent naming; e.g., roi vs reset_on_init.

> +{
> +       struct list_head *reset_device_list =3D reset_context->reset_devi=
ce_list;
> +       struct amdgpu_device *tmp_adev;
> +       int r;
> +
> +       list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
> +               amdgpu_unregister_gpu_instance(tmp_adev);
> +               r =3D amdgpu_reset_xgmi_rst_on_init_suspend(tmp_adev);
> +               if (r) {
> +                       dev_err(tmp_adev->dev,
> +                               "xgmi reset on init: prepare for reset fa=
iled");
> +                       return r;
> +               }
> +       }
> +
> +       return r;
> +}
> +
> +static int
> +amdgpu_reset_xgmi_roi_restore_hwctxt(struct amdgpu_reset_control *reset_=
ctl,
> +                                    struct amdgpu_reset_context *reset_c=
ontext)
> +{
> +       struct list_head *reset_device_list =3D reset_context->reset_devi=
ce_list;
> +       struct amdgpu_device *tmp_adev =3D NULL;
> +       int r;
> +
> +       r =3D amdgpu_device_reinit_after_reset(reset_context);
> +       if (r)
> +               return r;
> +       list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
> +               if (!tmp_adev->kfd.init_complete) {
> +                       kgd2kfd_init_zone_device(tmp_adev);
> +                       amdgpu_amdkfd_device_init(tmp_adev);
> +                       amdgpu_amdkfd_drm_client_create(tmp_adev);
> +               }
> +       }
> +
> +       return r;
> +}
> +
> +static int
> +amdgpu_reset_xgmi_roi_perform_reset(struct amdgpu_reset_control *reset_c=
tl,

Same comment here.

> +                                   struct amdgpu_reset_context *reset_co=
ntext)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl-=
>handle;
> +       struct list_head *reset_device_list =3D reset_context->reset_devi=
ce_list;
> +       struct amdgpu_device *tmp_adev =3D NULL;
> +       int r;
> +
> +       dev_dbg(adev->dev, "xgmi roi - hw reset\n");
> +
> +       list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
> +               mutex_lock(&tmp_adev->reset_cntl->reset_lock);
> +               tmp_adev->reset_cntl->active_reset =3D
> +                       amdgpu_asic_reset_method(adev);
> +       }
> +       r =3D 0;
> +       /* Mode1 reset needs to be triggered on all devices together */
> +       list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
> +               /* For XGMI run all resets in parallel to speed up the pr=
ocess */
> +               if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_=
work))
> +                       r =3D -EALREADY;
> +               if (r) {
> +                       dev_err(tmp_adev->dev,
> +                               "xgmi reset on init: reset failed with er=
ror, %d",
> +                               r);
> +                       break;
> +               }
> +       }
> +
> +       /* For XGMI wait for all resets to complete before proceed */
> +       if (!r) {
> +               list_for_each_entry(tmp_adev, reset_device_list, reset_li=
st) {
> +                       flush_work(&tmp_adev->xgmi_reset_work);
> +                       r =3D tmp_adev->asic_reset_res;
> +                       if (r)
> +                               break;
> +               }
> +       }
> +
> +       list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
> +               mutex_unlock(&tmp_adev->reset_cntl->reset_lock);
> +               tmp_adev->reset_cntl->active_reset =3D AMD_RESET_METHOD_N=
ONE;
> +       }
> +
> +       return r;
> +}
> +
> +int amdgpu_reset_xgmi_rst_on_init(struct amdgpu_reset_context *reset_con=
text)

and here.

Alex

> +{
> +       struct list_head *reset_device_list =3D reset_context->reset_devi=
ce_list;
> +       struct amdgpu_device *adev;
> +       int r;
> +
> +       if (!reset_device_list || list_empty(reset_device_list) ||
> +           list_is_singular(reset_device_list))
> +               return -EINVAL;
> +
> +       adev =3D list_first_entry(reset_device_list, struct amdgpu_device=
,
> +                               reset_list);
> +       r =3D amdgpu_reset_prepare_hwcontext(adev, reset_context);
> +       if (r)
> +               return r;
> +
> +       r =3D amdgpu_reset_perform_reset(adev, reset_context);
> +
> +       return r;
> +}
> +
> +struct amdgpu_reset_handler reset_on_init_handler =3D {
> +       .reset_method =3D AMD_RESET_METHOD_ON_INIT,
> +       .prepare_env =3D NULL,
> +       .prepare_hwcontext =3D amdgpu_reset_xgmi_roi_prep_hwctxt,
> +       .perform_reset =3D amdgpu_reset_xgmi_roi_perform_reset,
> +       .restore_hwcontext =3D amdgpu_reset_xgmi_roi_restore_hwctxt,
> +       .restore_env =3D NULL,
> +       .do_reset =3D NULL,
> +};
> +
>  int amdgpu_reset_init(struct amdgpu_device *adev)
>  {
>         int ret =3D 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_reset.h
> index 1cb920abc2fe..d89929f412fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -153,4 +153,8 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_contex=
t *rst_ctxt, char *buf,
>         for (i =3D 0; (i < AMDGPU_RESET_MAX_HANDLERS) &&           \
>                     (handler =3D (*reset_ctl->reset_handlers)[i]); \
>              ++i)
> +
> +extern struct amdgpu_reset_handler reset_on_init_handler;
> +int amdgpu_reset_xgmi_rst_on_init(struct amdgpu_reset_context *reset_con=
text);
> +
>  #endif
> --
> 2.25.1
>
