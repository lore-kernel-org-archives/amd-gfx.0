Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BB9F8A176
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 13:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D89810E8A8;
	Thu, 16 Apr 2026 13:28:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MOubYMaZ";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 836C910E8A8
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 13:28:55 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2d9b27e4aa3so185539eec.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 06:28:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776346135; cv=none;
 d=google.com; s=arc-20240605;
 b=kVPtq3Ud1f9OddSIhPRcBHnpkUr5duEyIqyBoRIvCgmwHQYE8rVfKWDA6lwYO5fbsB
 JzpsH39cPshkvx2y2al1D2C18uu7oSxzZ+Dl4efS+fE6GZOMBAu7Q6LqvIRioKctk2ih
 x/QnFn9yxcof3b6QNTFWSxQRcbLSIbOPh2bhI5jVtZkra39HT0dBl4iZjVKGE1kB/3xG
 zzv5F18yeBtaGtLFRlvNfF8tgWJSHWeFJUmUjIgZ4by2FEVMr+TeOVpvCa8UNKIV06UG
 mKcnl+Q8Fl6HRpmH5dQS/RDZygzm+OIQmeTDriyTFIF8q3NghtHeVm8k0RggPr0kfoXM
 OxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MSktGAC9ozJhAXiwePy6mZvke6/90EpBImrF1sA1aOs=;
 fh=ruWCVUv8P4PWlRLKRWQc90EjZKRBqBbICn6JmB5krSI=;
 b=GzDis0MuV7iwjov1P1PX1UQGTbzlBkl3Fa0p4b/zeIAFQPcw75560vR5L6u8px8sDd
 h85ee/XiOCbXizw9SgckPTwUATOkIu4rIY0tdeVMrWMRySUo75XCmNkd+I795uHrqSQT
 7O4oeYlkNG3S26PRKIMlpjogP1lMXGW+e3CPkoDnMFL3D40ehV3kcPt9V/t4ctmjpUFQ
 Q3EGFI6IKxoHS34UKzI9S0aLXln9G0tDmGI3PRqcK4EXnPwlH7aIOItcsbh5JbI8C+iL
 +hhaytszmbu0rYa0e919pESRkNuvWsymooIxEwAWUIs+dJj4GGBxc6nk7xpK/TswTN1S
 9OLw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776346135; x=1776950935; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MSktGAC9ozJhAXiwePy6mZvke6/90EpBImrF1sA1aOs=;
 b=MOubYMaZpgjLLRB9ZYliuHaLWaiPxDypByPupleU8m4aymkqxOrG1xdVDgzhr41sIT
 vIqKgjomVeBv+kCk4xtDh8QkvphyrPxkQzO04L9TMOa9shOpRyuF7MOMlPg0qYz6B4fD
 RBltYyGrV2eADlxQ/LvtAp1p6oAqcRIrSkYdhqWW+yzlurc806IqVlkgeWLvPcENFy68
 qPtXhcnfQ15ze4sX3tMQIuy9W+z9W7WQcuVhhdxH/THVeI2zfQm294o4kojmnN9orklB
 rJ11tWvISNagbJpWLamywjmAqE0pHFvtFQRppTdWoq21DOQEbyiBEegN1V6gJfoDVL2m
 YSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776346135; x=1776950935;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MSktGAC9ozJhAXiwePy6mZvke6/90EpBImrF1sA1aOs=;
 b=GrL3/f+EiQZdainLSfqEN2QwAoFTeT9Tx8ZNfx3ByNZpxcIXz376M2cyfA59YCWKir
 WKJ5PevQK3anO7ul++CNEiKn2gw8xTLvXCBhgIXokOUyJD+9JpJ45VV7VxIwwvwh05uE
 YhTjFEf8JeGIyeOQMTAkIbTKwKCYjXTV2j5Tg5MGiQkRYxwkKCsYj58ErYONFk4kp5S0
 K361oZX4fNikTaZiHsJdl69jCjnsM1cw0qJ4GlQbi5KXSZaD3fhqvSzfSBbcGcgWl1Qw
 vLyYLJj68xCZSulzuixq9vwebx5MiC7xJFqVpAFCrnzr8dgtlxIzD9V28JYNvZNr69Uh
 25kQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ91zA5fRw6IVYaflStb8J5T3mvEyL9+bza/naObSiG4cdeewPdRsJ0oSYr7AdjTRAXFsyt+ZXPs@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxeS61dVJHe2CtoxchTMl5ileeJtwBdbkiLTAJW+Sd+2k0mBCFf
 zZbSv0NSmkcj/c4Uu0qAtpyMyzzL5N5IW2sOGZTnowagAs/n3odNsH1XnMBSsHiKzhetNNuvg7p
 CdcqIVRsEXahDnD/ALoqdPsCHLIaGo+o=
X-Gm-Gg: AeBDievR6fYQ2zOnWz/XQilJnFBTF6ssw9M4pcl0KpeypoNjmz/nC92mUw2XNF0Vax6
 4nJhvRDDEjH451ouUn5tGKaaP05Gx4NPORHJbjn+T9mzYg0kavHJBOQA2GpMyx/AFFqzzoxHWxj
 DywRaBG0yPZ/CjXjtB+qi8k3/CG4ykQ9ZOkjrVAjRFN1Oy3Kr6ypwZwjYHiG99mfCU2EIl3prI4
 9sVPsHpHUtQY5WT/m0YI35w1deMdzUVCwFgRpGX2UqypbWc7tF+xsCPAm4T+iGNEbmoIA5LCu6V
 UZxhcmFtNpdtzWKugL+K1NF2mUCEfQLMTy4Dd5UxQUyqNnPr/xMcDG31zpNywuDvUY2o6w==
X-Received: by 2002:a05:7022:519:b0:123:2d38:929b with SMTP id
 a92af1059eb24-12c65d3eab9mr462554c88.6.1776346134728; Thu, 16 Apr 2026
 06:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260416045025.1825888-1-perry.yuan@amd.com>
 <20260416045025.1825888-2-perry.yuan@amd.com>
In-Reply-To: <20260416045025.1825888-2-perry.yuan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Apr 2026 09:28:42 -0400
X-Gm-Features: AQROBzDnwBlfkC-mBaz8gGd8dy3NU_DuXQ70gLFKNQdBkBU8UwKhchUiJfA1564
Message-ID: <CADnq5_MFUpZV6+i0kW4cP0sN_3OGF0J9S7xrfX3inx5NN32Peg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdkfd: bump KFD ioctl minor version to 1.23
To: Perry Yuan <perry.yuan@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Thu, Apr 16, 2026 at 2:09=E2=80=AFAM Perry Yuan <perry.yuan@amd.com> wro=
te:
>
> Bump `KFD_IOCTL_MINOR_VERSION` from 22 to 23 and document version 1.23
> in `kfd_ioctl.h` so userspace can detect profiler ioctl support.
>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  include/uapi/linux/kfd_ioctl.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioct=
l.h
> index 1a94d512df35..9584b5aab727 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -48,9 +48,10 @@
>   * - 1.20 - Trap handler support for expert scheduling mode available
>   * - 1.21 - Debugger support to subscribe to LDS out-of-address exceptio=
ns
>   * - 1.22 - Add queue creation with metadata ring base address
> + * - 1.23 - Add profiler control ioctl to enable/disable profiler on a p=
rocess
>   */
>  #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 22
> +#define KFD_IOCTL_MINOR_VERSION 23
>
>  struct kfd_ioctl_get_version_args {
>         __u32 major_version;    /* from KFD */
> --
> 2.34.1
>
