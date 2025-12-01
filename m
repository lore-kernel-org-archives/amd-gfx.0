Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5096ED116F3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 23:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1CD710E4C3;
	Mon,  1 Dec 2025 23:15:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X6ze5FgP";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5767310E4C3
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 23:15:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KttEBccSJXpzqCbKUkMfc18IELBrvalVUliqctTrvmrtEU2fbAu39Fnb10ZfRfzKRfbLjjwbSd2h/JbAgT2Mz7FHgbcbu8qW7a1KfP7I6bgfw+V8JRgVRxpFwLq3Q7k+3NO8hZoj1HoYBtbTcmvSZEHvWiB7R6o/YC4UkgI3RzuSPGyqRknRCf9Jl09PaId3DbyWjQd8F3IvtMBVUPjSmZbMEmUThp26ypC+/ZRggxQj6/l/RZKhH3zEN1+r7DW08UHrKF3uTUB1f+9fdS2mBPwTpE2u6rZYlBMt5Z8IlWPj2kdqJAjzoBCqePVd9HjP9prlIlmRSG4M9Kgmyuh0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOIqYPBZGMgQADf8y4motdGmc9PI4UHZEUdAcFxk+Sk=;
 b=YddtNkjrnaz4tjibZrixxAf6AMBThD0tI66doz3ItL5tDqL1UVHzabtvTmFmVZbC3Ke6dROjEg+fA0/TAjM3c7SAzMDY93pGfOjxaBKiKDK/XbglooBgZsjIm40sDVJNu7TrHRW3htUuzyeTT1UVfEcYOP/xIpOI5fJF6O7BNyw+imeWS2MeDQorA8sa1BGAOzGRFWKjkeiCHadTUJ8aoB0JdovmcPtJr9lQVGNtWgHQBnkaYJo3shWbusmMOll6o+XRs3cGrfNEZEsIVyJSZOBQ0vKWojuh1YpNRtKWj3IlPwiSzrBs3MebRsIHWMXh4ttv9YN9PDK1i8uQ57v5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOIqYPBZGMgQADf8y4motdGmc9PI4UHZEUdAcFxk+Sk=;
 b=X6ze5FgPY99iU4jmxm8vpUNL/Ubx6Tc9gFLJ1Aq6HpNzEp2yO0aPevhg5BwpsIN3lH+jmUO+sN7+OVyg1kOZLjOoghtan+Z9T3a/LPsUQ02c55iQQLig/FTE4BQES6xcMU9bOJGf/GnlZ0yIiRX9EMlEBYSRwcwTV5wiRtE/7so=
Received: from SA1P222CA0037.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::18)
 by SA1PR12MB7294.namprd12.prod.outlook.com (2603:10b6:806:2b8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 23:15:23 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::af) by SA1P222CA0037.outlook.office365.com
 (2603:10b6:806:2d0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 23:15:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 23:15:22 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 17:15:21 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix SHMEM alignment mode for GFX 12.1.0
Date: Mon, 1 Dec 2025 18:15:00 -0500
Message-ID: <20251201231509.791954-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SA1PR12MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 46048cc5-8b84-4b0b-1479-08de312f8098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L5TCMtkQakLkhuqV7s/rFR1DtHvIQdjiYFsIq55RWjqdr8ZlF3I5wlHxuOaX?=
 =?us-ascii?Q?CJv9ACwRu72gU5QAGW/xmYZPFk+/9WlKEcnv6TxMum2z6lUeOlTcrJpbJN2b?=
 =?us-ascii?Q?QRNCrcOsmW5S67ix3SFNro1oxgkuc4E1zrXMKY5vYWTKfsfFIX9QNguipAXL?=
 =?us-ascii?Q?w+9WAUNJvipyIvSlmpytbOyVsVm642ErPMpm+17LUWgrOXaSg5XmS+D15pFD?=
 =?us-ascii?Q?UPpsJloN0ihgrv3VayZNc09nEc0StIYdC7mFHYsdgOjzIVs6zt3wdEndgYvi?=
 =?us-ascii?Q?QJU1WmNOFnIIucJE+fVEvrRxtgtrTkJnb/ExIK6ZVFXNGy3O8Wy27VNxJhtA?=
 =?us-ascii?Q?b5A5ZLe775yLF+PHXzo8wEm2djroCr5R8vHv53HJ0uizVZDsRbR5neArxY+f?=
 =?us-ascii?Q?eMqNHbjBZ2grJvbTI+Yug1YWZa8ynrKQB6wSDv/0lx1pOZB4Y8uMcXXoVUVI?=
 =?us-ascii?Q?SmdQb5/sO8ql86NYlWRhaKoCx9IvDkAJ0gNoXL9d97xds8jSDJR54AWZkTHx?=
 =?us-ascii?Q?EMIiAnn9DpaFHMAeEnoWSV7EMGF83BamDWpDRrixGA2aL7++vE9k7DjWZJ9Z?=
 =?us-ascii?Q?gGlB6TC3rpaieLUMteDYlZ5av6Etkbi1ZQHnfCFBLiO3KDVmvpJFHv2V1Uu+?=
 =?us-ascii?Q?gXY8LRoPUUyLI2B79UEIEnUFYrOIm+r0eAq0KL+RGqP7WUZ3YF3Gmduz/WPg?=
 =?us-ascii?Q?2xjt0raH84SVoH3k8q1+CvKpcpWlGBM3JkDbpGKMp/kNQdKZ8rYavjkxLwPW?=
 =?us-ascii?Q?wzxXaUcG6byZ9yLOlb0ITYU57FrLTFB+HWvsMuvBE5zk60Iknjs0/UekM+U1?=
 =?us-ascii?Q?aiyCRvSIDCHuIaYCJgIOlbecioRjal4oI9yUxzjBwnv8Q8Gs3D52f0dx37p8?=
 =?us-ascii?Q?yx7EnThEQdJpYPrck88APyo8G8XKk01w05Q4MlytGx63oS9LQEY2ubRzHQ0E?=
 =?us-ascii?Q?euq9HgO6brcG9F7eyQVK7HGTP2KJ/xEgG1BxDPVs7pdsqRzHDkJthMXMTjar?=
 =?us-ascii?Q?QwBcv4ZgY/e1cfQOOwlwgACW0TbRmJWfvQXysSDe267h67Q55D0fSFm18hqV?=
 =?us-ascii?Q?YjDPp57WPNcvA9vGDuztiwXoURuzswu+h1MFhyarkbOkL8lay6DvX7h5xxDI?=
 =?us-ascii?Q?N0nM5L0XWrW5c2WtMveGLf4iE8gr5mNiZlNDnptXki9IFownjGpDfKr9RKU8?=
 =?us-ascii?Q?fG6q6l/pqilDwSCn7OifF6IQ/e/37KS/u8ncSekb4SIabT3NhrqZDm6EzJEn?=
 =?us-ascii?Q?iRSqDUo8Il3+rh1UV5lSuIj+7OKqSVjXusWlR/okmbQtscPi8vKvedjQ/0x6?=
 =?us-ascii?Q?guZA/fB4jyoaxTHu3BGctKcPFxw2KbjO6J6Q+yEOSBQa46pZ6vZwPGztQMOo?=
 =?us-ascii?Q?zIjXF2QIRlBm4IAY/MiB8BZQpUV+T/dfvX3/nEQpNSlyRNfazVHuiUntjUsr?=
 =?us-ascii?Q?m8bO6uAaKFalgRZPKendLbBpL3aAK5Px0rUwSZxkdw8meFE/b5aAJzatAWBF?=
 =?us-ascii?Q?ateqVwjv56bPvk+iXNiJdzhwh9rErUf69XmDICippgm4HRd0B0fD/IFJ22Ch?=
 =?us-ascii?Q?rDpFZVO7kRDac4Rp9D8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 23:15:22.3430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46048cc5-8b84-4b0b-1479-08de312f8098
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7294
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

From: Mukul Joshi <mukul.joshi@amd.com>

Alignment mode in SHMEM config register is only a single bit
value on GFX 12.1.0 instead of 2 bits in previous asics.
Add a new enum and use the correct value of SHMEM alignment mode
when programming the SHMEM config register.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c                      | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c | 2 +-
 drivers/gpu/drm/amd/include/soc_v1_0_enum.h                 | 5 +++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index fbd7d10b16bda..14baf9423c89a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -52,9 +52,10 @@
 MODULE_FIRMWARE("amdgpu/gc_12_1_0_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_1_0_rlc.bin");
 
+#define SH_MEM_ALIGNMENT_MODE_UNALIGNED_GFX12_1_0	0x00000001
 #define DEFAULT_SH_MEM_CONFIG \
 	((SH_MEM_ADDRESS_MODE_64 << SH_MEM_CONFIG__ADDRESS_MODE__SHIFT) | \
-	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
+	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED_GFX12_1_0 << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
 	 (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT))
 
 static void gfx_v12_1_xcc_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
index db7675c1498de..e4ec7190fea14 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
@@ -24,7 +24,7 @@
 
 #include "kfd_device_queue_manager.h"
 #include "gc/gc_12_1_0_sh_mask.h"
-#include "soc24_enum.h"
+#include "soc_v1_0_enum.h"
 
 static int update_qpd_v12_1(struct device_queue_manager *dqm,
 			 struct qcm_process_device *qpd);
diff --git a/drivers/gpu/drm/amd/include/soc_v1_0_enum.h b/drivers/gpu/drm/amd/include/soc_v1_0_enum.h
index 5a0963eaf3b9a..2a910785334db 100644
--- a/drivers/gpu/drm/amd/include/soc_v1_0_enum.h
+++ b/drivers/gpu/drm/amd/include/soc_v1_0_enum.h
@@ -30,4 +30,9 @@ typedef enum MTYPE {
 	MTYPE_UC			= 0x00000003,
 } MTYPE;
 
+typedef enum SH_MEM_ALIGNMENT_MODE {
+	SH_MEM_ALIGNMENT_MODE_DWORD              = 0x00000000,
+	SH_MEM_ALIGNMENT_MODE_UNALIGNED          = 0x00000001,
+} SH_MEM_ALIGNMENT_MODE;
+
 #endif
-- 
2.51.1

