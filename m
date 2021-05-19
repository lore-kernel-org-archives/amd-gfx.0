Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61D0C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 02:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C1861363
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 02:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C1861363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 255606ECC0;
	Wed, 19 May 2021 02:20:30 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E2166ECC0
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 02:20:01 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 t10-20020a05683022eab0290304ed8bc759so10435971otc.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 19:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5FGNGve67ZWXy0J3UZiYo1vBqbmNmiV+yxKlkklhzZY=;
 b=tWlM3nL4L+OFZHT7KmBfQrad3YQRFD5Iu6AyNUxVzxzQJLD+0K08Ukys/IfHtHPa43
 rlT6wNF2WAei23Y34w08xDATWgMHaYiHVHNaIJKhPut7j9NyUQrhZubcULKyu7by/lWv
 KDUAySZa+1DPVp1hgECgtueWbnfdzlirgmEdl3HF1ORkpONsPhZXuna6tbF574iJFSFQ
 ORADXvQl2TOBE3a3nPOEwo/hb4JIdSMbugRXwEjRPCE+a1LbVw1/P1iKQVYnLB8PlOYD
 A2/OMs7bjI+quKqFkdX0NGjxXQbI2yLMn+03vSoL74EjW+C/Jffjv6etJQXXlakfDUni
 vwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5FGNGve67ZWXy0J3UZiYo1vBqbmNmiV+yxKlkklhzZY=;
 b=Hsi3aM2ebFDfx133p5vpqRJxQkpGPpz6LN7KomyQMfdyjWqUZOmNip+tKX/1ricuRd
 4M5kd7WYk9YNpTBbgnSdo0YGrpJs7VR6b9VMKGajt1MH8/epoG5NBuXYeiCGWC2zncW3
 dYKz6kCbNNZlYF3Kz6kDJK45WZWkL8+QjMuGHZdeUXB6504SlDgYcT8o3XBHyOWjJCa0
 tC2RFBQ3vRxtV2/L0IwRclli6NClWtr+dgvjEDGXat8aocYsCxG6aY22LbDaMIQQukfn
 9L66cEBjwpgemm2c64OVqrQmzFyEkUlTBFCvZAHsEDYBuRjPOOOpFYpBU9hE353NtxTg
 HhhA==
X-Gm-Message-State: AOAM531OqPkEQR7d2J7c4WY6gsTSnrkVTd2KctZUZYe/JxS+KsORhcBq
 l0NjFxxTTJVZ1wmfZUtSjFmoo7fNJduKDuMV8CwimrC+
X-Google-Smtp-Source: ABdhPJyuiChm37DGUEsPNkF9nTcAZ8xEOEJVaCT4UiJ7E0mysxr2Vh2KQg/lfjBCJj2tbixU4R/Hkjvm7JS+HtoYZeU=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr6781234oti.23.1621390800926; 
 Tue, 18 May 2021 19:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210514081944.16849-1-changfeng.zhu@amd.com>
 <CADnq5_P4tvpTkmzpn=7V8qvfvy3aiR3WO967UObKKacJzQro9w@mail.gmail.com>
 <20210517062724.GA1853590@hr-amd>
 <MW2PR12MB46847BE39163543C680AF9BCFD2D9@MW2PR12MB4684.namprd12.prod.outlook.com>
In-Reply-To: <MW2PR12MB46847BE39163543C680AF9BCFD2D9@MW2PR12MB4684.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 May 2021 22:19:50 -0400
Message-ID: <CADnq5_OmpYjzaeGPUC4rUNkSo_CP+8zFfZQsF6d+2fLegtxUkQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid
 compute hang
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Care to submit a patch to re-enable the extra compute queues?

Alex

On Mon, May 17, 2021 at 4:09 AM Zhu, Changfeng <Changfeng.Zhu@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Ray and Alex,
>
> I have confirmed it can enable the additional compute queues with this patch:
>
> [   41.823013] This is ring mec 1, pipe 0, queue 0, value 1
> [   41.823028] This is ring mec 1, pipe 1, queue 0, value 1
> [   41.823042] This is ring mec 1, pipe 2, queue 0, value 1
> [   41.823057] This is ring mec 1, pipe 3, queue 0, value 1
> [   41.823071] This is ring mec 1, pipe 0, queue 1, value 1
> [   41.823086] This is ring mec 1, pipe 1, queue 1, value 1
> [   41.823101] This is ring mec 1, pipe 2, queue 1, value 1
> [   41.823115] This is ring mec 1, pipe 3, queue 1, value 1
>
> BR,
> Changfeng.
>
>
> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Monday, May 17, 2021 2:27 PM
> To: Alex Deucher <alexdeucher@gmail.com>; Zhu, Changfeng <Changfeng.Zhu@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid compute hang
>
> On Fri, May 14, 2021 at 10:13:55PM +0800, Alex Deucher wrote:
> > On Fri, May 14, 2021 at 4:20 AM <changfeng.zhu@amd.com> wrote:
> > >
> > > From: changzhu <Changfeng.Zhu@amd.com>
> > >
> > > From: Changfeng <Changfeng.Zhu@amd.com>
> > >
> > > There is problem with 3DCGCG firmware and it will cause compute test
> > > hang on picasso/raven1. It needs to disable 3DCGCG in driver to
> > > avoid compute hang.
> > >
> > > Change-Id: Ic7d3c7922b2b32f7ac5193d6a4869cbc5b3baa87
> > > Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
> >
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > WIth this applied, can we re-enable the additional compute queues?
> >
>
> I think so.
>
> Changfeng, could you please confirm this on all raven series?
>
> Patch is Reviewed-by: Huang Rui <ray.huang@amd.com>
>
> > Alex
> >
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++++---
> > >  drivers/gpu/drm/amd/amdgpu/soc15.c    |  2 --
> > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > index 22608c45f07c..feaa5e4a5538 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > @@ -4947,7 +4947,7 @@ static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
> > >         amdgpu_gfx_rlc_enter_safe_mode(adev);
> > >
> > >         /* Enable 3D CGCG/CGLS */
> > > -       if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
> > > +       if (enable) {
> > >                 /* write cmd to clear cgcg/cgls ov */
> > >                 def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
> > >                 /* unset CGCG override */ @@ -4959,8 +4959,12 @@
> > > static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
> > >                 /* enable 3Dcgcg FSM(0x0000363f) */
> > >                 def = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);
> > >
> > > -               data = (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> > > -                       RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
> > > +               if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
> > > +                       data = (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> > > +                               RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
> > > +               else
> > > +                       data = 0x0 <<
> > > + RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT;
> > > +
> > >                 if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS)
> > >                         data |= (0x000F << RLC_CGCG_CGLS_CTRL_3D__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
> > >                                 RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > index 4b660b2d1c22..080e715799d4 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > @@ -1393,7 +1393,6 @@ static int soc15_common_early_init(void *handle)
> > >                         adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> > >                                 AMD_CG_SUPPORT_GFX_MGLS |
> > >                                 AMD_CG_SUPPORT_GFX_CP_LS |
> > > -                               AMD_CG_SUPPORT_GFX_3D_CGCG |
> > >                                 AMD_CG_SUPPORT_GFX_3D_CGLS |
> > >                                 AMD_CG_SUPPORT_GFX_CGCG |
> > >                                 AMD_CG_SUPPORT_GFX_CGLS | @@ -1413,7
> > > +1412,6 @@ static int soc15_common_early_init(void *handle)
> > >                                 AMD_CG_SUPPORT_GFX_MGLS |
> > >                                 AMD_CG_SUPPORT_GFX_RLC_LS |
> > >                                 AMD_CG_SUPPORT_GFX_CP_LS |
> > > -                               AMD_CG_SUPPORT_GFX_3D_CGCG |
> > >                                 AMD_CG_SUPPORT_GFX_3D_CGLS |
> > >                                 AMD_CG_SUPPORT_GFX_CGCG |
> > >                                 AMD_CG_SUPPORT_GFX_CGLS |
> > > --
> > > 2.17.1
> > >
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fli
> > > sts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%
> > > 7CRay.Huang%40amd.com%7C0e273856253d4b3efd0b08d916e2892a%7C3dd8961fe
> > > 4884e608e11a82d994e183d%7C0%7C0%7C637565984495414849%7CUnknown%7CTWF
> > > pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> > > 6Mn0%3D%7C1000&amp;sdata=lBzswAPBguL0mWFglEk%2Bg2eDCEuhir7JfFjov%2BV
> > > 7pSY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
