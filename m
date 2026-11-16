Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC260606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VVPGouWj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EDDE10EA95;
	Mon, 16 Nov 2026 16:57:42 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECC1210EA95
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 16:57:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGzrB7TLJMd83QYaPY9WxF4YMvJDmxXBIv2ELYDXi3r/d0CMssmWcJ8pT+181pi/1OGE+yUxCaE5WvC/7bTo0HDQ16sGcmCip6NgwxgXQDNjXsMnVQTkWJvPABjLn5oty5lOf2u7c3/JV/tVN+/Je08KY0QuW0J+uUEebcNYZIZ1TKY+XNbdcDOX9H9wACqTp1sjJJmh/teOkHrSs6R9XRc1pPDfjrV6Psl9ZDrg1IEMFEjJa21YrD1uH/KWtsje2WXgE36jbwxBtvJIKfL9n60zE6E0EVcALtv1afb8jhjM2ORwFw7zTCKl6KccS1WGaa0wZjwa7NKOauau05DA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCodllbUKvxJBYi5oyEdgDoKuR8VLuT2yUTrq6Xuloo=;
 b=BDCEo6EDoM6eB/CqXS2CSqWtoK9kNjQYo8TWCxzhGPZ9JVfWSZ3R8wOf9S+CgZiJnwi6m7ppadjLSwnL4ef6p8Fhhd/CfpUIPyGEABEthDsVnR0zG+pEX1FJJT25Gqts2HafIOEH1/gJngqKhGq7CihJnF7ImP7MAwiu/8e1r7xLFftuBy2kHiOBCVsvsR/JAoTs77dT7c+H3hmHv9pmvXNHV1vuEpVHGi5Jaf3szU+p+4G8gAlcykupR6TxIwtoKA1dxCUQ/VBwGdwaTV29Y43d1iZIa5SC33VqWai2dBvs35jbjYll2eaSXv7jV2LZzAQSG9rWqbEq784JGkFYJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCodllbUKvxJBYi5oyEdgDoKuR8VLuT2yUTrq6Xuloo=;
 b=VVPGouWj0Rr29NPHXsTjllYAxmX2qh7WI9185NghyG9iiZ/h7I1dwdPc2HvDf6rBA+Jf3y5o6I7DUOEHSZ1x+cFMwhVx2aCeY7+cjfrgzVdTqXxZcvJovaV9SCEeloQJGiAPbu0ZEkjLht1bKcI7lTbbSnIH29dDpqqikN5jtLY=
Received: from PH7P220CA0145.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::9)
 by FT1PR12MB155092.namprd12.prod.outlook.com (2603:10b6:170:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 16:57:32 +0000
Received: from PH3PEPF00059619.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::31) by PH7P220CA0145.outlook.office365.com
 (2603:10b6:510:327::9) with Microsoft SMTP Server (version=TLS1_3,
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
 Transport; Mon, 16 Nov 2026 10:57:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu/gfx9.4.3: program the RLC SPM in RLC resume
Date: Mon, 16 Nov 2026 11:57:12 -0500
Message-ID: <20261116165713.1945549-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116165713.1945549-1-alexander.deucher@amd.com>
References: <20261116165713.1945549-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059619:EE_|FT1PR12MB155092:EE_
X-MS-Office365-Filtering-Correlation-Id: 12da1e00-dcca-494c-f438-08df4402b485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|22082099003|18002099003|261009223027099003|11063799006|56012099006|261102123227099003|261021123027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: nLUz5dPilraNLwnXbRl+CEGhad1fHpE0yUXAiTc0rTNc8knzyVQjOOVvWzkML1rrvKbIU8BM+hb2txv/QDdy3MuhGXwV9kGa3yXFaDXMwErq1QvzR4OejlmbkObCIuWJSSEhQWyUaHwNWuzRaW14hI+1QZexJczwzUFxpghNBFKUMqgTiBgaI1VHhCCIKrimhCIqBN8UjPOepPUSCd15B1MqMwBrMBlghJ5GkhYYiVwRdq5aC21yrjzMom/jrBjstzAORXC35ncHtVOJXE2YXfeMM2Xp3Nxk5q5iU3uxfZMmtS7EEijEAmNoVH2n7AURraEidsyVC5TCTZdk7sMl6s2J0epWUUiXFsgx8lu/mz/T8MDa6beZKWvcLre2sIdhxdLnazeQ4AQ+SDjbD2QfB8brhIrysxdYnrGtruqnHWWW8h0ErHZPkL31UUcxUl3t6nIqJvR+JqZT2j5/er5JVxmAvh0qmh80UPId1BTjvo2ywaP5wlLMcBVok104lS06zD9hdym9LE2lkjLtZw3H+5vXM9uld89gF6LI0NvOUC+RxIVAYJu2srvbaz2MmhSNgYfYG+P8TcP2UMf3r5lrbW3lgH/R4NPkhP19Oyze5pnsyFAqJDHdORNjhYWjnA8oLcgHKvOgiTTJDr9SDwpU2M73lz0aRIBRtR9fo6H+Ze6CEtevP/wTrW7Lhu1UsQmpiCMSZJPaXw90YTdZAnz+Pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261021123027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7gHrjANgUr7rB3YI7ZzmCuat8/j9Z9y5TJq3PK7lH6g++FYs8RWkJG2A7jxqoaj6qF73nryC9aodvHwTSy0Gq3J2x1eYJjn6W3tRMpbQiV6W9gqAWAMM6Lp1czZMkVvO4p08uw4FgILoW6Hwvx3z3LAgeQfRgWfBGi4Icrj7oKqymKeBRRBpp9ETNpHtiLeRT1jgUH4teYX/4EB3Dj5PE42DfGHZbnRH6LP4NFVXDLm/0vnAfqjbF+W8EOZnxnOxZMH9hNrjr7Pyl5L93P63lEtEjBm5oh+5G3f/mSq5oNjal15mxPxfaN8kADHkOG1RSR11fDEZVL4qsaM3hAWGILXtLFphtBiigQiRF5Gj2OQIt3SifffngkQIN4nHfOsFWva+dThnWIbX6J3h/cmFfOU5JLFEBXoTyWs15sWnF0m1QNW+qzbmZZ40dO2NXQIw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 16:57:31.8044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12da1e00-dcca-494c-f438-08df4402b485
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059619.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB155092
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

Fixes: 7c0f7ee00c7d ("drm/amdgpu: add gc v9_4_3 rlc_funcs implementation")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index da031caa4e9e6..151336e6094f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1395,10 +1395,6 @@ static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
 
 static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
 {
-	/* init spm vmid with 0xf */
-	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
-
 	return 0;
 }
 
@@ -1588,6 +1584,10 @@ static int gfx_v9_4_3_xcc_rlc_resume(struct amdgpu_device *adev, int xcc_id)
 	gfx_v9_4_3_xcc_init_pg(adev, xcc_id);
 	amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);
 
+	/* init spm vmid with 0xf */
+	if (adev->gfx.rlc.funcs->update_spm_vmid)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
+
 	return 0;
 }
 
-- 
2.56.1

