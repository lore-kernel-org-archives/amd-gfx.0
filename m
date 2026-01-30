Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D7CE6BF31
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 17:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C522C10EA27;
	Fri, 30 Jan 2026 17:31:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gcyVv7rk";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8476110EA30
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 17:31:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lx9tVcEcUrCZiE9QbdHbB/fNMmWrDQ67L8JWKoFLqn28HOSGUa2Dw0S6+8dYRd3bm4ZEa8nvI8P+eJkWDEF2TePySA0iHmmZB9XOREGiu3syHk+imGbp3WnAs2mtNgnZ4pFP3vvZ9m5yZEVTU0isHThQpItBepqmtUZpnyIhuxD0YeD9lXCzQohFg6MLtGkPGuBEcGfjPTiG/TlkFS9IyJnkFcE25B7q8n3hpZ+8BGU7gG71EsgiZwMnRcYZpvhPDW/DsAif3oCVVtE/Qse4z3OOabOfOTkrU6KTioi8lyrhQoi6alL5Z6BUpKdbn0r/leEXKWbwHphak9eiqzJEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvJ/+hb9bIUFQ2iPIZVPmQVfDIcJqHUZwxhVqF+yFDY=;
 b=MLoU7epkpYl2kwzBcaJg/tDT+OfnEWrwR42b4p9IUM1asp/AQu860083cwhOTpP8wAjkmFDi8K0XymxVSUozZPtwUkNGzP3ByO1E8eFnSd1rDGoTySsNmX+ApKjYueHqWwg1qXpmsnbnXOVgVnJvDoZQ598W8uU/cHjOnjZnO5i0CF9xhUwf97PZGyz9gfHh++cacof3X64ddEqXNA/olIQFYYVLJ6UMrf/0217xx9rgZE19xj7TYsQSWEQVaVJmXG047vl1vaiuAWmFiOebzfH0HKPgqhvusI61OqsACad6dVw2/wGgyLxEJO6kCcCXWuSKUs82cnfclKlCNdYvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvJ/+hb9bIUFQ2iPIZVPmQVfDIcJqHUZwxhVqF+yFDY=;
 b=gcyVv7rkUBcGTQ0vtRuAs46ufn5IpTXugj8Tm7tnBmdOOp3FZNOnoWXGlHQj+zbD4gE0kJfOAm1+bwnKxdtc1Hwl1u122GcX+ruyTl2A4B9VdJCA3EDj243vRbcpDGl7IwhW2VJL5zValXOc2jgOidEEhRM+8A8AwHAjrAGVc6Y=
Received: from SJ0PR05CA0131.namprd05.prod.outlook.com (2603:10b6:a03:33d::16)
 by CY1PR12MB9557.namprd12.prod.outlook.com (2603:10b6:930:fe::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 30 Jan
 2026 17:31:05 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::7b) by SJ0PR05CA0131.outlook.office365.com
 (2603:10b6:a03:33d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.2 via Frontend Transport; Fri,
 30 Jan 2026 17:30:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 17:31:05 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 11:30:58 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 30 Jan 2026 09:30:57 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/12] drm/amdgpu: don't call drm_sched_stop/start() in asic
 reset
Date: Fri, 30 Jan 2026 12:30:35 -0500
Message-ID: <20260130173042.15008-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130173042.15008-1-alexander.deucher@amd.com>
References: <20260130173042.15008-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|CY1PR12MB9557:EE_
X-MS-Office365-Filtering-Correlation-Id: 385e265c-c735-4a11-fcb2-08de602558cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5ambT2OcxSthaYI2dqMxBthGo9H2+OQ1eDEFXgT1KAMRSwWWMigAQcKxxSsB?=
 =?us-ascii?Q?IPxBFBYPgsf66+pQS/F0f7HIpV2F61nPblNt1Lnn0OudvDm2Omf6tRkWUfBc?=
 =?us-ascii?Q?eXsbSgnunYOfZxyEVO9NB05blX8a9Kr3qc3DmVlgenuPzhF/gUjfWfk/Ds+D?=
 =?us-ascii?Q?bbgopa7Nojdxxqu7kuKGARHqNvrMCyW7yECi308kn1++/8XBC8AONCGO8GMn?=
 =?us-ascii?Q?qBj+ltylpw7SntSFI/3p2RW1CyaP/w6Sw5rutXwSF1FRbt+lOhEojC2y2eun?=
 =?us-ascii?Q?KyH+82h168ebrgEFQzaMmqygTeC7xhLME9CTjyUkdTnYV9yUP3E05THKFO17?=
 =?us-ascii?Q?etrducsWBv2RUr48lBDHybOwSSXZ61seUhwaKB+lCHwUzPOz3gDntg0JLSgp?=
 =?us-ascii?Q?aYW9XzzesEDuG08wjeXvj1x6D1Wc3Bv315Mdk49FOUYeR0pPLs9DCVU5HMtv?=
 =?us-ascii?Q?NyAiUpuePMg5W+Cm5chzDFXGvOnmPZvGgcdUwfAQyVX+SnHHlL8yPINs2ies?=
 =?us-ascii?Q?262Vz4NZWmtpbWy+kN3Tfw7VAJ4s7w7iq7duU1cPJC/rn7W1VorwnpY2HzC0?=
 =?us-ascii?Q?SC1k8impcPXWgA0svu70+Fcv3sBTygTMHyr/Ev1RyFcN4D9T/ixxZHhmR1YN?=
 =?us-ascii?Q?VKibQAhD517ExLmq4nHR1S/PPI4YpUEFriINYfQuorPjKsriyncIaGYPLROB?=
 =?us-ascii?Q?RCC3NgK0HI0PU49CXSQD9nnw162fzvFa5TkgHc1ndcMIQBD1cHQzlnTN9Pld?=
 =?us-ascii?Q?rOidp341M5DLoQNWC2B5p4kpkCd0Q3NiXt6nzHnbK/LIQ7ry0J+6vSTYB8ox?=
 =?us-ascii?Q?Ebc+kNOCKnUTkdGUF79zFTcdeenjCbcajrVsf9Dv/WSkf5Qgvt6HGVs3Z9i9?=
 =?us-ascii?Q?b81tQZ0YewQYHoeFOjMEoterP1FcsbV/tdsuIDNu+6J1pkxbM06CpHQqqY3t?=
 =?us-ascii?Q?Y7cwzlkvzS+zlfMgAIrwgRbT3SzZvLUeTytvLMYyEIvL+0NWFeRIqnsrQHhz?=
 =?us-ascii?Q?nh695oh+wM/mt+PEZRFaV4lWuholLbuZskKaLmTHIV9ty0W/jdpQjAoQyxnT?=
 =?us-ascii?Q?Wd/vMM7TRhiI1iH7DYbb25vDGjV5p0rARyNRUt7f1pPm1gKZTkCToO6/K04P?=
 =?us-ascii?Q?g06j04kTJQU2c0f5XwH6RiNX0ejLerAc6V/gisoe2Dh5oulJQPKIboOupR4g?=
 =?us-ascii?Q?fIJwYUN6IbZDAO9KNUMvHFehExS3eMUwy29C3T5bEVV7wjrY5I2wF6nKwTBp?=
 =?us-ascii?Q?fyGpA/DZLsoipj4Hf8MB0HUjgBFbE3XeYWXpZ0o3TT6GYEE4ZEMsyEIxlnnx?=
 =?us-ascii?Q?u2tVwCwK/Naf2lsewNhEH4CXWt0oSTEV9KghuMO8cqwBe2gH/DcqhF/r3Xg0?=
 =?us-ascii?Q?jKm9uUiyZodhNfLXORoKzN8RPUZpXGV2mz3DZdtofCtpo+Nx5i0/1Gz+zmfC?=
 =?us-ascii?Q?nCAZ2zAti5NAHI1nn5KrLbtpzumaPrNiG/krOmJM2gNkFl1xn7Zb6blDEOLO?=
 =?us-ascii?Q?McjeNa58ekBHlCReGnemMu5QbJ9VWFnBO2awC/9SInbAbHCx+oaXDvvDX/vh?=
 =?us-ascii?Q?zrKvKLySUnrb7QYFICzShVaBZw6TsoUKW7Td1nBpjWUrOLR/1QqSg2mi6u3S?=
 =?us-ascii?Q?+Y/naSzi2LI4H3ceIXDZkEe6yTIwML+z8Gf45fwclizaoH07Ly6Bhh49Ngtt?=
 =?us-ascii?Q?zRt8SQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qC2NomewiSO+Uv3vyPuae8lME2TW8KB4uK5V52yy1R2CyXefSET4QQZuImapxhsLsnQsqnHAF7ENlUV/1zdH8wpiWAV8LyB8oBt8GqwbvGyi+KfZsAFyH6pyV3ewsN+qbNi21UKDKri8cJdfVdx87IzM8kxwYFsP+QvBvkvXIpOMNZARmMK81lRhhFv5e0pC0pmTO2OBHMacFIrQVMCPcb2hCwJsycNyZmheOsBTQJ/o+d6Tb8pTt5BKQoVW9p3ju3cqTWpdrM/UE4dVCswBF5DMDlAmSvTXt8bo8DNQTmYz0B34VBc7aCRAB8kkBCIDV+NGI0zMRLefUxngQTR8OKZaKvTzAM1c9x02nBEdTXUGkFOLbCqThyzz6Rz4xmngco4hB2I3HqQdn/6lupXcnixBD5qRwQUvfKJOE02XdkzOjiw6kahgWpbL/J/TUUax
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 17:31:05.1739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 385e265c-c735-4a11-fcb2-08de602558cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9557
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
v3: return the proper job status so scheduler adds the
    job back to the pending list

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e69ab8a923e31..a5b43d57c7b05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6313,7 +6313,7 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 			if (!amdgpu_ring_sched_ready(ring))
 				continue;
 
-			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
+			drm_sched_wqueue_stop(&ring->sched);
 
 			if (need_emergency_restart)
 				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
@@ -6397,7 +6397,7 @@ static int amdgpu_device_sched_resume(struct list_head *device_list,
 			if (!amdgpu_ring_sched_ready(ring))
 				continue;
 
-			drm_sched_start(&ring->sched, 0);
+			drm_sched_wqueue_start(&ring->sched);
 		}
 
 		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index df06a271bdf99..cd0707737a29b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -92,7 +92,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct drm_wedge_task_info *info = NULL;
 	struct amdgpu_task_info *ti = NULL;
 	struct amdgpu_device *adev = ring->adev;
-	enum drm_gpu_sched_stat status = DRM_GPU_SCHED_STAT_RESET;
 	int idx, r;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
@@ -147,8 +146,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 				ring->sched.name);
 			drm_dev_wedged_event(adev_to_drm(adev),
 					     DRM_WEDGE_RECOVERY_NONE, info);
-			/* This is needed to add the job back to the pending list */
-			status = DRM_GPU_SCHED_STAT_NO_HANG;
 			goto exit;
 		}
 		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
@@ -184,7 +181,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 exit:
 	amdgpu_vm_put_task_info(ti);
 	drm_dev_exit(idx);
-	return status;
+	/* This is needed to add the job back to the pending list */
+	return DRM_GPU_SCHED_STAT_NO_HANG;
 }
 
 int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-- 
2.52.0

