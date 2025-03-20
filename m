Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8E6C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 05:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5883F10E385;
	Thu, 20 Mar 2025 05:12:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0J4u+5TU";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB71310E385
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 05:12:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSjiZLeqKgGEuv0qYWYk/NEKTDQjl43buPTD6bWj8yZ1iEGNunbttOjxdOsyL870qBoTaDFwylBcEaoJeRwYSR9+OeEuRosmV03zCrJakVC2/tsFHUTOaKk20pgyHXEkBpyKW4OYJ9Ch8C2nXzJfNnfkse25nR4GT21671qlpDO7BstLkXUBRpqwcdz53TR5zYRdFbH6ezWy5IRzIaeJVa971LdM9mWLgAnSQUsORJMJ8et1XIj2lO0bWwDofhzT4GvXYpn0yL2A9tl2QzHgD9qWUNvSA/srxw/Ia7qopJ1lcgDfjl3ma9ye7QLNR6TmFc9Gcw18K6bIH1H28hIzBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMNEws0fcGosZTStSCahszdEC7Hr0OLndHOV90nmwfs=;
 b=QzD7K3SnfV7hqM7q60eD6MX7YjkMsgm0EFkV/DrXD/DGbpga8VRRhly6kTDA1iv3wxnJSsh7nJsa5yytwCflNRpLiQCFcalRxE4zVf1koPjgvz7P+5l3KhMQVWF3uSrCZCUjiBsd9dwy1KwMIY9BzD0PeOTsQ2BDLj8n1DK/3JE9x/4E524CoGFmj7FAZI1XvocFHIO4WR86liKCAQHMVhBtbvRMCGOqPMtei0mPWOe5PYTecnDflDJLymGMu2/Zma+2xVe7rbNDWvfwGuNYhZe3/lGM6PNpH3xrcbvhckSJZIy6WEYo3Ml5daNHuFLEYtu0al1fXGDCTWol01LJPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMNEws0fcGosZTStSCahszdEC7Hr0OLndHOV90nmwfs=;
 b=0J4u+5TUAax5ZcbzXlfisl7ET88XEQAoLyRPk7lBtBHuJzwGKRHZViv0ImOldTh+08hTWRc90rDIYtV/k7k4xGksQXXJKKECtfuluhNtpZXoI9M6mgRelV+H9Gy12J24KI8G3XLw59T9c2eydmHxZw/avXbrS9uV9jUo79ZgVic=
Received: from MW4PR04CA0288.namprd04.prod.outlook.com (2603:10b6:303:89::23)
 by LV8PR12MB9690.namprd12.prod.outlook.com (2603:10b6:408:296::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 05:12:31 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::a2) by MW4PR04CA0288.outlook.office365.com
 (2603:10b6:303:89::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 05:12:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 05:12:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 00:11:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 00:09:57 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 20 Mar 2025 00:09:51 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, "Jesse
 Zhang" <jesse.zhang@amd.com>
Subject: [PATCH v9 2/3] drm/amdgpu: Optimize VM invalidation engine allocation
 and synchronize GPU TLB flush
Date: Thu, 20 Mar 2025 13:09:42 +0800
Message-ID: <20250320050943.4161194-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250320050943.4161194-1-jesse.zhang@amd.com>
References: <20250320050943.4161194-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|LV8PR12MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: a9355e2f-b7ec-4482-7b7c-08dd676dd094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0b//e6WSmsjNq5cdJUqaFKeEEESV9+Xza41cTdyh5vflSjQCz1yTCQ0yl359?=
 =?us-ascii?Q?YnV7lAbOfrzyBrWuS5u7gJLCG8l7YUMiE3XpB5qsT9ZX9A9OohYgSy2QRaAZ?=
 =?us-ascii?Q?j2LBSyWjV382wwt+v/Y8PY6eLzNZIZNGe0fprdinY5srVaNKftxlzLlvIkhX?=
 =?us-ascii?Q?5vq3NDYCEzhE6mnpMEWHk/ywoxbSXg1LguhH0b08kBreyuAo3f/yWho/AyMV?=
 =?us-ascii?Q?LP5hvH0JxB/698jUvL99wnrcMV5dcKQmrpdKO5mDGWNllwHBWPevXyJEVc0e?=
 =?us-ascii?Q?gYMmT7dPbE8LXw5gDysglOvM3/AnSxuJsikFmyZApQZMLAbBMvEjqp08Qeit?=
 =?us-ascii?Q?gqlStFVM8zjFRBe+6iKX8fMECf0FC657u9vzzCoit33+V+Btj2sBbdLnUn2S?=
 =?us-ascii?Q?OI0A2FPHPUg3L8UuO9/FqO0zcTk5Kc692hpiZ9aczGYPnz+8RT5VRVLHfO9J?=
 =?us-ascii?Q?4xboQ3ri2ct2hnjZ8gn7LWxOFqXhoHYXvgaW8tMUeu38N6KFXbwQMo/WjONM?=
 =?us-ascii?Q?fGmA/wOLwf/hxGIi7AUJ3YvDAtmfadEbnZ+UuUnaAOGZw7mFUUteER/o9U6l?=
 =?us-ascii?Q?6Rag1ow2jxiXYEV2h6rLBshtr6wNKSJfOuFyQoBBS5I6z94IRRLxL+IpUUv7?=
 =?us-ascii?Q?Oc9EP0ZMHCp/G+TgelGl3qYDjRGcthnelb4almz6sV60YtV9+0pgPQ0/r77o?=
 =?us-ascii?Q?pNVCZkCWqUNWDOppiYdf61qJuycaMORdegh+7ysf7ZH25Zt+D/mlRMfUea24?=
 =?us-ascii?Q?bJVQVmzpbBrKDMe9UHeT3e9pSZw4h6GKuYoSEWcxyQF/CtpkFdrBBmZCXggd?=
 =?us-ascii?Q?GUiBnSzFTqgxBAvT3IimZAN0YrnkeM/VMKjizoZeMmnJNzx7Aq7dBPuyQOnZ?=
 =?us-ascii?Q?MkLneKqZ0HBEetQYQfFHtk79x9bUK0mG37pIg2puIPwcfHTavx4/qnmfwKMT?=
 =?us-ascii?Q?XZFx2l9L9SbrPYULmat0B7APCs4W6ANAxs3akJkXlX3S+N/iRmhRZsWxFxYJ?=
 =?us-ascii?Q?iDkLQx/LLrF/cCJB83LAiCIsBbYQQUAK7bwUP4YqOV7gI+l89HdYkTBgPwMx?=
 =?us-ascii?Q?SR/XhhJnDOkQ+5iTh+ASE8xdmnAc5xnZ5cJgL3z1NHPaI2rAnY/hUdGRcri+?=
 =?us-ascii?Q?OsvNAX1eCfsE56Zzb2i+ndOWHixFel36yDiIlcOIWxG/MzXJ9drX5z6N1OCn?=
 =?us-ascii?Q?NaGu6qtDdg+rYD3OPyBplNN3mVDkJB0/HgsS1vSW6Ec6kkmB3FmPC2bS/R7G?=
 =?us-ascii?Q?9OfUyeZhxVkQxqWtTtL+IIyvdr4wcMxGmTV/EHulraVsDoCoGWUkJGTk5e1O?=
 =?us-ascii?Q?ND7b/9tPHauPMcX6K1Has89gN4mwEy8vIE5yALVNpS+K7wzhd3UCfRQQh8Wo?=
 =?us-ascii?Q?fCyUCbN4uCy5knYXRxlJwEv1PNKEOnEIkXcAfH3mZIStW20jGUizIqLzoZei?=
 =?us-ascii?Q?3HehZb421Z7giOneK6raCR2c+7ULEeDgOO4Zb0DEJgB8EinpCjf1YgBKVbNo?=
 =?us-ascii?Q?ItqgbDzlORUhrpU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 05:12:30.4029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9355e2f-b7ec-4482-7b7c-08dd676dd094
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9690
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

- Modify the VM invalidation engine allocation logic to handle SDMA page rings.
  SDMA page rings now share the VM invalidation engine with SDMA gfx rings instead of
  allocating a separate engine. This change ensures efficient resource management and
  avoids the issue of insufficient VM invalidation engines.

- Add synchronization for GPU TLB flush operations in gmc_v9_0.c.
  Use spin_lock and spin_unlock to ensure thread safety and prevent race conditions
  during TLB flush operations. This improves the stability and reliability of the driver,
  especially in multi-threaded environments.

 v2: replace the sdma ring check with a function `amdgpu_sdma_is_page_queue`
 to check if a ring is an SDMA page queue.(Lijo)

 v3: Add GC version check, only enabled on GC9.4.3/9.4.4/9.5.0
 v4: Fix code style and add more detailed description (Christian)
 v5: Remove dependency on vm_inv_eng loop order, explicitly lookup shared inv_eng(Christian/Lijo)
 v6: Added search shared ring function amdgpu_sdma_get_shared_ring (Lijo)

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 20 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 33 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 +++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 4eefa17fa39b..464625282872 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -573,6 +573,7 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 	unsigned vm_inv_engs[AMDGPU_MAX_VMHUBS] = {0};
 	unsigned i;
 	unsigned vmhub, inv_eng;
+	struct amdgpu_ring *shared_ring;
 
 	/* init the vm inv eng for all vmhubs */
 	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS) {
@@ -595,6 +596,10 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 		    ring == &adev->cper.ring_buf)
 			continue;
 
+		/* Skip if the ring is a shared ring */
+		if (amdgpu_sdma_is_shared_inv_eng(adev, ring))
+			continue;
+
 		inv_eng = ffs(vm_inv_engs[vmhub]);
 		if (!inv_eng) {
 			dev_err(adev->dev, "no VM inv eng for ring %s\n",
@@ -607,6 +612,21 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 
 		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
 			 ring->name, ring->vm_inv_eng, ring->vm_hub);
+		/* SDMA has a special packet which allows it to use the same
+		 * invalidation engine for all the rings in one instance.
+		 * Therefore, we do not allocate a separate VM invalidation engine
+		 * for SDMA page rings. Instead, they share the VM invalidation
+		 * engine with the SDMA gfx ring. This change ensures efficient
+		 * resource management and avoids the issue of insufficient VM
+		 * invalidation engines.
+		 */
+		shared_ring = amdgpu_sdma_get_shared_ring(adev, ring);
+		if (shared_ring) {
+			shared_ring->vm_inv_eng = ring->vm_inv_eng;
+			dev_info(adev->dev, "ring %s shares VM invalidation engine %u with ring %s on hub %u\n",
+					ring->name, ring->vm_inv_eng, shared_ring->name, ring->vm_hub);
+			continue;
+		}
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 39669f8788a7..45dae38f802b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -504,6 +504,37 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 	}
 }
 
+struct amdgpu_ring *amdgpu_sdma_get_shared_ring(struct amdgpu_device *adev, struct amdgpu_ring *ring)
+{
+	if (adev->sdma.has_page_queue && ring == &adev->sdma.instance[ring->me].ring)
+		return &adev->sdma.instance[ring->me].page;
+	else
+		return NULL;
+}
+
+/**
+* amdgpu_sdma_is_shared_inv_eng - Check if a ring is an SDMA ring that shares a VM invalidation engine
+* @adev: Pointer to the AMDGPU device structure
+* @ring: Pointer to the ring structure to check
+*
+* This function checks if the given ring is an SDMA ring that shares a VM invalidation engine.
+* It returns true if the ring is such an SDMA ring, false otherwise.
+*/
+bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring *ring)
+{
+	int i = ring->me;
+
+	if (!adev->sdma.has_page_queue || i >= adev->sdma.num_instances)
+		return false;
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
+		return (ring == &adev->sdma.instance[i].page);
+	else
+		return false;
+}
+
 /**
  * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
  * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
@@ -545,7 +576,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
 {
 	struct sdma_on_reset_funcs *funcs;
 	int ret = 0;
-	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];;
+	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
 	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
 	struct amdgpu_ring *page_ring = &sdma_instance->page;
 	bool gfx_sched_stopped = false, page_sched_stopped = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 965169320065..77288bfb4e76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -194,4 +194,7 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_sdma_sched_mask_init(struct amdgpu_device *adev);
 int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev);
 void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev);
+bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring *ring);
+struct amdgpu_ring *amdgpu_sdma_get_shared_ring(struct amdgpu_device *adev,
+	struct amdgpu_ring *ring);
 #endif
-- 
2.25.1

