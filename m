Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA415C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 687DC1130D8;
	Wed,  1 May 2024 07:21:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yWxNeb7j";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B91F31130D7
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:21:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbWR1cI9fN5G/v8h3yABj22uqd9UwxldCLGDWLnJCKfni1k8kGP+J7heoWZf0XanB1MPxixOHNnlpuADXw7o9qjVRz3Alk9FsS1yjNfHMpaLyz5eqU/j7kYgttIjUsp2R2J1vn92/E+8jvP36I8L2UktQk4IEqs826aegn1TF4noffatZak0b4wxsrkMOurrCoCaPol6jGJNh+3lAMBQNlbxQgEqhHceicmcUBIvmB41AjiMBw8ulEm0gOUcN+T76Cpf1wA/nMtUPxEov6oAamNlALWQX8txgHpGANOh37aKhUtyst6ARD0Cg/H6+zWkvX/oU0ht8wVxr34Glj8HKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5X0AsDtfL+RbsJ0raPw4IZrOMTrAISl2WJ/w26ae9uM=;
 b=V7amerDt2igw4T75786HluN8WJ0KHBuZZH6xOfTV9jcixBuT+IKk149WGM++wH+4VVjjvyPXDBU5vyOzhOfJf17aOegT5+TsPs77OTywqD3bTHZ8nbYBiR+35JX1/QSiP5QkeUckyNOU6Po/iNU1HleAIZ6EY56CwaSkz1GxaFKO5SYLt3RMwwaw31HVsJMzuwT51wEUgG5G301WGmKSyd/HxJQHUyfEyLc8KaBW4eAUGBuGFB4HSPFyX6afJEQpl6FoYxR7eD3WqJsYgmZpbQIiAqqYeuf/dDU02NNxvZ1b/wkklh5E97VoVGeKh5jbEHwRXP9e/BAkFRj4o1/EOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5X0AsDtfL+RbsJ0raPw4IZrOMTrAISl2WJ/w26ae9uM=;
 b=yWxNeb7jR3wPpIh7Lalr6B2rUtWX2FaxSkvqNHOfd128PiYatp1QKIr+vtY+t7URPQ362UlVrbS1euxXiMZLVmu+4ZTgBtbeiu2OFTzdKbHeUmi0W0mjGY/B4Bz2LXmNuQDfRgM52EU1Cz28dYkE+NOcra8mfh+IXfAdjGvTu80=
Received: from SA9PR13CA0135.namprd13.prod.outlook.com (2603:10b6:806:27::20)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 07:21:11 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:27:cafe::e1) by SA9PR13CA0135.outlook.office365.com
 (2603:10b6:806:27::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28 via Frontend
 Transport; Wed, 1 May 2024 07:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:21:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:21:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:21:10 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:21:02 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 40/45] drm/amd/display: Limit array index according to
 architecture
Date: Wed, 1 May 2024 15:16:46 +0800
Message-ID: <20240501071651.3541919-41-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 155c5392-b466-4685-c6fd-08dc69af473d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lH5OHT9QOOSf0RZS5AooGOj9uY/h2Q9D+it7ODrsaSS3plwnGOuR5krO1Nrj?=
 =?us-ascii?Q?WHKpq72CR5EgJ/UO068xXkwdGR6z+5D/M+yWWJhpnL0L522Jn6D4CcdAlyrg?=
 =?us-ascii?Q?l7qYsdt7Pm2s6+RrAMd86FZ2o1TMStCv0N+osPz2RR9R7gg17VqNNJjWMYO1?=
 =?us-ascii?Q?DIq4khbX2i7uWKs/RovWFLJ0H5TD+nPf2kRzMFAq0pb3x8+l5CiD19ogfJdB?=
 =?us-ascii?Q?0Gxpep+D4FG0WVnQHkG5UlH/SFcGzIOxkI8Oc/1ZcryOL3m54MxMO5Q7xScP?=
 =?us-ascii?Q?YJ/hMiWaIP43eLPaC7+dzwuzAXD+Wszp7e1GgZw54IgyDqtil21LJEBl/9ux?=
 =?us-ascii?Q?wyFWDEEthF+83zULdNPNHLpgdJkQbAoIa5/VqGezK6clb8rSU/owVNRKIbXl?=
 =?us-ascii?Q?yBOKOYrPxl18noKDIouIFe0Dv7D56gD67yTEL+JufdFOGZgBaQs47IKT5VC9?=
 =?us-ascii?Q?zv9GnkLKxEP45m7PTb8mzX7Qm3VcZ3n/EOpN2VICqmdjdIhuT7mYdr9P9R42?=
 =?us-ascii?Q?K8ELWHde055qw1KvNXvGKUfeRci5gW8pLn+AF2VphfR148I5hTRJ1hVvQacI?=
 =?us-ascii?Q?/36rylFjXMZyYK6186ba9O9SGikUTSaKgov0DobBhJyQZaG9ZdBFhsuZ9SdC?=
 =?us-ascii?Q?Pv04c0fYxt7nq0VDFxgQX0zL5aYI7IuzznRENp8noD//I8lKBw0i3BNvSp/Z?=
 =?us-ascii?Q?3D2FJaEPjP1JaqU/P+UrotMFd8HzD/UBMcht2MbhCATZRBKCyijYd5fGNZAF?=
 =?us-ascii?Q?D2NFKFXVR8bwYLZ2lpsAqY2kdHjyYciUiPArZW53J8vlXLtHN0jr5Ru/WLvl?=
 =?us-ascii?Q?zZqizYzNobR7gsw96/Il8hLTj3zT1snbmlz/ZxcnD+5kHO5GE3Iz7r69kMNi?=
 =?us-ascii?Q?gVxjRR1vO1Ku/zXHV6JWqqm2C0x/DkZ7F4YlhWz3RaCWaZOQkKGwz5NB+0g6?=
 =?us-ascii?Q?VuJk1ki2xqL7RIbbUbvmXJrV2f/LcrXVVZ0RBySCElELbvqQsHULb8I5+jqp?=
 =?us-ascii?Q?pMf8guyZ1jdnWPJeohzNzV9ecPEVhrK0Ucz7Y9klaydwdiM07vhC+RhgA6UH?=
 =?us-ascii?Q?hp6x85ptpmLD0cB1V7U9hOlfFeFge/U0vpwiUHlK89aKvizvGMa2s1E0939J?=
 =?us-ascii?Q?0LDP3NA9AuIWrR4Gf7HiMX3gzMb1F4XZ7QEx1GhnKymCYz9oUysDTenuvTIy?=
 =?us-ascii?Q?gR+t1sosM6CsUlas5pkYaaaJLedpUrVFttnBQ5NsarnEptuhJizIKW177qZs?=
 =?us-ascii?Q?+DbqNSqTpBxUssQia6/Wb4UPvKq1bhP4pfEJh3SNxV4MZ0YKLB8elwF4XQBj?=
 =?us-ascii?Q?CGJVUJ9Owkx2j7igd2nEz7baJ355nCdy9AZ4r22XJQZb90RyE+o0XZAmW5yn?=
 =?us-ascii?Q?VrUCYCBf4hms1DI22gbD+xeNRK+E?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:21:11.4567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 155c5392-b466-4685-c6fd-08dc69af473d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259
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

From: Alex Hung <alex.hung@amd.com>

[WHY & HOW]
ctx->architecture determine array sizes of ODMMode and DPPPerSurface
arrays to __DML2_WRAPPER_MAX_STREAMS_PLANES__ or __DML_NUM_PLANES__,
and these array index should be checked before used

This fixes 2 OVERRUN issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index 507cff525f97..49e2cc65a43b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -1031,6 +1031,7 @@ bool dml2_map_dc_pipes(struct dml2_context *ctx, struct dc_state *state, const s
 
 	unsigned int stream_disp_cfg_index;
 	unsigned int plane_disp_cfg_index;
+	unsigned int disp_cfg_index_max;
 
 	unsigned int plane_id;
 	unsigned int stream_id;
@@ -1060,6 +1061,7 @@ bool dml2_map_dc_pipes(struct dml2_context *ctx, struct dc_state *state, const s
 	} else {
 		ODMMode = (unsigned int *)disp_cfg->hw.ODMMode;
 		DPPPerSurface = disp_cfg->hw.DPPPerSurface;
+		disp_cfg_index_max = __DML_NUM_PLANES__;
 	}
 
 	for (stream_index = 0; stream_index < state->stream_count; stream_index++) {
@@ -1067,6 +1069,8 @@ bool dml2_map_dc_pipes(struct dml2_context *ctx, struct dc_state *state, const s
 
 		stream_id = state->streams[stream_index]->stream_id;
 		stream_disp_cfg_index = find_disp_cfg_idx_by_stream_id(mapping, stream_id);
+		if (stream_disp_cfg_index >= disp_cfg_index_max)
+			continue;
 
 		if (ODMMode[stream_disp_cfg_index] == dml_odm_mode_bypass) {
 			scratch.odm_info.odm_factor = 1;
@@ -1110,7 +1114,7 @@ bool dml2_map_dc_pipes(struct dml2_context *ctx, struct dc_state *state, const s
 
 				// Setup mpc_info for this plane
 				scratch.mpc_info.prev_odm_pipe = NULL;
-				if (scratch.odm_info.odm_factor == 1) {
+				if (scratch.odm_info.odm_factor == 1 && plane_disp_cfg_index < disp_cfg_index_max) {
 					// If ODM combine is not inuse, then the number of pipes
 					// per plane is determined by MPC combine factor
 					scratch.mpc_info.mpc_factor = DPPPerSurface[plane_disp_cfg_index];
-- 
2.34.1

