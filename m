Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A4BC77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 08:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F0C910E688;
	Thu, 27 Apr 2023 08:03:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A62B110E688
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 08:03:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLeacqdwzM2hf1REpZ6lE4bQUhI3Vum+pdYmuiaHp8HX7yQPmgUoPV6vxgnzjD0TYo1rLs+0X0fAKypM4TOEv6pYcuoHlu+TMDqH8tocYjpB6b4AlpqFAY2hpPQEsC8Jy22t2ntvCgrn9rDNq35xDdf5JjQVTatGdmKGNFGXawC5CxNfwtp6g3hL3qC0x1APDS7KO27ntRyfDKBE9iGbMMvrG3vyW49wll6LL78lxhbut9p61QlgqxU41SDLnEDZWr+L1rhCVRCUV1ieGg3gPpp/bwAgX78cKBhE8XYkuKn1FWDrzQqCqwGySpOOWMFW2YEcluKNNuYPEmm09SM0fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzF8KjIXeT6IK3F1zkkk98Ac4ejL0/JSttmMgcQEFVY=;
 b=CXCDjZKrTi2cvHYJG1m4vMCwidw+p+426MOxN1caKVJ3Yx/WUE4bnrzqc/ymqxh4LdjeoASdx3BPNA9pUhMlfvcRx1HyuxpWATBsF4jYjoGOYVGFiqUohCCnJF+Hmjutd6TWBGxpFuxP4Ix6GQj8hz3jHw61BWa8Lq0l16IQi4xCRSiVaycvrdHA7JXTovmb5yuLyMdUbCBucHFBZU3fPS0Z8YNUE4nYlgPVOnjpbDTMyKWHNc1IVRYOJQkGcHkzr2qNYzd451OSB/4lIzHK94Yf+vPW0k+AIGKb7K9Uv0mGvW0mylBaOndWCAycLGElbCNsw+WVcp4NbbLAeFfsSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzF8KjIXeT6IK3F1zkkk98Ac4ejL0/JSttmMgcQEFVY=;
 b=llFN8VTheK7QN77WeogCpggHeH23swxoDkeLYUiK8ll+H7qLcLyXmCcoJW3kuJFKDHAqYYy27w43hCi3komTPtjTaqTMsSZXPuqBIpIeV2+hPudO61VPOK7zp01vT8J5O/1/3LjI9iUadyZ07oAXvfWxSdbLsFUgJw8xDaOzhag=
Received: from DM6PR07CA0055.namprd07.prod.outlook.com (2603:10b6:5:74::32) by
 CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.21; Thu, 27 Apr 2023 08:03:45 +0000
Received: from DS1PEPF0000E637.namprd02.prod.outlook.com
 (2603:10b6:5:74:cafe::d9) by DM6PR07CA0055.outlook.office365.com
 (2603:10b6:5:74::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 08:03:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E637.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Thu, 27 Apr 2023 08:03:44 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 03:03:42 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: don't output mes error message when gfx hang
 during gpu reset
Date: Thu, 27 Apr 2023 16:02:18 +0800
Message-ID: <20230427080219.374815-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230427080219.374815-1-YiPeng.Chai@amd.com>
References: <20230427080219.374815-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E637:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb99a9d-71a4-402b-4014-08db46f5ec67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DtamLed8iD16TBVJHr8rhXDP6shtCE0xrO1LCtA/vNsKhPrd4CCBg6BGc2Sz4OeMPOSuMtR/NGwahc1obDgGTk0HIP39k/1YojrYCb9jl4LSZk6sO6SaCYm4T/felxPFAUYL/krN1i3qyoWA+vW5KVA1Ux5Q3ZJ/p9uWcBHN3gJR2uqwoN/3Tg/Td6gde9k9FqdJeiGvRqOfFofhduI2TEWkd2qckNZQNdox2QpO1/c0NDpkg85jjpDiehT7i04ZE20KYh0VAbFK++oHjkmf0LEWTeuWWW9igVZTuHGyxOkny2U7yQCu1/DEibruPVVf3LqifQBhMAWcfcdNXsb2ab4m2BmeSRdK7prpgpIHFDLLVMwLx9SiYjIInxHYJMWq+ql8Ekag9pNPDPLAVsDto2S6FMNtCNDmKyB3W4iiCbKz7BOTUyVdwP8Q17RXuKWLVSD+JvOdEM2weLQKEZ9JF8aLPV8jxyW7cPSFOTyY0u6fzlKUrDb3RyHAwRZAtYAcMU8ITjrhHJ84wwOYagt0AGPUydzuXDOlvSS2DhSWpb0gkIF1qjjYLVN5Vx00Bzn+T7tCC41/0KjLlxt2aBjwuj4nAlqALojo2vpdAXKdthKLUo80uHuWaZwqszEft/lUwspeofin7BkwaTpIq/hEfgPOTKNHohV8k4pm20bWMcRK6g9bVt+lozjA4MX38UGVCXOR7TPccmEI2GK3LHXf8nNP9cmfSJlQbUWpyg+euTc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(4326008)(70206006)(5660300002)(316002)(15650500001)(41300700001)(6916009)(70586007)(8936002)(2906002)(8676002)(7696005)(1076003)(86362001)(478600001)(356005)(81166007)(40460700003)(82740400003)(54906003)(2616005)(6666004)(82310400005)(36860700001)(36756003)(83380400001)(16526019)(336012)(426003)(47076005)(186003)(26005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 08:03:44.8303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb99a9d-71a4-402b-4014-08db46f5ec67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E637.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236
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
Cc: Tao.Zhou1@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com,
 yipechai@amd.com, Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to clear the invalid mes error message when gfx
ras poison consumption causes gpu reset on gfx v11_0_3.

[Why]:
  Gfx ras poison consumption will cause gfx hang, and gfx hang
  will cause mes to fail to run, and gfx can not be recovered
  until gpu reset complete. So the mes error message before the
  gpu reset completes is invalid. Since the gpu reset has already
  started, these mes error messages are easily misinterpreted.

[How]:
  Since mes depends on gfx, when mes fails to submit a packet
  during gpu reset, it will first check the gfx status to decide
  whether to output an error message. This check is only used
  during gpu reset.

MES error message during gpu reset:
[  389.803015] amdgpu 0000:63:00.0: amdgpu: GPU reset begin!
[  389.913909] [drm:mes_v11_0_submit_pkt_and_poll_completion.constprop.0 [amdgpu]] *ERROR* MES failed to response msg=3
[  389.914104] amdgpu: failed to remove hardware queue from MES, doorbell=0x1000
[  389.914117] amdgpu: MES might be in unrecoverable state, issue a GPU reset
[  389.914128] amdgpu: Failed to evict queue 0
[  389.914136] amdgpu: Failed to evict process queues
[  389.914145] amdgpu: Failed to suspend process 0x8001
[  390.922077] amdgpu 0000:63:00.0: amdgpu: IP block:gfx_v11_0 is hung!
[  390.923519] [drm] kiq ring mec 3 pipe 1 q 0
[  390.924573] amdkcl: cancel_work function is not supported
[  390.931057] amdgpu 0000:63:00.0: amdgpu: recover vram bo from shadow start
[  390.931060] amdgpu 0000:63:00.0: amdgpu: recover vram bo from shadow done
[  390.931067] amdgpu 0000:63:00.0: amdgpu: GPU reset(1) succeeded!

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                 |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c          | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c              |  3 +++
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c   | 13 ++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_process.c            |  7 +++++--
 6 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 35a0474ccdb0..3ca5716b0e06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1434,6 +1434,8 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
 int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
 			       enum amd_powergating_state state);
 
+bool amdgpu_device_check_gfx_status_in_reset(struct amdgpu_device *adev);
+
 static inline bool amdgpu_device_has_timeouts_enabled(struct amdgpu_device *adev)
 {
 	return amdgpu_gpu_recovery != 0 &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 051b9e231cf4..a5086be4d7dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6059,3 +6059,13 @@ bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev)
 		return true;
 	}
 }
+
+bool amdgpu_device_check_gfx_status_in_reset(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	if (!amdgpu_in_reset(adev))
+		return false;
+
+	return ras->reset_by_gfx_poison ? true : false;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index f0f00466b59f..403fb3f464f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -818,7 +818,7 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 	queue_input.trail_fence_data = seq;
 
 	r = adev->mes.funcs->unmap_legacy_queue(&adev->mes, &queue_input);
-	if (r)
+	if (r && (r != -EREMOTEIO))
 		DRM_ERROR("failed to unmap legacy queue\n");
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 67f7557d545d..071973a6b0c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -129,6 +129,9 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
 		      timeout);
 	if (r < 1) {
+		if (amdgpu_device_check_gfx_status_in_reset(adev))
+			return -EREMOTEIO;
+
 		DRM_ERROR("MES failed to response msg=%d\n",
 			  x_pkt->header.opcode);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 7a95698d83f7..5106af4bb60d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -257,9 +257,11 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	amdgpu_mes_unlock(&adev->mes);
 
 	if (r) {
-		pr_err("failed to remove hardware queue from MES, doorbell=0x%x\n",
-			q->properties.doorbell_off);
-		pr_err("MES might be in unrecoverable state, issue a GPU reset\n");
+		if (r != -EREMOTEIO) {
+			pr_err("failed to remove hardware queue from MES, doorbell=0x%x\n",
+				q->properties.doorbell_off);
+			pr_err("MES might be in unrecoverable state, issue a GPU reset\n");
+		}
 		kfd_hws_hang(dqm);
 	}
 
@@ -996,8 +998,9 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 		if (dqm->dev->shared_resources.enable_mes) {
 			retval = remove_queue_mes(dqm, q, qpd);
 			if (retval) {
-				pr_err("Failed to evict queue %d\n",
-					q->properties.queue_id);
+				if (retval != -EREMOTEIO)
+					pr_err("Failed to evict queue %d\n",
+						q->properties.queue_id);
 				goto out;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 95cc63d9f578..6cedfba5b1f4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1821,7 +1821,8 @@ int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger)
 		 * them been add back since they actually not be saved right now.
 		 */
 		if (r && r != -EIO) {
-			pr_err("Failed to evict process queues\n");
+			if (r != -EREMOTEIO)
+				pr_err("Failed to evict process queues\n");
 			goto fail;
 		}
 		n_evicted++;
@@ -1984,13 +1985,15 @@ void kfd_suspend_all_processes(void)
 	struct kfd_process *p;
 	unsigned int temp;
 	int idx = srcu_read_lock(&kfd_processes_srcu);
+	int ret = 0;
 
 	WARN(debug_evictions, "Evicting all processes");
 	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
 		cancel_delayed_work_sync(&p->eviction_work);
 		cancel_delayed_work_sync(&p->restore_work);
 
-		if (kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SUSPEND))
+		ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SUSPEND);
+		if (ret && (ret != -EREMOTEIO))
 			pr_err("Failed to suspend process 0x%x\n", p->pasid);
 		dma_fence_signal(p->ef);
 		dma_fence_put(p->ef);
-- 
2.34.1

