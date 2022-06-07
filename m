Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3635C43334
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 19:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FDF810E128;
	Tue,  7 Jun 2022 19:25:17 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A0F910E128
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 19:25:16 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id g186so7915223pgc.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jun 2022 12:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=szR7r+mhCiyllPHOYpWCvCcgEkcODKa3DHmlzg25Uuc=;
 b=YxOVYFIXNDL2R9Bp5NP7sFBCXOpoBOSoM2+6V+lnOBnYxPPzfDjs2/v/oTsXj4uhLS
 078BRiHzhGwm+ESUcmIhulF8W4QCV6GSulm+/klLNoOsu0JbpU1VZvx/TBp4Fen3EBH7
 /jj0leaQxRcNbCpvW6hZMD8BLq397vAcPTfDhJe3C26YNJoQkrv87gKE/wcOPh7xxi5o
 QCRIdWFaPOS4K/eIwD87pekU6QM+YI/CHK5K6Gic1G7v7fGKPzWBpaF3tvNwt42+LPJk
 KsE7eVpzhBKnfe7hGrCKvIZU5E3bMVAAdH8DHASpfdSkoz6ia8Lr61B9+lKpxySWVQM/
 emBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=szR7r+mhCiyllPHOYpWCvCcgEkcODKa3DHmlzg25Uuc=;
 b=m/KuwbNp+nucmiudhyiD8SrWivp4aq5bAqkjVIXoFtDMSd+PCqf3p05hqZ/aRQ5CoP
 tzctCtyKhHHTciBqwMZNXaod8uZKzO3aGQGM8ME9jZroSWjthU2dliUMqKj6P9eFzH4j
 UtFJUj2umWK9QLny/jP4tUE4OIJio4Kc05GpGwfIX902a/PoRITPOj+Tc0fQ6fmGvSOY
 subYmSx34p+WSvaTruxle6CoDg+xuR/PYgiL2WVJISqGAzfoq4OdSscYPHvbqxsto6D4
 SDZMxrBGrbhJtyLTAF0unHNBZeKAExLYzAuyIAUtIbSr3gVayguvH3UPBT4to0dE6Kfy
 4wcA==
X-Gm-Message-State: AOAM531UiQXC98pNZuJvwvG9T/uihtE9FR005wHGsUYsdcJ9onewa5aE
 JvwSOG4LsBeZGr57tshUFss=
X-Google-Smtp-Source: ABdhPJxjqDVgqTFmIHkJXehL20yGslGE4u+0x03+g4O9N4M8WM3QfKusenD1lbiI3tyXzFjnFuTgcg==
X-Received: by 2002:a05:6a00:88f:b0:510:7a49:b72f with SMTP id
 q15-20020a056a00088f00b005107a49b72fmr30639671pfj.21.1654629915579; 
 Tue, 07 Jun 2022 12:25:15 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:fa4d])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a170902d34500b0015ef27092aasm12865936plk.190.2022.06.07.12.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jun 2022 12:25:14 -0700 (PDT)
Date: Tue, 7 Jun 2022 09:25:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] Revert "workqueue: remove unused cancel_work()"
Message-ID: <Yp+mGaY+Ga/wX2h2@slm.duckdns.org>
References: <20220519135642.83209-1-andrey.grodzovsky@amd.com>
 <CAJhGHyBQ60Lh3WZCa+2cE4T36t3vjNxYTBCxS7J0xhZr8Eb2wg@mail.gmail.com>
 <e1e2e63d-a1a9-12ad-97a7-a3771210edda@amd.com>
 <CAJhGHyC7VLM1PnXMu2zmdX=xtSNKo6VGO5p0AkUnaaMsuZytpA@mail.gmail.com>
 <045157bb-31a0-2d76-18b7-4272fab218ef@gmail.com>
 <YodIquufXzK581gw@slm.duckdns.org>
 <8df16635-658b-b381-9a40-3544828910fc@amd.com>
 <Yp+HXowR9nTig331@slm.duckdns.org>
 <CADnq5_OquY8A_nMsCcwMxvDL3r0WzYAxFdrGNzYsKEP7q-Xg7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_OquY8A_nMsCcwMxvDL3r0WzYAxFdrGNzYsKEP7q-Xg7g@mail.gmail.com>
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Christian Koenig <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 07, 2022 at 01:39:01PM -0400, Alex Deucher wrote:
> On Tue, Jun 7, 2022 at 1:14 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Sat, May 21, 2022 at 12:04:00AM -0400, Andrey Grodzovsky wrote:
> > > From 78df30cc97f10c885f5159a293e6afe2348aa60c Mon Sep 17 00:00:00 2001
> > > From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> > > Date: Thu, 19 May 2022 09:47:28 -0400
> > > Subject: Revert "workqueue: remove unused cancel_work()"
> > >
> > > This reverts commit 6417250d3f894e66a68ba1cd93676143f2376a6f.
> > >
> > > amdpgu need this function in order to prematurly stop pending
> > > reset works when another reset work already in progress.
> > >
> > > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> >
> > Applied to wq/for-5.19-fixes.
> 
> Could we take it through the drm tree so we can include it with
> Andrey's patches that depend on it?

Oh sure, please go ahead. Imma revert from my tree.

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
