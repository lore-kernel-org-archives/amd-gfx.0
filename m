Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F9FC53209
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 19:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCCA510E2F5;
	Mon, 27 Jul 2026 19:43:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F0tkCPyo";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65B9510E6D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 19:43:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHAh/iFMY3Yggm+1iIOeFRaSOP7ZyWtiPLGiUnXgRKU0M1d49wqS+kXq0C5lFYeY/+sLgcclad5RoFJdyBXEhyXWMpaO8mUotuhGxBdHadNkTgDExUfW0JGuGdWb/QiWuAV9CLkyWMwgy/mm5q3oPEnH8A0pIrGl9jJJV8dtHq4JnamCNYBBrHJRCvSQq6S9Wnofju/1F1as9YmUi/RSLY0OM7wyS0+Dgb43L/UtmSRa4Ic7uZvESRjdUjH525epWJs72fo9rTquR4ZpR9YEvdcC6nzBGayVawozzgbX617PLwMj5ceyi4fmR82MkjAdzt4VDA/dk4UmNLG6duEOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ta1oTadHKuLAsFlkJ2C7pQmqz3dInBrer+mJEPfl6pc=;
 b=jrxHh2Z40asLVHalpfrRHKOXpVstrXTsxWHXAIV2qb/s8q3ojydSxVTCaUCdhWZfhJNAcObE4eITBQ//a+Lmoxzg0SKaaJxy3VhJgR5hfpf14dUayJs7kg5Wkk1RIZ9dWLyl3mEYwnfZetJXYvgpixuCPXUNWZG5reemmdjdHhv8+dM8ZJjosAZep7GXIwBzxpn/0vZ8RHQGLv6ntF9lF5fPug+9y3GlpKEcpDLa/s2DoB79tJiVWRI0kE3oV+l9v5peu6hPjKy0PDniA/mFdM81x4DzYc3Wnjxz44O8Iy68qpeBspeLyhCpsAp8KlNuW9se6JR1arXmXfRQXeJAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta1oTadHKuLAsFlkJ2C7pQmqz3dInBrer+mJEPfl6pc=;
 b=F0tkCPyozAZC1pHHg778Yx47MMy5PZFHCHTVzxM27YzjPN2iNKba3PSTnxRJysuN5i780dwhyYKIZ2lSnaC4QxokNMGnFyEOUv1s0XdaH5DEvd1fjQken6PLVgT9wPAwTG5NP+XyvETPOQjW8o05U/UF3nIu7NZVJjGUhtb4ezA=
Received: from BN1PR13CA0022.namprd13.prod.outlook.com (2603:10b6:408:e2::27)
 by DS5PPFB8FBD73EA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 19:43:18 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:e2:cafe::5d) by BN1PR13CA0022.outlook.office365.com
 (2603:10b6:408:e2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Mon,
 27 Jul 2026 19:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Mon, 27 Jul 2026 19:43:17 +0000
Received: from rocm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 14:43:17 -0500
From: Harkirat Gill <harkirat.gill@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Harkirat
 Gill" <harkirat.gill@amd.com>
Subject: [PATCH] drm/amdgpu: cap GTT size to physical RAM on APUs
Date: Mon, 27 Jul 2026 15:42:07 -0400
Message-ID: <20260727194207.176803-1-harkirat.gill@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|DS5PPFB8FBD73EA:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e53226-c22a-4df4-9d47-08deec174e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: hrkiElz10sPQZ4IoLs8TbRGkwqLfO5JM1UIODABn08ojuvQ0VY73rjgGuNy+96l06NGlhVQj5gum1AL41FabpvJRnQxCmHbHej2Vffw3r4GIoaBzPrFvnxS3WtQKm1CevCQ/DjFmOtvIT6/1Nhcm+lrN/oEnGEwq5bXtn+eU4jZ29fb7D9XL+h4pnfHrFzA3TF77aJFwy694xGET8fejIw7dPvPrq+LceVlN8SztAzkuZf2PAHyqXtHB2Vw5QrdA81g4hgOFSBhoLNEtg/l1Lhmj9CfQe6rMeGxTKrFReLH1ej/k5AdBICQnxGsR5XH3kOUkUlUwHRZAYAp/nbY46lXg6bgv1eAEFTIV8mK5ulSe9gJi6gDaieEyIIePieeI3AyXa4Fkqhrkb7U6wpZtQEBrek+wWVlDGImrZLED3aXSD0AX0gH9Xnl2M52KmQQTZxtFcaVtwgcY634zBt04UCYGLF94dK28E2xiXZIF9Aw74zeIT2payXdmnVXXxmAMU64gBsYGstfmb8aK5Hd63Yg8lwehH9Zo3abn5JdDVjetUrzXJlou8r02eimP6SslcH3kh+VhSxcY58ZY2mKmecfQ9F8/1+0PSSTJMze0I9J+NALe3RBijiqUfJF1TaAKAuDfyMB+V5/AFfaQB/VO7fBBFH3+0l/aH32FWPMWC51TEhxuFSGQSnUPyCbzbeBMKoDeN0k/FEEDF1BQTspGpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TQJQREbY6IeA1PVnWcSAdDlDZu/SKyarCRHxMALglilEVoNUpjbrb9LvUh2EeHfz3GnY/JezsDQ2ZBguhlVCerEyCyWwREwoAnJtB4fDM6Z/BQvonr556vppD0QjubIAeewh6tcEG9ZtecBfFg2/CzX9TNHDsgAimMG3oUZx2yjjZvt0IPWS4BkkN7kut5MnTfzddeQElgm2XW0AkkqBPik6iL41f7Q+T6N29h9YpjkPjyxUQlEkcTE1cxYQRduulqgOSFuIm6CsCCwSJ2ex6EPin0lY05Ah/R8gLQCd7VJ7j1dcvNjQhNDrkdNAp0YsWoXGUHeBtuENsndAYagkreqJUGzNeH9OXFgkfS9ony8onY4yiKbfcUBuJ6Q8i2iPVT1MOkVQuX1qpIm41cT3kqSvF2UNyNXToEx8H21FQah8bOfOc2onfLUJbgzgfYpM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 19:43:17.5001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e53226-c22a-4df4-9d47-08deec174e4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFB8FBD73EA
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

On APUs, the GTT pool is backed by system RAM, but its size is not bound
to the non-carveout memory that actually backs it. A user can end up
with GTT + VRAM exceeding total physical memory through the following
sequence:

 - Have a large non-carveout memory space (~128GB) and accordingly set a
   large GTT (~100GB) via the ttm module parameter.
 - Lower the non-carveout memory space in BIOS by increasing the UMA
   Frame Buffer Size (VRAM) to 64GB.
 - The previously set GTT value (~100GB) persists, even though the new
   non-carveout space (64GB) can no longer back it.

This leads to a case where kernel reports GTT (100GB) + VRAM (64GB)
despite the sum being greater than total physical memory (128GB).

Cap the GTT size to totalram_pages() on APUs. totalram_pages() already
excludes the VRAM carveout, so the resulting GTT can never exceed the
system RAM that actually backs it.

Signed-off-by: Harkirat Gill <harkirat.gill@amd.com>
Assisted-by: Claude:claude-opus-4
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7920675af..da89d19dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2173,6 +2173,18 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		gtt_size = configured_size;
 	}
 
+	/* Cap GTT so that it does not exceed total physical RAM. */
+	if (adev->flags & AMD_IS_APU) {
+		u64 phys_ram = (u64)totalram_pages() << PAGE_SHIFT;
+
+		if (gtt_size > phys_ram) {
+			gtt_size = phys_ram;
+			dev_info(adev->dev,
+				 "Capping GTT to %uM to not exceed available system memory\n",
+				 (unsigned int)(gtt_size / (1024 * 1024)));
+		}
+	}
+
 	/* Initialize GTT memory pool */
 	r = amdgpu_gtt_mgr_init(adev, gtt_size);
 	if (r) {

base-commit: ea97ab2759506d9a818ffed1009bde01062b4091
-- 
2.43.0

