Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D3CD690EC
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 09:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4910710EC4E;
	Thu, 28 Nov 2024 09:16:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KgWp1+Ru";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 150AC10EC4E
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 09:16:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4aqsl3a9Hwsv0XQg4pLImmzHmEFu6GLAbBk/HDxfrx9rVeaclSRB4chqO8a1uW3pa+1l7v2NKO7R7TGmpppDkQ9361b1IieBLNaL6dVPCm7tncPT+7xNMeiyETM9FBs7xHirVjFxboUo18voWnzxWzN11LXxHQ1ai4rPQEFumHkpschTMTYIYx01E1zdNrPE99Ud/N5/Ok3+jtq0EUaV9+khfdoaK7msRXNgIuugUU4v+0zjl31bCZK1VPJHt0NX0+pJeogq/vbyozRtUHD+chIztibSOOdquSJPGwznTxIm/o//FoiTEF5CvLdsbyrwFdSOf4DgJiZ7mqY19xUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98tpz3xiMroEHiF6QkSZz0zo2kw6Pu3M8lEDIQQc+uc=;
 b=IrWUzdz1llgpPA7c3miyS+QpHGodLmPNHKFKn/hyMat7h8PQqjXpHy6sA01DeSIa5EA7Ucr0tv0kB3/5O0tOx9qyD3FVj1vIDljTEoO/A4cOhzbz2SB0A9InSDaV5XlkUlVqvlBugh6GLRrR0TOqvYjMOdGYp01xqle30q/oCJcZ7IInuzFRo60TB8t/so4va1ZWj+XI0hk88FuhiEtg0N3og86zdhZUN+Z2U92le5NoHQdQwzpoi2Vu0ceeDBu3I9sdTpyQXn+WwoX4UMvQMxg9Zhg7EOej83sEMPunPVxTzud9/6aFpW4laBrpEe1T7V10gYqvMQuxml7/87MJIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98tpz3xiMroEHiF6QkSZz0zo2kw6Pu3M8lEDIQQc+uc=;
 b=KgWp1+RujgIjT8Y1cgp3BJ+miWZfEtrF/QusC0Mx0Z4rCl47940WqviVAYMOLNiuqfxANh0B5Q8y1FKH4LU0l67n+qkzN1emrS/tiLLiEw5+ZgxdbmfdXRvBHDkM6aTRdvvCV30nH5YZE4+n8YvnHubjxCxjD/4ifYwlY9YWLFo=
Received: from SJ0PR05CA0126.namprd05.prod.outlook.com (2603:10b6:a03:33d::11)
 by CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Thu, 28 Nov
 2024 09:16:20 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::3f) by SJ0PR05CA0126.outlook.office365.com
 (2603:10b6:a03:33d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Thu,
 28 Nov 2024 09:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 09:16:20 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Nov 2024 03:16:18 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu: Fix NULL ptr dereference issue for non
 userq fences
Date: Thu, 28 Nov 2024 14:45:43 +0530
Message-ID: <20241128091546.462159-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|CY8PR12MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d1c404-2cc9-486a-4f9c-08dd0f8d525c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2te3m/VwTtT6KaD/5jV9pw//PJHvuvFOtRco5xHyd+d5Vx4d+HzKtwcQqo4R?=
 =?us-ascii?Q?MjXljKNHgtWuuu2M8ynhgz08E/+ZsdWFUpjEupKYc7t737MzGjzao66bj/Q7?=
 =?us-ascii?Q?N+9YS3o2IsJOR05G4N0E9dv6N99p1y2EJiKOOkgccvg/2zoK9zVNeMcSTjI4?=
 =?us-ascii?Q?pOQHpsbip1KpiXV60nU1t4EjYK+88cevSeh82xMfJXkRHDu5zuVlLttb1EF2?=
 =?us-ascii?Q?BTmdKofzHhpmMIUTP6XQPhBOQAjBIvmiYldILexsLwR6kW+p87s5cGH1v20B?=
 =?us-ascii?Q?HPtwiprZY9M2pqKGTSUqY9g9HgH3oHmhFBT4vTZv+QWKirUM0Z/9oPZ+0QB9?=
 =?us-ascii?Q?JcadbTNaGv30HCDHvxtmuzHe5dzIjNmsaNplM1G+kt57L3/7FrThKLFdZZ0i?=
 =?us-ascii?Q?BXuGiS8keOUegDMq2SBnv84dt0uTtPwzVlbWQ0VgqroLoaaddfaUZDFXmZtq?=
 =?us-ascii?Q?VY+2VZdKmOIDNNQgOUdXE5MXiwnbeww3dk9hdEcCVilbehc16aL/aRIfzDvI?=
 =?us-ascii?Q?FX/Nr3L7e6I0/cKmNY40RmV8Y1pLVo25g1lDNdDI+oecpfV9WrXHeT9JlA3n?=
 =?us-ascii?Q?gh9GpQFBGOiAmljUux452i/uS7ZQcAaI5JnNC+oNmCA/xO31Kx32FaYtR+96?=
 =?us-ascii?Q?03xtel8Ouy3NeI4+URbYQuTKG9c2riWoBmnEAQR/BGd7AVc5uDoG3wFfuoJf?=
 =?us-ascii?Q?SrasdEei/WCE3m6ZI2yyO+xs94/fwFZTh3NrTavD8deI3bwJCLD4eeAJKmlO?=
 =?us-ascii?Q?mFExHH5aA6Rfxb2NhifxeHzNlqJLZ3w3lcQocdztuRONtzTk9Krrb7DNQ4Z0?=
 =?us-ascii?Q?8Fvct9Me4bZw3Kenr00NYWR5yfHNymCJcHFTbri+PXEJI7gwisTFTsA27gz+?=
 =?us-ascii?Q?mez3Sre/zjnL74tZTHtEtecJBVxM6zRN1V8rr8At8EcvqEqP0iqY5VhfJ8Yl?=
 =?us-ascii?Q?LIBoQn+0EZY9BBWIXeGIuNCCdrrZfjvhoIlmA1KdlBx9eWbSWHmcWc6rJz1H?=
 =?us-ascii?Q?kQNCScgI+mflppP9xaECcuGPXXMl38GDiAmYYDsRZ0CneNtqdXICkbk8ndsW?=
 =?us-ascii?Q?tmZWM2guR0xHqt/fwgDDIwBr03BVghBa06blhfQ5/6qHUg60d3d8vX6PFuj7?=
 =?us-ascii?Q?cuiVjvqoXwUtj9mvNrLkTZAavq7pdocyDb2R5eqxcN3hVlchf3U5tIuY5TLN?=
 =?us-ascii?Q?jtwOeqVozR6GSQJmi9ZUbhluNQU5EL/JpCvHDXs99fGFjGm2/35A6QmZz2LG?=
 =?us-ascii?Q?weCWYEOutvE7ru7KqmG++LghP3HGzzjB/Jf6x0jgQq/BBjhZXvYgFfQtZe9l?=
 =?us-ascii?Q?BtITstLONn/SvAbmdzBM3cs6FnWjkU+aKjNuP+yupjxQEjZ1zWSdjGHhSqcp?=
 =?us-ascii?Q?AKhobELT9KLcExCB7/up2arIvm1Y8AmPYrGQ0E56HzzrU343uaaxKMo1CdFy?=
 =?us-ascii?Q?vpVRfOtp1CyjjPHmXsePWgJrStHFxTgt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 09:16:20.1502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d1c404-2cc9-486a-4f9c-08dd0f8d525c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299
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

Add the correct fences count variable [num_fences] in the fences
array iteration to handle the userq / non-userq fences.

v2:(Christian)
  - All fences in the array either come from some reservation object
    or drm_syncobj. If any of those are NULL then there is a bug
    somewhere else.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 877cb17a14e9..3a88f754a395 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -825,7 +825,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			fences[num_fences++] = fence;
 		}
 
-		for (i = 0, cnt = 0; i < wait_info->num_fences; i++) {
+		for (i = 0, cnt = 0; i < num_fences; i++) {
 			struct amdgpu_userq_fence_driver *fence_drv;
 			struct amdgpu_userq_fence *userq_fence;
 			u32 index;
-- 
2.25.1

