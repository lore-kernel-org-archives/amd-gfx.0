Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB9DEFCE44
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 20:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ACF610E1B2;
	Wed,  4 Mar 2026 20:27:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aIzYBIKx";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E1D910E1B2
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 20:27:46 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2be22d699c9so162044eec.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Mar 2026 12:27:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772656065; cv=none;
 d=google.com; s=arc-20240605;
 b=aQVuhJIlF1rJdrgqdBN2KS70/iPawaUyY8pmMcJkThikO/tYiNVmyKe5rmrguz+1Km
 pULlNI/pJL9lHIZw2tvhlJ8pu8dwr1dXf85aNxelIvYL8KvKErS61vOuKND/YwOhtH8N
 tJb5ZpqKooXrkEytMMxA/eGc1NXBWabx7JrOrtVBpzKpiCsYQmMOFIv6ZUHlUBnofvUQ
 7Ei8zHN4dXsJLROeo5hGs5INCcq1HfHiUMcWYEzWSEF2NNJjUKI3bJ7TzWFlFNbD/4OD
 Q71yudP8tLjNjAijzvptqw+YIWqrXw1fo4dvmQbnJ8H7UPilrAsTOGYu8Ms9jH/ljdMZ
 6RGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rLUrnLpUQdD3tFiKd6Bral/WfUN4JhjB7HzQtZWk8fo=;
 fh=/jXuF6kkEzGc76I89MWDwYajZhHhstOH8SMMdzCQivY=;
 b=LaDwaXUFwOR5VP1qbHMJ43l0U0X8p/65K/qCFKAOXcbJm7Ei3+TkG1TVXtbG37r34O
 M2LbFWBNqI/3SR8WtfEeiVT5IvuRKEK4bM6/pVgZLV2qw3IkgQb5PNfIYdriqHJ/wDBA
 YVmL3aBJT1Qo5E4Wl4oIZXieBRBkXn0RIWvm9TNxhffZgxJiYjB4rrqwZCn6cS64i9oX
 NUhBJfr5rwLmKTACENnwiz7pt/2SZ22rK8zneIN606poKs2BxbMpAdPkzI4cv9pkLNsc
 JlnmJdRy9ialBMF303xPbiviF2Nuj3xrmXReVNKEUMyM9pzm6IxNkEb/0Gy+dx2jWyFU
 SnRQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772656065; x=1773260865; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rLUrnLpUQdD3tFiKd6Bral/WfUN4JhjB7HzQtZWk8fo=;
 b=aIzYBIKxXI+zjtVaxHBl1WZC4hBHnAX9mhMwcFcV6n689p11NTPjL9XbGo2nFbSYkC
 QDtEUGdH7c+qsPKF64HeQMpY6ZInS20EnvVq3xII5IKiMo9PupJp64Y1CiV8y6yjPsSe
 V2439YPEB1aaVHRolc6rpng9xiV2g+MVR8K8+6eUvJX3NB146J8XNODg5+jl+Nys6KRG
 v+RZ5zt5/EayBoMg5GrHloQIYlN8CXZng8er3b9pJy3Ug7yp54ctFl0vE9bQVXTmhccE
 WydkOEYV+wyBRANYgbqCcZASD9S6LnnEaAcO08ZTjrMgdx1YXQO+Y5mcloBoHPnyIoVf
 FDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772656065; x=1773260865;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rLUrnLpUQdD3tFiKd6Bral/WfUN4JhjB7HzQtZWk8fo=;
 b=r4moWgy0YIc7CGi+Ob6iAcVYy6krAhru985Cxx8fPFXWLUj2Czv1j+AyqzojPtM39R
 Yu6k2xVljWI/Bo4mf/xEkmkzXvk+DqVVF+ie/SNgY7AKnmdUxRyVLd09wtF677+hyPMd
 4cS56FNGx2q9mqaQMAlrbDHmAzaoOHgjgeHw2R432wqUgL0Y49QVnsSvAi9ErVpivHf9
 TzJr+MuEVok92FlecruQZj5fphHGly4f8e3fFzOLLJBZuje6TkbQcfY6tFSs020EDkOS
 a81tFFlNP0ywVwgvunqAWj6RiUOligKvBDWCYfcA45oHBq8L4BBHDV054EVA4dIha4AQ
 U5Lg==
X-Gm-Message-State: AOJu0YxmjuBzle2AP8W/f/7YvNFlsu7LEb/Idmcwt4QizvjfjfcVxbnh
 gIwVx5Uzdt/uxWkbqs7yp6IX0VNJdWDFCjUudCTt0Qe+T336AWZBnDqrx9OOZ5X4EkAd/KxrYNN
 vSVrOKiMMU3IVeDug1iB9nKpI3Urkn9CaPrwS
X-Gm-Gg: ATEYQzxfu5xSJhG6MrmBO7WLblLv0yMhaTkm90VgXA8/NTIsk/nrqelaUx9FNbDEg/8
 0FHvYbpaZv5LCXYJ2fNmi2SXv3x/10caPnwgsk7sZU9THauHEg4JHxw40dMbpO085aatCxt3bBr
 I4eJyEJuhJMwW9oiKbK0UbQec2SbgaVfkpMTNOV42CE5Wjdsa7D87+Lnim9tmv0TMcwa7n0PEuS
 5MT8p4xnaZp3JclNLA1D5nqud8YvzrLxKuJEU8w1YPnHk5d3vsSBLxdTAtCs0/9Lj1n1T7q4ocq
 23AoKKEmJPVloA/DWVlD5gLrS5+Q6MPjmuIwGmMrZXKV3qFEXrKIhG981Ik4kIbiLVTmsqG5W7S
 233cf
X-Received: by 2002:a05:7022:6b82:b0:11b:65e:f33 with SMTP id
 a92af1059eb24-128b70664bbmr792097c88.1.1772656065420; Wed, 04 Mar 2026
 12:27:45 -0800 (PST)
MIME-Version: 1.0
References: <20260304200741.1096953-1-mario.limonciello@amd.com>
In-Reply-To: <20260304200741.1096953-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Mar 2026 15:27:33 -0500
X-Gm-Features: AaiRm51taj1_5hBfLfnqqSbB67Xy6XEjTG0AdGvgiw_6aRF8eXAwcg9FzLffdAU
Message-ID: <CADnq5_My9MnHifeCLVSAEdd7xjNBeErYfMob4bZwaeSZqWX=Fw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix NULL pointer dereference in device cleanup
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Wed, Mar 4, 2026 at 3:08=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> When GPU initialization fails due to an unsupported HW block
> IP blocks may have a NULL version pointer. During cleanup in
> amdgpu_device_fini_hw, the code calls amdgpu_device_set_pg_state and
> amdgpu_device_set_cg_state which iterate over all IP blocks and access
> adev->ip_blocks[i].version without NULL checks, leading to a kernel
> NULL pointer dereference.
>
> Add NULL checks for adev->ip_blocks[i].version in both
> amdgpu_device_set_cg_state and amdgpu_device_set_pg_state to prevent
> dereferencing NULL pointers during GPU teardown when initialization has
> failed.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I think probably:
Fixes: 39fc2bc4da00 ("drm/amdgpu: Protect GPU register accesses in
powergated state in some paths")

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 5c24369821e47..258391ddee7c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3258,6 +3258,8 @@ int amdgpu_device_set_cg_state(struct amdgpu_device=
 *adev,
>                 i =3D state =3D=3D AMD_CG_STATE_GATE ? j : adev->num_ip_b=
locks - j - 1;
>                 if (!adev->ip_blocks[i].status.late_initialized)
>                         continue;
> +               if (!adev->ip_blocks[i].version)
> +                       continue;
>                 /* skip CG for GFX, SDMA on S0ix */
>                 if (adev->in_s0ix &&
>                     (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK=
_TYPE_GFX ||
> @@ -3297,6 +3299,8 @@ int amdgpu_device_set_pg_state(struct amdgpu_device=
 *adev,
>                 i =3D state =3D=3D AMD_PG_STATE_GATE ? j : adev->num_ip_b=
locks - j - 1;
>                 if (!adev->ip_blocks[i].status.late_initialized)
>                         continue;
> +               if (!adev->ip_blocks[i].version)
> +                       continue;
>                 /* skip PG for GFX, SDMA on S0ix */
>                 if (adev->in_s0ix &&
>                     (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK=
_TYPE_GFX ||
> --
> 2.53.0
>
