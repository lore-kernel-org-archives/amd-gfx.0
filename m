Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53368C52D7D
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 07:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9C5510E142;
	Mon, 12 Aug 2024 07:31:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.b="Prn3nkMn";
	dkim-atps=neutral
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F4E410E11A;
 Mon, 12 Aug 2024 07:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
 Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=idBXxM8dGSa96iv7+rsnoNHkcGWImDmOE5L/dsu42Mc=; b=Prn3nkMnCmNcJvqLeA8rzN+iqV
 /xCh8fUxCllblZcx93hhu0lAvNYRNA9TbG2aDEfYJzG+y8Jq0TtoWLyXU//VT5G6i+cVZUXWBJwdZ
 /PMhi1NJ9pV5Xz3tqJ+5AK9YyZsH/l54z2/IfRyt0J1cn7UkXo9R935A43H3v1mwFNqGmai6mcxr8
 1XmgzM1vlwfBAejZWcOec++qoSeZJRx6Mxw+xU9heosEEne1OefXsOAe5ctp/Ozsl/K04TkmWnnB1
 64Eut1YpoMBmp9eqVfFy6CN3TGrfYZZTCdUSVx4XLmA8ePrwmMOYJzhblBjXAREcQuUEffew9S6It
 RAcOZe9Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1sdOzA-000000010k7-3Ama; Mon, 12 Aug 2024 06:56:56 +0000
Date: Mon, 12 Aug 2024 07:56:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCHES] [drm] file descriptor fixes
Message-ID: <20240812065656.GI13701@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 12 Aug 2024 07:31:01 +0000
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

	Resurrecting the stuff from last cycle.
Context: several places in drm have racy uses of close_fd().
Not hard to fix, thankfully.

	Changed since the last posting: as requested, KFD
fix had been split in two commits - introduction of helper
(drm_gem_prime_handle_to_dmabuf()) and switching kfd_mem_export_dmabuf()
to that.

	Branch in git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #for-drm,
individual patches in followups.

	Please, review; IMO that ought to go through drm and amd-gfx
trees.

Shortlog:

Al Viro (4):
      new helper: drm_gem_prime_handle_to_dmabuf()
      amdgpu: fix a race in kfd_mem_export_dmabuf()
      amdkfd CRIU fixes
      amdgpu: get rid of bogus includes of fdtable.h

Diffstat:
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 12 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c          |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           | 64 ++++++++++++-----
 drivers/gpu/drm/drm_prime.c                        | 84 +++++++++++-----------
 include/drm/drm_prime.h                            |  3 +
 6 files changed, 95 insertions(+), 70 deletions(-)

