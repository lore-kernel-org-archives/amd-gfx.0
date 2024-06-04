Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC75CC25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 12:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C40C10E7C7;
	Wed,  5 Jun 2024 12:57:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.b="D2F9bKLj";
	dkim-atps=neutral
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF9810E5C6;
 Tue,  4 Jun 2024 19:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=EKsNoF0MywpqT/TZQS7gCYk1zUr/B3b14dN+nOLsCxA=; b=D2F9bKLjQnk7HuVdWJZ5UkK2UP
 R22lvglnquTB7YQ5tih1nFbAjhp4KkgsmiDvSNSpnTpPCaKDqCK1eKgwjzZNqAMY/PY+Nz7eITxtb
 pMSU3hilQ5tKPE+TSD1B6QicaIyNjSMDGEdvj59Iwd/VXx3NGf8b3UfAnqamJp9fxlgFYGmsZ3sVo
 gpycLP3HiYbhl2a8AXnAaBbmaQsvYiLRqphxK+MBDgyQLhocZsUEo+Z49vvEL2Wg8zqhYcwUc2GyR
 HPJpqnsgn5xW3F7CjvujX7BlBjdb8toFzbdnt8BBIvvy0G7GnA0Ok/A+u8kxX9UHFwO97Z3eoH8Er
 AGIgVPfA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1sEZXo-00E0aS-2U; Tue, 04 Jun 2024 19:10:05 +0000
Date: Tue, 4 Jun 2024 20:10:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2][RFC] amdgpu: fix a race in kfd_mem_export_dmabuf()
Message-ID: <20240604191004.GR1629371@ZenIV>
References: <20240604021255.GO1629371@ZenIV> <20240604021354.GA3053943@ZenIV>
 <611b4f6e-e91b-4759-a170-fb43819000ce@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <611b4f6e-e91b-4759-a170-fb43819000ce@amd.com>
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

On Tue, Jun 04, 2024 at 02:08:30PM -0400, Felix Kuehling wrote:
> > +int drm_gem_prime_handle_to_fd(struct drm_device *dev,
> > +			       struct drm_file *file_priv, uint32_t handle,
> > +			       uint32_t flags,
> > +			       int *prime_fd)
> > +{
> > +	struct dma_buf *dmabuf;
> > +	int fd = get_unused_fd_flags(flags);
> > +
> > +	if (fd < 0)
> > +		return fd;
> > +
> > +	dmabuf = drm_gem_prime_handle_to_dmabuf(dev, file_priv, handle, flags);
> > +	if (IS_ERR(dmabuf))
> > +		return PTR_ERR(dmabuf);

That ought to be
	if (IS_ERR(dmabuf)) {
		put_unused_fd(fd);
		return PTR_ERR(dmabuf);
	}
or we'll leak an allocated descriptor.  Will fix and repost...
