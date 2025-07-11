Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB48C8303C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 09:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E0A610E9FE;
	Fri, 11 Jul 2025 09:40:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ujT7XwGe";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D7FE10E9FE
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 09:39:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaUy9sWGOeZ4C/yGgTluQ5QU72XAWadfgYP/vLvOzTAVtCAS4KBoUMnhdl046RuaSEXJaRvBvonYVD+JRMi+04KZQMv+tGmzZGzIQQdaarUnmycsumEh9OAOjF27gRhjkJo+LgOPhzZN5+LRcuCH/Pyx4w3xpNoILUCwfWP93y7r2z5YF7MFh+BHEXMu067XpiXA65KrEiIoV/cfsSDuccZclQckVRz4yvianasn04yc1+ygADz5hNWDRUWp5sSFj0TrSxst+MnRv4FjuLqKxsWniwXlg9fPPiLKW9BeIoyBT8ongj1Fn4ohfzUUXAMiSg7zft44Aj4ugAB+m438FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTo6B5Ao0kAxs4w0KfWdbZczd6XpHfnd0opj+m4o66k=;
 b=BzlGvDzWpZ06xf+fREPwtmPEUwM8lHVkJNl5zWbA6qL7AVARdTjZqSyQwFkl66k91/B6VHARCUVsjkNvW3yYajTYO7ZtZCTQrBrNyHEi/CSJ90TiqchcDOQmZFH3wTHJ7u8WYXIee3jnlW2o2N0HGXDvLh+yKXr0ePNIv1RJ6yTtH6P5t1Ta076QXRGQ6EmThlwScZWLAsY5q0oAjs8kwF9SUza2yjxGpwDVHI5+he07o73AflBLa1oxcKF3ZD3s/Ob2sVFoVvDiEocg/+Wb+OMNnkx5gw7oyG/GqUpI+25ulwV886RkyHrU24kqarHK6HR38Sr9RBkLr+ld96M1Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTo6B5Ao0kAxs4w0KfWdbZczd6XpHfnd0opj+m4o66k=;
 b=ujT7XwGerHTgXgRsULpgAun1MwNTKfIHwGG3rLRs1x6utLiugRgvh5IaPLh3KBmEc5+DIffuaWWAL+Uqzs/PAWF/O/rW4V1Ltopm7TdlcmAfBI0wGVLXEcK3w2MJcFEZISydV2Llsu+UnGP7xpIdqi/8GNlVCraqRPtSgVNQlf4=
Received: from MW4PR02CA0018.namprd02.prod.outlook.com (2603:10b6:303:16d::17)
 by DS5PPF1ADAD2878.namprd12.prod.outlook.com (2603:10b6:f:fc00::646)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Fri, 11 Jul
 2025 09:39:53 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::76) by MW4PR02CA0018.outlook.office365.com
 (2603:10b6:303:16d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Fri,
 11 Jul 2025 09:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 09:39:52 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 04:39:50 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v6 07/11] drm/amdgpu: validate userq's last fence prior to
 destroying
Date: Fri, 11 Jul 2025 17:39:26 +0800
Message-ID: <20250711093930.1411470-7-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711093930.1411470-1-Prike.Liang@amd.com>
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|DS5PPF1ADAD2878:EE_
X-MS-Office365-Filtering-Correlation-Id: ad955718-ee93-47c0-27aa-08ddc05ee32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0LWiZmDbEX35JgFiOAEk38JfCSKzr8/g5YYqTdz4LTF1ZGEm9/pWUXjn+QZj?=
 =?us-ascii?Q?Q4VXqfqgJCZraHTe29RtHBlwSM8+rv6XBHI/auODKHkJvMafak1ivWNcMVUp?=
 =?us-ascii?Q?HjHXxMgImZtYe50t0mP/h4WhKk7qXP9GDJ70DNccgMobp2eN8qdCmclSEzMY?=
 =?us-ascii?Q?Q/v0W/dhgx2mhKNnQbZk2TgVFPfzE3WDlxBWSXxZXGeyRKkm2DrWoGNa/8x1?=
 =?us-ascii?Q?fABJJixw3FYtE6k9yFq2bVYOLhusaGCBITawRnWK+/s2sNyyriIH+Lw5hHD0?=
 =?us-ascii?Q?D1ktyDLoKRTVcMU46uTLz0PQIUcO85FIIrziREzdFAXhPn22hdnBBxIMzKqC?=
 =?us-ascii?Q?/ggMvrw1kGvOfrvqi3Tzkt4q/FyxZMA4KvgpLD8eheCC79hIeFxkokB8cXi+?=
 =?us-ascii?Q?NL1Bd8fULvtWLv1MjWzPZYYVjeIygfziXSMpw3a6hqB6+oFphmDlklxYoqaY?=
 =?us-ascii?Q?IE4C6ZXCZoriH1YFNf7jJV3Nq3bKrYKRUVDUMxdyUqXA3JZjuVX4OmBLuQRP?=
 =?us-ascii?Q?AQ+sd25SwZcZZbrApji5JlpWGJsVMPJYoTO3aN996jW/fJmDG/HLYWGD75FF?=
 =?us-ascii?Q?l6DSRGI91uNUTz7340QlyedpEwqSNWnAhvRSdZA8fhqvnDTjj3pPJMhk7nV7?=
 =?us-ascii?Q?o6RS98Nx9QkldRj0v1H8lmyfjy59Azh5fPsxQ/c8ZmbNTf3gCYSLr+P+j/p9?=
 =?us-ascii?Q?bTjMi9gMfmD7iWkbdDiz4hdUsDPWC+6Gf6lyFDELdju7x6L0R8r6KFpWngtP?=
 =?us-ascii?Q?I+jdKJJDL0hfZmCDbae2iTaXFETIfbKttTJM548B856ZI7wbVBfInF/dWw5f?=
 =?us-ascii?Q?MtVi8ZcRZEYY7tz4Wk/PfIGoPO8636UPE3ymKL0zOJTBS0fwIbL+t+CSDIUJ?=
 =?us-ascii?Q?VUxnnqF5tM0Y6XpbsNorGU7hJr+O3AtLnNL1LF5hT7Evtl+OELVxwC7EJrE2?=
 =?us-ascii?Q?X8Jm+rdrwrw5gDD8ExEMhQdEguWEOi/K1VEuvV5MZcFUffXL9SuUdGEuBUiQ?=
 =?us-ascii?Q?aulKQPCD+nQPWWX8ZPn6252va3Fp3PZVnIgjDIzqMjudO+K9hGP0stlRwIHE?=
 =?us-ascii?Q?j558tbI9BmUtnqakRcibstiw1P1aLLUQMcMhrsAFi2nne5JaazQdyVf6Fdv1?=
 =?us-ascii?Q?oX1NPc1tdS3thoa7ab3UkaoKo3HTJ81ZVTcblIk3GFAocPQB9rTVlM3u+b2T?=
 =?us-ascii?Q?nj+3H9bIdr8L/2wQeD1tbIpwMhLHacceUDZnZ8oiObdxV5UxEcts2nWBIeva?=
 =?us-ascii?Q?gLGO5q4+8ts8IKZzUcsM42IroqFzcvLUdY+YicNqwT/bITDf+KKbJRQLkpqA?=
 =?us-ascii?Q?j6uXHEBcvXs/7IKp8IDTKaw2RoCQ7K9bz5PRZ3Ut8EosgbFfGGBO1ThrQWdm?=
 =?us-ascii?Q?OsUdJHFdxsknQh5xtbiECq6Ouc/7o/1jXmIKrHN/3Pi+7JI7u0tevj+EDOBA?=
 =?us-ascii?Q?JHgTBjPH20UogIQDGTyTvBxvSJUoeQsN8nHVwn39J69iKDsaMUO9R/W/tjMp?=
 =?us-ascii?Q?3Mvpl7ew6D7LJkS/5bz7//WWEczxuxaEPhZq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:39:52.5853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad955718-ee93-47c0-27aa-08ddc05ee32b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF1ADAD2878
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

The userq requires validating queue status before destroying
it, if user tries to destroy a busy userq by IOCTL then the
driver should report an error for this illegal usage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 81fbb00b6d91..bcbe8d3f66ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -281,7 +281,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-static void
+static int
 amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_usermode_queue *queue)
 {
@@ -290,10 +290,14 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 
 	if (f && !dma_fence_is_signaled(f)) {
 		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
-		if (ret <= 0)
+		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
+			return -ETIMEDOUT;
+		}
 	}
+
+	return 0;
 }
 
 static void
@@ -509,7 +513,12 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		mutex_unlock(&uq_mgr->userq_mutex);
 		return -EINVAL;
 	}
-	amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
+
+	if (amdgpu_userq_wait_for_last_fence(uq_mgr, queue)) {
+		drm_warn(adev_to_drm(uq_mgr->adev), "Don't destroy a busy userq\n");
+		/* For the fence signal timeout case, it requires resetting the busy queue.*/
+		r = -ETIMEDOUT;
+	}
 
 	/*
 	 * At this point the userq obj va should be mapped,
-- 
2.34.1

