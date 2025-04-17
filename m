Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCB5C369C9
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 19:30:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1ED010E3AD;
	Thu, 17 Apr 2025 19:30:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w8aZ8S/p";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 916DF10E3AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 19:30:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyDnTwXC5MNZBLquAiu05rOX84OMV43nX435h6F1K/DSJCJyvgqnE9vEQqSiNbSkzEu3tBqB2BX3en4WWXxl9ibSlAG2LhsBNwr4JQxg/kM8LRMRVtJLCr9UpRJqWzanUP/y7g1hDmlcUWU/nR7JMLDfS/VXq0ESeoDp0By9pAAayd/VIDc2W6kL2zOuj2VUSMYkYkLQAYsN3epYoJiIwvf51Y5AygCIym9abkvKo39SwNgpZ8kLXvArtLMYuwEIWtlNPGIfo/UYonSYFzK3hs+G93atJs6gfo7Vh4V1Wp/WfEUdaTovK1nWGedGWaoBaAWSRdRivhfJmeafCzv9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UH/GfFVcjCALIAz2C4dptvZHR19Tm3O/JbMJP90fjzA=;
 b=m376WxVdA73VjRzl/Ty6bQzxT2iUu5RXe7bsyztYrvitKd4pcfnJ+d5/k9y8m44rWwO/tQOy8k+WvMyy81trzwG9Dfcv5v0uzttBWsKFRl0jQYaPJdQy/w+fOoZFJKhqtsYmIlUNGg7RzvwaGT8M0gdNEWwNAgQrXWBMHZma8rJwByxp/eHfwMPyFOzOW+p308VIeKfwlmPdNfCV84ej+y3bNd4WPYtc6ASe+1YY6kMPnk23MQ34VdpQXvNFdKsbDKG+NKkVuvzLR0WTO7WcTU21eUvSA7zgxwSGJsVYbvJ6Ji3qlUtv+VIWq6xfEaS0/bJ4GeooN7jwLODSOu88eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UH/GfFVcjCALIAz2C4dptvZHR19Tm3O/JbMJP90fjzA=;
 b=w8aZ8S/pbqauuEGcYLBHuLLeP4dtXodwea6s9GE7mtpsFFeyfAAx1zDFaufTEvyObOmzWRkw+kFGuoKy8IxQaD5ygmq3jVlphUKaT71LDT4nk2rZSSYvLgVOjqP95neB0TIW0aNSIOyu/+qRAapY6dhN9JFMqNEJjunbZFXlZoU=
Received: from SJ0PR03CA0218.namprd03.prod.outlook.com (2603:10b6:a03:39f::13)
 by CH3PR12MB8910.namprd12.prod.outlook.com (2603:10b6:610:179::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 19:30:43 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::d) by SJ0PR03CA0218.outlook.office365.com
 (2603:10b6:a03:39f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Thu,
 17 Apr 2025 19:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 19:30:42 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Apr 2025 14:30:39 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, 
 Tom Chung <chiahsuan.chung@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH] drm/amd/display: Add NULL pointer checks in
 dm_force_atomic_commit()
Date: Fri, 18 Apr 2025 01:00:26 +0530
Message-ID: <20250417193026.3760783-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|CH3PR12MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: 583ce7ab-1335-48fe-f534-08dd7de657e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?arsFv5+DdiHky7CDwLXSb+A1E9Df9VjllCO4Z7XtwGCxVwKSWL+FY65L/Ix7?=
 =?us-ascii?Q?yAJrqxJEmucKjcdTSZaZbGDkWX977rF1F7XLOt7+i7Fey9l1b+lrk4NhqZY0?=
 =?us-ascii?Q?44kui2FXbAO0wfijcgD5JHyPtNkSDwwxEtgSORa5JKo/G0m8Nrc3hEe7bj2y?=
 =?us-ascii?Q?Ps+OIk8OJIW0/iNZ0jIISm6hB6iBXwMD1lrSc7h/Z04hjfSVLpGJBRVCzBrk?=
 =?us-ascii?Q?BzgWLwnA4Lz7K2U3NGxJ8Zy2tLuH1SHNDqTsVsNaYQgAcSL9G+I4+AMg4ddC?=
 =?us-ascii?Q?rzUoLnDEXk0L5ZjBX6+vCRlIHqpUkYR/8rdseX8L5qVMm2rAC9shpNh0ZsSK?=
 =?us-ascii?Q?RZIRZbmoVWuckxAb2Ke67o9AHJXdSg/+wM7flfhW61YwUrk6WQHyQDIJBTy+?=
 =?us-ascii?Q?F5D+sarTpOQIMXo/3PebDIEpyjG6b+liXnC8rTkMdk2D9BG8yvn5SM2whGBA?=
 =?us-ascii?Q?6BFEGIFaqAv6VVfxqcTJcxvAO3AAqb+gIlxfFEFRjualllKrdplzRlcMdGMk?=
 =?us-ascii?Q?dzfLOADZNo0wkal7ewRXz5VPBSqfIKOWYEoNvobJJ+RDZsa7b827vXiiuXDu?=
 =?us-ascii?Q?VxFbz6LO091bAVrf4rTWf564Ayoh/d1LFn7rHP2KehT4Ij1AGCAwXf/zHLRg?=
 =?us-ascii?Q?b2o/4pK7IW7tjIkGh5CAme24amAskjEaPyUbXecthc43aPwpVCOmaCMA7m8q?=
 =?us-ascii?Q?dUj6atsofeDwQ0e8ElN3Yed/l2YFV3FUvk5qnAq0MfzJnK0KXyn/yb0s+D/1?=
 =?us-ascii?Q?BwVdHiKs817fmj1G7Qvjd+OAU8vdtO5nLXNh5HvxQOkuauLW3XlPyMGxvIjJ?=
 =?us-ascii?Q?PoFbypmHKwFsbabCRfr7pf+FYXOZq43c/52THqJ+6WqXIF/EgqsPaWU/Acor?=
 =?us-ascii?Q?MeYbWzqNIPqqV67H3IhoWnwDnZhY9cjgknLZqYGSEYVSkJOb5O1WSvidnJtT?=
 =?us-ascii?Q?rXiPUQId0c8Yo+9Onu9lvW056RHe+hSvcgWDajGt/0F2jOdNKVg0cJlzmFpQ?=
 =?us-ascii?Q?MeYMDGo50ORXJB46LLIqcxy9z3DK3RJTBD33y8jBPjZ+Dh7IeQNYrsJc5M3m?=
 =?us-ascii?Q?1mQg7nHFmvVlQNdsb/ewx0i/NP4HPuYRVALzedg5vMza/Oi/ibhx6KujyFfy?=
 =?us-ascii?Q?qHmYzUEtF79Y/IO7OBvnm1qKBiKFZigtUoLjfikRJzDVyxaeH7aMcDG3mShw?=
 =?us-ascii?Q?jJCMXOD9A+7Xpz7fDzivP+qTB/ljiiO9tWCJ/f66fiqab/PWfEfG5DB9MLS9?=
 =?us-ascii?Q?oSxYGNiy4h3cnsw9ausB1fxmnVjsXFxzy5xBBISQ5qHaXFMc/W4KtGKtm6mX?=
 =?us-ascii?Q?OcDdXeN41Ww9pOQtt4BjRgdVzEXuKJJffr3Kb64o69nu7N3LS7NNOYF14hLx?=
 =?us-ascii?Q?q0rxzEk7hLSvFjqrEYVG7oYSI7zJZ4F3R9UBClUC9hJ3jHB15nPmQFsZU8jg?=
 =?us-ascii?Q?43uw7/Vr8lfhg/dz9QjfuLIlHNC0viFVBZPeU0Md9Fwi9mU8p2gUdkoWK14Y?=
 =?us-ascii?Q?qpBL/C80CBX2/8yLQa1/z16xsGkO6EQt3J58?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 19:30:42.5259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 583ce7ab-1335-48fe-f534-08dd7de657e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8910
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

This commit updates the dm_force_atomic_commit function to replace the
usage of PTR_ERR_OR_ZERO with IS_ERR for checking error states after
retrieving the Connector (drm_atomic_get_connector_state), CRTC
(drm_atomic_get_crtc_state), and Plane (drm_atomic_get_plane_state)
states.

The function utilized PTR_ERR_OR_ZERO for error checking. However, this
approach is inappropriate in this context because the respective
functions do not return NULL; they return pointers that encode errors.

This change ensures that error pointers are properly checked using
IS_ERR before attempting to dereference.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 012ff8332dd2..4a31d99da505 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10621,16 +10621,20 @@ static int dm_force_atomic_commit(struct drm_connector *connector)
 	 */
 	conn_state = drm_atomic_get_connector_state(state, connector);
 
-	ret = PTR_ERR_OR_ZERO(conn_state);
-	if (ret)
+	/* Check for error in getting connector state */
+	if (IS_ERR(conn_state)) {
+		ret = PTR_ERR(conn_state);
 		goto out;
+	}
 
 	/* Attach crtc to drm_atomic_state*/
 	crtc_state = drm_atomic_get_crtc_state(state, &disconnected_acrtc->base);
 
-	ret = PTR_ERR_OR_ZERO(crtc_state);
-	if (ret)
+	/* Check for error in getting crtc state */
+	if (IS_ERR(crtc_state)) {
+		ret = PTR_ERR(crtc_state);
 		goto out;
+	}
 
 	/* force a restore */
 	crtc_state->mode_changed = true;
@@ -10638,9 +10642,11 @@ static int dm_force_atomic_commit(struct drm_connector *connector)
 	/* Attach plane to drm_atomic_state */
 	plane_state = drm_atomic_get_plane_state(state, plane);
 
-	ret = PTR_ERR_OR_ZERO(plane_state);
-	if (ret)
+	/* Check for error in getting plane state */
+	if (IS_ERR(plane_state)) {
+		ret = PTR_ERR(plane_state);
 		goto out;
+	}
 
 	/* Call commit internally with the state we just constructed */
 	ret = drm_atomic_commit(state);
-- 
2.34.1

