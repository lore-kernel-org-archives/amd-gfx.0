Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20323C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 13:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEFF52078D
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 13:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWvNL0RQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFF52078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 888F46E1BA;
	Thu, 13 Aug 2020 13:37:06 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B836A6E1BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 13:37:05 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id g8so4714061wmk.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 06:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IXmCxvphoYLdyHg7iWxKWx368rgdlVTSE9KU4CgrToc=;
 b=mWvNL0RQIevJgTv3PPyaTMMKRhA3V+lU6rpBSkoi5OqHP+5GHmebPeITM8IMKCEtCM
 VT01JijFayXu5Wr19QctV6sF0vqodg3TNzmhHEWdG1t/akyPj4XCFNCHff/f2C0P7LDI
 Dv7QUc00LDDW9I6qGlnSol8Lz6e8TO2R43KsWjLm4miJ3UdZRUbS8KwtuAPUCpiW6dA/
 HLPI7hzhkar/1Aq8lWS5KsyM3gVXTSCCGb9ljBvqcHFzi7ZKJ8YBdNvZ/AIAMUIhwyim
 MgyVGmz8oqnAzzkbas+PQBj5WO5y7fzqepHPTI346Vy1QxAwFIiWzbO7p9EjNQivv6O4
 IiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IXmCxvphoYLdyHg7iWxKWx368rgdlVTSE9KU4CgrToc=;
 b=uJXL8QGfanBC2FNNxbkAjvjcGyj0fPQtvn6netDovQBw5PgoPgI1eIL4w+c+g4SAwy
 aebmG2m6R02WSAOqjs4KsmOvVcPKqqjQqw+wO9us3u3fvFQ5sLk0F+fYqT6h8XkVlGH/
 qFl0TmreR1g2yXs08kxCTxDdehfvhxkwYpuW/+wqz3+U1BB9j+D5Q6Slu1Fff8NFxa3q
 g2DKBUnaPW0Vk+Xk7hJ6mR5HrE4bdM+AGcsuEnxBuFEr4ZCEExWQRbEOhqKaWlZeQyUe
 ZmAIAfxGI3bRPIeBQzDtu6K6EtEjw3Iw/dHZdMDBRGvQTM6BPJUQBWq7JVTMG/vpjXdl
 10yw==
X-Gm-Message-State: AOAM533FN1FnnCrLXXWv4S6HnMWnq5V3nGkxOaqezKIurGIDUmAlzZxs
 vov4xok+d1tFlgaWDQEI1EeMUARdH41H3p2kEXY=
X-Google-Smtp-Source: ABdhPJw66NjbDw2OU3s+5hph+DAJTsYIrwpPb18tjeffiZmy9Jliu9ebIAiGke8N0HlDY6w1QJFOjKy/Cp1+V7mZJx4=
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr4414174wmh.39.1597325824359; 
 Thu, 13 Aug 2020 06:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200811133053.71123-1-nirmoy.das@amd.com>
 <1795711a-9261-2cb4-642e-44bc25afc9ce@amd.com>
 <9770d7a3-0d4e-f609-4530-991154ef1a49@amd.com>
In-Reply-To: <9770d7a3-0d4e-f609-4530-991154ef1a49@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Aug 2020 09:36:53 -0400
Message-ID: <CADnq5_OKWs+8T0bdvnAArzNpJDax+zV2RrqZCdHx0gsWqqJo5w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] drm/amdgpu: add initial support for pci error
 handler
To: Nirmoy <nirmodas@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 13, 2020 at 7:06 AM Nirmoy <nirmodas@amd.com> wrote:
>
>
> On 8/12/20 4:52 PM, Andrey Grodzovsky wrote:
> >
> > On 8/11/20 9:30 AM, Nirmoy Das wrote:
> >> This patch will ignore non-fatal errors and try to
> >> stop amdgpu's sw stack on fatal errors.
> >>
> >> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 56 ++++++++++++++++++++++++-
> >>   1 file changed, 54 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> index c1219af2e7d6..2b9ede3000ee 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> @@ -35,6 +35,7 @@
> >>   #include <linux/pm_runtime.h>
> >>   #include <linux/vga_switcheroo.h>
> >>   #include <drm/drm_probe_helper.h>
> >> +#include <drm/drm_atomic_helper.h>
> >>   #include <linux/mmu_notifier.h>
> >>     #include "amdgpu.h"
> >> @@ -1516,6 +1517,58 @@ static struct drm_driver kms_driver = {
> >>       .patchlevel = KMS_DRIVER_PATCHLEVEL,
> >>   };
> >>   +static pci_ers_result_t amdgpu_pci_err_detected(struct pci_dev *pdev,
> >> +                        pci_channel_state_t state)
> >> +{
> >> +    struct drm_device *dev = pci_get_drvdata(pdev);
> >> +    struct amdgpu_device *adev = dev->dev_private;
> >> +    int i;
> >> +    int ret = PCI_ERS_RESULT_DISCONNECT;
> >> +
> >> +    switch (state) {
> >> +    case pci_channel_io_normal:
> >> +        ret = PCI_ERS_RESULT_CAN_RECOVER;
> >> +        break;
> >> +    default:
> >> +        /* Disable power management */
> >> +        adev->runpm = 0;
> >> +        /* Suspend all IO operations */
> >> +        amdgpu_fbdev_set_suspend(adev, 1);
> >> + cancel_delayed_work_sync(&adev->delayed_init_work);
> >> +        for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> >> +            struct amdgpu_ring *ring = adev->rings[i];
> >> +
> >> +            if (!ring || !ring->sched.thread)
> >> +                continue;
> >> +
> >> + amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
> >
> >
> > You need to call drm_sched_stop first before calling this
> >
> >> +        }
> >> +
> >> +        if (adev->mode_info.mode_config_initialized) {
> >> +            if (!amdgpu_device_has_dc_support(adev))
> >> +                drm_helper_force_disable_all(adev->ddev);
> >> +            else
> >> +                drm_atomic_helper_shutdown(adev->ddev);
> >> +        }
> >> +
> >> +        amdgpu_fence_driver_fini(adev);
> >> +        amdgpu_fbdev_fini(adev);
> >> +        /* Try to close drm device to stop applications
> >> +         * from opening dri files for further IO operations.
> >> +         * TODO: This will throw warning as ttm is not
> >> +         * cleaned perperly */
> >> +        drm_dev_fini(dev);
> >
> >
> > I think user mode applications might still hold reference to the drm
> > device through through drm_dev_get either by directly opening
> > the device file or indirectly through importing DMA buff, if so when
> > the last of them terminate
> > drm_dev_put->drm_dev_release->...->drm_dev_fini
> > might get called again causing use after free e.t.c issues. Maybe
> > better to call here drm_dev_put then and so drm_dev_fini will get
> > called when this
> > last user client releases his reference.
>
>
> drm_dev_fini() seems to be cleaner. Problem is  window manager(sway)
> never gets terminated after the AER error and drm files remains active.
> Simple cat on dri files
>
> goes though amdgpu and spits out more errors.
>
>
> >
> > Also a general question - in my work on DPC recovery feature which
> > tries to recover after PCIe error - once the PCI error has happened
> > MMIO registers become
> > unaccessible for r/w as the PCI link is dead until after the PCI link
> > is reset by the DPC driver (see
> > https://www.kernel.org/doc/html/latest/PCI/pci-error-recovery.html
> > section 6.1.4).
> > Your case is to try and gracefully to close the drm device once fatal
> > error happened, didn't you encounter errors or warnings when accessing
> > HW registers during any of the operations
> > above ?
>
>
> As discussed over chat, it seems aer generated with aer-inject tool just
> triggers kernel PCI error APIs but the device is still active so I
> didn't encounter any errors when accessing HW registers.

I think DPC is special because it triggers a special hardware mode
which resets the device.  Most other PCI errors do not.

Alex


>
>
> Nirmoy
>
>
> >
> > Andrey
> >
> >
> >> +        break;
> >> +    }
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static const struct pci_error_handlers amdgpu_err_handler = {
> >> +       .error_detected = amdgpu_pci_err_detected,
> >> +};
> >> +
> >> +
> >>   static struct pci_driver amdgpu_kms_pci_driver = {
> >>       .name = DRIVER_NAME,
> >>       .id_table = pciidlist,
> >> @@ -1523,10 +1576,9 @@ static struct pci_driver amdgpu_kms_pci_driver
> >> = {
> >>       .remove = amdgpu_pci_remove,
> >>       .shutdown = amdgpu_pci_shutdown,
> >>       .driver.pm = &amdgpu_pm_ops,
> >> +    .err_handler = &amdgpu_err_handler,
> >>   };
> >>   -
> >> -
> >>   static int __init amdgpu_init(void)
> >>   {
> >>       int r;
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
