Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14C9C00140
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Aug 2022 08:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B74FE10F379;
	Wed, 24 Aug 2022 08:30:06 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B8D310EE52
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Aug 2022 08:29:43 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4MCK5Y6q20z9sQq;
 Wed, 24 Aug 2022 10:29:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1661329777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26NeHTGm7e9EEAKJl9DyR/UzxI4df0KxXaJOPa3e9g4=;
 b=vjH0wldRmNoh2CTi/zE6l1+1///DzwLjL2dq5fVO8YQqra467yVMwbF+QQQm+evvrwuDuQ
 331bMaCmWjPmXT5o3PcLNuO2zWDUoFPSlulH/IgZKB9cczxhTF0Nu2E98Hjd7gHeZa2OA7
 rbc8jTD1VAirHd/U2ZEyQMRN0G+ClJtSRyX6i2KiH3No9h4AnnnahsfcJxmo0Kvk56P1sP
 Qd5d2YBTI9YU+0wa0aq5SCXd4vpCkXD8eVu3wiik/oRlXAfk76TRE2rIqiovbbPqlX/aJN
 u9VF1o+2xhjKruvohSveA4fOMAqBL1hHfQL1k9MAG+xMK9yCxBJ3i+jEZOOjbg==
Message-ID: <02f71087-6cdc-cd9a-940f-2e7084a41597@mailbox.org>
Date: Wed, 24 Aug 2022 10:29:31 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/sced: Add FIFO policy for scheduler rq
Content-Language: en-CA
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 dri-devel@lists.freedesktop.org
References: <20220822200917.440681-1-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20220822200917.440681-1-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 91bf8bba033e3884e97
X-MBO-RS-META: ztc3j448k49exjn1z6a11kmakk3sthmx
X-Rspamd-Queue-Id: 4MCK5Y6q20z9sQq
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
Cc: ckoenig.leichtzumerken@gmail.com, Li Yunxiang <Yunxiang.Li@amd.com>,
 luben.tuikov@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-08-22 22:09, Andrey Grodzovsky wrote:
> Poblem: Given many entities competing for same rq on
> same scheduler an uncceptabliy long wait time for some
> jobs waiting stuck in rq before being picked up are
> observed (seen using  GPUVis).
> The issue is due to Round Robin policy used by scheduler
> to pick up the next entity for execution. Under stress
> of many entities and long job queus within entity some
> jobs could be stack for very long time in it's entity's
> queue before being popped from the queue and executed
> while for other entites with samller job queues a job
> might execute ealier even though that job arrived later
> then the job in the long queue.
> 
> Fix:
> Add FIFO selection policy to entites in RQ, chose next enitity
> on rq in such order that if job on one entity arrived
> ealrier then job on another entity the first job will start
> executing ealier regardless of the length of the entity's job
> queue.

Instead of ordering based on when jobs are added, might it be possible to order them based on when they become ready to run?

Otherwise it seems possible to e.g. submit a large number of inter-dependent jobs at once, and they would all run before any jobs from another queue get a chance.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

