Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838A7C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 13:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F36DF1134F8;
	Wed, 17 Apr 2024 13:19:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PCHiAktw";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51E1B1134F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 13:19:50 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-5d3907ff128so4395939a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 06:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713359989; x=1713964789; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MClVdYP0OyNZYFU3Ftp/4YhgIQ8JeYL0NFYzsOAXVA=;
 b=PCHiAktwNMvCgCz5gDi/6dTVXVOEF0uTCtWBXz3xY4MM7f62tiQdWrMi1PGKvT4DRR
 SEVLFrI8qsV04dhD+2iILI13vbkI7clL4jIPSrgWH0ZpEb/LLAujaSSqf+LMRgXHLAjx
 DKbp0+ZSAkVrRaI+Llt87ePJmoSSLAMenBndO0fMxevbQsoXaZZfvB1Ktwi/r2ke+BYU
 RFEIMl5F4WrcBTgKSgdHqjhhWoihvqAZ/Whbjl1JngJsWjaSXmFzrM0umO4Iw0j8U5Pw
 PJCuoKhsAt+wC37E/GppnEsxuBwdDdkMlVvLy5Xj1IwCRNcXP0Ju6fyLclsuW5s1vtlr
 XvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713359989; x=1713964789;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7MClVdYP0OyNZYFU3Ftp/4YhgIQ8JeYL0NFYzsOAXVA=;
 b=YoD5Q1CqYistTgNnKgAyrMqHdJhjY/BWUukeIOlO22v9tk+YE12lnb0EmqC38wd6Yi
 WEA2+1TIs/gR1AC1oiexUE7ghyMqlHpuBSC4uiZ4Pdi7w2zxC/2xr4X9+QC9wyd0C65t
 VREfCKBP2I4rLA17HoYdWWKN+C9BQy2nz0+rVmsLdI5ED6Sfcx7RNmWNOJpoc9vSoUKx
 hDiv5/AxdYytoTozo4Msz5hZpPZ1Nib4XtPAWo2J8hTR7s8xstjtknLgSDQlVQA6Voao
 Igq397qWaYPxwcLXPHM7CflNQ750GjomvDZNU+6F/RSoSTZi49OVGv0OUdv2O94L1kG6
 PX3A==
X-Gm-Message-State: AOJu0YxahJRmXCsQZ4y0BCMlmcLxU524mciZO4/arPVVjRQMcyyEhAAj
 SgS6IZ2Q0VG00cN5gL8Gj2XAgxtZa8BBDbNuyjod+rUj6T8z+gM0sKcdWQTDgfJmmXCKaoHDlIP
 kO1CZsWNendbkHEHqbEnlXlQB7O4=
X-Google-Smtp-Source: AGHT+IE4umWef1apDJMRUxfaEMsuxQ+i72YCeLCdYIlS5Jo2SAObrvKGMNlTDK+sqDZA3DdzGyCIvOLEKUaxpjx4w3Q=
X-Received: by 2002:a17:90a:3489:b0:2a2:88d:cdcb with SMTP id
 p9-20020a17090a348900b002a2088dcdcbmr19060484pjb.26.1713359989532; Wed, 17
 Apr 2024 06:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240417115743.167530-1-lijo.lazar@amd.com>
In-Reply-To: <20240417115743.167530-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Apr 2024 09:19:36 -0400
Message-ID: <CADnq5_Nu85f-UkAwnVzizxwKMhmW6UN11JuBpx68Se-SpLhm1g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Assign correct bits for SDMA HDP flush
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Le.Ma@amd.com
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

On Wed, Apr 17, 2024 at 8:07=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> HDP Flush request bit can be kept unique per AID, and doesn't need to be
> unique SOC-wide. Assign only bits 10-13 for SDMA v4.4.2.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index f8e2cd514493..09e45ef16c0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -368,7 +368,8 @@ static void sdma_v4_4_2_ring_emit_hdp_flush(struct am=
dgpu_ring *ring)
>         u32 ref_and_mask =3D 0;
>         const struct nbio_hdp_flush_reg *nbio_hf_reg =3D adev->nbio.hdp_f=
lush_reg;
>
> -       ref_and_mask =3D nbio_hf_reg->ref_and_mask_sdma0 << ring->me;
> +       ref_and_mask =3D nbio_hf_reg->ref_and_mask_sdma0
> +                      << (ring->me % adev->sdma.num_inst_per_aid);
>
>         sdma_v4_4_2_wait_reg_mem(ring, 0, 1,
>                                adev->nbio.funcs->get_hdp_flush_done_offse=
t(adev),
> --
> 2.25.1
>
