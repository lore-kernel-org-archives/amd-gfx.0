Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8075CC282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 13:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93B2810E085;
	Tue, 18 Mar 2025 13:41:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cLohXGFc";
	dkim-atps=neutral
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E452710E085
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 13:41:47 +0000 (UTC)
Received: by mail-vk1-f170.google.com with SMTP id
 71dfb90a1353d-523f58d7322so209934e0c.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 06:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742305307; x=1742910107; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XO2nv5aSHo83smhQ56XhxDo1rmSvfvWOnLzreDY1H1U=;
 b=cLohXGFcXzDf3+Y66yxlP36YluPTJhHiSPZVjYtbtrhINYR8sh8DK0nExDrCPl/CeL
 +jc3s7A1Jc5yDO5KBt96wGSlsCXj9VlopcBBCvQzAGSIqRkU6Az3K/tjMrGQI0lgXv22
 BQDCcjpMjZEpWXZF8hHQ380nzjxaV2W1TDEAhxxj9/raXPOcHkSpdvtWB8ozMvXHHLMa
 PwL1c4+GLeSeKe4QYBlX8yG+jDeKXTYHBQrkOI7ixiiteux/KACeTd1TjUDCsfjvaddr
 ll0k5ggwBdcp/zt+lJS6jWCQX8wLzYN965eet4J07D7cQL+TPE57Fhp71LTpTZ/ker4P
 tfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742305307; x=1742910107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XO2nv5aSHo83smhQ56XhxDo1rmSvfvWOnLzreDY1H1U=;
 b=QrLeZR8MYVVBuLY0/CzKortHsMm1dLwk0g6u2CgUMegpftEPeThHSxVdFv2+IwMMMT
 b5szlaOvvgnP6arTd9I89u3YYzRw9tHqWHqaqbS8U6rNFtlvycw8eQbODltsoYVYLr5/
 SbKiDKFbcWu9MRlwn0kqvRVLczS6S+4cyf7R922vl0fcxjHVfgv/WEmjsqVx0BtXLqan
 B9XQedZBxBrMxGdiXGKyveofI6Ddhpy0v5LZjRrlmd302D14DCfaIN3wTRHeqghCm603
 TLFFIXK7d65hTg2UyajbQ2ykQrYVgoyzBt49o0FvbXuMxYckdv+DYIy/yg7ABCopm7vE
 wQ9A==
X-Gm-Message-State: AOJu0YzZbtAh8vFvY770+uddljWAxj9CBynA/lbp87NE6fJ2wyGwc/Gd
 j19muyypc1+BMgwRbtAOvF8eIru7f7TNJ0hpOd/m5pRUycKwPAI7HscBPEP9lzb+MI4dl8rfnZ7
 CwxCwcPvNscYgHWcpjbDiXN3BC8s=
X-Gm-Gg: ASbGncvmEfuafT6nFndToWZAYfK7R5wwYvBjm6Xn3ANvPbVki70bTBzWRbNS6/y77ef
 pyCewWVkn5UlVNP5ZGTy/hE/zZfEKYGNgChUIFG85ckqvFG6CMfq75kKgr8Ln+10ntM8nhWs9jS
 wDfaJQvQjwewcFEb/4j8FB9k5rLw==
X-Google-Smtp-Source: AGHT+IEhRhScOOJdXJGA4/5tq8NW+pWSxnIxosfJsmWHlZ4HJGBeuhD/wPb7Q0oTIZD0GdQ4Jzoq1DXm8perGqjPCFU=
X-Received: by 2002:a05:6102:290a:b0:4c1:8047:e002 with SMTP id
 ada2fe7eead31-4c383105425mr3119951137.1.1742305306703; Tue, 18 Mar 2025
 06:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250307062006.251686-1-lijo.lazar@amd.com>
 <20250307062006.251686-2-lijo.lazar@amd.com>
In-Reply-To: <20250307062006.251686-2-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Mar 2025 09:41:31 -0400
X-Gm-Features: AQ5f1JpzS7X_jWaZ1tM3OV3VLvFs8PFpNzDaJ_dNBUKIui-DNncX9UuPIgnYjAs
Message-ID: <CADnq5_Oz3iLpiDDV00=B_dHLAW5xpCYM2rz7H50opF6SLTurKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Documentation/amdgpu: Add debug_mask documentation
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Mar 7, 2025 at 1:20=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> Add description for debug_mask bit options.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 22775c204632..04b518417da0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1055,6 +1055,11 @@ module_param_named(seamless, amdgpu_seamless, int,=
 0444);
>   *   limits the VRAM size reported to ROCm applications to the visible
>   *   size, usually 256MB.
>   * - 0x4: Disable GPU soft recovery, always do a full reset
> + * - 0x8: Use VRAM for firmware loading
> + * - 0x10: Enable ACA based RAS logging
> + * - 0x20: Enable experimental resets
> + * - 0x40: Disable ring resets
> + * - 0x80: Use VRAM for SMU pool
>   */
>  MODULE_PARM_DESC(debug_mask, "debug options for amdgpu, disabled by defa=
ult");
>  module_param_named_unsafe(debug_mask, amdgpu_debug_mask, uint, 0444);
> --
> 2.25.1
>
