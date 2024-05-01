Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0869C10F1A
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 302E71130BA;
	Wed,  1 May 2024 07:18:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V7SVoEEK";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 821271130B7
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:18:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3M3L6yK7hnyd8Fy1H6XorHKDx/OHTe994ZBzYZvHXrkKJhViVK53D+5rGfy741SWYhQlmrHOfk873R1fch8oddINvwmapPMPgHsOEKJFRZKNb4Sq0sb5IVMnu+17iTWxziOKYP7jFYc9CZS813SwmcE7Xr6G9dkZ1GepjpF7xwFy6sQEKQ0bSD/yX7kG2mi+SToIT3XDhiVCG3aqC40CX5xzJn6/Et9dHrmByK2D2KMlUYRNl1280we5dAp33DH8S077CK02RG4B0LgIH7BItxzkz5x/G5n0k3LiOM1Ifow38v4df613KNoOqs4IhUs8gTc9htEG4lzfPyNp3g7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/A0J3+yZY83GBYnenV3aAhUDRaCer4JWxJ0ILwJQ38o=;
 b=JKvOE4WaD4psyP40FXnRIob29MYC/zVvw31Nw0GQ6DzgA5LNwhOJHmOERB55WwkJ9/Ko7FlrTM/wGOfFxqXe8f/bXOtEScgWGidphzV4G4jEm9qmPFCBQrOn6qUbRh63WnfgONZnzxgO293m3XYfUeAJ9OQUQ9OPNyHxAZtOG8PB8Fx3oY/Rc5qh81M1nu6hYaQZtTis0/ys7ALmrdl61ZuvOLe4viTisN6TBVGkCR2e45yO/Heks1S1v00gwTZQWkyL5PXrUr1Cu3AXisYIi19B8xH3LuOjZRM13Hocxc9iMxlDn7MmE7Gd+kiG9q1nzzs9ckPxUx5ZPadrVXsAHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/A0J3+yZY83GBYnenV3aAhUDRaCer4JWxJ0ILwJQ38o=;
 b=V7SVoEEKJx/sK4V66NIg7UremWHsh+heFMOYIJBRux+0bJhjzHwSWSRfDQ15d1UN/uy58W4qvPTuZt6dIBQ23FV7p/GsJFRq0Z5SmFDM+dfFEVbNfABWqiXRfMTJ0L6VZ2v/QVBk6cXuxSkNuwhKVU5C0a2fnDfd/fu22Xqe2Mo=
Received: from PH8PR20CA0001.namprd20.prod.outlook.com (2603:10b6:510:23c::15)
 by IA1PR12MB6579.namprd12.prod.outlook.com (2603:10b6:208:3a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 07:18:28 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::a2) by PH8PR20CA0001.outlook.office365.com
 (2603:10b6:510:23c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.37 via Frontend
 Transport; Wed, 1 May 2024 07:18:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:18:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:18:19 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:18:11 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 14/45] drm/amd/display: Stop amdgpu_dm initialize when link
 nums greater than max_links
Date: Wed, 1 May 2024 15:16:20 +0800
Message-ID: <20240501071651.3541919-15-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|IA1PR12MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 1719c986-59ab-475d-d5ad-08dc69aee5b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B8SB9Cl3LNng4kwFcA8nxXZhiaiYAmIFUV5SfpmRtWBzgeKkx9na84FsbL8l?=
 =?us-ascii?Q?J+ZBl8HNy0RSgPCVTYlCLXGJxuJNp3Xu5Tji2SOibWIjzaTHtVKh0AxmIwP7?=
 =?us-ascii?Q?++mpfQEZ4xo8oU1G6omPkbqrVv5OvxMRx918JC0eGGBaa22J6I8vF4tga8A+?=
 =?us-ascii?Q?dGMfe7wNJCWuZQ5JxYooUaD0cl5GyfCzRlyHvxj90gPURSIThDwc+GIaKK05?=
 =?us-ascii?Q?jNd0rFbOROZZduxnmp4Or9dnwzAQZKleqO1vRPMD+1faA/VZSHg3/XNJXQUj?=
 =?us-ascii?Q?vNWI8GG+5GyCrExptrcSc0lqtBeZBOIaskgCusz/55XKjXCTFbEycZk48meB?=
 =?us-ascii?Q?sNVqkFOdLf2xN9+rpD5mkzyUCvZzMgGMz+aaEbJRkeDRkTiSgLCeaQOf4wfn?=
 =?us-ascii?Q?XVr2TuPfDz6lkBAPBgGLt2ymWY8umYEtiWh3KOqWQ2EEjPTGntNLHkaQD2Nk?=
 =?us-ascii?Q?EQ14weJEINJb+wUUuqIUA/yY85SLRIduSBGMSxR7VVp/9udv1mmvfwZ0D+ni?=
 =?us-ascii?Q?lbz7griMl8ws9lM0qQEsIpqd/ZvIkmatrqzitSU/YdsWk3V5RqNg0fcmMxc0?=
 =?us-ascii?Q?ib3LX7Y6MWpfeoeRrGJfjIPWeotifqj4s4Czr5wpifWeeQjMhQvlan1HHKt8?=
 =?us-ascii?Q?Sn2OWNtB+scxbBvuc+V/Acl9xu0yHe8fEJNmY5jMHjVzBc8OJ4vLowm+JLq6?=
 =?us-ascii?Q?rvLsTx5Z6Uaq4+7rxM5fmiLMQ2PhDF3f/OZSXCAcV81Xl1tgr/0Uk/sIUe/r?=
 =?us-ascii?Q?IH6A+pOTqlR3vmyO19UPa9VVpGnSxyVs6XqUcEk4pZLGk9GcJCIU3zu+n1KO?=
 =?us-ascii?Q?WlKU8jxEQq3GiU/4V8C9vYXDQwIJ3m1bnh2E+orvjaQjDu0IiLbDDb5Z2WmQ?=
 =?us-ascii?Q?M+p4TCml3EyhulZ9AzQlLtTSYzbHpatR6uWMvZX0lny6Wqvk69f+ZvcKU2Ke?=
 =?us-ascii?Q?jcI5ZIHXNUekLSKr7QWYAVHxitrZKtsSyDFlBDe8qfLSBNTNvMFqXq8PWLrh?=
 =?us-ascii?Q?jGH2fpJNXAW3RSyDIXn1iPI4d+2yvG6mmw3Yo3/4BrQn1SBwRHLBt3ehj+BF?=
 =?us-ascii?Q?Xij+LqI4a+TJVMx1KFl4RLLpxN7+a/dyOcjtg23OOXQqf9GqJDB01DoPKWuG?=
 =?us-ascii?Q?o2THigrPHFzN3FbW/YXQl3BRwKLosrVC6HvgqT7HqQ/xhBzkfovKVrtjai8y?=
 =?us-ascii?Q?Nkewt4BiLjUGc5Ewvs774o8uDd5f+79OhXHF6KhJ86eelEXinontapX+KTQ9?=
 =?us-ascii?Q?497sZ9uUC5QphPZ03KLb33Bo1GoIg007PnAjJKomdgURwfengTqKT2ivqt/7?=
 =?us-ascii?Q?RmfqgCn270z8pxRn5OTzihZOmp1dZJdrvnptYzrQgVeLzpg3hnxR13Wum+io?=
 =?us-ascii?Q?E/SYdY/fbdFTINOCCgDnOhdOZUan?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:18:27.8111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1719c986-59ab-475d-d5ad-08dc69aee5b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6579
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
Coverity report OVERRUN warning. There are
only max_links elements within dc->links. link
count could up to AMDGPU_DM_MAX_DISPLAY_INDEX 31.

[How]
Make sure link count less than max_links.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cbe2021f14bd..af35bb3c3b19 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4685,17 +4685,17 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		}
 	}
 
+	if (link_cnt > MAX_LINKS) {
+		DRM_ERROR(
+			"KMS: Cannot support more than %d display indexes\n",
+				MAX_LINKS);
+		goto fail;
+	}
+
 	/* loops over all connectors on the board */
 	for (i = 0; i < link_cnt; i++) {
 		struct dc_link *link = NULL;
 
-		if (i > AMDGPU_DM_MAX_DISPLAY_INDEX) {
-			DRM_ERROR(
-				"KMS: Cannot support more than %d display indexes\n",
-					AMDGPU_DM_MAX_DISPLAY_INDEX);
-			continue;
-		}
-
 		link = dc_get_link_at_index(dm->dc, i);
 
 		if (link->connector_signal == SIGNAL_TYPE_VIRTUAL) {
-- 
2.34.1

