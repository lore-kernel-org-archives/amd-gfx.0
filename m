Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF27D13C1B
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 08:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C30410E4E8;
	Tue, 27 Jan 2026 08:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Gnbh9Loe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A16A510E494;
 Mon, 26 Jan 2026 20:50:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B367560129;
 Mon, 26 Jan 2026 20:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC155C116C6;
 Mon, 26 Jan 2026 20:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1769460649;
 bh=yndic95Dd8m5l7C1UqbBVJQY3dB2qyl3JPw2oSTE5TQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Gnbh9LoeYg4uZkvQPBCJHv7TazOmO+eqozhbasI0b8pDuDPJ/LE4GearjPOnG04NB
 /t1tDK4uOP4xN4ZsPWegJH7KYRjDifFFGDt4laaZ+PpC0Uf05a9w2tV709Z6OH1Ogt
 GvJ4OwYOaLmX6a2pJF4xDjbXynMUAml/PDzkSr5U=
Date: Mon, 26 Jan 2026 12:50:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, Leon
 Romanovsky <leon@kernel.org>, Steven Price <steven.price@arm.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2 7/7] netclassid: use thread_group_leader(p) in
 update_classid_task()
Message-Id: <20260126125048.323a281527fb2554c96f40bf@linux-foundation.org>
In-Reply-To: <aXY_4NSP094-Cf-2@redhat.com>
References: <aXY_h8i78n6yD9JY@redhat.com>
	<aXY_4NSP094-Cf-2@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 27 Jan 2026 08:19:15 +0000
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

On Sun, 25 Jan 2026 17:08:00 +0100 Oleg Nesterov <oleg@redhat.com> wrote:

> Cleanup and preparation to simplify the next changes.
> 

"next changes".  This is the final patch?

> --- a/net/core/netclassid_cgroup.c
> +++ b/net/core/netclassid_cgroup.c
> @@ -93,7 +93,7 @@ static void update_classid_task(struct task_struct *p, u32 classid)
>  	/* Only update the leader task, when many threads in this task,
>  	 * so it can avoid the useless traversal.
>  	 */
> -	if (p != p->group_leader)
> +	if (!thread_group_leader(p))
>  		return;
>  
>  	do {
> -- 
> 2.52.0
