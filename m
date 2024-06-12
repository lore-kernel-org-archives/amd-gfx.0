Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E550BC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jun 2024 09:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7458F10E9CE;
	Thu, 13 Jun 2024 09:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WRP3bIWo";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E21AE10E849;
 Wed, 12 Jun 2024 12:44:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8DE6F6144A;
 Wed, 12 Jun 2024 12:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E17C3277B;
 Wed, 12 Jun 2024 12:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1718196273;
 bh=1/B4yRI/9Xj67nhFRukq/WUcqq8ryLg3lr4o7PviOdc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WRP3bIWoLvdDYRQGgU4uiucjc4e2iPFQNQ6DMeckRyZWZLY6B1bOFoRhJ5+6K9Pik
 fGjx4BE5kxTqZzWCT/7vb43Uj8ZPtB5LbGGIC77vstcNAjytKCxpmBK3j832ndU0bc
 /6xOxA91rAKX9pa4MRRlhstaTYvQh6PlMwfyf/io=
Date: Wed, 12 Jun 2024 14:44:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthew Ruffell <matthew.ruffell@canonical.com>
Cc: w_armin@gmx.de, Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Felix.Kuehling@amd.com, Prike.Liang@amd.com, Xinhui.Pan@amd.com,
 Yifan1.Zhang@amd.com, amd-gfx@lists.freedesktop.org,
 bkauler@gmail.com, dri-devel@lists.freedesktop.org,
 sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "drm/amdgpu: init iommu after amdkfd device init"
Message-ID: <2024061223-suitable-handler-b6f2@gregkh>
References: <fe03d95a-a8dd-4f4c-8588-02a544e638e7@gmx.de>
 <20240612001037.10409-1-matthew.ruffell@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612001037.10409-1-matthew.ruffell@canonical.com>
X-Mailman-Approved-At: Thu, 13 Jun 2024 09:28:51 +0000
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

On Wed, Jun 12, 2024 at 12:10:37PM +1200, Matthew Ruffell wrote:
> Hi Greg KH, Sasha,
> 
> Please pick up this patch for 5.15 stable tree. I have built a test kernel and
> can confirm that it fixes affected users.
> 
> Downstream bug:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2068738

Sorry for the delay, now picked up.

greg k-h
