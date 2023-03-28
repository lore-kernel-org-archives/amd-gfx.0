Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175CBC761AF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33CB110E929;
	Tue, 28 Mar 2023 15:15:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A404B10E917
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwenSJh7SbJ5bYoyYFuio+rxaCd40rpFvm8Q4zlP4P0Wd2PiVZhjP/7tFloH4O/Ezg9rhJp4W7vfPDbPofXN+mbJOXLzi26LpE1G8S9n9oegNsdmlusxrbq1Ky1R8rKoSvzxd2Gvo5b4rVEwVvxSikuQna15k73jL3ZPqluIMcmgYDg/3bWCY9WRdLfp9HxToxR9RmG5XiVTGIw9MOFHRCJK8yAc+wlttnS4PEDDIT3vuX1+PwidQgb4UqdwB5lAJT7iUg2HEuXb+U6bCs+jBaiJjVkUlE5Pi00yJqWSJ9xvZ4XupbTPKtnb7Tm7Zly1iilfreBlDbnKkyTxAHaCHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5qIOR0ogusbhy7woGMl2bXWByQU+RgiJde6r/GO9PE=;
 b=bIYoAuuXJLVzH34TnRoQfFOjc+n+SslcYJd8J/RiTXC+4or9aqDaz0I5doPlhxjJEde45tC8bBcb2L0IHe1sgySbfnkoq7mLJYvzZg+zX6w+wvSec9kcb49kaOyd/ijYq9N+omImsltcRbruEPwh9dWZ/cQKBmBgDoi9WfC7Abvn/OyBAbuMrkYnAfqfLS0CH0RF1jQkkSbsvtf3mIAeQ3fRz2CEYqhI2d+ksmgZXrBXXbnEEIOz4pwxNINppbXnukbQEiORK3mlk4EpPwIKDPBTriLK0keEvw7acnGTtk3jwRfDi44ccQCpRoenP6xYhxg/SZmmYvPW1vtW4mlEZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5qIOR0ogusbhy7woGMl2bXWByQU+RgiJde6r/GO9PE=;
 b=1ciH/oyLGKvOx/OlTq0r61cbWjGdFB9bPUCt3aSsRCo1kFOCru7vJrCy063UntJz8ajqZZz0bHsdJFm4JuRQIQ7RiPXvhLWM6muWUN9/kWs7U1iDyp0/qDk6vawP+nxw6l1SOfsJJh9PxLGeu+FplDaem0RXCQu0mXW08UIxbxA=
Received: from BLAP220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::23)
 by SJ0PR12MB8139.namprd12.prod.outlook.com (2603:10b6:a03:4e8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 15:14:54 +0000
Received: from BL02EPF000100D1.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::54) by BLAP220CA0018.outlook.office365.com
 (2603:10b6:208:32c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 31/32] drm/amdgpu: introduce new doorbell assignment table for
 GC 9.4.3
Date: Tue, 28 Mar 2023 11:13:43 -0400
Message-ID: <20230328151344.1934291-31-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF000100D1:EE_|SJ0PR12MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: 34fb0910-0184-4720-16d9-08db2f9f2f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UDjgmPB+t3jI9mwt/Ha9R3da6BpHSpwWPhxhcnr4UkXPWF2Eh95SqN+kkgm29i6SPEq74DpegQreq7QaRv/kfUqBYkJvC58BPco9AOvdcXQrhobVmt6/XM67H/oGSxkGcmfQdNiYTbQjBMesxDBwOrMHNSveYGployTGF4zNXqn4MlInVShSgx/+2H3cMpHgLREubcacu8xbFYZurYA6X+8RpmJnV5WCrpLIGkLMpfAgy0i2B5TrpFSV7KkDRLnjdq8PjcbebIQmWeR0XztRd0UpvbSHM3zDJfgq6BXVPFKASK3r1hllllg6rx6Dmu3jftmBGSY47/zB6GFl1TrYdniWmlrpNe2fbiPD3tveXI6LVkn6VXjjAIr6L737/RlL24VNFtzWsvX+TpULEfZ/BosPYWd4HKqTIq05dxmGv5wrArD7h/yzTQhKoLgy80vpVk/xIGVpk6x6tafZYCEHffA3vaIgv2YA6vEY083h5ANnEwFY1uRcLV63flXpvIsHz0zj0oBwZUHwj+iX6TlBqlNntuN9wDeZj/9mHU/T2RzAbyMStzJS3gFPSYg/ifZ5HZM0bNg3E5MrSdPqjfm4InLF+HT9cnmX7tYC27j1aSFcGE+9fnDzJF3A5MYUG1YRAey2GjqcJ5DBBP0JzIYytXIBnDvVOrTLElvxGJLtx2hJYUnaIHCOmlb/ZKe7ZlLlT5Pk3R9bbr+DEYEwTptLtmZMTgKy8evuT1DSjgsdOCQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(6916009)(356005)(40480700001)(36756003)(40460700003)(86362001)(82310400005)(8676002)(70586007)(70206006)(316002)(336012)(8936002)(5660300002)(2616005)(41300700001)(16526019)(6666004)(186003)(7696005)(478600001)(54906003)(26005)(1076003)(4326008)(36860700001)(81166007)(47076005)(426003)(2906002)(82740400003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:54.2344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fb0910-0184-4720-16d9-08db2f9f2f4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8139
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Four basic reasons as below to do the change:
  1. number of ring expand a lot on GC 9.4.3, and adjustment on old
     assignment cannot make each ring in a continuous doorbell space.
  2. the SDMA doorbell index should not exceed 0x1FF on SDMA 4.2.2 due to
     regDOORBELLx_CTRL_ENTRY.BIF_DOORBELLx_RANGE_OFFSET_ENTRY field width.
  3. re-design the doorbell assignment and unify the calculation as
     "start + ring/inst id" will make the code much concise.
  4. only defining the START/END makes the table look simple

v2: (Lijo)
  1. replace name
  2. use num_inst_per_aid/sdma_doorbell_range instead of hardcoding

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h | 32 +++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c      |  6 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c      |  8 +----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c     | 19 ++----------
 4 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 613bc035f2e4..93cbb307db93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -54,7 +54,7 @@ struct amdgpu_doorbell_index {
 	uint32_t gfx_ring1;
 	uint32_t gfx_userqueue_start;
 	uint32_t gfx_userqueue_end;
-	uint32_t sdma_engine[8];
+	uint32_t sdma_engine[16];
 	uint32_t mes_ring0;
 	uint32_t mes_ring1;
 	uint32_t ih;
@@ -78,9 +78,6 @@ struct amdgpu_doorbell_index {
 	};
 	uint32_t first_non_cp;
 	uint32_t last_non_cp;
-	uint32_t xcc1_kiq_start;
-	uint32_t xcc1_mec_ring0_start;
-	uint32_t aid1_sdma_start;
 	uint32_t max_assignment;
 	/* Per engine SDMA doorbell size in dword */
 	uint32_t sdma_doorbell_range;
@@ -307,6 +304,33 @@ typedef enum _AMDGPU_DOORBELL64_ASSIGNMENT
 	AMDGPU_DOORBELL64_INVALID                 = 0xFFFF
 } AMDGPU_DOORBELL64_ASSIGNMENT;
 
+typedef enum _AMDGPU_DOORBELL_ASSIGNMENT_LAYOUT1
+{
+	/* KIQ: 0~7 for maximum 8 XCD */
+	AMDGPU_DOORBELL_LAYOUT1_KIQ_START               = 0x000,
+	AMDGPU_DOORBELL_LAYOUT1_HIQ                     = 0x008,
+	AMDGPU_DOORBELL_LAYOUT1_DIQ                     = 0x009,
+	/* Compute: 0x0A ~ 0x49 */
+	AMDGPU_DOORBELL_LAYOUT1_MEC_RING_START          = 0x00A,
+	AMDGPU_DOORBELL_LAYOUT1_MEC_RING_END            = 0x049,
+	AMDGPU_DOORBELL_LAYOUT1_USERQUEUE_START         = 0x04A,
+	AMDGPU_DOORBELL_LAYOUT1_USERQUEUE_END           = 0x0C9,
+	/* SDMA: 0x100 ~ 0x19F */
+	AMDGPU_DOORBELL_LAYOUT1_sDMA_ENGINE_START       = 0x100,
+	AMDGPU_DOORBELL_LAYOUT1_sDMA_ENGINE_END         = 0x19F,
+	/* IH: 0x1A0 ~ 0x1AF */
+	AMDGPU_DOORBELL_LAYOUT1_IH                      = 0x1A0,
+	/* VCN: 0x1B0 ~ 0x1C2 */
+	AMDGPU_DOORBELL_LAYOUT1_VCN_START               = 0x1B0,
+	AMDGPU_DOORBELL_LAYOUT1_VCN_END                 = 0x1C2,
+
+	AMDGPU_DOORBELL_LAYOUT1_FIRST_NON_CP            = AMDGPU_DOORBELL_LAYOUT1_sDMA_ENGINE_START,
+	AMDGPU_DOORBELL_LAYOUT1_LAST_NON_CP             = AMDGPU_DOORBELL_LAYOUT1_VCN_END,
+
+	AMDGPU_DOORBELL_LAYOUT1_MAX_ASSIGNMENT          = 0x1C2,
+	AMDGPU_DOORBELL_LAYOUT1_INVALID                 = 0xFFFF
+} AMDGPU_DOORBELL_ASSIGNMENT_LAYOUT1;
+
 u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index);
 void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v);
 u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index d48f80469533..77a42f73c3de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -315,11 +315,7 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 	ring->use_doorbell = true;
 	ring->xcc_id = xcc_id;
 	ring->vm_hub = AMDGPU_GFXHUB(xcc_id);
-	if (xcc_id >= 1)
-		ring->doorbell_index = (adev->doorbell_index.xcc1_kiq_start +
-					xcc_id - 1) << 1;
-	else
-		ring->doorbell_index = adev->doorbell_index.kiq << 1;
+	ring->doorbell_index = (adev->doorbell_index.kiq + xcc_id) << 1;
 
 	r = amdgpu_gfx_kiq_acquire(adev, ring, xcc_id);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index bd375e472823..d103832630f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -822,13 +822,7 @@ static int gfx_v9_4_3_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 
 	ring->ring_obj = NULL;
 	ring->use_doorbell = true;
-	if (xcc_id >= 1)
-		ring->doorbell_index =
-				(adev->doorbell_index.xcc1_mec_ring0_start +
-				ring_id - adev->gfx.num_compute_rings) << 1;
-	else
-		ring->doorbell_index =
-				(adev->doorbell_index.mec_ring0 + ring_id) << 1;
+	ring->doorbell_index = (adev->doorbell_index.mec_ring0 + ring_id) << 1;
 	ring->eop_gpu_addr = adev->gfx.mec.hpd_eop_gpu_addr
 				+ (ring_id * GFX9_MEC_HPD_SIZE);
 	ring->vm_hub = AMDGPU_GFXHUB(xcc_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index d3c7f9a43ef1..9b53174925f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1310,14 +1310,7 @@ static int sdma_v4_4_2_sw_init(void *handle)
 				ring->use_doorbell?"true":"false");
 
 		/* doorbell size is 2 dwords, get DWORD offset */
-		if (aid_id > 0)
-			ring->doorbell_index =
-				(adev->doorbell_index.aid1_sdma_start << 1)
-				+ adev->doorbell_index.sdma_doorbell_range
-				* (i - adev->sdma.num_inst_per_aid);
-		else
-			ring->doorbell_index =
-				adev->doorbell_index.sdma_engine[i] << 1;
+		ring->doorbell_index = adev->doorbell_index.sdma_engine[i] << 1;
 		ring->vm_hub = AMDGPU_MMHUB0(aid_id);
 
 		sprintf(ring->name, "sdma%d.%d", aid_id,
@@ -1336,14 +1329,8 @@ static int sdma_v4_4_2_sw_init(void *handle)
 			/* doorbell index of page queue is assigned right after
 			 * gfx queue on the same instance
 			 */
-			if (aid_id > 0)
-				ring->doorbell_index =
-					((adev->doorbell_index.aid1_sdma_start + 1) << 1)
-					+ adev->doorbell_index.sdma_doorbell_range
-					* (i - adev->sdma.num_inst_per_aid);
-			else
-				ring->doorbell_index =
-					(adev->doorbell_index.sdma_engine[i] + 1) << 1;
+			ring->doorbell_index =
+				(adev->doorbell_index.sdma_engine[i] + 1) << 1;
 			ring->vm_hub = AMDGPU_MMHUB0(aid_id);
 
 			sprintf(ring->name, "page%d.%d", aid_id,
-- 
2.39.2

