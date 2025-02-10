Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC8EC02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 07:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57ABF10E4BB;
	Mon, 10 Feb 2025 07:32:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QOwStA8a";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C591710E4BB
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 07:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/0ERMt/zNV2oKxhKp9lscrMYqiKljrHRb7CW1ZNOwmQVvkA0j9u3r+s20Y3VZyjFbZZS4UGAL8QPiVbWDkTFLC9mOsME6o+/dIdGuO3nCUhwxIJteKuEKvWFDA+3i9/EIxsz8ZmSWpYqPksltXSxzfzOLo1SA1+zJDIdtNlro+QpBoumlfGFfMnTtvcckp8Cogl1yqo9XkbgleW5rlcuBWJ1l4hgWphkd4RT2X9kFWNRigSWKwRwD17OSWQYyp0LvvYwWN9ANXX6whMr3Bq6QimpTRhXwopesXltlwIJPALK5YRVmuKwDMdowoKQyxsZJUsafvXGci13uttSNjKrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+n1WmhwLyf4wRDDAz1+MQkAilGXoULXQX+NJKlExXg=;
 b=yuQQveymbeL/tUFVzRxZRfQ3bafLY9fdBPNr1yE8SEn8q7hhXv2vFgXBLgVV0nIvhucVwanWAQ4rcAV9GR2B/jb/vgbmLH+dKygo5i0FjUG0aoXtmDIebbRfNG0p29o6FubmOVsy8fZT7YuGRfT1lZbNkTkG2+wt+v4Hm5NQF4t9pgTVTsJnqFd9mYBWVBh2YzUOzPweOM7oPMsrf7drLvlOdWD8EEGZD11X4X2X38X9oCePHwAkvW6ACHnO7xEadwCSvl/kAQoXzbVOTAHrQSLTvO57jOgw5oMYLkpLqtgKC8tmoyK0M7vfXeaz1L0PPHKS838gwYyR060HvFCiTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+n1WmhwLyf4wRDDAz1+MQkAilGXoULXQX+NJKlExXg=;
 b=QOwStA8aiNDOr0do2xgiDlgPBq5WD5p0wHLA4OqKzrfza1SGe4XypHHJmXsR0lEXGLnyUMwjJOz7+WHH9Ttc2HpXYjAIGNOEuTAV8j402VG9+9o95njlH1hQ0E4BwPuDyKRkl1qtp0AL/3b9J5riNtWYburhagaqduyCBCxK8a4=
Received: from SJ0PR03CA0198.namprd03.prod.outlook.com (2603:10b6:a03:2ef::23)
 by SN7PR12MB7297.namprd12.prod.outlook.com (2603:10b6:806:2ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 07:31:59 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::4) by SJ0PR03CA0198.outlook.office365.com
 (2603:10b6:a03:2ef::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 07:31:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 07:31:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 01:31:57 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 10 Feb 2025 01:31:46 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/kfd: Add shared SDMA reset functionality with
 callback support
Date: Mon, 10 Feb 2025 15:31:42 +0800
Message-ID: <20250210073145.2681082-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|SN7PR12MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 67980b66-a199-42f3-b6d4-08dd49a500f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YWno8E+Z3xHSuhRkpkAmcQVFHMNmAub2qIlvOkT76VKqz17YlkyR42WKL8zR?=
 =?us-ascii?Q?jbWuz8vKgmuSSFXLR/QQcDDQXBCOrR+xZ0FGrbugOl4/YPulM4v3ljxKm6rq?=
 =?us-ascii?Q?JpxllHeCTHJytT9KXMsYI/F16Cb9dGfVR7Q5Xb/R4G9PgjunQKLBYlUfTibw?=
 =?us-ascii?Q?4EtsV0P74nTIeMNic8EgCArrCD/ScD4UNcob1dkoqCVjgTvk4llt6K4hVYWm?=
 =?us-ascii?Q?9ZqwowJuw3Z1gcTCNcIOV+AFaZUWt+/OPAxLY13VY2SqdOVwl2Q+izWZTKdm?=
 =?us-ascii?Q?O+5EJTDS5mZojmTks8a4e9wR38THiVjMtHjq29pTzYvFyyoYdluVZ19SxwYU?=
 =?us-ascii?Q?Sor0h5U8t2JtDMtS1TJn6cm+enUT2w7bdpzt8QlE+aTg8LIdTkIGGdMiJJiZ?=
 =?us-ascii?Q?GTDBKabz+JVFILZfu/2H61Rj7Z/8HdDstJ/wP+WGPh1Drwbr0IWKVpf/JH8V?=
 =?us-ascii?Q?9nGLNCMUEl/O4WxUFJnpUBVIOzXhpJo6jzBmOX0R0TJbAV19ntSokpQZ6kCN?=
 =?us-ascii?Q?yFayQCYsRjXJgfHaWwPW53O0fVtkrAgPvFF4AYsJzt7yBowgkxdQUhcVpVWU?=
 =?us-ascii?Q?TSG9D6lr1fJh6eFVm6YXvaVXEyelrv7o4xuzNJ+eWnuIpDpvKMC0hurA1NKk?=
 =?us-ascii?Q?+KlD7TfQYtruZ4Xycvyvg75ncANHYluwJXoAQl7T3a5HG1deZ3IqrPfwfkr2?=
 =?us-ascii?Q?iPOvx6Lx+mEGkifwllqx2FVpTCaarMYNVkwDHNDZB0zFqJRd0TXW3XSngMty?=
 =?us-ascii?Q?iSP8fwVkMLZtgIgF+8Ffv3La6poKtBn0/YOPM3cetnI7os8+OpVDTQWiKtQ0?=
 =?us-ascii?Q?2QZXgQ/K3/m8iAMzIO8mkKNmgc6exC7uGbCadSkPRKkBd9QQoMG/vecbCOO4?=
 =?us-ascii?Q?ufKYRXHuR3cXjZJRBPu+2U0qlm3QT7au7r+sGO6TiQM8yFPyhddyQVDeZ5zz?=
 =?us-ascii?Q?eWdaUh009s6o44EoWdSPwrG+fUnMsB2jawXeyEWyPY19r3yilQyrUXtSLv58?=
 =?us-ascii?Q?vKYmmIT1fMB0L8VN171A3tXhNVXhcypENSopw00caBk+M3ntj6Ee5C4VH9Ig?=
 =?us-ascii?Q?yg5zwXECHnwdphPwaqLkImwDTAgnEd0jP1HZ/ihThro2kokcu7S9/Q5EQn3C?=
 =?us-ascii?Q?gZ+a8PLEwhpG3WfIun4MC79wMqsWRr2L0G1n1/llo+afTktGf4fbOScu1fuI?=
 =?us-ascii?Q?nuuUDJBFNpkCNZgqDYvq1oATl6bDTPdSbszE9waE9WkH1oJNzmlRlr89eZlF?=
 =?us-ascii?Q?9cD6GEGy+Kv1w0I/2YA6KbeVIdmCZq3IbtmTJkT7SNHDndQLCHPKg8bgnQBH?=
 =?us-ascii?Q?hz6wOwM66etCUdu+Jyk3PqdvYNbh58T7S435kBBP4aBBSr5Gay/kMyNe11AW?=
 =?us-ascii?Q?3uV9g4BADTBjhCbmUNN0G1DwmhnV8G5XCif1Bzx2ZY9PdQ/VwfkHFPTcYDAp?=
 =?us-ascii?Q?qy86tdQ3Bv5T/M6JJvfcK33gtPXIL5OlTlKk1IP0cTFTYhhTg/v1/ajzK4NM?=
 =?us-ascii?Q?ckYt6wTwp1JfiIs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 07:31:58.9410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67980b66-a199-42f3-b6d4-08dd49a500f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7297
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

