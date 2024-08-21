Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1B7C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 21:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E578910E4FC;
	Wed, 21 Aug 2024 21:17:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0BrlcZSy";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B500410E48B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 21:17:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nk7H69jFayy0gt23Y7xgC3LD23evoFhAJNZ8DPBbuTXR/pH4AX2qI4OT7s4l+zDeeERyxtvndnOmIDp6F3FUsvJTxLJgtrNkdQhk32O9gBUcGgtJ1Cp/dE3CCuHLWlVpD3xffNBSSxrFqycT09fE2ZnNjahG8HWw51A2CRc8dOg587JP68hW7QlqUE8oUp+2ClIh65niqSdqX1QTIgIHHTBbGAz/cpRckmM8CerlqBofGwnBsJeJghjLxkrVkKzITunLLT/xVHZl4oC3HwTgtLod6T2coSXAGBabl0TtYiwDHvDKs0D+XWuVEmND8v8TKJd23ldPxOqJc9MVaWEa2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzWErOJuLLd7mr3irqD2BHEumiegCzi/XfcXPMHhx0o=;
 b=bvcaHBgJgshF6cexkoPNvpTFnWWKHHxFF7p/c1foIKf0ag1Cqr4bJTq/LOj6f5kRhN1OIebXErQtf7dZ4RkmDRTJz2V5xByeatyyM6+/At5bBNa2kLJpAe94nSxbNnLsPBvGOLYE+pVt0/FcBdYucWNy6yncc8hN4TX9FjLL4HhQowkayzGwXwnjNl9oWM7IQaL7h7mPXFKp2Uioppq7VUXJIcOJ98BfOsFQZ1p5ezRkkMsjzm2wKfFELJDTzkslMzCiQXFaft4MfGeLDBu0nGknO2Rg/lGUfxM+0sT6Bwx0jZSWmpSJS/F5vaZH+n5WRtYyhje5YBreJGYg2GLGWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzWErOJuLLd7mr3irqD2BHEumiegCzi/XfcXPMHhx0o=;
 b=0BrlcZSyn0gnbOBLPTFty/h6PXcZDnM9oIrH1z479j135tnGC8StDqSdUlr+Wdit2bdCW3h459TAj2m5H8ThlPoo815Q88B6nOWsqNsxKbmtsTRLYCas0Wn3SE++A7E6/QQ6mwMy5oJcQJCU2X/UxAypTizzGKJnEajCdm4Epag=
Received: from MW4PR04CA0072.namprd04.prod.outlook.com (2603:10b6:303:6b::17)
 by CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 21:17:45 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::ab) by MW4PR04CA0072.outlook.office365.com
 (2603:10b6:303:6b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 21:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 21:17:44 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 16:17:43 -0500
From: Jonathan Kim <Jonathan.Kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <Alexander.Deucher@amd.com>, Jonathan Kim <Jonathan.Kim@amd.com>, "Jonathan
 Kim" <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: fix missed queue reset on queue destroy
Date: Wed, 21 Aug 2024 17:17:37 -0400
Message-ID: <20240821211737.4154269-1-Jonathan.Kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2acc0e-5085-4ffb-47fb-08dcc226b330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ozxo5EdDWysjVYYuPh7lrK5AhSTBOGrhAkk2dLBhND7rusTiQI935sSNwGZA?=
 =?us-ascii?Q?JCYIYo2Uq1/j5Y3Jk6vJlnm8bndny8lvJ9XBA8fsUIfn8a0Z/qslLOdqlOty?=
 =?us-ascii?Q?ilWVGmKOFlG/wlUluS1wcn/TIjW9DSFx3G79Sh65LCD1uDA+mk5LOt/H3Wu3?=
 =?us-ascii?Q?2PiK9VFyHoESy9sU1fZK/9pDPBZh1FgT/5nR6yHvP5rNZ3l412QNoGREgx4R?=
 =?us-ascii?Q?W1uqJoOYh097by0cITmzBFpgmN7mOdkKyd+kGXYja+SHYfrIXV9aggQWdTP1?=
 =?us-ascii?Q?Uouj80cLVexMdpca03wRL26AAwIIfeyZUlaJVNcOzzQqWwJiFAxZ8btH6fu6?=
 =?us-ascii?Q?DcXebYllNoLm3VNKCk8R26kwo+77c7T0oANylWxlnmGrec48o9B/q3mPTVP/?=
 =?us-ascii?Q?ZYl/VlPZMhUTdEtoHP5noNVIC6wBxnCW+wIgXKO34ovNnSR/OmxJub/zRQb7?=
 =?us-ascii?Q?EvSkQK/CccjnlijGGm67KgEbVyhluGj2hqiLtT1Edc2zArOk52ysWuGaoCUI?=
 =?us-ascii?Q?N5jOiq1TDGwH7f7yOjGKxTqSg/A8y7J4SAXmZiytnBe27gF7tDwzPKwMAc/4?=
 =?us-ascii?Q?arPILSc4QZeSmALic/tPNo6B6T0Xuj4VW/SEqsWwLalWsdaYPIZTBNNQm7E+?=
 =?us-ascii?Q?YOu88pO/zA1ggmfWYnichiBvdsRtEcdmGFgUSj5QkMQEohnQSn0hLP8ThFVt?=
 =?us-ascii?Q?mymVB8+iaiKn+UY4uj0Npjrc66jGYzIkD1CKe1XP6uwuX7hTSStnXh056wAv?=
 =?us-ascii?Q?Htq47v0obuImqUexEprxkEIt8YuAcG+PGvZHI2Zc2N8z9IS4SaCPt1OxcnVk?=
 =?us-ascii?Q?YPbQMoobsOL5tOIFYMC7N2Lwd00JsDRdLt1UCWkoxrHtDfJErQuVlWlf7DvF?=
 =?us-ascii?Q?90YPDhkjrIQcrkrI46+NcWvRfIm48a3F4U6kyj3JPlwaF4zw9211BtdvlIac?=
 =?us-ascii?Q?63GvpprNGPnRf3WQlS2prnUWlwdElwdz+Qio7hBdPOZwAvI43Pch3m4Hkus4?=
 =?us-ascii?Q?wQ6MgqkOzxIdIWPv/KGnr5TNt2Y44RFdwULKvHiOcbM017y4Gt54PUVuwYUO?=
 =?us-ascii?Q?FBJwBxWzBwI//5PlemUA+Xn0Qgu55h3oh7bOJgi0Awng0C47oIHULRqMddcD?=
 =?us-ascii?Q?w4FYYgzoo4oOq13vPhip4zLEqn0EZpC5FE2duA14llbhNSuOycXZb0PuprWm?=
 =?us-ascii?Q?uWEGrOz7DTDe/LcfuFR+YpnwaZ8ddQIgErv0LUkW52d9d7nL/Y7iRerm942u?=
 =?us-ascii?Q?h2DIiZ1wuImFtyAGhpYvgpgK54MCWArloH2nHh5FyULv0z5v+4XIW99Ctroc?=
 =?us-ascii?Q?C2aZ7DkKa7C6s8cUKXP2scD6xSlWRjJUvL0PhBQRVhINgY2F1GJX4qtzmi2T?=
 =?us-ascii?Q?Vm7Gyh37vZT7m//WnC/Mrqtt+kfIt8oN2H9UZoL2MX06pyxcqD8fRsRmGbCP?=
 =?us-ascii?Q?xUhIoiurCVC5LPMCizoYGjoRiU+dPM2C?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 21:17:44.9036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2acc0e-5085-4ffb-47fb-08dcc226b330
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584
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

If a queue is being destroyed but causes a HWS hang on removal, the KFD
may issue an unnecessary gpu reset if the destroyed queue can be fixed
by a queue reset.

This is because the queue has been removed from the KFD's queue list
prior to the preemption action on destroy so the reset call will fail to
match the HQD PQ reset information against the KFD's queue record to do
the actual reset.

Since a queue destroy request is under the same device lock as any other
preemption request (which subsumes queue reset calls), transiently
store the destroyed queue's reference so that a potential subsequent queue
reset call can check against this queue as well.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 10 +++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 577d121cc6d1..09e39a72ca31 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1842,6 +1842,8 @@ static int start_cpsch(struct device_queue_manager *dqm)
 		goto fail_detect_hang_buffer;
 	}
 
+	dqm->cur_destroyed_queue = NULL;
+
 	dqm_unlock(dqm);
 
 	return 0;
@@ -2105,7 +2107,7 @@ static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q
 		q->properties.queue_id, q->process->pasid);
 
 	pdd->has_reset_queue = true;
-	if (q->properties.is_active) {
+	if (q->properties.is_active && dqm->cur_destroyed_queue != q) {
 		q->properties.is_active = false;
 		decrement_queue_count(dqm, qpd, q);
 	}
@@ -2160,6 +2162,10 @@ static struct queue *find_queue_by_address(struct device_queue_manager *dqm, uin
 	struct qcm_process_device *qpd;
 	struct queue *q;
 
+	if (dqm->cur_destroyed_queue &&
+	    dqm->cur_destroyed_queue->properties.queue_address == queue_address)
+		return dqm->cur_destroyed_queue;
+
 	list_for_each_entry(cur, &dqm->queues, list) {
 		qpd = cur->qpd;
 		list_for_each_entry(q, &qpd->queues_list, list) {
@@ -2409,6 +2415,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 
 	list_del(&q->list);
 	qpd->queue_count--;
+	dqm->cur_destroyed_queue = q;
 	if (q->properties.is_active) {
 		decrement_queue_count(dqm, qpd, q);
 		if (!dqm->dev->kfd->shared_resources.enable_mes) {
@@ -2421,6 +2428,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 			retval = remove_queue_mes(dqm, q, qpd);
 		}
 	}
+	dqm->cur_destroyed_queue = NULL;
 
 	/*
 	 * Unconditionally decrement this counter, regardless of the queue's
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 08b40826ad1e..5425c1dd7924 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -285,6 +285,7 @@ struct device_queue_manager {
 	struct dqm_detect_hang_info *detect_hang_info;
 	size_t detect_hang_info_size;
 	int detect_hang_count;
+	struct queue *cur_destroyed_queue;
 };
 
 void device_queue_manager_init_cik(
-- 
2.34.1

