Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1538C5DF60
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 08:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8955021D7E
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 08:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8955021D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 067446F898;
	Fri,  8 Nov 2019 08:12:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 798596E5BB;
 Fri,  8 Nov 2019 06:33:11 +0000 (UTC)
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1iSxpO-0004uP-RP; Fri, 08 Nov 2019 06:33:02 +0000
Date: Thu, 7 Nov 2019 22:33:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v2 02/15] mm/mmu_notifier: add an interval tree notifier
Message-ID: <20191108063302.GA18778@infradead.org>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-3-jgg@ziepe.ca>
 <35c2b322-004e-0e18-87e4-1920dc71bfd5@nvidia.com>
 <20191107200604.GB21728@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191107200604.GB21728@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Fri, 08 Nov 2019 08:12:39 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sfdfvBL2vL+6/zKzcRD8BS56fyubhIZ+MnB63+Whqww=; b=FyyBMRXg7xjEFz//LRCdOwL18
 hKB/D3F1bPGKiHdQWF5m35XG4E3WD+6E0CxgvcikgS5iRvO035mZUNmAfQsrTxXbipkMtN7Csh82U
 TkXb00nbArvJ4o9o1oSsuBXDYKdWjjL+gFeJdHZim38W2w/ASDOrOw7R4zUEvGcf9P4Zly7OuHtXi
 R2b9mpCV+5doe05qxCME3B/ZrpaUGvMjyxA/fTYrGvV7sgs0phhNbJEtc/O73szxHJx/zSNnzUmhw
 WnNF01/JTBJLgMj7/spP8/IEmmGPsj93eGRwYEwNwsz/7/7UlAROrdUCayb+qrzFziI1mB1Ncy4fZ
 vWBdHpcGA==;
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Michal Hocko <mhocko@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Andrea Arcangeli <aarcange@redhat.com>, David Zhou <David1.Zhou@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>, Ben Skeggs <bskeggs@redhat.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Jerome Glisse <jglisse@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Petr Cvek <petrcvekcz@gmail.com>,
 Juergen Gross <jgross@suse.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>,
 "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Dennis Dalessandro <dennis.dalessandro@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108063302.mbU4Gdnk-sV3_ztK6k8pj6LBKTPrTUh7QzHFslsMda4@z>

T24gVGh1LCBOb3YgMDcsIDIwMTkgYXQgMDg6MDY6MDhQTSArMDAwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgo+ID4gCj4gPiBlbnVtIG1tdV9yYW5nZV9ub3RpZmllcl9ldmVudCB7Cj4gPiAJTU1V
X05PVElGWV9SRUxFQVNFLAo+ID4gfTsKPiA+IAo+ID4gLi4uYXNzdW1pbmcgdGhhdCB3ZSBzdGF5
IHdpdGggIm1tdV9yYW5nZV9ub3RpZmllciIgYXMgYSBjb3JlIG5hbWUgZm9yIHRoaXMgCj4gPiB3
aG9sZSB0aGluZy4KPiA+IAo+ID4gQWxzbywgaXQgaXMgYmVzdCBtb3ZlZCBkb3duIHRvIGJlIG5l
eHQgdG8gdGhlIG5ldyBNTlIgc3RydWN0cywgc28gdGhhdCBhbGwgdGhlCj4gPiBNTlIgc3R1ZmYg
aXMgaW4gb25lIGdyb3VwLgo+IAo+IEkgYWdyZWUgd2l0aCBKZXJvbWUsIHRoaXMgZW51bSBpcyBw
YXJ0IG9mIHRoZSAnc3RydWN0Cj4gbW11X25vdGlmaWVyX3JhbmdlJyAoaWUgdGhlIGRlc2NyaXB0
aW9uIG9mIHRoZSBpbnZhbGlkYXRpb24pIGFuZCBpdAo+IGRvZXNuJ3QgcmVhbGx5IG1hdHRlciB0
aGF0IG9ubHkgdGhlc2UgbmV3IG5vdGlmaWVycyBjYW4gYmUgY2FsbGVkIHdpdGgKPiB0aGlzIHR5
cGUsIGl0IGlzIHN0aWxsIHBhcnQgb2YgdGhlIG1tdV9ub3RpZmllcl9yYW5nZS4KPiAKPiBUaGUg
Y29tbWVudCBhbHJlYWR5IHNheXMgaXQgb25seSBhcHBsaWVzIHRvIHRoZSBtbXVfcmFuZ2Vfbm90
aWZpZXIKPiBzY2hlbWUuLgoKSW4gZmFjdCB0aGUgZW51bSBpcyBlbnRpcmVseSB1bnVzZWQuICBX
ZSBtaWdodCBhcyB3ZWxsIGp1c3Qga2lsbCBpdCBvZmYKZW50aXJlbHkuCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
