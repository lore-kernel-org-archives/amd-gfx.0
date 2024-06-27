Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61329C2BD09
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8E6210EB68;
	Thu, 27 Jun 2024 21:14:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q0AADI5Q";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4375110EB64
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:14:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgLXHMo0wKxKV9nWNkuTwOGtP2BxDafB756cioMsFAtsXDVjvd3sudfK0Hx6XGc7gOQTqIUNLn2rbIyR7xZElqhtAyKa0CAbRb46MiRW5DDY1R58Vy0+B1w1vS/2MPfngeR51jU9SqddiSmggjoO47HcRCCoNrXz8/thF/tjhnRvZOymJUP7qL7TX20JwrQ64rXYurPoZ/G5eYmpoCD02c6Bwy1gyI+obJOHRZoQwhkBTx2EoRXkb52EUBdsSGOwfxDzBPPiM2J7gX8AHJRhTNIUWTyUiCcpMx4MSsowukcJ9lK6ZlCNhz6NJB2u9uQJ05zKrDWz/YaaDixkfUqHDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8H+oCf8SU+f4LUBhQRTcY41b4fmqpwohq96cz/HPzDs=;
 b=hA5xuc1ynSmfbshe5FoMFz9hEqCKTfwe70xpWdv1YBJeaJAVBUshrdLFJcaOOmiXOliuibAnU/w2ZNuxjy7lxOABIW9D5/Bb0Ta0zU00rELF6kvbdAS3c9CRMJPYrQzXLnK86NXhC+RGjzuMcbopx/2gcjFqFWx2aRQryoUiqoQVz9btZnpSzJknSNLIpCFkAlLHUaN7R/R685AHBgvIlsm2HnbEKDkkpJI6wh25g0tGjtTOjNingrooP1AZ5d4g2iNfYnQC171yBrQAtcUNOi3l52FxnkSWjKMrirfxSSo6RKn4tMIintLuLQoXBj3jQZ0awaJTjZjMtxk2SyFnIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8H+oCf8SU+f4LUBhQRTcY41b4fmqpwohq96cz/HPzDs=;
 b=q0AADI5QAa7q9wK4QjguLC//ZwfJ0ceW74bPjJh5f7ITmnkQaOCybzZVnSf+UD+/pq42THuYQoXZuRLv+3Po9D6cazLWhPuUHCOLdYaFtJ4Nnm2d0Q2MoDUL9EnbcaImgz/NY2eHj8+LdDPdo3c9Jolyh+IWTLSBY/1TUbq/avI=
Received: from PH8PR05CA0002.namprd05.prod.outlook.com (2603:10b6:510:2cc::20)
 by CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Thu, 27 Jun
 2024 21:14:42 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::5c) by PH8PR05CA0002.outlook.office365.com
 (2603:10b6:510:2cc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.24 via Frontend
 Transport; Thu, 27 Jun 2024 21:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:14:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:39 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:14:38 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 18/26] drm/amd/display: Fix dmub timeout after fams2 enabled
Date: Thu, 27 Jun 2024 17:13:21 -0400
Message-ID: <20240627211329.26386-19-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|CH3PR12MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: 46fc4db4-ef4c-49dc-48fc-08dc96ee2932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?72lPtQ8K3QOExsbO1SW1P6jhJgvs23XUWtCtRRz2HwVbKCgDl3fk0Emse01g?=
 =?us-ascii?Q?2NDqRquXiC9o7HmJiVrER3X+O0uK4/STrC7wHaiSLtb+tUG9+M3FavrZkuCQ?=
 =?us-ascii?Q?fIL7wQzkZNrTDn+v9EzyTull5C+FD8PDtuYZNkncemMb7DsCO8Cz1OU2so67?=
 =?us-ascii?Q?Q7ByN5gx6GOTaCm638MfhDhq0TLRKHmitFj50p96nF7G6AJXtZ3uIcRsrNCR?=
 =?us-ascii?Q?ZJkW76HkG03SB1/ljpamsehb4DmbTp04soqs43CQXP6NFrZS5qOsZORIiffX?=
 =?us-ascii?Q?F5NAanLks0oEGkvuNI26DVkAA6YzHJzxqqz31GDTpi6+NoM9tPb+CrLjKEB5?=
 =?us-ascii?Q?VBWfYEaeH4ULSpnDl1kkTdFXF5J3gJAOFo67KIn0Gw0XmxD8BLDY2xnY5wlg?=
 =?us-ascii?Q?kv6IqM/PILkaSMzjcwmJ9h4Ob6H3kuCOEoQX8H/MYsFUHEu1wY7QqIIAZ1ND?=
 =?us-ascii?Q?69rnmaBfykcZn82AGUtTxN8THnz5m0P3R/qFtFnfl/oswNv9kRpTiNVhvpH/?=
 =?us-ascii?Q?QDlny617A6vP5Sx3op4nqVEk1AacAXSbHLq7bACFzlPSkBw2YDIKzcHfb4GQ?=
 =?us-ascii?Q?LAzMlYp7vaTw80IofMh42PFoNbB+ISjfztQwFkZxbkKqQLgbIZZV7EpUERrw?=
 =?us-ascii?Q?cnPFgTfjm8pBWtDZ1ej9uF4aSK3sNsVWW9Wt+D6PQQ+lN5lEHXFPEEGqe4hl?=
 =?us-ascii?Q?k3Q+ldG4fHNcLP+nor0AhGA2xx3q4n9x/qsgsDvumC2TD2i1OHK0Rv18iaQl?=
 =?us-ascii?Q?tclZJjkmVAN0p2KYjNBCxBvRomUraHlyFgLAlOwidXAd3imOttktTWkTtFlv?=
 =?us-ascii?Q?USiQq71uUK8IvuXRVRo1Qjyk51lHUDsBUd/pvd/RWzld0tTchBWGfMckmtbK?=
 =?us-ascii?Q?dnLye4WUP8Od3YPxVpQ8P63j+krKAAIObrJ50wwWEMoUuq8oEUsN3MrVWJVX?=
 =?us-ascii?Q?ZN5AsrtGXK5bs7WPFPFZnKOtbrnkHidF9yP//EDbcSV+mEJ/Zb3Kh3qQIWuJ?=
 =?us-ascii?Q?/L/C0lfQndOuYZ2FLLZjoVAX4ToCDQ8qH/nTyrV2nz+QAMpayMR3c6A4zpEo?=
 =?us-ascii?Q?D2TZi+ttIxK+pY2+wsYZk/awusr9azDM30TtwoTRTNiDcIzir46q0EEmKv0e?=
 =?us-ascii?Q?bFXF6HCQyIwUVaUOBXY0+G3pT+wZURXb0cnQCps0tKbyS2dFIHUXL+IWt0/2?=
 =?us-ascii?Q?rCnc5BrkJ1UJ7dFCNvQO8JqJIbXHHFn61YY0NKCr2x9uwcwHRCz0Dwwj1QiB?=
 =?us-ascii?Q?mrUJzmlvCQFURuN6QvpvxXOv5Wpp4TcHaWCwbZynIUAv9Y6mgAS+9cSKDdeo?=
 =?us-ascii?Q?wNRSJzdCq8uhN01Oq6M2Cp5iIreEVTTVqOrx+0ChMLtSc3CeVea0r8sGP53A?=
 =?us-ascii?Q?ZP7Af++4PZVV5ZB46bSMECHmwxp/cqHcnHZxJcD9r/6JPzr6aTsy+o+Qy975?=
 =?us-ascii?Q?WOd66fz0EUNgyBIEj4VmpetiJx/lC23s?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:14:41.5124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fc4db4-ef4c-49dc-48fc-08dc96ee2932
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8460
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

From: Fangzhi Zuo <jerry.zuo@amd.com>

Reset fams stream count upon stream removal, otherwise
fams2 state machine in dmub will get corrupted.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index c310354cd5fc..9edcacdde6b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -197,8 +197,13 @@ static bool dml21_mode_check_and_programming(const struct dc *in_dc, struct dc_s
 	memset(&dml_ctx->v21.dml_to_dc_pipe_mapping, 0, sizeof(struct dml2_dml_to_dc_pipe_mapping));
 	memset(&dml_ctx->v21.mode_programming.dml2_instance->scratch.build_mode_programming_locals.mode_programming_params, 0, sizeof(struct dml2_core_mode_programming_in_out));
 
-	if (!context || context->stream_count == 0)
+	if (!context)
+		return true;
+
+	if (context->stream_count == 0) {
+		dml21_build_fams2_programming(in_dc, context, dml_ctx);
 		return true;
+	}
 
 	/* scrub phantom's from current dc_state */
 	dml_ctx->config.svp_pstate.callbacks.remove_phantom_streams_and_planes(in_dc, context);
-- 
2.34.1

