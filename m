Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8032DC54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 03:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05B0B10EB1A;
	Mon, 18 Mar 2024 03:38:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hlv25NbS";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCDCC10EB1A
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 03:38:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVSYbKWwXKnJdzIHJ8MK+7mbKRnhb/GXfqMoh7MMYmQMBd/+1329kg2EI4im7Ggrituq/uTHPelYAHcDuJ3xTUVaBQjkrmsdA87qhLB6VGhUGvcB4TEMmkEJveDUnoyGkRaDrjKdlRvM0Sg/LbJGu4AYioY7bihd9kdl+axUHqbumz+n9Jj9tTdkrw6Xi98boWa5uDKRiFfOBVZKD+HDmRG74MK0YBociqSOEHWQy2rkrwtyWzTukvONT96wkVkuQ31AP5797Yog5APHhgyHNiS+ezSAQ3GxSlVGiLmdJetloDE9RqL1qpfc9V5Kct1FsU6IBMIpGb5iV2sUXENEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GL0ud4py87XpM8qdLJFe9aYAxS212E2h0QR0hOjQ4q0=;
 b=Ejp7y1VyEvpf4frCvYp6s6tkR61A/i45SliIopZeRwReq4uUhsM8RQQU7/UHMqcHVBo5GlV5ksQWE4DkCynANbv7IadDNPI2GT6Crjz1YMiBmgaMfc2zw4Bxnqftfm6OybyyQan15lwQNpY4yYC1xjm7XfdkmTdZOsdNVSjY5pts0CKoG3vhnrzzNQXSHjzHopg+NbQOePO728Ezh2VOEAAiZ3Fzm7fcyDQrDvlUvjWyUJl7Md7ynhzH9+qDHlD8FMDT7F15Db8bfT+IhGZGTs2CIYc0o0K/5FmuEI6NAqbjAy4z7TVKhfFhkTUlqg6AlaqsAB1vSyzWvEOsqGpKjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GL0ud4py87XpM8qdLJFe9aYAxS212E2h0QR0hOjQ4q0=;
 b=Hlv25NbSJ4oxRo6dq5DJ7KrxdSV9GlUZvKidRiJAr2FY5dCKH6hG5Kt5pS8eHLPVx8SzDmZwfAjbVSFE8YYxNHIMV7Pp3f530rG2wb1GkvZGIgJZ1OMfG7/jcCcLVonfibzJMwtWXbEFPIhjOFu9PR1BUI5bsCHLMt30K5TBWNo=
Received: from MW4PR04CA0345.namprd04.prod.outlook.com (2603:10b6:303:8a::20)
 by IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 03:38:26 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::29) by MW4PR04CA0345.outlook.office365.com
 (2603:10b6:303:8a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.37 via Frontend
 Transport; Mon, 18 Mar 2024 03:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 03:38:25 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 17 Mar
 2024 22:38:20 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Sashank.Saye@amd.com>, <Jeffrey.Chan@amd.com>,
 Zhigang Luo <Zhigang.Luo@amd.com>
Subject: [PATCH] drm/amdgpu: trigger flr_work if reading pf2vf data failed
Date: Sun, 17 Mar 2024 23:37:33 -0400
Message-ID: <20240318033733.5824-1-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c5e3ad6-8193-44bc-6410-08dc46fcde62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VIyGlODaq+KsRvDYdLelBSHUxd14zkEkrySNCOyWH2auR+SDp+zXC0C+BZeKdw1LXlwaz5gLqZ9O1zC8zmTwK+rLYRLbwHT6YKAY7d7n3Fo8DQM3sDPFje1Ie1fzIyP66sU3A9V0Xoph9vW3C3wwOtvFoi+UJNE6O0J3WY8kRGn4b0/eovsLc/zl3exCQ7kzOrYpo7xc45W02v0FRPD4VXERFmog1yNAVqmF/DMvvWrjLoyl5hfV8l8Cs+fxv8JF3nqxVnyAUZ4OX1VtwDiTg7uE9n1A8o2zUfOQIYycxiOHCvCAaZsYf+OU4kvfLRRAYVMzZ04C0ic3VyLuPD2PeMNC5QDSSl7YVaOnu+lb+k1j2S9zL+Ymbtq1SGjDNcLB1W64aCR061P3ZRF/kBYGK00NO62wbBLnS//4qoOXnBlvsLV5Ke+XGpQb+PVbppf2GO/4ELdojlwB9nqhvPVcCwCrsXcjACz6+IegO8bUVJ6F12bAVLAL2uXpk8YFhNgxnv1ZDT2caY3AOWSIcIoiprDbyHw4I3G/jjbCw/6Q9csXjuNM4XUZ4BRGb897AHCQOZXW07O1XVd6odM7ViJ9kXiw+UJS6Y5vVxpVCi5Ym6i4HgXmxIt9TXi9I8+PI1jBQQMXHQxQLnKiYv5BVEWGjWM33bcVHEUthu08s9TfCicXzOAoipqaHdZ+D85JelIWWkGIqUOSVP2wsQ+zmBbgwo/W1nDWB+S5xFoyIzQlZnQsGsqwHaPwngnPzNrY8Ecz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 03:38:25.5054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5e3ad6-8193-44bc-6410-08dc46fcde62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019
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

if reading pf2vf data failed 30 times continuously, it means something is
wrong. Need to trigger flr_work to recover the issue.

also use dev_err to print the error message to get which device has
issue and add warning message if waiting IDH_FLR_NOTIFICATION_CMPL
timeout.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
Change-Id: Ia7ce934d0c3068ad3934715c14bbffdfcbafc4c2
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 29 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  3 +++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  2 ++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  2 ++
 5 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b37113b79483..70261eb9b0bb 100644
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
@@ -5712,11 +5716,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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
index 7a4eae36778a..aed60aaf1a55 100644
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
+		if ((adev->virt.vf2pf_update_retry_cnt >= AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT) &&
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
index 3f59b7b5523f..a858bc98cad4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -52,6 +52,8 @@
 /* tonga/fiji use this offset */
 #define mmBIF_IOV_FUNC_IDENTIFIER 0x1503
 
+#define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 30
+
 enum amdgpu_sriov_vf_mode {
 	SRIOV_VF_MODE_BARE_METAL = 0,
 	SRIOV_VF_MODE_ONE_VF,
@@ -257,6 +259,7 @@ struct amdgpu_virt {
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
index a1bad772d932..89992c1c9a62 100644
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

