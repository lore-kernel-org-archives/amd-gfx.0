Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6901C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 16:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E5860FC1
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 16:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 87E5860FC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16EE66E3D6;
	Wed, 25 Aug 2021 16:49:11 +0000 (UTC)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFD596E3CE;
 Wed, 25 Aug 2021 16:49:09 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 t2-20020a4ae9a2000000b0028c7144f106so8221ood.6; 
 Wed, 25 Aug 2021 09:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0PnOjcm9Fuu9oRLVmMOTan/jdn80kkK21Ga9ki6Awwk=;
 b=oLKBYXOX8Zl+nQIQ14XImUuWQDtAypiP2IN8YZ51Fwze2diqVC9UNIFVWk6OBBzEy4
 yi8ypOx5PPoYDrOalicVkFtXLnmzo7MOKuVAKUDCC509ce6bcN7HA+yTIjxZWRwpQPEj
 KgpFu0POrV2wkwhXSReVmSi/UADcgH8GPIiA+BM60Gmjc3RaMwoKlfUty1Isj/SlfIN+
 9ZNlcqEhis7iVsoL2PHQ7gQTQB/MZ2jco6pv08+KJDaN2HLmF73HnE9o657+z2oIYSS5
 MhI4oEU0I2a8ObpWDWd//HUEpCnag3hF9Bx17N4KR6cV088YU5BcaXhiE1yJHD28G2O1
 mgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0PnOjcm9Fuu9oRLVmMOTan/jdn80kkK21Ga9ki6Awwk=;
 b=ESvnn8KSr5mF/gVjiTFh8Ocur+NjuDp9RAGj8WouE+ZUwA3eNJNfsKi2W9dURvc9SW
 mAcSbkVngGOhNLarGP0ECWN0W0BXh4+kjYThcFcOQUhMwqIsEBqoBkxT2nWcDPO9TuBT
 Ebco9Flpn7G957REV7dMOQUvZ3bt9t01l+LydrnfbuDeMZkckvVZBA4cQmxcGLTIueSo
 ycDOu8U3ewBzKtb5u+k3t9M/fmi5ndqDUL9W4+3DsZ1pn2ZCMaJbr1T82L3KsWwJ1aDw
 9cucHIOAdt8yuHgIWulQZu1s0t/ByHZ83sqzWDLcmh5A2FvjpCzbBBYu73v8DZK+GrMT
 F6YA==
X-Gm-Message-State: AOAM533lVHUQu98KOhO+NX/7+9m34c9G3WQCd6GBJlHGYePX8AwQkRCn
 uDabhTcMkvgRsxU4Hf6G0RDhbxGMnPUiUGIVKnU=
X-Google-Smtp-Source: ABdhPJxtlTki/sGBLa9DFM+o5O7lTh25DEiF6j7B6Xps5jPXQTiyNItJ0IZv26fJlktcUUknHJZV96yu5azfwgaPN+4=
X-Received: by 2002:a4a:ba86:: with SMTP id d6mr35250933oop.61.1629910148947; 
 Wed, 25 Aug 2021 09:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210825113615.14555-1-colin.king@canonical.com>
 <feed4359-c682-bb13-5584-6f34bb9960eb@amd.com>
In-Reply-To: <feed4359-c682-bb13-5584-6f34bb9960eb@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Aug 2021 12:48:57 -0400
Message-ID: <CADnq5_OTr97_PXPENkT2aZs9xAueFt=2wreDQh9U-MB_zR2c9g@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: fix spelling mistake "alidation"
 -> "validation"
To: Harry Wentland <harry.wentland@amd.com>
Cc: Colin King <colin.king@canonical.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 xinhui pan <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
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

Applied.  Thanks!

Alex

On Wed, Aug 25, 2021 at 10:09 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2021-08-25 7:36 a.m., Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There is a spelling mistake in a DC_LOG_WARNING message. Fix it.
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> > index 3223a1ff2292..91cbc0922ad4 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> > @@ -1999,7 +1999,7 @@ bool dcn31_validate_bandwidth(struct dc *dc,
> >       goto validate_out;
> >
> >  validate_fail:
> > -     DC_LOG_WARNING("Mode Validation Warning: %s failed alidation.\n",
> > +     DC_LOG_WARNING("Mode Validation Warning: %s failed validation.\n",
> >               dml_get_status_message(context->bw_ctx.dml.vba.ValidationStatus[context->bw_ctx.dml.vba.soc.num_states]));
> >
> >       BW_VAL_TRACE_SKIP(fail);
> >
>
