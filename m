Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F913C54791
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 09:12:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D1E910F728;
	Wed, 13 Mar 2024 09:12:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FWm3QpsK";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E608910F726
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 09:12:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+vOAQUN51rPwgtWEdlf4DN8yU1PB4sZfokLRzwEtU2WK1ozAc91bhAZ6NMEx2UWO1GmhlOv4mKGnZMwx2sUifhpdAcy/q4vZHmk186dFn3DMZDqt651jW2l5r4Yn2GuPZyHA7D+aJYW8ZZndRLMcVmbrUxULDGP18Ska1JG0vtMjA1G3FzcJ5iJTjsVPk4OkBHiA+UYN5juS/luLnyMZe40FhnKzomwiGn88qP0aRhrStGFEF0axmDY+Y1k8GHZpkP1HEPVs3w9PkIPl36raVzQ2ocD+wqmCm2mMt4Ao0jIXjzKMU8upjuzfpZZ9muwF5DP7fFhMeV7zk4ekrPK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fYPxlddqW9fAi0DZmWhSklJsK4Fj1te5qGDvIrdyWU=;
 b=B14Ew0MoZj8dgAJ9OoDEr/wOgKVmDLkW6+WCkxT5Xp1Q3aXh1+vSPnsRqhQenEGCywxJkMquioGvxJ+OmTBDLeOW4+omNMf91WrhOA9h+lkgaqIZOK+1LndKsCedwv4VmHKvvhwWZveH45TG8PVZKaiMe32AYG9Qfw7UCKoEi1CjrDlL4+zFqRg4FxiA40W6SlMY453WgEZgI4FLfEV5V7MVGJWoM5yoVRGdtab51eMa4QPtTti7qbO457hIfLrs5Bz7M6SXeMJhw7CLLZke6DA0PglIXiuKvCe1tYDMWhBnO8TxwO5F42xsis51bACIxK9GkYQvRQtZeRD/2f6YYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fYPxlddqW9fAi0DZmWhSklJsK4Fj1te5qGDvIrdyWU=;
 b=FWm3QpsKwu79pFgmZdD+9+rMHDGkac6+jwdr1h75/iDp0bi8Daoj2+Lq+MRT6hlEqow4ObV4rB+IvOffllniWQ1wCtJJSTcrKICbZDcZFVLnT1kARiD43b9MUH3WovAeahA5MXv34ORFrZCWs2T8Ld/V6TKZ7iL50W5j7HrxYXI=
Received: from BL0PR01CA0035.prod.exchangelabs.com (2603:10b6:208:71::48) by
 PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Wed, 13 Mar
 2024 09:12:10 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:71:cafe::d4) by BL0PR01CA0035.outlook.office365.com
 (2603:10b6:208:71::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Wed, 13 Mar 2024 09:12:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 09:12:10 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 04:12:06 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: make reset method configurable for RAS poison
Date: Wed, 13 Mar 2024 17:11:55 +0800
Message-ID: <20240313091155.347161-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313091155.347161-1-tao.zhou1@amd.com>
References: <20240313091155.347161-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|PH8PR12MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 063d03c0-49ff-44fe-73bd-08dc433da9dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O/Ip+yetp7pEeRuwfnz1dAmG/RKIrESGAzKIPnOiKN/bknFC+K8tsaVdsSSrQZNElpuPx1/ucfsU1QKflWWaaQcpjf1riRO+YlpZgjEgwqg6zmVhXvYBrsz4mW84+kTS+WMZ2Ozieq+8ciYxJzN5/3iOniyGfNir+rb5CChx7f4e1gqM+LP7RMgG9qEh/YQmcItdU3H25FVewWZgF9o/6PVo61GjfvNBZD/62B5onpX44dX4Kvz80bHgFBQE86eXW5OGTU6dS5fJSxIvtQUveQPzc5QKjsUZjCsXh2Du1rW/YxShj5XsdbExT8twDauE8DFTOgmZQiS7txP/622d51XRbELw5R6A3rLzz6zwfu9D9Ib7r+ghk9KdEIxrG73JMykjiqwE0LBfnlVWSwawDGrKrtXelM83kafy1XxMf0wiDZ9GsnLbYdSuMuOdXvs0vJlOAqXX6UIauA3cut57dJWRh/K7NqDvCiuiouZZK1AcbYA5qrHItxBog3JnOoJDOoOLTrsomkNM9iT/eAV0mDcrrp+0AkNLopRciXaaR3Im7Ag9Zi3suKdmLtZy9HAeGLeY4Dv580jKc5AZTf1hoGG7+FjEqvcapnQPw3tqqb5LMX5DYEPrQLw109UrE0pBnJBjIjw7Z8cM/odnfTQOZ42qZ/lKIQuSNBDfVd+NQvD42CiOHZDeSA0mEMBfJeIUSJLhFFLJh7NycGHtoiyVS8fq9LFtBbR2vsKWidofU2h4Tdy+M40IQYeb1JHhZaHU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 09:12:10.1227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 063d03c0-49ff-44fe-73bd-08dc433da9dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6770
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

Each RAS block has different requirement for gpu reset in poison
consumption handling.
Add support for mmhub RAS poison consumption handling.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       | 14 ++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |  4 ++--
 .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c  | 20 ++++++++++++++-----
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 20 ++++++++++++++-----
 7 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 9687650b0fe3..262d20167039 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -760,7 +760,7 @@ bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev)
 }
 
 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev,
-	enum amdgpu_ras_block block, bool reset)
+	enum amdgpu_ras_block block, uint32_t reset)
 {
 	amdgpu_umc_poison_handler(adev, block, reset);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 03bf20e0e3da..ad50c7bbc326 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -400,7 +400,7 @@ void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device *adev);
 int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
 				struct tile_config *config);
 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev,
-			enum amdgpu_ras_block block, bool reset);
+			enum amdgpu_ras_block block, uint32_t reset);
 bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev);
 bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *mem);
 void amdgpu_amdkfd_block_mmu_notifications(void *p);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e32a186c2de1..58fe7bebdf1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2045,7 +2045,7 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 		}
 	}
 
-	amdgpu_umc_poison_handler(adev, obj->head.block, false);
+	amdgpu_umc_poison_handler(adev, obj->head.block, 0);
 
 	if (block_obj->hw_ops && block_obj->hw_ops->handle_poison_consumption)
 		poison_stat = block_obj->hw_ops->handle_poison_consumption(adev);
@@ -2698,7 +2698,7 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 		atomic_dec(&con->page_retirement_req_cnt);
 
 		amdgpu_umc_bad_page_polling_timeout(adev,
-				false, MAX_UMC_POISON_POLLING_TIME_ASYNC);
+				0, MAX_UMC_POISON_POLLING_TIME_ASYNC);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 20436f81856a..2c02585dcbff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -186,9 +186,7 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 	amdgpu_umc_handle_bad_pages(adev, ras_error_status);
 
 	if (err_data->ue_count && reset) {
-		/* use mode-2 reset for poison consumption */
-		if (!entry)
-			con->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		con->gpu_reset_flags |= reset;
 		amdgpu_ras_reset_gpu(adev);
 	}
 
@@ -196,7 +194,7 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 }
 
 int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
-			bool reset, uint32_t timeout_ms)
+			uint32_t reset, uint32_t timeout_ms)
 {
 	struct ras_err_data err_data;
 	struct ras_common_if head = {
@@ -238,8 +236,7 @@ int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
 	if (reset) {
 		struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
-		/* use mode-2 reset for poison consumption */
-		con->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		con->gpu_reset_flags |= reset;
 		amdgpu_ras_reset_gpu(adev);
 	}
 
@@ -247,7 +244,7 @@ int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
 }
 
 int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
-			enum amdgpu_ras_block block, bool reset)
+			enum amdgpu_ras_block block, uint32_t reset)
 {
 	int ret = AMDGPU_RAS_SUCCESS;
 
@@ -311,7 +308,8 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 		void *ras_error_status,
 		struct amdgpu_iv_entry *entry)
 {
-	return amdgpu_umc_do_page_retirement(adev, ras_error_status, entry, true);
+	return amdgpu_umc_do_page_retirement(adev, ras_error_status, entry,
+				AMDGPU_RAS_GPU_RESET_MODE1_RESET);
 }
 
 int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 26d2ae498daf..4365a20eeb49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -103,7 +103,7 @@ struct amdgpu_umc {
 int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
-			enum amdgpu_ras_block block, bool reset);
+			enum amdgpu_ras_block block, uint32_t reset);
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
 		struct amdgpu_irq_src *source,
 		struct amdgpu_iv_entry *entry);
@@ -123,5 +123,5 @@ int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
 			umc_func func, void *data);
 
 int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
-			bool reset, uint32_t timeout_ms);
+			uint32_t reset, uint32_t timeout_ms);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
index 650da18b0d87..94ab1f33fc4a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -134,6 +134,7 @@ static void event_interrupt_poison_consumption(struct kfd_node *dev,
 {
 	enum amdgpu_ras_block block = 0;
 	int old_poison, ret = -EINVAL;
+	uint32_t reset = 0;
 	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
 
 	if (!p)
@@ -153,6 +154,15 @@ static void event_interrupt_poison_consumption(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_UTCL2:
 		ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
 		block = AMDGPU_RAS_BLOCK__GFX;
+		if (ret)
+			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		break;
+	case SOC15_IH_CLIENTID_VMC:
+	case SOC15_IH_CLIENTID_VMC1:
+		ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
+		block = AMDGPU_RAS_BLOCK__MMHUB;
+		if (ret)
+			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 		break;
 	case SOC15_IH_CLIENTID_SDMA0:
 	case SOC15_IH_CLIENTID_SDMA1:
@@ -160,6 +170,7 @@ static void event_interrupt_poison_consumption(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_SDMA3:
 	case SOC15_IH_CLIENTID_SDMA4:
 		block = AMDGPU_RAS_BLOCK__SDMA;
+		reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
 		break;
 	default:
 		break;
@@ -170,17 +181,16 @@ static void event_interrupt_poison_consumption(struct kfd_node *dev,
 	/* resetting queue passes, do page retirement without gpu reset
 	 * resetting queue fails, fallback to gpu reset solution
 	 */
-	if (!ret) {
+	if (!ret)
 		dev_warn(dev->adev->dev,
 			"RAS poison consumption, unmap queue flow succeeded: client id %d\n",
 			client_id);
-		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, false);
-	} else {
+	else
 		dev_warn(dev->adev->dev,
 			"RAS poison consumption, fall back to gpu reset flow: client id %d\n",
 			client_id);
-		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, true);
-	}
+
+	amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, reset);
 }
 
 static bool event_interrupt_isr_v10(struct kfd_node *dev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 11641f4645e6..2a37ab7a7150 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -145,6 +145,7 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 {
 	enum amdgpu_ras_block block = 0;
 	int old_poison, ret = -EINVAL;
+	uint32_t reset = 0;
 	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
 
 	if (!p)
@@ -164,6 +165,15 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_UTCL2:
 		ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
 		block = AMDGPU_RAS_BLOCK__GFX;
+		if (ret)
+			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		break;
+	case SOC15_IH_CLIENTID_VMC:
+	case SOC15_IH_CLIENTID_VMC1:
+		ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
+		block = AMDGPU_RAS_BLOCK__MMHUB;
+		if (ret)
+			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 		break;
 	case SOC15_IH_CLIENTID_SDMA0:
 	case SOC15_IH_CLIENTID_SDMA1:
@@ -171,6 +181,7 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_SDMA3:
 	case SOC15_IH_CLIENTID_SDMA4:
 		block = AMDGPU_RAS_BLOCK__SDMA;
+		reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
 		break;
 	default:
 		break;
@@ -181,17 +192,16 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 	/* resetting queue passes, do page retirement without gpu reset
 	 * resetting queue fails, fallback to gpu reset solution
 	 */
-	if (!ret) {
+	if (!ret)
 		dev_warn(dev->adev->dev,
 			"RAS poison consumption, unmap queue flow succeeded: client id %d\n",
 			client_id);
-		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, false);
-	} else {
+	else
 		dev_warn(dev->adev->dev,
 			"RAS poison consumption, fall back to gpu reset flow: client id %d\n",
 			client_id);
-		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, true);
-	}
+
+	amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, reset);
 }
 
 static bool context_id_expected(struct kfd_dev *dev)
-- 
2.34.1

