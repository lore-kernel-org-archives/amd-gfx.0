Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3FFCF6499
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 12:00:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 351FC10E403;
	Mon, 30 Sep 2024 12:00:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pe7HMqdw";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25C2F10E403
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 12:00:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AE9o9hHBbcof/XSaTR3A1VrJzFER5yiMj9fRG1K55V+qaWSZut77yJ3Sg312atraADGZ1Eya57/p4xqGQcq5rekKENjGTnJRx503uO1ZRyaQkdRxz3xoRh2BrV1kWhoxodL3mi69LX6S9v+lV62vpZaY8HYCZM0QTLTAyrqACbnC/zJcJpE1WhjSkpEYbvnD+iTFj62KiZMadtDEGGMjqC6cE5zQD0hwVPMIsf3/b/UlC2rZOi1IZttw1l9MHoVdFNZP6tFhd6JCuHNXR/YWr6rUJqIGpq3Fl8BzyIxCLGpx6+KjXdinYhzVsPqUqAQRy+ijX3dEcl8GmmWvcZIsuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NV46kft/If9E+1EH/6ZK2NP5TLlO3FF/8axyGNWNzc0=;
 b=rf1UW7z0aa2XSInMKxaw/ZgbFVyOP5G5C+gWe5iWff7uRAm090O/GElX6lFJvF/RbUWZdjBc5h5tJafCueBuNB0+V0vEEpz28ctnNvOcuHwZcgACPltdIMA3B4AIozD4FNALHiZLkURal8RCOCSUIr3SUYP4naKKAwecq3P9w5N/dTUcDOVwTzkdz/kjIVIBDEy1l+cMrkqRC3jc9zSDpY3d31vmRM4R3HrkFI8m1LP5H5z8Hcgg6JQYPcuPn2b7W8i4FwLDDR4SqsNJbOdVayT27diYCZ5iIsh+dOONlyKc3lsVNFHwf/xji43Pe8W/Lh0dqN4pL05eob+/tx1BAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NV46kft/If9E+1EH/6ZK2NP5TLlO3FF/8axyGNWNzc0=;
 b=pe7HMqdwzpNCKa5G2ds/9z9zUqEHzBf1bzieYJsJMCfcBuLDkdaz9OWROi+4IHhC9YVznJBiuzh+QV8/11OB3NiUe6wybJYSv9clFwJQiBfL2rHuI5VfI/a8ayHmbke+QiIgtCxyj4VIK6WYbOL0nCw/66otFUrkrWJq+avldHg=
Received: from SN1PR12CA0065.namprd12.prod.outlook.com (2603:10b6:802:20::36)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 12:00:25 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:802:20:cafe::2) by SN1PR12CA0065.outlook.office365.com
 (2603:10b6:802:20::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Mon, 30 Sep 2024 12:00:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 12:00:24 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 07:00:22 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v3 05/09] drm/amdgpu: Remove the MES self test
Date: Mon, 30 Sep 2024 17:29:02 +0530
Message-ID: <20240930115906.191060-5-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930115906.191060-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240930115906.191060-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ca7d19-590e-474e-aa17-08dce14777dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWxYSCtqK0RiOVZVdnFBRk1ENjJBeEN0Wi9QZHpEL0RKT001RE1OakZPNzI2?=
 =?utf-8?B?QU5VY3pZN0N2Zm41WXgzNWFnYVdWbllUVVBEQUZBMDUvVjBLUE91NGhYL3JT?=
 =?utf-8?B?RHJ5M25GQzAvNzRXYzdoKzlyK3JFckVlMjdIT2R2SmVYVzZHc0JuN1F6VG9H?=
 =?utf-8?B?VGJjbkdPQnBQdVY2NGVSTHUyaEJJa0RjTDMvKzJBZlMwV29sK3RYeTB6WUl2?=
 =?utf-8?B?YUVGa3MvQjZlR3NiNENwLzFnTXZtVWR5bjFLVW1yVFZkdHN3ZjQyVmJlRFIv?=
 =?utf-8?B?NGY5ckVrUHlpOURsQmcvdWZlVVhFekNKK29XUlYxNVdKekxkZ0cvWGFpMFBl?=
 =?utf-8?B?Tm14U1M2TnN6WUpKUzdZYU8zK2k5M09OUXNCc2JYSndNbUYzcFZPcENaT3dz?=
 =?utf-8?B?eE1nVjMvV3hRY2hjU3pDdndQOEY4cE1MeUVMcHFia0ZPdW9zNkhwTmRJa3ZF?=
 =?utf-8?B?ZStuY1ZwenExaENoNnRvbWdXa0d0Y0tFSXJkdHpwTUlnR1RFQXI4c0JTUUxs?=
 =?utf-8?B?bTZJN01tMk5CUnA0VWZhY1dBTm5ncHowdkRob2txczlMNE0wZkN0UkVoTnJV?=
 =?utf-8?B?TFhmQWhSY0N5ZFZSZTcyTnlsVzJrOC91MUp5ZWNXQ1ZQOGllL3lDSE1zNk9S?=
 =?utf-8?B?VWxPTFA1TDlhTXRhdUZUWkVTdUEwd2dlWmtwQVVkMlZxU2xvVlZicHpOeCtI?=
 =?utf-8?B?MEZ2dlJHS1pqYytEOFVmbkQvd3BLa0pnaE5ZRXo5SXMzN3N3U25rSU5DQkl1?=
 =?utf-8?B?VjFIcEt1SVFpamZ5VkVjNnYxbXFqNVR1OGw0WENrelA5dFdLQnBJd2E2NEJZ?=
 =?utf-8?B?Nm9xS1dYc0Y0TFFaeGdxbGczUk9BUlZuQW5aa2NLenA4bFNQTk9OM2JRVEJz?=
 =?utf-8?B?YXJTand0R1ZSSkxadGc2bCtjZWhMSTlTY1BCcDIrOXR0NkdxRHN5Mll4aGEv?=
 =?utf-8?B?dnVMUFNSMjNUQ2dhc3JhWEVmWjlycVRQakRVYmdjV1lzMXhTNVBpZHFmaHps?=
 =?utf-8?B?SWM3enJTblJpeFhiYitjUFhwRncvZy9hL0czM0JLSXRDOEFud2YrRlRKcXhu?=
 =?utf-8?B?aXVqNjF5ems2KzhITWFLNU1XaWFra3VWelg2K2hkTkdHK3g4cHQzWFNKZ3Ry?=
 =?utf-8?B?QTNzQjl5Ulppb2dxTUxBaytKZlZoQWtVUkhCTDBQVXhoL25JMzhYKytuakh3?=
 =?utf-8?B?WmdHR0U0dy9BTzZBOVhwTzB2ZFJScExvVEhETytCdEU1NEROVXFidkxWaERJ?=
 =?utf-8?B?NmJsWFQvY3NISzZUaXBGdXJLUVRXM0hiWXNmUjdFdFMzVkViNENtVUJjU0ZB?=
 =?utf-8?B?dU4yUCtpRGNwMGhneE1rUTZUaFZEbzQ2Zkhhd1huR2t3ODMwL0NIVVhuWk9h?=
 =?utf-8?B?U1lEYmhxTnJ4bEtTWWdtR0llOGl0V0NZWVVpNElva1BkZFRQdFhuYVR4NE9h?=
 =?utf-8?B?MHhXZFhFb3pPYVdZSWZjWHZpN0hvWks1UGJVcDNXMlFOQmd2aDNZWkg1ZDdz?=
 =?utf-8?B?R2JnUXRNc3M2WjBGSjVWT2laeEpqL3lHNVFacHlOcko3VENWcFdTTzFwUXZF?=
 =?utf-8?B?MVUyRHV0SUFFWHF5blR6cmxmYk1CcmZzMlE5bk5Gd1k0RVZSaHJYdHBqcURm?=
 =?utf-8?B?T0d0QUk2UzNENDBMeTRibGhFTGZKc1lRdWgxb3ZGcHFyQm9zc0YxelpkczVD?=
 =?utf-8?B?SFQ2OW9Zb2grbzlDR2xyYXE2dzVSbTJZaVBMUk1LalJyR1l5RVIzeklCRVZ3?=
 =?utf-8?B?a3hPQTBLcncxVE9QbGttMGpSSlFHSnAyKzBnbTJSOXZTUmp2TlBzSlF4MXhk?=
 =?utf-8?B?a0lMdEtQcGN6RllmWGZvcU0waDl4d0pBZ0lud2xTc3djMVJpaExUbWh2QWFi?=
 =?utf-8?B?UHNsMGFaYlQvY2tXS3RHWEhMeXZUSGg4MWp5d1JDNXFidk1QY21UQ0Exek1W?=
 =?utf-8?Q?4uZGBYEJZjyDlS7YewzQJXvL2HZIGXX7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:00:24.8929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ca7d19-590e-474e-aa17-08dce14777dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
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

Remove MES self test as this conflicts the userqueue fence
interrupts.

v2:(Christian)
  - remove the amdgpu_mes_self_test() function and any now unused code.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    | 169 ---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |   2 -
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c     |  12 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     |  14 +-
 5 files changed, 2 insertions(+), 198 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2da895f91e4d..5ec6cb237c81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4700,9 +4700,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	}
 	adev->in_suspend = false;
 
-	if (adev->enable_mes)
-		amdgpu_mes_self_test(adev);
-
 	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D0))
 		DRM_WARN("smart shift update failed\n");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index da48b6da0107..dbe7cf4b322d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1297,175 +1297,6 @@ int amdgpu_mes_ctx_unmap_meta_data(struct amdgpu_device *adev,
 	return r;
 }
 
-static int amdgpu_mes_test_create_gang_and_queues(struct amdgpu_device *adev,
-					  int pasid, int *gang_id,
-					  int queue_type, int num_queue,
-					  struct amdgpu_ring **added_rings,
-					  struct amdgpu_mes_ctx_data *ctx_data)
-{
-	struct amdgpu_ring *ring;
-	struct amdgpu_mes_gang_properties gprops = {0};
-	int r, j;
-
-	/* create a gang for the process */
-	gprops.priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
-	gprops.gang_quantum = adev->mes.default_gang_quantum;
-	gprops.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
-	gprops.priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
-	gprops.global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
-
-	r = amdgpu_mes_add_gang(adev, pasid, &gprops, gang_id);
-	if (r) {
-		DRM_ERROR("failed to add gang\n");
-		return r;
-	}
-
-	/* create queues for the gang */
-	for (j = 0; j < num_queue; j++) {
-		r = amdgpu_mes_add_ring(adev, *gang_id, queue_type, j,
-					ctx_data, &ring);
-		if (r) {
-			DRM_ERROR("failed to add ring\n");
-			break;
-		}
-
-		DRM_INFO("ring %s was added\n", ring->name);
-		added_rings[j] = ring;
-	}
-
-	return 0;
-}
-
-static int amdgpu_mes_test_queues(struct amdgpu_ring **added_rings)
-{
-	struct amdgpu_ring *ring;
-	int i, r;
-
-	for (i = 0; i < AMDGPU_MES_CTX_MAX_RINGS; i++) {
-		ring = added_rings[i];
-		if (!ring)
-			continue;
-
-		r = amdgpu_ring_test_helper(ring);
-		if (r)
-			return r;
-
-		r = amdgpu_ring_test_ib(ring, 1000 * 10);
-		if (r) {
-			DRM_DEV_ERROR(ring->adev->dev,
-				      "ring %s ib test failed (%d)\n",
-				      ring->name, r);
-			return r;
-		} else
-			DRM_INFO("ring %s ib test pass\n", ring->name);
-	}
-
-	return 0;
-}
-
-int amdgpu_mes_self_test(struct amdgpu_device *adev)
-{
-	struct amdgpu_vm *vm = NULL;
-	struct amdgpu_mes_ctx_data ctx_data = {0};
-	struct amdgpu_ring *added_rings[AMDGPU_MES_CTX_MAX_RINGS] = { NULL };
-	int gang_ids[3] = {0};
-	int queue_types[][2] = { { AMDGPU_RING_TYPE_GFX, 1 },
-				 { AMDGPU_RING_TYPE_COMPUTE, 1 },
-				 { AMDGPU_RING_TYPE_SDMA, 1} };
-	int i, r, pasid, k = 0;
-
-	pasid = amdgpu_pasid_alloc(16);
-	if (pasid < 0) {
-		dev_warn(adev->dev, "No more PASIDs available!");
-		pasid = 0;
-	}
-
-	vm = kzalloc(sizeof(*vm), GFP_KERNEL);
-	if (!vm) {
-		r = -ENOMEM;
-		goto error_pasid;
-	}
-
-	r = amdgpu_vm_init(adev, vm, -1);
-	if (r) {
-		DRM_ERROR("failed to initialize vm\n");
-		goto error_pasid;
-	}
-
-	r = amdgpu_mes_ctx_alloc_meta_data(adev, &ctx_data);
-	if (r) {
-		DRM_ERROR("failed to alloc ctx meta data\n");
-		goto error_fini;
-	}
-
-	ctx_data.meta_data_gpu_addr = AMDGPU_VA_RESERVED_SIZE;
-	r = amdgpu_mes_ctx_map_meta_data(adev, vm, &ctx_data);
-	if (r) {
-		DRM_ERROR("failed to map ctx meta data\n");
-		goto error_vm;
-	}
-
-	r = amdgpu_mes_create_process(adev, pasid, vm);
-	if (r) {
-		DRM_ERROR("failed to create MES process\n");
-		goto error_vm;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(queue_types); i++) {
-		/* On GFX v10.3, fw hasn't supported to map sdma queue. */
-		if (amdgpu_ip_version(adev, GC_HWIP, 0) >=
-			    IP_VERSION(10, 3, 0) &&
-		    amdgpu_ip_version(adev, GC_HWIP, 0) <
-			    IP_VERSION(11, 0, 0) &&
-		    queue_types[i][0] == AMDGPU_RING_TYPE_SDMA)
-			continue;
-
-		r = amdgpu_mes_test_create_gang_and_queues(adev, pasid,
-							   &gang_ids[i],
-							   queue_types[i][0],
-							   queue_types[i][1],
-							   &added_rings[k],
-							   &ctx_data);
-		if (r)
-			goto error_queues;
-
-		k += queue_types[i][1];
-	}
-
-	/* start ring test and ib test for MES queues */
-	amdgpu_mes_test_queues(added_rings);
-
-error_queues:
-	/* remove all queues */
-	for (i = 0; i < ARRAY_SIZE(added_rings); i++) {
-		if (!added_rings[i])
-			continue;
-		amdgpu_mes_remove_ring(adev, added_rings[i]);
-	}
-
-	for (i = 0; i < ARRAY_SIZE(gang_ids); i++) {
-		if (!gang_ids[i])
-			continue;
-		amdgpu_mes_remove_gang(adev, gang_ids[i]);
-	}
-
-	amdgpu_mes_destroy_process(adev, pasid);
-
-error_vm:
-	amdgpu_mes_ctx_unmap_meta_data(adev, &ctx_data);
-
-error_fini:
-	amdgpu_vm_fini(adev, vm);
-
-error_pasid:
-	if (pasid)
-		amdgpu_pasid_free(pasid);
-
-	amdgpu_mes_ctx_free_meta_data(&ctx_data);
-	kfree(vm);
-	return 0;
-}
-
 int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
 {
 	const struct mes_firmware_header_v1_0 *mes_hdr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 7d4f93fea937..e7af28834766 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -396,8 +396,6 @@ int amdgpu_mes_ctx_map_meta_data(struct amdgpu_device *adev,
 int amdgpu_mes_ctx_unmap_meta_data(struct amdgpu_device *adev,
 				   struct amdgpu_mes_ctx_data *ctx_data);
 
-int amdgpu_mes_self_test(struct amdgpu_device *adev);
-
 int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev);
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 1e5ad1e08d2a..1b2745670d4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -1156,20 +1156,10 @@ static int mes_v10_0_early_init(void *handle)
 	return 0;
 }
 
-static int mes_v10_0_late_init(void *handle)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
-	if (!amdgpu_in_reset(adev))
-		amdgpu_mes_self_test(adev);
-
-	return 0;
-}
-
 static const struct amd_ip_funcs mes_v10_1_ip_funcs = {
 	.name = "mes_v10_1",
 	.early_init = mes_v10_0_early_init,
-	.late_init = mes_v10_0_late_init,
+	.late_init = NULL,
 	.sw_init = mes_v10_1_sw_init,
 	.sw_fini = mes_v10_1_sw_fini,
 	.hw_init = mes_v10_1_hw_init,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 26d71a22395d..38e35c0a2876 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1257,22 +1257,10 @@ static int mes_v11_0_early_init(void *handle)
 	return 0;
 }
 
-static int mes_v11_0_late_init(void *handle)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
-	/* it's only intended for use in mes_self_test case, not for s0ix and reset */
-	if (!amdgpu_in_reset(adev) && !adev->in_s0ix && !adev->in_suspend &&
-	    (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(11, 0, 3)))
-		amdgpu_mes_self_test(adev);
-
-	return 0;
-}
-
 static const struct amd_ip_funcs mes_v11_0_ip_funcs = {
 	.name = "mes_v11_0",
 	.early_init = mes_v11_0_early_init,
-	.late_init = mes_v11_0_late_init,
+	.late_init = NULL,
 	.sw_init = mes_v11_0_sw_init,
 	.sw_fini = mes_v11_0_sw_fini,
 	.hw_init = mes_v11_0_hw_init,
-- 
2.34.1

