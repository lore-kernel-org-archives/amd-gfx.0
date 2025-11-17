Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BACCEACEF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 09:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E471D10E1A6;
	Mon, 17 Nov 2025 09:39:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z5STzJNu";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8D1D10E1A6
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 09:39:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WShSXIBd1dmGBxdcbS/CTOrsIABMMVTOIRgElBIi+yXrEwIzeY3q6Ec1K8p0Cg5RyTP14mmNkvg3oxv74CudKVBv7TyjyM4CV0jE0UUGWTt9CKQlGOjo0rbNGYdk0CTF0oszrMt2xEM9310SvBUqdgYADpEcWBYSKS0/WE4oELFYa1F9zsAlLkUQ2986jq+yF0yZGPOSW9hQtJ3BF0c5CYO9SjZW4QZT1w/PGdUuUWiBqqF9OIYTcwRJgoldpS3Qyf+2qdHO4UMMf6ppD2OfHC3yadOf6i33UyUhzKHeCd0dkqcm4/VvUKYJ+RLaJmLHAq/w1cd1R+ARbt+lem8A8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCcSi+0ULqaHke1w5zBjHnkr1K+q0OI0sDNrpUqxWuw=;
 b=x3NA+ywWT81vxDRMCBrJIFXi05lWFbFA1T8qWBgQvZCLBiYH5As8uMf1ujOuPygTWumRMwbUFpKiG9Ap72jDOGgDlWtvujoKE2gBbn23cXEgRudwpUO3KQwxVATuZcrnhMS2gudFcWX0XeecfCKL3DNV3878xesis5wQtZngafh9NTpEZpiJ3m5pLqnv0ZPWcqg6NcKkv5vO+iPSDVMqfMjCVfeJ74txNPmF9hjpLrhBYBI/yEW6r5zCZnspIa5ax8W7hmwHLjj8X9XN0p4V9pGT3ZUfX6NaNbuaxLau6TpoXKOro8Yr9bqm271lJOiCUaE+zF6gKC6XqNeI/E2HZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCcSi+0ULqaHke1w5zBjHnkr1K+q0OI0sDNrpUqxWuw=;
 b=z5STzJNu73ERP+mpKcFtzUSn03ILZN3j1sHRU/sAW5w0Jnj00eToW3WXyX3sSUJVzLMK4tDKhEh+IROdEpL6zddtvcL0wkOBiSN492VqXWgUBTx0ozxv7Jh4sxmCUPjjV9NccFuTZMjINjEfij5EFaztyhysDJGV6si8/7QPc+8=
Received: from BL1PR13CA0408.namprd13.prod.outlook.com (2603:10b6:208:2c2::23)
 by DS7PR12MB9044.namprd12.prod.outlook.com (2603:10b6:8:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 09:39:08 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::63) by BL1PR13CA0408.outlook.office365.com
 (2603:10b6:208:2c2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Mon,
 17 Nov 2025 09:39:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 09:39:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 17 Nov
 2025 01:39:04 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 17 Nov
 2025 01:39:03 -0800
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 17 Nov 2025 01:38:57 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Prevent VA mapping for MMIO_REMAP domain
Date: Mon, 17 Nov 2025 17:38:26 +0800
Message-ID: <20251117093856.857964-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|DS7PR12MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: e0afa139-8c3a-4132-2b55-08de25bd283e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j7xLa9/VrTfq+WlNJs9g+BtU6sGvbsjMQQiCAOZhptcaKgKTrpJx5urpVq4x?=
 =?us-ascii?Q?6GidAzJEXUno72mNWEb4YUIVD2qU5+3/f1IlvAxU08Q6XQT8ewhaXzsfyQo5?=
 =?us-ascii?Q?m6aR2ewc8HljhfF5DKMngiV5XHrR7tORoDrTJZvvoNPmxmJbN4GgfPN76hLb?=
 =?us-ascii?Q?Um+0+RM03guZL0y+1rs10OehxGuFY+WwXHwE8jTmHnMarSGUNJ4cQJHtoQPv?=
 =?us-ascii?Q?BurzbBUnTe59h1qXWESfClfX6k0Smz/g9nrN8dkdWME6phnPAUoihbbc0QIV?=
 =?us-ascii?Q?9KQrCCbr3BmOs/h1YXzXz26jdvoCrxq/YELxZryz5PmeSv+VWIl8CADY2aV2?=
 =?us-ascii?Q?xGVlnYRkpFME3Vkfdvs2b7A0hm3KIwZtwP+/FawFIJDAHQO+eaXYANZnqeIb?=
 =?us-ascii?Q?4dYti+b5sX6AdfHn9UH+lqlVEeelB/ClA6xmT8YSByCbL1N6zlQBMNzI32g1?=
 =?us-ascii?Q?onS71AiGuyWGHodf+TQ/XlJFidQlRWqYO8q5PSq01eOy9KJVDFWtRq7ba9Q9?=
 =?us-ascii?Q?TAUxIjKTpEa83f2WByovSmvzv9DM9jKZuF7TT56LBrJX2f8kwyLN+WIQUspm?=
 =?us-ascii?Q?JFCu0BGK9k3KsRyA+TzkqwjsfFrpDY//bblOQkfz4HfxBlsEsuXWNabcgN9e?=
 =?us-ascii?Q?+8dqfczhaNuiNwuMf+Ebyg/Qotw+opCUGpuNN74yNF1YHzfM9kOiVu5dDo6+?=
 =?us-ascii?Q?ploB4acT1Cnogn2OrSRSye8ha6/3Aev8bHpRV2Xj4Kqce0Dba7DIc5ZynoRo?=
 =?us-ascii?Q?T+v76DH19dDHllIwa3J6fmMd6Ifj+mwFJyVbPHNerJ1KYozOCsKnVIwYlljT?=
 =?us-ascii?Q?gTLQQ47rzPZJH/jggxdvES7s2GZQrzDUX4mv8qFhCts+TgNL/snSkkCLMmic?=
 =?us-ascii?Q?vbIe2luF0l4LX42wxDk7Rk/fv6JEnv0D+e23cNBqHNJgy8CLmitTwvmHTeUl?=
 =?us-ascii?Q?gRaR2b4ZgzVlnR+hy1l8/WprE4U3toF44QUAotaivcmBSDZFmO0jyrtE3yh1?=
 =?us-ascii?Q?0IQaOPDAgTX/YEr5An9f4CdUTnkNeiCXaxaxCSnvI8m7fC/+eOaIriCsomlq?=
 =?us-ascii?Q?GX3WcVZgYCu5eA6WdsUZ3zgo2C72PVN0cumoe+7Y9tIsotdIzVXsXaj9QxGn?=
 =?us-ascii?Q?ZKseRIaznrOmcNIkBjlRJ6noK43m+pJ/mg7j4dHqJVqwYUrgEGliNTHAwS+J?=
 =?us-ascii?Q?bdWE+svwMfRiaWXopM596geVsAS9y3JM3GdOJm37m0b8o3Gb6NgK8VqD17KZ?=
 =?us-ascii?Q?UzhCTpkmnvvSdCud2XpBJlBTNVHuFKJWwUJJ+qFTiRiWRQ/iwxRJp58hVrw3?=
 =?us-ascii?Q?6hk1ZsS0D9jr0L2S/NcP9/v7VlPNeF8DtjpR8fqpRfbBIqgUK2XL00e+RPpR?=
 =?us-ascii?Q?SSW73Um6HWv9cyNSqZJ4FuUFM+zFtIYw2CMZ9rnR/hNULb3FuU2hASGQnXPz?=
 =?us-ascii?Q?j6G02OHy5ifC9+uFTTRnhw5gDelIq0KI0HZ4P52U2bNm5izCAsPa2SU0h+xp?=
 =?us-ascii?Q?IaWK06f+2Wp07lgun81Mm+ImWzNqDZ6HhJ3jGJFCWBJbFvG6a8HqHcOg/3Jb?=
 =?us-ascii?Q?jnEeXU7n+UKY6DLoeGk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 09:39:08.6966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0afa139-8c3a-4132-2b55-08de25bd283e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9044
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

 Add validation in amdgpu_gem_va_ioctl to reject VA mapping operations
for buffers allocated with AMDGPU_GEM_DOMAIN_MMIO_REMAP domain.

This fixes a kernel NULL pointer dereference that occurs when
user-space attempts to create VA mappings for MMIO_REMAP buffers.
The MMIO_REMAP domain lacks proper scatter-gather table setup
required for VA operations, causing the kernel to crash when
accessing ttm->sg->sgl in amdgpu_ttm_tt_pde_flags.

The crash manifests as:

[  228.188527] amdgpu_gem_create_ioctl[513] allocation mmio domain ###########
[  228.188537] BUG: kernel NULL pointer dereference, address: 0000000000000030
[  228.188541] #PF: supervisor read access in kernel mode
[  228.188543] #PF: error_code(0x0000) - not-present page
[  228.188546] Oops: Oops: 0000 [#1] SMP NOPTI
[  228.188556] RIP: 0010:amdgpu_ttm_tt_pde_flags+0x2b/0x60 [amdgpu]
[  228.188673] RSP: 0018:ffff986f04563998 EFLAGS: 00010246
[  228.188686] Call Trace:
[  228.188691]  amdgpu_ttm_tt_pte_flags+0x21/0x50 [amdgpu]
[  228.188783]  amdgpu_vm_bo_update+0x105/0x710 [amdgpu]
[  228.188887]  amdgpu_gem_va_ioctl+0x77f/0x800 [amdgpu]

The crash occurs because the instruction at amdgpu_ttm_tt_pde_flags+0x2b
 attempts to read from offset 0x30 of a NULL pointer (rdi=0x0000000000000000).

By explicitly rejecting VA mapping for MMIO_REMAP domain at the ioctl
entry point, we prevent the crash and provide clear feedback to user-space
that this memory domain is not supported for VA operations.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 10e21d2d9b52..1b09d6b9af58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -867,6 +867,20 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	uint64_t vm_size;
 	int r = 0;
 
+	/* Check for invalid memory domains */
+	if (args->operation != AMDGPU_VA_OP_CLEAR &&
+	    !(args->flags & AMDGPU_VM_PAGE_PRT)) {
+		gobj = drm_gem_object_lookup(filp, args->handle);
+		if (gobj == NULL)
+			return -ENOENT;
+		abo = gem_to_amdgpu_bo(gobj);
+		if (abo && (abo->preferred_domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP)) {
+			drm_gem_object_put(gobj);
+			dev_info(adev->dev, "MMIO_REMAP domain not supported for VA mapping\n");
+			return -EINVAL;
+		}
+	}
+
 	if (args->va_address < AMDGPU_VA_RESERVED_BOTTOM) {
 		dev_dbg(dev->dev,
 			"va_address 0x%llx is in reserved area 0x%llx\n",
-- 
2.49.0

