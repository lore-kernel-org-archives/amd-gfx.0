Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB330C77B77
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Apr 2023 12:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AE4310E4A7;
	Mon, 17 Apr 2023 12:44:58 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5BC810E196;
 Mon, 17 Apr 2023 12:44:54 +0000 (UTC)
Received: from pendragon.ideasonboard.com
 (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id EE06EF95;
 Mon, 17 Apr 2023 14:44:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1681735487;
 bh=zwJu2smQro8gmZkUISaFthzO1JFoFUjclNsgTOGhq0k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jZ7cALUflLY2jyyw1/dLRTBCqWHq1/RUmoJ5Si1ueg48oDpqAbGTIXMBJ8Y8bBhP6
 HOjdpcPmTDxfQXDLILaV4dzIVvZYJHHveKKNHpQZSknABUEVx+uX2AycGenjhTwann
 OJG2W+YXKBxe9nPuAmd1dieu4QpBgjoUFUHiRLiE=
Date: Mon, 17 Apr 2023 15:45:02 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Garcia <rgarcia@igalia.com>
Subject: Re: 2023 X.Org Foundation Membership deadline for voting in the
 election
Message-ID: <20230417124502.GB19964@pendragon.ideasonboard.com>
References: <ef4e39301a769ef83668074c341274e30db57f95.camel@igalia.com>
 <2b861d289edaab1c53c031f72de192fcddf85b13.camel@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b861d289edaab1c53c031f72de192fcddf85b13.camel@igalia.com>
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
Cc: xorg-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org,
 board <board@foundation.x.org>, members@x.org, amd-gfx@lists.freedesktop.org,
 events@lists.x.org, mesa-dev@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, libre-soc-dev@lists.libre-soc.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Ricardo,

On Mon, Mar 13, 2023 at 04:22:54PM +0100, Ricardo Garcia wrote:
> This is a reminder that the deadline for new memberships and renewals
> finishes in a couple of weeks. Original email follows.
> 
> Thanks for your attention.

I don't know if I'm the only one affected by this issue, but I've just
received today two months of e-mails from x.org, including all the
reminders aboud membership renewal and election nomination period. This
isn't the first time this happens, and the last time I was told there
was no automated process to quick the mail queues when errors happen,
making mails pile up forever on x.org's side until someone handles it
manually. This is something you really want to automate, or at least
monitored.

> On Wed, 2023-02-15 at 16:58 +0100, Ricardo Garcia wrote:
> > The 2023 X.Org Foundation elections are rapidly approaching. We will be
> > forwarding the election schedule and nominating process to the
> > membership shortly.
> > 
> > Please note that only current members can vote in the upcoming election,
> > and that the deadline for new memberships or renewals to vote in the
> > upcoming election is 26 March 2023 at 23:59 UTC.
> > 
> > If you are interested in joining the X.Org Foundation or in renewing
> > your membership, please visit the membership system site at:
> > https://members.x.org/
> > 
> > Ricardo Garcia, on behalf of the X.Org elections committee

-- 
Regards,

Laurent Pinchart
