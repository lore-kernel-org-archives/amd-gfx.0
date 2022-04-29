Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B78BC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F4D510F26A;
	Fri, 29 Apr 2022 17:47:02 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2084.outbound.protection.outlook.com [40.107.101.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DA6610F240
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A17hnQux0FFk+fVaLXkaziRUFxc3PmMJWI6aOSvuXMNi77/DyQlID1+EMq1GIP05U9DpMWsNACX79eS3oKq7JoiSLiDxBIJyqximskAanUUxv89Z9Sqi7tIAq/8AEHwTs6PNIdIk+ByJVkBBU51d8tgesI0oUqIoIhahEAxPSvdF8IkoDe1jEmyLiCdMlQjI4T+rchHvyk5Gwx/3ZqyD9AmRRa37994S21iIW0KweREDRy3GyAN/nnw28e1mu7wo+XeHOuQNUTe8mm9EciwdDVjOTw6qCSINI8NLfmr/trdaqM8jWLPieSoiOeT6NWKpQ7xYSICGnnEL0L3j8YUg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hY0Uf/sIPeqDXFfKewkQuzTQEboszLsiAQeZ9JECHAQ=;
 b=E9zz8LqZ4cCKq+KJlPu3KOwcWhRc3Fk3/RSZUc70nYecuXtXeVeCOEcCozhWmxOdIGQ0y2VoMkXlkj+Pu38JqDcLpqH32a/Wcb2xZlsdF4UDcv6zRURkzCcO2HBmrzXvmmCdqAxk7WagIkV7qTQJ2ji1P/pfI4RM1ezU61Eum248J/PgLY09ViS9500oqK91bd1susMAGngLeY50Co+kldF13bryVLr+2apCY/xzzeLEZ+Uy9SPwTopSbcKWll3Vdawj0sjM7Bf/DcVB3iuSk+nzS7Fe0oX6Vx4m2twH3lIc30Xo1t+o1nrVmp4EI88WTXmz+DgZWgBJuaX1L1RfOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY0Uf/sIPeqDXFfKewkQuzTQEboszLsiAQeZ9JECHAQ=;
 b=wlnSZxTtPJrs/gFVz61twZIPZ4Fxgj41MtnANS3yeC9IhYkgC24NG2CGWkk4PQ+VuFh4DdsmA8GFT1e+iwBQ5MBumXvcypIvllUuPtxzRt+ZuuNLzmnziqKiyKdHvsNinnx+ra8Igz4KzYGn6xTasYxqRjwPiGb3XluJ5Y4n0Yk=
Received: from DS7PR06CA0004.namprd06.prod.outlook.com (2603:10b6:8:2a::19) by
 CY4PR12MB1941.namprd12.prod.outlook.com (2603:10b6:903:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 17:46:54 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::92) by DS7PR06CA0004.outlook.office365.com
 (2603:10b6:8:2a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/73] drm/amdgpu/sdma5.2: add mes support for sdma ring test
Date: Fri, 29 Apr 2022 13:45:39 -0400
Message-ID: <20220429174624.459475-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc831ec1-aa18-4f36-bde1-08da2a083fe0
X-MS-TrafficTypeDiagnostic: CY4PR12MB1941:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1941A4C23EC3228570923DC0F7FC9@CY4PR12MB1941.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1u/5CGrv3ry7kPPCDPUWP7j1gnb/Fq7wwI0B8tusL6DoTc3QU/FtGFjpOEO+4ejeU1i1xuq8MVBtnJ+GulhdZr+u07cB+CXS/RdTxDbUw4DToMlctbqsD4qa4m9DfHJZxbe8xYkq4sa0W5ECZPNR7jmP1AcsiuwwobdmggJ4ftAutHQ3iS2a+2AAvcxVbEroqYXYfJMzTuhFeL8tTePtbTqxquenhGwdPw/68rWs1QZZu2EUsnZ4NNxB8OZ7P7PMWYQ1k8UE2qWwnQ7Myqe/pDtRHT5kW+tSoxFUGLvTRDJvQ/WffsUs4nAuXAcJTF7KnSZUdcjIFeFZH2+OhVQWCTSoqR+y4ff3JxTgmZYrpddXZsMN9gyiIufePLL5VKtRXAMH59vuZeIGZvzsXAFazrFExKB6UpXijDWMLc+2hVcUwxBfVGk77AkVeHzCorgWpe57ju0P5E7OQop6CE5iQndhwdM9WvlzN1OHC0Bgk0dfJ9LMX+JHUwAmcnzm16xUGIKcQmQdQUlv20YqviotlIFXH5ZIWCWyhzRF5IwwbAc4PJBF//D1gN4wj1cDG8TyGl3FWtdHxj+uSQBStRvDK9YJ2vxbYTXFUZQ5/iD20GwgTg+/x9StOXV0gNH/8AHX+2Je2f6HahdjP+9T4F9QojFLmhHQa539l6aWb+aX1dhCq8oMXWcac4/NMvyc2nevmaGYwt99XWP8FYrHuyCnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(54906003)(82310400005)(7696005)(70586007)(70206006)(26005)(6666004)(2616005)(316002)(6916009)(86362001)(508600001)(81166007)(36860700001)(1076003)(47076005)(336012)(83380400001)(426003)(356005)(40460700003)(16526019)(186003)(66574015)(2906002)(36756003)(8936002)(4326008)(5660300002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:54.5207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc831ec1-aa18-4f36-bde1-08da2a083fe0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1941
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Add MES support for sdma ring test.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 37 ++++++++++++++++++--------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 9f246ab942f9..7c9c70382591 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -965,18 +965,29 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
 	int r;
 	u32 tmp;
 	u64 gpu_addr;
+	volatile uint32_t *cpu_ptr = NULL;
 
-	r = amdgpu_device_wb_get(adev, &index);
-	if (r) {
-		dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r);
-		return r;
-	}
-
-	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	tmp = 0xCAFEDEAD;
-	adev->wb.wb[index] = cpu_to_le32(tmp);
 
-	r = amdgpu_ring_alloc(ring, 5);
+	if (ring->is_mes_queue) {
+		uint32_t offset = 0;
+		offset = amdgpu_mes_ctx_get_offs(ring,
+					 AMDGPU_MES_CTX_PADDING_OFFS);
+		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		*cpu_ptr = tmp;
+	} else {
+		r = amdgpu_device_wb_get(adev, &index);
+		if (r) {
+			dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r);
+			return r;
+		}
+
+		gpu_addr = adev->wb.gpu_addr + (index * 4);
+		adev->wb.wb[index] = cpu_to_le32(tmp);
+	}
+
+	r = amdgpu_ring_alloc(ring, 20);
 	if (r) {
 		DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
 		amdgpu_device_wb_free(adev, index);
@@ -992,7 +1003,10 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
 	amdgpu_ring_commit(ring);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		tmp = le32_to_cpu(adev->wb.wb[index]);
+		if (ring->is_mes_queue)
+			tmp = le32_to_cpu(*cpu_ptr);
+		else
+			tmp = le32_to_cpu(adev->wb.wb[index]);
 		if (tmp == 0xDEADBEEF)
 			break;
 		if (amdgpu_emu_mode == 1)
@@ -1004,7 +1018,8 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
 	if (i >= adev->usec_timeout)
 		r = -ETIMEDOUT;
 
-	amdgpu_device_wb_free(adev, index);
+	if (!ring->is_mes_queue)
+		amdgpu_device_wb_free(adev, index);
 
 	return r;
 }
-- 
2.35.1

