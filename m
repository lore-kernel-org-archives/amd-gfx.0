Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF41C4743D
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 16:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17935611AE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 16:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17935611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6DEE6E13C;
	Fri,  4 Jun 2021 16:38:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98F086E13C
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 16:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmZrVuDemC3qWNZtzGWtGbddM0dL7sOXzii0LhJnVJG56r23O34R48G+zwDAyVzsJJh/Oddoa7mRw2rXU/jF5/QZdKC7sJZy1Fz9F/KI7d833+w+hbTSH81YTgW0tzfvFR4mcY9WQPJmBtfM5aDUIArbrxCHLCgriSZiplPtCjV7DqPO/9F1kKT9mvQ97dV7/AmINk7sw4sDL2ndUmVruJeZWYPJUJtPEcfP9P7M5O6NdBnfrxb1gbf1txpI7y2GtQUkYqj9Z+LjD53o45Il144beMur1TDuaaby3P8M34U1FdLy827pZH2imAqkdPesil6dQLc88Wp3t7xJ1UiXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CacRpqaq0Oo5Nkg/ioV7HI6NcLn7Mh124AfSMUaCMXM=;
 b=dpWnOC3Ah29FTtVbxnEjcHmxs/TPU0rHPicBXrmhas+OhddRXJDosQJE9zJ8JM4U+sJhiJR/NnhRfKFw/Nj1iZWw/hKEuaHsNghIsA6AR2o+eh4oi3LA/83/Zq7WVOBq06jvyd8Bwhf2fLu11Jl0kioIfx1knQRpkzUN4/FLN3MkiOiG7GdWf7pJLpaSAlPvZvN7jo5WtmZUXMqGsekJ6FcQn3cU+H0Ja7RvMCETDLbnZtfTvZY+WAE4NHF/Y0yUVef9j3WPeH/n6uoCRkbljYco2g/56Cw0JVOShB/gp0z7TwVBfq9r+YwcFhcZjaVqiqkFaBHsUJ5oRuLbgwgI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CacRpqaq0Oo5Nkg/ioV7HI6NcLn7Mh124AfSMUaCMXM=;
 b=XsSh/kflT6QMFQ1xCsgz5akvgyw2Xeyt3mS37qJqJBG84stiAP6S3uqjVhUqUG9XgfdPf1yOBaN+WsezIc37aNilxABf+DM9aI9iFXhKJt6Z9Ry2pmXhgzjZLJ+D6MF20LYkmhhIw2mzD0RClR32O1Cm43jsvkW0m68310aWHZ0=
Received: from BN0PR04CA0083.namprd04.prod.outlook.com (2603:10b6:408:ea::28)
 by DM6PR12MB3609.namprd12.prod.outlook.com (2603:10b6:5:118::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 16:38:46 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::ef) by BN0PR04CA0083.outlook.office365.com
 (2603:10b6:408:ea::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Fri, 4 Jun 2021 16:38:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Fri, 4 Jun 2021 16:38:45 +0000
Received: from Rohit-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 4 Jun 2021
 11:38:44 -0500
From: Rohit Khaire <rohit.khaire@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alexander Deucher
 <Alexander.Deucher@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, "Emily
 Deng" <Emily.Deng@amd.com>, Monk Liu <Monk.Liu@amd.com>, Peng Ju Zhou
 <PengJu.Zhou@amd.com>, Horace Chen <Horace.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: Modify GC register access to use _SOC15 macros
Date: Fri, 4 Jun 2021 12:38:26 -0400
Message-ID: <20210604163826.21693-1-rohit.khaire@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d876975-c198-4c2b-c1be-08d9277738e9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3609:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3609A5D18456F95EEED9DF86873B9@DM6PR12MB3609.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p6dPZNHQRzsb/y3f9mEpF3La6+KKRcq/HZIVLxlCP0e6qYCKUQdnIELcd2EIIUhOieYTtlP64b6FxFfH2IstmrxpQQc2/fWCmnfOvgFlo6Hl5ZfMPTSL/dXvkcQgR5JcxssQftPSGVVLsUHSAZjQ1u92a8O2rf7GO56hz+BYgud5OCCdXpN+ZSmlqqV49gcMNmuGJ7iPijUA4dNtWs49DeJyl6REHKX3zTHKEJ9dWlE0RXIdqZfcD+OCcgXaDccvrH1hYe0mwT0p/YSQrc/dqKvQWp4fGBFZ+GAOA1vFgRMoiy6ehlRaSgoB1dP9gpcpyCzfMBeOENnCUma2oqvDoTAJs8Zge8dfS0bvrY0v6k/a19lfOv8uqAuXuzjkPz/+fPxBsiUwzD4xlC4bax7kF3BAjrmXcN4qIOp33RX78KDqQX11OV0LdDarGqGDKYDaFzsaEJWeg/4ohbr6L6vzlmryGzbEj3p/+JT5jPZEtY5oOdipa0fs0ZrnrTpMdCgY4VldwYGT/Hm2djlujVufwVVs9imKy8Rz7QKfUx9pIdoWlNWrY9TUCFOEGxS5HWGp+1OH9rjDfnMYnlmapHXn5adLNUdRAZpX2tmf3xX6Y7dtEt1h6KIbSiRiOB2it3PiawbmZTGSt388YYx05XV//Phu3pk9Bqu3QO3FlOAamQ3E9PYhiJOjNp3v+B3BvfyT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(136003)(396003)(346002)(36840700001)(46966006)(47076005)(5660300002)(86362001)(7696005)(8936002)(44832011)(1076003)(336012)(6636002)(426003)(478600001)(8676002)(2616005)(186003)(4326008)(26005)(36756003)(316002)(82310400003)(82740400003)(2906002)(70206006)(54906003)(70586007)(110136005)(83380400001)(81166007)(356005)(16526019)(36860700001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 16:38:45.8651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d876975-c198-4c2b-c1be-08d9277738e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3609
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
Cc: Davis Ming <Davis.Ming@amd.com>, Rohit Khaire <rohit.khaire@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Using _SOC15 read/write macros ensures that they go
through RLC when flag is enabled.

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  | 42 +++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index d39cff4a1fe3..1f5620cc3570 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -95,8 +95,8 @@ static void program_sh_mem_settings_v10_3(struct kgd_dev *kgd, uint32_t vmid,
 
 	lock_srbm(kgd, 0, 0, 0, vmid);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_CONFIG), sh_mem_config);
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_BASES), sh_mem_bases);
+	WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, sh_mem_config);
+	WREG32_SOC15(GC, 0, mmSH_MEM_BASES, sh_mem_bases);
 	/* APE1 no longer exists on GFX9 */
 
 	unlock_srbm(kgd);
@@ -129,7 +129,7 @@ static int init_interrupts_v10_3(struct kgd_dev *kgd, uint32_t pipe_id)
 
 	lock_srbm(kgd, mec, pipe, 0, 0);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmCPC_INT_CNTL),
+	WREG32_SOC15(GC, 0, mmCPC_INT_CNTL,
 		CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
 		CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);
 
@@ -212,10 +212,10 @@ static int hqd_load_v10_3(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 
 		pr_debug("kfd: set HIQ, mec:%d, pipe:%d, queue:%d.\n",
 			mec, pipe, queue_id);
-		value = RREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_CP_SCHEDULERS));
+		value = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
 		value = REG_SET_FIELD(value, RLC_CP_SCHEDULERS, scheduler1,
 			((mec << 5) | (pipe << 3) | queue_id | 0x80));
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_CP_SCHEDULERS), value);
+		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, value);
 	}
 
 	/* HQD registers extend from CP_MQD_BASE_ADDR to CP_HQD_EOP_WPTR_MEM. */
@@ -224,13 +224,13 @@ static int hqd_load_v10_3(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 
 	for (reg = hqd_base;
 	     reg <= SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI); reg++)
-		WREG32(reg, mqd_hqd[reg - hqd_base]);
+		WREG32_SOC15_IP(GC, reg, mqd_hqd[reg - hqd_base]);
 
 
 	/* Activate doorbell logic before triggering WPTR poll. */
 	data = REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
 			     CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL), data);
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL, data);
 
 	if (wptr) {
 		/* Don't read wptr with get_user because the user
@@ -259,17 +259,17 @@ static int hqd_load_v10_3(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 		guessed_wptr += m->cp_hqd_pq_wptr_lo & ~(queue_size - 1);
 		guessed_wptr += (uint64_t)m->cp_hqd_pq_wptr_hi << 32;
 
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_LO),
+		WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_LO,
 		       lower_32_bits(guessed_wptr));
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI),
+		WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_HI,
 		       upper_32_bits(guessed_wptr));
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
+		WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR,
 		       lower_32_bits((uint64_t)wptr));
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
+		WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI,
 		       upper_32_bits((uint64_t)wptr));
 		pr_debug("%s setting CP_PQ_WPTR_POLL_CNTL1 to %x\n", __func__,
 			 (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),
+		WREG32_SOC15(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1,
 		       (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
 	}
 
@@ -279,7 +279,7 @@ static int hqd_load_v10_3(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
 
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE), data);
+	WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, data);
 
 	release_queue(kgd);
 
@@ -350,7 +350,7 @@ static int hqd_dump_v10_3(struct kgd_dev *kgd,
 		if (WARN_ON_ONCE(i >= HQD_N_REGS))	\
 			break;				\
 		(*dump)[i][0] = (addr) << 2;		\
-		(*dump)[i++][1] = RREG32(addr);		\
+		(*dump)[i++][1] = RREG32_SOC15_IP(GC, addr);		\
 	} while (0)
 
 	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
@@ -482,13 +482,13 @@ static bool hqd_is_occupied_v10_3(struct kgd_dev *kgd, uint64_t queue_address,
 	uint32_t low, high;
 
 	acquire_queue(kgd, pipe_id, queue_id);
-	act = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
+	act = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
 	if (act) {
 		low = lower_32_bits(queue_address >> 8);
 		high = upper_32_bits(queue_address >> 8);
 
-		if (low == RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_BASE)) &&
-		   high == RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_BASE_HI)))
+		if (low == RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE) &&
+		   high == RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE_HI))
 			retval = true;
 	}
 	release_queue(kgd);
@@ -542,11 +542,11 @@ static int hqd_destroy_v10_3(struct kgd_dev *kgd, void *mqd,
 		break;
 	}
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_DEQUEUE_REQUEST), type);
+	WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, type);
 
 	end_jiffies = (utimeout * HZ / 1000) + jiffies;
 	while (true) {
-		temp = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
+		temp = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
 		if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
 			break;
 		if (time_after(jiffies, end_jiffies)) {
@@ -626,7 +626,7 @@ static int wave_control_execute_v10_3(struct kgd_dev *kgd,
 
 	mutex_lock(&adev->grbm_idx_mutex);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), gfx_index_val);
+	WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, gfx_index_val);
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_CMD), sq_cmd);
 
 	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
@@ -636,7 +636,7 @@ static int wave_control_execute_v10_3(struct kgd_dev *kgd,
 	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
 		SE_BROADCAST_WRITES, 1);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), data);
+	WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	return 0;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
