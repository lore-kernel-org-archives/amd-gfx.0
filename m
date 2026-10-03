Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1711CA5FDD
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Oct 2026 04:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE29010E073;
	Sat,  3 Oct 2026 04:40:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bGbYMJry";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010018.outbound.protection.outlook.com
 [52.101.193.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FCED10E073
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Oct 2026 04:40:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o03qDH+lc2PQXNN/J6hftMgJWB6ffMh/cFHdg23M4I/5eVGeo+0Nr8Yp5dlXAUO6PTVnXHnRKw+ZDMg/5yxrlMZddPCQ28q5CUO+xgwQHdihKNXhOy3iR9PPc4OujYwB59ui6dfdsHYVI4NYzbPHKeekUnlwwDJrtvrNnw8wCrzo9oL3nFovv/AwvaNR2e/V4gch9yFIqJcRPN0USG1OIdYjxUEL46X9XrnDzY6gI8oXWQop5XuQaMwlPcA7eqBeLEOqBQeK4a68FLhB1SJce1WPSBNOxazc+s3n3NBV1U8aLoMZSdhmuTHAUmnkjTt4bEyopTmJrif1Atk3ZQb6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7i+eFVSR+IGltnGHMgdwvPE6sI/T7q5T6GJmNpInS4=;
 b=A7HIO0SMq5ZdWaePMS4qOoP61wQH+7CqRekyLk3vYl6Zwrvhjiht5NjKOIGE9KD4ZxbUUF6S8hQgGCIh9RIMEFpr6Hd2I9euDFPL0Ram4rejshIRjTOyZQ0lj3Q54Tqs0y/3RR8hHz1StErM3a6ITFoefzMuXZ3APgT/nUJ71Okb2AoqgEzp69IyhqT7tEok7IybmT7Z6fyjx2hJxa87KgAYMZ4Z6LC6KYGhVbkF+Z5n2JgdMMfToebPvwM7OfxA0KBsK8vs3eJUWA3ygGz3AWr1eSdyQ5eeJys9bmo8rp6FlBb+Jyt3PCHYJsXS5er49QMIHgKMMDlJA7v6QtgubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7i+eFVSR+IGltnGHMgdwvPE6sI/T7q5T6GJmNpInS4=;
 b=bGbYMJryyMxSZ94poZTKlPbo32KOv0CpBfR0KaiRqTQYbE/3dcrr1vWqBRs3m54jP0mZ75V0/skutsHe9LOG3IM65etia/vPuVvsK0/fmC4kreAUqG59M/fln4+xx++cdick9L7SGwAFRNcUDc2G7ZVs0Tv3H5WfwhJdMQwpsXE=
Received: from PH7P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::16)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Sat, 3 Oct
 2026 04:40:14 +0000
Received: from CY8PEPF0000005C.namprd21.prod.outlook.com
 (2603:10b6:510:326:cafe::5) by PH7P220CA0004.outlook.office365.com
 (2603:10b6:510:326::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Sat, 3
 Oct 2026 04:40:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF0000005C.mail.protection.outlook.com (10.167.247.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.3 via Frontend Transport; Sat, 3 Oct 2026 04:40:13 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 23:40:11 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 0/4] drm/amdgpu: Second-level trap handler for render-node
 user and kernel queues
Date: Sat, 3 Oct 2026 10:09:49 +0530
Message-ID: <20261003043953.936202-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005C:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b0d8ee2-4e4e-424b-a356-08df21086a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|6133799003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: gDr+XjKlDntueMWzLApUjort9l+zy3/jA+6Pu6+fGJIParPUyyAiUiQhyODn9hT7sQBGbcY84WhXVm+oyxqt+EnWxcE+Z7PkgUe6T+FyvUN+RQoYgYXORsgOktZZVA/7fYyCu8GEgGDenSyD9hVZGc6tx/YaXTLsLtK4LHExgcKoZIeUNTkMzTkLr972g6FB3+Am98SYajZ9MZWFoTeBsff8Zw9d9VZyDbC3Mi31igjNHd1meZtzXxTozu6i2UAhyBnMUa5mtWMxTvb5jfkkQOZpIegi5vCA6M1hHDKVoI1Xxs4ng2FXTm0B61m9qPq7If/0BHJaUpiyHs/L2dF5ZI+MY8zAV69Sqw/YadJAWgJT0Cot01wFSrW726rxjoU/epOm+6bP7GLwD9LtETt3vXHW+cb0gYE2DHCfEuECr8ZgeqaHdtEexsMhqG1QzTTVf2toGjYcE6FRVQ++ua4NdZTnC+hGs8ZcHlI8GHIji+xrdKhOAmItJrlumfgH0PSHMonqyLntJ/5LcQzPvCeGTrE9QWXK1JosX5/FW0ut8PzqC8v4arfwZGCxwLt/E2jcNkLYOTgiQI6QCK8y2+rgVHGH3znj1zHJiQ/D1h8daMIugXJavTi3x83aBS1HLuYNXBaKtwvBOTev/NNomJHenPS3LRBKKMVn0okIVb0e6lZjzpwyNtMzZQMopY14dOICMxxx2RemRm2yO0PYp6wasw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zjJveT6UodyZtsiG3/R70a4z/iDZ77bvYk/rl5xkeocRw+6iCryR6V+2Hc0I0UUkdEm87OU0NmLt/E8qgFcfdS0m2ntP5E4ItFIrwV269OGU55J2NTck72iuokpDMAVqlXkG+0zUMKx17ZaaEYX/qXMytxUYIfybdSPlE5mrYbPOiAWFCb6CFFLfaY8PQR/vljD7K8Og4IlLLKPEKHju2hr2GAKBnhAZHJ9pbpeMISRx19MV+tBmbvUNHW8VyzFeDSiws97gxUAliBFDq0hS8EPzZ5gPO28SAtiVj0vtGjxKX9hpJ//URy8zlquDiq1/gN3bucLQMr+7VrrRPFTWAGBt8VyT8CoycKPHG8xiucV1fgntYue2xzVihGYyNVwr3J7Mi3f+843FkmSnGsqnFNhY1lB2qbJAC/JC8x4jdlmAc/tvPkXNNgMQMREQHW4Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 04:40:13.8326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0d8ee2-4e4e-424b-a356-08df21086a6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF0000005C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,
 
This series adds second-level trap handler support for render-node user
queues and kernel-managed VMIDs.
 
The first-level trap state is associated with the GPUVM because the TBA
and TMA are mappings in that GPU virtual address space. User queues and
kernel queues using the same GPUVM therefore use the same first-level
trap state.
 
User queues get their first-level TBA/TMA through MES/KIQ. For
kernel-managed VMIDs, the required trap registers are programmed from
the gfxhub setup path.
 
SET_L2_TRAP and CLEAR_L2_TRAP are exposed through the VM ioctl. Before
changing the second-level trap descriptor, the driver waits for
outstanding work tracked by the GPUVM reservation. The VM root remains
reserved while the mappings are checked and the descriptor is updated,
so the queues cannot be resumed in the middle of the update.
 
Userspace must keep the second-level TBA and TMA mappings valid after
SET_L2_TRAP and may remove them after CLEAR_L2_TRAP completes
successfully.
 
Changes in v3:
- Use the existing GPUVM eviction fence instead of explicitly evicting
  and restoring user queues for SET/CLEAR.
- Keep the VM locked while checking the mappings and updating the L2
  trap addresses, so queues cannot resume during the update.
- Remove the amdgpu_userq_restore_all() export since the trap path no
  longer needs it.
- Remove the remaining old TRAP ioctl UAPI definitions.
- Fix the cleanup when trap allocation fails and the ordering when the
  trap state is freed during VM teardown.
- Keep the separate reserved VA range for the first-level trap mapping.
- Add kernel VMID trap programming for gfxhub_v3_0_3.
- Mask the TBA/TMA address fields when programming the registers and
  keep the existing GFX11 TRAP_EN workaround.
- Handle the XCC mask when programming multi-XCC hardware and restore
  the VMID selector afterwards.
- Check the reserved fields in the VM ioctl input.
- Document that userspace must keep the second-level TBA/TMA mappings
  valid until CLEAR_L2_TRAP completes.
 
Only compilation and driver load tested.

Srinivasan Shanmugam (4):
  drm/amdgpu: Add second-level trap handler infrastructure
  drm/amdgpu: Make first-level trap state GPUVM-owned
  drm/amdgpu: Program trap TBA/TMA for kernel-managed VMIDs
  drm/amdgpu/uapi: Add SET/CLEAR L2 TRAP to VM ioctl

 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c    | 396 ++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h    |  65 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  60 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |   4 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c |  38 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   |  38 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   |  53 +++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    |  38 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    |  46 +++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  |  46 +++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c  |   7 +-
 include/uapi/drm/amdgpu_drm.h               |  88 +++--
 15 files changed, 686 insertions(+), 205 deletions(-)

-- 
2.34.1

