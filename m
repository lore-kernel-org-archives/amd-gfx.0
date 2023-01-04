Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21CEC46467
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 14:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 699B310E1FB;
	Wed,  4 Jan 2023 14:18:54 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F38D810E085;
 Wed,  4 Jan 2023 12:38:08 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 45DB961259;
 Wed,  4 Jan 2023 12:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF75C433D2;
 Wed,  4 Jan 2023 12:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1672835887;
 bh=mZ1yQV6qgagBCn4KzMBLklPWpB3lKrVvtA6CvGf8SBM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=naslG5MxxmqKLIV+Z1H4AwcExPULYIym7Tj3pANslk7YZhnjKN/uFiFBP2jYgQeTe
 FK6XHtkX4T7ZMaBYh7pInU/Ulfg/1y4PoXx9aAHVzjf+CBzOzdzrLV60H37eZR8XvW
 bbOlmwUOqCqrX0tzT8U/8Pl6t8KNohme6DjLXg2o=
Date: Wed, 4 Jan 2023 13:38:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dragos-Marian Panait <dragos.panait@windriver.com>
Subject: Re: [PATCH 4.19 0/1] drm/amdkfd: Check for null pointer after
 calling kmemdup
Message-ID: <Y7VzLI/GhGtne+78@kroah.com>
References: <20230103184308.511448-1-dragos.panait@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103184308.511448-1-dragos.panait@windriver.com>
X-Mailman-Approved-At: Wed, 04 Jan 2023 14:18:53 +0000
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
Cc: Oded Gabbay <oded.gabbay@gmail.com>, David Zhou <David1.Zhou@amd.com>,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 03, 2023 at 08:43:07PM +0200, Dragos-Marian Panait wrote:
> The following commit is needed to fix CVE-2022-3108:

That's a funny cve, given that you can not ever trigger it in a system,
right?  Why was a CVE allocated for that?

{sigh}

