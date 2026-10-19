Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDF8606A31B
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 19:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bFmweXeJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEAB010EA94;
	Mon, 19 Oct 2026 19:07:24 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAE8A10EAC9
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 19:07:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJyVBoudirrYfuOL0DHZxUIrhaGvxqUT2OFZ3LpUSOi1nVBzNMZHroervg3IrDi7YhikwE/a5GJBN1HP1TeENmF1PX3U/onUK3z+lTWUsFRnmp35DTJlbQmEvBEjHaAA7n7qufI2Pih9yie4jmYInzUJlqGLaIAy736pDB6VJ1SLFNNw25ywkbe+oEoSNfaYX79lNcKBPmNDbcNosylH0PtpOjuFVNGkmbVV1nDtEaKKsizAcrRC0lU4UHDaTTPTMTCOmgXaKDIEm8dZXeEnXcfkjdmxZpkhLcVkn2pyxlXFh5Jim7O9LPS3M+G75DAomTDYPhDVXl+l0HX4z/9++A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUbYF2Ku0bTAMHvBLQgjnH9+YRfOUyHsGes/6UMPQSo=;
 b=Xg6ddo19vVBYlvxYa9BbXClCc6KK1lU3bgNUdwxI0B9tU1/gqNl0p9UxnU+jgMrhQ6ci9wi0w/EPieNbkJTs0q6vpFAWkzerJK8OJo7WenvDRf5zws+PiMbZ1BPIBoQUyjzu8dhZP70K0piLlst/JcUY99jfvOvvT1O8TWogYPogQ3Tp7t6ji/6HrWp6D/W23C2/5u6SIHXV6rh2HluRtKwdMRUyK+vx29U976gCDgCPpVChQnzqHCjs5kGhLXHwefErsSrF+x3Bh4Mnrr2C1lWUcsvNHayyuAXkj8ICUCg9qHsZY7jVMA4Tu1QJcxw493/ZVDgPzlJFDgNzWrkwBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUbYF2Ku0bTAMHvBLQgjnH9+YRfOUyHsGes/6UMPQSo=;
 b=bFmweXeJA1iX8nPr6prIvPvakv8LEbJQbz3PjpG1WhX1LjtQa3X3JcZcdcFqr9KgRammVKwYfHl+HrF21WVipO8+wVoSPPprM4RF422PdkB2vae0v0vfPMeL/AbP6/gzwOPfv48g0i6czr9iotyqzF/Ex8aKwtMpWpGrUAWaf+M=
Received: from CH2PR15CA0011.namprd15.prod.outlook.com (2603:10b6:610:51::21)
 by IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 19:07:07 +0000
Received: from BL2PEPF000352D1.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::20) by CH2PR15CA0011.outlook.office365.com
 (2603:10b6:610:51::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 19:07:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL2PEPF000352D1.mail.protection.outlook.com (10.167.249.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 19:07:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 14:07:06 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 14:07:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/sdma5: don't access registers in MQD setup
Date: Mon, 19 Oct 2026 15:06:55 -0400
Message-ID: <20261019190659.2773961-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D1:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b72f30b-898c-4612-409f-08df2e142b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|261009223027099003|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 4khy7SrOykhPtVbsioV8wLShZGtcKzGd8qeIBSnhxJuU8NRp92pv98+6mXTg3qYQEivplxoviGUiMwTJtR7+KBSDew2F7hB5VwS/KUVIOPHE48OkWChVT34yTfiAy42yDKwmSfDc9uYkFkJ8H2nF//A/hHlcJkr7VYeFlcRLTTrLQOomDCUu9NeapObXjzsmWJMrgQA1CZeYRfIhGpBv9mIafKI1RGB9/JOS34bafhhqPpRf5u7l2qtyRUWOBFuWTB5tc5qjEg5ssNaqOV79gjFmUx1VTPNigaf3EgD+Fr8NUTpzBHzb8hFb+fUzkssIIZUKbq9u0XlOGwGhmyv5P7qnmX5hRaRBOy7kJLzMNwnBwd6c9vIyYcjLBNFWZ6E0w5Dd07SGi9+5jhbahRUfVCbdwJtNqdloLmFb3Whno0C3ZcFvuX6PjNoDhPISHtW/F56rfhNCpZ9K5muUZSyxuml9tIGZObcoho/usmM7NSVNuznSHISBEpP4TATDslMqRmFJ7fFHPSlQ3VfsqZIkScndVMeEgU2vqZLPj/uw57E3Y+Hd/ydjMrvSycSUrzJxgFQVWYzb1NrrWtX8TAJ6WXxAe74Zo2b8CH4iCuVUB7tWdO5Pjdffwd5Wbl73KiGlELzF2ThhYNeZZN5ZhXx/xFxLVJzXWI24Ey5/G/sRZ+fHeT5Dj3lTEgBmE3sa4HilDpCUl2ANRiKIWL+VW2oaGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OcLXKQ1rWD2lm0CF/B2C85oz5pVjLrU3xiBll/7JziYMkXjKpXQRfkaV3hdeBWxuuGlgD1rsVhltdqRxrSMzk8RBFg52zPmXsYrX8r2r8XXTmyXIJ4tiCiOST17P/R8yAsV0UwY1IBtPNzDajE1eiC86c5OZ+Ksc4d5tjN7vfRRoip8Ipbk7RPN833BQsE9C0O5ZYoSPKWBzt1XFGmIsSrV7N+LtrvY7+04x/I1WqtDkx9O/3DcdhHWFuzWKZCHSyJGddG1bnsJiArh4e5x8Y6bcVpenHmJ4s2WV8uoIEGSXM6XILYYQ5HTphMxrSGeF8gt3xN6ZYRP5KUYULuSVzVIUS030+kQ3l3SmdDXUTV3JrRxkSxZfZWkpwPl3oK+wtDvuz5ozL+s5Lpihkrr/pn5COkSMleUCjh0DvotA0n9nspImtSUCIjxLYY3p42q9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 19:07:07.1473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b72f30b-898c-4612-409f-08df2e142b61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2PEPF000352D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138
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

No need to read the register state from the hardware, just
program the settings explicitly.  This could also cause
problems when gfx is powered off.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 1a1427d2dd20e..883f558eb79dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -932,6 +932,7 @@ static int sdma_v5_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 {
 	struct v10_sdma_mqd *m = mqd;
 	uint64_t wb_gpu_addr;
+	u32 tmp;
 
 	m->sdmax_rlcx_rb_cntl =
 		order_base_2(prop->queue_size / 4) << SDMA0_RLC0_RB_CNTL__RB_SIZE__SHIFT |
@@ -942,8 +943,9 @@ static int sdma_v5_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_rb_base = lower_32_bits(prop->hqd_base_gpu_addr >> 8);
 	m->sdmax_rlcx_rb_base_hi = upper_32_bits(prop->hqd_base_gpu_addr >> 8);
 
-	m->sdmax_rlcx_rb_wptr_poll_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, 0,
-						  mmSDMA0_GFX_RB_WPTR_POLL_CNTL));
+	tmp = REG_SET_FIELD(0, SDMA0_RLC0_RB_WPTR_POLL_CNTL, FREQUENCY, 0x100);
+	tmp = REG_SET_FIELD(tmp, SDMA0_RLC0_RB_WPTR_POLL_CNTL, IDLE_POLL_COUNT, 0x40);
+	m->sdmax_rlcx_rb_wptr_poll_cntl = tmp;
 
 	wb_gpu_addr = prop->wptr_gpu_addr;
 	m->sdmax_rlcx_rb_wptr_poll_addr_lo = lower_32_bits(wb_gpu_addr);
@@ -953,8 +955,9 @@ static int sdma_v5_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits(wb_gpu_addr);
 	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits(wb_gpu_addr);
 
-	m->sdmax_rlcx_ib_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, 0,
-							mmSDMA0_GFX_IB_CNTL));
+	tmp = REG_SET_FIELD(0, SDMA0_RLC0_IB_CNTL, IB_ENABLE, 1);
+	tmp = REG_SET_FIELD(tmp, SDMA0_RLC0_IB_CNTL, SWITCH_INSIDE_IB, 1);
+	m->sdmax_rlcx_ib_cntl = tmp;
 
 	m->sdmax_rlcx_doorbell_offset =
 		prop->doorbell_index << SDMA0_RLC0_DOORBELL_OFFSET__OFFSET__SHIFT;
-- 
2.56.0

