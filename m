Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6E1606A31B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RDmI1TU4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AA75112A31;
	Fri, 23 Oct 2026 08:34:52 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD6D8112A28
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 08:34:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7Bcqm+R5FSmVWXlAFOHCfMDqtjw5Zr26Ds/g95WwvPPai7EiijzgM/s8hgrSNRpAav14Tr+7yvXkevciMJIcw2noMymco99m6eAjjCkdXYUHUMCkPPpo69cjtQJ7AnuSgZUcDTXDGcPZLrGwnXu10gWulsYLvbBCbpsZa7tH1+TQJnRA/zs8UK5xGEo6xZSHrVhG2I7fMg8wbZC8XkBw++2RL51WoQlEX4+hCctzRWX8W2Nd17sGwMdASvrX7P+lbGRSxLJQzMWhfNWdv4tWt2xrYTU4o7jR05ii9yKjd3Xsg4q1KjFmz14sIF1ha5G1otgmheUM+h+PY8TOB3i0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlWCyJq87pzo6fHkSAmjcGT0yaQykH1U8XWwDsmjhbc=;
 b=QNfvRYkTUW1z5XGciGucdyKUblQr7V+HZXECL8QYnWSijyA3ujWUtwyWvlkjhyY8CMCg5V8VGJ47/sJaZFuihPXjMVwjXnwNoS6Jztxqc0VLvePYWu+1GQzpf9J7MXPCBOsYHAgjYzM3XkCymoUJ1vcPY1Cv/h/vvC126QdrUdh3DkhjT2J6zrrzzAIYvCdQjPE+xc8ziqOhLa/ci4fXmMFXtgTt76Qg6Ale0TFLlApU9hwRS7LjMa+W2JfkhJK9rfpb3uLmjlR/1ZBNuiqNtc67B/QOEyHrUjjQYQeu02qZ1Inhzlodb6GtmT+dYl4tFDiYq6307dLamz2D9gjtvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlWCyJq87pzo6fHkSAmjcGT0yaQykH1U8XWwDsmjhbc=;
 b=RDmI1TU4WDUg/L5xw9ztLVhWa5iUQED4qqJ9tg8A62qj0OFJ1IMXf7q486O5fFSDIZ3r71HBqClu+NM9fnynLNRebdvEthj/C/eO5pzkBUAWjl2T6o2s6mzkTU4VCc/Y7a8Kq/Q5vI0OYk6U4pXS/LIwCO9CdFd2qjSAuZ2Lm+w=
Received: from BY3PR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:254::10)
 by MW4PR12MB8612.namprd12.prod.outlook.com (2603:10b6:303:1ec::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 08:34:40 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::30) by BY3PR05CA0005.outlook.office365.com
 (2603:10b6:a03:254::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.3 via Frontend Transport; Fri, 23
 Oct 2026 08:34:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 08:34:40 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 03:34:38 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 4/8] drm/amdgpu/vce: don't allocate a scheduler fence in the
 direct IB test
Date: Fri, 23 Oct 2026 16:34:18 +0800
Message-ID: <20261023083422.3049246-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023083422.3049246-1-Prike.Liang@amd.com>
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|MW4PR12MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: ac32988d-b4a0-45c9-bbb9-08df30e07b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|18002099003|22082099003|261022105027099003|261022075727099003|11063799006|261009221227099003|261009223027099003|261009220027099003|261009221727099003|261021123027099003|10067099003|261021121427099003|261009223327099003|56012099006;
X-Microsoft-Antispam-Message-Info: S66ocRPnMEcKl4wJaWgFMYy+0qpydZU+XiRsO+mNS+FpUU4azYKWs0dGqmsnzzj58eWaEkT/5CKuuDbEfoiyyAoORTTDVOXcs3WqwnNFPLOmXhA7noQhDYefTuKsZcXNWATwytcBiQQZuVxuYq/HO+wbY+FIDRtgrA7nBbQh5OAzPa+udDSTqyF5CBXaPgIp2XmhprWczk0fh5KYYeN9UB7tJumRshtzxraL60/x3kHOjvzjcoPdqo5ll18xSx1TlIMWE4nirl1efoaT9VD89YfsEiPoRmGT/9gySsrdeqR/DJ9x3n6rhp3zwxu1H/SqIjN+7LdClL/wY+4+TTbUtPktZaUwd9OW+l7kbqcZiWV97S/3/yi6S2uIF37KDgOtd0fVixWj1XGPhFHeihK39sgKtd+eQv8dlAE3WHXGcPQOSg6Z35X1ilvS15lDXtzSI1tFdf8r8uY1CC6a+wCwZRy/BAXX0DefZURSpFd1pGvjoS03cP62IcszGXoFSK7dGNUad3xuYHUp1yzQC1vjeltzgsk8vB1uVmdYrKuK/c66993KQLtJt8jXvudezMofdv/+ntL1ge/IjIAjFR7Ng5rU62VKA8MXY4JlK/LMO1L5+KinIDRn4CnVniq1q21LeXOdOu6iK6k1ahTXzVIl+bCgFCcr/51mOyLBhA1oHLx3qgJM34ilS4suFhoE2Ye4PhWzQBvm4JCIe4q3SI5HEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(261022105027099003)(261022075727099003)(11063799006)(261009221227099003)(261009223027099003)(261009220027099003)(261009221727099003)(261021123027099003)(10067099003)(261021121427099003)(261009223327099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L2h6tUNxZx2+PgWhgcw+wSZ91HnNB6YGmLqDhkkwNKreXjlo59BlECokbBVHVHLo5ZAblHpLLGKCq3ABDzoGK/oLmK5QyPdZHM/PQE7bSawP4NuBFWRu5mvQ3g3iCwlVAta5mg+xpV1jEJcBVoeXER/WV78bfhKmIQtUBvJykYiMSbeZ6wWfMKwbHYpR/eqO4I/29gJDA6W5DVFWnhcYB2j0tuv4Sq+F1FB+dBraPy9Gq90hRXjXl2I73/rR5wjitqchnu2oLXTe71uIhDdj3KjWAbR47kQMgqNtGHj4CGh8UXsLt5ExoDjH6e28ZYrJFLlG3vuzOi5OwGgApS3WSojugRmznlbYhDlWm1ZYm8rpWdHNYbxG10rcmLzWd1vc8LXOYiW9TRL+tB/VQi91ovoyTyhZW3h3PUPjuq1y77lBjxWT4PgKH0KmXbK6OK8n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 08:34:40.5310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac32988d-b4a0-45c9-bbb9-08df30e07b22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8612
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

The IB tests run inside GPU recovery, which must not allocate memory with
reclaim. The direct IB pool and the job allocation use GFP_ATOMIC for
this reason.

amdgpu_vce_get_create_msg() and amdgpu_vce_get_destroy_msg() still pass
the VCE scheduler entity for direct submissions, so drm_sched_job_init()
allocates a scheduler fence with GFP_KERNEL that the direct submission
never uses.

The create message is always submitted directly, so don't pass the entity
there. The destroy message also goes through the scheduler when the
handles of a closed file are freed, so only pass the entity for those
scheduled submissions.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 1f7a98cdce5a..4c049e591f7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -470,7 +470,7 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, &ring->adev->vce.entity,
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
 				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
@@ -561,7 +561,8 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 	struct dma_fence *f = NULL;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, &ring->adev->vce.entity,
+	r = amdgpu_job_alloc_with_ib(ring->adev,
+				     direct ? NULL : &ring->adev->vce.entity,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     ib_size_dw * 4,
 				     direct ? AMDGPU_IB_POOL_DIRECT :
-- 
2.34.1

