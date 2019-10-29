Return-Path: <SRS0=VQNv=YW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56874CA9EAE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 11:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3246220830
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 11:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3246220830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD4AD6E216;
	Tue, 29 Oct 2019 11:36:56 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690063.outbound.protection.outlook.com [40.107.69.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FE356E216
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 11:36:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDJ1+k7mgF4ySu4SUlPcVV/cOvhFIK2QQ7DGitpQJIF17w/WVHsLldab2UP4H0++JY6Gwf03QdTeNnepY3Fb807X1apO+JqYfSIf5heQ4xhQpyln8gc1CAWkVgKKsAbUpwvABB2xe9LpBQIGWy7yPrnOzRD9rsWzWsAZQAlfopJwCLR/nd4mR5Ax6sNM7EvyKnwDyknY0JeVpX+F/JdBk3bk6DE5FtVdCOFe13ZB0P69HGKxCor/zxjYqLJ7sEjgNQlYbLu3tELaXR931H6OPQf4hQh0/aAsdMnC8vCE7ExOiEngExQWISOXHvmIQUBKnrpi4R2feMU/xbgw/lN1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXJycEiOrzwNw9jLqJbhjzy/feQR+fpz2T0MSj/oisE=;
 b=C7gbC0dWNnYMJkrmvajcPHR79kRBJTViepnNz6iXbVjrLXrqsRK6OQ7UuWXF7SvURzOqJckI5dlEWoqNfK4wuEjly789Dsy5b642iPJ+c/CpAOpzwI+yiKxxKiFZ91QRiXxIUao7bQKKPSf9bwF/T7djYmGRdxdN+HYP7DWyGf4nI8lc8bYbDMCTGw2aZQbMAEIlFCxjBVdzbyy1FybOBtR+OthC/G5DJUOTYtgyVtZVgwaJ90FHSAwsjLOTONNeXAWsYEHTWi+59THHzxXX4ZORUMvjIR0KCl7/oqZlBy3ELlOP3z0ms2zTiNzyaJSt/QWaJKXEro+/pwLhYM9QyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN8PR12MB3602.namprd12.prod.outlook.com (20.178.212.86) by
 BN8PR12MB2962.namprd12.prod.outlook.com (20.178.211.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Tue, 29 Oct 2019 11:36:53 +0000
Received: from BN8PR12MB3602.namprd12.prod.outlook.com
 ([fe80::adae:509b:748f:cd05]) by BN8PR12MB3602.namprd12.prod.outlook.com
 ([fe80::adae:509b:748f:cd05%6]) with mapi id 15.20.2408.018; Tue, 29 Oct 2019
 11:36:53 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gfx10: fix mqd backup/restore for gfx rings
Thread-Topic: [PATCH] drm/amdgpu/gfx10: fix mqd backup/restore for gfx rings
Thread-Index: AQHVjk0pFslnEm/ESEOuM8mneGiGDA==
Date: Tue, 29 Oct 2019 11:36:53 +0000
Message-ID: <20191029113635.16161-1-xiaojie.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0022.apcprd03.prod.outlook.com
 (2603:1096:203:2e::34) To BN8PR12MB3602.namprd12.prod.outlook.com
 (2603:10b6:408:49::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65d1362f-ccbc-4883-bbaa-08d75c644b97
x-ms-traffictypediagnostic: BN8PR12MB2962:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB296253FBCA01249B0B739EEC89610@BN8PR12MB2962.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(199004)(189003)(8676002)(6436002)(5640700003)(66476007)(66446008)(64756008)(52116002)(66556008)(36756003)(476003)(86362001)(486006)(2351001)(1076003)(25786009)(26005)(81166006)(14454004)(81156014)(6486002)(66946007)(50226002)(7736002)(6512007)(305945005)(5660300002)(8936002)(102836004)(71200400001)(2501003)(14444005)(2616005)(66066001)(186003)(6916009)(99286004)(71190400001)(256004)(386003)(316002)(54906003)(478600001)(6116002)(4326008)(2906002)(6506007)(3846002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB2962;
 H:BN8PR12MB3602.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4HXeX61O+jwlrAL1ekhfKwMIY8CKVO5fOOdDcJD2orMoENydab/mWhZiYx2+EwrCdF7sRf0Br74TI4YvjJIlp8nu0J+Bf2IsASe2l0fss3ICmLqUynN0DU9v5WHkBSIqAqNY32ttHzfEx6rOHtj5SYV6q6eSKFJyfS4lRCdDyIgSPpcooApxX0mgzrCVh9+vs9UBlTr5RiFdoD7EY0fn5TsB0Hyk4wZzS8zEd3YwSGG66UJqtdkvla9W/C5gDeQ3y3QUHE52SOjLiOk5Z5rbxNX1g2I6ROX0igDmtg0cgR/2egaHzYTobR9I3mRF/izAk+6zZ7fvYmcHqBV9Ti0M/TqyxGfWOkc7Tb205zOzi/PhTG2EFGh8htZtFvZtpF/XCxebwhDKGWSEzPnGfOt+7S727jMTv2vENfircSpFP3rBctcoPUKF2NmlLoU0sjlT
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d1362f-ccbc-4883-bbaa-08d75c644b97
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:36:53.5242 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q5AX5NJMqZoR2+6tW9z3ZMUZ9mxz/+55tkQYhcVIcwD2LDiaxwMRxyDyg2Fsgvxm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2962
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXJycEiOrzwNw9jLqJbhjzy/feQR+fpz2T0MSj/oisE=;
 b=vZHAfCYIAEgrCNtrKcnvbtxA+g2JQRZEgjNniJRcSliRVbdmuzEvcaitmtgDj/5zfowwHmhAqYkSE4yyqFdri4gAiqsFrinF35RhlI9NrI+qX/fgW9+FnWsCnUwIgGmEyf+M+0YEJ/gdS32LWh6P05L43O12qFMkwBg9OW+uxYQ=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191029113653.8WeYCvqM_PC8FIGAu4NukH5Bycc_eRPEbvUoO4FRmu8@z>

MS4gbm8gbmVlZCB0byBhbGxvY2F0ZSBhbiBleHRyYSBtZW1iZXIgZm9yICdtcWRfYmFja3VwJyBh
cnJheQoyLiBiYWNrdXAvcmVzdG9yZSBtcWQgdG8vZnJvbSB0aGUgY29ycmVjdCAnbXFkX2JhY2t1
cCcgYXJyYXkgc2xvdAoKU2lnbmVkLW9mZi1ieTogWGlhb2ppZSBZdWFuIDx4aWFvamllLnl1YW5A
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmggfCAy
ICstCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyAgfCA5ICsrKysrLS0t
LQogMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oCmluZGV4IDQ1OWFhOTA1OTU0Mi4uNmQx
OWU3ODkxNDkxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z2Z4LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oCkBAIC0y
MjUsNyArMjI1LDcgQEAgc3RydWN0IGFtZGdwdV9tZSB7CiAJdWludDMyX3QJCQludW1fbWU7CiAJ
dWludDMyX3QJCQludW1fcGlwZV9wZXJfbWU7CiAJdWludDMyX3QJCQludW1fcXVldWVfcGVyX3Bp
cGU7Ci0Jdm9pZAkJCQkqbXFkX2JhY2t1cFtBTURHUFVfTUFYX0dGWF9SSU5HUyArIDFdOworCXZv
aWQJCQkJKm1xZF9iYWNrdXBbQU1ER1BVX01BWF9HRlhfUklOR1NdOwogCiAJLyogVGhlc2UgYXJl
IHRoZSByZXNvdXJjZXMgZm9yIHdoaWNoIGFtZGdwdSB0YWtlcyBvd25lcnNoaXAgKi8KIAlERUNM
QVJFX0JJVE1BUChxdWV1ZV9iaXRtYXAsIEFNREdQVV9NQVhfR0ZYX1FVRVVFUyk7CmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCmluZGV4IGVmMTk3NWE1MzIzYS4uMmM1ZGM5YjU4
ZTIzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwpAQCAtMzA3NSw2ICsz
MDc1LDcgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfZ2Z4X2luaXRfcXVldWUoc3RydWN0IGFtZGdw
dV9yaW5nICpyaW5nKQogewogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gcmluZy0+YWRl
djsKIAlzdHJ1Y3QgdjEwX2dmeF9tcWQgKm1xZCA9IHJpbmctPm1xZF9wdHI7CisJaW50IG1xZF9p
ZHggPSByaW5nIC0gJmFkZXYtPmdmeC5nZnhfcmluZ1swXTsKIAogCWlmICghYWRldi0+aW5fZ3B1
X3Jlc2V0ICYmICFhZGV2LT5pbl9zdXNwZW5kKSB7CiAJCW1lbXNldCgodm9pZCAqKW1xZCwgMCwg
c2l6ZW9mKCptcWQpKTsKQEAgLTMwODYsMTIgKzMwODcsMTIgQEAgc3RhdGljIGludCBnZnhfdjEw
XzBfZ2Z4X2luaXRfcXVldWUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQogI2VuZGlmCiAJCW52
X2dyYm1fc2VsZWN0KGFkZXYsIDAsIDAsIDAsIDApOwogCQltdXRleF91bmxvY2soJmFkZXYtPnNy
Ym1fbXV0ZXgpOwotCQlpZiAoYWRldi0+Z2Z4Lm1lLm1xZF9iYWNrdXBbQU1ER1BVX01BWF9HRlhf
UklOR1NdKQotCQkJbWVtY3B5KGFkZXYtPmdmeC5tZS5tcWRfYmFja3VwW0FNREdQVV9NQVhfR0ZY
X1JJTkdTXSwgbXFkLCBzaXplb2YoKm1xZCkpOworCQlpZiAoYWRldi0+Z2Z4Lm1lLm1xZF9iYWNr
dXBbbXFkX2lkeF0pCisJCQltZW1jcHkoYWRldi0+Z2Z4Lm1lLm1xZF9iYWNrdXBbbXFkX2lkeF0s
IG1xZCwgc2l6ZW9mKCptcWQpKTsKIAl9IGVsc2UgaWYgKGFkZXYtPmluX2dwdV9yZXNldCkgewog
CQkvKiByZXNldCBtcWQgd2l0aCB0aGUgYmFja3VwIGNvcHkgKi8KLQkJaWYgKGFkZXYtPmdmeC5t
ZS5tcWRfYmFja3VwW0FNREdQVV9NQVhfR0ZYX1JJTkdTXSkKLQkJCW1lbWNweShtcWQsIGFkZXYt
PmdmeC5tZS5tcWRfYmFja3VwW0FNREdQVV9NQVhfR0ZYX1JJTkdTXSwgc2l6ZW9mKCptcWQpKTsK
KwkJaWYgKGFkZXYtPmdmeC5tZS5tcWRfYmFja3VwW21xZF9pZHhdKQorCQkJbWVtY3B5KG1xZCwg
YWRldi0+Z2Z4Lm1lLm1xZF9iYWNrdXBbbXFkX2lkeF0sIHNpemVvZigqbXFkKSk7CiAJCS8qIHJl
c2V0IHRoZSByaW5nICovCiAJCXJpbmctPndwdHIgPSAwOwogCQlhbWRncHVfcmluZ19jbGVhcl9y
aW5nKHJpbmcpOwotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZng=
