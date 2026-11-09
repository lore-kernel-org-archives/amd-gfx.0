Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DBB606A31C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wmchI4eE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22FF710E8D7;
	Mon,  9 Nov 2026 19:30:23 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ED5810E8D7
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 19:30:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7ruLVAKwDXeG2nASS12p/SByghT+l59UrRLdt+clUnlAzK8Rgy8WyX/QsA0s7Lafx6CZvcIR5OhKf74U2h6Krx4rO51RG3nR/A/akpKEUCJ2qBG4LK7R+OeJUMMaPd7btIGZwlBaHekrbq2yW362OLmm5hcxUijZXgBSbRG4EIJC/W9UdOZkuM7DUAi5ckdArUjCPNY4HmrLfXYqnCqqucfDHOEgVb9Bp0VbV4VdquBOmMpDZI6r3GTvUktEYUzW1xNicDsthIkmFGZTRFeIr80yxqMDPflRc+qDhRbyZXrZMmZrBkaOfOjpRKIAD8pyV6AegcXA8GDnfinSfu0OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVILcg0z7stdMUce/yrx620zO4uW3Qb3LJZADGEz0H8=;
 b=diWiA8zheAPjHFOb2dazEPbCqmu7uVc3T/wMfevYZ6NsHtps0BcGaB9X8ocE+Y0PDMFklZWEpT7VnUBk7AVWSbuZ06SEbOw/B4ffkCLvm6leq7EahybyQpRWFOiv4PPuXcvHPZzPhB+clgHYwZfYand1WRBihaIcRENddEn6W5X/jSJbhm/bdW5rAVPfUwOUtYX3wRixE0XYy09M7+y9uSg/XBW7YX1eaRq3JKf1hp/1XLSSx7diIE63LMjKr9tav10lzIJJfGErVvltS+YP3MHM305EKd9MnzqsAoD0IenrHqmquZNN1dPnf6Qma/vz5oLnnN83r9c8wU1YD7SfGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVILcg0z7stdMUce/yrx620zO4uW3Qb3LJZADGEz0H8=;
 b=wmchI4eE5wNIKpJxEsXaAHKPLNtBCQ69TcEOnZCUeH6vIgyBgmv9w177BJENsyOkozu5ZKx78kKcQHoy3p2v7KbZ6hPK4km797mhby/x2dfV/v9TF+wAUOnRHL5NY1ekK8JYf04pPScsdiyKNd/ATZE0hP21hhbmxNjcc1StnHU=
Received: from CH0PR03CA0083.namprd03.prod.outlook.com (2603:10b6:610:cc::28)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 19:30:09 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::71) by CH0PR03CA0083.outlook.office365.com
 (2603:10b6:610:cc::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 19:30:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 19:30:07 +0000
Received: from alex-sierra-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 13:30:06 -0600
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Lijo.Lazar@amd.com>, <Mukul.Joshi@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, Alex Sierra <alex.sierra@amd.com>
Subject: [PATCH] drm/amdgpu: reinitialize GFX compute across a partition switch
Date: Mon, 9 Nov 2026 13:29:53 -0600
Message-ID: <20261109192953.3746947-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105135053.3501763-1-alex.sierra@amd.com>
References: <20261105135053.3501763-1-alex.sierra@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|PH7PR12MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c7ca93f-15e8-4545-6238-08df3e97dc8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|22082099003|18002099003|6133799003|10067099003|5023799004|11063799006|261028144727099003|261102123227099003|261026121527099003|261009223027099003|261022105027099003|261022075727099003|261021121427099003|56012099006|261021123027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: mqvX94h9mqbk6qCfAeQp9xC6eZcdL9tvbR4r9geTzyAkyuSdfl0kX1M7GdFIZW+5RN6lD8ZpWdCU8Ggce7tLEzH+9IT9Z7qvQDjM4nkDLT6RkD2rPsGNBlW8+FSDpOHHn9t8fLcMaLDQSrMbh+zp9TP4KxR7S4DYpHN0tkRXRrWYyokqizn7y+VMkIMtPPswitDlPFXLU29dDaIZlFAzqwf0lJRjs1AngaDswkBSoJWQ9pcTiIvP22i4PsZwk9wl1EopRHQZw78DPKNq/DB6iM13LS3NAwEUAKKtoaGe+4rCNM77jr9lN9V7s0gXWJ3VhZNIyUTyp8hKITAr7SL4iGQhBVUaeP5zBqkaAEcRPYIECaFqUlzKDvi1+94kQ5vvvDBhJTQ7Xowt/3c++VgXOuQa+UA9AykEYbH8v0OwGVIrrfVjpr7Onl1IFO1HtCmJWzAW1YE24+WX+YLSKWl8H38aj8Ybe5Eu+Tod2G8zRxKdkMoM+NKtPatqAsbGycUCLsMe5hgSl3kVvjTdAYXHGPCZNCOp3GH8FzX4JxVOHwr+WPtmtbyw7Gvxrq68Q6vLkJSJBgL1jQvsdlebH4fjv9CJ9H1iqLax1CyjkAU+zs97xs346lDGFdenlzbSFbYLFXe7jqV1bcExHZkwf1B8kIqVa2RqLxvRgPT9ENp0unc5F1DjgAig25XS5KTgmfalcTHbNc5eypydUWVY39d3Xg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(5023799004)(11063799006)(261028144727099003)(261102123227099003)(261026121527099003)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(56012099006)(261021123027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1MHBvA1uxOxnoYtCkJMIWmTajMKrghBQZezdOiuci/CE6oH8PmrgnJpn4XUaSeXcszDdapitSPfYFHVI8PuG3OTT0JtQZSoU5xoGYkZ+rvjupr1InhTuZ2Lp6FJ9L2uqZHrYN2VO6FBj+EQGEQrAOcdOyL2CzfAxDQQGTN5XhGGa3ANHHsMGo51kjKp9Dg+gnXenz12TowdNJ+iod+qR70i2EbKxD02UHFQ3BNOOOk2HW0tcMVRoQgZI3KGLjIHgqdLPtpxgjQ9hLnx8cNQZKFpSoiyzqYDTYnSZ0v6AHBS5BVEBFlh229Y4B2/er3H5oMGxYnbwMeq2LIl5NIKJIYVfqGvff/HB5rT631XvJl6n8Qq+l61CokQhZJNxoiDByIAq3hi6s4EzxmxYFuCr1Vfh0S7shNWnTUVSpnNDZiM2AZK+m+oeE3FCPd3BxKgy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 19:30:07.0393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7ca93f-15e8-4545-6238-08df3e97dc8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A runtime compute partition switch updates the XCP mode and IMU
partition without passing through GFX hw_fini and hw_init. The MEC,
KCQs, and MES KIQ therefore remain programmed for the previous
partition, including its cooperative mode.

Add optional pre_px_switch and post_px_switch hooks to amd_ip_funcs.
amdgpu_xcp_pre_partition_switch runs the pre hooks while the old
partition is still in place. amdgpu_xcp_post_partition_switch runs
the post hooks after the new mode is committed and before KFD
recreates queues. A failed switch also runs the post hooks, so each
IP can undo whatever its pre hook stopped.

GFX v12.1 uses its regular per-XCC teardown in the pre hook. This
disables KCQs, tears down MES KIQ, and disables the MEC compute
pipes. Clear both MES rings and their writeback pointers before the
switch so firmware cannot replay stale packets when it restarts.

The post hook runs the matching CP resume path, which enables MEC,
initializes MES KIQ for the new cooperative mode, restores KCQs, and
tests the compute rings. If the MES scheduler rings are not ready,
the pre hook does nothing and the normal CP resume initializes the
compute path.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c  | 70 ++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c   | 54 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c   |  8 +++
 drivers/gpu/drm/amd/include/amd_shared.h |  5 ++
 5 files changed, 132 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 41471bc560cd..df6e9da1a11d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -532,6 +532,7 @@ struct amdgpu_gfx {
 	uint16_t 			xcc_mask;
 	uint32_t			num_xcc_per_xcp;
 	struct mutex			partition_mutex;
+	bool				px_switch_stopped;
 	bool				mcbp; /* mid command buffer preemption */
 
 	/* IP reg dump */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 9f4158e06e60..77d9782cf799 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -213,6 +213,30 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
 	return 0;
 }
 
+static int amdgpu_xcp_run_px_switch(struct amdgpu_device *adev, bool post)
+{
+	struct amdgpu_ip_block *ip_block;
+	int (*px_switch)(struct amdgpu_ip_block *ip_block);
+	int i, ret;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		ip_block = &adev->ip_blocks[i];
+		if (!ip_block->version || !ip_block->version->funcs)
+			continue;
+
+		px_switch = post ? ip_block->version->funcs->post_px_switch :
+				   ip_block->version->funcs->pre_px_switch;
+		if (!px_switch)
+			continue;
+
+		ret = px_switch(ip_block);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int __amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 					      int mode)
 {
@@ -237,6 +261,19 @@ static int __amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 		else
 			xcp_mgr->mode = curr_mode;
 
+		/*
+		 * pre_px_switch may have stopped an IP. Each post_px_switch
+		 * decides what to bring back for the mode settled above.
+		 */
+		{
+			int px_ret = amdgpu_xcp_run_px_switch(xcp_mgr->adev, true);
+
+			if (px_ret)
+				dev_err(xcp_mgr->adev->dev,
+					"Failed to restore IP state after partition switch failure: %d\n",
+					px_ret);
+		}
+
 		goto out;
 	}
 	amdgpu_xcp_sysfs_entries_update(xcp_mgr);
@@ -855,27 +892,48 @@ void amdgpu_xcp_update_supported_modes(struct amdgpu_xcp_mgr *xcp_mgr)
 
 int amdgpu_xcp_pre_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
 {
+	struct amdgpu_device *adev = xcp_mgr->adev;
 	int ret = 0;
 
 	/* TODO:
 	 * Stop user queues and threads, and make sure GPU is empty of work.
 	 */
 
-	if (flags & AMDGPU_XCP_OPS_KFD)
-		ret = amdgpu_amdkfd_prepare_partition_switch(xcp_mgr->adev);
+	if (flags & AMDGPU_XCP_OPS_KFD) {
+		ret = amdgpu_amdkfd_prepare_partition_switch(adev);
+		if (ret)
+			return ret;
+	}
 
-	return ret;
+	/*
+	 * IP-specific prep while the old partition is still programmed.
+	 * enable_mes_kiq and similar checks belong in the IP callback.
+	 */
+	ret = amdgpu_xcp_run_px_switch(adev, false);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 int amdgpu_xcp_post_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
 {
+	struct amdgpu_device *adev = xcp_mgr->adev;
 	int ret = 0;
 
+	/*
+	 * The new partition mode is already committed. Let each IP
+	 * program itself before KFD recreates queues.
+	 */
+	ret = amdgpu_xcp_run_px_switch(adev, true);
+	if (ret)
+		return ret;
+
 	if (flags & AMDGPU_XCP_OPS_KFD) {
-		amdgpu_amdkfd_device_probe(xcp_mgr->adev);
-		amdgpu_amdkfd_device_init(xcp_mgr->adev);
+		amdgpu_amdkfd_device_probe(adev);
+		amdgpu_amdkfd_device_init(adev);
 		/* If KFD init failed, return failure */
-		if (!xcp_mgr->adev->kfd.init_complete)
+		if (!adev->kfd.init_complete)
 			ret = -EIO;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index fee6b1b433cd..3592b95371b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -4041,6 +4041,58 @@ static void gfx_v12_1_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zero */
 }
 
+/*
+ * A runtime partition switch does not pass through GFX hw_fini/hw_init.
+ * Stop the GFX compute path while the old partition is still programmed,
+ * then restore it after the new mode is committed.
+ */
+static int gfx_v12_1_pre_px_switch(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int xcc_id, pipe, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+
+	if (!adev->enable_mes_kiq)
+		return 0;
+
+	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
+		if (!adev->mes.ring[MES_PIPE_INST(xcc_id,
+						  AMDGPU_MES_SCHED_PIPE)].sched.ready)
+			return 0;
+	}
+
+	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++)
+		gfx_v12_1_xcc_fini(adev, xcc_id);
+
+	/*
+	 * MES firmware restarts with its read pointer at zero. Clear both
+	 * rings and their writeback pointers before bringing the GFX compute
+	 * path back up, otherwise firmware can replay stale packets.
+	 */
+	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
+		for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++)
+			amdgpu_ring_clear_ring_and_ptrs(
+				&adev->mes.ring[MES_PIPE_INST(xcc_id, pipe)]);
+	}
+
+	adev->gfx.px_switch_stopped = true;
+	return 0;
+}
+
+static int gfx_v12_1_post_px_switch(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	uint16_t xcc_mask;
+
+	if (!adev->enable_mes_kiq || !adev->gfx.px_switch_stopped)
+		return 0;
+
+	/* Cleared first so a failed resume is not run a second time. */
+	adev->gfx.px_switch_stopped = false;
+	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
+
+	return gfx_v12_1_xcc_cp_resume(adev, xcc_mask);
+}
+
 static const struct amd_ip_funcs gfx_v12_1_ip_funcs = {
 	.name = "gfx_v12_1",
 	.early_init = gfx_v12_1_early_init,
@@ -4056,6 +4108,8 @@ static const struct amd_ip_funcs gfx_v12_1_ip_funcs = {
 	.get_clockgating_state = gfx_v12_1_get_clockgating_state,
 	.dump_ip_state = gfx_v12_1_ip_dump,
 	.print_ip_state = gfx_v12_1_ip_print,
+	.pre_px_switch = gfx_v12_1_pre_px_switch,
+	.post_px_switch = gfx_v12_1_post_px_switch,
 };
 
 static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_compute = {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 3585897c817d..a8153c504c41 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -679,6 +679,14 @@ static int mes_v12_1_set_hw_resources_1(struct amdgpu_mes *mes,
 			mes->shared_cmd_buf_gpu_addr[MES_PIPE_INST(master_xcc_id, pipe)];
 	}
 
+	dev_dbg(mes->adev->dev,
+		"MES(%d, %d) SET_HW_RSRC_1 coop=%u enable_coop=%u kiq_ver=0x%x mode=%s\n",
+		xcc_id, pipe, mes_set_hw_res_1_pkt.mes_coop_mode,
+		mes->enable_coop_mode,
+		mes->kiq_version & AMDGPU_MES_VERSION_MASK,
+		amdgpu_gfx_compute_mode_desc(mes->adev->xcp_mgr ?
+					     mes->adev->xcp_mgr->mode : -1));
+
 	return mes_v12_1_submit_pkt_and_poll_completion(mes, xcc_id, pipe,
 			&mes_set_hw_res_1_pkt, sizeof(mes_set_hw_res_1_pkt),
 			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index e81ce9d79009..db24bacb8e0e 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -446,6 +446,9 @@ enum amd_dpm_forced_level;
  * @get_clockgating_state: get current clockgating status
  * @dump_ip_state: dump the IP state of the ASIC during a gpu hang
  * @print_ip_state: print the IP state in devcoredump for each IP of the ASIC
+ * @pre_px_switch: IP-specific prep before a compute partition switch - Optional
+ * @post_px_switch: IP-specific programming after a compute partition switch,
+ *                  or after a failed switch - Optional
  *
  * These hooks provide an interface for controlling the operational state
  * of IP blocks. After acquiring a list of IP blocks for the GPU in use,
@@ -476,6 +479,8 @@ struct amd_ip_funcs {
 	void (*get_clockgating_state)(struct amdgpu_ip_block *ip_block, u64 *flags);
 	void (*dump_ip_state)(struct amdgpu_ip_block *ip_block);
 	void (*print_ip_state)(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
+	int (*pre_px_switch)(struct amdgpu_ip_block *ip_block);
+	int (*post_px_switch)(struct amdgpu_ip_block *ip_block);
 };
 
 
-- 
2.34.1

