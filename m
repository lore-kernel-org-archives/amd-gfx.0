Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAB1C88E59
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5656710F649;
	Fri, 11 Sep 2026 17:56:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yBIhrXss";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 634A010F477
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0S4+29bmtzVia5z1AIqEFB7XY01+x/xLQsnV7yRibZM4FoA8UR7z7KcofGciiI7ePyyt65VRy8LM6N0E8NyjXfFesSwGEIOw8uSf2RISuMww1k1pWY/WHV1hfb5C+Nw/3DPMjxl8jwU/gmzk5S2apM0IUVY2soGgYPrE+RY4533Eqd3xM7dqE09sZTI30Jx/rl4izXJ457jqaJcblYIOBWZkZOfpP9V9sUtne4CSI8NpMYrawSMdQ42eGQAGhsZuckjyocj8Eyi+4NgzFX3QsKe4o0+GPB83mCfsBMawiFk12iH4yrpVkoJFYkTs6T8XjoUd+gQPakkta88LI0qXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JEtdHo5+UAEjA0hjjhyu098tToXecyxvmmLLjkuXTo=;
 b=BpGihDBJq6N/NFTp2vNeqiU8DhlRirJBthTu2aNPExlltHfKnjWUP7Kg6MBUnSiRzdXvam6PugkPYVlJSb5E7VoiRGinjkSIpYloQIxyqRG4T0KH78V7FHE0Y4ax1llJYgqSd2c2qab6BmlNlKeh7CM0FTYgvDu4hzi2g/B6y5Su7preTqynA4MALA/hKropV7aI1vjNlhhejEHVJnpdsLP8Te3jlujXIxH+nytgI/4C6odvlHmgOlTE6Ku4BKfK2XhbJgdLpqF1Hqfl/WldnaMXzvk+nPtWD56rqE9FjjgTB+YzyulirJhpfsEn/dwudOk7gvuqS81KiHkr4YhQMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JEtdHo5+UAEjA0hjjhyu098tToXecyxvmmLLjkuXTo=;
 b=yBIhrXss8ScFZJqtxUama+iRIyrM1kGYt7TGc+DSyFCoYUxefNoF29HO616rzjz8iTJfuV9uoW50A2X7zaupoO1wQoYTKOf6NYBVkSNn3tueaRcJp/rKywN2DmzAxMhldTcxD2/HjAvbnzpMHiJ/QOcDv5vk3VmzWMqZ92ByLzY=
Received: from BN9PR03CA0172.namprd03.prod.outlook.com (2603:10b6:408:f4::27)
 by PH0PR12MB8775.namprd12.prod.outlook.com (2603:10b6:510:28e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 17:56:05 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::6e) by BN9PR03CA0172.outlook.office365.com
 (2603:10b6:408:f4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 17:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:05 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:55:58 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:55:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/23] drm/amdgpu: add a buffer funcs callback for TLB
 invalidation
Date: Fri, 11 Sep 2026 13:55:27 -0400
Message-ID: <20260911175544.1314467-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|PH0PR12MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: ce3fd1b6-a989-4374-69fa-08df102df35a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|56012099006|11063799006|6133799003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yLgb8E+bcWuPaIZv7w2AhoBwplA7LPymdqh2vvPopA5Xt3qo3sHyP5S3daH91fiNZ+f+wBp1LvxjbsEErAjaDGXJH9kUVpUMVRtLYQ5mmSKfdCU91X6nKXVf3NZGz2iOilZz6yGwapdi2lFDsgMrhhPCY+noeyQDD36PfNSTE2675cxElWPakXnMGThqAObNFEAS4xDUTZwg/8BDnELDO+PvB2WO+xDIxMz/KPYhMTWje5bjOgI5cBveDlc+bDSzUTodvXbCfDFH8wWuaUZ78qAILZNwhp+TFODbjAe1dbvtKnWbl3Cqqb6V3ToPp+2+W9SmXE/1iVWxnEirbz2FXUwpq7FfTzkUx12993sTC9snBHW4pt9wEc25bQe+2ojoxbTTzxEC2DoJf9KsnVCYxIalwZWsUgeU0FTKBD0G5HOMe0zgKPUaXadLfz4a4CDD7w/IYcfZp5nS8vwG7mdGDkjhUzn+KUMDrypmUE2hGGS5hH0ILAV+TDbDmtSDKg4v7W0gvgBXEo9AvNDUaZJIobSuQ1aBVuOtq2rkqWJbXSyO13eDqSrkFipDZRSDNaEJ91XLoVznD4b5B6ZigF9jzDRN/HFT8n1FR4ZSVU/JPevNnu1z7TvRrW3TUGKrRg+eskim377J4NLRyqBQYdncw01JhGt0/DvLb8FxSSBNpBrH+J/AjkSUNdPoaQXTB6CWq95PqXet8y9awvWWLJOisA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(56012099006)(11063799006)(6133799003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bERE5NT/jgqI+q4tMerM4kKoB9o08jFeeK5/qYjFsX3GI9MqUpXHv2BcJ+AIqDyE5KaP+5S0v9k+vME74AY3m+cSNv9VYR39asdrfC61NOvr86HqPwl80Thv3tJHtW3qtnyCIIzDhbnNtINDZBHYnSj41vsC+36hMJTUS8GUFaHjFLZZ1S7xoARTvFNhHhhy1hOph8LZpwp4fFxUtacWmGte7QvXw4LNOXIIt/GU5LiY8N2eYMznzT5VhAL1tFEbNheFDFfSkawSxViBHfAgpk84rqrWFiZPFUz93V3pqzdcG8pMj9jUHw0SmNWKsEq/7CVHKNYS1bhoRkA+Ktvw9Ot3NHHRyIrUqX/6lmgt7DgA5RwKZfqGhtKyQHFDTOMeLMn+mywTwfkO5EvM/BW1Qvco3Em3UxSA7Fohu0zSVaA0DMtnpb+lb6axBEnArIwo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:05.1843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3fd1b6-a989-4374-69fa-08df102df35a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8775
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

Use this interface to issue TLB invalidations using
SDMA for pasid TLB invalidations.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 659836c2c377c..611b53ef187ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -158,6 +158,23 @@ struct amdgpu_buffer_funcs {
 				 uint64_t dst_offset,
 				 /* number of byte to fill */
 				 uint32_t byte_count);
+
+	/* number of dw to reserve per operation */
+	unsigned	tlb_inv_num_dw;
+
+	/* used for buffer clearing */
+	void (*emit_tlb_inv)(struct amdgpu_device *adev,
+			     struct amdgpu_ib *ib,
+			     /* vmid to target */
+			     unsigned int vmid,
+			     /* vmhub to target */
+			     u32 vmhub,
+			     /* inv eng to target */
+			     u32 eng,
+			     /* flush type */
+			     u32 flush_type,
+			     /* XCC to target */
+			     u32 xcc_inst);
 };
 
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
@@ -165,6 +182,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
 #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
+#define amdgpu_emit_tlb_inv(adev, ib, v, h, e, f, x) (adev)->mman.buffer_funcs->emit_tlb_inv((adev), (ib), (v), (h), (e), (f), (x))
 
 struct amdgpu_sdma_instance *
 amdgpu_sdma_get_instance_from_ring(struct amdgpu_ring *ring);
-- 
2.55.0

