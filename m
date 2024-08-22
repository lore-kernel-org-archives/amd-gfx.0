Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EADC5472C
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 07:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE24810E7B5;
	Thu, 22 Aug 2024 07:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.b="gpCJK+AM";
	dkim-atps=neutral
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2F0210E011;
 Thu, 22 Aug 2024 00:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=kGDQYbC8qypiT4m0fJt+09ZAK1zE2sNw7WPJdY9LOOA=; b=gpCJK+AMtryzj3NxN0zDt9z63c
 Jn/c7h+tY4ffYsJNq+RYN7GxikQDh3WAQpBsK9VGrJ/xL7zeyyvXFFCgC53X1oOJKE3/XyWIvGemS
 Fec0urCA0gyZhIbyk9l8Opnvf6q/Itp/9i3dfgsNM+GQc+zBri1N5eNA3QfMIh7inLYD77e7rwZ+O
 Z0jjX4o0LCGqOaoTfmrk8BbeH+Q99VC9rLDU40bj6xg76gemtSi043pNnfKm1iMTNv7uoz/0EUqv6
 RPB3USODanpez1kz5cB22epSaDJLrWnmiJ82C8QJex/Pk0uruHv8qTYA7nhOvhonqNg+d8ABs8ZMG
 zvz+OdtQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1sgvhZ-00000003wEk-3Fkj; Thu, 22 Aug 2024 00:29:21 +0000
Date: Thu, 22 Aug 2024 01:29:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] amdgpu: fix a race in kfd_mem_export_dmabuf()
Message-ID: <20240822002921.GN504335@ZenIV>
References: <20240812065656.GI13701@ZenIV>
 <20240812065906.241398-1-viro@zeniv.linux.org.uk>
 <20240812065906.241398-2-viro@zeniv.linux.org.uk>
 <09a1d083-0960-4de7-ab66-527099076ee4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09a1d083-0960-4de7-ab66-527099076ee4@amd.com>
X-Mailman-Approved-At: Thu, 22 Aug 2024 07:20:39 +0000
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

On Wed, Aug 14, 2024 at 06:15:46PM -0400, Felix Kuehling wrote:
> 
> On 2024-08-12 02:59, Al Viro wrote:
> > Using drm_gem_prime_handle_to_fd() to set dmabuf up and insert it into
> > descriptor table, only to have it looked up by file descriptor and
> > remove it from descriptor table is not just too convoluted - it's
> > racy; another thread might have modified the descriptor table while
> > we'd been going through that song and dance.
> > 
> > Switch kfd_mem_export_dmabuf() to using drm_gem_prime_handle_to_dmabuf()
> > and leave the descriptor table alone...
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> This patch is
> 
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

Umm...  So which tree should that series go through?

I can put it through vfs.git, or send a pull request to drm folks, or...

Preferences?
