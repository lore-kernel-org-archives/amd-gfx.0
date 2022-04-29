Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42EBC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DC2E10F6C3;
	Fri, 29 Apr 2022 17:47:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04FD310F232
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpZfMuF2RbXr2vicgrWSBc2SM4EkfaQ9q42hAvNyJakqq06UsYYdvNt/xL//DVAWVUqPyVdtjGJFr+5cXfeh8TR9MPpJs5Tc/I31GM651enOCJGK8VwGT0mM1IIdJSiftUNLRjGqqIrkOdoEpXm8EFa9n2MzO2l+U84e0pICE4UuxUMmQ8wmbM+gk/bD2r/DMoidbILIUpL01w48ox4U1oQRFR77iccbKGNAF5bomu87SW2hhEasKU+mikaTwmbkxdSo0prRCPQMV23aZ3HXFoWkItWMRSMomd596FYzH86WEXUBuZF2Wzy0GmmHNhdWf7Z5U36vAIG9PzdqLvI0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNR0ffYkCe5ARzJnj0MGUPXx4dkL1USvpHxQIDS2iA8=;
 b=LLekUacUlrYO/es+9vXn9x7ug5tsUz7ciyPrOZWhnJf9hlyPTokYhwOUbJZ15K2PLT1RLBQAOHmr4uxoO/NuxvgXXZbsyzbdKUAF5hL325Dv/FTVw8nXTh/EkKkB4tJNoO5++hqjZDyvohFWbv4TyZ8KF2vZ0xHVVjp+Bg79oZejSJSTLAqHQf8NnUTJIWrcqyAVpyRiIiahEmZpJOfm2F2J0gAtFgHQexMizkr+KC/05U0QjgiizXqocDQAUgI1DlDRX9zmvgbEEAKNQlCSFXFfpPkaLcZz8t74HkhNerLMfkOytKOn3oVOgRthtlUVhFQ+hH8Bb6v3hBB+SfUfcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNR0ffYkCe5ARzJnj0MGUPXx4dkL1USvpHxQIDS2iA8=;
 b=LiS41NYL/7N7kH6HU82E6w5FaQ5HSCEoI1lBQJlvfLGmv7hR6SprrEjMNqQt3RTnRntIDnZ/gk/+X43FHAF7T+Oe4zKkLrcD+AmFEphyhwCqVOp+Bx8hyYSCopactcCRBEggU8hIASVVhkvfboH2HX7IgHN6SDsA9xO8HnKjwuQ=
Received: from DS7PR06CA0015.namprd06.prod.outlook.com (2603:10b6:8:2a::26) by
 DM6PR12MB3193.namprd12.prod.outlook.com (2603:10b6:5:186::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Fri, 29 Apr 2022 17:46:52 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::23) by DS7PR06CA0015.outlook.office365.com
 (2603:10b6:8:2a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/73] drm/amdgpu/sdma: use per-ctx sdma csa address for mes
 sdma queue
Date: Fri, 29 Apr 2022 13:45:35 -0400
Message-ID: <20220429174624.459475-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 951254a6-6197-4492-9617-08da2a083ece
X-MS-TrafficTypeDiagnostic: DM6PR12MB3193:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB319398D5CDD0F521A7CA0F50F7FC9@DM6PR12MB3193.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uW+ID9ewenC7LOSpx4fdMsfwwZYMbGcnpKAZuOCMGcTRlVGp69+5bIuEFG1YmEXv+mEeuF4k24CfOqTjQ2UTW1McOgYkBWLT8QnK29TkI8TPpL28xK15ycMtWFasBOJDQjuEeL0CPmbSE87cvZIIGU7zWJehownTyqWJ6GgCPUs0Z4CDZ9ackGbo+muDvwCOKDtt9f+a0+pooehkBqrhjnUNFVpMuJ8BPJQfCFp8VD1B7T7tvRPTUTvaOq4QDCg8bUV7DRCO9d2AM0c5E5Y0rBF2FysroLpDkOqVDRsXJJQA1UYKe8WF5suvJrKEbEAbqhGnOlU1xNNPpFXfULjN7oMFi+jC8pku4BaQE8vmf0/NyHZgwIByOwyZtiCGeAG9JSn7gzQ4EnBHSjuITGou78ZZadugcAMIyc4fW2S/C7+4mktqDprH0U0Pj66YGAWauyIuhDDcNSYeqSKx0SQFNhMzCQ1E6y6TuaP7U0ricOzSY/oMQXMdUG51hmN+FdwGTbETchLv906xPTVlU9rw4fdWs2d8p6daMWRbvvudH9b66w/U/OHHEViahT3ag7IbagMckdrMLvvgi+3gynWP2WQQntH4qp6c6OIP5clIe0us7z6y+mUxazWo3RNLNMKI9qYaJjolYwfg+raKHOWmRjgd+VE3K08CcGJdMRRmjxSIPfNgJgXByQfgw3T6otqNV3f3yKKUrDgTeMP/sP1pgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400005)(2616005)(26005)(356005)(81166007)(2906002)(7696005)(70586007)(1076003)(8676002)(70206006)(4326008)(6916009)(54906003)(16526019)(36756003)(8936002)(86362001)(508600001)(6666004)(83380400001)(5660300002)(47076005)(40460700003)(336012)(186003)(36860700001)(316002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:52.7240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 951254a6-6197-4492-9617-08da2a083ece
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3193
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Use per context sdma csa address for mes sdma queue.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index e1835fd4b237..8e221a1ba937 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -74,14 +74,22 @@ uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev) || vmid == 0 || !amdgpu_mcbp)
 		return 0;
 
-	r = amdgpu_sdma_get_index_from_ring(ring, &index);
-
-	if (r || index > 31)
-		csa_mc_addr = 0;
-	else
-		csa_mc_addr = amdgpu_csa_vaddr(adev) +
-			AMDGPU_CSA_SDMA_OFFSET +
-			index * AMDGPU_CSA_SDMA_SIZE;
+	if (ring->is_mes_queue) {
+		uint32_t offset = 0;
+
+		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
+				  sdma[ring->idx].sdma_meta_data);
+		csa_mc_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+	} else {
+		r = amdgpu_sdma_get_index_from_ring(ring, &index);
+
+		if (r || index > 31)
+			csa_mc_addr = 0;
+		else
+			csa_mc_addr = amdgpu_csa_vaddr(adev) +
+				AMDGPU_CSA_SDMA_OFFSET +
+				index * AMDGPU_CSA_SDMA_SIZE;
+	}
 
 	return csa_mc_addr;
 }
-- 
2.35.1

