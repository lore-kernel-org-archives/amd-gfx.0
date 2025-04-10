Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7958BC369AD
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3AAB10EA3F;
	Thu, 10 Apr 2025 18:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZloBQX+8";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 184E210EA0A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXdos+wPOIo9i+zPeqq/z9gvQNlNUem4B0NghZMuxBDZCv9JIeRmayZh2phMIE3bxGBaxkq2uOy08wJVKlAZoPWvzwWsf5nIDcbirVzCaAvAlrGxH8a9/H7UpqC/wBQMb6fLxF49vUL9CvL4IK9fw/ax/8BZAq4ix14DYvZFjmkPKehHk+44oTvR3e3ZQZLKz+Jaqvr4D3TAK0OXpo5wNXnSBXD7VbsD4HxZQgU1t3QAMk9Ps7UJ/OwuLQLwbCxrGjp++m5cigZWr4rY28I/Ma5So46Fx6Wx5ojuviTe82vLr5hIG3KYTYNLbzq2bdkish+kU3mAKpjdxJugke3v1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAC1kOUPBh1ESy2h8qu+20nbAs0cB0D3qjbagO1groU=;
 b=Wz5MKIKy5V5ehEg5YTt0XY33FMSVitvh+JWeUR1FuvmpGwN6nXt/M2UMm+c/QXgSkqj2Sa/2bz4aAp2NV80055SE4cNuGycQZgdP/5fdkE/0wUuZeKNGpsgBfk6Kb/+EeZpnO78D7u3NO31QSE9/9lXv+hubkTIAoGOHsK1LbouZtt4eV8ayfAUBFhEQKYIW0rfMf6a9D6eJ+BPHZnMp29MUxhlpueEC9GAky2rL9xn2GoRTEybFWfyrfQ8cT9K/URK4uqSOZOt5JAclaQ2ipttPXdzm5oe+UD0RyvH++OlDm3oxPqDAH+xlAQqNGwxonpUc37aY1koEkl9Hr9UR1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAC1kOUPBh1ESy2h8qu+20nbAs0cB0D3qjbagO1groU=;
 b=ZloBQX+8xAw+fS3zusfz2WGqp9un1JXjA0T09Ha4bRtV04sUlcfj3qbMnHTuEqDvaWgvEIAEIaRDj+yiqWpBcZEKmSIPLvDC7mrpL0AQ+hZkRhfihKDPfxVldQSG4OT9FHQopxFzv6s5skugwvrNarBo9KvvrWq+2NK8W/B+/FI=
Received: from BN9PR03CA0903.namprd03.prod.outlook.com (2603:10b6:408:107::8)
 by DS0PR12MB6653.namprd12.prod.outlook.com (2603:10b6:8:cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 18:54:22 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::d2) by BN9PR03CA0903.outlook.office365.com
 (2603:10b6:408:107::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Thu,
 10 Apr 2025 18:54:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:54:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:54:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/13] drm/amdgpu/userq/mes: pass the secure flag to mqd init
Date: Thu, 10 Apr 2025 14:54:01 -0400
Message-ID: <20250410185402.2352109-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410185402.2352109-1-alexander.deucher@amd.com>
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|DS0PR12MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f96acb-efb7-4f28-7b4d-08dd78611b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gw9BYmd4VJfws9IbBJR2KX6pfyGJIB1YU/NGp20UZBZiFUh70DMmTHIn9Q9s?=
 =?us-ascii?Q?kGZJLDcEq2w6wmey5Kvw06tTF5VQMtPy6nuUtnqS911mkZQXuOUV57FBGLKG?=
 =?us-ascii?Q?pIDCBNMeGnPtzpcbvIPFW/uqH5gtJhZYD2PXtpn+4vlVv4bpWhM2P8v+U+tB?=
 =?us-ascii?Q?I4XkZnTrERd7JAOxEFtZBrOvQUGKfgErt9koAc71ELtdjj8hClsRsSHyBdKT?=
 =?us-ascii?Q?GSAJhHl2iBPyb8sr014kK5wuGeyNwzgF9kJxWsi5GPkRXKPm0o04wzr76GBl?=
 =?us-ascii?Q?B84bZ1HCFTY5zY1DfxIs4n+VXY+ekjiAil75q45ACwCJVaF/70iTZ83MwJsv?=
 =?us-ascii?Q?t85/tEJxUJH69teEdYe3HAx46fOp6kkBOEiBW7nCivYNxBeAP0w59IyHtWUn?=
 =?us-ascii?Q?gojg4Y+kzxvQI+595OFkZChqYPcXlXdIp0V+iPw72DJYSqjFjykctMbNzI7g?=
 =?us-ascii?Q?mi4t6FEp7BDX5FDwFPjXptfWHag+rvxsjDflRU9ZUoqJRfQOV0kv/TQActTr?=
 =?us-ascii?Q?99+FRJucJSGRAyap3fEong7sC6UOFCwSWkuetWd5SQ6ghhI8ejAxccKtKAJt?=
 =?us-ascii?Q?F9FS5NdxuXVJ9LGuDPMBQyYON49LOH26desQHTEMDfBC95Fw6b7re9nXvki/?=
 =?us-ascii?Q?7jsBjpt2ApB9l0bk/YzZ69PyGYHYo9QUu/8jia60cFBQ0E+766g5evWlcQbP?=
 =?us-ascii?Q?KEbHpOj4Kh1hoj53DjEqU/c+xLvxNj+m0F/fPYKHus1hDelhpqvyPp/lMbfn?=
 =?us-ascii?Q?VsgdtjhPs75p+Hscdc6AScJqFiq5vOGU8U1qdmMaOkPKTVSMHYhbmB+OU7nG?=
 =?us-ascii?Q?z6cM8nnN2NxmMEbsFV40HD50YYoEbj/GeJBouqWRwCR8ve1cMNCD44cwD4vH?=
 =?us-ascii?Q?yPJgHnIGl24vaihEpukHnNULYucm1WP3PcZFuQhG1552SCdQe2gBc2az87N9?=
 =?us-ascii?Q?BUlBd6gAi0A5J63R/8fwZDDHM7I1ZoBnePJ1ZGel60+lR2CGvHFvpbYqSbFR?=
 =?us-ascii?Q?CzSMuy/AD2fV6IMm7dZOydFYjxbEJt7P3hl++zTkcXFI/Q92tYkfNW6KxFPD?=
 =?us-ascii?Q?mQqbr/IEHTFpX8VStcEIRt0k6bfTxBAOrM5L0bnPi2RnA5yKRpeiZ3gjUC6/?=
 =?us-ascii?Q?MmO9UJ+MvVmhZ0YjDCPVEC65oWONs7iCNw1mLIYtfBTmJPudzsZcNPpsA5XF?=
 =?us-ascii?Q?XMyzR/cssJzWlbWo8a639l/net4qXP5bEd9b7GtRCVIbjRX/lJLv4eEEsK4O?=
 =?us-ascii?Q?FY/TnW8g3rPclFJVw2ao3mhWWVrNYSo+TCYlyJ8o9dHX86YPjTC5YndHDuVC?=
 =?us-ascii?Q?QJzTbnHdstBXOFUIIhvgKKS32x3kI+Yhdc1pf/YzfO+122aWUN7onhJSeIFa?=
 =?us-ascii?Q?gSUbEXyM9b+WJ9MFF0/Qu/eSMeJulweNymnVHZ21zpcUqOKIPoFuhNQF1JHU?=
 =?us-ascii?Q?O1yt420AKQ6l/QveRUZnwQbZrIQga7ZBuVATAJUeF/4faWdl9V6jxw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:54:21.9832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f96acb-efb7-4f28-7b4d-08dd78611b37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6653
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

So that we initialize the MQD as a secure queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index f406a9a29bda5..e175f05bba6a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -267,6 +267,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
 		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
 		userq_props->hqd_active = false;
+		userq_props->tmz_queue =
+			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
 		kfree(compute_mqd);
 	} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
 		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
@@ -286,6 +288,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 
 		userq_props->shadow_addr = mqd_gfx_v11->shadow_va;
 		userq_props->csa_addr = mqd_gfx_v11->csa_va;
+		userq_props->tmz_queue =
+			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
 		kfree(mqd_gfx_v11);
 	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
 		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
-- 
2.49.0

