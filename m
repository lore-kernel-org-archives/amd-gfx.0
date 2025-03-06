Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AB2C282DE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 18:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D96C410EA7D;
	Thu,  6 Mar 2025 18:46:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kI/y0MF/";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38BFE10E329
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 18:46:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRjwHaf6vlKTYiHeG/W00FNjHdTXjyfvIOM2vl1kHL88XXD7vz0WOAdSCRqcwe99EcnC6lDsrsVbfL89nSjfgz/c7k5Hm21qs1MfK746uTZkH0j+8fgRpGLZ9M3mPFy6RKocT5CucDb349IZH5IDd8DVw2pnFxO1gKR07XfBEPEqaSaS6/J8HIprYLW4tbUTMKJveZrFYMPjPPlDqxG+1mUhpc7vITgMxLwFitpW+TtIj1YNLVUG1ZiOykJqkg6oIui5sMf8VwU73me7Rq7aVKFUd9RIldXtWGxMVBaMeebFhKicNh3QsZ2FJ/lzE3zHFGmoJ/Z9PDlmvbKCOQp9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vADAkEkdsVJ95Ns/ZPgLXgiXMHlWeJng7nZvuCryYGQ=;
 b=EHnXLrnG6iKdHXwHCE5soN9BZl+AN0XAZtEyQH02kI0dZ8+WWzmRUjJ3ohsDDHOSrpJyjdHtSaCsJC2w+QajBA2GU2qzb2p/mhOKEKLRz5LSaybdgaKF8tfgPiPANtpvy5KGcId7c0qq7FZsYSmEzlTi1vtGQpDXz30WOdvDIfmmDfDH5ukS8gdXhT0hmycdDVXaeN+yxtrT0GWJwbf0jG4VHsgqqJRQkrujHk4tBKB6OwXrmYGOmmdEPrsByDdkknr3wy6NzKx/FkKdOfVc8DLlix7C6SCqd1feKx/RT4/TfPqULbMVvaDyJMylLRynBt4hYppJ5R88HA8YqK4Bag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vADAkEkdsVJ95Ns/ZPgLXgiXMHlWeJng7nZvuCryYGQ=;
 b=kI/y0MF/OmcIHJJ43i5nRFTnx+aXbHQfnGzkJWvZChC1It8daQ7/Gb4RLU5NtU5dd8lqVAvW6CTNSgK2jCY1NsaiJwS96HXmK+znUmh9aGakJ8x0HiI5WE5oBhP1OSdOfhc3IhZKwsM4rSMy9G0P6xYyqvZUCv6tV/2AnMKvtjk=
Received: from BL0PR02CA0022.namprd02.prod.outlook.com (2603:10b6:207:3c::35)
 by PH7PR12MB6933.namprd12.prod.outlook.com (2603:10b6:510:1b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 18:46:31 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::79) by BL0PR02CA0022.outlook.office365.com
 (2603:10b6:207:3c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Thu,
 6 Mar 2025 18:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 18:46:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 12:46:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 05/11] drm/amdgpu/mes: update hqd masks when disable_kq is set
Date: Thu, 6 Mar 2025 13:46:05 -0500
Message-ID: <20250306184612.8910-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306184612.8910-1-alexander.deucher@amd.com>
References: <20250306184612.8910-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|PH7PR12MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: c70a7f38-f308-4bee-31c7-08dd5cdf3628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9AUaWitxyV9nkhuGQPKhvsTmi+wuWO9sXYvCseH+8PxjnyDp6GE3Qn0Qc5dA?=
 =?us-ascii?Q?MQq8FpuGxBDx9p0K+Go3+TNIZiO0GXRxFTt4zxV5aacO555D5dv8wekBJBAv?=
 =?us-ascii?Q?O0nAN3+31OLVzSRc2d4Qi72bN+W+PkmLpSDh2otvWvvNoHITmAlPsgpLSk9J?=
 =?us-ascii?Q?QGDtk51fqE4jdVEARP6PCQwzPFR3vs6bI9DRe7RRLpASwW4rBq6zSHpg1jZd?=
 =?us-ascii?Q?l+iRoVjTrbPJpDRNLBBfUnT9RNsgxb7LocpO7nkJYtc1+HvgHPCxKIyhzd9+?=
 =?us-ascii?Q?JcYfVFO46b0pXJENXRfFdoqL8bUEVg0Ou4Jvu41qq7ujlJXhD2JSW4Of5ETW?=
 =?us-ascii?Q?wbwSO4AksWCfDckO/6broNL30aS3pRwfu0iOru+crTaigXZdlwTLnxCsuA+3?=
 =?us-ascii?Q?TP31bVxxVCQayY1C5YcWgFysj/FReOVpXbCFHYLEp0mRr8uYSJk4EmaVLdgc?=
 =?us-ascii?Q?KF6jHKy0YV/59LZc8A7oK51IU1C0Nngm/Jp5BguSQ+GqeDY+/JVRXPcrpJ2E?=
 =?us-ascii?Q?zYW2NFXVlACyoJzg5fvhZshK8oUaZjgcWUH5O2Da9nnCO31GcZMeMzn2qBxA?=
 =?us-ascii?Q?vow3r4g1uTJ9zMmfbSEcSZbj06FUMy21DXzjPIZcNrQKWJkiM9enOw5ljtXA?=
 =?us-ascii?Q?phWsFDFVKJ0uKqEGeRsquGdZTWrf4RNbkS5PQBKnF7DoPuGxiDTIMeRqmm2M?=
 =?us-ascii?Q?J1WFHLvwFiuIMnYQc207qTbWNLB1dxYGseWH8Zy8HH70KpFdnA2LkI59Auqt?=
 =?us-ascii?Q?RE7Owm6Ruqp1ArzOrVCCiBG7Ty/P+zgwhQMMWsIdgxujE6KoYYw3jh/et4uj?=
 =?us-ascii?Q?KXakUKaW5x1tTaC7paM/hUEC6wAKWCij0chKLGszTQqOHnDciGuJGAR5TKRJ?=
 =?us-ascii?Q?l/JN96nvp9pDT6hBUaei03qsl6HLcyWmVYqrpHZGn415I1JkXlzSFhxM6VgZ?=
 =?us-ascii?Q?VuyybKjVFRRljMEBCdR+QO2Z+sswbpEqjQHt/K1j9OAqHNud+G3Wsmal1bJW?=
 =?us-ascii?Q?Ns0dmBI5EQdY5cJIfOFyy01XYd88T/gqjrPjmPMnAcpw6Xhjx29Sg5Pako+W?=
 =?us-ascii?Q?c+7Sp8eX7m0CkCQ9W4lv75c3y8sxONh9uQ0txM49rhWb3dFMs0g2Io/sZEKI?=
 =?us-ascii?Q?jdheuZTDdNUecqfx7j4vJVMKGUfZYzPfkcCc/tgK1hJmTgQbCs9kZ/uLdKrC?=
 =?us-ascii?Q?6NkKAoi56yE6wZ2uEp6mRjIRMK1JceRe+NPeSvSNeBfMpGUFtnAOg3m0BVW3?=
 =?us-ascii?Q?ug4WdHUd8RMtjyXppaqHUwjR2ZH5q8avCWMOW3bo5UU6F4CgWW0TQjhi/m1T?=
 =?us-ascii?Q?+8Xj0FsqI6YFRo4aFbvKBWc5Ikn00y3Z6rJOpjOYXMdLq8FcnmPGZng1ej2R?=
 =?us-ascii?Q?1S7ncSiB98i38lj7NYIPPNibpxURCnnsdI9uuAqJdeVtl0Hfhq7ZcTfD6Tlg?=
 =?us-ascii?Q?thiqlqSxwRS5WzRSH8f4RAtIcYffpaR5wfRgJ39pVu46z5uDrdiPo0FUbLTE?=
 =?us-ascii?Q?ARt6AITlPdc2H6A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:46:31.2075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c70a7f38-f308-4bee-31c7-08dd5cdf3628
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6933
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

Make all resources available to user queues.

Suggested-by: Sunil Khatri <sunil.khatri@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 5913c5ba85ed0..e585e8690edf0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -156,21 +156,21 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 			 * Set GFX pipe 0 queue 1-7 for MES scheduling
 			 * mask = 1111 1110b
 			 */
-			adev->mes.gfx_hqd_mask[i] = 0xFE;
+			adev->mes.gfx_hqd_mask[i] = adev->gfx.disable_kq ? 0xFF : 0xFE;
 		else
 			/*
 			 * GFX pipe 0 queue 0 is being used by Kernel queue.
 			 * Set GFX pipe 0 queue 1 for MES scheduling
 			 * mask = 10b
 			 */
-			adev->mes.gfx_hqd_mask[i] = 0x2;
+			adev->mes.gfx_hqd_mask[i] = adev->gfx.disable_kq ? 0x3 : 0x2;
 	}
 
 	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
 		/* use only 1st MEC pipes */
 		if (i >= adev->gfx.mec.num_pipe_per_mec)
 			continue;
-		adev->mes.compute_hqd_mask[i] = 0xc;
+		adev->mes.compute_hqd_mask[i] = adev->gfx.disable_kq ? 0xF : 0xC;
 	}
 
 	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
-- 
2.48.1

