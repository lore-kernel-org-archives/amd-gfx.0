Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C2FC28D13
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 14:07:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3218210E263;
	Thu, 25 Aug 2022 14:07:52 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7E7010E291
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 14:07:48 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-11d08d7ece2so18304315fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 07:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=8Iq0tx/HM55h6F/YDaUbNVARvca3hYdCseCJUEhn25M=;
 b=HWGuykZvcH9MezvCPb1MITuzbV+6pWBFWbg9WNSxgsyvjcI8Z6sR0AzsHAr4z53mEc
 AFiTJvu4ViC29jpWeR2F63NShFI4AUJvohSOG2ikHVKAXubBnQAoMSBrkg2NCY7BJF4r
 y7bz4mTz0ntaFIvtDD5URWf3lWsj9ThANfZVu/A2jpDbAFG+Y90rYahEZEBQ3pBvv4rp
 NoS0/Mb+dqORKBn5qMQT4Ub5EHqWzNen+onNd+tZKWU9k7eawP5x4EGgOJu1yaAlYpwv
 n7ANo9K4RjQETplRBDxmJLaJH9cxU5GIj8MTMXGLqoSHuwt0XZa0u7ON/SL0jpMYs/N+
 K7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=8Iq0tx/HM55h6F/YDaUbNVARvca3hYdCseCJUEhn25M=;
 b=gRWpeWISuUcuJqRzJjGs++NyKhAorQQ7BVPeSHOH4eHLVvo/C9ZAq0e4IqalAzP6Es
 0hHMnhsXf8zdYYzNE8KY3POdJ3uPsjq+fPmWpDyllyimrE2FIXk/zGDrxhJvBxYERFNk
 6idCU7ymUWdIDZmHa7m3nZgj8b1aCser1tQMb9v8DMLwaFzOz7/9btEM77SmOiaw2djY
 bNAlmNU2LMDEnx+ht1o5aNJfbltCZcnvMILezK2BLQlzB9fdsRf6Uq0hIp+uSF2iDVOF
 h/tBEAhjdwKuczu4gKyrso/q9oKEqeCRMAJ1gPPUKRv4EUeglsR6OYWLfuoU+OP0lByn
 eUYg==
X-Gm-Message-State: ACgBeo0uk4cI1I64bH2aXV/TI2ip1829elG4hkA2V3yo49ajyVVOT/eu
 +Ukc9vMurHWcOGvsK7Co6hYOdwkn4tFnmZKdp2E=
X-Google-Smtp-Source: AA6agR7XRk38wt5YMxtihm7PvMzrwZufHQZqNdlD9dfmSCIogOJ8N3A/XJfr8XgsqjPrXUAnuglDdlWYXscvP98YDFg=
X-Received: by 2002:a05:6870:3484:b0:11e:4465:3d9b with SMTP id
 n4-20020a056870348400b0011e44653d9bmr431164oah.46.1661436468116; Thu, 25 Aug
 2022 07:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220825085820.1228641-1-lijo.lazar@amd.com>
 <20220825085820.1228641-2-lijo.lazar@amd.com>
 <CADnq5_NDpBBZnozvo7_X2BNqjZ=W3XkyHAQeVio2LLCJAwwFAQ@mail.gmail.com>
In-Reply-To: <CADnq5_NDpBBZnozvo7_X2BNqjZ=W3XkyHAQeVio2LLCJAwwFAQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Aug 2022 10:07:36 -0400
Message-ID: <CADnq5_NHZ3poJmJyzHGxBEZB3tv1TbrkfCp3R95ybXvnw6tssA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Init VF's HDP flush reg offset early
To: Lijo Lazar <lijo.lazar@amd.com>
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
Cc: Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org, tseewald@gmail.com,
 helgaas@kernel.org, Alexander.Deucher@amd.com, sr@denx.de,
 Christian.Koenig@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 25, 2022 at 9:22 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Series is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>

Actually, hold off on that, I have a comment on patch 1.

Alex

> On Thu, Aug 25, 2022 at 4:58 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
> >
> > Make sure the register offsets used for HDP flush in VF is
> > initialized early so that it works fine during any early HDP flush
> > sequence. For that, move the offset initialization to *_remap_hdp.
> >
> > Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c     | 23 +++++++++++++--------
> >  drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c     | 12 +++++++----
> >  drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c     | 23 +++++++++++++--------
> >  drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c     | 21 ++++++++++++-------
> >  drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c     | 24 ++++++++++++++--------
> >  drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c     | 23 +++++++++++++--------
> >  7 files changed, 84 insertions(+), 44 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 53d753e94a71..c0bb2e9616c5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2382,7 +2382,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
> >                          * to process space. This is needed for any early HDP
> >                          * flush operation during gmc initialization.
> >                          */
> > -                       if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
> > +                       if (adev->nbio.funcs->remap_hdp_registers)
> >                                 adev->nbio.funcs->remap_hdp_registers(adev);
> >
> >                         r = adev->ip_blocks[i].version->funcs->hw_init((void *)adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> > index b465baa26762..20fa2c5ad510 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> > @@ -65,10 +65,21 @@
> >
> >  static void nbio_v2_3_remap_hdp_registers(struct amdgpu_device *adev)
> >  {
> > -       WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
> > -               adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
> > -       WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
> > -               adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
> > +       if (amdgpu_sriov_vf(adev))
> > +               adev->rmmio_remap.reg_offset =
> > +                       SOC15_REG_OFFSET(
> > +                               NBIO, 0,
> > +                               mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL)
> > +                       << 2;
> > +
> > +       if (!amdgpu_sriov_vf(adev)) {
> > +               WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
> > +                            adev->rmmio_remap.reg_offset +
> > +                                    KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
> > +               WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
> > +                            adev->rmmio_remap.reg_offset +
> > +                                    KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
> > +       }
> >  }
> >
> >  static u32 nbio_v2_3_get_rev_id(struct amdgpu_device *adev)
> > @@ -338,10 +349,6 @@ static void nbio_v2_3_init_registers(struct amdgpu_device *adev)
> >
> >         if (def != data)
> >                 WREG32_PCIE(smnPCIE_CONFIG_CNTL, data);
> > -
> > -       if (amdgpu_sriov_vf(adev))
> > -               adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
> > -                       mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
> >  }
> >
> >  #define NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT         0x00000000 // off by default, no gains over L1
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> > index 982a89f841d5..e011d9856794 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> > @@ -30,10 +30,14 @@
> >
> >  static void nbio_v4_3_remap_hdp_registers(struct amdgpu_device *adev)
> >  {
> > -       WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
> > -               adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
> > -       WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
> > -               adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
> > +       if (!amdgpu_sriov_vf(adev)) {
> > +               WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
> > +                            adev->rmmio_remap.reg_offset +
> > +                                    KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
> > +               WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
> > +                            adev->rmmio_remap.reg_offset +
> > +                                    KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
> > +       }
> >  }
> >
> >  static u32 nbio_v4_3_get_rev_id(struct amdgpu_device *adev)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> > index f7f6ddebd3e4..7536ca3fcd69 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> > @@ -55,10 +55,21 @@
> >
> >  static void nbio_v6_1_remap_hdp_registers(struct amdgpu_device *adev)
> >  {
> > -       WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
> > -               adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
> > -       WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
> > -               adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
> > +       if (amdgpu_sriov_vf(adev))
> > +               adev->rmmio_remap.reg_offset =
> > +                       SOC15_REG_OFFSET(
> > +                               NBIO, 0,
> > +                               mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL)
> > +                       << 2;
> > +
> > +       if (!amdgpu_sriov_vf(adev)) {
> > +               WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
> > +                            adev->rmmio_remap.reg_offset +
> > +                                    KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
> > +               WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
> > +                            adev->rmmio_remap.reg_offset +
> > +                                    KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
> > +       }
> >  }
> >
> >  static u32 nbio_v6_1_get_rev_id(struct amdgpu_device *adev)
> > @@ -276,10 +287,6 @@ static void nbio_v6_1_init_registers(struct amdgpu_device *adev)
> >
> >         if (def != data)
> >                 WREG32_PCIE(smnPCIE_CI_CNTL, data);
> > -
> > -       if (amdgpu_sriov_vf(adev))
> > -               adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
> > -                       mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
> >  }
> >
> >  static void nbio_v6_1_program_ltr(struct amdgpu_device *adev)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
> > index aa0326d00c72..6b4ac16a8466 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
> > @@ -35,10 +35,20 @@
> >
> >  static void nbio_v7_0_remap_hdp_registers(struct amdgpu_device *adev)
> >  {
> > -       WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
> > -               adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
> > -       WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
> > -               adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
> > +       if (amdgpu_sriov_vf(adev))
> > +               adev->rmmio_remap.reg_offset =
> > +                       SOC15_REG_OFFSET(NBIO, 0,
> > +                                        mmHDP_MEM_COHERENCY_FLUSH_CNTL)
> > +                       << 2;
> > +
> > +       if (!amdgpu_sriov_vf(adev)) {
> > +               WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
> > +                            adev->rmmio_remap.reg_offset +
> > +                                    KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
> > +               WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
> > +                            adev->rmmio_remap.reg_offset +
> > +                                    KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
> > +       }
> >  }
> >
> >  static u32 nbio_v7_0_get_rev_id(struct amdgpu_device *adev)
> > @@ -273,9 +283,6 @@ const struct nbio_hdp_flush_reg nbio_v7_0_hdp_flush_reg = {
> >
> >  static void nbio_v7_0_init_registers(struct amdgpu_device *adev)
> >  {
> > -       if (amdgpu_sriov_vf(adev))
> > -               adev->rmmio_remap.reg_offset =
> > -                       SOC15_REG_OFFSET(NBIO, 0, mmHDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
> >  }
> >
> >  const struct amdgpu_nbio_funcs nbio_v7_0_funcs = {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> > index 31776b12e4c4..fb4be72eade7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> > @@ -49,10 +49,21 @@
> >
> >  static void nbio_v7_2_remap_hdp_registers(struct amdgpu_device *adev)
> >  {
> > -       WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
> > -               adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
> > -       WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
> > -               adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
> > +       if (amdgpu_sriov_vf(adev))
> > +               adev->rmmio_remap.reg_offset =
> > +                       SOC15_REG_OFFSET(
> > +                               NBIO, 0,
> > +                               regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL)
> > +                       << 2;
> > +
> > +       if (!amdgpu_sriov_vf(adev)) {
> > +               WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
> > +                            adev->rmmio_remap.reg_offset +
> > +                                    KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
> > +               WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
> > +                            adev->rmmio_remap.reg_offset +
> > +                                    KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
> > +       }
> >  }
> >
> >  static u32 nbio_v7_2_get_rev_id(struct amdgpu_device *adev)
> > @@ -369,6 +380,7 @@ const struct nbio_hdp_flush_reg nbio_v7_2_hdp_flush_reg = {
> >  static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
> >  {
> >         uint32_t def, data;
> > +
> >         switch (adev->ip_versions[NBIO_HWIP][0]) {
> >         case IP_VERSION(7, 2, 1):
> >         case IP_VERSION(7, 3, 0):
> > @@ -393,10 +405,6 @@ static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
> >                         WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CONFIG_CNTL), data);
> >                 break;
> >         }
> > -
> > -       if (amdgpu_sriov_vf(adev))
> > -               adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
> > -                       regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
> >  }
> >
> >  const struct amdgpu_nbio_funcs nbio_v7_2_funcs = {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> > index 11848d1e238b..3c11af99582f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> > @@ -101,10 +101,21 @@ static void nbio_v7_4_query_ras_error_count(struct amdgpu_device *adev,
> >
> >  static void nbio_v7_4_remap_hdp_registers(struct amdgpu_device *adev)
> >  {
> > -       WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
> > -               adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
> > -       WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
> > -               adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
> > +       if (amdgpu_sriov_vf(adev))
> > +               adev->rmmio_remap.reg_offset =
> > +                       SOC15_REG_OFFSET(
> > +                               NBIO, 0,
> > +                               mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL)
> > +                       << 2;
> > +
> > +       if (!amdgpu_sriov_vf(adev)) {
> > +               WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
> > +                            adev->rmmio_remap.reg_offset +
> > +                                    KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
> > +               WREG32_SOC15(NBIO, 0, mmREMAP_HDP_REG_FLUSH_CNTL,
> > +                            adev->rmmio_remap.reg_offset +
> > +                                    KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
> > +       }
> >  }
> >
> >  static u32 nbio_v7_4_get_rev_id(struct amdgpu_device *adev)
> > @@ -343,10 +354,6 @@ static void nbio_v7_4_init_registers(struct amdgpu_device *adev)
> >  {
> >         uint32_t baco_cntl;
> >
> > -       if (amdgpu_sriov_vf(adev))
> > -               adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
> > -                       mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
> > -
> >         if (adev->ip_versions[NBIO_HWIP][0] == IP_VERSION(7, 4, 4) &&
> >             !amdgpu_sriov_vf(adev)) {
> >                 baco_cntl = RREG32_SOC15(NBIO, 0, mmBACO_CNTL);
> > --
> > 2.25.1
> >
