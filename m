Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597ADC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 06:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10EE1206D8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 06:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EE1206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A146E0F0;
	Wed, 20 Nov 2019 06:47:32 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760045.outbound.protection.outlook.com [40.107.76.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CFDF6E061
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 06:47:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjjs6Yvv/s6hhCu2T+TXhYnhgP0jyCq9MAiieuhkCUbMtP6TKgjdKVqG2Hz0vPadpg8nEaDumHJoHe4itE2d/OoKHGpr9ejlQALWMO7EmYdMM1hJvd08DAf+tctigHN6lHzQtWybaiO1FlmtE6r27sotKEDVJIgGhhaK+2UBJdkF500qJMm+wJNV06Rk/QfKHy0JegjTTk7jrqZcFCs7kzC6ME4nzix11q2kIl6Iocbht/iMAAgynfFUsPkRCRgXNxEhEifeKGoJqMLLSAwWCvy0BTnDTlIAm6fbxiBNTLqEOlFH5Gdz6ozK9/C3XCuuLvQXLS235FfyT1hNw0h4sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSjA8lmdfbOPwaCONiwxQy0tRqXncPS+0gGxs4PBUEM=;
 b=ci7aUYs21+M4Otol0VYTs2h1z70OHiuL5A68hZJ7ktWdqa0iUyyADTgUsFMpuXCRN5wjibjSpo8ukzWR0lhV4JqejRmYjTxlyIJj2HjDx/fphwVc69dHHAOsqYy/MlP3yLE1AxoJwhESGNyR3eYz8QkP3JTep9RwOVDiAXe3pYkaiCn+AuqR7IImvMvgh4wQq2kvpKZJfpusTUbpldatfhdFqIZBZaL2T5A8BPAzASQSTDMbEl8Gpb7AXNeeEi1WoevyJvhetDRu8WTHWqQb92r4HaklW0dV+HXkpt5cVLYP1p2CkxV0086x0oMt36NUoPBbNb03F44/1tSwJFaktQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB3518.namprd12.prod.outlook.com (20.179.82.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Wed, 20 Nov 2019 06:47:28 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15%5]) with mapi id 15.20.2451.029; Wed, 20 Nov 2019
 06:47:28 +0000
From: Xiaojie Yuan <xiaojie.yuan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/gfx10: re-init clear state buffer after gpu reset
Date: Wed, 20 Nov 2019 14:47:01 +0800
Message-Id: <20191120064701.2765-1-xiaojie.yuan@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK0PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::31) To MN2PR12MB3087.namprd12.prod.outlook.com
 (2603:10b6:208:d2::32)
MIME-Version: 1.0
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d265c877-6ae5-4b6c-6569-08d76d85824a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3518:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3518B649C8B8F23C7F5620CD894F0@MN2PR12MB3518.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:130;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(979002)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(189003)(199004)(8936002)(50466002)(4326008)(26005)(386003)(2351001)(47776003)(186003)(2616005)(3846002)(6116002)(6486002)(52116002)(6506007)(66066001)(25786009)(316002)(6512007)(6666004)(86362001)(2361001)(36756003)(2870700001)(2906002)(6916009)(14454004)(478600001)(8676002)(7736002)(305945005)(6436002)(66476007)(81166006)(51416003)(14444005)(81156014)(66556008)(66946007)(48376002)(1076003)(99286004)(5660300002)(44832011)(476003)(486006)(50226002)(357404004)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3518;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5s23CdLD9+n8oPq1xl483UC+pQ2juc9gic+8Vfw3OkIpLY/Rcp+LndztZnpZAfPemBAVSfXTJBUqKZL32A4pg7ojueDdRkpq63WjBoXU6t0J/r73B0staCucnJPLDiLZ3q4tylT8j+M+FpsbXKBntxmgMYEANt1pHXQ1KC93+LphJ9UZagEkEnCsND3ZQidp5Ytcl6AT77eZmO/EF48p11B4O5a0MepSwLG2/sRD1VKZ2BdF1sAzIlL66tp2VTIh/Ttw+liMbFzR8lj83KFAVZPL55+Z6cWWz8b3xWchAzTK11x44f9Axgy1YvxV3ZbpYge8zL64xFTTWjWE5phhjEwvIgTWLe2XPTluA/taSzPocGdr5G16B6dpy79xQiqM8A3VNDOewt5M31ygS2B4mbiF9UBlLIK9lQWaZv238yva60QnsDJ+8t0KCFE0DkmO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d265c877-6ae5-4b6c-6569-08d76d85824a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 06:47:28.2504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VyT2AvfQMAb7M8GRKApzn5SXzcFCDw4vs9LrNsLMjJ8URMfdvbGMUToPdI/31ww
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3518
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSjA8lmdfbOPwaCONiwxQy0tRqXncPS+0gGxs4PBUEM=;
 b=WWtzf/RxxQoYbcMfKgH0KO+WbfQLe7T3J4A/sAq6iocGMibNLlhiyCLLxRuTKGDG1PzfZR/FmlNzOuGbaEB5inzPdwXvCOOrjTDH7XWO3coBdB335+4eijBzrgKdWla/vNqEQeMktIWyAbphPRr00hmH2ML5eDlfYmBdF/nZHek=
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
Cc: gang.long@amd.com, jack.xiao@amd.com, Xiaojie Yuan <xiaojie.yuan@amd.com>,
 hawking.zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120064701.aSHNVZHqPOYiQy1KHnyKRqW8gBiGgqmqboGs_cbDdY0@z>

VGhpcyBwYXRjaCBmaXhlcyAybmQgYmFjbyByZXNldCBmYWlsdXJlIHdpdGggZ2Z4b2ZmIGVuYWJs
ZWQgb24gbmF2aTF4LgoKY2xlYXIgc3RhdGUgYnVmZmVyIChyZXNpZGVzIGluIHZyYW0pIGlzIGNv
cnJ1cHRlZCBhZnRlciAxc3QgYmFjbyByZXNldCwKdXBvbiBnZnhvZmYgZXhpdCwgQ1BGIGdldHMg
Z2FyYmFnZSBoZWFkZXIgaW4gQ1NJQiBhbmQgaGFuZ3MuCgpTaWduZWQtb2ZmLWJ5OiBYaWFvamll
IFl1YW4gPHhpYW9qaWUueXVhbkBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92MTBfMC5jIHwgNDMgKysrKysrKysrKysrKysrKysrKysrKy0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3YxMF8wLmMKaW5kZXggOTI3NGJkNGI2YzY4Li44ZTI0ZWEwOGNhMzkgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCkBAIC0xNzg5LDI3ICsxNzg5LDUy
IEBAIHN0YXRpYyB2b2lkIGdmeF92MTBfMF9lbmFibGVfZ3VpX2lkbGVfaW50ZXJydXB0KHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LAogCVdSRUczMl9TT0MxNShHQywgMCwgbW1DUF9JTlRfQ05U
TF9SSU5HMCwgdG1wKTsKIH0KIAotc3RhdGljIHZvaWQgZ2Z4X3YxMF8wX2luaXRfY3NiKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQorc3RhdGljIGludCBnZnhfdjEwXzBfaW5pdF9jc2Ioc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7CisJaW50IHI7CisKKwlpZiAoYWRldi0+aW5fZ3B1
X3Jlc2V0KSB7CisJCXIgPSBhbWRncHVfYm9fcmVzZXJ2ZShhZGV2LT5nZngucmxjLmNsZWFyX3N0
YXRlX29iaiwgZmFsc2UpOworCQlpZiAocikKKwkJCXJldHVybiByOworCisJCXIgPSBhbWRncHVf
Ym9fa21hcChhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX29iaiwKKwkJCQkgICAodm9pZCAqKikm
YWRldi0+Z2Z4LnJsYy5jc19wdHIpOworCQlpZiAoIXIpIHsKKwkJCWFkZXYtPmdmeC5ybGMuZnVu
Y3MtPmdldF9jc2JfYnVmZmVyKGFkZXYsCisJCQkJCWFkZXYtPmdmeC5ybGMuY3NfcHRyKTsKKwkJ
CWFtZGdwdV9ib19rdW5tYXAoYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9vYmopOworCQl9CisK
KwkJYW1kZ3B1X2JvX3VucmVzZXJ2ZShhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX29iaik7CisJ
CWlmIChyKQorCQkJcmV0dXJuIHI7CisJfQorCiAJLyogY3NpYiAqLwogCVdSRUczMl9TT0MxNShH
QywgMCwgbW1STENfQ1NJQl9BRERSX0hJLAogCQkgICAgIGFkZXYtPmdmeC5ybGMuY2xlYXJfc3Rh
dGVfZ3B1X2FkZHIgPj4gMzIpOwogCVdSRUczMl9TT0MxNShHQywgMCwgbW1STENfQ1NJQl9BRERS
X0xPLAogCQkgICAgIGFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfZ3B1X2FkZHIgJiAweGZmZmZm
ZmZjKTsKIAlXUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX0NTSUJfTEVOR1RILCBhZGV2LT5nZngu
cmxjLmNsZWFyX3N0YXRlX3NpemUpOworCisJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyB2b2lkIGdm
eF92MTBfMF9pbml0X3BnKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQorc3RhdGljIGludCBn
ZnhfdjEwXzBfaW5pdF9wZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKIAlpbnQgaTsK
KwlpbnQgcjsKIAotCWdmeF92MTBfMF9pbml0X2NzYihhZGV2KTsKKwlyID0gZ2Z4X3YxMF8wX2lu
aXRfY3NiKGFkZXYpOworCWlmIChyKQorCQlyZXR1cm4gcjsKIAogCWZvciAoaSA9IDA7IGkgPCBh
ZGV2LT5udW1fdm1odWJzOyBpKyspCiAJCWFtZGdwdV9nbWNfZmx1c2hfZ3B1X3RsYihhZGV2LCAw
LCBpLCAwKTsKIAogCS8qIFRPRE86IGluaXQgcG93ZXIgZ2F0aW5nICovCi0JcmV0dXJuOworCXJl
dHVybiAwOwogfQogCiB2b2lkIGdmeF92MTBfMF9ybGNfc3RvcChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKQEAgLTE5MTEsNyArMTkzNiwxMCBAQCBzdGF0aWMgaW50IGdmeF92MTBfMF9ybGNf
cmVzdW1lKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQlyID0gZ2Z4X3YxMF8wX3dhaXRf
Zm9yX3JsY19hdXRvbG9hZF9jb21wbGV0ZShhZGV2KTsKIAkJaWYgKHIpCiAJCQlyZXR1cm4gcjsK
LQkJZ2Z4X3YxMF8wX2luaXRfcGcoYWRldik7CisKKwkJciA9IGdmeF92MTBfMF9pbml0X3BnKGFk
ZXYpOworCQlpZiAocikKKwkJCXJldHVybiByOwogCiAJCS8qIGVuYWJsZSBSTEMgU1JNICovCiAJ
CWdmeF92MTBfMF9ybGNfZW5hYmxlX3NybShhZGV2KTsKQEAgLTE5MzcsNyArMTk2NSwxMCBAQCBz
dGF0aWMgaW50IGdmeF92MTBfMF9ybGNfcmVzdW1lKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQogCQkJCXJldHVybiByOwogCQl9CiAKLQkJZ2Z4X3YxMF8wX2luaXRfcGcoYWRldik7CisJCXIg
PSBnZnhfdjEwXzBfaW5pdF9wZyhhZGV2KTsKKwkJaWYgKHIpCisJCQlyZXR1cm4gcjsKKwogCQlh
ZGV2LT5nZngucmxjLmZ1bmNzLT5zdGFydChhZGV2KTsKIAogCQlpZiAoYWRldi0+ZmlybXdhcmUu
bG9hZF90eXBlID09IEFNREdQVV9GV19MT0FEX1JMQ19CQUNLRE9PUl9BVVRPKSB7Ci0tIAoyLjIw
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
