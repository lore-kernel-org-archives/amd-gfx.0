Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7E6CD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 06:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 287BC10E984;
	Tue, 23 Jun 2026 06:57:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PBWecxGX";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011002.outbound.protection.outlook.com
 [40.93.194.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEB9710E32E
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 06:56:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTwPQRo37xBuE7kRxiUGMaKbWRPHHs6UzWz23bFpf045EBK0hZ+YHBfsuXUXYvQoFUs2ALlZrpenlv7ZbdrRdJegljl/BE0rFzA2aG8qlhkQmeHTymhMRttIvZTg45sQ3VTNhXI4rUC2khTNLrDOPzNAYWCB6aDM2/OmT5lwj8VA7m9Q01i38bKGxWqJ8eFOg/xcC68ZwkGmp+KVY7/sBFg3l307ITiNbQNKPmsEbfg9X35kfS/lvijf96N34JNPVj5ajlsO5Kvrp1NHxJb87yrZSMBi6h5ARhCXsFqPg1Qi6eUNurzV2ygQsMqtWhmjYmcphzZTfT4JOna1WYdUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQx7QrQA0QthYEsixky0iRR3yNwrymY/yM5Z8hdn+qU=;
 b=BDAmV6r7hTsmus2N44VZEmGe4RB/Iu1dl26KhDhSROxLEisC38OFsebRWD9VtWDRRscKMUEIqE58a1Xj8cHOAIwNBdhlpxbp+jZ0CsacLLWP4ryvsakt/hYexVgntyVyQzyNT5nUv9rZCtuCML13ZoMrK/FXpLdVQmOOWy+zUhfXNXb8V5K0cRJBHO3ig400J+j2A0wjpBYU2xTct2tiLlHMBvkjJ4tgKPddpeRQuo8R0SiPoJlem34irhtJsrwwmGtQuzu7PNV17Wp/Hz5YI/fehRk33Yatr5B3dWUmkgAFzT4EEv/HRGAa4iX2J6gPa8/56aIrkU5Ku54EMfDTxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=igalia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQx7QrQA0QthYEsixky0iRR3yNwrymY/yM5Z8hdn+qU=;
 b=PBWecxGXkLk2KFcWvTXjdMNccE1oEFoIJ4cVpYV29XUxz/RUX/g/SebPBf5ueWhOgG2jA53agJsNyGf19PfglXn+TU2VshiTKRROn16eVk4XTGKuddD7d5588yvrJrMdNXvcXIEnYTwWewK3MWhaJmqFfOyWrhTIMANAP9Fkn70=
Received: from MW4PR03CA0045.namprd03.prod.outlook.com (2603:10b6:303:8e::20)
 by DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 06:56:53 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:303:8e:cafe::39) by MW4PR03CA0045.outlook.office365.com
 (2603:10b6:303:8e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 06:56:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 06:56:51 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 01:56:49 -0500
From: Honglei Huang <honghuan@amd.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <siqueira@igalia.com>,
 <Christian.Koenig@amd.com>, <Mario.Limonciello@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Ray.Huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [PATCH] drm/amd/display: use kvzalloc to allocate struct dc
Date: Tue, 23 Jun 2026 14:56:35 +0800
Message-ID: <20260623065635.2525331-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 2311c4b8-9415-4a0c-3cdf-08ded0f49aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: SahLBeZz8SdZRyefldCpRsGgJbRVNx/bJrxaiOZttuuSBwf6kV5Ufimww6cIoGUWx+RDsj3XJL+Gf1518zbTca5hNgCHR3X1D12vn4TY4kPPQgPvaTXK+DF4R2AYxQfHTUcKxx+pQa+mq8eaEnceu2OnKiHZSgfjzd45YA/61rgBzll16Odu1TnxlvNvPpwJzha+0z6GbnksMTWTr/kSnspToIppZt2/bbAq+4AiYI56hjo36VCwngTGbAuWl/fPHPsdliLXrWlztGftvPOXbgxiWTDrW9iLnahVbypJyFE+/Lu+eQouHAYqL9NDFSy493xW0TyUtEdH6p3YiDw4iYlUrC8EEldqTb04qEqDcxHjQi9CfB1KZUQ9s4h8h0dVxYxiXj+PK5qadd6jsmUbGppqy2dbNNL6qJPtI7CsEgejmlws9lue8SYMmFDW+74u9Bx+OhLavU+P+besPojvlvIDbYPrwHgOCTpodQdT/cccHuB/hBGy9I8CB1Z1ydt2zv/7fv0VNzsvaTpsUHMyx0RQN7qeTWDLBvygcJi/sQ6n+NnuzIhAc7JtNa0gTNzww3aGaexWtJz174bkpvX2eEXm2Jdyi+wDX81QmGhgsLMM0vad+TyZ7D3jTSlK17ndjSOliGBvdWLJJsHLtdomNLXXacpSI340lSPW2FgVayyd7TiJl6/Y82Vt2v71GoAF/g/Xbyqy12jkFZwYgVGxyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ylOFz50YRQtN0SKXqiwbCs44U+OdASF8WaiciUsk7rzcOqR1AxYXY/dnKlhYm9pVbTBvxUs9aFMFOnE1KnWATRSeuiOzFlGU1i2+F+d2pnldaI5inFUdlfhC+i2lgs765NfpKPxWaDfXpSJXKxkKj2+MPQ0qpAA8957R3avjosgJQuUYjaF/bdq1iNRZGzUN9G+vnN+1sCrxXIdByJ6NHyjPVVXB/8SJUZm7G/GP/RqRu0FsJVt0iZ6fX3QJNgCH56zqIWnRLABN2AlE6MlVR8uFW1JDgA/R9yK9rGyZDaE7vlb/x770XY3a/s3qaV3E/ixwFl+1uE7CTXOaEJqjG8/OxBmeF3yZhY7VLZyOzf0hLFj7+Gf/BQaEZukESBfrAAUcJR2XwFJjqXj03DVaTVjKanhWjObU1waQdcSreK25kc1o5c3B56WPd6dA86ek
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 06:56:51.7421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2311c4b8-9415-4a0c-3cdf-08ded0f49aac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770
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

struct dc has grown large over time (most of it the two inlined
dc_scratch_space copies) and now sits close to the page allocator's 4 MiB
contiguous allocation limit. Its actual size is not fixed by the source
alone, it also depends on the compiler and the .configk, so it can
easily cross 4 MiB, e.g. with a newer GCC or a config change, and once it
does dc_create() fails.

dc_create() allocates it with kzalloc(). Once struct dc exceeds 4 MiB the
request is rounded up to order 11 (8 MiB), which is above MAX_PAGE_ORDER,
so the page allocator warns and returns NULL. dc_create() then fails, DM
init fails and amdgpu probe aborts with -EINVAL:

  WARNING: mm/page_alloc.c:5197 at __alloc_frozen_pages_noprof+0x2f9/0x380
  RSI: ...000b   RBP: ...000b      <- order = 11 (8 MiB)
   __kmalloc_large_noprof+0x1e/0xc0
   dc_create+0x38/0x660 [amdgpu]
   amdgpu_dm_init+0x2d9/0x510 [amdgpu]
   dm_hw_init+0x1b/0x90 [amdgpu]
  amdgpu 0000:03:00.0: hw_init of IP block <dm> failed -22
  amdgpu 0000:03:00.0: probe with driver amdgpu failed with error -22

struct dc is software only state, never DMAed and only kept as an opaque
pointer, so it needs no physically contiguous memory. Use kvzalloc()/
kvfree() so it falls back to vmalloc(), removing the dependency on
MAX_PAGE_ORDER. The underlying bloat of struct dc should be addressed
separately.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index b3530fbf32f..65bd927435e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1507,7 +1507,7 @@ static void disable_vbios_mode_if_required(
 
 struct dc *dc_create(const struct dc_init_data *init_params)
 {
-	struct dc *dc = kzalloc_obj(*dc);
+	struct dc *dc = kvzalloc_obj(*dc);
 	unsigned int full_pipe_count;
 
 	if (!dc)
@@ -1555,7 +1555,7 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 
 destruct_dc:
 	dc_destruct(dc);
-	kfree(dc);
+	kvfree(dc);
 	return NULL;
 }
 
@@ -1604,7 +1604,7 @@ void dc_deinit_callbacks(struct dc *dc)
 void dc_destroy(struct dc **dc)
 {
 	dc_destruct(*dc);
-	kfree(*dc);
+	kvfree(*dc);
 	*dc = NULL;
 }
 
-- 
2.34.1

