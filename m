Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E31F428C9
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 20:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AE7510E743;
	Wed, 15 Apr 2026 20:07:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sWRUU+Ee";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012016.outbound.protection.outlook.com
 [40.93.195.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2130A10E743
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 20:07:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YANuiE7UQp+3RpBKidka4d+x2mQcLHxTAO0BYQEHC4VDJlrU56I3lvkE1UlruDu56QQXkX7YGRGnEUPo+4ZzTGNNtpSJXaHMXrOAxA5kWsnpoT5iQs+p8cNhItreqlIHT7FKXaW0bQPjEuRUn8kGt0eLPJ7l1uyZhZxONSW3y8PF3CnC9ieSQDDmpnwVQEz0UTLjPdl/8ND0NMcCsUHnUfCA7hqFnsz/bqD7BOq66kSowjJlsRXnnxdX4qxl+iB0Nubhg9SF8Z81bMW3M5xcv20wgB2Vh1YcCXIj9w5DKndQ2Ox9ASh44PhoVGOfFC7DBmnSQXXx/+9l9QCHIQE0Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gGrF/UDBQDsB9jlcztLJGzlYIwrdIdsVHhVH/9VKjI=;
 b=C4EVQy3MvMySXgvoA1CdWKKJ6NLWhDkfBRpyD7Sc9qRkLPV75+FjO/QE5wPwKNG8rf0HtBlOhqyjF9/6gqiBSQCWZYfsBrffQJm/1ww0vW326m8xnltUHuiwb4i+lUzHnbR5LpSkOzp1JT7AWKAMPhwsJRpdkXV3OdZb5a5/NUuFTZ9ya6c5OEJ4pM9/LWFVY7BYjpJAeCUacHykZPv0Zi3DVUP0R7BZXNd1d2TBz0xJfFvAf0l+DzII6HdENqHIPD2/AzSOYMpmmHRHPzEh6ZvXUtc0HMAACx85ttWEL+RhUe+6PBLUpByi0gJdDIS3Ddm9J6LDgf0qAtjTc0mDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gGrF/UDBQDsB9jlcztLJGzlYIwrdIdsVHhVH/9VKjI=;
 b=sWRUU+Ee3Dy//XLBvY6obaHNtC6qlQXjJH0Nqo2L3gPoFv6zCUa67MW7Pqxz5ouAzd424gtQ1AxvenEV0TeUf2zGE76moU29aSVil33XWMv5WqU+xC90gWd3fXI3QihfCHUrQCsE1/KFAtI6TG4v3idAQEaw/5kCsXqfZmNWMXQ=
Received: from BY3PR04CA0002.namprd04.prod.outlook.com (2603:10b6:a03:217::7)
 by MW4PR12MB8609.namprd12.prod.outlook.com (2603:10b6:303:1e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 20:07:04 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::95) by BY3PR04CA0002.outlook.office365.com
 (2603:10b6:a03:217::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.44 via Frontend Transport; Wed,
 15 Apr 2026 20:07:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 20:07:03 +0000
Received: from bingma-dev0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 15:07:02 -0500
From: Bing Ma <bing.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Bing Ma <bing.ma@amd.com>, Bing Ma <Bing.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Add gc v12_1_0 ip headers v6
Date: Wed, 15 Apr 2026 13:05:59 -0700
Message-ID: <20260415200559.838180-1-bing.ma@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|MW4PR12MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: eb372ead-113a-4c75-816f-08de9b2a8fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: wesyLfvGV1EzaLOKPTgrQLe5S9yVFS3yJL3NVxOZJ9OQbqe5zKG6eROlB5xDrUy46laQS9ChhvU6S2mSbFkkNuTgFaecmn3JjrU++FQmFWvwY2nRA0IlPgRiuM+RISCx5WaKZ7Gzk7HmEQ16tonsFHwTTNy/5flM1dz0npDWwiYAFrjteCfBM23F86/CIchzdbRV6jgIWqAO65lEO9R8wwbyZARP3tv4+S88PxWvPQM7BZxirN1c856GxfGmX8hZzegSq/8en5/VJqns4zv0aAR4Ng5pu3X+HUqykM4GC8zWxogmUlHATXzQJ04A9P3Ws9oJb+xOG8cPMr9iAiPjYpmZFEDoMMa4EzLOlknrYvGLrn4TB6iuXYNClmqYfdtkUF64ePOlTHaJzhJoRrC4S+229ud9I3djZ05NzYNHVPNi/6bAx4YPxuo/gV9mvbH41FYhd3zzbNITial3exkM/WpzyOnWV0lwWIZOMSTDRZOvOkUTQ6HKxqH9/7oMsqOgaYm1twCac4UZqLdZ3nwWPbjmsqv5+sfH9d5e+u617bnSQv4mT1zm84oGpJ6U/Qqjsbj80QJgrhzkN9GByAGKpyTAgETeVsal/ZUlJZ7BMq1hR7tuKmTPrw/Kt+7TCtXdHw500VaUqHQAxQ9LtA/mMuusLYCgX7h1EqRGKcxiUU1Hi7NhhhNa2SScKnKnslcZr6Z77fnnbMsVa/vTA6vfPuDYgbOHDPFqwhRdjln0Suzb3Aekcm2qXrwn+Z4pwgkCrzy84GrztgZfUgOtMaYeyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bj1a4pgpV85PQRsw7E+i3hUzw/C31H46EQCaOQtWrikDbUhVGa1ItjCzECvZSku6uUgOEcG1GmnOI7G6vGel1dX3WuK29yXbYQIa6CE2UJrfr8lWMnxiT9swYknCfpIZEvPWStQYZN7dLfVeJdy4c9ITuExGXzxYW4rGYfB9CfGtqLkQgXRqVZSPWU4Xo2tMuHSLUQ4uVORL9y/k3wJj9TJfLXzMpUjoBJ9gJWi6gnlv0y8ZZl/9C9ij5/T9MuMDTO3Qn0Smoffb7K+p79mQOf/BNjnKBGqWopVMA4uVWav4utHK56s8xovVTdFoukQq+7IJGUBjBmuragrqsxjpHokbYkgqCbAIPEugJ+MLqUVgH9/GRzXwQ310CIrV611ExdI1J6PTNFUUqF2shUnhgQMwBGtVMiTZ6xkF0e77eOncEh+loUDdxIoIa3uQcbT7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 20:07:03.5160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb372ead-113a-4c75-816f-08de9b2a8fc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8609
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

Add header files for gc v12_1_0 register offsets
and shift masks
v2: Update gc v12_1_0 ip headers
v3: Update gc v12_1_0 ip headers
v4, v5: Clean up registers (Alex)
v6: Update gc v12_1_0 ip headers

Signed-off-by: Bing Ma <Bing.Ma@amd.com>
---
 .../include/asic_reg/gc/gc_12_1_0_offset.h    | 110 +++++
 .../include/asic_reg/gc/gc_12_1_0_sh_mask.h   | 455 ++++++++++++++++++
 2 files changed, 565 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h
index d6a2839b4682..025e5490e6f1 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h
@@ -5475,6 +5475,14 @@
 #define regCHA_PERFCOUNTER3_HI_BASE_IDX                                                                 1
 
 
+// addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_perfddec
+// base address: 0x34000
+#define regGC_CANE_PERFCOUNTER0_LO                                                                      0x36c0
+#define regGC_CANE_PERFCOUNTER0_LO_BASE_IDX                                                             1
+#define regGC_CANE_PERFCOUNTER0_HI                                                                      0x36c1
+#define regGC_CANE_PERFCOUNTER0_HI_BASE_IDX                                                             1
+
+
 // addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_cpwd_perfsdec
 // base address: 0x36000
 #define regCPG_PERFCOUNTER1_SELECT                                                                      0x3800
@@ -5761,6 +5769,16 @@
 #define regCHA_PERFCOUNTER3_SELECT1_BASE_IDX                                                            1
 
 
+// addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_perfsdec
+// base address: 0x36000
+#define regGC_CANE_PERFCOUNTER0_SELECT                                                                  0x3e80
+#define regGC_CANE_PERFCOUNTER0_SELECT_BASE_IDX                                                         1
+#define regGC_CANE_PERFCOUNTER0_SELECT1                                                                 0x3e81
+#define regGC_CANE_PERFCOUNTER0_SELECT1_BASE_IDX                                                        1
+#define regGC_CANE_PERFCOUNTER0_MODE                                                                    0x3e82
+#define regGC_CANE_PERFCOUNTER0_MODE_BASE_IDX                                                           1
+
+
 // addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_gdfll_xvmin_xvmin_xvmin_reg_blk
 // base address: 0x3a014
 #define regXVMIN_XVMIN_WR_DATA                                                                          0x4806
@@ -12080,6 +12098,22 @@
 #define regGC_ATC_L2_PERFCOUNTER_HI_BASE_IDX                                                            1
 
 
+// addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcutcl2ffbmprdec
+// base address: 0x353d0
+#define regGCUTCL2_FFBM_PERFCOUNTER_LO                                                                  0x34f4
+#define regGCUTCL2_FFBM_PERFCOUNTER_LO_BASE_IDX                                                         1
+#define regGCUTCL2_FFBM_PERFCOUNTER_HI                                                                  0x34f5
+#define regGCUTCL2_FFBM_PERFCOUNTER_HI_BASE_IDX                                                         1
+
+
+// addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcutcl2nhttlbprdec
+// base address: 0x353e0
+#define regGCUTCL2_NHTTLB_PERFCOUNTER_LO                                                                0x34f8
+#define regGCUTCL2_NHTTLB_PERFCOUNTER_LO_BASE_IDX                                                       1
+#define regGCUTCL2_NHTTLB_PERFCOUNTER_HI                                                                0x34f9
+#define regGCUTCL2_NHTTLB_PERFCOUNTER_HI_BASE_IDX                                                       1
+
+
 // addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcl2tlbprdec
 // base address: 0x353f0
 #define regGC_L2TLB_PERFCOUNTER_LO                                                                      0x34fc
@@ -12176,6 +12210,82 @@
 #define regGC_ATC_L2_PERFCOUNTER_RSLT_CNTL_BASE_IDX                                                     1
 
 
+// addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcutcl2ffbmpldec
+// base address: 0x37bb0
+#define regGCUTCL2_FFBM_PERFCOUNTER0_CFG                                                                0x3eec
+#define regGCUTCL2_FFBM_PERFCOUNTER0_CFG_BASE_IDX                                                       1
+#define regGCUTCL2_FFBM_PERFCOUNTER1_CFG                                                                0x3eed
+#define regGCUTCL2_FFBM_PERFCOUNTER1_CFG_BASE_IDX                                                       1
+#define regGCUTCL2_FFBM_PERFCOUNTER2_CFG                                                                0x3eee
+#define regGCUTCL2_FFBM_PERFCOUNTER2_CFG_BASE_IDX                                                       1
+#define regGCUTCL2_FFBM_PERFCOUNTER3_CFG                                                                0x3eef
+#define regGCUTCL2_FFBM_PERFCOUNTER3_CFG_BASE_IDX                                                       1
+#define regGCUTCL2_FFBM_PERFCOUNTER4_CFG                                                                0x3ef0
+#define regGCUTCL2_FFBM_PERFCOUNTER4_CFG_BASE_IDX                                                       1
+#define regGCUTCL2_FFBM_PERFCOUNTER5_CFG                                                                0x3ef1
+#define regGCUTCL2_FFBM_PERFCOUNTER5_CFG_BASE_IDX                                                       1
+#define regGCUTCL2_FFBM_PERFCOUNTER6_CFG                                                                0x3ef2
+#define regGCUTCL2_FFBM_PERFCOUNTER6_CFG_BASE_IDX                                                       1
+#define regGCUTCL2_FFBM_PERFCOUNTER7_CFG                                                                0x3ef3
+#define regGCUTCL2_FFBM_PERFCOUNTER7_CFG_BASE_IDX                                                       1
+#define regGCUTCL2_FFBM_PERFCOUNTER8_CFG                                                                0x3ef4
+#define regGCUTCL2_FFBM_PERFCOUNTER8_CFG_BASE_IDX                                                       1
+#define regGCUTCL2_FFBM_PERFCOUNTER9_CFG                                                                0x3ef5
+#define regGCUTCL2_FFBM_PERFCOUNTER9_CFG_BASE_IDX                                                       1
+#define regGCUTCL2_FFBM_PERFCOUNTER10_CFG                                                               0x3ef6
+#define regGCUTCL2_FFBM_PERFCOUNTER10_CFG_BASE_IDX                                                      1
+#define regGCUTCL2_FFBM_PERFCOUNTER11_CFG                                                               0x3ef7
+#define regGCUTCL2_FFBM_PERFCOUNTER11_CFG_BASE_IDX                                                      1
+#define regGCUTCL2_FFBM_PERFCOUNTER12_CFG                                                               0x3ef8
+#define regGCUTCL2_FFBM_PERFCOUNTER12_CFG_BASE_IDX                                                      1
+#define regGCUTCL2_FFBM_PERFCOUNTER13_CFG                                                               0x3ef9
+#define regGCUTCL2_FFBM_PERFCOUNTER13_CFG_BASE_IDX                                                      1
+#define regGCUTCL2_FFBM_PERFCOUNTER14_CFG                                                               0x3efa
+#define regGCUTCL2_FFBM_PERFCOUNTER14_CFG_BASE_IDX                                                      1
+#define regGCUTCL2_FFBM_PERFCOUNTER15_CFG                                                               0x3efb
+#define regGCUTCL2_FFBM_PERFCOUNTER15_CFG_BASE_IDX                                                      1
+#define regGCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL                                                           0x3efc
+#define regGCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL_BASE_IDX                                                  1
+
+
+// addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcutcl2nhttlbpldec
+// base address: 0x37c00
+#define regGCUTCL2_NHTTLB_PERFCOUNTER0_CFG                                                              0x3f00
+#define regGCUTCL2_NHTTLB_PERFCOUNTER0_CFG_BASE_IDX                                                     1
+#define regGCUTCL2_NHTTLB_PERFCOUNTER1_CFG                                                              0x3f01
+#define regGCUTCL2_NHTTLB_PERFCOUNTER1_CFG_BASE_IDX                                                     1
+#define regGCUTCL2_NHTTLB_PERFCOUNTER2_CFG                                                              0x3f02
+#define regGCUTCL2_NHTTLB_PERFCOUNTER2_CFG_BASE_IDX                                                     1
+#define regGCUTCL2_NHTTLB_PERFCOUNTER3_CFG                                                              0x3f03
+#define regGCUTCL2_NHTTLB_PERFCOUNTER3_CFG_BASE_IDX                                                     1
+#define regGCUTCL2_NHTTLB_PERFCOUNTER4_CFG                                                              0x3f04
+#define regGCUTCL2_NHTTLB_PERFCOUNTER4_CFG_BASE_IDX                                                     1
+#define regGCUTCL2_NHTTLB_PERFCOUNTER5_CFG                                                              0x3f05
+#define regGCUTCL2_NHTTLB_PERFCOUNTER5_CFG_BASE_IDX                                                     1
+#define regGCUTCL2_NHTTLB_PERFCOUNTER6_CFG                                                              0x3f06
+#define regGCUTCL2_NHTTLB_PERFCOUNTER6_CFG_BASE_IDX                                                     1
+#define regGCUTCL2_NHTTLB_PERFCOUNTER7_CFG                                                              0x3f07
+#define regGCUTCL2_NHTTLB_PERFCOUNTER7_CFG_BASE_IDX                                                     1
+#define regGCUTCL2_NHTTLB_PERFCOUNTER8_CFG                                                              0x3f08
+#define regGCUTCL2_NHTTLB_PERFCOUNTER8_CFG_BASE_IDX                                                     1
+#define regGCUTCL2_NHTTLB_PERFCOUNTER9_CFG                                                              0x3f09
+#define regGCUTCL2_NHTTLB_PERFCOUNTER9_CFG_BASE_IDX                                                     1
+#define regGCUTCL2_NHTTLB_PERFCOUNTER10_CFG                                                             0x3f0a
+#define regGCUTCL2_NHTTLB_PERFCOUNTER10_CFG_BASE_IDX                                                    1
+#define regGCUTCL2_NHTTLB_PERFCOUNTER11_CFG                                                             0x3f0b
+#define regGCUTCL2_NHTTLB_PERFCOUNTER11_CFG_BASE_IDX                                                    1
+#define regGCUTCL2_NHTTLB_PERFCOUNTER12_CFG                                                             0x3f0c
+#define regGCUTCL2_NHTTLB_PERFCOUNTER12_CFG_BASE_IDX                                                    1
+#define regGCUTCL2_NHTTLB_PERFCOUNTER13_CFG                                                             0x3f0d
+#define regGCUTCL2_NHTTLB_PERFCOUNTER13_CFG_BASE_IDX                                                    1
+#define regGCUTCL2_NHTTLB_PERFCOUNTER14_CFG                                                             0x3f0e
+#define regGCUTCL2_NHTTLB_PERFCOUNTER14_CFG_BASE_IDX                                                    1
+#define regGCUTCL2_NHTTLB_PERFCOUNTER15_CFG                                                             0x3f0f
+#define regGCUTCL2_NHTTLB_PERFCOUNTER15_CFG_BASE_IDX                                                    1
+#define regGCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL                                                         0x3f10
+#define regGCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL_BASE_IDX                                                1
+
+
 // addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcl2tlbpldec
 // base address: 0x37c50
 #define regGC_L2TLB_PERFCOUNTER0_CFG                                                                    0x3f14
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h
index f606c5cd03c5..1cf890de35cb 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h
@@ -16951,6 +16951,15 @@
 #define CHA_PERFCOUNTER3_HI__PERFCOUNTER_HI_MASK                                                              0xFFFFFFFFL
 
 
+// addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_perfddec
+//GC_CANE_PERFCOUNTER0_LO
+#define GC_CANE_PERFCOUNTER0_LO__PERFCOUNTER_LO__SHIFT                                                        0x0
+#define GC_CANE_PERFCOUNTER0_LO__PERFCOUNTER_LO_MASK                                                          0xFFFFFFFFL
+//GC_CANE_PERFCOUNTER0_HI
+#define GC_CANE_PERFCOUNTER0_HI__PERFCOUNTER_HI__SHIFT                                                        0x0
+#define GC_CANE_PERFCOUNTER0_HI__PERFCOUNTER_HI_MASK                                                          0xFFFFFFFFL
+
+
 // addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_cpwd_perfsdec
 //CPG_PERFCOUNTER1_SELECT
 #define CPG_PERFCOUNTER1_SELECT__PERF_SEL__SHIFT                                                              0x0
@@ -18123,6 +18132,46 @@
 #define CHA_PERFCOUNTER3_SELECT1__PERF_MODE2_MASK                                                             0xF0000000L
 
 
+// addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_perfsdec
+//GC_CANE_PERFCOUNTER0_SELECT
+#define GC_CANE_PERFCOUNTER0_SELECT__PERF_SEL__SHIFT                                                          0x0
+#define GC_CANE_PERFCOUNTER0_SELECT__PERF_SEL1__SHIFT                                                         0xa
+#define GC_CANE_PERFCOUNTER0_SELECT__CNTR_MODE__SHIFT                                                         0x14
+#define GC_CANE_PERFCOUNTER0_SELECT__PERF_MODE1__SHIFT                                                        0x18
+#define GC_CANE_PERFCOUNTER0_SELECT__PERF_MODE__SHIFT                                                         0x1c
+#define GC_CANE_PERFCOUNTER0_SELECT__PERF_SEL_MASK                                                            0x000003FFL
+#define GC_CANE_PERFCOUNTER0_SELECT__PERF_SEL1_MASK                                                           0x000FFC00L
+#define GC_CANE_PERFCOUNTER0_SELECT__CNTR_MODE_MASK                                                           0x00F00000L
+#define GC_CANE_PERFCOUNTER0_SELECT__PERF_MODE1_MASK                                                          0x0F000000L
+#define GC_CANE_PERFCOUNTER0_SELECT__PERF_MODE_MASK                                                           0xF0000000L
+//GC_CANE_PERFCOUNTER0_SELECT1
+#define GC_CANE_PERFCOUNTER0_SELECT1__PERF_SEL2__SHIFT                                                        0x0
+#define GC_CANE_PERFCOUNTER0_SELECT1__PERF_SEL3__SHIFT                                                        0xa
+#define GC_CANE_PERFCOUNTER0_SELECT1__PERF_MODE3__SHIFT                                                       0x18
+#define GC_CANE_PERFCOUNTER0_SELECT1__PERF_MODE2__SHIFT                                                       0x1c
+#define GC_CANE_PERFCOUNTER0_SELECT1__PERF_SEL2_MASK                                                          0x000003FFL
+#define GC_CANE_PERFCOUNTER0_SELECT1__PERF_SEL3_MASK                                                          0x000FFC00L
+#define GC_CANE_PERFCOUNTER0_SELECT1__PERF_MODE3_MASK                                                         0x0F000000L
+#define GC_CANE_PERFCOUNTER0_SELECT1__PERF_MODE2_MASK                                                         0xF0000000L
+//GC_CANE_PERFCOUNTER0_MODE
+#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_MODE0__SHIFT                                                       0x0
+#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_MODE1__SHIFT                                                       0x2
+#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_MODE2__SHIFT                                                       0x4
+#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_MODE3__SHIFT                                                       0x6
+#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_VALUE0__SHIFT                                                      0x8
+#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_VALUE1__SHIFT                                                      0xc
+#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_VALUE2__SHIFT                                                      0x10
+#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_VALUE3__SHIFT                                                      0x14
+#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_MODE0_MASK                                                         0x00000003L
+#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_MODE1_MASK                                                         0x0000000CL
+#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_MODE2_MASK                                                         0x00000030L
+#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_MODE3_MASK                                                         0x000000C0L
+#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_VALUE0_MASK                                                        0x00000F00L
+#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_VALUE1_MASK                                                        0x0000F000L
+#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_VALUE2_MASK                                                        0x000F0000L
+#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_VALUE3_MASK                                                        0x00F00000L
+
+
 // addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_gdfll_xvmin_xvmin_xvmin_reg_blk
 //XVMIN_XVMIN_WR_DATA
 #define XVMIN_XVMIN_WR_DATA__XVMINDATA__SHIFT                                                                 0x0
@@ -43203,6 +43252,28 @@
 #define GC_ATC_L2_PERFCOUNTER_HI__COMPARE_VALUE_MASK                                                          0xFFFF0000L
 
 
+// addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcutcl2ffbmprdec
+//GCUTCL2_FFBM_PERFCOUNTER_LO
+#define GCUTCL2_FFBM_PERFCOUNTER_LO__COUNTER_LO__SHIFT                                                        0x0
+#define GCUTCL2_FFBM_PERFCOUNTER_LO__COUNTER_LO_MASK                                                          0xFFFFFFFFL
+//GCUTCL2_FFBM_PERFCOUNTER_HI
+#define GCUTCL2_FFBM_PERFCOUNTER_HI__COUNTER_HI__SHIFT                                                        0x0
+#define GCUTCL2_FFBM_PERFCOUNTER_HI__COMPARE_VALUE__SHIFT                                                     0x10
+#define GCUTCL2_FFBM_PERFCOUNTER_HI__COUNTER_HI_MASK                                                          0x0000FFFFL
+#define GCUTCL2_FFBM_PERFCOUNTER_HI__COMPARE_VALUE_MASK                                                       0xFFFF0000L
+
+
+// addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcutcl2nhttlbprdec
+//GCUTCL2_NHTTLB_PERFCOUNTER_LO
+#define GCUTCL2_NHTTLB_PERFCOUNTER_LO__COUNTER_LO__SHIFT                                                      0x0
+#define GCUTCL2_NHTTLB_PERFCOUNTER_LO__COUNTER_LO_MASK                                                        0xFFFFFFFFL
+//GCUTCL2_NHTTLB_PERFCOUNTER_HI
+#define GCUTCL2_NHTTLB_PERFCOUNTER_HI__COUNTER_HI__SHIFT                                                      0x0
+#define GCUTCL2_NHTTLB_PERFCOUNTER_HI__COMPARE_VALUE__SHIFT                                                   0x10
+#define GCUTCL2_NHTTLB_PERFCOUNTER_HI__COUNTER_HI_MASK                                                        0x0000FFFFL
+#define GCUTCL2_NHTTLB_PERFCOUNTER_HI__COMPARE_VALUE_MASK                                                     0xFFFF0000L
+
+
 // addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcl2tlbprdec
 //GC_L2TLB_PERFCOUNTER_LO
 #define GC_L2TLB_PERFCOUNTER_LO__COUNTER_LO__SHIFT                                                            0x0
@@ -43660,6 +43731,390 @@
 #define GC_ATC_L2_PERFCOUNTER_RSLT_CNTL__STOP_ALL_ON_SATURATE_MASK                                            0x04000000L
 
 
+// addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcutcl2ffbmpldec
+//GCUTCL2_FFBM_PERFCOUNTER0_CFG
+#define GCUTCL2_FFBM_PERFCOUNTER0_CFG__PERF_SEL__SHIFT                                                        0x0
+#define GCUTCL2_FFBM_PERFCOUNTER0_CFG__PERF_SEL_END__SHIFT                                                    0x8
+#define GCUTCL2_FFBM_PERFCOUNTER0_CFG__PERF_MODE__SHIFT                                                       0x18
+#define GCUTCL2_FFBM_PERFCOUNTER0_CFG__ENABLE__SHIFT                                                          0x1c
+#define GCUTCL2_FFBM_PERFCOUNTER0_CFG__CLEAR__SHIFT                                                           0x1d
+#define GCUTCL2_FFBM_PERFCOUNTER0_CFG__PERF_SEL_MASK                                                          0x000000FFL
+#define GCUTCL2_FFBM_PERFCOUNTER0_CFG__PERF_SEL_END_MASK                                                      0x0000FF00L
+#define GCUTCL2_FFBM_PERFCOUNTER0_CFG__PERF_MODE_MASK                                                         0x0F000000L
+#define GCUTCL2_FFBM_PERFCOUNTER0_CFG__ENABLE_MASK                                                            0x10000000L
+#define GCUTCL2_FFBM_PERFCOUNTER0_CFG__CLEAR_MASK                                                             0x20000000L
+//GCUTCL2_FFBM_PERFCOUNTER1_CFG
+#define GCUTCL2_FFBM_PERFCOUNTER1_CFG__PERF_SEL__SHIFT                                                        0x0
+#define GCUTCL2_FFBM_PERFCOUNTER1_CFG__PERF_SEL_END__SHIFT                                                    0x8
+#define GCUTCL2_FFBM_PERFCOUNTER1_CFG__PERF_MODE__SHIFT                                                       0x18
+#define GCUTCL2_FFBM_PERFCOUNTER1_CFG__ENABLE__SHIFT                                                          0x1c
+#define GCUTCL2_FFBM_PERFCOUNTER1_CFG__CLEAR__SHIFT                                                           0x1d
+#define GCUTCL2_FFBM_PERFCOUNTER1_CFG__PERF_SEL_MASK                                                          0x000000FFL
+#define GCUTCL2_FFBM_PERFCOUNTER1_CFG__PERF_SEL_END_MASK                                                      0x0000FF00L
+#define GCUTCL2_FFBM_PERFCOUNTER1_CFG__PERF_MODE_MASK                                                         0x0F000000L
+#define GCUTCL2_FFBM_PERFCOUNTER1_CFG__ENABLE_MASK                                                            0x10000000L
+#define GCUTCL2_FFBM_PERFCOUNTER1_CFG__CLEAR_MASK                                                             0x20000000L
+//GCUTCL2_FFBM_PERFCOUNTER2_CFG
+#define GCUTCL2_FFBM_PERFCOUNTER2_CFG__PERF_SEL__SHIFT                                                        0x0
+#define GCUTCL2_FFBM_PERFCOUNTER2_CFG__PERF_SEL_END__SHIFT                                                    0x8
+#define GCUTCL2_FFBM_PERFCOUNTER2_CFG__PERF_MODE__SHIFT                                                       0x18
+#define GCUTCL2_FFBM_PERFCOUNTER2_CFG__ENABLE__SHIFT                                                          0x1c
+#define GCUTCL2_FFBM_PERFCOUNTER2_CFG__CLEAR__SHIFT                                                           0x1d
+#define GCUTCL2_FFBM_PERFCOUNTER2_CFG__PERF_SEL_MASK                                                          0x000000FFL
+#define GCUTCL2_FFBM_PERFCOUNTER2_CFG__PERF_SEL_END_MASK                                                      0x0000FF00L
+#define GCUTCL2_FFBM_PERFCOUNTER2_CFG__PERF_MODE_MASK                                                         0x0F000000L
+#define GCUTCL2_FFBM_PERFCOUNTER2_CFG__ENABLE_MASK                                                            0x10000000L
+#define GCUTCL2_FFBM_PERFCOUNTER2_CFG__CLEAR_MASK                                                             0x20000000L
+//GCUTCL2_FFBM_PERFCOUNTER3_CFG
+#define GCUTCL2_FFBM_PERFCOUNTER3_CFG__PERF_SEL__SHIFT                                                        0x0
+#define GCUTCL2_FFBM_PERFCOUNTER3_CFG__PERF_SEL_END__SHIFT                                                    0x8
+#define GCUTCL2_FFBM_PERFCOUNTER3_CFG__PERF_MODE__SHIFT                                                       0x18
+#define GCUTCL2_FFBM_PERFCOUNTER3_CFG__ENABLE__SHIFT                                                          0x1c
+#define GCUTCL2_FFBM_PERFCOUNTER3_CFG__CLEAR__SHIFT                                                           0x1d
+#define GCUTCL2_FFBM_PERFCOUNTER3_CFG__PERF_SEL_MASK                                                          0x000000FFL
+#define GCUTCL2_FFBM_PERFCOUNTER3_CFG__PERF_SEL_END_MASK                                                      0x0000FF00L
+#define GCUTCL2_FFBM_PERFCOUNTER3_CFG__PERF_MODE_MASK                                                         0x0F000000L
+#define GCUTCL2_FFBM_PERFCOUNTER3_CFG__ENABLE_MASK                                                            0x10000000L
+#define GCUTCL2_FFBM_PERFCOUNTER3_CFG__CLEAR_MASK                                                             0x20000000L
+//GCUTCL2_FFBM_PERFCOUNTER4_CFG
+#define GCUTCL2_FFBM_PERFCOUNTER4_CFG__PERF_SEL__SHIFT                                                        0x0
+#define GCUTCL2_FFBM_PERFCOUNTER4_CFG__PERF_SEL_END__SHIFT                                                    0x8
+#define GCUTCL2_FFBM_PERFCOUNTER4_CFG__PERF_MODE__SHIFT                                                       0x18
+#define GCUTCL2_FFBM_PERFCOUNTER4_CFG__ENABLE__SHIFT                                                          0x1c
+#define GCUTCL2_FFBM_PERFCOUNTER4_CFG__CLEAR__SHIFT                                                           0x1d
+#define GCUTCL2_FFBM_PERFCOUNTER4_CFG__PERF_SEL_MASK                                                          0x000000FFL
+#define GCUTCL2_FFBM_PERFCOUNTER4_CFG__PERF_SEL_END_MASK                                                      0x0000FF00L
+#define GCUTCL2_FFBM_PERFCOUNTER4_CFG__PERF_MODE_MASK                                                         0x0F000000L
+#define GCUTCL2_FFBM_PERFCOUNTER4_CFG__ENABLE_MASK                                                            0x10000000L
+#define GCUTCL2_FFBM_PERFCOUNTER4_CFG__CLEAR_MASK                                                             0x20000000L
+//GCUTCL2_FFBM_PERFCOUNTER5_CFG
+#define GCUTCL2_FFBM_PERFCOUNTER5_CFG__PERF_SEL__SHIFT                                                        0x0
+#define GCUTCL2_FFBM_PERFCOUNTER5_CFG__PERF_SEL_END__SHIFT                                                    0x8
+#define GCUTCL2_FFBM_PERFCOUNTER5_CFG__PERF_MODE__SHIFT                                                       0x18
+#define GCUTCL2_FFBM_PERFCOUNTER5_CFG__ENABLE__SHIFT                                                          0x1c
+#define GCUTCL2_FFBM_PERFCOUNTER5_CFG__CLEAR__SHIFT                                                           0x1d
+#define GCUTCL2_FFBM_PERFCOUNTER5_CFG__PERF_SEL_MASK                                                          0x000000FFL
+#define GCUTCL2_FFBM_PERFCOUNTER5_CFG__PERF_SEL_END_MASK                                                      0x0000FF00L
+#define GCUTCL2_FFBM_PERFCOUNTER5_CFG__PERF_MODE_MASK                                                         0x0F000000L
+#define GCUTCL2_FFBM_PERFCOUNTER5_CFG__ENABLE_MASK                                                            0x10000000L
+#define GCUTCL2_FFBM_PERFCOUNTER5_CFG__CLEAR_MASK                                                             0x20000000L
+//GCUTCL2_FFBM_PERFCOUNTER6_CFG
+#define GCUTCL2_FFBM_PERFCOUNTER6_CFG__PERF_SEL__SHIFT                                                        0x0
+#define GCUTCL2_FFBM_PERFCOUNTER6_CFG__PERF_SEL_END__SHIFT                                                    0x8
+#define GCUTCL2_FFBM_PERFCOUNTER6_CFG__PERF_MODE__SHIFT                                                       0x18
+#define GCUTCL2_FFBM_PERFCOUNTER6_CFG__ENABLE__SHIFT                                                          0x1c
+#define GCUTCL2_FFBM_PERFCOUNTER6_CFG__CLEAR__SHIFT                                                           0x1d
+#define GCUTCL2_FFBM_PERFCOUNTER6_CFG__PERF_SEL_MASK                                                          0x000000FFL
+#define GCUTCL2_FFBM_PERFCOUNTER6_CFG__PERF_SEL_END_MASK                                                      0x0000FF00L
+#define GCUTCL2_FFBM_PERFCOUNTER6_CFG__PERF_MODE_MASK                                                         0x0F000000L
+#define GCUTCL2_FFBM_PERFCOUNTER6_CFG__ENABLE_MASK                                                            0x10000000L
+#define GCUTCL2_FFBM_PERFCOUNTER6_CFG__CLEAR_MASK                                                             0x20000000L
+//GCUTCL2_FFBM_PERFCOUNTER7_CFG
+#define GCUTCL2_FFBM_PERFCOUNTER7_CFG__PERF_SEL__SHIFT                                                        0x0
+#define GCUTCL2_FFBM_PERFCOUNTER7_CFG__PERF_SEL_END__SHIFT                                                    0x8
+#define GCUTCL2_FFBM_PERFCOUNTER7_CFG__PERF_MODE__SHIFT                                                       0x18
+#define GCUTCL2_FFBM_PERFCOUNTER7_CFG__ENABLE__SHIFT                                                          0x1c
+#define GCUTCL2_FFBM_PERFCOUNTER7_CFG__CLEAR__SHIFT                                                           0x1d
+#define GCUTCL2_FFBM_PERFCOUNTER7_CFG__PERF_SEL_MASK                                                          0x000000FFL
+#define GCUTCL2_FFBM_PERFCOUNTER7_CFG__PERF_SEL_END_MASK                                                      0x0000FF00L
+#define GCUTCL2_FFBM_PERFCOUNTER7_CFG__PERF_MODE_MASK                                                         0x0F000000L
+#define GCUTCL2_FFBM_PERFCOUNTER7_CFG__ENABLE_MASK                                                            0x10000000L
+#define GCUTCL2_FFBM_PERFCOUNTER7_CFG__CLEAR_MASK                                                             0x20000000L
+//GCUTCL2_FFBM_PERFCOUNTER8_CFG
+#define GCUTCL2_FFBM_PERFCOUNTER8_CFG__PERF_SEL__SHIFT                                                        0x0
+#define GCUTCL2_FFBM_PERFCOUNTER8_CFG__PERF_SEL_END__SHIFT                                                    0x8
+#define GCUTCL2_FFBM_PERFCOUNTER8_CFG__PERF_MODE__SHIFT                                                       0x18
+#define GCUTCL2_FFBM_PERFCOUNTER8_CFG__ENABLE__SHIFT                                                          0x1c
+#define GCUTCL2_FFBM_PERFCOUNTER8_CFG__CLEAR__SHIFT                                                           0x1d
+#define GCUTCL2_FFBM_PERFCOUNTER8_CFG__PERF_SEL_MASK                                                          0x000000FFL
+#define GCUTCL2_FFBM_PERFCOUNTER8_CFG__PERF_SEL_END_MASK                                                      0x0000FF00L
+#define GCUTCL2_FFBM_PERFCOUNTER8_CFG__PERF_MODE_MASK                                                         0x0F000000L
+#define GCUTCL2_FFBM_PERFCOUNTER8_CFG__ENABLE_MASK                                                            0x10000000L
+#define GCUTCL2_FFBM_PERFCOUNTER8_CFG__CLEAR_MASK                                                             0x20000000L
+//GCUTCL2_FFBM_PERFCOUNTER9_CFG
+#define GCUTCL2_FFBM_PERFCOUNTER9_CFG__PERF_SEL__SHIFT                                                        0x0
+#define GCUTCL2_FFBM_PERFCOUNTER9_CFG__PERF_SEL_END__SHIFT                                                    0x8
+#define GCUTCL2_FFBM_PERFCOUNTER9_CFG__PERF_MODE__SHIFT                                                       0x18
+#define GCUTCL2_FFBM_PERFCOUNTER9_CFG__ENABLE__SHIFT                                                          0x1c
+#define GCUTCL2_FFBM_PERFCOUNTER9_CFG__CLEAR__SHIFT                                                           0x1d
+#define GCUTCL2_FFBM_PERFCOUNTER9_CFG__PERF_SEL_MASK                                                          0x000000FFL
+#define GCUTCL2_FFBM_PERFCOUNTER9_CFG__PERF_SEL_END_MASK                                                      0x0000FF00L
+#define GCUTCL2_FFBM_PERFCOUNTER9_CFG__PERF_MODE_MASK                                                         0x0F000000L
+#define GCUTCL2_FFBM_PERFCOUNTER9_CFG__ENABLE_MASK                                                            0x10000000L
+#define GCUTCL2_FFBM_PERFCOUNTER9_CFG__CLEAR_MASK                                                             0x20000000L
+//GCUTCL2_FFBM_PERFCOUNTER10_CFG
+#define GCUTCL2_FFBM_PERFCOUNTER10_CFG__PERF_SEL__SHIFT                                                       0x0
+#define GCUTCL2_FFBM_PERFCOUNTER10_CFG__PERF_SEL_END__SHIFT                                                   0x8
+#define GCUTCL2_FFBM_PERFCOUNTER10_CFG__PERF_MODE__SHIFT                                                      0x18
+#define GCUTCL2_FFBM_PERFCOUNTER10_CFG__ENABLE__SHIFT                                                         0x1c
+#define GCUTCL2_FFBM_PERFCOUNTER10_CFG__CLEAR__SHIFT                                                          0x1d
+#define GCUTCL2_FFBM_PERFCOUNTER10_CFG__PERF_SEL_MASK                                                         0x000000FFL
+#define GCUTCL2_FFBM_PERFCOUNTER10_CFG__PERF_SEL_END_MASK                                                     0x0000FF00L
+#define GCUTCL2_FFBM_PERFCOUNTER10_CFG__PERF_MODE_MASK                                                        0x0F000000L
+#define GCUTCL2_FFBM_PERFCOUNTER10_CFG__ENABLE_MASK                                                           0x10000000L
+#define GCUTCL2_FFBM_PERFCOUNTER10_CFG__CLEAR_MASK                                                            0x20000000L
+//GCUTCL2_FFBM_PERFCOUNTER11_CFG
+#define GCUTCL2_FFBM_PERFCOUNTER11_CFG__PERF_SEL__SHIFT                                                       0x0
+#define GCUTCL2_FFBM_PERFCOUNTER11_CFG__PERF_SEL_END__SHIFT                                                   0x8
+#define GCUTCL2_FFBM_PERFCOUNTER11_CFG__PERF_MODE__SHIFT                                                      0x18
+#define GCUTCL2_FFBM_PERFCOUNTER11_CFG__ENABLE__SHIFT                                                         0x1c
+#define GCUTCL2_FFBM_PERFCOUNTER11_CFG__CLEAR__SHIFT                                                          0x1d
+#define GCUTCL2_FFBM_PERFCOUNTER11_CFG__PERF_SEL_MASK                                                         0x000000FFL
+#define GCUTCL2_FFBM_PERFCOUNTER11_CFG__PERF_SEL_END_MASK                                                     0x0000FF00L
+#define GCUTCL2_FFBM_PERFCOUNTER11_CFG__PERF_MODE_MASK                                                        0x0F000000L
+#define GCUTCL2_FFBM_PERFCOUNTER11_CFG__ENABLE_MASK                                                           0x10000000L
+#define GCUTCL2_FFBM_PERFCOUNTER11_CFG__CLEAR_MASK                                                            0x20000000L
+//GCUTCL2_FFBM_PERFCOUNTER12_CFG
+#define GCUTCL2_FFBM_PERFCOUNTER12_CFG__PERF_SEL__SHIFT                                                       0x0
+#define GCUTCL2_FFBM_PERFCOUNTER12_CFG__PERF_SEL_END__SHIFT                                                   0x8
+#define GCUTCL2_FFBM_PERFCOUNTER12_CFG__PERF_MODE__SHIFT                                                      0x18
+#define GCUTCL2_FFBM_PERFCOUNTER12_CFG__ENABLE__SHIFT                                                         0x1c
+#define GCUTCL2_FFBM_PERFCOUNTER12_CFG__CLEAR__SHIFT                                                          0x1d
+#define GCUTCL2_FFBM_PERFCOUNTER12_CFG__PERF_SEL_MASK                                                         0x000000FFL
+#define GCUTCL2_FFBM_PERFCOUNTER12_CFG__PERF_SEL_END_MASK                                                     0x0000FF00L
+#define GCUTCL2_FFBM_PERFCOUNTER12_CFG__PERF_MODE_MASK                                                        0x0F000000L
+#define GCUTCL2_FFBM_PERFCOUNTER12_CFG__ENABLE_MASK                                                           0x10000000L
+#define GCUTCL2_FFBM_PERFCOUNTER12_CFG__CLEAR_MASK                                                            0x20000000L
+//GCUTCL2_FFBM_PERFCOUNTER13_CFG
+#define GCUTCL2_FFBM_PERFCOUNTER13_CFG__PERF_SEL__SHIFT                                                       0x0
+#define GCUTCL2_FFBM_PERFCOUNTER13_CFG__PERF_SEL_END__SHIFT                                                   0x8
+#define GCUTCL2_FFBM_PERFCOUNTER13_CFG__PERF_MODE__SHIFT                                                      0x18
+#define GCUTCL2_FFBM_PERFCOUNTER13_CFG__ENABLE__SHIFT                                                         0x1c
+#define GCUTCL2_FFBM_PERFCOUNTER13_CFG__CLEAR__SHIFT                                                          0x1d
+#define GCUTCL2_FFBM_PERFCOUNTER13_CFG__PERF_SEL_MASK                                                         0x000000FFL
+#define GCUTCL2_FFBM_PERFCOUNTER13_CFG__PERF_SEL_END_MASK                                                     0x0000FF00L
+#define GCUTCL2_FFBM_PERFCOUNTER13_CFG__PERF_MODE_MASK                                                        0x0F000000L
+#define GCUTCL2_FFBM_PERFCOUNTER13_CFG__ENABLE_MASK                                                           0x10000000L
+#define GCUTCL2_FFBM_PERFCOUNTER13_CFG__CLEAR_MASK                                                            0x20000000L
+//GCUTCL2_FFBM_PERFCOUNTER14_CFG
+#define GCUTCL2_FFBM_PERFCOUNTER14_CFG__PERF_SEL__SHIFT                                                       0x0
+#define GCUTCL2_FFBM_PERFCOUNTER14_CFG__PERF_SEL_END__SHIFT                                                   0x8
+#define GCUTCL2_FFBM_PERFCOUNTER14_CFG__PERF_MODE__SHIFT                                                      0x18
+#define GCUTCL2_FFBM_PERFCOUNTER14_CFG__ENABLE__SHIFT                                                         0x1c
+#define GCUTCL2_FFBM_PERFCOUNTER14_CFG__CLEAR__SHIFT                                                          0x1d
+#define GCUTCL2_FFBM_PERFCOUNTER14_CFG__PERF_SEL_MASK                                                         0x000000FFL
+#define GCUTCL2_FFBM_PERFCOUNTER14_CFG__PERF_SEL_END_MASK                                                     0x0000FF00L
+#define GCUTCL2_FFBM_PERFCOUNTER14_CFG__PERF_MODE_MASK                                                        0x0F000000L
+#define GCUTCL2_FFBM_PERFCOUNTER14_CFG__ENABLE_MASK                                                           0x10000000L
+#define GCUTCL2_FFBM_PERFCOUNTER14_CFG__CLEAR_MASK                                                            0x20000000L
+//GCUTCL2_FFBM_PERFCOUNTER15_CFG
+#define GCUTCL2_FFBM_PERFCOUNTER15_CFG__PERF_SEL__SHIFT                                                       0x0
+#define GCUTCL2_FFBM_PERFCOUNTER15_CFG__PERF_SEL_END__SHIFT                                                   0x8
+#define GCUTCL2_FFBM_PERFCOUNTER15_CFG__PERF_MODE__SHIFT                                                      0x18
+#define GCUTCL2_FFBM_PERFCOUNTER15_CFG__ENABLE__SHIFT                                                         0x1c
+#define GCUTCL2_FFBM_PERFCOUNTER15_CFG__CLEAR__SHIFT                                                          0x1d
+#define GCUTCL2_FFBM_PERFCOUNTER15_CFG__PERF_SEL_MASK                                                         0x000000FFL
+#define GCUTCL2_FFBM_PERFCOUNTER15_CFG__PERF_SEL_END_MASK                                                     0x0000FF00L
+#define GCUTCL2_FFBM_PERFCOUNTER15_CFG__PERF_MODE_MASK                                                        0x0F000000L
+#define GCUTCL2_FFBM_PERFCOUNTER15_CFG__ENABLE_MASK                                                           0x10000000L
+#define GCUTCL2_FFBM_PERFCOUNTER15_CFG__CLEAR_MASK                                                            0x20000000L
+//GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL
+#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__PERF_COUNTER_SELECT__SHIFT                                        0x0
+#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__START_TRIGGER__SHIFT                                              0x8
+#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__STOP_TRIGGER__SHIFT                                               0x10
+#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__ENABLE_ANY__SHIFT                                                 0x18
+#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__CLEAR_ALL__SHIFT                                                  0x19
+#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__STOP_ALL_ON_SATURATE__SHIFT                                       0x1a
+#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__PERF_COUNTER_SELECT_MASK                                          0x0000000FL
+#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__START_TRIGGER_MASK                                                0x0000FF00L
+#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__STOP_TRIGGER_MASK                                                 0x00FF0000L
+#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__ENABLE_ANY_MASK                                                   0x01000000L
+#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__CLEAR_ALL_MASK                                                    0x02000000L
+#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__STOP_ALL_ON_SATURATE_MASK                                         0x04000000L
+
+
+// addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcutcl2nhttlbpldec
+//GCUTCL2_NHTTLB_PERFCOUNTER0_CFG
+#define GCUTCL2_NHTTLB_PERFCOUNTER0_CFG__PERF_SEL__SHIFT                                                      0x0
+#define GCUTCL2_NHTTLB_PERFCOUNTER0_CFG__PERF_SEL_END__SHIFT                                                  0x8
+#define GCUTCL2_NHTTLB_PERFCOUNTER0_CFG__PERF_MODE__SHIFT                                                     0x18
+#define GCUTCL2_NHTTLB_PERFCOUNTER0_CFG__ENABLE__SHIFT                                                        0x1c
+#define GCUTCL2_NHTTLB_PERFCOUNTER0_CFG__CLEAR__SHIFT                                                         0x1d
+#define GCUTCL2_NHTTLB_PERFCOUNTER0_CFG__PERF_SEL_MASK                                                        0x000000FFL
+#define GCUTCL2_NHTTLB_PERFCOUNTER0_CFG__PERF_SEL_END_MASK                                                    0x0000FF00L
+#define GCUTCL2_NHTTLB_PERFCOUNTER0_CFG__PERF_MODE_MASK                                                       0x0F000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER0_CFG__ENABLE_MASK                                                          0x10000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER0_CFG__CLEAR_MASK                                                           0x20000000L
+//GCUTCL2_NHTTLB_PERFCOUNTER1_CFG
+#define GCUTCL2_NHTTLB_PERFCOUNTER1_CFG__PERF_SEL__SHIFT                                                      0x0
+#define GCUTCL2_NHTTLB_PERFCOUNTER1_CFG__PERF_SEL_END__SHIFT                                                  0x8
+#define GCUTCL2_NHTTLB_PERFCOUNTER1_CFG__PERF_MODE__SHIFT                                                     0x18
+#define GCUTCL2_NHTTLB_PERFCOUNTER1_CFG__ENABLE__SHIFT                                                        0x1c
+#define GCUTCL2_NHTTLB_PERFCOUNTER1_CFG__CLEAR__SHIFT                                                         0x1d
+#define GCUTCL2_NHTTLB_PERFCOUNTER1_CFG__PERF_SEL_MASK                                                        0x000000FFL
+#define GCUTCL2_NHTTLB_PERFCOUNTER1_CFG__PERF_SEL_END_MASK                                                    0x0000FF00L
+#define GCUTCL2_NHTTLB_PERFCOUNTER1_CFG__PERF_MODE_MASK                                                       0x0F000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER1_CFG__ENABLE_MASK                                                          0x10000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER1_CFG__CLEAR_MASK                                                           0x20000000L
+//GCUTCL2_NHTTLB_PERFCOUNTER2_CFG
+#define GCUTCL2_NHTTLB_PERFCOUNTER2_CFG__PERF_SEL__SHIFT                                                      0x0
+#define GCUTCL2_NHTTLB_PERFCOUNTER2_CFG__PERF_SEL_END__SHIFT                                                  0x8
+#define GCUTCL2_NHTTLB_PERFCOUNTER2_CFG__PERF_MODE__SHIFT                                                     0x18
+#define GCUTCL2_NHTTLB_PERFCOUNTER2_CFG__ENABLE__SHIFT                                                        0x1c
+#define GCUTCL2_NHTTLB_PERFCOUNTER2_CFG__CLEAR__SHIFT                                                         0x1d
+#define GCUTCL2_NHTTLB_PERFCOUNTER2_CFG__PERF_SEL_MASK                                                        0x000000FFL
+#define GCUTCL2_NHTTLB_PERFCOUNTER2_CFG__PERF_SEL_END_MASK                                                    0x0000FF00L
+#define GCUTCL2_NHTTLB_PERFCOUNTER2_CFG__PERF_MODE_MASK                                                       0x0F000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER2_CFG__ENABLE_MASK                                                          0x10000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER2_CFG__CLEAR_MASK                                                           0x20000000L
+//GCUTCL2_NHTTLB_PERFCOUNTER3_CFG
+#define GCUTCL2_NHTTLB_PERFCOUNTER3_CFG__PERF_SEL__SHIFT                                                      0x0
+#define GCUTCL2_NHTTLB_PERFCOUNTER3_CFG__PERF_SEL_END__SHIFT                                                  0x8
+#define GCUTCL2_NHTTLB_PERFCOUNTER3_CFG__PERF_MODE__SHIFT                                                     0x18
+#define GCUTCL2_NHTTLB_PERFCOUNTER3_CFG__ENABLE__SHIFT                                                        0x1c
+#define GCUTCL2_NHTTLB_PERFCOUNTER3_CFG__CLEAR__SHIFT                                                         0x1d
+#define GCUTCL2_NHTTLB_PERFCOUNTER3_CFG__PERF_SEL_MASK                                                        0x000000FFL
+#define GCUTCL2_NHTTLB_PERFCOUNTER3_CFG__PERF_SEL_END_MASK                                                    0x0000FF00L
+#define GCUTCL2_NHTTLB_PERFCOUNTER3_CFG__PERF_MODE_MASK                                                       0x0F000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER3_CFG__ENABLE_MASK                                                          0x10000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER3_CFG__CLEAR_MASK                                                           0x20000000L
+//GCUTCL2_NHTTLB_PERFCOUNTER4_CFG
+#define GCUTCL2_NHTTLB_PERFCOUNTER4_CFG__PERF_SEL__SHIFT                                                      0x0
+#define GCUTCL2_NHTTLB_PERFCOUNTER4_CFG__PERF_SEL_END__SHIFT                                                  0x8
+#define GCUTCL2_NHTTLB_PERFCOUNTER4_CFG__PERF_MODE__SHIFT                                                     0x18
+#define GCUTCL2_NHTTLB_PERFCOUNTER4_CFG__ENABLE__SHIFT                                                        0x1c
+#define GCUTCL2_NHTTLB_PERFCOUNTER4_CFG__CLEAR__SHIFT                                                         0x1d
+#define GCUTCL2_NHTTLB_PERFCOUNTER4_CFG__PERF_SEL_MASK                                                        0x000000FFL
+#define GCUTCL2_NHTTLB_PERFCOUNTER4_CFG__PERF_SEL_END_MASK                                                    0x0000FF00L
+#define GCUTCL2_NHTTLB_PERFCOUNTER4_CFG__PERF_MODE_MASK                                                       0x0F000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER4_CFG__ENABLE_MASK                                                          0x10000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER4_CFG__CLEAR_MASK                                                           0x20000000L
+//GCUTCL2_NHTTLB_PERFCOUNTER5_CFG
+#define GCUTCL2_NHTTLB_PERFCOUNTER5_CFG__PERF_SEL__SHIFT                                                      0x0
+#define GCUTCL2_NHTTLB_PERFCOUNTER5_CFG__PERF_SEL_END__SHIFT                                                  0x8
+#define GCUTCL2_NHTTLB_PERFCOUNTER5_CFG__PERF_MODE__SHIFT                                                     0x18
+#define GCUTCL2_NHTTLB_PERFCOUNTER5_CFG__ENABLE__SHIFT                                                        0x1c
+#define GCUTCL2_NHTTLB_PERFCOUNTER5_CFG__CLEAR__SHIFT                                                         0x1d
+#define GCUTCL2_NHTTLB_PERFCOUNTER5_CFG__PERF_SEL_MASK                                                        0x000000FFL
+#define GCUTCL2_NHTTLB_PERFCOUNTER5_CFG__PERF_SEL_END_MASK                                                    0x0000FF00L
+#define GCUTCL2_NHTTLB_PERFCOUNTER5_CFG__PERF_MODE_MASK                                                       0x0F000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER5_CFG__ENABLE_MASK                                                          0x10000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER5_CFG__CLEAR_MASK                                                           0x20000000L
+//GCUTCL2_NHTTLB_PERFCOUNTER6_CFG
+#define GCUTCL2_NHTTLB_PERFCOUNTER6_CFG__PERF_SEL__SHIFT                                                      0x0
+#define GCUTCL2_NHTTLB_PERFCOUNTER6_CFG__PERF_SEL_END__SHIFT                                                  0x8
+#define GCUTCL2_NHTTLB_PERFCOUNTER6_CFG__PERF_MODE__SHIFT                                                     0x18
+#define GCUTCL2_NHTTLB_PERFCOUNTER6_CFG__ENABLE__SHIFT                                                        0x1c
+#define GCUTCL2_NHTTLB_PERFCOUNTER6_CFG__CLEAR__SHIFT                                                         0x1d
+#define GCUTCL2_NHTTLB_PERFCOUNTER6_CFG__PERF_SEL_MASK                                                        0x000000FFL
+#define GCUTCL2_NHTTLB_PERFCOUNTER6_CFG__PERF_SEL_END_MASK                                                    0x0000FF00L
+#define GCUTCL2_NHTTLB_PERFCOUNTER6_CFG__PERF_MODE_MASK                                                       0x0F000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER6_CFG__ENABLE_MASK                                                          0x10000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER6_CFG__CLEAR_MASK                                                           0x20000000L
+//GCUTCL2_NHTTLB_PERFCOUNTER7_CFG
+#define GCUTCL2_NHTTLB_PERFCOUNTER7_CFG__PERF_SEL__SHIFT                                                      0x0
+#define GCUTCL2_NHTTLB_PERFCOUNTER7_CFG__PERF_SEL_END__SHIFT                                                  0x8
+#define GCUTCL2_NHTTLB_PERFCOUNTER7_CFG__PERF_MODE__SHIFT                                                     0x18
+#define GCUTCL2_NHTTLB_PERFCOUNTER7_CFG__ENABLE__SHIFT                                                        0x1c
+#define GCUTCL2_NHTTLB_PERFCOUNTER7_CFG__CLEAR__SHIFT                                                         0x1d
+#define GCUTCL2_NHTTLB_PERFCOUNTER7_CFG__PERF_SEL_MASK                                                        0x000000FFL
+#define GCUTCL2_NHTTLB_PERFCOUNTER7_CFG__PERF_SEL_END_MASK                                                    0x0000FF00L
+#define GCUTCL2_NHTTLB_PERFCOUNTER7_CFG__PERF_MODE_MASK                                                       0x0F000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER7_CFG__ENABLE_MASK                                                          0x10000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER7_CFG__CLEAR_MASK                                                           0x20000000L
+//GCUTCL2_NHTTLB_PERFCOUNTER8_CFG
+#define GCUTCL2_NHTTLB_PERFCOUNTER8_CFG__PERF_SEL__SHIFT                                                      0x0
+#define GCUTCL2_NHTTLB_PERFCOUNTER8_CFG__PERF_SEL_END__SHIFT                                                  0x8
+#define GCUTCL2_NHTTLB_PERFCOUNTER8_CFG__PERF_MODE__SHIFT                                                     0x18
+#define GCUTCL2_NHTTLB_PERFCOUNTER8_CFG__ENABLE__SHIFT                                                        0x1c
+#define GCUTCL2_NHTTLB_PERFCOUNTER8_CFG__CLEAR__SHIFT                                                         0x1d
+#define GCUTCL2_NHTTLB_PERFCOUNTER8_CFG__PERF_SEL_MASK                                                        0x000000FFL
+#define GCUTCL2_NHTTLB_PERFCOUNTER8_CFG__PERF_SEL_END_MASK                                                    0x0000FF00L
+#define GCUTCL2_NHTTLB_PERFCOUNTER8_CFG__PERF_MODE_MASK                                                       0x0F000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER8_CFG__ENABLE_MASK                                                          0x10000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER8_CFG__CLEAR_MASK                                                           0x20000000L
+//GCUTCL2_NHTTLB_PERFCOUNTER9_CFG
+#define GCUTCL2_NHTTLB_PERFCOUNTER9_CFG__PERF_SEL__SHIFT                                                      0x0
+#define GCUTCL2_NHTTLB_PERFCOUNTER9_CFG__PERF_SEL_END__SHIFT                                                  0x8
+#define GCUTCL2_NHTTLB_PERFCOUNTER9_CFG__PERF_MODE__SHIFT                                                     0x18
+#define GCUTCL2_NHTTLB_PERFCOUNTER9_CFG__ENABLE__SHIFT                                                        0x1c
+#define GCUTCL2_NHTTLB_PERFCOUNTER9_CFG__CLEAR__SHIFT                                                         0x1d
+#define GCUTCL2_NHTTLB_PERFCOUNTER9_CFG__PERF_SEL_MASK                                                        0x000000FFL
+#define GCUTCL2_NHTTLB_PERFCOUNTER9_CFG__PERF_SEL_END_MASK                                                    0x0000FF00L
+#define GCUTCL2_NHTTLB_PERFCOUNTER9_CFG__PERF_MODE_MASK                                                       0x0F000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER9_CFG__ENABLE_MASK                                                          0x10000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER9_CFG__CLEAR_MASK                                                           0x20000000L
+//GCUTCL2_NHTTLB_PERFCOUNTER10_CFG
+#define GCUTCL2_NHTTLB_PERFCOUNTER10_CFG__PERF_SEL__SHIFT                                                     0x0
+#define GCUTCL2_NHTTLB_PERFCOUNTER10_CFG__PERF_SEL_END__SHIFT                                                 0x8
+#define GCUTCL2_NHTTLB_PERFCOUNTER10_CFG__PERF_MODE__SHIFT                                                    0x18
+#define GCUTCL2_NHTTLB_PERFCOUNTER10_CFG__ENABLE__SHIFT                                                       0x1c
+#define GCUTCL2_NHTTLB_PERFCOUNTER10_CFG__CLEAR__SHIFT                                                        0x1d
+#define GCUTCL2_NHTTLB_PERFCOUNTER10_CFG__PERF_SEL_MASK                                                       0x000000FFL
+#define GCUTCL2_NHTTLB_PERFCOUNTER10_CFG__PERF_SEL_END_MASK                                                   0x0000FF00L
+#define GCUTCL2_NHTTLB_PERFCOUNTER10_CFG__PERF_MODE_MASK                                                      0x0F000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER10_CFG__ENABLE_MASK                                                         0x10000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER10_CFG__CLEAR_MASK                                                          0x20000000L
+//GCUTCL2_NHTTLB_PERFCOUNTER11_CFG
+#define GCUTCL2_NHTTLB_PERFCOUNTER11_CFG__PERF_SEL__SHIFT                                                     0x0
+#define GCUTCL2_NHTTLB_PERFCOUNTER11_CFG__PERF_SEL_END__SHIFT                                                 0x8
+#define GCUTCL2_NHTTLB_PERFCOUNTER11_CFG__PERF_MODE__SHIFT                                                    0x18
+#define GCUTCL2_NHTTLB_PERFCOUNTER11_CFG__ENABLE__SHIFT                                                       0x1c
+#define GCUTCL2_NHTTLB_PERFCOUNTER11_CFG__CLEAR__SHIFT                                                        0x1d
+#define GCUTCL2_NHTTLB_PERFCOUNTER11_CFG__PERF_SEL_MASK                                                       0x000000FFL
+#define GCUTCL2_NHTTLB_PERFCOUNTER11_CFG__PERF_SEL_END_MASK                                                   0x0000FF00L
+#define GCUTCL2_NHTTLB_PERFCOUNTER11_CFG__PERF_MODE_MASK                                                      0x0F000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER11_CFG__ENABLE_MASK                                                         0x10000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER11_CFG__CLEAR_MASK                                                          0x20000000L
+//GCUTCL2_NHTTLB_PERFCOUNTER12_CFG
+#define GCUTCL2_NHTTLB_PERFCOUNTER12_CFG__PERF_SEL__SHIFT                                                     0x0
+#define GCUTCL2_NHTTLB_PERFCOUNTER12_CFG__PERF_SEL_END__SHIFT                                                 0x8
+#define GCUTCL2_NHTTLB_PERFCOUNTER12_CFG__PERF_MODE__SHIFT                                                    0x18
+#define GCUTCL2_NHTTLB_PERFCOUNTER12_CFG__ENABLE__SHIFT                                                       0x1c
+#define GCUTCL2_NHTTLB_PERFCOUNTER12_CFG__CLEAR__SHIFT                                                        0x1d
+#define GCUTCL2_NHTTLB_PERFCOUNTER12_CFG__PERF_SEL_MASK                                                       0x000000FFL
+#define GCUTCL2_NHTTLB_PERFCOUNTER12_CFG__PERF_SEL_END_MASK                                                   0x0000FF00L
+#define GCUTCL2_NHTTLB_PERFCOUNTER12_CFG__PERF_MODE_MASK                                                      0x0F000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER12_CFG__ENABLE_MASK                                                         0x10000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER12_CFG__CLEAR_MASK                                                          0x20000000L
+//GCUTCL2_NHTTLB_PERFCOUNTER13_CFG
+#define GCUTCL2_NHTTLB_PERFCOUNTER13_CFG__PERF_SEL__SHIFT                                                     0x0
+#define GCUTCL2_NHTTLB_PERFCOUNTER13_CFG__PERF_SEL_END__SHIFT                                                 0x8
+#define GCUTCL2_NHTTLB_PERFCOUNTER13_CFG__PERF_MODE__SHIFT                                                    0x18
+#define GCUTCL2_NHTTLB_PERFCOUNTER13_CFG__ENABLE__SHIFT                                                       0x1c
+#define GCUTCL2_NHTTLB_PERFCOUNTER13_CFG__CLEAR__SHIFT                                                        0x1d
+#define GCUTCL2_NHTTLB_PERFCOUNTER13_CFG__PERF_SEL_MASK                                                       0x000000FFL
+#define GCUTCL2_NHTTLB_PERFCOUNTER13_CFG__PERF_SEL_END_MASK                                                   0x0000FF00L
+#define GCUTCL2_NHTTLB_PERFCOUNTER13_CFG__PERF_MODE_MASK                                                      0x0F000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER13_CFG__ENABLE_MASK                                                         0x10000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER13_CFG__CLEAR_MASK                                                          0x20000000L
+//GCUTCL2_NHTTLB_PERFCOUNTER14_CFG
+#define GCUTCL2_NHTTLB_PERFCOUNTER14_CFG__PERF_SEL__SHIFT                                                     0x0
+#define GCUTCL2_NHTTLB_PERFCOUNTER14_CFG__PERF_SEL_END__SHIFT                                                 0x8
+#define GCUTCL2_NHTTLB_PERFCOUNTER14_CFG__PERF_MODE__SHIFT                                                    0x18
+#define GCUTCL2_NHTTLB_PERFCOUNTER14_CFG__ENABLE__SHIFT                                                       0x1c
+#define GCUTCL2_NHTTLB_PERFCOUNTER14_CFG__CLEAR__SHIFT                                                        0x1d
+#define GCUTCL2_NHTTLB_PERFCOUNTER14_CFG__PERF_SEL_MASK                                                       0x000000FFL
+#define GCUTCL2_NHTTLB_PERFCOUNTER14_CFG__PERF_SEL_END_MASK                                                   0x0000FF00L
+#define GCUTCL2_NHTTLB_PERFCOUNTER14_CFG__PERF_MODE_MASK                                                      0x0F000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER14_CFG__ENABLE_MASK                                                         0x10000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER14_CFG__CLEAR_MASK                                                          0x20000000L
+//GCUTCL2_NHTTLB_PERFCOUNTER15_CFG
+#define GCUTCL2_NHTTLB_PERFCOUNTER15_CFG__PERF_SEL__SHIFT                                                     0x0
+#define GCUTCL2_NHTTLB_PERFCOUNTER15_CFG__PERF_SEL_END__SHIFT                                                 0x8
+#define GCUTCL2_NHTTLB_PERFCOUNTER15_CFG__PERF_MODE__SHIFT                                                    0x18
+#define GCUTCL2_NHTTLB_PERFCOUNTER15_CFG__ENABLE__SHIFT                                                       0x1c
+#define GCUTCL2_NHTTLB_PERFCOUNTER15_CFG__CLEAR__SHIFT                                                        0x1d
+#define GCUTCL2_NHTTLB_PERFCOUNTER15_CFG__PERF_SEL_MASK                                                       0x000000FFL
+#define GCUTCL2_NHTTLB_PERFCOUNTER15_CFG__PERF_SEL_END_MASK                                                   0x0000FF00L
+#define GCUTCL2_NHTTLB_PERFCOUNTER15_CFG__PERF_MODE_MASK                                                      0x0F000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER15_CFG__ENABLE_MASK                                                         0x10000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER15_CFG__CLEAR_MASK                                                          0x20000000L
+//GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL
+#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__PERF_COUNTER_SELECT__SHIFT                                      0x0
+#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__START_TRIGGER__SHIFT                                            0x8
+#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__STOP_TRIGGER__SHIFT                                             0x10
+#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__ENABLE_ANY__SHIFT                                               0x18
+#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__CLEAR_ALL__SHIFT                                                0x19
+#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__STOP_ALL_ON_SATURATE__SHIFT                                     0x1a
+#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__PERF_COUNTER_SELECT_MASK                                        0x0000000FL
+#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__START_TRIGGER_MASK                                              0x0000FF00L
+#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__STOP_TRIGGER_MASK                                               0x00FF0000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__ENABLE_ANY_MASK                                                 0x01000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__CLEAR_ALL_MASK                                                  0x02000000L
+#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__STOP_ALL_ON_SATURATE_MASK                                       0x04000000L
+
+
 // addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcl2tlbpldec
 //GC_L2TLB_PERFCOUNTER0_CFG
 #define GC_L2TLB_PERFCOUNTER0_CFG__PERF_SEL__SHIFT                                                            0x0
-- 
2.34.1

