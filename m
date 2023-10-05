Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4607AE92729
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 19:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE73610E486;
	Thu,  5 Oct 2023 19:13:06 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3EE710E486
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 19:12:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 438C3B81D35;
 Thu,  5 Oct 2023 19:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A1BC433C7;
 Thu,  5 Oct 2023 19:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1696533157;
 bh=Tw3qLeOmMTt4rHHH7mPpiRpz5PuKOiA4vb2uC+WvlSw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Icl9ZnxhNZ9axTPJ3rWpt9hqEoZ+gCF3stfdVpGBe28IfMgSRmTEcD0/FFy7zNbYy
 6s5a95iVYvRJKKiymeDldptrrUTfM8XaBBYTF3yyt8uSDA24cd33VnGJ8+APELmOFd
 YYWLV/y+lDT7j7tSOEVme9yDD11LN277GErCzu0Y=
Date: Thu, 5 Oct 2023 21:12:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 2/2] Revert "drm/amd/pm: workaround for the wrong ac
 power detection on smu 13.0.0"
Message-ID: <2023100547-vitamins-detergent-4d18@gregkh>
References: <20231005175230.232764-1-mario.limonciello@amd.com>
 <20231005175230.232764-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005175230.232764-3-mario.limonciello@amd.com>
X-Mailman-Approved-At: Thu, 05 Oct 2023 19:13:05 +0000
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
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 linux-usb@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Wolfram Sang <wsa@kernel.org>, Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 05, 2023 at 12:52:30PM -0500, Mario Limonciello wrote:
> This reverts commit 0e5e1a84f0b8c814d502a135824244127fed8f23.
> 
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

No explaination as to why this needs to be reverted?  And does this need
to be backported anywhere?

thanks,

greg k-h
