Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71ACC3ABCC
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 11:25:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8801C10E3AC;
	Tue, 13 May 2025 11:25:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O0/b4plY";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33F7F10E3AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 11:25:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uP1VE0NOdPuJ4jOfpEhAqEPeOaEUjV2Mo7VZWXsVQND7U+lewtCKY4O/nA0QfvUhm0vAaeXZ2clPYSwDw30Z3ZRdfykUPYNH7OC4FNgVCfXrZlu7xSIbURpDnUIEtRXP3l2k5LltoBXK+9P4LOPlKtz9y3p/h+8JH6uVXyr328nt+kLNcvUMYv1ZcmikGmfw4MseUuvZLu4LOpgy8Kg0vOVApu3stfVOmyljUWUCi/UYLikpXIZWMeIamAdiEW6sG74wS03Qm5eilAr8qRtJfLNsRQ6jf7bm1hv4xF+Z0YhCeLE8zem2yZdIuamme4RHc14CfsyCupF6uo1XefBv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZB3R1NMkRnLd02jMut+cyjiGqL6EQrvQUeOPJsfjLuY=;
 b=MIq0N+aRMG8ivwdU2nKTqXhhKFpPIRr0QxH4tc1hecEtXqF1LmXHdmipGNmZb4GSgVTe1XIBmqiGp9atiRzUEWc4ur1eYR9G9+vhRykeJevle6fORowpbcWLn54hsUSTWzpzmj8mjW9u3KuC6Ynn0neq+eAiZEgPaNNVCudWxwpkXmGl0pXBcOTYLpfCd3DGSx9Ucs2pAwpFFd2s8hz3X36GTrik9gdE7R9b05iPmi1bOohp8L3SPgCFjbDujBL3ujaR8BYbLzzBpwWo72veN7sdJlFge874s2IvvbuvDzAkqi8xa1LFOQJwCL3PIp5M4TeQO4NF2F4QGqVR5PsTtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB3R1NMkRnLd02jMut+cyjiGqL6EQrvQUeOPJsfjLuY=;
 b=O0/b4plYCzz2JdlpWtrKdKPcnhxKw8MYiSvMuzQc9d9scBdzDQWsDwj9KNFMsDpAdDCrlPxVq4Ed9yTq1YdIsneG7TyTkahxiGiTpP6TSytizWMwjr2qtwDc38GmsZvCDJoothF2pgonvexVtVX26rtK93EIlBL+GFMAoHdlbcA=
Received: from MN2PR22CA0010.namprd22.prod.outlook.com (2603:10b6:208:238::15)
 by SA1PR12MB8945.namprd12.prod.outlook.com (2603:10b6:806:375::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 11:24:59 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::7) by MN2PR22CA0010.outlook.office365.com
 (2603:10b6:208:238::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.30 via Frontend Transport; Tue,
 13 May 2025 11:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 11:24:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 06:24:58 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 13 May 2025 06:24:55 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Yihan Zhu
 <Yihan.Zhu@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 02/11] drm/amd/display: init local variable to fix format
 errors
Date: Tue, 13 May 2025 19:24:30 +0800
Message-ID: <20250513112439.2295366-3-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
References: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SA1PR12MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: c908bdaf-e3fc-49ec-b9f5-08dd9210cbad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pEPzVQy0YzJf7YlMHLp96sPWo73Oe7GuxkOorC3Ud5OIbMrcWWYZUxCgbfmF?=
 =?us-ascii?Q?1hCnRUVg1l6tXUZ0AWHhZX/pkp4e7gLnrOth4Z3va/tGZPttc/nzcRbVjDnZ?=
 =?us-ascii?Q?2TTyP5C/0SmdHToYu5+klnh/bQNERBT4JFrIWdelC8DEuShgtyO+EK0Xa0jx?=
 =?us-ascii?Q?gqkdKtZe4pWLKc+yB/FijnkYaTIrv2X2IG6GUgUG8aqefEv+Q53oPvfc1jcc?=
 =?us-ascii?Q?3h2I0M75LrsbXwfb5HffsJuVvNKDGGsav3+Y3Y6fDZqfbo/E1PJXGJXZsKf8?=
 =?us-ascii?Q?5YDex8B4xDlLuEBmq9Fmi2+WslCKroZXituWhkeE4b9K+fB5Z4pgpVhXAXEM?=
 =?us-ascii?Q?IhOich7biW3jgtMvpz3TJ97sNioq5rXrTgtLWgVyvUkaGG/h3LVtkF17+E+y?=
 =?us-ascii?Q?jOm//TM2kQ/VlLbMbh5mof76f1Nte5KfuAGZ2W0ieYrvSLuMI9O9HU7rZkEK?=
 =?us-ascii?Q?Fp6uT33iILV7RmAj9CB7OWZFZ1HBh1B1DFPb8Q0ZxgfZc6OUK2yr5CL5MBaY?=
 =?us-ascii?Q?bxYcINEP9CUDd85fx/na+b1dFUqT0qANz+iCGpeTX/qSAYvx0UJke4D+sEYe?=
 =?us-ascii?Q?++uazS/thEdBqd2ROieIWq8UbW6YThxn8kfx7FqvqghXH2PAHseQ448FBKVA?=
 =?us-ascii?Q?XpFEi0DoTwze79EH+HuTdp6d3sM/3u7KK3STfiwhznfRhTNDwnohqJDIdLAM?=
 =?us-ascii?Q?WUcNHVbflZJyfXHxW4Oel5unuRq7X4PL/vxogysgD7Iuir61Ea0VqlEDRccK?=
 =?us-ascii?Q?91uFIdMI994D4cKxfxkvsw55RWSy1XsUyaWOhbNsVVyLIEYoy2XILi0q9kqi?=
 =?us-ascii?Q?TE3UnMseSs8dy5vd3ivS/wTUEzKAQHv7jNsfeVotQLNqBSONpG4ep6PU4LZN?=
 =?us-ascii?Q?AlUtcvozZso3N2V5QLOVX2T1Hm2NHUDFLoPqVjw4mYnROKhGQ0ChMEN1Byqz?=
 =?us-ascii?Q?H4JJlNrDEfw5/ev5NRBvgNi72e/oTdRgubLn5VzLKorPIhoQ5Fvpo74Wz3sq?=
 =?us-ascii?Q?ml6mtfsJ1fNXQBZt5PGaJy8sM+47EKxyboubbOszVK4a6SRAKJ2wQhg3CrFQ?=
 =?us-ascii?Q?HwFmRAgjyjqZwnBkXiR2gNh50RLMXQ5G66f1MByA+oexgwU4zshfLhENf4n7?=
 =?us-ascii?Q?4Jzjvy25vd94oaxQ787YNW7E2Z7IwXFSqKRX2hYiAf7giRFocAv7TUcGqIa4?=
 =?us-ascii?Q?qF55cYmEp5bfs77xdvqtvGQRHVdlguYm0JyXMW+a17SXLdwKV8Pt6zSC+Jm4?=
 =?us-ascii?Q?VXZ7l8rZgKf0MDxDXEaJNdhvB8uDkpYLg4F9gDbm16A8TIp1vxNXhJKh/jhR?=
 =?us-ascii?Q?sNZmmx7oZtZZkzHaNKD4/002tBD3EDSlTOtN9Ara6prFT7824gcPmBu4lOt7?=
 =?us-ascii?Q?RzTeWfBpFIxEzECjzv8iECOuxktXzLfDnJ6MgvwVGelYkRpLFICO82Ki3ksD?=
 =?us-ascii?Q?CIR4r4gGfvYiEWcdTT1vLHeTCwUoXsJdqc8hxM5rcUs7nESoPx4+t7PJteUA?=
 =?us-ascii?Q?ZkuHhjfmj+9ekvmrXYN3Efn7juQsNEQuW5J7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 11:24:59.0315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c908bdaf-e3fc-49ec-b9f5-08dd9210cbad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8945
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

From: Yihan Zhu <Yihan.Zhu@amd.com>

[WHY & HOW]
Uninitialized local variables will cause format checker complain
about them.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Yihan Zhu <Yihan.Zhu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index e61ed07fdc62..c5c6a33cd643 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -525,11 +525,11 @@ bool dcn401_program_rmcm_luts(
 	enum MCM_LUT_XABLE shaper_xable, lut3d_xable = MCM_LUT_DISABLE, lut1d_xable;
 	enum hubp_3dlut_fl_mode mode;
 	enum hubp_3dlut_fl_addressing_mode addr_mode;
-	enum hubp_3dlut_fl_format format;
-	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_y_g;
-	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cb_b;
-	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cr_r;
-	enum hubp_3dlut_fl_width width;
+	enum hubp_3dlut_fl_format format = 0;
+	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_y_g = 0;
+	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cb_b = 0;
+	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cr_r = 0;
+	enum hubp_3dlut_fl_width width = 0;
 	struct dc *dc = hubp->ctx->dc;
 
 	bool bypass_rmcm_3dlut  = false;
@@ -654,9 +654,9 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 	enum hubp_3dlut_fl_mode mode;
 	enum hubp_3dlut_fl_width width = 0;
 	enum hubp_3dlut_fl_addressing_mode addr_mode;
-	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_y_g;
-	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cb_b;
-	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cr_r;
+	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_y_g = 0;
+	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cb_b = 0;
+	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cr_r = 0;
 	enum MCM_LUT_XABLE shaper_xable = MCM_LUT_DISABLE;
 	enum MCM_LUT_XABLE lut3d_xable = MCM_LUT_DISABLE;
 	enum MCM_LUT_XABLE lut1d_xable = MCM_LUT_DISABLE;
-- 
2.34.1

