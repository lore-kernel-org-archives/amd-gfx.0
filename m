Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B3CCA1002
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Sep 2025 03:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3440510E961;
	Thu,  4 Sep 2025 03:13:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ni2cw7r5";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A66BF10E961
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Sep 2025 03:13:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0fe+SZT1NC5HU55mdRBmj15pRIEbJ+R+YevUL6kzQDYKwX7mHWlD3//EPwKMwPd1DR1LxvzFvdBNPr3yRv2utItt6OPkjWhUMrZe3/E5jF6p3FemwpT6sBY1Qm3fYNRD3iuh0ok/7XO429NxssiublzmnEcx9iCeIVZWmYY33qePmFdlzhtuzpgY6CHM9ID3GTEZ/V/O/ImMVqCProvon+d4j+rsB81i7/hrDJsE9B2Il8ncGFADauirxHGyBfHMgBMoSRZLjfmiFHdKCGHKTe3b15z5wj+ezbfzu6HiLKOEeGwi1X9SAejbGUzaDE+Z18c/bqpYZ1KAL9OrRKvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmkM7t3Fb41eDoKfdmheNEcKuEhFa2/5uHK5WXMZnCU=;
 b=I+TsTTsw1soBK1AUT+ZTuOcjk/222pEIByG6kNGnQdTSKwX80h8BtBHDycoKxyX5Wfa5EeX+YzuH122rnUDRVZ71j6UyXut9ti6+PbLHj3UxHvky5k1KZKFRbWk2LF1gLoslgiLomBtEU3ZwNxrZHAV7Ddj85igxCnL79zGWm1aa474mhrcGCgsrM7JnMlDvNaUOj4rfFwPh0v1q4Mdu+ccSfkrMjhmvRIOClUSZxx2d6jR71MuLbqEMW3F0F8iYlemwaxaKKkZJ5z0FCDtgmXDBxRCns6tulemJaDrVjRKkTQi6c1X7E2meB/7vNOkI1r0hwpSxVocApwiYrZxCYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmkM7t3Fb41eDoKfdmheNEcKuEhFa2/5uHK5WXMZnCU=;
 b=ni2cw7r5BLtj34dU1h5hyVNZZ7GwdoOuM8Vw2PZh4rODUvuxYNOhOOjuyDJlzS0vw2Woeee+2SP+sPR+ZiCcyoZfZzfU1mMjljhpRzOva3Myz1q4Pbij02wfKb3tcE7CRc1CU2a47UWxg+WKoM14LaYOIMxj2IeuexiYTuOPE+o=
Received: from PH0PR07CA0116.namprd07.prod.outlook.com (2603:10b6:510:4::31)
 by DM3PR12MB9288.namprd12.prod.outlook.com (2603:10b6:0:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 03:13:33 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::fd) by PH0PR07CA0116.outlook.office365.com
 (2603:10b6:510:4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Thu,
 4 Sep 2025 03:13:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 03:13:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 22:13:32 -0500
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 20:13:30 -0700
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>, <lijo.lazar@amd.com>
Subject: [PATCH 5/5] drm/amd/pm: unified smu feature cap for vcn reset
Date: Thu, 4 Sep 2025 11:13:09 +0800
Message-ID: <20250904031309.2035678-5-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904031309.2035678-1-kevinyang.wang@amd.com>
References: <20250904031309.2035678-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DM3PR12MB9288:EE_
X-MS-Office365-Filtering-Correlation-Id: 6978580d-ee9b-4766-73bf-08ddeb610792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RDLpzbcxP280wV8MUN75ZNFT+khTcv8K6L3W2ozQ8fsqKOy3OllK1uSM8TES?=
 =?us-ascii?Q?h2T0hc8j2mtvvtVmuc7KP1FxUVibYUliAyJUJkyYRZEcouOqCbxeKupo4TqT?=
 =?us-ascii?Q?VhmCZz1B5XEXnRxwm5LrWGSLgrqhWsK+DpYKFvqp9gz3OJfRoMRQKDu6qmGs?=
 =?us-ascii?Q?mLdqUyDnJIewUXBGzTsN6aJBg4O0NKvwSsBvFAJvPnw+r+BVFp1EREIB4NSf?=
 =?us-ascii?Q?mmTac+3/QYAbZxTX3giXM12WfTYWDGmYQ0htn5OC9KXPLgMi/rylqyQ4CXq4?=
 =?us-ascii?Q?3DkYvqR7VWciH7FZKpwIvxjkTrSaiYDOFOzm0jtgfpvcbWznP5zzvY7QhhS4?=
 =?us-ascii?Q?iNKVfabF2qDk0+3H/D51Zroxlpbt1UnZKxCe1H21aJS3sL12hpNhMvuK2piX?=
 =?us-ascii?Q?DoHuIbEOLsAYEwRCVaZAfboNpkq0ZMODVyjmvXOPKSRofwvNfUoPJSjiEOTL?=
 =?us-ascii?Q?4n9Ry67/sCvUGT4qo7oADZ4pf2jaJFEWccsoscpFmgLh1zjIGdX5IX1kO/D3?=
 =?us-ascii?Q?MitG09fzFvYkI6TQtW3pc/gmMIIWcDrWKUU6v6pM7WU4Wz7e6m9zxXzFmqtn?=
 =?us-ascii?Q?nlTY3O/SLPaA2cRidG3EqLofQxNeI5vrVH2kQYrMuAlieIClkWOa1EgUV7fO?=
 =?us-ascii?Q?lZwn0tJUknEDL3EsfYsG53QXuBa52YlOgrAFKVbHr3FjW6KOtz9ND6oN/ud6?=
 =?us-ascii?Q?LL7lAmCE7vppgXQ1vOvn4WDgP1U0vUIdBIq+nIy39rDNUg5QKiyQrj35pUuK?=
 =?us-ascii?Q?tTaAErEs157BK1ynVfmYD5tsb3uI4nudn6FJYrcd0wcU7v+C/JE/fh8tSL5f?=
 =?us-ascii?Q?vz2Z8xr2uWNJSxbHpfqR8+laI21Ui4UO6ULq2tG6T9oK4Ggh5prge4X7wgPm?=
 =?us-ascii?Q?KUqPcgYO5jrdpakWAG1QxjwNMCcLsp5khiMSVk+WdwwMAtMG+JJnxCeOIKpg?=
 =?us-ascii?Q?2krWHTodhFVwfn9dPK3n+ZTNfZV4WxuiGGabFml6ojm1+GlNKqfPikAkLyaH?=
 =?us-ascii?Q?blQhHvMNqDFI9Xp21+QjuZQFnjtEa4aafh2nPiCSL0/3pUCuk2xbyHviqEE9?=
 =?us-ascii?Q?CIB9YvodjdtN+fe7pbBDFxMvzNW1awc1HSMk+T08VkUgG9EiHMYHXK0s4vOQ?=
 =?us-ascii?Q?y7+Sday9f4X7+YH1KBUr1tsnaDZR2wEshHEWzrf4qyOrKqUXd8wRTIglLS2Q?=
 =?us-ascii?Q?yDBp5LhAONSA1BCHA1mqIg9o3nmsdtMuO6ZnC9lSb5n4dh66eAF8Xy60LSXN?=
 =?us-ascii?Q?yyRfpKV7Jb5ShYuw3tRcn9+QAG2tuDR6BXosAtrlsjqK1X3QVdYSrqU2Hl1R?=
 =?us-ascii?Q?fqnNCmMHRkBFp3cqxYPycvwsPGm1AtoB9mlM5WG7TBXk9fcSi/6cSW8gaDaL?=
 =?us-ascii?Q?KQwIb3ZClPOdBYTYNVFgKN6SnKbex2hc38MYNn1N22HFxB/cRsLjUy45wzg9?=
 =?us-ascii?Q?sFfcjwZWf97E2XizUCIfCab9NxIZIHVHfxQnllMi/e0vA05q7YPvm/r8kMSN?=
 =?us-ascii?Q?snrwVMWP9scGxoUQP5VSP9R07JQPHJtykwV2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 03:13:32.7257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6978580d-ee9b-4766-73bf-08ddeb610792
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9288
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

unified vcn reset smu feature cap

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 7 +------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h        | 5 +----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 +++-
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f5db055d96a6..ae3f7f00c38f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -4140,12 +4140,7 @@ int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 
 bool smu_reset_vcn_is_supported(struct smu_context *smu)
 {
-	bool ret = false;
-
-	if (smu->ppt_funcs && smu->ppt_funcs->reset_vcn_is_supported)
-		ret = smu->ppt_funcs->reset_vcn_is_supported(smu);
-
-	return ret;
+	return smu_feature_cap_test(smu, SMU_FEATURE_CAP_ID__VCN_RESET);
 }
 
 int smu_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index d4ba1f87a0a7..61f5d30d06f7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -531,6 +531,7 @@ enum smu_feature_cap_id {
 	SMU_FEATURE_CAP_ID__MODE1_RESET = 0,
 	SMU_FEATURE_CAP_ID__LINK_RESET,
 	SMU_FEATURE_CAP_ID__SDMA_RESET,
+	SMU_FEATURE_CAP_ID__VCN_RESET,
 	SMU_FEATURE_CAP_ID__COUNT,
 };
 
@@ -1433,10 +1434,6 @@ struct pptable_funcs {
 	 * @reset_vcn: message SMU to soft reset vcn instance.
 	 */
 	int (*dpm_reset_vcn)(struct smu_context *smu, uint32_t inst_mask);
-	/**
-	 * @reset_vcn_is_supported: Check if support resets vcn.
-	 */
-	bool (*reset_vcn_is_supported)(struct smu_context *smu);
 
 	/**
 	 * @get_ecc_table:  message SMU to get ECC INFO table.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 89360e345c25..9be19a7fb6e1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3224,6 +3224,9 @@ static int smu_v13_0_6_post_init(struct smu_context *smu)
 	if (smu_v13_0_6_reset_sdma_is_supported(smu))
 		smu_feature_cap_set(smu, SMU_FEATURE_CAP_ID__SDMA_RESET);
 
+	if (smu_v13_0_6_reset_vcn_is_supported(smu))
+		smu_feature_cap_set(smu, SMU_FEATURE_CAP_ID__VCN_RESET);
+
 	return 0;
 }
 
@@ -3899,7 +3902,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.send_rma_reason = smu_v13_0_6_send_rma_reason,
 	.reset_sdma = smu_v13_0_6_reset_sdma,
 	.dpm_reset_vcn = smu_v13_0_6_reset_vcn,
-	.reset_vcn_is_supported = smu_v13_0_6_reset_vcn_is_supported,
 	.post_init = smu_v13_0_6_post_init,
 };
 
-- 
2.34.1

