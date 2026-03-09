Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8A5FCA191
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 21:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80FE110E103;
	Mon,  9 Mar 2026 21:51:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jOXbDhef";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3710710E103
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 21:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgK1uFLotn8T5Od8t/tB61Go642Aa3Ahx0yMFiaLwGetRZlMmnViuWWggdZ10JWpw9GXSMdwQUFxcQo57ECtsxdw+hPele1HJKJuZrm9b4UD0STaxelyIhhOqmVwyKA/WyNYdmuv8e2T1ccW6PO3c3hq93tO362tzz9lZw+G8WbU/hqWp4ufRMljlvHnRB76l/IH316SN9VQpNPVOjJoNeHbiqxsrvR9QUfOHiSR55ib24TIkeh5mtKKa5m3KXcTpmHcTv97d8Bu2bChEQnqYDq2kV60zi+5tb1eY8zNIAUMpfLyN0ZdnefWHy4ktFluyGlfkWsVH8dsOmHCCPLTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yg0wSpI6DShrjABAsIu9YC0oKDx/DjkS+rgcBj5AL1c=;
 b=G1khBL5r5H3/puQXmSHNzApO+ejON/GWvyLLbRyeYk3M0v91zrnMmgEaC5WhF/dvXUmfxIJGcBcu78dBoR1Nu/v1nnXzNGe0vRdkvE0Yk/WTq1OUKchGa+uEzgHk0qRhq3eZCzQNpek1ipKzpJZFdH/wG9aYbWv3uK8G0svwNsnEMK6fFudxHKFQW/INMf1xoqtQ6pEpyCyXfX/HaTPtAJvQIiQ7UdGS/gm5EIP0K3srxs6NIVxJJdf+ZKqmjSroclxkDx8ccB93kr+2TxpF+ZDJrroRV3ZzLYqqiEjGoahT6Krhcgkzlp0vdSjT/SwMaOaA8T9Nkz7lTgJO+62iHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg0wSpI6DShrjABAsIu9YC0oKDx/DjkS+rgcBj5AL1c=;
 b=jOXbDhefMvBTN5RVf/VDHmqbzXQHy1JwpmpRlXqqThro1Gk+dr74TzhozbuKYhujQOZDVyBR/deHi0XYacW8btQShIRBJIXaAUYm/9BCgAOHHXRTCDm7Kngy+nM8Ov4ARkXzrIf8YSCBmlovw2Zmiex2MleeVBBM6Ars/WTuHrA=
Received: from CH0P221CA0036.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::14)
 by LV8PR12MB9420.namprd12.prod.outlook.com (2603:10b6:408:200::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 21:51:37 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::fd) by CH0P221CA0036.outlook.office365.com
 (2603:10b6:610:11d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend
 Transport; Mon, 9 Mar 2026 21:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 21:51:36 +0000
Received: from STXH3-MAPLE-10.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 16:51:35 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <mlimonci@amd.com>, <christian.koenig@amd.com>
CC: <rafael.j.wysocki@intel.com>, <benjamin.chan@amd.com>, <bin.du@amd.com>,
 <king.li@amd.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>, Bin Du
 <Bin.Du@amd.com>
Subject: [PATCH v1] drm/amdgpu: Fix ISP regression issue in kernel v7.0
Date: Mon, 9 Mar 2026 17:50:28 -0400
Message-ID: <20260309215052.1417114-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|LV8PR12MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c42881b-2817-416d-c473-08de7e260953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: 7f3LyabNP8eVH02xdkdVxPePP4QGlO53K39yo9WWi26GmJTkYhCa29sTDBOEgDcQV31GBOeQSA/cVFOdOLUuuRbF/UOx+jeh0jw8Z1floiCwNHi0YziImB9iMunRpGCq5kwM8AhntHR6mdP31oYnl2RUJvTmAIDa83wfTC3BST8P47TGYL6wkOVTxAU8CUoZ5t4ib7diT5lcyLJ/0ydBX2NmVoFsM642glymApWi6EFCF0NSjzqQRmgCh+0J6k9yCPySPumf1XbKTiLRu1uszrjRQLMsvP0/3CHSib32SlG8q1l5Y7lElfd+Gs+32vujNGoBCUO4QedexJSixYV3xwgBSOWRSmhxIh3jmVZCaumQwkeOehGCrdWm5u1vuOabG2aVXOM/eOPX+/MlZmqLaQXdNgAcCHHXb0oSTPYBJzgK3N9sGmA5NABGHjwtIPd8U4yS1eUJJVktEKed/CAGK46jsntm4OWxLfOul5l2NAW56jVg0DeaH/2xtg9iGaKIvKpmOV3vfVnOHyHshEuXjLWTtNfxwfSaDtYp1ibUO14/bg5hRzi+hnEdvUS8HLHnjnvwlr1ELVrXgye53lXW3kYlVLsNbjxvTpT27Doj0/FBiwXfYB/VF/HQDAt8kWj/f8qS9SBPJOg3CSRfWhnY4LW91UqVf5cGYY2lJsbsuIbDLWhTjgOag9f+jgn4tDJ3ZJRQ0hmFEx6sqmU0/r6+475xQwAiXI6nheqU+jfjgyMW11sX4mPCRx5FvDULivAJaSLZLYWe3D6Wj4KAqoOJlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OqRVRS72u9cW7za+ZBYkZuga3w++PQDDyqgYB1bq1sZAo/7aE2H0r4R3EIeYBeaJdg1d7baW3S94fjdYJTEWFS/z1GxxaP2La+ar/jTTR49Y3ceTivjA2LKMzK++IMJNogeCIiu8gCUP7CUV+qH8CJ+2RgtJmoSf9HZk3nyCcintvXThJFDESweILZW9v8ZSnSS77rTba6xEHx/NoLbK5IKAb7780K4haC0FJyI3C0dFEgHQOLJyooDIllQn4ixR8pxQySPPRBLg8JjjeFgeLSGBKYheT3RVq96RYVLSGHxbZm2geZtd6SeHd8AEDlcRNsa6MXvInf3p0oEvYupbxmhpui2FPqgNxbwzu4XOqvQOAICcQjV0c0NYG6Nj/dZ7qFWtb7bfIGOS244G2Qfbxg92ZOpRbO5VOzvKS1P5d8yxfiIbzYRK7YkLEUb3mopw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 21:51:36.3093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c42881b-2817-416d-c473-08de7e260953
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9420
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

Add NULL pointer checks for dev->type before accessing
dev->type->name in ISP genpd add/remove functions to
prevent kernel crashes. Also add MODULE_SOFTDEP to ensure
ISP driver dependencies are loaded in correct order.

The regression was introduced in kernel v7.0 where MFD ISP
device enumeration doesn't complete by the time it is added
to gendp. The timing of ISP device enumeration has changed
because of the changes in registering the device sources in
the device hierarchy.

Co-developed-by: Bin Du <Bin.Du@amd.com>
Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform one")
Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 95d26f086d545..920595f0d22ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3212,3 +3212,4 @@ module_exit(amdgpu_exit);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL and additional rights");
+MODULE_SOFTDEP("post: amd_isp4_capture i2c-designware-amdisp pinctrl-amdisp");
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index b3590b33cab9e..485ecdec96184 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -129,7 +129,7 @@ static int isp_genpd_add_device(struct device *dev, void *data)
 	if (!pdev)
 		return -EINVAL;
 
-	if (!dev->type->name) {
+	if (!dev->type || !dev->type->name) {
 		drm_dbg(&adev->ddev, "Invalid device type to add\n");
 		goto exit;
 	}
@@ -165,7 +165,7 @@ static int isp_genpd_remove_device(struct device *dev, void *data)
 	if (!pdev)
 		return -EINVAL;
 
-	if (!dev->type->name) {
+	if (!dev->type || !dev->type->name) {
 		drm_dbg(&adev->ddev, "Invalid device type to remove\n");
 		goto exit;
 	}
-- 
2.43.0

