Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D225C3ABA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 20:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDEE210E463;
	Tue, 29 Apr 2025 20:26:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t1+9j6wD";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7911610E04D
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 20:26:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOk5/64RSP0ddQ98vpB4NCW3BYKhIyys9N9zm14XGgFSGEszCFRB1cVNl5PpcD1yamdHMwq3tO6Y4Pzv9zibmRovMLsWw4AzwWskASL8V9VIfNReKIbElQ6GFdFJJ0Qs4zU67ghhzoWNn76QqBEb5tTcJOfB0uyKDra4WY3f2oOzlSWwCExqRxZA6sCVIreeOMlW6oLhvHQ7DJRdvmmIiOY6leZyj2B3kz9m0pwf2dpzzMCwc1K28mlDZsBKih/Qon26eGUhGERdiMqETI2TbOy4oqqvAfUSni/SzEM0vtUbWnKM4E/y8Ah0Gg8Jv2fQBsPjuqvZFEc5BM/7+bCLxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8OkJ8SS0WLZ3I0XGusPNS+cAoBjT2LuDcGipP6igzY=;
 b=sHirByVgsjg/UNlp+aA99dUhAldarob+7FxU7XA0funITCPL/eIyN2ZEabal8XJJGAOyrGHtzO4WF0n3YSJpjcjxg73u04/JFkcFejs1F4cbknrmK+wWNHLwY//PxmWckVLiwYb+LMuGrPsymn6VRVGzGQgCU8GROXBwPiKnHxqmKIYOZEs+faaaf0XvDj6+yYRH9RMj18oN4/viWuOoANdS1Qs/nLeJAMzDhzrNrzDsh6Top2MyLWR3zHnkcrA1l7gWlsdVAMrDGx70Tt7xNQOWUhj0zEalZ4PQGuzR3ELKQnV1lHV7igx3WGtBb0bHgjEEV1WFv3EauZ5e6dTGvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8OkJ8SS0WLZ3I0XGusPNS+cAoBjT2LuDcGipP6igzY=;
 b=t1+9j6wDN2mtEBLm7TnnuPw25ASo4gFwC5F9MtaCJrfvkniDH22f5NeD6sEj2UJHjohwqYqN9nf9m4WSqXoYsGrb8p3AgfyZr6y2iWGGThz2FcHsjyiqqgy4tfYu2Ar+vCX51nMlBm1wqsiZo+LUi3jqJtdbv+4WL0p+T5VybJ0=
Received: from BL1PR13CA0428.namprd13.prod.outlook.com (2603:10b6:208:2c3::13)
 by SA1PR12MB6946.namprd12.prod.outlook.com (2603:10b6:806:24d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 20:25:58 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::e1) by BL1PR13CA0428.outlook.office365.com
 (2603:10b6:208:2c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8678.13 via Frontend Transport; Tue,
 29 Apr 2025 20:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 20:25:57 +0000
Received: from asrock-1e715-b03-3.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Apr 2025 15:25:40 -0500
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Victor.Skvortsov@amd.com>, <Ahmad.Rehman@amd.com>,
 <Jeffrey.Chan@amd.com>, <Shravankumar.Gande@amd.com>, <Zhigang.Luo@amd.com>,
 Ellen Pan <yunru.pan@amd.com>, Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH] [PATCH 1/6] drm/amdgpu: Add Runtime Bad Page message
 definitions for VFs
Date: Tue, 29 Apr 2025 16:25:28 -0400
Message-ID: <20250429202528.84158-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|SA1PR12MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: 9496e0d3-ef94-4382-67e0-08dd875c0cb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?47mTRkJ8rR+63XThytV51q2H0cAAD2zYhQj8IlF8WeMlfQm38WKe4ec9GV/m?=
 =?us-ascii?Q?nu+VdNoQy1Ym7GeYIHtXi0RIehxgtF67OVRCDowOJZ5nM3mZhDAHCD/FIYTL?=
 =?us-ascii?Q?+yTh18pXchUgGbpO5CrLCXNp5plQFyW1oTLu9M/8BGXLQ0h2sh6d6iC4BNW8?=
 =?us-ascii?Q?527g//cELYqkG9licx0gB7iYYvss15RxbnwnZ8/x9hf09NFuoIN0jX6tb9Qa?=
 =?us-ascii?Q?G8FlbWqiV+nxDVB3zCpBhp9+fDPpxAuHkZnzQSq+UN972NaMUI6YUVWDN16s?=
 =?us-ascii?Q?jKEYpvfBG6/20tSufSYcSPVKdoniycmal/0j/A7bOXqS6B1kWBNacmFsOc4q?=
 =?us-ascii?Q?ThG8DUinWMNgc2XVr9ssFKk9WqwlTJNSKl20CW0QMjHZCGkOXaAI8Bbb4k8P?=
 =?us-ascii?Q?F59UjGCoqMbMjPYvSUIag1sLbNSmgZ6OZNVrGh8e4Erm9g+WlJvBmq+RUknc?=
 =?us-ascii?Q?SN9eyS9gkaZBdGWplyZbAp3TzHthx+zmqTgjxIKClHBXcyPxRXxbIFjy1vzU?=
 =?us-ascii?Q?FteUHGY1sSkV6jRF6SkxOsOaMWryUV/ttaWA2Q7keWiKt5KhZhiNM2Q/Z5f5?=
 =?us-ascii?Q?DFTzV/qcLz/hVTFNf0SEEgZgbQE4bccrFE3+EVzs6faIEWaF0DFTA2PXF/JU?=
 =?us-ascii?Q?wOOZSNZX1BrjNjtsZnwlCgEdBpEgt5VY5E1z4efn0lr16NzD80Ca9RPGB+Z3?=
 =?us-ascii?Q?NVMnO5eOFPqPNtT80fMu40s8RxICqF/T8RuWPq7esZVzDVfoiyQxHEFlkx8G?=
 =?us-ascii?Q?mzOaJoNWbYefNWYH8XGlLL4VWcrFlGNne2WvTTjy78b9vn4B6LIQFJvmP/Qc?=
 =?us-ascii?Q?5p0x9OHtO6hcHqV6XEJ2EAy1q4MhYjCGomN7z+oP/mF0w6dAeHLwa8pXMS+0?=
 =?us-ascii?Q?BsMPC7jOfZrzmRQ+cCRZ0TG8dLfTurrIpvJf+jhI2o2DlKB7C2DjD9bZGnkE?=
 =?us-ascii?Q?CpEjpq9LlGiTJNdhV40OOa4I0ToOc5315IYCpxH51WdYZ2U9PmrX+YJ/10+N?=
 =?us-ascii?Q?JYGt93AOkskakx7Zt4/hOc1IzvMIlEae1yjRA1CMBkWqDKcXAg6HnpHxyUyP?=
 =?us-ascii?Q?IV3KwHmdy373a9MD6nGTpA9R8kpzNgk9mP3qS3iETORdbBdd5gKDRGNynWgZ?=
 =?us-ascii?Q?4Z3jc9l4B7OQRE3sOQEX9spTyvZSet8fmKRj97HhkVL+Zl52hHxFZELERJQt?=
 =?us-ascii?Q?5Elmi1NGMVa4OZEOvm08W2nMBD3xhYrej77XozSJCgMDxxgyLEr2J2qsJuzY?=
 =?us-ascii?Q?KdtkJe+hw6D6WCW3zYjp3kPKVx0r2RxkyRdCrKdrLGyCr7aJefboK/FKmVBr?=
 =?us-ascii?Q?fbbzXtsUxjAN4SWujvN0P0bmdMd1Px0cWMADLThXKGLtjiew0Hf06OxLfe41?=
 =?us-ascii?Q?m2RWPSnl2KSuEH5A/sI4ouhzWcHYluZX91RYwrP8IeitFCDm1IYWeyKeERR7?=
 =?us-ascii?Q?oCjE47ELp/OnHAOW7AvB0Toyook4jmvKqIHtkL1uVvZiEvuh60avR+W2hCDU?=
 =?us-ascii?Q?Ybt6CcHRWa2RkjPhoQNpuAKF/GEkkZP96mWH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 20:25:57.5815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9496e0d3-ef94-4382-67e0-08dd875c0cb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6946
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

Currently VFs rely on poison consumption interrupt from HW
to kick off the bad page retirement process. Part of this process
includes a VF reset.

This patch adds the following:

1) Host Bad Pages notification message.
2) Guest request bad pages message.

When combined, VFs are able to reserve the pages early, and potentially
avoid future poison consumption that will disrupt user services
from consequent FLR.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index bea724981309..3b0c55f67fe4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -331,6 +331,7 @@ enum amd_sriov_mailbox_request_message {
 	MB_REQ_MSG_RAS_POISON = 202,
 	MB_REQ_RAS_ERROR_COUNT = 203,
 	MB_REQ_RAS_CPER_DUMP = 204,
+	MB_REQ_RAS_BAD_PAGES = 205,
 };
 
 /* mailbox message send from host to guest  */
@@ -348,6 +349,8 @@ enum amd_sriov_mailbox_response_message {
 	MB_RES_MSG_GPU_RMA			= 10,
 	MB_RES_MSG_RAS_ERROR_COUNT_READY	= 11,
 	MB_REQ_RAS_CPER_DUMP_READY		= 14,
+	MB_RES_MSG_RAS_BAD_PAGES_READY		= 15,
+	MB_RES_MSG_RAS_BAD_PAGES_NOTIFICATION	= 16,
 	MB_RES_MSG_TEXT_MESSAGE			= 255
 };
 
-- 
2.34.1

