Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE15CA0EDC
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 01:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C926210E849;
	Thu, 21 Aug 2025 01:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ai8a/DYq";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C1D10E852
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 01:42:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIyRfGKVLM6poJ6IvsMRf/E15EGGYaH/lxW+Ew+lHknrf4yPM7oaXRPmmLltvi4r/z3z2d8sksw6OTq/IR/uURboaxHhlsCiIfIcQtxrDgaa+8Yjgu66U4/2SxXIqRKJ02PHb4RtNVuHG2oe5rbZ+1olTNQAGZITmmAz5YtyWvRCTZbmA7zvfEqS9Mcilt6hWmoileQSgFlxQkTug1i+OoyoAn/gDm6Z/mZicphjAKc56tWa0QQ0wXWLeP3zwIHPmhw+TFYjOzzvVpKzAwcaWx7pDKBZTM/4HdXuxpx4WmR7F+KdV1WmZDGhhUolXDMlWcKHjIyVrlzrOeSgLK7IRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0kPzbWAe1gVTxMOucFfR6KfWoapfkMxFvxyCNZWkM8=;
 b=y1C4dkeulxNtDaoqvvLKlPiwD0xgH+JZpQkmjLS0lMD63XdpjYDiPUpSWzlr73L1MVbYFrA2l/Ga7eHF3rf1wA9piPPMbUuX0JW48IuqWnldqNNV6i09WzpjyDGeuAaY20xw0h579PRNJ0GSvX3O21mPxSQEw0LFS2bTt0hksEQ5xBZxPJpswhl2CGQzPDgA+fVRsU1AN4MgJwJ91veGj+IgaF880FbwiU4Ftdexj8E5FqbIJLY22ZHBxcP6A3rwxUGE4fOnQOLZngtXe5lMiWCLhhGzPup1MYSwSd/CQf6t4VkDAIjhqprMV5dWTrIfs/koJjGfcdKmgEOaXquvnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0kPzbWAe1gVTxMOucFfR6KfWoapfkMxFvxyCNZWkM8=;
 b=Ai8a/DYqX/YfVwCM082qrchFlcd2qQA7PSHqP9QQQwpnQLvMq4EJtJS+0v83eemSVchC01qLY/pDGRkP26gmIcogTWhlziKuNo2+tcdWyk+crWPrAobNfBC0DnybjmoSqLWIKhS4UDIyepSMR2wlBWxcYrm0yKfwdxjsC3GR13k=
Received: from DS7PR06CA0001.namprd06.prod.outlook.com (2603:10b6:8:2a::12) by
 LV8PR12MB9156.namprd12.prod.outlook.com (2603:10b6:408:181::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 21 Aug 2025 01:42:29 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::c4) by DS7PR06CA0001.outlook.office365.com
 (2603:10b6:8:2a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 01:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 01:42:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 20:42:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 18:42:28 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 20:42:22 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v9 10/11] drm/amdgpu: Switch user queues to use preempt/restore for
 eviction
Date: Thu, 21 Aug 2025 09:36:12 +0800
Message-ID: <20250821014115.566598-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250821014115.566598-1-Jesse.Zhang@amd.com>
References: <20250821014115.566598-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|LV8PR12MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: 86704164-2a0b-4349-2d72-08dde053fd56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CkSE+ZTwgCYY5wsR4U3AEZLi0iSQLYOK+xVwJ32WE/SH4jBTS/v/sUpVhxtx?=
 =?us-ascii?Q?PP/BBe7ZEhVyL7pLBzGWPfTYY0oNjFRHMu2oO7zRGp9mFPrgWIxlKw+knUUN?=
 =?us-ascii?Q?bGnVzVrm7ulZgj2EUmfrLbUwXnNgXTAellGm9KEwT3OBgvQa+jNWX3WxlZTA?=
 =?us-ascii?Q?oknDr6WaDBnx1cztioiUdQiaRs9YLxpoVJGxI3N6QjblrLz3J/3nVdTHtjPt?=
 =?us-ascii?Q?6uZfqSKkNBIdsVCWaEKirtzWLBR25Lh17nd3IQ7/+ht4oo1ceBqQII3OuMDX?=
 =?us-ascii?Q?kvaXFmhhxjD26TmY76oCcUbhNS8lrGbrzhWLG7vRTnSgfyx+HkgsIt2vt9UX?=
 =?us-ascii?Q?bBURWdLyC8/Tkj0i9qlNsu1vLDnzYO3/dQyUtUJKtQjw0e+rCRcsIR4w3WsD?=
 =?us-ascii?Q?nTBjFD3s0QCEbAna2iL7IdcFgPu3Zlnq1eggSGvHqMRtqb6R3Ver4pEZj5aq?=
 =?us-ascii?Q?05wg05LuYUWEs9Muc+/EFSwr0v+dizrJSvj574utHRsepAgmtz0WUUh6Sr40?=
 =?us-ascii?Q?mDo1aG6uKEI2/mKTcZMaMn04NgTty2HQEcMMvi0ClGURrva+OptLP868ATCt?=
 =?us-ascii?Q?FEZzqUq8jq7+yJMi+/rlROrKFBmsATpwdSuxFW1Bveto9uQA4YSSTYqGIPjo?=
 =?us-ascii?Q?je+gKGU1ABidt661xn62Q5oZjOPxbb0+yetGvEziI7ktiRUlwISZn5vBs+FB?=
 =?us-ascii?Q?Ur2hVaoZ9JNrd7oHbmbhUdRyMKYaAgNlyzuLUSPAFjw7sjTsMi0RyB1795wI?=
 =?us-ascii?Q?iM+iTCmzeONYOLtnvl4CgFNEbOgtP/PNIcn71Ywa58FFdIqVq1X9f6HeR2G9?=
 =?us-ascii?Q?wGePQyEjah1w20/jsKTQmdqnTZgc9s2hjFCVzZ8KbtkO7VYSU4KUFJSVXmwP?=
 =?us-ascii?Q?MttQm5f6xqU/qJZoWXVfak9TC3ShSIZA9sHbNRsLktTIkuDNodEq/TrNLMTG?=
 =?us-ascii?Q?l2e313717mLAKi+rKlGs0lPv+lA0PUpmhbxT6W0ZZAEusZkicPk2tc2fodFD?=
 =?us-ascii?Q?h173qbB4uqKJQ/6hcd5mIIUkuHLmfv8JQVZdmgdASAubf+nQZFlMrydUw27r?=
 =?us-ascii?Q?QsDw61FbbxwdOf6a6uqYDkVWJPBzs70GbaQvWNstesBW7Hv3XdXvggmF0ZzV?=
 =?us-ascii?Q?KaLi28bT/CMnawZTbx9H/ecX4jNWzVO5FkYkyGoYwz9EI7tWywdqaqJpib3Z?=
 =?us-ascii?Q?bmWMPhwjZ0zqSyAj2kewIG8Gc8LaWemfhi5Er2qOZp1ZR0jVBazrDYCftjS+?=
 =?us-ascii?Q?AZvfqUYZ9jaK5loP7grNBwYLs6iyu2nq5vC9e0JoH/IcTnbzv4qLN9ZsnTt9?=
 =?us-ascii?Q?KGO+ZaSiGUoXyqxFC7t7MrqJWix9Wn2upWeknt7eLxjnE5kPM9qkmL2bZ3rM?=
 =?us-ascii?Q?vLZIvgQVWkME4w4AKiLQbEq0byLMA2jV2eySuvnyZPPmxSdpxJnaamDElQoj?=
 =?us-ascii?Q?+pFbPduRwB0PiCaZt79KJ/wWrtRJjSRl0GSXg/nuiVKj/0gGZIVPtDE7QeDP?=
 =?us-ascii?Q?WcgZQkVvd+iHs88aDoXYsRuB1ppdNYRd9OXZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 01:42:29.2853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86704164-2a0b-4349-2d72-08dde053fd56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9156
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

This patch modifies the user queue management to use preempt/restore
operations instead of full map/unmap for queue eviction scenarios where
applicable. The changes include:

1. Introduces new helper functions:
   - amdgpu_userqueue_preempt_helper()
   - amdgpu_userqueue_restore_helper()

2. Updates queue state management to track PREEMPTED state

3. Modifies eviction handling to use preempt instead of unmap:
   - amdgpu_userq_evict_all() now uses preempt_helper
   - amdgpu_userq_restore_all() now uses restore_helper

The preempt/restore approach provides better performance during queue
eviction by avoiding the overhead of full queue teardown and setup.
Full map/unmap operations are still used for initial setup/teardown
and system suspend scenarios.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 49 +++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index aac0de86f3e8..decedf8057ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -45,7 +45,7 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 }
 
 static int
-amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
+amdgpu_userqueue_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
@@ -54,6 +54,49 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+		r = userq_funcs->preempt(uq_mgr, queue);
+		if (r) {
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		} else {
+			queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
+		}
+	}
+
+	return r;
+}
+
+static int
+amdgpu_userqueue_restore_helper(struct amdgpu_userq_mgr *uq_mgr,
+			struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	int r = 0;
+
+	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
+		r = userq_funcs->restore(uq_mgr, queue);
+		if (r) {
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		} else {
+			queue->state = AMDGPU_USERQ_STATE_MAPPED;
+		}
+	}
+
+	return r;
+}
+
+static int
+amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
+			  struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	int r = 0;
+
+	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
+		(queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
 		r = userq_funcs->unmap(uq_mgr, queue);
 		if (r)
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
@@ -536,7 +579,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_map_helper(uq_mgr, queue);
+		r = amdgpu_userqueue_restore_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
@@ -693,7 +736,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Try to unmap all the queues in this process ctx */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_unmap_helper(uq_mgr, queue);
+		r = amdgpu_userqueue_preempt_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
-- 
2.49.0

