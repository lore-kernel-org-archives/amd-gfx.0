Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CA2606A32D
	for <amd-gfx@archiver.kernel.org>; Sun, 22 Nov 2026 20:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gB4RUSWx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B0E510E5D6;
	Sun, 22 Nov 2026 20:26:03 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013067.outbound.protection.outlook.com
 [40.107.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C314A10E61A
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Nov 2026 20:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWpN6UBzcX7NXVqVRXu9x4HAvMDOEY7AKwPIWmRUChn3w6sbQHOUSVyXGRBqaD+gm1+Cucbc2q3DcffZ9FH1Ig1kCQgRebut01N1GuJwgBnokdRUBiv0f0xcVDvT6mvOs4dZ/RiOYJG3sfdXAtK/58QsEwdyoQO89eZQOc6yBYZiERYSSDBY5KD4xYJu9Zgsp4T/JR1hq3/nutBm4k34MMVjE6aHCdeE3G4rnLyMrP8gfJglYW93POq+kfqMew6efQdZ0GOjEJGx2R6RijPfadgIBVbOg1kGQa+YGv/6vqa6ACZx8dbsA/cvf68aR8q/aXvsqGht5UCweT26S7hqag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjWEgrDWppYJPh1v+1o0icUv4nUU5e+4kIHV9kIuR0U=;
 b=XDtidwJOaE4dRymhBqCt6TjFUiwrFivum/wtELJFJuKnLZJzEKDzQrFO2VZxaPSac30AS6G5bg1XBFzPzsjyaz5S5NizaKwdXHLbzRkhvy/qYdh11FpPvLOISQRs24d9lW+i4O0W4txtMfVoUoMyBj0/vLnuXJz5OHawLkefkz+6FO8UnC72fJxyWNArDvaG7ZgfgXS+BWS1oyRAoRYNHiEJEOKXLiZpBqKW6Ru0el8T1ZMj45hR50I5WQVdJ0sWgPYDL4zrCi874dyIb2M7t3gFTxk6BWfewPbuJta8L2yc1J7ZIBd9TDdiM7QHPud4feezVaS8VzzMai7cPjuAgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjWEgrDWppYJPh1v+1o0icUv4nUU5e+4kIHV9kIuR0U=;
 b=gB4RUSWxoaBK5FfX1gfMWW7YNA1F9p7sLB4HRV4YaZIz3BETnyS6Oy3GnF1oSNa8/1SW78WfV9jgYhWCnrVWxVPeRPDKKY8XpYHDjydmnkQLLY18qOTafEvNzAr0wn7yETiKBem4dKS1shV3EzN/D+S5MFiYnWL3weLiFcVOJx8=
Received: from CYZPR05CA0040.namprd05.prod.outlook.com (2603:10b6:930:a3::17)
 by CH1PPF84B7B0C96.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::618) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Sun, 22 Nov
 2026 20:25:50 +0000
Received: from MWH0EPF000DD30D.namprd05.prod.outlook.com
 (2603:10b6:930:a3:cafe::31) by CYZPR05CA0040.outlook.office365.com
 (2603:10b6:930:a3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Sun, 22
 Nov 2026 20:25:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000DD30D.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Sun, 22 Nov 2026 20:25:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 22 Nov
 2026 14:25:46 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 22 Nov
 2026 14:25:46 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57
 via Frontend Transport; Sun, 22 Nov 2026 14:25:45 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v5 0/3] drm/amdkfd: Enable device private memory THP support
 in kfd svm driver
Date: Sun, 22 Nov 2026 14:26:50 -0600
Message-ID: <20261122202653.274580-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000DD30D:EE_|CH1PPF84B7B0C96:EE_
X-MS-Office365-Filtering-Correlation-Id: c1829d1d-6009-42eb-e34a-08df48d6cc14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|6133799003|11063799006|261022105027099003|261028144727099003|13003099007|261021121427099003|261026140227099003|261102123227099003|56012099006|261009223027099003|261026121527099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 1z/yJKEhBzYJrziGQOqx7PnBTH1H5KaReJ3LBb4yOlqBfO43T3IXv03Dd5i2IhS7mW3QjomZisz0EJllQoYfTOX9tG9PO67ZBBscm5LZt6v52iSMfHp5Am/XZcTRqQCTZmckZz0ihGrkeaTrR/IYo0ui2YBeUVtRa4EC8+Hic44RdKDWc1HpJx/vyOqGwjctVguU6Crr2tPX14vmUhwKsWDAKgGo2mICj9Ns1r6fPMPjx6H46i3sSIL0Mqzv7aonPbqZgabT2T4rT7rKdlgK3bmAPxbcdKU1+AMsIzK4r3Eos7Cbkb8rREqVDuHkdzQDBI55tJI1IssRphKoQKXrW5cMJ9LAqH73SwkCfTukDHjQuKPQ3JGHVUC3Qme4waO/StECQfCtRzGb04f1y2KHUn26YcL+1Z6/GmOiSlzCU1I72Ki9InmUZKrnKb4rCa4DZ9Smu21GIj1K0YvWoIFAgFzyywnHNL8U2bzU5kyJ5RuZ/x+nhcvTDi13jtamypjzsTHxBBRUqJBLlZ24lDZ3oHGaKik2V9zVPfL59/HziXoaznSG6Je3o0BLgZDz2Yz0Vmvf2yZZjcCb/Sb+sWEaOgP6c22weOHCHf6RtbS8fbHVGH8HbGFFukNlTvlYQF4Hld6Z88/5e64j8b7ERKw8hw+pdE4+m9QQywS0CYK4B3o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(6133799003)(11063799006)(261022105027099003)(261028144727099003)(13003099007)(261021121427099003)(261026140227099003)(261102123227099003)(56012099006)(261009223027099003)(261026121527099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lMfrtEqu3IxKUZ8o46LmycRyHvfv1s9vllKbTBa2jacDeVt/hnYHyIf7KyVick6cz25EXeuQ8OwHRcScX7zCc3G+GQLEomQIRpkGYi7/jG7GWwkdlFc2VGCVGUpUAwRnuJJQIh+c1ct7T/FiwOoPKNejVAGPDSJNxsKBdcPTJYf+ZZKMTqYRNHbziSgZj8B0PBeKu0bMCchgnX3+pSVNpPb4eYSifYrCaJDHPo0xfg9c5mjEjuzc5WBJT5vbZ+jqirv7tXmFjf8ImbH+wcybGGNJlQ8qBZdmMwL0yFHOiQ6i8+1G8e/bcyc3mUjhhfTotmHReQ/mg/U3cH7O9W15jAxvGHayuAzxeFIA+ne4kshSXYPC6yYhwyvD8mc10O71vkeEh7ESNhdt28B1ySDvQ1B2SYAfLbr0IoP780wQFHI0W2obhn+Th1Oy9RwILniz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2026 20:25:49.2676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1829d1d-6009-42eb-e34a-08df48d6cc14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000DD30D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF84B7B0C96
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

Add device private THP support to migration in kfd driver by using following
work [1]. The implementation enables efficient migration of large folios
between system memory and device-private memory.

A benchmark test shows the migration speed got improved more than 5 times
comparing to current kfd/svm driver.

[1]https://lore.kernel.org/linux-mm/20251001065707.920170-1-balbirs@nvidia.com/

v2:
- Reset is_large each 4K page iteration
- Unmap the THP DMA mapping once as DMA mapping, at its real size
- Leave migrate->dst[i] zero when the source is not migrating
- Count THP migrations as HPAGE_PMD_NR pages in prange->vram_pages
- Implement folio_split and hold one svm_bo ref per subpage

v3:
- Do not migrate partial THP memory at CPU/GPU page fault handler
- re-configure compound device folio after it is release from core HMM.
  So, it can be reused by ttm as 4K pages.
- Remove SDMA page entry FLAG(9) setting at GART page table since
  not see noticelbe perofmance change.

v4: fix multiples issues from Claude code review

- Fill every dst slot when a device THP falls back to 4K RAM pages, and handle an out-of-range compound entry  
 
  If no THP destination could be allocated, only the head slot got a 4K page. migrate_vma_pages() then splits the source and dereferences every tail dst slot without a NULL check.
  This happened on any failed THP allocation, and on every VMA with THP disabled. The new svm_migrate_compound_to_4k_ram()/svm_migrate_compound_to_4k_vram fills all 512 slots and 
  copies them with one GART copy.

  Out-of-range entry in both copy directions, a compound entry that runs past npages now triggers WARN_ON_ONCE() and fails the window.

- Build with THP disabled: HPAGE_PMD_* expand to BUILD_BUG() without CONFIG_TRANSPARENT_HUGEPAGE. Define SVM_THP_ENABLED and SVM_HPAGE_PMD_* to control the build.

- Don't dereference the folio in svm_range_cpu_huge_folio_order()

  The PMD was read without locks, and the code then called folio_order() on its folio with no reference. MADV_DONTNEED, deferred split or migration could free or
  reuse that folio, which could make the migration window larger than intended.

  Fix: a huge PMD always maps a PMD-order folio, so return SVM_HPAGE_PMD_ORDER without touching the folio.

- Get svm_bo from the folio head in svm_migrate_to_ram()(cpu page fault)

  When a device THP's PMD has been split but the folio hasn't (partial munmap/mprotect/madvise, or a failed split_folio in migrate_vma_setup()), the CPU fault passes a tail page.
  Only the head page has zone_device_data set, so on a tail page svm_bo was garbage and svm_bo->mm could oops.

  Read it from page_folio(vmf->page), which is safe because the caller holds the folio lock and a reference

- Respect THP policy and check NULL in svm_migrate_get_sys_page()

  Problem: the result of vma_alloc_folio() went into folio_page() with no NULL check. The order-9 allocation used GFP_HIGHUSER, 
  which means direct reclaim and compaction on every VRAM→RAM migration (fault, prefetch, eviction). It also ignored MADV_NOHUGEPAGE and PR_SET_THP_DISABLE.

  Fix: check for NULL; skip THP when vma_thp_disabled() says so; allocate with GFP_TRANSHUGE_LIGHT, adding direct reclaim only for MADV_HUGEPAGE VMAs; Compile the THP path only with THP enabled.

- Reset device THP pages before dropping the svm_bo reference(race issue)

  Problem: svm_migrate_folio_free() dropped the svm_bo reference first, then reset the 512 struct pages with svm_migrate_clear_compound_pages(). 
  If that was the last reference, the VRAM could be freed and given to another range. A new zone_device_folio_init() on those pfns could then race
  with the reset, which could wipe the tails of a newly created THP.

  Fix: reset the pages first, while the folio still holds the BO alive.

v5: 
- Rebase code on tip of amd-staging-drm-next branch which is based on kernel 7.2.0

Xiaogang Chen (3):
  drm/amdkfd: Add awareness of THP of device and system RAM in kfd svm
    driver
  drm/amdkfd: Do not migrate partial THP memory at CPU/GPU page fault
    handler
  drm/amdkfd: Enable HMM device-private THP migration in KFD SVM driver

 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 642 +++++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 125 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  30 ++
 3 files changed, 732 insertions(+), 65 deletions(-)

-- 
2.34.1

