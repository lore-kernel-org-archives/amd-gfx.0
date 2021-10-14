Return-Path: <SRS0=AM0C=PC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B171C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 02:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C97106109F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 02:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C97106109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4887F6E128;
	Thu, 14 Oct 2021 02:00:25 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4B736E128
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Oct 2021 02:00:24 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 l24-20020a9d1c98000000b00552a5c6b23cso6202882ota.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 19:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZX0DgDucBFu/k04JmZ+UZyIBco2qhhOoab72Zs+HhuU=;
 b=XOKEEvqEVrvSWAvAnlMwnP3RKnTNC07RIpsLxh1kwE0PMxYg9hheu79UbUwp3WIDDy
 ksjLJULNLKXYZAG/dXFkyxh9OZPnb2gCfsOeUxE5xQ8Dr87Tq+sVDCVcxFWTl0eXCv+d
 7yAwnuhWluUzYUHkX2JxCW1ufudigqnG536GYUszVtfcXBtIbunPK3JqLZCqTY+ztDmt
 rtIDLbK0c+hKPRtiRSUuPKA8d3LChpDSszocB56C5a5GLlb0QrQwAfoHjIgYfAD5IpiA
 DRej5d7m8HEABFZTVrTkOxVJpGIgaxZoPH1I10Zdgu+YJ90F72TEAf3LUm9k82snb+rD
 Y4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZX0DgDucBFu/k04JmZ+UZyIBco2qhhOoab72Zs+HhuU=;
 b=d5k7OE8XHGcwY2u9heOHVp1By2O0kF6LZ6yYWJ/awzInyNe52TOY+2i6I+Ya02Co4d
 TKxL+NmCQyMY8yeOJnO0AJvFrY4JpBRLPwdySM1R1UVKDPlfjldVAZRXW6eF6rnMcuUS
 PndP1Kcpnf2KRdkZJse70bAO5hY57EGcnkSs8K2OBcdaNpjHqP9YxRgO3TyqFS2390B1
 fklVIPhCWxGkptNFQ0yG5Sp2sFbSJP09RDONHVEmus+FlUfJNUNMcKYlZC7WX7crp6Iu
 QXd4XEk5+E3ils7o6Zb/VlNV9XHc9ofPai//cYVp04mOMDvVUHOPlLUFwiXe3yCqo8Kd
 t05w==
X-Gm-Message-State: AOAM530pmEvsVTz56wGLvTuw3ZGsCGNvRZ1wsT/UsM8wb9Hp8Qf35w8Z
 chrRGE7BryzZlV6Qx5Xez6KlJ7uut2ytnALWb1Y=
X-Google-Smtp-Source: ABdhPJy8gj7uW16y/n0SQjXU85ggx974rQx+lxczTL34h2mARWgJt83aov5B0uXw5afpnGT/UUE2oZjmkYwEJYWwoAc=
X-Received: by 2002:a05:6830:23ac:: with SMTP id
 m12mr69430ots.357.1634176823921; 
 Wed, 13 Oct 2021 19:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211012155307.1059170-1-alexander.deucher@amd.com>
 <20211012155307.1059170-3-alexander.deucher@amd.com>
 <DM6PR12MB261955EC5754D6E20C98DF9BE4B89@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB261955EC5754D6E20C98DF9BE4B89@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Oct 2021 22:00:13 -0400
Message-ID: <CADnq5_PVm4fFCNHSodNNSct19waF6nnQGBN_keR_2+Zi4SYF+w@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/psp: add some missing cases to
 psp_check_pmfw_centralized_cstate_management
To: "Quan, Evan" <Evan.Quan@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 13, 2021 at 9:41 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only]
>
> I assume IP_VERSION(11, 0, 0) and IP_VERSION(11, 0, 5) are for Navi10 and Navi14 respectively.
> Then according to the code comment that " pmfw_centralized_cstate_management support is available for Navi12 and onwards only", I think they should be handled by "default" branch. That means this patch seems unnecessary.
>

The original code was this:
       if ((adev->asic_type >= CHIP_ARCTURUS) ||
           (adev->asic_type >= CHIP_NAVI12))
                psp->pmfw_centralized_cstate_management = true;
So navi10 and 14 were included.  Not sure whether they should have been or not.

Alex


> Patch1 and 2 are reviewed-by: Evan Quan <evan.quan@amd.com>
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Tuesday, October 12, 2021 11:53 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: [PATCH 3/3] drm/amdgpu/psp: add some missing cases to
> > psp_check_pmfw_centralized_cstate_management
> >
> > Missed a few asics.
> >
> > Fixes: 82d05736c47b19 ("drm/amdgpu/amdgpu_psp: convert to IP version
> > checking")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > index 6b39e6c02dd8..51620f2fc43a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -77,7 +77,9 @@ static void
> > psp_check_pmfw_centralized_cstate_management(struct psp_context
> > *psp
> >       }
> >
> >       switch (adev->ip_versions[MP0_HWIP][0]) {
> > +     case IP_VERSION(11, 0, 0):
> >       case IP_VERSION(11, 0, 4):
> > +     case IP_VERSION(11, 0, 5):
> >       case IP_VERSION(11, 0, 7):
> >       case IP_VERSION(11, 0, 9):
> >       case IP_VERSION(11, 0, 11):
> > --
> > 2.31.1
