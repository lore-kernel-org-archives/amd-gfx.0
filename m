Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825A1C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2126010F48B;
	Fri, 21 Aug 2026 19:53:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ae1ne7uf";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AB8E10F48B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v832HMIUlcAOoxSh7B9ha4C+q7TAG9+OkAYDdLOnjNyqHYB6Fe/uwGgW54usopWuHwnb/804NUzT+HwfXoYmucRxGaxn4ddOBBj4A5ulSn/klmahB6HydE5WgU8SCrioD8FtrhWhz0qRpa7W+BG5ua07lajsWBy1Y7nEXCQ8rPFTU235bo9QBE7NxT93om/YKnErji5U9+iPJ+cp11fCw1c2JzHCoecNy7/5C/K0D9bxLfZd5AZ4x9WgHRcRfJelOaHYM+uI6mc/JXAMU45uVzMlzU1WpPZGKyRQ2kd3YFz/GSDMQAtFQE5dTCDHzDpDKF6Ppc7NZRPQA4PxK2kWxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oixp2AZxGkbISdAA8jWvknFtBwxfk9GjlmqubCc0TUg=;
 b=CgJKpeWsaOU34OBg4pzwN9r+cill6IR8yJHvzyDq8JtfaqayrrlbhkbH0955nMPNJpklJobOmlApkpKe1RACY5cQo1cqGQDqC2XsgLoGEmLs9fVJHFXVvu8tyod2rB22usAK60sRYtZ+7zzpGJZ+v6xwJlkdruBFdm9MBZ81VZ8yM4sNfJWwjxLFpfQWbi5tAB7GUkCy3Yy0PMqIOTU6FPjXdaNkKhThqY+xoJz9TyNKZJoPlspWfWy78N+2AskyvByeXxo0ATLfEjirwcT2AbXRSeF38tuC1AIMTXDku9AKDd+/CnhT15ORU/bOYQG3CpxnBGI7dlfnfH4jO3/CuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oixp2AZxGkbISdAA8jWvknFtBwxfk9GjlmqubCc0TUg=;
 b=Ae1ne7ufVl8lvv4SZGOLxvYeOzVceRVYcBTq9BicZMbVJs1qtOt+odeDJsgWlI0mhJnfz7WMNeJ+MpsTQZaRnwQjqdzcQkOnrxISgoS59ERHS/3o8N2T6ijqE5Llyk+HbUiuAwbkXlu/r6hR1/2rY2BCcGACwP2cLKUMp3/TCGk=
Received: from CH0PR04CA0005.namprd04.prod.outlook.com (2603:10b6:610:76::10)
 by SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:36:15 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::97) by CH0PR04CA0005.outlook.office365.com
 (2603:10b6:610:76::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:09 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:36:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 94/95] drm/amdgpu: add mtype_remote module parameter
Date: Fri, 21 Aug 2026 15:34:57 -0400
Message-ID: <20260821193458.808626-95-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 2885f8a1-92c8-47de-598d-08deffbb76dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|56012099006|3023799007|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ubyw/7/xm7V0Y+8REe8BvtCeoa/rUEEM8HlUyH+16AnYZwJOOl0oZPgP9NP4OIw1C+xlVd1pFy0FVD+Q+awwmOpGk5mtw/m6MGdEMfWlyKPsQ+1nPlvPlN9Ien5wHHjRTVqMjYNA9HG9Y9A9B6wFuxnZci5hjgkGw3bd0MI7drXl1aeQlDM8j5XAFBte9dUQag8LH9x7gGbz/RjbNWhdZrj8x35HBUF1TEwGouZczuU2DZFgNVIJljq7EKmXeD19iqul7PvAUgqyLoKojWMg/cGGHjWKJ4kneFkybW8Vxh/nMBpvcLmsHfG+1BY5qNJ5MQ+tU+IjfMZt8DoJgc3Sl6n5l4/OPGuue/lOEMMS1UxouDzBJSQp4B2mkiRN1nDlFS6Siy/H4jsOBGVwoypcyvWnZDvAwUOr4xch8UUX7qtQxQk4f8Cce3Gc4M5/FFA3LLMlz00r/xGrsLJdzL096Gwey3hy7g4KsMGAroMUKQtC+nksdcWbfYYtnP8yqaCZobTs8VuJmgCCqJvNtoAAi2xt4imeCYHneQc7IqoDhi9gtdMPVozFSJdQeFKyFNy4lKMUnqpElwwwHv4UtNUZBy1fTMBAHu0qpdl9Hqu4kW717Y63bDvUC6uHXCM5WmXqVB9c7LhsSw5xHh/3jud+w/LYIrodIzC9rE6ztCqUJVSc3m6TzERUdV3SlWc7QpJ0geAp0dx44JYW140pUgB+dQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(56012099006)(3023799007)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5kriL+hYtNjXqijzH6NkDqo/c0YtYoX2nr7i3p5fIH+DNlrYoSN44FKT6S61rtzsghVFWM4OMj6fa8xO3vb8Wr9Y/6OmyUkf0bgLwKX1gaVlXCmMjn1zrXmUpVchbUzofK6Wq67Zo4Rc4hMMlWARejiNkhvmHQM2UwAk85SjfTJRJubiveCO22RRdtSlCxKr+zKJWQ7r51583R+y34JMx2kh3Sb27UdgBDub/4qyWh+VDhsiFD0PKHDpTmDGaMAQe6DYnNdbmWE7/ZKud35AJc0VfHta+1m6JezRRVZAf+C2Rk/KDhKlS40L5JcOepssJncDXmo5khyQRuCWQFFwa69y6GmhJhj2Lm5uIqXoldW66uMB07D6Dt5Di8ACVpMt1mzq4KD4bhTZTTriu+lF8l6GgbAn+1C2ICrPIRD2NZXkJW6Tj3p1shwLph2Gx7RL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:15.0761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2885f8a1-92c8-47de-598d-08deffbb76dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

Add an amdgpu_mtype_remote module parameter so the MTYPE used for remote
memory accesses can be overridden. For now only MTYPE_NC and MTYPE_UC
are selectable (0 = MTYPE_NC, 1 = MTYPE_UC); it defaults to the
ASIC-dependent value. Currently, it is used only for GFX 12.1.

The MTYPEs resolved for both local and remote memory are logged once.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  7 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c  | 34 +++++++++++++------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |  8 ++++--
 4 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f619d95a5ccfe..79b69d74eb2e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -223,6 +223,7 @@ extern int amdgpu_force_asic_type;
 extern int amdgpu_smartshift_bias;
 extern int amdgpu_use_xgmi_p2p;
 extern int amdgpu_mtype_local;
+extern int amdgpu_mtype_remote;
 extern int amdgpu_enforce_isolation;
 extern uint amdgpu_debug_mask;
 #ifdef CONFIG_HSA_AMD
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 53738b40c97f6..04b21e456fbc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -844,6 +844,13 @@ int amdgpu_mtype_local = -1;
 MODULE_PARM_DESC(mtype_local, "MTYPE for local memory (default: ASIC dependent, 0 = MTYPE_RW, 1 = MTYPE_NC, 2 = MTYPE_CC)");
 module_param_named_unsafe(mtype_local, amdgpu_mtype_local, int, 0444);
 
+/**
+ * DOC: mtype_remote (int)
+ */
+int amdgpu_mtype_remote = -1;
+MODULE_PARM_DESC(mtype_remote, "MTYPE for remote memory (default: ASIC dependent, 0 = MTYPE_NC, 1 = MTYPE_UC)");
+module_param_named_unsafe(mtype_remote, amdgpu_mtype_remote, int, 0444);
+
 /**
  * DOC: pcie_p2p (bool)
  * Enable PCIe P2P (requires large-BAR). Default value: true (on)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index a3b7e240abaed..4e7b6e2c87ab5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -618,8 +618,8 @@ static void gmc_v12_1_get_npa_flags(struct amdgpu_device *adev,
 
 /*
  * Resolve the MTYPEs used for local and remote memory accesses on GFX 12.1.
- * Remote memory always uses MTYPE_UC; local memory depends on the AID stepping
- * and the amdgpu_mtype_local module parameter.
+ * Both default to an ASIC-dependent value that can be overridden through the
+ * amdgpu_mtype_local and amdgpu_mtype_remote module parameters.
  */
 static void gmc_v12_1_get_mtypes(struct amdgpu_device *adev,
 				 unsigned int *mtype_local,
@@ -627,23 +627,25 @@ static void gmc_v12_1_get_mtypes(struct amdgpu_device *adev,
 {
 	bool is_aid_a1 = (adev->rev_id & 0x10);
 
+	/* Local memory: ASIC default depends on the AID stepping. */
 	*mtype_local = is_aid_a1 ? MTYPE_RW : MTYPE_NC;
-	/* Remote memory always uses MTYPE_UC on GFX 12.1. */
-	*mtype_remote = MTYPE_UC;
-
-	if (amdgpu_mtype_local == 0) {
-		DRM_INFO_ONCE("Using MTYPE_RW for local memory\n");
+	if (amdgpu_mtype_local == 0)
 		*mtype_local = MTYPE_RW;
-	} else if (amdgpu_mtype_local == 1) {
-		DRM_INFO_ONCE("Using MTYPE_NC for local memory\n");
+	else if (amdgpu_mtype_local == 1)
 		*mtype_local = MTYPE_NC;
-	} else if (amdgpu_mtype_local == 2) {
-		DRM_INFO_ONCE("MTYPE_CC not supported, using %s for local memory\n",
-			      is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC");
-	} else {
-		DRM_INFO_ONCE("Using %s for local memory and MTYPE_UC for remote memory\n",
-			      is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC");
-	}
+	else if (amdgpu_mtype_local == 2)
+		DRM_INFO_ONCE("MTYPE_CC not supported for local memory\n");
+
+	/* Remote memory defaults to MTYPE_UC on GFX 12.1. */
+	*mtype_remote = MTYPE_UC;
+	if (amdgpu_mtype_remote == 0)
+		*mtype_remote = MTYPE_NC;
+	else if (amdgpu_mtype_remote == 1)
+		*mtype_remote = MTYPE_UC;
+
+	DRM_INFO_ONCE("Using %s for local memory and %s for remote memory\n",
+		      *mtype_local == MTYPE_RW ? "MTYPE_RW" : "MTYPE_NC",
+		      *mtype_remote == MTYPE_NC ? "MTYPE_NC" : "MTYPE_UC");
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 64fb38400bd1a..c521ec07bf3c0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1348,8 +1348,12 @@ svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 		mtype_local = amdgpu_mtype_local == 0 ? AMDGPU_VM_MTYPE_RW :
 				amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
 				is_aid_a1 ? AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_NC;
-		/* Remote memory always uses MTYPE_UC on GFX 12.1. */
-		mtype_remote = AMDGPU_VM_MTYPE_UC;
+		/* Remote memory defaults to MTYPE_UC on GFX 12.1 and can be
+		 * overridden through the amdgpu_mtype_remote module parameter
+		 * (0 = MTYPE_NC, 1 = MTYPE_UC).
+		 */
+		mtype_remote = amdgpu_mtype_remote == 0 ? AMDGPU_VM_MTYPE_NC :
+				AMDGPU_VM_MTYPE_UC;
 		snoop = true;
 
 		if (is_local) /* local HBM  */ {
-- 
2.55.0

