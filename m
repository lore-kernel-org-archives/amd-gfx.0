Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D219C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69A4510E914;
	Tue, 28 Mar 2023 15:14:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63A3D10E90A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMJbV6NECWrOinXuP/BHaUBUGHkXm2/uzdJ82rFVP7kTV04Q3cV/A86ZKkdpGRfF5E57/8ixnefDvB8R4DsBpYl5Lk8kpxyERc54535jA2PMokES6OwH3XvRAirJidaSZVIpNnBtu/Lh58as8yTm2b11EEOcugliwgNWQYLhizOeQrOHxXNy19GA4TQPd5I9ojAI3mG/JPTX5IvrhXvK1IULDuVRMZTePS4lwjI8u5yHoZ7w4QNPwo9QL9tiuYMg9M65E/TcpiuXGrc8+zRfa9XqXSjkeGT4HBMUGRclCoQpeSGyO17g59zfylPlYtqLJ0MJrk8ttRr0h01AZDS/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uo1e5hhGnJOF6l9w0dtdQKdMkezqEkT7ZDVvWTijXQA=;
 b=CCXp4wkkrl4mgNnVdKeb9IEXFGD0DCvvX8LCfgtbE0ZE1mrgBazezlV+9GY3mNE9St4SgYuNFw/8T+5/tzgKvqsXWj6HQrdTNNLQKYXrapLsZ0NYzBRVOFzCwkcPsg2AVwIsqfCnWvQPuPd0DN6OwhegrPWY1sWtSbLE+57029f4BF898zkxj5HlHy79ScjksGWs8WFeH723NVr6q7QNdn+apIUkzOweOQfWzPvV5YoWhm0R/JX0LfQA2A/Jd5jvdV5jk5t3vB8mOl96NgA2udN/WhNhCr8FBCHlagySrFYA/YTqC3ZTAXytD7pSoaG3C6Y7McHrN3vJuIOE0WtO1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uo1e5hhGnJOF6l9w0dtdQKdMkezqEkT7ZDVvWTijXQA=;
 b=gfF2AeRXFmhRtJ3LC/A48m72yeKLy5pQJywy22z9Xq8c1YHwI2SaSnNVf1Wc52RRcwM4/5wN+2VlL00XOhlfTH+UEksCnDm8LbE9V52uf/j+i/QvN8BQM3wt+brNxmOeMvDlUta4B8xvkiIYcScgG7NLfAr/08CC0lfwoMJ65jU=
Received: from BN0PR02CA0033.namprd02.prod.outlook.com (2603:10b6:408:e5::8)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.41; Tue, 28 Mar 2023 15:14:37 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::1c) by BN0PR02CA0033.outlook.office365.com
 (2603:10b6:408:e5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/32] drm/amdgpu: Add XCC inst to PASID TLB flushing
Date: Tue, 28 Mar 2023 11:13:23 -0400
Message-ID: <20230328151344.1934291-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: d9517363-4591-4221-72c4-08db2f9f2545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ktfKNTEVn9GztbaT5o4svTwB91SY1uWaBkHa8c0fzPNREcn4DcnMzVFTQnf1Ml9LnpBecRGWxzgBdHbOQdffyCrapMXdCmOajbPnmBX1WrnL3nxR1/Q4njZ+QxulYbF0UxSvoL26JL+kH+nwHk6hftGailFEd17N/79aO5SY8EJOGecvx2yC5RkC6x+UnXfozbLujcRJgE2sF869Mueqfq3Gy38IpQ7+9ETV9UjWjchS6WDxhGzTKo5aBl4NVzFb3Jw2okv8xPHwtYjBu783vZlOHsdA/PVEEdLv1gvoJTiV6wqvU0p7vpqaNCPhB+v3y2mE4JFihf/4q5i7o/s3IO6+FJRK+nqljW5710lyKAgR+R1nADEEqCLscr7F+GBI68J8wuF+n8jusmWcRi0O/v4mtR10bgfWt4SKGjDjot6X+ntDdUQSXvuua+MEgLVmhkyV7O5xCG2c0gFb9AxYV4zfVLRjNreil+i5rbR3+6qnuq9YJ6PVpaKdhG1iriD0nCWo4iRolu2t1MvXIVnoIsmFAAGdDbsRyMx7taRlhPd5rCEJzAskYK0hpQNl/1pZWOQeFz4YRb2iJYLhqR58lxMSIGIighx8/ugtUzVGtS2+6atvDmYeFHaxeQOStDU29XY1nGnszGPf5QVvmuMi8MawWnrCuf5HjffE5Pj7yovawPCYAjZGjUmTjskOCcfUCXAbuTwH4XjKKzcJOZ2OL73Gfkl5b0OgWOa7PSz/x3c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(46966006)(36840700001)(40470700004)(47076005)(83380400001)(426003)(86362001)(82310400005)(26005)(2906002)(6666004)(1076003)(316002)(7696005)(54906003)(478600001)(40480700001)(356005)(16526019)(8676002)(2616005)(186003)(6916009)(4326008)(40460700003)(336012)(36860700001)(5660300002)(36756003)(82740400003)(8936002)(70586007)(70206006)(81166007)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:37.4202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9517363-4591-4221-72c4-08db2f9f2545
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168
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
Cc: Amber Lin <Amber.Lin@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Felix
 Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

Add XCC instance to select the correct KIQ ring when
flushing TLBs on a multi-XCC setup.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Tested-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  7 ++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 12 ++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  7 +++++--
 9 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 90d872356edc..0f641bb30870 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -742,7 +742,9 @@ int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct amdgpu_device *adev,
 }
 
 int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
-				      uint16_t pasid, enum TLB_FLUSH_TYPE flush_type)
+				      uint16_t pasid,
+				      enum TLB_FLUSH_TYPE flush_type,
+				      uint32_t inst)
 {
 	bool all_hub = false;
 
@@ -750,7 +752,7 @@ int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	    adev->family == AMDGPU_FAMILY_RV)
 		all_hub = true;
 
-	return amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, flush_type, all_hub);
+	return amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, flush_type, all_hub, inst);
 }
 
 bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 01ba3589b60a..df07e212c21e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -160,7 +160,8 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
 int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct amdgpu_device *adev,
 				uint16_t vmid);
 int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
-				uint16_t pasid, enum TLB_FLUSH_TYPE flush_type);
+				uint16_t pasid, enum TLB_FLUSH_TYPE flush_type,
+				uint32_t inst);
 
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 232523e3e270..5c1d68bec0be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -118,7 +118,8 @@ struct amdgpu_gmc_funcs {
 				uint32_t vmhub, uint32_t flush_type);
 	/* flush the vm tlb via pasid */
 	int (*flush_gpu_tlb_pasid)(struct amdgpu_device *adev, uint16_t pasid,
-					uint32_t flush_type, bool all_hub);
+					uint32_t flush_type, bool all_hub,
+					uint32_t inst);
 	/* flush the vm tlb via ring */
 	uint64_t (*emit_flush_gpu_tlb)(struct amdgpu_ring *ring, unsigned vmid,
 				       uint64_t pd_addr);
@@ -295,9 +296,9 @@ struct amdgpu_gmc {
 };
 
 #define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
-#define amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, type, allhub) \
+#define amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, type, allhub, inst) \
 	((adev)->gmc.gmc_funcs->flush_gpu_tlb_pasid \
-	((adev), (pasid), (type), (allhub)))
+	((adev), (pasid), (type), (allhub), (inst)))
 #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
 #define amdgpu_gmc_emit_pasid_mapping(r, vmid, pasid) (r)->adev->gmc.gmc_funcs->emit_pasid_mapping((r), (vmid), (pasid))
 #define amdgpu_gmc_map_mtype(adev, flags) (adev)->gmc.gmc_funcs->map_mtype((adev),(flags))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 503b4ff13fa4..100da79e17d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -419,7 +419,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
  */
 static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 					uint16_t pasid, uint32_t flush_type,
-					bool all_hub)
+					bool all_hub, uint32_t inst)
 {
 	int vmid, i;
 	signed long r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index d5a0f16cddba..088ba9784548 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -322,7 +322,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
  */
 static int gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 					uint16_t pasid, uint32_t flush_type,
-					bool all_hub)
+					bool all_hub, uint32_t inst)
 {
 	int vmid, i;
 	signed long r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 81609a2b226f..6f53049619cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -424,7 +424,7 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
  */
 static int gmc_v7_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 					uint16_t pasid, uint32_t flush_type,
-					bool all_hub)
+					bool all_hub, uint32_t inst)
 {
 	int vmid;
 	unsigned int tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index d48e33738a88..48475077ca92 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -622,7 +622,7 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
  */
 static int gmc_v8_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 					uint16_t pasid, uint32_t flush_type,
-					bool all_hub)
+					bool all_hub, uint32_t inst)
 {
 	int vmid;
 	unsigned int tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 63ea9dabe999..18aa2a896c3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -907,7 +907,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
  */
 static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 					uint16_t pasid, uint32_t flush_type,
-					bool all_hub)
+					bool all_hub, uint32_t inst)
 {
 	int vmid, i;
 	signed long r;
@@ -915,8 +915,8 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint16_t queried_pasid;
 	bool ret;
 	u32 usec_timeout = amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT : adev->usec_timeout;
-	struct amdgpu_ring *ring = &adev->gfx.kiq[0].ring;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
 
 	if (amdgpu_in_reset(adev))
 		return -EIO;
@@ -936,7 +936,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		if (vega20_xgmi_wa)
 			ndw += kiq->pmf->invalidate_tlbs_size;
 
-		spin_lock(&adev->gfx.kiq[0].ring_lock);
+		spin_lock(&adev->gfx.kiq[inst].ring_lock);
 		/* 2 dwords flush + 8 dwords fence */
 		amdgpu_ring_alloc(ring, ndw);
 		if (vega20_xgmi_wa)
@@ -947,13 +947,13 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
 		if (r) {
 			amdgpu_ring_undo(ring);
-			spin_unlock(&adev->gfx.kiq[0].ring_lock);
+			spin_unlock(&adev->gfx.kiq[inst].ring_lock);
 			up_read(&adev->reset_domain->sem);
 			return -ETIME;
 		}
 
 		amdgpu_ring_commit(ring);
-		spin_unlock(&adev->gfx.kiq[0].ring_lock);
+		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
 		r = amdgpu_fence_wait_polling(ring, seq, usec_timeout);
 		if (r < 1) {
 			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index a56b8acc051c..9e667fa38df1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -2052,6 +2052,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
 	struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
 	uint64_t tlb_seq = amdgpu_vm_tlb_seq(vm);
 	struct kfd_node *dev = pdd->dev;
+	int xcc = 0;
 
 	/*
 	 * It can be that we race and lose here, but that is extremely unlikely
@@ -2069,8 +2070,10 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
 			amdgpu_amdkfd_flush_gpu_tlb_vmid(dev->adev,
 							pdd->qpd.vmid);
 	} else {
-		amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->adev,
-					pdd->process->pasid, type);
+		for (xcc = 0; xcc < dev->num_xcc_per_node; xcc++)
+			amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->adev,
+					pdd->process->pasid, type,
+					dev->start_xcc_id + xcc);
 	}
 }
 
-- 
2.39.2

