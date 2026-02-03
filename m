Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9FFE87834
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 15:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D14D10E6BC;
	Tue,  3 Feb 2026 15:14:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oRZ9ngdX";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFFFA10E6BC
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 15:14:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYPuoj65uFu+L2Q60HzojcXEv7EDOY9gWCMreywbD9cl/+XqA4Hi1Q9WAkXS2JstnoetvkxRKYn+vK86HGuK8m5/KCG9N8P2XxknkE4ZHCiivttggxrFFA/u7PPMr8ViBrsE+1Hi5aK4m/Ds+aUoCcbnILgk8nHpUFHQXQC/gqQ3diTpCn65nyTl4sF/xaO69RE2x8Gzk5Wpy2xGNfE/y/orMMymAjlFVp5s7vWxD8cHsH1IAvn/kNUXYt1mewXh4ryyeVtfpofyYkj97fP2EldbrZiqkdd59VvvhMJX2EF5Ym9jTlQ69v5eTCpoTeMjZTedAqApOdEabhj03r06Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQj2idI74/6RJgYEuMtCS+2P9P6U2vClv0fY+snLT+Q=;
 b=KDnti03sl1/0SFWNo9naxnU2onuCWZcB66BYvcolD8yCGSnGhec8FY/uYC0THO+dDjHl3upL3Q0ty+W9zCb6T1wV+lkfOOVl/+XtPrStU4pvWB8sEhuhzuPIm2W3C+ecZuePVSQpmVOTqcigaYatGLcMvbR4nAsUxhmfY+to6cvUOMr4U5jIG2yS0hFLdObP1i3wUXOgPD5lV6RMSMhs4PSxPC4XvVJqD/LOVrGoCVKqSSHtHqAuTF+KSUBnXoTfaFZ7Eau++AZJwPNSQtkPba6fWOGF7jfh+bC587akgM98l7E77qB3colyALpO4shf3NMwBHlW7k50hfMM95mOtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQj2idI74/6RJgYEuMtCS+2P9P6U2vClv0fY+snLT+Q=;
 b=oRZ9ngdX9JJ4oUcG1SwAnpqJ3tqAbalNjGlHTENKpT+joG44p/ijEn04kAxCNt7WmcMV2Z5x8bCVWMc/xAEaVGFn0i3AUmVGA4jUpgQpk6+kqI0+xxQlBL4hYCzzkdM7vq/UZOvw+LyrHicT24GKD7lq2VjEkdRiByml8JBYV6I=
Received: from SJ0PR03CA0145.namprd03.prod.outlook.com (2603:10b6:a03:33c::30)
 by CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 15:13:58 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::b9) by SJ0PR03CA0145.outlook.office365.com
 (2603:10b6:a03:33c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 15:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 15:13:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:13:55 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:13:55 -0600
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:13:52 -0800
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 15/16] drm/amd/display: [FW Promotion] Release 0.1.46.0
Date: Tue, 3 Feb 2026 23:01:57 +0800
Message-ID: <20260203151229.3673042-16-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
References: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|CH3PR12MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 86009767-2187-4288-8fc4-08de6336da67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OkRWZ8zU4fNg0Ppgq8OXoLu+vDNLjj7c7r/0ctJzUcxMU5pQFq1gqliNHWUm?=
 =?us-ascii?Q?2xR2U/PST6DcEHy5Mp5LxSKjPDGM4h+JL1th7vXqsOi6NEMUkZboYrkEQFvG?=
 =?us-ascii?Q?6smVjJnUVevGv9E49rSv6mVhkfGbgBQDk6pxUtRkPT+xij/zNn5trovQddS6?=
 =?us-ascii?Q?7nWG9QydrBJJj8oGjUBAUBmqWAhxddAFOrQV185Znp14uOYeEWTHZFO6cEaX?=
 =?us-ascii?Q?UmNCmV7/odJJcffoQwKSYS9VZqU/3VS54vKB0wPcVOnrHdfWxPH4UqW8+gB1?=
 =?us-ascii?Q?hzy8bcPo938CJJo3XaifxyCuev5RMkASCEucmsOqDt+Sw5a8Mn91K6dV09PG?=
 =?us-ascii?Q?vcB9UAHMKZDtaaoRNGwNML2ShI1LdGc/Z/UkWTEnRSDankCIJTsC4FQkXW1Z?=
 =?us-ascii?Q?QQ2lTEG6jdAl66NKFCO9hQVBghSonC7YYS1q4DWn1ufH64msWFLoLPI993ZE?=
 =?us-ascii?Q?WkZIRemFEFm50v6PgpMjbst/4uX8NPWhmUX6xTi4wVUWi+TdStxKTpOedcv1?=
 =?us-ascii?Q?Z0+dmaukjcej8kRcvpVCEilgMnOpm5pxIjuQpNEKRS3zeTHw0VDFt/gja6x1?=
 =?us-ascii?Q?A+VJvdE+0G1UDoAaY/PiXacXy5u4Y7J7UeeA5JU0gIzok+iz35xMcEdndt8R?=
 =?us-ascii?Q?PnrkW19f8AuYVKIz0YS/jF47DRJNsSyZ0NZHYG4iYee7fz+iC44Ly5iPofo5?=
 =?us-ascii?Q?2SAf6ZwDHkzpu98zl6iHoEnUXNWlFDyczRjCC6dJXAuB61LU/eQ+Wa3de4+J?=
 =?us-ascii?Q?Dm/TbZL3YBhrHBKl66VJPhkSLjVtKO+CbUXJooyN9H/KWOT+go+PuI/O7gXc?=
 =?us-ascii?Q?oDd36EXi+HDNrwJLKtvqFbTvZoLHYJe2o5vlsIZi4/LlydnloxDGEtzJk/xM?=
 =?us-ascii?Q?/E/EgOYjkY1nj2dPHrzCKAmjFFLhk9LbSRG6ouWZ5Drs6kY7Gjrr238oyRLL?=
 =?us-ascii?Q?M2cciVhlhH+wpTyveAEbbm6TfbFKt0RVQQU2StZewL5UDvvM8zX3u5wSVNHS?=
 =?us-ascii?Q?HlmZhGeSRD1CgY2wO6/UlkafAqRkjypmuONoB9pPwmIwIuDj72mFxMBOK1oV?=
 =?us-ascii?Q?72LAc11czbExkVGaBRpq8e08i9imk78keqTBxY2UzJrXsc9p2yF1Xa7/VitW?=
 =?us-ascii?Q?afKXAk5al77svCzKMWpsDljrw81KLmO7r919cwSC42OZTBh/a4Kb7evqq3th?=
 =?us-ascii?Q?sUtT/PLXE50Jv6+snewJJuv8PqroJR6qifqUyIES+YsxJ1FBJjUUQi9wNjPM?=
 =?us-ascii?Q?OASpmA8vvWq020HzevstbgDAtMJsATe7h+r23jzrk/u8fctkY2tGmTy5fSY9?=
 =?us-ascii?Q?PahnFeB9TmPukbkm2Vyn00fZyIynoiyT0OjtRGLvu/mWHpbVukKGxG/PU1lw?=
 =?us-ascii?Q?3dauRu1K8rMbz7gU5sdFG7abXrPJaNgC+3lvokrnuiI455DVsrKio0Kqkb3d?=
 =?us-ascii?Q?PLZ1JL52HEb9wlzvA720okTGDmB7IQXbnsVe2PklGLYLYD3+oUuVDD5bA8kr?=
 =?us-ascii?Q?4WrebNc5tI9lfHDzFu19nlmRP4qfU3JYxYXvLQQPRhxkhfBsgWGa1iU0VJ78?=
 =?us-ascii?Q?ynmGwcf/J47Eq+1/AakgDdCTc/29DSS3vwjoy/CbUnJpH+cyK/p1wH7VIWLu?=
 =?us-ascii?Q?1qAAHoZNElavdw4NzFinKEb9bOhZ8Ts0zdHQYLZ3fcjc+3XLrfSZtDJDijnx?=
 =?us-ascii?Q?IZXoqw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gSO7Cr+CG4kWfrMvul8F0GIeuWJKr/sdrx2CuL7plwgbpYGbqVbFJuERVVEH3MXjDuRhgokbXmZl0b6p/jX0x75k30QTrDGKvpotDv1Y3M+dnBJL7E4Qy+S/y2b1xzcrbVENsTlpZ9+teVoYgAAFq4dNKIVMpqaFJIMgqdV0ZE7F0EmmehhNQPQOjarJL4xiayph8xCBcQDoIN3rylkS8n5LYSm0YsDgJrHwLFTtMPps8nFWYsTQ3fm7o7fssd4SQI/UMdE9nKvL1Z1tkS4Xoq5CCXG1x30+6lg+Ds12ds0aEWYCebc5OYDHoCyXTRIBKzvUR1RWgyravFaB3XXOQ1NcjoHrgVblpKTpBVRShdYozQ9gn5KBMbzWI8ki7+J6bBbwdH+LpgHwGWc5ye4bFXR1A43O8ZJ8V7mHhgdDmMb/Zc6hMhnPquie+xdYi6+3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:13:57.5448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86009767-2187-4288-8fc4-08de6336da67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Add some struct member and enum for panel replay

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 3b4f5e990ec5..6f388c910e18 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1638,6 +1638,11 @@ enum dmub_gpint_command {
 	 * DESC: Initiates IPS wake sequence.
 	 */
 	DMUB_GPINT__IPS_DEBUG_WAKE = 137,
+	/**
+	 * DESC: Do panel power off sequence
+	 * ARGS: 1 - Power off
+	 */
+	DMUB_GPINT__PANEL_POWER_OFF_SEQ = 138,
 };
 
 /**
@@ -4408,6 +4413,7 @@ enum dmub_cmd_panel_replay_type {
 enum dmub_cmd_panel_replay_state_update_subtype {
 	PR_STATE_UPDATE_COASTING_VTOTAL = 0x1,
 	PR_STATE_UPDATE_SYNC_MODE = 0x2,
+	PR_STATE_UPDATE_RUNTIME_FLAGS = 0x3,
 };
 
 enum dmub_cmd_panel_replay_general_subtype {
@@ -6701,6 +6707,13 @@ struct dmub_rb_cmd_pr_copy_settings {
 	struct dmub_cmd_pr_copy_settings_data data;
 };
 
+union dmub_pr_runtime_flags {
+	struct {
+		uint32_t disable_abm_optimization : 1; // Disable ABM optimization for PR
+	} bitfields;
+	uint32_t u32All;
+};
+
 struct dmub_cmd_pr_update_state_data {
 	/**
 	 * Panel Instance.
@@ -6719,6 +6732,8 @@ struct dmub_cmd_pr_update_state_data {
 	 */
 	uint32_t coasting_vtotal;
 	uint32_t sync_mode;
+
+	union dmub_pr_runtime_flags pr_runtime_flags;
 };
 
 struct dmub_cmd_pr_general_cmd_data {
-- 
2.43.0

