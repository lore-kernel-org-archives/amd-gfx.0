Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D686CCA470
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 05:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E98710E2DF;
	Mon,  6 Oct 2025 05:19:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DQbttK8N";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3CB710E2DF
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 05:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vbgj06X20OrOZBYV1CdEa60LY/xLrUD99uKqlbFXQozxBCUVgkh9cnydPHgAyrw2iEM1DCJc0gtpHy4cOs6fhL09mfCylx5603pLDzu5GN7JpMf4VbjFh8XB5dFhMs5+MRu8m/x6hYJBP1AgG/rEbVkHjLbEWQpjPngZtljKUoD5qjN4RrnCQaDFSbeEQ7ThbMNCWNNbZfk5U8rgIShDstW9ugg//Y8acwWZGHJx6/q2hgFe5oPseS7andyW8BmI+qwic2lCVY6kTrDj/AtP+v29payJEFiNhlYTMJXsU0k9movHHhgKgJQq9SlhsClBQ80Zy67Mb1V2+YZdOybeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oORQQ1ILiBEohnpl75T4qhCP6PmvEYpHzivijPXXneE=;
 b=UV36egM4omFVMv/3/S/k+n9ncL14mPOfu36wDXageWavy8UVKHrk8H3e83L+1yaN0Jc4eHNzKoX2VPAYO9i9hMk75sl9TAJtgV35N60k55ddTIlqWGNAV9LZCyW4yvv4KTY3lTmsgsB9VU6ySKE/5whxrvCTc0elhF/TxaX5icCYfi4m8NVDU9Z7qfXq2fidTmeGIKbh2RBaX0cX0nKSUSysrC8KjIENwXm/GUVjb41EFFxo0ZBXnPJQb4uNiVMrilDZws9jYgewAuUgA0S4ukuwVI0hrrFHvOgzDK0P01nR8xHWFNflrsaHc2wHzzZz2DLjea9Woma3LpazB5MpHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oORQQ1ILiBEohnpl75T4qhCP6PmvEYpHzivijPXXneE=;
 b=DQbttK8NJfgLEMumpPx9GmeZoHvNdAoeFfAb3u4c9Da2+qebmdH79W0SMDCM44ZRyJ2KpyQatgY8QcfvbMz92rB4J172PzI/M/drOgrYEQJOKJjeqWtZVIZoiAOs7QVWtmBhn95982+HXa+DbZZKYx562d+Z7j9yPPbIYDepL5o=
Received: from SJ0PR05CA0154.namprd05.prod.outlook.com (2603:10b6:a03:339::9)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 05:19:44 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::2f) by SJ0PR05CA0154.outlook.office365.com
 (2603:10b6:a03:339::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.8 via Frontend Transport; Mon, 6
 Oct 2025 05:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 05:19:44 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 5 Oct
 2025 22:19:42 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Report individual reset error
Date: Mon, 6 Oct 2025 10:49:25 +0530
Message-ID: <20251006051925.3354101-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|BY5PR12MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b040af0-6254-40f4-19ec-08de0497f5ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3uGkBTUTwGjY3rPKUz9tzGcQX6Nlb0Ijt2ugmF3Zvb1UJDMLHdtNdOjDKj2P?=
 =?us-ascii?Q?m0vM+WW9YGxIQsIjyejw+7ufopGPTBZcy0clAfdz8d6GdTs26GTb2N4uSRxP?=
 =?us-ascii?Q?WlKcTtlmVxAWlZtfleIzBREJ0c412Z66+QkauwPbwHQ0XhPHu3Ikl5izoGbv?=
 =?us-ascii?Q?srXvEqCOJ91NisFqtJmZ9zjoDolqeVVkZT9eRJihV/0aJDZ3u7ICI9OrYNvv?=
 =?us-ascii?Q?nnVGOLiRACF7g9x5vX3I9AfEL+9PnF+qxJSa0aJEdmScOEi28goBI0p+qIOZ?=
 =?us-ascii?Q?K0eUxKe3gCYZhHZgHE2KHlwUPvlHMwX+uqpRnZf0S/1VzCS0ZKMytiPaXmtJ?=
 =?us-ascii?Q?f+WE6QFMC0SuN+LF4LsKKqWNbM5njBE8ycGEbZfE+yDx2I7bn7lw0f+0wdYV?=
 =?us-ascii?Q?lh+2FY+zOmbesiaW4eK6BHrYC3xKG9T+KCjYlawq+iu8ngM3BsmB8yMIFc+u?=
 =?us-ascii?Q?u6zC8TH6VqzR9GIUiewcHoXMx1u748fbms3Atks3elpPfTh16aIwOmnOzoN9?=
 =?us-ascii?Q?XuytAPoGPK4GxXP968yoybd69/QZGu1HbOul3IlDJgf4vUQXj9G6ZJY9Q8L2?=
 =?us-ascii?Q?7lVnTMYFhfbxOCRRfVQIUQJEacKcxxvbHy5/hHIK3cHXRTmTJvtAurUI3nKS?=
 =?us-ascii?Q?hhUvxCrrCBAm6k6emrtqhPvVx/eaxUvfMKb/Gawz0DRbT/cxrBE8WUBZuwYz?=
 =?us-ascii?Q?b/ROoGJx3DWgcVAiA0GMJghwjWbKSQ2iR/bENaMDE+GbUF9Uu2orOQ7lGLIY?=
 =?us-ascii?Q?k7fpdhcRgTWEcRHyB2/gXFMe/QbCUFa3vqWtLpvrGl+K0eaVLrvIM477po19?=
 =?us-ascii?Q?JkqOuIoAkWS84E2NKeuryhJazDJzc+W1gz0JcMWt2VJQAiyMnANvamVF7Uvp?=
 =?us-ascii?Q?aEtZ3iWUKA7moo9e8X/+/p2KYVVVvpV3tjCOfyfOh8kXMHwZa7I+8W8y7wTE?=
 =?us-ascii?Q?AVgzoJTp8T8AFLXh5W8Rd8Uv003t0KhJL4hMG/dZ9BBuxdkeyACjeIUth7VD?=
 =?us-ascii?Q?OTajyVUdQuuNN/PHP+3NDjdmJr0RvhZk+HSC26TLgv96ax9l+ve8v32b0U8x?=
 =?us-ascii?Q?PFZvX4+9yyc8UBg5N9DyaLceHYOZXps6X+TlTHQCNFUbcQkGOEApFcLf5ZFt?=
 =?us-ascii?Q?A7PjHUWdnDDOfbqrJ3RduLmK9/F2967+qMddqW+lVmvkq2BUrTOQ2Jekh/fK?=
 =?us-ascii?Q?8NPR8l/a3nBKvqAS0Jjpfk+RFI9CZ60eQ0Fzjy9DkoQWnAgstSaufY95Eflp?=
 =?us-ascii?Q?JGxcO9WHJqPMqribF8qEEenFMs+yDjOoSBaRmwskSdIY4TwN2XacUhxieAHD?=
 =?us-ascii?Q?Tzvfdd9+7cMQvtE0e0J3HvMvRxM6L2hbn1Ywa6rNTMZM7KCr+ZrElXmIW7C0?=
 =?us-ascii?Q?SFAjv8ISp3tFPhl9xVtxOZxISVZgBP4iyuzqJZPZjr21l5eseD9wZrLUjKRb?=
 =?us-ascii?Q?7CXAXIYkNUYMu2aJUoIGh2V1qbCupDrcDj+IHCuuLKXRBRwUUn6BmNsZVus0?=
 =?us-ascii?Q?nMj6xag7TXfR5MkNT5AijpI9cMa3YcYsXSqhF9GCUHBqZsCrs3J1+u7QU0nI?=
 =?us-ascii?Q?6UfnbI6FaWJ7xSqhjWk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 05:19:44.4379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b040af0-6254-40f4-19ec-08de0497f5ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098
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

If reinitialization of one of the GPUs fails after reset, it logs
failure on all subsequent GPUs eventhough they have resumed
successfully.

A sample log where only device at 0000:95:00.0 had a failure -

	amdgpu 0000:15:00.0: amdgpu: GPU reset(19) succeeded!
	amdgpu 0000:65:00.0: amdgpu: GPU reset(19) succeeded!
	amdgpu 0000:75:00.0: amdgpu: GPU reset(19) succeeded!
	amdgpu 0000:85:00.0: amdgpu: GPU reset(19) succeeded!
	amdgpu 0000:95:00.0: amdgpu: GPU reset(19) failed
	amdgpu 0000:e5:00.0: amdgpu: GPU reset(19) failed
	amdgpu 0000:f5:00.0: amdgpu: GPU reset(19) failed
	amdgpu 0000:05:00.0: amdgpu: GPU reset(19) failed
	amdgpu 0000:15:00.0: amdgpu: GPU reset end with ret = -5

To avoid confusion, report the error for each device
separately and return the first error as the overall result.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 +++++++++++++---------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 929936c8d87c..7a899fb4de29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6389,23 +6389,28 @@ static int amdgpu_device_sched_resume(struct list_head *device_list,
 		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled)
 			drm_helper_resume_force_mode(adev_to_drm(tmp_adev));
 
-		if (tmp_adev->asic_reset_res)
-			r = tmp_adev->asic_reset_res;
-
-		tmp_adev->asic_reset_res = 0;
-
-		if (r) {
+		if (tmp_adev->asic_reset_res) {
 			/* bad news, how to tell it to userspace ?
 			 * for ras error, we should report GPU bad status instead of
 			 * reset failure
 			 */
 			if (reset_context->src != AMDGPU_RESET_SRC_RAS ||
 			    !amdgpu_ras_eeprom_check_err_threshold(tmp_adev))
-				dev_info(tmp_adev->dev, "GPU reset(%d) failed\n",
-					atomic_read(&tmp_adev->gpu_reset_counter));
-			amdgpu_vf_error_put(tmp_adev, AMDGIM_ERROR_VF_GPU_RESET_FAIL, 0, r);
+				dev_info(
+					tmp_adev->dev,
+					"GPU reset(%d) failed with error %d \n",
+					atomic_read(
+						&tmp_adev->gpu_reset_counter),
+					tmp_adev->asic_reset_res);
+			amdgpu_vf_error_put(tmp_adev,
+					    AMDGIM_ERROR_VF_GPU_RESET_FAIL, 0,
+					    tmp_adev->asic_reset_res);
+			if (!r)
+				r = tmp_adev->asic_reset_res;
+			tmp_adev->asic_reset_res = 0;
 		} else {
-			dev_info(tmp_adev->dev, "GPU reset(%d) succeeded!\n", atomic_read(&tmp_adev->gpu_reset_counter));
+			dev_info(tmp_adev->dev, "GPU reset(%d) succeeded!\n",
+				 atomic_read(&tmp_adev->gpu_reset_counter));
 			if (amdgpu_acpi_smart_shift_update(tmp_adev,
 							   AMDGPU_SS_DEV_D0))
 				dev_warn(tmp_adev->dev,
-- 
2.49.0

