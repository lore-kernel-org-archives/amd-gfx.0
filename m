Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24326C07E96
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 05:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909E461360
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 05:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909E461360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7F36E519;
	Thu, 15 Jul 2021 05:08:19 +0000 (UTC)
X-Greylist: delayed 963 seconds by postgrey-1.36 at gabe;
 Thu, 15 Jul 2021 05:08:17 UTC
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com
 [91.221.196.215])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0CC56E519
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 05:08:17 +0000 (UTC)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
 by mx1.smtp.larsendata.com (Halon) with ESMTPS
 id 686ca631-e528-11eb-9082-0050568c148b;
 Thu, 15 Jul 2021 04:52:07 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net
 [80.162.45.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: sam@ravnborg.org)
 by mail01.mxhotel.dk (Postfix) with ESMTPSA id C362D194B05;
 Thu, 15 Jul 2021 06:52:24 +0200 (CEST)
Date: Thu, 15 Jul 2021 06:52:09 +0200
X-Report-Abuse-To: abuse@mxhotel.dk
From: Sam Ravnborg <sam@ravnborg.org>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [pull] amdgpu, amdkfd drm-fixes-5.14
Message-ID: <YO+++Tj94RRjVqwV@ravnborg.org>
References: <20210714220858.5553-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210714220858.5553-1-alexander.deucher@amd.com>
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
Cc: daniel.vetter@ffwll.ch, airlied@gmail.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex,

On Wed, Jul 14, 2021 at 06:08:58PM -0400, Alex Deucher wrote:
> Hi Dave, Daniel,
> 
> Fixes for 5.14.  The big change here is unifying the SMU13 code.  This was
> new code added in 5.14 to support Yellow Carp, but we've since cleaned it
> up and removed a lot of duplication, so better to merge it now to facilitate
> any bug fixes in the future that need to go back to this kernel via stable.
> Only affects Yellow Carp which is new for 5.14 anyway so not much chance for
> regressions.  The rest is just standard bug fixes.

This pull seems not to include any fixes for the W=1 warnings that
has crept in again. It would be nice if the amdgpu could be warning free
again, this would maybe motivate the others to fix theirs too so we
could keep most/all of drivers/gpu/ free of W=1 warnings.

	Sam
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
