Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F16EC07E96
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 14:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33231613C7
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 14:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33231613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A8806E866;
	Thu, 15 Jul 2021 14:07:32 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 399996E864;
 Thu, 15 Jul 2021 14:07:30 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id h9so6735527oih.4;
 Thu, 15 Jul 2021 07:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Wd27DEr1E/QgRt9+LAOHHXGHaGJPQeFul0EaBUCJi5E=;
 b=FXf0E7T8xJ07pqsOK2pr9Cfp1wMLErGzJV2wcLPmS7Vh7BinMGkG7jbvYdrfAr6rHa
 pcHmpmlfOH0PgE8yv62FegDUPsQDa5zWuxfsKFOG6Lm2v1H4UBClsOQ5Pj7gtYH1kIjK
 DWIi+ICNwgmBMsELTyogZ1VQx+3qqP+Sj0aBBbPSqFS/wUjlwfBSPedIqpDiCcQyyBLa
 5TjdB0bPdkg51I+tqQ6aOuBamCn11Q0e4MO0/hwj5w2uVfrLzc4b8qMoHEW8uOJICWKJ
 HyxPTMFTqM2rRsvwyEC7GSmg+nVYr6rX129ihdwxllkGkm01VylbZ7K/sIS7eLlAaz8X
 GDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Wd27DEr1E/QgRt9+LAOHHXGHaGJPQeFul0EaBUCJi5E=;
 b=e8LnzYPmf0h6wj6JyfIm+KNrk9d6SW0lUM8Jc7rTHJD57PiVQBPyPJJgVspEStc1TO
 01PjalStUYOhv68lqdauLQfOaCnmQ9XyV6ctSM0jQBjx+Vcaiemzcra6VXsfYPC/Hm4x
 Fpb8Mvjg2GngTc6qqcS7Bict64TukSSm6SBf3qJVzsmdMNLRILy/sA1igFP4I7bslm1N
 8lcjWoMIlX/8vo/gEOu4XEpIO6vsBfuwG21WY1R5u4AWdj6q5bdm5PYJ6TpQXhOULjV0
 bstsrVG6uWyxWKJ8Lmn001SU0BguCSxpjy16KMZCv/lr3cbHMeb83VRUpM7m5pJYgQu1
 X76g==
X-Gm-Message-State: AOAM531cKN7Qy5eoh1ITvIUf2Gx57LATTA8FeMFYnCpnNKmAEcg05Lh3
 5PDLqY+dRlMdZ7VwJvvSdjG01HffUBLIFpPppj8=
X-Google-Smtp-Source: ABdhPJycQPIgA6Orp3hDXE6mb3cB+XnNHiJqRke4rwpt7C4aMqzEBwexz5AqgcAGz52swASEEf6jKcP7SQm0g+Ndhvg=
X-Received: by 2002:aca:3446:: with SMTP id b67mr3775753oia.120.1626358049509; 
 Thu, 15 Jul 2021 07:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210714220858.5553-1-alexander.deucher@amd.com>
 <YO+++Tj94RRjVqwV@ravnborg.org>
In-Reply-To: <YO+++Tj94RRjVqwV@ravnborg.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Jul 2021 10:07:18 -0400
Message-ID: <CADnq5_Oj1Totqe=fGeF3AeQsodR9_6ki7EChs3CmJzC7txMu1A@mail.gmail.com>
Subject: Re: [pull] amdgpu, amdkfd drm-fixes-5.14
To: Sam Ravnborg <sam@ravnborg.org>
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
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 15, 2021 at 12:52 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Alex,
>
> On Wed, Jul 14, 2021 at 06:08:58PM -0400, Alex Deucher wrote:
> > Hi Dave, Daniel,
> >
> > Fixes for 5.14.  The big change here is unifying the SMU13 code.  This was
> > new code added in 5.14 to support Yellow Carp, but we've since cleaned it
> > up and removed a lot of duplication, so better to merge it now to facilitate
> > any bug fixes in the future that need to go back to this kernel via stable.
> > Only affects Yellow Carp which is new for 5.14 anyway so not much chance for
> > regressions.  The rest is just standard bug fixes.
>
> This pull seems not to include any fixes for the W=1 warnings that
> has crept in again. It would be nice if the amdgpu could be warning free
> again, this would maybe motivate the others to fix theirs too so we
> could keep most/all of drivers/gpu/ free of W=1 warnings.

We haven't really been monitoring the W=1 stuff that closely.  I'll
see what we can do going forward.

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
