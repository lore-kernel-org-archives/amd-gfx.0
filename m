Return-Path: <SRS0=VQNv=YW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BF1CA9EC3
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 12:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D85FC2086A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 12:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85FC2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88E466E2BD;
	Tue, 29 Oct 2019 12:42:32 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C57C06E267;
 Tue, 29 Oct 2019 12:19:26 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Oct 2019 05:19:25 -0700
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; d="scan'208";a="203547917"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.206.224])
 ([10.254.206.224])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/AES256-SHA;
 29 Oct 2019 05:19:21 -0700
Subject: Re: [PATCH v2 06/15] RDMA/hfi1: Use mmu_range_notifier_inset for
 user_exp_rcv
To: Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
 Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-7-jgg@ziepe.ca>
From: Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <a8644875-9133-9667-c04b-b40c296d68eb@intel.com>
Date: Tue, 29 Oct 2019 08:19:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191028201032.6352-7-jgg@ziepe.ca>
Content-Language: en-US
X-Mailman-Approved-At: Tue, 29 Oct 2019 12:42:32 +0000
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
Cc: Juergen Gross <jgross@suse.com>, David Zhou <David1.Zhou@amd.com>,
 Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 linux-rdma@vger.kernel.org, nouveau@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@mellanox.com>, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, xen-devel@lists.xenproject.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Petr Cvek <petrcvekcz@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Ben Skeggs <bskeggs@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191029121920.jFmNAJNyuqSaJ5crWOtcI4YhrjUNbP003C_iHw0yup4@z>

T24gMTAvMjgvMjAxOSA0OjEwIFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4gRnJvbTogSmFz
b24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPgo+IAo+IFRoaXMgY29udmVydHMgb25lIG9m
IHRoZSB0d28gdXNlcnMgb2YgbW11X25vdGlmaWVycyB0byB1c2UgdGhlIG5ldyBBUEkuCj4gVGhl
IGNvbnZlcnNpb24gaXMgZmFpcmx5IHN0cmFpZ2h0Zm9yd2FyZCwgaG93ZXZlciB0aGUgZXhpc3Rp
bmcgdXNlIG9mCj4gbm90aWZpZXJzIGhlcmUgc2VlbXMgdG8gYmUgcmFjZXkuCj4gCj4gQ2M6IE1p
a2UgTWFyY2luaXN6eW4gPG1pa2UubWFyY2luaXN6eW5AaW50ZWwuY29tPgo+IENjOiBEZW5uaXMg
RGFsZXNzYW5kcm8gPGRlbm5pcy5kYWxlc3NhbmRyb0BpbnRlbC5jb20+Cj4gU2lnbmVkLW9mZi1i
eTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPgoKSSB0ZXN0ZWQgdjEsIGFuZCBy
ZXBsaWVkIHRvIGl0IFsxXS4gSSBjYW4gcmUtdGVzdCB3aXRoIHRoaXMgdmVyc2lvbiBpZiAKeW91
IGxpa2UgYXMgd2VsbC4KClsxXSBodHRwczovL21hcmMuaW5mby8/bD1saW51eC1yZG1hJm09MTU3
MjM1MTMwNjA2NDEyJnc9MgoKLURlbm55Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
