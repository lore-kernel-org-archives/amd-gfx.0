Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09441606A32A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UP0jDI1o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3AE110E261;
	Mon,  9 Nov 2026 14:57:46 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011070.outbound.protection.outlook.com [40.107.208.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39AEC10E390
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 14:57:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRwDXJSJzb/7qFD4ZtBaQfgGWWwmjyw2xVtuCRpwkWeM3Bighzyl8bm+Qkr5lrHG74vWphMCBBWjplOOorAtVV77vqir/BGoAKIMZIGU2uEdt+X8Nzi9LXRzlxx2PVQa0u+WceC9wRuetZlQWx3qdKzhbYgVFSsovIr6RWKL66LcXpQ1ja/PSbs06T5hBXzvkd2/2ISfNzcHLSgX6EcqHCQQFIETc+Uf40i2iov04iw16xYZR+z65VGuVc+TURvHcOqI9oVF+XKAYGRYM6fhCsroJKuxU8cKLLxhf97m8YqpM5JmxzMhew9bqacp2Xp8A6yHXd0P0OO9a8qAeA4K5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxKGwBTfTDhKLO+w1c4oECHZzDIpxwTsLG7J9VEKCdk=;
 b=mgOCJTRiol9qwBqJJP5k8+FE9hzb0JZH1Nl/FAndznCj6TilfPN0lDhFHhwXS6kb2mHS7fIuXE2tvk4r8aznz4Ku7mT1ElQmmM+CTRiW7I8p3G6/cfLkt19/jRCUsWixxXGLo+8TKXvAdbFPG8gxFD4Wwfvm7/ts43BQCh64A8sJiZkT2Dd1GsqgoalaFz0QLVUY+y+CnEl5lggKOy6qTuy6InXCWvlKSen893e8DMsCUE+WPpnt1MPeeyAiQhJJDyCyYCk2uFhcWNpAmQvsSINLMgMiym9IbVw+ADRmdEzPAQ25RfT3FFdG8AvaBlbG8U+RQJlYKz7F+8IaUXQE9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxKGwBTfTDhKLO+w1c4oECHZzDIpxwTsLG7J9VEKCdk=;
 b=UP0jDI1on5rucLFTbhnL2Wx7Nwi189+b0WgK4v0XP/YdAS+tTc5kN7Bx1qbEqR0SpffzY4lYXSwxA4a3uraeqnYisoshLUOXFiXpCzn+IV0zHyf87eyzQ/3gP9EiZzxe+MFOUds8BaDyyrU/eXlJ2/RDxhkpEQ78thdDb2Vx0kY=
Received: from SJ0PR03CA0196.namprd03.prod.outlook.com (2603:10b6:a03:2ef::21)
 by MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:208::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 14:57:35 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::51) by SJ0PR03CA0196.outlook.office365.com
 (2603:10b6:a03:2ef::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Mon, 9
 Nov 2026 14:57:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 14:57:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 08:57:34 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 08:57:34 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 08:57:33 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Sunil Khatri <sunil.khatri@amd.com>, Benjamin Cheng
 <benjamin.cheng@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu/gem: use dma_resv_add_fence directly
Date: Mon, 9 Nov 2026 09:57:18 -0500
Message-ID: <20261109145718.91381-2-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109145718.91381-1-benjamin.cheng@amd.com>
References: <20261014022107.2511834-1-benjamin.cheng@amd.com>
 <20261109145718.91381-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|MW4PR12MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 57933e38-656b-4940-cc30-08df3e71c9d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|10067099003|4143699003|11063799006|261102123227099003|261021123027099003|56012099006|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: dlERdYJxpkmgVhbhQ0P1aZLJjRU/gHhPDnHPZtqZ9eEMnWX2gT+yrIjif3CJV2+ZJIAqzLiddYkpY5Q8xbetpeRVNrJGub/0a3H0JPspe9b79YT/uYEeNjMo9a36R3EhGNsQwT8Wvi/66p2o4X7nl36GRgOJ7VyDrj+4jvJe/J5PgELLZQhvc9jMt92Cq/o3nR1NAtY22KJhcLpQFSTNWdwsze2Gn2fH735r2aXxjpjD2/HV5RJAyqxO32FLOdtpqGyfs+EOA8b04bQY5QPsES8Uw87telu3zNCZKSHPldiO7zQ7346uC0fNFGIpsM2lLU1yYt+X83M3keMjUBiKFBc0ByDsleruQ/aHDvthx4fVMyrzvXphz8/Rn7KatcYYhVsEvn82KG0jXQF5UAXluBA/hcmKctjhhQ1fYfQrphOP7LTUFpfGaVLUDVe7bpcPT82dBuk6GGnSQVPWofASxHbjmNO/q4zew1I0jEqD307zJSvrT2zmt+DJi/3mISV2GXqanztTYLNsdyKnnzqN4mOguy142MwfZqwpO9eqb5As9Raf0jZMAkxqVpaAoAmvWH1NumuLelpwQ+PW/0Tqt85dbd66C0aSwPPozpafaEbgdOLqwUfep96GZRX/oh6isDwJK5HXmxiSObrYJwFraz0hiD5UckYYkaV2YDdf8lEo4oPHm1W7LUp9Eh9qP+6r7zcXBoCIZOudqlTdtlL5Fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(261102123227099003)(261021123027099003)(56012099006)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zuCmwJztgxVWcNv344jcm2ihOnMrJ8DdziyUKc9ogqISCBbo3Bt/J86oxzWuiGbqJtPbbT+uKWONuInLwT8ymgo2EYTcs6EU9VBJaXoLrDwFVACW1/A6WjO27P/pKy5Jn/p9JMgJK01zb2/77RU0hANcprJvhj9bOC08ILK2ikAjfflb2BU37P6sTRQYiUMGKVI5HPsI0RS9TNRV8xvlFGqQ5AtHutmJSAn+ALNas6NVs7tGqFZcoct8TGampIRcNBRCEbieOgpoJyGhjiVOIcOCU5IqOajWV5PEA90plhLh2cdG7u1kE9+Z00ZGesTX2meSPs9MSQs0vuorOKLtAx0FyIuhdWffZH3tahbB7mfIYaIMKrhnVIpuG5N1R1cc/Ukp+l3wZILzfPNlDg2X1OrclyDzygKQspiL0gKZGWvlbhLPZ5qQD0rXOTFOFNHt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 14:57:34.6926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57933e38-656b-4940-cc30-08df3e71c9d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Christian pointed out that amdgpu_bo_fence() is deprecated since it
reserves fence slots there outside of the lock. Replace it with a direct
dma_resv_add_fence call here (we reserve the correct amount of fences
already). Also switch it to use the BOOKKEEP usage since these are both
kernel-internal fences.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index c9a84257ae5f..eebba3bea089 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -373,11 +373,11 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 	if (r || !fence)
 		goto out_tlb;
 
-	amdgpu_bo_fence(bo, fence, true);
+	dma_resv_add_fence(bo->tbo.base.resv, fence, DMA_RESV_USAGE_BOOKKEEP);
 	dma_fence_put(fence);
 
 out_tlb:
-	amdgpu_bo_fence(bo, vm->last_tlb_inv, true);
+	dma_resv_add_fence(bo->tbo.base.resv, vm->last_tlb_inv, DMA_RESV_USAGE_BOOKKEEP);
 
 out_unlock:
 	if (r && !drm_dev_is_unplugged(adev_to_drm(adev)))
-- 
2.56.0

