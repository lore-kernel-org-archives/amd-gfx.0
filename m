Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14173C5DF7A
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2318C10F73D;
	Fri, 14 Aug 2026 21:04:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JY2jjklo";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010058.outbound.protection.outlook.com [52.101.46.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF75910F722
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRAp3UVuuB2ThVgu82vMJmoi7MZ9ySJQQYcAsYTfevsEBSjWH5mSxaiRL5eCmsbFf+G/aKsMeocTeENmJemXJyWAKId8GQT4HedEhztVVkJ6WG6LQYjDNi45zE7X+9f/FZ00yPBkqnzwVH4G8lXoepZsD6jujf5S/O1A1dUpBhK2JjdfIrFHc2geohCQwIjjA56IVwPSCoTaPKja4IWrVQFSG2OKHsesFY/FftojvoDxi0EwnlQGwixlLcfoSVvhvpoUn6mORfDKJ+hkKv+RD1nUqhRhDepIxaXP10vzN1++JInp2qW2DdMYzXDVgbxjG3qEaAsbQFXEtQ4GzQomeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVg6238wJZlEjD3ISgbxt0ncazgsKQ/4MmbCeYvrMtw=;
 b=L5Bk60CFogVt+LuZNdCdW/h4eTwkqGwkT8MVX2fKycayfHBFaXpSOyCSvTKok0bfDfO2lvVGOQetK6emqHR1bZRWMCY/fQ//Ro4zqIax5LCW43cQSPdPFsYmW7KIMM/uzauxNsKTXydtyyfJ5Vruc+hV8O7Vpw0EDw6N0rhaK9BFsQ46Yf0VoXY89LHNIq3a2yQkmSi/j71Ws0nN820MUu6lVjjgQkaUgwhQFrXaBYuSsD6ztKbXMFhVtqy9iQEJYJ2VEn5eaPQYFwspjVjx+6/B/FTJOvRy7dEoyF5en8CXKBGg4U53MEbUi4/Mi7MH0vUE3BPZBZHEMzkxuIecoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVg6238wJZlEjD3ISgbxt0ncazgsKQ/4MmbCeYvrMtw=;
 b=JY2jjklo8ldjp93SghC5i2+w16Z8TaqofhxYFc+1TmuhTi6pZHeJf+aze+QdQk9BV0bAEJNMVb0++TgTYoM869sPc4nEq9feIEnpi1I5XlgSk0mhP5Mue+izAedOYsLM7Cw+nwRHmb44R3xoTD38ZHmFIg+66b7d0IGUYxnpAIA=
Received: from BN0PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:143::24)
 by MN0PR12MB6296.namprd12.prod.outlook.com (2603:10b6:208:3d3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:54 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::66) by BN0PR10CA0021.outlook.office365.com
 (2603:10b6:408:143::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 21:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:53 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:49 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 086/109] drm/amd/ras: record crashdump BERT sections as boot
 CPER
Date: Fri, 14 Aug 2026 17:02:23 -0400
Message-ID: <20260814210246.3067612-87-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|MN0PR12MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: 06140114-0804-40e3-ea28-08defa478c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|6133799003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: dK0Akv8JppVPCCQY9xSSd0Px5gUHLRcgzyFwXytaSDs1i3u7fNyW9HBnd4w/v5xQSLiLErKALLv7od7s+LAzcCWwa3YjCyiq3dl+IBOQ2pV6yh0mT7XoYf1tyAEXtSh3NE9cCe0y68x1b5Nqckd882tOwFfiiUhfDpJ+cKJsrY2dUwhY4jokJrsSMA9MwqdzPm4RTs5w8edCf5EQ3wbtESazia6/cXjCUJ37bot4VbmpwLT83iCX7uKMuZmK/lCzxLxn6suNUHzEAjvBLTlsulzwV8rhSisZH9JD/1ithYdgz7Wy/sKVNe81msxsD4dYqTDdq+2BBKLDEeAIJBxNvoGV7Kbr3W2GcBvLc5l1OJ7Vnu8XKrqxbJZ0EwHZoWg6tzbPh2mUgeKgojgQt5wiY0BidIb2c6fGV7JI1A7NT7Um7WJzmm+Xy27ovYRhYYCRlDg6pPGZKN4wdFJguoZSykNfXJHIr27ik0ZhMmdwTpSACrJCVUgA5ToV0vJx6mKIxoQJ6xDfsrmssJnJlBNGhy+ZCxaHTjxKhJ0VwEzsOJJedfi2fCOkd1y1xnOZOwGgQr8/66qAYu33PXF660rFxbDe38jscLvoRM7jakkGWpF9EGzZRFX6rltV0RaPK+2Wabwiz88EbuonGGGybOH6Q2uq5Q+uwrCjOBzslwzlarzujZcXcR2hbfHrYPcj/8LI7LORDKvTp0vpZZNa+aw7Tg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M2vPSL9rE597mDL6gfPtmDH17jbwlWLwGS4vVMG1uBEsjiRJy+T9rsuQKCKfMCNzr4860a8gbQcrftC0/Ir34/dEsgt/M/rKJdybI1TefBq6mvYyi6ZnOCB8MVeMUGYPyQaF5PtQytx2sNzwFuERNIKxuJBC7XIQYupu6STVXj2Wk4+mNEhVyQTZJx0u5AAL+AblBQ65I8b1KSxQN8Y3a8/uGMUnuYP2cHVsLLVbxOXRb92tO4l7qu93VRAGmdiP+zJXkY0kVnErxNwbeYi5puVANdFHUEMACrsUqRdQgwQun+ICf6p1P50S0xxEOab8fOww0wkTfo/NHIBT8z0aUGGrJ74Gf95uuJntP10/tbaQokGI5L4V4Mqc4o2FzCFGMexmQzcH6dFaOC8VlJMc2ELI0TxYB+Juv62EL6WB5hh7eGmImWSBigrL009VZRYb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:53.4905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06140114-0804-40e3-ea28-08defa478c38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6296
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiang Liu <xiang.liu@amd.com>

Add a small section dispatch table and record AMD crashdump sections as
RAS_LOG_EVENT_BOOT events. Preserve the original section GUID,
severity, and a bounded copy of the section payload so the existing boot
CPER generator can emit records for debugfs consumers.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_bert.c | 61 ++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_bert.c b/drivers/gpu/drm/amd/ras/core/ras_bert.c
index 991c3fa164b27..474b2836dee77 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_bert.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_bert.c
@@ -113,6 +113,53 @@ static int ras_bert_estatus_check(const struct ras_bert_hest_generic_status *est
 	return 0;
 }
 
+typedef int (*ras_bert_section_parser)(struct ras_core_context *ras_core,
+				       struct ras_bert_hest_generic_data *gdata);
+
+struct ras_bert_section_dispatch {
+	const u8 *section_type;
+	ras_bert_section_parser parser;
+};
+
+static int ras_bert_record_section(struct ras_core_context *ras_core,
+				   struct ras_bert_hest_generic_data *gdata)
+{
+	struct ras_boot_err_ctx ctx = { 0 };
+	u16 data_size;
+
+	memcpy(ctx.section_type, gdata->section_type,
+	       min(sizeof(ctx.section_type), sizeof(gdata->section_type)));
+	ctx.error_severity = gdata->error_severity;
+	ctx.reg_ctx_type = CPER_CTX_TYPE__BOOT;
+	data_size = min_t(u32, gdata->error_data_length, sizeof(ctx.regs));
+	ctx.reg_arr_size = data_size;
+	memcpy(ctx.regs, ras_bert_get_payload(gdata), data_size);
+
+	ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_BOOT, &ctx, sizeof(ctx), NULL);
+
+	return 0;
+}
+
+static const struct ras_cper_guid ras_bert_guid_crashdump = GPU__CRASHDUMP;
+
+static const struct ras_bert_section_dispatch ras_bert_section_dispatch[] = {
+	{ ras_bert_guid_crashdump.b, ras_bert_record_section },
+};
+
+static const struct ras_bert_section_dispatch *
+ras_bert_find_section_parser(const u8 *section_type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ras_bert_section_dispatch); i++) {
+		if (!memcmp(section_type, ras_bert_section_dispatch[i].section_type,
+			    CPER_UUID_MAX_SIZE))
+			return &ras_bert_section_dispatch[i];
+	}
+
+	return NULL;
+}
+
 int ras_bert_process_records(struct ras_core_context *ras_core,
 			     const void *bert, u32 bert_len)
 {
@@ -120,6 +167,7 @@ int ras_bert_process_records(struct ras_core_context *ras_core,
 	struct ras_bert_hest_generic_data *gdata;
 	u32 estatus_len;
 	int remain;
+	int ret;
 
 	if (!ras_core || !bert || bert_len < sizeof(struct ras_bert_hest_generic_status))
 		return -EINVAL;
@@ -152,8 +200,17 @@ int ras_bert_process_records(struct ras_core_context *ras_core,
 
 		gdata = (struct ras_bert_hest_generic_data *)(estatus + 1);
 		while ((void *)gdata - (void *)(estatus + 1) < estatus->data_length) {
-			RAS_DEV_INFO(ras_core->dev, "unknown section: %pUl\n",
-				     gdata->section_type);
+			const struct ras_bert_section_dispatch *parser;
+
+			parser = ras_bert_find_section_parser(gdata->section_type);
+			if (parser) {
+				ret = parser->parser(ras_core, gdata);
+				if (ret)
+					return ret;
+			} else {
+				RAS_DEV_INFO(ras_core->dev, "skip section: %pUl\n",
+					     gdata->section_type);
+			}
 
 			gdata = ras_bert_get_next(gdata);
 		}
-- 
2.55.0

