Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51556C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 13:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC9016137C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 13:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC9016137C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 470B66E167;
	Tue, 19 Oct 2021 13:22:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 118CA6E167
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 13:22:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUHvIwCR1D7Oasj5HzvN30DWMQn+fyZsutpv7ubfmW0AqQNxNXs0RgupPmQMyQhEROkamr16L8kwbgZEQk1OPZWaWabHj7YtnJE3aLLYp9t163makIwwDH7xidcpm/l7r6kjNvxFx0YWC14ECwkr/1p60fYL0MZ8lwKe8/QZDAiu2a46dErmLmpCsUwnNQL39m30F8jqCnxsmi0XAtAkSGI9P8n9FQcjvr1PHofEfkE0vTCk+UkcPwNUVi+eZzwjpwaFd3wFY12MwWvi5NlTpIyP88dIwjIp6UdNpAck+cybiWqRu9ct1sjyPW0dIwCeEDDONc/9gznuwItiON6xsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naipwFb/5mS45svgL+f/vbpennuPxqH3KXmy2hRZfw8=;
 b=XxAynucDXGuCxVFUZk0shv/3Gmu6NZaDl8KHQ8p7JN4T4rrEWe5GGNd8rVw1VyV+XPlU7qj7JVfB0bAFB1Ne4PNLIpbUpRap4/pFTHsF6n8fF1J09H9XRrWl9CkxiNOV/vXuqW0keYiV4sKHa9WkjHkCZwuBq/8VDtwRVXt1X+mSwE4xBGZvgNzJgeM1cPZxgeGA6k+z0/NP2ghy+Eo93lY15ipLvZUqPzGP7HJq8u9bBpf401lnWmgzCxG5BlCKO6phOl7ErbDeZhyNFPBJnz7UDw2vggN7yyFO/bAP/oe7zYOy7er4sflSErDYgwHoMCGThHKSbnPxilXeaFZaGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naipwFb/5mS45svgL+f/vbpennuPxqH3KXmy2hRZfw8=;
 b=yQMAEEHtloaYtUlSq197e6Pyb9IzgLCkOUjGoA8O9Yd3ZIG+EiytR92cRsPiUF3v2KlljxjQKbEYFwkI2pvk7+oR/P5YJcOoVkPqAy58d2uvODC23C0cKYjyyFgXhBxPjXIMOiHu+4eitvmntF9l+5ZPu2nS2xep+4E2K2omTqw=
Received: from BN9PR03CA0920.namprd03.prod.outlook.com (2603:10b6:408:107::25)
 by DM5PR12MB1819.namprd12.prod.outlook.com (2603:10b6:3:113::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 13:22:12 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::23) by BN9PR03CA0920.outlook.office365.com
 (2603:10b6:408:107::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend
 Transport; Tue, 19 Oct 2021 13:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 13:22:12 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 08:22:11 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: recover gart table at resume
Date: Tue, 19 Oct 2021 15:22:00 +0200
Message-ID: <20211019132200.10352-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64e6eab8-3f19-4516-b730-08d993037601
X-MS-TrafficTypeDiagnostic: DM5PR12MB1819:
X-Microsoft-Antispam-PRVS: <DM5PR12MB18197CF71392BDD3C7DB0AAC8BBD9@DM5PR12MB1819.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gIaELwqAzg+9QhEVU77TiyW7cDwFdnDucDbey8Spf0qZELjiqefnxY8nj42J9FH3qQgeikGX40aasq9c47WmKZjdAPkUw+I2cZtZPya7YQOEz8ZtZF3iTtIFyAsbsq7C7EA3zzHga6GJirb2/BVLHjgd5DwfMOoPayc39g5usdOCyGQ7dcc/59MF8g7wAdsaoq+RgGD5nOPtmad8EtqrjTClbCKNIMDPUYY68JWN2Af8RAj5dbi9pHB3Y9XR20Rykbf4t14HQ7pgt+mfW3mmTioKlq+BBP4pgXQFHPhI7nXbg/rYsBB1Nmv8oz3UOlesM1ADlxIkM6awkdBmfE5DgdPQgxoWu4HGp90WwWLeBa3eh+OIBdlKiCalNO/Lh8okV/GGYVpn9S7TJ7NLY82ilWguA0oHr0HzAqjGTk7R0yD6qQ6GnxBGW5fQd97Twj6UX/rQu4SUd63w6ScAW/QZqbGLJcNm4KMwRi+FfyHKdMbns3c+pT6XHU91d9hnzFJ8+3dJAIBhWNEwVPYTSoOrfvuLYwtywrV9ktFAGcxYbiTX9/zg6J7oRI38PBbSlPgAYodVLrLM2hdpfaolk0TD28GWGP55HYy1TbVGdA5wSlBw7915/LdEZ/fp/rkXBvMO8Jngkjy/rJcXlXmu9/SnPT8jVHixC/PxbwSTtZKytJkKLUqOSv7E/tchpVnxbsynctJgO3l7JdCeiORLZFQnrxXFIQQTautXU+3Lk7xg2HyAOJgVVjjaDyFpjovIDFfMy0uKPSCZJnVEaDLTNNkGhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(83380400001)(4326008)(54906003)(5660300002)(36860700001)(316002)(16526019)(26005)(82310400003)(1076003)(47076005)(36756003)(356005)(81166007)(86362001)(2616005)(336012)(2906002)(426003)(6916009)(8676002)(44832011)(508600001)(8936002)(186003)(7696005)(70586007)(6666004)(70206006)(36900700001)(358055004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 13:22:12.3214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e6eab8-3f19-4516-b730-08d993037601
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1819
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

Get rid off pin/unpin and evict and swap back gart
page table which should make things less likely to break.

Also remove 2nd call to amdgpu_device_evict_resources()
as we don't need it.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 -----
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 16 ++++++++++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 17 +++++++++++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 16 ++++++++++++----
 4 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 41ce86244144..22ff229ab981 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3941,11 +3941,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	amdgpu_fence_driver_hw_fini(adev);
 
 	amdgpu_device_ip_suspend_phase2(adev);
-	/* This second call to evict device resources is to evict
-	 * the gart page table using the CPU.
-	 */
-	amdgpu_device_evict_resources(adev);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 3ec5ff5a6dbe..18e3f3c5aae6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -992,9 +992,16 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	r = amdgpu_gart_table_vram_pin(adev);
-	if (r)
-		return r;
+	if (!adev->in_suspend) {
+		r = amdgpu_gart_table_vram_pin(adev);
+		if (r)
+			return r;
+	} else {
+		r = amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev,
+							    TTM_PL_TT));
+		if (r)
+			return r;
+	}
 
 	r = adev->gfxhub.funcs->gart_enable(adev);
 	if (r)
@@ -1062,7 +1069,8 @@ static void gmc_v10_0_gart_disable(struct amdgpu_device *adev)
 {
 	adev->gfxhub.funcs->gart_disable(adev);
 	adev->mmhub.funcs->gart_disable(adev);
-	amdgpu_gart_table_vram_unpin(adev);
+	if (!adev->in_suspend)
+		amdgpu_gart_table_vram_unpin(adev);
 }
 
 static int gmc_v10_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 492ebed2915b..0ef50ad3d7d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -837,9 +837,17 @@ static int gmc_v8_0_gart_enable(struct amdgpu_device *adev)
 		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
 		return -EINVAL;
 	}
-	r = amdgpu_gart_table_vram_pin(adev);
-	if (r)
-		return r;
+
+	if (!adev->in_suspend) {
+		r = amdgpu_gart_table_vram_pin(adev);
+		if (r)
+			return r;
+	} else {
+		r = amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev,
+							    TTM_PL_TT));
+		if (r)
+			return r;
+	}
 
 	table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
 
@@ -992,7 +1000,8 @@ static void gmc_v8_0_gart_disable(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
 	WREG32(mmVM_L2_CNTL, tmp);
 	WREG32(mmVM_L2_CNTL2, 0);
-	amdgpu_gart_table_vram_unpin(adev);
+	if (!adev->in_suspend)
+		amdgpu_gart_table_vram_unpin(adev);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index cb82404df534..1bbcefd53974 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1714,9 +1714,16 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	r = amdgpu_gart_table_vram_pin(adev);
-	if (r)
-		return r;
+	if (!adev->in_suspend) {
+		r = amdgpu_gart_table_vram_pin(adev);
+		if (r)
+			return r;
+	} else {
+		r = amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev,
+							    TTM_PL_TT));
+		if (r)
+			return r;
+	}
 
 	r = adev->gfxhub.funcs->gart_enable(adev);
 	if (r)
@@ -1793,7 +1800,8 @@ static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
 {
 	adev->gfxhub.funcs->gart_disable(adev);
 	adev->mmhub.funcs->gart_disable(adev);
-	amdgpu_gart_table_vram_unpin(adev);
+	if (!adev->in_suspend)
+		amdgpu_gart_table_vram_unpin(adev);
 }
 
 static int gmc_v9_0_hw_fini(void *handle)
-- 
2.32.0

