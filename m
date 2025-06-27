Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC566C7EE2A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 16:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94C9510E341;
	Fri, 27 Jun 2025 16:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gRFbU6Kx";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5633410E341
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 16:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIaOhGd7iltwfK9nvIt5aSwjToRtmQayOuznGqGHRLa2F1ONiNzs5zPgCb74vOoVJTUddndimQk4ZoGpuU8h83vyzISXtPakahFYnnFhdYvwCETA//kH3jZf3i7L1jv5QqaSgpSCtXfNkfjnTrCoZYFUNlYA0zf87oaPLt0PWsfKGthGnPx3FQdgL0Gix64naVZ/y6p8w0uChEMwYlg9728U2Vn6XQ1cLNxbqJ4Vdbqg96c6+XDL+WrmU/nc+4Qo6Z52U83RaNoTtqFHC8z9LKROT1JdaZZDIWhGLZLbzwNRp7RyaYiCPi/Dsgm1Ah6aR+qWmmX7Outy6UDXySmhfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwkBwcokoNnF6MxCABBjQcRhM0N910QDMtoNgDy6Dhc=;
 b=lPQV21/tMPS4lmrHNRuz7N2f9UbLifmv825zg5/xU6q8gKB/4dm+5qLH+i+ThB+9ZVitkFXd6LM/67nyUz5Oq/LeOUKuETMGw9xGo3u6FQX5VwjnlX13CQcDaqegPQK8rUMS7/JZuJwh9rdkfSkBz5i/d3ZnJo3plk53kfSzpY+UuHkd0XaPA1R17VoEbEkByvNYiItRuM9TCeNnFeFqdCQSy9JU+6KQDgAdCTtPYQkQ1gbmq0UToikC8+uSZ7/vvyHwgeBB6lcKSbUD8pBO1MI2NTlDtlrpShvpjZdTJrjak+ZAB3ri4wHTELaCpYt/diwXlkhBcfiCUzvHbZ/ZPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwkBwcokoNnF6MxCABBjQcRhM0N910QDMtoNgDy6Dhc=;
 b=gRFbU6Kxr5dp48wGlJWIhE61LpaJ9zjLmDsbRWKnXFcfV6CVMNLBa2raa2JBDmG2pjj4pkfs2QJg3aDpDKzMuzd9XFwkrhjmciYkOE02hIN8u1pWZo0O7TBL4zjKddtAAaERnzC627dDehbzBZGCFQwbdSBw9XPjyjVOqrc8+Yw=
Received: from BLAPR03CA0111.namprd03.prod.outlook.com (2603:10b6:208:32a::26)
 by SJ0PR12MB6902.namprd12.prod.outlook.com (2603:10b6:a03:484::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Fri, 27 Jun
 2025 16:46:14 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::a5) by BLAPR03CA0111.outlook.office365.com
 (2603:10b6:208:32a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.23 via Frontend Transport; Fri,
 27 Jun 2025 16:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 16:46:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Jun
 2025 11:46:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/sdma6: fix user queue firmware version check
Date: Fri, 27 Jun 2025 12:45:58 -0400
Message-ID: <20250627164558.27382-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|SJ0PR12MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d576e3-36d5-46f7-2c6b-08ddb59a2066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qmHeb9Eb46zJPjS4/YfVo+HsZrAWvOGNrVXuiuY9Gu5LQ6yVaD6uDYJDdpmn?=
 =?us-ascii?Q?SQoiTgrjtvNWONYpZ/V4/jolyadRI7ScWRyve/u44G98ISSh7n5IcPZO5dwj?=
 =?us-ascii?Q?8XSjiqEOldEV/4a0QHdUP6gvc0xGKI8GJsFnlgsrBUKy3ka2cn0BElGJIrLC?=
 =?us-ascii?Q?Ji7AfKF80X5Vdp9e+cU5qAZuMYEND2EQGn2mP5as5dTR8GgtROe3+vR3XHyU?=
 =?us-ascii?Q?ag5j8Ejv1H/5KxIB/C74LxTpGSdtVsrzkRwZyoh09JHWz2c0gH7+YW1jvThm?=
 =?us-ascii?Q?pk91M14NIBbVmFhumGX4FR7rg07eB18QtimLEaM/LU9FmdeSbhKAZkc1qQon?=
 =?us-ascii?Q?J/Uuw9IEPPC3FxbI00MaZgrmsE8lCancv1T2nD1auFjGCqI0MxlqN3wV9e8x?=
 =?us-ascii?Q?+wXYahwobsUxxV39nq7TI7AxIzahBPJ2KcuK3bz3qbNGvpJvuDVGnVG9yGwZ?=
 =?us-ascii?Q?rQZMmo7MbHIOOccHwRzFQCIPAfoa45dN7Exi9u4BM1iP1iQeAZx3bXMzIc9K?=
 =?us-ascii?Q?+417bp4NXwC0zpLPokwVuzvuS/Hu3O8B2giuz27qjLzebHYcwjq3/uAP54j5?=
 =?us-ascii?Q?p4euouBgiRaWKMw9U+GSzVwYM6ibB7zeMEOO+XkGHxVtTVELXf68S6JkFST8?=
 =?us-ascii?Q?H5gbrAWVoz5AARwNM4/DqljKC+CJvxXq/cHVj+OZ36j30mFsP+SAJMr/kik2?=
 =?us-ascii?Q?azO/n9q6zks+YzEfS/mjzNlM4O5hWPdCAZnqIuJP4NsLdDm/pIMln7J19lYd?=
 =?us-ascii?Q?9EL65Wx20YM9/gOY0UMY1cRKvCSPzu7uGg4Fb0VICgpoRSk2mkedDhaywpZS?=
 =?us-ascii?Q?mQ52a0Di6CMlbzCLqq0P1I2Ma+fn10DDtIM4JgQOUUMbic51hPkMJOlF44yN?=
 =?us-ascii?Q?hKkiKYPRJOYRgQ8j1Za0n3ddI+TAuTt5kyExWuHDHO6TkggNVai6r7hMtv8s?=
 =?us-ascii?Q?EUkt3T2K5mZWkrP4W+u0e8Bs0Phq6NvifdrdVNizk8odGEAvRSNPM+E9fKkx?=
 =?us-ascii?Q?QvDd9nC6ytHYeFkAQMO7NVFfEaNkPJC5VTXwhcD/3sjnJ9gZL1RZW1pJ6grs?=
 =?us-ascii?Q?vtbw6MNnePT1fD7j3+66k3xCBoyXhz4F3Lneq0X94bTvk7Tu3tvr1HVXXu18?=
 =?us-ascii?Q?bNt7uDg1WrFZSeZMvqLDVk5RTqrMNkz7b+4BoLqvVHD+0hKKrW9GffsHwqOm?=
 =?us-ascii?Q?eVfpA7G1xj0r9k+oKGRNZNAAo/UT70lzBllYa7tthlCAMc+SoVYMq4n6uyF7?=
 =?us-ascii?Q?o5DrkjfrxhvTjgxOy1nNk/bSReH27bKtQs0UBe7VxqXp6gXGTJcblwiMkkM3?=
 =?us-ascii?Q?HRN5Zb/JK+DWCFuqwY+33KZRqr/v8KnvMyhGdLJZdzx4utSlYuDNpMWk1g3N?=
 =?us-ascii?Q?peqtOmmUw53RklDO3Rw7HPpKeReDGnIl9NvTgKt2Aos+mNZ+GB8IUoTjiocl?=
 =?us-ascii?Q?jeprV4NV8kcs4NB0TUS7yiegiyoX0ILcgduRGlARvx+EGI3ODkMvyCv133Fc?=
 =?us-ascii?Q?wVgV0dTJCj5JwuTXP68N/d0xwCwHi32aGfPi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 16:46:12.9186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d576e3-36d5-46f7-2c6b-08ddb59a2066
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6902
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

Some of the versions were incorrect and add support for
6.1.3.

Fixes: 3de84812c702 ("drm/amdgpu/sdma6: add more ucode version checks for userq support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 2f3250d30bb01..273f9a1567761 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1392,15 +1392,19 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 		break;
 	case IP_VERSION(6, 1, 0):
-		if ((adev->sdma.instance[0].fw_version >= 11) && !adev->sdma.disable_uq)
+		if ((adev->sdma.instance[0].fw_version >= 14) && !adev->sdma.disable_uq)
 			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 		break;
 	case IP_VERSION(6, 1, 1):
-		if ((adev->sdma.instance[0].fw_version >= 14) && !adev->sdma.disable_uq)
+		if ((adev->sdma.instance[0].fw_version >= 17) && !adev->sdma.disable_uq)
 			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 		break;
 	case IP_VERSION(6, 1, 2):
-		if ((adev->sdma.instance[0].fw_version >= 12) && !adev->sdma.disable_uq)
+		if ((adev->sdma.instance[0].fw_version >= 15) && !adev->sdma.disable_uq)
+			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
+		break;
+	case IP_VERSION(6, 1, 3):
+		if ((adev->sdma.instance[0].fw_version >= 10) && !adev->sdma.disable_uq)
 			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 		break;
 	default:
-- 
2.50.0

