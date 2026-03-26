Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B583710A88F1
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 18:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A37410EAED;
	Thu, 26 Mar 2026 18:01:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rcjQvwOr";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D57710E066
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 17:56:32 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12711867ca1so84992c88.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 10:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774547791; cv=none;
 d=google.com; s=arc-20240605;
 b=UMhgJvAqm9lIagduH52js/BvgOZj3LUNC3H6wrToFyREmE39Y5m/TfkpEZMexx/dUu
 W2GaB1y/w4CG+bgEiNqa8vX7OldtIgKfbJbtvfbibPvKt1p8kvpu3ltCksfLbfFt1Nfl
 yhzIL3vzPXGcZBkbfppooB6S4zZwkFcRditqdV9de35uuG/MIkp8O4MnXMQu5b2OqkXd
 5enpwe7fHMNufVOb9owXYPkykQqeXeAeAGWvCjJCLQOq5b+PiiiMmLCE2qbo0eEt67I/
 LMah6I5lCaDMg5jFFj6ly4sLfcl9Dhbi7MI0UzBthN5HKmYq/FN8BOsAnrMNZ5q+jfln
 Luzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KMnbUlxKQb4h6CzFf/mS8L7hRwZYUsFXtGxYkUbQSww=;
 fh=OvKzi3YaVdYQcj/ttN/1Uz8prEoy1Xr2B3QHReZfFdY=;
 b=Wz1dYIBYJCgpJ0H4F/GSTRouQ49ae+FQUQ9E9nt3eNqSyMqpGiLaFjOjEoOx0/f6vt
 RoykIjBejSfzR/HiQ5tNikzxL80CWqv4TxM9v4l56TO8IyX4ToAGCCUqFTK2TM258EyX
 PwY+Id7aBx/TsXmeGtJnGXY/YiXqe2zVrE97yuuPxDSvlK27SASLNyHN9OAhquwxLd63
 UmB6wpsY+iwZpNo69PZNQ3TixCjeKbHvwlYgFYE1abctK1g9n8jnmsXZhVxiTsszYDJK
 iIf+QrSgsUuSVNpNn2Nf92wUaebSZDJfuf8LrWSz2W7JKGjXWaYjYYkrZDWKca4oKxiA
 CxJg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774547791; x=1775152591; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KMnbUlxKQb4h6CzFf/mS8L7hRwZYUsFXtGxYkUbQSww=;
 b=rcjQvwOrPmsiIESnY4E9JHlcLSQLrGdQFGM+NhWpPclO4JmjEEXoCSsH9bnK2W+XCN
 21freCC1BzD9sPu6sxBJ0MVtxwVGHnn7LVHlW2+B7DTAICDa9L20nHX629l7hPp4+f/c
 KsK2AtFR4L0tU/eiaop1ZdGYnzENyhmLtOW58aB+DkMOBhGZudpFo85FnnLoq51N6P0C
 KqEMnYG4tCIOtU716k1CVSKoTcBbPcWvZsFRgaZ1wQcSin2qiVrZMJovt8wdvnNQxY9P
 0J2Irrxr7ZKeQkkxb4z7zFgFeR0YYjpLCSx7T/yAvH2uAF9GUJVzWs0tYaprSBTrKa1D
 EQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774547791; x=1775152591;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KMnbUlxKQb4h6CzFf/mS8L7hRwZYUsFXtGxYkUbQSww=;
 b=D7aiis77qGMi3zuZo3rEdFW2b2qOIHpeq+DEYb7klIEveWTeEEWN2iEkdxrPQqZJMp
 iIqE+43Cn5ANjTPgeSNHCaLqdjWONuEKkszMi9U1Qqqz/3E70RqJ1bSeKcB/i88whMCm
 eK+stt1w5lDqCCs/AcBuwVZHPryn8AqJV4n+57DaDAklHWZmsGfDmTQOg9HpPpTURDEH
 CvqQHJkLzIMMELYXiLP2cARf+VyTL184VqCUhrTQffbmRCcAEh6Ch0C/guRT7vgFeHof
 wkJpUTNR7+t88PA38Qh9HCaOCDXDcXvxlvLpGMlv6ux0z95ED5NnUAds/xhmt+IzUgBa
 8UzA==
X-Gm-Message-State: AOJu0YxINIvCu0M9w0f6cSQ8EP95DN14EQ35VQM90DRMwsjLlXnds/9b
 iuT58BDqNg/nivZR7+gQf+EPzd8GFs2mTjfi17qYajaIVdY2zmRZLjXE40q2nyAANnXe70cVVnq
 OB3umsF0fKxUWepCSJ1+5yAK5+D8HBNY=
X-Gm-Gg: ATEYQzyu9XoyD5s3fmqS9crmoz9g7PGZALzvWu7w95Mc5gscZ4RCY1zApCS04nK6lvo
 MqBx5LAXFn/HlNlMiVIhRR1Gy3UbC4C4jo3FX2iAengC6kKXnkGFrn7b+JKrKo6v1uDSYa2N4gi
 TFgIUGHHxmXH1u91E9FuEJMqQ1olxV7HSKzlsZAB+VV5/1PnPyDGlVYmKfD6tXwefrSpVttBdsM
 B+a6pSlyA0rj5DEqYVozD0pQJln5PnrsTPw9BNVf3UjOvvsRs31t1WLyzrKAc4YKrgW8DN85irW
 qDHRHhQeoFaZTw1ojwJKrdCfWVaW1uJ3uOLsn4unIoFTT0Vutwmdc4LFq18TcATxywnSKQ==
X-Received: by 2002:a05:7300:dc0f:b0:2bd:fa8f:77f4 with SMTP id
 5a478bee46e88-2c15d3a2f78mr2385938eec.4.1774547791257; Thu, 26 Mar 2026
 10:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
 <20260324175653.1325754-5-Amber.Lin@amd.com>
In-Reply-To: <20260324175653.1325754-5-Amber.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Mar 2026 13:56:19 -0400
X-Gm-Features: AQROBzCx7J-2O_Se1i9jUF2haf-k7ORYIdx2KCk7RiMtbOg-g-TYqpznlnE1Q3k
Message-ID: <CADnq5_M_Gi8wCxpbHecpfnJRTWK-ibskpT_oTYR1Zizk1d2tkg@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] drm/amdgpu: Create hqd info structure
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
> Create hung_queue_hqd_info structure and fill in hung queses information
> passed by MES, including queue type, pipe id, and queue id.
>
> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 11 ++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 13 +++++++++++++
>  2 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index f1f8bbfc31e0..d778c3da8203 100644
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
> @@ -486,10 +486,11 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct =
amdgpu_device *adev,
>                 return r;
>         }
>
> -       /*
> -        * TODO: return HQD info for MES scheduled user compute queue res=
et cases
> -        * stored in hung_db_array hqd info offset to full array size
> -        */
> +       if (queue_type !=3D AMDGPU_RING_TYPE_COMPUTE)
> +               return r;
> +
> +       for (i =3D hqd_info_offset; i < hqd_info_offset + *hung_db_num; i=
++)
> +               hung_db_array[i] =3D db_array[i];
>
>         if (r)
>                 dev_err(adev->dev, "failed to reset\n");

I think the new hunk of code should come after this error message
otherwise it won't get printed for non-compute queues.

Alex

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
