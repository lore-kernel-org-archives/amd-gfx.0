Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E26CC54E68
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 12:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58CE510E8D3;
	Thu, 21 Mar 2024 12:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YA+AGE1K";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 509B810E8D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 12:36:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IE1+vzQ+mdbGj8yLeuG9JumXWI0EnBnoRQ9k3f4t9SYZpwQAbMXf6WC0CsLuQd2R0hG6JCglfP/gYLQ7mqjUSUiWbufMLPkrQYmZvT7wQjy77IKGgZmGvD0oHZqQ7ET1PCckSi6muNYsxSCM8dVVF/7/EwUSiLHJTteVtQuFaUM8L2e1SxFoYxFNZPW8labJgcfgav2aIvAZKTr7DH7b+v2BLOP/dogGVX846zoAPRMcIl+3WXH/2BuY9WA9UXJbQ/Tdj5Xz3Baivc3nAdNDlNCyyWRxZAZ/YaD4q5fDukF/MHLn/vmVPqcQQh+9T7ohKoraeHVAoplFWjAlInq4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvZqOYQkk/sQAMwbc7B8ZjhkftrufBmCWuJsSKLGMkU=;
 b=TKRx7MPIaf5xGXfaMtcAk91sL4rtP1ISl2dFlbPcWNTX5HTDxZiOa35y+Ko2ABroydS2/NTNNWQucxH3bhGKcA0cPUaeC8heUlhjU5V31XyWQFMI7oF/SN90qZl30CDKZADB8655dQaDg4aakChUc0OkK3edCVvaUU1ceqLucRvx0QlRp2aqHqRl8tPtde18QSDzrHKcaU1JWEru1jIV+1+X4ORW/yYjC1qsgcHCyoxKNXqalrYQL+F90V5B64wutCKhum9Jbby7ErS+gFJHoLpU/oelYzlbUKRuQH+e3wanDryOARKDTCIk4vDssmlkdaLypQDkrjmidj84zVnvXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvZqOYQkk/sQAMwbc7B8ZjhkftrufBmCWuJsSKLGMkU=;
 b=YA+AGE1Kd2Yk9yT6Y/6zLLvib1hs4YKzcf1oxf711M5GZFJ5nBSq03jaM+MQgyeVYPbFso49QmPx8VcwlbfvxuY4I8NAnCAcj9Ra8ZBXAryNlNZRzve+D/uPBHjI75w/9Go8838+TBqBxgAyX0oWImDXKc3N9mnBIvYBn+Ye2kI=
Received: from MN2PR01CA0055.prod.exchangelabs.com (2603:10b6:208:23f::24) by
 IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Thu, 21 Mar
 2024 12:36:25 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::6) by MN2PR01CA0055.outlook.office365.com
 (2603:10b6:208:23f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Thu, 21 Mar 2024 12:36:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 12:36:25 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Mar
 2024 07:36:22 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Refine IB schedule error logging
Date: Thu, 21 Mar 2024 18:06:06 +0530
Message-ID: <20240321123606.764092-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|IA1PR12MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca27030-a1e2-4f31-06e7-08dc49a385ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0R7YZVed4NLt5gkMhZDOR8ZyO3Hmsjj+QghaT45lI1S6b8aUcSZO2GMUF/JY8KB6QHbFPstq5oOs8LlahGMuUKFLtPa4vu7Oshly5Ik0nKWDDUFma/oUyHvLXcaXN3ajSY0E5C+ZrUHhfpcsyx+IaFC3ShX4wXMd37RJO9XNmrKPb/iMWQwbuic67E32W1XiiIWr/ir3f8EURaJ7go7G3eZBGF22WktKoEmrIW0lRmS6u+1L7pKBK5WUvTJ3bgSUDsyFoe1r/2EDbr99nRET71Gn0YL62psSSVp6MXhNoT6zKXacpKiofsLGIpvOA2NCUjydL7YEvAfJ0rCfDVoA5tZ033Gt3SDuLNHWGvk6YJl7z1tzr0a1/Yvoe+JRLxuXnghsk2EpPwuhShyuL35Ca0ZIsMCj7IYIjkv6wh9CIAa0HUJ3p3I66kIAMwmKEA8FpteY4I1NydnI5OdqpJPabYz5RWi7R9C2calurhFQU8qtueYUY61LrtBR5Dg7wl9wJDT9cSPJOxec6itRVzprLia0iG6sWvoCO0IWuWIXs8TAsr9RY9ttxYqBcSXHpWRwAdPrGpMk2gcIhZnAuGDey13vWOZJYsR6U3dgdRwbpL2qWaoAcEZDOhfRSGOgHZuZRKcYPUEwYFTe+1H7bzDnWY7IPLw+tXb1NuaTBeFHOnACa+6H+ytVl4/CUn7Jsp1uYht8hxbFt8fNEWaC2YkppZUPSHPYqaDxEt2xo4ZUAYqRP6UcrB/LkuJfeI3aEYuX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 12:36:25.4659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca27030-a1e2-4f31-06e7-08dc49a385ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494
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

Downgrade to debug information when IBs are skipped. Also, use dev_* to
identify the device.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 4b3000c21ef2..e4742b65032d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -304,12 +304,15 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 		dma_fence_set_error(finished, -ECANCELED);
 
 	if (finished->error < 0) {
-		DRM_INFO("Skip scheduling IBs!\n");
+		dev_dbg(adev->dev, "Skip scheduling IBs in ring(%s)",
+			ring->name);
 	} else {
 		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
 				       &fence);
 		if (r)
-			DRM_ERROR("Error scheduling IBs (%d)\n", r);
+			dev_err(adev->dev,
+				"Error scheduling IBs (%d) in ring(%s)", r,
+				ring->name);
 	}
 
 	job->job_run_counter++;
-- 
2.25.1

