Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75CBC433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 16:15:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8627220639
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 16:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XNv/DBVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8627220639
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C41F6E941;
	Wed,  2 Sep 2020 16:15:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF0B06E941
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 16:15:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zqxuu9P8MrHyQMY2Gy5kdIGrDBbrlKfQyEo5+FJoPOpAb54zJsQZkOzrrpBBYQSm5fiAKmYOTBjI3J22+jVnEXc3FEF+HarktPOtz1MTcdtViBcObLwAOq0hR9y6Tql6tiHKEssol0D1mCxNoXDJRerOgIemaA6v3PDGF7Uqzs23GXTe3FVlG4ES3XAMg1AA0O8jEubzrDa6CqW+j/4rKhPIVmgsWI1OQjUjKLfHz3OzGtRIl6DC2A5FIAFp16JUn/qAJ9xCTyU1vFPabOC03nJ3XVLUfl5tlyWvKcQv+BbYqX6/rAxDvxj+rcwDQPGM4u++Ix0MZ5rbKbmtvrdP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhnpAtO21/WG60nUti7nJToy7cYXpNh97r+kLMcQLCw=;
 b=eKS1rlEKKnxuWW1tPMBqFxvGthrBd5nMINQ2mWvZUZA9ZR3WW5vEQpdOLfr2odn0AiWwm78vJGBhm1KmsYji8LAyWFFrMZbvxMfGCL1icxXuLJNflnHJ79XbOqWAUSClyttx9nW2MnyIAcZ1Hs94scVmDHrmqTJTLC/qx1JFRE0Eq2oF9Zfd5kW8Nkat5bnWk3uO/12aVWXCyOYXWuMiWQ07Pq5gjewGL6iM5E+YTvLImoXFaNOs2haNMXpL63VuuXfEyBN0SW30nI7VdwGj0I8mHa5dxKGlUlatA9SsD4ETb0kyofJe6QZUReKd0zMG1yL9DRJTtl6Yg+n/2QZhsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhnpAtO21/WG60nUti7nJToy7cYXpNh97r+kLMcQLCw=;
 b=XNv/DBVgAOqmZx/mMdVwthTzPH93/n8Fs6k44AMOKYloyw9UOTcv08ZXQOV5/kh9DGje5U5Rfd3zoY1fsucvrc19reHDYFr+bkwn1peMukVaYgMCNNAnu7IbRAdPvtMJ8hVqcGaCYJU5qGHrmnRBCGLj5983sPbt3nhtGqbBzAo=
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by SN1PR12MB2463.namprd12.prod.outlook.com (2603:10b6:802:22::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 2 Sep
 2020 16:15:50 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 16:15:50 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix max_entries calculation v3
Thread-Topic: [PATCH] drm/amdgpu: fix max_entries calculation v3
Thread-Index: AQHWgTyu2t3KDvm1gUKK5U10lc9z3KlVhikA
Date: Wed, 2 Sep 2020 16:15:49 +0000
Message-ID: <03C90896-08CE-46DA-B3B0-F755ED4A399F@amd.com>
References: <20200902152101.2280-1-christian.koenig@amd.com>
In-Reply-To: <20200902152101.2280-1-christian.koenig@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 80246b3b-0478-44ca-4123-08d84f5b7553
x-ms-traffictypediagnostic: SN1PR12MB2463:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB2463CDFF4EB87BD1AF5F3C6D872F0@SN1PR12MB2463.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RhWI4e81zTW8BV7GQMJXvCbW3hhodYobF6PxDyc3kFtQaWtvwEyQwp0HMfUPNJCFuHmkctkAijl1tshKkRK8Z1fV0yiJ25zv8SNHpVU7K6and1kONl2AimPEy9ACMnfWGg5TAT4UCWm0A7rA98Ma9e5hnHrwOKntbFA6Byif9mDDQTGeJTvKTpBL740+wevZ0TJeJBRaU5fr2WwO7iIN+ThcgTqaUFHhINYoMrWyfxsNM00QNE+OZNbhLmKK3PUyUlU03hF5kOOuUAvi13rg+PcagktM85eT17lk7IJGZhFWnsrO6e93zfLJa2yu95AgecCg1wfTGLxIOK2KYwJ7TUUAiLM9QFIpBQwLcedi0OI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(4326008)(54906003)(6916009)(6486002)(2616005)(2906002)(966005)(71200400001)(6512007)(33656002)(66946007)(8936002)(76116006)(66574015)(478600001)(36756003)(66476007)(8676002)(83380400001)(64756008)(6506007)(86362001)(91956017)(66446008)(66556008)(45080400002)(186003)(26005)(5660300002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 20xeEUYyzyFR66lW0zXR9vElwqUYCNc9g8SwRT12Nkyv+Sip/K6O7y5BaUd2rmLeZ7jAXKLLjvUTq1TeO0n6IoyD0VUZVYDTjvbz9QK+JNnA9H3Inep1LPSq3SlXCQeTMMmvQLGQRq9ldyJNUvh2DLFWsUAF+1mafqU15WKB72WS4xyxsDcFfTw1NF1YTKGB9bZBlftiRJg4KAJZP3/PN24NEeBGSd9SIDV56IFz16Aa46VKZpfySfsVHchBs7VBEirC8wqiX/ya+Plj9vcj8v6kcEPL5SMIyEBNltp0HqXNOlJ1FNzNhReHMZ7OH8v6yyACq5AkJSxpoe0+mxUZSckO18oqQpVHM3MMCKeUwxDYADTTpaTE3Ogw/oA2aOHZ0eqaPp9Rcm++cuNdkTp4RMkGvSJy0CeeZsyrb4gOmohPZeBKslHNV+EHD3Lbqo5T0KAqdvliqHhXsS4QKnBORHLUjhBOPGReIiEfOsRUEaWTPoWETp2rn4JnLhL6Cdx08t9kqn5MICgZP4prGCICfTi6E1Ngbft8embfgbFNfnYQTggTuhVWQpkdw+TqHKtbD20OOMVzLQsMQcNeyTwZv0lMKChl7D7Z2yK4uycGr3pqf1KZF/yig0R9QdSyqWB5Lv0voY+rlJxk7ZQdWDRAlQ==
Content-ID: <747F9757220D7B43A7D8272D489D1920@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80246b3b-0478-44ca-4123-08d84f5b7553
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 16:15:49.9705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JdHJSHn+9fzFl3ohp6H1F7s/z8Uvo8emYQXSTCetv2P3LZ95iqqPfeDUh4z8Lj7S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2463
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCj4gMjAyMOW5tDnmnIgy5pelIDIzOjIx77yMQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5s
ZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IOWGmemBk++8mg0KPiANCj4gQ2FsY3VsYXRlIHRoZSBj
b3JyZWN0IHZhbHVlIGZvciBtYXhfZW50cmllcyBvciB3ZSBtaWdodCBydW4gYWZ0ZXIgdGhlDQo+
IHBhZ2VfYWRkcmVzcyBhcnJheS4NCj4gDQo+IHYyOiBYaW5odWkgcG9pbnRlZCBvdXQgd2UgZG9u
J3QgbmVlZCB0aGUgc2hpZnQNCj4gdjM6IHVzZSBsb2NhbCBjb3B5IG9mIHN0YXJ0IGFuZCBzaW1w
bGlmeSBzb21lIGNhbGN1bGF0aW9uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IEZpeGVzOiAxZTY5MWUyNDQ0ODcgZHJt
L2FtZGdwdTogc3RvcCBhbGxvY2F0aW5nIGR1bW15IEdUVCBub2Rlcw0KPiAtLS0NCj4gZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCA0ICsrLS0NCj4gMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+IGluZGV4IDhiYzIyNTM5MzliZS4uN2NiZWUxYTdlYzg0
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiBAQCAtMTY5
Nyw3ICsxNjk3LDcgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fc3BsaXRfbWFwcGluZyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gCQkJCUFNREdQVV9HUFVfUEFHRVNfSU5fQ1BVX1BB
R0U7DQo+IAkJfSBlbHNlIHsNCj4gCQkJYWRkciA9IDA7DQo+IC0JCQltYXhfZW50cmllcyA9IFM2
NF9NQVg7DQo+ICsJCQltYXhfZW50cmllcyA9IG1hcHBpbmctPmxhc3QgLSBzdGFydCArIDE7DQo+
IAkJfQ0KPiANCj4gCQlpZiAocGFnZXNfYWRkcikgew0KPiBAQCAtMTcyNyw3ICsxNzI3LDcgQEAg
c3RhdGljIGludCBhbWRncHVfdm1fYm9fc3BsaXRfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwNCj4gCQkJYWRkciArPSBwZm4gPDwgUEFHRV9TSElGVDsNCj4gCQl9DQo+IA0KPiAt
CQlsYXN0ID0gbWluKCh1aW50NjRfdCltYXBwaW5nLT5sYXN0LCBzdGFydCArIG1heF9lbnRyaWVz
IC0gMSk7DQo+ICsJCWxhc3QgPSBzdGFydCArIG1heF9lbnRyaWVzIC0gMTsNCg0KSSBhbSBub3Qg
c3VyZSBpZiB3ZSBjYWxjdWxhdGUgdGhlIG1heF9lbnRyaWVzIGJ5IG5vZGVzLT5zaXplLiBkb2Vz
IGl0IHdvcmsgaW4gdGhhdCBjYXNlPw0KDQo+IAkJciA9IGFtZGdwdV92bV9ib191cGRhdGVfbWFw
cGluZyhhZGV2LCB2bSwgZmFsc2UsIGZhbHNlLCByZXN2LA0KPiAJCQkJCQlzdGFydCwgbGFzdCwg
ZmxhZ3MsIGFkZHIsDQo+IAkJCQkJCWRtYV9hZGRyLCBmZW5jZSk7DQo+IC0tIA0KPiAyLjE3LjEN
Cj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+
IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+
IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFt
ZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q3hpbmh1aS5wYW4lNDBhbWQuY29tJTdDYmIyYzI0NTY1
MzQ4NDJkMjRlOWMwOGQ4NGY1M2NmYzMlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgz
ZCU3QzAlN0MwJTdDNjM3MzQ2NTY4NjczNzAzODY4JmFtcDtzZGF0YT1yTEIzTUUyNUFreVJhUDZr
ZDNKeE9rdnF6M2lTS2hIdTlia1puTU1xUzc0JTNEJmFtcDtyZXNlcnZlZD0wDQoNCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
