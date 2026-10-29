Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1054C606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 03:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KJktLWlJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6127D10E1A1;
	Thu, 29 Oct 2026 03:55:26 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013055.outbound.protection.outlook.com
 [40.93.196.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB81310FF40
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 03:55:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4cktVW/RmN2vLYh952RVOo1G+0Gur1a26jfJSCLRBbjJT8knC0FeqyUj8fvRvLOIFMUlkEbs916jpyZd0+yUhYB2I57MZvpx0xy2v00K/zkvOxelqN69HhaGTxn98yYVv2AH60Lgy5YvJCnSCAY1hDoF0qcsvoj1NkQpHjqAwdZu6zu22L8y1LX49xYikbWw1HV8uhC0qCCSkTg8gUHOB061ikX25kC6P1ShzARocuKfQSPlw4agp8ys7QNHyZTYh6gNnBw1W+hD2YyH1s8q8RXchsWAW7HZR4JcCk/sd2MDIzArTycUQkS3UJaHpbl3yfp+ZXfuk/nWUXeJlKpBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FdvLh954G2pGrF3UketFPl8EVhK8gAwN4aahoUuMD4=;
 b=e8fzs7lwidE9+C5LjSSAUrRbsW2ZarEm83JqISbAsT/OAohKWatOSTJAdS3StDthfOrlzVHRoTIxcoMoSGsdOdwOarulFi5u+6R97S5qA3tFEN8OKF5/17a3ONTVHpumxdfT3ZFIIzK7PdirIOiKxc/23/vHyhxwloIoUiTZL4ks8/3LKp1RgbqfQAsWxridk4R5kUd4qKFvAk9lLhowP3tltQ2Cbfr7J2Pxu5yKUwPmhMGorhODdVOorBDuNbaAgMa7tsK/73MT0SIsvChkMtKmwdPzMZbLOMnba+Yj7c4lUV+migrRG8SmnbOQULYo+XL9sQq5qlswkqlpFCeXfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FdvLh954G2pGrF3UketFPl8EVhK8gAwN4aahoUuMD4=;
 b=KJktLWlJAdaEx0dy3x5D5Di+q/KH9gP+EftBn9kcBov50y+aceD/0BzgEPWO8oY473DKlX9wcjZv552z4ov5mOqw0ld0h1xUmJuNJbiGRmwSO9mLfM176GAYlUfq/f/1nDm1SSCf1IES1kyvAVCJ/bN/xbZhmfJYGH7HlE+34f4=
Received: from CH0PR03CA0111.namprd03.prod.outlook.com (2603:10b6:610:cd::26)
 by PH7PR12MB7329.namprd12.prod.outlook.com (2603:10b6:510:20c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 03:55:15 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::39) by CH0PR03CA0111.outlook.office365.com
 (2603:10b6:610:cd::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Thu, 29
 Oct 2026 03:55:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 03:55:14 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 22:55:12 -0500
From: Kevin Wang <kevin.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: populate unique ID for smu 13.0.7
Date: Thu, 29 Oct 2026 11:55:01 +0800
Message-ID: <20261029035501.2334248-1-kevin.wang@amd.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|PH7PR12MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: 551f382f-ac96-46ad-b32a-08df35707001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|18002099003|261028144727099003|261026140227099003|261021121427099003|56012099006|11063799006|10067099003|261009223027099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: V/kkrJQMN57SYRGF1oAtcfxUdSa58IgR8GsDEJ142omHl5UYA1kyDb4PPuxkGYiOD1aCgEwvccZmqA5eEPhVP5eecpmRu5NoKpQOcbu2zPOlOl7rXEEq7rTdMep1uC6Zz0MqJkVoifz+/zZm0hF5PYiz/6RpgMejkfMnvaW4WCYOH/A04I6v6q54stnwEoq9Hxg9AUUoJgPy9KaleoR482pN23fnuh+7Vj9rTGWyMydgmNi8hUan0f/umA+4t8WTPMD4mAInju7b5R5gDzJ1v6j/7LI5aPGDYgt95Gs8Co4HpzNbfeDj2BV4T9CErSBhRd/UkXvPEXodbXfB2y48UbAxK2coNDQUA9e7Bb4dp2u/FyQPaP14vRMQ7Ac3yFzu8U68dVXxj8LW3RbdPuENKbQ5tZ3zNaMblx+NPvFjZP0PFUiSiCO6+CXJ39/BvCGtInxudvPg9T92jsOcaN0wW3QB51ydIGHztpRAbUcRGg0noJdPDORhjzaiTY6xso0qF/3JnPnHA47gcHz0dWDSti3Kq0gcV5CutBZ+bLsLGrDiFRVHYwK1WqjQ/ADvlgkXLxoenJeC+m1+XWNoLV84P5viej0chemYiSFaPSXRxdtWsiIoLP9PNyT7ozYlebMQ2XItF9XWJPzyMBeh+DADtWhKunB0XMbkzCHioSf9kAbyrSFB2OyN+g9S1jpF46DGHcOlyj2NZWrjUd9+Dz+FDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(18002099003)(261028144727099003)(261026140227099003)(261021121427099003)(56012099006)(11063799006)(10067099003)(261009223027099003)(261022105027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2eri0RNuI5Bjhtv28eKyALsuprSdT/Or54NAXk/toAiyfEJs3Wq2E/kezxzQtb6dvr0daFj7AuLUSbfazCGKcWPSNsAclWxvfXaIDhrg82bNv6z/UMEwtUuJhfA9MopXYnF0daRSFW4HZGLjI+d56rCz/Iul4SiYsKk6vqaP3uu5tBzMQRow/tXWliPVOG82W+QdKxmYbgUUb7SsDHgGU34/s9CoX+ZsoSDfWH7QiEntj7ZUh8RQjq7Gn7jwyvndiE224Qr/uGBKNn7PrIMsdh++dykm7J/zm6iVtt0ABOJrLqOHYLUhC1Q/gputQiObdi6PyPPa9nu2PWujurSD0mnIS2QczCJy/TOZlp0oZ8XoxPgkU4f4O/BDLHdw5JTPHKQCpGB/iZllTUCIJA8yYCJu7cEbx5Kk6vpL0kOE5xlDfhBilrxAMABmsAx2Zx1l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 03:55:14.1112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 551f382f-ac96-46ad-b32a-08df35707001
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7329
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The smu 13.0.7 backend does not register get_unique_id, leaving
adev->unique_id at zero and KFD topology without the stable GPU
identifier consumed by HIP.

The failure is observed at:
    auto ierr = hipDeviceGetUuid(&uuid, 0);

Fixes: 113cc31dde66 ("drm/amd/pm: add SMU_13_0_7 ppt_funcs for SMU_13_0_7")
Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index f4543da0f72d..7d795f2c582f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2943,6 +2943,25 @@ static int smu_v13_0_7_mode1_reset(struct smu_context *smu)
    return ret;
 }
 
+static void smu_v13_0_7_get_unique_id(struct smu_context *smu)
+{
+	SmuMetricsExternal_t metrics_external;
+	SmuMetrics_t *metrics = &metrics_external.SmuMetrics;
+	struct amdgpu_device *adev = smu->adev;
+	u32 upper32 = 0, lower32 = 0;
+	int ret;
+
+	ret = smu_cmn_get_metrics_table(smu, &metrics_external, false);
+	if (ret)
+		goto out;
+
+	upper32 = metrics->PublicSerialNumberUpper;
+	lower32 = metrics->PublicSerialNumberLower;
+
+out:
+	adev->unique_id = ((u64)upper32 << 32) | lower32;
+}
+
 static void smu_v13_0_7_init_msg_ctl(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -3026,6 +3045,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.enable_uclk_shadow = smu_v13_0_enable_uclk_shadow,
 	.set_wbrf_exclusion_ranges = smu_v13_0_set_wbrf_exclusion_ranges,
 	.interrupt_work = smu_v13_0_interrupt_work,
+	.get_unique_id = smu_v13_0_7_get_unique_id,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
-- 
2.55.0

