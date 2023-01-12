Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7E6C54EBE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 16:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5769710E2F6;
	Thu, 12 Jan 2023 16:49:39 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A85B10E2FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 16:49:10 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id EE8D3B81EE6;
 Thu, 12 Jan 2023 16:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292B8C433D2;
 Thu, 12 Jan 2023 16:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1673542147;
 bh=VQBygNuP8yrIEuw0qYWh/djMhCafZON+WlX6T9VzRik=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mJ2uK8ydeG+r7kGt3EX8LMB0MXD+CCkIr5sg71RfxpDSNcQgbn9ypA23TA9xOarvL
 tPk7a4w9h9nYlnM3w7FoHZR9Qx/hVjrXaDv2jvUh8QSIqCtUMnTZNtVl5nZ3hgp58H
 kIEIaYGpY9ru6uyZoiL/Ktp5/iBwZqx4U7osI2z0=
Date: Thu, 12 Jan 2023 17:49:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 6.0 108/148] drm/amdgpu: Fix size validation for
 non-exclusive domains (v4)
Message-ID: <Y8A6AC9DrYfO1c4+@kroah.com>
References: <20230110180017.145591678@linuxfoundation.org>
 <20230110180020.610387724@linuxfoundation.org>
 <e4b4b0ca-b6e6-70ae-1652-3df71df53ab4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4b4b0ca-b6e6-70ae-1652-3df71df53ab4@amd.com>
X-Mailman-Approved-At: Thu, 12 Jan 2023 16:49:37 +0000
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
Cc: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev,
 AMD Graphics <amd-gfx@lists.freedesktop.org>, stable@vger.kernel.org,
 Alex Deucher <Alexander.Deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 12, 2023 at 11:25:08AM -0500, Luben Tuikov wrote:
> Hi Greg,
> 
> The patch in the link is a Fixes patch of the quoted patch, and should also go in:
> 
> https://lore.kernel.org/all/20230104221935.113400-1-luben.tuikov@amd.com/

Is that in Linus's tree already?  if so, what is the git commit id?

thanks,

greg k-h
