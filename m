Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8E5C88E70
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 13:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CD4C10ECD1;
	Mon, 14 Sep 2026 13:07:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="32S6pfda";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9244B10ECD1
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 13:07:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSC3K+mAmb4r6VPYUOr8Ruk5LSat12MpUE6DkBckmvOKjdaTNB0hmrAjf+vsnNiEcsFWTEG+Vzf/tPKT/0OZiHOlZUkPhy+Qu4Mrs9vXsq/wP3iIcbcvVmBUH0bf9l8kV9YU0FS4kKPQxuJwIIxKUZMfrx0d4FBFSojJfaMsZVjEb/KsAEcKrwhuKV3fK/uV83oOJKeqBw339kODk/C8QhP4BG2FyCV2TF0d2ofrboccDC1wTjTm3INgafYKtVG0FyXggysRKElxCoiwWkJP85+Weg/XfxKRQqgPXLzkh+BFwhEjj9YHTDfcX74PbruK8mtb+wSHbvCNKAM6D3mwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+I1dI3NugWPUdvrf4Ar7J4LsfKmJQiJh2NWKpeRUORY=;
 b=Qx7XLxePBdpdPcmIc5lekpR/P9GbosSFpMjZCEslFgDTDQOymroopMC3j3ielnBr5OuHjm5t/S7wwoVMq7JY2jL5N6HbkgdC5441uFEawouayutHljkhd72Qn1GvSf6jvZ5HnaBsYXlbsI+muYllWhYBUegEzJeeLmoV8R7WJ0q5r3Pier7FBz2EGOxbCYz4Ch6dYmnXIENPOE/PzGQD145epS7ScFlXMrDjo59uDzz0OdF0oMRcOHFIh+xGW/b69IMqqwU+8dftHT7SMVMTTbts5SxyTKvRXeSSMuwlpZGGuY435sCL8RXyOt5RBkGzWd4lendaaCUfWbvS4+8BeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+I1dI3NugWPUdvrf4Ar7J4LsfKmJQiJh2NWKpeRUORY=;
 b=32S6pfdaSGqXPZ9UZbTx1nz4CqUartN1vBQDf9dXFck1AlgeNCJmUHgyURDs4X37RLzD9N6focXNCN25k+etQhMsLg5oxZSHEO7u71pqITHwZ4TIJ2GiiEkQNzYtuxdZZ6G48JHVNtUu8byLIwkSUEPb6kquk7tDp1JaIaaNNUw=
Received: from BLAPR03CA0091.namprd03.prod.outlook.com (2603:10b6:208:32a::6)
 by PH6PR12MB220232.namprd12.prod.outlook.com (2603:10b6:510:3da::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 13:07:10 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::80) by BLAPR03CA0091.outlook.office365.com
 (2603:10b6:208:32a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 13:07:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 13:07:09 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 08:07:07 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH RESEND 04/10] drm/amdgpu/gfx12: hold userq refs in private
 fault worker
Date: Mon, 14 Sep 2026 21:07:18 +0800
Message-ID: <20260914130724.130794-5-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914130724.130794-1-lingshan.zhu@amd.com>
References: <20260914130724.130794-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|PH6PR12MB220232:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e878d5-cd92-4154-a5aa-08df126115d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TY27yUFCwMwZhT8qjA7ItI/trMpqmOkWUMdSzVLxEHkcssjE2cqOhwMwfzQd5SYw2m6/z0rMhJ/Oh1c5DUDMEiZrEObzvZtr7JIn6/tEneKamymm7dG94qQ/DBoXodAi6Lf11X4LYJagK0egS0rTYN4o0rHFh/x52TGNQ9pTxBP2k6wgIr5aCs1VqcGmsVgWQBLC3DLn/x0BsLrpb695LGINJkWEd/kt1CPziedWi2d4sr4J+KOf+oFsGv0lUr/u7JLzPde2jl80bIbwE9vznraewjfHfkpK0A/NDDzjBEVQtCp1K2CJj4JCKdBoC00pv3ql/Mr7AwYUwjF6rQo6xMby6eD4nBl92oXexCuoy3mMtfnNMQXtUqE6F3Ju0RtoXg1PmbxlqoTHyj6NM5xIycc/2Wg9qHOqjA6BED6BaMpIZTnZjwatcyTXYspsL6vx8WFZ9K5trJkX0MVIq8D10UIjrl/69f0uT+iwNm8PQ3GaYdpNIjnwYPfDPJIXS1BTaufJqh3RKy2s2dR+Vs4LCY/HaoANF6UXNwbL6DiH2SoYu9LPmTJcucY/23SsPzqS0Vr8dkwEp7Pq1v63LpdbOVRFrKEt8T8cGHAGxAsiJRaq9fbEIBOkMFk/ScKKa9A0294FlG0v8cB+FtZckHTB1L7tpyGenJD4xxt4+Yq2bQyGYTiksWrvK+493sVT6q0Zkk/H/ghEa3oFitaN/thDGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TSheG1M1uSbl/pzjthrXAhS0ogLDU1mSmrOMU0kzKseDEjRU7wTcRHZveZoJDMLdXmR14ORvarS7hAJo9eXuBH94crjyIUHJwCoD7Dg5D9UVsVCuQT7/lA/f1VJgXPkaJX1H3HHyO7PVSV2UkKVMfdHOok2b19YE+kUQloFnpeoT9afvaxEUODm2ZT9fHHZzQAtPxIFsaMHt873vYPt/7M2+U3p0BVjmbpvs3Pcw3BBpv/Uc75ACtC0XWu6oSbM+je06ZIcEb3pRfJ3Rki6BpcOzqlmSGFTmybqu1dOA9oH3UXTMHVwFlIqtHfQ/ohnZOveaMuJtrVlrmJQ1ag97lyi88TWTGoPL1R9aaL/Me1jm88Z36TrjY8ZJAeeFSw2CeyJJxS+8szUpR5wVj8hx5hlQlr6hHXQzYfjizhA2IKoI6hFAMNbKDxxHqFBhw4II
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 13:07:09.6928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e878d5-cd92-4154-a5aa-08df126115d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH6PR12MB220232
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

The GFX12 user queue private fault woker loads
the relevnt user queue from the userq doorbell xarray.
However it does not hold the spin_lock of the xarray
when walking the xarray, and does not increase the
kref of the user queue, so it races with queue
destruction path and may run into an use-after-free
userq problem.

This commit fixes this UAF problem by utilizing
amdgpu_lookup_queue_by_doorbell helper, which
properly hoding the xarray spin lock and the kref
of the user queue.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index fdfee88e41e3..b6ae15066205 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5070,9 +5070,12 @@ static void gfx_v12_0_userq_priv_fault_work(struct work_struct *work)
 
 		doorbell = (db_ctrl & CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
 			   CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
-		q = xa_load(&adev->userq_doorbell_xa, doorbell);
-		if (q)
+		q = amdgpu_lookup_queue_by_doorbell(&adev->userq_doorbell_xa,
+						    doorbell);
+		if (q) {
 			amdgpu_userq_start_hang_detect_work(q);
+			amdgpu_userq_put(q);
+		}
 	}
 }
 
-- 
2.53.0

