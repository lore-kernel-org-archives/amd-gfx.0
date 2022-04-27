Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0ACC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 16:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3B3710E163;
	Wed, 27 Apr 2022 16:10:36 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AFD510E05E
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 16:10:35 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-e68392d626so2452654fac.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 09:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YL53+dkKJ8Nq1+jtQTDMpOFcGbXGXb30Ai4hIBqWlNY=;
 b=C0Rhajnkbo0l/qrNd9GiAZxmeewXtmff4Kk0al6lU39pNNVSuTOvza1qJSywbxt+T+
 VjKXUwB9isHiou6zXEncrN+HinjHsjdWp9551UTIjg0mKVHp9ESpNZ79LfeM27+U5cX+
 yWZC8+sgbAHFuYaNwW0oi5YtMitzckMi/PQA4hKG2u822c/PyLXyXa5L2LxFGAVwiHkV
 Tmn+5CY8WWK/yGWirfyknHvmUJ9fDk8QSlcNJ6GEyryLJa6zwp8urRd4mxySgl3PfK8J
 JwgeecYOuq8xP8B7XRO9mK8HioXTYvXi2UNW6RRoibdTiOWj1nrqzIchEbolwt86sKb1
 nhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YL53+dkKJ8Nq1+jtQTDMpOFcGbXGXb30Ai4hIBqWlNY=;
 b=6X/cI9Ua+VFkqNIEOkrk9XS/CsBUz8MztEIpXl+wh6tZ8SUeg7hAnQCj7xBskq2j3+
 jmEpMeAo3lY2zBaO9nqpD6QPDc5UofiAK+Ae6GWpg+0aOPNx7m/5XNjmbcrHr5Cj4RTj
 maUBw/L0EXHPzX8t+eJwc59QK5ClgGZ+hPcKl6FOuEnUccrRbCS9OitCvuWyM3drtVUm
 cEezemPj+xfzLL+Tf9+7K4Ig4fnMcEd2gpcwVNOh8R54j8fEkzwTEUpb6nclJg1G3VXf
 nIVSYTjGkXtSSHlvT8YninEdsLEERvhZHXcNwImQ1PUm2iSAntyJC9Y91nlGE4Ds65Jr
 JP3Q==
X-Gm-Message-State: AOAM530w2pzlxNoigUSLTw8UO90iYJV51tB4HUlR7AkpRFdx7o8jjaTm
 WbxnqMgk8owJgbkETgiM++Eg7mWj/1CRTECKUes0RhF3
X-Google-Smtp-Source: ABdhPJzIHi7XnhqZq+nRo1ALPVP5IUAHKy+Z56AR++L645zaHjd8I57DhG0/J5zEcp4G2GWINDLqNq/YLxQsmEZA4ms=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr15360072oaa.200.1651075834510; Wed, 27
 Apr 2022 09:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220427102659.23579-1-guchun.chen@amd.com>
 <DM6PR12MB2619F4B2E3CDA10FC4B93946E4FA9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619F4B2E3CDA10FC4B93946E4FA9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Apr 2022 12:10:22 -0400
Message-ID: <CADnq5_OaOhGjTRNDhBYq2wL7njk0REgGjpm4XLeTSDf2nOoYUw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable runtime pm on several sienna cichlid
 cards(v2)
To: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 27, 2022 at 7:42 AM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
>
>
> > -----Original Message-----
> > From: Chen, Guchun <Guchun.Chen@amd.com>
> > Sent: Wednesday, April 27, 2022 6:27 PM
> > To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> > <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;
> > Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
> > <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> > Cc: Chen, Guchun <Guchun.Chen@amd.com>
> > Subject: [PATCH] drm/amdgpu: disable runtime pm on several sienna cichlid
> > cards(v2)
> >
> > Disable runtime power management on several sienna cichlid
> > cards, otherwise SMU will possibly fail to be resumed from
> > runtime suspend. Will drop this after a clean solution between
> > kernel driver and SMU FW is available.
> >
> > amdgpu 0000:63:00.0: amdgpu: GECC is enabled
> > amdgpu 0000:63:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is
> > not available
> > amdgpu 0000:63:00.0: amdgpu: SMU is resuming...
> > amdgpu 0000:63:00.0: amdgpu: SMU: I'm not done with your command:
> > SMN_C2PMSG_66:0x0000000E SMN_C2PMSG_82:0x00000080
> > amdgpu 0000:63:00.0: amdgpu: Failed to SetDriverDramAddr!
> > amdgpu 0000:63:00.0: amdgpu: Failed to setup smc hw!
> > [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP
> > block <smu> failed -62
> > amdgpu 0000:63:00.0: amdgpu: amdgpu_device_ip_resume failed (-62)
> >
> > v2: seperate to a function.
> >
> > Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > index 262938f0dfdb..1bf8ff71b6b5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -43,6 +43,17 @@
> >  #include "amdgpu_display.h"
> >  #include "amdgpu_ras.h"
> >
> > +static void amdgpu_runtime_pm_quirk(struct amdgpu_device *adev)
> > +{
> > +     /*
> > +      * Add below quirk on several sienna_cichlid cards to disable
> > +      * runtime pm to fix EMI failures.
> > +      */
> > +     if (((adev->pdev->device == 0x73A1) && (adev->pdev->revision ==
> > 0x00)) ||
> > +         ((adev->pdev->device == 0x73BF) && (adev->pdev->revision ==
> > 0xCF)))
> > +             adev->runpm = false;
> > +}
> > +
> [Quan, Evan] Better to move this to sienna_cichlid_check_bxco_support(). As long as smu_baco->platform_support is set as false there,
> the runpm will be disabled accordingly I think.

Good point.  We probably want to disable BACO entirely or enable the
workaround because BACO could also be used for a GPU reset in some
cases.  Then only disable runtime pm if BACO will be used.  BOCO
should still work fine for example.

Alex

>
> Either way the patch is reviewed-by: Evan Quan <evan.quan@amd.com>
>
> BR
> Evan
> >  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
> >  {
> >       struct amdgpu_gpu_instance *gpu_instance;
> > @@ -180,6 +191,9 @@ int amdgpu_driver_load_kms(struct amdgpu_device
> > *adev, unsigned long flags)
> >                */
> >               if (adev->is_fw_fb)
> >                       adev->runpm = false;
> > +
> > +             amdgpu_runtime_pm_quirk(adev);
> > +
> >               if (adev->runpm)
> >                       dev_info(adev->dev, "Using BACO for runtime
> > pm\n");
> >       }
> > --
> > 2.17.1
