Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A61E606A323
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 04:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jPZV8llY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 344E410E7B6;
	Tue, 17 Nov 2026 04:21:15 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 079A410E3AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 04:21:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6XLXzxn984wfbHbXIMIRaYBOioXRVn85ME53e5JGvPz2InkivfXhjaCNdBTZDPLTOO3nI24KhJ6RQqrb+nipaQJ/qh0z+Q2CJ/lhKXbRNgTUOau+eGqgBPu/89OI5B4dO4xsqt7EHR6yP6Q0DJJY0LV0rou3zGBpGYf1u0jJ1o1OZA4pNhtK8Ce/Gy+j1X5NTVNtc0Zm583/6XmkVx5PodnsSIAlVEOIziO7wk9Fv6yRc3fh7k5RRhwDR+RGhGObUvJ6ywnc+E1tYwXpHnyquspR9t4Cq3UyUumkPsuGQL+eeVUGtFDwCz2l0d0MPU8xLIEC0t31YgHF0jHalvXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhBehEk7fya3jSvfxL7CdLk4tJdGffH3IcVAtqZN7AE=;
 b=WWaL22CnchLmcGLIY12NxkXxw8Z/lgO9MIbTleRQOgySbWIb2ntH56Y0Ar7goV0vFNX0iWtxHvVe0HWlHBGUY0dq/bRBWZM3HXK1DaidXcZbvDfHEdBw/y5LW7YkzeoXeyJTWI5wbBmOmyLrC12MHdRs+7Iin73mZJN8RchuWHOVg1AQqg30fLVwsbGCsiONfOLEDIfT5FGQfldYylBYH5y90BhB5WNfY28+s4bkgjQ7OLIob9QrGQj5af8+qu3et335A2HGdKWVdfpNvPmRnBDzHSNsqzWPWSAAJmIOiH2zvYAAyySA/nfteNQvxjr0tZ8cE6GdrLnTNUaqt4kMGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhBehEk7fya3jSvfxL7CdLk4tJdGffH3IcVAtqZN7AE=;
 b=jPZV8llYDTIueQGvhTyQZUTf8roe3orMpjU0Ag5FQ8aW6j0ixkr04F+8yBYm/yAKzJumizg6xR1NwSa8dCDxeoCkNy+we6aYp8mmP1o3MUWo8Y7KwCng0O+oc7/OtMfiOdXjKslr+Of0zEM9K8D6bYPBQArqkzyK48uuv7Ar9qI=
Received: from CH2PR19CA0015.namprd19.prod.outlook.com (2603:10b6:610:4d::25)
 by DM4PR12MB7645.namprd12.prod.outlook.com (2603:10b6:8:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 04:21:05 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::18) by CH2PR19CA0015.outlook.office365.com
 (2603:10b6:610:4d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Tue,
 17 Nov 2026 04:21:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 04:21:04 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 22:21:03 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 22:21:03 -0600
Received: from junhua-NucBox-EVO-X2.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57
 via Frontend Transport; Mon, 16 Nov 2026 22:21:00 -0600
From: Junhua Shen <Junhua.Shen@amd.com>
To: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Chris Freehill <Chris.Freehill@amd.com>, Kent Russell
 <Kent.Russell@amd.com>, Maneesh Gupta <Maneesh.Gupta@amd.com>, Denny Iriawan
 <Denny.Iriawan@amd.com>, David Yat Sin <David.YatSin@amd.com>, Huang Rui
 <ray.huang@amd.com>, Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan
 <lingshan.zhu@amd.com>, Honglei Huang <honglei1.huang@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Junhua Shen <Junhua.Shen@amd.com>
Subject: [PATCH v1 0/2] drm/amdkfd: honor read-only intent for userptr and SVM
 ranges
Date: Tue, 17 Nov 2026 12:20:49 +0800
Message-ID: <20261117042051.768201-1-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|DM4PR12MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5801fe-41c2-4414-6b6b-08df446231eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|261009223027099003|3023799007|13003099007|11063799006|56012099006|261102123227099003|261026121527099003|261021123027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: mK1sg5uUKrWhu2hBhlXVZgyJC6km0NJp5QAiZDihTtvEGgE3JCcRhGKeg5XqERZVxn2UkS80VKbTUlsZm/4cSKdF27hn98pHG/sZFiod4JZLUTF+lSJ2gU4T8C6ErSyv/b2Wsg4AgyPpPBDEzAzyzXWN7Q3WL2qIrriPJgXxp8K/fLtdFxgDy0pIbx/ricg5iluE+BmssP7aubHgFV6R20V+seJ0bLzUNWoaM+6SCiomoT9y0JHp4jb0ca8mmwQ+bK6wqj32Rry+rzB5ujUT6Mgp/LNzmIQbQm96iEGfb6CyA1fy0HEHXVeo8AXeJrucqxAhOqysiKOVvD3qR8mWQCu62MNP20MZHyq/tm+jGQa0VeaPNZIBPFlykFyZ4jZ7ghwuh1AEQqGdwFXu6oxvJW7Wf9IlvSXuK9xWp7P094EbrQfCl0UsCOFvivvMs/iAGvSIvdVJNpCGoxcVixTM+EtaKqi6PZxelekuccNyI3NhdRIw/nVyrBtdVGOhwVy4wbLBcIge6HpEGoIA7sqQ3PLG/2izUxCYTeGtbD+YO4wc/Ggiebrbrf9+qQN/hYam0nu2VVBv+sKdzGwoyanojhcNc7NWxt63C8LMFs+pu+quNmv+BVCV6dPUxrA3mstKMFPeAwlS/hDMv4E9190tlng3t7viTVv5U8Nrb/nv1hf6pAAXA6jCr3DpCyGAF3zgmWVm4I5VbEi4FiyVgLZEkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(261009223027099003)(3023799007)(13003099007)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261021123027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LDDttmSQKM44CjyVmQELlDPsLnBMfSFVThMyIRw6NsI4YWuvbLrHNd768WOMjdh5/79N+6pRKNMft466Gq8sMwgrUodm7BG9RcrvjkmMDdVBglRfvxrP2uZAQAfTZbPOev6Aj+XMs64K0XHRj975j3pd2+x+Y84BdMiN7BNp7U6sYpKvBmWRJ4Iw655Q+Q0UiN6nYYe3KElT2XmoZhfC1GW704ZCyKauxf5vB5Hiksk1nQPj8Tjlcx7I0mQxg4nURD0MRjIyze5kj/SKC1b6I7B/zbrCp6grGtYsJRCRkmgM3ecvR6PmKA1Z29UEqdtztqkt7/cw4Tt0l8d84teTfA14/IXP+3F8c4o5C8NCANtgSYysFAcrZ9/aaS+z/wrSIfnFZdMxX6pThgQdO7liGqmM6asbUNI5dJRsSVirrHkFoz492bPkxby0AVVHxhKE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 04:21:04.4247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5801fe-41c2-4414-6b6b-08df446231eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7645
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

KFD records whether an allocation or SVM range is writable
(KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE for userptr, KFD_IOCTL_SVM_FLAG_GPU_RO
for SVM) and already honors it when building the GPUVM page table. The
userptr registration and the SVM mapping path, however, do not pass that
intent down to the HMM fault, so hmm_range_fault() is asked for write
access even for a read-only buffer.

For a read-only buffer backed by a writable private mapping
(PROT_READ|PROT_WRITE, MAP_PRIVATE) that the GPU only reads, e.g. a
host-to-device copy source, faulting for write breaks COW: every page is
copied into anonymous memory, which doubles the footprint and, because
the copy changes the CPU page tables, fires an MMU-notifier invalidation
that evicts the GPU user-mode queues.

To keep the GPU mapping consistent with the requested permission, this
series makes the HMM fault honor the same read-only intent:

 - Patch 1 (userptr): register the userptr read-only when the allocation
   did not request KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE.
 - Patch 2 (SVM): also honor KFD_IOCTL_SVM_FLAG_GPU_RO instead of deriving
   read-only solely from the VMA write permission.

This does not change what the GPU can access: the page table already maps
a read-only allocation without write permission, so a GPU write to it
already faults, with or without this series. The series only aligns the
HMM fault with that page table and drops the needless write fault and COW.
A buffer the GPU may write must still be allocated writable; there is no
in-place upgrade, so making a buffer writable means freeing and
re-allocating it.

The user-space side that marks such buffers read-only is tracked here:
Link: https://github.com/ROCm/rocm-systems/pull/15545

Junhua Shen (2):
  drm/amdgpu: map KFD userptr read-only when the BO is not writable
  drm/amdkfd: honor KFD_IOCTL_SVM_FLAG_GPU_RO for read-only SVM ranges

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)


base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
-- 
2.53.0

