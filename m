Return-Path: <SRS0=opbO=4I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EA1C11D05
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 15:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97357207FD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 15:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ru/9z6vh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97357207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BD926EDAD;
	Thu, 20 Feb 2020 15:24:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37FF86EDAD
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2020 15:24:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asBoFHaNi8VeXKukWXo2OXxn5MDcy0+brI0nyZxCQxoPHuBFM+8yDqhx+Ks6a25jOK9lPuHPhslKfGr3xjzAdLilBRGwHGVDKG7g6mO/rna7gE/kaOyBa8Z0gZeVoXNp6R4gvDj1hRl3ZdZAIV3COjopUSNCEh9BLgG1VOvT1wzbbTo3UtvI1vcQvUvltuuiNNP20GaUcMubvfioo27I1krP4i13ScrLQq8rwAtgQ2urXEU2wexYWHql0A8P7jNBmy/iR1VsTEBRinn9ATrFGZ6P8fuYJnKJKxBB5W9jbtWic4E3993KHr0nbgZ1Tn5OLtXjm+dSmHCdG7oliqqK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x37TtjJCY4r267y0Z/7AXujCoOlXBSP9Nz48H2cc/68=;
 b=CK2/5LaVcmjvd0cbmuMsapMUyjBWADCfw9rTGQu6LvlwV4mB1Zf8ycpf8OBkazswz268ckhtmZ2vfJvyhppFHGEiwmwC6J1/mpazAOK8tsIgXsc5pSka7yZxu9OOHU3GspTrIKwEObzAXncNkQovJzBEpkjUULh9DgEZdV01wkDepcML9r1AaP5rIn8DJpTUuTyYCGDk4P1rN+he7hBsQYGyBXha/c/61ptxrp9s7rTHv0r92KERXGu5StG2BR6FN1WqxO1RLDsbUmIHWZbEkWKrUt7bFVGVU8EHvoPdW92thWEAsBEE6Gu+0GgNpx9Tj0nMZ+CN28vhnx+D/tDFDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x37TtjJCY4r267y0Z/7AXujCoOlXBSP9Nz48H2cc/68=;
 b=Ru/9z6vhQvSXaDJvveGx9HihMgG5k4/Ly81er4UHFFxXIcIDT+fELsY577Ab3khC674/cWgwrGRPWhSo5ROogWLYBl+qh4R3y33h9Cj2nCEObx5VvLiHLxf88OkJYNktmqnUiwF47uC3P6a5ltYkT0FHJ4C6VYRfrN3u29uEVgs=
Received: from DM6PR12MB3931.namprd12.prod.outlook.com (10.255.174.140) by
 DM6PR12MB4338.namprd12.prod.outlook.com (20.180.252.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 20 Feb 2020 15:24:27 +0000
Received: from DM6PR12MB3931.namprd12.prod.outlook.com
 ([fe80::c51d:4e6b:f0f1:b7a3]) by DM6PR12MB3931.namprd12.prod.outlook.com
 ([fe80::c51d:4e6b:f0f1:b7a3%7]) with mapi id 15.20.2729.032; Thu, 20 Feb 2020
 15:24:27 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IGEgYnVn?=
 =?utf-8?Q?_NULL_pointer_dereference?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGRybS9hbWRncHU6IGZpeCBhIGJ1ZyBOVUxMIHBv?=
 =?utf-8?Q?inter_dereference?=
Thread-Index: AQHV5tpejmUZxmzr8E+/dIkRGLqWv6giDTkAgABJr4CAAArysIABY3CAgABGJdCAAAqScIAAHXiAgAABfwCAAADTwA==
Date: Thu, 20 Feb 2020 15:24:27 +0000
Message-ID: <DM6PR12MB3931DCBEB1DC6C722605E6F484130@DM6PR12MB3931.namprd12.prod.outlook.com>
References: <20200219040445.11112-1-Dennis.Li@amd.com>
 <DM5PR12MB1418062D884DBE08E1FB9997FC100@DM5PR12MB1418.namprd12.prod.outlook.com>
 <e7ea478f-95ff-69c6-e81e-709b44904209@gmail.com>
 <DM6PR12MB393104A6C93ED039BAA5ED1C84100@DM6PR12MB3931.namprd12.prod.outlook.com>
 <MN2PR12MB3167C68A5B6AF0E97613A6A4ED130@MN2PR12MB3167.namprd12.prod.outlook.com>
 <DM6PR12MB39317635C3FB63265B9216D084130@DM6PR12MB3931.namprd12.prod.outlook.com>
 <DM6PR12MB39317F37CBE569725C00ABD284130@DM6PR12MB3931.namprd12.prod.outlook.com>
 <a8e8df99-aaed-5c0a-10ee-7cb63861c283@amd.com>
 <c778adb5-1ded-3b66-3f74-120f3388d611@amd.com>
In-Reply-To: <c778adb5-1ded-3b66-3f74-120f3388d611@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4979569e-dab5-4548-abfc-08d7b618f954
x-ms-traffictypediagnostic: DM6PR12MB4338:|DM6PR12MB4338:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4338FB31A67D20E73EA63D0F84130@DM6PR12MB4338.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(199004)(189003)(66556008)(64756008)(86362001)(66446008)(76116006)(33656002)(66946007)(81156014)(316002)(7696005)(66476007)(110136005)(8936002)(6506007)(81166006)(53546011)(478600001)(52536014)(26005)(224303003)(9686003)(55016002)(71200400001)(45080400002)(186003)(5660300002)(2906002)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4338;
 H:DM6PR12MB3931.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0q4MIBxqkjY+1RheHo0aqbSOAAw6Crck9ZL7agFr1RDXCLPVwhEggPrrqiniK2cCbC1dOcOuGome9vYqVSRVgn1Hz70iqN6RRKZHLnuM6hDIMZIpSxp2evxubtmkERdAIDCqzwlJXcQVqoo6Cz7bZOPm8D0hQvkzrd/kXeYg8phnT6w14v5gPZg40Qg0c1ZQNThVG4V4eivdaAVnIPxZWfIHeWo5aHMIFIC4zLOlvKD819c6biz//DoVLBhXNecXja/yneAa0BJW7VVX9NsYf8ObeBQAX3GndSPMrKxHJZhw0S6U4b3P8NqSeEuSiAMrOpvUSECdibRKo/73Sx+xsloY5x1jg6U1bMvCDupn2J36oHEqR2UauxCO54BSSYQpSGVaD9+a+SC19U8ShBZBhlj1wdelA/zf5LpYx/LKWLTJkuVOso+n/wU/7P9rCc9LESZVemJU7tFsdYcGIu4oF/HWT9H5DeTAWdy66FreiPKdrnW7gFTahWE+gg8F+YdmBz3t2ws3T0/DixXCoE7qDdt15lbJselUYuE8uce/pz4N33AqmpSOeqm85+Vr3jsNaOW7dozkYxW2lE7GssRK8VZJVCNPoDgF8dnwC0IJzpZg9EpLMi9KwHLGAxt104WT
x-ms-exchange-antispam-messagedata: I/rxkiL9SQQQZ9+aziDh4IaxuZDbyXKnzK+JxO1u1iEOisOZBdMsIrmjyvQmYMEtCBAKb/ASqQ2+Oy0J5M+1TGQJ+3FwdrIVsaoO0L47dB6/5yPp2dLr9T5CtGfYQwFPQi5WyLU4WrVOnvm+WnjJ2A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4979569e-dab5-4548-abfc-08d7b618f954
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 15:24:27.2691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wuFCN/UrgPQXQ3b1+pAM9cgHLSV3ASx7lTHccPiAyvX+jQvp5aYedm8f6DAZqNca
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
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

SSBkb24ndCBrbm93DQoNClRoZSBwYXRjaCBpcyBmcm9tIG1lLCBJIGp1c3QgdGhpbmsgdGhlIHBh
dGNoIGlzIGRyb3BwaW5nIGEgdm0gdXBkYXRlIHdoaWNoIGxvb2tzIG5vdCBwZXJmZWN0IHRvIG1l
DQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogYW1kLWdmeCA8YW1kLWdmeC1i
b3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4g5Luj6KGoIE5pcm1veQ0K5Y+R6YCB5pe26Ze0
OiAyMDIw5bm0MuaciDIw5pelIDIzOjIxDQrmlLbku7bkuro6IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQrkuLvpopg6IFJlOiDlm57lpI06IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IGEg
YnVnIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZQ0KDQpIaSBNb25rLA0KDQpIb3fCoCBjYW4gSSBy
ZXByb2R1Y2UgdGhpcyBidWcgPw0KDQpSZWdhcmRzLA0KDQpOaXJtb3kNCg0KT24gMi8yMC8yMCA0
OjE1IFBNLCBOaXJtb3kgd3JvdGU6DQo+DQo+IE9uIDIvMjAvMjAgMjozNSBQTSwgTGl1LCBNb25r
IHdyb3RlOg0KPj4gU29ycnksIG15IHByZXZpb3VzIGlkZWEgc3RpbGwgbGVhdmUgUlEgbnVsbCwg
cGxlYXNlIGNoZWNrIGlmIGJlbG93IA0KPj4gbWV0aG9kIHdvcmtzOg0KPj4NCj4+IDI5IHN0YXRp
YyBzdHJ1Y3QgZHJtX3NjaGVkX3JxICoNCj4+IDEzMCBkcm1fc2NoZWRfZW50aXR5X2dldF9mcmVl
X3NjaGVkKHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHkpDQo+PiAxMzEgew0KPj4gMTMy
wqDCoMKgwqAgc3RydWN0IGRybV9zY2hlZF9ycSAqcnEgPSBOVUxMOw0KPj4gMTMzwqDCoMKgwqAg
dW5zaWduZWQgaW50IG1pbl9qb2JzID0gVUlOVF9NQVgsIG51bV9qb2JzOw0KPj4gMTM0wqDCoMKg
wqAgaW50IGk7DQo+Pg0KPj4gMTM1DQo+PiDCoMKgwqDCoMKgwqDCoCBXaGlsZSAoIW11dGV4X3Ry
eWxvY2soLi4uLikpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNsZWVwKCkNCj4gV2UgY2Fu
J3QgZG8gdGhhdCBkcm1fc2NoZWRfZW50aXR5X2dldF9mcmVlX3NjaGVkIGlzIGluIGFub3RoZXIg
DQo+IG1vZHVsZShkcm0gc2NoZWR1bGVyKSBpbmRlcGVuZGVudCBvZiBhbWRncHUNCj4+IDEzNsKg
wqDCoMKgIGZvciAoaSA9IDA7IGkgPCBlbnRpdHktPm51bV9ycV9saXN0OyArK2kpIHsNCj4+IDEz
N8KgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCA9IA0KPj4g
ZW50aXR5LT5ycV9saXN0W2ldLT5zY2hlZDsNCj4+IDEzOA0KPj4gMTM5wqDCoMKgwqDCoMKgwqDC
oCBpZiAoIWVudGl0eS0+cnFfbGlzdFtpXS0+c2NoZWQtPnJlYWR5KSB7IC8vd2UgdGFrZSB0aGUg
DQo+PiBncHUgcmVzZXQgbXV0ZXggbG9jaywgc28gbm93IHNjaGVkLT5yZWFkeSB3b24ndCBiZSBz
ZXQgdG8gIm5vdCByZWFkeSINCj4+IDE0MMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBEUk1fV0FS
Tigic2NoZWQlcyBpcyBub3QgcmVhZHksIHNraXBwaW5nIiwgDQo+PiBzY2hlZC0+bmFtZSk7DQo+
PiAxNDHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7DQo+PiAxNDLCoMKgwqDCoMKg
wqDCoMKgIH0NCj4+IDE0Mw0KPj4gMTQ0wqDCoMKgwqDCoMKgwqDCoCBudW1fam9icyA9IGF0b21p
Y19yZWFkKCZzY2hlZC0+bnVtX2pvYnMpOw0KPj4gMTQ1wqDCoMKgwqDCoMKgwqDCoCBpZiAobnVt
X2pvYnMgPCBtaW5fam9icykgew0KPj4gMTQ2wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1pbl9q
b2JzID0gbnVtX2pvYnM7DQo+PiAxNDfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcnEgPSBlbnRp
dHktPnJxX2xpc3RbaV07DQo+PiAxNDjCoMKgwqDCoMKgwqDCoMKgIH0NCj4+IDE0OcKgwqDCoMKg
IH0NCj4+DQo+PiDCoMKgwqDCoMKgwqDCoCBNdXRleF91bmxvY2soLi4uKQ0KPj4NCj4+IDE1MA0K
Pj4gMTUxwqDCoMKgwqAgcmV0dXJuIHJxOw0KPj4gMTUyIH0NCj4+DQo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGFtZC1nZnggbWFpbGluZyBsaXN0
DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IGh0dHBzOi8vbmFtMTEuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3QNCj4gcy5m
cmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAy
JTdDMDElN0Ntbw0KPiBuay5saXUlNDBhbWQuY29tJTdDMzYzNWZjOGJhYTRkNGI5MDM4NzEwOGQ3
YjYxODgwNjklN0MzZGQ4OTYxZmU0ODg0ZTYwDQo+IDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3
QzYzNzE3ODA4ODY2MTI1MzY1MSZhbXA7c2RhdGE9S2kwU211bFBFU0xJajcNCj4gZEd5VDEwQmUw
elh1bmdLNFU5ZlhPTnA0NU5qYUElM0QmYW1wO3Jlc2VydmVkPTANCj4NCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0K
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9w
Lm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q21v
bmsubGl1JTQwYW1kLmNvbSU3QzM2MzVmYzhiYWE0ZDRiOTAzODcxMDhkN2I2MTg4MDY5JTdDM2Rk
ODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE3ODA4ODY2MTI1MzY1
MSZhbXA7c2RhdGE9S2kwU211bFBFU0xJajdkR3lUMTBCZTB6WHVuZ0s0VTlmWE9OcDQ1TmphQSUz
RCZhbXA7cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
