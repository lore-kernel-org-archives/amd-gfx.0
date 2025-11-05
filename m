Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD3BCCFA19
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 15:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A220810E2D5;
	Wed,  5 Nov 2025 15:41:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v7FIuDOP";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012043.outbound.protection.outlook.com
 [40.93.195.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25B0110E2D2
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 15:41:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyeIyxJfVQNhw+osPUClNyaBMlkiAsQaeN0v6mFCLQWOYe1KAeJ5un+sjgVcwRvFkcb25FvtX7Uj7dUM77r0KsMeA4qoRPdPA+BBxIsIYJhBX2sV01fhFL+Bf0dhflZhPkCq9pYKCmZDLI+6dM+PssHMHWaT4fHrXskmwF/+o/xFrSY37ZGafQ0nE+ueiqk17XCTqosFq5PKOaZZNJ92r4GLcMdqVK6VnsDsgL+btEsZYD5LQ/1HpynCtXnQ+OsrtuPa19rihMfArVwcQj9gIyUDtKod8mHMqtD668KLpYxQQowePIRBuOq+N480J1nnEs3kFq1E8At/UlehWz2D2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eR3Q2zLoaj+iNlCnjmR6jGp1SJ7qcUwvLMsaYg/EhW8=;
 b=kGX5mrgQNWRABJtSKyxHXaqy4UiCoEoxlVDd1AFXEXTHVX7yGlYZm1fbsu6HQCw3fUtWVCY58dlEsRE8nW0VjodfLWX5YXY3W5RowfW7vxN96onTzxirHFojqEyq7dPBfyrV54Ja97RlTH1FNZab0JQ63Hl68tndd7bJ8Wdwp1snUs88ExwqlmzGPQsKE8zMhubHpzIDrr/iU5iF6KNYoNg17CeG9IJYJ486MF6hvNEYH5ZRQSO4UbNUEBG+j6UfIojybuPHa2nhxUDdWbswH+X6hwULQEjMIuV92vbk5Yv32uxl7XA4SbVhtoA8ABDz0G5XynWsC2EbHCkWVU+i0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eR3Q2zLoaj+iNlCnjmR6jGp1SJ7qcUwvLMsaYg/EhW8=;
 b=v7FIuDOP22oZPvTx3wES1HH99H4W4WJ9HX9TUOEEiHZrq4tsbW4u4+nlS2mn5og5ibeb2j3f1vEmG2V3AMouof6Zsx/QdoJlXD/jT0TfePoajDMQUggs5xU4RM1YMgCvUzUJcvt5hakS4ZXlDkDdTs8hBXDfDszUPfQTQ0ykF8Y=
Received: from BN1PR10CA0012.namprd10.prod.outlook.com (2603:10b6:408:e0::17)
 by CH3PR12MB8259.namprd12.prod.outlook.com (2603:10b6:610:124::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 15:41:03 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::a2) by BN1PR10CA0012.outlook.office365.com
 (2603:10b6:408:e0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 15:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 15:41:02 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 07:40:53 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 07:40:53 -0800
Received: from jzuo-laptop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 5 Nov 2025 07:40:52 -0800
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, George Shen <george.shen@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 04/13] drm/amd/display: Add interface to capture power feature
 status for debug logging
Date: Wed, 5 Nov 2025 10:36:19 -0500
Message-ID: <20251105154035.883188-5-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105154035.883188-1-Jerry.Zuo@amd.com>
References: <20251105154035.883188-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|CH3PR12MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e38e85a-5c48-476d-99a5-08de1c81b9ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?omg++IlbapXIVOC2PPgYT8Ip2z9WpgWNcSDNXXYeLAHVubFW6JZlUviT90YJ?=
 =?us-ascii?Q?nO9dDYaGs6B7GM9UxGUerpy6dkVT/jyjxMMmr8bxaSUNV0RmIEGoUFmcihy4?=
 =?us-ascii?Q?jTHdtz4dyQTFl72uJvpf/KN65Zg+VMq3e5zjEvySpcJcwBUqrkfwMHOz7ViV?=
 =?us-ascii?Q?zSlkVdlFo+PmGH0yXPU15vT+lHDEmyeh9UUxQvOWPg04wghKYr4GxYseLDtI?=
 =?us-ascii?Q?eH5Di+SiW1gP1R09sGI4bef4n/a6sI1yTsZ0pu8jO/vcjwU/X3oqn4nG4VJw?=
 =?us-ascii?Q?ZxzsvcjuA9s+HGSwugwofDemq1GdNfBXMfETat+8cMwycR8J7uw9/hij8HA+?=
 =?us-ascii?Q?n1BSOB5tWwpZArNVTqtf1sqr/LN7lyuYQaDqnPT8KRYlzoaSx7SQOz2idOLD?=
 =?us-ascii?Q?BJuBzygtATnE4NkuI+kQqT6it4Bb0yf7zzmHkOZQW9wwsKTBjP8LvfgY729D?=
 =?us-ascii?Q?D8sNh8In7mFt03KpxtXItDwA3BXLhak0VYus/5YlnAG35IDUNdmgGpp3bpgf?=
 =?us-ascii?Q?OIykhmRviaYa1vHkSoyFMZ3iQ+rsTBb42DNQv/Cvc+nGyGgx5CfrOcTKNpQS?=
 =?us-ascii?Q?u2e/uRYY64yN85roeESXh/O67KYzq28QVHVPkNRz+gfHAsOr6M5eD2748y/x?=
 =?us-ascii?Q?TMT5IoRtn/Ab0/VD1ksI43zYftvj5H64aXDWLyeZy8XuRmpzazek7nQp28F7?=
 =?us-ascii?Q?MHu8ycsFFyoWmmPdC+bLzlAwjzwawQsF40AcdDOlmcwpSj9bNwwjBZVLmI/y?=
 =?us-ascii?Q?QdJK21UwbrrHCnolewdzzVnwxreg2V27/0zT5lxfETXtmJDIwHNwyr5f3Y5A?=
 =?us-ascii?Q?ZLzlNxwjmg+0ROsTWkSmqW+t8xnq8CTnepzbxXcGuq+e5whnbLBaD02yAh/D?=
 =?us-ascii?Q?DkVfWBdMM5w8i8RMFcUI9EuldrqADVCw50qvsxfFSXi3wzisNVXjQSbOhIuN?=
 =?us-ascii?Q?5bdXB2ZVfjRuz0Z4qgnl3m6+IM8ut2V63G3WpM5vv9LV6bwt6yvTNRGSukFb?=
 =?us-ascii?Q?8e1uXUCrsxbDdcbUbWCcjIsJjipaw+Gc7LWF/SyU4TgMLr/QFIDbwbZY5eJ4?=
 =?us-ascii?Q?45IOjwucVsBf6fTBrqr4FUe57cN44WTCkuReChx3RrZQoi5xMLxFouXvcYFF?=
 =?us-ascii?Q?t14Z3zTcTkSkWJXt7/SPZ/j9PUYnAJNZUwsCrqueuV86BNmYR6C07dOPMidF?=
 =?us-ascii?Q?MYHryztICK4gKt3PuqeqhO0PnQ9LaO/W3+raxB10js27b/joPYED7KqVucNI?=
 =?us-ascii?Q?z2VvGafWRIiH+DfUUU/IEzatgPXOhVjQlwdo2wfdtijo3yv/nd52etgOcCXN?=
 =?us-ascii?Q?kUTXwyskch6lGn4MEQKUe3Kx28+p2+JCioQAV+FWd5ICPNW1Gpvn6NFB7wwM?=
 =?us-ascii?Q?4TbARLlSkmm1TaFXhxRilkoxmDSAVQs1IB9TQMQyCsaTlP9LC4/Hyo5YFN/b?=
 =?us-ascii?Q?VCZz3TssYLAeIxYUmfwczoJIID5oBAUtfQruCmREbVt5ApoQTGe+VTl7JaSa?=
 =?us-ascii?Q?VcJ1BasfxKgZuzfNbpkKTV1vRikz/lMUhJPMADEAHqUMKc3FHlEjnMrcLhGi?=
 =?us-ascii?Q?8h5G+60OOITXqc/yLEE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:41:02.9633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e38e85a-5c48-476d-99a5-08de1c81b9ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8259
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

From: George Shen <george.shen@amd.com>

[Why]
The status of various power features is often important information when
debugging certain issues, such as underflow. This info helps to
narrow down the potential sources of errors.

[How]
Add dc interface to capture power feature enablement status.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c |  7 +++++++
 drivers/gpu/drm/amd/display/dc/dc.h      | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f519e5893a68..5e79962c5f2b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6421,6 +6421,13 @@ void dc_get_underflow_debug_data_for_otg(struct dc *dc, int primary_otg_inst,
 		dc->hwss.get_underflow_debug_data(dc, tg, out_data);
 }
 
+void dc_get_power_feature_status(struct dc *dc, int primary_otg_inst,
+				struct power_features *out_data)
+{
+	out_data->uclk_p_state = dc->current_state->clk_mgr->clks.p_state_change_support;
+	out_data->fams = dc->current_state->bw_ctx.bw.dcn.clk.fw_based_mclk_switching;
+}
+
 void dc_log_preos_dmcub_info(const struct dc *dc)
 {
 	dc_dmub_srv_log_preos_dmcub_info(dc->ctx->dmub_srv);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5c19df8ef641..1ba7bab51a3b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1865,6 +1865,18 @@ struct dc_underflow_debug_data {
 	struct dcn_dccg_reg_state *dccg_reg_state[MAX_PIPES];
 };
 
+struct power_features {
+	bool ips;
+	bool rcg;
+	bool replay;
+	bool dds;
+	bool sprs;
+	bool psr;
+	bool fams;
+	bool mpo;
+	bool uclk_p_state;
+};
+
 /*
  * Create a new surface with default parameters;
  */
@@ -2772,4 +2784,6 @@ bool dc_can_clear_cursor_limit(const struct dc *dc);
  */
 void dc_get_underflow_debug_data_for_otg(struct dc *dc, int primary_otg_inst, struct dc_underflow_debug_data *out_data);
 
+void dc_get_power_feature_status(struct dc *dc, int primary_otg_inst, struct power_features *out_data);
+
 #endif /* DC_INTERFACE_H_ */
-- 
2.43.0

