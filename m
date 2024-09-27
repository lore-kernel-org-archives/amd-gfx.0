Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58914CDD1CD
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 17:01:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9E3810ECEE;
	Fri, 27 Sep 2024 17:01:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yRrQ2IPD";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31FF910ECEE
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 17:01:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0X3gScrUEFBVZyGjOMLDCZKLIErF7vge4nkH4LmEvQkKbPIuHFd5JAgwMdMy7mBhxV2l0RfgoYXWg3P8dy7AiYaHaK+YLs5maBjPjQIqZSXz+YsOCwOCYElnKMw8s6SmiA5B1Cx8KqSc2w+lvZ4k7RvPQwXXdO9GFwVsijC/SSbgM5z0VKd7EQvsUOk6ChiaSYmO5u9UHf2MEJ/p6hTClmXJqVbIMEjTI1ACEAG/wjF6FxylmKVptgCYWAGNkN0hPGJlzOYSCfvL/kKBYw2VrByWwmjCkr3sILKKMKM3+SxL0aJArXuxyyY5RWBY1abiY846n3uofvxut+GI2zmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qYBK8apOINtz8iunsCgD+AeQojPHSyt5RSexTOifR0=;
 b=uBnvhZX6WL0cxE0EFPK34kTYtOedmYzId4BoKrREXC2fD5HlnaLAJv70BIkqKYhK0quandi2MyP55pMY42E6E3o8FlPa88yksswLL97ChwQRUCRaWeJ920Ic9pc/yQcIN00aZasCIzTAMMMn+odSe3+9TgfZuuiflCJMUlezev65T8+wwGNMWV6nO6tqiMALojP/avCQaDi4AsD5YAq03WPzJFzEAS2U4XQDFacFoQ++SzTHi+KEMaMQzljPUJ4dEP5MRcsfUz68DRI9oVRQskDV41XDvvns494kIGr5FuNmKGirc8RnpomeGVsUUe/i77hM2p+jir//Yxhk6ScP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qYBK8apOINtz8iunsCgD+AeQojPHSyt5RSexTOifR0=;
 b=yRrQ2IPD4PglMlwIvR15ktfBYZQiPg89O5Jkdvw1L6J7Mj3S1jTfFDbwnEnWR1pREQ5/xi1NIH+U8a0o5ev3SAafRirSriLIbQ3KqiOZIbmbtYshsOXZ5VRYAei3e+rLBkN4liDzd4g7TjfqvnHjDks3QCysWeqAhVp028nPXII=
Received: from CH5P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::21)
 by SJ2PR12MB8928.namprd12.prod.outlook.com (2603:10b6:a03:53e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 17:01:42 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::4c) by CH5P222CA0017.outlook.office365.com
 (2603:10b6:610:1ee::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24 via Frontend
 Transport; Fri, 27 Sep 2024 17:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 17:01:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 12:01:41 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 12:01:41 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Paul Hsieh <paul.hsieh@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 03/13] drm/amd/display: Add logs to record register read/write
Date: Fri, 27 Sep 2024 13:00:53 -0400
Message-ID: <20240927170103.102180-4-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927170103.102180-1-Jerry.Zuo@amd.com>
References: <20240927170103.102180-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|SJ2PR12MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: 1036f98a-8f08-4d62-abc1-08dcdf160fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QsaBlK3vj/3dPo9UPfe8pE3+pcF28Ffv2YvQyKURdRgUXqrzcIvbo8snf79/?=
 =?us-ascii?Q?m7tVwj8cdPECkdJL0kJhhpyXcb9RRlDYp7xCdXuLyrfcoRPACPpXodPQ+7x/?=
 =?us-ascii?Q?jJTA6D6faT1AUJrE5B+ZGhuV6jr7QhJGakTt+ynb2wEoyMsVAyStubvXfhzL?=
 =?us-ascii?Q?3GWzROb+BXmAL/mmz2K7IUyK1YKyxRptzbMhKyMCVNoHWESbpZRUxk2yURKI?=
 =?us-ascii?Q?ZLsCyVEAviJ7tPyRLLvzEVY8HsW9gjrgXT/oZD29jJCtBS4w9QRA5FBgSrOi?=
 =?us-ascii?Q?c3+ZSyUg6bNGONsoKclB+t+2BuM8I3EItB3cWW13p1Go34kbGCwqzGJaGRfD?=
 =?us-ascii?Q?W5akTzwYvPzbHF8LeFSQzIWLjcRFaodvp3vtnkSKIAN0mY2RdQe2hBnGk0YB?=
 =?us-ascii?Q?x3KEQJl2CX3K/3yO6FJ1mw3NoskwW97NDev0kw9vePCnOR4MrWPMMU3uLFNm?=
 =?us-ascii?Q?b4sX0LVuQzuUyF9nEitUfi7DVOTr9rzW1i7HCsndJHu+XfC7vKWHRthnPkMr?=
 =?us-ascii?Q?Ui01WAIFPukIth/11uuHQnBliAcxGb63mwYx8Gln9PN5cqctjICZ8W3OiOTq?=
 =?us-ascii?Q?QTn3lEPu+2Rqc3V5PZfDuG/y9R2s/pzbAD3jqCE5ysUMRnYgHTeHNUUm1gEK?=
 =?us-ascii?Q?hvtXQ7sl031f8bknx+dD8RoOndUd4shnsEBX9pLvtiNV+LTew5wG978ZhPXI?=
 =?us-ascii?Q?5yxZdgThGZ8QHD3KkVLcnD3Kx2x+IKV4br25WCmtd3V5XKzc6LdEXsxMAo2Z?=
 =?us-ascii?Q?Xcser1bnwseV6mfbfyOOP3lDTdzXgBCW5k4VjG/ODFf7xkGzyfCEMKmA61Ml?=
 =?us-ascii?Q?xFHTUyY+BcmrrgRJdBKx7Dlg1m1wjSFuI0EnXMrzRJ0ZmxGQVmCJP0MltB/S?=
 =?us-ascii?Q?7u0pwo3NUKUJ+5zT5me/DZ8qehKV51Qjp1IgH8H067UKJRNN5l2PcWe4/rOy?=
 =?us-ascii?Q?9OItSc96/fa8boLS8RdtR44iNjWMr0dgAQcnKVcVImMAZ6s+9S3PxHsaOogu?=
 =?us-ascii?Q?MYjAh4U8wdsAR0XAwllizymohH3nNTm8x5T2UIJTOfDe8qIIsg6SU022mYLk?=
 =?us-ascii?Q?70orN9QWEpBdE+mdrQ533xsCpMx+n4qOBKCPRnYKHOyl5RwxHi9t2n4AUNvT?=
 =?us-ascii?Q?r15uXg/iin5DM616un4LMyQTqKiqjFH0Kdn9zCCYyitac9/vAHKJG8AypUK3?=
 =?us-ascii?Q?oDBuSrrQiiWseJqZ0UqJ/vkX6p+lj3XuEVwOPtUMc90s1LLHY9BrOlrtWnmf?=
 =?us-ascii?Q?DJhTUqtdOMbwiBhADMEoAogdOOnj7rd5L8tzYk8BMM6ZaoH/ftWiTIvhbIuv?=
 =?us-ascii?Q?l2MrrSHMcq1cCfDvDtWSxSutaALDYBKDR2Hzzh2J8648R5wN5YVo10t6y4s1?=
 =?us-ascii?Q?ybDUkjMHnSH8eslbvO5eP5biJfRqfTgj7byCZwhvIGqk+IMvMGX4VJLUkkUj?=
 =?us-ascii?Q?/a1EYon+SJXWSTJp1JT1M5Xb4WNeJ39V?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:01:42.5939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1036f98a-8f08-4d62-abc1-08dcdf160fc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8928
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

From: Paul Hsieh <paul.hsieh@amd.com>

[Why]
There are some issues which customer only can provide full
dump for analyze, without register history, it's hard to
debug HW status.

[How]
1. Put register read/write into WPP log so we can trace the logs
from full memory dump.
2. MALL doesn't add into WPP, add it.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/include/logger_types.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/include/logger_types.h b/drivers/gpu/drm/amd/display/include/logger_types.h
index a48d564d1660..4d68c1c6e210 100644
--- a/drivers/gpu/drm/amd/display/include/logger_types.h
+++ b/drivers/gpu/drm/amd/display/include/logger_types.h
@@ -61,11 +61,13 @@
 #define DC_LOG_ALL_TF_CHANNELS(...) pr_debug("[GAMMA]:"__VA_ARGS__)
 #define DC_LOG_DSC(...) drm_dbg_dp((DC_LOGGER)->dev, __VA_ARGS__)
 #define DC_LOG_SMU(...) pr_debug("[SMU_MSG]:"__VA_ARGS__)
-#define DC_LOG_MALL(...) pr_debug("[MALL]:"__VA_ARGS__)
 #define DC_LOG_DWB(...) drm_dbg((DC_LOGGER)->dev, __VA_ARGS__)
 #define DC_LOG_DP2(...) drm_dbg_dp((DC_LOGGER)->dev, __VA_ARGS__)
 #define DC_LOG_AUTO_DPM_TEST(...) pr_debug("[AutoDPMTest]: "__VA_ARGS__)
 #define DC_LOG_IPS(...) pr_debug("[IPS]: "__VA_ARGS__)
+#define DC_LOG_MALL(...) pr_debug("[MALL]:"__VA_ARGS__)
+#define DC_LOG_REGISTER_READ(...) pr_debug("[REGISTER_READ]: "__VA_ARGS__)
+#define DC_LOG_REGISTER_WRITE(...) pr_debug("[REGISTER_WRITE]: "__VA_ARGS__)
 
 struct dc_log_buffer_ctx {
 	char *buf;
-- 
2.34.1

