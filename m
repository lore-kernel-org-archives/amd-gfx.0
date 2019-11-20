Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E7FC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 13:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D71792251D
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 13:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71792251D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4CE56E5CF;
	Wed, 20 Nov 2019 13:18:19 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730045.outbound.protection.outlook.com [40.107.73.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 810B56E5CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 13:18:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wsj2oxiQijnU6J0GloCLxd6/QlyI9JljhutxY7sIqq9d4uewbMHHO+B/RBLZhfuQwG6KiLLWdl7tU7H7b7yh+Ls8gPX7nnUvzZCBJzVKj7D1kgmp0aVNZnxGXk0HtuXl6E4VB9E/TlXVWplMMBjvv4A7CC/eEND1oWZCpVO7clkN1Bt+z8DlmpA7WgRbf8c1yTQJ0EWVCXU2voIYsHpQS7AJfqGzzBDXrfZrDK1AZoJix4fFXBzzJMHIC/hWQfZtDiyMkcP12HYD7eOP9n/MrjuKwF+EuVO6Q9JuTieCaXButQaPJEgGkgKM7hgSMkS/s3IsobEsuH57oGK6W7sqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPvKj369wXWzFmAFvkzBtu2uaMrHJNXFPvaQ2Jo+42k=;
 b=EvLxWvg8E3VZu2by7EEXDsQk1sFVeogv7AENonI8+T/OQ7NN2GIxKP28y3BPUFwJES23cC8JBjAH4PE4CLvhDveV3tRKITGfhvJAMscP0fwla41sGgEThk8ZCsiT8dqDFJ9VKLvyilCFVCtd79cwOuuQAJASxRWQnlgXoj0Hh2RB+fb1BoOIaCRMTiT53tB1XHY2fXK2wREcODzkXcLQ2rK5Mkt/VOcB2gKE8dnjMCm5lgBnuOsYMPse24n7J+meoBg+wPtrkf6VDl+J5OCYIt62duqyo1YIlwV/6eYhuX0yM7V0yUSAXFzdB5fVVGNcBX2ql0+wJLoBT3kEGCP7/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (10.255.236.82) by
 MN2PR12MB3215.namprd12.prod.outlook.com (20.179.82.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Wed, 20 Nov 2019 13:18:15 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::bc8a:52c5:e1d:e90d]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::bc8a:52c5:e1d:e90d%3]) with mapi id 15.20.2451.029; Wed, 20 Nov 2019
 13:18:15 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Xiao, Jack" <Jack.Xiao@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Huang, Shimmer"
 <Xinmei.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1OiBpbnZhbGlkYXRlIG1t?=
 =?utf-8?Q?hub_semphore_workaround_in_amdgpu=5Fvirt?=
Thread-Topic: [PATCH 1/2] drm/amdgpu: invalidate mmhub semphore workaround in
 amdgpu_virt
Thread-Index: AQHVn4cQABau01mATkmxBHHNdjn5AaeUCOKA
Date: Wed, 20 Nov 2019 13:18:14 +0000
Message-ID:
 <MN2PR12MB3933863C8DFCE1F68A44EFFA844F0@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <20191120091418.26526-1-changfeng.zhu@amd.com>
In-Reply-To: <20191120091418.26526-1-changfeng.zhu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad17babd-d58e-4122-526a-08d76dbc19d7
x-ms-traffictypediagnostic: MN2PR12MB3215:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB32150E9A2E5A300910FB51B3844F0@MN2PR12MB3215.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(14454004)(6116002)(6306002)(55016002)(3846002)(4326008)(66066001)(186003)(2906002)(2501003)(86362001)(7736002)(74316002)(25786009)(305945005)(71200400001)(71190400001)(52536014)(66946007)(64756008)(66476007)(66446008)(66556008)(478600001)(256004)(14444005)(966005)(6436002)(224303003)(76176011)(99286004)(9686003)(33656002)(5660300002)(26005)(110136005)(11346002)(102836004)(6506007)(76116006)(486006)(446003)(81156014)(81166006)(8936002)(316002)(7696005)(476003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3215;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UwDoXkCgT7w4TG1GxRebWFJY66Aa3RdbzG8d5ORuQcNmRRdDBGX90DPPEF7Z2aAAsFJee7iIl6P3FPyRYqH83/K1Vg6jDtJcSdmgDXiHrSZ3YIfB6e/4N9Ur+pts7uy8soabfHZcXVv3p0BYOh1+xJvWLVMURX7WuO7wAFTpNp5xhGcamdP/DBHxCwWoxKSGX5rmH4RhjG/Z9AbZ5VsGquLvIQtpMpOQsq2NWpTXTLEIvwHdfyqq3wpr7wkNeOq3RPJb0/kbD9y75Mp7qvkBN1OZLeRbVzicxAQGoahlGpSPd37FmSs14Cm/gtWt/tQhS9FGt6awB8vCPPJu8SHn5k/QxiB19XcF4MMkus4QbC3dTgMpR8X6tIEuglu0BFpDQV0sYgsKX/3VQSKp+SZIffWVYgVVmArBjLK3sSHlX9zxRDIrtOLFn55kb8NUPnCN
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad17babd-d58e-4122-526a-08d76dbc19d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 13:18:14.9716 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EuO5Tlt7hPTIUuKBzlcfZv8r00rCl8ZUwEGtGGeBNEIhB/lx/pyYfobCkkrmyeRN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3215
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPvKj369wXWzFmAFvkzBtu2uaMrHJNXFPvaQ2Jo+42k=;
 b=euFRWvPYtrXNacqZu42gVCu8HIm3YD1J9kLk6mwhA12qvk/y7Hr/5ooa8Fi+m1HM5r6vUHUKtMlXnz5OVAUtOTLHqCtZZp35oTQ8HXSwPTIAq8cTBLk9y2ldi/YA1+8C/umVEtVj92/Ezfv33pWHFFwzwl8yZL/J/9ZN7CBb2T8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
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
Cc: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120131814.U8gcVVfb9QjYEzjIOFfcRYjLtY0zrHuRGQ0BstVcXWc@z>

SGkgQ2hhbmdmZW5nIA0KDQpGaXJzIG9mIGFsbCwgdGhlcmUgaXMgbm8gcG93ZXItZ2F0aW5nIG9m
ZiBjaXJjbGUgaW52b2x2ZWQgaW4gQU1ER1BVIFNSSU9WLCBzaW5jZSB3ZSBkb24ndCBhbGxvdyBW
Ri9WTSBkbyBzdWNoIHRoaW5ncyBzbyBJIGRvIGZlZWwgc3RyYW5nZSB3aHkgeW91IHBvc3Qgc29t
ZXRoaW5nIGxpa2UgdGhpcyANCkVzcGVjaWFsbHkgb24gVkVHQTEwIHNlcmlhbHMgd2hpY2ggbG9v
a3MgZG9lc24ndCBoYXZlIGFueSBpc3N1ZSBvbiB0aG9zZSBncHVfZmx1c2ggcGFydCANCg0KSGVy
ZSBpcyBteSBxdWVzdGlvbnMgZm9yIHlvdToNCjEpIENhbiB5b3UgcG9pbnQgbWUgd2hhdCBpc3N1
ZSBoYWQgeW91IGJlZW4gZXhwZXJpZW5jZWQgPyBhbmQgaG93IHRvIHJlcHJvIHRoZSBidWcNCjIp
IGlmIHlvdSBkbyBoaXQgc29tZSBpc3N1ZXMsIGRpZCB5b3UgdmVyaWZpZWQgdGhhdCB5b3VyIHBh
dGNoIGNhbiBmaXggaXQgPw0KDQpiZXNpZGVzDQoNCi9Nb25rDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2
LS0tLS0NCuWPkeS7tuS6ujogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4g5Luj6KGoIENoYW5nZmVuZy5aaHUNCuWPkemAgeaXtumXtDogMjAxOeW5tDEx5pyI
MjDml6UgMTc6MTQNCuaUtuS7tuS6ujogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2Vu
aWdAYW1kLmNvbT47IFhpYW8sIEphY2sgPEphY2suWGlhb0BhbWQuY29tPjsgWmhvdTEsIFRhbyA8
VGFvLlpob3UxQGFtZC5jb20+OyBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47IEh1YW5n
LCBTaGltbWVyIDxYaW5tZWkuSHVhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQrmioTpgIE6IFpodSwgQ2hhbmdmZW5nIDxDaGFuZ2ZlbmcuWmh1QGFtZC5jb20+DQrk
uLvpopg6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IGludmFsaWRhdGUgbW1odWIgc2VtcGhvcmUg
d29ya2Fyb3VuZCBpbiBhbWRncHVfdmlydA0KDQpGcm9tOiBjaGFuZ3podSA8Q2hhbmdmZW5nLlpo
dUBhbWQuY29tPg0KDQpJdCBtYXkgbG9zZSBncHV2bSBpbnZhbGlkYXRlIGFja25vd2xkZWdlIHN0
YXRlIGFjcm9zcyBwb3dlci1nYXRpbmcgb2ZmIGN5Y2xlLiBUbyBhdm9pZCB0aGlzIGlzc3VlIGlu
IHZpcnQgaW52YWxpZGF0aW9uLCBhZGQgc2VtYXBob3JlIGFjcXVpcmUgYmVmb3JlIGludmFsaWRh
dGlvbiBhbmQgc2VtYXBob3JlIHJlbGVhc2UgYWZ0ZXIgaW52YWxpZGF0aW9uLg0KDQpDaGFuZ2Ut
SWQ6IEllOTgzMDRlNDc1MTY2YjUzZWVkMDMzNDYyZDc2NDIzYjZiMGZjMjViDQpTaWduZWQtb2Zm
LWJ5OiBjaGFuZ3podSA8Q2hhbmdmZW5nLlpodUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYyB8IDI2ICsrKysrKysrKysrKysrKysrKysrKyst
LSAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuaCB8ICAzICsrLQ0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgICAgfCAgMyArKy0NCiAzIGZpbGVz
IGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYw0KaW5kZXggZjA0ZWIxYTY0MjcxLi43MGZmYWY5
MWNkMTIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmly
dC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jDQpAQCAt
MTM1LDcgKzEzNSw4IEBAIHZvaWQgYW1kZ3B1X3ZpcnRfa2lxX3dyZWcoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsIHVpbnQzMl90IHJlZywgdWludDMyX3QgdikNCiANCiB2b2lkIGFtZGdwdV92
aXJ0X2tpcV9yZWdfd3JpdGVfcmVnX3dhaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQog
CQkJCQl1aW50MzJfdCByZWcwLCB1aW50MzJfdCByZWcxLA0KLQkJCQkJdWludDMyX3QgcmVmLCB1
aW50MzJfdCBtYXNrKQ0KKwkJCQkJdWludDMyX3QgcmVmLCB1aW50MzJfdCBtYXNrLA0KKwkJCQkJ
dWludDMyX3Qgc2VtKQ0KIHsNCiAJc3RydWN0IGFtZGdwdV9raXEgKmtpcSA9ICZhZGV2LT5nZngu
a2lxOw0KIAlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSAma2lxLT5yaW5nOyBAQCAtMTQ0LDkg
KzE0NSwzMCBAQCB2b2lkIGFtZGdwdV92aXJ0X2tpcV9yZWdfd3JpdGVfcmVnX3dhaXQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQogCXVpbnQzMl90IHNlcTsNCiANCiAJc3Bpbl9sb2NrX2ly
cXNhdmUoJmtpcS0+cmluZ19sb2NrLCBmbGFncyk7DQotCWFtZGdwdV9yaW5nX2FsbG9jKHJpbmcs
IDMyKTsNCisJYW1kZ3B1X3JpbmdfYWxsb2MocmluZywgNjApOw0KKw0KKwkvKg0KKwkgKiBJdCBt
YXkgbG9zZSBncHV2bSBpbnZhbGlkYXRlIGFja25vd2xkZWdlIHN0YXRlIGFjcm9zcyBwb3dlci1n
YXRpbmcNCisJICogb2ZmIGN5Y2xlLCBhZGQgc2VtYXBob3JlIGFjcXVpcmUgYmVmb3JlIGludmFs
aWRhdGlvbiBhbmQgc2VtYXBob3JlDQorCSAqIHJlbGVhc2UgYWZ0ZXIgaW52YWxpZGF0aW9uIHRv
IGF2b2lkIGVudGVyaW5nIHBvd2VyIGdhdGVkIHN0YXRlDQorCSAqIHRvIFdBIHRoZSBJc3N1ZQ0K
KwkgKi8NCisNCisJLyogYSByZWFkIHJldHVybiB2YWx1ZSBvZiAxIG1lYW5zIHNlbWFwaG9yZSBh
Y3VxaXJlICovDQorCWlmIChyaW5nLT5mdW5jcy0+dm1odWIgPT0gQU1ER1BVX01NSFVCXzAgfHwN
CisJICAgIHJpbmctPmZ1bmNzLT52bWh1YiA9PSBBTURHUFVfTU1IVUJfMSkNCisJYW1kZ3B1X3Jp
bmdfZW1pdF9yZWdfd2FpdChyaW5nLCBzZW0sIDB4MSwgMHgxKTsNCisNCiAJYW1kZ3B1X3Jpbmdf
ZW1pdF9yZWdfd3JpdGVfcmVnX3dhaXQocmluZywgcmVnMCwgcmVnMSwNCiAJCQkJCSAgICByZWYs
IG1hc2spOw0KKwkvKg0KKwkgKiBhZGQgc2VtYXBob3JlIHJlbGVhc2UgYWZ0ZXIgaW52YWxpZGF0
aW9uLA0KKwkgKiB3cml0ZSB3aXRoIDAgbWVhbnMgc2VtYXBob3JlIHJlbGVhc2UNCisJICovDQor
CWlmIChyaW5nLT5mdW5jcy0+dm1odWIgPT0gQU1ER1BVX01NSFVCXzAgfHwNCisJICAgIHJpbmct
PmZ1bmNzLT52bWh1YiA9PSBBTURHUFVfTU1IVUJfMSkNCisJYW1kZ3B1X3JpbmdfZW1pdF93cmVn
KHJpbmcsIHNlbSwgMCk7DQorDQogCWFtZGdwdV9mZW5jZV9lbWl0X3BvbGxpbmcocmluZywgJnNl
cSk7DQogCWFtZGdwdV9yaW5nX2NvbW1pdChyaW5nKTsNCiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgma2lxLT5yaW5nX2xvY2ssIGZsYWdzKTsgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdmlydC5oDQppbmRleCBiMGIyYmRjNzUwZGYuLmJkYTZhMmYzN2RjMCAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmgNCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmgNCkBAIC0yOTUsNyArMjk1LDggQEAgdWlu
dDMyX3QgYW1kZ3B1X3ZpcnRfa2lxX3JyZWcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVp
bnQzMl90IHJlZyk7ICB2b2lkIGFtZGdwdV92aXJ0X2tpcV93cmVnKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LCB1aW50MzJfdCByZWcsIHVpbnQzMl90IHYpOyAgdm9pZCBhbWRncHVfdmlydF9r
aXFfcmVnX3dyaXRlX3JlZ193YWl0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KIAkJCQkJ
dWludDMyX3QgcmVnMCwgdWludDMyX3QgcnJlZzEsDQotCQkJCQl1aW50MzJfdCByZWYsIHVpbnQz
Ml90IG1hc2spOw0KKwkJCQkJdWludDMyX3QgcmVmLCB1aW50MzJfdCBtYXNrLA0KKwkJCQkJdWlu
dDMyX3Qgc2VtKTsNCiBpbnQgYW1kZ3B1X3ZpcnRfcmVxdWVzdF9mdWxsX2dwdShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwgYm9vbCBpbml0KTsgIGludCBhbWRncHVfdmlydF9yZWxlYXNlX2Z1
bGxfZ3B1KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBib29sIGluaXQpOyAgaW50IGFtZGdw
dV92aXJ0X3Jlc2V0X2dwdShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ21jX3Y5XzAuYw0KaW5kZXggZjI1Y2Q5N2JhNWYyLi4xYWU1OWFmNzgzNmEg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jDQorKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jDQpAQCAtNDQ4LDkgKzQ0OCwx
MCBAQCBzdGF0aWMgdm9pZCBnbWNfdjlfMF9mbHVzaF9ncHVfdGxiKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LCB1aW50MzJfdCB2bWlkLA0KIAkJCSFhZGV2LT5pbl9ncHVfcmVzZXQpIHsNCiAJ
CXVpbnQzMl90IHJlcSA9IGh1Yi0+dm1faW52X2VuZzBfcmVxICsgZW5nOw0KIAkJdWludDMyX3Qg
YWNrID0gaHViLT52bV9pbnZfZW5nMF9hY2sgKyBlbmc7DQorCQl1aW50MzJfdCBzZW0gPSBodWIt
PnZtX2ludl9lbmcwX3NlbSArIGVuZzsNCiANCiAJCWFtZGdwdV92aXJ0X2tpcV9yZWdfd3JpdGVf
cmVnX3dhaXQoYWRldiwgcmVxLCBhY2ssIHRtcCwNCi0JCQkJMSA8PCB2bWlkKTsNCisJCQkJCQkg
ICAxIDw8IHZtaWQsIHNlbSk7DQogCQlyZXR1cm47DQogCX0NCiANCi0tDQoyLjE3LjENCg0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmFtZC1nZnggbWFp
bGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
