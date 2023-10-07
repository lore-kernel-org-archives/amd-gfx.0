Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EF1E95A8E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 10:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC7810E25E;
	Mon,  9 Oct 2023 10:33:36 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08E5D10E0DC;
 Sat,  7 Oct 2023 09:51:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 100D5CE10C7;
 Sat,  7 Oct 2023 09:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82C5C433C8;
 Sat,  7 Oct 2023 09:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1696672259;
 bh=BpvrhegrCV1J4cKymgkwU4t6EVNh8m5OfKQGXvcEXDs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iSPya9UeLlHx9QhsfamPOjcW275Ghv9CzwmpfigLJO/kJTZ04QUbhXBdIco+fn28K
 YQOYlLMtkKvjUUc960lanETvTjUxcpgg3yJOVLzYPQEzJ9lVsFjJbl7gCQriVKI10y
 L/6gqL1UGXZX3Ck+qLAQvPKBdonmGWnsUIuOx8iM=
Date: Sat, 7 Oct 2023 11:50:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Bryan Jennings <bryjen423@gmail.com>
Subject: Re: [PATCH AUTOSEL 5.10 13/22] drm/amdgpu: install stub fence into
 potential unused fence pointers
Message-ID: <2023100750-unraveled-propeller-3697@gregkh>
References: <2023083119-phoney-ascend-d4ec@gregkh>
 <d32d6919-47cf-4ddc-955a-0759088220ae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d32d6919-47cf-4ddc-955a-0759088220ae@gmail.com>
X-Mailman-Approved-At: Mon, 09 Oct 2023 10:33:35 +0000
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
Cc: sashal@kernel.org, airlied@linux.ie, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, olvaffe@gmail.com,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 stable@vger.kernel.org, Lang.Yu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Sep 10, 2023 at 03:43:01PM -0500, Bryan Jennings wrote:
> This is also causing log spam on 5.15.  It was included in 5.15.128 as
> commit 4921792e04f2125b5eadef9dbe9417a8354c7eff.  I encountered this and
> found https://gitlab.freedesktop.org/drm/amd/-/issues/2820 while researching
> the problem.

Confused, what should we do here?
