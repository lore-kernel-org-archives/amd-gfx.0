Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F699606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0uIznE4y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E372112485;
	Thu,  5 Nov 2026 13:47:55 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1CE8112485
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 13:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4bWukq5zFRz/zpqh4pcg55o0NmblnaIz/Y+bXEgw72YIkxf5voGD2+PQ6Gr9V4AUHKfA4WOmfuHps321QRcGMEvg3vXZaoY5LjlfIOQWm8YLQuzsRoyvczBRjL71qwIhukrea8o/1E8qxkt4rq9J83d52kD55Lymy2WkhIPjhAz/M4Y4OU2J6AAdHMzz60RUW7YsovwdTTLStZDuOYRLd/2d2lePMDLTRCOS3DqF71K/7T4hQmTsfWSmZfO4tu8oeE6QlJT3PtKBXHJ96ckcmddmS9i3eQNNeMtMDAhDbj/AFzdALxHjTQRZANLcJDjdveZaR6iwMlcFtLQ9Telew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anxVIT+U5gB0WPVCNLiamX0xymw8NJHRsDUbuAU4w0k=;
 b=us8Bj6Yu9hWJPr+YIvnBbkEq/OyE4sB4PUWYYRfg05ntSZGdnWoqm2eO44Lh5Q2k5qIbDQj6zHhAZwbycdsOrMxeMwraW+b3TiWUoNPkBua10/DmJndXLvVDvQGQhpT2LQHg0LKdGcNUz+jiYaDPWG6buPemtrXOiTZFnUCIZLwdRS0ENhw0moMAAZt5E7967LWYz1SEou+hi6QDoNw2/0MtDbcvEfdHmzDzX9HsljVY9A/Z2rK+uJD6JrqKRW+kFVFZsNPDOhrmBXsIT9jVdXp+aMlDmohBezTEozpv66wOc7OGn40SShxuR/2+HChK4IUzfqx0RX2A0vPkgGifQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anxVIT+U5gB0WPVCNLiamX0xymw8NJHRsDUbuAU4w0k=;
 b=0uIznE4ywUprzgwGqOoMi0FD8VFMQduopWv3zMThIfXm1tRuhQyB8fk+diOOITuno3Jdd1qOmsN9zLCruCQK0JMuu9kACLlabNGqC2us46Qdiu3i6NV4HY2p6I8CpNJYJUGb31uXEL+Vaas43ZMcmngTjzFxorXpPKC5fK04G7M=
Received: from BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::16)
 by CH1PPFC908D89D1.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::623) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 13:47:43 +0000
Received: from PH4PEPF0000B60D.namprd21.prod.outlook.com
 (2603:10b6:a03:59d:cafe::7f) by BY1P220CA0008.outlook.office365.com
 (2603:10b6:a03:59d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 13:47:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH4PEPF0000B60D.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.2 via Frontend Transport; Thu, 5 Nov 2026 13:47:42 +0000
Received: from alex-sierra-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 07:47:41 -0600
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Lijo.Lazar@amd.com>, <Mukul.Joshi@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, Alex Sierra <alex.sierra@amd.com>, Cursor
 <cursoragent@cursor.com>
Subject: [PATCH] drm/amdgpu: reinitialize MES KIQ across a partition switch
Date: Thu, 5 Nov 2026 07:47:26 -0600
Message-ID: <20261105134726.3501207-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029203412.3224512-1-alex.sierra@amd.com>
References: <20261029203412.3224512-1-alex.sierra@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B60D:EE_|CH1PPFC908D89D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 485a3ce2-9817-4047-979f-08df3b435d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|10067099003|22082099003|18002099003|11063799006|261026140227099003|261102123227099003|261026121527099003|261009223027099003|56012099006|261021123027099003|261028144727099003|261021121427099003|261022075727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: QSEYHgEsfZljzT3vghU8ha7cKUANw7aeJP61VoHG5iG7l5Loih3TNga+7wsr8vqFDYqt0pJ1mlgFTz6QPwtIVLY76PQKF8cSpUSeop6Ov3gkNoyUo7NyzCqypHj+wWKZvKwR8Ra8hSoDuw9MGZPhzRs5RQLDoL28266UygQeFd5+/26OoAWE+x4LkTimhTQpZqDwdTOe/WCUES4vKa/VK9fa6qDen4l9omy5XSYVHtTEwoZgMZmjvz3aoLa1/amNb9TFmsUvmYcJ74TFFXHZvolIvtebQPQEkD82I3XWrIeBignx0KrCuvATg1ze+EOQ0vt5jn+vyH2qLUa6RbBMpED/mH5QWOZ09Yo9Wa/AQwQzFqxYWsE/A6so7xG2NngixLbMFZatOSIlf7z6Yo7qfa4/db++gN2Hzshj/MN1dKS5p/V4veO5w4VfgTDjJ5ionymEUwzGmwl0AiYcwDyOBzzqarzz2oa6s81Tf//sCVvkf7EiWCSwg0AJnesHdlfDtjo3qhLDL5r/gJCn+pOC1uYIQ9tGkcG82P5WNwOmnVjW2ofb9U1elRRAVoGYjXWgxRmlOW9xKK5qUdBmdij9dTX+SHnP7/bayccTGM1QYGentSANGXVKluvLAUo6jJLi3bJisqcG/HlHZUpiU7fwV+uKfRM37o2Q75vlbqdcCJRBoMHvkP2uIHhdtAhS3E5HckF5UYlKZkNF4of1+uEuKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(261026140227099003)(261102123227099003)(261026121527099003)(261009223027099003)(56012099006)(261021123027099003)(261028144727099003)(261021121427099003)(261022075727099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w1clfCfTz26I1KeOso+BEUu79BrtBrqG/1UihnH0DnMAurlr+du7zRXODnfqJNf29he6KHmb17JxlBDWWBTR2qo6dIjhiUwwCcavqLX8Zt26dWHkMJG8Nn3kQqyP2jkfKUEnP8jdU6i05L3R4U3v132197UiI1HKoFbrhuFVB794JIA4HLayngHNl00y6cMv+AqLhxHj9rLNm5JwoVl9XnADdZcR3dV+ZUhTLjhT1w5JEBkbrz/Q2aRQOkoPVx6zbMwUkzyqD2ZJdoYXk5dh0YtnahQ0SYmFOby+RXi/ikAiEfTDk+yx5pL7JWlufwXmwHqec0VzK8JZOdcxrfNAouqtUh0P1v61NXSLM5fbmLaeoJUy8bw/upag+XkVfSdf+TA8SvqCMAsEDui/ajCnJIyxoUqkns9IF4qr7IytQVW0G9arSRWtPr5/Ar+zcT5P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 13:47:42.3265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 485a3ce2-9817-4047-979f-08df3b435d51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH4PEPF0000B60D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC908D89D1
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

Stop KIQ in amdgpu_xcp_pre_partition_switch, while the old partition
is still in place. After the new mode is committed, start KIQ again
from amdgpu_xcp_post_partition_switch, before KFD recreates queues.
That init remaps both queues and sends SET_HW_RSRC followed by
SET_HW_RSRC_1 with cooperative mode enabled for SPX, DPX, and QPX and
disabled for CPX.

The calls are gated on enable_mes_kiq. If the switch fails after KIQ
was stopped, start it again for the mode the switch settles on.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 14 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 51 +++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  | 72 +++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 652cd0950453..cd020959192c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -141,6 +141,14 @@ struct amdgpu_mes {
                                                    uint32_t xcc_id);
 	int                             (*kiq_hw_fini)(struct amdgpu_device *adev,
                                                    uint32_t xcc_id);
+	/*
+	 * Partition switch: stop KIQ before the hardware switch, start it
+	 * again once the new mode is committed. kiq_hw_stopped is set by
+	 * the pre callback and cleared when post runs.
+	 */
+	int                             (*kiq_hw_pre_switch)(struct amdgpu_device *adev);
+	int                             (*kiq_hw_post_switch)(struct amdgpu_device *adev);
+	bool                            kiq_hw_stopped;
 
 	/* MES doorbells */
 	uint32_t			db_start_dw_offset;
@@ -572,6 +580,12 @@ struct amdgpu_mqd {
 	(adev)->mes.kiq_hw_init((adev), (xcc_id))
 #define amdgpu_mes_kiq_hw_fini(adev, xcc_id) \
 	(adev)->mes.kiq_hw_fini((adev), (xcc_id))
+#define amdgpu_mes_kiq_hw_pre_switch(adev) \
+	((adev)->mes.kiq_hw_pre_switch ? \
+	 (adev)->mes.kiq_hw_pre_switch(adev) : 0)
+#define amdgpu_mes_kiq_hw_post_switch(adev) \
+	((adev)->mes.kiq_hw_post_switch ? \
+	 (adev)->mes.kiq_hw_post_switch(adev) : 0)
 
 int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe);
 void amdgpu_mes_validate_fw_version(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index c29a60d6f0a6..4bdd9b60a35e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -212,6 +212,20 @@ static int __amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 		else
 			xcp_mgr->mode = curr_mode;
 
+		/*
+		 * pre_partition_switch may have halted MES KIQ. This
+		 * failure returned before post_partition_switch, so
+		 * start KIQ again for the mode settled above.
+		 */
+		if (xcp_mgr->adev->mes.kiq_hw_stopped) {
+			int kiq_ret = amdgpu_mes_kiq_hw_post_switch(xcp_mgr->adev);
+
+			if (kiq_ret)
+				dev_err(xcp_mgr->adev->dev,
+					"Failed to restore MES KIQ after partition switch failure: %d\n",
+					kiq_ret);
+		}
+
 		goto out;
 	}
 	amdgpu_xcp_sysfs_entries_update(xcp_mgr);
@@ -721,27 +735,52 @@ void amdgpu_xcp_update_supported_modes(struct amdgpu_xcp_mgr *xcp_mgr)
 
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
+	 * Halt MES KIQ while the old partition is still programmed.
+	 * Devices without MES KIQ leave the callback NULL.
+	 */
+	if (adev->enable_mes_kiq) {
+		ret = amdgpu_mes_kiq_hw_pre_switch(adev);
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
+	 * The new partition mode is already committed. Program KIQ
+	 * before KFD recreates queues.
+	 */
+	if (adev->enable_mes_kiq) {
+		ret = amdgpu_mes_kiq_hw_post_switch(adev);
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
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index ec595449963e..0957e56bb069 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -46,6 +46,8 @@ static int mes_v12_1_setup_coop_mode(struct amdgpu_device *adev, int xcc_id);
 static int mes_v12_1_enable_dbgext_irq_xcc(struct amdgpu_mes *mes,
 					   bool enable, u32 xcc_id);
 static int mes_v12_1_enable_dbgext_irq(struct amdgpu_mes *mes, bool enable);
+static int mes_v12_1_kiq_hw_pre_switch(struct amdgpu_device *adev);
+static int mes_v12_1_kiq_hw_post_switch(struct amdgpu_device *adev);
 
 #define MES_EOP_SIZE   2048
 #define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 8 /* [0:3] = db offset [4:7] hqd info */
@@ -689,6 +691,14 @@ static int mes_v12_1_set_hw_resources_1(struct amdgpu_mes *mes,
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
@@ -1611,6 +1621,8 @@ static int mes_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->mes.funcs = &mes_v12_1_funcs;
 	adev->mes.kiq_hw_init = &mes_v12_1_kiq_hw_init;
 	adev->mes.kiq_hw_fini = &mes_v12_1_kiq_hw_fini;
+	adev->mes.kiq_hw_pre_switch = &mes_v12_1_kiq_hw_pre_switch;
+	adev->mes.kiq_hw_post_switch = &mes_v12_1_kiq_hw_post_switch;
 	adev->mes.enable_legacy_queue_map = true;
 
 	/*
@@ -1881,6 +1893,66 @@ static int mes_v12_1_setup_coop_mode(struct amdgpu_device *adev, int xcc_id)
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
+static int mes_v12_1_kiq_hw_pre_switch(struct amdgpu_device *adev)
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
+	adev->mes.kiq_hw_stopped = true;
+	return 0;
+}
+
+static int mes_v12_1_kiq_hw_post_switch(struct amdgpu_device *adev)
+{
+	int xcc_id, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	int r;
+
+	if (!adev->mes.kiq_hw_stopped)
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
-- 
2.34.1

