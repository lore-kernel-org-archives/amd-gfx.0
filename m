Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A28CF9C7A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 15:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50DCC10EA2C;
	Wed, 25 Sep 2024 15:10:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K6e9NrMS";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1713910EA2C
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 15:10:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBFDdC58JNX6Rn7Uakw1qSwqYsT7rsUZG9emqxG/EBSFXYNfF2If2COOF/f1SaHe1kDOULViiq/X2+JrB0UKUbd7Sr5FVW+WILcQvSCBFZW+0uff6ngztqtn3yVpNE46PnOHu8Mhs3DQ34/WxHcDbpUuXlfoBWo0du2rVh9o2Czy0RyHxj0ry2c/f94ouj29mE8q4I53BHI3PUIQxsXZJr1PQfP+f8EIEnv2djTgaTMrFWQNP+/jd+A/yn+V8VU/pTKBgewJKzBBO2d5swlGvOHcBBKa2w6X3QVTLCizaGXIPChQkCYPymrVOnvEhROEZ5+/cRRHPJAFfCxg2u9TtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yELWu4YDwYTtQynU+1IRCojcZbq77B6QwnGTp6csMn4=;
 b=X8Q+uLel2mAk6J2nO2Lz3h7x8Ie2w+WwO+S3ESPP5e2DbRZI2b0lDFXudESRGtQlMF0BBwWQ/0jaZ8Xq//tZZPBb480zl1L7ePyzYA6rfiXYmP29DSC7GUnv8giZdgJI0OtPsTGEB32P8mlcmqOMBdEzZieFaZOPiNo3isSDsM0xis2k/0aKeFQmh1WBAE5iW3CPETFu1UwjyPOkZmRBOK2kG1dnM7jEvRx1XXotWzriNwmscLJauErazCGGCw/wNmmPKxUZrTf1ZMefsJ/nq2o7dO4NpcHl89DCQJyiyeh4/lHSYNlOe62jzNPIFDdMQCpnFFpUYqkOid353iMwAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yELWu4YDwYTtQynU+1IRCojcZbq77B6QwnGTp6csMn4=;
 b=K6e9NrMSrHMVyH4X9qqpakR3AqdHzM5BwRoINOwFGIIPjFCO96ncJiiC0vl+sS8I5ILc6e4eT2xJ+J4MHRFHp72Nm+f+czbS2DDgnM25Wp7xblXsyztvYAnQSnHt+RlkWv97Wakg2Jw2iWi8RTTcBGc9lsZuhoiX90BiKMNp6Bk=
Received: from CH2PR14CA0036.namprd14.prod.outlook.com (2603:10b6:610:56::16)
 by CYYPR12MB8751.namprd12.prod.outlook.com (2603:10b6:930:ba::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 15:10:01 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::5e) by CH2PR14CA0036.outlook.office365.com
 (2603:10b6:610:56::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26 via Frontend
 Transport; Wed, 25 Sep 2024 15:10:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 15:10:01 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 10:09:57 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH v3] drm/amd/display: Fix out-of-bounds access in
 'dcn21_link_encoder_create'
Date: Wed, 25 Sep 2024 20:39:48 +0530
Message-ID: <20240925150948.3331867-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|CYYPR12MB8751:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8ac953-f5d4-483a-236f-08dcdd7420a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VVR1xD9oPqW4zNj3YEi/o/bAaTGUY1FH4ROxENSsITUyhND4w+MQmTg6Ev3E?=
 =?us-ascii?Q?HXK0EwjqK/gz7o25UxVTBzoob1mx5vZLmJ+iWf/UEjxkUYuqctxyVx+LZc2I?=
 =?us-ascii?Q?lG/1oDeGVnNigNCRJzUjHFoL4YkgnL7HOiJGSVjWi7gcvDzsgU/t8bE67rx9?=
 =?us-ascii?Q?+akjeOSYuLrxCxQqiSpocPHzQR0BnPmbR0ZNa9h2N6d6gcJeM2uVlU15sVN0?=
 =?us-ascii?Q?9Ns7w5CIpDK0sf7j4ST5jGMzTo4Md4whlEFP+kxCMIrQo2Gy3ZkLSpovnmET?=
 =?us-ascii?Q?r4QbFs3A0bOO6UK1zi3dyl7+Hgen7Gt+YgaC+U5Gv32Dkn6uwQ1fkrrD2huP?=
 =?us-ascii?Q?vb3QgZ3jCZnLAyyIG/ulMAdChU0/b0ilh971+LX+BVFyBefVpxS/PFJOrWNW?=
 =?us-ascii?Q?2C0wUvHJnFdCrLbrtMVb3Vq+KTIGUWK7Z9pIsgYKJHE9KhxnmLrI4/Gi/9i4?=
 =?us-ascii?Q?L7qQMZ2QR3E4HyBQuhWGioeItYoCawZ64nneH63xZFFMJuK5feqrDmUFXenP?=
 =?us-ascii?Q?YQv5lUHUtcBmSaN97mmL23bRbBWC3z6L9Y4li7LCJsLrzkl87xIly1sl4C8V?=
 =?us-ascii?Q?sAKZxLhnmHpIB4fzwF9rxtKOEaof1Isk+A90I1BO3DTABaHJ+Kof2xELHqvb?=
 =?us-ascii?Q?5QJpdxjiP7X2w/jwCcuWumQrFtMHyTCRacDe3VbDFq4WFJLvHkgjtNC8vAp0?=
 =?us-ascii?Q?qNkNZcJfFqKM5aKpIz6SeFCLoULtPqN9Qt/hGW/RG6NtBmhXTlsXji83fAcU?=
 =?us-ascii?Q?z/hoOokEMJQ/kOIpzQMjAJExWiQ8l6x2y/lrK3minJxoAAKWFncwxJcPxRIM?=
 =?us-ascii?Q?6UEw/dzF+E9QCixJEdHEFMLST3IPmzjJG24JZdh8ztaWxyN3bCNwJsa88GMn?=
 =?us-ascii?Q?9hG4/cGZ/DiveelV3LnzRE6UjXEFwqHtyEx+pSyfn+L0yHfq4QP1xIiIfhHm?=
 =?us-ascii?Q?qZj6LN5c0ffiWsSabQ/W3TthcaXytWMMlj/khp8mXjRSL7iHBhO6QVMxZi2F?=
 =?us-ascii?Q?3YKXxCkgaThzkOkKcI6KbF874Jyl1ueXc6N86IQvceUlTF9qDOpuqiHOuXXg?=
 =?us-ascii?Q?taoK7R5aCZAY0j3o8kA0iXwb46tGZ1YnggvPqW5lLPkiBdJeC0vX3CZHgOn9?=
 =?us-ascii?Q?utJfGEZRnjdw+P+v0bfKZKU9V3fH1pGHw5ByeKW/iIyADz1D1QE3+cX1YLd1?=
 =?us-ascii?Q?t8d1wa8Vv+iK7U1ZMg27zwADSKac0KZfWBbBX7YjRJPL+PixFFqGeoxhkpFZ?=
 =?us-ascii?Q?BGgYBoas5B36PxhwhI6w73on4mhcbNXhpcXSwmDiK6RjNcdWGMXnqSkGPfKC?=
 =?us-ascii?Q?EILmrD7lCOvMNJk8v/cha2jOIbjAKueCOyRzCbCRi0ovp/1bDRFkLLEuux68?=
 =?us-ascii?Q?G77VbEQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 15:10:01.2559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8ac953-f5d4-483a-236f-08dcdd7420a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8751
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

An issue was identified in the dcn21_link_encoder_create function where
an out-of-bounds access could occur when the hpd_source index was used
to reference the link_enc_hpd_regs array. This array has a fixed size
and the index was not being checked against the array's bounds before
accessing it.

This fix adds a conditional check to ensure that the hpd_source index is
within the valid range of the link_enc_hpd_regs array. If the index is
out of bounds, the function now returns NULL to prevent undefined
behavior.

References:

[   65.920507] ------------[ cut here ]------------
[   65.920510] UBSAN: array-index-out-of-bounds in drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn21/dcn21_resource.c:1312:29
[   65.920519] index 7 is out of range for type 'dcn10_link_enc_hpd_registers [5]'
[   65.920523] CPU: 3 PID: 1178 Comm: modprobe Tainted: G           OE      6.8.0-cleanershaderfeatureresetasdntipmi200nv2132 #13
[   65.920525] Hardware name: AMD Majolica-RN/Majolica-RN, BIOS WMJ0429N_Weekly_20_04_2 04/29/2020
[   65.920527] Call Trace:
[   65.920529]  <TASK>
[   65.920532]  dump_stack_lvl+0x48/0x70
[   65.920541]  dump_stack+0x10/0x20
[   65.920543]  __ubsan_handle_out_of_bounds+0xa2/0xe0
[   65.920549]  dcn21_link_encoder_create+0xd9/0x140 [amdgpu]
[   65.921009]  link_create+0x6d3/0xed0 [amdgpu]
[   65.921355]  create_links+0x18a/0x4e0 [amdgpu]
[   65.921679]  dc_create+0x360/0x720 [amdgpu]
[   65.921999]  ? dmi_matches+0xa0/0x220
[   65.922004]  amdgpu_dm_init+0x2b6/0x2c90 [amdgpu]
[   65.922342]  ? console_unlock+0x77/0x120
[   65.922348]  ? dev_printk_emit+0x86/0xb0
[   65.922354]  dm_hw_init+0x15/0x40 [amdgpu]
[   65.922686]  amdgpu_device_init+0x26a8/0x33a0 [amdgpu]
[   65.922921]  amdgpu_driver_load_kms+0x1b/0xa0 [amdgpu]
[   65.923087]  amdgpu_pci_probe+0x1b7/0x630 [amdgpu]
[   65.923087]  local_pci_probe+0x4b/0xb0
[   65.923087]  pci_device_probe+0xc8/0x280
[   65.923087]  really_probe+0x187/0x300
[   65.923087]  __driver_probe_device+0x85/0x130
[   65.923087]  driver_probe_device+0x24/0x110
[   65.923087]  __driver_attach+0xac/0x1d0
[   65.923087]  ? __pfx___driver_attach+0x10/0x10
[   65.923087]  bus_for_each_dev+0x7d/0xd0
[   65.923087]  driver_attach+0x1e/0x30
[   65.923087]  bus_add_driver+0xf2/0x200
[   65.923087]  driver_register+0x64/0x130
[   65.923087]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   65.923087]  __pci_register_driver+0x61/0x70
[   65.923087]  amdgpu_init+0x7d/0xff0 [amdgpu]
[   65.923087]  do_one_initcall+0x49/0x310
[   65.923087]  ? kmalloc_trace+0x136/0x360
[   65.923087]  do_init_module+0x6a/0x270
[   65.923087]  load_module+0x1fce/0x23a0
[   65.923087]  init_module_from_file+0x9c/0xe0
[   65.923087]  ? init_module_from_file+0x9c/0xe0
[   65.923087]  idempotent_init_module+0x179/0x230
[   65.923087]  __x64_sys_finit_module+0x5d/0xa0
[   65.923087]  do_syscall_64+0x76/0x120
[   65.923087]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[   65.923087] RIP: 0033:0x7f2d80f1e88d
[   65.923087] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48
[   65.923087] RSP: 002b:00007ffc7bc1aa78 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   65.923087] RAX: ffffffffffffffda RBX: 0000564c9c1db130 RCX: 00007f2d80f1e88d
[   65.923087] RDX: 0000000000000000 RSI: 0000564c9c1e5480 RDI: 000000000000000f
[   65.923087] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000002
[   65.923087] R10: 000000000000000f R11: 0000000000000246 R12: 0000564c9c1e5480
[   65.923087] R13: 0000564c9c1db260 R14: 0000000000000000 R15: 0000564c9c1e54b0
[   65.923087]  </TASK>
[   65.923927] ---[ end trace ]---

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
 - Changed to ARRAY_SIZE() to be generic (Roman)
 
v3:
 - Updated git commit message

 drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index 347e6aaea582..14b28841657d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -1298,7 +1298,7 @@ static struct link_encoder *dcn21_link_encoder_create(
 		kzalloc(sizeof(struct dcn21_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc21)
+	if (!enc21 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
-- 
2.34.1

