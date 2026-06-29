Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3867C43638
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 14:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3921110E8EF;
	Mon, 29 Jun 2026 14:08:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dj2r8AEp";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C6A010E8EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 14:08:47 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-30e869ebc19so135540eec.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 07:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782742127; cv=none;
 d=google.com; s=arc-20260327;
 b=GcgTGtOO9akwoSuYiPd5VtSqhy/YBrqRfrtEXKWO016sWiY0Tla8l9iUGwCcOEf1EE
 gZREcXELOBmgAY7NL46ZfpH0CY5+1mYUM2J98sygk6LVgblGsT5LB9nHw3BrHDV+rwgU
 wjYTJ2UgnuPsYBL4Uz9PlGAuMPp+BwT36reqWSkqCOVomGBA7CtqXkKMWnvr1xdUNBdi
 9tH2cAtWOExyGesqMyTdU5nchP4BlkbDGHb3qntz8j6nA+Uh0tSm/kbO6EuFfmVJk825
 T6ORgc7mg2jIuyb++vbPjswvkTzWF1Ox7FQvu67yszHS1P6Y1c2KBeVpTb4sVx9SqXXf
 8Xdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Os15Gfb1V7YzcgtVAdxiLtA7ZwjEE8StN2sYmzj9v3w=;
 fh=jgvQxTQm+X+l9xqrVP2NK6hI3g5K2nQTz6oz8pyfh3Q=;
 b=It/LMN9c6Xt6XR4ao3m32GQN5l3vMqvyHzvoIDFzPLaDXWX4YFaentgv6diuVSTfKQ
 KrUKajAsPxkSnK2SuqjBfaA72nsq3gj7qpa5vnP969+3S+hmnUwxd18VsImK9coh7hEo
 jMu1liWAQTvcCxMUYYb3EM//nFbT3YKGFuWJ3oiQZ531XFUFHfzFswTtDhdA4jjzHJp9
 94fpUiiiLLDv83w8i5bBFkpdxwaPh77ShS4DcVWb4uSGcyHRxdSdcWUBF6Edkccy35uF
 a3nNT95Maymgw21xnC916EUYi/AmCmt9/ykQ/wdxCioPKynTYPN7mZbTIuyDGUMaSDYs
 LlpA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782742127; x=1783346927; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Os15Gfb1V7YzcgtVAdxiLtA7ZwjEE8StN2sYmzj9v3w=;
 b=Dj2r8AEpSjQau0UDLftH0HSOe9VZ+p9oGJj/djvhMO2uSmbcp6zsxiiWd2wX8VyIGb
 hea1KRf/Rq6lEr9exeYaApvz2PAp7Kvk4n9XqAUGv7btq3OAHxHQUuq2GZxw8UYq5oZR
 y2CiCEMcDdtUNqG5wGm/1jFsS4UsNTKX+AoKYba4Y90n4Xxdqfol2s86bJJyj9SP67Gr
 bcxWY++gtPxsd+zFfDe8GAAe4y22qYBOdWjJG7jltfJGW73o7/5KmhCLd3K0/GkdHY7p
 39/1lwQXNq3EjTKjb7NeQFj6dRKriA2Tp8mudrYTKNG0E0YZIa1/8eucl44m7AIk1guY
 M7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742127; x=1783346927;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Os15Gfb1V7YzcgtVAdxiLtA7ZwjEE8StN2sYmzj9v3w=;
 b=Wjz4w+dEet1C4Fo+LiQMZ1OoYvVnLLxX5yDgxa6wI/TwHeoiT9s2fOV2OH30hAvZta
 9kRwCA8Wxx/cRzV6HqY+92oEJH2haFGoy3nWKdBZ+OvsKfN3lmh1ptnRyCNEZbq8fUd5
 nu+X7H8dp+P/zchl26+civ8fOK1JWxUNfCG92tImKHgoZ6yuLyidjtSSE2LTcr+61VK+
 iLqwyeTefUBNl9NzBoTPuPE8/T7C1VNhTLQRjD/C7eUzlzVhhK3H71B7cqPweK1+ayR4
 uE329nGJHJqBF7PbJb98URTnHIheZC0JpeYnstmstFYm8DejimbhsbOYTuDi+t5+pTHk
 1n/w==
X-Gm-Message-State: AOJu0YxUuSszqtuu6G3i/rFM7OiYfOwQo106XkMe4i0BFbgTSE1tl7S0
 XSuZLSy/GXPMeZ5pbTUMCbbMxDKNh0h4xZ7I4gxkxQsewtbZ7Ukbzzaba75vDnxuwxmLeMTJKLK
 Ojj43fRU9DHFhTLfr5De8zy6CTSbeYPDGiw==
X-Gm-Gg: AfdE7ckod3h6I6dzIZj3Rp76CepoVypqXIYQB6dkVgzBA2akH3zlO9n2I2Bv5MChvlt
 LBShpgMlbUcIYm7/D7+WUx+AHAGVOqvnSjGrNnDL0BbwNhh8U8O+tXeGwgJ2vX41u/fKI336nU8
 zEBJvBLtkq+1aSOrmTA+uuctqERs/cM/wzT5SNB6uuxY74Sra0Qb2k2UWiAPMpFdaAWjSMpxl50
 ddBHjr5FqptzfKwJ4/1cCMip5yzwBO1d7JLZN57GDUzV3TRKrUkjZKd/mu2pV4IO+MxZdSRAu0c
 Rom8cB6vJq61zI7U7+LNUjl1sq9L3WkvAu1VD2jfXf1P5qvpJZfKnOLT0rQ=
X-Received: by 2002:a05:7022:459f:b0:138:2790:149b with SMTP id
 a92af1059eb24-139dbaec420mr7750670c88.7.1782742126690; Mon, 29 Jun 2026
 07:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260625205836.125081-1-Bokun.Zhang@amd.com>
In-Reply-To: <20260625205836.125081-1-Bokun.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 29 Jun 2026 10:08:34 -0400
X-Gm-Features: AVVi8CduXf1QCoSP1KOrxTYjpHVsndbdzo9IznkJsYaLvXZAHY2BlqJMfyuIQUE
Message-ID: <CADnq5_O7GQG1+xGEhetXQk-FTs=m5gdoxT3HEaNjC0xUPrX+2g@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amd/amdgpu: prevent CPER rsp batch index out of
 bound
To: Bokun Zhang <Bokun.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, Jun 25, 2026 at 5:19=E2=80=AFPM Bokun Zhang <Bokun.Zhang@amd.com> w=
rote:
>
> - There is a bug that the host CPER response struct may
>   contain bad data so that it will lead to guest side
>   memory access out of bound
>
> - Must move the variable to a dedicated variable
>   and compare the boundary
>
> Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/driv=
ers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> index c6e7aa6ecb8f..6049b3392a9d 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> @@ -204,6 +204,7 @@ static int amdgpu_virt_ras_get_batch_records(struct r=
as_core_context *ras_core,
>                 .batch_num =3D RAS_CMD_MAX_BATCH_NUM,
>         };
>         struct ras_cmd_batch_trace_record_rsp *rsp =3D rsp_cache;
> +       uint32_t rsp_start_batch_id;
>         struct batch_ras_trace_info *batch;
>         uint32_t trace_num;
>         uint32_t offset;
> @@ -220,7 +221,11 @@ static int amdgpu_virt_ras_get_batch_records(struct =
ras_core_context *ras_core,
>                         return -EPIPE;
>         }
>
> -       batch =3D &rsp->batchs[batch_id - rsp->start_batch_id];
> +       rsp_start_batch_id =3D rsp->start_batch_id;
> +       if ((batch_id < rsp_start_batch_id) || ((batch_id - rsp_start_bat=
ch_id) >=3D RAS_CMD_MAX_BATCH_NUM))
> +               return -ENODATA;
> +
> +       batch =3D &rsp->batchs[batch_id - rsp_start_batch_id];
>         if (batch_id !=3D batch->batch_id)
>                 return -ENODATA;
>
> --
> 2.51.0
>
