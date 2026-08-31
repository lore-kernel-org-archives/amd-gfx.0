Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE64C624D3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F65510EA59;
	Mon, 31 Aug 2026 18:28:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZInEd+hi";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013052.outbound.protection.outlook.com
 [40.93.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D42B310E9FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbZ0lHS5bSSxXq0GqtnDDNl44CE9Z3LMhpzrdVoGhlkAsse9GvUydgbAD6Moy8nD51vQfFkFQVjqkkulxwa9eDiH+g+vtKByxy75jEL6GSQhVsYwLX/1EakEJ++91VQk6eUzPmS+WcPe87tbvTUUYTp9UZplF1dRlAEP+F3Txbu2Fcgdq7Rc0S5YsEEd2ZKS1GTHdEBCzlFq6zP1MvqC8ZxZuVJYMKe01njomv2cD+GXL/hhjAUqoP4kz3r7R8E0Fw9H2TQBrBv72fXGbP0hh5vhZsi0hbklqhcp95lgtKQR7Aay2CG682bnzzZM8CQuMxwhEnrT8HuKAUbnXf0EoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9ogpgxZZiUuB+kMaZhLmW3p58ORAfMqhOk/P2o3B7A=;
 b=tnATogxWTdZbQIaEQbPqBiP3lFCpUZwdFtafN220Z6PAov0TFikclCJ+dug8dhmxlKZQPAOZK88Vl3FuL41ydIoRpdsCTIqrCZGV9iKOG5NTi2/BVqTJWFWo6C5ucqhG5jS+JvXFu/uIpakNpn4fVGq58kGm38h94E6k3rv0vn5o0DJiuN71Q8a/NqDa76fsX6jbLU4+I8wlGO4kIOQviZNp/7V2pwpOD2PQl34F7RXIqIOtTzyatB+xowRcWOEPv7PFOD9lIdoPS9gx/rcp2fI8NC45R/DJ/3ImRf9Y/HmTL4trDkVuZ85sIX5S/yCzrHaaixduz3AWkXikazFRuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9ogpgxZZiUuB+kMaZhLmW3p58ORAfMqhOk/P2o3B7A=;
 b=ZInEd+hiJg8FqZ4RkfjPBHyDffu7x+SHNW3wtSTdZKYd36Rrdb4df0XXmAGCXvd9rjAl0y226m6LqyJ/9l9B5fG/8FnmcXbK+XP3MGV9DP/CDMGimSpWwznlxHQ3GDXA+CN3IRpuBThS73+dYYz1WtwDqIKvTfl+xO7Q1u/LkT4=
Received: from BN1PR14CA0012.namprd14.prod.outlook.com (2603:10b6:408:e3::17)
 by DS2PR12MB9752.namprd12.prod.outlook.com (2603:10b6:8:270::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:33 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::e) by BN1PR14CA0012.outlook.office365.com
 (2603:10b6:408:e3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:17 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 18/95] drm/amdgpu: Add helper function to check psp xgmi ta
Date: Mon, 31 Aug 2026 14:26:37 -0400
Message-ID: <20260831182754.1089811-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DS2PR12MB9752:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7f5f39-69f3-4d70-1208-08df078da99f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|6133799003|11063799006|10067099003|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iJEGzKqSnnXZSupuHBgLadtwuvS4Hr/B+/GkTRpG9GzxUZuT+HB8jtJaGWK5yD2AM3vbPSO1frmOdMKwDW5RlXIFoAy1tohImSsNXDlXVy6XlaBrWazSUkKeEGmxMfZCr/nVCUvyy62++GCCle1SQ58neJ/AULwJFT5Azng3100nnGxaxrP3XTXxOCmk2nq37nyHMwiQYast8ZeeyzMV2LGi8FiGJTFQJ5AUuJup4sB21+tE9ye295HK/h59p/k4L3cGXxaVl4nPKmIz1S5Z3s8Apz7BXVtc5s8rsWRPba3G/UneTiPoYEx8z6xpWWLgFNCbzMMmDGbS26De10IYZpnBNMB33dvIzgYJejivWrG34RPO4OKBKPX3fsV9AtcJtht3f0Fl5o3dSXq87+3AzSZCMLfWWAn/MmCHEiW/QuAoJgkBq3x3i2UEkZ0yWiRSAmGpaVVWykbGfUxEzJlKvtb5zvuIX0+G7IuZHkbF3adsr/Ns/UeHyhNk9y7s+PCMtpP9ymQ4e+nt1lMSaF0R/MyyWg4MROn5zK/pvGQof0gdIsMnRGHnkKbMm8xKLao4AEask1MzQSTfHHK3iyTDkU/sC1vrxG7/f9EG8iVuJE3ViHcy7pEHpqj0hyO1nCUo2xBUr/KflllTy9HCwUt1IYMbANgiLK7gY+fa5C2aQGhHzW/Rl2tJbsmKQL9HqeqgD5UBahBKODLf+8+py6Lo0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(6133799003)(11063799006)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Uuh9YvXQICUaCdUv+ovWZLLha9NW7KosgduNXJ6uKXOTCGcfsSWVP4PvIyZZ/CkrlKQF/ihhUE8+7habj9AGQf7XT7RsF4+czfQStcC9DM/hCEOmWZNWeME+GTmz4qmMKDUtcVNTAObAnlU2dgMWPdGUw6XXiVx/obgT+KrOILoUjBf9YjY86wWDhECpNHWxpSZQk44nUPbBo7OIT+QrDJc9MGOK1n0iRrbvvd/wjsW7SyiqYJwKcuiM+I6ZP2unflC6nUYnYYpTjds6ITJ7eURlJPni1CQFuao5bvMbAcvnoDCle5OR9AgsGKiOtrJstF/wSsygxiOxZ2Q43VNRnpsQuOcTenoFmyaYTuyLDeNzTuhjfiemh8Hk7u99SAdzlwuGYuY7WmNlszQZhGOR3mSVHxw56o41Uy+9N1JpDKCHKLj6aTqlxlpvcw4o+A1n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:32.7019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7f5f39-69f3-4d70-1208-08df078da99f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9752
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

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Helper function to check if psp xgmi ta is supported

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 11 ++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d68b1e5118732..6a66a90c8e5b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2257,14 +2257,19 @@ int psp_xgmi_terminate(struct psp_context *psp)
 	return ret;
 }
 
+bool psp_is_xgmi_ta_supported(struct psp_context *psp)
+{
+	return psp->ta_fw &&
+	       psp->xgmi_context.context.bin_desc.size_bytes &&
+	       psp->xgmi_context.context.bin_desc.start_addr;
+}
+
 int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool load_ta)
 {
 	struct ta_xgmi_shared_memory *xgmi_cmd;
 	int ret;
 
-	if (!psp->ta_fw ||
-	    !psp->xgmi_context.context.bin_desc.size_bytes ||
-	    !psp->xgmi_context.context.bin_desc.start_addr)
+	if (!psp_is_xgmi_ta_supported(psp))
 		return -ENOENT;
 
 	if (!load_ta)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index ee37170c1c2b3..bb84f3a3dc54b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -628,6 +628,7 @@ int psp_ta_invoke(struct psp_context *psp,
 			struct ta_context *context);
 
 int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool load_ta);
+bool psp_is_xgmi_ta_supported(struct psp_context *psp);
 int psp_xgmi_terminate(struct psp_context *psp);
 int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
 int psp_xgmi_get_hive_id(struct psp_context *psp, uint64_t *hive_id);
-- 
2.55.0

