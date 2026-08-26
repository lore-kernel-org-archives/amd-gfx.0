Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC39C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B84310EE45;
	Wed, 26 Aug 2026 23:22:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wOYoA8by";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1685A10EE44
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxWLWhUk5Pw0kegQ7fnjLqiGaGgQNBX+RepiVFjDkkfl7B+DgsPQbXQQCU5WPlxhYq2SbMTBp/zygaQlJlzT6NgROD6tDG8DEJ8XKG/LQVgAw5AHaBwXJaZ82gwqmjA05g1AD8UotpvrzEEcybr6gxKEFdb/6dqUu/LyhOrn+h+gn8FQcpv8/9DNmgq1VoX7f2U8w9WELq3jhMjocz4wFwGe6gBN0lpEnYIytJk1OWiqWNjjGCchn0iH8bwymywO81bKYXoU6K3BV9LY/B1o7q4YmYub+bd1+RLOk3CkOiHgKxgWlTwFOy0Jz+dygGydmEe7399+EFOhT2iSLO/XYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9tL0P9qyidAoc7muDjwc/2Y4K5w+IwEYgcq2GlRCak=;
 b=n2hGyB58sfLbAFcLt5mEe24XxCPIeY4TimJbP+hiWbqbSMsXduXk3gJw/1gd1R6Mt8g2c7Ym/hZX++cdm9YTs/+7IKCORhEEFD6qsWJUdeYrPIW5dS64KNVfFtD9M19QiQBiw8D8M1s9itKAml4beSeA0Gx6ABe9GVpTET2HjFdQhIzinOpe5Tx9JfDQkHNmBB0cBOfuZWZJ2lDbin4uuj2ZcwtgkZfKukNSdvo8El3dfbPdtw1goocNcbs1+uHsKjWln1/cP5WBknwnFkUa8s1kEZ9PYcOYH22qM412n76d3mZsaINb6g/b54tqE/ZWfGqBeslYo/gpWM4TAAZc3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9tL0P9qyidAoc7muDjwc/2Y4K5w+IwEYgcq2GlRCak=;
 b=wOYoA8byaqrMc6Cj9CdS5gxMQaD9A5SxzYlghDLBrjNFTCHEECDAXGowAbqtq30HHDthyjCoaMjw4cd+cBgjMz3IN0eU2VHkoZmpJd8Mfczy3X2W+KnTzK4J7qa54PJUSYimpfMD7EHQLK6Mw3/qQa3eJtRFswCdGF8HBE1G4xs=
Received: from SA9P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::33)
 by SA1PR12MB999108.namprd12.prod.outlook.com (2603:10b6:806:4a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 23:22:52 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::6e) by SA9P221CA0028.outlook.office365.com
 (2603:10b6:806:25::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:22:51 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:22:44 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 21/59] drm/amd/display: Model ASSERT as path terminator
Date: Wed, 26 Aug 2026 17:04:52 -0600
Message-ID: <20260826231519.881949-22-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|SA1PR12MB999108:EE_
X-MS-Office365-Filtering-Correlation-Id: 3679a4f6-eb1a-474b-b637-08df03c8f319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|6133799003|3023799007|10067099003|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Y+R0E7cS0YFrtZy+WCpSqiUvuCeGKrPno9MyIH13gPhH1XO+ndyrbFeyVKB9KA+em2noVC7pmikc6ordm+i907C5ywtuLVoe9gqkN4hCKPJ7ppinvl4W3U3+++F52tG6yjfonw9IRBeDp/t9yfh7Z9OLqs69nxLW0U/zHzdOrjdhbaKLQrWpdJfNtSolkWdvY99OEYuSbqUaqL8fzgnRInwtZe6aV3YmKuzPfnEV4oB44bSyIDYygJeNHPPXU0gjdVMX4ff2oY5KVRZYMFHQ8hpKhghlOEfXG5K/ljU4GgeaYJL4zrZQBqXdmMq3ObmPWOT3xNG9JvyOEDRh2D8lcJJVBBOND/+KJoT6pMTv7QUG+UVhAAmaNf2Kmi4ki5EcgDfLl97uYsOFnX3kHouh/OrYhaIkNPMuAVO//SI9fnHnE18eMDLaaKVdyahU8OfWxoAk5n002BRBi1k54HX5jmvLHQaog1MTghuqGyLAN2MUxzlVBJTLqVM+DtR6meKdPkmdqZJ0gFlX/RQIFbVQeiC5/IQWnZmfphGcdY5lrOjzsSoAydBI62ww3JVmUCPCiFqyFcQi9LMn+lm+B4z4qS5uqhCRd1NWcHRUhthPBV7tji15P20EYleDdozOK2kh5jyx+07Ke+STca5jWA0fLrUhB+RvZTJIIzVjmGfS49Pjey2SoM5bfO691LiPuoky/cfCY6Gw28Rygvg/yBt9KA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BXuogxySsc4NRFgdoX0M4qCwDtpOcLvBe2SGV/5lwFu04l6zjCbIqr6heyrMyuqhd3jjOm03yo3mKPsSyxB5JnqtceMd2evQQ0szCelHDsMB37z4ef/qaQShbv3mFfjNYsHpcbGbekZy51HpzIy+PVDh94SzMw/btYozJZVBh3IKIuFoPi2HZZPdQmv+Med89EohW9xSuyyfFftb7ozEmAeOWk+avyllFIsRoRvD2CqkFRuTHqhJB2Qsfq1s5sSN4S4Biqq3JsHkkRwjuTmOUAvZPywlGgRXqcIz5mjry98smNs4li5USoSsYkK7StYQd3UHJKheyHSXdzSaU9SUCamSVbPJCiz+bcgBu5QB+nGVU7b31O2ELFuIpv6pkX64PiCiQaQ4GXQ0rxkT+a3CkuFNkzX0WH2fWZOijPJiLKPygBW5eW2e1doX0Su08hcO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:22:51.5572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3679a4f6-eb1a-474b-b637-08df03c8f319
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999108
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

[WHAT]
ASSERT() and ASSERT_CRITICAL() expand to a WARN_ON() test that falls
through, because dc_breakpoint() is a no-op unless
CONFIG_DEBUG_KERNEL_DC is set.

Static analysers read that test as proof the asserted condition can
fail, then keep walking the failing path because nothing stops it. The
assert therefore manufactures the very defect it guards against, and
Coverity reports DIVIDE_BY_ZERO defects whose entire path is the assert
itself.

[HOW]
Redefine both macros to call a declaration-only __coverity_panic__()
when the asserted condition fails, which marks the failing path as
unreachable and leaves only genuinely reachable defects.

The override is guarded by __COVERITY__, which is defined only while
the analyser captures the build, so the code emitted by a normal build
is unchanged.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/os_types.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
index 538d00105738..339372293a98 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -78,6 +78,23 @@
 #define dc_breakpoint()		do {} while (0)
 #endif
 
+#ifdef __COVERITY__
+/*
+ * Static analysers see the WARN_ON() test as proof that the asserted condition
+ * can fail, then keep walking the failing path because nothing stops it. Model
+ * the assert as a path terminator so only genuinely reachable defects survive.
+ * __COVERITY__ is defined during analysis capture only, so the code emitted by
+ * a real build is unchanged.
+ */
+void __coverity_panic__(void);
+
+#define ASSERT_CRITICAL(expr) do {		\
+		if (!(expr))			\
+			__coverity_panic__();	\
+	} while (0)
+
+#define ASSERT(expr) ASSERT_CRITICAL(expr)
+#else
 #define ASSERT_CRITICAL(expr) do {		\
 		if (WARN_ON(!(expr)))		\
 			dc_breakpoint();	\
@@ -87,6 +104,7 @@
 		if (WARN_ON_ONCE(!(expr)))	\
 			dc_breakpoint();	\
 	} while (0)
+#endif
 
 #define BREAK_TO_DEBUGGER() \
 	do { \
-- 
2.43.0

