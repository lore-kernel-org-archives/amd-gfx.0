Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34915CF256A
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 02:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA02410E55A;
	Wed, 19 Nov 2025 02:59:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dRTA1lf/";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013050.outbound.protection.outlook.com
 [40.93.196.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76E2E10E55A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 02:59:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vy/76IvnEYVUApFoXQo5U26H6dvBILOusgdGc+cXtOeohlGeXAhScjBThz7LqB+i3bR5y6DzPpZkdSmNBEML4GrB+cgOnOitoMecWM4bQLhakw2mq9aS/lHUR1IlKyIMbTptqMQgA4KBBXQ9WkilJMoE4NoTXGJ0I/GEYPwXArlfJ3xoYyOdXJoE14+KfFZPK3dE/3n8bGXz2RAhcJnoK06RzTQjZf84OCJfFXvCDNl/sGGlkpcEnKMRFgDG2zhonP0y1fIIam03MgvaS1VYt/Q0C66k2UgyXfzh7pDJ8y9e9RBfQrgA3Tju0lsX5YnN1Ich1zSwHKTnFAWPvrFP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0AtRKyOmQxfPfhQCJg3GbhThAfnKQbWrpHEWFmvWM4=;
 b=moq5dHMPy7j0dXEmEmF16MqG7Rp2S07QoNQzgDj0qIq/UPtjaZkca62Bue+SGnHDbK016dRI5Ewgu+MurmxE/x+g9O/nWVKWzOTtmkqcPrvELLat3NMIYM+fTKd+DeLe7lDhF1J+/YE1ugNZQkeJNFzcU4+lAhlVxxXlgBXxMKGOlv9mj7t5S4rHj5I/1rd7pw2Sdjq1q2I7uFj7fRQrE+o9STgGWKprq0TZmGCtbPlkicQvJ2JAVrfk31RR2UW743QCpSAkdvr6TKpE2d7jg4zhtw8r2ZVtk5zp9D95Jp8wJ+XHWuq1cnd4mhfWqLl2sCOtdQ4hHZVrPCTveVdwgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0AtRKyOmQxfPfhQCJg3GbhThAfnKQbWrpHEWFmvWM4=;
 b=dRTA1lf/6IsA3TBQjOEHtd89Zv4rC8dUq2yap8RrEt576S/FdxEWgk83d0pzjetHM6og/banQdEHDki8/kfN/Rxu05O9DQCgIIBbLIUTDFDov+JbR1C7dgqp9VmssIzAoYeCZTjzMm5mybnXl2w6P+sxgD+N6rf4HokDOAY0RkY=
Received: from BYAPR07CA0101.namprd07.prod.outlook.com (2603:10b6:a03:12b::42)
 by CYYPR12MB8891.namprd12.prod.outlook.com (2603:10b6:930:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 02:59:41 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::f0) by BYAPR07CA0101.outlook.office365.com
 (2603:10b6:a03:12b::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 02:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 02:59:40 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 18:59:38 -0800
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>, <candice.li@amd.com>
Subject: [PATCH] drm/amd/pm: fix amdgpu_irq enabled counter unbalanced on smu
 v11.0
Date: Wed, 19 Nov 2025 10:59:27 +0800
Message-ID: <20251119025927.1813858-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|CYYPR12MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: eb1bfcc8-2ace-442f-e60d-08de2717af08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KhIJ7TsXWSfGfB1EiroUOIFY2PuTWTgllSOtoO4nxAY+ssWaMKkdxMGNvi+5?=
 =?us-ascii?Q?1MohzQSUHf2Htoye+27rG+CQ6YeE2oumCJwBPL3cbd/sQXHgTfJi7eKRdThC?=
 =?us-ascii?Q?PmDj2nVIjlaAHBYxxHzNmQiaOy9+CFnYYH5YrwM2AABDm1y8AWFyavXotQc5?=
 =?us-ascii?Q?fMearwSHqZbEatHLpkFZyK4EYbo4i6iEydBnMy5MLpjKgs+Z4+5o970U1E4C?=
 =?us-ascii?Q?/aH/f/jtsCapEnusTkX2RspTSbU/c/c54fAooLhkKT7wEy6NCrLLFrAfot+y?=
 =?us-ascii?Q?F9lhBSeoas9NDuwjXx/sAewHDQzRuIS5mQTz9dQkLwtT45M6JV3f2ZNWx+BS?=
 =?us-ascii?Q?sFMxQq0mdczNoQXBKIc/YQQLnLPkJ2Fr6Jd4+504K+nGk82pU11XZaKFGHfO?=
 =?us-ascii?Q?fo0f9HsW7YCGW8UoeE15DXsUEdO1PCQqcjnAQVyI5jBEH9eWsSXRw/WGnND+?=
 =?us-ascii?Q?911780M1gqAYR8InIru3kvl5FN3n4ywcrP96ai/B0D9yPasbNPppMoTbBat4?=
 =?us-ascii?Q?BYn3zyV8JYwLCU7lCB30RzR0bJxvCiR4pM9idcf3JCX127Nd+1d9gVPkLqeN?=
 =?us-ascii?Q?Fxt9tJYUooQ+ykeLcErhfy600S44CYLWKvBNg8FeBcWaPTnDUKzoD2DsKDEL?=
 =?us-ascii?Q?+GmzlSA3YyhSm3XhWQjFXurbFEZNja77xSHnXYYXiOi7HGVxV3oEMyWjdAsv?=
 =?us-ascii?Q?h1NtaWRWpwc0s8WSupZJwp4UYiX+B+jfpi1jxPQvWbP8EsBkoMpSk0SbTWOa?=
 =?us-ascii?Q?c9u2N9zUobwP+WL70M2vUdt9Dbkf/XlfCKUWX6MWZr7Lio/n+tXhAtB3bayN?=
 =?us-ascii?Q?sEWZ+OYtZGl/iyD0kFjfOQ+ztXKrpUVIbQmdvLeznUzsDTNRrQyiJeETJfBa?=
 =?us-ascii?Q?1yz6f2xMs8O5tch/i0ok/3m2Omdn9E1Z83cc9+vPe32DXsetpOolg7GExFRY?=
 =?us-ascii?Q?nb6Wg5VmNPyXDAzGSh6vLBN/gERtdyO9Twc4GHLflvItAfwPV0sHPW4aCMf5?=
 =?us-ascii?Q?2SUNHBOSHdTLjq5NTDynYfCzJ4blX+xFNyO/2le7DN45PmBXFTAIsCBUGnU9?=
 =?us-ascii?Q?J0jqOFPl4Er4BKNOgJ5UhfUOO9E2edJtArw5WjFPne+Mp6RrVHJ0Tz+9mkZD?=
 =?us-ascii?Q?Ef8BpGsmj1yBc/4xzwJxgIpsoI3LSlLqk9wyLbVlYfmhXSCSug/T5cTl67p4?=
 =?us-ascii?Q?cR0ighXcLE6/+GVjPZGDLJMTOYyC7msJZ81dBn8TMXOvHrPRsAbmr2ZWRdHW?=
 =?us-ascii?Q?w2Z0k/ReZ87UF8udBYd6trmTVxppcYSW2jmB1wYkdVPWp9tUYQ9x1nrYhASP?=
 =?us-ascii?Q?fwn/R8NH5CYJ/wK7uFj0HyiTWJA/KtAN8ts+ljVkWky/gsSJRyqJsCcGFxw2?=
 =?us-ascii?Q?ltYHE+2iNtClzQP4BeL56gnsJ8csix2ENe8hX6tp47ESaew+icChDMFzXPP3?=
 =?us-ascii?Q?XC0YB2unbpXWLTdq+cb9QylRAclPlA3dxQ2GDsQK2qWEeBzZgKF8ouToogeB?=
 =?us-ascii?Q?19hVwQeWn4f25LpuvD82pBzB0M+x7TE5CYk8sj0lRC1qzOhHRCjaqHyWR9tW?=
 =?us-ascii?Q?F60jcwqGIzhJ/EhfF44=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 02:59:40.6181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1bfcc8-2ace-442f-e60d-08de2717af08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8891
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

fix amdgpu_irq enabled counter unbalanced issue on smu_v11_0_disable_thermal_alert.

[  357.773144] ------------[ cut here ]------------
[  357.773156] WARNING: CPU: 21 PID: 2202 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xd8/0xf0 [amdgpu]
...
[  357.774651] Tainted: [E]=UNSIGNED_MODULE
[  357.774656] Hardware name: GIGABYTE MZ01-CE0-00/MZ01-CE0-00, BIOS F14a 08/14/2020
[  357.774664] RIP: 0010:amdgpu_irq_put+0xd8/0xf0 [amdgpu]
[  357.775563] Code: 31 f6 31 ff e9 f9 c3 4f cb 44 89 f2 4c 89 e6 4c 89 ef e8 db fc ff ff 5b 41 5c 41 5d 41 5e 5d 31 d2 31 f6 31 ff e9 d8 c3 4f cb <0f> 0b eb c3 b8 fe ff ff ff eb 97 e9 d3 8d 8b 00 0f 1f 84 00 00 00
[  357.775573] RSP: 0018:ffffd28616ecba58 EFLAGS: 00010246
[  357.775584] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[  357.775592] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  357.775598] RBP: ffffd28616ecba78 R08: 0000000000000000 R09: 0000000000000000
[  357.775605] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8aac201a8008
[  357.775611] R13: ffff8aac0e600000 R14: 0000000000000000 R15: ffff8aac201a8000
[  357.775618] FS:  0000751c697b7c40(0000) GS:ffff8acb4fba2000(0000) knlGS:0000000000000000
[  357.775627] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  357.775634] CR2: 00005a844a5e7028 CR3: 0000001039a0f000 CR4: 00000000003506f0
[  357.775642] Call Trace:
[  357.775649]  <TASK>
[  357.775663]  smu_v11_0_disable_thermal_alert+0x17/0x30 [amdgpu]
[  357.776704]  smu_smc_hw_cleanup+0x79/0x500 [amdgpu]
[  357.777857]  smu_hw_fini+0x139/0x200 [amdgpu]
[  357.778908]  amdgpu_ip_block_hw_fini+0x29/0xc0 [amdgpu]
[  357.779698]  amdgpu_device_fini_hw+0x2e5/0x560 [amdgpu]
[  357.780487]  ? blocking_notifier_chain_unregister+0x3e/0x70
[  357.780511]  amdgpu_driver_unload_kms+0x4b/0x70 [amdgpu]
[  357.781334]  amdgpu_pci_remove+0x50/0x90 [amdgpu]
[  357.782126]  pci_device_remove+0x41/0xc0
[  357.782145]  device_remove+0x46/0x80
[  357.782159]  device_release_driver_internal+0x203/0x270
[  357.782169]  ? srso_return_thunk+0x5/0x5f
[  357.782189]  driver_detach+0x4a/0xa0
[  357.782201]  bus_remove_driver+0x83/0x110
[  357.782216]  driver_unregister+0x31/0x60
[  357.782227]  pci_unregister_driver+0x40/0x90
[  357.782244]  amdgpu_exit+0x15/0x3b [amdgpu]

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 78e4186d06cc..24d9f576846b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1022,7 +1022,12 @@ int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
 
 int smu_v11_0_disable_thermal_alert(struct smu_context *smu)
 {
-	return amdgpu_irq_put(smu->adev, &smu->irq_source, 0);
+	int ret = 0;
+
+	if (smu->smu_table.thermal_controller_type)
+		ret = amdgpu_irq_get(smu->adev, &smu->irq_source, 0);
+
+	return ret;
 }
 
 static uint16_t convert_to_vddc(uint8_t vid)
-- 
2.34.1

