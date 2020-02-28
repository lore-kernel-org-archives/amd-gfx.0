Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D61C3F2D2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 22:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B181D20637
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 22:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMijP3dG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B181D20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 610B56F50C;
	Fri, 28 Feb 2020 22:25:26 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7B216F50C
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 22:25:24 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id a141so5015460wme.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 14:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aF2aJyuvvTQuT5Yl5IlpYF+PKSKuzBGPNR0RRCHfSyE=;
 b=UMijP3dGnLH0Io7tAF7I8H2+a9oHXHHBQc/B446M2cE+aAcjtahgPh5qlAPQOFEmqT
 PBCLjCcClh8KLJcU0qtPuOD1qYEFaPTDIYu2WboLCUFJ0BWcss2NGUXnux14oC8tdp02
 AtiJh4EhP75KSfgCYtIO7uvOzLkppZGScCarVjjATlxJ/4AhEEsTIEgJ3daL1zUiZi99
 iSTG8QMu9WoyJlSArJ5VvmIvreUlagf8CROj+nzy7Pxv5FeCAKvJ5w6i8xDEoncFvmpH
 gLeRwual2uTwfFS/tFN+LD+q+KDBmiRYhuWzflSN7fVK+HeHYzk3MVcMgdo8JpprRUO7
 E5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aF2aJyuvvTQuT5Yl5IlpYF+PKSKuzBGPNR0RRCHfSyE=;
 b=nXB7xtHrSmM0v0RX+KlrS8yBe+bnTvV6ZlZrXla3Kw5NyUe33nX6xjGws9nMj3eWVH
 WhU8lYnWhkEHoKIZ8PusXCjYtooIPcOk+qv2S4WnMQWtFqciiwEsN9m+kP4aSMH5uM4I
 pDrIYkgv2aKtoznWDTaYyy5QBHDxz+cv7IUBCfACMDjvt+32YbNlI9CgjYFWSBXxjp8Z
 m2EGe90QU9zjvQsKiDKHy/86dyCZ5ug88+As4i1q9WKuiRX3Vph+OoRQxJR5TeEAsgvq
 NTz5ZrZ1RlFIgADxsO9Gomu6qUKdrZ5pNtGQ2SS/7wSsCFtkTyPc0PdKSAclgPzh3eaR
 MjAQ==
X-Gm-Message-State: APjAAAUZZHAsonVZ3iGFKpQeWL6/0nSLdZ6t+D8VrSy1Lyj2RlzTuZsX
 QwDhRtmFHcuDP81KI8NSwOezhnczwu+2efSSNzmdfw==
X-Google-Smtp-Source: APXvYqxYE/hjSqERv1tj0urbFkC7/8umE/kA7MUauldzYOiQ7RdpulLOcdkyiP8mvt8Kz9ler15Pn6D6xWa5Faa7yfg=
X-Received: by 2002:a05:600c:218b:: with SMTP id
 e11mr6826873wme.56.1582928723549; 
 Fri, 28 Feb 2020 14:25:23 -0800 (PST)
MIME-Version: 1.0
References: <20200228105833.2jdsy7sxpeoo3lvy@kili.mountain>
 <e425f3fd-a517-c10b-aab4-05d8315983de@amd.com>
In-Reply-To: <e425f3fd-a517-c10b-aab4-05d8315983de@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Feb 2020 17:25:12 -0500
Message-ID: <CADnq5_MkjfdaVe=7=sZhvAYUVMgNk1fHQb7VBcMSwsCXzc2jeA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Fix dmub_psr_destroy()
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Wyatt Wood <wyatt.wood@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Fri, Feb 28, 2020 at 8:08 AM Kazlauskas, Nicholas
<nicholas.kazlauskas@amd.com> wrote:
>
> On 2020-02-28 5:58 a.m., Dan Carpenter wrote:
> > This is freeing the wrong variable so it will crash.  It should be
> > freeing "*dmub" instead of "dmub".
> >
> > Fixes: 4c1a1335dfe0 ("drm/amd/display: Driverside changes to support PSR in DMCUB")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>
> Thanks!
>
> > ---
> >   drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> > index 2c932c29f1f9..f0936cb3c056 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> > @@ -235,6 +235,6 @@ struct dmub_psr *dmub_psr_create(struct dc_context *ctx)
> >    */
> >   void dmub_psr_destroy(struct dmub_psr **dmub)
> >   {
> > -     kfree(dmub);
> > +     kfree(*dmub);
> >       *dmub = NULL;
> >   }
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
