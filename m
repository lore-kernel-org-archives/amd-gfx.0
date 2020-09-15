Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F971C43461
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 19:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 168FB206DB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 19:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEQyiLWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168FB206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 831CF6E8B9;
	Tue, 15 Sep 2020 19:44:25 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A136E14C;
 Tue, 15 Sep 2020 19:44:23 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id m6so4594194wrn.0;
 Tue, 15 Sep 2020 12:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Cc84912ps9QzBUrSER3j4GRi1EEaiC0ms1w3qlDFryQ=;
 b=aEQyiLWSOdLI4o7RIrCD77KLfP9RTLKwjeaNeEcI7p0ufgj6Cwg0oD/xgFdaGhYEeK
 teKZXHaAOcOo3CTdOaCNr4PUxQplO9fazQEU/d617gbFnAU7lVzHq9wnWNtakwC2b9G4
 CaBh6qEHyRCvuew+3cabF3oISRn4cepWn/+gmlYYwGHDPdSijPs45RdJs43GbthH7EHF
 J5Ez3dnqQcrxn79ysb3lfe4qGZQUM80N6Hfy0rbbJvOH1IyOkDx59k3tJrSTJNJ59BRE
 R3ExEmZ6iiRzrZ0jNdn3idP7zl/u3JbFLZUkMJfjzl9xZbh/+8328HvAJhp2+U9/JRep
 SYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Cc84912ps9QzBUrSER3j4GRi1EEaiC0ms1w3qlDFryQ=;
 b=GnryJ2S3et9J93Cfvri6iUQDo3PC1zie88iMPxh5Jl+PZ/+WFi3s3qsCzKVlTms3kX
 PZxIIifIwKsN3HTBgsbZCCeesi9VnbOITPkv3y3exe5jmaRCAaq4ECx15G3aPQVk9Z0n
 IuZh3Id7X/0ACb9ydHJo8PnUx1Yaf//tCdgVHp6fD+oVqoaYiZwHWy0ffw9tLC1h8qZB
 pU2ipvvjO2m5C32BdkSpdnh4OpSv1IZoMLPBcDQ3U4tWsXlNhRzIs1urVEBESJa5CpV1
 cUym7dM63fgG+C9pa1BI1fff62fYKb9Q18a4+FguXvnHfsH4Cb2vDGB+8vasb2zoL+04
 YZWw==
X-Gm-Message-State: AOAM531+3Ku5dLK2ANxQs6qhNvAeGtKQaeZCYb6L/SwqflktU/upf9JM
 12VoOCLHPnLQpW29ADfQ28cg8DDriWiOPI/DCJXH4y8Z
X-Google-Smtp-Source: ABdhPJzOePrptUE3RAcwh0Ybv8+dGJ8Y7Ir6h24d+B4f9X84uHxDb5x1cF2UQnnahPWpshF4Qeh6SmHVUxzfyYLHFhk=
X-Received: by 2002:adf:dd82:: with SMTP id x2mr24399319wrl.419.1600199062537; 
 Tue, 15 Sep 2020 12:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200910032636.27296-1-yuehaibing@huawei.com>
 <62c4312b-9e92-23bb-0823-7f1aca125c0f@amd.com>
In-Reply-To: <62c4312b-9e92-23bb-0823-7f1aca125c0f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2020 15:44:11 -0400
Message-ID: <CADnq5_OTqZFZ9urP+aUK+KNuvSpkNSM2m0E4=DZYn4d+uaTS2w@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Fix possible memleak in
 dp_trigger_hotplug()
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: Eryk Brol <eryk.brol@amd.com>, "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 YueHaibing <yuehaibing@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Lipski,
 Mikita" <mikita.lipski@amd.com>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks,

Alex

On Thu, Sep 10, 2020 at 11:34 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2020-09-09 11:26 p.m., YueHaibing wrote:
> > If parse_write_buffer_into_params() fails, we should free
> > wr_buf before return.
> >
> > Fixes: 6f77b2ac6280 ("drm/amd/display: Add connector HPD trigger debugfs entry")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > index 83da24aced45..11e16fbe484d 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > @@ -1089,8 +1089,10 @@ static ssize_t dp_trigger_hotplug(struct file *f, const char __user *buf,
> >       if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> >                                               (long *)param, buf,
> >                                               max_param_num,
> > -                                             &param_nums))
> > +                                             &param_nums)) {
> > +             kfree(wr_buf);
> >               return -EINVAL;
> > +     }
> >
> >       if (param_nums <= 0) {
> >               DRM_DEBUG_DRIVER("user data not be read\n");
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
