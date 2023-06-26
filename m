Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20478C0015E
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 15:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAB3210E226;
	Mon, 26 Jun 2023 15:06:06 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A11E10E226
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 15:06:05 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3a034e628fcso2333764b6e.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 08:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687791964; x=1690383964;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6B0AzI99a/sQDyhj8ZFF1ZrsLmfXfcLaapFgNs561yY=;
 b=OZaqe4cVVdHCEM0VKi17RjDsc6Q5PSrLEaEYX7wlSKv5LF1ggKXXxWjCncDEiURLCc
 hbzfIP99sAIRZvgHbQM+wSM33zWZ/lBBC+GA9/cP9F0+vWEmsYq3w9FhdMr0aYbL20UT
 nj4N71A5q7Eg2zhxPjpq+72HEWPeCxvtkPeedc8GBD0VzCZxPGJWwrl/gDROkNFUgAiG
 IbH4SR8AajZ+hnD9/drQBAfHSJI7VtXaIdJ0wPHrBQDEpgR50NPOta0bg+tQqXXkGYNN
 /ZtkyQTRZ2c+n1wgsrZLzdUHdAW94h+Cl05OecdfdXsUATrpkhNSzD0akef2Ws9x1Omw
 haSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687791964; x=1690383964;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6B0AzI99a/sQDyhj8ZFF1ZrsLmfXfcLaapFgNs561yY=;
 b=K/gcEfmoNnaMexeANJQU1dasnLJyewJwVxJn3ivNzaPA975FNdqLL6COvCJUG6826b
 t4kgeQGQLq/TjjSOGlMSq/6Qv2lxsNNA3JHeSgMO4LlOrQHa3n0jtkmYptx16OyPZhhc
 5LejygR0BfGUBYyK3O2kIGjj13WmYPeRqPdZOgAY36M6mFXtpVBu88K4s0sw3Kyfou9o
 oNuKShQxirDzyizvh7znYZWkFVEaTCem61wHm9W09SVgP8DhhK4PYBwSBwC3PbhOt12M
 6pOci1NyYmgzwu1c/pIpzWrVQDfw2RDp2uX4ZDvbKEv/dRzOpxKBlHOL9KyaAyJWJtia
 HVlA==
X-Gm-Message-State: AC+VfDxlSCd1537d7FPHBtF/kSHDMhmf3lvuniI5uxf3SF63QNOYJJnj
 YpTNEsPol+Sj5S9Ea6JJ4R+JDRGqFH5ZdNCUSSEaJg8r
X-Google-Smtp-Source: ACHHUZ57MQI8S2SYNIwek/UiGpvMXJRgDqEAHPFVIOO5nHv85W7DMCzdVKdvlinbOfK1joPPxFhIf3ZpUoWA29M5MRA=
X-Received: by 2002:aca:db55:0:b0:39e:c32d:1c8f with SMTP id
 s82-20020acadb55000000b0039ec32d1c8fmr12621763oig.22.1687791964553; Mon, 26
 Jun 2023 08:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230626145938.1393-1-mario.limonciello@amd.com>
In-Reply-To: <20230626145938.1393-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Jun 2023 11:05:53 -0400
Message-ID: <CADnq5_PTDFHnmaPeG=WyaaOEA10Gf8KhNif9VGGvQC8YffxROQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix a documentation warning about excess
 parameters
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 26, 2023 at 11:00=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> `pcie_index` and `pcie_data` aren't used by
> amdgpu_device_indirect_wreg() since commit 65ba96e91b68
> ("drm/amdgpu: Move to common indirect reg access helper") but
> the documentation wasn't updated. This causes a warning while
> building documentation.
>
> Fixes: 65ba96e91b68 ("drm/amdgpu: Move to common indirect reg access help=
er")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 65fe0f3488679..a3dae8ffbdb10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -747,8 +747,6 @@ u64 amdgpu_device_indirect_rreg64(struct amdgpu_devic=
e *adev,
>   * amdgpu_device_indirect_wreg - write an indirect register address
>   *
>   * @adev: amdgpu_device pointer
> - * @pcie_index: mmio register offset
> - * @pcie_data: mmio register offset
>   * @reg_addr: indirect register offset
>   * @reg_data: indirect register data
>   *
> @@ -778,8 +776,6 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device=
 *adev,
>   * amdgpu_device_indirect_wreg64 - write a 64bits indirect register addr=
ess
>   *
>   * @adev: amdgpu_device pointer
> - * @pcie_index: mmio register offset
> - * @pcie_data: mmio register offset
>   * @reg_addr: indirect register offset
>   * @reg_data: indirect register data
>   *
> --
> 2.34.1
>
