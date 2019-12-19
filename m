Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C991FC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 03:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A02222314
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 03:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pO904L9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A02222314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 021236E072;
	Thu, 19 Dec 2019 03:23:19 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D9606E072
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 03:23:18 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id q9so3943432wmj.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 19:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DnXbevrZK77XylqsyP80Z8MhMG7fFARXa9Ofhc/NJZ0=;
 b=pO904L9YDKKn7plogX4UbqDzM+yx/FAq8KwRHOE5ySSbj+qNSKmg8BzfGhNgoyVtAa
 dc97ze4jQGu3BRCFPENju4ZiV5zyvLW8XIdvw+3wQwWDQ2Ftae2coNrw6uQK7i0VdIQt
 TbGyYRyBuCES16ey9sBcSFfQoKH0+1Q9LkdCNTDN/MNOP8JutIKTglX/9h9ej0bVx+dz
 +8aMeo8aGe6o3qrpCfEuCgiYhKdQZjzRjoETIb/xcYRwvKEHpnCSUuWIA6my2PFie6G+
 +SNkGeRs0SZDKW2DSRgGKNgbtxOPPHE7Stza7d78HrzNGtmVkfBbhEXbih0wyjBHJjNI
 Uk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DnXbevrZK77XylqsyP80Z8MhMG7fFARXa9Ofhc/NJZ0=;
 b=X1Qv9PPXuryQxSNrsVUu0i36BFjOsTTBR2wD1Jh/AP+rGWsMfIy1SGIGiNxxZMgL85
 QWb7HIx7SQImsCUuB/KXQWu6Bx2EjcqcHM+4xu7WSl+I0DbERXqsSFOVLcJlzGVUvRNq
 wt/wIjD0eadrdOnzVmYQM7cwaGDNIXLo4nWkxSuIxXwVhw0jKa5aS0Z1lJEw9ycenmXW
 akXTHN/Hyqm+1rzX06Mh5k9OZK7Ed/vV96N9zZ4h49Bo9fjYtHCw/yqsTZpsGAKzEdlP
 JYbijuJG8k53RikdDYBL1TKnURC9h0IBSXHOabn0Z+dYjjAbhSxSt2t692/peuX+afDV
 0b1w==
X-Gm-Message-State: APjAAAW4Wo7PvFwPkbwwfi64nrwaF7TWo2NG2EBq/vm27C55mLuDRvys
 IqX61BtrlObYEkqAaJAmHT32/eXkhCP5+ZvKToA=
X-Google-Smtp-Source: APXvYqwegoHeAxPei5Dvo1in3Kf1fb2x0P0zq4mtZDkFI2BVZgRZQ0qJlumtkFCgDFZk4G+kfbFMRnOqZQNzbZ3OTN0=
X-Received: by 2002:a1c:e909:: with SMTP id q9mr7540242wmc.30.1576725796621;
 Wed, 18 Dec 2019 19:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20191218032457.28424-1-evan.quan@amd.com>
 <CADnq5_PXP-TTS46rw6HcxPo8ZM_2djf9Ct12dyBQ9sMs7Cxv3g@mail.gmail.com>
 <MN2PR12MB33440E09FC04B87E06695B6CE4520@MN2PR12MB3344.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB33440E09FC04B87E06695B6CE4520@MN2PR12MB3344.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Dec 2019 22:23:04 -0500
Message-ID: <CADnq5_N+HxFcm5F8hnCsHouY4Ed+E7nYZL2F_0cSqWoS1Gjs4A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: no SMC firmware reloading for non-RAS baco
 reset
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 18, 2019 at 9:12 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> Hi Alex,
>
> "Power saving" means the regular suspend/resume case, right? That was considered.

I mean BACO for runtime power management support.  I landed the code
to enable BACO for saving power at runtime when the GPU is not in use.
It's still disabled by default until we properly handle KFD support,
but you can enable it with amdgpu.runpm=1.

> With current amdgpu code, the MP1 state was not correctly set for the regular suspend case.
> More straightforwardly I believe PrepareMP1_for_unload should be issued to MP1 on regular suspend path(excluding gpu reset case).
>
> And with the MP1 state correctly set for all case, we can remove the "adev->in_gpu_reset".
> But for now, I do not want to involve too many changes and limit this to the gpu reset case.
>
> P.S. the mp1 state was correctly handled for mode1 reset. So, it's safe to enforce this for all gpu reset case instead of baco reset only.

Ah, good to hear.

Alex

>
> Regards,
> Evan
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Wednesday, December 18, 2019 10:56 PM
> > To: Quan, Evan <Evan.Quan@amd.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> > Subject: Re: [PATCH] drm/amdgpu: no SMC firmware reloading for non-RAS
> > baco reset
> >
> > On Tue, Dec 17, 2019 at 10:25 PM Evan Quan <evan.quan@amd.com> wrote:
> > >
> > > For non-RAS baco reset, there is no need to reset the SMC. Thus the
> > > firmware reloading should be avoided.
> > >
> > > Change-Id: I73f6284541d0ca0e82761380a27e32484fb0061c
> > > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  3 ++-
> > > drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 14 ++++++++++++++
> > >  2 files changed, 16 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > > index c14f2ccd0677..9bf7e92394f5 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > > @@ -1439,7 +1439,8 @@ static int psp_np_fw_load(struct psp_context *psp)
> > >                         continue;
> > >
> > >                 if (ucode->ucode_id == AMDGPU_UCODE_ID_SMC &&
> > > -                   (psp_smu_reload_quirk(psp) || psp->autoload_supported))
> > > +                   ((adev->in_gpu_reset && psp_smu_reload_quirk(psp))
> > > +                     || psp->autoload_supported))
> >
> > Will this cover the power saving case as well?  Do we need to check
> > adev->in_gpu_reset as well or can we drop that part?
> >
> > Alex
> >
> > >                         continue;
> > >
> > >                 if (amdgpu_sriov_vf(adev) && diff --git
> > > a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> > > index c66ca8cc2ebd..ba761e9366e3 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> > > @@ -676,6 +676,19 @@ static bool psp_v11_0_compare_sram_data(struct
> > psp_context *psp,
> > >         return true;
> > >  }
> > >
> > > +/*
> > > + * Check whether SMU is still alive. If that's true
> > > + * (e.g. for non-RAS baco reset), we need to skip SMC firmware reloading.
> > > + */
> > > +static bool psp_v11_0_smu_reload_quirk(struct psp_context *psp) {
> > > +       struct amdgpu_device *adev = psp->adev;
> > > +       uint32_t reg;
> > > +
> > > +       reg = RREG32_PCIE(smnMP1_FIRMWARE_FLAGS | 0x03b00000);
> > > +       return (reg &
> > MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) ?
> > > +true : false; }
> > > +
> > >  static int psp_v11_0_mode1_reset(struct psp_context *psp)  {
> > >         int ret;
> > > @@ -1070,6 +1083,7 @@ static const struct psp_funcs psp_v11_0_funcs = {
> > >         .ring_stop = psp_v11_0_ring_stop,
> > >         .ring_destroy = psp_v11_0_ring_destroy,
> > >         .compare_sram_data = psp_v11_0_compare_sram_data,
> > > +       .smu_reload_quirk = psp_v11_0_smu_reload_quirk,
> > >         .mode1_reset = psp_v11_0_mode1_reset,
> > >         .xgmi_get_topology_info = psp_v11_0_xgmi_get_topology_info,
> > >         .xgmi_set_topology_info = psp_v11_0_xgmi_set_topology_info,
> > > --
> > > 2.24.0
> > >
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> > gfx&amp;data=02%7C01%7Cev
> > >
> > an.quan%40amd.com%7C8781ad2ef92d4a188c3008d783ca6846%7C3dd8961fe
> > 4884e6
> > >
> > 08e11a82d994e183d%7C0%7C0%7C637122777663939524&amp;sdata=DMLV%
> > 2Bz%2FsG
> > > nXhpsiOdv9EZrsBcn6HGJ3L7lKdKL2PaPQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
