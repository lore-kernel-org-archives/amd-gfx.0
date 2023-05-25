Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D33FC7EE29
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 17:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A21A310E0B6;
	Thu, 25 May 2023 17:08:38 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DEEE10E0B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 17:08:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5Sd3VGvxGDpOMsJNkZZKqoyILHwrz2Bg7LS0820kTJMiTgaOn8+33YiGQw6oaRJ45EV07rf/Q3mSorT07248MJQTHjkSI51MvI8+nnWcOmT7Ys9qj4Ua3qAvpaXXB9WjOSR7BvDKwCdDwg9mFIgijOVHChs1X5vXoTF6uRbegZBT4R9VDW4NYIWNVfJe4tlUpWCd7oIZqNUsN+jZtepZr93witUCufleHrjgwQigGBvMiXH/UmoAjezbvIGsRu+GTNDcwoVF4pujheYg/rOjwk3cVeuSdKDpzEABTtnEv0zBB8JLRzCRh++a60OcjOe7KBLmIM2zCxbMi/JBqT8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRjF+HyOv7Luw1KacK8gXhVim/dcVcRsWwDrpb/b/e0=;
 b=IqyiL2VoUecwuIGkMSRCW12iUhZqiVHkTlfFYYivchQYxhbOWfE6T7X2W4/W8ktW0jAwfWbf3ZDRi6kV1n9EruqI1e9CZBOT54xgonDpNgJGMZGoUPGg1p76/qrs3f0UO99SuCQKaza7FHSs0b4ntljbmC1cIYjRB2NQWaNfjwrnVRRYc5uxuSkSAhaWhg0CWoFwsYqqCQE3GcfEbWK2Y0Sw3OVst01/98QZQzMDcskepIiT1mwxlT8G1Aqgf8HOp3wcJRPa1LxJk/YeJ9NvQnTdgycLMbVi9+/SHo6GInXJ+fuxz/kvo1g1ZD7YDqy3kFFtcR0XubYMTS3eG4Dg6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRjF+HyOv7Luw1KacK8gXhVim/dcVcRsWwDrpb/b/e0=;
 b=Vsw2o+dWVpYd1qtiURZbLTh2OnpxXCoNNHbr/ib/hEhq4Tx0LoSww2pA5ldADdJnOBnZQK4KOLffqcuNBkknQsBtrbmsxqltbU4RZyOCrm4G/UO5qVadlppGhVrG1aUrpHC9lhKOyTNp3mY8Pynrv0d2UeLbpvG56txxaQwIzUo=
Received: from BN9PR03CA0642.namprd03.prod.outlook.com (2603:10b6:408:13b::17)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Thu, 25 May
 2023 17:08:33 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::4e) by BN9PR03CA0642.outlook.office365.com
 (2603:10b6:408:13b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17 via Frontend
 Transport; Thu, 25 May 2023 17:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.7 via Frontend Transport; Thu, 25 May 2023 17:08:32 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 12:08:30 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix up kdoc in sdma_v4_4_2.c
Date: Thu, 25 May 2023 22:38:16 +0530
Message-ID: <20230525170816.790790-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|CH2PR12MB4055:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac2576a-a627-45b6-2694-08db5d42ab50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AFGtqdnbmUb//lClh+nH3fin1WhX8hmvbfyE773eBl/D5l2TumsE2OrFQCpPNXwTgQU++MXmU/GskdzBICSFzsxhpPMMS3Okbjcyo7c6Bh0V7MOGcUBRqMpuTIN/JtaTjkyL4JLh/D6iPhAfJVxYNKNW9V+DPbfHIL/38Dste8E19sKmQ4Bvp9Yfb7CPn2rdLnD85rjVmOQa12qYwY35+RSBAQBYAJdJqN7s0e9Bd5C7/qol5uqPTLNwbS0kHtACP1XX/51H4WxgyHziG6zSak31QjZqU5JyvmVHuqTnrdvmEo9g/xIAfJwFuJwZVgdlSD+6FrjNBoF5K/a1L8K+MoMxDoYHFo4m/eo3+eXlqeYT5xI0bnJZt3hsmXnayGBZP8sxw7NGD5uq6x4ws2/pRtTJ/8T3n4cC/qlJzgqBr79aialjGGbXKzufn8qoad7u03QSHzpznF1vH7B5neQslk5Djb5pwS1hABkpFRXaS3SU6gNSbEpdJdhevKorNVvXc/rORzEOvQYJfbw+KHzWvFmPrjPDzl69axfGWep6f9+mnP06QUTfLFujPRmDvNICpOaBt84OD55Z/6xwQfZEk0oD/evfIewAXHTIphh/h17v1yIGLyFqVyttY+KA4THQ7OfUIfpsCXdZu1Qz+xe8syphg/4RjoEKOzZE4pub2IiZHH3ZkSo2S4sdzi5ntZiwDUF+0p0f2hF1nLszieUbv7zcuzAvQjNauMgin+jGcYsG1FQl5aiu7JCH5893Mh9EKTKPS63W2hrbMFF9gpn7SA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(44832011)(81166007)(356005)(186003)(16526019)(82310400005)(1076003)(82740400003)(336012)(26005)(66574015)(426003)(2616005)(36860700001)(83380400001)(47076005)(2906002)(478600001)(86362001)(6666004)(7696005)(40480700001)(36756003)(54906003)(110136005)(70586007)(8676002)(8936002)(4326008)(70206006)(6636002)(41300700001)(316002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 17:08:32.5969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac2576a-a627-45b6-2694-08db5d42ab50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Address a bunch of kdoc warnings:

gcc with W=1
drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:426: warning: Function parameter or member 'inst_mask' not described in 'sdma_v4_4_2_inst_gfx_stop'
drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:457: warning: Function parameter or member 'inst_mask' not described in 'sdma_v4_4_2_inst_rlc_stop'
drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:470: warning: Function parameter or member 'inst_mask' not described in 'sdma_v4_4_2_inst_page_stop'
drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:506: warning: Function parameter or member 'inst_mask' not described in 'sdma_v4_4_2_inst_ctx_switch_enable'
drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:794: warning: Function parameter or member 'inst_mask' not described in 'sdma_v4_4_2_inst_rlc_resume'
drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:810: warning: Function parameter or member 'inst_mask' not described in 'sdma_v4_4_2_inst_load_microcode'
drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:854: warning: Function parameter or member 'inst_mask' not described in 'sdma_v4_4_2_inst_start'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index ff41fb577cdd..8eebf9c2bbcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -418,6 +418,7 @@ static void sdma_v4_4_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64
  * sdma_v4_4_2_inst_gfx_stop - stop the gfx async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @inst_mask: mask of dma engine instances to be disabled
  *
  * Stop the gfx async dma ring buffers.
  */
@@ -449,6 +450,7 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_device *adev,
  * sdma_v4_4_2_inst_rlc_stop - stop the compute async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @inst_mask: mask of dma engine instances to be disabled
  *
  * Stop the compute async dma queues.
  */
@@ -462,6 +464,7 @@ static void sdma_v4_4_2_inst_rlc_stop(struct amdgpu_device *adev,
  * sdma_v4_4_2_inst_page_stop - stop the page async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @inst_mask: mask of dma engine instances to be disabled
  *
  * Stop the page async dma ring buffers.
  */
@@ -498,6 +501,7 @@ static void sdma_v4_4_2_inst_page_stop(struct amdgpu_device *adev,
  *
  * @adev: amdgpu_device pointer
  * @enable: enable/disable the DMA MEs context switch.
+ * @inst_mask: mask of dma engine instances to be enabled
  *
  * Halt or unhalt the async dma engines context switch.
  */
@@ -785,6 +789,7 @@ static void sdma_v4_4_2_init_pg(struct amdgpu_device *adev)
  * sdma_v4_4_2_inst_rlc_resume - setup and start the async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @inst_mask: mask of dma engine instances to be enabled
  *
  * Set up the compute DMA queues and enable them.
  * Returns 0 for success, error for failure.
@@ -801,6 +806,7 @@ static int sdma_v4_4_2_inst_rlc_resume(struct amdgpu_device *adev,
  * sdma_v4_4_2_inst_load_microcode - load the sDMA ME ucode
  *
  * @adev: amdgpu_device pointer
+ * @inst_mask: mask of dma engine instances to be enabled
  *
  * Loads the sDMA0/1 ucode.
  * Returns 0 for success, -EINVAL if the ucode is not available.
@@ -845,6 +851,7 @@ static int sdma_v4_4_2_inst_load_microcode(struct amdgpu_device *adev,
  * sdma_v4_4_2_inst_start - setup and start the async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @inst_mask: mask of dma engine instances to be enabled
  *
  * Set up the DMA engines and enable them.
  * Returns 0 for success, error for failure.
-- 
2.25.1

