Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA47606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KLlfFJRK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B96B10E496;
	Tue, 17 Nov 2026 18:20:00 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8976B10E623
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 18:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUesVIF311sObxFb0/i5BdCCrxt+RExG3i1LB/itfEo8Fz8/C6YDfTHoBezrxfJU4Kz4ThEZ4p6ovB/xWmVFKC2IoTViNcZNyT/6/NtB9xjQvSA+d9YUuVmGcVFcmiHZIzDlwE33ZePnSbS3P01AGly3ppGraXQ/biGDJTW4A4HxiD50N2dVQh3XY8QP4sMlfqI9v1+ZWGp3x4cx/D7gGT91sSXtraQtqUMPZWiwzEjNequiSYPIeqlb7RrclFP6eCBz+XgROfZpVyNMMqRMMXQV+0e0ok+9iaToIaXs96BRdnzsB8h8AWM54oWp/nzd3uL9KuZ9iKJ8YbY0ba+ASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Knn71qAPN24vfycOevbR/5TK8yx51wJfGHsIS5qA5UA=;
 b=BDFtKQ1vNI3GXVUf/8YNyTRwB7Zfm7h+ctI2am077zHsGYsmbsg4Pg5DQ9IgnMSv7hNrZ33BdbbID/nQfvynomalIGP/55CH/8+WPme2xQouOc+mpVRk6M9lxy7aAWpw5LPcBGORUtOXwHwUneqxy+vv+g1LLfJyFj4OKCQtwNM9iQip2Yo4R2TSiWqLJv/hnCYjebH8M5tqScsTmfWP7L9rVZrbHtegv/n5+3X2zSarSzBE7tvANnoLMzDGjAvJIsBk3w54nsIyVtjfRcIOJv6d8y/Pj2/Fpr52XQDV2bK9I/tYDVIG48wadAYTp/6Qt7l5udoVrvP3p5iUik2nsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Knn71qAPN24vfycOevbR/5TK8yx51wJfGHsIS5qA5UA=;
 b=KLlfFJRKP28U/fF2+eF34oRyhkvvYOMbHFFdK2S3RwYMsWOPrMaTMR+5wjgv0SFKqP7dMAAvnH0FRfSctO4R1jXsx//9wqA3a9xFa+505tQIHPhA3Il9UsAPCzrFwVSKPDHDbBwbiHS5EO5KEpBLUZ3cV5wE1cnRiTuMZHYTz9E=
Received: from BN9PR03CA0599.namprd03.prod.outlook.com (2603:10b6:408:10d::34)
 by IA1PR12MB6163.namprd12.prod.outlook.com (2603:10b6:208:3e9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 18:19:42 +0000
Received: from BN3PEPF00022BBA.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::56) by BN9PR03CA0599.outlook.office365.com
 (2603:10b6:408:10d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 18:19:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBA.mail.protection.outlook.com (10.167.248.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 18:19:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 12:19:42 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 12:19:41 -0600
Received: from work-495456.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 12:19:41 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Sunil
 Khatri" <sunil.khatri@amd.com>, James Zhu <James.Zhu@amd.com>
Subject: [RFC PATCH v2 0/3] drm/amdgpu: make the reserved SPM VMID
 per-partition
Date: Tue, 17 Nov 2026 13:19:38 -0500
Message-ID: <20261117181941.3968996-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117165952.3558762-1-James.Zhu@amd.com>
References: <20261117165952.3558762-1-James.Zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBA:EE_|IA1PR12MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e7ae2e2-f539-49d2-7a3c-08df44d759d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|261102123227099003|56012099006|5023799004|11063799006|261026140227099003|261026121527099003|261028144727099003|10067099003|261022105027099003|261021121427099003|261022113327099003|261021123027099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: O4hazMEOdm8xgGy3C7KgPvhlYW4IepXZ4XwuyjtPzEYZa18XaCKz2feiUj9r6LhyqI17OtistGPDUmwZXWvFtufPkpNwSRYNhwbfuqD+fOR8rV5PD2Ld70r2jn+JcdvyFDYhoTOsPlJjBZ5rRCZ9h0BYFOyoSomRoXo2wj6FjLyoNhl55SM4zL/8UtSD+sSNc21dJuQ4isiDT4kT4KEg1S6BCXoHgQysLhONp067+r1gUzyOq9kutgqRF4ET5E5f3MbwpSM7tj3s1+KZfOIdeLmSzV6Ckk0eSWvVzNWyhkEXx4R0HLmd0RRWxzr5T+KjD3Fd2OhPlVfmkaw6lfXlvGlixXsvuBnvSSn0fInIbN/FARaBh77mNiyN8TaZMUCPwbADeORcbv/qOngzCpN7fisSNjFYO+Mb5+NXfRbxH6lyC0vD7ZiZPWCMu3mhtjiM3LZaX07iwqpNYGxsZ/awaxNA5sTxH5rBweSJiFgdvuO/UA2GM0oKA1dySeJZOy1bZZq6ZxphWVfC8MkZwiVJjEFWqAc2k9S41/9OuMaNMlAI8OftVwL9W3JWIsPc5CbAOQhw4tTLlBU48RRlHUhl520vCsS00tKoBSsHOY46IxwWZyBxaxJzBMprwI+cNAOJN9PwbuuJYx3fsoR+HVAVERh3l5pEo81o4dh5Xe6mAk14qaW8d2RtkYZAql6h6Tbjho9/VWejHv3Jj4KsH6HaCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(261102123227099003)(56012099006)(5023799004)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261022105027099003)(261021121427099003)(261022113327099003)(261021123027099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZwL67OUujSrjWSWRFkXW6EtmTcTivfxMUXmINi/DRk98yz2uz2OQjP2Ig6MugGIZDxHfP6LK/YY0ZIXmJoZOk0LD30phsEVLjnPgkwJNOO2D3CljAQl9ACD/PWUxg99VqnRtp45aAehSnq1xcOSK+UZHSCbUetnBGmgyeiTUn5nnwD88BbCXJgp95z366aD9b2Opsc1fXcoDqAZI5e8qkXtdEb1DJP8mb95m1uf708odFQB2fLAHr3pinOFEBGaBakwdpwoRlHFaTsIEDMmzRwIQCy5pw/ManDgyOBT2TA3tJ5pL48HMjAlwbi4NHuMCCQJ//KIhJWcs2qSF13AmFfv59FFYiCI/bmiQTjBmDIHtp3q6VJuJYJXPKFkrh6CAKlypkbg/FAwvBFdOcPUC566hkIvuT2KsbIwy2nPwrxw65UNHH2Eax6688mLCdI/c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 18:19:42.5163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7ae2e2-f539-49d2-7a3c-08df44d759d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6163
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

The reserved (SPM) VMID handling was designed on single-XCC hardware,
where one GFXHUB is all there is. On multi-XCC parts with partitioning
every XCC has an own GFXHUB and every partition is exposed as an own
render node, and the current code is incoherent in three ways at once:

1. AMDGPU_VM_OP_RESERVE_VMID records the reservation on
   AMDGPU_GFXHUB(0) only. The VMID grab path checks
   vm->reserved_vmid[ring->vm_hub], and the rings of XCC i use
   AMDGPU_GFXHUB(i) - so for any job running on XCC 1..n the
   reservation silently does nothing. A debugger relying on a stable
   VMID gets one on exactly one XCC of the partition it runs on, or
   none at all.

2. The physical programming goes the other way: the setup_vm_pt_regs
   gfxhub callback broadcasts the SPM VMID's page table base to every
   XCC of the device, including XCCs of partitions the caller cannot
   even submit to.

3. The exclusion is device-global: because every reservation contends
   for hub 0's id_mgr, one partition's render node blocks every other
   partition from reserving, which breaks the isolation the render
   nodes are supposed to provide.

None of this is visible on single-XCC hardware, where "hub 0", "all
hubs" and "the caller's hubs" happen to be the same thing. gfx 9.4.3
partition modes are where the three diverge.

This series makes the per-hub infrastructure, which already exists in
the data structures (vm->reserved_vmid[] and id_mgr[] are per-vmhub
arrays), real end to end:

Patch 1 exposes the XCC-masked setup_vm_pt_regs variant, which gfxhub
v1.2 and v12.1 already implement internally, as a gfxhub callback.

Patch 2 makes the hub argument of the binding path mean what it says:
amdgpu_gmc_bind_vmid() programs and flushes only the given hub,
amdgpu_vmid_free_spm() unbinds the hub it frees, amdgpu_vm_spm_update()
binds every hub the VM holds the reservation on, and the ioctl reserves
on every GFXHUB instance. This fixes 1. and 2. while keeping the
device-wide scope.

Patch 3 then derives the hub set from the caller's partition
(fpriv->xcp_id), fixing 3.: each partition reserves, binds and
conflicts only on its own XCCs. Unreserve keeps operating on every hub,
freeing whatever the VM actually holds.

A note on the record granularity: the reservation could instead be
recorded on the partition's first GFXHUB only and treated as a pure
ownership token, closest to the original single-hub design. But the
record plays three roles at once: the ownership token, the set of hubs
whose page table base has to be bound (each XCC translates through its
own hub, so the binding must cover every XCC of the partition either
way), and the per-hub check of the VMID grab and CS paths
(vm->reserved_vmid[ring->vm_hub]). Recording on every hub of the
partition keeps the three consistent by construction, lets
amdgpu_vm_spm_update() derive the binding set from the existing
structures without a new field, and gives jobs on every XCC of the
partition the same reserved-VMID semantics instead of only on the
first one. The VMID number itself is the same everywhere either way:
it is always adev->vm_manager.spm_vmid.

No UAPI change. On devices without partitioning, or on the whole-device
node, the mask degenerates to every XCC and nothing changes; on
single-XCC parts the series is a no-op.

Compile-tested on amd-staging-drm-next with CONFIG_DRM_AMDGPU=m;
checkpatch clean.

v2: address the Sashiko AI review findings, all of which checked out:
- Iterate the GFXHUBs with a logical XCC mask
  (GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0)) instead of the physical
  adev->gfx.xcc_mask, which can be sparse when an XCC is harvested and
  would send out-of-range logical indices into GET_INST()
  (amdgpu_vm_spm_update(), both ioctl ops). The partition path already
  used the logical xcp inst_mask.
- amdgpu_vm_fini() now checks every VMHUB, not just GFXHUB(0), before
  waiting for jobs that may still use a reserved VMID; with patch 3 a
  partition > 0 holds no reservation on hub 0 and the wait was skipped.
- amdgpu_vmid_alloc_spm_gfxhubs() rolls back only the hubs it newly
  reserved, and waits on the root PD reservation first, honoring
  amdgpu_vmid_free_spm()'s wait requirement; previously the rollback
  could free pre-held hubs and unbind a VMID a just-submitted job uses.
- The return of amdgpu_xcp_get_inst_details() is checked; a stale
  fpriv->xcp_id now fails the ioctl instead of silently reserving the
  whole device.

James Zhu (3):
  drm/amdgpu: expose the XCC-masked setup_vm_pt_regs as a gfxhub
    callback
  drm/amdgpu: reserve and bind the SPM VMID on every GFXHUB instance
  drm/amdgpu: scope AMDGPU_VM_OP_RESERVE_VMID to the caller's partition

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 68 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h    |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 70 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  1 +
 7 files changed, 132 insertions(+), 18 deletions(-)

-- 
2.34.1

