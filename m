Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1905E606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eP7LokXG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72D6210EAC9;
	Mon, 19 Oct 2026 19:07:25 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9867D10EA94
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 19:07:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbIOuVj3OxdyX7r3B2ub6PKOVcSgER5JC9oWoz24XRJYmEN2M4O56zDD/bhQ9l50O3yi333qgQYsdei9sciOWdUNy6UAo95yEHm9wlnoCT/GhzXcHcvI9YAYfHVXAWxC3bRkLo6I1D9lG2VICj4XJpdaXth4MEcOKnu8oZoQgVMVPWAZpwCZ3snKot27D/iELdukpxOw0ocvWicSbZqy/wg0Wq6AlaDaiY1qi3yVym/6VN4PzkhLqFgsO3zaLJDhIOWzB/pVXjRA3BRKOyXCYOiYpEqxgH3ii3O2eFx/xx0Kzt1BCUwRZVnuMRfHVSubKISjIIkxWKnXIORArDhGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8jwlK2YMJF1N902C7VZdXBJqVYzLFnWgGA1C/QhMOA=;
 b=TiQd4DB58oyUZjkTnqsDH/K/znj/r2NioFqgSe26DWJA7BpqekXsOj688IY3d1XcvIoMeDjtNpYs7bdLWfND8I/qIXojbJFlJs3UHci0r/clpkgkMr9fE4Jl9P50TT8dF9rmSjdrsDiIG3urPqBlEkQ9K/QdtHzdEJDcfFQZeBHJGUxKvPtx3vB7kn8Egrrv6S5XnOiTSmC7E/O6gx8hpjNmMRyOwa89zw2lQm0IMN3YaxVj+qCeQLnFyYfpaOzHVFqsAuu1aiSzJZ0n7hXn2joDNLdx/X5PR6ovylGvr1SuYMwFzfJ08qdDgfn4yHN1kVK3lkiCqBZvH4JgukPgBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8jwlK2YMJF1N902C7VZdXBJqVYzLFnWgGA1C/QhMOA=;
 b=eP7LokXGz1oqLIWDtS1kXhp1hDOX7pu9uYum2xtKeKz3mv3Iv2ctRQ5N4iw49JAr/0tg/jrBMg+7zxHMgaJFW9paOzDKvZXcITxwFts5byEAvcVJ6zGR7jdQVzdUInnzOvYQMHt6+5bHlJ9TxgjcOArOYb35vxsmfU11SS7uIj8=
Received: from CH2PR15CA0004.namprd15.prod.outlook.com (2603:10b6:610:51::14)
 by PH8PR12MB999271.namprd12.prod.outlook.com (2603:10b6:510:409::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 19:07:11 +0000
Received: from BL2PEPF000352D1.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::4c) by CH2PR15CA0004.outlook.office365.com
 (2603:10b6:610:51::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 19:07:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL2PEPF000352D1.mail.protection.outlook.com (10.167.249.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 19:07:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 14:07:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 14:07:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/5] drm/amdgpu/sdma7.1: don't access registers in MQD setup
Date: Mon, 19 Oct 2026 15:06:59 -0400
Message-ID: <20261019190659.2773961-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019190659.2773961-1-alexander.deucher@amd.com>
References: <20261019190659.2773961-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D1:EE_|PH8PR12MB999271:EE_
X-MS-Office365-Filtering-Correlation-Id: 849eb36a-8746-410c-b6de-08df2e142d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5TAw5DS1RlcKIYFjejmE2qOhfSwuCYOBbOprZTqs2scxhSqWTz4eAYp/Iu5HtWAa2I3X7aJEMhu1ytlje8DbKXgTNbYCHv2ZHOBAIWxrvCBGtVcx5dOMRcaoB8dMgFh9Hm8JRjk//BPP5y0bfM6L4Qh5yesS/xKYls2bZNZdMc8AFD1rQUBVknA8eKyTZdDqnkwrnMWpQCq3UpIe5dBS8pRgnpidau9ZmpMROkpjZ1uxgdcyQsas3e7tyIadDrA7wMqaIXpOjMrc9pJZppu8nVKdiWz/9XTCHR8X2fFYH7a9o3m/3Jb6O8fdTh2/8pq9IQ2WPtDE5qXdIBJMvU5R8MXpp7BJCr3j0fj9NG5bHPOKQ66yjvZGIdtFebNieVWq2/cL5l08cteAojCjO7aJP9PwOWDlilh1FiRYj1JPZ1XI5wMv8rFT/B6Ys6wzHEhQACtmyGSw5owMd5/bvXgtuvlvj4YG/4lNJIMJtacjh7Ue/pTXDwzJsLZyDR2XvDXUJzAs6daLFFw4pQxHmmLbVezwNoziIIWKWjc/097cfnPDPBKZdTpz7VlXhkOf7r5CoTdfd67H3l/2AAOIrPs9ppSNyfDVFSDoDcSZOxWr9AAsYTqyOLXfAS72DwtMcvAQOPOBTh/FVQhkufcVy6T7PGWcvooXyH8xjl3CKb7RDkUys5JtiG8GXqKZjxDqUPXUABlcYBrgNDRLEQmOLf+zxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2MYlto1H5c7HI0epkrFvFMnwTSGPyHxedJJTDtD8CgjSPLzuK5HlwWypaRyzXpTfEfXrz7mCiU8FxkG4KQNMzI6vAF4PFxbZiHWc78gHJYps6hwD8BS+pONQxpyQm80v1TawrkbGX3IzY9l7IaUQQOmRAgOsL0rkBCPYd7G46YtNy0NGiXlOvRCsqQyq5lTi1P9FwZOmCf0HnKXCoLCK0+jJnSAnCj91JTJWjjAx/vaYlVqukU4XzcOBXeQ1pTdd2RIFKVIcF2k10eLM69jETlzJo23e0/LA80Uc62LaU8tBIVF+96BTDXne32Lj4ocFJqTSx17FqjtDpQbRMuZUqQuhX4uOG2x5IzzmhdtvgHHlVrr6RY4CzTO8rsrZUyUyvgyCF3hMSaXJiWbMzgNW+5cqpAg5uzar3xtSKL7a0wFqV1kuKlAGxq8GPWb9eY8r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 19:07:10.6707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 849eb36a-8746-410c-b6de-08df2e142d7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2PEPF000352D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB999271
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

No need to read the register state from the hardware, just
program the settings explicitly.  This could also cause
problems when gfx is powered off.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 73c60d928fa85..ed2928b26a0ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -860,6 +860,7 @@ static int sdma_v7_1_mqd_init(struct amdgpu_device *adev, void *mqd,
 {
 	struct v12_1_sdma_mqd *m = mqd;
 	uint64_t wb_gpu_addr;
+	u32 tmp;
 
 	m->sdmax_queuen_rb_cntl =
 		order_base_2(prop->queue_size / 4) << SDMA0_SDMA_QUEUE0_RB_CNTL__RB_SIZE__SHIFT |
@@ -878,8 +879,9 @@ static int sdma_v7_1_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_queuen_rb_rptr_addr_lo = lower_32_bits(wb_gpu_addr);
 	m->sdmax_queuen_rb_rptr_addr_hi = upper_32_bits(wb_gpu_addr);
 
-	m->sdmax_queuen_ib_cntl = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, 0,
-							regSDMA0_SDMA_QUEUE0_IB_CNTL));
+	tmp = REG_SET_FIELD(0, SDMA0_SDMA_QUEUE0_IB_CNTL, IB_ENABLE, 1);
+	tmp = REG_SET_FIELD(tmp, SDMA0_SDMA_QUEUE0_IB_CNTL, SWITCH_INSIDE_IB, 1);
+	m->sdmax_queuen_ib_cntl = tmp;
 
 	m->sdmax_queuen_doorbell_offset =
 		prop->doorbell_index << SDMA0_SDMA_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
-- 
2.56.0

