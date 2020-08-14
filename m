Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468F1C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 20:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 128842074D
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 20:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNG1rBBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128842074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6F476EC0A;
	Fri, 14 Aug 2020 20:11:06 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28E906EC0A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 20:11:06 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id a14so9368693wra.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 13:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=e2l0KLL2+Klue2DzWsvhDXmLReiPw+h7OnrGHk/2iHw=;
 b=tNG1rBBiehLhdrPJNTFwm2ID1iwXx7rPQZ/h/r4NL5rrhAuogt4hJmzoDR+GhwFFdK
 UQu3aGoJ2xwzfN63ML+x5FX4Q3z7PndKoW8KHd30LUshKhoq3kn7atov1ucYT8FEYafn
 waYCRG8XnovFL3x336h4JCW/BFin69e11Yk7ZFCBe2oTSDfu6K1d1kyh4th6KMHNuJ/O
 DmCnKxz4eeCrQ0sc4eTP4u8Dj1QXsAJuDSoXwhdDVFBq/yo8lk3S81Oq0E1HJik6SNp+
 mh5g91VjbdqMLB2+s2tzbk2F/IVy0gnbkx/Rzau5//XR5IwgUflpnPd4+n74IWeo8KW+
 NbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=e2l0KLL2+Klue2DzWsvhDXmLReiPw+h7OnrGHk/2iHw=;
 b=U39K0f/2U7jrZMsU1YKlcxX70ZwelFyccWNbvxisIEeBLqBljdKISj+RsRpEhdjDkj
 ntqy6X0rMn0rvuaC61C8bXBwOtAvZtxHLfTflmtmPX3+bsFm2AeCH0iTqJgvmg0Q9mI5
 LmOMuCr3hNK67v7+V36fPV29Hfk2FP0UHvYJ9tQcp0Lkdi8narhBrIFZ2y57RKWeKcgp
 XmRfRBE9gEVlTTZg+cIrjVauBnyR0WHIOXK5lyaw45rcnIWlJPZbMozFjEaQ6IPZFpYT
 fJkdIZn2gs1InaZh5BoNUsvtfkp7XadOIsxy8MyyBnQimtAEVTGC0YY+IeKI5VobwTBz
 tMbQ==
X-Gm-Message-State: AOAM533ty2BJtBzzif1lc7GWWKW1wn9Nkk+BT4BVloVW1Hx665u7Dsys
 ot1q55F/887lNxVpF+SOwj/E9Oj/5duITEDQR4k=
X-Google-Smtp-Source: ABdhPJwIN8z/6J6oGOO1SdFK+XO48RXEATKck7eUfZWulsgcd2Dv3EL5Wis0fpx5iYI3BcN2WIc2+yrX74T4LO/VTT8=
X-Received: by 2002:a5d:6348:: with SMTP id b8mr3992094wrw.362.1597435864596; 
 Fri, 14 Aug 2020 13:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200811133053.71123-1-nirmoy.das@amd.com>
 <1795711a-9261-2cb4-642e-44bc25afc9ce@amd.com>
 <9770d7a3-0d4e-f609-4530-991154ef1a49@amd.com>
 <b6e878c0-bade-77a5-fda7-6be234c2f6b7@amd.com>
 <50cab62a-e8d4-0e0d-438b-b274c09d0972@amd.com>
 <1fb93957-e1c7-779c-953f-c575a0b6c74d@amd.com>
 <f63c9053-e473-2d5a-635a-39c8d8b905c1@amd.com>
 <cd54cb41-9dcb-29a4-2e72-088a89d44e6d@amd.com>
 <3d93f01c-6bd7-edfe-6e02-51687e446d18@amd.com>
In-Reply-To: <3d93f01c-6bd7-edfe-6e02-51687e446d18@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Aug 2020 16:10:53 -0400
Message-ID: <CADnq5_NhPJ8+QsAfzHEha-1i_B0UcgwFA-X0P-NAskUhZzmZPg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] drm/amdgpu: add initial support for pci error
 handler
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Nirmoy <nirmodas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Nirmoy Das <nirmoy.das@amd.com>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 14, 2020 at 3:52 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> On 2020-08-14 11:23 a.m., Nirmoy wrote:
> >
> > On 8/13/20 11:17 PM, Luben Tuikov wrote:
> >> I support having AER handling.
> >>
> >> However, I feel it should be offloaded to the DRM layer.
> >> The PCI driver gets the AER callback and immediately
> >> offloads into DRM, as "return drm_aer_recover(dev); }".
> >> The DRM layer does a top-down approach into the error
> >> recovery procedure.
> >>
> >> The PCI device driver provides (would/should?) a capability
> >> (at registration) which the DRM layer would inspect and
> >> subsequently call into the PCI driver's low-level methods
> >> to recover the error or to reset the device.
> >>
> >> But it should be a top-down approach. I believe the thread
> >> below has somehow hinted at this.
> >>
> >> The implementation below boils down to:
> >>
> >>      If recoverable error, all is good.
> >>      If unrecoverable error, then
> >>              disable power management,
> >>              suspend I/O operations,
> >>              cancel pending work,
> >>              call into PCI driver to clear
> >>                      any state it keeps,
> >>              call into PCI driver to reset display control.
> >>              Etc.
> >>
> >> And this regime could be performed by DRM.
> >>
> >> And as you can see now, the function implemented below,
> >> *calls into* (that's the key here!) DRM, and it should be
> >> the other way around--the DRM should call into the PCI driver,
> >> after the PCI driver's callback immediately calls into DRM,
> >> as outlined above.
> >>
> >> This abstraction could be expanded to more concepts of PCIe GPU drivers,
> >> and it would scale well, beyond PCIe as a protocol for graphics.
> >
> > If drm handles pci error callbacks then it should also handle power
> > management
>
> Yes. LLDDs should have a method for DRM to call to control power
> management. For instance the first thing a DRM unifying layer would
> do is suspend issuing tasks to the LLDD, then recall (pause?) issued tasks,
> do some memory management housekeeping related to the LLDD and then
> invoke power management.
>
> Once DRM is aware of power management it can better control
> memory and task dependencies.
>
> >
> > because power management also calls into drm in very similar way. I
> > think these are very
> >
> > low device level tasks for drm.
>
> I disagree and think that it is not "very low device level tasks".
> Look at the regime posted above. All those directives should/could?
> be known to DRM and LLDDs should have entries for DRM to call
> into.
>
> I see DRM as more of a unifying layer (perhaps long term), as opposed
> to a *library* which LLDDs call into. Then LLDDs would provide an interface
> to the hardware. This will help us avoid many of the deadlocks and
> synchronization issues which were outlined in a recent memory presentation.
> It will also help us avoid code redundancy in LLDDs.

We are actually trying to move away from that model.  drm started out
as a midlayer and it caused all kinds of pain.  E.g., some drm devices
are usb devices, some are pci, some are platform devices, etc.  A flow
that worked for one didn't always work well for another.  In general
we should follow the driver model for the specific device model of
your driver and then use drm helper functions to deal with the core
drm functionality.  E.g., drm shouldn't be in the business of dealing
with pci power management.  The driver should interact directly with
the pci subsystem for that.

Alex

>
> Regards,
> Luben
>
> >
> >
> >>> +static const struct pci_error_handlers amdgpu_err_handler = {
> >> That's too generic a name for this. I'd rather add "pci" in there,
> >>
> >> static const struct pci_error_handlers amdgpu_pci_err_handler =  {
> >
> >
> > True, thanks for the name suggestion.
> >
> >
> > Nirmoy
> >
> >
> >>      .element = init,
> >>      ...
> >> };
> >>
> >> Being a singular noun from the outset is good and this is preserved.
> >>
> >>> +       .error_detected = amdgpu_pci_err_detected,
> >>> +};
> >>> +
> >>> +
> >>>   static struct pci_driver amdgpu_kms_pci_driver = {
> >>>     .name = DRIVER_NAME,
> >>>     .id_table = pciidlist,
> >>> @@ -1523,10 +1576,9 @@ static struct pci_driver amdgpu_kms_pci_driver = {
> >>>     .remove = amdgpu_pci_remove,
> >>>     .shutdown = amdgpu_pci_shutdown,
> >>>     .driver.pm = &amdgpu_pm_ops,
> >>> +   .err_handler = &amdgpu_err_handler,
> >> ".err_handler = amdgpu_pci_err_handler,"
> >>
> >>
> >> Regards,
> >> Luben
> >>
> >> On 2020-08-13 2:18 p.m., Andrey Grodzovsky wrote:
> >>> On 8/13/20 11:06 AM, Nirmoy wrote:
> >>>> On 8/13/20 3:38 PM, Andrey Grodzovsky wrote:
> >>>>> On 8/13/20 7:09 AM, Nirmoy wrote:
> >>>>>> On 8/12/20 4:52 PM, Andrey Grodzovsky wrote:
> >>>>>>> On 8/11/20 9:30 AM, Nirmoy Das wrote:
> >>>>>>>> This patch will ignore non-fatal errors and try to
> >>>>>>>> stop amdgpu's sw stack on fatal errors.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> >>>>>>>> ---
> >>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 56 ++++++++++++++++++++++++-
> >>>>>>>>    1 file changed, 54 insertions(+), 2 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>>>>> index c1219af2e7d6..2b9ede3000ee 100644
> >>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>>>>> @@ -35,6 +35,7 @@
> >>>>>>>>    #include <linux/pm_runtime.h>
> >>>>>>>>    #include <linux/vga_switcheroo.h>
> >>>>>>>>    #include <drm/drm_probe_helper.h>
> >>>>>>>> +#include <drm/drm_atomic_helper.h>
> >>>>>>>>    #include <linux/mmu_notifier.h>
> >>>>>>>>      #include "amdgpu.h"
> >>>>>>>> @@ -1516,6 +1517,58 @@ static struct drm_driver kms_driver = {
> >>>>>>>>        .patchlevel = KMS_DRIVER_PATCHLEVEL,
> >>>>>>>>    };
> >>>>>>>>    +static pci_ers_result_t amdgpu_pci_err_detected(struct pci_dev *pdev,
> >>>>>>>> +                        pci_channel_state_t state)
> >>>>>>>> +{
> >>>>>>>> +    struct drm_device *dev = pci_get_drvdata(pdev);
> >>>>>>>> +    struct amdgpu_device *adev = dev->dev_private;
> >>>>>>>> +    int i;
> >>>>>>>> +    int ret = PCI_ERS_RESULT_DISCONNECT;
> >>>>>>>> +
> >>>>>>>> +    switch (state) {
> >>>>>>>> +    case pci_channel_io_normal:
> >>>>>>>> +        ret = PCI_ERS_RESULT_CAN_RECOVER;
> >>>>>>>> +        break;
> >>>>>>>> +    default:
> >>>>>>>> +        /* Disable power management */
> >>>>>>>> +        adev->runpm = 0;
> >>>>>>>> +        /* Suspend all IO operations */
> >>>>>>>> +        amdgpu_fbdev_set_suspend(adev, 1);
> >>>>>>>> + cancel_delayed_work_sync(&adev->delayed_init_work);
> >>>>>>>> +        for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> >>>>>>>> +            struct amdgpu_ring *ring = adev->rings[i];
> >>>>>>>> +
> >>>>>>>> +            if (!ring || !ring->sched.thread)
> >>>>>>>> +                continue;
> >>>>>>>> +
> >>>>>>>> + amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
> >>>>>>>
> >>>>>>> You need to call drm_sched_stop first before calling this
> >>>>>>>
> >>>>>>>> +        }
> >>>>>>>> +
> >>>>>>>> +        if (adev->mode_info.mode_config_initialized) {
> >>>>>>>> +            if (!amdgpu_device_has_dc_support(adev))
> >>>>>>>> + drm_helper_force_disable_all(adev->ddev);
> >>>>>>>> +            else
> >>>>>>>> + drm_atomic_helper_shutdown(adev->ddev);
> >>>>>>>> +        }
> >>>>>>>> +
> >>>>>>>> +        amdgpu_fence_driver_fini(adev);
> >>>>>>>> +        amdgpu_fbdev_fini(adev);
> >>>>>>>> +        /* Try to close drm device to stop applications
> >>>>>>>> +         * from opening dri files for further IO operations.
> >>>>>>>> +         * TODO: This will throw warning as ttm is not
> >>>>>>>> +         * cleaned perperly */
> >>>>>>>> +        drm_dev_fini(dev);
> >>>>>>>
> >>>>>>> I think user mode applications might still hold reference to the drm device
> >>>>>>> through through drm_dev_get either by directly opening
> >>>>>>> the device file or indirectly through importing DMA buff, if so when the
> >>>>>>> last of them terminate drm_dev_put->drm_dev_release->...->drm_dev_fini
> >>>>>>> might get called again causing use after free e.t.c issues. Maybe better to
> >>>>>>> call here drm_dev_put then and so drm_dev_fini will get called when this
> >>>>>>> last user client releases his reference.
> >>>>>>
> >>>>>> drm_dev_fini() seems to be cleaner. Problem is  window manager(sway) never
> >>>>>> gets terminated after the AER error and drm files remains active. Simple cat
> >>>>>> on dri files
> >>>>>>
> >>>>>> goes though amdgpu and spits out more errors.
> >>>>>
> >>>>> What happens if you kill the window manager after you closed drm device with
> >>>>> your original code applied ? I would expect drm_dev_fini to be called again
> >>>>> for the reason i explained above and this would obviously would be wrong to
> >>>>> happen.
> >>>> Hi Andrey,
> >>>>
> >>>>
> >>>> hmm I quickly tried that, Kernel crashed and later rebooted after sometime. I
> >>>> don't have a serial console to check logs and there was no logs afterwards in
> >>>> journalctl.
> >>>>
> >>>> drm_dev_put() had similar behavior, kernel/machine was inaccessible over ssh.
> >>>>
> >>>>
> >>>> Did you face same behavior while testing gpu hotplug ?
> >>>>
> >>>>
> >>>> Nirmoy
> >>>
> >>> Yea, in my case device sysfs structure was removed on pci_remove while when last
> >>> user client dropped reference and this led
> >>> to drm_dev_fini to be called there were more sysfs entries removal there which
> >>> lead to a crash. But here i don't think the sysfs for drm_device
> >>> is removed because the device is not extracted...
> >>>
> >>> Andrey
> >>>
> >>>
> >>>>
> >>>>> Andrey
> >>>>>
> >>>>>
> >>>>>>
> >>>>>>> Also a general question - in my work on DPC recovery feature which tries to
> >>>>>>> recover after PCIe error - once the PCI error has happened MMIO registers
> >>>>>>> become
> >>>>>>> unaccessible for r/w as the PCI link is dead until after the PCI link is
> >>>>>>> reset by the DPC driver (see
> >>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2Fhtml%2Flatest%2FPCI%2Fpci-error-recovery.html&amp;data=02%7C01%7Cluben.tuikov%40amd.com%7C4490887b817b47b029a808d83fb5525f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637329395327201326&amp;sdata=ukcNKOfdzIo7CdKr0yq78vLgqKkzHtqa%2FangK7OEYsA%3D&amp;reserved=0 section
> >>>>>>> 6.1.4).
> >>>>>>> Your case is to try and gracefully to close the drm device once fatal error
> >>>>>>> happened, didn't you encounter errors or warnings when accessing HW
> >>>>>>> registers during any of the operations
> >>>>>>> above ?
> >>>>>>
> >>>>>> As discussed over chat, it seems aer generated with aer-inject tool just
> >>>>>> triggers kernel PCI error APIs but the device is still active so I didn't
> >>>>>> encounter any errors when accessing HW registers.
> >>>>>>
> >>>>>>
> >>>>>> Nirmoy
> >>>>>>
> >>>>>>
> >>>>>>> Andrey
> >>>>>>>
> >>>>>>>
> >>>>>>>> +        break;
> >>>>>>>> +    }
> >>>>>>>> +
> >>>>>>>> +    return ret;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static const struct pci_error_handlers amdgpu_err_handler = {
> >>>>>>>> +       .error_detected = amdgpu_pci_err_detected,
> >>>>>>>> +};
> >>>>>>>> +
> >>>>>>>> +
> >>>>>>>>    static struct pci_driver amdgpu_kms_pci_driver = {
> >>>>>>>>        .name = DRIVER_NAME,
> >>>>>>>>        .id_table = pciidlist,
> >>>>>>>> @@ -1523,10 +1576,9 @@ static struct pci_driver amdgpu_kms_pci_driver = {
> >>>>>>>>        .remove = amdgpu_pci_remove,
> >>>>>>>>        .shutdown = amdgpu_pci_shutdown,
> >>>>>>>>        .driver.pm = &amdgpu_pm_ops,
> >>>>>>>> +    .err_handler = &amdgpu_err_handler,
> >>>>>>>>    };
> >>>>>>>>    -
> >>>>>>>> -
> >>>>>>>>    static int __init amdgpu_init(void)
> >>>>>>>>    {
> >>>>>>>>        int r;
> >>> _______________________________________________
> >>> amd-gfx mailing list
> >>> amd-gfx@lists.freedesktop.org
> >>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cluben.tuikov%40amd.com%7C4490887b817b47b029a808d83fb5525f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637329395327201326&amp;sdata=hUiqeBUx%2BhXqgL21ewNbPBP0WQp1i66av5CDeg9CF38%3D&amp;reserved=0
> >>>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
