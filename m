Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410E1CFC274
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 07:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3E1F10E524;
	Tue, 15 Oct 2024 07:43:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fx03EcHl";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC6E10E524
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 07:43:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMzzyw1cIz5CAAcEec071UvNPJobC3t+PQiAcUBS4ohtFBZAN1UlKz48XU5M8kN9WqbJ+O2yAslA3aMhrTpL4r1SETHq3FSmPZ6DwEuQi2NghyRjzgN6/4Q8LT9AmD3vE/eCy6LCfTbWzbX4oXNYkiTRrHncbu4jNvtQ0QAEqrp3Ti5cGbZaN9IOABE3PPwhh5pjwit/EBFh8AJWNUVnYZUzNVEp6It+a8a3Oup3zGtpkOfjZyK6ZAurva7IzGdgwOOFJ3P4QrRYw5tYpAEICP1N36Zb61SkEkj0goeFv+PX3I+N/y+FsVAH60mpMVhAT+OHJlRj0pAU5lL16nsnyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NV46kft/If9E+1EH/6ZK2NP5TLlO3FF/8axyGNWNzc0=;
 b=NDs+sBWt0uX2zNAT3gibGRzHMyirUssWG//PVVfWuM0jXHt39h31Hg+c5NzS0HCfYSmF/m04+3oTavAvnwR9tAkiwMFTCWyOMN8XkH6AYwPHlCfxmEQsEZNjYkc1zkT6vmdCnoRL6y9AtChC7X1dXlR9japspS4deiLTJYu/JER51hqu3Y6vM7R1Mer5fru+WzeqeNsaSiMSeWE63AlqD9QfTU4bYO3A0V60bTdauIL8n7HkhgHNN2Q4FnuJQc4sOICGFpgr1S2ItzFg2CIOPRJQZbPnTZLBaP7Bdesfn9YS4iL95GfL3mBsb5tjHr0pFJeArZ15s/obCXA3fLCpHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NV46kft/If9E+1EH/6ZK2NP5TLlO3FF/8axyGNWNzc0=;
 b=fx03EcHlTQHU5PL9zoa4qdA23s6JV+oquCeYChFkIDrfCRV0yCXWTSVeD8ukHrjBHc4BcHCQLROjV6nFzEpe8iDM2uUy/90bN82bNggyBdO1i38op5RulpLoa2J+LoxgEq+J+RJTHGttcMpbVkaRROAOKhkn83wqb6gQfDeps1Q=
Received: from BLAPR05CA0031.namprd05.prod.outlook.com (2603:10b6:208:335::12)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 07:43:41 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::51) by BLAPR05CA0031.outlook.office365.com
 (2603:10b6:208:335::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 07:43:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 07:43:40 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 02:43:38 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v4 05/09] drm/amdgpu: Remove the MES self test
Date: Tue, 15 Oct 2024 13:13:05 +0530
Message-ID: <20241015074309.2484264-5-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241015074309.2484264-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241015074309.2484264-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 286e12c3-c8ab-4711-009d-08dceced1664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2dibkpwZ045NFJ3UTEvd3FnQ1lZY2c3UUhXbUZoYVZ1cTFFb0x6Q0FwOVVr?=
 =?utf-8?B?WTRNV0NEcVhtaFVpNUtEL1hJQ3JqS1JXOE85Um5OVFJVNi92SjFlWnJOMG1p?=
 =?utf-8?B?WUczVDhhR0pnQXV5RzVzM2s5ZXNGc0gwekNWU0dnN1RNcjI3c29zZkZvWndu?=
 =?utf-8?B?R1VGK0lWaFlOVzNLNFViaUZlR0dQNEFYRWRpaHJLdkdqc1dCeURVeWlUNUxy?=
 =?utf-8?B?WXF2MkJVdThxeS9kVEoxSk1RQTBuV0RJc0wxWkh2SjNOQjhiVlZ4a1ZGUm9B?=
 =?utf-8?B?TmJLaC9sVmZubUhtc1BlQXJoeVlsekVwOWRjdXltTzg2SE5LSnBLcVI1dzAw?=
 =?utf-8?B?dndESllMU2dWaVhJQTIrY1B1QTV6SnVjT1BMajFjYXdqWXZYK09yU1NWR1lt?=
 =?utf-8?B?L0xKVUJrdUFKb0xlQUdtMjQ3SjlMenk3bFJXdFVFRFFtZkNvMDlzcyswRHJH?=
 =?utf-8?B?Z0dnNC9NWmdzZnVZZHl5ekF5Uk9ET0RHSTRCV2U1SHJDVkYvRm9yaXRNbG9k?=
 =?utf-8?B?b1NvR1Q4N1NRSk8xTDVBVGxkWXNueEVaTS9PREhxbWszQ203YjNWUkFySWZm?=
 =?utf-8?B?T0xvQ0J1MFAwTm13UEVZZjdaTFd0MFRCdnV5MS9tdWsyajl5K2ZYM1lOaWlX?=
 =?utf-8?B?SUFoMU40SDkxSWpzc3VPMC83dWUzeWNYM213V3lCblJsbTcxdXBjL29zeVlk?=
 =?utf-8?B?ZEthbzFtS20xdlhNYWRnckgrTzBWd2NCS3hFZjlhdnN4SHU0amo5dkR4QVlD?=
 =?utf-8?B?aVlIVEg5VmV1bVBMSkxGOFhHR2crQ3J1VjdTWWVhdno2Rm1aT01YQWE0VU9U?=
 =?utf-8?B?WXFUamlJaGFzSlpBeENNdkhIaDZWUEZ4eHZQcHpPcG5yTldxWGJLTm04S05J?=
 =?utf-8?B?eXd0WFFsMDlyeklPRDhaTTY3dkcrSlY3MWJaRS9zbnNLWEd3V2pSVUVhNFpN?=
 =?utf-8?B?Y3JycEIxWUpDdFZiTmxpN29OM1JKRHMxRXJlK0ZFaFlvejNEOXZSd3hST0xn?=
 =?utf-8?B?UzVSS005ZEd2MmdndVpJSXgvdmhFOWl3bUowNzkxTFprcHRiNW56MmhWYnIz?=
 =?utf-8?B?Rlg5N0lMTnlsYVpUVkhUZEdlQUZ4clVVQ05zTHBaS0Y2dG1ZSG5iWHRPU1E1?=
 =?utf-8?B?M2tvU2tkakZlcEFBVmwyWTVFZnZNV3JRdHhya09qL3hneVZtRmFkamIzWjc2?=
 =?utf-8?B?RkFuaFZkVEVJVnZ4Q1h2cGdEemR2Z09ONUVSRm5GRmN6T0x2clF2aks4NlE3?=
 =?utf-8?B?VFowdmxPekhQVG1tQ2ttUTVxUURrUWZpYWJKV29kby80eEtpNU55VVFPdngr?=
 =?utf-8?B?QjVBUjI0NkQ4RkoyMTludVNDUDVsb2tERFRpRTdXTkZGM2RKclZ2dm1HNnRL?=
 =?utf-8?B?aXdTYjhTNkxyVmxoM2MyMlg0ZmNkQVRvWE5TbUJlbUlydE5HZTZYRGNUU2xY?=
 =?utf-8?B?Ulo4NXIrVXVYNlVzUkpVWnNZQVpveGRycHNMNm5sdk5kUnJSK2RoeGNBTDQ2?=
 =?utf-8?B?ckdMTmppSjh1aVZGZjlvRlhBeWZiNGlIandlUjVjU0VvZi9tTW52OXhYT0E0?=
 =?utf-8?B?dnpveHhVMk5UV3duSXQzMktLMFlOVkJINjJRNllOL1hMRnhGWXVxRzE1aTBO?=
 =?utf-8?B?YUtOM01iMVM4VDRnWEZIWDRkQTFpNmRUMUsxTjk0cEpNWDFCMy9yVE43U3g0?=
 =?utf-8?B?ckZKdjBFeE9scng1U3MrQldYREd3N0Vmajlmb2xGVXVacTRPNFZ4ME5ZVHIx?=
 =?utf-8?B?VHMzNzZmMHZIUUVxYitWNzIvbHBFclZtQXpmVnRrQmszdVg2cDZ0RXE3eGRP?=
 =?utf-8?B?WVBkQzJkaVh6MHhMV1hYd29vY2prUGRWdnRhSEE5SmpPL2Z3cndJN0plMEZm?=
 =?utf-8?Q?51s5F+Gx3zUsS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 07:43:40.6199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 286e12c3-c8ab-4711-009d-08dceced1664
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
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

