Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133F9F33A6B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 14:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A635910EBC2;
	Thu,  5 Mar 2026 14:20:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IHdZ04LA";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44C2610EBDA
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 14:20:42 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-124713e4244so422483c88.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Mar 2026 06:20:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772720441; cv=none;
 d=google.com; s=arc-20240605;
 b=WKxqvRZinYE2YUkWPrlzCBkTD7YyjmkxE67ndRz6XkRSjoAgqn+Iqlk6Uhx4ZSyAlI
 Xq08vSd/1828yDgBZt0kWqZu6H5FBz/+CH7o4EACZvDDXdBKik1wrbxaKJdZ+5yZKPmO
 IRqCuZd/j1qcXgn7HNssBVPN0w+khkR5qUn8WpQLSnRyFxz2DJcUuGct3Ukcde0KVz5l
 N/1hZRhNWFZJHvgb0GSW6NyfxWjZtL6xkT9FxVwTcAmHGnRGkGO5PEz6Y0IbcTRMW+fr
 7on3T1Soxu6b+AUJK6BDMGfE3yaLGbD1ah41mO9CqVLeM2D18oy1Avs7iFWMKxySATHr
 L23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6A+xwStnZi22v2iK85Kk/JR5gY6rsLJWVafvXpj7iRc=;
 fh=o4xV2mC7x0GPsAYfnwdZJIhsI+bktGM3lWU1YOrgBUQ=;
 b=JLqpjf7TycAiiE3EVHzpd7F7ntWF4ChtmAkYewSeKAqkr19QbM9oYSGToPKz8b71AH
 MsrQAYYd7LAk1T1Ho7OilYSw8cLifMHtM+vlZ1TTc2ysAdTtoTQTaRwIdUNzRkKHNzeT
 EdXfnAJ9U/560SWalxXje78IOGVeNh5RofrHuhORyHML3YDzTZR0+UQnn+9Xrj/3vlDS
 FY7b3HnOG1JrxOmd+BhjKrVyd3XK+YCFDXxJmViLbEymS1zZS2Zw32SyywnnxnPsuY2x
 5uH+SsbuFvW22AcuxKSBeSFnUp/5ozIXSFe5mfGjOTVXOpr3ufSfhjtFSZxIk4Sd/auR
 55pg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772720441; x=1773325241; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6A+xwStnZi22v2iK85Kk/JR5gY6rsLJWVafvXpj7iRc=;
 b=IHdZ04LACneDaYHO0wHFCYNGe2F0lHZLm8Fg2as7DON0XUMGt0NL7E++BQ0xSF1/Cg
 l6RJEGAKUaJnyS7igYEAW97VTk096kv4jnxSjBO57DKlGinzyBvItuY+qMYvqS70srFd
 aKu+t4R/fvsPl8CTZPhkSL1MwgNtfY0u49KIoeKNT3JoQif6kJlztqkSrc084FhWfW3v
 UzKS0vwijjNS/9/frP1EDaAxy6pS4mxCI3q6Eq8TaFoSI1zxHVk2GUHtqD+4xkE5iPmb
 F1pXMkTsU0wCTqZNeIQ528Y85rfNhBybiIddjHzOkNpa5OLJOetyOGdWlBsKd8Vts9qf
 hwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772720441; x=1773325241;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6A+xwStnZi22v2iK85Kk/JR5gY6rsLJWVafvXpj7iRc=;
 b=G3erz4m81xEyBHRV6aHljlluTZDrcvNaUFAGD+AyAtYPDjYXuKFB99v0iTMtl7+U3Z
 pFJ+Zb+T8nRXw9ki85qGkMBRUdiZXwlX+LrIABTkp25MFgD+SClhhJN0uJPxVtQoVJDk
 zO6nyACWtJomvNt2Qz28Sx5YkURawlojLCkv+V+eNdJMI5wUMnERmQtWQ2cCIYRaaqU9
 ZSDC2uaLjkbXY4+K07aiOSOD7uEy5HGixdsTN5Sxa4V5/AFqGpONRWrZIhrNhayIaLDj
 wN3lbXCmbgHp5kNN+ZYcZnUR43UpyRQ2GBSZbb9D7fS+hExa95kG45dBxWK+kGoZHJp/
 Tjyg==
X-Gm-Message-State: AOJu0YyvEZGPC0MjdmlYPfTyI5CRNmTWFZBgvPHoboohzsJb9qxyhe4n
 ei1oeyez0GpYdVg8ugrkOYWAmRf9jrxDUoGvG3mOW3QbIoVKMspqLyan6KZvkANAP9sxgmp4vCX
 Rm3TFwKnCkagQm19pvGTz7qUjAeKY440=
X-Gm-Gg: ATEYQzw4LOCXriSv+9K2jSE907BdrNlnsfZSFgH85ZhKNr7mTe+3PF9XYWFxEbhkHUx
 VyoGfmJij6BB7TIqgNFsIIaKbUKD3Xmhr6u+6slYX5Ix74zzTXWoTbqhtaMRWyh2MfYIWe37j3j
 xZemFCqy/ndJW+KgBDN+wcVgYCOc/UMyaDKzdN8w3jHbsCyRvyLK7rks4uJLcjoSZLR5ObicAeM
 9igh5O3ygrvMn64iZyBdIrVmDmPp/XSNmdc9r+f/AedAfnliIlnGBTjkVWfrorbXjQuCVCA3+Sv
 KIAigeJSiSLlxaq7aduMFYc9F6/RyoSU5wnWC3qolREXTzqzhZpHiPnokhi7OoccK2Jhxg==
X-Received: by 2002:a05:7022:6b82:b0:127:3480:7ca9 with SMTP id
 a92af1059eb24-128b7066280mr1286506c88.2.1772720441437; Thu, 05 Mar 2026
 06:20:41 -0800 (PST)
MIME-Version: 1.0
References: <20260305054835.962639-1-kevinyang.wang@amd.com>
In-Reply-To: <20260305054835.962639-1-kevinyang.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Mar 2026 09:20:28 -0500
X-Gm-Features: AaiRm53fx38mTULb4cxS_4CyPwtfYr2KLze3EtTkfq77XDM5Es6YfeUo5sSELCw
Message-ID: <CADnq5_Mo=VrkWONW6A1AfsFG7faN-C8gCw8+7Kb1RS6Zn-=Tfg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix gpu idle power consumtion issue for gfx
 v12
To: Yang Wang <kevinyang.wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 hawking.zhang@amd.com, Jack.Xiao@amd.com
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

On Thu, Mar 5, 2026 at 12:48=E2=80=AFAM Yang Wang <kevinyang.wang@amd.com> =
wrote:
>
> Older versions of the MES firmware may cause abnormal GPU power consumpti=
on.
> When performing inference tasks on the GPU (e.g., with Ollama using ROCm)=
,
> the GPU may show abnormal power consumption in idle state and incorrect G=
PU load information.
> This issue has been fixed in firmware version 0x8b and newer.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 5bfa5d1d0b36..023c7345ea54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -731,6 +731,9 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_m=
es *mes, int pipe)
>         int i;
>         struct amdgpu_device *adev =3D mes->adev;
>         union MESAPI_SET_HW_RESOURCES mes_set_hw_res_pkt;
> +       uint32_t mes_rev =3D (pipe =3D=3D AMDGPU_MES_SCHED_PIPE) ?
> +               (mes->sched_version & AMDGPU_MES_VERSION_MASK) :
> +               (mes->kiq_version & AMDGPU_MES_VERSION_MASK);
>
>         memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));
>
> @@ -785,7 +788,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_m=
es *mes, int pipe)
>          * handling support, other queue will not use the oversubscribe t=
imer.
>          * handling  mode - 0: disabled; 1: basic version; 2: basic+ vers=
ion
>          */
> -       mes_set_hw_res_pkt.oversubscription_timer =3D 50;
> +       mes_set_hw_res_pkt.oversubscription_timer =3D mes_rev < 0x8b ? 0 =
: 50;
>         mes_set_hw_res_pkt.unmapped_doorbell_handling =3D 1;
>
>         if (amdgpu_mes_log_enable) {
> --
> 2.47.3
>
