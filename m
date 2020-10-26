Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F09C4363A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 17:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C09921D42
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 17:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urEx+43S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C09921D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A756EA46;
	Mon, 26 Oct 2020 17:36:05 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93AA66EA46
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 17:36:04 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id g12so13624093wrp.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 10:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ONnwdTXAi0KqD4xgCehz6fs98mVhVUYkVg/AFYIduFw=;
 b=urEx+43SCJJTaQloBBvQvVlhKsZ3Zpq9BfNcGvQP4Dj+2NW4569Q//Lw17hpyPBMtB
 FKIhwhPMRf2excZuVru5cDa2aFgHJnl2GGG8dSBkoe1EH3s20AFZqnGznoB0A0N1S7a7
 gORq/DirdaQI6Migqd8e0Sln9WROoLuRS5Az6d/I1lAQ34/PC0SUOh7TNT3o/J7niQ+o
 45PabSAB8ZffZlpX1m+QWxJ03bDfReyy18YjgBbh+vfaRS3CoeOrX9FUATOH4DYLgX25
 63UiSmmPoHmmN2bi6ZKtf9uioeugODn74KLQmvRQ3k8tYGgBf/5BjcDrdq/Jry0IUvFM
 HrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ONnwdTXAi0KqD4xgCehz6fs98mVhVUYkVg/AFYIduFw=;
 b=ULRoPaLPYy9x8sV00hXfYvc56ln6PvBnvtV4Ljh1aXP7PG/o+Hh5YgDH5OqLO6o4bl
 U2WieMKyhxR/brZ2PHyMi3Yj+ukWkbg9Z/LVNmfl+U4x88MOqFa25Z/xay5iLosemdoF
 HJTdmP9iVpVVd0dCAOWqyTGGnxHV61ADjNw9vixMWCw94zu9G9dRjIiqN8/U+cMSLdJd
 kEsUivilydVqMD01Dtk0ljfFin5BmheleuDQMUm1QbVElxuHZVQW/XEW/I9e7Lm2MpCX
 dryJKAF0rlel6RQxQg9MdseBgZoQdEYGakHjY38OnidXrrr8M+5SGGZXXCqxUrwciH2O
 tVRQ==
X-Gm-Message-State: AOAM530idBJXWFRPwuU6c1MHz9r2SGgihu5rZp41SfdlILxQarjnmWPr
 NxTf6R8bcE2eSsDxnY5sEvqb8JiMLQiGQreHA6A=
X-Google-Smtp-Source: ABdhPJxoEnXteucv4F8HocrO3UKcjgRpgKfS2Hq2tLVYzdrfY9qgrBLQWz/5E4d/8PU1dU1j4dVEsxNUHZ1sIbwnKGE=
X-Received: by 2002:adf:dd8f:: with SMTP id x15mr20315874wrl.124.1603733763253; 
 Mon, 26 Oct 2020 10:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201026143040.887736-1-alexander.deucher@amd.com>
 <1603731150.75fg1z8ezy.none@localhost>
In-Reply-To: <1603731150.75fg1z8ezy.none@localhost>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Oct 2020 13:35:52 -0400
Message-ID: <CADnq5_Nvb6K4yHh-x=m4Hy-nhb=pJ7=DStL0oXpfogBYcay+YA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: use kvzalloc again in dc_create_state
To: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Will do.  Thanks!

Alex

On Mon, Oct 26, 2020 at 12:56 PM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
>
> Excerpts from Alex Deucher's message of October 26, 2020 10:30 am:
> > It looks this was accidently lost in a follow up patch.
> > dc context is large and we don't need contiguous pages.
> >
> > Fixes: e4863f118a7d ("drm/amd/display: Multi display cause system lag on mode change")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Aric Cyr <aric.cyr@amd.com>
> > Cc: Alex Xu <alex_y_xu@yahoo.ca>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > index 7ff029143722..64da60450fb0 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > @@ -1564,8 +1564,8 @@ static void init_state(struct dc *dc, struct dc_state *context)
> >
> >  struct dc_state *dc_create_state(struct dc *dc)
> >  {
> > -     struct dc_state *context = kzalloc(sizeof(struct dc_state),
> > -                                        GFP_KERNEL);
> > +     struct dc_state *context = kvzalloc(sizeof(struct dc_state),
> > +                                         GFP_KERNEL);
> >
> >       if (!context)
> >               return NULL;
> > --
> > 2.25.4
> >
> >
>
> Did a quick test, it seems to resolve the issue for me. If you could
> apply one or both of:
>
> Reported-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
> Tested-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
>
> I'd appreciate it, but it's not a big deal. Thanks!
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
