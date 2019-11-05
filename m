Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ED5C5DF60
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 20:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B53205C9
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 20:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B53205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 855BC6E506;
	Tue,  5 Nov 2019 20:21:45 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740047.outbound.protection.outlook.com [40.107.74.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4CF26E506
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 20:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIfzZ46uUZwXgE0zgT4Bfgtwmdn9wOzBJyBen/8hmprojzex677LA/EIgTHdRDU0K4UwKOBVlT8piA/iv/NZEOqlix60MzjXAXxtYKlEfDGS68kQisNWkaMFHRJzkhgnOKRHeAtL12GBFAmKuGUtD2soHg6F11M1/lJD31U1gaDh/Xum6cXZ7xhwXZZz8usLX7YPvOljNXxE/BzeBEuHHE2tbNTH/lbIqvXgh7STV1IVOLMP+5e+aPGERV8DO8xHof2gRxg39PgKr7USuTGbdrAwS3NxrDo4sjreOH3XnocImor0KTFpWdS9CVaex1BrypiMpwvAV/+A3uzCEdRLMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oisLJ/FE5+o7fxhYT3kfj1oeLnbo4eEAR9nFjrt+3nk=;
 b=QdXNkE/FLO0uR4Qz7MKGWJO32AVEnp4EdGylW85rqd9p/G6ZesfnnOr/CNWTIPPZwbX/K7o2riAzdH1m3enWQp/wLNrp8zE5gspanieptiOF3kpADhchRrUYilmzylgM6L/k80RMyi38WD13e0yQdXKoyAdq1j2T/xtYQo0WSa9ZTbASWezy94fPIi2cw+NkKC7m3z99Zqnfc+hx5DuGWWRg8RGqGhkERITPQYJOtF+sWYKlVe40b69YntyHzLHCSZ2L2k0JxJJeqvwGO5D3uIUP0Y8ld7+pEt9vU6XXpTxo+IhEk3VPydVKA9J+lgrv8HN8TxG+/lFNxeNBbJTAlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB3047.namprd12.prod.outlook.com (20.178.53.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 20:21:40 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 20:21:40 +0000
From: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
To: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amd/display: Send vblank and user events at
 vsartup for DCN
Thread-Topic: [PATCH 1/2] drm/amd/display: Send vblank and user events at
 vsartup for DCN
Thread-Index: AQHVk+6ktQvcBIKgakaDyM9X6Te8YKd8bKcAgAB6IgCAAB6YAA==
Date: Tue, 5 Nov 2019 20:21:40 +0000
Message-ID: <5c6b9af3-65cb-a5a5-4c10-e3d5c4ac754a@amd.com>
References: <20191105153416.32049-1-sunpeng.li@amd.com>
 <c93c503d-48dc-1ea5-19f7-42ff9392e162@amd.com>
 <ed7b7f5e-4a53-f3e1-912f-e0ae5181288c@amd.com>
In-Reply-To: <ed7b7f5e-4a53-f3e1-912f-e0ae5181288c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTBPR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::16) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ccdea07-24db-402b-20b1-08d7622dc478
x-ms-traffictypediagnostic: BYAPR12MB3047:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB30471B01F7C6F80A78F49CACEC7E0@BYAPR12MB3047.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(99286004)(316002)(102836004)(486006)(66446008)(256004)(3846002)(2906002)(14444005)(305945005)(4326008)(6116002)(25786009)(71190400001)(66556008)(11346002)(14454004)(7736002)(446003)(2501003)(52116002)(476003)(5660300002)(6246003)(66476007)(6436002)(64756008)(76176011)(31686004)(478600001)(31696002)(71200400001)(86362001)(186003)(81156014)(81166006)(8936002)(8676002)(36756003)(66946007)(386003)(26005)(110136005)(2616005)(54906003)(229853002)(6506007)(66066001)(6486002)(6512007)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3047;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LlCA5G8dldg0lJS1LTa1AsmPpiN+qDHaHtD9jpApQWBEEiaPUhGQ0qzmVVV3NML4I1buZHlCx68Ke9LipcABR2IxbawrEoYj7kj5ULAOqDBmGBRMEoZ9RScxm3N/ak3DvVM6i3Y0xhOw9LTSvjN9VVr548cuFN1hYb55Xb0T0ZeZ3ntt+N1MA0PzpUmpWxbk0ZhEAhg4XQrAzUZEO0GV4U/TTe5wXVTQuaKJBWjnAQ5HZhwuEuuSsP54MRfRU63GLK62pkX0DMk/C1VPGUZJSWYlqN9RDilJ/sJ6hG5OkbKyonjbsw5muvV0aFRLC5KfJk3ZskJKZ4w2Z7Nocb67CyTlHLdvcQPr9VnO0L3UU0FahaCuFhgsrsvJgXrA8H6O2hXmFVagHA2EHf5XDXSp77pw31a0vPuZ+XZhb+TIwRpKgTZlSXRCcFsGIOvI5RIS
Content-ID: <225C4C254702704EBCCAEE8B85D2D0F8@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccdea07-24db-402b-20b1-08d7622dc478
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 20:21:40.7520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JaxaLiN6KRT/IYsG0pzd0fNC/zUU6ah2SdiLnkuqDUjVKUOwjNW0TzTXyyLx692GSNCDbfSpOTwl0TdvfP6Akg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3047
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oisLJ/FE5+o7fxhYT3kfj1oeLnbo4eEAR9nFjrt+3nk=;
 b=tSVJCNKRapCfzM4hU3U+fKaCifS3Ou85+gZ47Ggy3zsQ6gqMdt8wNh5V6rZQqSFo7XF+wmKo6q/AzOxNwJ6XwKwHW7yZx074vTKMQ9IewV/PtxvVPvMHdJ8D+FJUqe3coPB6yOznbCxAdnpcmPIcRWCRRGjUFQJctvNJ8zFwAgE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
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
Cc: "mario.kleiner.de@gmail.com" <mario.kleiner.de@gmail.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105202140.TldAm4EbUH9qa9pQKc_ET-WbnvTod0VBQGTH93SudIY@z>

T24gMjAxOS0xMS0wNSAxOjMyIHAubS4sIExpLCBTdW4gcGVuZyAoTGVvKSB3cm90ZToNCj4gDQo+
IA0KPiBPbiAyMDE5LTExLTA1IDExOjE1IGEubS4sIEthemxhdXNrYXMsIE5pY2hvbGFzIHdyb3Rl
Og0KPj4gT24gMjAxOS0xMS0wNSAxMDozNCBhLm0uLCBzdW5wZW5nLmxpQGFtZC5jb20gd3JvdGU6
DQo+Pj4gRnJvbTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+DQo+Pj4NCj4+PiBbV2h5XQ0K
Pj4+DQo+Pj4gRm9yIERDTiBoYXJkd2FyZSwgdGhlIGNydGNfaGlnaF9pcnEgaGFuZGxlciBpcyBh
c3NpZ25lZCB0byB0aGUgdnN0YXJ0dXANCj4+PiBpbnRlcnJ1cHQuIFRoaXMgaXMgZGlmZmVyZW50
IGZyb20gRENFLCB3aGljaCBoYXMgaXQgYXNzaWduZWQgdG8gdmJsYW5rDQo+Pj4gc3RhcnQuDQo+
Pj4NCj4+PiBXZSdkIGxpa2UgdG8gc2VuZCB2YmxhbmsgYW5kIHVzZXIgZXZlbnRzIGF0IHZzdGFy
dHVwIGJlY2F1c2U6DQo+Pj4NCj4+PiAqIEl0IGhhcHBlbnMgY2xvc2UgZW5vdWdoIHRvIHZ1cGRh
dGUgLSB0aGUgcG9pbnQgb2Ygbm8gcmV0dXJuIGZvciBIVy4NCj4+Pg0KPj4+ICogSXQgaXMgcHJv
Z3JhbW1lZCBhcyBsaW5lcyByZWxhdGl2ZSB0byB2YmxhbmsgZW5kIC0gaS5lLiBpdCBpcyBub3Qg
aW4NCj4+PiAgICAgdGhlIHZhcmlhYmxlIHBvcnRpb24gd2hlbiBWUlIgaXMgZW5hYmxlZC4gV2Ug
c2hvdWxkIHNpZ25hbCB1c2VyDQo+Pj4gICAgIGV2ZW50cyBoZXJlLg0KPj4+DQo+Pj4gKiBUaGUg
cGZsaXAgaW50ZXJydXB0IHJlc3BvbnNpYmxlIGZvciBzZW5kaW5nIHVzZXIgZXZlbnRzIHRvZGF5
IG9ubHkNCj4+PiAgICAgZmlyZXMgaWYgdGhlIERDSCBIVUJQIGNvbXBvbmVudCBpcyBub3QgY2xv
Y2sgZ2F0ZWQuIEluIHNpdHVhdGlvbnMNCj4+PiAgICAgd2hlcmUgcGxhbmVzIGFyZSBkaXNhYmxl
ZCAtIGJ1dCB0aGUgQ1JUQyBpcyBlbmFibGVkIC0gdXNlciBldmVudHMgd29uJ3QNCj4+PiAgICAg
YmUgc2VudCBvdXQsIGxlYWRpbmcgdG8gZmxpcCBkb25lIHRpbWVvdXRzLg0KPj4+DQo+Pj4gQ29u
c2VxdWVudGx5LCB0aGlzIG1ha2VzIHZ1cGRhdGUgb24gRENOIGhhcmR3YXJlIHJlZHVuZGFudC4g
SXQgd2lsbCBiZQ0KPj4+IHJlbW92ZWQgaW4gdGhlIG5leHQgY2hhbmdlLg0KPj4+DQo+Pj4gW0hv
d10NCj4+Pg0KPj4+IEFkZCBhIERDTi1zcGVjaWZpYyBjcnRjX2hpZ2hfaXJxIGhhbmRsZXIsIGFu
ZCBob29rIGl0IHRvIHRoZSBWU3RhcnR1cA0KPj4+IHNpZ25hbC4gSW5zaWRlIHRoZSBEQ04gaGFu
ZGxlciwgd2Ugc2VuZCBvZmYgdXNlciBldmVudHMgaWYgdGhlIHBmbGlwDQo+Pj4gaGFuZGxlciBo
YXNuJ3QgYWxyZWFkeSBkb25lIHNvLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTGVvIExpIDxz
dW5wZW5nLmxpQGFtZC5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgLi4uL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgNjUgKysrKysrKysrKysrKysrKysrLQ0KPj4+ICAg
IDEgZmlsZSBjaGFuZ2VkLCA2NCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4NCj4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRn
cHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2Rt
LmMNCj4+PiBpbmRleCAwMDAxN2I5MWM5MWEuLjI1NmEyM2EwZWMyOCAxMDA2NDQNCj4+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jDQo+Pj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYw0K
Pj4+IEBAIC00ODUsNiArNDg1LDY5IEBAIHN0YXRpYyB2b2lkIGRtX2NydGNfaGlnaF9pcnEodm9p
ZCAqaW50ZXJydXB0X3BhcmFtcykNCj4+PiAgICAJfQ0KPj4+ICAgIH0NCj4+Pg0KPj4+ICsNCj4+
PiArLyoqDQo+Pj4gKyAqIGRtX2Rjbl9jcnRjX2hpZ2hfaXJxKCkgLSBIYW5kbGVzIFZTdGFydHVw
IGludGVycnVwdCBmb3IgRENOIGdlbmVyYXRpb24gQVNJQ3MNCj4+PiArICogQGludGVycnVwdCBw
YXJhbXMgLSBpbnRlcnJ1cHQgcGFyYW1ldGVycw0KPj4+ICsgKg0KPj4+ICsgKiBOb3RpZnkgRFJN
J3MgdmJsYW5rIGV2ZW50IGhhbmRsZXIgYXQgVlNUQVJUVVANCj4+PiArICoNCj4+PiArICogVW5s
aWtlIERDRSBoYXJkd2FyZSwgd2UgdHJpZ2dlciB0aGUgaGFuZGxlciBhdCBWU1RBUlRVUC4gYXQg
d2hpY2g6DQo+Pj4gKyAqICogV2UgYXJlIGNsb3NlIGVub3VnaCB0byBWVVBEQVRFIC0gdGhlIHBv
aW50IG9mIG5vIHJldHVybiBmb3IgaHcNCj4+PiArICogKiBXZSBhcmUgaW4gdGhlIGZpeGVkIHBv
cnRpb24gb2YgdmFyaWFibGUgZnJvbnQgcG9yY2ggd2hlbiB2cnIgaXMgZW5hYmxlZA0KPj4+ICsg
KiAqIFdlIGFyZSBiZWZvcmUgVlVQREFURSwgd2hlcmUgZG91YmxlLWJ1ZmZlcmVkIHZyciByZWdp
c3RlcnMgYXJlIHN3YXBwZWQNCj4+PiArICoNCj4+PiArICogSXQgaXMgdGhlcmVmb3JlIHRoZSBj
b3JyZWN0IHBsYWNlIHRvIHNpZ25hbCB2YmxhbmssIHNlbmQgdXNlciBmbGlwIGV2ZW50cywNCj4+
PiArICogYW5kIHVwZGF0ZSBWUlIuDQo+Pj4gKyAqLw0KPj4+ICtzdGF0aWMgdm9pZCBkbV9kY25f
Y3J0Y19oaWdoX2lycSh2b2lkICppbnRlcnJ1cHRfcGFyYW1zKQ0KPj4+ICt7DQo+Pj4gKwlzdHJ1
Y3QgY29tbW9uX2lycV9wYXJhbXMgKmlycV9wYXJhbXMgPSBpbnRlcnJ1cHRfcGFyYW1zOw0KPj4+
ICsJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBpcnFfcGFyYW1zLT5hZGV2Ow0KPj4+ICsJ
c3RydWN0IGFtZGdwdV9jcnRjICphY3J0YzsNCj4+PiArCXN0cnVjdCBkbV9jcnRjX3N0YXRlICph
Y3J0Y19zdGF0ZTsNCj4+PiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+Pj4gKw0KPj4+ICsJYWNy
dGMgPSBnZXRfY3J0Y19ieV9vdGdfaW5zdChhZGV2LCBpcnFfcGFyYW1zLT5pcnFfc3JjIC0gSVJR
X1RZUEVfVkJMQU5LKTsNCj4+PiArDQo+Pj4gKwlpZiAoIWFjcnRjKQ0KPj4+ICsJCXJldHVybjsN
Cj4+PiArDQo+Pj4gKwlhY3J0Y19zdGF0ZSA9IHRvX2RtX2NydGNfc3RhdGUoYWNydGMtPmJhc2Uu
c3RhdGUpOw0KPj4+ICsNCj4+PiArCURSTV9ERUJVR19EUklWRVIoImNydGM6JWQsIHZ1cGRhdGUt
dnJyOiVkXG4iLCBhY3J0Yy0+Y3J0Y19pZCwNCj4+PiArCQkJCWFtZGdwdV9kbV92cnJfYWN0aXZl
KGFjcnRjX3N0YXRlKSk7DQo+Pj4gKw0KPj4+ICsJYW1kZ3B1X2RtX2NydGNfaGFuZGxlX2NyY19p
cnEoJmFjcnRjLT5iYXNlKTsNCj4+PiArCWRybV9jcnRjX2hhbmRsZV92YmxhbmsoJmFjcnRjLT5i
YXNlKTsNCj4+DQo+PiBTaG91bGRuJ3QgdGhpcyBiZSB0aGUgb3RoZXIgd2F5IGFyb3VuZD8gRG9u
J3Qgd2Ugd2FudCB0aGUgQ1JDIHNlbnQgYmFjaw0KPj4gdG8gdXNlcnNwYWNlIHRvIGhhdmUgdGhl
IHVwZGF0ZWQgdmJsYW5rIGNvdW50ZXI/DQo+Pg0KPj4gVGhpcyBpcyBob3cgaXQgd29ya2VkIGJl
Zm9yZSBhdCBsZWFzdC4NCj4+DQo+PiBPdGhlciB0aGFuIHRoYXQsIHRoaXMgcGF0Y2ggbG9va3Mg
ZmluZSB0byBtZS4NCj4+DQo+PiBOaWNob2xhcyBLYXpsYXVza2FzDQo+IA0KPiANCj4gTG9va3Mg
bGlrZSB3ZSdyZSBkb2luZyBhIGNydGNfYWNjdXJhdGVfdmJsYW5rX2NvdW50KCkgaW5zaWRlIHRo
ZSBjcmMgaGFuZGxlciwNCj4gc28gSSBkb24ndCB0aGluayBvcmRlciBtYXR0ZXJzIGhlcmUuDQo+
IA0KPiBMZW8NCg0KU291bmRzIGZpbmUgdG8gbWUgdGhlbi4NCg0KUmV2aWV3ZWQtYnk6IE5pY2hv
bGFzIEthemxhdXNrYXMgPG5pY2hvbGFzLmthemxhdXNrYXNAYW1kLmNvbT4NCg0KTmljaG9sYXMg
S2F6bGF1c2thcw0KDQo+IA0KPj4NCj4+PiArDQo+Pj4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmYWRl
di0+ZGRldi0+ZXZlbnRfbG9jaywgZmxhZ3MpOw0KPj4+ICsNCj4+PiArCWlmIChhY3J0Y19zdGF0
ZS0+dnJyX3BhcmFtcy5zdXBwb3J0ZWQgJiYNCj4+PiArCSAgICBhY3J0Y19zdGF0ZS0+ZnJlZXN5
bmNfY29uZmlnLnN0YXRlID09IFZSUl9TVEFURV9BQ1RJVkVfVkFSSUFCTEUpIHsNCj4+PiArCQlt
b2RfZnJlZXN5bmNfaGFuZGxlX3ZfdXBkYXRlKA0KPj4+ICsJCWFkZXYtPmRtLmZyZWVzeW5jX21v
ZHVsZSwNCj4+PiArCQlhY3J0Y19zdGF0ZS0+c3RyZWFtLA0KPj4+ICsJCSZhY3J0Y19zdGF0ZS0+
dnJyX3BhcmFtcyk7DQo+Pj4gKw0KPj4+ICsJCWRjX3N0cmVhbV9hZGp1c3Rfdm1pbl92bWF4KA0K
Pj4+ICsJCQlhZGV2LT5kbS5kYywNCj4+PiArCQkJYWNydGNfc3RhdGUtPnN0cmVhbSwNCj4+PiAr
CQkJJmFjcnRjX3N0YXRlLT52cnJfcGFyYW1zLmFkanVzdCk7DQo+Pj4gKwl9DQo+Pj4gKw0KPj4+
ICsJaWYgKGFjcnRjLT5wZmxpcF9zdGF0dXMgPT0gQU1ER1BVX0ZMSVBfU1VCTUlUVEVEKSB7DQo+
Pj4gKwkJaWYgKGFjcnRjLT5ldmVudCkgew0KPj4+ICsJCQlkcm1fY3J0Y19zZW5kX3ZibGFua19l
dmVudCgmYWNydGMtPmJhc2UsIGFjcnRjLT5ldmVudCk7DQo+Pj4gKwkJCWFjcnRjLT5ldmVudCA9
IE5VTEw7DQo+Pj4gKwkJCWRybV9jcnRjX3ZibGFua19wdXQoJmFjcnRjLT5iYXNlKTsNCj4+PiAr
CQl9DQo+Pj4gKwkJYWNydGMtPnBmbGlwX3N0YXR1cyA9IEFNREdQVV9GTElQX05PTkU7DQo+Pj4g
Kwl9DQo+Pj4gKw0KPj4+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmYWRldi0+ZGRldi0+ZXZl
bnRfbG9jaywgZmxhZ3MpOw0KPj4+ICt9DQo+Pj4gKw0KPj4+ICAgIHN0YXRpYyBpbnQgZG1fc2V0
X2Nsb2NrZ2F0aW5nX3N0YXRlKHZvaWQgKmhhbmRsZSwNCj4+PiAgICAJCSAgZW51bSBhbWRfY2xv
Y2tnYXRpbmdfc3RhdGUgc3RhdGUpDQo+Pj4gICAgew0KPj4+IEBAIC0yMTc1LDcgKzIyMzgsNyBA
QCBzdGF0aWMgaW50IGRjbjEwX3JlZ2lzdGVyX2lycV9oYW5kbGVycyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikNCj4+PiAgICAJCWNfaXJxX3BhcmFtcy0+aXJxX3NyYyA9IGludF9wYXJhbXMu
aXJxX3NvdXJjZTsNCj4+Pg0KPj4+ICAgIAkJYW1kZ3B1X2RtX2lycV9yZWdpc3Rlcl9pbnRlcnJ1
cHQoYWRldiwgJmludF9wYXJhbXMsDQo+Pj4gLQkJCQlkbV9jcnRjX2hpZ2hfaXJxLCBjX2lycV9w
YXJhbXMpOw0KPj4+ICsJCQkJZG1fZGNuX2NydGNfaGlnaF9pcnEsIGNfaXJxX3BhcmFtcyk7DQo+
Pj4gICAgCX0NCj4+Pg0KPj4+ICAgIAkvKiBVc2UgVlVQREFURV9OT19MT0NLIGludGVycnVwdCBv
biBEQ04sIHdoaWNoIHNlZW1zIHRvIGNvcnJlc3BvbmQgdG8NCj4+PiAtLQ0KPj4+IDIuMjMuMA0K
Pj4+DQo+Pg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
