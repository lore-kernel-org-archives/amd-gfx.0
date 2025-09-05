Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADD3CA1012
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 03:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C36710EB07;
	Fri,  5 Sep 2025 03:20:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nMYkeJRh";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D1EC10EB07
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 03:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfIjftfJPcOeS/kisbDruUKyEFKPNFNkTebyozybuOjxcY4WgCWLpygwMVtmxjHWh18JvTjuquh8qsWayUcpN6WqYjlEXcBxeWbmK4LHDK1oW+4eDUgHc1v1QnPqQ7jEXjPoeE11RbTqPFHgwkNarHbw8fVKOpKTpFq+SOrrGD3RqichBUKfOvbA2qyWNbWr8c8jpOnsrFKPx3+nRZatTrqM3b1euz6AF75CesmVP2Vc/OiSHQSOQJWySJIVCMVOGzdNp0CKXYssYvymAEh1vvvnHKavuX7M/rbtgXGIV6BGR8Oe+lS0EDQvUiA+bBCf6d2VdY/c+Hn1Mop5Kl0hXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1pJ69nsrLOMVuhY3eFYVed9C2ZoF8Mie4AZHBhy2ik=;
 b=SAdIH2eF/KquFD/QrMALPA0PgJrWa93/Ls4gfrl97c0UAy8kWRo1qVRd19KIpV2HPHsJTHPOwZoIHKKNGmRHBRATnO6tHcPOXkwh4zi1rM7ykuiUh+9LtY+zCD/HY0spyq0MXhlNIglT89BeRXihTI7Yu8jPedvuUdLxVUkEtvXqsSdfeUV61qbifT312YIpbILKUCPtOfNcIYIOport92DZa6Nqz94FsKU1RQgryOAQKZyY+b+IXqlnh6ngAXgeYwlkLwyUqp9ET/dOCuBlGH8MR2EzXi9MFJUqP+KoVwY0H7J3piqE/mgrFGxZKexPdwg0PU6o1OZvo340uf6zmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1pJ69nsrLOMVuhY3eFYVed9C2ZoF8Mie4AZHBhy2ik=;
 b=nMYkeJRh2K9Nl+I/QBP9Fd4unPPVkPGFVJMiuAqSWeHZpwDDKdWZtSHY8jNqmVSvFmyUL+7rS9HPR2fu+iGQT5ZG3l3w5GdYfen1/a5z+CcxDap/Y48dUq8jlNy28acpaLqgDES16yHyXoqYeDQqItk0wwfhFrKZCiD+sEo3XQ0=
Received: from SJ0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::29)
 by PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 03:20:42 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::65) by SJ0P220CA0006.outlook.office365.com
 (2603:10b6:a03:41b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Fri,
 5 Sep 2025 03:20:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 03:20:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 22:20:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 4 Sep
 2025 20:20:40 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 4 Sep 2025 22:20:34 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Switch user queues to use preempt/restore for
 eviction
Date: Fri, 5 Sep 2025 11:19:26 +0800
Message-ID: <20250905032026.3256999-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250905032026.3256999-1-Jesse.Zhang@amd.com>
References: <20250905032026.3256999-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|PH7PR12MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 98fe075d-3b9f-47bd-d3e6-08ddec2b31c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f+hLujKb5OJ+085uVt0Bz+eTMl2T9P3Sgs5p5Zh/UJXJ08CQHIEwsIV/Ln4h?=
 =?us-ascii?Q?RQ5/tKaf6GVM1SEksCCA+i8MRYwb+qabt8Tdnc0vBdhN2U0yXNDuhFYPznqw?=
 =?us-ascii?Q?SSqpOWHe0vorpn1dBIYP2yJ/e05OdyL0SBDNqsUW9mbN4+Qzu1Qn+9kTGSKj?=
 =?us-ascii?Q?+Qj+hBiwddip84la28DHr3nktxiuJeX4WQDlYwXqaDJ+NGR5fjsJlMjvOEOW?=
 =?us-ascii?Q?UZdObwMATNVorm3/0iezsJ+9/Fq2zM1DV4cdC3Sea+4FvapEQupZq+4w6bmF?=
 =?us-ascii?Q?L1rWVEUHPqLEv8rVSElKBvOrPL0jo/2drI6LoEEoqMxcQVGltih9hxekyBd8?=
 =?us-ascii?Q?V5A31JixJXEUkF8511nD62Ya2IW3+OqyN//R2p9gAJXx/B8aadhqxlyJ4EAv?=
 =?us-ascii?Q?2sTWei0OlWlu593dM/5OiaT18TfdHqtpfsP2MTm3Xm6gl+vBPbB3/0GhzzvG?=
 =?us-ascii?Q?/rrFzLRqzjVbQahoQmokfFP+VtYwGh2FD6MEtXWp8IgEOd9ZlFhu4ElbUNgx?=
 =?us-ascii?Q?bDqrAK4pdYqADSJ91hnY9wvfcv0pTMbtXe0mEW0+6oMEliHIQRMfTLyV0p8e?=
 =?us-ascii?Q?po9Qm91X1ZPciUjCcwTPkjtsM9241l0eBMIF/n2FekdL1o4JMzQpA6ATVbKR?=
 =?us-ascii?Q?Vil66sQh4etTzHnt0CnRlSHzywo+2KH1q+hXX5Wz/SjowHYS/z/O/J+sTOd8?=
 =?us-ascii?Q?eBVAiOrsszxKn6qwZTbe1DictbjuTVUd73atBeU7zap8pPPQjLvZpTiXaRDv?=
 =?us-ascii?Q?OFVePhASXLgy+QQhFZyHWUqPUbn9S4GqdbB1v86qZkoHIRzS2kEQwCxjeB/z?=
 =?us-ascii?Q?42jKa7iGShselMu1Ap2mwUk+7u5sd1E5HFhVmaaRvhyZmtS8onBPvzfnsYq2?=
 =?us-ascii?Q?+CPm0yLnruVfpCGsPsW7t/+LUFJMH+6VLnLETc7AO/1NXlhzJfX0tLpw7ln/?=
 =?us-ascii?Q?gsZHYF6b3VdBboOP6l2GT6sWFw+6fx8cnDJBy/9pW9FPuyEPWWTeKfK8SLVm?=
 =?us-ascii?Q?RkCmd4Z9VSKS9RymDGp/IWH5Pn+IK0eHmLxnv2rRO84Z0FBeG+ZZAkbW5aLn?=
 =?us-ascii?Q?AVkZ+D+BHd0hbI3YP2y819hX1pNzU9CLS53gKncHc7pKztT///elwMkQ0j0o?=
 =?us-ascii?Q?YaC7uVw19u9uBmQZGn39SnnpFd3RwPCWMUKKN4USXge9n74okoPEZVpJpxuP?=
 =?us-ascii?Q?d1Hk+/y54n0NnuVh7dPahV7qWIENz9iWi8E+SdF2acXFjKy/cetGIXMLcyYm?=
 =?us-ascii?Q?mNrErzltw7vtNj2b0bnxBRSS6KgUPIL7YoY1Z2HZN/lmrAoMToSNvql0/K0b?=
 =?us-ascii?Q?TlnE1V52wv/TG7+vVqo5pSV/NLTWLbQ9OE5qSM+/DJtwP4H6O97I7AbwIE0B?=
 =?us-ascii?Q?aDpkMG8myqiB/s3leUVU6ztgXuZ6iXFv16k5laA0+mYtdgqLfuvrZsOYKxVc?=
 =?us-ascii?Q?Gf4w5NWIAnQyUJOEsjvZcV+zai+wtjlvxYg+KouWfBEviit/yAnMtUxApN0V?=
 =?us-ascii?Q?pQwYMHv+13lqJoKvtF4sM3kQpOwFTgRKmvCN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 03:20:41.7998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fe075d-3b9f-47bd-d3e6-08ddec2b31c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808
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

v2: rename amdgpu_userqueue_restore_helper/amdgpu_userqueue_preempt_helper to
amdgpu_userq_restore_helper/amdgpu_userq_preempt_helper for consistency. (Alex)

v3: amdgpu_userq_stop_sched_for_enforce_isolation() and
amdgpu_userq_start_sched_for_enforce_isolation() should use preempt and restore (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 53 ++++++++++++++++++++---
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index f941787e3506..7772de16f12b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -45,7 +45,7 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 }
 
 static int
-amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
+amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
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
+amdgpu_userq_restore_helper(struct amdgpu_userq_mgr *uq_mgr,
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
@@ -591,7 +634,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_map_helper(uq_mgr, queue);
+		r = amdgpu_userq_restore_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
@@ -748,7 +791,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Try to unmap all the queues in this process ctx */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_unmap_helper(uq_mgr, queue);
+		r = amdgpu_userq_preempt_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
@@ -933,7 +976,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
 			    (queue->xcp_id == idx)) {
-				r = amdgpu_userq_unmap_helper(uqm, queue);
+				r = amdgpu_userq_preempt_helper(uqm, queue);
 				if (r)
 					ret = r;
 			}
@@ -967,7 +1010,7 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
 			    (queue->xcp_id == idx)) {
-				r = amdgpu_userq_map_helper(uqm, queue);
+				r = amdgpu_userq_restore_helper(uqm, queue);
 				if (r)
 					ret = r;
 			}
-- 
2.49.0

