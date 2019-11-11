Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8449EC43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 09:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CCC820674
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 09:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CCC820674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28DA989E1B;
	Mon, 11 Nov 2019 09:28:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770051.outbound.protection.outlook.com [40.107.77.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 832EC89E1B
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 09:28:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIz5umQC3d7oyY7Ddrx5b67dILrsLlCLl2DS0UApYxtufUEOet4wi6i6RFLEQhKKNT79hCxNJJrEOPqJQeI949NNjkwW4irBuWv7atj3YOXI3ykC+A4PG0bJYmq1dX0C34bPm4gvlW5gXFtwEs4hJ4yckyBvK75w4UykiQrd4vLjoPYfGO2CTyprTyk1adwgtWXUNAToG1c4pPTJ+V2EsjLgU6Qzqf6uMT1hyBCOVU/4q1vZ7zoubB4eRx96GZYtyyrEboTGtXswqK70C79aBIfJemqSIHxqC9Xpbyv1fyV9LFjP1UZffOiWYHIXlPXnJTKy6RuRvD/yrK1wJnm2Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqfWCm5xJji9txDB6NKrhuvmuChS+lD+4GN0zIlGwH8=;
 b=ZBHuXwwi0dnKfmWdpE6e3uEsjzEX9vO08+8lgfLcJy9rkjgCFtYwKGqPcficE/9+RqqEUCS2T5jijgqSxHq+NI2/oSxHlteuBSURHrq8WkjiE9qxWUneX14hmP5tYWGQRGWrQfalulzlogSrNxm9XZpUpZSI7kMzV1ounkqPnakyITVZkTV8vFaIDwrUidXsduQ6v88G2UkFtmXi7lzPzXj2x1/rLakj2/dg+XBrFHTnCA2ilx59X+nbf6pIC/6P2FKXXRQIb8/T4aDkZC9vLOiKMFizBIFD6ZecF2PsjROaZAKUjNlx06jFp1B9Cohtxgigr8U3KbczToz0AwBAtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB2928.namprd12.prod.outlook.com (20.179.83.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Mon, 11 Nov 2019 09:28:29 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2430.023; Mon, 11 Nov 2019
 09:28:29 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Matt Coffin <mcoffin13@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: do proper cleanups on hw_fini
Thread-Topic: [PATCH] drm/amd/powerplay: do proper cleanups on hw_fini
Thread-Index: AQHVYgnVJlYcNsHbwkaZ7rqoIq5RdqeCKB0AgAP4VLA=
Date: Mon, 11 Nov 2019 09:28:29 +0000
Message-ID:
 <MN2PR12MB3344AE3F4B75313B425FAB9EE4740@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20190903034336.16005-1-evan.quan@amd.com>
 <50104e7b-e38f-6750-7aae-dfef399790f3@gmail.com>
In-Reply-To: <50104e7b-e38f-6750-7aae-dfef399790f3@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b89e8f4-a294-4b4c-91a3-08d76689836c
x-ms-traffictypediagnostic: MN2PR12MB2928:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB292872D8D50BB40855DA22DAE4740@MN2PR12MB2928.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:106;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(51874003)(13464003)(199004)(189003)(186003)(2906002)(81156014)(33656002)(81166006)(8936002)(74316002)(316002)(486006)(25786009)(305945005)(966005)(7736002)(76176011)(6246003)(110136005)(7696005)(26005)(66066001)(54906003)(8676002)(6506007)(53546011)(14454004)(5660300002)(102836004)(2501003)(99286004)(6116002)(71190400001)(71200400001)(229853002)(446003)(66556008)(11346002)(66946007)(14444005)(66476007)(66446008)(64756008)(3846002)(478600001)(52536014)(4326008)(6306002)(86362001)(76116006)(9686003)(256004)(55016002)(6436002)(476003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2928;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nYnuUnMZC1AmSn3qDLtZIS5R3edyRuG9vVeiDWIWTDCCK4FqdZIBek2Je4w+uvAp4aRQxONRdDHOYErJqXYz8UmaKv6Q6sdBYsJwPWhDUAXmGJsBLbXOwdIxfn1/QRwQxXcj0Z/8Abjm4UM6DWpqy8pp/cOgiCfWHy8fjf3+m/AZmR+DhNL2r89o1LfZ4bcfqTLodDxNEMqdxKPGo28JX26s9uR8n6pDT4oxKlMgE5nUZhVU/LllIUZQQBIU3SXG7e7jpdXMwPaWTCgUqLxRdQXVh7foBRDHBgygAdJCSX16Pw85tMSNLUl/Q7mj5MnqPGK1r7Hp56PsaLMYCtC7fuECBMxpKOlMyRzbJFN4uHaYIFdGZjnHhMneV+UAr5p0n3+T97st7rnsBQXr4RicbZYod9jT3hb6TF0O0oQ69sJtiOJ9pqGu40QlOuEVTosDMhQmpbQ9plzvAyljTXth4D8n2g7BXipgzNctWC+bT8gp/m2tC3moCGyjNgHU557kp2xiKnCv1uFEZdCmATv91mLVs09hwXr6oZKIOKmWCiwJLAWsWzNzCjExA0M+US1o
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b89e8f4-a294-4b4c-91a3-08d76689836c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 09:28:29.6738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XwFZblfGFSa/7IVhOj2Jdqga88juJQdFmE1z5yG94ePuxye2j5RPd4u0hQyJ3Wi6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2928
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqfWCm5xJji9txDB6NKrhuvmuChS+lD+4GN0zIlGwH8=;
 b=U6tugWdz7UjbmkMA7lQGhTg5LMr4RVwqRrdvAkoloDbAkF6GF3Kub7YkJKCIOYA9e5r5Ie233pls4+a2dhgOSqm/2KtMV71Y2l4PaSzBdM2iupIvqp3asFrz1NcfvBEVZVPNU1Ealg5z7JEqg27sSi7SucXgEuCCIIHTBUu8LKk=
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
Cc: Alex Deucher <alexdeucher@gmail.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Gui, Jack" <Jack.Gui@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111092829.zA7xIRnmZw-i87k0Rg60ZRgP7TP5qrIQcxqu7aFkl8Y@z>

SnVzdCBzZW50IG91dCBhIHBhdGNoIHdoaWNoIHNob3VsZCBiZSBhYmxlIHRvIGFkZHJlc3MgdGhp
cyBpc3N1ZS4NCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL2FyY2hpdmVzL2FtZC1nZngv
MjAxOS1Ob3ZlbWJlci8wNDI0NTguaHRtbA0KDQpSZWdhcmRzLA0KRXZhbg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXR0IENvZmZpbiA8bWNvZmZpbjEzQGdtYWlsLmNv
bT4NCj4gU2VudDogU2F0dXJkYXksIE5vdmVtYmVyIDksIDIwMTkgNDo1MCBBTQ0KPiBUbzogUXVh
biwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KPiBDYzogTGksIENhbmRpY2UgPENhbmRpY2UuTGlAYW1kLmNvbT47IEd1aSwgSmFjayA8SmFj
ay5HdWlAYW1kLmNvbT47IEFsZXgNCj4gRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL3Bvd2VycGxheTogZG8gcHJvcGVyIGNsZWFu
dXBzIG9uIGh3X2ZpbmkNCj4gDQo+IEhleSBndXlzLA0KPiANCj4gDQo+IA0KPiBUaGlzIHBhdGNo
IGNhdXNlZCBzb21lIGtpbmQgb2YgcmV2ZXJzaW9uIHdpdGggc211X3Jlc2V0IG9uIE5hdmkxMC4g
SSdtIG5vDQo+IGV4cGVydCBzaW5jZSBldmVyeXRoaW5nIEkga25vdyBjb21lcyBmcm9tIGp1c3Qg
cmVhZGluZyB0aHJvdWdoIHRoZSBjb2RlLCBzbw0KPiB0aGlzIGNvdWxkIGJlIHNvbWUga2luZCBv
ZiBpbnRlbmRlZCBiZWhhdmlvciwgYnV0IGFmdGVyIHRoaXMgcGF0Y2gsIGlmIHlvdSB3cml0ZSBh
DQo+IHBwdGFibGUgdG8gdGhlIHN5c2ZzIHBwX3RhYmxlIGludGVyZmFjZSBvbiBuYXZpMTAsIHRo
ZW4gdGhlIFNNVSB3aWxsIGZhaWwgdG8gcmVzZXQNCj4gc3VjY2Vzc2Z1bGx5LCBhbmQgdGhlIHJl
c3VsdCBpcyBzZWVtaW5nbHkgYW4gdW5yZWNvdmVyYWJsZSBzaXR1YXRpb24uDQo+IA0KPiANCj4g
DQo+IEkgcHV0IGluIGEgcmVwb3J0IG9uIGJ1Z3ppbGxhIHdpdGggZG1lc2cgbG9ncw0KPiA6DQo+
IGh0dHBzOi8vYnVncy5mcmVlZGVza3RvcC5vcmcvc2hvd19idWcuY2dpP2lkPTExMjIzNA0KPiAN
Cj4gDQo+IEZpbmRpbmcgdGhpcyBjaGFuZ2Ugd2FzIHRoZSByZXN1bHQgb2YgYSBiaXNlY3QgdG8g
ZmluZCB3aGVyZSB0aGUgaXNzdWUgc3RhcnRlZCwNCj4gYW5kIHJldmVydGluZyB0aGUgY2hhbmdl
cyB0byBzbXVfaHdfZmluaSByZXNvbHZlZCB0aGUgaXNzdWUuDQo+IEFueSBhZHZpY2Ugb24gcG9z
c2libGUgcHJvcGVyIGZpeGVzPw0KPiANCj4gVGhhbmtzIGluIGFkdmFuY2UsDQo+IA0KPiBNYXR0
DQo+IA0KPiBPbiA5LzIvMTkgOTo0NCBQTSwgUXVhbiwgRXZhbiB3cm90ZToNCj4gPiBUaGVzZSBh
cmUgbmVlZGVkIGZvciBzbXVfcmVzZXQgc3VwcG9ydC4NCj4gPg0KPiA+IENoYW5nZS1JZDogSWYy
OWVkZTRiOTk3NThhZGIwOGZkNGUxNjY2NWY0NGZkODkzZWM5OWINCj4gPiBTaWduZWQtb2ZmLWJ5
OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMgICAgIHwgMTcNCj4gKysrKysrKysrKysr
KysrKysNCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2FtZGdwdV9zbXUu
aCB8ICAzICsrKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAu
YyAgICAgIHwgMTAgKysrKysrKysrKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlv
bnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9hbWRncHVfc211LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdw
dV9zbXUuYw0KPiA+IGluZGV4IGQ1ZWUxM2E3OGViNy4uM2NmOGQ5NDRmODkwIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYw0KPiA+IEBAIC0x
Mjg2LDYgKzEyODYsMTEgQEAgc3RhdGljIGludCBzbXVfaHdfaW5pdCh2b2lkICpoYW5kbGUpDQo+
ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBzbXVfc3RvcF9k
cG1zKHN0cnVjdCBzbXVfY29udGV4dCAqc211KSB7DQo+ID4gKwlyZXR1cm4gc211X3NlbmRfc21j
X21zZyhzbXUsIFNNVV9NU0dfRGlzYWJsZUFsbFNtdUZlYXR1cmVzKTsgfQ0KPiA+ICsNCj4gPiAg
c3RhdGljIGludCBzbXVfaHdfZmluaSh2b2lkICpoYW5kbGUpDQo+ID4gIHsNCj4gPiAgCXN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOyBA
QA0KPiA+IC0xMjk4LDYgKzEzMDMsMTggQEAgc3RhdGljIGludCBzbXVfaHdfZmluaSh2b2lkICpo
YW5kbGUpDQo+ID4gIAkJc211X3Bvd2VyZ2F0ZV92Y24oJmFkZXYtPnNtdSwgdHJ1ZSk7DQo+ID4g
IAl9DQo+ID4NCj4gPiArCXJldCA9IHNtdV9zdG9wX3RoZXJtYWxfY29udHJvbChzbXUpOw0KPiA+
ICsJaWYgKHJldCkgew0KPiA+ICsJCXByX3dhcm4oIkZhaWwgdG8gc3RvcCB0aGVybWFsIGNvbnRy
b2whXG4iKTsNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldCA9
IHNtdV9zdG9wX2RwbXMoc211KTsNCj4gPiArCWlmIChyZXQpIHsNCj4gPiArCQlwcl93YXJuKCJG
YWlsIHRvIHN0b3AgRHBtcyFcbiIpOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKwl9DQo+ID4g
Kw0KPiA+ICAJa2ZyZWUodGFibGVfY29udGV4dC0+ZHJpdmVyX3BwdGFibGUpOw0KPiA+ICAJdGFi
bGVfY29udGV4dC0+ZHJpdmVyX3BwdGFibGUgPSBOVUxMOw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9hbWRncHVfc211LmgNCj4gPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9hbWRncHVfc211LmgNCj4gPiBpbmRleCBi
MTkyMjRjYjZkNmQuLjhlNGIwYWQyNDcxMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9pbmMvYW1kZ3B1X3NtdS5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2FtZGdwdV9zbXUuaA0KPiA+IEBAIC00OTgsNiArNDk4LDcg
QEAgc3RydWN0IHNtdV9mdW5jcw0KPiA+ICAJaW50ICgqZ2V0X2N1cnJlbnRfY2xrX2ZyZXEpKHN0
cnVjdCBzbXVfY29udGV4dCAqc211LCBlbnVtDQo+IHNtdV9jbGtfdHlwZSBjbGtfaWQsIHVpbnQz
Ml90ICp2YWx1ZSk7DQo+ID4gIAlpbnQgKCppbml0X21heF9zdXN0YWluYWJsZV9jbG9ja3MpKHN0
cnVjdCBzbXVfY29udGV4dCAqc211KTsNCj4gPiAgCWludCAoKnN0YXJ0X3RoZXJtYWxfY29udHJv
bCkoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpOw0KPiA+ICsJaW50ICgqc3RvcF90aGVybWFsX2Nv
bnRyb2wpKHN0cnVjdCBzbXVfY29udGV4dCAqc211KTsNCj4gPiAgCWludCAoKnJlYWRfc2Vuc29y
KShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwgZW51bSBhbWRfcHBfc2Vuc29ycw0KPiBzZW5zb3Is
DQo+ID4gIAkJCSAgIHZvaWQgKmRhdGEsIHVpbnQzMl90ICpzaXplKTsNCj4gPiAgCWludCAoKnNl
dF9kZWVwX3NsZWVwX2RjZWZjbGspKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCB1aW50MzJfdA0K
PiA+IGNsayk7IEBAIC02NDcsNiArNjQ4LDggQEAgc3RydWN0IHNtdV9mdW5jcw0KPiA+ICAJKChz
bXUpLT5wcHRfZnVuY3MtPnNldF90aGVybWFsX2Zhbl90YWJsZSA/DQo+ID4gKHNtdSktPnBwdF9m
dW5jcy0+c2V0X3RoZXJtYWxfZmFuX3RhYmxlKChzbXUpKSA6IDApICAjZGVmaW5lDQo+IHNtdV9z
dGFydF90aGVybWFsX2NvbnRyb2woc211KSBcDQo+ID4gIAkoKHNtdSktPmZ1bmNzLT5zdGFydF90
aGVybWFsX2NvbnRyb2w/DQo+ID4gKHNtdSktPmZ1bmNzLT5zdGFydF90aGVybWFsX2NvbnRyb2wo
KHNtdSkpIDogMCkNCj4gPiArI2RlZmluZSBzbXVfc3RvcF90aGVybWFsX2NvbnRyb2woc211KSBc
DQo+ID4gKwkoKHNtdSktPmZ1bmNzLT5zdG9wX3RoZXJtYWxfY29udHJvbD8NCj4gPiArKHNtdSkt
PmZ1bmNzLT5zdG9wX3RoZXJtYWxfY29udHJvbCgoc211KSkgOiAwKQ0KPiA+ICAjZGVmaW5lIHNt
dV9yZWFkX3NlbnNvcihzbXUsIHNlbnNvciwgZGF0YSwgc2l6ZSkgXA0KPiA+ICAJKChzbXUpLT5w
cHRfZnVuY3MtPnJlYWRfc2Vuc29yPyAoc211KS0+cHB0X2Z1bmNzLQ0KPiA+cmVhZF9zZW5zb3Io
KHNtdSksDQo+ID4gKHNlbnNvciksIChkYXRhKSwgKHNpemUpKSA6IDApICAjZGVmaW5lIHNtdV9z
bWNfcmVhZF9zZW5zb3Ioc211LA0KPiA+IHNlbnNvciwgZGF0YSwgc2l6ZSkgXCBkaWZmIC0tZ2l0
DQo+ID4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYw0KPiA+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMNCj4gPiBpbmRleCBkYjVl
OTRjZTU0YWYuLjFhMzhhZjg0Mzk0ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L3NtdV92MTFfMC5jDQo+ID4gQEAgLTEyMDksNiArMTIwOSwxNSBAQCBzdGF0aWMg
aW50DQo+IHNtdV92MTFfMF9zdGFydF90aGVybWFsX2NvbnRyb2woc3RydWN0IHNtdV9jb250ZXh0
ICpzbXUpDQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBz
bXVfdjExXzBfc3RvcF90aGVybWFsX2NvbnRyb2woc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpIHsN
Cj4gPiArCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gc211LT5hZGV2Ow0KPiA+ICsNCj4g
PiArCVdSRUczMl9TT0MxNShUSE0sIDAsIG1tVEhNX1RIRVJNQUxfSU5UX0VOQSwgMCk7DQo+ID4g
Kw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyB1aW50MTZfdCBj
b252ZXJ0X3RvX3ZkZGModWludDhfdCB2aWQpICB7DQo+ID4gIAlyZXR1cm4gKHVpbnQxNl90KSAo
KDYyMDAgLSAodmlkICogMjUpKSAvIFNNVTExX1ZPTFRBR0VfU0NBTEUpOyBAQA0KPiA+IC0xNzgz
LDYgKzE3OTIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNtdV9mdW5jcyBzbXVfdjExXzBfZnVu
Y3MgPSB7DQo+ID4gIAkuZ2V0X2N1cnJlbnRfY2xrX2ZyZXEgPSBzbXVfdjExXzBfZ2V0X2N1cnJl
bnRfY2xrX2ZyZXEsDQo+ID4gIAkuaW5pdF9tYXhfc3VzdGFpbmFibGVfY2xvY2tzID0NCj4gc211
X3YxMV8wX2luaXRfbWF4X3N1c3RhaW5hYmxlX2Nsb2NrcywNCj4gPiAgCS5zdGFydF90aGVybWFs
X2NvbnRyb2wgPSBzbXVfdjExXzBfc3RhcnRfdGhlcm1hbF9jb250cm9sLA0KPiA+ICsJLnN0b3Bf
dGhlcm1hbF9jb250cm9sID0gc211X3YxMV8wX3N0b3BfdGhlcm1hbF9jb250cm9sLA0KPiA+ICAJ
LnJlYWRfc2Vuc29yID0gc211X3YxMV8wX3JlYWRfc2Vuc29yLA0KPiA+ICAJLnNldF9kZWVwX3Ns
ZWVwX2RjZWZjbGsgPSBzbXVfdjExXzBfc2V0X2RlZXBfc2xlZXBfZGNlZmNsaywNCj4gPiAgCS5k
aXNwbGF5X2Nsb2NrX3ZvbHRhZ2VfcmVxdWVzdCA9DQo+ID4gc211X3YxMV8wX2Rpc3BsYXlfY2xv
Y2tfdm9sdGFnZV9yZXF1ZXN0LA0KPiA+DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
