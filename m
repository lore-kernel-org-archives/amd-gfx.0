Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E2CC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 14:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3316613DD
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 14:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3316613DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C1786E919;
	Fri, 21 May 2021 14:25:16 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 437816E919
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 14:25:15 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 69-20020a9d0a4b0000b02902ed42f141e1so18170578otg.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 07:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I/UBe90D8qxOepd40gGpiekwqb09q29PwNMblsPNi7A=;
 b=Dd/5gm0cZY/lvOoM7fdsqyjvi8ps/ShSse5eyacvc/LPNK0EXvwvTVz5yh3/aZBGGY
 HINoNnU0mFLoQHmlEdPgOAGtZoRc1mvItE37bx9p7SRlA6UfcBUNFNXASffyJT2814FT
 jtYc4Ldjcbkv2n4OJyGXMfm+9pDLiN7S4G3uDPsMltNtExnYRuPoeQpFeXnafNiAwYt2
 h4lX5NaKcJZSqCgTSkGz9d+VIl5AIai+A2oUUJfQVDYxwq1ak47lnoA6T9/LqjPTbKJM
 ayCfwApPEi5OVmdiH23FswePP5u6BrrJQkVnYI0NDhmuttGa8DblJrYt6+Uxz8XQG2/U
 l0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I/UBe90D8qxOepd40gGpiekwqb09q29PwNMblsPNi7A=;
 b=YElzKUfoXhOMVDY9TJxE1CP839yJSntpvxo2tobX9mBQqyP8qTj26t+jTLR5VEg7TC
 oIt4UbVf7xOaJUhILqF1Z6Rg9TjNV/r+61dJuPLN+EAO3gGmk9ktgAjaegpQEWTKxr2E
 p6ZtKqaROAzKXE/KSUYWvgrjk2JCrYm9p/bXYF59dc4V4PMhpEL0z/6r65HrtIZ/ruIn
 CRd5+uYqkPEjJFxO0ABbU4YVwV7hFtwzH/MTLXypX60Y05+CXpvlGX0UCsY4KSRq0KVe
 svNLSDnSJbUgWiVDWylaxNzt7Vwe08M8rUFWxHGxQ3FNjmS3uJm86iyVHdJY3uewwFrw
 4WPg==
X-Gm-Message-State: AOAM533w5mgP4Nk8RvPlAwPjHTpg6EBDlX+ywr3RENbZYQN3nZ8/YLQp
 RprW63OcbQDxzkJFkps3bXtlJW6bcUGOu5lCiUOt/JYYP3A=
X-Google-Smtp-Source: ABdhPJy4Dxav33aCv7tTGgWPTPuyy8c3b0fBQOdQ+lPRq7Z+nsmoK2hdtNRL2xkVs4y+O/L8gFyMG+E60fhaWKvEj/4=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr8677797otl.132.1621607114490; 
 Fri, 21 May 2021 07:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210517143910.2125-1-PengJu.Zhou@amd.com>
 <20210517143910.2125-9-PengJu.Zhou@amd.com>
 <CADnq5_OB+F3yeN9=nJjnvnAV6ePevL6Rz1NYhERJFUJ3s1sCJw@mail.gmail.com>
 <DM8PR12MB5478E96B03A4B7FDF9263092F8299@DM8PR12MB5478.namprd12.prod.outlook.com>
 <PH0PR12MB54173F1759D9D6FAA290DB568F299@PH0PR12MB5417.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54173F1759D9D6FAA290DB568F299@PH0PR12MB5417.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 May 2021 10:25:03 -0400
Message-ID: <CADnq5_OK-dhpYpyiFgq7pD8H25oiD7Rjfns4=mjMWcHuF-7ksQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] drm/amdgpu: Use PSP to program IH_RB_CNTL*
 registers
To: "Deng, Emily" <Emily.Deng@amd.com>
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
Cc: "Zhao, Victor" <Victor.Zhao@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 21, 2021 at 6:07 AM Deng, Emily <Emily.Deng@amd.com> wrote:
>
> Hi Pengju,
>      You'd better only switch for sriov.

Either verify that this doesn't break bare metal, or do something like
we do on sienna cichlid.  E.g.,
                if (!amdgpu_sriov_vf(adev)) {
                        amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
                        if (likely(adev->firmware.load_type ==
AMDGPU_FW_LOAD_PSP))
                                amdgpu_device_ip_block_add(adev,
&psp_v11_0_ip_block);
                } else {
                        if (likely(adev->firmware.load_type ==
AMDGPU_FW_LOAD_PSP))
                                amdgpu_device_ip_block_add(adev,
&psp_v11_0_ip_block);
                        amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
                }

Alex

>
> Best wishes
> Emily Deng
>
> >-----Original Message-----
> >From: Zhou, Peng Ju <PengJu.Zhou@amd.com>
> >Sent: Friday, May 21, 2021 5:58 PM
> >To: Alex Deucher <alexdeucher@gmail.com>; Zhao, Victor
> ><Victor.Zhao@amd.com>; Deng, Emily <Emily.Deng@amd.com>
> >Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> >Subject: RE: [PATCH v5 09/10] drm/amdgpu: Use PSP to program IH_RB_CNTL*
> >registers
> >
> >[AMD Official Use Only - Internal Distribution Only]
> >
> >Hi @Zhao, Victor/@Deng, Emily
> >
> >Can you help to answer Alex's question,?
> >Because this patch originally from @Zhao, Victor, it's hard for me to explain the
> >question.
> >
> >Alex's question:
> >> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> >> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> >> > @@ -845,8 +845,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
> >> >         case CHIP_NAVI12:
> >> >                 amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
> >> >                 amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
> >> > -               amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
> >> >                 amdgpu_device_ip_block_add(adev,
> >> > &psp_v11_0_ip_block);
> >> > +               amdgpu_device_ip_block_add(adev,
> >> > + &navi10_ih_ip_block);
> >>
> >> Is it safe to change the order like this on bare metal?  Please look
> >> at what was done for vega and sienna cichlid.  Something like that is probably
> >a better bet.
> >
> >
> >----------------------------------------------------------------------
> >BW
> >Pengju Zhou
> >
> >
> >
> >
> >> -----Original Message-----
> >> From: Alex Deucher <alexdeucher@gmail.com>
> >> Sent: Thursday, May 20, 2021 11:47 AM
> >> To: Zhou, Peng Ju <PengJu.Zhou@amd.com>
> >> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhao, Victor
> >> <Victor.Zhao@amd.com>
> >> Subject: Re: [PATCH v5 09/10] drm/amdgpu: Use PSP to program
> >> IH_RB_CNTL* registers
> >>
> >> On Mon, May 17, 2021 at 10:39 AM Peng Ju Zhou <PengJu.Zhou@amd.com>
> >> wrote:
> >> >
> >> > use psp to program IH_RB_CNTL* if indirect access for ih enabled in
> >> > SRIOV environment.
> >> >
> >> > Signed-off-by: Victor <Victor.Zhao@amd.com>
> >> > Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> >> > ---
> >> >  drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 19 +++++++++++++++++--
> >> >  drivers/gpu/drm/amd/amdgpu/nv.c        |  2 +-
> >> >  2 files changed, 18 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> >> > b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> >> > index f4e4040bbd25..2e69cf8db072 100644
> >> > --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> >> > +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> >> > @@ -151,7 +151,14 @@ static int navi10_ih_toggle_ring_interrupts(struct
> >> amdgpu_device *adev,
> >> >         /* enable_intr field is only valid in ring0 */
> >> >         if (ih == &adev->irq.ih)
> >> >                 tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ?
> >> 1 : 0));
> >> > -       WREG32(ih_regs->ih_rb_cntl, tmp);
> >> > +       if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
> >> > +               if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
> >> > +                       DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
> >> > +                       return -ETIMEDOUT;
> >> > +               }
> >> > +       } else {
> >> > +               WREG32(ih_regs->ih_rb_cntl, tmp);
> >> > +       }
> >> >
> >> >         if (enable) {
> >> >                 ih->enabled = true;
> >> > @@ -261,7 +268,15 @@ static int navi10_ih_enable_ring(struct
> >> amdgpu_device *adev,
> >> >                 tmp = REG_SET_FIELD(tmp, IH_RB_CNTL,
> >> WPTR_OVERFLOW_ENABLE, 0);
> >> >                 tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABLE,
> >> 1);
> >> >         }
> >> > -       WREG32(ih_regs->ih_rb_cntl, tmp);
> >> > +
> >> > +       if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
> >> > +               if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
> >> > +                       DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
> >> > +                       return -ETIMEDOUT;
> >> > +               }
> >> > +       } else {
> >> > +               WREG32(ih_regs->ih_rb_cntl, tmp);
> >> > +       }
> >> >
> >> >         if (ih == &adev->irq.ih) {
> >> >                 /* set the ih ring 0 writeback address whether it's
> >> > enabled or not */ diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
> >> > b/drivers/gpu/drm/amd/amdgpu/nv.c index a9ad28fb55b3..b9c9c4d4606c
> >> > 100644
> >> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> >> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> >> > @@ -845,8 +845,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
> >> >         case CHIP_NAVI12:
> >> >                 amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
> >> >                 amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
> >> > -               amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
> >> >                 amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
> >> > +               amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
> >>
> >> Is it safe to change the order like this on bare metal?  Please look at what was
> >> done for vega and sienna cichlid.  Something like that is probably a better bet.
> >>
> >> Alex
> >>
> >>
> >> >                 if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
> >> >                         amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
> >> >                 if (adev->enable_virtual_display ||
> >> > amdgpu_sriov_vf(adev))
> >> > --
> >> > 2.17.1
> >> >
> >> > _______________________________________________
> >> > amd-gfx mailing list
> >> > amd-gfx@lists.freedesktop.org
> >> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> >> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> >> gfx&amp;data=04%7C01%7CPe
> >> >
> >> ngJu.Zhou%40amd.com%7Cabc8d955fb1f4deb9ce108d91b41ecbb%7C3dd89
> >> 61fe4884
> >> >
> >> e608e11a82d994e183d%7C0%7C0%7C637570792232990999%7CUnknown%7
> >> CTWFpbGZsb
> >> >
> >> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> >> %3D%
> >> >
> >> 7C1000&amp;sdata=HyDcZjT3c6mY%2F%2FYdjMuW1T%2FRUIzqX5kK9vaYus
> >> mZJxI%3D&
> >> > amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
