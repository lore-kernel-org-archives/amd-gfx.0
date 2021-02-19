Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0DAC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 03:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CDAF64ED9
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 03:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDAF64ED9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC1D6EA91;
	Fri, 19 Feb 2021 03:53:57 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1448E6EA27
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 03:53:57 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id s3so802475otg.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Feb 2021 19:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2QX5X7QVheVvvurQ/O5R8WtknuCyPHg+pvYdLT9stTk=;
 b=prPZf6WwY0D/cieUkkqekAP1W9hVOuyLokIe/B8YxT7qMBYj00zcMm+bdSlct34lYL
 Wslck8r9G1vIfrL533FXwaT9Q4lclEazAw/5YLmC/o86JJddoDcCZHmN5dVRlOZMcNFe
 QFuuR+mIDU0rMhZNq7LNuAH4FI58HpqNMcHWK1lAPK86//iTw2TjF9KbfVeRxOSuOEaM
 buhDzRolgyNzPOTrdq1v9AUQoGVcSYZeD8b6LcjIoSCw5gw81d0olBvnX1B/mjhGzUAY
 bERyCR2dF252OrubWPRJx6qRJHpV4iYGuiT+5Cjt8fcWlV/0Cwvpaq4S5/Wh/xForccT
 N2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2QX5X7QVheVvvurQ/O5R8WtknuCyPHg+pvYdLT9stTk=;
 b=g9ajWT/QojxVIwc6pvxzIZ17LWGXLvaUoPj9+j/YGtTuDQW+I9sLHCmruc98XcVcTh
 KYaFmf98XofGTgRIn89/9/swRmEv1v0IfFiu0FiQB2HXlPHxT5SgTFKH5765vDIzWsT6
 kMUND6Ca/JSrOBdob9mvJXQWLrY+572WMfUqRLnPYTD+blh5PgmBoMkpLvfAtQxcH+vc
 G3TPNqwaYOF+M0f8L02MvfJPJLvm8IKVJMpWn9+ifbt8Y7WoEoCCYF4M/xrQXe1nUbQO
 Nd5OJOfb1zno8qAqX+icCtGdxZ0Nqes+yFIDXpkIrN+1GODzOYplweZI8cH92rZ0OaPF
 ZwSw==
X-Gm-Message-State: AOAM533WZ2XxH0aQvqQ0Bln9vKoEr8v5nb1ChGIbYD5lUbOBKwtzKVzo
 pOllQA9nDWgoJ2qDdJkilvRzGZM9HJhlpHHZwKA=
X-Google-Smtp-Source: ABdhPJxE2AoYVHhXVMkXVXyFRGLcaJ8djEHeX7MSiCVL0hMpMEYN1Cv+W/x/8aA5XYa/LNB3uAfbmny/l29wQQddhOg=
X-Received: by 2002:a9d:12f2:: with SMTP id g105mr5807308otg.132.1613706836402; 
 Thu, 18 Feb 2021 19:53:56 -0800 (PST)
MIME-Version: 1.0
References: <20210218171054.3039369-1-alexander.deucher@amd.com>
 <BYAPR12MB3238E2E495055E7D37EFD284FB849@BYAPR12MB3238.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB3238E2E495055E7D37EFD284FB849@BYAPR12MB3238.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Feb 2021 22:53:45 -0500
Message-ID: <CADnq5_MF2vZ3G_99REz71HmibfXGwTg5+fw8Tv-GqPrf0jY9pg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix shutdown with s0ix
To: "Liang, Prike" <Prike.Liang@amd.com>
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
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 18, 2021 at 7:57 PM Liang, Prike <Prike.Liang@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Thanks Alex fix, I also have drafted the fix locally for the poweroff and shutdown on the s0ix enablement.
> Besides the shutdown opt fix for the reboot process and we also need a similarity for the poweroff opt.
>
> So how about create a new combination flag for legacy PM poweroff() and shutdown() opt?

Sure.

Alex

>
> Thanks,
> Prike
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Friday, February 19, 2021 1:11 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> > <Prike.Liang@amd.com>
> > Subject: [PATCH] drm/amdgpu: fix shutdown with s0ix
> >
> > For shutdown needs to be handled differently and s0ix.  Add a new flag to
> > shutdown and use it to adjust behavior appropriately.
> >
> > Bug:
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitla
> > b.freedesktop.org%2Fdrm%2Famd%2F-
> > %2Fissues%2F1499&amp;data=04%7C01%7CPrike.Liang%40amd.com%7C247
> > 59f57e2644f26deaf08d8d4302cc3%7C3dd8961fe4884e608e11a82d994e183d
> > %7C0%7C0%7C637492650673813454%7CUnknown%7CTWFpbGZsb3d8eyJWI
> > joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1
> > 000&amp;sdata=I0rH%2FFt2cs%2BdNwvNdqWKPE%2B3bOosUyBodViUsEwb
> > 6tE%3D&amp;reserved=0
> > Fixes: 628c36d7b238e2 ("drm/amdgpu: update amdgpu device
> > suspend/resume sequence for s0i3 support")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 2 ++
> >  3 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index da258331e86b..7f5500d8e8f4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1018,6 +1018,7 @@ struct amdgpu_device {
> >  /* s3/s4 mask */
> >  bool                            in_suspend;
> >  boolin_hibernate;
> > +boolin_shutdown;
> >
> >  atomic_t in_gpu_reset;
> >  enum pp_mp1_state               mp1_state;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 7052dc35d278..ecd0201050ac 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2678,7 +2678,8 @@ static int
> > amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)  {
> >  int i, r;
> >
> > -if (!amdgpu_acpi_is_s0ix_supported(adev) ||
> > amdgpu_in_reset(adev)) {
> > +if (adev->in_shutdown ||
> > +    !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev))
> > {
> >  amdgpu_device_set_pg_state(adev,
> > AMD_PG_STATE_UNGATE);
> >  amdgpu_device_set_cg_state(adev,
> > AMD_CG_STATE_UNGATE);
> >  }
> > @@ -3741,7 +3742,8 @@ int amdgpu_device_suspend(struct drm_device
> > *dev, bool fbcon)
> >
> >  amdgpu_fence_driver_suspend(adev);
> >
> > -if (!amdgpu_acpi_is_s0ix_supported(adev) ||
> > amdgpu_in_reset(adev))
> > +if (adev->in_shutdown ||
> > +    !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev))
> >  r = amdgpu_device_ip_suspend_phase2(adev);
> >  else
> >  amdgpu_gfx_state_change_set(adev,
> > sGpuChangeState_D3Entry); diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 2ddaa72437e3..b44358e8dc5b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -1265,6 +1265,7 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
> >  if (amdgpu_ras_intr_triggered())
> >  return;
> >
> > +adev->in_shutdown = true;
> >  /* if we are running in a VM, make sure the device
> >   * torn down properly on reboot/shutdown.
> >   * unfortunately we can't detect certain @@ -1274,6 +1275,7 @@
> > amdgpu_pci_shutdown(struct pci_dev *pdev)
> >  adev->mp1_state = PP_MP1_STATE_UNLOAD;
> >  amdgpu_device_ip_suspend(adev);
> >  adev->mp1_state = PP_MP1_STATE_NONE;
> > +adev->in_shutdown = false;
> >  }
> >
> >  static int amdgpu_pmops_prepare(struct device *dev)
> > --
> > 2.29.2
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
