Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609D0CD8C83
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 15:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4B1D11A94F;
	Fri,  5 Jun 2026 15:49:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t57CqIAl";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E48F11A951
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 15:49:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnOZ8srGYS1LhPbpkOLwVc+Fk1y4onwtsd9KgwyOtYrqcp/otqgRQbnZoXdysRX8t1to9RWEo015V1GmsUuiRs+wuuz8+kKHThL3TOU2BH6K0mfuKM6QxBJDKD/y10lWI9lgh/qqBdyMeFb73WoeiYZPKz0rs/CEuIyfKXsF+OTi2L2XDmCwwiaN4sRe+219OSK7Cuwl/uWuTAQqCGy8CLzYXJkOtL9EGLsr/ISgo28gYRUV4xZwjKPZtZWeMd6opozHG/VcCOGePa31up6DlKQeNTw2P9c8DY0d/vkoWLBQqe3Nz4Bd1l2bo4JUVctNiGDlMcxVS4SYbl6BT0EnEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKCmgEdqLQ6c2J4BZ0v3S+Vbhj17t2ZoQu4GfD7L/no=;
 b=BjG/5psEgnm0UJy+C9bEpi0PcOt59bLnnN5XS0idDEu1Qh/iVphckGLeenRjHJCp9dlNcD42WN9CuYIHB1KJO1TZD3XjyTBnPX2Ny4a+TiMDK3dAqLugLCJu3+8yZZNPYlvxgxbv2ey2yYbEIKoooedeG4Qek57kSw5KGCohSX65rVIobBMFpg2xqsdojJYx9+JJZ8y5JcqI3ZOzJd929VKLlto/etBrXHG1GuiGEU5ctP+RhJ9gmbLlceOxaaYRDO+ywLlmkd4AS9vI+1OzNFxmO0T/LtjlJMo7NdqH3z9Lmc3CDyNd9+TKtPfwV5RXMjmKerHbBS+TPaQP0RFjLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKCmgEdqLQ6c2J4BZ0v3S+Vbhj17t2ZoQu4GfD7L/no=;
 b=t57CqIAl5o+hVyeUQCoSzmNK5TJBzUftRMxl8rOlpHtbbVvKLdAjctnDC3Mz7NB4JIoGAYeMW491khpp6lBpvgt/buNQBBywGEi+OZfB98NzCODD08xV6O+FJJ0/jA/XLDE0iwfI25uC1xlDefx48Scv6dBIoavA0Sm6bIMzJ3I=
Received: from MW4PR03CA0103.namprd03.prod.outlook.com (2603:10b6:303:b7::18)
 by PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 15:49:38 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::6c) by MW4PR03CA0103.outlook.office365.com
 (2603:10b6:303:b7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 15:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 15:49:34 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 10:49:32 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>, <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu/gfx: fix cleaner shader IB buffer overflow
Date: Fri, 5 Jun 2026 23:49:20 +0800
Message-ID: <20260605154920.1314590-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|PH0PR12MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7c275c-eee8-4814-05ad-08dec31a0acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|6133799003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 6O1wwcDTSUw0aUAtKqKUOFhvVMcJRslDsVHP01VlnLQBXpn0knuDpNyLyagr9h3JIAnLhDnxBheFiDmKk7oZaF0jf+l+36Pvo/liw5Rya/cmccHHI80QBv7bOBCJazUYhdH4pcBlKZ9gXvFPOPrmk1cz9ST+4lnHAhKGS3RDMCUB4MTcHOHIFWyjA1nviun+mTpOCNqQHTrmL0SqVUKx0CKlrh6W1E6h0Iv8OLSIAh4Y96PqmndLV11GMLn7a8s2TcAK59BSiMr8qgGzQM8Wp9refxnHZqHOwTOyHKO/woq0lE5EzNlP8NTqYD6dZgcdeM0RpbYm7N1e8upC77nLVmmCZVpQl9rfDtYVKYfJiI3UtH/1zeaWMKXNxoX60kVmbQKntCBPJsoAV+lJpXZ9TWZcepo7yM2YV8/XZN7JZUs1BPSlPTwrL+HKXtbEg4xOu8f5SXmtxqTmZxz4nAaDbmmC7RY5qJKceTkXax21Cm2XxcEiu7QkK2ioNzQanqavSPW7lTB5lvYHuYDvUKxvi9ephds0BQoHu0+5cIqwaqrCtXXdvrh31YgYXqf2lfrgULv0Ihyc73WvN3kLkVxhpvSUQTfP2Z1e4m7jtREQgb02HeNfb39jsww2l/oiXMQ/KZjmMSS2IAdHOMuiOGOc4FTRb5Yssq/G5qHWvzJK+g3Z1KEV8AGkUWsIxCVcaL4GTbmEhJ68S9D1Giot3RIMoMkAmgjLvxqujS2X7GtNWV8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(6133799003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yFEF0Jyfzy7Iv82SvmTXnuPUHLQDNV/aqRvRCiA2waD/JDie6ByM5DM2LNwOhuXeZDBl++s577Zf89RvTZGhy8N/xLoy07Z5VoQQ0OgeoPiElOJeXSbcO3I5D/1pGN+RO6xTc2+4kvPVJy8B1gDJ5NnZFXMxkFj6x6Inx7D6w+XMuY+9/9UmeoHN6CzPkHp/rmbLq7cbeODp5vs2Ybe0HL/7byLxQwDq9agsAAkmN3m35PKvguHoDXsxQDCXqifD4LSzyhw4bUrNrL+0hFg35Fsujv9s3XdDkSgU6d9Z1s+yzamaF0PRAMFfiCfMRTjtTLmUkroDibbU7kjSvdMDGl65Ckdrk4ioSRUbLkT0kltsSGj7zLpJR/Bnixlc834KzfBgWHrMCT4Botx8Uh2jUuDgOIlv2hdFj7UlaYfP3m6u1QTTnKVnujh90ZeXg68i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 15:49:34.9874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7c275c-eee8-4814-05ad-08dec31a0acc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7957
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

The cleaner shader sysfs path allocates a 16-dword (64 byte) IB but
incorrectly fills (align_mask + 1) dwords. On GFX rings align_mask is
0xff, so the loop wrote 256 dwords into a 64-byte buffer, causing a
kernel page fault.

The IB only needs to be a minimal NOP shell to schedule the job; the
cleaner shader itself is emitted on the ring via emit_cleaner_shader().
Fill 16 dwords to match the allocation.

Fixes: d361ad5d2fc0 ("drm/amdgpu: Add sysfs interface for running cleaner shader")

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index ff5a55f5f3c9..f2c536929446 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1694,7 +1694,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	void *owner;
-	int i, r;
+	int r;
 
 	/* Initialize the scheduler entity */
 	r = drm_sched_entity_init(&entity, DRM_SCHED_PRIORITY_NORMAL,
@@ -1722,9 +1722,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	job->run_cleaner_shader = true;
 
 	ib = &job->ibs[0];
-	for (i = 0; i <= ring->funcs->align_mask; ++i)
-		ib->ptr[i] = ring->funcs->nop;
-	ib->length_dw = ring->funcs->align_mask + 1;
+	memset32(ib->ptr, ring->funcs->nop, 16);
+	ib->length_dw = 16;
 
 	f = amdgpu_job_submit(job);
 
-- 
2.46.0

