Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76209C43461
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 07:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A91420771
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 07:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNuL53mm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A91420771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74CB56E348;
	Wed, 16 Sep 2020 07:32:54 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E7A56E2E5;
 Wed, 16 Sep 2020 06:32:26 +0000 (UTC)
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4F7B0206A5;
 Wed, 16 Sep 2020 06:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600237945;
 bh=wRtARHe2LKkE2nHSoQVtqIGXlzPYT4T/Rf9r1//fVC4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KNuL53mmpCgivYk8/Ekcnpr4cCgcJhha4/zMX2JhQwHAI9bPQ+9b2Xc2HXSW31eVE
 2nlIErWqRfPzvRVEzA8RRoXQFMvD5dLPGYTE5vPOs6QzCWIgWVljFaQLmm1SmdYDBg
 R/FXWzWVtRrUgZ1C0Gj93HDZHsysIbmqJoAEW5fo=
Date: Wed, 16 Sep 2020 08:33:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] Revert "drm/radeon: handle PCIe root ports with
 addressing limitations"
Message-ID: <20200916063300.GJ142621@kroah.com>
References: <20200915184607.84435-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200915184607.84435-1-alexander.deucher@amd.com>
X-Mailman-Approved-At: Wed, 16 Sep 2020 07:32:53 +0000
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
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 15, 2020 at 02:46:07PM -0400, Alex Deucher wrote:
> This change breaks tons of systems.

Very vague :(

This commit has also been merged for over a year, why the sudden
problem now?

> This reverts commit 33b3ad3788aba846fc8b9a065fe2685a0b64f713.

You mean "33b3ad3788ab ("drm/radeon: handle PCIe root ports with
addressing limitations")"?

That's the proper way to reference commits in changelogs please.  It's
even documented that way...

> 
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=206973
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=206697
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=207763
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1140
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1287
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: christian.koenig@amd.com

Fixes: 33b3ad3788ab ("drm/radeon: handle PCIe root ports with addressing limitations")

as well?

thanks,

greg k-h
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
