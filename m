Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D49C47082
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 01:37:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE9AF613E9
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 01:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9AF613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 599A66F553;
	Fri,  4 Jun 2021 01:37:18 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 275766F553;
 Fri,  4 Jun 2021 01:37:17 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id g8so12061859ejx.1;
 Thu, 03 Jun 2021 18:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DmDwyfiUpk4MzADbJZuAJIcu3kCE/Kytx8Q+Lh8fxLg=;
 b=D1MmLWnh/4tPMDvS54FuKlMsDPerGoj9PNax6boNdMKfbt+pbam3+WqgKAOTFAGPox
 qKUfbWwBVdjZ0rEkIErTtnaE5c4YMt6kMcehXGcSwvrOtBrtM0WzIorwWpMMZPUg/0dS
 7jxQXfN0wgaJIboKk9Y9s3X8KxRnGe5ep+gCn3rOlXfe5YPfjequIkgJDgMhHVn3oXrH
 EBlzPYxaiYXTJqE8m8B5lHNQUzsNnhNMF+Xnlu+FnApCi06Mihj1dGrvRR24XQ1GEDQn
 p9pOJxOMvF7z3dvTmYHyedyWqTPlE6xE7NCZ+/httq0bmJOshxXY5DHkwEZHZzXsK0Zl
 ybFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DmDwyfiUpk4MzADbJZuAJIcu3kCE/Kytx8Q+Lh8fxLg=;
 b=PQnW8qnfZ4QS9EDkfaduBuRhzaVDGHp5znEkrgWjXnqcMwKcN2B/lpBL7zedpXfnLU
 wwqFrA+Hh+ejSbJqNA5yefN453YMWhItTanQ+FUW/iPuVCp1BhSfPz6P6i8jf/0VKcMv
 Vz2ssfgmhAjFYFXIYaQZAjh7bYVJCOLj3EKHbRxnZXghSyDBSHx+7Cit9u+0yrhxG/Io
 bQfBJHSZ7/BtmeYnqEKp8koSKdzRLbKs+4yOQDSADACRNqpsj+TJOg/cGmB2f1QStZIf
 d+iWhR+fdl1wWn2oaD66g2W3ms3mzVycYrYLdDxeMi6i0pKZa8tDcA8dv/PNxOO5DSDH
 55xg==
X-Gm-Message-State: AOAM533WcEgbzHhKVok6nLrQ21tLaN0grn8UYcLb/wliUPfDe8ufiuAz
 oAWPsnm3sJdNerzvCCffIblh9gxAYidr15ryVi4=
X-Google-Smtp-Source: ABdhPJxKo2rMgh/XfOxymxh2x0163+/YrtzFqMwn6wsiH74huoJoqb6VdRHmuvv/zq4K/a5cKaG+2sFhpBzadDUwSD0=
X-Received: by 2002:a17:906:4747:: with SMTP id
 j7mr1878454ejs.419.1622770635803; 
 Thu, 03 Jun 2021 18:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210601201702.23316-1-andrey.grodzovsky@amd.com>
 <CADnq5_Nfs_j9XE1Siou2wGYuwd5cvTD1T7m9gFpS9z74D=AuAQ@mail.gmail.com>
In-Reply-To: <CADnq5_Nfs_j9XE1Siou2wGYuwd5cvTD1T7m9gFpS9z74D=AuAQ@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 4 Jun 2021 11:37:04 +1000
Message-ID: <CAPM=9tznFeKrL-La1RqCtAib4N+Stf=2epQYabrm=vYnds6LwQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] libdrm tests for hot-unplug feature
To: Alex Deucher <alexdeucher@gmail.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 4 Jun 2021 at 07:20, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Please open a gitlab MR for these.
>

I'd really prefer these tests all get migrated out of here into igt. I
don't think libdrm_amdgpu really should have tests that test the
kernel level infrastructure.

I know some people at AMD had issues in the past with igt because the
i might have stood for intel back in time, but at this point I think
we should be moving past that.

Dave.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
