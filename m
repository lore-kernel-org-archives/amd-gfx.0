Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B4560A3804
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZZzRB7LK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD5D110E358;
	Wed, 18 Nov 2026 23:10:24 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2816710E358
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 23:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkEMD9VIssGrnghbi9JPa76N9O6m2yLSsCr+TOV1X/JnnYRDY7scuBRa7uOPCXoUKyHwR72gULrLaWr5PFPaxsrNFHS1QW3xlOt5u+UDLU2Cu41wdB2W5uv5VwwRVB6OSBecX6P1JHQRFEs2XPneatjaB14eKczfWz1W1VM8xgTA4R6ODkWnCBFoh0/7OYNtbFUmCx0n5gZ5gaFK2JIl31uhz/u11t2OZ9KIQKzIFGaZnGGmBfgZVw0Q0suiSBFo6gm0nsh1Mk/4/Go5/6SEjfhAcm/uBGT4iM1HszW28Bdkv9YAj1YSjkivf9IsmNVmdf2P8pVuZl/RjL72yfNbOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZH5+SpwFc43ud9F7Ynm86xMg2gLtxoXs8xSvB4n2hw=;
 b=BCfpBipc3114dpdsJ7iv+PfHfG+N+wa6Mhs7It9ceNx63pXBfxiamlZI5B1rAiWTvDtenTK8tYq+RjFA/Tg4gF6nLn5p+iy0kaUk0Gu16cUy9BnoVZlkLHv73WAEndQs7AuenpSmpuD++30GjIoOvLlRw5IN1QhQwboEOxPDFLUmMTUuUbqyY6u2SOCVnICUJehJzwj6Jax48rygrk0uMV4Xow8VCLWMmkCl0jV0haMP4oCjyIFs8mpcYTYKL5v35NboRPED7nXnFdXeNjtkj01FGQYpCBCqey89ippuETCeT39CUD8jpXR0FtmqHaqE3+GwhhlbP9OdWxWHIMhYYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZH5+SpwFc43ud9F7Ynm86xMg2gLtxoXs8xSvB4n2hw=;
 b=ZZzRB7LKRJ+/pUyRrJV6tRBzA9JsauqdqrTu1XnSPKxes8l275otk1k8GBQ8irLhRZsgto3QlAWbIGa0Ht4m7KDz9VvxjrUUXh3HfUWXkMkNYRlg37ikPc2SBO0Yqr6dkFd7opmrkhX2+yHYTNGwxScmrGkctb5DWwu10Fw+1Hc=
Received: from SJ0PR03CA0208.namprd03.prod.outlook.com (2603:10b6:a03:2ef::33)
 by DS2PR12MB9590.namprd12.prod.outlook.com (2603:10b6:8:279::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 23:09:59 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::a8) by SJ0PR03CA0208.outlook.office365.com
 (2603:10b6:a03:2ef::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 23:09:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 23:09:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 17:09:56 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57
 via Frontend Transport; Wed, 18 Nov 2026 17:09:56 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <xiaogang.chen@amd.com>
Subject: [PATCH v4 0/3] drm/amdkfd: Enable device private memory THP support
 in kfd svm driver
Date: Wed, 18 Nov 2026 17:10:57 -0600
Message-ID: <20261118231100.68176-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|DS2PR12MB9590:EE_
X-MS-Office365-Filtering-Correlation-Id: 4644449e-adbb-4e1f-57eb-08df45c910f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261021123027099003|10067099003|56012099006|11063799006|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|261009223027099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: ggX78D5PCcGaw7M91rmcAawWR/5g0/6HhikCA7FKGbgpf2ffDmyThBuxavpvv2l5D1wpEIxMQ9zxwWj+vlCrbcatTCVHSxwtsfrfu0ybmP1SKzYFMA6HLWLKr8EMRGpw+isYSopGDrwpotFwfcRCgQD9bGrL+GxMEFEQXe3fgB2zESpZDam2IqEZnr7TqKGby0jTxkR1BH+OUo5QAJKranFi2J6P12zZGWjgEKiGuqrNMtMP/xUgAnskyJe+PDjhyDVtrkQ5honJq6BhFqtuexThvro1EUoqFj6SQQXpwzksxT/nmD3qlkifOkEUD1TfrfcPqI5s/ShEyb5VJUj0HYUvf7cLghxCU1s8OvW9cQ0jsFO6clM7Wasz+9h5s9vobsxFLo1lL9LqE1SFCKZHj0nZBuAD8pC1hPOGzqFByyVb9yjjuFPSJQUYsyH3ZFXmsyOe6CH1XN9N4F98ga3FKNySwON5vmnssjyigT6YV0MVKEFxS3f6Dcb749iATGOVL8sicZW4XJtb8biFT7h5Uk+LkCQiw2mlj3igvfy3AFtFK70EmoJRYna2N1XcN9DglPs1b9rBqIxBiaEy3yo/SsYmHNCm4GvfqQNj7HyzTZVTAXcef4MfAejGEqFRc1baT5JEeKZuFbES08gdLbFoeBszORcelnGmp36b6CMIO6U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261021123027099003)(10067099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fIKQLtd+wo8A5dTZ8UzOwVlp4D/oxzrHhWoIxdR7Z8007LCNdY2dE2xbmbv6pnMqvMEhji+L+1JbqA3igblmGJT/I19vuUK8wKseOiEylxxnNQGRCq8HAJdFfOJnJ9Ncn1fGjLeXCCTreTJDRNf5o513EzE7miCtdimA0C8DgNqemLUy2bidklrILOlwgKEG88YkaOtwRMsnM/QO72hX/FfV1Zde2DTsDEq2jFNBxUBj8JhGvfJReX2jLP/GWtJFLrdHzX6+J6xC3FzxMZBA6xq5nv8yGhEcglCseHqu1232TdG9dSmBwQrlXhCGAdA1bDSzKQxUnSpZNpKSFSJVBmwRkdE8cA5b5WmatIS5+h0AAUzb+W1YT80bWuaY63hfr9c0dWoa3rXGtstmn2HZekEAtELtGevK4s7t2oNvHT1EINwqFxV9geF4pm7LGwdm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 23:09:58.3791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4644449e-adbb-4e1f-57eb-08df45c910f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9590
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

