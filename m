Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F18606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ej2wDo1J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6704F10FD8C;
	Wed, 18 Nov 2026 15:11:05 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010014.outbound.protection.outlook.com
 [40.93.198.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0996210FD91
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 15:10:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lz7yng9IjIdMKj/uHOaCPwlNURwpLPwwJp+u9skbV3EhohV0+O4meWBxDtPg5AKLamdvzJOf/MXTVpDig3K9tt/8F4AQ1s3Yi6pj8ekYoYVNGAI4kKWvF+yj9Bh2NbD/T80BjM3i9nT4Qh/UMLNy3F+E7tEpzQtJc25b49q9w9ppZepLUbjM9OAtzt6tn0F4lKX8bIkpxt99asa6uZD+nc5bkwWhdNCQf0AJXU9wtO6yrhNJIlgxvBegl2e3Cju32KPNt/720XaWKTTNpO1nB1uIgjzB4AIefvOvDC6pnt9evFu36e7hWSmRYAMoHb2zdtX5cyhAS4ohz6k6xKZEDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eaKL4GNZnNb8xhHTKx1bq7WWwHKrq+jagJfYQpyUXU=;
 b=pq5LTpVY/d7uhQQZedASS4TPE7DS1mD4R1lWiGnxE2tpRh2fUt3/1H+xK+S/hjJtKof/mlSBz1jvJ9358y4teDyI+gl+o2MQttSDL9d+oNMdV4fvZrsQgTnLOKJ/+dBHdC7Z4O3nOUGqohwicG3o6l+N1I3lyt6KrBHbdzTYR+gwF7QoaWhb6Zwx4f4e1tB8Ypw6y+LNOvLvgTZwWy59iz+E4TJU6uTde0Q77/9wCxx2F4MTBgl1lIjrHZwbPftshsWaC6Xtx/0UsJvX8CO8Vm47LfV0wPSGdf281czjPSDWCQsHGURV/XNFdAjJwDHyPfrDUf1RrGMmd3HxYFPzkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eaKL4GNZnNb8xhHTKx1bq7WWwHKrq+jagJfYQpyUXU=;
 b=Ej2wDo1JaeljMtJ0TbJ+GcuP2w15tjqpkMTJRXQA3uajscmxNgk60fUnqdFgXuZAoq4nvgi+I3hlpu1G2+K1QSi1SKIzi3IcF+p7mXMQTzME50E2qwxEZ41r5MlRIBAgzBhOxCK0MBb09gR8y8QN3vBm9jhVrj9E0S+fQqdC2Ak=
Received: from PH7PR17CA0048.namprd17.prod.outlook.com (2603:10b6:510:323::11)
 by DS2PR12MB767817.namprd12.prod.outlook.com (2603:10b6:8:3c2::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 15:10:54 +0000
Received: from CY6PEPF00000048.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::a2) by PH7PR17CA0048.outlook.office365.com
 (2603:10b6:510:323::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 15:10:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF00000048.mail.protection.outlook.com (10.167.247.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 15:10:53 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 09:10:52 -0600
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <William.Palacek@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>, <philip.yang@amd.com>
Subject: [PATCH 0/4] drm/amdkfd: don't stall other threads during large
 userptr registration
Date: Wed, 18 Nov 2026 10:10:34 -0500
Message-ID: <cover.1795014593.git.William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF00000048:EE_|DS2PR12MB767817:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c396aa-d4c4-41f4-f107-08df4586238f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|261022105027099003|261102123227099003|261021123027099003|261021121427099003|261026121527099003|261028144727099003|11063799006|261026140227099003|56012099006|10067099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: AffBT12a2fSR+ecmXA7gaeOJHf5yyv7F10hglmm6fY4eFUeCdnYgLvonU2R6K2/t/oFioyxdNkiy8zupnq6eXn6BjbCuXqCIBiEJRiHAeypAwBwIVJSH5SO3Wy1Fz0MYh0Igz1iz4JUj/ACMbAP1ALEbKW8szUtC5whBshafR65Q9qixfWuIhoGsrxfXHuTpVjACIMOMEdb9Ybpeqp/254CS8GuapgrDcufi8EruJn9Aac2RKbzsUpOM2y+8ibhw0g1cdHIG8I4bBwi4DuNNFNHGerY8ZYrFnNT9wVBdnJQMf/1kEGVK1nelSw0DnqPR9fo1tNOKhYId7UIFUvxGaaBbnvr6XA2+F0rA/ECIdcwqFjKJiT1IdNFTNUyaDOLXlnLJYnHFwklqLR3Fy3KNW5G3K+7rMKQHoik6ECk8ctD7alt+3+n16RG1oAZ30DFjJYKmKSE3DNBcF38Zf/zOZYCaKL8EagOzxGPCOqKolyCiDXLVMZTS20+xCWPkAkWmqEVvONr4FoRjK32Oz0I4aBKfjdRk5cP+K024bIa5EbMnjJ6c+jNpB47s0LJmMWHQHEb4d0/+jcsRzamKySFG4xuco9dFxsMFh2/HJmkbyjwh2lpx5rJfqz3tehS2mGv1Yjmz1TV4ScfWFc57ZZ/MCY3/ZhLKdxc5JDBeQpU4ipwT21qyChsKUt7XLA8tiTPhRBU6Fp/Gdur/S/0rNUTEDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(261022105027099003)(261102123227099003)(261021123027099003)(261021121427099003)(261026121527099003)(261028144727099003)(11063799006)(261026140227099003)(56012099006)(10067099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c3MA8RsZg0PGDaIg7qaHFaHuR+dw5JgFvirOyfM7/641099dw6RDhwwfNLTP06Xz25NWgo65mH60gOvGW9KzApo5SjrF9t5T8JV348C9TxjNfOKgonTOvzAn3fnqwL+WY8ieWscL5LQansnbuD12YO7/8RzWAidl4JN5C4B/s8T9NdyaIex1YtImqHMTRNXlnSZcARbEM9Hk8141VQ6t/+a54jhbde2o9+MlJ+WhD8nFnF7emZE2N9JfjbNt+QyozBAc8uQlSSItmA96WIP2J6hr3o4/pFRNRN3E1pqMN5f/ufDfJyMRdJjLDzsS3nFQrKMJKT3iEgLUylganH4V/ixIY6auKQA+HDadIBTDGYERInl8C6V7nAvzEzJuHZfmwfkde4kiHwtgWlIGO4gTLJG2hEgzDfm1NpIMbUdHHNu4Jd47kfxYzZdzdnMW7mSj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:10:53.3851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c396aa-d4c4-41f4-f107-08df4586238f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF00000048.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB767817
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Registering a large userptr BO (hipHostMalloc) holds mmap_lock, p->mutex
and process_info->lock while every page of the range is faulted in. For
32 GiB on MI300X that takes seconds, and every other thread of the
process that submits GPU work waits behind it for the whole time.

Patch 1 limits userptr sg segments to half of sg->length. Larger
physically contiguous segments can overflow the padded segment length in
iommu_dma_map_sg(), and the pin fails. This already happens without the
series; patch 3 makes the pages contiguous enough that it hits on a
freshly booted system, so it goes first.

Patch 2 drops p->mutex from AMDKFD_IOC_GET_CLOCK_COUNTERS, which other
threads call while submitting work.

Patch 3 drops mmap_lock between 2 MiB chunks while faulting userptr
pages in.

Patch 4 faults in and validates userptr pages without p->mutex and
process_info->lock, and adds the BO to the valid list only if no
invalidation happened meanwhile.

Tested with two 32 GiB hipHostMalloc/hipHostFree cycles next to 4
PyTorch streams on 2 GPUs, measuring the worst GPU submission latency
of the other threads (limit 1 s), on the amdgpu 7.2 DKMS driver:

  MI300X, IOMMU DMA-FQ     unpatched    0/3 (6.1-6.2 s; on other boots
                                         the 32 GiB pin itself fails)
                           series       3/3 (0.80-0.95 s)
  MI300X, IOMMU identity   unpatched    0/3 (9.6-10.1 s)
                           patches 2-3  0/3 (10.5-11.0 s)
                           patches 2-4  3/3 (0.81-0.93 s)
  MI350X, IOMMU identity   unpatched    0/4 (4.55-4.84 s)
                           series       7/7 (0.21-0.39 s)

kfdtest KFDMemoryTest.* and KFDEvictTest.* pass on both GPUs.

William Palacek (4):
  drm/amdgpu: limit userptr sg segments to half of sg->length
  drm/amdkfd: don't take p->mutex in AMDKFD_IOC_GET_CLOCK_COUNTERS
  drm/amdgpu: drop mmap_lock between chunks when faulting userptr pages
  drm/amdkfd: register userptr pages without holding KFD process locks

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 53 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c       | 14 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  9 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  7 +++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 10 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  2 +-
 7 files changed, 66 insertions(+), 31 deletions(-)

-- 
2.43.0

