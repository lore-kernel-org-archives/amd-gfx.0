Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C7FC61DC4
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 15:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C738010E42E;
	Thu, 27 Aug 2026 15:14:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SpkYF3dJ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26F4610E42E
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 15:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nk0H1glKx4wbN+joZjHp7msPXkndEgFfpeePS1MJ2iccDHAvOCxaGd8kwuQBlQaUI4S7eSJcK1sRqGxvIBjG2UfP1uOCIPOkU1JJANHDllXuO9E1XypJtUTwbVP8nY1pl4uRhbwM1g5vt5tU3lI4Dw+x77cSWdG0ibHT1ZQ8Ob0dHTYnlPHa6MP0PZSF5t3ffewcGMpiCphyHpYfALxP1w3JlMgmxeDMdPL9TQrE6Lx0asbXw68nHjPsSl04tc9p2pNPkVjSGNwURWKSzsMMEYQjIY/ECuNrdfzI0fSLJIHdUEgfe3OuOyox94tQFm3650pZS6rPvA8L9mXpUdwK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPyVMtCN/jjM8ebxQ4vkUjU4ZSp5NYZPLiNGaIykMB4=;
 b=VW39mpfFiuGH0LAfNwTq0WdZIYMB/xgwAU3vjthgq7zLNTrzQGy3trbVjI/ET1Gglvxax9d1sere4C4TPULr30xyrQkc7qMoBfr2SKqK5GL6MOeL5YCs111b58HC0dQ325/z5egx+2cwH/VfIi+uz2eRpg2dH6f+28burirW4nA/s3cbrvSWFwAAzwpVAUP77+np+JpblFogqSeWdzTN2VQRfv8DuvZUUcZZI/51nfjPl9aU9+y1oSIAXxa0LTo4dvQRpLpTooTCz8ArcEwBc0TWz6MG9tLGufkORpHkeHZjNapHjdbjGupGKeaNGmyeqMTJGl2pLiiw562PnO/BLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPyVMtCN/jjM8ebxQ4vkUjU4ZSp5NYZPLiNGaIykMB4=;
 b=SpkYF3dJEtmY+Oq4+a5+cY25IPL4K6YGWVH3Zn99JzMn5dgiLTOVsUUcx6v4nG3UAn9qthGKGwt8WX3md/SAkKvHxN3Ai0Ettvpwmmz8V+BoXMUO7HotIF4WyF2mAQgWun/H7ZW9ZMv1sdBOeNwXxRIjvlc4uIUiE4ceaqHZsZU=
Received: from MW4P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::35)
 by IA0PR12MB8896.namprd12.prod.outlook.com (2603:10b6:208:493::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Thu, 27 Aug
 2026 15:14:03 +0000
Received: from MWH0EPF000C618E.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::4a) by MW4P221CA0030.outlook.office365.com
 (2603:10b6:303:8b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 15:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618E.mail.protection.outlook.com (10.167.249.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 15:14:01 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 27 Aug 2026 10:13:59 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tishko.Araz@amd.com>, <mario.limonciello@amd.com>, Eric Huang
 <jinhuieric.huang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix oversubscription timer for sr-iov
Date: Thu, 27 Aug 2026 11:13:45 -0400
Message-ID: <20260827151345.83133-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618E:EE_|IA0PR12MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 64712873-aaee-4605-28d6-08df044dd39b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|56012099006|10067099003|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: IK1JDGHP/Tdx9UbiRTh73mKMEmZW1qERdUvmbnWXo2+30dMYusORfwT9GItatTa92KAYgkf6BQB31ngjA1zlEUN+QVSbTWIU9qllXXrz79rRZaH8S8DTdVBX3dqwtM/qDzTnKa2L605hpMmjWOLvBRrOtIsi9kUYDzo+dlQvi8pBZzc6QDBLUUwcFiLdbxjq6ixVj/TaU5a+BQmNJQhWBaImAlkwDtRsUXlHxiRW/g8Tue+dG1BLYsf82+W3KL1wiqfC5HZ/sOadKZAT6DGsrbHxpl/SyjVJbP/34yq+hjUREHpEK9KeyCq6RgW1Uftdp1DAAzaarJX10hagwWBVIUbeCnQYNSBlx+cB1w2as6vDYnLNKvu1l2CjkEG7UYbc7r86AgVih4bYhHKIrmLuRWndHUJswIZTKG2RCAI/Y2VZBer5bMPDV4Mr+945upHBoJhmV5Q5s9OkEfiAn6nyaqO+LJaavHh9fit9H1NOeGfRg9VjBNRPaHYOifIf5ygzJmuWpUcZ6+cWSVWh7cO0K0fFRwkE/DPWBhKVOqp7OJyhlFLoKFFKyApV9Bbv0/oBxGA9q3vUrscAntKHQaQ6j1D7z2RMv5zsVNgf7xGL29V67Z6GABemoAWDx93faAg+MOuw41fF4rPrQMWChpkvvMB3ufVY8jkVZMdLLC1gNovoyDLWJjV6jU1nTqOUEnuZSLDwEOotRwg7MOYfh8cukw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(56012099006)(10067099003)(5023799004)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZQ55F+NbngWJRuL2iGU2c1ik2qrx4zfc6Tnx35PKHleAbbnWvCn40oy3NiKZLVldET3LWfDrMZY1wwzvqdh64szj5A5zkt30G3rH8zqyGkUgpP379VFyHORInFzZzyfHC0aXuNf5gd20tAdRoysBUC7LucotRdWymyFuOWC7G7Dw0IWsrXvqtOUUL12aX8TKnzQIQtwDHz7+hsJCErDqcfsmoAIfeHhJdjo7E702owAoGltmzIRljrMERvAnq1/NkBSWnCyC/RETVw+nNc2OawO39VEVVO1fPfztZvkZAcMhXgwYHVbe3OUtT7HpFO9aF1dyx6vzOaeTw/RySGufCXBpPITq7Wx4F1Jt/g2IbUBPl6Hcz3hmnwUl2gZQWNlav8UEyQf82GvRJb8mzMicPQu/WbedT5FiEJxlNh376on9lEfsG/1NWstM2ieKk09J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 15:14:01.7716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64712873-aaee-4605-28d6-08df044dd39b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8896
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

The KFD/userq software oversubscription-notify timers added to
replace GFX11 MES firmware's oversubscription_timer call
amdgpu_mes_notify_unmap_queue(), which takes mes->mutex_hidden,
the same lock add/remove_hw_queue() use. Under SR-IOV this call
can block up to 9s (vs 2.1s bare metal), so MES round-trip latency
goes up (world-switch contention) it stalls re-mapping queues
and times out KFDQMTest.AllCpQueues.

Keep the firmware timer enabled for SR-IOV VFs and skip the
software timers there; the issue this works around is bare-metal
only.

fixes: "drm/amdkfd: workaround 100% gpu usage issue for gfx11"

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c               |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                |  9 +++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 11 +++++++++--
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 5cf1bb1c2085..e5f8a81c3a3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1208,6 +1208,9 @@ static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work)
  */
 void amdgpu_mes_userq_queue_mapped(struct amdgpu_device *adev)
 {
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	if (!(amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0) &&
 	      amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0)))
 		return;
@@ -1224,6 +1227,9 @@ void amdgpu_mes_userq_queue_mapped(struct amdgpu_device *adev)
  */
 void amdgpu_mes_userq_queue_unmapped(struct amdgpu_device *adev)
 {
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	if (!(amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0) &&
 	      amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0)))
 		return;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 33ff1afd7c4c..c81e4b8616d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1024,6 +1024,15 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
+	/*
+	 * Bare metal: disabled here, KFD arms a software replacement only
+	 * while oversubscribed (see kfd_device_queue_manager.c). SR-IOV
+	 * guests keep the firmware timer instead of the KFD-side one, since
+	 * the notify round-trip is much slower under SR-IOV and would
+	 * otherwise stall remapping queues.
+	 */
+	if (amdgpu_sriov_vf(adev))
+		mes_set_hw_res_pkt.oversubscription_timer = 50;
 	if (adev->mes.use_rs64mem)
 		mes_set_hw_res_pkt.use_rs64mem_for_proc_gang_ctx = 1;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b37aed34a72c..f37bfeeb4bf4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -282,8 +282,15 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 		return r;
 	}
 
-	/* GFX11: start notify timer only once when oversubscription begins */
-	if (KFD_GC_VERSION(dqm->dev) >= IP_VERSION(11, 0, 0) &&
+	/*
+	 * GFX11: start notify timer only once when oversubscription begins.
+	 * Skip under SR-IOV: MES round-trips are far slower there, and this
+	 * notify call shares mes->mutex_hidden with add/remove_hw_queue, so
+	 * a slow notify can stall remapping queues. SR-IOV guests keep MES's
+	 * own firmware oversubscription timer instead.
+	 */
+	if (!amdgpu_sriov_vf(adev) &&
+	    KFD_GC_VERSION(dqm->dev) >= IP_VERSION(11, 0, 0) &&
 	    KFD_GC_VERSION(dqm->dev) < IP_VERSION(12, 0, 0) &&
 	    dqm->active_cp_queue_count > get_cp_queues_num(dqm))
 		queue_delayed_work(system_wq, &dqm->notify_unmap_work,
-- 
2.43.0

