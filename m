Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A389CC2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 15:34:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4745320735
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 15:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y5L54ijl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4745320735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA8146ECEA;
	Tue,  3 Nov 2020 15:34:07 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 157E56E8C0;
 Tue,  3 Nov 2020 15:33:15 +0000 (UTC)
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 498D820735;
 Tue,  3 Nov 2020 15:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604417594;
 bh=W571NPcDIE5ZXTV/zMmJykXxM0qZYlkoHanLbG2nw84=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=y5L54ijl1bqs8JZb6DcGz/lO1YgExP6G6NybEcPB+sixrb+cWycBsL9TswlWNukSi
 tLqeNWfqpLtPZG9m/Cuj96MhweqpAseCwLrhU4KtrmVFRKCHyu+RuoeY2gzCSeoJ6s
 /TKSJFxHuRliMLwfp9anZkiBE8ztwtSE/kizOM9Y=
Date: Tue, 3 Nov 2020 16:34:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: do not initialise global variables to 0 or
 NULL
Message-ID: <20201103153407.GB3267686@kroah.com>
References: <20201102184147.GA42288@localhost>
 <CADnq5_OnA3T_p4pTEOpoqQ=NZyso2VFoDiOHu=+h7dKOeKHq-A@mail.gmail.com>
 <c916ae88-5933-ab06-ad32-d87f00cac21f@gmail.com>
 <20201103065324.GD75930@kroah.com>
 <MN2PR12MB4488F91151FA17018306F92AF7110@MN2PR12MB4488.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MN2PR12MB4488F91151FA17018306F92AF7110@MN2PR12MB4488.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Tue, 03 Nov 2020 15:34:07 +0000
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
Cc: Deepak R Varma <mh12gx2825@gmail.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Melissa Wen <melissa.srw@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexdeucher@gmail.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 03, 2020 at 02:50:40PM +0000, Deucher, Alexander wrote:
> [AMD Public Use]
> =

> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Tuesday, November 3, 2020 1:53 AM
> > To: Koenig, Christian <Christian.Koenig@amd.com>
> > Cc: Alex Deucher <alexdeucher@gmail.com>; Deepak R Varma
> > <mh12gx2825@gmail.com>; David Airlie <airlied@linux.ie>; LKML <linux-
> > kernel@vger.kernel.org>; Maling list - DRI developers <dri-
> > devel@lists.freedesktop.org>; Melissa Wen <melissa.srw@gmail.com>;
> > amd-gfx list <amd-gfx@lists.freedesktop.org>; Daniel Vetter
> > <daniel@ffwll.ch>; Daniel Vetter <daniel.vetter@ffwll.ch>; Deucher,
> > Alexander <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: do not initialise global variables to =
0 or
> > NULL
> > =

> > On Mon, Nov 02, 2020 at 09:06:21PM +0100, Christian K=F6nig wrote:
> > > Am 02.11.20 um 20:43 schrieb Alex Deucher:
> > > > On Mon, Nov 2, 2020 at 1:42 PM Deepak R Varma
> > <mh12gx2825@gmail.com> wrote:
> > > > > Initializing global variable to 0 or NULL is not necessary and
> > > > > should be avoided. Issue reported by checkpatch script as:
> > > > > ERROR: do not initialise globals to 0 (or NULL).
> > > > I agree that this is technically correct, but a lot of people don't
> > > > seem to know that so we get a lot of comments about this code for
> > > > the variables that are not explicitly set.  Seems less confusing to
> > > > initialize them even if it not necessary.  I don't have a
> > > > particularly strong opinion on it however.
> > >
> > > Agree with Alex.
> > >
> > > Especially for the module parameters we should have a explicit init
> > > value for documentation purposes, even when it is 0.
> > =

> > Why is this one tiny driver somehow special compared to the entire rest=
 of
> > the kernel?  (hint, it isn't...)
> > =

> > Please follow the normal coding style rules, there's no reason to ignor=
e them
> > unless you like to constantly reject patches like this that get sent to=
 you.
> > =

> =

> I'll apply the patch, but as a data point, this is the first time I've
> gotten a patch to make this change.  I get several bug reports or
> patches every year to explicitly set values to global variables
> because users assume they are not initialized.  So it will always be a
> trade off as to which patches you want to NACK.

Are you all not running your patches through checkpatch.pl to tell you
simple things like this?  If no, I suggest you start doing that :)

thanks,

greg k-h
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
