Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F087C001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 03:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C167910E619;
	Fri, 21 Jul 2023 03:51:44 +0000 (UTC)
X-Greylist: delayed 463 seconds by postgrey-1.36 at gabe;
 Fri, 21 Jul 2023 03:51:43 UTC
Received: from mail.mhcomputing.net (master.mhcomputing.net
 [IPv6:2607:f1c0:810:6500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D96E510E618
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 03:51:43 +0000 (UTC)
Received: by mail.mhcomputing.net (Postfix, from userid 1000)
 id 3532B113; Thu, 20 Jul 2023 20:43:59 -0700 (PDT)
Date: Thu, 20 Jul 2023 20:43:59 -0700
From: Matthew Hall <mhall@mhcomputing.net>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org
Subject: AMDGPU crash - request for assistance triaging / reporting
Message-ID: <20230721034359.GA1133@mhcomputing.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
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

Hello,

I see you are listed in the MAINTAINERS for Radeon / AMDGPU.

I would greatly appreciate your advice in the best route to a triage and fix for the following:

https://bugzilla.kernel.org/show_bug.cgi?id=217690

It makes it difficult to have a consistently stable Lenovo ThinkPad Z16 which I think is one of the best available AMD & Radeon laptops out today, and listed as supporting Linux officially.

I have about 30 years of programming experience, though none of it was on GPUs, so please let me know what I might be able to do in order to help figure this out.

Sincerely,
Matthew Hall
