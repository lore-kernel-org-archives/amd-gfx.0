Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD91C3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 12:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22BFE10E391;
	Mon, 15 Jul 2024 12:36:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eppDFe6I";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E904A10E37C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 12:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkIy4h/CV5JngSWcfOL4FfSCr0j7JoznOEbQ6lRlHsy/ABisVO6bv+Qdz5FFL51qD0nDLRMptaHQqOOgbmsuSIOn5KgXsUn+rmeELo8OIiDMfTqJtiSFfYoGygtiJzyzpNOKR6HnaPPXyFnGamTiV9Ge0A1L7Wu6tMK+lOD6AMcsFVW96+Jd5OhROJDyxFIbwJKrESfmWALA36dlGLj59CjUdhmrvR7GA5oGKaxPKT04+E68Okq4HGcw252DRujNl7Xofyvvk/bi3XPGwVhpXHzFf6KKOTK4Rst5LA3Qh5THL22fdGBzyivpHvFpVIkGWuJyOl1U/f6W9BCcb01BJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfp311Ainsndz+SF26jIto2O0OBRNErc+E7pJH0ywyk=;
 b=NMCFvg5vCDculC+R4jOdnhprYbL/hqFDbqlPetpY5UCJxRdDvZQP+6WtJICR547nwpNKXQ7zJJCy46ArM6LaCy737ZndSwZg9U8O4kc5KL72T28Izs2sPVeZiYHC8uIIl8qTKkJEmuTglbvYplKVq/vmhAkFH+4EQF5rOwsj74CqeSIRmvZGeIjungW7W6cy1Z6HZk8p3YH5uvNzeKk1minb0ooR/76ueIoL9wJstRPFhYUoTSojSMYVjP/qljTBKEacGytw3dBidaOkJZ+MX8L8xba/Sd7iehJ6u3j4kCAQwoRedjhkKTiAhbYv0ToSf7GnSZRZeqj5+Td8GJ3esQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfp311Ainsndz+SF26jIto2O0OBRNErc+E7pJH0ywyk=;
 b=eppDFe6IoBDPsCzDBRM0hKtoYfo0GeA3w4NzpfkL9Zbd2zs91AsuweiZmmzijSkBof96pHGeQs3fWlp2Y+pAZ41Ek685nPaEzbGTbTVFHxYLEusYzE2wng3qDkbejpgdk9JemzPsZ//+zNBF/4IH6hawv4r681yjA9IjjtOvu0A=
Received: from BL1PR13CA0330.namprd13.prod.outlook.com (2603:10b6:208:2c1::35)
 by SA1PR12MB7101.namprd12.prod.outlook.com (2603:10b6:806:29d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Mon, 15 Jul
 2024 12:36:27 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::25) by BL1PR13CA0330.outlook.office365.com
 (2603:10b6:208:2c1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Mon, 15 Jul 2024 12:36:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 12:36:27 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 07:36:25 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 1/9] drm/amdkfd: kfd_bo_mapped_dev support partition
Date: Mon, 15 Jul 2024 08:34:54 -0400
Message-ID: <20240715123502.7013-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240715123502.7013-1-Philip.Yang@amd.com>
References: <20240715123502.7013-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SA1PR12MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa5f118-2811-4b1b-7995-08dca4cabee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mai/XsuZQjnmaCuVw1tKoUAvPQWy8bCcox7kbiX+sVsQJWtAHcbgDOOBoQYZ?=
 =?us-ascii?Q?B0i1nGOUWotXts7478iK9BWzQgQ/nBoziDwe+fHMB5ypxWfGDC65iRjszZEy?=
 =?us-ascii?Q?j4JsNsVtVYKRuKuf74SVDg2kilB9N+TX+r6D39yi9JLsknilIj005epswy6I?=
 =?us-ascii?Q?G4OImFrBW7iPcRuBkuqLuxdL1aIgVqhclCZK2QMgJUuQf7OC/GxRf6Ugi58O?=
 =?us-ascii?Q?g/okCHjNmupPcQgW1+bRor7IkOK7cPl+dJU632MQ3zRlKjf/M0rFo4NQCmjZ?=
 =?us-ascii?Q?vwIrEMsxEpc3RhQuMKcpYdVJBs6agxmHbCKCBqEmGy7VNUc7VtITdSzRGmDK?=
 =?us-ascii?Q?qyfq79eTvB9YleQreDC70WJxvfw0NIFHJV4mqIp13yxoPRN8ggIA2p3d/XSB?=
 =?us-ascii?Q?UF8IvyqBwiKXfRae9nSQyCe2MQZkGWGrp2937e1x8lq3iIWblshfEPsbyNEr?=
 =?us-ascii?Q?SOHRyQvoKB/DvK/HZWuOxZYHoZYL86uUqHdeGdjMlJktCzN2RgUxHjYyWW73?=
 =?us-ascii?Q?16Gi0WUfgAsFshNW3ltKTaSNZpAPZidmkTs6f5/FRYlsE6SDOVL1ScjndoYi?=
 =?us-ascii?Q?ELBjR9IaGE1iMgL9mERRseoo0sCMWqzV3zGRmWGnxAGL5XqVn83YVJ4G8EwL?=
 =?us-ascii?Q?Yv+FyQU4VhMIwa9Ra/BAgY68t0O/9LfILWQA9cHjqp5t1vr+caIJG7JjdGAf?=
 =?us-ascii?Q?sowFqz9T62x2voJhoQt29mGMIoQ982kaz9H5VGQ8q1PVTvdq8ljRp4uaUqoo?=
 =?us-ascii?Q?yG1NMxwl6JFblA/KXxXKARJ1VsHqrlUF/rx96QPRRAKPYeX+4T+Gslj4XfNe?=
 =?us-ascii?Q?1xlvoljUBFFk23SBdiHa518QLqXy4D7/yzUGxKOpie0K+XFvs7iljYQHSWS3?=
 =?us-ascii?Q?9RXRPdPVQ+3lnpCrBzaUuqiu6AOQzFrRpDAUedXO+jF94xn/oJtT0s+8XDtY?=
 =?us-ascii?Q?y4UnK1uzb54VF4cq80sHPurh14GEswPrSbIw9+gIJrbjs8A5B2f4I8Bmlyvv?=
 =?us-ascii?Q?2WEZwafVckXkpxmrF7oyudLyJSx2xKuO1GK4PrhPYQmOoRvjNeejOqf3d0Ya?=
 =?us-ascii?Q?iwNGUPnsAia5CpJZvK/kacJleKxiJ/fCh6n23fC6/l8dM7gpcHWVUpjTmmEk?=
 =?us-ascii?Q?UBTPQ5UbtCS4LEGrPRXxZI+usISQZr0DpIXtep+98y2JPp6UYqnD2FiT1nF2?=
 =?us-ascii?Q?eR8Yf0p4ZU7HKQlDfVqCL77ESX3BkGE9t8uN0Q4DyeWwRc9vrWakXu4I7hLV?=
 =?us-ascii?Q?l+vbtD4BUdZTRj4tFEU/DvU2rgILCoZLd2D2dxm648r5xqgYRXk5bgeWh2Jz?=
 =?us-ascii?Q?N+ZNbxtZ8g3+ZtNL3buh0deYyCWJCueaBvWwugb6qIrRigzE0WzgXU8POF7a?=
 =?us-ascii?Q?yy22d6Ea8NODnszlAZviTSFwhzix5msRQbKk8wfrOlxeoZqoaUERAu1xLosp?=
 =?us-ascii?Q?PFm4LtRBcntvLC1B3H5B/tUNs0t5An/a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 12:36:27.1249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa5f118-2811-4b1b-7995-08dca4cabee0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7101
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

Change amdgpu_amdkfd_bo_mapped_to_dev to use drm_priv as parameter
instead of adev, to support spatial partition. This is only used by CRIU
checkpoint restore now. No functional change.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 5 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index e7bb1ca35801..66b1c72c81e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -345,7 +345,7 @@ void amdgpu_amdkfd_ras_pasid_poison_consumption_handler(struct amdgpu_device *ad
 			pasid_notify pasid_fn, void *data, uint32_t reset);
 
 bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev);
-bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *mem);
+bool amdgpu_amdkfd_bo_mapped_to_dev(void *drm_priv, struct kgd_mem *mem);
 void amdgpu_amdkfd_block_mmu_notifications(void *p);
 int amdgpu_amdkfd_criu_resume(void *p);
 bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 11672bfe4fad..199e387d35f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -3200,12 +3200,13 @@ int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
 	return 0;
 }
 
-bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *mem)
+bool amdgpu_amdkfd_bo_mapped_to_dev(void *drm_priv, struct kgd_mem *mem)
 {
+	struct amdgpu_vm *vm = drm_priv_to_vm(drm_priv);
 	struct kfd_mem_attachment *entry;
 
 	list_for_each_entry(entry, &mem->attachments, list) {
-		if (entry->is_mapped && entry->adev == adev)
+		if (entry->is_mapped && entry->bo_va->base.vm == vm)
 			return true;
 	}
 	return false;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 32e5db509560..1d9b21628be7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1963,7 +1963,7 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 				bo_bucket->offset = amdgpu_bo_mmap_offset(dumper_bo);
 
 			for (i = 0; i < p->n_pdds; i++) {
-				if (amdgpu_amdkfd_bo_mapped_to_dev(p->pdds[i]->dev->adev, kgd_mem))
+				if (amdgpu_amdkfd_bo_mapped_to_dev(p->pdds[i]->drm_priv, kgd_mem))
 					bo_priv->mapped_gpuids[dev_idx++] = p->pdds[i]->user_gpu_id;
 			}
 
-- 
2.43.2

