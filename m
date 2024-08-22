Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B73C5321D
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 07:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81E9F10EC31;
	Fri, 23 Aug 2024 07:42:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.b="U+8y7g7m";
	dkim-atps=neutral
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B485110EB30;
 Thu, 22 Aug 2024 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=28CByVoDKbmSRRoAthE7OCIveD+kuGlPjlnsnOxE2WQ=; b=U+8y7g7mJU3YIDPNhHd6YX145o
 S6ebhlQ3NAZ6TWcOC6QNny5FyE+2w5iFlzB667o8Jd0g6jScASoWP6RF3M9j0CXqTNW6ON9nH+IEz
 rMscFLTn3peq7N0O81iSD7RDymYz2HpjOoA/CPvfC1xfiHj7iGBe37ULh7jdQtDaJnczCQDL8EN4/
 BBHQl6jENKs8BgTOGztSqgyM+0I14aZ869U3+hXWv2/+zykm225FvgVMQCmjzDwnhBWu1Lx3lDCOo
 XuNzCVorUvEU4e66WLtJI6WQX89u0/ANZBqIdwaJRYsptYazPEx7fe1Vrbs+b5FG+7B1Z4/rtS9p2
 qjWRbB4Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1sh9bq-00000004FKl-0LTH; Thu, 22 Aug 2024 15:20:22 +0000
Date: Thu, 22 Aug 2024 16:20:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] new helper: drm_gem_prime_handle_to_dmabuf()
Message-ID: <20240822152022.GU504335@ZenIV>
References: <20240812065656.GI13701@ZenIV>
 <20240812065906.241398-1-viro@zeniv.linux.org.uk>
 <57520a28-fff2-41ae-850b-fa820d2b0cfa@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57520a28-fff2-41ae-850b-fa820d2b0cfa@suse.de>
X-Mailman-Approved-At: Fri, 23 Aug 2024 07:42:15 +0000
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

On Thu, Aug 22, 2024 at 04:41:59PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 12.08.24 um 08:59 schrieb Al Viro:
> > Once something had been put into descriptor table, the only thing you
> > can do with it is returning descriptor to userland - you can't withdraw
> > it on subsequent failure exit, etc.  You certainly can't count upon
> > it staying in the same slot of descriptor table - another thread
> > could've played with close(2)/dup2(2)/whatnot.
> 
> This paragraph appears to refer to the newly added call to fd_install().

It refers to dma_buf_fd() call that had been there all along, actually.
dma_buf_fd() is get_unused_fd_flags() + fd_install().  The reason
for splitting it in new variant and calling get_unused_fd_flags() and
fd_install() separately is that it makes for simpler cleanup; we could
use dma_buf_fd() instead - it would be a bit more clumsy, but that's
it.

The real issue is that drm_gem_prime_handle_to_fd() forces us to make
the thing reachable via descriptor table; it's just what we need when
all we are going to do is returning descriptor to userland, but it's
inherently racy for internal uses - anything put into descriptor table,
be it by fd_install() or by dma_buf_fd(), is fair game for all syscalls
by other threads.
 
> > Add drm_gem_prime_handle_to_dmabuf() - the "set dmabuf up" parts of
> > drm_gem_prime_handle_to_fd() without the descriptor-related ones.
> > Instead of inserting into descriptor table and returning the file
> > descriptor it just returns the struct file.
> > 
> > drm_gem_prime_handle_to_fd() becomes a wrapper for it.  Other users
> > will be introduced in the next commit.

> > -int drm_gem_prime_handle_to_fd(struct drm_device *dev,
> > +struct dma_buf *drm_gem_prime_handle_to_dmabuf(struct drm_device *dev,
> 
> If it's exported it should have kernel docs. At least copy-paste the docs
> from drm_gem_prime_handle_to_fd()
> and reword a few bits.

Point...
