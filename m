Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920FF606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lxbaYTLr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FFDE10EBC5;
	Tue, 17 Nov 2026 17:00:14 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E689A10EB99
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:00:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+UcM4/yQE2yTK2V8ozReFNwCnETBvwLE/Q8zGw5zvEsIPky/olWGNe/ugMNl04vWPQAnZsGMdrr8E28ES4uavR3ckVR0h6cjNtifEa5k/B0Xf98rOK6z9tK+b8773QLEe1bmBI3/TFjqHoAtcpx9AP2Z7TNwhP3a9iEcavuEZVWEDFVZYqH0TbKg3FcivuxdggH9MyHBpJDHG/Iwvq1wwR4I5cxit2VQOREsIiiZyKeiGrAau7ToEZPlIb23RmHGfnj1VlxsIV5Glm6dq+6WQMMBhOD6UkS/Jfi2xAADGK3hkadd3BBAaGhDpK6pSV4zGddb7MLWqr6R75wGiISdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dr+vXGaoVPN3tsVLE0NPAw6pZ+BvFwFuI8FY2kogJwU=;
 b=KcHoK2Z28+TiNUX6cVRnhhbg5Zo0HZ4/DeOepoFGrteeBRlDLEPLKLKo1hg+Kycms0QpB5vz14p9NxOFZKwttTEm+nVx9TlyEZ5bXQVJbg6J0KFde6+U/ridCI0GBw4Ryw0I5rv4JOBqVQ6IvbdFX9E3pb1J3ydBxAnfs0NHf2zhOuaKNlq9xWWMPoariYc9T13EoDHE3uuo0tSP8SKK94g0sK20zlNWKOSpj9yUu2OUS5mTDqwJSBWvr4Dmq4Ap7hCiIeSV7DQLkbiitWlHICGTqDXIgQtoN+CntAwXUSKXO9ZA46vKt25Ym4prKuS6YGFFRxUN2QeF4q+hBstTEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dr+vXGaoVPN3tsVLE0NPAw6pZ+BvFwFuI8FY2kogJwU=;
 b=lxbaYTLrSidIrRIup3mfxz8qQjZQRMMx7T/uUdZCyLlO+KJ6AS6uKnhSm9b3og+t+cXkO9Lm6LqRULg/w/lzOMA8ZVUfsmg0mqKuy3aElePZnHArQPEoUCQmrNL7zFshso1lm0EgMPwrXhbfzVaPsevdu4biQPEnCEaH08/mIl8=
Received: from MW4PR04CA0351.namprd04.prod.outlook.com (2603:10b6:303:8a::26)
 by SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 16:59:59 +0000
Received: from MWH0EPF000DD30B.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::93) by MW4PR04CA0351.outlook.office365.com
 (2603:10b6:303:8a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 16:59:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000DD30B.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 16:59:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 10:59:58 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 10:59:58 -0600
Received: from work-495456.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 10:59:57 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Sunil
 Khatri" <sunil.khatri@amd.com>, James Zhu <James.Zhu@amd.com>
Subject: [RFC PATCH 0/3] drm/amdgpu: make the reserved SPM VMID per-partition
Date: Tue, 17 Nov 2026 11:59:49 -0500
Message-ID: <20261117165952.3558762-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000DD30B:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 87cb902c-026d-4401-dc80-08df44cc3699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|6133799003|261009223027099003|11063799006|56012099006|261102123227099003|261028144727099003|10067099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|261022113327099003|261021123027099003|5023799004;
X-Microsoft-Antispam-Message-Info: KgIwQmTCPcxSy4jsI/H2bR4V8cmBi+Nq0JdGfFQr/19kmzIpxUKvDJVzFZUnG7ilwkrhGOUyGiz52oPPR4Ri2qUWrhQA2jFH7LZhPcuyfEtzAbNq2qaRPUPbuGW54pxMbKF1Czo/XlKCcsdblPudkkaHQ8DqITzloBEwe1FIxnke6Z3M2DR1cFk7LVMwnqHKQ6n0WflyLsQPAkg6PaguS9RyAG4XWR2BOjM6oq0IeDOk4fxbDddZaV81P5Uao22JugDn39IL/YzLb6LyLcpzN/3rn82ujV0ax8j5jpVtiLc7kBRxV9PvRPcawoCF8Gp0ZVdW60KhSiZo3lfm2aUkECFUSgsgZWGl4fCiHYamcwJpnyikjSLBy4B9n+736ssyQQx11nzYsLRHTnkkrOB3ExJirnYKr2byMT3x8bNq22nH+CXOukhbgpsoZnqfZOrhYawblwFyma2PdEiAGy2dlu+XSIWMDrnEw7Ooin5UqiKN1zwjoQsE3SV367xlnTlHG1tWEvTfkJoEyd3AcQl8REghHFLBrVUfi5p5qcHkICm6JOa/3vX7FfXQLjViKhQzdsYVFAKSagnZfbjtR8riRgrdoQntpUfiH3aLYxgeSwatU7pTysfaSd6gZ2fpKYRD6DBPDPHV/6wOUZi0BoD/VBCC8S9InNeH6lAyDla6MS357HmtZyX6sFGqQc4ICiIgfRbNRG103/HAPn+Ov9x/HQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(10067099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261022113327099003)(261021123027099003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O7aILA3ejxXn+hqSwq3TZiV7yRqSzouuvrqFD4qr5j++ezWDvtEM+FwTda/u/znKsgXp/SoiZDZn9xvT/r6UbEn0LfTjZy1S1N7dXe7F+TQ6xkhlgUcJs/fwHxwcf7qhk5JoSLcqlu/LW0NjTulAyHIzpM3DuYc8/mPBkld9ZN1MIPWQNFuNbBYgtqUwpmHmOjicXgtDzEE68DbindWfAetYgpa3oD3D9GSL27vVd08eN7PtTcYQcvuU3vY9SBVyM6wm45zn/huVR3xWsF81gd4xhjSMt/bB+yfBXD904YiJyGQfI/4hntP/zZGO9JpQCROtfXzDzEYc/3tNaGV6zbFgmYhPsNBfn9a3hSdumJ05/AGbpvIEsw00IpJUXiPZ+JOXq8+VGIAfhrcchmCbOmEv9FV0s2kUWZYRxCQiDKLgIt60SBdeAiLRccGEPYkR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 16:59:58.8417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cb902c-026d-4401-dc80-08df44cc3699
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000DD30B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992
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

Compile-tested on amd-staging-drm-next with CONFIG_DRM_AMDGPU=m
(amdgpu_vm.o, amdgpu_ids.o, amdgpu_gmc.o, gfxhub_v1_2.o,
gfxhub_v12_1.o build warning-free); checkpatch clean.

James Zhu (3):
  drm/amdgpu: expose the XCC-masked setup_vm_pt_regs as a gfxhub
    callback
  drm/amdgpu: reserve and bind the SPM VMID on every GFXHUB instance
  drm/amdgpu: scope AMDGPU_VM_OP_RESERVE_VMID to the caller's partition

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 49 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h    |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 50 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  1 +
 7 files changed, 96 insertions(+), 15 deletions(-)

-- 
2.34.1

