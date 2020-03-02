Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43290C3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1257F246B4
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iV2EiDox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1257F246B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3E5A6E209;
	Mon,  2 Mar 2020 09:34:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC0286E209
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 09:34:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4rT9jN2PK4viP+bs+43LXiVYyb3FF+NtPylnINKPQVbfMW9tLPzcEzate6m/RmvS//C69Q8qgrLQfu/8w+a3Wb/+iOq2S3ULxBSHfFmFiH/EG4Dd3XFGbIHn6ULv9xWZkXtfI9xS337jskYdt/k/pb+GJR3OVlqdk8k3rYW96eoEF2GLCN6LH9SrtIq+qVkMr9yzTsGnYGxyWrnydgujYSyJHZ85Ia8Vg9aA33jmSzfX77bSF4rjLsTcFz8idAHHmttYt2NKlS24J3jsA4mB5VKg+K7eBHVLGmQhV+Hxhh983C9csHraf7QxzDE8zGMRr+HopimQnEGxHCTvmeHWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRq6tRSqGQ5ju09K1K2hpGydLv71mFPn3eDufz0grmY=;
 b=meuPDpcWyBa/19dTfge9oa2dI+H4mo4XUsBCzE16uPD8Ec4YsuKu717NpbD8594oU1v9F07Wwsulgh80K/j3MSmbhDaQ8qa7O18EIf6nMAU3vzKiauGCiNcm0uZVI7BkQYbWHHqGU6z88aVQKnkNhBdIHYOYdHyqMs+QnxuibaqkTP5q6ntvBmBzB5uum/o5AN4hinXnh5mBs5MZVVnF8NxbKdT2CBlN4k87tdVxYD9QWTuGTFuGcDrFW6Fhpq2hADwFSGhW7w9G8LJO0/Fy7cL/ijafmPRdhess4nkhmqgWVJ0UfAR5CTV1JVIBadGm9H0rtBRkXj53I8dYAeLJKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRq6tRSqGQ5ju09K1K2hpGydLv71mFPn3eDufz0grmY=;
 b=iV2EiDox2Csl0lijNQy3qwcaIBlC2xbMr3Uz8NmDCqeJVJygz4hnjvVBFOAwo8RSE+BvzpSB6TT4BGWXWCvzG2Qb27qoEV04u0WvBeTNsCP4fZsdMyhHetp7AxViB2IDFkD2995fUrKEZlwYFqTp5/1qEUODWn7TVs3ae6K85D8=
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (2603:10b6:208:162::18)
 by MN2PR12MB3949.namprd12.prod.outlook.com (2603:10b6:208:167::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 09:34:39 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::4905:91cf:ae95:6ffb]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::4905:91cf:ae95:6ffb%7]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 09:34:39 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: don't use pipe1 of gfx10
Thread-Topic: [PATCH 2/3] drm/amdgpu: don't use pipe1 of gfx10
Thread-Index: AQHV8HQReLkruH2RsUWk4UHejSkXGqg1CWeAgAAA9kA=
Date: Mon, 2 Mar 2020 09:34:39 +0000
Message-ID: <MN2PR12MB3933CBC3EEB9AFA45F0DC09A84E70@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <1583140927-19809-1-git-send-email-Monk.Liu@amd.com>
 <1583140927-19809-2-git-send-email-Monk.Liu@amd.com>
 <DM5PR12MB14181B0ADC4E78F78BF88590FCE70@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB14181B0ADC4E78F78BF88590FCE70@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-02T09:30:01Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=cda4363c-4aa8-4a73-a156-0000ca7c1a45;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c60b1303-5e3b-4103-8e95-08d7be8cee4d
x-ms-traffictypediagnostic: MN2PR12MB3949:|MN2PR12MB3949:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3949FD747B181B2665E2FE3C84E70@MN2PR12MB3949.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(189003)(199004)(66946007)(66476007)(52536014)(64756008)(66446008)(66556008)(2906002)(86362001)(478600001)(9686003)(966005)(55016002)(71200400001)(76116006)(33656002)(45080400002)(5660300002)(8676002)(53546011)(7696005)(8936002)(81166006)(81156014)(6506007)(316002)(26005)(186003)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3949;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /8uQN79Q/Mx2jHgrOu4YHn50LioaGOLFl4Vloensvk0t0lHyVEpOuDr4vx5VryGsBbXdnaFOf57gta6MVQHUfrVXv9KFmozTqpwLSCEYtuKD9ScbI/wQFtS7SStzyXec1Gfz6qgtiTfk3SDNqwXxq9Ed65XP58eUZAA9n+1SIazDnxdjiybNub1IvuAlHEGybmKGZIZBiF4GOh1zd/6xvhG09szflC9y/TPgJJX+uyfirid90+qXXGAF2s65l0n7vCvX0y71u5A/14LSKTO2dzch5Dpek8OD1hT0W66iuVMeFR/5k51YLLbYInANHmr5okd3TJGzkOBG+vhpBzZdWYxsgDLS7epqpqs6ZT111IMrz7nFaG5nVFEs8zNvvHSG9g0J4UMK3XLGA/EiK4WUd+qSbdTh2m5vaOPDOtyazImcyMLyNklN3O74Eq979kJsmzuPJtiaXo5jhIpsequ4dy7A7JxeycnWpgav8DtZG7c=
x-ms-exchange-antispam-messagedata: LyjP86eQ1E6SBtyV7f5+2MwA+m2UB40AKW73tXsoKJpqWeuWmcKaJLEbS3KAJQFDETvRIRLDJBzAx7NxyBcBdvYcQ3zsJ2lhNXNdYKfBqaGFSbX1O6fNFoJrMLjBiQ4UBvIciWjEUTJteZVBGLRlnA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60b1303-5e3b-4103-8e95-08d7be8cee4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 09:34:39.6974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VlhKbYxl7pqhmhzzE+W7p+OdchUxY++AU0vsAdVbX0pO+dVGCBC1ZBGKW6n3UZZl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3949
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgSGF3a2luZw0KDQpJIGRpZG4ndCBzZWUgdGlhbmNpJ3MgcGF0Y2ggbWVyZ2VkIHRvIGRybS1u
ZXh0LCBpcyBpdCBwYXNzZWQgb3VyIHJldmlldyB5ZXQgPyANCg0KUGxlYXNlIGlnbm9yZSBteSBw
YXRjaCB0aGVuIA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KTW9uayBM
aXV8R1BVIFZpcnR1YWxpemF0aW9uIFRlYW0gfEFNRA0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPiANClNl
bnQ6IE1vbmRheSwgTWFyY2ggMiwgMjAyMCA1OjMwIFBNDQpUbzogTGl1LCBNb25rIDxNb25rLkxp
dUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBMaXUsIE1vbmsg
PE1vbmsuTGl1QGFtZC5jb20+DQpTdWJqZWN0OiBSRTogW1BBVENIIDIvM10gZHJtL2FtZGdwdTog
ZG9uJ3QgdXNlIHBpcGUxIG9mIGdmeDEwDQoNCltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBJbnRl
cm5hbCBEaXN0cmlidXRpb24gT25seV0NCg0KVGhpcyBoYXMgYWxyZWFkeSBkb25lIGJ5IFRpYW5j
aGkuDQoNClJlZ2FyZHMsDQpIYXdraW5nDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBC
ZWhhbGYgT2YgTW9uayBMaXUNClNlbnQ6IE1vbmRheSwgTWFyY2ggMiwgMjAyMCAxNzoyMg0KVG86
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogTGl1LCBNb25rIDxNb25rLkxpdUBh
bWQuY29tPg0KU3ViamVjdDogW1BBVENIIDIvM10gZHJtL2FtZGdwdTogZG9uJ3QgdXNlIHBpcGUx
IG9mIGdmeDEwDQoNCndoYXQ6DQp3ZSBmb3VuZCBzb21ldGltZXMgSURMRSBmYWlsIGFmdGVyIHZm
IGd1ZXN0IGZpbmlzaGVkIElCIHRlc3Qgb24gR0ZYIHJpbmcxIChwaXBlMSkNCg0Kd2h5Og0KYmVs
b3cgaXMgd2hhdCBDUCB0ZWFtIHN0YXRlZCAoTWFudSk6DQpHRlggUGlwZSAxIGlzIHRoZXJlIGlu
IEhXLCBidXQgYXMgcGFydCBvZiBvcHRpbWl6YXRpb24gYWxsIGRyaXZlciBkZWNpZGVkIG5vdCB0
byB1c2UgcGlwZSAxIGF0IGFsbCwgb3RoZXJ3aXNlIGRyaXZlciBoYXMgdG8gc2FjcmlmaWNlIGNv
bnRleHQgc28gYWxsIDcgY29udGV4dCB3aWxsIG5vdCBiZSBhYmxlIGZvciBHRlggcGlwZSAwLiBU
aGF04oCZcyB3aHkgSSBza2lwIHNldHRpbmcgb2Ygc3RhdGUgZm9yIGdmeCBwaXBlIDEgYXMgZGVj
aWRlZCBieSBhbGwgZHJpdmVyIHRlYW0NCg0KZml4Og0Kc2luY2UgQ1AgdGVhbSB3b24ndCBoZWxw
IHVzIHRvIGRlYnVnIGFueSBpc3N1ZXMgdGhhdCByZWxhdGVkIHdpdGggZ2Z4IHBpcGUxLCBzbyBi
YXNlZCBvbiBhYm92ZSByZWFzb24sIGxldCdzIHNraXAgZ2Z4IHJpbmcgMSAocGlwZTEpIGV2ZW4g
Zm9yIGJvdGggYmFyZS1tZXRhbCBhbmQgU1JJT1YNCg0KU2lnbmVkLW9mZi1ieTogTW9uayBMaXUg
PE1vbmsuTGl1QGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djEwXzAuYyB8IDI5ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5n
ZWQsIDE4IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjEwXzAuYw0KaW5kZXggMDU1NTk4OS4uYWZhZTRjYyAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KQEAgLTEzMDgsNyArMTMwOCw3IEBAIHN0YXRp
YyBpbnQgZ2Z4X3YxMF8wX3N3X2luaXQodm9pZCAqaGFuZGxlKQ0KIAljYXNlIENISVBfTkFWSTE0
Og0KIAljYXNlIENISVBfTkFWSTEyOg0KIAkJYWRldi0+Z2Z4Lm1lLm51bV9tZSA9IDE7DQotCQlh
ZGV2LT5nZngubWUubnVtX3BpcGVfcGVyX21lID0gMjsNCisJCWFkZXYtPmdmeC5tZS5udW1fcGlw
ZV9wZXJfbWUgPSAxOw0KIAkJYWRldi0+Z2Z4Lm1lLm51bV9xdWV1ZV9wZXJfcGlwZSA9IDE7DQog
CQlhZGV2LT5nZngubWVjLm51bV9tZWMgPSAyOw0KIAkJYWRldi0+Z2Z4Lm1lYy5udW1fcGlwZV9w
ZXJfbWVjID0gNDsNCkBAIC0yNzEzLDE4ICsyNzEzLDIxIEBAIHN0YXRpYyBpbnQgZ2Z4X3YxMF8w
X2NwX2dmeF9zdGFydChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCiANCiAJYW1kZ3B1X3Jp
bmdfY29tbWl0KHJpbmcpOw0KIA0KLQkvKiBzdWJtaXQgY3MgcGFja2V0IHRvIGNvcHkgc3RhdGUg
MCB0byBuZXh0IGF2YWlsYWJsZSBzdGF0ZSAqLw0KLQlyaW5nID0gJmFkZXYtPmdmeC5nZnhfcmlu
Z1sxXTsNCi0JciA9IGFtZGdwdV9yaW5nX2FsbG9jKHJpbmcsIDIpOw0KLQlpZiAocikgew0KLQkJ
RFJNX0VSUk9SKCJhbWRncHU6IGNwIGZhaWxlZCB0byBsb2NrIHJpbmcgKCVkKS5cbiIsIHIpOw0K
LQkJcmV0dXJuIHI7DQotCX0NCisJaWYgKGFkZXYtPmdmeC5tZS5udW1fcGlwZV9wZXJfbWUgPT0g
Mikgew0KKwkJLyogc3VibWl0IGNzIHBhY2tldCB0byBjb3B5IHN0YXRlIDAgdG8gbmV4dCBhdmFp
bGFibGUgc3RhdGUgKi8NCisJCXJpbmcgPSAmYWRldi0+Z2Z4LmdmeF9yaW5nWzFdOw0KIA0KLQlh
bWRncHVfcmluZ193cml0ZShyaW5nLCBQQUNLRVQzKFBBQ0tFVDNfQ0xFQVJfU1RBVEUsIDApKTsN
Ci0JYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgMCk7DQorCQlyID0gYW1kZ3B1X3JpbmdfYWxsb2Mo
cmluZywgMik7DQorCQlpZiAocikgew0KKwkJCURSTV9FUlJPUigiYW1kZ3B1OiBjcCBmYWlsZWQg
dG8gbG9jayByaW5nICglZCkuXG4iLCByKTsNCisJCQlyZXR1cm4gcjsNCisJCX0NCiANCi0JYW1k
Z3B1X3JpbmdfY29tbWl0KHJpbmcpOw0KKwkJYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgUEFDS0VU
MyhQQUNLRVQzX0NMRUFSX1NUQVRFLCAwKSk7DQorCQlhbWRncHVfcmluZ193cml0ZShyaW5nLCAw
KTsNCisNCisJCWFtZGdwdV9yaW5nX2NvbW1pdChyaW5nKTsNCisJfQ0KIA0KIAlyZXR1cm4gMDsN
CiB9DQpAQCAtMjgyMiw2ICsyODI1LDkgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfY3BfZ2Z4X3Jl
c3VtZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCiAJbXV0ZXhfdW5sb2NrKCZhZGV2LT5z
cmJtX211dGV4KTsNCiANCiAJLyogSW5pdCBnZnggcmluZyAxIGZvciBwaXBlIDEgKi8NCisJaWYg
KGFkZXYtPmdmeC5tZS5udW1fcGlwZV9wZXJfbWUgPT0gMSkNCisJCWdvdG8gZG9fc3RhcnQ7DQor
DQogCW11dGV4X2xvY2soJmFkZXYtPnNyYm1fbXV0ZXgpOw0KIAlnZnhfdjEwXzBfY3BfZ2Z4X3N3
aXRjaF9waXBlKGFkZXYsIFBJUEVfSUQxKTsNCiAJcmluZyA9ICZhZGV2LT5nZnguZ2Z4X3Jpbmdb
MV07DQpAQCAtMjg2MCw2ICsyODY2LDcgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfY3BfZ2Z4X3Jl
c3VtZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCiAJZ2Z4X3YxMF8wX2NwX2dmeF9zd2l0
Y2hfcGlwZShhZGV2LCBQSVBFX0lEMCk7DQogCW11dGV4X3VubG9jaygmYWRldi0+c3JibV9tdXRl
eCk7DQogDQorZG9fc3RhcnQ6DQogCS8qIHN0YXJ0IHRoZSByaW5nICovDQogCWdmeF92MTBfMF9j
cF9nZnhfc3RhcnQoYWRldik7DQogDQotLQ0KMi43LjQNCg0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlv
bi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJG
bWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDaGF3a2luZy56
aGFuZyU0MGFtZC5jb20lN0M3ZTdkZmIxNmViNTM0NGM0M2JjYzA4ZDdiZThiMzJlNCU3QzNkZDg5
NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxODczNzczOTA5NTkxOTIm
YW1wO3NkYXRhPTJHYjVhcEtaYW5DZnZnYmNsS0xPJTJCQUFiYXN4TmFtVWd3MGo1NjdISSUyQkJz
JTNEJmFtcDtyZXNlcnZlZD0wDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
