Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB7EFD45F1
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 00:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 973DA10E231;
	Thu, 26 Feb 2026 00:02:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZtYk6fTq";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3778D10E0AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 00:02:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7lQQ9pdmSs2qOclnAzy7boD0FA8Zh2UgxuYc0dIwU6rpNYV7g4wrL9VvSrHL+83GGad362OXua/Bts9sUSLW3BN4AFR5Ym7KKErGEGjDA9OeENhS3vQuWGc28rJe6fctjBAyT2CATAvwTp1GY7lrpOLkaQwmvD8rRTXvu74URnHx1CLIFlguO6t7SNTi9zL7TbM2AzNM86M37kJSNoPC6/7aGajaOAx2EMCGduTL4z7XkTaIr/jBh4/iXDtzJtnH4CKJXa+HLoA/G6fvDxAXY4gGq7KP7lxAoERYJRA/QMrPRAwir+sEXlhku0BthvkMeZTCYB7iyTR+hEZOsVboA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqbKbC/t6qCi/4gbWgutdwvvCNC0qyBjLvxD31lCM74=;
 b=dyH76EzH8AppQHLRu01yLsJJT8dNtWGVEriNW7WmIKbHSXkOGDjOMIWMN+R1yWu8quaIhuBBrHQtq5pnIh7erHUykI4eMJIJXvbKUEtXqcBNznPODH11QGKU2W6Cj6/9oNxOu4qoOEf4+MW3dOWlnFqf3FQ8ow/Jn8puuhnWPbGRfIip24Rc86RgtMWKNvTgcvtHifHDatywBYaz7Ec7kZVxccNzOeiM3kw8jgAR/R2Bah9p2MdkjEa0QG8QkB1DDqKO5InuDjEOaHtk0bQKHHDthGHZUn01aqifDdQ9r3aVsqcuavqQfCfq17oFlDOCB528l7HNqqa3pFxaPZmp7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqbKbC/t6qCi/4gbWgutdwvvCNC0qyBjLvxD31lCM74=;
 b=ZtYk6fTqW/MvCOyOt4vEXCSNDDWgpR7Xku/Rkm+Z9jngOvSNQS981l4QhVLdNctME8C3jrlTBhHDb8j2lgAKXZPYz3dTYd0D90S5tzGi+mJIPF9P/JEV5u0+CGo2pupPyHeIv/qXsNiqnd7gmHZNe+IVk6UXs5GEpzZdKUmYNDs=
Received: from PH8PR21CA0004.namprd21.prod.outlook.com (2603:10b6:510:2ce::11)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 00:02:00 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::65) by PH8PR21CA0004.outlook.office365.com
 (2603:10b6:510:2ce::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.7 via Frontend Transport; Thu,
 26 Feb 2026 00:01:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 00:01:59 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 18:01:57 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 3/8] drm/amd/display: Initialize replay_state to
 PR_STATE_INVALID
Date: Wed, 25 Feb 2026 16:57:42 -0700
Message-ID: <20260226000048.68030-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226000048.68030-1-alex.hung@amd.com>
References: <20260226000048.68030-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 8788dba7-3165-4b27-c308-08de74ca431d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: 79OzGIdtWeUkQNDSsehp9h+uYrga+HIjplBr7HVo/mRJVOjiwzMOafuBcUEch0qBhE6aSkwOhtmiElLDWxxQ8pRM5TQ+5p3064SpKpHGAN9MCIwvJVkrVUSCGuzRegs5DG1ON1nWXfPmXkbK5emtI9Mp0shfNRI2VTo4NPLM5pah0GeAP1rOk7wpUowRZmtV9TYrk3y7jUTXPxJN8P2lejpPZtGysCw7M4Xvz+0qix/ohG0OifS6fJz5WDbbwV+YF4IqfGEPCajkufNT2DS1Bsaf/wDX0sv0KpkY1cKga3DEHKxRZip99FXicSIuZ5CQIgynlvaiqy8UxtjB1JD3yAj0EXg0UiMcNGGHX4dgfqnYECi/drD27KMLRIlmAxwtsrJNaxDZi6bbYi8DHChcuhx4YGxTXk4Dp9EpmZyjQqmIZ/qyPJPK1/mujCckF2Hbx7b9tzXgfPbVIh7UJ5eu47Tm2FbxKFf4gsQwOdyy+hsSIBY4+TOK/MRaorU+mLK5nL2LzGbwBnVPqXYmV/JuP/8fk7O3tZKQTQygOMvulI6XRkfJ1wrp2UyjQTBIiYDYrbuFG2WcGhaJuM8mFWkSJLLb5jnp8hTMEFSUmjh28exg2hMBp9i0y8ktJ3I4U70XYsmiJq+nutBw1MQIxKgoAGJHpRh/WBte5RxVL+hmT0/3pONM+qrr/ABCaAzqlV2Ew7oIF+CrgLOiAK8iCc0+ucYKeDj49pPawxCrByXYEE29bM5O0vt2GnsZuKZNKlyACRGI1hddg0EmseJsO8LsUYHsKXPbzZw/8kSLFAXv36m8RvgiIJWBwlTqrFJ4km1L38vkMwe0B4l/YB4gt9gtmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RVHZU1EN7azSpWfFlIsjJRbhZwbQQFkmtwDVcsm+cRoT1Jup+9cyljTOzRl/TCFNJDA6bJSAYVlHvUVEhA/ZkJ2N5OMBnDHdtji1TVk+LU3s5AV8RyHWLgRzT/JiU63L1THBScfqe+8kk04OYl2VnemoAKFnPSaS+2UbvGn8flh2PR7XC+nqVG9/x/J5P9xFM7q/4FVm93zaICZ8jEm3276GJH8oYh2Dkd1Uwh/ttQzCg5oaD3SwHCzJ4OMsR1lo97xgWzY6nSRyOoc0dsSZkjXMNFZI7rjNbmbDMtvmrCGyBiN2FY5bKPWv4utjbm2U6abl0bWU/vyz3PNIe+KMm4zAnCCfBfm/x81pZhVn8MqVuex+W3X+P8Hi0xnqxxCiAVZWqPsc8Oz84nqlaMo59Aq0gHdYrIEO95hW5qHJCz72l6QHO6fHfeumVdHNrr1J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 00:01:59.0762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8788dba7-3165-4b27-c308-08de74ca431d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249
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

From: Ivan Lipski <ivan.lipski@amd.com>

[WHY & HOW]
Initialize the replay_state variable to PR_STATE_INVALID instead of
PR_STATE_0 before retrieving the actual replay state.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_dp_panel_replay.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
index 7e45d1e767bb..6661078c0241 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
@@ -389,7 +389,7 @@ bool dp_pr_get_state(const struct dc_link *link, uint64_t *state)
 	const struct dc *dc = link->ctx->dc;
 	unsigned int panel_inst = 0;
 	uint32_t retry_count = 0;
-	uint32_t replay_state = 0;
+	uint32_t replay_state = PR_STATE_INVALID;
 
 	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
 		return false;
-- 
2.43.0

