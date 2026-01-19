Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A701C98315
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 05:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB92510E35F;
	Mon, 19 Jan 2026 05:35:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DMJcNxIf";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A8B210E35F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 05:35:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0JzE3PwkwsTlsSkZUqjk8mw+g0Y5ikeRp6jDCQhAU2AiN+0a/VWN7+OBbMyVgdVl4JY6c56MWZ1GeDahrj6khmv8oKRkNsI3Z1RYImppFnHW5pA24yunbweKsVVpYP19Nr/gJmN0Aa+lFWA2DZPtNS5e7bXruQ0lToXZCmndNVynZ3GMe7d9Msc7Ux5nPAy5MazcQLdiYDVMNg7plMwh2IDlEqiJZq3fK1QJ7y+TlGOZMMgbU+wjibo/dKMfIdfANooH0xPZqzzsbRtNlXnsweSMpwOGzN1lZSbqmFfpC/0XsdqtZxoHCQjXjdvUrjpq4XGoYYP5sansFzy6sTibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFOIJqLgdRseni+fh2ZtGa5fWRvvS+1gcJD6B3dg5no=;
 b=rhNDAfR6ta8zICHYEBM8iqAcrIrbtqpWvXf6JB+bVeOiv+STnVm0BdD7Eit67dP/bG0PqsMgWUrsuncknXj8RdLINkb1mO0fKt+onPbu5vEgknFajsQtaMppgnaq8QPuSzTAtWyEKj3YuubLaxtaOjds9jrhFUKgDH7hq7dqLE8O4y/RoAlgEwZAxNq7pOPD/s2FstaEg9a4EHu0RXmSYpxRT4cXCOhkFMOmGHLy1d3JTiFqqZxeGb+hvyrsV0c+QSne6UUfRwLrMqhrc7OHgZ/L6P/e/lTsUOGmG6D9U6ESqftSfY86xCgzp/vc53qRtHaiUnZu5/L1wok5KG31iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFOIJqLgdRseni+fh2ZtGa5fWRvvS+1gcJD6B3dg5no=;
 b=DMJcNxIflnyyGOwDOFg8F0hOIyGjF5bXY1sgXkGqwDCHKgwEmDAXWHL5YBLEvANbxaiGcBQ9YFqtrraWHK0nj6JQkazbraCBM9Q2DveCgaehVyOWqHUOGtczQfL4J73fxzR7NHi/6mAjSIfmuuC+LDlowDqYBF944og/F2x5z5w=
Received: from SA1PR03CA0011.namprd03.prod.outlook.com (2603:10b6:806:2d3::23)
 by IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 05:35:30 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:806:2d3:cafe::d3) by SA1PR03CA0011.outlook.office365.com
 (2603:10b6:806:2d3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Mon,
 19 Jan 2026 05:35:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 05:35:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 18 Jan
 2026 23:35:29 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 18 Jan
 2026 23:35:29 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Sun, 18 Jan 2026 23:35:23 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 2/5] drm/amdgpu/vcn4.0.3: ensure JPEG is powered on during
 VCN reset for VCN 4.0.3
Date: Mon, 19 Jan 2026 13:34:03 +0800
Message-ID: <20260119053515.893663-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260119053515.893663-1-Jesse.Zhang@amd.com>
References: <20260119053515.893663-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|IA0PR12MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1a86bc-3005-4f38-543c-08de571c8ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?frjjoG+/1xLncz71gayUGBjXQ93wEUByusSRuN4FZNpByAX4VKYYPOJFKsbx?=
 =?us-ascii?Q?cPlCzVWcz0NBtnvD0hDrQwPqAvPY8oyTgK7hYLcPBAa4YQV8ALdU+UnPlVqR?=
 =?us-ascii?Q?e9F/93vXqSJuSM4o8TyNGquC70BwaQOR48GHCKtf/VSUev+uX7xVX8Akf1fV?=
 =?us-ascii?Q?rWkxPMgeOu5vuy6Pp6IDzd0TUTiIcgoRLYgbmoVJAnBHAt8h3oKUorxSIGzm?=
 =?us-ascii?Q?dyxaF2wNsQGvw6TWl+DhxBg5Tv5PpW0wCCYIlpXqxm6VDMLho0+kCpUkmqHn?=
 =?us-ascii?Q?VK4nTR660mbRcsavYiT2Aakivq0de14Aw1ysgeLObQwutAbKf1jbQFTU9zDc?=
 =?us-ascii?Q?pUNYrbi7xagWzoDToJ8zckHiw3ijQ5vUtceAItWFKWKC3zYCHAyydKJBg6eu?=
 =?us-ascii?Q?hYHp0Kh+fqYCdf6jC/PEpVY29kkVcYPkau9jElCGBLXjnbjETszUZIKMC1pN?=
 =?us-ascii?Q?HVm8oPglr/63Mk2e5PIpatN8xuanV3jmHHlNuL3OBdZljj3HSKcHFFNZ2Ato?=
 =?us-ascii?Q?F2QQzaxdx+gWawqSsvhC4W+d7JRu3ENDN80qwpktfdkE1zBgZmhkfSfO91Vb?=
 =?us-ascii?Q?4mfWaA39qgNizuyzceG3Q8BBTn3NEtBmpG9XW5LUFdL8UdtpMYNJYkH9FAH2?=
 =?us-ascii?Q?gSF+h2217km5WCwRSgEKWEAf7VeebmX6ggdm/RE13fblwLVJs5VczqG6+1CN?=
 =?us-ascii?Q?Y36ynTBWmZDRFVdQ1CqyaeYF9j4JUQCKR/bTEm55BD7IWSjHMK8hT1z/QnzG?=
 =?us-ascii?Q?ctBdHfWLxSJVgXOQrexlw+BlnSlmxUkUTlJWLvGr1x+jZJn+genUbNqW/EcJ?=
 =?us-ascii?Q?gK6TefRiq22I3m2EQ8G0DqaUXQNz+8g9pO1RcSmH7+eNDI1AueHVdRCA2Fc6?=
 =?us-ascii?Q?9O+s3FjMuHSZKRhw5/Mrmp3pdaio2paQojr4gS9FNCo6oSq1r1V/oQQx+XTq?=
 =?us-ascii?Q?cMHcgRRc0OBGVW8h6GgyQ88TuQ07SORueM9rYOODqsxiIGuyGxNOP1QKT+ma?=
 =?us-ascii?Q?VRtYlbHdxYp2xNWy5wOtHjbekwxsKvwHa53hVRCDnxu5XjyIAQbiaTIUQmOk?=
 =?us-ascii?Q?d7ANuQ6GwD9dpCUCN6YsNYxyCuUJW07+KjUri4F2CehvADsDHLbSpEUISupc?=
 =?us-ascii?Q?2S6H57yK/Qn145D54LuXmFpwgF8t0YRJp67HCYq0VcO6UzARcyeYYjMmRVM1?=
 =?us-ascii?Q?qRNT2la6WwEdH1cDiWOiQYls9kF8WUbo8iZo+q739TrRtiuc9Hk2L8RxCO1w?=
 =?us-ascii?Q?McsOMfkc/9ESWjgIZUKK/qnCbJhfsTem7VIbxc0vvpgMBk6lRJod/z4xfIv8?=
 =?us-ascii?Q?CyUF4dPrMln1YGddAi5kK2b6DGJoohahw46eSzzEjG1pXGHogywCOURbcOT5?=
 =?us-ascii?Q?ITMGaSFWl/PkXRX9LzYDW4JAHwGLj4oawX8on/V3pomJPKpDYtbw09ajbEHL?=
 =?us-ascii?Q?kbs+4yQ6fOLH6bJp1nRNKAvV3vzxbraIv5Lq3RzzFdWBxhPk7iWutOIr3vM0?=
 =?us-ascii?Q?Lf4LDT0jwddMC3+yKfRt24U8GEhEfDnyTpVd5BbIglkfMlTOGby/nmel9Dbn?=
 =?us-ascii?Q?1VPpuBKTVYbc8wwM2vpihJg312JOPVo9fw3q55kkSv5a4+pEpqXTjcFu5Pg5?=
 =?us-ascii?Q?f+irmrMO2HeKqFhmC73wsDdpxhIFkz2WFeXoL/wWHBDAxCBIjfudBeNAfViN?=
 =?us-ascii?Q?8VNnkg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 05:35:30.1495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1a86bc-3005-4f38-543c-08de571c8ef2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304
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

Resetting VCN resets the entire tile, including JPEG hardware.
When we reset VCN, we need to ensure the JPEG block is accessible
for proper reset handling and queue recovery.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index c7f94976ce6a..78c13724a7ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1658,9 +1658,18 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	int vcn_inst;
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+	bool pg_state = false;
 
 	/* take the vcn reset mutex here because resetting VCN will reset jpeg as well */
 	mutex_lock(&vinst->engine_reset_mutex);
+	mutex_lock(&adev->jpeg.jpeg_pg_lock);
+	/* Ensure JPEG is powered on during reset if currently gated */
+	if (adev->jpeg.cur_state == AMD_PG_STATE_GATE) {
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
+						       AMD_PG_STATE_UNGATE);
+		pg_state = true;
+	}
+
 	vcn_v4_0_3_reset_jpeg_pre_helper(adev, ring->me);
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
@@ -1669,6 +1678,11 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 
 	if (r) {
 		DRM_DEV_ERROR(adev->dev, "VCN reset fail : %d\n", r);
+		/* Restore JPEG power gating state if it was originally gated */
+		if (pg_state)
+			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
+							       AMD_PG_STATE_GATE);
+		mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 		goto unlock;
 	}
 
@@ -1679,10 +1693,19 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
 
 	r = amdgpu_ring_reset_helper_end(ring, timedout_fence);
-	if (r)
+	if (r) {
+		if (pg_state)
+			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
+							       AMD_PG_STATE_GATE);
+		mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 		goto unlock;
+	}
 
 	r = vcn_v4_0_3_reset_jpeg_post_helper(adev, ring->me);
+	if (pg_state)
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
+						       AMD_PG_STATE_GATE);
+	mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 
 unlock:
 	mutex_unlock(&vinst->engine_reset_mutex);
-- 
2.49.0

