Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EACC43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E002710EE1E;
	Tue,  7 Jul 2026 15:42:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qeSRjfrT";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012005.outbound.protection.outlook.com
 [40.107.200.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBB9610EE0F
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulDV/g0Rp5NxnrHhEncY2wTZmbj+Wit474G4yQKyXQNa4mGEnN7iZNMFj0GKOAdnYht/gN321CGR6hh798Y2vaDSI/Xp6S3HFEgt650nTHDsVXFecfcitwu34N3ZWVZjHiiALOmlIU+/lHM0coGPi/UVDMPxaUFOvHG3cFQCd4nfT96AiwqshNXoJ3ypA+E7J1CGLDs58VC5rDZSdi2cSfjHOO5226H+axs5AgcqD0J4GTki+iW9evW576BypfVVCqjco1VcM4PL0gp1FzlWSiJtwUzLJEiP1CBjl6AgheoAZYUiAHagIkr5I7ZluE/sgkVwdl6p+fZyVTZnj+dkBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+7C23Zy2so/OqdIMcJML3t+ObessMM4priEBhjcc0U=;
 b=a5zpcTT9mpDDxjXBVzVg85CEsnxqKH2Qf2l9is0A9JBGEiEfNeNeqJOMPlHklqApcM5I7eXnr1o3sjsagC+Wo2VJHEC1pEXB62eaCB6PJ4VaalWzER491u8N+1UrWQu4CTr1EhLMI1LT8N5U0bAAJYUbxwsyjuyjYqaq+88CkSnILcFyPUpeNUv3Hm6buy2biBJxtcayNPEPR5JFPzJDHdoBheJTslC+ut3II2Rklf2hJyVBLsEpBo74KCc6OXsXjCINpeXKqOYN4ZIPbB2lp+Q06DqY/AA0BwX4012rZXRffNO+mI8vKEKm0C30AoCDPGyyqD2RD00OhbHZ8YoONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+7C23Zy2so/OqdIMcJML3t+ObessMM4priEBhjcc0U=;
 b=qeSRjfrTwa9UUpMvadJl/y5flwb08xs8guBhSsZL9CAghpZEpMR00aG3bIPgzFr4Q19NE5ADyhMTCyacbXvFsA3Xt1zJYtsLG46WBvlFEPuyLkmHIJGFSphAXYhz+vvNQyifVI2M2urK7/04xWJCIgu2oNTZKjGBAiih5aj1DWE=
Received: from BN8PR04CA0065.namprd04.prod.outlook.com (2603:10b6:408:d4::39)
 by DSVPR12MB999125.namprd12.prod.outlook.com (2603:10b6:8:38a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 15:42:26 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::af) by BN8PR04CA0065.outlook.office365.com
 (2603:10b6:408:d4::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:25 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:25 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/30] drm/amdgpu/mes12.1: drop all BUG()s
Date: Tue, 7 Jul 2026 11:41:50 -0400
Message-ID: <20260707154203.2603209-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|DSVPR12MB999125:EE_
X-MS-Office365-Filtering-Correlation-Id: ca093dca-4259-496a-20cd-08dedc3e5830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ClyxPPSOsIQjxb4f4JON6SIQbeIIjgHUsaB4POXCwEbscH9ilqTG0IHhqzRI5FZUz0ICzKN7uwboLYnfhXLm5E2LGD+2L1W08ev6T3annJ4b9R64INfQtxXL5ZsPUdPj6XKXLRayFqLSq+KGMsWVC3Xhakkp796loJFrveH4w3jAF3tQEFtgUb4MH5oOenL57B2oZ2putCkEmCARLBfd1GLO1rJr8pOgpELJMpWXLGXAtWJvWEXbbkilYio5DZddbtFThh7DKuMYqG/C9xhYz3xHppWD1piEw1xjxMspoKwxahiMYlZ9DMjT7MKp5pv6FFZaF6suhxUnTGzvzlMAo+RtENxunZlFJnIH8KLu+ZQriYQTCa8j3Tu3UdXSE1KRtKUUANHC1hSxOlwwgJGjvWE6x/HiRFzR0JLmtf7Ey1ofyZr+faDBQv0C2w+90J6+u99kNXYWO9GDkDs7IMUtr+aL/T00maMjAdva/L5ib0Gf7EXgciyYXjVuTVAIeAe46PcqxyzOAUfqWo/OtVLePUzg4y6uMVLsciSxYw1mUOXSd5wIDf/kRl5w/la+wq/1xO7+coJmZ8r4lYGF1/Ji0DDeuRPCaaeLK7ENyFyUYAhVXtWHoiyuNCzlFTegL5pLhuBZ5xebwggqn+z1Nm4CLmyX+IBt++ND9xll39oKjbRTsyBkr5P32edwQTc5PSSssqehP0ENt+KXojCRAQcPRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m5k6JsKO/AJQV5xjkBdfEK0IStfEgWaOPe3hEozTenYtxwqj7J+0LaXENmwC1PasrCvG9zOXUuYXym7xaZJ0A6lM6/4xDWr9CplmI/4J/3Fg4+BWVyQcRVoSHg5IABOH92pPFQnz3wfl8Nu+CavD3oofj/heKPqBLk5ykMbY+EUyGuqEMpoC4ZHfugPAH23z3qRNt+WsOmYOUqLZTNmY0w6S+4ncunNp2tshz4uMjhpdV/d2nnNZwo+/Jl1HQ1hGt29erPOc2ObfgLkUoWRAAFNuBBv0Krw9P8J3UhZEIhx9N+OzujD+7juuKn/GB4gNTDn3xyVfbG1FZsMo+AAWKrnwwrHD3UGyQTa3uucrPI4mnA3LxXZ38d99OtG5ziPQqnu6qTLAeHcW+5/E0qQ/ccpgB7yI5zsewV8S/WU79n3qA+bjHi3I/m+km98Z2nYM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:25.8384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca093dca-4259-496a-20cd-08dedc3e5830
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999125
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index dbdb9ba02a5fc..c034b6946c7e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -61,7 +61,7 @@ static void mes_v12_1_ring_set_wptr(struct amdgpu_ring *ring)
 			     ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
-		BUG();
+		dev_warn(adev->dev, "mes_v12_1_ring_set_wptr() requires doorbell!\n");
 	}
 }
 
@@ -72,12 +72,16 @@ static u64 mes_v12_1_ring_get_rptr(struct amdgpu_ring *ring)
 
 static u64 mes_v12_1_ring_get_wptr(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
 	u64 wptr;
 
-	if (ring->use_doorbell)
+	if (ring->use_doorbell) {
 		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
+	} else {
+		dev_warn(adev->dev, "mes_v12_1_ring_get_wptr() requires doorbell!\n");
+		wptr = 0;
+
+	}
 	return wptr;
 }
 
@@ -278,7 +282,7 @@ static int convert_to_mes_queue_type(int queue_type)
 	else if (queue_type == AMDGPU_RING_TYPE_MES)
 		return MES_QUEUE_TYPE_SCHQ;
 	else
-		BUG();
+		WARN(1, "Invalid queue type %d\n", queue_type);
 	return -1;
 }
 
-- 
2.55.0

