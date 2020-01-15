Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A514C33CB1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 06:17:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65BE24671
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 06:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h3Vf8q97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65BE24671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BCD06E029;
	Wed, 15 Jan 2020 06:17:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D896E029
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 06:16:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e216qsOjjtcEeU8CwDqtS9SEz/kL9459wz2EmnWTuKgOIyWbQnkQK9vmVoLh9BE5WUeNkewo5AZQrdNTqJ/burFewAxd3fOWOo86P1SCwCNGs9UPcZF6DUCLjiTXhCIZiupuIDwHsC5IFs1Jehr08nCWRokgo77KfoF04n0e4q4QvAaZdOzfhPlbJ+FE327cVmsAoPa0Iq+5+RTcrhqkEr3UmhmwzF7TxzYxoJCx11cvxEXUM/p6Q+Jjz5glcKjvhmXBKn52IYw2ok5L4SY2E1UhoLMGb1F0SeFcZZ1V3DaSjYL57U9ah/sxgs+rnht6EuYjluD3BRuBT67guKxt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCTM/QBbtZDT03SFLDTEtEOKM6mE7K1E6cvxdX8P/78=;
 b=R9JY7Z//Islo8dhiogIe474BG4RpbRq+Tpbhxr4uPfulXGQwF++/zAxyp/CFGPfvs504jEnzzY54zVcNWVbavVULCjFItDeJyoQIJICWc2XBCs05SKd7cLoCpT4aRHvWjnOK8JmVH582rH4T5ovM67CcuVazjSBd5ADEJ4bO9TrEXvQRqUDZtOpvej7qWEtchB82yVeJdIo7vs4mEqb/i7m72bWZPP101ANNqBK7KUFFx//YqHs1Q16gTKvrgSNshD3yPC3CnHFs+/PFuSEcURpcGeyt3qTgtkVYiKzJwuojOqglGQsZzio8Lzit7yh9lr7bYIR6goJndsSau+/EHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCTM/QBbtZDT03SFLDTEtEOKM6mE7K1E6cvxdX8P/78=;
 b=h3Vf8q97JgPZbEq+zwwlcPWnVjqIU1Fmepslbmy+CHlAfJ9s3azAdFZBu0JmNzy35cYLeT8u5D+Iaq4xeBj7Jecv7qr09jugkF1vvut0ZiWk3J3j9vJJ6PwSQNXsnvUyJjqhw7C2pB0Mb1tSaPe8eff9b5NNLtRAU9ud5IcnTc0=
Received: from CH2PR12MB3767.namprd12.prod.outlook.com (52.132.244.213) by
 CH2PR12MB4310.namprd12.prod.outlook.com (20.180.6.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Wed, 15 Jan 2020 06:16:55 +0000
Received: from CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::703e:37ee:ddb1:d321]) by CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::703e:37ee:ddb1:d321%3]) with mapi id 15.20.2623.015; Wed, 15 Jan 2020
 06:16:55 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix modprobe failure of the secondary GPU
 when GDDR6 training enabled(V5)
Thread-Topic: [PATCH] drm/amdgpu: fix modprobe failure of the secondary GPU
 when GDDR6 training enabled(V5)
Thread-Index: AQHVybYWZxdk0iSS/Uu7lmK88GItyKfrQ1Fg
Date: Wed, 15 Jan 2020 06:16:55 +0000
Message-ID: <CH2PR12MB3767B17455BCCB1749B973BBFE370@CH2PR12MB3767.namprd12.prod.outlook.com>
References: <20200113020627.9976-1-tianci.yin@amd.com>
In-Reply-To: <20200113020627.9976-1-tianci.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Feifei.Xu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2616efc9-f459-4a87-c4e0-08d799828511
x-ms-traffictypediagnostic: CH2PR12MB4310:|CH2PR12MB4310:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB431084DDC98047E95899E51BFE370@CH2PR12MB4310.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(189003)(199004)(2906002)(316002)(66574012)(110136005)(54906003)(76116006)(66446008)(66476007)(66556008)(64756008)(66946007)(71200400001)(26005)(81166006)(4326008)(33656002)(53546011)(6506007)(86362001)(81156014)(52536014)(478600001)(186003)(9686003)(55016002)(8936002)(5660300002)(7696005)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4310;
 H:CH2PR12MB3767.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r+uR87RJeZ9xlJVRbdu1tvN5sBLVK5pPPUsaHDRmghdIzxFTNrLbvnOowMZJLlVGNVUAN+oIbiIoOHKtY3Vmojv3O4gKI+567gxOfGQ3Hg9a8kF7G+6zxVDKXUHocPzdTOxZunR7yAz4047z6B6n+MQ1h8TWypih0qxUsVmZYUCcMJbjEizy8Abcz/IE7XiPC5oyhC7CY1c4XgBcln6PdxRNFwvM9CADtpyXmnKnKJj6HFSubvYSm978RtcOl5Te74m6RdRrXeTmUS9dE/43uTG3TZ4vCvFD/SgubOhqlnlNU516L+BMpXQr6MwOIqYHrNMmZXTVspIOUKqXzAXgdD+5T87d30/q/GZhZWvo1PwFxlPA2ShYcPLIn+9wQLlUnkr7v4Z7r9TyXG7YYE0EDkusnjnQFLJC63Iy9ObAcRbBb5hzxLRDchzrZqxz3X/r
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2616efc9-f459-4a87-c4e0-08d799828511
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 06:16:55.2407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 35T4TBC8Y2ajDvbFqTktCf0dyWIofBvPiq0fwZ15gTusEqAEvLo9XjHSdwVQcalI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Yin,
 Tianci \(Rico\)" <Tianci.Yin@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNClJldmlld2VkLWJ5OiBGZWlmZWkgWHUgPEZlaWZlaS5YdUBhbWQuY29tPg0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogVGlhbmNpIFlpbiA8dGlhbmNpLnlpbkBhbWQuY29t
PiANClNlbnQ6IE1vbmRheSwgSmFudWFyeSAxMywgMjAyMCAxMDowNiBBTQ0KVG86IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogVHVpa292LCBMdWJlbiA8THViZW4uVHVpa292QGFt
ZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIEhhd2tp
bmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IFh1LCBGZWlmZWkgPEZlaWZlaS5YdUBhbWQuY29t
PjsgWXVhbiwgWGlhb2ppZSA8WGlhb2ppZS5ZdWFuQGFtZC5jb20+OyBMb25nLCBHYW5nIDxHYW5n
LkxvbmdAYW1kLmNvbT47IFdhbmcsIEtldmluKFlhbmcpIDxLZXZpbjEuV2FuZ0BhbWQuY29tPjsg
WWluLCBUaWFuY2kgKFJpY28pIDxUaWFuY2kuWWluQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hd
IGRybS9hbWRncHU6IGZpeCBtb2Rwcm9iZSBmYWlsdXJlIG9mIHRoZSBzZWNvbmRhcnkgR1BVIHdo
ZW4gR0REUjYgdHJhaW5pbmcgZW5hYmxlZChWNSkNCg0KRnJvbTogIlRpYW5jaS5ZaW4iIDx0aWFu
Y2kueWluQGFtZC5jb20+DQoNClt3aHldDQpJbiBkdWFsIEdQVXMgc2NlbmFyaW8sIHN0b2xlbl9z
aXplIGlzIGFzc2lnbmVkIHRvIHplcm8gb24gdGhlIHNlY29uZGFyeSBHUFUsIHNpbmNlIHRoZXJl
IGlzIG5vIHByZS1PUyBjb25zb2xlIHVzaW5nIHRoYXQgbWVtb3J5LiBUaGVuIHRoZSBib3R0b20g
cmVnaW9uIG9mIFZSQU0gd2FzIGFsbG9jYXRlZCBhcyBHVFQsIHVuZm9ydHVuYXRlbHkgYSBzbWFs
bCByZWdpb24gb2YgYm90dG9tIFZSQU0gd2FzIGVuY3JvYWNoZWQgYnkgVU1DIGZpcm13YXJlIGR1
cmluZyBHRERSNiBCSVNUIHRyYWluaW5nLCB0aGlzIGNhdXNlIHBhZ2UgZmF1bHQuDQoNCltob3dd
DQpGb3JjaW5nIHN0b2xlbl9zaXplIHRvIDNNQiwgdGhlbiB0aGUgYm90dG9tIHJlZ2lvbiBvZiBW
UkFNIHdhcyBhbGxvY2F0ZWQgYXMgc3RvbGVuIG1lbW9yeSwgR1RUIGNvcnJ1cHRpb24gYXZvaWQu
DQoNCkNoYW5nZS1JZDogSTMxMGE3MmJhMDQwMjk5NGRlZmJlNTA4Mzk4NDJhOGVkYjAyNWE4NjgN
ClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
DQpTaWduZWQtb2ZmLWJ5OiBUaWFuY2kuWWluIDx0aWFuY2kueWluQGFtZC5jb20+DQotLS0NCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmggfCAgNSArKysrKyAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgIHwgMjcgKysrKysrKysrKysrKysrKysr
KysrKysrLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5o
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oDQppbmRleCBjOTFkZDYw
MmQ1ZjEuLmVkZTRhMGVhMGM4NCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nbWMuaA0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2dtYy5oDQpAQCAtNjAsNiArNjAsMTEgQEANCiAgKi8NCiAjZGVmaW5lIEFNREdQVV9HTUNfRkFV
TFRfVElNRU9VVAk1MDAwVUxMDQogDQorLyoNCisgKiBEZWZhdWx0IHN0b2xlbiBtZW1vcnkgc2l6
ZSwgMTAyNCAqIDc2OCAqIDQgICovDQorI2RlZmluZSBBTURHUFVfU1RPTEVOX0JJU1RfVFJBSU5J
TkdfREVGQVVMVF9TSVpFCTB4MzAwMDAwVUxMDQorDQogc3RydWN0IGZpcm13YXJlOw0KIA0KIC8q
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYw0KaW5kZXggNWFkODliYjZmM2Jh
Li4wNDAxNzA1N2Y4Y2EgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjEwXzAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMN
CkBAIC01NjYsNyArNTY2LDEyIEBAIHN0YXRpYyBpbnQgZ21jX3YxMF8wX2xhdGVfaW5pdCh2b2lk
ICpoYW5kbGUpDQogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICopaGFuZGxlOw0KIAlpbnQgcjsNCiANCi0JYW1kZ3B1X2JvX2xhdGVfaW5pdChhZGV2
KTsNCisJLyoNCisJICogQ2FuJ3QgZnJlZSB0aGUgc3RvbGVuIFZHQSBtZW1vcnkgd2hlbiBpdCBt
aWdodCBiZSB1c2VkIGZvciBtZW1vcnkNCisJICogdHJhaW5pbmcgYWdhaW4uDQorCSAqLw0KKwlp
ZiAoIWFkZXYtPmZ3X3ZyYW1fdXNhZ2UubWVtX3RyYWluX3N1cHBvcnQpDQorCQlhbWRncHVfYm9f
bGF0ZV9pbml0KGFkZXYpOw0KIA0KIAlyID0gYW1kZ3B1X2dtY19hbGxvY2F0ZV92bV9pbnZfZW5n
KGFkZXYpOw0KIAlpZiAocikNCkBAIC03NTAsNiArNzU1LDE5IEBAIHN0YXRpYyBpbnQgZ21jX3Yx
MF8wX3N3X2luaXQodm9pZCAqaGFuZGxlKQ0KIA0KIAlhZGV2LT5nbWMuc3RvbGVuX3NpemUgPSBn
bWNfdjEwXzBfZ2V0X3ZiaW9zX2ZiX3NpemUoYWRldik7DQogDQorCS8qDQorCSAqIEluIGR1YWwg
R1BVcyBzY2VuYXJpbywgc3RvbGVuX3NpemUgaXMgYXNzaWduZWQgdG8gemVybyBvbiB0aGUNCisJ
ICogc2Vjb25kYXJ5IEdQVSwgc2luY2UgdGhlcmUgaXMgbm8gcHJlLU9TIGNvbnNvbGUgdXNpbmcg
dGhhdCBtZW1vcnkuDQorCSAqIFRoZW4gdGhlIGJvdHRvbSByZWdpb24gb2YgVlJBTSB3YXMgYWxs
b2NhdGVkIGFzIEdUVCwgdW5mb3J0dW5hdGVseSBhDQorCSAqIHNtYWxsIHJlZ2lvbiBvZiBib3R0
b20gVlJBTSB3YXMgZW5jcm9hY2hlZCBieSBVTUMgZmlybXdhcmUgZHVyaW5nDQorCSAqIEdERFI2
IEJJU1QgdHJhaW5pbmcsIHRoaXMgY2F1c2UgcGFnZSBmYXVsdC4NCisJICogVGhlIHBhZ2UgZmF1
bHQgY2FuIGJlIGZpeGVkIGJ5IGZvcmNpbmcgc3RvbGVuX3NpemUgdG8gM01CLCB0aGVuIHRoZQ0K
KwkgKiBib3R0b20gcmVnaW9uIG9mIFZSQU0gd2FzIGFsbG9jYXRlZCBhcyBzdG9sZW4gbWVtb3J5
LCBHVFQgY29ycnVwdGlvbg0KKwkgKiBhdm9pZC4NCisJICovDQorCWFkZXYtPmdtYy5zdG9sZW5f
c2l6ZSA9IG1heChhZGV2LT5nbWMuc3RvbGVuX3NpemUsDQorCQkJCSAgICBBTURHUFVfU1RPTEVO
X0JJU1RfVFJBSU5JTkdfREVGQVVMVF9TSVpFKTsNCisNCiAJLyogTWVtb3J5IG1hbmFnZXIgKi8N
CiAJciA9IGFtZGdwdV9ib19pbml0KGFkZXYpOw0KIAlpZiAocikNCkBAIC03ODksNiArODA3LDEz
IEBAIHN0YXRpYyB2b2lkIGdtY192MTBfMF9nYXJ0X2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpICBzdGF0aWMgaW50IGdtY192MTBfMF9zd19maW5pKHZvaWQgKmhhbmRsZSkgIHsNCiAJ
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5k
bGU7DQorCXZvaWQgKnN0b2xlbl92Z2FfYnVmOw0KKw0KKwkvKg0KKwkgKiBGcmVlIHRoZSBzdG9s
ZW4gbWVtb3J5IGlmIGl0IHdhc24ndCBhbHJlYWR5IGZyZWVkIGluIGxhdGVfaW5pdA0KKwkgKiBi
ZWNhdXNlIG9mIG1lbW9yeSB0cmFpbmluZy4NCisJICovDQorCWFtZGdwdV9ib19mcmVlX2tlcm5l
bCgmYWRldi0+c3RvbGVuX3ZnYV9tZW1vcnksIE5VTEwsIA0KKyZzdG9sZW5fdmdhX2J1Zik7DQog
DQogCWFtZGdwdV92bV9tYW5hZ2VyX2ZpbmkoYWRldik7DQogCWdtY192MTBfMF9nYXJ0X2Zpbmko
YWRldik7DQotLQ0KMi4xNy4xDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
