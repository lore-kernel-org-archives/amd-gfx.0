Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B281CECD983
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 16:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CCEB10E923;
	Thu,  5 Feb 2026 16:55:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KCe866Po";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0261A10E923
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 16:55:52 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-124b07e5fe4so54646c88.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 08:55:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770310552; cv=none;
 d=google.com; s=arc-20240605;
 b=GD2sUPAwfMGOwgdPRpidztIiYjUdhVxsHQYsc4SSUA1r9RudW41qRpEbC3pBdRz00N
 XQpAAJnw1Ogcl1kGiF48ZxQuy2owhE8QHxI4iN4BTF5Hi8ZI6N5K7j1tfqtRQaMnfDea
 Bn4MRN25HgRBuiLa9XpEn5bo0s7O/dbvSF4T51t+zF2EdA2/QEmNnnUqs/atTUm2Xu1r
 GWDX8wngL0mVZ91M8od3SXXVBAW2/A1FZmr4t95TYkPf3vXAHQ2TejqeTTGomntZBx39
 LMtFjH1hj79rW7QuwAwhRVii7Onp/xd1uE1HES+W3rEF1tJOHdGTHce6jdJc6224LvcV
 oCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qYcv7WBX28jkw74k2LvZGucdgX44JyzgaQDtSSUGDz8=;
 fh=8ZsOUXip5ZygMVAC7OdZyx5XI3P3K9qm3P6Cm6h+xd8=;
 b=Vtlmj2SJ7d/9larjxXZYF7JgOo2eGBMyqKIHtR0tJ4wNW0hGg9P2BW9QbttAZoVSkX
 /q+dDEIbZcHEV5sRAb0Wp78JLPhNiOyafJ4ruhkhPYmWjeiJPJQw1nIv750jwz9Q9JSt
 MbMukXR8itdHLIwqX7StPpbv+pJMlh2gj/KjbizJD19xIZhWnIsX+eEXtdpva0QepHS2
 NYyhRu/F2ozbBPPgoEAs3SzWTdERQRdfoQ/MziW2ZLitF1VqJZ9D8QFKGQfCqAcb5G+Z
 EJ07fMXOWIMo5MXJdWH9IoOVFN0OwYnT7bdNmnCSCF4yO3EAHrxa/+to3YLDB9KW5pll
 nIHA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770310552; x=1770915352; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYcv7WBX28jkw74k2LvZGucdgX44JyzgaQDtSSUGDz8=;
 b=KCe866PoadRy3/1LZzLzBUkt7gHMyjsRwb558mhW/pB3j7b2rN5NAFmzT9iffUzo8O
 ZFNKWsToGZbSUHwXnbtOryslXlEpL2O+8WOmfyc7pKtiRcdgDn4iyMfIPpdPGtnAGkVi
 yORt2izwUcOCFW29QPuPb5SzDYsvzqL7grL98px8s1ChlgivP0MkzVxk8FjNSPIJEszO
 jqixMe+mD9OeT25u+ShoqwoRfc5g7Qsyv+IKMToh458PJ+ggL9IccFG0TnqaGyJ8azR2
 HVGJgboezqnyqN3XLpSFt1fLljdBywvowhC6FN/XPTSl3yZ571vEg5gh1eg+SMIbahOo
 Oauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770310552; x=1770915352;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qYcv7WBX28jkw74k2LvZGucdgX44JyzgaQDtSSUGDz8=;
 b=aRNWrp0kT3g4koVPFGJEdLHmp80W1MyC0WGyyymtO89XfUf7ZoDDjTmVxrAbJ+83ho
 4tE3jXOE/T1w+ukdDkFnbCMea1Flvdy5UdiUK9TybXA70Y5ToZ5NNhn6Fi80DKpbUdnF
 +jKmQqCwVjtGCqxUXXX1OLJlOPikDHTjSov85CwxxBgtkBTOCXMnjGQ8/H1OQL9bIWlX
 f0izvXz/ldhrLEkxfY28GXWqc04GYw8S8s1bNhvjxIqvMR0dS0tBIulnEqV9roEnpmpb
 7pvdSHdfZv4bfhV/o3SqVSAw31dOYHF+zBbUnBF7QyH+Hn36wq/e+0RaLZvWnzPxeIBc
 i0Rw==
X-Gm-Message-State: AOJu0YyIMxj8UuXPAcCyuT9xZBv1/lp/AzUdpGz++hlIgD2gGekcFZYr
 5rnzKSW+j+DqP1Zl2AIvPG6bgdFdCWEMdg+OssVFVq4dlEMnF/r4pP0ePH8Rm6YL7K0LcrUQsaW
 1alZcs9/oMIiDhELxm/Uw+A2vv8J2qwN11w==
X-Gm-Gg: AZuq6aLimuvcSvq1AvKwO8iTsm6JWyvhjxJ3Kudz3ZVP6msn0IOZKjK6ChCivhyXdHN
 Whl+m3+Pz9d3bacmD1b/LiFYYHP4nVW/jZoKU35jtTQPFS7jdsMvB5t9twqbASye/xcmF76GmIB
 /sDq4IpUeGaAfXpGk5RJockuNX3XrS3ptT2UzGwXSEOFHzddfMm4CPuhrRM0u0E1wB8QC6txjH4
 oWNHImD4pL4SoLhzzFcp0I5ittgGuGZ5uZyK0Hsok9FgJi5BoawqqWNarLS9woj67MKTYox
X-Received: by 2002:a05:7022:e984:b0:11e:3e9:3e98 with SMTP id
 a92af1059eb24-126f610a287mr1497908c88.7.1770310552061; Thu, 05 Feb 2026
 08:55:52 -0800 (PST)
MIME-Version: 1.0
References: <20260205164254.4091912-1-mario.limonciello@amd.com>
In-Reply-To: <20260205164254.4091912-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Feb 2026 11:55:40 -0500
X-Gm-Features: AZwV_QgJax6xm9aiLaUdQsK82bFU0ItUqKcDY7SunLUTXAaUwMCt70E9fsX4t9w
Message-ID: <CADnq5_OyKt2Yjj5u=mn9PWJ9c-ND_LSgZatURwLSgrigYdnMBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix hang on amdgpu unload by using
 pci_dev_is_disconnected()
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Cal Peake <cp@absolutedigital.net>
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

On Thu, Feb 5, 2026 at 11:52=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The commit 28695ca09d32 ("drm/amd: Clean up kfd node on surprise
> disconnect") introduced early KFD cleanup when drm_dev_is_unplugged()
> returns true. However, this causes hangs during normal module unload
> (rmmod amdgpu).
>
> The issue occurs because drm_dev_unplug() is called in amdgpu_pci_remove(=
)
> for all removal scenarios, not just surprise disconnects. This was done
> intentionally in commit 39934d3ed5725c ("Revert "drm/amdgpu: TA unload
> messages are not actually sent to psp when amdgpu is uninstalled"") to
> fix IGT PCI software unplug test failures. As a result,
> drm_dev_is_unplugged() returns true even during normal module unload,
> triggering the early KFD cleanup inappropriately.
>
> The correct check should distinguish between:
> - Actual surprise disconnect (eGPU unplugged): pci_dev_is_disconnected()
>   returns true
> - Normal module unload (rmmod): pci_dev_is_disconnected() returns false
>
> Replace drm_dev_is_unplugged() with pci_dev_is_disconnected() to ensure
> the early cleanup only happens during true hardware disconnect events.
>
> Reported-by: Cal Peake <cp@absolutedigital.net>
> Closes: https://lore.kernel.org/all/b0c22deb-c0fa-3343-33cf-fd9a77d7db99@=
absolutedigital.net/
> Fixes: 28695ca09d32 ("drm/amd: Clean up kfd node on surprise disconnect")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index d2c3885de711f..8900e0dc8a61d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5068,7 +5068,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *ad=
ev)
>          * before ip_fini_early to prevent kfd locking refcount issues by=
 calling
>          * amdgpu_amdkfd_suspend()
>          */
> -       if (drm_dev_is_unplugged(adev_to_drm(adev)))
> +       if (pci_dev_is_disconnected(adev->pdev))
>                 amdgpu_amdkfd_device_fini_sw(adev);
>
>         amdgpu_device_ip_fini_early(adev);
> @@ -5080,7 +5080,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *ad=
ev)
>
>         amdgpu_gart_dummy_page_fini(adev);
>
> -       if (drm_dev_is_unplugged(adev_to_drm(adev)))
> +       if (pci_dev_is_disconnected(adev->pdev))
>                 amdgpu_device_unmap_mmio(adev);
>
>  }
> --
> 2.52.0
>
