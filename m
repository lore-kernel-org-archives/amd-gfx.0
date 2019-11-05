Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F22BC010A2
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 10:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E06A217F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 10:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E06A217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9C236E9B8;
	Tue,  5 Nov 2019 10:23:42 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720078.outbound.protection.outlook.com [40.107.72.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A095D6E9B9
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 10:23:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hW0J9W6fBy/nqzkjHkcf1Wcy6OVSz+gqJihXORHVevHTKn44daMmD5sdgcrOMuWysVWFu1KKMWLvITDLSXEdeQ1zvuqIXnIX4W7lBogfU/Hpdy5IdRD8wzC2n3J0Gsq6Rrk4KWdkFIyhE/dN3ENq1O1GVvifjLZuUpDPp3AwbfaQq0fm/mIND4C5Uw8bpx1KB7t7WFpxAAl1yXCdP1QagteBdhS4Z7qqSsqlQ/R7K5mMoWN5cAZxkBX/6eBBc5W3uiBvAQtL/vjuqPdniO0NXCUQtpJzHELs07iEPfeO+VKJ0l9IIYBoQg36OaBZ1aKLxlO9hgfz/Sflvl839N93gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ou8PpR5S2Zq23KzoJ8KUx2P9h2FsOkjlVuo0txkgEmM=;
 b=fbnthnGRPY+zZSZUwxpigUO/UkuHpuX/wZYAvl/1hk3uwggUAmmmTv2O6+8YyENh/A9h9jGXqYWCI9vUomhZzNT3gqZFZYFYLGjr+hNqu02aRsRQd36DhnxgbraEsGlprDWnz/QJflnP3nJ7a9fahsr02cleK5eJYpIx2VmX8Jb4Q8gR4WyHH1SrOw8qZfZukkuVfglKjpLp9H8M60KwppAnQw5RKfdHSHY+mIk6joDf5mkACycMtxI8YsW4RsO41FReXpk8ozV19FQoL5OOCBHqsqb5+X0oN5hnVLsR7AFzJ01Z0wdPrhMFSgSPUmWBUXxYj+ltYA8YGQ3cUMg80Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3342.namprd12.prod.outlook.com (20.178.240.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 10:23:40 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 10:23:40 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: perform p-state switch after the whole hive
 initialized
Thread-Topic: [PATCH 2/2] drm/amdgpu: perform p-state switch after the whole
 hive initialized
Thread-Index: AQHVk8MXX98TBsaKs0mPZR5S38P8SQ==
Date: Tue, 5 Nov 2019 10:23:40 +0000
Message-ID: <20191105102310.16657-2-evan.quan@amd.com>
References: <20191105102310.16657-1-evan.quan@amd.com>
In-Reply-To: <20191105102310.16657-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR0401CA0004.apcprd04.prod.outlook.com
 (2603:1096:202:2::14) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ea1f8e3-48da-4c5d-9184-08d761da39fe
x-ms-traffictypediagnostic: MN2PR12MB3342:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3342715F5A700A7486D33CAEE47E0@MN2PR12MB3342.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(199004)(189003)(186003)(54906003)(26005)(2501003)(86362001)(6116002)(3846002)(64756008)(66066001)(66556008)(52116002)(6916009)(102836004)(76176011)(8676002)(66476007)(305945005)(7736002)(5660300002)(8936002)(256004)(14444005)(476003)(5640700003)(14454004)(66446008)(71190400001)(50226002)(81166006)(71200400001)(2351001)(478600001)(6436002)(2616005)(2906002)(1076003)(6512007)(4326008)(6506007)(386003)(6486002)(11346002)(446003)(486006)(81156014)(66946007)(25786009)(36756003)(99286004)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3342;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7pHgt4TEg5a2Xi637XPkvvfFX9eR0Tw0cXwFnsG9lz9j4+D/sfW/zWa6tU0ePaqNdlK2B00BiEzYYRg9yzKgdADuX7Dh6zRWNWvtY4itfTKN0jjqxgNv4kxGFGqOd+MpVWcv2xcfP4vZLjgxXdKPn8I1q4IPtQ4hqn6Rg7VsqVHYE1uk1j6i11x3kyaxL4maW/pKadYXy9Pj4EZhNv/U1eXJJhyo00IB9PLD0vMqc5h9L/f2veyWEQ/vVjojGQvJHiMjKJCL61+gv+kp1+R4HDb9d2xQ0Prfovy0qVP68jV0mApZpVZo9kkvQwRuTPU2EQwbZr+OHr5x3wE4xBENYO8tPZheoheQY2io/wBAxOaCUzptJ2DAsn4yLH7/pt2l7BoKO+LHMhcK4MVcMy7Wg7cWIMeIMOFLtNa369o/8SzL/mRhUqFYXUQh7BFMYZCL
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea1f8e3-48da-4c5d-9184-08d761da39fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 10:23:40.2802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fr1qztWO95pSnLGDwQ+NDQ/A7IXjW2dVJu34y4cQgKXpC8hhD6oFVUOXAhp+fXA2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3342
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ou8PpR5S2Zq23KzoJ8KUx2P9h2FsOkjlVuo0txkgEmM=;
 b=HWrvcoLTRQWCa/PYzuPHtlUBWn1c76RefpXHSLXfrNsYM4Fku4ninLeJ9QvKxTANyMZx/Ud5XXaUndp8P/vilI+eoxQDopYZENsFWY6/mloNLWTzEFiR/ESRTNPtQ56JpKQmieS/DTPaua0uWYBjmQ7siR/DeK/YwldtjRQfIZc=
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
Cc: "Strawbridge, Michael" <Michael.Strawbridge@amd.com>, "Kim,
 Jonathan" <Jonathan.Kim@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105102340.A-BdtW1zjhr2jNGJTjH64MlcgbAXWySY58stenh6pNE@z>

UC1zdGF0ZSBzd2l0Y2ggc2hvdWxkIGJlIHBlcmZvcm1lZCBhZnRlciBhbGwgZGV2aWNlcyBmcm9t
IHRoZSBoaXZlCmdldCBpbml0aWFsaXplZC4KCkNoYW5nZS1JZDogSWZjN2NhYzllZjBjZjI1MDQ0
N2QyYTQxMmRhMzVkNjAxZTJhYzc5ZWMKU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFuLnF1
YW5AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNl
LmMgfCA0NyArKysrKysrKysrKysrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMzUgaW5zZXJ0
aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jCmluZGV4IGU2Y2U5NDk2NzBlNS4uMmQ3MmQyMDZjZWFkIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC0yMDkwLDYgKzIwOTAsNyBA
QCBzdGF0aWMgaW50IGFtZGdwdV9kZXZpY2VfZW5hYmxlX21ncHVfZmFuX2Jvb3N0KHZvaWQpCiAg
Ki8KIHN0YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9pcF9sYXRlX2luaXQoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpCiB7CisJc3RydWN0IGFtZGdwdV9ncHVfaW5zdGFuY2UgKmdwdV9pbnN0YW5j
ZTsKIAlpbnQgaSA9IDAsIHI7CiAKIAlmb3IgKGkgPSAwOyBpIDwgYWRldi0+bnVtX2lwX2Jsb2Nr
czsgaSsrKSB7CkBAIC0yMTE1LDYgKzIxMTYsNDAgQEAgc3RhdGljIGludCBhbWRncHVfZGV2aWNl
X2lwX2xhdGVfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAlpZiAocikKIAkJRFJN
X0VSUk9SKCJlbmFibGUgbWdwdSBmYW4gYm9vc3QgZmFpbGVkICglZCkuXG4iLCByKTsKIAorCisJ
aWYgKGFkZXYtPmdtYy54Z21pLm51bV9waHlzaWNhbF9ub2RlcyA+IDEpIHsKKwkJbXV0ZXhfbG9j
aygmbWdwdV9pbmZvLm11dGV4KTsKKworCQkvKgorCQkgKiBSZXNldCBkZXZpY2UgcC1zdGF0ZSB0
byBsb3cgYXMgdGhpcyB3YXMgYm9vdGVkIHdpdGggaGlnaC4KKwkJICoKKwkJICogVGhpcyBzaG91
bGQgYmUgcGVyZm9ybWVkIG9ubHkgYWZ0ZXIgYWxsIGRldmljZXMgZnJvbSB0aGUgc2FtZQorCQkg
KiBoaXZlIGdldCBpbml0aWFsaXplZC4KKwkJICoKKwkJICogSG93ZXZlciwgaXQncyB1bmtub3du
IGhvdyBtYW55IGRldmljZSBpbiB0aGUgaGl2ZSBpbiBhZHZhbmNlLgorCQkgKiBBcyB0aGlzIGlz
IGNvdW50ZWQgb25lIGJ5IG9uZSBkdXJpbmcgZGV2aWNlcyBpbml0aWFsaXphdGlvbnMuCisJCSAq
CisJCSAqIFNvLCB3ZSB3YWl0IGZvciBhbGwgWEdNSSBpbnRlcmxpbmtlZCBkZXZpY2VzIGluaXRp
YWxpemVkLgorCQkgKiBUaGlzIG1heSBicmluZyBzb21lIGRlbGF5cyBhcyB0aG9zZSBkZXZpY2Vz
IG1heSBjb21lIGZyb20KKwkJICogZGlmZmVyZW50IGhpdmVzLiBCdXQgdGhhdCBzaG91bGQgYmUg
T0suCisJCSAqLworCQlpZiAobWdwdV9pbmZvLm51bV9kZ3B1ID09IGFkZXYtPmdtYy54Z21pLm51
bV9waHlzaWNhbF9ub2RlcykgeworCQkJZm9yIChpID0gMDsgaSA8IG1ncHVfaW5mby5udW1fZ3B1
OyBpKyspIHsKKwkJCQlncHVfaW5zdGFuY2UgPSAmKG1ncHVfaW5mby5ncHVfaW5zW2ldKTsKKwkJ
CQlpZiAoZ3B1X2luc3RhbmNlLT5hZGV2LT5mbGFncyAmIEFNRF9JU19BUFUpCisJCQkJCWNvbnRp
bnVlOworCisJCQkJciA9IGFtZGdwdV94Z21pX3NldF9wc3RhdGUoZ3B1X2luc3RhbmNlLT5hZGV2
LCAwKTsKKwkJCQlpZiAocikgeworCQkJCQlEUk1fRVJST1IoInBzdGF0ZSBzZXR0aW5nIGZhaWxl
ZCAoJWQpLlxuIiwgcik7CisJCQkJCWJyZWFrOworCQkJCX0KKwkJCX0KKwkJfQorCisJCW11dGV4
X3VubG9jaygmbWdwdV9pbmZvLm11dGV4KTsKKwl9CisKIAlyZXR1cm4gMDsKIH0KIApAQCAtMjIy
NywxOCArMjI2Miw2IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9kZXZpY2VfZGVsYXllZF9pbml0X3dv
cmtfaGFuZGxlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAJciA9IGFtZGdwdV9pYl9yaW5n
X3Rlc3RzKGFkZXYpOwogCWlmIChyKQogCQlEUk1fRVJST1IoImliIHJpbmcgdGVzdCBmYWlsZWQg
KCVkKS5cbiIsIHIpOwotCi0JLyoKLQkgKiBzZXQgdG8gbG93IHBzdGF0ZSBieSBkZWZhdWx0Ci0J
ICogVGhpcyBzaG91bGQgYmUgcGVyZm9ybWVkIGFmdGVyIGFsbCBkZXZpY2VzIGZyb20KLQkgKiBY
R01JIGZpbmlzaCB0aGVpciBpbml0aWFsaXphdGlvbnMuIFRodXMgaXQncyBtb3ZlZAotCSAqIHRv
IGhlcmUuCi0JICogVGhlIHRpbWUgZGVsYXkgaXMgMlMuIFRPRE86IGNvbmZpcm0gd2hldGhlciB0
aGF0Ci0JICogaXMgZW5vdWdoIGZvciBhbGwgcG9zc2libGUgWEdNSSBzZXR1cHMuCi0JICovCi0J
ciA9IGFtZGdwdV94Z21pX3NldF9wc3RhdGUoYWRldiwgMCk7Ci0JaWYgKHIpCi0JCURSTV9FUlJP
UigicHN0YXRlIHNldHRpbmcgZmFpbGVkICglZCkuXG4iLCByKTsKIH0KIAogc3RhdGljIHZvaWQg
YW1kZ3B1X2RldmljZV9kZWxheV9lbmFibGVfZ2Z4X29mZihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndv
cmspCi0tIAoyLjIzLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
