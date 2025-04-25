Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44927C369C2
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 15:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE1D10E326;
	Fri, 25 Apr 2025 15:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KlPAORz6";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6766A10E326
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 15:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=te4lu7L1brLhdOWl7O5C3q/2pLf8kLFeB3QZLBLWRmfg0vtCkV0Yb6W9Yu5+uoehtshB+PpnFTdtKCmQp1JUqDaFzqKKNf21kikY1/Nh58oWn9l/0x94ZIhPcUJqcVxh+Y3WR+F+7D/SvEXpIgLoqnha+y2aaWEUWkx8AXLd4bZC6Yt8JCLCnhx/ahlJZqR6Pfx0MsfxNJez+H/78tl6GNmpPT7UjLAnI0vSZdiLT4TVdgZBvukjCEtIEJwuF5lPUgVST7b1NdN3UtTd2pUqG4dBrt7xlPDDL3n5rrvmpnl+wImv67PfHG5G+jKOWTle9CpBdcbRtuDjJ/YoU6yTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9lKwGklGhbMVh+cmW1KKOpIChy6kfGwJluzQOWIi2c=;
 b=jsf4yikLfjLedF5UH/qQBbp/jn6DutPcFo2w1Tce3i6M6fscn/dEmXoAOUPILetETn3/GOnjQn+iX9eKhCisM0ehPDDgYf5ZME907/1UihZcegfa1jkK9+iPBQ9dRlePnKT1XTiWetGvsdMKZNdbu+bjsdwJ6eiF0OfOuMNpv67iSSpg3qQfJBlz8AJbUthZv5iH0dnQWMzOdSvtw4rdGyjOlgYptSNGs+R3eoxNqmxNBw0Ebe0cSaNyvtCkkLOl4rHmpNz1BFk2iygmEwmJURdBkleeOpSFJjjL30pgvdBadAiIw89XaN+C+4EXLvPTlQBvmYOJW7FtkNWYvzOGbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9lKwGklGhbMVh+cmW1KKOpIChy6kfGwJluzQOWIi2c=;
 b=KlPAORz6jWe45OLMv2uMh8NSVS1ZAKE0qm+Cw1U38u5XpCXmowawIEYIOuJQW5RCygIQvlF3nTR4tTGAA+zLEPCPiTynAAvaEbAfxQYEgvtTuW4+52DbW23WsM+F15JO+CmwuOULg2ZpTt/FuCe5uFS6UwzGLM1Ld3O567hMWC4=
Received: from BN9PR03CA0989.namprd03.prod.outlook.com (2603:10b6:408:109::34)
 by CY8PR12MB7123.namprd12.prod.outlook.com (2603:10b6:930:60::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 15:39:25 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:109:cafe::11) by BN9PR03CA0989.outlook.office365.com
 (2603:10b6:408:109::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Fri,
 25 Apr 2025 15:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.1 via Frontend Transport; Fri, 25 Apr 2025 15:39:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 10:39:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 10:39:24 -0500
Received: from RSB-CVSLAB-03.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 25 Apr 2025 10:39:23 -0500
From: Nikola Petrovic <nipetrov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Nikola Petrovic <nipetrov@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix GPU reset handling after WGR is triggered
Date: Fri, 25 Apr 2025 17:07:50 +0200
Message-ID: <20250425150748.1338-3-nipetrov@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: nipetrov@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|CY8PR12MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: afeb6597-68f9-417c-6f37-08dd840f5b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wbbY6A4j4AwsDJ44TR8/YhqKtlSVzmDMWzPgQ9acakAlDjfeq6vdNwjfw/PG?=
 =?us-ascii?Q?Dd4ZCaQyxGam/vXvf0dGOwqYs37USN6h3EwTfGlaj/HWfAARBO3Z0h+C6o9I?=
 =?us-ascii?Q?qauuCF6tR8uIt2n+OXglG7W7cWLSpv9ggSVWzpEKEZkyG4gY9tDpam77vlbg?=
 =?us-ascii?Q?L4auoUi94wVZ6+mhSs8xqOfjMNvsmSWvoYe88ek8GZVfLz0D/sX03I7S/ybg?=
 =?us-ascii?Q?vbhc1ik2Rz9PoGyV30jSOEIJeWfVHmcU9RrXEuMSmsAQI4/aVWkiE+OMXGNc?=
 =?us-ascii?Q?2TuFKn4ljeXJIWVL2VBv8gKogR6o+mTLj2wp8PUbnLo1hd6IC5yP7+A9KIxv?=
 =?us-ascii?Q?qt4v9wkC09qL2h10FRlpTxoeQjz6FZKyK1IOUzThW9dWeKTHBazCqee3XtVA?=
 =?us-ascii?Q?kjATmitz9ik3FE+/BXVC/pJooQ4kCn49FOb7CMYY93X8hFbAc5z+OtZ1nn3C?=
 =?us-ascii?Q?W4Y2Q11A8WwwJtPMpcgxlYzzalOyCeLgE3KGGcnvHUSMSa/faRa5sB7z8wpr?=
 =?us-ascii?Q?mZEdbjKClI2ktCd0Whib2ivARPvr4m+t3ZzVO+UIOJTeCKHFuHw1CvoKHiRv?=
 =?us-ascii?Q?aR0+Ifl1lAnLCtwXLuszrXuDBSaX1dCPjRDSjwqJfXxZ519CGoPoTAomdgWG?=
 =?us-ascii?Q?PYsssstbNbGjjRM3oDmp3kbSLEoaN1tC9XcqCeuYZNAzM1NB+1NEgmaEb5Fx?=
 =?us-ascii?Q?A59QWDsHuvBjvIgbw9NVZAiyk1QJo0FzaKFyxHtt26iUfZyxXctNL4H+McG0?=
 =?us-ascii?Q?MNZVTuyo3q9IkjXAKuf5r7nqr9N7efz881LLrmKfacIqC4ALlH6mC8JDxKNG?=
 =?us-ascii?Q?7xJ/WYdZJkMVO9Zm97dQVC2wHr+UHtejkQhcwUUpN6V34GUJ+SQcglFjU14q?=
 =?us-ascii?Q?3sZPP02F3Tw1kJNAXxYlkrVwxHgPWsbHfr6izJBBwE7+jrBVl2eealJ7rkbj?=
 =?us-ascii?Q?+zHUUvzXPgqv/X06+FTwl7Jl/lC65qftUAjQ1RudCJdoCAFEaap4UEjv9/Fk?=
 =?us-ascii?Q?9RWAosHqMETvvTDiix4gYF6EfxUKupO4AyMTydpzBJGdTulEXZZZzR7nuBm5?=
 =?us-ascii?Q?6/lbgGWIazwm1aCbJiPsoBF75Rk1Ca1uGQKPPjuGprBWZn/wZ7HjTFVWH5wT?=
 =?us-ascii?Q?MlaIkE9h6ixO+FgZE6xwpHuuasEeXt0UE+0MCAV6uk3bC5pO4D9US7za3LN6?=
 =?us-ascii?Q?js/NePkkONlgUsi7AzJOfhEDXFs8k7zNcFXl9+yLeDPJvlTpdA7mJrv4myqO?=
 =?us-ascii?Q?KM4ofyluthe9co3ClxpeaDJgPJzdPq2YqVC4kAKjN3LddA9JNvw/sCEQc1wc?=
 =?us-ascii?Q?DAh7rFYVMSm4z/MZmiJ2M+IzTXmI5WCfwE1Bec8YjeK04k+OH7zvSJBnsMDs?=
 =?us-ascii?Q?FuFnffMJ/E15wMg70+b5UiuAoNjTRr1sy84VdmVUfBMOtNYdygE+uq/CVMTE?=
 =?us-ascii?Q?PKRw4xwshjK+MW+IqMnxuB2Jo2ShdI69JbWjzHH5U6tGkzbWF2UpV2PK2qZq?=
 =?us-ascii?Q?6g2ObzK++WwKtdAFppKs8Ty3Z0artkBzA5Li?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 15:39:24.7543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afeb6597-68f9-417c-6f37-08dd840f5b52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7123
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

I've identified a critical issue with the existing GPU reset mechanism that causes a BSOD on the Windows Hyper-V platform. The current function:

static void xgpu_nv_mailbox_flr_work(struct work_struct *work)  

incorrectly sets the AMDGPU_HOST_FLR flag if any engine is hanging. This approach wrongly assumes that the Host PF is always responsible for triggering FLR. However, a VF (VM-guest) can also cause a GPU hang, which results in an unsuccessful VM reset. This ultimately causes a FULL_ACCESS_TIMEOUT on the host side, leading to six attempts to retrigger a Whole Guest Reset (WGR), which results in a BSOD after five to six failed restarts.

Additionally, the current sequence sends a READY_TO_RESTART event and then requests FULL_ACCESS, which seems incorrect to me.

My fix addresses this problem by using REQ_GPU_RESET to initiate the necessary restart while appropriately handling the FULL ACCESS request. My implementation has successfully passed 100 loop tests, confirming its effectiveness.

Signed-off-by: Nikola Petrovic <nipetrov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7f354cd532dc..a2a436707200 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5314,11 +5314,12 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	struct amdgpu_hive_info *hive = NULL;
 
 	if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags)) {
+		r = amdgpu_virt_wait_reset(adev);
+		if (r)
+			return r;
 		if (!amdgpu_ras_get_fed_status(adev))
-			amdgpu_virt_ready_to_reset(adev);
-		amdgpu_virt_wait_reset(adev);
+			amdgpu_virt_reset_gpu(adev);
 		clear_bit(AMDGPU_HOST_FLR, &reset_context->flags);
-		r = amdgpu_virt_request_full_gpu(adev, true);
 	} else {
 		r = amdgpu_virt_reset_gpu(adev);
 	}
-- 
2.43.0

