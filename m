Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83873C021A0
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2025 08:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B4B10E256;
	Mon, 17 Feb 2025 08:02:01 +0000 (UTC)
X-Greylist: delayed 1144 seconds by postgrey-1.36 at gabe;
 Sun, 16 Feb 2025 21:06:17 UTC
Received: from vps-ovh.mhejs.net (vps-ovh.mhejs.net [145.239.82.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B676C10E0A0
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Feb 2025 21:06:17 +0000 (UTC)
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tjlXh-00000007Mme-24sX; Sun, 16 Feb 2025 21:47:09 +0100
Message-ID: <ecbc5fd0-06fd-4de3-b77e-f0af24377f12@maciej.szmigiero.name>
Date: Sun, 16 Feb 2025 21:47:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu/pm/legacy: fix suspend/resume issues
To: Alex Deucher <alexander.deucher@amd.com>
Cc: "chr[]" <chris@rudorff.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20250212161129.2712730-1-alexander.deucher@amd.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
In-Reply-To: <20250212161129.2712730-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 17 Feb 2025 08:02:00 +0000
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

On 12.02.2025 17:11, Alex Deucher wrote:
> From: "chr[]" <chris@rudorff.com>
> 
> resume and irq handler happily races in set_power_state()
> 
> * amdgpu_legacy_dpm_compute_clocks() needs lock
> * protect irq work handler
> * fix dpm_enabled usage
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2524
> Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in amdgpu_dpm.c")
> Signed-off-by: chr[] <chris@rudorff.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---

Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name> # on Oland PRO

Thanks,
Maciej

