Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4CBC43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 04:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F214A20818
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 04:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F214A20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91CFF6E150;
	Mon, 11 Nov 2019 04:16:23 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740054.outbound.protection.outlook.com [40.107.74.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C4AC6E150
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 04:16:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2oaoQ3e6kN1+jhz+cdS8VcfgmXaf5+hzjyTrRT7DuxSkcxSz6jMAXMUQ/l1Ve+0DqZ3fcO+DCaD8+vdA5B9wnDWhjoSTESvMaDYvt3kMqHu08qO17JUI7AThkiun7ANQVgabgvZZhT4kbo2pGNJ+BEjJp9VQWShL4bzOeuWQCaWEBPh9DSTej9AZqmbIOPJ7+2zrzWhDN+eGdMMrRWJbOvsf3dxpr8c2rHcU9CW6Fh69uCOAEUyR+w/fR1VR7eoN2wDxaBesCIZ8yBEak2aD49DXSTWf18x19cEPio3ilbThS0mQQ88A85HaTURMsTzOLDIF+47AQB1uw/4itkhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQlmHX127Noz7uT1SLw3MVTAKngxEXId1diIXesLpZw=;
 b=J03CqaYgbZPWmSUneoodMImtilFgdZFr8j7abWmPcjuo7g0+ESfeEPthrec91ITXVJ4YZmtytmjC7TQCtuPcOHvER8SYxIJcB7KqxC55iePEW+YVasl8B9qa+JXDM4eHFO/oi/sWU1mw/cXvywXlqJHgAQItCRKg1Ha/0f2qLVpYOkUb8Czn25uEkwv901cv55mgKdbBxn+b4QJzEqB9lL3+mU1xpb0JaovTH8nHT2g2aUVRxqZAj3VX2wnm0YvicZPLZMvPmdoRyh2LUbrCrfDg/Wg3ikMlP7ruUc5AmhzwZKn8z8K1FUPVA08nrEh/Ynl9IFqCh8hGQB66Dt1kKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3407.namprd12.prod.outlook.com (20.178.241.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Mon, 11 Nov 2019 04:16:18 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2430.023; Mon, 11 Nov 2019
 04:16:18 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Matt Coffin <mcoffin13@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 0/3] navi10: Implement overdrive pp_od_clk_voltage
Thread-Topic: [PATCH v2 0/3] navi10: Implement overdrive pp_od_clk_voltage
Thread-Index: AQHVlntvJajr7fYPg0O56A0egeKGq6eFYG5w
Date: Mon, 11 Nov 2019 04:16:18 +0000
Message-ID:
 <MN2PR12MB334499252729037F67A09F89E4740@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <cover.1573248368.git.mcoffin13@gmail.com>
In-Reply-To: <cover.1573248368.git.mcoffin13@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7795c572-c450-4f45-c06f-08d7665de693
x-ms-traffictypediagnostic: MN2PR12MB3407:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3407CF77A103F80889DA6AFEE4740@MN2PR12MB3407.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(199004)(189003)(13464003)(9686003)(186003)(26005)(110136005)(55016002)(316002)(4326008)(7736002)(76116006)(66446008)(64756008)(66476007)(66556008)(66946007)(305945005)(74316002)(11346002)(446003)(476003)(2501003)(486006)(3846002)(6116002)(71190400001)(6246003)(71200400001)(66066001)(14454004)(478600001)(25786009)(7696005)(76176011)(6436002)(256004)(6506007)(102836004)(53546011)(2906002)(8676002)(81156014)(8936002)(81166006)(229853002)(5660300002)(99286004)(86362001)(33656002)(52536014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3407;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: faKb+7hleGntILcnti/cnvLQ317oJfzk8y149M4Z0Moz90WYLqYbgbJAXmobAtqXUvAeb5OkGKQ7udp6hjtwa8sq/d+6WOwQwiRLJWrqZ3ALgINlrqgsag5vtFAtFYXQZ0xxeAylvl3+0R67iJVkV3+QpBet0cgB5wDgcjLsujBq6+NsxA2WrGguDCyxzR0l8dcbKmU8GyNDQyC8M+6XIFqg7q9Fqk17apDj+gVdn7a0zLPymLAE/ha6uH1yhGy93zOpnTWR4BNx9rt3e1lhkwHOEbjjeaILI5YM04rfVjHH5s6UaGrfPZxtueA+XRUYHmisT1fWn5PiH82UTCk36BJJ4qE2OrZrTXJAnhK+KxpnTQVVRG4RYALvILRb+hu0Jsabux1538OyF3uQ/V40bAWgmvACRscJq9DXWUZrUBJIN8gGqrD9RTtrOXWGZpIO
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7795c572-c450-4f45-c06f-08d7665de693
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 04:16:18.0889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ydyqJZ5n8fuDXHYgckZtHUcRA/28GTuX/ELavsDzHxYYeIO7aLm4FvM4kX60D97H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3407
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQlmHX127Noz7uT1SLw3MVTAKngxEXId1diIXesLpZw=;
 b=PaNXS5tWjuozNskgBk548L5VFBbBvsCbnLnb8R3NajdDI6WunuJfoTGuRoprcyCA1yS/b/K7Zti8Z9h9aYiebMBT3SNtKLZNmewTIDVuOTtEOZDXBL+cCsnevxpR4iv1Z3E3qCC/ln1BaNWpQSUQ+OLj0fZ8QPcVRdk7prrsvQQ=
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
Message-ID: <20191111041618.op85-8-3HDhKmHa2crbP_iZh9rUxdRBreXTASw1uPOY@z>

U2VyaWVzIGlzIHJldmlld2VkLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgoKPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IE1hdHQgQ29mZmluIDxtY29mZmluMTNA
Z21haWwuY29tPgo+IFNlbnQ6IFNhdHVyZGF5LCBOb3ZlbWJlciA5LCAyMDE5IDU6MjggQU0KPiBU
bzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBh
bWQuY29tPgo+IENjOiBNYXR0IENvZmZpbiA8bWNvZmZpbjEzQGdtYWlsLmNvbT47IERldWNoZXIs
IEFsZXhhbmRlcgo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPgo+IFN1YmplY3Q6IFtQQVRD
SCB2MiAwLzNdIG5hdmkxMDogSW1wbGVtZW50IG92ZXJkcml2ZSBwcF9vZF9jbGtfdm9sdGFnZQo+
IAo+IFtXaHldCj4gQmVmb3JlIHRoaXMgcGF0Y2hzZXQsIG5hdmkxMCB1c2VycyBjb3VsZCBub3Qg
dXRpbGl6ZSB0aGUgb3ZlcmRyaXZlIGZ1bmN0aW9uYWxpdHkuCj4gVGhpcyBwcmV2ZW50ZWQgdGhl
bSBmcm9tIG92ZXJjbG9ja2luZywgb3ZlcnZvbHRpbmcsIG9yIHVuZGVydm9sdGluZyB0aGVpciBj
YXJkcy4KPiAKPiBbSG93XQo+IFNpbWlsYXIgdG8gdGhlIHZlZ2EyMCBpbXBsZW1lbnRhdGlvbiwg
YWRkIHRoZSBwcF9vZF9jbGtfdm9sdGFnZSBpbnRlcmZhY2UgdG8KPiB0aGUgbmF2aTEwIHBvd2Vy
cGxheSB0YWJsZS4KPiAKPiBbUG9zc2libGUgQWx0ZXJuYXRpdmVzXQo+IFRoaXMgY291bGQgYWxz
byBiZSBkb25lIG1vcmUgZ2VuZXJpY2FsbHkgaW4gc211X3YxMV8wIGNvZGUsIGJ1dCB3b3VsZCBy
ZXF1aXJlCj4gbW9yZSBzaWduaWZpY2FudCBjaGFuZ2VzIHRvIHRoZSB2ZWdhMjAgY29kZSwgYW5k
IGZlYXR1cmUtZ2F0aW5nIGJhc2VkIG9uIGNoaXAKPiBjYXBhYmlsaXRpZXMgaW4gdGhlIHNtdSB0
byBkaXNhYmxlIG92ZXJkcml2ZSBmb3IgYXJjdGVydXMuCj4gSSBjaG9zZSB0aGlzIHBhdGggc28g
YXMgbm90IHRvIGNvbXBsZXRlbHkgcmVmYWN0b3IgdGhlIHZlZ2EyMCBzaWRlIG9mIHRoaW5ncywg
YW5kCj4gaW50cm9kdWNlIFNNVSBjb2RlIHdoaWNoIHdvdWxkIG5vdCBwbGF5IG5pY2VseSB3aXRo
IG5ldyBBU0lDcy4KPiAKPiB2MjogcmViYXNlIG9mZiBsYXRlc3QgY29kZSwgYW5kIHJlbW92ZSBh
biBpbmNvcnJlY3QgYm91bmRzIGNoZWNrCj4gCj4gTWF0dCBDb2ZmaW4gKDMpOgo+ICAgZHJtL2Ft
ZGdwdS9uYXZpMTA6IGltcGxlbWVudCBzY2xrL21jbGsgT0QgdmlhIHBwX29kX2Nsa192b2x0YWdl
Cj4gICBkcm0vYW1kZ3B1L25hdmkxMDogaW1wbGVtZW50IEdGWENMS19DVVJWRSBvdmVyZHJpdmUK
PiAgIGRybS9hbWRncHUvbmF2aTEwOiBJbXBsZW1lbnQgb2QgY2xrIHByaW50aW5nCj4gCj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9zbXVfdjExXzAuaCB8ICAgMiArCj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYyAgICB8IDI4MiArKysrKysr
KysrKysrKysrKysKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEwX3BwdC5o
ICAgIHwgICAyICsKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMg
ICAgIHwgIDI3ICsrCj4gIDQgZmlsZXMgY2hhbmdlZCwgMzEzIGluc2VydGlvbnMoKykKPiAKPiAt
LQo+IDIuMjMuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
