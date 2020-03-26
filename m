Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE0AC43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 20:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1DFA206E6
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 20:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WrVRixxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DFA206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A17C46E920;
	Thu, 26 Mar 2020 20:03:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28F486E920
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 20:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRpdXz0CBiGM4ta/kF39Ghe7YyiLtHQyCW73B/PjP6nv4Ef8aiw9VOipS1akfw49U7KvFOTN79IuuoqPMmDN2He3pp8jp8FeoFca23pNLGguN9ij31eK6VPDszVI9m16vn7GJmJJD+5a83e06Z8y7n1C4b9Op3ZVGmSEDjdMrcx3atNa7xmyXjL1JFYrhIIDxypw/Y6oKfYzN+t6I//V2hgefD87/S87gbqgFhqrOP5gAG+uzDSM6t6Ef1gPAr4IdF5kXo3DEXwaHsevEF0LkmnvnhyFqMTMHL9vByLeBd7K4PwSbvPsmfA9SGWXyXn6dyFEffasSNeC/yQbdyjiUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/bv+lRddIAfwUR30Qg1SM9px8+t2oV0nrplcWC13ig=;
 b=lQUCbrv5CU+L/eBFTtRHSjokOjjD7rQtXXFw/eI2ZPb1ImHArVO+aZxViba5qLWzynUUEpiuaz8zlAsi17lkybaYZHWEn5efejvcJXVEXrzfcfXstnXgpw27M0aKCioJsXY4KHl+CgmS9t6JCdkUxcYy2uAY3LHE3Daky3H+BeAZpPgTL0Xea9QkpBd7oG2gdNnbuOvmMQoZTq57frdJszkHAVNd5XJoToiKAiJm7RyRppUEmr4IBm/uHOAMFZ0OSsPNYkxcoo1aLKhlzF0mMs1j3KwVBK4JbhCwev2Z8Pcyp5yDp/mpjB61LKhCdGJXy+WAWEUlsbDnwTEKyXCGQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/bv+lRddIAfwUR30Qg1SM9px8+t2oV0nrplcWC13ig=;
 b=WrVRixxfH2Tb2eoopcarkTvICrJsSY15INNwX6OTBMR0sOscOJw3R6jzkru8jlGSEQT5uKdr+up14/PENaQdTkOYdBENthKNuxpdq+BvRu9zwUBOa4i0lxfHsAqQOqXLtE0SRxtdbaW5ICR85GnUSjMyLer/1JD7v/RaIjs/LE0=
Received: from MWHPR15CA0042.namprd15.prod.outlook.com (2603:10b6:300:ad::28)
 by CH2PR12MB3799.namprd12.prod.outlook.com (2603:10b6:610:21::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Thu, 26 Mar
 2020 20:03:07 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::94) by MWHPR15CA0042.outlook.office365.com
 (2603:10b6:300:ad::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend
 Transport; Thu, 26 Mar 2020 20:03:07 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2856.19 via Frontend Transport; Thu, 26 Mar 2020 20:03:07 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 26 Mar
 2020 15:03:02 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 26 Mar 2020 15:03:01 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/4] drm/amdgpu: Add mem_sync implementation for all the
 ASICs.
Date: Thu, 26 Mar 2020 16:02:47 -0400
Message-ID: <1585252968-1218-4-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585252968-1218-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1585252968-1218-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(428003)(46966005)(36756003)(86362001)(356004)(6666004)(5660300002)(4326008)(426003)(44832011)(54906003)(47076004)(82740400003)(2616005)(336012)(8936002)(8676002)(2906002)(186003)(81166006)(26005)(478600001)(316002)(70206006)(70586007)(6916009)(7696005)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3799; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 531ff887-9718-4932-8aed-08d7d1c0b3a8
X-MS-TrafficTypeDiagnostic: CH2PR12MB3799:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3799812A989481D4982EE787EACF0@CH2PR12MB3799.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0354B4BED2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JNa6rpAopdlMFv/wD4l9SWdwLcPuD12lwD57IOj1n8mWp9SInn8hIWKpxt17UC/ATlszK59CAk54w/GS/FaL+OOeEFv3W8wrQlwWEQ5ZDYQEFNmupQtd+U600QF26qZppTXsOxCd01N/1Qm+vLPhnlvcHvM2XN54sCYEcG4G56x0a2CkZiTTCTA0ceI55ckAyp3o9isDqGpgdyTxsRIzV2HgfOBTcT9J3dSpyrs46gALwdZeteKelxgqQWOm4gaGu/NF1Q8ih3mnL+oHHO8jiyAHAJqTwaGv16dLW6zMDfngSJokOf35SlSATEqH7sBjNWPFn7ihU+3nmKlpXN45+t4i/Y5Bc/rMsH7q0Nfl9V8+inXZndWRDpqs6dQfbAxrVfQdg/ifDu/0HxA1NwdN6GLRXjQisjKsC6ajAf7YVjmmNwzDLEMp9XgNnjCpwUplmOHSqyruLuUFVbCj/DxwrnXuCK+RFOlNBQLmqyCg4/uZDvG5hfaqSMMCEbGEvJW0l5o+zJyoz9KfhhxPyHs9Pw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 20:03:07.2578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 531ff887-9718-4932-8aed-08d7d1c0b3a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3799
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 ckoenig.leichtzumerken@gmail.com, Marek.Olsak@amd.com, Ken.Qiao@amd.com,
 luben.tuikov@amd.com, alexdeucher@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implement the .mem_sync hook defined earlier.

v2: Rename functions

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 27 ++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c  | 16 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c  | 16 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  | 17 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 22 +++++++++++++++++++++-
 5 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 91c8238..974f1b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5236,6 +5236,29 @@ static int gfx_v10_0_kiq_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
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
+		8, /* gfx_v10_0_emit_mem_sync */
 	.emit_ib_size =	4, /* gfx_v10_0_ring_emit_ib_gfx */
 	.emit_ib = gfx_v10_0_ring_emit_ib_gfx,
 	.emit_fence = gfx_v10_0_ring_emit_fence,
@@ -5304,6 +5328,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
+	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 };
 
 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 31f44d0..07917f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3466,6 +3466,18 @@ static int gfx_v6_0_set_powergating_state(void *handle,
 	return 0;
 }
 
+static void gfx_v6_0_emit_mem_sync(struct amdgpu_ring *ring)
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
+	.emit_mem_sync = gfx_v6_0_emit_mem_sync,
 };
 
 static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_compute = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 733d398..6f52b16f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -5001,6 +5001,18 @@ static int gfx_v7_0_set_powergating_state(void *handle,
 	return 0;
 }
 
+static void gfx_v7_0_emit_mem_sync(struct amdgpu_ring *ring)
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
+	.emit_mem_sync = gfx_v7_0_emit_mem_sync,
 };
 
 static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index fc32586..5e95326 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6815,6 +6815,19 @@ static int gfx_v8_0_sq_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void gfx_v8_0_emit_mem_sync(struct amdgpu_ring *ring)
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
+	.emit_mem_sync = gfx_v8_0_emit_mem_sync,
 };
 
 static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 01b22da..a2855d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -6613,6 +6613,24 @@ static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring)
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
+		7, /* gfx_v9_0_emit_mem_sync */
 	.emit_ib_size =	4, /* gfx_v9_0_ring_emit_ib_gfx */
 	.emit_ib = gfx_v9_0_ring_emit_ib_gfx,
 	.emit_fence = gfx_v9_0_ring_emit_fence,
@@ -6680,6 +6699,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v9_0_ring_soft_recovery,
+	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
