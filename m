Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A82FF8860
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 17:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 377AD10E86E;
	Mon, 27 Apr 2026 17:31:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FcBqMf2s";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010056.outbound.protection.outlook.com
 [40.93.198.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAEAD10E861
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 17:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSml0r03+55bHmh4fXnzpDNy6gHQjxOZxmdnZy9Uyoo8/FTzKIXoc3t0zRi9aJAVbE5wl/1k0XRyRoDY9KU0Qsbw6AopBAfBaDhREhODqhSkBae2Sq8UjMq7RLXjXnJr/BGFgdySa2xzEI7b7/VgjQUyHF/HnhgAiq5phIMnsDTpXecaLjIxPXXsBm1z07z3Dt1PDaj1Rn8JQL8TN9mVugNNO6dtlTjdS2G7JIs7YvvtI42ZyhZ6cmaJnq63ch7HGXSOksmxHrJ5x+7qSjEfFZYmtLp0Fa1bn5vwZMYkzydyH+M/DB1wzkmlV2JRgo8tx42WAv7DCU8wrARuA1KvNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtDAch7RLakwwH4B7Vh+bPBfExSINbBXUt6wVpSwu7s=;
 b=keRnt3zuh4KaOqyUwF3rNeZ5EzzT5YWz84LBcmMV/XPE9RkRIy5NjymYVfe1CXg9rypyGBsBju4vwTLbZ/Mpoc7YUwzc4pPsSVKaPGTvRlRfgi+Z9P4ytsKDNHo+oyj0V8tx94iCW3J2M9XJ3LYOJOZ4lv/j/v0ohpf+39auGJJEGJm6UooRi9K03FGk48yq7hBzY80tKmOs2Ju8pnnT6mlzAwyMkkLWtAb2UNQNVt6BFcsUlFP0dt7UeJrRioV6Rb89uWhxXckCbPEhjturAyVeFH60WRRuyXhWklco7Wuxb1i95I1ADIApGGoVSSoXtaU/ZmOpo2Vr5/pkMS0/Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtDAch7RLakwwH4B7Vh+bPBfExSINbBXUt6wVpSwu7s=;
 b=FcBqMf2sCYZlxRQlt6wyJ3UYHAVCFQGD8NAb+6hQ44x10ZomDE7xdj5q6WZaDO3+ihsvuKo5ZG+xk/ZM+RxtwvqPTVaNcICo7jRzroIHvPiE9p1f4L1Nml/3SD9gHLo9z27HgD+WIEreMzmcVjDRuYpOOvx9f7pPW6oBXc9kgsI=
Received: from DM6PR01CA0002.prod.exchangelabs.com (2603:10b6:5:296::7) by
 SA5PPF6407DD448.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 17:31:32 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::a7) by DM6PR01CA0002.outlook.office365.com
 (2603:10b6:5:296::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 17:31:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 17:31:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 27 Apr
 2026 12:31:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 27 Apr
 2026 12:31:28 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Apr 2026 12:31:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/pm: add missing revision check for CI
Date: Mon, 27 Apr 2026 13:31:02 -0400
Message-ID: <20260427173103.1020723-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|SA5PPF6407DD448:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b36372b-4576-4597-cd65-08dea482d2c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 3Gfn28jNNAED3GhKWEPVh3IIl6xB/1nHEFTkVyfuaeZL0/Jl22ZOWyvBI3Ki/dsSMJbfTWT+b4I8UemE0hAIUoH05H5U07fjgna51RxbNfBseqXfptyFGP2YfQ/gC67F7EUv14RcbHSNjn0F+isJ2qpmN8zT6SRBAm8ptOZRFMxDL/t3mYtBnxjhsMo7a7u3R5H6sifK1qF5qdMG6LCDCErp459ibiKU3S+r5SIyu/lPxgiKnfs3Kl5nn1Crh34Ta0JugEXwZUhkqy9Gjq463BV3Aj5DCWK9yP9nK5pYmA+BRnnygxy2pKt6f3lXH332REYmUflV8632/TUKgSfaP2rmXVt1OBMveBM3XP9S6ZK/gNWBfMhO0GAvX0qWLgvtqD9CsilnvOfBsSab1Ni4NcA22ZZ0fXL76FGiHFowKK9tkpXgFnHwx8izqCpQAI2cv3hsU1uINdMXjr2/2uhxiwvb9OU6xJyXwh6fogmF83NMT1r3E+nL2LHOGf4pQss0IP+nmckv215OCiQmqSQ/+sLxFXcG7MEdyPLtxjAdAtw7D1Y8MNpDgNt4+IRTvbHAuAMzgL551hcyYUKuQ+lYKE5/uXnluzMo45hGg1TyKSXKCIfgSnR+GuKhsvTSNa8WGOj0nTgHuHb1b5cta9zIDSB3g/byzV9q3mHbXd5nZJEIUbX9y5sdlSfY9BUOulicNzhEs6Qpme2+G6+h+FVvlylI0CTXKJ0GvkqS6inlcS7KVViNTQcxpdR3lsQnfTQ5Fzx9UunblmQ3Fin+ub4Q9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4cntvKDhH+kegm0UDjML2s81uH2hXO6i1w3PxwUnKE3JaAUM+H3vJtayHCpa4hOoiopWATItnDP2IrLIpmxKBxsa+qUjoVjyC3grT9wMiGC0bkGCc3e/DfhY81/NZsebtgv3gVL4RFvct3ljqGpsu5THrB3ztgsjJ+2KdN1C+T62/Z+V+h6SNNgnW8AjvHGYH9Mbmc7h1DXu4DYyAh1b9poNkAngAawlZbAxtFZcEb+TxzVZyeacoOy3zJniYxmdB4nIdCpFJgZNla+POTnPktBSCV39gR6wUQxqRCh+s5D2Pi5rYTWf3+VLZS68jX9X3X2M7JeOCxnyw+i7dB8lB0g/iQKCQnN47655NdTLAQxzqR4McR6rOMK6XcuqIgY9eO0x3AhUoAz3Hyz78TU1e3y0wvdfNFlQvpvx/4sKr7EaENeEDzg04RcFDmsAqN3i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 17:31:32.1441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b36372b-4576-4597-cd65-08dea482d2c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6407DD448
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

The ci_populate_all_memory_levels() workaround only
applies to revision 0 SKUs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index 69d8b05ef2457..6e89a032e3dcf 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -1333,8 +1333,9 @@ static int ci_populate_all_memory_levels(struct pp_hwmgr *hwmgr)
 
 	dev_id = adev->pdev->device;
 
-	if ((dpm_table->mclk_table.count >= 2)
-		&& ((dev_id == 0x67B0) ||  (dev_id == 0x67B1))) {
+	if ((dpm_table->mclk_table.count >= 2) &&
+	    ((dev_id == 0x67B0) ||  (dev_id == 0x67B1)) &&
+	    (adev->pdev->revision == 0)) {
 		smu_data->smc_state_table.MemoryLevel[1].MinVddci =
 				smu_data->smc_state_table.MemoryLevel[0].MinVddci;
 		smu_data->smc_state_table.MemoryLevel[1].MinMvdd =
-- 
2.53.0

