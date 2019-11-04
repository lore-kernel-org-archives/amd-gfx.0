Return-Path: <SRS0=Vl9p=Y4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CFBCA9ED0
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 03:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (unknown [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C7C21929
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 03:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C7C21929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C3846E0CF;
	Mon,  4 Nov 2019 03:03:26 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790084.outbound.protection.outlook.com [40.107.79.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEA676E0CF
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2019 03:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aypXMyo5vhvfd9v9weIVMsP1HzAKwi/TBjLpR/u+P+GBpinaXS7p5BMVWIRX7qvDTj5Nc2sTsKPQSoEG3i0frS7sgnwdlUGSnQjmoMwtikURtMB7mnjNoeM3IzrbCX9jVW8SxjK0V/gZZ4+VVjieRLs/Eph4SkKzuU/ZNen04V+gTeztRbJOgtFeie16xhj2sUds4hUix8mm9Frtd26EXjNTmREIc8AhluiqsdIoQhD1Xpda4QQaM+Bg+hcrd6f2TyGfuiHOandgAzpimfgYqvDzxXd2VFlP7K1zJYYzI1EObtbBt7gSy9dYDAo7/5GVlpGbOaeGRGXiWaU30fyd0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8a/u1VkYWwHonbn2EdVyABfAAzHJS0D3tUx4+nytbk=;
 b=PPUMuyFJV+C7/AWLkJFDRc24fctdAQ9FAKVqh0kSq89GTk5Bk0BfoHQ2t8+HJS2SzXMwoqam+fF0O+KwNrMI1VCLqouIfNUlz+YtNCIlmoFQV27wUJxeJUO7rSuKyyRh5bF3+bQ1MSiWHlMBT2ZuflN5KBFohn1qMAVg6c8aRGlZ/o01vcoUHAhJuxrOn+pjz2Nqi/jWUAK0t2cAfK1Ccag6LBRYUK2ErqmogpAtIRrCFqLcPHZS8gePSTJDFWVor9r0il3eTkk9sXCmHiJOWbS7jJuba6AQxNtAS6N05npojEfD6iF360/M6VnmsPbw1dD6fXHemsOkEwm7oThvzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from CY4PR12CA0043.namprd12.prod.outlook.com (2603:10b6:903:129::29)
 by MN2PR12MB3038.namprd12.prod.outlook.com (2603:10b6:208:cb::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Mon, 4 Nov
 2019 03:03:24 +0000
Received: from CO1NAM03FT064.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::202) by CY4PR12CA0043.outlook.office365.com
 (2603:10b6:903:129::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.24 via Frontend
 Transport; Mon, 4 Nov 2019 03:03:23 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM03FT064.mail.protection.outlook.com (10.152.81.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Mon, 4 Nov 2019 03:03:23 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 3 Nov 2019
 21:03:22 -0600
Received: from emily-build-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Sun, 3 Nov 2019 21:03:21 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Need to free discovery memory
Date: Mon, 4 Nov 2019 11:03:17 +0800
Message-ID: <1572836597-31265-1-git-send-email-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39850400004)(428003)(189003)(199004)(426003)(186003)(86362001)(81166006)(305945005)(486006)(50226002)(476003)(126002)(70206006)(70586007)(8936002)(2906002)(4326008)(8676002)(81156014)(5660300002)(336012)(36756003)(2616005)(6916009)(48376002)(50466002)(51416003)(7696005)(2351001)(26005)(53416004)(316002)(478600001)(47776003)(356004)(6666004)(16586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3038; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff305116-c12c-4b3a-8308-08d760d38e3e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3038:
X-Microsoft-Antispam-PRVS: <MN2PR12MB30384E07E211A59934543D988F7F0@MN2PR12MB3038.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:224;
X-Forefront-PRVS: 0211965D06
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4MqrmqZKsgXjggkOa6kCtXhZi65ubZ68d5eP8U3hFAlfFJmC2cqf+4vAgpbxqxRrbxlx6b05dIDacDU+7vvBiUEckf0JqhQOcyYEYWnhihyRrhDfUp30bOp1/A0kYMOu2asGjlZnafFD3Iia/9WOooaPVgoeZ84Zwkd0HvLUIYZ9+RVk+F7Q15CgrPbgcR+HYQMCVMg+LT/VM2U2VaKsdyUHM+PcIJtNCGvRMsYr7A+xRb6RcLtvuwFVrx4K5lbWKePP6qyUKh0AblBhF3gLDW6t4Su9UI+6U7PVaO7IP7LRYQoc1i+4tFCVgJGWL0b/AxvKPDVIk14A0vp10tdJQ0JlgXJM7Spvh0hBUn/p4y8vssoWzLKtLzsZUPaoIMnqci72u6n3Pvgqf3F8HRCVlvTEBg4YrWe4pRWYmrtDG6Xoz3xgIc9xjhAH29uZrTG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2019 03:03:23.5410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff305116-c12c-4b3a-8308-08d760d38e3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3038
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8a/u1VkYWwHonbn2EdVyABfAAzHJS0D3tUx4+nytbk=;
 b=bonvFRSkEn/k5tU51GegWSu99AGQ8tnTb44cDQjniz9MFlXlJg4BBPd/En8gQvWlZPqxh52tnUxOCw/+7irk4d+8I8mKZo6vAsRzSMaF8gQpOvnZpSJzWejgIfUzefTsEkoPZ8kUndZ6l0NLTRSLBkoeYtrh2uq5ZbRMFSStTfw=
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191104030317.UmP5pWWqmDAfsUT1APkaf5rVSlcNCMQEzAKgJlsMdVc@z>

V2hlbiB1bmxvYWRpbmcgZHJpdmVyLCBuZWVkIHRvIGZyZWUgZGlzY292ZXJ5IG1lbW9yeS4KClNp
Z25lZC1vZmYtYnk6IEVtaWx5IERlbmcgPEVtaWx5LkRlbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdHRtLmMKaW5kZXggMjhiMDlmNi4uN2NiZTZkOSAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwpAQCAtMjEwNiw5ICsyMTA2LDYgQEAgdm9pZCBhbWRn
cHVfdHRtX2xhdGVfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAl2b2lkICpzdG9s
ZW5fdmdhX2J1ZjsKIAkvKiByZXR1cm4gdGhlIFZHQSBzdG9sZW4gbWVtb3J5IChpZiBhbnkpIGJh
Y2sgdG8gVlJBTSAqLwogCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYWRldi0+c3RvbGVuX3ZnYV9t
ZW1vcnksIE5VTEwsICZzdG9sZW5fdmdhX2J1Zik7Ci0KLQkvKiByZXR1cm4gdGhlIElQIERpc2Nv
dmVyeSBUTVIgbWVtb3J5IGJhY2sgdG8gVlJBTSAqLwotCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgm
YWRldi0+ZGlzY292ZXJ5X21lbW9yeSwgTlVMTCwgTlVMTCk7CiB9CiAKIC8qKgpAQCAtMjEyMSw3
ICsyMTE4LDEwIEBAIHZvaWQgYW1kZ3B1X3R0bV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQogCiAJYW1kZ3B1X3R0bV9kZWJ1Z2ZzX2ZpbmkoYWRldik7CiAJYW1kZ3B1X3R0bV90cmFp
bmluZ19yZXNlcnZlX3ZyYW1fZmluaShhZGV2KTsKKwkvKiByZXR1cm4gdGhlIElQIERpc2NvdmVy
eSBUTVIgbWVtb3J5IGJhY2sgdG8gVlJBTSAqLworCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYWRl
di0+ZGlzY292ZXJ5X21lbW9yeSwgTlVMTCwgTlVMTCk7CiAJYW1kZ3B1X3R0bV9md19yZXNlcnZl
X3ZyYW1fZmluaShhZGV2KTsKKwogCWlmIChhZGV2LT5tbWFuLmFwZXJfYmFzZV9rYWRkcikKIAkJ
aW91bm1hcChhZGV2LT5tbWFuLmFwZXJfYmFzZV9rYWRkcik7CiAJYWRldi0+bW1hbi5hcGVyX2Jh
c2Vfa2FkZHIgPSBOVUxMOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
