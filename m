Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E177C369A8
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 12:51:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DB7410EB93;
	Fri, 11 Apr 2025 12:51:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FQlaCXsL";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EB8E10EB9E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 12:51:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMhvnbV+BdVid/N22iYQdwmOxaYg3O7sW2eXnXrmKd1yDC3WFZ240lMpd1vJ1VSPI/Z4h4NZcC+mQiLJkBbJh2zS9NnyzQUj7cYGbb6i/GTQp2OZlajF3NGOWSgFsbyCha6jqQHv+VG3qBlxUvsW3z0kPAjVZCUlFyuAPAnDb4dLCnVI+5cyrSRoW+IlgweX0NokZOUoMYtzxZFrYQq67HxKvYKuCgAuz0eof4/DKbm99Tn+ZwEKCKly/myymucPl7B8QVTtMxv3FmOMwm0GTfDpFijsmNczPDr/7PBAi904IW4D7RcAFPaxrIM4q3FhhVZYeeJmIa55olNoLxNOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmjTiUGblGzlPpRwihBxv1VXx0eh1UmeNhR9yB1A/NM=;
 b=K431P0/ktMGynKdlxsW+V/+LLJCU5u9+Zc/sF9R81kSfEYXgwjufea3b8cUTDG83pUNUOp4RsLBQAj7mbsmBXIvR9VI7fFXNfzdlYS8nN2x4hYkd5uyi0/eqX5UFG9y8DQTOkubKIN4d4l1cawS4i3q08n6Qb1Ps9mVVG4+Sna0dSYh7YdEi+/pi9784qirWEkMEKsrsS92tSiupHjyVBJEbPoyTmk+MpX3cL/i9i90qKRUUUsY2WxuLJ/3rkZONswy22aFjwzzhJnz5H/em4wdoE0Qj+35xTnrvz6O+EgcW0/pqxPmrMK7idhZ0Nd+FmszgjERwPEXh5OVkgDLU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmjTiUGblGzlPpRwihBxv1VXx0eh1UmeNhR9yB1A/NM=;
 b=FQlaCXsLZoVsF7HULNeu1nudafzLceRvLWWBwXQt24wmS9Qk6xRZB+MTgZZeMk0IV2SdXR0pcYakbGr8SwYvFTMCibffngL9PhARzRpB4Vm4i7GmErrn4HnsXTKXV+/EJKeC+K64lluqvEknJfUWu+Cx3x6vOf5tTF8HFuis36I=
Received: from BL1PR13CA0070.namprd13.prod.outlook.com (2603:10b6:208:2b8::15)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 12:51:02 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::1b) by BL1PR13CA0070.outlook.office365.com
 (2603:10b6:208:2b8::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Fri,
 11 Apr 2025 12:51:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 12:51:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 07:51:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix no_user_submission check for SDMA
Date: Fri, 11 Apr 2025 08:50:47 -0400
Message-ID: <20250411125047.2660769-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c906e8-770d-4614-cac6-08dd78f78401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5SRQMeQHq/zo80NuS3VhCZfQ8l47PQ2uSStXykjFORc4aaekq+r9/UZ5vpGX?=
 =?us-ascii?Q?7ILQPTwgs8knrvchNHQgwRDOjGF7OdKPuDd6KbMOVYIude1mVm0/3yLlJ7hM?=
 =?us-ascii?Q?8Hckj/5A9/XOqf8XJGw6GzNi2QdveJk+HE9pQe3D4LDM3+ahXLx4osNs3R9r?=
 =?us-ascii?Q?wkyr6ht5eVA3M0M0e4cr3ZCg3bBG7nNMDRLDGDmdmONQYuGaJ+1oIfvX4rbK?=
 =?us-ascii?Q?pojNK8+JenkjT8L0MkEmRQW7PEEVHx38oKA5u7xUAULFNTc4+0ZeUNgnzsiu?=
 =?us-ascii?Q?CgNV4mvIHbjMJK7x0T5b4QiN+Vi1QTB0DYMRx/qJqkiFzHOL7bKOFAVsmmEs?=
 =?us-ascii?Q?UgBGdJkcl2G5dL7JcrA8swqLRhrp0hdtuWjXbN6LXl/lC9TACkHO7DmTxYjo?=
 =?us-ascii?Q?YGyUF7cByyuriJM7jnvriBMcAMPWLUVHdGE1V5mu9TtUI19TdK9voumO4D1/?=
 =?us-ascii?Q?8xk462ts6Umak8QGqcp4TCn7NyZITI2BLPrWsPEunK04JVY4T1iEIx6Hvocc?=
 =?us-ascii?Q?0vSVPLCK07AALmzxCGMwHm97WeLg0lhvmSm8ftC6vpaKk8ifGFX/UNB1Rq1h?=
 =?us-ascii?Q?BkNKVOVGMJN7dJiWJTPFNzeHx04vGmwGN6gwZZDtatews3vPJJwQsFPY4x+W?=
 =?us-ascii?Q?ScCo5aJxTHCKFYJNB91tpW6dP4UJnLjk6K3Cg5LyC+K9vDziN8zSD2sulO7R?=
 =?us-ascii?Q?Z4mKJhKgUuS7RwjjmpSsVOYFV7BCPE97TeFwAeIZmk2xJtIS46ogkv7JVh5M?=
 =?us-ascii?Q?kqQ1SaXmTIIL/xC+NxOjZNrGrNE23V7KiycikEub+Ku1Mnthy8PakHWu5VSQ?=
 =?us-ascii?Q?Yzu74UDJEq972QR/RDqohX2bt/jRA99fy/xLX9zfX++7FMFW73fdM2VTY8/G?=
 =?us-ascii?Q?QRalZUZm5lyy/XTySC6a6McnS6hwOtPJuh2dNFrN7tFVch5z7kNWtD8CwI5w?=
 =?us-ascii?Q?XlyHZ2CWBOgt58iLDw6bI1JPTbmFS0r6AYi8GlnUux4ahHrEfBmmKPmskMyK?=
 =?us-ascii?Q?1YF47dEEP59+HUfnn9XBDK9LMkHd6zadp47rrYwm57zXWwVb9kW5q6+QFkwA?=
 =?us-ascii?Q?GR6UBqxVWNLyG6uQpAdZv1cBaVml8LVBBSEjV2DvegR8LIGm++6D8ZZ2NZsg?=
 =?us-ascii?Q?W0QhJQ1JV6lmsqK2Ukcb++fujuZFu6ob02jxcwBVxh3Tkw0aXU2aGvGrJWKi?=
 =?us-ascii?Q?Tlz2tpS6i9wwM3YxHFI5zNvW+NGHCZDQqYCrbwLLsmLryADLDitRnuD2pACM?=
 =?us-ascii?Q?/yv3OqAdAuXxPcG5PfJHHoXeDusVmsoo0W/twreuVrcwaoLdMllDM1KNVlVd?=
 =?us-ascii?Q?r/aL+U3x8TXsZIid/rFU0TWyHOlDIzvUz734gFMRZrpxTneZL0Nx3efe2vjp?=
 =?us-ascii?Q?9WwKsTgQEzmE0VQvxLFJjkcYbp1Z8NA+cWHAEcTWfvOB4Y8JHh/T8M13fuyv?=
 =?us-ascii?Q?pkY+M3e6mJUdkNXB+yAveTtNZPOtP8TF35M7RKcPXKIdySO/OxknAfBcn8+5?=
 =?us-ascii?Q?sT3dXwGN2iQiVCYjbFdsUmNFoysuEQ1YBeJr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 12:51:02.2974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c906e8-770d-4614-cac6-08dd78f78401
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102
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

Copy paste typo.  Use the flag from the sdma structure.

Fixes: 4310acd4464b ("drm/amdgpu: add ring flag for no user submissions")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 0ba3ef1e4a068..6a42dea775b10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -427,7 +427,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		type = AMD_IP_BLOCK_TYPE_SDMA;
 		for (i = 0; i < adev->sdma.num_instances; i++)
 			if (adev->sdma.instance[i].ring.sched.ready &&
-			    !adev->gfx.gfx_ring[i].no_user_submission)
+			    !adev->sdma.instance[i].ring.no_user_submission)
 				++num_rings;
 		ib_start_alignment = 256;
 		ib_size_alignment = 4;
-- 
2.49.0

