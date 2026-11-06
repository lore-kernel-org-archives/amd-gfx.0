Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D3A606A31B
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 01:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KnfTWX2F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1D5610E008;
	Fri,  6 Nov 2026 01:10:09 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B04C710E008
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 01:10:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXfhCIeCSwLpN+Qd4HMdgszrMk7wUefTU59rmOFZI6/m98RdL+L35KJ1GxYJsnrEfEsO1t8gbH90XVoQlOXhSv2It/B0R7E3YdE7j4pR01bGJvUqmx5WzWleUzfhbVNLNpXQJqg6VZCQbGyw2CsRIO/ugq/586nxdIALtWYbgi67ficbhE+V5BmJNbi1NmtIjAMoMPfc+tbFJDBOiRoNajpVmZ57yyAAtFdyWFhnial1PiC4nG5M++YH9IeKftkZe5h5fY8FpVwn1xcObxNEwdW+egkHqVsWwNygaiqK4/Ci3bZEUtBYmHc9+/Zz5o2/UK7AAH2VWNqBWY8BwWjF7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw9Z6jsQu7PyPui0+n0zEtVZvjc9+mepRM2goxEVKxo=;
 b=JdNc7+EohOEwMsKFx5s50CU2C3CAvYWUZ7nr+m60wMQLktXGHcrwG/PJ91akgLjilPo0eqQy5M23uDZH4usWXvcDVYDFwxevk20nC9bi6xl6uiu707HiyJuwBelzQM1Z8MA0U8jr9RTOo4An/2vSwIjSAC2Eeg3QKE1bhkeFVyHMcRsMxMCTWYyCvtHDrGQWvORh3uk4DmfQN9ACItWoiFFuNuMna7IZlDnh1pBnxXDAsoLkINJMVIIqTKoG26aytIhH0NQ+TgTGjAIgwFI0GbZZOjdj41RvFl2OyuXFi6DjoHlFOfsV6whtgesHOrtun55yQT8hOROZV+ce5HiVWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw9Z6jsQu7PyPui0+n0zEtVZvjc9+mepRM2goxEVKxo=;
 b=KnfTWX2FaOtFJzQZy0kVhjVshDILiQxlVc07JkHe5iRSzP8cjpo4ni1LA6j3yvq2pDT/Ud34p8zq8qPBzMhiK/zkBqMT8/HqC83Rw8oPxHb4HWM+8i1j/+xdV/H6bUHAS3V92lQ/VPWSg985kpMXHgpgYdNzMWkNGtleUkV+Qo4=
Received: from BN9PR03CA0473.namprd03.prod.outlook.com (2603:10b6:408:139::28)
 by DS2PR12MB127457.namprd12.prod.outlook.com (2603:10b6:8:4df::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 01:10:00 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::5a) by BN9PR03CA0473.outlook.office365.com
 (2603:10b6:408:139::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 01:10:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 01:10:00 +0000
Received: from alex-sierra-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 19:09:59 -0600
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Lijo.Lazar@amd.com>, <Mukul.Joshi@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, Alex Sierra <alex.sierra@amd.com>
Subject: [PATCH] drm/amdgpu: reinitialize MES KIQ across a partition switch
Date: Thu, 5 Nov 2026 19:09:43 -0600
Message-ID: <20261106010943.3623210-1-alex.sierra@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|DS2PR12MB127457:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e821088-bfa1-4865-9381-08df3ba2ae15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|18002099003|22082099003|6133799003|10067099003|56012099006|5023799004|261026121527099003|11063799006|261028144727099003|261102123227099003|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 6pei8+Pz0BZ8ZnPmumGhTmg/cJGBZdtLJ7gm0dklDuuXe81bBi9bszS3P8++aKFujtPUwLal0Bbm8aK1lONl3WDBKYx36XVEfFrfWCftaFv6qEe5lOwsAV92cY0bpqTozJqjE/5mtLbeL9oODpx4Rcvrai8bzZmMBmRb76MTw/g7n/PCS2oUjQzNcsVRGllG0IGKeEfMOkWJ8hcZa3/+Mxze7+evJkjpJofb+fkV3zjfMNybB/rkesxVwi/+lfJYHJMTRqrb3ZbpJTD4aS2HEO8c9vKE6mB+pYa8s/FjRftgZk2lHQcys7zshx5JH9BAJ1+/5zP/XvOTBtfmojyNMhGCHyzYPWtzP6PWw0zOZ+URvGY3EJd2BlIKHqtx0gZzJmOx5LXmr15gSv/MAPnc+G6C0Z/K9L5vpU7Z+9IYdhXkN9QbBIrMimbNUMytdndhhBmLKOalpsSo/hhPgUqCuB8EFARELO1RWqGy6kc7+Wi7XZ6Yw0p60uaYRZe7+ACx7SXyenlb2a/quJ2ZGnpUlFVlU0dS+GEmnetkBVImNoWakPhAF5d+JRvbkvFBBHghIXWqJ48ner0WVu7ipye7eFcOrwKnT/dnMlZFXZkwU8G6vEgxXnkDDMo/MSYv3/1UQHQkeCGpi7kDz8C4fcpwQ15l6PXvkH/HBUJxC1U3xnE9focgewy0v5kae52zg97/90avkaSWJiMS89WCxehiRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006)(5023799004)(261026121527099003)(11063799006)(261028144727099003)(261102123227099003)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261022105027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LOC3bZSanrNoApRCIgSPXLLPo2KrvcXe2/zoZP8DCDK2ywT4mkApXqL0K6n27QeZgR8nr+4pshfKnsl0OQPFLu+vuQovWi8HIZ2R+1+RFAJdfAjkhOE00lbHBkQU6FZs5rppKFFU5AN2PSfId0OpAZp75+hDDRNQl3EhuirEK5M9CG5EBGheAP8Y2QHemXxfzZmvPqz3744Oi0qi5RI3ZYN55DVwwZ/aqDLV8vVnph6n7Qv/AJdYH2bNAIEGcnCgGM8JA1GZjXtjsU8iepN2BBI0B0/PvJrGfdeqUZshF0SX5ZUd16AQAKNypjK6k08UFfMyF4O3q6XnU0roWFKTsn7TPi4/39VrkFKlJuMuKYBy6Jpj5uGk/gDRjy+UgYcIMoZzSLtAUbVw7filopYf3qltI1OrlZ+sth9d6kUOwe43Zjva3mO+x8ZhKO5THYej
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 01:10:00.0855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e821088-bfa1-4865-9381-08df3ba2ae15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB127457
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
partition without passing through MES hw init. The MES KIQ and
scheduler therefore remain programmed for the previous partition,
including its cooperative mode.

Add optional pre_px_switch and post_px_switch hooks to amd_ip_funcs.
amdgpu_xcp_pre_partition_switch runs the pre hooks while the old
partition is still in place. amdgpu_xcp_post_partition_switch runs
the post hooks after the new mode is committed and before KFD
recreates queues. A failed switch also runs the post hooks, so each
IP can undo whatever its pre hook stopped.

MES v12.1 stops KIQ in its pre hook, tearing it down on every XCC and
clearing both MES rings. Its post hook runs kiq_hw_init again, which
remaps both queues and sends SET_HW_RSRC followed by SET_HW_RSRC_1
with cooperative mode enabled for SPX, DPX, and QPX and disabled for
CPX. Both hooks return early unless enable_mes_kiq is set. If the MES
scheduler ring is not ready yet, the pre hook does nothing, and CP
resume programs KIQ for the current mode.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h  |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c  | 70 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c   | 75 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/include/amd_shared.h |  5 ++
 4 files changed, 146 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 652cd0950453..4e386b33a815 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -141,6 +141,8 @@ struct amdgpu_mes {
                                                    uint32_t xcc_id);
 	int                             (*kiq_hw_fini)(struct amdgpu_device *adev,
                                                    uint32_t xcc_id);
+	/* Set by MES pre_px_switch, cleared by MES post_px_switch. */
+	bool                            kiq_hw_stopped;
 
 	/* MES doorbells */
 	uint32_t			db_start_dw_offset;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index c29a60d6f0a6..c3b9f9fcaa4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -188,6 +188,30 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
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
@@ -212,6 +236,19 @@ static int __amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
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
@@ -721,27 +758,48 @@ void amdgpu_xcp_update_supported_modes(struct amdgpu_xcp_mgr *xcp_mgr)
 
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
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index ec595449963e..f01509f64edf 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -689,6 +689,14 @@ static int mes_v12_1_set_hw_resources_1(struct amdgpu_mes *mes,
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
@@ -1881,6 +1889,71 @@ static int mes_v12_1_setup_coop_mode(struct amdgpu_device *adev, int xcc_id)
 	return r;
 }
 
+/*
+ * Runtime partition switches do not pass through MES IP hw_init. Stop KIQ
+ * on the pre-switch side, while the old partition is still in place, and
+ * start it again once the new mode is committed. The post path maps the
+ * KIQ and scheduler queues and, through setup_coop_mode, programs
+ * mes_coop_mode for that mode.
+ *
+ * If a scheduler ring is not ready, MES has not been initialized yet and
+ * the kiq_hw_init call from CP resume covers this mode.
+ */
+static int mes_v12_1_pre_px_switch(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int xcc_id, pipe, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	int r;
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
+	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
+		r = mes_v12_1_kiq_hw_fini(adev, xcc_id);
+		if (r)
+			return r;
+
+		/*
+		 * The firmware restarts with its read pointer at zero, so
+		 * leaving the old contents and writeback pointers in place
+		 * would make it replay stale packets.
+		 */
+		for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++)
+			amdgpu_ring_clear_ring_and_ptrs(
+				&adev->mes.ring[MES_PIPE_INST(xcc_id, pipe)]);
+	}
+
+	adev->mes.kiq_hw_stopped = true;
+	return 0;
+}
+
+static int mes_v12_1_post_px_switch(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int xcc_id, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	int r;
+
+	if (!adev->enable_mes_kiq || !adev->mes.kiq_hw_stopped)
+		return 0;
+
+	/* Cleared first so a failed init is not run a second time. */
+	adev->mes.kiq_hw_stopped = false;
+
+	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
+		r = mes_v12_1_kiq_hw_init(adev, xcc_id);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
 static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_block *ip_block, int xcc_id)
 {
 	int r;
@@ -1997,6 +2070,8 @@ static const struct amd_ip_funcs mes_v12_1_ip_funcs = {
 	.hw_fini = mes_v12_1_hw_fini,
 	.suspend = mes_v12_1_suspend,
 	.resume = mes_v12_1_resume,
+	.pre_px_switch = mes_v12_1_pre_px_switch,
+	.post_px_switch = mes_v12_1_post_px_switch,
 };
 
 const struct amdgpu_ip_block_version mes_v12_1_ip_block = {
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

