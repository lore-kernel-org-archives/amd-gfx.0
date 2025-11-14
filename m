Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1664ECE7AEF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 14:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF92E10EA81;
	Fri, 14 Nov 2025 14:42:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eC7a/Qob";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04DC910EA81
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 14:42:27 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-7baa00e291eso99189b3a.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 06:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763131347; x=1763736147; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WbhTUph6rb6dOZwHxKXPOXdvh0ZDWyV5XHLLRq0zXo=;
 b=eC7a/QobubofnJlgJgVJPt/0JB+rBWyM/BJhhU+IXd/TNkepmWtHPynR2h0kEkNtBM
 K1frqtprQ8WcEW2nspHE7SrdZrn/HvkbMLeCILWh6iMGXy9wl1ePHchkBhsY3j/mjYas
 EPEgqm07ePicaTWtZCcrsv2BsjkMPXiGGD1mgruwLNOsS1WtCKhu8LSX6ZYYosPoQPnu
 +vg70n2GA/Ts28NpHB7JdbcSnT7xOP9RmlR9B75fzkIPkXhvWhJ3s1BUhXsg9O7c0s80
 4smAjXfJayDq7a7fMPC3jyrBABi+vQpf6BXnPSBjwnjuv3D0B27EyfpmMSDbNdz+XnPz
 B1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763131347; x=1763736147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8WbhTUph6rb6dOZwHxKXPOXdvh0ZDWyV5XHLLRq0zXo=;
 b=M31NO2rYgayukJ7fylEDed3RosyOvwFkJ8fi87Vp5aDygIdiLJwIKC1bUDEvIIDK6Z
 T19bsFxfzMBASHhlWlspLUwMCBDfR5eWtORrJ631BHHh07v6Qf/ge3nuyZ7YFyCjUdgM
 Q5CZMHZ+ayF4rQSNU1L5iD9SGcqtiDqxxEqYtKq6OhwJ9mctln3lRGKjXiP4r+h4PkpV
 gO5pKT4xqdontomclGhiqTrLoVAYbSrk9YWdDxDgBei0DQZry6E7FD/46FEffFYyKER9
 0hNuCeBmVfF8uIa6R16O8f8KzONdHDv13pCqb5m/eGB2uMc6rHYhi1G0UPgnyY1ZOEuv
 09ig==
X-Gm-Message-State: AOJu0YwnPq2//x4PoGB1xSO1Um4zZKjCDQoLxeP1wJ8knEZHKZLvaxtL
 YA17M73i6/rSjlIRXVzCJeNechQx2kMmLCGt+i9Hy7L1AFKGFRTBsT4CN/U7LifrsFKe5lHhoFv
 IOlZRn53ZpjAMtDVhUcM3jXe9qyuwb5k=
X-Gm-Gg: ASbGncs67Jn6PMqrL2NicMd0QNtDQblkRw0Pr2eBzKgbOxSkhkPnVeQ16il3/ufI0Vh
 1low4Ak6ICtw6B0tecC7ZBKCUwLGkmwj2tK64RNzs4bm7Dvhcxg4+K+HHrkHSKLtOohEYt+G6fB
 ZEfgtno1kLT63YB6qY+d9Ps5+X8vScdgx4diArAQF+tNFiSx21RATbUQX/5XhXUZhXrs2K3zHiC
 H1213W5ZtNYA/fi6qTXQBRwheZ33b+A5N5wVmLzIRQcYg2A3+P7teabZNyi
X-Google-Smtp-Source: AGHT+IHt7WnTQ03Hla1e/xvi51ehVANCz5Wtkw67itjdw32iuQoxj42ATWGSzoTYB6pnk8VGHY16wB2NpAjbGVwy+Mg=
X-Received: by 2002:a05:7022:ef12:b0:119:e56b:c3f3 with SMTP id
 a92af1059eb24-11b493dde93mr681379c88.3.1763131347241; Fri, 14 Nov 2025
 06:42:27 -0800 (PST)
MIME-Version: 1.0
References: <20251113180853.225907-1-michael.chen@amd.com>
In-Reply-To: <20251113180853.225907-1-michael.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Nov 2025 09:42:14 -0500
X-Gm-Features: AWmQ_bmI8ySjkpbX8sM2RZspd06FEMvYdkFsinmfQ_GdIhSdSBw7gwOz1a-F6Zo
Message-ID: <CADnq5_MkNX=VBNkSv3T253_To=Piitm0NTxKCseZz7J7AZFTEw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: reserve vm invalidation engine for uni_mes
To: Michael Chen <michael.chen@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
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

On Thu, Nov 13, 2025 at 1:10=E2=80=AFPM Michael Chen <michael.chen@amd.com>=
 wrote:
>
> Reserve vm invalidation engine 6 when uni_mes enabled. It
> is used in processing tlb flush request from host.
>
> Signed-off-by: Michael Chen <michael.chen@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index 97b562a79ea8..4814be022f32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -597,6 +597,9 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_devi=
ce *adev)
>                 /* reserve engine 5 for firmware */
>                 if (adev->enable_mes)
>                         vm_inv_engs[i] &=3D ~(1 << 5);
> +               /* reserve engine 6 for uni mes */
> +               if (adev->enable_uni_mes)
> +                       vm_inv_engs[i] &=3D ~(1 << 6);
>                 /* reserve mmhub engine 3 for firmware */
>                 if (adev->enable_umsch_mm)
>                         vm_inv_engs[i] &=3D ~(1 << 3);
> --
> 2.34.1
>
