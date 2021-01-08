Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375E6C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 15:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C411A23718
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 15:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C411A23718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E2666E804;
	Fri,  8 Jan 2021 15:14:28 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 477036E804
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 15:14:27 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id j8so2453787oon.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 07:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JZg8lbYDedRv4ato5A7403AMtfRbJTE9O20vF1ZKNSs=;
 b=BlKD5pWmvCro0hvaljfP3vjhLyaMzL557Lhn7j684p/DQtpOdhZ6OALk11Cy9I6Lho
 JugpCtfXFJR83VrA8+tc0WqZGGbC3qrlNIrPY8Ps5ubtDGCUhIRN7i9DKODK9mM77PRC
 MUHcQqSyeP/Cqf4BkhiFzzMptnj+daGjltG/j96sFUAEHfQiWDAED5IRmfsSU//M8mIl
 S3eVQZ87ZdB1t6p3zTJfPgECQIVNnkOu6q3VE8jkWGnrvhFJbNEXH0fMpjaMnIKSs5hV
 U2+wIQiTEqOxNO26+pnHWqNxeWHIGTwgly1IkmW2z96QDbSQYKXd6NaFOhxv5dzY1dRU
 3ODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JZg8lbYDedRv4ato5A7403AMtfRbJTE9O20vF1ZKNSs=;
 b=A2mEJeG79iGBB5tpScYAbhbcsgAl0+YHCqBt3IM2LRbz5o1TMaHDL88JMcSGvQ1kK2
 4Ck2DNesbZPflBqPA1YEofyDlPLC/pvz/duFnTJdzIrmxQIMLs6hH6N/nJeN/qWENh/T
 JqHBbFO3UAK+7QfUiUlBc+Iy3x4UHHI+5jdq765DeuFNnJ4NcQNkxVMjdF11bkpNnX9C
 tlT7FHrybDpkvLGVUIHy4PwX6kk4JUfGABfNPXcgAeeLkwiLnsegxFePsR0KEd49l/q1
 MEaVJ8BbXDD1E5WgspzojNG87gTGzjSl80mvrsKJtv/bUQhHmVOsEQ2JoxI+tantUgLq
 81Ug==
X-Gm-Message-State: AOAM531U+GGzVJSdIs2MJftT2vsMbojl38P1kSlh59i0AIRqCGcy47nw
 LlKz4lJXlaPsbO8mnHViXFvyH7anj299Z3JzNAc=
X-Google-Smtp-Source: ABdhPJzvbBV2P49Lkr1e7nI4JG0g/UDPjgyIGQn3zMVQFSwOp3WKK4FB22me074a/nUy8V1eR9GSnlw8bG09SqFx0zo=
X-Received: by 2002:a4a:330b:: with SMTP id q11mr4616072ooq.90.1610118866630; 
 Fri, 08 Jan 2021 07:14:26 -0800 (PST)
MIME-Version: 1.0
References: <20210107032927.660772-1-Emily.Deng@amd.com>
 <BY5PR12MB4115BE023BAF8FE53E2070158FAE0@BY5PR12MB4115.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB4115BE023BAF8FE53E2070158FAE0@BY5PR12MB4115.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Jan 2021 10:14:15 -0500
Message-ID: <CADnq5_N0hYURmnApHxhk3xmY426jyRNCBn97JoNxAq8t3f=Ojw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu:Limit the resolution for virtual_display
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

On Thu, Jan 7, 2021 at 8:45 PM Deng, Emily <Emily.Deng@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Ping ......
>

It's not clear what problem this solves.

Alex


> Best wishes
> Emily Deng
>
>
>
> >-----Original Message-----
> >From: Emily Deng <Emily.Deng@amd.com>
> >Sent: Thursday, January 7, 2021 11:29 AM
> >To: amd-gfx@lists.freedesktop.org
> >Cc: Deng, Emily <Emily.Deng@amd.com>
> >Subject: [PATCH v2] drm/amdgpu:Limit the resolution for virtual_display
> >
> >From: "Emily.Deng" <Emily.Deng@amd.com>
> >
> >Limit the resolution not bigger than 16384, which means
> >dev->mode_info.num_crtc * common_modes[i].w not bigger than 16384.
> >
> >v2:
> >  Refine the code
> >
> >Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
> >---
> > drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 7 +++++--
> > 1 file changed, 5 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> >b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> >index 2b16c8faca34..fd2b3a6dfd60 100644
> >--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> >+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> >@@ -319,6 +319,7 @@ dce_virtual_encoder(struct drm_connector
> >*connector)  static int dce_virtual_get_modes(struct drm_connector
> >*connector)  {
> > struct drm_device *dev = connector->dev;
> >+struct amdgpu_device *adev = dev->dev_private;
> > struct drm_display_mode *mode = NULL;
> > unsigned i;
> > static const struct mode_size {
> >@@ -350,8 +351,10 @@ static int dce_virtual_get_modes(struct
> >drm_connector *connector)
> > };
> >
> > for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
> >-mode = drm_cvt_mode(dev, common_modes[i].w,
> >common_modes[i].h, 60, false, false, false);
> >-drm_mode_probed_add(connector, mode);
> >+if (adev->mode_info.num_crtc * common_modes[i].w <=
> >16384) {
> >+mode = drm_cvt_mode(dev, common_modes[i].w,
> >common_modes[i].h, 60, false, false, false);
> >+drm_mode_probed_add(connector, mode);
> >+}
> > }
> >
> > return 0;
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
