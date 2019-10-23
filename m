Return-Path: <SRS0=+G2B=YQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A80CA9EBC
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 20:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E0421872
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 20:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E0421872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F408F6EB83;
	Wed, 23 Oct 2019 20:26:23 +0000 (UTC)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02D716EB8B
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2019 20:26:22 +0000 (UTC)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-Mi54ZwgNMmyd4SWvphQ_uA-1; Wed, 23 Oct 2019 16:26:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01D3C800D5A;
 Wed, 23 Oct 2019 20:26:17 +0000 (UTC)
Received: from redhat.com (ovpn-123-188.rdu2.redhat.com [10.10.123.188])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A79610027A4;
 Wed, 23 Oct 2019 20:26:15 +0000 (UTC)
Date: Wed, 23 Oct 2019 16:26:13 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Message-ID: <20191023202539.GA3200@redhat.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191021184041.GF3177@redhat.com>
 <20191021190556.GI6285@mellanox.com>
MIME-Version: 1.0
In-Reply-To: <20191021190556.GI6285@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Mi54ZwgNMmyd4SWvphQ_uA-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1571862381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g1XeLbQwzCck5Lma54SyUL7NHxZOnECT3DsLOWtBh4k=;
 b=flLdISb/pLQJ0TRAqBSa1m3RAYv04lBBYV4NjaKYxYdXmPi1gpyKN+bEe/XAR8Bu1Oppyu
 mesM6VI4bkJcoUCAc6kDo9rBvBANy5tMwiBNlfzYYVdBo/5Q04KNz3AZnL2zNMAQPb9DXs
 9I8NYjuvwyGPwFE79GWfyY0+9b6gPLQ=
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
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Ralph Campbell <rcampbell@nvidia.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 John Hubbard <jhubbard@nvidia.com>,
 "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191023202613.8cpVfgGOA498n7-dkVlxLrFbOTKaV-bPQ49PLiRwIgU@z>

T24gTW9uLCBPY3QgMjEsIDIwMTkgYXQgMDc6MDY6MDBQTSArMDAwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgo+IE9uIE1vbiwgT2N0IDIxLCAyMDE5IGF0IDAyOjQwOjQxUE0gLTA0MDAsIEplcm9t
ZSBHbGlzc2Ugd3JvdGU6Cj4gPiBPbiBUdWUsIE9jdCAxNSwgMjAxOSBhdCAwMzoxMjoyN1BNIC0w
MzAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4gPiA+IEZyb206IEphc29uIEd1bnRob3JwZSA8
amdnQG1lbGxhbm94LmNvbT4KPiA+ID4gCj4gPiA+IDggb2YgdGhlIG1tdV9ub3RpZmllciB1c2lu
ZyBkcml2ZXJzIChpOTE1X2dlbSwgcmFkZW9uX21uLCB1bWVtX29kcCwgaGZpMSwKPiA+ID4gc2Np
Zl9kbWEsIHZob3N0LCBnbnRkZXYsIGhtbSkgZHJpdmVycyBhcmUgdXNpbmcgYSBjb21tb24gcGF0
dGVybiB3aGVyZQo+ID4gPiB0aGV5IG9ubHkgdXNlIGludmFsaWRhdGVfcmFuZ2Vfc3RhcnQvZW5k
IGFuZCBpbW1lZGlhdGVseSBjaGVjayB0aGUKPiA+ID4gaW52YWxpZGF0aW5nIHJhbmdlIGFnYWlu
c3Qgc29tZSBkcml2ZXIgZGF0YSBzdHJ1Y3R1cmUgdG8gdGVsbCBpZiB0aGUKPiA+ID4gZHJpdmVy
IGlzIGludGVyZXN0ZWQuIEhhbGYgb2YgdGhlbSB1c2UgYW4gaW50ZXJ2YWxfdHJlZSwgdGhlIG90
aGVycyBhcmUKPiA+ID4gc2ltcGxlIGxpbmVhciBzZWFyY2ggbGlzdHMuCj4gPiA+IAo+ID4gPiBP
ZiB0aGUgb25lcyBJIGNoZWNrZWQgdGhleSBsYXJnZWx5IHNlZW0gdG8gaGF2ZSB2YXJpb3VzIGtp
bmRzIG9mIHJhY2VzLAo+ID4gPiBidWdzIGFuZCBwb29yIGltcGxlbWVudGF0aW9uLiBUaGlzIGlz
IGEgcmVzdWx0IG9mIHRoZSBjb21wbGV4aXR5IGluIGhvdwo+ID4gPiB0aGUgbm90aWZpZXIgaW50
ZXJhY3RzIHdpdGggZ2V0X3VzZXJfcGFnZXMoKS4gSXQgaXMgZXh0cmVtZWx5IGRpZmZpY3VsdCB0
bwo+ID4gPiB1c2UgaXQgY29ycmVjdGx5Lgo+ID4gPiAKPiA+ID4gQ29uc29saWRhdGUgYWxsIG9m
IHRoaXMgY29kZSB0b2dldGhlciBpbnRvIHRoZSBjb3JlIG1tdV9ub3RpZmllciBhbmQKPiA+ID4g
cHJvdmlkZSBhIGxvY2tpbmcgc2NoZW1lIHNpbWlsYXIgdG8gaG1tX21pcnJvciB0aGF0IGFsbG93
cyB0aGUgdXNlciB0bwo+ID4gPiBzYWZlbHkgdXNlIGdldF91c2VyX3BhZ2VzKCkgYW5kIHJlbGlh
Ymx5IGtub3cgaWYgdGhlIHBhZ2UgbGlzdCBzdGlsbAo+ID4gPiBtYXRjaGVzIHRoZSBtbS4KPiA+
ID4gCj4gPiA+IFRoaXMgbmV3IGFycmFuZ21lbnQgcGxheXMgbmljZWx5IHdpdGggdGhlICFibG9j
a2FibGUgbW9kZSBmb3IKPiA+ID4gT09NLiBTY2FubmluZyB0aGUgaW50ZXJ2YWwgdHJlZSBpcyBk
b25lIHN1Y2ggdGhhdCB0aGUgaW50ZXJzZWN0aW9uIHRlc3QKPiA+ID4gd2lsbCBhbHdheXMgc3Vj
Y2VlZCwgYW5kIHNpbmNlIHRoZXJlIGlzIG5vIGludmFsaWRhdGVfcmFuZ2VfZW5kIGV4cG9zZWQg
dG8KPiA+ID4gZHJpdmVycyB0aGUgc2NoZW1lIHNhZmVseSBhbGxvd3MgbXVsdGlwbGUgZHJpdmVy
cyB0byBiZSBzdWJzY3JpYmVkLgo+ID4gPiAKPiA+ID4gRm91ciBwbGFjZXMgYXJlIGNvbnZlcnRl
ZCBhcyBhbiBleGFtcGxlIG9mIGhvdyB0aGUgbmV3IEFQSSBpcyB1c2VkLgo+ID4gPiBGb3VyIGFy
ZSBsZWZ0IGZvciBmdXR1cmUgcGF0Y2hlczoKPiA+ID4gIC0gaTkxNV9nZW0gaGFzIGNvbXBsZXgg
bG9ja2luZyBhcm91bmQgZGVzdHJ1Y3Rpb24gb2YgYSByZWdpc3RyYXRpb24sCj4gPiA+ICAgIG5l
ZWRzIG1vcmUgc3R1ZHkKPiA+ID4gIC0gaGZpMSAoMm5kIHVzZXIpIG5lZWRzIGFjY2VzcyB0byB0
aGUgcmJ0cmVlCj4gPiA+ICAtIHNjaWZfZG1hIGhhcyBhIGNvbXBsaWNhdGVkIGxvZ2ljIGZsb3cK
PiA+ID4gIC0gdmhvc3QncyBtbXUgbm90aWZpZXJzIGFyZSBhbHJlYWR5IGJlaW5nIHJld3JpdHRl
bgo+ID4gPiAKPiA+ID4gVGhpcyBpcyBzdGlsbCBiZWluZyB0ZXN0ZWQsIGJ1dCBJIGZpZ3VyZWQg
dG8gc2VuZCBpdCB0byBzdGFydCBnZXR0aW5nIGhlbHAKPiA+ID4gZnJvbSB0aGUgeGVuLCBhbWQg
YW5kIGhmaSBkcml2ZXJzIHdoaWNoIEkgY2Fubm90IHRlc3QgaGVyZS4KPiA+IAo+ID4gSXQgbWln
aHQgYmUgYSBnb29kIG9wb3J0dW5pdHkgdG8gYWxzbyBzd2l0Y2ggdGhvc2UgdXNlcnMgdG8KPiA+
IGhtbV9yYW5nZV9mYXVsdCgpIGluc3RlYWQgb2YgR1VQIGFzIEdVUCBpcyBwb2ludGxlc3MgZm9y
IHRob3NlCj4gPiB1c2Vycy4gSW4gZmFjdCB0aGUgR1VQIGlzIGFuIGltcGVkaW1lbnQgdG8gbm9y
bWFsIG1tIG9wZXJhdGlvbnMuCj4gCj4gSSB0aGluayB2aG9zdCBjYW4gdXNlIGhtbV9yYW5nZV9m
YXVsdAo+IAo+IGhmaTEgZG9lcyBhY3R1YWxseSBuZWVkIHRvIGhhdmUgdGhlIHBhZ2UgcGluLCBp
dCBkb2Vzbid0IGZlbmNlIERNQQo+IGR1cmluZyBpbnZhbGlkYXRlLgo+IAo+IGk5MTVfZ2VtIGZl
ZWxzIGFsb3QgbGlrZSBhbWRncHUsIHNvIHByb2JhYmx5IGl0IHdvdWxkIGJlbmVmaXQKPiAKPiBO
byBpZGVhIGFib3V0IHNjaWZfZG1hCj4gCj4gPiBJIHdpbGwgdGVzdCBvbiBub3V2ZWF1Lgo+IAo+
IFRoYW5rcywgaG9wZWZ1bGx5IGl0IHN0aWxsIHdvcmtzLCBJIHRoaW5rIFJhbHBoIHdhcyBhYmxl
IHRvIGRvIHNvbWUKPiBiYXNpYyBjaGVja3MuIEJ1dCBpdCBpcyBhIHByZXR0eSBjb21wbGljYXRl
ZCBzZXJpZXMsIEkgcHJvYmFibHkgbWFkZQo+IHNvbWUgbWlzdGFrZXMuCgpTbyBpdCBzZWVtcyB0
byB3b3JrIG9rIHdpdGggbm91dmVhdSwgd2lsbCBsZXQgdGVzdHMgcnVuIGluIGxvb3AgdGhvdWdo
dAp0aGVyZSBhcmUgbm90IHZlcnkgYWR2YW5jZSB0ZXN0LgoKPiAKPiBGV0lXLCBJIGtub3cgdGhh
dCBub3V2ZWF1IGdldHMgYSBsb2NrZGVwIHNwbGF0IG5vdyBmcm9tIERhbmllbAo+IFZldHRlcidz
IHJlY2VudCBjaGFuZ2VzLCBpdCB0cmllcyB0byBkbyBHRlBfS0VSRU5FTCBhbGxvY2F0aW9ucyB1
bmRlcgo+IGEgbG9jayBhbHNvIGhlbGQgYnkgdGhlIGludmFsaWRhdGVfcmFuZ2Vfc3RhcnQgcGF0
aC4KCkkgaGF2ZSBub3Qgc2VlbiBhbnkgc3BsYXQgc28gZmFyLCBpcyBpdCB0aHJvdWdodCBzb21l
IG5ldyBrZXJuZWwgY29uZmlnID8KCkNoZWVycywKSsOpcsO0bWUKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
