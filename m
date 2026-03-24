Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F00DF532EA
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 07:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9944910E5F6;
	Tue, 24 Mar 2026 07:38:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ooRnDoM4";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE9B10E5F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 07:38:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hb+EalaiyHj2uJmri+YB9r8zmFuMPTD0Y1T/vCb+cGgHQ4npnnLr1JU7G2X8V91nNpcHx3P/Ro26L1SgAKVivkA5MjOTtkszPP7Aec9Nit0ENJNb9Np0efr4lpbIZgpj3hkQhpStLB1CMob0M3aZXc0S8lzakLVItckWf/sA3RO6/BB9nmz9NZ07M9ntkgPi52nKMbNZWv75krBeT+ZJMp9nUBw7WlpuZzQASiUdrO5gk2iW7DB8Zyt2KulZ93QQ1Gql064yED+H8xQO4M6FG1+Lyib5eRQ6Svt0x0+7mrxQSA+Rb+eP3rJYyU5JQ/f3saiinP56B2soQ5GmgtxO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBjAiLyYr+m8XeHHCd++wj1Z0kis8D8JuLxl6MwV6aU=;
 b=u2QMP6toh/EAmke0r8fXs8gWFbt4blA+2Gx8g+xjVj/6l8dU+8tEMckfVhwY1cF43+RkfqUF3vOkTXnZbXorcnzDdrO3Rks/cgRRPjVdRDJkwIVnwL2YC+nMRTjpVsu6yoU8Q6uH0ZVnSxebkDDFhr4hIwy7CHIziTmFsO0lrC/JCywKNqyRtgbUd5OYjf1s77SZVwuKGstGa1rn1fDxlMaEQ3UDkChuKqmbQp9cSgAizbpBrhmqOGPelW+6VtjyJ7cwEY+O3gFMEb/FfkVY5OW/AJxDZpk9vbAeg57CMZMVzgeigHkVPF7v7F4lo9IAEzJixBgMmWQTgh99wIlNFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBjAiLyYr+m8XeHHCd++wj1Z0kis8D8JuLxl6MwV6aU=;
 b=ooRnDoM4SYXHpzSAp1W04Ykgdt4NNIbPNJ95IVNR7mmh7Xc/SfJe9dB0SeX30ADNiBfiV3upsXEq4iZN+YG7PM7kngXaoDb0korwz4MsGjF+f9us1bSDJsxxHvcY2wQeAHAaFEhf9nj9SDDc1ONWZkK9VpdYGixj63si5G/ut+A=
Received: from BN9PR03CA0696.namprd03.prod.outlook.com (2603:10b6:408:ef::11)
 by DS0PR12MB9057.namprd12.prod.outlook.com (2603:10b6:8:c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 07:38:25 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:ef:cafe::fb) by BN9PR03CA0696.outlook.office365.com
 (2603:10b6:408:ef::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 07:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 07:38:24 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 02:38:24 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 24 Mar 2026 02:38:17 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: guard atom_context in devcoredump VBIOS dump
Date: Tue, 24 Mar 2026 15:37:36 +0800
Message-ID: <20260324073817.662295-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|DS0PR12MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f649c30-38ca-40ab-1a9e-08de897854fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: g8NRh3ZzKORlOaCbF3r2A6N/BV5o0agY5nb2hzJoIqKbfBdpTRHeLSRacyALXEut0jj3ysfHkqXn7DfnSu9eT3kNJlVc/WA8Yumr3fZLrU0e8leGS45eA1CNfsdcmDhVC7xsunibDDpsowUH0HmNQeNExFXnXnGcxDOS8LoQMekeXu7v/IQXVGYl9gG0CeMqpWI9sVmriQXaOzThDB+qjSVyRxFMmIOcOgMd/tQVqZVPosJ2LaHCgxmBlzk9/tHtOc2fh7n5MFuDJixjX2vX9jxD7p6CXEkWTGCiHygAisggZd5RMeH2jUqqD/2/BMIdbjTInDcbkE2G9jJFzMMcPwl1vV1+ZP1G/avrs8FuV8UT9A8Amyqn99UmaP7k27QMsnHQc1ut8gBcfEX4tFn+/DZhtj6zh+8Fveo1N8alZFtlMLZKM8+CmKvH8dPoXvcK9MIReUgTKu/uYvOJPtx+pcXvUHlu6QERje2Mg4CMDL9xe9wp/2r4TBAuEfATg2hPih+GL+tARzCscE4DNaPx+rainePRPCDM4gGhCPHTh37rfWEySgMMB18js6BidY9EV7PWDGvrqCOp20gnmq9zhnCZx4M1vGy31XPH9vT0PbMOOiJpN+ImWH3z0HDP82mgVThfaCC+8/FFmbRrSL3ic4HoRj5uPIltDpHdOwlJlrMzweV55VUrfUPltdJ96NDGTS+JYQlpUVqRwqrr+5HCBJN1Gxi/yDN3UeU+jughYxLKMVy8C+cwoSlFhZZcaNo+BIa3K6JqG66ohERFhcaIOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +u+6BlSlE8BX49z6uoPSQGts1vDDZbISSwDH856HZ2k0h99LwTMndJ+RhExleO3Y4vtjNMRgeoqyjMK8Mla9S+Ri0SCzAziHPXDuL9yzP3IyMe7nekhwjGqmOOzMehfUNoH6atOWOgT0N/nKNJE1HlktnqsufTHQa9QQ0X1ixTm9lq1U1D6HIDX/XIv7bNWVnYUFApm20rvfUeRDQkzA/wDJXC4UtfSdC7AS+DtjOJU9K1vDMXY7GwhSC5lLygBvygH5M8kyJSvaBQVC2I0cllA2R1D5okEqWAA0p5Afyf6VZAm/WvJHzXCSvpkXp4vVSSvXHTdthHb0Y8A/oUsoSCjHEVAc420B4a0UUi96pV3ZIcAjC5riZ1256FiQElqhJkNOekY1s64KNgbvZgDrAGge2z7zSo6cCPP8b+87JKXMkllyeFu+kNOcnlRTzfIy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 07:38:24.7812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f649c30-38ca-40ab-1a9e-08de897854fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9057
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

During GPU reset coredump generation, amdgpu_devcoredump_fw_info() unconditionally
dereferences adev->mode_info.atom_context to print VBIOS fields. On reset/teardown
paths this pointer can be NULL, causing a kernel page fault from the deferred
coredump workqueue.

Fix by checking ctx before printing VBIOS fields:

if ctx is valid, print full VBIOS information as before;
This prevents NULL-dereference crashes while preserving coredump output.

Observed page fault log:
[  667.933329] RIP: 0010:amdgpu_devcoredump_format+0x780/0xc00 [amdgpu]
[  667.941517] amdgpu 0002:01:00.0: Dumping IP State
[  667.949660] Code: 8d 57 74 48 c7 c6 01 65 9f c2 48 8d 7d 98 e8 97 96 7a ff 49 8d 97 b4 00 00 00 48 c7 c6 18 65 9f c2 48 8d 7d 98 e8 80 96 7a ff <41> 8b 97 f4 00 00 00 48 c7 c6 2f 65 9f c2 48 8d 7d 98 e8 69 96 7a
[  667.949666] RSP: 0018:ffffc9002302bd50 EFLAGS: 00010246
[  667.949673] RAX: 0000000000000000 RBX: ffff888110600000 RCX: 0000000000000000
[  667.949676] RDX: 000000000000a9b5 RSI: 0000000000000405 RDI: 000000000000a999
[  667.949680] RBP: ffffc9002302be00 R08: ffffffffc09c3084 R09: ffffffffc09c3085
[  667.949684] R10: 0000000000000000 R11: 0000000000000004 R12: 00000000000048e0
[  667.993908] amdgpu 0002:01:00.0: Dumping IP State Completed
[  667.994229] R13: 0000000000000025 R14: 000000000000000c R15: 0000000000000000
[  667.994233] FS:  0000000000000000(0000) GS:ffff88c44c2c9000(0000) knlGS:0000000000000000
[  668.000076] amdgpu 0002:01:00.0: [drm] AMDGPU device coredump file has been created
[  668.008025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  668.008030] CR2: 00000000000000f4 CR3: 000000011195f001 CR4: 0000000000770ef0
[  668.008035] PKRU: 55555554
[  668.008040] Call Trace:
[  668.008045]  <TASK>
[  668.016010] amdgpu 0002:01:00.0: [drm] Check your /sys/class/drm/card16/device/devcoredump/data
[  668.023967]  ? srso_alias_return_thunk+0x5/0xfbef5
[  668.023988]  ? __pfx___drm_printfn_coredump+0x10/0x10 [drm]
[  668.031950] amdgpu 0003:01:00.0: Dumping IP State
[  668.038159]  ? __pfx___drm_puts_coredump+0x10/0x10 [drm]
[  668.083017] amdgpu 0003:01:00.0: Dumping IP State Completed
[  668.083824]  amdgpu_devcoredump_deferred_work+0x26/0xc0 [amdgpu]
[  668.086163] amdgpu 0003:01:00.0: [drm] AMDGPU device coredump file has been created
[  668.095863]  process_scheduled_works+0xa6/0x420
[  668.095880]  worker_thread+0x12a/0x270
[  668.101223] amdgpu 0003:01:00.0: [drm] Check your /sys/class/drm/card24/device/devcoredump/data
[  668.107441]  kthread+0x10d/0x230
[  668.107451]  ? __pfx_worker_thread+0x10/0x10
[  668.107458]  ? __pfx_kthread+0x10/0x10
[  668.112709] amdgpu 0000:01:00.0: ring vcn_unified_1 timeout, signaled seq=9, emitted seq=10
[  668.118630]  ret_from_fork+0x17c/0x1f0
[  668.118640]  ? __pfx_kthread+0x10/0x10
[  668.118647]  ret_from_fork_asm+0x1a/0x30

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index bbb5afd67b49..5aa46480f05f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -192,12 +192,16 @@ static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev,
 	drm_printf(p, "VPE feature version: %u, fw version: 0x%08x\n",
 		   adev->vpe.feature_version, adev->vpe.fw_version);
 
-	drm_printf(p, "\nVBIOS Information\n");
-	drm_printf(p, "vbios name       : %s\n", ctx->name);
-	drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
-	drm_printf(p, "vbios version    : %d\n", ctx->version);
-	drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
-	drm_printf(p, "vbios date       : %s\n", ctx->date);
+	if (adev->bios) {
+		drm_printf(p, "\nVBIOS Information\n");
+		drm_printf(p, "vbios name       : %s\n", ctx->name);
+		drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
+		drm_printf(p, "vbios version    : %d\n", ctx->version);
+		drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
+		drm_printf(p, "vbios date       : %s\n", ctx->date);
+	}else {
+		drm_printf(p, "\nVBIOS Information: NA\n");
+	}
 }
 
 static ssize_t
-- 
2.49.0

