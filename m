Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EFAC0219E
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 05:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5205F10E63A;
	Tue, 11 Feb 2025 05:15:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jotMeeGU";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D396010E41C
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 05:15:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDtGV/0YsuDJ5M0z2D7quKw8FtEOYoon6OAm/o2+EH/+7uYhn43azlyv1BDtaiEJojrAT9BfwkwUwjGy2vTzO2ymLb0L0VPg7qxCV7+uhw9Q2r5XQgzXRQpGEGmsIaeXIYgnDq5RX/s+t7AoMCPuNpKAsJWb/LF+Fno7diQuRqcfi7eAZ4eo17LOsQ7CLrqAltAKDqLlS9OxtIGZm8Nw5jYqabd6COB+2dopPYPx0v1d9EeTvD58ro2NkxS8usHRvKBH5YskpA+nodEg6H90cLJTwtQ7xGZBV9GCkObLqGj4Zs6tVHhhjNh4cR8HTOWpKyYPzqABbR9twJDliFNL+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+n1WmhwLyf4wRDDAz1+MQkAilGXoULXQX+NJKlExXg=;
 b=X7Q9z3FBcTDBLAjPocS3EjdwXSnVwoCvADYuPeEeEqyDTriUfLwqNgA9ny3KuY5lmLPM/1KNB3eTrX+8aR5A9XEvAZLeIO//QKNxzwp+YiJnaf1DQLjCDcaA0b9ZNd37miWXErLZQhG/WOZ3C0dijgVeUnoeaOJANyAlnN5VCNI6IcKjwkAX9DvAnd2EQJECLgH3At3rpEm8PA/SkicuRUM20ZkAoKCuc+jKY+r3vceWPVF9hVryuyPFkyLzSZ/GSMDQYZrugr6Ei6yY/MB5ke5HiOHDR8RT9XORiRynBfOHijot66+fbRZi2Tyd2DUWNUTBB6yAsKwJVW1LzL8Y3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+n1WmhwLyf4wRDDAz1+MQkAilGXoULXQX+NJKlExXg=;
 b=jotMeeGUHI4xDHU7UBz6v3UgEFuZGl9eaAngBaux1OossGRMbT6l/3cZ5dcZsEMWB6Oz+A6VpotoJ0fyIJEdayI8eIS8o978xNU1rouH37XvTdB8CR/0u+WJSjtOYUPxW66BX4Ej7oWdo0aMV5ILjBJPQ8w/6PUFkmT54X3wRAA=
Received: from BY5PR17CA0020.namprd17.prod.outlook.com (2603:10b6:a03:1b8::33)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 05:15:13 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::b5) by BY5PR17CA0020.outlook.office365.com
 (2603:10b6:a03:1b8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 05:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 05:15:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 23:15:12 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 23:15:12 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 10 Feb 2025 23:15:00 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 1/4 v6] drm/amdgpu/kfd: Add shared SDMA reset functionality
 with callback support
Date: Tue, 11 Feb 2025 13:14:51 +0800
Message-ID: <20250211051454.2811943-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 142aefde-e842-454b-4fda-08dd4a5b1053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Huo8hLB8q3jHcPCElK4A99+2ccq/DYbHqgzcTMv59FZfJiVNZpIKHGBXwh4i?=
 =?us-ascii?Q?yz+rit6mM6Xi6KLzok/jjLuRilaXSUF/XTxq5IN0jK7qHo3yPPg8joWmJoLf?=
 =?us-ascii?Q?0PF/95u+NFbHo5F0PazEDzByUHPAad64696yyeMfkQ5Idj3mrp5bmXhUKJED?=
 =?us-ascii?Q?IBycmyg7rZFUkLYn1iJZ93STOtznmO8ITjbqfh1oW2ufbyF3IugngUqu9sq5?=
 =?us-ascii?Q?W19J8w4WcKa+ai2H2Qn+GDduHkip/GtSYvhKv52XkRBaTlpEglaS8bJvzkrc?=
 =?us-ascii?Q?6a0LbN9wxWSocEZDshCUsKxxG39hPHGlwUw6spP4cC9E43Ot0CWgMwnUwPNi?=
 =?us-ascii?Q?XdUejQaU2bpRgCmRAYQn36+gt0u/LPo6dj+X0uiuO3Pq0CCQSySsQWTleVhZ?=
 =?us-ascii?Q?Qg36Xfm3UGlvCXhwOnaF5EOHfi9PVF0gjNlRC07W1g9JrOHic66qDHP/WjNb?=
 =?us-ascii?Q?pYt6+kcbcmHQJmT2gara1N/LIwC++tae7JZSAUZ74jqlmIBj8IqkEW8fRLEA?=
 =?us-ascii?Q?8deYe2v/G1ic1an1gCtdsTgboxbclvNTFz9xgROLvrfZhlZ4yhs7AZdqfWTp?=
 =?us-ascii?Q?TBWtA9c3q4vX618jXawGcytBPWZlFFg1QihQfbAqfi1hai4q45h2+efvtSuv?=
 =?us-ascii?Q?njtiFn1KUHJEBK05W7UgRxKCtu2/xn0Mq46EpNca6vfw6TPoZr0t2ofK5k+s?=
 =?us-ascii?Q?5y44TFBlamnV0Af0HcoZQFeAHnKLHw0ovx1d4DX+wlwN5blxAdKRaeVS+6Nl?=
 =?us-ascii?Q?SxOOqRilKoSo3EmEltqD3m93lMfZHh9k+6PLSuQ1fE325hVnW1FDpfXchO+g?=
 =?us-ascii?Q?W1zqpFqGQzrzXr8deJcUxz6OtIo7VCdTlMUC2hF6dWCemJe/WbwTX1v570aC?=
 =?us-ascii?Q?B2TsukJc55BAPHEJXIJL+p0DIc6pveDWSXhMAVStGXqbcsb8KOiSB79rvtAD?=
 =?us-ascii?Q?4bu3gUYbD0AsmQ8lmJDXb9ohIv/sjK/RAU2qc3cCo9JC5PD16Pe62rUYnkAQ?=
 =?us-ascii?Q?HCqstVtdy9Ke8ED0iCIAwPZzRziAyfXVr1AR4UhLloBGNfI4YaVXeSfX+UE4?=
 =?us-ascii?Q?J3/QzFe0B0aIumuqslghmKIEYa7gOPUMqzDBLubN+Mip4vIxOx3S2qJWq9IC?=
 =?us-ascii?Q?Tnpz8OzF2HN563Q3o0rILa/40kYeiYxBP0QpiN0saehNDXgRX6TBCK9OU0Tu?=
 =?us-ascii?Q?XzWzvyGAApaaF1vEDU5tbdhaZmP/E49cN+eiD40VJXXqNfGFBV6yupY15HOD?=
 =?us-ascii?Q?Y0AivUuD+2X+PU7YfIrYdjeBghRYcOQfyoejV7+tCntuGSQCrx6KMv/BKv/1?=
 =?us-ascii?Q?2MHO7SmbboubryLTYe38ETwmtvQ0eDDz3/lERIjSFv4DQ3AFknZaN8BUdGIJ?=
 =?us-ascii?Q?RyPOW4tern3lx6ZFkR7a1n4xeaTlyRf4eXUBDEoHBSr822RNr3Jg9gM5BydY?=
 =?us-ascii?Q?OxCOTfIykQA9MDv4Zx+bxc9BoJC0Hhws3ik/rVsjVp1A5D2ew/qC8TGFbJHZ?=
 =?us-ascii?Q?V/EYZ8ColSMf8NU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 05:15:13.0978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 142aefde-e842-454b-4fda-08dd4a5b1053
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930
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

