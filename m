Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D13C3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 08:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6014010E188;
	Wed,  7 Aug 2024 08:36:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YCNzX9mm";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6518A10E188
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 08:36:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9rgw4Ay9/t9N/tCIdBLf5fEiCkzY3yyG3vniW9PVs2eV5Oi3XveDm5qqk7qZzTkBzA6AWkVJlGsEnKIc0DvFrG5twcvNH9kB0AuQtkHN4QbhWj+J37RPja7vWs0C2kFzvjjUBucp+aV2R2GGH7+ZAu2xtVOicdJAHIgHVL9Ci4jr9Tdep0atYnWd3n7zVSsWdBmMTy94W934z0jkJ28G6ulKwVAjgHkimaEFUPoT0dsxU+cEMjM90Gsn2d8mAHlRFnvSwZG0QUsBCl8gRubfex52M2bm0upbKvrPfKPrGCZa0lCuok87L8EonPRnLageJuwcEaWjrPxVJz0l9jeuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTej1H+JBeynPDWqZQTfbawuuUfHl0uoozdRyamxXbI=;
 b=gA7le7UDM2PXfVLAs/7szW4viN/voDgr/Mz98FQE7v+eJ5KoF1f+/fiiFlXw/N1+G7NvED7uUHrZ2ak2Fr8rhE1nhG7AZzZayE9b9OsSSzG8Bfr1PHWom2uIzl9R55WW2E+y7giif/movqc3DkYnY2CO3KrxUwUl6u7cZFDWAb8fJg+DhW94IIxYRSAAawFiItLXZdhFc0qKmJAf7luyotnGKgdocroehoVgJf+0RqiIewsX73pX5kImIYL8q7qoYDPKaVAHrG/kRQrSCTPb0QxXqccZ789PPLyakxceVvkMa2KPFBGc6xJd0OCP5UQqM4rkXlh3cuI2n+RDmHTB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTej1H+JBeynPDWqZQTfbawuuUfHl0uoozdRyamxXbI=;
 b=YCNzX9mmHpnnq0rRhrqbvrrOIPmrTKJiHfMldbAFhVo9Z+14BV1EPQpWbCyMbj3TmN7TiYR2rSBJw+HzXFAuyvloSk7GINLFO3RslaxqTVxMVi7Fww9M+6a95qQ9ess6v98Jwf19+RhH2+ijI7SztIWdhHm4XW8sGn46NlsVBpc=
Received: from BN9PR03CA0041.namprd03.prod.outlook.com (2603:10b6:408:fb::16)
 by LV3PR12MB9094.namprd12.prod.outlook.com (2603:10b6:408:19e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 7 Aug
 2024 08:36:56 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::53) by BN9PR03CA0041.outlook.office365.com
 (2603:10b6:408:fb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 08:36:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 08:36:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 03:36:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 03:36:54 -0500
Received: from sam-builder.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 03:36:54 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Samuel Zhang <guoqing.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix KFDMemoryTest.PtraceAccessInvisibleVram fail
 on SRIOV
Date: Wed, 7 Aug 2024 16:36:24 +0800
Message-ID: <20240807083624.1729349-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|LV3PR12MB9094:EE_
X-MS-Office365-Filtering-Correlation-Id: 349de709-49d6-4a3e-9297-08dcb6bc1855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b3JePYnX+kJ7Roekw6r8KBR4yBf9cd9gCBnXHhXY0bpKYO6B5fuhUazE49s2?=
 =?us-ascii?Q?FpEDBKXVMOWKrLO+aR+bePiV07dyGHq54S5uuBerfpCBZp5b936mqyLZY4Tp?=
 =?us-ascii?Q?yxZUCzkO4LcuSg7GDLAAdTAP3yiffNzqJZRrp7kSbVWC+T7AsMItMIDcZmSY?=
 =?us-ascii?Q?JNIjJ9Rrjrf3sQEQd/sDWyxbtglz4Wylx4DYkN150Z9ZdnCBVhNbFOX6JyHb?=
 =?us-ascii?Q?QFVxYbgjqRi9VRRVayU7v8Z3cFZlsSlzuFcQ0fiZHnwSnsSJGTv9Teh4mZUO?=
 =?us-ascii?Q?QpxPoHcVYzqGjQk/ODPxMxLY6/kooGltzl/Dze1CEcvzN1q2Ud14p1Toq/9B?=
 =?us-ascii?Q?RUdfbbTmPH/Bii4F3Zgfh3lspcXjw0rDQ+DJZiz5kQy1enQI/7sB8yJR81Vf?=
 =?us-ascii?Q?avgKfz2ImrGJGiGTmkKaRkDQ+0Utpnjfq+D8kJA+oJLOIeqz3DOq2SbOuzU5?=
 =?us-ascii?Q?UKGcLil9hwACBjQq+Jd9ECB+0UrFvDyZ4iVNNK9j+q15ynVp8iVaG0oSeKw1?=
 =?us-ascii?Q?GLdqcxvWaGNuQSr20T6HO6i1UMzFUOIWbR/i6cymoUxW8IX7s9AtzQOGRdUw?=
 =?us-ascii?Q?1LrRMMurticHW1MsZTQEWL68CUKYxCoBP5YpmpTp45R+FCwFQEenkH97JlzI?=
 =?us-ascii?Q?XG4WT/kTCFeySNXQTXSpAjqVW7c1JKvn9+sVpBruNLZhYm48mv90nQ46O2Q7?=
 =?us-ascii?Q?ir0fRI1usrxyBPc8vOiudGink6eVfg2g6e6Ftl2tLUDjXxmv7We1SCYDTRd6?=
 =?us-ascii?Q?881Jjt3RTn3udyJ4mkUsGMpHYyRXjBGFbUQKKt2xvYkNwlVlyidDZxCg8OHj?=
 =?us-ascii?Q?wOYOgv+kxHy6QfLB174riZmfegsl3BuLX13iGAWnVP5j4DAJ5N7JYbvmEiQS?=
 =?us-ascii?Q?eMfWynKbMo7SV69Em9MQJJ77vxEM/84ELWVPkuhuwvx9/7lTAKsKkGFDY29h?=
 =?us-ascii?Q?tY6YmQkekX1t14IIcNq1L6urqce0geVvbQhIRrppYdHA0h3GC1PXAXJpEb12?=
 =?us-ascii?Q?0RSsK5cU9weVgbw2EhnsENJsW7bM+trMe8vsInl3t66pjn8p+zYm5lBmF4q6?=
 =?us-ascii?Q?JAKq1IuX0asGJ4762w9w5SOKHfEJZOJvDkOR3MIWm8p7CNRfxDcar3+s5ZAE?=
 =?us-ascii?Q?D+bdtnNkIJHBZfU01WIHsAXpgXP354A8IHrKUSplFkllw1IXtkQ7WWFoeE0y?=
 =?us-ascii?Q?NN2b17vx0eGCOdlgWJQP9b5ADt/ktLcEnYWopZ69uvZplu6/KuXD3bJ2CR7q?=
 =?us-ascii?Q?qndSC+Hi7k9m1DZ4VP25T01plyJS7aCC4X+zOHP5jQSXsGuOxq/gOWAJ74I6?=
 =?us-ascii?Q?7wlwKlRQ0pGHoLPO0qSw3P0dV161QBWNAmKapHZ9ZLvDqMszgjqK8z561LOh?=
 =?us-ascii?Q?AhZTo9Je9tfytAd1Wd6dNaw261Zf+PoNWAXYc9dTCkHovG5sxAuUmY4SyEXN?=
 =?us-ascii?Q?ZPYD/c+omL8wlvmX9ZaaEaylv/A2gEsl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 08:36:55.7354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 349de709-49d6-4a3e-9297-08dcb6bc1855
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9094
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

Ptrace access VRAM bo will first try sdma access in
amdgpu_ttm_access_memory_sdma(), if fails, it will fallback to mmio
access.

Since ptrace only access 8 bytes at a time and
amdgpu_ttm_access_memory_sdma() only allow PAGE_SIZE bytes access,
it returns fail.
On SRIOV, mmio access will also fail as MM_INDEX/MM_DATA register write
is blocked for security reasons.

The fix is just change len check in amdgpu_ttm_access_memory_sdma() so
that len in (0, PAGE_SIZE] are allowed. This will not fix the ptrace
test case on SRIOV, but also improve the access performance when the
access length is < PAGE_SIZE.
len > PAGE_SIZE case support is not needed as larger size will be break
into chunks of PAGE_SIZE len max in mem_rw().

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 5daa05e23ddf..a6e90eada367 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1486,7 +1486,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	unsigned int num_dw;
 	int r, idx;
 
-	if (len != PAGE_SIZE)
+	if (len > PAGE_SIZE)
 		return -EINVAL;
 
 	if (!adev->mman.sdma_access_ptr)
@@ -1514,7 +1514,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 		swap(src_addr, dst_addr);
 
 	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr,
-				PAGE_SIZE, 0);
+				len, 0);
 
 	amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job->ibs[0]);
 	WARN_ON(job->ibs[0].length_dw > num_dw);
-- 
2.25.1

