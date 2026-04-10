Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73323F44847
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 12:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE7B910E950;
	Fri, 10 Apr 2026 12:28:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NHJLrhTr";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012050.outbound.protection.outlook.com
 [40.93.195.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C07E710E950
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 12:28:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TR8AE38TX8ylJYCSHpD8s5z8buNjiyBV723Hv7uSUVfSkuiKo8/7Jt+8Ns7gz2vq8Gni7E1u4PUWVvJY0tjLLpvtiyI7l/3uEKT7XPoqBdpY83PSh8lGDejVMPpwMhVRM7Lr28q0k7Ee82u/rIqZxfW7gs/TQa6kZLo1d9TcQaa+wGEFfWvLLhmz15xE8s5raqxwQIlPhhY+eq6NiFiWpMvJNZZrQqI1L36aZIVZNTEloYwfqHHlF3VnJJob22TtTsdYPtJtKpXCzIRbJ+T/GnyTUEblrwSrL+tHQXVxZY4Gp2Nd++n3NVJ5lMuc/AX29w+6QaV7svrYOuLyg8/k9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lra3Mk7hZ54R5CvDSPK0DJwEur9Ccjum3QIgXu67J1k=;
 b=bSrdEoM52KJXurQSE88EBhDwbGq4LUQrez3C+lcz2Rox1vq3upY6Ekc239ryOFhpRh4Pj2vY8CMG9vkbNdE6VFyFDk9rcYUWH7hcaOjQnNplNTlW6MtfVvwWBnpvKBfBQEGfXsdGA6e/evziRxD3OPS+nmW0fmvKqZP8vsANeAkQ1+eXh6uGu+hK1D7IGyLkBBts7DYDCmoR4ee5qMqHsYbC3aekHVL198BLVhnJKZgZcRE4tISnEAkhyW34GKuDjlSD+EOqPTAFsRvCkErRn793imIjoHJ+Wb53Sh5Nm9Ko9zQgI8X94pwf55zEoAsPQti9RgAHG9KjoomyP8IpRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lra3Mk7hZ54R5CvDSPK0DJwEur9Ccjum3QIgXu67J1k=;
 b=NHJLrhTrY6O196LJoQxlyuqnvNB/GDVUCjCLvCGdOl2Agq5QbkYrbDxBhO/a4VYq2DmAPZVXs2XoxTOkNNS7yhQPqjKSa1BvmJb69z6QXBXDFaWw2CiE7zCNc1JUdl+Z/z0VODlvmCwrnXXwOv2M+YY3IM0C6BPVIMdYpKNBGHY=
Received: from SJ0PR05CA0103.namprd05.prod.outlook.com (2603:10b6:a03:334::18)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.35; Fri, 10 Apr
 2026 12:28:13 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::28) by SJ0PR05CA0103.outlook.office365.com
 (2603:10b6:a03:334::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Fri,
 10 Apr 2026 12:28:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 10 Apr 2026 12:28:12 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 10 Apr 2026 07:28:09 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/mes_v12_1: Fix iterator reuse in
 mes_v12_1_test_ring()
Date: Fri, 10 Apr 2026 17:57:56 +0530
Message-ID: <20260410122756.2287428-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 2463de40-e851-43b9-5cab-08de96fca202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Wj85owWS6HzdaST1bcMaZJeOGI6qoCjrK/M0i7qOq3qXoq8YkOgVrbQIlCpu1DLXujR7S2iPtKYVUdNYdBYHtaVlZTCv5iN8wM1hkymY4phOksFCTogcDcH+5K/wi4yukm3DybXcnC66uOx6Zi0ZIbsB9+Up5jjZmP3FdHzVH+PsPyBn+CfdEkSOF55zaaO3H3nSGXcwrr+aWpXMbGl6/In4A/euXCtrPw5gELfhTv6rFnLN/HhjMc6JCk0BPn3tqR9BlDQJ1eShE6nnYR0vt5FrfLrHI2Z2RxeJavAPhGK/sFpkjwvR8UwJ0GJybvDSrDqIiAUHm3Aafu0Fsspt6eZFOLL1vA+V397GtCqANIvRnE2putWjReufynid9vkGZM6JxqCkmvvdMOFQ8sN3H79Xo0BPN1nZuM2Nh6e28/fq2NL1F5bKt7kDRESRHPPdSpfRrNlZX+7/dbPfCaDYHgLGmiaD3xftiE1lrIDRvtTyg+GS+7suJoGmK0HgdcZBb/cibnnna/fNTGZVUwC2zx24ug03Mmj80o6vJBE/1iNhTBfqumcFGjKcS4h3JPbSMyeGd9p6LAMylCLh86HJaV1P4YdMfj1gSI4YgQTXJcfN7XKUVjnHDeYYWvCC5wLRGHgWn0ZWuW1DDFx3ZoWXwm2DZ4fj1JpMZCuGams2PQZvMEgWzQh2YVZyPGabo5k//OKaqbqLnUdwD2dxjRXF5y2X/0pJZjBhFYBzluSgA3+Do3bg53tClk7SN8zku4PSmHZ2nJXZMhUj6ynOryflpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xFKR+WcrQpD74ED+cubyvRTGiYgahn/vOQHegBTamznlgFezDCL0jad7zkqv1rTWhG97F/5NqOZMe9ZF/YkvaXm2HQGx89263PV9FUcVkn6j1+DD6dL/1pWrlGm9AMmPfrJevNm0wpXJ6ohbxMu2d0pOSQ9ir/uu3kDZTy7CL6Uusq2taSnJYTSe1sEZmtTEXTdNWqoL6qmwGJlqVpzJNH0vqYqFdptBgmetWZ567tmgQHJXEDQ50te0e7m2pHKAYwu+5jilb7BLoHKG85pLkg0mE8JHqNp+f+w6HocuGiL2YeqnV16Mm88kp9DV6BaG1pmSFkNeYorMpUmZ36H0P/MOGjZpOyMVWmIQudTgdLcCtlGvy04rfdr1sdCRwIthaIAkvMUAmjFX4i5TWA8gKP9LhqBNpnktF9t9Y5f0247wX+L0QSmWASwRf0vV+NwI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 12:28:12.5823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2463de40-e851-43b9-5cab-08de96fca202
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798
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

This code waits for the MES self-test to complete by repeatedly checking
a register or memory value until it becomes valid or a timeout occurs.
The fix ensures the timeout counter works correctly by not reusing the
same variable inside another loop.

mes_v12_1_test_ring() uses 'i' as the outer timeout loop counter, but
reuses the same variable for the inner XCC scan in cooperative mode.

This makes the timeout counter ambiguous and can lead to incorrect
timeout handling. It also triggers a Smatch warning about reusing the
outer loop iterator.

Fix this by introducing a separate iterator for the inner XCC loop so
that 'i' continues to represent only the timeout wait duration.

drivers/gpu/drm/amd/amdgpu/mes_v12_1.c:2080 mes_v12_1_test_ring()
warn: reusing outside iterator: 'i'

drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
    2069         atomic64_set((atomic64_t *)wptr_cpu_addr, wptr);
    2070         WDOORBELL64(doorbell_idx, wptr);
    2071
    2072         for (i = 0; i < adev->usec_timeout; i++) {

i is counting usec

    2073                 if (queue_type == AMDGPU_RING_TYPE_SDMA) {
    2074                         tmp = le32_to_cpu(*cpu_ptr);
    2075                 } else {
    2076                         if (!adev->mes.enable_coop_mode) {
    2077                                 tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
    2078                                                    regSCRATCH_REG0);
    2079                         } else {
--> 2080                                 for (i = 0; i < num_xcc; i++) {

and then re-used to count something else

Fixes: 5ba87c3e9e4b ("drm/amdgpu/mes_v12_1: add mes self test")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jack Xiao <Jack.Xiao@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 0e9089544769..cec801278126 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -2028,7 +2028,7 @@ static int mes_v12_1_test_ring(struct amdgpu_device *adev, int xcc_id,
 	int num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	int sdma_ring_align = 0x10, compute_ring_align = 0x100;
 	uint32_t tmp, xcc_offset;
-	int r = 0, i, wptr = 0;
+	int r = 0, i, j, wptr = 0;
 
 	if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
 		if (!adev->mes.enable_coop_mode) {
@@ -2077,11 +2077,11 @@ static int mes_v12_1_test_ring(struct amdgpu_device *adev, int xcc_id,
 				tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
 						   regSCRATCH_REG0);
 			} else {
-				for (i = 0; i < num_xcc; i++) {
-					if (xcc_id != adev->mes.master_xcc_ids[i])
+				for (j = 0; j < num_xcc; j++) {
+					if (xcc_id != adev->mes.master_xcc_ids[j])
 						continue;
 
-					tmp = RREG32_SOC15(GC, GET_INST(GC, i),
+					tmp = RREG32_SOC15(GC, GET_INST(GC, j),
 							   regSCRATCH_REG0);
 					if (tmp != 0xDEADBEEF)
 						break;
-- 
2.34.1

