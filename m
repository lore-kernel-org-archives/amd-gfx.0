Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193BAC0044D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 01:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B7E920739
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 01:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7E920739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 792836EA0E;
	Thu, 12 Mar 2020 01:33:18 +0000 (UTC)
Received: from smtprelay.hostedemail.com (smtprelay0007.hostedemail.com
 [216.40.44.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D77758931D;
 Wed, 11 Mar 2020 22:11:09 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id F39FF181D330D;
 Wed, 11 Mar 2020 22:11:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: loaf59_60ffb32fe5a07
X-Filterd-Recvd-Size: 1958
Received: from XPS-9350 (unknown [172.58.78.137])
 (Authenticated sender: joe@perches.com)
 by omf08.hostedemail.com (Postfix) with ESMTPA;
 Wed, 11 Mar 2020 22:11:06 +0000 (UTC)
Message-ID: <3fc2c61e4c1c25d847fd7f284c818b664b64441c.camel@perches.com>
Subject: Re: [PATCH -next 023/491] AMD KFD: Use fallthrough;
From: Joe Perches <joe@perches.com>
To: Felix Kuehling <felix.kuehling@amd.com>
Date: Wed, 11 Mar 2020 15:09:22 -0700
In-Reply-To: <12c75b17-1d0e-6cc4-4ed1-a6f5003772ae@amd.com>
References: <cover.1583896344.git.joe@perches.com>
 <3cfc40c8f750abc672d6a60418fe220cb663a0f5.1583896349.git.joe@perches.com>
 <12c75b17-1d0e-6cc4-4ed1-a6f5003772ae@amd.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 12 Mar 2020 01:33:17 +0000
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
Cc: "David \(ChunMing\)
 Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, 2020-03-11 at 17:50 -0400, Felix Kuehling wrote:
> On 2020-03-11 12:51 a.m., Joe Perches wrote:
> > Convert the various uses of fallthrough comments to fallthrough;
> > 
> > Done via script
> > Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
> 
> The link seems to be broken. This one works: 
> https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com/

Thanks.

I neglected to use a backslash on the generating script.
In the script in 0/491,

Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com/

likely should have been:

Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe\@perches.com/


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
