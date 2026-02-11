Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A770DE9E30D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 13:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36A5610E615;
	Wed, 11 Feb 2026 13:56:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M5UzgdeW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89ACA10E294;
 Wed, 11 Feb 2026 09:19:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A8535600CB;
 Wed, 11 Feb 2026 09:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D646CC4CEF7;
 Wed, 11 Feb 2026 09:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1770801581;
 bh=58Z4uB9Pkeol6hTI7MeGr7wp1yT5hcTC8QqAYBryOUM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M5UzgdeWozsUWlySaOYUfwVPWb5tNvgUx4Jz7Ar0o3Tf5GDnWXCe14TiuPNyX/x8e
 OyT8z5Kz9bWqmS6r4uJAlrBKfOViNTICENxGnoWxx5kJBQ+tuSsxXInCirkk20r4vO
 x3kpKmsWcKoqmAZFM0CavOjzN5HpVKZFNYNfyo14=
Date: Wed, 11 Feb 2026 10:19:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Michele Palazzi <sysdadmin@m1k.cloud>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 harry.wentland@amd.com, sunpeng.li@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 mario.limonciello@amd.com, Rodrigo.Siqueira@igalia.com,
 alex.hung@amd.com, aurabindo.pillai@amd.com, stable@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: add module param to disable immediate
 vblank off
Message-ID: <2026021146-mockup-pushup-5f47@gregkh>
References: <20260211074529.131290-1-sysdadmin@m1k.cloud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211074529.131290-1-sysdadmin@m1k.cloud>
X-Mailman-Approved-At: Wed, 11 Feb 2026 13:56:40 +0000
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

On Wed, Feb 11, 2026 at 08:45:29AM +0100, Michele Palazzi wrote:
> Add amdgpu.no_vblank_immediate parameter to optionally disable the
> immediate vblank disable path on DCN35+ non-PSR CRTCs. When set to 1,
> a 2-frame offdelay is used instead, matching the behavior used for
> older hardware and DGPUs.

Please no more module parameters, this is not the 1990's with only one
one device in the system.  Please fix this the proper way.

Also, this isn't the correct way to submit patches to stable.

thanks,

greg k-h
