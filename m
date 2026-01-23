Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8E2D778AF
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 20:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EEBF10E2EA;
	Fri, 23 Jan 2026 20:53:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F0bSjgJy";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 555C810E2EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 20:53:40 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1233bc11279so198584c88.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 12:53:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769201619; cv=none;
 d=google.com; s=arc-20240605;
 b=MJwY5J0od+Ht0AnaHySoAisqaj1xX6TSuEf2zwqf9yHBBcOzcY3NucwG1jflNfVnwy
 8ycZIXyelI9dVLSr7QL6o4zNIQfq2R3St7JOtV9G1OW2lvwAraAM8qGo7RVQ6Z8nNdWt
 OrArXToeT9apAYn28n2gylHphbR0IracPuP6fefPtdGutgfC+Soi2+R924ll5gWnEyic
 8uCGWVJW7ZaF92Re0UQzIm/uE0WqXBUEvIVBR+yAl6XvN/U/s61CnRhWpXeCdMN9V0dx
 lqFzFi/f24S3WhLcVdJ/UgFmbUbfbMqjufPSJOh/THc8Nik1Ms9a+e0cNFCgc4ad08vp
 Tkhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4h+a5Jawc+wJMuKreh7mC0GwP/tnBKqvAC671stJ4W8=;
 fh=hY26Edfw5zSfQ7k5ViI2NrfnfaMcpj1z2TiRTG9Zwhg=;
 b=Qq1NYQ1BUvLejKPt09JUlb4ZBHfufBB1hS10fGJItrGTT0/gWVuRg03f4G7GzFDV69
 hQLiiiuKmMFlV5C4dE0YfuoSa8HUjE+87z5QcPFQMG6ytZ4HdtGacqdwO3Bjqpigm4ly
 YlrqIbyyrRiX31za1D71hiehbl2LKGbhIulv1f1D/rZzgZ0PEmsG9NKFIanuMXDc8NXk
 UGZAhFxiCxftE8/9/Bo4pB1kdlgRjAjkCmD87/6iVtZWzCl6IsLo0elNL7+ri+S/+/+T
 RKkwDTtRbwKwhiOVwj28+dOcJs1fW7KwGBcnLl90gsU2ahupnH7Ic2b725AEbZ8bKTOz
 Fkow==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769201619; x=1769806419; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4h+a5Jawc+wJMuKreh7mC0GwP/tnBKqvAC671stJ4W8=;
 b=F0bSjgJyA9IEcQMbueg6X6mjl7bFNgqP0fCq/Dimf++qOHkszdntGl0JR4K/GKLJqn
 W+IyV987a5zWSvY4nbyZ3sGFmhZOkhW7j7THFSe/+/VDcU1C7ULtIyzH+5u0khwvf82r
 f/01XLxq8PFU/swabmDhiX15rCr112kKoMUI05HACEaGhdRWFKFiyskNlsOeWfO1khQH
 QjToMb8Cpk6s0nvcLQ1hcGgbdF4/MOA1jnCNESVft6UcMnWfqi8aK/RbwElDhEytb3l+
 CMTMALbCWMYDUndmQ6Ad8JRVnp+LQTnvWS++ldrtmcsfgR6VPf9fIeNv1ZR9ALyLdbTg
 9IfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769201619; x=1769806419;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4h+a5Jawc+wJMuKreh7mC0GwP/tnBKqvAC671stJ4W8=;
 b=BDdWChlp6CiO9iUlICfehOQCTcMS5GYlyX3yRq65Ezvl+08/wbcYGdF3DVEryMOde1
 GHXJX9BFlFDzBLg3kC7dHClUF4q+RY3nNn3gyPXRAHqubZCET74Mnz3shliJsf6JlVHp
 1faTVtWPT0O+6PJixjMRq112UzcsPobhuGwBTAqDuZrflPZx+sNR/WpEKew466R9IgxI
 nTS7XGkrnnH5b1dGiQ5hHJ5FUBafmfy+k285nLQjGmpRzelq2zowxpj/wZqZIgYPt18F
 65x4AKUx5Cuj2SCODvyjREIQpazlMnbXXDX780cTUbRqvybcL6z7W7/g9ZSi/J7xFTwf
 pMPQ==
X-Gm-Message-State: AOJu0Yzcb6jFOaIpmq38ahC67nPbEpwkzOjIC8ISy3IN7Vdt13VKCxOV
 6tCbFxrNJWwkiImNkXczcxaiUtLXZIB3NDlDY7aEn/vIxM3LRBh2o9vnemOncAViucMqsbBHIDj
 41K8FkVw4kDwUCRxWTn8RyhUgqdnhKd8=
X-Gm-Gg: AZuq6aI26li/MzJixJBed0TdmoqF8Nc2ENuirhysrZ2r7G1c/R/RP7tL0TMCHSw4NWW
 ClV1PLO3M412xI4Le7SRLtxHCYp8qZfzk7g5v3rxp0eBFYpKIe1DEg1yrwgRmoJEHloUgMpu5p7
 XnEhuJExt6CFlsjbeNIF6+RFVAYr8ZkJTw3Avmj/Xq5oP63cGfHbtGRwXqZHMeMQdw9Xp0DPBr4
 JwSk77czNUO1Cf+KF+5ljMMGdKkoAg+Sn3kdegnzSfbOYn1S/+xD9cYpaoeihQeSes2HpAI
X-Received: by 2002:a05:7022:6b87:b0:119:e56b:46b6 with SMTP id
 a92af1059eb24-12485584e31mr220977c88.0.1769201619442; Fri, 23 Jan 2026
 12:53:39 -0800 (PST)
MIME-Version: 1.0
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
 <20260122104118.1682154-12-lijo.lazar@amd.com>
In-Reply-To: <20260122104118.1682154-12-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Jan 2026 15:53:28 -0500
X-Gm-Features: AZwV_Qj9BedeZZJjOVe8MtsCMYYhKP5Fo4Gf7bFRtYuF54bWBKVuq9PQXsgtbZ4
Message-ID: <CADnq5_MQUq4sQXDc3Kv5RJDzP+ya82-+xEPnAsys9KAP0=Mb=A@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] drm/amdgpu: Add interface to set debug trap flag
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com
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

On Thu, Jan 22, 2026 at 5:42=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Add interface to set debugger trap flag in TMA region.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 19 ++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |  3 +++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cwsr.c
> index 70f444afece0..663b91c8e6f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> @@ -19,7 +19,6 @@
>   * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
> -

Spurious change.

>  #include <drm/drm_exec.h>
>
>  #include "amdgpu.h"
> @@ -614,4 +613,22 @@ int amdgpu_cwsr_ioctl(struct drm_device *dev, void *=
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
> index c9f61e393fde..a32044b07b45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> @@ -93,5 +93,8 @@ static inline bool amdgpu_cwsr_has_dbg_wa(struct amdgpu=
_device *adev)
>
>  int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data,
>                       struct drm_file *filp);
> +int amdgpu_cwsr_set_trap_debug_flag(struct amdgpu_device *adev,
> +                                   struct amdgpu_cwsr_trap_obj *cwsr_obj=
,
> +                                   bool enabled);
>

Nothing uses this yet?

Alex

>  #endif
> --
> 2.49.0
>
