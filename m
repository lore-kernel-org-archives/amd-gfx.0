Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D70E7FDD8
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 21:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0704C10E3CE;
	Mon,  2 Feb 2026 21:18:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XzNj6VAI";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C9DA10E3CE
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 21:18:01 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2b71e7dab12so265592eec.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 13:18:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770067081; cv=none;
 d=google.com; s=arc-20240605;
 b=HExHWECtg9Xxm3g9ijF0CEdyTc38Jg9OlkR7ibF9G6Xsayei5ykN5fzJSz0hjGkGwf
 DKWOkAZEX4nd2uULxQAMMJBiXWZ43ofb+5UmtHfrCKMUUtbX9izAboCCsrGaYRe7YlE8
 iemPhE0KTjIz8Yzk+tVjnbtLa136dVdeTf3VLQ6t8nKaetKUi+iTgwAdLQn//Cf0tfqM
 sZLZflRojYS6uRqyvk2+NOCzAAHEG1mfzVo286ObRnJ2cWygeZMoLzJBkehjslpz9mR3
 fV7rakV4DV/zHM2wFFdyWquLtsoWS1xL82qbT6EAo6Bd6fo9MuiqaD6NNZ/f72gh6rcZ
 0CZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xtxRuCI2Atd8wthE0TWsBYd1InEfj/DBSgh7fR7BZV0=;
 fh=jrj2zacaXiuElwmT/59HCjZUVEPuL3U3OF0ylmi9raM=;
 b=OxbfYq60TEA1R9qbg5uLqRJ7YLiWvbJlqJE3Fbf7gmmjvY34RtAidtlU0uSC3cXu4L
 4XcpmB1gcYKWNuzxSFiv0xw/Dbd+XPsimyVJzws75isTc8zQJMWX+E+mI3qetL5OaVKk
 Zxd1A/yM7XwMLYymSdT9Y+WJAwonoHs6Q6OlWBPo5k/R1cMjZcW+iy7bNEIYzmn7bTRn
 ZgjR4XSXePc7tSPUt7T+7Mg/ZJc2RPJrmKAg1eufAH+Y+SWq/S9yMVAgbXOGoHPaPSHI
 LWnpP02OpHDyv2/RYJ/GP075qGCqeeHEeWQnu4gOylbK4OgjASbN2FBPcnWHTa/U+O0i
 Kc7g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770067081; x=1770671881; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xtxRuCI2Atd8wthE0TWsBYd1InEfj/DBSgh7fR7BZV0=;
 b=XzNj6VAIX1K8xlFEI94U22YpQBOfvtorx5g0F/6KBHgUE1bQJVo8WSbrNXxuEy7KzC
 S4NDl1dZs8ZinDvMFXRUMIIZjtfFdlgQlXLaRat4NfGD0e0xPXxK+eDiOGgU4CMZSDOv
 e59tkQRgxBVi6njx/kvNdEFVqyD8K6zUP7H33w0z4gAH7IZUehhMSqHDf3Kp2NDeZQW3
 8XxhBThl/BSfs7Ta6pA+2Nxf5tvngkP1eHEaq5rzCu/n81RPjgoKIha5EGVVZkobaVOt
 hGCB4vsjHzf1cRweMejHZbVTKfUP1vk2CQwRQ1yFLVHpveacHKZdZ8j3dWjZIXO+nTNk
 SiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770067081; x=1770671881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xtxRuCI2Atd8wthE0TWsBYd1InEfj/DBSgh7fR7BZV0=;
 b=iLV3WOZUoV5A0z4itCKZj2JEbcExzp7ujvv+FPM3TB9o9anB1LwMqHX1UgtSsndqpP
 ccg8qNy9LEW1CsUHGp8a9/rKgmjYe5SK4Zg5FafY0XcnWZDxwwPC7nfz2sNd78BLxdVR
 hJbIwLPNZMxd+Qa8E1ljt203Uz/Eesd71+BnyuNuQZ5deAUlp/kQsUPC6cqaMt03BBMZ
 05H7FvZoyfqjM6FwPk8dTj+t04I24JJ9kWUZyFNc8L6PjbREryJe6ApqgTlk8HM3X7uk
 lzz+LqN0BhKYte1CFPuPBv2JJebkVTB9/3fb2KpATR0EuDnlrpbSg6gn7vVmlOYv1mM/
 QuNw==
X-Gm-Message-State: AOJu0YyVfF8lOxSPJFjyVemzOGW6O2LFhXjzGLPftLzNR3CsdtIhAozz
 ZMKaYPixH/1jMJ6QSucFwyjxmFgv+oHjjo8jSEjW1eTLV2EQzKNvCcCWiPzYhPMCWfWwPknqe6H
 T6AxghY2D3CMoCn+zZQERoddO2w4Wysk=
X-Gm-Gg: AZuq6aK9WfclMmR8efskAB9mSPFvoJ6eVyL7/hDezgUF7EMMuDSUh85FgPSHMR+kuVT
 ek0fMxkyCReYgRKFVfhiA+VPgaCnVLUOpzue7HQumnFY9/cRQCDf0q+lykcPMtB5ZFLtRvcBeTr
 MX+xDyLP5WE2zXg7dSJgWkLIaQWCirkHk+Xl1XhvGaN9xJpmqS6sw31h0E4s7sOToB2oNs6a9lV
 58puhQdwgseRGusT4bTv9U+bvEmxxhB4FU8NqbRr2TC2vEhSOBx0VjolNJRR9BiqLWQhVwcepi5
 5GFqHHE=
X-Received: by 2002:a05:7022:660b:b0:11b:862d:8031 with SMTP id
 a92af1059eb24-125c0f12e0cmr3015760c88.0.1770067080637; Mon, 02 Feb 2026
 13:18:00 -0800 (PST)
MIME-Version: 1.0
References: <20260130084137.2906792-1-lijo.lazar@amd.com>
 <20260130084137.2906792-12-lijo.lazar@amd.com>
In-Reply-To: <20260130084137.2906792-12-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Feb 2026 16:17:49 -0500
X-Gm-Features: AZwV_QjPmPg1RNTYxa0bt1DO0LrLgg76AQDarIukcf2dRiF0C2wU2GAyxrNn2Bo
Message-ID: <CADnq5_PkDhF2fvMHbiRKNMsrFBDUSpFGqaQL=T906t=5_buKgw@mail.gmail.com>
Subject: Re: [PATCH v5 11/11] drm/amdgpu: Add interface to set debug trap flag
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, David.YatSin@amd.com, 
 Lancelot.Six@amd.com, jonathan.kim@amd.com, Jesse.Zhang@amd.com
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

On Fri, Jan 30, 2026 at 6:12=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Add interface to set debugger trap flag in TMA region.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 19 ++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |  3 +++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cwsr.c
> index 50bafb84a912..7e5a08b0a1c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> @@ -19,7 +19,6 @@
>   * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
> -
>  #include <drm/drm_exec.h>
>
>  #include "amdgpu.h"
> @@ -609,4 +608,22 @@ int amdgpu_cwsr_ioctl(struct drm_device *dev, void *=
data, struct drm_file *filp)
>         }
>
>         return r;
> +}
> +
> +int amdgpu_cwsr_set_trap_debug_flag(struct amdgpu_device *adev,
> +                                   struct amdgpu_cwsr_trap_obj *cwsr_obj=
,
> +                                   bool enabled)
> +{
> +       uint64_t *l1tma;
> +
> +       if (!amdgpu_cwsr_is_enabled(adev))
> +               return -EOPNOTSUPP;
> +
> +       if (!cwsr_obj)
> +               return -EINVAL;
> +
> +       l1tma =3D (uint64_t *)(cwsr_obj->tma_cpu_addr);
> +       l1tma[2] =3D enabled;
> +
> +       return 0;
>  }
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cwsr.h
> index 2cf485111e8f..06036954627e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> @@ -92,5 +92,8 @@ static inline bool amdgpu_cwsr_has_dbg_wa(struct amdgpu=
_device *adev)
>
>  int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data,
>                       struct drm_file *filp);
> +int amdgpu_cwsr_set_trap_debug_flag(struct amdgpu_device *adev,
> +                                   struct amdgpu_cwsr_trap_obj *cwsr_obj=
,
> +                                   bool enabled);
>
>  #endif
> --
> 2.49.0
>
