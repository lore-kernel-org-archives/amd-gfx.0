Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6EAC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 21:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15F6810E7CC;
	Thu, 16 Jun 2022 21:09:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7DED10E7CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 21:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/4aI5XOHh7dlXMkK9s9PvIqkcmXRBVEW3HO5bAT6UvhCOYo2f6dxpIUeYUxkQtQt2g4aNIbGIUaiiQfmHDo8yE/0jK7c5r+gNfIioR9UMZ+e/52V6dUKjYgdBwOjIj2MWmp31NBJG9WDJHqMQEn9v1zF69qH92kc+s7K7U/V9YKj/U8WQlKRQ8N1DvQ9y+sXlAsAUyOQJZmtOiVOwZcAwewyx/p6dxVXuKwRDnCvP/Hb5tcVWvRzg24X/rbIpgZk3QLsOlPkcebRmQaERefW5Rp90Z5RPJlGyM7b09kAejQpGKGb293ZVDnzN/simIbzUDm0dmXzRvKrfWbeMXdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nSS7QXHBrdy4wXE2UjI3UpkQKYfK0KmXZTq6ird5iY=;
 b=BD92RhyQNCxs2ftI9d0ddnXOGRAdSmVDy1GD3HuDg2hZpzszzcf4YKJ3Dq9kqClExAZ1w5tIIEW6t5k67kMFTZ+n+NOWrPharF0UgTbsyTz4eDkWH4mGeWFYJXochZpxZwXFmv2D6hAmFYsDz9z9H48U0lvxx4BO1SkVdD7/fBGtXKcnFIIcvkcvPbXPf+6fAUpFTEB88tXlV/K9Cg0dQF0eTL6cDTnTg07AKEL1mh6qAsiesRlQVQanjoCwkumjaC/H7JTkCQ2SZinpA6hwVqyGz8ozbfNf4OtoHkwYlyG8n+uG8rnRZLdRXczBZqeUd47usurs7esSOY/0XevwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nSS7QXHBrdy4wXE2UjI3UpkQKYfK0KmXZTq6ird5iY=;
 b=PPplnH6/rQqAhZbjENYKepJfonUxtNn+8Vgdd78FqhhBGY1fbxbpV7Bpo03ei9EoZYrJ8wf5Z4iEjGLUjYm3icyMxG6W4eXNzGaGP9/6WKkb2UdJJEJMGxJSBsefTZMMiuA/vW5Q2l89OvgUx8LQZKeSaazDTgYlMU4oRBEgYaY=
Received: from DM5PR2001CA0015.namprd20.prod.outlook.com (2603:10b6:4:16::25)
 by BN8PR12MB3346.namprd12.prod.outlook.com (2603:10b6:408:45::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 21:09:05 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::fe) by DM5PR2001CA0015.outlook.office365.com
 (2603:10b6:4:16::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
 Transport; Thu, 16 Jun 2022 21:09:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Thu, 16 Jun 2022 21:09:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 16:09:04 -0500
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 16 Jun 2022 16:09:04 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: add missing reg defs for DCN3x HUBBUB
Date: Thu, 16 Jun 2022 17:08:59 -0400
Message-ID: <20220616210859.1054753-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ff6d33d-3626-4076-8b3f-08da4fdc720b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3346:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB334677E80EC4170A0D7F10788BAC9@BN8PR12MB3346.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KPUpbBUNJvKLLqO8Myu4a3IkgUWp4QUd/C6VpLrCFX6iW6LzjKgTf42kf8pIv0z3h14pwDElEvXp01kgRihnJ1oKeyZdW8glEF8UQsolpoKmA6MMOERnbxJfYrF402ful+i1JnQYGBjk7+TQs9iv8rJVQaFtc0ypy6BcMt4V9qrGMPGbVJCPziSHMV9XekiIkI37NVjddVPWtf31VaY8XoEu1rlosz96CXu5BCbQYyYhBGqtJctfWFU9h/Cb2HktgZsQg3b3KEf2c6WWdOzG0d2o3o8cUGrQCmvjic5B8GVkO86nGVomOzXfMkw9LKkRqCNUHIcm+XhmZGj5PolJUiu/yNwz2IpQYCloDLdwKGW4BD2T3r1qJwLOOhIlbUTmX37t95WiEXTQOOounpdSK6Jkbq6zXr449p5iNobj+tBw5sKrDgR+yZP7Drs/wAJBvqXqUlM/mptsEukLDaDsL0GixBagm1Fzet+OqT479v99cdpz07zi/+kfDK+w/6FWNgtaq4VFMsDY5far2dSjuvlj2ffQmgEj6m3Btq1SIBbRb221oC0xesyUwWHnIZtIuZfY9ey9+7YBaMdthMxtSvtUgrm9B7PUPYhXibdTD5v/XrVfgq58fpSW29KUIZfVlUFFfd/UBnHK3kpsahpBwt7Q2FS1AmWzg/sKpfZ1TnF80X+kq+beTV2ALM3QJGpbPBou5tA6P6ehp2KSJa5cZyhNz+5XRyjp03aXq+R1HeQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(44832011)(45080400002)(356005)(8936002)(5660300002)(508600001)(83380400001)(40460700003)(1076003)(186003)(26005)(6666004)(82310400005)(7696005)(426003)(2906002)(86362001)(47076005)(70206006)(4326008)(70586007)(8676002)(316002)(6916009)(36756003)(54906003)(2616005)(81166007)(336012)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 21:09:05.0011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff6d33d-3626-4076-8b3f-08da4fdc720b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3346
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
Cc: rodrigo.siqueira@amd.com, aurabindo.pillai@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
The omitted register definition caused call traces like:

[    3.811215] WARNING: CPU: 7 PID: 794 at drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:120 set_reg_field_values.constprop.0+0xc7/0xe0 [amdgpu]
[    3.811406] Modules linked in: amdgpu(+) drm_ttm_helper ttm iommu_v2 gpu_sched drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcopyarea drm i2c_piix4 drm_panel_orientation_quirks
[    3.811419] CPU: 7 PID: 794 Comm: systemd-udevd Not tainted 5.16.0-kfd+ #132
[    3.811422] Hardware name: System manufacturer System Product Name/ROG STRIX B450-F GAMING, BIOS 3003 12/09/2019
[    3.811425] RIP: 0010:set_reg_field_values.constprop.0+0xc7/0xe0 [amdgpu]
[    3.811615] Code: 08 49 89 51 08 8b 08 48 8d 42 08 49 89 41 08 44 8b 02 48 8d 50 08 0f b6 c9 49 89 51 08 8b 00 45 85 c0 75 b3 0f 0b eb af 5d c3 <0f> 0b e9 48 ff ff ff 49 8b 51 08 eb d0 49 8b 41 08 eb d5 66 0f 1f
[    3.811619] RSP: 0018:ffffb8c1c04cf640 EFLAGS: 00010246
[    3.811621] RAX: 0000000000000000 RBX: ffff96f2100d8800 RCX: 0000000000000000
[    3.811623] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffb8c1c04cf650
[    3.811625] RBP: ffffb8c1c04cf640 R08: 000000000000047f R09: ffffb8c1c04cf658
[    3.811627] R10: ffff96f5161ff000 R11: ffff96f5161ff000 R12: ffff96f204afb9c0
[    3.811629] R13: 0000000000000000 R14: ffff96f202b94c00 R15: ffffb8c1c04cf718
[    3.811631] FS:  00007fe07c2e2880(0000) GS:ffff96f5059c0000(0000) knlGS:0000000000000000
[    3.811634] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.811636] CR2: 0000559634ab57b8 CR3: 0000000120674000 CR4: 00000000003506e0
[    3.811637] Call Trace:
[    3.811640]  <TASK>
[    3.811642]  generic_reg_update_ex+0x69/0x200 [amdgpu]
[    3.811831]  ? _printk+0x58/0x6f
[    3.811836]  dcn32_init_crb+0x18f/0x1b0 [amdgpu]
[    3.812031]  dcn32_init_hw+0x379/0x6a0 [amdgpu]
[    3.812223]  dc_hardware_init+0xba/0x100 [amdgpu]
[    3.812415]  amdgpu_dm_init.isra.0.cold+0x166/0x1867 [amdgpu]
[    3.812616]  ? dev_vprintk_emit+0x139/0x15d
[    3.812621]  ? dev_printk_emit+0x4e/0x65
[    3.812624]  dm_hw_init+0x12/0x30 [amdgpu]
[    3.812820]  amdgpu_device_init.cold+0x130d/0x178c [amdgpu]
[    3.813017]  ? pci_read_config_word+0x25/0x40
[    3.813021]  amdgpu_driver_load_kms+0x1a/0x130 [amdgpu]
[    3.813178]  amdgpu_pci_probe+0x130/0x330 [amdgpu]

Fixes: 7ea50d53 ("drm/amd: add register headers for DCN32/321")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h          | 2 ++
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_offset.h  | 2 ++
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h | 3 +++
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_offset.h  | 2 ++
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_sh_mask.h | 4 ++++
 5 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
index 8d3ea8ee5b3b..3bae6e558971 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
@@ -65,6 +65,7 @@
 	SR(DCHUBBUB_DET3_CTRL),\
 	SR(DCHUBBUB_COMPBUF_CTRL),\
 	SR(COMPBUF_RESERVED_SPACE),\
+	SR(DCHUBBUB_DEBUG_CTRL_0),\
 	SR(DCHUBBUB_ARB_USR_RETRAINING_CNTL),\
 	SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_A),\
 	SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_B),\
@@ -118,6 +119,7 @@
 	HUBBUB_SF(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_B, DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_B, mask_sh), \
 	HUBBUB_SF(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_C, DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_C, mask_sh), \
 	HUBBUB_SF(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D, DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_DEBUG_CTRL_0, DET_DEPTH, mask_sh),\
 	HUBBUB_SF(DCHUBBUB_DET0_CTRL, DET0_SIZE, mask_sh),\
 	HUBBUB_SF(DCHUBBUB_DET0_CTRL, DET0_SIZE_CURRENT, mask_sh),\
 	HUBBUB_SF(DCHUBBUB_DET1_CTRL, DET1_SIZE, mask_sh),\
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_offset.h
index 6f84ea5c006f..14c29ce4c7b3 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_offset.h
@@ -1807,6 +1807,8 @@
 #define regDCHUBBUB_DET2_CTRL_BASE_IDX                                                                  2
 #define regDCHUBBUB_DET3_CTRL                                                                           0x04be
 #define regDCHUBBUB_DET3_CTRL_BASE_IDX                                                                  2
+#define regDCHUBBUB_DEBUG_CTRL_0                                                                        0x04c5
+#define regDCHUBBUB_DEBUG_CTRL_0_BASE_IDX                                                               2
 #define regDCHUBBUB_MEM_PWR_MODE_CTRL                                                                   0x04c0
 #define regDCHUBBUB_MEM_PWR_MODE_CTRL_BASE_IDX                                                          2
 #define regCOMPBUF_MEM_PWR_CTRL_1                                                                       0x04c1
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h
index d42f91560bb9..0691e328d0f0 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h
@@ -6348,6 +6348,9 @@
 #define COMPBUF_RESERVED_SPACE__COMPBUF_RESERVED_SPACE_64B_MASK                                               0x00000FFFL
 #define COMPBUF_RESERVED_SPACE__COMPBUF_RESERVED_SPACE_ZS_MASK                                                0x0FFF0000L
 
+//DCHUBBUB_DEBUG_CTRL_0
+#define DCHUBBUB_DEBUG_CTRL_0__DET_DEPTH__SHIFT                                                               0x10
+#define DCHUBBUB_DEBUG_CTRL_0__DET_DEPTH_MASK                                                                 0x07FF0000L
 
 // addressBlock: dcn_dc_dchubbubl_hubbub_vmrq_if_dispdec
 //DCN_VM_CONTEXT0_CNTL
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_offset.h
index e40a924c02ce..3bd8792fd7b3 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_offset.h
@@ -1817,6 +1817,8 @@
 #define regDCHUBBUB_MEM_PWR_STATUS_BASE_IDX                                                             2
 #define regCOMPBUF_RESERVED_SPACE                                                                       0x04c4
 #define regCOMPBUF_RESERVED_SPACE_BASE_IDX                                                              2
+#define regDCHUBBUB_DEBUG_CTRL_0                                                                        0x04c5
+#define regDCHUBBUB_DEBUG_CTRL_0_BASE_IDX                                                               2
 
 
 // addressBlock: dce_dc_dchubbubl_hubbub_vmrq_if_dispdec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_sh_mask.h
index 23faa628cd59..e82dffc2b9b0 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_sh_mask.h
@@ -6350,6 +6350,10 @@
 #define COMPBUF_RESERVED_SPACE__COMPBUF_RESERVED_SPACE_64B_MASK                                               0x00000FFFL
 #define COMPBUF_RESERVED_SPACE__COMPBUF_RESERVED_SPACE_ZS_MASK                                                0x0FFF0000L
 
+//DCHUBBUB_DEBUG_CTRL_0
+#define DCHUBBUB_DEBUG_CTRL_0__DET_DEPTH__SHIFT                                                               0x10
+#define DCHUBBUB_DEBUG_CTRL_0__DET_DEPTH_MASK                                                                 0x07FF0000L
+
 
 // addressBlock: dce_dc_dchubbubl_hubbub_vmrq_if_dispdec
 //DCN_VM_CONTEXT0_CNTL
-- 
2.36.1

