Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B84AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 08:30:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0239A10E7B0;
	Tue, 29 Mar 2022 08:30:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF17B10E7B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 08:30:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrb1xKBfy+qRxvkMhudxkHuMgZwS2hLqg6tG6z3aEcXBJmJaM2ABeFgULDH7D9DGCsrRsOde5sHii06YDDyHF2E3WAHP4h6//DNp1vRCY3Fudc8azCDLMUiP5am399o7tKTerQ+287aeMxlgsPaQlPaeQi8Upl3cFhUwIr/6uxEOHh/6FjNJspbqLDA8ZxDja9V3h9CoquHeax1JuAvgBuTHLWgXgxH324znWzyRZRa25uSabXzADF9KYqWu6k9NEax4sRpJCWLqZ8HSCJM3cQKXYyMSQY9wDfxAMM+/9HYB6ZfJ0eDoYlikv5JCZk1dIyJX8+V/tkjQI3DBaiaA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIzXiDlDtJF74nPiNxcC/pN7LtvW+VUd8TzJ0NgeW2M=;
 b=aIfxzVvdaq0/3oM97GjwD51Hj+43dThppCBNsBvoPIsG0K256DkMAgHEEN1IIy1yGKa9Xm61WGihP8S8OEanbbEgSHCBuih8tfU2dBk3TSM6BqwJOj9kxcPRvv8e7cATK/3iWR4DRLzQRJgF4qCDNMIhstQ3+Nq3vyApYMdtC+ba4vAgXZyJRTXWu9UhLx2jWGx+CKNYEfoHx8wjk00RrmTdXeX3TLRW2izROdLwkSeGo6mM9DYdKDhoQTjjfkkcwPKQchjfAgWW0KrY0zcQoVWYbD0b2/5rAere1WvJ4E02M3RK9pT088SlRjyOuy6AVUGfdq/l13yliJ4Z/kKH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIzXiDlDtJF74nPiNxcC/pN7LtvW+VUd8TzJ0NgeW2M=;
 b=qFDm9/MeXOZWb/ceWCt/qO85+skTIepmBTr3L2Qa1gV7taE0oGNZqhga1Gs1IHKPERca8dITP3eeCGzX1wtEXpaNuCNOscmIBAMsKiMQM2wrPtgmzA4IcHhj5sNjvNiO0TJ/KI05FDSEiw1KpfxwsGxGu5ykhA9xQ8WZiy57aJA=
Received: from BN6PR17CA0001.namprd17.prod.outlook.com (2603:10b6:404:65::11)
 by BY5PR12MB3810.namprd12.prod.outlook.com (2603:10b6:a03:1a6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 29 Mar
 2022 08:30:33 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::3d) by BN6PR17CA0001.outlook.office365.com
 (2603:10b6:404:65::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23 via Frontend
 Transport; Tue, 29 Mar 2022 08:30:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 08:30:32 +0000
Received: from ETHANOL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 29 Mar
 2022 03:30:31 -0500
From: CHANDAN VURDIGERE NATARAJ <chandan.vurdigerenataraj@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Fix by adding FPU protection for
 dcn30_internal_validate_bw
Date: Tue, 29 Mar 2022 13:59:57 +0530
Message-ID: <20220329082957.1662655-1-chandan.vurdigerenataraj@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfaeb375-351a-472f-3bed-08da115e6418
X-MS-TrafficTypeDiagnostic: BY5PR12MB3810:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3810586FF67B7DAB792AEB5D961E9@BY5PR12MB3810.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pKe06AMydAzzi6k9uO8eNagL3mhD7rHow2l1DrlEryCaVmpu4C1GGYhXClhinZHLrO+EJejV3PhzL3z8/j6g95WK1/sNALY36h/io1FpEdZUf5VHHRbmkl6f687nDzz+HcyLUk1O4YzFigIhP7VnAKsAdq2uNvTiZvWFz9W12cl4AKrEVDQwhTDgH51gZYieIwYj7oYe12SaY1aYp6pCU12hvzgXKt00gXxCiPzV9/+MhJf3nFOFIHOEzH/d5givAWL6ss8C+IfilvNnhjvDSlZRfXl35yNgqISNLiVIqqtbPLKdNdJeNLDwy9gLKRIDvjJCk3vt6O3cAjotfSkH4AvalgQAbrEzdNXrzTSBIzRCffdaayCTywunGtJXqxvASuaeBE8YvNZrnjjtjI0BUxsjbWfTbETOen2hVcHcNcIDCtNHb4X035jfIhOhc6imQxrExvcJlKd3+lk2VvHxSm8fcS2sK1E31icym5OJ5KXNcsx6U4dZNx8y+omMrf8uvSDhboJfkSnoNOcc/hrRZPbkbkETPJOd886vpm+vEj42pgzwgX8Ne5XY2pcwnphgvlw8m/xB8yoDibFq65UPylifbdIvAEOfriLyQzuY7PkWwIvlvS7Zy/TVwizoTrFHu/KZy/NDjI+w4eARH8QQyTKicVyfJKYq28sXGj9kkZbrw4vEI5/ViSDVLZy25JbvCzz0i94Dl7CZDPhTtrIGzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82310400004)(2616005)(336012)(4326008)(83380400001)(5660300002)(186003)(8936002)(36756003)(6666004)(26005)(426003)(16526019)(508600001)(1076003)(110136005)(2906002)(70206006)(70586007)(6636002)(86362001)(7696005)(356005)(54906003)(8676002)(81166007)(47076005)(40460700003)(316002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 08:30:32.9473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfaeb375-351a-472f-3bed-08da115e6418
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3810
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
Cc: CHANDAN VURDIGERE NATARAJ <chandan.vurdigerenataraj@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[WHY]
Below general protection fault observed when WebGL Aquarium is run for
longer duration. If drm debug logs are enabled and set to 0x1f then the
issue is observed within 10 minutes of run.

[  100.717056] general protection fault, probably for non-canonical address 0x2d33302d32323032: 0000 [#1] PREEMPT SMP NOPTI
[  100.727921] CPU: 3 PID: 1906 Comm: DrmThread Tainted: G        W         5.15.30 #12 d726c6a2d6ebe5cf9223931cbca6892f916fe18b
[  100.754419] RIP: 0010:CalculateSwathWidth+0x1f7/0x44f
[  100.767109] Code: 00 00 00 f2 42 0f 11 04 f0 48 8b 85 88 00 00 00 f2 42 0f 10 04 f0 48 8b 85 98 00 00 00 f2 42 0f 11 04 f0 48 8b 45 10 0f 57 c0 <f3> 42 0f 2a 04 b0 0f 57 c9 f3 43 0f 2a 0c b4 e8 8c e2 f3 ff 48 8b
[  100.781269] RSP: 0018:ffffa9230079eeb0 EFLAGS: 00010246
[  100.812528] RAX: 2d33302d32323032 RBX: 0000000000000500 RCX: 0000000000000000
[  100.819656] RDX: 0000000000000001 RSI: ffff99deb712c49c RDI: 0000000000000000
[  100.826781] RBP: ffffa9230079ef50 R08: ffff99deb712460c R09: ffff99deb712462c
[  100.833907] R10: ffff99deb7124940 R11: ffff99deb7124d70 R12: ffff99deb712ae44
[  100.841033] R13: 0000000000000001 R14: 0000000000000000 R15: ffffa9230079f0a0
[  100.848159] FS:  00007af121212640(0000) GS:ffff99deba780000(0000) knlGS:0000000000000000
[  100.856240] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  100.861980] CR2: 0000209000fe1000 CR3: 000000011b18c000 CR4: 0000000000350ee0
[  100.869106] Call Trace:
[  100.871555]  <TASK>
[  100.873655]  ? asm_sysvec_reschedule_ipi+0x12/0x20
[  100.878449]  CalculateSwathAndDETConfiguration+0x1a3/0x6dd
[  100.883937]  dml31_ModeSupportAndSystemConfigurationFull+0x2ce4/0x76da
[  100.890467]  ? kallsyms_lookup_buildid+0xc8/0x163
[  100.895173]  ? kallsyms_lookup_buildid+0xc8/0x163
[  100.899874]  ? __sprint_symbol+0x80/0x135
[  100.903883]  ? dm_update_plane_state+0x3f9/0x4d2
[  100.908500]  ? symbol_string+0xb7/0xde
[  100.912250]  ? number+0x145/0x29b
[  100.915566]  ? vsnprintf+0x341/0x5ff
[  100.919141]  ? desc_read_finalized_seq+0x39/0x87
[  100.923755]  ? update_load_avg+0x1b9/0x607
[  100.927849]  ? compute_mst_dsc_configs_for_state+0x7d/0xd5b
[  100.933416]  ? fetch_pipe_params+0xa4d/0xd0c
[  100.937686]  ? dc_fpu_end+0x3d/0xa8
[  100.941175]  dml_get_voltage_level+0x16b/0x180
[  100.945619]  dcn30_internal_validate_bw+0x10e/0x89b
[  100.950495]  ? dcn31_validate_bandwidth+0x68/0x1fc
[  100.955285]  ? resource_build_scaling_params+0x98b/0xb8c
[  100.960595]  ? dcn31_validate_bandwidth+0x68/0x1fc
[  100.965384]  dcn31_validate_bandwidth+0x9a/0x1fc
[  100.970001]  dc_validate_global_state+0x238/0x295
[  100.974703]  amdgpu_dm_atomic_check+0x9c1/0xbce
[  100.979235]  ? _printk+0x59/0x73
[  100.982467]  drm_atomic_check_only+0x403/0x78b
[  100.986912]  drm_mode_atomic_ioctl+0x49b/0x546
[  100.991358]  ? drm_ioctl+0x1c1/0x3b3
[  100.994936]  ? drm_atomic_set_property+0x92a/0x92a
[  100.999725]  drm_ioctl_kernel+0xdc/0x149
[  101.003648]  drm_ioctl+0x27f/0x3b3
[  101.007051]  ? drm_atomic_set_property+0x92a/0x92a
[  101.011842]  amdgpu_drm_ioctl+0x49/0x7d
[  101.015679]  __se_sys_ioctl+0x7c/0xb8
[  101.015685]  do_syscall_64+0x5f/0xb8
[  101.015690]  ? __irq_exit_rcu+0x34/0x96

[HOW]
It calles populate_dml_pipes which uses doubles to initialize.
Adding FPU protection avoids context switch and probable loss of vba context
as there is potential contention while drm debug logs are enabled.

Signed-off-by: CHANDAN VURDIGERE NATARAJ <chandan.vurdigerenataraj@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 826970f2bd0a..f27262417abe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1750,7 +1750,9 @@ bool dcn31_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	DC_FP_START();
 	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate);
+	DC_FP_END();
 
 	// Disable fast_validate to set min dcfclk in alculate_wm_and_dlg
 	if (pipe_cnt == 0)
-- 
2.25.1

