Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB20CE77182
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 21:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D36C10E0C4;
	Tue, 10 Dec 2024 21:47:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ObEWwQtC";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2C8710E0C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 21:47:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ub/lP8tUGG7yWf4Db0+En6KKz+nZDfLTSy0879dvj7/583Isf8mc1M5sZXIliXUN3NHUn1l2ydODWFFf8cHLrTjw82O11QbnZ8ibRIvAIhxoAf9/HR384t6fjq0qQHpvUeiSCfaB2ZXgV4VE8/6Sw4p/zA5Urf2i02hfMrU7aZx0mKpIBLZWon/JI/cnHRhVgnM0N3ng2U29Ab00iRQRJCkprio5QWQF+76NxEgXFRQvrmg/bXSscfZMyIwKQ6GOIObjOPeIJmXtQaV2sseiLvPRyWRGoTj8Kug7/H2A41dDEN5FxbKbsh5s+PT47QCpQKvDSWtIS6ccaYsrQHCSOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfIiOLKtoX3iIDTVDfRMZKXvSL6XweiKv3F1A1D18II=;
 b=A6xILZW7KCBuqpPzoQT8RpEC6lLJUmUUnTdW6JEMYbG9yHMZO41pV3qp+ps5anafZoxud/+HFqGoVHWVZ0fa+YiOWDWlnvF5eriafbDyP+2n549ISopLIjQpoC6C2VhfbjJPg7aVyHYKZGuk8ABXdMdc5GpjQgr3nysNc4aP9rK3Jqzdean1vRZ9GntN/PRpaq4/lRa3E3g5Q1QNLyMxFqUYxt140qT3Gdp/oIQOUOEZ5MSsCRnlDVMBkBdTIF8X6pjkDuO+arfieaWozuBDuxuoON1K9NHdxj9IpRpFwMaQENqHKKouKp4Qg82mWEzzBHw6XctD6boGo462FFTtog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfIiOLKtoX3iIDTVDfRMZKXvSL6XweiKv3F1A1D18II=;
 b=ObEWwQtC+7jlzQmnPnZ6Olf5AA4qKiU8bk4jxoOJc/7yxzhJLFQ8EcIKARijp0B1nCNYGIBoJgE7+QoMbF2p1Sdtp+qZJbYOSZk9Sp+jipCjJdIyY12vUqkBapqYDMUchr4XSmOZnUco/4yhFItndltaf+SiT4OzcpxLCqeFHH0=
Received: from CH2PR07CA0013.namprd07.prod.outlook.com (2603:10b6:610:20::26)
 by CY5PR12MB6646.namprd12.prod.outlook.com (2603:10b6:930:41::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Tue, 10 Dec
 2024 21:47:18 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::49) by CH2PR07CA0013.outlook.office365.com
 (2603:10b6:610:20::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Tue,
 10 Dec 2024 21:47:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Tue, 10 Dec 2024 21:47:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 15:47:17 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/jpeg5.0.1: use num_jpeg_inst for SR-IOV
Date: Tue, 10 Dec 2024 16:47:03 -0500
Message-ID: <20241210214703.34668-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210214703.34668-1-alexander.deucher@amd.com>
References: <20241210214703.34668-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|CY5PR12MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: dd8a8e94-2856-4b4c-26ac-08dd196437eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PhFKUJyiTnp2waY2+lj6rVZTTvvNuTr+a3iVSQxUGkAeTz4n/Ymd+G+eVgGu?=
 =?us-ascii?Q?J977tfj77OZN8Geb+Nx2+1anZAmw7OV50/xuUd9hsEOkDrCVQFH6RFZo3z7q?=
 =?us-ascii?Q?wyAi0SgGsceiA8SgXcJsUyDbewMkcohI+RpZ/7SGsklbtqS82FtD5r3dma79?=
 =?us-ascii?Q?I+qoEbVGltkam2A/R3uOkysjW7VWiKfUdAHQwNUSW/E6j5vauE//aVEDWivI?=
 =?us-ascii?Q?NO9DQNDNmZDSg55oMxWYH0hz6RD+U8LW/XVuGu2Xtqxoc5kikAM1ptJDOxYg?=
 =?us-ascii?Q?f7tOIcrG9GkCy/rwvPrHmusx+ld53KXBr5K5ozPhsRbTz+OOwtdnX/PDaz+X?=
 =?us-ascii?Q?W4j1jh2aecx5QGsB/zuashg3fHcxAGEtlTjBkqTHD7OtZaP0hobkQkxz/ssJ?=
 =?us-ascii?Q?P3uQnxEHh/ixroOs2TzBhWn/NK+I6YpNuOg0ymcbKTFdDKd5ttVHe5NbYqoN?=
 =?us-ascii?Q?CntTpkRPwQ2IZRAAc4VWhN8OgpOXKS71u3WbMCmF9dDLyR7fW2SQEp6EFAhi?=
 =?us-ascii?Q?a6kg7Ee6SOwizmD1wDD0tRtwmMnnL1LRgJLmdishrZ969xKv6gZjTL5ReRWT?=
 =?us-ascii?Q?xYZWJ5nK7Jcqh6X/PTjoHZx+Nn37pZBvBjwOBNvnHO9dyXdjKmpaNWf2Mhwc?=
 =?us-ascii?Q?0YXBGM1j1rMWS8PkfSMYk7BLMFMCuJrFrPBOdgKLBPTyBHsYHdLbIbk0d1Sj?=
 =?us-ascii?Q?HefU/qN6Eor4YXzSwJnwU3yvXRdg/NZdoD8QhUQyBRQqN6/rutZ/vmOZQIIG?=
 =?us-ascii?Q?uA9sqNDYxfPS5pyrhFheH8hn72KJy1fvhE5biEyh+AZdxB0x6MK9S+PHF5ca?=
 =?us-ascii?Q?uMBsGGkVopUdXM2Kr2g/lk5cYQcthYnKPa/4PKGm1wXHI9e11u6RqDj7rP9T?=
 =?us-ascii?Q?VtwLg0pVh64oLaoEGpnM2Ylqr9Fcq4PBDnLU/CVfWltZuMXZ7Y5j4YLfteN7?=
 =?us-ascii?Q?xx6q56M9BDX8FLMiKiIFdPhxo5sAsXN+DdQcfFJ8SB6MonwOJe8YjJSoeZL5?=
 =?us-ascii?Q?H/tIxIe21i/bSbB4jL9202dbZ5CkOL81uDIwWV5Hfnuq/BEbgtY0MlaMlUb5?=
 =?us-ascii?Q?V5ThAtZ7BTL1dxU4f1D3FVt24/s2Z6y6ffXWMnMbeQkhBInM93goXQl2llgz?=
 =?us-ascii?Q?LHViPYxoVTJ7c8sWjETqg2hAU9aTeE69mvEbTxvU5+DCv7u4VC6LfbR6r6NB?=
 =?us-ascii?Q?HStn5llw4WUU4Bb+x5xMeW755a7g+a+QuDPZ++xL91CH9I47t3xscvpHejpW?=
 =?us-ascii?Q?9sKECUaKS8ojpXWw1qm3gkjuwzyhTEaMT4SlKLTpOFw8efXJnsaVTf3CkNVl?=
 =?us-ascii?Q?y6XeWMb5SWV5dS7FzYNgmDwbHg3q3AXRzBguSIVtgUG9KPd7v8t7OsHpA4Rq?=
 =?us-ascii?Q?892ut+jKPtFUB9CYD7IY30/wXqugFMz9SY8gU3KXXLzVGWeGP2d5lGSkvKty?=
 =?us-ascii?Q?35rG64NDzi5+6NwBhTubPc2nbm+eZTj1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 21:47:18.1278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8a8e94-2856-4b4c-26ac-08dd196437eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6646
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

They should be the same, but use the proper variable.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 8bfa400e7a874..40d4c32a8c2a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -183,7 +183,7 @@ static int jpeg_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 
 	if (amdgpu_sriov_vf(adev)) {
 		/* jpeg_v5_0_1_start_sriov(adev); */
-		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 			for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
 				ring = &adev->jpeg.inst[i].ring_dec[j];
 				ring->wptr = 0;
-- 
2.47.1

