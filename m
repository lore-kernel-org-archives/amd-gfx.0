Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC112CCD192
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 02:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DFC410E6D9;
	Wed, 15 Oct 2025 02:59:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qpDt/0dk";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012039.outbound.protection.outlook.com
 [40.107.200.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 257A510E6D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 02:59:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0/w22YomW08n3933X98yL5iRaL7Vg0nfPknOXaRK6CyGoxe5ozWTclymQoG1cfds4bXko74ai5Hl5xQs0szCrPOIqLRjq+RgG5kHe0ZkWAI0NU8qsdvGkZSvVNxa6fr/83KET4AcPr1ukf610JekZfsaHXYxK2EGoQj0AB+Z7Gi/ZYSzCDnU4EFuxloknHPzTMuOqFlZUOopJR47Ek1DZ4UsBASeDkEc8HJaix5Nzzs95ul7TSofKoSWPB3UzCmZN58rDjZNLHBruCrSpTbziTsXXYH4Y5yuj45uIaT4vnlSYwFrsywmskF8C+R7gsPwUoCpyIQF8bdaOK4OzJHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJiIemB/5YK0JcHTkLb6eBFMUnbdJPUZ6BPiSDYGnt8=;
 b=t3scGvdN7ddflUMYJ4GiNKxGfzBg9bn0AEu/FfOANzO5pxHtOfEKv6ZEgMiqixDgMYF6dZ2XgjXpN+HEumRebDYUHOLhKTD/pWdwKeid1gg6iPnr6IIhnFi8Nu/WqUit8FtyJJrUNdPeCegO7STcFQJHhpHp9y8fYcDf+5kGYfWC225lrZ29fVPmIpdqEHr7li8mlTatNHmw5lnfopqXkZMugqQckaNf07XSXgQ8oAR9eWdhj7iQA0xMzbpluQUttTWTtsYJwmU6s4boCDusy1c7GTVm5FBNA/fQJ1LGI3eSo0Qa9ZPaQ1T161LMGXYUmNlB3cyfOM7r7T1ulqkTsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJiIemB/5YK0JcHTkLb6eBFMUnbdJPUZ6BPiSDYGnt8=;
 b=qpDt/0dka6m0be91wHEtdqsLDERV1l7uTsxVu9ENjdtJyN1cv0e+UIoikpZ+mfzETfVPYA0XIa7m/LhjVpaw0vNxfaSCvEAFRRdcex9azgYD9KtYkAnasZUcStwJ8AqTw4QDwQT/kyeg/pTr8PjMVL+ImRC37Xn2cBhK0yIfDns=
Received: from SJ0PR13CA0028.namprd13.prod.outlook.com (2603:10b6:a03:2c0::33)
 by SA5PPFC3F406448.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Wed, 15 Oct
 2025 02:59:04 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::8) by SJ0PR13CA0028.outlook.office365.com
 (2603:10b6:a03:2c0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Wed,
 15 Oct 2025 02:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 02:59:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 14 Oct
 2025 19:58:59 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Oct
 2025 21:58:59 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Oct 2025 19:58:56 -0700
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Cruise Hung <Cruise.Hung@amd.com>, "Meenakshikumar
 Somasundaram" <meenakshikumar.somasundaram@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 6/8] drm/amd/display: Control BW allocation in FW side
Date: Wed, 15 Oct 2025 10:57:07 +0800
Message-ID: <20251015025816.1542507-7-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015025816.1542507-1-chiahsuan.chung@amd.com>
References: <20251015025816.1542507-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|SA5PPFC3F406448:EE_
X-MS-Office365-Filtering-Correlation-Id: d9dac056-3586-4fc1-db8b-08de0b96caa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v0j+ZDv++Cn1WtNht4+OvCZhzBFOTXMsysYPMF9bxMFXkEUvtRSFI58FhlyB?=
 =?us-ascii?Q?TbAWlp20iVscixwzymV713MtdAYyOWiF2OKyjZ4M10SpzaaPMLHoj+aNxNlJ?=
 =?us-ascii?Q?dB3cZYSA7HeBFEypKa5Gdh+LixlpOhwQvMOLu+hCB6/X+szxxbZ/63Xeb01A?=
 =?us-ascii?Q?LRsvqwINCOnPYK1iqbrlQ7V5X5StoAWDCd+lKri31Fas7hLlIWwWNB9q/mUL?=
 =?us-ascii?Q?7lvabRc/KAMuYhL5LthPFFhwYIeOmo7/VMdUuObfTM7FJTJfUAciYJC/0v8Y?=
 =?us-ascii?Q?kXSi/OY3OC2qbtATgU7TRBhIOLfZk+4CXNkNem/dBZPUyT+joRfVpN0YEqFz?=
 =?us-ascii?Q?XN66GJc+CLlkRsw3WX75NcrUa3D1gfAil9ec6VuyHcH3Pu952WENkPmGepxO?=
 =?us-ascii?Q?SzSQ3ydyHxOT2RW5xh/1il+6N5KoxuH+jTKWRzIutSZoLzawhBLX7xJE6B+c?=
 =?us-ascii?Q?wGwciytP0x/ZRK7Ix7XWv3Lk0FEjHPzahPbz/bePL8Y7F7ZBc3IC38KwWF0w?=
 =?us-ascii?Q?L0b6RRJ+nqCnJakEYssY+3nko5TV/zwMPm2zPhCgaCruHbdBqaJ+oOn3zVCS?=
 =?us-ascii?Q?MNh/OgdU2AkJKlZc7OGgb52ObIZ5a7cuKbL4m1N/4NL8Xv2FcyiKmHZm8oIg?=
 =?us-ascii?Q?I4Z23IQOMjxxjKPcDEgxO/VafHAUEoX/4BQeKw1x34pS+tdm4+H0ALPpxrjP?=
 =?us-ascii?Q?4ubpnFuL1bVJ8oiau7wdZUcNawJWEXCxO17ZXpdLUIrIGdrs4eTLfYhl33vG?=
 =?us-ascii?Q?dIlAmCpnRYMQQRwED4YQwlGwU0ZgUr9yH8V4CdoLHJBdR7DuGDf+AxqXRL0/?=
 =?us-ascii?Q?qNRR+xcTuNGOGhvJI4LtLsxzn4aAxdjXbHioHyxbARasDlcPHorPHASYjJ3t?=
 =?us-ascii?Q?XS1tubfL+9LsucRAPv81hW03aNUS2PCCjZIKQmhcVr9qqhlsNpGvvHZYwFuq?=
 =?us-ascii?Q?9ybqb9+AVvIPS+3q8VOXV83ydF6dOU7VxbUEhETA8T7kiw8GVaajreaWsJTe?=
 =?us-ascii?Q?xBbjEAh8zcGiOA/6hIyp1qq9EhwBy8FfeBoyhk+SuAumsvF+oArg8dNj5pI1?=
 =?us-ascii?Q?smGfQNEcWoz/HcPKWKmssK2ofZNKbt7HFNTUkcQS3TsVVg9433M0n4rT3/Cc?=
 =?us-ascii?Q?X6eVem6aYzuaIpTF4Ehb1PmoEILeuV2gQK2PwATRl9pOP0Z7A+8WaNXXPJm/?=
 =?us-ascii?Q?SDhNDYuM8bqiLyHaNQYm36VOyN9z10u0Ya64BuYKbcI9Zn6yVB7GOwdRMgxd?=
 =?us-ascii?Q?vv/+Kax2IIRXqtCxG/8iDTRmvE7wVCUfGt5v/oDAO64KfHQU4nlnSqchXbsG?=
 =?us-ascii?Q?dc4LECxZa6V16ltQorsoOe9DDSVymvNMAQKUjmjQ+csOU82bULWC2NAF6/iu?=
 =?us-ascii?Q?iH3MBrAbXJbdC3CWaYcfAhv3K1B/ho+eSi9vl2B8tup0oFt5VbenNq13eT2p?=
 =?us-ascii?Q?OqAq+v46Jzy9f5ROT9D8P78MEPc3BD+i76UokpUm9BZo00olwtIYPE+sF5V2?=
 =?us-ascii?Q?cqHcD9Rbn6W8EwNX3iiRoHFibolVsjGe2qeTWAz+sTCyG61D02QuD+/9aN65?=
 =?us-ascii?Q?RQStBgXgeOQnpoEIclo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 02:59:00.4978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dac056-3586-4fc1-db8b-08de0b96caa9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFC3F406448
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

From: Cruise Hung <Cruise.Hung@amd.com>

[Why]
The BW allocation feature should be controlled in FW side.

[How]
Pass the control bit to FW boot option.

Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                          | 3 +--
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c  | 5 -----
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h                  | 1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c            | 1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c            | 1 +
 5 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b39ed429a312..c661a0191c50 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -850,8 +850,7 @@ union dpia_debug_options {
 		uint32_t enable_force_tbt3_work_around:1; /* bit 4 */
 		uint32_t disable_usb4_pm_support:1; /* bit 5 */
 		uint32_t enable_usb4_bw_zero_alloc_patch:1; /* bit 6 */
-		uint32_t enable_bw_allocation_mode:1; /* bit 7 */
-		uint32_t reserved:24;
+		uint32_t reserved:25;
 	} bits;
 	uint32_t raw;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index b16eb97ae11c..c958d3f600c8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -225,11 +225,6 @@ bool link_dpia_enable_usb4_dp_bw_alloc_mode(struct dc_link *link)
 	bool ret = false;
 	uint8_t val;
 
-	if (link->dc->debug.dpia_debug.bits.enable_bw_allocation_mode == false) {
-		DC_LOG_DEBUG("%s:  link[%d] DPTX BW allocation mode disabled", __func__, link->link_index);
-		return false;
-	}
-
 	val = DPTX_BW_ALLOC_MODE_ENABLE | DPTX_BW_ALLOC_UNMASK_IRQ;
 
 	if (core_link_write_dpcd(link, DPTX_BW_ALLOCATION_MODE_CONTROL, &val, sizeof(uint8_t)) == DC_OK) {
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 9012a7ba1602..f25c2fc2f98f 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -318,6 +318,7 @@ struct dmub_srv_hw_params {
 	bool enable_non_transparent_setconfig;
 	bool lower_hbr3_phy_ssc;
 	bool override_hbr3_pll_vco;
+	bool disable_dpia_bw_allocation;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 4777c7203b2c..cd04d7c756c3 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -380,6 +380,7 @@ void dmub_dcn31_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	boot_options.bits.override_hbr3_pll_vco = params->override_hbr3_pll_vco;
 
 	boot_options.bits.sel_mux_phy_c_d_phy_f_g = (dmub->asic == DMUB_ASIC_DCN31B) ? 1 : 0;
+	boot_options.bits.disable_dpia_bw_allocation = params->disable_dpia_bw_allocation;
 
 	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 834e5434ccb8..b40482dbd6ad 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -418,6 +418,7 @@ void dmub_dcn35_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	boot_options.bits.disable_sldo_opt = params->disable_sldo_opt;
 	boot_options.bits.enable_non_transparent_setconfig = params->enable_non_transparent_setconfig;
 	boot_options.bits.lower_hbr3_phy_ssc = params->lower_hbr3_phy_ssc;
+	boot_options.bits.disable_dpia_bw_allocation = params->disable_dpia_bw_allocation;
 
 	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
 }
-- 
2.43.0

