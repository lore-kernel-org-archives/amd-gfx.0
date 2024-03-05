Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1473C54798
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 14:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A18A10E0A3;
	Tue,  5 Mar 2024 14:13:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EzfH4ovb";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFFB110E0A3
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 14:13:49 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-6e5eb3dd2f8so2163857b3a.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Mar 2024 06:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709648029; x=1710252829; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NK/StaZZbObzLpdaocrQ0rbwJ+yrRS//FXROpgmbfZA=;
 b=EzfH4ovbSUYD7FGanePAk7GP2Cg2ld04wjwK7D0M4xM4Z+aBK16BRt3+iGS70MyGjF
 S37Oj5hKGefq/3MP2AoN56nu6+jZdpelfPGQVM12eopk5dCnlKyWrf7wOk7KswOKv8GS
 ELq7TddsV7II/BIz8Gqob9fpo5prPUeh9vp7b7aG0b9MuApyajmbKl49BPr1UJCR19Kg
 H2LoN+LqhQ6zRS7VxquzMsWPBvyBJfKH+IeVTZQm3k1Ttpd1EbQYO7P5dgC4epgs1wpS
 TovzH50UeSU762PQ5LrHyyOR+F10mssZdyrVj/mgEoAEmyHRFi2IWAWmUxxf1UuIKIP3
 A+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709648029; x=1710252829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NK/StaZZbObzLpdaocrQ0rbwJ+yrRS//FXROpgmbfZA=;
 b=GBELW6IxoiVyZFG4VFUFPFEhnu1nHx+ihsFOVvp1IIaufic85t/2xLtCTDTD72veWD
 IeQcOlB3tfCJyfPlvElwIMMuA9mA2y4yf8Ss2dxX0Buco3uIXxv7ckZ+8iaX/TPjoQrS
 LRyRUZrarGkd5wd2Gg7Hob0yJytf3nDW8G7oEB8rUeAbBIu+QnnZ3kd1vYfFnEVx4Vug
 tOGmzyOqDWM23CawTJGfUrjdKQCSVu09rqH5Vt2I3eP2xBNDoC2auh1LTzJt+zuqqL9b
 yHI7XJ8nG3LpQl11c9p7plRr0rOnnQg70AJiIoS6ewLvRxX94fab7e/48Imc3v32Xs6J
 ZB0g==
X-Gm-Message-State: AOJu0YyTTUo9D0A90s4w6Aag3OiKvttKrQbZxFomLcUucJJR1ylxndru
 jZpod6rtk2mzgDrQIx5x5EppIlToF3VYuZWdrJy/P77wbBkKbZIC04O9yTnyaoU3c3fGiXepnLW
 Kk5cimIL2OA/o8Zxu1ovGF2stp3E=
X-Google-Smtp-Source: AGHT+IFFozveCgZWKbIXapRxP6aVVUA+7v8xdYCr+hTxFq5Xp5J9vSq3If9BuDTxVTes4l88MFNcHMZ4eUdeN2ZDY0Y=
X-Received: by 2002:a05:6a20:d81a:b0:1a1:4846:116a with SMTP id
 iv26-20020a056a20d81a00b001a14846116amr2255349pzb.15.1709648028969; Tue, 05
 Mar 2024 06:13:48 -0800 (PST)
MIME-Version: 1.0
References: <20240305011926.1518752-1-yifan1.zhang@amd.com>
In-Reply-To: <20240305011926.1518752-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Mar 2024 09:13:36 -0500
Message-ID: <CADnq5_Ox1VJ0Nq3haK_F=ihrWFQ+stMOZqhXKYUa=U1eAGYvzA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add dcn3.5.1 support
To: Yifan Zhang <yifan1.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Hamza.Mahfooz@amd.com, Harry.Wentland@amd.com
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

On Mon, Mar 4, 2024 at 8:28=E2=80=AFPM Yifan Zhang <yifan1.zhang@amd.com> w=
rote:
>
> This patch to add dcn3.5.1 support.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 502333725b49..72701e7f09fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1936,6 +1936,7 @@ static int amdgpu_discovery_set_display_ip_blocks(s=
truct amdgpu_device *adev)
>                 case IP_VERSION(3, 2, 0):
>                 case IP_VERSION(3, 2, 1):
>                 case IP_VERSION(3, 5, 0):
> +               case IP_VERSION(3, 5, 1):
>                         if (amdgpu_sriov_vf(adev))
>                                 amdgpu_discovery_set_sriov_display(adev);
>                         else
> --
> 2.37.3
>
