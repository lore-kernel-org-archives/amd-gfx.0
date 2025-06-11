Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235CFC677C4
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 03:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB99F10E2E0;
	Wed, 11 Jun 2025 03:35:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tLZ+nknF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15BB710E2E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 03:35:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R41dJ2Ubtdv5mVShJbH7ml2NRU7wspMPvCG+6Cz2J68KE8u6eSf0YgOBf0sm9GZ11BZD6+N7NAHoCtnV4ETR9Ttt0B63E+PHwaejoa33U5SVXs4tHmMLfu/68O//TnToHYXuIt0HT10hMJOvCCZpt2ol/+5uQZGvWhy9mjSnmp8CFxAr+HHML7tJC1Al+lUFLhcwbwK1ajsIHif/TLN8VBCAw0Tgpa3pNumw58CU6ZNgcP0M17+1+Op3H1trvD0jcLp7rORZXviCOudOqtvjlmeMEgC1nb9pHlgzBfmB4d/rE41U3T5tSuCXRk3XcGRvy2ZTzO1EpVQP4BTVI2IGYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRzLapUeu10hV58dou0jLP6B47nF2axD1zMo4+r73eY=;
 b=MD3/mAbbzZ+nSQgZxeB2wtcHM3kFr8pGhDMyqotweGpk7e3EAYyzaXf/DnJ0ZtTRgs8CFE7T/dXgHD20rKu8TF8zETWgxaMDxJRwyeAqPzcg11kT0GHPtRVWa8HI3ur0LBywXsv937iRK21PJprvEU5F6hzO/IhuOU/TaePCPYkKIeFau/5v/ptq2rYST9C83e3vBZ/G3MkywG2BWlkPfDCpwNIzUhvtgAhX6Zkgw62LtqCrm3g7LW5f61AUH0KZy3vSNRD4Aj6cqv6ZqPYwzpKfuDieUCxuvEc/TgbrKcJ2Skoplq8LY4LJpMy+5SiRe1amqjpgaxppHJUiy12ZuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRzLapUeu10hV58dou0jLP6B47nF2axD1zMo4+r73eY=;
 b=tLZ+nknFRwvH/6cWzz5InGJTdc2ZyK+Z17T/XvCAtnabrXteV9L99RGxMvu/qS0dbgumqu0oPlf4ShILTWpiLq51xkZ2kCHpF3BMavHCsjD0biliymngcET4LSuAxr7BegpXr0XEVrN390xBLrITFQmqlOWqGIeOW2gmSBkrjZs=
Received: from CH2PR07CA0027.namprd07.prod.outlook.com (2603:10b6:610:20::40)
 by DS0PR12MB8269.namprd12.prod.outlook.com (2603:10b6:8:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 03:35:11 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::fe) by CH2PR07CA0027.outlook.office365.com
 (2603:10b6:610:20::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Wed,
 11 Jun 2025 03:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 03:35:11 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Jun
 2025 22:35:03 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Add SDMA RAS poison consumption handling
Date: Wed, 11 Jun 2025 11:34:51 +0800
Message-ID: <20250611033453.48610-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611033453.48610-1-tao.zhou1@amd.com>
References: <20250611033453.48610-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DS0PR12MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc91fcd-5122-4961-37e2-08dda898f86f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SaLsC0oF/xvECde1hdUoyevNaVg9sQEM6ub3z1bjEn6W8JjkyDAb6LD1IDz+?=
 =?us-ascii?Q?ohhORUdwuqoi77N8webx4fnFXtTx/jUB3XmPaga60x1qHmM8G22R5VKKJAmA?=
 =?us-ascii?Q?e3o8BX658CKkwD/h3H1Hn8f4AsCzhHpEQ7y8t/rkUjofE31jP7T4Izz6Vn51?=
 =?us-ascii?Q?0ubJZxQE26iF4ZXHLVU8PcEQxyPpPQZZqzHeTRwzhllKW8xHPG8nVRyZur+Z?=
 =?us-ascii?Q?OABRXYX9u6MXF6N/J5qzraMnRg0b5pqBT7YxAqBsX/76VbzdV6hQLwZHRlUl?=
 =?us-ascii?Q?u1v1m49ETPIKK9/gkxklB1ugzCZ9Y2uS6PULIhRWOu5kOo2mL8NxAy0D9OeU?=
 =?us-ascii?Q?tPZfpT+fQcl9zFKkZh4WvYjelqV/eLcddcOzCOROu+OzYQInA/oqjKJvYdML?=
 =?us-ascii?Q?9Fe6YGvzjXkOXzpKFv+QIiqUwa4NvVqVxH/zhbu3hX62SWIDcUKW35+UvrTj?=
 =?us-ascii?Q?7S1es9N8HDMgwX1bWoFKFy+hq9/vKF/10VzCkrR1eUGDR9q9B9oaiqqQiKNi?=
 =?us-ascii?Q?u9mGR9Ka1JXhdZ1MqvuMvpgdQyI0o9ZD1fTOoJJzOaodxM/iphz3oTZEHcry?=
 =?us-ascii?Q?lwuqLBdsrGQoXFBJY9geDMDUzpJ5mIrN8qxbK43cfMlmI/Bpy9DafongBNnN?=
 =?us-ascii?Q?gJkNfWjrT6hu+nYxjJ20LrRGe+d85I8cW03Yd89OzmOE+GP73x29pl4iO8tX?=
 =?us-ascii?Q?PJdxCt+5Vil62oy8llUGKupvHJWqzrfS4g50PDYOcoNBWdeKfA52FRWb5syj?=
 =?us-ascii?Q?0sedaspQg1+jEYDUB3J8pSiDgV6mDSL8EjyjedSeByXJROJS/HmEPQaC14FI?=
 =?us-ascii?Q?A837DsFaAmeQnQcf1Q23CPNeUDjpysym6HRC2tFhfWW08v47xARfJ7/Bk2vA?=
 =?us-ascii?Q?Q1O1v8yIBCMdcvcZTLRs1Jtvc59PDUOsXe4ionb8CGVlTx3kQoiJE10uV5qN?=
 =?us-ascii?Q?r2upej0c7VG5P1qvn4/tjVA8P7dH0v0ujG6E3Bu8RfqmcfE4Q1IDpQroEVd/?=
 =?us-ascii?Q?+TLEmoOke0dxAhvls1xaKDE6qUirfLpLS3MpfFlO5tjxrZHUjdvPLwXXmNZ7?=
 =?us-ascii?Q?Pvg9YhQMJODjFfPKcB1xDBQ5HB6Wap3Rvgp/W9v2+SvJNTIJMGcodjVqa7nr?=
 =?us-ascii?Q?pmurrPvkFqwulyM+Qhk/rkcQEGJRdtJDIOKg82DpEzxoEvr4xlJVvJCn38ow?=
 =?us-ascii?Q?6hvVc6RMhPotWVb/poRDGMwlm6UmTyBVTrtjtIi/U/uHhSA6ATlfZ30v9t4m?=
 =?us-ascii?Q?EVwa1YC6H1Zv7ZO9s2MoufC9SiLbrFWHA+BNTZ4VSmUlbbFAirX3rarlYzoh?=
 =?us-ascii?Q?wmApByxivdKasXZPRNWM/DXuzwc7g+/cQ1bSa+RgxKFuKVYezraxhiUxvT5u?=
 =?us-ascii?Q?wXq8NtZ6KM4+mALJtBowJMDLPoJUXiv1fytdJMWcTxdDMPqlo77F7CyPmdPx?=
 =?us-ascii?Q?cL6+n2WQYkZkvIEevohgyPERtbkPHQ1/YhRSrXcht4cD4m78HVLuX8tkuMLX?=
 =?us-ascii?Q?2M0YcCXo1vcRMK35RA0Q8KSWyq4zzz76FDpW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 03:35:11.2202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc91fcd-5122-4961-37e2-08dda898f86f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8269
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

Perform queue reset for SDMA poison consumption.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  8 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 30 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  4 +++
 4 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 6c47f7d9adcd..085bff11319a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -741,6 +741,14 @@ void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev,
 	amdgpu_umc_pasid_poison_handler(adev, block, 0, NULL, NULL, reset);
 }
 
+int amdgpu_amdkfd_ras_poison_queue_reset(struct amdgpu_device *adev,
+	enum amdgpu_ras_block block, uint16_t client_id, uint16_t vmid,
+	uint16_t node_id)
+{
+	return amdgpu_ras_poison_queue_reset(adev, block, client_id, vmid,
+			node_id);
+}
+
 int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
 					uint32_t *payload)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 3fa951ede37c..f1680027399e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -404,6 +404,9 @@ void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev,
 void amdgpu_amdkfd_ras_pasid_poison_consumption_handler(struct amdgpu_device *adev,
 			enum amdgpu_ras_block block, uint16_t pasid,
 			pasid_notify pasid_fn, void *data, uint32_t reset);
+int amdgpu_amdkfd_ras_poison_queue_reset(struct amdgpu_device *adev,
+			enum amdgpu_ras_block block, uint16_t client_id,
+			uint16_t vmid, uint16_t node_id);
 
 bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev);
 bool amdgpu_amdkfd_bo_mapped_to_dev(void *drm_priv, struct kgd_mem *mem);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6565dc7ff9cd..7e63c2fc1a62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -5311,3 +5311,33 @@ bool amdgpu_ras_is_rma(struct amdgpu_device *adev)
 
 	return con->is_rma;
 }
+
+int amdgpu_ras_poison_queue_reset(struct amdgpu_device *adev,
+	enum amdgpu_ras_block block, uint16_t client_id, uint16_t vmid,
+	uint16_t node_id)
+{
+	struct amdgpu_ring *ring = NULL;
+	int sdma_inst, ret;
+
+	if (block == AMDGPU_RAS_BLOCK__SDMA &&
+	    adev->sdma.instance[0].funcs->sdma_irq_id_to_seq) {
+		sdma_inst = adev->sdma.instance[0].funcs->sdma_irq_id_to_seq(adev,
+					client_id, node_id);
+		if (sdma_inst < 0)
+			return sdma_inst;
+
+		ring = &(adev->sdma.instance[sdma_inst].ring);
+	}
+
+	if (ring && ring->funcs->reset) {
+		ret = amdgpu_ring_reset(ring, vmid);
+		if (ret)
+			dev_warn(adev->dev,
+				"queue reset failed in block%d (ret %d), fallback to gpu reset\n",
+				block, ret);
+	} else {
+		return -EINVAL;
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 927d6bff734a..debc07767b5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -984,4 +984,8 @@ void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id,
 				const char *fmt, ...);
 
 bool amdgpu_ras_is_rma(struct amdgpu_device *adev);
+
+int amdgpu_ras_poison_queue_reset(struct amdgpu_device *adev,
+	enum amdgpu_ras_block block, uint16_t client_id, uint16_t vmid,
+	uint16_t node_id);
 #endif
-- 
2.34.1

