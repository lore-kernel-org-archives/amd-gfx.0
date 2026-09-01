Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CE7C624D3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1E5410EEF1;
	Tue,  1 Sep 2026 20:10:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rsIDr1mP";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 050A810EECF
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:10:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfejPFn0EZpS59RCfTR0llW9zCdGXkB47fVmXacc00oFsLdYJO+rJ2xYdm+Ui8CTm3yxNLeHZjC5miG7ITXTymDcH9GEeUfNPVt1YMP0o0CZqxWTG0jvuBpT3YuSuzLr6bQmxe4D/t0Frl/toWC52jkqzItZtHsFp+ueItDKkLAd9u8iVWwO11bGxoU0BX6SQR43BRs71c06u/K/zdazt3SAdQGOpove5EdkysZdAU93C48fBJEcU+TN/wWQ935dms3wns8rXRgsJiD6NPG5F/9jtrKA5eIq0Y8B7YTCkRXQzjeQBJvI8JRYo3tU3tQ6pWyFvnsQyYeme+Yg/Dm7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTWrAQYNPv22TJ5D3xff4ogQA4kCBKTm9xQVWTRVP9Y=;
 b=klslaYvBpU/776zplgGZpYSDZhsMiP5uijdhifmuOw6Vi0O+7f3T+zW00dlLmu0Rxi7iyazXQxqDV3oRMHwBfkhh71LYkOefmtaha+ETQu432x235g3X4FIe/8KaQGM3loQFXjOzlRfvN7omwBt1e2QcDoT7/5Dngnl8em57QaUhAYz0KjaamPdlpY/r9re2H0ERXGDpFcDxnAZ2pMk5hd/7YtWRBjWd6Q6fdwtXIixiWyHGFSZ+vYtPlS2GW0kfs2/55Q8GKiabRl8VCfLST1V8abxEsQkJ2z0UonNnk8TEze85lNIQX7fUa9+BMgfvBWjGGWEKxW6gkbVzVFCyrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTWrAQYNPv22TJ5D3xff4ogQA4kCBKTm9xQVWTRVP9Y=;
 b=rsIDr1mPV/lo6KgVxBU9Wn9oBm9yar6cpSbsqjnKUDAsOIMHisItcnn3QRoJOAB8zrbpqKeCCvMZuydo1W5LVdG/moCqXuwuIDGoItwWb7uzlJ7cdZrnTh406bZ1IvV0NFpPbevsFYEaLkI5gFcoKq1NMo5sEFOD/jCHDpBcRT0=
Received: from CH0PR13CA0056.namprd13.prod.outlook.com (2603:10b6:610:b2::31)
 by LV2PR12MB999073.namprd12.prod.outlook.com (2603:10b6:408:352::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:10:54 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::a9) by CH0PR13CA0056.outlook.office365.com
 (2603:10b6:610:b2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:10:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:10:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:51 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/31] drm/amdgpu/gmc9: use MMIO for TLB flushes
Date: Tue, 1 Sep 2026 16:10:10 -0400
Message-ID: <20260901201034.2960437-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|LV2PR12MB999073:EE_
X-MS-Office365-Filtering-Correlation-Id: 79cd7df5-e164-4f4f-294d-08df086520d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|10067099003|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: N6G77Pw4DViDEsFPmyUy2hsjDhp5Y1rQlgm5GQwQ7UnJ/1x2GzdmpbIPxHCua0idisuMPRpqEKwL8H+VCGVWglEUF9LoqFjM5HnnY1VX8sXKiy6XDnZIxZsWX5pRJrIdroPp1Y2om5/8osREc8+18Z8XJUyBEHeWgShJbRw3gfJoA2j76/BrCh1IS90uqkKP/HM7VbLJ3aiFdjw2g6Wrqn+Uo9CocX+RcrsIoSx/XL7mqzTldorZd3GI8GRbZbE8oJb46dwJJzkL1QTVU9z4QaCOZj+txr5R01E7Rq6f/WOlvGiQ6qKuw2JHVVyHJVoi24oPPyy74bToQEVsdHU9ud6a1JHkBELC1uIZG85M/CD/Z6y6U3cygEzIKW+hgkk2dEtBfZfxwoIr5LuRPWi8MO7BNEAA9fJek54i3eTjxe5J8eF1m98TtszHvJBdidrYTPzipe3hRolEiinAMEhezYUUfA9WVLGECxgSlxy0Y7xfx6VVLufu9ihLTzorGxR0SiT38vi3mgi958v4ch8GYwRiBYQl6d1NvAoLbm7yORwVXdihdjzcF8MCJilTZ0k34mswRT4yr9Q1Zb3QwZw3EexS96er5Ca97p9dVsX/8ItsUDDnTvwq7xbtd3anyjAfrCDc5PEV2uAp+mOewd/H39qww3xDLnkZV78U8Q9625ATE4QLIsxubRbRGVw6rh4L8bbUTPlipuiOMuAImTuIKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(10067099003)(22082099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R2GvpCPKIhvN8Qzx59bzYKK9XmvP1Rv7NFFL89q0rl7hutr3KHV8qtjHqoQW/s/kxThkZCvSn16Yg75pVBuSD/ogPhlOS6cUTrjbmo6q1CK1A9jRB5wE8xP3gF+ERqsVqEwokTR1NxqNh7TX00Ipab/sjSHd2QwJaYbd+JZ/H/T74wlHbgZlhbeRZla654u/pCtcH9y3LUjSAkcMU3ww/Efd/3byKNqZRWrbIr0FQwSMy7VT7nOxB3PanY8nLJtkvESctUxQtWNeuNSYVh8AxQfCG7oJgsRXQH1UXskuPsMkakGUimrnHVyuSi94hMMNlMeyLHhygfKTkOTCxjgq7PC/n+a4cfFad7vp6RcyLIJ2/L4G3qlKUOiIBB5/yZknwFi1gnohkjySwCP6v2Q7M0XNDR4faBBvUGibuyvucFy2LUQJYMnPSgkEsTv/0okk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:10:54.5151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cd7df5-e164-4f4f-294d-08df086520d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999073
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

KIQ handles scheduling on GC 9 so it can get delayed if
there are a lot of queues active.

KIQ was used to avoid disallowing GFXOFF, but since the
KIQ will wake GFX anyway, just disallow it when we
flush and use MMIO on vega20 and older.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 23de2caf13646..a91d0ddb6e729 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2038,7 +2038,8 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 		amdgpu_gmc_sysfs_init(adev);
 
 	adev->gmc.use_mmio_for_tlb_flush =
-		!(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev));
+		!amdgpu_sriov_runtime(adev) &&
+		(amdgpu_ip_version(adev, GC_HWIP, 0) <= IP_VERSION(9, 4, 0));
 
 	return 0;
 }
-- 
2.55.0

