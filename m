Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610CDC2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 18:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B67010E947;
	Thu, 15 May 2025 18:06:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I5MxWjwo";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B193E10E947
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 18:06:38 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-22e19c71070so2030965ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 11:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747332398; x=1747937198; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c0k5n/xzNUmn4yzXb2NlVd/3ie7WZFn/R6GKBvpiRMk=;
 b=I5MxWjwopLPtvIDSBU5qaqMW3jSATdmOSnDmURyXY4NeSEunB31e0+L/A0kci7ke95
 zaUitjeX2F2LEGO8W403bal3lTd6LFjDQaS03KkmLdsF7UJGRCEEj/weQu1Ai/nEto1M
 S+Nr2gtZixTQDr0gTiyCYOqN5ESormIjVDG5wJqI/7efVhV1V5avopQTzZUtoXnp4LWS
 ySojZXcwPXH0Fxsq3+zz4S09wr+WpVx3r/GwA0h7M9MFDAAP49T6WB2kulvDpy9OWC1M
 0E4v0Rkn6AIEfUXVugNRAfSU6Rs+g/2G/OIUJC+fsvXB/TU22CJh8v9E/dVT4JmsX8vF
 o8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747332398; x=1747937198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c0k5n/xzNUmn4yzXb2NlVd/3ie7WZFn/R6GKBvpiRMk=;
 b=McWu89c0/stKeR3p92+JddX2N6ovowNeW2wjxldZIQfGe/rqo2LkN8CrdlEYhmqYeJ
 BEx82tGRZb0UW9XLfFpjH8wfIU9frs0DaeN3z0SX0uMYV2aRm0F83y3q/VfV652M671d
 Z8+CVRUZ5M7hclOWARw3sWBaIGSDBwC9fuMqVr5BLQlLlpxtFrwXav+Z8m6u6lZTpfzJ
 t62hX13A3TOxQ7lxPIwLY4W84F+B+WA+ELKsAoRo5rsXi/bhr9f9w1FaJOyrK6ZIXT73
 WVXPx4qeayf4MIrhmLSsuu9tpbiEt7nKgCPoWQN4zwBIHVUXaAX6RjIxcHmLFQwiPM+9
 hX9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9+FIbfyMoHMG2H9fAEq1gX6AIKVLQo4WBNZWbDWCzTq1I5nJ2LOyF2b+pNIH0xfw9WJiGergS@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHi1h6ArIxVp+kn3vKZGyxjDXT30F15MvootwVfc+LySJbPZpm
 f1Yn2BxjZt3MFg1sPSHeHhVOPk9lCEWDc/8foP8HTzZ0Mj2cyH05+rfdP+Q7TJ4E9Ebn1p4rTcm
 zIWpk59ONW9MNwaqxS0K3noJ4Ni7O+XI=
X-Gm-Gg: ASbGncscTqURhpOZt9I0E+ANcDzp8tba9kqgO3ANE9uNx8np4lIENGPXnZDNRxdEOgi
 N9sJR2W5y4q26y9xLv9uUBdzmrkejn6/CsOJJleqHyjDb9f1koB41RY6hjarRt0SUasPRDWbTr5
 DUsFjbro32oUMmTtX6/8WrwPckH9v9EWxPxA==
X-Google-Smtp-Source: AGHT+IEPYyqgyjEoPgiQyEtGx/a3TfQasjRShhbVpNiKnyH72KfsYIEU59X132QC4IsGi9P+RK4Ocehc911/oHoBWbs=
X-Received: by 2002:a17:902:ce8f:b0:22e:61b1:fea1 with SMTP id
 d9443c01a7336-231d455beb8mr1741185ad.14.1747332397924; Thu, 15 May 2025
 11:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250514213721.519943-1-pratap.nirujogi@amd.com>
 <f2d33475-53e8-43ec-9095-95081e480989@amd.com>
 <6088b764-cf5b-4c21-be95-4695730456e3@amd.com>
 <9fb6bd11-4855-404b-af11-004a7b2bf65a@amd.com>
In-Reply-To: <9fb6bd11-4855-404b-af11-004a7b2bf65a@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 May 2025 14:06:26 -0400
X-Gm-Features: AX0GCFtWGnnrocxz7K83zHlTK3yKc4jj4XN9TeJumFLagvuXBRMDPzgtEeH8cvY
Message-ID: <CADnq5_NrqF2ZDuN=kf-VT-zWC_9vAdcr-3cwnC3D1_WW3mdWUg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add GPIO resources required for amdisp
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Nirujogi, Pratap" <pnirujog@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, 
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, mlimonci@amd.com, benjamin.chan@amd.com, 
 bin.du@amd.com, gjorgji.rosikopulos@amd.com, king.li@amd.com, dantony@amd.com
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

On Thu, May 15, 2025 at 2:03=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 5/15/2025 12:47 PM, Nirujogi, Pratap wrote:
> > Hi Mario,
> >
> > On 5/14/2025 6:05 PM, Mario Limonciello wrote:
> >> On 5/14/2025 4:35 PM, Pratap Nirujogi wrote:
> >>> ISP is a child device to GFX, and its device specific information
> >>> is not available in ACPI. Adding the 2 GPIO resources required for
> >>> ISP_v4_1_1 in amdgpu_isp driver.
> >>>
> >>> - GPIO 0 to allow sensor driver to enable and disable sensor module.
> >>> - GPIO 85 to allow ISP driver to enable and disable ISP RGB streaming
> >>> mode.
> >>>
> >>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 46 ++++++++++++++++++++++=
+++
> >>>   1 file changed, 46 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/
> >>> drm/amd/amdgpu/isp_v4_1_1.c
> >>> index 69dd92f6e86d..c488af6c8013 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> >>> @@ -25,6 +25,7 @@
> >>>    *
> >>>    */
> >>> +#include <linux/gpio/machine.h>
> >>>   #include "amdgpu.h"
> >>>   #include "isp_v4_1_1.h"
> >>> @@ -39,15 +40,60 @@ static const unsigned int
> >>> isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] =3D {
> >>>       ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16
> >>>   };
> >>> +static struct gpiod_lookup_table isp_gpio_table =3D {
> >>> +    .dev_id =3D "amd_isp_capture",
> >>> +    .table =3D {
> >>> +        GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp", GPIO_ACTIVE_HIG=
H),
> >>> +        { }
> >>> +    },
> >>> +};
> >>> +
> >>> +static struct gpiod_lookup_table isp_sensor_gpio_table =3D {
> >>> +    .dev_id =3D "i2c-ov05c10",
> >>> +    .table =3D {
> >>> +        GPIO_LOOKUP("amdisp-pinctrl", 0, "enable", GPIO_ACTIVE_HIGH)=
,
> >>> +        { }
> >>> +    },
> >>> +};
> >>> +
> >>> +static const struct acpi_device_id isp_sensor_ids[] =3D {
> >>> +    { "OMNI5C10" },
> >>> +    { }
> >>> +};
> >>> +
> >>> +static int isp_match_acpi_device_ids(struct device *dev, const void
> >>> *data)
> >>> +{
> >>> +    return acpi_match_device(data, dev) ? 1 : 0;
> >>> +}
> >>> +
> >>>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
> >>>   {
> >>>       struct amdgpu_device *adev =3D isp->adev;
> >>> +    struct acpi_device *acpi_pdev;
> >>>       int idx, int_idx, num_res, r;
> >>> +    struct device *pdev;
> >>>       u64 isp_base;
> >>>       if (adev->rmmio_size =3D=3D 0 || adev->rmmio_size < 0x5289)
> >>>           return -EINVAL;
> >>> +    pdev =3D bus_find_device(&platform_bus_type, NULL, isp_sensor_id=
s,
> >>> +                   isp_match_acpi_device_ids);
> >>> +    if (!pdev) {
> >>> +        drm_dbg(&adev->ddev, "Invalid isp platform detected:%ld",
> >>> +            PTR_ERR(pdev));
> >>> +        /* allow GPU init to progress */
> >>> +        return 0;
> >>> +    }
> >>> +    acpi_pdev =3D ACPI_COMPANION(pdev);
> >>> +
> >>> +    /* add GPIO resources required for OMNI5C10 sensor */
> >>> +    if (!strcmp("OMNI5C10", acpi_device_hid(acpi_pdev))) {
> >>> +        gpiod_add_lookup_table(&isp_gpio_table);
> >>> +        gpiod_add_lookup_table(&isp_sensor_gpio_table);
> >>> +    }
> >>> +    put_device(pdev);
> >>> +
> >>
> >> Can you please move this into a helper in amdgpu_acpi.c?  We try not
> >> to have ACPI code outside of there in case someone compiles without
> >> CONFIG_ACPI.
> >>
> >> Sorry I should have mentioned this sooner.
> >>
> > sure, I will add "int amdgpu_acpi_get_isp4_dev_hid(char **hid)", which
> > takes care of:
> >
> > 1. finding the matching isp4 platform device(pdev) using bus_find_devic=
e()
> > 2. gets acpi device handle(acpi_pdev) for the matching pdev and returns
> > valid hid incase of no failures.
> >
> > Is this approach okay? hope this function signature makes sense. Please
> > let me know if any comments or suggestions on this approach.
> >
> > Thanks,
> > Pratap
>
> I think this approach is fine, but it would be good to get Alex's
> comments on this.

Seems fine to me.

Alex

>
> >
> >>>       isp_base =3D adev->rmmio_base;
> >>>       isp->isp_cell =3D kcalloc(3, sizeof(struct mfd_cell), GFP_KERNE=
L);
> >>
> >
>
