Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D14DC44501
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 18:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD81D10EA77;
	Mon, 13 Jul 2026 18:27:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qCoxuPUE";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88A0010E64E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 18:27:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FP/rBN1kVgdAqAJoRxl819K0F8PqD2UtS1RtwTihjAM1KhXHYfbO+MlJMKJQFTWNB72eb7OUX2LH4zk8cxjMMTHDPGcW3wzrbPuYiEQSOj8kn+YQwkhFtJ19PxHy5VxTqB25uaXNPBhqYzqxUbqRg0vEiexzLuxu43PCoGl/qT0T8d0MKEFqeEhTrLmmLRZJPPQ/kMqINE+FWz353f+CdXfX3yO32JPukz8KLsGBw586k2qpvLuk3GJhOA1+pPe8Tc1IFvQlkAlis531Rlj0ewaIl67yx5N18X/D+9Xv0A6s/d5/+H6SnGTv2zAQirlk8ooUdtxfCE9otD/AFFLsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qfHOoN/nS62kaGXonzb7W5qZfio0DeDGPUNduOyaOI=;
 b=ocmeLsZFIpCEm5XbmUZc2DQlbFdSBvbS+n7qGTfsctGiqccPpIfGIN3LenSthseosNoV/Urf2GN7D1JP3UpHfIhb5nd4yooEEPLWyk8FpknLBi1xuxYgWuAPtk/mhEodK+zfkfsVDVze40xRRXMLBbz5rQmIP18mdgS/v98HPnx69DBfPW4JyJNOS1I2tbaSex6HfNOCjyk8BVizOwC3b/OkQyPG9JpeRP25So9HVNNsRvNwUt3bzy5TFxQK+ibdIlzJRC7qSstDlrrskSMVd1CaC9Y4UkmwBSYNU3/mIU7/wOxiAhpH5113LTFPxLtULjb5q79RLx/pAkH9BFh9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qfHOoN/nS62kaGXonzb7W5qZfio0DeDGPUNduOyaOI=;
 b=qCoxuPUETOOAyIsaguLH/ffgVr9lwf+BDMx8/3BtqAB0QgN4syV/H/huF1pCugooBJEgGAGGF/+HmiyKxGCQbpuQu5Sz39zkHWMnTYzYEyfk2xfWdSLzCUUqq4s0Lohkoa4blzuJwBEoVaczF1DS9dFI4w7tio1RF1U6BOOzubQ=
Received: from SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::12)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 18:27:46 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::84) by SJ0P220CA0005.outlook.office365.com
 (2603:10b6:a03:41b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 18:27:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 18:27:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 13:27:43 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 13:27:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/14] drm/amdgpu/gmc12: disallow gfxoff around TLB flushes
Date: Mon, 13 Jul 2026 14:27:22 -0400
Message-ID: <20260713182732.630947-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713182732.630947-1-alexander.deucher@amd.com>
References: <20260713182732.630947-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1852d6-17b2-46f2-23ad-08dee10c6ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iYUP6CwNnQUHGLVLoKTKCo5bQhJQ1LOUyciBxx4DP9roFsc69ReJWTRiI1MulLFRvfMh8nLH/h+dghcQLDxYpX2pnWJfrWPFSGXE9XpTv1I5dd2K98nMjryUQaaVD1H/6Zn0JaGNNLAzMzELyY7LEPjKLK1sTC6H13aywkVC6msmuZtWV1pfHtx5li9DtWzM1soWEOlbp+Y5Yv+r3Oum57l50IzUsEA/8i76I91xkF2Sz9oz5U9g2Q8qZMH27bHQFuXZ7r8sb6u7HTc3QTXEL+QBXcR48BZlgoiBLJiYd8fTUfxfU9LSkZ6kFgqHxH602vHbKhAGSAV0fr4WfQywknFvaaTthLpsgZaRTB3VMlZnRRmX2AJNZIvrU+uUlvYIwS7lnZi4dA7w1NqvmC1Z7Bh2qJ9Hijgm0N4ckEvE8Q7khkc8h3UQlNZFElDzxAqefKddOfSiDK3ywButFHXaKNDYWZk8swZGHTayONMNX8FdsooIfdXM3cGzL93MI975oM4AFX46eHsvqHwA053E7LIN+fRh8uMXf+iuuRjwTh6sK4C2g6Mq7in5AgtP/lZ+hmQ5QFbzA8whhb2wpGc0omlFL/7fDhIfmxdjOVwub47qxyxVz1SJafGHo5xxI1QVTtVkajTIFrIIX7jaxBGVQ+PNakihGJ8e+Gl9HsZRt8oz0t3Z4cIDRkapk2/o1Tl/iBWRkxsQ0kh1d20Ouj6yRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q6ef7Ljz711doKGRXSgIbP1qYGcijDy4+VLQ9WAaHufv6B59RUDTxLNU1mBedxS8/4qciaQgPwRUACalqT0HO9VSsugbgQfUhYCISRUNIyFEAJdaTbCiLHj7uIt4aMNJy+OHpEvIAfv9VRiNa+RZ67Z6EEZFh0QzezQ/r6/CgO4Besm91hfvoAc5ZDSuTPk+UT7EoNsKd+QFkKnJCU+HjgXg2pSYG3wNQQ8D+nLTBNhgyZ6ZW+gdhpwCGV+fgieuv22tM21ArTtv3Ekt4+OV/wicTulwIK3BuuDRZnYmk04Knnxn45GrenP1YFrEROmc5gRYz6FW0ECH9YN18cswS5dIkhbSoErcUGbhC7qS7ikqDtj9hevdMCPJj7sUrsBjZlDoPsBqN50shMoNCnc5NzusFMKINRXAvhb5N03yzla8t2Jc+7O/PBQJ/06xw8Gv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:27:44.5737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1852d6-17b2-46f2-23ad-08dee10c6ebf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624
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
index 84c93364d2201..dba83a90550da 100644
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

