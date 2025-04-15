Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589A1C369B5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 14:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB0910E7AC;
	Tue, 15 Apr 2025 14:35:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hXo+kSam";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7485210E7AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 14:35:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaXjbSLMkJdEAt2DHD8usBFrYb7cOLT9Sf80PWkrarzu/k9D96SchiheSzxqPCh6zEFlrWOwzDnoFnh5SQVYuhRCoj6VvZSkytvJr0PabcBlXgDIX6xcQUn+/DB48e51YkJBAx44LNP4KQIw5AN/yP62JzLDPiKef6JZRJRUYRtgy1XGtZrrZ1DbNGSowTnj/0MMZvbW89pO/sTLUyCqwSPNxRMXoCd0fK5FVtfkfFBwyHiqkv/8FNNy2XPX1I19fC278kRR5x7gv9tJtbZ4sO6bLqKOOlY7T4nxSkLqSVrzsBvMADdH4DnexQZKLMR7OrNaADgGCx4izxYihvhc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRHuLYLsSsk+zcyh5nD5+xqEjunRcOs+DU+rz3FKNeA=;
 b=UsMPK3RmM/kdHMXjoPOFYGMDOq8qPzYXLf71oMwC8lq9kdGRsqk1ntN0GkiUm7HHiWiaQ6+1Tub1Ieaej7Uv0QIULo9n0tmZZdPppbYhw0G9WcvprUHKCOIyG6VWI4YBHGa0YXlmLoKgBixtGiKHYobnyUY7VgoJ83mSjvXimM3D/qrMGB87fDHCghmobQ6vRnUJ5d4/0zbqsv6tnrOVnhsnakEwCyZU11/0nLs8/Tk1YABL5unLaZhc0qiaZ2y9iirE9d4xTC8130R5aOUOU9rwVh1IQ0L0ac/pD5hGopi/2gzczQ50ARPmKgsRmWlwNJxyz6upWfdt7zYxfli2Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRHuLYLsSsk+zcyh5nD5+xqEjunRcOs+DU+rz3FKNeA=;
 b=hXo+kSamV/qW0p4bMshg2kxT8vtviwVdVrWEfEWV+7ys+t2Vi/nGNZyRllPn42RotBp2uJkH48vpYtkdV1Na5WhsEO+IEheZmdm5G9al0TTmkliK7fDRtZOsgikaVZm3Dz5n2ozi4AQvCrnQN4ST7ootBbvDXf3SiaTzD1hBFfE=
Received: from SJ0PR13CA0008.namprd13.prod.outlook.com (2603:10b6:a03:2c0::13)
 by PH0PR12MB8127.namprd12.prod.outlook.com (2603:10b6:510:292::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 14:35:46 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::89) by SJ0PR13CA0008.outlook.office365.com
 (2603:10b6:a03:2c0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12 via Frontend Transport; Tue,
 15 Apr 2025 14:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:35:45 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:35:42 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 2/7] drm/amd/pm: Update pmfw headers for smu_v_13_0_6
Date: Tue, 15 Apr 2025 22:35:16 +0800
Message-ID: <20250415143521.367895-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250415143521.367895-1-asad.kamal@amd.com>
References: <20250415143521.367895-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|PH0PR12MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d36fc05-ea11-4256-9542-08dd7c2aced6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4s6KPkL4xZYBDBsFtaxFlMQTvIMv4RaK1MlbRS7SdhDtQrgX/EE5VWn33GuK?=
 =?us-ascii?Q?w7jfrFmWv0ZT3OnaYvJaUSxdOB3JLHzvJH7NEEwWNaTH1f0MrZ1FOWeGd7e9?=
 =?us-ascii?Q?ngVZHUOC907MTff+ovUXD/IKVEBv56279rMhk3/CfaCKJjt2yOgyM/0uYn5f?=
 =?us-ascii?Q?ui/OoQjXadP4Njn+ggwmw65sHxy8GrAID8SbghSKcYIbCbS0cCl4Ni5yPPNn?=
 =?us-ascii?Q?rXMUxzhLuTPSC6TekuhG28AFh2ExKPrXXbeuAjUWbbC567mbMmRKJiK/wCVQ?=
 =?us-ascii?Q?hm1whrbrQ/hhgu/2OLp6u8nNX2gHvUEjVUeZFfVhTaIvgHCqIvuqsEgH+CGf?=
 =?us-ascii?Q?euI7CLWUNxJdkYs9G3BCw88E8VRH4apyheG5FHELq4PID423hYEnAvCjURrX?=
 =?us-ascii?Q?WTQO+qYwWSv5K3ZIA+CJbEItXH2jPlH8jcazu9ZrhdAXx4wHSvDRfmEc/Anq?=
 =?us-ascii?Q?hiJhkb7PKuxuKHAuOX6YZwZKL6fY/zqAb0U+ZS6geKH0JZ1BM4PWXcB5jsUM?=
 =?us-ascii?Q?7neaELKdQnD1vZ9V4/mO9xXwPzC0AZ0Mbhw9b3YTqif/ilTA/rQZWuUcbmVz?=
 =?us-ascii?Q?LjO+AI6kA94zjSR4G2RKBl/0YJupyPAKq9hPHwK4M/CuALlwpGktnN+7d6T2?=
 =?us-ascii?Q?8+iOgshpK9p8oMyNOKOFSAx+5aeR8Zqwd4GNOrrHD/XbhapPQCpfVHFgqEVM?=
 =?us-ascii?Q?yO6wroGVO08JDdfldFMN8+5uulyfjU9iydXxnZYMXV+AAvyHJGNvFgOHf6U3?=
 =?us-ascii?Q?OHCGGLMAczHH7jOm8D59mOdc1xKndjvcl+voVctviRZ6GfdNMA3Hx2EKhbGM?=
 =?us-ascii?Q?ifcVUYW0lAdKHHU7+tOBlAQs7xfLJn3W532igFpu38+r/FJXSoQIy8FtlkH/?=
 =?us-ascii?Q?57hlOR9EVloGA7o1/s6nR1TFLULLH92pQvBDj0g2YAkFolOkeb2Gq360rT7e?=
 =?us-ascii?Q?A3fUpBoL4Em5l7NiJxRrNJGDyOqiqGL+DzNrTeo03U3MNCk/yGDdPalKPB1U?=
 =?us-ascii?Q?AsEUyoCNJGdBVGYrJCsg5TaEhRLc0IBk0HNaU1q1dfGHNRWexfasnvfWXOvw?=
 =?us-ascii?Q?CAPVhbcZOwHGPQHNTr54HMxg2/Jp+bERiAMN+tgKEuiHKzVl1a4nIf8ljixF?=
 =?us-ascii?Q?X4T9RIN4RgRzHzANmKZ3pbqc5Jvngune5xDITSrAV/l5hmbxKMs5cbs7iEL+?=
 =?us-ascii?Q?xGCb2Eo39BiSOdWG0ZiMeNwhEaPti0IyqD+FLgkCLsXr6e+n7qHFWH9EoZze?=
 =?us-ascii?Q?0sirbhl16maznu3n+WHv3Q/Ng71qMJO8nmaVni17pc2WzcK9l5w9kIFZpes2?=
 =?us-ascii?Q?cW0VEY07rzSeqTEPSxZtmX4LlNAUGvKp7T+HZqnBIHF5pyfNB6anciZoi2pq?=
 =?us-ascii?Q?8rHiRoit3uW90sybKowRp4Vikt5bTinrC7x941VVdMx+OdJl0MqxAkPl+4qq?=
 =?us-ascii?Q?2XZe3vuymXFFr9zhtKuW9Q0iLvihLX0/Ps0nDjmzHdsLx4owB1/d6w9/NG+y?=
 =?us-ascii?Q?Px8dU36zIhhj5YYbujugwSpqyk3QaeB7cGnF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:35:45.5712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d36fc05-ea11-4256-9542-08dd7c2aced6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8127
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

Update pmfw headers for smu_v_13_0_6 to include static metrics table

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h    | 7 +++++++
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h   | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index d26f35119a12..3d9e5e967c94 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -459,4 +459,11 @@ typedef struct __attribute__((packed, aligned(4))) {
   uint64_t AccGfxclkBelowHostLimit;
 } VfMetricsTable_t;
 
+#pragma pack(push, 4)
+typedef struct {
+  // Telemetry
+  uint32_t InputTelemetryVoltageInmV;
+} StaticMetricsTable_t;
+#pragma pack(pop)
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 348d06a3200c..41f268313613 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -95,7 +95,8 @@
 #define PPSMC_MSG_SetThrottlingPolicy               0x44
 #define PPSMC_MSG_ResetSDMA                         0x4D
 #define PPSMC_MSG_ResetVCN                          0x4E
-#define PPSMC_Message_Count                         0x4F
+#define PPSMC_MSG_GetStaticMetricsTable             0x59
+#define PPSMC_Message_Count                         0x5A
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
-- 
2.46.0

