Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14255C2D0E4
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 18:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814842222F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 18:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUNzmGMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814842222F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A71516E102;
	Thu, 12 Nov 2020 18:57:16 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2D966E102
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 18:57:15 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id l1so7133766wrb.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 10:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WQX+DGrPqq+2cmuCZCxKpbXgj6MGwkZbVsaMRNcopyU=;
 b=tUNzmGMoPkXY5HpxIPrDqgr2Nhfu3qpmEG/uDAJlWP2BqResLDu9/j7GEsWsFPmV6K
 1pJHJb1HRP0IP8uWt0FUMxIr/4BQ59Q71exdWwSCUgHQPP51Pyfhph/CIhxbQNBTwFeB
 PNZI6gA6RZD1D875+VtUq5UZTQWhK6Gua7kh+kHmgfBHGzDeZ6k8nefAHTLSdRpmK1IV
 2/aCPKv0azw3CZl+Ilntp207UJwvVezyNMwVHHO+pKg5SDoYwqlTJzQCM2Zq4tbSY8c8
 NrNzPa1F5TMEJBPn3HQpLuw/4zuUhhx4nAoiOVQbLawpDm1Ulg0Cc5JE0d2yFXCfcu2l
 gNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WQX+DGrPqq+2cmuCZCxKpbXgj6MGwkZbVsaMRNcopyU=;
 b=h8RXIsaFb3z2+8znYXb1N1cXOYXw0WylnIr8BdsfRYte812CBjdJyxXb/WOQ0RLC+G
 LyhT58CjL9BEQfW6NCBbDYkQuOej1xMGrmexdGl2ahXHMo8db3Uf1OU4pq/Eq7ciImAr
 0ES6ayhGzjAryBAFfOcVlioeoWike5czG9c1vJIn+LBj5xQGKyrS9GyJ5/chQrqBBJ84
 ECxhDKz6yclVzI+OmMQQLB0ui1eX/zg4mO2r3RTFjA8UL1WwvOfQeNktAc4AF1ueFDHH
 i8ays5NMzLUPKJ0ulkOJA7NEk2d59+aLcd0nirAMVRlZsLiAwOey+VaYDuu9zClCP6j3
 eABg==
X-Gm-Message-State: AOAM531dlXB5wYd8iVxOly9eJPQDGdlG9Vaesr8Z2e0OkZkHOh5zvn39
 bmmopR+FBoJ1YqDn34utgMLt1JSi5VVEmeRaVJ8=
X-Google-Smtp-Source: ABdhPJzV/gEGh7s0tRadAPFI4CelaYCbw2t780ubDb31tPgO3UoLAeW6oyhMfSqtq8P2UYWUjni77yOWRxOfbWoE70A=
X-Received: by 2002:adf:ce87:: with SMTP id r7mr1110685wrn.212.1605207434578; 
 Thu, 12 Nov 2020 10:57:14 -0800 (PST)
MIME-Version: 1.0
References: <1605133674-21093-1-git-send-email-James.Zhu@amd.com>
 <CADnq5_OuXH4iWR7baRsUDTO3BMe=TditrXgCqvzC1U_pb27saQ@mail.gmail.com>
 <9971c116-faf9-7ebe-0b59-4ff1b5cd25ae@amd.com>
In-Reply-To: <9971c116-faf9-7ebe-0b59-4ff1b5cd25ae@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Nov 2020 13:57:03 -0500
Message-ID: <CADnq5_O957h_HosBL=mMhwrY+0xkFvZypCVgnsJZ4e2gq1Xbpg@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amdgpu: add vcn dec software ring enabled
 parameter
To: James Zhu <jamesz@amd.com>
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
Cc: James Zhu <James.Zhu@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 12, 2020 at 10:23 AM James Zhu <jamesz@amd.com> wrote:
>
>
> On 2020-11-12 9:23 a.m., Alex Deucher wrote:
> > On Wed, Nov 11, 2020 at 5:28 PM James Zhu <James.Zhu@amd.com> wrote:
> >> This allows us to enable dec software ring feature on VCN.
> >> The default is 0 for all asics, and it is only valid for
> >> asics with vcn3.0 and above.
> >>
> >> Signed-off-by: James Zhu <James.Zhu@amd.com>
> >> Reviewed-by: Leo Liu <leo.liu@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
> >>   2 files changed, 9 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> index 20400ec..cc47da6 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> @@ -209,6 +209,7 @@ extern int amdgpu_si_support;
> >>   extern int amdgpu_cik_support;
> >>   #endif
> >>   extern int amdgpu_num_kcq;
> >> +extern int amdgpu_dec_sw_ring_enabled;
> >>
> >>   #define AMDGPU_VM_MAX_NUM_CTX                  4096
> >>   #define AMDGPU_SG_THRESHOLD                    (256*1024*1024)
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> index 999f84d..570088f 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> @@ -160,6 +160,7 @@ int amdgpu_force_asic_type = -1;
> >>   int amdgpu_tmz;
> >>   int amdgpu_reset_method = -1; /* auto */
> >>   int amdgpu_num_kcq = -1;
> >> +int amdgpu_dec_sw_ring_enabled;
> >>
> >>   struct amdgpu_mgpu_info mgpu_info = {
> >>          .mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
> >> @@ -806,6 +807,13 @@ module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
> >>   MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
> >>   module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
> >>
> >> +/**
> >> + * DOC: dec_sw_ring_enabled (uint)
> >> + * Override vcn decode software ring features enabled.
> >> + */
> >> +MODULE_PARM_DESC(dec_sw_ring_enabled, "vcn dec sw ring support (1 = enable, 0 = disable (default))");
> >> +module_param_named(dec_sw_ring_enabled, amdgpu_dec_sw_ring_enabled, int, 0444);
> > How about just vcn_sw_ring as the parameter name?
> [JZ] It is for decode ring only. if just use vcn_sw_ring. I am not sure
> if it will confuse people.

Are we intending to have a separate enable option for enc?  If so, is
there value in that vs just having one knob for both?

Alex


> >
> >> +
> >>   static const struct pci_device_id pciidlist[] = {
> >>   #ifdef  CONFIG_DRM_AMDGPU_SI
> >>          {0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
> >> --
> >> 2.7.4
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJames.Zhu%40amd.com%7C6a8168ed39b74d9a0a8f08d88716a006%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637407878530324835%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=egZMRoAdhY%2FRQAVENCT5CEVivi%2Fdzsn%2BUxPrnHJRKzU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
