Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F30C43219
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6111D10F6A1;
	Fri, 29 Apr 2022 17:47:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C019B10F232
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3jrFJMPypm6jZPHjr4ulZXJpzEhkTiBtLjOPg7L7HB81H4tuLDNMS+Fj0dTQh9G6YOJQM1qdUl0iXl5cFTu8Mc4dSsQN7OttnLr6YYNbcPLDuMXrC7IeTb4CHJOKg4xYQVGsULEKhW/8D3EHf2e1OPsV+24HMtnfnVIlyMh+oCISwcbivMEqOShh0qSxkKMIaXtf53jiMfL6aG1myuITYuUue4B+Oj9gkyIip+q5kFjRYnYcSvgeCZaTvLkfCX4I91MXgtIyLT/W2pgd5zSGjCOLkR5ObmFKyzggJsnM14p+JKq9EEx7nKjEjRqY6cNqiMlIcM1X0CsiGRxRB27OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoVVTCh/S6hQE/n7ru86ad2Bs9p7jh9AkWwcgUiQdjA=;
 b=b2UXYOE7ucf7WdEhgcupab1zjJNoEKJcRffuQF7QFS1JjbOQORgsO1WiCSRfaJkbWGui9+K7Qru9LoytkXTU71j9XmAm8Dphd5kJNpL/W+tl/VwqF+9AIzTru8TgLQzc5gaHBxV4SuoKP5mtSoHdkiuKE+bK//lUvG0/AoOp+YQv7lmsZcwkvO7UBJbBI4WfqX6msAleNrfLIhSHMhVif6+2XGVacitx5wDW3QYpVmNHyc59p7SY3wlnU2Rzb9RIiXO/Db9D80+GGIauVlZgkzOugJVfnrvmDJhDzFRutXaonK6zEXvN9l5/WeCxI+BlGU0dxbsmBqV3w7FTRZj+VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoVVTCh/S6hQE/n7ru86ad2Bs9p7jh9AkWwcgUiQdjA=;
 b=Vz32N902PwsP0MKEvwFyXlxMJxQJuJ5QyibckXrbSb2FBrSm7nRcuDnM9nVKURA6AhtX6ie2Sp25piPAHafkL+eaejlbAgQL2jdEoN0aOTI5aKBNCrtKHLx2Mo8FxAV6avDwBVzjUTKOxG/1Htd/aZyMCNowHVEGBw0k9NvnQ2k=
Received: from DS7PR06CA0015.namprd06.prod.outlook.com (2603:10b6:8:2a::26) by
 BN8PR12MB3554.namprd12.prod.outlook.com (2603:10b6:408:65::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Fri, 29 Apr 2022 17:46:58 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::5d) by DS7PR06CA0015.outlook.office365.com
 (2603:10b6:8:2a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 33/73] drm/amdgpu/sdma5: add mes support for sdma ring test
Date: Fri, 29 Apr 2022 13:45:44 -0400
Message-ID: <20220429174624.459475-34-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 42a3918e-2d17-465f-0912-08da2a084243
X-MS-TrafficTypeDiagnostic: BN8PR12MB3554:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB35545ECBBDB15A7EDE07A198F7FC9@BN8PR12MB3554.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t33z07ZVu9x31zrfzFbFUEM6FPxH27BUDT6IOLmMeVbv5S8CWUBCdS1zJ9q/P4kYe7huPxUB/sKNBj7yfAVrrZZDIXcMBcW04tPraFIUrO3s6Oal4zdw7VWLBQRiM9r/oLkqgU9yU6RoBE3wulfdFz1ZIFuQG26qhb+C9DgDZhObseBJEqMd99I1HbKLjBgoJPFpgldmaOL6JVwwRtcI6Ox+/vtI3PspYOsLKMyVZm4DIiBLIkqXhGrbMQpYPWIhYAnm1q/zCCW5UI1m/wUuJjRQC8n1GjAY/fTPAyVPTin2ZRM9QJpuSy44dtHQ8UrsVdV2MUh0XGerftM4kGplkpUpwNZYk3dUWSgEO9LjHFnBK5yaom7lz3b/02B30OnTDiMkHg58yd06C7khX/pXNIQSQxjjIE3Wzs5jrC6JzullHrFOoTTRQP88e/BSPh0nWmPhkuTp3dcNIzSw/kHe0PF+63Fivx/EeDTkYIUjq6EhIHlUFwC9/myADgQzz5kVZx6pVqExg28KxQVnUr0VPPQ+qJBk5elwz0e8pwoRnxPgj3cKvVgf8EZnMg+wxsjDWdRdnaGOZ7+Azue9B1Z1V1BnILogIkHW3B3qVymMNnwbK4b8Ensy914E/3ei7WcKxTmEVP9cHJduLUg04U1ZjdE2Nlpu5VmcendivCTGx8glUVNNcSK5X0BKS2w2qFf4CuRAHx4Hhd/Wq2TsIRncYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(36756003)(1076003)(82310400005)(2906002)(5660300002)(70586007)(316002)(6916009)(70206006)(508600001)(36860700001)(54906003)(356005)(26005)(86362001)(83380400001)(7696005)(6666004)(8936002)(4326008)(40460700003)(336012)(186003)(426003)(47076005)(16526019)(8676002)(2616005)(66574015)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:58.5203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a3918e-2d17-465f-0912-08da2a084243
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3554
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
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 37 ++++++++++++++++++--------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 564adc7b010c..1f0b19e18494 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1021,18 +1021,29 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
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
@@ -1048,7 +1059,10 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
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
@@ -1060,7 +1074,8 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
 	if (i >= adev->usec_timeout)
 		r = -ETIMEDOUT;
 
-	amdgpu_device_wb_free(adev, index);
+	if (!ring->is_mes_queue)
+		amdgpu_device_wb_free(adev, index);
 
 	return r;
 }
-- 
2.35.1

