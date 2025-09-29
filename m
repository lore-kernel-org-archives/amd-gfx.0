Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF23CAC5B0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Sep 2025 08:10:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB2210E3BA;
	Mon, 29 Sep 2025 08:10:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qmhrRgdd";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012013.outbound.protection.outlook.com
 [40.107.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCEED10E3B2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Sep 2025 08:10:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJwFknFVhH5f+Kav2GrmkS36j8YFQIZ8WMwHwEZPJ/bgl8jk+yGIq1mKaqmg+lTdLNmRLjPAxmGWZEvu5ZcBoOcsI2+395t1UOP1YAQFJn1pJsIpARJx/uUTm+w/XRLL178T0ahG1PSaQQLvNSxotyy2jCITK/bEgODGKGwHvCXEedrtpEdRaJYl4ufoGMswcyWpKU1N4bXMrasq6b2nD43OE3EW3p54GxeFJk5bwqznzNkw042T0laEAC4K3Gwg+f0bnb64fieX3jUsYWvrBfZ/oRMwuvfd9VExCPYHVnwPIRQkbU4ANsQlmLEad1sak3h6S6PHrYG0utZZjFu1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mn2foryv47SsboLNVRXJCdYc5O1vittLOVjh6Gldohk=;
 b=hPE691Tsv9yHZjNzFXdFm2ShD3PhuCeuySiSdTrX0QDFn8rO+QyRnM61+hWiYhAFKoso1UY1RFCZ6HY5Pi1GIVzwo6ru9qby+RRu9qv6sMzfizXo88TRlNpq9w3AqdXjrFdXPk+OCNPNM3bbjmyMN5/QfZIsfhGf9U632XtAPGDJovlZZl4eP4ePORM+Wx9Ll1cnU2MxWsFt0xrcKOVr1ZbAo1bF8bzRwxS60ssILvVkM37GQuoujWqQfSWoywZMW6ZZfKXyHOAApIcHOiiQSc6YTBuY4EJtH8Vf0ufvieOi9nEtTfyNMGsLDEivZ/8p2iDY5WoWlkYrb8NzVotd8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn2foryv47SsboLNVRXJCdYc5O1vittLOVjh6Gldohk=;
 b=qmhrRgdd3Kwg6JTdr8gB98FcPLW9aSYoL0kcZgT/XurPaBS5jMaiVswEegd6glucvXkLrV6gpT4XLyHSQpssOueSVsAqmSvVAx6PA4AVveh/uVOlCXYLILaGQxByTi2ugFF9M1LdOUDKufRHoUmdTXmp5iVdfeLT8DjhEZ2vEU8=
Received: from BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20) by
 DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.17; Mon, 29 Sep 2025 08:10:11 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::a0) by BYAPR01CA0043.outlook.office365.com
 (2603:10b6:a03:94::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 08:10:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 08:10:10 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 01:10:03 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v5 6/8] drm/amdgpu: validate userq va for GEM unmap
Date: Mon, 29 Sep 2025 16:09:42 +0800
Message-ID: <20250929080944.2892809-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250929080944.2892809-1-Prike.Liang@amd.com>
References: <20250929080944.2892809-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 2017b841-d4d7-4f7e-b362-08ddff2f9c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXZuZjR0eXhSNVdLbVBSdkNNVDFpVi9zcVVia0VNaUt4cmJJbEFJNENwVUdH?=
 =?utf-8?B?UFdsdGpTMmhiU1pvSGtxd3RIVkJlYVhHZjNCQmZkUWI5SnRBWk9ZYVJlZ01Z?=
 =?utf-8?B?dGdGNDV6VjJ1UjdSSDhVcUJqVzJLNlNONWdwRyt3bHFoaUhRa1ZLZFlCL1dl?=
 =?utf-8?B?RmlvcGNHTEpXczdydFp1a0cySHlzVlV1QTRZMVJuMTFFMndySTVMVVpYYk1X?=
 =?utf-8?B?eEh1UGV6U2NYMEp1MmRIZFM5bnBtKzY1V25HUUh3VmduSTZhdkJQa21uTGVL?=
 =?utf-8?B?NnFUQ3JWVExnSTRRRDArZHI1YktUamlUNnNpTmJ6WHR0ZVgwZWVITzFaWldM?=
 =?utf-8?B?NEhTc0dwRzF6UVpzdncrckEyUEFRY1VzVmM1SEY3QmJKV1p0V2FCZStVRm5P?=
 =?utf-8?B?Vll0NEhTNlZva3k3NG1rZGFsbFJobGJyYkNLd2hkNE0xRndCeDcrUjZBNXhy?=
 =?utf-8?B?YWlreEVDZElwQXNQVnBrb3FtdEZ5a1crM25WbU5vTzBYbWNLWkFhT3pKU2dq?=
 =?utf-8?B?NStvL0NjOVNSSElWRWZiWFJpQ2FMUnZGL2Q5SVJQWU1VY2lVTnB0dVJNT21G?=
 =?utf-8?B?Z1hxR2oxRVc3Ly9pY1ozQ3ZrTll5bnZ3TE5qTlFYam5tVlN2QTlBMlBoUEZw?=
 =?utf-8?B?M1FOWUZGcGc3cGtURmFHNGpTeHp0V1hDNHZNbFplS2FrbjQrektRYUV4amRH?=
 =?utf-8?B?QXlMcGdiWDB6RkxqeU9DVzJlaytHaDhDeEx4YjRUaUt1b0ltQTF4M2tWSlNw?=
 =?utf-8?B?MVp1N0svTXlqVEQ1MExXTVNVNlo1YU80MDRZKzRZMTRXZmpuU2RiZHYyb0Vu?=
 =?utf-8?B?Q0E2dndrSkRSQi9URDhBa3ZjUm9yUjlnUU5YSmdMNi9WcVlyTXFnNzZaek01?=
 =?utf-8?B?TC9Jb2RRcHFBRmtxSncxR2FsWVFYbHMwMGZxT3pyaUNrNkJuRHhQbWhDR1VK?=
 =?utf-8?B?NDd5WkJwRmx3WkRLNlRuY3FmU1JZNHZ6MEFUN3ZrUS9GU1JZS3Z2c3ZGRWo0?=
 =?utf-8?B?Z1hteXhWbHp2Q29tc21VMGZadHc4cHk5U3FXY2FlSjRmbzhMejE4MW91QlJL?=
 =?utf-8?B?c3lVbk5pQmg1M1N5UEM0QTk0QUU2aWZTZ3NRZkl3SDJoUmpHVnZqbWtOMjVP?=
 =?utf-8?B?NVNHSlBSVTZ6bjk1MWtDMEhaRmU5eEpRSTJ6K0s3V3d5RWNuSFBnSWR3MUsy?=
 =?utf-8?B?ZEc3SkdOTGhzYStwYmJwb3RaaWJ5Q1IvV2VkT0IyQ29nVm41S0thQ3M4Mkhm?=
 =?utf-8?B?OFhCNnRnRG5Qc1IwWjNreml6Z0VXbUxVSXBwdmtveHVzWEpZdjRHbnJyYW9M?=
 =?utf-8?B?bW93Sy9ITExSV1hYT2tLS09UT2NIU3pmQ3RsMXpFZlAzLzBuUXRSeWtESURr?=
 =?utf-8?B?Wlg4VzhqYVo0b0dIMWszMzRHQTdnU3BGQnRaNFZQaFdLYnhrUTBZc2dHRkRo?=
 =?utf-8?B?WDc3WDNzTUxKQUtHUkM1TDJGa0llYTllTVJrYUpPSVJPNzdXVFFDd1lTYXdq?=
 =?utf-8?B?T1kxOFhXRS9SVmN4d0JFalRaUVBLRElZVzVKVnNCQUIxUVNJS25LMlhtTlhY?=
 =?utf-8?B?RVZGUjZCY1pGQ0JIU2hZZjVoSlFmcnZaR1hwMktqUGV4S3Z2Y09oS1JEZGJy?=
 =?utf-8?B?SnZvMUQrZGFlQ0Z3THVtWjJZeXRWZmY4bXdXM2lPSkZHemlSMnlvTDR2ZzBG?=
 =?utf-8?B?V2RIank4TkNCemw3WWQwbDZUZGpkV3VnUzEyYlhaMTM1S1NreUhhVUJTTkJ3?=
 =?utf-8?B?N2NBS1NnaWZRT0doQ3VJSkNiTjh0RnNuQlk0b24zQ0JrRmxzUmlRbS9JbjdE?=
 =?utf-8?B?Z05NekNadTk3ZEhlM1FYdU1TOU44ampZMmc1MkJQV0xUM2hiTEs0dVFFOENx?=
 =?utf-8?B?Qm1ORFhUcU9vdGttdmladFhhNkdCV0FkR1pMaUFPTzNRSy9QL3BLSncrK3hy?=
 =?utf-8?B?a0lhTnRrbmU1YVRlaU9vd0pnVDF4a1F6cE5KbmFuazZsZS9rWFh4aVVNbHNm?=
 =?utf-8?B?RzRnZHZ3aUFXVzNFekxRbWxPSTR5WHdLOWlHaktBMk5zdjZGVFBnRlRsbERw?=
 =?utf-8?B?ZnlFMWY5MWtBVktscGhPNUhFbE9lYUFVWElIQWpYY0NpUHo5UWRLclVtNDNO?=
 =?utf-8?Q?LLVk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 08:10:10.4316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2017b841-d4d7-4f7e-b362-08ddff2f9c33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527
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

When a user unmaps a userq VA, the driver must ensure
the queue has no in-flight jobs. If there is pending work,
the kernel should wait for the attached eviction (bookkeeping)
fence to signal before deleting the mapping.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 31 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 12 +++++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 15ab2f4c1952..d7cda252cae9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1195,3 +1195,34 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
 }
+
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
+				       struct amdgpu_bo_va_mapping *mapping,
+				       uint64_t saddr)
+{
+	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
+	struct amdgpu_bo_va *bo_va = mapping->bo_va;
+	struct dma_resv *resv = bo_va->base.bo->tbo.base.resv;
+	int ret;
+
+	if (!ip_mask)
+		return 0;
+
+	dev_warn_once(adev->dev, "now unmapping a vital queue va:%llx\n", saddr);
+	/**
+	 * The userq VA mapping reservation should include the eviction fence,
+	 * if the eviction fence can't signal successfully during unmapping,
+	 * then driver will warn to flag this improper unmap of the userq VA.
+	 * Note: The eviction fence may be attached to different BOs, and this
+	 * unmap is only for one kind of userq VAs, so at this point suppose
+	 * the eviction fence is always unsignaled.
+	 */
+	if (!dma_resv_test_signaled(resv, DMA_RESV_USAGE_BOOKKEEP)) {
+		ret = dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP, true,
+					    MAX_SCHEDULE_TIMEOUT);
+		if (ret <= 0)
+			return -EBUSY;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index f19416feb7ef..7bbbb5988fc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -146,4 +146,7 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
 int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
 				   u64 addr, u64 expected_size);
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
+				       struct amdgpu_bo_va_mapping *mapping,
+				       uint64_t saddr);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 563cad9c6cbc..a5de6e3980db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1913,6 +1913,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	bool valid = true;
+	int r;
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
 
@@ -1933,6 +1934,17 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 			return -ENOENT;
 	}
 
+	/* It's unlikely to happen that the mapping userq hasn't been idled
+	 * during user requests GEM unmap IOCTL except for forcing the unmap
+	 * from user space.
+	 */
+	if (unlikely(atomic_read(&bo_va->userq_va_mapped) > 0)) {
+		r = amdgpu_userq_gem_va_unmap_validate(adev, mapping, saddr);
+		if (unlikely(r == -EBUSY))
+			dev_warn_once(adev->dev,
+				      "Attempt to unmap an active userq buffer\n");
+	}
+
 	list_del(&mapping->list);
 	amdgpu_vm_it_remove(mapping, &vm->va);
 	mapping->bo_va = NULL;
-- 
2.34.1

