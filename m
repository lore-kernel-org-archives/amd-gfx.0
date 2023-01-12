Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30247C54EBC
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 13:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A68DF10E8E3;
	Thu, 12 Jan 2023 13:35:58 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE54A10E8DC;
 Thu, 12 Jan 2023 12:47:58 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AEA3E60A69;
 Thu, 12 Jan 2023 12:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837E4C433F1;
 Thu, 12 Jan 2023 12:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1673527677;
 bh=7zZrtN8lmZKOOP4+fso5bw1M8rjneci9uxIRHPuWDgc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=blPoptpCI5TVw04j6Uhfv3eMlNkUaOX5zUB2uS8oijYwVXOJP9UpjgZbfm+h4Utms
 pSR+QBlb2klOw1xHCe5LkrZsFcpd0DBiBzpP1Rcfdr6K816Fz0OJS2KBpsbm72BkD7
 MGb++JTPURweTALy/PkKhEGelWwvB8qYR6SFw7NE=
Date: Thu, 12 Jan 2023 13:47:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dragos-Marian Panait <dragos.panait@windriver.com>
Subject: Re: [PATCH 5.10 1/1] drm/amdkfd: Check for null pointer after
 calling kmemdup
Message-ID: <Y8ABeXQLzWdoaGAY@kroah.com>
References: <20230104175633.1420151-1-dragos.panait@windriver.com>
 <20230104175633.1420151-2-dragos.panait@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104175633.1420151-2-dragos.panait@windriver.com>
X-Mailman-Approved-At: Thu, 12 Jan 2023 13:35:57 +0000
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
Cc: Oded Gabbay <oded.gabbay@gmail.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Jiasheng Jiang <jiasheng@iscas.ac.cn>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Kent Russell <kent.russell@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 04, 2023 at 07:56:33PM +0200, Dragos-Marian Panait wrote:
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
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 86b4dadf772e..02e3c650ed1c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -408,6 +408,9 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
>  			return -ENODEV;
>  		/* same everything but the other direction */
>  		props2 = kmemdup(props, sizeof(*props2), GFP_KERNEL);
> +		if (!props2)
> +			return -ENOMEM;

Not going to queue this up as this is a bogus CVE.
