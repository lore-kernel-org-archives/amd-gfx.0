Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A084CE8D4C
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 05:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 986B510E0BE;
	Thu, 19 Sep 2024 05:54:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a0VtSJnk";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9530510E0BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 05:54:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhF9RWiJR6mimgcv7jCj5MUEN29D3vyE2zoJ98j87FWVMcNMBxd6q5SQ+s2ePAemUS0GRjAmWMBVfz15IsRACBaQvz27Z0KnQ8/Vm4b+KYxcJOe/IaDrCC8zbjk/W3kuRPBwSwHu75JB+dmgyjhZa8971XgC6ICQTrALtuhPqjzGNcaeE0mSc1XYsLDJWsuvNG0aoJV2/bW13iLBycs68Au1WZW70fxv85R3H8KBJzC4Y6dPvy+dt3mT+ZvLN3eC8qWDhbJhzDMxp47KEpdCmnxga7rxMz6MrSgcKi5ms2kgbGY7X4Sit2ASAyW4sORjbhxYtJNXlqDVnAyqQjV+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vtW3EiqRLul/kvbcjoUlfJleYKVrFO3iiZCNyedBNs=;
 b=jBgnTCndtbyv2WGJXOJ8z8rEb8AH9rKzdiP/a4Sizs9MPU/urv/IHt9l0sA25nRaCpeluBybq/qOEr1q6epl9sHDR+Q0efAAf89qjhj908KPSTqxR6zicmX//g7j6uJh6srT3SfRhdh1zyy+k+79fbkO3LfwdB7QMHwcmdPeJ4TSg9rbeaQe4oBV+TnDTfmP+2SkcfqWgF2Ig/dok5wf0EeyvVt1pNxfVwYGxIXkMYvVAG7UVHjJwSjUJXK1jEAcS2c3C/com1lY8ZP/74wY9IntDVHa6WwEZNARNWDf9fSlaTg1uprslenS6oZZs3ncF6wokN5T0vYwksDKnlIB9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vtW3EiqRLul/kvbcjoUlfJleYKVrFO3iiZCNyedBNs=;
 b=a0VtSJnkxthwyJwhcvsnR9HWh62qpaWyyhzPY1j4E4zPu44qlieCRbcbhJHCNDkcJwmtDgwsAZ9b6EpJ2Fm4rAbDsmxkqUDwObCSn/rcpg78l7RhLZiPKuEpcMVeuJNfaRdk3BCJ8yXZ6MBL/p72FuWVEpSnDkAfrYexxs5FqSQ=
Received: from BL1PR13CA0433.namprd13.prod.outlook.com (2603:10b6:208:2c3::18)
 by DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Thu, 19 Sep
 2024 05:54:00 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:2c3:cafe::fa) by BL1PR13CA0433.outlook.office365.com
 (2603:10b6:208:2c3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 19 Sep 2024 05:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 05:54:00 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 00:53:57 -0500
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <jingwen.chen@amd.com>, <lin.cao@amd.com>,
 ZhenGuo Yin <zhenguo.yin@amd.com>
Subject: [PATCH] drm/amdgpu: skip coredump after job timeout in SRIOV
Date: Thu, 19 Sep 2024 13:53:43 +0800
Message-ID: <20240919055343.112601-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|DS7PR12MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b751c4-3c7f-47e2-5b3c-08dcd86f758d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rz8CgBqDZtNddHEm3xeUu0cwPk6a5elpllZdJ1wuKnpsmQMIInAm+LhE36Wq?=
 =?us-ascii?Q?jk/tdyT1b6FhcZkAYxNZeoWI3y2nxU+6SGhRG7ne+8/XX32UAwMc3tvlqcyv?=
 =?us-ascii?Q?cdspodxQZHhYT3ZwDCb09F66K/g+uJoQuH00GUS/e+EN/QxhtBmsPLkuiKZY?=
 =?us-ascii?Q?pnzHLU/8Ceoxm4yCuNiOnp8hCX0/sLwv2QFK7Fvq5Nn3qSEFs/Cch8HaLQB3?=
 =?us-ascii?Q?jVZYIab7uLYnt3yoWFElVCllBEmC1rUiQlzGy0zb/E4AKF9dMN1Yo3ytV9Nk?=
 =?us-ascii?Q?IkQhS4nrkkqPPGcaVlyG8TKuCR+uCow2o1CdF0/EowcLBuNt1664Mp22s0xm?=
 =?us-ascii?Q?pTY0NyvqUdi/oskD6EfEW6f5kU4nDoggmVbKBWr184M3QlchktNKkBBqJa34?=
 =?us-ascii?Q?tesJmuc3YT6ZgkQzFV81NjLCSudFxnV2iwnIxCyzgIL0jUnEeLwmFKrlznk+?=
 =?us-ascii?Q?lyChqfXPvsTlyTFrdiApojw5UY2WOzSayY5szBwYgmLQx5rqjHQruqQAofnh?=
 =?us-ascii?Q?kyu84XL73N99U2BwD2Xr99TkjeFwF4py4fX1WfqpG0OvBbdoLzxFFDisY0g7?=
 =?us-ascii?Q?umkZKpDQvUbGCU3iQI8OxDgILvgR4oKTGfLavVjqtQGkVQzO2zeuCbuqGqEG?=
 =?us-ascii?Q?d57cFAO6iB5EQy54U4lYJp3vEcr71RAoWP2keSW7h8T3t+s8ok82/sYCsK+x?=
 =?us-ascii?Q?VzdFyAUlXgtV1+AibnPjpkByhF2DPMd4mlacsyjruIc5UI+4duRGRUMnI6w1?=
 =?us-ascii?Q?RPn6H4VuRFmAt588AmCMHSO4oGWbDEK7wTlg84abSgK+IS+MwIwbtfuFhhwr?=
 =?us-ascii?Q?gon6YAg/jkKeYVwuqLYBmXv/r9vve7Y2mjFKt88zdgOYF+0a3LX5yr6FRlp2?=
 =?us-ascii?Q?zeTdr5zOkp9obGtvwJZPt49kuiGSVuV8VDkec9BhXrJDec005RUe+RojlPEX?=
 =?us-ascii?Q?8o3n8nGNCoahUOO0bJlaLbNaMB/8rp/NkGzx0hXtJohD2T7l8p5ip88UONl2?=
 =?us-ascii?Q?B6+aWfbGrxKhGbLcPl3K9ISWDEwbGzhae2CJYs+kQTSJuQezrIr30BfF3rxM?=
 =?us-ascii?Q?dZ5qvLXEjbrz9RTM0+pNMRx1RqPfNLhhn09g2v0Q/h42hwzqFLjzEbEcp8PS?=
 =?us-ascii?Q?MjXSX59lPIYW2dUP2mGqSX+4COmcN9ztkXjsam5zOlmKoenef1JhnQJNH5Go?=
 =?us-ascii?Q?W9ttmh3970LQkSfzznwhWXSTuNdl4y8u0RiJbMEOiPBrCVYFVdnp479+VcXQ?=
 =?us-ascii?Q?VVyTdhaubiDMvZSXa+4098cjJ+3IGOEPTFHh6LSN6HJ6b2dB/y8xC+/hn+rE?=
 =?us-ascii?Q?KS23jB+DcAEwt/OgVJevHQSjkjJ3px5XVrh86On4sMhYLGgOo8C2rOxWnb+1?=
 =?us-ascii?Q?8zcUs9euP/sZLTrFx7yWHt8mCTAcyuQQ2TETgCHEw7e4dnjXsUnWS+Z3XjWq?=
 =?us-ascii?Q?dBaqwmx8294=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 05:54:00.2435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b751c4-3c7f-47e2-5b3c-08dcd86f758d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292
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

VF FLR will be triggered by host driver before job timeout,
hence the error status of GPU get cleared. Performing a
coredump here is unnecessary.

Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 381c886298bf..13a3604cf107 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -107,8 +107,11 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	/*
 	 * Do the coredump immediately after a job timeout to get a very
 	 * close dump/snapshot/representation of GPU's current error status
+	 * Skip it for SRIOV, since VF FLR will be triggered by host driver
+	 * before job timeout
 	 */
-	amdgpu_job_core_dump(adev, job);
+	if (!amdgpu_sriov_vf(adev))
+		amdgpu_job_core_dump(adev, job);
 
 	if (amdgpu_gpu_recovery &&
 	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
-- 
2.35.1

