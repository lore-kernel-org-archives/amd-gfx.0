Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BFFC021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 16:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCCAE10E85A;
	Wed, 19 Feb 2025 16:42:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jnbzOIxN";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8972A10E85A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 16:42:50 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2217875d103so2026145ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 08:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739983370; x=1740588170; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VhSzi9mvtkb3e7wuskUuuqmxgA4h1laDigC9d5f2bgA=;
 b=jnbzOIxNu5gePl1VMDlH4UPrdXCjMfiyj7btHinWh7qKZ5QxHQ5KJjszrdE2JH1u/c
 /YrijBS86gtgmPUukFTZ8HpwQjbflfVbJXmSly/z4WhbwB7jGh1fUrn3totU+Ikcdngj
 kJrO4Bogxp2btUD3iT8yhvlxz67vAaNrRAIQpFuxa1KtoB7rR03cOBOd9muQXDdSE4FL
 hV8Yd+VV5HI8ItGGIUTjrIQO6F/uKxuZDwgRz7tGvkDmYDR0iI/Uqi9ynGK8kFVMEW8M
 cVdNZYAQwijBTgxGa65XfHFZkTaZrcWLV+PKfzSe5J+m5wY1cKfxCGhbr9ULhfxfhZ49
 PvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739983370; x=1740588170;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VhSzi9mvtkb3e7wuskUuuqmxgA4h1laDigC9d5f2bgA=;
 b=xFvxBQZQDK7Ap6iiecirtvzyocuLrb2p/dXRB9vP/t6MvdIcKLLlawaKFViLQmqB+R
 Q7ntpyg7gWTcmif1yLwHqoRkvie6rtUc4+ZHqLCxmPfPpP/ZS59ONxEBs6Jfqbls8/0g
 1MlEm9y2oVgc3qdg9wh0gS1eKwvdQxXXzJzBM+7i6mhzvjVeXaZqI7RTl/P7cCxD1Eb3
 O6ipZ08jxwlTPxVJhPoKBqb5BAV97NSvN5TA/bFmwbWw7YbcuNeFDewyAVt8de8dQhp/
 FM5GlDOOYQqhTaGM+UXrQoCRgzzsPN1ed0WbtYUBIHv6E0K5iBeEIy9BWNtavug56S09
 e3tg==
X-Gm-Message-State: AOJu0YwWn3WgZXaa7rBoJQYA+MOwExhjJk4eKmoRfcNUGTq+cRujPi7u
 Pn5R2eSw+U2eM+mS6Ktr3NnLNKY/EUczjs8E2kjZdzqvRnAH2/nWPSOHswOE6iyOFQOLknubVEt
 6GhF5MyAiS7usnBtnfXDLuB3TmZutgm2q
X-Gm-Gg: ASbGncu1DfWJB4Z9wbiIgYBHfeimyxdEVrfsJC3ke1EC0KkF+I54DSeo5Kj6eJQCzVt
 O3fnumVyj1BGWkT0vIUxc0d8y1BzfnV5XHIXE4PLHHeH5s97/N/dLK12dRX290EymlMygQKI1
X-Google-Smtp-Source: AGHT+IFpeZUO2XERJLLl3Ee/ZUHvrM3DQFqAd9VLvTZhRMuHIAIdSKD6vCICfv7Kql+N0VrNH/vV2kqJ0CRXHQPd6OI=
X-Received: by 2002:a17:903:40c5:b0:220:d71d:4666 with SMTP id
 d9443c01a7336-22104096854mr110733745ad.13.1739983369983; Wed, 19 Feb 2025
 08:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20250219162802.61564-1-alexander.deucher@amd.com>
In-Reply-To: <20250219162802.61564-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Feb 2025 11:42:37 -0500
X-Gm-Features: AWEUYZl0IwvYR_I6dOZgtLCUtC3OVE-48AWIBx8VlXbHsik1jDakdbzHEB7eMys
Message-ID: <CADnq5_P_yKOTV2_ECrrHtsu60H86=V4=m00wJHF+Zj9vdzL72A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable BAR resize on Dell G5 SE
To: Alex Deucher <alexander.deucher@amd.com>
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

On Wed, Feb 19, 2025 at 11:39=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> There was a quirk added to add a workaround for a Sapphire
> RX 5600 XT Pulse that didn't allow BAR resizing.  However,
> the quirk caused a regression with runtim pm on Dell laptops

runtim -> runtime fixed locally.

Alex

> using those chips, rather than narrowing the scope of the
> resizing quirk, add a quirk to prevent amdgpu from resizing
> the BAR on those Dell platforms unless runtime pm is disabled.
>
> v2: update commit message, add runpm check
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
> Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT=
 Pulse")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 5ec71f146fa93..cae6dcb95a131 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1662,6 +1662,13 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_devi=
ce *adev)
>         if (amdgpu_sriov_vf(adev))
>                 return 0;
>
> +       /* resizing on Dell G5 SE platforms causes problems with runtime =
pm */
> +       if ((amdgpu_runtime_pm !=3D 0) &&
> +           adev->pdev->vendor =3D=3D PCI_VENDOR_ID_ATI &&
> +           adev->pdev->device =3D=3D 0x731f &&
> +           adev->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_DELL)
> +               return 0;
> +
>         /* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
>         if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
>                 DRM_WARN("System can't access extended configuration spac=
e, please check!!\n");
> --
> 2.48.1
>
