Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3663606A31B
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ytxECmr7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91E8B10F2BE;
	Tue, 27 Oct 2026 07:51:25 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC2D10F2BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 07:51:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icTqSJWDIKuiX/G/fA2YHCP3Rn+/1bdduqqocqvwfRmGRsNL8wcreSWtPuZ4LXzHf9ZxvcV3GAA5CaM44yVw9ookllxvBdIIzr4sC/izDFCfkOlUv3R2an2JuULMopQ5oSOfFOwpW17ZI807PFMnsfk9Ey/RNSHIaJ6gCbnhvFfOrjqBYU6sHqWk5UYfLvMbItCSD0Mq7A5XV74nRuSfLJxJLcqCzxT2CWC27L8M5Elg7XJx6dVOFYNBV0GxD7YoBrZzcAuu4/8QBC8mDpNiH+zeGArTpPHZEBbcFQzYhzeY4VWfS/R38GbVR8ztEhrOLhsROIh/iODIGwKFHX8E6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCpYU6mnHVWe7DJMASI1ctdv2TKBRXoIhRP6Y7Yh/64=;
 b=OoCSJH86IkvlzUIWSiUb2fltAjaefDyHkKsHPqEsFkf1susvxiyVT5DsIK/TV3GQrN2pc+ddj7nQsvqg0+dPZJv7Bg7y0swU0y7o221mA1kbMFL4HVdnjwrLrkzrKpr/aEiSK6H5cdkgv9gecCkqLF2VRpXrpEIszshaYrQLQafortmvDE1cYLwkX3sknZXCWPM6ApQl9TUXQ+pNmnhzVcBWBAsD1MsBO+NHFhIs26FKJjwVMbjBBi8U1G/2CXHzENCasHySUg3OQh9iw38Lz8jd7XMYeXqfvs6b3jkiy2UTVpOJPeCu0i2VbaYuYXy9+vgkXPU5k4La5wydb9RkJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCpYU6mnHVWe7DJMASI1ctdv2TKBRXoIhRP6Y7Yh/64=;
 b=ytxECmr76Tyelo8ljZf3SDGGOovpOK9JHfIR+57fHtKT2jblBoCs2gL8wUFFrptE2XyCprT4psbRjRfP/0Xcspp5PrG/e5MwRO7XIAfe08qcD+ydzEc3BrvKE4bES2l9sUDbnyHsVnEDUJPhP+E7kU5aSQSxrE/5ozzXUCKP5ZY=
Received: from BY5PR04CA0014.namprd04.prod.outlook.com (2603:10b6:a03:1d0::24)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:51:15 +0000
Received: from CO1PEPF00012E80.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::28) by BY5PR04CA0014.outlook.office365.com
 (2603:10b6:a03:1d0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 07:51:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E80.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 07:51:14 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 02:51:12 -0500
From: Amber Lin <amber.lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Amber Lin <amber.lin@amd.com>
Subject: [PATCH v2 4/4] drm/amdgpu: Correct hung queue number for reset
Date: Tue, 27 Oct 2026 03:50:07 -0400
Message-ID: <20261027075017.121456-4-amber.lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027075017.121456-1-amber.lin@amd.com>
References: <20261027075017.121456-1-amber.lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E80:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ae04d6-2216-45f1-a687-08df33ff13b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|261026121527099003|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iJGDFGJY8L9F14oMiCYAH45AoD7FWPopcQY531dkU+XuOnMXbGUBurQS2efSTDlLWJyFmkI2Ptk66v9WncWbddTD5kAstuaXa/S9d0RdBfh5Q7zlbbs3FXgSvVe+wzLYEoY+oBGu5VtjTn3MvYuIHeKXc/uXh6pLIEgzKbKiyOyppQNwuVgCO8kGtfOgR/BAIL1cbbOj4brUzsw1oK68hLm9FV/8vem61khi+H6/G1EKa4VNC29wKcvgMuMKVJ+pCYd7OXmf3j5DgYXxtBBi3w4ToBQe8LCWGsMZjqw1qIT1CefZa/v8YpT8XYdL0w+RiQYq4LdV4Qt2z9AWM6c5rMjsBssDOo9xr4WVF6WJB94PG719q3Qf3GiVAFCSMkx0It9rssmlY0CkXBdb5d1ojiWTIRs4oIiHSmKXCJg0vOrnhBbo2JdGAlmGwbLW4a3Zem6r9bHFoGXtnmD/6MjCp9d1sndm133DlF7cPj97MTbm7WMEEt6Z/L3BrddK74X7Vux5gxGfgJW9Fl1ALI7YTcPg4O14ceS2uTtp6kZdbyVGhcLSW6t086WNi794SEqbq+iJoxdomAgnUrCBKJbeM93OCbDBd4cSacP3528vD3Ytac1hkPKUm9+0gl4dspcwerby4HNgGTQ7v6ghOZc+07ohm8axpCQHVyNzBVDCsuGKEfd433ZE5abukgyTcT0AKpUWq5OPnaqivTxKoIfSeg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(261026121527099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 69gy9OYaAKfwGL/Yj7p94tiTo4Yb5o5SyCnQvOtN4D6RDNxmWx+hUeh4SRYsFZW2/8roDb5wMnbCjCo4OxZ8ItyM1TermBh9+LgymgY1UO4Wl3HV9kcKEXF3YFSDMAQFXDWf2ElSoyNhbSwE1wIFW3tdKk3c3RRfuDzwCmoUP9fE+srxiJKlaEgV/e2luo6yAgQdxodtydkhA0zGiUOv7f7AXTSCuBR1KJ7i/uGFJcCHaMIntOfecEAm2rwe6pqUwHc0ZMeu5/AksVRKyTnmANn65kiDrFbL4YwYgUPoBHDXcYgDEaUrGC+ThMhtwXGYIcx/ccil9epLqJwlB14L7IULyk+Gl+xLKhHj5jB/X8+inf2j2R0OeLlbxEXu0/jACtoGGF5lYiqrJKWoRTwJLMeYD/sQPUTdM66e3tTbhqc5i3r0z0S5I8yGGeH+61Zz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:51:14.8685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ae04d6-2216-45f1-a687-08df33ff13b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E80.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
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

In an ASIC supporting multi-compute partitions, the number of queues
varies with the compute partition mode. We need to adjust the hqd_info
offset to get the correct hung queues doorbell offset and hqd_info.

Signed-off-by: Amber Lin <amber.lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 49 ++++++++++++++++++-------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index b58a9ffef4e4..d81e613081c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -108,6 +108,24 @@ static inline u32 amdgpu_mes_get_hqd_mask(u32 num_pipe,
 
 static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work);
 
+static int get_num_queues_per_xcp(struct amdgpu_device *adev, int num_xcps)
+{
+	int i, num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
+	u32 num_queues = 0;
+
+	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
+		num_queues += hweight32(adev->mes.gfx_hqd_mask[i]);
+
+	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
+		num_queues += hweight32(adev->mes.compute_hqd_mask[i]);
+
+	num_xcc /= num_xcps;
+	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
+		num_queues += hweight32(adev->mes.sdma_hqd_mask[i]) * num_xcc;
+
+	return num_queues;
+}
+
 int amdgpu_mes_init(struct amdgpu_device *adev)
 {
 	int i, r, num_pipes, num_queues = 0;
@@ -222,21 +240,19 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 		goto error_doorbell;
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0)) {
-		/* When queue/pipe reset is done in MES instead of in the
-		 * driver, MES passes hung queues information to the driver in
-		 * hung_queue_hqd_info. Calculate required space to store this
-		 * information.
+		/* When queue/pipe reset is handled by MES instead of by the
+		 * driver, driver provides the buffer for MES to store the hung
+		 * queues information. Calculate required buffer size, which is
+		 * the number of maximum queues. This number varies with compute
+		 * partition mode. We allocate the biggest size, which is SPX,
+		 * num_xcps = 1.
 		 */
-		for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
-			num_queues += hweight32(adev->mes.gfx_hqd_mask[i]);
-
-		for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
-			num_queues += hweight32(adev->mes.compute_hqd_mask[i]);
-
-		for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
-			num_queues += hweight32(adev->mes.sdma_hqd_mask[i]) * num_xcc;
+		num_queues = get_num_queues_per_xcp(adev, 1);
 
 		adev->mes.hung_queue_hqd_info_offset = num_queues;
+		/* Double num_queues. The first half is to store doorbell offset
+		 * and the second half is to store hqd_info.
+		 */
 		adev->mes.hung_queue_db_array_size = num_queues * 2;
 	}
 
@@ -526,7 +542,8 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 {
 	struct mes_detect_and_reset_queue_input input;
 	u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr;
-	int hqd_info_offset = adev->mes.hung_queue_hqd_info_offset, r, i;
+	int hqd_info_offset, r, i;
+	int num_xcps = 1;
 
 	if (!hung_db_num || !hung_db_array)
 		return -EINVAL;
@@ -551,9 +568,13 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 		return r;
 	}
 
+	if (adev->xcp_mgr)
+		num_xcps = adev->xcp_mgr->num_xcps;
+	hqd_info_offset = get_num_queues_per_xcp(adev, num_xcps);
+
 	*hung_db_num = 0;
 	/* MES passes hung queues' doorbell to driver */
-	for (i = 0; i < adev->mes.hung_queue_hqd_info_offset; i++) {
+	for (i = 0; i < hqd_info_offset; i++) {
 		/* Finding hung queues where db_array[i] is a valid doorbell */
 		if (db_array[i] != AMDGPU_MES_INVALID_DB_OFFSET) {
 			dev_dbg(adev->dev, "MES: hung queue doorbell 0x%x\n", db_array[i]);
-- 
2.43.0

