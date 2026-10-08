Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3122CA600B
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 06:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F8810E74C;
	Thu,  8 Oct 2026 06:51:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fEXZA98X";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010057.outbound.protection.outlook.com
 [52.101.193.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F32E210E74C
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 06:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4aHBxAAla56eTueQRXUDQCFDFMU0Usiqo52x1ggR6rBR3xEeq4Bppt47Tj6IAU40DkmTxDPjTyZzjeM2kX33MU2V5x8fq/Py744oQJRA31XwCoCSXm9eJ1xTLHKoIz8ChRntBZxjUAVtkvwiDBwpj5wnSyJy+/EKSh0Y9WQQHxtzwq4lLFqeBGnWNjQD53SHUYP6K93ElYRFpzl1jdfHMDaqPrMccE//kBgjJBpGpU37kWjoDtSI6oIvPUJ/d/usSUQ9wJ2FoiJ7opvA0PKg+eNi49VttSzqq2UfCqq64lJFOTPGWaY5VfQHH2Afdvewsq31QTEoTchbVhSw0Y7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tF9giHgBvmzLhTMWuA+Zng5LvNJFdYMXJoThE7Km6jY=;
 b=DzsSUS3FS4bGtNdd1ZLHXz1RRrtzEgKPe3qrVA4FnZbusA1UZRhKsShAcMr9QG9wqNpmQbTanURkeNZLNSXGqET8zocNZvlqpFofo+iOX/T1Tsa1pPVmg293GJ57y30j1VE/ZZNl4rP5OcNlgeWMcWO/t0TPs0l/tFSSOBtP1+7vB9mEHr0V3wDVxv10oRNFlcxyMgL9ACSwmGmY89+uar0WTKyd2idWLYxZI/KfPVVrdgPmHlBOsFQshpwISnJhRN+escJ1FHpBJh15xj/6hkL8hwGU+FXQMZ2aKw2ss/DuGwyXlbgEpq2gkFGOcEWQdzSHTDOjNOG7CGvMIcnJIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tF9giHgBvmzLhTMWuA+Zng5LvNJFdYMXJoThE7Km6jY=;
 b=fEXZA98XeJjicP4m9y5nwVtvKrgnZqloyevsY4eZ7dos+erChGlMRTmkAVBmW/fXReEj+zTilMalyxIKfst/kUS26no7kK6VrES+CZ4j36tMICY5Hl10L342b/SJ9JDUgJ5+9OCq9PKZMChQE2SmPhMyb2+lPHhrQRfdHSXsLrs=
Received: from SJ0PR03CA0041.namprd03.prod.outlook.com (2603:10b6:a03:33e::16)
 by SA5PPFB29794CA1.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8dd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 06:51:44 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::81) by SJ0PR03CA0041.outlook.office365.com
 (2603:10b6:a03:33e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu, 8
 Oct 2026 06:51:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 06:51:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 01:51:41 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 01:51:40 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: wake the GPU for INFO queries that access the
 hardware
Date: Thu, 8 Oct 2026 14:50:32 +0800
Message-ID: <20261008065140.3607658-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|SA5PPFB29794CA1:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f8ec53d-eb07-45b9-4742-08df25089d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|56012099006|11063799006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: QOAcbq/SNE+vPbUO4l+hXFPLfQsYhWm3BTyoQ3polQsemG+145KCxS+G2XmEXvKZWxCuBB2vjM8rzs4Bz8zn5OIfw83WleUABny2Tk8rrDgt4YxBOVPhbOSzTIb7AmiakxLe2k9y2LP0fajnLm0dXq3iQ9oRKO/erFSrRkrktMJxK3n2hlvt7wW5ADBuSOLUXoiue9yTk+ZrUrZ/Dk00HCiGwAsqNVZwICPCnvUmeKz2nU2Ms3Y0e5kaVYhjhCAZo2THT8PeH7dL4nw4uhl0Dkde6raUwksUSCpMyYato4jGAzdnf/gNIHyInS7+HUO9ptlSWAiefLiehu4+Y/ISKNIhL7s6AX+RtokhNXWo85pa+WTDCYXFB9xZcifakXvwTKyL2ZmfTII4jpqdpCbIhAb/eTPoQyqTIP47ZWlviOiYbavTEVGH7wslO8+gqE2r7JROFnCNpAz6kvCXLpm/Wav8mHjLEGD/WfPdEe03iB6oOyemBsvU8v0ZknvIxNj/pML9BDaLEA4fBcATpbWOo6sJmDvgtCiVmRlLZ2b58h3qNA8dAuMjuyFJV+HxJasfryauFUoaz++2pYP0A0tEI+rU0AVLXOXN3NXsVlEX1pG8fNn3wCwcb8oW6Cq9rzc03QWUy4oanczgKDggIOrc3euisSIjBwlvvLhNrnhPce7IBdo4lfKBsZxj9k6jsadJ4W3RkUtEtmXZIzg3+a5Hmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: doIMPiYdQsy/tsA/kdgWpvziUS7Fg4A9eEyug432zGcCRnOHuRNzyHDqsAIfcE0HHckoqxa2EjD/Aoz+ip7HSsCZo0ne3RhR8F//eaEAJqnvi1Z/xnVuR5hEplcW0EHWOzqYGPKOuHlVPTToLhI4M3hFCn39kk+nK5CVZpIFgoQ+jUp3b76i2Jadf3Mhnz6TXzkVNo0I748F9HtOAcSJqykbBjdGf0MeMSLPAlVcVoqdqeq0FcxN6g1wk/SqY+/ExO7Mla6YevHLgBkjK9CgXCJaJdgR6Db4/b7HoN7Uxj6K39tu3jmdb2Irw2zDFU89Oy9Z0zzBxprT37FS7xqjKJdx/5rv2U/I8GuSRWcTRUPN0S6xstHAh8ZPGGnOXzMlNdzN33qZg29QdKLCodItkYA/y38dKs/um8YpwJC68sFoMfh5BmPiPwvkAsNvG8Y8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 06:51:43.3787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8ec53d-eb07-45b9-4742-08df25089d15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB29794CA1
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

Since amdgpu_drm_ioctl() was removed, amdgpu_info_ioctl() no longer
holds a runtime PM reference. When the GPU is runtime suspended, the
queries that touch the hardware run against a powered down device:

  - AMDGPU_INFO_READ_MMR_REG reads all ones,
  - AMDGPU_INFO_TIMESTAMP returns ~0ull,
  - AMDGPU_INFO_DEV_INFO reports 0 for the engine and memory clock
    limits because the SMU is down,
  - AMDGPU_INFO_SENSOR fails with -ENOENT.

On Navi31 with an idle GPU in BAMACO, GRBM_STATUS reads 0xffffffff
instead of 0x0000302c, the timestamp is 0xffffffffffffffff, and the
min/max sclk is reported as 0/0 kHz instead of 500000/1880000 kHz.

Resume the GPU for these queries, the same way the CS ioctl does.

Fixes: a66aee8f3057 ("drm/amdgpu: get rid of amdgpu_drm_ioctl")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 28 ++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f34150d20a2f..1589b6a6575f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -780,9 +780,16 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 		return copy_to_user(out, &count, min(size, 4u)) ? -EFAULT : 0;
 	}
-	case AMDGPU_INFO_TIMESTAMP:
+	case AMDGPU_INFO_TIMESTAMP: {
+		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
+
+		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+		if (ret)
+			return ret;
+
 		ui64 = amdgpu_gfx_get_gpu_clock_counter(adev);
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
+	}
 	case AMDGPU_INFO_FW_VERSION: {
 		struct drm_amdgpu_info_firmware fw_info;
 
@@ -906,6 +913,12 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		if (info->read_mmr_reg.count > 128)
 			return -EINVAL;
 
+		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
+
+		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+		if (ret)
+			return ret;
+
 		regs = kmalloc_array(info->read_mmr_reg.count, sizeof(*regs),
 				     GFP_KERNEL);
 		if (!regs)
@@ -940,6 +953,13 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		uint64_t vm_size;
 		uint32_t pcie_gen_mask, pcie_width_mask;
 
+		/* The clock limits are only available while the SMU is up. */
+		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
+
+		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+		if (ret)
+			return ret;
+
 		dev_info = kzalloc_obj(*dev_info);
 		if (!dev_info)
 			return -ENOMEM;
@@ -1167,6 +1187,12 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		}
 	}
 	case AMDGPU_INFO_SENSOR: {
+		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
+
+		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+		if (ret)
+			return ret;
+
 		if (!adev->pm.dpm_enabled)
 			return -ENOENT;
 
-- 
2.50.1

