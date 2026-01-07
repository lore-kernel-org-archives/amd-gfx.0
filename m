Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8B5D185FD
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 13:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29D2010E727;
	Thu,  8 Jan 2026 13:37:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="BevhwU23";
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B52CB10E2DB
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 20:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=onCYdfBJPf4AnSBVwJ2/aEqS6jrss/1BLUDHPeErKyY=; b=BevhwU23jXy7xBnkUWiBMQhaqv
 R6sPWMjAr+rKAe7A0FmmrwGQv87wr6BoDLHGWK8Nirt4cOJxD5bBnI35sVUwaPAYpEyAsuiNfb3R8
 SqzrIjpgDFtsdRe2lfF8B9YclMUz2k1wbV8XvIsPjhpckjjnWI8WXoss9bqrZB9sFAvS3rNelehfw
 wssT0vUTINtXtevh7HAcwg+ZgAhiXpPf/8xaaP1iZy7/QQQKySUM9ZTwKqbpkZ+XiNH7cvzF2RSFf
 MSyWMP8oEPS4/pJTR5cK6CrokTWx04RcATzMyJd4Bzdn26Ap1tG7V7pSFRlASMD/kA9LL3FLizffP
 YnMkACxw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1vdaYu-0000000DwPV-0E06;
 Wed, 07 Jan 2026 20:55:24 +0000
Date: Wed, 7 Jan 2026 20:55:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Pedro Falcato <pfalcato@suse.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org,
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mm_take_all_locks: change -EINTR to -ERESTARTSYS
Message-ID: <aV7IO8-trMSI1twA@casper.infradead.org>
References: <20260107203113.690118053@debian4.vm>
 <20260107203224.969740802@debian4.vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107203224.969740802@debian4.vm>
X-Mailman-Approved-At: Thu, 08 Jan 2026 13:37:29 +0000
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

On Wed, Jan 07, 2026 at 09:31:14PM +0100, Mikulas Patocka wrote:
> This commit changes -EINTR to -ERESTARTSYS, so that if the signal handler
> was installed with the SA_RESTART flag, the operation is automatically
> restarted.

No, this is bonkers.  If you get a signal, you return -EINTR.
