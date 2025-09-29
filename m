Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BF9CAC5B0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Sep 2025 08:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C37B10E3CB;
	Mon, 29 Sep 2025 08:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1KnF+Lv+";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012037.outbound.protection.outlook.com
 [40.93.195.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15A6210E3CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Sep 2025 08:51:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJM11wzFoOB1+tKLiPi7dBkhXzXYUvv7CnkTdUnPk9XU0TPmzLlsmRSQSNbt68uuQclPdHat6ORuSipahPS9394rMWde6ahNcJl/ocBNGWTWhTLtD7eIOWuT3DcbhkolKZt4CsWH1Yfapwprbnho1eZN3cL5q4PLReech6u8ERwz+QoZFi0hXOeVRAawoCruGX2sgZ4jLCLMfN9S/WcMjjNtg6sfY+Ac/FoxDTyrg4cUxRITmXEm08qADWKKoBaBRfYvFwuw8NxogLUW3tvG8rRh8KmoFArrvqTTciM6etlPuwtIN5FabDHAZTzzY/Yzh4pgP+D2eDKY4GT7CJXOeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paUKPGTXQ+gNDB5TnoCNMsg39kdCvrR+NbV6wuNKaNU=;
 b=NSKgOmWVQKxjsA+33l+lCb8TJ74kQhwXs9aFGRozWZ7AjE2+w/qps6rqTsYF57oMgmH323bl4toIqvfGx2KMqBzIFQie/Q7OIHbt3LLb3VcUl/RjEBjK4F3IRJMBKRsbS0nWEqK+kiY3I5EcmN/O5XAZ8So3OS7NEXKXJRd1WS68K4Krtpm3B0hlZyqAJUQMV2sM4+yV23r50HT8Ndyv4Pzfe4iuYxzQxRcavPL7KjW9Z1+9m6udYDiR9VsNl/qANZCUyVUKyV6b+VGa+KmvYTZ3EJpfhGeroCKRV5wIBXPU4+16gzw5imYF4+a/WoqMJEMfhMrUTZX7fKCFF6ejag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paUKPGTXQ+gNDB5TnoCNMsg39kdCvrR+NbV6wuNKaNU=;
 b=1KnF+Lv+QgPUJ5nKorcyDwVtKQB8u8wXDttO9jVtncCAdYrtR/osQdoYT8OWOZ9xFKV7lOhXAhzfOxu5ne4eXfwtF0a7AGy5n7RPpPoqXbFYRR9n0wRiVI46R9w/noqEmE9FiVdkER47gFPqOLAtB2sYgGih0TadXsiPoGwmQzU=
Received: from BL1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:208:256::11)
 by IA1PR12MB9740.namprd12.prod.outlook.com (2603:10b6:208:465::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Mon, 29 Sep
 2025 08:51:31 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:208:256:cafe::72) by BL1PR13CA0006.outlook.office365.com
 (2603:10b6:208:256::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.13 via Frontend Transport; Mon,
 29 Sep 2025 08:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.1 via Frontend Transport; Mon, 29 Sep 2025 08:51:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 29 Sep
 2025 01:51:28 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Sep
 2025 03:51:28 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 29 Sep 2025 01:51:27 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix general protection fault in
 amdgpu_vm_bo_reset_state_machine
Date: Mon, 29 Sep 2025 16:51:04 +0800
Message-ID: <20250929085121.3181721-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|IA1PR12MB9740:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ddbd7b-3466-4040-d0bd-08ddff35629f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3OSVuCERZfdkTqgvMY+OXf8k+bnPyFPcecyKC/EpUsf1ybmoJqxqeGlKEVRZ?=
 =?us-ascii?Q?GtXIcwVT91uH0EXgTJuFk9106qP4f7tUr41cPMJrZ1QFp9pT+K1ZCcX4Cb9d?=
 =?us-ascii?Q?20bDqrTK46cMycGV01VG6ehqhl19TXiGekEkj2f1bt0B9jq5UF4U6XjsybSm?=
 =?us-ascii?Q?gic/IDyFDfQku38pbjpmukIocMZSIvDi04xp1Zi089IrZMsPhIXmC3rS3Im2?=
 =?us-ascii?Q?xk0y5OBKHh0C1cNJqNHfALmbsYwnRDkY5+fMraM3V9OTRZy1APUhmVPHJDky?=
 =?us-ascii?Q?5IqkKaoZlbT/xhX4QbFTMOu5Z6FRdTZ2jsNTrr8Bc1Xf95DNIpwiu873yFLF?=
 =?us-ascii?Q?SAXdLMzCUVorT/quAZmcYCyxGIbvhoC0bDxwb+3467JfSc9f+a0Xb4A6sij2?=
 =?us-ascii?Q?DCTgOUA9Jr8DbVQ93u/oF9zLFhyFicHCq1jeMgl9AWhwDSjxMDMEL3BOiXYI?=
 =?us-ascii?Q?jox0HyRQZviMMYZHAvl77DCWOg/4hpKNi8R2bQm1PwbgqCKgzRMuExVb9Sg7?=
 =?us-ascii?Q?BhKcWe6q0kEqqkDiNIF/1NKxv9cimEc+ZX3cBMsrx1IxKTLPpnyFMnhi/gC9?=
 =?us-ascii?Q?FD3pnqL0ffH7XwOE0JAgyGnkPkJlxKtG1JD4I6WHjYYdJTz78/hoj9mo7gNb?=
 =?us-ascii?Q?EKInDUiMJCrmdMrUbyV+jNWwFPTisBUFIpPu3iOQuxkks/VVTE73Xb4hu/P7?=
 =?us-ascii?Q?U7VQHV/wNUDGpGnZ4q81PVHam853bCaS77Qg+p4PBeQh5DQNDLgtNluKyPiQ?=
 =?us-ascii?Q?7at+erl4g+GppYrqSPx+m+FPoybWpA3ydd90R7rfNrNT5UR12X0fjQQt27ZE?=
 =?us-ascii?Q?HTgxj8m5eY23M8SMjiRQ+EvApcraIi2PQfrpUhWSGDaw0aNpJOc83Shxxx9f?=
 =?us-ascii?Q?WItl0FhdXXjZ6cdkDUdHRQ1YvYwUT86erqcOl//LTzytbtdmGql6b9/8WDA7?=
 =?us-ascii?Q?FOTEttvQUPoZCmJ9sIRbeCU6vcBLInK48TAH4QQtDGNe7p5PoD8kMegvxIMI?=
 =?us-ascii?Q?CDTD3YWuHNKyCsvHaChrnALubT0m1R27AK21AJ8N2TJ0iIl4hte3i6YkKLca?=
 =?us-ascii?Q?XuUe2+9rHh7OoMypaVj55mwViTnLLk+ZyDEgvOFM8TavRvCopeJoPBAAS9tK?=
 =?us-ascii?Q?wN7kr+rX4MVMVQNXLJj7bNxhksXjwm+pJSaVrTVFHxtUfVJMYbe7KlPJRNiC?=
 =?us-ascii?Q?v3kfRnIjOr/f4yX4qrZuvS1bQasbpDSD2yx6DH0qOmMojMcNnJ1gekmcYYHN?=
 =?us-ascii?Q?6Mf/A7nRONK3rKRZhw+awXl5iGmXRHM9AhQihvO1o9KE2zn1iEZSUmml4HnR?=
 =?us-ascii?Q?6ljgZX98GilcZA4X4uGiObef0c4aKfOsNA5tFtE7o7UkMC2y/puW6XOOINQZ?=
 =?us-ascii?Q?L2jO7/ba9FkNQlZ4IfWhwZocgGN7lLGE4Gs7oUJsznwKUeqp++HiNNADBSO8?=
 =?us-ascii?Q?bcOcdPlqYpYEs0kDpUPTVDZgQOfjWl8ze10vhP7auYbkwUAqZEedt1496UWx?=
 =?us-ascii?Q?nq9XLog31ueCxlELQZ+eMe1tDV0GMwG5Tqb2iQWnfRJL45KzuvZirLbiW1w6?=
 =?us-ascii?Q?NLa0w68lIBPanYw5uzM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 08:51:30.8802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ddbd7b-3466-4040-d0bd-08ddff35629f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9740
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

After GPU reset with VRAM loss, a general protection fault occurs
during user queue restoration when accessing vm_bo->vm after
spinlock release in amdgpu_vm_bo_reset_state_machine.

The root cause is that vm_bo points to the last entry from the
list_for_each_entry loop, but this becomes invalid after the
spinlock is released. Accessing vm_bo->vm at this point leads
to memory corruption.

Crash log shows:
[  326.981811] Oops: general protection fault, probably for non-canonical address 0x4156415741e58ac8: 0000 [#1] SMP NOPTI
[  326.981820] CPU: 13 UID: 0 PID: 1035 Comm: kworker/13:3 Tainted: G            E       6.16.0+ #25 PREEMPT(voluntary)
[  326.981826] Tainted: [E]=UNSIGNED_MODULE
[  326.981827] Hardware name: Gigabyte Technology Co., Ltd. X870E AORUS PRO ICE/X870E AORUS PRO ICE, BIOS F3i 12/19/2024
[  326.981831] Workqueue: events amdgpu_userq_restore_worker [amdgpu]
[  326.981999] RIP: 0010:amdgpu_vm_assert_locked+0x16/0x70 [amdgpu]
[  326.982094] Code: 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 85 ff 74 45 48 8b 87 80 03 00 00 48 85 c0 74 40 <48> 8b b8 80 01 00 00 48 85 ff 74 3b 8b 05 0c b7 0e f0 85 c0 75 05
[  326.982098] RSP: 0018:ffffaa91c2a6bc20 EFLAGS: 00010206
[  326.982100] RAX: 4156415741e58948 RBX: ffff9e8f013e8330 RCX: 0000000000000000
[  326.982102] RDX: 0000000000000005 RSI: 000000001d254e88 RDI: ffffffffc144814a
[  326.982104] RBP: ffffaa91c2a6bc68 R08: 0000004c21a25674 R09: 0000000000000001
[  326.982106] R10: 0000000000000001 R11: dccaf3f2f82863fc R12: ffff9e8f013e8000
[  326.982108] R13: ffff9e8f013e8000 R14: 0000000000000000 R15: ffff9e8f09980000
[  326.982110] FS:  0000000000000000(0000) GS:ffff9e9e79995000(0000) knlGS:0000000000000000
[  326.982112] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  326.982114] CR2: 000055ed6c9caa80 CR3: 0000000797060000 CR4: 0000000000750ef0
[  326.982116] PKRU: 55555554

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 563cad9c6cbc..86c8288c665f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -265,7 +265,7 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 		vm_bo->moved = true;
 	spin_unlock(&vm->invalidated_lock);
 
-	amdgpu_vm_assert_locked(vm_bo->vm);
+	amdgpu_vm_assert_locked(vm);
 	list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
 		struct amdgpu_bo *bo = vm_bo->bo;
 
-- 
2.49.0

