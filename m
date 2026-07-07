Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC7BC43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80ECA10EE16;
	Tue,  7 Jul 2026 15:42:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="COB84SI4";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F30710EE16
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xx4Evwu314yX7r9ycKRqezI6wJB4R4JaMB61utsH2MWQlQEfIIXr4jZazbfE3w8XuvexKHRzZrjnzU3n06Z+J3aGfvuPSMMVSk95YS9jjjOYFNlGidLRKPjaOzEitY+1frIPUYi684Y2L+3Iv1S3ib5b2Opxmt1iFzqcyN5y7S5hjbATqGzz1hFFaSOHmcp0k58YtY5yfVbTJsVGXlT2h1sxvLkJUaUCGrTahPcjPVfwTzCSXFhpIL3xUNhD1mZKs4ggRaOu/b8gs/iBrWIBJoxvFd1dsiYIDruw4FwES8XnjnsXlvus9u9u+7df/qICId+dbfHoAOaOdQM0AXQEMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZfdY9bz54EvqjFv6Im9vtbREPm55XRoX6QtAAVPtwA=;
 b=V9vSqlcO/lZ1/jHf4D4iTdXOb7n8CwJ9ELnwmzspuevgSIRjDGVvOJNCflYuWXSPkJ1PlOZfUFc9+8MwLPKNsViA8PIWKWEVf5Olw/a0l6WrbJ9PuKtmEK3N3Y07z6/cHMf3R0jq6XNcIKD4g1A4+J/N652cFzz9om6C2q5RGeVtqgYdCkY2qM+MFOuTC72/5/veXlGugSh8LvWjk0rvdqgqQUtbTUlTSHEr/uSIRw+ISafA71b9w3q4Fz/xEtKO4h+6+9DMTAhbbtatJkkpFteF/dY5wUkOdMdl5966s1iIcZpBebXI4dApbzZTRTX01k4+w7w5snKfvms+cEtYcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZfdY9bz54EvqjFv6Im9vtbREPm55XRoX6QtAAVPtwA=;
 b=COB84SI4H6LXaVqd39zXihhu6h4IUT8nwwLII6eCqFAHjHXsvrSfR9iVvZT55K+OiwTbHaOppakOwX0dbu5p99XgP5qXbf1VTbzDaIPEKbUQWf76j8zdULmzOCQMMUPV7LyT4vKiwfoPy6foHXpztC68zSaUR7hUhop7pb4DHuU=
Received: from BN8PR04CA0055.namprd04.prod.outlook.com (2603:10b6:408:d4::29)
 by SA1PR12MB8644.namprd12.prod.outlook.com (2603:10b6:806:384::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 15:42:37 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::3) by BN8PR04CA0055.outlook.office365.com
 (2603:10b6:408:d4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:37 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:31 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 26/30] drm/amdgpu/gfx9.4.3: drop all BUG()s
Date: Tue, 7 Jul 2026 11:41:59 -0400
Message-ID: <20260707154203.2603209-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SA1PR12MB8644:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b0e957-33c5-491e-dd63-08dedc3e5f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: yHsbhLHrcNqGuz/wlSfNdLyK0SYXfYPm24CzGyBZ/L+y8prjQQB7uWpTqV0UUPEc/QUwnE1+KXLvFnv/ghqzBNKvWAnAvkPn8XVclu5cy/OKTShNl4fhmLyveZIONPHjdBetWuXgzg93KoVfrX/2n2UXdYKR/g/qevq0Zh9hEkG/l8gMSzvUbf3R7pv7/i+GxRvJTjOaIWzbUlHTRFJRcYTJoCDESBY0NfBSHAnznkMLkGVM5NaYbW0+ScY1Hg8tGWvsjIWgNXRjhsC7djMmUgssNthL888Rd9tNhp9Wqv/gsrv2U1MS6n2Vm6WNMNPKuqirLHnEF142+8dPwMsbPtCwnrCzXqV4HPqvFxByVlUB3ksYN+CFPkPTJo4NSeeMvV1uMUTsXs+e5h8wvWeOm8Rq/7Th6B4ym8v067J+S0odM3N5HWB0Kh1P787VfPWv9wVAwuzCbuS92sE1RyovvVBgi9eeWDYit3Ahhduu1ULzSUi6UQHkShT/NwyPFfq010tPwEpUazHpeMJ+yXn4LcXqh3SdVywTS0DPnwYVZVwqnp3IC++h+3wZ4PhCnCH7ztifMpLFWDHQPY6oNZOgbx4n0/WHzqGzYdfrXars8pkTCcjDGmb2eAcG8BMAbOcSQ1DK9SvutRWWVEUrZs/+thqaIRvDU19FZzMOSqo7w84YrRNEfz9h1xErlBlQfFGRf6GqRHSqHYrUBR0VEar1Eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cxc2yDTBDIg4palq0Xe0bnXGktnMoP6jF6ah8yi3FTjgkRIK4hFxC+N3O6nbANuR2eJoXWqNnx8BKeS+VtraNdo7xFlBfgZgu7KuwuRZ5UiSwcT0MppJ9t2cIN4+cAq5KpqX/UKX3Uu/W/JL4Wz32OLZAhq5p4vGUQcoNE8kl21lEtwhzHKwLniiylzfJ4zw1Vih9PPDX6M327EcPR1PF2kHJRM5Do2xFtxRty8585f8MOYYtXfSmHsbai7euIE9LOBV15ibl6LoSHlERq9Op7ME0pZOuI/SNhUaOssuHq4Izpf02l/6NpY+BnH8RZBEXiPCrjMZ2wWHQJVXM6T4lB2gR3dc5P2shQfM3f6E8KSZbvBf1a3/y23Mqo+RN2LKXS89xV/D/ZKB4gCI0W452VGeNhFIYBz5FpeWuuPKVPQ29gYsJ/LOfae6v+/ZzHOb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:37.3382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b0e957-33c5-491e-dd63-08dedc3e5f0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8644
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 44d38b76cb4f7..cab29f58601a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3029,13 +3029,18 @@ static u64 gfx_v9_4_3_ring_get_rptr_compute(struct amdgpu_ring *ring)
 
 static u64 gfx_v9_4_3_ring_get_wptr_compute(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
 	u64 wptr;
 
 	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell)
+	if (ring->use_doorbell) {
 		wptr = atomic64_read((atomic64_t *)&ring->adev->wb.wb[ring->wptr_offs]);
-	else
-		BUG();
+	} else {
+		dev_warn(adev->dev,
+			 "gfx_v9_4_3_ring_get_wptr_compute() requires doorbell!\n");
+		wptr = 0;
+
+	}
 	return wptr;
 }
 
@@ -3048,7 +3053,8 @@ static void gfx_v9_4_3_ring_set_wptr_compute(struct amdgpu_ring *ring)
 		atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
-		BUG(); /* only DOORBELL method supported on gfx9 now */
+		dev_warn(adev->dev,
+			 "gfx_v9_4_3_ring_set_wptr_compute() requires doorbell!\n");
 	}
 }
 
-- 
2.55.0

