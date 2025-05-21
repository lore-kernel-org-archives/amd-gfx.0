Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15940C54E90
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 20:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2B4610E029;
	Wed, 21 May 2025 20:11:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qrCNxFWw";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6668F10E029
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 20:11:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piMtXyCDy+nZBKbavblR53QQI5GJAQcz2I7jtUYNzuGogqMQr8/PahKkXmZo/KZLrD78OHydnY949pI1g8bIrEJoREb7BSVgYuCjhrnvOql5RREMOUT20cwd+vOX7dsHFoghuVJP9iHuSfjxM+XfM59KDEdM4IN1f6zQ8NAEFio0K0DHG+UbEPU0Pxyr6+kr26En5PzfOehJ6btVFP3KQihQkgEr+hCClDeoOA0//MLh1g53jsHjDJpaFkrwWtN9JTAppB1MU8btaW+KgZnk/bsoQgeLzEciqI2yqjcdUXQgm5yUdfGOJ7mZy32Xad5LiVNoBLNlEHvnlL/+J/ooIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzDZPL9pe43NZMjVpQ20aTeNSZQp24yq+zK4kJir3K8=;
 b=v6P0knfX1CYgkfP6FSF8UuYR0FYSp7EaSpmWEzAf1paDCYWrPXHPGEcnoG2aT4oRACEuy/KJIY/eov6iz+IJRqfZf2AgD4Un9guktAvsRlOp2Mddl254qeEeHiPSaFs5CzRev+Ha0El5tVv2h53YKtG+DaDJfREWzOdaGdVGLd1lrH0cHiLEJ9TvrN1F0MgC2whHjDrEcz6VMtyHr74h/oIxsSeG3EC3Gw2zAYXHLIda1dTaPs+xa6rDR78ct6eBjLlWVQRrTNnfG70wsr4vCvSoBBDUVyMt8eljgPbc0zEEjjNj7MmyagEw0RkXkrFOTkGJJnbwE/oQDluM+jzRTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzDZPL9pe43NZMjVpQ20aTeNSZQp24yq+zK4kJir3K8=;
 b=qrCNxFWwtxifN+x8RgiZ5YMYUbPEhoqyYdQ2DRaMjMT23otWvRY5DqT+x1IbJwHTGiVeLklRIXrvSXS3mLkPcbZon3HYmJ/I0C7f0UVuXhvzZPAOjSpxiDfNuhkX5O+P84Yw0EVXmZcN+ALL02K5vTBphFN0nvkhT1o2BsUbAsY=
Received: from SJ0PR13CA0082.namprd13.prod.outlook.com (2603:10b6:a03:2c4::27)
 by SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.35; Wed, 21 May
 2025 20:10:59 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::d7) by SJ0PR13CA0082.outlook.office365.com
 (2603:10b6:a03:2c4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.9 via Frontend Transport; Wed,
 21 May 2025 20:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 20:10:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 15:10:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 15:10:57 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 21 May 2025 15:10:57 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sunpeng.li@amd.com>, <harry.wentland@amd.com>, <alex.hung@amd.com>,
 <alexander.deucher@amd.com>, <aurabindo.pillai@amd.com>
Subject: [PATCH] Revert "drm/amd/display: more liberal vmin/vmax update for
 freesync"
Date: Wed, 21 May 2025 16:10:57 -0400
Message-ID: <20250521201057.76093-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: 03fdb32e-a660-4f0b-672f-08dd98a39a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nrUAT+qWq6YY2oYX6J6xQCKECe6yDcQJMt1D/KM5IoYxqjI7t3IOdQQNPKJP?=
 =?us-ascii?Q?rejO9DEJmuiOgEUc2W/cQXeRjMjpWYbwvNEW40nJeTNTFGufPxuytlO4vknW?=
 =?us-ascii?Q?B5snQFsWkW9rG4Q1J5/Yxw+caClH5ehafRU/FDLZlV58Zk9UIOUMAnEnMlYW?=
 =?us-ascii?Q?WpQWXgrRB6j2374KQPGVuhmoRq7OJvZBL0tPQAPkF5Ab8ifaRPDmT37xFVat?=
 =?us-ascii?Q?MUI75YYqO/NiWA/xdXDcJ4F0MDhCwXqi3opXiJ2S0TbQV0WD5C58D/tcQOlt?=
 =?us-ascii?Q?5x9sy76C+onPzWFPIctyFCyVcBxDwA1I6qfVa5muUsx9j2eAL26jyG7kGycT?=
 =?us-ascii?Q?gXZ07U4OEQFuPZ/G4qJXoPheVWeVA67dj7t2sxLGDB6wB9lxAiMQgRWckHXU?=
 =?us-ascii?Q?l7wusyuzHeraDeAitk9gnN3Yd828kmqisQmXS9GTopRpc2o9BXycizhpKB8G?=
 =?us-ascii?Q?ge6kOxR7sTiZVOyEj0rllZA6MVo15KaGA898SeC0PJo00H5UEQkhGpyTUEwe?=
 =?us-ascii?Q?tZckOUameRuX1GdkLMMWY/gHMBWfJpWoXqaz+8BeqehznT7yodf8K/7QprBo?=
 =?us-ascii?Q?25rPlFjcGPXMIO+RXCJefY2qMAfchWqAIp9gKJ2IwDCNi2mald5lsAugBImj?=
 =?us-ascii?Q?7q+2rcVp2HIzc6W88Yguj6Xgga8D1q4hYw3xubdLoc7hZLFqjQ3SVRhHooIX?=
 =?us-ascii?Q?ayCCn19jfNQavkqCeGCpU/bJ9m3zj65TGc4aNKEOENv5R/jvzNUlpgkAjhRZ?=
 =?us-ascii?Q?YVl39j1T31wQA6+cUM0TGvrAXPHOWx3nVzEiqZe9mjJnI1LPEmJfB6PfIMZl?=
 =?us-ascii?Q?ACMBl4tFU3l+VstwvcZJi9JXiZHeCZVqy9VIgzssiU8F/+Qm9Nb02d5lnLMO?=
 =?us-ascii?Q?lqUqQ2T4aCtaBLiRWyxgT8HKjp/Dy9IcHNba4BmNO+fGghirEJ9JUM5r5mE1?=
 =?us-ascii?Q?1RKqmglR8lcXm3vFMnfCoPYRE1HZCNUMqqtRs97gpJPKHKfG4ZzYaSRUtYH2?=
 =?us-ascii?Q?kjxnKNBI+CoVsB7/kMdP5VCKSEmanbydyQx1ZBJ+5mcmWidnE0R+hFhFmrnt?=
 =?us-ascii?Q?Jdh39+N/lsvx0WHNCXv8ywUttw3LKK0I3yCfkFXwq2diODMuajne7n5kCRQl?=
 =?us-ascii?Q?4/7Nlfv3B+tsZ0m2HYPaOJN8uhY604iACtfiq5rhLGcMWGp/j7O8e6kpEU7o?=
 =?us-ascii?Q?5gb1iAj5p9gpKCXYewZ7OxKzf/1ZgqwkzoPA2mF/wbOo0/OxHm9k63iDKKHq?=
 =?us-ascii?Q?+6ANCEbWRKPfgPgT+Bz54uEQItmjSXRkMZgv4e2DJsJdOSnI5QWJGyIZ/dCc?=
 =?us-ascii?Q?OKxGNTnS15z6rhCZWTjHqdkB3TroiSwjSUvGGOwJATDqqjw6KySJXkUGIgrE?=
 =?us-ascii?Q?NQte40EGXRQSoOwL0W1oxXmQg0qQnrs1RSDBWpk+KLDdrZYnHp0Q24trkvXZ?=
 =?us-ascii?Q?65KWZDt15CAQRdG9Qr2dD+k7Fm2GIn5tdchxSfgEvhoLqRBrp9mnjw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 20:10:58.6955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fdb32e-a660-4f0b-672f-08dd98a39a0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792
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

This reverts commit 219898d29c438d8ec34a5560fac4ea8f6b8d4f20 since it
causes regressions on certain configs. Revert until the issue can be
isolated and debugged.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4238
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2bb347771aa1..acb5a6baabf4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -676,21 +676,15 @@ static void dm_crtc_high_irq(void *interrupt_params)
 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
 
 	if (acrtc->dm_irq_params.stream &&
-		acrtc->dm_irq_params.vrr_params.supported) {
-		bool replay_en = acrtc->dm_irq_params.stream->link->replay_settings.replay_feature_enabled;
-		bool psr_en = acrtc->dm_irq_params.stream->link->psr_settings.psr_feature_enabled;
-		bool fs_active_var_en = acrtc->dm_irq_params.freesync_config.state == VRR_STATE_ACTIVE_VARIABLE;
-
+	    acrtc->dm_irq_params.vrr_params.supported &&
+	    acrtc->dm_irq_params.freesync_config.state ==
+		    VRR_STATE_ACTIVE_VARIABLE) {
 		mod_freesync_handle_v_update(adev->dm.freesync_module,
 					     acrtc->dm_irq_params.stream,
 					     &acrtc->dm_irq_params.vrr_params);
 
-		/* update vmin_vmax only if freesync is enabled, or only if PSR and REPLAY are disabled */
-		if (fs_active_var_en || (!fs_active_var_en && !replay_en && !psr_en)) {
-			dc_stream_adjust_vmin_vmax(adev->dm.dc,
-					acrtc->dm_irq_params.stream,
-					&acrtc->dm_irq_params.vrr_params.adjust);
-		}
+		dc_stream_adjust_vmin_vmax(adev->dm.dc, acrtc->dm_irq_params.stream,
+					   &acrtc->dm_irq_params.vrr_params.adjust);
 	}
 
 	/*
-- 
2.49.0

