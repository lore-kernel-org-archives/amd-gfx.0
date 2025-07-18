Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C029C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 04:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 204AB10E86B;
	Fri, 18 Jul 2025 04:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jcs7I6Jp";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E53910E86B
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 04:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQ5V+P3HlwzLg2Xk+MjKs+oyDmyPxmQaWfwFR1+Wvye9BM933ro/Qx4V444ZaNC7lFaX9kGe3msGZuX403OL5didzdIyN9K2bszQcc9V1bCbv+15kM1u7Ba89GCE0Jmp8fBdf8NT4kMwhW8G7Vv/FZECrVpRkcWt9eBdVnkuWpXynJBWe/JyyMerwebwcJPmbKnH0WlLBOf4EDkETpdbwa2AGKRPEgxze2eTmYety8bH+LCnMKtdCjeE3hf0tnlLsBz7o9Csdcx47BC0Ozl4MHHwqZbDt5hK0FVF7vOQET781TH2M/IIGwieWpF7zkiuoNTMm6RPRPznTPW5zHcFCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/ov4KFmzD8Qc0d14SIQIVMoaTGMql5sxw02qx3rtgo=;
 b=LQ8l4oqVhXrKxSTzeF/Pixrojn313kTbcYzKAC578j9yWlltZm9NdZzoB1IAtayJmvE/q8Mz9Q/h4NUSToHz2bFsy2dzEQKKEogWIcWc2u9CbKzwuXQrfnmVDEf5pws2GWTXN1LejQoc3AZD4N58KkvgH1H9znwbYAObWAEM7quZ7CYlgPLGnPkOtDiUBmPfic0M6bqW6ZunI+SKRuwnb7vhTtaZh1UlQZK73qeYYJ9fof/ogy+r7bNB92rKXJMSLzbE+gFH0EHiOWpG+/O3Vn0JaTL0iZ259pzEejUI0/qYd9loyhWUIjQuFAvTotyn6bbiQpLzwL5i6vsEVI/HCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/ov4KFmzD8Qc0d14SIQIVMoaTGMql5sxw02qx3rtgo=;
 b=Jcs7I6JpYwDK839tOaBfKNe9eiDF6+kdCfXl44uRPLO4oyLnuPVLlr9eKsKgiuXWbezsEu1FnA7DTvPM1J6UNZ1pgJTU/VMJaHouAGL/8g26zIJP7jkGkOwWvj0vXIA88IZyqBrZZ30RxfoKLs5Dx121Fa2zE9NGl1nO0GaLd4o=
Received: from CH0PR03CA0282.namprd03.prod.outlook.com (2603:10b6:610:e6::17)
 by PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.37; Fri, 18 Jul
 2025 04:00:13 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::f0) by CH0PR03CA0282.outlook.office365.com
 (2603:10b6:610:e6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Fri,
 18 Jul 2025 04:00:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 04:00:11 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Jul
 2025 23:00:01 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add NULL check for asic_funcs
Date: Fri, 18 Jul 2025 09:29:44 +0530
Message-ID: <20250718035945.1560178-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|PH7PR12MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: b2969fd3-d62b-4c1f-860b-08ddc5af9814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wrt5mAMtugFkyePgww+2C94nV9XwJM0gZiYiuxc0RtlCYzOl79DL3GUcMiSS?=
 =?us-ascii?Q?TnMZlvtLilY0jTdLl22DWO1Esp4GMNsNtgGx5wKl0QDnEPKLOJCxp8yuCO9V?=
 =?us-ascii?Q?CgW97CLvvxLgMzTRp2L5pcf5DNk/mum0PSKC++nIFcrEDjoI2cushdFIfLts?=
 =?us-ascii?Q?Ncl7PCD270bN4ke9j66XpcYXAUCtNDuLEWVV+Ru/ZM+XifUDAZWUiNnzSZbK?=
 =?us-ascii?Q?bl1se2WhXxQjVL5MwV771U1BP/WaWV4PY5cYvltTUSgQRDUCim0DTmm7Cj+F?=
 =?us-ascii?Q?2ZfRHqmoJ0Pea0nYlAM0UZa1gYA+XnA55ovQlYG+K9druckYo/sNEyFXw2jR?=
 =?us-ascii?Q?aLR10d+QynjN+pCzF7bFidxP3hk8N/HsgZHyqfSUq3STcAKGdnGWQdFTBVDT?=
 =?us-ascii?Q?q8Lp1lu8pH0xPV9nkOYLDRSQPeVHSqNsmkbSD9se90baMKwPMBiS+L/Yb8pV?=
 =?us-ascii?Q?1M4nUJXjfFsUnzjfMleiqWi+HiJO0I+SywmXrxFmbgRO9mevX7Pn2IcsIZaF?=
 =?us-ascii?Q?gS/Ck2Z3kCB/ctzAkKwzkUFsTtJueIPJzNicUddBOO4gh5tfQTaFnWXcFkD3?=
 =?us-ascii?Q?GtERQfSvjb3EwXQrgp76ZCURmp4U3aBeLTtjgHKtAVR7OnmyBJhV3hdVPKkR?=
 =?us-ascii?Q?TOEwN4QxB5Cn7Tnxz8a+/ydkWgSyFkPPLy+iPzSHUtmkJXeNSpMDOQ4h/hnN?=
 =?us-ascii?Q?j+z//9/AjtUO8sf26tkuBTKnA80vpWP7qRhH/fYopDI20qt4cBV5HR4xb6ug?=
 =?us-ascii?Q?YMhgTgtLxqvFNNX66elgb9qlJRUUQNbCK6L3hx9CpPgKIWhbzA171p/pNFLo?=
 =?us-ascii?Q?CdV2YzwknQrihvozrWaHJo1kb6lrRFXbodHvIbKZ971xz7nGbEF161zNh4Uu?=
 =?us-ascii?Q?5i4xoQI3Gr+ZWBCSJaY/zMscNGkPKes/7g3pwX6Cj8qC81bx0jFwFTCh+MSe?=
 =?us-ascii?Q?gMsb6SR3qB3qvOYL2+LNJrpcvNUEtqQLHN0arBm7LhDxxruPgeemWqWypNN6?=
 =?us-ascii?Q?f50c219lyBlTKBWRyUG14i/7/2qJ/B84MFlNNJ9OrDl8UWQ11CgNELAOqktb?=
 =?us-ascii?Q?PvQVWcau49wstVtBcg0cHKjTISzeDbUSGS8tCTB8siyzRfUrGuLqctpzYiPu?=
 =?us-ascii?Q?b4sIG/hKLS+LKKTa+NUnX8V5xPq3ycD4Wguac/y6YHflWcXdK3eqQvwuDF2H?=
 =?us-ascii?Q?FU+clpicbKbbLG8M0p9EyDs6lPgjlCrU2thescfg8qtn3OEw3/t/qOVL9fUr?=
 =?us-ascii?Q?OqasTxIrAdjeLsLxYbjcuAAMJBvA85KmuvAFlE3GL5kVZsAa+cvlhbLZ6qEp?=
 =?us-ascii?Q?Z5VQPWWmV9pG1wQCIPUzFy6D9+oV54z2//s6x1q0rEWk5v5p0pklbzi7WOnC?=
 =?us-ascii?Q?hUeq/kHtHIB7CbydzGbgCp+m8o5s+IG3fvhqPYFF3ZUecQ7GccV7l7vJhqVf?=
 =?us-ascii?Q?Ba31EzwZqoDHl5jYIRE+HqCtkURoB1pyOGvjP8yx1zzgU1VgytZ7Xbw43aj/?=
 =?us-ascii?Q?wkjTJt7X3nm1nhY9paYKj2nHlqk8UEE9M8Qm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 04:00:11.7111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2969fd3-d62b-4c1f-860b-08ddc5af9814
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903
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

If driver load fails too early, asic_funcs pointer remains unassigned.
Add NULL check to sanitize unwind path.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index e56ba93a8df6..a974265837f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -55,7 +55,8 @@ u64 amdgpu_nbio_get_pcie_replay_count(struct amdgpu_device *adev)
 
 bool amdgpu_nbio_is_replay_cnt_supported(struct amdgpu_device *adev)
 {
-	if (amdgpu_sriov_vf(adev) || !adev->asic_funcs->get_pcie_replay_count ||
+	if (amdgpu_sriov_vf(adev) || !adev->asic_funcs ||
+	    !adev->asic_funcs->get_pcie_replay_count ||
 	    (!adev->nbio.funcs || !adev->nbio.funcs->get_pcie_replay_count))
 		return false;
 
-- 
2.49.0

