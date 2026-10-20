Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50228606A31B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 05:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tgtbJKOx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD2BC10EB66;
	Tue, 20 Oct 2026 05:29:24 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A8BD10EB66
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 05:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlS+V8KDKW+w+hlJ3SRWoOvETPqb2LNTQPU6kAM7KNSu9mzUdxEMgr0DTrIZ8gKRN468jp+IaH76NEQuOHcu8hqGwbnfDU3jn06kB662fJbwPdu8S8qHUdqYkdyFtjqEKCNnA5TDXD4JuItvJMjCidbrJiiQrV+STHMiUiaZDFC8P4PmMQyLjQe6o6lEYAG7Z+ydvXg7d3m83ixi5ZBYEE2tf5eZyQs62pz1g3NVdFyA8TRNTV5bGxSf1jiZmTzeciCMLhKHqGQAa6rWhj6n0enyFwDhzxTJhtsPLXPpWJZetUfGLYWCa5IR0SCmiZCq9bc9LRTPcIio6Nm5pftOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bP1fRFKyo/9qfaX8RayWpesWE7UUWkJpKZUERH8L4u8=;
 b=vmj/GLkGCsMBq/hodPbEjSVRCfovB7IYqxBEz2757dA/gR7TL12KBhSgrQEGEGXdPp+Q9XCJoD+eRNYZZy5/yNYsTfRNC/70nTiA5N7rSWbgupLfIibGiCZwif2FPA/UbuPCnTGlfNA4KDdaDwasYmAO/jTCXMWrTEv5vxFexnBT03Zh8xiYzALcu9hTLhGm0/uQdzshIOQUQSVwbs28/gKkhrFOBncFun5c8F9dp0XAjVhNJIqLtdxIBeEpr2a1U73o70foCYN/NVL66zOVNpibQUsVmO04pBpE7MGjOteXVUsGMUySXb2EDjg3qqWyZmy4i5asN26Ht3KDF2lSug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP1fRFKyo/9qfaX8RayWpesWE7UUWkJpKZUERH8L4u8=;
 b=tgtbJKOxGkQw6D3o5doupsi2WYO4snkEhbf6Bbj9U4Q0HHoqdPP/ONALlXLBMacOPTpCB2A156WZgtjgtoBRRyXVZPDEW8Xy6oH7yWmXHcvNfzvGqk6cmRnHvQ151YHGYYmhCnqeJBVEnPtyKHaaQMAbVkLWV4ry82Bl43bAd9o=
Received: from BN9PR03CA0755.namprd03.prod.outlook.com (2603:10b6:408:13a::10)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 05:29:13 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::53) by BN9PR03CA0755.outlook.office365.com
 (2603:10b6:408:13a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Tue,
 20 Oct 2026 05:29:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Tue, 20 Oct 2026 05:29:12 +0000
Received: from danielhuang-HP-EliteBook-845-14-inch-G10-Notebook-PC.amd.com
 (10.180.168.240) by satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Tue, 20 Oct 2026 00:29:11 -0500
From: Daniel Huang <danielhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Daniel Huang <danielhu@amd.com>
Subject: [PATCH v3 0/2] drm/amdkfd: bound SVM mappings by the GPU address
 limits
Date: Tue, 20 Oct 2026 21:28:59 +0800
Message-ID: <20261020132901.23157-1-danielhu@amd.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a72e6a-8f2e-4d41-1cc4-08df2e6b1334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|56012099006|11063799006|5023799004|261009223027099003|10067099003|18002099003|6133799003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info: UW9jsQPKN0KSoMUhI9Ao/QVpmF8S0QtdRZwl/zFK1n8DWPA5p1SlJE3ACrhOhsoPr8bRYIkh+5GgIxFOJrF8UjmxlSVY4tkS8oIwSQz3MBAN56GxJn5iTAmnjJ41ohcNv6Qn8vaWhQNuvJN3ZyWQsOQBzxtFcmBxwlZF8OuOHcE5wrOgJNd1JRuOppG4u2NpX3mT6myuShKFRDWNce4Zz9p8165rb1+TZjEFipKWUndPESuLY/4gEyJqE1lnyOtOsKvAGpVykQFDfMmB6GWsFhR0yjpRMc6zjEeRiQSNh1OKAEYW6NH0QVIc7i2vjrWtTPSLjVOaUc6WWWwNOKTJwcYoAODBp/HI4bs8B+ij1SqzYqiuTz783z3BHCA+IFiR2wPdBsG1Ij0Lfz9aegt+5ksyW8Y4SjvvMNqX1Gtc39NLC8hg9k21EgE9T9AlCxtGX/ZGvCi/Sr0nyRK3Bqgs8C57bYhLZsdqAXz0ZtIbiWR9Pt3+03GBc7z0fA/0eZpg5Q4siKEC+xBzvBWiwNjVZ/ef+rTjcM4BKPrzp3wIJHhoK4Fh88/TZNoNEjUBlnGHLAjmqHcny1AV0AoaOSmL9h2sCui8DgrtJ6OX+ztQlumTF4xR2ZzRgVmmDDG11UUDY7WtFoMR3YadMcCiBjAX4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(6133799003)(3023799007)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4QmT6+6NvcSOrxRXMwdGj6MIWpE84UTRhWCMTCC+E1Z1FsKLO8UJloePrdpr/19jm/ztzm9CfqsgXLKjso67sdjl5g2iaQ/Raj1g9D8zKU+S0fi1KUK6PBCxRiHCf+bcjhWGGMH7CDHC3QQoqOwNqmzGWWHrOHKX9qlQT8MYDRnTx4qaeTL/8SVGjWwCKqDwb3PbHoyT6l3s0tZklh+pvR9FW+c1BSoW1H1R6wLnZFs1737xWbFj+BkcG9iKETVasFv+UMxWl640n/wBYErWjWwb2i+R1AgO5crhjeLWQ7vc3zJeAbBtQscS5Y83VC3WlAbUOk0cZAWlU55ZK0lpN7JVyr5GyyTmRQvwP6aDxp210vMufYrblBtJOkVO8gXhvCxXToC7nXPvRVLZejw666dicWYkO7b5J6kFgCK3Gtut0N0cwsXZsYC0wpPiEGBF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 05:29:12.8036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a72e6a-8f2e-4d41-1cc4-08df2e6b1334
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
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

Three points in patch 2 where I did not follow the suggestion exactly,
flagged here so they are easy to object to:

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

- One late check is kept, the hard -EINVAL in svm_range_map_to_gpu(),
  immediately before amdgpu_vm_update_range() walks the page tables.
  With the creation-time validation in place it should be unreachable;
  it is there as a backstop on the exact path that produced the GPF in
  [1]. Say the word and I will drop it.

Note that a process wide minimum makes a GPU with a larger GPUVM
unusable above the smallest limit in the process, even for ranges that
only that GPU would map. Given the 4-level, 48-bit uniformity noted
above this should not be observable on real systems, but it is a
behaviour change and I would rather state it than have it found later.

[1] https://github.com/ROCm/TheRock/issues/9302
[2] https://lore.kernel.org/amd-gfx/20261016170546.88570-1-danielhu@amd.com/
[3] https://sashiko.dev/#/patchset/20261016145129.69645-1-danielhu%40amd.com

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
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c      | 44 +++++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h      | 23 ++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 11 +++++-
 4 files changed, 76 insertions(+), 6 deletions(-)


base-commit: fe9f3ed36c83dcc24b4ca3e8913edd6e33a89150
-- 
2.53.0

