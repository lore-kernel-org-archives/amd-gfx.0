Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2A3C61DB9
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32B6410E878;
	Mon, 24 Aug 2026 22:14:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eWtcnrRZ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012016.outbound.protection.outlook.com [52.101.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32C1510E857
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syRXKjKMTd2WJFCewgVJOzu1dSJn/KNzd6VAxqQWW1WZ63FyWBhMQ3K0kAIWPnXKTReGHguPyOoYktbXP2fkt+fcHjATIRGlcrxn1u/6B8JG49igcNG9roj6SpbMuGnmEkMzKa3tAp2eBo3zntaKOkCKBw0GOGC3y+UW3RsmbdH4KxU6a/+jL813NFjdUlYXEwgmI2kkDiFBcr/6USi4Rj6T8q9C6fe4FEEUwUsto95VZm8scSaEYp9jV2yooH7gn90a7s72TvYGjwx6hJuhrysdO62jsHlmJ9V9JCMyuhodsLOzdLvu73G409Xwl/Vqb731tbLkoKFoPfsW/OaD2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHX+Zi0a/K6hC17YtwYk7kqhjDfvji/jR5vW4KEnNf4=;
 b=Lt5mZzzJNpPk0SR6Vz7Bd3AdfKKe32qxmkTtB9lyn5sXdFEqSu2kkYMXRuCbpLHjvo35jQWx7aGSW1rXIuAQaxzmes2SCj28thaspQlDaQ3+px/YQAUYno3W0Y5I4xbA/UqvAPicaqIW4x2eCmbI5T/n+R0xzAynjIP6DrZNXpcGXAt2dIsFokpq5KqY00s1CAsYNelU9tlf9lzehGJtsuG4WcJK5GBwX4CqPgOkyM8VoxWzFlnVRJuwDs7IJc0vuXFcZE9JXcfJCuCua+4/9xauvH9rschoKeNYo5NUsICrSzysaIrzq6gysy3DkmyfrJ1ncjtg1ENq6K4TQjOuZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHX+Zi0a/K6hC17YtwYk7kqhjDfvji/jR5vW4KEnNf4=;
 b=eWtcnrRZvPh7cBMbEEpIdo+nl9BYRSiBYE2ZSvNLdqxYdivKhyGWTV87X8eYkO9MyKklDbwjJG7vK5F3KlORdpummBuOoyvb3gM16+UHpkoQLlzktKMZ3mzDHBcyEVaHVJ5zd2IlEDYqTMgq3RbI4tHjty/giqhhbXOF7cqDQyI=
Received: from MN2PR16CA0060.namprd16.prod.outlook.com (2603:10b6:208:234::29)
 by CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:14:09 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::e) by MN2PR16CA0060.outlook.office365.com
 (2603:10b6:208:234::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:09 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/30] drm/amdgpu/gmc10: use MMIO for TLB flushes
Date: Mon, 24 Aug 2026 18:13:29 -0400
Message-ID: <20260824221352.1793542-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CH3PR12MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f319054-8248-4641-499c-08df022d051e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 7iXthT8KoN2zQLHsgaiZ2qPSKJqXeYSX37hftrWDq+sCrCe3AxxeXDeKGfpgdau4qkGt6MC/vY6atUh6oM5Bd0Gi9HNN+BbJR1BYjJjAbAwAN6+3OUHomPeDUjnUI8e/oSdNbv8RlWXqVpIYl8LgfzdWc42iRDVgerTMrJeAO/lZ7xbRCCMrluuQSQdweL7vLcIKRMSnrW9EljQeJ5a+ESTj0jP4fpCcQKxrmIt0nLecOqNP/hL/yYZuXCET6MNlWAyiH/hMs1m8wZsl1MlBKTSzDB+iJHEetszhLhee0mgZFRLXiBH/Cgxr+oh4HFbBjrtdRBGhpE4TzOh8hu/q3/hvn8EAnZsZkM5gYiTOTyP9OUlTMAhQBGlFanZwRgvhTL/rg+f3j7ZZvbbEdi/kAJyp9ZwGqKPPd88iwt5koX+JytCNE4leEBFDn7H4V325MVBeg84mjj6WSkyxR18LA/RXgUEBCmDUxnRpE7AX7yXloi7+z/X7nuEREBrkk0xq1g8OwSAcnm88EQmGNO74ufcJkdjv2JLxNtD76lRHTBXAEtq8DFCoLKrtgODRvhd1Jru7vTJ9nJbbxLwKjIja7pznRVK4di5mODZ+bFeOHv4tPTLoEGn4BvXqCEzZ0iBJaF2nFNsIYltmp/dQv4mAV1F7hvTU7YA89uJXE88hNEpSRXYAB00mO/K1T9wOeeXmKUL9lsto/OVXE5QcNBFpaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GJUxuY6nVksxDpsEfNlfc+771fo19AjapfeJ2Z894uvUqv/PiQkx/IvgyLPEE1E6UkifQXN1uCCE9gfzsrtdqVoFBURCARjVemt0kYM9XVwTldgrnh2/p7CIjBR/j7bNTPri2nPYH4HsntdFaFc2qPUeV5Tq9JLXEVFko47+atDyq34I4Klbd7sN81rppEfwg9P5I6lANgaKT3f+zlgHw4mGWUhqA3OwLpgm2rN/cq23tzRtAA72hwhoegWCF7I8LSSwo8QGYkMEHS4d/oEQSgY2wEDmVkzM/I7ND94k9oOLnJu3iJG3vnxDF4GCoGscuwGRLc+9asUYT/tap03tVYeNIRGVZum6rWIjH9X5YvJ8OfZ/FXmPHn6ifPBrr6DpIpTuTskCQDOj7OuVBB4zvaO93ALOM9nhh73cdS2b1x4k23klfQ/T6KdHGyH7U7FB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:09.2123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f319054-8248-4641-499c-08df022d051e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728
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

KIQ handles scheduling on GC 10 so it can get delayed if
there are a lot of queues active.

KIQ was used to avoid disallowing GFXOFF, but since the
KIQ will wake GFX anyway, just disallow it when we
flush and use MMIO.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 7ea1c4b878e97..23d9fe995a2b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -884,7 +884,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	adev->gmc.use_mmio_for_tlb_flush =
-		!(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev));
+		!amdgpu_sriov_runtime(adev);
 
 	return 0;
 }
-- 
2.55.0

