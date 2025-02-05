Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FEAC0219B
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 03:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 009F310E726;
	Wed,  5 Feb 2025 03:13:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NkRT81Ys";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FA3F10E17B
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 02:48:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llcDvqX+Kc6Mz1dE/dL3LC7BYYKi4Z+G6van1Qq3WqRm434HeWbwzfdS0BKrEfSQwCWbfeFGIIOyAgGuoNraemTIWb7NA3DTJp14mgMfJ7w31IO6Nu8zEJrxhvtEjfCM9YGtvytBOkLTtCcsHj3N0l2MIggo3a616YJ3u8m9d1irCnaxzKviu1ezNKNeZ9ndLWlhgwhWGMzKkWF+lujoITwypuQXd07fkQBduh4gT+TNn98AQ2HT9BO5DhZQoqrZC4Mhtu74ZSbmbiPivqAR1AbZZO6h+uE6ahgEzjuKJB+T6HY6kjjQLPfFY0l7SwUXi/eZGhk7TFcGT02JVmNJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8BZefJUQw89av8dgc0YcrQP7l1fHUSDWb3iLDQMe/0=;
 b=VBNQTuAXC5MfOJuDDX2AA1obmK8e/rP0Tb4zmHFgi3IqWx6doawlp9xrOwRLaVmGXx/0zwxTyUG7WiK/caDJAdbmIdJOyx6FZTepv+qhg270c27nsAaTdDJSJK0LhQJDirXM5CbgBP+8Y2DstJoMaPrpsnuOM5CHeYcBI8hLKo5mdAn+FlJx/pg8Do0sBXrG3tftFinM7bpP/HHJtLA+jxkAvc5OA81J4+kHnSg/9hbZSfZN7au9c1NE0r6xUH4yu5GOGX16NVdGKp2OngyMT5mTRL9un4yFOHfJcv0xOyZl52+GIwhQjDFRW19uzrV760SfKAW206KslSq5kcWxTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8BZefJUQw89av8dgc0YcrQP7l1fHUSDWb3iLDQMe/0=;
 b=NkRT81Yse5MDOSMopy5Yn1q0og5cqPLfGi5+f6+JUIt2zUIXoVin0jr1PZgIYlilVIYEIU24bt0+yFzRK+Ybex1tQkBKy+s3GjhI6xrv8jpmakdHh0kQ/A4bRIoeS9F32bCsPCgoKwPSSqvVLmvEYYLJN6eRYHzi+ok4JUdaewI=
Received: from SA1P222CA0089.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::19)
 by DS0PR12MB9399.namprd12.prod.outlook.com (2603:10b6:8:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 02:48:50 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:35e:cafe::b7) by SA1P222CA0089.outlook.office365.com
 (2603:10b6:806:35e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Wed,
 5 Feb 2025 02:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 02:48:49 +0000
Received: from rliang-PowerEdge-R740.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Feb 2025 20:48:47 -0600
From: Ying Li <yingli12@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Mario <Mario.Limonciello@amd.com>,
 <ray.huang@amd.com>
CC: Richard <Richardqi.Liang@amd.com>, YING LI <yingli12@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add support for IP version 11.5.2
Date: Tue, 4 Feb 2025 21:48:36 -0500
Message-ID: <20250205024837.976890-1-yingli12@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|DS0PR12MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: 85bcb464-1fc2-422d-58f1-08dd458f9e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L2MXs+t/5t6eyV89SOCqzZugOdcaHkXTi891+TobIEAzKoX+GMgUu89wF6bA?=
 =?us-ascii?Q?HadmxOi7uD3+jWJpxgk/+sZ4jcMeziqt4r2uHkvl9nicaJ4uxDm6Xw7cLPTl?=
 =?us-ascii?Q?UFGGcXqHHXKMuUaFrdgLahwpO8ZEvMLD0nFLX3gg8mKqpMuHq7Mfg4JVYLxk?=
 =?us-ascii?Q?4i1Bx+Q8dttDd+dX7sYuAGDNuKHBMtbXTqcrZaDi/tu7FbGsPWD0C9UANqvZ?=
 =?us-ascii?Q?+Zmg65bM9SPLR3aCKPMuaAyALssVrN5Dnk3njLwv47ayMS7YSO17HGUjVUkb?=
 =?us-ascii?Q?exHyVlkJKVnXVKidMpCR+jISpt0s06knSDMVRJtec+JK6Z9CZwSGFL4cXnp3?=
 =?us-ascii?Q?sdwkUsNmi1D4cHtSycqvXskuP+aCtEIDmY2hXxrREYPgVZo3RFSWRCtvHtsI?=
 =?us-ascii?Q?3MSRKSGFznGCLp3qS4EPQIgxGiav5DXbbGYCUdiwKLYNaWwaVu56PrBIAx+S?=
 =?us-ascii?Q?B9kV1yBZ/SHqgtTWcOR6hYzuGzs0xM0S84WHhC1hhARPiXbexIl4rltS7o3d?=
 =?us-ascii?Q?8TMJzhodH/tCXJRLrhPM6jEZVnEKT8kTYQm/dm/8sMDy9KCiMfVbrPTig00m?=
 =?us-ascii?Q?MtBzwhOTfEbQakOBJgbtqjmznBAOLaOO9jMGYEcRNjqp0aDo6SJ5YKijD8jK?=
 =?us-ascii?Q?kt4QSAF5Mx9OJjMs12Alo3Vh5QJGH6QdUzhWgV+yWCKDA/CI1z5qPOtYNlgI?=
 =?us-ascii?Q?KFvTx1i8sS/U747miY9s4bUFU89SGAZDNHsVaxBc8d7vmyTa81+eQucSeZ+O?=
 =?us-ascii?Q?gTf3wdC0PdS0tiQC9NFHrWXcvx/s2XOgZlWPK+kvk8fgV/z3gTuL34A9i7BL?=
 =?us-ascii?Q?xFTi4MrSS50kVA/ZXT2VYJfrsXqd2e41Z94GmeTfytX/JDhsuO88VDzpjEQ/?=
 =?us-ascii?Q?Vy6EouPpWOkDwdhLo6/JDdi1I3i0fhiPKZOv19PDzfrXgqWd+8MloyE686d5?=
 =?us-ascii?Q?rYvp0Q9ElLVBED2jhI/bjj/rE+MMLt/0q44hQSMq9uIWlCWkTyhq0JX/GSnB?=
 =?us-ascii?Q?v/WJT9sgr055uv2OsDZrFg9GwCple6o7XC5uKoVAhPer1yRYZ1O0uaL7whdI?=
 =?us-ascii?Q?kug2rkPw4pNmPeqc/r6Nc9PSP808wRU8Jo6dpeFN4EdOMS27ohAJ0O2PXa/v?=
 =?us-ascii?Q?KjPTsirNfVEJiuII1l7Hhyy+4y6HbL3zbGP+N8ZnHR02fmcjwJMwVP8atyKH?=
 =?us-ascii?Q?Yog3iPVS0F8BodNrfGno95lfydeRYiZTpUrg7u+RFU5UZuGexclhpPeoBESJ?=
 =?us-ascii?Q?RfU8p+oNgn2zpMfwYM2AZDrOGjCQ4lNXDov9AV89JxR3a9cY8tZypZabxKwC?=
 =?us-ascii?Q?VNZy9ZoEL4+CRCIhu0fR3PhgN4t+wWjagIJnJOYd29i6L/GKQBA/b/9Tzo6I?=
 =?us-ascii?Q?FfCGe+tpZGOQlrPItluVQ71h4dBSWLp09ABVf1sOjRZL/fGDNUbiFe4kPLfx?=
 =?us-ascii?Q?zQxUNcPS6yUNcvunGwEhPIVJo1XbvxaDQ1eARYWhAoEBAkypewYTldttxbiT?=
 =?us-ascii?Q?6cjFG06daJax6gk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 02:48:49.4246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bcb464-1fc2-422d-58f1-08dd458f9e50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9399
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

This initializes drm/amdgpu IP version 11.5.2

Signed-off-by: YING LI <yingli12@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 1 +
 drivers/gpu/drm/amd/amdgpu/nv.c               | 1 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        | 1 +
 5 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index fbe1e23526f0..e7f6d2592a32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2001,6 +2001,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 12):
 	case IP_VERSION(11, 0, 13):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 2):
 		amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
 		break;
 	case IP_VERSION(11, 0, 8):
@@ -2065,6 +2066,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 12):
 	case IP_VERSION(11, 0, 13):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 2):
 		amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -2909,6 +2911,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 10):
 	case IP_VERSION(11, 0, 11):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 9):
 	case IP_VERSION(13, 0, 10):
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 4c794e8ca7bd..cdf595eb0849 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -193,6 +193,7 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 0, 9):
 	case IP_VERSION(11, 0, 11):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 0, 12):
 	case IP_VERSION(11, 0, 13):
 		psp_v11_0_set_psp_funcs(psp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index cf700824b960..3d9e9fdc10b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1216,6 +1216,7 @@ static const char *amdgpu_ucode_legacy_naming(struct amdgpu_device *adev, int bl
 		case IP_VERSION(11, 0, 13):
 			return "beige_goby";
 		case IP_VERSION(11, 5, 0):
+		case IP_VERSION(11, 5, 2):
 			return "vangogh";
 		case IP_VERSION(12, 0, 1):
 			return "green_sardine";
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 47db483c3516..8d84dff58b7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -454,6 +454,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
 	case IP_VERSION(13, 0, 5):
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 2395f1856962..bb5dfc410a66 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -129,6 +129,7 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 		err = psp_init_ta_microcode(psp, ucode_prefix);
 		break;
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 2):
 		err = psp_init_asd_microcode(psp, ucode_prefix);
 		if (err)
 			return err;
-- 
2.34.1

