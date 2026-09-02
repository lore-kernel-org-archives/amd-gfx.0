Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C223FC624D4
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 21:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B3B810E03F;
	Wed,  2 Sep 2026 21:43:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sKxNUjFZ";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 829DF10E03F
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 21:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZB3FQSY2khf4+TfddcLUiAEnaFk6net3XgzxUA+9RidutYhaa/eUWnZ6CfLdxqHzhyhALwHp+ZLoZxusJ5CuNr7UjPLgJoZB0AO0J7BgCAM47ZrD0b7F7lnCbuhpfLZQWMNUJ15KwZE/DGTv6lS2gCf2ur0tGswGsB09f/umAHhHhEIkXtdRDXwFtjYthJV/2jaN5agdxu6qaaI+fXF7yBs8DxfDujY1W+LUljcxYA/dpsoo19h9sV+IesE/KPTE/d9Uwns0X/ZpyG/+w2JSn1shJ9QomRS5jxDbIZ7csA9hNZLww+vK8B8Kzm9AQh847fFRsnfrjpt4NEPO4Oyg5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/V/zfNItrQlnHCYCfLxe2J3YUNLLQmLODqhgGvGv47E=;
 b=Z86J1E7/iIoLl5LubvefMnablP7EHbvyTc4gEmgyCcoJut4ObR1X6U+2XRnQMckmtsemqYlQHfC0Ihk6bORD0ntP6/F9wlgg171M/S+sCB88KiKjEdnHk+cor5ssr5iMP4DGRx2fXBO0glHCGaK6wn+QtKLw/CVWhlrE54ddN7dtGUIuDwZImN1MQykKDk4NOUNVcgOxe0Rpwkt+fq3vDG3dHe/hTXOaNnTK1w1iF4Ag+kYfeRFtjJIBgRUWiGydqTrvT3DBTg6Laj6SXm8ItIEFnOwp1OZSfM6SM6f3qRJipl9DcaUNBD41PI/lf8C9nvnFcaozwQ8RvggLDII/fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/V/zfNItrQlnHCYCfLxe2J3YUNLLQmLODqhgGvGv47E=;
 b=sKxNUjFZx4uXNmskmxRzE8r4XazDLrdt1YG97zyzfg1fILpGH602ik5dUy1Yy3C+TGpYa+UjDDSqAb5iAl5r5fLeWw/0D6LgLWkmvBK218VYKZq2B272mx8UPT0AoHlLHH7kd8gJrj7blc3RrvlJDTu3XLzKC3IVX7AG7UnsoyA=
Received: from DS1PR07CA0023.namprd07.prod.outlook.com (2603:10b6:8:44d::12)
 by IA4PR12MB9833.namprd12.prod.outlook.com (2603:10b6:208:55b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 21:42:58 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:44d:cafe::59) by DS1PR07CA0023.outlook.office365.com
 (2603:10b6:8:44d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 21:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 21:42:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 16:42:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 16:42:55 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 16:42:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gmc12: drop duplicate gmc.init_pte_flags
Date: Wed, 2 Sep 2026 17:42:41 -0400
Message-ID: <20260902214241.2903550-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|IA4PR12MB9833:EE_
X-MS-Office365-Filtering-Correlation-Id: fc06f513-1369-431b-e179-08df093b2777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: zB7V1DjtWywKSccKCJIsQiLjgIrEpvkw3ZZX7KAQvd/YhGPhLy9GAtX26H4uJkkwihmZHf4HNVlh5WcQLmsiB2LxYOgB9XUwy1OVbNuZBwZtp3trRSDis7cx38BI/WQ1UhxSMdVwKOd0dhzLGNIgIM2DuZ2Ywm3JjscGxDjbhxJ8xsmREuYxtQLHsMjyONzsOW4tmdggu1dIGIKXxgfeHMtJSRFPeYQNvjY8CC9IUySq2qR9AGGdVN93lcz/D/ZzV+GZ5xnqJWVelK6KqQVzO0G/FbPij1JTg1zVshsKeUa9Xw1LwZwd1vsmuwMZ4Q/1wlO1Rr+yyPGE2+KUNk229JnBmzQ6oW4auSOW+EiISWVXaN4bF2tt6F5sVlIola29sGDPjFSnQp8BPaodqbzUHNhZZ2FwQPQy8EEdV2wQw91Kzwtqrf9ybez5LLYnXGYpD7VtmaNb/RcjwprFoxiQkbdmvWjkQKY5L77KVHjgn+Nm90zwln3bAmgLFiVTkyeqZYaBiORW0L4ORFGU29RQnO9qILeRTV1NDYFcywTxjMHj8idSPf3x+dccBxjahjppeQDDYKFn0iZ2p+CQ/4K9GUNGp85ha51dn5DP+BpilW0JWwca4Vy5fkYEsIq/za852kL+/OcDhQh00MZ7QVrfLRqgvBd7fIlFssmUxFc3lqUPjHxSFSoktumlPbSw/45kIkpO3Su0qerUNb8JQChWnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pP7fYawE3Md3QAur+uLtXZr6DtxcMyBq8gdLLKsoNZPE+al/3otyM5OJhZhbU0puXhN5y+wzpAWxtSww2pfO+kSew5elDl+LS3dcUWeQo0/KuWLkiAvZiJCPSMVXMoGpUKdS607xmRmDFUG5PMIZQTe7xvJcqZC+E22MmqyLaTOr+43QWglmmgQRWe1aI++fx5Y0b9dIigXlikUNTIlWxASInNdF5kowdVrCRihLpVd58kRgbwpwcFhctByDzoWl+aSQTVGIGPXwO/suKyFaCXmtKhcmkmZgnqJy6V6JQKvoabjOlE0Af36pIiA4g9AfYl7pwMT6awhDlAOW/i1TDavP32fy0K4zetJJqJzJQsvoU1nWVKMdVFrTPZzXBmyPO8YIJLW55x3gkYI917J5Rjn9wKRffE5lAY7r826HXUPpInuNDrRkQ8zgtYo7Hl3k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 21:42:57.9010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc06f513-1369-431b-e179-08df093b2777
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9833
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

This is now set for all GMC 12.x variants in
early_init() so drop the duplicate setting.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 0cc73982ed6f9..b6cd6babb035a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -861,7 +861,6 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		pte_addr_mask = 0x000FFFFFFFFFF000ULL; /* 52 bit PA */
 		dma_addr_bits = 52;
 		adev->gmc.translate_further = adev->vm_manager.num_level > 1;
-		adev->gmc.init_pte_flags = AMDGPU_PTE_IS_PTE;
 		break;
 	default:
 		dev_warn(adev->dev, "Unrecognized GC IP version: 0x%08x\n",
-- 
2.55.0

