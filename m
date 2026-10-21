Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A58606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 01:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mOnmzxar
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C60C710EC2D;
	Wed, 21 Oct 2026 01:59:28 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65CA310F87F
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 01:59:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBstsziBzQyhb2dTSHP+2d1SdmwZqXNbNlRY33OAadUgemjnLupyrntmRgYyiIcoNglG6LutSvo38tzCF8mH+CyevzOjhVha1HCmBEEC5YxWot0Bm7tfAY/8KtKDep9E1VRwT2yFg39k1CB17dwZc9WAo5o46hgwOWJ+1fG4dHZbeSQEsx3+9YLeRK0kb4hVG/8hrcICOylOB5+XkTqJ69TsH2ishw54kTy9PesqZvOB8J/09BmX1wd9O6EHSgGhd7qnpKb30m25zT6RY1IWTkx2OlQ7PI4rYmluYc6EFmbWqlFoqNYPBZoCqRV3dlCttFiVASQDEjxX1kYqte0YWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwfNAekHBUM9/4L5kIOqeJ6J7sG0mPGgkjvUOBfP+Yw=;
 b=pS1dfOdf+i3f+8RyPAuf4pkxG8f3nf6W9yix9WDRqAhcRCnIb90eIh55tTscX7M4PZPLBBnJPtX0565IsMplA2VxhyXlELJ1HncmzLqlztri5+f3i+/P+I9erK3grEiPcgHw+n6swYmEUes0RAzfWBoS8Z+jNlxB+MTmrbCi4CfXYG0+yIgNz8dSyHwwnXRiR3UCtE3ZQ338PyVtjPh+dmqe8LDR3mJKOAP4n2HmQbHPaIqDE/4qQOSZkTXW+Dr2scgbyiTf+wNsGSZS8XAOel6Ad+26w1VFDOyioijosak1hCArHOz7+bSOkEG3SitapAKWnNvgfwuQ345skPvBqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwfNAekHBUM9/4L5kIOqeJ6J7sG0mPGgkjvUOBfP+Yw=;
 b=mOnmzxar9qRHmzInaUkb0uhx8hIdkdCNr7QN8gO16ikgSMfSfH94pRQU4TtHVNaUF1eRxpV0vWoKuQGSe5kknFYISlq3ALkUrpNGghutAIDVxb2fC/9sDCRuy0EEYUkwRXvX3AbeyubX1VnlRm+B4l3ZbKUE0qVN+LPnh0YCnjM=
Received: from SJ0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::13)
 by LY0PR12MB888806.namprd12.prod.outlook.com (2603:10b6:404:234::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 01:59:19 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::92) by SJ0P220CA0029.outlook.office365.com
 (2603:10b6:a03:41b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 01:59:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 01:59:17 +0000
Received: from danielhuang-HP-EliteBook-845-14-inch-G10-Notebook-PC.amd.com
 (10.180.168.240) by satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Tue, 20 Oct 2026 20:59:13 -0500
From: Daniel Huang <danielhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Daniel Huang <danielhu@amd.com>
Subject: [PATCH v4 0/2] drm/amdkfd: bound SVM mappings by the GPU address
 limits
Date: Wed, 21 Oct 2026 17:59:04 +0800
Message-ID: <20261021095906.48630-1-danielhu@amd.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|LY0PR12MB888806:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4fcef8-9ab7-4c59-ab6c-08df2f16ea55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|5023799004|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: AMFTrQSdDY0mDKdTM3LtGUlvNt/8Q9OPlxyX0hXS92YrK3cWSKQI2BqVUSPJZZ8IExLFbviuArsZeROHcdwspHs5Xfn5LMUtkyONoEeNGccktTrwrwW9/2kbxfjzlQJE/CwvW2H+RD95hMROzsPDIk2WTCrzpU1cXYlJbURwhaomwQxTXitrh0Mp9Hp29PluXK3oRtMOIUQmscUbtCWq24g8Be6MCwwG2dWdMTN2QOVZgxEtrg0iqWE2RIPfftJ1cBl4/SqJgBF7L3OIWTaHkNqLCZA+0Dp1EE3o8ESSF0+Hzgd+SJ9CRaNLi9Zq66OhI4XeWgZ5YgYs6qDg1sSkC0UxtsS63YJRCPFP2G4haZwXiq9kHitrCPh2L1NPBF314uRulPigk6X84DkXFWrOrEa+gzJgRrbO0gIbaoh64ShAH5PEvh7LxoP9UlZmO0RinVxtH55OW6D8UYNtYacYVn0510dJ3X3puHoWjlfHt/T5ddX0KenkIOtFekVuZl6aVu4LQRdAc8GUEENxdoRSAx9DIFJ/06mO0J+I0GwaqiKIqTcCoViZZQe8swTTV8wTEs6Mp65Vl8CDZj2aJc1sAppYq7+tgBJWnJ/Y9xAXUcxtp1ExIyYjaOPPuHk2PYb1qCKy8zfaKBCK6I5AP+91Yg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(5023799004)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PKf5rlby035Mie5zN3xTU9YYwCwU/nJTF2oIcmk4AoTjmHNtbAh0ibnyF3bGV0oLGm7GJtUcb7FTpOORVIxNUimH15muLEFuMMCJ/Sbd9qn/Cf4K9sOgxPUX3idNiyjytUZM5svHAQX53dN9XZk+DEif/k1pFuxEbMror+IeqAVjP6zgtj1nMyp4wfnBMsudj6wLHZZjX5E51IrHxdr+XfWGG3+DoNlsDxEU3VWBYX8SRiMZbYIJJpn6RN0ZWy47w0L6TIHpr70Fi9UhZ+UzB0N7S34hDnGFY8kor+pqx4zso5d6dsFaG0Kvhwn97d6b8r3m7E/FobRUD7LJQCF4BOMUw3OzneOKunbz5ayYiV31cWFAy2G+qeXD4SomwLmGIAgzRnGqqvL1mQRAg7fWPX84CitSDZ0DCFY1TVBgOmlvmS9TVzIyHFmy6z3gEs/Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 01:59:17.5888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4fcef8-9ab7-4c59-ab6c-08df2f16ea55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB888806
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
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

KFD SVM maps memory in GPUVM at the same virtual address used by the
CPU, but no code bounds that address against what the GPU can actually
represent. kfd_ioctl_svm() validates only page alignment and a non-zero
size, and svm_range_map_to_gpu() passes the PFNs straight to
amdgpu_vm_update_range(). The BO mapping path, by contrast, validates
through amdgpu_vm_verify_parameters().

Patch 1 is the crash reported in [1]: with an explicit amdgpu.vm_size
override the GPUVM can be smaller than the CPU address range, and the
page-table walker indexes past the root page-table entries. It disables
SVM when the GPUVM cannot cover AMDGPU_GMC_HOLE_START.

Patch 2 addresses a gap in that check, found by the Sashiko AI review
bot [3]. The comparison is against the GPU's own address hole, so on a
system whose CPU address space is larger than the GPU's it succeeds and
SVM stays enabled, while individual addresses can still fall outside the
GPUVM. Every current GMC generation uses a 4-level, 48-bit GPUVM except
one gfx12 variant, so a 5-level paging CPU reaches this whenever
userspace passes an mmap hint above DEFAULT_MAP_WINDOW.

Changes since v3 [4]:
- The late bounds check in svm_range_map_to_gpu() is now a
  WARN_ON_ONCE() instead of a silent -EINVAL (Felix). With the
  creation-time validation in place it is unreachable, so it should
  assert that invariant rather than pretend to be a runtime check. I
  kept it rather than dropping it because the invariant is maintained
  by three call sites in two other functions, and a future range
  creation path that forgets the bound would otherwise reintroduce the
  out-of-bounds page-table access silently.
- Picked up Felix's Reviewed-by on patch 1. No other code changes.

Changes since v2 [2]:
- Dropped the Fixes: tag and the stable Cc from both patches, and
  dropped stable@vger.kernel.org from the Cc list of this posting. The
  crash requires an explicit amdgpu.vm_size override, which exists for
  driver testing rather than normal end-user configuration, so this is
  not a conventional bug fix (Christian).
- Patch 1 now states in its changelog why GMC v6/v7/v8 cannot be
  affected: kgd2kfd_init_zone_device() returns early for GC IP versions
  below 9.0.1, leaving kfd.pgmap.type at zero, so those parts never
  advertised HSA_CAP_SVMAPI_SUPPORTED to begin with and the new
  condition cannot change their behaviour. Thanks to Felix for
  confirming that KFD SVM has never been supported before GFXv9.
- Patch 2 rewritten following Felix's review. v2 checked every range
  against every GPU at map time, and svm_range_map_to_gpus() skipped a
  GPU that could not represent the range without reporting anything to
  userspace. v3 instead determines the smallest GPUVM among the SVM
  capable GPUs of the process in svm_range_list_init(), stores it in
  svm_range_list, and validates where ranges are created.
- Canonicalised the Closes: URL in patch 1; the previous repository
  redirects to [1].

Two points in patch 2 where I did not follow the suggestion exactly,
still flagged here so they are easy to object to:

- The set-attribute check went into svm_range_is_valid() rather than
  svm_range_add(). svm_range_set_attr() calls it immediately before
  svm_range_add(), it already takes (p, start, size) in pages and
  already computes the inclusive last page, it runs before anything is
  allocated, and it additionally covers svm_range_get_attr(). Happy to
  move it into svm_range_add() if you prefer the literal placement.

- svm_range_create_unregistered_range() clamps rather than rejects. Its
  range boundaries widen the fault address to the granularity, so a
  fault that is itself in range can produce a last page that is not.
  Rejecting the widened range would fail a legitimate fault, so only
  the fault address itself is rejected and the widened range is clamped.

For the record, the four paths that can create an SVM range are all
bounded before the WARN_ON_ONCE() can be reached: svm_range_set_attr()
and svm_range_get_attr() through svm_range_is_valid(),
svm_range_restore_pages() through svm_range_create_unregistered_range(),
and CRIU restore through kfd_criu_resume_svm(), which builds its ranges
by calling svm_range_set_attr() and so inherits the same check.

Note that a process wide minimum makes a GPU with a larger GPUVM
unusable above the smallest limit in the process, even for ranges that
only that GPU would map. Given the 4-level, 48-bit uniformity noted
above this should not be observable on real systems, but it is a
behaviour change and I would rather state it than have it found later.

[1] https://github.com/ROCm/TheRock/issues/9302
[2] https://lore.kernel.org/amd-gfx/20261016170546.88570-1-danielhu@amd.com/
[3] https://sashiko.dev/#/patchset/20261016145129.69645-1-danielhu%40amd.com
[4] https://lore.kernel.org/amd-gfx/20261020132901.23157-1-danielhu@amd.com/

Per Documentation/process/generated-content.rst: an AI coding assistant
was used throughout this series, as recorded by the Assisted-by tags. It
diagnosed the fault path ordering that determines where patch 1 emits
its warning, designed the creation-time validation and its call sites in
patch 2, and drafted both changelogs and this cover letter. I reviewed
and tested the result and take responsibility for it.

Patch 1 is tested on a Radeon 780M as described in its notes. Patch 2 is
built for CONFIG_HSA_AMD_SVM=y and =n and otherwise compile-tested only;
I do not have a 5-level paging host with a 4-level GPU to exercise the
out-of-range path directly, so review of the bounds arithmetic would be
welcome.

Daniel Huang (2):
  drm/amdkfd: disable SVM when the GPUVM cannot cover CPU addresses
  drm/amdkfd: bound SVM ranges by the smallest GPU address limit

 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  4 +++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c      | 43 +++++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h      | 23 ++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 11 +++++-
 4 files changed, 75 insertions(+), 6 deletions(-)


base-commit: fe9f3ed36c83dcc24b4ca3e8913edd6e33a89150
-- 
2.53.0

