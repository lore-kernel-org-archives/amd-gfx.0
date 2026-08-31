Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EEDC624D4
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E5E10EA65;
	Mon, 31 Aug 2026 18:28:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cvW0g4NS";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D103110E50F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9NP3QISvb+8UfM4OWSGKMQ8dCfm00appVkxfIy9a/HJqr4r+M8pB+976RQ9NL39dmDpNdbQpRHY+vzNnCQbuFApjYx6ozTYTJ8pEg1G5Xr1L4zMkm3ta7zo9dIaxxLH3DjMeg9MazFwh5M8q5zcQFOFFWeyEI9fRugExUuIPuSg+tIu4ChpvLyr6LnqGivjB1UiWjcFuAwPxP72cnqIOIL7EknbG0v/NdpHONMUzZ8WEbsbrr2pHnBdt+RMZP6hAY5E/nAdsxRYsun1kYdHUvfBNQ9GP4YuRUlmik6ecx0w4+VjY+7FMriTJPImz4X57jZnu/leOHXIq9zJV1EmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fpf3Yjn/RFu8DclTqOxljcBno5rklFuWOKDh6hBSFVA=;
 b=xf1Tm3DR+Nwj4e/IQeA7tZVavvZSd8HjdQ29P/LaUhNBmOVZt3kAMGKd/RlSWUIBXYa9bwCdTdlEo5trbt0D7q116dHXA4Jv236ZMEO38PuiUrkGimFH/4bwkErh1lUcnmjsTHiGTd3YlfUHZRB5+cij1E4+Mie6Ib9QVlpDjWAzCiyCASd0WrCgL0oGboDu3TmPFcoobKWNIntH7qQFnFJUZG91l28SrmEFpL5QpeEBdnWARUWtW4GGtFLlJZ+aKYbJUa7jq4qsMDIAVATi46O7LCpXs2C/3V76iGp1aXOJz4kAnKoHKMTjaDwJNcUYNw8PC7rDoPPT2xjrYsqtxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fpf3Yjn/RFu8DclTqOxljcBno5rklFuWOKDh6hBSFVA=;
 b=cvW0g4NSQ5e8TmTrjbtFz/5xanLxcfWN+TwumxZA6/ssvowFMNM61g8+3RwgUXjicbr/K3tixSz1984FEV6wMSRp6p3QUOTBX6F1aEFt8zCExqCh6qxPN9aYMO9IVgYMqGfZ5kIhpqkffQ68dhffneyHEE2NXpKc21OCgsNsRNo=
Received: from CH5P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::17)
 by CH8PR12MB9765.namprd12.prod.outlook.com (2603:10b6:610:264::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:45 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::26) by CH5P220CA0019.outlook.office365.com
 (2603:10b6:610:1ef::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:32 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 41/95] drm/amdgpu: Add UALink software init, teardown,
 and reset
Date: Mon, 31 Aug 2026 14:27:00 -0400
Message-ID: <20260831182754.1089811-42-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|CH8PR12MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1c5cff-f34e-4ae8-c30a-08df078db107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zSxxmnO2lKeBY6ewF4Owb6kd7FDWA1qa0Zz49Lp9yorJjAYI4J8aWJEj8ex8ygHV25WqkEATgfk0fayUYZkr8kT9WV9OEQ1hfmgM+evY53KjPezL4wEK1viZd3874R+sxH3ou3aHABw88eXBBDJ7q/b0mus/8ZXKd9hRRaY/KJ+nROs82S1iALBg22aYKdwC1BhGPF6n/Awlg+W8fy7QCcEm+YfbXLZe1GZWegaaiMuC/+AajuSt1IUOaNXX8MCu1SH9OjB2XRNwghC++ca4rTTlPvV8QjJ2QqsuiWRQ2TFFKqsnZfvSXEzWFPGnLnoW331nH2HZAlxnmhPDbbB+UaoEZDgH0vEAkSZTns5LNluir5L8bRRSGvcX42fqUf3pbAx4TwHXlEsYMDsqO2Q6hDjwBY+5jhW9DWujFMeaoRURoKIk//kOlT1zq+txYjhSxa7QJBqzhcvP4H4rOCrb/u2VfyqrrRYM6A3rAkA2611qPPFhrRR3Gy0w2NdkqhxJRe1GYohnVsjCCaSwgqGuvZWIN4s8Ymiri9V7gxx5Y6VNzpuVTRL4vRYcqIX0J829UZFW1LeYcQd95C/FZ2510A0aGtEE/7Tjv77ZGiKRy84qL8kD3POby2I05NA6h1wtTX+kVjnQFv6PwXTJ5gomEMEWOgH9Vxi5P3wzcQ0D+Porp3b2HcqwURd+SD1jPuj8QCVSuzEN6daHWhZp9M641g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Bkt40b9mRDyz/Mv3tJINjfbuWMzqGBdIq8EHlZF4VAeVCkhiOaUbPq+uqaBbLLct+Qt2rDo1Ko2IntKBAlGVgcGWuEuDoZawMSDG5tvi1QY9heIozaL0tHULP2p9qi+fjM3vfOl6+NzWr2WuQDZVwHkgAiTv5+YTYzJmtrSw3PIf8Zn1bRvrydW738e5nZM3NOtVk6HANtKqwSBag+6t4rqVehQzer2q5fyyOj+VxY/nhDc9SihSkSTOAvM0WFn96o4QhsHOj9RKByKeGskyY20+Oja34rLCZhBzCgeVjO450YQKPLCoToYzEfqSP2LOMf/deIRLmRw7pmz+qbckXuZtALpS9WKf5TWJPfFLntai/29G1/UY5KAy5r2RJAJDfRrFdVqUWbYTKvRLYkCb+1vELGOqGHYxoTWLvZ1+aH/KZ7hg6ahCidBltWnVaQ4A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:45.1313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1c5cff-f34e-4ae8-c30a-08df078db107
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9765
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
index e749f304efb76..d1e8f51a88b2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -705,6 +705,13 @@ static void activate_accelerator(struct amdgpu_device *adev)
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
 
@@ -719,6 +726,7 @@ static void deactivate_accelerator(struct amdgpu_device *adev)
 	/* ignore return value */
 	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_CONFIGURED;
 
+	amdgpu_ualink_sw_fini(adev);
 	amdgpu_ualink_manager_stop(adev);
 }
 
@@ -3013,3 +3021,91 @@ static void amdgpu_ualink_peer_remote_fini(struct amdgpu_device *adev)
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

