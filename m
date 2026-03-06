Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E83EFCB61A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 15:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C862F10ED5F;
	Fri,  6 Mar 2026 15:40:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mArS3uR6";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012022.outbound.protection.outlook.com
 [40.107.200.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A0C810ED60
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 15:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytAZYd5YYMvHw8TnItbgI+z/fP/iHzE98S8z89VU9/9vzb0nXpjNrFPJb9k5mBbpmQbyTxGFDAQ8Ix57U7VqPMnJZptDb+pOTloYgwXZExLEPdtsnGgvX9RDt22/5lHTqn7MS/UXwR95x4QDM4rPE/+y3FIcXPaW9k6lYI3PNlO8TLJJo422NrCCDXUweXqjiGt2YXMhCCP0OAGOxvMFawtbb6lWSxCwFgvoUo7m8NTaIFkDJBPJ6qaVR/zW/Xq1y7Vgjp/FsWAKGkgBTh1S09kfVuPYIjKQiPhBTmtYdihfbvVlqbtW8n+sd5HqIwQIVjY55V73MRHJugS0YS0Nzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0b1iQ4ghHikAosVtEtaTVI9bvMhP73dIoa0LT1R+3fo=;
 b=H+JTE2U0WF6nRaYvi5JYNN57+zHvBpVLhD1u/EF0zqxVbVnz6/Jo9AaVQbIytHSbq/VUOl9vRpbkUNz2hczCcREelr8iqV46dRIO+IShaanFU8/T6ddWb3J4AyJjaPFc3fV1MHhcFczaB/MTZywJZ2MZrI+3F+vll86EcUfomNqCtoBeXV/YpXu2e/GWFLjEGBi9Tuz/jRVfPLvTv7xtENa48PEglEIAABAewbv/Y7+ktFD5aW72JbPu86ejWRXWjJjY/LytXJr3H8OgSjTfywLKRQro1OhOz/p/6e1XsCNarGgAUU8yz50Qpk0p3R1LBSbbBACONpob4LaPcHoMyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0b1iQ4ghHikAosVtEtaTVI9bvMhP73dIoa0LT1R+3fo=;
 b=mArS3uR6zXzlFCpSi2xA/T9MwgIzsvZ3ZjZaNVIR+0MaTYV2ldGQx1Kbn6ER+q/GTii2NpYh7yxTiVqXCb2HUoAS4gvE8VskR9uAJsWlH5wJ2hDKXvjy7Xz/Wg1YtVXEmuj3D61rzfX9Mzh6LXCrcMyxv5M0qVHjLOyuIJ7bL0k=
Received: from MN0P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::32)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 15:40:23 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::c3) by MN0P221CA0020.outlook.office365.com
 (2603:10b6:208:52a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 15:40:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:40:23 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 09:40:22 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 09:40:22 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: bypass IMU ucode loading for MP0 15.0.8
Date: Fri, 6 Mar 2026 10:40:06 -0500
Message-ID: <20260306154012.22525-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306154012.22525-1-alexander.deucher@amd.com>
References: <20260306154012.22525-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e9190a-e5ed-459a-41dd-08de7b96ae3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016; 
X-Microsoft-Antispam-Message-Info: 8+eOhkJQd8Vj6DrTh67A/bdhEWyyR8DyTFwv7Qh8AEZRTCnjT9bVMl86gxAzEjKxfrA657xk0pixjvWL7BkJsvaqJgDrAkSa8Qx145jmQhuTccIarPWFclJHNcUraFhtYlHACh6dJ0MNsxC1Tzt1jmi/l9doMN1g+wAvwTixPbFx5YnXCur4zZydNeofW0mZBnLt6wRIrp/lM1PLnC/LxU2tsQAn6lHnVgKIsx5Hdtd41NvNlP686B6cLvpVqY2qf+N70jmC9BMOJPXhLIhteLfNeXr5ljbCNqm150Jg1r9SmodFoabe5f7aRfOlO3eh5eiqsxp+mMx+/uIjQ79vL/qTMzax1uwof9K9QTXWEUEHRYaQCfmZRRvTy6rcuGGJ/Sjofjmwj+1nv3zr+wubQVxDNjrSa/1WdbGyHd2CsA0Hv/4ECX4A1d7yIpQB+GeN5APfs6yprJrrm1y+nFyzIuuGKk1co+Mrn4C3Fm96tZ4R2zosW57FXkvVO5ZXlCo9aKLRhuU6EG1975ZOXgqOUPE6ySnmFOXh3MSFNGSZa8yVVyjNlMtOSpQvzNIltS20ERpwWKhWb3RZWLZfxmvDj0tYSTJduouyQYhggmXHqSxWugwfYR7fpIpjJ36LA5kHbSJpOp/Rl4Ye66EsoEenEsppF5nowzCEF+X6PrWlbyLK3RNr1m00k5gTVrSQMZqncqKfMDyMmcK4AhebdUsTe7oh990HFcLc2lc91A3w52Q6VufDBojPVR5Rx8ByqN8/Q39a/rOygytP9RueEJeBoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 33vozPOiGRb6jAStr9RdXCmTTdSVApFr8yIpw9Jj0dk+gpnQFl9n/rVZe7liTtT2b2zNSLq/zRGB/goRk9hImQOmcMHoD5qLHLv7uyUltaOdDmWlmHkWtlcNRafFimjw8fCnPT9aziJsGIfAwiUEMrtRBvMkDwEbAvSOpgBz1SBOaLb+jrqOJKV/gzmY++ngIhz2Eh6xjQ3t5ruwXu9lBPZ8DEUyBp03HWYSlicVQNUMOGgzlIKv0DGPHMJpRLaAryB9mWdnq+ekkttCgodSopXAQYdIeJ9owy0WhauJffY3iepVsn0Uhatn7RyyNFo3lFoNIteysInDrWMxzCFRVNTbKexELVmggtPdNroNtI3sOp9bW4PDrVzVx31k9DOyBh2c6LjNcfegRxOaylltjZiqdbRYAz3cAM1nvTrSCJqswNXadmAFRZl+NdYQT16N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:40:23.1114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e9190a-e5ed-459a-41dd-08de7b96ae3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385
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

From: Le Ma <le.ma@amd.com>

For MP0 15.0.8, IMU ucode is part of IFWI and ASP would load it by default.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a7c7b378c696c..0b35180ace355 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3096,6 +3096,13 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
 			 */
 			continue;
 
+		/* IMU ucode is part of IFWI and MP0 15.0.8 would load it */
+		if (amdgpu_ip_version(adev, MP0_HWIP, 0) ==
+		    IP_VERSION(15, 0, 8) &&
+		    (ucode->ucode_id == AMDGPU_UCODE_ID_IMU_I ||
+		    ucode->ucode_id == AMDGPU_UCODE_ID_IMU_D))
+			continue;
+
 		psp_print_fw_hdr(psp, ucode);
 
 		ret = psp_execute_ip_fw_load(psp, ucode);
-- 
2.53.0

