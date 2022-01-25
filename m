Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B20C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 10:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F33D110E328;
	Tue, 25 Jan 2022 10:46:32 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03FFD10E2A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 10:46:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6z5fgBaIWZ12E4412zC93T/bfq+Usxb+iSSr4Fyvk2PlP9sOcxoH9RKDmCgdCeml5xDdzQ6xHBOsx8vNtKlcY7HrY8RxLShO0UucLwIXrGXtquvVk/0E4g0KKVrnTUMTE2ZRrOeUItmHWYO9w+8sV8SlnywevnM/wqY1EIgBzh/VoVoW7Rgpw2aoOgGQPLq687hctc6dZwqMj6eHh2LmvTwwrVPLu1SBmIalOi5b46uiUu12xcYk1PFkwEnMQXCIMJKzSXkUrF5vEpR1gRK4mK2edT12oQf+8UweR6geB8F7K4voj1F4a6EEK6YvtoPl7hFyRjNYY+7nJA5WMyf2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvP5FfWcOzv0lY3rLtTuyPsdTv03eKhRxDmnmIDUHJg=;
 b=LUa4WZ0T3AA/SFxV5lpHNvxk83gozh6TElcGu3220pJCwd1j82TPRldBULbCBh29umveUI8vpwRucJLBwoqT98sHYGBR+OKMhRy8wfWTs+xsoSgVdJ3ukK1PKEZH4YVRhHVlz0+Uh35aVLeQB8yH9ZEYDI6+/D6moc4Zj5E45vyqAPMx9HAo6GD3mehiebVtKhD62Y9AXsJoypVLeIgsMek9CnEIGPMQ5tgPn8liQ66tJ3Lf1tBIXHP2l4CjsZ4CuQO3qLgLksE/uR+jzMb3rCMZ8Xl/asgGz7P2i0sVdnvnCUSb6SoawOKbulqKPG3SxlFnysDy+7Y0DWePyiOwKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvP5FfWcOzv0lY3rLtTuyPsdTv03eKhRxDmnmIDUHJg=;
 b=Ls3dT3JsTUnTpCrqwQIfI46jId00D0xYiWGgiOPYzmJFtZ2UMBaA9tX8y23qG9kA7PwmD1JsQuHQvu9H1hxt4X9UgnraiTA+u49Y+75JPXLymfP5XJqZ3mPJy/WkNcXW1ZdhQMQmPZwm/MJoerNgky5sFZtw21wMzfPmGA/emw8=
Received: from DM6PR03CA0095.namprd03.prod.outlook.com (2603:10b6:5:333::28)
 by BN8PR12MB3555.namprd12.prod.outlook.com (2603:10b6:408:48::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Tue, 25 Jan
 2022 10:46:29 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::f8) by DM6PR03CA0095.outlook.office365.com
 (2603:10b6:5:333::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Tue, 25 Jan 2022 10:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 10:46:29 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 04:46:26 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <john.clements@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: update algorithm of umc address conversion
Date: Tue, 25 Jan 2022 18:46:11 +0800
Message-ID: <20220125104612.27050-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220125104612.27050-1-tao.zhou1@amd.com>
References: <20220125104612.27050-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be0fdfa2-9ef9-44a8-2797-08d9dfeff1a8
X-MS-TrafficTypeDiagnostic: BN8PR12MB3555:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3555C451EF31CF371A8AFD90B05F9@BN8PR12MB3555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNln2wE5Ss1GjFUGUy1jF6cSzPfBwUIUX42Neh+LLaQ24C3+YkOPdXbZrt/aZkgO+kTR0VlVTIBzuYAdaRD4pDwLjK8XlQf0f9aPEeRKgcHtx3/XlPMuKt+OVKbmvYL7/Ez88eg9yVLmtzTo/9qXhbP/Q2LKEnFYuwZr8GbaiQwi2Q1nuydebS6paXgX9sg6rUdgtdrmz36UylwgywJ69LsStnhFni8GHeSLI68KxFGSr3/97A5FOBSgYKJ5WLjCFO8WnfsbV57GU/KQtnLCPmwlqyNEmKxSE/Phg1B+hqXuZ82j9emJyR6lpmP81QnYzwKOxjHJKYL6vebDx9B7dsUZESel0bjIIK8Eo8N+UjGnzo+n83juC7DPcBUuqajwSOmb0WwbJB8XqRHZ8nxsclwKvH4Q/eJE2Mfn+1oVHqjnijzzQXf0lfifxgdZ4vthkQ9SIe8yurooy72fmzpSw0/HMxrM9xkAgNgMKwb6niOlQSN+zveXGVvJeM4U+Wmep0yXYyost+zjIZCTPI6S3+g33fgrkChJK6SU8gjrMS7bk47+EwuDxXRasO7uOrZpxQtsgR4A1aAR6IX+SxXdBYePbztWpuWKhNSh3h29bOZxbPXCUDf071/DlTrsQ0IRtSE/HVfnHwbMwskCzM0YXRuBnaDdUYtEWeXJTNmacgDiVeJOVUNObKcTjBQJ3gwO0fnUyBLyH/zLGreWAQm59/E5dbVCe1vjqWrbTE1q1CKZuuQI53bIPIwbtEGtPNtrTNi5bNTh0NCpWbHu7Pefm3SVXrFp9No0lEEdXwuBQ9w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(46966006)(36840700001)(2616005)(36860700001)(8676002)(70586007)(508600001)(40460700003)(82310400004)(186003)(4326008)(36756003)(336012)(5660300002)(47076005)(110136005)(26005)(2906002)(81166007)(15650500001)(86362001)(7696005)(1076003)(70206006)(16526019)(6666004)(426003)(83380400001)(316002)(8936002)(356005)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 10:46:29.3361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be0fdfa2-9ef9-44a8-2797-08d9dfeff1a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3555
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On ALDEBARAN, we need to traverse all column bits higher than
BIT11(C4C3C2) in a row, the shift of R14 bit should be also taken
into account. Retire all pages we find.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 41 +++++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.h |  4 +++
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 300dee9ec6b4..1ecba7b5df1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -119,7 +119,7 @@ static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 					 uint32_t ch_inst,
 					 uint32_t umc_inst)
 {
-	uint64_t mc_umc_status, err_addr, retired_page;
+	uint64_t mc_umc_status, err_addr, soc_pa, retired_page, column;
 	uint32_t channel_index;
 	uint32_t eccinfo_table_idx;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
@@ -145,15 +145,27 @@ static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
 
 		/* translate umc channel address to soc pa, 3 parts are included */
-		retired_page = ADDR_OF_8KB_BLOCK(err_addr) |
+		soc_pa = ADDR_OF_8KB_BLOCK(err_addr) |
 				ADDR_OF_256B_BLOCK(channel_index) |
 				OFFSET_IN_256B_BLOCK(err_addr);
+		/* clear [C4 C3 C2] in soc physical address */
+		soc_pa &= ~(0x7ULL << UMC_V6_7_PA_C2_BIT);
 
 		/* we only save ue error information currently, ce is skipped */
 		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
-				== 1)
-			amdgpu_umc_fill_error_record(err_data, err_addr,
+				== 1) {
+			/* loop for all possibilities of [C4 C3 C2] */
+			for (column = 0; column < UMC_V6_7_NA_MAP_PA_NUM; column++) {
+				retired_page = soc_pa | (column << UMC_V6_7_PA_C2_BIT);
+				amdgpu_umc_fill_error_record(err_data, err_addr,
 					retired_page, channel_index, umc_inst);
+
+				/* shift R14 bit */
+				retired_page ^= (0x1ULL << UMC_V6_7_PA_R14_BIT);
+				amdgpu_umc_fill_error_record(err_data, err_addr,
+					retired_page, channel_index, umc_inst);
+			}
+		}
 	}
 }
 
@@ -332,8 +344,9 @@ static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
 					 uint32_t umc_inst)
 {
 	uint32_t mc_umc_status_addr;
-	uint64_t mc_umc_status, err_addr, retired_page, mc_umc_addrt0;
 	uint32_t channel_index;
+	uint64_t mc_umc_status, mc_umc_addrt0;
+	uint64_t err_addr, soc_pa, retired_page, column;
 
 	mc_umc_status_addr =
 		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
@@ -363,15 +376,27 @@ static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
 		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
 
 		/* translate umc channel address to soc pa, 3 parts are included */
-		retired_page = ADDR_OF_8KB_BLOCK(err_addr) |
+		soc_pa = ADDR_OF_8KB_BLOCK(err_addr) |
 				ADDR_OF_256B_BLOCK(channel_index) |
 				OFFSET_IN_256B_BLOCK(err_addr);
+		/* clear [C4 C3 C2] in soc physical address */
+		soc_pa &= ~(0x7ULL << UMC_V6_7_PA_C2_BIT);
 
 		/* we only save ue error information currently, ce is skipped */
 		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
-				== 1)
-			amdgpu_umc_fill_error_record(err_data, err_addr,
+				== 1) {
+			/* loop for all possibilities of [C4 C3 C2] */
+			for (column = 0; column < UMC_V6_7_NA_MAP_PA_NUM; column++) {
+				retired_page = soc_pa | (column << UMC_V6_7_PA_C2_BIT);
+				amdgpu_umc_fill_error_record(err_data, err_addr,
+					retired_page, channel_index, umc_inst);
+
+				/* shift R14 bit */
+				retired_page ^= (0x1ULL << UMC_V6_7_PA_R14_BIT);
+				amdgpu_umc_fill_error_record(err_data, err_addr,
 					retired_page, channel_index, umc_inst);
+			}
+		}
 	}
 
 	/* clear umc status */
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
index 9adebcf98582..b67677867b45 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
@@ -45,6 +45,10 @@
 #define UMC_V6_7_NA_MAP_PA_NUM	8
 /* R14 bit shift should be considered, double the number */
 #define UMC_V6_7_BAD_PAGE_NUM_PER_CHANNEL	(UMC_V6_7_NA_MAP_PA_NUM * 2)
+/* The C2 bit in SOC physical address */
+#define UMC_V6_7_PA_C2_BIT	17
+/* The R14 bit in SOC physical address */
+#define UMC_V6_7_PA_R14_BIT	34
 /* UMC regiser per channel offset */
 #define UMC_V6_7_PER_CHANNEL_OFFSET		0x400
 extern struct amdgpu_umc_ras umc_v6_7_ras;
-- 
2.17.1

