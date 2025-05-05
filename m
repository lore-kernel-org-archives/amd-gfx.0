Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07DBC3ABAA
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 13:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D225D10E3F9;
	Mon,  5 May 2025 13:05:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iCN/44yU";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F085110E3F3
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 13:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ra1gkM48yxd+g7iYzPm8J2DRI5ytJgiQiEG/Q1FyMSyk0HoDdQMLqjRkqhPLVSgmR5f/Kqeb7D4Wjc58Q1QgjE4mlz2n7SpypWZkBLCg2KJgHhvECrP5PXjQ0tB59iY0sjgnXj06YhU/13/YdScJfgXUY7qUw4+bp+1gA/DvqOjiYTaFkxbksWHGFX0edaVpUoBOVFLaxOuFRNQQ4SX2sbKtsikAYo0ro2GaCgLNtFGa3QDAMkjjShi8tnLeWBuV3Ca88sFMbTwLPYTDX1/M5MCbTo2Pvqcpt1PdK+ZdmY2D0M2l28vwuN6E1AIUpLxSLhCLf2A2NgxFp3ZaYVkLRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74syTndZkzMFcscJpw26mD30o9Iu8Rho0BZm9PNN2X8=;
 b=TUpqZsHFSUCRCztgq9fqBBmSCtgvB7Qf/mfN9vEg5lBL8mkT8Dxl6YIGOdj41cQj5CZ9ed9651C/UxwTqZ6nM4SxgE6xUgA7GVJvvNjeXaGrPFyqnfgFb9bi4U61cHDMSewEBT+CDu7pJSBWvetYYc/3GBKqfd99hVCEvXGzheff4VH27hzoiEzkReJ9Q9Olxg+KDPLv8/f7Mf6gE+7b1GpNMro4BJqTeVbHcyUP59hN26PlNcHJrD/dl92rC6+wiNBlLHBYJMajwpXRZ5Syg3gGxjDNE/GkhauLtJ8zpWu9QoGTHPkFWQC3TcKp2qPpdhmEHzdk+DAOUH4lh/huIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74syTndZkzMFcscJpw26mD30o9Iu8Rho0BZm9PNN2X8=;
 b=iCN/44yUnfiMEnjmFga58h1eZ+mzuOBVzwJa0e3tR7CArIDsLAsl8N3A33WZZRa31ZQEEKzBCaWY77/Uc4uEa25TA0m5X4tO3sqMF92GuubLgf8HG2rcKww955v1nXfD5Yjln6WY6QzsWqBGRI5hqEamdP71rtE/YU+ytejGc5c=
Received: from CH2PR18CA0025.namprd18.prod.outlook.com (2603:10b6:610:4f::35)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 13:05:16 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::82) by CH2PR18CA0025.outlook.office365.com
 (2603:10b6:610:4f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.24 via Frontend Transport; Mon,
 5 May 2025 13:05:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 13:05:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 08:05:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Alexey Klimov
 <alexey.klimov@linaro.org>
Subject: [PATCH 3/7] drm/amdgpu/hdp5: use memcfg register to post the write
 for HDP flush
Date: Mon, 5 May 2025 09:04:55 -0400
Message-ID: <20250505130459.1985637-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505130459.1985637-1-alexander.deucher@amd.com>
References: <20250505130459.1985637-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|BY5PR12MB4099:EE_
X-MS-Office365-Filtering-Correlation-Id: 8588e457-f0aa-4863-efc4-08dd8bd57aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uXUZ2NPCpZcR2LY9O9PJEQ+mMM0WNcYYDKhw3MY/FosJb1gtweptz9RGNP4M?=
 =?us-ascii?Q?Wj61M2A9U8w5vQmLTo/9JkfJIOXoCdF2/Z6nIczqXi5af1XM2RZCp5D2Klus?=
 =?us-ascii?Q?m8UswpsDQd6SdTOSwRXXZf4pVGV44wQa7yKqAb5Lr5FRORBNsu8e+2iWgxot?=
 =?us-ascii?Q?oSmIkdf9z5JRSXLoYhrzelwN9g+6cogoUzFZ1ZZtZqaUksqfiHDD4iXW9Ay9?=
 =?us-ascii?Q?ZP2+i2OSAr0++mUsYQuA8WWb5MHJrIyKuq+7D6p3IWbPZcfeqYVe+ggzPJWn?=
 =?us-ascii?Q?mKlhntkZciAwg2WM1gxTZyqmrdKqAqurOx9ly+r8XxN9ZZ6i8ivT0uj783bl?=
 =?us-ascii?Q?Pr0M628PaFOWmnoqgaml9bcoeHezDD7/f8BJOmcON52jA2vxVGeZ+353DMRn?=
 =?us-ascii?Q?BREqaUlL5c1lWpbzTlF4jZHIS4tGe/rmz2juZ6y1f/nxYCmLclIZp6IxLgR6?=
 =?us-ascii?Q?AB9r7H7pIuNHQJ0PzB2uAc1l+pLOdmiqtnEO16v63bWMfoBYlEUx8FEmOcdz?=
 =?us-ascii?Q?xMrHSBtl4bhFl2dULA72vNNnoH/+vndjmPXrxaTpmwVs0dZsER1vyeaC3zGa?=
 =?us-ascii?Q?UZKxDaMFRvEKgLUnEKQeHBGuv27BzJKEGidwal6m8jTfuI7GKMJsmwVm4mgC?=
 =?us-ascii?Q?7n0d/KA8ipCJK/Jnq3UUI/SCoT9ms3elytnd/gi28/Yv/+X5UA1HK56TI76G?=
 =?us-ascii?Q?D58hInARQtAjkfnyYoj7FC/IBDWZpqBDssXOmruvEEYHVup8EUE/mmG4cTo6?=
 =?us-ascii?Q?icbnJQg8HPJt13AmB68JBE+Mt3BezuvgjCcyoQNz6uWgLz3TPvYgWoEK7Qux?=
 =?us-ascii?Q?TfSXv36N5lImxRwfQwxF+TFqNEHDucxYRM5GCdXcVIof8BSIVbRnQOvT6AqE?=
 =?us-ascii?Q?k6kuMc6Uw9Zp8VQrEpIpAKGo/+NDQpHajxdNYyHU819vh/HohnpvNbhMSVI8?=
 =?us-ascii?Q?EepBAJjRRp+vsy0qHrNkBN0uk4hOWY9eec6lw81XjRid4NiVrBRkmyJvkyDo?=
 =?us-ascii?Q?tTBP6+FZ0wl3H2CMu02XNfR2I7Q093CLW3fN4H1AJHojVsk4S61chu+MPyE9?=
 =?us-ascii?Q?EGXbTC0iXq1X7mnsEbS62FjWKMtZ+sjIFM0z02Bz8ChQhSoSgK/RdXil/l6p?=
 =?us-ascii?Q?pC8/0aTYMU8zhEFr8LHoTlm1Jx10uKa6pECxUU41aAf7ohEwpY1+lBBYaGou?=
 =?us-ascii?Q?jMiYna6aay4bpub/QwhN1uUbD17O3z0qwpFmePURn8PivDp8C9mvDt4Yj0vc?=
 =?us-ascii?Q?uCfSjRZIIB1CHJjt/tDyGsyHC4QskzoOyThQ3ce3z+svI87U0/FGvEXmNUa+?=
 =?us-ascii?Q?gdG8+uiMmvmAhM0lldSJynYJeFScxhMUDSMLClkwZlpWffKfWDNxwF6fH9iY?=
 =?us-ascii?Q?UM2F7uy/D8Sr9JAVp0rQiLf1TWOlaIbBlU4tmOhO0xyceW4f7jywHFvIiI9x?=
 =?us-ascii?Q?XgJRYsNa6UwGZbp2TirIz7hTVygv3ngCTdF1sJezgwAHhUDwidlwKA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 13:05:16.3507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8588e457-f0aa-4863-efc4-08dd8bd57aff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
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

Reading back the remapped HDP flush register seems to cause
problems on some platforms. All we need is a read, so read back
the memcfg register.

Fixes: cf424020e040 ("drm/amdgpu/hdp5.0: do a posting read when flushing HDP")
Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
Link: https://lists.freedesktop.org/archives/amd-gfx/2025-April/123150.html
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4119
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3908
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
index 43195c0797480..086a647308df0 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
@@ -32,7 +32,12 @@ static void hdp_v5_0_flush_hdp(struct amdgpu_device *adev,
 {
 	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+		/* We just need to read back a register to post the write.
+		 * Reading back the remapped register causes problems on
+		 * some platforms so just read back the memory size register.
+		 */
+		if (adev->nbio.funcs->get_memsize)
+			adev->nbio.funcs->get_memsize(adev);
 	} else {
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 	}
-- 
2.49.0

