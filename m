Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47356D3B7E2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 17:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC5A910E4A8;
	Mon,  8 Dec 2025 17:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VR4LNYvt";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE20910E4A9
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 17:17:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSW+nXOglyBHucv5Ja6FIntHQJ9xBRZ1PAVePvAdCEWHT1rqmB8+qyoQ96rjHG0jv3E0eoaEb9Ry11a8uEURi4Cg0AKJbu+6jQ7WonAvmP8c77c83OCuXT8WOcEJD56aUVcZGapHG5Mt4Plkwe2Vr/qXLhPapJfzsYkmE52G6kuVBBJ/7oMwLIG0lt6eo9l0vk11CMkfAtuF+gYWbegX6oB27oY1ue0Nc+mBRqQSPTc6FPBR+rG6dCl+NVWY3Acs8j6Z84o74NkIblN5IOy1R4vjRnJLZWzjd0LX1kxTMI03HQZpfOzcD0Vai6NHbqbD0n93aPeoc7HJDjGEf7ZxCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvhIKZ9QlDcX0+Mifwvd8J+1Gz+4sTNYt9H/JiZ/0y4=;
 b=JwIAUv6M7NLc/Ca0unh2IwYgfZZGbAnJBpPTwhB5eMpiZ7zqJt7cpyjTNhWrdWrW45y0rLKoj7Uei0jT6SAc9Kb2rc/4B4JaV9dKaoZzA78mg/MrKrEE9+0G3OC/ZgLk+ywKWSLmSp/YIC2vcnZCDkZDxFf6UMZ6/9pX4hPbE2LaDeF4WAzUexOpKYOnkDUzVk9LyuM190heyQc5dNDgaTwXdvfgrwGFMkMkXoInMYEhrs1JPSn/nYuPUtZuyZV4aN+1NDIqNK6SoRT6uexnqT+RD244os4oQ2h2WxDWjT4YLDEnZzji3m7v31X4mYSVF0xnS/5AGB8/wJifycSmMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvhIKZ9QlDcX0+Mifwvd8J+1Gz+4sTNYt9H/JiZ/0y4=;
 b=VR4LNYvtViFgzQxrhn4cNq+a0I0TaHfF03VrOFX70709N18zGXSmMcpuuf1WgpJ52Rw99EsxZXcLsCeQLx/7kUgvZkyV4AcIHOmcmPBJMKSgtLwVDQ5sDT2VqfVFjg+g8qAAg6DlZ0bZKz0trWlldy3ESTIcL+2qgohpgqRlMcY=
Received: from SJ0PR03CA0144.namprd03.prod.outlook.com (2603:10b6:a03:33c::29)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:17:55 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::94) by SJ0PR03CA0144.outlook.office365.com
 (2603:10b6:a03:33c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 17:17:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 17:17:54 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 11:17:47 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Init partition_mode and xcc_mask for
 GFX_IMU_PARTITION_SWITCH
Date: Mon, 8 Dec 2025 12:17:13 -0500
Message-ID: <20251208171720.153355-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208171720.153355-1-alexander.deucher@amd.com>
References: <20251208171720.153355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 200e736c-09bd-4bb5-2b31-08de367db9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fZY4IMVKzIz/1oicYaiWXQ70PLDFiGGsk0TNV3y4T/IISNvc5GnLPy/CgzhC?=
 =?us-ascii?Q?gtWeZWzkPN99x2PgSOJOlRJKxavuic3fHq+UWPEcirnqvNcDuRFZ0O1epiKa?=
 =?us-ascii?Q?8Vy+DAcDaUMl5tie1CLfI60CvO87aIfuHI0+JBiMDViOGYp3l5xQEPCyEwYq?=
 =?us-ascii?Q?rZDHmwrxX7/dz0X2oND1aZMQL4UW3MU4pwXbczH+k/b9cfzi6PRmIUcRlMJE?=
 =?us-ascii?Q?ARyPGj8W4vK/TYaLxzNldKH1xEru/Q5/4JoDIf1s+OowUkFykwl5PnbP6/Pk?=
 =?us-ascii?Q?WqHo8hQRRSBCky/IFXdAAx0ixqwwN3P6TKj+kqr4hJD39VxmDNOWjoOps3bm?=
 =?us-ascii?Q?Pm7XT9sVRbKTD+h1PDy7yYCsl9LXBefWrJoN/IkB7GIRFCotOBG24UJFKQQZ?=
 =?us-ascii?Q?OkBfHpKUfUINgEe4PZofEB5zh5JKRynTicleXDZC4J3QVg6qM73FZ/ImnL/w?=
 =?us-ascii?Q?oOcdKRElb2KbSkgJ/7sDEpnNRapTpp9cfGWOxMYT05HZz1qWctD1IWITXlAT?=
 =?us-ascii?Q?AX3r1qcMUnj3PVcHTB85J9JZSmG32PyhZ1Gd8jsaiNWqxdH0mG8+PmDSyMJ8?=
 =?us-ascii?Q?aC61cmmQXw5z6Y6viCzy6TIISxB0rcRLo9TV643pj7Hmg3McFTYs3Sbb3SDv?=
 =?us-ascii?Q?FuIx3NRoqc+wQB6yAwcQFRFQy7Sjy0DdSAaRwqyIIBtxvyoMjWeGoeKRgIz+?=
 =?us-ascii?Q?kosauY6B2GvOwbsMZ8qIS6zVM/gfI0YOQq7kI5TqjUz4c/ZE/jwkCRWAjBD2?=
 =?us-ascii?Q?89RNrynfm/HZeJ8mtZ8R+5JG9MXHRKCEfqplEK/o6Gw+XoUoTtOeOqJnpvRn?=
 =?us-ascii?Q?ji9VUx2cny93GwpAhXatAbij6xG0iPKxcBJ7SxlSbaLfCFyYSzneSaZCWnLp?=
 =?us-ascii?Q?lG3D5qybDJPcPSg+m4qhwQUuKjjJVOI+2a6TmN0uPYjt3UFV83JEeGhWFYmi?=
 =?us-ascii?Q?8JHufRrp49/9U+SdSHpPyKNjFIvkKNvZwLST/AyoJEV1WG3jPyqNm9u5U0Nn?=
 =?us-ascii?Q?+2E9jgI4+dgtzyUOhARs6SSw76KQXZLYEIbtCNK4t1kAeUCLCKOtNDoJN6mx?=
 =?us-ascii?Q?H+5BpjYLsVUSGrn27KrrAQ4ZvFwnrb0tc0xPrzFJBT3HahmEy4EFdXApSuuf?=
 =?us-ascii?Q?131AlvDAZt1LstbB9np6HLRnSl/aWEh0TKV+0beMpcmfK6QHVoUPgn3iwrLR?=
 =?us-ascii?Q?XcDdWvhitLyKln1tOaNk64uqKZxEcM5c7D8MBb6dRNRt70IjA/EmIstrufvM?=
 =?us-ascii?Q?P0oSI1I36RYFPN/xcrn2wqGeVDfdFHBNo5WOZIHDSL+S+ZDkebJwfaxunfxE?=
 =?us-ascii?Q?sHl9ly1AmGvu0lBHXCG6XU/h8cAuTgcDfP3Gm6hzWqMNX5Hzqp6Q6X9TuTlt?=
 =?us-ascii?Q?5Mul/Mt+EdWMa0oYU2fWBP42q7KngR2jFwEnT4RaZFrgWZBBLQPjgAYFAZmF?=
 =?us-ascii?Q?/s2ViXMD8VEW4F7Y7YpZ++78hDLP+FWmjBrTVAK6RTKoG8rpGMnlZ6Sr0o2f?=
 =?us-ascii?Q?Fjl++W6taVAaVbTp7zu8z3Z9nKPeSS9lqKe7Cye60C++rvrtsGOVsfYenmSC?=
 =?us-ascii?Q?Y4/C8aAWqkhre2+iZcI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:17:54.8472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 200e736c-09bd-4bb5-2b31-08de367db9d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Set partition_mode and physical xcc mask fields in
GFX_IMU_PARTITION_SWITCH register

v2: cleanup (Alex)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h | 3 ++-
 drivers/gpu/drm/amd/amdgpu/imu_v12_1.c  | 4 +++-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c   | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
index 1a9b4b24dcc60..13c71edafa409 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
@@ -38,7 +38,8 @@ struct amdgpu_imu_funcs {
     int (*wait_for_reset_status)(struct amdgpu_device *adev);
     int (*get_xccs_per_xcp)(struct amdgpu_device *adev);
     int (*switch_compute_partition)(struct amdgpu_device *adev,
-				    int num_xccs_per_xcp);
+				    int num_xccs_per_xcp,
+				    int compute_partition_mode);
 };
 
 struct imu_rlc_ram_golden {
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
index 2ccc5c0793bbf..aa94e598f3f14 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
@@ -144,11 +144,13 @@ static int imu_v12_1_get_xccs_per_xcp(struct amdgpu_device *adev)
 }
 
 static int imu_v12_1_switch_compute_partition(struct amdgpu_device *adev,
-					      int num_xccs_per_xcp)
+					      int num_xccs_per_xcp,
+					      int compute_partition_mode)
 {
 	int ret;
 
 	if (adev->psp.funcs) {
+		/*TODO: revisit asp interface once it's avaialble */
 		ret = psp_spatial_partition(&adev->psp,
 					    NUM_XCC(adev->gfx.xcc_mask) /
 						    num_xccs_per_xcp);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 7e96c6583aa97..d4d42f2611a45 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -652,7 +652,7 @@ static int soc_v1_0_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 	num_xcc_per_xcp = __soc_v1_0_get_xcc_per_xcp(xcp_mgr, mode);
 	if (adev->gfx.imu.funcs &&
 	    adev->gfx.imu.funcs->switch_compute_partition)
-		adev->gfx.imu.funcs->switch_compute_partition(xcp_mgr->adev, num_xcc_per_xcp);
+		adev->gfx.imu.funcs->switch_compute_partition(xcp_mgr->adev, num_xcc_per_xcp, mode);
 
 	/* Init info about new xcps */
 	*num_xcps = num_xcc / num_xcc_per_xcp;
-- 
2.51.1

