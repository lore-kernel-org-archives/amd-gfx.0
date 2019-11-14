Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CD4C432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 02:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51083206EC
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 02:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51083206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E8E66E116;
	Thu, 14 Nov 2019 02:32:29 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760045.outbound.protection.outlook.com [40.107.76.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C421C6E116
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 02:32:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7NLzd1WDwItnIsZXEiENLGtKYT2N7JWJz+HWnbn/YGvLzERIlXvv8Qm6eWYZeTvbUQOLe2Axb8t9HQQbPpFgjExVCVPc5r14tZnoYVeIeAsh06e8/8Cv0DzhHiaog8kzQUCua1MyMuTx+T7fANmIbq3UMQAXGSGcOqRqXHTFSf/q5WKuV6MweW28XctXJtiDX1tb5CFJQggipdGIKuOHZGla5u50Nlo42wk9TVOQGLmOhsPop43+7wFBxuxBJlAASqZzURwt+D0YWHivD22uxUN0McsV1SwgradRaBipd8c7JHCl/feYMErh2P7kv67z8onchGEPw9+UKqHZQDIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKBRsIUK7lFm7qyqbGdspXvPR6HjauSkHca71jJuFWg=;
 b=N69DOgBNzK6yRM96gkfqHf8CbniSiyfyxBhtwAn7BTQts80St4DMLIYTiRsBBt4uH1XNVy3TPLbJcnqehp9KrmXO2SQqtY4aVoJf2jj/9vqtLOlvXZ2NyqrNE/77qowXDB/ipojJS6sXydW/y+T8XbHrsp++tZY+vbpSH6YK+hwxJYSLvoGGzy0or7YN679FRE2eDA5s4to9vb3iDkxHTDpfo9lZ+hb0xwL1wuVQ9fqZ4QSS9s719jEaDAXbv4LsC2adDL6gzZTD25sW2P+aRwScrHyNh9m524GLU57SIhqeni/EPag5u0o+4vjiKRYrVRGOf1oSx+i7a4zsD+lmjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3742.namprd12.prod.outlook.com (10.255.238.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Thu, 14 Nov 2019 02:32:25 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 02:32:25 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/powerplay: properly set PP_GFXOFF_MASK
Thread-Topic: [PATCH 1/2] drm/amdgpu/powerplay: properly set PP_GFXOFF_MASK
Thread-Index: AQHVmj6v97K63lvwEkythn0pXCBr86eJ8tOQ
Date: Thu, 14 Nov 2019 02:32:25 +0000
Message-ID:
 <MN2PR12MB33448D3EBFE632D2518C383FE4710@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191113162314.520605-1-alexander.deucher@amd.com>
In-Reply-To: <20191113162314.520605-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 578fe48b-9afd-452f-bf06-08d768aae2e2
x-ms-traffictypediagnostic: MN2PR12MB3742:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB37423408E2A50C7A77192366E4710@MN2PR12MB3742.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(136003)(39850400004)(346002)(376002)(199004)(189003)(13464003)(81156014)(6436002)(14454004)(74316002)(8936002)(966005)(229853002)(52536014)(478600001)(8676002)(25786009)(5660300002)(7736002)(71190400001)(71200400001)(4326008)(66066001)(76116006)(81166006)(66946007)(7696005)(186003)(102836004)(26005)(53546011)(6506007)(76176011)(256004)(11346002)(486006)(446003)(9686003)(2906002)(476003)(3846002)(6116002)(33656002)(110136005)(99286004)(55016002)(6306002)(316002)(64756008)(2501003)(66476007)(6246003)(66446008)(66556008)(305945005)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3742;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rrGqF7NL3xAHqGejET6oL9lIm25Ma8DWP9P+2BB1UL0DmVVhXQ35ggb2PZFUxhl6VRylcrpoOGeceTK8vOFg2FzJe2HoF8/SNbCpv9c9mxGG0YdyDbqueDMh45dzZ18CA74Py5n24VSjZtKe4fjtanhy/2VERxJrHoUB/HHZiASz5JwBCbpwTL6ucSWfxIHsOVMXz/zL/0hVN4vmNk9wTgEt33/RyleGRjykXJ/K7teoJdH60wFrPmv9OSHc7wjJAlCI4cdD0np1dBh7LnlRKG90ZrdH6sTZ9Wd31Erl71DWA9XkiWQCESznzLCiBHXz9/RYAUu1SjyNvAqAv2Hj6o5ssdQUe4EM3s65ERKzM6yR7MENNQDmk8cLjDAUL48F66/zBI3ZSV+8HpJnjDmyi8tV6Ey2mfeev/JUuYb598dF9fuynxVZ5XouRlR7smWY3CluZEQpEMl4Dq/NPN7EbGRozncPpkJdCMThdbcs9r0=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 578fe48b-9afd-452f-bf06-08d768aae2e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 02:32:25.5325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XoFI/BhoK2PV4CTlPmja6waZ0N4YnbPnxkQSkXLt2HCemt3hj2S9JZUkeBsIwjGP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3742
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKBRsIUK7lFm7qyqbGdspXvPR6HjauSkHca71jJuFWg=;
 b=a823jLSciDFyGOmGBvgbc7iHLXj1GbdZ5gnhDht0+7I7Jn7iIuTBdrs4smbrEs++LVRieg9EljWAYxR93068c0PIBIIXOzYf6hZmdSAARRuZN4oqbR/F9IPr59pltOHdss9WSSNnpay0KYsTdDn2p5tXJCKubgpOrEalSb0ZCQ0=
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191114023225.2YradDCdE6XR4DPn_UYUGgJDpVNgFvnaOB85YD2nFVM@z>

UmV2aWV3ZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXgNCj4gRGV1Y2hlcg0KPiBTZW50OiBU
aHVyc2RheSwgTm92ZW1iZXIgMTQsIDIwMTkgMTI6MjMgQU0NCj4gVG86IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAxLzJdIGRybS9hbWRncHUvcG93ZXJwbGF5
OiBwcm9wZXJseSBzZXQgUFBfR0ZYT0ZGX01BU0sNCj4gDQo+IFNvIHRoYXQgdGhlIHNldHRpbmcg
cmVmbGVjdHMgd2hhdCB0aGUgaHcgc3VwcG9ydHMuIFRoaXMgd2lsbCBiZSB1c2VkIGluIGENCj4g
c3Vic2VxdWVudCBwYXRjaCBzbyBuZWVkcyB0byBiZSBjb3JyZWN0Lg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiAtLS0NCj4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyAgfCAyICsrDQo+IGRy
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL2h3bWdyLmMgfCA3ICsrKysrKysNCj4g
IDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jDQo+IGluZGV4IDU3NDU5YTY1ZWI0NC4uYWQz
OWRiNDlhMjlkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9h
bWRncHVfc211LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1
X3NtdS5jDQo+IEBAIC03MTksNiArNzE5LDcgQEAgc3RhdGljIGludCBzbXVfc2V0X2Z1bmNzKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiANCj4gIAlzd2l0Y2ggKGFkZXYtPmFzaWNfdHlw
ZSkgew0KPiAgCWNhc2UgQ0hJUF9WRUdBMjA6DQo+ICsJCWFkZXYtPnBtLnBwX2ZlYXR1cmUgJj0g
flBQX0dGWE9GRl9NQVNLOw0KPiAgCQl2ZWdhMjBfc2V0X3BwdF9mdW5jcyhzbXUpOw0KPiAgCQli
cmVhazsNCj4gIAljYXNlIENISVBfTkFWSTEwOg0KPiBAQCAtNzI3LDYgKzcyOCw3IEBAIHN0YXRp
YyBpbnQgc211X3NldF9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gIAkJbmF2
aTEwX3NldF9wcHRfZnVuY3Moc211KTsNCj4gIAkJYnJlYWs7DQo+ICAJY2FzZSBDSElQX0FSQ1RV
UlVTOg0KPiArCQlhZGV2LT5wbS5wcF9mZWF0dXJlICY9IH5QUF9HRlhPRkZfTUFTSzsNCj4gIAkJ
YXJjdHVydXNfc2V0X3BwdF9mdW5jcyhzbXUpOw0KPiAgCQkvKiBPRCBpcyBub3Qgc3VwcG9ydGVk
IG9uIEFyY3R1cnVzICovDQo+ICAJCXNtdS0+b2RfZW5hYmxlZCA9ZmFsc2U7DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9od21nci5jDQo+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvaHdtZ3IuYw0KPiBpbmRleCBhMjRiZWFh
NGZiMDEuLjQ0MzYyNWM4M2VjOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvaHdtZ3IvaHdtZ3IuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9od21nci9od21nci5jDQo+IEBAIC04MSw2ICs4MSw4IEBAIHN0YXRpYyB2b2lkIGh3bWdy
X2luaXRfd29ya2xvYWRfcHJvcml0eShzdHJ1Y3QNCj4gcHBfaHdtZ3IgKmh3bWdyKQ0KPiANCj4g
IGludCBod21ncl9lYXJseV9pbml0KHN0cnVjdCBwcF9od21nciAqaHdtZ3IpICB7DQo+ICsJc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBod21nci0+YWRldjsNCj4gKw0KPiAgCWlmICghaHdt
Z3IpDQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiANCj4gQEAgLTk2LDYgKzk4LDcgQEAgaW50IGh3
bWdyX2Vhcmx5X2luaXQoc3RydWN0IHBwX2h3bWdyICpod21ncikNCj4gDQo+ICAJc3dpdGNoICho
d21nci0+Y2hpcF9mYW1pbHkpIHsNCj4gIAljYXNlIEFNREdQVV9GQU1JTFlfQ0k6DQo+ICsJCWFk
ZXYtPnBtLnBwX2ZlYXR1cmUgJj0gflBQX0dGWE9GRl9NQVNLOw0KPiAgCQlod21nci0+c211bWdy
X2Z1bmNzID0gJmNpX3NtdV9mdW5jczsNCj4gIAkJY2lfc2V0X2FzaWNfc3BlY2lhbF9jYXBzKGh3
bWdyKTsNCj4gIAkJaHdtZ3ItPmZlYXR1cmVfbWFzayAmPSB+KFBQX1ZCSV9USU1FX1NVUFBPUlRf
TUFTSyB8DQo+IEBAIC0xMDYsMTIgKzEwOSwxNCBAQCBpbnQgaHdtZ3JfZWFybHlfaW5pdChzdHJ1
Y3QgcHBfaHdtZ3IgKmh3bWdyKQ0KPiAgCQlzbXU3X2luaXRfZnVuY3Rpb25fcG9pbnRlcnMoaHdt
Z3IpOw0KPiAgCQlicmVhazsNCj4gIAljYXNlIEFNREdQVV9GQU1JTFlfQ1o6DQo+ICsJCWFkZXYt
PnBtLnBwX2ZlYXR1cmUgJj0gflBQX0dGWE9GRl9NQVNLOw0KPiAgCQlod21nci0+b2RfZW5hYmxl
ZCA9IGZhbHNlOw0KPiAgCQlod21nci0+c211bWdyX2Z1bmNzID0gJnNtdThfc211X2Z1bmNzOw0K
PiAgCQlod21nci0+ZmVhdHVyZV9tYXNrICY9IH5QUF9HRlhPRkZfTUFTSzsNCj4gIAkJc211OF9p
bml0X2Z1bmN0aW9uX3BvaW50ZXJzKGh3bWdyKTsNCj4gIAkJYnJlYWs7DQo+ICAJY2FzZSBBTURH
UFVfRkFNSUxZX1ZJOg0KPiArCQlhZGV2LT5wbS5wcF9mZWF0dXJlICY9IH5QUF9HRlhPRkZfTUFT
SzsNCj4gIAkJaHdtZ3ItPmZlYXR1cmVfbWFzayAmPSB+UFBfR0ZYT0ZGX01BU0s7DQo+ICAJCXN3
aXRjaCAoaHdtZ3ItPmNoaXBfaWQpIHsNCj4gIAkJY2FzZSBDSElQX1RPUEFaOg0KPiBAQCAtMTUz
LDYgKzE1OCw3IEBAIGludCBod21ncl9lYXJseV9pbml0KHN0cnVjdCBwcF9od21nciAqaHdtZ3Ip
DQo+ICAJY2FzZSBBTURHUFVfRkFNSUxZX0FJOg0KPiAgCQlzd2l0Y2ggKGh3bWdyLT5jaGlwX2lk
KSB7DQo+ICAJCWNhc2UgQ0hJUF9WRUdBMTA6DQo+ICsJCQlhZGV2LT5wbS5wcF9mZWF0dXJlICY9
IH5QUF9HRlhPRkZfTUFTSzsNCj4gIAkJCWh3bWdyLT5mZWF0dXJlX21hc2sgJj0gflBQX0dGWE9G
Rl9NQVNLOw0KPiAgCQkJaHdtZ3ItPnNtdW1ncl9mdW5jcyA9ICZ2ZWdhMTBfc211X2Z1bmNzOw0K
PiAgCQkJdmVnYTEwX2h3bWdyX2luaXQoaHdtZ3IpOw0KPiBAQCAtMTYyLDYgKzE2OCw3IEBAIGlu
dCBod21ncl9lYXJseV9pbml0KHN0cnVjdCBwcF9od21nciAqaHdtZ3IpDQo+ICAJCQl2ZWdhMTJf
aHdtZ3JfaW5pdChod21ncik7DQo+ICAJCQlicmVhazsNCj4gIAkJY2FzZSBDSElQX1ZFR0EyMDoN
Cj4gKwkJCWFkZXYtPnBtLnBwX2ZlYXR1cmUgJj0gflBQX0dGWE9GRl9NQVNLOw0KPiAgCQkJaHdt
Z3ItPmZlYXR1cmVfbWFzayAmPSB+UFBfR0ZYT0ZGX01BU0s7DQo+ICAJCQlod21nci0+c211bWdy
X2Z1bmNzID0gJnZlZ2EyMF9zbXVfZnVuY3M7DQo+ICAJCQl2ZWdhMjBfaHdtZ3JfaW5pdChod21n
cik7DQo+IC0tDQo+IDIuMjMuMA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18NCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
