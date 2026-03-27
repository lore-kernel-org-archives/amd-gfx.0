Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D3010AB836
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 01:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDBEE10EC34;
	Fri, 27 Mar 2026 01:04:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mj+u/eqL";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7FAC10EC34
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 01:04:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIcW00nNtxMd5Wootxw4Y+3ngCA/EJa+fW2Vc8ndUKz2nbiRYepzW0G53rIQNuCEcsjRj0bWVx6JuLamd0IkPqkrA2qEzW3FHyCfsEQ1Kdim6XgsAxv+EccgELAE5Ho4sBLYZLAUDxffVFdXlj6zNl4DXNo5tUPtGY8MVl5BXZ2s6W5zjHO0KS8ZPrkuEfjddoVeCgMm1fm54EeXKIOj3AyUzXbpfLHcie4Typ4wP7n8ZHTX7Ya7lDQS5RcyzBxmIlUYEchi6ELKYePU8S1N+VCQ1lhpj9HkpuKdF8JQKe19Qc3zkUZgNL20KF7F9dS2f6SuW83Q0vVkSLKA5xgGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++p7/7rJVSVejCh/w45d7AXCJi63Jdi4JCJlUlQviJs=;
 b=WpPWZpyr5zdNxDo9Ic4cfc+wcLyQdP6d0RvcFuGPQjLwlEYAfyoFS+Dsmt+tZHoajIIuVNdA96mKRFdVJLOIGH3goP8O0zOeM8+KMl98fB+gBXCEERkExLG0zM7B4an22mKWehrbgnMxP/eim99TdZ0gZaOMKJR8v5gacSYzVYrTF8g9b/4HQoveayi7L++935EAAWiXUuQCL10xiDzADbBrbwMEPz2ctf4plcoqRy+hTZkL15DkfptaOyF/M9RXE25+QWY3OvjgATG48B3Y7GcLTJqtLCEtFZHFJAdYpfn1R4el9QJnzFTurK8OcYPBn2AR8rEfxbj/YG5KLk162A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++p7/7rJVSVejCh/w45d7AXCJi63Jdi4JCJlUlQviJs=;
 b=Mj+u/eqLpmwGwtxG3Jo+gxkwM+KLvM4bgN2XEKiScNH6vMgo99OrXGPifJv+oXbH7kBcYHz6Wa6mxVhNhBUzvm+jiIVXxvFuhu+Day06T2o+pp/usl3sWVrzeb/wsRxZ94b+85EQEO379SLSGkJwrqit5mK+t4xYCqnTWXTiOmg=
Received: from SJ0PR03CA0096.namprd03.prod.outlook.com (2603:10b6:a03:333::11)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 01:04:05 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::74) by SJ0PR03CA0096.outlook.office365.com
 (2603:10b6:a03:333::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Fri,
 27 Mar 2026 01:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 01:04:04 +0000
Received: from lang-cezanne.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 20:04:03 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Mukul Joshi <mukul.joshi@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH] drm/amdkfd: Switch to dev_* printk stuff in
 kfd_int_process_v12_1.c
Date: Fri, 27 Mar 2026 09:03:48 +0800
Message-ID: <20260327010348.38134-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|DM6PR12MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c3c77ca-05e1-4ae9-11d4-08de8b9cbdb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 0XAjQyWUVNMe96VLr/pv5j4PVjBXeD0tj3xr44lsDAM2DezHVPYFTJ6+owOT80yi1DMTm13D64FQbtLArEpcsvQGcZdNu4bqgn+RkmebSpXkDELyQRAGFU5cSL2ejEtnh5rs/s3VHMkQv9hS8z1coKndrlVBCOkUAtYJrcGzodF5yYeXYDaFwv4ClQujLqRUmYAPhQRkeVqiPO/287VHDXT4DGOhiHH/NwBHFZM/erNTfFN2XFYmecIu6hqyemtzDXAYp6McUb1T6NWM+s1x9vQeAGbJBMFM0VZZB2mIHTXV9AJOx3YEwuiWZHqi7PIo2vUjtFwOoK/yTNUj3bD41gSS+Xy8pzOfydgQTg7zwY8sCFm5GH81vIg4h0FjyNnvetutn6O5nqO+iZoIsvh2sxCVyF7619PSi9PdEwm8/GY0m8VutD9VHspqErUqYxLQ7AZwEL7EiQNxjIHrSwT2A74lwroW0zMSJR8o1G3NdtzYtm8c36EvFmRLLW/F4Q7hqS8xzZlHQnff6ypqJ5vjPDrc9MkBMvn7+zEuVjH/RnDgM2p0OWQgGioVEO1wLdTxvi66tzqXoc0ROg8tTVHz50ekAloi0lncVxSW0td9WFwVvW3SBLGs5VaLnj7tWCkyuICpNXw15XeJSiZurfACTfvaXERh5Qk/Elepx984FrKXcathOkBBPZiUBhNZutwL7JAyI/Lud7K2rlO3axQLBm653ZUenYyEhX2foBl2r9sNk8xe1i1+O1mM8YsLO1bihq59hbL6tXpiuVVjRDFH0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OyHI+AgRU3667EiG7P4bmzvuwehIwd6dxm9eZ2S7rt2uZrwvkAIkRtpSzdzV/Uq237wKH2MYlIAMyArjmUTEIgFQr/0CnSjqzwddDqYVVscsKdfAnVPpZAbJ7Vis5MQKaVfxkgmSP0wBXrlMIIeDQXuC5+bkm2LeZnIj3wwGjTXjM7jq/W898i0IR89r6+Xa3qZrjOnxAosU8mGGNvbxUTfwV71itfe0gtxnKeAjT4d0zXHmQHzoxodgXZwZw2sk6ReuIgIGT4qUk9XT6dcELUFWTOk3no8VZe5CsbxUf1Ho97Y6Gc/Shu0/jUsGhcRmpg9f21ZphohnjUbgg/+29NLbe+jHEvJPtspOMLfkz11hwBDn8dmfee5vEVfarceoDxYbsGiV4kzKRZ8APstz2r8TmwPAYoovqSGpvlrULn8I276QXJr7oGoYRmyH78QP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 01:04:04.6546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3c77ca-05e1-4ae9-11d4-08de8b9cbdb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
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

dev_* printk stuff is multi-GPU friendly.

Use dev_warn_ratelimited() for print_sq_intr_info_error() which is
consistent with previous IPs.

Use dev_dbg_ratelimited() for irrelevant node interrupt print to
avoid too much noise.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 .../drm/amd/amdkfd/kfd_int_process_v12_1.c    | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
index 47947b94926b..0da7e1db55c9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
@@ -144,9 +144,10 @@ enum SQ_INTERRUPT_ERROR_TYPE {
 #define KFD_CTXID0_DOORBELL_ID(ctxid0)		((ctxid0) & \
 				KFD_CTXID0_DOORBELL_ID_MASK)
 
-static void print_sq_intr_info_auto(uint32_t context_id0, uint32_t context_id1)
+static void print_sq_intr_info_auto(struct kfd_node *dev, uint32_t context_id0, uint32_t context_id1)
 {
-	pr_debug_ratelimited(
+	dev_dbg_ratelimited(
+		dev->adev->dev,
 		"sq_intr: auto, ttrace %d, wlt %d, ttrace_buf0_full %d, ttrace_buf1_full %d ttrace_utc_err %d\n",
 		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, THREAD_TRACE),
 		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, WLT),
@@ -155,9 +156,10 @@ static void print_sq_intr_info_auto(uint32_t context_id0, uint32_t context_id1)
 		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, THREAD_TRACE_UTC_ERROR));
 }
 
-static void print_sq_intr_info_inst(uint32_t context_id0, uint32_t context_id1)
+static void print_sq_intr_info_inst(struct kfd_node *dev, uint32_t context_id0, uint32_t context_id1)
 {
-	pr_debug_ratelimited(
+	dev_dbg_ratelimited(
+		dev->adev->dev,
 		"sq_intr: inst, data 0x%08x, sh %d, priv %d, wave_id %d, simd_id %d, wgp_id %d\n",
 		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0, DATA),
 		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0, SA_ID),
@@ -167,9 +169,10 @@ static void print_sq_intr_info_inst(uint32_t context_id0, uint32_t context_id1)
 		REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1, WGP_ID));
 }
 
-static void print_sq_intr_info_error(uint32_t context_id0, uint32_t context_id1)
+static void print_sq_intr_info_error(struct kfd_node *dev, uint32_t context_id0, uint32_t context_id1)
 {
-	pr_debug_ratelimited(
+	dev_warn_ratelimited(
+		dev->adev->dev,
 		"sq_intr: error, detail 0x%08x, type %d, sh %d, priv %d, wave_id %d, simd_id %d, wgp_id %d\n",
 		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, DETAIL),
 		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, TYPE),
@@ -246,7 +249,8 @@ static bool event_interrupt_isr_v12_1(struct kfd_node *node,
 	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
 
 	if (!kfd_irq_is_from_node(node, node_id, vmid)) {
-		pr_debug("Interrupt not for Node, node_id: %d, vmid: %d\n", node_id, vmid);
+		dev_dbg_ratelimited(node->adev->dev,
+			"Interrupt not for Node, node_id: %d, vmid: %d\n", node_id, vmid);
 		return false;
 	}
 
@@ -266,9 +270,9 @@ static bool event_interrupt_isr_v12_1(struct kfd_node *node,
 	    (context_id0 & AMDGPU_FENCE_MES_QUEUE_FLAG))
 		return false;
 
-	pr_debug("client id 0x%x, source id %d, vmid %d, pasid 0x%x. raw data:\n",
+	dev_dbg(node->adev->dev, "client id 0x%x, source id %d, vmid %d, pasid 0x%x. raw data:\n",
 		 client_id, source_id, vmid, pasid);
-	pr_debug("%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X.\n",
+	dev_dbg(node->adev->dev, "%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X.\n",
 		 data[0], data[1], data[2], data[3],
 		 data[4], data[5], data[6], data[7]);
 
@@ -361,10 +365,10 @@ static void event_interrupt_wq_v12_1(struct kfd_node *node,
 					SQ_INTERRUPT_WORD_WAVE_CTXID1, ENCODING);
 			switch (sq_int_enc) {
 			case SQ_INTERRUPT_WORD_ENCODING_AUTO:
-				print_sq_intr_info_auto(context_id0, context_id1);
+				print_sq_intr_info_auto(node, context_id0, context_id1);
 				break;
 			case SQ_INTERRUPT_WORD_ENCODING_INST:
-				print_sq_intr_info_inst(context_id0, context_id1);
+				print_sq_intr_info_inst(node, context_id0, context_id1);
 				sq_int_priv = REG_GET_FIELD(context_id0,
 						SQ_INTERRUPT_WORD_WAVE_CTXID0, PRIV);
 				if (sq_int_priv && (kfd_set_dbg_ev_from_interrupt(node, pasid,
@@ -374,7 +378,7 @@ static void event_interrupt_wq_v12_1(struct kfd_node *node,
 					return;
 				break;
 			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
-				print_sq_intr_info_error(context_id0, context_id1);
+				print_sq_intr_info_error(node, context_id0, context_id1);
 				sq_int_errtype = REG_GET_FIELD(context_id0,
 						SQ_INTERRUPT_WORD_ERROR_CTXID0, TYPE);
 				if (sq_int_errtype != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
-- 
2.34.1

