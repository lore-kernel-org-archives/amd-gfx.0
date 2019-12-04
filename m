Return-Path: <SRS0=SH5p=Z2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CFAC43603
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 10:14:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71070205ED
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 10:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71070205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 073EE73321;
	Wed,  4 Dec 2019 10:14:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F6073113
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2019 10:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuZKY+vuiLPUl4yJbvRSSwKcmKInq0ZS35zWA4Qca/kq8LiUfv6iZHTMckLTQjuXvUkcAcbyEHq6a0FtNEHDNNN02knIsDxRPCdnTJWrKGxU30jEC2h+0Yy3OG4t1ygoDZz2u8qPDCfQQA3St5uzIxWeRKYhQL8bGdxzykmthS/QfR6g60ox9vvKQ6iY2EDmQfPH0weojCduMEbGQz6OT5rUS9vrVxaAvP0Dp2b19i6KdUv+UTl9/XF1uImnoS3F5psO1ATkT7GTBdKpVGM6ZJkCDTwoBcMVwZM1Ex+OMEBbjSTJZ+QcHDEl9MnH+Voacm75lrn8VxdoNlLKklTFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDfXQNDWzkEMpazi4xZYfB7PAOrCsuS8ZyTbfAcFZNQ=;
 b=i5fgqluri035WVmPNiJB+nxxcHSv4nBIfi1t6Q8jVQvq44x07VAotkFtP1hIpcTN7YjieaSq+HqSuVvw0wOF9U8tHqFIYfAH3omct39vtSKCm6GDDRe6BO02qNQO7gJnV3YIiACf74bl3ezAb43Jx3pvJF80qdTYaO/0H9DOVjMACibBx1diF5fimQqN2i1pdy5ke1MbbTC5GHUD5nEs5QA1mQ1HGjDiazk/ZqXyPD+6B9Fqp4MhoBZm/pa0FPNQTLL8dRqxoXHmidkMcZDlY70Nbh1T1rzJvGa2pxBHyYuBe3UK4auet9lGau+9Y4jxO8q7wVc+ZP6c5oYBQMVHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB4288.namprd12.prod.outlook.com (52.135.48.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 4 Dec 2019 10:14:18 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::58ae:be91:c063:b2a1]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::58ae:be91:c063:b2a1%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 10:14:18 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: pre-check the SMU state before
 issuing message
Thread-Topic: [PATCH 2/2] drm/amd/powerplay: pre-check the SMU state before
 issuing message
Thread-Index: AQHVqojJa1r3rCrDAkKyOg7DBmduB6epwhqA
Date: Wed, 4 Dec 2019 10:14:18 +0000
Message-ID: <CDE97C86-24CB-45A6-8913-97CD34C8127E@amd.com>
References: <20191204095339.25497-1-evan.quan@amd.com>
 <20191204095339.25497-2-evan.quan@amd.com>
In-Reply-To: <20191204095339.25497-2-evan.quan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [101.88.26.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7fef0f4d-254c-4646-0e94-08d778a2b921
x-ms-traffictypediagnostic: MN2PR12MB4288:|MN2PR12MB4288:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB42885E64846659BC88C5BB4D8E5D0@MN2PR12MB4288.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(189003)(199004)(76176011)(81156014)(81166006)(2906002)(8936002)(8676002)(71190400001)(6636002)(64756008)(305945005)(71200400001)(25786009)(76116006)(36756003)(91956017)(66476007)(66946007)(66556008)(6512007)(6306002)(4326008)(6862004)(99286004)(5660300002)(14454004)(15650500001)(6246003)(86362001)(478600001)(966005)(45080400002)(2616005)(33656002)(229853002)(7736002)(6506007)(11346002)(26005)(102836004)(37006003)(186003)(316002)(6486002)(6116002)(6436002)(3846002)(66446008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4288;
 H:MN2PR12MB3598.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kncYSamXBXCoRuR9lznbyMwcpUVK0UsYFPS1esH4FmnPIo2ze0IgTCC/bGF1dGaCronUkrNfhobTkezCTkNvPYxg6zx+8PIpM1tPnyOVL0hgyAhtacxSaCM9DgfBJGjinNJovoVbrurMm5cl/8WlRTfgEU+JsYcZOsEGVz9/tfAYDPuwmZ/mZWrrGE+jGKhK/3OSBDMLRNL83SFlpcMZZfgUxpn8H3kJaEf2LehBAMpFd8KefPNHDbPwnh26/iTGH0Vd3E8K4t8HPBkQsWAkfUwkEJo7cN1KkbdWYKo+HxtJe5HR5uYwStLjYIl6VYr9539xn4ganTx+Fycm9QbcU8MGAazUdRvMEgYUJw9mp1O1K03bZD14PGzV7Puv0y5fGQlBQOAuuzXYBmqjXfjRvmnNVNqOcD/eRYteALp+ZdK0HTHALfnkpm8RYY1LXLVaNHKaWmzi56LL6ubjgk8xmWn/5W50tr7TauDp+cq9bXU=
Content-ID: <3E68F4FC73978E4BA6F818AD8D1627A5@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fef0f4d-254c-4646-0e94-08d778a2b921
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 10:14:18.0621 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iFE45IcWmutxK8+t44GI/HcambURcwmDejpvfsPur1K8+GqV5DnUtVybq+O6QgKY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDfXQNDWzkEMpazi4xZYfB7PAOrCsuS8ZyTbfAcFZNQ=;
 b=ldcMGYV9QqzYsDFXdiMPRkIZP8cApZzMKUG/uKE7t1hVHNkfoCdxhwL1LQe5zsBbUtYg4bf0oU1fNZNvjniWWWip/VYsGwKMyz7wBLnuDMntFL9BHbz2O7cw4dbvR4vFcIQW2+BdFfgt50USAKwCxBc8b7cNmXBfWI2uUHdJRGI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kenneth.Feng@amd.com; 
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgRXZhbiwNClRoZSBvcmlnaW5hbCBkZXNpZ24gaXMgYWxzbyBhYm9ydGluZyBzZW5kaW5nIHRo
ZSBtZXNzYWdlIGJlY2F1c2Ugb2YgYSDigJhicmVha+KAmSB0aGVyZS4NCllvdXIgcGF0Y2ggaXMg
Zm9yIGNvZGUgZmFjdG9yaW5nPw0KVGhhbmtzLg0KDQo+IOWcqCAyMDE55bm0MTLmnIg05pel77yM
5LiL5Y2INTo1M++8jEV2YW4gUXVhbiA8RXZhbi5RdWFuQGFtZC5jb20+IOWGmemBk++8mg0KPiAN
Cj4gW0NBVVRJT046IEV4dGVybmFsIEVtYWlsXQ0KPiANCj4gQWJvcnQgdGhlIG1lc3NhZ2UgaXNz
dWluZyBpZiB0aGUgU01VIHdhcyBub3QgaW4gdGhlIHJpZ2h0IHN0YXRlLg0KPiANCj4gQ2hhbmdl
LUlkOiBJZGE5ZjkxMWUwNTFmNmU3OGRlNGY0NzU5NTZjNzg2MzdlNTZlNmVhMw0KPiBTaWduZWQt
b2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPg0KPiAtLS0NCj4gZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMgfCAxNiArKysrKysrKy0tLS0tLS0tDQo+
IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTJfMC5jIHwgMTYgKysrKysrKyst
LS0tLS0tLQ0KPiAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Nt
dV92MTFfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMNCj4g
aW5kZXggMzI1ZWM0ODY0ZjkwLi5kODRjN2Y1ZmIwMWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jDQo+IEBAIC02OCwxNSArNjgsMTMgQEAgc3RhdGlj
IGludCBzbXVfdjExXzBfd2FpdF9mb3JfcmVzcG9uc2Uoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUp
DQo+ICAgICAgICBmb3IgKGkgPSAwOyBpIDwgdGltZW91dDsgaSsrKSB7DQo+ICAgICAgICAgICAg
ICAgIGN1cl92YWx1ZSA9IFJSRUczMl9TT0MxNShNUDEsIDAsIG1tTVAxX1NNTl9DMlBNU0dfOTAp
Ow0KPiAgICAgICAgICAgICAgICBpZiAoKGN1cl92YWx1ZSAmIE1QMV9DMlBNU0dfOTBfX0NPTlRF
TlRfTUFTSykgIT0gMCkNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiBjdXJfdmFsdWUgPT0gMHgxID8gMCA6IC1FSU87DQo+
ICsNCj4gICAgICAgICAgICAgICAgdWRlbGF5KDEpOw0KPiAgICAgICAgfQ0KPiANCj4gICAgICAg
IC8qIHRpbWVvdXQgbWVhbnMgd3JvbmcgbG9naWMgKi8NCj4gLSAgICAgICBpZiAoaSA9PSB0aW1l
b3V0KQ0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIC1FVElNRTsNCj4gLQ0KPiAtICAgICAgIHJl
dHVybiBSUkVHMzJfU09DMTUoTVAxLCAwLCBtbU1QMV9TTU5fQzJQTVNHXzkwKSA9PSAweDEgPyAw
IDogLUVJTzsNCj4gKyAgICAgICByZXR1cm4gLUVUSU1FOw0KPiB9DQo+IA0KPiBpbnQNCj4gQEAg
LTkyLDkgKzkwLDExIEBAIHNtdV92MTFfMF9zZW5kX21zZ193aXRoX3BhcmFtKHN0cnVjdCBzbXVf
Y29udGV4dCAqc211LA0KPiAgICAgICAgICAgICAgICByZXR1cm4gaW5kZXg7DQo+IA0KPiAgICAg
ICAgcmV0ID0gc211X3YxMV8wX3dhaXRfZm9yX3Jlc3BvbnNlKHNtdSk7DQo+IC0gICAgICAgaWYg
KHJldCkNCj4gLSAgICAgICAgICAgICAgIHByX2VycigiZmFpbGVkIHNlbmQgbWVzc2FnZTogJTEw
cyAoJWQpIFx0cGFyYW06IDB4JTA4eCByZXNwb25zZSAlI3hcbiIsDQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgc211X2dldF9tZXNzYWdlX25hbWUoc211LCBtc2cpLCBpbmRleCwgcGFyYW0sIHJl
dCk7DQo+ICsgICAgICAgaWYgKHJldCkgew0KPiArICAgICAgICAgICAgICAgcHJfZXJyKCJNc2cg
aXNzdWluZyBwcmUtY2hlY2sgZmFpbGVkIGFuZCAiDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IlNNVSBtYXkgYmUgbm90IGluIHRoZSByaWdodCBzdGF0ZSFcbiIpOw0KPiArICAgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCj4gKyAgICAgICB9DQo+IA0KPiAgICAgICAgV1JFRzMyX1NPQzE1KE1Q
MSwgMCwgbW1NUDFfU01OX0MyUE1TR185MCwgMCk7DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMl8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9zbXVfdjEyXzAuYw0KPiBpbmRleCA3ZjVmN2UxMmE0MWUuLmE2MzgzMjZiYTFi
NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMl8w
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMl8wLmMNCj4g
QEAgLTU2LDE1ICs1NiwxMyBAQCBpbnQgc211X3YxMl8wX3dhaXRfZm9yX3Jlc3BvbnNlKHN0cnVj
dCBzbXVfY29udGV4dCAqc211KQ0KPiAgICAgICAgZm9yIChpID0gMDsgaSA8IGFkZXYtPnVzZWNf
dGltZW91dDsgaSsrKSB7DQo+ICAgICAgICAgICAgICAgIGN1cl92YWx1ZSA9IFJSRUczMl9TT0Mx
NShNUDEsIDAsIG1tTVAxX1NNTl9DMlBNU0dfOTApOw0KPiAgICAgICAgICAgICAgICBpZiAoKGN1
cl92YWx1ZSAmIE1QMV9DMlBNU0dfOTBfX0NPTlRFTlRfTUFTSykgIT0gMCkNCj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBj
dXJfdmFsdWUgPT0gMHgxID8gMCA6IC1FSU87DQo+ICsNCj4gICAgICAgICAgICAgICAgdWRlbGF5
KDEpOw0KPiAgICAgICAgfQ0KPiANCj4gICAgICAgIC8qIHRpbWVvdXQgbWVhbnMgd3JvbmcgbG9n
aWMgKi8NCj4gLSAgICAgICBpZiAoaSA9PSBhZGV2LT51c2VjX3RpbWVvdXQpDQo+IC0gICAgICAg
ICAgICAgICByZXR1cm4gLUVUSU1FOw0KPiAtDQo+IC0gICAgICAgcmV0dXJuIFJSRUczMl9TT0Mx
NShNUDEsIDAsIG1tTVAxX1NNTl9DMlBNU0dfOTApID09IDB4MSA/IDAgOiAtRUlPOw0KPiArICAg
ICAgIHJldHVybiAtRVRJTUU7DQo+IH0NCj4gDQo+IGludA0KPiBAQCAtODAsOSArNzgsMTEgQEAg
c211X3YxMl8wX3NlbmRfbXNnX3dpdGhfcGFyYW0oc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQo+
ICAgICAgICAgICAgICAgIHJldHVybiBpbmRleDsNCj4gDQo+ICAgICAgICByZXQgPSBzbXVfdjEy
XzBfd2FpdF9mb3JfcmVzcG9uc2Uoc211KTsNCj4gLSAgICAgICBpZiAocmV0KQ0KPiAtICAgICAg
ICAgICAgICAgcHJfZXJyKCJGYWlsZWQgdG8gc2VuZCBtZXNzYWdlIDB4JXgsIHJlc3BvbnNlIDB4
JXgsIHBhcmFtIDB4JXhcbiIsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgaW5kZXgsIHJldCwg
cGFyYW0pOw0KPiArICAgICAgIGlmIChyZXQpIHsNCj4gKyAgICAgICAgICAgICAgIHByX2Vycigi
TXNnIGlzc3VpbmcgcHJlLWNoZWNrIGZhaWxlZCBhbmQgIg0KPiArICAgICAgICAgICAgICAgICAg
ICAgICJTTVUgbWF5IGJlIG5vdCBpbiB0aGUgcmlnaHQgc3RhdGUhXG4iKTsNCj4gKyAgICAgICAg
ICAgICAgIHJldHVybiByZXQ7DQo+ICsgICAgICAgfQ0KPiANCj4gICAgICAgIFdSRUczMl9TT0Mx
NShNUDEsIDAsIG1tTVAxX1NNTl9DMlBNU0dfOTAsIDApOw0KPiANCj4gLS0NCj4gMi4yNC4wDQo+
IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBo
dHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMl
M0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQt
Z2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NLZW5uZXRoLkZlbmclNDBhbWQuY29tJTdDMTM4M2YyNjYx
YjU4NGUwNGVkZjkwOGQ3Nzg5ZmVhZjUlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgz
ZCU3QzAlN0MwJTdDNjM3MTEwNTAwNTUxMDM2NDM4JmFtcDtzZGF0YT1RUVJZOGRzaVQlMkJQaW81
SSUyQiUyRjNFcnFMbllRTHh0NmhjeVhIZWRVNzltdVRJJTNEJmFtcDtyZXNlcnZlZD0wDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
