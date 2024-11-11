Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD52AD12D76
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 06:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 514E210E18C;
	Mon, 11 Nov 2024 06:30:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3XacTp1/";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04C2810E41F
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 06:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siFY9tzUuu32LgL1th79H6Bo4WX1Q2J7osNKXlUxlDZPsruiQ5xnEQm1b8QRulh/oejz8jnwlGPf7D6CuygDVhvlCumdTDvdApJtxvIGyY9zO5n24p24Utf2C6IJ2k1WzcygNoDGPljL4t2S8nKq1b6JLmXWgpgB0WoSm360L1akWyEteXchAh+Hvn9nTy0I0azbjrkg76bLQOjine/3Qp3cpimvRC5cfI814nTflSmtIgYTVnTJ64wIrhmhpDzXPAUuBTwj2Taccee/cy+ybCgLa0+a6HZwv+tU7lYXZqtY+mmxb1nQS1czyk0PD6PqKqJpAGRn2h0UYDY4R4Sezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kK/wkhfcZWB7KM7z5e3Fh6xYKMqDQDCjk0TOqfzjUw=;
 b=RxXH4vPoEvX0wrHPKkWFH/R776zRkjwnzrk9Cf/vre3GSyFZgb71z/ubwtyhr4lqtzKegkE0ot18qsjqAE35WF5Idd6o6TXEYNyicKHsVU3n/s4+M1Y95/szq41+zi4IBrk/jVbo4WdRkR5ogvJujbjh5UzP3E9qLHJTa7AS3t5SsluiavZW54M9f1irZiriNfWUY++ESeMagE1/NAd01v7DZM1MzqAY09DlrUXSDuZB88nuw59pG1dvCKoGCmewyrifeBkt4jtOgBsmbf4w+UPHU8P2qqUB3QThOwVmpt6M/8K/f7pvaX8GqyXnZf8CTzKLAaEp9zEclFDQpwdKvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kK/wkhfcZWB7KM7z5e3Fh6xYKMqDQDCjk0TOqfzjUw=;
 b=3XacTp1/MohYYyP5flHpPOSSSv26Wi+BoRfW8Nj95Rj3Mttw5e/JX53mLaqGRHWeqAHkDaszwLvd2XqCKC5vIuwolc1rMp32f3osWwgH8nmVTXEc4o9vtesfPyry76g1yRMrPndqHAn4wKjb5AD3J4ZzxVOADtzlb1fKkW9JAZo=
Received: from BL0PR02CA0014.namprd02.prod.outlook.com (2603:10b6:207:3c::27)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.25; Mon, 11 Nov
 2024 06:30:14 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::8c) by BL0PR02CA0014.outlook.office365.com
 (2603:10b6:207:3c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27 via Frontend
 Transport; Mon, 11 Nov 2024 06:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 06:30:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 00:30:13 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 00:30:13 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 11 Nov 2024 00:30:11 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <vitaly.prosyak@amd.com>, <Tim.Huang@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix double free vcn ip_dump
Date: Mon, 11 Nov 2024 14:30:11 +0800
Message-ID: <20241111063011.1380340-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: febdd219-8fb8-4807-21c2-08dd021a4d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bhpdHxt5678B7ar1rh6OZkzsoSzeq2BnJda4gewxns93KyPZ/Es+pxa/80YW?=
 =?us-ascii?Q?iXwYe6XNbim1Npn6w8ybh6kEgqS8KGuQAVSaIekmoLEMeMuzQ3KGP945dst7?=
 =?us-ascii?Q?a11s7LTx30SaiN6sxjQQ+2YG/HcIFUWaqODcDQmAg7Q+dQp0qeiZx7hNf8i9?=
 =?us-ascii?Q?0gRSoFneF7Az+qU/P5ggqf7MAu1c+4+0p73Pik3Ih2715Ad5gPjN0fwexTVy?=
 =?us-ascii?Q?KZmDwT2Z3IZLnvvzaRpY9vC0fXzJkQDVYgEiAR1+k9iheTNSonCBz8uZxCKf?=
 =?us-ascii?Q?t9+NcKoSBQrb9MaVXjQnZgpJnhyFW0yeWwy24RggP4zOhMjM6KkQhIJS0tVp?=
 =?us-ascii?Q?2yYyOqEmhylTP6FpAYLOPPJqKWRm49LO51R4/KmCr0umvVapzwzFsusOVP/d?=
 =?us-ascii?Q?OEXONSekTZNGcguvgtPLI12SwaH3NbwC1BaWg6q+ZXyEPIAG4l5m0b+FpuP2?=
 =?us-ascii?Q?y2VwOGBWwXigzu/gFG456JvUhAYD9SB/ct0l1Sb502Ex+pyDmJEzvA/Yw0KM?=
 =?us-ascii?Q?EIIGSPbv+w+YuPpPtNBOy7UMUeN6okiuGQ+SAhx7vP05xh7RRAfL902wcHp6?=
 =?us-ascii?Q?wSESWHFo8eZlQRdoA06W6VFP19Hy3O2crhl31sc3AsGFnY6dGDCxL9ShNzMO?=
 =?us-ascii?Q?fRbTNAkUqOt+yhrz8ptpyotLXQyIcUNU8ih5QKh3AmAx/BGyALeNwXdhi/bK?=
 =?us-ascii?Q?d7WUbyWsft9WSBnrtgKwZeTM5wlFeEDNYPZUcSw9shVbQP15uBdnKC+AR//s?=
 =?us-ascii?Q?bFMQx27yszda29yIpOCISWeqUETEnRxal3Bo+XceEyb3DbhlCB/eqJOuz6Cj?=
 =?us-ascii?Q?ukKWX+vtdh8m6A7m18ezVgwKxqjS7I7vlsSOdKtNhjB8na4p4ok29Ax6BD4K?=
 =?us-ascii?Q?3BkUEhQMf7EBeCh2cbllsDQPSLFWj3cVd5DVGW/QwlNyqubCJjvsz6qOC18F?=
 =?us-ascii?Q?MWDS7gyFXyJMBeUpUEYzQQvJRnXwBBLKMl5wEXFaD9sy7EjLtK1jeyVUnlqm?=
 =?us-ascii?Q?cm1/Q0X54wLEMWRmeryOP33FMUvjf/U5M4hJakfeAHCmm5/LBrqImE6bpxxW?=
 =?us-ascii?Q?PYEpqllRjRgitNwOr9iMHaMK/ed8ww5Gfs1pPvbHPltXBbJGyPKsTsOltJUB?=
 =?us-ascii?Q?KSB5ZbExFOCLfV73JBpAyVc1qS8makbT3sVPsmWsnMgnnx5vzLBfiMHC53qn?=
 =?us-ascii?Q?KIsm9ZtSG/qCLTLzBPLwUvJrjHo7T7s6HVkP0D1D5MP9xQJaSpBUO4Y4vI8U?=
 =?us-ascii?Q?/K2KZgKRuiG9uktGOFlsFpomdjr7MsDoLtyAb/Fw5yvxWPTkCoAcc1FeuqJe?=
 =?us-ascii?Q?m7JGCHOlMj5NEAPAVYKu9lw52v5hJD3XLeCi44RfKJK1tA0lXcT5OrpwUYlZ?=
 =?us-ascii?Q?RtlODCo8BQ4mdArjpKssbFNvDMskhqiiDTOI7wGh/PmzPQns0A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 06:30:14.2013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: febdd219-8fb8-4807-21c2-08dd021a4d1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699
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

[   90.441868] ------------[ cut here ]------------
[   90.441873] kernel BUG at mm/slub.c:553!
[   90.441885] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[   90.441892] CPU: 0 PID: 1523 Comm: amd_pci_unplug Tainted: G            E      6.10.0+ #47
[   90.441900] Hardware name: AMD Splinter/Splinter-PHX2, BIOS TS41102C_925 01/05/2024
[   90.441907] RIP: 0010:__slab_free+0x1ce/0x320
[   90.441916] Code: f7 c3 00 02 00 00 0f 84 6c ff ff ff fb 0f 1f 44 00 00 e9 61 ff ff ff 41 f7 46 08 87 04 00 00 0f 85 d6 fe ff ff e9 ca fe ff ff <0f> 0b 49 3b 5c 24 28 75 bd 48 8b 44 24 28 49 89 4c 24 28 ba 01 00
[   90.441927] RSP: 0018:ffffb9c801cefcb0 EFLAGS: 00010246
[   90.441934] RAX: ffff8cdb481dcf00 RBX: 0000000000200012 RCX: ffff8cdb481dce00
[   90.441940] RDX: ffff8cdb481dce00 RSI: ffffe3f904207700 RDI: ffff8cdb40042a00
[   90.441945] RBP: ffffb9c801cefd50 R08: 0000000000000001 R09: ffffffffc149f632
[   90.441950] R10: ffff8cdb481dce00 R11: ffff8ce26e621e18 R12: ffffe3f904207700
[   90.441956] R13: ffff8cdb481dce00 R14: ffff8cdb40042a00 R15: ffff8cdb481dce00
[   90.441962] FS:  00007f0a4f3fec40(0000) GS:ffff8ce26e600000(0000) knlGS:0000000000000000
[   90.441968] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   90.441974] CR2: 000055bf74ba8930 CR3: 0000000108f48000 CR4: 0000000000750ef0
[   90.441979] PKRU: 55555554
[   90.441983] Call Trace:
[   90.441987]  <TASK>
[   90.441991]  ? show_regs+0x6b/0x80
[   90.441999]  ? __die_body+0x24/0x70
[   90.442005]  ? die+0x42/0x70
[   90.442011]  ? do_trap+0xda/0xf0
[   90.442018]  ? do_error_trap+0x76/0xa0
[   90.442023]  ? __slab_free+0x1ce/0x320
[   90.442030]  ? exc_invalid_op+0x57/0x80
[   90.442036]  ? __slab_free+0x1ce/0x320
[   90.442042]  ? asm_exc_invalid_op+0x1f/0x30
[   90.442053]  ? vcn_v4_0_sw_fini+0xc2/0x110 [amdgpu]
[   90.442308]  ? __slab_free+0x1ce/0x320
[   90.442316]  ? release_firmware.part.0+0x2e/0x50
[   90.442323]  ? srso_alias_return_thunk+0x5/0xfbef5
[   90.442332]  ? srso_alias_return_thunk+0x5/0xfbef5
[   90.442338]  ? vcn_v4_0_sw_fini+0xc2/0x110 [amdgpu]
[   90.442496]  kfree+0x23e/0x2f0
[   90.442502]  vcn_v4_0_sw_fini+0xc2/0x110 [amdgpu]
[   90.442653]  amdgpu_device_fini_sw+0x133/0x700 [amdgpu]
[   90.442835]  amdgpu_driver_release_kms+0x1a/0x30 [amdgpu]
[   90.442981]  drm_dev_release+0x2d/0x50 [drm]
[   90.443003]  drm_minor_release+0x3d/0x60 [drm]
[   90.443026]  drm_release+0x90/0xd0 [drm]
[   90.443052]  __fput+0xfa/0x2f0
[   90.443059]  __fput_sync+0x1e/0x30
[   90.443064]  __x64_sys_close+0x42/0x90
[   90.443071]  x64_sys_call+0x18f6/0x20d0
[   90.443076]  do_syscall_64+0x6f/0x110
[   90.443083]  ? do_syscall_64+0x7b/0x110
[   90.443089]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   90.443096] RIP: 0033:0x7f0a51514f67
[   90.443102] Code: ff e8 0d 16 02 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 73 ba f7 ff
[   90.443113] RSP: 002b:00007ffec29b16e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[   90.443121] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0a51514f67
[   90.443127] RDX: 0000000000000001 RSI: 00007f0a51776485 RDI: 0000000000000003
[   90.443132] RBP: 00007ffec29b1770 R08: 000055f942381170 R09: 0000000000000000
[   90.443138] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   90.443143] R13: 000055f90a2a41c0 R14: 0000000000000000 R15: 0000000000000001
[   90.443152]  </TASK>

Set ip_dump to null after releasing vcn ip_dump.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 5 ++++-
 6 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index a327c3bf84f2..b23b55539b43 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -263,7 +263,10 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_vcn_sw_fini(adev, inst);
 
-	kfree(adev->vcn.ip_dump);
+	if (adev->vcn.ip_dump) {
+		kfree(adev->vcn.ip_dump);
+		adev->vcn.ip_dump = NULL;
+	}
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index b78c6da0a3cd..df3855e7b5c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -331,7 +331,10 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_vcn_sw_fini(adev, inst);
 
-	kfree(adev->vcn.ip_dump);
+	if (adev->vcn.ip_dump) {
+		kfree(adev->vcn.ip_dump);
+		adev->vcn.ip_dump = NULL;
+	}
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 5c3b718ebdfa..d8b46f440ba5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -295,7 +295,10 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 	r = amdgpu_vcn_sw_fini(adev, inst);
 
-	kfree(adev->vcn.ip_dump);
+	if (adev->vcn.ip_dump) {
+		kfree(adev->vcn.ip_dump);
+		adev->vcn.ip_dump = NULL;
+	}
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index aa06b2fdeb7a..c71793431433 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -257,7 +257,10 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 	r = amdgpu_vcn_sw_fini(adev, inst);
 
-	kfree(adev->vcn.ip_dump);
+	if (adev->vcn.ip_dump) {
+		kfree(adev->vcn.ip_dump);
+		adev->vcn.ip_dump = NULL;
+	}
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 4e7da56a9f34..4c4b8a711b99 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -252,7 +252,10 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_vcn_sw_fini(adev, inst);
 
-	kfree(adev->vcn.ip_dump);
+	if (adev->vcn.ip_dump) {
+		kfree(adev->vcn.ip_dump);
+		adev->vcn.ip_dump = NULL;
+	}
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index a72de204f130..71f2cb75e91f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -226,7 +226,10 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 	r = amdgpu_vcn_sw_fini(adev, inst);
 
-	kfree(adev->vcn.ip_dump);
+	if (adev->vcn.ip_dump) {
+		kfree(adev->vcn.ip_dump);
+		adev->vcn.ip_dump = NULL;
+	}
 
 	return r;
 }
-- 
2.25.1

