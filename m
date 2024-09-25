Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F4FCCF9ED
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 20:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DA6010E867;
	Wed, 25 Sep 2024 20:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QFGqJnjw";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 940B910E867
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 20:00:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgM5qT845aJqHSpV8UyyY+uVAW3eoGlu0uhPUFNJW44O8H4g9wJcSkB6FLzYcl9XiJH4A8mo+YB0alkoAJe9qLIH/8DiwluB08HouthxF1KVQmANeH3uTHy1jxVGOcBaI/rsvRsbdw30vNGOpkmpIV6/osDcI1jwxg9nt47Kpy1/JHwaPdgSXI5x2hCd3fSNWUscq0aQ+ypMXJYD5mqo92wSeiHfUYQoyTWtlolZuFiyeHgg5xLvTblUEu4v5Jl2BEJxfromU9WTyFXIAzbgIHdUHxGMqipLy7f+w854smIXPau8BFEeZq670e6W8kfOWi1eR7CKO82TEKOXTYhFnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NV46kft/If9E+1EH/6ZK2NP5TLlO3FF/8axyGNWNzc0=;
 b=Un4qDpB2Pp540lM7gG5iPyz46mIvxxmulD1Q1YDjKD2RCAZYfc6qtOa0MSmpKvxrBPOdcX1uuX6vFfyqVlLPHZtApf4MeZkBKxyKMhMx2Pvr8AsMXu9zSgZLXB+OXkyUtXMkTKnyYjg4swQE06J5Di+cEj6Gnw5kagzxPRbGKWqp45mLG8LtXG8ywXyBzRhlNC/eOvtVpjowKHaqO3FroVqIeCEWBpF+EcwOWDFKdwweA2HyfE//4NdWUev5Mn4BiF6p7nFc2NE8yIwOF5EWQ2HWWklX+1mBRGKMxsODg6PuE47PClUU8XPzq8nj9ShfRSp8umkLILBI4lijVgit9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NV46kft/If9E+1EH/6ZK2NP5TLlO3FF/8axyGNWNzc0=;
 b=QFGqJnjwRbDqLCdZgcD/vvuqfQjzE4RjJKMmg5pidYSWgxOZ6IXcCimqTkGrrJKZGi0Q5EdY7655X8K2gONtt9W55WiYm1Gtnimx6/cfWw566d271zl7KlSqLNHCNEprSIxmfNd9VWlijP/DePPWyalSabIh76sP0QEi+zFq3l0=
Received: from SJ0PR03CA0187.namprd03.prod.outlook.com (2603:10b6:a03:2ef::12)
 by PH7PR12MB6442.namprd12.prod.outlook.com (2603:10b6:510:1fa::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 20:00:09 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::3e) by SJ0PR03CA0187.outlook.office365.com
 (2603:10b6:a03:2ef::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Wed, 25 Sep 2024 20:00:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 20:00:09 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 15:00:07 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2 05/08] drm/amdgpu: Remove the MES self test
Date: Thu, 26 Sep 2024 01:29:25 +0530
Message-ID: <20240925195928.142001-5-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|PH7PR12MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a77a28c-0a47-4a25-2b43-08dcdd9ca882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzdtR1ZwVktWSWVyQzk4cWdFVkFENFpFNjFwYmhIM1VPcHVHRHQ5N2xUKzQ2?=
 =?utf-8?B?ZTluZ2tET29OS0FYRzA3VThtWE9JbjZBZ29wVHBQeHVZSUV5R1hoQjhteU1R?=
 =?utf-8?B?eHBxdHN0elBKNC9mS3dCa2pSNDUrUmNwTkxDM2JjcWE1RHZFRFlEa1YxVEZs?=
 =?utf-8?B?ZisyVWJoRUJFanBxZkZ2ZlYxTXovaS93dzhlNGNMY3RDMXBrWEZScGgrMFI0?=
 =?utf-8?B?Q0NBWDBUYUJ1VFFOSkhKMW1wTFYyam9JSXpCbnJZbkxhbThPVTBEYVFyME01?=
 =?utf-8?B?dnBySG1LWm1HeXN6N1RieFFYaXhVc1N1czFOeE5wdHRvbEI5UTRzM3hYMlov?=
 =?utf-8?B?bFZaU0NNSDVwTXVEdnJ4eFMrRWIzTXZNM3lqYitwcDFYZWdwdW00S2M3Q0Ur?=
 =?utf-8?B?WTMreHVLeTNLMDRNT0YxWVpBbXlwdGd4b1dXRkU3eTBkUWxwSnRLemsrT2hE?=
 =?utf-8?B?SXBDZ3ZubTJlTHBBa0pGSDRtMk1ZMWpkTlk2OFVKUnRvcURRSU42U3NoV3dJ?=
 =?utf-8?B?OXRiTFdQOGxJWEcrQThFNWpiUnJSMmVySGVLMGdCTTJMdW1Kd2hUMzFsbUtZ?=
 =?utf-8?B?MXIyQkN6RkpYSTNoblBMdnZwNmtIMmViUUZSdFBIMm1sWnhPamE2RXJvYVli?=
 =?utf-8?B?NjFHY0FMTFRQdkJkOHQzTUNyTUVwOC9JUndzS0EyNzBrQVlURHdMRkNldXZX?=
 =?utf-8?B?UlA1SXJ2ellHZmxXR2F0QU5JUUpHUGJkVjFQd0ttZXR4dW1BdSs2R3NWaGUx?=
 =?utf-8?B?ZnZoY0FaVlN3SmhXemdYa1NkenlOVGdlaUVqOGpTMGUwbjJ4WEg1TFQxYjFW?=
 =?utf-8?B?UFVocm1IeXdNZE51N0NHRnY0VnJPM09LUktPUW1YaGFZQUJscEhzNjhHSC9m?=
 =?utf-8?B?ZjY4Zmhpa1ZiaTFRYlBWSFNrcTN6dEdrSDdLME5YWnpiUmM2cnVqM1pCbjFO?=
 =?utf-8?B?b0l4VkZrTFNPdHVocktmejhkdEUydnA0bTZwaFFFelVjY1ZWODVyRTBUdlU5?=
 =?utf-8?B?V1NpZ1NLazlJTkpGOENlbVI5UmxDQktOUTdYSkxhWWtpSVR4aVFKLzFiSTRm?=
 =?utf-8?B?UmVSZEVVTnBuVnpETFN6eXREOUF6Q1RiY2hOVGJjMUNhYzFYbEZnUmwxWm1N?=
 =?utf-8?B?NExaZVoxaGd2aUR3Z25vSUdVOTN5SWVRYUFaSlUxMG5PK1dTSkIzMkdQZVRk?=
 =?utf-8?B?ckZuWXFUU3ZucGs0Y251aUFiTGZtSWxTV1ZSSFRkWU1ZT0pqS3JOMjZLUEJ2?=
 =?utf-8?B?RFZqNjQvTXJXOVFCdlI5ZlBvMTNvbG9Eb0sxYk41bGxrUDBVNldGbDV3bWZF?=
 =?utf-8?B?M0JuMmR0NWJHNDluQXVldVJCVnBaai9HL2c2U0REVlVkZGg3SFN3Qm83M3Fz?=
 =?utf-8?B?ejV2SitVNWRTeEFGbzdPYjc1YXVnZFloYkRJTmV6TnlHU2VsaWwxWUNETkNh?=
 =?utf-8?B?QXkrU3p4MjlDQ01DdmN3OU8ySDhwN1Zhd0RISTRrc2hLajRuazd5a1NMQS8x?=
 =?utf-8?B?dHBSWWhQNmtIYTgzaWlGTmY5RUZwc0hLUEdFKzNjSHFkMXFPSi9CWDdrZEdj?=
 =?utf-8?B?MFBKNGp0Rjg1NXAvdzhCM2Voa1N1bnpOaHFXY25lZmJDUFlEQ21wSmhwZkZh?=
 =?utf-8?B?aWNNNGFzTy82L2x3UXVQZGVoSitJTmMxVnAvRUxRYkJQenJFZUpFNm9sT1d0?=
 =?utf-8?B?d1lENzNyTDZsM0tReFBjZXltMDRMOHdRSEFGUkkyTUtrazdBelhoeWdlaFEv?=
 =?utf-8?B?UW92TXh0bEQzdXRCVDJjTVZzdk5BM3pXMEdsRmxqa1cyd3AzUDJvY0ZTVWx6?=
 =?utf-8?B?RHdGUHlxNDdRbk81SHZqbHlhamJTejg5VVBtd0JnOTZpWEd2SkJjNC92Z0lB?=
 =?utf-8?B?L2tKWm50N0c2a2gyVUd6SGZEUXRyZkpmc2VoMXNuY1B3M25hdWFBS1ZndDBh?=
 =?utf-8?Q?WqNmlOO1c7VbSAcJcRo/c6o+1kRyvo7C?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 20:00:09.0726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a77a28c-0a47-4a25-2b43-08dcdd9ca882
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6442
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

