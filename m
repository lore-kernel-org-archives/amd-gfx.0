Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E60AE63CBF
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Jan 2026 19:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1AF210E382;
	Sun, 25 Jan 2026 19:38:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EW91Ki1b";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5474E10E1BE;
 Sun, 25 Jan 2026 19:38:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3F344600C3;
 Sun, 25 Jan 2026 19:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0D6C4CEF1;
 Sun, 25 Jan 2026 19:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769369879;
 bh=CJJoAyHycnWBHWJ3K9UH9JsSF4QzEnlHxtNRXEkKYF0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EW91Ki1bnyV6hL0gLSqe0lWMgwVzGSEO4FxhMWUnXMJUxea7tCXNpnWQtApwfQsQz
 hXX+wKr1b9LhB54vNjlPyKAUT8zMLomBW7pBDjFm/C45EE4TZN/iQ9ABQo52rBYGEA
 bBjygq4DfWF0iZEbaon9lr3xXRrPyxqPKQA21ynK3QScoof5Ae+PR/nw4A8T8bC5Vr
 qBWPVTdJkJUBRaZZfEY58mWZCorDxb2GGvdNYTeB48vhxHWsj6JhL23obe5FdjbIFC
 pnEQ5wZDzrLsEvtzNMpcFqqVNbK65jGwK/QTWTxOV0itRjxTwgfB7lP4zy302fhCAf
 rmI42ODIOJDLg==
Date: Sun, 25 Jan 2026 11:37:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alice Ryhl
 <aliceryhl@google.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Leon Romanovsky <leon@kernel.org>, Steven Price
 <steven.price@arm.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 7/7] netclassid: use thread_group_leader(p) in
 update_classid_task()
Message-ID: <20260125113758.0f985df0@kernel.org>
In-Reply-To: <aXY_4NSP094-Cf-2@redhat.com>
References: <aXY_h8i78n6yD9JY@redhat.com>
	<aXY_4NSP094-Cf-2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sun, 25 Jan 2026 17:08:00 +0100 Oleg Nesterov wrote:
> Cleanup and preparation to simplify the next changes.

Acked-by: Jakub Kicinski <kuba@kernel.org>
