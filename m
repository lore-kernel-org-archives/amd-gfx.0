Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BD0CA9EAF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 07:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F6020856
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 07:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F6020856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B8A96E112;
	Thu, 24 Oct 2019 07:31:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 429E56E064;
 Thu, 24 Oct 2019 02:16:31 +0000 (UTC)
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1iNSfp-0002vA-89; Thu, 24 Oct 2019 02:16:25 +0000
Date: Wed, 23 Oct 2019 19:16:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Message-ID: <20191024021625.GA5893@infradead.org>
References: <f7e34d8f-f3b0-b86d-7388-1f791674a4a9@amd.com>
 <20191021135744.GA25164@mellanox.com>
 <e07092c3-8ccd-9814-835c-6c462017aff8@amd.com>
 <20191021151221.GC25164@mellanox.com>
 <20191022075735.GV11828@phenom.ffwll.local>
 <20191022150109.GF22766@mellanox.com>
 <20191023090858.GV11828@phenom.ffwll.local>
 <13edf841-421e-3522-fcec-ef919c2013ef@gmail.com>
 <20191023165223.GA4163@redhat.com>
 <20191023172442.GX22766@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191023172442.GX22766@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Thu, 24 Oct 2019 07:31:04 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n82/LvZl+GucMZK4YinIAcI1lwtheo/oC9RuQSaBEMw=; b=B8SvHU/rhOG2NTh0SA61tiq9d
 /tnJ+Pnfo/sCYaSQnLryDLbk+1rrK/SmAQd3WgNQLcZ7DwqzDGBG2mMg4QObmjgvhVa1gpSnTZo/T
 MdRG+p4o4mSxouvzqD3Zxa/sJBs1yeIWfiJbuntnoyXmhmjn2qHcktB6zH0bb8si41epnCyehBnVg
 5aJP+oYOuo5EFYwmpGPWXa4wippARZBVovs68kwbw+NXXmMsZCdb5vkavMox6M/adYn0OKU/0WRVb
 OrohiMBsAKyzJxA3L3gWuY7NZRpkuW8v4tRtHZMOTo05gMp+AUh7bS5kexyR4NrOJtDqQytRomB+3
 jrn0SJR6w==;
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, "Yang,
 Philip" <Philip.Yang@amd.com>, Ralph Campbell <rcampbell@nvidia.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 John Hubbard <jhubbard@nvidia.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Jerome Glisse <jglisse@redhat.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191024021625.T4GvV1dcH0SpS81Gh1i9TdprdBeEYFbBg8lnGKK_8fE@z>

T24gV2VkLCBPY3QgMjMsIDIwMTkgYXQgMDU6MjQ6NDVQTSArMDAwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgo+IG1seDUgaXMgc2ltaWxhciwgYnV0IG5vdCBjdXJyZW50bHkgY29kZWQgcXVpdGUg
cmlnaHQsIHRoZXJlIGlzIG9uZQo+IGxvY2sgdGhhdCBwcm90ZWN0cyB0aGUgY29tbWFuZCBxdWV1
ZSBmb3Igc3VibWl0dGluZyBpbnZhbGlkYXRpb25zIHRvCj4gdGhlIEhXIGFuZCBpdCBkb2Vzbid0
IG1ha2UgYSBsb3Qgb2Ygc2Vuc2UgdG8gaGF2ZSBhZGRpdGlvbmFsIGZpbmUKPiBncmFpbmVkIGxv
Y2tpbmcgYmV5b25kIHRoYXQuCgpJRkYgYWxsIGRyaXZlcnMgY291bGQgYWdyZWUgb24gYSBsb2Nr
IHR5cGUgKHJ3X3NlbWFwaG9yZT8pIGZvciB0aGlzCnByb3RlY3Rpb24geW91IGNvdWxkIGFkZCBh
IHBvaW50ZXIgdG8gdGhlIHJhbmdlIHdoaWNoIHdvdWxkIGNsZWFyCnRoaW5ncyB1cCBhIGxvdC4g
IEknbSBqdXN0IG5vdCBzdXJlIHlvdSBjb3VsZCBnZXQgZXZlcnlvbmUgdG8KYWdyZWUuCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
