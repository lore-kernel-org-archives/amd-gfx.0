Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105CBC3ABD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 19:05:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DC1810E647;
	Wed, 14 May 2025 19:05:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hCoTPhqe";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F0110E638
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 19:05:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xY/pxTUB0fubIH9pHGkELenx/zKTYN7jJh+Cybv2WxM+lvjW+eY9XWn63Unsz6PTakSlgbIYERAsstgDoKLcOWFjzycnyXACq2M224oPJD270fun9HcYm9zh1mjJofqOFOmJqo/Q4ch2gGksDi6QnZpfqlulgglWVe1OrKetfcOcJuUBlw1Eqsv3RSUfB1Y3T2RL1qlWBGKGfUMbQ7Hcfnt3ymDQ+bwKH9dGyjxgE+Oe+Ppq4MJN5z5usWlbjdjFy4HOSO0NsSlq6Qkbp0DD1h33x7qDyrBdf1GIxJ4kOp4hM3AtDbOqJy3WXkp301zPHMaxclDb0fhIwBJ94KV7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXNiLUd2BKItvskX0b5vGIJE4pbt4okMHdYUXFAXVdg=;
 b=vVHNVnkjmG0O/FjJfbQmT3Wq5usvUlIl+Z1iC9ZYpv04UDd7GXkE8d4taJqkzt4D2/GVPE7TIj+zKDigIVxmoWjIPEDQWaZphFQ7p5xe6ggQV2yBnvTz9mcc7vB+wyZGUsaGsZXzSFgpEIaHZx0jy2u0NNkEJVQuStZuIMzY3QwzOLoJa4SsGcI4rvo32UyVJ5Ch2JlaFUqwW5FRQtseMrPwvJhKZXDqdGKdTxsMLwPyMHx1HR63xQ9g45565qo6SfZISbCuJwuYTNZdU+kLvIFaraaRtXGoauJhf59g5jcIya30Ta4BchQeJGihp7uLP7SlK5iw3QVmHmovI4kHXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXNiLUd2BKItvskX0b5vGIJE4pbt4okMHdYUXFAXVdg=;
 b=hCoTPhqeaiSwTwjTADNiEeSXNm4Tqq/ImW8K4wJ/6mf/rcBuUh3YYZl3uJ2eabtw/akd7fx6wiZr9GI7wgDYsYGHet+lw0CP+xruMw52FhhqIQfwPvPNTKXZzS8TxdcrOJ4Bd6W1hhGvPsfinI0Hn+0TNKKpZ8amBHWfNOl7Z70=
Received: from SA1P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::30)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 19:05:07 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::c0) by SA1P222CA0028.outlook.office365.com
 (2603:10b6:806:22c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.17 via Frontend Transport; Wed,
 14 May 2025 19:05:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 19:05:06 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 14:05:02 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Philip.Yang@amd.com>
CC: Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdkfd: Support chain runlists of XNACK+/XNACK-
Date: Wed, 14 May 2025 15:04:41 -0400
Message-ID: <20250514190441.1212737-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ba6d79-3480-47ae-5ac1-08dd931a3d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6hS2xKtRmkG/K2VZWkrSo8/F7swJj4gO3NDB6fayeexhSfr2wZNYQ86urKJk?=
 =?us-ascii?Q?kkjrDxtOtsY35jJYZGJSAx8oHjYaE84YAN+qbPdNyfBTbR/wwr0h+RIds7Ty?=
 =?us-ascii?Q?/KKMXPV7czFdNny/2B2Wk//jaLrehYMSIuR83PAkWa1LUY0IfOwSSPDMTdFP?=
 =?us-ascii?Q?I2IeDdzRAQO2e7BasXQPtU6NSu/sAOGgeKouKkd9qc4TyFCKG774fx20AwJI?=
 =?us-ascii?Q?5da6Nc5v2a46T3uKtAjkv40H6f9ihsG9SI3woPpVdf3AIMcB3pgn7/fRuWHC?=
 =?us-ascii?Q?qKoB2VgP83urJbfMbKkEDz+vtRtN0KAqFjqIm9NNrqrdXXQhsrU5jq0ZsFR2?=
 =?us-ascii?Q?l1R2RndvyhG3FM752iz3vFVlOd6BRbJmYyVI2/Lzefp+iKFLTI0cb2TBQiF8?=
 =?us-ascii?Q?DOizMSh5bLHQXbRwZkS386OvnNiWFNAIRys1mYKtZGO6ZsEqsErtZTJo/UWt?=
 =?us-ascii?Q?9vzvQ6BitfIHLhstK+rIiBzDKzZLNrIKP5YLRxC4fsp1cBXlrrBt86evWSyA?=
 =?us-ascii?Q?bl019f5XthwcDWY+sboy3s6btcuxfbstyFhSIXVjESV5/jDHy/mPlv96GygG?=
 =?us-ascii?Q?1rHFo/f5gPXdwj+Hc2yscXK060PjtkvulP5tLVyOORQQ14KIp1nu3VMJr0pA?=
 =?us-ascii?Q?8xA57lsau05VHoqxTSMBLhHLfTtpQbT6dHkOxxgl5+qWti4Ct5jHpl0GDi6l?=
 =?us-ascii?Q?62znfgLi59XsUTJMaRUH1EpI8krvMuPLa8YHPO8ahH1SiIkdVeOzuDdQLNWa?=
 =?us-ascii?Q?3eMXNCmn1Y5pRcnvhWqZ9i/HW6yaQ3KqLuCQuYIE8uVVlhvDGaWpmIZ7wbLQ?=
 =?us-ascii?Q?OiSMZ9l+kg26RflSMTAmGuYJ8FUnLNhGl0NdsSeDMm50DPRJ3qH2KG5dpXRv?=
 =?us-ascii?Q?h+MLueIv4lQ1Ec82FXIgiKc+kJOW/WGQEfPYJ+zxldYUOUWtwRMphUZTMxuZ?=
 =?us-ascii?Q?6baK/xCjmM1mcFtpWw/ITYq/GbE1mo2pLIY8oxM3fgZb+H6Al5gxEDQWq+fP?=
 =?us-ascii?Q?rnsP3QhSsKIncMBD9jshawvQEdEIt8NH2Pf8kYyp4CCsQsyUtHHIgrJxHtdd?=
 =?us-ascii?Q?AGx95+w3zgr1TuQq0LHSVOWktEW3Hxc0IMhKKvU4v6f5TMkg7HRoQXXf+hCY?=
 =?us-ascii?Q?Cfy9YIYWPT7D0gBPmWlF+xsG3RSworuXtGKcJ5C65Te2iBDS+psqDCslL7uz?=
 =?us-ascii?Q?meDhZeQ9OWax173XF2+50v7OVQk5ccmu3QWMONzMjCrZdTY50DGBDjlDr1Ks?=
 =?us-ascii?Q?RS1xqp4IMeuR7by2t+aEOcKIirx2ohvpFntusiY8Z2P2iCxGdBS6OgvLfstV?=
 =?us-ascii?Q?lv5wUmEE9LSQvl15+/pLpt+3zlMoNJicLBdGIpNM3RkNC+7+i0HCBgTJMhNJ?=
 =?us-ascii?Q?xv6OG6QZzFPhVZcPZczo1Bl1hXAZDblw0E6qc6x2pM9uEZr5bpr5utVRXsBs?=
 =?us-ascii?Q?d6JqM301qIsKFGEj5nHCLmZXotd3Gq+qet4q8SLWfZg1UHNiFpVYfgBRFVdd?=
 =?us-ascii?Q?JyX+oRbD2JvRVlAwgic1kc64CtU+f3DPqI/K?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 19:05:06.3322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ba6d79-3480-47ae-5ac1-08dd931a3d57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805
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

If the MEC firmware supports chaining runlists of XNACK+/XNACK-
processes, set SQ_CONFIG1 chicken bit and SET_RESOURCES bit 28.

When the MEC/HWS supports it, KFD checks the XNACK+/XNACK- processes mix
happens or not. If it does, enter over-subscription.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  4 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 31 ++++++++++
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 56 +++++++++++++++----
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  2 +
 .../gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h   |  3 +-
 5 files changed, 84 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index bd7fc123b8f9..80fa29c26e9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -62,6 +62,9 @@
  */
 #define AMDGPU_GMC_FAULT_TIMEOUT	5000ULL
 
+/* XNACK flags */
+#define AMDGPU_GMC_XNACK_FLAG_CHAIN BIT(0)
+
 struct firmware;
 
 enum amdgpu_memory_partition {
@@ -301,6 +304,7 @@ struct amdgpu_gmc {
 	struct amdgpu_xgmi xgmi;
 	struct amdgpu_irq_src	ecc_irq;
 	int noretry;
+	uint32_t xnack_flags;
 
 	uint32_t	vmid0_page_table_block_size;
 	uint32_t	vmid0_page_table_depth;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index e6d516b1efd9..c233edf60569 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1273,6 +1273,22 @@ static void gfx_v9_4_3_xcc_init_gds_vmid(struct amdgpu_device *adev, int xcc_id)
 	}
 }
 
+/* For ASICs that needs xnack chain and MEC version supports, set SG_CONFIG1
+ * DISABLE_XNACK_CHECK_IN_RETRY_DISABLE bit and inform KFD to set xnack_chain
+ * bit in SET_RESOURCES
+ */
+static void gfx_v9_4_3_xcc_init_sq(struct amdgpu_device *adev, int xcc_id)
+{
+	uint32_t data;
+
+	if (!(adev->gmc.xnack_flags & AMDGPU_GMC_XNACK_FLAG_CHAIN))
+		return;
+
+	data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regSQ_CONFIG1);
+	data = REG_SET_FIELD(data, SQ_CONFIG1, DISABLE_XNACK_CHECK_IN_RETRY_DISABLE, 1);
+	WREG32_SOC15(GC, xcc_id, regSQ_CONFIG1, data);
+}
+
 static void gfx_v9_4_3_xcc_constants_init(struct amdgpu_device *adev,
 					  int xcc_id)
 {
@@ -1317,6 +1333,7 @@ static void gfx_v9_4_3_xcc_constants_init(struct amdgpu_device *adev,
 
 	gfx_v9_4_3_xcc_init_compute_vmid(adev, xcc_id);
 	gfx_v9_4_3_xcc_init_gds_vmid(adev, xcc_id);
+	gfx_v9_4_3_xcc_init_sq(adev, xcc_id);
 }
 
 static void gfx_v9_4_3_constants_init(struct amdgpu_device *adev)
@@ -1329,6 +1346,20 @@ static void gfx_v9_4_3_constants_init(struct amdgpu_device *adev)
 	adev->gfx.config.db_debug2 =
 		RREG32_SOC15(GC, GET_INST(GC, 0), regDB_DEBUG2);
 
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	/* ToDo: GC 9.4.4 */
+	case IP_VERSION(9, 4, 3):
+		if (adev->gfx.mec_fw_version >= 184)
+			adev->gmc.xnack_flags |= AMDGPU_GMC_XNACK_FLAG_CHAIN;
+		break;
+	case IP_VERSION(9, 5, 0):
+		if (adev->gfx.mec_fw_version >= 23)
+			adev->gmc.xnack_flags |= AMDGPU_GMC_XNACK_FLAG_CHAIN;
+		break;
+	default:
+		break;
+	}
+
 	for (i = 0; i < num_xcc; i++)
 		gfx_v9_4_3_xcc_constants_init(adev, i);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 271c567242ab..b1a6eb349bb3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -31,6 +31,7 @@
 #define OVER_SUBSCRIPTION_PROCESS_COUNT (1 << 0)
 #define OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT (1 << 1)
 #define OVER_SUBSCRIPTION_GWS_QUEUE_COUNT (1 << 2)
+#define OVER_SUBSCRIPTION_XNACK_CONFLICT (1 << 3)
 
 static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
 				unsigned int buffer_size_bytes)
@@ -44,7 +45,8 @@ static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
 
 static void pm_calc_rlib_size(struct packet_manager *pm,
 				unsigned int *rlib_size,
-				int *over_subscription)
+				int *over_subscription,
+				int xnack_conflict)
 {
 	unsigned int process_count, queue_count, compute_queue_count, gws_queue_count;
 	unsigned int map_queue_size;
@@ -73,6 +75,8 @@ static void pm_calc_rlib_size(struct packet_manager *pm,
 		*over_subscription |= OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT;
 	if (gws_queue_count > 1)
 		*over_subscription |= OVER_SUBSCRIPTION_GWS_QUEUE_COUNT;
+	if (xnack_conflict && (node->adev->gmc.xnack_flags & AMDGPU_GMC_XNACK_FLAG_CHAIN))
+		*over_subscription |= OVER_SUBSCRIPTION_XNACK_CONFLICT;
 
 	if (*over_subscription)
 		dev_dbg(dev, "Over subscribed runlist\n");
@@ -96,7 +100,8 @@ static int pm_allocate_runlist_ib(struct packet_manager *pm,
 				unsigned int **rl_buffer,
 				uint64_t *rl_gpu_buffer,
 				unsigned int *rl_buffer_size,
-				int *is_over_subscription)
+				int *is_over_subscription,
+				int xnack_conflict)
 {
 	struct kfd_node *node = pm->dqm->dev;
 	struct device *dev = node->adev->dev;
@@ -105,7 +110,8 @@ static int pm_allocate_runlist_ib(struct packet_manager *pm,
 	if (WARN_ON(pm->allocated))
 		return -EINVAL;
 
-	pm_calc_rlib_size(pm, rl_buffer_size, is_over_subscription);
+	pm_calc_rlib_size(pm, rl_buffer_size, is_over_subscription,
+				xnack_conflict);
 
 	mutex_lock(&pm->lock);
 
@@ -142,11 +148,27 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 	struct queue *q;
 	struct kernel_queue *kq;
 	int is_over_subscription;
+	int xnack_enabled = -1;
+	bool xnack_conflict = 0;
 
 	rl_wptr = retval = processes_mapped = 0;
 
+	/* Check if processes set different xnack modes */
+	list_for_each_entry(cur, queues, list) {
+		qpd = cur->qpd;
+		if (xnack_enabled < 0)
+			/* First process */
+			xnack_enabled = qpd->pqm->process->xnack_enabled;
+		else if (qpd->pqm->process->xnack_enabled != xnack_enabled) {
+			/* Found a process with a different xnack mode */
+			xnack_conflict = 1;
+			break;
+		}
+	}
+
 	retval = pm_allocate_runlist_ib(pm, &rl_buffer, rl_gpu_addr,
-				&alloc_size_bytes, &is_over_subscription);
+				&alloc_size_bytes, &is_over_subscription,
+				xnack_conflict);
 	if (retval)
 		return retval;
 
@@ -156,9 +178,13 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 	dev_dbg(dev, "Building runlist ib process count: %d queues count %d\n",
 		pm->dqm->processes_count, pm->dqm->active_queue_count);
 
+build_runlist_ib:
 	/* build the run list ib packet */
 	list_for_each_entry(cur, queues, list) {
 		qpd = cur->qpd;
+		/* group processes with the same xnack mode together */
+		if (qpd->pqm->process->xnack_enabled != xnack_enabled)
+			continue;
 		/* build map process packet */
 		if (processes_mapped >= pm->dqm->processes_count) {
 			dev_dbg(dev, "Not enough space left in runlist IB\n");
@@ -215,18 +241,26 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 				alloc_size_bytes);
 		}
 	}
+	if (xnack_conflict) {
+		/* pick up processes with the other xnack mode */
+		xnack_enabled = !xnack_enabled;
+		xnack_conflict = 0;
+		goto build_runlist_ib;
+	}
 
 	dev_dbg(dev, "Finished map process and queues to runlist\n");
 
 	if (is_over_subscription) {
 		if (!pm->is_over_subscription)
-			dev_warn(dev, "Runlist is getting oversubscribed due to%s%s%s. Expect reduced ROCm performance.\n",
-				 is_over_subscription & OVER_SUBSCRIPTION_PROCESS_COUNT ?
-				 " too many processes." : "",
-				 is_over_subscription & OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT ?
-				 " too many queues." : "",
-				 is_over_subscription & OVER_SUBSCRIPTION_GWS_QUEUE_COUNT ?
-				 " multiple processes using cooperative launch." : "");
+			dev_warn(dev, "Runlist is getting oversubscribed due to%s%s%s%s. Expect reduced ROCm performance.\n",
+				is_over_subscription & OVER_SUBSCRIPTION_PROCESS_COUNT ?
+				" too many processes" : "",
+				is_over_subscription & OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT ?
+				" too many queues" : "",
+				is_over_subscription & OVER_SUBSCRIPTION_GWS_QUEUE_COUNT ?
+				" multiple processes using cooperative launch" : "",
+				is_over_subscription & OVER_SUBSCRIPTION_XNACK_CONFLICT ?
+				" xnack on/off processes mixed on gfx9" : "");
 
 		retval = pm->pmf->runlist(pm, &rl_buffer[rl_wptr],
 					*rl_gpu_addr,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index fa28c57692b8..8fa6489b6f5d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -203,6 +203,8 @@ static int pm_set_resources_v9(struct packet_manager *pm, uint32_t *buffer,
 			queue_type__mes_set_resources__hsa_interface_queue_hiq;
 	packet->bitfields2.vmid_mask = res->vmid_mask;
 	packet->bitfields2.unmap_latency = KFD_UNMAP_LATENCY_MS / 100;
+	if (pm->dqm->dev->adev->gmc.xnack_flags & AMDGPU_GMC_XNACK_FLAG_CHAIN)
+		packet->bitfields2.enb_xnack_retry_disable_check = 1;
 	packet->bitfields7.oac_mask = res->oac_mask;
 	packet->bitfields8.gds_heap_base = res->gds_heap_base;
 	packet->bitfields8.gds_heap_size = res->gds_heap_size;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
index cd8611401a66..e356a207d03c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
@@ -63,7 +63,8 @@ struct pm4_mes_set_resources {
 		struct {
 			uint32_t vmid_mask:16;
 			uint32_t unmap_latency:8;
-			uint32_t reserved1:5;
+			uint32_t reserved1:4;
+			uint32_t enb_xnack_retry_disable_check:1;
 			enum mes_set_resources_queue_type_enum queue_type:3;
 		} bitfields2;
 		uint32_t ordinal2;
-- 
2.34.1

