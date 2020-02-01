Return-Path: <SRS0=wWp/=3X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5379C3524E
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2020 08:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88AF420658
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2020 08:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AF420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D1B76EB53;
	Mon,  3 Feb 2020 08:27:46 +0000 (UTC)
X-Greylist: delayed 537 seconds by postgrey-1.36 at gabe;
 Sat, 01 Feb 2020 23:47:53 UTC
Received: from smtprelay.hostedemail.com (smtprelay0194.hostedemail.com
 [216.40.44.194])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A09A26E56D
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Feb 2020 23:47:53 +0000 (UTC)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 026DC1828AE40
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Feb 2020 23:38:57 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay08.hostedemail.com (Postfix) with ESMTP id A4059182CED28;
 Sat,  1 Feb 2020 23:38:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: flock06_30532222dbd16
X-Filterd-Recvd-Size: 2806
Received: from XPS-9350.home (unknown [47.151.135.224])
 (Authenticated sender: joe@perches.com)
 by omf03.hostedemail.com (Postfix) with ESMTPA;
 Sat,  1 Feb 2020 23:38:51 +0000 (UTC)
Message-ID: <b9b671508d478469c1ad43206dd29d770bfb7818.camel@perches.com>
Subject: Re: [PATCH] drm/amdkfd: Make process queues logs less verbose
From: Joe Perches <joe@perches.com>
To: Julian Sax <jsbc@gmx.de>, amd-gfx@lists.freedesktop.org
Date: Sat, 01 Feb 2020 15:37:43 -0800
In-Reply-To: <20200201231101.2127964-1-jsbc@gmx.de>
References: <20200201231101.2127964-1-jsbc@gmx.de>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 03 Feb 2020 08:27:45 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, 2020-02-02 at 00:11 +0100, Julian Sax wrote:
> During normal usage, especially if jobs are started and stopped in rapid
> succession, the kernel log is filled with messages like this:
> 
> [38732.522910] Restoring PASID 0x8003 queues
> [38732.666767] Evicting PASID 0x8003 queues
> [38732.714074] Restoring PASID 0x8003 queues
> [38732.815633] Evicting PASID 0x8003 queues
> [38732.834961] Restoring PASID 0x8003 queues
> [38732.840536] Evicting PASID 0x8003 queues
> [38732.869846] Restoring PASID 0x8003 queues
> [38732.893655] Evicting PASID 0x8003 queues
> [38732.927975] Restoring PASID 0x8003 queues
> 
> According to [1], these messages are expected, but they carry little
> value for the end user, so turn them into debug messages.
> 
> [1] https://github.com/RadeonOpenCompute/ROCm/issues/343

trivia:

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
[]
> @@ -604,7 +604,7 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>  		goto out;
> 
>  	pdd = qpd_to_pdd(qpd);
> -	pr_info_ratelimited("Evicting PASID 0x%x queues\n",
> +	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
>  			    pdd->process->pasid);

It would be nicer to realign all the subsequent lines in a
single statement to the now moved open parenthesis.

> 
>  	/* Mark all queues as evicted. Deactivate all active queues on
> @@ -650,7 +650,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>  		goto out;
> 
>  	pdd = qpd_to_pdd(qpd);
> -	pr_info_ratelimited("Evicting PASID 0x%x queues\n",
> +	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
>  			    pdd->process->pasid);

etc...


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
