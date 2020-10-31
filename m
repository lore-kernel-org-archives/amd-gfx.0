Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B091EC2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 01:04:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5670421D91
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 01:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5670421D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEE1D6E101;
	Mon,  2 Nov 2020 01:04:44 +0000 (UTC)
Received: from smtprelay.hostedemail.com (smtprelay0067.hostedemail.com
 [216.40.44.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 059B26E098;
 Sat, 31 Oct 2020 11:52:55 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay01.hostedemail.com (Postfix) with ESMTP id 7E2E8100E7B42;
 Sat, 31 Oct 2020 11:52:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hate63_1d141c52729e
X-Filterd-Recvd-Size: 2182
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf07.hostedemail.com (Postfix) with ESMTPA;
 Sat, 31 Oct 2020 11:52:51 +0000 (UTC)
Message-ID: <0b818156537f354904938f437cbb9dd02e765653.camel@perches.com>
Subject: Re: [Outreachy kernel] [PATCH] drm/amdgpu: use
 DEFINE_DEBUGFS_ATTRIBUTE with debugfs_create_file_unsafe()
From: Joe Perches <joe@perches.com>
To: Greg KH <gregkh@linuxfoundation.org>, Deepak R Varma <mh12gx2825@gmail.com>
Date: Sat, 31 Oct 2020 04:52:50 -0700
In-Reply-To: <20201030080316.GA1612206@kroah.com>
References: <20201030032245.GA274478@my--box>
 <20201030071120.GA1493629@kroah.com> <20201030075716.GA6976@my--box>
 <20201030080316.GA1612206@kroah.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 02 Nov 2020 01:04:44 +0000
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
Cc: David Airlie <airlied@linux.ie>, daniel.vetter@ffwll.ch,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 melissa.srw@gmail.com, outreachy-kernel@googlegroups.com,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 2020-10-30 at 09:03 +0100, Greg KH wrote:
> On Fri, Oct 30, 2020 at 01:27:16PM +0530, Deepak R Varma wrote:
> > On Fri, Oct 30, 2020 at 08:11:20AM +0100, Greg KH wrote:
> > > On Fri, Oct 30, 2020 at 08:52:45AM +0530, Deepak R Varma wrote:
> > > > Using DEFINE_DEBUGFS_ATTRIBUTE macro with debugfs_create_file_unsafe()
> > > > function in place of the debugfs_create_file() function will make the
> > > > file operation struct "reset" aware of the file's lifetime. Additional
> > > > details here: https://lists.archive.carbon60.com/linux/kernel/2369498
> > > > 
> > > > Issue reported by Coccinelle script:
> > > > scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
[]
> There is a reason we didn't just do a global search/replace for this in
> the kernel when the new functions were added, so I don't know why
> checkpatch is now saying it must be done.

I think it's not a checkpatch warning here.

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
