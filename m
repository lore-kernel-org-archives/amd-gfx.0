Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882BBC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B772067B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B772067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0088C6EBA6;
	Tue, 12 Nov 2019 18:04:06 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790081.outbound.protection.outlook.com [40.107.79.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4291A6EBA6
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 18:04:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDFep6acTylCKwehtkliFpyKorZpA0M4zwqaipW0cK9iOVsO6IKJutF8ZGSqI9WLFNenukKHKUvzup5TKOv7Moz/iJEMVvRIbrMiQh8iTeEEdskohouyIl0aDpqs7uECyYXgWUD5DAbBKUBpUp14AyfROYA5zUoXt4O/OrHEKql8Gtt1ai/vs3VNriZ1lAsEDBR5e15VjH8yuPvS/fqs3ZzMJM96oSt0lLTSp/JSe+4xJOeeDYS7bY9WtR6w755ICQk5Fs/hwt88nYct2HHQIBJ/Be/qHHyATxN7Yod2m8JBCRsR5B2SFwevhGhJixTRdoAb5FNqwA9lL9o4tQhYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibsKhKsr7hW3iU+96zaF3uxBuY0OiozDfvufZM/P1pI=;
 b=FbykG8WwjGAAYgNJEyNS+S0VdAIx+6zYpCUfP33aXzU/DC+E+GKwydtIzl/PgkxwPu68l7gDyc94IvtGyZZPHlqQhSd20UazQu8TpH7xRlj+BkaMZwTbWM2FsE+y4DXBgs1X9rdl5f1d5RQjatEy6o9FEerDYMp3mRcHy7kuBOqhXMjR5a3TjMarumKbgvJYAfZgisYSuaV4XWMIm3JuNelLnsntGt87vzi87nyfWv3Sk08LMHSTxo9VViHci9THriECQzKWHMk2BJFQnLIuMOxPBF8F8cqXcqriOBB8ZIqcAdYK0r0X6RRnmqJqCsNWcoVBeN5yVPHTpyBZdsLZ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB2405.namprd12.prod.outlook.com (52.132.140.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 18:03:58 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 18:03:58 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/21] drm/amdgpu: add JPEG HW IP and SW structures
Date: Tue, 12 Nov 2019 13:03:09 -0500
Message-Id: <20191112180329.3927-2-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112180329.3927-1-leo.liu@amd.com>
References: <20191112180329.3927-1-leo.liu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 01e2d10c-88e4-47f8-bcda-08d7679ab09b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2405:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2405709EC177C5B7F345E3DFE5770@DM5PR12MB2405.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(4326008)(6512007)(76176011)(66066001)(47776003)(6666004)(2351001)(478600001)(51416003)(52116002)(14454004)(6916009)(44832011)(486006)(186003)(476003)(2616005)(6506007)(386003)(7736002)(26005)(25786009)(2361001)(14444005)(36756003)(86362001)(305945005)(446003)(11346002)(6116002)(8676002)(3846002)(99286004)(16586007)(66476007)(50226002)(66946007)(2906002)(6486002)(6436002)(8936002)(81166006)(50466002)(5660300002)(316002)(1076003)(48376002)(81156014)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2405;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: abr40NUYojwG4ScgRiNUPiKZuacuM33/owFCSntG+qtsoCmW8sbRbbgr3oJUAioqOs94m8NLb6o52IXYkci+7mUr//VNBhD2JqHkPBwHuUCe2kGmlQhhgWIBfgXWrhKRVhD5Jsx6zkC87EUh1JV4gOiQnl3mvCGEwmAXqmozk2ASd1vgmu6nRFV2ZZyvqsaZrOpy8qM96GKnGwstgSlNI2nFukBorq08oYwNgKfIYc+eSfK0i5LdGgeHRiuPyjqhQq8WcN4ScvNybC59SeTMH+GKHTBBoZA3UAmm69/gV3Bm2nq+QgVEzEBUn4K20OLaaTiP+enX57cjegD5hV61vIiI1mfQbrBBq6TYRym70N4SRHylzDfuLxz2q3b1JmqE7tXTsqHHSz6E8LBg4HrRFhxAvl36qJd8U//Q1wOjm/WzGL9RU5QOwb5KM5CEcccd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e2d10c-88e4-47f8-bcda-08d7679ab09b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 18:03:58.4633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExLaamdbJ1xvVS7POh9xcDCcD+OTWwvJPRWSNlMCMmbmEdQ5efJ0Z5lVLzL2Pg5F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2405
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibsKhKsr7hW3iU+96zaF3uxBuY0OiozDfvufZM/P1pI=;
 b=NI2iVLlrXEbbecholyb1yoXpVSWw5ybn4CifTP2P3mi9qgpIyxPi7PFZpNzwzjraaOJsqEIVfrAj2oV7npkMVkSBBFj4jyFIgy9CSTUpIXJdbxdef1E+4Pu6O7dCZkvFkrifQmyVne3uxaKaVFh+dFwi5i5LfGNlrO0yOPR+fFE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
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
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112180309.M8eg965w_mPHw6LZ7UnhASAJ3lM45uwRG8ZfuWTtEi4@z>

SXQgd2lsbCBiZSB1c2VkIGZvciBKUEVHIElQIDEuMCwgMi4wLCAyLjUgYW5kIGxhdGVyLgoKU2ln
bmVkLW9mZi1ieTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAgICAgfCAgNSArKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9qcGVnLmggfCA0NiArKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmls
ZXMgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qcGVnLmgKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdS5oCmluZGV4IGJkYzdkZTViNTgzZC4uYjk5ZTc3NzJhYzAxIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHUuaApAQCAtNjksNiArNjksNyBAQAogI2luY2x1ZGUgImFtZGdwdV91dmQu
aCIKICNpbmNsdWRlICJhbWRncHVfdmNlLmgiCiAjaW5jbHVkZSAiYW1kZ3B1X3Zjbi5oIgorI2lu
Y2x1ZGUgImFtZGdwdV9qcGVnLmgiCiAjaW5jbHVkZSAiYW1kZ3B1X21uLmgiCiAjaW5jbHVkZSAi
YW1kZ3B1X2dtYy5oIgogI2luY2x1ZGUgImFtZGdwdV9nZnguaCIKQEAgLTcxMCw2ICs3MTEsNyBA
QCBlbnVtIGFtZF9od19pcF9ibG9ja190eXBlIHsKIAlNUDFfSFdJUCwKIAlVVkRfSFdJUCwKIAlW
Q05fSFdJUCA9IFVWRF9IV0lQLAorCUpQRUdfSFdJUCA9IFZDTl9IV0lQLAogCVZDRV9IV0lQLAog
CURGX0hXSVAsCiAJRENFX0hXSVAsCkBAIC05MDUsNiArOTA3LDkgQEAgc3RydWN0IGFtZGdwdV9k
ZXZpY2UgewogCS8qIHZjbiAqLwogCXN0cnVjdCBhbWRncHVfdmNuCQl2Y247CiAKKwkvKiBqcGVn
ICovCisJc3RydWN0IGFtZGdwdV9qcGVnCQlqcGVnOworCiAJLyogZmlybXdhcmVzICovCiAJc3Ry
dWN0IGFtZGdwdV9maXJtd2FyZQkJZmlybXdhcmU7CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qcGVnLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfanBlZy5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4u
MzZlMmI3MzQwYzk3Ci0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2pwZWcuaApAQCAtMCwwICsxLDQ2IEBACisvKgorICogQ29weXJpZ2h0IDIwMTkg
QWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLgorICoKKyAqIFBlcm1pc3Npb24gaXMgaGVyZWJ5
IGdyYW50ZWQsIGZyZWUgb2YgY2hhcmdlLCB0byBhbnkgcGVyc29uIG9idGFpbmluZyBhCisgKiBj
b3B5IG9mIHRoaXMgc29mdHdhcmUgYW5kIGFzc29jaWF0ZWQgZG9jdW1lbnRhdGlvbiBmaWxlcyAo
dGhlICJTb2Z0d2FyZSIpLAorICogdG8gZGVhbCBpbiB0aGUgU29mdHdhcmUgd2l0aG91dCByZXN0
cmljdGlvbiwgaW5jbHVkaW5nIHdpdGhvdXQgbGltaXRhdGlvbgorICogdGhlIHJpZ2h0cyB0byB1
c2UsIGNvcHksIG1vZGlmeSwgbWVyZ2UsIHB1Ymxpc2gsIGRpc3RyaWJ1dGUsIHN1YmxpY2Vuc2Us
CisgKiBhbmQvb3Igc2VsbCBjb3BpZXMgb2YgdGhlIFNvZnR3YXJlLCBhbmQgdG8gcGVybWl0IHBl
cnNvbnMgdG8gd2hvbSB0aGUKKyAqIFNvZnR3YXJlIGlzIGZ1cm5pc2hlZCB0byBkbyBzbywgc3Vi
amVjdCB0byB0aGUgZm9sbG93aW5nIGNvbmRpdGlvbnM6CisgKgorICogVGhlIGFib3ZlIGNvcHly
aWdodCBub3RpY2UgYW5kIHRoaXMgcGVybWlzc2lvbiBub3RpY2Ugc2hhbGwgYmUgaW5jbHVkZWQg
aW4KKyAqIGFsbCBjb3BpZXMgb3Igc3Vic3RhbnRpYWwgcG9ydGlvbnMgb2YgdGhlIFNvZnR3YXJl
LgorICoKKyAqIFRIRSBTT0ZUV0FSRSBJUyBQUk9WSURFRCAiQVMgSVMiLCBXSVRIT1VUIFdBUlJB
TlRZIE9GIEFOWSBLSU5ELCBFWFBSRVNTIE9SCisgKiBJTVBMSUVELCBJTkNMVURJTkcgQlVUIE5P
VCBMSU1JVEVEIFRPIFRIRSBXQVJSQU5USUVTIE9GIE1FUkNIQU5UQUJJTElUWSwKKyAqIEZJVE5F
U1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFIEFORCBOT05JTkZSSU5HRU1FTlQuICBJTiBOTyBF
VkVOVCBTSEFMTAorICogVEhFIENPUFlSSUdIVCBIT0xERVIoUykgT1IgQVVUSE9SKFMpIEJFIExJ
QUJMRSBGT1IgQU5ZIENMQUlNLCBEQU1BR0VTIE9SCisgKiBPVEhFUiBMSUFCSUxJVFksIFdIRVRI
RVIgSU4gQU4gQUNUSU9OIE9GIENPTlRSQUNULCBUT1JUIE9SIE9USEVSV0lTRSwKKyAqIEFSSVNJ
TkcgRlJPTSwgT1VUIE9GIE9SIElOIENPTk5FQ1RJT04gV0lUSCBUSEUgU09GVFdBUkUgT1IgVEhF
IFVTRSBPUgorICogT1RIRVIgREVBTElOR1MgSU4gVEhFIFNPRlRXQVJFLgorICoKKyAqLworCisj
aWZuZGVmIF9fQU1ER1BVX0pQRUdfSF9fCisjZGVmaW5lIF9fQU1ER1BVX0pQRUdfSF9fCisKKyNk
ZWZpbmUgQU1ER1BVX01BWF9KUEVHX0lOU1RBTkNFUwkyCisKK3N0cnVjdCBhbWRncHVfanBlZ19y
ZWd7CisJdW5zaWduZWQganBlZ19waXRjaDsKK307CisKK3N0cnVjdCBhbWRncHVfanBlZ19pbnN0
IHsKKwlzdHJ1Y3QgYW1kZ3B1X3JpbmcgcmluZ19kZWM7CisJc3RydWN0IGFtZGdwdV9pcnFfc3Jj
IGlycTsKKwlzdHJ1Y3QgYW1kZ3B1X2pwZWdfcmVnIGV4dGVybmFsOworfTsKKworc3RydWN0IGFt
ZGdwdV9qcGVnIHsKKwl1aW50OF90CW51bV9qcGVnX2luc3Q7CisJc3RydWN0IGFtZGdwdV9qcGVn
X2luc3QgaW5zdFtBTURHUFVfTUFYX0pQRUdfSU5TVEFOQ0VTXTsKKwlzdHJ1Y3QgYW1kZ3B1X2pw
ZWdfcmVnIGludGVybmFsOworCXVuc2lnbmVkIGhhcnZlc3RfY29uZmlnOworfTsKKworI2VuZGlm
IC8qX19BTURHUFVfSlBFR19IX18qLwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZng=
