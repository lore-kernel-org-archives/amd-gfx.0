Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AF5D41C06
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 14:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA8A410E2AC;
	Thu, 11 Dec 2025 14:34:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GHrZws3g";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4148710E2AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 14:34:10 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-7b7cdcdd8afso13414b3a.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 06:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765463650; x=1766068450; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=btmLPf8yWccDo9iGica5P43eXD2kP2r8mqMP3kcew2E=;
 b=GHrZws3g/5iW1i8aYeAdZU1Bdm1Gx4R3nyflX0DE6T/Q8my+xIHBoIHmtgEWQXCPh3
 9dEq4l29UxGGwe0yXarxJjauSoCV3lL8cYjjua4KIKEnA01SUXS96P2WkHDvLwaa5BRX
 9xwHofZSZacgKO4YcB1jYN4Kkulzz5guSdqI99a+fg/04TbqdZF6D+V2iuqmqqbnowVM
 VqOdviS3SYWFqc7eSuHYLz1IeVyPGFY22Wd8pjmV7Np202CPMtDVZwDb7sOp49A2EgLX
 uN5rmhqJrbgorQ4whrB9dBVaXdF6YmHd2WXo3Eo+W02pRln9T9FB6KA3YvjZIKDfQRJI
 HeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765463650; x=1766068450;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=btmLPf8yWccDo9iGica5P43eXD2kP2r8mqMP3kcew2E=;
 b=Al0FCrAUdrQmqhxlRjoIdclljPEd3WaAtWczOVSdmQDmlfN4+XcGm3VmfFlAIBj8x0
 CXKamDVAd6qxixKWBbVh+2V8R4YUnZ2kzBNRbbbck+lh7o8k0b9Kw/dzp8rUHfCdwFn8
 NQnbORSMzGjGu3vTCfqBddTXoVlaXUbaTB4KuugbaaJD4JWcnUfXMoqWxmeRgIufXvW1
 /aHpxQK2ucD7/xqcmrinr+UMl+1DuywI2QWNxBKck7f9Eh1pvSB7+EhFtcBlSISzMJMm
 Nh/BPScCb2HyY8kyoAtXO5LQpI/Wy0UmYjbNPUjOlOkxfdNDkLN9SPs+vNLgIcQrMbcK
 EXjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeY+yhkyFD6I2JbFSM4X2eHAYn7juqTo5IA0xfOTEgesJxFaNMFUdyoTkluuQQI99P3OtPbjRJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQBB5Pv+Xnk+JflcQS/tAL9Ezqg38j6GPIjK34PvSj3Trx3tQd
 kcVdmmBOPwLhU+X4q6NTODB5th69iCktEvWONBnf8JeNcoJ6ESJIwQ+LFKSFriiTcC+WXUs0K9Y
 7FOZyIFeqPn7bm4aX5mVa3x50ZEdqOk0=
X-Gm-Gg: AY/fxX69Ooyktkdz2NMxoMsLujoteIlWBLzck5HRpT6IRoH2bKiwMIMIthYGRtIJnQb
 WiTMoZOoKIR7z4UXVemv/GHOeZy/+yqvRxonVFjmKOesH28DdCuiUH6j7KfV50SlAYKgu5254d+
 mnkZemWot7iybDTwQNTWeGaq6Cl3sfRRDFmWb4/bGYMvfqjhl1fDYndECvZbNt0Dq3nFTMGRdOZ
 ch1vc0/mFPvO2ITaXLBW5V/XkggremDt0SIe5a9g9lk5/uc0bQMP6lMry2sMUrvmn6WaZ53swDs
 3Hp1Sg==
X-Google-Smtp-Source: AGHT+IGymtT7LusKNG5N22JJLsYb4PH74S17vPlU2+angqRtkQTuvigG9VBp7kvlmiEsSZgVSVkibrRFWyoagwaGhtI=
X-Received: by 2002:a05:7022:6187:b0:119:e55a:95a3 with SMTP id
 a92af1059eb24-11f2e82aa2dmr1070766c88.5.1765463649479; Thu, 11 Dec 2025
 06:34:09 -0800 (PST)
MIME-Version: 1.0
References: <20251210015140.568540-1-pratap.nirujogi@amd.com>
 <db479aed-d96d-414c-88f2-a699accf24f8@amd.com>
 <2aa0eb5d-6097-43eb-bb18-4fc7d793256c@amd.com>
In-Reply-To: <2aa0eb5d-6097-43eb-bb18-4fc7d793256c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Dec 2025 09:33:57 -0500
X-Gm-Features: AQt7F2oRb7eY649VRkg2NYBu3O0wb3dmXNsApWpyKd2-bz3x4odgnlw_nmi2GhE
Message-ID: <CADnq5_M36+bQ_kbfhGLFD3uHxWqAHZcPY93Vkzq=0B=EBm7JLw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix SMU warning during isp suspend-resume
To: "Nirujogi, Pratap" <pnirujog@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, 
 amd-gfx@lists.freedesktop.org, mlimonci@amd.com, alexander.deucher@amd.com, 
 christian.koenig@amd.com, benjamin.chan@amd.com, bin.du@amd.com, 
 gjorgji.rosikopulos@amd.com, king.li@amd.com, dantony@amd.com, 
 phil.jawich@amd.com, Gjorgji Rosikopulos <grosikop@amd.com>
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

On Wed, Dec 10, 2025 at 6:24=E2=80=AFPM Nirujogi, Pratap <pnirujog@amd.com>=
 wrote:
>
> Hi Mario,
>
> On 12/9/2025 10:28 PM, Mario Limonciello wrote:
> >
> >
> > On 12/9/2025 7:50 PM, Pratap Nirujogi wrote:
> >> ISP mfd child devices are using genpd and the system suspend-resume
> >> operations between genpd and amdgpu parent device which uses only
> >> runtime suspend-resume are not in sync.
> >>
> >> Linux power manager during suspend-resume resuming the genpd devices
> >> earlier than the amdgpu parent device. This is resulting in the below
> >> warning as SMU is in suspended state when genpd attempts to resume ISP=
.
> >>
> >> WARNING: CPU: 13 PID: 5435 at
> >> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:398
> >> smu_dpm_set_power_gate+0x36f/0x380 [amdgpu]
> >>
> >> To fix this warning isp suspend-resume is handled as part of amdgpu
> >> parent device suspend-resume instead of genpd sequence. Each ISP MFD
> >> child device is marked as dev_pm_syscore_device to skip genpd
> >> suspend-resume and use pm_runtime_force api's to suspend-resume
> >> the devices when callbacks from amdgpu are received.
> >>
> >> Signed-off-by: Gjorgji Rosikopulos <grosikop@amd.com>
> >> Signed-off-by: Bin Du <bin.du@amd.com>
> >> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> >
> > Who is the patch author?  If you guys worked together, there should be
> > Co-developed-by tags to represent it.
> >
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 24 ++++++++++
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |  2 +
> >>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 59 +++++++++++++++++++++++=
++
> >>   3 files changed, 85 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> >> index 37270c4dab8d..532f83d783d1 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> >> @@ -318,12 +318,36 @@ void isp_kernel_buffer_free(void **buf_obj, u64
> >> *gpu_addr, void **cpu_addr)
> >>   }
> >>   EXPORT_SYMBOL(isp_kernel_buffer_free);
> >>   +static int isp_resume(struct amdgpu_ip_block *ip_block)
> >> +{
> >> +    struct amdgpu_device *adev =3D ip_block->adev;
> >> +    struct amdgpu_isp *isp =3D &adev->isp;
> >> +
> >> +    if (isp->funcs->hw_resume)
> >> +        return isp->funcs->hw_resume(isp);
> >> +
> >> +    return -ENODEV;
> >> +}
> >> +
> >> +static int isp_suspend(struct amdgpu_ip_block *ip_block)
> >> +{
> >> +    struct amdgpu_device *adev =3D ip_block->adev;
> >> +    struct amdgpu_isp *isp =3D &adev->isp;
> >> +
> >> +    if (isp->funcs->hw_suspend)
> >> +        return isp->funcs->hw_suspend(isp);
> >> +
> >> +    return -ENODEV;
> >> +}
> >> +
> >>   static const struct amd_ip_funcs isp_ip_funcs =3D {
> >>       .name =3D "isp_ip",
> >>       .early_init =3D isp_early_init,
> >>       .hw_init =3D isp_hw_init,
> >>       .hw_fini =3D isp_hw_fini,
> >>       .is_idle =3D isp_is_idle,
> >> +    .suspend =3D isp_suspend,
> >> +    .resume =3D isp_resume,
> >>       .set_clockgating_state =3D isp_set_clockgating_state,
> >>       .set_powergating_state =3D isp_set_powergating_state,
> >>   };
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> >> index d6f4ffa4c97c..9a5d2b1dff9e 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> >> @@ -38,6 +38,8 @@ struct amdgpu_isp;
> >>   struct isp_funcs {
> >>       int (*hw_init)(struct amdgpu_isp *isp);
> >>       int (*hw_fini)(struct amdgpu_isp *isp);
> >> +    int (*hw_suspend)(struct amdgpu_isp *isp);
> >> +    int (*hw_resume)(struct amdgpu_isp *isp);
> >>   };
> >>     struct amdgpu_isp {
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> >> b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> >> index 4258d3e0b706..560c398e14fc 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> >> @@ -26,6 +26,7 @@
> >>    */
> >>     #include <linux/gpio/machine.h>
> >> +#include <linux/pm_runtime.h>
> >>   #include "amdgpu.h"
> >>   #include "isp_v4_1_1.h"
> >>   @@ -145,6 +146,9 @@ static int isp_genpd_add_device(struct device
> >> *dev, void *data)
> >>           return -ENODEV;
> >>       }
> >>   +    /* The devcies will be managed by the pm ops from the parent */
> >
> > devices
> >
> >> +    dev_pm_syscore_device(dev, true);
> >> +
> >>   exit:
> >>       /* Continue to add */
> >>       return 0;
> >> @@ -177,12 +181,65 @@ static int isp_genpd_remove_device(struct
> >> device *dev, void *data)
> >>           drm_err(&adev->ddev, "Failed to remove dev from genpd
> >> %d\n", ret);
> >>           return -ENODEV;
> >>       }
> >> +    dev_pm_syscore_device(dev, false);
> >>     exit:
> >>       /* Continue to remove */
> >>       return 0;
> >>   }
> >>   +static int isp_suspend_device(struct device *dev, void *data)
> >> +{
> >> +    struct platform_device *pdev =3D container_of(dev, struct
> >> platform_device, dev);
> >> +
> >> +    if (!dev->type || !dev->type->name)
> >> +        return 0;
> >> +    if (strncmp(dev->type->name, "mfd_device", 10))
> >> +        return 0;
> >> +    if (!strncmp(pdev->mfd_cell->name, "amdisp-pinctrl", 14))
> >> +        return 0;
> >
> > Could we store the mfd_cell pointer instead and just compare the
> > pointers?
>
> I don't think I can do a pointer comparision to identify the correct
> mfd_cell, string comparision seems like required in this case.
>
> Its because when isp mfd child devices are created using
> mfd_add_hotplug_devices(), it is not returning the pdev or mfd_cell handl=
es
> to store in the amdgpu_isp and later use in suspend/resume to compare
> with incoming pdev->mfd_cell to detect the correct the device.
>
> The mfd-core is doing a kmemdup of mfd_cells data passed to
> mfd_add_hotplug_devices() to create the platform device.
>
> https://github.com/torvalds/linux/blob/master/drivers/mfd/mfd-core.c#L163
>
> I'm considering to add this function to check for valid isp mfd child
> devices that are allowed to do suspend-resume, this can minimize the
> checks, but still cannot eliminate the string comparsion, please let us
> know your thoughts.

Can you do something like what was done in the acp code?  See:

commit 4fce6b64ec8bcd0694f221906952d2880ed8ae31
Author: Brady Norander <bradynorander@gmail.com>
Date:   Tue Mar 25 17:05:17 2025 -0400

    drm/amdgpu: use static ids for ACP platform devs

    mfd_add_hotplug_devices() assigns child platform devices with
    PLATFORM_DEVID_AUTO, but the ACP machine drivers expect the platform
    device names to never change. Use mfd_add_devices() instead and give
    each cell a unique id.

    Signed-off-by: Brady Norander <bradynorander@gmail.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>
> static bool is_valid_mfd_device(struct platform_device *pdev)
> {
>      const struct mfd_cell *mc =3D mfd_get_cell(pdev);
>      if (!mc)
>          return false;
>      if (!strncmp(mc->name, "amdisp-pinctrl", 14))
>          return false;
>      return true;
> }
>
> Thanks,
>
> Pratap
>
> >
> >> +
> >> +    return pm_runtime_force_suspend(dev);
> >> +}
> >> +
> >> +static int isp_resume_device(struct device *dev, void *data)
> >> +{
> >> +    struct platform_device *pdev =3D container_of(dev, struct
> >> platform_device, dev);
> >> +
> >> +    if (!dev->type || !dev->type->name)
> >> +        return 0;
> >> +    if (strncmp(dev->type->name, "mfd_device", 10))
> >> +        return 0;
> >> +    if (!strncmp(pdev->mfd_cell->name, "amdisp-pinctrl", 14))
> >> +        return 0;
> >
> > same comment as above
> >
> >> +
> >> +    return pm_runtime_force_resume(dev);
> >> +}
> >> +
> >> +static int isp_v4_1_1_hw_suspend(struct amdgpu_isp *isp)
> >> +{
> >> +    int r;
> >> +
> >> +    r =3D device_for_each_child(isp->parent, NULL,
> >> +                  isp_suspend_device);
> >> +    if (r)
> >> +        dev_err(isp->parent, "failed to suspend hw devices (%d)\n", r=
);
> >> +
> >> +    return 0;
> >
> > Shouldn't you return r?
> >
> >> +}
> >> +
> >> +static int isp_v4_1_1_hw_resume(struct amdgpu_isp *isp)
> >> +{
> >> +    int r;
> >> +
> >> +    r =3D device_for_each_child(isp->parent, NULL,
> >> +                  isp_resume_device);
> >> +    if (r)
> >> +        dev_err(isp->parent, "failed to resume hw device (%d)\n", r);
> >> +
> >> +    return 0;
> >
> > Shouldn't you return r?
> >
> >> +}
> >> +
> >>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
> >>   {
> >>       const struct software_node *amd_camera_node, *isp4_node;
> >> @@ -369,6 +426,8 @@ static int isp_v4_1_1_hw_fini(struct amdgpu_isp
> >> *isp)
> >>   static const struct isp_funcs isp_v4_1_1_funcs =3D {
> >>       .hw_init =3D isp_v4_1_1_hw_init,
> >>       .hw_fini =3D isp_v4_1_1_hw_fini,
> >> +    .hw_suspend =3D isp_v4_1_1_hw_suspend,
> >> +    .hw_resume =3D isp_v4_1_1_hw_resume,
> >>   };
> >>     void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp)
> >
