Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38E3C5DF9B
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 20:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC16310F3A3;
	Fri, 21 Aug 2026 19:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="te02S8r1";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17D2010F3A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:41:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITHswpmYzRxvjVhjOKxNNJ8cNCr8uI9uS2uIyAeeqytc315kIFiKBVu3456i19WrZOQI0s8TDsksplpHzDxY5s5hLWgIu4QJOzq7AR11p1FePjyBGF9XLBHJRUCZECLD/+Rk6Q345d0GBZyTPdmYhXw33WvdXcndmac3oBSDeyJZxqwsl9xYi/LVGMp2PWVbPZro5BYgOy5OlBOTZqg+kdwsN4bb9eRljRdFz9dpxYfsQdpx5tUjtHUyOdWSUiGQE2yNtC2S7HU1rsKAksGrejDEVhwG4fSeDK3TNr80jV4Sbw/JnouAljA+sLbYNerIdvGcgRoJE0thkhUcdBIUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgF1zA6BHjoDr/qd0KQ+fF+rlkQwEdtFbqWcuH4ysAA=;
 b=hE84OnCOArl9YWZeWLekeVvUUL0SBdhqsWcWENUiv5X/862Fz4fCQB04HxrquRqhMXGlwJRuO4Xq/fkeIcBRaSP3D3VfsSlV3J0xj5eKfc+OFvpZYIdN4CsK4ErHfpnX/OlVPHZ9/ii7n8C0SHS+5zf3UYpYPVSiIig+IiaslNmZiJAgaOLRf8vldOKBGEhVpESyjTzq9FM28+Kjs4Oa2/6NkFoJtp49cYzZZhPD7DLmtGBf5lBqTwkTOPL5WuExJSe3cK7kGbTfiu1IttzvyyJ+3yZsGKsm79WlUsedTTnRis9pmI2p3fe8i4Fb0hwNnxDvlVbEeLHoeJp2eXbrFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgF1zA6BHjoDr/qd0KQ+fF+rlkQwEdtFbqWcuH4ysAA=;
 b=te02S8r1y60hA+SFc33cfnpJ17FYz1/sIC1rFAQq3KLw0m12t+aQ6ur1joZJM4uZEyLCBJlLa046mqzcv7p7ucsbDDkSuiFWOlyrswayKaOrD3/Zk6+vW8iRjxMt5CC9C7s5dHLwn+SdjChDl6hej69L1Qv1urFjpyHEHUeLWtU=
Received: from DS1P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::11) by
 DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.11; Fri, 21 Aug 2026 19:35:48 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:8:454:cafe::9b) by DS1P222CA0011.outlook.office365.com
 (2603:10b6:8:454::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:36 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:36 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 41/95] drm/amdgpu: Add UALink software init, teardown,
 and reset
Date: Fri, 21 Aug 2026 15:34:04 -0400
Message-ID: <20260821193458.808626-42-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ce21e6-8e9e-4a34-4576-08deffbb658b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|56012099006|11063799006|6133799003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: QpyZYCzcvsu9a+mz36EH0hafxo3hl2bgwh4z91J/ZzchI+rQA26HUjChrV6RVIqR04Mk971yHAtL4T2yFuQBWeN2VWKj4Wr0J7Tw3+WSs2zZj3gcYiHPP9Hqr7EhFeV+BpEU7vyDbBPXOYMcCCfGKQA83lrnwsvNxeLie/5HYMjTwgDNg0lZx6Z8sGDvd88pz8DhEtjn7vrN0UIyCf/xe4vgtLTDEit1fh/mby0y6oirAjHx/WZfWSuKL2K5Xh17N+v0FXzLEw/jxSkXzYGj8/kXOyhYKvdyF8A8r2kYUKOvLKCA4NJuiYhWx91MiohiQCrITiJM06EFPMRviBBBH8x6Idau3MLqbdmCfsSEmtsJFszX+q2wwd1Y+FOt62wAf3abqFzefYN850FQ7AduuuVSI+QYxcm+ltl3WY/WeoBm6oh6GStxpp0hWFFSuytVS2/Q8czxPGr0WPe7wlyPDJ8HZiLfWUrFoZgKlyrg9opnP3EZ5l0TS7M/wp1T71ozXjtvOVpQDfFphgMnL6xHxz9hBz+TCXs+r4oi5cvegYjTK1QBmPfcgTMc+dXNmKQHhxLSaMD4RC+9QrBxpWMYuVCdQYlI9HF5HRKTxV601rLfckAnggbXa39X+YiEU1q75D/N4yK2DkRqlrLs8J71j99Ycb4O4Yn/D+BS40D7ze1ejxO6w7i4DV9zIynWQONgSPOQhwgyHFltVbYtZ5JVhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R/YUcnB4jDcakhPlMQfgFsSiF3vPW26luipPOyVRc/0108xjRpiW7qrRT4ARpLmtGfWfOYORtoiSx1mAarLcZbKjsHuNmeImDp7RuHrcw6clEPSpZiu/pyvL6HIVZcNrdtSZgVzubWQ8EZno2O+aKebnI42dIMzYvQqsc0jE8ZcfH+zgbQS2xv0sgnh6SCZfRo8kjINpB2ARgNpyh2PER189KksUR69sTJUMkMYDulUZnqXRBSo8O7PXLRbIky7Zcj39Kf1SiuBRfe0vpdXFp487+RM8SKumYVHD8kbz03ng9G3UyRb4ZqXmIa4NKITY8zGPrQyz8OeZ+7L3GAXPWAFcMkVTY/pYKYx6dTLJ5V8uNHU1R876oFTYUEQxkjQywSO9O1FsPJpXgvSgW4Rfssxz7yTCdoBkEqJYkzq+6XhIUPe3ClATO7omETDrwLWH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:45.9926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ce21e6-8e9e-4a34-4576-08deffbb658b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
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

From: Philip Yang <Philip.Yang@amd.com>

Sequence the setup steps into a single init path with rollback on
failure, and a teardown that halts firmware first. Hook both paths into
the virtual pod commit so resources rebuild on reconfiguration.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 96 ++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 35c9f8de60961..3fc11b49d9863 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -680,6 +680,13 @@ static void activate_accelerator(struct amdgpu_device *adev)
 		return;
 	}
 
+	r = amdgpu_ualink_sw_init(adev);
+	if (r) {
+		dev_err(adev->dev, "Failed to init UALink sw r=%d\n", r);
+		amdgpu_ualink_manager_stop(adev);
+		return;
+	}
+
 	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_READY;
 }
 
@@ -694,6 +701,7 @@ static void deactivate_accelerator(struct amdgpu_device *adev)
 	/* ignore return value */
 	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_CONFIGURED;
 
+	amdgpu_ualink_sw_fini(adev);
 	amdgpu_ualink_manager_stop(adev);
 }
 
@@ -2965,3 +2973,91 @@ static void amdgpu_ualink_peer_remote_fini(struct amdgpu_device *adev)
 	}
 }
 
+/**
+ * amdgpu_ualink_sw_init - Initialize UALink software resources
+ * @adev: amdgpu device pointer
+ *
+ * Performs full UALink software initialization including metadata allocation,
+ * NPA address mapping, SDMA scheduler entity setup, and remote peer GPU
+ * connection initialization. On failure, all previously initialized resources
+ * are cleaned up.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int amdgpu_ualink_sw_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_remote *remote;
+	int r;
+
+	remote = kzalloc(sizeof(*remote), GFP_KERNEL);
+	if (!remote)
+		return -ENOMEM;
+	adev->ualink.remote = remote;
+
+	r = amdgpu_ualink_metadata_init(adev);
+	if (r)
+		goto out;
+
+	r = amdgpu_ualink_metadata_npa_mapping(adev);
+	if (r)
+		goto out_metadata_fini;
+
+	r = amdgpu_ualink_sdma_entities_init(adev);
+	if (r)
+		goto out_npa_unmap;
+
+	r = amdgpu_ualink_peer_remote_init(adev);
+	if (r)
+		goto out_sdma_entities_fini;
+
+	dev_dbg(adev->dev, "ualink sw init succeed\n");
+	return 0;
+
+out_sdma_entities_fini:
+	amdgpu_ualink_sdma_entities_fini(adev);
+out_npa_unmap:
+	amdgpu_ualink_metadata_npa_unmapping(adev);
+out_metadata_fini:
+	amdgpu_ualink_metadata_fini(adev);
+out:
+	kfree(adev->ualink.remote);
+	adev->ualink.remote = NULL;
+	dev_dbg(adev->dev, "ualink sw init failed %d\n", r);
+	return r;
+}
+
+/**
+ * amdgpu_ualink_sw_fini - Tear down UALink software resources
+ * @adev: amdgpu device pointer
+ *
+ * Cleans up all UALink software resources in reverse order of initialization:
+ * remote peer connections, SDMA entities, NPA mappings, and metadata.
+ */
+void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
+{
+	u32 status;
+	int i;
+
+	dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n", ualink_accel_id(adev),
+		ualink_addr_mode(adev));
+
+	amdgpu_ualink_mailbox_write(adev, mmMPNHT_SMN_C2PMSG_22_ALT_2,
+				    AMDGPU_UALINK_FW_CMD_HALT_OPERATION);
+
+	for (i = 0; i < 2000; i++) {
+		status = amdgpu_ualink_mailbox_read(adev, mmMPNHT_SMN_C2PMSG_26_ALT_2);
+		if (status == AMDGPU_UALINK_FW_STATUS_HALT)
+			break;
+		mdelay(1);
+	}
+	if (status != AMDGPU_UALINK_FW_STATUS_HALT)
+		dev_warn(adev->dev, "f/w halt failed status 0x%x\n", status);
+
+	amdgpu_ualink_peer_remote_fini(adev);
+	amdgpu_ualink_sdma_entities_fini(adev);
+	amdgpu_ualink_metadata_npa_unmapping(adev);
+	amdgpu_ualink_metadata_fini(adev);
+	kfree(adev->ualink.remote);
+	adev->ualink.remote = NULL;
+}
+
-- 
2.55.0

