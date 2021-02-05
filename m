Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757E8C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 04:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1938D64F9B
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 04:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1938D64F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86A466E0E1;
	Fri,  5 Feb 2021 04:33:34 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF28E6E0DD;
 Fri,  5 Feb 2021 04:33:32 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id f6so5704516ots.9;
 Thu, 04 Feb 2021 20:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uMiesEpfBEncjUgmLRyB5Wm6+wRh6ZUIfqzc/jNxnKg=;
 b=MvhNUhjVzivGCKIbSVwualeGM4Er83+5oQLC2SCe6zZ1jJtsXLVjcvK7jACUKvd0Hh
 822JFh15jP/VctkGvX3PIXVQ+fgR4luCNDd+nszp4r3DijNr1D90ixjvlc9PHv+Qrn0M
 YLUQfnPmU76NkLvKM5oEFxewQamID98apeRjDSnjxs18e1L6lMMnV8t0ZRR6F0AtC5Gc
 4KJgy4Fi8Pm8tbD0TgdPYHntx2lbghX6tyHI3H3ESxOMBG7CfbncsK8IemcRmmHeOTpL
 L9SM2isO4hXL3+VFWFPvIojLV1iAgC0KWZC7zG06nGFebzcVudDzEB7WWmlhrHG+v7LS
 tQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uMiesEpfBEncjUgmLRyB5Wm6+wRh6ZUIfqzc/jNxnKg=;
 b=fIFZX+1FqWvL6JZUxkmW7fjTtHwTICePK5qgQhZJTf1+T/cBIrTNZuUQuHiHb/q6W1
 uyVRzNnX703Y2lKR/NxqH0Bpv6EH6DpKJrFT029Pkq/NRCFkLAKOcVJakQFTC7twW4f2
 4riX+2ErSP2pIpChDtf0pCQLz5Da1qz069SAHYxUP2zPjUvo6P6ZCQMwq7P0BDlo/+70
 hVnR0kvd+QtQBH0gCfNuqd2+lHaf2z+N7jqVrcLUxUILHjBQYHjqVJwMa45BZp0h35Qb
 guwgdeEbyd4zo6jw38icVhm/ecKHbv8NAFH/IvkAPcZ1dj0p0iH/80Fur7XOKrEHvWFz
 pKUQ==
X-Gm-Message-State: AOAM530IXKLKZja1qXdFJpxXY1LenYefOGl9T6WpBa+nSkQeSFhUNtxK
 j+a/lAQxFf0v5FjRWLIsDPKlbGjXB0vC0e+1yyg=
X-Google-Smtp-Source: ABdhPJyGeZACQ8LylcDwLHvNmIAqsxElNJQXnpoU/qwZq7M78zZ32QLrXW64bCS4XmgYsLC7u3Z+j7iyh8rctMm6B/s=
X-Received: by 2002:a05:6830:92:: with SMTP id
 a18mr2067886oto.23.1612499612250; 
 Thu, 04 Feb 2021 20:33:32 -0800 (PST)
MIME-Version: 1.0
References: <20210204045717.3823-1-alexander.deucher@amd.com>
 <CAPM=9tzKzgOTQd4zorqn8LP2QJhSLuD_xJhm5saSH2uUJE7_+w@mail.gmail.com>
In-Reply-To: <CAPM=9tzKzgOTQd4zorqn8LP2QJhSLuD_xJhm5saSH2uUJE7_+w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Feb 2021 23:33:21 -0500
Message-ID: <CADnq5_MjZrt4EQt8UhszT-_UcuSY_j7Ezk__TmTr+NhBuWw=3A@mail.gmail.com>
Subject: Re: [pull] amdgpu, amdkfd drm-next-5.12
To: Dave Airlie <airlied@gmail.com>
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
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 4, 2021 at 6:52 PM Dave Airlie <airlied@gmail.com> wrote:
>
> On Thu, 4 Feb 2021 at 14:57, Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > Hi Dave, Daniel,
> >
> > More fixes for 5.12.  Same PR from last week with the issue Felix reported
> > fixed and a few more additional fixes on top.
> >
> > The following changes since commit a6b8720c2f85143561c3453e1cf928a2f8586ac0:
> >
> >   Merge tag 'amd-drm-next-5.12-2021-01-20' of https://gitlab.freedesktop.org/agd5f/linux into drm-next (2021-01-20 13:08:18 +0100)
> >
> This brought an arm32 warning with it, I've applied Arnd's patch to
> drm-next to fix it.
>
> https://patchwork.freedesktop.org/patch/msgid/20210125124849.102037-1-arnd@kernel.org
>
> However that function has an ifdef around an ifdef that probably could
> do with cleaning up.

Sorry about that.  Bhawan fixed that up at the time:
https://patchwork.freedesktop.org/patch/415092/
Daniel said he picked that up last week:
https://lists.freedesktop.org/archives/dri-devel/2021-January/294941.html
but I guess it never landed, otherwise I would have included it in my PR.

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
