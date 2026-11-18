Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BFE606A338
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hz4AvmvI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 761F110FF98;
	Wed, 18 Nov 2026 19:07:56 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010012.outbound.protection.outlook.com
 [40.93.198.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEE4E10FF95
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 19:07:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzBnjFyn4deP/2Cy4WmOP/uMD4iirXLaX2K8hC2yMKWzQoiaKPDeW7Bgs9EO1O+tEpBfyWj/2eBw5+FiENdcfBCMdx+PBBPj4oIvlQaowzIPp5aWOkdqYHDs9XjK/Edhn8ss+k+8ehir98fmI+uYfNn7pbrjdH02DesrxjqDYFpbx+nYuLzQeKlI5WiUxZaD2xUV7AGSHt/xIhyJxrX3W0i348GUgspDo5/GdRSeMlob3FZErAKHTKGhe9djlmbvRaNmnxngYEXFBgA6LFidIEu3O0MdHGOGSysJFcSvKq4+85B8WROArhem7zTiD7j8dcqKTFZalUYM/phtILnWKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJZUdDD4tMtX9zhPYPoXKi7YGsYkovNkdjdDRS9A4dE=;
 b=TstW7uDTsIu86AhqzG3uJNnQ4Nw/FMi47O/Oo39sOKHzttuiDdpqZbT0cynNNXbA2lv1J3uvAgcAo8lwyLGxAEiXqe8m1iyayvQ20bF4EZ/Tv7FEhxu+O9RxijgnR/7ZcNjkAwhEBGOQ6sk2tbLZTiU7xT0LcERp/JFyj6NkVrSTiFKysmuJVb99LyG/L7nmIrh3iQuRZKuDNWeAbdbvV1zygK+RE2M7B48bTqXgFl0t4uqedz34j+Wv9n85jCsA9J0YFiCRwSCQwpgrEkje7LpRXTX7hX3Wu2v5bMId0MqUDNtWfB5K5hKAIZFnpNvRi3dHgP9y/BIYHk0YknOq6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJZUdDD4tMtX9zhPYPoXKi7YGsYkovNkdjdDRS9A4dE=;
 b=hz4AvmvIjbFxMh1Pbcn+kiAMSSrwVilZggDovWDasJaM3CjdvHJcg/1S/cir8vXC2HN6v0WA4AUilHR1ZPMf+aJzEhJr4Xu7rndxxvdlMCkADuZU79KXDUY731AAZZxg8h0QsEyq1eIrtwopwkbUTL4CJ8asEa/U6NVdEYcvxis=
Received: from SJ0P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::19)
 by CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:07:38 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::31) by SJ0P220CA0015.outlook.office365.com
 (2603:10b6:a03:41b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Wed,
 18 Nov 2026 19:07:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 19:07:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 13:07:37 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 13:07:37 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v2 00/10] Consolidate and fix root PD fence resverations
Date: Wed, 18 Nov 2026 14:07:25 -0500
Message-ID: <20261118190735.1863676-1-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 2067e48c-becd-489e-a7d8-08df45a73643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261026121527099003|261102123227099003|261009223027099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: f/ruM4s1JhEkgzTHo0noz7VAgDT16xQLir8Jji27XmNYvrnuhD5SqcVp/bB4rSyw5ywMPwWCg7Iky/+SZjgGWE/vXt24tUsF5rPbEmnaCrxvoAwGZrcGSzJN+RnkwrqMZBRU1PG0+8SAXPVc7/8xLLQzsyGofKeu2EvSnXPflC+sjSwpo3r4Mrir8p4QsX1Jq1kY8uvrm1tnOmkVcxsiCJI+w9JNCOl8nih7eOzuYN3ueHft66NBErupCg2h1NFGqbjE287G2rLefjgKGmzvL/KAulpyYutCrXyql4+l15nGlZvaxRBNaznFaQV9oYGkYm08WDv9BNUda1SXR8bW81KtzUqC79ZaKDsHD+oJi9X0ZjcI0s0WmycWJeG1TMhKUbcW4vA5VifiSHR0EpO5YsNjAtPuTq054y0Xar7jSvk+FsmVcOmy12B8bZK4NF+KVKhcyP9EPE3rjG0Y7LDy4qz2Jax/G14XyNh0u/StCC30HbiRIUViWLbFBwTW33wXC2rVpCVxbXmfHcN56jvtaBDtS134xJ0AAyQaSHji+rs/0MIgskp2Abw4XkDWIPGgpBwAhOlVaHwpPC2sZg/ldbofowX8/n7pcJutXMRboRJVTKasEQdsaF9eqRx+7l1PF7w3mTuoYoIumjjR2+lFgADBWtie286MvtTv1FErwAg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ulMBplBIRYcszu3T9JOswbBEV5jJr5cFvbhDnX5XdCTE4CnQwPvz12M5+aU4g5fl/03ARTBF2EO4Pa90s9WZFuAhRf2u5H4GYQgQcvpkpiBzpAQQqmNM7Zv0Aj5NijfrQ5GUv5LMefiToiP7DWJ9DpyzpayM2ZI5xDd0nrlQU+oa9ghrBfb20h6LgGYZOWe8/K/vNM4w5fi8AYKdZAV9PFd+RCBoXqNYahppBvGfodTlSsnEg2YNqnzA8Yvt+7YQN8wfaDx6/vmWj+NU5ZiPKe+uyhQmgnhshaUlyGofJSNiCYoZ5ZQGhPC/lEas4+Bv+gOqypuhasGWX1tRD8sB7wxUFieVoYYhUYOg71Gb7ljEnMCXbHPKRVhy6PhYGUxp8xZ4ocnCNShtqCoDHrMueetsbocGisvuiFiiWzUoo3qrkIVoVDIRyHonL3hX5whV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:07:38.0955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2067e48c-becd-489e-a7d8-08df45a73643
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595
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

In [1] I originally wanted to just stop using amdgpu_bo_fence. However
while attempting to address Christian's comment about reserving the
fences upfront when the PD is locked, I realized that there are many
places that are not reserving enough fences in the worst-case.

I went through and audited every lock of the VM root PD and I think I
have caught everything missing fence reservations in this series. I
have lightly tested this and didn't see any issues, and in general
this is reserving more fences than the typical case so it shouldn't
cause any BUG_ONs.

Patch 1 is mostly an independent fix. It is not related to the VM root
PD, but follows almost the same logic as patch 2 through 5 below.

Patch 2 through 5 here are the reservation fixes. Basically since we
started enabling more clear/move entities to be used, we should be
reserving the worst-case space upfront. Also when the TLB flush fence
was added we did not add reserve space for it.

Patch 6 and 7 are cleanups that I found (not everywhere locking the PD
does validation or VM updates), and patches 8 through 10 are the
amdgpu_bo_fence() removal series from [1].

[1]: https://lore.kernel.org/amd-gfx/20261112164408.1748006-1-benjamin.cheng@amd.com/

Benjamin Cheng (10):
  drm/amdkfd: reserve TTM move fences
  drm/amdgpu/gem: reserve fences on the VM root PD
  drm/amdgpu/vm: reserve more fences in amdgpu_vm_lock_pd
  drm/amdgpu/dma_buf: reserve AMDGPU_VM_UPDATE_FENCES for move_notify
  drm/amdgpu/vm: reserve AMDGPU_VM_UPDATE_FENCES for handle_fault
  drm/amdgpu: reserve only what the caller asks for in lock_pd
  drm/amdgpu/userq: remove extra fence request when locking PD
  drm/amdgpu/vm: stop using amdgpu_bo_fence
  drm/amdgpu/uvd: stop using amdgpu_bo_fence
  drm/amdgpu/object: get rid of amdgpu_bo_fence

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 16 +++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 13 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 25 -------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    | 12 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  6 ++---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       | 17 ++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 14 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  8 ++++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  3 ++-
 14 files changed, 68 insertions(+), 57 deletions(-)

-- 
2.56.1

