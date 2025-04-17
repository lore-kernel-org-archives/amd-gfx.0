Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949B1C369C2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 14:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20C8310EB41;
	Thu, 17 Apr 2025 14:52:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vk48osQa";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0D8410EB3C
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 14:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sC1tnQXj7diWqAh1M5vmyaWFaTRFGDMb8+Lu4NDq6WEydwVPeQHIWRCsxVNEFf3tmucYV1XCHEvFa5R0LKJC9gY05nj6X5z+NOf2cf4Z+2v6+L7J4UnDrUf08MUYwxqQJjhUMNBN8MIThMMDAOU4WMTcX3s1kD2/ULm1uO7X6wVKvNF6oFB62casRPZ2k04PuydUxynSraMaXwovvXDF39nfkztwSorjEXLbNMMgGvndoqaNW/MqI8B8dxkdULP05hjNeHZNn9bMJAQFpYLTUbZ7ylM4YbAi1Wmo6zQax+WhunI6BtW0GcNE55WC5KfLv9uDkDINYWJSCnqezN+sgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIUc0gjq1Wru76mi0Em3QGnGykENsUdqGXGeCYOQa4c=;
 b=iElbRXLDNA5tgMsljdI7N3nbw6FvFujPuJHVQ/YGpM4BYSvbr6ZBlW/Od87po+BtAuNw3M2FFtONmz+IEJrhzgSwQN1ER3Z5giSdvKA91oA33cxvllVzgc3Kell2Z+n3VNXBonBcts1Ee5CR53YZnkifzMYukP16PRXJkB5IulqzrpNseXuIbPKZFcAljcrOB5bCMsZKF43bOGXPtZwhYITuyvU4aGw6Ton5NQeWXT021K8sJVvOqYZS0bonj8KlRisGYPBmISO2h/tlpmKTYoUe/0XabYGeZyp8uktSz/UbIz18vhL+vcAivDS0vmnIf3R7N4Io6gzKL6g66NNVBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIUc0gjq1Wru76mi0Em3QGnGykENsUdqGXGeCYOQa4c=;
 b=Vk48osQaId60bsKt5A/0xvtdhiDDY7nGKjCEaeSB73ym08DmpsIaAWgqXH/fNmEr11QyzDECf1VEtmPM/6AdjS4R7mfZV9d5ukjVfmIAbvk5fe1KlMS4tGk37a1sBhGUFOujRSq0vD52iZYpyMao0at+dmYVOxYJ0pflZAHbMRk=
Received: from SJ0PR03CA0383.namprd03.prod.outlook.com (2603:10b6:a03:3a1::28)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 14:52:19 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::e0) by SJ0PR03CA0383.outlook.office365.com
 (2603:10b6:a03:3a1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.33 via Frontend Transport; Thu,
 17 Apr 2025 14:52:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 14:52:19 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 09:52:16 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <yang.su2@amd.com>, <hao.zhou@amd.com>,
 <asher.song@amd.com>, <pak.lui@amd.com>
Subject: [PATCH v3 3/4] drm/amdgpu: Allow P2P access through XGMI
Date: Thu, 17 Apr 2025 10:51:50 -0400
Message-ID: <20250417145151.1275415-3-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417145151.1275415-1-felix.kuehling@amd.com>
References: <20250417145151.1275415-1-felix.kuehling@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d060d28-aa96-4f53-6586-08dd7dbf73e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWd1NFBLSThzQWhIOGlLdVlWK1FhejluTWN3a0lNTUduS01IY0IxdndERXhu?=
 =?utf-8?B?K2t3Y1JET0VMQzFjMVQvS05PN1dGeFlxZ0orNnFlelBJUitWdnlNKzhES3Zm?=
 =?utf-8?B?VkZIRmVLeDk1Qk41aDB6Q1lycEs3ajdjTEFMVnJnTS9NNllQWkhOaHgzcVNH?=
 =?utf-8?B?eXNXWk5sN25xc0NGMUZaZnpjNGIvWFVPSVViSU5udDhrakFDT0t6SzlFNDM4?=
 =?utf-8?B?ZDBnclNCOGc2dUpxUDRacXVLMDREZGt6UUNPSTBGMEFrbS9TcUUybEVWZGUy?=
 =?utf-8?B?bytnbUtjZGIxK1UwY1dVSWM5L3dDdVBHdS9waU5CNHNORGlxakZabTVDN01r?=
 =?utf-8?B?Sk9yMEtrRmI3U2FxdUgvSy9lVjZEeHE3WVp2K3BsaFhOOVpCcVBpT1g2b09N?=
 =?utf-8?B?NDE4Nm5sSTArQjd3WHJYWlduNHJodzZ5RU1TaUxEK0hQc1hhUjZrWUFqRVZM?=
 =?utf-8?B?WUpCWHQvVHNhUGQ3VTZ0SDQ0UEpaNXBjSG9FeFcwNHhqbCtJMDZzUDdoaTRK?=
 =?utf-8?B?YTgzU2lsR3BxaFhEckNGbVFwelhDM3FDTFkxUDN5YzM3clA0UU9oeG52MDYz?=
 =?utf-8?B?eGhTYXN0OHZTVisxRVRZd1VpaXdUZlBHTC80MStCWnQySEJmR2k0SWF5dVhm?=
 =?utf-8?B?NWE5RnJPTWtlbjh6L0pxM21zcThVUjdROXBEckhISGcvelJ2cWx2WFhwYVhG?=
 =?utf-8?B?VmNGbHNFNjdjZUJHOTIzc2JFMWpOQ3lGazRZcHhSREplbkdIMGkvcklWRmV6?=
 =?utf-8?B?MEVwbkhFR1lOSmRUSlhaRVJSZ2FkZWxWdURHei9tcUY5VVgvd21nWktzb09I?=
 =?utf-8?B?V0kzTGpmdDF4R1VWNkxCREhxU25SZUlza0JMU2xsNnFNanZnelhyaXkwaWFj?=
 =?utf-8?B?TUtWVVZhQzR6QlIzOHUzQlJLUXRrcWZLM3NvMkJDVGovQUpWYmYwSGlUd3dx?=
 =?utf-8?B?QnpGbkpBeWNWNk1WNHU5RHV6dzk1Y1gweEEya3ZydTZ1MG0vWk4yMVJJRE1N?=
 =?utf-8?B?dXBkWS83UTZ5Sm1raC81V2kweUl6bDlUQjlRVURCcExkQTZFSGg3MGlnU25G?=
 =?utf-8?B?bDRYRlZUTEowY3M5bnBtcXhuZXg5cGxtWGtQTHVHRHJMelR0aEhNNVpMbDFY?=
 =?utf-8?B?SVRHSEVSVXZ6SDg3RmsyOTlkbDQ3SzFBRWNOR29pa3JMV0Nsd1V6aDlNOFpS?=
 =?utf-8?B?OERPMGhwT3dtTStheXdJL21TQ2h0djZwSVJSMG1CSmtIZXFEWk54ajdVc2Zt?=
 =?utf-8?B?dUdkUVJlZUZFc1ZNN3JOdkpibm5NVjJvTCtmZ0k0MURmcHVaaXVMVkxNcWVx?=
 =?utf-8?B?ZnNCT0xiUjBCc0dMTWxPM1Q0YnJNdWdpMERHc3U5d0FGYXRiaHN0bmZEZzc4?=
 =?utf-8?B?UHEyRXpGd3FwdW4yWVA5SFozcjlFTno0bFJGUE5NOS9LRmhDaTlWRERVWjJl?=
 =?utf-8?B?clp4dTNpOUJzWC9SZEVtQ2VQZVVsc212czVKWjlOekRYYnI2dXljY21pSGZp?=
 =?utf-8?B?Z1M0aGxQZ1ZST0FoNVJpSUFibFhZUm53ZWk0RmJHd1BVZmFnRXBwMzdiUHph?=
 =?utf-8?B?a1NrZkNjN09WWXhwa2t5THcwRFU3NkNvOVVKS3p1SWRjZVhrK3FHVWp3T3la?=
 =?utf-8?B?S3ludHIxcVltSHdlbmdOaHNRMlFBb1lXdFg2QUxSVFJhdy9Tc0NzZFNSaVkr?=
 =?utf-8?B?YVRYS3lWK3MvVEZ4OU5nWDl2WDlLNmpPUHhUMDhHUXZZdUYyblF5V3U0bGhn?=
 =?utf-8?B?dGpPRWlQVnJyY3RMUG1UckZ3d29tZk10ZTRndTBJTGZ2SjJPRXVFOWJzb0l4?=
 =?utf-8?B?OXppVTBFQnpvb2lwc21COWFJaU80WTd5K0x0YnBTYzNXRVQxaSs3ZStKMjRV?=
 =?utf-8?B?WkYyNk5LUnNTWVJod2xmOW5ldTZWY2lTeWRFSkV2WG8yYytSZ0VZVFpHblg1?=
 =?utf-8?B?QmJHQ205bEg3eTJXYTE4Wi8zR1QwVm45YktEQnhsdGxjNTVuUlVhQ2FjRHpN?=
 =?utf-8?B?TFQ5VUFjQmcxWU9pWWZDSTZhdFEvUk1CQjk4bkllMktSWDA3UzNFN0NRWE5a?=
 =?utf-8?Q?ghT5xv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 14:52:19.1358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d060d28-aa96-4f53-6586-08dd7dbf73e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712
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
index 5740e8d1a522..e6913fcf2c7b 100644
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
@@ -480,6 +505,9 @@ bool amdgpu_dmabuf_is_xgmi_accessible(struct amdgpu_device *adev,
 	struct drm_gem_object *obj = &bo->tbo.base;
 	struct drm_gem_object *gobj;
 
+	if (!adev)
+		return false;
+
 	if (obj->import_attach) {
 		struct dma_buf *dma_buf = obj->import_attach->dmabuf;
 
-- 
2.34.1

