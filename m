Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E5EC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69DB820829
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U9s8a+kK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DB820829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A26B6E2A5;
	Thu, 30 Jul 2020 19:12:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 692FA6E961
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 19:12:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSiunX6DSKfTBVDgUybNKuH6JpszNfjJdjEJokcp/qCf34mTz3ZS97uFxw5bcv/p9r/8f9eR/7qOCXBqlZcdO2T+gg6TbedLZ5PBAwEcoVdAqkT3l4JLQIaioxIXxnQCYB5RrrhNd4htzlrqzkja5LfbnNys+7Z6X/JTKrpNEBjlossfCV69/nB5/cmmZry3ltfPLsxwV0NoiOoq3AiFh0dU/ZbpcpUyuWjFACq1REtjU5lTrLmjWvNCQPVIp/Mb+0janaVC9vDZxiAQ2V0tXuDdIJcgi2D66MhFJth5GE8ArLzABNYrqPKRCcC6R1kuAPsK2iM9xB876Cd17rkgZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqMnwLVCMtn+MVtWPErdqxepWwLdrNLoj4fi8cjmSXo=;
 b=MrIy9U2ZkMtki2m2NpC7tdu3O09KsFpyYdIDw6GbtOQQ/QCAktsqFf9zuxYZhpk+rt3DCiBtnqDnnPCBtlgrH6p++mui9YP+GaNqxrSJFxUlM95aym+8si+GvLWKZuOUU7XYrnF4kt87FavrPYoCFTQmXgQGXa1rm7pZ9g/w8Ddnm2KgVkQpLDA7gEt3+wJsYaQexcEkiPMNthcB0mMMUnYaEKU4ScnRNssPX65pkgJXpgTOFEN7O0b0R2BwSYddCecwIgCVpcMS5MnXtkwNyd/aG0UnBDk1fL6zlTRuDfbMg7USCSSWSBoUA+kSH5gT6nntKMh4vOMdP37ladP4Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqMnwLVCMtn+MVtWPErdqxepWwLdrNLoj4fi8cjmSXo=;
 b=U9s8a+kK1nFZSaRYqgGoioL2ScXyNpMV1ab2TecfhiiT8x9gVWyy6Wy4WrHW05Ksrd7fVV6h0kqwH/ivUL4Orm0poHIL1w9eD9vyGu0rjPhU2dkGAu8QZEq9zmjFKxF/B3rMABxNoVQYzB3ic+zlzOtOG1xYVbvKO/wQw4Dqs1E=
Received: from BN6PR03CA0076.namprd03.prod.outlook.com (2603:10b6:405:6f::14)
 by BYAPR12MB3639.namprd12.prod.outlook.com (2603:10b6:a03:db::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.28; Thu, 30 Jul
 2020 19:12:37 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:6f:cafe::f9) by BN6PR03CA0076.outlook.office365.com
 (2603:10b6:405:6f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Thu, 30 Jul 2020 19:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 19:12:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:36 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:36 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 30 Jul 2020 14:12:35 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/16] drm/amd/display: [FW Promotion] Release 0.0.27
Date: Thu, 30 Jul 2020 15:11:45 -0400
Message-ID: <20200730191146.33112-16-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200730191146.33112-1-aurabindo.pillai@amd.com>
References: <20200730191146.33112-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7ceb9c3-eff2-46bf-00c2-08d834bc8593
X-MS-TrafficTypeDiagnostic: BYAPR12MB3639:
X-Microsoft-Antispam-PRVS: <BYAPR12MB36395E73EF164133F57BBD5E8B710@BYAPR12MB3639.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibQqzVKvFem6Np/Nxnqglr9aD0c2vTBmnLtmMPEUJetK5jAKyu0KxiaNjZq7zl8NItDF1mzZMPvnrx+VAw8N8fcTPW2+ysNMTCfj+3EEH9y1HqGrvg4K8vUmLK9DwenWpUnrVCtgcjUOlWjtIKqZiG07JjPflJGvkqaLF0SjEPfOr3nr3dtLSpNvdAxXBKStLIjqeo5JJdD/LA4k1V9OmngupSqTHiPuowA48N3TQRooEyNks2ZDxBWJ9zK8OBtvc12w6TmYfkRJCvt+JNVR8OY+mwrBSCtJIapZ2ZO0UDVxsuPZpUsEOCmeVFvTq4pkx+EJtjZP9sd0K7sGFIzMqBgiXq4ImUIkLQK/UFAphBA7hu2gp71cNZYO6kl42OHuEGcuvDvhSgSKWdz5bEhhQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966005)(44832011)(36756003)(1076003)(54906003)(86362001)(70206006)(82310400002)(7696005)(70586007)(6916009)(81166007)(5660300002)(6666004)(8676002)(356005)(186003)(2906002)(336012)(4326008)(2616005)(316002)(83380400001)(26005)(8936002)(478600001)(426003)(82740400003)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 19:12:37.2005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ceb9c3-eff2-46bf-00c2-08d834bc8593
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3639
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

| [Header Changes]
|       - Reworked the FW versioning to include hotfix
|         and test bits

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 8b27cf0f1d51..55717ae4724d 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,11 +36,20 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x636e7b294
+#define DMUB_FW_VERSION_GIT_HASH 0xd7f4bb6ee
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 26
-#define DMUB_FW_VERSION_UCODE ((DMUB_FW_VERSION_MAJOR << 24) | (DMUB_FW_VERSION_MINOR << 16) | DMUB_FW_VERSION_REVISION)
+#define DMUB_FW_VERSION_REVISION 27
+#define DMUB_FW_VERSION_TEST 0
+#define DMUB_FW_VERSION_VBIOS 0
+#define DMUB_FW_VERSION_HOTFIX 0
+#define DMUB_FW_VERSION_UCODE (((DMUB_FW_VERSION_MAJOR & 0xFF) << 24) | \
+		((DMUB_FW_VERSION_MINOR & 0xFF) << 16) | \
+		((DMUB_FW_VERSION_REVISION & 0xFF) << 8) | \
+		((DMUB_FW_VERSION_TEST & 0x1) << 7) | \
+		((DMUB_FW_VERSION_VBIOS & 0x1) << 6) | \
+		(DMUB_FW_VERSION_HOTFIX & 0x3F))
+
 #endif
 
 //<DMUB_TYPES>==================================================================
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
