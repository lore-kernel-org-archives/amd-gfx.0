Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAAFC27C53
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Jun 2024 15:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6074D10E259;
	Sat, 22 Jun 2024 15:48:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="12xlWB4s";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B32C10E274
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Jun 2024 15:48:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Avgjtj7cvPPvqhBnoGNWP8lm7APQdFWQp1Fr4/ZLwlfOrvEq1C40a1SN1Y6GFl0E/Mth88f/sfeXOuv1DhQi8apQo5zIGKOWIOaJkk2UNDBJCX0AptjbJnJG64e1qvxqr7rCPLV41p3t1hzm4YMUoITVqS1iLg5r1OpEmE5l5ScGApeOn7bCJMoDkB3rENz2oQVOik6JglTb6Cka0qjhyv4R3/5skc6O/fjLjLoHpOGBdH70LddyHD0XWXy9/n0gSEdsiOtHVJ0iKrgVOqupJel+WN8Ohgdw5hCGie0376CGuoy9o07IA9HAUoBeXMkPSQ1vPogum0NN+x6fEA4xIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYqpxf/bqvjGrp6QevaWF+EEogw7G8v+UZqfQ93sns4=;
 b=T4QOPIeKLICw+//jWRxYNABWmXsZTzII1y8ezFVxGMy2tlsKnw/qqQSm4Typ8888vWKFKC6I2kf3f4Cc/n/4EQaibCIV7kWESEdfKYQfYjkhqlcyANlKEl/8jJpC31arZQhnN2seSvVz/ZsYY/YorDQsvpQ0An5NozFjHZQociwVLvqMJGH0I2oIsaJfsWTUN+KMj67dqdxvci/kSEKL2y8ljtOULnHMHf1GODXahYzev+1f39/i7uHXA1InzcuTa/OFzYQzGCORpLAyHAXmufluPoWicC8VxWrmlyAowmbRwfWJfZucgBFldmMuargnv4JLNX6uC9e+JeGdsNyQsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYqpxf/bqvjGrp6QevaWF+EEogw7G8v+UZqfQ93sns4=;
 b=12xlWB4sX87caf1JXwoLollStsu5IIh66V0ocE431XNtscQykZjjCkpaZ29+9jhQtDrVq6p7pW0DKMRTpiC+NFRVvOkRwQE+ZDTgeVlrbNzdFMVbPf0cBkEjCQkQ+4AdulvNXABK5lc/+nP70XrsRQ4fVY/+J4JFAVA/tPZ4KbM=
Received: from PH7PR03CA0026.namprd03.prod.outlook.com (2603:10b6:510:339::11)
 by DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Sat, 22 Jun
 2024 15:48:04 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::e4) by PH7PR03CA0026.outlook.office365.com
 (2603:10b6:510:339::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.37 via Frontend
 Transport; Sat, 22 Jun 2024 15:48:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Sat, 22 Jun 2024 15:48:04 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 22 Jun
 2024 10:48:03 -0500
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>,
 <lijo.lazar@amd.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Subject: [Patch v2 1/2] drm/amdgpu: Disable compute partition switch under
 SRIOV
Date: Sat, 22 Jun 2024 11:47:50 -0400
Message-ID: <20240622154751.632271-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DS0PR12MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: 433ed993-daf6-4255-de6b-08dc92d2b448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|36860700010|1800799021|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PFrnPK1TlGQSnUW0ahpiIucXotXcvfmSSjhJZMKaxsC0zMgxgC8W6IP7e2BC?=
 =?us-ascii?Q?VW0O36jlyTVTg5wIngmhmQKqsg9yI+eBwFmclxAe748KGmaE+kw+eXdCrAyF?=
 =?us-ascii?Q?l9WUnqyJCtn6U60/scC/P1hmFaMTUAXGleF8/NoVFO31zPcPjyLYZjuNil7l?=
 =?us-ascii?Q?qnJZzX6REfyKBVDwYv1otllbAXkRKgjL3RJUBYaO0zmGlD77+C+216sSdp/D?=
 =?us-ascii?Q?RgZOfEhS3bdv/OqzeyUPCVjsPlGiZoQnEG7nwcuwcqIXhhN24OVMD5rlV2a4?=
 =?us-ascii?Q?gAJ3r2LRvkzXN+qrQyvbBuWGaPO+NeJQzppqAZe09mxKWw87RvlF9Yq1PYnH?=
 =?us-ascii?Q?QLuCop6PNzLlyqSo4ph95RgrZcQ5yVR6z+lUrQeN7rHoQ2oglMdafpktKI0g?=
 =?us-ascii?Q?rjCDCj6tqdmJo/B48eSyvAEg69OZmiei1/l+OiM7Np+LlBMD93O3jdSX6Mw6?=
 =?us-ascii?Q?y0r1IcYVJgxkjwbsx3JRzJ7+mU+E0bGP2XZcH82jeMpp/HL5sn6Yrx+YvmZO?=
 =?us-ascii?Q?RQHbI0EvC56HtqiaAlDbqWX02n4t4BEe/9zlUBRNnC+uMYxEUIft2CWOPgMJ?=
 =?us-ascii?Q?rFjhMiy4uWejbtIpgPyGy0KDKojpORPMdpJyUIkxqRPAIGMCYE5Jzo3rcwWp?=
 =?us-ascii?Q?wp3gyI7BCDtlhCTTMbwhY9Uxa9OaxjF0RjuktP36lscz7Y05f+ImjjyaTSCd?=
 =?us-ascii?Q?rzQrsqlY37aW+xw+ratDVvOnDCHOzm6xrnyOfeZqX6Viqq+agFOWZ6Dra5AZ?=
 =?us-ascii?Q?F1nALpRGNKfAVGVaVYIF84FlUpRTy0kL3pmvIHcAEE0KPvR/d9mRqhp6Tgos?=
 =?us-ascii?Q?kLYUtDEQKUpG3QvmzObl1/0CFPthBTgXJIixD1axuy2Kq0ocm5qoqH7Xmtyn?=
 =?us-ascii?Q?klTcr2zg8hJFDUOTBA2PllGovK33WOTIYTzl2MOPODgeLLfCBSUOsNQch+o4?=
 =?us-ascii?Q?7YUyJQOSZ19sdn2kVm+gmXcZ3P4IkV54eWH4r6kgczTn1Asa1WJohtv+Gj27?=
 =?us-ascii?Q?6g6zn96cWzlNuPIK0OccY4nmSnA+7KEv045mTuzCYUBbKiX03SD8xL8byWCg?=
 =?us-ascii?Q?Ejkj/bsQMI0fGCa5qZ/KTXIBv7ULmaARurvCF745iPHsFoYuMy7sJ4g++qJ0?=
 =?us-ascii?Q?qVuxCuiXkvlMPrkcIPsYxfgBRTdJYBfD9ozoimni1YEiyIcIDhCN1aeGY8v7?=
 =?us-ascii?Q?74pVe1Ta43LwlzC1E9a0h0qg+TAdIlXR2XK5hF1rsWlWnfk4/z1KeodKOr1T?=
 =?us-ascii?Q?hWPjVXZYbnhbQI3xVqcM8iDtUMWQ3bBE1Gt1n4B+GVmFOjtPS+oaEi2Y078O?=
 =?us-ascii?Q?iGFEqD6HAy5HW5kU97+U5dlym2ihxMoaY3hC/PDPNs/3t2/+5SW0LZ6lF2Ax?=
 =?us-ascii?Q?YJjtyE7Hu5xM9dPtWibi7IQNH+fqwi01wkUd0ME0NMuSycdDRw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(82310400023)(36860700010)(1800799021)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2024 15:48:04.3979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 433ed993-daf6-4255-de6b-08dc92d2b448
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246
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

Do not allow the compute partition mode switch from the guest driver but
still allow the query for current_compute_partition.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 9 ++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 82452606ae6c..1c673c0b65d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1292,6 +1292,11 @@ static ssize_t amdgpu_gfx_set_compute_partition(struct device *dev,
 	enum amdgpu_gfx_partition mode;
 	int ret = 0, num_xcc;
 
+	/* Under SRIOV, this is allowed only via the host driver but not from
+	 * within the VF */
+	if (amdgpu_sriov_vf(adev))
+		return -EPERM;
+
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	if (num_xcc % 2 != 0)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 8d8763ebe027..f87dc1b9d77c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -936,11 +936,7 @@ static int gfx_v9_4_3_sw_init(void *handle)
 	if (r)
 		return r;
 
-
-	if (!amdgpu_sriov_vf(adev))
-		r = amdgpu_gfx_sysfs_init(adev);
-
-	return r;
+	return amdgpu_gfx_sysfs_init(adev);
 }
 
 static int gfx_v9_4_3_sw_fini(void *handle)
@@ -961,8 +957,7 @@ static int gfx_v9_4_3_sw_fini(void *handle)
 	gfx_v9_4_3_mec_fini(adev);
 	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
 	gfx_v9_4_3_free_microcode(adev);
-	if (!amdgpu_sriov_vf(adev))
-		amdgpu_gfx_sysfs_fini(adev);
+	amdgpu_gfx_sysfs_fini(adev);
 
 	return 0;
 }
-- 
2.34.1

