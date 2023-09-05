Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F8CC83F33
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 14:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74B7010E546;
	Tue,  5 Sep 2023 14:51:04 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D77AC10E546
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 14:51:02 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3ab3aceaf2aso1080870b6e.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Sep 2023 07:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693925462; x=1694530262; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O6gwk/b6dDaGp1L2z1Zqkip2uOtGqBNxtTQR7yQDwy4=;
 b=oUrHy99bzVUYMAiiD72tYhZD1tU7G7gRssHzGhpWsCEmRDTIBryQuLk8YCtQAufJMf
 T/gUCb+RYfB/XfTIcl/GNDQuVlBOg7OV15/SNgmnGOjmnlDsMiIZLiB7+kL/fdeR4Wzz
 mqMjILKUUk20/dJYhGCVV8j91sC8SK9ualQEZ8Qidknd5R4EwcCaiYbZZyUq4pu35dOf
 KngQcAnZJjGWzSyZkiGNk/DIkryxAhqnbeX4AgSkLnhhhIolzr6pWnqXoUVdtwgYR+Oi
 ef9xeMAHGQ4IrnFgI9h6QIFem4caDX/2GivWdA/vEENIhcxl/Azejiq6eLMNF+vZEVLs
 IjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693925462; x=1694530262;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O6gwk/b6dDaGp1L2z1Zqkip2uOtGqBNxtTQR7yQDwy4=;
 b=SxeuKGDThN+cT4nGp2SmmWEz22Y1K7C/XMZbLJASkqOzBbsMkICmP0g2dskYjZttgB
 +sVvFZmsGWLbwZnah8sq+OxGhI6EQdBVOCKchOj/gHOpGKMda37JVkMh9IhJNptSPJwL
 cic/mJ8IuL2SPFKOaTifxlZqwKgPKXSKZIhqmk97JQtOAuXffXuF7Yp93Cd2AF0uSZwp
 AuCjqwsyDLxTs6jqJIF7yst5eEjR8KyZtFBCVYRh3rHaek/lnNUHL65cuXSVrcdIcxgS
 cWZMMa1XeJ+sqMMgtYkbxT3qIAI348of7mQMM5vfJhPhRycyrTkOoDAHYADK9W2XG+vp
 24Ug==
X-Gm-Message-State: AOJu0YwI4TTDfnINTDzXYN/+BUxwgJvMSI3CfDaBl2wYf0pOewMowMDp
 cvDLNPKphVsWfA89SKcHGgm8GCyC3fdwi6o1zT/kQWU6
X-Google-Smtp-Source: AGHT+IH9Udb7RZh+QY4QV/o11to1EodPxN9qmMQPN+S1ied2eyd14TlEBpVTo/nrrehvd92Ga09y2/BbPEE2rSatnFA=
X-Received: by 2002:a05:6808:128a:b0:3a7:b5ea:f5e8 with SMTP id
 a10-20020a056808128a00b003a7b5eaf5e8mr19678149oiw.27.1693925462051; Tue, 05
 Sep 2023 07:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230904131027.912234-1-lijo.lazar@amd.com>
 <20230904131027.912234-3-lijo.lazar@amd.com>
In-Reply-To: <20230904131027.912234-3-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Sep 2023 10:50:51 -0400
Message-ID: <CADnq5_MGGCEgSHM4-ZdFZiLX+b50P-bEC=EgB3ZrW7=Zp94GUw@mail.gmail.com>
Subject: Re: [PATCH 3/3] Documentation/amdgpu: Modify pp_dpm_*clk details
To: Lijo Lazar <lijo.lazar@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 4, 2023 at 9:20=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> pp_dpm_*clk nodes also could show the frequencies when a clock is in
> 'sleep' state. Add documentation related to that.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index 84e1af6a6ce7..3dca1aa473c8 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -983,7 +983,15 @@ static ssize_t amdgpu_get_pp_features(struct device =
*dev,
>   * pp_dpm_fclk interface is only available for Vega20 and later ASICs.
>   *
>   * Reading back the files will show you the available power levels withi=
n
> - * the power state and the clock information for those levels.
> + * the power state and the clock information for those levels. If deep s=
leep is
> + * applied to a clock, the level will be denoted by a special level 'S:'
> + * E.g.,
> + *     S: 19Mhz *
> + *     0: 615Mhz
> + *     1: 800Mhz
> + *     2: 888Mhz
> + *     3: 1000Mhz
> + *
>   *
>   * To manually adjust these states, first select manual using
>   * power_dpm_force_performance_level.

Might be nice to update older asics to follow this model as well at some po=
int.

Alex

> --
> 2.25.1
>
