Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60618CEE349
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 19:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E4FC10E7E7;
	Wed,  9 Oct 2024 19:26:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="to1btMVa";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D56010E7DE
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 19:26:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBfw5GafQA3pKN64/+iXZb80t2CYbtuyrluZcSx/nxbsdJQX9OXe+qRMJyY1y0lLo4ib8fGd+nQjm+bikXts69qdOCyDHlErwFAbSbd98QO3vr43E8TlG59V2ygCOWK0oNotKBhx6i5D768xosTwlCR9qVgL2Oxd3ywbUAZ7Y0JEk8fKsOjM3wZBLVVNHCamuwsKsN8j/QGIdUJA/2+CSPjgmb0qDzxxwyENt4KOb/bxj9+/1peGlz66UVmIl3dD0mJhNBpDiQ3BtJfg6n3KQreT74+J5YPBe79gaHPJxNOHtS0z+BMlo/lCTFPnnEPCCsjpxwD9Jn3KFbQKBp+FyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nF6j2KGo4LqHuWDT/18Qzc7SqLe7nyd5KWSR/K8Pei4=;
 b=jKciSf9Gxvlzs31Kcz/doCj3NSNcLN3kmjJ67KpioOUIZHhrZJm9euxQuSkg6uGGynP9796p8Qi5z7OSg5AL0yfMpOWApOEtvU8JIbqgAFXZeKgObz3W8kQQv/EklthhXMQ2pIBmK+83eTJiazjbCSGy1hBo/YZB4eIUClPAfdK4jeTPsje37UAswRJ13y0qrVHPCJWVSBve32xrTkjJCrNH4K57eFZLLIdS9VLUoOGXanwlHFe2A/w3FB6KQ4xDi1hoU1QQhO20CEON9N6zm9jkIcRPa7rnE734UC2iPNeQgH91q66soJY1nLfip3MRsjNG1HAXFjpMUFYyCef8sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nF6j2KGo4LqHuWDT/18Qzc7SqLe7nyd5KWSR/K8Pei4=;
 b=to1btMVapY1UjXfEDtfDacy5QzL59HzVsfdrQIaZsbNx9kEOe4+RZA225TRM0dJxRj9One4DXzCE/WzxxLwggTY15MzSmJ/I7XRsO8VP85ztGzespZCsc/HurJCdzqhrYdNFL+AcjwIDDFYBSLmtjSLeJjJFWNEZUirrN41x+xE=
Received: from BN0PR04CA0067.namprd04.prod.outlook.com (2603:10b6:408:ea::12)
 by DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 19:26:04 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::fe) by BN0PR04CA0067.outlook.office365.com
 (2603:10b6:408:ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 19:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 19:26:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:26:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:26:02 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 14:26:02 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Leo Chen <leo.chen@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 08/16] drm/amd/display: Full exit out of IPS2 when all allow
 signals have been cleared
Date: Wed, 9 Oct 2024 15:23:36 -0400
Message-ID: <20241009192344.650118-9-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009192344.650118-1-Roman.Li@amd.com>
References: <20241009192344.650118-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|DS7PR12MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: b39eafad-cb32-4e9c-f913-08dce8983717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dKKKeTLTcIJFl05RKdAm04f/ffVX5Gfuy9Mr8jqiNN18TprMhDu56mccs8vD?=
 =?us-ascii?Q?VlGER5WMEnbYxru0ng6KY/IRaKfXQiSa5V3qYhvuOJKsJHFKPIZarQzV+jmq?=
 =?us-ascii?Q?3YPb3huzxRD/wqYAJTnwXJavnudfKvUcFZNsi0Dg/7J17WbAeqH7SJLduyK7?=
 =?us-ascii?Q?+W6btSYDpZUb8neFu5WAKXwOUe9Jnb8gD6+iqje3tfvN+kO5I8qv3O13CYU4?=
 =?us-ascii?Q?m7s8WBK+GlKbeybE219pIxxa4P7zX311XXVRgONcm4g/3RmJW4+ZfsfQ7Y2T?=
 =?us-ascii?Q?AazJWIoa1OaNyNVYdMsTuMnNma3Ay0Y5TGBXosuorPxYD1unDiGL7Iz7gINS?=
 =?us-ascii?Q?S+NXSdveotbqlFyuLq03msdeNMS7Q2llCMnfo+yuN80P5Lld9n730w3SC45T?=
 =?us-ascii?Q?69LQZ+R2GZTtzW6uIwd382tja71p9dWaqUiEkNAuXllEFEEFXYAo8ESraacF?=
 =?us-ascii?Q?Lm+6j2xXAnWIiKfYvrmACMdygw0RESzkNQ7FTittSA0UcMhTsEqEyTR8PqjE?=
 =?us-ascii?Q?MNCFc+ojivwLM6uQy5C0Y5dVqCazoQbzpQMsi2Hbe8N0kFw2M78isrt3TufN?=
 =?us-ascii?Q?pPOigzkmAEVlJnZcJBh+mD7GNx7rEeq4qwlGP3ZxnS2zlJVQys2I5llT7GAV?=
 =?us-ascii?Q?gyqyM2fevkEcRnYV1cWLow+Cr3c7Jc8ADFZsVf9/Jhdh3UQmyzWmgghPtb9T?=
 =?us-ascii?Q?aESwNLcQTdfannXXRMcFs+7U15+ZO9HAfBM3k0+/Yd3DhdqLVc7/AjSCLANW?=
 =?us-ascii?Q?a2CHFFdxx+MDMrAgZ13uPu7zQ7IoGTnhopFloh4HqNPGpY/fC5CGiNcO1ikE?=
 =?us-ascii?Q?HOVgLZayZsrYqkPqUCQmZUaeDtp8k3n3LiejTLfADqbVR/cxnz3q+zkJkBcm?=
 =?us-ascii?Q?Ebt5UZZN38lp+XgsI68l9+X97wIl6OhVADDYCYXMm9M+fkKsrm6eEQNnLxHa?=
 =?us-ascii?Q?8+/DPIUdHr71cCrFntcX25JlI/K3tb3uk+2HAq9B7cTMQdYq9B7hGqC1YBza?=
 =?us-ascii?Q?rdOV/sYoejz+6VRoTVJ6nq6ZjwNfXA6DkMx8utwH8HsGPttH3SpNajlDuksS?=
 =?us-ascii?Q?L+xBeUvCCu2nYGzFs7AChw3tI7Q9GYzb1Ih566jl9x9H1ZfLpZboyWqQqF3s?=
 =?us-ascii?Q?bTMZPRRqaR+L07Fd/Wvsx+FHMMjFkV9u9sTz8TqqccqTAuC9U+Vb5TGY/Ay0?=
 =?us-ascii?Q?XiuQ96LhIcmeD/hUY4S82pjMEAXNt6wCl9xCvIzyxZC+3FyIvE4+PpFGwvz+?=
 =?us-ascii?Q?jSTPzIvtgn3ejhe4L+BsfdXk2laOxxiiTbaaRekOafba0BJk0TvcRmQJvCV8?=
 =?us-ascii?Q?+EdtIoIL69i91lawaE/NoAtqg6qATrU6p0QbNPC8Q/fnzCVTBsr7xJ5in6d6?=
 =?us-ascii?Q?9NLIsRT5xx94hqVUx9LwpVamp8PW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 19:26:03.5977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b39eafad-cb32-4e9c-f913-08dce8983717
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8371
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

From: Leo Chen <leo.chen@amd.com>

[Why]
A race condition occurs between cursor movement and vertical interrupt control
thread from OS, with both threads trying to exit IPS2.
Vertical interrupt control thread clears the prev driver allow signal while not fully
finishing the IPS2 exit process.

[How]
We want to detect all the allow signals have been cleared before we perform the full exit.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c    | 6 ++++--
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 8486c144d81c..f0417ee6fcf8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1295,6 +1295,8 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 
 		memset(&new_signals, 0, sizeof(new_signals));
 
+		new_signals.bits.allow_idle = 1; /* always set */
+
 		if (dc->config.disable_ips == DMUB_IPS_ENABLE ||
 		    dc->config.disable_ips == DMUB_IPS_DISABLE_DYNAMIC) {
 			new_signals.bits.allow_pg = 1;
@@ -1390,7 +1392,7 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 		 */
 		dc_dmub_srv->needs_idle_wake = false;
 
-		if (prev_driver_signals.bits.allow_ips2 &&
+		if ((prev_driver_signals.bits.allow_ips2 || prev_driver_signals.all == 0) &&
 		    (!dc->debug.optimize_ips_handshake ||
 		     ips_fw->signals.bits.ips2_commit || !ips_fw->signals.bits.in_idle)) {
 			DC_LOG_IPS(
@@ -1451,7 +1453,7 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 		}
 
 		dc_dmub_srv_notify_idle(dc, false);
-		if (prev_driver_signals.bits.allow_ips1) {
+		if (prev_driver_signals.bits.allow_ips1 || prev_driver_signals.all == 0) {
 			DC_LOG_IPS(
 				"wait for IPS1 commit clear (ips1_commit=%u ips2_commit=%u)",
 				ips_fw->signals.bits.ips1_commit,
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index f9e82c4f8deb..6edd3d34c7b5 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -752,7 +752,8 @@ union dmub_shared_state_ips_driver_signals {
 		uint32_t allow_ips1 : 1; /**< 1 is IPS1 is allowed */
 		uint32_t allow_ips2 : 1; /**< 1 is IPS1 is allowed */
 		uint32_t allow_z10 : 1; /**< 1 if Z10 is allowed */
-		uint32_t reserved_bits : 28; /**< Reversed bits */
+		uint32_t allow_idle : 1; /**< 1 if driver is allowing idle */
+		uint32_t reserved_bits : 27; /**< Reversed bits */
 	} bits;
 	uint32_t all;
 };
-- 
2.34.1

