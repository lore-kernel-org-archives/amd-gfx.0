Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512CAC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:33:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC502184C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC502184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D87086EA28;
	Tue, 12 Nov 2019 00:33:52 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800058.outbound.protection.outlook.com [40.107.80.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6BA06EA23
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:33:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5W3IFuImKydMGlNVSMtgiK+Era6xbmrWI5xzQpO1Vc+AXesnEBtLYWz8cSe0KQoxBl/kz5bKo1Ss60t1KPYFuuplih1TnuBM5Ad7i8H4AMDzhXHLoexi6mEaL4otJICm+R2q2KUKEItncGdfT3SnENgGARVcBKQKf8flOF3ZqJgLknavE6YfO2xk6y7FfdVmQP0je7J/xcSD1Q7sIPkUDCUIwa1GEPGVVJekbYbG9n33f6oJYdM8jLQUx7BbftZo6oJ7fWgg5u/Fvl+ncJfiPUHjgISl5dCt+DFSHk4EYkleeKtGPv7KxYEN89WzQRZyir2FIcU79VNisQfDeEElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23SKddcpPqyAqrWIV/zb0CINp6P2vijjEMdN7mYdtFc=;
 b=Cgl2xiVRw6HGgECLyjjUxMCbtd0oXInIrA5jHjINe6ftX9FoWRUh0eUTwIjnzniRfxL2RHP9SsWgSRjXRSxMsqAqWBwoqCilDyVwX8zMUl6gOVNX9Bbr0yWXCarvKLRCPAu/ZUWuVrFO/xPUIgVgHBNNCxP5QbRhGBHTghfVYrtOciRrGOPy0p0+sCEvAFGREn7/NN+ErlHR1922vUHCDaYtt9HcSAp+a8u/6hdgxtR6hNil4ZMU5zOzOP9SJ8WNsnvi6fTbyhQCnUE8bKiOCGtsOeEPwgDvq1/1BvDRIOEhteO76n0oPnD1hefZwoEmYtkl2nphDAgqfvzfwHit/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.180.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:33:49 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:33:49 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/30] drm/amd/display: Update background color in bottommost
 mpcc
Date: Mon, 11 Nov 2019 19:32:59 -0500
Message-Id: <20191112003324.8419-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
References: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd0cb377-b517-4dbd-3358-08d76707fc26
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25541D551C6BAE43CFDD83E298770@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(76176011)(6916009)(81166006)(81156014)(386003)(8676002)(478600001)(6506007)(51416003)(52116002)(2870700001)(25786009)(14444005)(2906002)(186003)(2361001)(3846002)(316002)(66066001)(47776003)(50466002)(4326008)(26005)(66946007)(6116002)(36756003)(1076003)(8936002)(48376002)(50226002)(54906003)(2616005)(305945005)(486006)(5660300002)(6512007)(14454004)(2351001)(446003)(6486002)(6666004)(99286004)(66556008)(15650500001)(476003)(66476007)(11346002)(86362001)(6436002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2554;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RBcDfSTUWDwZmcKqvG4UFR0KhgRLuC9vVScMH5CrTXvUquHZvyl3SBIu0Pa7IAM8XgPD9N9xly7gZxeVsO1I1fi2XeOT3nXPHL6jCsIm8Oa2eOT3nx/Dhr+cXarWvCSo91Z64H1hlG3d3sbOtTCC/NMVt1XhtfOOkGdNkz9T4lQ3EJRtMFjn72eZuFuIVAzQTnNHIIyeAXHTdFXjhVyPmhCA5cidM4csET55xOFTzQVPBkoB5D42jz+CmwS7iTilnrwEPGDyJDI1oL5Y+OQShh5fquw4jPA122bpyYPsNL0NUlXAmh7R0ZzvRnZamd5xEIhzOzqciV93EMZlTGWGB/hglfK9ynj2UDLrZnpPrr6dlILGbWHeJ7ApMqMgygJHpZCyUIir2qDuT6RqqEx/wDYCOGFACU3CA/C8cAI0vjcgjiKwrpAnSYkcsMKKzC4R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0cb377-b517-4dbd-3358-08d76707fc26
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:33:49.0667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPg9WrgCDrT/Agp12s8l2ngGXR/vma54xGTx4bmhEuo0uhiek2cgTh8v2s/a8Zl3L0qr4PwJjg//9sRhBnY4kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23SKddcpPqyAqrWIV/zb0CINp6P2vijjEMdN7mYdtFc=;
 b=TspLizsbpHycaRhTZ9t2qKB3fuSLNuv8eCaOJVdPqx2/v3unHekIJqrJZ5WdBSPxPQjrWh4jW7GGb4q5/xj6QKfNqpm0GOLkNRdCaOYzOGbhKQYb1TaOlpmvs1KAY4KmpZlgvjCraQEkRPSk8noew4bnmD6rsOJrQJwDUmfF624=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
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
Cc: Hugo Hu <hugo.hu@amd.com>, Yongqiang Sun <yongqiang.sun@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112003259.A_2qCupOHaB4jOGd9A6CGwky71lUHBS0hbVKr0NQkWc@z>

RnJvbTogSHVnbyBIdSA8aHVnby5odUBhbWQuY29tPgoKW1doeV0KQmFja2dyb3VuZCBjb2xvciBv
bmx5IHRha2VzIGVmZmVjdCBpbiBib3R0b21tb3N0IG1wY2MuCgpbSG93XQpVcGRhdGUgYmFja2dy
b3VuZCBjb2xvciBpbiBib3R0b21tb3N0IG1wY2MuCgpTaWduZWQtb2ZmLWJ5OiBIdWdvIEh1IDxo
dWdvLmh1QGFtZC5jb20+ClJldmlld2VkLWJ5OiBZb25ncWlhbmcgU3VuIDx5b25ncWlhbmcuc3Vu
QGFtZC5jb20+CkFja2VkLWJ5OiBSb2RyaWdvIFNpcXVlaXJhIDxSb2RyaWdvLlNpcXVlaXJhQGFt
ZC5jb20+Ci0tLQogLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfbXBjLmMg
IHwgMTkgKysrKysrKysrKysrKy0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjbjEwL2RjbjEwX21wYy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjbjEwL2RjbjEwX21wYy5jCmluZGV4IDIyMDE1NGY3OTExYS4uMDRmODYzNDk5Y2ZiIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfbXBjLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX21wYy5jCkBA
IC00MiwyMCArNDIsMjcgQEAgdm9pZCBtcGMxX3NldF9iZ19jb2xvcihzdHJ1Y3QgbXBjICptcGMs
CiAJCWludCBtcGNjX2lkKQogewogCXN0cnVjdCBkY24xMF9tcGMgKm1wYzEwID0gVE9fRENOMTBf
TVBDKG1wYyk7CisJc3RydWN0IG1wY2MgKmJvdHRvbW1vc3RfbXBjYyA9IG1wYzFfZ2V0X21wY2Mo
bXBjLCBtcGNjX2lkKTsKKwl1aW50MzJfdCBiZ19yX2NyLCBiZ19nX3ksIGJnX2JfY2I7CisKKwkv
KiBmaW5kIGJvdHRvbW1vc3QgbXBjYy4gKi8KKwl3aGlsZSAoYm90dG9tbW9zdF9tcGNjLT5tcGNj
X2JvdCkgeworCQlib3R0b21tb3N0X21wY2MgPSBib3R0b21tb3N0X21wY2MtPm1wY2NfYm90Owor
CX0KIAogCS8qIG1wYyBjb2xvciBpcyAxMiBiaXQuICB0Z19jb2xvciBpcyAxMCBiaXQgKi8KIAkv
KiB0b2RvOiBtaWdodCB3YW50IHRvIHVzZSAxNiBiaXQgdG8gcmVwcmVzZW50IGNvbG9yIGFuZCBo
YXZlIGVhY2gKIAkgKiBodyBibG9jayB0cmFuc2xhdGUgdG8gY29ycmVjdCBjb2xvciBkZXB0aC4K
IAkgKi8KLQl1aW50MzJfdCBiZ19yX2NyID0gYmdfY29sb3ItPmNvbG9yX3JfY3IgPDwgMjsKLQl1
aW50MzJfdCBiZ19nX3kgPSBiZ19jb2xvci0+Y29sb3JfZ195IDw8IDI7Ci0JdWludDMyX3QgYmdf
Yl9jYiA9IGJnX2NvbG9yLT5jb2xvcl9iX2NiIDw8IDI7CisJYmdfcl9jciA9IGJnX2NvbG9yLT5j
b2xvcl9yX2NyIDw8IDI7CisJYmdfZ195ID0gYmdfY29sb3ItPmNvbG9yX2dfeSA8PCAyOworCWJn
X2JfY2IgPSBiZ19jb2xvci0+Y29sb3JfYl9jYiA8PCAyOwogCi0JUkVHX1NFVChNUENDX0JHX1Jf
Q1JbbXBjY19pZF0sIDAsCisJUkVHX1NFVChNUENDX0JHX1JfQ1JbYm90dG9tbW9zdF9tcGNjLT5t
cGNjX2lkXSwgMCwKIAkJCU1QQ0NfQkdfUl9DUiwgYmdfcl9jcik7Ci0JUkVHX1NFVChNUENDX0JH
X0dfWVttcGNjX2lkXSwgMCwKKwlSRUdfU0VUKE1QQ0NfQkdfR19ZW2JvdHRvbW1vc3RfbXBjYy0+
bXBjY19pZF0sIDAsCiAJCQlNUENDX0JHX0dfWSwgYmdfZ195KTsKLQlSRUdfU0VUKE1QQ0NfQkdf
Ql9DQlttcGNjX2lkXSwgMCwKKwlSRUdfU0VUKE1QQ0NfQkdfQl9DQltib3R0b21tb3N0X21wY2Mt
Pm1wY2NfaWRdLCAwLAogCQkJTVBDQ19CR19CX0NCLCBiZ19iX2NiKTsKIH0KIAotLSAKMi4yNC4w
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
