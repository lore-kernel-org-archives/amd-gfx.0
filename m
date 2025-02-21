Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92C9C021B5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82D3910E21E;
	Fri, 21 Feb 2025 15:33:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z3VtQRCp";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50BAE10E21E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVi5WwTsQis9p0rjsiMgsnmgd9XrMBBHOq/kULeh1cKYsInW9Qxj6y3/ENvm27M+5e+2TFuaBP3L6dk9LwYRyCGyWnIe1iBW43dfPa6E3NPZz2Mp7SM7trOD538zTzbwnLQmhLGaSZgq8SJaYDdqeDcc1/xFQI/JaxMwbvwZzRwHi/SVkPYV4wXUtAGbbnGBC7QeUy44uGB5XRElv0yhHgmS3cGmpWwZ69P/dKUbxBXB8GCkff+pHR1CS2AZpHsu2fVKOAoMj/UG5Gx4pxDce0Shgd+ORHaOsT3pGInSFdwnh0Se8fw1n39pukPW1GsvY2SHLlX7VUQMFKDWJSHGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MM8JW8YeJhE5kqRouJgVVfDqdSTrn358Kv+um8RbW6g=;
 b=Fdn4z1KJmRmbYGJBrQ159bKBOnYWhkpCU25inrOdXggWO61HloSDROoRUjGNAGtBFfM6ub4dF88vV9hhIE+YjrIyWDjarupE6RLRn+HQR6fL5xynuAfJ/fCEr+mdukH71NABvCbstHomh397NxWWdE3+4cmCejuEO0h++KLYbKKbzQYsxT3q5eFJohSwQrbnE175q5FuDfgwjov+JveZfYE03YQ2lqcUzLoqdv/n8yzJhxV8ToUSiZSkTisafYKxzxv/BepP7rsZQMkHmsts4kRvOSx3mVECmfRoWIkyOMJlXdBndq+1wbpmked9pgz7q/901HlzK7fhDKXrOKgMrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MM8JW8YeJhE5kqRouJgVVfDqdSTrn358Kv+um8RbW6g=;
 b=Z3VtQRCpylyKmLeUutA6B8HkJV2LDnuFm5mOvD6FLz/UF+5tXY6oB+WgPAwWpT0igb8+ryBldVYkiSBbA9FAyRNXmovSwGgg0zANeO54Wmrmeagoi9ZATEZTZiJNW1PQ3aX8Dchgj9TP1oqorjWZb5fwTvCXOrHJ5TNjwE391vQ=
Received: from PH3PEPF000040A2.namprd05.prod.outlook.com (2603:10b6:518:1::56)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.17; Fri, 21 Feb 2025 15:33:15 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2a01:111:f403:c902::13) by PH3PEPF000040A2.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 15:33:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Fri, 21 Feb 2025 15:33:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:33:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu/job: move fix is_guilty logic change
Date: Fri, 21 Feb 2025 10:32:47 -0500
Message-ID: <20250221153247.3499295-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f019cbf-547e-4c6b-2131-08dd528d0f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PLolfxqvC+JRI+wBdWbkhivcLYDjJTYA4WuU6sw7UwLJsyjALgSJcyw18FBn?=
 =?us-ascii?Q?i2buH9cFkQIlhS18f830s8QaWmCP5e+KmlooGNJLjBbmprMi9eikuvj2U5tS?=
 =?us-ascii?Q?LszGTMkbudmXPGwxCuSF1ZwEx/P2w0gV7kecdcRjofnSSY9SJotcp1Xu9Rcn?=
 =?us-ascii?Q?ktYReag/EqcMpxF9BZyFgpkGdRLrllldhh67JY41lwjfFvhFS6NYhRl2uii8?=
 =?us-ascii?Q?0WsKs8k6BXSqbVUgnpYpnEApQAiFTQvJAsvm/lw7CfYVd9335U6u/akf4px5?=
 =?us-ascii?Q?YkUunqH9gqKOqSc7Th2tOuJiswLyclRG9u7ztPETl5+6z41m8wvXXnL5OtKd?=
 =?us-ascii?Q?xOw9k9M22HrSJ1SckxMzgN2Nx1XDl+28/IK32e1QqPNUlfdoiiikjJ4gSr5P?=
 =?us-ascii?Q?6ciBXe+SH05/jlT8G1PXJmceQlSZSb7J4mawl7SQmUbqaELY9ucwWlv2gBS4?=
 =?us-ascii?Q?bysPieMlLBxA2gO5KUpOAdhH6m/wBAgjHTyJ9nCZHEwfJ5dZ8hDUYa/jFP7e?=
 =?us-ascii?Q?dytzJRJmgDA+RbRnCNQeVqIZWhU2HQP7DPI04CWqj1Z7A+QL3pfxZ9I1uQrt?=
 =?us-ascii?Q?V8lZIgvj+MvJUvO6nGA0QcehLm9rDRSpe/ygNsG78Ss/AXWFtDxdNdIaO2uE?=
 =?us-ascii?Q?4VqhDwGi3M59MMMW4MjoRi3tFlC6zY2tOB6rBuzXRHCMjR0UPO3Ly8k89ohO?=
 =?us-ascii?Q?I+Bqe7GBbK2NcurF/qTHTKvlvcnO5EMtDAKkqGAWRAgiLI7cQEj3rWENtLe1?=
 =?us-ascii?Q?CrboAATQ16KpwOo2lLzx1CgcZxHdgRVvh2OKmk7cmyUR7aPoxSwhtbEyJ7mF?=
 =?us-ascii?Q?iCR4c9efFW5twRrv/M07xa6lgKm6vIOid/QtV8oGw8qz8faqDAojFzBIn6mw?=
 =?us-ascii?Q?wl1XBK9v8BHmbWWt1AL4qjwknG/QVzZvZxAVrWplhc3ks5fIXVOFfF4xRffZ?=
 =?us-ascii?Q?RrUW+vik8MKn+cEIMMmwSA3a8+8CnFrtAivFO0F+Y76OEB+XVxENsJjvKhdg?=
 =?us-ascii?Q?+9vgmVs5/v9wg7D+JhD4634e0GP2peRHFy1slPsArIbUh52mslUVEwR6mZZ5?=
 =?us-ascii?Q?6e/In5hXjVTH6eh/SrqY1h+1S5zhFOwUTW4tNJxRUC8QsJ+AQ6jEKyXqZeVZ?=
 =?us-ascii?Q?9QhiO+XxwnlViAC/OEq2uNI0iFGcaSAB2B7ftL5EacTCyyARfQY9BcDJQ2cX?=
 =?us-ascii?Q?dR/63PfXYL5naC9WOdq6+VYJwgpnOtyKLY4oT8XPIqMlu0K6iytjwcEAhheG?=
 =?us-ascii?Q?tJrYTS2IOtMb5tir52qtK37O1PapFKMdiYP8lhJFDfYigs8ZNgMH9VuCsJH6?=
 =?us-ascii?Q?/QzbVKksslH5JMT3OM/Nu6SGfms/bto8neaGFWOrzX5uf9l6RJP4oFLAyePf?=
 =?us-ascii?Q?V/r1O5Xm21RDWjjgaXVtsXzgUWPrVSoe0z+dG6KcswazebJwDxmpDJtyxJJS?=
 =?us-ascii?Q?dB7phQ3TtSzkVuVcF9at8yVb+O/Q6j6DOWnM6DyTgI94aKT/6LyakJqTrsej?=
 =?us-ascii?Q?tGkLY7q76IpR2JA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:33:15.3635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f019cbf-547e-4c6b-2131-08dd528d0f33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485
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

Incrementing the gpu_reset counter needs to be
in the is_guilty block.

Fixes: f447ba2bbd48 ("drm/amdgpu: Update amdgpu_job_timedout to check if the ring is guilty")
Cc: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index efba509e2b5d1..a82119b551dc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -155,8 +155,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		if (!r) {
 			if (amdgpu_ring_sched_ready(ring))
 				drm_sched_stop(&ring->sched, s_job);
-			atomic_inc(&ring->adev->gpu_reset_counter);
 			if (is_guilty) {
+				atomic_inc(&ring->adev->gpu_reset_counter);
 				amdgpu_fence_driver_force_completion(ring);
 				dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 			}
-- 
2.48.1

