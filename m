Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22198C12002
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 14:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8F66112D
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 14:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8F66112D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3F1289C8F;
	Mon, 19 Jul 2021 14:44:07 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60E7189FE3;
 Mon, 19 Jul 2021 09:16:52 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id C051C68AFE; Mon, 19 Jul 2021 11:16:47 +0200 (CEST)
Date: Mon, 19 Jul 2021 11:16:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alex Sierra <alex.sierra@amd.com>
Subject: Re: [PATCH v4 03/13] kernel: resource: lookup_resource as exported
 symbol
Message-ID: <20210719091647.GA30855@lst.de>
References: <20210717192135.9030-1-alex.sierra@amd.com>
 <20210717192135.9030-4-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210717192135.9030-4-alex.sierra@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Mon, 19 Jul 2021 14:44:05 +0000
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
Cc: rcampbell@nvidia.com, Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com,
 dri-devel@lists.freedesktop.org, jgg@nvidia.com, akpm@linux-foundation.org,
 linux-ext4@vger.kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Jul 17, 2021 at 02:21:25PM -0500, Alex Sierra wrote:
>  	return res;
>  }
> -
> +EXPORT_SYMBOL_GPL(lookup_resource);
>  /*

Please keep this empty line (after the EXPORT_SYMBOL).
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
