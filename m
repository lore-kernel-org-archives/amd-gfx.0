Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6737C54FD0
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 14:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89AC82070A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 14:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X5PTFrx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AC82070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2031C6E86D;
	Wed, 25 Mar 2020 14:30:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DB686E86D
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 14:29:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/hnKmz9A/wtFWwzYzezwLlS2JOm8Q29NX5az98wxygM2vPCG/XRQ4D8ikgX/WDKRQYLA0p2eUckB+ZpEkQl39rdTPq+PX99EuZBxHugzJZRyqvr6SDvFBwGUomJUbEW9CWBHKud2aoIFC49yeMtNxSItwCpUfpeteQWZU9l6JplVr6suvjOSoEfqFzf6OtqoTsMyRi0Bc26HikkbLpNHupHa32ZQ/EKr7qjCLsiAp1TXyv4+1otvwA0uoFpFRHTEOC2UW53aRkOsEys4PlX/ej7TaF8JqVbYpU1Fih7Gf5DgviO9y5GRAWhFdRbfyitVMek8b5TS0JQfRTEoii25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiD4SV6R1ng214ywUTENeoKfG/wx954bpWwDF7i9cg4=;
 b=XhMb5ADzzPDlz2dVNdQHYwob06wMk9WelCVd+8X40X1YsbgWzrIb2PNgtNPPvBkVLzArl7HzMzZ3kF9t7Yl3LzpNTT1pKNwBINcKe6yRx7z9aBH9NwKmOMoEkjVK9drGD3n1X99hvR0ARZloOwu3m22Q05/ZEDrqw9Bl6b52dhAMw4c+W1UNtOknVqcDoOf9BfqQ+0sxCjdrgHlbD+LncLcsm1+zK4I3LUjSzL2ys9zjAiiw9LNZ1XKtfApwa7O7wFI7NPm3FnnDWSt43C7jJ6xUYAa7vsI8gmLzGuYQI0rpIGKhpFLrbCkPOzeYs90HoSbNIwX7gSpnAjrsXKHfmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiD4SV6R1ng214ywUTENeoKfG/wx954bpWwDF7i9cg4=;
 b=X5PTFrx/rd3vbyTrVSOfpCgRRn05SDHw3ioTvm9/evwkwPXc6toeVrO9VdFx18Vc8pbqcQvc0a0JWGs9+uCFjeupOxy+yiWBM94ecHrz9LE2qJls6QkVrIWR6s9crYaCeKx7dhSmwBpQdxQh585AUlm7urY+8M+TNtlPTJGEook=
Received: from MWHPR22CA0001.namprd22.prod.outlook.com (2603:10b6:300:ef::11)
 by MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Wed, 25 Mar
 2020 14:29:58 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::91) by MWHPR22CA0001.outlook.office365.com
 (2603:10b6:300:ef::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.21 via Frontend
 Transport; Wed, 25 Mar 2020 14:29:57 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Wed, 25 Mar 2020 14:29:55 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 25 Mar
 2020 09:29:51 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 25 Mar 2020 09:29:51 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: Add mem_sync implementation for all the ASICs.
Date: Wed, 25 Mar 2020 10:29:39 -0400
Message-ID: <1585146580-27143-4-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585146580-27143-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1585146580-27143-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(428003)(46966005)(7696005)(2616005)(186003)(81156014)(81166006)(8676002)(8936002)(70586007)(82740400003)(70206006)(336012)(426003)(36756003)(26005)(4326008)(5660300002)(316002)(6916009)(44832011)(47076004)(54906003)(356004)(6666004)(86362001)(478600001)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4566; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bff97355-5dcd-4194-67cf-08d7d0c8fd26
X-MS-TrafficTypeDiagnostic: MN2PR12MB4566:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4566ECBE5384698FF20BD788EACE0@MN2PR12MB4566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0353563E2B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: apwN8oNB2RRLNqngDRqD92b02DBMKGKtk7NMd0LuhNKHXVDGirVQdHbKBIwYS4KZ4ZKgL0QvdOdK8BYvHk+tpcvdTIjvzOHFPqUR1nSjlokzDgB+B4NwMDyYacEM3hvlk28M6a6/pA0oVFYBGCLC1Bsbbeew80/yJc3C/aIid5T8v1APpmZZXiHYz7ahUmvsGvaegh3+5x+acGX643WrzUwvDsdx3zqef7p9BM642N8Bca049e4mtG0KIsqsWt81cOXKLOkfERB62Hk5Obatvdc09vybfNRqIG50lTSBluvS7+fY25ZgR0B6vBnYTCBgrjfhe85v8NgZ2cttFpBt7R0oRsRq8T3vCPXFNpVKnHEEIU/in1A0Ubqk+SDPmQcUvpoFUs3o4Hpomy+eg1zZMJc4n5N4TKgx+w8qiLteNTtbfNRlP1w4y5wSrKyE+6bff45eTiiCEQT3XlBdMMFi2PA6TXcRBqbtX9RRpAHmXKGjb95eyRgX2IE2gFonkLqXSN2Erd7vdP2ofLPkQK7AHQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 14:29:55.3764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bff97355-5dcd-4194-67cf-08d7d0c8fd26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566
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
Cc: Ken.Qiao@amd.com, Marek.Olsak@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implement the .mem_sync hook defined earlier.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 27 ++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c  | 16 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c  | 16 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  | 17 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 22 +++++++++++++++++++++-
 5 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 7f9ac1a1..d7f3177 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5236,6 +5236,29 @@ static int gfx_v10_0_kiq_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void gfx_v10_0_mem_sync(struct amdgpu_ring *ring)
+{
+	unsigned gcr_cntl = PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_INV(1) |
+			    PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_WB(1) |
+			    PACKET3_ACQUIRE_MEM_GCR_CNTL_GLM_INV(1) |
+			    PACKET3_ACQUIRE_MEM_GCR_CNTL_GLM_WB(1) |
+			    PACKET3_ACQUIRE_MEM_GCR_CNTL_GL1_INV(1) |
+			    PACKET3_ACQUIRE_MEM_GCR_CNTL_GLV_INV(1) |
+			    PACKET3_ACQUIRE_MEM_GCR_CNTL_GLK_INV(1) |
+			    /* TODO is this eqvivalent to V_586_GLI_ALL ? */
+			    PACKET3_ACQUIRE_MEM_GCR_CNTL_GLI_INV(1);
+
+	/* ACQUIRE_MEM -make one or more surfaces valid for use by the subsequent operations */
+	amdgpu_ring_write(ring, PACKET3(PACKET3_ACQUIRE_MEM, 6));
+	amdgpu_ring_write(ring, 0); /* CP_COHER_CNTL */
+	amdgpu_ring_write(ring, 0xffffffff);  /* CP_COHER_SIZE */
+	amdgpu_ring_write(ring, 0xffffff);  /* CP_COHER_SIZE_HI */
+	amdgpu_ring_write(ring, 0); /* CP_COHER_BASE */
+	amdgpu_ring_write(ring, 0);  /* CP_COHER_BASE_HI */
+	amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
+	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
+}
+
 static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
 	.name = "gfx_v10_0",
 	.early_init = gfx_v10_0_early_init,
@@ -5283,7 +5306,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 		3 + /* CNTX_CTRL */
 		5 + /* HDP_INVL */
 		8 + 8 + /* FENCE x2 */
-		2, /* SWITCH_BUFFER */
+		2 + /* SWITCH_BUFFER */
+		8, /* gfx_v10_0_mem_sync */
 	.emit_ib_size =	4, /* gfx_v10_0_ring_emit_ib_gfx */
 	.emit_ib = gfx_v10_0_ring_emit_ib_gfx,
 	.emit_fence = gfx_v10_0_ring_emit_fence,
@@ -5304,6 +5328,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
+	.mem_sync = gfx_v10_0_mem_sync,
 };
 
 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 31f44d0..ced6459 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3466,6 +3466,18 @@ static int gfx_v6_0_set_powergating_state(void *handle,
 	return 0;
 }
 
+static void gfx_v6_0_mem_sync(struct amdgpu_ring *ring)
+{
+	amdgpu_ring_write(ring, PACKET3(PACKET3_SURFACE_SYNC, 3));
+	amdgpu_ring_write(ring, PACKET3_TCL1_ACTION_ENA |
+			  PACKET3_TC_ACTION_ENA |
+			  PACKET3_SH_KCACHE_ACTION_ENA |
+			  PACKET3_SH_ICACHE_ACTION_ENA);  /* CP_COHER_CNTL */
+	amdgpu_ring_write(ring, 0xffffffff);  /* CP_COHER_SIZE */
+	amdgpu_ring_write(ring, 0);  /* CP_COHER_BASE */
+	amdgpu_ring_write(ring, 0x0000000A); /* poll interval */
+}
+
 static const struct amd_ip_funcs gfx_v6_0_ip_funcs = {
 	.name = "gfx_v6_0",
 	.early_init = gfx_v6_0_early_init,
@@ -3496,7 +3508,8 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_gfx = {
 		14 + 14 + 14 + /* gfx_v6_0_ring_emit_fence x3 for user fence, vm fence */
 		7 + 4 + /* gfx_v6_0_ring_emit_pipeline_sync */
 		SI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 6 + /* gfx_v6_0_ring_emit_vm_flush */
-		3 + 2, /* gfx_v6_ring_emit_cntxcntl including vgt flush */
+		3 + 2 + /* gfx_v6_ring_emit_cntxcntl including vgt flush */
+		5, /* SURFACE_SYNC */
 	.emit_ib_size = 6, /* gfx_v6_0_ring_emit_ib */
 	.emit_ib = gfx_v6_0_ring_emit_ib,
 	.emit_fence = gfx_v6_0_ring_emit_fence,
@@ -3507,6 +3520,7 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_gfx = {
 	.insert_nop = amdgpu_ring_insert_nop,
 	.emit_cntxcntl = gfx_v6_ring_emit_cntxcntl,
 	.emit_wreg = gfx_v6_0_ring_emit_wreg,
+	.mem_sync = gfx_v6_0_mem_sync,
 };
 
 static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_compute = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 733d398..88c54c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -5001,6 +5001,18 @@ static int gfx_v7_0_set_powergating_state(void *handle,
 	return 0;
 }
 
+static void gfx_v7_0_mem_sync(struct amdgpu_ring *ring)
+{
+	amdgpu_ring_write(ring, PACKET3(PACKET3_SURFACE_SYNC, 3));
+	amdgpu_ring_write(ring, PACKET3_TCL1_ACTION_ENA |
+			  PACKET3_TC_ACTION_ENA |
+			  PACKET3_SH_KCACHE_ACTION_ENA |
+			  PACKET3_SH_ICACHE_ACTION_ENA);  /* CP_COHER_CNTL */
+	amdgpu_ring_write(ring, 0xffffffff);  /* CP_COHER_SIZE */
+	amdgpu_ring_write(ring, 0);  /* CP_COHER_BASE */
+	amdgpu_ring_write(ring, 0x0000000A); /* poll interval */
+}
+
 static const struct amd_ip_funcs gfx_v7_0_ip_funcs = {
 	.name = "gfx_v7_0",
 	.early_init = gfx_v7_0_early_init,
@@ -5033,7 +5045,8 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
 		12 + 12 + 12 + /* gfx_v7_0_ring_emit_fence_gfx x3 for user fence, vm fence */
 		7 + 4 + /* gfx_v7_0_ring_emit_pipeline_sync */
 		CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 6 + /* gfx_v7_0_ring_emit_vm_flush */
-		3 + 4, /* gfx_v7_ring_emit_cntxcntl including vgt flush*/
+		3 + 4 + /* gfx_v7_ring_emit_cntxcntl including vgt flush*/
+		5, /* SURFACE_SYNC */
 	.emit_ib_size = 4, /* gfx_v7_0_ring_emit_ib_gfx */
 	.emit_ib = gfx_v7_0_ring_emit_ib_gfx,
 	.emit_fence = gfx_v7_0_ring_emit_fence_gfx,
@@ -5048,6 +5061,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
 	.emit_cntxcntl = gfx_v7_ring_emit_cntxcntl,
 	.emit_wreg = gfx_v7_0_ring_emit_wreg,
 	.soft_recovery = gfx_v7_0_ring_soft_recovery,
+	.mem_sync = gfx_v7_0_mem_sync,
 };
 
 static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index fc32586..0b1d3a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6815,6 +6815,19 @@ static int gfx_v8_0_sq_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void gfx_v8_0_mem_sync(struct amdgpu_ring *ring)
+{
+	amdgpu_ring_write(ring, PACKET3(PACKET3_SURFACE_SYNC, 3));
+	amdgpu_ring_write(ring, PACKET3_TCL1_ACTION_ENA |
+			  PACKET3_TC_ACTION_ENA |
+			  PACKET3_SH_KCACHE_ACTION_ENA |
+			  PACKET3_SH_ICACHE_ACTION_ENA |
+			  PACKET3_TC_WB_ACTION_ENA);  /* CP_COHER_CNTL */
+	amdgpu_ring_write(ring, 0xffffffff);  /* CP_COHER_SIZE */
+	amdgpu_ring_write(ring, 0);  /* CP_COHER_BASE */
+	amdgpu_ring_write(ring, 0x0000000A); /* poll interval */
+}
+
 static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
 	.name = "gfx_v8_0",
 	.early_init = gfx_v8_0_early_init,
@@ -6861,7 +6874,8 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_gfx = {
 		3 + /* CNTX_CTRL */
 		5 + /* HDP_INVL */
 		12 + 12 + /* FENCE x2 */
-		2, /* SWITCH_BUFFER */
+		2 + /* SWITCH_BUFFER */
+		5, /* SURFACE_SYNC */
 	.emit_ib_size =	4, /* gfx_v8_0_ring_emit_ib_gfx */
 	.emit_ib = gfx_v8_0_ring_emit_ib_gfx,
 	.emit_fence = gfx_v8_0_ring_emit_fence_gfx,
@@ -6879,6 +6893,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_gfx = {
 	.patch_cond_exec = gfx_v8_0_ring_emit_patch_cond_exec,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
 	.soft_recovery = gfx_v8_0_ring_soft_recovery,
+	.mem_sync = gfx_v8_0_mem_sync,
 };
 
 static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index fb567cf..f851e80 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -6613,6 +6613,24 @@ static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void gfx_v9_0_mem_sync(struct amdgpu_ring *ring)
+{
+	unsigned cp_coher_cntl = PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_ICACHE_ACTION_ENA(1) |
+				 PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_KCACHE_ACTION_ENA(1) |
+				 PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_ACTION_ENA(1) |
+				 PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TCL1_ACTION_ENA(1) |
+				 PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_WB_ACTION_ENA(1);
+
+	/* ACQUIRE_MEM -make one or more surfaces valid for use by the subsequent operations */
+	amdgpu_ring_write(ring, PACKET3(PACKET3_ACQUIRE_MEM, 5));
+	amdgpu_ring_write(ring, cp_coher_cntl); /* CP_COHER_CNTL */
+	amdgpu_ring_write(ring, 0xffffffff);  /* CP_COHER_SIZE */
+	amdgpu_ring_write(ring, 0xffffff);  /* CP_COHER_SIZE_HI */
+	amdgpu_ring_write(ring, 0); /* CP_COHER_BASE */
+	amdgpu_ring_write(ring, 0);  /* CP_COHER_BASE_HI */
+	amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
+}
+
 static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
 	.name = "gfx_v9_0",
 	.early_init = gfx_v9_0_early_init,
@@ -6659,7 +6677,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 		3 + /* CNTX_CTRL */
 		5 + /* HDP_INVL */
 		8 + 8 + /* FENCE x2 */
-		2, /* SWITCH_BUFFER */
+		2 + /* SWITCH_BUFFER */
+		7, /* gfx_v9_0_mem_sync */
 	.emit_ib_size =	4, /* gfx_v9_0_ring_emit_ib_gfx */
 	.emit_ib = gfx_v9_0_ring_emit_ib_gfx,
 	.emit_fence = gfx_v9_0_ring_emit_fence,
@@ -6680,6 +6699,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v9_0_ring_soft_recovery,
+	.mem_sync = gfx_v9_0_mem_sync,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
