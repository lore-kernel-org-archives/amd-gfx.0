Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BBFCA9EA0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 05:48:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB5120679
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 05:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB5120679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01BFB6E37F;
	Mon, 28 Oct 2019 05:48:12 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730063.outbound.protection.outlook.com [40.107.73.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F23456E37F
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 05:48:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkfd36JnLbflgXqHISxY27NiMg51EW975pPBVx5Zob+D5E9aswjOcbBUhJs3cFZwYhuQHGloeTK2+23l8eIa4vRPnWhNQvXRT4QZSXRVozoGEvGyYe/YCm2NqSRTVNV8X1s4HDQgYTgnwRYM0gzhrHZ/cC+HEGFQ17UTbQ97WjWxcR0aJxkURmqmsQsryGsV+jYBAnIrVyPFzrVHwLiqXSvxQLupu3TqdJWoB5UcEZfWbl06xQgWGtgnrgvRftbuTfksNeTeJjKT1mq7K8FK0JWsPEW+4y+KWzSZRS03N2geP28XBPFO8R4LstQcCb29J1r0xfCnnZQ/j9Cdbx3BEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKXVMU+U8/R3QB7DwmGKB58oZ/SwijjtbTYAST9dBpg=;
 b=ckyAAwKDeCspIqDjj41zSaiqKOjj08BxY+cyrO09lbVcx2dHG9jkevgXKHTyiIOwHglTOUFuOVIa6tYpr1IaG1Wi1ZcAG9uB5pmpLcq/dVxHxmolLEaT9b0Ma1vg6zy233bCpmBQHBAZKUCItI57uD1MkcZNxLV9lnu8UBd6AWY/Dt+hzCXt9edlsHl8O6GFzETW9f2erirKH5vy5EoKFw1Q4KXw6bMxusjOgLsREqE8KcjbbYatvL0MnpNInxtI1/6MyesM82zn8D6lZO41lSQoLpFSjYgefDIueNrVfU48/yEPUGfDYWY6hhI1IMyBWdek5ewrognIXq5O0fm1wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB4029.namprd12.prod.outlook.com (10.255.237.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Mon, 28 Oct 2019 05:48:07 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 05:48:07 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Gong, Curry" <Curry.Gong@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: Disable gfx CGPG when suspend smu
Thread-Topic: [PATCH] drm/amd/powerplay: Disable gfx CGPG when suspend smu
Thread-Index: AQHViyRTBlhW3hx/qEqA5it2/Y10RKdvkAKg
Date: Mon, 28 Oct 2019 05:48:07 +0000
Message-ID:
 <MN2PR12MB33445EA31CC5982407D0896CE4660@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1572001610-9599-1-git-send-email-curry.gong@amd.com>
In-Reply-To: <1572001610-9599-1-git-send-email-curry.gong@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53dd6b75-a268-4510-24eb-08d75b6a68cb
x-ms-traffictypediagnostic: MN2PR12MB4029:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB40298928441BC1EB5C162BDCE4660@MN2PR12MB4029.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:415;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(13464003)(189003)(199004)(4326008)(33656002)(8676002)(74316002)(66476007)(256004)(25786009)(14444005)(2501003)(81156014)(81166006)(6246003)(66066001)(6436002)(7736002)(305945005)(2906002)(52536014)(8936002)(229853002)(476003)(71200400001)(11346002)(110136005)(486006)(26005)(71190400001)(55016002)(6506007)(446003)(9686003)(6306002)(5660300002)(15650500001)(14454004)(66946007)(64756008)(66556008)(66446008)(3846002)(76176011)(86362001)(76116006)(7696005)(6116002)(316002)(478600001)(966005)(102836004)(99286004)(53546011)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4029;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tOZpDkLNvspOZMJxkii6JUW24p0EHvfhkblCtVCSJLCibiFjoIrSsZn6hc9D+/BSuvwHL1l/1zNA8PCdZE24EW1LnJLuraXfCr26TQfXOovJSqYyb5Z5sGjdTA1URltFB4zk/UOEoQO6Wfg4jKMOVwxvIcxYAT0EFTyyZVOhkIcreWPuRieG4ed40vrnL7a6VXsVPlQ2H/mgvQrfRSB0RAOFKTXYuGvK/ZRn8SnQBdbPLFFVDC191Dyy8kksdLLXFYR5ThUxbm91LSuHxNFZ1vrV6hn4aWx4rYNMlQiqbtRFjyRR3hx781fdOMYw3jSybBLmaKV9jyOQwGpAZAKIn0ipGiM895lDKGY6Gx1BINOFt9XDT1lTT0fvaWgs9NFdIqh1wYtGarapX4E8jJ7oNY5ypZtjKhnMmDugsUIGWKbuFvKAFgdtTfFVDrC3ybS+tnfqEaGtKm1P+ajKkIw+q6USxURO/vY6PTED086WkVs=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53dd6b75-a268-4510-24eb-08d75b6a68cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 05:48:07.7729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/EhVin+csvasH1WH9RFb3Jap0grglwYl7fqdm3MI8q1/p0yxxXu3EXvAJeX2ykm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4029
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKXVMU+U8/R3QB7DwmGKB58oZ/SwijjtbTYAST9dBpg=;
 b=z6EWM5HoaCyiCH2n5JefmAaGCc8z3eHJ15aexQNBgf5/hSmprryRb5wACY34pJVM3YXk6wCj2qWdxilJ4vqxlMJypvTlkDEE+ktj8iVicVj63LlhC/SCa2qyM0Eis+Nzgr8ElHYOMSO5IPfk614pEuX2CghK9KfThXOK3/ydoqM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: "Gong, Curry" <Curry.Gong@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028054807.mRoJB5z-XCJYDqIuP6MHPPyx9W1HIc89NtCMkhslqhs@z>

QWNrZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgY2hlbiBnb25nDQpTZW50OiBGcmlkYXksIE9jdG9iZXIg
MjUsIDIwMTkgNzowNyBQTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzog
R29uZywgQ3VycnkgPEN1cnJ5LkdvbmdAYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gZHJtL2Ft
ZC9wb3dlcnBsYXk6IERpc2FibGUgZ2Z4IENHUEcgd2hlbiBzdXNwZW5kIHNtdQ0KDQppZiBubyBk
aXNhYmxlIGdmeCBDR1BHIHdoZW4gc3VzcGVuZCBzbXUsIGVuYWJsaW5nIGdmeCBDR1BHIHdpbGwg
ZmFpbCB3aGVuIHJlc3VtZSBzbXUuDQoNClBsYXRmb3JtOiBSZW5vaXINCmRtZXNnIGxvZyBpbmZv
cm1hdGlvbjoNCg0KWyAgMTUxLjg0NDExMCBdIGFtZGdwdTogW3Bvd2VycGxheV0gU01VIGlzIHJl
c3VtaW5nLi4uDQpbICAxNTEuODQ0MTE2IF0gYW1kZ3B1OiBbcG93ZXJwbGF5XSBkcG0gaGFzIGJl
ZW4gZGlzYWJsZWQNClsgIDE1MS44NDQ2MDQgXSBhbWRncHU6IFtwb3dlcnBsYXldIEZhaWxlZCB0
byBzZW5kIG1lc3NhZ2UgMHgyZixyZXNwb25zZSAweGZmZmZmZmZiIHBhcmFtIDB4MQ0KWyAgMTUx
Ljg0NDYwNSBdIGFtZGdwdTogW3Bvd2VycGxheV0gU01VIGlzIHJlc3VtZWQgc3VjY2Vzc2Z1bGx5
IQ0KDQpTaWduZWQtb2ZmLWJ5OiBjaGVuIGdvbmcgPGN1cnJ5LmdvbmdAYW1kLmNvbT4NCi0tLQ0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyB8IDIgKysNCiAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9hbWRncHVfc211LmMNCmluZGV4IDI2OTIzYWEuLjRlNDY4YjAgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMNCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYw0KQEAgLTEzNTEsNiArMTM1MSw4IEBA
IHN0YXRpYyBpbnQgc211X3N1c3BlbmQodm9pZCAqaGFuZGxlKQ0KIAlpZiAoYWRldi0+YXNpY190
eXBlID49IENISVBfTkFWSTEwICYmDQogCSAgICBhZGV2LT5nZngucmxjLmZ1bmNzLT5zdG9wKQ0K
IAkJYWRldi0+Z2Z4LnJsYy5mdW5jcy0+c3RvcChhZGV2KTsNCisJaWYgKHNtdS0+aXNfYXB1KQ0K
KwkJc211X3NldF9nZnhfY2dwZygmYWRldi0+c211LCBmYWxzZSk7DQogDQogCXJldHVybiAwOw0K
IH0NCi0tIA0KMi43LjQNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
