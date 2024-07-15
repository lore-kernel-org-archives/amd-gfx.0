Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD74C3DA4B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 21:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D60D10E4B7;
	Mon, 15 Jul 2024 21:54:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NiVahBvk";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C690610E4B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 21:54:30 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-7163489149eso3506157a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 14:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721080470; x=1721685270; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G9GYtvhGaSU5l4wd8f42Y79vd7/oPxWrtM47HvRAu9Q=;
 b=NiVahBvkKW3rB24xYiy7wfAilnPE5SyTzosPJS0GnshSDFdeSK/GDiuRYl5JFUQ4ta
 aKa/pJEAo9VBVc/4JByCvF7U6DajVX3JxKpvjTO8Fkc0gw5qyi79TBKkmd62aDgtDVGl
 sKIWEGEjA9Iwx5HdQewseDS6atPRfXdWflY4L1KIO2fHbN5yFsmr4TST9YQvjBLBEW75
 G3q+KiwSMF7G+hgNwowJuHVwM7lmoiUmIYU3Ff/lM9wgn+s0VYQZFyZhiH5JtGoQFyBf
 tZpwBP8MvWq+HCBgEKK3uXlhu+bfUTmyJSvitf/s5Rtlz4x/+jNoC6R2Lz3Btcku18iH
 jYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721080470; x=1721685270;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G9GYtvhGaSU5l4wd8f42Y79vd7/oPxWrtM47HvRAu9Q=;
 b=LRaHQzfnUrsCEye7/mWNAdKfbneHsurj/YgoiSjKwspRwtmjM+tjyWdpF0bPSK4P88
 fveNTTt/kX+HBSDuAQxWmGUcsRHWj6LVy52izemadNabmYXD1fyb3wdB2Hh+sSvhevwK
 uhpw2BKPYAN3T0RaiENrSrBVgfJv3LxpeBqvjxrEa4Br+rl6nvA6Blj51Mo3OWAbqiIY
 OHksWlb3ZP7/xjRN8rBWONvk11L9Afmy8LqUfNuBLzsnyuFv/aEvblXvXr2gLvNTioXF
 8STsiWCOwlcizCtIuJ1ZNxQqTbO0O1UEoid9BTwmpT9WOtunqqosLxzB/xgrT76mzGz7
 49NQ==
X-Gm-Message-State: AOJu0YzX8KOsBcHWD9DD98ySONfFPPPIDETaQ9MaFLqROpdx08u/6/xQ
 2kEpXLW2+oTgWZ/FKDChnDawXedPcAHx3PIYa8BkSxjTlL8XLfj1aWz2QzqvrHOYNfa0lIrm1xT
 GmTUz/ye80jHDwMv8I2ItBNPKq8wDMQ==
X-Google-Smtp-Source: AGHT+IG7rHb92pmZ6kWyHo7nFM3/O8mHGSHLs2mD2wB5RV91LKeylW4+Qx5ciOD0RoffrSZ3ZpipWqBP+PoWA2UYqeg=
X-Received: by 2002:a05:6a20:3d88:b0:1c0:ef24:413e with SMTP id
 adf61e73a8af0-1c3f1295d2cmr248991637.36.1721080470139; Mon, 15 Jul 2024
 14:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240711140603.2860632-1-aurabindo.pillai@amd.com>
In-Reply-To: <20240711140603.2860632-1-aurabindo.pillai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jul 2024 17:54:18 -0400
Message-ID: <CADnq5_O9J2jDKvJ3VqBpHqrwMcRghhWTdSBSiQdoz=WPdu4=zg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Bump KMS_DRIVER_MINOR version
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 marek.olsak@amd.com
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

On Thu, Jul 11, 2024 at 11:05=E2=80=AFAM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> Increase the KMS minor version to indicate GFX12 DCC support since this
> contains a major change in how DCC is managed across IPs like GFX, DCN
> etc. This will be used mainly by userspace like Mesa to figure out
> DCC support on GFX12 hardware.
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 802debd8d9f0..af44cbc90d2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -117,9 +117,10 @@
>   * - 3.56.0 - Update IB start address and size alignment for decode and =
encode
>   * - 3.57.0 - Compute tunneling on GFX10+
>   * - 3.58.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF & A=
MDGPU_IDS_FLAGS_MODE_PT
> + * - 3.59.0 - Add GFX12 DCC support
>   */
>  #define KMS_DRIVER_MAJOR       3
> -#define KMS_DRIVER_MINOR       58
> +#define KMS_DRIVER_MINOR       59

Just a heads up for posterity.  The feature for 58 wasn't ready yet,
so it's been dropped for the time being so I've switched this to 58
for upstream.

Alex


>  #define KMS_DRIVER_PATCHLEVEL  0
>
>  /*
> --
> 2.45.2
>
