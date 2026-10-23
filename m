Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72558606A31B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=x75oFdZL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65B0F112C75;
	Fri, 23 Oct 2026 17:13:01 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF69610E5FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 13:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CE3fnC/0A10uVlgi4LADKzlOzV4W6sjVherlBCi2mA/0vJzbxpK+nDYPCIPsmPkgIsVEdn6z3J3q78clcIvk9Cta0YHP/ew/hXKvQWrghoUtRxT5+1FuZlBH7DGtIk74CIGyDQKhQb4BzJjawD2tU93js64RA5ejv4xK73e2Hnb/K450SlEALQ9RIu0z+NMKhNSRPH6edXZ1od/AzS+lzmUspuVBWzCywL2cj0UBeaJXRswsA44ij7hDZ624Y8kHZTKoNqMmRgB7XOy1AfUs/dBEpfcVepj3L4cKIovHru8TxsDJQzWHzVOZZCHogei430Auu9BUlFNvWp4iaIPmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqR2YGfKjaRXJDN8kFWdMLw0j8ErXadtQKZJ9rpavxk=;
 b=ha2QxIgmZs+7PKsuU1kvPEPyQMzgOE/1tcu3UQ4W93mTafAjyr4RwfIeuT9hu7NREeMXJ5hGsR109AO1RtpzdgI/sthXQprSmvZTowSOnKPNJxJ8iGmFyMTlnHP3A/Too2j6mmn7pppJzwShDX9c7kpsCbr5t2HApICVnF/BsfPOqZNaD6NCqdbD+w4QHzPgUzH7g9MiGJSkjfBkqdB+TiIkzuRe+DIWa9gYt6RdCyX1DUhCOOVlt5azR38bULCaPqOWmsfOagfOfTxhzBvXo1c5KMgvME9UmS4fyEnp2Yn8HNxVwC/zkt26EovF2H8F5hg9xuXjtn/TLokuY2tGKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqR2YGfKjaRXJDN8kFWdMLw0j8ErXadtQKZJ9rpavxk=;
 b=x75oFdZLMmLhtwz6Ra+w174Ukm9yvi5pmS9zdpINm48+YS1Jg23w9zOwMbeoGeJqfHZUw2ym13cxbDrQDId1ncUrx8mLWcC6P6ViB8uKdxheD8TSYpOZ+aRnrp2KPr83BWZiQ+M6nSdj1bZCbfMTXIcLo0EBm1UGF0/lSVjjBXI=
Received: from MW4PR04CA0216.namprd04.prod.outlook.com (2603:10b6:303:87::11)
 by CH8PR12MB042578.namprd12.prod.outlook.com (2603:10b6:610:707::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 13:00:45 +0000
Received: from MWH0EPF000C6192.namprd02.prod.outlook.com
 (2603:10b6:303:87:cafe::77) by MW4PR04CA0216.outlook.office365.com
 (2603:10b6:303:87::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 13:00:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6192.mail.protection.outlook.com (10.167.249.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 23 Oct 2026 13:00:44 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 08:00:32 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <Kevin.Wang@amd.com>,
 <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Use a minimum version for NPM capability init
Date: Fri, 23 Oct 2026 21:00:15 +0800
Message-ID: <20261023130015.3230621-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6192:EE_|CH8PR12MB042578:EE_
X-MS-Office365-Filtering-Correlation-Id: b8ea95f4-f97a-419c-93cf-08df3105a68c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|18002099003|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: bKaLMIVAuUBjw6kLYQHjbDWAwwk77E6rgyY018IGFeG5GAbfG/sONgkJixqOzkhKxOZIw+X2fc+TEPCbB6o+DHJaTBUvVUbRoeNaJnyVn1W8h4fub1X9rCXajQNeAOAW/qoMEQKHK8j03XXiXecL+KstoplZbd3YDHoLXqeUFeCRaNtnypgCkx9PaFgu7E+3dOUwGhMcMFMLBG68UR1RuAHECu2m4yBd+lK+3BgXYi7jlon/budm47up/3RTChLq/lpoOV6avBvgy6l5Hdanb9Htua/0r8qiF6eHBuy0AGMMU/3jGinQuF5toMtKgcGSugFQY0v6f59YRGXYYeRWx/uSFGH2CU+fEPjd94V5HZarQ+4CY+LcN/mdsuh7AuuhugQBrnGhqu4GlkL3O0vHaTSkeQs/UekE7TgaYSzCi3ADQnu697IlQ/YSq8bfIIMT7yZumCWS1FIzLr2ibg0fmwe0pg9fMaYVvGTfDL5ehzr57f8MBsMz9Cv9wA05OQvWPopLG+I9vMpF+VZ0a9eotKwBWBbyjvzJMvKOYIDT7rdIvGdsAbh6XA0JCb+PeA4j4Way7ffYSekiaFwSTJ2RURETIZqrOIgoG+T5rIMnEU7jDE0yc/YJuDshNvccIIa9Ub+LqwrmESRUPRiV1niHD+aiZuu8WGQc+nsZm4fRll3Bb/d5exU++r7Kpn7YRPJV834ZanmxRbIBKXuc5LyNRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(18002099003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DdW6ppL3dX/diOvYxVD4GuyH+NWtwxeuVkKhekiV2kiIgfdbugfhqXdcHYHmFADl180qWWoCwF6jhJbgwXvsbLG6aNKmiftChZWDOehIpwv9Yk1w7V5kE9dFD2FVXNx4bmomMpGDsG8jyWWmnMR2GGyLQ0dbBOKvKt+mM2tJzsfYVxsgF1nyxw7eM+G1FKtxE7Zcg/fSFYYU4X+9iJSO6ZRfP9EfIWoKmgn9IC1uafcaC4a6sPKNABM9uwoZEnRiTf/0fGEQa1c2jbo8nRaPBuwlhMdAV78pc+j37Dhw8bbyQGtozoUK+2maMoPQ9ZU7nGTWSURMuzxUY9+RLr3dvwm7Z9eIAIXiqpkGRzXsZwqbGMlK8CyvRgsN6nT4B5iQcMmPO7BEc2dWaVco4bmtazzlaYQtBObEg+mkQRuWnQLRODPtv0pFQW2vMLc2wqYx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 13:00:44.7887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ea95f4-f97a-419c-93cf-08df3105a68c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6192.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB042578
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Compare the system metrics table version with the first version that
added NPM. SMU_SYSTEM_METRICS_TABLE_VERSION follows the latest header
and would drop NPM support when that header moves forward.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index f427efa23c4c..9663fe0d5e94 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -622,7 +622,7 @@ static void smu_v15_0_8_init_npm_cap(struct smu_context *smu)
 	if (ret)
 		return;
 
-	if (table_version < SMU_SYSTEM_METRICS_TABLE_VERSION)
+	if (table_version < SMU_15_0_8_SYSTEM_METRICS_NPM_MIN_VERSION)
 		return;
 
 	ret = smu_v15_0_8_get_system_metrics_table(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
index dff601bc0f9a..106b847db494 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
@@ -35,6 +35,7 @@
 #define SMU_15_0_8_CAP_NPM			1
 #define SMU_15_0_8_CAP_NODE_UNLOAD		2
 #define SMU_15_0_8_NODE_UNLOAD_MIN_FW_VERSION	0x027d0c00u /* 2.125.12.0 */
+#define SMU_15_0_8_SYSTEM_METRICS_NPM_MIN_VERSION	0x2
 extern void smu_v15_0_8_set_ppt_funcs(struct smu_context *smu);
 
 typedef struct {
-- 
2.46.0

