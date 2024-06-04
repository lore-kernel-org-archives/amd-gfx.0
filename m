Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD832C27C5E
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 12:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BEB910E7BD;
	Wed,  5 Jun 2024 12:57:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.b="Lldakplg";
	dkim-atps=neutral
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E672A10E5DE
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=8ifQNFXiuCP8WJicsEJVSugBnZEZ1cTltL7aAzeeklc=; b=Lldakplg9sbiC9O5qqMpjwVUpR
 tySCdfyBS2c0bGSqE+wAxV7D/DntKToNygAp4KHbH0Ikf1d5AZG75UKxTzM9Lqh/RZ212Rfp5tNk7
 4sgfGI/nR3LX/GZvRTxdwrFsNw8VYBCYICW5Ej9S5MtdhiAI8FmsCIWpvqZQxev5tbeqPDIktBJWy
 z1UvxjeAqksE5VZXgE4pXornZtebQdUYa3l02lvBvuwjlb2qyCN3boeIvM7HxtlWhTT3tmTol6F4c
 dOvPRcq8VScC0pDlKbh9CMYmNL8deUSav3MvD4Lsb9SLH+vCX9WlSgKq1eHLIkaSL0Y5TO8kdlOs8
 paGReFJg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1sEZhn-00E1vy-30; Tue, 04 Jun 2024 19:20:24 +0000
Date: Tue, 4 Jun 2024 20:20:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2][RFC] amdkfd CRIU fixes
Message-ID: <20240604192023.GT1629371@ZenIV>
References: <20240604021255.GO1629371@ZenIV> <20240604021456.GB3053943@ZenIV>
 <1cd7980e-1cfa-4470-b712-48d9d2658435@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cd7980e-1cfa-4470-b712-48d9d2658435@amd.com>
X-Mailman-Approved-At: Wed, 05 Jun 2024 12:57:07 +0000
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

On Tue, Jun 04, 2024 at 02:16:00PM -0400, Felix Kuehling wrote:
> 
> On 2024-06-03 22:14, Al Viro wrote:
> > Instead of trying to use close_fd() on failure exits, just have
> > criu_get_prime_handle() store the file reference without inserting
> > it into descriptor table.
> > 
> > Then, once the callers are past the last failure exit, they can go
> > and either insert all those file references into the corresponding
> > slots of descriptor table, or drop all those file references and
> > free the unused descriptors.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Thank you for the patches and the explanation. One minor nit-pick inline.
> With that fixed, this patch is
> 
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> 
> I can apply this patch to amd-staging-drm-next, if you want. See one comment
> inline ...

Fine by me; I think this stuff would be better off in the relevant trees -
it's not as if we realistically could unexport close_fd() this cycle anyway,
more's the pity...  So nothing I've got in my queue has that as a prereq and
it would definitely have better odds of getting tested in your tree.
