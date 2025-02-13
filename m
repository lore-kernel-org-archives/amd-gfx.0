Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4283C021A7
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 05:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A66410E092;
	Thu, 13 Feb 2025 05:47:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="16nfDtXI";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43A8710E092
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 05:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s31Li8OxS7yjJzB13wDu81Bvhpoj1SXG6fva/ftI6sRzgKrwg5NT0oTs6ziQKJ+BlPCgGSMaUFcgThUq7+KLlddkiEJy8D2aOmnxby8DVMhc6r9g3Y/eZ5p1yNzYNhw86udu3lFvAKg8Zaxx4yrLGUCtaAt78Lo2w1H8693OjF4fcsk8zJSr/eac93ur3BKHfBBs6IIolLdwnmCrOo6mbDMl1qE8sCbv/gDaaGIsXoN0LtINzRMZnKp6EM5NLxqFJBb29UAJ2U5VVj3ZPGA/n+DGqiZU+azozciEtyEIKvNLDHATh7Rfbqw6Drl6UuT/nq1AbgUnr00+1hmur+0LXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHj4sVFSBmIwKcd0oGcpMlfTCkWYiFNDOF5PiLX4NaA=;
 b=KRvwYCsof6Chw3fxXiMz+CvpiOy04wSR+yPPHr8JhM5cBsvc0YJWtqqStZB5+AymZd/GXopsEZ+n8RXM+uokQ6XSlHwF6Ccv0qkFxHkWEGCFNlbSCdMoW3MTOnwOiPV+9MrVfslSpftUTehtW+n0h3O654MJJLchzqUJgFOr17c/FbKg6vNVO1jQ9PTJWdRvxojw/QunYOs8BG2Z3+NK/h+RzIgDpWeRAxlhPpj/d/uC4R8dQKivLCtMrmCFWpbnEeKFrimukpRLm1bsOBtG5TM/Cayq7pCVselMomferzqtCLsmir65XF8aE8Z3tMvgLbs9xfZi41DsbsGQqu5kaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHj4sVFSBmIwKcd0oGcpMlfTCkWYiFNDOF5PiLX4NaA=;
 b=16nfDtXIwxuzlyeVdaA2j7Dl5/65cyk22oEvuIt69mOGgKtjMGepc9CWCE7u7zbIfamGAE4g1i+aYY06uSkXVR5+ZEB/I+uP63ryaMuB4BgF+YGO2vXyafJ0vFP6uBXLIyn5At0N5UK85qwsOez0jo6qJEgkb92pFSNWNupSQNg=
Received: from DS7PR03CA0280.namprd03.prod.outlook.com (2603:10b6:5:3ad::15)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Thu, 13 Feb
 2025 05:47:29 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::3e) by DS7PR03CA0280.outlook.office365.com
 (2603:10b6:5:3ad::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Thu,
 13 Feb 2025 05:47:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 05:47:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 23:47:27 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 12 Feb 2025 23:47:15 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v7 1/9] drm/amdgpu/kfd: Add shared SDMA reset functionality
 with callback support
Date: Thu, 13 Feb 2025 13:47:07 +0800
Message-ID: <20250213054715.3121445-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|DM6PR12MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f99260-6c37-4589-8284-08dd4bf1e6ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aaASc3pqrx1RlIlw8OokCP43LHdGkjTieLFYITUtgskwihVsHEWp3X3VxMK3?=
 =?us-ascii?Q?m802cIJ57oOCwuCBVe1D/biUgH7QNeSg2dZXeAGptE2Ffp/sy5Ig33g2zpfm?=
 =?us-ascii?Q?c39LfJh4FeOkdkC04eRyrs3xf1BiQQ9hkj2KEx3HmVLbFFYJB+90fhbpp9d5?=
 =?us-ascii?Q?o4L1Y0O7i/HLBsRgJm+9J0LkSXZCmxhpRFWhNKGH98wk5s9G0Wtmm6t30XEN?=
 =?us-ascii?Q?PewFHNvqTYNhMcwf1JkltaPSe40nWcDseO5P0CQHMZ1W8l+27t4ExozAoMNA?=
 =?us-ascii?Q?aB5BwRXFL/V0+f2nBVyzthb7quJKjZjLA2pkYQOwN3p8HLH7uGCn+GYWjKGz?=
 =?us-ascii?Q?SwT/RZe5tFiAQhAdzIzC8owwr0RrlpTvUMe3YWfocFVjekSCKGoz7OobqZRN?=
 =?us-ascii?Q?mQuHRofJyCBAWXE9k9PRVcTUlnGZ1k2BNV7VZxXqCC9+H+AYrZdXrUSAyXrk?=
 =?us-ascii?Q?ifd0YGXUL+mSJwdtssIxMfqYqa2UXkTQEHpRk40vvnVNTNKcO/DmcObWIzoI?=
 =?us-ascii?Q?I1ATDwGPrYxHjiOGrOn2gNAXfiFpWuPcg6BQDQBxsmlpk1R3dUnnQIlC3FDY?=
 =?us-ascii?Q?+EWIKPhs/uv9jhveRb5EH8JzsNaacreux5uz2uHfs9KZXRBo/foHmlACFBQ/?=
 =?us-ascii?Q?PwQLIEkhnjTsnvnq+og6wtMFlJXq3sOZ2f480ubjYXyI+Vp+03ySl36fc8qQ?=
 =?us-ascii?Q?u3lvJTmVAqFU8KVU1aJE7Xq88fMc6PepQAHq9Mzil06EwV0Y4yRqCrBjTxDg?=
 =?us-ascii?Q?tfpXBKyZhaQQTHuROb6C49D9mYpZMqIiv2IhKRB4QfiSYimi6IiTlskfnHJl?=
 =?us-ascii?Q?fysice8q70K7wTWwjRUbR4p4LAbMya4RD3n2NFHCXDCz4U6lf/bqf3lmg9AF?=
 =?us-ascii?Q?XYwiJjxspILM6hMAd4irfzMr++KyaQxDAp4GKHW56UeLF/5iLIT+C6hAzeL2?=
 =?us-ascii?Q?x332K7CPrKIHXPexzGNQT/siBRsgZj7ORHv+BFQ64pIZModbgf7fYkQGD3aZ?=
 =?us-ascii?Q?HxxdoXXzWOtJImWG1b2B+Abyta+UrHAd0N6pWRBq/VdyTebXPvqLZVAkF8h1?=
 =?us-ascii?Q?4Lzdc/SkMLJXEYw4pa1mpL58eTYacf6QdUAru+gjsx4ppXJ21fvwNAvjR+GJ?=
 =?us-ascii?Q?Vl3oOaMLPPK5x0YNxGIHo02oxvTah0shlXYSOucPHGbqD+IfYjMweDIGaWOX?=
 =?us-ascii?Q?fiNJIInmv5vXP/q4FZp/4i/KnLVOhOyWxt6fD1rKTvUin8LJMWKNsJ9kYK13?=
 =?us-ascii?Q?lhdnsSVgRbRSFFztV/MsNFYfliXObdyxPRBP6Btlwrice5y2Gqccxxmm5gmS?=
 =?us-ascii?Q?5KxFwDyyDp9n8GbxcW9xEBLXezm2U0UTSUdWSnRqJSzx6bDgxZOqSyZjfr7Y?=
 =?us-ascii?Q?PDKkWv5Z4Hj2Ly2V0PybxPHb6eWPGbMc7QHAUA5iYE7hgPrE/vxn6lTuUpRU?=
 =?us-ascii?Q?O6Ae0wbqkd4BK2kv9e+U13jh6Th38IjxsPmLWLI0LLdlRV4i8rjjAo0rc2tI?=
 =?us-ascii?Q?9HsQrLF2PO2KQys=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 05:47:28.6617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f99260-6c37-4589-8284-08dd4bf1e6ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch introduces shared SDMA reset functionality between AMDGPU and KFD.
The implementation includes the following key changes:

1. Added `amdgpu_sdma_reset_queue`:
   - Resets a specific SDMA queue by instance ID.
   - Invokes registered pre-reset and post-reset callbacks to allow KFD and AMDGPU
     to save/restore their state during the reset process.

2. Added `amdgpu_set_on_reset_callbacks`:
   - Allows KFD and AMDGPU to register callback functions for pre-reset and
     post-reset operations.
   - Callbacks are stored in a global linked list and invoked in the correct order
     during SDMA reset.

This patch ensures that both AMDGPU and KFD can handle SDMA reset events
gracefully, with proper state saving and restoration. It also provides a flexible
callback mechanism for future extensions.

v2: fix CamelCase and put the SDMA helper into amdgpu_sdma.c (Alex)

v3: rename the `amdgpu_register_on_reset_callbacks` function to
      `amdgpu_sdma_register_on_reset_callbacks`
    move global reset_callback_list to struct amdgpu_sdma (Alex)

v4: Update the reset callback function description and
   rename the reset function to amdgpu_sdma_reset_engine (Alex)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 73 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 11 ++++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  2 +-
 3 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 174badca27e7..fe39198307ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -460,3 +460,76 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 			device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
 	}
 }
+
+/**
+ * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
+ * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
+ *
+ * This function allows KFD and AMDGPU to register their own callbacks for handling
+ * pre-reset and post-reset operations for engine reset. These are needed because engine
+ * reset will stop all queues on that engine.
+ */
+void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct sdma_on_reset_funcs *funcs)
+{
+	if (!funcs)
+		return;
+
+	/* Initialize the list node in the callback structure */
+	INIT_LIST_HEAD(&funcs->list);
+
+	/* Add the callback structure to the global list */
+	list_add_tail(&funcs->list, &adev->sdma.reset_callback_list);
+}
+
+/**
+ * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
+ * @adev: Pointer to the AMDGPU device
+ * @instance_id: ID of the SDMA engine instance to reset
+ *
+ * This function performs the following steps:
+ * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU to save their state.
+ * 2. Resets the specified SDMA engine instance.
+ * 3. Calls all registered post_reset callbacks to allow KFD and AMDGPU to restore their state.
+ *
+ * Returns: 0 on success, or a negative error code on failure.
+ */
+int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
+{
+	struct sdma_on_reset_funcs *funcs;
+	int ret;
+
+	/* Invoke all registered pre_reset callbacks */
+	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
+		if (funcs->pre_reset) {
+			ret = funcs->pre_reset(adev, instance_id);
+			if (ret) {
+				dev_err(adev->dev,
+				"beforeReset callback failed for instance %u: %d\n",
+					instance_id, ret);
+				return ret;
+			}
+		}
+	}
+
+	/* Perform the SDMA reset for the specified instance */
+	ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
+	if (ret) {
+		dev_err(adev->dev, "Failed to reset SDMA instance %u\n", instance_id);
+		return ret;
+	}
+
+	/* Invoke all registered post_reset callbacks */
+	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
+		if (funcs->post_reset) {
+			ret = funcs->post_reset(adev, instance_id);
+			if (ret) {
+				dev_err(adev->dev,
+				"afterReset callback failed for instance %u: %d\n",
+					instance_id, ret);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 5f60736051d1..f91d75848557 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -98,6 +98,13 @@ struct amdgpu_sdma_ras {
 	struct amdgpu_ras_block_object ras_block;
 };
 
+struct sdma_on_reset_funcs {
+	int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id);
+	int (*post_reset)(struct amdgpu_device *adev, uint32_t instance_id);
+	/* Linked list node to store this structure in a list; */
+	struct list_head list;
+};
+
 struct amdgpu_sdma {
 	struct amdgpu_sdma_instance instance[AMDGPU_MAX_SDMA_INSTANCES];
 	struct amdgpu_irq_src	trap_irq;
@@ -118,6 +125,7 @@ struct amdgpu_sdma {
 	struct amdgpu_sdma_ras	*ras;
 	uint32_t		*ip_dump;
 	uint32_t 		supported_reset;
+	struct list_head	reset_callback_list;
 };
 
 /*
@@ -157,6 +165,9 @@ struct amdgpu_buffer_funcs {
 				 uint32_t byte_count);
 };
 
+void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct sdma_on_reset_funcs *funcs);
+int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id);
+
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
 #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 5e0066cd6c51..64c163dd708f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1477,7 +1477,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
 	if (r)
 		return r;
-
+	INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
 	return r;
 }
 
-- 
2.25.1

