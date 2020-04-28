Return-Path: <SRS0=QpD2=6M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B36C83000
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 15:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4EEC20746
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 15:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tPPofvih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4EEC20746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BED46E833;
	Tue, 28 Apr 2020 15:30:49 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C4F76E836
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2020 15:30:47 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id g13so25145616wrb.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2020 08:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O/Yf26uY8sBP02BnMywEDTj+Um3+Ik9/D/QFCV2E0kg=;
 b=tPPofvihYwJVm1Rcbem7re6mXGch5uRxeLvmeTbrCQ03T3nJd2+aG+9w8ZRHaY5aQP
 CYI4bbXlY9HNGXxgK1driFzRcfBqyZ7qp12XaLdTlcsXt9LSDaNE75rrrDyUpLHzAffo
 QFNdLDhU3D6m+6EyPMuom5ibOR97tz2AVLBADbvDdm7Vk8ijggzKNuA+ir45B7hOKFqi
 +IO3KAIy2gX2cKw4CMhy4XVam02JsAGlvxFSOGCe67k6kr9tDnY4l7NcUVn1xOt0hdiE
 4R0Pw1OzKLsS33C0RCUVI1j6J5v2Hu7isc1OMYe6DOd83x/TpZFphfDU7FAyBmyR5pZQ
 aORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O/Yf26uY8sBP02BnMywEDTj+Um3+Ik9/D/QFCV2E0kg=;
 b=ui06EOTwBrky39stW5s9pQKrODOiMyfetgJ/VOYarcd0zIeYwZ1qJosyGIUImzH9h6
 SouRNAiDf2SkkoE9boukzG9WNoYNc+cTlKZhGQsQrV1iPZQqNfomKQ1w0dyoU46RW8Fu
 P/cNOACBmKC80fs7e6oe7MKwiLZdl0F/w8qeWTARqRtxNzk1gI7MHUUxitM7LsGHa/eI
 A/WQJLGyzZ7W8ZvktI8rjXTbn8AhqAQUXEXyEyI53n6ZMPDdKqjSTwHmhwDkPJRuZpwu
 eFmWZGqFz/elBuWh+we6L0KCYgizmMoFg/i25MIaUkc7i1lPFcVox7XtUAxZcJBoJ+OV
 PHMw==
X-Gm-Message-State: AGi0PuaveFiTVAZXJkcJ0VesBRDF6sUjLHTanvu9NiJytz1J2wTaZNMz
 TniS7J4c23kvJBrrUbKOi/lEIddR2NwTBCv3NWZUCw==
X-Google-Smtp-Source: APiQypJyjPWEGK8HlLXtbID/3Hi5Lxsm4H6nEC3aXVIZBiOwyked0+3apRnShEFVe9ADrKZi/pd5/4U9thGb3J31n+c=
X-Received: by 2002:a5d:5352:: with SMTP id t18mr33395688wrv.111.1588087846173; 
 Tue, 28 Apr 2020 08:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200422024221.16914-1-evan.quan@amd.com>
 <CADnq5_O8bNkDnUYYn=nAOOq+0qZUMgZgM2ZeCE4BWA2NWQ_Fdg@mail.gmail.com>
 <DM6PR12MB26194747FAC0B96B60CF285CE4AC0@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26194747FAC0B96B60CF285CE4AC0@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Apr 2020 11:30:34 -0400
Message-ID: <CADnq5_Nv_9d3r7KpjaxSPue1jbyAgc=A6uQAxoQKVXGLxCuCJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: put the audio codec into suspend state before
 gpu reset V2
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 28, 2020 at 12:08 AM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> Hi Alex,
>
> The pm_runtime_autosuspend_expiration() return 0 due to ->use_autosuspend and autosuspend_delay are all zeros.
> This seems not kernel specific. As I can see this on 5.6-drm-next kernel and ubuntu original 5.3.46 kernel.
> Any insights why that happened?
> And maybe a compromise is: try the pm_runtime_autosuspend_expiration() first. And if failed(report 0), use a fixed interval(3S).

Seems fine.

Alex

>
> Regards,
> Evan
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, April 22, 2020 9:35 PM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: put the audio codec into suspend state before gpu reset V2
>
> On Tue, Apr 21, 2020 at 10:42 PM Evan Quan <evan.quan@amd.com> wrote:
> >
> > At default, the autosuspend delay of audio controller is 3S. If the
> > gpu reset is triggered within 3S(after audio controller idle), the
> > audio controller may be unable into suspended state. Then the sudden
> > gpu reset will cause some audio errors. The change here is targeted to
> > resolve this.
> >
> > However if the audio controller is in use when the gpu reset
> > triggered, this change may be still not enough to put the audio
> > controller into suspend state. Under this case, the gpu reset will
> > still proceed but there will be a warning message printed("failed to
> > suspend display audio").
> >
> > V2: limit this for BACO and mode1 reset only
> >
> > Change-Id: I33d85e6fcad1882eb33f9cde8916d57be8d5a87a
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 70
> > ++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 2d4b78d96426..70f43b1aed78 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -69,6 +69,7 @@
> >
> >  #include <linux/suspend.h>
> >  #include <drm/task_barrier.h>
> > +#include <linux/pm_runtime.h>
> >
> >  MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
> >  MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
> > @@ -4146,6 +4147,59 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
> >         mutex_unlock(&adev->lock_reset);  }
> >
> > +static void amdgpu_device_resume_display_audio(struct amdgpu_device
> > +*adev) {
> > +       struct pci_dev *p = NULL;
> > +
> > +       p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
> > +                       adev->pdev->bus->number, 1);
> > +       if (p) {
> > +               pm_runtime_enable(&(p->dev));
> > +               pm_runtime_resume(&(p->dev));
> > +       }
> > +}
> > +
> > +static int amdgpu_device_suspend_display_audio(struct amdgpu_device
> > +*adev) {
> > +       enum amd_reset_method reset_method;
> > +       struct pci_dev *p = NULL;
> > +       unsigned long end_jiffies;
> > +
> > +       /*
> > +        * For now, only BACO and mode1 reset are confirmed
> > +        * to suffer the audio issue without proper suspended.
> > +        */
> > +       reset_method = amdgpu_asic_reset_method(adev);
> > +       if ((reset_method != AMD_RESET_METHOD_BACO) &&
> > +            (reset_method != AMD_RESET_METHOD_MODE1))
> > +               return -EINVAL;
> > +
> > +       p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
> > +                       adev->pdev->bus->number, 1);
> > +       if (!p)
> > +               return -ENODEV;
> > +
> > +       /*
> > +        * 3S is the audio controller default autosuspend delay setting.
> > +        * 4S used here is guaranteed to cover that.
> > +        */
>
> Instead of hardcoding 3S, we should probably use
> pm_runtime_autosuspend_expiration() to query how much time is left and then use that.  That way this will work even if userspace has changed the delay.  With that fixed:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> Alex
>
>
> > +       end_jiffies = msecs_to_jiffies(4000) + jiffies;
> > +       while (!pm_runtime_status_suspended(&(p->dev))) {
> > +               if (!pm_runtime_suspend(&(p->dev)))
> > +                       break;
> > +
> > +               if (time_after(jiffies, end_jiffies)) {
> > +                       dev_warn(adev->dev, "failed to suspend display audio\n");
> > +                       /* TODO: abort the succeeding gpu reset? */
> > +                       return -ETIMEDOUT;
> > +               }
> > +       }
> > +
> > +       pm_runtime_disable(&(p->dev));
> > +
> > +       return 0;
> > +}
> > +
> >  /**
> >   * amdgpu_device_gpu_recover - reset the asic and recover scheduler
> >   *
> > @@ -4170,6 +4224,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
> >         bool use_baco =
> >                 (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ?
> >                 true : false;
> > +       bool audio_suspended = false;
> >
> >         /*
> >          * Flush RAM to disk so that after reboot @@ -4227,6 +4282,19
> > @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
> >                         return 0;
> >                 }
> >
> > +               /*
> > +                * Try to put the audio codec into suspend state
> > +                * before gpu reset started.
> > +                *
> > +                * Due to the power domain of the graphics device
> > +                * is shared with AZ power domain. Without this,
> > +                * we may change the audio hardware from behind
> > +                * the audio driver's back. That will trigger
> > +                * some audio codec errors.
> > +                */
> > +               if (!amdgpu_device_suspend_display_audio(tmp_adev))
> > +                       audio_suspended = true;
> > +
> >                 amdgpu_ras_set_error_query_ready(tmp_adev, false);
> >
> >
> > cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
> > @@ -4339,6 +4407,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
> >                 /*unlock kfd: SRIOV would do it separately */
> >                 if (!(in_ras_intr && !use_baco) && !amdgpu_sriov_vf(tmp_adev))
> >                         amdgpu_amdkfd_post_reset(tmp_adev);
> > +               if (audio_suspended)
> > +                       amdgpu_device_resume_display_audio(tmp_adev);
> >                 amdgpu_device_unlock_adev(tmp_adev);
> >         }
> >
> > --
> > 2.26.2
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cev
> > an.quan%40amd.com%7Cf459a830629f4738329808d7e6c201e4%7C3dd8961fe4884e6
> > 08e11a82d994e183d%7C0%7C0%7C637231593241762358&amp;sdata=0EEfJPHc%2BEF
> > K9Ukvzo20h4K4lL%2F%2FcUOvH0AdYDsha08%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
