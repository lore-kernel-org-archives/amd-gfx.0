Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63308C44500
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 06:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEAB710E138;
	Thu, 22 Jan 2026 06:56:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fsLjBSSA";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFC1D88697
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 06:56:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClQ8wuJ2KIvA4NZzX8zaq9h3/ihEHEfbbwaoUJP72BuUlLg23oKwV4wuQIUh2+RXcxpUTCJ2dZ8ulq4Eb8Vg0m1mILxO2kQzWrJy+WLWEH13TUlnKvTcoP3GWsnKa0HE0RPsu+CcmCfYOlpNfyRmjMSArqnTOfQ5IrmBhnfQy6uwxUykfqV2Vr0CR6wGVqGbBr1jAaQ1qKObYT/cf6YbanxKEgsIp5t9bXzDVBfDZOkStZi0Dexc+YYWvUztRNzhSZFndB58JyZ9TWXq18JO0bU0Svpb6BkgBl1RKwqeMbYHp+nPRwsK6mFbInLFGSE/8tzo9H6tYd1CW/NbKV8meg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjtC4Ib0CMYt5t4LM/naV5lCWa+0wnNHx3N/vegq7I4=;
 b=d556Gs/JhNgSAVdHw6fByux5QYX5/DHhB5Et2I2ydGLE+77eZphxmwofId23IuzYTW8zpWW7ml5dPpbZ9QbTO92xgtx7Z7kCyX2A8LmkkzQzoRT02f1gemC1NmCufmevbr+s1RgFHFqria3qWtW57j+duNNZDVR1XE6z3d/dHMjk3geQcihV9tlR2RnlE0L4JtioT9ZmbSJz+Cg+MofWvCQ7i1gaJ6QXsqx3C6i6OJuTb0f6UBnv+g4jLswHMtcuh0qEgpN2C4dlow15Lh6CpSZkqkbiQabq9x50t32zIWd/S2eIgKD701m1PG0a8kgAJW94//Z2Ye0e1M2ZnoACsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjtC4Ib0CMYt5t4LM/naV5lCWa+0wnNHx3N/vegq7I4=;
 b=fsLjBSSAQrll1yqZpJjbNsgaksE0w6kg4xsaBICcE90Qt757SWhKJP8UxT3oirgzdwnAeJ7Aru/JPMPG6VR7evY+lZnXBGKQCzeTONRUGov1Hu1ZXu4c8oeKXNjagcnYcgbk8f20/mybxbbVEVxXwfHdPjnW5It9Klthky1gJ/c=
Received: from BN9PR03CA0136.namprd03.prod.outlook.com (2603:10b6:408:fe::21)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 06:56:00 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:fe:cafe::c6) by BN9PR03CA0136.outlook.office365.com
 (2603:10b6:408:fe::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 06:55:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 06:56:00 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 00:55:58 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Mangesh.Gadre@amd.com>, <Stanley.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: Skip vcn poison irq release on VF
Date: Thu, 22 Jan 2026 12:25:37 +0530
Message-ID: <20260122065538.1595301-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|SA0PR12MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: b39c8fee-9394-4641-6ec4-08de59834cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cYZYZY+oyBNPYt5Z3ZIRV9gsukwfPLu0U0k2FNYQrboLXwG90OWIne///xf/?=
 =?us-ascii?Q?sTJmrc2ifID8m5TmYrkOmHdo/R8FB5VuFCgV6FLqU84E2VjGgLBR68+U2kbK?=
 =?us-ascii?Q?C+NT3Nk2uagKsgWBwMdFhROt3d31SJwiocnxrpngDhpQlHDgEDeyjoJJODH1?=
 =?us-ascii?Q?lETgBTaYOBZYcoG08gLuJ3NRQfnA3XUafrL0VdOhfJYMWmJZrlYodx4Xg3Xl?=
 =?us-ascii?Q?Q7NQz/MCo0rU2/EGlPD+0fOjMuhJVJ2j6TwZjikPdvM1Fi3s6veBpuZXX7TQ?=
 =?us-ascii?Q?oXRowwTBKdIiBw+xvKQmA1n7fZUcUyCP+XezszdYKZtOKOKqKmLgWZ85OApR?=
 =?us-ascii?Q?G2Gy04uxF7EW0NalKESAJsesQjmohW//DxAqVybgiCWEsSeTKNO0YbrxzZha?=
 =?us-ascii?Q?R9ie2pVfXcmgEdq8eyymVxqKTneMxVSr1ASaSmST7Nt8vV6Fdm9KXc3wzBQZ?=
 =?us-ascii?Q?AiZc9P2kr6vWDg2M9iz15i4BTV0Jep7ex6igsUK6T3Mcoe+XTnVTvEuZa3rC?=
 =?us-ascii?Q?PVc/ZGsqS9JssKNCH1NOhveKrEocP5cXXHPAuyhKbNj5urxiWE7LbtsubKuY?=
 =?us-ascii?Q?Utf2SsGmZcrOPvdfgnz0Al1ZMjjjdreSOZ2b/O5GLzQ66NrVTGzBiAdxyQJ2?=
 =?us-ascii?Q?Nixq7TE197RSolS2KeXDBF76VWTwcx/vOF7DkHvkZ64taWJ30XZ+usg6Rfv7?=
 =?us-ascii?Q?CyoI54U8UjiJlUTQ97LLkhBSN2FjNK6zWEy8oEiynGEBKf0XWSzenNpGFaKH?=
 =?us-ascii?Q?eNGbYquy+aXiZLcG1EV1e7+gMeyj09TeK5y4dShJXXyoIUF/HxDDEkmKr9zI?=
 =?us-ascii?Q?TQY2ANrf4TIYBN2XeGSNIATIn4Uj/NN+QxzMl2ctuw3UZtaZRDxHG9pmFuff?=
 =?us-ascii?Q?Oqr5Y2EiocWiZXLO1bi1+r4zyaWNRnOhD4LsgURZwgDzvPtsjihr43UyGe/E?=
 =?us-ascii?Q?dbjz9W5xifceGeVw4cPw/6b8sksUrMIeq9WrqtWIqroc597bI0NTgZbJHVA4?=
 =?us-ascii?Q?RKOv+iGfluPCW6+uHBWunwvUI+WnGgWI3dXLhYkmMq5Lo4ZRsWKoCIAt2OSY?=
 =?us-ascii?Q?3/haJF3QR7eEGjy2r+gW2WPY06rkS37vZ+quA0m6Y8ZVRoi++BBV4RYRUHz+?=
 =?us-ascii?Q?9zs4o/aTvpWmyhVXgq35I4yTX8vY4nEGCbvw/zy3tJSqT8GiBHAVgdxRET/x?=
 =?us-ascii?Q?b92YRc0ddJn8U1dPRxXwYsrYdcyTVkfqgo9Xoxn2WCUqIbEGA6nIhjZzvZYi?=
 =?us-ascii?Q?BMfeI34GSGyHE5WhHjcqpTymVOFys/b17aiwCNU3+IXqumtwu71G9mhz2kxs?=
 =?us-ascii?Q?6bdt6QVMDVLSN6yCcvIK5nE0sIksg8F5557GdOk2MP3NDbBmWBufaiJF3C3g?=
 =?us-ascii?Q?ujhPdk4jnUxOxw/cEzz3cp1CuJJiGWh75g2zVVWTjkOseYtfTKjjjB/JRhUh?=
 =?us-ascii?Q?YDIiBnb5NNzRC5G/Anyo4+zBbc3mv+wJBzkbORPX7PPAXkq1IVbMSrMIoIHz?=
 =?us-ascii?Q?eWyxRfu+GWlBCe6iEF4fPBOyLAE7+9n80h1re/K6UtSkXNU4TCO4o8onpWcH?=
 =?us-ascii?Q?iVrSKtgTg+0rbZMKf076e/oV9tbAN6DB8toAvZVAmxapuvSJfEPGY6C4yCIA?=
 =?us-ascii?Q?tl5e8zCR1PCCpF+x5u6U4dFbzM9ZFEqK6qqFXOIzqnFhmH7E7j9Lv0DyQPrI?=
 =?us-ascii?Q?RsXD7g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 06:56:00.0088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b39c8fee-9394-4641-6ec4-08de59834cfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398
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

VF doesn't enable VCN poison irq in VCNv2.5. Skip releasing it and avoid
call trace during deinitialization.

[   71.913601] [drm] clean up the vf2pf work item
[   71.915088] ------------[ cut here ]------------
[   71.915092] WARNING: CPU: 3 PID: 1079 at /tmp/amd.aFkFvSQl/amd/amdgpu/amdgpu_irq.c:641 amdgpu_irq_put+0xc6/0xe0 [amdgpu]
[   71.915355] Modules linked in: amdgpu(OE-) amddrm_ttm_helper(OE) amdttm(OE) amddrm_buddy(OE) amdxcp(OE) amddrm_exec(OE) amd_sched(OE) amdkcl(OE) drm_suballoc_helper drm_display_helper cec rc_core i2c_algo_bit video wmi binfmt_misc nls_iso8859_1 intel_rapl_msr intel_rapl_common input_leds joydev serio_raw mac_hid qemu_fw_cfg sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 hid_generic crct10dif_pclmul crc32_pclmul polyval_clmulni polyval_generic ghash_clmulni_intel usbhid 8139too sha256_ssse3 sha1_ssse3 hid psmouse bochs i2c_i801 ahci drm_vram_helper libahci i2c_smbus lpc_ich drm_ttm_helper 8139cp mii ttm aesni_intel crypto_simd cryptd
[   71.915484] CPU: 3 PID: 1079 Comm: rmmod Tainted: G           OE      6.8.0-87-generic #88~22.04.1-Ubuntu
[   71.915489] Hardware name: Red Hat KVM/RHEL, BIOS 1.16.3-2.el9_5.1 04/01/2014
[   71.915492] RIP: 0010:amdgpu_irq_put+0xc6/0xe0 [amdgpu]
[   71.915768] Code: 75 84 b8 ea ff ff ff eb d4 44 89 ea 48 89 de 4c 89 e7 e8 fd fc ff ff 5b 41 5c 41 5d 41 5e 5d 31 d2 31 f6 31 ff e9 55 30 3b c7 <0f> 0b eb d4 b8 fe ff ff ff eb a8 e9 b7 3b 8a 00 66 2e 0f 1f 84 00
[   71.915771] RSP: 0018:ffffcf0800eafa30 EFLAGS: 00010246
[   71.915775] RAX: 0000000000000000 RBX: ffff891bda4b0668 RCX: 0000000000000000
[   71.915777] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   71.915779] RBP: ffffcf0800eafa50 R08: 0000000000000000 R09: 0000000000000000
[   71.915781] R10: 0000000000000000 R11: 0000000000000000 R12: ffff891bda480000
[   71.915782] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
[   71.915792] FS:  000070cff87c4c40(0000) GS:ffff893abfb80000(0000) knlGS:0000000000000000
[   71.915795] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   71.915797] CR2: 00005fa13073e478 CR3: 000000010d634006 CR4: 0000000000770ef0
[   71.915800] PKRU: 55555554
[   71.915802] Call Trace:
[   71.915805]  <TASK>
[   71.915809]  vcn_v2_5_hw_fini+0x19e/0x1e0 [amdgpu]

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index cebee453871c..006a15451197 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -521,7 +521,9 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
 			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 
-		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
+		/* VF doesn't enable interrupt operations for RAS */
+		if (!amdgpu_sriov_vf(adev) &&
+		    amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
 			amdgpu_irq_put(adev, &vinst->ras_poison_irq, 0);
 	}
 
-- 
2.49.0

