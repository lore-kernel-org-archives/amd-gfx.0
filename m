Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D10C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E43210EE7C;
	Wed,  1 May 2024 07:18:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E24NtXuZ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B34D810EE7C
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:18:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDa8zWxsFCPLJdrhVrIIEIktRtlFcdLz5zNHuNqfD/GfEsmgWyBQS5WBoUIKqMty3kPUbqTVSZc1WhusGzGfE8zWMVw4HpZry8qjvHNB56Tj7wpBP9tSVnDSyVrANIZIBU+v09VZ8CofhzAdkVrp7m890In7a7qbOUFpgd91rjHOzlQA3hnI8HgD01Rp+DnHhpHIqMwzbNbMKJnh8JIWlhBh7d/IvP+WN2etMYrRQVXu89u1GSGiWpNGRrJQBgH77lsD7OVllIXB9iVNjY/12P3fKDvc0blLU4WsuyJyWRYGYw0/VGm727FLrfditHuuvUrCX/50qFPxbfpZVczY4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aomcV5v/Igb/7V1vqdLEdYSSIBFbTLfezy2BhTYljX0=;
 b=MfzQ3LQ2j02ADLEBLn0xV5E55+ZnfTt3JVcAN6Omf3VwVyul92ZMHiLUzF8a1M7Oes3/uWD/x8LkG0rfRvQvESsW2G171BmsJWK5F9fCMEIcQd/0uzwFbepJKHxn11pQOgmzbajcYtvVmQmzmUOd9hCdUxBpspDTjqfj0jErcd+JNiZMbiq7dh2TtVCgjuF2DYzhhZSyvRSrHizGCYtysTPdjoXzaRe2Ew4qZgObizzrqwz1SOKeJ9iHEomLGc8nhDPkBxfvw2Ap5WLDze43LSNeH2Y/V+lMYgs8cSjlEMY44CqvsqQY3dBoVFPMuCDBWRNGqCfC+kX28dX72pZpsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aomcV5v/Igb/7V1vqdLEdYSSIBFbTLfezy2BhTYljX0=;
 b=E24NtXuZOPczwljtbz5+z45HiqjY89bQa/NW1LzZMUPAfTbmZckzOPbiMJUPyq0L5kuOH81+HaN+oAey/svvaqdbWwxDcmGFxYZaIVAQS9YfugDFdWlycqznUZCtXCwrxENvJUwxj/gRUMqpg1lY4/wMvh6QPv7ZMWqbXZ+SUsM=
Received: from CH2PR07CA0034.namprd07.prod.outlook.com (2603:10b6:610:20::47)
 by SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 07:18:08 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::82) by CH2PR07CA0034.outlook.office365.com
 (2603:10b6:610:20::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.27 via Frontend
 Transport; Wed, 1 May 2024 07:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 1 May 2024 07:18:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:18:07 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:18:00 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 12/45] drm/amd/display: Stop amdgpu_dm initialize when stream
 nums greater than 6
Date: Wed, 1 May 2024 15:16:18 +0800
Message-ID: <20240501071651.3541919-13-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|SA1PR12MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: 313a81bf-3191-488b-aebc-08dc69aeda1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Di7CEgZ2pJ0nR5aGYrMzVnUi+RUyQscchMhHWwZ/orXfA2uq+oRUlHOnwnYd?=
 =?us-ascii?Q?CWlSI5ouDngFPr/R92jUyLi7JjKxQqczSiVPo1oG4E6sB6xiSJ/lTrbg3lTa?=
 =?us-ascii?Q?ttmFrTLiI//7PdhcDH/lGPuA9idhDSyM7b3LuZL1rq4jDHDD5N77vC1T6FKk?=
 =?us-ascii?Q?X7ElXkDyrnjkeYtgDM+V0kgIAfyLO/Nffniq998ZvK5w8LGXonR2Yi1XcGgR?=
 =?us-ascii?Q?FrUbiiL1bZvBn/5LblTH5FB5zYbg9fCeI3w0+P1y+rgsdE60pCQ913/qSMJq?=
 =?us-ascii?Q?5+d/qMJaRy+xIJZz7zt1aB9iY/e4rSSnZRxCO17Q/RaXsqDe+O8oTtPgbgvt?=
 =?us-ascii?Q?o48+omzRz5pItWYz6enfSC6smFVW4bIDqpGbKeAlFfLWh5T4ftqAw3u9T3En?=
 =?us-ascii?Q?czSb/3d64g4B6UDkZ6Y/x9AiQZ6iULmd+soJFn2ujxxL0XlOG6ABuKCIM72j?=
 =?us-ascii?Q?YarCxGqFGyBXe7iym0Fv+APSw6iiMLmfIbucOzb5L4pX3xEOxm7tc6i4/sGd?=
 =?us-ascii?Q?ogQ39UUiCI6ae5RTEZre8nHt3r7RarDkupqlBGPGozElgNP2sK8xN3GumOBq?=
 =?us-ascii?Q?WN67aqaiVxf8IjYqm4SH4o1aM1wnWFFHRJQgZ3CEJ1eYELC+mfZuFMmeHH9W?=
 =?us-ascii?Q?zDFJstUaignmADUGLAotWoOgNVukKtXlgP5hg4nZFoXv3QjHtyubGvM1Ehau?=
 =?us-ascii?Q?6hwN81e3oxmvqdRl7tmjzzXUB8zI2m/Ta1XC2+2tE7puu4tSdsT9gWv5QOBV?=
 =?us-ascii?Q?W1Pt3neK7iZPKwN7w1cFAvVBpntq09O43Qf+fG2Mbbd0N8PifK8FqGBznBUW?=
 =?us-ascii?Q?mIZpB9bH5sSqBsSeKXJrRFbhOX3/1IiFRuHkWb17DVCg428+8SK30zxThtSa?=
 =?us-ascii?Q?T55oSZjTK7xxE8Jagi+iJifDSOhKsYfjKB2F+Kp5m5AuqX+1wbf1+oQwp8Mh?=
 =?us-ascii?Q?dGXoWAoji5FSEC0BctS9/gofbWzBueSN4ei+nC/qxrr758WXPOlN4SZlg2q5?=
 =?us-ascii?Q?XGHntM9tqqArcifWEp6y3vekvkFJCp7Qvb/xLNxmEmTgGhO++1nAJI6q8+An?=
 =?us-ascii?Q?mfDEmVZ2AD0pLVZYVHX7jlcVDgt1DFAJBlU20c23zLWcWpN7tkPgPMz+O888?=
 =?us-ascii?Q?NOSw2yLffS+UACcvoLtK9NI0BOhPnhyuFP1uW8mIpVMWvwnZmVB6NA077LS7?=
 =?us-ascii?Q?NPnnEuDnyxUR8iNEze7330Qh8Apn0tznyaXKFwNalXwyviDgxM+7j/GVYY4E?=
 =?us-ascii?Q?uJaHmUx7adbSLDogBKmwCy4yp8T0GHpoDvOI3Ab3oD6TyaQqt6HloMnQQuTV?=
 =?us-ascii?Q?Lls3b+WC8k+hikT0t4idQxt7IJo3F5cUIJYIDX0QLW27u5S1fUbnmvL4p1+D?=
 =?us-ascii?Q?k/jsyDHBzPtFhSdZzJjoW+cGLoY/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:18:08.3903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 313a81bf-3191-488b-aebc-08dc69aeda1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246
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

From: Hersen Wu <hersenxs.wu@amd.com>

[Why]
Coverity reports OVERRUN warning. Should abort amdgpu_dm
initialize.

[How]
Return failure to amdgpu_dm_init.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d922751995fc..cbe2021f14bd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4566,7 +4566,10 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 	/* There is one primary plane per CRTC */
 	primary_planes = dm->dc->caps.max_streams;
-	ASSERT(primary_planes <= AMDGPU_MAX_PLANES);
+	if (primary_planes > AMDGPU_MAX_PLANES) {
+		DRM_ERROR("DM: Plane nums out of 6 planes\n");
+		return -EINVAL;
+	}
 
 	/*
 	 * Initialize primary planes, implicit planes for legacy IOCTLS.
-- 
2.34.1

