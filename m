Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9ACD73E89
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 20:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F10EA10E315;
	Thu, 29 Jan 2026 20:38:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F+wucRdX";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010019.outbound.protection.outlook.com
 [52.101.193.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73D4110E07A
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 20:37:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gH/Sjm/uM1M0oRwSi3WSFZE9QyYSIcnx3gQickYXqXeO/fpoF5J0Wfpso0UN0adiMtOjvV84/KTgvz+x0st9fmqsHbT7/3KJMUwtezOz8W/R9eez3anabZf0bGerp+46eBwDcqHX+etmkevvvoXmZ8vHXd4IUhYtckPmn6E2tb0KNP1Jao2sPR8nD1nKjIJVEJsHOJoeDX2pNvPSoTZn8HsHqG5ns8Bp1mtmpuMebxSKJtMTAXTEsgz56HLDMZ2TqpcWkEBWkIx/ap9xYN7yoHD4KpXNVATAwVC32M0KzWFVP4AQvK3PLqqtKIsaIGjjwtgGlVCg7O2QOsGTc+tYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Og7xJE2gobqn5tajyHqIw5WSOpcFhh7kjMWFJ4allcM=;
 b=PP8HSn9MAEO54Q9Ey7peIGjcZ9ZKLtPuFTnQO6iRoypWc8ccTizIs10p7n0zvNZniKcwvatqA4w7mUrKgMv6MDefeiykSI+KpeY6b+ZvrjVms28Vv05X4SG21sSTSCIJ63Fhq2cKQpht3ViboeXGJWsJmKY5b61gqIvwNK4nwq//LXKzJmvLj9Tgj6/bgxHaf/dzw6TwUD1K92k2U0lWzG6pxFhVFyqpia0fa83L8aq+5G1Jun+YD3AHoLUKiof2Wp4DFLNO7VBBYv3INoUNI7zyHBwE49bP9XtfdNPPcpTN3XwH0P0JLbN56HXQhC2qAC+pz2+e/rOHre/9X//rKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Og7xJE2gobqn5tajyHqIw5WSOpcFhh7kjMWFJ4allcM=;
 b=F+wucRdXVT8Au9AWfoARa6ppLB9Jkn8KjC5hp0mYqvG1dI90kxCKbNZL71EVmC1+xe3xx9y81p2QO1HgXPmtquwbYGPpUOtstzyO3uaUZJdyqT08qWSqgFUE4X+NwqE/DIu/rOY4X2PRG1PRPmiwN18mwa0CyN7rIZ1BxhN/cVc=
Received: from CH3P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::19)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 20:37:53 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:1e8:cafe::86) by CH3P220CA0008.outlook.office365.com
 (2603:10b6:610:1e8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 20:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Thu, 29 Jan 2026 20:37:53 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 14:37:53 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 29 Jan 2026 12:37:52 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/12] drm/amdgpu: don't call drm_sched_stop/start() in asic
 reset
Date: Thu, 29 Jan 2026 15:37:24 -0500
Message-ID: <20260129203731.21506-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129203731.21506-1-alexander.deucher@amd.com>
References: <20260129203731.21506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: d25bc7d1-3bcd-4fbd-a09f-08de5f7646e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y8+/2iUGN5wecSm6EQaX4Ej+3g0t+T+ZQb73w65PK3JoCP9QbmstEiXUY56d?=
 =?us-ascii?Q?hV8zQCfa0JzMGEDLQ935GLB1m93pKNIlU1GQUuiBGadXag675PLxiBQvkOQh?=
 =?us-ascii?Q?pvO9Ywt7hdR8hbW/IHv85TWpvoCwKgIt+ekke9f92Acd2v64YJk8RMxSUeq6?=
 =?us-ascii?Q?QQHlSxz18qLc7B9hsIepYhaVdoqX7e2X/18hJjx/SHqvThDsA0ii4R5IfD82?=
 =?us-ascii?Q?AhdG07Iw/Jnrgz0wdrv4vny6KCeTuvZsd7iSWjx3UDdcZsZvFEwOn+/2itje?=
 =?us-ascii?Q?wTacWCRpSLpKfXo7tQxd9Qbt79/eai/9nPcRXwC/mMqrEVDNRTXXfgDEsdME?=
 =?us-ascii?Q?MpSpLiO6bD3KM2QJY35hMrVr054M9kSnM7goG4yNdpNArUiqZqM4CN6AevoJ?=
 =?us-ascii?Q?DxEkNyy+pEP6oeD0hDqE2GFesypEpXChkks7nf87MRHU2efa9tlduixwdNE2?=
 =?us-ascii?Q?fkGil06sJIqRrY8IpDNaxzj4N213TnW/ox3vmPfo9nWLs+tD1x8TqcVp/Jfy?=
 =?us-ascii?Q?rXiVizW1VHKWJzrv1VYbz8FWLPSVTdTCrNYvQl5s1uupUVEV067MJ5VchbG7?=
 =?us-ascii?Q?k+aBlyTblTGCYyvCIimhBH5DIrMIW6smfUZF3i5/ifK3mNBoQUiBx/o23Gbm?=
 =?us-ascii?Q?jD9TE5D3z/vCHpO4ov50SWPtRDuywKXq15uOfAfP9LLXDmMmekgt0t2kW12S?=
 =?us-ascii?Q?GcXDKQhgenZHXmOHxIC76XmyIz0AaKHFXFX4MHuzA+yVa9MCXmVEMSeJ3Myb?=
 =?us-ascii?Q?5b4IkvRb+v52hzuZCpQZ2linj6SIj7de+Se4dzvQbYJtM0NQ87/DIYdiMQwm?=
 =?us-ascii?Q?w9EnqlvjoP5gbHyc/YLl4k6liwFmduyVMONIBPesD/4XIyy9/PrrDYsQrJEy?=
 =?us-ascii?Q?fkeDWBppAGysAfB4YhH0WacVkSD1B2mqv/2dkLbjaNWO75sfDWf8sIRdji5v?=
 =?us-ascii?Q?U4C3y/qRnPYr5QbU39KHRGFFJ0CjjpuFmVTF/upShClfoxfVD3JFaQE/sowR?=
 =?us-ascii?Q?acE6N4JkejEK54b8AdJzdGfUKDJPr2bDd08lhnIKFiixq7U9HRxRzA7CZpfv?=
 =?us-ascii?Q?Y7ZkRqAHfsCk+snhic2SIQItaiszNfwKjCe5ZD3fe/MsYcg7EtxQE5lUPAOw?=
 =?us-ascii?Q?dRyD9bIPv4UbEcA8g6Mu7guiONr23YbfyGdXpN+nnpGNBF1L9Hv6yuCsBK3J?=
 =?us-ascii?Q?G7DpDfvHhFBKn1GFieinwexw7DWwQSV4z/OSkXij/H7pXzzcZ/gppFPVMDmB?=
 =?us-ascii?Q?DDQQbJz5ILDlxRmM8TqED9rMou/wlT3msMG4ca+lw8St+bWSn6gb82T4+Sc2?=
 =?us-ascii?Q?UTWX/auAsFUJ/w74RLlZX3wM/GTsd07/7N/KEUrTbCzn8HQLajFOPSjfL5xW?=
 =?us-ascii?Q?7DqVhaCtk9PqskIR1Z9kpohrZeYYMrPcpj6grsdiinmj2utSkPDK5Zc6wYqu?=
 =?us-ascii?Q?VEZY8qy+Ke2tRiprNcOIAvg34XAa3zy8cf3Ygo4YKM7w5GdEw75eSkLMIyZr?=
 =?us-ascii?Q?EtsZj1todp5ikGGK17R3CmvJG4Wcao12sQN7EKt5ZV2LtTWbIBjJYK30OqPJ?=
 =?us-ascii?Q?yuYpS0hF9di2vFg2IHFcj5wqqgTO2/+xfB+Eu13Y7k7Q2Q/LsTIo1KRzkRd1?=
 =?us-ascii?Q?QwwkySiHpeuozBK+ZBNoD6otXDJ4Abe5LQbUQ4tcKnNdfhpgGIZDpjJ3Sqar?=
 =?us-ascii?Q?1lq19Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hUzNXJ09GdZMMiTAZZaK+JE3jzm+Lx4iBjQuEF3mTk4ToQoQqL2zE/XWpK1EGiMlY3eZlMwpbAa3300RGzvPmLisLlBekLwKi/P6230rSObhukvEW2pl/+9u3wo0my/XJb1jbzO2hPZ87SZeMW9BWmHntpFSBPaYs10aTDx0FkFM7c7I22Qyb3JycPjLsAEb+t7xkBOZbfrDAbx3nzVIwvpJDhbGR1sXSEcWZulh2XDEk8s9hdBgvov+jGxK1hBe+lHPne/WIr586seFvI428GXcqABUNewyudjutf9gPWZz7hA65zl1mjaf0HZaD2siLQJx/n3p7uNmASVlrR7Gl5UUtv2laO3lgtHYDbAKG+UnlPMiyPOGskMCiPgAjaFWLzvovEnS/b8rcST7Qjei4xwqq6tJBqwBsTpdAV60XDRDRYLYDDzczTwbHu1PjPKl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 20:37:53.2762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d25bc7d1-3bcd-4fbd-a09f-08de5f7646e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970
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
fences, etc.

v2: add the job back to the pending list.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e69ab8a923e31..376b7c4dbdaff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6313,7 +6313,10 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 			if (!amdgpu_ring_sched_ready(ring))
 				continue;
 
-			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
+			drm_sched_wqueue_stop(&ring->sched);
+			/* add the job back to the pending list */
+			if (job && job->base.sched == &ring->sched)
+				list_add(&job->base.list, &job->base.sched->pending_list);
 
 			if (need_emergency_restart)
 				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
@@ -6397,7 +6400,7 @@ static int amdgpu_device_sched_resume(struct list_head *device_list,
 			if (!amdgpu_ring_sched_ready(ring))
 				continue;
 
-			drm_sched_start(&ring->sched, 0);
+			drm_sched_wqueue_start(&ring->sched);
 		}
 
 		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled)
-- 
2.52.0

