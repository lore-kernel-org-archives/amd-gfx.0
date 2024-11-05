Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EF8D12663
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 09:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD13510E548;
	Tue,  5 Nov 2024 09:25:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nG8EqqJw";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 308A710E548
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 09:25:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lzoja+/aKGSbf+omBuaRZpfyWm031nbMGyoBhJYZPAYOuqFpXtIA8z0WnCiUwoGC7+JRCB/uO46rJIRlXeTP8HetBq/rHiqHstQWY2pDR7rkSzE2WiRdoYaYyIHs+Haw62ySjOxZTuQ4H/m6cWhiug8tR0acjg5SQWoWIAtGnDoI49QztXOeBsI12D6Q8TBDCFZs7tI0uAWgfvrtkUgwsNgTNa8XK4tLHARe3Xkza0P1FXoxOPjnEuVuBHjBLzYWlIPuzc9TeuB6PllSTSSxtB4VPeYc1/21Xebr/wSqWoJHUWfxX/5wAWMnMUHV2jjo9IftHmW2XhGELsK+FAaIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0GThxD0QhfmZJdn0Hvqkv7cErRpmhOWM964PqzLaYU=;
 b=ulPDi29Gi3fY/c0Gh3eci1jjUYXtv5kLRX1YyoUtXHRt7F3F40F1CRUVXs9qLijikZQQNcI6ui545f6d2sFuK31zlXXLkqGPKDUByQQPjfgFFfnSuwOPhgDFfp3W/K6Hv1ri5TT0gRT6vUeZwGilgJ6O1sqKUsWClTFd0m2hJY1v2YexLwpz2WxFU4FZvAZFGqNBHqvv27DQ5K90W6rarHzfpLfngJ3G0DDF17cvYXQ1AGqQQN+d6xOJlbakg8fNx1DtbEEmrNwWtjgdCDscRoePPzfWIuixiPtzMcajfM/G8TlgT3+PEy0nPtvH3Y/RUuNXbdd5fyNOM+NO8bV1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0GThxD0QhfmZJdn0Hvqkv7cErRpmhOWM964PqzLaYU=;
 b=nG8EqqJwusSXuV8baLUSFSc6hEaRn0Fw7GXJTN6g7GEb+FIFarIgODtBP8UmKThWG8Xybz9UUop8TJHb53WVyuHiQ7z21fyeaVNhZy7LZrZNRHVE2dwLq7LQTnDX9Twctsm800kxIZfk1EXlEoW/u1FGNZX7jWMCW8lVHDZD4rc=
Received: from LV3P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::33)
 by CH3PR12MB8710.namprd12.prod.outlook.com (2603:10b6:610:173::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 09:25:23 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:234:cafe::18) by LV3P220CA0001.outlook.office365.com
 (2603:10b6:408:234::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 09:25:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 09:25:23 +0000
Received: from lc-X10DRi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 03:25:21 -0600
From: Chong Li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <Emily.Deng@amd.com>, <lincao12@amd.com>,
 <dandjelk@amd.com>, <zhengyin@amd.com>, Chong Li <chongli2@amd.com>
Subject: [PATCH] drm/amdgpu: fix return random value when multiple threads
 read registers via mes.
Date: Tue, 5 Nov 2024 17:24:53 +0800
Message-ID: <20241105092454.40017-1-chongli2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|CH3PR12MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: e3537dcf-a289-4990-0706-08dcfd7bc6ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/04Hbb7zy6cyHesRFjIyTR1rn21jUNje8tdTD22hXQxU6CHUnp1CIbsZFKer?=
 =?us-ascii?Q?Ry4jkSP9k7OfHzo8+UTn2JsgXrXPmEtxd3+pvroxkSwMIJjK7mgFuu9JVtiu?=
 =?us-ascii?Q?qmwroOIGoKWPZm41N0u8BgS8BYjEyEZjTfuCssxQXSpK2l8/tvgeOv86Qr7W?=
 =?us-ascii?Q?tJmCR5JaFkwbKIjzbXI/L4X+B3cHke44VgwJy5go2K61ZVlD0B/YyPPh1R4y?=
 =?us-ascii?Q?z3wdbZ4HAXL2G6om2GyWtEEs0d2oIPq4BzZGQFcLqhXstJrGog1/r0dvsYfU?=
 =?us-ascii?Q?1IQ4tilYLZsxnfo4zSoWHxffBmi8C89jXH/IUi+4bw5YhkLltlAMEnrwgP8c?=
 =?us-ascii?Q?82QOJC0ffbQiYK051z++vBwQlgSe5cheux36s68eQofq9gO7yW08KWkjUf4/?=
 =?us-ascii?Q?d1pKCEKM5jGk0GPcA+cp7nbG79p5RM3BPlN8gQr6SIO3xC6ThzhE2xoXqlj6?=
 =?us-ascii?Q?+ekPMLJiNLrz61hdoD7hmodsyLVGbACMeZ5cM3klPo/wydMxuAGM4rnHHngT?=
 =?us-ascii?Q?XAwOS/Jkd5aDdcA7/xVVMBEuuaqvgAxj/ledks0Ip0uX6liUnbLmpronmokv?=
 =?us-ascii?Q?NhPIcbgOhuz6mAxpmPozAyutbVsZGG1N/mYkhks2RymXPNnKnHwvL9hIJCmo?=
 =?us-ascii?Q?ElavYFrX3j96OJVvFTEp/DNNfog3B1V/tQd9DvlPjjSSyLA6y7NKeXMazyHy?=
 =?us-ascii?Q?GYE12nlaa5IhUZD/7ZQd3F7a6ZoFwhko+JESVT4khMocyk0YwkDE9EnuptpG?=
 =?us-ascii?Q?1vOGrpDXoZ3cSsW3mrfBLIup4vb6JCZWZ/IdmtU8skC8bqD8ILbk4z7jUFQv?=
 =?us-ascii?Q?wWoNRyB5uG72VyO231FvnGWbf5qrJt1GC2aPYNV6oq09Jc4da1LW6sCMQ0Z8?=
 =?us-ascii?Q?rFRYIv33mkhrszFMzCHXQuA+JLnj2/JQ8swiTrIwtrGycgge50muzd4XQkkl?=
 =?us-ascii?Q?7j8lwVEWOz1s6VWyHXb7oTWfntcqzCKpMGPExfPc4NfcKnIo5m5egzJxNDFS?=
 =?us-ascii?Q?19E6+kOf2mlowe7na9PDEuD1NrAwnm78F6mEEmvb68RI/29I6Z9d33MiQfGN?=
 =?us-ascii?Q?2Kc7Np0wowLVZ5gwWB7+/zM7HCsqJqPCEyVGCPzy2xUktYsCzOvmsTzNMAV2?=
 =?us-ascii?Q?kO86goe/HKndBuuyNqXQMKJPys+2caJZTWcbNzqg4zVgkxMEMnd+fk1moKwa?=
 =?us-ascii?Q?G8HH1NM5l7i5LLNbjCIkrNYT7CyfjgcfuTbfAtfDB7jsPaH17rKv7pjyp0aX?=
 =?us-ascii?Q?P+C5i2rP71xkO4XwnxXX8Hol6hQsVKwcle5NEnALcBzod3ln4Q2MTi7c1YX4?=
 =?us-ascii?Q?kTsi5sNUIz53v6bDsciagN8Dk8cn6HPi1asi4Da7Vr75Abm1oYth+GEdpSbk?=
 =?us-ascii?Q?bGDKeIJIyHXId5gsnuSCYG6MhU0+M4Z2XFsQk591NyibkIgKjQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 09:25:23.6027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3537dcf-a289-4990-0706-08dcfd7bc6ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710
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

The currect code use the address "adev->mes.read_val_ptr" to
store the value read from register via mes.
So when multiple threads read register,
multiple threads have to share the one address,
and overwrite the value each other.

Assign an address by "amdgpu_device_wb_get" to store register value.
each thread will has an address to store register value.

Signed-off-by: Chong Li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 30 +++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 ---
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 83d0f731fb65..a8f7173b2663 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -189,17 +189,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 			(uint64_t *)&adev->wb.wb[adev->mes.query_status_fence_offs[i]];
 	}
 
-	r = amdgpu_device_wb_get(adev, &adev->mes.read_val_offs);
-	if (r) {
-		dev_err(adev->dev,
-			"(%d) read_val_offs alloc failed\n", r);
-		goto error;
-	}
-	adev->mes.read_val_gpu_addr =
-		adev->wb.gpu_addr + (adev->mes.read_val_offs * 4);
-	adev->mes.read_val_ptr =
-		(uint32_t *)&adev->wb.wb[adev->mes.read_val_offs];
-
 	r = amdgpu_mes_doorbell_init(adev);
 	if (r)
 		goto error;
@@ -220,8 +209,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 			amdgpu_device_wb_free(adev,
 				      adev->mes.query_status_fence_offs[i]);
 	}
-	if (adev->mes.read_val_ptr)
-		amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
 
 	idr_destroy(&adev->mes.pasid_idr);
 	idr_destroy(&adev->mes.gang_id_idr);
@@ -246,8 +233,6 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 			amdgpu_device_wb_free(adev,
 				      adev->mes.query_status_fence_offs[i]);
 	}
-	if (adev->mes.read_val_ptr)
-		amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
 
 	amdgpu_mes_doorbell_free(adev);
 
@@ -918,10 +903,19 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 {
 	struct mes_misc_op_input op_input;
 	int r, val = 0;
+	uint32_t addr_offset = 0;
+	uint64_t read_val_gpu_addr;
+	uint32_t *read_val_ptr;
 
+	if (amdgpu_device_wb_get(adev, &addr_offset)) {
+		DRM_ERROR("critical bug! too many mes readers\n");
+		goto error;
+	}
+	read_val_gpu_addr = adev->wb.gpu_addr + (addr_offset * 4);
+	read_val_ptr = (uint32_t *)&adev->wb.wb[addr_offset];
 	op_input.op = MES_MISC_OP_READ_REG;
 	op_input.read_reg.reg_offset = reg;
-	op_input.read_reg.buffer_addr = adev->mes.read_val_gpu_addr;
+	op_input.read_reg.buffer_addr = read_val_gpu_addr;
 
 	if (!adev->mes.funcs->misc_op) {
 		DRM_ERROR("mes rreg is not supported!\n");
@@ -932,9 +926,11 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 	if (r)
 		DRM_ERROR("failed to read reg (0x%x)\n", reg);
 	else
-		val = *(adev->mes.read_val_ptr);
+		val = *(read_val_ptr);
 
 error:
+	if (addr_offset)
+		amdgpu_device_wb_free(adev, addr_offset);
 	return val;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 45e3508f0f8e..83f45bb48427 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -119,9 +119,6 @@ struct amdgpu_mes {
 	uint32_t			query_status_fence_offs[AMDGPU_MAX_MES_PIPES];
 	uint64_t			query_status_fence_gpu_addr[AMDGPU_MAX_MES_PIPES];
 	uint64_t			*query_status_fence_ptr[AMDGPU_MAX_MES_PIPES];
-	uint32_t                        read_val_offs;
-	uint64_t			read_val_gpu_addr;
-	uint32_t			*read_val_ptr;
 
 	uint32_t			saved_flags;
 
-- 
2.34.1

