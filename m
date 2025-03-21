Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC677C36000
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 19:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E82710E821;
	Fri, 21 Mar 2025 19:14:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="to6Fe7uk";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2E0710E826
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 19:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgMgnOfnPrLqI4bPoK/ZW+zsvjvTu/jmcDSzoE6O3Yzk7Hqplben00VBR+/qgXn18t046Zb+nZdUA559l9QryQPt1+qBOWC5/lgPJIHWT+YIEJBw5QC+KnoJ4BAWTc4cbl235iHy1k/M08j3tnsIXZwGO/cyIcSZ5J2Q53N+lRF2gZdRHyZZMAXCX5myxiqur1tItGTaw/yaD7Mt5z9sDgrmmifmn0iDxJOlS6WpNLkaxIS5lmthwFM9b3rl3QNhpqe0aLX/k8+Bx0qNldq3zzDE6qElt4kbfossBGTgkNV1ZASsP16ebc/25rbTYhL7rh4F4Dy3JqktLYlCiMfzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qf+IuWR4Vl5jDv8/mGwWAs4C9oS5IpWtI0JpbdSKGc=;
 b=Dsre2DoOscRRc0h23HTtHf+HisaFbYnMktJBMAgXmBohAYRmEbtt5MctPEFFfHdZXuLph6tRKDv0DweLDs+bZnkeRedosY7xtH/5PoYxtnNgmOCFyMylorJjtGyGpCfvzGxn/9L7AM4B7Xc067lB+HGa764K1hqQFqTh/hAv9J6jfNRKsWmymXZW9jo4mjChiaqEm4uJIRcImqES8sDw2mC2w2bVRJVPzLAkZifu6rQ38Hd70fcfQgNs9ARB2jii366g4tRovntzhOh+fU44NMtXXMonspCEddAUmp4QSFbDZpcDsM/FMx9e0ULrxo5meXA3i9InYTcSahIN1kH9oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qf+IuWR4Vl5jDv8/mGwWAs4C9oS5IpWtI0JpbdSKGc=;
 b=to6Fe7ukkB4gEIEsAlWB+MaXdKLGkr7jUny3bZhXU12F05+GSe0nbhRosqeuItRQuUGQJC9aC0k1z3sPJ4PEHcCsfRLprvgz/5cGgBY2CL/N2YiS6ZhzcqIX+uOKwmuGZMLyMXoSmouBXSJxDBnokTnMmDfXgp1wJVJR05GP/gY=
Received: from CY8PR22CA0011.namprd22.prod.outlook.com (2603:10b6:930:45::19)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 19:14:17 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:45:cafe::3f) by CY8PR22CA0011.outlook.office365.com
 (2603:10b6:930:45::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Fri,
 21 Mar 2025 19:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 19:14:16 +0000
Received: from saleem-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 14:14:13 -0500
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <alexander.deucher@amd.com>, <Christian.Koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <siqueira@igalia.com>
CC: <aurabindo.pillai@amd.com>, <mario.limonciello@amd.com>,
 <alex.hung@amd.com>, <saleemkhan.jamadar@amd.com>
Subject: [PATCH v2] drm/amd/display: add proper error message for vblank init
Date: Sat, 22 Mar 2025 00:43:59 +0530
Message-ID: <20250321191359.423187-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DM6PR12MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a6c901-5fae-419d-6815-08dd68ac9331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5x1/61hYhnMlQbxF2sxojDiTwzhAvrHZEp+8/zlEPR+mkLpg5VMrGvXntawt?=
 =?us-ascii?Q?tjIuSs9YqSp1dwpfnw4NJCFGo5NP+PpDRWanNwASj+hZ0b2+JX+6CdwOMOnn?=
 =?us-ascii?Q?gmJ6MvvHh+bNQ8+eOtyTno2tCnkjsWLwj4ooXMQJDDkoOVklwD7vlDjUXkn7?=
 =?us-ascii?Q?6iCVmmiC3ObrmPjnQB+T7tWswpSLhSnaEuULkYu7ygnJd05bcbNArx3onYsF?=
 =?us-ascii?Q?2BSM6Fr2BLgTnExgxXDTwjZo2Q5rihCfaf3tXYb1xT6Vd7kzei/crNJ2dUu4?=
 =?us-ascii?Q?Q18PX3/m5fbNZPFYmUV/Kd7xn3GJ3brgDlU4WnNKYFdixCscn/nk08qn5VLk?=
 =?us-ascii?Q?d6mq7/oAUDjXKreJJ9yk9OKzt/pra8SZzQgtxwUZIDkKSCAd39udZdjsfRzO?=
 =?us-ascii?Q?4XlCKSwdotk+JRS660lDa0B7YQcCOgRn33TdekG/oJdUSV9yx/a4YOs7Bzk3?=
 =?us-ascii?Q?slDaDJFRcsdF4pACocrRc2f9CpP3LL5Ts73p1PWXvjZ/JoY+ZBX6YmXKGE6e?=
 =?us-ascii?Q?Di/OrxGvVld0gOK4oFq4ax0zCjvhP+JfW9nQqBAnFBcshdqtQahuWFKO/BAH?=
 =?us-ascii?Q?fawL0XYw05VaiofvhXTRDCjhnVh9LekERR4PzQHBJl1wUPxY7KzVr4kWtg/P?=
 =?us-ascii?Q?SWoSDk9TLEFIbDsnVSH3Q04vcEjNtPjdwS+Eaese8icXdFaHvdA4NxccLth+?=
 =?us-ascii?Q?fItiwo8rtBQnCddJYtvzPlmUZJZXi6YV3WMTK/VEtMIhzluXGRbvGH+pB1Pd?=
 =?us-ascii?Q?onwIGc3OWGOw7W8JqM2xjGfj3F5xOk+hbaKmVpVeAy1LBfytf1Kt2D0pTtet?=
 =?us-ascii?Q?Uhhbkqx1usu4QT4SB8NDEtRZiIPBYUv0ddY0CJao0xsudJ3BsosNnyVhz3nR?=
 =?us-ascii?Q?2PlX7zkVv91nznfJS+CKWlRzGe1sXuvDoUHqIodN8S5WeRwdHkXU7GWGeZj6?=
 =?us-ascii?Q?wFTZFqrB8LNYgJ6Evum6y8WQk+lGs/uY68ZUDzmhx6r1M1/0XfWsCdcZrPyP?=
 =?us-ascii?Q?FgB+tKL4820O3A5cH2AVu+d8cCjYP4yyuApLOSORi1LpszJkz6j2vQpvau+6?=
 =?us-ascii?Q?dvlMbLkZUroor6rS2lt+Vj6A8YY18gF7UWVOKYzBsQuknilYbFRc6WmUV8nY?=
 =?us-ascii?Q?cL+Dsqcso45ftOWgEF183JqBXwTcWOhF1gvwb4U828vtC1vv1i/ISDWrDand?=
 =?us-ascii?Q?y/JhiciBMYc4Kjq1OVVOR6VdDS6+8MFeqMLv8my8itXa3tbEhHDb4LN3xRtn?=
 =?us-ascii?Q?YKR8CpyA1XHmKsVa/h1o78q8mZTdtZtqQP2JQQBRrDR2peQrTKDs9fOMPxsn?=
 =?us-ascii?Q?60bfuL0kExJhnQSZDHHidPHNrv7oYiVZzEwiQwmVislvkG0FOC72JffreHwn?=
 =?us-ascii?Q?CK4izMW4I7sEYudu4ey6UrAbJJClMR+RG+QbkisaZQEIymhGYiDsu6xCy/Gm?=
 =?us-ascii?Q?+7/MbhXHsnRTePI1RAV0fQjAkjXGVGFiUJ7FCu8lZRzQcxMI1kbDDy7AzNqg?=
 =?us-ascii?Q?w5o8KNg/hlype3o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 19:14:16.8068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a6c901-5fae-419d-6815-08dd68ac9331
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300
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

v1 - DRM_ERROR to dev_err (Mario)

Update message to identifiy the vblank initialization fail case

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8dd9bf58eac5..ecc6d48a2585 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2217,8 +2217,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	adev_to_drm(adev)->mode_config.cursor_height = adev->dm.dc->caps.max_cursor_size;
 
 	if (drm_vblank_init(adev_to_drm(adev), adev->dm.display_indexes_num)) {
-		DRM_ERROR(
-		"amdgpu: failed to initialize sw for display support.\n");
+		dev_err(adev->dev,
+		"amdgpu: failed to initialize vblank sw for display support.\n");
 		goto error;
 	}
 
-- 
2.34.1

