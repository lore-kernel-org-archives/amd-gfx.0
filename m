Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E856C27C65
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E0DC10E6E3;
	Tue, 11 Jun 2024 16:53:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e+25Dem4";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CE4810E6DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFhlKl027/rNuivsLUffq6zOSt5cUgLCp7NJpIImNt25nhx8RqKXFTvcumg7r67l59kGarxSfVjNx73JX3ijmRZIOa/hXCOUPQaov5hAJI2NlDNFBQY11ovAZpWxxWoXGh7ON4gDU6k44WSjPla72fDcBJItoypHh7d9GUbaz92j3rAOrefPCWPn/Rr6+7hjWgtZFTC5RbGOUQaMehHMYnFw2YsdHej2o5QjrNsmohZ+F7CQjBI91gzbDMIRVOD0dAa8hRPsczdcL34yON6eSsUHrVkAcxXLe1xJbqMNkncbaOwBPG5mu3Vw23B9XeV0i9EXJ2TvPiuIc+xcRu5m7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DewGSR7clWeGOSCL0KPy+mSGcX98nwd5r4L/GFve6Kg=;
 b=W2Vq+i0LubtQRDoWVQkEFyDZSLei5QMnRw1hxgZiSA7rLOqYwLZmlIj8NhIwmaywtxP5+4R+qHegFdWD5O1HMQvTrgcWhq9P93i4VNFSIaizqaH7XSOFm8lWK+77s17jReTPxDVOMh9ZamqxYs++Uoe91zFGHBISx/7LBM5F8PyKUxZCy0ErEWXtXpFBUzplCvQqK20WoaHwunGWkHgrpRjaAhuYtqDBHTC8mWJSIAuhX1XUN6XUqIzR4zgLNliRngWOb1d6/X0ifZputwmYNozOncvndi1Xor3L/JwyqLsRMWRy/E+nHYoZTQGQjid9jJzM/QFCGbgM6bVIDQ3MAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DewGSR7clWeGOSCL0KPy+mSGcX98nwd5r4L/GFve6Kg=;
 b=e+25Dem4H5crs4tvXHLLJ7mcDca6cn71jfo9+A+JQ3sTQGZiDLXLiiYgUZp9jqXlH3R3qDt88a3iClWPipcD7KnhOGvh2E3mBKK3BXtYYYGi1xtV+Kq5bFAn3zP6dY7E+KtmNQ8s5+67MJ5D3KXDv3NX+Qcy1pJ8qVkJrI7Wne0=
Received: from BLAPR03CA0025.namprd03.prod.outlook.com (2603:10b6:208:32b::30)
 by DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:52:45 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::c7) by BLAPR03CA0025.outlook.office365.com
 (2603:10b6:208:32b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:45 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:42 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 "Wenjing Liu" <wenjing.liu@amd.com>
Subject: [PATCH 25/36] drm/amd/display: Fix warning caused by an attempt to
 configure a non-otg master
Date: Tue, 11 Jun 2024 12:51:28 -0400
Message-ID: <20240611165204.195093-26-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DS0PR12MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: bb39fafc-8536-401c-2ad5-08dc8a36eb2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HsElcAuJTy/Jao5y1azHbyX8L2BhTo8gM+47esXSkwqxtWppFCJtmtNmN5Vp?=
 =?us-ascii?Q?uJmQO1VAik4FTGI3CUJ5I6TZ67OGtYdqkgSsc24iiSELhthN93+fpf6BrAbb?=
 =?us-ascii?Q?sxw+2zDDH2FdI/W9GVe7FsK43d/r22F1K/rHRKhB1dE8RFLisqzyr4Ujq84Z?=
 =?us-ascii?Q?unfyk643qJ4nz411fuheAa2SoNIYdNcp+Mz+fG4AXw6Pp+rgPaZN6ovPzyY6?=
 =?us-ascii?Q?rXnJnqf0nrT4WZ3GffEYguh0ZnjxmpY6KcCx3WUdsXZp2vWACISVpo3F1tT3?=
 =?us-ascii?Q?8AdaBrtZNuNhO/xZz1KZfcBsVWLIc3SqgjPpITj4jsUUy4kALPbbbnU+befV?=
 =?us-ascii?Q?8Ot7SQ0PfPX1tALYF0t8iXs9venjeUM2nqPlLSVGjz8wLACLkPtgmNQbKd4a?=
 =?us-ascii?Q?CMcLiuOzS5Twquoco9phXTh+AvD9YKLY5ErL8oyEv8fiKdWxFgEl4fIojfYj?=
 =?us-ascii?Q?WCtMln1UUqYLOB+7Sd0q4l1h6/oHueNjjqghdDo+jetp1Xyix+DsM2oNsUxS?=
 =?us-ascii?Q?ygrpQCTOxjS77iXpppjnG/9u/63tPS/kZAwJCInvJt3898FKuTW4Fwg2KZLV?=
 =?us-ascii?Q?cTQlcg/5793A1A8mwAfQI206puMNyxrv0PbY3R66IUi41zzVkKqjo1+zKa1P?=
 =?us-ascii?Q?fQjlSYgcpIUfC4J+h4C4DjNQwogrAqeX1QBRwmjzNcr+o2y5RyiFwSoVyf0b?=
 =?us-ascii?Q?YWQ+iRE7h88+hm6moXYaH3Wpme5zunsGucdWStAN5TA8FTjEwe6YZszwmRE9?=
 =?us-ascii?Q?IIlVuMdAInLUUpr+ItSID37CgCrzNkgeI/rcpwD0+LY028Om+ewBHdKWC+U3?=
 =?us-ascii?Q?9sJZLFQIEgnBJBjknI6sjrpwdiSq0/Hkq2oMIpFSZh3E50fkj0+n6zAfKg6c?=
 =?us-ascii?Q?u77xLjgPeAsy5kI7BmPxM/Q4SB9WJXnYuM28HshFuxLZ7X0M8XrJPr6pNxPl?=
 =?us-ascii?Q?m6VWDO56ttTeCWP0TPTpfINS87df9uQgF/2MQOO3U0MWzvQkdv4oJJBOCHy3?=
 =?us-ascii?Q?h+U6UJOXZo+VI6F/zJcRF11pviDss+5GR+MlSpRWLGnVmXjVHFeDYZd1uw4i?=
 =?us-ascii?Q?btxG0i7m1WpfwuOzh/Qj0HcshjAJXG9+uEZ/j2BMFmh/dkL6q+6veATDor2O?=
 =?us-ascii?Q?kK/EsABXNIlJ8KUW4oyz2jgxHyzUHjPFEIbM9poKuY062gYrjhu13/1ern11?=
 =?us-ascii?Q?zFn0UG60rsghQPwF89D9SOC1QbXoT0BG+1D1rt2cMWbhDzHeDGdomLmisOLZ?=
 =?us-ascii?Q?/n4LStYfqEg+H3bPQvW+/Kkg2EPqWfHyJxxKo03DXl4o5KnU0NqwKROlVk2I?=
 =?us-ascii?Q?6rq0noPQcHkfPtXXf1Cdw+ErBPZ5MCpk154aVp6FEy53mtpMsmtIbIHIB9u6?=
 =?us-ascii?Q?ZAAr9w/mZDEt5TjG21HQHe7zQKFfZ61HnmBTGbW0bNMre/DUGg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:45.7459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb39fafc-8536-401c-2ad5-08dc8a36eb2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536
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

From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>

When booting the system with DCN401, the driver adds the following dmesg
warning:

WARNING: CPU: 8 PID: 175 at
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1923
resource_get_opp_heads_for_otg_master+0x13/0x70 [amdgpu]

Modules linked in: amdgpu(+) hid_generic amdxcp i2c_algo_bit
drm_ttm_helper ttm drm_exec gpu_sched drm_suballoc_helper drm_buddy
drm_display_helper drm_kms_helper usbhid hid drm i2c_piix4 ahci igc
libahci video wmi

CPU: 8 PID: 175 Comm: systemd-udevd Not tainted 6.8.0-EXTRA-PROMO-MAY-29+ #66
Hardware name: ASUS System Product Name/TUF GAMING X570-PRO (WI-FI),
BIOS 4021 08/10/2021

RIP: 0010:resource_get_opp_heads_for_otg_master+0x13/0x70 [amdgpu]
Code: 8b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
90 0f 1f 44 00 00 55 48 83 bf f8 07 00 00 00 48 89 e5 74 0c <0f> 0b 31
f6 89 f0 5d e9 0c 65 01 e5 48 83 bf e0 07 00 00 00 75 ea

RSP: 0018:ffffa5f000816ed8 EFLAGS: 00010246
[...]
PKRU: 55555554
Call Trace:
 <TASK>
 ? show_regs+0x65/0x70
 ? __warn+0x85/0x160
 ? resource_get_opp_heads_for_otg_master+0x13/0x70 [amdgpu]
 ? report_bug+0x192/0x1c0
 ? handle_bug+0x44/0x90
 ? exc_invalid_op+0x18/0x70
[...]

This warning is triggered by a check in the function
resource_get_opp_heads_for_otg_master that validates if the request
operation is in a master OTG pipe; if not, the warning above is
displayed. In other words, another part of the code might be calling
this function in a non-OTG master pipe context, resulting in the log
message.

The reason the ASSERT was triggered is that the current state wasn't
updated after applying the context to the hardware. This means that the
update_dsc_for_odm_change might be called from a non-OTG-MASTER. To
prevent this, it's crucial to check if the current reference is pointing
to an OTG master before operate in the old OTG master reference. If it's
not, the function must set the old OTG reference to NULL and avoid
calling resource_get_opp_heads_for_otg_master before the context is
updated.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Co-developed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 24 ++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 0fafbec442b1..cb8e417fb032 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1561,16 +1561,28 @@ static void update_dsc_for_odm_change(struct dc *dc, struct dc_state *context,
 	struct pipe_ctx *new_pipe;
 	struct pipe_ctx *old_opp_heads[MAX_PIPES];
 	struct dccg *dccg = dc->res_pool->dccg;
-	struct pipe_ctx *old_otg_master =
-			&dc->current_state->res_ctx.pipe_ctx[otg_master->pipe_idx];
-	int old_opp_head_count = resource_get_opp_heads_for_otg_master(
-			old_otg_master, &dc->current_state->res_ctx,
-			old_opp_heads);
+	struct pipe_ctx *old_otg_master;
+	int old_opp_head_count = 0;
+
+	old_otg_master = &dc->current_state->res_ctx.pipe_ctx[otg_master->pipe_idx];
+
+	if (resource_is_pipe_type(old_otg_master, OTG_MASTER)) {
+		old_opp_head_count = resource_get_opp_heads_for_otg_master(old_otg_master,
+									   &dc->current_state->res_ctx,
+									   old_opp_heads);
+	} else {
+		// DC cannot assume that the current state and the new state
+		// share the same OTG pipe since this is not true when called
+		// in the context of a commit stream not checked. Hence, set
+		// old_otg_master to NULL to skip the DSC configuration.
+		old_otg_master = NULL;
+	}
+
 
 	if (otg_master->stream_res.dsc)
 		dcn32_update_dsc_on_stream(otg_master,
 				otg_master->stream->timing.flags.DSC);
-	if (old_otg_master->stream_res.dsc) {
+	if (old_otg_master && old_otg_master->stream_res.dsc) {
 		for (i = 0; i < old_opp_head_count; i++) {
 			old_pipe = old_opp_heads[i];
 			new_pipe = &context->res_ctx.pipe_ctx[old_pipe->pipe_idx];
-- 
2.45.1

