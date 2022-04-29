Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119CAC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CB9810F6EB;
	Fri, 29 Apr 2022 17:47:19 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2074.outbound.protection.outlook.com [40.107.101.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A032A10F232
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3fXVaQgcQLgiv5C/8lpSTmTp92uJe7LBCzD/V7t3haNCG/jTxkMTV3AVbzJaH06V1RQY3OgRxdirEsEsjqPhNd9lDC5U9M+eCT6LHT+Egx8IxnZMV4GKcoAznPzO3ealozsICwTcxIn7v0kcSje5Pl17HJLaZLt2xHzv2DdWhydejM4lD0+bRUu0CdFqK2FKWwiO6Z/RTvLauAFzdUHlqzqVFUifh4WfKMBj2ysQtAbQoq9teJthVcCeYK97F83wI1mFm3estpz07DVd84FW6kukErmMvALL8Qe2K0QAOO+GWdRw0mU6UdZE+fR0mjsGABV2dAHK922S5TyYaddAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vslDob6n9aNDRjFvccKot6qmddEh4t9H1fPcyVKdtlo=;
 b=Vom5AGnQS9EWi+nk05qLbi4xHc1giN/5KLLQ5M27n/dnxBgZDhYktKMv8bFRbLB0EKOSLOQ8m7gkvYkPQ8LA90xcePZKWkff63ww3gZF6gJCHLLzDe+MRnqSycqt9m7kMqVjSudqD2Gg1WPDTWv4IQ6hC+9azc3/Uj6SvRfkooXiF3W1cMj6HqfphW50oA0S3nq5QE6+jjtQ+VcCmnfXpoEVI9nLdQ73HzKBo0KdwWqFDp/y3woxBctB+BuParcLr5MNzF11FrK0ZId/HTrRrwq0ObRrl9FrUN/iKMKPFIDefa0hUHvDTke5Eez1FU/g93bbMwp82veZQRJrRT8F3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vslDob6n9aNDRjFvccKot6qmddEh4t9H1fPcyVKdtlo=;
 b=hkTFpCjzpDjRQS1SLxBYrnumI+ZpZPJYNGavcQj/K96dgzff9hhMhYqOIvnr3IRTktS2WFI+VMbVsgvw0JnuikRp6ztzF2e3rrRRLTj8bJpjyA/bllSwt55gVaPHnMcK1pYtf7Sl3x1Jc2g/RuZjB9/o1v2nDyuFjxSqExdGg5s=
Received: from DS7PR06CA0012.namprd06.prod.outlook.com (2603:10b6:8:2a::22) by
 MN2PR12MB3039.namprd12.prod.outlook.com (2603:10b6:208:c9::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Fri, 29 Apr 2022 17:46:55 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::d3) by DS7PR06CA0012.outlook.office365.com
 (2603:10b6:8:2a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:55 +0000
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
Subject: [PATCH 29/73] drm/amdgpu/sdma5.2: add mes support for sdma ib test
Date: Fri, 29 Apr 2022 13:45:40 -0400
Message-ID: <20220429174624.459475-30-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: dbf37afb-0252-4dad-7e25-08da2a084023
X-MS-TrafficTypeDiagnostic: MN2PR12MB3039:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3039B23C9C4197A67D0F709BF7FC9@MN2PR12MB3039.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zyqZxkJHcMy4zbHfmie7XVJvJxVjrR78FWeJLIRpPcT0ae/UMPz8Hvoe5ayLevxGhWILYZQpYBemFqHAAxK3FlR5gmIHc5brwwxlsfeysvBBqnxn4dFwLlenYGELvG39Q4Pb+tnHUrI9/imQAkDbk4WnNJ3g8QF2NIxadJjKQEr+unPPTPyHvPWhZ4mqfa751/nR64e7AsTXgIcfTBcKZA7UBTdmwotQxmUBdjm7NwNtn+h7MNvEtG8T3c/30SWUG0j7HRGG68IfzqtJqCRMFA/BvR3VxHtpRTQT+Cjk1+wJhOHeEQ1NTOJLsYwlBoekk1TVjNdAHygl49FcVPQTYj9s7dQuVw2kxtmcTWyQgj2S36rWBQfh19pKgcUbY8x/v1Rv/pCuqJ5IpGpH5tBKShFBadb7MooIHsu2vv/Ry16frtQbIgdSNxsoXE8RTO6jK3zNS6KhteHOw+pBtqQWoiX6r+eLpQkGCQpRqTXnLf3hCZVXW6CfkFaBGyd1YuqtSyjt8hpxnI3T/Hqbt+6ikzp3gzqs7uYWqfkxoiSTR6nEf1aS14gCmbXFyLh2RHuYZvjIYOxfmUiij5mKJ9s3eGmgnPdY01H/iG/IG0TupElfHGl0NFf0xnQZMLvrAiEHngaxmjb8H4QwvU/TIK13mxHo1RXRE2hGGdf2dK83r/EuisyRtG8BFTXGRV/9Vxcg7Xpd0F2jGmtJFqpd4dligg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(86362001)(47076005)(82310400005)(508600001)(40460700003)(2616005)(336012)(426003)(26005)(1076003)(356005)(81166007)(6666004)(70206006)(36860700001)(2906002)(316002)(16526019)(186003)(7696005)(5660300002)(36756003)(8936002)(70586007)(54906003)(83380400001)(4326008)(6916009)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:54.9581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf37afb-0252-4dad-7e25-08da2a084023
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3039
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

Add MES support for sdma ib test.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 50 ++++++++++++++++++--------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 7c9c70382591..83c6ccaaa9e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1042,21 +1042,37 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	long r;
 	u32 tmp = 0;
 	u64 gpu_addr;
+	volatile uint32_t *cpu_ptr = NULL;
 
-	r = amdgpu_device_wb_get(adev, &index);
-	if (r) {
-		dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
-		return r;
-	}
-
-	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	tmp = 0xCAFEDEAD;
-	adev->wb.wb[index] = cpu_to_le32(tmp);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
-	if (r) {
-		DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
-		goto err0;
+
+	if (ring->is_mes_queue) {
+		uint32_t offset = 0;
+		offset = amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_IB_OFFS);
+		ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+		ib.ptr = (void *)amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+
+		offset = amdgpu_mes_ctx_get_offs(ring,
+					 AMDGPU_MES_CTX_PADDING_OFFS);
+		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		*cpu_ptr = tmp;
+	} else {
+		r = amdgpu_device_wb_get(adev, &index);
+		if (r) {
+			dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
+			return r;
+		}
+
+		gpu_addr = adev->wb.gpu_addr + (index * 4);
+		adev->wb.wb[index] = cpu_to_le32(tmp);
+
+		r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
+		if (r) {
+			DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
+			goto err0;
+		}
 	}
 
 	ib.ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
@@ -1083,7 +1099,12 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		DRM_ERROR("amdgpu: fence wait failed (%ld).\n", r);
 		goto err1;
 	}
-	tmp = le32_to_cpu(adev->wb.wb[index]);
+
+	if (ring->is_mes_queue)
+		tmp = le32_to_cpu(*cpu_ptr);
+	else
+		tmp = le32_to_cpu(adev->wb.wb[index]);
+
 	if (tmp == 0xDEADBEEF)
 		r = 0;
 	else
@@ -1093,7 +1114,8 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(adev, &ib, NULL);
 	dma_fence_put(f);
 err0:
-	amdgpu_device_wb_free(adev, index);
+	if (!ring->is_mes_queue)
+		amdgpu_device_wb_free(adev, index);
 	return r;
 }
 
-- 
2.35.1

