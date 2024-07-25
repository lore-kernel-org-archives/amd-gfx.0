Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DDBC3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:03:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C0010E303;
	Thu, 25 Jul 2024 18:03:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hDEhBPt4";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF58E10E2F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:03:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQ8cWEZwOmP4Uvj44YxfB3NRGy4w2yxvI0R3O2SI5/SmDt1rC+C6pf62gXT53L3XPtRlxtUOONiFA/ApHA9VQ4gWKiatzUXSBAEZ7ha03ZnJjayhamZX1c8BVrvX2jjdVdz/25vR51GkYCSKnvZMt3O4djJK1HLezQMVbp83Ti5XSWOYH6RwKmbrsOQSYg1cY+t71O0OowNjtbPJeg7U1YfyFk/UnBixkyUpMh3cMQHCZ7C9/Pq1zUMeNHPtiClYjNuLhA/P1GqvvnkoqsfQBVNUtNgCDNxOknydlzlAl+53BOA0LM/hJHfV2j+HMxv1/Xvh1Bdendp+bhu8/Ol7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdVbrhFVwJkTK2cqXa+kMNjo7SkQFkVlRh3+5J6CTBY=;
 b=KCsJOLruJA1lEI5T81cBZPpiAg57gQvpevt6ITsz3xOoEQoRLSz8jtufhN5+OdvaRLglDZaRShdr/xm5r+t0rjwvCI+MF/t8epgCrw+mqvHUQzfeAAVTjq9kVYk7biePGC26qIg6hRMAyySbBpHORgrHjoguxT7y5l28mlTQskdDo3iIaM/AEjutf0qHcJ9Pz26PxLYUlZ2bNi7zzJOF8W5l9FA+5u1FxUW/43flddqzoN2H/mMK5Ujfp0VgLntXYpDkTjp1wnKDm/pAmZQgbyouKbavPOoglvzwJrvq8CgA5yjmmxfM67viy0knA1OTbVUAYLdkmzpbtq6sN41QNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdVbrhFVwJkTK2cqXa+kMNjo7SkQFkVlRh3+5J6CTBY=;
 b=hDEhBPt4tlG8ZyZXoCMmVS8KqYEsJSy8BCGkiBhjxGucpYEHmVAui1i8Oxxi+hai8GE0PSI7wKLzijw1YwBTMq0hRgsVD3dZoVnA6Kaq3/kopLAtikZ6QEo0544YMgsXqObmRm8kYOec1+LFkLQa+NnITOXjk7fwOOqkYTwP/v0=
Received: from CH0PR03CA0366.namprd03.prod.outlook.com (2603:10b6:610:119::12)
 by DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.20; Thu, 25 Jul 2024 18:03:39 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::42) by CH0PR03CA0366.outlook.office365.com
 (2603:10b6:610:119::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 18:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:03:39 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:03:36 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 02/39] drm/amd/display: Let drm_crtc_vblank_on/off manage
 interrupts
Date: Thu, 25 Jul 2024 12:00:46 -0600
Message-ID: <20240725180309.105968-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DS7PR12MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc99a51-e99f-4240-4233-08dcacd41ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gJlKw75K0bVdjqTA1zef4kCtqTAHQmGMrIWb3xU8YU8dJxVrqLBaQJD2GxVD?=
 =?us-ascii?Q?ICoxlLITHU/H33KD5MoyNdrPG4ihZXZ3jJSgOhgVp+kglnKiWD3fYyhwn9P8?=
 =?us-ascii?Q?szBm+6WMjGHilbcUUcG7JtYj7caNayk2EGHAzIr6m1B8pz0a55HxKYdqyxTa?=
 =?us-ascii?Q?GBslByMLqXTGqK8aFwq9hD4grFQgKwOB9m6lHIJGIhSp17tFl7MH7/xhpJwZ?=
 =?us-ascii?Q?pUKyMvCImoNo9j5/tWPzQrQ1Zt1taSzWR03zXv9vE4e7tg+nFYLJOaTjpopx?=
 =?us-ascii?Q?pQvqxUXgk8winxhUYfLhgT7TB7R8qU4WJNxXO+dw/WuBNd4gS6JqHax5xifz?=
 =?us-ascii?Q?hfckHxf0DXAOyftG2c02u7HWk0rEpcZEHfsFn4BQruoAzuhCwNcPYFSQsd+O?=
 =?us-ascii?Q?zw2aDUcZfK3GuitapRD8HnpAzyQjX3nE6LMyypv/Zg8mxiI+35Zd/d9zeLcx?=
 =?us-ascii?Q?zvPuzaKXUdyu0l4GmAlgB8b34IDquP105dyCZyjpcfybsmETVYx3PQnEtV9w?=
 =?us-ascii?Q?c8G16U6cEJEVGaGSTEqay/62q7mkIhS6Kucg1UtS2Nae54I6uZtCQxnayD+8?=
 =?us-ascii?Q?VDhXfUcfD4YAium5r4wVJBGI3rv0/ES2KVSjdgpMrwfizhC512QrYMEm54n8?=
 =?us-ascii?Q?89oDPmhrAjP0K+E+p30ulqflM2FWlNkllwLzAG3KGt8/tZvGLRQQl7HoCh5b?=
 =?us-ascii?Q?y1F/GfYG8UOYwmU6WO+bEPo8NTisGYErQAan1Em89k/MTHYmZVRT4xR90vdV?=
 =?us-ascii?Q?Qdgibmpp0OrGA05sb6dVg9a+Wao4XwQcrIQDkoRMtPtzLxpIrG6qJKhIYKYk?=
 =?us-ascii?Q?hx2O34j0lXZNA+liSrnKhQPPNOeb155+iAxE/FcqJ8eJ/LQ9cC3jdTF/vbLr?=
 =?us-ascii?Q?uBnbeLp6q+oRGAFmX74ArymPYNINXDAD99yjLHuyO25PTjKIQseDiqkFwYaw?=
 =?us-ascii?Q?lPmAyywxkwk4wsUO+5h8s9q9dgL6VaApKoKHqXMQwVLkSAgfQb7/lf0LcINO?=
 =?us-ascii?Q?Nx0ipzdljrLALGEKSCfWEqQ4mf9ONG42M37vd+LF8YQoNmzcfZF3TIWUtvoY?=
 =?us-ascii?Q?J0MV3aA1G2I9iMUTeg4v6r9o0TEZFW4TQXtEQ05Fe369p5lQDYm1CzHuoApw?=
 =?us-ascii?Q?5qcadODH8IRpLbYKTPYmH5M5bPznhCEX1Mdp5Stf0JRF4J/EjgWQ6NqibFiT?=
 =?us-ascii?Q?n6Wz+xhO9iFu2ModSblCwQHikSIfjn00LSK01YME4MSEKl44ACygGfEhu9Zu?=
 =?us-ascii?Q?Ex4ey7cNigG1koNSdyhzBxaV3OupKK7Gv/h6LA0X/Ut3y1jTplRsL7IsRH1H?=
 =?us-ascii?Q?oM3YU2I/UKNeYZL7DAXJqPWQO8U9O5KpQy9UVGEkv2gbM4NIoBxU2UlUkw6w?=
 =?us-ascii?Q?h2PAztlHrmvKfhktoZr/Un7rgQbepOqAtFrtywFpCGRCFYa0iyaSbfGhOgel?=
 =?us-ascii?Q?oy0qpymgwzfj0rWJuCBKTPj/7Tg4quir?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:03:39.0864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc99a51-e99f-4240-4233-08dcacd41ca2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6048
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

From: Leo Li <sunpeng.li@amd.com>

[Why]
We manage interrupts for CRTCs in two places:
1. In manage_dm_interrupts(), when CRTC get enabled or disabled
2. When drm_vblank_get/put() starts or kills the vblank counter, calling
   into amdgpu_dm_crtc_set_vblank()

The interrupts managed by these twp places should be identical.

[How]
Since manage_dm_interrupts() already use drm_crtc_vblank_on/off(), just
move all CRTC interrupt management into amdgpu_dm_crtc_set_vblank().

This has the added benefit of disabling all CRTC and HUBP interrupts
when there are no vblank requestors.

Note that there is a TODO item - unchanged from when it was first
introduced - to properly identify the HUBP instance from the OTG
instance, rather than just assume direct mapping.

Signed-off-by: Leo Li <sunpeng.li@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 36 +-------------
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 48 +++++++++++++++++--
 2 files changed, 47 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1a8fc566e24d..4d36a66917c6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8246,42 +8246,10 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 				 struct amdgpu_crtc *acrtc,
 				 bool enable)
 {
-	/*
-	 * We have no guarantee that the frontend index maps to the same
-	 * backend index - some even map to more than one.
-	 *
-	 * TODO: Use a different interrupt or check DC itself for the mapping.
-	 */
-	int irq_type =
-		amdgpu_display_crtc_idx_to_irq_type(
-			adev,
-			acrtc->crtc_id);
-
-	if (enable) {
+	if (enable)
 		drm_crtc_vblank_on(&acrtc->base);
-		amdgpu_irq_get(
-			adev,
-			&adev->pageflip_irq,
-			irq_type);
-#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-		amdgpu_irq_get(
-			adev,
-			&adev->vline0_irq,
-			irq_type);
-#endif
-	} else {
-#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-		amdgpu_irq_put(
-			adev,
-			&adev->vline0_irq,
-			irq_type);
-#endif
-		amdgpu_irq_put(
-			adev,
-			&adev->pageflip_irq,
-			irq_type);
+	else
 		drm_crtc_vblank_off(&acrtc->base);
-	}
 }
 
 static void dm_update_pflip_irq_state(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 99014339aaa3..1fe038616d9f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -286,11 +286,14 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
 	struct amdgpu_display_manager *dm = &adev->dm;
 	struct vblank_control_work *work;
+	int irq_type;
 	int rc = 0;
 
 	if (acrtc->otg_inst == -1)
 		goto skip;
 
+	irq_type = amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
+
 	if (enable) {
 		/* vblank irq on -> Only need vupdate irq in vrr mode */
 		if (amdgpu_dm_crtc_vrr_active(acrtc_state))
@@ -303,13 +306,52 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 	if (rc)
 		return rc;
 
-	rc = (enable)
-		? amdgpu_irq_get(adev, &adev->crtc_irq, acrtc->crtc_id)
-		: amdgpu_irq_put(adev, &adev->crtc_irq, acrtc->crtc_id);
+	/* crtc vblank or vstartup interrupt */
+	if (enable) {
+		rc = amdgpu_irq_get(adev, &adev->crtc_irq, irq_type);
+		drm_dbg_vbl(crtc->dev, "Get crtc_irq ret=%d\n", rc);
+	} else {
+		rc = amdgpu_irq_put(adev, &adev->crtc_irq, irq_type);
+		drm_dbg_vbl(crtc->dev, "Put crtc_irq ret=%d\n", rc);
+	}
 
 	if (rc)
 		return rc;
 
+	/*
+	 * hubp surface flip interrupt
+	 *
+	 * We have no guarantee that the frontend index maps to the same
+	 * backend index - some even map to more than one.
+	 *
+	 * TODO: Use a different interrupt or check DC itself for the mapping.
+	 */
+	if (enable) {
+		rc = amdgpu_irq_get(adev, &adev->pageflip_irq, irq_type);
+		drm_dbg_vbl(crtc->dev, "Get pageflip_irq ret=%d\n", rc);
+	} else {
+		rc = amdgpu_irq_put(adev, &adev->pageflip_irq, irq_type);
+		drm_dbg_vbl(crtc->dev, "Put pageflip_irq ret=%d\n", rc);
+	}
+
+	if (rc)
+		return rc;
+
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+	/* crtc vline0 interrupt, only available on DCN+ */
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) != 0) {
+		if (enable) {
+			rc = amdgpu_irq_get(adev, &adev->vline0_irq, irq_type);
+			drm_dbg_vbl(crtc->dev, "Get vline0_irq ret=%d\n", rc);
+		} else {
+			rc = amdgpu_irq_put(adev, &adev->vline0_irq, irq_type);
+			drm_dbg_vbl(crtc->dev, "Put vline0_irq ret=%d\n", rc);
+		}
+
+		if (rc)
+			return rc;
+	}
+#endif
 skip:
 	if (amdgpu_in_reset(adev))
 		return 0;
-- 
2.43.0

