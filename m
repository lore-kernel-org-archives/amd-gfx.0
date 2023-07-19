Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3434EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 13:07:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CDEF10E4A3;
	Wed, 19 Jul 2023 13:07:11 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CFA410E4A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 13:07:08 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1b056276889so4720873fac.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 06:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689772026; x=1692364026;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bqOBZpcKF0B5xx+9yFMYQKkIdp4rSmAsPeN7uVTk3Uk=;
 b=lI1sDCZyqcUfbZ99iEjf9cxsUwuDPqaSpjb0JyMzL0hMwm7G/eIliKCg6OzTLBVkJy
 xoh4VzXO2tSukLF2dMcXYC92/i7ePNgx9cbH6Ng39UfHA83Ngb7MglwOB0afPC9xuUwk
 cRsDKQbaG8s+xbWFGeNHKcqw8AMNVp2sd7W8QzROo2WbTfRja9sON1tpuqKIdg5E6s5k
 c9D7nUUEiL5/oQgvRYOTRbvAFgUkWKRIb0KCA5QPVCNb8RRc05tKIipCOp8lCcEFy2XJ
 kDLHwXw0N8uTDftnqhSR2bGsQitkU+lKum6Re35QJdvK+dAmlofB4bjg3nb27xip+IUQ
 3U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689772026; x=1692364026;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bqOBZpcKF0B5xx+9yFMYQKkIdp4rSmAsPeN7uVTk3Uk=;
 b=BnLKtAmu0mVhLT4y+mNE5ArAa2BzN/5Tdq2iHqsPzBAMJS/cT53a1q8xZ9/61PUYOd
 jeGhbzxAmdUrX0Vn4Is4Dqpjv9Yo5ouUVljINwBvgu3FpXxZK8C6jEdjvCxSl/darAgG
 neX+FQLn1zjTtjxrz5LIVvTwbWALwA0Bowxydb44uOPYC3/ayvbiX7Sz9X6780qgJ1ss
 x5WWmJlC6s+3IAD4X6ykULWomZAUCBKVMMp+SzLkvggr1y3V+5eNoDeO1+aJpRVGqdyf
 8bCqmKLuYB6a2f1VS/dTXDm911/mLg46fDjNVBOQ6mg4ZTskGy9rd2/a9bmMX1XuLspx
 rqOQ==
X-Gm-Message-State: ABy/qLYvrMEg/OJrdR5L0WwK+9k0DXJaq5nJq+z+uWWX7TB2k4mtIyxb
 j8JUn/qg96dptSlxkAMwRRme8xtaG8xFtjv+j0Q=
X-Google-Smtp-Source: APBJJlFThQvebp4xJWwABsqS6Slr7QPl3c8BdRk6VM2Hnrly3dacTOt6MLEVI0zVvX10wka/jjpP1Jt7dl7Ixj4EpOc=
X-Received: by 2002:a05:6870:610f:b0:1b0:2d25:f5ae with SMTP id
 s15-20020a056870610f00b001b02d25f5aemr2614631oae.47.1689772026642; Wed, 19
 Jul 2023 06:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230719051939.811520-1-srinivasan.shanmugam@amd.com>
 <20230719051939.811520-3-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230719051939.811520-3-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Jul 2023 09:06:55 -0400
Message-ID: <CADnq5_PGvVTXn_oTxvgS61C5b96Rtdu3UbDzpX24sYESHit2-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/radeon: Prefer dev_warn over printk
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
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.corp-partner.google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 19, 2023 at 1:20=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.corp-partner.google.=
com>
>
> Fixes the following checkpatch.pl:
>
> WARNING: printk() should include KERN_<LEVEL> facility level

Might be better to convert to dev_* variants so that we get better
info when there are multiple GPUs in the system.

Alex

>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/radeon/radeon_atpx_handler.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_atpx_handler.c b/drivers/gpu/d=
rm/radeon/radeon_atpx_handler.c
> index d0b450a06506..875a995fff66 100644
> --- a/drivers/gpu/drm/radeon/radeon_atpx_handler.c
> +++ b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
> @@ -115,7 +115,7 @@ static union acpi_object *radeon_atpx_call(acpi_handl=
e handle, int function,
>
>         /* Fail only if calling the method fails and ATPX is supported */
>         if (ACPI_FAILURE(status) && status !=3D AE_NOT_FOUND) {
> -               printk("failed to evaluate ATPX got %s\n",
> +               pr_err("failed to evaluate ATPX got %s\n",
>                        acpi_format_exception(status));
>                 kfree(buffer.pointer);
>                 return NULL;
> @@ -171,7 +171,7 @@ static int radeon_atpx_validate(struct radeon_atpx *a=
tpx)
>
>                 size =3D *(u16 *) info->buffer.pointer;
>                 if (size < 10) {
> -                       printk("ATPX buffer is too small: %zu\n", size);
> +                       pr_err("ATPX buffer is too small: %zu\n", size);
>                         kfree(info);
>                         return -EINVAL;
>                 }
> @@ -202,7 +202,7 @@ static int radeon_atpx_validate(struct radeon_atpx *a=
tpx)
>
>         atpx->is_hybrid =3D false;
>         if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
> -               printk("ATPX Hybrid Graphics\n");
> +               pr_info("ATPX Hybrid Graphics\n");
>                 /*
>                  * Disable legacy PM methods only when pcie port PM is us=
able,
>                  * otherwise the device might fail to power off or power =
on.
> @@ -239,7 +239,7 @@ static int radeon_atpx_verify_interface(struct radeon=
_atpx *atpx)
>
>         size =3D *(u16 *) info->buffer.pointer;
>         if (size < 8) {
> -               printk("ATPX buffer is too small: %zu\n", size);
> +               pr_err("ATPX buffer is too small: %zu\n", size);
>                 err =3D -EINVAL;
>                 goto out;
>         }
> @@ -248,7 +248,7 @@ static int radeon_atpx_verify_interface(struct radeon=
_atpx *atpx)
>         memcpy(&output, info->buffer.pointer, size);
>
>         /* TODO: check version? */
> -       printk("ATPX version %u, functions 0x%08x\n",
> +       pr_info("ATPX version %u, functions 0x%08x\n",
>                output.version, output.function_bits);
>
>         radeon_atpx_parse_functions(&atpx->functions, output.function_bit=
s);
> --
> 2.25.1
>
