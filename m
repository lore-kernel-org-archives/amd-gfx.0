Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643E9CD98DA
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E12C010E78F;
	Mon, 15 Jun 2026 23:57:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OzvfS8YR";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013015.outbound.protection.outlook.com
 [40.93.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0FB010E780
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oa2RfW8xBzH7ya1L8PqQ+RcB/0HssBiaFr+ZHM5MHMlmdyHgbsUoS5UoI9IBJeNDSJxWbhWQ4uYh/qzITg1YkcQn8C7iw1RylXi24pf4IxqXtKT4RCPW2estWeVJQgepzCVNH/Pu7p1jZ7kmA6EvRgltGhlAPGAildZM0oC2uERlU5HP73w+GM6LqPXKi5Jd1FMnQFheStTtZ/gGmjoPvLS7SOkPI63SfElkcWVWVNjetA9tfm1DD0y3RrsqArOwvVXHBRyLkODHnaUnfHZHrsD08lBHvBGYfthx4VYNeY6XOo5zFsvuhd54OAfMoulwg6jk6MNGFJe+98bmK73VuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJdD8Ht71nX1IgZCpKYP31BgNc9wt4j4KEx6mo5l0ko=;
 b=uKQVtduecVEymkuTpMB0XpyREsr5iOM8lKCldAJSDxz2a5hDoEhz3CwveFmxEMVgIexgHoTG+wKNfjUgwvJMAaBNnPrw/Gs/4Cb429qcw5t/hosPgq/WCMsbHdEh4yg7uQQWZC1zFu5r8zeMYcW5CpfYNyLN+txV9BrrA8Ri1EdXnm0Vi57JIl+K4Vk9+1EZoEjbR9qQO9A3C/1cRkrMudf3138jle69nCGfTtgHzwd7LiObBiUSCRrRv7euC5M+dKNaBDSikXKq6cFj1JQNQ7gkLT51AqI/z2UBA9U5kfsCenqQ33q06zMbYi0F/5kxv9Qp57+8JjoxVe9Xb2NfHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJdD8Ht71nX1IgZCpKYP31BgNc9wt4j4KEx6mo5l0ko=;
 b=OzvfS8YRKSdCbuLFb7WZ08pSKxyxituoH4N+zEdI+2V3lv0a2ml3O/Ng0lRpSkFmPpEiWcQhuOVL24INr7Pusk3R4XCgBAY0ZEMKQBuXCgjNhW1TgSM1Od5tPaxA2DjLDSYejEIMR5YjPGIVS8yfZQl0zb+VGSJ35EVjpmqINUI=
Received: from CY5PR22CA0054.namprd22.prod.outlook.com (2603:10b6:930:1d::18)
 by DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:57:16 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:930:1d:cafe::91) by CY5PR22CA0054.outlook.office365.com
 (2603:10b6:930:1d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:16 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:10 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 35/43] drm/amdgpu/gfx6: drop all BUG()s
Date: Mon, 15 Jun 2026 19:56:37 -0400
Message-ID: <20260615235645.737189-35-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 56aba34f-b2fd-41a0-9d48-08decb39d3d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: qo9FgLbvbVZhxmlGS9cFwkuQBe5CXrhbi+SylqkK/8tFPo+eN6F7ut8OVF8bfIfJ4/dk2zl2APzdx7DchYsDnQYUBHC5eslCo9v7kTIJeUPGTCbeReI8EiLrUE4M6xptfrDOUk9VYxYiZ8Jjnv4FpbTeDKw20QRaZC7dgAVjsI02sFP8eQXA/dQ94OmNv5riFvHpEV8eSLExIBWAMKwwIlb0CfBog1yO8MV5JCuagAR9H/fbb5lp5plpHufVvzLKZ0aUhEakMBVqECWfV6JLFrL8kwKgRRPa0jsxgUForhjbwto32qsEVQZI5zJQrqGc26G5sYt4Cm9VC2FJm79VuV6wa6srkBN/yEtBVmXtfD5V7jV24KJztUlKBPfKkIaCm6LuaA92HN926AeAe0/ALuakZ7WgiF+BBdsGS/VMYatZKjV7zmaEl+sO5ypVtpg+Cm0nyXkoYjeu/pcwb2fwamcOIMOh6U59NJZtG1PbpchXGzQbt8whrs6LXuDLGWn6wU7a3iv/W+YZQJwIEeSmP2JaOsB4zPvQ4OZKrekVjRCYikQdIXrAsSALhDpzgsL9foiqvhbdh6fqlYFJto3VgihJS1FDHnQYYyUxzY+Lt3vjHtvXtmKdJxjnmoCIs2eFWRegjnSNjb3Bn6uJf/WNEE/axL6hlgEE9snWHGaZ6jIPPpH98rEO5CSQGpD2CWU4YHKv7RLghPTfK2sxwOhoz+vCtu1rRtPjEKHJ9iKPoIA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FXp30MHkCle9KMn1+H3/2WJ9rGFfUMgQg4cRCuVh2fG4xoiz8S/jKqxo/JLYKbUwHNSos6XMSEQ+HS5fvDpJt1X9rqCCPklb/8FGs/kLyUD2jSIjy+R8OwqfpOYdGDckbPRZopdaz1Lsv1P7E1rJxdhZ3ANdgIpkr/TDHZ23Cv/5ThzhOumvT1cIR9meYWLuXU/ex7jTF7pAfGQUyDl4ySmtvuMu2iQHyIrQPiLUkl9Tm3aXFdm2v9PL1WgPqH/4YxXMCAAhbs5TlCKcb/kqybfMaBUgXVKXNtSx/jiNbWMWepmNqDLTYhi5PqzFx4PsQbtd4nBHIcJ+QAKE+I9zxxQs1/HCDfL05OCYMnvFGnEAv5xJ1gGD/J4pgiFfIHj685MI7f5kzrwKJMWoAHKajYTCeRzMslSMw8YjvBfMCO1J4lfZv9kfPsEkgmKbG71m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:16.0699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56aba34f-b2fd-41a0-9d48-08decb39d3d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745
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
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index ac90d8e9d86a8..4ba9ff7c3b3f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -347,7 +347,8 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 	case CHIP_HAINAN:
 		chip_name = "hainan";
 		break;
-	default: BUG();
+	default:
+		return -EINVAL;
 	}
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
@@ -1736,7 +1737,6 @@ static void gfx_v6_0_constants_init(struct amdgpu_device *adev)
 		gb_addr_config = HAINAN_GB_ADDR_CONFIG_GOLDEN;
 		break;
 	default:
-		BUG();
 		break;
 	}
 
@@ -2202,7 +2202,7 @@ static u64 gfx_v6_0_ring_get_wptr(struct amdgpu_ring *ring)
 	else if (ring == &adev->gfx.compute_ring[1])
 		return RREG32(mmCP_RB2_WPTR);
 	else
-		BUG();
+		return 0;
 }
 
 static void gfx_v6_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
@@ -2223,8 +2223,6 @@ static void gfx_v6_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 	} else if (ring == &adev->gfx.compute_ring[1]) {
 		WREG32(mmCP_RB2_WPTR, lower_32_bits(ring->wptr));
 		(void)RREG32(mmCP_RB2_WPTR);
-	} else {
-		BUG();
 	}
 
 }
@@ -3310,7 +3308,6 @@ static void gfx_v6_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev,
 		}
 
 	default:
-		BUG();
 		break;
 
 	}
-- 
2.54.0

