Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E813BCCD19F
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 17:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FBFF10E492;
	Mon, 20 Oct 2025 17:21:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rvl/jEr3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 178CA10E491
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 17:21:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BDC5548C46
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 17:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7D6C116D0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 17:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760980889;
 bh=uI5rsFpiE13xOKlRUr0iIvhiw/jg45u3VMFRQxTK9Hk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Rvl/jEr3JCHqO7eVAcQ2vXHc4Cei02Xx6mPp//9vMReOYECUZuKOyRBR+1PEWGaA4
 OC0QZ6+t4kJMRFIJJbJwgZCdpcAw2s+dHkmCCjHU8VD3ZOQfjrhuCJMGfag72QqfST
 I6Bjc3dq6SeRjZPSjcR4FRNU4IzbZOd1U5dX3vXYoLcineMF8fz0zHbLkjqc5U7cVu
 Cd9hm3ahpdusMDDvIl2HRGLy8LUR6Waqfjv8u+TxMUWHeo0AdDkaU0DglgUQjOry2z
 idCNbCNd0uJEi7ZLN1dkaMUI5FaCTKSVGDAWAOwqRqPi0ybiqtwFwuXMvdj2g3UhKw
 zwRUsrO/I+V6w==
Received: by mail-oa1-f43.google.com with SMTP id
 586e51a60fabf-3c9a42d6349so4839260fac.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 10:21:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCW1ozG/sSe/5jnXqcLoGLxUG4DLmauDncnlVfA0YENIrqcHikl71eHs3SUzI2pccjHcz85/xiIU@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAtGOGgPvs/Zn+md1UzWUurA14SuVEnbwj5+1fS1j5ZNZ/hVQ3
 tbuKoKRDt2ZXayJZneN1ZXhb7ytrYMAgcldeb78BX48heJugR90vSP8yEqrjuEcXhYdH5f0JdnR
 cqUtDzVzK2O5mDSJpoESITsgbZ6nCon4=
X-Google-Smtp-Source: AGHT+IFU0bU8fKZ0Wua75/5pRYAXjg6ICdC5ZIAIZU0v6VlGJqQRFSAEBuztx/l/Pivh+cm/UonHIHXKPVckX8HLNyQ=
X-Received: by 2002:a05:6871:2e90:b0:387:9b79:a61b with SMTP id
 586e51a60fabf-3c98cff3fd9mr5575729fac.22.1760980888969; Mon, 20 Oct 2025
 10:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20251020165317.3992933-1-superm1@kernel.org>
 <20251020165317.3992933-4-superm1@kernel.org>
In-Reply-To: <20251020165317.3992933-4-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Oct 2025 19:21:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gsdmfXUJuLW8Ogt2jKDunx4g51LqCfSVMWQ6WHXBw_zg@mail.gmail.com>
X-Gm-Features: AS18NWChU2EP-kmiSeBpXBkZQsZMUWO1qaU0RIWwAVoz1ykVcHqEMNRFvTKh8NY
Message-ID: <CAJZ5v0gsdmfXUJuLW8Ogt2jKDunx4g51LqCfSVMWQ6WHXBw_zg@mail.gmail.com>
Subject: Re: [RFC 3/3] drm/amd: Return -EBUSY for amdgpu_pmops_thaw() on
 success
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, airlied@gmail.com, alexander.deucher@amd.com, 
 christian.koenig@amd.com, dakr@kernel.org, gregkh@linuxfoundation.org, 
 lenb@kernel.org, pavel@kernel.org, rafael@kernel.org, simona@ffwll.ch, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
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

On Mon, Oct 20, 2025 at 6:53=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> The PM core should be notified that thaw was skipped for the device
> so that if it's tried to be resumed (such as an aborted hibernate)
> that it gets another chance to resume.
>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 61268aa82df4d..d40af069f24dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2681,7 +2681,7 @@ static int amdgpu_pmops_thaw(struct device *dev)
>
>         /* do not resume device if it's normal hibernation */
>         if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_susp=
end())
> -               return 0;
> +               return -EBUSY;

So that's why you need the special handling of -EBUSY in the previous patch=
.

I think that you need to save some state in this driver and then use
it in subsequent callbacks instead of hacking the core to do what you
want.

>         return amdgpu_device_resume(drm_dev, true);
>  }
> --
