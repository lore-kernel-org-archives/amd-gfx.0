Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707A4606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lDQCsL33
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 765EA10EC51;
	Wed, 18 Nov 2026 16:24:46 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013068.outbound.protection.outlook.com
 [40.107.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0A3F10EC38
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 16:24:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJC+g/pL1cV2eqmbTq11yGgkFz1I2eIUEO5SkC8382C6ALqYUTvMrd+QQ0lkya0HWa8oxTp+C/w96noR9wN5up3+oDvL8Lbp09ZoYPDPZJrDJuVjRiAOa0+3dZX2Uwpj87JPB+UkI5UrTFPMiY3hZm/iCn2B0Y6/3+VbJAgtIkvIhc3IJMmQM6/kdVO+ho0GdBrA6swPbBHnxsEcgtPqfNYb49VV6HtQC6KTj7NG4HHJ15SH6lhy3IvC4KmvLo/TtBcYMwYqqOO44/dF0saZLuxvA1ntc8wIb+R3f8KrNaFifQY6o4Fa9mEh7TG7ave5loLmXLN1QYE4HQ8rO5GTLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbQuBstjOi+hvSvez519zuDWwB+ouCcGmDTKsWRE9Mo=;
 b=tbIJl/C82vQpBPTOPtqGXpYEnzvk2hXeA1MUJ3zkAj50oD5uC6KipFZtyJi+foZngKt5GyXgbGroRocJ2yf8bBqn105N0oQOLcQPBmhx3Ra1+3KoeY5/TZFl9DZC/o9kRLGkZAcnd6gNGm0l0t30WRuibFzmY79y1sSQm743+XeO6RkR7LEXsnQkGZJUShVo8ByKnBled1sU6J4C/7khoR8WbCFzWZjcM5AIFvDAMpUhJlra1MK1kqhfFOU/GlE2e80EAhQLT/fyYzEtY+LOpxArKumynhgwyyL+SdZ1qsxgkWg88eV95wHj2jU0FZVqzNTudO9rU9bEdx0xkD8XWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbQuBstjOi+hvSvez519zuDWwB+ouCcGmDTKsWRE9Mo=;
 b=lDQCsL334UyedgNOdvYwlz2osC1ecgYN4SYwEyLotIgyBRwC4yZvmM4kmnmvn07ShF5VP4TBYJVAWkTV+Xu+yswuyOQgQU0cFJB1cx5n4Bf/DaGYI+9WTY83wQvcQV2UAD+DGM1uxdXJkJWRIVq64DXrL4UCuBK4hIjZMqKTBVo=
Received: from CY5PR04CA0025.namprd04.prod.outlook.com (2603:10b6:930:1e::28)
 by DS6PR12MB312928.namprd12.prod.outlook.com (2603:10b6:8:532::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 16:24:33 +0000
Received: from CY5PEPF00000E82.namprd05.prod.outlook.com
 (2603:10b6:930:1e:cafe::3) by CY5PR04CA0025.outlook.office365.com
 (2603:10b6:930:1e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 16:24:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY5PEPF00000E82.mail.protection.outlook.com (10.167.247.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Wed, 18 Nov 2026 16:24:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 10:24:32 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 10:24:32 -0600
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 10:24:31 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Sunil
 Khatri" <sunil.khatri@amd.com>, James Zhu <James.Zhu@amd.com>
Subject: [RFC PATCH v3 0/3] drm/amdgpu: make the reserved SPM VMID
 per-partition
Date: Wed, 18 Nov 2026 11:24:23 -0500
Message-ID: <20261118162426.1642532-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117165952.3558762-1-James.Zhu@amd.com>
References: <20261117165952.3558762-1-James.Zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E82:EE_|DS6PR12MB312928:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3587ee-3332-479b-3aa9-08df45906dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|261021121427099003|11063799006|261026121527099003|56012099006|5023799004|261026140227099003|10067099003|261028144727099003|261021123027099003|261022105027099003|261022113327099003|261102123227099003|18002099003|22082099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info: vyA6dOCJPLyC8v5cnLXf441VxwoXI5ZT91Rgq1GIPKL82YjvAZGKmWM5HBUbPBZ2WLDYzobyTHtSOaIDFHetoOIHyqk4sFwKTySQ7IHRZzKHLB9HsM1AeSSaw7v8yQhVrcb6FHbyaB7rwXkN+/ibK4EmeKZJ+6NgYaHmGlEAJzFOF3L0CAvXxLg3n+9pfl3Pxe11SiOT10I7kfnh3KRADlTloL0Gjz9d/0SEVrhNhErocpEXpiAKsEZD5WfqmCB8JAaNIh8cz8VcpC3G91PReDiihF61EHiB4kqosfjssT88WeLGXeACAeKE4owV1ceqVLBCbsR+VMbffN3RQ5bJaBxBmhoTmPM6Smg3Nyti6OdDwz3ChfogcUhe/+XLpsOirteQpjktsEwXmLl9bSRdW1hmaVCrkEESKSApuezmkfr4HAFjJpbtvdiNNGeeesV2g5zMPNh8Sdxbx7UYGuKA0xnVtlYy1kVQ9k08TzK3PVPi9MODcschGKKilWVEWcdV82wc0/ro6ro/Uz2J8Xx4jD1bAkDiF873MwCU0LOs92ahZqb0fsm0mfHE1uA5yNMtbbyxj4FNuiAXMwNIWFcjmYf+aI4mycTmEC6heSTCN4CsIdTjw5SoTB33ZisCWCtGI17HIciUGvu5H4X9Qteq6Y+lGW7jkRL+1COew/acc4SahrQ/IHWBNwZjFT5y6t4Hdy6PeJFcVDdVqnQWByBrEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(261021121427099003)(11063799006)(261026121527099003)(56012099006)(5023799004)(261026140227099003)(10067099003)(261028144727099003)(261021123027099003)(261022105027099003)(261022113327099003)(261102123227099003)(18002099003)(22082099003)(6133799003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xEMl+7kAaA1OUm4qK8R0uHIwWDKTqUsvC5d9JkEpynshiXQ0wM8wJC0bSm6abqPrrMlPaHnv/WgaNNC8OHNtqnMYVTBZYonPhWvZrWwkV25HoU0usiMN9ppzPTLtvLlZecfYPib/o4p4XB5LwTJS0BLUHyH0PffKuucuF8isQ08dYM8bK1O74rbP5gBoTjJndxWqdShyW2mCsJQMo8DP+D3icqMYKgr2rQU63dr1sT8Q2TfQLB0uO48rRH++Pzw2k3gLImQ43Ntomg95R0Sh0nDpQh2ioGimSkxQdRwq2G77DkuX35gmUBC72csh1GbgKRqUTF+mVV51WuSSyuUOB/sxE9Womj9jGdS7n+NXcvDFGxIAqGFfIuKeQWiWX8fmY7Bu9uu406ib0kRKw+33q7doiv3lyn12jJzqhKcI80T9NM0xgzVxwjmlaIYGyTMt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 16:24:32.6728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3587ee-3332-479b-3aa9-08df45906dae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E82.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB312928
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

Patch 1 extends the setup_vm_pt_regs gfxhub callback with the mask of
logical XCCs to program and adds amdgpu_gfx_logical_xcc_mask() for
deriving that mask (the GFXHUBs are indexed by logical XCC, while
adev->gfx.xcc_mask holds physical instances and can be sparse under
harvesting); no functional change.

Patch 2 makes the hub argument of the binding path mean what it says:
amdgpu_gmc_bind_vmid() programs and flushes only the given hub, and
amdgpu_vmid_alloc_spm()/free_spm() take the set of GFXHUBs directly,
reserving on every hub the VM's jobs can run on, under the root PD
reservation as an asserted lock contract. This fixes 1. and 2. while
keeping the device-wide scope.

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

Compile-tested on amd-staging-drm-next with CONFIG_DRM_AMDGPU=m (the
whole amdgpu directory builds warning-free); checkpatch clean.

v3: address Christian's review of the v1 structure and the Sashiko AI
review of v2:
- Per Christian: no parallel interfaces. Patch 1 extends the existing
  setup_vm_pt_regs callback with an xcc_mask argument (all nine
  implementations and all callers updated; gfxhub v1.2/v12.1 hook up
  their internal XCC-masked variants directly and lose the broadcast
  wrappers) instead of adding a setup_vm_pt_regs_xcc callback. Patch 2
  changes amdgpu_vmid_alloc_spm()/amdgpu_vmid_free_spm() themselves to
  take the GFXHUB set instead of adding *_gfxhubs() wrappers.
- Per the Sashiko review of v2 (verified): AMDGPU_VM_OP_RESERVE_VMID
  takes the root PD reservation before reserving and holds it across
  amdgpu_vm_spm_update(), matching UNRESERVE; both functions assert the
  root PD reservation. This serializes the per-VM reservation state
  against concurrent RESERVE/UNRESERVE, keeps a new CS of the same VM
  from grabbing a freshly reserved VMID between the rollback's wait and
  its unbind, and makes a failed root PD reservation an ioctl error.
  amdgpu_vm_fini() consequently frees the reservation while the root PD
  is still held.
- Further hardening from self-review: the logical-mask idiom lives in
  one helper (amdgpu_gfx_logical_xcc_mask(), guarding xcc_mask == 0)
  instead of eight open-coded copies; UNRESERVE checks the root PD
  reservation result like RESERVE does; amdgpu_vm_spm_update() skips
  hubs without a reservation with a lock-free check (reserved_vmid[]
  only changes under the root PD reservation the caller holds), so the
  common non-SPM VM takes no id_mgr lock on the userqueue validate
  path.

v2: address the Sashiko AI review findings of v1, all of which checked
out:
- Iterate the GFXHUBs with a logical XCC mask instead of the physical
  adev->gfx.xcc_mask, which can be sparse when an XCC is harvested and
  would send out-of-range logical indices into GET_INST(). The
  partition path already used the logical xcp inst_mask.
- amdgpu_vm_fini() now checks every VMHUB, not just GFXHUB(0), before
  waiting for jobs that may still use a reserved VMID.
- The reservation rollback releases only the hubs the call newly
  reserved, after waiting for jobs which might have grabbed the VMID.
- The return of amdgpu_xcp_get_inst_details() is checked; a stale
  fpriv->xcp_id now fails the ioctl instead of silently reserving the
  whole device.

James Zhu (3):
  drm/amdgpu: pass an XCC mask to the setup_vm_pt_regs gfxhub callback
  drm/amdgpu: reserve and bind the SPM VMID on every GFXHUB instance
  drm/amdgpu: scope AMDGPU_VM_OP_RESERVE_VMID to the caller's partition

 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |   3 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |   3 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |   3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  18 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c       | 102 ++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 101 ++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c   |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c     |   5 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c     |  13 +--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c      |   5 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c      |  12 +--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c    |   4 +-
 20 files changed, 211 insertions(+), 90 deletions(-)

-- 
2.34.1

