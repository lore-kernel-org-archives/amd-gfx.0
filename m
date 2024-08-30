Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B767CA100E
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Aug 2024 18:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7775C10EAD6;
	Fri, 30 Aug 2024 18:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qf2stYP8";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2337310EAD5
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Aug 2024 18:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiqcE/07mN8ykJkml+99bALBbCF9XLzRX+CkUaw3o8wjNdLHeO5sEduPv1mJDifN5hOz3rh1vP2cEPQ9i4Wmz+3d12CK0rwJUuf0UW7WOdyBqz3WHp4DcV+2iUrdtknwiaSjG7GYBX4OFCZloMCPQugsSZyPJLgN/a2hnXX3GgGTwzYQLu3KhZvZg2B632F/w5SJiUqs/fXewj3oWWgECdClSjGRWJj0lDeFnvKt1dkIMd9inwIYnLNS8i1cZND35HvWcLNpUyUJulP62PK5KvPyHjDCOtNyGiUp3yfjnwjXDNzbnwr0g0jv5Gpil0+3JlbLxOTL5QRf90RPC/uv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUPghYpzLtRqjiGY1OIYt+ZP0in4ggor0h4VrP23ZaE=;
 b=Bin6zFx8S04lNvll6r5qTJfwCNSCpAgH+adjBLvrir7tAes7gV//Pkvh+fqSBNtbtnCnbRC2CxRxsINIVlzY7Xmu47go0YGdxHlyDmBFIpzX49lXZ7gpov84t7VXQ39LZ7tu+fUkqxc7aUGOJQxkRRkyMolwN72iyF96/3rKa7ELKNDbmIPI+80l/VDXPSVB6yVNXikQtknolKGzwB+P2ohCl4YcCV7aBOMjwAqJ+rnhILwk86+l1V7ctsqa5Ty1HFyqdqBZBfU9s3nU2Fw00Qp5FCTK7QaHlw4QEoAZeDk9+vaoU+TXOcXoxJiHUdHo8Tw3hO/zJZCQ32ZcK0qtdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUPghYpzLtRqjiGY1OIYt+ZP0in4ggor0h4VrP23ZaE=;
 b=Qf2stYP8jPTrHQ+v6xHg9GOQsEaYpgrDOonX1h+5pi/JIreHQcp2hOns7e4wJnYeX4/jO8+jr/lq4o+InwWOzY+hygIZAFO4LKmrjhUxJJ3L23y+ZgjTjNY0fFKZ7LP2x6jsI+YXHpQcZKMomCr3V/rWPUqwG5ODnwdbYqRUgCw=
Received: from BY3PR10CA0015.namprd10.prod.outlook.com (2603:10b6:a03:255::20)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 18:44:10 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::6f) by BY3PR10CA0015.outlook.office365.com
 (2603:10b6:a03:255::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20 via Frontend
 Transport; Fri, 30 Aug 2024 18:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 30 Aug 2024 18:44:09 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 13:44:04 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: Remove the MES self test
Date: Sat, 31 Aug 2024 00:13:21 +0530
Message-ID: <20240830184322.1238767-5-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: f9d57c5e-8d19-4648-2afa-08dcc923bc75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i0WiNK4y2kkwFnrkbwiv9E/JjzKFAx0szGw5Qmt7BpWz7OaePchz3mOIi6c5?=
 =?us-ascii?Q?owINGE1dypuKymVYi5rozID9i8W+SYORsl8ULzxw+5LI3KVslqtKUYJ3/B1+?=
 =?us-ascii?Q?yPi4Hqglhtjku0A7hrf/FYCBbHkQOWPKVneSyi1PK0nEo+jfB6J9WkghetaS?=
 =?us-ascii?Q?jinYJVf9/e+3wv3/A1OIMKMtAxzXDuYpPKgnAVFA8n9IYih3Vl1zIIxB7n+4?=
 =?us-ascii?Q?EFuuqQ3kOLVF+7/6IEkaB6S7tYCOrJZq0opSP4VQBkPuYChZ6UE8kiBb3rvf?=
 =?us-ascii?Q?XHmvY/CDIWAjvcr2N40rXzbVc071D0SlDG0i4l0D+sw1FxZFBe4aEOApoKIK?=
 =?us-ascii?Q?Lu6MrQ/p0VlvvRkqJQjJrDUVZ82joFyqT4HVxAjNk9s7MIv65zHuE3rCWF5H?=
 =?us-ascii?Q?Arx/93IgwxzjDIIOxh6wu9wBeDYh3tNLEItT0d9/RN0BKSfAs90F6zj8GTJu?=
 =?us-ascii?Q?zBIjilkJq+I/Jv75NB51O0B6tlL01oai2rhndKqFMS1X3k8QMbEjFs7fAeWH?=
 =?us-ascii?Q?eBAJ1yicdzdAssZGC0ZpZ+YWyfb46beg2/puAC6LopvKqIf2NSJ00dqdcyvJ?=
 =?us-ascii?Q?+Fyq+G4aSjeZ/kLb+B3/g07pW2h+8WIslGbVMcEjUpLcToE1CVYqQxLbKT5u?=
 =?us-ascii?Q?3zNDpNwlhDR4WCPvn2SxVGEer9VI0nifg4wMfu3BeQp5VySoGwY74unCozZV?=
 =?us-ascii?Q?F/qhL5jszFT4EtYVHc1lokibZE1XhdUs4GpjDfGgoKn59U9Zv7SB+oVEMyIE?=
 =?us-ascii?Q?QNrdrj8FMoj99SrV+PLjcVNVNOEQhpSBfH9j6kBwZY11eSm752Op2rTuJGnp?=
 =?us-ascii?Q?udcIiE61pBSmXum4/uV2ueKZwDOYatIidUyjixgVEnqU7mDRVCjtuaBOVa3t?=
 =?us-ascii?Q?pV1l72KpMDARbGU3td3WxiDanTtVCNdc0xIh2u/cEwdFgZA3th8ZYJFl6Bho?=
 =?us-ascii?Q?6yCiY+iMI6D9CAfbp1GYFOr1pdWyJ09xxRJAFG+1Nl7mu4e1LS4DBOpSXVlb?=
 =?us-ascii?Q?rgBl9n8yde9ypcwm1p7yEuNEg4FjVkkqgd+nSYwjaKTSssK7g60dlq0WiBwp?=
 =?us-ascii?Q?snqoku+mZzq25avtBW9CNd58ZmhAmsVI14Zto5toKYmi6mH1ovcmvCI31VTF?=
 =?us-ascii?Q?6CCfcHzerhflCHO8rTPCy5jBxcZMXQFNFIuq2TYlxlEHL7uPHuuOx/N29NXt?=
 =?us-ascii?Q?vFWibQPPBkAF+VejW3BDCvhOZiGfZdjr+LjYSMrx3YMbNR6yffxE/Dg0CRw9?=
 =?us-ascii?Q?xLa5JynP2CQ6pjyu67DsNO9MtOnfnwdEMhoCi8FcNO3CSv8bxWTe/ovT9Zur?=
 =?us-ascii?Q?ZSy0USvtbjYPttOc5KJ3WpQPe2t/HxN7paRVk1eCynHV8LaU2u68TemvMfOL?=
 =?us-ascii?Q?0zNrktvfJYdRIMF71iNwh8aPJx6NubUP5cTpNO47zuYC3jQpqWKNWQZYAI23?=
 =?us-ascii?Q?XpUM4ke9Jrm/5iUFOuvEAuVYugyPv2XG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 18:44:09.7445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d57c5e-8d19-4648-2afa-08dcc923bc75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
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

