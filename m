Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C20DC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 16:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD392558F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 16:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoCUjDrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD392558F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E2889D8A;
	Mon, 29 Jun 2020 16:20:49 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3074989D8A
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 16:20:49 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id z13so17136946wrw.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bVNJjB2QEsEYo8Dhb6xZ25V60tc2kgFpBPizhEjIdRk=;
 b=WoCUjDrV6ZzpNNSM6mmURmA9DajcHTmodKQBxmLO5m8ulKACqpzohIxOllWWapP64M
 m3gzU0HrAEZ33pil2sgnxp5uBnWR5LY+A5gE2KoOk2CbsP0+5FoWwZrvaKLADh2b60R5
 3R0+DgRBmIsn5TYghGyu7npu35szIaGAXfaYI5ht7kp/Qz+mu2clTlFpemfcRVMSPt8z
 YUUvJKiifuc5T6C3Om35A70TrwEo2njbhkUkMgR/KtS90iqKBqUJH7jZvn7O9aUGOFZc
 8VoC23FRK/bxK6d+DEhuLbHbxvWCzeIIJM5WYfh4XTKs8EPAa4EMNU7uLViWGj8NqLYe
 RlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bVNJjB2QEsEYo8Dhb6xZ25V60tc2kgFpBPizhEjIdRk=;
 b=d5dCnbYjapWusXpTeBlRO76w/e4PyYlp+wJDtJ8r57QVsMOIXsIvFqoAKcTVsPER2d
 FW7DJzYCZDVmrKDtknYYUKlubgguzXkyGonL339QkIbSpesz+p0FnaB4pQUc4BqSs5s6
 2jjVO8Eb8W7/LHlHiheP4eTfqOQf7tmIoDnkvEG281XTNceiQt+ohQB5tvKPmFUDr0xc
 O0MC+Hp3W1/epel6/j2jFXC44qbzSchHh1SZD5FsHiUWkIlD3EZ8DzOPwa4u0bjAPNme
 Eh0GI5YerGcIgnzZl1EB2sHaxVurbrMiZspoKhSK6bPyfEvwh4iNrriMQl3awGkfig0+
 mgYw==
X-Gm-Message-State: AOAM531o2Qz6f04TnFcLI/gxoVUfmh5gdPl567QP3iDhkYlg+gUhSZJ2
 qqNcoYwkQMmeuOg8PZZ+j8u9wCXFWQXtZDiF7rvrCg==
X-Google-Smtp-Source: ABdhPJyMw+6o9fpetObqBmwQaiMfHUHtM/c/qNau4a3dtXSYrW3xh5pmIdjwPFKKmAHEleXZdLNR/IeWAXYKb2Rq+B0=
X-Received: by 2002:a5d:68cc:: with SMTP id p12mr17501734wrw.111.1593447647844; 
 Mon, 29 Jun 2020 09:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200629153652.101179-1-alexander.deucher@amd.com>
 <0af93aef-1173-58dd-f44a-5e2e36eba17c@amd.com>
 <5f57c33d-dfd7-1f1f-f448-e05963caa9ec@amd.com>
In-Reply-To: <5f57c33d-dfd7-1f1f-f448-e05963caa9ec@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 29 Jun 2020 12:20:36 -0400
Message-ID: <CADnq5_PmHGXXxocZeXCOW-rESXNo9aStpT4eb4Zg+jRRmoONkg@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: Revalidate bandwidth before
 commiting DC updates"
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 29, 2020 at 12:13 PM Kazlauskas, Nicholas
<nicholas.kazlauskas@amd.com> wrote:
>
> On 2020-06-29 11:40 a.m., Kazlauskas, Nicholas wrote:
> > On 2020-06-29 11:36 a.m., Alex Deucher wrote:
> >> Seems to cause stability issues for some users.
> >>
> >> This reverts commit a24eaa5c51255b344d5a321f1eeb3205f2775498.
> >>
> >> Bug:
> >> https://gitlab.freedesktop.org/drm/amd/-/issues/1191
> >>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > I don't see the error in their log. How do we know this commit is
> > actually causing the issue?
> >
> > I don't really want to revert this commit because it means that we
> > missed rejecting a commit during atomic check, meaning we're either
> > going to get underflow on the screen or a pipe hang.
> >
> > Regards,
> > Nicholas Kazlauskas
>
> Actually, we only want to be doing this on full updates - it's not a
> very fast operation. Not sure if this is causing their stability issue
> though.

Maybe.  Several people have reported reverting it fixes hangs.  Maybe
something in the validation code hangs?  Maybe some sort of software
deadlock?

Alex


>
> Regards,
> Nicholas Kazlauskas
>
> >
> >> ---
> >>   drivers/gpu/drm/amd/display/dc/core/dc.c | 6 ------
> >>   1 file changed, 6 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c
> >> b/drivers/gpu/drm/amd/display/dc/core/dc.c
> >> index 67402d75e67e..94230bb3195d 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> >> @@ -2607,12 +2607,6 @@ void dc_commit_updates_for_stream(struct dc *dc,
> >>       copy_stream_update_to_stream(dc, context, stream, stream_update);
> >> -    if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false)) {
> >> -        DC_ERROR("Mode validation failed for stream update!\n");
> >> -        dc_release_state(context);
> >> -        return;
> >> -    }
> >> -
> >>       commit_planes_for_stream(
> >>                   dc,
> >>                   srf_updates,
> >>
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
