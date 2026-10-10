Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C4ACA9EC1
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2026 15:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46EAE10E300;
	Sat, 10 Oct 2026 15:09:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L7LcsSL5";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012027.outbound.protection.outlook.com
 [40.93.195.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 151F210E5D4
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Oct 2026 15:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yiu/JjksRW4MI0B+OJqahsR36Z/RfdZ55SnFX1Yqa+2kw9hxjr+RG97oykSB98w2qRvlUNhHh8DC99lvlSUtoYTu35+xCAVjY5pPzz/PD+X7ReXId4ahAQJ98kE3AEScbt8O4cDTw8pwDE4ubcKMjTeN+NJ9x8pXV2cCiX6yf2TvE8SbsowvwRiMQ6VZVhT5fQ18fiCBZPJX1zk0jMQo3lBcrNxjq2LEw3j+crTg7TMJHP3d3yjB21ll2/HtAQs5dr6to8R2IvOiuP+g6/WptK4RhKqJv9Plq9EiD4/E1lD4U6waHe87HNTaTbluJzJWRl+fOaWNCw7pA0pcRxbMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6I7P4tG8x/pr6jCouKXKQUFiZwmjTGavwpze1xRLdsQ=;
 b=lGR58TDR/JDrBLYvy7QulOLHDBSC1o56KNgwFPxEI0pbBKNOqOXRlx1bBa2zjLOqnYzuTExZJGQnhyOTZWUK4KqFpXwDTW1Zt2FHunRkPQbUXg3xNJhk4Ca8Vz9YSA8Pwa8hlSVzd0wnSPNGVdSSsBv8n8x3rqzfLjQWDe4pIyQPQT/SkywHSeg1gvIYb1mxDwTUO+X04c8AXiwoDxCnMB4ew/fbStK/N21bLpA3Iloa7VC4o11f0GEenQvUu6GUEXMjU58Ltx3XXtOsur5HJJanYLDW6CFs3cHDRDXWG83tCnsEpA2qPVzw+cIrU+OKPSN7P0jg59BupJY5VK1G2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6I7P4tG8x/pr6jCouKXKQUFiZwmjTGavwpze1xRLdsQ=;
 b=L7LcsSL56XvYwaAlIxExrw2C3wlNqJSMCaE/1+CWrAUD9gS8tVU1RZg2XB6kWjAbZme2OC4FYPyJF7eMxFBkYNhC+IbhPH+raqsh8IAFOK7XZLSCMYTHBQWC+8EvhQtAuiSOVHoTRHEa+NUHZZ8BzR5r+x8kruPITiFnXG7QUIY=
Received: from SJ0PR05CA0167.namprd05.prod.outlook.com (2603:10b6:a03:339::22)
 by SA3PR12MB9091.namprd12.prod.outlook.com (2603:10b6:806:395::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Sat, 10 Oct
 2026 15:09:41 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:339:cafe::35) by SJ0PR05CA0167.outlook.office365.com
 (2603:10b6:a03:339::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Sat, 10
 Oct 2026 15:09:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Sat, 10 Oct 2026 15:09:41 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sat, 10 Oct
 2026 10:09:34 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amd/pm: move smu_feature_init to smu_early_init
Date: Sat, 10 Oct 2026 23:09:30 +0800
Message-ID: <20261010150930.212730-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|SA3PR12MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d9a135-e1e4-421a-c753-08df26e082b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|6133799003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: /Ip/6foA9oZzojxvoL5kNvHDzMcSVrtjV4/BCtFUY6jxBkRr/seLzbUY6fUH2jUx7D+fqQ0LApI5HYho/De41JhX/Wooims4Ec2JDOhghCpNn6TahK8Ng7wsQ1l+kUmfurOaSg/yJ//N4RSkXHyYrzP8H3+AD82gevFJrTQ06Y0+EX+/HXj4M/x6KVInV0f4SyIkUu1R1r7bCRSrgqjbGo4ezb573/0X3BiV9b7ot0lBj3TyqOV54d6yCSL2XVjGwAZMt3NsnNz1CHWlX0GjQPhz75Ia+2nzU4cQGGH83mgIp0sf5vhsXxziBLT7lqEro3TZpHwGT23GUmLTxGu9ATuy/LFX8GUJJ46WLN27w/UAngMyRNhPEA6JvzLJbhOKn2L341+2utmHxmnKXS7X/fChpqAhqhHR4nfkhwiOXh0xnImSQbmqgeQJD/nfS2lafW9moE/n+VklHq38fY0XWQLu3mr5MuF+sofgSKxt6ZTl3rHjBkKrViHfHUMwwcKWjEuMuKHkbl/b/IQX8b//UTyvWZUz2PVod87dn7rMllVrt3oGlylmBj3/tqIEBnq/DnAuTu/xENEdjxVhyY+QYOMSq1h7G1uMQ4x6D6sjJwaPmsyCnvDh/9KhFCyXQsIezTgV+EwJeB8X1C70SJMRJHf5ohJaeG99FM/IbWVAMNaSZR/NYfZBaRwyrgEzkpVzqa6F3QLbPpqkSePqT9Xmyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(6133799003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NqfS1VF43MISxmIXlQghXTqIEGGz973b1Wh06Z8lag5jIejXjYZjJY741HNjMRdhFpdZ/pDtnTRHMa45jrXD/hl129+B8jbpxEEuCNh+XwHrflWFoXe2v5k2LSgGLXlMy7S2MZGLIPejsmy36fIx5cu5yaisNHGmpbNG/pWS6uR41B1+gPT6dA54SJ31vL7NptlPF+NXJSi6/TbwEkp41251fBSgWEuGAmnL02unAQt/cH4iPXc4G/XDBvn6Qda+A+sAK12vLwlDNdJy0JaWG/Zeq+yQKPF0CM/wHXKqoMAMmrR171VxeYjJrevceRzSkFP9Z6UI4xvXPjJa6QZ3O7wy1qZL9NiR7oDqiNMsxSuhtvWy+K0UXSNpgW+JKjCxCBxeuKp2EU8bjv1sU6pnE80MVoydqd4C2JtKnDA2aVFxR9jlQEMhJQQEcvfSSfIF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 15:09:41.5989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d9a135-e1e4-421a-c753-08df26e082b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9091
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

RAS early init executes prior to smu_sw_init, leaving feature_num as 0
and triggering invalid bitmap operations.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 44b2e8d8b956..9e9c1621b21e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -884,6 +884,9 @@ static int smu_early_init(struct amdgpu_ip_block *ip_block)
 	r = smu_set_funcs(adev);
 	if (r)
 		return r;
+
+	smu_feature_init(smu, SMU_FEATURE_NUM_DEFAULT);
+
 	return smu_init_microcode(smu);
 }
 
@@ -1417,7 +1420,6 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	int i, ret;
 
 	smu->pool_size = adev->pm.smu_prv_buffer_size;
-	smu_feature_init(smu, SMU_FEATURE_NUM_DEFAULT);
 
 	INIT_WORK(&smu->throttling_logging_work, smu_throttling_logging_work_fn);
 	INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
-- 
2.34.1

