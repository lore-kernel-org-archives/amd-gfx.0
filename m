Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9C6C5B552
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jun 2025 15:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB9F010E143;
	Mon,  9 Jun 2025 15:34:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gIKpf78q";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D76CC10E143
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jun 2025 15:34:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyxEZqh9b05VvpiX3X39wWaHZ6wZHwZfxYHaPzEBlPHvGarn75rpJ4cMsBFw2z5OoGAEly7fxsCVotF9nkOGNnGl5RpL8vYfSiuhA27CM1fZ5rripzjWhB2yojnnHkdkInN2vAiGXAEgZu1f47k+GS5XCV9hIMGk/+USbx7fczCPbne3rMcMs3Y+6v0RfItOJgD4PtL8nmseHBMQGdx01U9xgI2Z6gj1QhCGq4nMsJpPGiFKE0wlfBYeuKN8JOF+36KC83wmA5YfbrAB9CgTsCM01dSik0B0jLN2Uo7/l68Hybx2KvZ7rq2sb45i5JmwLA0c9MavP/l6O68Dxd9xNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+OqIIwPforMZGWwf/Vkj8O7Kkxvd3ajxIp4xP1Gj+U=;
 b=UP2pR3pt8o5iRXTw8nLPjRLfO3G1sG6QGrrkTlXrRao1CmpNqcSefv7yziq++PoqB2zNZhGUc08SYCjQ/1VJ8r2LVnlnGthmC6KN3tRzipWp3qPg1cdVsBF5rG9qewbuSOAgYYATqXaCW92wegZ0R4+fnURQqyF8VQx87VOd3cxVDZsget2tNGJdi9DlMQmAkxLAkhfRH+A5204pmi2D28qXWkRv0/U9SoZO8mhbMzpq0EwBqGNe5IKYquHCT0zO6X/NTrlci2BIA3xYVTduUjuvrPzqhMKEgORg/LLqm3l3Onixsfm532AhXpEQzZfP5QQ00p8rCbF6/3o/BRldCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+OqIIwPforMZGWwf/Vkj8O7Kkxvd3ajxIp4xP1Gj+U=;
 b=gIKpf78qslyanLuQSih7H9H7AFzzd+RVKztJqDV42huaAqBeV7uRNG7XFUVvHc8PajugcMM/baEPbGl4MWLkd6Vj8FpHl8T7A8MF9peS6aQ8c2pwKekUnObuWmtsWpGKAJkwN0JhVoOtZvlJqcIpGjNnQvLcOuTchdz7V8C2uHY=
Received: from BY3PR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:254::31)
 by DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 15:34:26 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::1a) by BY3PR05CA0026.outlook.office365.com
 (2603:10b6:a03:254::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.16 via Frontend Transport; Mon,
 9 Jun 2025 15:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 15:34:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Jun
 2025 10:34:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amdgpu/mes: add compatibility checks for set_hw_resource_1
Date: Mon, 9 Jun 2025 11:34:10 -0400
Message-ID: <20250609153410.15977-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba117ca-d471-49fe-36d3-08dda76b1dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YTbP/JvWzB/P67nfFpvNirHRTUXE5qu3qr6Wfd1I1vemGR716UQBdW6v8moq?=
 =?us-ascii?Q?5S3EiS9ENJIsC2NttenIZFceecFypU6GA1xvtqm1urDDRPO0+81lklYkK9Qs?=
 =?us-ascii?Q?x5cXtQlHS8iBPsrFawXhi8/uximNm7C4H11/3T0qXYXfAaIKO13XH742LNTX?=
 =?us-ascii?Q?BQheKIXMh7Y2W+UR2uiPscxet8UnEPLKdyc/Ly4BxkUgGMZw9aGiE0PFfrxb?=
 =?us-ascii?Q?ltnwMb5occxUuyrPQvQqDkCKKB9D8UOCWoEYrilup+xdlw3J89mOHWnDbk5K?=
 =?us-ascii?Q?94IJpYvbvG+Ae9+venHr/51+w56tnRJWnIrqPJ6JTmi7yGcqyGx6fG2wqdro?=
 =?us-ascii?Q?s/GgRboGl82CaqOiCY0MauLQ28aKHT441U4eRyFf5DiYvDLGCnV3Pov+8XVt?=
 =?us-ascii?Q?oPXKpLWmRzKDMND9KrgTNxjGvyGS1eX1rkJnel4ipsyHS98nYvQWoFW5A7CX?=
 =?us-ascii?Q?Ws16d43j9THCGNASDQd//aaRH7WN+xY/POBA1nylQXOyXR5hjnFqoWKWbVNN?=
 =?us-ascii?Q?ONvLCCy1JJYGlNkQWs9vU2WbnutLS4QBYYt3EKlJhShPl2ECbOhyFJFiQXNF?=
 =?us-ascii?Q?If/yf0wpXrj3M6PSEP07gRHgwoPiSqYs03HJ562nMq5OmrMvcIzwZz25Zdkt?=
 =?us-ascii?Q?7K/EGR5LVoT2ftUzLaVfGBoavu1jqPMNyXY9vS/AKYhU302EVlqjJcwV0c2L?=
 =?us-ascii?Q?726ukq8FuOKpU6OL18hatr83keCzq84WzNzpi45qoCTz5jd6sIc4K/igspG4?=
 =?us-ascii?Q?li7G0s1xmWpxm6TzsMSUtgNn0pjMbJelNYB7LCO3/406UfQCJNFEHLyhpDBB?=
 =?us-ascii?Q?S7A00yVTnP7kbL5lHUB1A9jtqX1P7ZaQ3ntPPb85GbLoW9cABbSLbMYs0j9X?=
 =?us-ascii?Q?+56FrmRSmhr6eHYlB1GotZiyxSkXcfIM6mw1WtX4UCwA+Xe81dNdok+v76c4?=
 =?us-ascii?Q?CjlaPuakXPggNqRFtToK1m3mVvOIRbqptoNysJ5A9kJfhlTqdhL+eNSbr/+G?=
 =?us-ascii?Q?YSlGP5HQ9jx0evU9spKVBiZTO5o0x5oeZy6Nu+kZI2dBZZphQUA0aKHz+C/6?=
 =?us-ascii?Q?IoYJYoxNw2VGQs9mIoKL0m8y/MpEsqlmtg+M548QiK+EVmZMxvQK6flB+nco?=
 =?us-ascii?Q?1FU2NmBAdLrL96vx3kDDYH7jj7w1h7WMrcBEuYpwpvP6ZV+Bjx7Cej9n/8zH?=
 =?us-ascii?Q?k/kjq/wCA0hUKw6ya3QvQ4fYTM6lhGW6Zfkp3axYtwtiLKrdspSrf0pfkyU5?=
 =?us-ascii?Q?Mxh4urD2OoMLz542lbWNg471qQlGTSHBHORdIdSx6mechZaBdbMNZjJWlW2+?=
 =?us-ascii?Q?1qkQOgEQiZQ3J8QDdsM9Blk4Q5wkkkwdq+zEPuDreseBmZYvKijMIZjfCQP0?=
 =?us-ascii?Q?UY2e95VldaV4UOZthWM7hygok8QG3IeWQ4wpgP2VsRQuDUW6sISrpgMSAFlZ?=
 =?us-ascii?Q?zT4Gva8OQshb1AZ5bDPJTR3EtM41HnYXy0Gq87lJ2lulnA1bMtJ7lQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:34:25.7826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba117ca-d471-49fe-36d3-08dda76b1dc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347
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

Seems some older MES firmware versions do not properly support
this packet.  Add back some the compatibility checks.

Fixes: f81cd793119e ("drm/amd/amdgpu: Fix MES init sequence")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4295
Cc: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 11 +++++++----
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c |  3 ++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index c9eba537de094..8a3e3aa86c5d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1630,10 +1630,13 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		goto failure;
 
-	r = mes_v11_0_set_hw_resources_1(&adev->mes);
-	if (r) {
-		DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=%d\n", r);
-		goto failure;
+	if (amdgpu_sriov_is_mes_info_enable(adev) ||
+	    adev->gfx.enable_cleaner_shader) {
+		r = mes_v11_0_set_hw_resources_1(&adev->mes);
+		if (r) {
+			DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=%d\n", r);
+			goto failure;
+		}
 	}
 
 	r = mes_v11_0_query_sched_status(&adev->mes);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 68bef36aae3b8..c1311de397f30 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1736,7 +1736,8 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		goto failure;
 
-	mes_v12_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED_PIPE);
+	if (adev->enable_uni_mes)
+		mes_v12_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED_PIPE);
 
 	mes_v12_0_init_aggregated_doorbell(&adev->mes);
 
-- 
2.49.0

