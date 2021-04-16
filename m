Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F804C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C828610FC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C828610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD0D76EB81;
	Fri, 16 Apr 2021 14:34:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CEBF6E084
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:34:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqoZEzoxWLI4l0WpSVJ0TsdYjigeEyGFGY2Q4PLnG1aJcYttnSXlcX63mpaXMdHsalq+CHuhUqwdJoPX7c+MHmM7RCsj3y8QZoGVwd3gWZs6/sgUMxk8CQXqkv51tQofntENEIvOp2y1euALlUonBwMWZcR/XrTv62FN9uyVkGmp32gLB/uEEV3KSVICPlurRSrlPCHbAqFIWvy0MunP+CkVy6cctcorTRLW+fxvEqcc4tPbQr5VW4XONNjZY6f2PR9SFqNNjja5L46hGS3sarCjlT/J8gsuLPy0NqStddf14rnYCq6HzA34UvQlfjhWK01MBtFo4DO7FrdQ7Kq/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drdrQPliTVduL3AChaTy5KmJyyKsQRC3VxiLqeI2foY=;
 b=YwiSdm7UjsNbktOO9TYywqpkFsxEvrAe8qZtR5r4Z+waKrkg1OJyPAcxsvB6ZAOltpsyrjHPklo9QPnhKs/4sm90tLScOQnmyWg70uyGrA5tWk3CHF9VR1CtF/PyqFqTaQmaLq/x12YGIrxWSVRMrUCxTiP2awXGPdfAjHSNL7AKlTY3ictUimiCtjgOgNc2X8bA51rb7Z6MKnznFlDKuGucVBHUk9QypPuu3coSn34y9lBnB3x0+CHNepz9hKM1vxwrVY08Ef0eFPpCZ4OKQsgPBeWk2cQBN+j56SAMIgWQ1TREFe5Ddoipe+ead3ARH1MSLqj1pnKE3QYGHhKdZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drdrQPliTVduL3AChaTy5KmJyyKsQRC3VxiLqeI2foY=;
 b=IVL/yQiAZ1DKNMD4zyIQzsJVQkS8KddFxFsPshWYhkXjJXPNecUR39h4mx9QW0Vaaxc+53wEY9WlZq3GNOPfriiYqmEPUQxzzRZMvJ2tAaXQ1T7NG2Gp5e3c0ZERPpcNVqK022PTGxkBZm3WMIbhp+AXbg7VWyOhu45g3hhU22I=
Received: from DM5PR12CA0004.namprd12.prod.outlook.com (2603:10b6:4:1::14) by
 CH0PR12MB5122.namprd12.prod.outlook.com (2603:10b6:610:bd::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Fri, 16 Apr 2021 14:34:25 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::1a) by DM5PR12CA0004.outlook.office365.com
 (2603:10b6:4:1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Fri, 16 Apr 2021 14:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:34:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:24 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Fri, 16 Apr 2021 09:34:18 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/19] drm/amd/display: fixed divide by zero kernel crash
 during dsc enablement
Date: Fri, 16 Apr 2021 10:33:59 -0400
Message-ID: <20210416143417.611019-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416143417.611019-1-aurabindo.pillai@amd.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66fa72da-65dd-4ac4-4697-08d900e4bbd5
X-MS-TrafficTypeDiagnostic: CH0PR12MB5122:
X-Microsoft-Antispam-PRVS: <CH0PR12MB51226233FEA5556BDE2D5C8F8B4C9@CH0PR12MB5122.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUTJZC3jhxnh6UmQdUuN9kQ3dEce6SICUsmIYNwrQujSmu8E4h30gUHxnK4wHsng47vLxN6I4exDlRyFkwJ3c9wctRTTDsMLE5/8GbW/0IdirBvCcteyEFW+ZmZ6MXIPAEsQtIyD26oaYIqsYby7QSSTr5oMaAT92C8sSUUbhOGg+/5stoxxXsWSxDJvXLLDOpeM04dYRbTCfuCttk8NvZudhIYsoeEGMwrXucN+ZTY6jecx4uXf9nHr8rGDzDtC1e4xcw0InLOjjUR1QAarVGeACE6rlKoqHEKuGj5mFeTPwDnVb2Q78iL3ECMFF1DbD0ay8618/xiqVW0g7FVKS8IKNq8eOe6qLJZEdcDBbeyH2oYMktRki/ia8W5z4WJj2YeBCH7cAFC6dza0NdV2tv3TjHZ8chD9Ay1NLa+oLgVLJiS80NPyCvycT8Zrj60K+aF7KyZcpwio0dw0CB+JUmTlXY9EHnqnDj86fyibwr7oRXtwR09leTTdDgd+pLRLHngqbUDxJMvlJ/yV9iNZdDWr/c//x5c7wYBcyfQL7UcBaRR4AYkUH3PV+APLQRQKjpoy3rDKORtUGg7lZQtXJtv7A8YQjdrM5l2pIv7roUUaPJ35T/Wr1EBm/UGUOjyuq691vKhDhE46+GPGj0j+cxcnf0tz4f3VMJ/ArG4TxUZ6BE6jg6HzdWwR/mNeQhyL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(46966006)(36840700001)(7696005)(54906003)(1076003)(8936002)(36860700001)(82740400003)(83380400001)(6666004)(36756003)(6916009)(426003)(44832011)(47076005)(4326008)(70586007)(70206006)(316002)(8676002)(5660300002)(2616005)(336012)(186003)(478600001)(2906002)(82310400003)(356005)(81166007)(26005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:34:25.2446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fa72da-65dd-4ac4-4697-08d900e4bbd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5122
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
Cc: Robin Singh <Robin.Singh@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Robin Singh <robin.singh@amd.com>

[why]
During dsc enable, a divide by zero condition triggered the
kernel crash.

[how]
An IGT test, which enable the DSC, was crashing at the time of
restore the default dsc status, becaue of h_totals value
becoming 0. So add a check before divide condition. If h_total
is zero, gracefully ignore and set the default value.

kernel panic log:

	[  128.758827] divide error: 0000 [#1] PREEMPT SMP NOPTI
	[  128.762714] CPU: 5 PID: 4562 Comm: amd_dp_dsc Tainted: G        W         5.4.19-android-x86_64 #1
	[  128.769728] Hardware name: ADVANCED MICRO DEVICES, INC. Mauna/Mauna, BIOS WMN0B13N Nov 11 2020
	[  128.777695] RIP: 0010:hubp2_vready_at_or_After_vsync+0x37/0x7a [amdgpu]
	[  128.785707] Code: 80 02 00 00 48 89 f3 48 8b 7f 08 b ......
	[  128.805696] RSP: 0018:ffffad8f82d43628 EFLAGS: 00010246
	......
	[  128.857707] CR2: 00007106d8465000 CR3: 0000000426530000 CR4: 0000000000140ee0
	[  128.865695] Call Trace:
	[  128.869712] hubp3_setup+0x1f/0x7f [amdgpu]
	[  128.873705] dcn20_update_dchubp_dpp+0xc8/0x54a [amdgpu]
	[  128.877706] dcn20_program_front_end_for_ctx+0x31d/0x463 [amdgpu]
	[  128.885706] dc_commit_state+0x3d2/0x658 [amdgpu]
	[  128.889707] amdgpu_dm_atomic_commit_tail+0x4b3/0x1e7c [amdgpu]
	[  128.897699] ? dm_read_reg_func+0x41/0xb5 [amdgpu]
	[  128.901707] ? dm_read_reg_func+0x41/0xb5 [amdgpu]
	[  128.905706] ? __is_insn_slot_addr+0x43/0x48
	[  128.909706] ? fill_plane_buffer_attributes+0x29e/0x3dc [amdgpu]
	[  128.917705] ? dm_plane_helper_prepare_fb+0x255/0x284 [amdgpu]
	[  128.921700] ? usleep_range+0x7c/0x7c
	[  128.925705] ? preempt_count_sub+0xf/0x18
	[  128.929706] ? _raw_spin_unlock_irq+0x13/0x24
	[  128.933732] ? __wait_for_common+0x11e/0x18f
	[  128.937705] ? _raw_spin_unlock_irq+0x13/0x24
	[  128.941706] ? __wait_for_common+0x11e/0x18f
	[  128.945705] commit_tail+0x8b/0xd2 [drm_kms_helper]
	[  128.949707] drm_atomic_helper_commit+0xd8/0xf5 [drm_kms_helper]
	[  128.957706] amdgpu_dm_atomic_commit+0x337/0x360 [amdgpu]
	[  128.961705] ? drm_atomic_check_only+0x543/0x68d [drm]
	[  128.969705] ? drm_atomic_set_property+0x760/0x7af [drm]
	[  128.973704] ? drm_mode_atomic_ioctl+0x6f3/0x85a [drm]
	[  128.977705] drm_mode_atomic_ioctl+0x6f3/0x85a [drm]
	[  128.985705] ? drm_atomic_set_property+0x7af/0x7af [drm]
	[  128.989706] drm_ioctl_kernel+0x82/0xda [drm]
	[  128.993706] drm_ioctl+0x225/0x319 [drm]
	[  128.997707] ? drm_atomic_set_property+0x7af/0x7af [drm]
	[  129.001706] ? preempt_count_sub+0xf/0x18
	[  129.005713] amdgpu_drm_ioctl+0x4b/0x76 [amdgpu]
	[  129.009705] vfs_ioctl+0x1d/0x2a
	[  129.013705] do_vfs_ioctl+0x419/0x43d
	[  129.017707] ksys_ioctl+0x52/0x71
	[  129.021707] __x64_sys_ioctl+0x16/0x19
	[  129.025706] do_syscall_64+0x78/0x85
	[  129.029705] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Robin Singh <robin.singh@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Reviewed-by: Robin Singh <Robin.Singh@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index bec7059f6d5d..a1318c31bcfa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2012-17 Advanced Micro Devices, Inc.
+ * Copyright 2012-2021 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -181,11 +181,14 @@ void hubp2_vready_at_or_After_vsync(struct hubp *hubp,
 	else
 		Set HUBP_VREADY_AT_OR_AFTER_VSYNC = 0
 	*/
-	if ((pipe_dest->vstartup_start - (pipe_dest->vready_offset+pipe_dest->vupdate_width
-		+ pipe_dest->vupdate_offset) / pipe_dest->htotal) <= pipe_dest->vblank_end) {
-		value = 1;
-	} else
-		value = 0;
+	if (pipe_dest->htotal != 0) {
+		if ((pipe_dest->vstartup_start - (pipe_dest->vready_offset+pipe_dest->vupdate_width
+			+ pipe_dest->vupdate_offset) / pipe_dest->htotal) <= pipe_dest->vblank_end) {
+			value = 1;
+		} else
+			value = 0;
+	}
+
 	REG_UPDATE(DCHUBP_CNTL, HUBP_VREADY_AT_OR_AFTER_VSYNC, value);
 }
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
