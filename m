Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE80ECD9A6
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 21:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E47589D7C;
	Thu,  5 Feb 2026 21:37:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Unk6WFzN";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A02B189D7C
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 21:37:36 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-124a7216c9cso155517c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 13:37:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770327456; cv=none;
 d=google.com; s=arc-20240605;
 b=B8WolsbzwHTiox5s5YXlSHBrAU90Mw0DgEOXrUTxEHc5ZMi5DKQCVtRrpZm9o1lnH6
 YXArfhGrIP9bayeh+I3LYX75kyo7leoG5LPYZ1MF1Lc3iecuYxrrOYaWhHbe0/tSK1ha
 wJia4vS+lE8M1wwMdfYFJCKOhhJ4TjNliH/cG2Znjyb9d75KrSRQ/bo35W+DMgo3l0hl
 +1HKzCEYAkJ+LT58U3s154b1bv8n4HgacJwK3D5hQBcpktJW6pVf0J+3h5Hy1xcvUcXR
 qBSdjcPeCIjzol82/5OufQAh0gbbj6gW7qY6tJwVHL0qHjcepKvGsbcdRpE57HvQTaOS
 nFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BGrdDCAeHQZbOIqbzQt7tMSkWmIwj1QfdOISHzj5CII=;
 fh=QOZ4KYU5fXgnCQtwDKdCwdRyB18eC8h+joRj2Ucgh5s=;
 b=VRDAxALy1hRx8WinvcCABWyLHNQX07jCsdB+vx0puDXDiPqv96DBhKo11ysYp6FBFT
 /NQinmy9eaMshQJ/8HUOuwNNqYbiZUUfN2PWDCYgG5dfRkGLnMhQLCzyfXsnFcBkuk2k
 YoYuu5yW3mTWevlrvsm79QjH8o/zcfiBT8mrT5l8eDB5z4j6MaemT1oGbDJlvV0SXin5
 q9wMCauUVkaHp8bbE+TdKqE/s5FFiOJyxHM9CmVcZ7MMc+jZrtVoOFnF/umfe+KyL8BF
 n1XKL0C1OFvrZTgCVdPtDXBXlG27JJUrgychmZd8/7XdLIz73VSHGWpGoKSpQFK21FOz
 K2Ag==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770327456; x=1770932256; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BGrdDCAeHQZbOIqbzQt7tMSkWmIwj1QfdOISHzj5CII=;
 b=Unk6WFzNUhjkbNC7R6DUvVz48ga4DqN7TQq27aQ7DDO2+p+WPAkXSeVT5LczWZuWLY
 eRiirpVaItvhnV7q5HCh7cmqpG1EfpWw4ku8dXU+9Yfa7Vp3HVFDBuAq9YOzS1hQeCF/
 KtBNAnx4vmssu4nbwGOxj3EoQZP6FMv/PMcGe5cz5huNgbEuHIZ3roPs2m+eAd0OUrtf
 wDElmeEe0M3UWrBAcnbD603zIa9l0KZeq0Wpt9zD4NvP2RP6JUZk6AejfZIsQifRZSVr
 c5B5jSqXzAV+2L0a6axO3Yis9N/SG8G8RRCjp92S4pEdh461fQfyewAJDn8FAiorsEEG
 teUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770327456; x=1770932256;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BGrdDCAeHQZbOIqbzQt7tMSkWmIwj1QfdOISHzj5CII=;
 b=HhlYn3ZSpW8KrRDtruDw+LemeVXmgOY5lC/IA+DtnhGmYQjdhk+eAYv5Ofnx+ja3K8
 za0C7YV7TbwG8oeOPcCchCWeslbQ92BRshbWDlZBAYBBa5rphh0mOdko6DBAOZEP154J
 ZL7KTyqoz9s0yQphGAF2E5qrKSeVkYSdhSCbnfKh1IoakQ50JWqhPkCcVdPr+EFPCTiN
 i/ubzYHf8HsQOSjK+so2rhITzLqSuwq7KkEorHXMzJA0hVdX4Hgx6+jGFf/8g6TAEMpS
 /Z5LuP36ZPo/zd7Oa6M9QskhqCnRRBDkRiXbSdTrpd0LFdbKSemcwTde759ZcWGBuH6h
 GiSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5yQ7+mezeqx8io4S1yVMRxCPIDBw2zWBIPBVDNnNXgHxc/RkPFBGLBPhpaS6vgTCGMekvTXTA@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxo7V8JROs5KtGzmQ9YHwTMo0VDa8Xu4IxEhY/qgxNLvdEKkYNr
 A9t5Kf/RE1L0sLimokH/FoCpwFI49YTcdAyopp0u7WllaT97AUpLVokNeiKpngXSfGFs/oRgAb4
 L5BWfWVCqAD+nzYZbU4euezUrsU09X90=
X-Gm-Gg: AZuq6aI9TrY6deZ7mvBEQlho1X1XOv/H+nlSMIOFqjNQrqxTmtA7+N/l80DrPKVBw5q
 ZmNT1Mk1u3WPZanGWGrBYPqIkLXefMtxehMO8WotWA3CTeloEPQ5xeKbI+jktKTY2e6tZW8fcPZ
 CRe8yxgy0DKZ1XtOGeaQ2xND9Fb5lHm4SCiXeA1IDngQeif0PiZ77h5+AGORVZvKR80LVwyzit3
 9Ff8XGsqO+lkdvOHORgHNbmzJNe5bZpRcMhr9JUYzE2iYeD1up4E3gP1Z8d4yPWTjGBu2c9
X-Received: by 2002:a05:7300:f195:b0:2b7:fdb6:ccc9 with SMTP id
 5a478bee46e88-2b85642c7f9mr122553eec.3.1770327455801; Thu, 05 Feb 2026
 13:37:35 -0800 (PST)
MIME-Version: 1.0
References: <20260205065130.654921-1-perry.yuan@amd.com>
 <20260205065130.654921-7-perry.yuan@amd.com>
In-Reply-To: <20260205065130.654921-7-perry.yuan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Feb 2026 16:37:24 -0500
X-Gm-Features: AZwV_QhvB0cLQgcOqKR9gSZ58ABeYhxz15PcZ5c172xp_V12QK5cK_drm9mdugk
Message-ID: <CADnq5_M59RNnzco4mSL90mfxKp++Z82ZyLBt17LtUKVkdxNEbQ@mail.gmail.com>
Subject: Re: [PATCH 07/22] Documentation/amdgpu: Add documentation for Peak
 Tops Limiter (PTL) sysfs interface
To: Perry Yuan <perry.yuan@amd.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 yifan1.zhang@amd.com
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

On Thu, Feb 5, 2026 at 11:57=E2=80=AFAM Perry Yuan <perry.yuan@amd.com> wro=
te:
>
> The PTL (Peak Tops Limiter) feature exposes per-GPU sysfs files under
> /sys/class/drm/cardX/device/ptl/ to allow users to enable or disable PTL,
> configure preferred data formats, and query supported formats. The usage
> of these sysfs files is not always obvious, so add documentation to
> describe their purpose and provide concrete usage examples.
>
> V3 changes:
>  * format show will display preferred formats instead of N/A (Alex)
>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  Documentation/gpu/amdgpu/index.rst |  1 +
>  Documentation/gpu/amdgpu/ptl.rst   | 94 ++++++++++++++++++++++++++++++
>  2 files changed, 95 insertions(+)
>  create mode 100644 Documentation/gpu/amdgpu/ptl.rst
>
> diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgp=
u/index.rst
> index 8732084186a4..b2ab182236ef 100644
> --- a/Documentation/gpu/amdgpu/index.rst
> +++ b/Documentation/gpu/amdgpu/index.rst
> @@ -23,3 +23,4 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) a=
rchitectures.
>     debugfs
>     process-isolation
>     amdgpu-glossary
> +   ptl
> diff --git a/Documentation/gpu/amdgpu/ptl.rst b/Documentation/gpu/amdgpu/=
ptl.rst
> new file mode 100644
> index 000000000000..c7f16dea7954
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/ptl.rst
> @@ -0,0 +1,94 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Peak Tops Limiter (PTL) sysfs Interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +--------
> +The Peak Tops Limiter (PTL) sysfs interface enables users to control and
> +configure the PTL feature for each GPU individually.  All PTL-related
> +sysfs files are located under `/sys/class/drm/cardX/device/ptl/`, where
> +`X` is the GPU index.  Through these files, users can enable or disable
> +PTL, set preferred data formats, and query supported formats for each GP=
U.
> +
> +PTL sysfs files
> +----------------
> +The following files are available under `/sys/class/drm/cardX/device/ptl=
/`:
> +
> +- `ptl_enable`
> +- `ptl_format`
> +- `ptl_supported_formats`
> +
> +PTL Enable/Disable
> +------------------
> +File: `ptl_enable`
> +Type: Read/Write (rw)
> +
> +Read: Returns the current PTL status as a string: `enabled` if PTL
> +is active, or `disabled` if inactive.
> +
> +Write:
> +
> +- Write `1` or `enabled` to enable PTL
> +- Write `0` or `disabled` to disable PTL

Ideally `enable` or `disable`, I.e., drop the "d".

Alex

> +
> +Examples::
> +
> +    # Query PTL status
> +    cat /sys/class/drm/card1/device/ptl/ptl_enable
> +    # Output: enabled
> +
> +    # Enable PTL
> +    sudo bash -c "echo 1 > /sys/class/drm/card1/device/ptl/ptl_enable"
> +
> +    # Disable PTL
> +    sudo bash -c "echo 0 > /sys/class/drm/card1/device/ptl/ptl_enable"
> +
> +PTL Format (Preferred Data Formats)
> +-----------------------------------
> +File: `ptl_format`
> +Type: Read/Write (rw)
> +
> +Read: Returns the two preferred formats, e.g. `I8,F32`.
> +
> +Write: Accepts two formats separated by a comma, e.g. `I8,F32`.
> +
> +- Both formats must be supported and different.
> +- If an invalid format is provided (not supported, or both formats are t=
he
> +  same), the driver will return "write error: Invalid argument".
> +
> +Examples::
> +
> +    # Query PTL formats
> +    cat /sys/class/drm/card1/device/ptl/ptl_format
> +    # Output: I8,F32
> +
> +    # Set PTL formats
> +    sudo bash -c "echo I8,F32 > /sys/class/drm/card1/device/ptl/ptl_form=
at"
> +
> +Supported Formats
> +-----------------
> +File: `ptl_supported_formats`
> +Type: Read-only (r)
> +
> +Read: Returns a comma-separated list of supported formats, e.g.
> +`I8,F16,BF16,F32,F64`.
> +
> +Example::
> +
> +    # Check supported formats
> +    cat /sys/class/drm/card1/device/ptl/ptl_supported_formats
> +    # Output: I8,F16,BF16,F32,F64
> +
> +Behavioral Notes
> +----------------
> +- PTL formats can only be set when PTL is enabled.
> +- If PTL is disabled, `ptl_format` returns `N/A`.
> +- Only two formats can be set at a time, and they must be from the suppo=
rted set and different..
> +- All commands support per-GPU targeting.
> +- Root permission is required to enable/disable PTL or change formats.
> +- If the hardware does not support PTL, the PTL sysfs directory will not
> +  be created.
> +
> +Implementation
> +--------------
> +The PTL sysfs nodes are implemented in `drivers/gpu/drm/amd/amdgpu/amdgp=
u_psp.c`.
> --
> 2.34.1
>
