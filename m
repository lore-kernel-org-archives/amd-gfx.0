Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B39CF3195
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 04:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1693810E699;
	Wed,  2 Oct 2024 04:41:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VcOBYtB+";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B3810E697
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:41:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmWAZCHBeVQ6FsmQbIAS790ySenriKk+AqBIGp54WDyuynX8aSC8+7DUs9BCx9Jjd69wLg7MkC82Irh5BPyzXVCbGy/tYsotpxWBdRxSX70jzumEA9ZsTwGPAJkJz3oAUDF8asm3Ca52C1HhaD0vgD4v/fZAqsGCsua9PYMFJTQFzJ+1zWpoqcH6iZ4W8g5s9Bya6RgmhpvuXmYDGuSMFloJusmIZHKDo5E4K6zseWiY7/4Wh3CWCco68kykbSDW/B2YveNvDTKCyaSU5BLMC5M1dUt8ezrUAJTl97UhCuTcXlBdECULK9MTPl4qiUMC1UFOj8lfynRGbw6UJ0j+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSdeqHGrP+Uh0G4jtNR5GDN8B4nhGi3raqE6fbm2Ono=;
 b=JvhNJ+NUNHme5VC6JVP7b3BBs4pb6X7yxAhkjQbj2v3jFAsyCtBsADyeA7w/duj8raU5aQyrBIo+gSSmhkUxtoAAeiDU2DwuApVGrAN3gdzhmXXYhpjjgStLKEFoUbSx/cmlGWnHypMqJ0GpxkY9jutl3EU7kxhA9SmMpSFoPXkLG1wkdKJJibLZ2qHWJgipndhAZfnbtD6bNP8dz3Xug70lhw9kQRGGSk3cXvH+URJuoF3a+a/cP99jR0Z4RbSLGnkdOujihATKGaO3shnSDoOENgjWpfimtwh2Pxvq53ok0lrX/paD+gcPbAeLcYyDlikGNzT8vCtYZ1vYEARB+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSdeqHGrP+Uh0G4jtNR5GDN8B4nhGi3raqE6fbm2Ono=;
 b=VcOBYtB+tMJJndOsMTUPUP1ekrABHZjh0eoVCHoGg7iB4baeWXnVy1LnAp/Z7JHvi9sPZCOyWNiTeT2z3jcCRhxRBpIaz6CRJVL2zVXCbetlss5TzesJ5KL6QnCXynkhrUE1NT8Oyw2MfGN1iW+lOtvO2r3KKFF4aYjcBJUjxUE=
Received: from SA0PR11CA0032.namprd11.prod.outlook.com (2603:10b6:806:d0::7)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.28; Wed, 2 Oct
 2024 04:41:01 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:d0:cafe::15) by SA0PR11CA0032.outlook.office365.com
 (2603:10b6:806:d0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Wed, 2 Oct 2024 04:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:41:00 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 23:40:08 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 1/6] drm/amdgpu/gfx10: Implement cleaner shader support for
 GFX10 hardware
Date: Wed, 2 Oct 2024 10:09:31 +0530
Message-ID: <20241002043936.2960921-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8f8d67-fd5b-4a11-1e5b-08dce29c6a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFdXSEE4Y1FvWjVLOHd6dSs3ZmhFM0o0ekJwYXFKQ1BkTXpWcnpZMUtHZnBk?=
 =?utf-8?B?ZnFWbFFGcFFVSnE0M0l3QWpUd2M0ck5sRVlTUTNlZmpBY2NPT0I1TjQyY3Vp?=
 =?utf-8?B?S0FSencvVWc3V0dqTXNFYm1pNkJDRzdqbXgwd21leS9kZXd1dzU2eFpOd2Vx?=
 =?utf-8?B?RVY2N3hTVEtxcUhFZUlFYU9QRDU4TlJhanQ5MXRhcE94YzRZcE54TFJMb2Uz?=
 =?utf-8?B?T2V5bTJla3NUV0N2SFY3RXlCSFgwV3Z4Wk53UjJIYzN1MjJmNGQ3U2ttME00?=
 =?utf-8?B?c3Qvd3dCbkF5UnRLV29GUHJzVm5vdTZrck9GanNueThvQmQ5VS96LzdPR3RE?=
 =?utf-8?B?ZHl1NVZlQ0ZGL1l3c1BOSm9YWWVBOHZ4TEVwallZamZqM1B6MDVTS25RL3Av?=
 =?utf-8?B?S2pkUEg0aHNvVTdWcnZTZlNxNytzM3NaZWlPcVVuTjZYN0U4TUxIRVVzY1hs?=
 =?utf-8?B?ZG5qTTd3UjYvb1U4N2ZseUErQXNnVTNuRmorZzBkalkybXpobE5wUzN4RjNk?=
 =?utf-8?B?K0RjRndUR1RYYk1ncWpObXY5TGV6YmFPVUZZRXZvdEFHSEVTSnhWKzNmSHdp?=
 =?utf-8?B?dXpHNC8wSUxaQXhSblVLZ2FjVFdNNWRQbzVlQ2YrRnpka0t5N0hJSkJZNzFJ?=
 =?utf-8?B?S3F4bm15RnRQVWNXdmdHTWY5S01vbnBhY1Irck1kVmpTSWdhMkVUZnhTaHU3?=
 =?utf-8?B?WkxuYll1K1pFQ3hQSS9Gc2NadWdPeFZjenI0cm9UYUh0WWpxaE44cEpPeTJ1?=
 =?utf-8?B?UGpWRGZVZnNQeXVET3IzK1d5Y1VwN0tRZ2JkdUZrVE03amMxbHAwS0NuUEZr?=
 =?utf-8?B?WTUyLzNpMEQxNllTRWtjeEp0TlNrcnVsdVJvajlhenQ5ak5GOVBZcDNjVTQz?=
 =?utf-8?B?ZXFPU0xLKzFOLzRWS255dHkxeEI0bzlvZ05VT0ZhUTNjRjNDRXM1d21DbktP?=
 =?utf-8?B?UkY4MGYybXl0MG5uU0k0SGhRVldUR1lPRWF1bU9QNDFRRndya09XcGhxQ1V5?=
 =?utf-8?B?L0NGdHFtTjRCdUExaVAvOTljNTlVaVUyMGl4enptekR2a1Nhak1PbjRYYWYy?=
 =?utf-8?B?c1dLTWwxcGJLV1kzN2RxSlRLT2dQS1dwa0JhYklXQlVzdGZBUnRrRzJTRGlZ?=
 =?utf-8?B?NGxHMWxhN0lmWGMzNFg5ZVZYL1h1M0ZXL0hPdDg1MkRjcFY0dkZsQUpwZENs?=
 =?utf-8?B?b2F6WHNkdTY3d3czWkticzJ6Y2hvZXVnMzFSYmlmNVJlTmZCT3IyTk5jTlh5?=
 =?utf-8?B?ZXNuSW9rbC9OSkJOL1hOMFdXWkpzS2FrRmdrVStYMysraFN3N0JFT1AzeUlG?=
 =?utf-8?B?NWVqTFc1QkR0SDQ1NTlqY3VJcFE4TXBqTVhOdXExZk1lMGlxUGVEeDJQY3h2?=
 =?utf-8?B?Ty8rLzBJbGpIMUpjTFZvVmxRQk14UXE4Nmx3MkZMTXZZdndQUytIV0QyNGFk?=
 =?utf-8?B?R1owQ0Y0a2V5My9sMzBZeXE0WnNCYXRNdDFlUjF1ajk5bndsMVJLNUVNa3RP?=
 =?utf-8?B?ZDJudmVBZG9kUVUyZHA3UlNtNU9SM2FwZTRJbGxJYTVaRjZ0dERDc0ZDSStS?=
 =?utf-8?B?OXdoaGRGOVR3OEMyVTNoeDVhN2pQM2pKcjNuSFY4ZnFTVDlKUVVCc0VPVEoy?=
 =?utf-8?B?ZEJRWksydUR0b0ZpQVNwaGovR0svSXJWZTJpZFZianZUSTlqNkYzbE04bmFD?=
 =?utf-8?B?aGJaMzR5L1pGbWhZYlNIZ0luelBJVmUxV0JoK1NMeDR2cC8wYXV6SGZiVyt4?=
 =?utf-8?B?ZWxUM2tLYTBqTktmY2ljMzQrbEtyWE9halNyWTZjMEFPT0JuOGlvdkFZUXMv?=
 =?utf-8?B?VkJVODRIMjFjMFBtdVZzUTRCRjlXL1NrL1pLck1kbldmZ2paVU9mVm5ySmk4?=
 =?utf-8?B?aWU3YXVTTXVsMHJhMVgrT2swN2I3VnFHdUdyRVJnTnZqZVJQVUhaMzlWVGMx?=
 =?utf-8?Q?3owTPOjlPlY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:41:00.6829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8f8d67-fd5b-4a11-1e5b-08dce29c6a6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888
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

The patch modifies the gfx_v10_0_kiq_set_resources function to write
the cleaner shader's memory controller address to the ring buffer. It
also adds a new function, gfx_v10_0_ring_emit_cleaner_shader, which
emits the PACKET3_RUN_CLEANER_SHADER packet to the ring buffer.

This patch adds support for the PACKET3_RUN_CLEANER_SHADER packet in the
gfx_v10_0 module. This packet is used to emit the cleaner shader, which
is used to clear GPU memory before it's reused, helping to prevent data
leakage between different processes.

Finally, the patch updates the ring function structures to include the
new gfx_v10_0_ring_emit_cleaner_shader function. This allows the
cleaner shader to be emitted as part of the ring's operations.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 40 +++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index c544ea2aea6e..2b230971c58a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3677,13 +3677,19 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 					  enum amd_powergating_state state);
 static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
 {
+	struct amdgpu_device *adev = kiq_ring->adev;
+	u64 shader_mc_addr;
+
+	/* Cleaner shader MC address */
+	shader_mc_addr = adev->gfx.cleaner_shader_gpu_addr >> 8;
+
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
 	amdgpu_ring_write(kiq_ring, PACKET3_SET_RESOURCES_VMID_MASK(0) |
 			  PACKET3_SET_RESOURCES_QUEUE_TYPE(0));	/* vmid_mask:0 queue_type:0 (KIQ) */
 	amdgpu_ring_write(kiq_ring, lower_32_bits(queue_mask));	/* queue mask lo */
 	amdgpu_ring_write(kiq_ring, upper_32_bits(queue_mask));	/* queue mask hi */
-	amdgpu_ring_write(kiq_ring, 0);	/* gws mask lo */
-	amdgpu_ring_write(kiq_ring, 0);	/* gws mask hi */
+	amdgpu_ring_write(kiq_ring, lower_32_bits(shader_mc_addr)); /* cleaner shader addr lo */
+	amdgpu_ring_write(kiq_ring, upper_32_bits(shader_mc_addr)); /* cleaner shader addr hi */
 	amdgpu_ring_write(kiq_ring, 0);	/* oac mask */
 	amdgpu_ring_write(kiq_ring, 0);	/* gds heap base:0, gds heap size:0 */
 }
@@ -4557,6 +4563,7 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
 		break;
 	}
 
+	adev->gfx.xcc_mask = 1;
 	adev->gfx.config.gb_addr_config = gb_addr_config;
 
 	adev->gfx.config.gb_addr_config_fields.num_pipes = 1 <<
@@ -4726,6 +4733,11 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.mec.num_queue_per_pipe = 8;
 		break;
 	}
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	default:
+		adev->gfx.enable_cleaner_shader = false;
+		break;
+	}
 
 	/* KIQ event */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP,
@@ -4842,6 +4854,9 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v10_0_alloc_ip_dump(adev);
 
+	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	if (r)
+		return r;
 	return 0;
 }
 
@@ -4881,6 +4896,8 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq[0].ring);
 	amdgpu_gfx_kiq_fini(adev, 0);
 
+	amdgpu_gfx_cleaner_shader_sw_fini(adev);
+
 	gfx_v10_0_pfp_fini(adev);
 	gfx_v10_0_ce_fini(adev);
 	gfx_v10_0_me_fini(adev);
@@ -4891,6 +4908,7 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block *ip_block)
 		gfx_v10_0_rlc_backdoor_autoload_buffer_fini(adev);
 
 	gfx_v10_0_free_microcode(adev);
+	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
@@ -7374,6 +7392,9 @@ static int gfx_v10_0_hw_init(void *handle)
 	if (!amdgpu_emu_mode)
 		gfx_v10_0_init_golden_registers(adev);
 
+	amdgpu_gfx_cleaner_shader_init(adev, adev->gfx.cleaner_shader_size,
+				       adev->gfx.cleaner_shader_ptr);
+
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 		/**
 		 * For gfx 10, rlc firmware loading relies on smu firmware is
@@ -9699,6 +9720,13 @@ static void gfx_v10_ip_dump(struct amdgpu_ip_block *ip_block)
 	amdgpu_gfx_off_ctrl(adev, true);
 }
 
+static void gfx_v10_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
+{
+	/* Emit the cleaner shader */
+	amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER, 0));
+	amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zero */
+}
+
 static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
 	.name = "gfx_v10_0",
 	.early_init = gfx_v10_0_early_init,
@@ -9749,7 +9777,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 		5 + /* HDP_INVL */
 		8 + 8 + /* FENCE x2 */
 		2 + /* SWITCH_BUFFER */
-		8, /* gfx_v10_0_emit_mem_sync */
+		8 + /* gfx_v10_0_emit_mem_sync */
+		2, /* gfx_v10_0_ring_emit_cleaner_shader */
 	.emit_ib_size =	4, /* gfx_v10_0_ring_emit_ib_gfx */
 	.emit_ib = gfx_v10_0_ring_emit_ib_gfx,
 	.emit_fence = gfx_v10_0_ring_emit_fence,
@@ -9772,6 +9801,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kgq,
+	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
 };
 
 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
@@ -9791,7 +9821,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* gfx_v10_0_ring_emit_vm_flush */
 		8 + 8 + 8 + /* gfx_v10_0_ring_emit_fence x3 for user fence, vm fence */
-		8, /* gfx_v10_0_emit_mem_sync */
+		8 + /* gfx_v10_0_emit_mem_sync */
+		2, /* gfx_v10_0_ring_emit_cleaner_shader */
 	.emit_ib_size =	7, /* gfx_v10_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v10_0_ring_emit_ib_compute,
 	.emit_fence = gfx_v10_0_ring_emit_fence,
@@ -9809,6 +9840,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kcq,
+	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
 };
 
 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
-- 
2.34.1

