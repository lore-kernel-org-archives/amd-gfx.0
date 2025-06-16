Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D12C71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 09:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6969710E314;
	Mon, 16 Jun 2025 09:39:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JrKm1wUY";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A37B910E314
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 09:39:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIjftWiStFjxqGHmMN45mxDRBXH0N+ofeqz+yYPI4JcbLurQE3CuoY2lc8CKhoBoLUOUl9kODRAZ5y4KXzCipxymRN7L1I1BZg9YTJdgabhyisdqzOtWv2AeNS6e4RaSiIsVIWCb57m0GR6A0ILpoyhiz+tjDM6PbOtK3fOY/3SLiXr9DFs+HD6qlzNWp66YsD1LVRop3d+xX9CL/uG5sNnbwvjxaDT38mUUTG651Mw/res5FzshGZw+wctbIUlmnPl9wPdVAh2cVA2jje/Qh+fWqT7PMSTFb235V5F9JTqob8jV8u7rFiYBPvP4ndZpIv1GF8nbSfQ8GkEr+CIxdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRAuuMj5tvWenYcZQBBDAkJRukH0arynAa6gYWlU47E=;
 b=BHxHE/CFZDwQ74EbP5xDR1F2G3B8ESdIbPbnGcg+lHd63v4oKu41z6gg5TxGqCpTBeCnJQjqhvsxTWNPQNa0uYa+AJHbitRmGXjB20YL2fGWVbZB83VcoBjci0ISzkO1z/Hzo24093/i6Bxpwp02rXmMjEoByMCwyZ/UslSZFHmH6RfureZPAce+1szPCaJ55NexkvOH4Q8K3Scrwplc5SeQdejGgJ78MYOmjURM9S0GENHFKpO4a4+Q3Scr0ECfr4M8vabdq58QLx7lfSk/nnTSa7etRoLUZOyzxhfCopNoejmNGW6SBUej2PEQ82m+ZTvaudmEu8trl8GS9TELSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRAuuMj5tvWenYcZQBBDAkJRukH0arynAa6gYWlU47E=;
 b=JrKm1wUYvWzFwFOZEd7nhCVGzYNmI8lsQfSQWH+joMC/RzYmzF/L2RAgMs1ORbqoCsfCK2zXHWWJ5mixe3MucrIYLhgK4W8DuMRRqDpk/Zmo/T31Bykcb4jqC3rp1jocOT8wfrrnVuMa8cFKLNrXzY6BfxFHyZCt6Vp3k8vf31c=
Received: from CH5P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::12)
 by CH1PPF7A6EE32B1.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::616) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 16 Jun
 2025 09:39:10 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::24) by CH5P221CA0016.outlook.office365.com
 (2603:10b6:610:1f2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.26 via Frontend Transport; Mon,
 16 Jun 2025 09:39:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 09:39:09 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Jun 2025 04:39:07 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, Le Ma
 <Le.Ma@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 06/10] drm/amdgpu: Convert pre|post_partition_switch into
 common helpers
Date: Mon, 16 Jun 2025 17:37:52 +0800
Message-ID: <20250616093756.16200-7-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250616093756.16200-1-Hawking.Zhang@amd.com>
References: <20250616093756.16200-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|CH1PPF7A6EE32B1:EE_
X-MS-Office365-Filtering-Correlation-Id: 129976e0-815f-44b3-259c-08ddacb9a512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iPxloDhfXHCq3RfhS29nz4wnC4Uh4JXlOZK6+3V4y6HLyQYKk/qIizi5TYw7?=
 =?us-ascii?Q?B/p+PLOe0YuXO/t1Ux4DCDj4zZBGUKfWjb9LjtA3I1LKgyo9hg21AsU+Kff2?=
 =?us-ascii?Q?FpU4ZtPou437a1G2OmL8KyPFvw+STA0U4YDLMDVroDffvqYlWFF+Gn67G2C6?=
 =?us-ascii?Q?WXIC5O6FINC89GMUYro2x9pIpPmLz1N1G5JgFZF+yO9GYBgoLLi0Jj4SuCDF?=
 =?us-ascii?Q?GAucni30iWVpap96NW2hCFcOuNJONpH72KpC3yStxPMJp9PMyOvPVWiJmv1l?=
 =?us-ascii?Q?bokhqIU66bhHN/UckmYsT+G1YjiT85Da8I7CbswJ7i23VLMrh/idXC+5+UpT?=
 =?us-ascii?Q?7lDHXsn0UsLyWhFTlRW+KjdGSAKnYiuN7cARJSjJfpqDZ19lWNbL5iXCmfVy?=
 =?us-ascii?Q?15vc7S6kPOmZi90w5G/8zGXkPktNtjhtdGqAelEVZ/OMH927wSCqWoJv6+6j?=
 =?us-ascii?Q?l5xtwHmpSCKA5JXcGwkg9MSiMRZ+cGHvXfI/BibCwnsFkRKv8iC8XVU2Zyjy?=
 =?us-ascii?Q?0LjsSRxNXx0S8G02jtHqAn21oWjVT6fCFuk8ANIqXaGs17DU1ZfgKty2e3Ds?=
 =?us-ascii?Q?Op9k7GuL9VgTTrw7hMbisWi9itai/ECzywBkKoEymLYSP+SVzjlcl58wl/mZ?=
 =?us-ascii?Q?MbGEEAmi0WKEzruwTOM7iGNj5W93cV2blJeAEfjyZOswDcXtVSp2VxIs/PUB?=
 =?us-ascii?Q?Q1MedhKcYdqEeTK5J3qVpI6/oQhX9Px5l/utNpHGF9lE1ixSE7VbrEvccdij?=
 =?us-ascii?Q?vHpvPAvHHanyt9MozdgnY6akvKm/Ibfau1AfIb+vzDgyJyjb+OxdGLJN5bsO?=
 =?us-ascii?Q?zRjgkMzCSMnusM5+LPrs+YlT3Ky+6Bvilu8km2vaNrcBLW1DIKwoTHnjUaQb?=
 =?us-ascii?Q?rKN40mGHUZsC6iSjvDfbIyYMUdoru+uECrSDCybz35SDCvwKf0YaLvsABQ+q?=
 =?us-ascii?Q?Ph2csL49Eyf46rFCgqPU6UyR2CJCb5W/7eynO5AfbRbpHPl/swbBIAdMvrIq?=
 =?us-ascii?Q?ZjZZoqpONnUs7ggiMvloLWb+oy2sJzwn/E6byjLCsZiMLBBenGtuvDF3/kML?=
 =?us-ascii?Q?P9N1ICzXkdvJMGxc1/FX5QbbqWvWjOXGaiwIgrtOGtAh275noL+BoX7DgzAj?=
 =?us-ascii?Q?NwpvFERuNBBBChRfTe75FbMrVlp4wjulZ3aZxa/xjCxgMvHjxqZw1HYpJM1O?=
 =?us-ascii?Q?fsgnt9i2Ag+HjFEI25Ui+Fh0mXRI8G3sAjGUCZAVk6J9HXY/Wgr+r2dWxG86?=
 =?us-ascii?Q?Ct0fCNmCik76ItfF8TC50kJCanPWHU1GhesCbmozzWY3t9oPI+cg0GCPKyUx?=
 =?us-ascii?Q?XvJ6ROrPQyrlW0rd7wkflcisPA1h/6NKfEdggXTkRHApb7hhiDoDWq9g/EUy?=
 =?us-ascii?Q?5tg4np60aXJ7CFBFr5y2PL62Y7x5MbXgOXqUDyHDH11m1LzOnqRJPOJjwLuF?=
 =?us-ascii?Q?kW+Au68g9+xBvovOczPOWcxvPxn6pz5yOOLVnorcOwMndXWVEqFgCxVHaNt/?=
 =?us-ascii?Q?2G8YsMfZOO3F3Kq1I69pWWymI/2yfkJw5Qxx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 09:39:09.4030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 129976e0-815f-44b3-259c-08ddacb9a512
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF7A6EE32B1
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

So they can be reused for future products

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 27 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  4 +++
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 33 ++--------------------
 3 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index d2423abac68b..7f9b669bbf86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -631,6 +631,33 @@ void amdgpu_xcp_update_supported_modes(struct amdgpu_xcp_mgr *xcp_mgr)
 	}
 }
 
+int amdgpu_xcp_pre_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
+{
+	/* TODO:
+	 * Stop user queues and threads, and make sure GPU is empty of work.
+	 */
+
+	if (flags & AMDGPU_XCP_OPS_KFD)
+		amdgpu_amdkfd_device_fini_sw(xcp_mgr->adev);
+
+	return 0;
+}
+
+int amdgpu_xcp_post_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
+{
+	int ret = 0;
+
+	if (flags & AMDGPU_XCP_OPS_KFD) {
+		amdgpu_amdkfd_device_probe(xcp_mgr->adev);
+		amdgpu_amdkfd_device_init(xcp_mgr->adev);
+		/* If KFD init failed, return failure */
+		if (!xcp_mgr->adev->kfd.init_complete)
+			ret = -EIO;
+	}
+
+	return ret;
+}
+
 /*====================== xcp sysfs - configuration ======================*/
 #define XCP_CFG_SYSFS_RES_ATTR_SHOW(_name)                         \
 	static ssize_t amdgpu_xcp_res_sysfs_##_name##_show(        \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 98fe270d8437..cba9ed07cc1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -39,6 +39,8 @@
 
 #define AMDGPU_XCP_NO_PARTITION (~0)
 
+#define AMDGPU_XCP_OPS_KFD	(1 << 0)
+
 struct amdgpu_fpriv;
 
 enum AMDGPU_XCP_IP_BLOCK {
@@ -179,6 +181,8 @@ int amdgpu_xcp_select_scheds(struct amdgpu_device *adev,
                              struct drm_gpu_scheduler ***scheds);
 void amdgpu_xcp_update_supported_modes(struct amdgpu_xcp_mgr *xcp_mgr);
 int amdgpu_xcp_update_partition_sched_list(struct amdgpu_device *adev);
+int amdgpu_xcp_pre_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags);
+int amdgpu_xcp_post_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags);
 void amdgpu_xcp_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_xcp_sysfs_fini(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 2dfffacfc8de..1128db0ecb9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -34,8 +34,6 @@
 #define XCP_INST_MASK(num_inst, xcp_id)                                        \
 	(num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) : 0)
 
-#define AMDGPU_XCP_OPS_KFD	(1 << 0)
-
 void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev)
 {
 	int i;
@@ -366,33 +364,6 @@ static bool __aqua_vanjaram_is_valid_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 	return false;
 }
 
-static int __aqua_vanjaram_pre_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
-{
-	/* TODO:
-	 * Stop user queues and threads, and make sure GPU is empty of work.
-	 */
-
-	if (flags & AMDGPU_XCP_OPS_KFD)
-		amdgpu_amdkfd_device_fini_sw(xcp_mgr->adev);
-
-	return 0;
-}
-
-static int __aqua_vanjaram_post_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
-{
-	int ret = 0;
-
-	if (flags & AMDGPU_XCP_OPS_KFD) {
-		amdgpu_amdkfd_device_probe(xcp_mgr->adev);
-		amdgpu_amdkfd_device_init(xcp_mgr->adev);
-		/* If KFD init failed, return failure */
-		if (!xcp_mgr->adev->kfd.init_complete)
-			ret = -EIO;
-	}
-
-	return ret;
-}
-
 static void __aqua_vanjaram_update_available_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
 {
 	int mode;
@@ -439,7 +410,7 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 			goto out;
 	}
 
-	ret = __aqua_vanjaram_pre_partition_switch(xcp_mgr, flags);
+	ret = amdgpu_xcp_pre_partition_switch(xcp_mgr, flags);
 	if (ret)
 		goto unlock;
 
@@ -452,7 +423,7 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 	*num_xcps = num_xcc / num_xcc_per_xcp;
 	amdgpu_xcp_init(xcp_mgr, *num_xcps, mode);
 
-	ret = __aqua_vanjaram_post_partition_switch(xcp_mgr, flags);
+	ret = amdgpu_xcp_post_partition_switch(xcp_mgr, flags);
 	if (!ret)
 		__aqua_vanjaram_update_available_partition_mode(xcp_mgr);
 unlock:
-- 
2.17.1

