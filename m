Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C036C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 14:18:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B55F10E20D;
	Wed,  4 Jan 2023 14:18:56 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C75B410E082;
 Wed,  4 Jan 2023 12:41:26 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 532DA6141C;
 Wed,  4 Jan 2023 12:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32396C433D2;
 Wed,  4 Jan 2023 12:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1672836085;
 bh=TOXTQ60NVRt1UUZ7zJB1nKXUtQdnqTmRrybEAGs47wA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eRG5aar/3NtyK6sTqpmMnnO4GuWi0LCInUB6dkAtQXjlLDWjw9LKhNFakYC1j6lTI
 pUnuDZ1JtTo5R1G93Kb4FbbrqLXbLJFmwzj4eKv1kplm1h8E0pR5vkRAy58xli7oPv
 H356a3QfNzlrx9nlcPS+2Sr+njyBTFzdwO94oaus=
Date: Wed, 4 Jan 2023 13:41:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dragos-Marian Panait <dragos.panait@windriver.com>
Subject: Re: [PATCH 4.19 1/1] drm/amdkfd: Check for null pointer after
 calling kmemdup
Message-ID: <Y7Vz8mm0X+1h844b@kroah.com>
References: <20230103184308.511448-1-dragos.panait@windriver.com>
 <20230103184308.511448-2-dragos.panait@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103184308.511448-2-dragos.panait@windriver.com>
X-Mailman-Approved-At: Wed, 04 Jan 2023 14:18:53 +0000
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
Cc: Oded Gabbay <oded.gabbay@gmail.com>, David Zhou <David1.Zhou@amd.com>,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 03, 2023 at 08:43:08PM +0200, Dragos-Marian Panait wrote:
> From: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> 
> [ Upstream commit abfaf0eee97925905e742aa3b0b72e04a918fa9e ]
> 
> As the possible failure of the allocation, kmemdup() may return NULL
> pointer.
> Therefore, it should be better to check the 'props2' in order to prevent
> the dereference of NULL pointer.
> 
> Fixes: 3a87177eb141 ("drm/amdkfd: Add topology support for dGPUs")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Dragos-Marian Panait <dragos.panait@windriver.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 3 +++
>  1 file changed, 3 insertions(+)

For obvious reasons, I can't take a patch for 4.19.y and not newer
kernel releases, right?

Please provide backports for all kernels if you really need to see this
merged.  And note, it's not a real bug at all, and given that a CVE was
allocated for it that makes me want to even more reject it to show the
whole folly of that mess.

thanks,

greg k-h
