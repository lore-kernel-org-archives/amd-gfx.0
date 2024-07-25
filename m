Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F49C52D1D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D35DC10E859;
	Thu, 25 Jul 2024 15:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gpTOJxI2";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54D4410E854
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inZK5+YjHNKdt7n5j1nQZ8IakqFm4nPOFCg38pRSaHRljT/0okaPcO8DqvHuii3ahAb6n8zWT06WNaxdeMbe4mX5lGddDWbLo0oz2ftk3WFimfupJtkqUUxJwvQFq66DjoEIBdRmv3fH5m3PtfikpXvSOZoru2pU3MpaWALalYKMD+ZWVMQm1KVAD6VVborxAbvIi/bGh5IbeHF3qQli5tRKb2iGaJCZov1u6ddhew8We0qP5L+RwEi6SZYuS73PD1Gr3/DoLUe/SEEK2K2kc9E4s2z3CBK8foBzvXCduYhEJlT+wO5tuJneLuWbxiweIeK764YFahwKjHIHRwAHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grd5C5IyasCSrrFYgk2yr0NclBX/RDs+hD+Vbls3vpw=;
 b=spIc86e7SQALtzVuJ0em3tHDryUydHXPBufHCs8jnQtygVTFhCBVjk1HNE+jJ4FfghxB0beroCm9pTCam3hXUV7SJ7Ww30p5K1XLXCjZtOPxwIQOaUkfoFx81rz+BZA5Krjn/CEg4Ytvr0YFpglJjfGtFIk5zcw3V77FdKZvPaY43lHAVBE2+ZWk3u5U5laOqnhFcQU+By7WrblXgcDx6ijhLi6h65ytF3fKlJhLQdWaCwEMIjCFC9+AN9IthdQ6Df2B++HWtyWh5C6KzEe96g1E+ho2o/7OocrhJEUNqzE2FjG6uu1KzcO2uHWLrJIoQtChTU/J1y/nleDXVGkzXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grd5C5IyasCSrrFYgk2yr0NclBX/RDs+hD+Vbls3vpw=;
 b=gpTOJxI29SHY1XN7AqIYvVxNJPGDoKiVgxpl5Mzt+wid7mEPp3NWHwvcFgacNK5kCcJdpN5v5HykPvWu0hfMWOwVueXvLnCyXE8ORZRwvsHJsv/ltwAxDdSM4ZXuWwMNutEC4hQRU5q8xHnuT4kgVDmFq3arFg6geuXjnHadppI=
Received: from PH7P220CA0047.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::6)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 15:01:23 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::79) by PH7P220CA0047.outlook.office365.com
 (2603:10b6:510:32b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 19/53] drm/amdgpu/gfx10: rework reset sequence
Date: Thu, 25 Jul 2024 11:00:21 -0400
Message-ID: <20240725150055.1991893-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: b38b9cdc-3d3a-404d-158b-08dcacbaa618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OyruGPah0zJ+8iUvH/Xyfep+PDcMMrvmFpjGOyGaAuITLLIRIGXuCFlBeIjs?=
 =?us-ascii?Q?bAJtH0TY9+DWoM5E9bzAqUOLXwmXM/Pc7HPETizW/VpzLVzWrEGlEnoaqUNQ?=
 =?us-ascii?Q?SRAyRFalTVaSIyFSaeKKzSYyfVxQKNBKMNo/DYEmQFDNOiI0BkMP9ISE4vzQ?=
 =?us-ascii?Q?IYwUz6LI3b62s56MC+yYnY/dwOzj1giD7qqSZsDlTaHeyfewPYIuoYO3BjBG?=
 =?us-ascii?Q?F5EZtS2QtYrKuBP9glcLqYcFBYaoMBxp/bqSoSOjRoiOKXOnA1F0FbIWxNiO?=
 =?us-ascii?Q?2jlUVvq8+HfXP2TbXA92Qdu3GkBafZ3jg/hDMrNljkIWefIZib2cRtpX7gBj?=
 =?us-ascii?Q?M7jG6rV/pEBG/E+l4OwZKiXk5Ww3tm72rkgh+BpR69wJpcxb+4BJIf64mDuM?=
 =?us-ascii?Q?/A0lMb2qPq2QAMVIM+zRnNtrRZeP+7VKPyiwY81uCXkOomXM4iti1R5A0rzG?=
 =?us-ascii?Q?epd2qINN9hpESOBOvkMkxvq8bqIfg+yPabkSAEh0Wk2KfHMKIk2MFSFXTP/g?=
 =?us-ascii?Q?HwYRu16qYNwzqjm7lS7j6VFY0bEEe6tlLPZd5KYgOE3GhIBvA7OapQBuDbNb?=
 =?us-ascii?Q?WKwFfUINmLL04kN1V0xJLRqaREs5VaIkyByvD5mCBnfAJhgP92AN2pcChDVh?=
 =?us-ascii?Q?fguizVt23Vc91AYzFBN0artyBcX75A7trvEf8CFvHiSwGn8HRhFgPBbaQ3Vt?=
 =?us-ascii?Q?4gz8sf/KC8J+UV8VO11aH+LhUUgixH8zo82cKqASyLIcEVb6psV42VZvxyR0?=
 =?us-ascii?Q?VzRkajbxV0TN4KFCNCpRkujnnWvGts96qMv7qcb9NaU5ZMAG6wr3AmJk1ufn?=
 =?us-ascii?Q?89FKeBShxUMOWBUgLbDfhIUmIKSRsR9xes1TzK/OyEG1S9cnWZ+VL5hDI++Y?=
 =?us-ascii?Q?mW9vi/inA+fBJeGh5b0tt3aFS9GLQ7wa8uqDBDN2tD3vIeoYHeDPRmA4lhlx?=
 =?us-ascii?Q?iH6ygGOP0MDDJ79fa0ZsXT4B/TvGSzmJyprfzWJtesd7FplcUu5Yfw8IbR28?=
 =?us-ascii?Q?iCZRaMWzaMfnJhLAVXfvfIVhMR0HMCHyuJIzOXYnblKxm2kdmyyn/MaKP0FD?=
 =?us-ascii?Q?hBNpNnM/nYpdp30dAIgPPbIMKUQKLZVCygHFHJvmdu/1OBNow5+Ek6Ilz19b?=
 =?us-ascii?Q?LIV6wYfGqtNeJ420hqYHEyCzJaJfP8hy0vjFKxLmh5pkd0WcWoxHmdoM8FhR?=
 =?us-ascii?Q?TQ+ZcFt9gsFHYelkTGYI7IhPISLrqUCmm3Mh0ZWE0QOzmeDsvTyayy6WSug5?=
 =?us-ascii?Q?gJ9gJdyY6qqcZq4Gfz/En3x3zqx1YqJ5InSZUnilSFTPgVgI+kpv4LAQTYhL?=
 =?us-ascii?Q?xjNtVlY7fNBSMrxNN4Ow6QV+OWctnxHlKBlchvUljCEWjH3koT3KES8HXRe+?=
 =?us-ascii?Q?kjyHusmW99ghC+8FihfuCmu0h+aRzTUiENR0HpcNN0Es2uZkRdgeObp+UyZ+?=
 =?us-ascii?Q?OG37Bk/Ac3iMBIls1oGfgXfyK+OQmrVA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:22.8539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b38b9cdc-3d3a-404d-158b-08dcacbaa618
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
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

To match other GFX IPs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 7b534966a297..0c12ea47c79a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6748,13 +6748,13 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
-static int gfx_v10_0_gfx_init_queue(struct amdgpu_ring *ring)
+static int gfx_v10_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v10_gfx_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.gfx_ring[0];
 
-	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
+	if (!reset && !amdgpu_in_reset(adev) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -6806,7 +6806,7 @@ static int gfx_v10_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 
 		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 		if (!r) {
-			r = gfx_v10_0_gfx_init_queue(ring);
+			r = gfx_v10_0_kgq_init_queue(ring, false);
 			amdgpu_bo_kunmap(ring->mqd_obj);
 			ring->mqd_ptr = NULL;
 		}
@@ -9498,10 +9498,22 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	if (r)
 		return r;
 
-	/* reset the ring */
-	ring->wptr = 0;
-	*ring->wptr_cpu_addr = 0;
-	amdgpu_ring_clear_ring(ring);
+	r = amdgpu_bo_reserve(ring->mqd_obj, false);
+	if (unlikely(r != 0)){
+		DRM_ERROR("fail to resv mqd_obj\n");
+		return r;
+	}
+	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
+	if (!r) {
+		r = gfx_v10_0_kgq_init_queue(ring, true);
+		amdgpu_bo_kunmap(ring->mqd_obj);
+		ring->mqd_ptr = NULL;
+	}
+	amdgpu_bo_unreserve(ring->mqd_obj);
+	if (r){
+		DRM_ERROR("fail to unresv mqd_obj\n");
+		return r;
+	}
 
 	return amdgpu_ring_test_ring(ring);
 }
-- 
2.45.2

