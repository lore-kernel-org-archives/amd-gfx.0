Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFDDC43458
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 19:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D7C10E3E9;
	Fri, 26 Jun 2026 19:39:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BxE8KJc7";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AC6710E3E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 19:39:04 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-30bb87c90deso166552eec.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 12:39:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782502743; cv=none;
 d=google.com; s=arc-20260327;
 b=Fy79fi/iuHSG1GcBGtnNAlFbfK6lCV/3i1w0ec9ll+i+0hpuEG5P5aT3rsuqjL0lo8
 Ptnz6K9gTVw6x1XCym/Y1cwDLu+mpWq1KSJwbMn/AF4HL73LrIDbd8n15P1Z+6rLfwNF
 nQFlmZkRvUmAnaSIK8QyNjZDv7v4zda5KVllaRSa/Rm/7HoEkfx+GwYYjzXEp+xPWhVT
 Oz3izlNrGbR3zvz2fIUNxTsiWG6G3QnMN/0OB44rfp74lXuI5drJCF/FEIw9oE8MLYTj
 Krb0eNLD9jNXAn+6JFgqXsZzDs8Wf6CzQAyCQPDSOC81XpZDFdhls9qOGHIqgWsWQchj
 9qqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ymD8IT6kcNdhPEekps/Z9O7NDXYnPeYvMCZ8i3L3Juw=;
 fh=BZqnJkDS12pEuaJQbJ/BwJU10C0354PX4g/AKZEARaU=;
 b=mu1TB0yZv7mD0TnleXrt66w7/jahw1Iqgn6p2HGNp2/O9ADvth3SX7TLQRUXAEbtE1
 uBROre6OwJOh73RaF/6r4Q/tDh/oiIpgJFbQ3x5LVIgohC+rZYy3I+bgrEGyt2dOq9U7
 yXa+wjNWawXmv92HM50j16aXVQuASCjaToF1aly4J/s6TL5/9PRLZWN8kZp4I1dYHwFr
 Gg9E1H/brzqaLP9J8TAvaCnCUO5h3zL7lDExdqnXoWtDApaXRyUYUYgwFjmNfhfZw2F7
 dMtSofiM2uR8YL1eLEp1wwBhyY0faDE5tDtAEHZKwj4GDExCZa2MM9R4o8A9m64M4Xow
 8wlQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782502743; x=1783107543; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ymD8IT6kcNdhPEekps/Z9O7NDXYnPeYvMCZ8i3L3Juw=;
 b=BxE8KJc7UyJcWN49rq+oJ0+14wo80NUSZuzZFKfE/aoaBIpYmSxLWKIUzm1qsRYrIP
 9E70JWZiEh6lwUzG5Qo0DDM/hFTm77BzAR5ZA2aC5PdLDGulwox0uGTNTeF5UsADqrho
 qrfoVmYxxgAUhzQgLFH2aoerCcYQeq/NuKpmNg0ZyFtVMkusjHFgnF0nXYnYCS8t+7FS
 dgIdLtuzohyhwGMHaQblSmlJJMmRmDg1Ld9wg6z99rzJTcdlYPBuZKZrbcDVTsrj0WrH
 8f6AAQlFEk7AnjBPpApzTq6SNlpi2tJHRnsH1amljEgV3P1qAyO7wDnzrw+0M68Dih8q
 GJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782502743; x=1783107543;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ymD8IT6kcNdhPEekps/Z9O7NDXYnPeYvMCZ8i3L3Juw=;
 b=nlj196LRJP1lj/vgS3w+DLH9pJyEc+Mt7ese0I0txU1ZFwlW/P44dHRKityrLWnddi
 uc/URJC4prCBRagE91CT+85dBJrKttw/uo+blGJXOEUveSiID9pR1/mpW/vVqIaqtbuF
 BWWGq7uupbwPWa0WSR6f+YqGOceOJX2RwxzNQvSh85Y5la3eeZnOgGCjmeDXd04AOIrE
 9YyFSGybvVzQjRhlPj2pxJ36fZDtdo3hhzVa344Jlybhxvt12Q4Cnrga4GY11S7Uc+IO
 H35MT0QjaPQUz9Lmt8sjSX2KNc95XjHCQVgnIz6KHVtrh8T6A8/J7KoPjfh8dzh+LHpP
 xuIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8lK8fAaXHbo7slFMvcIfxFjZzLaFI6+LMUMAflVbJolnH2nYtUhGpaTsowEME53E/NUHkvKzCQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yya6SzEQg+OKmbCMbjwRbUlsgMpp8uRRimWNlGA5VOgkxAIZMif
 agaTxVjfuZpdMlQADbvwyKjBJxdLRsWmxdHLyEKH/egZ4UVRjdCM/BW/M1aFoq0zNAAMiAzbIXz
 P9vsnc4bu8ZJdpeqooQIqc2/jtzWZodA=
X-Gm-Gg: AfdE7cnk1E2w0OulLYLviwS53HFDuaE6Zc8D4XlHR0N3sHn/5t0GAOa7Z4aFN4CFgzt
 qsAoX2OCq4slBzaC9HEPzX13yETaV31Pq+Zi8vADSjgBRO0gldWtR8Jaiur4cYtUtHGsWxfOThm
 5cfiOlVM8uY6AFDAucHDyamFbq/ANAWNKXYYiAEfQEjP+mQptCBM2Pr2uA4n8Rv3NQhVN2I6tUK
 Dspsr7TFoEpnIZSDYVv54ckDQOb+mS4VIZ2qXSYQsKxHX6uS9Y9+QQ7eCLiP6HJEv3BcNTjkuJ7
 y5YNwQupXbX8xh8kppRsblb5gwAhJwFTL+ikzXPfvJAzXM+pLozTzJEvvLy5Ck52AyWSeQ==
X-Received: by 2002:a05:7022:6b9c:b0:139:ed5b:1459 with SMTP id
 a92af1059eb24-139ed5b1529mr545472c88.9.1782502743091; Fri, 26 Jun 2026
 12:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260621173211.28443-1-oz@shift-computing.de>
 <20260621180154.30421-1-oz@shift-computing.de>
 <716a31c5-0484-4ef9-b49e-b71310f92d86@amd.com>
In-Reply-To: <716a31c5-0484-4ef9-b49e-b71310f92d86@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 26 Jun 2026 15:38:51 -0400
X-Gm-Features: AVVi8Ceqj9OvWI37y5ACqaKD1A7BQxhav_LOaaBB5xtZRRVm9ASTNOh1QdbNUsM
Message-ID: <CADnq5_MWX-xO=+rUzCiMR=J+Jovi8=RRJFBke=4J-7JsR1xLqQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: add firmware file fallback for APU VBIOS
 discovery
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Oz Tiram <oz@shift-computing.de>, amd-gfx@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
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

On Fri, Jun 26, 2026 at 1:42=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 6/21/26 13:01, Oz Tiram wrote:
> > APUs (e.g. AMD Radeon 780M / HawkPoint, PCI 1002:1900) have no
> > dedicated VBIOS ROM chip.  amdgpu_get_bios_apu() attempts four paths
> > before giving up:
> >
> >    1. ACPI VFCT table
> >    2. VRAM BAR read
> >    3. ROM BAR read
> >    4. platform BIOS
> >
> > On some systems all four fail:
>
> That's pretty odd to me.  Isn't this a BIOS bug?  Can you share more
> about why all of these are failing?
>
> Does the UEFI GOP driver work?
>
> >
> >    - The VFCT table is absent or contains only the discrete GPU entry
> >      (e.g. when a custom ACPI override is present for the dGPU only).
> >    - The VRAM BAR is unmapped at probe time.
> >    - The ROM BAR is zero (PCI firmware did not assign it; observed even
> >      with pci=3Drealloc,assign-busses).
> >    - No platform BIOS mapping exists.
> >
> > The driver then prints "Unable to locate a BIOS ROM" and refuses to
> > bind, leaving the APU completely unusable under Linux even though the
> > hardware is functional.
> >
> > Add a fifth fallback: request a firmware file named
> > "amdgpu/<vendor>_<device>.bin" (e.g. "amdgpu/1002_1900.bin") via
> > request_firmware().  This allows a VBIOS image extracted from the
> > running hardware
>
> I thought you just said this didn't work.  How did you extract it?

This is not likely to work which is why we don't generally support
this.  On APUs, the base vbios image is updated by the sbios at boot
depending on the runtime configuration of the specific system (OEM
display configuration, etc.).  Overriding these values with something
else can cause serious problems.

Alex

>
> > to be shipped as a firmware blob in /lib/firmware/ and
> > makes the binding succeed without any change to the ACPI tables.
> >
> > The fallback is only reached if all existing paths have already failed,
> > so there is no regression risk for boards where VFCT or ROM BAR work.
> >
> > Signed-off-by: Oz Tiram <oz@shift-computing.de>
> > ---
> > v2: Validate the fetched firmware with check_atom_bios() before accepti=
ng
> >      it, consistent with all other VBIOS discovery paths.  Save fw->siz=
e
> >      before release_firmware() so it remains valid for the size check.
> >      Release the buffer via amdgpu_bios_release() if validation fails.
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_bios.c
> > index aa039e148a5e..86064c753b09 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> > @@ -26,6 +26,7 @@
> >    *          Jerome Glisse
> >    */
> >
> > +#include <linux/firmware.h>
> >   #include "amdgpu.h"
> >   #include "atom.h"
> >
> > @@ -457,6 +458,28 @@ static bool amdgpu_get_bios_apu(struct amdgpu_devi=
ce *adev)
> >               goto success;
> >       }
> >
> > +     {
> > +             const struct firmware *fw;
> > +             char fw_name[32];
> > +             size_t fw_size;
> > +
> > +             snprintf(fw_name, sizeof(fw_name), "amdgpu/%04x_%04x.bin"=
,
> > +                      adev->pdev->vendor, adev->pdev->device);
> > +             if (request_firmware(&fw, fw_name, adev->dev) =3D=3D 0) {
> > +                     adev->bios =3D kmemdup(fw->data, fw->size, GFP_KE=
RNEL);
> > +                     fw_size =3D fw->size;
> > +                     release_firmware(fw);
> > +                     if (!adev->bios || !check_atom_bios(adev, fw_size=
)) {
> > +                             amdgpu_bios_release(adev);
> > +                     } else {
> > +                             adev->bios_size =3D fw_size;
> > +                             dev_info(adev->dev, "Fetched VBIOS from f=
irmware file %s\n",
> > +                                      fw_name);
> > +                             goto success;
> > +                     }
> > +             }
> > +     }
> > +
> >       dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
> >       return false;
> >
>
