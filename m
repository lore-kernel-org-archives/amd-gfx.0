Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D46ED35664
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 01:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C10710E5F7;
	Wed, 28 Jan 2026 01:59:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C6mYl686";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97CEC10E5F7
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 01:59:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSE/hMr70+v6AcCc51q+GqabOTO8sVLIw3jxyyG0qSwkwPEG6QYRl1InxIdXHWCi72SpimwL2XcltLf0/07raZDMfUGK013v6b9KHx9jc8By04EePCL0h6azh3o45aNaXiyQnqqtFS4gvcgHmsdQeU/K0K2LrE/UjlUvWjRo6FKe9Xb/S+zyenI9p2qCvhLyfn5aQGh02VEEbLBH7EqopW0xzQmKvOP4JJzl/v6Z6g7BjTaetE3cwiP0TcjmXo0PXTQ6CWqUrKde7sDlunDxsb0tdiq1DdG/6P2RvMmB2TlBP5NDSi5mrUyFYXHwqSyArt8mD+b2ii/EJEALzF4eQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2ye/R1V3j47jE8Hp5U0oN25fJD3hWA8ATCJTH4ug/o=;
 b=lqCnPcUcmBjIf2fAkkn8CN9dTDtJXLB+VWDvCBqRmL7lm0txD8wBc/i3uZbu5MGqBwfg63PXTEkJSJMxBa3VMlK70eQ/ty3E/Rvrqf5+gni0RFuF1so5fRSs3EUeyZt+Qh1cadE2IvBzQctp/t4LBFhFYht4rvZsc/VzRT9oSZWJIuYPT/pYyzXcBIMr31brfuYnyOon5oS63YgqV1Y6KYtpf1KvHAsPS6+95T9M/IlIaqp7iR55c9+3AQE4fhwP21wtu6X+rHP0SW/8cv2km5hadPugaYODNU2mZtf1MAzR8zV4w+8UHRpk+0oyt/rTopN6xDlMYlPPCy5WJOwu/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2ye/R1V3j47jE8Hp5U0oN25fJD3hWA8ATCJTH4ug/o=;
 b=C6mYl68602Mu+RWWxPfkeBpv3s9YiG+yc9d4YnFPWxvLVtU64ybKNnhevjsdUuTsiqdFsRzLqk2NrD1n0qcU22rlDzKZMTrdhHbc9pNn1Woa8MBtC7FX7qgPy+9EV6GVAQC5R1Rq2cb7sVkcOF5gx5qTu5d/VNqSeAMgjLX8p20=
Received: from SJ0PR03CA0192.namprd03.prod.outlook.com (2603:10b6:a03:2ef::17)
 by DS0PR12MB8528.namprd12.prod.outlook.com (2603:10b6:8:160::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 01:59:44 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::4) by SJ0PR03CA0192.outlook.office365.com
 (2603:10b6:a03:2ef::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 01:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 01:59:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 19:59:43 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 19:59:43 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 19:59:35 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 08/21] drm/amd/display: Fix IGT link training failure on
 Replay panel
Date: Wed, 28 Jan 2026 09:51:33 +0800
Message-ID: <20260128015538.568712-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128015538.568712-1-Wayne.Lin@amd.com>
References: <20260128015538.568712-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|DS0PR12MB8528:EE_
X-MS-Office365-Filtering-Correlation-Id: e90e2ce8-995b-4cb3-ec29-08de5e10e841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JR0DgNyLDo74bkpHMPdijUalRufsf4k6RwpSUiA5qLXMKAPiM+AODOz6bats?=
 =?us-ascii?Q?lmYwj/vMpAokAtSB6Rtua/pKpomYPqln1KXpZtxt4pCk68jWDJlyYhhI7Tsn?=
 =?us-ascii?Q?tjaF7WGM2eiAXWkVt+XJTpi+hsI6g3FQVOqZw5H1WsBzFLj6B+JI2u18YUkQ?=
 =?us-ascii?Q?AJypKHM52g0xO1EwXCtx3lcvXs7ty24dg2a3YSr/kRkxMc96zD0kEOKskYK0?=
 =?us-ascii?Q?zdxoaEtIKt+f/ynAM1jWzUhFGvAcp3ytbtS2HynCLakxnIIwM1gHYELtOvHL?=
 =?us-ascii?Q?Rt0Bbl/Lm/7ZctOLWgR0pwFHgHs21mznJln6p3dS3m/6y9BmC8692ZR52WZ/?=
 =?us-ascii?Q?q4r5RHztPDq8rCy1c+pycQuRJUeENrjjwKsGtqyYxlFAypPvTuzkidezAc7J?=
 =?us-ascii?Q?w+6PEnzSS2skNn65xVWYArRiw5SO++f0sI/6aikGHJ2L0i5cTQ+yO6jdyHer?=
 =?us-ascii?Q?3osdLQkZeC+cq3aqustomEpn6VfqRk+cllOo1akJC9JH8G2NmUhA1RSQ09pV?=
 =?us-ascii?Q?y0TSI2FS/HUb2V7qd1yU2IEDDv3RgueoFCoi/GI08BAzZvxZz0EL75XVdqkV?=
 =?us-ascii?Q?RqmEdx27EJ57SGmNCFNqZE+U01lNbFZa2Tr8YCHBVsZ+I+ROTWkLoSVJGlpt?=
 =?us-ascii?Q?rXKsR3SI+S+1Jt4CL/j6ET+tV4+qijdV8xTUsd4omzbMrTxTxOq4AthXlQ69?=
 =?us-ascii?Q?GRrNYNRW5spAGRS1Ngp63J+zPLHiknBR0W7zqsaCkPsmdUOBBEsefYHoWdwI?=
 =?us-ascii?Q?Jhf7sgg9fhqvLb3cgTTwxT8FRgqGb0AX9hOpExWlA1HYJcmVj2jMvu34BBtq?=
 =?us-ascii?Q?JN8LI8Qw4rVzuOmAsnWdFLo7XgOUlDPVXZ4gJ/xwTwYD1BrabKYj9fm241KI?=
 =?us-ascii?Q?4Bn+18POnbpEf4G1mlmzyqo9MHe5xQnMxSr2jDvRlTQB/fhG0+/UFVdRtdwi?=
 =?us-ascii?Q?OCSvG2yj57rO+LMXHwTc0nLiorUq88/NPnyjtgoXeiFmm0KxRnN6OAEU7GIX?=
 =?us-ascii?Q?6dQ7iFlEKHVqrFgKq4G4tmeK9BlrL1rsJFm9xJN7nnDVSFrh6LwwYp1pp/Zt?=
 =?us-ascii?Q?sOFGJwGLf/Ate3UDL3V6/5AeqHMynR1eCp3VlB05hyW+XVPIZN/YeNWJ9LfH?=
 =?us-ascii?Q?F1K+On1X7nbfhu64GKTcbr1nmzFiFNFfG8gjLKtR94cCq8FPBZzOAbUk+6Ub?=
 =?us-ascii?Q?k81mLa4Y7XIRqkp2XPoTxozsaB8n+BLO2J4nky9125oDaGDwxlEyCnbylOln?=
 =?us-ascii?Q?giJ+JqtTH1Y7IiiACrxCPdUkJ0Cnvn/cRtwkDZj8zUIluMD0k/m1yeh2+1c7?=
 =?us-ascii?Q?ig/PG0B+bKMUqmFJXtuZUlUWAsmKDteYQSw+vMNGVn7dkbD7DG5PWBP5DxDO?=
 =?us-ascii?Q?Va8djW6JsQDkWzwToF8LInn5q5TdCgvOf+MmPukOCJGpYgltBh3PJbJhyb64?=
 =?us-ascii?Q?vPHODnKSJ0hSOVpYThcf9iN8/uESAwII6LJEU7aEUZf5TBZWSo7WPsSiZ6kl?=
 =?us-ascii?Q?gfcCVHRb0/Yg0FXhixXpAnisJBEC13Laiz8w99TIoQnG+jZmFnRmMAUP0S9w?=
 =?us-ascii?Q?VU42TeS266npwWcIAZsdjrqr/iCyMv8VSqCMmgTGZjGG4bmlYOA2ZHYV+HoJ?=
 =?us-ascii?Q?/Kx3phRA0VvJHQ3L8D0qayrc8elBXW03htuBkagxgqEMk6zjGOpJnyWWtSAJ?=
 =?us-ascii?Q?fQizbg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 01:59:44.1494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e90e2ce8-995b-4cb3-ec29-08de5e10e841
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8528
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

From: Ray Wu <ray.wu@amd.com>

[Why]
IGT link-training-configs test fails to set the link rate on Replay panels
because some link rate types are not supported in debugfs. As a result,
debugfs treats these link rates as invalid, causing the IGT test to fail.

[How]
Add missing link rate types to resolve this issue.

Reviewed-by: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index b9ed29ec60dc..5fb573214f18 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -302,8 +302,11 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 
 	switch (param[1]) {
 	case LINK_RATE_LOW:
+	case LINK_RATE_RATE_2:
+	case LINK_RATE_RATE_3:
 	case LINK_RATE_HIGH:
 	case LINK_RATE_RBR2:
+	case LINK_RATE_RATE_6:
 	case LINK_RATE_HIGH2:
 	case LINK_RATE_HIGH3:
 	case LINK_RATE_UHBR10:
-- 
2.43.0

