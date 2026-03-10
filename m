Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4880CFD2D79
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 13:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF64F10E6B5;
	Tue, 10 Mar 2026 13:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tDhy/Tja";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E0D10E2B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 13:22:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZexNUhFtaOXRQz2X68MKmJobaVnE7mzimpa4h5wePee2T4ov5S8Y2XTFZfBh19FKzxQQCLW5VP4YIbn2Q1Du15PBnQASkugXG8GIgPv3a/B27bwwRBniAw97wDmGIWQCCq484j5CLosNG4BMvO/9l+APqTRLB43vZxaNUd6LwTXnh6YcS2ofeMUw2Z+n4e5ZB7idxWppXmspuwKvHkq027h3VkFSzPzsSGTNCfCVtPwE7RHzXBnmogRiAG2prLvpKsBRefiswOLXWZMKv+GrrEOkBbfqi1sPamLvEli5wijQNUnDet4k+1y++g3j6m4HzUOcLN0xZd4D5CVOAk7m2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d95rDMwRZpJ7Z5JRrB23q6CTDntxMD7QyYXdfbz+Ybk=;
 b=f9FFjfoyY1aAdA1h8w6Eg8aIeastp/NttY84FHhoT9xTIdCjmfwoX09J4g7IeVfmrxV4Dzqg9PJdrcYbhZ3nuTC8W8o7CWHF6AWAuZXbFWOEukiVOM7Mpbqr9uOGUyBZOJD22RqkP9XQgFbdA9Uek3W1lgTXjnkh7mtMW+sum0e+S4J3b2SaU+3c0/vrj+yvl1Y9cdJSHcIcz0Ef+L4j952gNKKCd4TNThl2ath2XvgdSjK7e6fMA/Toy0KbL7bGk10o7AuJN4cADOYpaVrTlJ8gFxWV057ARheilBz1OLdTH5iNcTeI52Bi9jvX0uzwO4HoQaz3iarudNzfmzSAQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d95rDMwRZpJ7Z5JRrB23q6CTDntxMD7QyYXdfbz+Ybk=;
 b=tDhy/TjaqykXhbsACEdmycz9WHfPjoiBNhmqvB5iUxeRWdfV73MIdCNMMrkmfLGa5WXKTU6k4RNfnFoH72EROJtEGabfPpFidoP4mxrTTQBaeq6XLCqR3XNQaJqLSELM85IX3MUrss7tsDc7ZvTtPP0m4Y4yG3/V8sPPxMVAamE=
Received: from BYAPR08CA0039.namprd08.prod.outlook.com (2603:10b6:a03:117::16)
 by DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 13:22:24 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::3) by BYAPR08CA0039.outlook.office365.com
 (2603:10b6:a03:117::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Tue,
 10 Mar 2026 13:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 13:22:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 08:22:21 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 08:22:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Add umc ecc error handling for gmc v12_1
Date: Tue, 10 Mar 2026 09:22:09 -0400
Message-ID: <20260310132211.2867415-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310132211.2867415-1-alexander.deucher@amd.com>
References: <20260310132211.2867415-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|DS0PR12MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c518830-8e50-4039-b68a-08de7ea8111b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099002; 
X-Microsoft-Antispam-Message-Info: aKXtVJHi7o8oGRpAn1bLRcT40nAWHk1SMw8Z5HCv6Br5VyDr+Y7wHhCB530ie6g91xKvUXaoc5388e+NfXwUZdAYHz5dNdzR64GgSSezO3yo3iDN48CX/RDGveZzrcW8z+gubA1UY4XJxwjAVqGMExZV30eshAIWJobjGIg6ZkvfUzT7WSRlhTAWdzdL82ncIAP0hBYlbxriMW37ucnxSK5Y1GChqBz8inu4a9KZwHqWgIXcOHAnajZeoeGabYAB1lrw3CiQO4qF53LPDe9T819fLuo7MZTv7N7fvO7fxVJp2UdfQRTmMgbv0ZOWAM6qph0+XsKii1rciLP1wu3FORR0/FS+jlUlTmHUxGKNsV1s89BC01zKfmKFTG8UiNqFU8iNizzKiNqqEpRySqzxrNtBGT0nzSEPzjidOSQbT4hrefJoh3U+wPkQQ2gqDs6Dimt1qjGM1CtzVi12Iye3MCRDxbkQIJ7wG914gVim4SRbWhNdsXwPuOBZJ3n3NE6WYos7V2U+JRYBCTK86wZAnjdoqZWiiLil/fhpECAXMhctisP9zE2ptqfjDHkaweIX8Wff5VmRtGw60kL1TNjQH+Yjj10aiGlPxpbqs8vGOk7E4nI1SmvGDbQehkiROlIhv1ceCRkZ7nUBSA4i3P7sMiftTL/5Izo+YhfWMcWMgjTBLwlsFxekVIS37LyIpaqd6doyd2d0cqrhPaid9GW30FYg3Fidc1LsH2E/5wY2+Pf3IujhhRMPhevoBQsf/d9adbt3vTulH/Km2x6sX35zNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wdPnUlPidOK0BOkvkr8900RCqbz8SJQ+4BRQwejlr3b34oyoeJhygBVktYkjQGRtDeuuE3elZvuRkKtwLUIwHYbEdFYtoKqWiBboHgLPBI1L8SfIMaouuDLnyhz9+jzjRta7gmMTJFaG0zQu+SyZYYWmUu4EvO89asbhnlguThusqxAvyHI2kLYrV8jPkP6PvDFu6B9/7ogfDKRTrdmSvMYmrjqjF4sQzCXaxR1GNpAxVg6IJhS0Y8cKzDSoeU4KM1mwcaE9ronm84VWIicukPaLZbcCg5MyWiEfXimWsrwx3LGaSZYNW4X/TxOW0O3p36wV+Izqz9tvPuVQxprJJg1jvHjQ9ub7ntrwoVHntklJmfDISvU/EbIiXKNeBezI4nEipXy/7do8rCxH3PxiECwnPvyct0DMav4vppf7Og7Ww+lVxxZFyUI3yaBcoscT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 13:22:23.8486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c518830-8e50-4039-b68a-08de7ea8111b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Add umc ecc error handling for gmc v12_1.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 10 +++++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c  |  7 +++++++
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 3f0b0e9af4f34..1be722ba6c9ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -398,6 +398,17 @@ int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_umc_uniras_process_ecc_irq(struct amdgpu_device *adev,
+			struct amdgpu_irq_src *source,
+			struct amdgpu_iv_entry *entry)
+{
+	struct ras_ih_info ih_info = {0};
+
+	ih_info.block = RAS_BLOCK_ID__UMC;
+	amdgpu_ras_mgr_dispatch_interrupt(adev, &ih_info);
+	return 0;
+}
+
 int amdgpu_umc_fill_error_record(struct ras_err_data *err_data,
 		uint64_t err_addr,
 		uint64_t retired_page,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 28dff750c47e3..8494a55ebf76c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -161,6 +161,9 @@ int amdgpu_umc_pasid_poison_handler(struct amdgpu_device *adev,
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
 		struct amdgpu_irq_src *source,
 		struct amdgpu_iv_entry *entry);
+int amdgpu_umc_uniras_process_ecc_irq(struct amdgpu_device *adev,
+		struct amdgpu_irq_src *source,
+		struct amdgpu_iv_entry *entry);
 int amdgpu_umc_fill_error_record(struct ras_err_data *err_data,
 		uint64_t err_addr,
 		uint64_t retired_page,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index ac39011d1268c..f1079bd8cf001 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -893,11 +893,15 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	if ((amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(12, 1, 0)) &&
-	    !amdgpu_sriov_vf(adev)) {
+	if (!amdgpu_sriov_vf(adev)) {
 		/* interrupt sent to DF. */
-		r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_DF, 0,
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 0, 0))
+			r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_DF, 0,
+				      &adev->gmc.ecc_irq);
+		else
+			r = amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_DF, 0,
 				      &adev->gmc.ecc_irq);
+
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 5e3102d072c4c..38c366b9a88bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -624,10 +624,17 @@ static const struct amdgpu_irq_src_funcs gmc_v12_1_irq_funcs = {
 	.process = gmc_v12_1_process_interrupt,
 };
 
+static const struct amdgpu_irq_src_funcs gmc_v12_1_ecc_funcs = {
+	.process = amdgpu_umc_uniras_process_ecc_irq,
+};
+
 void gmc_v12_1_set_irq_funcs(struct amdgpu_device *adev)
 {
 	adev->gmc.vm_fault.num_types = 1;
 	adev->gmc.vm_fault.funcs = &gmc_v12_1_irq_funcs;
+
+	adev->gmc.ecc_irq.num_types = 1;
+	adev->gmc.ecc_irq.funcs = &gmc_v12_1_ecc_funcs;
 }
 
 void gmc_v12_1_init_vram_info(struct amdgpu_device *adev)
-- 
2.53.0

