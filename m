Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BE4C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 10:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21ABC10E28C;
	Fri, 21 Feb 2025 10:45:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tN3iM+s6";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6356A10E24A
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 10:45:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZNARYm76sWeP7jcqVlA/rN8TKH7dttNoxQp4bkp/3c9+EEa2M9vQDBIsr6Iaz/A8JBKC0+NWtKz906hUzoa3Ihqzn53cp+tBs7tr2BaPUSFNOocS8sFftpjuF4rmNqoxe+uFQ3bz4O0+rsotkEs5fngNtk3eRt3gaNRghpWMNfCFigx3SZH1q0VxIL5m8puX9vsx0H1zl7SBe993z8YkmNApUB8sWr53DU2WfM+vdKTSojTih7t4ehWx7S/R8ed5NuSns3AToIQh50NWLw+DzlJJpULAs10LhaLp2HGf+rTk7I3cSvj7yXmgCh9PAtPJTciC00yD3FeTY6yWVDA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDgz43k8DvHJ1Fmu69oNIcdaF4oeKVLfIvkxaz0TfY0=;
 b=bKNWpDT9AmO/zp7qnuBFj0JQyS470JyGRpo/YcyUUMHb9nXYE9204RRe88wtg98Zb8mqCT8MuPFTqIWSulCfgpeWrX20G4M/ViglBAU9cIATQyqFgUW9/6cZUT0k4MIgC8MTgiSqjWUv8WnQC4LhLKbRAz5jxbRW3mjniXFJ9Sx5ZfZw5lvBtINoM7loa575QK1WeN9Oq+DYcvZok7f+LHdMfdMZsIfm2itd+5GZ41cicx0J5PxbRVHn4jn7lV8UvUEVrcOYo7TXMDbSuCWhshjT/PUwL6TKMOApNf5Uk7CmqIrOiBg4FI6kp5I9qCDVoDM15y7Qx/iUJDYrfLJGSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDgz43k8DvHJ1Fmu69oNIcdaF4oeKVLfIvkxaz0TfY0=;
 b=tN3iM+s6KVSFFa53v7xYSkbJXnqmH/odcIv/XOBrwxPIHn+ORAH93PB7dzItVy8l1gVmJ4thHRKzZ9LqkaQWYFshAZ7UpNIY1Q7QAXENAeMToj0fAVEwiNWNHlj6Fv+XCWgIvJ9SQozFtc3/Qb97y3XNKi0VBRh3esx9PgdGJII=
Received: from SJ0PR03CA0380.namprd03.prod.outlook.com (2603:10b6:a03:3a1::25)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 10:45:47 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::a0) by SJ0PR03CA0380.outlook.office365.com
 (2603:10b6:a03:3a1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 10:45:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 10:45:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 04:45:44 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 21 Feb 2025 04:45:42 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>, <tim.huang@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>, Jonathan Kim <Jonathan.Kim@amd.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>
Subject: [PATCH] drm/amdgpu: update SDMA reset mask in late_init
Date: Fri, 21 Feb 2025 18:45:42 +0800
Message-ID: <20250221104542.3994301-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|DM4PR12MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: 53ccbe6d-2d3c-4abc-8ef0-08dd5264e5b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?opmlsKUEkyhbNQOjsLDFvdcwX1KC5X1DzHo2KF0OA4/h5ks8xA+mq48o7awa?=
 =?us-ascii?Q?0fBIJgNzkMlJwUkVeLDLYsEyilcEvHQbUK8BPypnGk+CeJwevn+QtNEB5XS9?=
 =?us-ascii?Q?nmOCG10RD1OBPZhVSMdKT72DCmBVt4VpUYeFGSzwwWc75J6xupxpgoPQIMnl?=
 =?us-ascii?Q?kmS8/eQrcxXv6BeJQOLRHS+Qj1qEamMoeVL7DKZn1nh7IJwMY2fYiTecSy/p?=
 =?us-ascii?Q?dqS7Bqs3NnbIpsFKV0d1JjhW5kFFdhEqhgWQ7qgqXr69dJGKxAlKrdryf665?=
 =?us-ascii?Q?H7dFwdRu/m7sp81WI7agwHeCxhoc2fTD2Hgrvp8U4InYLUbgUJm3ES9lSE3h?=
 =?us-ascii?Q?q+Ts73i2fkF7e3Rm2FFXyFjqrkgKwgLZxa5iQCfagBad4u0Qb+4VEyAo+9i5?=
 =?us-ascii?Q?uM6zuxlyE0aqhiaWOslnMuzDA0bzosdaMnRUng3n3l6+c/5yw5fG4pII2oVm?=
 =?us-ascii?Q?kjv/dpoe6gTaq4FtliHZld6LzWbf6XFCJ3SkGiamVmt6vbGH04re5GtZ6mFC?=
 =?us-ascii?Q?0TLN8s9ONm9MDj0hclLDJotVxqf5rEnDvKZ54QxwFPJTuwbpd0UjKmFXEDEH?=
 =?us-ascii?Q?PClpTQohJNRxGOq+jhlnNy6OOgkB7rT+Y4hVn5ZejL6lY2IgDC2Wbt8rmFNj?=
 =?us-ascii?Q?oP/3/fMGcv9ch7lIM/3yqlBUvCM8GfouhfwqoP+IS+dOtnPGx5ijCJvJ4jgl?=
 =?us-ascii?Q?AycFqT+elGfx+pJknTA5YpVnlA4405SRevDNJkS2E8UqyFPbZDC2c92byhS3?=
 =?us-ascii?Q?TF56Le7Zzy94IBTffpEOHwTKR8mB1AUeNVMCAN12FrCYaBDxb5KJ4cih0do+?=
 =?us-ascii?Q?e2R16l+Yl0L4fww8k/QVukOIPUBZn/DeRg141sbLWyN0UOEl4hLbP+I2RW+M?=
 =?us-ascii?Q?zTB9ybj0hM4It8wQ40a80PbLTz/B1shlP5Z9rwRK/quiyPUJEHloaQ0HkAno?=
 =?us-ascii?Q?dSBO7CGA5JFKFU+e81wtUD2xt5mCEAayoqvJgAjsPk+DpAIscZLc30UixELs?=
 =?us-ascii?Q?/tnFgAXRwB4H9SMFog4tzsWwH5BKpLXlYjZNjpRWsF51ly2DbfwRncp6nQKq?=
 =?us-ascii?Q?uMeAl8PUTqzATmj0OvV/XfbikwsiYAU436kd0hxPIO8ki3KE9OZivLuo9Tt7?=
 =?us-ascii?Q?zI1JvKsf/0hZ4LDk6uhWEYhL6AbSl4+0e0ZVaRZiriU1BW6OJKIv8qPTmlCJ?=
 =?us-ascii?Q?EalLsmx0GBe/tLXu5rSV6ruBBGhhTorgQBM/zFPTyJR2+kRvYD2AUNxmEOod?=
 =?us-ascii?Q?ACi7OqKGLjDySFJg2e2mZRMxkuW+zVvPwshGD5H6lkZMOTVJ2frP9bsAIJTV?=
 =?us-ascii?Q?k1cXBnvYKR7mzgtC/NFeZngaXzmNkhXK1JBJ69d/dxFngBTk4Pb6D9H+ovh0?=
 =?us-ascii?Q?3rZ39LGlVA0fSNaJFqfyoZTVNuWl1AJYGFlrtMVQLeKfX/f55N9BtddiNy1l?=
 =?us-ascii?Q?soBwdlB5GdM8T6tPenbD8h2w3ALZ0AWP9wvXgQhY0s8H/aBepGab/w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 10:45:45.8847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ccbe6d-2d3c-4abc-8ef0-08dd5264e5b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011
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

From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>

- Added `sdma_v4_4_2_update_reset_mask` function to update the reset mask.
- update the sysfs reset mask to the `late_init` stage to ensure that the SMU  initialization
     and capability setup are completed before checking the SDMA reset capability.
- For IP versions 9.4.3 and 9.4.4, enable per-queue reset if the MEC firmware version is at least 0xb0 and PMFW supports queue reset.
- Add a TODO comment for future support of per-queue reset for IP version 9.4.5.

This change ensures that per-queue reset is only enabled when the MEC and PMFW support it.

Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 37 +++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 4fa688e00f5e..17e7e36f4477 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -107,6 +107,7 @@ static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *adev);
+static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev);
 
 static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
 		u32 instance, u32 offset)
@@ -1374,6 +1375,12 @@ static int sdma_v4_4_2_late_init(struct amdgpu_ip_block *ip_block)
 	if (!amdgpu_persistent_edc_harvesting_supported(adev))
 		amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__SDMA);
 
+	/* The initialization is done in the late_init stage to ensure that the SMU
+	 * initialization and capability setup are completed before we check the SDMA
+	 * reset capability
+	 */
+	sdma_v4_4_2_update_reset_mask(adev);
+
 	return 0;
 }
 
@@ -1481,7 +1488,6 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
-	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->sdma.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
 
@@ -2328,6 +2334,35 @@ static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev)
 	adev->vm_manager.vm_pte_num_scheds = adev->sdma.num_instances;
 }
 
+/**
+ * sdma_v4_4_2_update_reset_mask - update  reset mask for SDMA
+ * @adev: Pointer to the AMDGPU device structure
+ *
+ * This function update reset mask for SDMA and sets the supported
+ * reset types based on the IP version and firmware versions.
+ *
+ */
+static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev)
+{
+
+	/*
+	 * the user queue relies on MEC fw and pmfw when the sdma queue do reset.
+	 * it needs to check both of them at here to skip old mec and pmfw.
+	 */
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+		if ((adev->gfx.mec_fw_version >= 0xb0) && amdgpu_dpm_reset_sdma_is_supported(adev))
+			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
+	case IP_VERSION(9, 4, 5):
+		/*TODO: enable the queue reset flag until fw supported */
+	default:
+		break;
+	}
+
+}
+
 const struct amdgpu_ip_block_version sdma_v4_4_2_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_SDMA,
 	.major = 4,
-- 
2.25.1

