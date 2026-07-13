Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63F7C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 04:29:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01DC510E420;
	Mon, 13 Jul 2026 04:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rkuLIkXw";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A1CA10E420
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 04:29:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxyklZXz43Cm6psQRu5yH6rs84c5rNLG/qE9sMu07SHWx49x8IPkiPKZxqeo65UWfzi1xvpO+FpLPCxzVX3UxUrAY96s8+GFaw+MPhELht7X3Bu/sWY7DwORXGlttxIuBjb3x7CjSEqrX7+42NnAClSZbSqGThwGh98bsg+D5+KiToAmgoeM6iIvwZE4cdfqa9citoPx3tDW3BaAMVzWAgBtA/hE5cbxQoqVUiyItuQ35UERyFllZmk4iIqcOznj98qb31Q4jBN+uURNf2MD3ksfl95Z65qyfhhYo1JkOzz941PB00hSDFPJtRv1VaVt00Sp4odmA7tO3HfvtLa1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPgvaBVz8YPt3IdnBLgQPiOol+J8pmDTxCX6nt6Yl7M=;
 b=RRXwHcoaC/vMzCuV7Fkrjm398gGrwjDkwJhvjuI+VihYQIRkLc6Hj3p2Re2/5z+R0EafknT3eleS8xcCNs2EwH8gO58i8L/Unn8cQ31mQf/VqDn6sRwSkloLhGfsqMc2ZzacBhX9bRpLw/KkYhC71BFOqXVn6UY61H3hnn5aP33Ewa/0QDKZER1tJl0W+ZAF8a/OltRDDlAQCnbCUeJdTmO9uILmZBA2PhlmW3RNTmjTD95MRrrbTm8H9H7iIjCqMRdTYkiMoK8K8zXGz/Z7sYC+02dJCz8gQf//++6pzqhV5th8fU4jSMHP2otni9XOInqrMI3J57NEMOjQmYymvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPgvaBVz8YPt3IdnBLgQPiOol+J8pmDTxCX6nt6Yl7M=;
 b=rkuLIkXwBr0OHL9AlX7/cqdL5hEOk5d/ctTzrdwZsnPwv6NjDn1n96UveYlHnmqG408TKHJays2gWVSQq+4bsVBdv/l+c98D39twwKiwpzUNaIOJLuQ7JwkijwEn//ngFwb0ptmwAc6PpPOynrhZl51AnhlD/aU8lcaeYksmDDc=
Received: from CH5P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::25)
 by DSVPR12MB999310.namprd12.prod.outlook.com (2603:10b6:8:41e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 04:29:20 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::82) by CH5P220CA0018.outlook.office365.com
 (2603:10b6:610:1ef::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 04:29:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 04:29:20 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 12 Jul
 2026 23:29:17 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>, John Olender <john.olender@gmail.com>
Subject: [PATCH] drm/amd/pm: Fix pp_entries_max() bios check
Date: Mon, 13 Jul 2026 12:29:02 +0800
Message-ID: <20260713042902.2220454-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|DSVPR12MB999310:EE_
X-MS-Office365-Filtering-Correlation-Id: f439ccec-3310-4d55-516e-08dee0974eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|56012099006|11063799006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: iW3eqm7voWCwj0GYDhnvGZXx46PcIetzLnYmY6rsS++CgPBBXXZxzj4060+sCR7gKE4u7Tcy5tg8+ibgE5EKWQuaP3lUfQjxyuJUzKuhTGfzqkp5xzVAfcYCAN+XTXHFoBhyZtWQecDbOzUMb1Il6JKSCtjmshKLT40144OgVW8lxYYID1hIj/qAbSI4UjDLLsdVgj8ikAOsdnI0Nbo/AInUOzEaSyJiBuEObpRL948kOdvXoR+NKmOhlgt6eh1CTz59v+OyUfXECjvp3XlbgDCPQMeqWmZC/oEF1+VcewpMVD9+sttw2eJ10JsNeLrUnIiPAk31arp6AiluiSfmrIs5yUCqLLGjW253+AWs8GZvrD95Po5IG/mAIosZKINbQBY0fIJzG2GlK2wOyLUrc4gU/hSvWS5zeCnz8jbICtLcBEeiDvhAvgk3di/Ia5xhUGqizRPvkCIhU69cqTRPDxWA+bwEiYBrx6GMu4+0S0W5jJlO8mJWzZHvxYOAQWE/yd4fh9dhLUyhW8QHBwwj+8xBWFNJLKFYA1QXroDzxJemadTrMEJnzvc4GBYSd+X9bTvVBwwdZ4lI3qQywy1PkkE08QKvixhTn0tqJAnBZuqo/le26W1OnNaTcqdfHbokfST7OVo49GtDpeJYEKs3T4SqN7s9qQCrho8sosfEIx+nPK+i8IlA86TBS+MuOkgmGg55vRPSYX0yvVD3mK/iSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TN2Mh1tnAtzOdpoCWeaVlntzh2ygssxuvmzzFsC3E/3G96caaK7Zp3r6yMsBg9gk9t32pkliaJIq8awGrOoxWJdF8GFqtpO2jnfh4+u4hoDuv8ko4yZcpIGFDkOvgR2oAd5B3zX1vR8CzeOGcoxPlSDk+9Yr8z1gd9FwZ6IZGXS1zX9RK5uCr7hQMTKgmoetXGBGgp2RU3PJe3C4gJD71pJmYK+Kg1FHFtX4Yr8gkIrh099X9iHz2OAEMTlBqjRllaltUlM4THwr5gbmurwUqnLCKpMKJlyRPQGftCCRYW/w3/PEH9z0U8qahedn8WgVoMHTGdkwhj5a6xtcdTKf3uQi6VHc/KHVNo0tL2IAe10d28GvijtMxrr+kSeJKyDHN1PMjFeL0bfwPmJZF/8eexkp68q+i8tBaGAbZEu1ELjiWS0xpsh58HyeLQkJUGVi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 04:29:20.1433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f439ccec-3310-4d55-516e-08dee0974eec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999310
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

Commit 3cfe43363050 ("drm/amd/pm: Use uploaded size for legacy custom
PPTable") changed pp_dpm_set_pp_table() to kmemdup the uploaded buffer
directly and set soft_pp_table_size to the uploaded size.  As a result
soft_pp_table now points to an allocation completely outside adev->bios,
making the unconditional pp_end > bios_end check in pp_entries_max()
always true for custom PP tables — silently returning 0 and breaking
PP table overrides via sysfs.

Fix this by conditioning the BIOS containment check on
hardcode_pp_table being NULL.  hardcode_pp_table is zero-initialised
(kzalloc) and only set when a custom table is uploaded via sysfs, so:

  - hardcode_pp_table == NULL: VBIOS path — enforce pp_end <= bios_end
    to reject a malicious VBIOS inflating usStructureSize past the BIOS
    image.

  - hardcode_pp_table != NULL: custom upload path — skip the bios_end
    check, soft_pp_table_size is the kernel-supplied upload size and is
    already trusted.

Fixes: e30b3e3ab51a ("drm/amdgpu/pm: add pp_entries_max() helper")
Reported-by: John Olender <john.olender@gmail.com>
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 7ebc1344023f..a23e01921842 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -833,14 +833,17 @@ static inline uint32_t pp_entries_max(const struct pp_hwmgr *hwmgr,
 				      const void *sub_table,
 				      size_t hdr_size, size_t rec_size)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr->adev;
-	const char *bios_end = (const char *)adev->bios + adev->bios_size;
-	const char *pp_end   = (const char *)hwmgr->soft_pp_table
-			       + hwmgr->soft_pp_table_size;
+	const char *pp_start = (const char *)hwmgr->soft_pp_table;
+	const char *pp_end   = pp_start + hwmgr->soft_pp_table_size;
 	const char *entries  = (const char *)sub_table + hdr_size;
 
-	if (pp_end > bios_end)
-		return 0;
+	if (!hwmgr->hardcode_pp_table) {
+		struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr->adev;
+		const char *bios_end = (const char *)adev->bios + adev->bios_size;
+
+		if (pp_end > bios_end)
+			return 0;
+	}
 	if (!rec_size || entries >= pp_end)
 		return 0;
 	return (uint32_t)((pp_end - entries) / rec_size);
-- 
2.46.0

