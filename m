Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74201C7EE32
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26C0510E940;
	Fri, 27 Jun 2025 03:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rrLrU4IH";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3514510E93C
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fq6ZEh/3ZZrpdgLlqsRpxcSxquGfTc5+rYBLP02AGz4mq5EBZE5uL9bkIHI1R1k13C04TLkXCayvX+6jrQgFvNT25H7hj2wzHw9IBUiIlwnOFGy/OF34St4WnAo0SHD7dSALrs3wdn1RSJjNlp81x8ootZqWTmTHutG5Mpl0weCoIomkgG6AeSX9br9vQscCcR0GRbHcU02e7DoPSb2Zu2ont6pDRov/fMMqZpUPNz5Z3ogMdW2SOrpzXj76diOj7bjqOO/0rtajxcJ9zXULeglu/4ns4jnu30wN2UoGwXBDtIgyQwkuNaVB5eTqiCaPWzj8aRTVgKXsK0BSaYbo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGTKXdLKk/IiwI9iYNJlRZeSxLH3te5Xuth/EnnH9vQ=;
 b=AsAfu8ywkGQAxPbKcT7mEGX7mtFBdE0Q4DEm2SjXg1ZZK39NrPe/r+fyiBRR4OkQA3ugrtOfgSJK5BCIKa/WIEDHTyg4qRmh66qTgzLIx2KeoyZAc+7ZRux+47s1f7J5+Q6Pate/4pDBPXiah7XJqT/W+KjT5ZO8IY+I3wqR60uYxZv3RpKXj4DFsHOB2leXymq5qhQ3sxPW2AcktQsVKSlsdnayXU/rz3AQAj6ksn0SxmiiPceRoinKslr25GZqnUoQKz37e/6ppSuiWyTQQRsF6i7YgVnayKPJzf2cOYsy2Uk6PJ0wrjBkMVfoxDomaT5nrGXpbIXJ4UxfHiC/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGTKXdLKk/IiwI9iYNJlRZeSxLH3te5Xuth/EnnH9vQ=;
 b=rrLrU4IHuDShkthMV5un3LKhbSB5g6jV3jjT5w8oljrfl6iAFlAaXt3eCV/kGGfEFwVo2hFBScDCvMWSS6ztysAD5KQrR+lsWxZqajtuOJyow4rHzuLn3UZrhznIj3b9SZVCtJ4mIVafE8unhjW2vjv3qazF5qcIdoL9P8CVuz4=
Received: from MN2PR08CA0009.namprd08.prod.outlook.com (2603:10b6:208:239::14)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.32; Fri, 27 Jun
 2025 03:40:26 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::7c) by MN2PR08CA0009.outlook.office365.com
 (2603:10b6:208:239::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.18 via Frontend Transport; Fri,
 27 Jun 2025 03:40:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/33] drm/amdgpu/sdma5.2: clean up resume code
Date: Thu, 26 Jun 2025 23:39:34 -0400
Message-ID: <20250627034002.5590-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|BY5PR12MB4195:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa48ac5-7932-4161-3e34-08ddb52c5a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lo5Mg0GQ/YksRoNIxeV4KZHXeGa941xZRNTIAwTqYzYgCfTssDfoXiC0m23B?=
 =?us-ascii?Q?3aU2HcZ8GfWzKIyQCWFF2gO8CSTWTWyZSqlqMWwFmHaTj6IvEdpytiT6BSQH?=
 =?us-ascii?Q?c/gK1q+mL+XA/3xsI6EUvWbCH7iM+9eF/zZi7P1/1seGUw3sjims7syyNe9G?=
 =?us-ascii?Q?34RF0UoASszJOyTqQ+i6cVX15JgNQOiRAEVDQN16lEWax8rfSHrEl1esFMSL?=
 =?us-ascii?Q?QdyME5rvLus6C+GW2WOfmkZaGJGmjt79jibfTtqEhF5LfY0h6Mj92EHt6juy?=
 =?us-ascii?Q?lti991b0FbCO3qQvuk2IIQ/F7QPoBFdF3qvXbS6u3NOvP968vU0GXYeXLWMH?=
 =?us-ascii?Q?+SFmXxsvSJL9f52fXSE/IzWBN2d5rQ9L4lENtoMGz7+eLPetrlehHer5yI4H?=
 =?us-ascii?Q?yTLebLF912C6bdfeSt4UoPs7QxRUEd2KS5BD4iZ03BEUyYoMKYHawAw6ptgb?=
 =?us-ascii?Q?SU92pDBhWrjGa05mjXUV21ZvhtcjEKmokNbX3p3Twczi3tneqsLQ02vewmYI?=
 =?us-ascii?Q?vAz9p4xocthjWRO4OdtDhPaA9oLwiNJbA4zh2GZenNR53XzW+OVInunKgPI1?=
 =?us-ascii?Q?OPtQs1BxlILHYBl9M7pW+fGf773qwQzmo+HOfGr85OS7QKZHs9H7TeUusNid?=
 =?us-ascii?Q?zjIaLqC8gaBtT/2dUm+SZUrGdIeVTIUju8ql4D9nEs3bTP7Yz8oys0ze+Md4?=
 =?us-ascii?Q?8Hwu/52avS/0vfZVWU2dJI/7WWlKydzl+xtLVv/AEZ8FAa4NwhjWVPKi9eEr?=
 =?us-ascii?Q?swVwp9OSrDN2J2epzzGsCTHtvt++nhAH7imsnQjvt1KWvw177ltEDOxgv/RM?=
 =?us-ascii?Q?coA0HA4sXBGswXVFjJbbyxLZBqAsU42Hnxbju00EnUze+wD90BuD6WFIAWYj?=
 =?us-ascii?Q?Z6EFPaN5CRDn89W/Gz03yxp7D7SDlPCdIXs35zb7DzFodKSxUPSKjzE62ZA5?=
 =?us-ascii?Q?8sCOAn+Kc6ui3zOtpfwDMIDYFi2zH2/CNCI9dgLIoWWu6h+wgmNA4l1QujbE?=
 =?us-ascii?Q?cdtL+DR02VnfcImvVqUkQSpIS7k0vVjcGi/ELASZZ6U/wK3ZYupxX/gBDbyY?=
 =?us-ascii?Q?281qGZ+cLX9rGqyvTvrorDHQC/Euul93jEfFTWLM3e6AFwFzKdgGghs7i++u?=
 =?us-ascii?Q?FUSOqKa3tJwu48LCqrOzTkRI+s/VL+SqGltOK466kkOg9fDvgsOY9E6lpgXt?=
 =?us-ascii?Q?z9ZqjtP9YA8xR7ZVVnHkD2rQttX/TNA1BiL3eYC+/gjO9mddwg9TSM7DtF3Y?=
 =?us-ascii?Q?JiNl81iWo6ncI+zDUq4Q5gqbEVyMyVer9p8w3Wlulfho60LO22goaYQNyEic?=
 =?us-ascii?Q?iiT58+8D3GNKTqFzNgZvlP9TT2890wuYIINI7vOBrVyoFOY8sDvt94P6gxnS?=
 =?us-ascii?Q?i+Cvis52udEyDK8SjzG35XhfTGG5FmP6W+UhYyjJRmhCizHFOtcqndR9UnQT?=
 =?us-ascii?Q?DY+W39qufWn4JdT4jaA0c9de1Suf2JLfx8tdrmwASqIEtO5EUWv94LYmO6oi?=
 =?us-ascii?Q?BFytAW/iAFQ22ZwrtExuYCZPUlsZdzeATqjS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:25.5944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa48ac5-7932-4161-3e34-08ddb52c5a67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
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

There no need to save the ring ptrs.  Just reset them.
This cleans up a conditional in the resume code.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 27 +++++++++-----------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 6843c2c3d71f5..b9498697ef41c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -528,13 +528,12 @@ static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
  *
  * @adev: amdgpu_device pointer
  * @i: instance
- * @restore: used to restore wptr when restart
  *
- * Set up the gfx DMA ring buffers and enable them. On restart, we will restore wptr and rptr.
+ * Set up the gfx DMA ring buffers and enable them.
  * Return 0 for success.
  */
 
-static int sdma_v5_2_gfx_resume_instance(struct amdgpu_device *adev, int i, bool restore)
+static int sdma_v5_2_gfx_resume_instance(struct amdgpu_device *adev, int i)
 {
 	struct amdgpu_ring *ring;
 	u32 rb_cntl, ib_cntl;
@@ -562,17 +561,10 @@ static int sdma_v5_2_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
 
 	/* Initialize the ring buffer's read and write pointers */
-	if (restore) {
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), lower_32_bits(ring->wptr << 2));
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), upper_32_bits(ring->wptr << 2));
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr << 2));
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
-	} else {
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), 0);
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), 0);
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), 0);
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), 0);
-	}
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), 0);
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), 0);
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), 0);
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), 0);
 
 	/* setup the wptr shadow polling */
 	wptr_gpu_addr = ring->wptr_gpu_addr;
@@ -599,8 +591,7 @@ static int sdma_v5_2_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE), ring->gpu_addr >> 8);
 	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE_HI), ring->gpu_addr >> 40);
 
-	if (!restore)
-		ring->wptr = 0;
+	ring->wptr = 0;
 
 	/* before programing wptr to a less value, need set minor_ptr_update first */
 	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
@@ -698,7 +689,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 	int i, r;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-		r = sdma_v5_2_gfx_resume_instance(adev, i, false);
+		r = sdma_v5_2_gfx_resume_instance(adev, i);
 		if (r)
 			return r;
 	}
@@ -1531,7 +1522,7 @@ static int sdma_v5_2_restore_queue(struct amdgpu_ring *ring)
 	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
 	WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), freeze);
 
-	r = sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
+	r = sdma_v5_2_gfx_resume_instance(adev, inst_id);
 
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
-- 
2.50.0

