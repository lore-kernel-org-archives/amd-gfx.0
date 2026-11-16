Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18981606A883
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=c9e/WlMc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8DF610EA9D;
	Mon, 16 Nov 2026 16:57:44 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F3F210EA9D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 16:57:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5yWOKkJswqA6z3oGTZN6BoabqNSphTGyX/bTKW6WQg1lyJGlP4LqaEJaFG+LPw11RZ7dYvCg9hm7snLcussnOAtiIy8kYz5I7RuO2LbP6QfD78DzTIyDnwcG01m6NBJD7CfFjhzL6OvkoNsxYzikVTDVedbiC2k5k9kEe+aPV1q91wzNVEEG8vDRnTe1dtYiqcyl1/G+pku6SQVj2/wMylHjQDE+hI9QBoNoPxXEfCnfOBFGyuX3d54TWaZfFeslaFRDVYfMh+mNQjMBVqqq9g6n9iB26Nx53JBI9f+XoXaGbaCBa64Iz0R/YGE87HyRcbUT94JjFEpIiROthK+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bj51Ykdwn8MBMhhkqHHJuz74quc5eU4G093rf7BCmUw=;
 b=xs2qfp/VOLdverwaRv1VZFTvqOm5A4vBJtAqaQV5af6qS7cACd8lgJ4G3Ge5XQFDqmVeKZn/rl+mPAxZO/FBXAE8J9KcfQD4QORxEUCA6F+zOOShYpeSYLhBJthOKPEmjvs+prv/0aV6Pr/uIvpc0v0/rvw7F5Ten0hbTXtiwLHEKycLtp4ZZvFJ6q3O8vMYVrXzwGdVGUNOsSY/3/ME9D2Z3nAsoXOFoExhn9A96hLK8q726RvEbravTpNc7Sy+MTa7Cqu6PLXiTwU2F+XdoIqzzOO7c2JNVov3F7Rs4pemD00/4jdYViP+u4BgKbNiz+Kjc4mmssKe0PZKy+0CNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bj51Ykdwn8MBMhhkqHHJuz74quc5eU4G093rf7BCmUw=;
 b=c9e/WlMcPpZ2hRKCdEEFVTISpD6EiGX8EuOiZWiZpQJ87Wa1BnvFIEMe2rGy/IfVlxPU/fY01c+ZZj8mUd8l+lefV7pNzyzYiA1Zgn3N3MeOvlfXVKlSVSBK0mNc0mRNy3f9QSiLLKsyBEGft/R6/cJ1Op9228vlTn6E7eufJ1I=
Received: from PH7P220CA0149.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::19)
 by DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 16:57:31 +0000
Received: from PH3PEPF00059619.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::1b) by PH7P220CA0149.outlook.office365.com
 (2603:10b6:510:327::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Mon, 16
 Nov 2026 16:57:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF00059619.mail.protection.outlook.com (10.167.243.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 16:57:31 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 10:57:28 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 16 Nov 2026 10:57:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/5] drm/amdgpu/gfx7,8: program the RLC SPM in RLC resume
Date: Mon, 16 Nov 2026 11:57:11 -0500
Message-ID: <20261116165713.1945549-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116165713.1945549-1-alexander.deucher@amd.com>
References: <20261116165713.1945549-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059619:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: cef915e5-e38e-4fb8-1ea0-08df4402b422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|18002099003|22082099003|261009223027099003|11063799006|56012099006|261102123227099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 05sm9kGrio6OynXdyyjktPgobT4hEVW34sl8D0Vxnc3JtaroS/InYIG161v7NlTMr7K0x8My+lAqBUfUPneSw+nTkStHFRenwKViejjVFCieI3Ikk/ZL4yqjuOKbrRcQna0Qi6WV9XeuO2scjDzOpAwXMjA80oo5PeMECZM/xLbiI9FlzraAGf1wjb1rKm5IAyYi6bnAoWENdpeoEABVwW7HBfsms4spz5YmHbZuDRmVkQoMwvMQFkxTWHgfCObhxzeyEJihq/P3D31VslLt5GsTW6hAnk480IhNJ7vhHNKy7DMTayuCNDEGCcgTuCTkWdAzVPWeDOlyzqLmbI2++x6LlmkuvDChLooKf0wRz0YA/Wtho17J1d5HYG+w+0cK5bihKQopqBsy5CjFEIYGwP7ELuaRgtNMWC5xHsW+h8/WeR/dky9TFPTVj5SBDVJWmlVJ0g/Fk6IqaOZAB3nZPcWWM+6p7Wu1o/rdRw3rw83h2qSFopCzDaY07bP+CIksMvx8+s5LWOiHEoxVZz45EULKlmrC75xkqWvFPH5Xc2NTsCLZU0ZE3C6HCu9YB5v9U3HXnGNghGS6Iehj9EaghGWgHvVSl462asK8pkffjb7b1/6xKZ1bBghzsrz1auVgfPAnm86ekP6PQtVE0UHc4m+nNsiclGwLo9UWBMxDNA1/xUZhjMc6UN3MR8b7t9By9I/TO5b1Mr/AsJ9oUAvh3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261021121427099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +ndyDNumBzQfZ6lmcm5whyx7J76m0Ku4ix3r8G2cMjV32CtuZUHBuBII6et1cUJi6JNsSXvQ5gcLgn7i+MB/XENDetg3K1GLKozECdu8W5kHqSlG60k6z+WfaKOC09rJK4atxs2pusQy1WyqBy2yt+VXzTgE+3nuw5LGI6e1DOt1tOqQNTkDc6FtbzsqXVqPU5OsSyJo3C4PXjVxnkvbVEH8VbXgw1bvHfzrWaTmhX+SHZoUlWZVvw4uq9LvVaKqeOb+gSIJ8RIvEwuEQJDu6W/kW6VYY8r+1dPHH5DbVwLeVJ47C5YcUGdtUe/FcSFLicbFDpKE8UlR+462VIoLCDL5ANejgJPCDeoWvJDfLH2aYf10/E6anGstU+EZJP0EBfMV8PuELyskp4hXVikEHJYZZvvEnfcTiLn7uNO0w6PL4wuPf/OLWwJrIv5GRskW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 16:57:31.1499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cef915e5-e38e-4fb8-1ea0-08df4402b422
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059619.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The register needs to be reprogrammed after a suspend and resume
or a GPU reset so program it in rlc_resume rather than rlc_init.

Fixes: 460c484f2411 ("drm/amdgpu: Initialize SPM_VMID with 0xf (v2)")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 7 +++----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 72c84b61fda16..58135757190c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3254,10 +3254,6 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	/* init spm vmid with 0xf */
-	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
-
 	return 0;
 }
 
@@ -3479,6 +3475,10 @@ static int gfx_v7_0_rlc_resume(struct amdgpu_device *adev)
 
 	adev->gfx.rlc.funcs->start(adev);
 
+	/* init spm vmid with 0xf */
+	if (adev->gfx.rlc.funcs->update_spm_vmid)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 4666aa5b38c75..df935827b002a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1274,10 +1274,6 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	/* init spm vmid with 0xf */
-	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
-
 	return 0;
 }
 
@@ -4086,6 +4082,9 @@ static int gfx_v8_0_rlc_resume(struct amdgpu_device *adev)
 	gfx_v8_0_init_pg(adev);
 	adev->gfx.rlc.funcs->start(adev);
 
+	/* init spm vmid with 0xf */
+	if (adev->gfx.rlc.funcs->update_spm_vmid)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
 	return 0;
 }
 
-- 
2.56.1

