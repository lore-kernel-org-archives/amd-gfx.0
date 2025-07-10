Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDCAC83F17
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jul 2025 21:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C325110E96E;
	Thu, 10 Jul 2025 21:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QIAG7qz9";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA0D10E96E
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 21:31:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLItUacZ3HIlDl1CDwIVxPuAaZkWvstPcETq/9akAXfEQHFIkmYK4gutYfJU5iy3HFmWs6r8VCSHU+hn/rOtnS3WoHmQxM6QlwtS53ZpDfo5mDfWMR5ezB0Et79Oef3KGMn8emKe0jQLd5GVoY6nJi1IrV7OlJ+d/3bBxdZ4r1HTV4a9S8lcliJzOQZAopWM60whAEfMJjFcSieqkGKp5aokmT7NikJyVcAsPss5N0GEIHczS0RQyPjnpLmYtRV3UMbUW563nqWKNrp/a9yTiYpp2BRZnzwK5cSVz0Z/8afHrVkJ3shd4n66pilZF1prcTn3M2PbjVIR2baEDHsiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4cCvLKIbithYNorqvNaZWvVRc8U0Z9SPyUIhIFbal0=;
 b=VhPY3yeheoh+wF/aRbAZ8Xo7pH6jhWzr8fajEUcg2HWOREaG0s7SUO5eKIcyCHpnj+lAGMhR6Ly1VbLSKFTOXzy5w0PfcATIw+4eJMjCABjU89g57GvLGEt30Ecb5mG7noGbUp9g49VlH/Wh86sq7+vKoNdv5ebEQop5Wyr/eYUZ71czQeWX+0Ilh8ZJy3/JBCAMed6LPfSKBoN6ZT+5S7a3O3lVgzDtQMQ/YLByxUG2kD0wlkMCmdDD0ycFf8dIqcDUQsaWqWuY6XKTMEIk2xlPlhcnGatXlFislanq+2sBHoJk0/Q8gZZjuYFVq3lLHzu4by9D3UdbJ/UkL4gusw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4cCvLKIbithYNorqvNaZWvVRc8U0Z9SPyUIhIFbal0=;
 b=QIAG7qz97Zr3vqEB3Lo44hW6OQCD8zhtdJFtK9tU6+oA7GoZ0EUbCfbfkchsGFn5DeKwhIZ6ZSyTpQYvO0yZjI3p3sZHUARMh+t+sKqmG1sSdCmGNtfvCdGvOOSHIktd9qvAOu646/csCFHjLiBjlFQSmM3mQPN/nEHc7VTM6u0=
Received: from CH0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:610:b0::16)
 by CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Thu, 10 Jul
 2025 21:31:18 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::bf) by CH0PR03CA0011.outlook.office365.com
 (2603:10b6:610:b0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 21:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 21:31:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:31:05 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 16:31:04 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Leo Chen <leo.chen@amd.com>, 
 Duncan Ma <duncan.ma@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 11/18] drm/amd/display: New Behavior for debug option
 disable_ips_in_vpb
Date: Thu, 10 Jul 2025 17:25:44 -0400
Message-ID: <20250710212941.630259-12-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
References: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: bb8043b3-be98-4c73-cef2-08ddbff91b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nDRoJJhuTYhDp8k5UL3S6qsLRLfs2afh1Q62R5Kd65SgvmYGgxH8c7yRpBQ6?=
 =?us-ascii?Q?QD+UphMRMFVdrAjaFO8BSOi0jDQH2PnZ4q/U4vp5hO+n+Z2lIuB3BpjrtFGP?=
 =?us-ascii?Q?3M+WRh6LCB1H1m+OPW3AdWBfyYgyIw6DhSfVQYllzyBWrfIRAfSDMDZYVPiJ?=
 =?us-ascii?Q?vuE3Ch/546P95XRB42v2dPwbfeHR2FJ1fgnl4MIS+ej4/HbmVh9K8tn0rUp6?=
 =?us-ascii?Q?wB0/fM2Wmp9mxILQNtLVjony55mgV+akoWTmsYak1TOugJuyaIhPr4hR0UpC?=
 =?us-ascii?Q?OdEsvy7HzUtciwRd+7m1WSllmBG+f8mQnn5W+hLfJVpYR4LlHz6yhN7JmGMc?=
 =?us-ascii?Q?x/6VqkDApdZSmIJv2R/AuUNwzra3B06rByO9gwpmbjAKWXYhO7z0H9X+WflV?=
 =?us-ascii?Q?QoHO0rRoC0K0byMBvejr1giSV++NSlgQdCYLLq/3r6ekNwXBud1bOV0uTnj4?=
 =?us-ascii?Q?mFl6q7i8nklolaU0nXIoIJaakmTrcyVojSmnldQKl0bJmq3TD4/tE6jOGzPo?=
 =?us-ascii?Q?fxCOleQJvy3XJRR/DDORLLuSXtE3bWzOS08NzJvNNtxYona4RV3t2vfp1JtE?=
 =?us-ascii?Q?SO+YX+AZFO0zS6sysq5aiWEztofGJssgMNm37ca8pTZQiT+cB1Os3upVN9a9?=
 =?us-ascii?Q?PKm1ijC1TE/sMj5+VSwDsx/l6r11DtAvB1OnpEDglKxyy+4Mih30IeXTbyfZ?=
 =?us-ascii?Q?f1aSYghmg8/aPgii/NUSYIJIWxquoQUDtRiT+Hcp6hgBZW+fpNO3TVT1ul47?=
 =?us-ascii?Q?XmkZoGxbQCaVgs0PvGg7Cn5Ga1Dw4nJLxFg2n9uECEi/K0krovV+rqsmCF7E?=
 =?us-ascii?Q?2u8AoJZDvR55uzxAhI48W/3yyrF02RFlAzyJzNLSv+QPrEy8D3BSwS7Q8NQ7?=
 =?us-ascii?Q?77jnHAGVOzRmnyYOko2EAme0JFyWpoI/WDZRzCf71IsynBPD8TESS79Aw2ZR?=
 =?us-ascii?Q?0D/b1kztR3v8TVK3RfU804n0F3IlE0Pl6+P6ChcCEfGOGFUGpPmAfvjktzmH?=
 =?us-ascii?Q?Vz+A+CxThZdYLn9X9vavy6BiXQQd9GkdGvh5a+RrTzGrXaJDwZmPZSowmg9I?=
 =?us-ascii?Q?bp+HLIRiAFXuI/yrmNmkLmjQ0Zm2NhD472+N9fUslUV8s/aTF0rxECHSel+m?=
 =?us-ascii?Q?fSYzenWi55g2cZRm5SPYePeijFYID2aPjeHUTLNHmC2uz17RUOd4DLB3NUm1?=
 =?us-ascii?Q?4dS00V1SPNhIcg4xfNP6qY5DzmSOu4621goYYTp/Ujci+fH8D33gcURCC46+?=
 =?us-ascii?Q?9BZU/DdQ8nOxMYng/XX99cJ/fV3o4RnHLciDX8xXZxmmJAHV7srTgE8GuoJT?=
 =?us-ascii?Q?ldHiALZImiRJvD5WMN4tRH0OEVzFralnRbxaWaBKs8Vgpd+9mHZn/8KPn50L?=
 =?us-ascii?Q?SdNyOyisketum7xPZRKQHfxZbK5Ex7s19rllFJeGSKoE4Pr4DBP6Z2bnKF4B?=
 =?us-ascii?Q?+LasmLoFs0x5Q/lNuTsJdpvJCSYgUyWxxJPqmlVL8bSI76L6bEYbPx1i4mlF?=
 =?us-ascii?Q?5obh/lmc6wqNNmCV9LW3uq90nwTqQ8hGaglk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 21:31:17.9163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8043b3-be98-4c73-cef2-08ddbff91b25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227
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

[Why & How]
To facilitate debugging, the following behaviors are defined for existing
debug option disable_ips_in_vpb

0 - Enable IPS in LVP - let driver decide (legacy)
1 - Disable IPS in LVP
2 - Enable IPS1 and RCG in LVP
3 - Enable IPS1 Z8, IPS1 and RCG in LVP

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Signed-off-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c    | 7 +++++++
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index b4525b1fc11b..f5ef1a07078e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1314,6 +1314,13 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 		} else if (dc->config.disable_ips_rcg == DMUB_IPS1_RCG_DISABLE) {
 			new_signals.bits.allow_ips0_rcg = 1;
 		}
+		// IPS dynamic allow bits (IPSv2 change, vpb use case)
+		if (dc->config.disable_ips_in_vpb == DMUB_IPS_VPB_ENABLE_IPS1_AND_RCG) {
+			new_signals.bits.allow_dynamic_ips1 = 1;
+		} else if (dc->config.disable_ips_in_vpb == DMUB_IPS_VPB_ENABLE_ALL) {
+			new_signals.bits.allow_dynamic_ips1 = 1;
+			new_signals.bits.allow_dynamic_ips1_z8 = 1;
+		}
 		ips_driver->signals = new_signals;
 		dc_dmub_srv->driver_signals = ips_driver->signals;
 	}
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 938a07cdcfec..fed2d3999305 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -790,6 +790,13 @@ enum dmub_ips_rcg_disable_type {
 	DMUB_IPS_RCG_DISABLE = 3
 };
 
+enum dmub_ips_in_vpb_disable_type {
+	DMUB_IPS_VPB_RCG_ONLY = 0, // Legacy behaviour
+	DMUB_IPS_VPB_DISABLE_ALL = 1,
+	DMUB_IPS_VPB_ENABLE_IPS1_AND_RCG = 2,
+	DMUB_IPS_VPB_ENABLE_ALL = 3 // Enable IPS1 Z8, IPS1 and RCG
+};
+
 #define DMUB_IPS1_ALLOW_MASK 0x00000001
 #define DMUB_IPS2_ALLOW_MASK 0x00000002
 #define DMUB_IPS1_COMMIT_MASK 0x00000004
-- 
2.43.0

