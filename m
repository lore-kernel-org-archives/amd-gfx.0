Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A986BC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 16:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0404C10E4DB;
	Wed, 16 Nov 2022 16:41:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74DF010E4DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 16:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgqBO0Aige0eNiKIOo1NwUc1Dct0tSR0B3cyXPhFryp+dpXKRFy8HlRQmAJ7TdJC2jIqxVDPocEYEd2goDeQdP4CpoL/Qw6Sto/LobpBnB0tkr3SAgH5FsndrdXhXWfViTdLOIOE9Bp4igR0pT7GWP0KajF9L5+7iCW3ZHhHEkpIGEOMqhE3Li9kjaziXGefHFz+l7NbmtmKjcFMthM5615oTtMoQbTycjurBHa50WeLR5Y714MfBJQLjTQCNeZogXjUjdXSRh+qZR/E1WndXjGdY7JJygvyY7lECBmkQJiIUEjIY5yxKjhn8pH0A7HZXCTnVnuMn9H0ldyMGtIcDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfvZTx30bPPmsIIvFD+uz9NcTiP0OFSG2BbY84rVy4Y=;
 b=PzVqR46NWpo90MlEMgqlU1E0Trj6dGAq0Z1AEi7CayTzLn81w0wfeBS1mrpBY4QtWs6oGFFhVbwQxt1/+Jax97JIrkSVBx79GVNHjBXyuf1+Yn2r6QRhJEvoaKP3Ov1TFnBcjk6irufaILOtqIpUY/7w3kH/aB9hRD6wLjwwnAwwq0Q4L+PGTDtVNsqtpC53JUfrs7bkKphKltHx8YIaq80S62GaYbAAWfWYWbT8j52s2bVnZNBJa9zmpWQAq5y+9yeAIKPMjDo63HR0hoAoXvi9cqnZEWWgVRz003OlVw/m9Y40I0FhPEmcQn93otGi5cJa0YBNsZPpFlZcnys2OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfvZTx30bPPmsIIvFD+uz9NcTiP0OFSG2BbY84rVy4Y=;
 b=zqO/RxKdC28smCpqGe3/F+Q+dC8LWdVOtNw0ExQ7gazQUWL4ueD1JPAJwe6nuBAumfTKcVMO6OIb39/ux3P+0vzq8neUgefdNzXaHcfZ263Nif01pnqrf2JaGffk+SzIeznTxlrz/q8eEiYNVjrgAE+3F+Yo/0k7OF2ipKaKkM0=
Received: from MN2PR07CA0019.namprd07.prod.outlook.com (2603:10b6:208:1a0::29)
 by SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 16:40:59 +0000
Received: from BL02EPF0000EE3E.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::11) by MN2PR07CA0019.outlook.office365.com
 (2603:10b6:208:1a0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19 via Frontend
 Transport; Wed, 16 Nov 2022 16:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3E.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Wed, 16 Nov 2022 16:40:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 10:40:57 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: make psp_ring_init common
Date: Wed, 16 Nov 2022 11:40:42 -0500
Message-ID: <20221116164042.2830086-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116164042.2830086-1-alexander.deucher@amd.com>
References: <20221116164042.2830086-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3E:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c80ae6-e659-439a-75a6-08dac7f15689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3BYLLpYtswQVtNBeQjOLcMUCG/5DTqLrvDQstSpRFKvVZP0+VLaNP8VKTtcJB2lU2qgyeVTAOzoTbT8CMu9EUjKFDGaMjRqZTyi67iMIosYa6prlupM7P3e5J7bL6/kTMgkSXmupk3QfGIENHxqvgydPdDj6JTrG6eMxs0bFsSGYPKaT2Xc4Dry9hJfiHS32ZtYzPZ52qYkmnf6VFXrRgPt6bKkAz8KBZ/7fmluUJKHyiaSvbhYE1WQE7vWO/ygf/kfHyDY6MpLm3owRFu68gHolcKFrARc3Xxqy2RzC7VOVPMBmcWwHDHXuePhvvD3WVzJJSY7up9xLDFHm7qa00ce/Fhg3Nepyhpc25xiTKr7Fp5Lvvko5MsT0kLiF/SK0hodnluFFDMl62D6aJSoFtEKsgWYk/02XtAEoZ65ER3xRJyOOvPaYYtvZ+eHDAL4VidrOHdLF2nOl+/4AyiqAfGanCiSeB90dI1/uHO/pb1It+IFDVuJZh0omYJ4N3NHNhd2HbCxzFTVYTIHHKcqjF/MqbBuQ7f1GPcSu6WRDXLi6McykDOeDe+KBbYaeBFBXhtXw6Bi/i/V06ZLTxK6m71qmQFZuwn2PXQCfDK1rwuxXTUsi5eRxkbbCJ+I+ZKLW0IfF9A81eF/PFGU/i3SuYRd1pKsAVjE4tfg9wjbUVTtdS3ALMMnS5Q1MCSopDUKDF3u4n5tbJd/6qMbqP7NohIje+IFvTA8dFUCjrmP7N/lwmuGvy4PX0YV8wmChiyt2z+0OKIRMiW+C6SSnonBtq0UJJh/hHQkFoXukeBpik1E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(86362001)(36756003)(2906002)(36860700001)(356005)(30864003)(8936002)(81166007)(40460700003)(83380400001)(47076005)(336012)(1076003)(2616005)(426003)(16526019)(6916009)(316002)(5660300002)(70206006)(478600001)(40480700001)(82310400005)(186003)(70586007)(82740400003)(7696005)(26005)(6666004)(8676002)(4326008)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 16:40:57.8772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c80ae6-e659-439a-75a6-08dac7f15689
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

All of the IP specific versions are the same now, so
we can just use a common function.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 26 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  |  2 --
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c   | 27 ------------------------
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c   | 27 ------------------------
 drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c | 27 ------------------------
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c   | 27 ------------------------
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c   | 27 ------------------------
 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c | 27 ------------------------
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c    | 27 ------------------------
 9 files changed, 26 insertions(+), 191 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d9cb4c4b8289..7bb2de1d11ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -52,6 +52,32 @@ static int psp_load_smu_fw(struct psp_context *psp);
 static int psp_rap_terminate(struct psp_context *psp);
 static int psp_securedisplay_terminate(struct psp_context *psp);
 
+static int psp_ring_init(struct psp_context *psp,
+			 enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	struct psp_ring *ring;
+	struct amdgpu_device *adev = psp->adev;
+
+	ring = &psp->km_ring;
+
+	ring->ring_type = ring_type;
+
+	/* allocate 4k Page of Local Frame Buffer memory for ring */
+	ring->ring_size = 0x1000;
+	ret = amdgpu_bo_create_kernel(adev, ring->ring_size, PAGE_SIZE,
+				      AMDGPU_GEM_DOMAIN_VRAM,
+				      &adev->firmware.rbuf,
+				      &ring->ring_mem_mc_addr,
+				      (void **)&ring->ring_mem);
+	if (ret) {
+		ring->ring_size = 0;
+		return ret;
+	}
+
+	return 0;
+}
+
 /*
  * Due to DF Cstate management centralized to PMFW, the firmware
  * loading sequence will be updated as below:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index cbd4194a2883..cf4f60c66122 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -118,7 +118,6 @@ struct psp_funcs
 	int (*bootloader_load_dbg_drv)(struct psp_context *psp);
 	int (*bootloader_load_ras_drv)(struct psp_context *psp);
 	int (*bootloader_load_sos)(struct psp_context *psp);
-	int (*ring_init)(struct psp_context *psp, enum psp_ring_type ring_type);
 	int (*ring_create)(struct psp_context *psp,
 			   enum psp_ring_type ring_type);
 	int (*ring_stop)(struct psp_context *psp,
@@ -396,7 +395,6 @@ struct amdgpu_psp_funcs {
 };
 
 
-#define psp_ring_init(psp, type) (psp)->funcs->ring_init((psp), (type))
 #define psp_ring_create(psp, type) (psp)->funcs->ring_create((psp), (type))
 #define psp_ring_stop(psp, type) (psp)->funcs->ring_stop((psp), (type))
 #define psp_ring_destroy(psp, type) ((psp)->funcs->ring_destroy((psp), (type)))
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
index ed2293686f0d..9de46fa8f46c 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -126,32 +126,6 @@ static int psp_v10_0_init_microcode(struct psp_context *psp)
 	return err;
 }
 
-static int psp_v10_0_ring_init(struct psp_context *psp,
-			       enum psp_ring_type ring_type)
-{
-	int ret = 0;
-	struct psp_ring *ring;
-	struct amdgpu_device *adev = psp->adev;
-
-	ring = &psp->km_ring;
-
-	ring->ring_type = ring_type;
-
-	/* allocate 4k Page of Local Frame Buffer memory for ring */
-	ring->ring_size = 0x1000;
-	ret = amdgpu_bo_create_kernel(adev, ring->ring_size, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &adev->firmware.rbuf,
-				      &ring->ring_mem_mc_addr,
-				      (void **)&ring->ring_mem);
-	if (ret) {
-		ring->ring_size = 0;
-		return ret;
-	}
-
-	return 0;
-}
-
 static int psp_v10_0_ring_create(struct psp_context *psp,
 				 enum psp_ring_type ring_type)
 {
@@ -245,7 +219,6 @@ static void psp_v10_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
 
 static const struct psp_funcs psp_v10_0_funcs = {
 	.init_microcode = psp_v10_0_init_microcode,
-	.ring_init = psp_v10_0_ring_init,
 	.ring_create = psp_v10_0_ring_create,
 	.ring_stop = psp_v10_0_ring_stop,
 	.ring_destroy = psp_v10_0_ring_destroy,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 9518b4394a6e..bd3e3e23a939 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -360,32 +360,6 @@ static int psp_v11_0_bootloader_load_sos(struct psp_context *psp)
 	return ret;
 }
 
-static int psp_v11_0_ring_init(struct psp_context *psp,
-			      enum psp_ring_type ring_type)
-{
-	int ret = 0;
-	struct psp_ring *ring;
-	struct amdgpu_device *adev = psp->adev;
-
-	ring = &psp->km_ring;
-
-	ring->ring_type = ring_type;
-
-	/* allocate 4k Page of Local Frame Buffer memory for ring */
-	ring->ring_size = 0x1000;
-	ret = amdgpu_bo_create_kernel(adev, ring->ring_size, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &adev->firmware.rbuf,
-				      &ring->ring_mem_mc_addr,
-				      (void **)&ring->ring_mem);
-	if (ret) {
-		ring->ring_size = 0;
-		return ret;
-	}
-
-	return 0;
-}
-
 static int psp_v11_0_ring_stop(struct psp_context *psp,
 			      enum psp_ring_type ring_type)
 {
@@ -779,7 +753,6 @@ static const struct psp_funcs psp_v11_0_funcs = {
 	.bootloader_load_spl = psp_v11_0_bootloader_load_spl,
 	.bootloader_load_sysdrv = psp_v11_0_bootloader_load_sysdrv,
 	.bootloader_load_sos = psp_v11_0_bootloader_load_sos,
-	.ring_init = psp_v11_0_ring_init,
 	.ring_create = psp_v11_0_ring_create,
 	.ring_stop = psp_v11_0_ring_stop,
 	.ring_destroy = psp_v11_0_ring_destroy,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
index ff13e1beb49b..5697760a819b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
@@ -28,32 +28,6 @@
 
 #include "mp/mp_11_0_8_offset.h"
 
-static int psp_v11_0_8_ring_init(struct psp_context *psp,
-			      enum psp_ring_type ring_type)
-{
-	int ret = 0;
-	struct psp_ring *ring;
-	struct amdgpu_device *adev = psp->adev;
-
-	ring = &psp->km_ring;
-
-	ring->ring_type = ring_type;
-
-	/* allocate 4k Page of Local Frame Buffer memory for ring */
-	ring->ring_size = 0x1000;
-	ret = amdgpu_bo_create_kernel(adev, ring->ring_size, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &adev->firmware.rbuf,
-				      &ring->ring_mem_mc_addr,
-				      (void **)&ring->ring_mem);
-	if (ret) {
-		ring->ring_size = 0;
-		return ret;
-	}
-
-	return 0;
-}
-
 static int psp_v11_0_8_ring_stop(struct psp_context *psp,
 			       enum psp_ring_type ring_type)
 {
@@ -194,7 +168,6 @@ static void psp_v11_0_8_ring_set_wptr(struct psp_context *psp, uint32_t value)
 }
 
 static const struct psp_funcs psp_v11_0_8_funcs = {
-	.ring_init = psp_v11_0_8_ring_init,
 	.ring_create = psp_v11_0_8_ring_create,
 	.ring_stop = psp_v11_0_8_ring_stop,
 	.ring_destroy = psp_v11_0_8_ring_destroy,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index d7dd84090c09..8ed2281b6557 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -236,32 +236,6 @@ static void psp_v12_0_reroute_ih(struct psp_context *psp)
 		     0x80000000, 0x8000FFFF, false);
 }
 
-static int psp_v12_0_ring_init(struct psp_context *psp,
-			      enum psp_ring_type ring_type)
-{
-	int ret = 0;
-	struct psp_ring *ring;
-	struct amdgpu_device *adev = psp->adev;
-
-	ring = &psp->km_ring;
-
-	ring->ring_type = ring_type;
-
-	/* allocate 4k Page of Local Frame Buffer memory for ring */
-	ring->ring_size = 0x1000;
-	ret = amdgpu_bo_create_kernel(adev, ring->ring_size, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &adev->firmware.rbuf,
-				      &ring->ring_mem_mc_addr,
-				      (void **)&ring->ring_mem);
-	if (ret) {
-		ring->ring_size = 0;
-		return ret;
-	}
-
-	return 0;
-}
-
 static int psp_v12_0_ring_create(struct psp_context *psp,
 				enum psp_ring_type ring_type)
 {
@@ -425,7 +399,6 @@ static const struct psp_funcs psp_v12_0_funcs = {
 	.init_microcode = psp_v12_0_init_microcode,
 	.bootloader_load_sysdrv = psp_v12_0_bootloader_load_sysdrv,
 	.bootloader_load_sos = psp_v12_0_bootloader_load_sos,
-	.ring_init = psp_v12_0_ring_init,
 	.ring_create = psp_v12_0_ring_create,
 	.ring_stop = psp_v12_0_ring_stop,
 	.ring_destroy = psp_v12_0_ring_destroy,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 88f9b327183a..ee27bfaba6fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -268,32 +268,6 @@ static int psp_v13_0_bootloader_load_sos(struct psp_context *psp)
 	return ret;
 }
 
-static int psp_v13_0_ring_init(struct psp_context *psp,
-			      enum psp_ring_type ring_type)
-{
-	int ret = 0;
-	struct psp_ring *ring;
-	struct amdgpu_device *adev = psp->adev;
-
-	ring = &psp->km_ring;
-
-	ring->ring_type = ring_type;
-
-	/* allocate 4k Page of Local Frame Buffer memory for ring */
-	ring->ring_size = 0x1000;
-	ret = amdgpu_bo_create_kernel(adev, ring->ring_size, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &adev->firmware.rbuf,
-				      &ring->ring_mem_mc_addr,
-				      (void **)&ring->ring_mem);
-	if (ret) {
-		ring->ring_size = 0;
-		return ret;
-	}
-
-	return 0;
-}
-
 static int psp_v13_0_ring_stop(struct psp_context *psp,
 			       enum psp_ring_type ring_type)
 {
@@ -729,7 +703,6 @@ static const struct psp_funcs psp_v13_0_funcs = {
 	.bootloader_load_dbg_drv = psp_v13_0_bootloader_load_dbg_drv,
 	.bootloader_load_ras_drv = psp_v13_0_bootloader_load_ras_drv,
 	.bootloader_load_sos = psp_v13_0_bootloader_load_sos,
-	.ring_init = psp_v13_0_ring_init,
 	.ring_create = psp_v13_0_ring_create,
 	.ring_stop = psp_v13_0_ring_stop,
 	.ring_destroy = psp_v13_0_ring_destroy,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
index 321089dfa7db..9d4e24e518e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
@@ -199,32 +199,6 @@ static int psp_v13_0_4_bootloader_load_sos(struct psp_context *psp)
 	return ret;
 }
 
-static int psp_v13_0_4_ring_init(struct psp_context *psp,
-			      enum psp_ring_type ring_type)
-{
-	int ret = 0;
-	struct psp_ring *ring;
-	struct amdgpu_device *adev = psp->adev;
-
-	ring = &psp->km_ring;
-
-	ring->ring_type = ring_type;
-
-	/* allocate 4k Page of Local Frame Buffer memory for ring */
-	ring->ring_size = 0x1000;
-	ret = amdgpu_bo_create_kernel(adev, ring->ring_size, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &adev->firmware.rbuf,
-				      &ring->ring_mem_mc_addr,
-				      (void **)&ring->ring_mem);
-	if (ret) {
-		ring->ring_size = 0;
-		return ret;
-	}
-
-	return 0;
-}
-
 static int psp_v13_0_4_ring_stop(struct psp_context *psp,
 			       enum psp_ring_type ring_type)
 {
@@ -373,7 +347,6 @@ static const struct psp_funcs psp_v13_0_4_funcs = {
 	.bootloader_load_intf_drv = psp_v13_0_4_bootloader_load_intf_drv,
 	.bootloader_load_dbg_drv = psp_v13_0_4_bootloader_load_dbg_drv,
 	.bootloader_load_sos = psp_v13_0_4_bootloader_load_sos,
-	.ring_init = psp_v13_0_4_ring_init,
 	.ring_create = psp_v13_0_4_ring_create,
 	.ring_stop = psp_v13_0_4_ring_stop,
 	.ring_destroy = psp_v13_0_4_ring_destroy,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index 01f3bcc62a6c..157147c6c94e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -160,32 +160,6 @@ static int psp_v3_1_bootloader_load_sos(struct psp_context *psp)
 	return ret;
 }
 
-static int psp_v3_1_ring_init(struct psp_context *psp,
-			      enum psp_ring_type ring_type)
-{
-	int ret = 0;
-	struct psp_ring *ring;
-	struct amdgpu_device *adev = psp->adev;
-
-	ring = &psp->km_ring;
-
-	ring->ring_type = ring_type;
-
-	/* allocate 4k Page of Local Frame Buffer memory for ring */
-	ring->ring_size = 0x1000;
-	ret = amdgpu_bo_create_kernel(adev, ring->ring_size, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &adev->firmware.rbuf,
-				      &ring->ring_mem_mc_addr,
-				      (void **)&ring->ring_mem);
-	if (ret) {
-		ring->ring_size = 0;
-		return ret;
-	}
-
-	return 0;
-}
-
 static void psp_v3_1_reroute_ih(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
@@ -401,7 +375,6 @@ static const struct psp_funcs psp_v3_1_funcs = {
 	.init_microcode = psp_v3_1_init_microcode,
 	.bootloader_load_sysdrv = psp_v3_1_bootloader_load_sysdrv,
 	.bootloader_load_sos = psp_v3_1_bootloader_load_sos,
-	.ring_init = psp_v3_1_ring_init,
 	.ring_create = psp_v3_1_ring_create,
 	.ring_stop = psp_v3_1_ring_stop,
 	.ring_destroy = psp_v3_1_ring_destroy,
-- 
2.38.1

