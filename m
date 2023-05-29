Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B3EC77B7E
	for <amd-gfx@archiver.kernel.org>; Mon, 29 May 2023 19:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F30BC10E208;
	Mon, 29 May 2023 19:39:03 +0000 (UTC)
Received: from mailrelay4-1.pub.mailoutpod2-cph3.one.com
 (mailrelay4-1.pub.mailoutpod2-cph3.one.com [46.30.211.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62DFE10E24E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 May 2023 19:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ravnborg.org; s=rsa1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=hS9C7fWnDSPQZ58CnQCj5SHuhoWrOmFyL9LAfljaHzg=;
 b=TSG6EveYvpoZeDtJvX0S0rh8cPRm68zaX+nLQZziu3IJ5+uTkmDTZTE84nxTAIAY4Ruhg+Lvga8L+
 nkWTGHhBXkJVKW1hYZsulYVf0n7XuweNX+kFho/NbTkVSvPexZGTwVd4gYVHAroCGkFdxtIJe9y/6W
 PuU1/1cSrokjLt9QnsI1cGx4tFmnl0Hrf/BMkHvYuoQ4ikpapge7jFkAHnlH/JydZAYhnQfFjreh2m
 es9wAyzXGp61BLd0/rpX5uKm6rPyaOvuDptojcU9QHBIfQf3rlVH7eI8X19wGLGKAczV7wsyD47kiq
 Lx0ISnID16EndPqNVPNn99VVkrLdiuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=ravnborg.org; s=ed1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=hS9C7fWnDSPQZ58CnQCj5SHuhoWrOmFyL9LAfljaHzg=;
 b=zUwswgSuyFtdlgerXhHDRpVhe/ckMs2wC7vrz/tXGZL8S4IjG9LpJ3SNbcQNrDY5PvQbrrqGEPflI
 rn/gVP4DA==
X-HalOne-ID: 4ec6af59-fe58-11ed-8a77-592bb1efe9dc
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
 by mailrelay4 (Halon) with ESMTPSA
 id 4ec6af59-fe58-11ed-8a77-592bb1efe9dc;
 Mon, 29 May 2023 19:37:56 +0000 (UTC)
Date: Mon, 29 May 2023 21:37:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 00/13] drm/fbdev: Remove DRM's helpers for fbdev I/O
Message-ID: <20230529193755.GE1370714@ravnborg.org>
References: <20230524092150.11776-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524092150.11776-1-tzimmermann@suse.de>
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
Cc: freedreno@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 javierm@redhat.com, dri-devel@lists.freedesktop.org, mripard@kernel.org,
 daniel@ffwll.ch, linux-tegra@vger.kernel.org, airlied@gmail.com,
 linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Thomas.

> v4:
> 	* use initializer and generator macros for struct fb_ops
> 	* partially support damage handling in msm (Dmitri)

I like the macros. They make it simpler and we do not spread the _cfb_
misname to more files.


> v3:
> 	* fix Kconfig options (Jingfeng)
> 	* minimize changes to exynos (Sam)
> v2:
> 	* simplify Kconfig handling (Sam)
> 
> Thomas Zimmermann (13):
>   fbdev: Add Kconfig options to select different fb_ops helpers
>   fbdev: Add initializer macros for struct fb_ops


>   drm/armada: Use regular fbdev I/O helpers
>   drm/exynos: Use regular fbdev I/O helpers
>   drm/gma500: Use regular fbdev I/O helpers
>   drm/radeon: Use regular fbdev I/O helpers
>   drm/fbdev-dma: Use regular fbdev I/O helpers
>   drm/msm: Use regular fbdev I/O helpers
>   drm/omapdrm: Use regular fbdev I/O helpers
>   drm/tegra: Use regular fbdev I/O helpers
These are all:
Acked-by: Sam Ravnborg <sam@ravnborg.org>
