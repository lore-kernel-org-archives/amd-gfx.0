Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDD8C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 02:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50D1C91C13;
	Tue, 12 Jul 2022 02:55:31 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FDFE9079F
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 02:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aktHkMi/EydZXK3i+2NvtplMdf53jacUIAlx6LQClLDSVxVQqfA6FzCmOw+G7+cHCs/pPSHTOjJWCktRLbqoXbs5rh15EwXD3TAHsBuzO/Kecu4PXcepKXmAvz3RG0i0zWgKDW3T3s8FAEBvlToKHM3R6SvbP6y1gaXTI/BE076tEbVnpFhbgubCx2QFGd8aAAO/DqMu9FGrENCYJtQmW81R7n2ATnpg5Uqp/G3wm6jIMKEngSnm8+4hu5T6zutRJgLwu3yWCObgWWxQ8N6PWiLAp1Qo8hCIoz4vN3bXI5jxG/EPjB7j2ymEGmJ20hBXiwO+6x/kUtYQ1W9FUBCwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1KyeYi/DBzTtppbp0y80kaBv+AukIA+8TehYE7weig=;
 b=Yw6RckRP3Mw1LGw6cY8Auird+L27AkbqlHXJxGxrpGNqM5E36qK9kwmcd2fSSuOB2ZTk3FZrGv4Dx9fyW5tB1hDigZD9e4EClByzbDQP0THeOjlBUZNOV9FOydzGgNw7r/0gkE3t1Fejp8qatYmKrr/MwebhoUiCi/8MuR/PjrmX6Sb2RIz1q2r+uSQitxQahVziyZ14jC6hsDMqKyDfAlRFYAiBW3g5JoHY7niRCBE4+ow99uUHiam0NmXe2lBz3x9RM1kPXxuVKCZeuv4EN94Bo095p+v1Ir37RHmiFK+a8PZqYqP91NKW65w18gTBOPrf5ghF62cmv8INHPysOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1KyeYi/DBzTtppbp0y80kaBv+AukIA+8TehYE7weig=;
 b=0zJwTmkLQ+khItWw37yQC+TiAn5hQ3hpi84YHFKmoqurTfL8YR7xeIMaUYIykv+ZafdTxL68W/QeJUH35+qxV8Tha59zvAfWpq2fO9yrragb5myuMn2JbrZKMXhMmV2pXMIswpO21KfpiFYipyVw3TfGPk2VSxeMnSItxuGewg8=
Received: from BN9PR03CA0781.namprd03.prod.outlook.com (2603:10b6:408:13f::6)
 by MN2PR12MB3104.namprd12.prod.outlook.com (2603:10b6:208:cc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Tue, 12 Jul
 2022 02:55:26 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::dc) by BN9PR03CA0781.outlook.office365.com
 (2603:10b6:408:13f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Tue, 12 Jul 2022 02:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 02:55:25 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 11 Jul
 2022 21:55:24 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdgpu/gfx11: add aggregated doorbell support
Date: Tue, 12 Jul 2022 10:55:00 +0800
Message-ID: <20220712025501.2083086-4-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712025501.2083086-1-Jack.Xiao@amd.com>
References: <20220712025501.2083086-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3197a5fe-f175-487c-c557-08da63b1f8c2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3104:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HIeU8Vfy4r1AzH4E8B1GlktonG+mxa9qc0TUrZezPLfbxbAWXD4ztzrAs0KOrf0jlDOStRiI/KkrAMk+mWoXA5Menf6nnMfXc6lxy4a/IQ550pK1k1cSKhDVruJTtfOgAsFAjMCGtsU9RZr0VJ+7mK2ra13ZAsRA3Uxu7q/O2O0QtpPI1waEadmXHDAdYFbz5YokPpx6bwg4l1Wg0ezLGQjli5leOyps3vsZtFgjYB6zP4melqfodHBupgwk8K/cyVj5FVVr+EeV5LloYeyo7Wdc2B6EozAjKplgoGrNT4A97ed9bAkfvD4gaJPJzMerPKeDNS8+A7TcfR8vKOEKe7Rh31579A3F35cVy7rVolR89aw/Ojsd5KzYHrT4tTYMtZuk3pIUOUOZCKVMknVmr7Ob6Jbwy05+EqtWLFu8fkFg0ErFxjhLWX4LxBnM6Xz9fsDju3Mx8ftPZaOLQ6boDorfSYUxlubZxR4F6CYQTZMwCfjY/qvW77C6jp/PSiUUfOm8f4VNan+at3818I02zj/jqHVkxLdYIBJ7btFuCyRYrOBNutc+btiQM1435kxtocJG5q7XxSJbvOMYdrxxComDLFeAn9v7gScBjuyHhySSnJlSVkWWovEMjWx8BqK3b6MSbQSrVLxbJc1Ca2gEYAuKIDWTg0vtO4+bp3K6XbUH5urU0yqxcERlGJms5vZZr7/WVmbqHfuE611tOO1oRuNVl6RcKaF0XRMI9LceNEWJ/OuSkUn7byGlsQ9RxVywepyN4rHcFZdJj3rDnxVrF8Z8IsAyBOzS7wplApXkgRDRKeM4Ve/sSI/2aUmELYrjwkxKFeXRniOOjylFP22XuSIgl3yhpRia8zxQy3IXIkch+Giy7MLE0/vklreMVd4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(36840700001)(40470700004)(46966006)(4326008)(8936002)(6916009)(8676002)(5660300002)(70586007)(6666004)(316002)(86362001)(1076003)(7696005)(81166007)(70206006)(41300700001)(2616005)(26005)(82740400003)(478600001)(16526019)(2906002)(336012)(426003)(40460700003)(47076005)(83380400001)(36756003)(356005)(36860700001)(82310400005)(40480700001)(186003)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 02:55:25.9596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3197a5fe-f175-487c-c557-08da63b1f8c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3104
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Port aggregated doorbell support to gfx11.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 82 ++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 942d41a65f2f..0a90b61cc126 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5297,14 +5297,45 @@ static u64 gfx_v11_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
 static void gfx_v11_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
+	uint32_t *wptr_saved;
+	uint32_t *is_queue_unmap;
+	uint64_t aggregated_db_index;
+	uint32_t mqd_size = adev->mqds[AMDGPU_HW_IP_GFX].mqd_size;
+	uint64_t wptr_tmp;
 
-	if (ring->use_doorbell) {
-		/* XXX check if swapping is necessary on BE */
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
-		WDOORBELL64(ring->doorbell_index, ring->wptr);
+	if (ring->is_mes_queue) {
+		wptr_saved = (uint32_t *)(ring->mqd_ptr + mqd_size);
+		is_queue_unmap = (uint32_t *)(ring->mqd_ptr + mqd_size +
+					      sizeof(uint32_t));
+		aggregated_db_index =
+			amdgpu_mes_get_aggregated_doorbell_index(adev,
+								 ring->hw_prio);
+
+		wptr_tmp = ring->wptr & ring->buf_mask;
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, wptr_tmp);
+		*wptr_saved = wptr_tmp;
+		/* assume doorbell always being used by mes mapped queue */
+		if (*is_queue_unmap) {
+			WDOORBELL64(aggregated_db_index, wptr_tmp);
+			WDOORBELL64(ring->doorbell_index, wptr_tmp);
+		} else {
+			WDOORBELL64(ring->doorbell_index, wptr_tmp);
+
+			if (*is_queue_unmap)
+				WDOORBELL64(aggregated_db_index, wptr_tmp);
+		}
 	} else {
-		WREG32_SOC15(GC, 0, regCP_RB0_WPTR, lower_32_bits(ring->wptr));
-		WREG32_SOC15(GC, 0, regCP_RB0_WPTR_HI, upper_32_bits(ring->wptr));
+		if (ring->use_doorbell) {
+			/* XXX check if swapping is necessary on BE */
+			atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
+				     ring->wptr);
+			WDOORBELL64(ring->doorbell_index, ring->wptr);
+		} else {
+			WREG32_SOC15(GC, 0, regCP_RB0_WPTR,
+				     lower_32_bits(ring->wptr));
+			WREG32_SOC15(GC, 0, regCP_RB0_WPTR_HI,
+				     upper_32_bits(ring->wptr));
+		}
 	}
 }
 
@@ -5329,13 +5360,42 @@ static u64 gfx_v11_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 static void gfx_v11_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
+	uint32_t *wptr_saved;
+	uint32_t *is_queue_unmap;
+	uint64_t aggregated_db_index;
+	uint32_t mqd_size = adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size;
+	uint64_t wptr_tmp;
 
-	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell) {
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
-		WDOORBELL64(ring->doorbell_index, ring->wptr);
+	if (ring->is_mes_queue) {
+		wptr_saved = (uint32_t *)(ring->mqd_ptr + mqd_size);
+		is_queue_unmap = (uint32_t *)(ring->mqd_ptr + mqd_size +
+					      sizeof(uint32_t));
+		aggregated_db_index =
+			amdgpu_mes_get_aggregated_doorbell_index(adev,
+								 ring->hw_prio);
+
+		wptr_tmp = ring->wptr & ring->buf_mask;
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, wptr_tmp);
+		*wptr_saved = wptr_tmp;
+		/* assume doorbell always used by mes mapped queue */
+		if (*is_queue_unmap) {
+			WDOORBELL64(aggregated_db_index, wptr_tmp);
+			WDOORBELL64(ring->doorbell_index, wptr_tmp);
+		} else {
+			WDOORBELL64(ring->doorbell_index, wptr_tmp);
+
+			if (*is_queue_unmap)
+				WDOORBELL64(aggregated_db_index, wptr_tmp);
+		}
 	} else {
-		BUG(); /* only DOORBELL method supported on gfx11 now */
+		/* XXX check if swapping is necessary on BE */
+		if (ring->use_doorbell) {
+			atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
+				     ring->wptr);
+			WDOORBELL64(ring->doorbell_index, ring->wptr);
+		} else {
+			BUG(); /* only DOORBELL method supported on gfx11 now */
+		}
 	}
 }
 
-- 
2.35.1

