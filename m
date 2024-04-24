Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896B3C07E8E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:33:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0734D113902;
	Wed, 24 Apr 2024 08:33:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sUFVfCYG";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEA6610FE09
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:33:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcC8YHxsdAAZ3ttwQYdtIELm3RU14IYhk8robV2y/lzqnLPp5wCLUh+/HlV+JIyMut4JS99GCbO9INUbtb7IjMWuKCtCYyMeIDJnBFA9wsPzEaL5VY/z52feFS/7p4uSN0eDfuek6Vz4J5jppnttfEzFNHkUQvisTosBaTtrzkmmnRyJqTBLYMUVnxjvH/CX+8OViXmitNvhDB2qGr7KiAHf0r+2u07Ow/RtB2+3McwxugDCPW8E5qdW7jj6yRyBf+zrJlVfl5RID4SsCepymj2qZnUW9W2DXtUBxa7OmT+qv6yxyIQRIAWAoE0C1lTK5eZ4aLg6M0IO9INL1nL8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+p1eetydjF0l7cCdrJDGWObo+m/urGHem2Pl2AXZuyw=;
 b=R8Yi0VKGbRgbyF8ickK/Z3DfRApaY9i7qZgjjB2gHxMRGiVAXfmHoMBWWb/zPIQKuXQRc5ORuPJfRR55IBvMNyABHsraVwsPcJMeyJBo7D4mi+HgXXLDENES74K+A6OJZCyRvOh6tHBh/MuVsd3kFza290r2UZ0Rw8CBqG0zunG0OnYfFZA2hZgPh2JC1KPOBaZuk82zhNItEt3rVr8QoW/4+9vlTI9ZwhlFczCIx6lf16ab7GEOrVTsajpIzQDgw4FyYxAis7LxqeZqMqCywlin75+6rbHI9Z6/SKNJbZsA3bWQU3i35bwBrpInOIj3DLWqwk/yFkeaNQdYN7eegw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+p1eetydjF0l7cCdrJDGWObo+m/urGHem2Pl2AXZuyw=;
 b=sUFVfCYGQG+Eh44tJAQW5mckOOcZv6/ryIrPdGIPJtITyHgHAYsACZgxg06nsoaCOc7bnVU9sg/FMx3zBG3z0qnN2i8YY4/Xbv6OwehcxG6ljaH34n1bolRzJXALv91+OhlByQ5Q/wPV5MHiTHu3ApNAJ/bMVm2/wvv+OwiFlik=
Received: from BL1P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::19)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 08:33:03 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::29) by BL1P223CA0014.outlook.office365.com
 (2603:10b6:208:2c4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Wed, 24 Apr 2024 08:33:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:33:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:33:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:33:01 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:32:46 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Sun peng Li <sunpeng.li@amd.com>
Subject: [PATCH 02/46] drm/amd/display: Always use legacy way of setting
 cursor on DCE
Date: Wed, 24 Apr 2024 16:31:18 +0800
Message-ID: <20240424083202.2647227-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424083202.2647227-1-Wayne.Lin@amd.com>
References: <20240424083202.2647227-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b668870-fb38-4637-4f86-08dc64392804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QNpsgoMN0NX+9De1DFnfYYAjik8jJ14jMSZG0OZzAI1/4ftZI7JbEiphItzQ?=
 =?us-ascii?Q?S8k/oKHe8i7BhymZhVo9VLBrIRg/IPjkuLJkfaA6Xtlwr2LUfdO+c34G8Dbz?=
 =?us-ascii?Q?PBp74YMqGxdOtsftncQ6SPa5MZLY9hdM+wJ9YOgnnsZ6wOisp2Hdb7Z21vz/?=
 =?us-ascii?Q?PYNxlb2d5sawjQHKwKn7DkfiX0hk1nwVRy+wBuGIPgK8O3Bl70DtNH6MZVBL?=
 =?us-ascii?Q?n7cpD3VnFcFghTSugzPBwdIm10V9pwcu/9IExAejCAQaYhyJ5RaqOE9KzPne?=
 =?us-ascii?Q?+BILMsBYYRiILdmNzVz1IzgcVomNb4xPIrR1FjFbQQVyXeGfoqpwVPqUrN8P?=
 =?us-ascii?Q?ChUKqfVKDpBXflQVdyJ4MiEKblE4M8n0IpJuR7L2vjdqw4Z74ySEwxogApAW?=
 =?us-ascii?Q?jd5OZIWS7iu7NXi8496IFIKHe+Wo1SVAZjpEAOoZpePRDJhsZUajFuJbfGRn?=
 =?us-ascii?Q?dNRlHQz+SW5RHJbOArQ2u1nQa7NKQsMkM1Px84vxmenAsF5UFOPIQMXiGWg2?=
 =?us-ascii?Q?PDiPTFc6aRGxT5zyakSo8Ha4qbwdPynzRbXe98hFpU7qE8rBI9BsARU63fda?=
 =?us-ascii?Q?ASDyU3GlWKjYIDs6+ykfZWGjjOJiJvvxNAkd9JkylyZeJ03cgvOaHAMg5huz?=
 =?us-ascii?Q?bzjsx6oKtCIwtPjMF03lihVQTRyFIeFiDqZiRNCdkQEsOkP2gBe9QLxqOtiL?=
 =?us-ascii?Q?mxEs2SVTcNYE1+OxeCBfc3nyLApYQ9QtnmXnGGaKSwMFER0ZQXhNe/tfxgOB?=
 =?us-ascii?Q?WmJVE50tOke+dN3BsfAXmMl9DsNedbv5jflhMnHoTcc3nlvKxwEr5FWWrFQJ?=
 =?us-ascii?Q?ZgrTmC1HnMyGvMFJdC9eMAizmNOrL9T1LN7DwLObE2Kxb7H3crFrGBQF9fDv?=
 =?us-ascii?Q?aFOXVD12PoIaqELPyWrmuj7uqfMZi4TUbfv859BLbdfcpZwGEpOmQp4edIV1?=
 =?us-ascii?Q?6wWmVtTZybEDmHKEWHcxXIKiQGufBoQCaQzVenK3Yt6WyXtQZvr11js+by+l?=
 =?us-ascii?Q?OE2XO6dSDS5UNnVnnIUu/u30yh7oFptmRu1FJQywAKaUoB+7GWvBnA52MFzh?=
 =?us-ascii?Q?Ivk0OIikeCoN0C1hmcMnYpQPy4Xdk72iLVFwXdoQNVP1uLpMEsbWckCP414N?=
 =?us-ascii?Q?DAUw6geWl4jtpUpriPA1IVe1EILKZf0Nbsx/IxHp16looFajR3PUbGnAYLHN?=
 =?us-ascii?Q?BGfN4Le4rZP9Usc6BlKxUHDs9ba53/e7tBYy5oRcj7Cqw3LIZCeO1FIIE6Pb?=
 =?us-ascii?Q?v2VjiWd03rxcE4rHLwyiofHoSFaGhCGItPZLwYAIGVzNwWA+ttyHM/exkvO3?=
 =?us-ascii?Q?uqyAdcksmO+9Y4lCduWME13vo88nMxNskES5I1sqOLwEX9ChZzsBNFj66OZM?=
 =?us-ascii?Q?mrHIirrTWFBDcwG2VdfIxP8JGXnq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:33:02.6739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b668870-fb38-4637-4f86-08dc64392804
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987
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

From: Harry Wentland <harry.wentland@amd.com>

Some IGT tests fail with the new atomic cursor updates
when running on older DCE-based ASICs. To work around
these issues keep calling the amdgpu_dm_commit_cursors
for each cursor update on DCE, even if those cursor
updates coincide with other plane updates.

Reviewed-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 75b65b243f1e..9d36dba914e9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8498,7 +8498,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			if ((fb && crtc == pcrtc) ||
 			    (old_plane_state->fb && old_plane_state->crtc == pcrtc)) {
 				cursor_update = true;
-				amdgpu_dm_update_cursor(plane, old_plane_state, &bundle->stream_update);
+				if (amdgpu_ip_version(dm->adev, DCE_HWIP, 0) != 0)
+					amdgpu_dm_update_cursor(plane, old_plane_state, &bundle->stream_update);
 			}
 
 			continue;
@@ -8850,7 +8851,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	 * This avoids redundant programming in the case where we're going
 	 * to be disabling a single plane - those pipes are being disabled.
 	 */
-	if (acrtc_state->active_planes && !updated_planes_and_streams)
+	if (acrtc_state->active_planes &&
+	    (!updated_planes_and_streams || amdgpu_ip_version(dm->adev, DCE_HWIP, 0) == 0))
 		amdgpu_dm_commit_cursors(state);
 
 cleanup:
-- 
2.37.3

