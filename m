Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3FFC83F26
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB28C10EAE4;
	Fri, 11 Jul 2025 22:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eZGq8Mtg";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EFA310EADD
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3ZykIrj7pbrq0Dua4eQjPMtcsHr816QTg0PgVs/pEyKtRCITcHjUc583rFHTHOI81ktbDhzy4pETmUKb5Hwjdjaz8oIKwIYSZ0yHdLb3+AsZlsqwBV6qIAR0edBGCe2WBFnHugDS1qs25Nt9ubsZIfq6HrJPVY9l81BI5woZ2UWL5HOGQiIiAHviSlhC3HWpMM62VHQDUvuLZZhQSV+A+jHU68qm5LGubdYkGWupjIChvZ5cGioV8hQFrMetAoua46rdMT4RS3F16Hq6oS3mguqxs4O1tCXvelmonkLLhKyjkcRmRPKeShKLfWNrSuR1SuDn80AVsWJ0jRkFa/AWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yh4Dd/h0DsNxKNPqSRStNr2zkiGDqb9BTNMCr9my1Os=;
 b=Np6m2nz/mEL1wGRftLzStMs0PBlm1Zf92BvlCIXs+LuviXLyRpSBB3xoZ3czl+AmnBNPztenhQj5jMpZqa6kDpGhe6hsvYS0ZTJI7oJvlavpojUItaD20DnqtaSTpbmUwcm8xGVSzkBbHJeNTYZPqMiRkbFMZNfKCy64Lwv0+Ro1kKxg7SEl1oxNBmc2VSIGAI0YhIoZIvCj/k3cRvvyhBJsYJbVgoISrRUQgeTAYDFAg3hcL3UUOWQQGyiXSpZwz4TMVPIiPmevImJze89vATtV3S4aTlNlkawjSLfDArgCHG6h9+MJKmeT2Vr38B86rUYe54aLyCcqf2FE9lVyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yh4Dd/h0DsNxKNPqSRStNr2zkiGDqb9BTNMCr9my1Os=;
 b=eZGq8MtgtA8z2znD7A5LJ+fvFz/P8LOlqAxoWE/pHZEgWenhqbuQqfIHH3KHJgbNEPfGPqiIiPmGVoRgfPwKz/g5UUWc0tELozkrUtuw/WO48H+hv1jExw0dqfMnju4MwgybGZyGu+2Vp7xcymnHMfA2/A6FO7SkKka/ONngiSY=
Received: from BYAPR01CA0067.prod.exchangelabs.com (2603:10b6:a03:94::44) by
 SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.29; Fri, 11 Jul 2025 22:40:42 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::b5) by BYAPR01CA0067.outlook.office365.com
 (2603:10b6:a03:94::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 22:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 04/33] drm/amdgpu/jpeg4: add additional ring reset error
 checking
Date: Fri, 11 Jul 2025 18:39:55 -0400
Message-ID: <20250711224024.410506-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba36ce5-856b-4429-4ff4-08ddc0cbf7ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pjApPSSq5vYKTxxZ2dnHxwpCumMscSQdpHp7T/oOQQmwOCzRADbBY//29ohu?=
 =?us-ascii?Q?USWbrYaRvbhpNZgf4DYhV36rBm6yOLLZfjEpz2QtYhOk2XqtIRngNl43i51E?=
 =?us-ascii?Q?Of2T0VmsI1C08ukvS1G93otfp1lVU48t/wcBztgJ7gp0ZKxPl0o4nI7TLntn?=
 =?us-ascii?Q?GjK6pNwBQghM7oHNVYZqkjThZioNQidhCNsTJ88l6lY99o2k2NZeaewtvpqP?=
 =?us-ascii?Q?YRwRH+XfZpGrAtWSMT/qB+gvJ3h00i/yqAFcKF5OvImhJ6pygYbgv94nHP0s?=
 =?us-ascii?Q?uopBU4iUqpntYhm58oGy4vf4T/nT1FUjw0oU2lrgwsY2kFySjaqzdnw5ENSy?=
 =?us-ascii?Q?dF3D85X+L/U2RjXeYT41z6U4xNmaaXBiyq9ofjNsZRiqkK1X+G6Wc30qRJHC?=
 =?us-ascii?Q?/GuHt7GQr3TR/gK4b5SgwNO+8TULkiot5DR1KQvh0QC++AC7VvF9B3NW5W5v?=
 =?us-ascii?Q?Q0bierVjBgldHx0O6k4kSdCOrONUEzGLgpCqalfdUgoLK4aHphwU4VoOtKdf?=
 =?us-ascii?Q?C/aojbG2mEMLKdaQl/azpzuFiH4tBqWRZJpWdHQYTCveJHCSDYOJJwWEIfNB?=
 =?us-ascii?Q?a9coPzwBZ24d4QBm/BLdqLuSc5e0gVcJ7b74hXzbKMgF+bpr0u9p/e3JWJJJ?=
 =?us-ascii?Q?lWZm3smc0MtR9qiK2oYdQkvoA+1ITUJ1Vqe+3j7CMlwpZgFlfIyeSdlJV5I4?=
 =?us-ascii?Q?oGK78plST6ccBq7H9MBIWxzjadp027lb85ODrEINProqjGd1dHBCeoPfdw0k?=
 =?us-ascii?Q?Xmw4zVQU0pgBBDTWg5V5RzCNhq0hIlKCV2YeXkpEQzDIavJEfklv5kiP6CsY?=
 =?us-ascii?Q?daF0EBvH7RZQ2H59rZOrtw0BbZNMLQlbP4CVzJOtlBMXpv06QfQoSoBhN8uJ?=
 =?us-ascii?Q?l+x70JIgkeNO07P6dJKjV2COag9yzNXiOGbHXvB6KIeaBQJKDoiBW1uKMH/S?=
 =?us-ascii?Q?CFK439EAGobzDQXugUywrV/a5HTcbNkXNfp+Q3/v5hDGTeSL7WiWSFOaC9IN?=
 =?us-ascii?Q?3hMe6+Q4E2Je1j7BmDsJ/e1FMA2nusid+lduWVi2RodaXqtqZp/6U9vvN6Yv?=
 =?us-ascii?Q?wzst4sI+2awOWZONFMmcuBU2MukQetpnfmF2rL6kljjFO2XN2g3c+jZNyntE?=
 =?us-ascii?Q?JghbytvBn2e9+3xlY9wfNY26Ampw+yT9nD6GnSuWa0vOBpXdKe77XZMe4p8o?=
 =?us-ascii?Q?D4jmyN26SWwO8V2Oku0Wow9D9qyHsynJTTX/8fDBpoeFHdK28arBTXFxa5Im?=
 =?us-ascii?Q?Y2eRlk8/leaT3k4heFawZ4C3NVzd2SI+/gRVgMp0JYb+dd0iWu+p5mvZycLh?=
 =?us-ascii?Q?kMSEQYLRV+HE/W1SYe9PzEi0OsQAs3KXB7q9pLLuqdLJJJ4Pa82BnyK0IcoE?=
 =?us-ascii?Q?ildzqzU4AP0b8VNajNr5HHQaGyRB+KneysLAAtylWOnzXB4FQETVl+t/t3dS?=
 =?us-ascii?Q?m2lZM7eP3y8ThWdqQiux4h/PzfhsmLJ2L1nZJa0NCCeDid3EohwRiI7UyngZ?=
 =?us-ascii?Q?Bc+b9zoMXQQ4/dnrJmsGkkP5CGssLmZqokXO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:42.5935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba36ce5-856b-4429-4ff4-08ddc0cbf7ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045
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

Start and stop can fail, so add checks.

Fixes: 74894ffc7d0c ("drm/amdgpu: Add ring reset callback for JPEG4_0_0")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 1d4edd77837d0..78fe1924f3cb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -730,8 +730,12 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
 		return -EINVAL;
 
 	drm_sched_wqueue_stop(&ring->sched);
-	jpeg_v4_0_stop(ring->adev);
-	jpeg_v4_0_start(ring->adev);
+	r = jpeg_v4_0_stop(ring->adev);
+	if (r)
+		return r;
+	r = jpeg_v4_0_start(ring->adev);
+	if (r)
+		return r;
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
-- 
2.50.0

