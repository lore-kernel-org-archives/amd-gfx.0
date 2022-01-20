Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC073C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 11:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F6F10E631;
	Thu, 20 Jan 2022 11:19:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BBC910E637
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 11:19:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTZf8E1YmFZXMGYQbbHB+Q9I84y2PxRMPaanISXyk+3T72L2xM2BP6A10tuQjbb+tFfdYa9bhZN9cWGkLa+dzwMiaBR64ZKRWuVbdoYHWBpPPxBRUSPQaTrI9wEMbtucJNwNd67pxhmJVwmJ74red976rY22/Acu2I+YejyPVY7gzflJW83ptDedEUYMgvZ2geRTwWJn3zvr+flr65CHBqhw3O6bwF908EcXhb3e8j+2hFZMxhBbHM+A+1qtcqRO53mMq172B3qivTpYPlaFGbu4RsYX6Mw/f5F3rIA0iKosi8Rrj5UlaVmIFEyvqs0VY2NQZoaBE/eVsbhPIJPAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxTfC+pT5nYB/ewBkDKo5JNlAhJJHs+ya9aHezwHcos=;
 b=X+EHJv9Fo7gKEI3I85aGHjE5BxbLqra+5MJfUhe2cg9fhLQ9qozGJ07Ck3jOuRu4Dy6BpTrkbi+/1shu6JJdt1qhhd0X0upUHYTFGimLa8RwIztTXy+G8NGwKpbD296hQgNi9/rn0xQcVDjwt7lutVEqXD6fV96BA327Yxc/z7rBx9sVN9og1tDsUgG/IUNVfAbeWzOzO8MVOl420x04y/nidapSi5vDNvbVorKzh9MddJo0Vkkd35nXgYq0STfvS9xnob5H9j1rEU7cxCPRCEJQ1M6cefb3IV5eVZ2P7xKWeDg0jAM7+f+jbqZWDdVUvWJFOyhAcLzVTl4fWCcnpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxTfC+pT5nYB/ewBkDKo5JNlAhJJHs+ya9aHezwHcos=;
 b=LRGKxdZ+yVbemvMxs411GVGw3wBs0hKeBLNoVXsBPebTx7XRD2PokSj8rkeyijBHtAQhDOM2h+CER1U2l7sLhdJ3Fqx76/QjPSVW/Ihux2SfkBzWw9cFzjSe9qzplfjFT7dMio0E7j0d+VI2Mp8tOBwn6epRDEOuYIZFmFVO+0I=
Received: from MWHPR01CA0033.prod.exchangelabs.com (2603:10b6:300:101::19) by
 CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.9; Thu, 20 Jan 2022 11:19:16 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::c2) by MWHPR01CA0033.outlook.office365.com
 (2603:10b6:300:101::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Thu, 20 Jan 2022 11:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 11:19:15 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 05:19:14 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 03:19:14 -0800
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.18 via Frontend Transport; Thu, 20 Jan 2022 05:19:13
 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 8/9] drm/amdgpu: switch to amdgpu_sriov_rreg/wreg
Date: Thu, 20 Jan 2022 19:18:52 +0800
Message-ID: <20220120111853.11674-8-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220120111853.11674-1-Hawking.Zhang@amd.com>
References: <20220120111853.11674-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8bc4930-0ae3-489e-3dda-08d9dc06b18f
X-MS-TrafficTypeDiagnostic: CH0PR12MB5266:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB526657A7E3355EBB27E4C644FC5A9@CH0PR12MB5266.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7HYjv+y+Nqp27TlTt5248WqFYwMc//b5pLZtjog6XW+XYSe+sAVKOG+1CuKtD14lS6Q3OdKttXGeWduk+2IlOwiH35B+gyxwHiXAH8DWk+J0WBxAYu3ckfqwvV881Mwqsav07/02GW+wYfTHOp1Qkjjqk8W5TSMbKTnRR8+ThKndlQYFlrVOSXhM7HUr7utnqFu92mW8j3MNRsl56cotVtH2+BM1S4+BG8AXCsxLQkFGPS9N2/yPEqbqOCTXg7sGL0AUCk8mQ8E9xZUJcIL8jjhf1QCZ3YWNsQRPW7a3TRWBRz/RzOTK9d1A7XxisGMAhNxzF/O++ZptQZPEpk5HrHdEqT1hprDeUm8xlti63944FnFe2do/Xxom1AA+kebmTXuSJlg8QoPdnT5g7KSpI6IGWlr11pP9Ab+aH1DP5cDDeT/GKrOOnK9Q9pFPzDGhXIaHGGcea/Uht7rVNk8r68XuSC0tWI8dwHk+n77Q+hXW+WY3gQzfc/4A46Eo1T2VRZGA0CO9qnm75Lzks2/Lhxld9ZgeRaQuwFdwJ4fVS6vvFPjMY2jcMUUlb/f0S7IiJkX/ISrPB8truiGs/Q4QPlBwwK1B+DnQVOXxEK7R5d9SLmkcVE485iBKAtp9GVCK/USObyrGJAnJI8Ouc4t7mziVE2ldeQmJn6zF4UhHjKqZ9Hhfrek/vp/cy01O8iaHeVtiHk7egNBWfk4uZllQ/G+vDE8ryJb/xFdllYa52Vj6GXeNYyMRkUoyC1ZheOSwbxW6NvAXssKMZaNoMvAvUz2FDvu/IeFzrCaInnfUXms=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(426003)(6636002)(356005)(5660300002)(110136005)(36756003)(7696005)(36860700001)(40460700001)(47076005)(2616005)(86362001)(8936002)(8676002)(66574015)(70206006)(4326008)(70586007)(6666004)(81166007)(508600001)(82310400004)(1076003)(336012)(186003)(316002)(83380400001)(26005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 11:19:15.4786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bc4930-0ae3-489e-3dda-08d9dc06b18f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5266
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of ip specific implementation for rlcg
indirect register access

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Zhou, Peng Ju <PengJu.Zhou@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/soc15_common.h  | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2baafef9c786..4867d2231a3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -566,7 +566,7 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 	    adev->gfx.rlc.funcs &&
 	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
 		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
-			return adev->gfx.rlc.funcs->sriov_wreg(adev, reg, v, 0, 0);
+			return amdgpu_sriov_wreg(adev, reg, v, 0, 0);
 	} else if ((reg * 4) >= adev->rmmio_size) {
 		adev->pcie_wreg(adev, reg * 4, v);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 473767e03676..acce8c2e0328 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -28,13 +28,13 @@
 #define SOC15_REG_OFFSET(ip, inst, reg)	(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
 
 #define __WREG32_SOC15_RLC__(reg, value, flag, hwip) \
-	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.funcs->sriov_wreg) ? \
-	 adev->gfx.rlc.funcs->sriov_wreg(adev, reg, value, flag, hwip) : \
+	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.rlcg_reg_access_supported) ? \
+	 amdgpu_sriov_wreg(adev, reg, value, flag, hwip) : \
 	 WREG32(reg, value))
 
 #define __RREG32_SOC15_RLC__(reg, flag, hwip) \
-	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.funcs->sriov_rreg) ? \
-	 adev->gfx.rlc.funcs->sriov_rreg(adev, reg, flag, hwip) : \
+	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.rlcg_reg_access_supported) ? \
+	 amdgpu_sriov_rreg(adev, reg, flag, hwip) : \
 	 RREG32(reg))
 
 #define WREG32_FIELD15(ip, idx, reg, field, val)	\
-- 
2.17.1

