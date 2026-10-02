Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0F4CA5FE4
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 19:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A095F10FA02;
	Fri,  2 Oct 2026 19:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GW1+BuTQ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E64A210FA01
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 19:33:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otBbiNZ62y854qjyFpCamMbDzEwxwd0K3qc24mnCbkI4p6qg4bAlwicwtt4TQjxioRPtg9jlaaFCLTGwEJQck40MZOvYgcDP8L2o4eY1fWKwo4K/P2AKw8zqXCg8dR6dKr0kvimPVt739zM6X82hHnNyz1/+9l3xJ72X61eLKr/uucE0n/TrI7EKXBLo6xJko/lZ4h6s8MWLT6DP+mOyxjRYD5A+tTe96l+cC2q/0gDCNXQpjngHOKGYiGffsnKFy4b8htJFWpum1VXN8wPsXMr8rh3wwmB4Ys1tH3bnfL8mnwf3hxYOCsLxmT7s50kEK4iRQXFMyN+ZCVefcWDl1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApfWXXWiJj2Z9zuyBS9Olkjwt+yVl/Q9juaFJ2K4Ro8=;
 b=R0THkonuGH6NOOs1M9u5/x3z/n6lRciR8vcLDnh71UHwj6cFSM3iObLinco5lVuE71hsF7P5RI34aYP8VjGbavXfm7IRaCQBMRG+ivNQf5w2UwQH4DFSPj/oj1aB7AOEoft/V1RxgRrXkxHHZZ+DWvrMA+zDBYP/rG70iRnytUQfFzjSJM3tBgJZmFlNrkUAsiGfKXcpZabGuZZ1OFM7Ry6rz0qLYSAcoOMU+Fh3Al4tvNpfvavK8LQpHSrs3IceMUm0X/1Ar+7GbdQgcOLBJ8E9ZqF+l9XMfQCkOCBrB4gjpEQ5k4Ynmr0v6Q7oPfs7YmfvcA6cInA5U9qRaJomaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApfWXXWiJj2Z9zuyBS9Olkjwt+yVl/Q9juaFJ2K4Ro8=;
 b=GW1+BuTQW5uovlykGxk/w69ZVtvPYfRL9vfTJ8n0wpMihOGvsn/hA+4TBnqPPR1OJG0o4XVcwn9zy+rCE76rfgMhBQqy2xx+j8Z62mKNxT4NyHG81MlZsQd7wq1C28oLZQvjraaCUgubISGt87VlhVAwG9shj0CP3LBepeyLr4w=
Received: from BL1PR13CA0001.namprd13.prod.outlook.com (2603:10b6:208:256::6)
 by SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 19:33:27 +0000
Received: from BN3PEPF00022BD4.namprd03.prod.outlook.com
 (2603:10b6:208:256:cafe::79) by BL1PR13CA0001.outlook.office365.com
 (2603:10b6:208:256::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.11 via Frontend Transport; Fri, 2
 Oct 2026 19:33:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD4.mail.protection.outlook.com (10.167.248.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 19:33:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:33:24 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 14:33:24 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>, Alvin Lee
 <Alvin.Lee2@amd.com>, Austin Zheng <austin.zheng@amd.com>
Subject: [PATCH 15/17] drm/amd/display: Add debug option to override low power
 SR latencies
Date: Fri, 2 Oct 2026 15:32:38 -0400
Message-ID: <20261002193240.3441018-16-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002193240.3441018-1-Roman.Li@amd.com>
References: <20261002193240.3441018-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD4:EE_|SJ0PR12MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: f507054e-67ae-491c-31c2-08df20bc0840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|30052699003|23010399003|1800799024|10067099003|56012099006|6133799003|3023799007|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nJLYNsHDR5GmQRVDIYT04w7UUIJlXkpd9PXRnz+xJcFUcG3iA+E0TAUcxsNjiHqCosQtdKXDrvqZ5OnLfFob7UZYBNkXdMNTG9SBffyJAH6es3SsLoG42VIxhLK8b+amv+f4DfLDIahjlAqlTFRpEa+zDo03RxbnKC6Ch1+gHzYncqK4JchwsUSqiALSn1IVHY4UJcpFSDjdSAszq5ZUZtVtx2PImVxTp8Np6MgjE5eU+VefcOTdBb8/eosCml4y/vXNxt7EEFGQ+ATZGMHJcGZ0m0F9XRv2HISN5T1OREmSh/NDj7IXqOFi+jBw9bc6CViHLaFMFnVqtXcW1jag3+lxQ1MLfloe0/k4K1r4e+rZSWOyQt/6O7K8zfbQuSXdWs96iWrqyoJwwRfdc7u4cEx/pqVqhApTzkv6yH66ZHNlojlp4iYyUFuPFEKsuLDqY1P3JqfQdGpNhWVmM+iHcd85ZZNqyFuLPs3bqAzouxWMDbAirJUwQi6/5VWlCb0BMSXMBJzxS7BbCzk0/zNIXJkp9YqgzDlMIAoB2U5A9mudOu6VUTAmm8p0LxKOz2gR4WM7PlFfe8iEHOk0u5GOJ/p5eHjDxkcelvYfgOaoA2dgY2Smm5yLT28TV4iHhC2epjHxStDXzLdswSAmixbUtcRrJJsHsRHsfr5SrEEvR6W090KJ+sP4H5/ovuSinFR1R8YvQQaCyEGtOFyh0w+F2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(30052699003)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(3023799007)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iyTko6abGF6kHq4C4mHWtfEer8x2nGXjRkmiYjXvENT1zw6TmGUuj10Nh/RZt4J+TqTHF0ztpo1DXwf9VTnsDe+mW048ZHHshMIK0OfEE302VBAPw0QISyHK9Q9Mfsr+iQcjGitz1nQRt4qarOJDcVtaBznYEtGPcpeaKj+gHTb+iRLkGyYNjRMRIuAJwQHIVExLqIQ6YJxrs/FgGFmUviEGHPmd+GNHLdWU9vjS8oqP7LhxB2ENDIdY1H78J7XHUPznjnszFcIIPqD0rokjdXBoIBOvdgEcEl4/YZS18dic7tOsMCmU99pn7O1mBjBZLm2u6eDgNqgY6ZiIJ1TcFFw9CwG5Jwg0S3ym7irmO3dYcZ4kZ8JwvaFMkTT80OV2fU7UkZmXNVwup4wEkoUkRE3Nr2fvOX0/VKY9/LU8TU5bIBV6g3p+krhTDyNPmeMc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:33:27.3813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f507054e-67ae-491c-31c2-08df20bc0840
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6927
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Add debug options to override low power SR latencies
- Match regular SR latency debug override

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
 .../dcn60/dcn60_soc_and_ip_translator.c       | 39 ++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 957e15e4a84c..5cd7699e3e84 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1042,6 +1042,8 @@ struct dc_virtual_addr_space_config {
 struct dc_bounding_box_overrides {
 	unsigned int sr_exit_time_ns;
 	unsigned int sr_enter_plus_exit_time_ns;
+	unsigned int sr_lp_exit_time_ns;
+	unsigned int sr_lp_enter_plus_exit_time_ns;
 	unsigned int sr_exit_z8_time_ns;
 	unsigned int sr_enter_plus_exit_z8_time_ns;
 	unsigned int urgent_latency_ns;
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.c
index f1ee2225e9b8..aef527c7584b 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.c
@@ -79,6 +79,43 @@ static void dcn60_update_soc_bb_with_values_from_dmub(struct dml2_soc_bb *soc_bb
 			min_alt_ch_carveout_size_mb;
 }
 
+static void dcn60_update_soc_bb_with_values_from_software_policy(struct dml2_soc_bb *soc_bb, const struct dc *dc)
+{
+	/* set if the value is provided */
+	if (dc->bb_overrides.sr_exit_time_ns)
+		soc_bb->power_management_parameters.stutter_exit_latency_us =
+				dc->bb_overrides.sr_exit_time_ns / 1000.0;
+
+	if (dc->bb_overrides.sr_enter_plus_exit_time_ns)
+		soc_bb->power_management_parameters.stutter_enter_plus_exit_latency_us =
+				dc->bb_overrides.sr_enter_plus_exit_time_ns / 1000.0;
+
+	if (dc->bb_overrides.dram_clock_change_latency_ns)
+		soc_bb->power_management_parameters.dram_clk_change_blackout_us =
+				dc->bb_overrides.dram_clock_change_latency_ns / 1000.0;
+
+	if (dc->bb_overrides.fclk_clock_change_latency_ns)
+		soc_bb->power_management_parameters.fclk_change_blackout_us =
+				dc->bb_overrides.fclk_clock_change_latency_ns / 1000.0;
+
+	if (dc->bb_overrides.sr_exit_z8_time_ns)
+		soc_bb->power_management_parameters.z8_stutter_exit_latency_us =
+				dc->bb_overrides.sr_exit_z8_time_ns / 1000.0;
+
+	if (dc->bb_overrides.sr_enter_plus_exit_z8_time_ns)
+		soc_bb->power_management_parameters.z8_stutter_enter_plus_exit_latency_us =
+				dc->bb_overrides.sr_enter_plus_exit_z8_time_ns / 1000.0;
+
+	/* low power stutter latencies exist only on DCN6 and above */
+	if (dc->bb_overrides.sr_lp_exit_time_ns)
+		soc_bb->power_management_parameters.low_power_stutter_exit_latency_us =
+				dc->bb_overrides.sr_lp_exit_time_ns / 1000.0;
+
+	if (dc->bb_overrides.sr_lp_enter_plus_exit_time_ns)
+		soc_bb->power_management_parameters.low_power_stutter_enter_plus_exit_latency_us =
+				dc->bb_overrides.sr_lp_enter_plus_exit_time_ns / 1000.0;
+}
+
 static void apply_soc_bb_updates(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config)
 {
 	/* Individual modification can be overwritten even if it was obtained by a previous function.
@@ -89,7 +126,7 @@ static void apply_soc_bb_updates(struct dml2_soc_bb *soc_bb, const struct dc *dc
 	dcn60_update_soc_bb_with_values_from_dmub(soc_bb, config);
 	dcn401_update_soc_bb_with_values_from_clk_mgr(soc_bb, dc, config);
 	dcn401_update_soc_bb_with_values_from_vbios(soc_bb, dc);
-	dcn401_update_soc_bb_with_values_from_software_policy(soc_bb, dc);
+	dcn60_update_soc_bb_with_values_from_software_policy(soc_bb, dc);
 }
 
 static void dcn60_get_soc_bb(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config)
-- 
2.34.1

