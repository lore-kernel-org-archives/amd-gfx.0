Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54881CA5FC1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 08:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC97F10F245;
	Wed, 30 Sep 2026 08:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bDwTLINw";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D363E10F240
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 08:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLRh8rqdJUnaXG8hzFpCnx/xDKsZXSnEaCaOzzgof1acJkHVLIp67gCpeL7irprvbOjL02LKXlNUsCwnIxfY2If+dWcfCgVRPod+VX2jLeZ4WA16yu15viSuZvPYyA+kTBjuQrvhRgSG51ByVfuQS7XoxrP2KzaBqr2cTpkDIxidfRfIB4o+I22h9N9tG99uYFzE2GrdCTM9QhrKqLf/5LkZU8/bsytqTMsl1Bw9AKsjJiwbRpf5TabGkwVuAFshgLvh983ToNudIP4wBgQe2PALk+yXaIt7jE+xbFuBzcPa9Lj6wDgSyPr5cLz3X1SNPghxUIF9JI+tMSkWw3OhUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=792OaopKEIlH+zkXwiKYxsOvCjdQTzV7mno62ZCQ8Gs=;
 b=WV6lJvwJm9GptiDsdRaTdiYOVd/oUHRtJanItiiYuv4Wj7jga7h4sSwKFpXbiN02Orc/5cCoyXq/HC3v9GJhjlYY0Kshl6+V9oOLFEo7wXc1nTh3VNA+20+Y+iQhutNbm0EnCKZ7wwwKwHUeLp0CxZCHPB4tcpB1lO0liat/A4acR0EmaUJJt5+tYh6paZmLzMO+HBASB+ydySqcvk1LJ5qu81YErjSKwQVSw4r9JWjPeMjEBo9LbksAKzFmXLIvqhwtyk0u9aJcgZaOM+GsNAQ4c2GAjsAzyXF9dghGkL0lEXtUmvmzA5NwMBoxutTe4pGfTUPO4Q/Jeq0pXZkcUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=792OaopKEIlH+zkXwiKYxsOvCjdQTzV7mno62ZCQ8Gs=;
 b=bDwTLINwiEzwJuGQq4gJbVZBNxG9pp1/N7NJYKjgITgFDNwzNRg+9A5FsO4qDPn5w3usfyYCVst5DFdQ3vDxiXDPU2S5cN3f2Pc4dvaLAHNeTriC/pzJLwSdUFeYDtXx6JROUdC9MOSgzG82hAJPdRDKmuyX3ZFMuPoUZe8wN+M=
Received: from BN0PR04CA0085.namprd04.prod.outlook.com (2603:10b6:408:ea::30)
 by PH0PR12MB7816.namprd12.prod.outlook.com (2603:10b6:510:28c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 08:40:15 +0000
Received: from BN2PEPF0000A98D.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::92) by BN0PR04CA0085.outlook.office365.com
 (2603:10b6:408:ea::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 08:40:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A98D.mail.protection.outlook.com (10.167.248.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 08:40:15 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:40:12 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 2/2] drm/amd/ras: use page units in EEPROM status messages
Date: Wed, 30 Sep 2026 16:39:45 +0800
Message-ID: <20260930083945.1362254-2-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930083945.1362254-1-xiang.liu@amd.com>
References: <20260930083945.1362254-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A98D:EE_|PH0PR12MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: b9dfb10c-5ff6-4c8a-f129-08df1ece730b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: BF1F1wpINZg5dSYc2rMuLLZE4UOSWuq8sKjTJjza8k4o6ZHKNm9cFsIa+pCeodY40MAImIJWz5qyFXAWGy55c/yCmVwSDggJpHrZWWQ7GzdybCjFud7geCQCvizGUW9TE4bIIDQxMpFH33LNfyglnHnWkfsxExURHoeCR7FFaHYgmGR6OZznfVBm+HsgZcW6l/cyhEB0ljMdhiMgSFCROvXbyShY+Tt1DoKoJlDO07B81TqBeI2OtHo9L6/AtzLFYDsM/CEZhenxsl//YlsQIt6fgFSz6kOnRImg3ltoiU/wrDEy0TSLTkd54vRmq96Fly2P3WpZK87hCutuu7E6S5pKlRtGpFmFgg4ryP4PvsOwGTdHpcO+4zu60syrcOj15HfiHGbq0VFA16tj4Q5yD+D37SCDeIG65YlqlIrDAkKyyNY96H1ELmmorRR5iHX+MVlGEcvH6ieDdZxeoBk1PueL/oj/BfRTNI3o2SzIIEsvm1ATHQW7u16fjqiSQe/1LQIWbnV2QxaKAJ1WoE2tRVR4nnCFs1WUcm4cBA0dIO76dXzkQarqAeZtmUmy//AzU0KAH7jNJh7hoaKrE+o146MvGclxSZr3pvvvwm0XXIihMafyFkuUgfWXLWdSEwCsCxfLu+OmhVwRVcVyAhy723k4o0tPn3v35MXSrKlvz61BzZ/nbL5E6rTPOgaBJc3PwXuadF2DvSQkr7fzJNg32Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A10QQ1CMtgwvS5ujHQAojdFFBWQInjfoXpWA3aEPYxj1Mg8iwtk81HK9ZyEhvGC8vGmoqGKObDlHmSxhCo64HE80kngRBXsQvMqaXl0Q8nps49l4Lsy5Q+Pd11xUXS8mGT+zLw3pdohzFzRZgsOabgxNDf0mKJX/oqXGH6B2yQHJGRVsqTCcot62adk+EVlnH/S79xO0YQNST23e3pm0UhDgl7I8C40c68XvcSmY6MyC6KUHsA2A8kabga/JC5f1ydoDnAFTmRs/nEkI298iIMZNOn8vZYDb86TLFhXUDmeRy1xh7PjNXaFF6TE23hnbqgHU7a8JDQuRQwGGDJDiduLlFudgmhGqZLzf2LXYpbyDamlhGeSqqTVJZuOFfnkAiy2ljlV1Pp1F+Z7uXF1pR/pL6KEsJTyaAD4bpeAajhesrB2Oo4X78IzmXkp/en0R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 08:40:15.1730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9dfb10c-5ff6-4c8a-f129-08df1ece730b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A98D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7816
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

Report the actual bad page count and convert the record threshold to
pages using the per-ASIC row size. Keep threshold decisions in record
units.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c | 29 +++++++++++--------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
index e90f89be7ebf..6cafda806d19 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
@@ -260,6 +260,7 @@ int ras_eeprom_mgr_check_and_report_status(struct ras_core_context *ras_core, bo
 {
 	struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
 	struct ras_eeprom_info info = {0};
+	u32 bad_page_count, bad_page_threshold;
 	int valid_err_count;
 	int ret = 0;
 
@@ -274,25 +275,29 @@ int ras_eeprom_mgr_check_and_report_status(struct ras_core_context *ras_core, bo
 		return ret;
 
 	valid_err_count = ras_umc_get_saved_eeprom_count(ras_core);
+	bad_page_count = ras_umc_get_badpage_count(ras_core);
+	bad_page_threshold = mgr->ras_err_threshold * ras_core->ras_umc.max_pages_per_row;
 	if (info.eeprom_status == RAS_EEPROM_OK) {
 		RAS_DEV_DBG(ras_core->dev,
-			"Found existing EEPROM table with %d records\n",
-			valid_err_count);
+			"Found existing EEPROM table with %u records\n",
+			bad_page_count);
 
 		/* Warn if error count reaches or exceeds 90% of the threshold */
 		if (10 * valid_err_count >= 9 * mgr->ras_err_threshold)
 			RAS_DEV_WARN(ras_core->dev,
-				"RAS records:%u exceeds 90%% of threshold:%d\n",
-				valid_err_count, mgr->ras_err_threshold);
+				"RAS records:%u exceeds 90%% of threshold:%u\n",
+				bad_page_count, bad_page_threshold);
 
 	} else if (info.eeprom_status == RAS_EEPROM_LOCKED) {
 		if (info.rma_status || valid_err_count > mgr->ras_err_threshold) {
 			if (info.rma_status)
-				RAS_DEV_ERR(ras_core->dev, "RAS records:%d exceed error threshold",
-					valid_err_count);
+				RAS_DEV_ERR(ras_core->dev,
+					    "RAS records:%u exceed error threshold",
+					    bad_page_count);
 			else
-				RAS_DEV_ERR(ras_core->dev, "RAS records:%d exceed threshold:%d",
-					valid_err_count, mgr->ras_err_threshold);
+				RAS_DEV_ERR(ras_core->dev,
+					    "RAS records:%u exceed threshold:%u",
+					    bad_page_count, bad_page_threshold);
 
 			if (mgr->work_mode_over_thresh != RAS_WORK_MODE_OVER_THRESH_DEBUG)
 				ras_core->bad_page_over_threshold = true;
@@ -320,13 +325,13 @@ int ras_eeprom_mgr_check_and_report_status(struct ras_core_context *ras_core, bo
 				ras_core->is_rma = false;
 				ras_core->bad_page_over_threshold = false;
 				RAS_DEV_INFO(ras_core->dev,
-					"records:%d threshold:%d, resetting RAS table header signature",
-					valid_err_count, mgr->ras_err_threshold);
+					"records:%u threshold:%u, resetting RAS table header signature",
+					bad_page_count, bad_page_threshold);
 			}
 		} else {
 			RAS_DEV_ERR(ras_core->dev,
-				"records:%d threshold:%d, not support to resize RAS table\n",
-				valid_err_count, mgr->ras_err_threshold);
+				"records:%u threshold:%u, not support to resize RAS table\n",
+				bad_page_count, bad_page_threshold);
 		}
 	} else {
 		RAS_DEV_ERR(ras_core->dev, "Error ras eeprom status:0x%x\n", info.eeprom_status);
-- 
2.34.1

