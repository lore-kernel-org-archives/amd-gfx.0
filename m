Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B21EC2BA1A
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E23D710EAFA;
	Thu, 20 Jun 2024 16:15:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Dtyg77F";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C06C10EAFA
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggVZUJ4dPNznu3wFBBV7DDnxCmsXYl/qH+21qSaTzmH2IrdOTY5Dh1WIKymr15IRC5jVKDB5YVrXGQWf342TsCCqcDtFnR3lgsf2vmTqs3zr0G9EcsBfGABY2Ui1tSEF2CwhR1LISODW+eQ7jCM8jr0pbvqA7w0aSrKWtCAZdNQTwRgMuciWcnTxszniKILKgFG2jA+IaZKz2jhZOOfJZHlOp/aKUhl1qQu/rcrxbR+G9TYDR2o665EwTOy5ktQ0ZFqHHZCdSw6CXxsYc+8/t3pwWn+o8tpllzVG7CyVGd+NF1HNHSCPn3N0s1XI5jkZOd34vavPReXzRypUFmFdow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vAAsITd1rMykMF5taPjJYXcaGiih/0kx5u/tKgaSsI=;
 b=PVqHcLJpBJCRl8f61QQ/sz0uHiTfnP5oHNxk8+cwtPtuaKxVKpw+AF7rzb12LdUVxnKzMUeC+5Rg6leG0x3+pb7sx55Zz093Bb9+7Wn/ZV7+gCGSNDafg1vMJISnIMYMps4BcoOzBHaLu1R09rIt51ml56CiZBA8M9r1iFW/mAaydDYweJYutZCCzRvcmfgYbX/ZnH1YlRuU6sAm13RsunukrLZWrUAaYmRNjPln6OCyZK5r1z0Ohki4rduDkVd637E49V9ryDOk0yzPb0FL/xoDC+LAY2xjd6YznbYqQ0K7KJ2jtMPWTy4BwKoycqGHLwwuAa9kWuO93bD9eO3YSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vAAsITd1rMykMF5taPjJYXcaGiih/0kx5u/tKgaSsI=;
 b=4Dtyg77FCP3zdcfBcbLgTZRHlxASzPmd7ku/wdZimMmfo137EIS6lon4FAC/ZuiWc7bllxtvp8xb1eRWqjPOlIpF/8u33cAY9tmVVXO+QX+m8HN2nQ3oPeGfYJjg0OYGv6dz5WVtZZ1XvxKDihJMPjYSWe2BhAcUpOuomRSTklU=
Received: from CY8PR19CA0011.namprd19.prod.outlook.com (2603:10b6:930:44::23)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Thu, 20 Jun
 2024 16:15:42 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:44:cafe::63) by CY8PR19CA0011.outlook.office365.com
 (2603:10b6:930:44::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:15:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:15:41 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:15:39 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Joan Lee <joan.lee@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 15/39] drm/amd/display: Add Replay general cmd
Date: Thu, 20 Jun 2024 10:11:21 -0600
Message-ID: <20240620161145.2489774-16-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: f391045f-3bb8-4566-b17a-08dc91443b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|82310400023|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rJWXa3Kp4XeUsJCUuGVbQCVGx8kA9TBlXxDgb/ntsIGGXgoSYCK+CMiyCPpO?=
 =?us-ascii?Q?RJNFiEivNOUpF3me5G2ZYYOqaLOiYNvEWGeAUHtQ73VGxCkA0J9AIaq9yfZ1?=
 =?us-ascii?Q?gA5LVUYGEU8PvnUsagX9PUZqJNQlRC7Gm74rmaRvf1Y84sHmUIFDhUvgNNEa?=
 =?us-ascii?Q?EZJcljwWrfTXdkuWy+0uidHd+4Uf2iQeiRllOWN4o7jVquhCHeoEKq4KWYJ0?=
 =?us-ascii?Q?JPvvuOvCFijIo3MB8enSCRzIAyHBtx4P7NXjjsD4X+EZdznCe8Qczm/CPgo7?=
 =?us-ascii?Q?im6kxLidMEhaR1t2RoabuFcjeTl7XNhkOqD8FGR5u3r6qQOwDgeoj0nnOMH6?=
 =?us-ascii?Q?aujyDcBvh6HK4FzS0Yo6la4LRGCk2dqAy9suDWqCqmDhYsodpsGmoMLInmuH?=
 =?us-ascii?Q?w9lD/42MIjxinrawPzaUBAcG+JREgX6GmjJH3r9Fo828EOwnpg011qob2Qbr?=
 =?us-ascii?Q?g+D0iyQ7k91FHbRHgndrdG/PW+KamSr7qrJ9OXm4mYTNBipRjE5BB8AmzOlW?=
 =?us-ascii?Q?/hbwS6bPwCX0CGyMNRHiLpK1AKz3h1a3iM2dqxEbiEss7P2xBgMBtwqJ0/CP?=
 =?us-ascii?Q?tVMQnDabSOtO8/J0h2XIih2u1oKmnhhLItMqSCufU5IGcCYB3WjsONOfmCgx?=
 =?us-ascii?Q?ZyWJInXv55mz83msY9CVe6Ejb5UAsiRZ1C2X4WvpNlUJ7e1q8mo0VVYgESdq?=
 =?us-ascii?Q?T/s0Hzb7f+5vJ/KZgltNcqlXggyX3Ll/K0qJm2KlFi1rz0F0MzZuu5U3VYz2?=
 =?us-ascii?Q?XsUNAz+ZaxDCUKQhUo0OxrLepA1s1HACKTqLdovKywtuoGU1NsucEWO9Gelo?=
 =?us-ascii?Q?F49Odmr8r8rf3ez0sEfeRDkQvDxGdSA5MuIvz6brfpdM+gZFf9cQSmMi/D3+?=
 =?us-ascii?Q?kn98acU3oqH6w3+LhjApEJ9SgLXX3of15DD6FF3Mw3FlRaXCN/L1/CNwdQNO?=
 =?us-ascii?Q?5J7oAIQ6TA7Px/gg56vZClb5fPKI65hDsciTseQhzUhSECS5oS80VkiGGJhA?=
 =?us-ascii?Q?YYhGhaerTJhhIqK1K5Y4ke2csUCjYqKUteBKUaKrcw50ToIKw7tb9I2IGETK?=
 =?us-ascii?Q?HCEog3NAGXQasDGEoPFHEFHbdeRX8C0q5WW9qCpnixovnYp++a5cl5w2NLSh?=
 =?us-ascii?Q?/Q/zYjPoW4JitTdsLvDWdzX5RG6ObZP/JWzKGL+9AXWYh+lvDuRt3m56F5tX?=
 =?us-ascii?Q?RMcK6LZ3wiJgI6J20HNexOEDf7VhmOAlI6JSFIPHFwbHUVnyD8cIqx2aU0xh?=
 =?us-ascii?Q?9w+G1FcjbLsGEUN1eef9869M1DsXGUWOHDhM7oZXoRIV1q2OCqXVIlcvZLUm?=
 =?us-ascii?Q?Ccx0B9TXL/bkBjWGrGitT0+5XSHGr5raZBVeIqfMUdkSS61NPlmjv/Ih79wp?=
 =?us-ascii?Q?r393KWj0NrbCvxw9C+Eh3jlr4Zzb48huvHMOB3LCG76AeLDf3Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:15:41.8095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f391045f-3bb8-4566-b17a-08dc91443b5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487
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

From: Joan Lee <joan.lee@amd.com>

[WHY & HOW]
Driver side adding replay general cmd interface.
Replay general command will config at most two uint_32 parameters,
with a replay general command subtype to set relative configurations.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Joan Lee <joan.lee@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h      |  1 +
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c   | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 21f4af9ab096..c550e8997033 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1036,6 +1036,7 @@ enum replay_FW_Message_type {
 	Replay_Set_Residency_Frameupdate_Timer,
 	Replay_Set_Pseudo_VTotal,
 	Replay_Disabled_Adaptive_Sync_SDP,
+	Replay_Set_General_Cmd,
 };
 
 union replay_error_status {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index 5437ebd8bc21..2a21bcf5224f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -346,13 +346,29 @@ static void dmub_replay_send_cmd(struct dmub_replay *dmub,
 		cmd.replay_disabled_adaptive_sync_sdp.header.sub_type =
 			DMUB_CMD__REPLAY_DISABLED_ADAPTIVE_SYNC_SDP;
 		cmd.replay_disabled_adaptive_sync_sdp.header.payload_bytes =
-			sizeof(struct dmub_rb_cmd_replay_set_pseudo_vtotal);
+			sizeof(struct dmub_rb_cmd_replay_disabled_adaptive_sync_sdp);
 		//Cmd Body
 		cmd.replay_disabled_adaptive_sync_sdp.data.panel_inst =
 			cmd_element->disabled_adaptive_sync_sdp_data.panel_inst;
 		cmd.replay_disabled_adaptive_sync_sdp.data.force_disabled =
 			cmd_element->disabled_adaptive_sync_sdp_data.force_disabled;
 		break;
+	case Replay_Set_General_Cmd:
+		//Header
+		cmd.replay_set_general_cmd.header.sub_type =
+			DMUB_CMD__REPLAY_SET_GENERAL_CMD;
+		cmd.replay_set_general_cmd.header.payload_bytes =
+			sizeof(struct dmub_rb_cmd_replay_set_general_cmd);
+		//Cmd Body
+		cmd.replay_set_general_cmd.data.panel_inst =
+			cmd_element->set_general_cmd_data.panel_inst;
+		cmd.replay_set_general_cmd.data.subtype =
+			cmd_element->set_general_cmd_data.subtype;
+		cmd.replay_set_general_cmd.data.param1 =
+			cmd_element->set_general_cmd_data.param1;
+		cmd.replay_set_general_cmd.data.param2 =
+			cmd_element->set_general_cmd_data.param2;
+		break;
 	case Replay_Msg_Not_Support:
 	default:
 		return;
-- 
2.34.1

