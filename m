Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEE5CDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B57D210E560;
	Mon, 22 Jun 2026 08:46:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rQ0/f4Rc";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E07A910E565
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBVepfe1nQn/hFedhGzV4FXCj9HZGomJ0dQFUK97V1G7joIS45hYRknBs+qd4JF02Bhor4Zlcw/fVGgyEFlLW8E28lzxVJac+WGurbRT8CXd46oI6scUjlO3qNbYriXw+KSOFIYdXG+KM0MxiLhHasRFzQJ5gJqcC3dWM8KXGUhekMlpEk7cK6k5qaN9CpOn3XUQJOleEEWCVZJxEwTmyDUIspDdZke/EOV05NFV0Fvz7TWleS04SVw2uzXpaOKwGg3LY1JY/Miqo98MXvsk/4O4p5N6+eYIg6s9HWxFZNTMPQB/Pkz2A1IDI3gW53NQCWyLaXOJnUv9H1vTWN1vMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1K1KueljFzEVfyFwMn7yUG382W3gyNDloVnle/IfqRs=;
 b=T8VhHCJ4V4mx54EbGovm6Jx+hlJc6eKmeOxzl7Q6lUD+0yytp84C6i9Ebr8/8WZA+GPsbFXuj1ublL3B2lPOeH208ZVorIylGAXMxSwFA9AT2mEJOk4W0/bYrfOz8tQUFpyQtlj7vZXTmCcC+/T2WLOij/wpG5aMqArWURfa4r5ZmeljbUTfPSEcdYRv69AY6RRVrDn1iJx+nUTDwD3A5Zmg4BvcQjSsZzjw4frydDTuMnPOdpdad0j3qFVnQ0tx0Qg8foi9HUJzFVTRTGFOcsvm6r/bPsIrZo0m4EoQyZa84Y1cz5j+AhLRhxCZL+7mYPjxGZJHGpcJ52byG3RK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1K1KueljFzEVfyFwMn7yUG382W3gyNDloVnle/IfqRs=;
 b=rQ0/f4RcbQZBfGlljQtDZKGNM//JjhmDzZak3uZzL47hMdWT5v94o4kPLyWFEmNMT2C01scsyJIftKm9YR1IeDzFvIMcPXXgBJg+1LrSDO132F8RHPUJ+Zvt/7UZ7qIN+kyE4FvoPd9XA9Mez1RRw8OO3WvEQOuM37KIrhVdkrU=
Received: from CY5PR16CA0013.namprd16.prod.outlook.com (2603:10b6:930:10::32)
 by PH0PR12MB8051.namprd12.prod.outlook.com (2603:10b6:510:26d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 08:45:55 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:10:cafe::62) by CY5PR16CA0013.outlook.office365.com
 (2603:10b6:930:10::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:45:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:45:55 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:45:52 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 23/48] drm/amdgpu: retire legacy RAS reset/query operations
 for vcn v4.0.3
Date: Mon, 22 Jun 2026 16:44:25 +0800
Message-ID: <2aea5dcab742036f649b2f0141c0730695c47cce.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|PH0PR12MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: fbccafb8-d1f1-4448-f1c5-08ded03aaca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: WolEgnMl9+Gz0KKMeamgymocn3n6kOdExMyZU2KIygp6wjs+F8q4tOc2pBf7hfarh0DQxPcJdqyMDOmDwPw8Giqt4cDCXBInRV5a+1xxm266lJj8iHX8xQM7OoBCLUSQnX16/GXVJfuwLhdtYWe7Uy3rzBfjUcqEdB5mqMrOlAAjtBh7UdSGzjhJlSo3vBtakekreGrKDJ0SZwGDheTtefVTyR5VPpihXnT6kw2rvjqh2oIhC4+uZhzy+tHpu9jxj0K5LmZ1p3as7gUQ6bhHqdXquYtV/KdFbtmK7xJMhRVl2jV9saO3mT3e1AmoO7Npi7LuHlQ48fMTpMjAEZTeMp3IKbmWIi5eDlEKDhG+/diTL/m8919NJJfjgM12QCAjS8hqz9gVn/o0kZx6G5WP5Uuk1w5jocx5+iB9iaf5x6lZVX4lfEEeNXV2Tqa6220pHCAPJVDNQTo4oiN07AsPzW1zZpa3uiHYhWZ4XZQeVhhnS0hENNE+pL2M15z8oY+tdoG35ZhlLezogmGYf04HaXTh7wyGInKcjroudq3D8ysvGtcOeEY7oP4PK3lQ7rLt3ejrd0MVSwkCNsF9dXaY3O26y+iGKWhSNJLPj9BeaoqZxs1HYKYBASUW7gI3Gyu8tgl9UOT1KUlx9Mj/edKEo12wU2AGfTWldmX3YjdaTh2nnxaKKO+WKlCk4BCMCeEJFdUg/NXHLOBtRACOcEjSmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6Ug8q0GKopeXZm8jciVQsZgJcpZcgvl4RHA/+oeBc0/ipZVcCFkn8LzK5ceP73sVzpp/UKGYupmW4ELXANUYKw4evhf+yZY5k867vphpNds6B0U3wsh6dQ2RkQzJAh280E1mboo/Ei3OtTrAuCk8PuzbhDlUBk+F6B0sVCknF14ylyT1tW/EImYsk+3hYEt9xZz1nEbzwHMa3nVwiWUotRE8GdRbVAl0X60jZ3O1xnquXggvzohvexxRi6ti0qdHXE21mwmeobZ9o+L/OKoprmEZyNlbbDuF6fskUVdF4BIMwrpZDJhzO5GP3qh7x42lPRQJXRb6mfaEVamWHKcQK2ZHgNKc4U+OcmJu2DbcO6+cz1/QRAWhqo/S+20iQzknbXpT+35itVVDz13JJsU0+IJjriN64c36z6+5bRpcMFNcm2e9vw7U9f3vZFDNgJRU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:45:55.5347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbccafb8-d1f1-4448-f1c5-08ded03aaca2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8051
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

retire legacy RAS reset/query operations for vcn v4.0.3

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 60 -------------------------
 1 file changed, 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 728946911f00..1733c613deb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -2065,64 +2065,6 @@ const struct amdgpu_ip_block_version vcn_v4_0_3_ip_block = {
 	.funcs = &vcn_v4_0_3_ip_funcs,
 };
 
-static const struct amdgpu_ras_err_status_reg_entry vcn_v4_0_3_ue_reg_list[] = {
-	{AMDGPU_RAS_REG_ENTRY(VCN, 0, regVCN_UE_ERR_STATUS_LO_VIDD, regVCN_UE_ERR_STATUS_HI_VIDD),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "VIDD"},
-	{AMDGPU_RAS_REG_ENTRY(VCN, 0, regVCN_UE_ERR_STATUS_LO_VIDV, regVCN_UE_ERR_STATUS_HI_VIDV),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "VIDV"},
-};
-
-static void vcn_v4_0_3_inst_query_ras_error_count(struct amdgpu_device *adev,
-						  uint32_t vcn_inst,
-						  void *ras_err_status)
-{
-	struct ras_err_data *err_data = (struct ras_err_data *)ras_err_status;
-
-	/* vcn v4_0_3 only support query uncorrectable errors */
-	amdgpu_ras_inst_query_ras_error_count(adev,
-			vcn_v4_0_3_ue_reg_list,
-			ARRAY_SIZE(vcn_v4_0_3_ue_reg_list),
-			NULL, 0, GET_INST(VCN, vcn_inst),
-			AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
-			&err_data->ue_count);
-}
-
-static void vcn_v4_0_3_query_ras_error_count(struct amdgpu_device *adev,
-					     void *ras_err_status)
-{
-	uint32_t i;
-
-	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN)) {
-		dev_warn(adev->dev, "VCN RAS is not supported\n");
-		return;
-	}
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
-		vcn_v4_0_3_inst_query_ras_error_count(adev, i, ras_err_status);
-}
-
-static void vcn_v4_0_3_inst_reset_ras_error_count(struct amdgpu_device *adev,
-						  uint32_t vcn_inst)
-{
-	amdgpu_ras_inst_reset_ras_error_count(adev,
-					vcn_v4_0_3_ue_reg_list,
-					ARRAY_SIZE(vcn_v4_0_3_ue_reg_list),
-					GET_INST(VCN, vcn_inst));
-}
-
-static void vcn_v4_0_3_reset_ras_error_count(struct amdgpu_device *adev)
-{
-	uint32_t i;
-
-	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN)) {
-		dev_warn(adev->dev, "VCN RAS is not supported\n");
-		return;
-	}
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
-		vcn_v4_0_3_inst_reset_ras_error_count(adev, i);
-}
-
 static uint32_t vcn_v4_0_3_query_poison_by_instance(struct amdgpu_device *adev,
 			uint32_t instance, uint32_t sub_block)
 {
@@ -2158,8 +2100,6 @@ static bool vcn_v4_0_3_query_poison_status(struct amdgpu_device *adev)
 }
 
 static const struct amdgpu_ras_block_hw_ops vcn_v4_0_3_ras_hw_ops = {
-	.query_ras_error_count = vcn_v4_0_3_query_ras_error_count,
-	.reset_ras_error_count = vcn_v4_0_3_reset_ras_error_count,
 	.query_poison_status = vcn_v4_0_3_query_poison_status,
 };
 
-- 
2.34.1

