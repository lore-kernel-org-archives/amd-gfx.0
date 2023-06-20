Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBEFEB64D8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jun 2023 17:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B8410E303;
	Tue, 20 Jun 2023 17:16:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8268310E303
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 17:16:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4n+2U6StnobXbPXSvWBr/lK/twYV0uhZKXo8ho5F5L1MSZfu7JHReNZIk+N9YV6PW8fvMEjfUuvyQs4J5d88Brl7giGjaNYLPQrknlIuSrByS0oa2j8CADjG4cRLuvbjgIINTZ8J1S2WgRvQsJCUaMAUL1kE4QrRG9Fkkw1idh78AyL2E2txqTaRDGDxkbdmeg9gLaccvqv/Y++HXPOz+XPIoxMcw3NFx9fTUeAw1aCqhMljnXewcVfHol2SKGaXAUQdD9m7K+ojyjg3GXyvRTzZeYySCcUfhbhWZnTJq11l4dJERGXCfB3bWxyFV/mS/QUHeOBWB3piL8FApOsZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4013ofi9GlH1ho5AhM7ylEZlHAJfD4ZXuOLkrt1n2OM=;
 b=m9l22H4/tKFwlrZJ35h4ym7DN8PR6kgNduJpxVvQxu/2TKghYb6a3+1CyMYIefjspJOJo4XWuXz+DHtuyk+dMvq2yPN/yk4JZby4GYd6OTwsJxlBbE/0CzbLTuIy14JfXM0XuoSqWMd/I3vhMhYDjBYE1aFLalhp170oFlRHsRSAKh+HPR7e1l0TQtLfFRCAOsIGoGMIbWG+8Hcz1V54m2pubU0uOyGS8P21dvk0lCIYZNyyU8ZmVzKHgVhFqF94CpEYB41Xi9qTN9FwcH4rMkAbsn1Z1zLKpm31fIiDBYlcogAtoaz3IdOYTByee5lpkFxOfJWInJgeAX2R+HU1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4013ofi9GlH1ho5AhM7ylEZlHAJfD4ZXuOLkrt1n2OM=;
 b=y+UmsppNwrWTeleDAZt1pvikkEacfS5llZUykqxu6NK+sBGm5eKpIZMGY4lbx5Bm6l81bYHw0G5Ph3UgbjzyZkdijuAxugVTh3PLoYe2+hvqmtVqiXZ4JA1ANY9QJEXk67lBg4XZPMAKpkJV/7/1E5tYfzSIvRkEets4jyXF928=
Received: from BY5PR17CA0026.namprd17.prod.outlook.com (2603:10b6:a03:1b8::39)
 by PH8PR12MB6722.namprd12.prod.outlook.com (2603:10b6:510:1cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 17:16:44 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:1b8:cafe::81) by BY5PR17CA0026.outlook.office365.com
 (2603:10b6:a03:1b8::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 17:16:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 17:16:44 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 12:16:38 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 11/12] drm/amdgpu: use doorbell mgr for MES kernel doorbells
Date: Tue, 20 Jun 2023 19:16:07 +0200
Message-ID: <20230620171608.2131-12-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230620171608.2131-1-shashank.sharma@amd.com>
References: <20230620171608.2131-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT090:EE_|PH8PR12MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: d01a3c6c-ec64-4156-42e8-08db71b21f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 156syqjxodtyHH79Z6ZEPASd/112ighVENXz4MKNoUkPMU0JZwXk2eQHL08sz1hEojZSeshzDcGTpr78VYxRdrbQ37Vz0qE0otM1Si0Y59nkWVWNqwXEmzLKg0w4j+HWIU2kDy7SRyWUYiI9tTgHWY2ye0y0qupuRI99TgNWo6BUGZ9Mvz5HXAcPfrq+iVaf6oCcQK1Xn1C5es/G7Nj2yS2DzgxqR4gMcZqqVfmYMsWzgXQqlRZYz8LkRbU5/V/oAuhX3DYbz/BULP3PPrhiZu+xL3N+syJySuFR75Z3ikeZlKWvMW1OBXmklmIA6AVqpxS5EcEiITvTOoQWIgmY4LMt4EUTeoTU9+v1aWN6mEcld0t9ZML7Au0RnpU4jfQwi9lZ3BrrD3N+r00UPirZ8nGoMkGXcC+M3dmiZBO60s3DkFt0lQnSHRAX2jn6liq7z9Z2P6uuBoFStNRfA6SmbJWXkZTjKKzC458vPKBIixjXSqyu03xC+9pC9VIx7lJQkosyFY/elipNUnZLhKzkE4bOH7EhdcdJuuqu3G9TNzwP+OsI38osii31cbRRghVvjQG451htqwZtykOmZAK8nq/BFNqqHr3OT5jzGbuU2QGJLkcuzrk1689EtG6kzq7Gv9hLzFKgibtDmoWTtpScm9ZRsfk9MHXisWj2NxB/ZCDHmf/8pXa2ZtRtst3Bu9bTmADynUbY41f55UYyV2Q4FoOpTDPNDv51ZP9NIsY5WLkSVZMBdvTKn+mf2OLzthpvRX4Hkl/1Xgtm50IK2003bg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(47076005)(36860700001)(82740400003)(40480700001)(81166007)(356005)(54906003)(6666004)(7696005)(478600001)(2906002)(44832011)(5660300002)(4326008)(6916009)(70206006)(70586007)(316002)(8676002)(8936002)(41300700001)(2616005)(426003)(336012)(83380400001)(82310400005)(16526019)(26005)(186003)(1076003)(86362001)(36756003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:16:44.2903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d01a3c6c-ec64-4156-42e8-08db71b21f27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6722
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch:
- Removes the existing doorbell management code, and its variables
  from the doorbell_init function, it will be done in doorbell
  manager now.
- uses the doorbell page created for MES kernel level needs (doorbells
  for MES self tests)
- current MES code was allocating MES doorbells in MES process context,
  but those were getting written using kernel doorbell calls. This patch
  instead allocates a MES kernel doorbell for this (in add_hw_queue).

V2: Create an extra page of doorbells for MES during kernel doorbell
    creation (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 94 ++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 +
 2 files changed, 40 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index f0f00466b59f..01c3d27512d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -67,91 +67,70 @@ unsigned int amdgpu_mes_get_doorbell_dw_offset_in_bar(
 		doorbell_id * 2);
 }
 
-static int amdgpu_mes_queue_doorbell_get(struct amdgpu_device *adev,
+static int amdgpu_mes_kernel_doorbell_get(struct amdgpu_device *adev,
 					 struct amdgpu_mes_process *process,
 					 int ip_type, uint64_t *doorbell_index)
 {
 	unsigned int offset, found;
+	struct amdgpu_mes *mes = &adev->mes;
 
-	if (ip_type == AMDGPU_RING_TYPE_SDMA) {
+	if (ip_type == AMDGPU_RING_TYPE_SDMA)
 		offset = adev->doorbell_index.sdma_engine[0];
-		found = find_next_zero_bit(process->doorbell_bitmap,
-					   AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS,
-					   offset);
-	} else {
-		found = find_first_zero_bit(process->doorbell_bitmap,
-					    AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS);
-	}
+	else
+		offset = 0;
 
-	if (found >= AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS) {
+	found = find_next_zero_bit(mes->doorbell_bitmap, mes->num_mes_dbs, offset);
+	if (found >= mes->num_mes_dbs) {
 		DRM_WARN("No doorbell available\n");
 		return -ENOSPC;
 	}
 
-	set_bit(found, process->doorbell_bitmap);
-
-	*doorbell_index = amdgpu_mes_get_doorbell_dw_offset_in_bar(adev,
-				process->doorbell_index, found);
+	set_bit(found, mes->doorbell_bitmap);
 
+	/* Get the absolute doorbell index on BAR */
+	*doorbell_index = mes->db_start_dw_offset + found * 2;
 	return 0;
 }
 
-static void amdgpu_mes_queue_doorbell_free(struct amdgpu_device *adev,
+static void amdgpu_mes_kernel_doorbell_free(struct amdgpu_device *adev,
 					   struct amdgpu_mes_process *process,
 					   uint32_t doorbell_index)
 {
-	unsigned int old, doorbell_id;
-
-	doorbell_id = doorbell_index -
-		(process->doorbell_index *
-		 amdgpu_mes_doorbell_process_slice(adev)) / sizeof(u32);
-	doorbell_id /= 2;
+	unsigned int old, rel_index;
+	struct amdgpu_mes *mes = &adev->mes;
 
-	old = test_and_clear_bit(doorbell_id, process->doorbell_bitmap);
+	/* Find the relative index of the doorbell in this object */
+	rel_index = (doorbell_index - mes->db_start_dw_offset) / 2;
+	old = test_and_clear_bit(rel_index, mes->doorbell_bitmap);
 	WARN_ON(!old);
 }
 
 static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
 {
-	size_t doorbell_start_offset;
-	size_t doorbell_aperture_size;
-	size_t doorbell_process_limit;
-	size_t aggregated_doorbell_start;
 	int i;
+	struct amdgpu_mes *mes = &adev->mes;
 
-	aggregated_doorbell_start = (adev->doorbell_index.max_assignment + 1) * sizeof(u32);
-	aggregated_doorbell_start =
-		roundup(aggregated_doorbell_start, PAGE_SIZE);
-
-	doorbell_start_offset = aggregated_doorbell_start + PAGE_SIZE;
-	doorbell_start_offset =
-		roundup(doorbell_start_offset,
-			amdgpu_mes_doorbell_process_slice(adev));
-
-	doorbell_aperture_size = adev->doorbell.size;
-	doorbell_aperture_size =
-			rounddown(doorbell_aperture_size,
-				  amdgpu_mes_doorbell_process_slice(adev));
-
-	if (doorbell_aperture_size > doorbell_start_offset)
-		doorbell_process_limit =
-			(doorbell_aperture_size - doorbell_start_offset) /
-			amdgpu_mes_doorbell_process_slice(adev);
-	else
-		return -ENOSPC;
-
-	adev->mes.doorbell_id_offset = doorbell_start_offset / sizeof(u32);
-	adev->mes.max_doorbell_slices = doorbell_process_limit;
+	/* Bitmap for dynamic allocation of kernel doorbells */
+	mes->doorbell_bitmap = bitmap_zalloc(PAGE_SIZE / sizeof(u32), GFP_KERNEL);
+	if (!mes->doorbell_bitmap) {
+		DRM_ERROR("Failed to allocate MES doorbell bitmap\n");
+		return -ENOMEM;
+	}
 
-	/* allocate Qword range for aggregated doorbell */
-	for (i = 0; i < AMDGPU_MES_PRIORITY_NUM_LEVELS; i++)
-		adev->mes.aggregated_doorbells[i] =
-			aggregated_doorbell_start / sizeof(u32) + i * 2;
+	mes->num_mes_dbs = PAGE_SIZE / AMDGPU_ONE_DOORBELL_SIZE;
+	for (i = 0; i < AMDGPU_MES_PRIORITY_NUM_LEVELS; i++) {
+		adev->mes.aggregated_doorbells[i] = mes->db_start_dw_offset + i * 2;
+		set_bit(i, mes->doorbell_bitmap);
+	}
 
-	DRM_INFO("max_doorbell_slices=%zu\n", doorbell_process_limit);
 	return 0;
 }
 
+static void amdgpu_mes_doorbell_free(struct amdgpu_device *adev)
+{
+	bitmap_free(adev->mes.doorbell_bitmap);
+}
+
 int amdgpu_mes_init(struct amdgpu_device *adev)
 {
 	int i, r;
@@ -250,6 +229,7 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 	amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
 	amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
 	amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
+	amdgpu_mes_doorbell_free(adev);
 
 	idr_destroy(&adev->mes.pasid_idr);
 	idr_destroy(&adev->mes.gang_id_idr);
@@ -679,7 +659,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 	*queue_id = queue->queue_id = r;
 
 	/* allocate a doorbell index for the queue */
-	r = amdgpu_mes_queue_doorbell_get(adev, gang->process,
+	r = amdgpu_mes_kernel_doorbell_get(adev, gang->process,
 					  qprops->queue_type,
 					  &qprops->doorbell_off);
 	if (r)
@@ -737,7 +717,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 	return 0;
 
 clean_up_doorbell:
-	amdgpu_mes_queue_doorbell_free(adev, gang->process,
+	amdgpu_mes_kernel_doorbell_free(adev, gang->process,
 				       qprops->doorbell_off);
 clean_up_queue_id:
 	spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
@@ -792,7 +772,7 @@ int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id)
 			  queue_id);
 
 	list_del(&queue->list);
-	amdgpu_mes_queue_doorbell_free(adev, gang->process,
+	amdgpu_mes_kernel_doorbell_free(adev, gang->process,
 				       queue->doorbell_off);
 	amdgpu_mes_unlock(&adev->mes);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index a403418d5eac..2c604e04fd5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -27,6 +27,7 @@
 #include "amdgpu_irq.h"
 #include "kgd_kfd_interface.h"
 #include "amdgpu_gfx.h"
+#include "amdgpu_doorbell.h"
 #include <linux/sched/mm.h>
 
 #define AMDGPU_MES_MAX_COMPUTE_PIPES        8
@@ -130,6 +131,8 @@ struct amdgpu_mes {
 
 	/* MES doorbells */
 	uint32_t			db_start_dw_offset;
+	uint32_t			num_mes_dbs;
+	unsigned long			*doorbell_bitmap;
 
 	/* ip specific functions */
 	const struct amdgpu_mes_funcs   *funcs;
-- 
2.40.1

