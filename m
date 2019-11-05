Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D13C5DF60
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 18:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4067D217F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 18:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4067D217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08CC36EB42;
	Tue,  5 Nov 2019 18:32:10 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800052.outbound.protection.outlook.com [40.107.80.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25A056EB42
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 18:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbLDUNIvWDpSCCuziWRLC+riEr2ZVpDx/BumJ12JegTyju2EPSeLfZv+LQ8eKDNYrOqZKFTgLaN+1DAR2r2xbE6p1tc0fK+zmXtlPeT2wEokzwQoNTD9qCnWiUpgzEebAzAiSll+1/D0/spadTRtWkquLl/S8CmLBlqmQ04LQg+su4dvGFaK0PeSQibdO13ahBDCRD64GqbMm3U9T1qVPeu5vbN6QJlZOrdb4uqdMn1ig0wY1YTU7VjE8UW7UPP1AEccxtEQK5oVSFc/w1V5BM1bETnDLLJCO3SIVishxg5gD5Xg3UL46bSiBZmPwoCRR0ofTNFOuCFASVsvmVfMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5GSnKYjMUaSid3QJCDlIVfxIfpEy2Jx6DJKpffCuVU=;
 b=LmbA5qK4uOo1OEYRe+Y+F92+Q16Eyd30/Dp/rkufMkocJvQT4ncRpsd5PKq5k882Sb5XUQv3bsK/YzcjNxqTfJGvQb9hphm8VApN2RB61iEu1JVrxrghTn4g5roxiqYXTLWRxohGgomywU6MkSTji5uFpSmUmsjXj4dRYGNxreQOHKS4A0rklPd3yAVr/T5IW85XBmqQBfh+VpaQ6Okv903lrCwc1Pwd7X+qeVpyw+AJcFyrInJHB1TQ/9QhA5O3trrKip1X0jujZ3stRjjoSvkOyv+NxtskjvCZ9tIErqGZFz02maWLjKVuCpEtJ6MSvxH0jzq6cB6411C9HdjE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2724.namprd12.prod.outlook.com (20.176.178.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 18:32:06 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::c9fd:22d8:cfdb:f430]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::c9fd:22d8:cfdb:f430%5]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 18:32:06 +0000
From: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amd/display: Send vblank and user events at
 vsartup for DCN
Thread-Topic: [PATCH 1/2] drm/amd/display: Send vblank and user events at
 vsartup for DCN
Thread-Index: AQHVk+6krlsKYazsQ0+O5OOgHa22uKd8wH0AgAAmSQA=
Date: Tue, 5 Nov 2019 18:32:06 +0000
Message-ID: <ed7b7f5e-4a53-f3e1-912f-e0ae5181288c@amd.com>
References: <20191105153416.32049-1-sunpeng.li@amd.com>
 <c93c503d-48dc-1ea5-19f7-42ff9392e162@amd.com>
In-Reply-To: <c93c503d-48dc-1ea5-19f7-42ff9392e162@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::47) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6158f2ed-deac-4ced-218a-08d7621e75e2
x-ms-traffictypediagnostic: BN7PR12MB2724:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB27245DE17D590FE9B5160067827E0@BN7PR12MB2724.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(189003)(199004)(6246003)(66066001)(81166006)(6486002)(76176011)(2906002)(2501003)(26005)(6436002)(386003)(31686004)(316002)(102836004)(478600001)(229853002)(53546011)(110136005)(14454004)(54906003)(71190400001)(71200400001)(5660300002)(31696002)(6512007)(256004)(8676002)(81156014)(305945005)(486006)(52116002)(3846002)(6506007)(186003)(25786009)(86362001)(7736002)(36756003)(2616005)(446003)(11346002)(66946007)(8936002)(64756008)(476003)(66556008)(66446008)(66476007)(6116002)(4326008)(99286004)(14444005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2724;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rMcp6zxUFPkIS/Qav2Ha9xFLhRH/CQODcSydw6zS8mt21TMV9E4Bq74XneqkjAyHh8ulJ5jLJpk2ZF4a8PbJMhZhnpb3/YW/Y3pO8waI8o48sSRy6GsROZIJjmxLrZ0ZOC+yDSEWNMhYcVCtl/2IMhnpCZCVkcTmsJaoRTtDiOvXy0L1cFaBDnHIbZK31BoWllv8Hya2Ls6wUxkKEgzVIWO6WHqck5Llbhat+s+Jcbbd3ICxXiYF8VOzciicoonRLSYCWcMnumkiLNqHOtOM56jbRwZuGVUgns3R5Lbv6dlXEIuklcycr1DtKRJkjkar0t6TjW9ZgdY9raZHPTqhDEklHrl7V9J4Qjq9cVCoN/1xmvVaKdhDWdzpk8yOGp0qWb9pg3nnNNC+otWoEnB6g4Rrv2XYtiSoXNB+P8NKZGc9LgPv8UyVs8vaPVU86xWG
Content-ID: <211D0A82163B714C868F5E156B242601@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6158f2ed-deac-4ced-218a-08d7621e75e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 18:32:06.5547 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GxO2bbFTX35XITS2Siy8TOGb+ZxXP7UxnzID9jREP3Jnt7gmxg8LKQkgrdx5ldl7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2724
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5GSnKYjMUaSid3QJCDlIVfxIfpEy2Jx6DJKpffCuVU=;
 b=F06sCMtkI+aH0OAWzGlTbNTpYFeiyCcWTBMdKKPz2QOLDJKN7HSDej4HrAnoVLiguZ6Ukx4zeWSvq3+cUtLsFJC5LnfsRVJk9X4wAJazFB1zeCB5fGykiEEAUCzcQmiccN4xOfyek03Sj6m8NNA6dTjwSKOhJnsBtZB/UvUsmPE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
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
Message-ID: <20191105183206.Dtyusr7MkFEpeSq9bAVxTyum7TdUOJz6IGrfYgqh99E@z>

DQoNCk9uIDIwMTktMTEtMDUgMTE6MTUgYS5tLiwgS2F6bGF1c2thcywgTmljaG9sYXMgd3JvdGU6
DQo+IE9uIDIwMTktMTEtMDUgMTA6MzQgYS5tLiwgc3VucGVuZy5saUBhbWQuY29tIHdyb3RlOg0K
Pj4gRnJvbTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+DQo+Pg0KPj4gW1doeV0NCj4+DQo+
PiBGb3IgRENOIGhhcmR3YXJlLCB0aGUgY3J0Y19oaWdoX2lycSBoYW5kbGVyIGlzIGFzc2lnbmVk
IHRvIHRoZSB2c3RhcnR1cA0KPj4gaW50ZXJydXB0LiBUaGlzIGlzIGRpZmZlcmVudCBmcm9tIERD
RSwgd2hpY2ggaGFzIGl0IGFzc2lnbmVkIHRvIHZibGFuaw0KPj4gc3RhcnQuDQo+Pg0KPj4gV2Un
ZCBsaWtlIHRvIHNlbmQgdmJsYW5rIGFuZCB1c2VyIGV2ZW50cyBhdCB2c3RhcnR1cCBiZWNhdXNl
Og0KPj4NCj4+ICogSXQgaGFwcGVucyBjbG9zZSBlbm91Z2ggdG8gdnVwZGF0ZSAtIHRoZSBwb2lu
dCBvZiBubyByZXR1cm4gZm9yIEhXLg0KPj4NCj4+ICogSXQgaXMgcHJvZ3JhbW1lZCBhcyBsaW5l
cyByZWxhdGl2ZSB0byB2YmxhbmsgZW5kIC0gaS5lLiBpdCBpcyBub3QgaW4NCj4+ICAgIHRoZSB2
YXJpYWJsZSBwb3J0aW9uIHdoZW4gVlJSIGlzIGVuYWJsZWQuIFdlIHNob3VsZCBzaWduYWwgdXNl
cg0KPj4gICAgZXZlbnRzIGhlcmUuDQo+Pg0KPj4gKiBUaGUgcGZsaXAgaW50ZXJydXB0IHJlc3Bv
bnNpYmxlIGZvciBzZW5kaW5nIHVzZXIgZXZlbnRzIHRvZGF5IG9ubHkNCj4+ICAgIGZpcmVzIGlm
IHRoZSBEQ0ggSFVCUCBjb21wb25lbnQgaXMgbm90IGNsb2NrIGdhdGVkLiBJbiBzaXR1YXRpb25z
DQo+PiAgICB3aGVyZSBwbGFuZXMgYXJlIGRpc2FibGVkIC0gYnV0IHRoZSBDUlRDIGlzIGVuYWJs
ZWQgLSB1c2VyIGV2ZW50cyB3b24ndA0KPj4gICAgYmUgc2VudCBvdXQsIGxlYWRpbmcgdG8gZmxp
cCBkb25lIHRpbWVvdXRzLg0KPj4NCj4+IENvbnNlcXVlbnRseSwgdGhpcyBtYWtlcyB2dXBkYXRl
IG9uIERDTiBoYXJkd2FyZSByZWR1bmRhbnQuIEl0IHdpbGwgYmUNCj4+IHJlbW92ZWQgaW4gdGhl
IG5leHQgY2hhbmdlLg0KPj4NCj4+IFtIb3ddDQo+Pg0KPj4gQWRkIGEgRENOLXNwZWNpZmljIGNy
dGNfaGlnaF9pcnEgaGFuZGxlciwgYW5kIGhvb2sgaXQgdG8gdGhlIFZTdGFydHVwDQo+PiBzaWdu
YWwuIEluc2lkZSB0aGUgRENOIGhhbmRsZXIsIHdlIHNlbmQgb2ZmIHVzZXIgZXZlbnRzIGlmIHRo
ZSBwZmxpcA0KPj4gaGFuZGxlciBoYXNuJ3QgYWxyZWFkeSBkb25lIHNvLg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPg0KPj4gLS0tDQo+PiAgIC4uLi9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDY1ICsrKysrKysrKysr
KysrKysrKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDY0IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Ft
ZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVf
ZG0vYW1kZ3B1X2RtLmMNCj4+IGluZGV4IDAwMDE3YjkxYzkxYS4uMjU2YTIzYTBlYzI4IDEwMDY0
NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG0uYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRn
cHVfZG0uYw0KPj4gQEAgLTQ4NSw2ICs0ODUsNjkgQEAgc3RhdGljIHZvaWQgZG1fY3J0Y19oaWdo
X2lycSh2b2lkICppbnRlcnJ1cHRfcGFyYW1zKQ0KPj4gICAJfQ0KPj4gICB9DQo+Pg0KPj4gKw0K
Pj4gKy8qKg0KPj4gKyAqIGRtX2Rjbl9jcnRjX2hpZ2hfaXJxKCkgLSBIYW5kbGVzIFZTdGFydHVw
IGludGVycnVwdCBmb3IgRENOIGdlbmVyYXRpb24gQVNJQ3MNCj4+ICsgKiBAaW50ZXJydXB0IHBh
cmFtcyAtIGludGVycnVwdCBwYXJhbWV0ZXJzDQo+PiArICoNCj4+ICsgKiBOb3RpZnkgRFJNJ3Mg
dmJsYW5rIGV2ZW50IGhhbmRsZXIgYXQgVlNUQVJUVVANCj4+ICsgKg0KPj4gKyAqIFVubGlrZSBE
Q0UgaGFyZHdhcmUsIHdlIHRyaWdnZXIgdGhlIGhhbmRsZXIgYXQgVlNUQVJUVVAuIGF0IHdoaWNo
Og0KPj4gKyAqICogV2UgYXJlIGNsb3NlIGVub3VnaCB0byBWVVBEQVRFIC0gdGhlIHBvaW50IG9m
IG5vIHJldHVybiBmb3IgaHcNCj4+ICsgKiAqIFdlIGFyZSBpbiB0aGUgZml4ZWQgcG9ydGlvbiBv
ZiB2YXJpYWJsZSBmcm9udCBwb3JjaCB3aGVuIHZyciBpcyBlbmFibGVkDQo+PiArICogKiBXZSBh
cmUgYmVmb3JlIFZVUERBVEUsIHdoZXJlIGRvdWJsZS1idWZmZXJlZCB2cnIgcmVnaXN0ZXJzIGFy
ZSBzd2FwcGVkDQo+PiArICoNCj4+ICsgKiBJdCBpcyB0aGVyZWZvcmUgdGhlIGNvcnJlY3QgcGxh
Y2UgdG8gc2lnbmFsIHZibGFuaywgc2VuZCB1c2VyIGZsaXAgZXZlbnRzLA0KPj4gKyAqIGFuZCB1
cGRhdGUgVlJSLg0KPj4gKyAqLw0KPj4gK3N0YXRpYyB2b2lkIGRtX2Rjbl9jcnRjX2hpZ2hfaXJx
KHZvaWQgKmludGVycnVwdF9wYXJhbXMpDQo+PiArew0KPj4gKwlzdHJ1Y3QgY29tbW9uX2lycV9w
YXJhbXMgKmlycV9wYXJhbXMgPSBpbnRlcnJ1cHRfcGFyYW1zOw0KPj4gKwlzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiA9IGlycV9wYXJhbXMtPmFkZXY7DQo+PiArCXN0cnVjdCBhbWRncHVfY3J0
YyAqYWNydGM7DQo+PiArCXN0cnVjdCBkbV9jcnRjX3N0YXRlICphY3J0Y19zdGF0ZTsNCj4+ICsJ
dW5zaWduZWQgbG9uZyBmbGFnczsNCj4+ICsNCj4+ICsJYWNydGMgPSBnZXRfY3J0Y19ieV9vdGdf
aW5zdChhZGV2LCBpcnFfcGFyYW1zLT5pcnFfc3JjIC0gSVJRX1RZUEVfVkJMQU5LKTsNCj4+ICsN
Cj4+ICsJaWYgKCFhY3J0YykNCj4+ICsJCXJldHVybjsNCj4+ICsNCj4+ICsJYWNydGNfc3RhdGUg
PSB0b19kbV9jcnRjX3N0YXRlKGFjcnRjLT5iYXNlLnN0YXRlKTsNCj4+ICsNCj4+ICsJRFJNX0RF
QlVHX0RSSVZFUigiY3J0YzolZCwgdnVwZGF0ZS12cnI6JWRcbiIsIGFjcnRjLT5jcnRjX2lkLA0K
Pj4gKwkJCQlhbWRncHVfZG1fdnJyX2FjdGl2ZShhY3J0Y19zdGF0ZSkpOw0KPj4gKw0KPj4gKwlh
bWRncHVfZG1fY3J0Y19oYW5kbGVfY3JjX2lycSgmYWNydGMtPmJhc2UpOw0KPj4gKwlkcm1fY3J0
Y19oYW5kbGVfdmJsYW5rKCZhY3J0Yy0+YmFzZSk7DQo+IA0KPiBTaG91bGRuJ3QgdGhpcyBiZSB0
aGUgb3RoZXIgd2F5IGFyb3VuZD8gRG9uJ3Qgd2Ugd2FudCB0aGUgQ1JDIHNlbnQgYmFjayANCj4g
dG8gdXNlcnNwYWNlIHRvIGhhdmUgdGhlIHVwZGF0ZWQgdmJsYW5rIGNvdW50ZXI/DQo+IA0KPiBU
aGlzIGlzIGhvdyBpdCB3b3JrZWQgYmVmb3JlIGF0IGxlYXN0Lg0KPiANCj4gT3RoZXIgdGhhbiB0
aGF0LCB0aGlzIHBhdGNoIGxvb2tzIGZpbmUgdG8gbWUuDQo+IA0KPiBOaWNob2xhcyBLYXpsYXVz
a2FzDQoNCg0KTG9va3MgbGlrZSB3ZSdyZSBkb2luZyBhIGNydGNfYWNjdXJhdGVfdmJsYW5rX2Nv
dW50KCkgaW5zaWRlIHRoZSBjcmMgaGFuZGxlciwNCnNvIEkgZG9uJ3QgdGhpbmsgb3JkZXIgbWF0
dGVycyBoZXJlLg0KDQpMZW8NCg0KPiANCj4+ICsNCj4+ICsJc3Bpbl9sb2NrX2lycXNhdmUoJmFk
ZXYtPmRkZXYtPmV2ZW50X2xvY2ssIGZsYWdzKTsNCj4+ICsNCj4+ICsJaWYgKGFjcnRjX3N0YXRl
LT52cnJfcGFyYW1zLnN1cHBvcnRlZCAmJg0KPj4gKwkgICAgYWNydGNfc3RhdGUtPmZyZWVzeW5j
X2NvbmZpZy5zdGF0ZSA9PSBWUlJfU1RBVEVfQUNUSVZFX1ZBUklBQkxFKSB7DQo+PiArCQltb2Rf
ZnJlZXN5bmNfaGFuZGxlX3ZfdXBkYXRlKA0KPj4gKwkJYWRldi0+ZG0uZnJlZXN5bmNfbW9kdWxl
LA0KPj4gKwkJYWNydGNfc3RhdGUtPnN0cmVhbSwNCj4+ICsJCSZhY3J0Y19zdGF0ZS0+dnJyX3Bh
cmFtcyk7DQo+PiArDQo+PiArCQlkY19zdHJlYW1fYWRqdXN0X3ZtaW5fdm1heCgNCj4+ICsJCQlh
ZGV2LT5kbS5kYywNCj4+ICsJCQlhY3J0Y19zdGF0ZS0+c3RyZWFtLA0KPj4gKwkJCSZhY3J0Y19z
dGF0ZS0+dnJyX3BhcmFtcy5hZGp1c3QpOw0KPj4gKwl9DQo+PiArDQo+PiArCWlmIChhY3J0Yy0+
cGZsaXBfc3RhdHVzID09IEFNREdQVV9GTElQX1NVQk1JVFRFRCkgew0KPj4gKwkJaWYgKGFjcnRj
LT5ldmVudCkgew0KPj4gKwkJCWRybV9jcnRjX3NlbmRfdmJsYW5rX2V2ZW50KCZhY3J0Yy0+YmFz
ZSwgYWNydGMtPmV2ZW50KTsNCj4+ICsJCQlhY3J0Yy0+ZXZlbnQgPSBOVUxMOw0KPj4gKwkJCWRy
bV9jcnRjX3ZibGFua19wdXQoJmFjcnRjLT5iYXNlKTsNCj4+ICsJCX0NCj4+ICsJCWFjcnRjLT5w
ZmxpcF9zdGF0dXMgPSBBTURHUFVfRkxJUF9OT05FOw0KPj4gKwl9DQo+PiArDQo+PiArCXNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJmFkZXYtPmRkZXYtPmV2ZW50X2xvY2ssIGZsYWdzKTsNCj4+ICt9
DQo+PiArDQo+PiAgIHN0YXRpYyBpbnQgZG1fc2V0X2Nsb2NrZ2F0aW5nX3N0YXRlKHZvaWQgKmhh
bmRsZSwNCj4+ICAgCQkgIGVudW0gYW1kX2Nsb2NrZ2F0aW5nX3N0YXRlIHN0YXRlKQ0KPj4gICB7
DQo+PiBAQCAtMjE3NSw3ICsyMjM4LDcgQEAgc3RhdGljIGludCBkY24xMF9yZWdpc3Rlcl9pcnFf
aGFuZGxlcnMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+PiAgIAkJY19pcnFfcGFyYW1z
LT5pcnFfc3JjID0gaW50X3BhcmFtcy5pcnFfc291cmNlOw0KPj4NCj4+ICAgCQlhbWRncHVfZG1f
aXJxX3JlZ2lzdGVyX2ludGVycnVwdChhZGV2LCAmaW50X3BhcmFtcywNCj4+IC0JCQkJZG1fY3J0
Y19oaWdoX2lycSwgY19pcnFfcGFyYW1zKTsNCj4+ICsJCQkJZG1fZGNuX2NydGNfaGlnaF9pcnEs
IGNfaXJxX3BhcmFtcyk7DQo+PiAgIAl9DQo+Pg0KPj4gICAJLyogVXNlIFZVUERBVEVfTk9fTE9D
SyBpbnRlcnJ1cHQgb24gRENOLCB3aGljaCBzZWVtcyB0byBjb3JyZXNwb25kIHRvDQo+PiAtLQ0K
Pj4gMi4yMy4wDQo+Pg0KPiANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
