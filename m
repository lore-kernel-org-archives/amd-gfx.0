Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FC0C7618E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 12:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E71B110E1C7;
	Mon, 24 Apr 2023 12:55:38 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AF9610E033
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Apr 2023 15:19:09 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E13C960B5C;
 Sat, 22 Apr 2023 15:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66AAC433D2;
 Sat, 22 Apr 2023 15:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1682176745;
 bh=EPGp9mwptWpG5U63B+pnun33N1H599DB6CRsQ6ixZDM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n264ezueVgts/7QaQfVrnGgt+FN9VvVhkEOk0Uzzmy9bt7owvdCsJNgYMzh3cyPmY
 bc6i+FSqxoBbbn3i5FEUSI5uTvY1/WHlx/K03nMUVbyq/TIs49+QD0scFGqNQew8Y2
 Z5MnYOmJKf1+uTKY54kf6TVafU9S+JTdqtkEpDA0=
Date: Sat, 22 Apr 2023 17:19:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH 6.1.y] drm/amdgpu/vcn: Disable indirect SRAM on Vangogh
 broken BIOSes
Message-ID: <2023042255-cartel-semester-a707@gregkh>
References: <20230418221522.1287942-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418221522.1287942-1-gpiccoli@igalia.com>
X-Mailman-Approved-At: Mon, 24 Apr 2023 12:55:37 +0000
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
Cc: sashal@kernel.org, kernel@gpiccoli.net, amd-gfx@lists.freedesktop.org,
 stable@vger.kernel.org, kernel-dev@igalia.com, alexander.deucher@amd.com,
 James.Zhu@amd.com, leo.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 18, 2023 at 07:15:22PM -0300, Guilherme G. Piccoli wrote:
> commit 542a56e8eb4467ae654eefab31ff194569db39cd upstream.
> 
> The VCN firmware loading path enables the indirect SRAM mode if it's
> advertised as supported. We might have some cases of FW issues that
> prevents this mode to working properly though, ending-up in a failed
> probe. An example below, observed in the Steam Deck:
> 
> [...]
> [drm] failed to load ucode VCN0_RAM(0x3A)
> [drm] psp gfx command LOAD_IP_FW(0x6) failed and response status is (0xFFFF0000)
> amdgpu 0000:04:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring vcn_dec_0 test failed (-110)
> [drm:amdgpu_device_init.cold [amdgpu]] *ERROR* hw_init of IP block <vcn_v3_0> failed -110
> amdgpu 0000:04:00.0: amdgpu: amdgpu_device_ip_init failed
> amdgpu 0000:04:00.0: amdgpu: Fatal error during GPU init
> [...]
> 
> Disabling the VCN block circumvents this, but it's a very invasive
> workaround that turns off the entire feature. So, let's add a quirk
> on VCN loading that checks for known problematic BIOSes on Vangogh,
> so we can proactively disable the indirect SRAM mode and allow the
> HW proper probe and VCN IP block to work fine.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2385
> Fixes: 82132ecc5432 ("drm/amdgpu: enable Vangogh VCN indirect sram mode")
> Fixes: 9a8cc8cabc1e ("drm/amdgpu: enable Vangogh VCN indirect sram mode")
> Cc: stable@vger.kernel.org
> Cc: James Zhu <James.Zhu@amd.com>
> Cc: Leo Liu <leo.liu@amd.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
> 
> Hi folks, this was build/boot tested on Deck. I've also adjusted the
> context, function was reworked on 6.2.
> 
> But what a surprise was for me not see this fix already in 6.1.y, since
> I've CCed stable, and the reason for that is really peculiar:

Now queued up, thanks.

greg k-h
