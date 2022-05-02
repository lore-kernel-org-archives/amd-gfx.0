Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A5CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  2 May 2022 19:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB27610F16A;
	Mon,  2 May 2022 19:08:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E55110F17D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 May 2022 19:08:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAUMQ36xyTDP+sUQun9G4UEmLlqR7nV1PImPdhzMEPPo9cu7Tc5dKCh/85gGofCQnOOO7BG6HNW6IxMShNypwD+hlMSQttWOBy5fbRcUXWkXWLmwQMxA53tvr1skLr6iSDm17Dy4tBc5MNFraIwP6uXn8fRSqJIClKvBK5MW2eZCMgKK7rr9MADv2HHAwWgl/Afv0Owds/OKzboOIlIPzYMLvQu8/+/sCa4YSnlO/keceQ/xcOjvgbfpaFgE9Q/yIqditY8vgc84SXcmgKjTlOBiFUJYv1WYq86h20g6hK7GpxUXymlHeWERBoAEvDEOuugRgi74oAexvfw/+8G3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRnLNkTqt34f/ZGqf7ylN2pqEgw4A1+bbhrDZVgcJiE=;
 b=B6+BroExNVHCwgPn808WrPY9LLIe/4oOH7tMDSMPe4pT+6AbDvE7MLpSaqCa8mNIo6liH/r4XMbt+zo4KdvAImNyTjAPoZYboDW5jreiSyN5V2pLJuZGKzP/E/HQ4aY9Ipl907pAe264NDMFapEW6zj84tvCKeZPdbvIm5u96KnsSx9/HD9pWe6/Jwac3VtPROBKRbj3WGjkiZ2kZWtBEhgw/8xK5hF7nNA1Qkw26FmmSmBNGIi9RNXIRUp122NIRabq7e/TtXdheENcUg2HMwEZ9bTaI6+4HOIT8rFZLmZKCz2VNoAS8Q00+tKPjIjnZCvAJpPMKcaFXc7DeSlYcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRnLNkTqt34f/ZGqf7ylN2pqEgw4A1+bbhrDZVgcJiE=;
 b=YGP/f/pw+hoCqzcyY7DkazueXBePxtV9oPH95/RS080uct75NhlfHkGaPY4F1dne9nQePBiv7peENuJ9NADCsO9G6LPeNodRGBdSHBns0RtsDV1AiM4zNIeaZqezNomNq4jSfSys3rQueXz3zIDglog733tlAgxnVtIKTVWH7/E=
Received: from MW4PR03CA0058.namprd03.prod.outlook.com (2603:10b6:303:8e::33)
 by SN6PR12MB2783.namprd12.prod.outlook.com (2603:10b6:805:78::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 2 May
 2022 19:08:17 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::69) by MW4PR03CA0058.outlook.office365.com
 (2603:10b6:303:8e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Mon, 2 May 2022 19:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Mon, 2 May 2022 19:08:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 2 May
 2022 14:08:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/11] drm/amdgpu: make software ring functions reuseable for
 newer VCN
Date: Mon, 2 May 2022 15:07:55 -0400
Message-ID: <20220502190804.784271-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502190804.784271-1-alexander.deucher@amd.com>
References: <20220502190804.784271-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d51acf98-7016-4dd5-3c14-08da2c6f1dad
X-MS-TrafficTypeDiagnostic: SN6PR12MB2783:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB27832F8893AA9C7C3E7BEB50F7C19@SN6PR12MB2783.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UnWkgLe+xDPaRVmIDV/FkB+cQokWlWv+n3l9SE5nj1oA7q/kcY5/JSmDJ8VIGSC39b/A41jqC/lZPs0fluwDyJ/Mk7LHysJhXIL8z46fqUvuDwq5PckmD0/WH/11XF3myAWhwBrEbThVDLebgHwGf1OELZFrR5yFxnP+LdAJaQKqrdfiTskMtA/3t5GQIK2dqwgV/AYzNyR59b9b3+0dMjKKJ85urBb+3sJFPa1yIO3c4u1TrrCcShCqKP/vI9WejhVTJdwO87iFnjtis2g1BORNM+i8kBbpwo8anmJjiJvLZNIAhsLGhzmL+CSVkp6HiHJOiunu59UojB6ZA67VAoPhnZ0JsQL+und1k5VgVWhF12IYYpmXyCiTkJuOYguXgtJ4aEJeFSBUiQoQHlGTiX+0dQ966dStmriKywjkpFb6fbBVKblRWYU4DzhxI9K2F9jTlxmNt0ZbZ886S/rAuu0GHIJy8lev4A1cLGeaCUeSR6EvtAadMCfF90/J2ePSgaWNJ+fSvkxo4/8gKPDnYt1DCdh5BQuTBCthKTYoiKgMomP8ZZ/HBux+SuTgoutBSwO9zPizHtrynIQClhqJX9Xdkt6odzmmZVQObCiwGJKn9MvoF/yf5e/QC18zwPo2jHO4+jSNgpmdU4Xmpey4gfnYLaxtilpq7/quEujmQOD7QTZHgnTVqsmSpHn2X4W1LwvUtlxH2HoK36zjfdQLGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7696005)(336012)(81166007)(36756003)(356005)(2616005)(54906003)(426003)(186003)(508600001)(26005)(1076003)(6666004)(40460700003)(83380400001)(36860700001)(16526019)(47076005)(8676002)(70206006)(4326008)(70586007)(2906002)(86362001)(5660300002)(8936002)(6916009)(316002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 19:08:17.5356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d51acf98-7016-4dd5-3c14-08da2c6f1dad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2783
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Liu <leo.liu@amd.com>

Software ring will be supported only from VCN4

Signed-off-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 23 +++++++++++------------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h | 12 ++++++++++++
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 19cdad38d134..930d3bcbb3e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1728,8 +1728,8 @@ static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
-				u64 seq, uint32_t flags)
+void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
+      u64 seq, uint32_t flags)
 {
 	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
 
@@ -1740,15 +1740,13 @@ static void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_TRAP);
 }
 
-static void vcn_v3_0_dec_sw_ring_insert_end(struct amdgpu_ring *ring)
+void vcn_v3_0_dec_sw_ring_insert_end(struct amdgpu_ring *ring)
 {
 	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_END);
 }
 
-static void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring,
-			       struct amdgpu_job *job,
-			       struct amdgpu_ib *ib,
-			       uint32_t flags)
+void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_job *job,
+        struct amdgpu_ib *ib, uint32_t flags)
 {
 	uint32_t vmid = AMDGPU_JOB_GET_VMID(job);
 
@@ -1759,8 +1757,8 @@ static void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, ib->length_dw);
 }
 
-static void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
-				uint32_t val, uint32_t mask)
+void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+        uint32_t val, uint32_t mask)
 {
 	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_REG_WAIT);
 	amdgpu_ring_write(ring, reg << 2);
@@ -1768,8 +1766,8 @@ static void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_
 	amdgpu_ring_write(ring, val);
 }
 
-static void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
-				uint32_t vmid, uint64_t pd_addr)
+void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
+        uint32_t vmid, uint64_t pd_addr)
 {
 	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
 	uint32_t data0, data1, mask;
@@ -1783,7 +1781,8 @@ static void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	vcn_v3_0_dec_sw_ring_emit_reg_wait(ring, data0, data1, mask);
 }
 
-static void vcn_v3_0_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
+void vcn_v3_0_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
+      uint32_t val)
 {
 	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_REG_WRITE);
 	amdgpu_ring_write(ring,	reg << 2);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h
index 31683582d778..7a6655d3b79d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h
@@ -26,4 +26,16 @@
 
 extern const struct amdgpu_ip_block_version vcn_v3_0_ip_block;
 
+void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
+      u64 seq, uint32_t flags);
+void vcn_v3_0_dec_sw_ring_insert_end(struct amdgpu_ring *ring);
+void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_job *job,
+      struct amdgpu_ib *ib, uint32_t flags);
+void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+      uint32_t val, uint32_t mask);
+void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
+      uint32_t vmid, uint64_t pd_addr);
+void vcn_v3_0_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
+      uint32_t val);
+
 #endif /* __VCN_V3_0_H__ */
-- 
2.35.1

