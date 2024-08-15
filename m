Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116F9C531DE
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 22:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A89F610E552;
	Thu, 15 Aug 2024 22:45:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p6HKOv3J";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 356B210E550
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 22:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOTOQnU7o6XiOwdp/qo7Q19GvpSXUIkij3alFzXvoVSBPlp/KaVqhMDzE8PvZ1afZD8+O0itCCmCHT2RIRsQwF71HxB980yoLUhPu6lTmF1SMGQuGkdIZEfQV42/4I+SH4vkQTG1mSfwf+p6zle9k48vr6tb8RFpj6lk1uMVcMJLWRj+ret3fzzU5/Hn9MJTN3QNyEmYfsE9dzWyfZV6Q48xufbqr1oRX/u2Qkft4LY0zjvywHlFUiTGfRTf3DZZ+4f1e4nskCFy9F7b9uRHQGjU4skXthdfoubi1DAK32Zf154Vl5tKbyuej65qb11bM49idkqPRmmw9Qi+UDOziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxcscfyzjqkPxbRy97YDRe63Z5X3ksRguMHYIxcwMbA=;
 b=giygIKzK3TuCmEal9H+16n7rNJSDs9fQb9nyHkS8tUva+r5g4kbY5pXqqveBf31xzhOkPhLPpo1V78z8GNEFKrwus585YAvhumoaRoH4FYt5uDC+Ejn4FH/t4bRoymQk9to/tHPtCTrxx9VFPSjuSjLm3ZX5RUgERyyfftxNXiGzqx9bHANAEto8VtWvr3ltyUJnTcKJwS2dkY2c2NsekiV6ZlyC2ogaz+g2iBFXJbwwUJvKFiRqxalFa++GSbJXquokMLs9Rp8Zdbu0WNg1mBcRvrEUzJ/tsrP3VeEcULKlEIBqmn6kaM7CdbzCnnGmiMqDVyLQH6JT5QxOjwMTfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxcscfyzjqkPxbRy97YDRe63Z5X3ksRguMHYIxcwMbA=;
 b=p6HKOv3JdVR7MjW/vMFV+HJObpQdI8RgqTYpCNVz6SiPjFXWIxsWLDL12G6ItiPL3HKm8v81JdclJcLKhNUwlDjfPi/OVr+BZfY3XOgIIO/qIcv3TVsIql57xapKkxpEpaLDeF4OMYI6phnCKDRPt/0H7BtqMt0e12yjHnNFljM=
Received: from MN2PR08CA0027.namprd08.prod.outlook.com (2603:10b6:208:239::32)
 by DM3PR12MB9287.namprd12.prod.outlook.com (2603:10b6:8:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 22:45:50 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::2d) by MN2PR08CA0027.outlook.office365.com
 (2603:10b6:208:239::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Thu, 15 Aug 2024 22:45:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 22:45:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 17:45:49 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 15 Aug 2024 17:45:43 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Tim Huang <tim.huang@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 10/13] drm/amd/display: fix double free issue during amdgpu
 module unload
Date: Thu, 15 Aug 2024 18:45:22 -0400
Message-ID: <20240815224525.3077505-11-Roman.Li@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DM3PR12MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: 50473313-c163-43bb-c63c-08dcbd7c02bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HoG1XzlumEE7jpmujLrkOivDJhKokwTYkhLKK/ZUNZ82OB6k4XiCWP1ReCzK?=
 =?us-ascii?Q?n7hKqujzxAoVzDEFj87AxeAeZxklx61H1HhW9nxkFm3s4NdNzrvEmhUlK8+w?=
 =?us-ascii?Q?+bS9kGEotZWXrokdoqtbPxuSrbQ1hh4wVWX0Gy54TjzhZFv+eYX2PMWpEEyu?=
 =?us-ascii?Q?75t4RvVAa5nEtdcReXil8M1/g3OUgcfLmpI4+vk7pMfyjqAbiBVPwp6WEAkv?=
 =?us-ascii?Q?MBx49FAt3eYaFwC7ppUQFE8KvNYqtuaHYWjuhcTho+KPYaFAbxcfwvswSiQC?=
 =?us-ascii?Q?lsFH5oQackYBYjBL0bLdJ1i0HCwYExMmxySmfY8oQUDXo6R5Ve7sTtCIIkcK?=
 =?us-ascii?Q?NVzXZtdolwSmtnEPGLJ2nYKMhlxA9uknX1yFim+i9oFi/qzldcNFowinL4EE?=
 =?us-ascii?Q?RJCyo+WQ1S0LhYf+fOOFhFLcMEvmuxszOCZdMusJB+Ab+q91x8cRv7UnkS6l?=
 =?us-ascii?Q?cf/xHJ+zeg2YV8oOFv5dU+e+TCTjr7kPS1XlW31xYPVAnqL3J3fbVKxc6eIg?=
 =?us-ascii?Q?3v4QWF8QeAAk5YqGJ55nTmvvO5AHUw3G06Z4Ct4mfyiyjLcGP4TQA9scvgu2?=
 =?us-ascii?Q?A3IC1tNiTXlx6BKMFyAx6OpEtnYFD+YJCKM3Bqrp0osgoi4CaLGOZY8Nq/uz?=
 =?us-ascii?Q?7GeDJRIAbQ3SpibrObYNxD6A1SU/Zvi6rKEcBouOq8uhxb5xfdpKyglkz5Gj?=
 =?us-ascii?Q?miWQJ+JQtveIYhiLsRXZ9+v/1fXL61JkOuxQE7vYYHO0/YZ2D+8QR9nLkc67?=
 =?us-ascii?Q?Ax142bwVD6tCmrHqo9JsbQsCU0061HpjXT/+VbRvU+sn5PrGyekZ2nNWl7o0?=
 =?us-ascii?Q?lCnRRkgraox4hWFxKcHk9wEpOAgsMf0zrCWFuExFUa1faaEge5guaLAS1ZNl?=
 =?us-ascii?Q?+IrXTLySCxcy3Dsp6idEbvmM24KrxL6SOq94uGLSITmac7B/ad1yiwGwIssH?=
 =?us-ascii?Q?QPS/tH3Ltr+0j5gGfz55AkhpVkWjwc8QvSS3EWMei2vyBEPdSHWSYGDCtR8u?=
 =?us-ascii?Q?UGZYi05DuZTrXUlsCE16SFKcm+awf+obUquSe1YsT7ffZTVycqhaUv9dTy3K?=
 =?us-ascii?Q?qSvhUMwdnuRWzJwrTCdxUu73WuGp9Z8rZ/YpP2so/RKqHIKM7A3LwkKFg+Xr?=
 =?us-ascii?Q?uT/XZDkXMDO9ehU5bEDQSpcdjS6lwsYCTf0cZEV6w0/PKvwjZY7o2kLR9Aw6?=
 =?us-ascii?Q?ji/t/XI4qmWFn2lUBsm8Uq5fIOlyKTuu92IgV/RPuWIeTruWKQxyw/aYcmqq?=
 =?us-ascii?Q?nIYT5QBVU1C31CfKIKKvizEXyn6ZCAN6axd1ZlqWXPl/Fs18T7jbn2GufCzu?=
 =?us-ascii?Q?2bLlMj7cX0M14xUUJK+/cCJlsoh52lJ5S7dz2qOljmV26XXMslSlWpQ6xRxe?=
 =?us-ascii?Q?fq1O+fxDXGW7DB54q4d+Q5d02C1vcGgW4ITDpNeFxIAXN7/NYclwbqckHCu7?=
 =?us-ascii?Q?3klWkWWFneDAoC8w+5kWJ0XGjs4KTLRi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 22:45:49.8703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50473313-c163-43bb-c63c-08dcbd7c02bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9287
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

From: Tim Huang <tim.huang@amd.com>

Flexible endpoints use DIGs from available inflexible endpoints,
so only the encoders of inflexible links need to be freed.
Otherwise, a double free issue may occur when unloading the
amdgpu module.

[  279.190523] RIP: 0010:__slab_free+0x152/0x2f0
[  279.190577] Call Trace:
[  279.190580]  <TASK>
[  279.190582]  ? show_regs+0x69/0x80
[  279.190590]  ? die+0x3b/0x90
[  279.190595]  ? do_trap+0xc8/0xe0
[  279.190601]  ? do_error_trap+0x73/0xa0
[  279.190605]  ? __slab_free+0x152/0x2f0
[  279.190609]  ? exc_invalid_op+0x56/0x70
[  279.190616]  ? __slab_free+0x152/0x2f0
[  279.190642]  ? asm_exc_invalid_op+0x1f/0x30
[  279.190648]  ? dcn10_link_encoder_destroy+0x19/0x30 [amdgpu]
[  279.191096]  ? __slab_free+0x152/0x2f0
[  279.191102]  ? dcn10_link_encoder_destroy+0x19/0x30 [amdgpu]
[  279.191469]  kfree+0x260/0x2b0
[  279.191474]  dcn10_link_encoder_destroy+0x19/0x30 [amdgpu]
[  279.191821]  link_destroy+0xd7/0x130 [amdgpu]
[  279.192248]  dc_destruct+0x90/0x270 [amdgpu]
[  279.192666]  dc_destroy+0x19/0x40 [amdgpu]
[  279.193020]  amdgpu_dm_fini+0x16e/0x200 [amdgpu]
[  279.193432]  dm_hw_fini+0x26/0x40 [amdgpu]
[  279.193795]  amdgpu_device_fini_hw+0x24c/0x400 [amdgpu]
[  279.194108]  amdgpu_driver_unload_kms+0x4f/0x70 [amdgpu]
[  279.194436]  amdgpu_pci_remove+0x40/0x80 [amdgpu]
[  279.194632]  pci_device_remove+0x3a/0xa0
[  279.194638]  device_remove+0x40/0x70
[  279.194642]  device_release_driver_internal+0x1ad/0x210
[  279.194647]  driver_detach+0x4e/0xa0
[  279.194650]  bus_remove_driver+0x6f/0xf0
[  279.194653]  driver_unregister+0x33/0x60
[  279.194657]  pci_unregister_driver+0x44/0x90
[  279.194662]  amdgpu_exit+0x19/0x1f0 [amdgpu]
[  279.194939]  __do_sys_delete_module.isra.0+0x198/0x2f0
[  279.194946]  __x64_sys_delete_module+0x16/0x20
[  279.194950]  do_syscall_64+0x58/0x120
[  279.194954]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  279.194980]  </TASK>

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_factory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 85fd6e422238..5e1b5ab9fbc6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -385,7 +385,7 @@ static void link_destruct(struct dc_link *link)
 	if (link->panel_cntl)
 		link->panel_cntl->funcs->destroy(&link->panel_cntl);
 
-	if (link->link_enc) {
+	if (link->link_enc && !link->is_dig_mapping_flexible) {
 		/* Update link encoder resource tracking variables. These are used for
 		 * the dynamic assignment of link encoders to streams. Virtual links
 		 * are not assigned encoder resources on creation.
-- 
2.34.1

