Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01C5C07E9B
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 13:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5508B61A19
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 13:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5508B61A19
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE206E4AD;
	Tue,  6 Jul 2021 13:22:40 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 961196E489;
 Tue,  6 Jul 2021 12:32:01 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9F9BF68C7B; Tue,  6 Jul 2021 14:21:11 +0200 (CEST)
Date: Tue, 6 Jul 2021 14:21:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Oded Gabbay <ogabbay@kernel.org>, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, sumit.semwal@linaro.org,
 christian.koenig@amd.com, galpress@amazon.com, sleybo@amazon.com,
 dri-devel@lists.freedesktop.org, jgg@ziepe.ca,
 linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
 dledford@redhat.com, airlied@gmail.com, alexander.deucher@amd.com,
 leonro@nvidia.com, hch@lst.de, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v4 0/2] Add p2p via dmabuf to habanalabs
Message-ID: <20210706122110.GA18273@lst.de>
References: <20210705130314.11519-1-ogabbay@kernel.org>
 <YOQXBWpo3whVjOyh@phenom.ffwll.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YOQXBWpo3whVjOyh@phenom.ffwll.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Tue, 06 Jul 2021 13:22:39 +0000
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 06, 2021 at 10:40:37AM +0200, Daniel Vetter wrote:
> > Greg, I hope this will be good enough for you to merge this code.
> 
> So we're officially going to use dri-devel for technical details review
> and then Greg for merging so we don't have to deal with other merge
> criteria dri-devel folks have?
> 
> I don't expect anything less by now, but it does make the original claim
> that drivers/misc will not step all over accelerators folks a complete
> farce under the totally-not-a-gpu banner.
> 
> This essentially means that for any other accelerator stack that doesn't
> fit the dri-devel merge criteria, even if it's acting like a gpu and uses
> other gpu driver stuff, you can just send it to Greg and it's good to go.
> 
> There's quite a lot of these floating around actually (and many do have
> semi-open runtimes, like habanalabs have now too, just not open enough to
> be actually useful). It's going to be absolutely lovely having to explain
> to these companies in background chats why habanalabs gets away with their
> stack and they don't.

FYI, I fully agree with Daniel here.  Habanlabs needs to open up their
runtime if they want to push any additional feature in the kernel.
The current situation is not sustainable.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
