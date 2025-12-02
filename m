Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E747D116F3
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 08:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C44210E749;
	Wed,  3 Dec 2025 08:52:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zWo6/0J9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BC3410E667;
 Tue,  2 Dec 2025 15:52:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EC45643ECA;
 Tue,  2 Dec 2025 15:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B39DC116B1;
 Tue,  2 Dec 2025 15:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1764690768;
 bh=a41Hc214ofss5go4vtnnf3ogCFKJwntca4v/HMvtCyM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zWo6/0J9iS7xicf0oIqwu5Ban7CvuP/EVNgTHUTLUd9ksrLbR/7SXHfxJdkUkA0sc
 cswn8w8i/9Jd8m3K5ZSe9fjcOPe7O09I43iY87/HobDCLg+FMhysn+uAyHEhKX9flP
 qxkIiMoEOFt+7PLVKfhFrbV51L1cGiQ5DWUfOfic=
Date: Tue, 2 Dec 2025 16:52:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 Javier Martinez Canillas <javierm@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 6.12.y] drm, fbcon, vga_switcheroo: Avoid race condition
 in fbcon setup
Message-ID: <2025120235-quartet-shrubs-0862@gregkh>
References: <2025120119-edgy-recycled-bcfe@gregkh>
 <20251201221055.1281985-1-sashal@kernel.org>
 <4dd8e529-4777-4cfc-a536-dbe0d0a90419@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dd8e529-4777-4cfc-a536-dbe0d0a90419@suse.de>
X-Mailman-Approved-At: Wed, 03 Dec 2025 08:52:29 +0000
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

On Tue, Dec 02, 2025 at 08:40:43AM +0100, Thomas Zimmermann wrote:
> Hi,
> 
> thanks for backporting.
> 
> You also have to remove the calls to vga_switcheroo_client_fb_set() from
> these files
> 
> https://elixir.bootlin.com/linux/v6.12/source/drivers/gpu/drm/i915/display/intel_fbdev.c
> https://elixir.bootlin.com/linux/v6.12/source/drivers/gpu/drm/radeon/radeon_fbdev.c

Can you send a fixed up patch instead?

thanks,

greg k-h
