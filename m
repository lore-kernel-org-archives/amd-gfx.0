Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BE1C5DF60
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 16:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 526B42084D
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 16:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526B42084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E58A6F9ED;
	Fri,  8 Nov 2019 16:06:58 +0000 (UTC)
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50074.outbound.protection.outlook.com [40.107.5.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D61C46F9CD;
 Fri,  8 Nov 2019 15:26:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idKNgVf6jVKmbn6oZNk9d+o8KH7zrMRnjZD09mWHwJr1/Kxwjg9irWZz8wWN8iMzB+kY6x+9k/dogRsJj3V7yEwt2b+4OFPvnbx391j5hjzouuGcFBN5P4G22TybBTWhVB81KY/RZyfH+qFzCBzuTiPsL+wgIQd07yvHjjuU59+wdgxn+FxMpsQiCOoxgdcjIPFKaDH6wSiwDrzBlaz9Lww5l2XpW20b3OmI2RlMnAcdL6TJGAvQepg7DXJ8oZ3lfTW2rLzSpmJ3ZMhKuH5l+QRkygbkZjy3PcYMuP4lhEAcN0rfB0ggFNTOxeczIqDQAV2gNOMTwnYs2gwOF1XlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kzwnbT9lm5Y4lK5jkW6EgWFPhy9eP7jnPkK++jCXto=;
 b=Q8DoVKO4xnqyDKSCkqug+bVxTz+cnMeujvO8wrNNM32hDUD4MHUDMPpuThmelGAywWEkmjgLL2yaZDGXEEGW28al/EOTeelBH09HIJmoLLapQQQMR2Wa3lJKGBNEKpUv4w5mT+zFM5d8+N7ppJHb+sj4jZOzLC2f6UQEvKTPA1pnXni4rUz1TVLxDF4OWUuK8Pi6FckgsvAWQnfd/lD2aYaSNLTIBZ+miFpOMeaFnkhjg7hy12ft+FCvFi8UrWOhYr4Idh+J8+wZOFDw/kfwnMUEb2JDeGtrbfOSDMN3xcQyNhy//2L1EFoTwx5ugi0xvS8XFKgCXCD6TQfILJ8veA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4109.eurprd05.prod.outlook.com (10.171.182.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Fri, 8 Nov 2019 15:26:03 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 15:26:03 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 02/15] mm/mmu_notifier: add an interval tree notifier
Thread-Topic: [PATCH v2 02/15] mm/mmu_notifier: add an interval tree notifier
Thread-Index: AQHVjcvJYOye0EiwZkisYK74G5bmhqd+54eAgAFKcgCAAA1gAIABNrMA
Date: Fri, 8 Nov 2019 15:26:03 +0000
Message-ID: <20191108152558.GG21728@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-3-jgg@ziepe.ca>
 <35c2b322-004e-0e18-87e4-1920dc71bfd5@nvidia.com>
 <20191107200604.GB21728@mellanox.com>
 <9dc2b3c7-f945-b645-b3a3-313a21d2fdfc@nvidia.com>
In-Reply-To: <9dc2b3c7-f945-b645-b3a3-313a21d2fdfc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:208:160::43) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48b76905-ba05-4f4b-6fcb-08d7645ff747
x-ms-traffictypediagnostic: VI1PR05MB4109:
x-microsoft-antispam-prvs: <VI1PR05MB4109D9C9A1D1C0D6DB42E1FFCF7B0@VI1PR05MB4109.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(199004)(189003)(25786009)(1076003)(486006)(386003)(14454004)(6916009)(316002)(99286004)(81156014)(478600001)(7416002)(81166006)(2906002)(6486002)(8676002)(446003)(6246003)(26005)(6512007)(6506007)(71200400001)(102836004)(2616005)(6436002)(71190400001)(8936002)(86362001)(36756003)(186003)(64756008)(6116002)(33656002)(305945005)(66946007)(66446008)(66556008)(66476007)(229853002)(76176011)(3846002)(256004)(66066001)(5660300002)(54906003)(476003)(11346002)(4326008)(52116002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB4109;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mV1RVWzPHLCQNN+LpAFkG7yEBh05U7w1QVa67j7ZZAtua2jv39j8Xb/7sQh+UCt9aThT0voGO9OdBWBO7n/SrpZAMioLYZvB+KfM5+vdiurRcDSwB6cwms1JEOijwDUI7PzJ17D+O1lQos3uJuuJfa8q4CYuLJBWWtJnPkMUtSCvrQxVcO1SX59e8ioTGsgr4YIF707P6SvIbKYtwhclZ9SVHODVVBIi/4ol3HIn/v0CqXXZmpCbGknthx8K3MmtzmcNWP/XIl/fknAYdSlD5iq+qhM9SljIFCAHf27p/G0xhqIR7uXIbG/JC/jWG0bXYL119G0tCCoc2nyNzHCl6Aqe2AsfgAHapZB06CTo0QYGBqce5X4BhyUF5AhjZV66BcyKIx8ZrHRi6eXMZ1zUuHfwwlj1GKM1dM4yw3F1cmjeODUl1sqKfofwGUv5jQ3l
x-ms-exchange-transport-forked: True
Content-ID: <8E8D480DDF199A4F8FA32DCA04F55AF3@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b76905-ba05-4f4b-6fcb-08d7645ff747
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 15:26:03.3786 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: azgdi27g8r0XKelABYVgzind4SWdZTnXU+8dGloSmUVxbgjx88SpHAZBy5oMZKbrSYfHEZNJYuOPM8eICD97RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4109
X-Mailman-Approved-At: Fri, 08 Nov 2019 16:06:56 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Mellanox.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kzwnbT9lm5Y4lK5jkW6EgWFPhy9eP7jnPkK++jCXto=;
 b=c0UJRdvRuINyqTVmXmI/thqBzveZgdEHz47hKMouKFoyBRIHHDEk5fB0460jdTvl8snP1wiYe+IApdU+ZKaRIND+OK8IsMS4uIkkzc7pyh4nKycQBPIpbZ5XCcdsTd0WS/jSFmyiqf/xjGlmQmzUP8rvNf5998PPM3tyH/mT8c4=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
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
 Ralph Campbell <rcampbell@nvidia.com>, Jerome Glisse <jglisse@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Petr Cvek <petrcvekcz@gmail.com>,
 Juergen Gross <jgross@suse.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108152603.8dsbj4g-scpv_XQ2AhbcxVuZqjagQHbt1ks_INIxMkU@z>

T24gVGh1LCBOb3YgMDcsIDIwMTkgYXQgMTI6NTM6NTZQTSAtMDgwMCwgSm9obiBIdWJiYXJkIHdy
b3RlOgo+ID4gPiA+ICsvKioKPiA+ID4gPiArICogc3RydWN0IG1tdV9yYW5nZV9ub3RpZmllcl9v
cHMKPiA+ID4gPiArICogQGludmFsaWRhdGU6IFVwb24gcmV0dXJuIHRoZSBjYWxsZXIgbXVzdCBz
dG9wIHVzaW5nIGFueSBTUFRFcyB3aXRoaW4gdGhpcwo+ID4gPiA+ICsgKiAgICAgICAgICAgICAg
cmFuZ2UsIHRoaXMgZnVuY3Rpb24gY2FuIHNsZWVwLiBSZXR1cm4gZmFsc2UgaWYgYmxvY2tpbmcg
d2FzCj4gPiA+ID4gKyAqICAgICAgICAgICAgICByZXF1aXJlZCBidXQgcmFuZ2UgaXMgbm9uLWJs
b2NraW5nCj4gPiA+ID4gKyAqLwo+ID4gPiAKPiA+ID4gSG93IGFib3V0IHRoaXMgKEknbSBub3Qg
c3VyZSBJIGZ1bGx5IHVuZGVyc3RhbmQgdGhlIHJldHVybiB2YWx1ZSwgdGhvdWdoKToKPiA+ID4g
Cj4gPiA+IC8qKgo+ID4gPiAgICogc3RydWN0IG1tdV9yYW5nZV9ub3RpZmllcl9vcHMKPiA+ID4g
ICAqIEBpbnZhbGlkYXRlOiBVcG9uIHJldHVybiB0aGUgY2FsbGVyIG11c3Qgc3RvcCB1c2luZyBh
bnkgU1BURXMgd2l0aGluIHRoaXMKPiA+ID4gICAqIAkJcmFuZ2UuCj4gPiA+ICAgKgo+ID4gPiAg
ICogCQlUaGlzIGZ1bmN0aW9uIGlzIHBlcm1pdHRlZCB0byBzbGVlcC4KPiA+ID4gICAqCj4gPiA+
ICAgKiAgICAgIAlAUmV0dXJuOiBmYWxzZSBpZiBibG9ja2luZyB3YXMgcmVxdWlyZWQsIGJ1dCBA
cmFuZ2UgaXMKPiA+ID4gICAqCQkJbm9uLWJsb2NraW5nLgo+ID4gPiAgICoKPiA+ID4gICAqLwo+
ID4gCj4gPiBJcyB0aGlzIGtkb2MgZm9ybWF0IGZvciBmdW5jdGlvbiBwb2ludGVycz8KPiAKPiBo
ZWgsIEknbSBzb3J0IG9mIHdpbmdpbmcgaXQsIEknbSBub3Qgc3VyZSBob3cgZnVuY3Rpb24gcG9p
bnRlcnMgYXJlIHN1cHBvc2VkCj4gdG8gYmUgZG9jdW1lbnRlZCBpbiBrZG9jLiBBY3R1YWxseSB0
aGUgb25seSBrZXkgdGFrZS1hd2F5IGhlcmUgaXMgdG8gd3JpdGUKPiAKPiAiVGhpcyBmdW5jdGlv
biBjYW4gc2xlZXAiCj4gCj4gYXMgYSBzZXBhcmF0ZSBzZW50ZW5jZS4uCgpTdXJlCgo+ID4gVGhp
cyBvZGQgZHVhbGl0eSBoYXMgYWxyZWFkeSBjYXVzZSBzb21lIGNvbmZ1c2lvbiwgYnV0IG5hbWVz
IGhlcmUgYXJlCj4gPiBoYXJkLiAgbW11X2ludGVydmFsX25vdGlmaWVyIGlzIHRoZSBiZXN0IGFs
dGVybmF0aXZlIEkndmUgaGVhcmQuCj4gPiAKPiA+IENoYW5naW5nIHRoaXMgbmFtZSBpcyBhIGxv
dCBvZiB3b3JrIC0gYXJlIHdlIGhhcHB5Cj4gPiAnbW11X2ludGVydmFsX25vdGlmaWVyJyBpcyB0
aGUgcmlnaHQgY2hvaWNlPyAKPiAKPiBZZXMsIGl0J3MgbXkgZmF2b3JpdGUgdG9vLiBJJ2Qgdm90
ZSBmb3IgZ29pbmcgd2l0aCB0aGF0LgoKT2theSwgbGV0cyBnaXZlIGl0IGEgZ28KCj4gVmVyeSBu
aWNlLCB3b3VsZCB5b3UgYmUgb3BlbiB0byBwdXR0aW5nIHRoYXQgaW50byAoYW55KSBvbmUgb2Yg
dGhlIGNvbW1lbnQKPiBoZWFkZXJzPyBUaGF0J3MgYW4gdW51c3VhbGx5IGNsZWFyIGFuZCBjb25j
aXNlIGRlc2NyaXB0aW9uOgoKWWVwLCBkb25lCgo+ID4gPiA+ICtpbnQgbW11X3JhbmdlX25vdGlm
aWVyX2luc2VydChzdHJ1Y3QgbW11X3JhbmdlX25vdGlmaWVyICptcm4sCj4gPiA+ID4gKwkJCSAg
ICAgIHVuc2lnbmVkIGxvbmcgc3RhcnQsIHVuc2lnbmVkIGxvbmcgbGVuZ3RoLAo+ID4gPiA+ICsJ
CQkgICAgICBzdHJ1Y3QgbW1fc3RydWN0ICptbSkKPiA+ID4gPiArewo+ID4gPiA+ICsJc3RydWN0
IG1tdV9ub3RpZmllcl9tbSAqbW1uX21tOwo+ID4gPiA+ICsJaW50IHJldDsKPiA+ID4gCj4gPiA+
IEhtbW0sIEkgdGhpbmsgYSBsYXRlciBwYXRjaCBpbXByb3Blcmx5IGNoYW5nZXMgdGhlIGFib3Zl
IHRvICJpbnQgcmV0ID0gMDsiLgo+ID4gPiBJJ2xsIGNoZWNrIG9uIHRoYXQuIEl0J3MgY29ycmVj
dCBoZXJlLCB0aG91Z2guCj4gPiAKPiA+IExvb2tzIE9LIGluIG15IHRyZWU/Cj4gCj4gTm9wZSwg
dGhhdCdzIGhvdyBJIGZvdW5kIGl0LiBUaGUgdG9wIG9mIHlvdXIgbW11X25vdGlmaWVyIGJyYW5j
aCBoYXMgdGhpczoKPiAKPiBpbnQgX19tbXVfbm90aWZpZXJfaW52YWxpZGF0ZV9yYW5nZV9zdGFy
dChzdHJ1Y3QgbW11X25vdGlmaWVyX3JhbmdlICpyYW5nZSkKPiB7Cj4gICAgICAgICBzdHJ1Y3Qg
bW11X25vdGlmaWVyX21tICptbW5fbW0gPSByYW5nZS0+bW0tPm1tdV9ub3RpZmllcl9tbTsKPiAg
ICAgICAgIGludCByZXQgPSAwOwo+IAo+ICAgICAgICAgaWYgKG1tbl9tbS0+aGFzX2ludGVydmFs
KSB7Cj4gICAgICAgICAgICAgICAgIHJldCA9IG1uX2l0cmVlX2ludmFsaWRhdGUobW1uX21tLCBy
YW5nZSk7Cj4gICAgICAgICAgICAgICAgIGlmIChyZXQpCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIHJldDsKPiAgICAgICAgIH0KPiAgICAgICAgIGlmICghaGxpc3RfZW1wdHkoJm1t
bl9tbS0+bGlzdCkpCj4gICAgICAgICAgICAgICAgIHJldHVybiBtbl9obGlzdF9pbnZhbGlkYXRl
X3JhbmdlX3N0YXJ0KG1tbl9tbSwgcmFuZ2UpOwo+ICAgICAgICAgcmV0dXJuIDA7Cj4gfQoKQWgs
IHRoYXQgaXMgYSBkaWZmZXJlbnQgZnVuY3Rpb24gOikgRml4ZWQKCj4gTG9va3MgZ29vZC4gV2Un
cmUganVzdCBwb2xpc2hpbmcgdXAgbWlub3IgcG9pbnRzIG5vdywgc28geW91IGNhbiBhZGQ6Cj4g
Cj4gUmV2aWV3ZWQtYnk6IEpvaG4gSHViYmFyZCA8amh1YmJhcmRAbnZpZGlhLmNvbT4KCkdyZWF0
LCB0aGFua3MsIEknbGwgcG9zdCBhIHYzIHdpdGggdGhlIHJlbmFtZQoKSmFzb24KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
