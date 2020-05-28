Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC952C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 14:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E33205CB
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 14:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E33205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76B956E578;
	Thu, 28 May 2020 14:15:36 +0000 (UTC)
Received: from smtp.ispras.ru (winnie.ispras.ru [83.149.199.91])
 by gabe.freedesktop.org (Postfix) with ESMTP id 2A1346E0A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 14:13:44 +0000 (UTC)
Received: from monopod.intra.ispras.ru (monopod.intra.ispras.ru [10.10.3.121])
 by smtp.ispras.ru (Postfix) with ESMTP id 4653D201D0;
 Thu, 28 May 2020 17:13:42 +0300 (MSK)
Date: Thu, 28 May 2020 17:13:42 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Harry Wentland <hwentlan@amd.com>
Subject: Re: [PATCH] Revert "drm/amd/display: disable dcn20 abm feature for
 bring up"
In-Reply-To: <fc597b5e-147c-2a90-d7c7-bd5b01cdcfd2@amd.com>
Message-ID: <alpine.LNX.2.20.13.2005281710560.18802@monopod.intra.ispras.ru>
References: <20200528134807.5665-1-harry.wentland@amd.com>
 <alpine.LNX.2.20.13.2005281652440.18802@monopod.intra.ispras.ru>
 <fc597b5e-147c-2a90-d7c7-bd5b01cdcfd2@amd.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 28 May 2020 14:15:35 +0000
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
Cc: Hersen Wu <hersenxs.wu@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org,
 Michael Chiu <Michael.Chiu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On Thu, 28 May 2020, Harry Wentland wrote:

> On 2020-05-28 9:54 a.m., Alexander Monakov wrote:
> > 
> > 
> > On Thu, 28 May 2020, Harry Wentland wrote:
> > 
> >> This reverts commit 96cb7cf13d8530099c256c053648ad576588c387.
> >>
> >> This change was used for DCN2 bringup and is no longer desired.
> >> In fact it breaks backlight on DCN2 systems.
> > 
> > Reported-and-tested-by: Alexander Monakov <amonakov@ispras.ru>
> > 
> 
> Thanks, Alex.
> 
> Just to confirm, this fixes the backlight issue you were seeing?

I applied a similar fix to my kernel yesterday, and it worked fine.
Tested by changing brightness a few times. If any problems come up,
I'll send new reports.

Alexander
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
