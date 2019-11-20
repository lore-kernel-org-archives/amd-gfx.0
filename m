Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D49C432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 08:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E60452235D
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 08:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60452235D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E58706E0EF;
	Wed, 20 Nov 2019 08:45:23 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe41::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41D776E0EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 08:45:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Egknf56t9SGfAwLMWaWtRuf1fnM1H3BE/8JB6UXKDuSFovTKhvCkevpkDHiDN3SpLpseIl0PhHwL4i0qoaaDv3hauR00AHXKP3M1/MQgzIV2u8u1oAkCZiGbkAJJkubttHyWHozVdhGbWfmk7CHnpd1S4MPjCMQIuqoHinlGki0pxzqnMvo5bRjS8U+ntnsmeZ3Px3pyqZJdhog93vbqogZTqhW3ju1DuTETdAXNkmrfZVGPNVAfnz+j27o9WgFPi/cAAe6jZcHiQoEiLNyqsJkj495LFmjxjWGb/9VwGBWqRWvZY9us9FxejP6LgXR/ES92kjS8QEQt/Yy+5WBbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRVqbXb8U9IPqFVGKZDjeg5MYvKkLzXJZma0QIhH28g=;
 b=A2fiEHGnksX/17vbsYmdRqTzKRROYPtI6DiYcVZP/zAv/AofzGuzwBqnPc09G1jpmSNtJoOwdfkU1ppXh/xyVretvIx0NBmeOof6cdhDDZfd+L+XGcwoq+1R7eLamajYbEuyZLSShC2Pd7PRyhmmpwdbenwPczSYIKMSzVzZYCK9tOWyGSm9REC5fzQVFykzrXCepPXIGMez7W7QLoriYT7FfOWSjYyciBP3ED14sDKAAYloXEusgjdPdKUUJNb/4K49EmYZV/k7LAbM26JwYLZxFBT/Y3ArdA1xQyb3uZOmlRVd0xAZAAN3P2DwsbWzdeLlRHt3/yLGChvj8P/IXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB2424.namprd12.prod.outlook.com (52.132.142.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Wed, 20 Nov 2019 08:45:19 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 08:45:19 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yuan, Xiaojie"
 <Xiaojie.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/gfx10: re-init clear state buffer after gpu
 reset
Thread-Topic: [PATCH] drm/amdgpu/gfx10: re-init clear state buffer after gpu
 reset
Thread-Index: AQHVn25hgnJp5nBSs0qXI2gya/dmz6eTvYcwgAABGIA=
Date: Wed, 20 Nov 2019 08:45:19 +0000
Message-ID:
 <DM5PR12MB14185B32B9CB4356233E5903FC4F0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20191120064701.2765-1-xiaojie.yuan@amd.com>
 <DM5PR12MB1418A32EB8199ABFFCCAEC04FC4F0@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1418A32EB8199ABFFCCAEC04FC4F0@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39faa773-c349-4485-d31a-08d76d95f937
x-ms-traffictypediagnostic: DM5PR12MB2424:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2424109EFC5F3C8A68D3E478FC4F0@DM5PR12MB2424.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(189003)(199004)(13464003)(8936002)(33656002)(2501003)(256004)(81156014)(8676002)(14444005)(81166006)(229853002)(6436002)(86362001)(7736002)(14454004)(2906002)(5660300002)(52536014)(478600001)(2940100002)(966005)(76116006)(3846002)(6116002)(25786009)(66946007)(64756008)(74316002)(54906003)(186003)(66446008)(66556008)(66476007)(305945005)(6506007)(316002)(4326008)(53546011)(26005)(71190400001)(110136005)(71200400001)(102836004)(6246003)(76176011)(66066001)(99286004)(446003)(11346002)(476003)(7696005)(486006)(9686003)(6306002)(55016002)(357404004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2424;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U6tfHihsWWH3SGudyhLPS02okfhsPsvDsOcVS7N6GFOeg5QupHenSOVkBgejxrh9avRfapBeGfq4nmDZY/YzEvjw0BCMcRBKYmzAcWa8UgeUCagggmJswKWzAGK2FOGbT1/iBlPuDWzzvzCUD9UahGmTZrxCAoQWnLoxsS+ge0n2H7kPnp5QFCQbkV2+dKtVmwR5d5HWH/Q1yKe2ph1v+0Slai85sodXq9V2hXqewwPEm8AfZSwmndbRQqUgCuwup5Me+UC11AzxA4/630Hlhi/pfOZMS9YCaaBJKOnoxTEfz1lsHYo/4IgeEPeAxnP5/nTNT72pqT/xgD9zEKUwkxXHpwHpDCbuITsgxAH44npbfrCPjZVFvdsi7dqyZiNpuTYGA6wwDdJIHBg/UhAAzNOY+AQB4Iv1R03VytOvlQKaQy8MPsYOWdd5qzYgAhGlaYvZhDYiWj3t7SHVUhjr3IEgxjEOu9Z6StVTLamGweQ=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39faa773-c349-4485-d31a-08d76d95f937
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 08:45:19.3235 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S74aEXRKppKtGlw+v7a+nCVCn8qdtbOT6oZW8sN1feVdefEysf7n5+dikChM2nm00eqMbMY6S1V2LASt+qoa/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2424
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRVqbXb8U9IPqFVGKZDjeg5MYvKkLzXJZma0QIhH28g=;
 b=CpYA1fE+pp89HBUVflDFsHhm/8joS0QsieABXnH0TuRD6jDeqjww+mhQtaAudZbzLk16nPpDduIX++iroGRKFbEI5YySiwtsZLd9W6S7ywZUUX4eANzrTTADBfHAK0gaoDnHihQ4gE68Touz4vvo2EdUUEwzXrBIi8dUqortwQM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xiao, Jack" <Jack.Xiao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120084519.mlLzgpe1OaIDu5xKFFHTjmPoS9Y0SbkWt-p6NGUTjLo@z>

T3IgaW4gYW5vdGhlciB3b3JkLCB3ZSBhcmUgc3RpbGwgbm90IGNsZWFyIHdoZW4gdGhlIGNvcnJ1
cHRpb24gYWN0dWFsbHkgaGFwcGVucywgcmlnaHQ/DQoNClJlZ2FyZHMsDQpIYXdraW5nDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIFpoYW5nLCBIYXdraW5nDQpTZW50OiAy
MDE55bm0MTHmnIgyMOaXpSAxNjo0NA0KVG86IFl1YW4sIFhpYW9qaWUgPFhpYW9qaWUuWXVhbkBh
bWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBMb25nLCBHYW5nIDxH
YW5nLkxvbmdAYW1kLmNvbT47IFhpYW8sIEphY2sgPEphY2suWGlhb0BhbWQuY29tPg0KU3ViamVj
dDogUkU6IFtQQVRDSF0gZHJtL2FtZGdwdS9nZngxMDogcmUtaW5pdCBjbGVhciBzdGF0ZSBidWZm
ZXIgYWZ0ZXIgZ3B1IHJlc2V0DQoNCkp1c3QgbWFrZSBzdXJlIEkgdW5kZXJzdGFuZCB5b3UgY29y
cmVjdGx5LiBTbyB1bnRpbCBmdyB0ZWFtIHJvb3QgY2F1c2UgdGhlIHJlYXNvbiBvZiBjc2IgY29y
cnVwdGlvbiwgd2Uga2VlcCB0aGUgd29ya2Fyb3VuZCBpbiBkcml2ZXIsIGNvcnJlY3Q/DQoNClJl
Z2FyZHMsDQpIYXdraW5nDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogWXVhbiwg
WGlhb2ppZSA8WGlhb2ppZS5ZdWFuQGFtZC5jb20+IA0KU2VudDogMjAxOeW5tDEx5pyIMjDml6Ug
MTQ6NDcNClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFpoYW5nLCBIYXdr
aW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBYaWFvLCBKYWNrIDxKYWNrLlhpYW9AYW1kLmNv
bT47IExvbmcsIEdhbmcgPEdhbmcuTG9uZ0BhbWQuY29tPjsgWXVhbiwgWGlhb2ppZSA8WGlhb2pp
ZS5ZdWFuQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHUvZ2Z4MTA6IHJlLWlu
aXQgY2xlYXIgc3RhdGUgYnVmZmVyIGFmdGVyIGdwdSByZXNldA0KDQpUaGlzIHBhdGNoIGZpeGVz
IDJuZCBiYWNvIHJlc2V0IGZhaWx1cmUgd2l0aCBnZnhvZmYgZW5hYmxlZCBvbiBuYXZpMXguDQoN
CmNsZWFyIHN0YXRlIGJ1ZmZlciAocmVzaWRlcyBpbiB2cmFtKSBpcyBjb3JydXB0ZWQgYWZ0ZXIg
MXN0IGJhY28gcmVzZXQsIHVwb24gZ2Z4b2ZmIGV4aXQsIENQRiBnZXRzIGdhcmJhZ2UgaGVhZGVy
IGluIENTSUIgYW5kIGhhbmdzLg0KDQpTaWduZWQtb2ZmLWJ5OiBYaWFvamllIFl1YW4gPHhpYW9q
aWUueXVhbkBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Yx
MF8wLmMgfCA0MyArKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAz
NyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjEwXzAuYw0KaW5kZXggOTI3NGJkNGI2YzY4Li44ZTI0ZWEwOGNhMzkgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCkBAIC0xNzg5LDI3ICsxNzg5LDUyIEBA
IHN0YXRpYyB2b2lkIGdmeF92MTBfMF9lbmFibGVfZ3VpX2lkbGVfaW50ZXJydXB0KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LA0KIAlXUkVHMzJfU09DMTUoR0MsIDAsIG1tQ1BfSU5UX0NOVExf
UklORzAsIHRtcCk7ICB9DQogDQotc3RhdGljIHZvaWQgZ2Z4X3YxMF8wX2luaXRfY3NiKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQ0KK3N0YXRpYyBpbnQgZ2Z4X3YxMF8wX2luaXRfY3NiKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KIHsNCisJaW50IHI7DQorDQorCWlmIChhZGV2LT5p
bl9ncHVfcmVzZXQpIHsNCisJCXIgPSBhbWRncHVfYm9fcmVzZXJ2ZShhZGV2LT5nZngucmxjLmNs
ZWFyX3N0YXRlX29iaiwgZmFsc2UpOw0KKwkJaWYgKHIpDQorCQkJcmV0dXJuIHI7DQorDQorCQly
ID0gYW1kZ3B1X2JvX2ttYXAoYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9vYmosDQorCQkJCSAg
ICh2b2lkICoqKSZhZGV2LT5nZngucmxjLmNzX3B0cik7DQorCQlpZiAoIXIpIHsNCisJCQlhZGV2
LT5nZngucmxjLmZ1bmNzLT5nZXRfY3NiX2J1ZmZlcihhZGV2LA0KKwkJCQkJYWRldi0+Z2Z4LnJs
Yy5jc19wdHIpOw0KKwkJCWFtZGdwdV9ib19rdW5tYXAoYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0
ZV9vYmopOw0KKwkJfQ0KKw0KKwkJYW1kZ3B1X2JvX3VucmVzZXJ2ZShhZGV2LT5nZngucmxjLmNs
ZWFyX3N0YXRlX29iaik7DQorCQlpZiAocikNCisJCQlyZXR1cm4gcjsNCisJfQ0KKw0KIAkvKiBj
c2liICovDQogCVdSRUczMl9TT0MxNShHQywgMCwgbW1STENfQ1NJQl9BRERSX0hJLA0KIAkJICAg
ICBhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX2dwdV9hZGRyID4+IDMyKTsNCiAJV1JFRzMyX1NP
QzE1KEdDLCAwLCBtbVJMQ19DU0lCX0FERFJfTE8sDQogCQkgICAgIGFkZXYtPmdmeC5ybGMuY2xl
YXJfc3RhdGVfZ3B1X2FkZHIgJiAweGZmZmZmZmZjKTsNCiAJV1JFRzMyX1NPQzE1KEdDLCAwLCBt
bVJMQ19DU0lCX0xFTkdUSCwgYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9zaXplKTsNCisNCisJ
cmV0dXJuIDA7DQogfQ0KIA0KLXN0YXRpYyB2b2lkIGdmeF92MTBfMF9pbml0X3BnKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQ0KK3N0YXRpYyBpbnQgZ2Z4X3YxMF8wX2luaXRfcGcoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQogew0KIAlpbnQgaTsNCisJaW50IHI7DQogDQotCWdmeF92
MTBfMF9pbml0X2NzYihhZGV2KTsNCisJciA9IGdmeF92MTBfMF9pbml0X2NzYihhZGV2KTsNCisJ
aWYgKHIpDQorCQlyZXR1cm4gcjsNCiANCiAJZm9yIChpID0gMDsgaSA8IGFkZXYtPm51bV92bWh1
YnM7IGkrKykNCiAJCWFtZGdwdV9nbWNfZmx1c2hfZ3B1X3RsYihhZGV2LCAwLCBpLCAwKTsNCiAN
CiAJLyogVE9ETzogaW5pdCBwb3dlciBnYXRpbmcgKi8NCi0JcmV0dXJuOw0KKwlyZXR1cm4gMDsN
CiB9DQogDQogdm9pZCBnZnhfdjEwXzBfcmxjX3N0b3Aoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpIEBAIC0xOTExLDcgKzE5MzYsMTAgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfcmxjX3Jlc3Vt
ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCiAJCXIgPSBnZnhfdjEwXzBfd2FpdF9mb3Jf
cmxjX2F1dG9sb2FkX2NvbXBsZXRlKGFkZXYpOw0KIAkJaWYgKHIpDQogCQkJcmV0dXJuIHI7DQot
CQlnZnhfdjEwXzBfaW5pdF9wZyhhZGV2KTsNCisNCisJCXIgPSBnZnhfdjEwXzBfaW5pdF9wZyhh
ZGV2KTsNCisJCWlmIChyKQ0KKwkJCXJldHVybiByOw0KIA0KIAkJLyogZW5hYmxlIFJMQyBTUk0g
Ki8NCiAJCWdmeF92MTBfMF9ybGNfZW5hYmxlX3NybShhZGV2KTsNCkBAIC0xOTM3LDcgKzE5NjUs
MTAgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfcmxjX3Jlc3VtZShzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikNCiAJCQkJcmV0dXJuIHI7DQogCQl9DQogDQotCQlnZnhfdjEwXzBfaW5pdF9wZyhh
ZGV2KTsNCisJCXIgPSBnZnhfdjEwXzBfaW5pdF9wZyhhZGV2KTsNCisJCWlmIChyKQ0KKwkJCXJl
dHVybiByOw0KKw0KIAkJYWRldi0+Z2Z4LnJsYy5mdW5jcy0+c3RhcnQoYWRldik7DQogDQogCQlp
ZiAoYWRldi0+ZmlybXdhcmUubG9hZF90eXBlID09IEFNREdQVV9GV19MT0FEX1JMQ19CQUNLRE9P
Ul9BVVRPKSB7DQotLQ0KMi4yMC4xDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
