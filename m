Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD498C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 01:33:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C61D20659
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 01:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C61D20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26CC46E0D0;
	Tue, 12 Nov 2019 01:33:47 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740071.outbound.protection.outlook.com [40.107.74.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49F5C6E0D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 01:33:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFtAeCpUt2AmUxT/A97rDbN3QI70ln/YiUjMPZZx0SlPNwqeaNcXJF9RjLxp6lPxPsG9Ew3V6Enaf1tseu8ACYR4B6Tp2dsS6QyAhhdeLw9mj9ju8FDgw1MpmS+UdRUmHR/cRdcMNRTyMhbz7ApR6YXVqrsFA3zf13YCDWj5LhxquiAxYJG6mNsBFR/BcM31h23V599ADQ1ni/eZ/ZIKCDV7yyv4BshrcpJUojMvh3/SGONJ8YtrpNkmmLD93dujVkU1lRjVrKuBZ2e23utYCacZu+OtiuUuCwX6CrGKywQdGL21A9pXJKQvs1p/f/yzefDZTNeBNPvHFZk1kZzr7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3v/OHSTg6Ea/zDLyhqrDO4nePxIB93GORDRYz/+j+Wg=;
 b=U7hn8r+SPeJ4gN3MYm63dbx8tyn06ehygfgzQQZhnZ4OeW3jA2lDEUGzoQA+gd2JXu40e7MlD7OyjRLHHN46EGcGcwhR1l7PsxroqHsv8yHJtdvm8tVIhMzc4TTB5DRgtAzHDuz7N9oRgUlDhGbCFHRB/l5FmgTK5ulOd4fQZnHGuTBxQopVXOvNBPNCTnXr0uo7xOj7TM/5uKSf0YbYsBlkT4K9o7hcn/7lRcHyv5t/+1xi2IWDh2hCk32L3RucXh3xSCF0WSW7xc1QCMpB2ONXLtNBm1sqwkMVd3FvfQWoy4E60Sd61t/yKCiLjehTMArgHZJdWh6sPfkNhNW2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3534.namprd12.prod.outlook.com (20.179.84.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 01:33:44 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 01:33:44 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/powerplay: avoid DPM reenable process on Navi1x
 ASICs
Thread-Topic: [PATCH] drm/amd/powerplay: avoid DPM reenable process on Navi1x
 ASICs
Thread-Index: AQHVmHH2/bAvRxj6QEWqq890wx502aeGO2GAgACD7AA=
Date: Tue, 12 Nov 2019 01:33:44 +0000
Message-ID:
 <MN2PR12MB3344DA38E540DD655ECC75ADE4770@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191111092506.18913-1-evan.quan@amd.com>
 <CADnq5_OhXnzYx6EgMM87dh1jgUi6Br86Axwi_KfvLjXuO2+gxw@mail.gmail.com>
In-Reply-To: <CADnq5_OhXnzYx6EgMM87dh1jgUi6Br86Axwi_KfvLjXuO2+gxw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dae98ab0-aa78-4ace-db12-08d767105b47
x-ms-traffictypediagnostic: MN2PR12MB3534:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR12MB3534152E34990617D6A1E41BE4770@MN2PR12MB3534.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:132;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(13464003)(189003)(199004)(9686003)(6436002)(4326008)(6306002)(6246003)(55016002)(229853002)(66066001)(33656002)(3846002)(25786009)(1411001)(8936002)(478600001)(86362001)(6116002)(966005)(2906002)(305945005)(99286004)(316002)(81156014)(66946007)(11346002)(76116006)(81166006)(446003)(486006)(71200400001)(71190400001)(5660300002)(74316002)(8676002)(14454004)(6916009)(7736002)(76176011)(53546011)(6506007)(476003)(7696005)(26005)(102836004)(52536014)(14444005)(256004)(186003)(66476007)(64756008)(66446008)(66556008)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3534;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 18iJK6edOZzH/wPMEIiksa8lm8oF3pB5r+dMdMBpYsp+qZr4AkylPDqLV6hbcZCt/vQTDTsiydoRwtc45kb3ogzPq6XLPliY3B/ZEP6mhyQABb7bqzDiNni83DzXvrMJMlqqxGBAc0D+S5Ixdmk4Dr03uWi+ZWbKsSrnwD9HstziD0qiNSRPptpWJQqeiJvxfnZ5WGMUz+snsqApEJnzGt/ZjxrO1pq/X4E3XVMdmoFmJq3cnMtmqIahxX39M/ROE1H6+qJ58kBDXO9SDEZIiz5OcFyMo9KtqDSVTANoQrHzMUqE2WgyOn0wdTcT4UFfkFRme7WuQxNXtle3YkYORumd1YX6MTfCVlGjbHEISaVjqT5sdLQ5j3L9I9DpAEd1w1d/L+B7VM2tZpWUmx2QF0xmVvViN13FjdKqG6Y42hSHr1VQ8sbjUpzlYDhY7cKq5UT/9oCQutGCTFmf/Q4zWhhNsmGrzkPlWftkgrG/Zaw=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae98ab0-aa78-4ace-db12-08d767105b47
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 01:33:44.2669 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: capvAOFwNe6uUYxjEHE6DLiVl2LZd/4psF3+IUQ6k3te+ysyM7K+RCx4za8P92LG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3534
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3v/OHSTg6Ea/zDLyhqrDO4nePxIB93GORDRYz/+j+Wg=;
 b=PEYH6qDPXz7G8jqiFBdOav8fB4zvC2LQ/BuZLA/iOiuhDt5ZuwcP7hzCpmxSo1ByP8e5o0AWHxETU2wUD7UjB92EOJ1uRfkL7MKDWiDGsQ8Tbr3MM7tLzo82n/RsEkZttSWDTS3P1SvnsUGXtdi/8JJJ5e9BAYHypWfaO6ecy4s=
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112013344.YMo4LGHL6GWk7IUZ3tM93ZdWjxUkudA8V-rn5lVN1bs@z>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxh
bGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDEyLCAyMDE5
IDE6MzQgQU0NCj4gVG86IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPg0KPiBDYzogYW1k
LWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gZHJtL2FtZC9wb3dlcnBsYXk6IGF2b2lkIERQTSByZWVuYWJsZSBwcm9jZXNzIG9u
DQo+IE5hdmkxeCBBU0lDcw0KPiANCj4gT24gTW9uLCBOb3YgMTEsIDIwMTkgYXQgNDoyNSBBTSBF
dmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IE90aGVyd2lzZSwg
d2l0aG91dCBSTEMgcmVpbml0aWFsaXphdGlvbiwgdGhlIERQTSByZWVuYWJsZW1lbnQgd2lsbA0K
PiA+IGZhaWwuIFRoYXQgYWZmZWN0cyB0aGUgY3VzdG9tIHBwdGFibGUgdXBsb2FkaW5nLg0KPiA+
DQo+ID4gQ2hhbmdlLUlkOiBJNmZlMmVkNWNlMjNmMmE1YjY2ZjM3MWMwYjZkMWY5MjQ4MzdlNWFm
Ng0KPiA+IFNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyAgICB8
IDMyICsrKysrKysrKysrKysrKy0tDQo+IC0tDQo+ID4gIC4uLi9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvaW5jL2FtZGdwdV9zbXUuaCAgICB8ICAxICsNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNiBp
bnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYw0KPiA+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jDQo+ID4gaW5kZXggNzZhNDE1NGIzYmUyLi5h
NGQ2N2IzMGZkNzIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvYW1kZ3B1X3NtdS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
YW1kZ3B1X3NtdS5jDQo+ID4gQEAgLTEyOTMsMTAgKzEyOTMsMjUgQEAgc3RhdGljIGludCBzbXVf
aHdfZmluaSh2b2lkICpoYW5kbGUpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+
ID4gICAgICAgICB9DQo+ID4NCj4gPiAtICAgICAgIHJldCA9IHNtdV9zdG9wX2RwbXMoc211KTsN
Cj4gPiAtICAgICAgIGlmIChyZXQpIHsNCj4gPiAtICAgICAgICAgICAgICAgcHJfd2FybigiRmFp
bCB0byBzdG9wIERwbXMhXG4iKTsNCj4gPiAtICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4g
PiArICAgICAgIC8qDQo+ID4gKyAgICAgICAgKiBGb3IgY3VzdG9tIHBwdGFibGUgdXBsb2FkaW5n
LCBza2lwIHRoZSBEUE0gZmVhdHVyZXMNCj4gPiArICAgICAgICAqIGRpc2FibGUgcHJvY2VzcyBv
biBOYXZpMXggQVNJQ3MuDQo+ID4gKyAgICAgICAgKiAgIC0gQXMgdGhlIGdmeCByZWxhdGVkIGZl
YXR1cmVzIGFyZSB1bmRlciBjb250cm9sIG9mDQo+ID4gKyAgICAgICAgKiAgICAgUkxDIG9uIHRo
b3NlIEFTSUNzLiBSTEMgcmVpbml0aWFsaXphdGlvbiB3aWxsIGJlDQo+ID4gKyAgICAgICAgKiAg
ICAgbmVlZGVkIHRvIHJlZW5hYmxlIHRoZW0uIFRoYXQgd2lsbCBjb3N0IG11Y2ggbW9yZQ0KPiA+
ICsgICAgICAgICogICAgIGVmZm9ydHMuDQo+ID4gKyAgICAgICAgKg0KPiA+ICsgICAgICAgICog
ICAtIFNNVSBmaXJtd2FyZSBjYW4gaGFuZGxlIHRoZSBEUE0gcmVlbmFibGVtZW50DQo+ID4gKyAg
ICAgICAgKiAgICAgcHJvcGVybHkuDQo+ID4gKyAgICAgICAgKi8NCj4gPiArICAgICAgIGlmICgh
c211LT51cGxvYWRpbmdfY3VzdG9tX3BwX3RhYmxlIHx8DQo+ID4gKyAgICAgICAgICAgISgoYWRl
di0+YXNpY190eXBlID49IENISVBfTkFWSTEwKSAmJg0KPiA+ICsgICAgICAgICAgICAgKGFkZXYt
PmFzaWNfdHlwZSA8PSBDSElQX05BVkkxMikpKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHJldCA9
IHNtdV9zdG9wX2RwbXMoc211KTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKHJldCkgew0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIHByX3dhcm4oIkZhaWwgdG8gc3RvcCBEcG1zIVxuIik7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiArICAgICAgICAg
ICAgICAgfQ0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICBrZnJlZSh0YWJsZV9jb250
ZXh0LT5kcml2ZXJfcHB0YWJsZSk7DQo+ID4gQEAgLTEzMjQsMTMgKzEzMzksMTYgQEAgaW50IHNt
dV9yZXNldChzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkNCj4gPiAgICAgICAgIHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2ID0gc211LT5hZGV2Ow0KPiA+ICAgICAgICAgaW50IHJldCA9IDA7DQo+
ID4NCj4gPiArICAgICAgIHNtdS0+dXBsb2FkaW5nX2N1c3RvbV9wcF90YWJsZSA9IHRydWU7DQo+
ID4gKw0KPiANCj4gRG8gd2UgbmVlZCB0byBkaWZmZXJlbnRpYXRlIGJldHdlZW4gcmVsb2FkaW5n
IGZvciBhIHBwdGFibGUgdXBkYXRlIGFuZA0KPiByZWxvYWRpbmcgZm9yIGEgZ3B1IHJlc2V0IG9y
IHN1c3BlbmQvcmVzdW1lIG9yIGlzIHRoYXQgYWxyZWFkeSBoYW5kbGVkPw0KW1F1YW4sIEV2YW5d
IFRoYXQgd2FzIGNvbnNpZGVyZWQoYW5kIGFzIEkgdmVyaWZpZWQgc3VzcGVuZC9yZXN1bWUgd2Fz
IGZpbmUpLiAgRm9yIGdwdSByZXNldCBvciBzdXNwZW5kL3Jlc3VtZSwgdGhlIHJsYy9nZnggd2ls
bCBiZSByZWluaXRpYWxpemVkLg0KU28sIHVuZGVyIHRob3NlIGNhc2VzLCBpdCdzIE9LIHRvIHBl
cmZvcm0gdGhlIGRwbXMgZGlzYWJsZW1lbnQuDQo+IFNob3VsZG4ndCB3ZSBiZSBzZXR0aW5nL2Ns
ZWFyaW5nIHVwbG9hZGluZ19jdXN0b21fcHBfdGFibGUgaW4NCj4gc211X3N5c19zZXRfcHBfdGFi
bGUoKSBhcm91bmQgdGhlIGNhbGwgdG8gc211X3Jlc2V0KCk/DQpbUXVhbiwgRXZhbl0gVGhhdCdz
IGEgZ29vZCBwb2ludC4gV2lsbCB1cGRhdGUgdGhpcyBpbiBWMi4NCj4gDQo+IEFsZXgNCj4gDQo+
ID4gICAgICAgICByZXQgPSBzbXVfaHdfZmluaShhZGV2KTsNCj4gPiAgICAgICAgIGlmIChyZXQp
DQo+ID4gLSAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKyAgICAgICAgICAgICAgIGdv
dG8gb3V0Ow0KPiA+DQo+ID4gICAgICAgICByZXQgPSBzbXVfaHdfaW5pdChhZGV2KTsNCj4gPiAt
ICAgICAgIGlmIChyZXQpDQo+ID4gLSAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKw0K
PiA+ICtvdXQ6DQo+ID4gKyAgICAgICBzbXUtPnVwbG9hZGluZ19jdXN0b21fcHBfdGFibGUgPSBm
YWxzZTsNCj4gPg0KPiA+ICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvYW1kZ3B1X3NtdS5oDQo+ID4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvYW1kZ3B1X3NtdS5oDQo+ID4gaW5k
ZXggODEyMGU3NTg3NTg1Li4yMTU4NDFmNWZiOTMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2FtZGdwdV9zbXUuaA0KPiA+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9hbWRncHVfc211LmgNCj4gPiBAQCAtMzkxLDYgKzM5
MSw3IEBAIHN0cnVjdCBzbXVfY29udGV4dA0KPiA+DQo+ID4gICAgICAgICB1aW50MzJfdCBzbWNf
aWZfdmVyc2lvbjsNCj4gPg0KPiA+ICsgICAgICAgYm9vbCB1cGxvYWRpbmdfY3VzdG9tX3BwX3Rh
YmxlOw0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0cnVjdCBpMmNfYWRhcHRlcjsNCj4gPiAtLQ0KPiA+
IDIuMjQuMA0KPiA+DQo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCj4gPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiA+IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQo+ID4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
