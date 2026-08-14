Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351FAC5DF76
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AE1D10F734;
	Fri, 14 Aug 2026 21:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nPDXUFOL";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B40EB10F72B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KItzof4L5fbFBFqEHZH+Zzwky16iCt99zmP8/ZvJAbAGAGn8/VkV0/AXdibbcyGkgI6iDkFY35Mmmo/EtNCNYMsQtG/BVtBpR19a/95obffOiT/JJv0Q0R43T1DJQhhCk1gfJX92wjpPdRh+KUIXEVp08XOLP+opr7MFefX0FkD6cvzv332a4SxqwkfnEi5lgdd+drCIQWSth46wu8zz2Qxow6gxfPXevivJKWnkEvOR6pdGnVgvRWS9TJga8nPOHp0fT1HnqCW/0vSxfp0ILubF2L52L87nUms46lES40oD3Y1fCu5r1u5IzJ/703lN1bN1ueLjiy6iH7e8QA0WJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiftyhXZFn+g5/VCPLRl70wqSu0PIbm6MvfwTzovUqw=;
 b=y17QndrSdIPDqczGj6WqDTRNt2iyLyiIg2B79Da6mH0xGb9OGWhDGAh0mdt0d7Ah3ZIJ43ALB0x1bqLNQvGU0rtVASWZpSgvXYcAI7biAYSY1CPjZNXx+5jfY5iCbk9Du77m5X6tEY4BvLh3CjPoErksYTxq/WD/6VJNvvYkDr6cMZkC/XUqInW0PYMxWkrpio5uuaDMOeCJPZ1F70kObk7wpTKNBI5FL32v87lnTr/62TS/FramwfzbX+cRHfa3iHZW3QgHturXaiKe8cXT61hW6QIU6LSp7f6I2/BJpyOqq3dxNYATk/iHNidZvz+QHyQfqADC5qqwr4jx5ErWgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiftyhXZFn+g5/VCPLRl70wqSu0PIbm6MvfwTzovUqw=;
 b=nPDXUFOLUat3LNXmJ9j923NIQSmNOSHDDK+FP2DpO78g2W8iMBqWQTqlvyBfvvFhVSuhBY+GMtmR1eD3PAMAXKw6ta9IO+nBVUbpDbrdRNSELjnjEqZiKNgUQFySkw2z6ksKf9VJE8Qjw0uod8r40ywZb3LyOH2w94KlZHe6sZo=
Received: from BN9PR03CA0987.namprd03.prod.outlook.com (2603:10b6:408:109::32)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:52 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::23) by BN9PR03CA0987.outlook.office365.com
 (2603:10b6:408:109::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 21:03:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:47 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 082/109] drm/amd/ras: replace variable with function to check
 poison support
Date: Fri, 14 Aug 2026 17:02:19 -0400
Message-ID: <20260814210246.3067612-83-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 88af75fd-74e5-4066-6094-08defa478b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|56012099006|10067099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: eHJNn6kQJ9nQ/EVH1BRLIcxKcR/CbfuY9Iu/oMMggZOtnQw4rPyxmBIx0SYh81MaCDhG7ZSWLYPxZDBWG58oQXFMocEs8ygSFOJvnGv0IPsR+IVFXLhf7BN2Ml4Qqlvtr7KI3VNB/hZpQdMTittr07Aztwxd0+G+CrnJTGkejXGdeMJIZx2IalmkM/ox3Ca6Sjr8eWzc6hml4XrDYwM5u2LpmEA0xHVNupfFW9sSbr5kud0QWcXPVpqjYnJGmeV0/cczchrdOa0LIlPT0bohLWAxPCsW2ma7Bd7jNwQkMOHZ51VlAf/clEEZiS7kOV0ki0ErL/gf9/fy4KIYIaWiQAgzeo3wGbPVUMhvxlde5mwuLzqxWLrzb4d9EXgP0m2moMdIs4jXwKnQoqurDdaWTa9Vtd7zowS2LOegWFQB1udgd/g8NJ4Ls8zdRRs0DNjfg41jQ5bcAewxhf4GdUsiJb0udedvhdyRsVJDL8ShazawhBdzFnn3o6dPW/7ZnvirAAmEqXppGA7eiMgrddiO48VHPDbdzEXJke/PMvbiRfOhWuPwc2hGabs6AfmWhjgIwtCtGlFeoklBZ984cTSTr/D2bHpkrhfKbCVuJrfYK7K/+zGlDcuiJ6jw46kHZwgNW1g/Imku+RB3LTxAw6+OMdPyF1jrG8JVqYcx3Xre+Qb19VzQbxTolaTdTPRgZSegfICXhE2ij0wqlzKIkq76lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +2oJOyd5JEHpEePzD/VDF3mFsqmcN0eUVTKZthVrdVq5mEkMpEWfVBUH6ob4SlbMRDQ12hvHnHog0edc1MECF/+F69E++c35qx+i7tHggvmtJEwhYR3VICRSins+r8yqibGDewUSBpmxEoK9gDJbzZgfjxe0OFx0d8/0hT+wZrCJAztQG6fHyAtHcdxhhm+y5plbwxEK4KzYk33EETDaIu6QxhLP4yIdFzTQ1gdT55ppa1AdR/VJaQmVDNHGE+8bCIcOjWGyKpqsRtKIcyMef3thtuhVCgAktnG8nJoCg9b55IVOzFyuyrsGPpEzXQQUosgihBXJKOB/GO68knb6SJxIViizKlx92xUvjftq+EcA/0Gv0WAdwiTh9otw1NAdHfm8KzFZMJom5VCnOH3atOrzY+HlJYhu+s/L9U10Bu06UFXO3Q1fjjUuYWtaivN7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:51.9313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88af75fd-74e5-4066-6094-08defa478b4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
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

Use a common interface to retrieve poison support status
to avoid handling ASIC-specific logic.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca_v1_0.c     | 2 +-
 drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/aca_v1_0.c b/drivers/gpu/drm/amd/ras/core/aca_v1_0.c
index c2fba818a4629..1f0ad3e502da1 100644
--- a/drivers/gpu/drm/amd/ras/core/aca_v1_0.c
+++ b/drivers/gpu/drm/amd/ras/core/aca_v1_0.c
@@ -176,7 +176,7 @@ static bool aca_match_mmhub_bank(struct aca_block *aca_blk, void *data)
 
 static bool aca_check_umc_de(struct ras_core_context *ras_core, uint64_t mc_umc_status)
 {
-	return (ras_core->poison_supported &&
+	return (ras_core_poison_supported(ras_core) &&
 		    ACA_REG_STATUS_VAL(mc_umc_status) &&
 		    ACA_REG_STATUS_DEFERRED(mc_umc_status));
 }
diff --git a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c b/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
index 60d087d977b14..52036ca7a39af 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
@@ -120,7 +120,7 @@ static bool aca_match_bank_default(struct aca_block *aca_blk, void *data)
 
 static bool aca_check_umc_de(struct ras_core_context *ras_core, u64 mc_umc_status)
 {
-	return (ras_core->poison_supported &&
+	return (ras_core_poison_supported(ras_core) &&
 		    ACA_V5_REG_STATUS_VAL(mc_umc_status) &&
 		    ACA_V5_REG_STATUS_DEFERRED(mc_umc_status));
 }
-- 
2.55.0

