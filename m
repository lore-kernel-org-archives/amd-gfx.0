Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C13CD5BAF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 840EF10E551;
	Fri, 22 May 2026 00:21:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lSOADL9J";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013006.outbound.protection.outlook.com
 [40.93.196.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9293C10E57C
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:21:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTGl6sa7N+hKX38FvR8V1bpVxoAiw84PbsKPJKwnAeXjZGYFXMBuc/IQkBxd7zahGrzOpRDyuNGew1dXR36WIST45MwwIlytIW9kAWJFupQL/v39aPoLw7Q5G2/O8VI4W5/d3DhYOCJJu55LWOldMyAyxxKpscZ6w9qvhWnjfNEXo6rmFtXgPzv7rbPjt80FHxh/UyfMAtu1w1KP9s/HDMLDMe2OCI4QfHgm7BIiY6EdwXdM+PIt5J8BcH8FSo5VKWGpDMoq+dG9SlXkQmNxCG2I+HiRxfI2XXbNXfTcC/F05aJ3oRJKRgB9iaLxG20G6vECTVmKM6pr+DzKjzErUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKa0QkzJ0NT+lXwPtRx7Zof7WWCLLUnKviDIBzMkCNE=;
 b=MzLonjaZJcm+QSu7l3kiCn1LJwdLoxwvd/ZpQ0JAl43QH+c4HdVyfbaicWObgJRNxpkdb5OF7vb6hQV9U558Ehcj+3oT4tXTy4r+WzZ8IRe/vZSdxGBGCuodcz/HrpFV43aUvJlRDALsmt8RF3VsIHmShF/mV1+NoJ1u1tq7FI7bE/kQHUcM5NpMlML44+GoW8vfNfp4x01GTSdqNpS3l1qUruaai3g9Ob1ZJ9eRW9MnjiaAqHzEEcV/m7D0lpdXi1J1gYzOsjzDaDzLpEebQhy8PLh3Q5wD2yfSMIJd9xEly2ARCq4Mwjs+/It56eijj/4mg5uAFYBmpiqA9Ccu+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKa0QkzJ0NT+lXwPtRx7Zof7WWCLLUnKviDIBzMkCNE=;
 b=lSOADL9J+evSV60ixjhJWKRRZU+JctPLxd0NzXpSeQfeLkn9wDPppH5EVTcUysbXEy6FSIs3JC7PrsQY2OT5iXYE5Uf8pB5lfRmabya7CgQa7DrjW+xAIRlgrzjRvU7qXT6RqSE2OUpe3ds/SnTB+mrJFoQynHlF52sgQ+QP7Ps=
Received: from DS7P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::9) by
 MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Fri, 22 May 2026 00:21:31 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::40) by DS7P222CA0023.outlook.office365.com
 (2603:10b6:8:2e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 21 May
 2026 19:21:14 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 May
 2026 19:21:14 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/42] drm/amdgpu/sdma: handle pipe reset more gracefully
Date: Thu, 21 May 2026 20:20:13 -0400
Message-ID: <20260522002048.98506-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 99be8a2f-1042-44f2-4f19-08deb79812b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: UVK59EN3cLmjqwRseD3xlCM4XIXj0+7/vd0/oSBMVo+jZCbRvHW022dwsn1DYrSgobRpY0o0CTXbEp9dXoA24yohSU+LxSPXGkXmkzoXdEYEG5TTHQFnGRq0AnnW+KtHNny0a+2Cjt2gOqPhtEZCxxRHOdCY1d7nuiazZUrIJ3GqRndVy/QDNlij5p9Ev/yYhNf0x18BGcycS83ctAbuhuplPJP8yetElajKx+yYWsWkcvOXdoPCNEaEVgau2tXecKV2ouDcyK79lCNgXR2j6A5hxD/vKvR7j9vMBtyaWiP/0Qo+/iamcJPwNy0MU7LpGcuqPG14U0IojxBYzlfiaPl3SgiUB+gmFJCofzcgRM4f8OBIf1CCG24h7yTP6FfN1XHKBff7Vj78qPGrl5C5/B/nSV/oUMGExnH7MKGm1ttVjG6OAISGR0UfIm2VVS4oD9ss3VFXH20dwFmivemv4Us0s/kRNoJV4UEzFMYsXUaeXY/o1tc0/5bpg9FvH8Oi4G3zR9xWHVBA0GqqeXqc07LXj43rqO+wtjexsdZoMw+KpLnsQB7aSMvp4Wc8xT/0KJwmgdIQxlMY0axdsgXtDMdsmdKHb/BIqw/GYwSUGLtWac08OYvshl37nT/RdMNvKPPaj+xj2a3Q5/0bDZqW+NxPBd51P2ERKipI82UwHRfaOc/Eio0NZ9at4g07PceeROwN2tZ6xNnazTWH7CEJMeoSoqvrlvSY36dCIuiUzfw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l6N773Vgvipq3q2NY2IO5C7VkQUzY236A1+3duNQt8gsMqfL+buOdgm1XtGe5z7NohJbP1/AsSk7SyIEqPfP1ha4vybbOgNthKF864dB6DgwGi+0B6Sr/zsRfN6zcSus1N/DrXlQ7YblAeF1Y8dbC4PQtw7nxo86l2j03Uobb7ptkyP2brCxaqb8mdOmpo1Mo+sCyOKa3FbpXTM+3BYD9VuCfhXHNOBcBds8qouVYqVYkjKfNdR9jiHTWml0qENs6B1s5s79p/5yg6ZfSBOK2HTCI59Eb6z8d2wmw6JpKTWXHUsU1igxJPrTdiN38n10GaXwO0LClkSv9kxdjkKI5xQ9fIGRCgavfN8jEpUuoEeCupsNMrLXpo7mYExIf84vwgAQ4CyhO1NXQJ/ZGACuvvofyjhpa29u1FUXBehAOkFV2WEUeeKKDhJaS2yn+Vom
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:30.9376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99be8a2f-1042-44f2-4f19-08deb79812b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730
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

Save any unprocessed work in the queues using the
new ring helper.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index fcd81242059e6..fbac732f3e01a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -553,10 +553,11 @@ static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 			     bool caller_handles_kernel_queues)
 {
-	int ret = 0;
 	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
 	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
 	struct amdgpu_ring *page_ring = &sdma_instance->page;
+	struct amdgpu_fence *gfx_fence, *page_fence;
+	int ret = 0;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EOPNOTSUPP;
@@ -569,9 +570,14 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 		 * the reset is in progress.
 		 */
 		drm_sched_wqueue_stop(&gfx_ring->sched);
+		gfx_fence = amdgpu_ring_find_guilty_fence(gfx_ring);
+		amdgpu_ring_reset_helper_begin(gfx_ring, gfx_fence);
 
-		if (adev->sdma.has_page_queue)
+		if (adev->sdma.has_page_queue) {
 			drm_sched_wqueue_stop(&page_ring->sched);
+			page_fence = amdgpu_ring_find_guilty_fence(page_ring);
+			amdgpu_ring_reset_helper_begin(page_ring, page_fence);
+		}
 	}
 
 	if (sdma_instance->funcs->stop_kernel_queue) {
@@ -600,14 +606,19 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 		 * to be submitted to the queues after the reset is complete.
 		 */
 		if (!ret) {
-			amdgpu_fence_driver_force_completion(gfx_ring, NULL);
+			ret = amdgpu_ring_reset_helper_end(gfx_ring, gfx_fence);
+			if (ret)
+				goto unlock;
 			drm_sched_wqueue_start(&gfx_ring->sched);
 			if (adev->sdma.has_page_queue) {
-				amdgpu_fence_driver_force_completion(page_ring, NULL);
+				ret = amdgpu_ring_reset_helper_end(page_ring, page_fence);
+				if (ret)
+					goto unlock;
 				drm_sched_wqueue_start(&page_ring->sched);
 			}
 		}
 	}
+unlock:
 	mutex_unlock(&sdma_instance->engine_reset_mutex);
 
 	return ret;
-- 
2.54.0

