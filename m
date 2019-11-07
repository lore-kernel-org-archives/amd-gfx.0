Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E67BC5DF60
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 05:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6322166E
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 05:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6322166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67C316EE85;
	Thu,  7 Nov 2019 05:05:48 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720062.outbound.protection.outlook.com [40.107.72.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A4F6E0E1
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 05:05:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHUk12Q3QvC/Y0wwJ7IL7vR7YdUeo9TtUmfQqA/9Wb8L07LUWOSgIxxhFeSIoxuWBqrCieAThKitKvtuMCXT0UmmAOjMU/41TJNc2pFqz/X0MWdAMC6BU7XyRP8vKVX8Aw52s2Js88x5iylJ5k0hdoUYUGuqa6KuRq00B+l5+pUAErJ3ptVhV7Jk/dX3efKT5Ym9LurjD4PZvS05+5B+6VNaDNbgdkcNldIF3SuP/zQMMAjzuGY6Is8Hcl42zsef9jgSqbGwF7d/7DTrmBqC+8GSmvquLMp4v67vnikJKeZBm7w/j61qflT8IJYsAHg8cgRpeyV2xG/mgFr4/tNz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6ndZqOpLqViv+tHeY8Qw9uA6P4n+rbkeuuNDBDeobM=;
 b=ZvSS4bhnHErT15fLhTmWQOzGP4kmv30KChZRR9PDnytDANVUhNiEUHz1llQOH1CskvTke9zUmNdoLBaLcqD0W9eV4pBoGviQ2QEWXC9RJb+tCWPYqw3LbD4CZPgp2DqMfQWw/c6xnd3qlnGdPB0JZACc+Vjiqz6/yoX2qcMNfv597YLqyN1ZSWKtm4kAj/Q2oFpbfk5N7qBaStT+NSL4KrKvQA6LPNJMbBTU4JOfWZFDYrg3rIPdDhcflFO/zaCGMmg6MBoKheaQiEPrriVVcaOx87WBWCmAE6ssIVoIragIi9O7WSdSl/yiq5D1nfFQhNx57HbSpTTjdTGnRJHU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.174.156) by
 DM6PR12MB3659.namprd12.prod.outlook.com (10.255.76.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Thu, 7 Nov 2019 05:05:44 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede%4]) with mapi id 15.20.2408.024; Thu, 7 Nov 2019
 05:05:44 +0000
From: "Kuehling, Felix" <Felix.Kuehling@amd.com>
To: "Zhao, Yong" <Yong.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Simplify the mmap offset related bit
 operations
Thread-Topic: [PATCH] drm/amdkfd: Simplify the mmap offset related bit
 operations
Thread-Index: AQHVlC9KsVca0NKFMUCOBwbcLRM7OKd/KaMA
Date: Thu, 7 Nov 2019 05:05:43 +0000
Message-ID: <38503488-c676-9e61-3e09-c27b1dd18e26@amd.com>
References: <20191105231759.19850-1-Yong.Zhao@amd.com>
In-Reply-To: <20191105231759.19850-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.54.211]
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-clientproxiedby: YTBPR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::14) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:1cb::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d558bcc6-a420-470c-ad85-08d763402491
x-ms-traffictypediagnostic: DM6PR12MB3659:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB36591B978269C893F8A4A41092780@DM6PR12MB3659.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(66476007)(386003)(102836004)(6116002)(7736002)(53546011)(6506007)(3846002)(66946007)(66556008)(5660300002)(66446008)(64756008)(446003)(11346002)(476003)(486006)(2616005)(26005)(186003)(76176011)(52116002)(2501003)(2906002)(6436002)(71190400001)(71200400001)(99286004)(31686004)(14454004)(6512007)(6486002)(66066001)(65806001)(478600001)(65956001)(316002)(25786009)(256004)(8936002)(305945005)(6246003)(36756003)(110136005)(58126008)(31696002)(229853002)(8676002)(81156014)(81166006)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3659;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8mHcUz8u8oRE2/CNshwpg9Ro0fPgu9CAVBLr7vrUfCfDO8xU4fIMa6LrsLjbA9KdxLGR64QWyUUQ8Xjfo52y+mwvxnuKU1WCwtJeuep+hH/yQeNzDM5NY9mVMEZH7LLP0U7aFfaamcrgeM8Rv1RHaJBBbF4KIl0NiV8pxSobzukS+HkIeXSCcPXW4KROd45bZHe67gMtdPpE6hJF2OYJFARM28C3fTEpICEXGs6d6oyUNoVfbB3dtCK9Ss9mtDk5cOOFJsQ6bktuL7dj/klFMDPvGB8sRAyHI8Wm70/SZzYD1yfs5Vc2HUHxL9zcuzEEW4KQ3DQOpvEGqNdhNB2D4pOmGIcyz5bZAvSHaiki/1BdsT6uDyzXUXzLFF7AmR3o2zvYWNDjp9nnYm46JACixyz1orcTF9mNM+f+cIJVLYCeGw/BVc12NhBM0BSZiteX
Content-ID: <C9C70E7E3F705445A97DFAAF053A5B09@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d558bcc6-a420-470c-ad85-08d763402491
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 05:05:43.9977 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZE6tFwBzneIjFc1kciWa7Sz9UZWcMcwah082usePaEIhnSJ3Lw5wSlo90yxKLEE6FfbKW17+ucmLmZ0+Mdhow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3659
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6ndZqOpLqViv+tHeY8Qw9uA6P4n+rbkeuuNDBDeobM=;
 b=lL3W1fYfprJUDu/zW1kakw3+lZxDBUA6laKaxrjE4ClcqkcnVEKhl5yUNuIzonRd86XUcaF+BtoSndPsKLyV9HayNvTA2bkr6jSiyU/NDmgHA3msQbaF+5wSLrAIQSZ8/e1CMSDuVqJNcrnXTl6qe07ejYbhGtJniur/MEN7cGE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
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
Message-ID: <20191107050543.pAfBf2jSxRC2OgAOkPbUPwdbBS6ZulK8QW-Xi_xiMyI@z>

T24gMjAxOS0xMS0wNSAxODoxOCwgWmhhbywgWW9uZyB3cm90ZToNCj4gVGhlIG5ldyBjb2RlIHVz
ZXMgc3RyYWlnaHRmb3J3YXJkIGJpdCBzaGlmdHMgYW5kIHRodXMgaGFzIGJldHRlciANCj4gcmVh
ZGFiaWxpdHkuDQoNCllvdSdyZSBtaXNzaW5nIHRoZSBNTUFQLXJlbGF0ZWQgY29kZSBmb3IgbW1p
byByZW1hcHBpbmcuIEluIA0Ka2ZkX2lvY3RsX2FsbG9jX21lbW9yeV9vZl9ncHU6DQoNCiDCoMKg
wqDCoMKgwqDCoCAvKiBNTUlPIGlzIG1hcHBlZCB0aHJvdWdoIGtmZCBkZXZpY2UNCiDCoMKgwqDC
oMKgwqDCoMKgICogR2VuZXJhdGUgYSBrZmQgbW1hcCBvZmZzZXQNCiDCoMKgwqDCoMKgwqDCoMKg
ICovDQogwqDCoMKgwqDCoMKgwqAgaWYgKGZsYWdzICYgS0ZEX0lPQ19BTExPQ19NRU1fRkxBR1Nf
TU1JT19SRU1BUCkgew0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhcmdzLT5tbWFw
X29mZnNldCA9IEtGRF9NTUFQX1RZUEVfTU1JTyB8IA0KS0ZEX01NQVBfR1BVX0lEKGFyZ3MtPmdw
dV9pZCk7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFyZ3MtPm1tYXBfb2Zmc2V0
IDw8PSBQQUdFX1NISUZUOw0KIMKgwqDCoMKgwqDCoMKgIH0NCg0KUmVnYXJkcywNCiDCoCBGZWxp
eA0KDQo+DQo+IENoYW5nZS1JZDogSTBjMWY3Y2NhN2UyNGRkYjdiNGZmZTFjYjBmYTcxOTQzODI4
YWUzNzMNCj4gU2lnbmVkLW9mZi1ieTogWW9uZyBaaGFvIDxZb25nLlpoYW9AYW1kLmNvbT4NCj4g
LS0tDQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMgfCAxMCArKysr
LS0tLS0tDQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9ldmVudHMuYyB8IDEgLQ0K
PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oIHwgOSArKystLS0tLS0NCj4g
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYyB8IDMgKy0tDQo+IDQgZmls
ZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMgDQo+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYw0KPiBpbmRleCBiOTE5OTM3NTNi
ODIuLjM0MDc4ZGYzNjYyMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX2NoYXJkZXYuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
Y2hhcmRldi5jDQo+IEBAIC0yOTgsNyArMjk4LDYgQEAgc3RhdGljIGludCBrZmRfaW9jdGxfY3Jl
YXRlX3F1ZXVlKHN0cnVjdCBmaWxlIA0KPiAqZmlsZXAsIHN0cnVjdCBrZmRfcHJvY2VzcyAqcCwN
Cj4gLyogUmV0dXJuIGdwdV9pZCBhcyBkb29yYmVsbCBvZmZzZXQgZm9yIG1tYXAgdXNhZ2UgKi8N
Cj4gYXJncy0+ZG9vcmJlbGxfb2Zmc2V0ID0gS0ZEX01NQVBfVFlQRV9ET09SQkVMTDsNCj4gYXJn
cy0+ZG9vcmJlbGxfb2Zmc2V0IHw9IEtGRF9NTUFQX0dQVV9JRChhcmdzLT5ncHVfaWQpOw0KPiAt
IGFyZ3MtPmRvb3JiZWxsX29mZnNldCA8PD0gUEFHRV9TSElGVDsNCj4gaWYgKEtGRF9JU19TT0Mx
NShkZXYtPmRldmljZV9pbmZvLT5hc2ljX2ZhbWlseSkpDQo+IC8qIE9uIFNPQzE1IEFTSUNzLCBp
bmNsdWRlIHRoZSBkb29yYmVsbCBvZmZzZXQgd2l0aGluIHRoZQ0KPiAqIHByb2Nlc3MgZG9vcmJl
bGwgZnJhbWUsIHdoaWNoIGNvdWxkIGJlIDEgcGFnZSBvciAyIHBhZ2VzLg0KPiBAQCAtMTkzOCwy
MCArMTkzNywxOSBAQCBzdGF0aWMgaW50IGtmZF9tbWFwKHN0cnVjdCBmaWxlICpmaWxwLCBzdHJ1
Y3QgDQo+IHZtX2FyZWFfc3RydWN0ICp2bWEpDQo+IHsNCj4gc3RydWN0IGtmZF9wcm9jZXNzICpw
cm9jZXNzOw0KPiBzdHJ1Y3Qga2ZkX2RldiAqZGV2ID0gTlVMTDsNCj4gLSB1bnNpZ25lZCBsb25n
IHZtX3Bnb2ZmOw0KPiArIHVuc2lnbmVkIGxvbmcgbW1hcF9vZmZzZXQ7DQo+IHVuc2lnbmVkIGlu
dCBncHVfaWQ7DQo+IHByb2Nlc3MgPSBrZmRfZ2V0X3Byb2Nlc3MoY3VycmVudCk7DQo+IGlmIChJ
U19FUlIocHJvY2VzcykpDQo+IHJldHVybiBQVFJfRVJSKHByb2Nlc3MpOw0KPiAtIHZtX3Bnb2Zm
ID0gdm1hLT52bV9wZ29mZjsNCj4gLSB2bWEtPnZtX3Bnb2ZmID0gS0ZEX01NQVBfT0ZGU0VUX1ZB
TFVFX0dFVCh2bV9wZ29mZik7DQo+IC0gZ3B1X2lkID0gS0ZEX01NQVBfR1BVX0lEX0dFVCh2bV9w
Z29mZik7DQo+ICsgbW1hcF9vZmZzZXQgPSB2bWEtPnZtX3Bnb2ZmIDw8IFBBR0VfU0hJRlQ7DQo+
ICsgZ3B1X2lkID0gS0ZEX01NQVBfR0VUX0dQVV9JRChtbWFwX29mZnNldCk7DQo+IGlmIChncHVf
aWQpDQo+IGRldiA9IGtmZF9kZXZpY2VfYnlfaWQoZ3B1X2lkKTsNCj4gLSBzd2l0Y2ggKHZtX3Bn
b2ZmICYgS0ZEX01NQVBfVFlQRV9NQVNLKSB7DQo+ICsgc3dpdGNoIChtbWFwX29mZnNldCAmIEtG
RF9NTUFQX1RZUEVfTUFTSykgew0KPiBjYXNlIEtGRF9NTUFQX1RZUEVfRE9PUkJFTEw6DQo+IGlm
ICghZGV2KQ0KPiByZXR1cm4gLUVOT0RFVjsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9ldmVudHMuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfZXZlbnRzLmMNCj4gaW5kZXggOTA4MDgxYzg1ZGUxLi4xZjgzNjU1NzViMTIgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9ldmVudHMuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZXZlbnRzLmMNCj4gQEAgLTM0Niw3ICsz
NDYsNiBAQCBpbnQga2ZkX2V2ZW50X2NyZWF0ZShzdHJ1Y3QgZmlsZSAqZGV2a2ZkLCBzdHJ1Y3Qg
DQo+IGtmZF9wcm9jZXNzICpwLA0KPiByZXQgPSBjcmVhdGVfc2lnbmFsX2V2ZW50KGRldmtmZCwg
cCwgZXYpOw0KPiBpZiAoIXJldCkgew0KPiAqZXZlbnRfcGFnZV9vZmZzZXQgPSBLRkRfTU1BUF9U
WVBFX0VWRU5UUzsNCj4gLSAqZXZlbnRfcGFnZV9vZmZzZXQgPDw9IFBBR0VfU0hJRlQ7DQo+ICpl
dmVudF9zbG90X2luZGV4ID0gZXYtPmV2ZW50X2lkOw0KPiB9DQo+IGJyZWFrOw0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaCANCj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oDQo+IGluZGV4IDY2YmFlOGYyZGFkMS4uOGVl
Y2QyY2QxZmQyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
cHJpdi5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgNCj4g
QEAgLTU5LDI0ICs1OSwyMSBAQA0KPiAqIE5PVEU6IHN0cnVjdCB2bV9hcmVhX3N0cnVjdC52bV9w
Z29mZiB1c2VzIG9mZnNldCBpbiBwYWdlcy4gSGVuY2UsIHRoZXNlDQo+ICogZGVmaW5lcyBhcmUg
dy5yLnQgdG8gUEFHRV9TSVpFDQo+ICovDQo+IC0jZGVmaW5lIEtGRF9NTUFQX1RZUEVfU0hJRlQg
KDYyIC0gUEFHRV9TSElGVCkNCj4gKyNkZWZpbmUgS0ZEX01NQVBfVFlQRV9TSElGVCAoNjIpDQo+
ICNkZWZpbmUgS0ZEX01NQVBfVFlQRV9NQVNLICgweDNVTEwgPDwgS0ZEX01NQVBfVFlQRV9TSElG
VCkNCj4gI2RlZmluZSBLRkRfTU1BUF9UWVBFX0RPT1JCRUxMICgweDNVTEwgPDwgS0ZEX01NQVBf
VFlQRV9TSElGVCkNCj4gI2RlZmluZSBLRkRfTU1BUF9UWVBFX0VWRU5UUyAoMHgyVUxMIDw8IEtG
RF9NTUFQX1RZUEVfU0hJRlQpDQo+ICNkZWZpbmUgS0ZEX01NQVBfVFlQRV9SRVNFUlZFRF9NRU0g
KDB4MVVMTCA8PCBLRkRfTU1BUF9UWVBFX1NISUZUKQ0KPiAjZGVmaW5lIEtGRF9NTUFQX1RZUEVf
TU1JTyAoMHgwVUxMIDw8IEtGRF9NTUFQX1RZUEVfU0hJRlQpDQo+IC0jZGVmaW5lIEtGRF9NTUFQ
X0dQVV9JRF9TSElGVCAoNDYgLSBQQUdFX1NISUZUKQ0KPiArI2RlZmluZSBLRkRfTU1BUF9HUFVf
SURfU0hJRlQgKDQ2KQ0KPiAjZGVmaW5lIEtGRF9NTUFQX0dQVV9JRF9NQVNLICgoKDFVTEwgPDwg
S0ZEX0dQVV9JRF9IQVNIX1dJRFRIKSAtIDEpIFwNCj4gPDwgS0ZEX01NQVBfR1BVX0lEX1NISUZU
KQ0KPiAjZGVmaW5lIEtGRF9NTUFQX0dQVV9JRChncHVfaWQpICgoKCh1aW50NjRfdClncHVfaWQp
IDw8IA0KPiBLRkRfTU1BUF9HUFVfSURfU0hJRlQpXA0KPiAmIEtGRF9NTUFQX0dQVV9JRF9NQVNL
KQ0KPiAtI2RlZmluZSBLRkRfTU1BUF9HUFVfSURfR0VUKG9mZnNldCkgKChvZmZzZXQgJiBLRkRf
TU1BUF9HUFVfSURfTUFTSykgXA0KPiArI2RlZmluZSBLRkRfTU1BUF9HRVRfR1BVX0lEKG9mZnNl
dCkgKChvZmZzZXQgJiBLRkRfTU1BUF9HUFVfSURfTUFTSykgXA0KPiA+PiBLRkRfTU1BUF9HUFVf
SURfU0hJRlQpDQo+IC0jZGVmaW5lIEtGRF9NTUFQX09GRlNFVF9WQUxVRV9NQVNLICgweDNGRkZG
RkZGRkZGRlVMTCA+PiBQQUdFX1NISUZUKQ0KPiAtI2RlZmluZSBLRkRfTU1BUF9PRkZTRVRfVkFM
VUVfR0VUKG9mZnNldCkgKG9mZnNldCAmIA0KPiBLRkRfTU1BUF9PRkZTRVRfVkFMVUVfTUFTSykN
Cj4gLQ0KPiAvKg0KPiAqIFdoZW4gd29ya2luZyB3aXRoIGNwIHNjaGVkdWxlciB3ZSBzaG91bGQg
YXNzaWduIHRoZSBISVEgbWFudWFsbHkgb3IgdmlhDQo+ICogdGhlIGFtZGdwdSBkcml2ZXIgdG8g
YSBmaXhlZCBocWQgc2xvdCwgaGVyZSBhcmUgdGhlIGZpeGVkIEhJUSBocWQgc2xvdA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYyANCj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQo+IGluZGV4IDZhYmZiNzdh
ZTU0MC4uMzlkYzQ5YjhmZDg1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfcHJvY2Vzcy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9wcm9jZXNzLmMNCj4gQEAgLTU1NCw4ICs1NTQsNyBAQCBzdGF0aWMgaW50IGtmZF9wcm9jZXNz
X2luaXRfY3dzcl9hcHUoc3RydWN0IA0KPiBrZmRfcHJvY2VzcyAqcCwgc3RydWN0IGZpbGUgKmZp
bGVwKQ0KPiBpZiAoIWRldi0+Y3dzcl9lbmFibGVkIHx8IHFwZC0+Y3dzcl9rYWRkciB8fCBxcGQt
PmN3c3JfYmFzZSkNCj4gY29udGludWU7DQo+IC0gb2Zmc2V0ID0gKEtGRF9NTUFQX1RZUEVfUkVT
RVJWRURfTUVNIHwgS0ZEX01NQVBfR1BVX0lEKGRldi0+aWQpKQ0KPiAtIDw8IFBBR0VfU0hJRlQ7
DQo+ICsgb2Zmc2V0ID0gS0ZEX01NQVBfVFlQRV9SRVNFUlZFRF9NRU0gfCBLRkRfTU1BUF9HUFVf
SUQoZGV2LT5pZCk7DQo+IHFwZC0+dGJhX2FkZHIgPSAoaW50NjRfdCl2bV9tbWFwKGZpbGVwLCAw
LA0KPiBLRkRfQ1dTUl9UQkFfVE1BX1NJWkUsIFBST1RfUkVBRCB8IFBST1RfRVhFQywNCj4gTUFQ
X1NIQVJFRCwgb2Zmc2V0KTsNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
