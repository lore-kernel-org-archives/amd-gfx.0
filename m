Return-Path: <SRS0=YLFm=YS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E97CA9EAF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 00:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F42321929
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 00:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F42321929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B6506E865;
	Fri, 25 Oct 2019 00:29:10 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680085.outbound.protection.outlook.com [40.107.68.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8BA6E865
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2019 00:29:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnHM/OVFcbjTgVOwcCfwZ78vL1v+Nc7xGAyD+PNdpSUWvcfAmYayaw0xSxMvj7ni4AbK/TI7x+K00ru8cX44oqU9L1Huu5Zeiy+7D5g1I3iRta9u5eQqhPt78hjn2alhunCrKw42dtNmitpCR2Wzxf9UZh6ZPVfo7pVcz2yMFJvk0bvQDMD9BwVQmKBSgjA6oxHhBuZQVuizGBly+J2CRxGvFpTEEUmOlhxZZXHQp6pQtpfXaI4RWpsYh1h1qy+HDo+fE1SDElPdf0upAQlbJqnz/hBPpZKHiRh6DKlpKPl4dXvLeM+hOfPFBBR/UWq9uFukgSo3RxU5r6fd7OzYqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIOpsZwjRcCG695/YGSMVZxrV+3vQr3FXspEsyg8WLI=;
 b=Anr7tLbq5eXVJkwcNwA7yfiXtJ9l3yOrtS5ANBG3DWTEpv9bt3vIalTYctMfYKWle76DOBp0lZr6ebZs7hUuZRyXRacbqHKUUrOcm+sB6DMQAroLwmh65PUyGwt6xukPuGp0vBAv3PGHjzNmHx+7G9lPG4R9eQJdkR60CQ2Jat5boAh4nKTcAsOAMVtlJZ+UNbhToLRLiU45P0JWo/6JxLh++hh/CDbuv0wsiVy3NmjUtFYj2ahU8kdyVpuZAC7Cmf7oIgXZC7CbUwpu+jtmGzGJtDyUoI/A6V0HioHYwpv7IWdulRcSIe0jODDK7qm+xTqDX3RGJBwu+HzwTNwOXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3646.namprd12.prod.outlook.com (20.178.241.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Fri, 25 Oct 2019 00:29:07 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::435:bdca:bac1:a26d]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::435:bdca:bac1:a26d%5]) with mapi id 15.20.2367.022; Fri, 25 Oct 2019
 00:29:06 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "Gong, Curry" <Curry.Gong@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: modify the parameters of
 SMU_MSG_PowerUpVcn to 0
Thread-Topic: [PATCH] drm/amd/powerplay: modify the parameters of
 SMU_MSG_PowerUpVcn to 0
Thread-Index: AQHViklgS/8OuwlMX0SV4tqSaaRud6dpgfkAgAD/s9A=
Date: Fri, 25 Oct 2019 00:29:06 +0000
Message-ID:
 <MN2PR12MB33440D918D7AED06A338FB5AE4650@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1571907564-18087-1-git-send-email-curry.gong@amd.com>
 <MN2PR12MB3838E06D487F8BE6792A9569F06A0@MN2PR12MB3838.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3838E06D487F8BE6792A9569F06A0@MN2PR12MB3838.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c8731b8-4eae-4c2d-132f-08d758e258af
x-ms-traffictypediagnostic: MN2PR12MB3646:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB36460EC129276EB850ED2F98E4650@MN2PR12MB3646.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(6029001)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(189003)(199004)(13464003)(76116006)(6306002)(99286004)(6116002)(2501003)(3846002)(256004)(6246003)(14444005)(66066001)(8936002)(81166006)(81156014)(316002)(7736002)(74316002)(186003)(102836004)(26005)(110136005)(229853002)(6506007)(8676002)(76176011)(53546011)(7696005)(9686003)(71200400001)(71190400001)(33656002)(305945005)(486006)(66476007)(476003)(64756008)(86362001)(66556008)(446003)(966005)(478600001)(4326008)(25786009)(55016002)(5660300002)(2906002)(52536014)(11346002)(14454004)(6436002)(66946007)(66446008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3646;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gj1sTStG2/k6lgJi0r+LlQfkiBVqp6ctcieYXQf282hG+lGOYPFvcua3OCJt/1sFT6IGjfc993DRJv5wmyJ+2Z64U4AFSF7bvpt6JEf0Akeo57B44D9On3U1RUQgf5E8h4eCAokeVMsPNoKQOtW/2WeCdnfgTv8heazPetPJmwDKm/B1qAgFnfB7wWlMskrxnCsqqfDSD8R75U4+TNeboQrDwM0U/VPdiDF/7atAW+/wSU6cq70U4MLsHHQU163r/W//L1kNjrR3A0EBJEfElaPBzWJ78+82Df1I61ocvgHdX9ccr/Kfvht3iOEmblk7LeKwSivJkczK0kWGh7Qzay8sk+3kJqrHFB7Dxg08ivtpLvNQGwI7Y+4J3JPAr2fF1B6zAaKK9BrlQ/lG8OeAKnTnFvqm11KAA4rhAh98nt0gE9m9iDwIowmgtQpvRk3Cbn1X+itKCEtK/fYwC7fQLjolxcO4+F1thKvj3wQNtmg=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8731b8-4eae-4c2d-132f-08d758e258af
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 00:29:06.8237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 67DrFC9ItOPLbKnqVXL9gemOgZ8KbFF7odaniowdCCLSo+0OFzUsB1YxtujKrRq2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3646
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIOpsZwjRcCG695/YGSMVZxrV+3vQr3FXspEsyg8WLI=;
 b=Jj2xLV3ttDAweIu9H6lRNA5Upk/48riIzY6rB7f7O3EmUpw5jWj+K7syLoM1ERrqwjBOg5Sl6mp+bfUkcuLFiYoLwTzDWQTnMxGIH1S7tuMFlViAkEv311rMI9AONc7MkR6eItqTFM+e2i7DpiJdPHG81q+joBNrzYyJP/gi4qw=
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
Message-ID: <20191025002906.BQqnPuW9jSiH30VC9Uv1w_p_b-J5TzirqqdvrXxCmvU@z>

QWNrZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgTGl1LCBBYXJvbg0KU2VudDogVGh1cnNkYXksIE9jdG9i
ZXIgMjQsIDIwMTkgNToxMyBQTQ0KVG86IEdvbmcsIEN1cnJ5IDxDdXJyeS5Hb25nQGFtZC5jb20+
OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IEdvbmcsIEN1cnJ5IDxDdXJyeS5H
b25nQGFtZC5jb20+DQpTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0vYW1kL3Bvd2VycGxheTogbW9k
aWZ5IHRoZSBwYXJhbWV0ZXJzIG9mIFNNVV9NU0dfUG93ZXJVcFZjbiB0byAwDQoNClJldmlld2Vk
LWJ5OiBBYXJvbiBMaXUgPGFhcm9uLmxpdUBhbWQuY29tPg0KDQpCUiwNCkFhcm9uIExpdQ0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91
bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiANCj4gY2hlbiBnb25nDQo+
IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDI0LCAyMDE5IDQ6NTkgUE0NCj4gVG86IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBHb25nLCBDdXJyeSA8Q3VycnkuR29uZ0BhbWQu
Y29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvcG93ZXJwbGF5OiBtb2RpZnkgdGhlIHBh
cmFtZXRlcnMgb2YgDQo+IFNNVV9NU0dfUG93ZXJVcFZjbiB0byAwDQo+IA0KPiBUaGUgcGFyYW1l
dGVycyB3aGF0IFNNVV9NU0dfUG93ZXJVcFZjbiBuZWVkIGlzIDAsIG5vdCAxDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBjaGVuIGdvbmcgPGN1cnJ5LmdvbmdAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9yZW5vaXJfcHB0LmMgfCAyICstDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9yZW5vaXJfcHB0LmMNCj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9yZW5vaXJfcHB0LmMNCj4gaW5kZXggNDVjNWY1NC4uNGE5
NzUxOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVub2ly
X3BwdC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Jlbm9pcl9wcHQu
Yw0KPiBAQCAtMjgyLDcgKzI4Miw3IEBAIHN0YXRpYyBpbnQgcmVub2lyX2RwbV9zZXRfdXZkX2Vu
YWJsZShzdHJ1Y3QgDQo+IHNtdV9jb250ZXh0ICpzbXUsIGJvb2wgZW5hYmxlKQ0KPiAgCWlmIChl
bmFibGUpIHsNCj4gIAkJLyogdmNuIGRwbSBvbiBpcyBhIHByZXJlcXVpc2l0ZSBmb3IgdmNuIHBv
d2VyIGdhdGUgbWVzc2FnZXMgKi8NCj4gIAkJaWYgKHNtdV9mZWF0dXJlX2lzX2VuYWJsZWQoc211
LA0KPiBTTVVfRkVBVFVSRV9WQ05fUEdfQklUKSkgew0KPiAtCQkJcmV0ID0gc211X3NlbmRfc21j
X21zZ193aXRoX3BhcmFtKHNtdSwNCj4gU01VX01TR19Qb3dlclVwVmNuLCAxKTsNCj4gKwkJCXJl
dCA9IHNtdV9zZW5kX3NtY19tc2dfd2l0aF9wYXJhbShzbXUsDQo+IFNNVV9NU0dfUG93ZXJVcFZj
biwgMCk7DQo+ICAJCQlpZiAocmV0KQ0KPiAgCQkJCXJldHVybiByZXQ7DQo+ICAJCX0NCj4gLS0N
Cj4gMi43LjQNCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
CmFtZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
