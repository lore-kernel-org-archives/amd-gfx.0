Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EC6CCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 16:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B032D10E949;
	Thu,  6 Nov 2025 16:01:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rLTECznu";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012057.outbound.protection.outlook.com
 [40.93.195.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFF1610E949
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 16:01:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZF1lf4Fq7BWt7qtfk2W0RMiykQfTyf37FJE3jclXn5jxFCniVd8d8SJYZegw2O1WCpBekkIlySH33kyYsxHDIfujyDECjUVod3GREi+yf+SEjnVggIifT9HF4XsD9J3kC3uK5RPkijizs0AZy7KUbgsqioTk7TWFEJqkShJuLHcrKuw+0YSZU8/PJK/DQ0zlipgz417CsM8f6CDmHel0RTdJ5aZbKrLrOkcdcCdUZCBJJFAHcqIJ10cE+L/BF+tbnrQVe2TNZi/SJ2TYcD5OBEguVKG8H+w3J4imRno5LDngROj+5kf+zf6NIdnvkRFShBEd5/80Xt+EyXcVnO4ksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/x+wg5ql5/KH28UUEaVU7baD0mTmMGknpbaj6H71mo=;
 b=ZwI7eJIupjDdUODw214vmcZR7ZchhwcJVHU9QyAAaWRj8wjzVQDDoRBVAwQSRy4gI2u6w5z9acsk8bolRZmzCwet/6xNLr/ohF2VFZEs9EKDQHLYo++WAjwW3ilc6JkQVqqLmoPfnr6dHp4+PEvvqij/YfGT1At1jBNRErAOf1iz3lviwzPjgYkWBz4axWWELDRIaikP9YADqYxhmnlNSeDgYtqJ63yiPAmo9HfLj/w6PbQh//ZmkU7Sz4GPUfRC6SGX3B1qj4qkwjxDUapbD9oytDuGq3r5PgDpMaC1cVISOCM+nPuiJoynKQ1XwWtqzzBfvy/iOGCxihAUXVVyrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/x+wg5ql5/KH28UUEaVU7baD0mTmMGknpbaj6H71mo=;
 b=rLTECznupfC+O2Drz12VltEk+KT+UIpm3G+qljdGNdDd1787nwiKfBXmLl2IVRSVpydp9DErdCYEtj9Z7Fi9M4OAWLSo82CpDkFxTFbwzoaa9gp8Qx8D4uTqWg4UjtMV5PpZ95nAa4v1Y21/R8hq272tcJFpLuKguIvpdJAFW3I=
Received: from BL1P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::13)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 16:01:18 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::ab) by BL1P221CA0025.outlook.office365.com
 (2603:10b6:208:2c5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.10 via Frontend Transport; Thu,
 6 Nov 2025 16:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 16:01:18 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 08:01:15 -0800
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH v2] drm/amd/pm: Add NULL check for power limit
Date: Fri, 7 Nov 2025 00:01:04 +0800
Message-ID: <20251106160104.3784249-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|MN2PR12MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a01df06-cc14-40c5-d328-08de1d4db8f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uun/u3NCzLAgtzRr1vkzJKdhSP4rUKma9pfoJCkuJ6v9CT548XKMBy7tx9aD?=
 =?us-ascii?Q?hrVrzq7uye8kfio9/LvPar9M22she75nyEDYM6uwdS0UGs/XQbvKq9NEC4j7?=
 =?us-ascii?Q?jrJQA8FvE98Qu01+XjZ5L1CyUtE9IPn76cYZ3YtJowR9EvzibI46CnP+r3C6?=
 =?us-ascii?Q?GTLFNnmUYshXAOp+spFjRfFLM5lIx5h3n/O4HhDRmEsTg9k7Ir/nJXyPxvzl?=
 =?us-ascii?Q?zzN9vGFZ3kHsWjjBbF+HrVyhRy/3eG9q1ok9nmCsgNpY8Iar3QYYwE6hXSTG?=
 =?us-ascii?Q?Up/6+CEfwKezGykEBwZhbpWCnd7RERkJCrdd/ZfF+Riv6+z9mk0zKsglVzS2?=
 =?us-ascii?Q?zJbMwANUuxPdjan6R68yhGe38qbx3NF3Frnmo+w1hSRwdJRq9XuDOhovTLA4?=
 =?us-ascii?Q?XvtUHZIIiq2jlkAUSRIzC9jp0BfLkWtF1iWCEUlxlGM0cKhmRA1nWBHKpG0O?=
 =?us-ascii?Q?fxx/BiiLESTt4YjdFUdfY1Lh6kY+Mtrg6jYHS57HUcc7MOKg0mEsLeU8bh6L?=
 =?us-ascii?Q?FiD/Y/+J4rbAbhkh90aY6TrCKr1FWYoMkV4k1oJxfYfPBMX+jV1rhULaq+OF?=
 =?us-ascii?Q?rv+XYqiNS3P4m+8UTd3DGJgwaL8jJdO3x3fhrlaPSs+xmqiSfNqnqzK/2AUS?=
 =?us-ascii?Q?ceww880VMnNloKgeTYoSAwKfeATwwr0q2h4Vp+D3Mv+bGdzJq0hFhH3Qh8Ip?=
 =?us-ascii?Q?5M1xI8uWgPS/SaKlC8qntr7TrZUN80cX/3nt267BzSuHQMls/p3Vix0f4kaU?=
 =?us-ascii?Q?QpMNi/+P+GLxNbnha9ZWnAvOtrtnIXstquW7fJDrSDl1m+lZkkLn62H4S+vd?=
 =?us-ascii?Q?nmSCDys41hbrnry7Qy5JyGjNuZV6QXeIK7n7MtCSSBmIGNaS+7s0ZQOdvC2Y?=
 =?us-ascii?Q?3Dc2QPqJ+DpS7ZobeKQe0sFBgk5/4Sxgf4/eK+Nhvpn2VUWK7ornuJsaG47W?=
 =?us-ascii?Q?kvMxViMEqtfLIyN9oB2q1+z1GsxqnLfj7FY50HssosroTd5RhisbXOHswKxG?=
 =?us-ascii?Q?PDanjP970onD3FZqIJ5XuTVLEjfyP6S8jzMqD6Eo46nR3PyF6DGD9xdXcFc7?=
 =?us-ascii?Q?0AiFRabTLupJq/OLtSeqcTpHEW3IiXKmRrtHp1+F5I/b15l/XiYie3k9CXPj?=
 =?us-ascii?Q?f+4Zpn4DpmJ7WxVdawkPf9V1fvJ9cW2GCJ57R0badXeH6h94h38y6w42fxKH?=
 =?us-ascii?Q?/lbOBBQiJCGLAA9a08L+HMJCoG8EJRC1P0bSb22LkFtHVab0uML0bA3kpzg3?=
 =?us-ascii?Q?7Hqlsm91VtgNRGdtXqhXKtV+VF8Qun+/JmYEl92/yTzjUCQv3LLL51EoYtME?=
 =?us-ascii?Q?o794yMNvP2P40ngPxqM6oWhixBrgfAjEotUVsYriS/dIRVUrBnZMOPw+LVjx?=
 =?us-ascii?Q?R3eInf5ernGNvWQDrNZuZq0ggFKPW8F3XTNuH/qiX3CqFNAezeYgCrQhgiTy?=
 =?us-ascii?Q?JYsPintjaXEYsT1GsynTJPuJFqrLI/3ALiAqhiqlKps+Y3a+ZS2jSzJEuybh?=
 =?us-ascii?Q?gCn2qoveIU3lAI1MIG89MwJPIieLSrc5w1quELh7r7qm1CeaO3uiMBIZ/zMz?=
 =?us-ascii?Q?S/pisexlYb7Jf+JmP5o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 16:01:18.5210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a01df06-cc14-40c5-d328-08de1d4db8f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
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

Add NULL check for smu power limit pointer

v2: Update error code on failure (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8b49fb86c77b..4a2c3ad0c38a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2907,6 +2907,9 @@ int smu_get_power_limit(void *handle,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
+	if  (!limit)
+		return -EINVAL;
+
 	switch (pp_power_type) {
 	case PP_PWR_TYPE_SUSTAINED:
 		limit_type = SMU_DEFAULT_PPT_LIMIT;
-- 
2.46.0

