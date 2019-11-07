Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674B0FC6195
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 17:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47E25218AE
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 17:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E25218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16B336F76B;
	Thu,  7 Nov 2019 17:48:04 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820075.outbound.protection.outlook.com [40.107.82.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E132B6F76B
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 17:48:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4FbEB0oZ9i9A/khJ4sneotfyVNlsJbczR3FAEHuo0CtpX90uKAadDSX2KqaQRVQa7tHThF6kK8AX6hkmVHu46a31VXqF/Bvf8fv5jTI25OGj9mnyHJzKRU37t2UD4wtIg5sZ6p1CqwtqKMcx8zWs4pb+Yxp6vopaYgSJ8/VDmvgklwY0mAzSaB6Q4J3sAN6u1Trm02DNz0Fb9dSnMrnGa/t1JmWvrZwr8gADnp5nrMptjQBvpqeASZNNHIkSfIurqEGOeddfx98NbKvQEzbzjeg4uE1Mx/HfnI9C2VJaYDIBcxZbN0iQF2KWvsHLbcP6nrVUADDW4HyRsUOOBzGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siLbj/lnujxe+c8yl9ioSt7N0AF/E0EQ7wNkDNNF6h8=;
 b=J8auFMpsiRkkrxf09szhuVGqo76IGC5PB0Spda3Rx/MkBFNlrRf70Hyvtp1V43tBKM+4gTRHPfA7yIU7jTtC+jRmDSFGbBMiPQJJHcc5IVjrD8mvU6GA89Ms2vbSEgCaSMgW2/nrJH35hMzDDkaRHMgUD+sihgah89zytMYiTkn31e/zcJsV40CAt6hHusuV/rIDrXrWWn6YOc/b5pyPS2jU7A+mEK+uK83LGyYtnjwpBE7dqATugj4d8LJfrc0oGsWl15/jg/5kb6iEPXZ1IobdO4DTi7evhMAXuUnx8H71EUKEaqDrq4WiCIoPzcT5JN4Py5WDQQWGF9ubeslv/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.174.156) by
 DM6PR12MB2732.namprd12.prod.outlook.com (20.176.116.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 17:48:01 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede%4]) with mapi id 15.20.2408.024; Thu, 7 Nov 2019
 17:48:01 +0000
From: "Kuehling, Felix" <Felix.Kuehling@amd.com>
To: "Zhao, Yong" <Yong.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Simplify the mmap offset related bit
 operations
Thread-Topic: [PATCH] drm/amdkfd: Simplify the mmap offset related bit
 operations
Thread-Index: AQHVlZGAfmrIt3RmZEW8tSKMosYzE6d/+9mA
Date: Thu, 7 Nov 2019 17:48:01 +0000
Message-ID: <2bec1af9-92e6-09f0-89e8-6d0f04993195@amd.com>
References: <20191107173330.20703-1-Yong.Zhao@amd.com>
In-Reply-To: <20191107173330.20703-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [142.116.193.252]
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-clientproxiedby: YT1PR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::32)
 To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:1cb::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0437ec4f-241a-4f15-c92c-08d763aaa236
x-ms-traffictypediagnostic: DM6PR12MB2732:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB273289D2F7BD05861CAB8C9592780@DM6PR12MB2732.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(189003)(199004)(486006)(52116002)(386003)(66556008)(26005)(8936002)(65956001)(66476007)(65806001)(66066001)(102836004)(36756003)(71190400001)(71200400001)(446003)(8676002)(6512007)(7736002)(53546011)(478600001)(81156014)(305945005)(476003)(2616005)(81166006)(6436002)(6486002)(2501003)(5660300002)(110136005)(99286004)(229853002)(11346002)(186003)(58126008)(86362001)(256004)(6506007)(31696002)(6246003)(66946007)(2906002)(316002)(31686004)(25786009)(76176011)(64756008)(3846002)(66446008)(14454004)(6116002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2732;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N1BWBtbSBBSigzRmSabdXBhc4fEZ4G/VJ82Sf0qD3WrLEBlZBzt0sa+yrLX3jwKEZfPHr252USNaDCwvJ5el8D+n9Sn5/8KR5Of+fGQfjAWSqXxaRYNccEZ25I0UZrBOIygcVu2n3ffp8NKhntfcrS1UbaGywD8Y8rvlQL+sRPb0TShRpbPgt2KSzPVDga35NE8VthMkDbmHXoqdniT/0lONzUri0dW4NndSCHtokm1ifwSjQB3J3AHVVHWxs28a/8iyjmJe0/48HWKWkLystb8VUTvr4HWMw8R2l2CsHSbUrlGWTYz6eCrCs7BIfs5y4IxaXdmnD2jBw6CHlpq7I7qaxxsSjb1tbUWuVR7HeC9yJjzvLT66sJhTeDL3Gy+5+lOAQEsUyY89pvJ43cYNbL+f29vvU5mrEGhxsR26TvJ54VGA4ywUyHvtf99vU9ip
Content-ID: <4B564DCF796BBB44A2E267E658E7DDB4@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0437ec4f-241a-4f15-c92c-08d763aaa236
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 17:48:01.4893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zktbxThZdRtDn2m9FIE31VXqu1c19oBkzSK0yrMj8V9Z6yokMtFZA2GhRdQFUyFAC97jZdf0d/nmO55YSbi9JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2732
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siLbj/lnujxe+c8yl9ioSt7N0AF/E0EQ7wNkDNNF6h8=;
 b=r9lZFJhhqms23bDQ96406u94lvArtMvCe4lb4eekgfrxULDHcRBrpXqT+bCvTgiyo3p2ZNlI12GiFDKvcU16an7ptLOzFc2jPFg07IzAEBwOoTznB/wR0duE3ShiagdShncofTgGOc/d4alCALJKQvDpetK82g4ETxDGxNUc0xc=
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
Message-ID: <20191107174801.1bO7r7Gki12-Uu8IG1jZd3GmA4NWS_fYplwrubfUliE@z>

T24gMjAxOS0xMS0wNyAxMjozMywgWmhhbywgWW9uZyB3cm90ZToNCj4gVGhlIG5ldyBjb2RlIHVz
ZXMgc3RyYWlnaHRmb3J3YXJkIGJpdCBzaGlmdHMgYW5kIHRodXMgaGFzIGJldHRlciByZWFkYWJp
bGl0eS4NCj4NCj4gQ2hhbmdlLUlkOiBJMGMxZjdjY2E3ZTI0ZGRiN2I0ZmZlMWNiMGZhNzE5NDM4
MjhhZTM3Mw0KPiBTaWduZWQtb2ZmLWJ5OiBZb25nIFpoYW8gPFlvbmcuWmhhb0BhbWQuY29tPg0K
DQpSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQoN
Cg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jIHwg
MTcgKysrKysrKy0tLS0tLS0tLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
ZXZlbnRzLmMgIHwgIDEgLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2
LmggICAgfCAgOSArKystLS0tLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
cHJvY2Vzcy5jIHwgIDMgKy0tDQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCsp
LCAxOSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9jaGFyZGV2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hh
cmRldi5jDQo+IGluZGV4IGI5MTk5Mzc1M2I4Mi4uZTU5YzIyOTg2MWU2IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMNCj4gQEAgLTI5OCw3ICsyOTgsNiBA
QCBzdGF0aWMgaW50IGtmZF9pb2N0bF9jcmVhdGVfcXVldWUoc3RydWN0IGZpbGUgKmZpbGVwLCBz
dHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAsDQo+ICAgCS8qIFJldHVybiBncHVfaWQgYXMgZG9vcmJlbGwg
b2Zmc2V0IGZvciBtbWFwIHVzYWdlICovDQo+ICAgCWFyZ3MtPmRvb3JiZWxsX29mZnNldCA9IEtG
RF9NTUFQX1RZUEVfRE9PUkJFTEw7DQo+ICAgCWFyZ3MtPmRvb3JiZWxsX29mZnNldCB8PSBLRkRf
TU1BUF9HUFVfSUQoYXJncy0+Z3B1X2lkKTsNCj4gLQlhcmdzLT5kb29yYmVsbF9vZmZzZXQgPDw9
IFBBR0VfU0hJRlQ7DQo+ICAgCWlmIChLRkRfSVNfU09DMTUoZGV2LT5kZXZpY2VfaW5mby0+YXNp
Y19mYW1pbHkpKQ0KPiAgIAkJLyogT24gU09DMTUgQVNJQ3MsIGluY2x1ZGUgdGhlIGRvb3JiZWxs
IG9mZnNldCB3aXRoaW4gdGhlDQo+ICAgCQkgKiBwcm9jZXNzIGRvb3JiZWxsIGZyYW1lLCB3aGlj
aCBjb3VsZCBiZSAxIHBhZ2Ugb3IgMiBwYWdlcy4NCj4gQEAgLTEzMTIsMTAgKzEzMTEsOSBAQCBz
dGF0aWMgaW50IGtmZF9pb2N0bF9hbGxvY19tZW1vcnlfb2ZfZ3B1KHN0cnVjdCBmaWxlICpmaWxl
cCwNCj4gICAJLyogTU1JTyBpcyBtYXBwZWQgdGhyb3VnaCBrZmQgZGV2aWNlDQo+ICAgCSAqIEdl
bmVyYXRlIGEga2ZkIG1tYXAgb2Zmc2V0DQo+ICAgCSAqLw0KPiAtCWlmIChmbGFncyAmIEtGRF9J
T0NfQUxMT0NfTUVNX0ZMQUdTX01NSU9fUkVNQVApIHsNCj4gLQkJYXJncy0+bW1hcF9vZmZzZXQg
PSBLRkRfTU1BUF9UWVBFX01NSU8gfCBLRkRfTU1BUF9HUFVfSUQoYXJncy0+Z3B1X2lkKTsNCj4g
LQkJYXJncy0+bW1hcF9vZmZzZXQgPDw9IFBBR0VfU0hJRlQ7DQo+IC0JfQ0KPiArCWlmIChmbGFn
cyAmIEtGRF9JT0NfQUxMT0NfTUVNX0ZMQUdTX01NSU9fUkVNQVApDQo+ICsJCWFyZ3MtPm1tYXBf
b2Zmc2V0ID0gS0ZEX01NQVBfVFlQRV9NTUlPDQo+ICsJCQkJCXwgS0ZEX01NQVBfR1BVX0lEKGFy
Z3MtPmdwdV9pZCk7DQo+ICAgDQo+ICAgCXJldHVybiAwOw0KPiAgIA0KPiBAQCAtMTkzOCwyMCAr
MTkzNiwxOSBAQCBzdGF0aWMgaW50IGtmZF9tbWFwKHN0cnVjdCBmaWxlICpmaWxwLCBzdHJ1Y3Qg
dm1fYXJlYV9zdHJ1Y3QgKnZtYSkNCj4gICB7DQo+ICAgCXN0cnVjdCBrZmRfcHJvY2VzcyAqcHJv
Y2VzczsNCj4gICAJc3RydWN0IGtmZF9kZXYgKmRldiA9IE5VTEw7DQo+IC0JdW5zaWduZWQgbG9u
ZyB2bV9wZ29mZjsNCj4gKwl1bnNpZ25lZCBsb25nIG1tYXBfb2Zmc2V0Ow0KPiAgIAl1bnNpZ25l
ZCBpbnQgZ3B1X2lkOw0KPiAgIA0KPiAgIAlwcm9jZXNzID0ga2ZkX2dldF9wcm9jZXNzKGN1cnJl
bnQpOw0KPiAgIAlpZiAoSVNfRVJSKHByb2Nlc3MpKQ0KPiAgIAkJcmV0dXJuIFBUUl9FUlIocHJv
Y2Vzcyk7DQo+ICAgDQo+IC0Jdm1fcGdvZmYgPSB2bWEtPnZtX3Bnb2ZmOw0KPiAtCXZtYS0+dm1f
cGdvZmYgPSBLRkRfTU1BUF9PRkZTRVRfVkFMVUVfR0VUKHZtX3Bnb2ZmKTsNCj4gLQlncHVfaWQg
PSBLRkRfTU1BUF9HUFVfSURfR0VUKHZtX3Bnb2ZmKTsNCj4gKwltbWFwX29mZnNldCA9IHZtYS0+
dm1fcGdvZmYgPDwgUEFHRV9TSElGVDsNCj4gKwlncHVfaWQgPSBLRkRfTU1BUF9HRVRfR1BVX0lE
KG1tYXBfb2Zmc2V0KTsNCj4gICAJaWYgKGdwdV9pZCkNCj4gICAJCWRldiA9IGtmZF9kZXZpY2Vf
YnlfaWQoZ3B1X2lkKTsNCj4gICANCj4gLQlzd2l0Y2ggKHZtX3Bnb2ZmICYgS0ZEX01NQVBfVFlQ
RV9NQVNLKSB7DQo+ICsJc3dpdGNoIChtbWFwX29mZnNldCAmIEtGRF9NTUFQX1RZUEVfTUFTSykg
ew0KPiAgIAljYXNlIEtGRF9NTUFQX1RZUEVfRE9PUkJFTEw6DQo+ICAgCQlpZiAoIWRldikNCj4g
ICAJCQlyZXR1cm4gLUVOT0RFVjsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9ldmVudHMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9ldmVu
dHMuYw0KPiBpbmRleCA5MDgwODFjODVkZTEuLjFmODM2NTU3NWIxMiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2V2ZW50cy5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9ldmVudHMuYw0KPiBAQCAtMzQ2LDcgKzM0Niw2IEBAIGlu
dCBrZmRfZXZlbnRfY3JlYXRlKHN0cnVjdCBmaWxlICpkZXZrZmQsIHN0cnVjdCBrZmRfcHJvY2Vz
cyAqcCwNCj4gICAJCXJldCA9IGNyZWF0ZV9zaWduYWxfZXZlbnQoZGV2a2ZkLCBwLCBldik7DQo+
ICAgCQlpZiAoIXJldCkgew0KPiAgIAkJCSpldmVudF9wYWdlX29mZnNldCA9IEtGRF9NTUFQX1RZ
UEVfRVZFTlRTOw0KPiAtCQkJKmV2ZW50X3BhZ2Vfb2Zmc2V0IDw8PSBQQUdFX1NISUZUOw0KPiAg
IAkJCSpldmVudF9zbG90X2luZGV4ID0gZXYtPmV2ZW50X2lkOw0KPiAgIAkJfQ0KPiAgIAkJYnJl
YWs7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5o
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaA0KPiBpbmRleCA2NmJhZThm
MmRhZDEuLjhlZWNkMmNkMWZkMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3ByaXYuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
cHJpdi5oDQo+IEBAIC01OSwyNCArNTksMjEgQEANCj4gICAgKiBOT1RFOiBzdHJ1Y3Qgdm1fYXJl
YV9zdHJ1Y3Qudm1fcGdvZmYgdXNlcyBvZmZzZXQgaW4gcGFnZXMuIEhlbmNlLCB0aGVzZQ0KPiAg
ICAqICBkZWZpbmVzIGFyZSB3LnIudCB0byBQQUdFX1NJWkUNCj4gICAgKi8NCj4gLSNkZWZpbmUg
S0ZEX01NQVBfVFlQRV9TSElGVAkoNjIgLSBQQUdFX1NISUZUKQ0KPiArI2RlZmluZSBLRkRfTU1B
UF9UWVBFX1NISUZUCSg2MikNCj4gICAjZGVmaW5lIEtGRF9NTUFQX1RZUEVfTUFTSwkoMHgzVUxM
IDw8IEtGRF9NTUFQX1RZUEVfU0hJRlQpDQo+ICAgI2RlZmluZSBLRkRfTU1BUF9UWVBFX0RPT1JC
RUxMCSgweDNVTEwgPDwgS0ZEX01NQVBfVFlQRV9TSElGVCkNCj4gICAjZGVmaW5lIEtGRF9NTUFQ
X1RZUEVfRVZFTlRTCSgweDJVTEwgPDwgS0ZEX01NQVBfVFlQRV9TSElGVCkNCj4gICAjZGVmaW5l
IEtGRF9NTUFQX1RZUEVfUkVTRVJWRURfTUVNCSgweDFVTEwgPDwgS0ZEX01NQVBfVFlQRV9TSElG
VCkNCj4gICAjZGVmaW5lIEtGRF9NTUFQX1RZUEVfTU1JTwkoMHgwVUxMIDw8IEtGRF9NTUFQX1RZ
UEVfU0hJRlQpDQo+ICAgDQo+IC0jZGVmaW5lIEtGRF9NTUFQX0dQVV9JRF9TSElGVCAoNDYgLSBQ
QUdFX1NISUZUKQ0KPiArI2RlZmluZSBLRkRfTU1BUF9HUFVfSURfU0hJRlQgKDQ2KQ0KPiAgICNk
ZWZpbmUgS0ZEX01NQVBfR1BVX0lEX01BU0sgKCgoMVVMTCA8PCBLRkRfR1BVX0lEX0hBU0hfV0lE
VEgpIC0gMSkgXA0KPiAgIAkJCQk8PCBLRkRfTU1BUF9HUFVfSURfU0hJRlQpDQo+ICAgI2RlZmlu
ZSBLRkRfTU1BUF9HUFVfSUQoZ3B1X2lkKSAoKCgodWludDY0X3QpZ3B1X2lkKSA8PCBLRkRfTU1B
UF9HUFVfSURfU0hJRlQpXA0KPiAgIAkJCQkmIEtGRF9NTUFQX0dQVV9JRF9NQVNLKQ0KPiAtI2Rl
ZmluZSBLRkRfTU1BUF9HUFVfSURfR0VUKG9mZnNldCkgICAgKChvZmZzZXQgJiBLRkRfTU1BUF9H
UFVfSURfTUFTSykgXA0KPiArI2RlZmluZSBLRkRfTU1BUF9HRVRfR1BVX0lEKG9mZnNldCkgICAg
KChvZmZzZXQgJiBLRkRfTU1BUF9HUFVfSURfTUFTSykgXA0KPiAgIAkJCQk+PiBLRkRfTU1BUF9H
UFVfSURfU0hJRlQpDQo+ICAgDQo+IC0jZGVmaW5lIEtGRF9NTUFQX09GRlNFVF9WQUxVRV9NQVNL
CSgweDNGRkZGRkZGRkZGRlVMTCA+PiBQQUdFX1NISUZUKQ0KPiAtI2RlZmluZSBLRkRfTU1BUF9P
RkZTRVRfVkFMVUVfR0VUKG9mZnNldCkgKG9mZnNldCAmIEtGRF9NTUFQX09GRlNFVF9WQUxVRV9N
QVNLKQ0KPiAtDQo+ICAgLyoNCj4gICAgKiBXaGVuIHdvcmtpbmcgd2l0aCBjcCBzY2hlZHVsZXIg
d2Ugc2hvdWxkIGFzc2lnbiB0aGUgSElRIG1hbnVhbGx5IG9yIHZpYQ0KPiAgICAqIHRoZSBhbWRn
cHUgZHJpdmVyIHRvIGEgZml4ZWQgaHFkIHNsb3QsIGhlcmUgYXJlIHRoZSBmaXhlZCBISVEgaHFk
IHNsb3QNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9j
ZXNzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQo+IGluZGV4
IDZhYmZiNzdhZTU0MC4uMzlkYzQ5YjhmZDg1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9wcm9jZXNzLmMNCj4gQEAgLTU1NCw4ICs1NTQsNyBAQCBzdGF0aWMgaW50IGtm
ZF9wcm9jZXNzX2luaXRfY3dzcl9hcHUoc3RydWN0IGtmZF9wcm9jZXNzICpwLCBzdHJ1Y3QgZmls
ZSAqZmlsZXApDQo+ICAgCQlpZiAoIWRldi0+Y3dzcl9lbmFibGVkIHx8IHFwZC0+Y3dzcl9rYWRk
ciB8fCBxcGQtPmN3c3JfYmFzZSkNCj4gICAJCQljb250aW51ZTsNCj4gICANCj4gLQkJb2Zmc2V0
ID0gKEtGRF9NTUFQX1RZUEVfUkVTRVJWRURfTUVNIHwgS0ZEX01NQVBfR1BVX0lEKGRldi0+aWQp
KQ0KPiAtCQkJPDwgUEFHRV9TSElGVDsNCj4gKwkJb2Zmc2V0ID0gS0ZEX01NQVBfVFlQRV9SRVNF
UlZFRF9NRU0gfCBLRkRfTU1BUF9HUFVfSUQoZGV2LT5pZCk7DQo+ICAgCQlxcGQtPnRiYV9hZGRy
ID0gKGludDY0X3Qpdm1fbW1hcChmaWxlcCwgMCwNCj4gICAJCQlLRkRfQ1dTUl9UQkFfVE1BX1NJ
WkUsIFBST1RfUkVBRCB8IFBST1RfRVhFQywNCj4gICAJCQlNQVBfU0hBUkVELCBvZmZzZXQpOw0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
