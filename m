Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBBFC28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 05:04:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A04910E047;
	Thu, 20 Mar 2025 05:04:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LEdPNuX2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C095D10E384
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 05:04:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2wL4pMLIczHofWdN9/r4LTbM57OqAV3BA19ZAwDcOVvZGDJuXbrlG7ldxl6PEEuKfix+vn2EwFYxtXKc3XllKW9jL6FMehJ9ApQKx6b34fnKF+G278OUJp1pRKor3bfZmc8zuHmnWyMggq0EKKuJoyo2EQQop+7Vj9ueDsCpy9ZeqF71dH/Anyyk8O7UV02ghQoSD+retZ62YTiQ6qlfhHzwWkEGbRhcO6ZXpX+3EV0XJsgJSIhy0bnZnFbNfPR68Qy31O+bdJAQFI06CtddRbAq42rZUIB/RD3bbS58cB7em9A18SGj8UST4oD+3TwnsKgJYOYss39BPiGvEirFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+VRSUAK8HnpAHRSHQRL9TnY5JfQjoWyBvD/5kHu9G8=;
 b=c/Gxk8lYAaCPBNpEjohiDbfotvMJQf1ttuubY+tsUHTITUOSepyZ39Rg1rbQUNRBJYnpk0Z8QQ2fFX42hg91SFIDBI1zXjnpUY+xfzIUfQHVu8FZcJe0SY9qyzI3jhj1Kzo7S4hB9rRPAplvtQBQanrlPmBv79abW/xy5PQO+IRNl++pEfLPHwJ47VaxZxaMx9JBbL7yRsahowGLxHbpZZLwBmhsnFWGETAZ7ihVfPvQ58NsTmThV/Xm0dV8SrXwBY/I7DUmZsK3zEI8q1Kp21chWxfRtWLurxrMuiE3Bjz7Jzc6igDWHU0XqrXxM6klbWIt69jepIiFvnGNS4KyPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+VRSUAK8HnpAHRSHQRL9TnY5JfQjoWyBvD/5kHu9G8=;
 b=LEdPNuX2+hZMg3TUfdpFackEQvDJ41TfnShtE8EuvSA2JlpyAdU69ByZFFvkSiAz/hJjNkiCarsKy3ncTu6Ge6GH3sOSqeGm4fredhcWwiBOGz8XT/XYnUz2ZqBsVMsdmf3u/mNHINNKxJcSiqXbrPZwmn8lnCoUaez3+4EM9pY=
Received: from SJ0PR03CA0133.namprd03.prod.outlook.com (2603:10b6:a03:33c::18)
 by SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 05:04:23 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::64) by SJ0PR03CA0133.outlook.office365.com
 (2603:10b6:a03:33c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.35 via Frontend Transport; Thu,
 20 Mar 2025 05:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 05:04:22 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 00:04:20 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdkfd: Use dev_* instead of pr_* for messages
Date: Thu, 20 Mar 2025 10:34:04 +0530
Message-ID: <20250320050404.362969-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: b4df1b1d-7a8d-4d5b-ebb6-08dd676cae00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E250cvJhYPzkQNtVnGu9Wp8OdLYkYbEVjp/e8zHFdVL3t0Q0jrnJQXGIZX+2?=
 =?us-ascii?Q?6o1l3l8ywYDK+PsE5d73h57BANkj779nBp6X8C9/aGzTkn9usXBFkZvF0mTJ?=
 =?us-ascii?Q?aANWF2tdj6ssjlJVnAo+glVihjefYsvsOmOFmhU4elw1lWnTCuk+1avJk9FP?=
 =?us-ascii?Q?lrzaPSgHh/xa2sY9tFJfzLVA/bOL5g4lvIJRh0j/ENKCFmmhZ0uNAKbkjQV/?=
 =?us-ascii?Q?mXvUGzT6j2vPs7HVROn9vsmCKuGgtecCfGG1LA5EUGhIaeQANfIHE+Kp40jn?=
 =?us-ascii?Q?6qiK6judhQ+GwL44tlD1GqLLeXNs2ag6xSgtW8BtMsbbs29y62M4MT4/utDB?=
 =?us-ascii?Q?sCI58c0i/vX0D4I1SR9AeIgRCahuCxjJmk1Bfui7yA4ai9CeQUoFOvJwFr7T?=
 =?us-ascii?Q?Yly5PfxoGjdjtTLhwvMXR1UrafCDfcnQqKPVMiq4CsZ5BlBnkVA2N8Zm7o6t?=
 =?us-ascii?Q?StPWtJMKVGRfZvTRQbkSQCU8PkHp2J06MOCO4aHQSGOpSgw0b/6cezdbpcPn?=
 =?us-ascii?Q?dQ3Dk9chsxlVyP3QSj5Py6Ly+WYC+RZa5i4kQIJi34SaHumc3KI7l/ma+fRU?=
 =?us-ascii?Q?gSbIreBcfApfN+ULjG5X115RnKO7e6X2PxR4IC8UrZfmUAYAONe3bvHxtyAn?=
 =?us-ascii?Q?YMle7bHgWtv1hWVU4R0r2ZI7ZeSOEiYKbMhhW7HTaFj7TrxmCzbqsX9zQ1sh?=
 =?us-ascii?Q?rdl0Skxdt7EvFvPHElPK2+vLpdOPQHITCCYQvMJabIIXtPrsyTfrgNDKZOO1?=
 =?us-ascii?Q?67DoOLnoVDPJuIUsjX5Nzp+Xhd9fju5dI2BYyNTqoADfxRqzju3RcMGUTxad?=
 =?us-ascii?Q?ulmyevtFQ/75vr5nfaeOnfaFCCSmlIhS6hUw4QLKD2NjEwWxP8Vj2xbhWij9?=
 =?us-ascii?Q?JgAaVWNkSgjS/yLJcb6imlqeavXYG+QR5oCThSY90oUHWvsgER2ncwndO555?=
 =?us-ascii?Q?/ibqMwifw3rPWD6rOAXmfuWlM/ScoS6GofNtxoB/OJT/ZsYPH85Cj+S3qf/z?=
 =?us-ascii?Q?ocGHWeKNtn0kpIBHqDQ8fStwkaQZCJoAgz34XV+xWWbF9w4K1Ev+ax1p4GFq?=
 =?us-ascii?Q?bjFK4IcUUXifbWHI2+monBqEvRkZiv+2afMZLB6S8G/pX+zs3txuJYp94Ngy?=
 =?us-ascii?Q?GgXRNXlCBzfYW/I3RQ7gomJmIfOx9QMYOlwa4ErS9/muYeIZnqEHHrM9huv9?=
 =?us-ascii?Q?0tLovCXchnEl8eQ8lc0MB91DgxZsLkOV0edTKWrRf13v7VfW4lskkyG/Pk2v?=
 =?us-ascii?Q?QQfmBX0fq8aqMiZamiDGjULotyxXT3+k99A0JhZw/QSqMT0r75+94Wxr+pqm?=
 =?us-ascii?Q?HYob6c8fldHAx694DTzHgivQiSFR5Al3GhdVyEYnM5vYSkK3uOhxzwqAUvsg?=
 =?us-ascii?Q?L2Z7PaoJJEvELnlyuT5a96zgEdc2eZy9e3WZZ4oczR5WXB/PMmhQxwoXlu57?=
 =?us-ascii?Q?ffwJLqd8nmqnE/9EfrIVZAkxel3CslEGaq9yJsA2dmyxHl+7bPLsulgl9ukm?=
 =?us-ascii?Q?3BOstT9lnTEjDek=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 05:04:22.9278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4df1b1d-7a8d-4d5b-ebb6-08dd676cae00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270
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

To get the device context, replace pr_ with dev_ functions.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c  | 142 ++++++++++++------
 .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c  |  92 ++++++++----
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 142 ++++++++++++++----
 3 files changed, 263 insertions(+), 113 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
index 37b69fe0ede3..54870b4c5000 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -168,11 +168,12 @@ static bool event_interrupt_isr_v10(struct kfd_node *dev,
 	    client_id != SOC15_IH_CLIENTID_SE3SH)
 		return false;
 
-	pr_debug("client id 0x%x, source id %d, vmid %d, pasid 0x%x. raw data:\n",
-		 client_id, source_id, vmid, pasid);
-	pr_debug("%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X.\n",
-		 data[0], data[1], data[2], data[3],
-		 data[4], data[5], data[6], data[7]);
+	dev_dbg(dev->adev->dev,
+		"client id 0x%x, source id %d, vmid %d, pasid 0x%x. raw data:\n",
+		client_id, source_id, vmid, pasid);
+	dev_dbg(dev->adev->dev, "%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X.\n",
+		data[0], data[1], data[2], data[3], data[4], data[5], data[6],
+		data[7]);
 
 	/* If there is no valid PASID, it's likely a bug */
 	if (WARN_ONCE(pasid == 0, "Bug: No PASID in KFD interrupt"))
@@ -217,37 +218,66 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
 						SQ_INTERRUPT_WORD_WAVE_CTXID1, ENCODING);
 			switch (encoding) {
 			case SQ_INTERRUPT_WORD_ENCODING_AUTO:
-				pr_debug_ratelimited(
+				dev_dbg_ratelimited(
+					dev->adev->dev,
 					"sq_intr: auto, se %d, ttrace %d, wlt %d, ttrac_buf0_full %d, ttrac_buf1_full %d, ttrace_utc_err %d\n",
-					REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_AUTO_CTXID1,
-							SE_ID),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
-							THREAD_TRACE),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
-							WLT),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
-							THREAD_TRACE_BUF0_FULL),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
-							THREAD_TRACE_BUF1_FULL),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
-							THREAD_TRACE_UTC_ERROR));
+					REG_GET_FIELD(
+						context_id1,
+						SQ_INTERRUPT_WORD_AUTO_CTXID1,
+						SE_ID),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_AUTO_CTXID0,
+						THREAD_TRACE),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_AUTO_CTXID0,
+						WLT),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_AUTO_CTXID0,
+						THREAD_TRACE_BUF0_FULL),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_AUTO_CTXID0,
+						THREAD_TRACE_BUF1_FULL),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_AUTO_CTXID0,
+						THREAD_TRACE_UTC_ERROR));
 				break;
 			case SQ_INTERRUPT_WORD_ENCODING_INST:
-				pr_debug_ratelimited("sq_intr: inst, se %d, data 0x%x, sa %d, priv %d, wave_id %d, simd_id %d, wgp_id %d\n",
-					REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1,
-							SE_ID),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
-							DATA),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
-							SA_ID),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
-							PRIV),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
-							WAVE_ID),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
-							SIMD_ID),
-					REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1,
-							WGP_ID));
+				dev_dbg_ratelimited(
+					dev->adev->dev,
+					"sq_intr: inst, se %d, data 0x%x, sa %d, priv %d, wave_id %d, simd_id %d, wgp_id %d\n",
+					REG_GET_FIELD(
+						context_id1,
+						SQ_INTERRUPT_WORD_WAVE_CTXID1,
+						SE_ID),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID0,
+						DATA),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID0,
+						SA_ID),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID0,
+						PRIV),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID0,
+						WAVE_ID),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID0,
+						SIMD_ID),
+					REG_GET_FIELD(
+						context_id1,
+						SQ_INTERRUPT_WORD_WAVE_CTXID1,
+						WGP_ID));
 				if (context_id0 & SQ_INTERRUPT_WORD_WAVE_CTXID0__PRIV_MASK) {
 					if (kfd_set_dbg_ev_from_interrupt(dev, pasid,
 							KFD_DEBUG_DOORBELL_ID(context_id0),
@@ -259,21 +289,37 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
 			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
 				sq_intr_err_type = REG_GET_FIELD(context_id0, KFD_CTXID0,
 								ERR_TYPE);
-				pr_warn_ratelimited("sq_intr: error, se %d, data 0x%x, sa %d, priv %d, wave_id %d, simd_id %d, wgp_id %d, err_type %d\n",
-					REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1,
-							SE_ID),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
-							DATA),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
-							SA_ID),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
-							PRIV),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
-							WAVE_ID),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
-							SIMD_ID),
-					REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1,
-							WGP_ID),
+				dev_warn_ratelimited(
+					dev->adev->dev,
+					"sq_intr: error, se %d, data 0x%x, sa %d, priv %d, wave_id %d, simd_id %d, wgp_id %d, err_type %d\n",
+					REG_GET_FIELD(
+						context_id1,
+						SQ_INTERRUPT_WORD_WAVE_CTXID1,
+						SE_ID),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID0,
+						DATA),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID0,
+						SA_ID),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID0,
+						PRIV),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID0,
+						WAVE_ID),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID0,
+						SIMD_ID),
+					REG_GET_FIELD(
+						context_id1,
+						SQ_INTERRUPT_WORD_WAVE_CTXID1,
+						WGP_ID),
 					sq_intr_err_type);
 				break;
 			default:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
index c5f97e6e36ff..eb88ba8d8b01 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -148,44 +148,69 @@ enum SQ_INTERRUPT_ERROR_TYPE {
 #define KFD_CTXID0_DOORBELL_ID(ctxid0)		((ctxid0) & \
 				KFD_CTXID0_DOORBELL_ID_MASK)
 
-static void print_sq_intr_info_auto(uint32_t context_id0, uint32_t context_id1)
+static void print_sq_intr_info_auto(struct kfd_node *dev, uint32_t context_id0,
+				    uint32_t context_id1)
 {
-	pr_debug_ratelimited(
+	dev_dbg_ratelimited(
+		dev->adev->dev,
 		"sq_intr: auto, ttrace %d, wlt %d, ttrace_buf_full %d, reg_tms %d, cmd_tms %d, host_cmd_ovf %d, host_reg_ovf %d, immed_ovf %d, ttrace_utc_err %d\n",
-		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, THREAD_TRACE),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
+			      THREAD_TRACE),
 		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, WLT),
-		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, THREAD_TRACE_BUF_FULL),
-		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, REG_TIMESTAMP),
-		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, CMD_TIMESTAMP),
-		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, HOST_CMD_OVERFLOW),
-		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, HOST_REG_OVERFLOW),
-		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, IMMED_OVERFLOW),
-		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, THREAD_TRACE_UTC_ERROR));
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
+			      THREAD_TRACE_BUF_FULL),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
+			      REG_TIMESTAMP),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
+			      CMD_TIMESTAMP),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
+			      HOST_CMD_OVERFLOW),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
+			      HOST_REG_OVERFLOW),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
+			      IMMED_OVERFLOW),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
+			      THREAD_TRACE_UTC_ERROR));
 }
 
-static void print_sq_intr_info_inst(uint32_t context_id0, uint32_t context_id1)
+static void print_sq_intr_info_inst(struct kfd_node *dev, uint32_t context_id0,
+				    uint32_t context_id1)
 {
-	pr_debug_ratelimited(
+	dev_dbg_ratelimited(
+		dev->adev->dev,
 		"sq_intr: inst, data 0x%08x, sh %d, priv %d, wave_id %d, simd_id %d, wgp_id %d\n",
 		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0, DATA),
-		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0, SH_ID),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
+			      SH_ID),
 		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0, PRIV),
-		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0, WAVE_ID),
-		REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1, SIMD_ID),
-		REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1, WGP_ID));
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
+			      WAVE_ID),
+		REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1,
+			      SIMD_ID),
+		REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1,
+			      WGP_ID));
 }
 
-static void print_sq_intr_info_error(uint32_t context_id0, uint32_t context_id1)
+static void print_sq_intr_info_error(struct kfd_node *dev, uint32_t context_id0,
+				     uint32_t context_id1)
 {
-	pr_warn_ratelimited(
+	dev_warn_ratelimited(
+		dev->adev->dev,
 		"sq_intr: error, detail 0x%08x, type %d, sh %d, priv %d, wave_id %d, simd_id %d, wgp_id %d\n",
-		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, DETAIL),
-		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, TYPE),
-		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, SH_ID),
-		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, PRIV),
-		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, WAVE_ID),
-		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID1, SIMD_ID),
-		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID1, WGP_ID));
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0,
+			      DETAIL),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0,
+			      TYPE),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0,
+			      SH_ID),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0,
+			      PRIV),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0,
+			      WAVE_ID),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID1,
+			      SIMD_ID),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID1,
+			      WGP_ID));
 }
 
 static void event_interrupt_poison_consumption_v11(struct kfd_node *dev,
@@ -255,11 +280,12 @@ static bool event_interrupt_isr_v11(struct kfd_node *dev,
 	    (context_id0 & AMDGPU_FENCE_MES_QUEUE_FLAG))
 		return false;
 
-	pr_debug("client id 0x%x, source id %d, vmid %d, pasid 0x%x. raw data:\n",
-		 client_id, source_id, vmid, pasid);
-	pr_debug("%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X.\n",
-		 data[0], data[1], data[2], data[3],
-		 data[4], data[5], data[6], data[7]);
+	dev_dbg(dev->adev->dev,
+		"client id 0x%x, source id %d, vmid %d, pasid 0x%x. raw data:\n",
+		client_id, source_id, vmid, pasid);
+	dev_dbg(dev->adev->dev, "%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X.\n",
+		data[0], data[1], data[2], data[3], data[4], data[5], data[6],
+		data[7]);
 
 	/* If there is no valid PASID, it's likely a bug */
 	if (WARN_ONCE(pasid == 0, "Bug: No PASID in KFD interrupt"))
@@ -353,10 +379,10 @@ static void event_interrupt_wq_v11(struct kfd_node *dev,
 					SQ_INTERRUPT_WORD_WAVE_CTXID1, ENCODING);
 			switch (sq_int_enc) {
 			case SQ_INTERRUPT_WORD_ENCODING_AUTO:
-				print_sq_intr_info_auto(context_id0, context_id1);
+				print_sq_intr_info_auto(dev, context_id0, context_id1);
 				break;
 			case SQ_INTERRUPT_WORD_ENCODING_INST:
-				print_sq_intr_info_inst(context_id0, context_id1);
+				print_sq_intr_info_inst(dev, context_id0, context_id1);
 				sq_int_priv = REG_GET_FIELD(context_id0,
 						SQ_INTERRUPT_WORD_WAVE_CTXID0, PRIV);
 				if (sq_int_priv && (kfd_set_dbg_ev_from_interrupt(dev, pasid,
@@ -366,7 +392,7 @@ static void event_interrupt_wq_v11(struct kfd_node *dev,
 					return;
 				break;
 			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
-				print_sq_intr_info_error(context_id0, context_id1);
+				print_sq_intr_info_error(dev, context_id0, context_id1);
 				sq_int_errtype = REG_GET_FIELD(context_id0,
 						SQ_INTERRUPT_WORD_ERROR_CTXID0, TYPE);
 				if (sq_int_errtype != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index b8a91bf4ef30..4ceb251312a6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -314,11 +314,12 @@ static bool event_interrupt_isr_v9(struct kfd_node *dev,
 					& ~pasid_mask) | pasid);
 	}
 
-	pr_debug("client id 0x%x, source id %d, vmid %d, pasid 0x%x. raw data:\n",
-		 client_id, source_id, vmid, pasid);
-	pr_debug("%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X.\n",
-		 data[0], data[1], data[2], data[3],
-		 data[4], data[5], data[6], data[7]);
+	dev_dbg(dev->adev->dev,
+		"client id 0x%x, source id %d, vmid %d, pasid 0x%x. raw data:\n",
+		client_id, source_id, vmid, pasid);
+	dev_dbg(dev->adev->dev, "%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X.\n",
+		data[0], data[1], data[2], data[3], data[4], data[5], data[6],
+		data[7]);
 
 	/* If there is no valid PASID, it's likely a bug */
 	if (WARN_ONCE(pasid == 0, "Bug: No PASID in KFD interrupt"))
@@ -379,28 +380,82 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 			encoding = REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, ENCODING);
 			switch (encoding) {
 			case SQ_INTERRUPT_WORD_ENCODING_AUTO:
-				pr_debug_ratelimited(
+				dev_dbg_ratelimited(
+					dev->adev->dev,
 					"sq_intr: auto, se %d, ttrace %d, wlt %d, ttrac_buf_full %d, reg_tms %d, cmd_tms %d, host_cmd_ovf %d, host_reg_ovf %d, immed_ovf %d, ttrace_utc_err %d\n",
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, SE_ID),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, THREAD_TRACE),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, WLT),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, THREAD_TRACE_BUF_FULL),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, REG_TIMESTAMP),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, CMD_TIMESTAMP),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, HOST_CMD_OVERFLOW),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, HOST_REG_OVERFLOW),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, IMMED_OVERFLOW),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, THREAD_TRACE_UTC_ERROR));
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_AUTO_CTXID,
+						SE_ID),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_AUTO_CTXID,
+						THREAD_TRACE),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_AUTO_CTXID,
+						WLT),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_AUTO_CTXID,
+						THREAD_TRACE_BUF_FULL),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_AUTO_CTXID,
+						REG_TIMESTAMP),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_AUTO_CTXID,
+						CMD_TIMESTAMP),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_AUTO_CTXID,
+						HOST_CMD_OVERFLOW),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_AUTO_CTXID,
+						HOST_REG_OVERFLOW),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_AUTO_CTXID,
+						IMMED_OVERFLOW),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_AUTO_CTXID,
+						THREAD_TRACE_UTC_ERROR));
 				break;
 			case SQ_INTERRUPT_WORD_ENCODING_INST:
-				pr_debug_ratelimited("sq_intr: inst, se %d, data 0x%x, sh %d, priv %d, wave_id %d, simd_id %d, cu_id %d, intr_data 0x%x\n",
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SE_ID),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, DATA),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SH_ID),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, PRIV),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, WAVE_ID),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SIMD_ID),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, CU_ID),
+				dev_dbg_ratelimited(
+					dev->adev->dev,
+					"sq_intr: inst, se %d, data 0x%x, sh %d, priv %d, wave_id %d, simd_id %d, cu_id %d, intr_data 0x%x\n",
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID,
+						SE_ID),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID,
+						DATA),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID,
+						SH_ID),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID,
+						PRIV),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID,
+						WAVE_ID),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID,
+						SIMD_ID),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID,
+						CU_ID),
 					sq_int_data);
 				if (context_id0 & SQ_INTERRUPT_WORD_WAVE_CTXID__PRIV_MASK) {
 					if (kfd_set_dbg_ev_from_interrupt(dev, pasid,
@@ -412,14 +467,37 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 				break;
 			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
 				sq_intr_err = REG_GET_FIELD(sq_int_data, KFD_SQ_INT_DATA, ERR_TYPE);
-				pr_warn_ratelimited("sq_intr: error, se %d, data 0x%x, sh %d, priv %d, wave_id %d, simd_id %d, cu_id %d, err_type %d\n",
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SE_ID),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, DATA),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SH_ID),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, PRIV),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, WAVE_ID),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SIMD_ID),
-					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, CU_ID),
+				dev_warn_ratelimited(
+					dev->adev->dev,
+					"sq_intr: error, se %d, data 0x%x, sh %d, priv %d, wave_id %d, simd_id %d, cu_id %d, err_type %d\n",
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID,
+						SE_ID),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID,
+						DATA),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID,
+						SH_ID),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID,
+						PRIV),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID,
+						WAVE_ID),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID,
+						SIMD_ID),
+					REG_GET_FIELD(
+						context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID,
+						CU_ID),
 					sq_intr_err);
 				if (sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
 					sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
-- 
2.25.1

