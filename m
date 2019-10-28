Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6081CA9EBF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 10:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9465320873
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 10:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9465320873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF926E5A0;
	Mon, 28 Oct 2019 10:51:17 +0000 (UTC)
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-eopbgr810089.outbound.protection.outlook.com [40.107.81.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1C866E5A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 10:51:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ib1sJ4fMeubuZuhLvd41r4POmHa+rRGMmVxAinSGFDe4wTeDDBmar9+pKmHD0CfYjZwjZSbHlpX9gLAeLci+rLIHbdFKL7kGnlzzDrb+Z7w69cTUWhQg5ACtq7IelxsLgULKhlmKi2dqpk7tJ36KmIsGao/KHOkBRFuonbNhGXRPxz7TJZR49u8BOR+UPsnIw/6n5NQwNXkw04/TCQrR9/Je0qpbtdfdssydHhZjIjercNIaXV9+ecrqOMK1m2emp0Fwy4R9LUe4SU0WaK9I69RDokI22QuDJIFDfnnqp3BNgE+XTMHlA5p+N0NO9fVJR+aygBYQbFayw1+pH73wKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mh+6Vh6Zo7tebE287+3B9Npn9yNDxNByclMx9+YppUU=;
 b=gmMu6Z9Qld6nEUVrKXkNeGqxsQ+vCASKFPtNNNm+yh2gaVNQAGpKSnmRSx9EjdN4eoKt2d83vf/InmsUXHZ1dJ4754ms8fkkNVe8RP3raSbOySV247UN1KnxbV2bej4jIHM7QEowxOaW5qoEsEfRJvVUUTYnu63W0NUWVAYRMzB88By9jCYfZGmyryO1XDhat3Evm5GpvPlmwEaStmAifpepX6vca6eiH4QLnfxvdn0rzGBDgB1NJNVm516xTxsAel1tSeBMRp1isG4mLzDMd4B2AJAc6Y7GUOsl8tgu6SBUKqBzPrbR1dTh0xpCF7qI7F/nL/qMnV2XnPtH2bNYpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2438.namprd12.prod.outlook.com (52.132.141.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Mon, 28 Oct 2019 10:51:14 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 10:51:14 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: GFX10: GRBM requires 1-cycle delay (v2)
Thread-Topic: [PATCH] drm/amdgpu: GFX10: GRBM requires 1-cycle delay (v2)
Thread-Index: AQHVi4fpC3AwdVjhPUe0pcPT6Tgl3qdv5CaA
Date: Mon, 28 Oct 2019 10:51:14 +0000
Message-ID: <2fe5443f-32be-c56f-b108-663f6ad59b6b@amd.com>
References: <b40c78f1-17a5-f0f9-183e-0c78fd7163e9@amd.com>
 <20191025225930.15074-1-luben.tuikov@amd.com>
In-Reply-To: <20191025225930.15074-1-luben.tuikov@amd.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM0PR05CA0007.eurprd05.prod.outlook.com
 (2603:10a6:208:55::20) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 028394b5-c93a-4a48-8778-08d75b94c081
x-ms-traffictypediagnostic: DM5PR12MB2438:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB24388F5F4D1F433F4F47819983660@DM5PR12MB2438.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(199004)(189003)(66446008)(66556008)(64756008)(66476007)(66946007)(4326008)(31696002)(46003)(6436002)(446003)(6512007)(6246003)(6486002)(25786009)(14454004)(2501003)(11346002)(478600001)(6116002)(58126008)(110136005)(316002)(229853002)(31686004)(7736002)(305945005)(2616005)(6506007)(256004)(2906002)(476003)(486006)(386003)(86362001)(5660300002)(186003)(71200400001)(99286004)(71190400001)(14444005)(52116002)(8676002)(36756003)(76176011)(81156014)(81166006)(102836004)(66574012)(8936002)(65806001)(65956001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2438;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QDK2SqXP3fc6bo5umMgKRO6CS//PoEdGH0s8p4TDlKh/KfyZ5Df6HUTWGxtahTRBiobh75ba77JlLAZAUe2EdBhWevvXu6REV4vEZ8tiMoC+ZLyOGHOaQR1wmFcqf1WD2et8N/sD2NizszKkdo7jXtyyyG8vKUQm3E9UZBU0ZvU3N7nN3Ch1yBLN1zkyiYiOn+GdEflrs1y7+ncvJ3O20h40hk++lqMWXQPh/ZiyzsqxekX/Y6a0O1sgosQf6felX4za6btlogC1dk0Gl3cEK6r5VvjjxR23M4D/cTqIHa3tyyDjWO05cz6+oMoMprQU3nR/JpxEyWOWigIz5nN50/p59XWVqdKkhRt1IC0oHX71kANapRvfSSceALmBPl0D2W79zLbyVoQYVlTvjXWQgeCQb6Qqvtu/ZR3a2s+O/prAWo4LOXfG+6tNtxkP9VvP
Content-ID: <774DF92C451837499DDA0D2C8A66CD30@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028394b5-c93a-4a48-8778-08d75b94c081
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 10:51:14.1105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8/Arrs/C9xY/rkZw+rr9jKk/SuyVlnswwSQIzWfQeoiWl1RQp3aWHcJXbZ0N3Leb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mh+6Vh6Zo7tebE287+3B9Npn9yNDxNByclMx9+YppUU=;
 b=qLOXGdzGhNB5m7DJMYC1j9LUmKQh6DHvNWoDR3mT/JWCsHqufppLs+gb/Ba+CozcJUmCkzsYMLGG6ptf6bzmhQLhlZ5Vd9ffTIEWqs3zhOqmug6t+xbizCNF7t6jhCcPnMpjBeq4aO3zrZ47VLeop85w5qnWHydPyhoa5ggpnrU=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028105114.DIxRXWEsYXRVWi6cR1mU5VJ9Oj3p8dCwYPXWgUwZBss@z>

QW0gMjYuMTAuMTkgdW0gMDA6NTkgc2NocmllYiBUdWlrb3YsIEx1YmVuOg0KPiBUaGUgR1JCTSBp
bnRlcmZhY2UgaXMgbm93IGNhcGFibGUgb2YgYnVyc3RpbmcNCj4gMS1jeWNsZSBvcCBwZXIgcmVn
aXN0ZXIsIGEgV1JJVEUgZm9sbG93ZWQgYnkNCj4gYW5vdGhlciBXUklURSwgb3IgYSBXUklURSBm
b2xsb3dlZCBieSBhIFJFQUQtLW11Y2gNCj4gZmFzdGVyIHRoYW4gcHJldmlvdXMgbXV0aS1jeWNs
ZSBwZXINCj4gY29tcGxldGVkLXRyYW5zYWN0aW9uIGludGVyZmFjZS4gVGhpcyBjYXVzZXMgYQ0K
PiBwcm9ibGVtLCB3aGVyZWJ5IHN0YXR1cyByZWdpc3RlcnMgcmVxdWlyaW5nIGENCj4gcmVhZC93
cml0ZSBieSBoYXJkd2FyZSwgaGF2ZSBhIDEtY3ljbGUgZGVsYXksIGR1ZQ0KPiB0byB0aGUgcmVn
aXN0ZXIgdXBkYXRlIGhhdmluZyB0byBnbyB0aHJvdWdoIEdSQk0NCj4gaW50ZXJmYWNlLg0KPg0K
PiBUaGlzIHBhdGNoIGFkZHMgdGhpcyBkZWxheS4NCj4NCj4gQSBvbmUgY3ljbGUgcmVhZCBvcCBp
cyBhZGRlZCBhZnRlciB1cGRhdGluZyB0aGUNCj4gaW52YWxpZGF0ZSByZXF1ZXN0IGFuZCBiZWZv
cmUgcmVhZGluZyB0aGUNCj4gaW52YWxpZGF0ZS1BQ0sgc3RhdHVzLg0KPg0KPiBTZWUgYWxzbyBj
b21taXQNCj4gNTM0OTkxNzMxY2I1ZmE5NGI1NTE5OTU3NjQ2Y2Y4NDljYTEwZDE3ZC4NCj4NCj4g
djI6IFJlbW92ZSBHRlg5IGFuZCBhcHBseSBvbmx5IHRvIFNETUEgcmluZy4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogTHViZW4gVHVpa292IDxsdWJlbi50dWlrb3ZAYW1kLmNvbT4NCj4gLS0tDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgfCA3ICsrKysrKysNCj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYyB8IDIgKy0NCj4gICAyIGZpbGVz
IGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYw0KPiBpbmRleCA2ZTFiMjViZDFmZTcuLmRlZGQ3ZTFh
YjJmYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8w
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMNCj4gQEAg
LTM0Niw2ICszNDYsMTMgQEAgc3RhdGljIHVpbnQ2NF90IGdtY192MTBfMF9lbWl0X2ZsdXNoX2dw
dV90bGIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLA0KPiAgIA0KPiAgIAlhbWRncHVfcmluZ19l
bWl0X3dyZWcocmluZywgaHViLT52bV9pbnZfZW5nMF9yZXEgKyBlbmcsIHJlcSk7DQo+ICAgDQo+
ICsJLyogSW5zZXJ0IGEgZHVtbXkgcmVhZCB0byBkZWxheSBvbmUgY3ljbGUgYWZ0ZXIgdGhlIHdy
aXRlIFJFUSwNCj4gKwkgKiBhbmQgYmVmb3JlIHRoZSBBQ0sgaW5xdWlyeS4NCj4gKwkgKi8NCj4g
KwlpZiAocmluZy0+ZnVuY3MtPnR5cGUgPT0gQU1ER1BVX1JJTkdfVFlQRV9TRE1BKQ0KPiArCQlh
bWRncHVfcmluZ19lbWl0X3JlZ193YWl0KHJpbmcsDQo+ICsJCQkJCSAgaHViLT52bV9pbnZfZW5n
MF9yZXEgKyBlbmcsIDAsIDApOw0KPiArDQo+ICAgCS8qIHdhaXQgZm9yIHRoZSBpbnZhbGlkYXRl
IHRvIGNvbXBsZXRlICovDQo+ICAgCWFtZGdwdV9yaW5nX2VtaXRfcmVnX3dhaXQocmluZywgaHVi
LT52bV9pbnZfZW5nMF9hY2sgKyBlbmcsDQo+ICAgCQkJCSAgMSA8PCB2bWlkLCAxIDw8IHZtaWQp
Ow0KDQpMb29rcyBsaWtlIHdlIGluZGVlZCBkb2Vzbid0IHVzZSB0aGUgaW50ZWdyYXRlZCB3cml0
ZS93YWl0IENQIGNvbW1hbmQgb24gDQpOYXZpLg0KDQpBbnl3YXkgdGhhdCBpcyBhIGNvbXBsZXRl
bHkgc2VwYXJhdGUgaXNzdWUsIHRoaXMgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IA0KQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFu
Lg0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMC5jDQo+IGluZGV4IGI4ZmRi
MTkyZjZkNi4uMGM0MWI0ZmRjNThiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zZG1hX3Y1XzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9z
ZG1hX3Y1XzAuYw0KPiBAQCAtMTU4OCw3ICsxNTg4LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBh
bWRncHVfcmluZ19mdW5jcyBzZG1hX3Y1XzBfcmluZ19mdW5jcyA9IHsNCj4gICAJCTYgKyAvKiBz
ZG1hX3Y1XzBfcmluZ19lbWl0X3BpcGVsaW5lX3N5bmMgKi8NCj4gICAJCS8qIHNkbWFfdjVfMF9y
aW5nX2VtaXRfdm1fZmx1c2ggKi8NCj4gICAJCVNPQzE1X0ZMVVNIX0dQVV9UTEJfTlVNX1dSRUcg
KiAzICsNCj4gLQkJU09DMTVfRkxVU0hfR1BVX1RMQl9OVU1fUkVHX1dBSVQgKiA2ICsNCj4gKwkJ
U09DMTVfRkxVU0hfR1BVX1RMQl9OVU1fUkVHX1dBSVQgKiA2ICogMiArDQo+ICAgCQkxMCArIDEw
ICsgMTAsIC8qIHNkbWFfdjVfMF9yaW5nX2VtaXRfZmVuY2UgeDMgZm9yIHVzZXIgZmVuY2UsIHZt
IGZlbmNlICovDQo+ICAgCS5lbWl0X2liX3NpemUgPSA3ICsgNiwgLyogc2RtYV92NV8wX3Jpbmdf
ZW1pdF9pYiAqLw0KPiAgIAkuZW1pdF9pYiA9IHNkbWFfdjVfMF9yaW5nX2VtaXRfaWIsDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
