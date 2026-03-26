Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB91610A88FB
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 18:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D09110EA8F;
	Thu, 26 Mar 2026 18:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="omWkjj8g";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D588510EA8F
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:03:29 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-12a6b260693so174530c88.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:03:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774548209; cv=none;
 d=google.com; s=arc-20240605;
 b=Um5Hsm5G0SSns90O5emllCL1lEeT9/zm9E4YsJCs4nsQSwtlPFRV3yaOfLE5rfpUzw
 8TCB3xGncJAki2M5beuuaSp3yDyX7MXBn6gTEZfySRdlp8lyyO2BgRSA6OkxUl5vcWIa
 H2DIKa7glsT2hGyV4+SXqWxRBGcgTaxs+gpZ/36E5sZWOBJyhYK56ZYSaHszkFm1Txog
 b04rgQ176/SRtyqFC8cDB/giprUrtIjBeHQ8kUpxA8AHLLqlj3xHQYpwou2/0911mQQ6
 q9xN5UskcvBHRYgBpvJDpla0kGXLfC5FpEeDX9Mnrm1FOxZF2Qx5fMphNyWY5YZd5oZG
 JFCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=++XF0il6x4My1Yrj9Mke0sEw/O8CeI7vJH6EqltiUA8=;
 fh=OvKzi3YaVdYQcj/ttN/1Uz8prEoy1Xr2B3QHReZfFdY=;
 b=XQVaTgLOdiJOnGm0ZdJYkxTeGth2VwTQXPSs3bM60yFxuxN7GSGZQxYAIfyE6Eb4hI
 EsdNKlPqqhtDL8EhuLCnICe/Dgj/AU1YQgqe4D2ziQJWzy0T1LV6CQYdtqX1mppXmhGn
 8hz89zhumiIJyxBe9TyoVLC7oT3xEWVLj1WvNjFkycTLAbFt9c572NfAQQrrE6jfwqiE
 YJzDcPUJauNWjvrhntdXXIPSB5toAxn7LRQK3UIof//mjNOHWLeeh1aUOov0GNyAE61w
 utDkMkryLTT7ZWi4x79dGY5hdms+KNiPsbUg0XLx4TG9lBKr6GWdpm9ytXXnA/7G0wBG
 +DzA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774548209; x=1775153009; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++XF0il6x4My1Yrj9Mke0sEw/O8CeI7vJH6EqltiUA8=;
 b=omWkjj8gTJLUJHeG+h0LLhoS+oPE6hzGvpxRKRbasP0c3C3bZmkPq3uLJeUH3HMLEK
 f4tABcBCl2hFiB5H4GdhjlYODxeVJHHKMcglNPzciaXAdIVy8aCTpFw+pZkgarr+ARaH
 l4UHcDbqyj1f4K7fG4p9BHXmuoz7BqrP9+CXv6W6Eiu8pd3fNwQTkNZQYlgAeMhzXe4O
 caylj8j2YvojHSAXVAKL3kCp0UZ2nGug3dQ/d1r53/u/LhYxplzoUp5QylyFXFL5LdI9
 mTUaqDsBSUsjJgvbnuSnGyixn/Bw66iDm1Jl0RiObtMvebt8z9uyoIoiTMsz1FNN7qJT
 oqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774548209; x=1775153009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=++XF0il6x4My1Yrj9Mke0sEw/O8CeI7vJH6EqltiUA8=;
 b=Gr3NNolcFx0yHttaKdKbluXDTYy7rgJSS8OWVl3c4JzS/yt4+W4dqH1JCIjFR8pxVw
 cXtgu035EJrQ8Rg3YoysOo6IzYEVvlwQeHxUM/gq1VTy0d6a707BDaqmzuaApQNko0IJ
 8B1+czipruRYfbp87VscHTJAHD0dJ4I8D9SgUf4kXbnA4J/N/hOsXe0VXfofwMTkA/P8
 W5bp4zfu/KXKv8+PBdHEfpYhZCNZBLALygTZwtpOt3F2kwIv4OCEiYVYa7jfLRRvLM8U
 p4nDixXYXfbusNSkw3OxCoRdXK/Fkg0sB/oHXeKEuJ27fXFpqTgyfMDtBce422Pw918L
 eIxw==
X-Gm-Message-State: AOJu0YxIHKe00yiX9J0ZETh/tsRp6wxtMjFrPJqymisEa9Fwrjqtp3PT
 haiLVKQ9bbr1YAaV5O8SpdXbyaKmDXY3h5ILv2CYhPvUpbUvRiAzEx/QcxBLl3i64L0G72uYxb/
 65zG8WDcs3cUqHq5H8SPFHEJ1Pc9DBqA=
X-Gm-Gg: ATEYQzzWMiwXdSKkSsUgCucpfzZsdiFwhWSEMXMPyQxcubONVqDxWDNLxJGWRByr5T0
 xVImZ8mSyFrV5sVTubirRvVfk9xnjIaafAUbjenvD6fyCWq5/YHHMnup9eHDPFbY0b1YhkTglXz
 0j2vPmdpNOpg0CT9B+1LIKLMp0NTiJQlkdNlQaquupONQ8v6d5Y26Vclh9atSO9gkZ9XyL4FquK
 OBxfo37fo82JHz53TFJMBlEeFbES6rLgl+N9GUHdhT0gMr6Vlu6Plhtcs+5j8t3Nif7epGnx4y6
 0IJ7wT7yrBbZ8qPtn9GMaylJs8SksnxMPFR0WadaRJOJG3dh1wkQa3MUyfBBDmdFW51HyA==
X-Received: by 2002:a05:7022:48a:b0:123:2d38:929b with SMTP id
 a92af1059eb24-12a96f87da8mr2185583c88.6.1774548208854; Thu, 26 Mar 2026
 11:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
 <20260324175653.1325754-3-Amber.Lin@amd.com>
In-Reply-To: <20260324175653.1325754-3-Amber.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Mar 2026 14:03:17 -0400
X-Gm-Features: AQROBzBzqqeCtx_MHT4l-y_t44dS4w3BlBkJaJxFNGuwyA224NGogRzc9BVYC8I
Message-ID: <CADnq5_Pi+DU-w385XAsd6Scj2SG8=qA1nyejTQbWX-9p3FC3bA@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] drm/amdgpu: Fixup boost mes detect hang array
 size
To: Amber Lin <Amber.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, Michael.Chen@amd.com, 
 Jesse.Zhang@amd.com, Jonathan Kim <jonathan.kim@amd.com>
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

On Tue, Mar 24, 2026 at 1:57=E2=80=AFPM Amber Lin <Amber.Lin@amd.com> wrote=
:
>
> When allocate the hung queues memory, we need to take the number of
> queues into account for the worst hang case.
>
> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 33 +++++++++++++++++++------
>  1 file changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 0d4c77c1b4b5..e639d6c329e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -103,7 +103,7 @@ static inline u32 amdgpu_mes_get_hqd_mask(u32 num_pip=
e,
>
>  int amdgpu_mes_init(struct amdgpu_device *adev)
>  {
> -       int i, r, num_pipes;
> +       int i, r, num_pipes, num_queues =3D 0;
>         u32 total_vmid_mask, reserved_vmid_mask;
>         int num_xcc =3D adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) =
: 1;
>         u32 gfx_hqd_mask =3D amdgpu_mes_get_hqd_mask(adev->gfx.me.num_pip=
e_per_me,
> @@ -159,7 +159,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>                 adev->mes.compute_hqd_mask[i] =3D compute_hqd_mask;
>         }
>
> -       num_pipes =3D adev->sdma.num_instances;
> +       num_pipes =3D adev->sdma.num_inst_per_xcc;
>         if (num_pipes > AMDGPU_MES_MAX_SDMA_PIPES)
>                 dev_warn(adev->dev, "more SDMA pipes than supported by ME=
S! (%d vs %d)\n",
>                          num_pipes, AMDGPU_MES_MAX_SDMA_PIPES);
> @@ -216,8 +216,27 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>         if (r)
>                 goto error_doorbell;
>
> +       if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(12, 1, 0)=
) {
> +               /* When queue/pipe reset is done in MES instead of in the
> +                * driver, MES passes hung queues information to the driv=
er in
> +                * hung_queue_hqd_info. Calculate required space to store=
 this
> +                * information.
> +                */
> +               for (i =3D 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
> +                       num_queues +=3D hweight32(adev->mes.gfx_hqd_mask[=
i]);
> +
> +               for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
> +                       num_queues +=3D hweight32(adev->mes.compute_hqd_m=
ask[i]);
> +
> +               for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
> +                       num_queues +=3D hweight32(adev->mes.sdma_hqd_mask=
[i]) * num_xcc;
> +
> +               adev->mes.hung_queue_hqd_info_offset =3D num_queues;
> +               adev->mes.hung_queue_db_array_size =3D num_queues * 2;
> +       }
> +
>         if (adev->mes.hung_queue_db_array_size) {
> -               for (i =3D 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
> +               for (i =3D 0; i < AMDGPU_MAX_MES_PIPES; i++) {
>                         r =3D amdgpu_bo_create_kernel(adev,
>                                                     adev->mes.hung_queue_=
db_array_size * sizeof(u32),
>                                                     PAGE_SIZE,
> @@ -264,10 +283,10 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>                               &adev->mes.event_log_cpu_addr);
>
>         for (i =3D 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
> -               amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_=
obj[i],
> -                                     &adev->mes.hung_queue_db_array_gpu_=
addr[i],
> -                                     &adev->mes.hung_queue_db_array_cpu_=
addr[i]);
> -
> +               if (adev->mes.hung_queue_db_array_gpu_obj[i])
> +                        amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_a=
rray_gpu_obj[i],
> +                                        &adev->mes.hung_queue_db_array_g=
pu_addr[i],
> +                                        &adev->mes.hung_queue_db_array_c=
pu_addr[i]);
>                 if (adev->mes.sch_ctx_ptr[i])
>                         amdgpu_device_wb_free(adev, adev->mes.sch_ctx_off=
s[i]);
>                 if (adev->mes.query_status_fence_ptr[i])
> --
> 2.43.0
>
