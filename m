Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04686C982D8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 16:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8641A10E8DC;
	Fri, 16 Jan 2026 16:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iqAILNHa";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2169410E8DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 16:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPZO7C4k359jkK0GLS7eU1vW3I+1N8GUgtauO4xlBxMlMdQDL3byOUoWt2QjlOrHLOA9IWIpPcBeMu8dd4JIRFLfLvqr3RUv1xoHhpu23Xocq1mLWDgPHY+3bfZ9/qAFBNK42XixgGplsb803OnXwlaXgwGeKXYeujnq99F3Swg5vOpeqmEWcHZhESTKkrilqOmTDkhMNQU3A7ucqsFeEwH+way3u1aIAHl2/qym60ElgQA7wBx3ZUFEPqZbQvDtvvu2kWTK5rH2exhJaoUfXKWKvERLWSH0iJ2bQ47dcuVreEWg4OReSWcOEtyoiiuGfKOCC7zOrae5c5HKklgARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekfZ7ANgHS/CCILvk3YLNg3pLFtnsehSCUvNAQNNXEk=;
 b=xFjRwVK/GRtgyWw1Tnl99ycnC5z4wMEhPK6OUwAIU0mVg6WumruXFZ8bBNizoVYddXQ/6E5kmdLwYLaX+FA2ysY7XHACE7lAiXW6olWjtD81drJ6jNkGCwaSgq1RoP8KG/COcuFeSEIb8SCweLqQqisKx/tYTQTH17gqfGdfAfWG3KtCDXZ2dk1RUL2Vf16Mw+aKXu2fav1eow8NJ4SRmhB1CAqoxEn+pFmWKPGZE6KZgS/biQRwcCZ7dQhPBr6KFUVzFg/D5UtVE5Jhheb52NMD3qAAT0k1FJwhb+rFNuznE/Fy1LIzCNj8YC6ZWyWh51n9hLp4HnmDfUyoI9yaNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekfZ7ANgHS/CCILvk3YLNg3pLFtnsehSCUvNAQNNXEk=;
 b=iqAILNHa3vC2G87fPB0CeVhpq2SOm2cf8aaBlUQvvZDR4g2Z+fYw1SPa62kXdJsT2yP9mCq9sa7hU06p+m3nEA7y9UgJ8FJdy+DIVVBkX3JyFXhwEj6aaJnlgDgtV0FV4DnUfp4j+2XgD23p78zfPwkgo2ZYa6AZrJyqXQgGHU0=
Received: from BL1PR13CA0351.namprd13.prod.outlook.com (2603:10b6:208:2c6::26)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 16:20:47 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:2c6:cafe::4b) by BL1PR13CA0351.outlook.office365.com
 (2603:10b6:208:2c6::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Fri,
 16 Jan 2026 16:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 16:20:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 10:20:43 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 10:20:43 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 16 Jan 2026 10:20:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/10] drm/amdgpu: don't call drm_sched_stop/start() in asic
 reset
Date: Fri, 16 Jan 2026 11:20:23 -0500
Message-ID: <20260116162027.21550-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116162027.21550-1-alexander.deucher@amd.com>
References: <20260116162027.21550-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 611c75a6-4ef9-4ac9-ded1-08de551b339b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lv8kNH2agXKV3l6DbfQiSfwnCMoorOWwTdI0OjWPXO6XChZC+HtM0ZU0fThZ?=
 =?us-ascii?Q?fOcg2H4n9fgGgnXrYyTQP2yBKc74ifXgJ2wu8OEh928B5cS4YunCf8AD+J0J?=
 =?us-ascii?Q?ajyFBmv03Ay/uFUnnCUROlgoNNHVcVALrDlbyQULXE1QVxV0I3cS8migiA0J?=
 =?us-ascii?Q?y+GGQKMt99GakDA1D6MKcEjhFtsWE+ZUn8ImHQWNcNtEStz5OeZ/DWJkYh+w?=
 =?us-ascii?Q?AcMsEM68YApVEb90wy4H3R928cYNRH/p9L7Z8zY65xcqivpFh0XJQuGdqtsH?=
 =?us-ascii?Q?SUJBn3/4VopqyWNjT+aopWT7bLYj10wDDfFDUNmfiz1oVlGPa4+V8jCqQh/V?=
 =?us-ascii?Q?lgYjtIBvyEHeuCSQhkxmUpIBRi/2goPsw+OBoWhp1j/7GPoayTTKjieQ5U2e?=
 =?us-ascii?Q?zLPPODBUe3Lf49Aun8O+pCstrWyKwZQN9D1L/jqqgVwK0mhMBb1qH/OLCBva?=
 =?us-ascii?Q?NCU3GOe7RMGxopZp6cu0KKV7DIwXfqRekB5WPQGNvUDyPp5kdyAdfN+mYWUv?=
 =?us-ascii?Q?WS4gfJdDE4S9t7sDKJw0i7F2npK7TlVUFOZ1zk/r0oOL+er6L1AjFDD1ysqi?=
 =?us-ascii?Q?0S8prmNxaorlb+Q2NZAUokNrPtE2c4izwEhJJ5m0cfqRRbu48pVoKH8ya7eZ?=
 =?us-ascii?Q?pjR6G83DoAzOPf2OsZ6GtfY/gkRd01vdTNOmwI2ZkFtX2RVZzTTI1hPKgHZx?=
 =?us-ascii?Q?98Qc1qUCYo8GSbkDURu3c44M/++Bd1FGjf1pFWNqJHEKtEOPwu0WNwaAW4WN?=
 =?us-ascii?Q?874c2AsibaOl41xFDNI/wzLHkLXsEHSOW7Li9aA6mjnPcunurCEUzruBHHsG?=
 =?us-ascii?Q?zL1fTeYBpSRBATBYs42Gx9ooc5PcNwsRjMYXd7ZXRaRastYbiyDoPE+i3cpn?=
 =?us-ascii?Q?aW32ui2N1yLwYMngnIEhibVh/WtAaLZw9Ipm9aoqSnq3RnSVF4fcih/HJG/A?=
 =?us-ascii?Q?0qEn0wJmxUeEkndrH2sNwVb6/NlWZ0sEdifAxwbETeTUrhUTUlZaSzQmdTlb?=
 =?us-ascii?Q?kHKHcrKDFFuDtCQpzKzi46t9DQNI1HOmMFter964cZp1WdNVXgVN9wPfZ3ym?=
 =?us-ascii?Q?UkFu7SEffeGSC5/boeQg/C9OUGWufjn7K1VP7YA4XiPYTDkCZ909PJOSBjgl?=
 =?us-ascii?Q?94TVR+FRFWUmpSKsGRZJlSI6NNKirvY+loo11t0SfkYOFiqMloBBYQfSzHXz?=
 =?us-ascii?Q?icA+RUVRU5XoHrYrFN2/9vBmZ78j19AhVMn5dTnf/OajpeHotHEux2s8XZa9?=
 =?us-ascii?Q?MZPJFP9ojCBzj6ozdEV+pFNtDyunq187vxSJLZzYOgqoaEegjZyuNdyrGIVN?=
 =?us-ascii?Q?Y54rgUZWVUn6J84VPPt7F1QS6088eRsLxWKHWnPIm3qijANujClBFciXdMOa?=
 =?us-ascii?Q?/5E2EXUQkjVHJx0D1331LKYdJCXDHGOmuXu1iQLO2n0DduzYjRDXE6WfYHIJ?=
 =?us-ascii?Q?8wMyQbwAdBm41fQkSo8ec4/vBnlDTPp1L2qDs7+LVg3kNPR4kU+Fv5ZMfpaV?=
 =?us-ascii?Q?7PZYmkkg3Yl7KZ/984nG4e0USzyRWq0ZKF6/jIA5M+dzhA3KQ7v2E5+AFtsu?=
 =?us-ascii?Q?43EP06URGdIRT7gWAOgHITurjkDKPvlXREu9+m13U/5oNMLg/Coo+mOsoIRX?=
 =?us-ascii?Q?7S7M7uAtYQuoJeSKF/f8Blu0s6/wyGniQ9COvcjKUCeJj5anuGGmUEsKZc+5?=
 =?us-ascii?Q?rUPrkg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 16:20:45.1071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 611c75a6-4ef9-4ac9-ded1-08de551b339b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778
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

We only want to stop the work queues, not mess with the
pending list so just stop the work queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 362ab2b344984..ed7f13752f462 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6310,7 +6310,7 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 			if (!amdgpu_ring_sched_ready(ring))
 				continue;
 
-			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
+			drm_sched_wqueue_stop(&ring->sched);
 
 			if (need_emergency_restart)
 				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
@@ -6394,7 +6394,7 @@ static int amdgpu_device_sched_resume(struct list_head *device_list,
 			if (!amdgpu_ring_sched_ready(ring))
 				continue;
 
-			drm_sched_start(&ring->sched, 0);
+			drm_sched_wqueue_start(&ring->sched);
 		}
 
 		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled)
-- 
2.52.0

