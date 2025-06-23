Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37F1C7EE2A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 17:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55ED610E435;
	Mon, 23 Jun 2025 17:12:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZZGRKFjJ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFFEE10E435
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 17:12:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rE2Xto6FXUvri/PsuRF99BNvYztiNuKI10OtQBoNKFxVhONONO5UgnEldjHkRY1tZtYMhGHa0CKCCMxkCMuwnu+PfXj52xps5nzSL2NW/WNMBASWozHbeJIjConeJ2qvToOYPSBTBrCJHAg0Xvk803gKTlMdl4li7WAaOEZJM1SQJnIVoe7bLE37DKQJtKtQeCniM9znOJQVMduasRqGwFC4RON9fE6069zsiXV7WjLhv0MGSqODFjtXR5/S2yqkRodLJCvo+jlncmPL0B77w6kE0HvtotApLTpV6ZLv8IYHj66phDzcXPiZAOmX98FSs0ZEtktptwV06wrD7XrvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJ5FmTSxIx71/A+5Ef+AiRFevTW9a/zExYyVOs47be4=;
 b=GtlnYjjGI2FALwD8y41VQX0Rqwd10DLchj9j96yrKsTfrxsCRXUmv8YLGsU6sIof24H/oicq2hK0LUte7WaF0mk8s+KgwPHuHkQkzLPXfzQQcxV8byyjplMRg5+2vpp9mkeRuTWVcWLdUAxlW0ySqTogAk3GOKwK5+C/eBEmLjPmJFSwWgYMJOHSXI9R4+3p3H6aQfEVqnp2fJwUYromPQFUafWWce6cEh45ELK+XBljJnbTvbFn03jSqfcYET8gWoTnXhH4c3KvRdMlvmgISwJ+9Pyc7LGxTINY/TdAlSOZPMKBIXc7LT+O39mko96tkdd6ljGv0ptrMPTLOZR5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJ5FmTSxIx71/A+5Ef+AiRFevTW9a/zExYyVOs47be4=;
 b=ZZGRKFjJGzvghqzL6xwOriwmUtBq9hlbNGbQCCGmrN92ssHnEnfpBfkdqnY/WCMEDy2f9uGIyzWQ7NbDiJlwcj20IVD9GozD9UR0GHPXUhWwl43c1u32O6KdeExQjwZuhgvYtZx17IsFkemqsCeVqHCvbikxP4RZrx+5p5nyc0k=
Received: from BN9PR03CA0797.namprd03.prod.outlook.com (2603:10b6:408:13f::22)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 17:12:10 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:408:13f:cafe::5f) by BN9PR03CA0797.outlook.office365.com
 (2603:10b6:408:13f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Mon,
 23 Jun 2025 17:12:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 17:12:10 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Jun 2025 12:12:04 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amd/display: Add a trace event for brightness
 programming
Date: Mon, 23 Jun 2025 12:11:14 -0500
Message-ID: <20250623171114.1156451-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623171114.1156451-1-mario.limonciello@amd.com>
References: <20250623171114.1156451-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7a86f7-c24b-4fc0-f9ed-08ddb2791740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hF7CJTDZepAulxEAnKn3anz0iX9CaC27dnyE71LrYmDZF3hUxxwo9Mi122vG?=
 =?us-ascii?Q?U+rsJjIc9Peyz2ltyS9Fo6XIREvyCjIx5v677l5fOaiQP3318IY5Zcf2IcsT?=
 =?us-ascii?Q?Al4UV1jVu56T65Isd+nR/AMA0jS6Edv06b0ucYKGSXssH34lRb4WmREOr81Q?=
 =?us-ascii?Q?4rU+CJZoAvs3g8EO9X6SK0M7HLAUr7RdvgTvme00WPx5GR8GeYg/XkhSypyk?=
 =?us-ascii?Q?7Qtwtq0DRSW8e5k4VNqHb6+RzKqm92IGjA8oyRu9Az0r+5b4Er1S8iCPOkmO?=
 =?us-ascii?Q?lASNwMutl1Km24I2i8mkbWpDasD5VXr+nBXEVc7C5psoQQ6Es7vn5tqrlOJ/?=
 =?us-ascii?Q?2XiajUNzkg0MjkTP2eus/ZvxOYzfeV4/NJOB44Xb0bd8bCLTWQYYJsO3AxEp?=
 =?us-ascii?Q?rW/1BxJBQKEa6VMnK9RdzASY+7T3EjL296ZCgX+CaTurWYxdxrdBSB+p0KEH?=
 =?us-ascii?Q?2tscYaz3eZmV1Y1g0x85y4rfi2tfazXQHHUnlPcflactdDu1Y7k3STiAGMxH?=
 =?us-ascii?Q?mf5A56FS9wuIimo/3e3BcGF6G/OK8cm64OKMmx31ssV/qTRQ0fRODADNvZy4?=
 =?us-ascii?Q?FpEWayy/2JHldyD5uFP97qPLcl1t44FRh5uYQAk6BpruwZBcPGB40EtC/Km7?=
 =?us-ascii?Q?XwnFW1BNpZrTYuQWt7qw+QSpKvmFJIWvj+py4v986RQ5hc9CxdF0xz7zmMhD?=
 =?us-ascii?Q?zifSwIG57af3XueN7LNKDaLfiCz2puyesCvSrbc7DY/z+Vfr8C2sTD3wbIUd?=
 =?us-ascii?Q?s9nSHyrJ5AQatWGtPzsYyQFdTmORexVq1H02Ydp6HZXE0h5YLrKJm7odUmez?=
 =?us-ascii?Q?1CUr/Wvh5mpUjNsdo8FDxNdi07Xfm3ppDId0DZCmgZ4hR1Wndwmhz+CQOuny?=
 =?us-ascii?Q?poI/D5enhWjWs5hn9l2GQZNrjS/1jnm21ytvtqGCmVCSBxlkPym6Fyr4e81p?=
 =?us-ascii?Q?Q5yDfsrUn0pMZ4Q0CPcShs9FqDl1cK/RSZ8TgFlvFUXdiBq7kZyE7FdgM9E8?=
 =?us-ascii?Q?5djvIJADiA16br5LQVboLNzIqIctcht5DMk5o6qNu+gzT9xhHUkvjxXyH3t3?=
 =?us-ascii?Q?2x3MoKR/V8W8VEPoOmBWfabxqIMsHTJXw/ZNRvvRdh7QVkMIhGNJ+4ex/jWV?=
 =?us-ascii?Q?L0SnR/RZfLnYMTgOMcX1VDR6UU9n72650WFC/Hr+mfvByAiaOsQKlo9SObpz?=
 =?us-ascii?Q?JfDvHi63qhH8lXNtC4o2Me4QCK9xu9iw3raXFpLf0vicC02pAQTwZoFMWxqb?=
 =?us-ascii?Q?gAU4F124Zli3Ilzgzi/TTRL+EkHOxUnIZWPlinqFS1/qSlzJbEGxRDogR+4L?=
 =?us-ascii?Q?31F5Y5FJ3NclvtXGh5HsLPRgNWvw9tTsnLnaBs4jgYbMmf1remi26uqyLxYp?=
 =?us-ascii?Q?5Bc86Xjte99MuFQ00qk3pJc0o2Dn6+2xx1Bue6TM5DI6uAWEMfQ9simd+bkq?=
 =?us-ascii?Q?OwyTFFLMlk+Ufqiu25nNTJRExUKJt2vsa24VhcQq5mM5U3ZhvufxoA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 17:12:10.6918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7a86f7-c24b-4fc0-f9ed-08ddb2791740
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716
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

[Why]
Brightness programming may involve a conversion of a user requested
brightness against what was in a custom brightness curve. The values
might not match what a user programmed.

[How]
Add a new trace event to show specific converted brightness values.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/debugging.rst        | 18 +++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 ++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   | 26 +++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/Documentation/gpu/amdgpu/debugging.rst b/Documentation/gpu/amdgpu/debugging.rst
index 7cbfea0606e1..ac914d524741 100644
--- a/Documentation/gpu/amdgpu/debugging.rst
+++ b/Documentation/gpu/amdgpu/debugging.rst
@@ -85,3 +85,21 @@ UMR
 GPU debugging and diagnostics tool.  Please see the umr
 `documentation <https://umr.readthedocs.io/en/main/>`_ for more information
 about its capabilities.
+
+Debugging backlight brightness
+==============================
+Default backlight brightness is intended to be set via the policy advertised
+by the firmware.  Firmware will often provide different defaults for AC or DC.
+Furthermore, some userspace software will save backlight brightness during
+the previous boot and attempt to restore it.
+
+Some firmware also has support for a feature called "Custom Backlight Curves"
+where an input value for brightness is mapped along a linearly interpolated
+curve of brightness values that better match display characteristics.
+
+In the event of problems happening with backlight, there is a trace event
+that can be enabled at bootup to log every brightness change request.
+This can help isolate where the problem is. To enable the trace event add
+the following to the kernel command line:
+
+  tp_printk trace_event=amdgpu_dm:amdgpu_dm_brightness:mod:amdgpu trace_buf_size=1M
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 77302caaf24a..2ac5cd225781 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4860,6 +4860,14 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 		reallow_idle = true;
 	}
 
+	if (trace_amdgpu_dm_brightness_enabled()) {
+		trace_amdgpu_dm_brightness(__builtin_return_address(0),
+					   user_brightness,
+					   brightness,
+					   caps->aux_support,
+					   power_supply_is_system_supplied() > 0);
+	}
+
 	if (caps->aux_support) {
 		rc = dc_link_set_backlight_level_nits(link, true, brightness,
 						      AUX_BL_DEFAULT_TRANSITION_TIME_MS);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index 4686d4b0cbad..308a36176bd2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -726,6 +726,32 @@ TRACE_EVENT(dcn_optc_lock_unlock_state,
 	    )
 );
 
+TRACE_EVENT(amdgpu_dm_brightness,
+	TP_PROTO(void *function, u32 user_brightness, u32 converted_brightness, bool aux, bool ac),
+	TP_ARGS(function, user_brightness, converted_brightness, aux, ac),
+	TP_STRUCT__entry(
+		__field(void *, function)
+		__field(u32, user_brightness)
+		__field(u32, converted_brightness)
+		__field(bool, aux)
+		__field(bool, ac)
+	),
+	TP_fast_assign(
+		__entry->function = function;
+		__entry->user_brightness = user_brightness;
+		__entry->converted_brightness = converted_brightness;
+		__entry->aux = aux;
+		__entry->ac = ac;
+	),
+	TP_printk("%ps: brightness requested=%u converted=%u aux=%s power=%s",
+		  (void *)__entry->function,
+		  (u32)__entry->user_brightness,
+		  (u32)__entry->converted_brightness,
+		  (__entry->aux) ? "true" : "false",
+		  (__entry->ac) ? "AC" : "DC"
+	)
+);
+
 #endif /* _AMDGPU_DM_TRACE_H_ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.49.0

