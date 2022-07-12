Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318EFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 02:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2F24913F1;
	Tue, 12 Jul 2022 02:55:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E98278E47C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 02:55:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBULEQMEU7zbYLca7qYLfuNwik8sGQI1rC4yKBf1ZXLuJk/TF1FcVImn6bBUnRWQLjbwMd+fJqEJ4lwZk3Hg1WzjeEXCa2NncCYgLxcvqJzn7NXdnssIKlmA6UY+gecq2xZ8aNYylBSzsGsgKUIHrYqMJ1yVEuGx4Lo1KAxMoWh9jOCpxDbKZESPgYHkzkaQ1IqHFLCAqZafYw2my+U+7ZtryLHTy8A+a2PltTuiDpQ8uJulb+VrblGj+ufglswuQyA6iyEQdFHbwJE3STVSSA5IywAAWUByyIB2zbnWrZAr8JH6O5Pez/llUjmGQAWayHhea/T0lsEfE9vOL9ZMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1UgjzDTSR33fOl1AYch5Ac1yFGE+5ZSgOCMrCFGIZE=;
 b=gl+Agucq3KwEB9mJZFQ+PejhdmQAFRo1liBHXTjEzpX9v8HSxv/6U3bE+JuWlKGZ4MS1mN/LlPhA/fbMYso8uvDiGDyCrkSaUxDX1h64a2CUR3iGuoyYoU2DWUyhAKhkNzEHYpo9RGuqREj/tSm5YVkzFR6MQ2qAhd5zdfihrHYhrTejMpEB4ml5ksqY3BaTK5hJLGKUzP85+MQPe4QK3gFkTFgygObrJ3Ywbh3fOTswgGp2WkY+A35n3PzsBTgAiROO4RwtgmGmxwfMm0LhBgF7hzNOVnKQPNQOrmOPGQaT7iFC1E4/CXxLj3CsMho4+JMpvGcueXkoY3ZHzuXmXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1UgjzDTSR33fOl1AYch5Ac1yFGE+5ZSgOCMrCFGIZE=;
 b=QV9ON7sFcQU+BODEoc/FQNVqCKXmjBfwuZHZCaRvIJPauRs9sN27POBAHE4f/ZtJyv5dK3xD+6o6uY7bmVk2d83B4beA2jG7VIkHeVAlXxHX6dsVwZreaEHf76ZVpNhSP5vPfuZRij/82KSzeIToHKloiKqkn12c+6kPeoIEiIo=
Received: from BN9PR03CA0782.namprd03.prod.outlook.com (2603:10b6:408:13f::7)
 by BN7PR12MB2770.namprd12.prod.outlook.com (2603:10b6:408:32::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Tue, 12 Jul
 2022 02:55:27 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::ed) by BN9PR03CA0782.outlook.office365.com
 (2603:10b6:408:13f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21 via Frontend
 Transport; Tue, 12 Jul 2022 02:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 02:55:27 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 11 Jul
 2022 21:55:25 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu/sdma6: add aggregated doorbell support
Date: Tue, 12 Jul 2022 10:55:01 +0800
Message-ID: <20220712025501.2083086-5-Jack.Xiao@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 300be905-cc36-4f26-2ccd-08da63b1f992
X-MS-TrafficTypeDiagnostic: BN7PR12MB2770:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZoFld2LUQl8jDvBoGIvkmGqO7wn1LWLD8XfeJp91s7Zeu4ePMbCNcBMwPcUx/CPLnyg8VrCXxxmQdIPcdwwAPp86zJ6Mo15gajeuiasqCniya6RqizNGI3hfjKHkLQHqVsme0g24x/7Yse2zj8H7XHIyxM/hWfApLh2kbbv3N4KDCLrkugHQX31bXCUUSpoSvftX7P1OF+frJyZyhZlnpDqTpY98nItb19lbNJ4UGn0YRb6bIHXnTS+axJMBXNvjPtzEbKLnEafq8anXGZRErEn9bqj4muQue4X5Gm5Twgx8NqkZhK8kFcOkcA2t478b8ZxSO89Zodbj2EHMqZHSxAkkEe8VfF83ABfvCWt/J53IYmMDH/bg47frqkI/7WJXUeT4tgB8SewQpXx/KAyRPEd3o8ptln77zOL/6cAoNvX/65taDRu65r6KaQvdXHPH7SJH/G2C0ZthlMIgb3yo4i8dpGbAAofemUDLsHUq01MgoTaJBUDoYfH1+8ePSgzBgRvssU4HnYR5vhI4reUN6VtBPxBRBA7drxUrOQefLPMpx5++H+i/msvtOUfQ4whABKlqWKiXpBx97hWnJIlPfjBQ0++EI094F2QCh5nf5esC43kNQCNcX2u/S4aZasw1qw1vem/EazQVNFxo9Kji/tr7hmvLmfmX/qPScRebmnfmZCjT3S0wtb+GAtsjv0QtYTq7MQLVmdrwS4Sv9YflC/3b/a+DBWaaDf6sjTjBZ/sDkQLcmszNQe6mOglTsw62VEEnUw9YeyDiDnnbJnYFIZegQsvhT4p3rJfmpTYhSbbcC816f5JVvt6EsTF1s60vEX6/ZqoNAWWk5I/24T9FtZ68q2fpsqr5y51BHRrBH0nehgCNj3Ux7iX4HSzFZDaf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966006)(36840700001)(40470700004)(16526019)(8936002)(186003)(336012)(1076003)(426003)(47076005)(356005)(36860700001)(8676002)(26005)(2616005)(2906002)(83380400001)(82740400003)(70206006)(41300700001)(86362001)(4326008)(82310400005)(478600001)(70586007)(6916009)(316002)(40460700003)(5660300002)(7696005)(36756003)(40480700001)(6666004)(81166007)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 02:55:27.3032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 300be905-cc36-4f26-2ccd-08da63b1f992
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2770
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

Port aggregated doorbell support to sdma6.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 80 ++++++++++++++++++--------
 1 file changed, 57 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 8cfaed55b192..59c8250e5fe7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -245,34 +245,68 @@ static uint64_t sdma_v6_0_ring_get_wptr(struct amdgpu_ring *ring)
 static void sdma_v6_0_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
+	uint32_t *wptr_saved;
+	uint32_t *is_queue_unmap;
+	uint64_t aggregated_db_index;
+	uint32_t mqd_size = adev->mqds[AMDGPU_HW_IP_DMA].mqd_size;
 
 	DRM_DEBUG("Setting write pointer\n");
-	if (ring->use_doorbell) {
-		DRM_DEBUG("Using doorbell -- "
-				"wptr_offs == 0x%08x "
-				"lower_32_bits(ring->wptr) << 2 == 0x%08x "
-				"upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
-				ring->wptr_offs,
-				lower_32_bits(ring->wptr << 2),
-				upper_32_bits(ring->wptr << 2));
-		/* XXX check if swapping is necessary on BE */
+
+	if (ring->is_mes_queue) {
+		wptr_saved = (uint32_t *)(ring->mqd_ptr + mqd_size);
+		is_queue_unmap = (uint32_t *)(ring->mqd_ptr + mqd_size +
+					      sizeof(uint32_t));
+		aggregated_db_index =
+			amdgpu_mes_get_aggregated_doorbell_index(adev,
+							 ring->hw_prio);
+
 		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
 			     ring->wptr << 2);
-		DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
-				ring->doorbell_index, ring->wptr << 2);
-		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
+		*wptr_saved = ring->wptr << 2;
+		if (*is_queue_unmap) {
+			WDOORBELL64(aggregated_db_index, ring->wptr << 2);
+			DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
+					ring->doorbell_index, ring->wptr << 2);
+			WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
+		} else {
+			DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
+					ring->doorbell_index, ring->wptr << 2);
+			WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
+
+			if (*is_queue_unmap)
+				WDOORBELL64(aggregated_db_index,
+					    ring->wptr << 2);
+		}
 	} else {
-		DRM_DEBUG("Not using doorbell -- "
-				"regSDMA%i_GFX_RB_WPTR == 0x%08x "
-				"regSDMA%i_GFX_RB_WPTR_HI == 0x%08x\n",
-				ring->me,
-				lower_32_bits(ring->wptr << 2),
-				ring->me,
-				upper_32_bits(ring->wptr << 2));
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, ring->me, regSDMA0_QUEUE0_RB_WPTR),
-			lower_32_bits(ring->wptr << 2));
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, ring->me, regSDMA0_QUEUE0_RB_WPTR_HI),
-			upper_32_bits(ring->wptr << 2));
+		if (ring->use_doorbell) {
+			DRM_DEBUG("Using doorbell -- "
+				  "wptr_offs == 0x%08x "
+				  "lower_32_bits(ring->wptr) << 2 == 0x%08x "
+				  "upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
+				  ring->wptr_offs,
+				  lower_32_bits(ring->wptr << 2),
+				  upper_32_bits(ring->wptr << 2));
+			/* XXX check if swapping is necessary on BE */
+			atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
+				     ring->wptr << 2);
+			DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
+				  ring->doorbell_index, ring->wptr << 2);
+			WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
+		} else {
+			DRM_DEBUG("Not using doorbell -- "
+				  "regSDMA%i_GFX_RB_WPTR == 0x%08x "
+				  "regSDMA%i_GFX_RB_WPTR_HI == 0x%08x\n",
+				  ring->me,
+				  lower_32_bits(ring->wptr << 2),
+				  ring->me,
+				  upper_32_bits(ring->wptr << 2));
+			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev,
+				        ring->me, regSDMA0_QUEUE0_RB_WPTR),
+					lower_32_bits(ring->wptr << 2));
+			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev,
+				        ring->me, regSDMA0_QUEUE0_RB_WPTR_HI),
+					upper_32_bits(ring->wptr << 2));
+		}
 	}
 }
 
-- 
2.35.1

