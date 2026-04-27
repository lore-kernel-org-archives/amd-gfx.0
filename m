Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CA4FF8868
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 15:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93CF310E7EC;
	Mon, 27 Apr 2026 15:59:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZRgMtMEK";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6418410E7EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 15:59:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnusCPGYDo7wYjGnlsLqPfgJ9RNZ0NJJKOo2X71vPf2rV0a1HBs5v+9VYxKvnCOe5WlbiY1YFLzX9kvUi/6FeEbN4Ypep6GgRWyE7yKK2jtjGpPEoTsr0nd9GgUKBeIaKgZSK5lcP9+yGH2k4BlqJsAmMi3gm2H2upT4r5HdU9IHBjcvFh/MvEdI9E15w9200RkRmX3nQ2ttbNxl022ix7y9BoU2+W9LphZFuZphqwgdEC7+gOx+fSDLOciVms9049E/xXfgV/vL6MLzeVot55qstgBeW0fjqWgw6vHoJ8uq2yF0Vie1FcVwmVbaZVnBgpqkAMB1ElNQLY4NG4fCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3fi64WADwNQC9eXW5LZGk1rWkCyVMILW/mfTW9voOE=;
 b=T4W+lIDUH8UGful66SsIMl05iOb5Ot7Yn5m/9gLqoZyz5qa8prz3r4R/i8gLrHQxo5Z+wEMJXSoX4mVXBufH2dymMUx6EKPaDWMeLo5eXmkPIT2mF3uMzvq2fRfEF0Da8OvNyEfOFNWBMJmPpf1CW2b3/8ZWnIVuq5baMRwNZyo3j54I/ziYWn5N7lmiUEfiUyTQDsOZByh55VdRNEReoDDx2xXlFBQHV+Qhb2qvUQA0sDkx6BuUMGsZ3PJg+yUjif8d0Xf0fyuYV+WH4//gcyawvW8fAlDy5CkoW2Lzx3enT3+eD58sZdPpnYSEJg0jV0U3LimP49v9z2Xf/eesVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3fi64WADwNQC9eXW5LZGk1rWkCyVMILW/mfTW9voOE=;
 b=ZRgMtMEKIwYKl9ynlmgV2edyY/4+d1JnvLFIKWvKMKeMY24pD9Ex+EC50+M4a2h9xWb4RxW0IOSsY/2NrWd4E1Y+5OM/lmfNlAvdFfogZSrjdG21L2gq0KSVsE5oUF+7rqpvBQd5Tmnxe4twdWUeVyTN+LBGrwhBjYRdFW5QPKQ=
Received: from BN9P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::22)
 by SA1PR12MB8164.namprd12.prod.outlook.com (2603:10b6:806:338::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 15:59:44 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:13e:cafe::9e) by BN9P220CA0017.outlook.office365.com
 (2603:10b6:408:13e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 15:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 15:59:43 +0000
Received: from yinjiyao-dev24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 10:59:43 -0500
From: Yinjie Yao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <leo.liu@amd.com>, <ruijing.dong@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH v2 04/19] drm/amdgpu/vcn: set no_user_fence for VCN v4.0 enc
 ring
Date: Mon, 27 Apr 2026 11:58:42 -0400
Message-ID: <20260427155857.1370151-4-yinjie.yao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427155857.1370151-1-yinjie.yao@amd.com>
References: <CADnq5_MPJG=S+B4kg6v64xD+8pDEbG5z1Q7j-2A+CfStmuejTg@mail.gmail.com>
 <20260427155857.1370151-1-yinjie.yao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|SA1PR12MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d9e3658-c94f-4d06-d120-08dea475ffa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: A9d1JKn9DkHkveBsXA+6q6rRHM0qq3nFfPc+aWDBSbAYBgtvOHng9i3Bmh+YOG8vdk9znmOAMVDWLUlsT7UBpJtsRIuijtxzUNejuQEKyQ1EifXJ+S/avhHc2K56Y3P3vggUkYdpJTg7QxpyrT8GVasuCh1FZ1qhWBKEbG4qW+Xs1OByQqX359qZh1n+oUDcI1oeOTlK+XTv5wagdb+2K8QQqGpLQ2vNb17BtA1KAOW2V7cEuBSNtmGMDPYmLMF1P5PFcGgpW+mm0PpDrdygrhHyAaKnxXg3/GdGlrfKntq+SL17R8NPyM20K3Ofp0jivXR7YfFoiBJH95BgW6MgFIUrPEYAyWqweQ5/2VR6MVQEk5+WMmY+dCbfv0IebKVuHm92o/jd+BKvdBMcZqDB07n+Kx8oXLlHtuPuXE89xyPhHdlQWihPh5TZUByH9rFtlbjqI/ORbUl/HD1gdInlmnz8pyLdCVOlSgE2GfoMKzxDlbuhdhq92JzS5Q05b6y6kleAqEtbQ9xiDsPoUeOFkEJywXSR0GECDX1V5Of8UW/oBN6nkN9E0pPp0A/2BcebSqPKLazNEr5F1b5zi3HjEC+NLiNVwG+6U0ji+przWB9y3bqlJ4CTNiTg+znHRourhZldv+EA02Ynqn1vvXqGvR4jXd91ff+hCPwTfO9AO+DWljzv3bMkcIJZ5HAUsPZ3XVAYZxCaGfOygRE2JTYcF8lNBQ4TdWHSo/G2GvL2T2YGj+z1+VCH3bxUJTgwOYKC3X2aqHwbK2twdom2uICW9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 61kAUwehIHimpKgUTyVsbw7p5OJHkYS1NVnG8nBd1EDWpZBLzcsGqQkT4yM8K2r8KJ3VC8pLzGFo9gycs9W76ocCG26tMhY0u8waWLGS+fgM6n8Kg8HR5EMheoGKVGNNv/S5UJk/Qy6MSjWKgFaDs6e8djR1uRQ3jIyWkhPtCH7HdzXr92f66f2MP4avIwMtcNW2Chac2GeXGgpGnBGkaifjL572Ci9VQcT3RbVMWZl4EE2vvSq1PQb2WUiMm+/FbyH5H8uzgOuvQfEseK3N+iH67Gi7/sxOl0lIUMxSa57J/3pKcx1WYzKE95ANPSPtLrvaI5kad8iK9dbKnOLF/M4lmc0ypUdY1rb11IRPStH+LcLRpidJFshemCCGflJ5KOzHGC+WIvccLfQHiqKQeGT2EZ39i9SLF9JjmNczoQgLGNzFzSkt7AhBsLe0KZ7k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:59:43.9811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9e3658-c94f-4d06-d120-08dea475ffa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8164
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

VCN encoder and decoder rings do not support 64-bit user fence writes,
reject CS submissions with user fences.

Fixes: 8da1170a16e4 ("drm/amdgpu: add VCN4 ip block support")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 5dec92691f73..bbdd017cbafb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1994,6 +1994,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.no_user_fence = true,
 	.extra_bytes = sizeof(struct amdgpu_vcn_rb_metadata),
 	.get_rptr = vcn_v4_0_unified_ring_get_rptr,
 	.get_wptr = vcn_v4_0_unified_ring_get_wptr,
-- 
2.43.0

