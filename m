Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2924BC531DE
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 22:45:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA47210E53F;
	Thu, 15 Aug 2024 22:45:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IvmcA0k8";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1499910E541
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 22:45:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iS7lDVuzHBYXJeqPnKuTGJ/mEZ10hl+mbXxO+T95O+9Le5VS+j1hcy2kISyCeKQsYRkeQwmEm2sSvLClJuU4YtR2kquT6nY4dXYQa/32xkPoqnkjgvttLAaEBhzxFgeNC1RuUky95ldNfTpP8S+SachTZLduaqMxRSU6T09r4BIMTFYJFeyNoBJmkiLweYR3PKt7DukBkJ8eLfJeyC9F7ShLc5nHmMkd3Wcm/FFE6F8Q/HRtZ1Ne4e771ehcDLP8joXVIL0tosh0/GWYlEApc6aDrbpEtHy1jZboQ3OPKRDhEyaY0CFh9Kf9VjUf47yIBbDYJssMt3Bh+Qn7S3XOnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Gj5OG6JpctUdpYMzg19GcDc2LvfEHm+nMEvnbz5+is=;
 b=itXbvyJW7EHH3PfO14MNFLULr0sOmJmrlEPYM8/vfh36EVN2dE/QkqzO1ZoYQmD4fXdGWtVI80Y7g5QeCIbHhawcZHwEByi8gTnHDyFizL73fQIiYJUm/SjDpMYqTI4gEFcV+bFFSsh0+IAbIG2MjQ1CX2gryJvl4dEVR0EsAZ7yJrmHZTZ5kGCH8g+VpyTLRA2trXV6BWJ57dUc5rwKVT+vycoR68wenrhaFQ11JbcpY+WxY2NmxgGtx8WPu4CXSDdjSWFX6Aux7jVajhPYx/lKDQi96A7MTbjqFcne6BdcT0d2aiNdgkUmk7oXfhKzb8fSabXQGdjxIcXsCx0Pug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Gj5OG6JpctUdpYMzg19GcDc2LvfEHm+nMEvnbz5+is=;
 b=IvmcA0k81dX9u4c1fCFV+qZLVQaHHvFzu6LgR7uGR2UuZcxeLb1LuJ5K7OCfWKeA7AzS14g4wreC2mQT/26dzfwt7yKmwnJb4zIJr4qzdqElzg3pOIlVPpJ75PmRKiM3G4aPcvwZbqIhcZJuNoTM6Jx6YTIYKj9uP4yAdAbRJPM=
Received: from MN2PR08CA0004.namprd08.prod.outlook.com (2603:10b6:208:239::9)
 by MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Thu, 15 Aug
 2024 22:45:42 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::88) by MN2PR08CA0004.outlook.office365.com
 (2603:10b6:208:239::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Thu, 15 Aug 2024 22:45:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 22:45:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 17:45:39 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 15 Aug 2024 17:45:34 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 03/13] drm/amd/display: remove an extraneous call for checking
 dchub clock
Date: Thu, 15 Aug 2024 18:45:15 -0400
Message-ID: <20240815224525.3077505-4-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815224525.3077505-1-Roman.Li@amd.com>
References: <20240815224525.3077505-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|MN2PR12MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: c25dac55-6348-4c83-c990-08dcbd7bfd13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9DZxuTcYyNHYrUM0asMGhZ+zdOCyILccVmcy/ONSeCWrNJEBMUIoUPrwzCkL?=
 =?us-ascii?Q?SkyjeWfjES4F0CpVCDB3h1eEKTmk8bhdNsmCOF4FmY2QFw51+sGVhyzKp/Cu?=
 =?us-ascii?Q?aa6cbdaYTJegtCffOkcbJlRYO4MwgvK1GNzEqTr+VW4xSnmKmDK9O6n9WVdv?=
 =?us-ascii?Q?AFGYEIgVmEkmhT8xA1TvvvYzE4m/C5n3/19l8IMlRE5pP4U/k4lvnfdakoEf?=
 =?us-ascii?Q?jqJ1rJ/JVSoN9giRhRQwtRlqcGk5i5Ljrka1BaCZBV8K1jIwWiNjRg6rOFAt?=
 =?us-ascii?Q?7bHYiPQm1JmThZZmH99+Q+pHg6vimbdEUDF7sTao1cOYijN/Af5ynvmb0vbc?=
 =?us-ascii?Q?UD/AU3ntT1dG1YrzQLEgGuDmmwBu+jmaKTJneZuV8SPbBAQCTiGcozSlHgd0?=
 =?us-ascii?Q?NHtPVao0wxqCpl5oD4JkLZPjxScUAUaoFG6b8KpALH1XRGlV8IiTvPj7YfaA?=
 =?us-ascii?Q?PdNNuqMOX7lPMDkct/bvnwJl5e3RNMVIq/3sYutL2m/FGDwocvBzbKfwDTyv?=
 =?us-ascii?Q?iuuagPW4y2VB8zCNZ7rvl8gv2cTyXg6HGrnMIFPPDHqCkWrgYkJRYafv61ZX?=
 =?us-ascii?Q?qoafYR9rvSBA9x6DPNrqAzb6+t1IL0+qTJV1XgNl/6Pz2zlUhOKwmuvGXB+f?=
 =?us-ascii?Q?lo9oDuAFn1/4VNZimF1R8lUdVGWQunQh8gnbLeuGmMorkH29W+H5IzouNLEb?=
 =?us-ascii?Q?oyv8zH+tt68cjfVPrlZR8LT2+DqijS9kpYBPGi0ja7Y3h3KyiCfSGmGWFhws?=
 =?us-ascii?Q?cpzAjYGQAMJag2Dz2bYU2r7c8hieo/NfMU7MpJ+OWEzdz5WeyT2/8CBrjE6n?=
 =?us-ascii?Q?465uHfx64NiO62BhXSFOsp4VWqPVhTOP4GwEtBjLrm6ct+8ZMu1iW9PdKHpS?=
 =?us-ascii?Q?GkdFewAUSV7RBWy6k7JxnlbEGKR3/OH+X44aX4tqfT04PnOjCsu0XjSFc7RD?=
 =?us-ascii?Q?lF8nRyaq0StbVx6x2WTnbA9654sZ/KpQHxUUI09LWs/Y8dmIBou/xxSQTuvb?=
 =?us-ascii?Q?hAwTFB4ImcQMAZZOsvgRtinkUJ9aK790zRVjBL/yLGUm/HB9NptVlX7q4KNM?=
 =?us-ascii?Q?wKj2Ti7zCleo1ZRZtHdxWNMMb9uRMCpRpgLwAusipcr33vz7/Csd5DBbQ/9L?=
 =?us-ascii?Q?ZAPLDNGAid8dK/eEbnblJF999RPfCQgouViM57U/1cUx4sqNFSQAwYNkAcox?=
 =?us-ascii?Q?PT1eSK2WxkCT4bLnnPxkIyzfGX8WO5lTp2AgiN7Qm0o2wrJfuy6o2khfAPiC?=
 =?us-ascii?Q?VphxdgIjkcQbHPFuDojPi7TLuicM5W1V0lBjo9Kwz9cUtYgc+TCVUZQjBo51?=
 =?us-ascii?Q?sLUcEwUe13I9AvYCUB954I+50BMLdgoz1neaBvUyhGapntfanV6iQGxMI46X?=
 =?us-ascii?Q?6wbqzLC1TjIY2XBIp1F9p4QZ7HlzYzTk7Iza6lepFzPlwfEgfhjXuRxg9DWr?=
 =?us-ascii?Q?fnxETdkymR1ptG678hvVV7t9G9fR0JS0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 22:45:40.3546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c25dac55-6348-4c83-c990-08dcbd7bfd13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

when removing the amdgpu module and reinserting it, a call trace is
triggered:

[  334.230602] RIP: 0010:hubbub2_get_dchub_ref_freq+0xbb/0xe0 [amdgpu]
[  334.230807] Code: 25 28 00 00 00 75 3c 48 8d 65 f0 5b 41 5c 5d 31 c0 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9 45 31 d2 45 31 db e9 55 a1 ca de <0f> 0b eb c6 0f 0b eb c2 d1 eb 8d 83 c0 63 ff ff 3d 20 4e 00 00 76
[  334.230809] RSP: 0018:ffffbc8b823fb540 EFLAGS: 00010246
[  334.230811] RAX: 0000000000001000 RBX: 00000000000186a0 RCX: 0000000000000000
[  334.230812] RDX: ffffbc8b823fb544 RSI: 0000000000000000 RDI: 0000000000000000
[  334.230813] RBP: ffffbc8b823fb560 R08: 0000000000000000 R09: 0000000000000000
[  334.230814] R10: 0000000000000000 R11: 000000000000000f R12: ffff9e644f1f2bb0
[  334.230815] R13: ffff9e6451361300 R14: 0000000000000000 R15: ffff9e6452c00000
[  334.230816] FS:  00007af7c8519000(0000) GS:ffff9e737dd00000(0000) knlGS:0000000000000000
[  334.230817] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  334.230818] CR2: 0000703576b9cbd0 CR3: 00000001095a2000 CR4: 0000000000750ee0
[  334.230819] PKRU: 55555554
[  334.230820] Call Trace:
[  334.230822]  <TASK>
[  334.230824]  ? show_regs+0x6d/0x80
[  334.230828]  ? __warn+0x89/0x160
[  334.230832]  ? hubbub2_get_dchub_ref_freq+0xbb/0xe0 [amdgpu]
[  334.231024]  ? report_bug+0x17e/0x1b0
[  334.231028]  ? handle_bug+0x46/0x90
[  334.231030]  ? exc_invalid_op+0x18/0x80
[  334.231032]  ? asm_exc_invalid_op+0x1b/0x20
[  334.231036]  ? hubbub2_get_dchub_ref_freq+0xbb/0xe0 [amdgpu]
[  334.231217]  dc_create_resource_pool+0xfd/0x320 [amdgpu]
[  334.231408]  dc_create+0x256/0x700 [amdgpu]
[  334.231588]  ? srso_alias_return_thunk+0x5/0x7f
[  334.231590]  ? dmi_matches+0xa0/0x230
[  334.231594]  amdgpu_dm_init+0x28c/0x25f0 [amdgpu]
[  334.231791]  ? prb_read_valid+0x1c/0x30
[  334.231795]  ? __irq_work_queue_local+0x43/0xf0
[  334.231798]  ? srso_alias_return_thunk+0x5/0x7f
[  334.231800]  ? irq_work_queue+0x2f/0x70
[  334.231802]  ? srso_alias_return_thunk+0x5/0x7f
[  334.231803]  ? __wake_up_klogd.part.0+0x40/0x70
[  334.231805]  ? srso_alias_return_thunk+0x5/0x7f
[  334.231807]  ? vprintk_emit+0xd9/0x210
[  334.231809]  ? set_dev_info+0x130/0x1c0
[  334.231812]  ? srso_alias_return_thunk+0x5/0x7f
[  334.231813]  ? dev_printk_emit+0xa1/0xe0
[  334.231819]  dm_hw_init+0x14/0x30 [amdgpu]
[  334.231993]  amdgpu_device_init+0x23c7/0x2fc0 [amdgpu]
[  334.232134]  ? pci_read_config_word+0x25/0x50
[  334.232139]  amdgpu_driver_load_kms+0x1a/0xd0 [amdgpu]
[  334.232284]  amdgpu_pci_probe+0x1f9/0x620 [amdgpu]

On DCN401, get_dchub_ref_freq() hook is called before init_hw() hook.
Hence, it is expected to trigger an assert. Remove the extraneous call
to get_dchub_ref_freq() to suppress the call trace

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b6377efc6253..ef585a89847b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -342,11 +342,6 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 				res_pool->ref_clocks.xtalin_clock_inKhz;
 			res_pool->ref_clocks.dchub_ref_clock_inKhz =
 				res_pool->ref_clocks.xtalin_clock_inKhz;
-			if (dc->debug.using_dml2)
-				if (res_pool->hubbub && res_pool->hubbub->funcs->get_dchub_ref_freq)
-					res_pool->hubbub->funcs->get_dchub_ref_freq(res_pool->hubbub,
-										    res_pool->ref_clocks.dccg_ref_clock_inKhz,
-										    &res_pool->ref_clocks.dchub_ref_clock_inKhz);
 		} else
 			ASSERT_CRITICAL(false);
 	}
-- 
2.34.1

