Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DD9C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 19:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC38A10E109;
	Fri,  1 Dec 2023 19:21:20 +0000 (UTC)
X-Greylist: delayed 593 seconds by postgrey-1.36 at gabe;
 Fri, 01 Dec 2023 19:15:51 UTC
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5EC510E93E
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 19:15:49 +0000 (UTC)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
 by mxout3.routing.net (Postfix) with ESMTP id 20FA860476;
 Fri,  1 Dec 2023 19:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=20200217; t=1701457554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k1KGPYRvYIOKuqyRIUAMSTTl/RZtGgGj2cX3gmi3st0=;
 b=BXSOtP87w0sNXDfd1BKrhZ0Hu9DzSraAdttZSa5r69wfWBSQ48L8FmzDdyDP0q5WEf5aMr
 pOjLdc294/cw8DeKNBTR8HyXMgta9srVE0airsEOGrvlSoQfTaq7xS3+lwM8cgdcVB/qEv
 vTgM1OQ8HETN66b+cDRF/HmxMU/0Fx4=
Received: from [192.168.178.75]
 (dynamic-095-116-189-134.95.116.pool.telefonica.de [95.116.189.134])
 by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 4AF95360200;
 Fri,  1 Dec 2023 19:05:53 +0000 (UTC)
Subject: Re: Fwd: Thinkpad X13 AMD: Problems with external monitor wake up
 after suspend
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>
References: <8da256ea-b069-44f0-9cc2-93482c2f5eec@gmail.com>
 <da0efb19-c883-40c8-b284-7eb7f4d3640b@leemhuis.info>
From: Oliver Schmidt <oliver@luced.de>
Message-ID: <12db0c2e-a1b7-f8f9-278e-8aefe5619c1f@luced.de>
Date: Fri, 1 Dec 2023 20:05:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <da0efb19-c883-40c8-b284-7eb7f4d3640b@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mail-ID: 20b245b1-f3ff-4754-a7e8-c1632906f36e
X-Mailman-Approved-At: Fri, 01 Dec 2023 19:21:18 +0000
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
Cc: Stylon Wang <stylon.wang@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 01.12.23 12:37, Thorsten Leemhuis wrote:
> Maybe one of the developers among the recipients has a idea. Oliver, but
> if none of them replies any time soon, it would be best if you'd check
> if 6.6 (and/or 6.7-rc) is affected as well; and if reverting it there
> fixes it, too.

OK, I checked it: compiled a 6.6.3 kernel and got the same suspend-resume
problem as with the 6.1.57 and 6.1.64 kernels. I also was able to revert the
changes of commit ec5fa9 "drm/amd/display: Adjust the MST resume flow" in the
6.6.3 kernel and the problem was solved as in the 6.1.x kernels (however it
seems that resuming with the 6.6 kernel needs a little more time until the
monitor gets signal).

Best regards,
Oliver


