Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22863C5AD4E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD73310E66A;
	Mon, 10 Aug 2026 06:50:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BMkdX3No";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C50C810E66A
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 06:50:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsslR6qjkBDY0P30/6VOs7i7MBN61nStJZVzvyb9cIGiSlyZauysG2FlxHIZgRsRR4nHKEkc+i+0Mw4OR41Wq186u5Ne3FR0uRP1EFvKEN62ricccrsKyTT9U9Oe2FSRJRwa8g1N9R6NuiP9MUwfCaHWSkcTtsoV2iKGoqhghrgY9Q0tZ2fcoXv5T1hLnZKBaWDB9+Rye0BhNPeCQ1ZHG8yXc11VlDO69JPfznzEfR5MNWVYYeTTOstrmArj3iS0P9ct4YPVzdRhe7Farn4Uf7rPeUZD4qMKhHtCNLT9PH7A//sMNYC4m/F3Ah1R1YERPmtr5Evh+pHEDesPRx3FxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdUGP9Oq93weqyg+ogeI3n7z1Udo5kgPWmoMAO4r2uE=;
 b=imDNlMjPUb7ep4iOEkr+nn2ufXwgvvN6OtMCaG1KjKr5GmGJjJVWuVn/2Lz3oE2w6gudwFr+oiESHmq8mpajdk9wq+Nw7DFh1yno6o62BFwwoP0ulwPT489BIyE3fauTMKKLi1FzfcMkYIUYeoJONGR4yCGwDHCHlwQsowDZAmo+IL21SE+qFZwYNvmUUjCCC4WekNdwTadn3uxkWNp2lMhgz2DPCewJWFnv0cPL/UjX8EhgK4dnm1OiRTkRRkMr7agHfRqrkCLyYNXnreqV5GP6wl5rVdO9KWelXx+uTXycz1KpqfXlC6MvZ8ckO7S0peGhv1z5aPa21aT8s5MnSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdUGP9Oq93weqyg+ogeI3n7z1Udo5kgPWmoMAO4r2uE=;
 b=BMkdX3No7qBx0kFPM8htV+eGiqDON6opfphdQXVfIoyMHGTYjfPNP2bYvA/Es3LrcNilbFiwIH3kgWlARSCY5SaLOfbjulArcluv69bNA3T1SSr2AX/uqT7xxPZ8KvKSU/5umWi+mxYhOhlUlAxDvThAs3YaOpz59YvwZZbgLMQ=
Received: from CH2PR07CA0045.namprd07.prod.outlook.com (2603:10b6:610:5b::19)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Mon, 10 Aug 2026 06:50:04 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::5f) by CH2PR07CA0045.outlook.office365.com
 (2603:10b6:610:5b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 06:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 06:50:03 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 01:50:01 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amd/ras: ignore ras eeprom init errors
Date: Mon, 10 Aug 2026 14:49:52 +0800
Message-ID: <20260810064952.3122893-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b9c8c7-4a05-430f-3355-08def6ab9b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|56012099006|11063799006|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 9mWRuBh7UBvvNcFAncXHTrPu4ogmTBJJAy4mdTie+5mxg3W98znhJ6ALWQ7vDNUGYQ3RszIfIXCPYCs2qDtOf8MibMSRzmrbddDgtqKNUa+FgLHjCS7NI/8ppKTrES1WZGKAaEvWFILu7/VjDW2Ve2BLTB8VBopvg3hQEQqYZI7ATgOPa477W00Nv+nVzHmk5PhDZIc5bFnpqFXH0KIGLSHfW/IPtqRwawm+TNS/qhXr0OQqwQmEZkmJT8jO4KdZ8GHxjJIBmSN1f277xj8vlrStx2TrzY3nXUDU4MBiWlY0bNrGi7q1TTbvYolnEr+rOkIi6yucLOYM/F4Sz93POr5Zm+jN50STMgpradEed9srHMdVTQie2/YsOB1gmSziYq/LRRj83SKyyK1aDLMhncJre9nwt3tAXcK6oyOZp68F9joYuabMwar7B757UNkmEZCoZKCyosegJQSS4gZzUPkW5DnZimxeNaiLNGDe5wo1UMSG308q4BL52aSQB0Itads8qXWuNFxBW4uoFrzCRD2wGDvulC1m1cEfMgLZeONM3ycgJlsFgBzvFcRccb0ztcgzleInC+z9WRTgCQpq5F/zXnwTUvrlKQqnlPnNJ9mRrsX8BjFZPJSnfKY7jd6uaTyMrrEJ3mAK9Eummjc9Oj59nQ6Xzyr6pS26ovQAV96QHhVvhcRODVXg0fi8cpFN8Wef1cjw+gsaoUWATnI+sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(56012099006)(11063799006)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xuv1xuoI94D7W2HFHkTAbbJG8E8y2CfVx6L0d2euG/YnCtr9iFb8zxAl/N/+pyXKzSicu0CEyvlVBuc/NZhIO5sBq25Ru8L0PVsuv2dA5LHi6iQMTx+c8qLPdKYu+oC/k2A8/8P2mqP93XyLQlUuYqlz6Zu6D91qDgWlbxCy6FQZeGwW6PbjrFq/GWvgMnohDHJFZeIcQim60XAHjw+dOIYxqJBS4L9JiuXbbU1PcZbru7M4VniNpspOvdZ+cYIb3Y+Nt8g3S/pZ+S3KgETd4KxBvOANU1NsgirUOjYN1ZmYEtHlXlDf6Mc70f10nJqbc3AVkU/mMJRbl2sPARWEr7fxHyMLriBeEf65GMy4yYDuZU7INPEUnO0I0MrPJ6b5VKO5rd+ttZ7aFfgh1ye7+qWK4cC0bRzdLswlMFqdKGUj8p19Vf5rTf/uviE3VM5S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 06:50:03.7100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b9c8c7-4a05-430f-3355-08def6ab9b3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072
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

Even eeprom is not functional, other RAS functions can still work,
no need to block the whole driver initialization.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/core/core.c | 31 +++++++++++++----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/core.c b/drivers/gpu/drm/amd/ras/core/core.c
index 9d24d3b48d74..6e5503f53bbf 100644
--- a/drivers/gpu/drm/amd/ras/core/core.c
+++ b/drivers/gpu/drm/amd/ras/core/core.c
@@ -408,37 +408,34 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
 		ret = ras_fw_eeprom_hw_init(ras_core);
 	else
 		ret = ras_eeprom_hw_init(ras_core);
-	if (ret)
-		goto init_err6;
 
-	ret = ras_core_eeprom_recovery(ras_core);
-	if (ret) {
-		RAS_DEV_ERR(ras_core->dev,
-			"Failed to recovery ras core, ret:%d\n", ret);
-		goto init_err6;
+	if (!ret) {
+		ret = ras_core_eeprom_recovery(ras_core);
+		if (ret)
+			RAS_DEV_ERR(ras_core->dev,
+				"Failed to recovery ras core, ret:%d\n", ret);
+
+		if (!ret)
+			if (ras_fw_eeprom_supported(ras_core))
+				ras_fw_eeprom_check_storage_status(ras_core);
+			else
+				ras_eeprom_check_storage_status(ras_core);
 	}
 
-	if (ras_fw_eeprom_supported(ras_core))
-		ret = ras_fw_eeprom_check_storage_status(ras_core);
-	else
-		ret = ras_eeprom_check_storage_status(ras_core);
-	if (ret)
-		goto init_err6;
-
 	ret = ras_process_init(ras_core);
 	if (ret)
-		goto init_err7;
+		goto init_err6;
 
 	ras_core->is_initialized = true;
 
 	return 0;
 
-init_err7:
+init_err6:
 	if (ras_fw_eeprom_supported(ras_core))
 		ras_fw_eeprom_hw_fini(ras_core);
 	else
 		ras_eeprom_hw_fini(ras_core);
-init_err6:
+
 	ras_gfx_hw_fini(ras_core);
 init_err5:
 	ras_umc_hw_fini(ras_core);
-- 
2.34.1

