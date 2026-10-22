Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04D3606A31D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1SCCaNz8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FC90112403;
	Thu, 22 Oct 2026 08:33:58 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013025.outbound.protection.outlook.com
 [40.93.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3676112406
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOsrF4Uk3EpgLe4B52QWYknnAVjE+HQQxg+7PYui/1n66KhzmZO9P+IwrX1KYrlx96LxT914d0xWsZNLf4H5cz4tLmOsqsc/ujWkFinzz8cIbLJnZzY7YT8DFxFdPaecHLqOVYoMcRBiC37rXfnwe0lOI0wi71yfIJm2Yf7zqbdzndOrBVcHLFh4rHinwp6hAYBa7ejUEC72OVb+z6DPPnmWpAgkcn/m2mfre7A65i+HJYzQv+c6kyh9hpLeXLNl36aeTUqDQr6vbPmKc0k251Mgy1PjGdGrnAdj1maGlgggwbLXptfYQ58V+MU4Rtd2HyeCaD4lFg4G6ed+6j39bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlWCyJq87pzo6fHkSAmjcGT0yaQykH1U8XWwDsmjhbc=;
 b=Gb363sHb7ytDJgUAtwg29oILSl3uH0Q6W0mW1LOFVWtffl1VrLMHMbHkrNINup6oZYSg3ob0mvb1bR+8tZwAfXl+r0W0bpXWgcMFRWF2B+97a6VCzcTd79pyvjwbTDfpMJ1Ly4YFw5a4GquR1gAsjfRkYxpU6HNRnskhlrkhSiKDOiZHPu1ui5gaG50baEDC6iZXD8kaBdOvQHaVyteiedS7TBsjkAIi6tdkOH4E/dILjm3yMtdblD58kVpgivugZDgTqFpulm8nFuq3/OdvdrnGOL0bP6r5ryuqtnhXC4WRcVIuIuJm7I2EocZEDT4wXXaLcwR0ydJbcjN/wKwfGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlWCyJq87pzo6fHkSAmjcGT0yaQykH1U8XWwDsmjhbc=;
 b=1SCCaNz8EGZxZ8Nj2ZxTl+lKZvZcarWWLMxYDdEeLo67ZVAog0aaSZY4hZ7vfEaJHGfV2aLvhvBOqqmU9TtUkDSduXpQ96FUuwI81BYZHhms7WwSM97henzVDlGDSpAvmpbgj1+u4hMM+IT41PG88H40a/CUBbs03ToeNE2S160=
Received: from CH0PR07CA0001.namprd07.prod.outlook.com (2603:10b6:610:32::6)
 by CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:33:50 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com (2603:10b6:610:32::4)
 by CH0PR07CA0001.outlook.office365.com (2603:10b6:610:32::6) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17
 via Frontend Transport; Thu, 22 Oct 2026 08:33:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:33:49 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:33:47 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 5/9] drm/amdgpu/vce: don't allocate a scheduler fence in the
 direct IB test
Date: Thu, 22 Oct 2026 16:33:27 +0800
Message-ID: <20261022083331.3019779-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022083331.3019779-1-Prike.Liang@amd.com>
References: <20261022083331.3019779-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a6c4e1-9cc0-444c-61f1-08df30173272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|22082099003|18002099003|10067099003|261021121427099003|261021123027099003|11063799006|261009221727099003|261009223327099003|261009220027099003|261009223027099003|261009221227099003|56012099006;
X-Microsoft-Antispam-Message-Info: 91fAW5d33VXhtnRB6NBlphUnpejBNTLe6iQG2pNEQFct3UIjqGxbNrhr1Kv8hPMht4SmHr4mBn3HA6bg/F3y8rdu69ggDyU94W3b+g33jBhH4NTnMfDhcudW31lJe4y9TyIC5l+/fxCtRO/DRxRElJW+Y0FJjCdC0W3aZtaCImj6sbO9JC2sNmpHLOtArywOPz6fMzQa8cs/041ENtz0qedgTjsg37H2sIV0QpB9lovjbhHFL958v1xyhKHvk6iv6NATr6TRNIUVSaa7oIy4Yl8gCs2i4NDa0B4yJR9R8YeRkWlW/xQRf/4LxYO9Jqbpy0/d+si+MkWUIX8PXZ1aWj+liHPnOq00m4WA/cVVFb+4QE81/AOaahDBVQrC6JrCFlc1RfQeO0Rxl87BsIamK4OGqa/ZnwBc+NXzHhTm6WFN5MPEADfg3CoMBFzH9AwfenNf0RmQ4kq6/3HwINwBKb1M5Ec864eoDHalyOaFMQvPiXmqZ4yHvyHxVGgdrSBrmrw216Ta9rO0e3Sx+wQLRuugf8BGk2vyRzOSpzXIBGJNWeCS/luOCTYfWWQ5iOmLjVDmn6IcBg9Cw4kkPnTPYsfJBfJMqIvxnIGciYbpk2P8/rpIUo2d1aktmkRQEbz0g6bYlv3eg1DQvLXCSlCQG3D08U+8lMVijRVb+XWFQW7FPVtnN858UdLLXTCnIwp0+c4/q051Fw6AB53MUoArpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(261021121427099003)(261021123027099003)(11063799006)(261009221727099003)(261009223327099003)(261009220027099003)(261009223027099003)(261009221227099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hofjtmKb4+lU58uESgKtCjO27ddnQVAOLZzVs4GBo5mX2/G8itZnIFs6JzftjnLpynQAexVkFJhIXk/jdiwX3c6U5sg0GXVddKvsBW0Nf1x7hyXRtvsxn4cWtf45xy/4t3aH8zdXzMPalmdptTo6NalM3ZOM722YicTmxaiPzdZUuap2KTp7OIyiaWwaTvBEFS591ho3g+EBhr8kUt0OApa273CfrJtKmPRG74IAS69tAJM9Z2iJBlHMtATL4obWQai4zusmAW6TodBi+BaQVcsJnPq1D40RkwskdyqzIjO9G4JRCzYQtBINPB0PHH9jpxOJu3JlidrkDYb4UAVtP9jrcUbjQDRjH9PN/DShgHYB0sJsH8d07kovVKdUl9x0+dYYjjlL72N2pBRhXXOwjKpjbUPxwNenQFrL4pDVkYqNPPVLeh+BgdKHxEga30Jf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:33:49.8087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a6c4e1-9cc0-444c-61f1-08df30173272
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731
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

