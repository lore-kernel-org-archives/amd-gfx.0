Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5822AF483E3
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 19:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF0DE10E373;
	Mon, 23 Mar 2026 19:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d/0n0QOW";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4950910E373
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 19:01:20 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2c0ccfcbee3so255938eec.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 12:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774292479; cv=none;
 d=google.com; s=arc-20240605;
 b=Y199Jo2Z3/DPFLtlN/L+4KZTZ5UMnEwLojID3a3unExXOpx3fjRkKM4z6CmREtfoFk
 28cyCg9qpYFaa9U+Hdql6p6o3He1jSj8kS128sDT+hgYVI2dznxYIl+zjJuvfzpaMigx
 /ZbVz5CDJw5niNm7V6sKxJDaXIMvPZd9Gn47ungwAFWrP4nGf8wyyA6XUToJS9cW4S1N
 psTV8fbBKKRwo+jjjD2QcnbaxdkpoqlMU461CESu4148sxZdSTbPN07ThTub2N1E8EU9
 fT3Qjfqo3BoL3H3MbMdQLjLWnuO92pjDM8l4mCqDCm6HnC1r1Z6cjycJ8ah0KTIJWfFe
 1/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aFMzcf+hN3Rr1e20J/jQpSd0pexSApBj+4ZzK/gq6w0=;
 fh=OvKzi3YaVdYQcj/ttN/1Uz8prEoy1Xr2B3QHReZfFdY=;
 b=USOckV7SqPWfBZXZOpfTCUf01rb3+BghZ0Y/KeUWcTEN/+bnXGhVGHg9QLzcRjVxea
 L9zN5ujNjJWkB1w0BlWu87ho9+DiJE+G99ujgKXntjMYoPJzlYrJjmrkpZDwXsJFfBTc
 C9V9NOpXatTkLxGqanxDmfogs1EuEAWXtVOaLKmqz+x8BL3yySsuywxW+eR5yWkHkxNt
 QL5WN+dvKE6xNpkH3BelGdJL6rWwd8GnYry4pHHrrU1Ww4LvfxpYQo6juQwqQ3J8DF1s
 AXTx2iYPVCgDq/3Qh1XDUnDoCovPBzq6ocE09jZt3d5d6bW1NRRvFstO053azzFb0AHQ
 xU6g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774292479; x=1774897279; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aFMzcf+hN3Rr1e20J/jQpSd0pexSApBj+4ZzK/gq6w0=;
 b=d/0n0QOWVPcdsxsNfVg6HbGAr9ImvXKt3ecrMXLLnsuCGuQIMgCZWkHs6DCp+Ify4C
 o0gAbn8IPQO6gwUprz8KCj/N7OyVh0MB+7SyCdqBo4IBdixo1hiofVsndJ6h9lDujdNZ
 CzM9N7i5H8mjVNCe55bsV+doa1f1+IRJgbYwittrw9w+TlM8V8zjnbOqmH8b/EzkR1JH
 EYtEyQ4jz1r3S/biSpPMRDQm1WIHJn3RChxfa7PgJmZegaUTzC5vD9DE2a4I3Y+damfx
 s3dMdYQlSF6wvN/KZTOsfEzgGHzjOnjTRv6SvWHyWNJ5voRxUZiwK+z+N579sy7wuggc
 CJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774292479; x=1774897279;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aFMzcf+hN3Rr1e20J/jQpSd0pexSApBj+4ZzK/gq6w0=;
 b=r9tbRog+vyOUqdqt0HVOlRr6pTIdgxuAkr1TGS3HTkuV0d/MqgNtEBC3kL/WbtZ9Wi
 LdMVfq46CEkwR42HcP+ilhdayVg56fVJm+pDQov1vpccKxkMZpPduFpQEXULKUeBIjbW
 NULyo2qcv5+e1ryjwKPdT2Ql49XbYElgVtpbpZhmBR1W64zlM0iDKQyngw0j91e1ZEin
 KjBmxS6AW0p825KiXDpXEdxt6tf83K1hcgFQ0VOVd7pDbmcyRhISzUIrnDFXuM1fgMvx
 LYNUfPk1S60OJTj9CZkskpYHdX62PTTlu0KkSCMEJK0glLm8AV++LgjpH8jMRw7iltqP
 5BYw==
X-Gm-Message-State: AOJu0YzHDf1/UEzIJRFCUPKxXVUZVX1HHGeYiHsrX6MtTWQKK1DqHGjU
 d9mEvWNYAt0Jv7SZUzlSohVu2q/9XeMvUDaqcXhDZfC1ikgqm6hMETYQtpImpTSTpp7u3bKohcL
 JZs4v/3hizL+EMiHRGUUAFyO//1Mbx08=
X-Gm-Gg: ATEYQzzked6r33IFIYg+okHUC2qOls/Ka2yn5HUIZvmB5JzdjbP7yWqy0Ix6EHYyvgz
 3JPZ9hL958qleIMp5Qs1eAka+qV4dQfKqk+rIDvPL9qZAS63ZXqVE6YVQqQU/HGDNrgEyWFvnNa
 OHOXMS9wYkWuoC0PGr5ckTDP8S/WanQhQXzsOcC2sN5hSioC41cPbqnPEf3RhYd66f2YxO1nk6h
 W9KyOHnyPmehLWM/klFNS/MGq/Ko13nQr8XI6LrrIHAjku8+FpJaCNQt/iY3jE7MGmEkghtah5s
 o+66exwSqniOB8gKOImjX+Ce0C7WBhx2wtcYfuiPXGUmSSGw1v7EgkiemCp1ZZSx1l0uZg==
X-Received: by 2002:a05:7022:792:b0:119:e56b:c3f1 with SMTP id
 a92af1059eb24-12a72651381mr3069008c88.1.1774292479087; Mon, 23 Mar 2026
 12:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260320200208.1188307-1-Amber.Lin@amd.com>
 <20260320200208.1188307-5-Amber.Lin@amd.com>
In-Reply-To: <20260320200208.1188307-5-Amber.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Mar 2026 15:01:07 -0400
X-Gm-Features: AaiRm52m1a7Rs1KGceuLc2vtS7mjTUNG32WuH75WwIqh7TgcpbNgTmVN3FnQccI
Message-ID: <CADnq5_NCqNEcAPC66tqcKNtM11XFRodV948Ev3zDHyMCW0mU9g@mail.gmail.com>
Subject: Re: [PATCH 4/8] drm/amdgpu: Create hqd info structure
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

On Fri, Mar 20, 2026 at 4:09=E2=80=AFPM Amber Lin <Amber.Lin@amd.com> wrote=
:
>
> Create hung_queue_hqd_info structure and fill in hung queses information
> passed by MES, including queue type, pipe id, and queue id.
>
> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 13 ++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 13 +++++++++++++
>  2 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index bea509f6b3ff..710bca87c32b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -447,7 +447,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct am=
dgpu_device *adev,
>  {
>         struct mes_detect_and_reset_queue_input input;
>         u32 *db_array =3D adev->mes.hung_queue_db_array_cpu_addr[xcc_id];
> -       int r, i;
> +       int hqd_info_offset =3D adev->mes.hung_queue_hqd_info_offset, r, =
i;
>
>         if (!hung_db_num || !hung_db_array)
>                 return -EINVAL;
> @@ -486,10 +486,13 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct =
amdgpu_device *adev,
>                 return r;
>         }
>
> -       /*
> -        * TODO: return HQD info for MES scheduled user compute queue res=
et cases
> -        * stored in hung_db_array hqd info offset to full array size
> -        */
> +       if (queue_type !=3D AMDGPU_RING_TYPE_COMPUTE) {
> +               dev_warn(adev->dev, "Unsupported queue type: %d\n", queue=
_type);

This function will get called for non-compute queues.  We shouldn't warn he=
re.

Alex

> +               return r;
> +       }
> +
> +       for (i =3D hqd_info_offset; i < hqd_info_offset + *hung_db_num; i=
++)
> +               hung_db_array[i] =3D db_array[i];
>
>         if (r)
>                 dev_err(adev->dev, "failed to reset\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index f80e3aca9c78..2e6ae9f84db0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -170,6 +170,19 @@ struct amdgpu_mes {
>         uint64_t            shared_cmd_buf_gpu_addr[AMDGPU_MAX_MES_INST_P=
IPES];
>  };
>
> +struct amdgpu_mes_hung_queue_hqd_info {
> +       union {
> +               struct {
> +                       uint32_t queue_type: 3; // queue type
> +                       uint32_t pipe_index: 4; // pipe index
> +                       uint32_t queue_index: 8; // queue index
> +                       uint32_t reserved: 17;
> +               };
> +
> +               uint32_t bit0_31;
> +       };
> +};
> +
>  struct amdgpu_mes_gang {
>         int                             gang_id;
>         int                             priority;
> --
> 2.43.0
>
