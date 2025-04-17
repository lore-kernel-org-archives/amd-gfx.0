Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC8DC369C2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 13:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6E8A10E110;
	Thu, 17 Apr 2025 13:34:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hP0eO2O+";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A3C410E110
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 13:34:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVxYqrgTH4RwRbR/bdFYs1hiSgf8BBpH6NR1Y1jF7g71DNgsHo+7HScljgtA4jR/F6B0TVfq6/iyomc8LTykcm2Mmeol7qUiQo6wlYj6rXgrqnz4YnLSMFaTg0u2fax2kQgVKVLggdVyprzzETxMAgFKp+m3zIeIlxniIwudno//A6murv4kdBGp3RIILgcQOPDez/EbTNUkllG+0JY7Kgjiu/pdVGmJhfXu6WqFhrVB1wzOKiBw6NolzpwTmLmaioL1AEV6u8xK9ZUlsT4fjd87IRZapKbWn/Mw6GA14BAF7UfKgxA1OqGKBuk50A+BwxTYeicZLsiA5pIavFSyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QavsExSGaD6t5YA1TeGySJ9rApWzZgdviWP6dtpZqAw=;
 b=Nlslo98Vt5Os+G7Vfp4Q94ITTwzzgkxhdA7UIHT0CtJ6R3cGAK5EGf2QDiJR2GyXkdeD++Ag4TOGFGJVgSA0zQxE2d/YSrI+Dr9uznjivnEXUFHwP/No7IXR4g619YRNNFCPsDMvzzezoB97hIqBOBVrGr4K6PZThBoQtnc/guthiiidKQjeiY6h52/e9uGXY4mgNHnTZ6uw6Z86WqJXVcpAT8YmHXVLGJDawecvHq3aAvCDmRze52yFrTktwhpQbVvB5oKVXtYbyJmwD+98CvvyGeiRL0fNOGi0dEOhwTYbOOditfUb00DefW82K5ClaS+VNPXf3mLC1j0Jlo2heg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QavsExSGaD6t5YA1TeGySJ9rApWzZgdviWP6dtpZqAw=;
 b=hP0eO2O+DTFpd+hnvRdXb+J5mQTQkUgwMlmYu1sJWgMopVk4LixYesW7YI+jiIt9mgSN4ffLdjNXJKxiB3PYg4bYjWDo1p/RJjvbxB38Yy08z0P6XOVNAme60bDJtfLLvI6BnniFoezgzov9xugctLTvj4eo/O1EmRxlkiSdRgw=
Received: from DM6PR08CA0058.namprd08.prod.outlook.com (2603:10b6:5:1e0::32)
 by DS2PR12MB9662.namprd12.prod.outlook.com (2603:10b6:8:27d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 13:34:29 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::de) by DM6PR08CA0058.outlook.office365.com
 (2603:10b6:5:1e0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Thu,
 17 Apr 2025 13:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 13:34:23 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 08:34:22 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <yang.su2@amd.com>, <hao.zhou@amd.com>,
 <asher.song@amd.com>, <pak.lui@amd.com>
Subject: [PATCH v2 2/3] drm/amdgpu: Allow P2P access through XGMI
Date: Thu, 17 Apr 2025 09:33:51 -0400
Message-ID: <20250417133352.1204510-2-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417133352.1204510-1-felix.kuehling@amd.com>
References: <20250417133352.1204510-1-felix.kuehling@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DS2PR12MB9662:EE_
X-MS-Office365-Filtering-Correlation-Id: 1554547f-7e25-45ff-92b4-08dd7db49131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGF2WDVIZWNqdTR5SHozZGhkY1NLeTc3dWprUFdNZVNIR3RMdm40R05VUGcv?=
 =?utf-8?B?RCtSQmFOZDhOKzQ1VTNtZERqaENsc1pteGxrNEROMWx4U1dPeGpxd2V1SFdz?=
 =?utf-8?B?ck9QcnRueFJwR1J3NzlqS205TzNadWRIZ1hLbVhOcTR2ZGxuaFJOMjhTeFBE?=
 =?utf-8?B?K2pXQzFlT2t1T0d0cnNCTEo4RG9VUjJiZEZkYjJ1VFV1ZE1DMzZjTHhqQXlI?=
 =?utf-8?B?R1dMSDFKZ3Y1dE9QbFdjY2drSytVdjcxQlhlekx4WnZYOWRjUTlwZGRIQ245?=
 =?utf-8?B?RHNRczZOYkIrS0c5bE1pVjVMbEpjR2ZiL1E2VXB4cVdTNDQ2Y3EwZm1GMzQy?=
 =?utf-8?B?Yy9UVS8yOVlVTXlMamhSd3ZIb3Z3U1Y3NHk1aG04VllDYnFFWHZMNHBuelBP?=
 =?utf-8?B?clRGQlAwSXJMVXBLZktzeGQ2amRJUFNVN2hLa0NlOWRQS2cyQ01BRWtjWlox?=
 =?utf-8?B?S1dKWEJYS0NnSnc4bUJQT2hTMW80dk4vaTNZN1grS2VQc2NMZVUzSFN3Lzhq?=
 =?utf-8?B?NTRrUGRVR0JRKzVCVzZmWi84MkZiRVhIa255RUxnNW02ZW1OdllDNzRrKzNo?=
 =?utf-8?B?bFhoTXQ1RHczb3A5dWhNYUNSYUNrSEFaRW5HQkNmbUJ0NmpJN01MZVc4alN1?=
 =?utf-8?B?V2lkTmVoMHZkc2Y4bG12YlVBbmhJRU14RW12T2tNbzdvSTRUMWs5bzZqN1Rr?=
 =?utf-8?B?dVZEdzlVeGhvb1VXYjdPRDkzbXcxajJkaHgxL2pVL3JCbVdueHN5ZW41Rmlw?=
 =?utf-8?B?UlpGRDhzY3c4cXVsa3MyK1N6MmV6MHU0WS9La09rUTJoNWt1RTVMVy83QjBZ?=
 =?utf-8?B?UUlKUGxRZTUzUUNUNVRtVTkwTXp4VFVkVTh5UVM3VFQvMXJiVytlajFhNUFt?=
 =?utf-8?B?U3RCQmZYaEtYUFZnSE4zZDBSYk0vUU8zSXNLTlJUMHV0czgrUFphbktobm5I?=
 =?utf-8?B?aktscVMybnN3NEtiaWdYMmFvUE5yZDZIc00rclQ1blJ0YWl4MCtoSzhkd0R4?=
 =?utf-8?B?Q1pvNjVVYmxOcDloelJPajNvektMSVRXRXN5RVJTMGM1V1kxR1pZdjdlVjNv?=
 =?utf-8?B?SXA5Q1gzb0xUdENGUVBpbVp2UTJvVUg1MjFEK0RTZjFpc2dVRGxsZUlraThX?=
 =?utf-8?B?SFVSUlhPaHVRd3NxcEk3VWNDQzlDS1NzWlNhUGZ1dWlZcXpybmVBS09lYi9C?=
 =?utf-8?B?ZjRxRTVjanY0aE92OEw1OEhBUW92WGVpZjhaS1hJRDJ3SHI3M3JKSVNDUUo4?=
 =?utf-8?B?ekR2bit1T1p1VTNEQ216QUpBK1RIWjlVN1ZGTHM0bW9MVlF5YkllU3R5bmZD?=
 =?utf-8?B?M1lRNWx6SzdaUEZpREtMUVpUOWtmSDhVZ0xMeXQ5UG1saXM4aGIzSUk0VGQ5?=
 =?utf-8?B?QUVTNC9MWGRCbWhUeHpFYzgwNmhreno2YmZ2KytjRmV2d3U1Qlp2WkVzbFNE?=
 =?utf-8?B?TTlyWHhBQ0xsY0pQQzRVWHJnM25USmNwTTZid3ZvbXBUdSs1ZzRsMmM2UHFp?=
 =?utf-8?B?RDFEdmM5TEgyVkZsWkxTb21PYlVyV2kvV21XZWVWd2g4VGRFRjM0RDRabDVC?=
 =?utf-8?B?eVFJR3hnS2h6aDhLU091VjJKczUrbCs3RG5teXZCUk9BQ05FNFg3MDEwblAy?=
 =?utf-8?B?ZzRSbVpXaEQ5WHNPVGo5NFFVMHBteWJqVGp1emFoMXNBZG43TElsWUxRbzB6?=
 =?utf-8?B?S3dTbjd0SnYvRHdFbXU3N2dxMVN0VDFpc2o0Nk1EZHZLZm56Ynl2T2JPaml0?=
 =?utf-8?B?aGNhT21HcDg0YjRhalN5dXB5bVJrUkY0UituM2dMYncxM28yelVrYU9TVnBC?=
 =?utf-8?B?Vlg5c1dhZVBXSXlFenQ3ek96S3ZlZjBIcWVDQk1Iajg1TlBNaVNjT1VVK1pC?=
 =?utf-8?B?VW8zRHFndS92UlJpeTNEdjBHZW1mdlpZbVFTTDA4Y2dZdE12dFgxUkZBVzl5?=
 =?utf-8?B?MEtwdHN3UitzRHFyajlSUlNBM3p4R1QwQW12UENxblcyNTAwdGw3cWhiSkM2?=
 =?utf-8?B?RnNSejVZczk2SUd5MFRGZ0ExWVovWjBVSXdrbFlyZEU3Ukx5dmlRYmJtNXpN?=
 =?utf-8?Q?exuMtj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 13:34:23.9071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1554547f-7e25-45ff-92b4-08dd7db49131
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9662
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

If peer memory is accessible through XGMI, allow leaving it in VRAM
rather than forcing its migration to GTT on DMABuf attachment.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Tested-by: Hao (Claire) Zhou <hao.zhou@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 30 ++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 3c2c32a252d4..073e64a667f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -43,6 +43,29 @@
 #include <linux/dma-fence-array.h>
 #include <linux/pci-p2pdma.h>
 
+static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
+
+/**
+ * dma_buf_attach_adev - Helper to get adev of an attachment
+ *
+ * @attach: attachment
+ *
+ * Returns:
+ * A struct amdgpu_device * if the attaching device is an amdgpu device or
+ * partition, NULL otherwise.
+ */
+static struct amdgpu_device *dma_buf_attach_adev(struct dma_buf_attachment *attach)
+{
+	if (attach->importer_ops == &amdgpu_dma_buf_attach_ops) {
+		struct drm_gem_object *obj = attach->importer_priv;
+		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+
+		return amdgpu_ttm_adev(bo->tbo.bdev);
+	}
+
+	return NULL;
+}
+
 /**
  * amdgpu_dma_buf_attach - &dma_buf_ops.attach implementation
  *
@@ -54,11 +77,13 @@
 static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 				 struct dma_buf_attachment *attach)
 {
+	struct amdgpu_device *attach_adev = dma_buf_attach_adev(attach);
 	struct drm_gem_object *obj = dmabuf->priv;
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 
-	if (pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
+	if (!amdgpu_dmabuf_is_xgmi_accessible(attach_adev, bo) &&
+	    pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
 		attach->peer2peer = false;
 
 	amdgpu_vm_bo_update_shared(bo);
@@ -479,6 +504,9 @@ bool amdgpu_dmabuf_is_xgmi_accessible(struct amdgpu_device *adev,
 	struct drm_gem_object *obj = &bo->tbo.base;
 	struct drm_gem_object *gobj;
 
+	if (!adev)
+		return false;
+
 	if (obj->import_attach) {
 		struct dma_buf *dma_buf = obj->import_attach->dmabuf;
 
-- 
2.34.1

