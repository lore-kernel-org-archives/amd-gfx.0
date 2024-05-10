Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78799C25B4F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 08:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5205A10E527;
	Fri, 10 May 2024 08:51:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jzvkeihE";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11A1610E408
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 08:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLlwilnultYKptRirl63cG6VBzRC0uMpthT05Tqr6X2qcZ1aqTVNCsOroPxRi8EJynvspz04J72ofdwbstfk7qXFRD2ieUv396FBMpPiBjNs6T2WTen0Ud4RZ859s1P0f3EMVMxisuQQzAdBik+2AAk9RLnoR4EoBieB1/LCPSndnnErg6vQf5biUqyhYx5B9Z4Ek2BSpEJEfGkWNBuKl3FUUpZhLCAR61t5+vdoYcvdXer98m5jlhkSmZiQBUrJNteKSlg8Y1lRrpqIYEA6WaJnJKSJbI15T/+7RImpmBj+LhRwkxMVmV/2wHUpDDV/aeeIZtjbDnEsHfvCPfGVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cRK2gPvLD1rTfGkCz/ISGkG6zb6qvjZAUnSttpD9YQ=;
 b=hRYEuV0as97LtpH/Zwkl5UMdAxcDJ/w6+DggHCqfu30a4DN7r/iQNzHYlU+Pirsk/y5W6HzpuorpLpYY0QZXYv9xHBZfjwuaII3quQUHoud00NoIRLVgXBFtJSblc8flkN9rc+wy953vDIex1pcuP4a8mIHfslM6e5hGkouufcPPuooWky+mcctYJAstvYQYzPBxuKdYTrAj/DGcvriyeWhC6pAGyeuMtiF/wapRf6qzxe5v+AF7gzo4Gnl76r+ojo6M8FPAg9uEAtiPHwsK3m7gkpUV7+mP7Er8uyRdKWqzUf9qn9w3YmCw0Ld7rcqplpu2daR+/aAXhKh/hJuMKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cRK2gPvLD1rTfGkCz/ISGkG6zb6qvjZAUnSttpD9YQ=;
 b=jzvkeihEO+5WQkhcs65Sf5rTnX3vAsiNwVQ00jVJ2RoOcGda998mToGCCeznbaEZCXzYSK77oX41OwgQwrTpH7MtY6B+RTo91yj7rVwjGyn2QQBMFBpPWyHWgwPYiz2ZMcXR8gW0b9BPFl3e8YFYkklZg/eDUlFvbiZigBongVo=
Received: from CH2PR12CA0020.namprd12.prod.outlook.com (2603:10b6:610:57::30)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 08:51:18 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::aa) by CH2PR12CA0020.outlook.office365.com
 (2603:10b6:610:57::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49 via Frontend
 Transport; Fri, 10 May 2024 08:51:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 10 May 2024 08:51:17 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 03:51:15 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v10 1/6] drm/amdgpu: Implement a new userqueue fence driver
Date: Fri, 10 May 2024 14:20:41 +0530
Message-ID: <20240510085046.2718-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|PH7PR12MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: cda80743-34c3-4040-d5dc-08dc70ce5b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWF0ZnBzb3M4ck1WNGxYQzZiaktYdGpDSVZBcm9KaVZRMmR6VnpTbTJBU1lj?=
 =?utf-8?B?Q29NVGdXS0NWS2p5WFBwenZxcDY4eGlNUFJRdXAvYUdQeEJYZFZDRHREYnVX?=
 =?utf-8?B?UFNVbzROeHV3WlB4SlRheGRQcmpKWWw3Ny9GdE85eGYzUTVabERDbUpxUThP?=
 =?utf-8?B?dFZ6VVI2MlhNNDA0SVVVd3hPUzdJeEZXRUxJanlkb1pqUmFmMXJzT0hOdTJI?=
 =?utf-8?B?d2hHN0JtUWJyTHJicy9saDlQME9GZGNHRFFNdGxSanZCd2lIaXNPY3NPMG9K?=
 =?utf-8?B?OTFHeDdyOWVQNmpHeW9zaWJRcEdQN3FyaDRVR2Z3QWdTcnpUSFRwdW44ZGRw?=
 =?utf-8?B?SUhxQlA2Zk03YnFmTXJEVkxvTnp2S0hFY1NHMWVzZlBlbXhxQm1GY1NGWDR4?=
 =?utf-8?B?QlVQdkRGNVkxZWZoSFdFeFJGZzQyaDl1QVRKaldlOXFaSXFHZ1RFUzBjRTBW?=
 =?utf-8?B?WlB4UllKN3BLN0VWMm1NZ3Z1enZSRTREckJoN2xqTkNZTmxCTTI1MUxNaTVX?=
 =?utf-8?B?QXZPRXBIN05xZnlSN0xjNmY5VlkybmxpNmFzQVcybFdrcml2YmNUZFZPT0Rj?=
 =?utf-8?B?UFNwQVdHTEdpc3dBMVp1S1RxdWxmc09BRUFRbzRZcFFVZXhhMEU0NGRvaUlw?=
 =?utf-8?B?SExJRGdsL2x1NHdYYmFYaXc5NnZpU3pQbVlKZU1hMTM3UjdZSGQ4V0JXdjk0?=
 =?utf-8?B?VUdFVkM5eEJVR1RLbW1KTS9nV3NZMWlkQzh5RUVNcXZGN1ltK3ltbkxkMDFv?=
 =?utf-8?B?K0d1enNUYUo0QkZVdU16cHdpWGxxQzFUL0VsYXN1Z1F0M0FxdzhuV0FjeHlN?=
 =?utf-8?B?L05Yd2pqbzhSQmNwdk5oTmk5VmM3Z2VhQUlraGRTS2ZiRnk3clp4SG1VNWJM?=
 =?utf-8?B?UnQ5b3BSYzhMbU8zNllaN3lVUlZQcFhRNmc3RzdDamVlaUNsU0xRT3lzY1ln?=
 =?utf-8?B?dll4OTdyZ28xQmVtdlJ3UmdoQitpM2c0WVZhZm9kTW9wR0lpb3hKY1oxdEJR?=
 =?utf-8?B?TmxNUWlNTGRtMnM4WHR1YzhGUkhtMkdWNGk3dlplelE4N21VbVlySXZ2UEl0?=
 =?utf-8?B?aTRkQXZHY0U2TE5jWEI4L0RFMlVwK08yeVpqeVVUaW9hMXBzUWRGWFdnZ1VB?=
 =?utf-8?B?dXlyQVdsUThZdlc2Ly9GY01PL0VreWsrWGNHR1ZpYzVVQ2R2dHJEVyt6ZUpS?=
 =?utf-8?B?SVRRWE43VmU3TE5mU2RXc3c0M240L0ZYL0dnUU1UZlVOSUxHYkF6Vk5nRmRC?=
 =?utf-8?B?NzlvVDNNWWNrVW9vUnEvaC9lTjgxaUpRZFRHdkxyMEFBN2lFcFIwcnRiS1g3?=
 =?utf-8?B?eGx6bi8rczVYQWl5QnJhZzl6TnFRSkZTRjc3VjFZMTFGbUQwY21MRkZ6SVRw?=
 =?utf-8?B?cTk4NjFVUFFWSC8zRTRJNENpL3ZVOUorZWRHYkM2dmFja1gvVDZ1eVlLUlFJ?=
 =?utf-8?B?YUtGTU9tS3RkdjdzSXlFSHRuUkprZm5YbXVrdEVmcW1VUDM5REdhc3ZXV0tD?=
 =?utf-8?B?ekN0MXBnbUNFQy93UzVGQXl1QWtPZ2c4ZU0xaFA5WjY3czY1R0krWDE3K1VP?=
 =?utf-8?B?a1NpZW5KTW96K0pOVEpGeHBoYW95eXpQM1FtTHVjNU56OExQSEpwZ3BKS3Fs?=
 =?utf-8?B?bUNjVTVBOE1aTHA4V1BpVEo5NHNESDJLZzFSN1Vybm9wb1lOS0dHSkY5ZlVh?=
 =?utf-8?B?RFU5UmdtTms2am9mT3ZyY2dyd3VlVmJYZ0g0ZXYzRjdOQXNSa2ZkYjMyTEhy?=
 =?utf-8?B?aTltbzBEQVZwNm1jenVsM2s4ME9ZY2l4UjhBUnVWMnZna1hmaFkrWG9LNnRm?=
 =?utf-8?B?d2NWbks1Q0FVakFWb3M1OW1Rcmo0VkJJak1oOFRySDgram5QSGxCL0pyY1Ay?=
 =?utf-8?Q?Eeky74kQ0TkUG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 08:51:17.8444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cda80743-34c3-4040-d5dc-08dc70ce5b6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784
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

Developed a userqueue fence driver for the userqueue process shared
BO synchronization.

Create a dma fence having write pointer as the seqno and allocate a
seq64 memory for each user queue process and feed this memory address
into the firmware/hardware, thus the firmware writes the read pointer
into the given address when the process completes it execution.
Compare wptr and rptr, if rptr >= wptr, signal the fences for the waiting
process to consume the buffers.

v2: Worked on review comments from Christian for the following
    modifications

    - Add wptr as sequence number into the fence
    - Add a reference count for the fence driver
    - Add dma_fence_put below the list_del as it might
      frees the userq fence.
    - Trim unnecessary code in interrupt handler.
    - Check dma fence signaled state in dma fence creation
      function for a potential problem of hardware completing
      the job processing beforehand.
    - Add necessary locks.
    - Create a list and process all the unsignaled fences.
    - clean up fences in destroy function.
    - implement .signaled callback function

v3: Worked on review comments from Christian
    - Modify naming convention for reference counted objects
    - Fix fence driver reference drop issue
    - Drop amdgpu_userq_fence_driver_process() function return value

v4: Worked on review comments from Christian
    - Moved fence driver allocation into amdgpu_userq_fence_driver_alloc()
    - Added detail doc mentioning the differences b/w
      two spinlocks declared.

v5: Worked on review comments from Christian
    - Check before upcast and remove local variable
    - Add error handling in fence_drv alloc function.
    - Move rptr read fn outside of the loop and remove WARN_ON in
      destroy function.

v6:
  - clear the seq64 memory in user fence driver(Christian)
  - fix for the wptr va bo mapping(Christian)
  - move the fence_drv xa entry erase code from the interrupt handler
    into user fence destroy function

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c     |   4 +-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 257 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  69 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  12 +-
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   5 +-
 7 files changed, 349 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index a640bfa468ad..f8dd808bd71c 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -80,7 +80,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
-	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o
+	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o \
+	amdgpu_userq_fence.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index acee1c279abb..844f7b5f90db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -51,6 +51,7 @@
 #include "amdgpu_sched.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_userqueue.h"
+#include "amdgpu_userq_fence.h"
 #include "../amdxcp/amdgpu_xcp_drv.h"
 
 /*
@@ -3012,6 +3013,10 @@ static int __init amdgpu_init(void)
 	if (r)
 		goto error_fence;
 
+	r = amdgpu_userq_fence_slab_init();
+	if (r)
+		goto error_fence;
+
 	DRM_INFO("amdgpu kernel modesetting enabled.\n");
 	amdgpu_register_atpx_handler();
 	amdgpu_acpi_detect();
@@ -3037,6 +3042,7 @@ static void __exit amdgpu_exit(void)
 	amdgpu_acpi_release();
 	amdgpu_sync_fini();
 	amdgpu_fence_slab_fini();
+	amdgpu_userq_fence_slab_fini();
 	mmu_notifier_synchronize();
 	amdgpu_xcp_drv_release();
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index e22cb2b5cd92..3ef1d7f4fd23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -45,7 +45,7 @@
  */
 static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device *adev)
 {
-	return AMDGPU_VA_RESERVED_SEQ64_START(adev);
+	return AMDGPU_VA_RESERVED_BOTTOM;
 }
 
 /**
@@ -90,7 +90,7 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	seq64_addr = amdgpu_seq64_get_va_base(adev);
 	r = amdgpu_vm_bo_map(adev, *bo_va, seq64_addr, 0, AMDGPU_VA_RESERVED_SEQ64_SIZE,
-			     AMDGPU_PTE_READABLE);
+			     AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE | AMDGPU_PTE_EXECUTABLE);
 	if (r) {
 		DRM_ERROR("failed to do bo_map on userq sem, err=%d\n", r);
 		amdgpu_vm_bo_del(adev, *bo_va);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
new file mode 100644
index 000000000000..f7baea2c67ab
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include <linux/kref.h>
+#include <linux/slab.h>
+
+#include <drm/drm_syncobj.h>
+
+#include "amdgpu.h"
+#include "amdgpu_userq_fence.h"
+
+static const struct dma_fence_ops amdgpu_userq_fence_ops;
+static struct kmem_cache *amdgpu_userq_fence_slab;
+
+int amdgpu_userq_fence_slab_init(void)
+{
+	amdgpu_userq_fence_slab = kmem_cache_create("amdgpu_userq_fence",
+						    sizeof(struct amdgpu_userq_fence),
+						    0,
+						    SLAB_HWCACHE_ALIGN,
+						    NULL);
+	if (!amdgpu_userq_fence_slab)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void amdgpu_userq_fence_slab_fini(void)
+{
+	rcu_barrier();
+	kmem_cache_destroy(amdgpu_userq_fence_slab);
+}
+
+static inline struct amdgpu_userq_fence *to_amdgpu_userq_fence(struct dma_fence *f)
+{
+	if (!f || f->ops != &amdgpu_userq_fence_ops)
+		return NULL;
+
+	return container_of(f, struct amdgpu_userq_fence, base);
+}
+
+static u64 amdgpu_userq_fence_read(struct amdgpu_userq_fence_driver *fence_drv)
+{
+	return le64_to_cpu(*fence_drv->cpu_addr);
+}
+
+int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
+				    struct amdgpu_usermode_queue *userq)
+{
+	struct amdgpu_userq_fence_driver *fence_drv;
+	int r;
+
+	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
+	if (!fence_drv) {
+		DRM_ERROR("Failed to allocate memory for fence driver\n");
+		return -ENOMEM;
+	}
+
+	/* Acquire seq64 memory */
+	r = amdgpu_seq64_alloc(adev, &fence_drv->gpu_addr,
+			       &fence_drv->cpu_addr);
+	if (r) {
+		kfree(fence_drv);
+		return -ENOMEM;
+	}
+
+	memset(fence_drv->cpu_addr, 0, sizeof(u64));
+
+	kref_init(&fence_drv->refcount);
+	INIT_LIST_HEAD(&fence_drv->fences);
+	spin_lock_init(&fence_drv->fence_list_lock);
+
+	fence_drv->adev = adev;
+	fence_drv->context = dma_fence_context_alloc(1);
+	get_task_comm(fence_drv->timeline_name, current);
+
+	userq->fence_drv = fence_drv;
+
+	return 0;
+}
+
+void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
+{
+	struct amdgpu_userq_fence *userq_fence, *tmp;
+	struct dma_fence *fence;
+	u64 rptr;
+
+	if (!fence_drv)
+		return;
+
+	rptr = amdgpu_userq_fence_read(fence_drv);
+
+	spin_lock(&fence_drv->fence_list_lock);
+	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
+		fence = &userq_fence->base;
+
+		if (rptr >= fence->seqno) {
+			dma_fence_signal(fence);
+			list_del(&userq_fence->link);
+
+			dma_fence_put(fence);
+		} else {
+			break;
+		}
+	}
+	spin_unlock(&fence_drv->fence_list_lock);
+}
+
+void amdgpu_userq_fence_driver_destroy(struct kref *ref)
+{
+	struct amdgpu_userq_fence_driver *fence_drv = container_of(ref,
+					 struct amdgpu_userq_fence_driver,
+					 refcount);
+	struct amdgpu_device *adev = fence_drv->adev;
+	struct amdgpu_userq_fence *fence, *tmp;
+	struct dma_fence *f;
+
+	spin_lock(&fence_drv->fence_list_lock);
+	list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link) {
+		f = &fence->base;
+
+		if (!dma_fence_is_signaled(f)) {
+			dma_fence_set_error(f, -ECANCELED);
+			dma_fence_signal(f);
+		}
+
+		list_del(&fence->link);
+		dma_fence_put(f);
+	}
+	spin_unlock(&fence_drv->fence_list_lock);
+
+	/* Free seq64 memory */
+	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
+	kfree(fence_drv);
+}
+
+void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv)
+{
+	kref_get(&fence_drv->refcount);
+}
+
+void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
+{
+	kref_put(&fence_drv->refcount, amdgpu_userq_fence_driver_destroy);
+}
+
+int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
+			      u64 seq, struct dma_fence **f)
+{
+	struct amdgpu_userq_fence_driver *fence_drv;
+	struct amdgpu_userq_fence *userq_fence;
+	struct dma_fence *fence;
+
+	fence_drv = userq->fence_drv;
+	if (!fence_drv)
+		return -EINVAL;
+
+	userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab, GFP_ATOMIC);
+	if (!userq_fence)
+		return -ENOMEM;
+
+	spin_lock_init(&userq_fence->lock);
+	INIT_LIST_HEAD(&userq_fence->link);
+	fence = &userq_fence->base;
+	userq_fence->fence_drv = fence_drv;
+
+	dma_fence_init(fence, &amdgpu_userq_fence_ops, &userq_fence->lock,
+		       fence_drv->context, seq);
+
+	amdgpu_userq_fence_driver_get(fence_drv);
+	dma_fence_get(fence);
+
+	spin_lock(&fence_drv->fence_list_lock);
+	/* Check if hardware has already processed the job */
+	if (!dma_fence_is_signaled(fence))
+		list_add_tail(&userq_fence->link, &fence_drv->fences);
+	else
+		dma_fence_put(fence);
+
+	spin_unlock(&fence_drv->fence_list_lock);
+
+	*f = fence;
+
+	return 0;
+}
+
+static const char *amdgpu_userq_fence_get_driver_name(struct dma_fence *f)
+{
+	return "amdgpu_userqueue_fence";
+}
+
+static const char *amdgpu_userq_fence_get_timeline_name(struct dma_fence *f)
+{
+	struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
+
+	return fence->fence_drv->timeline_name;
+}
+
+static bool amdgpu_userq_fence_signaled(struct dma_fence *f)
+{
+	struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
+	struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+	u64 rptr, wptr;
+
+	rptr = amdgpu_userq_fence_read(fence_drv);
+	wptr = fence->base.seqno;
+
+	if (rptr >= wptr)
+		return true;
+
+	return false;
+}
+
+static void amdgpu_userq_fence_free(struct rcu_head *rcu)
+{
+	struct dma_fence *fence = container_of(rcu, struct dma_fence, rcu);
+	struct amdgpu_userq_fence *userq_fence = to_amdgpu_userq_fence(fence);
+	struct amdgpu_userq_fence_driver *fence_drv = userq_fence->fence_drv;
+
+	/* Release the fence driver reference */
+	amdgpu_userq_fence_driver_put(fence_drv);
+	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
+}
+
+static void amdgpu_userq_fence_release(struct dma_fence *f)
+{
+	call_rcu(&f->rcu, amdgpu_userq_fence_free);
+}
+
+static const struct dma_fence_ops amdgpu_userq_fence_ops = {
+	.use_64bit_seqno = true,
+	.get_driver_name = amdgpu_userq_fence_get_driver_name,
+	.get_timeline_name = amdgpu_userq_fence_get_timeline_name,
+	.signaled = amdgpu_userq_fence_signaled,
+	.release = amdgpu_userq_fence_release,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
new file mode 100644
index 000000000000..c3e04cdbb9e7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __AMDGPU_USERQ_FENCE_H__
+#define __AMDGPU_USERQ_FENCE_H__
+
+#include <linux/types.h>
+
+#include "amdgpu_userqueue.h"
+
+struct amdgpu_userq_fence {
+	struct dma_fence base;
+	/*
+	 * This lock is necessary to synchronize the
+	 * userqueue dma fence operations.
+	 */
+	spinlock_t lock;
+	struct list_head link;
+	struct amdgpu_userq_fence_driver *fence_drv;
+};
+
+struct amdgpu_userq_fence_driver {
+	struct kref refcount;
+	u64 gpu_addr;
+	u64 *cpu_addr;
+	u64 context;
+	/*
+	 * This lock is necesaary to synchronize the access
+	 * to the fences list by the fence driver.
+	 */
+	spinlock_t fence_list_lock;
+	struct list_head fences;
+	struct amdgpu_device *adev;
+	char timeline_name[TASK_COMM_LEN];
+};
+
+int amdgpu_userq_fence_slab_init(void);
+void amdgpu_userq_fence_slab_fini(void);
+int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
+			      u64 seq, struct dma_fence **f);
+void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv);
+void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
+int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
+				    struct amdgpu_usermode_queue *userq);
+void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
+void amdgpu_userq_fence_driver_destroy(struct kref *ref);
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 98cd07a42623..73d225aa3e1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -26,6 +26,7 @@
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_userqueue.h"
+#include "amdgpu_userq_fence.h"
 
 static void
 amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
@@ -36,6 +37,7 @@ amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 
 	uq_funcs->mqd_destroy(uq_mgr, queue);
+	amdgpu_userq_fence_driver_put(queue->fence_drv);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
 	kfree(queue);
 }
@@ -55,7 +57,7 @@ amdgpu_userqueue_fence_get_driver_name(struct dma_fence *fence)
 static const char *
 amdgpu_userqueue_fence_get_timeline_name(struct dma_fence *f)
 {
-	struct amdgpu_userq_fence *ef = container_of(f, struct amdgpu_userq_fence, base);
+	struct amdgpu_userq_ev_fence *ef = container_of(f, struct amdgpu_userq_ev_fence, base);
 
 	return ef->timeline_name;
 }
@@ -69,7 +71,7 @@ static const struct dma_fence_ops amdgpu_userqueue_eviction_fence_ops = {
 static void
 amdgpu_userqueue_init_eviction_fence(struct amdgpu_userq_mgr *uq_mgr)
 {
-	struct amdgpu_userq_fence *fence = &uq_mgr->eviction_fence;
+	struct amdgpu_userq_ev_fence *fence = &uq_mgr->eviction_fence;
 	atomic_t seq = ATOMIC_INIT(0);
 
 	spin_lock_init(&fence->lock);
@@ -403,6 +405,12 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 	queue->doorbell_index = index;
 
+	r = amdgpu_userq_fence_driver_alloc(adev, queue);
+	if (r) {
+		DRM_ERROR("Failed to alloc fence driver\n");
+		goto unlock;
+	}
+
 	r = uq_funcs->mqd_create(uq_mgr, &args->in, queue);
 	if (r) {
 		DRM_ERROR("Failed to create Queue\n");
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 5ba18374bfbb..d3738f645adc 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -48,6 +48,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_userq_obj	db_obj;
 	struct amdgpu_userq_obj fw_obj;
 	struct amdgpu_userq_obj wptr_obj;
+	struct amdgpu_userq_fence_driver *fence_drv;
 };
 
 struct amdgpu_userq_funcs {
@@ -58,7 +59,7 @@ struct amdgpu_userq_funcs {
 			    struct amdgpu_usermode_queue *uq);
 };
 
-struct amdgpu_userq_fence {
+struct amdgpu_userq_ev_fence {
 	u64		 fence_ctx;
 	atomic_t	 seq;
 	spinlock_t	 lock;
@@ -71,7 +72,7 @@ struct amdgpu_userq_mgr {
 	struct idr			userq_idr;
 	struct mutex			userq_mutex;
 	struct amdgpu_device		*adev;
-	struct amdgpu_userq_fence	eviction_fence;
+	struct amdgpu_userq_ev_fence	eviction_fence;
 };
 
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
-- 
2.25.1

