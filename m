Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD67EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jul 2023 05:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC8AB10E08D;
	Thu, 13 Jul 2023 05:20:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F029B10E06F
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 05:20:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0u0uE/xHdRuKvwLrSWBiQCjwwW/ncaw8smiNmtSj+ep6JAm1smvoCGnS1ecwp8otTUh5ecV/ZtCZG3AGKmPtEGjIwM/Px5hLpjneHfOlswqMhE4WJ5mMTYU5hzFAsY5hy8/2/gYHZMUo8dtOdIsQNFPoij2ih0G93F+n2CoHlvr/STfFP9sq+D9demWRvtXmFmOIsp5J5qe6GBVcNF9U9QOkFfs0rGN0xn3AOl44nz16qMeMBnMxGgQ+h7LrrKUbqV+tkaae3rAg2NyQvbjE0uZuShJ7mGpJGbsuqLG1vf+sAc3QkbTsLTuON3yKmn5WUhNHVzu4FK60FU782Bhtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zh82juMNr68J1JN5m2x3ZM9oPNjXktMverafGjLhFWI=;
 b=ha8Qv0gy2IDajtsiYN3CrwIIvfZ3Z/QOdVV7Jl+k3/+WoFTcpG/iLgFuXri+MIcf4865WlgSDqW4jT6MYKuZKfSvXdvFpiK3AGvZDJ2PKKzoT+KhhYXdGDBYi20kXUcbqJ/MAemcKjqr+cBuuYWDfSAQI3KHSOHyOoZ1Ez5arjRhyhUQu6+lNWanvznXDwc2hhpoe7UPZgg1C0ZL0EpUQBSNNE2iqhiwwhA0tZ4N1mby65ohNE1JvXC8tBxH+JQqwatmgc8UQNjzPF9cSKgA2193N03QkzXvRNAzH1ZpzxuHFM+TysSpvJlXsb7rKKdw5dMV5G2WXHG7AUJgWYh54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zh82juMNr68J1JN5m2x3ZM9oPNjXktMverafGjLhFWI=;
 b=F1/Ex+UTLVHiniXEbFQ5LdpLqiII0uC5NbuhvA9rn7v7jf1Bf+Lp2h7naUMDjcT44vUDE+3mjByC2qiCn9r2PEoffUTnt30zlRMTt5VIftmWou9ad+gqncy8PgBLnm6u5u8xfH6LaVZTQfJ3wFESLgLtwWDEq4ry1QHNPrpf+dk=
Received: from BYAPR07CA0049.namprd07.prod.outlook.com (2603:10b6:a03:60::26)
 by SN7PR12MB6912.namprd12.prod.outlook.com (2603:10b6:806:26d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 05:20:16 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:60:cafe::72) by BYAPR07CA0049.outlook.office365.com
 (2603:10b6:a03:60::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Thu, 13 Jul 2023 05:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 05:20:15 +0000
Received: from x570-ryzen9-5900x.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Jul 2023 00:20:12 -0500
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <saleemkhan.jamadar@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <marek.olsak@amd.com>, <christian.koenig@amd.com>, <leo.liu@amd.com>,
 <veerabadhran.gopalakrishnan@amd.com>
Subject: [PATCH 1/2] Revert "drm/amdgpu: update kernel vcn ring test"
Date: Thu, 13 Jul 2023 10:49:47 +0530
Message-ID: <20230713051948.3952921-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT025:EE_|SN7PR12MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b29603b-bbc5-4792-2e6e-08db8360d7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6mt4dWI65GStebm/2skIF6IbzOabCJLZ2xVJ5J9jg8NH1RJXVrV8FuHLI0CHgh8FeCKIHzlg3ozHPOKoF36az576kQiOEWbPUNPRiDf9sReUyUUnnutOiIjxLUL/JMUUq2rD4XrZhOQB1M/XoxGCBZWn6ggyhVQ63hYjIJ4W+idBctb6n6gLqkIIek47szeqZjM9aeq8BXDswRNAMjMP58g1+j8N2Vi2aKMuEZ1vHKPP/PaCNPIQ7mv+Vlg2upUUvNvxHJm9vdRrymgWoEaNr61L3ZAlL9DeoBrNK5eS/DXEA7q7vu39NyoJy2AcpDtxWiZzu/th+ONQhz0doUW6gQmDcN2tzplXjWEMyf3p81V0wwoJYu5mgSKGJxug8OYBGKX9iApckUZB6wgzv+oTsMcNCFrlurX7V6PQBdTtegOc3IUQuk13WjVLWRuYlJEnT8tknvcn6bZmzpr1BhNtxwS6qTtFcv5DDgOeNr/Cd9EQn8Iem8tQJbV7M55aRyu6TDn+KULGP4aU5QVWHZaV6aPOniVApqs96VarSkcN0ZaRKC4QPn1wfqxTLQVOZnKWqS1b7OBF9Ykpcfw4C3lOCf8YYeGKnuPH7iWza8JmgAzN7p4hTl6aiPToc/IddvaOVrsMWXOF4d8lvOa72mzeRKZHNUbrq/5CvlvTB/xCG2tU32YR38vFnSaHiE4GV7bWWpiZQiZYCgwDam9QueBQP9NnX4haiuQJ6CgaS+ciwT3CQHyEHnvteJ2VPYETRRnL3hkQdeqMV1KfGC0nFjZQzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(44832011)(4326008)(70206006)(70586007)(316002)(6636002)(2906002)(41300700001)(478600001)(8676002)(8936002)(110136005)(5660300002)(36860700001)(6666004)(7696005)(40460700003)(40480700001)(426003)(1076003)(186003)(16526019)(36756003)(83380400001)(336012)(82310400005)(47076005)(356005)(81166007)(82740400003)(26005)(2616005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 05:20:15.9192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b29603b-bbc5-4792-2e6e-08db8360d7a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6912
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
Cc: sathishkumar.sundararaju@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VCN FW depncencies revert it to unblock others

This reverts commit d0edfbe8bc2d18ede8f805c6eb71c63e0b40c1da.

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 5c2aa925dd79..8966ffb2f4a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -539,7 +539,6 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 				   struct dma_fence **fence)
 {
 	u64 addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
-	uint64_t session_ctx_buf_gaddr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr + 8192);
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *f = NULL;
 	struct amdgpu_job *job;
@@ -553,23 +552,13 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 		goto err;
 
 	ib = &job->ibs[0];
-	ib->length_dw = 0;
-	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.data0, 0);
-	ib->ptr[ib->length_dw++] = lower_32_bits(session_ctx_buf_gaddr);
-	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.data1, 0);
-	ib->ptr[ib->length_dw++] = upper_32_bits(session_ctx_buf_gaddr);
-	/* session ctx buffer cmd */
-	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.cmd, 0);
-	ib->ptr[ib->length_dw++] = 0xa;
-
-	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.data0, 0);
-	ib->ptr[ib->length_dw++] = lower_32_bits(addr);
-	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.data1, 0);
-	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
-	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.cmd, 0);
-	ib->ptr[ib->length_dw++] = 0;
-
-	for (i = ib->length_dw; i < 16; i += 2) {
+	ib->ptr[0] = PACKET0(adev->vcn.internal.data0, 0);
+	ib->ptr[1] = addr;
+	ib->ptr[2] = PACKET0(adev->vcn.internal.data1, 0);
+	ib->ptr[3] = addr >> 32;
+	ib->ptr[4] = PACKET0(adev->vcn.internal.cmd, 0);
+	ib->ptr[5] = 0;
+	for (i = 6; i < 16; i += 2) {
 		ib->ptr[i] = PACKET0(adev->vcn.internal.nop, 0);
 		ib->ptr[i+1] = 0;
 	}
-- 
2.25.1

