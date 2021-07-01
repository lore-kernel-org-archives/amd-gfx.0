Return-Path: <SRS0=TGuI=LZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C462C11F64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 15:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C07161374
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 15:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C07161374
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF82D6EB4D;
	Thu,  1 Jul 2021 15:57:46 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9ACD6EB4D
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jul 2021 15:57:45 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id 11so7825076oid.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Jul 2021 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=psB9xnbSWvF7j5xihYd+44fpXRZkFhx+Qe4ij00Mxg8=;
 b=RGhVKsBvyGZTCEz4x4AFDUmE7A/2NISrRsuOmsTxMTjR5GTZBztWckZFz/uzZJV8hc
 hscNjo2OzOJN1x2e4KqtCxhMMmJKFSu/3kP67gmcixKDHQSG6blRqNEMXY8gNa5rqDR+
 mf2G517Qkcru8WT0YROM31812S54dGfDLELlLVr1Li3IM4/NQP1rcn9wI31fPQghGV9L
 6chyOllBszgqdk0/C3z0TPddCjZuS+mKvDY7387SrxREJ+owuvkw26RAg0suxpKMN0QB
 vhT1yEOVFb9PR6frYlO8kC7mfXqc1VdiBqZ6Aj/diS1yfVsbpL44CC3DBWR6qVpEG6+0
 BL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=psB9xnbSWvF7j5xihYd+44fpXRZkFhx+Qe4ij00Mxg8=;
 b=VJ5b/k2HCUEQ5qTHruXQfgR6RMvTLXnjXhFQGKzMjHdt0BWlR087mRQBlVegmTX8KM
 XA6y45BmvHTrgEE0tmiCbCA+IdJQSBDDnnSIF6lCA86ED6YOxwIlKSxxGAYf1N5+/lIi
 QkZgylwtSvq4Yy7MaksTIjFdo0LBSGNPnZll+b5v1ulnN53beebcBdQwoHEbAAqQhmTF
 dptj0oaZhzthiGW5G2X/YXsesnxGxwGdgmkRoX1y2Op3jdxIqP49fJuJ/Rj2bl06nTFd
 aDYsgXP0IMAAWdAs1LUJSBLUCt0TrkynWaStmP4L861GdwaQi1EQJjnZUIafLeXOu6ER
 HqNA==
X-Gm-Message-State: AOAM5335Cs+oXZPtzZ1oLu6lNpWd040z8OEZAc/OyFzKWvEOQTpELmoI
 i4Jvrgwr0594D3jdHKlHDl9ym2MnynG1H65RkQY=
X-Google-Smtp-Source: ABdhPJz3AFYOZ/zuwXi0mrU8Tfw9/rE2EThNYmGsYCkzCdPsu8TknHW4D2tiqIzoaRmTERmq7acQ9Yf0Cd5zSHIc/4o=
X-Received: by 2002:aca:ac15:: with SMTP id v21mr1805863oie.5.1625155065095;
 Thu, 01 Jul 2021 08:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210701043743.10663-1-Emily.Deng@amd.com>
 <PH0PR12MB54175493FA2801261FDBD0358F009@PH0PR12MB5417.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54175493FA2801261FDBD0358F009@PH0PR12MB5417.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 1 Jul 2021 11:57:34 -0400
Message-ID: <CADnq5_PTUb8RgM1oJw19c=Q7g0LtBOTA8Sb2YXuucO4+0_oVxQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Correct the irq numbers for virtual ctrc
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Jul 1, 2021 at 5:18 AM Deng, Emily <Emily.Deng@amd.com> wrote:
>
> [AMD Official Use Only]
>
> Ping......
>
> >-----Original Message-----
> >From: Emily Deng <Emily.Deng@amd.com>
> >Sent: Thursday, July 1, 2021 12:38 PM
> >To: amd-gfx@lists.freedesktop.org
> >Cc: Deng, Emily <Emily.Deng@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
> >Subject: [PATCH] drm/amdgpu: Correct the irq numbers for virtual ctrc
> >
> >Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> >Signed-off-by: Victor <Victor.Zhao@amd.com>
> >---
> > drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> >b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> >index 33324427b555..7e0d8c092c7e 100644
> >--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> >+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> >@@ -766,7 +766,7 @@ static const struct amdgpu_irq_src_funcs
> >dce_virtual_crtc_irq_funcs = {
> >
> > static void dce_virtual_set_irq_funcs(struct amdgpu_device *adev)  {
> >-      adev->crtc_irq.num_types = AMDGPU_CRTC_IRQ_VBLANK6 + 1;
> >+      adev->crtc_irq.num_types = adev->mode_info.num_crtc;
> >       adev->crtc_irq.funcs = &dce_virtual_crtc_irq_funcs;  }
> >
> >--
> >2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
