Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F6FE7717F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 15:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8603510F076;
	Fri, 13 Dec 2024 15:55:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SZ9GA3rI";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41FD610F076
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 15:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4+1AiYmfxhKvBJBXDVgxTGZnwr8dum0xTTQp1AWtDedDCJLQeyDd0w9dDFt5uO4078amhkGtCwV2/UmC7ZQ3IJu64Vqn1AYokBDCb9+8fKAwqtAReJCzJ5wGCSJgeoG5M2fJdDeNe9sHxBqveehpKAUaWGzKkBfMWyKh25EoIaER0R0i/hsBJGUrGsA6kCVhcfQ6Lxnc33FfsSjvt+ZAoRZ/V+GFqMVDzVRm4Sk1Ahn+b8lT1ZEXrmIszJFn3otnow89cNb3uFjS1lEjdI7q0S2wBHIdX3U9G8FM6AEKs/dRzTyVSPsKcAwTqYctzznVDsURZeq2rQxlDPLAbcN+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16oCXGMHBr10JlQrQJahDbKzm2lW0+4XsyVB8PBKPQk=;
 b=YQMKScqGV4rcsO4v2irAOUu4jtRjxqYSTnicBxrURALuafiSJqrunp5GhAiwmPJ/Jf9uWMsCmMU+wjb0JRqHQpHDrgYHFPrckaUL9ExR2djN0dIVuua+O0ZkZ9M1c5PWewUgWu2PqQXDzI//hg7QjruviyiZ2s2ZG3l4udX+9O2DgBkleQuG+UM24E8RkgJ4t/9E/u7nkmbXypy2QdyYL/p2m8HDeKYchHzYy25pzN+11RmrZ0uTN7Z6frM0ZyGy83lDwelvZrcVxizSgyKrJXdMNcWw3dGoOa6nDuW1KJ89OdxSV2gcTjBvu2ULaU1kVH1H5P2/8+crWeVH9/kO1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16oCXGMHBr10JlQrQJahDbKzm2lW0+4XsyVB8PBKPQk=;
 b=SZ9GA3rIxEJaiygHMCZlg/r8eQj7DbizwhfCgKrJ3phY0K1SrJQawknY6kCJTRI+SL//ZH6WMzJwA/HxvJmNmJWAZvfwy5HlkElH7lBEOfkhKp41SX+R6NRftqlSv45+6tOAoMGvk6vQzMzZQRzqdqQy5ZeiZXSbJdv86S98758=
Received: from BL1P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::12)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 15:55:17 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::7b) by BL1P221CA0001.outlook.office365.com
 (2603:10b6:208:2c5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.17 via Frontend Transport; Fri,
 13 Dec 2024 15:55:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 15:55:16 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 09:55:13 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Leo Chen <leo.chen@amd.com>
Subject: [PATCH 15/17] drm/amd/display: Don't allow IPS2 in D0 for RCG Dynamic
Date: Fri, 13 Dec 2024 08:52:47 -0700
Message-ID: <20241213155405.393252-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
References: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|LV8PR12MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: d4bfb06c-79eb-49e8-4573-08dd1b8e8973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sKmp1JPT5XVDdLjOwYPoudsMcP7ztol5yHQWOeEbGirsgV+WaPbjU5YlgvjL?=
 =?us-ascii?Q?iKn9JXG7cC7TD0mjQ74h41WDnvKrquZ5p9xNzzgO8vuucdK+67w67K93elXD?=
 =?us-ascii?Q?+sUOyYITAzv50eLhwFaIqMAa28uzJ0pMN7YyCTIstH84T2eGL15fyxslq9Em?=
 =?us-ascii?Q?hwLhMIY0D+b939nk9WEm2siUUvxBG1kjnSeZJuO2MvDO0Pr3o4jisdir6/xY?=
 =?us-ascii?Q?CqxdKY8Qst3oOe6B5Wjt0SjxnLdt9u84lMMHQ3W+FLoYx7Kh7oUA1phb1KjI?=
 =?us-ascii?Q?ZGCUhdCZPpG4o5FXHiJ9HsbZey8W/xFVQL3ygZ7Hbxnq3PGSdm2Yh2VNCyas?=
 =?us-ascii?Q?Rxuggf05orw9NuWQpUADYCJfTQvxzItMF8qnS1Xigvai6/yCzEAK7/engkY6?=
 =?us-ascii?Q?ASilanspcT2B7sPCc1MmK3KPlWfprdfep4YTc/GNaLkdQnweDsz3hmX4LRMl?=
 =?us-ascii?Q?hmqbZDM2azs9vlSI44k3yXWlfAMXiWg8i6PTc+0ROnKzqQWbRP1fdy0XzyoP?=
 =?us-ascii?Q?5We3IoMSFYCihTavrifAs7b9bMkoc4Qwga6y+gOzz2vmoNGeKO/r7ZPO8cT/?=
 =?us-ascii?Q?NJIKR4v0KvdfwjwBZpMYDET3IAeAWx7PuFSy7JKDNxIly+FZDBAIHaqKHROl?=
 =?us-ascii?Q?74inY7SO46OH/Ke8v9c6LtbiVhwKTIgOCT75VEoQhIW2K75BOffH88Jv2dWL?=
 =?us-ascii?Q?sNVa/sa0iS6w/ECUS2rPt/whY6u7IJzyFiPFWuCxBY7pH8rufiB7BBLCbXcO?=
 =?us-ascii?Q?2exn4JYtPaMBuJdfj1FEMpH4ZMS2SRcbytREo+yp8lHnU/bdjkpum1sHQbI9?=
 =?us-ascii?Q?SzSNsQh7TEHtrGVQQ5slbRAQNopllneTQvER2jFCzjJALg3ZRNeTaBCrCpkv?=
 =?us-ascii?Q?iFcsIbBbtmZIyCMWZ2YOryMF6ImEOwOFOGCn1dnejHi53LphsMGKbJUv61Va?=
 =?us-ascii?Q?6G77DOtlxaR70HJNS7ojjfJ4UXN+fI9KMshW3D85ZCE7zfQb45bs/IAHBMco?=
 =?us-ascii?Q?N618xDDRwWdm8AvKQ3x0pk6c6cK374+dKLZQXeZpyG17zy+O0V9irl62CGXl?=
 =?us-ascii?Q?OG9FXQFkPjRYpmzUKbXAxLgmqalcQ2uYoSKDwQXyBXlxz0+Mu4TUTTR9w3oP?=
 =?us-ascii?Q?kjNHHJUyAH+zwdWgEG55oiH6z1oW6qqm1OCK3EABe+6Nl3IcFbfd59XqiLWn?=
 =?us-ascii?Q?AsGKx447rCg7kn9FsuhGzzBm/56uJVJcoPtOov7Kc6xqwWg7NnLAxEx/VVMV?=
 =?us-ascii?Q?7oGcL5mUu1Mzb0YUFHkvAm3MC3cftlD2tfymMrKFhSTcgQZI6D2k6Zlni3VQ?=
 =?us-ascii?Q?PEq9qoENndWm15tXFVlovsLeeaTfmKP8xK3eYUcPx9LANAz5/YcEzycCvD1M?=
 =?us-ascii?Q?64lQqpR4WXTAYI6Y8Kghzv7yzyhNSfOSuAXNLehxTIcdKoAfRUB6smIxr9MY?=
 =?us-ascii?Q?XgKnS2nvkdQeJv2qBBee7X26Yzx2Jd24sRd7HB45qVBOtWIdiXp5+oMtBc3I?=
 =?us-ascii?Q?GFVgq8QrH4Kdbdg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:55:16.1192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bfb06c-79eb-49e8-4573-08dd1b8e8973
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The existing changes to the DPMS off flag should help reduce accidental
entry, but this change further restricts the entry condition.

[How]
Record last power state as sent to DMUB.
Don't send IPS2 allow if it's D0.

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 5 ++++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 44ff9abe2880..cbe63a870492 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1313,7 +1313,8 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 			new_signals.bits.allow_ips2 = 1;
 		} else if (dc->config.disable_ips == DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF) {
 			/* TODO: Move this logic out to hwseq */
-			if (count_active_streams(dc) == 0) {
+			if (dc_dmub_srv->last_power_state == DC_ACPI_CM_POWER_STATE_D3 &&
+			    count_active_streams(dc) == 0) {
 				/* IPS2 - Display off */
 				new_signals.bits.allow_pg = 1;
 				new_signals.bits.allow_ips1 = 1;
@@ -1517,6 +1518,8 @@ void dc_dmub_srv_notify_fw_dc_power_state(struct dc_dmub_srv *dc_dmub_srv,
 	}
 
 	dc_wake_and_execute_dmub_cmd(dc_dmub_srv->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+	dc_dmub_srv->last_power_state = power_state;
 }
 
 bool dc_dmub_srv_should_detect(struct dc_dmub_srv *dc_dmub_srv)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 10b48198b7a6..4763e652c9c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -56,6 +56,7 @@ struct dc_dmub_srv {
 	union dmub_shared_state_ips_driver_signals driver_signals;
 	bool idle_allowed;
 	bool needs_idle_wake;
+	enum dc_acpi_cm_power_state last_power_state;
 };
 
 void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv);
-- 
2.45.2

