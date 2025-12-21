Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397AFE66886
	for <amd-gfx@archiver.kernel.org>; Sun, 21 Dec 2025 08:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AC4110E088;
	Sun, 21 Dec 2025 08:03:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bXqwdOwL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D00F910E088;
 Sun, 21 Dec 2025 08:03:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6B4E040E0A;
 Sun, 21 Dec 2025 08:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DACFC4CEFB;
 Sun, 21 Dec 2025 08:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766304219;
 bh=+zi1N9VwIHER6WrxiBOiWYKoYPkd9jJMNes2GHR5m70=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bXqwdOwLJ1ot4Bd4V/La84l2fstRHfEoLIoVohfCehi9MV7T8WvAShPZZ+v8LrZhR
 3BFIsHFbTumZDqr6Nt25eHtWOr9k9dYWchpzOOj0hdeBDJ/vd8xs89zzxH6CW2emJd
 V2RHp7g5qD5MXp9fTMoG5A8ow8OutFG5kesc3YZlzaeOgXZp6FmJcyN8ZKhGurL5pb
 57yprU/oxN25dR5AqrwBziuJ6jAFSwdLredWN/dbii+H7PtMLYJ08cBULM1imNVFvd
 +2QBcrmWgMiYrEUFNElGnYuOaLq/2tjlIzQtn+i69mf00YLdha1UTTbtKEKq/egmUv
 vwOTp3WtjzUtg==
Date: Sun, 21 Dec 2025 10:03:34 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Christian Brauner <brauner@kernel.org>,
 Carlos Llamas <cmllamas@google.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?iso-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Liviu Dudau <liviu.dudau@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH 6/7] RDMA/umem: don't abuse current->group_leader
Message-ID: <20251221080334.GC13030@unreal>
References: <aTV1KYdcDGvjXHos@redhat.com>
 <aTV1pbftBkH8n4kh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTV1pbftBkH8n4kh@redhat.com>
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

On Sun, Dec 07, 2025 at 01:40:05PM +0100, Oleg Nesterov wrote:
> Cleanup and preparation to simplify the next changes.
> 
> Use current->tgid instead of current->group_leader->pid.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  drivers/infiniband/core/umem_odp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Thanks,
Acked-by: Leon Romanovsky <leon@kernel.org>
