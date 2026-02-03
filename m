Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4E7E8304F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 04:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A27C10E502;
	Tue,  3 Feb 2026 04:13:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bBXcmhs8";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012039.outbound.protection.outlook.com
 [40.93.195.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A35B10E4FC
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 04:13:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbYEdW++EqFQeKIkjvRxliS9m8YHZOKTq5V38qIr/rdriqPq71GHeA0+8aaapwd7f7Yo3F9C7eeKXg52fPHApXlKXMz+GGT0i0H7gWmDtmkp2VkJZFsagsLShkewErfSDpkEPZ2NmVN3NU1MjW2CTFoZK+MML1tL+JuphgWfFT8xwKH9cfA2yOGwGcuEhyveF39v4MSotacFampLtEP5gPxTrshj6oVZb5dE9uPPiN9nIUURuzCtpthM35OFXhBzGLWhSC6lsJ02M8rS7VHYLxeOufthh77+3IHCZOM34StSERGSm9a6KlbcdCl2mJBTK5OoSrfxjagphx5d4cSLig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Rlz4k8+9hl8qcKfK4uN+sXyTJ19b1HfQCf7oGubqM0=;
 b=ZJdFbB3EwV8iHTo034q1yy7bmyvvWEQyncd8m2RJIZKFfTWJt3LyPDF784CepAQLH9V+T9g/284BjccXCSqaoeJyVc3yreT+JnpM3c655KAPi3ecrJfdOIcDDlSG3fUuQspNVBapqQTjlRIIgjaUBYjrxLUBaJhqEmYoVJMcLZOMufPZVbwfbkMBKHTFUFPuAHz28aHkPvCCInrKlpkPm4zTKG14VULrfw4mkx+wZYRvS5e9A68AM8HVd3Zozz3mKCuMLyUNfAk06yXqyOSQgnbejvL81ZNE4IGxwiJXIm8UP9sUAJLTVOsmO0rTb0R4ixNEvjs8bdYdHRrWHqpPEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Rlz4k8+9hl8qcKfK4uN+sXyTJ19b1HfQCf7oGubqM0=;
 b=bBXcmhs8K7FOev/kIIocqQGZituB7rMGNt9ofrxXhc0q+Wz9a6fNkOXYIFndu06xmjPkz9T6QP212jMlQw6BEyLRkLMTZvKR5PnTUiv8VwnuISfaNxnt4g1lksuZl/FpGzCiZc2cO/Mebn7vWTocIJ6g+cg1MOgDCmXFHFo9eiA=
Received: from BN0PR04CA0043.namprd04.prod.outlook.com (2603:10b6:408:e8::18)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 04:13:09 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:e8:cafe::95) by BN0PR04CA0043.outlook.office365.com
 (2603:10b6:408:e8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 04:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 04:13:08 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 2 Feb 2026 22:13:06 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH V2 13/14] drm/amd/ras: add check func for pmfw eeprom
Date: Tue, 3 Feb 2026 12:12:05 +0800
Message-ID: <20260203041206.1299104-13-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203041206.1299104-1-ganglxie@amd.com>
References: <20260203041206.1299104-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: 298c3623-833e-47ef-8826-08de62da8997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?huRcDzsBeEMqLLKEHWtcE9aXmoPEJXsrTa3R5cXxv6vR9vWFGvnQF5mAIEL7?=
 =?us-ascii?Q?2+o4IVMvT/ZggKWL4Yn7PkmsNGxY/hOiNWss+pxS12I2EFaZtvGG3wIeOgdX?=
 =?us-ascii?Q?NqdlYwAqw0RY/VGfCEqjHdkVThfd+1cLZ/Ha/FcESUsDXlaBzEHiHnDhDPMe?=
 =?us-ascii?Q?UUE4qOTl97jd0E8xX+qkhE0rTDZzQX3t7fF2btJ4w1rh4FjTBWRkYhwdWpwD?=
 =?us-ascii?Q?gRaycq33plUe/qE5D6JuyxCQpYR4dRhgvkO+q3KBlGRSF6fscaNdRtUdgsM5?=
 =?us-ascii?Q?hL0iNS4B4jrG6gonK28AmBxFpG/CODdOaAoayLcvVeDjdSym3GgpbnhA14iM?=
 =?us-ascii?Q?DYrBrAB/9KMU7zBRJyWy+Rmr7RjGQjSRh5Kblwd+4hqEqfugXqTmmP4/lctk?=
 =?us-ascii?Q?CXo4NAPRLVAn+m3Eker5rw9aqM3W0u1ZETsp8OxhgDWp1BN6PBD2iNtMm/6C?=
 =?us-ascii?Q?bBdYZPaSbgO/p9IacQZDq7nxuGdNZWNqY5UYosnoFC3Hxm7F53kU/WNfNo5c?=
 =?us-ascii?Q?daiwjGPQp5HE2cZ738i3w4yggVqk1e3X5vw9mzMT7Z8a+0YTFaolNsGL36JB?=
 =?us-ascii?Q?K8ebbSSmx7fvFh806EE5qQSyh1LoaNIrVYuo8+VqNv0Wk7aco1PrnmrFXE5f?=
 =?us-ascii?Q?HGRk8TJOdMKvxCB+1HD2Wq8Wsy11KAxOUt1T0NzhJoc2vUQAKwboPhuXtqrr?=
 =?us-ascii?Q?ch22+q5//XXLao5Puqm9QWq132GOCwLDIWPVt10UmbnLCBjWI+Q2OmvlI9u2?=
 =?us-ascii?Q?kC9h82pmqgSUCjkpwcnKykFYXVzpkOedU0gB+ZoAXlzbgK4Ck6mY2TLYMSSO?=
 =?us-ascii?Q?lGRY6W9zTYWgwpGEI2M1sgtidxtScZQgE9njHVrtSwldSiqAXPcDnUvFAoTO?=
 =?us-ascii?Q?4RA6WxgqOOJGuarDyafhiofuBxJUw31oBA2nfO9OqsFKKl8iiol8XzkPrAX2?=
 =?us-ascii?Q?KN8TrMs7uMBDoORTDlk+fPiOgT0t+HZSTNBnnF+aR1hqFsmqHduULsVXBmCP?=
 =?us-ascii?Q?g68U7sr2Bion9sHJjwW9ARteYpcXt8/NaeMA56fLtR3GYmITmoB6tn2ekZCO?=
 =?us-ascii?Q?l1HMwkNM+JuZYxrNmf1dABzq8w/yP50x7fSQprwAPLZCkSxnyaDc41XH+e2d?=
 =?us-ascii?Q?6S7U1FG9/CwR3ntBO+sm7+AwijKrA3REMTEEVsPtHVJftPqJm646bg3EE+lP?=
 =?us-ascii?Q?/XuxtQqmxg6ZYQfY7G6YXeHvSUi1JlfQl13gko2gkdXGmbtMld6ct5idd8Pe?=
 =?us-ascii?Q?dlCWZr6jWBtHQIDAafqJE4feG32xVPGs/r5Dv/XMhkSNHKq0keHR7Lzmfgrw?=
 =?us-ascii?Q?JQP4kbhvx3CC16qin37oytf5WUv6hiiNejeDup+wAmRKG7m8LrydD/FAmeZ/?=
 =?us-ascii?Q?jrE71oRYnC9yWeBCfj6ed9lF2dFSFmxObgNe4tglDSSB88j7oPCq+4pbIV9o?=
 =?us-ascii?Q?/Kc1+FW2DX67CQkMARuTv4GLOiiC7RrM9BtKN0NyeKIHFNtwfYWP2+KYBFsx?=
 =?us-ascii?Q?SmGVe/ikImDSlIuNWxZEVEmkpUgQyncIEk7/0osRczcZ3bAcTDgYdorZo4Mg?=
 =?us-ascii?Q?zXF/NSc83N0GrCm0WkUbPxKU0RR1HeaGtTrIntRqyobMuWIpCMsVp73WVsjM?=
 =?us-ascii?Q?Xm98ehzNIj9E8zJISKy+yb3sF9pBFKGE6lJC8I7pUbGIk7Ktxjl+68AvUgBg?=
 =?us-ascii?Q?i6R9VA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V4HYa6wv+cdVqWTshkh9+/07tj2kvJ0H1Jx48KG5TZ4TKJ3zGjv+S8U6+Aw97LcZw5ONk8fvsP4CgDdrH3sMvfegZk8JNQgSlVu/f8rHMxacyselL3tvN11Ra5APjQTmtIufkl5JhmA+5tbrnOHPZF/FHAhVdWYqMt+SUegduG+TMR7ae8Dno3cCv0mWh5L688zcSHRDZT5VuORSswXMSVdZJNwvPaza8V/4YFywLj3JVEfjxN2dxtdNAV5QkGNNUylvrvp0rme42VucsTsZnkeSrXmZJajXWhZhYjicnPe1FVJZhW3q4SayqRk/dUDSm/NMWdGyyZNQxt7URTqTLPsaALBgDWHsVTUnppBLulnsenws1Szb9zwAH5J4IxcCA1cfF+k0B2bdNtfXI6fDnZ1wKgstancdTgrb8TIOHiFDZDNUUzJvx2C2wtQ1m5ry
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 04:13:08.3571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 298c3623-833e-47ef-8826-08de62da8997
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160
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

add check func for pmfw eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  |  3 +-
 drivers/gpu/drm/amd/ras/rascore/ras.h         |  7 +++
 drivers/gpu/drm/amd/ras/rascore/ras_core.c    |  5 +-
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom.h  |  7 ---
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 51 +++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  3 ++
 6 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index 45ed8c3b5563..7d728e523604 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -137,7 +137,8 @@ static int amdgpu_ras_sys_event_notifier(struct ras_core_context *ras_core,
 		break;
 	case RAS_EVENT_ID__DEVICE_RMA:
 		ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_RMA, NULL, NULL);
-		ret = amdgpu_dpm_send_rma_reason(ras_core->dev);
+		if (!ras_fw_eeprom_supported(ras_core))
+			ret = amdgpu_dpm_send_rma_reason(ras_core->dev);
 		break;
 	case RAS_EVENT_ID__RESET_GPU:
 		ret = amdgpu_ras_mgr_reset_gpu(ras_core->dev, *(uint32_t *)data);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index 05c7923e8f0f..c2a56138b2dd 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -50,6 +50,13 @@
 #define GPU_RESET_CAUSE_FATAL   (RAS_CORE_RESET_GPU | 0x0002)
 #define GPU_RESET_CAUSE_RMA     (RAS_CORE_RESET_GPU | 0x0004)
 
+enum ras_gpu_health_status {
+	RAS_GPU_HEALTH_NONE = 0,
+	RAS_GPU_HEALTH_USABLE = 1,
+	RAS_GPU_RETIRED__ECC_REACH_THRESHOLD = 2,
+	RAS_GPU_IN_BAD_STATUS = 3,
+};
+
 enum ras_core_fw_feature_flags {
 	RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM = BIT_ULL(0),
 };
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 1eba279a020b..a4e2ad6a159f 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -401,7 +401,10 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
 		goto init_err6;
 	}
 
-	ret = ras_eeprom_check_storage_status(ras_core);
+	if (ras_fw_eeprom_supported(ras_core))
+		ret = ras_fw_eeprom_check_storage_status(ras_core);
+	else
+		ret = ras_eeprom_check_storage_status(ras_core);
 	if (ret)
 		goto init_err6;
 
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.h
index 2abe566c18b6..f2c001ef64e1 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.h
@@ -57,13 +57,6 @@ do { \
 	(RECORD)->retired_row_pfn = tmp; \
 } while (0)
 
-enum ras_gpu_health_status {
-	RAS_GPU_HEALTH_NONE = 0,
-	RAS_GPU_HEALTH_USABLE = 1,
-	RAS_GPU_RETIRED__ECC_REACH_THRESHOLD = 2,
-	RAS_GPU_IN_BAD_STATUS = 3,
-};
-
 enum ras_eeprom_err_type {
 	RAS_EEPROM_ERR_NA,
 	RAS_EEPROM_ERR_RECOVERABLE,
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index 4362b8a0f3c4..70bbf1334c4f 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -453,3 +453,54 @@ int ras_fw_eeprom_hw_fini(struct ras_core_context *ras_core)
 
 	return 0;
 }
+
+int ras_fw_eeprom_check_storage_status(struct ras_core_context *ras_core)
+{
+	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
+	int bad_page_count;
+
+	bad_page_count = ras_umc_get_badpage_count(ras_core);
+
+	if ((control->record_threshold_count < bad_page_count) &&
+	    (control->record_threshold_config != 0)) {
+		RAS_DEV_ERR(ras_core->dev, "RAS records:%d exceed threshold:%d",
+				bad_page_count, control->record_threshold_count);
+		if ((control->record_threshold_config == WARN_NONSTOP_OVER_THRESHOLD) ||
+			(control->record_threshold_config == NONSTOP_OVER_THRESHOLD)) {
+			RAS_DEV_WARN(ras_core->dev,
+			"Please consult AMD Service Action Guide (SAG) for appropriate service procedures\n");
+		} else {
+			ras_core->is_rma = true;
+			RAS_DEV_ERR(ras_core->dev,
+			"User defined threshold is set, runtime service will be halt when threshold is reached\n");
+		}
+		return 0;
+	}
+
+	RAS_DEV_INFO(ras_core->dev,
+			"Found existing EEPROM table with %d records\n",
+			bad_page_count);
+	/* Warn if we are at 90% of the threshold or above
+	 */
+	if (10 * bad_page_count >= 9 * control->record_threshold_count)
+		RAS_DEV_WARN(ras_core->dev,
+			"RAS records:%u exceeds 90%% of threshold:%d\n",
+			bad_page_count,
+			control->record_threshold_count);
+
+	return 0;
+}
+
+enum ras_gpu_health_status
+	ras_fw_eeprom_check_gpu_status(struct ras_core_context *ras_core)
+{
+	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
+
+	if (!control->record_threshold_config)
+		return RAS_GPU_HEALTH_NONE;
+
+	if (ras_core->is_rma)
+		return RAS_GPU_RETIRED__ECC_REACH_THRESHOLD;
+
+	return RAS_GPU_HEALTH_USABLE;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index cb92e6a63cf5..75d8b95c6923 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -79,5 +79,8 @@ int ras_fw_eeprom_update_record(struct ras_core_context *ras_core,
 				struct ras_bank_ecc *ras_ecc);
 int ras_fw_eeprom_hw_init(struct ras_core_context *ras_core);
 int ras_fw_eeprom_hw_fini(struct ras_core_context *ras_core);
+int ras_fw_eeprom_check_storage_status(struct ras_core_context *ras_core);
+enum ras_gpu_health_status
+	ras_fw_eeprom_check_gpu_status(struct ras_core_context *ras_core);
 
 #endif
-- 
2.34.1

