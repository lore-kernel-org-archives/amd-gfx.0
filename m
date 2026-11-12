Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E86606A31C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 00:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kwslyfkN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97FC6112417;
	Fri, 13 Nov 2026 00:21:09 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A31B7112340
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 00:21:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B715htpykXbp32j3t27BoLZb+FD1dKDPhTYZxJp4BxcPhXtyL9VjPPnYu4XO5SWp3haKRWT92C8ERYboTCXjakKN0IgWxxpUyjPwrxGdnymIAeoL8WGFDItUNZxbaN42b8GtrpdX53oV7F7V3aq/3c1MQ9YwOViplcXLVSFjhcX+2fDk+GKociOa7zaSFMWVjcXaAVgrJtq7WkA2fj4BIg0NrJ1QHcfrvn3iyk1o+ojlm0K8bM7QFCDAQN8Sjd6GsAAq4qFIPOE+ZyxX+T9afrNotMYQgU8WN96eXLdfLr8PjAU3WYQJUjl7bwNCFRrr24HS8SkTHWQUBIrCqRGk1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMKZq4BEZFxtXkaeNXMcpoMp3Lyz6WtfKM9jVzlwI7E=;
 b=b0SPSgQn79H0CAPkMQ4ya6Rx+Znv3vQR2xVGkdmcJTXB7tOMNLwj9FX5aYJZb2aI+YK55lG7LDu+zsniOY+U60kQbCrKrZIGZ1T9/ItXtNfj2sEJnuu+Dv/2D4NJMAaGg9qfC5kdDFo/FZbgFWupFkgP2nTeXGbVaXqsMQf0AGzJ9QMUS3dVLCjU4juifXSyuQiv4xHc4b+rze4gkr/Jgsi9Y276gjqpkrOW85SAUta2SzjrjtzmcZx2SDwzFh8Pg1+Wc8BSLXueFdVwDVmsDp4XKIwYy5+YmG11EzYqy0HkgahfP4FRpQfB63+GDqL8N5sqLQDpj0pznmaK1lQ83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMKZq4BEZFxtXkaeNXMcpoMp3Lyz6WtfKM9jVzlwI7E=;
 b=kwslyfkNpUPqbRfCs6tlqBq0pKP1xjp/pj8I1z5jL2FOp0pesqEo/rs2mgZzD0b6U0eBTxtDTQajr5Ld4Ot803CDcinhWcQNZK9nLFuCtC1Nb4vbgLj/i3+E4rS3J08+GebQsnKuRNBbV8vk6iJIj/CDIF3hz8/8ZcIwVmGf7Tk=
Received: from YQBPR0101CA0257.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:68::6)
 by LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 00:17:37 +0000
Received: from MW1PEPF00018892.namprd03.prod.outlook.com
 (2603:10b6:c01:68:cafe::1) by YQBPR0101CA0257.outlook.office365.com
 (2603:10b6:c01:68::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Fri, 13
 Nov 2026 00:17:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00018892.mail.protection.outlook.com (10.167.249.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 00:15:25 +0000
Received: from alex-sierra-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 16:12:28 -0600
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Lijo.Lazar@amd.com>, <Mukul.Joshi@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, Alex Sierra <alex.sierra@amd.com>
Subject: [PATCH] drm/amdgpu: reinitialize GFX compute across a partition switch
Date: Thu, 12 Nov 2026 16:12:17 -0600
Message-ID: <20261112221217.4015963-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109192953.3746947-1-alex.sierra@amd.com>
References: <20261109192953.3746947-1-alex.sierra@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00018892:EE_|LV3PR12MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b45a78e-3331-4d6f-e6e3-08df411b3738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|6133799003|261026121527099003|261009223027099003|10067099003|261028144727099003|261026140227099003|3023799007|261021123027099003|261102123227099003|261022105027099003|261021121427099003|261022075727099003|56012099006|18092099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lelfu75roA9WgFMzGXz0bTiGKUDzTNeKiAbHf6hUDAX6vSXFU8uR8OMryKn1j2y+na3GNOjSyRF7b3bQR0mPpjwGg7pRx1ObSeTzMPl+YIz63o7Fd7Xjhx1nnHZd6rQUhgQtG3C3LRejYoEIIKDduvU+zHd2pDhVJzfBhOnpi0rG3Y0CifPFx4hGGCPH0XqZb7X/NBuSoDZDPc1KK4qtD9TOQL8gBiVcSsofiYXQyUJctgt2CkwjEm6k09w2iOoaS0GUh/b8QFta34woxqQZZePaxXSSzZC5W1hDNh4c4yUJwSwbDqeSrKEzChobh4Kf892g2HQMKLnoMPKOjFY0ykGXCTcCKe2AT00rNfBE0Lfa/UxIiqSS+MoV5c7ANUbcN6sXf4WG7oQldZB3o3+IwiAGlArUgoYbT0kNtLDcUqgXtzmnpAmc3KuNid/OIMAONtW/6ZJICOUApULau3BzylagwInQcn4U1LnsCgosiBHMUY3jFOSVTJIz34/wrgAnTUuin2v9ZfubAXSSRxKrpZKNo6SS949JuRfhZlw0oeoGqFORZPQwwwk9qEPqcpd9kIBTDTWi8vJrP9pbA3pjTyUcncEvFZbvYnCmgHlDflzjAekLK7HiGVwSadrFm+04BzRB59M8KRXgcOS/a2z5yAX/GszeX1W+aPEZiJyhbrqo2McEhCWBMGtLf+4adqxrljRvCw6YZiLKfcZDsSP7+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(6133799003)(261026121527099003)(261009223027099003)(10067099003)(261028144727099003)(261026140227099003)(3023799007)(261021123027099003)(261102123227099003)(261022105027099003)(261021121427099003)(261022075727099003)(56012099006)(18092099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ONv3KDSSBfRdMvLiKHrNeZj6FHErFkYGtBkgz1Rw0aZjc9wNcU+H0uUq4RhcRvaxX6i3eEDFWI9TpHA9J1v8oUrQjKyand7F1bfowJesYEAMZuAz1IlfqVXt43qy3mbKFg8Ul4NOG8q8mET8t2pppTyHhM8M85dJNkDP3Gw/SJYnnaRLE+LCXzi4I3c/Q92AAuPmqDvG4pNsRHQLO7ZuqtRmGZMKHL7MZDnqA0OfIprAvJYyfDmktDTX5pTb0d1bObxaAKiEPRNBvx1AP5K4R7Z2HCm7zGJCvusYYiD/As4v+wD0lc96AgaH0LAAQUn23wdyPnPFhuMirRuCvYUBcq2eBR4OQ9pSOakih4kG9qsdqGC0aVqBNsJLvEnvyOCmrC17V++sgHHr18wgcRISZLAqsGEEERMIF+7CJVR0e1NcUkZIgRwCm6Fz/MVTUNfZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 00:15:25.1683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b45a78e-3331-4d6f-e6e3-08df411b3738
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00018892.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409
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
recreates queues.

Run the IP hooks only for a runtime switch with a known current mode.
Skip them during initial mode setup, reset or suspend recovery, and
amdgpu_xcp_restore_partition_mode, where the regular IP initialization
path restores the hardware. If an eligible runtime switch fails, run
the post hooks to undo any state stopped by its pre hooks.

GFX v12.1 uses its regular per-XCC teardown in the pre hook. This
disables KCQs, tears down MES KIQ, and disables the MEC compute pipes.
Clear both MES rings and their writeback pointers before the switch so
firmware cannot replay stale packets when it restarts.

The post hook runs the matching CP resume path, which enables MEC,
initializes MES KIQ for the new cooperative mode, restores KCQs, and
tests the compute rings. Track whether the pre hook stopped GFX so the
post hook only resumes a path that was actually torn down.

Add debug output for SET_HW_RSRC_1 to expose the cooperative-mode
selection used while validating the new partition state.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 88 +++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  3 +-
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     | 54 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c     |  8 ++
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c      |  4 +-
 drivers/gpu/drm/amd/include/amd_shared.h   |  5 ++
 8 files changed, 152 insertions(+), 15 deletions(-)

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
index 9f4158e06e60..158faa362606 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -213,8 +213,32 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
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
-					      int mode)
+					      int mode, u32 flags)
 {
 	int ret, curr_mode, num_xcps = 0;
 
@@ -224,10 +248,15 @@ static int __amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 	mutex_lock(&xcp_mgr->xcp_lock);
 
 	curr_mode = xcp_mgr->mode;
+	if (amdgpu_in_reset(xcp_mgr->adev) || xcp_mgr->adev->in_suspend ||
+	    curr_mode == AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
+		flags &= ~AMDGPU_XCP_OPS_IP;
+
 	/* State set to transient mode */
 	xcp_mgr->mode = AMDGPU_XCP_MODE_TRANS;
 
-	ret = xcp_mgr->funcs->switch_partition_mode(xcp_mgr, mode, &num_xcps);
+	ret = xcp_mgr->funcs->switch_partition_mode(xcp_mgr, mode, &num_xcps,
+						    flags);
 
 	if (ret) {
 		/* Failed, get whatever mode it's at now */
@@ -237,6 +266,19 @@ static int __amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 		else
 			xcp_mgr->mode = curr_mode;
 
+		/*
+		 * pre_px_switch may have stopped an IP. Each post_px_switch
+		 * decides what to bring back for the mode settled above.
+		 */
+		if (flags & AMDGPU_XCP_OPS_IP) {
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
@@ -254,7 +296,8 @@ int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int mode)
 	if (xcp_mgr->mode == mode)
 		return 0;
 
-	return __amdgpu_xcp_switch_partition_mode(xcp_mgr, mode);
+	return __amdgpu_xcp_switch_partition_mode(xcp_mgr, mode,
+						  AMDGPU_XCP_OPS_IP);
 }
 
 int amdgpu_xcp_restore_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
@@ -262,7 +305,7 @@ int amdgpu_xcp_restore_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
 	if (!xcp_mgr || xcp_mgr->mode == AMDGPU_XCP_MODE_NONE)
 		return 0;
 
-	return __amdgpu_xcp_switch_partition_mode(xcp_mgr, xcp_mgr->mode);
+	return __amdgpu_xcp_switch_partition_mode(xcp_mgr, xcp_mgr->mode, 0);
 }
 
 static bool __amdgpu_xcp_is_cached_mode_valid(struct amdgpu_xcp_mgr *xcp_mgr)
@@ -855,27 +898,52 @@ void amdgpu_xcp_update_supported_modes(struct amdgpu_xcp_mgr *xcp_mgr)
 
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
+	if (flags & AMDGPU_XCP_OPS_IP) {
+		ret = amdgpu_xcp_run_px_switch(adev, false);
+		if (ret)
+			return ret;
+	}
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
+	if (flags & AMDGPU_XCP_OPS_IP) {
+		ret = amdgpu_xcp_run_px_switch(adev, true);
+		if (ret)
+			return ret;
+	}
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
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 6b3fdafc8b02..b4c0f80488dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -41,6 +41,7 @@
 #define AMDGPU_XCP_NO_PARTITION (~0)
 
 #define AMDGPU_XCP_OPS_KFD	(1 << 0)
+#define AMDGPU_XCP_OPS_IP	BIT(1)
 
 #define XCP_INST_MASK(num_inst, xcp_id)		\
 	(num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) : 0)
@@ -150,7 +151,7 @@ struct amdgpu_xcp_mgr {
 
 struct amdgpu_xcp_mgr_funcs {
 	int (*switch_partition_mode)(struct amdgpu_xcp_mgr *xcp_mgr, int mode,
-				     int *num_xcps);
+				     int *num_xcps, u32 flags);
 	int (*query_partition_mode)(struct amdgpu_xcp_mgr *xcp_mgr);
 	int (*get_ip_details)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
 			      enum AMDGPU_XCP_IP_BLOCK ip_id,
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 05e4edf72e4d..ec8b0c8f5e6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -364,11 +364,11 @@ static void __aqua_vanjaram_update_available_partition_mode(struct amdgpu_xcp_mg
 }
 
 static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
-					       int mode, int *num_xcps)
+					       int mode, int *num_xcps,
+					       u32 flags)
 {
 	int num_xcc_per_xcp, num_xcc, ret;
 	struct amdgpu_device *adev;
-	u32 flags = 0;
 
 	adev = xcp_mgr->adev;
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
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
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index b782fe2841b5..ad9913723cfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -1166,11 +1166,11 @@ static void __soc_v1_0_update_available_partition_mode(struct amdgpu_xcp_mgr *xc
 }
 
 static int soc_v1_0_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
-					  int mode, int *num_xcps)
+					  int mode, int *num_xcps,
+					  u32 flags)
 {
 	int num_xcc_per_xcp, num_xcc, ret;
 	struct amdgpu_device *adev;
-	u32 flags = 0;
 
 	adev = xcp_mgr->adev;
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
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

