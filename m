Return-Path: <SRS0=QpD2=6M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC2EC83001
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 16:12:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2895E206E2
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 16:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2895E206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB38C6E839;
	Tue, 28 Apr 2020 16:12:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 99A556E82D;
 Tue, 28 Apr 2020 16:03:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11FB530E;
 Tue, 28 Apr 2020 09:03:02 -0700 (PDT)
Received: from [10.57.33.170] (unknown [10.57.33.170])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EE773F305;
 Tue, 28 Apr 2020 09:02:59 -0700 (PDT)
Subject: Re: [RFC 00/17] DRM: fix struct sg_table nents vs. orig_nents misuse
To: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 intel-gfx@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>
References: <CGME20200428132022eucas1p2aa4716cbaca61c432ee8028be15fef7a@eucas1p2.samsung.com>
 <20200428132005.21424-1-m.szyprowski@samsung.com>
 <20200428140257.GA3433@lst.de> <20200428153202.GY3456981@phenom.ffwll.local>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c01c9766-9778-fd1f-f36e-2dc7bd376ba4@arm.com>
Date: Tue, 28 Apr 2020 17:02:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428153202.GY3456981@phenom.ffwll.local>
Content-Language: en-GB
X-Mailman-Approved-At: Tue, 28 Apr 2020 16:12:00 +0000
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-04-28 4:32 pm, Daniel Vetter wrote:
> On Tue, Apr 28, 2020 at 04:02:57PM +0200, Christoph Hellwig wrote:
>> On Tue, Apr 28, 2020 at 03:19:48PM +0200, Marek Szyprowski wrote:
>>> 1. introduce a dma_{map,sync,unmap}_sgtable() wrappers, which will use
>>>     a proper sg_table entries and call respective DMA-mapping functions
>>>     and adapt current code to it
>>
>> That sounds reasonable to me.  Those could be pretty trivial wrappers.
>>
>>>
>>>
>>> 2. rename nents and orig_nents to nr_pages, nr_dmas to clearly state
>>>     which one refers to which part of the scatterlist; I'm open for
>>>     other names for those entries
>>
>> nr_cpu_ents and nr_dma_ents might be better names, but it still would be
>> a whole lot of churn for little gain.  I think just good wrappers like
>> suggested above might be more helpful.
> 
> I guess long-term we could aim for both? I.e. roll out better wrappers
> first, once that's soaked through the tree, rename the last offenders.

Yes, that's what I was thinking too - most of these uses are just 
passing them in and out of the DMA APIs, and thus would be subsumed into 
the wrappers anyway, then in the relatively few remaining places where 
the table is actually iterated for one reason or the other, renaming 
would stand to help review and maintenance in terms of making it far 
more obvious when the implementation and the intent don't match.

Robin.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
