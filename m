Return-Path: <SRS0=UwKb=ZU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353BAC432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 06:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0AF215A5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 06:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0AF215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 999FB6E1A3;
	Thu, 28 Nov 2019 06:50:27 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680088.outbound.protection.outlook.com [40.107.68.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A60A86E1A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2019 06:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GM2LAfTTdeVRrdr2K17YyLdxQSK6KQXd3mHziphrvcLbR2oKh7Qnp0PTVsRe9wENwQbd9EZr2TnzX++hoVcwW9S4AB9bmG9UdZUCJk64Z5KCvwIj1jS3zpBk/Vd5mhYVA9cp50rHGwtJWPiOhdsxLBSpmmbrZM+wUCooVrj7VXpwjV669tLggy6pLLJ4Rpun0kD7vN/bqFPGFmMb3W12HHFvQDtOoaxZAYx2VUC6nwOmlzc39B7+o3GiF5S9XiXPH46ZGw0eaS/xH6+btXNetFiBHr6Glc2c1AMqPbXmL3ghyYVdpnvmI5pHpm5WVdYyxPh4gAenUuMuTeWneZi8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mhpz2KjxO/q3ryp76a1nmrv85hHc4+VZw0cHxBpnz4E=;
 b=SFgqvkU1/k5cgWuxMZZ1IjxuNwdYV0JHsArHoA+ISdF+HCo7w2QcPo9nchCRRprhwzXyQ+F6o+CIr0kS5TwHWbJdfu0mQ/bkE/bjaY21uNIb0WzcNmoOIIcd350uY4Gijbz/eLtmddUdpup8TeGJUl55GsazvyzCyWz2iHVyuERLsi+oQ1a6kiCz+jjYOWp+LkPFCHbBfYRE28t3JQ1oBEFvK5C46WIAlahickURn/L8OQUjBV9nP30LGVX1C18Mz0wwiPqoB1MfoUe7LS1QDnWbcpAJtTriXxD78nhvh7KJHmFk1TdajamEFSD6uAgwMSa6BjBAy0G7yfCqSZKBzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3054.namprd12.prod.outlook.com (20.178.244.79) by
 MN2PR12MB3230.namprd12.prod.outlook.com (20.179.84.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Thu, 28 Nov 2019 06:50:24 +0000
Received: from MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::2935:2980:666:3c79]) by MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::2935:2980:666:3c79%5]) with mapi id 15.20.2474.023; Thu, 28 Nov 2019
 06:50:24 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 05/10] drm/amdgpu: enable/disable doorbell interrupt in
 baco entry/exit helper
Thread-Topic: [PATCH 05/10] drm/amdgpu: enable/disable doorbell interrupt in
 baco entry/exit helper
Thread-Index: AQHVpQNEuYCh1hmyRUmsFZCxww72K6egJNGg
Date: Thu, 28 Nov 2019 06:50:24 +0000
Message-ID:
 <MN2PR12MB30541C57228667CFC6DC74F6B0470@MN2PR12MB3054.namprd12.prod.outlook.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <1574846129-4826-4-git-send-email-le.ma@amd.com>
In-Reply-To: <1574846129-4826-4-git-send-email-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25f2639e-a7fd-4dc3-5881-08d773cf3e91
x-ms-traffictypediagnostic: MN2PR12MB3230:|MN2PR12MB3230:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB32302688E89D83D4B040AEDDB0470@MN2PR12MB3230.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(13464003)(189003)(199004)(66446008)(256004)(66066001)(478600001)(4326008)(5660300002)(52536014)(14454004)(33656002)(74316002)(229853002)(76116006)(6246003)(305945005)(3846002)(7736002)(6116002)(55016002)(6436002)(9686003)(25786009)(186003)(64756008)(102836004)(11346002)(66556008)(53546011)(6506007)(81156014)(66946007)(71200400001)(99286004)(26005)(66476007)(2906002)(316002)(110136005)(2501003)(71190400001)(54906003)(8936002)(8676002)(86362001)(81166006)(7696005)(76176011)(446003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3230;
 H:MN2PR12MB3054.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bForwVsk8B26QpHfc+q4YN1I6v58d/2ApyYS+4E9FIbkoKpkcMAqR4ldcnNfCqIDQqr/4H4CAbuggoLkmnc+2IleFAB478XzGVNPGAZiLXhf7l1p20M9v1P3JueELXx2Zf+6IbOw7vYdKAltXC+2m3QDDdU/xGN9JWvPw4n7vek+XXNiwC7WWx2ThohNPiASM2BwkQSYZZiC71xQup4KYp7bLB7auYwJAHYMhMCmxGglZQdPewyM9jIb6eYJQNtW/C8gfCFLcoTj4t8YjDlCU+XwLysBbbdisvzhu8MQAAlbb70hyPkNi+6OWHCym1ekJ1CfbmDNFFh+JzNpeDwOpfufGAj1PgbGlA3S1YsLhw3OnNMfb58bA5NIs1x5aCBK/zyH/Q5Ay+UAR/1Gsa6GbWVKTkVSSgXDWwklzytHqf8IhHY6hG4frIrdm3YbIhsR
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f2639e-a7fd-4dc3-5881-08d773cf3e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 06:50:24.0832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e84jE33eP1yTNL2EkFxzqY/jeK1dnOCp2d+y22YppaGXdKY+K1Vdq/CWYRNRgjaV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3230
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mhpz2KjxO/q3ryp76a1nmrv85hHc4+VZw0cHxBpnz4E=;
 b=3bosdc6RBMfAl8dfoigl2Ph6cuqTuV6C2kAIAZ+zG/JOQKcDXuz/01eA5PR2aTz83WbC3xTijAoG0sMyY7YSIgrbZ5EEaq72+X+R8/6TZANFlOVLEm70hBFmJRxvDpNJDfownyqXb0ZLt0IRvLzzH6tS2F4fdsPN21JyukNUEtI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tao.Zhou1@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191128065024.wksD3QFx5s0GpxfXxGeWXYmmXlEnT4GPpl0COhICK_Y@z>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGUgTWEgPGxlLm1hQGFt
ZC5jb20+DQo+IFNlbnQ6IDIwMTnlubQxMeaciDI35pelIDE3OjE1DQo+IFRvOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdA
YW1kLmNvbT47IENoZW4sIEd1Y2h1bg0KPiA8R3VjaHVuLkNoZW5AYW1kLmNvbT47IFpob3UxLCBU
YW8gPFRhby5aaG91MUBhbWQuY29tPjsgTGksIERlbm5pcw0KPiA8RGVubmlzLkxpQGFtZC5jb20+
OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBNYSwg
TGUgPExlLk1hQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAwNS8xMF0gZHJtL2FtZGdwdTog
ZW5hYmxlL2Rpc2FibGUgZG9vcmJlbGwgaW50ZXJydXB0IGluDQo+IGJhY28gZW50cnkvZXhpdCBo
ZWxwZXINCj4gDQo+IFRoaXMgb3BlcmF0aW9uIGlzIG5lZWRlZCB3aGVuIGJhY28gZW50cnkvZXhp
dCBmb3IgcmFzIHJlY292ZXJ5DQo+IA0KPiBDaGFuZ2UtSWQ6IEk1MzVjNzIzMTY5M2YzMTM4YThl
M2Q1YWNkNTU2NzJlMmFjNjgyMzJmDQo+IFNpZ25lZC1vZmYtYnk6IExlIE1hIDxsZS5tYUBhbWQu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
YyB8IDE5ICsrKysrKysrKysrKy0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRp
b25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBpbmRleCBiMTQwOGM1Li5iZDM4N2JiIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IEBAIC00MzA4LDEw
ICs0MzA4LDE0IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9kZXZpY2VfZ2V0X3BjaWVfaW5mbyhzdHJ1
Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldikgIGludCBhbWRncHVfZGV2aWNlX2JhY29fZW50ZXIo
c3RydWN0IGRybV9kZXZpY2UNCj4gKmRldikgIHsNCj4gIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiA9IGRldi0+ZGV2X3ByaXZhdGU7DQo+ICsJc3RydWN0IGFtZGdwdV9yYXMgKnJhcyA9IGFt
ZGdwdV9yYXNfZ2V0X2NvbnRleHQoYWRldik7DQo+IA0KPiAgCWlmICghYW1kZ3B1X2RldmljZV9z
dXBwb3J0c19iYWNvKGFkZXYtPmRkZXYpKQ0KPiAgCQlyZXR1cm4gLUVOT1RTVVBQOw0KPiANCj4g
KwlpZiAocmFzICYmIHJhcy0+c3VwcG9ydGVkKQ0KPiArCQlhZGV2LT5uYmlvLmZ1bmNzLT5lbmFi
bGVfZG9vcmJlbGxfaW50ZXJydXB0KGFkZXYsIGZhbHNlKTsNCj4gKw0KDQpbVGFvXSBUaGUgZm9s
bG93aW5nIGNvZGUgaXMgb2JzZXJ2ZWQgc2V2ZXJhbCB0aW1lcywgSSB0aGluayB3ZSBjYW4gYWRk
IGEgbmV3IGludGVyZmFjZSB0byByZXBsYWNlIGl0LCBJJ2xsIGRvIHRoYXQgd2hlbiBJIGhhdmUg
dGltZS4NCg0Kc3RydWN0IGFtZGdwdV9yYXMgKnJhcyA9IGFtZGdwdV9yYXNfZ2V0X2NvbnRleHQo
YWRldik7DQppZiAocmFzICYmIHJhcy0+c3VwcG9ydGVkKQ0KDQo+ICAJaWYgKGlzX3N1cHBvcnRf
c3dfc211KGFkZXYpKSB7DQo+ICAJCXN0cnVjdCBzbXVfY29udGV4dCAqc211ID0gJmFkZXYtPnNt
dTsNCj4gIAkJaW50IHJldDsNCj4gQEAgLTQzMTksOCArNDMyMyw2IEBAIGludCBhbWRncHVfZGV2
aWNlX2JhY29fZW50ZXIoc3RydWN0IGRybV9kZXZpY2UNCj4gKmRldikNCj4gIAkJcmV0ID0gc211
X2JhY29fZW50ZXIoc211KTsNCj4gIAkJaWYgKHJldCkNCj4gIAkJCXJldHVybiByZXQ7DQo+IC0N
Cj4gLQkJcmV0dXJuIDA7DQo+ICAJfSBlbHNlIHsNCj4gIAkJdm9pZCAqcHBfaGFuZGxlID0gYWRl
di0+cG93ZXJwbGF5LnBwX2hhbmRsZTsNCj4gIAkJY29uc3Qgc3RydWN0IGFtZF9wbV9mdW5jcyAq
cHBfZnVuY3MgPSBhZGV2LQ0KPiA+cG93ZXJwbGF5LnBwX2Z1bmNzOyBAQCAtNDMzMSwxNCArNDMz
MywxNSBAQCBpbnQNCj4gYW1kZ3B1X2RldmljZV9iYWNvX2VudGVyKHN0cnVjdCBkcm1fZGV2aWNl
ICpkZXYpDQo+ICAJCS8qIGVudGVyIEJBQ08gc3RhdGUgKi8NCj4gIAkJaWYgKHBwX2Z1bmNzLT5z
ZXRfYXNpY19iYWNvX3N0YXRlKHBwX2hhbmRsZSwgMSkpDQo+ICAJCQlyZXR1cm4gLUVJTzsNCj4g
LQ0KPiAtCQlyZXR1cm4gMDsNCj4gIAl9DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+
ICBpbnQgYW1kZ3B1X2RldmljZV9iYWNvX2V4aXQoc3RydWN0IGRybV9kZXZpY2UgKmRldikgIHsN
Cj4gIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGRldi0+ZGV2X3ByaXZhdGU7DQo+ICsJ
c3RydWN0IGFtZGdwdV9yYXMgKnJhcyA9IGFtZGdwdV9yYXNfZ2V0X2NvbnRleHQoYWRldik7DQo+
IA0KPiAgCWlmICghYW1kZ3B1X2RldmljZV9zdXBwb3J0c19iYWNvKGFkZXYtPmRkZXYpKQ0KPiAg
CQlyZXR1cm4gLUVOT1RTVVBQOw0KPiBAQCAtNDM1MSw3ICs0MzU0LDYgQEAgaW50IGFtZGdwdV9k
ZXZpY2VfYmFjb19leGl0KHN0cnVjdCBkcm1fZGV2aWNlDQo+ICpkZXYpDQo+ICAJCWlmIChyZXQp
DQo+ICAJCQlyZXR1cm4gcmV0Ow0KPiANCj4gLQkJcmV0dXJuIDA7DQo+ICAJfSBlbHNlIHsNCj4g
IAkJdm9pZCAqcHBfaGFuZGxlID0gYWRldi0+cG93ZXJwbGF5LnBwX2hhbmRsZTsNCj4gIAkJY29u
c3Qgc3RydWN0IGFtZF9wbV9mdW5jcyAqcHBfZnVuY3MgPSBhZGV2LQ0KPiA+cG93ZXJwbGF5LnBw
X2Z1bmNzOyBAQCAtNDM2Miw3ICs0MzY0LDEwIEBAIGludA0KPiBhbWRncHVfZGV2aWNlX2JhY29f
ZXhpdChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KQ0KPiAgCQkvKiBleGl0IEJBQ08gc3RhdGUgKi8N
Cj4gIAkJaWYgKHBwX2Z1bmNzLT5zZXRfYXNpY19iYWNvX3N0YXRlKHBwX2hhbmRsZSwgMCkpDQo+
ICAJCQlyZXR1cm4gLUVJTzsNCj4gLQ0KPiAtCQlyZXR1cm4gMDsNCj4gIAl9DQo+ICsNCj4gKwlp
ZiAocmFzICYmIHJhcy0+c3VwcG9ydGVkKQ0KPiArCQlhZGV2LT5uYmlvLmZ1bmNzLT5lbmFibGVf
ZG9vcmJlbGxfaW50ZXJydXB0KGFkZXYsIGZhbHNlKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiAg
fQ0KPiAtLQ0KPiAyLjcuNA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
