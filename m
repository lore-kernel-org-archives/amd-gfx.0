Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EA0C5AE59
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 13:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6317C10E088;
	Tue,  3 Jun 2025 13:59:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qruePmhX";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26E8410E088
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 13:59:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 5E721A50362
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 13:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E91EC4CEF2
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 13:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748959178;
 bh=8O01BeD3JeBGoCXMVGKmioU2y+7W8/zk5PFp0PTzOCo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=qruePmhXwLwIT7yubZ2rZ1crCtxzob6uzm08WfAD1wV3bvYzhB2xlL0O329ckyApr
 arPLahzg+pfFk+0spIfnt+5aUpPE54/q8nleDN/gqWPT7YfsKsdwkd8EqQZVmIPy7h
 pTUgBvuwntrQYTWLISg0JX6O7Ypl5uwJc3OLha7wFy8vBDlIs5gCGvyTRmhNqpxjn5
 GW84N5NzxOvq/7dMln14mrOknedBIMPJL78poPaQ2sB3sdIw+242UGSjh7kyjgn9l2
 arfVwCR9iINO4k7DT5dJzq01R/NCe24FsleitVkR/zB82eCGuyMFs5Oa9KrgTLbdhq
 dyb+mBzZohBSA==
Received: by mail-oi1-f170.google.com with SMTP id
 5614622812f47-40677f3b919so918323b6e.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jun 2025 06:59:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCV97r66GC7wsgbLZROstfxIH+3XYQWjk3KZ/Ekb7uR9oq34lcKVfGlgou9wU3lbbc6+DbZMowX1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwB6kwDEISXVWJ5SJHR9/yqjcL2kz+q1er5nsLNhBnXjjOuus8x
 b/A1dYjQ4HZRHz2i1hSmykFnm4PAsf/iMzkacfu4Ejt+cyxHuwz5xDZhxnwMWjT8dF1VfjYGZ92
 9uNmapM+6iKzRUedqeGXUEc+xSWxoFWk=
X-Google-Smtp-Source: AGHT+IGz9sON12m2CdSik0QSY1yX71qiBMm+dsJBK0M2V5gvh+KI+TPMkvmjVzkb2Wmx5U1j+QnI/M+7F/k3doV8KA8=
X-Received: by 2002:a05:6808:6f89:b0:400:fa6b:a104 with SMTP id
 5614622812f47-4067e6e30d2mr9667733b6e.33.1748959177407; Tue, 03 Jun 2025
 06:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0jDZQaR8S6Kn_RoXHBU86+tpjp=qgyxm5h03YEe2S=nPg@mail.gmail.com>
 <aD7L0RD4HT-mEtBc@debian.local>
 <CAJZ5v0h65Gt1Fw35vp2k8kKu62+goCD8WF8u-tvhfWW6a7xHxQ@mail.gmail.com>
 <CAJZ5v0ggPHhYcdNos2o8savvq+-zpPTaQunjOkR36k3VwF3_CA@mail.gmail.com>
 <CAJZ5v0gF=ewooE0cUrNfe5_inhnzq6bqw8VTjkFwr56_wrptJQ@mail.gmail.com>
 <CAJZ5v0hpJSVdiCN29=kbV8KfgU1y1d3hFfshtBoMpVFXf+LvBQ@mail.gmail.com>
 <aD7nOMP3xA9BR781@debian.local>
 <CAJZ5v0gAcohRWuSZbFWvyfAU9Vjc7nRyj+AFRYQ7hcGEXdPxyQ@mail.gmail.com>
 <CAP-bSRbVjcXBvxDT6ZQuoRB+JF6A4LhdMVnNqnaQC0bg-xg2BQ@mail.gmail.com>
 <CAJZ5v0gTRtPzrROdkxRjTeXv4BsRyUkyGpCWmh-gHNx3X2L9RA@mail.gmail.com>
 <aD76cCE5qyALjKHc@debian.local>
In-Reply-To: <aD76cCE5qyALjKHc@debian.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Jun 2025 15:59:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gy1Fi6QYw1XYwfszZN=x5O=gWDnassPfsh5RY5_Ap-fg@mail.gmail.com>
X-Gm-Features: AX0GCFtkYKFF_TFvKerspJLAsqHSQV36SIt8zWO8vVSk14cy87pDGd1iE5I0DQM
Message-ID: <CAJZ5v0gy1Fi6QYw1XYwfszZN=x5O=gWDnassPfsh5RY5_Ap-fg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] PM: sleep: Suspend async parents after suspending
 children
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Mario Limonciello <superm1@kernel.org>, 
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>, 
 Saravana Kannan <saravanak@google.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 3, 2025 at 3:36=E2=80=AFPM Chris Bainbridge
<chris.bainbridge@gmail.com> wrote:
>
> On Tue, Jun 03, 2025 at 03:04:33PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Jun 3, 2025 at 2:27=E2=80=AFPM Chris Bainbridge
> > <chris.bainbridge@gmail.com> wrote:
> > >
> > > On Tue, 3 Jun 2025 at 13:24, Rafael J. Wysocki <rafael@kernel.org> wr=
ote:
> > > > >
> > > > > This patch does fix the list corruption, but the "Unbalanced
> > > > > pm_runtime_enable" still occurs:
> > > >
> > > > Have you applied it together with the previous patch?
> > >
> > > Yes
> >
> > So it looks like some devices have power.is_suspended set from the
> > previous cycle which causes device_resume() to attempt to resume them
> > even though they have not been suspended in the current cycle yet.
> >
> > Please try the attached patch in addition to the previous 2 patches.
> >
> > Thanks!
>
> That fixed it. Passed 30 attempted suspends without error.
>
> Reported-and-tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>

Thanks for verifying!

I will add changelogs to the patches and send them later today.
