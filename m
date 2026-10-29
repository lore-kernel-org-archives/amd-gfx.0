Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A96760A2639
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KdJ7fcZt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EABB8112539;
	Thu, 29 Oct 2026 20:34:41 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010033.outbound.protection.outlook.com
 [52.101.193.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67D59112542
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 20:34:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJLrieW6E5jFSYD7FTst4QXlXrwhjglle6a4xB8bAriJzucD8/CKYVlvdZrVUH1KHRjAj+ATT3yNu6GhZJjqxCmV94jDhFdHzKw2I/1xzBI/oyp+jHbzD4hvzVomQqDnIjTSdLbVLZZAFFa/rWo18TMRPYlIoGFUtbTsc6/o1+yLogbJ0yIQZazwHhhMry4Jjf9sw36FUUGJEMC9zEOoMKsPlXMQT/kfQCsw6DBjsWeD1WP03XZ0hVceGFoHqqIFHAUQ4NYO3bAVbOHJKfP0dsa2fwDwDQ446fP8mqf24Gdv4FdKk45QiYJr0oerzpwb33scYo2x/yTO6AtEfhX0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZbfGoKFL+RH8YcaBFoiwdAfdI3Xd03Z5IMCzvmjmBQ=;
 b=h/Jn4/OiKiVTAk+ghExsXq5BFchStZm6ug61xFjeQgNKDc8CNSugUfgwNylZlV927EVbw7LoeNZsnOYOn3b9mhbKSdLwRZh++YdUgZgiN14D6iTeVBD9L6BTxTfne9tjZzxiCrS4aHiutYCdDm9LBvkeQtVdMuc7WzHIZBBhoSqTZ+iQdO7Zb2C5eO4Ti8nMSvWjYd6xtnx0+++6mnmxADS5Ytix0uQ/iQIPvHB24FditGpPzjlzAPU6e99WLU6BSkXzNIkGupr+xToNdWtq/pvjoQz1JGfB/1WS2Biyhu5mQiYb+NRi4M3/47vP21UL95ZR5maxgJfjbamPrXF30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZbfGoKFL+RH8YcaBFoiwdAfdI3Xd03Z5IMCzvmjmBQ=;
 b=KdJ7fcZt8QxBXgqhez/sMHcU2g9TMmS79KUJwLkIFUOHZKctan9iAHOUbxoxyrsnJH1/PQHssGxMgtzLzF2kkDHtKBHkQK/QkCbBXsCXdJ4Mg1dYH3902X15NTgPoacGGRBLHDIGynlbTEnrchg71hOwiWzgFsnXT4VmQJJwxyg=
Received: from CH0P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::14)
 by SA1PR12MB8119.namprd12.prod.outlook.com (2603:10b6:806:337::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Thu, 29 Oct
 2026 20:34:25 +0000
Received: from BN2PEPF0000A98F.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::9b) by CH0P223CA0004.outlook.office365.com
 (2603:10b6:610:116::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Thu, 29
 Oct 2026 20:34:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A98F.mail.protection.outlook.com (10.167.248.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 20:34:24 +0000
Received: from alex-sierra-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 15:34:24 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>,
 <Mukul.Joshi@amd.com>, <Michael.Chen@amd.com>, Alex Sierra
 <alex.sierra@amd.com>
Subject: [PATCH] drm/amdgpu: reinitialize MES KIQ after partition switch
Date: Thu, 29 Oct 2026 15:34:12 -0500
Message-ID: <20261029203412.3224512-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A98F:EE_|SA1PR12MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d945be2-45e8-4405-c3e5-08df35fc0567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|261026121527099003|18002099003|10067099003|56012099006|11063799006|261022105027099003|261022075727099003|261021121427099003|261009223027099003|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: 1jMoTuUaDaquBwazHZKBHmNRS4fwlJgZ2nPSoXkYO86vHmuTbB0RoeQA0Z74vpeK+2SrAw9HeF/8hao0iAObxCAR98cjVSO22IKW+zIB5g7pgcOMLI87SENKxBGnIhvCDmIlMaSF2d/dTW+aqNgWsqXAwV2KaLAkxM1YnEKKE5pRYokBlHhBm07Hy79JiX4zF1N7f4YMaFx9YHXiBd2heM1RqJC9h0rc7gjF+Qhmd5etrhGOC9A/fcLxsO05SP3Opp7AzY6lNnC+0t2Vv19aEFviHj5nrH45KxMrpr7hn4Wvg6rvhuCdz+8DsvYFjuHys6t8x4fVAHVzypj0WFacMzwMezwmgYyUyT82wABa07GjdTROqCy4Va7V1Y29+xV4RRy5RJ4i+TxJviAgVqmK/bkCwrhZzeGVCcp4b6xBr7pbc+ZJoCb+8UYXemMGmHM/WqvBNJK/HPKEjanduwD9j/XQqVgf0MSSC+8kHTuchO5ghNGGaiaphS/19CARuIVncHgftdy45WpdFu/kcdmWZqbAru/WKWgCxrP038wHzGOM+NIdZgUUZzD9o7jqwq+Ijazn1pn3jLaZKSeGtmuwphBOPHmiN6etIYBfX0rCpNaJQyrBsQZibT80lKt9KD4hwOCwbcbumyySxbPFLpahpV46Npy3GqUQ5QNVDB/U/Je9V8tXWcoB4jLfb0NLlgdNBCuGBQMvLEK1kYz7NAOxCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(261026121527099003)(18002099003)(10067099003)(56012099006)(11063799006)(261022105027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261026140227099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q4UVWTrI2zfTluuTPRSlB4zqD+biVrM/TzQAy0BT56PEdxDMPnj9mwsXwPHVqiRnTGkShejF1pvguK82rhhDYyj1FaGhm5lvLqwhnS2J95uhYrvAmV2wBMPTc2tK4dm90mFfv2KefEP01Kac++kezJZfYpYWELm1QrORFpAEbPR/YS8VbYuGc52YyMTY1VJk0W83IEZ3euGud4E3gENAohqB1vAZ9MUL/whfJGOfKzJxTtdSpJtyZtR9d+Pa3dce0jERbYS67fa1RmnC/cDxh9B9wwkh6M6vCiMPF70bKqGTjEddlodU6y5JJh2OB89J7FLfS64EckBjeDEbl7fJ+9PfQ9WKFoLf5WMe0tHCVPvEgqHMCz4Zw9Jo/M+sFWY3yDblPdpmSppjJua99CrJE2SfiyymSV2dCFV3/NtLo+uS0TGCRSoqtLxJopux//FD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 20:34:24.8180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d945be2-45e8-4405-c3e5-08df35fc0567
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A98F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8119
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A runtime compute partition switch updates the XCP mode and IMU
partition without passing through MES hw init. The MES KIQ and
scheduler therefore remain programmed for the previous partition,
including its cooperative mode.

After committing the new mode, tear KIQ down on every XCC, clear the
KIQ and scheduler rings and their writeback pointers, and initialize
KIQ again. This remaps both queues and sends SET_HW_RSRC followed by
SET_HW_RSRC_1 with cooperative mode enabled for SPX, DPX, and QPX and
disabled for CPX.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  5 +++
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  | 54 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c   |  9 +++++
 3 files changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 0f368fbd2c80..5a14f4e7b64d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -141,6 +141,8 @@ struct amdgpu_mes {
                                                    uint32_t xcc_id);
 	int                             (*kiq_hw_fini)(struct amdgpu_device *adev,
                                                    uint32_t xcc_id);
+	/* Tear down KIQ, clear its rings, and run kiq_hw_init again. */
+	int                             (*kiq_hw_reinit)(struct amdgpu_device *adev);
 
 	/* MES doorbells */
 	uint32_t			db_start_dw_offset;
@@ -553,6 +555,9 @@ struct amdgpu_mqd {
 	(adev)->mes.kiq_hw_init((adev), (xcc_id))
 #define amdgpu_mes_kiq_hw_fini(adev, xcc_id) \
 	(adev)->mes.kiq_hw_fini((adev), (xcc_id))
+#define amdgpu_mes_kiq_hw_reinit(adev) \
+	((adev)->mes.kiq_hw_reinit ? \
+	 (adev)->mes.kiq_hw_reinit(adev) : 0)
 
 int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe);
 void amdgpu_mes_validate_fw_version(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 5573fe981a22..760c93740a7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -42,6 +42,7 @@ static int mes_v12_1_hw_fini(struct amdgpu_ip_block *ip_block);
 static int mes_v12_1_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_id);
 static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id);
 static int mes_v12_1_setup_coop_mode(struct amdgpu_device *adev, int xcc_id);
+static int mes_v12_1_kiq_hw_reinit(struct amdgpu_device *adev);
 
 #define MES_EOP_SIZE   2048
 #define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 8 /* [0:3] = db offset [4:7] hqd info */
@@ -674,6 +675,14 @@ static int mes_v12_1_set_hw_resources_1(struct amdgpu_mes *mes,
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
@@ -1530,6 +1539,7 @@ static int mes_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->mes.funcs = &mes_v12_1_funcs;
 	adev->mes.kiq_hw_init = &mes_v12_1_kiq_hw_init;
 	adev->mes.kiq_hw_fini = &mes_v12_1_kiq_hw_fini;
+	adev->mes.kiq_hw_reinit = &mes_v12_1_kiq_hw_reinit;
 	adev->mes.enable_legacy_queue_map = true;
 
 	adev->mes.event_log_size = AMDGPU_MAX_MES_PIPES *
@@ -1774,6 +1784,50 @@ static int mes_v12_1_setup_coop_mode(struct amdgpu_device *adev, int xcc_id)
 	return r;
 }
 
+/*
+ * Runtime partition switches do not pass through MES IP hw_init. Tear KIQ
+ * down, clear both MES rings, and run kiq_hw_init again. That init maps
+ * the KIQ and scheduler queues and, through setup_coop_mode, programs
+ * mes_coop_mode for the new partition.
+ *
+ * If a scheduler ring is not ready, MES has not been initialized yet and
+ * the kiq_hw_init call from CP resume covers this mode.
+ */
+static int mes_v12_1_kiq_hw_reinit(struct amdgpu_device *adev)
+{
+	int xcc_id, pipe, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	int r;
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
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 506060fc5368..95ebbd4a7369 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -1100,6 +1100,15 @@ static int soc_v1_0_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 	*num_xcps = num_xcc / num_xcc_per_xcp;
 	amdgpu_xcp_init(xcp_mgr, *num_xcps, mode);
 
+	/*
+	 * xcp_mgr->mode is the new partition now. MES KIQ was programmed for
+	 * the previous mode and is not reset by the IMU switch, so tear it
+	 * down, clear the rings, and run kiq_hw_init again.
+	 */
+	ret = amdgpu_mes_kiq_hw_reinit(adev);
+	if (ret)
+		goto out;
+
 	ret = amdgpu_xcp_post_partition_switch(xcp_mgr, flags);
 	if (!ret)
 		__soc_v1_0_update_available_partition_mode(xcp_mgr);
-- 
2.34.1

