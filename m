Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7384BCD4F3C
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2026 18:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0978410F2BA;
	Thu, 14 May 2026 18:09:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="amB66ys0";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 293A010F2BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 18:09:52 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-12c8c3f48deso295245c88.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 11:09:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778782191; cv=none;
 d=google.com; s=arc-20240605;
 b=HrSQk8RcBC6MevIHIZj4xvn4gDPQWedU12xW+eQNReSUw9uvR9s0ohx7mBRmh5DJeg
 PcnBsHOvrzpxuhB/ndVvY6/9JnmED7MDXNKMWn4dgcqUSW52xn3lRaYSQfCMdTgH6aKi
 6WAcf7himZs/XMlvO2AsNrJn0J5hyij3y2ra3KM9Mz2SSVIuhd0+7kc30NNmgitSazad
 kF0FTxuOHjlXSjykpve8ItVh3TLZeKE1o3bAXr9jZCcf2fTV/zUCYeCJfjlshfX2n+Ed
 Rmo7YBjOR8YHpT10sldfI0loZwsbjM7Ef5kGq5Z0t6UtorEvP6VLSd9gxJcmL5j7f9PW
 fCgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nI2muwR20CfXo07nlBeWlSxlxBa4DApcs0qqA6MwymY=;
 fh=8VlCKmlUX8T8hAmFOxUS/RpqIqraxAHr6XYs4UP6Pw8=;
 b=M02VhApdxQ4oBsP8zwNIiElIYhwdYiiBtqw35ymYqq5CvsFOiOWjfYTZYp/qPtw6gK
 rdgLPM/wHPQO6SKVRn3spqa2ZNknkD8QqRcG5HfER3IXMSYuvziWlDjuT2UOAOJze1Kr
 wgTJk6l5S/PaDfn4A6JgWUyu59zsh2jH+uSoYjSF3wnP92pfyy7Fvgs8Ra1EuX283IvW
 XDMZcYqfNv+O6rqJa33Fs57wvtXpzSXDhtsL/zmPV7vXnKhyHuGHnjpJuc/uoVwO5qPd
 zWdiEyy4JwqkXPvLOW82HU48fF3vQzfrNHNBOf9tzWwZkjCt2jiyF9baSMfYBmpqzDY3
 X47w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778782191; x=1779386991; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nI2muwR20CfXo07nlBeWlSxlxBa4DApcs0qqA6MwymY=;
 b=amB66ys0/Mdjok/PehDU6D7PiSCvZZhuBmVXEDwTIkccOcM0drLRGFrQY+RQdm+r92
 kyWcU+6l4aJHK5PlfmVjXBb5Nd564evnx2Xj7EIQqPFkoGXqb6xzoYvMV/acJ35uWPgB
 ekFNf+/T2eLOd2Q2YtdFOiHJ+fw5G0rMrGkhd7tXrxDLEYsq1xhiE38lWUInbSDfSosC
 8oVcEvsapZHIg54LPlhZqQuE8rGNAtGqqVVUWLrNFbcUxeBoHZmf7I2rp2+cIfV2n6Jj
 keHdhqqxlntcQcKKyXtruNqFy2Bgg31IuN3Jl08kRobn6Tvj3WaGxi+v7bgMl8snBoVa
 zgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778782191; x=1779386991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nI2muwR20CfXo07nlBeWlSxlxBa4DApcs0qqA6MwymY=;
 b=mMY+VTH5vrFlqn2SxVblcCrJwJe9cBhYva4iigwclynITk7ItvqtzK9xnsDeatM6gz
 0B4SL4dZxtO5DpO+ED2eva0ns+xsd0liDnrqLhDk8OMOF3j5D+bdPgRIM2JByFCZq+WT
 gmDSXFAW5G2iz/7g/Y3ijooB5ADnTlNejP9t5+kWbXzLWaU2E2BAylaEO3/7R/PulJ6n
 agdTWq124vmAU3WAosDwhWGRCfKQwuGflKUDfyg1ZhaMEDqhGCQI3Q1wDOsAQmdgfG8q
 MHlXdiX2K1kabAN7PfU7DjaSffGAJMzeerN43m5DDo4AGfj8A23Xk1E3nsbSAf36cnRe
 twUw==
X-Gm-Message-State: AOJu0YyhVA6SZK/dVJ6bRH5zFBYLUUK2jJpXl8IlQIlQP8APbGEGchcY
 WWRTi3qgH4qgxWvj/z4XI4QQk6yEs6sD1gJV4RZF+dXimgATX4ZgC4gT7TdaNWIFXhlVU2gUiOB
 LJUFGwO3ZEuwMO4kC8IAGClfOGmJNRT0=
X-Gm-Gg: Acq92OH6QgDaIUy6zY2TIjr0J7vNzeYglghBMcv76SKGwfjzYohV4oPGpW0zJpKNad8
 XbZLDRg4+F0aGtTB4b9XBtJDBrbulno1GEgcEIREqgDXQ7tJav5GMS5/u9MwE3+C/V4OtI5Nkp4
 K6IeZHurT87I58uszc65edvDlt0zWwsSRk28HO99RCnLy+gYBhsIiNkCWTqBCNGZliv/SrLspxC
 nBkq4dAakxqxF0h2qlcZNHqtixXGyqaRfDOSYLrKodtHmqB7g0tv5Pi0n4pnpwug2m1q/11zZqu
 qzSmaXwGxu6J3WnCYWpjb2G+IiBLUr5IXttvixtHgiFSN9VcSmLoTOXwGj2V7Slv8ie2sA==
X-Received: by 2002:a05:7022:4596:b0:12c:888b:aaab with SMTP id
 a92af1059eb24-1350451b228mr49209c88.0.1778782190368; Thu, 14 May 2026
 11:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260513200416.35631-1-timur.kristof@gmail.com>
In-Reply-To: <20260513200416.35631-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 May 2026 14:09:38 -0400
X-Gm-Features: AVHnY4IJ9F8c_N9kRyK7mW-z0gJBemynLbhBAZeO8NpmlZRrD5-P-AyypriaSAo
Message-ID: <CADnq5_Mgx2BWW9ijjzmkMfcJkGL9LdSM+dpduF3EN8nLYqUegA@mail.gmail.com>
Subject: Re: [PATCH 0/9] VCE1 fixes (v3)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>
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

Applied the series.  Thanks!

On Wed, May 13, 2026 at 4:04=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> Fix various small issues regarding VCE1
> and the workaround to ensure the VCPU BO
> has a low 32-bit address.
>
> These should be included in 7.1 because
> that includes amdgpu_gtt_mgr_alloc_entries()
> that exposed these bugs on VCE 1.
>
> Also fix an issue around firmware size
> and offsets on all VCE versions.
>
> v3:
> addressed review feedback,
> dropped patches that were not reviewed
>
> Timur Krist=C3=B3f (9):
>   drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB size on Tahiti (v2)
>   drm/amdgpu/vce1: Check that the GPU address is < 128 MiB
>   drm/amdgpu/vce1: Remove superfluous address check
>   drm/amdgpu/vce1: Check if VRAM address is lower than GART.
>   drm/amdgpu/vce1: Don't repeat GTT MGR node allocation
>   drm/amdgpu/vce1: Fix VCE 1 firmware size and offsets
>   drm/amdgpu/vce1: Stop using amdgpu_vce_resume
>   drm/amdgpu/vce2: Fix VCE 2 firmware size and offsets
>   drm/amdgpu/vce3: Fix VCE 3 firmware size and offsets
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c |  9 ++-
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c       | 64 +++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c       |  9 ++-
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c       |  2 +-
>  4 files changed, 55 insertions(+), 29 deletions(-)
>
> --
> 2.54.0
>
