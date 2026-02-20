Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446FAC5AD69
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 19:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20B0B10E824;
	Fri, 20 Feb 2026 19:23:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wFftPRRD";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010003.outbound.protection.outlook.com
 [40.93.198.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5DD410E375
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 19:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6vpAH4rPzhlrNfvhQTbtjyj5AOM5rn3+1hpcYKZ6FaCowWYIIfChQnlR06rnUUNo5/e7rKEN+pYSRTGwl12Oaa1QFQNf7BAjEZgS4mE6GGxJ+3bpFfcgBp6aKHAcwBQFQpNRziZc8nQAgQEWRKgRu90hd67WYJlI1RRfKFzF/rihn6frMAmK3UDrv5k1sg5ZrXzdKr/+IJ9f98kfat6ZavOf2OauRAZPzcA6qt8jal4Td9SLoEE2QvZY+HxPojY05ZA1CxOFGFv6Q6Q5NOPwFBcR7PVfKh46FXeoQ2Ggrs0z7LGfvehM+cMpVIvjemK2C8cZ2lbz7LGDXliPvariw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ea+kU8awP/5znBBqAlpHNpHlDmTj+EMf2sQv77SbYas=;
 b=Vgswz58YnEZXSHHo94p7kY4t7HGnx26vIccxdLQzpnLh5hL0P3NKoHqro24rjc+35fIFsaeDYfnG6rMwlZtypaXZaVK8cKS2S8sGM4V6g1b2QrrCE/7HT5c6uOE+uCOdRpG8ASqMsSo/naFsAqIlUF73wxz+fo/Fonz/ddxCXLmSJfLiuLkNJ25tFBX28Lz7NZ9Ccvt9oSiSOtyGbIDylH3danO1kwvcgmZANvguJjBpiBzt9uZhOQiGkEJnC5sPIZruRyX6Pfdz5rVEz9piBmZFb165sCLZrrZJIKDIiLC1HblYyr5iFG2XGTRIarKdprbXqwdu1xgJGl0/BQ0r2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ea+kU8awP/5znBBqAlpHNpHlDmTj+EMf2sQv77SbYas=;
 b=wFftPRRDc9c2UVizGvCoOu8TPdR2OEokhyfh86XaajYkwYVS866jQ9V4QiIRpsgup5U9Hl7mzzKwZ2BhYsMEO0SEukCvGTahmhIbrQK54uZCePT9Uvx9AF6QniQDEy5FojR9JRtDxQzFxZA5nwUf2XVSuTwCWJ8Z55FvFXiA5OI=
Received: from PH8P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::28)
 by CYXPR12MB9319.namprd12.prod.outlook.com (2603:10b6:930:e8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Fri, 20 Feb
 2026 19:23:07 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::b1) by PH8P221CA0028.outlook.office365.com
 (2603:10b6:510:2d8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 19:23:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 19:23:06 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 13:22:54 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH 10/17] drm/amdgpu: add profiler/spm operation
 AMDGPU_SPM_OP_ACQUIRE
Date: Fri, 20 Feb 2026 14:22:29 -0500
Message-ID: <20260220192236.3121556-10-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260220192236.3121556-1-James.Zhu@amd.com>
References: <20260220192236.3121556-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|CYXPR12MB9319:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a21a44-86eb-44b7-c8ea-08de70b579e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZZOyoRzvKCcAH2rMXg6l+5w9kdCuGYYGgVGYRQBH7wO1VYUKAOS9uBCsXKGI?=
 =?us-ascii?Q?IPnPZEv/2g848DTENDEpTCzokQWej0WzsHchtZ+IYR49TzYgSZWqX5I62F+z?=
 =?us-ascii?Q?A8Y3dJX4vpMnpUS+GO5hkCUxzHWjr+d4sWp4sqTmPjdsV4ZINgcNpOKoqHLA?=
 =?us-ascii?Q?8JU44xw/BqDDQgaZ/ltmbs0a/PfSOp4uHvX7JjeSNHFowsvz8xypvTK+B8J3?=
 =?us-ascii?Q?qcIgP8qDXeBLF5HGRGGPxgLOB7jDBX6EHVaaczTQkgvNpl2x3P/d8hCQVHG6?=
 =?us-ascii?Q?w4eKaUwW1AJRxz8MwAbY3R63ohdEl5kIFF+9LaxJ0u3ZnoZzkxIPlz2VLqtD?=
 =?us-ascii?Q?oIQj4Lg+cN9fKvlDbauqVMIfKCHDV0Ogxwg9x+ITV9fDAmvMFbS7CpJNxwak?=
 =?us-ascii?Q?zUsl64zaMJQO4szMSvXICrOz31A0NV4rWx4lx2bDTaTvkl0n6dDcWgI+u5zr?=
 =?us-ascii?Q?fhZPfNCrV+yyu7ant2tVOUqUovQh1YbdzA9vmn9C06m8RwJlsTOGCWyoJTTz?=
 =?us-ascii?Q?xtfiu/y7d6CaOBVq//KGygbTwEPQjqiimbb+cGw4APj3FxMVe7XgDOIyruVP?=
 =?us-ascii?Q?udr5f5gRBwCrnYg63zKoTtwbNHhLU+cFq4xn/TqHMpGKZYsdYag1hSLS/XHm?=
 =?us-ascii?Q?c7LdKndphL4H+QhaZcVjaDMJCjIJr+V0Hmwrw+bnzIVs7Us/Lyvmr0poDSBd?=
 =?us-ascii?Q?7/1hwVPxy5M0rP7lM/RJO6SbWbAmT9da95iVk1iKM6c92yT14fEaANsTEg00?=
 =?us-ascii?Q?ZwYL1+yQYyODocPjIiRWI4vLdKPgMuAHUtz6Aqjb8wOwLqsfbC+iCo+jOdGb?=
 =?us-ascii?Q?tPNnXkwpnnO4CNY0UJZfYdYqfEFWMDKIi2GlJRXXQd8E0koth225xfjgRjN/?=
 =?us-ascii?Q?SJlP89r2lWWLdW8LoDVbN8az+ZjUefNf5rE9+uedyWUpn1roXJLXEt7SHS/z?=
 =?us-ascii?Q?2hpT1T5oWqtRbTTEYQm8GrJIuuldQZgvm6PpJB3ENxOoX6BRv/jP0dmIzkZH?=
 =?us-ascii?Q?CREOv0yajC4/mjL0G9qEzqIAgOM/KPfRU3kmsGFFOCOnG2NbmJwEnbLKSJCk?=
 =?us-ascii?Q?jvgkWy+T1yyk4UHxjqYE7jJ/neZmXwsRpqxRHSB4U/aEAOiW4tKFyhqd2H+d?=
 =?us-ascii?Q?rntPmnfCbDsGiV1/wlLoKqFrTYxYBb3EXNsx4/uYHXN0Z1Ss1ZbGlvYRLy7u?=
 =?us-ascii?Q?PMSnmpBHBiIXRG5U0fxVVF1qMqyYbNdJDnQypnm3kEn9Fl0HpW5fpLabkgf3?=
 =?us-ascii?Q?Rhn7sEhiUR7QBsOTHoKzT+k52fO7yMiw6pHhrm29Ff5IwCspqiUy0DdSiYWO?=
 =?us-ascii?Q?Ufc4zMMh5/DSPwEE+x7WGD+MpLOHX0BZ9u2K8mAw+/XJJj5Gr8B7UkUtuus4?=
 =?us-ascii?Q?lez33U/kJU8XPnJB5Gvks4AVV8aetsecMxDgdRcKkL9Mig5jOqZoxtRkbn6b?=
 =?us-ascii?Q?+W7Ha09G9DHrAfxvvLmwf0PPPBKIMzut5nZw4sfws48K2KQVTL8Gfb+nxUhY?=
 =?us-ascii?Q?lWXH6OwyG1w3Y9agXo2hEBDJl1hS8tGzE3M45xCdzzdPyzCV1oOi5pF5Uy5e?=
 =?us-ascii?Q?8eK/MG3V1ccfdf4zJtlClOdPdaBz9UmcI6r79yKiLX1HYNpX4UiuaKfgX3+x?=
 =?us-ascii?Q?6I36nN/pbx+RFL6kGDvPVsa4DGx2U6knMzckL9JscCMtHkR2EgV7+98VH4l1?=
 =?us-ascii?Q?vhpkcA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a06S9HyzgueBOeEM29nwU0t7SRdlVOhXaK+fdd4b0sKOBWM9yamO0Rbu7P+ovBeaGjEukH9nBormHSNHcyYbmRdyutfOXP5qom/imuMd5XcpYmqMiHbQ4KcoLmRdYT80tA1f5X7MNcv1QDhdVAZUdp4DegiRQoKm6IKXX1k7mKAl90H26qgkleb7zLMsYPvER9wuoz9MekMi9cW1McSonZoLneiTowJ/egipDkPbzDpUcNoDMd730X7f6wG1qtVD2S01YnC2ZNxdrOTvQs1LGEXMGcUlgLVmS9Em7R2bElviLma+S9QeVmes7cpaY2y8dQ7MIaJE3eHbpiaaAxQvlzPy+B3x8jFkOyEaFmgEcnGqEJtV/MIeON0NByQv7ywFqyQpn+WQcmLtVUETNhRExagD4R4NkKahIH0aJluIkbvPdNQVS5QITwlzRAzFZx8U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 19:23:06.8949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a21a44-86eb-44b7-c8ea-08de70b579e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9319
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

skeleton to provide ring buffer for SPM collecting data, and
create a work queue to dump data to user buffer.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c      | 127 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h      |   6 +
 3 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
index 369833f6e684..703a2a9bb8b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -27,6 +27,7 @@
 
 #include "amdgpu_spm.h"
 
+#define AMDGPU_XCC_MASK(adev) ((1U << NUM_XCC(adev->gfx.xcc_mask)) - 1)
 #define AMDGPU_XCP_ID(x) (x == AMDGPU_XCP_NO_PARTITION ? 0 : x)
 #define fpriv_to_prof_mgr(fpriv) (&fpriv->userq_mgr.adev->prof_mgr)
 #define fpriv_to_adev(fpriv) fpriv->userq_mgr.adev
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index e7d16359551f..1ac3668c9744 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -29,11 +29,40 @@
  * 0.1 - Initial revision
  */
 
+struct amdgpu_spm_base {
+	u64    gpu_addr;
+	u32    ring_size;
+	u32    *cpu_addr;
+	void   *spm_obj;
+};
+struct amdgpu_spm_cntr {
+	struct amdgpu_spm_base spm[MAX_XCP];
+	struct mutex spm_worker_mutex;
+};
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp);
+static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp);
+
+
+static void amdgpu_spm_work(struct work_struct *work)
+{
+	struct amdgpu_spm_mgr *spm_mgr = container_of(work, struct amdgpu_spm_mgr, spm_work);
+	struct mm_struct *mm = NULL;
+
+	mm = get_task_mm(spm_mgr->lead_thread);
+	if (mm) {
+		kthread_use_mm(mm);
+		{ /* attach mm */
+			/* TODO: dump spm ring buffer to user buffer */
+		} /* detach mm */
+		kthread_unuse_mm(mm);
+		/* release the mm structure */
+		mmput(mm);
+	}
+}
 
 static void amdgpu_spm_init_device(struct amdgpu_spm_mgr *spm_mgr)
 {
-	/* TODO */
+	spm_mgr->spm_cntr = NULL;
 }
 
 static void amdgpu_spm_release_device(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp)
@@ -41,6 +70,96 @@ static void amdgpu_spm_release_device(struct amdgpu_spm_mgr *spm_mgr, struct drm
 	amdgpu_spm_release(spm_mgr, filp);
 }
 
+static int _amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp)
+{
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+	struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
+	int ret = 0;
+
+	/* allocate 4M spm ring buffer */
+	spm->ring_size = order_base_2(4 * 1024 * 1024/4);
+	spm->ring_size = (1 << spm->ring_size) * 4;
+
+	ret = amdgpu_vm_alloc_gtt_mem(adev,
+			spm->ring_size, &spm->spm_obj,
+			&spm->gpu_addr, (void *)&spm->cpu_addr,
+			false, false);
+
+	if (ret)
+		goto out;
+
+	ret = amdgpu_rlc_spm_acquire(adev, inst, drm_priv_to_vm(filp),
+			spm->gpu_addr, spm->ring_size);
+
+	/*
+	 * By definition, the last 8 DWs of the buffer are not part of the rings
+	 *  and are instead part of the Meta data area.
+	 */
+	spm->ring_size -= 0x20;
+
+	if (ret)
+		goto rlc_spm_acquire_failure;
+
+	goto out;
+
+rlc_spm_acquire_failure:
+	amdgpu_vm_free_gtt_mem(adev, &spm->spm_obj);
+	memset(spm, 0, sizeof(*spm));
+out:
+	return ret;
+}
+
+static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp)
+{
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+	int ret = 0;
+	int inst;
+
+	mutex_lock(&(to_prof_xcp_mgr(spm_mgr, spm_mgr)->mutex));
+
+	if (spm_mgr->spm_cntr) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	spm_mgr->lead_thread = current->group_leader;
+	spm_mgr->spm_cntr = kzalloc(sizeof(struct amdgpu_spm_cntr), GFP_KERNEL);
+	if (!spm_mgr->spm_cntr) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for_each_inst(inst, AMDGPU_XCC_MASK(adev)) {
+		ret = _amdgpu_spm_acquire(spm_mgr, inst, filp);
+		if (ret)
+			goto acquire_spm_failure;
+	}
+
+	mutex_init(&spm_mgr->spm_cntr->spm_worker_mutex);
+
+	INIT_WORK(&spm_mgr->spm_work, amdgpu_spm_work);
+
+	spm_mgr->file = filp;
+
+	goto out;
+
+acquire_spm_failure:
+	for_each_inst(inst, AMDGPU_XCC_MASK(adev))
+		_amdgpu_spm_release(spm_mgr, inst, filp);
+	kfree(spm_mgr->spm_cntr);
+	spm_mgr->spm_cntr = NULL;
+
+out:
+	mutex_unlock(&(to_prof_xcp_mgr(spm_mgr, spm_mgr)->mutex));
+	return ret;
+}
+
+static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp)
+{
+	/* TODO: */
+
+}
+
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp)
 {
 	/* TODO */
@@ -52,9 +171,15 @@ int amdgpu_spm_ioctl(struct drm_device *dev, void __user *data,
 {
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_device *adev = fpriv_to_adev(fpriv);
+	struct amdgpu_profiler_mgr *prof_mgr = fpriv_to_prof_mgr(fpriv);
 	struct drm_amdgpu_spm_args *args = data;
+	struct amdgpu_spm_mgr *spm_mgr =
+		&(prof_mgr->prof_xcp_mgr[AMDGPU_XCP_ID(fpriv->xcp_id)].spm_mgr);
 
 	switch (args->op) {
+	case AMDGPU_SPM_OP_ACQUIRE:
+		return  amdgpu_spm_acquire(spm_mgr, filp);
+
 	default:
 		dev_err(adev->dev, "Invalid option: %i\n", args->op);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
index 3728f227bd61..ee4f03e2f6cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -25,6 +25,12 @@
 
 struct amdgpu_spm_mgr {
 	struct drm_file *file;
+
+	struct task_struct *lead_thread;
+
+	/* spm data */
+	struct amdgpu_spm_cntr *spm_cntr;
+	struct work_struct spm_work;
 };
 
 int amdgpu_spm_ioctl(struct drm_device *dev, void __user *data,
-- 
2.34.1

