Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9626FC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 14:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 543CA61481
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 14:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543CA61481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE856E7D5;
	Mon,  1 Feb 2021 14:38:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACD3C6E7D3
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 14:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtwCqdm1ARGt2lALTgpR1YH0VwgJ4bNdDWlvLAV7MXjF6FrCFV/tqw1Kdqqb3Ta2aXO1oJIQZsMY7w6nsRsQ6RWrCmP2eJJulUuqW6s98J0rX7r4AVWz0TCS+M41VeMJ6IDLhKCf8QQqX7LE5p6CU8NrpPDW4bjIxjYBNYDqsO2oPCcR+QsnAXm/5PMXhhByVwWPBjbsL3pIzVIOf/Me2w0hvUIAIF7oHmBsyMxbkFPmKhNWDPBQwGJ17IDWAzWkPKBPr9OWIU/F+JtRIrtiTMTYohC/2kx4NfrxnBLHztTVHFJ/RU9ugU8kAqVYo1FeZ488t74T9Cb+Fp65l1wx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvgBDXTRkx/T+hOREm32AW4HVDOF7hZ92APH9bfTpgo=;
 b=GVOqPHO8567U1ZpTOzz/VmcFPYoHdh0qd/Jh/k/ymrUxFXg3ux4Of/V9PNAm8n8kxjDw73I7yPIG8/ORwidVwbsffUTExMFAf4AAtdN4s2alSomtiLCre7KjStJBDRUBPVMMNkDJ9sLUjBWw16/iv9HiJaVnNZ0KD68Wecs7AUSnk39TQUlXA52N5bZ1edt7f1hE2XHkGD5c/QLG96i+Z9GGkn9nAiatm4UPBMDg6eJjsTUzLg9bkpGpGqLubLys/BDt5n86vm4fQQGZbVIuXP9le1ASf8P6Q2YQiSuKOGl6jwNVDaSUkUs+dkD9TrB5TdXPWtZ2gfuyZNHK9HuIXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvgBDXTRkx/T+hOREm32AW4HVDOF7hZ92APH9bfTpgo=;
 b=ywddp1gQ4rG9Q0UkbrbRst214PH9n5/yLh9wP5G8SRLGIlEndpKaarvkLlv+zGHP/GgCg7tSPp5UtCZ8c0jbYtwGcXPSSMMRkgbLRX8kAd/GfiFQTgXdUUvYOtS1V093s7p5HlQSumbV5YvPBGXzfqjF/sW3buR9HPb5Dwo0ROg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB2373.namprd12.prod.outlook.com (2603:10b6:4:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.20; Mon, 1 Feb
 2021 14:38:16 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Mon, 1 Feb 2021
 14:38:16 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: add wave limit functionality for gfx8,9
Date: Mon,  1 Feb 2021 15:37:59 +0100
Message-Id: <20210201143800.26908-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210201143800.26908-1-nirmoy.das@amd.com>
References: <20210201143800.26908-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.32.223]
X-ClientProxiedBy: AM0PR04CA0144.eurprd04.prod.outlook.com
 (2603:10a6:208:55::49) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.32.223) by
 AM0PR04CA0144.eurprd04.prod.outlook.com (2603:10a6:208:55::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 14:38:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cff2e5a0-26d8-454c-01dd-08d8c6bf02d1
X-MS-TrafficTypeDiagnostic: DM5PR12MB2373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB237334FBD98597098A47BB388BB69@DM5PR12MB2373.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QqicbHigeOounDRK3p+4M2iaUPhg6PEDSLLd/TxkRCeoqtsivBmmVZQNCTVplrfKcShSBL3vpjt+0rMF+eI3I56y1LSDYgrj+1WAmPXP6rzshvSltbt30bHQCzHXhUC5JbFDxRAE5h90+5NSDeDjpiBVJe2f66trWtBz5lqkYB42IDNzwd07UWZw7gPC+uoe9aedpS/g2a/h4VVLzFOpkH6uhA0X56m4QYXmu/A2q+IdRbFO7ltU2WFeM6miWLyF+RdEqxP6B+BkdNSu49+TS4useutVoyazXMDhLFV6iD7zq9tdRiUKgxqCi7mmlciuVAEo1DNjxguGnTymTlg7VK7cUgvLj6MaiO2LMwhPnqVTFdY2UJ72qoMeWj0ThWDK1+w4NamIvacwj5Iq8QYyfBPTuorKrIdZr9m0Q7Vj6W60cZpE40qEq6GvoeBW4QEUxTuN92tox2pl1bwhRgQcsKHuHS/KU8MY/0lW8iePyJH1Lx5HGIPFiRVxQ/iiPSGzQADFEZuBFebLYBJ2WPMcIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(2616005)(6916009)(44832011)(6506007)(26005)(186003)(36756003)(316002)(52116002)(6486002)(956004)(6512007)(86362001)(6666004)(8936002)(2906002)(8676002)(66946007)(16526019)(66556008)(83380400001)(478600001)(4326008)(66476007)(5660300002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5krAvHiuVGpR/3qPWa+IP8kpYMu693vcxs/J+7OdK/9cb9/X5ZBT5BygaWox?=
 =?us-ascii?Q?C0fmtur1rprfnDfr/AQ2AH8vatIJzYEoUu3Ns5s9I8uRfDjdJOMgJzGLJRid?=
 =?us-ascii?Q?kFRPUz1yoj8CuVlEmwRDqSbk0t1ig3D5cuEgcxdniCl47A39vAU2xLFESmqZ?=
 =?us-ascii?Q?H1NOmtpstUoDzr4aI6o8PZQAOid/G2x8UeEW79nKtcTeicyFX2+sHjROjrqa?=
 =?us-ascii?Q?6M3dJ3rWeTZ7GsaqwmEL4JMvzOR8fcG2HAedvTMIz3kqKK5qrBc0WCGp7WfV?=
 =?us-ascii?Q?IJr64Ox2vCdK4EsKQwpHxGLxYcU9Dmwuy6/ZsMpdNT+CVdUqGUgrdWhSARW6?=
 =?us-ascii?Q?HB4NMUMGPUxXqp+c4HzYOzduND57Mu/87lYhK8B9a476JQw1YZxNV43EBO35?=
 =?us-ascii?Q?4U/cNB/bsB4vVpazbOeNXfk+yL6AiBms1yM8J65nkUIRfkXBGQKf2HzMugfp?=
 =?us-ascii?Q?UaINz+Bz7X4l671tw4K+f0OB5M+m/R87s0NBZi6I7g8kfi8mDhLiRuliO3eQ?=
 =?us-ascii?Q?xCZ7IvEVkrGCHEr/WuBO2pU9l9sU6xItk82IqFyLM7t823Lq+5YS6qTIl4Wj?=
 =?us-ascii?Q?T0zN4yIbyDU30KYp2/8sQT2sFctBhbenVThU47Ty8Dp2u00QvNOstQIcuOG3?=
 =?us-ascii?Q?EgAlsB9t+Cx5Z43tsvVxY1ZPsb3ubVxp4evkTOKDG7j5d4lLmpoKW/jyKGQ5?=
 =?us-ascii?Q?gjs+MwFw73Wpi7y6fiqmep2SaUYEmSn0AxVB3nzLbdifSgC/wVMVtIMHUaRF?=
 =?us-ascii?Q?8OdsIHRqoxBQ1e/OxSOXnQ3U7YqkmeQSPb+OA0NlO1cSNX1nPt4ZDpfGAiL0?=
 =?us-ascii?Q?XsiX//n/vP1aZkYGLHxBch0di3EB/wEo0utDfbmnHOnja2Y7FPSkSWHFsaBI?=
 =?us-ascii?Q?Y1ajflLden7IXKi/C6evd9aFog13t8cITqJ6APKNHy3DxWnQ4oxIkU+zK1ue?=
 =?us-ascii?Q?FmRP3PQ5pGk0ET+OAf3uWidxhK8yAnT/KWu6mdpKjUQaLmS4sjcQK35WIblT?=
 =?us-ascii?Q?eJlJ/lpskcVibFERxEP+u6h0qU3aOcvIG+Q8pxCndNvXhKTpAFRYH6gE8Sur?=
 =?us-ascii?Q?oLfZjDhR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff2e5a0-26d8-454c-01dd-08d8c6bf02d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 14:38:16.3219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEfVyvDliuLctX6aIVDSQfau6V6+CE9xJmwg1Beo4AxZ2hmM2ZqqImqc7DX42fEfAHVXpA4oFYhp6kUQoPSFPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2373
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
Cc: Alan.Harrison@amd.com, Felix.Kuehling@amd.com,
 Nirmoy Das <nirmoy.das@amd.com>, ray.huang@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Wave limiting can be use to load balance high priority
compute jobs along with gfx jobs. When enabled, this will reserve
~75% of waves for compute jobs.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 18 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 21 ++++++++++++++++++++-
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7112137689db..220eec886f23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -197,6 +197,7 @@ struct amdgpu_ring_funcs {
 	void (*soft_recovery)(struct amdgpu_ring *ring, unsigned vmid);
 	int (*preempt_ib)(struct amdgpu_ring *ring);
 	void (*emit_mem_sync)(struct amdgpu_ring *ring);
+	void (*emit_wave_limit)(struct amdgpu_ring *ring, bool enable);
 };
 
 struct amdgpu_ring {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index b0284c4659ba..bdfd29a22b3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -29,6 +29,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
+#include "amdgpu_ring.h"
 #include "vi.h"
 #include "vi_structs.h"
 #include "vid.h"
@@ -6845,6 +6846,19 @@ static void gfx_v8_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0x0000000A);	/* poll interval */
 }
 
+#define mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT	0x07ffffff
+static void gfx_v8_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
+{
+	uint32_t val;
+
+	/* mmSPI_WCL_PIPE_PERCENT_GFX is 7 bit multiplier register to limit
+	 * number of gfx waves. Setting 5 bit will make sure gfx only gets
+	 * around 25% of gpu resources.
+	 */
+	val = enable ? 0x1f : mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT;
+	amdgpu_ring_emit_wreg(ring, mmSPI_WCL_PIPE_PERCENT_GFX, val);
+}
+
 static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
 	.name = "gfx_v8_0",
 	.early_init = gfx_v8_0_early_init,
@@ -6928,7 +6942,8 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
 		7 + /* gfx_v8_0_ring_emit_pipeline_sync */
 		VI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /* gfx_v8_0_ring_emit_vm_flush */
 		7 + 7 + 7 + /* gfx_v8_0_ring_emit_fence_compute x3 for user fence, vm fence */
-		7, /* gfx_v8_0_emit_mem_sync_compute */
+		7 + /* gfx_v8_0_emit_mem_sync_compute */
+		5, /* gfx_v8_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
 	.emit_ib_size =	7, /* gfx_v8_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v8_0_ring_emit_ib_compute,
 	.emit_fence = gfx_v8_0_ring_emit_fence_compute,
@@ -6942,6 +6957,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
 	.emit_mem_sync = gfx_v8_0_emit_mem_sync_compute,
+	.emit_wave_limit = gfx_v8_0_emit_wave_limit,
 };
 
 static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_kiq = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7b13f9dd965a..027997e95e46 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -52,6 +52,7 @@
 
 #include "asic_reg/pwr/pwr_10_0_offset.h"
 #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
+#include "asic_reg/gc/gc_9_0_default.h"
 
 #define GFX9_NUM_GFX_RINGS     1
 #define GFX9_MEC_HPD_SIZE 4096
@@ -6667,6 +6668,22 @@ static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
 }
 
+static void gfx_v9_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t val;
+
+
+	/* mmSPI_WCL_PIPE_PERCENT_GFX is 7 bit multiplier register to limit
+	 * number of gfx waves. Setting 5 bit will make sure gfx only gets
+	 * around 25% of gpu resources.
+	 */
+	val = enable ? 0x1f : mmSPI_WCL_PIPE_PERCENT_GFX_DEFAULT;
+	amdgpu_ring_emit_wreg(ring,
+			      SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_GFX),
+			      val);
+}
+
 static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
 	.name = "gfx_v9_0",
 	.early_init = gfx_v9_0_early_init,
@@ -6756,7 +6773,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* gfx_v9_0_ring_emit_vm_flush */
 		8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
-		7, /* gfx_v9_0_emit_mem_sync */
+		7 + /* gfx_v9_0_emit_mem_sync */
+		5, /* gfx_v9_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
 	.emit_ib_size =	7, /* gfx_v9_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v9_0_ring_emit_ib_compute,
 	.emit_fence = gfx_v9_0_ring_emit_fence,
@@ -6772,6 +6790,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
+	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
