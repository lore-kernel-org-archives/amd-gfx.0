Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180ECC2D0CF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 07:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE3E10EAEC;
	Fri, 21 Jun 2024 07:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x2s4mr0Z";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 284AC10EB31
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:37:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7E4DF621F3;
 Thu, 20 Jun 2024 16:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A20DC2BD10;
 Thu, 20 Jun 2024 16:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1718901419;
 bh=DcaboQ7B3JmHo97botsQRQ+5atQTWcS0b/XRS7eC+xg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=x2s4mr0Z10Rgkos3+lh1fUBgwioOxg0KhpBgZRPsSWdrSptRvjvUizResDrTE18Mb
 1o3j1xiTy/8gd9S2+50r/x6avrxjDWZXDSVY8u6d2hlH6aSpE1O3yp6ZESL2fp5gVL
 pHE9f9RpOl+F/I3J+CaR42J6ecULHm4SyVGhyvVw=
Date: Thu, 20 Jun 2024 18:36:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, roman.li@amd.com, wayne.lin@amd.com,
 agustin.gutierrez@amd.com, chiahsuan.chung@amd.com,
 jerry.zuo@amd.com, Dillon Varone <dillon.varone@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH 21/39] drm/amd/display: Make DML2.1 P-State method force
 per stream
Message-ID: <2024062032-emoticon-nifty-337d@gregkh>
References: <20240620161145.2489774-1-alex.hung@amd.com>
 <20240620161145.2489774-22-alex.hung@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620161145.2489774-22-alex.hung@amd.com>
X-Mailman-Approved-At: Fri, 21 Jun 2024 07:13:20 +0000
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

On Thu, Jun 20, 2024 at 10:11:27AM -0600, Alex Hung wrote:
> From: Dillon Varone <dillon.varone@amd.com>
> 
> [WHY & HOW]
> Currently the force only works for a single display, make it so it can
> be forced per stream.
> 
> Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Acked-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Dillon Varone <dillon.varone@amd.com>

When submitting patches from others, you too have to sign-off on the
patch.  Read the DCO in the documentation for details.

thanks,

greg k-h
