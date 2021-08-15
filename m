Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45744C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 07:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E227061A89
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 07:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E227061A89
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B9189C68;
	Mon, 16 Aug 2021 07:14:13 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E7089C0D;
 Sun, 15 Aug 2021 09:10:04 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9DEF66736F; Sun, 15 Aug 2021 11:10:00 +0200 (CEST)
Date: Sun, 15 Aug 2021 11:10:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alex Sierra <alex.sierra@amd.com>
Cc: akpm@linux-foundation.org, Felix.Kuehling@amd.com, linux-mm@kvack.org,
 rcampbell@nvidia.com, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, hch@lst.de, jgg@nvidia.com,
 jglisse@redhat.com
Subject: Re: [PATCH v6 04/13] drm/amdkfd: add SPM support for SVM
Message-ID: <20210815091000.GB25067@lst.de>
References: <20210813063150.2938-1-alex.sierra@amd.com>
 <20210813063150.2938-5-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813063150.2938-5-alex.sierra@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Mon, 16 Aug 2021 07:13:00 +0000
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

> @@ -880,17 +881,22 @@ int svm_migrate_init(struct amdgpu_device *adev)
>  	 * should remove reserved size
>  	 */
>  	size = ALIGN(adev->gmc.real_vram_size, 2ULL << 20);
> -	res = devm_request_free_mem_region(adev->dev, &iomem_resource, size);
> +	if (xgmi_connected_to_cpu)
> +		res = lookup_resource(&iomem_resource, adev->gmc.aper_base);
> +	else
> +		res = devm_request_free_mem_region(adev->dev, &iomem_resource, size);
> +

Can you explain what the point of the lookup_resource is here? res->start
is obviously identical to the start value you pass in.  So this is used
as a way to query the length, but I'm pretty sure the driver must
already know that as it inserted the resource itself, right?

On a slightly higher level comment svm_migrate_init is a bit of a mess
with all the if/else already, and with the above addressed will become
a bit more.  I think splitting it into a device private and device
generic case would probably help people finding it to understand the code
much better later on.  Even more so with a useful comment.
