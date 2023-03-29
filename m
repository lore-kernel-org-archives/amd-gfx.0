Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08471C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 07:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DB4410E4E0;
	Wed, 29 Mar 2023 07:54:01 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2163E10E257
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 07:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=c0DagGnX42QzeNj2UXakQh0Ab7J7fUDwI+PuwWFvT1M=; b=CMoMVBzCqLO5Ie7wpLeEHeRHt8
 Q8nSt/jQqGM7hBcPHpO1zbV4A++/lrsC9dr1x//dvOOuvPvfj8HWikRdviH2mgr9XjvQdk7lWtB3V
 A4RqfKlZsb/I0i2MT4c+fiTtWbZY1PEA/s06OXzEA3btiylpIeyW0+upd9lgx3rkhKescS3bJKmy4
 eeuS6jiqOhB7NA1AldYLIDtuJ/68GoCIw1inkQMffSm+n58RwjleegizG1lSQMr7Gdsd3NNPxJYsC
 CDX4+UgXhHWWq6sOPpRhPvXaxR7R+Nxj4EUfQYu16aH6gMtdCm56HNUpvJBEe6rpyVp5sEkrTtqlL
 ZqrhIvQg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1phPwn-009BuN-8A; Wed, 29 Mar 2023 07:10:17 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3A4C83002A3;
 Wed, 29 Mar 2023 09:10:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 181A6201D9953; Wed, 29 Mar 2023 09:10:14 +0200 (CEST)
Date: Wed, 29 Mar 2023 09:10:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Wenyou Yang <WenYou.Yang@amd.com>
Subject: Re: [PATCH v3 1/2] cpu/smt: add a notifier to notify the SMT changes
Message-ID: <20230329071014.GC7701@hirez.programming.kicks-ass.net>
References: <20230329015149.870132-1-WenYou.Yang@amd.com>
 <20230329015149.870132-2-WenYou.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329015149.870132-2-WenYou.Yang@amd.com>
X-Mailman-Approved-At: Wed, 29 Mar 2023 07:53:59 +0000
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
Cc: evan.quan@amd.com, kunliu13@amd.com, ying.li@amd.com, Xinhui.Pan@amd.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 jpoimboe@kernel.org, kim.phillips@amd.com, gpiccoli@igalia.com,
 mario.limonciello@amd.com, alexander.deucher@amd.com, tglx@linutronix.de,
 bp@suse.de, christian.koenig@amd.com, richardqi.liang@amd.com,
 weiyuan2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 29, 2023 at 09:51:48AM +0800, Wenyou Yang wrote:
> Add the notifier chain to notify the cpu SMT status changes
> 

Why!?!? What's the purpose of all this? IIRC this doesn't trigger if you
manually disable all the siblings. And because you didn't tell us why
you need this I can't tell you if that matters or not :/
