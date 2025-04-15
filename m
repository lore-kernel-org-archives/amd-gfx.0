Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324E0C369B9
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 15:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B755610E7CE;
	Tue, 15 Apr 2025 15:00:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EW9CoVgA";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D87810E7CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 14:59:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YH2GyxA65Tx+OA5rJkV1QWhQD9COJu5zDpPpy+jbhBcv8c7OEg/7A2LQepBX6ESM58+TdszTsW/Ri9xSYuoSVBuq6Hdr5T0pt7eMloFBSw/gBZMfiFSMsH19JZcdnhNu6YnHtBGe8UteY+miB7LAz04OEQ2eUUlPPqRQUbTncRY4adb0+rE7TfNUSgnuEjj7N95g5qhuJUe0O4GNtCY/ZFGUgErnAcRbF01oyupm1ZE9kIzfvrwLj2tUOHF1oTJ4k02t6yfnBHiTUPeUHoo6unY90L0fCC5j6QcnKPPI7thzEyPlFlxmX5M3ylNxOgGWx/atXjV5rUpUfNI2xMbVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DT+wNTyYOgOpcBa5txIT4HhR5nj8BVnnT9mU8f9phM=;
 b=LCEKaulJkuSaC9+uVh8knpHx2CQWtI0UrSjdbNbKGn0WETkB2diOv4InHBYerE3i4ipMZpsaROvP78kkmTk03IaNtclXDcrwiACaGA6NP8SvyMrRiNIOE14KNHAHGP3rqnDgQsWBpma8+sEuAvyPiPYK6lad4xPRxfrS9yAV5HpFqwA1CnQITBH8aIZyj1FppkQYj/tJrwUvyvy7IHzvL3vIACmyQfufI1CTXpYNSZseilogPBm/x+jdLwE8xvW0vOlpGcy7dVEkfXDNhD2JpSfJLYidam/1AwGa+Ml4gyVRk8QSejEtSvjYQFV6tACtVymOEwQxjesZGM/oUR9mYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DT+wNTyYOgOpcBa5txIT4HhR5nj8BVnnT9mU8f9phM=;
 b=EW9CoVgAh0yWSNnwo3vzTDwEhnRupONuB4ebgpap3yXytIfPfckYdG9q8g3KO+zctS0p7aKm0HnOc/sNtRt6D4q8RhRDDJLUenuCOtS6Py7nW3+URPDPNr3uNXMIaC2i9ATuaIb/EpTuI6stgCTLH3+PPkv6OXJh9MjqFFExX0E=
Received: from SN6PR05CA0017.namprd05.prod.outlook.com (2603:10b6:805:de::30)
 by MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 14:59:53 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:805:de:cafe::84) by SN6PR05CA0017.outlook.office365.com
 (2603:10b6:805:de::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 14:59:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:59:53 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:59:50 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 12/22] drm/amd/display: fix incorrect return of vblank enable
 on unconfigured crtc
Date: Tue, 15 Apr 2025 10:58:58 -0400
Message-ID: <20250415145908.3790253-13-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
References: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|MN0PR12MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e0e90d-0672-478e-619d-08dd7c2e2d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?82bILAG906XhU6e8er4CB98pgJUnTEMlby3wV+gmSZ6eaqBFzvZDC7pmFDka?=
 =?us-ascii?Q?jfZbmZzQDttr1MF1gp43kHHxP7ylqWYyEzyOJxMOnKS8qHEE4sboQCQyHfYU?=
 =?us-ascii?Q?jONUfvPW0Gyl56dvMf5oCyExZ/jPUr9DVkJdSbUCehTqXtmPnUhHzAvKM/uB?=
 =?us-ascii?Q?qhEq2YPbTYWAsEFdQEGQ+gQXc9mnje4hcF9uBGj40W5B0SpJM1tI7Zp/M05Y?=
 =?us-ascii?Q?XzbTmWJPsJwuIcP2oUkqkpx1j6Hu/ychQBcniExmodc+8R92cpF4GTkPQtUN?=
 =?us-ascii?Q?xDjYXXyQTkKNKRK+HTGsiY8OxPYJcryqSEICYvw/b6T516h5zaMgGnCUCUqr?=
 =?us-ascii?Q?tFBT7lbvEBkrAhIjIp4KWsM3WICJDRlrnHItC40SRNXx/9E3O3CYvPBtdKom?=
 =?us-ascii?Q?TzhVo+NmhJOfpeXrVgsMMWrfJauyI06BSBNkN3RSuOo97exDBaVloUboapNq?=
 =?us-ascii?Q?2yNmXtGuaJwqpR18ryKhBirFMJpyk43WLPDAGO6DuJnwadH2kj/2IAC9SYfK?=
 =?us-ascii?Q?pv/8C9Ey1bWaXJJt/pkIzIRz9NDjvszr5Thdkq7PVNaVWZF/oLOxeiNuMTBE?=
 =?us-ascii?Q?RlzPKHERG+oE0C1Pd/ajinGc6C01InNw3vw69dSp2OGU+Z3fSRkvXYl50P6J?=
 =?us-ascii?Q?Lfm4UudZ3wD9ceA2Xi3nt1FJC/YcmNH88TdoIcr/2gFnnpax48pzH/pAg2Bn?=
 =?us-ascii?Q?KZeaZ3rTcfrmBtSiYhtqSlDZK2b67PCY0drYLmWDgrdTsPqhmdKO5G1Ae9Hg?=
 =?us-ascii?Q?U8ktfCmhGvzPEEp7Vhdo9NRHYiVQ51XyPMOsi4XYjKSmo03DKFbjC5HTTx+8?=
 =?us-ascii?Q?uhCVAqmYjw78BtAcfFgCl9LFg9nBZ1WPZba7Dyj0PQzkLjqlYM3w6yygzjKR?=
 =?us-ascii?Q?6+jKo2QrYfHFhXq0u/QDw4QPahXQmNP/slXB9MlQreeB+FAv1UiXtLEGvxYJ?=
 =?us-ascii?Q?LIBEixsYOLTx5cXoQIUqVbuYthOUDpeWOBwmwRQ4Zshg62su1k25Ge75qBdR?=
 =?us-ascii?Q?7dWG2srThVrAfxg9BMzMtYkXEzDGM9Y9qKRBOPZZNq1r1NmrQbfRCkuwjXNW?=
 =?us-ascii?Q?0f8WqOpR8V0Lxr/reXKnELtjrJLOSWo/vhKsxl4OYN+k1hP1hg7LXvJypmzn?=
 =?us-ascii?Q?PJSkdCCrx2AxK/WTS+Uo/virI3vC79WxdxbcXtRq9ZMd6U2vL+HPQw5Mc8pF?=
 =?us-ascii?Q?HORXIK3crvIk6ceVoBT14z0/COz2adhO5syjAHJM8soTGJxB/kPZsI8clxyA?=
 =?us-ascii?Q?r0aTsiIGcCNCgPFfHo5F41g1/LXgjiqDYF85optrjGx/al6d+KTy9IQmheX/?=
 =?us-ascii?Q?PgdeaLUqASGO42/fK4y2aQgXAuRAqhQxjI9eGSFjsQzfxLt0bLl1Q1KdHknN?=
 =?us-ascii?Q?/a6QWo2tTkQFz+sWeIwQWdrjPFLZJoZPAK1ZqJG9EgXFsvVQBd4mvwwLlvsZ?=
 =?us-ascii?Q?o+4OR/KQTQJ2YENRA+5pZSLvZpIyndUC5i+bKQHPQqSizmZ7i6oZwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:59:53.1416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e0e90d-0672-478e-619d-08dd7c2e2d9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

When userspace asks us to enable vblank on a crtc that is not yet
enabled return -EINVAL. There is no need to queue the vblank handler in
this case, so return early.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1856

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index e8bdd7f0c460..22d9ded489af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -302,8 +302,8 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 	int irq_type;
 	int rc = 0;
 
-	if (acrtc->otg_inst == -1)
-		goto skip;
+	if (!acrtc->base.enabled)
+		return -EINVAL;
 
 	irq_type = amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
 
@@ -365,7 +365,6 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 			return rc;
 	}
 #endif
-skip:
 	if (amdgpu_in_reset(adev))
 		return 0;
 
@@ -752,4 +751,3 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 	kfree(cursor_plane);
 	return res;
 }
-
-- 
2.34.1

