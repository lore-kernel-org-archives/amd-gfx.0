Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197D3C2BA83
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 14:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F6D21741
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 14:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVEc5+uy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F6D21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A16DF6FCDB;
	Fri,  7 Feb 2020 14:38:20 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 868C66FCDB
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 14:38:19 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id g1so2800928wmh.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Feb 2020 06:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QxCV6GYDI/sfhaIGpIYAPHVjHQEy7mMrT5mc8pEuPv8=;
 b=YVEc5+uyKLU43PbvFBsR50iE6880p11ftr2zI8CIHSy5Q+nMvxzmS/gVLwIWW+HAd7
 2rZ3dP+Cj6grttKa9aeGXuke3jy+6ElHBRdbF2aRwSVbPn8nR3n7X4BHWahbt6jUmEz9
 pcuKCPIUD5bHzdUoXLYik7/sJrn+50m2W1Aa9khm1uMOmkajzhlkqQ4tYSr3jt2oVb+4
 EaNJkhAzOfvGEis2wevab3dli06FgCn3UpIRI/q//Pstj4yTZy8U8WfDGZ07cUJ23s/K
 hZS30ddBoHID7nZljJdt8fLFr+/6BydVMd7thA4upDbs/fKoCl28dIExfLe9FHQIe7ZY
 +0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QxCV6GYDI/sfhaIGpIYAPHVjHQEy7mMrT5mc8pEuPv8=;
 b=NiiudPumAkD5ikQXbfzvHNDCua32WBRT05QN2XdbTnXUMIdwU1F5+D8hmPPqWuXMdI
 QNkJBbXhMxEA2ZmVhq90TlPuBlOpENvWh9VUUfu6z3xkfOTv837Sz60rE7Wfc5yA61Qj
 BNgIPSbsqXZG6VgnIN8VJcig58GITbVprSgFrDfIHuGInDPmA2G7n7yolDB5NCZYY/gR
 Yb60X2ys67ElSnKcDQamNqMPIKtw/iFkhG0710djPtq+MZ4XabHhIoMbQCTWhccWM/fW
 UJ4dcKK4jB+YvyaIQvALGbOHi9b/eNNu1YEs7FFtKqfH383psO+HHAaceTPJyxiAIcT9
 pYjw==
X-Gm-Message-State: APjAAAUvyCxJRRJ3zcllDpMMlH/WoUJPaQ47aj8pMI1NhUQjOyOYUbtX
 uGbJIbz/b1KG/L7yEOnhaoiBN00R1E5a3mUt2jQ=
X-Google-Smtp-Source: APXvYqzyNNI5wTTrocsGmlDWho+Mmr8mLQ2b/QE7zgBmhwJnsmDA3MjO8XgPS1HCPZyl1CzlElE1A7lD7gPPIyNHzV8=
X-Received: by 2002:a05:600c:218b:: with SMTP id
 e11mr4801573wme.56.1581086298054; 
 Fri, 07 Feb 2020 06:38:18 -0800 (PST)
MIME-Version: 1.0
References: <20200206081920.18766-1-evan.quan@amd.com>
 <CADnq5_Obdf0pL8vuereUPGsVZWPaHX1J3Fkni3_ZFbUOxFMrfw@mail.gmail.com>
 <MN2PR12MB3344D5998333EC893754FF3BE41C0@MN2PR12MB3344.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3344D5998333EC893754FF3BE41C0@MN2PR12MB3344.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 Feb 2020 09:38:06 -0500
Message-ID: <CADnq5_P94he3QfCONG0VJLNohsyuV+PCF9d=dD2DTChNhfvQCw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: handle features disablement for baco
 reset in SMU FW
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 7, 2020 at 3:28 AM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> >Do we need the in_gpu_reset check here?  Is there ever a case where would
> >ever want to execute the rest of this?  What if we enable BACO for power
> >savings on arcturus?
> That is used to rule out the system suspend case.
> But yes, it may cause some problem for the runtime suspend case(which uses baco for power saving).
> How can we know whether it's a runtime suspend or just system suspend?

At the moment, we haven't had a need to differentiate them, but we
could add a flag.  That said, I don't quite understand why BACO at
runtime is any different from BACO for reset.  They should both
require the same steps to enter and exit.  What is different about
system suspend?

Alex

>
> >-----Original Message-----
> >From: Alex Deucher <alexdeucher@gmail.com>
> >Sent: Thursday, February 6, 2020 10:01 PM
> >To: Quan, Evan <Evan.Quan@amd.com>
> >Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking
> ><Hawking.Zhang@amd.com>
> >Subject: Re: [PATCH] drm/amd/powerplay: handle features disablement for
> >baco reset in SMU FW
> >
> >On Thu, Feb 6, 2020 at 3:19 AM Evan Quan <evan.quan@amd.com> wrote:
> >>
> >> SMU FW will handle the features disablement for baco reset on
> >> Arcturus.
> >>
> >> Change-Id: Ifd87a09de2fca0c67c041afbd5e711973769119a
> >> Signed-off-by: Evan Quan <evan.quan@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 53
> >> +++++++++++++++++-----
> >>  1 file changed, 42 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> >> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> >> index 9d1075823681..efd10e6fa9ef 100644
> >> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> >> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> >> @@ -1467,24 +1467,39 @@ void smu_late_fini(void *handle)
> >>         smu_send_smc_msg(smu, SMU_MSG_PrepareMp1ForShutdown);  }
> >>
> >> -static int smu_suspend(void *handle)
> >> +static int smu_disabled_dpms(struct smu_context *smu)
> >>  {
> >> -       int ret;
> >> -       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >> -       struct smu_context *smu = &adev->smu;
> >> -       bool baco_feature_is_enabled = false;
> >> +       struct amdgpu_device *adev = smu->adev;
> >> +       uint32_t smu_version;
> >> +       int ret = 0;
> >>
> >> -       if (!smu->pm_enabled)
> >> -               return 0;
> >> +       ret = smu_get_smc_version(smu, NULL, &smu_version);
> >> +       if (ret) {
> >> +               pr_err("Failed to get smu version.\n");
> >> +               return ret;
> >> +       }
> >>
> >> -       if(!smu->is_apu)
> >> -               baco_feature_is_enabled = smu_feature_is_enabled(smu,
> >SMU_FEATURE_BACO_BIT);
> >> +       /*
> >> +        * For baco reset on Arcturus, this operation
> >> +        * (disable all smu feature) will be handled by SMU FW.
> >> +        */
> >> +       if (adev->in_gpu_reset &&
> >> +           (amdgpu_asic_reset_method(adev) ==
> >AMD_RESET_METHOD_BACO) &&
> >> +           (adev->asic_type == CHIP_ARCTURUS && smu_version > 0x360e00))
> >> +               return 0;
> >
> >Do we need the in_gpu_reset check here?  Is there ever a case where would
> >ever want to execute the rest of this?  What if we enable BACO for power
> >savings on arcturus?
> >
> >>
> >> +       /* Disable all enabled SMU features */
> >>         ret = smu_system_features_control(smu, false);
> >> -       if (ret)
> >> +       if (ret) {
> >> +               pr_err("Failed to disable smu features.\n");
> >>                 return ret;
> >> +       }
> >>
> >> -       if (baco_feature_is_enabled) {
> >> +       /* For baco reset, need to leave BACO feature enabled */
> >> +       if (adev->in_gpu_reset &&
> >> +           (amdgpu_asic_reset_method(adev) ==
> >AMD_RESET_METHOD_BACO) &&
> >> +           !smu->is_apu &&
> >> +           smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)) {
> >
> >This change will break BACO for power savings on navi1x.  I think we can drop
> >this hunk.
> >
> >>                 ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT,
> >true);
> >>                 if (ret) {
> >>                         pr_warn("set BACO feature enabled failed,
> >> return %d\n", ret); @@ -1492,6 +1507,22 @@ static int smu_suspend(void
> >*handle)
> >>                 }
> >>         }
> >>
> >> +       return ret;
> >> +}
> >> +
> >> +static int smu_suspend(void *handle)
> >> +{
> >> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >> +       struct smu_context *smu = &adev->smu;
> >> +       int ret;
> >> +
> >> +       if (!smu->pm_enabled)
> >> +               return 0;
> >> +
> >> +       ret = smu_disabled_dpms(smu);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >>         smu->watermarks_bitmap &= ~(WATERMARKS_LOADED);
> >>
> >>         if (adev->asic_type >= CHIP_NAVI10 &&
> >> --
> >> 2.25.0
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> >> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> >gfx&amp;data=02%7C01%7Cev
> >>
> >an.quan%40amd.com%7Ce4212e8faa2849ebda5008d7ab0cfbfd%7C3dd8961fe
> >4884e6
> >>
> >08e11a82d994e183d%7C0%7C0%7C637165944568797358&amp;sdata=M9jaswf
> >JV%2Bq
> >> KLZTxff%2Bju81y47M9WKT2iULEZjHBHcw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
