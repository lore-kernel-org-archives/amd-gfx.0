Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7F4C6FD1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Mar 2023 17:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAD2410E3F7;
	Fri, 17 Mar 2023 17:18:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D44AA10E116
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 17:18:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuRhnHlGvJwuEvs7H+O9jUzc9YMvfo+nXVhGCerB2JlFagpL8gewKtw5nWy247zX6Y8dqEFw2odfGej7P/TkYfWmjj9v5AG9zBkNWHbfWjsKty+DaABW/edVwRmFzXddM/VMmiY6T4BUrsMjlgL2PzLkWiGB/+rNIX2Tr2jdSwlFz82w+QC/0zLfd7KQkljAspiBXqSClD1GMMZzRiX6jyJ7eapqj+Br90djop2CiqsjTxDQR/X6MZBV3hw5r75D2dWhmyzFsT1AXMxAWsbabmeZQdRAQFB1iOunoYo57Gp6ehjCz/CalkLyM+ixkJAzcEJoaBqbhtt5Xt+OGTzTog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5PLkD5UMQSG29ZF6+yEFtcI/16XQ+a/xyKL9XOvsCk=;
 b=QH07FGsarezifTRzk+HvV/6OH7Y/cBJkjGGwDq9LyekScyWtlWzWP8rvewBUZ2dyrj0/8qNNKlp3LKDhSROqphY4LmMHSbqSGmf6/Z0MlHkFOmMpW+luvcD6KpWqZ/2hWiAGSr3/SkdDv/5HVx7CtmRrbeA5NyP3ehMJirQ01nwbBuCP6yHBcI6rdceacEf3Mn06cTmTtLv0EVxXxcczsCTRxDwkCj4/jzBV1w+qxb7hjP4UjP0qyk2fim9fGZqkcMVmKa7FReu8UwrBhOhuNTbe+H/S90xZ7/tfyVOedUZJ79tlriDibQH8hpX9fyKKBCyZOqi6RFX+XP55SvzUtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5PLkD5UMQSG29ZF6+yEFtcI/16XQ+a/xyKL9XOvsCk=;
 b=KSF5TI/K9Rgz7ieY+H7w2BM7CEZObMSz7z+h/LPjjk2F++e2JKJFngriWCLWLuDH4hLsVNiAVGGHVccWSBXz5AspKN7iJMgIyi/unia9NEeyVn5Z924PW2dIXlRlSQgCydWPFDkZNE/EkLpuMUgIm7D1hzWlr06LxuX88SKFCkk=
Received: from DM6PR08CA0014.namprd08.prod.outlook.com (2603:10b6:5:80::27) by
 IA1PR12MB7664.namprd12.prod.outlook.com (2603:10b6:208:423::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Fri, 17 Mar 2023 17:18:08 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::bb) by DM6PR08CA0014.outlook.office365.com
 (2603:10b6:5:80::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Fri, 17 Mar 2023 17:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.16 via Frontend Transport; Fri, 17 Mar 2023 17:18:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 12:18:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/10] drm/amdgpu/gfx11: make job optional in emit_gfx_shadow
Date: Fri, 17 Mar 2023 13:17:43 -0400
Message-ID: <20230317171748.682691-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317171748.682691-1-alexander.deucher@amd.com>
References: <20230317171748.682691-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|IA1PR12MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b067367-7a70-4e65-2bb1-08db270b9408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wGZ6gtXm6xh35qNYR1VcywrxVivNcAVRISh4HOcDQF8TwkMDYZcqRWItzGsNy7iiFimPfvzpfq+voUI0HmJAJ2p3OPmxtqCfjrSqNkF1qjGdVXpYOwarhoicbCubEONJUsfmU4xNpjb7gPdsOzBuRT+wRFj/yu1JBOe81amSQTY3B+q44BbLHxUFiKNwvI0H5nf62Vja4Gqp0/E+FGYRHlLY4XrvqQJeIvkC7roP+XqeoDc92AtJqGstUqMZpgqxAgnqQja8gLz71ujuVCgagOlBHv9vNUa49ay2v0FZ5ikui0YYsZ5aklFhK/VYSwRQqR9z05D1juEfPU17+EDgIR2b+Bf/zWTL4937eBw3Bxu1czrGFYYmfMK9Cyqy9HvIewzosyHZFIxtk1Flznj+VjAF3ggA3KTBwvB+T8FZozRv+R9cu/AO3IbJeSYp9VjEFwuCM+I1CAiz9UVAKYDYXi5CDqY0idH5EucvaagMnAA4MRza7ZE9bfKbPvAQu5rbU+Jof1T9WYlgWUcfJxN+s6RoxECR0NE5RMsYMzBlntqb29oZO0L/DzK5ZQHu2HDOjtC9OimO/qBNCOoH6AfFPMbqUAouaWosZphN8OTuIJVhR9RwbthhtQ/C4toh08j3G2yTBzXcifobgBWHbo+RxgCMuPxMMEXO+hLTpdLwCcVR74zvj0pFXnJbWqfDn7KxMEzZ7V2o3bRYEsq64yvMA46erDYNqjNOAzAVRe1SfKs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(4326008)(82310400005)(8936002)(82740400003)(70586007)(41300700001)(40460700003)(478600001)(70206006)(36756003)(356005)(40480700001)(86362001)(6916009)(36860700001)(81166007)(2906002)(186003)(1076003)(316002)(26005)(7696005)(8676002)(16526019)(6666004)(83380400001)(5660300002)(336012)(47076005)(426003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 17:18:08.3962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b067367-7a70-4e65-2bb1-08db270b9408
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7664
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need to emit this packet any time we emit an IB, not
just when we have a job.  When no job is present just
send all 0's to reset to the legacy state.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 34 +++++++++++++++++---------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 166a3f640042..0a507b7939f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5594,17 +5594,29 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
 	if (!adev->gfx.cp_gfx_shadow)
 		return;
 
-	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_Q_PREEMPTION_MODE, 7));
-	amdgpu_ring_write(ring, lower_32_bits(job->shadow_va));
-	amdgpu_ring_write(ring, upper_32_bits(job->shadow_va));
-	amdgpu_ring_write(ring, lower_32_bits(job->gds_va));
-	amdgpu_ring_write(ring, upper_32_bits(job->gds_va));
-	amdgpu_ring_write(ring, lower_32_bits(job->csa_va));
-	amdgpu_ring_write(ring, upper_32_bits(job->csa_va));
-	amdgpu_ring_write(ring, job->shadow_va ?
-			  PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(vmid) : 0);
-	amdgpu_ring_write(ring, job->init_shadow ?
-			  PACKET3_SET_Q_PREEMPTION_MODE_INIT_SHADOW_MEM : 0);
+	if (job) {
+		amdgpu_ring_write(ring, PACKET3(PACKET3_SET_Q_PREEMPTION_MODE, 7));
+		amdgpu_ring_write(ring, lower_32_bits(job->shadow_va));
+		amdgpu_ring_write(ring, upper_32_bits(job->shadow_va));
+		amdgpu_ring_write(ring, lower_32_bits(job->gds_va));
+		amdgpu_ring_write(ring, upper_32_bits(job->gds_va));
+		amdgpu_ring_write(ring, lower_32_bits(job->csa_va));
+		amdgpu_ring_write(ring, upper_32_bits(job->csa_va));
+		amdgpu_ring_write(ring, job->shadow_va ?
+				  PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(vmid) : 0);
+		amdgpu_ring_write(ring, job->init_shadow ?
+				  PACKET3_SET_Q_PREEMPTION_MODE_INIT_SHADOW_MEM : 0);
+	} else {
+		amdgpu_ring_write(ring, PACKET3(PACKET3_SET_Q_PREEMPTION_MODE, 7));
+		amdgpu_ring_write(ring, 0);
+		amdgpu_ring_write(ring, 0);
+		amdgpu_ring_write(ring, 0);
+		amdgpu_ring_write(ring, 0);
+		amdgpu_ring_write(ring, 0);
+		amdgpu_ring_write(ring, 0);
+		amdgpu_ring_write(ring, 0);
+		amdgpu_ring_write(ring, 0);
+	}
 }
 
 static unsigned gfx_v11_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring)
-- 
2.39.2

