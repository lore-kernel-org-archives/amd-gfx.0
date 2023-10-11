Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BFECDB476
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 18:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77F6E10E0A2;
	Wed, 11 Oct 2023 18:27:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A42310E0A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 18:27:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6nlr1JwXt1CMD6BIegxY+anV2MZDF4GS0nHlZVEDw7tzBfBBpEm2tAyYHiHmOS5cqbc4RupRL2HEXN/6azXGKicmbuPMJ9HYRh4VhFNXXBafn/Glif6o6QoK2G1fUwvzgjiIbiZtexx3JBr5UloNoZIE2cugcWLxefjt3pJrZd8ZsbJOMfqeotTAYDKxcQjGTSEumRgyYH56oI1VEZws9daxUZ2U1Y4LJEDjQJzWLJvvC4tyRaOAyb4JzOvWEav0D5Gl5EgrPIW+N7Xqawf3OxmWOpEo8ZwMw+dG6ld1DA+StuBNUiCYLJigFzNRLtJU8XKDzn4s47qYPx1nsgSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Jm3MG/VysvVaCdKQetHo6jl8fGQzDJZNA8NuhaGTno=;
 b=hPf3n7R4ep7cRzpGGOxDDP2IqleDVypao9BJW5ZrUskGjcRxuFk7C/wNA2yvl+2vvO5+d0H9DaZZpQnhJigxOJwgkBP6jtBtFihUOvTLCp3R2otmWzFvZfMwH2c1aDrOOkor+rtA3tziqftXYTDh35fnjMJ5E8+pBvsjoEw8DSdtaZsu2rtxi9L6Gt/kf6fPm7amDLztALpee+N9/Ffmh7XRO9ZLon3pkybQcgvaUJQFiuULD7Jw5NFuOpK+JufK2gXrdSIuI3YBVqNJbb9kcOZ/E4xNvKkuURu+N0aYWpqAprGY4RQH9+3NypZJNS3e8b8/yRr2XUsd8HnTmz9YWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Jm3MG/VysvVaCdKQetHo6jl8fGQzDJZNA8NuhaGTno=;
 b=qQGGG5Dc9PpagQIwnqyTZInI+Px2hEx4WKnWloUK2L6tw01C83QrfdKFHKiddFDz0jvnr0jJEXncgoW8YnXTWhTGeXxBiBolcznYRoZKLQQDCYLVT8s1OiHtAvJsiwo+i9SNcigUQFEDn8/OU9sMMoGvkG2MkLH40FQCe2OUViI=
Received: from BYAPR02CA0041.namprd02.prod.outlook.com (2603:10b6:a03:54::18)
 by BY5PR12MB4999.namprd12.prod.outlook.com (2603:10b6:a03:1da::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Wed, 11 Oct
 2023 18:27:02 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::a4) by BYAPR02CA0041.outlook.office365.com
 (2603:10b6:a03:54::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Wed, 11 Oct 2023 18:27:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 18:27:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 13:27:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/mes11: remove aggregated doorbell code
Date: Wed, 11 Oct 2023 14:26:47 -0400
Message-ID: <20231011182647.2599981-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|BY5PR12MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb39a97-a776-451d-9730-08dbca87a9a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3bk3E3WZaKp/W0TXP2C3MHtWnN+8yq610HBGa0/eeYMoj3y+HQBuRApXhU1LEjIlCoFusIBvLYlfnBFyadIOPC63Trfbmafd83YnR6xYEmRJNAvTJkuMmFF9yM/sR1EFJVrum1pGKaUNmfmXLsddrFmy/2FuotW16BAuOLNyCNBRPK/0zqpn/Bqe63eQ2YqAQjDaLIiw1KXBw6DmzTGbKnR7yHEONn9ahb/2NNof9JQcQKWSI/FUoRtNpXJigBYZLoHsbA1SqvO/TyXysYUlgxjIjHXTh9AiHJSNiMuh0Vwetff7fLuppBOOQrDoM08p5H+Wc3OvT2bLdmmWPt65ji9OkE33uYq8iDtozCaKbYVJifdA0ZN7zfce8HL8upoFUAezG1ZoaITN8hI1WQVj73qX3vyVX/Ay2cIlVL9HM00jIDy8K1au97yuXf1oWb5dEDn5EkaWFRskGQjGipdbsgln7lSmtw0joSUveywU6/zfmJNunL3uVbFWnmnAA46toxY3rq7OS9TPtSG9tcAxMLKsfyAczAgAmeH4a50hiJVfFwQSivo7Uq8rx57Gs3/8BqFPM6ePLY4A7zpkH+kZx37SpRKzaANJgIXeJWTVFNCAImZND+/m6KFD40yob1uPzR8+USNF4sMA1MiO6LsMH+QaL/7mdEA6HLO6GFbZ70hduvsvdxnACZSeosdw/BdAYappJsvsLGq+BwtPrsooUtr3CG4TqlJhgx0Lq4yMx6Y83UWBARSXCwd04UOIh7CNXKE62E/6Q+zjmhWV+xJbdWDmbTul5bzGPqi8SAT35s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(40480700001)(478600001)(6666004)(47076005)(40460700003)(70586007)(6916009)(316002)(70206006)(30864003)(86362001)(2906002)(82740400003)(8676002)(8936002)(81166007)(36756003)(356005)(4326008)(5660300002)(41300700001)(36860700001)(26005)(16526019)(2616005)(83380400001)(1076003)(426003)(336012)(7696005)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 18:27:01.6623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb39a97-a776-451d-9730-08dbca87a9a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4999
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's not enabled in hardware so the code is dead.
Remove it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 86 +++++---------------------
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 56 -----------------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 83 ++++++++-----------------
 3 files changed, 40 insertions(+), 185 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 27b224b0688a..91c07ab4f14e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5170,45 +5170,17 @@ static u64 gfx_v11_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
 static void gfx_v11_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	uint32_t *wptr_saved;
-	uint32_t *is_queue_unmap;
-	uint64_t aggregated_db_index;
-	uint32_t mqd_size = adev->mqds[AMDGPU_HW_IP_GFX].mqd_size;
-	uint64_t wptr_tmp;
 
-	if (ring->is_mes_queue) {
-		wptr_saved = (uint32_t *)(ring->mqd_ptr + mqd_size);
-		is_queue_unmap = (uint32_t *)(ring->mqd_ptr + mqd_size +
-					      sizeof(uint32_t));
-		aggregated_db_index =
-			amdgpu_mes_get_aggregated_doorbell_index(adev,
-								 ring->hw_prio);
-
-		wptr_tmp = ring->wptr & ring->buf_mask;
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, wptr_tmp);
-		*wptr_saved = wptr_tmp;
-		/* assume doorbell always being used by mes mapped queue */
-		if (*is_queue_unmap) {
-			WDOORBELL64(aggregated_db_index, wptr_tmp);
-			WDOORBELL64(ring->doorbell_index, wptr_tmp);
-		} else {
-			WDOORBELL64(ring->doorbell_index, wptr_tmp);
-
-			if (*is_queue_unmap)
-				WDOORBELL64(aggregated_db_index, wptr_tmp);
-		}
+	if (ring->use_doorbell) {
+		/* XXX check if swapping is necessary on BE */
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
+			     ring->wptr);
+		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
-		if (ring->use_doorbell) {
-			/* XXX check if swapping is necessary on BE */
-			atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-				     ring->wptr);
-			WDOORBELL64(ring->doorbell_index, ring->wptr);
-		} else {
-			WREG32_SOC15(GC, 0, regCP_RB0_WPTR,
-				     lower_32_bits(ring->wptr));
-			WREG32_SOC15(GC, 0, regCP_RB0_WPTR_HI,
-				     upper_32_bits(ring->wptr));
-		}
+		WREG32_SOC15(GC, 0, regCP_RB0_WPTR,
+			     lower_32_bits(ring->wptr));
+		WREG32_SOC15(GC, 0, regCP_RB0_WPTR_HI,
+			     upper_32_bits(ring->wptr));
 	}
 }
 
@@ -5233,42 +5205,14 @@ static u64 gfx_v11_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 static void gfx_v11_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	uint32_t *wptr_saved;
-	uint32_t *is_queue_unmap;
-	uint64_t aggregated_db_index;
-	uint32_t mqd_size = adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size;
-	uint64_t wptr_tmp;
 
-	if (ring->is_mes_queue) {
-		wptr_saved = (uint32_t *)(ring->mqd_ptr + mqd_size);
-		is_queue_unmap = (uint32_t *)(ring->mqd_ptr + mqd_size +
-					      sizeof(uint32_t));
-		aggregated_db_index =
-			amdgpu_mes_get_aggregated_doorbell_index(adev,
-								 ring->hw_prio);
-
-		wptr_tmp = ring->wptr & ring->buf_mask;
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, wptr_tmp);
-		*wptr_saved = wptr_tmp;
-		/* assume doorbell always used by mes mapped queue */
-		if (*is_queue_unmap) {
-			WDOORBELL64(aggregated_db_index, wptr_tmp);
-			WDOORBELL64(ring->doorbell_index, wptr_tmp);
-		} else {
-			WDOORBELL64(ring->doorbell_index, wptr_tmp);
-
-			if (*is_queue_unmap)
-				WDOORBELL64(aggregated_db_index, wptr_tmp);
-		}
+	/* XXX check if swapping is necessary on BE */
+	if (ring->use_doorbell) {
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
+			     ring->wptr);
+		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
-		/* XXX check if swapping is necessary on BE */
-		if (ring->use_doorbell) {
-			atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-				     ring->wptr);
-			WDOORBELL64(ring->doorbell_index, ring->wptr);
-		} else {
-			BUG(); /* only DOORBELL method supported on gfx11 now */
-		}
+		BUG(); /* only DOORBELL method supported on gfx11 now */
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 31b26e6f0b30..4dfec56e1b7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -414,60 +414,6 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 			offsetof(union MESAPI_SET_HW_RESOURCES, api_status));
 }
 
-static void mes_v11_0_init_aggregated_doorbell(struct amdgpu_mes *mes)
-{
-	struct amdgpu_device *adev = mes->adev;
-	uint32_t data;
-
-	data = RREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL1);
-	data &= ~(CP_MES_DOORBELL_CONTROL1__DOORBELL_OFFSET_MASK |
-		  CP_MES_DOORBELL_CONTROL1__DOORBELL_EN_MASK |
-		  CP_MES_DOORBELL_CONTROL1__DOORBELL_HIT_MASK);
-	data |= mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_LOW] <<
-		CP_MES_DOORBELL_CONTROL1__DOORBELL_OFFSET__SHIFT;
-	data |= 1 << CP_MES_DOORBELL_CONTROL1__DOORBELL_EN__SHIFT;
-	WREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL1, data);
-
-	data = RREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL2);
-	data &= ~(CP_MES_DOORBELL_CONTROL2__DOORBELL_OFFSET_MASK |
-		  CP_MES_DOORBELL_CONTROL2__DOORBELL_EN_MASK |
-		  CP_MES_DOORBELL_CONTROL2__DOORBELL_HIT_MASK);
-	data |= mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_NORMAL] <<
-		CP_MES_DOORBELL_CONTROL2__DOORBELL_OFFSET__SHIFT;
-	data |= 1 << CP_MES_DOORBELL_CONTROL2__DOORBELL_EN__SHIFT;
-	WREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL2, data);
-
-	data = RREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL3);
-	data &= ~(CP_MES_DOORBELL_CONTROL3__DOORBELL_OFFSET_MASK |
-		  CP_MES_DOORBELL_CONTROL3__DOORBELL_EN_MASK |
-		  CP_MES_DOORBELL_CONTROL3__DOORBELL_HIT_MASK);
-	data |= mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_MEDIUM] <<
-		CP_MES_DOORBELL_CONTROL3__DOORBELL_OFFSET__SHIFT;
-	data |= 1 << CP_MES_DOORBELL_CONTROL3__DOORBELL_EN__SHIFT;
-	WREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL3, data);
-
-	data = RREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL4);
-	data &= ~(CP_MES_DOORBELL_CONTROL4__DOORBELL_OFFSET_MASK |
-		  CP_MES_DOORBELL_CONTROL4__DOORBELL_EN_MASK |
-		  CP_MES_DOORBELL_CONTROL4__DOORBELL_HIT_MASK);
-	data |= mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_HIGH] <<
-		CP_MES_DOORBELL_CONTROL4__DOORBELL_OFFSET__SHIFT;
-	data |= 1 << CP_MES_DOORBELL_CONTROL4__DOORBELL_EN__SHIFT;
-	WREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL4, data);
-
-	data = RREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL5);
-	data &= ~(CP_MES_DOORBELL_CONTROL5__DOORBELL_OFFSET_MASK |
-		  CP_MES_DOORBELL_CONTROL5__DOORBELL_EN_MASK |
-		  CP_MES_DOORBELL_CONTROL5__DOORBELL_HIT_MASK);
-	data |= mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_REALTIME] <<
-		CP_MES_DOORBELL_CONTROL5__DOORBELL_OFFSET__SHIFT;
-	data |= 1 << CP_MES_DOORBELL_CONTROL5__DOORBELL_EN__SHIFT;
-	WREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL5, data);
-
-	data = 1 << CP_HQD_GFX_CONTROL__DB_UPDATED_MSG_EN__SHIFT;
-	WREG32_SOC15(GC, 0, regCP_HQD_GFX_CONTROL, data);
-}
-
 static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.add_hw_queue = mes_v11_0_add_hw_queue,
 	.remove_hw_queue = mes_v11_0_remove_hw_queue,
@@ -1243,8 +1189,6 @@ static int mes_v11_0_hw_init(void *handle)
 	if (r)
 		goto failure;
 
-	mes_v11_0_init_aggregated_doorbell(&adev->mes);
-
 	r = mes_v11_0_query_sched_status(&adev->mes);
 	if (r) {
 		DRM_ERROR("MES is busy\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 1f8122fd1ad7..7e4d5188cbfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -156,68 +156,35 @@ static uint64_t sdma_v6_0_ring_get_wptr(struct amdgpu_ring *ring)
 static void sdma_v6_0_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	uint32_t *wptr_saved;
-	uint32_t *is_queue_unmap;
-	uint64_t aggregated_db_index;
-	uint32_t mqd_size = adev->mqds[AMDGPU_HW_IP_DMA].mqd_size;
-
-	DRM_DEBUG("Setting write pointer\n");
-
-	if (ring->is_mes_queue) {
-		wptr_saved = (uint32_t *)(ring->mqd_ptr + mqd_size);
-		is_queue_unmap = (uint32_t *)(ring->mqd_ptr + mqd_size +
-					      sizeof(uint32_t));
-		aggregated_db_index =
-			amdgpu_mes_get_aggregated_doorbell_index(adev,
-							 ring->hw_prio);
 
+	if (ring->use_doorbell) {
+		DRM_DEBUG("Using doorbell -- "
+			  "wptr_offs == 0x%08x "
+			  "lower_32_bits(ring->wptr) << 2 == 0x%08x "
+			  "upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
+			  ring->wptr_offs,
+			  lower_32_bits(ring->wptr << 2),
+			  upper_32_bits(ring->wptr << 2));
+		/* XXX check if swapping is necessary on BE */
 		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
 			     ring->wptr << 2);
-		*wptr_saved = ring->wptr << 2;
-		if (*is_queue_unmap) {
-			WDOORBELL64(aggregated_db_index, ring->wptr << 2);
-			DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
-					ring->doorbell_index, ring->wptr << 2);
-			WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
-		} else {
-			DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
-					ring->doorbell_index, ring->wptr << 2);
-			WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
-
-			if (*is_queue_unmap)
-				WDOORBELL64(aggregated_db_index,
-					    ring->wptr << 2);
-		}
+		DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
+			  ring->doorbell_index, ring->wptr << 2);
+		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
 	} else {
-		if (ring->use_doorbell) {
-			DRM_DEBUG("Using doorbell -- "
-				  "wptr_offs == 0x%08x "
-				  "lower_32_bits(ring->wptr) << 2 == 0x%08x "
-				  "upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
-				  ring->wptr_offs,
-				  lower_32_bits(ring->wptr << 2),
-				  upper_32_bits(ring->wptr << 2));
-			/* XXX check if swapping is necessary on BE */
-			atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-				     ring->wptr << 2);
-			DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
-				  ring->doorbell_index, ring->wptr << 2);
-			WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
-		} else {
-			DRM_DEBUG("Not using doorbell -- "
-				  "regSDMA%i_GFX_RB_WPTR == 0x%08x "
-				  "regSDMA%i_GFX_RB_WPTR_HI == 0x%08x\n",
-				  ring->me,
-				  lower_32_bits(ring->wptr << 2),
-				  ring->me,
-				  upper_32_bits(ring->wptr << 2));
-			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev,
-				        ring->me, regSDMA0_QUEUE0_RB_WPTR),
-					lower_32_bits(ring->wptr << 2));
-			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev,
-				        ring->me, regSDMA0_QUEUE0_RB_WPTR_HI),
-					upper_32_bits(ring->wptr << 2));
-		}
+		DRM_DEBUG("Not using doorbell -- "
+			  "regSDMA%i_GFX_RB_WPTR == 0x%08x "
+			  "regSDMA%i_GFX_RB_WPTR_HI == 0x%08x\n",
+			  ring->me,
+			  lower_32_bits(ring->wptr << 2),
+			  ring->me,
+			  upper_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev,
+							     ring->me, regSDMA0_QUEUE0_RB_WPTR),
+				lower_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev,
+							     ring->me, regSDMA0_QUEUE0_RB_WPTR_HI),
+				upper_32_bits(ring->wptr << 2));
 	}
 }
 
-- 
2.41.0

