Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BF7CA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 14:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E737E20659
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 14:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E737E20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B46096E8B7;
	Mon, 28 Oct 2019 14:09:06 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe49::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 609DA6E8B0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:09:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHMBU/A+2lCRMW3hRAO6VY2w7GH6sWlqhkaQAZUDJadnWwlj/aM2ZJZNvkW0zbhhekgw/ki8JCotTwxUP4/HuZrvJ7ZXF/Fd3eniM70xzXONjf/drA3U5dl+wgAl3+Y92ShatlrUqUU3EDuMvFQh21gcuP6TfCUS0H0/3PMgR8ja4RHf4EB8YI27IrX+S3iXWFTgN7/d+QtKlsu0H7o5wRaHqCfSziz7vakUcgFkgvO3a1R5y04YFqRoI6A+MTyV5PhzK3tiJ4RBjTE3O1wdlUddcrgp6VuvvsKrHKVNrPZ/klzWEu5nRfcDRc9iHcSqZCerIOYXR7irh5BGg1IupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+u4y5HfzuIx+THNOMYhx6IiFffXYgStivubdnVGU/1s=;
 b=StdZt/2YZ2h+lGND5b68swYLN8p5xPUKLtbld84ojNCP/I7FdhivHk74nH8/7rDHEX8oGsanQ2M6Gfeeiq0tatj/YGhK2Q9eVfvSoLkPiaZpoR69CnPXKHoEf4/NpG7urMzCcw6+6gr22aXm5v3EO908/fMCd5N8ePz3slUW4l3iXUqF4Dp76vFKAvU9iE6h+jr+9DiNCwa8oGv41/7K3wrfFhneFMqkT7SEVqR6pB8thfF3DSreWmDta605JsZTCoW10W4sVcZTy95FlDuPPWPM2KoAUOLBEpKnaVZXLt30wwK88Tf0Wh7bd89tJ74dkn5c7qahfZcpNjK2y0bh7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from CY4PR1201CA0010.namprd12.prod.outlook.com
 (2603:10b6:910:16::20) by DM6PR12MB3993.namprd12.prod.outlook.com
 (2603:10b6:5:1cd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.22; Mon, 28 Oct
 2019 14:09:02 +0000
Received: from CO1NAM03FT061.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::201) by CY4PR1201CA0010.outlook.office365.com
 (2603:10b6:910:16::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.22 via Frontend
 Transport; Mon, 28 Oct 2019 14:09:02 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM03FT061.mail.protection.outlook.com (10.152.81.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Mon, 28 Oct 2019 14:09:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 28 Oct
 2019 09:09:01 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 28 Oct
 2019 09:09:00 -0500
Received: from kazvm.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 28 Oct 2019 09:09:00 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/11] drm/amd/display: Register DMUB service with DC
Date: Mon, 28 Oct 2019 10:08:36 -0400
Message-ID: <20191028140837.7908-11-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028140837.7908-1-nicholas.kazlauskas@amd.com>
References: <20191028140837.7908-1-nicholas.kazlauskas@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(428003)(189003)(199004)(86362001)(316002)(6916009)(53416004)(305945005)(478600001)(1076003)(51416003)(7696005)(5660300002)(6666004)(356004)(2906002)(36756003)(2870700001)(70206006)(50466002)(186003)(76176011)(70586007)(47776003)(4326008)(2616005)(486006)(476003)(126002)(81166006)(11346002)(50226002)(81156014)(446003)(426003)(8936002)(336012)(8676002)(2351001)(26005)(44832011)(48376002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3993; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dd1fc90-d5ee-49df-10ec-08d75bb0628a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3993:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3993CDBCFB7491CE90AEF01BEC660@DM6PR12MB3993.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0204F0BDE2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMDaF7aitSStYRiYdlz4R4v3KBX+ZejY4v/L9gnhDOqNbNbW2fyFj8CB1iT7oMxawgF9E8xU5YPyoQPvqmPPMuf9rfbd7asEgK1ioGrsmvZr8TyLI8h9B4sySSq8x/I6zHKAupeXU/kGQhe/2F/xwiV0q6JFuF8KsxBQDBSN5gdJ4161EYNFaYQ4f2QpUtMu2+fptJrNLUxuGsmDSGuJ2nmrfa3r3WkdhtwfJlYMrGkDorIisK3+aPX5hrovVZX7qfwZ5ciICn5FzRskBeE80jrZqSsQulZ2k/pWPemANAYMi5dWnLYPeqpPFanmg7CgMZLAKuSPTmYUhca+ltGulPOJASq7rrWFYIjyyb4fG9Q0sUXxqJmO9Az+OGtISs8G5pwoq6hJ9TmgzH+lBnb0lGmlNioS1ii7v0Y1PlscOGuIGhvCYRRXabZ5Ru2/faTQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2019 14:09:02.0160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd1fc90-d5ee-49df-10ec-08d75bb0628a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3993
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+u4y5HfzuIx+THNOMYhx6IiFffXYgStivubdnVGU/1s=;
 b=r8pK58klP+U6Y7ZWN7Xoxd9R32qUp3rdCSA4dX9Qls4nhsxgn0W1Zij0+26qEeCIJ7N0ypizc7EeVvIvGNZlYNPRZCUST5Qm/i9PUKZW+S0XiOdVZ8Hemzo7mWrPBphtGTjufvaEWAE0ndBmVY/bQKoj7c/KqYrJBQkXX0vEi50=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is
 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
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
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028140836.z1HTZ6InVRte1pKrEXQ8vKihGH0tlICpAYoeluzCxqA@z>

W1doeV0KREMgY2FuIHV0aWxpemUgdGhlIERNVUIgc2VydmVyIHRvIHNlbmQgY29tbWFuZHMgdG8g
dGhlIERNVUIgYnV0IGl0J3MKdGhlIERNIHJlc3BvbnNpYmlsaXR5IHRvIHBhc3MgaXQgdGhlIHNl
cnZpY2UgdG8gdXNlLgoKW0hvd10KQ3JlYXRlIHRoZSBkY19kbXViX3NydiBhZnRlciB3ZSBmaW5p
c2ggaW5pdGlhbGl6aW5nIHRoZSBkbXViX3Nydi4KQ2xlYW51cCB0aGUgZGNfZG11Yl9zcnYgYmVm
b3JlIGRlc3Ryb3lpbmcgdGhlIGRtdWJfc3J2IG9yIGRjLgoKU2lnbmVkLW9mZi1ieTogTmljaG9s
YXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAxMiArKysrKysrKysr
KysKIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKaW5kZXggMjMwZmQwMTU1NDYz
Li45MjBlODRlNDBiYmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9h
bWRncHVfZG0vYW1kZ3B1X2RtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Ft
ZGdwdV9kbS9hbWRncHVfZG0uYwpAQCAtMzQsNiArMzQsNyBAQAogI2luY2x1ZGUgImRtdWIvaW5j
L2RtdWJfc3J2LmgiCiAjaW5jbHVkZSAiZGMvaW5jL2h3L2RtY3UuaCIKICNpbmNsdWRlICJkYy9p
bmMvaHcvYWJtLmgiCisjaW5jbHVkZSAiZGMvZGNfZG11Yl9zcnYuaCIKICNlbmRpZgogCiAjaW5j
bHVkZSAidmlkLmgiCkBAIC04MDMsNiArODA0LDEyIEBAIHN0YXRpYyBpbnQgZG1fZG11Yl9od19p
bml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQlhYm0tPmRtY3VfaXNfcnVubmluZyA9
IGRtY3UtPmZ1bmNzLT5pc19kbWN1X2luaXRpYWxpemVkKGRtY3UpOwogCX0KIAorCWFkZXYtPmRt
LmRjLT5jdHgtPmRtdWJfc3J2ID0gZGNfZG11Yl9zcnZfY3JlYXRlKGFkZXYtPmRtLmRjLCBkbXVi
X3Nydik7CisJaWYgKCFhZGV2LT5kbS5kYy0+Y3R4LT5kbXViX3NydikgeworCQlEUk1fRVJST1Io
IkNvdWxkbid0IGFsbG9jYXRlIERDIERNVUIgc2VydmVyIVxuIik7CisJCXJldHVybiAtRU5PTUVN
OworCX0KKwogCURSTV9JTkZPKCJETVVCIGhhcmR3YXJlIGluaXRpYWxpemVkOiB2ZXJzaW9uPTB4
JTA4WFxuIiwKIAkJIGFkZXYtPmRtLmRtY3ViX2Z3X3ZlcnNpb24pOwogCkBAIC05NzYsNiArOTgz
LDExIEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9kbV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQogCQlkY19kZWluaXRfY2FsbGJhY2tzKGFkZXYtPmRtLmRjKTsKICNlbmRpZgogI2lmZGVm
IENPTkZJR19EUk1fQU1EX0RDX0RNVUIKKwlpZiAoYWRldi0+ZG0uZGMtPmN0eC0+ZG11Yl9zcnYp
IHsKKwkJZGNfZG11Yl9zcnZfZGVzdHJveSgmYWRldi0+ZG0uZGMtPmN0eC0+ZG11Yl9zcnYpOwor
CQlhZGV2LT5kbS5kYy0+Y3R4LT5kbXViX3NydiA9IE5VTEw7CisJfQorCiAJaWYgKGFkZXYtPmRt
LmRtdWJfYm8pCiAJCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYWRldi0+ZG0uZG11Yl9ibywKIAkJ
CQkgICAgICAmYWRldi0+ZG0uZG11Yl9ib19ncHVfYWRkciwKLS0gCjIuMjAuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
