Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49D5606A31C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dZ4c55Ha
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F9710E5CA;
	Mon,  9 Nov 2026 18:47:03 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012030.outbound.protection.outlook.com
 [40.107.200.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C455210E5CE
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 18:46:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyIJWzPE/USgEO5X2YtBtN0khO6ejbm56fnLP5nkbYYsb+cNZjIfcNR1gEqVon1tgtphYpqN3Racd2WFD5Xh/PqIo5izGFUcrEqE+IzHVo7b8/PN9qileDDoxmoebjmO1Ostl64J7bF4JwEHghylsJLDg7BfflTo47mckN0VT5YhhcH8/D03Z6VEQTbbe56QPxUk2IQYfKTd5kRLIEMNjcoQvq/Ia293ornHQ2O+iVBCyNF4++0jHrDzsul7iVzHwHUtwIenpEU6Tsw8i36zK4mCCAV8NBLHG1dC7AvVCVsvntkHOQDUmO3vfhbyHxFsK7AGwrvhXk+6y6UG2v5sFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4tJtcvvEUtplMsraV2bGMP0UkPPav9IcSmqmrWZT8c=;
 b=liLPBLLuqj8iqH/dHWl42bRFovaFPdT8U+xqwDEipfkYrlaVwngGx0lxn3I3AdSaIUCz8RLVPpdf6fymRJlkSGYlQq6JwU/Dt4GaPdKiFj3tiopha3QpKfXzzmlQtV7XBviA4SLdrJy6BlwPvcb3mbb0CzUpigSR+MSlHRIVMMVygJj50iS7MKRp1KGbIFcu9wQ/29InUHgQlZT/knCx9csObKgjCuPl5wARgX6ftZ8UmB3h/pn5eNfpjwHC4UEPZo2LrZBMVx0vemHzbNNW9LX9eLLL1bfRWf7QPAc1pgYYlh58diyoqR20IJ72GefMT6jY3OqsAiAD48+87cfukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4tJtcvvEUtplMsraV2bGMP0UkPPav9IcSmqmrWZT8c=;
 b=dZ4c55Ha8Dgo3SpSnhrQbkPLGY8ebmQy0XnHxrkADURJqAD0vhyaQCQx7HqGdc1a2xw0n27JlAaifqssHV8FEaDHtlZdYh6pO+be9kVock9jwWDFPAsBxlwg2gtj5pW0JdMlGWaDy+fews70mK90IIxMDi6qyWjSy/HZrmKL3jw=
Received: from PH8PR22CA0019.namprd22.prod.outlook.com (2603:10b6:510:2d1::28)
 by MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 18:46:53 +0000
Received: from PH4PEPF0000B611.namprd21.prod.outlook.com
 (2603:10b6:510:2d1:cafe::3e) by PH8PR22CA0019.outlook.office365.com
 (2603:10b6:510:2d1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 18:46:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH4PEPF0000B611.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Mon, 9 Nov 2026 18:46:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 12:46:52 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 12:46:52 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 12:46:52 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kevin Wang <kevin.wang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 8/8] drm/amdgpu: enable mgcg/cgcg/cgls for gfx 13
Date: Mon, 9 Nov 2026 13:46:40 -0500
Message-ID: <20261109184641.3656885-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109184641.3656885-1-alexander.deucher@amd.com>
References: <20261109184641.3656885-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B611:EE_|MW4PR12MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad5f976-4226-4a1f-c2df-08df3e91d292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|261102123227099003|261009223027099003|261021123027099003|261021121427099003|260925021911599003|260925021311599003|260925022911599003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2qKDju146aFDfYouLFoR8CXAryRKIsey4Mvkr2joPMjU3bVGb8FPb4HummfAL2PSVpkkcENgwXj2qOPels0+/tCaM+LDK4+7KQG3ixxtwwvpUXUfAipkapblNUuZjaaoT32GnnUskgnGpbDvOiSbaxd5WCFCmFMD4M+KqEy2XAs6ykU8rI3Q23/TxiFWFYlfhDVaf9uTLtVK4BQVKdWoV4zoYtB+kk87agWiIblRqCIGQpopHjlTnBLQay1H1PisdQEEgcCnXmu0H2U8iSlnBuLwFlDIwfk04otjcGidojz3MX14nXUsCJTE5K2pJHnpOuxc9qJG+k4SDuW0KDBga5zF+HDIWuPZLbI8PBEkklXINmOH12LZenAcgT5KYX6v7wdkwEhaR+Ma9McXEsiVO3HwZ+xdBcte1zBakOwSoCrIiOsL0ZfkCSQd5HwjbgdWWJuYWTICrO6J+se7mgO/IKPfoyY/RJjPcveUwdiSRsolv0ifoEdfZTkM2Hc2zRrjhlutH+TbE5LYuh3/QU93zYkgeEu3ytElObVT+9++g2IwCEqP3QBjjGxzUM49iBeHpPHdGZ+2tJLluKc9nGpuWgIkVxZfRVyANNTPUKbbnur+wQ50/vdu+pHcO02e1HT2MrMJzx2fTL02pMd3iFsAG6IOhLT4pIvKoq0RINGrN/aQYZy2EnwQ/pSjg2R0iHyx0oEsHeRnS1TH6EOeuZIEJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(261102123227099003)(261009223027099003)(261021123027099003)(261021121427099003)(260925021911599003)(260925021311599003)(260925022911599003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +ku1CiTeyPqVzm1MLTwaM+/djPqOoLsm6SRzuGLkR2ckdtSXOmsYNbYqbkBhU4VXFLd9gNcgnADOqICqE/84UIcCusAoLUs1LfD/QRbUXFU/oiHFRcFC5W/Wsd4EGUWqAMg/yMWgaivKTzg3+Y4UH6BKa3egaLMSCY/0o51qae3Ayww/wiUkMFK0CXG6Xde3J5icyME74RFBWtvTKkZ1iaF1WSbhUsB0RJNxe/cOBHK1Zbf18rtoGfxj6+8sttcrc48RS4KxoCkF2RchPPKiKircat45fxrlsVohJM4DACJvjBgPQ6csYotesTAv5Ub1JdAioqIIXXIKvSsD3MJkZf0HAXbkgkGvIOkkNIpjFEZoobFGUTIuPAdwpaZcXnOL5+BYs39X1/5O3mXzWuf2q+OhF6OeRpOEoHxvKxOXzeUNgFPStfxPgJFD1CsZbdPm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:46:53.2769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad5f976-4226-4a1f-c2df-08df3e91d292
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH4PEPF0000B611.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6803
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

From: Kevin Wang <kevin.wang@amd.com>

enable mgcg/cgcg/cgls for gfx 13

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v2_0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v2_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v2_0.c
index 0f358dbe578e6..5e0317560283b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v2_0.c
@@ -354,7 +354,9 @@ static int soc_v2_0_common_early_init(struct amdgpu_ip_block *ip_block)
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 4):
-		adev->cg_flags = 0;
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS,
 		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x10;
 		break;
-- 
2.56.0

