Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0257CD10F4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:28:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DC8810E5F2;
	Wed, 26 Nov 2025 13:28:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Tout2tr";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3391310E5FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:28:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AryR0zCbhY0swlWSQshtDXN+RqZk0Nnx1RZi2BPxU1XjlNjH8m7B9z1/SsejjpXejSQatT9i2jYQkMgiOuRp3m/A2BNeOM2W5IyAFppDDsPh9vt4pvm/7L+aN7zM/ZCzQlicHAHtNfV1Hv2UHnrnPVgk35Zd88gSNj+iTQX2dXm0ExOjuZf/R0YjhHtEVKX7RnB6FALv2RGe6EEfDsdcGCLGQyTSnO+1nxQmr7GJUgSw+tlyTWDJmb1dRDTRPkoMXwJGJkqhCckxm7qCgitCFiVWW67K6TI3MEMF5BtXU5pRtirmVPYlFbj3SOyMWIKnUvnTzC2FZv1TfawqDzJ5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSE0Bzvkkhd/Cc9Hz3PTPDdlJGLBPGPBedJOwutdN8A=;
 b=wPJzQMidGngwoXZ8x7aQkxpkkhPRIWV2sEKIcQBxSD5bcQ293TVDNkupQL+Bm2DjYv06RcQ3fs7ZmMntVjcvplGIFp3vNS4bAP/VaYI4/NaB4oKIDXlwbtBy7tVulRKYZ0GywwrkzdpldLAdgImCyWuc3yTO8TzfEO673PtbPYBxih6lgc+i7Dw2FHVGuHbOdpOvva+p8OvCIGqQJUbDt0RBrnkPkYEeC8rA6nYb/eNG6CXN4KRciHG3TT5LzfQypUqJxHx0An25szl5VAAfocC0ZeEEWn9HdVvzf468Uw5x8qqfpvO+S2huk3HEdRLVd/oXtKhG9vFd1lb+JiG19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSE0Bzvkkhd/Cc9Hz3PTPDdlJGLBPGPBedJOwutdN8A=;
 b=3Tout2trXietBqhpR8gKtIbgtTIBvw6nd9uW1o5vAgwgZcUdS2KuUfYsqn9rORCwgDOdcLKAfHKZvd62hsRCqtiwMA56W1Pios2LL4IAEUWhEHc5pqIPukQ/7FZf/7Dp3TpNnhbUdNhMKiNOM9TFmf8gKsbtc0jTxYZRGWEVeUs=
Received: from SJ0PR03CA0271.namprd03.prod.outlook.com (2603:10b6:a03:39e::6)
 by DS0PR12MB999082.namprd12.prod.outlook.com (2603:10b6:8:302::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 13:28:52 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::f) by SJ0PR03CA0271.outlook.office365.com
 (2603:10b6:a03:39e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 13:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:28:50 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:28:48 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 05/20] drm/amd/pm: Use emit_clk_levels in renoir
Date: Wed, 26 Nov 2025 18:53:52 +0530
Message-ID: <20251126132822.3266730-6-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251126132822.3266730-1-lijo.lazar@amd.com>
References: <20251126132822.3266730-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|DS0PR12MB999082:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d6fda7-2dcb-47e3-8cbf-08de2cefbcad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gq3aEwqodkl/0DtUfOC4E/WvIDKQ7yvfusK+jNZXqHHbfOy4oJhE5IrUn8Mw?=
 =?us-ascii?Q?8zVU6pJijpc+hLWKN5wOd4uXREEg1bHNtvJ46OfV8xb8CSDLrZYD6mMjnybf?=
 =?us-ascii?Q?Vw813EpetqRq9hPfXzn2nOpD5BzBbUEEDyTV4yI3c5zr8Konbp3lvDWT8FUw?=
 =?us-ascii?Q?kAeWcvOoJSGohtE5yNimlUSE2cZ/o4ns6P/r8NsVy/op3ao1AEG0zqxuJIc2?=
 =?us-ascii?Q?/zao95aVYDg3RkN5BK63qLXF5CZNVvowVYPNyrLJkA/E6+mkCG/zP6d5+S4R?=
 =?us-ascii?Q?fO5DEoaJBwueCRwSnXllEmM18KPPx7RkAhp2Zn85inXf5JmaFrn++ZvDBOhp?=
 =?us-ascii?Q?ToZA+aflvmWzaImwIs/LrMUCr/O4foOSlsqyeDyTEIzmhTTvTe4EWqyd+KWv?=
 =?us-ascii?Q?R+xFzgnb55bWfhtHmkdljkw2j1vUObEo4kv7dKLnUiA8mhlPYyK7ewalsnz7?=
 =?us-ascii?Q?hpNmoQY5XRJe6oceZC7ALxLseI/N3uHuZB3XZev8yxKx3R+mPm/9vgytKyoF?=
 =?us-ascii?Q?jTPYuHboaQvf20SFF7qElN6Ql0F6p2Z6pNbALqQaq0vwYX4GdEA+eSFf0zZy?=
 =?us-ascii?Q?qEMQvpaRG1VIdgQrqjX0ZNDSsCb0OEK3WTmEC6OjYAs/z4HQJUCmpd0MBpEA?=
 =?us-ascii?Q?dfWaB5CMokzwS+g0v68TkGLP+JO6KXSyUXcaioT+Gfz0jeoWmyHC2oEIc+u7?=
 =?us-ascii?Q?elQXeECtI58W62cnODD9H+5n8+eCtasSMX9vOMEr7ObyicUi3OQmI0/4iaY/?=
 =?us-ascii?Q?V6R4l+81raa0VD4Ax7Cb4ozUhUUnxpuEMafx6psCkYfiCr2y6NegT2Hyvyo5?=
 =?us-ascii?Q?r5DZyOcX407r4Vc8yiQ3gkobYZ4PQ3yUWYOf4VjL+M6REt2V1GHhyxoKDjsk?=
 =?us-ascii?Q?lUrOjr57+hg66j61ZN9wqASt1BW7ahpWg+a4I+aHQqBHckLtCV+PdLVuNdDl?=
 =?us-ascii?Q?bvM5JeDUv0t4WGm6xCJsIgnxzvBfj+wYA8Ht/cfMGHwpb45QCrirWKFjRX9B?=
 =?us-ascii?Q?cFcFGKUTmcKrC4yC0c6fgxKzI9BrJO9MhE5huL/J4qd+y3/zZswYHiHSPyKm?=
 =?us-ascii?Q?SWDsmj1ilbgVN49uskNOq7g0AcaYdCupbGbyZ7vWqUisQJiKckxUv8EexKVY?=
 =?us-ascii?Q?x0d6j2EcyaBXn+HML17DII1vooXjE5wd5+LvNlOXP08p4/rJ09EiO7O498Ex?=
 =?us-ascii?Q?+UpIF0QrmVpLPOc0tq4mpIg7yrQMawHkdKgKzPEX59ncD8E57inNa26KmHJD?=
 =?us-ascii?Q?20kUhCcYIKWVkr1Mtp2Kju7Rc4wwVR/c65kadJFEm0R72eJ9XiFqbpdrxTYw?=
 =?us-ascii?Q?5f1DE287hIFWc+jnAJjXmNVvgoZdY4MceMTY9zLEAY9A96FHyeLyffpy5K0Q?=
 =?us-ascii?Q?Us/X9YJf2cD9cxepkwxnUptn3NaJbaGkML9yfHErQST689BRV6XNJMLSpmw6?=
 =?us-ascii?Q?xMN+jQrVFuacpJ6XyUO+DDgEWlGqyWitwwpflVAC0u9rYjU1c9rOc2QilJkg?=
 =?us-ascii?Q?WIzKLzahgksuQKSfeWh63p6ofQrSKu78b9+Yt3IQzlUGwOJFyN0BHQaME9Pm?=
 =?us-ascii?Q?w+7RwMr7S6u47neGl5s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:28:50.6114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d6fda7-2dcb-47e3-8cbf-08de2cefbcad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999082
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

Move to emit_clk_levels from print_clk_levels

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 52 +++++++++----------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index eaa9ea162f16..45c0afb47c51 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -491,11 +491,12 @@ static int renoir_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
 	return 0;
 }
 
-static int renoir_print_clk_levels(struct smu_context *smu,
-			enum smu_clk_type clk_type, char *buf)
+static int renoir_emit_clk_levels(struct smu_context *smu,
+				  enum smu_clk_type clk_type, char *buf,
+				  int *offset)
 {
-	int i, idx, size = 0, ret = 0, start_offset = 0;
 	uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
+	int i, idx, size = *offset, ret = 0, start_offset = *offset;
 	SmuMetrics_t metrics;
 	bool cur_value_match_level = false;
 
@@ -505,9 +506,6 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_get_sysfs_buf(&buf, &size);
-	start_offset = size;
-
 	switch (clk_type) {
 	case SMU_OD_RANGE:
 		ret = smu_cmn_send_smc_msg_with_param(smu,
@@ -534,24 +532,24 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 		/* retirve table returned paramters unit is MHz */
 		cur_value = metrics.ClockFrequency[CLOCK_GFXCLK];
 		ret = renoir_get_dpm_ultimate_freq(smu, SMU_GFXCLK, &min, &max);
-		if (!ret) {
-			/* driver only know min/max gfx_clk, Add level 1 for all other gfx clks */
-			if (cur_value  == max)
-				i = 2;
-			else if (cur_value == min)
-				i = 0;
-			else
-				i = 1;
-
-			size += sysfs_emit_at(buf, size, "0: %uMhz %s\n", min,
-					i == 0 ? "*" : "");
-			size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
-					i == 1 ? cur_value : RENOIR_UMD_PSTATE_GFXCLK,
-					i == 1 ? "*" : "");
-			size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
-					i == 2 ? "*" : "");
-		}
-		return size - start_offset;
+		if (ret)
+			return ret;
+		/* driver only know min/max gfx_clk, Add level 1 for all other gfx clks */
+		if (cur_value == max)
+			i = 2;
+		else if (cur_value == min)
+			i = 0;
+		else
+			i = 1;
+		size += sysfs_emit_at(buf, size, "0: %uMhz %s\n", min,
+				      i == 0 ? "*" : "");
+		size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
+				      i == 1 ? cur_value :
+					       RENOIR_UMD_PSTATE_GFXCLK,
+				      i == 1 ? "*" : "");
+		size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
+				      i == 2 ? "*" : "");
+		break;
 	case SMU_SOCCLK:
 		count = NUM_SOCCLK_DPM_LEVELS;
 		cur_value = metrics.ClockFrequency[CLOCK_SOCCLK];
@@ -608,7 +606,9 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size - start_offset;
+	*offset += size - start_offset;
+
+	return 0;
 }
 
 static enum amd_pm_state_type renoir_get_current_power_state(struct smu_context *smu)
@@ -1450,7 +1450,7 @@ static int renoir_get_enabled_mask(struct smu_context *smu,
 
 static const struct pptable_funcs renoir_ppt_funcs = {
 	.set_power_state = NULL,
-	.print_clk_levels = renoir_print_clk_levels,
+	.emit_clk_levels = renoir_emit_clk_levels,
 	.get_current_power_state = renoir_get_current_power_state,
 	.dpm_set_vcn_enable = renoir_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = renoir_dpm_set_jpeg_enable,
-- 
2.49.0

