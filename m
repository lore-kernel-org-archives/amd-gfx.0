Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65DE606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aasF9R53
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 451F910E0C7;
	Mon, 26 Oct 2026 18:18:28 +0000 (UTC)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CFFD10E0C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 18:18:22 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1438dbb05c1so180798c88.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 11:18:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793038701; cv=none;
 d=google.com; s=arc-20260327;
 b=EjJ4oaIFHbvC5rvIn2E0PSl8iJBfho3Tf8fNVopwxy6TWoT51EgfmrMvA4KjdlkHVz
 KT19qUm+PC3aLBMfjJ+0uXWd3x/thhjmKeazKTtPJVTNhX5/3Yb0l9Pu7N9BwYvVnVBa
 gC4YJXeLLRiY22fUpVpXR8hubRuaKxiTZQz4g73/PifZd5ZLlXW6tVGMuwDOUwzv9LUQ
 NkZ/Ead28fyUl+W1BGYe5lkDoFSwGLfWwGFLa9uh2YxJasfg9O8iUGlsxECLLKHqHbRU
 euDKD8Bv2/3FlTXXqDHhZQF+b+KfaeAFeZrgFG3Ea11LFTH1PaGnA5fRd7Ft3vW9rV+P
 LxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rUFVEl7fV+HUh8nhoQnb/g9LkM23VhHFCgUj8hV83sM=;
 fh=LeyzQGF/lZ23XphB6HQQm3K33VCzNCe8IbwEM70Zph4=;
 b=Tu3P2uhf3EfVuGN/vfuQMVNYFpDTnZkNmrGVclNRyXBlOuZD5z4aLC5NAa2pocL5gv
 pUVgMYL7m5MCnSZFg4E0UJIj63iLdpcdOuSSwgitZqjsVmdvlgrVr60frsdYvgFjlbXN
 vThN1IWlMpWuZo8iQiYjUrJzI0jSg3UIlwlsdVYhOH8b7hp4awjUvQJZQjax+OlpMI5Y
 dLtlZrNRjDUNTGlMT0J4mx/DcMl89daOjUz2llUoAeh+9T7nqfCdBXeGoPnSQX76XWXi
 HEXYT13ANDyGtzYAg7fhga/55KBwa7qgguZ5Izg5shC8kShW0YF8kHkFQxqVldUNz2hB
 I/Ng==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793038701; x=1793643501; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rUFVEl7fV+HUh8nhoQnb/g9LkM23VhHFCgUj8hV83sM=;
 b=aasF9R532WA4TtV+fFjh1Cfw6zEtP3ruWvGIQ6UHm5AN4ZGsKrPmckUJ0HhGeM8jGs
 8ssfzNgZW61gw0xXD19iiJ93G+5e7r0zidLWUFtERLYxg65A/3PwlYMi/FxbDKpeJD0m
 aECcd9et7pp0oFszpET4gNoyY6lYzHx0bvtyn9JrI79SHNEKJDjWOCxZYKOcAL6OaudU
 YD69lp2YN5ybagynaILb0GfsMHGrHrnIkL4qLdLi1qn1i0Q+blo8KPapuXpr6zgLaBNl
 IXy7EoFMFnD/Qk9wotlev8LSJyEe2f6FDItg2NFRYOt0pXIkrdkJLklBmdDxSz9hcUtn
 VUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793038701; x=1793643501;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rUFVEl7fV+HUh8nhoQnb/g9LkM23VhHFCgUj8hV83sM=;
 b=MA2L/RN+Ba/MvlhCrtwNBv4Nl0s1VLGo7Nk8j0AL8unpsoDnAunGJjNWcMfJQWbDb+
 JUEwb0G5pSWTK5XFh+50UGcqUDvTsZwDVv3f0uICqOsn4dN/n8gGyfkwE82r+AOMcXyZ
 TSyNax3Tv9TjQA2fZJJn31YbMs+1mGh0rkqFy8XN50JuTxtC0RnR6aruGYwV5Eap4EhW
 zQg8gGGapl+PtznZeH3kPujWmazo1+13vbVNWW9mdnCJtt9DBZ2tMMp1FhF95XAlE9q9
 LdDeDEV+vHmxCVWqv/jj6Tv/999JG1TrPMgWJp/zKycDagQeHIeZ37FOsJN+IaVu7of/
 3O7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlX6VjEPIsJpEaZj49rEigODQS/2phGNXHwPqYZwGUn1Df9s9B8NUPA7xblwMr5F9OKFSaN7bf@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK0Y6rV85iNOz9RgeI0yl7bzgvfuf2GOreQedcS+XYic/SOfaIs
 lLChCdveibE7qwlQtDxyIBYPAFNkgs59uUAseyQ3F95ap2BCbjKFYcOpOqEyOhNZBhx9e2Z7D5H
 HmO4VpjNF79AF+GERGLqxfe6U9sSJ5p0=
X-Gm-Gg: AYBFou2BWII3bW2XJ2so48ha4eoCxZSINwMo+jeSl5xTwdzqp38YbIKrDx8U+o+/u4J
 j7y5V6uFbTKumxhtmx7SSxOlPAUz2EixjFRO77LOF3wj5w4nTuCUxOn7RAnDPI/bnrvFQlzV+s3
 oxUys42GB3RFsmipC1zUm5z4w/x6fjPZIGFF8p/3SaU+w+WVARt+kQH4Xbw0Gh2VUBUSNzPhvL3
 WYL2yQQcnL/KyDveRBNS6G86/ogjoBVFgLEln9Q2foRm+J5Z8ihDB4ioSDSlPo8tAC6PdX9mZx3
 If+AtPUunNp3+uQbymGfsmwrDcd6bMDVBGgcnzsSCjyqy7AlQ0mCvmNcpEpDVvJaWXAYm61fnzf
 WhDd5TPbUv9qJMmmaTxYocXgN7ICo536si3yaK+mFkA88PKMI7zc0W7hTbwqaY/P0REhY2SOwpj
 0P5vr2ZnSt0huLFzddY7hAhSo=
X-Received: by 2002:a05:7022:5f07:b0:146:ffa9:2117 with SMTP id
 a92af1059eb24-1993639e5f7mr16191284c88.1.1793038700920; Mon, 26 Oct 2026
 11:18:20 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
 <20261025040046.1602-13-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20261025040046.1602-13-atharvatiwarilinuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Oct 2026 14:18:09 -0400
X-Gm-Features: AclHuK_gGXqjT0cI7KV7tvEEJQhRHXFUqhLnyaELH9XqFgMeuwm1bkZPQKcDe-s
Message-ID: <CADnq5_NLhN4TKH-afTtJdF2d-e0=1kysf=pWiUpXu+bLhJFEeQ@mail.gmail.com>
Subject: Re: [PATCH 12/13] drm/amdgpu: Skip AC/DC notification while the GPU
 is runtime suspended
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Andre Eikmeyer <dev@deq.rocks>, Bjorn Helgaas <bhelgaas@google.com>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, Kenneth Feng <kenneth.feng@amd.com>, 
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, 
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
 "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 25, 2026 at 12:11=E2=80=AFAM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> From: Andre Eikmeyer <dev@deq.rocks>
>
> Plugging or unplugging the charger raises an ACPI AC event. The handler
> sent the new power source to the SMU without a runtime PM reference, so
> with GMUX keeping the GPU off every SMU message spun on skipped register
> reads for seconds. A runtime resume racing with that left the SMU
> firmware unable to start on MacBookPro15,1 and the GPU in runtime PM
> error state. Record the power source only and let the resume apply it.
>
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm=
/amdgpu_dpm.c
> index 808be6c42..b64f0b681 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -30,6 +30,7 @@
>  #include "amd_pcie.h"
>  #include "amdgpu_display.h"
>  #include "hwmgr.h"
> +#include <linux/pm_runtime.h>
>  #include <linux/power_supply.h>
>  #include "amdgpu_smu.h"
>
> @@ -498,20 +499,26 @@ int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_dev=
ice *adev,
>
>  void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
>  {
> +       int active =3D 0;
> +
>         if (adev->pm.dpm_enabled) {
>                 mutex_lock(&adev->pm.mutex);
> +               active =3D adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX ?
> +                               pm_runtime_get_if_active(adev->dev) : 1;

There's no reason this needs to be GMUX only.  You can drop the
AMDGPU_RUNPM_GMUX check here.

Alex

> +
>                 if (power_supply_is_system_supplied() > 0)
>                         adev->pm.ac_power =3D true;
>                 else
>                         adev->pm.ac_power =3D false;
>
> -               if (adev->powerplay.pp_funcs &&
> -                   adev->powerplay.pp_funcs->notify_ac_dc)
> -                       amdgpu_dpm_notify_ac_dc(adev);
> -
> -               if (is_support_sw_smu(adev))
> -                       smu_set_ac_dc(adev->powerplay.pp_handle, true);
> +               if (active) {
> +                       if (adev->powerplay.pp_funcs &&
> +                           adev->powerplay.pp_funcs->notify_ac_dc)
> +                               amdgpu_dpm_notify_ac_dc(adev);
>
> +                       if (is_support_sw_smu(adev))
> +                               smu_set_ac_dc(adev->powerplay.pp_handle, =
true);
> +               }
>                 mutex_unlock(&adev->pm.mutex);
>         }
>  }
> --
> 2.55.0
>
