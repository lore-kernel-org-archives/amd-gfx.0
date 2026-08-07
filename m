Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4F0C5AE49
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F3B010E676;
	Mon, 10 Aug 2026 06:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="boDauy8K";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72AFC10E3F6
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 09:20:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B6D2F40A65;
 Fri,  7 Aug 2026 09:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B6A1F000E9;
 Fri,  7 Aug 2026 09:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1786094434;
 bh=Jn+fiI9qmYUQjFZpzjR7v8a31r2Lb/Xd14bKyYsHu9s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=boDauy8KYulJNR81WiYKgIA86Tp7nsjT7KTsnzGIiay5RmkWKEI6iYogt7ZaV6CYe
 GqJvnT+MhSZOe+erce3CR1Y7luVIRcaEjvbADGlNncVngU5m81plYQx9QXanLN79of
 c8xgPIQGKNp1qPG0oGPby/cYfFnGG1uPL6JbHwT8=
Date: Fri, 7 Aug 2026 11:20:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Leo Li <sunpeng.li@amd.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, David Weber <weber.aulendorf@gmail.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 7.1.y] drm/amd/display: Exit idle optimizations before
 programming
Message-ID: <2026080707-deem-ascend-927c@gregkh>
References: <20260805163314.214623-1-sunpeng.li@amd.com>
 <20260806021809.0021-sashal@kernel.org>
 <ac4c0e75-fbaf-4264-8794-d3f86eebb014@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac4c0e75-fbaf-4264-8794-d3f86eebb014@amd.com>
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:02 +0000
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

On Thu, Aug 06, 2026 at 09:42:42AM -0400, Leo Li wrote:
> 
> 
> On 2026-08-06 07:36, Sasha Levin wrote:
> > This doesn't apply cleanly to 7.1?
> > 
> 
> Hi Sasha,
> 
> Looks like the tagged "Fixes:" hasn't landed in 7.1 yet. This patch depends on it.
> See the 7.1 backport of it here: https://lore.kernel.org/stable/3956c589-2fbb-49af-b0bb-8aeff0cd56db@amd.com/

So what are we supposed to do here?
