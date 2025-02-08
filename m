Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84BAC02198
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Feb 2025 03:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46C5810EBCC;
	Sat,  8 Feb 2025 03:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T81WzxQo";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD76410EBCC
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Feb 2025 03:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gup4doBj9fVjfinMo7Y8OWCpNZ3IqhOveSBvDxV0bXzfaY3kFWro4umC7AcqvSLHffXt7dD28X84ww8bRXgNyxgbCQUN2G2fXfvDyJNnBXlc7WpKD7YFrKeqRJ7aeAPSaQDOYVTt3dkIiyPqK0L5DLoKw+077Jn1kRQbesm7yq5EzW+beK6Z8eExSSyRw14LewM4RyAT5+jDvemRkSF1JhFq19AfpKAPf/ycT74jDAw224p3XxeepwQCa7C6UOjvHQSxx2PUCYmtZdVtCSFKtg6mZzOey1yqPI99XHUbKv2sHSLKc0RbzNkPHrgX61Gb1DLhxXVmg4Fh0mVJYz3ohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+n1WmhwLyf4wRDDAz1+MQkAilGXoULXQX+NJKlExXg=;
 b=eEEy9h+JdHePSQRlZzY9+vu3eggNxQfOp4WGXeznjajB9X9XRFDpG4ELmp96l/xxBgkdvAwtJ1d6iQ50SpnEDuPwuDf8PxsDR0DHJwIkVhxxxCgnts01U9pRYueVmhgLwob3vDkdNlgByqe40gjLDSIVCFO0DI2k+4qp82RiKHNDyUnXunh+NMmwA7BcmZPp0Yn08XenpH6spGiWSg7s0J9gDHOkTGz0zizn5ZGdOT9Atbh0ZY9jn+7OxTG42MeqfsIeFCAfB8iibp5kBaS1y3uJQPgaAklfEcY/4cxfGmy6i0hygQZlZ7knHEZoceM+p6NQ/s7a/eeJ+PWcDxcJjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+n1WmhwLyf4wRDDAz1+MQkAilGXoULXQX+NJKlExXg=;
 b=T81WzxQo9pbNG9VHMyUCDaJD+GdJKJsPK7nh7Vpui+PGuInGjHxyRHSEm9SfJZOpO2lc3403uUJcv2yPSXq7BlQSUwR2LFTL8xK6qyiuqikp8Z8MBHmAIKkOHtXLgIYhpmKK/YPt0FKxBlCr9websEqsBrZ/mkZyTMdzkbqq5S8=
Received: from BY5PR13CA0003.namprd13.prod.outlook.com (2603:10b6:a03:180::16)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Sat, 8 Feb
 2025 03:57:58 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::5) by BY5PR13CA0003.outlook.office365.com
 (2603:10b6:a03:180::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Sat,
 8 Feb 2025 03:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 03:57:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 21:57:56 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 7 Feb 2025 21:57:45 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/kfd: Add shared SDMA reset functionality with
 callback support
Date: Sat, 8 Feb 2025 11:57:41 +0800
Message-ID: <20250208035744.2455413-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|CH2PR12MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: a7199752-6d58-4b2b-7875-08dd47f4c60b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+RP0bhFT8y2Cwho+KxHVWPo2sduJk9kXRYP7Q+uhR9OILjBpDjHC1e2J6g3M?=
 =?us-ascii?Q?sM/CefG+T4+191KKT1un73l1r3qcEFd/8WyJyBkrjZ/q6UYIgKtTtHFNaAZa?=
 =?us-ascii?Q?oshJBzFS9SiMuhplNUrzyrJVdlzANBiOxGeWV4SeeR6uiphXFnLY0qisCyYd?=
 =?us-ascii?Q?FJVr8m4SE4mrqY8PTtwQTKtzFJQITGzMY/2V50ZHS9LQQuTyGVBEJESl4540?=
 =?us-ascii?Q?fGH9GVlRLiiWWfuREOXNcn93q8oAiwTNB5Chd2UIb1prKKvMkjg+0kC59B/7?=
 =?us-ascii?Q?paoxOT7dJPkqNVLbf9N8rTjmgWXVg3fj6MEIbMuVxLkEGJTgPWkYIqol+Dww?=
 =?us-ascii?Q?tgGRRE9EeyHF74zmMDkCsc3IJU9I8A92Q8j51DS9zEoPD2kmZNqKAlw4trwW?=
 =?us-ascii?Q?5YZhoz4LMWnShaHqJJkXl1OsGA8Q3mZSoy6y4SEyXZo8ruwQfqx8zkhry4gi?=
 =?us-ascii?Q?U1YsXvGM2DoHOoIRyxc6JQ+fV2W3WQ1UJlDk6pHm45hX2c8JlvSY5U7+2hos?=
 =?us-ascii?Q?kcnfwTXolVNkHY0JEJCt1wTDpQqbhqXkfBkzdVrFEU4IUVj+SR3crQy80ZIq?=
 =?us-ascii?Q?AsuwdcjW0zabw1/I0BxO20WIxLmdUOaYWHlyz8EDmgVYJqEOT5vVZxxlQfUI?=
 =?us-ascii?Q?t2ObdXBcPvqCe0zs5UcWp60svyu9wWz/NsA5Ju4vZqcKDJpuqkXGvBups3no?=
 =?us-ascii?Q?uuBCwEeXW/YOmXlr2Wlmp29usCs/Vu8IX+g9Pv0CDq7j71bv5Lg/Pu+dxVwW?=
 =?us-ascii?Q?YOVKPvDLKxbZCrZxgCuSZVR4MPRHUngBqK3l/cqec9mgwQuLEreTFsgXdHyl?=
 =?us-ascii?Q?w9cTO0CV/XjjGE0xyJuqAPA3tyhxDCmcVnEXgUIj9f3u4CSIPLOoUyJy9j6+?=
 =?us-ascii?Q?VWvedX1hz2GFPKVk4yj3Sb6F8cKxUX3/nbGfOXWa3gUVT994zUrML1EYKTOw?=
 =?us-ascii?Q?mHiFd5p81J9iXpE3cMMAAzPPr63uwX45yPEXYSAAQCJ4B7IklRI77bL2tmoS?=
 =?us-ascii?Q?sXfsJp/99iHn4v8JKjRysnIFCCq996Dd5vxkFeQRDkCnTh0CAP6YORLMIP97?=
 =?us-ascii?Q?vdldp9ciw25J3Qk2pEzeXG78mhS2iVXOxjgSSqeoMxQU+8EIyFe3ooeWiOj+?=
 =?us-ascii?Q?8IsQGmmbj2CTcVcjZExs0hRV2TfCUTWR/1yePLpoGIZnJcmmZt+kjuL5JZuL?=
 =?us-ascii?Q?CUgji25BVPH70GCTjHBJUtAL9erUndwRhyeKnoycAGIJXMsAFId+SgbLRUrH?=
 =?us-ascii?Q?+ILENNbFiusmz3Q0jaVrXDb2/O/0DVaeks45hJa0gDGZquX/07uZwwIbkwIY?=
 =?us-ascii?Q?NNGf1JetBIsKtP9alIGvCbYfS8BO53s5x0DLgld4fWe4tWYjT5gCc413xqon?=
 =?us-ascii?Q?3+CRs04NmaESQEnl7Gyvt2zB05WEmrna8IUmVEhz3AH7SmbHADvVSct6iLxx?=
 =?us-ascii?Q?f9D2AajNCjUIAVjomUy0E1Sj5fxN6JWE9Mh3OhLlgsaIwjiopCTvkk8q4nSA?=
 =?us-ascii?Q?z7Lt6W2pkYY6kHY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 03:57:57.4992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7199752-6d58-4b2b-7875-08dd47f4c60b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520
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

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 72 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 11 ++++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  2 +-
 3 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 174badca27e7..19c8be7d72e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -460,3 +460,75 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 			device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
 	}
 }
+
+/**
+ * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
+ * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
+ *
+ * This function allows KFD and AMDGPU to register their own callbacks for handling
+ * pre-reset and post-reset operations. The callbacks are added to a global list.
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
+ * amdgpu_sdma_reset_instance - Reset a specific SDMA instance
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
+int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t instance_id)
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
index 5f60736051d1..fbb8b04ef2cb 100644
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
+int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t instance_id);
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

