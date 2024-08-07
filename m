Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3DEC52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BD8F10E449;
	Wed,  7 Aug 2024 07:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U2gSW7d5";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A137F10E448
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DePxJ6Sw2qK1AKwnZ7uqnQokp7jPdo7o34Pgn1k9jnJzF31xRRw3Y4+ZVCuKDFstgXe6IMBjSIedvnzItzEpBXFkRZPvYMvBcXfYotA+KmWSrGbKqKXctj++0EZPyHVuzErbeiS5A4SOvuthKPopqi+vUFJlJD34FbmQXZDUzkr+IAUUxPJSR7DYdrfmphUCfjdbp4CJsNirV+7uSGrUbZ1ZBm/qsxxQELMYprA0DTKZFEEt7hLDOUaUP/w98V3SkdoZUmfnsKAdfHgy++vhhhTYgSJ3FACEuAUvR4gDTuTx1H9JBt9V3kEo63ddE+IXj8njWbN91d1h4d1pMbOx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MwN+BNJjaOlrF8BbIhSRhqJBnPzARTagnaV/biwg6o=;
 b=pR4Ur9OIjSVU4jAnhuAHmMD3+xaaWhbXrJqp/lDvxQaprdskKbWs/vkG4JzaQzY/hI3k34K2CDHErpTDKo/t6zgn0tyw+PgFalQEV4uzRMUb0sHO3qsAAEkooNbb9sbNMIj45XsZJ236TF5NCh0C832lXW3fa+AktHXYYQ2TjbYCeKZRYnktW/LX6fb4Ia0QTJdlSVyt3X1aQTGGuc/O24j+0edDaDSaVYUyCF0S3dE0wxoscvej7jqlImA1ikoMIZvTugFp0K+6bF7+8s0ifAsNnHimXHZtj+e3OoC2YsgsgznGWPjrXF6W0NVhjKyXrX85qFOnjFQGDixn867+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MwN+BNJjaOlrF8BbIhSRhqJBnPzARTagnaV/biwg6o=;
 b=U2gSW7d5pJlOic0/EIuOG7sSIzO+Vs/boMCuymRj1EJ82Qj98sS1SwOO8MTiQ60TkK58luq3VCrYiK83Z0aWkhCYsrwlNmg0epU8FiRz+VNzFEXL60Oiw700uGY4KDUiT8fmM05CwmQBM3T7dEKGean20whcAVgjzC23ApYr7zE=
Received: from BN9PR03CA0806.namprd03.prod.outlook.com (2603:10b6:408:13f::31)
 by CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 7 Aug
 2024 07:57:17 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::43) by BN9PR03CA0806.outlook.office365.com
 (2603:10b6:408:13f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28 via Frontend
 Transport; Wed, 7 Aug 2024 07:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:57:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:57:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:57:14 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:57:11 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Charlene Liu
 <Charlene.Liu@amd.com>, Chris Park <chris.park@amd.com>
Subject: [PATCH 17/24] drm/amd/display: remove redundant msg to pmfw at
 boot/resume
Date: Wed, 7 Aug 2024 15:55:39 +0800
Message-ID: <20240807075546.831208-18-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|CYYPR12MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ffe8d9d-0425-4ba0-883e-08dcb6b68e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h66Vom/s4iJJYqKLE1Z+Guy5gUbR6ezznu7TUiCaYrLeMeSHFhKIQVqvlFuj?=
 =?us-ascii?Q?t31+BM9xUXOSl68oZrvOK7+3geQxoCGFnNHsAP+CZ5EB/E8gE4q47aXpJzDM?=
 =?us-ascii?Q?3L6dEuDC7SvramJYlnoFJvDgxr+qLDDqnc5eQMSQaSpC9cGhDAvxoMFEn21a?=
 =?us-ascii?Q?nichji2EwdOwImeQ7AV99HHvrBsA4EuUSPG92XOt0nIRzRq5qZVjWh2ZfhaX?=
 =?us-ascii?Q?ztp5VI9yqK4cJw0xHNsDS8gKjkBkXLpbLMBJyFravxYSJRaZkw5gGhTg0uS1?=
 =?us-ascii?Q?Sxpool0+nMNU2HxRuSB54XN5BFsmjQLXicLCC66xWNIZTSH5p45tbKpuAOML?=
 =?us-ascii?Q?oTtL6mY+pOkzOm3MNvUUP+eBuJhuSIitnSEuaXvk1ncZKI30RNMIATHd9w+d?=
 =?us-ascii?Q?L5Pm6Au6eiUOrqHWD0gwT2sl3VuGLwCiNec/XpsflpIuM/AV6x5nptc3I6KC?=
 =?us-ascii?Q?XUAsxFr0Dky2WOQIlBXiLp0Mvz9GO534ie/CtkrF3vcLVcOtYf2x2Li4JbmD?=
 =?us-ascii?Q?nGnHqtrTfbJHuvPK8qmqVjhT9oCppuG9g0pblrn/H4u+lAD6JwvHz2ZNp30g?=
 =?us-ascii?Q?5C0H79MDsbxGA1nqznxdN7GJglxppaii6O7uYPgMcQYH1eqoOLAKyYH5ul3J?=
 =?us-ascii?Q?WI1KI3DdN/yIL7xXu8dyRB7eAEsF6aR3Q9FvVuJI2SLctNisc6a1Bk5tDh5N?=
 =?us-ascii?Q?+ImlMmuS3afGvwHHLLA0K4IwG1o5d0OsNMQGZkmvCXVJUfIHZKxh78HuXQuD?=
 =?us-ascii?Q?85NcF2urncEk1azu2P3tQf602CITTnD06kk3yr5/eL+EMg4LS7usjkSs0Kas?=
 =?us-ascii?Q?uqfWNppoSk1Riiy1NnYz3PkMeE9BsuGKwVWI7F/abnrDMouGAizTM+1qAkcK?=
 =?us-ascii?Q?ZE4R7Zr/ZJ9LQkhWVJ8a3Q9CEHN2zbFRJNjommi3Yyg4BaoKLSMcQFq1STFZ?=
 =?us-ascii?Q?JsAqymwP/8pJ0sAqM66lO6g6oRkmjdhIyxTsXYC+TeQrEHZi/diMEes+XI56?=
 =?us-ascii?Q?AJHzUD7FWnbvxpuCp6EzDxe5fNLewv/nZyA/2lpiMtTMFBe08FjNSU9UPgIW?=
 =?us-ascii?Q?/E3RUqSsY6A+8pwV0lw6HG6ilkQQ9oKF2ORnsYIBpY3bfkNgp8km09FgKK/a?=
 =?us-ascii?Q?ldz9OZe2B2iavE+GP+Uy64pmUCuOeQhmTM15GORUlbUGdHyK/JYAr6I4h7kz?=
 =?us-ascii?Q?HyJMGOrSLBxeS8IdToSvF78w2PiULnCoxWNERLo+2SnF/VmZRS7AUoUD/GJh?=
 =?us-ascii?Q?qpej5rwwB7zQVEcw8B38BYW6DN3qC5Em7RXYQuUpbNFPk0/8s7xzdSQj+ufQ?=
 =?us-ascii?Q?zljE6PXikRRKdT9pCVzfZlHlCHr5dYb++G2eBYI1VLY499vw3B2R6noGF6pz?=
 =?us-ascii?Q?QyaGYNB1750kheUt0nfWYRZ9doJuOFAllR+eYL/O1jek4XRne0WCy/91/RZL?=
 =?us-ascii?Q?OaACrEvj8jaDPyjzAXkz+z4czH8YfItj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:57:16.7678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffe8d9d-0425-4ba0-883e-08dcb6b68e59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why & how]
this is to remove redundant msg to pmfw at boot/resume
since bios already power up dcn.

Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index e2f5c4d34a55..217344ccf644 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1845,6 +1845,7 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 	bool can_apply_edp_fast_boot = false;
 	bool can_apply_seamless_boot = false;
 	bool keep_edp_vdd_on = false;
+	struct dc_bios *dcb = dc->ctx->dc_bios;
 	DC_LOGGER_INIT();
 
 
@@ -1921,13 +1922,15 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 			hws->funcs.edp_backlight_control(edp_link_with_sink, false);
 		}
 		/*resume from S3, no vbios posting, no need to power down again*/
-		clk_mgr_exit_optimized_pwr_state(dc, dc->clk_mgr);
+		if (dcb && dcb->funcs && !dcb->funcs->is_accelerated_mode(dcb))
+			clk_mgr_exit_optimized_pwr_state(dc, dc->clk_mgr);
 
 		power_down_all_hw_blocks(dc);
 		disable_vga_and_power_gate_all_controllers(dc);
 		if (edp_link_with_sink && !keep_edp_vdd_on)
 			dc->hwss.edp_power_control(edp_link_with_sink, false);
-		clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
+		if (dcb && dcb->funcs && !dcb->funcs->is_accelerated_mode(dcb))
+			clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
 	}
 	bios_set_scratch_acc_mode_change(dc->ctx->dc_bios, 1);
 }
-- 
2.34.1

