Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB4FCD13D3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 16:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 940AF10F3B4;
	Thu, 30 Apr 2026 16:12:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pwcCNmaG";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011032.outbound.protection.outlook.com [52.101.57.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A7510F3B4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 16:12:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C07zNYQLhrMqKI1ztBn2VGJ0CKMGO/JFzhqIhOnDmeGAhNM/If1EYHTf1ZdjkbMg3YISwLH5stTXkjFnbVda0y363pr6WBI6vHYztqSn6ZWoqWN+AxKQsH6A9FkyUulPmFQwnyYBRh9Zi5vPmHinHfKSbmlAeQmetfQo0GNf8oOHaBdLBYwBxrr/IfuJMNlxFYdBV29ochUwysTr6ixtcVnJ4uYC9Io/G661dg+e3ur3iSRr5DEu3Qagr0P9yTSJ7qCD+CjZ6vgv9YJZpIdpWvunx9MXA9D4TenSGsG0Pzy9aCezkPMPZxr9kLgLsvETidlUWreNMThncbH1GffBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYMP9M2cCV9T8sp/gFzGNoYjFwTw7qEEcXfHdp5/eFk=;
 b=h9JzeghbUlPyeHhDGxYREYnJexWrRGRoM9K1GhTxNptOpv1UNgz5g2VcbrzAdtJV3DXvkZZ2qdL+BGthoy48axkmgEq2UTXfJnK+OD5DyAd/mvNvRh38pX4KW8prlZ7wZNGkq/3LZKcLUMWcSTLmA39eOxWFJJVtRTEjJRvs4e3eYGA9hCOyNDkTC0YltHDT5P2zlK4+KYPB+iUzp8FoqmZaaIp3MJoaEqqjA204IZ0D9GgjroXRtcpz9u/9eks6RQh2cHr02ETNgs19dB8gHzx9lZI2JwxiAFp82cADXrqw/NAdHS9PsxcQ3JvV0znurYhrEBi/dA1XlPy8Uc0xrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYMP9M2cCV9T8sp/gFzGNoYjFwTw7qEEcXfHdp5/eFk=;
 b=pwcCNmaG6jBv2TKnufNRPuFmT5+wv6O3JAUR9ffAtYZrsrgE5ngVe9M35eYESMfNk2+BBMCq4AZDeNF3Clw/OehrzZkxVdwsh7SrJoXiPo5YRZoj3WgPFDIEo+6AzKVSD4rNy0P7tg0Y+43K3tpeQwi9QjxTjZ2ZIBBeDpmwhB0=
Received: from BN9PR03CA0050.namprd03.prod.outlook.com (2603:10b6:408:fb::25)
 by PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 16:12:48 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:408:fb:cafe::10) by BN9PR03CA0050.outlook.office365.com
 (2603:10b6:408:fb::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 16:12:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 30 Apr 2026 16:12:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 30 Apr
 2026 11:12:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Apr
 2026 11:12:46 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 11:12:35 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v4 08/10] drm/amdgpu/mes: route NORMAL aggregated doorbell
 through global agdb_bo
Date: Fri, 1 May 2026 00:03:36 +0800
Message-ID: <20260430161146.2851078-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
References: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: b8518d9a-ed38-4937-58bf-08dea6d351d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: vJO77WutkPcI1ss7EQ7imfCMWFnjwdhM9Z/gJ/k9AOjMMqu2KEFvFdqJW0WwKCmT0JvQhrtpm0XTJLEXYlahzbOdI+CDDb4+Qw0MGaEpDnYngSXkbkZiHH16kL1lMF9YaAZkWfc8Wr0h5bySlnqpVmxq1xLqy9JCblydAkwqO6sYhCzny/GJOOi1nEspB0tknYBqVkOINIIkLCay3UZPodNYmBajDkwtcbNkeZ9/fcZ9vs5HD8w9XjrSWXSsZQ9wy57MqKs1K5KLk0gF26akn9251kBZ4+KJce1QaT17RHJHJ6Ugrd+77kZtQD/SrgCXkP3QV6djIqqVLLjJf28WjxxoJywid0EvuaBpGRUQn0WfRuDW4q6JrCGHjGXIELTDAS32gz2c9MvV6yi/GpDY5+5W/XEpOiIL23GPCP5prlmW+v8A3wgP3wBSvoMIfKmtXK7bBPxAsgHoSvOiHDW+giOG24EjQNkwJ6l0bhTnjdyk7vaejmLQ2MfEjDVi6iSLFMMUMkrpKs75Fs5Pv6Oe76Q1iub0gDl3zhAyzTuRl3sUuoP+icILGLsQegqJrUy0tEvULei6P+qVXLYJxzPbuHA73m29MSHmq+zqw6BxHCR5Bb3oIaU7q8NDkFLwVBQ/XdvfTo2M3S5dCXssTChSzexl/0m0b7JmnXfYRlmlriNXZXwHC+7dv9xzxz0rse1LVCgjiPppHXyHPMeUJYgPv8uOcxodsCUzdG1a5pSHNmRe13DX57VWVQYqr12mqxMozxpXp6N4AB8PUuXChslxuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2NEfwGijrcqJiXk0sGBQgMls7te1Mt3JoGO4Z+LyxRos9uMUtRenXQk5TDn2Aj4dYzLYDMbdfjiXXvzgi6XAAZpt7o07A9HPVYcXZGLrnAvaEDspQa+kQkumlBhY9mtZWJlB3SOCdIahfFS7qWLDB2woDHPPKLbJc7DZhxyBVuK6tFuu/9MAs4Ze7KA7hfSSXZXXIbjWS2SVT0c1WxNZdJamM/ckq0D5qpKa5sg/uo8rBe2iGenwRn9CV94IjLruFqBAVMOqbWYVbi1X2MgrLFhLBUn8RKg5XxTARhnjLMv50CSIq2RJFD1aJ+Y0gKkZdGLBCkHic562rDThzpuSnVpRWNMx/4STctckT5mHl1if7rIuDU9jfE0G4q+B8Jaw54aPOiKqGx0Cl8KLzgQJC0Hjd0tQS/IH9O20cyA8JA3aNyxp3ov128Pg3hyuejPL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 16:12:47.3802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8518d9a-ed38-4937-58bf-08dea6d351d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284
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

From: "Jesse.zhang" <Jesse.zhang@amd.com>

SDMA UMQ submits cannot reliably wake the SDMA engine via the per-queue
doorbell because LSDMA programs the HQD-slot DOORBELL_OFFSET register
asynchronously after MES MAP_QUEUE — early rings hit a stale slot and
get silently dropped.  Going through the MES aggregated doorbell works,
but today's slot lives inside the MES kernel doorbell page, which is
not user-mappable.  This forces every SDMA UMQ submit through
amdgpu_userq_signal_ioctl just so the kernel can WDOORBELL32() the
agg slot — defeating the purpose of user mode queues.

Allocate the NORMAL-priority aggregated doorbell inside the global
adev->agdb_bo.  MES is told via SET_HW_RESOURCES to monitor the new
location — code unchanged because it reads
mes->aggregated_doorbells[NORMAL] which now points into agdb_bo.

Suggested-by:  Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c  | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  9 +++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index bdf2561b5404..974dd7a3fc4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -28,6 +28,7 @@
 #include "amdgpu.h"
 #include "soc15_common.h"
 #include "amdgpu_mes_ctx.h"
+#include "amdgpu_doorbell.h"
 
 #define AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS 1024
 #define AMDGPU_ONE_DOORBELL_SIZE 8
@@ -57,6 +58,29 @@ static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
 		set_bit(i, mes->doorbell_bitmap);
 	}
 
+	/*
+	 * Relocate the NORMAL-priority aggregated doorbell into the global
+	 * aggregated-doorbell BO so userspace SDMA UMQs can mmap it (via
+	 * AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL) and ring it directly,
+	 * bypassing signal_ioctl.  GFX/COMPUTE NORMAL queues are unaffected
+	 * functionally — they don't actively ring the agg doorbell; the HW
+	 * CP_UNMAPPED_DOORBELL intercept wakes MES for them.  SDMA has no
+	 * such intercept and needs an explicit wake path.  Other priorities
+	 * stay in the MES kernel doorbell page.
+	 */
+	if (adev->agdb_bo) {
+		int r = amdgpu_bo_reserve(adev->agdb_bo, true);
+
+		if (r)
+			return r;
+		adev->sdma.agdb_offset = AMDGPU_NAVI10_DOORBELL_sDMA_ENGINE0 << 1;
+		adev->mes.aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_NORMAL] =
+			amdgpu_doorbell_index_on_bar(adev, adev->agdb_bo,
+						     adev->sdma.agdb_offset,
+						     sizeof(u32));
+		amdgpu_bo_unreserve(adev->agdb_bo);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 2bf365609775..11cefb4c3a27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -144,6 +144,15 @@ struct amdgpu_sdma {
 	struct list_head	reset_callback_list;
 	bool			no_user_submission;
 	bool			disable_uq;
+	/*
+	 * Dword offset within adev->agdb_bo for the SDMA UMQ aggregated
+	 * doorbell.  MES is told via SET_HW_RESOURCES to monitor this slot
+	 * for NORMAL priority wakes.  Userspace mmaps adev->agdb_bo (via
+	 * AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL) and writes WPTR here to
+	 * wake SDMA UMQs without going through signal_ioctl.  Reported via
+	 * AMDGPU_INFO_DOORBELL with query_hw_ip.type = AMDGPU_HW_IP_DMA.
+	 */
+	uint32_t		agdb_offset;
 	void (*get_csa_info)(struct amdgpu_device *adev,
 			     struct amdgpu_sdma_csa_info *csa_info);
 };
-- 
2.49.0

