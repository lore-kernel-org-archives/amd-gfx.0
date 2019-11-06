Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992F4C5DF62
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 10:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7C2206A3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 10:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7C2206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C43D6ECA9;
	Wed,  6 Nov 2019 10:09:14 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700080.outbound.protection.outlook.com [40.107.70.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AEB56ECA9
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 10:09:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHP2gTOU12MJSGpneBYTKhjE8ZBu4m6B2VvE5A8Fn7cBjld80V8SRbdCYlhVCH0b62Ze5T3C+SIFoRYK96YaDsZMSN5Ccqh4gzB7N/YClkBwLL19Az8Y1Szbvg5xqZXp8OmRds//OS4Ob1euzToJg34zO4AemU5Crgm9BZA6LDGni6zaH4U0J3GW9jKwwESEJ9RjcHJlCm0zdTbRyy+QgG8ZxIaC8GTYwVFlyfNg7QoAvhUHb333deP0Di9dfUF68m7RUN3qqeBMIYqglC+2l9FPCdjup/fpOuWIaVpylCSRvhild217sjREiEo+2ciyGy8V16YGJL+tEsKA5Dyx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/voYLfLCZTguew9OEhcDuBMCH3uviiZdLdoWLPAUvBE=;
 b=cVWC9VQQjmL9Z1GQ6vhkJlVteisnyMRNs9pc4JCvnBPd48rqaSdojphq5oHjlOBv6EdQrQ4RCyQUVZpgyHcvmH+TIlYWKA4EcO4s5WH0uMHM6MPKL3giu1hNK9su9SCgnh0yunOnMIUuqHcZBo40RBRkBzUHoLaXyif+43cmowvLCTFJjWe+OxhJhZ8Z1FWwyrxD9vlYMRsAxXLl8k/+1j2bfcU0QTbv9A5Gpe97slYwR3VgMTwPif8epnr7IR108mh/2ssa4mtvahuTviq/qhqINJxHSXX9D7QGZ4e/IHrMRfMMDWtXP3uBjHWBIcwDnT/YCUhNJJ45xr018PJd2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (20.178.243.142) by
 MN2PR12MB3102.namprd12.prod.outlook.com (20.178.241.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 10:09:10 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::49e3:7f2c:931c:36e7]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::49e3:7f2c:931c:36e7%7]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 10:09:10 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Need to disable msix when unloading driver
Thread-Topic: [PATCH] drm/amdgpu: Need to disable msix when unloading driver
Thread-Index: AQHVlGrBJT+Rb0LvoUyv2c5IYs5XAad9rdGQgAAzYICAAAnf4A==
Date: Wed, 6 Nov 2019 10:09:10 +0000
Message-ID:
 <MN2PR12MB297565CEDAAF6460C71F98F28F790@MN2PR12MB2975.namprd12.prod.outlook.com>
References: <1573021419-15518-1-git-send-email-Emily.Deng@amd.com>
 <MN2PR12MB2975A3DFE6CCED7BB3D6D2748F790@MN2PR12MB2975.namprd12.prod.outlook.com>
 <6be1e7b9-13a9-f382-ef66-00c284a14a14@gmail.com>
In-Reply-To: <6be1e7b9-13a9-f382-ef66-00c284a14a14@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2fbc2d57-cf45-4617-fdaa-08d762a15e49
x-ms-traffictypediagnostic: MN2PR12MB3102:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB31023AD55252E5B62A9AE62D8F790@MN2PR12MB3102.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(53754006)(199004)(189003)(13464003)(81166006)(66574012)(446003)(316002)(11346002)(8676002)(86362001)(476003)(7736002)(8936002)(5660300002)(6506007)(53546011)(305945005)(76116006)(71190400001)(26005)(186003)(2501003)(478600001)(6636002)(99286004)(64756008)(66946007)(76176011)(7696005)(66446008)(3846002)(66476007)(66556008)(33656002)(6246003)(102836004)(2906002)(6116002)(74316002)(110136005)(66066001)(486006)(81156014)(6306002)(9686003)(14454004)(229853002)(55016002)(6436002)(25786009)(256004)(14444005)(966005)(71200400001)(52536014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3102;
 H:MN2PR12MB2975.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sy+7nLUB2cynjmkFdXnlkcoJoqoW1Kd4sPmklNnYEsX3MgTWdxGmVYqAt0wrVh3PPW0Hz4nQ/Wk5PCfX9c7IdP9Zq3IRBeKYA4jyBowELFJv1CkKNjprvOq4F+ee9q0LF127OpkJnm/f8ra0+LuRuzb/Y5fhu98TWRKxUvgHGbXehIFP7DMVVGGeG7F0f8Ay0TN/59JVepvHFIJsi3ZJc3iMR2ctjXJ63AWHCwQBhn/8akXUvTUxkLwsbdh/hHPzaNhbkYQ+YQlZ+7c4ui3O2yZebguPSdnVM7pRFRL87wizixI52B4rk/asZfsHmg7oMXrnXpOt5KMuLJVatANAxzTYQ5LxoPbM+4EBbpqEeORzxE6tTVVjhh+0PqozaXAUiHJLKyIZ8LpIlSLyZuD/6DR2/5pjWq53iBj1K9OZublNwgdw29mRx4sLGbnjSWcfGCMoWGxU8a6yZcDIn/DxbEDr2EId14fZzYWA3igrJAU=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbc2d57-cf45-4617-fdaa-08d762a15e49
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 10:09:10.5139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ed8X4dL2NnuXrE1wloFx80grjuJycuh7/lxGqU3IVZL0Sm1M8LxhDIWiFqsY46ff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3102
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/voYLfLCZTguew9OEhcDuBMCH3uviiZdLdoWLPAUvBE=;
 b=EKUv2AtVXlEodBCuFvxy9bZhbz0cixoI9Jkb/2O4Z9QTnVtJyrE7NNI3pTosekFRfMj72YE0+StAKIWcGCcyFHLwDMYo5KbJ0Z7xq2GNkugGt+PzCm9kT4AX+gHVErvM4MCHFr1dhVC/iNwdN1lsplkKlxi+Jj45aWYC4WaUOlE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Emily.Deng@amd.com; 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106100910.0lZejubdLj9UCj54-xSmJvOg0ySg4HkvWMICJTxRziY@z>

SGkgQ2hyaXN0aWFuLA0KICAgIFdlIHVzZSAiIHBjaV9hbGxvY19pcnFfdmVjdG9ycyAiIGluIGFt
ZGdwdV9pcnFfaW5pdC4gVGhpcyBwYXRjaCB1c2UgIiBwY2lfZnJlZV9pcnFfdmVjdG9ycyAiIGlu
IGFtZGdwdV9pcnFfZmluaS4NCg0KSGkgQWxleCwNCiAgICBDb3VsZCB5b3UgaGVscCB0byByZXZp
ZXcgdGhpcz8NCg0KQmVzdCB3aXNoZXMNCkVtaWx5IERlbmcNCg0KDQoNCj4tLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPkZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVt
ZXJrZW5AZ21haWwuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgNiwgMjAxOSA1OjMy
IFBNDQo+VG86IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IE5lZWQg
dG8gZGlzYWJsZSBtc2l4IHdoZW4gdW5sb2FkaW5nDQo+ZHJpdmVyDQo+DQo+Tm90IGFuIGV4cGVy
dCBvbiB0aGUgUENJIElSUSBzdHVmZiwgYnV0IGZyb20gd2hhdCBJIGtub3cgdGhhdCBsb29rcyBj
b3JyZWN0IHRvDQo+bWUuDQo+DQo+T25seSBxdWVzdGlvbiBJIGNhbiBzZWUgaXMgd2h5IGRvbid0
IHdlIHVzZSBwY2lfYWxsb2NfaXJxX3ZlY3RvcnMoKT8NCj5BbGV4IHByb2JhYmx5IG5lZWRzIHRv
IHRha2UgYSBsb29rLg0KPg0KPlJlZ2FyZHMsDQo+Q2hyaXN0aWFuLg0KPg0KPkFtIDA2LjExLjE5
IHVtIDA3OjI4IHNjaHJpZWIgRGVuZywgRW1pbHk6DQo+PiBIaSBhbGwsDQo+PiAgICAgIFBsZWFz
ZSBoZWxwIHRvIHJldmlldyB0aGlzLiBUaGlzIGlzIHRvIGZpeCBkcml2ZXIgcmVsb2FkIGlzc3Vl
Lg0KPj4NCj4+IEJlc3Qgd2lzaGVzDQo+PiBFbWlseSBEZW5nDQo+Pg0KPj4NCj4+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEVtaWx5IERlbmcgPEVtaWx5LkRlbmdAYW1k
LmNvbT4NCj4+PiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDYsIDIwMTkgMjoyNCBQTQ0KPj4+
IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPj4+IENjOiBEZW5nLCBFbWlseSA8
RW1pbHkuRGVuZ0BhbWQuY29tPg0KPj4+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogTmVl
ZCB0byBkaXNhYmxlIG1zaXggd2hlbiB1bmxvYWRpbmcNCj4+PiBkcml2ZXINCj4+Pg0KPj4+IEZv
ciBkcml2ZXIgcmVsb2FkIHRlc3QsIGl0IHdpbGwgcmVwb3J0ICJjYW4ndCBlbmFibGUgTVNJIChN
U0ktWCBhbHJlYWR5DQo+ZW5hYmxlZCkiLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogRW1pbHkg
RGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPg0KPj4+IC0tLQ0KPj4+IGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9pcnEuYyB8IDIgKy0NCj4+PiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJxLmMNCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9pcnEuYw0KPj4+IGluZGV4IDZmM2IwM2YuLjMwZDU0MGQgMTAwNjQ0DQo+
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jDQo+Pj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jDQo+Pj4gQEAgLTMxMSw3
ICszMTEsNyBAQCB2b2lkIGFtZGdwdV9pcnFfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikNCj4+PiAJCWRybV9pcnFfdW5pbnN0YWxsKGFkZXYtPmRkZXYpOw0KPj4+IAkJYWRldi0+aXJx
Lmluc3RhbGxlZCA9IGZhbHNlOw0KPj4+IAkJaWYgKGFkZXYtPmlycS5tc2lfZW5hYmxlZCkNCj4+
PiAtCQkJcGNpX2Rpc2FibGVfbXNpKGFkZXYtPnBkZXYpOw0KPj4+ICsJCQlwY2lfZnJlZV9pcnFf
dmVjdG9ycyhhZGV2LT5wZGV2KTsNCj4+PiAJCWlmICghYW1kZ3B1X2RldmljZV9oYXNfZGNfc3Vw
cG9ydChhZGV2KSkNCj4+PiAJCQlmbHVzaF93b3JrKCZhZGV2LT5ob3RwbHVnX3dvcmspOw0KPj4+
IAl9DQo+Pj4gLS0NCj4+PiAyLjcuNA0KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18NCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+PiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KPj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
