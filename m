Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933EDC54E5D
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 16:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0736C10FC16;
	Thu, 14 Mar 2024 16:54:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OfIOrldL";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD6AC10FC16
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 16:54:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFr3tc8nxhDRypl+nvvoKbDggm/o3g6uUVEmDzY6vX9K3irbee+FT0vnASaB83SNazZV8GVaGoh7hjH7qDuAOZqvCwm/R91UwG3/Tu9E8QXIdqyGpcJ2M3j6Tyun4tfvPpmNcHb1LgYLW35tgfBBdKDBhrIGYj/8OjeuxSSh1YlMhIdE9onivFD/kW7+/gwmlPLeNJzi+Ty5n8ErVrGKfzmotMgJnYRimToFD1BlZpJ9WaCBSfWE3McOPxswpQFUoI8Gbq8Lb14c+i5BVp2GhR3wabzhIkFsGqiMqxIeXFHKR2V2nvXipb6xqJJlWriYmSvVBM8sJQb6wag4hLJfjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qgml6hLGi4L8eQRprR6WbA2X795IOAsGSdHoBFacbs=;
 b=Y9qL3aEyt84KifYCIHxB4zMwK21jkzLp/P35LP8/fkqnjhuElV7jezLY9LCvfjl969k4N05xGhV8SiAbV6uzcllJTB7gERvAiTAgc5h9yckRqFDuqNOniddvVdlB6Asp9mav6DodvNIhPN7iz+9d7DqMtV4kr6HDikaVD6Ml8We9GIuLZn6WououDHPNZPfsdJ5Zycbls5U6N7XeeSn7cHGKfIepZJ0csayL7JJZQ6wJeiKCoFnfWch1pefBc98rdJbC2iQCN/d/X1e9eKZZWN9/wu9b/pylEs/Wi5uTdCgaTtVBVJ1GmdAwrRecdzWgqBwSB02D01DELfONjicJuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qgml6hLGi4L8eQRprR6WbA2X795IOAsGSdHoBFacbs=;
 b=OfIOrldL/8kSgvncTWbaZf8oE1Ed0DvEj9mDocbImm613RbO6n821hPFC/1E7tkXOMi5qKzyUHxZ5SEQh7b4A7QbTpLdClfNXGkcyccZ9AklSuPlENwah+Ai+Rg/OxexBEMjyESfXBw5OKNgpTapmJJDy+PqmLtIZZigH3AnpOg=
Received: from CH0PR03CA0303.namprd03.prod.outlook.com (2603:10b6:610:118::16)
 by SA3PR12MB9177.namprd12.prod.outlook.com (2603:10b6:806:39d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 14 Mar
 2024 16:54:37 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::dc) by CH0PR03CA0303.outlook.office365.com
 (2603:10b6:610:118::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Thu, 14 Mar 2024 16:54:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 16:54:36 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Mar
 2024 11:54:35 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Sashank.Saye@amd.com>, <Jeffrey.Chan@amd.com>,
 Zhigang Luo <Zhigang.Luo@amd.com>
Subject: [PATCH] drm/amdgpu: trigger flr_work if reading pf2vf data failed
Date: Thu, 14 Mar 2024 12:54:09 -0400
Message-ID: <20240314165409.17657-1-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|SA3PR12MB9177:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da6d6e4-8431-44fb-07bd-08dc44476e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zDaKEVkyKuDt3C+WPz7d11Ag03hr8tAoIH3UezqJ35MFWqTWDdXI9c3lm8eXWCvA4THy08xN3OwyaGnZOWDmqvxFfaPEu76uS2K2P/a7Ady4SOYBnRdM4hizpuUlr32JuLoaUpOeFkJq0I7ngIG5SuzSPymtqeyQbCO0drYOkSlvyVmynIZX2RM8Z+MeZzL6HHczf/ay3a4yMvJYIitXGOqjXypZLVx1h0FfxqimACng09GWnB72PbYOH/zfhKA4vp9c/OzvrDvooDXDFm/CKAKynSTusxugJScB3tayj2YQ/AcwNygaqF1PnmxeUpn8kJO71mcJHjTjMDuXu+3sHGTlxaSIPBdt5vU2qyXoEUQYktxNdYG4AMJBrlspeHWr4i5nhX2uKl2zxpchyfd6GSlTC8l+W/lKTloxKlG5rRKqEX/7LUB73xUtEUOqm1X6DwtHEyCawNXBusUqhBV/iRuvDzmVxmjWL7TMiiiflur3N1uh4VOH5BFHeeVEq7ubut5bYeAvg9snXApcNAsqZ2ELSJCf4jE9Ug/s4KesxKZH2axHjT9V6IFyEXUKqfClz6Q+E9d+U2aRYd7hupnoMcZqRNqBU3i+13ibPFil+dWjzlkH38+KvIhIpV0csxvE4m6F9ve+gfS24P/VrYeiqK1jZytThLb1FishXWnw4/VnJ2ZFx071p2FiOu4te3ZYkJzR/pteZM42uR76A5K1HJpbN3bztmMk/sxDkiJ8kIMgAlFQ49gZPTcTkssyAA17
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 16:54:36.8294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da6d6e4-8431-44fb-07bd-08dc44476e9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9177
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

if reading pf2vf data failed 5 times continuously, it means something is
wrong. Need to trigger flr_work to recover the issue.

also use dev_err to print the error message to get which device has
issue and add warning message if waiting IDH_FLR_NOTIFICATION_CMPL
timeout.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
Change-Id: Ia7ce934d0c3068ad3934715c14bbffdfcbafc4c2
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 29 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  2 ++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  2 ++
 5 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1e9454e6e4cb..9bb04a56d020 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -143,6 +143,8 @@ const char *amdgpu_asic_name[] = {
 	"LAST",
 };
 
+static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev);
+
 /**
  * DOC: pcie_replay_count
  *
@@ -4972,6 +4974,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 retry:
 	amdgpu_amdkfd_pre_reset(adev);
 
+	amdgpu_device_stop_pending_resets(adev);
+
 	if (from_hypervisor)
 		r = amdgpu_virt_request_full_gpu(adev, true);
 	else
@@ -5689,11 +5693,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			tmp_adev->asic_reset_res = r;
 		}
 
-		/*
-		 * Drop all pending non scheduler resets. Scheduler resets
-		 * were already dropped during drm_sched_stop
-		 */
-		amdgpu_device_stop_pending_resets(tmp_adev);
+		if (!amdgpu_sriov_vf(tmp_adev))
+			/*
+			* Drop all pending non scheduler resets. Scheduler resets
+			* were already dropped during drm_sched_stop
+			*/
+			amdgpu_device_stop_pending_resets(tmp_adev);
 	}
 
 	/* Actual ASIC resets if needed.*/
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 7a4eae36778a..4e8364a46d4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -32,6 +32,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_reset.h"
 #include "vi.h"
 #include "soc15.h"
 #include "nv.h"
@@ -424,7 +425,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 		return -EINVAL;
 
 	if (pf2vf_info->size > 1024) {
-		DRM_ERROR("invalid pf2vf message size\n");
+		dev_err(adev->dev, "invalid pf2vf message size: 0x%x\n", pf2vf_info->size);
 		return -EINVAL;
 	}
 
@@ -435,7 +436,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
 			adev->virt.fw_reserve.checksum_key, checksum);
 		if (checksum != checkval) {
-			DRM_ERROR("invalid pf2vf message\n");
+			dev_err(adev->dev,
+				"invalid pf2vf message: header checksum=0x%x calculated checksum=0x%x\n",
+				checksum, checkval);
 			return -EINVAL;
 		}
 
@@ -449,7 +452,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
 			0, checksum);
 		if (checksum != checkval) {
-			DRM_ERROR("invalid pf2vf message\n");
+			dev_err(adev->dev,
+				"invalid pf2vf message: header checksum=0x%x calculated checksum=0x%x\n",
+				checksum, checkval);
 			return -EINVAL;
 		}
 
@@ -485,7 +490,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
 		break;
 	default:
-		DRM_ERROR("invalid pf2vf version\n");
+		dev_err(adev->dev, "invalid pf2vf version: 0x%x\n", pf2vf_info->version);
 		return -EINVAL;
 	}
 
@@ -584,8 +589,21 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 	int ret;
 
 	ret = amdgpu_virt_read_pf2vf_data(adev);
-	if (ret)
+	if (ret) {
+		adev->virt.vf2pf_update_retry_cnt++;
+		if ((adev->virt.vf2pf_update_retry_cnt >= 5) &&
+		    amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev)) {
+			if (amdgpu_reset_domain_schedule(adev->reset_domain,
+							  &adev->virt.flr_work))
+				return;
+			else
+				dev_err(adev->dev, "Failed to queue work! at %s", __func__);
+		}
+
 		goto out;
+	}
+
+	adev->virt.vf2pf_update_retry_cnt = 0;
 	amdgpu_virt_write_vf2pf_data(adev);
 
 out:
@@ -606,6 +624,7 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 	adev->virt.fw_reserve.p_pf2vf = NULL;
 	adev->virt.fw_reserve.p_vf2pf = NULL;
 	adev->virt.vf2pf_update_interval_ms = 0;
+	adev->virt.vf2pf_update_retry_cnt = 0;
 
 	if (adev->mman.fw_vram_usage_va && adev->mman.drv_vram_usage_va) {
 		DRM_WARN("Currently fw_vram and drv_vram should not have values at the same time!");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 3f59b7b5523f..eedf5d44bf00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -257,6 +257,7 @@ struct amdgpu_virt {
 	/* vf2pf message */
 	struct delayed_work vf2pf_work;
 	uint32_t vf2pf_update_interval_ms;
+	int vf2pf_update_retry_cnt;
 
 	/* multimedia bandwidth config */
 	bool     is_mm_bw_enabled;
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index a2bd2c3b1ef9..0c7275bca8f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -276,6 +276,8 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 		timeout -= 10;
 	} while (timeout > 1);
 
+	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
+
 flr_done:
 	atomic_set(&adev->reset_domain->in_gpu_reset, 0);
 	up_write(&adev->reset_domain->sem);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 77f5b55decf9..ee9aa2815d5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -309,6 +309,8 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 		timeout -= 10;
 	} while (timeout > 1);
 
+	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
+
 flr_done:
 	atomic_set(&adev->reset_domain->in_gpu_reset, 0);
 	up_write(&adev->reset_domain->sem);
-- 
2.25.1

