Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0453EC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 21:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 979E16146E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 21:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979E16146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A976E8F8;
	Mon, 10 May 2021 21:21:08 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 876E86E8F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 21:21:06 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 36-20020a9d0ba70000b02902e0a0a8fe36so9422563oth.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 14:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1izQFGQMreu8HN0/vQftnxMKF6OBeHuz6Ydj3VRoejw=;
 b=H+rsB6Tzl7ZkTQiWpY557VAYf0vqbOhKzYUq5tWfSS2HxWf69G0XehvCgHx5bKFKhB
 ZjOJ4M1d3ljui6U5bVckfwLdiJUIAR9FKY5AkjC1fYevk9iQtb4paLCB639cs2VJe5p4
 64e/SUBtCnuNzw69UdlwSF46qJ6y3HUcrHQA+EZj2IX6iU43LgOIeYDbPYmOO2x+cxcZ
 BcPSbmeBZFWBPDK9Dy4O8oryQ1lE+y7xkDqMd9tK05MiqyfHo8mjr7I7IXKRIXjvqLro
 oPyAcY1WaOvRVKzPt5VvYMAWE1al28geGzxiqbtPrdwyAVMoG7vzi6f/38cm9I+UMYeV
 yVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1izQFGQMreu8HN0/vQftnxMKF6OBeHuz6Ydj3VRoejw=;
 b=N2Yej1/Tt/0awJ5Hm6ayfhxGpnlr/giotJL9ObGU9Pu74uFdVgQS1HmAceffq7f3O/
 nJtmNSeLKr1F+DWXYaLElFxbsQo/BvVYUNmACGeTw1gw0B1vTbIoACd/orKwAxZUrdgl
 MCFk1toRYiGB5xarLaSou7ieLpgwlLTrVpJ60a+Gdn2Axq+qNppWNAA6ht5tv9WzUvLn
 GERZX/jJz0G/wldv4Ogd1vsh5pj7G8iFk7R3iMDXK25/O4Gh03EUQ6dG0Dv+vCc4jnFd
 y/7v2NHvhmvPRkorI/Zg9efuHNUVJkvDFziuRrsr1pR96Qg1GrXp1JuDI++xGuRHpO7K
 X+aA==
X-Gm-Message-State: AOAM531pQbpODZIXrkKZj+2nseyq48gu5SzCYWx8qflAIoMH1X8wLeFD
 uSpLb/PVrDzb5nXDESBtvU7QecY6ckBRStdov+Yjd0q/
X-Google-Smtp-Source: ABdhPJzCqnBL7l4fSerRWstf7AZwqKL1tgnAasAUiZAR7IxSzcCla81CjvOZkKP+sXf2HNH0ewpi9oYWdpteXaN796U=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr20711564oti.23.1620681665920; 
 Mon, 10 May 2021 14:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210504184233.2350976-1-alexander.deucher@amd.com>
 <15cc0988-0446-5423-62d7-051ccaf2936e@embeddedor.com>
 <MN2PR12MB44886A5959AA52DF5D3EDF7BF7599@MN2PR12MB4488.namprd12.prod.outlook.com>
 <09c63f79-7245-3863-c070-8bac952a4ca8@embeddedor.com>
 <caac4b9d-8999-8c06-80ed-0ddf1ef29c9a@embeddedor.com>
In-Reply-To: <caac4b9d-8999-8c06-80ed-0ddf1ef29c9a@embeddedor.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 May 2021 17:20:54 -0400
Message-ID: <CADnq5_OwNGx5XvtA8UPdGdyNmFBN9ynKESxum5=yef=XSL69JA@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/radeon/si_dpm: Replace one-element array with
 flexible-array in struct SISLANDS_SMC_SWSTATE"
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
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
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 10, 2021 at 4:26 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Hi Alex,
>
> I've just sent a couple of fixes for the recent radeon problems:
>
> https://lore.kernel.org/lkml/20210509224926.GA31035@embeddedor/
> https://lore.kernel.org/lkml/20210509225525.GA32045@embeddedor/
>
> So, there is no need to revert the problematic patches for radeon anymore.
>
> Sorry for the inconveniences.

Thanks for fixing these up.

Alex

> Thanks!
> --
> Gustavo
>
> On 5/5/21 08:45, Gustavo A. R. Silva wrote:
> >
> >
> > On 5/5/21 08:06, Deucher, Alexander wrote:
> >> [AMD Public Use]
> >>
> >>> -----Original Message-----
> >>> From: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >>> Sent: Tuesday, May 4, 2021 6:43 PM
> >>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> >>> gfx@lists.freedesktop.org
> >>> Cc: Gustavo A . R . Silva <gustavoars@kernel.org>
> >>> Subject: Re: [PATCH] Revert "drm/radeon/si_dpm: Replace one-element
> >>> array with flexible-array in struct SISLANDS_SMC_SWSTATE"
> >>>
> >>> Hi,
> >>>
> >>> I thought it was this[1] the one causing problems[2].
> >>
> >> They are both causing problems.
> >
> > Yeah, I already know why and I'll work out a solution soon. In the meantime, both
> > should be reverted.
> >
> > These other two[1][2] also seem to have the same issue and should be reverted, too.
> > I wonder why no one has reported any problems, yet... in particular regarding this[2].
> >
> > Thanks
> > --
> > Gustavo
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0e1aa13ca3ffdd1e626532a3924ac80686939848
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4541ea81edde6ce9a1d9be082489aca7e8e7e1dc
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
