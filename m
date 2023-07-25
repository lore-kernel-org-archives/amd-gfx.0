Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75D1C001DE
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 13:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C7A010E13F;
	Tue, 25 Jul 2023 13:17:59 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73E2A10E13F
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 13:17:57 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1bb75afeee3so1470781fac.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690291076; x=1690895876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IqurHV6wYxbL743RqxIbcsoCPhdmd2Axd6jUoyWkAjI=;
 b=RgL4MqF3WxIbuZD9e8luodMNeop+i/MNpUShPnim0y26q/5UQMk8CT9TS4ycHjuzse
 WnHhukdnehcJ/OVTcSttm0u0i5h+0hBMls55FIQ0YouldNgXk6yWvHDkaQdB6eYW7xrM
 eRioUIhl/3VFiDOKHrdWKuRk5sVRjU4LL7R0Lk1IdF72l17zPzfDjkZR19z6vlWMilRW
 u0bZaHCdl096x8UUGladj2gvAXQChslBS0ngTaROwvMLdFhQIvHmtKaqRqeqWulR/8vm
 5xUnhzCMa2qbM40f5ubBnZ6nuaEEl2KqkpL8FjFT4OiDr8SfvrHTtzgBofLdHvON2GHS
 BVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690291076; x=1690895876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IqurHV6wYxbL743RqxIbcsoCPhdmd2Axd6jUoyWkAjI=;
 b=gqr3s/KD3Z4faKGGVtL06f2Ir67+2dTFG+uK+M6TupVAKkzBZReOqdMCHT7mLsQ2aH
 pJja+OvYK0JRma7xVddQdG8Pxe2gcEDT01afuKyWIy3rWb+BeQoA5qeC+qwkEHi8l2Wn
 FZXTkxCFKXfuwpVQER7uF2WTnVMRWcndStTdRItfKvnSRMtcTnXqp+ZPA6oUzwWCiajn
 48r4aZ5aDgzRSFedoaP3dJXNTJFWYILPm+0odw12trz+VBlDMFQaXc4rkLVMibrI5bnt
 6DH5Beryv6WzsgF4xHuGal1DJvaXXOY25ADnQPt0Ao6B2JJC3tqgjEGQ/3CdUKzyaSVc
 tX8A==
X-Gm-Message-State: ABy/qLZgYqxmZlpdVDLIPF97F3hYivVulwXrSxppU3K9KyNrDerCY6V4
 xrkVuHxyj2vhTrZzYBRDJ9NDMIY9qmk2drfC41N34nCs
X-Google-Smtp-Source: APBJJlGc5t/z4+eczk5fOYVXXtYVz43Ipw9+imZ3RiZdwn7YTW9r5hdME5H92Da/cs9OgLVp7oZMtaBF2PyPZ2aLiCI=
X-Received: by 2002:a05:6871:614:b0:1bb:75af:37b5 with SMTP id
 w20-20020a056871061400b001bb75af37b5mr6039311oan.10.1690291076363; Tue, 25
 Jul 2023 06:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230725131539.2308926-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230725131539.2308926-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Jul 2023 09:17:45 -0400
Message-ID: <CADnq5_OhWLcyeTFXOb5+VuB9PSY8E40caaFVSPN9sFRKFv8F4w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Prefer dev_* variant over printk in
 amdgpu_atpx_handler.c
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
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Jul 25, 2023 at 9:16=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Changed from printk to dev_* variants so that
> we get better debug info when there are multiple GPUs
> in the system.
>
> Fixes other style issue:
>
> ERROR: open brace '{' following function definitions go on the next line
> WARNING: printk() should include KERN_<LEVEL> facility level
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c  | 35 ++++++++++++-------
>  1 file changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> index d6d986be906a..4eddca672f3e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> @@ -74,24 +74,29 @@ struct atpx_mux {
>         u16 mux;
>  } __packed;
>
> -bool amdgpu_has_atpx(void) {
> +bool amdgpu_has_atpx(void)
> +{
>         return amdgpu_atpx_priv.atpx_detected;
>  }
>
> -bool amdgpu_has_atpx_dgpu_power_cntl(void) {
> +bool amdgpu_has_atpx_dgpu_power_cntl(void)
> +{
>         return amdgpu_atpx_priv.atpx.functions.power_cntl;
>  }
>
> -bool amdgpu_is_atpx_hybrid(void) {
> +bool amdgpu_is_atpx_hybrid(void)
> +{
>         return amdgpu_atpx_priv.atpx.is_hybrid;
>  }
>
> -bool amdgpu_atpx_dgpu_req_power_for_displays(void) {
> +bool amdgpu_atpx_dgpu_req_power_for_displays(void)
> +{
>         return amdgpu_atpx_priv.atpx.dgpu_req_power_for_displays;
>  }
>
>  #if defined(CONFIG_ACPI)
> -void *amdgpu_atpx_get_dhandle(void) {
> +void *amdgpu_atpx_get_dhandle(void)
> +{
>         return amdgpu_atpx_priv.dhandle;
>  }
>  #endif
> @@ -113,6 +118,8 @@ static union acpi_object *amdgpu_atpx_call(acpi_handl=
e handle, int function,
>         union acpi_object atpx_arg_elements[2];
>         struct acpi_object_list atpx_arg;
>         struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +       struct acpi_device *adev =3D container_of(handle, struct acpi_dev=
ice, handle);
> +       struct device *dev =3D &adev->dev;
>
>         atpx_arg.count =3D 2;
>         atpx_arg.pointer =3D &atpx_arg_elements[0];
> @@ -134,8 +141,8 @@ static union acpi_object *amdgpu_atpx_call(acpi_handl=
e handle, int function,
>
>         /* Fail only if calling the method fails and ATPX is supported */
>         if (ACPI_FAILURE(status) && status !=3D AE_NOT_FOUND) {
> -               printk("failed to evaluate ATPX got %s\n",
> -                      acpi_format_exception(status));
> +               dev_err(dev, "failed to evaluate ATPX got %s\n",
> +                       acpi_format_exception(status));
>                 kfree(buffer.pointer);
>                 return NULL;
>         }
> @@ -176,6 +183,8 @@ static void amdgpu_atpx_parse_functions(struct amdgpu=
_atpx_functions *f, u32 mas
>  static int amdgpu_atpx_validate(struct amdgpu_atpx *atpx)
>  {
>         u32 valid_bits =3D 0;
> +       struct acpi_device *adev =3D container_of(atpx->handle, struct ac=
pi_device, handle);
> +       struct device *dev =3D &adev->dev;
>
>         if (atpx->functions.px_params) {
>                 union acpi_object *info;
> @@ -190,7 +199,7 @@ static int amdgpu_atpx_validate(struct amdgpu_atpx *a=
tpx)
>
>                 size =3D *(u16 *) info->buffer.pointer;
>                 if (size < 10) {
> -                       printk("ATPX buffer is too small: %zu\n", size);
> +                       dev_err(dev, "ATPX buffer is too small: %zu\n", s=
ize);
>                         kfree(info);
>                         return -EINVAL;
>                 }
> @@ -223,11 +232,11 @@ static int amdgpu_atpx_validate(struct amdgpu_atpx =
*atpx)
>         atpx->is_hybrid =3D false;
>         if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
>                 if (amdgpu_atpx_priv.quirks & AMDGPU_PX_QUIRK_FORCE_ATPX)=
 {
> -                       printk("ATPX Hybrid Graphics, forcing to ATPX\n")=
;
> +                       dev_info(dev, "ATPX Hybrid Graphics, forcing to A=
TPX\n");
>                         atpx->functions.power_cntl =3D true;
>                         atpx->is_hybrid =3D false;
>                 } else {
> -                       printk("ATPX Hybrid Graphics\n");
> +                       dev_info(dev, "ATPX Hybrid Graphics\n");
>                         /*
>                          * Disable legacy PM methods only when pcie port =
PM is usable,
>                          * otherwise the device might fail to power off o=
r power on.
> @@ -260,6 +269,8 @@ static int amdgpu_atpx_verify_interface(struct amdgpu=
_atpx *atpx)
>         struct atpx_verify_interface output;
>         size_t size;
>         int err =3D 0;
> +       struct acpi_device *adev =3D container_of(atpx->handle, struct ac=
pi_device, handle);
> +       struct device *dev =3D &adev->dev;
>
>         info =3D amdgpu_atpx_call(atpx->handle, ATPX_FUNCTION_VERIFY_INTE=
RFACE, NULL);
>         if (!info)
> @@ -278,8 +289,8 @@ static int amdgpu_atpx_verify_interface(struct amdgpu=
_atpx *atpx)
>         memcpy(&output, info->buffer.pointer, size);
>
>         /* TODO: check version? */
> -       printk("ATPX version %u, functions 0x%08x\n",
> -              output.version, output.function_bits);
> +       dev_info(dev, "ATPX version %u, functions 0x%08x\n",
> +                output.version, output.function_bits);
>
>         amdgpu_atpx_parse_functions(&atpx->functions, output.function_bit=
s);
>
> --
> 2.25.1
>
