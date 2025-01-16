Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332BFC02187
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 22:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1F6E10E39C;
	Thu, 16 Jan 2025 22:16:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rb4q2X3l";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 392AC10E39C
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 22:16:35 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2f45244a81fso304187a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 14:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737065735; x=1737670535; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eyPx9EeLTD7i4zotwFfdjlfxqaq94aBkteHQeYOIw8s=;
 b=Rb4q2X3lh20Yu9QKIdSrOCtwXSb8aQ9maQmujfV7VPSzKw4DGD1WWkosX6aoNJ6B41
 s4dXHXYm+13wbHw6Sp4o5zSEErfcK96BSjbJjEGdGBPTCjcd4dD+Jt7896qAtUL/3Cy5
 1/dABWmMFPpRsX9GZZcd5+OZ7wGgzN2e5ExjFObD7SJvHIAre64vXC6XMu2REVtY8c6a
 3y8ZmOntmmyNsUScfrQIMpwEnh+eTXkg3H/j/NdOpYAGIlLEf26TxFDBKTtw5/dohTHq
 hm/R/OFHX4HG9ZGjqK+NOPvPdK9XFskgvODaLFhd+KFUy2dpAnWCB1FS0wx8OUYyklru
 6QoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737065735; x=1737670535;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eyPx9EeLTD7i4zotwFfdjlfxqaq94aBkteHQeYOIw8s=;
 b=GRnrgcvprpDLV3UoIB3je7/hgtLjz45xl2Goa0PvML4xA31pjkdXAXjqElpDYfa2hM
 EG4BwG7F+zjAgUXmOoYEpWCi5pgeJgVBT3bD/MFqSHVfV26QobvB3peHxhbE8aTT6p2r
 NkoSchtekiTMV8qla3jZ6TEztJlqNXFzB8bXiiFbt6o34oTXc8QrEQdy6Qn/Mpm7Rka6
 7YO//NuBjwT+h6v4t+Q8AgsK17z/ingnEDJwOJCsMYLfvXiRsqtQ+DoibhXVka2k3fh8
 BDP68GkWgDZh8lBhot804TiAOvpifjw/MxU1dRE063cO8e9Jju4yG5EA9ocMq2RIjq5U
 cyJg==
X-Gm-Message-State: AOJu0YwVrZeOcrAmX6DB8MUxmgB6YRZBRdQXljB2IOqndSNjpJfGHyFE
 vaG9/K7tz/PtGD+vJrRM6CAPqEqV0KfwsF5dxjnVQrD9Lxs0OfaRRWV9/lVRqh9Jw4y0b/aJV4x
 W5kCjmK/wBj1NJi0W9aIOWIdc+9nCTA==
X-Gm-Gg: ASbGncurYXrQLwKRMjOa/M1IaPrnSUtEjWbzV0KjhVy4wLN4aLlxADfHQdsk7iAZLde
 EcJ4H9srhzHcVmXsb7PeGPAlga0os9HNOQ/w5Pg==
X-Google-Smtp-Source: AGHT+IHQKM2pv+3y/y3qNdGTJSXNvZ+DJx6VYmnFtzFRfLFo3VFAIt8YfDkqXM2G5t78Bdy5wp+ozdMUGAUTs2CU8tk=
X-Received: by 2002:a17:90b:514d:b0:2ee:f440:bb93 with SMTP id
 98e67ed59e1d1-2f782d90afdmr125418a91.4.1737065734825; Thu, 16 Jan 2025
 14:15:34 -0800 (PST)
MIME-Version: 1.0
References: <20250116220020.2425025-1-superm1@kernel.org>
In-Reply-To: <20250116220020.2425025-1-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jan 2025 17:15:23 -0500
X-Gm-Features: AbW1kvby0NxnsOP3ME79XkJdCS5Tqi-3nCMHd11st_4wNuWIM9ybB0WHxnctmSg
Message-ID: <CADnq5_N7aw6234g5S9hT9B+F41vdHbO1UhRcgK5M7QFJxnfUbQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amd: Clarify kdoc for amdgpu.gttsize
To: Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>
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

On Thu, Jan 16, 2025 at 5:07=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Effectively amdgpu.gttsize gets set to ~1/2 of RAM, but that's controlled
> by what the TTM page limit is set to.  Clarify the kdoc.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index b911653dd8b6..680b272a83c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -282,7 +282,7 @@ module_param_named(gartsize, amdgpu_gart_size, uint, =
0600);
>  /**
>   * DOC: gttsize (int)
>   * Restrict the size of GTT domain (for userspace use) in MiB for testin=
g.
> - * The default is -1 (Use 1/2 RAM, minimum value is 3GB).
> + * The default is -1 (Use value specified by TTM).
>   */
>  MODULE_PARM_DESC(gttsize, "Size of the GTT userspace domain in megabytes=
 (-1 =3D auto)");
>  module_param_named(gttsize, amdgpu_gtt_size, int, 0600);
> --
> 2.48.0
>
