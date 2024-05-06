Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EFAC10F16
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 10:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 409D8112F47;
	Mon,  6 May 2024 10:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WQrWM5Bf";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C804F112F47
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 10:01:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X69zMFwvRproMmPh6hZe5FBPmGaEHg6XPZHjQx2Lz0ctqnB9jHNEFznjLuOYSejkxeDM3EY32/17TgUtnDJ+w7YR2kyKzSh+ViRx4filw3BWb/21e0nEabju68vubsxEFFQKQ8UlpZzfhOsRH2JnGXpyH0S8oCRFRb9/phThYJT3JhzMIT7Gt51zG+Li6wCzNTzVOBX5M38J7HxaUPzuuP8VXmZiJ4MFL8mIt3+L4IJeqrkpxQnixe/9w7l0y9ifoKP/Wcc91CNBu0wn/Vgm7+Tf4DuSJVVQDegD/AHktYK+010SFq9+EBlrETUpuOpRz2B+zJkR4Fp/zHBnfoqB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWpnoD0qWGs0V+5HCmNh0lbfSAIK8sS4QLsQ+GZDsF8=;
 b=oW+i+0aqICEl/yw23HNKfLIXpaC78bqSM/oZkj4eE1o6bGbMzHRIEjdICwI6aayl4sS44ija5P5BVsKyidRWbIFmGJ+Fytk6Rk/S2jN+ynh4OyuFG2EuCMvox/6vHbzxD0EKs28+IxGZVMKc0K/iOVC4ozC5vMVW2h51wZd/Kd8HsSM1dJSzd6rGnRFNICPk/XUvJ87g4jin1QspPY2Re4rxp+xxkOcl3XIeue/ikYLjl7kT7kaXZ5GNQgMFN7xR2i6U31EoO+Yyo0xLwIcev33jKSFVrs3cRaJ53+cKz8Fx4FmiK3CoZcq0uerDxpq14SHlZa15oq2BdTNqio3FyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWpnoD0qWGs0V+5HCmNh0lbfSAIK8sS4QLsQ+GZDsF8=;
 b=WQrWM5Bfwgag86Fy10G7Aq1IU689Z7TLA7zsg7iB/630phSx+RqcklJmxPqAvLHHAWSYVqCv+/+OrfdSrB2hx/5zswTaITlLtXg6RECmzRL1mG+HVvb8aK2Wqri+A9HOcod5Qcg/Vinu7WpWdeW5hkcuFubb1HaU8r9C3DIGOfo=
Received: from PH0PR07CA0106.namprd07.prod.outlook.com (2603:10b6:510:4::21)
 by MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 10:01:26 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::5f) by PH0PR07CA0106.outlook.office365.com
 (2603:10b6:510:4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Mon, 6 May 2024 10:01:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 10:01:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 05:01:24 -0500
Received: from primary-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 6 May 2024 05:01:23 -0500
From: Lin.Cao <lincao12@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jingwen.chen2@amd.com>, <jonathan.kim@amd.com>, Lin.Cao <lincao12@amd.com>
Subject: [PATCH] drm/amdkfd: Check debug trap enable before write dbg_ev_file
Date: Mon, 6 May 2024 18:01:19 +0800
Message-ID: <20240506100119.769844-1-lincao12@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: lincao12@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|MN0PR12MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: 4361861c-aa82-4c1d-de0b-08dc6db37ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uiayWhO040LVDCCXvKAesjsuQRdaFsk+G7mWXeOvfqi7mhnZ0kmLt9UY18Hc?=
 =?us-ascii?Q?tM1LHr2m2dw/LoS/WlY6SBY0H/Xnr698SFWduIoS/MmwXZb7r+lfTp3dGLGB?=
 =?us-ascii?Q?7dRgbSYTNKlPePLY2ItbsEa+tfKoIWPNxgCs/y4ELOCUvIYR3KWAcKQDRR0J?=
 =?us-ascii?Q?QDdJ8NszCJTElS4VjMK6vQP4jEdi0lm9LEY/fpaSG67oB970B11kqVvMj+uz?=
 =?us-ascii?Q?w0KrVfsHo7HzttLiRzcSav9QC8RG2ZrMMQz5vva5/kgTe48egdNVNUUGZMeT?=
 =?us-ascii?Q?7FxipQ9a9R5/p4zTwBhR9scIu0S3t7wtdiA0HaR+morxbz3ReYFMMQEAzpbZ?=
 =?us-ascii?Q?M2HXpoxSkJKTrex3f1M4Ox+ajo6wkjsUarikIsXVTPyIE8v/731l34IkJGxv?=
 =?us-ascii?Q?Rt/wIH0k61WI9JGldkgfV02bSNuYCIKQqQ90Dh3kuxhng1bcc5L+opOW9EZ3?=
 =?us-ascii?Q?cJHk04o/KinSV8ohmre4sSxe8K1RZ2l74ONkts7uZJ73QAR2XXAuD3LEiFI1?=
 =?us-ascii?Q?PxFBp4DF3srayHChzx0AGcVxnCgaKglZXCx6LVXQ+rBFGA/p75tbH84prd7B?=
 =?us-ascii?Q?1FeSz/vK9jC62/qf/qiuglYoU2lF5EKErIbjNreevlQ2c0sAAt3LBoWXJnMq?=
 =?us-ascii?Q?PGouWRuTabt/vKjgVrTen0FG4pxv5I2HKWVLglugjvrLd81gsbO98t7shttd?=
 =?us-ascii?Q?iansnXaKx/RiOrhQqxZavrX1EcVuj4jQlnQbxFGkIhh7561cVUSDVttOccn1?=
 =?us-ascii?Q?msb6j16QmvaJXvU5WqUzS9P5ziiMb/6g/lw5m+oJaxatTTg6HP4qa2WkSubm?=
 =?us-ascii?Q?ZjeSwO64B3oJ1wRvdg0coRqeMR9s0GvLjrR8muuDlYNv4fkb5vI6ZeKBnbWJ?=
 =?us-ascii?Q?iPE1FY+DAKDTjnPwUvvKW0Xt1vAQPULj4b+G7FH+A/ETjtacwBuF3zTtl2Mq?=
 =?us-ascii?Q?JwVbf/sXZPesY8xcaY+87eQ6XjqS+5FsBpJZlTd+4VqPuJBH10bUQJD1Vxjw?=
 =?us-ascii?Q?rFNHVqJQQ9y9GsizOVUYwrHG5aFsZUDtrmhn9JnhCfN2wNyImGW9dee6by7l?=
 =?us-ascii?Q?Kxc1wczO3xY2ioNqOf1QDXETI+mrGXfV7jwYMOEug3RQdwsMAIJ3ySu8C664?=
 =?us-ascii?Q?4FZK6h8z5fSgzhmJv9OsZlVAxDzwy2pv2c+KnXDe+SjjRJCTsbT65Pmqnso8?=
 =?us-ascii?Q?/TUFwx2QqT8z7fFhOvQejyIsYhCoY6SxzpxAABxDTS2Lb+8aZ1JnSMnjS3sb?=
 =?us-ascii?Q?RJYLA6P2sOvZIXp+0+kPOb4UkPB+lHZ+bCyiAOTE1qvH+X/pGxPHgy3tnCuY?=
 =?us-ascii?Q?8v6lxc09vdlCyLPOrBcel4J4Z8vkyQkorJxrw/VUvbXgmiMnhG2uDpOXngAN?=
 =?us-ascii?Q?CMWDlx2Eu16c9T30sKr6tXjDCq6b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 10:01:25.7539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4361861c-aa82-4c1d-de0b-08dc6db37ddf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053
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

In interrupt context, write dbg_ev_file will be run by work queue. It
will cause write dbg_ev_file execution after debug_trap_disable, which
will cause NULL pointer access.
v2: cancel work "debug_event_workarea" before set dbg_ev_file as NULL.

Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index d889e3545120..6c2f6a26c479 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -103,7 +103,8 @@ void debug_event_write_work_handler(struct work_struct *work)
 			struct kfd_process,
 			debug_event_workarea);
 
-	kernel_write(process->dbg_ev_file, &write_data, 1, &pos);
+	if (process->debug_trap_enabled && process->dbg_ev_file)
+		kernel_write(process->dbg_ev_file, &write_data, 1, &pos);
 }
 
 /* update process/device/queue exception status, write to descriptor
@@ -645,6 +646,7 @@ int kfd_dbg_trap_disable(struct kfd_process *target)
 	else if (target->runtime_info.runtime_state != DEBUG_RUNTIME_STATE_DISABLED)
 		target->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;
 
+	cancel_work_sync(&target->debug_event_workarea);
 	fput(target->dbg_ev_file);
 	target->dbg_ev_file = NULL;
 
-- 
2.25.1

