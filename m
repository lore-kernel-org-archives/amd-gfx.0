Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45A1D232C7
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 01:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D455410E7D9;
	Fri,  9 Jan 2026 01:18:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BkqB56df";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D70D10E304
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 01:18:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 330C842E41;
 Fri,  9 Jan 2026 01:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84DAC116C6;
 Fri,  9 Jan 2026 01:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767921519;
 bh=R30MjaWiVKCZO6hL4X3IntKJmzte8Kq+Ssd8NLay3oA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BkqB56dfCx9uUDKm5unPnjRrTu9HKQyKexFq74u/W2yHm2DpERk7SMCcKAalcNKRU
 +d6TN1Zr+mnMQ31Cvif8BV5ZF24QsU2jSf8uWCd3k1mhFQx3dxTVFAaoAD54PdoOHO
 L9tXGanUp5L9ns1cnkkUHHsC+FeVZttfDt/pKNAtnt75h+syCJQZasJ3A/+DC8QQiS
 1moKsG5F7CxLBbKky99hnYwqfGi1CL0d+CAn0DpjqtUu9YEyZhOghz2BDGbg25253x
 Maww4O4TSU9ido4UD36yiOm11x6Jk2WufwPc4HInbzww6ebVBF6rmOMuiQrOiBTxqL
 jgwQTlbr/b0Lg==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>, Pedro Falcato <pfalcato@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org,
 linux-mm@kvack.org
Subject: Re: Finding mm patches to review before those are pulled into the
 mainline (was "Re: [PATCH v2] fix AMDGPU failure with periodic signal")
Date: Thu,  8 Jan 2026 17:18:29 -0800
Message-ID: <20260109011830.68325-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1c758937-787a-4afa-983d-e5b89578b101@lucifer.local>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Thu, 8 Jan 2026 09:05:16 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Wed, Jan 07, 2026 at 10:26:35PM -0800, SeongJae Park wrote:
[...]
> We need to change that in my opinion, but I'm no longer hopeful that we will any
> time soon.

Thank you for kindly and patiently clarifying the situation and your opinion,
Lorenzo.  Thanks to that, I now better understand what you are saying, though I
don't have a good idea to add on here, for now.  I will also take more time on
thinking and help if I get some ideas later.


Thanks,
SJ

[...]
