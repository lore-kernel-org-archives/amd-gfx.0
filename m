Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF32CDB466
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 07:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B130D10F154;
	Thu, 25 Jun 2026 07:27:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XVEMKaot";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011007.outbound.protection.outlook.com
 [40.93.194.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DB6F10F154
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 07:27:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuHKbsSh3+K1AHFOkBNgxsUb4TEZFoV5XWa/YgfmjREikXkrYYsNYTubESLyXnpGnVuxP0f49FYS/4UA3eDI12xljozJ0hGOXl8Cg/YGumeCLWT6kqkhxAHa4q4ofxlgBBUoYF1aw+PseAsXmeu8FtGf5RwceqZw0aydaI+/siYSpM0FE8N6TlT03Orbcr+K4NOGU05Cq3EkeczK+Ckc5FxPMd/oBTDnWvv9Jo6CT+vhyTuqdihncG+Sr4YBeG640pSrheAC+5BNLjlOUf0TOgFjr8UkAtCrscFlmLZKxUv5sMG4zJw7rgDHs7td7xXYMRbInSggpb3FeMBiE5B1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW60D3foiKeTrLHndD3XfWhcXQDIY2hZ62CtMOcTC78=;
 b=SBI7QL+D0XvThUUeDFjnZ9NwP6AwmVQ8OIWThAgmnLKZnkSsK7cMqygiMhw+KKBAJ63gDCdDzZrgXrz7wSrXpbk9wKIGsAwgCS/xUlAhM1K9XbmODr39zdUY+Mw4EvevZ0uIkLzwOd71pv6uQniSEpx2F8P8e25lLWiNh7ApCBSbM9JeIEHRzOMXMutWgi3vIz47N6jKnh2B2pz089qgo5HrUpgi81dNpe9IMrxKS95KS2f9XGIyOUW0P+3ZETSjjV/5SYIrqwPO2uJpRGV0fw6iBGRfiQWpMwiEHqiWQQJIzq0gW/+xhMQsaVvLM4qsqAeJWLDX0WYFo+lXZ95cKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bW60D3foiKeTrLHndD3XfWhcXQDIY2hZ62CtMOcTC78=;
 b=XVEMKaotm2XdVrp+u9Nsy5XSSoDf/nuO0TbwDNKw6ZntoVMHtobSnHKu1aknInkDBekYwB0qdH6FImXWH0F3b32ZdC5y/fevLbWFGTkzDfl5SzfWMhz3KfRHsfGmC649Sb3ert8lXtnl8ynLVL/XpQ7wXvPUKF9gfJWb8qPQuh4=
Received: from PH0P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::21)
 by IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 07:27:27 +0000
Received: from MW1PEPF00016159.namprd21.prod.outlook.com
 (2603:10b6:510:d3:cafe::5c) by PH0P220CA0022.outlook.office365.com
 (2603:10b6:510:d3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.22 via Frontend Transport; Thu,
 25 Jun 2026 07:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00016159.mail.protection.outlook.com (10.167.249.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.0 via Frontend Transport; Thu, 25 Jun 2026 07:27:26 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 02:27:25 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 25 Jun 2026 02:27:24 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Shaoyun Liu <shaoyun.liu@amd.com>, Amber Lin <Amber.Lin@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/2] Revert "drm/amdgpu: Fix mes remove_hw_queue lock"
Date: Thu, 25 Jun 2026 15:27:07 +0800
Message-ID: <20260625072723.1919513-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016159:EE_|IA1PR12MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cfe5a8f-f5a1-4a2a-7ba2-08ded28b3519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: d4PISkX7l/06QCWgCVEDjm+dtf+RCeJv+/Vdw/dvIF7+724c2Yd8fhK8INYBP/YDCWT2u2iUkKynZ9rk++DFm8crl3ZFGEUugEvLjJGX5wvKw61sAJP7M6paRX2wHpEKzOX3eznbBrzViSyaup7tvYpLBwYNi/RPILBxXyHGB+V+RlhWmyPcJbjR95MPmEUnBZiFTXxZMk/J61h+uqRZ94qsVzGRAOtMW90TNp8fCyjNY1zQOfcBNiU4d7HO/FfxmAsiKyQkQ1BTPXbxwyg3SDhspgyei7I+4ixAy6iy0Z4lRwJ1Rt6Rr8ggeO0p1pAgRo0rQd9cXsTsvsKPoD9b3SVrb1/uzDTDq2G9r2PXOFQx/EJHkDzwhOS6n/yeZLb0rx/Q6qoGacIbgq2BEjUX5UfUXXEaMWJiVde0+WoB+MAzhQjKK2IqrkuAe0uV1c2zME3toM/EturXtDxJe0GpI8ZKqOfWA+pLySHRWRiNUP5SSA45Gu5/l//140XyXshXC8nmfFTI5t+UiTfJ4ivzuFDz1IP8kANTLWveHlkoglB+PgzEWCBoopzKjHC2GFGQwm0iICkn0KDi+6ppN4vQ1UoJfIfWThVnFrkK7tgy+c61M4YxEE1esajdpGYTXSE9375CP76bV0n4+eiK+4x8QLNvzjAT/cpMv1VRR8FWfD4A74bvpxnPEg6u1YqAnoLMDTzmnSyeLC2xZN8uBc9sBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P9RE4HIdNCknWpAaDGzkVSHhISM+8DW0H9gso9E3p0hC+lBhSdsfP+I/lJi0tv1VOduX2kVLuR+PBdWOVQlB1KKQt9oKwpRFVNPGsRkN7m4kwtgsxnDasepQI05Ng9aGsi+yAC69NGWLBx6p0uKLJNTXo5jtZXA7ZtwbBDTr72L8Llwdg//6JcxUpJv7xQFv5T6Z4+MB9Bm5N1u1uXRZn1DumX4qEYKoZzuwcUhsuRn73lV3IR5HrPw/rFqHSd9yx63UOtSdgtv88V7Cvh8VnotXtuX0SnbkvB55DUdAkajFFsyHvtp6HP8kc/RE+zlGS9qosTcvDXf7ykLOWsqFx8j2Oirxm22ouSLEZXJuslnfeYPHDiKHgiLSlsxzabe+a0h0+PVW1L7N+dAm+2nn/BW7lE8xrOLuX9ZLwS7Nd7FPHmEz4VmiX6nytXPJLKFN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 07:27:26.4999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfe5a8f-f5a1-4a2a-7ba2-08ded28b3519
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016159.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8190
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

This reverts commit 524b4c43a848d2b92a8006e9fdafe2e2e9757efb.

It introduced a regression issue on gfx11.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  5 ----
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 23 +++++++++++++++----
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a5b835d0c166..a3e76bd85401 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2387,14 +2387,9 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 		 * preempted successfuly. Remove it before resume all so it
 		 * doesn't get mapped back
 		 */
-		if (!down_read_trylock(&adev->reset_domain->sem)) {
-			r = -EIO;
-			goto out;
-		}
 		amdgpu_mes_lock(&adev->mes);
 		r = adev->mes.funcs->remove_hw_queue(&adev->mes, queue_input);
 		amdgpu_mes_unlock(&adev->mes);
-		up_read(&adev->reset_domain->sem);
 	}
 
 out:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 9f28974f25b4..2360eb243515 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -71,11 +71,11 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 				struct queue *q, const uint32_t *restore_sdma_id);
 
 static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bool is_sdma);
+static int recover_bad_queue_mes(struct device_queue_manager *dqm, struct queue *q);
 static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *dqm,
 						   u32 doorbell_offset);
 static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
 			       struct qcm_process_device *qpd);
-static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q);
 
 static inline
 enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type)
@@ -307,12 +307,11 @@ static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
 	amdgpu_mes_unlock(&adev->mes);
 	up_read(&adev->reset_domain->sem);
 
-	/* If is_for_reset set, it is a mes internal cleanup */
 	if (!r || is_for_reset)
 		return r;
 
-	/* remove_hw_queue failure indicates a queue hang. reset the queue */
-	r = reset_queues_mes(dqm, q);
+	/* remove_hw_queue failed. try to recover */
+	r = recover_bad_queue_mes(dqm, q);
 	if (r && amdgpu_gpu_recovery) {
 		dev_err(adev->dev, "failed to remove queue from MES, doorbell=0x%x\n",
 			q->properties.doorbell_off);
@@ -486,6 +485,20 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
 	return r;
 }
 
+static int recover_bad_queue_mes(struct device_queue_manager *dqm, struct queue *q)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
+	int r = 0;
+
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return -EIO;
+
+	r = reset_queues_mes(dqm, q);
+
+	up_read(&adev->reset_domain->sem);
+	return r;
+}
+
 static void increment_queue_count(struct device_queue_manager *dqm,
 				  struct qcm_process_device *qpd,
 				  struct queue *q)
@@ -3229,7 +3242,7 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbel
 
 		list_for_each_entry(q, &qpd->queues_list, list) {
 			if (q->doorbell_id == doorbell_id && q->properties.is_active) {
-				reset_queues_mes(dqm, q);
+				recover_bad_queue_mes(dqm, q);
 				q->properties.is_evicted = true;
 				q->properties.is_active = false;
 				decrement_queue_count(dqm, qpd, q);
-- 
2.49.0

