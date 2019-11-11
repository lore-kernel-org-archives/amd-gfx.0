Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0889C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 06:00:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B48206C3
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 06:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B48206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A6156E18F;
	Mon, 11 Nov 2019 06:00:36 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730073.outbound.protection.outlook.com [40.107.73.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC3C06E18F
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 06:00:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2ZYyz1Zi7a6DPXKam1Sn5e4k1pDAH/nSdJiEWs1QXTlNOgVdfPG6uVUde+/xFnY+DkQsQp7JCK+tKTbZ4eSoCaOUnCnG49/Lk2LnnWv1bek7J7/6mElHsZunS0j6o1IKrAktzFuh9dSUXDFli7rap7nRB+4MVex8oMYJosQfIoeQcVHVlReYEcU0bWzt4xf4rGHUSkKbRkH3g7sjQ3Y653rmLUfqpixr9cOGMusWgsYRsL2o2LfP4ccpM1pQVpVBfZKEOR8x8NR+ftBJg8xvpHiiqJEjNRssMjosPDyuh5wG+PLOFLZ4VUugrOPLiVOGVo5kAxLQDtagf5b2UGzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/cCyPMn+qA0ILyE1sahsWCxNfgThqO+XbpZZ3kH83Q=;
 b=Nc359lCCYLYAU0C6wzXluGLHilB4WI2up3IRBAooGk8YsrGjB8Xco0sbSgnzGSjAhWH/+bmhdj3x3oJKA5s/50H98OtQxs0kJImZpg7NuZ0qBcfmql5SPEj3cda/8jIr6FpoSKvkztZWvbyMyhknBhMCcrsU6Nk0NGcMLOFsmcZLhszGnVVDRuh3qcyUaDZv5vhDbktGcJ4ZxOTmilXlSCNB3UFeX9mY0/bMa0X+NoF2oyBxLV/NgZJRQZJLOR3K5lqDw9c1ZeuTlxbLunKSHybAmqx1pek+OhEeFBAoJsCo0fFPIR6RY2NvxNW3D8CWPwIoAKuC6NGyEu67MW+dMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB4285.namprd12.prod.outlook.com (52.135.49.140) by
 MN2PR12MB3086.namprd12.prod.outlook.com (20.178.241.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Mon, 11 Nov 2019 06:00:31 +0000
Received: from MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::1179:cf99:3822:58dd]) by MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::1179:cf99:3822:58dd%6]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 06:00:31 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: avoid upload corrupted ta ucode to psp
Thread-Topic: [PATCH] drm/amdgpu: avoid upload corrupted ta ucode to psp
Thread-Index: AQHVmEqoeg5BiK23g0GqfrN81zUGDqeFefZA
Date: Mon, 11 Nov 2019 06:00:30 +0000
Message-ID:
 <MN2PR12MB4285913B2858184D6A170487F6740@MN2PR12MB4285.namprd12.prod.outlook.com>
References: <20191111044402.11408-1-Hawking.Zhang@amd.com>
In-Reply-To: <20191111044402.11408-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9218476f-b73a-4f46-1290-08d7666c7596
x-ms-traffictypediagnostic: MN2PR12MB3086:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB30867BD63A5830F8F232C945F6740@MN2PR12MB3086.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(13464003)(189003)(199004)(66476007)(76176011)(6506007)(53546011)(229853002)(7696005)(102836004)(99286004)(66556008)(76116006)(6246003)(81166006)(81156014)(8676002)(66946007)(8936002)(64756008)(7736002)(74316002)(305945005)(66446008)(6116002)(66066001)(6636002)(33656002)(2906002)(3846002)(486006)(2501003)(5660300002)(52536014)(14444005)(11346002)(446003)(316002)(86362001)(110136005)(26005)(186003)(256004)(25786009)(6436002)(9686003)(478600001)(55016002)(71200400001)(476003)(71190400001)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3086;
 H:MN2PR12MB4285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wcJFJ93VVMk0iWEONyWebIPzYkiqeAcKEDs9gnLh0UWH9vNAzJ+vVF74bkOIDMYC4vtKqgpe0Qhpo8nJUv9Df+s5ToXL5nO1OjRbLma5k/hw/eSA/d7O0Ue530+m6kh7evsT7eYF6HBNb+OAXMIU5hLMJRuXdGdg441nrVjz/kxL1cMaBHd8BkDX0MfxoNTl1Cz90RX6qKyoC+phkhMWRNcXb4xC/GuaO9BxhWffXQwrYSU4BAgGYt8afoVxUb/k7Fm/XZtdNPjELbQyz90SNV2unjDFYAAjjsbCe4Io+NuTTf6aO5ai9FcHYFLTQueVj20j4jhr5+zZ1XxTn2Thy2xMo8JOZ4Yq+lIx3mBP/rTllj2VsE/K+6eL8xa69y9hPtOa6BKUATKjEwev98k7tmicpQaG9TBN6i3MpWMpXEoT1Srii8p5UKZa6/Uve0dJ
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9218476f-b73a-4f46-1290-08d7666c7596
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 06:00:31.0061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HWeRX8eZdnPKRXHPzBlvXk6Ukf2Y4rh1BxyUPYRUEQrKRmI2b2+1s1n04GCtvit3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3086
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/cCyPMn+qA0ILyE1sahsWCxNfgThqO+XbpZZ3kH83Q=;
 b=xxlVl65ez939J3TSo7F+cZrHlyB8sXP41qR/0w1GcpOGtbYSjpPpL1B0KKcBw0b9edicENAje4dD+kSZXrWdsBrxHmNBE/f1khuk9/KOWmjjrJd3acDUul0duHQQTGOX6x2h/Cj1PpBsJxjBQnF5VnKDmO6rT6K1wLwAFjSW+X8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Le.Ma@amd.com; 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111060030.lOmvEhEk--XN2dukJnp9Cb0YEV7Iwz6FRyuiKftNpTY@z>

UmV2aWV3ZWQtYnk6IExlIE1hIDxMZS5NYUBhbWQuY29tPgoKLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0KRnJvbTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPiAKU2VudDog
TW9uZGF5LCBOb3ZlbWJlciAxMSwgMjAxOSAxMjo0NCBQTQpUbzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT47IENsZW1lbnRzLCBKb2huIDxKb2huLkNsZW1lbnRzQGFtZC5jb20+OyBNYSwgTGUgPExlLk1h
QGFtZC5jb20+CkNjOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgpTdWJq
ZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IGF2b2lkIHVwbG9hZCBjb3JydXB0ZWQgdGEgdWNvZGUg
dG8gcHNwCgp4Z21pLCByYXMsIGhkY3AgYW5kIGR0bSB0YSBhcmUgYWN0dWFsbHkgc2VwYXJhdGVk
IHVjb2RlIGFuZCBuZWVkIHRvIGhhbmRsZWQgY2FzZSBieSBjYXNlIHRvIHVwbG9hZCB0byBwc3Au
CgpXZSBzdXBwb3J0IHRoZSBjYXNlIHRoYXQgdGEgYmluYXJ5IGhhdmUgb25lIG9yIG11bHRpcGxl
IG9mIHRoZW0gYnVpbHQtaW4uIEFzIGEgcmVzdWx0LCB0aGUgZHJpdmVyIHNob3VsZCBjaGVjayBl
YWNoIHRhIGJpbmFyaXkncyBhdmFpbGFibGl0eSBiZWZvcmUgZGVjaWRlIHRvIHVwbG9hZCB0aGVt
IHRvIHBzcC4KCkluIHRoZSB0ZXJtaW5hdGUgKHVubG9hZCkgY2FzZSwgdGhlIGRyaXZlciB3aWxs
IGNoZWNrIHRoZSBjb250ZXh0IHJlYWRpbmVzcyBiZWZvcmUgcGVyZm9ybSB1bmxvYWQgYWN0aXZp
dHkuIEl0J3MgZmluZSB0byBrZWVwIGl0IGFzIGlzLgoKQ2hhbmdlLUlkOiBJNDkzMTE2OTcwZmZi
NTU3ZjMzYzA2ZGUxMGY3ODY2ODRmZGNlZjg1YgpTaWduZWQtb2ZmLWJ5OiBIYXdraW5nIFpoYW5n
IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3BzcC5jIHwgMjIgKysrKysrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQs
IDIxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcHNwLmMKaW5kZXggNDU2YWMwNGIyNDZjLi45NjIxZTIwN2E5Y2EgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKQEAgLTU1OCw3ICs1NTgsOSBAQCBzdGF0
aWMgaW50IHBzcF94Z21pX2luaXRpYWxpemUoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJc3Ry
dWN0IHRhX3hnbWlfc2hhcmVkX21lbW9yeSAqeGdtaV9jbWQ7CiAJaW50IHJldDsKIAotCWlmICgh
cHNwLT5hZGV2LT5wc3AudGFfZncpCisJaWYgKCFwc3AtPmFkZXYtPnBzcC50YV9mdyB8fAorCSAg
ICAhcHNwLT5hZGV2LT5wc3AudGFfeGdtaV91Y29kZV9zaXplIHx8CisJICAgICFwc3AtPmFkZXYt
PnBzcC50YV94Z21pX3N0YXJ0X2FkZHIpCiAJCXJldHVybiAtRU5PRU5UOwogCiAJaWYgKCFwc3At
PnhnbWlfY29udGV4dC5pbml0aWFsaXplZCkgewpAQCAtNzY4LDYgKzc3MCwxMiBAQCBzdGF0aWMg
aW50IHBzcF9yYXNfaW5pdGlhbGl6ZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkgIHsKIAlpbnQg
cmV0OwogCisJaWYgKCFwc3AtPmFkZXYtPnBzcC50YV9yYXNfdWNvZGVfc2l6ZSB8fAorCSAgICAh
cHNwLT5hZGV2LT5wc3AudGFfcmFzX3N0YXJ0X2FkZHIpIHsKKwkJZGV2X3dhcm4ocHNwLT5hZGV2
LT5kZXYsICJSQVM6IHJhcyB0YSB1Y29kZSBpcyBub3QgYXZhaWxhYmxlXG4iKTsKKwkJcmV0dXJu
IDA7CisJfQorCiAJaWYgKCFwc3AtPnJhcy5yYXNfaW5pdGlhbGl6ZWQpIHsKIAkJcmV0ID0gcHNw
X3Jhc19pbml0X3NoYXJlZF9idWYocHNwKTsKIAkJaWYgKHJldCkKQEAgLTg1Nyw2ICs4NjUsMTIg
QEAgc3RhdGljIGludCBwc3BfaGRjcF9pbml0aWFsaXplKHN0cnVjdCBwc3BfY29udGV4dCAqcHNw
KSAgewogCWludCByZXQ7CiAKKwlpZiAoIXBzcC0+YWRldi0+cHNwLnRhX2hkY3BfdWNvZGVfc2l6
ZSB8fAorCSAgICAhcHNwLT5hZGV2LT5wc3AudGFfaGRjcF9zdGFydF9hZGRyKSB7CisJCWRldl93
YXJuKHBzcC0+YWRldi0+ZGV2LCAiSERDUDogaGRjcCB0YSB1Y29kZSBpcyBub3QgYXZhaWxhYmxl
XG4iKTsKKwkJcmV0dXJuIDA7CisJfQorCiAJaWYgKCFwc3AtPmhkY3BfY29udGV4dC5oZGNwX2lu
aXRpYWxpemVkKSB7CiAJCXJldCA9IHBzcF9oZGNwX2luaXRfc2hhcmVkX2J1Zihwc3ApOwogCQlp
ZiAocmV0KQpAQCAtMTAzMCw2ICsxMDQ0LDEyIEBAIHN0YXRpYyBpbnQgcHNwX2R0bV9pbml0aWFs
aXplKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKSAgewogCWludCByZXQ7CiAKKwlpZiAoIXBzcC0+
YWRldi0+cHNwLnRhX2R0bV91Y29kZV9zaXplIHx8CisJICAgICFwc3AtPmFkZXYtPnBzcC50YV9k
dG1fc3RhcnRfYWRkcikgeworCQlkZXZfd2Fybihwc3AtPmFkZXYtPmRldiwgIkRUTTogZHRtIHRh
IHVjb2RlIGlzIG5vdCBhdmFpbGFibGVcbiIpOworCQlyZXR1cm4gMDsKKwl9CisKIAlpZiAoIXBz
cC0+ZHRtX2NvbnRleHQuZHRtX2luaXRpYWxpemVkKSB7CiAJCXJldCA9IHBzcF9kdG1faW5pdF9z
aGFyZWRfYnVmKHBzcCk7CiAJCWlmIChyZXQpCi0tCjIuMTcuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
