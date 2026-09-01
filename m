Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9504C61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25F0C10EEC8;
	Tue,  1 Sep 2026 20:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2bdRWgOU";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45FB010EEC8
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:10:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbRtwch7LRY6wTDgt0+IeCxIZSPCc0PJ3g4L8omy5/86Rs3OZugdzff07aBU2erc1MX4Sl3eZQPR0NbD4GnVJR2hBcZ4ID/SFlAbxAQ9/4Klrh0znDJo3aeNC8BA1yiyRg8Y38elCyyxn8qroMu1SveaslWLQmHCa8YPh74gvi6eOQfZrPQXgpJJOAcOGll6N2FpgF5whr61wY3+ppijGdyzUxYq3bE5v+en5uuQMn0CAMdwV/7jFSXSFFcg8o8Wh+VlGQR9rCWagsx+oAQcVuyqzzcxXMrWGW5z31BIwnP5TXa/8/nRRNbm1em66aLEv4txSNAx6gvZAK3xVqztng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nu2Ag9z6peX6eHKAQcwQ8GHwpmfGbJH8HxBYSU+xzNg=;
 b=BDtWBIyxoKyD0Jm8EQ+qZHPaQKEno6Ee4CVwILDtkXWNCFCoTbKL2HW4GGY/SEBHPmOUaBWj3aMc+ZMAaf/aFWFvmmhPcds/KSgxwzIwpFjNJex0QYiSWEiemwkHRDTnTqn0AhuTNRO5PwmHbAxDwGAPAWnp/nak0rCBe1H34wCY8fiUOZ05McXW4VidfeNZZuMxV7+UbMkH6a+RICYy78BJvvg5AkiL0IheEgnOLFNBwXHw+g0n5WbvsqzorZO8OUyVQNhCes8VKI/cBuWvGFfgKp5l8Y3oBcnMI2angf9yzn4jZvYyLORs4nPs5iKRi6JJRZ6+J5HqrIlWqcpNrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nu2Ag9z6peX6eHKAQcwQ8GHwpmfGbJH8HxBYSU+xzNg=;
 b=2bdRWgOUoejHyzRZNWbEcvWC6UoavVLLLiTPDvW5WFgc91LYOMWXlVJ+Z/QPYQvlf8rOjPW0rW6TStJHa7N38LmarCCBoCZypGYnYUHVy8Po52mRxVYrlrJERa88Bu4AFdhuOeNJuV0Mwu0MY31P7HxWeIDHkW+YxJm9PiDm7DI=
Received: from PH7PR02CA0002.namprd02.prod.outlook.com (2603:10b6:510:33d::33)
 by PH0PR12MB7905.namprd12.prod.outlook.com (2603:10b6:510:28b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:10:51 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:33d:cafe::4e) by PH7PR02CA0002.outlook.office365.com
 (2603:10b6:510:33d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:10:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:10:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:49 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/31] drm/amdgpu/gmc12: disallow gfxoff around TLB flushes
Date: Tue, 1 Sep 2026 16:10:07 -0400
Message-ID: <20260901201034.2960437-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|PH0PR12MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: 5043bbe8-755a-4587-7767-08df08651e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CgzB4hwDlR4tL24QkpIzSNwgpDri0e+58nPVeJX0Gtl5cVkyBJUZFD7/wqovFAo74OPolf4K9olO1SrzFqXVHBvNGv1id4q88ePIEpOJ5L2bG5795bubv6eXIqv2aEYV2CNMHO1Tezt9g8D6B1dZHvbLxiwUcFht8KF9x4e8LmEbQl4SRhH2Hg/jUCIzdw4kOABPBeBrxNFSGJCo9giZeytwFkJ0KuRbxS4HPZon0YkoewzowmZezHUu6LSZhwB923JZsb9CVLoVad4htBvo2G/EZUPP6zegW4KxbFGJIeBHHCcwxTnnweH0tFKoWCk2teP6/G2IMljxIRddyRoStkgggCIvOzlEevSviPvARtWv2pqswwDlGR1o2Cu+3wAKFnngObjQyGVTPIfdWosv3WGQAWGn2Cnv9L8RRgMHyTVjKhuYXWCuopdhTQ/kZeFEADKCd0fwRt8wIYVdtiQ5vfXgRgIBUuhEcTybudsuDzFFCwHTOx3VAJE/5Yydg000hbxuWnBPYQmPzqMO7DLwzqqURSngHRbIH9LTEE3JoYbtt7eo07Mkmb6+aPOIGCaHLqyH/5rEE45GbEtSgP/M22+ppakZrpE03NiOVGRN6JabrB9Qse/GHDQY7XJeEbwj8UZOIsss1pIEJBNAfNyUGEOBWVzQEa5pS4buso9j7Vpl3g1GJSG3L5jo9FZyVSAzH/Y63wt/1Ldg2DWGOztAVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vg6dwYx0Qf4L2hbzZLvgpZacTqJmwrN833L/sF1C4nAgpYcrqHlXP1nazKIg2nbXp4inrphsXRe7uy2pzQXGt9+tTTwgH4cOQGeAVHeRAQiL+xxzSogRZnbOdr/2Gu764/4riLJki/aCYR5IkVGTM4VYkdl2dReqS/e1yn19uYlnEaAks21gpSd2BajuSOwOU/RcfVExJfYkKH9+eo2D4UvUftCaWFJqW064qmDRqa9YuvWS7d3y+iwiepxWbDWxrqaLb0eQb/L22aaGkStA9G1ntIHH5fBgujwgZpk2fIsWtH0SsE2uYtJQCdrCvQbBhIeLH80SMa6Vb7IyfWpudUQNrZYQ7TakHIEr/KX1tAjdr5e9cLu1CyeIk0+LgvqI2mAjMs8EBtR45PpGTkYqFCR+ZWXCTrxB4rrdAjtrPlDo9q8Rc1ooy2EEDYnoppSv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:10:50.1117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5043bbe8-755a-4587-7767-08df08651e3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7905
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

We need to disallow gfxoff if we touch GC MMIO registers.
At the moment we use KIQ or MES for TLB flushes so
no intended functional change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 2c7e3eae7b237..3b7764b94de19 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -327,8 +327,14 @@ static void gmc_v12_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		return;
 	}
 
+	/* disabllow gfxoff when we invalidate */
+	if (vmhub == AMDGPU_GFXHUB(0))
+		amdgpu_gfx_off_ctrl(adev, false);
+
 	gmc_v12_0_flush_vm_hub(adev, vmid, vmhub, 0);
-	return;
+
+	if (vmhub == AMDGPU_GFXHUB(0))
+		amdgpu_gfx_off_ctrl(adev, true);
 }
 
 /**
-- 
2.55.0

