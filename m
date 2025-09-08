Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5CDCAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 15:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5865510E564;
	Mon,  8 Sep 2025 15:47:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V0qCPqlf";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C419C10E559
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 15:47:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spMIiscYnn7X0h06mSndIcw6e1dvcu+PUqjlMIfm+up2BfBo941dJ4FQG+ESphVGgQe0V0Q/qukP/gdPlw1wS80XKnrLgueWhK1/VIbIjQir//QjJ1Z4Ga6JiBUitGfQxH6QxW5nzuFSH78XtiHEOjxlMIwCJ5KV9TwssY7U4WqepUkcHZNE6E9Xt/2pa6IFcmZBqa35gQd97aEVp6VpvVLGsNM1pvIv6x3klj9OeANRxfrjOef5NlGCLH9wIeln1IU5RjJQhX9L5a1yKQzhRJSe+NwMxJVwtnBkav90qv3Y7OzST5Txfv4HEWxLAdyn4e3utm6WjWAhJcrnIOlDYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nypo7pOkpVcTZ4r5BMfcTTudv9leZaN8bSbQWi4dhQw=;
 b=NZa0N5RTJBYwlTDfp7gC+fsCOlXM/k6b1Uu3VIHgsfMX68Pyvp6TWHTpE1hILkFhdppQP2bmw0NBbSws2RuwVYTg/MjS7/Iu2yUCA+G+XB/2m8v4K0a/VMXiAhoMZepog+wsV7QkSwDC363kxK7M+jPDVpFgXDPTxA33lyhi+RC8vKYqbjlphVDqR/Jt9hWuXdxu6Qk3cHPv0KGB0+nOzV75L8JPag4wZoIzVg7YQfiPa8ML/aO09gZ/oaIKpGzeyGoyCDeGg16r3/pAyS1/tWaMq+cPmKG/MV5kzZHF2e+nElgqxd1olyrHALc3Ks3B20CAqmBmuc8BnPFO48SM0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nypo7pOkpVcTZ4r5BMfcTTudv9leZaN8bSbQWi4dhQw=;
 b=V0qCPqlfzgzm+/hxU+QyGpBz/NYtI+g5WUb7SrsdpZ9fu/F6XHdm2Oy0OP10VHBztZsL67QrursrfJFRqzYDHcDy3i76dSKOCS3zhRbDBAnEuhFYgtk3vZa7MjRasJB2IwFneMNpebeJ9/ScdX3zgxuA7KLz9R/Mq2MP0WrjvQ8=
Received: from BL6PEPF0001640E.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:15) by MW4PR12MB5668.namprd12.prod.outlook.com
 (2603:10b6:303:16b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 15:47:48 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2a01:111:f403:c803::8) by BL6PEPF0001640E.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 15:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Mon, 8 Sep 2025 15:47:48 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 08:47:47 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Leo Li <sunpeng.li@amd.com>
Subject: [PATCH] Revert "drm/amd/display: Remove unnecessary
 amdgpu_irq_get/put"
Date: Mon, 8 Sep 2025 11:47:33 -0400
Message-ID: <20250908154733.418648-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|MW4PR12MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 4985e669-2c87-497f-2dfe-08ddeeef0f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n5CQPvCSA05fXqz/jkPifq6Eq5Sz3B4QyV0ojbXAVkUE2njQGV5HUOOwiXsj?=
 =?us-ascii?Q?LF9m/2uLirEm1c1zjYNklJsV5Jzpq8eQsHvTNGO8mJSmsWa//qJPp2+kQJUN?=
 =?us-ascii?Q?g1lHcv0lRBb0XUCwoQQQw/4Ga6F5kFsZXfQS1FMcStTp5TCUMyEut3mJPKps?=
 =?us-ascii?Q?mmEOw4SfEt0tinusD3nZIDMlsJsTRNGTdtpliSCLWYx2IC949pL/+husquUy?=
 =?us-ascii?Q?KrviBUigFSiLmv4ZJ5azvWBh5Sm1qS5+e2ZrJ09Q5rdTrGtGuGIO8H4b1ghW?=
 =?us-ascii?Q?OYUxshXcXCKVofRIYid1dK//o72ZIGCDIKI+rRC45LN5Nc/vvixKFMx9K2r3?=
 =?us-ascii?Q?jDfxKYR2dcxtaBh89WBK2aNXcoSOEJQBDF4/+y7KBWFtqeTQTo3zdnnvTfgQ?=
 =?us-ascii?Q?YmIj36IY7t2GPx9nmzyTnZo/UqFdmqBVBxhUjhFGBa7heKsr0kXz06bx2xBG?=
 =?us-ascii?Q?xeFKpRrVL1Rx6w7tDxE7xq0Bkr6AQtZNMzV3mxYIBQzhDzeSJBRkmNk9FR5+?=
 =?us-ascii?Q?frTA1Z60evA6Dn6ObZ2YK3Rl840kGFJbmG1ca+BPnhIUFeDH7wHIclWs6Kv0?=
 =?us-ascii?Q?NEAE5YatCO82r+7S11FRboFMK4dDKH59dfu2CDU10PhtUtNj+6+4Cyoz1Z+S?=
 =?us-ascii?Q?6NiyNRoDIQpHB9rr8/qRliFii1T/wRNIs4Kg7Jai9ekwwazr0kWfcmmcWyFk?=
 =?us-ascii?Q?agoW5p2a4v5KkiRLqjJyCJ+mHA1MWq1ydSHjyUWtkJmypTA8Ao7kcv4Cdp43?=
 =?us-ascii?Q?ANrSjG/ehWR84ek7JHh0URnmq72T1jm6jccn0hom1PZyBRIunNjHL3HcU43c?=
 =?us-ascii?Q?diLg8byR1LZkzkLH+lCF3eVR+SJhriwSucy5QlqJQUTGzEn6clSDpJPouw9m?=
 =?us-ascii?Q?UBYhyvL50XNwR8vqedxu5wLWnnVyL1S0lv10W6PzR6ay8CXfYcDbYmeZlph4?=
 =?us-ascii?Q?Bqd/rnTdGAJu/AAm/exX8KqrxPLbIiJHKr4wrullQ0JXIVdzd5BCgZb+bI1A?=
 =?us-ascii?Q?zgQ/a4LFqeJpOcqh/GdYTHTBoxSr6GkRHxVAVil3Wj05kDZoTsaNfmWCH3d/?=
 =?us-ascii?Q?JPLBTztJo6+a5LVCaK3t1PSYNiVNNQfxk612pjkWuZ2j6xg4tXn5wu6nKdw4?=
 =?us-ascii?Q?ho5rW5ubScU2oNoAuS0M/FufC7byDP0JLT+aoCTecF8Ei980kueV1gpTFlpy?=
 =?us-ascii?Q?BphIkpyhqRqz3J2xZmjTZpUqVqJl4qCe1WaqkzCNxXFsRuoEf/lNz1yPc8Yh?=
 =?us-ascii?Q?OOHY/F07bf3uAotzu2qOLPvTDNgrkatrZpLk8qtFbupepXplAonWRagcvVlW?=
 =?us-ascii?Q?rSKO6Q+qRAJD/V0+weUO75jIHF6YmBoEkdjKe3oISs6h8U7GE2O0LhNdFT58?=
 =?us-ascii?Q?cHP5ZvDLdFroeGxtfi/jgTulTFbjLE9/XdHhxNaJ4Tmrex7yeNdZIT+WxiLG?=
 =?us-ascii?Q?F22HMEFPdSsimyP0urHaYj1CkUvH2xsv0Ll1X2DS95c3bPX3nPpG/A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:47:48.1623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4985e669-2c87-497f-2dfe-08ddeeef0f8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5668
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

This reverts commit 3782305ce5807c18fbf092124b9e8303cf1723ae.

This commit breaks init on some boards so revert for now.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3994
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3936
Cc: Alex Hung <alex.hung@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 611a935890571..f1ff0f95a719f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8797,6 +8797,16 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 				 struct amdgpu_crtc *acrtc,
 				 struct dm_crtc_state *acrtc_state)
 {
+	/*
+	 * We have no guarantee that the frontend index maps to the same
+	 * backend index - some even map to more than one.
+	 *
+	 * TODO: Use a different interrupt or check DC itself for the mapping.
+	 */
+	int irq_type =
+		amdgpu_display_crtc_idx_to_irq_type(
+			adev,
+			acrtc->crtc_id);
 	struct drm_vblank_crtc_config config = {0};
 	struct dc_crtc_timing *timing;
 	int offdelay;
@@ -8849,7 +8859,28 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 
 		drm_crtc_vblank_on_config(&acrtc->base,
 					  &config);
+
+		amdgpu_irq_get(
+			adev,
+			&adev->pageflip_irq,
+			irq_type);
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+		amdgpu_irq_get(
+			adev,
+			&adev->vline0_irq,
+			irq_type);
+#endif
 	} else {
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+		amdgpu_irq_put(
+			adev,
+			&adev->vline0_irq,
+			irq_type);
+#endif
+		amdgpu_irq_put(
+			adev,
+			&adev->pageflip_irq,
+			irq_type);
 		drm_crtc_vblank_off(&acrtc->base);
 	}
 }
-- 
2.51.0

