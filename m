Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EBEC49EAB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 10:02:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858022190F
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 10:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858022190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4814989180;
	Tue,  5 Nov 2019 10:02:13 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750044.outbound.protection.outlook.com [40.107.75.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AECEE89180
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 10:02:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7CEdeM2UYtFw4W0fHGucbxTdEFMIiNGD+hTtvtGq4jOC5mFBD/WPagU/bgY9DcSWpBzdT4IvXQWbzeGiay6DUxw1T6NNdFQsu0cVtr2y8imSPZyTHcUq7/8sE+I9HhfVTRujk7doDI/nrqfaTa9fuIPhc9hYdPJdqea16pn6MBehzc5agClqYNy6wn03ulE+mU35yVsgHpFvEnO9LiGxmQccrjS0+ItE0oi2eIeqMRW3R1+HfJKMtfrw5/e9/R98JDakgfGAnyGlTmg7WP/y6u0bAZGwEgwxyA1JsmK9GSjFL5we6/zbWYqQr4rV9K4Z/z3UGx7jIQREBpaCNIjtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3G6oBZsiwGa3adFQA3RJeoA7YUeMzXB1lx4d45Bplu8=;
 b=CAKCiEsN6s/uFbGWTNOx9H1lkzOi7ifeo8Qx7rKdz+3gtyQU48VNVwfLWpKrl7idycCz1g29q+Dq8/eYiMup4AN8+xNYU+Usx/TXBNVCUHnDa8mkxQoxnBF1y95iC1YEZYvH1px4m5Y2hM0uA8+OOu05rVB22NPBlcoxgEXozfMpErGKLtHMgtaJk6F2ZWpoVPZCi7TUETi6toQsQkWrD2xCFPSz9d5nlNXact6umIAaLz9sjRye3p6HD6UnngXSHdu4j8kturSBVdhkhT894cd0SKlSWmI89RnBFpJwfvfmEH3GvkrcO9rddR4FT7AvG53lKJP5plZsCz1gCdgUJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB3712.namprd12.prod.outlook.com (10.255.236.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 10:02:10 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::111:5294:f151:3846]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::111:5294:f151:3846%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 10:02:10 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: update Arcturus driver-smu interface
 header
Thread-Topic: [PATCH] drm/amd/powerplay: update Arcturus driver-smu interface
 header
Thread-Index: AQHVk7Ivu79ePOc7RkGMR+VD1ySeGKd8WI5A
Date: Tue, 5 Nov 2019 10:02:09 +0000
Message-ID:
 <MN2PR12MB359888A04CA91F7155036CC48E7E0@MN2PR12MB3598.namprd12.prod.outlook.com>
References: <20191105082218.19972-1-evan.quan@amd.com>
In-Reply-To: <20191105082218.19972-1-evan.quan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1eaffeda-4162-41f4-9e51-08d761d73933
x-ms-traffictypediagnostic: MN2PR12MB3712:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3712C39F6F58334CFBBBAE318E7E0@MN2PR12MB3712.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(189003)(199004)(13464003)(66556008)(110136005)(25786009)(66446008)(76176011)(9686003)(14454004)(81166006)(8676002)(81156014)(2501003)(476003)(14444005)(7696005)(66066001)(256004)(6116002)(74316002)(3846002)(5660300002)(11346002)(102836004)(8936002)(316002)(229853002)(15650500001)(6306002)(446003)(86362001)(6246003)(66476007)(64756008)(966005)(52536014)(99286004)(2906002)(76116006)(7736002)(53546011)(4326008)(186003)(26005)(55016002)(33656002)(71190400001)(305945005)(6436002)(486006)(71200400001)(66946007)(478600001)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3712;
 H:MN2PR12MB3598.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a4HCYuZZvCXMamcLh3umMAiYyPw39CH2c8V+FkeJi7nc9xq8K6G5wraRJohNt8PCBtUk1Shb5sjs0ziOHj9yFm5C8fifhMBq9MqqCj/SF1Mx3cPnNcDryLc/dVpfqncoN5A9S9aGUjMlvKFOBZItSM7gdNLW63GqWABlI+kwcm/hMpG7Q2ghxStbslJiqRSBfuCJTaoSkWilu2bsmTqY9Aji+MXfycXr+OJdZKZgdTA/RNsozYdBgwarkQtWCwMyhZiGVepQEFSZKTy4tZtOTABuPpWshksX5CEH7GtvDZX4BYFODAhItRkl5PpcPi8O8RThQf9b+BXSCJcgqbxSPFpD61JmunNWbFb+e9WQJPuERzzP0iHHlJrdksv3AevhbXxziEqByMeWe/o5NNqIZPHgkPPo0z8cyrVQK3/F2vz9YsDDs7jZUe7WTvN1cpXruvRRJE0VhAtQ/vZuITwQeVXw4opJ848DmFO35oe1tN0=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eaffeda-4162-41f4-9e51-08d761d73933
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 10:02:10.0442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYneLE1AHMuFVZZ5OZOF0+oiASGi9cTBiEuQFnAvfapi5K8i30P5HTowN89KgSNh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3712
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3G6oBZsiwGa3adFQA3RJeoA7YUeMzXB1lx4d45Bplu8=;
 b=u3qPSvcbfg09UiHjd6PjlrOK89vh6TYBjS4vapyHR6q3v/6M91Ocjf+pIs3WQLKKILWdbxtDIutDYM+FXpQQEv2z50GZNex42PUR89jKnZSnq/tLk/9ZUdbxdPA3N/4JrlS7L/qyPGXH13C+ItvZ+U1XgYb6xDj10YWZNDWmJFE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kenneth.Feng@amd.com; 
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105100209.pkdXCMFc_s3rFbHka8Fi4aEdxCxhzg4c3H0_-xgtusE@z>

UmV2aWV3ZWQtYnk6IEtlbm5ldGggRmVuZyA8a2VubmV0aC5mZW5nQGFtZC5jb20+DQoNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0Bs
aXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBRdWFuLCBFdmFuDQpTZW50OiBUdWVz
ZGF5LCBOb3ZlbWJlciA1LCAyMDE5IDQ6MjMgUE0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KQ2M6IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPg0KU3ViamVjdDogW1BB
VENIXSBkcm0vYW1kL3Bvd2VycGxheTogdXBkYXRlIEFyY3R1cnVzIGRyaXZlci1zbXUgaW50ZXJm
YWNlIGhlYWRlcg0KDQpbQ0FVVElPTjogRXh0ZXJuYWwgRW1haWxdDQoNClRvIGZpdCB0aGUgbGF0
ZXN0IFNNVSBmaXJtd2FyZS4NCg0KQ2hhbmdlLUlkOiBJYjE5N2U2MTg2MTI3MTIxYjRhZTI3NjYz
OWZhNjY2NzcwOTRhN2QwMQ0KU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1k
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9zbXUxMV9kcml2
ZXJfaWZfYXJjdHVydXMuaCB8IDIgKy0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9p
bmMvc211X3YxMV8wLmggICAgICAgICAgICAgICAgfCAyICstDQogMiBmaWxlcyBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211MTFfZHJpdmVyX2lmX2FyY3R1cnVzLmggYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211MTFfZHJpdmVyX2lmX2FyY3R1cnVzLmgN
CmluZGV4IDg4NmI5YTIxZWJkOC4uYTg4NmYwNjQ0ZDI0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL3NtdTExX2RyaXZlcl9pZl9hcmN0dXJ1cy5oDQorKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211MTFfZHJpdmVyX2lmX2FyY3R1
cnVzLmgNCkBAIC0xNTksNyArMTU5LDcgQEANCiAvL0ZJWE1FIG5lZWQgdXBkYXRpbmcNCiAvLyBE
ZWJ1ZyBPdmVycmlkZXMgQml0bWFzaw0KICNkZWZpbmUgRFBNX09WRVJSSURFX0RJU0FCTEVfVUNM
S19QSUQgICAgICAgICAgICAgICAweDAwMDAwMDAxDQotI2RlZmluZSBEUE1fT1ZFUlJJREVfRU5B
QkxFX1ZPTFRfTElOS19WQ05fRkNMSyAgICAgIDB4MDAwMDAwMDINCisjZGVmaW5lIERQTV9PVkVS
UklERV9ESVNBQkxFX1ZPTFRfTElOS19WQ05fRkNMSyAgICAgMHgwMDAwMDAwMg0KDQogLy8gSTJD
IENvbmZpZyBCaXQgRGVmaW5lcw0KICNkZWZpbmUgSTJDX0NPTlRST0xMRVJfRU5BQkxFRCAgICAg
ICAgICAgMQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9z
bXVfdjExXzAuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9zbXVfdjExXzAu
aA0KaW5kZXggODhlZTY2NjgzMjcxLi4zNjAyOGU5ZDEwMTEgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211X3YxMV8wLmgNCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2luYy9zbXVfdjExXzAuaA0KQEAgLTI3LDcgKzI3LDcgQEANCg0K
ICNkZWZpbmUgU01VMTFfRFJJVkVSX0lGX1ZFUlNJT05fSU5WIDB4RkZGRkZGRkYgICNkZWZpbmUg
U01VMTFfRFJJVkVSX0lGX1ZFUlNJT05fVkcyMCAweDEzIC0jZGVmaW5lIFNNVTExX0RSSVZFUl9J
Rl9WRVJTSU9OX0FSQ1QgMHgwRg0KKyNkZWZpbmUgU01VMTFfRFJJVkVSX0lGX1ZFUlNJT05fQVJD
VCAweDEwDQogI2RlZmluZSBTTVUxMV9EUklWRVJfSUZfVkVSU0lPTl9OVjEwIDB4MzMgICNkZWZp
bmUgU01VMTFfRFJJVkVSX0lGX1ZFUlNJT05fTlYxMiAweDMzICAjZGVmaW5lIFNNVTExX0RSSVZF
Ul9JRl9WRVJTSU9OX05WMTQgMHgzNA0KLS0NCjIuMjMuMA0KDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KYW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
