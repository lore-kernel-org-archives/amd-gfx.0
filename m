Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536C6C88E4D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B778910F6AF;
	Fri, 11 Sep 2026 17:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G/Rf2sgp";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 255CD10F6AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8rvQZ3GJm90GZNS8ECNJrrdYAd1qJJsrBnkvkgg2r2jSQDjCB3VDUqRm3NNQ1BHiTWXtIP9Uul8jJyYNvylqtqhmgK3F4YOelsnH+LZm1H+VuUuFxSvUhLLJ3wRAD9NixA88FziGKOKHnr8CRTuJ3v7uGhLOVAJnSC6G/1Zrei3kB0gilHNiRanGh1lDCe/8eOOpfmRhSRkuJcsrml9OuzN7hIa18r084sNpw9GhyMiITnDVZ0GiY+SA5xXmIDxsSddzUu7+31iREvipuUXpDIMlqZ2bsvI6D3pD/FHOaQY2Bvl8kUwkXXZpqcjWhEEZu1XWR/mM28bcjCyML8V3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+C7bXFSoPvcd3OHKqDCjoBKMQVV/HvsvgrJs/JAMMA=;
 b=zMN8Jb+5RqL0aR9j/CvWJBEbTd8iZWGDvQnVUBXpQeT3BCHa/yo7pIKueESXVxkeGXw+lfCwC/Gfs2QdzKSmbuJBTzrzK1kOB/bVas/TYx21ZzUrMUvyIrjtGv3P2GxrUNjukv7I+v1YZ+u/BiUBErif6uaI2mBPDOOJLLlT0bs2IK9oEKTcAvwkIe2krcR4+weH2gm7qyNUi+dZ4fuQscHZ9LO6qebVc3H2u/paKaMI0DZyxXJgU45NvBkRdqW13TLs6RZDmRn7IRVcn8+7YeLsO9wbJpHpXHhjwr7osO1QpkD6Ll+3FfWk0l5aqXywk8alHX8qXsCPJT5BeCcKOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+C7bXFSoPvcd3OHKqDCjoBKMQVV/HvsvgrJs/JAMMA=;
 b=G/Rf2sgpYie16nkN+aoj4vv7mXV6jE4kflAp4Ak9zck7/buHkmAjVBEkCNrL3Q5nWVP8ZHD0y7oMemC8mQfu4xbAO4QaF3lcwJFeZrfA8+0o1C0oNl0XL7hS9NRliH0r+5RXyxvZEH1TVf+rwU9RX4HlYn5CakusneAcVIJEJPA=
Received: from CH0PR03CA0195.namprd03.prod.outlook.com (2603:10b6:610:e4::20)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 17:56:19 +0000
Received: from BN2PEPF0000A7FF.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::10) by CH0PR03CA0195.outlook.office365.com
 (2603:10b6:610:e4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 17:56:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A7FF.mail.protection.outlook.com (10.167.245.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:17 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:56:05 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:56:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 19/23] drm/amdgpu/gmc11: use SDMA for gart TLB invalidation
Date: Fri, 11 Sep 2026 13:55:40 -0400
Message-ID: <20260911175544.1314467-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FF:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0de61d-cb88-4b06-a708-08df102dfaf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: popadoev2UpT6cOEUBAY4SX39Z6Ie13t0tGcWx/QcM/eJGNmYWyXMcvRZWrNZwg3BCtYk9/4kQ6TvCYl7l8qGxCyL8gscOFnMt4OC6GWpaPAFfknDMl44Ks20V04sfNBLN49pJaU2XU5p307ayq3RKTGtsaD127D3QHe7ssd3ohvtYgQ7APIF3jG6NdwxRyRc9BQMDACT/WCgKox2SZx6jWE2lby/JmdESwEF9a0P6GYvVB+5dGija312p6C+CZD+ZNrnWkGhztBU05g4XJBoiGyPJUgWlzMrf4xVfinQXNL1isYeZwpThZuysh0MczRDVacy973WAgqTr/skkYzMiDyAIlo/eqB5uFQEUs9R46zx5U22mNl614Dxrqzxt+zYdfuwshZP/gdOJ+5SI6Scf/1TzHYuBkfmjh6NeivSYOmJgC1rq2JjENQ7E3vF8s/7NMNG/KFFQ9euczhuRuE2Okl9D1MOOiRrdJ/adJjdz5qsoSWVOFuuB7Q8gq3I+pEJBvuVfUg3rUN0ZSsiXa99iMan3jRKMUvrF1iKejFSJf0YurFKXb77GEbv4l5rwy7femVMUM19/5h/RQ+Wt04an0xfa8z34qhiXaxkhzaDsswnJN3wh0H0j3A4qcn2gldfO//uHrIQh0C97PiMyYMEI9YeHR/a27EfONWMgAY4V/3y04cfn4K+/n4Zfu+VpBxsn3bnmJdKLjMXvF2UPZboQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /862QZ7BcuhdOrfX91sBgsD2Zp1zCPUTkSXIblweWu1Lp9nKWW+w/g5oPlilV4cKC7Gu+uRJMVwDV6zaqznUgqh328QJKs496k2gLfoHlCGvArXjIge8vtuRlSky5IpVRDv4Om2tjuY4uyflNJl099Xx06x+MEkT9qI0ti0Gr0hHUPXBE8gP0a/UuDPF4DVPDcymKmuESuAf8TYxxKChynar9wAD+P/mCrWslJh3ZsGDkcVjWXfmBZjJ6iXtEzXCK8eDXlpI1HYMn5EdEKLnCj10/ox4eOONvymvEO+/+yt2ZwNLh1QsYGibS8vTMDHdQs2mYH60hDU+/GUGJBhvbFq/wJVCnlnAPlkFFbd4isu0vcAphIEeEL9OrQn6oSg6pvKdVTlE2xZn3I/qSaZXpqbiEu5bezvR3YdeSSltnpeYSmDdoCNLC1PYxDAL6kyz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:17.9452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0de61d-cb88-4b06-a708-08df102dfaf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
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

Use SDMA rather than MES/MMIO.  This is recommended by
the hubs team and aligns with what other OSes do.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 43a9bb6305564..fa80132c8418e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -761,6 +761,7 @@ static int gmc_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	adev->gmc.flush_pasid_uses_kiq = !amdgpu_emu_mode;
 	if (adev->gmc.flush_pasid_uses_kiq)
 		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_KIQ;
+	adev->gmc.gart_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 
 	/* The sequence of these two function calls matters.*/
 	gmc_v11_0_init_golden_registers(adev);
-- 
2.55.0

