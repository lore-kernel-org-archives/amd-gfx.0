Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7CCE7717F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 11:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFD1B10E215;
	Thu, 12 Dec 2024 11:08:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N5VFq3Cj";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D3C310E215
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 11:08:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvC84cwdMpMBSQjtSjH/9zhtYFYUiQw/MZyrHfEm41A9Co1bkfx/pDW1SskbilG1VWfKAH/jWXzQZDiATcdj5cutf7O475dqMZfBZ6TB+Vc/yhi+sOSH0+i2rGeYw5n+nfhE/1Q7gHHRB14m/M/XHGAeM92UzlLvqvoHVNcXNJN/02HLZz3DyNMvfwgnpz5u0//lr43R4OL82jXySZf30kj7tazFTegc2v+twyxyakZbbKyL5nGYioYZ5CyJFjkY+6jPemJqam/SqsS5xtxOnI0qG9efT2ol/suBVabsdYa/42HWHWKQyxPfKKlo1EaMxAy3abtLw8Xz/V3jc6i7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrtWItukpz6RkXpY/2dORYwL7FCBH4CN2QY7fH4EQfY=;
 b=o3Y7yRo0w7t9/zOYJAAwsa6/bTcPxZLGeG4wH5gia4obIHs5gEbRzmvN5CdBlkoEdu6Te8OeYNyS5arE+ihyoK6AF2Pcrz+BPaUGR4E1eK+xiN8ZClfy+9ewToeTLer/tcGDdRNpZX4IMKd3UDEZ+z4P2UBVmwgzhtyypnCJoy4VWyQD7UseIvkVgEBI/pBPwB7/3HfWRocWEvT2Dp3xsexrhg2uRzKjUeONJLhrFMUPJxVC2k6TaEs0Lvx2rB6gqpAtO8AmyGTh8+HX2YCgUKMSWBXb33yUKf1CmLc4x6we8OnrcBhVJBuV45Z0TwpLVnNMx8qPecwyJ7P/uMFPTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrtWItukpz6RkXpY/2dORYwL7FCBH4CN2QY7fH4EQfY=;
 b=N5VFq3CjKbGDf/mXPYJ4fXZBAoc9OXD1fUEM2pyvCZCabssemt9YY0YgzG1mJP74s+ccOcNIC6DmJj9BhyM0cgQLsgQrsiqhiEjz24VPrNq+zzSBWbdoGwqYqzJ7M7pTDETq+5ZQ7qkMy30FNWdw8mrwyWiD7ONy3xPHs2G3nZQ=
Received: from DM6PR02CA0154.namprd02.prod.outlook.com (2603:10b6:5:332::21)
 by SJ2PR12MB7919.namprd12.prod.outlook.com (2603:10b6:a03:4cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 11:08:28 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::40) by DM6PR02CA0154.outlook.office365.com
 (2603:10b6:5:332::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 11:08:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 11:08:28 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Dec 2024 05:08:24 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Leo Li <sunpeng.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>, Alex Hung
 <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2] drm/amd/display: Fix NULL pointer dereference in
 dmub_tracebuffer_show
Date: Thu, 12 Dec 2024 16:38:08 +0530
Message-ID: <20241212110808.956179-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|SJ2PR12MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c18175-b6c9-4d92-9627-08dd1a9d4e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v4GBGZnE88o4R4V6CR5eWjlAglrZP7uPjt39lIDUyjpLogoTTVX2ELXeqYLL?=
 =?us-ascii?Q?kihaetF8WJa+8mE2jm8dPjxRm3Ei5RnjNsPD5RC6E5/WOJwY9jMvYPe4LuYU?=
 =?us-ascii?Q?eKvvclejRPNNETIL96R3FzKvvhgQSzvQjUI+iD8wHdtpS09z+Ug7gGWVqaoV?=
 =?us-ascii?Q?Yk1AU/PYYYraylJRjS3WWXdzledQF6LLUT3zhJZ82eb4mi5yijjVK+1bUgtC?=
 =?us-ascii?Q?eVA0G5FfPGh1hLoRO01JsIp2Z5IoqIglV37GQEwqUBnQK/5MyR2z20MlLFtN?=
 =?us-ascii?Q?AO7jidGSmrzSptRGZYEIkV7sUJpgXqumv+n8YeA3q4GZmlvEmmUhoJOLz5sP?=
 =?us-ascii?Q?KbKzfWDGSGkxkJgYP422xwAwwc/rWTfz0g+tkUuDCp6G00rF0zZoLSVyyKG4?=
 =?us-ascii?Q?G9PZ5NAinT2p+7hf/QTaYmCxwBRVxW48v/FumDegQLT7WSkdgtgqfF5bobu7?=
 =?us-ascii?Q?vg69CuWUAnGz15TQzHkpQJLzVjEi0PMzFcFnJlNfTr48i5/z3lWim3SmTzau?=
 =?us-ascii?Q?4WKPrvh5Q75Si561RToAVAwNnpdg27Cres6jsd/Qvea1WCFtn4cg20gCCMSV?=
 =?us-ascii?Q?HQhVDZzbvKE8u3JwlRIAed+DFI+sYRAoH+GJLb0wgQoXpdGwv4vkXEElQN+y?=
 =?us-ascii?Q?Ss2LFaJu73Sbg82WyhFEwTOdoWz14jRP2ctmKUOGeQTwMadWolImWRJBgRR1?=
 =?us-ascii?Q?3nvdUMv7fqNoMYSUBxEaKU45HTtMLGJITo7lSpwkL2vabogdbzDRvsVfNpyf?=
 =?us-ascii?Q?AivY/dDwELHcxPabbSn4rIDkPoshsbOIkcsov5lmhfgdf6FTsskdu38R/aih?=
 =?us-ascii?Q?lkUJmw6P8C1gL8emmOb3TS6xFqSgvzN3Jgk4QO6adSHX7LSe0vV1KcO5xkbg?=
 =?us-ascii?Q?M8scFd1hjcLM6p0veAd70YYhmeAS8XL4cauONLB5Ghovyo2d6X6E3vLXrSjC?=
 =?us-ascii?Q?WtdATwZvPzPdjlvwqCvDN1B+dxHc0JwxNl5zMxhZhy+99ycGx7wVGNcF38Iq?=
 =?us-ascii?Q?B+6zReErcF6igqgTV9yFuIdpUl8Sf4EjKbaXLrhTAwnVi0NmIwReyGDtuHSW?=
 =?us-ascii?Q?/CkVk+MW59aszMBgW4k32fZQuqZRn42vLhlWQAixI/RwSFnF2+LX4AYeNPDS?=
 =?us-ascii?Q?oLFtcXRkJ6dp5eg5GmNuolenQTRsQgPLgLZg7VSoivlxJrbfLTT766q/N/1p?=
 =?us-ascii?Q?RMaMIXVTl032okNMrYlEPdkjXpQNaIOSVkoXIJjlpjahIq//26PyFIAan7od?=
 =?us-ascii?Q?qnmZ1300AOrjSDZelm5jvabxkYMME/T0fmCqPJsYNSL9R+DJKChXW4oJOEIT?=
 =?us-ascii?Q?uuxDTNzHOXgcRD3oxwkLWja7hUs9kvPa2LPQOl/qbEBYxrckBqWV5Z/9R5OW?=
 =?us-ascii?Q?1zJXt9co+V9mg9gJeyJ8oHN8Grt9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 11:08:28.1042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c18175-b6c9-4d92-9627-08dd1a9d4e47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7919
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

It corrects the issue by checking if 'adev->dm.dmub_srv' is NULL before
accessing its 'meta_info' member. This ensures that we do not
dereference a NULL pointer.

Fixes the below:
	drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:917 dmub_tracebuffer_show()
	warn: address of 'adev->dm.dmub_srv->meta_info' is non-NULL

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c
    901 static int dmub_tracebuffer_show(struct seq_file *m, void *data)
    902 {
    903         struct amdgpu_device *adev = m->private;
    904         struct dmub_srv_fb_info *fb_info = adev->dm.dmub_fb_info;
    905         struct dmub_fw_meta_info *fw_meta_info = &adev->dm.dmub_srv->meta_info;
                                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Even if adev->dm.dmub_srv is NULL, the address of ->meta_info can't be NULL

    906         struct dmub_debugfs_trace_entry *entries;
    907         uint8_t *tbuf_base;
    908         uint32_t tbuf_size, max_entries, num_entries, first_entry, i;
    909
    910         if (!fb_info)
    911                 return 0;
    912
    913         tbuf_base = (uint8_t *)fb_info->fb[DMUB_WINDOW_5_TRACEBUFF].cpu_addr;
    914         if (!tbuf_base)
    915                 return 0;
    916
--> 917         tbuf_size = fw_meta_info ? fw_meta_info->trace_buffer_size :
                            ^^^^^^^^^^^^ Always non-NULL

    918                                    DMUB_TRACE_BUFFER_SIZE;
    919         max_entries = (tbuf_size - sizeof(struct dmub_debugfs_trace_header)) /
    920                       sizeof(struct dmub_debugfs_trace_entry);
    921
    922         num_entries =

Fixes: c506f6e03b18 ("drm/amd/display: Make DMCUB tracebuffer debugfs chronological")
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
 - initially initialize struct dmub_fw_meta_info *fw_meta_info to NULL (Dan
   Carpenter)
  
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 11a7ac54f91c..2d31836ecb98 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -902,7 +902,7 @@ static int dmub_tracebuffer_show(struct seq_file *m, void *data)
 {
 	struct amdgpu_device *adev = m->private;
 	struct dmub_srv_fb_info *fb_info = adev->dm.dmub_fb_info;
-	struct dmub_fw_meta_info *fw_meta_info = &adev->dm.dmub_srv->meta_info;
+	struct dmub_fw_meta_info *fw_meta_info = NULL;
 	struct dmub_debugfs_trace_entry *entries;
 	uint8_t *tbuf_base;
 	uint32_t tbuf_size, max_entries, num_entries, first_entry, i;
@@ -914,6 +914,9 @@ static int dmub_tracebuffer_show(struct seq_file *m, void *data)
 	if (!tbuf_base)
 		return 0;
 
+	if (adev->dm.dmub_srv)
+		fw_meta_info = &adev->dm.dmub_srv->meta_info;
+
 	tbuf_size = fw_meta_info ? fw_meta_info->trace_buffer_size :
 				   DMUB_TRACE_BUFFER_SIZE;
 	max_entries = (tbuf_size - sizeof(struct dmub_debugfs_trace_header)) /
-- 
2.34.1

