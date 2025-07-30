Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C51C87FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 19:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F6A210E6CA;
	Wed, 30 Jul 2025 19:01:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PBoxL2Qa";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C111B10E6C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 19:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRbr7dJXBX2khC96TuqzJA5tR27uGs92V/iNyff/Mi/ihDR2IaQJaUYnCjXAJqlkEbXCTI4X2P5AWlUcuOjlEBQ72/8dFJBVvhI+lXcwLwJnZi3R2WQTuQaYA2p72COjxm+Rv9N7oR2KE0iOGD7qmTT3udNsTrOPLFZYm08jUdKZLV6XfoeDYOTPZ31AfKD3xCMqsfSWXFJ2yYQzY8OWoCiDh8sGxy+kBl38RGn5JAGK9bHXNx9/3EL8ugADT/9fnE2v5bATzYaIsvcWIcpgKH4c5c68eWkFVV2IvJ/7Pu7ByvlsjGTz/lQLTZStte3KjVgyDlMAwV+WrArgpB4XcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qysgp4UyjgP7RmK+MJ2lV3VQaVOrm1VsjMpmpYSTKQ=;
 b=jhZoHX0HDCM/KaZT0r7h59+kl3p4GN7bNoMQloIuaUxm5QMm2trtBE7O7t21m48JaezayiLlYvak6eEx1egCEKDt20RZ7KxtcxV/RIckGMnKJ7T+YeT0HIkovx82KtfvsWR8C6fLKrdnJwC9XxxGZPqZl141ZU55cQ3OWjvaDwAv+NiTFP7U8KQBfeoA0n4znORra6erNnJjJlR1gjl3jpyuvVV2HG5ouZJ9gp0c1+K4NwStZwoVqqVrfCwpM+Z6WzMAvVSAw2pT64FodLYTxPIvvUtabggmlBpQSkHGd6EOi8eZfHKDW2BZDjiSh7HOx63T7/x6NDP5pLMipsUqTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qysgp4UyjgP7RmK+MJ2lV3VQaVOrm1VsjMpmpYSTKQ=;
 b=PBoxL2QamDlr89UpKgKcixx3AbT9Yw8jKIHDAcgLzWgDxa464qxOFaWW7goFRPrk+qM9x3Tl4i8q7BD8XG7CzAnp/hHEkh0CWmu+kkbra2Z+0nBTNKH+MVXAmE9eOb6ZZe1Orf9Ti2yAODDp04hPraa5KevVAL9pPghre4lFuOM=
Received: from MN2PR16CA0028.namprd16.prod.outlook.com (2603:10b6:208:134::41)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Wed, 30 Jul
 2025 19:01:11 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:134:cafe::d5) by MN2PR16CA0028.outlook.office365.com
 (2603:10b6:208:134::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Wed,
 30 Jul 2025 19:01:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 19:01:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:01:00 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Jul 2025 14:00:50 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 07/12] drm/amd/display: Avoid Read Remote DPCD Many Times
Date: Wed, 30 Jul 2025 14:58:58 -0400
Message-ID: <20250730185903.1023256-8-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730185903.1023256-1-Roman.Li@amd.com>
References: <20250730185903.1023256-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc45caa-c9a4-457f-7392-08ddcf9b727b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nfeh6lJv+S5KBEx4gJSy9SkQOYq0/FuOsvILfjLIi2selpwsUPf3GWQfEzci?=
 =?us-ascii?Q?I/E3eya8FjK/BHQU2IFMSEQjv7PXN2elI5/28omTiWV1k/KFwAnWLghR3Nvr?=
 =?us-ascii?Q?hG3sFITa7woLPSMAm3yu+OfdF2coIu2kWRskCOEn9plHHkcUBAUnm17tuy1j?=
 =?us-ascii?Q?naWc7ADm2FptKDHwbtv3QCCNGADA8GozMNsKNBAqLgkb4Xp96wztdjtOKeFx?=
 =?us-ascii?Q?MEu5j+AljSZHjJqY5DSb4F+6ySetXnSD8loaKmY6Vnxy2POnGbXYwQk6eH7l?=
 =?us-ascii?Q?jfNkRzip+tVbxBE1bF5rpmCLjMMAaznw+37dLCJS55pG7SsozyfOj1uzjw+g?=
 =?us-ascii?Q?iGIrc4w6T/faymY6hKGx5OZ7KZz0vDZVNsT4tNN3QXOeyQcvk2D8q1zMn81x?=
 =?us-ascii?Q?92b97a9Rnzjlqk091GUkgMCJzsnwiyuS5GQyjl4ZC/XQsiUJilOAtfd/4AhV?=
 =?us-ascii?Q?6uChKEAprYY2ignCFPNwlplhUgzOw12AKVrQYZoK0FbcyE9ts3I2Iy2bZQ2M?=
 =?us-ascii?Q?7xwPEvaNUmFbJKvUKl9auoLkx6XQ1NAkyCK8P6HHny23qhz8V4sanLfmIYmr?=
 =?us-ascii?Q?evIlPW0rhK6mrZVWZhDwJhN10UueZATBOgJF6f2M6gBz9nVR0uS/i8BHyfSO?=
 =?us-ascii?Q?47nlo055dmzKWn5jUBBTpT92tGKbF3ZvZ8EnI8vfdfR7Bt52YVufZgdBZO/p?=
 =?us-ascii?Q?4OYeTqkTV76jnKxaPRhMiRdQrWKXBDleixcJDqmsCGO/i+sDJycF22keiJ6y?=
 =?us-ascii?Q?aqX/HG+zNJLIrZ1gcXzBh/IQGymbKDFQGlFKWDglSNk1uEPWQiZrXpjHRlrV?=
 =?us-ascii?Q?W2/ymWBiteVd1kj2VPSYyTb8Im0cXERYKrpKdRn4ZShrzDMsdTrjv8GsG5w/?=
 =?us-ascii?Q?+1DCCmvXWvNW5foB6awqVn1oe5C9/uEgnPRCBHnVNw4MojR2PWB/NzE20BpJ?=
 =?us-ascii?Q?Gbl9h0MSIPgxGaDCoiSBPqN4JrcT39Uz16zPJ1Szwn226JVh3ACJ1xWYmfFO?=
 =?us-ascii?Q?gdtpQqqYB3iLpegVw+33Wcim7muh9dzRjBrVJ4A3m0qj8DB9MjkaRjKXGH8y?=
 =?us-ascii?Q?2ultL7VvoGLzJSLpLvNxDcujp7uC+x+jA0qtFFozntRSMfPU/hz9nNrea2Ut?=
 =?us-ascii?Q?izS3OPc4JFbg0jREPXpai2Xzbae8BDTwHOVpNKGLvXuaXQWOvVvZoUHM+A/5?=
 =?us-ascii?Q?rcwcYxfBhQ2jHXNwid9FKmkvTL5T2kGRV41K52SVhILPDR2NbesgAVD1YBXu?=
 =?us-ascii?Q?pgx88J/tIzjW+nTgYZl53C/x+nfxW1pO6mG9Tzplau+K2sMbHkzdFtgQmUbv?=
 =?us-ascii?Q?s4gwt6aMdM5HHxBm+hqYZORBWNE5YO5n6G//xbvcv8rGzx55AvWU4i1VwqQ6?=
 =?us-ascii?Q?DhFLfl1adNRe2Yt0pMVQNVGJoYulQN9GmT4j3g/LXu107Ry0VYyjpgOkvyg/?=
 =?us-ascii?Q?Ovn2b+hrloCzYuRE+uLSQsf+P5xg80BFq92YGMyIfTKOhJn3CMEUygcqIyol?=
 =?us-ascii?Q?6569iNSwXEb6/f+c7W+ynUsnM8Kthc9O6nKw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:01:10.3621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc45caa-c9a4-457f-7392-08ddcf9b727b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

Reading remote dpcd is time consuming. Instead of reading each byte
one by one, read 16 bytes together.

Reviewed-by: ChiaHsuan (Tom) Chung <chiahsuan.chung@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 137f18d41f1b..32281bf62f70 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1763,14 +1763,17 @@ static bool dp_get_link_current_set_bw(struct drm_dp_aux *aux, uint32_t *cur_lin
 	union lane_count_set lane_count;
 	u8 dp_link_encoding;
 	u8 link_bw_set = 0;
+	u8 data[16] = {0};
 
 	*cur_link_bw = 0;
 
-	if (drm_dp_dpcd_read(aux, DP_MAIN_LINK_CHANNEL_CODING_SET, &dp_link_encoding, 1) != 1 ||
-		drm_dp_dpcd_read(aux, DP_LANE_COUNT_SET, &lane_count.raw, 1) != 1 ||
-		drm_dp_dpcd_read(aux, DP_LINK_BW_SET, &link_bw_set, 1) != 1)
+	if (drm_dp_dpcd_read(aux, DP_LINK_BW_SET, data, 16) != 16)
 		return false;
 
+	dp_link_encoding = data[DP_MAIN_LINK_CHANNEL_CODING_SET - DP_LINK_BW_SET];
+	link_bw_set = data[DP_LINK_BW_SET - DP_LINK_BW_SET];
+	lane_count.raw = data[DP_LANE_COUNT_SET - DP_LINK_BW_SET];
+
 	switch (dp_link_encoding) {
 	case DP_8b_10b_ENCODING:
 		link_rate = link_bw_set;
-- 
2.34.1

