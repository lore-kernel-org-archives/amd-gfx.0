Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D65C25B4F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 19:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54F75112938;
	Wed,  8 May 2024 19:24:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DN53sAEV";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46FA2112942
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 19:24:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwSKfN24jS2Xr/PXuA79GbRWBaSfMMtoRFQoI1t9dev/yEzkgJS47UU/eyj9mUNtLbNH25y/jCa5JVY2WA00uZ1PDTX5H8hC37BJ7zKvE9w/TBnF5lFu1SSQ5UjQJhzmy48/0FkZUDLwjIUqsyOT/d/7A9KbtbenKxumD6ChIryKw14GGwGOmB9e2jqqZXvsjnxWPdvFz5seDTkgEn7fEIOPXGBkkj54U3maKuhzX7cR60CJkFwgaEQOmMeGBcKAS8U9X5cPZhwXxCBwLf/yL3u1VG1jm16BrigqQ2jQIvhf8cyBtZxUODfO2e8t+1QlYeIx1ZqSRmhhyWaNOmgtdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AimZJOXJ9r2JYYGs1cbWdskGLNZRsyelcKDtzbavio=;
 b=GEdSzvc5KXBUkmqPTZpsZaZVeO23r7TOu3me7Li3SpSud6SYH215DzN/67ZvTmIYOzkQJz1htBaEO0DPtGjSDxwRDB/nUABoO7EfoUeHLNNcpbH3fBURKLd0rDC4UWCNUBamXQtGQ/mAERsv9zUk73OjexkGWK6oZwRD34JDX0vO9B/BsY4dP16AjmKFd/dABX97vije7hWc9BFgwkN8VDEjAs5BHTHj1XpL73zNCjUzDfhjMP/dQDxancG2UU28h2ZzPxzLor5CpyxUohcNkBla90BRaK9PLauxa5xMl6CFel/Kl9THMcGVWVtwy3XXCvyJAi0+qwl1r5tadjiAvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AimZJOXJ9r2JYYGs1cbWdskGLNZRsyelcKDtzbavio=;
 b=DN53sAEVkApy4xYnL78iibwZqdnIfZ7yJvajsNqvEtL0gb1d/yBQ+BfD0F3j8LlM8fWHmUZV9jjaojRCoai+NF5cnyyNGljCWvvffJtHSJo/J/t4ccWbi6nUP7yCOk4432VmMVfeB+Ffj5Oooeck/6pQT+X2RBSTV7iRrsp08qc=
Received: from CH0PR03CA0237.namprd03.prod.outlook.com (2603:10b6:610:e7::32)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 19:24:03 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::7f) by CH0PR03CA0237.outlook.office365.com
 (2603:10b6:610:e7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Wed, 8 May 2024 19:24:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 19:24:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 14:24:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/soc24: use common nbio callback to set remap offset
Date: Wed, 8 May 2024 15:23:45 -0400
Message-ID: <20240508192345.3688461-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: f9643dd2-f696-4131-54b3-08dc6f946b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mR48HsnFAJ6hypV+odBKlUuAJgRIWUn7yE4NlqBbevicMblWqdVPxCp9RKsc?=
 =?us-ascii?Q?yDVMFYfIJOmmWvk6anhGcqAcDHPzZpm/o0yCBcPe+Q43WAxqQBYNMWdRpAGp?=
 =?us-ascii?Q?DnWvirzZ1iKO/2tHpLSJH1YjGVAzKUi1Qq1EEYBtOgYAZ/Ym8Vsba5d+7Nm9?=
 =?us-ascii?Q?wJLYelX1B0E822WscAXsP2g3uETNk6SrQjpz3cPEMn56vnWkSvOtBfq82rlC?=
 =?us-ascii?Q?OIeFWp38M4hN6d9eiSBCi2VSybQKOv+FmklLDdlAKMlR9i7mkCZ4SH+y2qyp?=
 =?us-ascii?Q?ZBPRcoYc8gn+L9C6BZ8JOOL9w/HZtf1hQGszKfVtOGdItlC2tVVgvYfsswtI?=
 =?us-ascii?Q?5GS6yXzcsokdn/HAQUXF+3vnEhvr8EPVXWXkhA+8i9jfboIvyIH+O14i0+af?=
 =?us-ascii?Q?QFPh4EjujlXL4j7QFzhj5Sm+N+9YAVjD8LjKMyk2nyL3m6nYiSJqCYQN2MhP?=
 =?us-ascii?Q?Yyob4yAOjjtWTEur9zLle8bPZJBCO+3NxvY0xQxRYU2LDYs+wA36vvmEJ5wZ?=
 =?us-ascii?Q?WGKyfRgLzLLaDrc+rZZDyMBZc1MirZ6/niG8UYsbbuyZPbp73xdVSWRzncGS?=
 =?us-ascii?Q?Ss0QkQp7nyrYHHvMPKJUFV4yEsgDaZTAYOa6GuxxZE2bqPQZUPxNWhWi9883?=
 =?us-ascii?Q?aRL0YuqwRMgLHzLZHe5vlvR3Cl123VGlh5qsUtsebbRdpi1814+g0DxJo4Uz?=
 =?us-ascii?Q?mHPIuTJvgtZDYkYWw4LIyRZigVPEv99haoKOevAtdcb6EdOvnOu0qglhUmXy?=
 =?us-ascii?Q?IoigGn1i93doa2cIry4Sr4rjTMZU/q+u7OImECm9/Z7RGeSA9RfQUcR1UXGt?=
 =?us-ascii?Q?/KknAosc8RzTw6jehyIHXKmr/shZN/W12O7F+erCgQ353OHml6dlLCUpuK3m?=
 =?us-ascii?Q?d25lSOGe8D3nOEqSj/Nov2jP8siUHqQkHXVkNB40H9KTiRuE+yEUODnq1EoJ?=
 =?us-ascii?Q?0gzbBHQGCoN4ft5aGYqj061KZZbUoIjA43B5R03Z4mZdbVqYbylt2h8xMvH8?=
 =?us-ascii?Q?GtY5al5esyuPyCKu7FYmYWdNjEE0ZqP1KE9No9v+MeaQelTxFh32Z+C0kQe3?=
 =?us-ascii?Q?LKMqk4yl8Mg6otYWLGgFNkcKFk0D1MteIElgUfJe6pBG8QKyNTTySwi3tJnl?=
 =?us-ascii?Q?bu1Y0SKA/arZl/0SvnvhnIK9stgzzvn2CdrIK0+aMmsSU+4XS1AWtU9ouTLI?=
 =?us-ascii?Q?zpLAHyP7j39vN0ASWEsUr8ciEqTHzAgPFQBGzA1kq5G9nv2q6nUc8Iej66bX?=
 =?us-ascii?Q?7YrYAZN1B8BaKsny0+BJscs5cJPGgZlvBwZwWXANRe6EwK/tUrC4TUd9dFqm?=
 =?us-ascii?Q?+pT8dDLTyjlePihYkWx+GXndRs4adcCPNDJl3CwRGM0v0nqnnEiIULtXmWpw?=
 =?us-ascii?Q?1z9O7JMZJyKXYEYNYYyPnLn/mVvX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 19:24:02.5674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9643dd2-f696-4131-54b3-08dc6f946b54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707
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

This fixes HDP flushes on systems with non-4K pages.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc24.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 12900488dd618..66c7138fc6aa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -372,11 +372,9 @@ static const struct amdgpu_asic_funcs soc24_asic_funcs = {
 
 static int soc24_common_early_init(void *handle)
 {
-#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
-	adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
+	adev->nbio.funcs->set_reg_remap(adev);
 	adev->smc_rreg = NULL;
 	adev->smc_wreg = NULL;
 	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
-- 
2.45.0

