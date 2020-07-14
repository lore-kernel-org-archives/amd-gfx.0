Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFEBC433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 15:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E08020663
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 15:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi7iqtbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E08020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5312E6E995;
	Tue, 14 Jul 2020 15:08:43 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88B4A6E995
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 15:08:41 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id q5so22331099wru.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UbX2bjs/oBRcyuIywFMctLsFmo7SfvwfpjGO6mWLN98=;
 b=bi7iqtbZU8UMprFFuKEfINolIXoycfFxpm9KOj3oWvlVbK5RmxSceOV6H8W8PN9PfY
 mxlVTBsLI6qRF/jOnb5qtnjnyjFftwiNTqdNJxf7LS9hujizvTecJ3n6Olxjao/pIWpc
 Ai0xZLQ54J0ZIO3K+NayvXCKd1UUEnxqAs0QwfouzYiM1RkFBFRUk8AWWWDR2OUGqOUC
 +DZiozYCqX2hGz6FQFMPhg1Kly1b/2gB1E4xQ+6d+ZRfsiu05iubMOPOwGpxQZrNiGnB
 Dg41711CAdrS6ROlhUBKNTVYG5Q/EvpFMZ4O8NwBw57QG6Y6xSurtesokZWvJTbSqUBp
 sDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UbX2bjs/oBRcyuIywFMctLsFmo7SfvwfpjGO6mWLN98=;
 b=YWn6ZKvGFDt6jIYhRLxt5iQNWQBx8gCd+a6sBkx76SEcZSUO9WZnu92RTG/b2QeU09
 aRO78mcfjt8IDXHG+rAqoIBwCFdqy2OmHfdSDBeWEUqqRb2o3udnk8OmKrtw9pQW14a0
 KKbsneP3YCR1XDAbGwgwYJJ6ttKXEykr2wdmNxgx5utM50B5GEZiUq7/aeXlaSBC56B7
 CRczuahGsyhI331wnRR4/8d9qETumRMWWmqdNCHgRv3BFD6fuwEY9agwxrjWtoGQmABj
 AnjPzwFx65UwOpQ8qpMB9gyj4OoMGyXTr2mukT0Av9zvW2xlCrLizq1REQ57VXwOJr91
 5ogw==
X-Gm-Message-State: AOAM5310OGP8Q1IZM5uL0NT+4eyVK8yeNXJWvKDwcnOwcDC2G3btBSz5
 TEpDMsBmPr60jLm3kvVLj4bqAu/pQDwYqP/8/x4=
X-Google-Smtp-Source: ABdhPJwWQdMpzC76cHpXyz09/KUcw5IaQOdsgkXV8Rx8l52Oii4V4Gv7V0l+r2yooVtQ5gGFzKiE7xcSzlFHKh7oWpo=
X-Received: by 2002:adf:ef89:: with SMTP id d9mr6646727wro.124.1594739320213; 
 Tue, 14 Jul 2020 08:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200714105700.GC294318@mwanda>
In-Reply-To: <20200714105700.GC294318@mwanda>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jul 2020 11:08:29 -0400
Message-ID: <CADnq5_PjbNie+rdxttjYuykhWSC4VrE+U+xFYeYurvYixeiPVA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove an unnecessary NULL check
To: Dan Carpenter <dan.carpenter@oracle.com>
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
Cc: Daniel Vetter <daniel@ffwll.ch>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, kernel-janitors@vger.kernel.org,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, David Airlie <airlied@linux.ie>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Yongqiang Sun <yongqiang.sun@amd.com>, Martin Leung <martin.leung@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 14, 2020 at 6:57 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The "stream" pointer can't be NULL and it's dereferenced on the line
> before so the check doesn't make sense.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 4f97329d9daf..7e58f242dab9 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -2324,7 +2324,7 @@ static void commit_planes_for_stream(struct dc *dc,
>
>         if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
>                 if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
> -                       if (stream && should_use_dmub_lock(stream->link)) {
> +                       if (should_use_dmub_lock(stream->link)) {
>                                 union dmub_hw_lock_flags hw_locks = { 0 };
>                                 struct dmub_hw_lock_inst_flags inst_flags = { 0 };
>
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
