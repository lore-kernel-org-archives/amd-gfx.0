Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3765C5AC80
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Aug 2026 03:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D624510E4AB;
	Sat,  8 Aug 2026 03:30:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DAnZuRlj";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012054.outbound.protection.outlook.com
 [40.93.195.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15ADA10E36F
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Aug 2026 03:30:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9CCY6BLbP9KOPNYPUd4wQ+o3ERgqIw8g0CjwaRG6NIxccPYtUpxHyklpLewDLX6qjzCctbjnScp14e60/rBIuono0kCp1tfPgRFgi+YCmIB7RECdSvcbz8vvU4S1NU+3AVzCPObxjuM/eaK8hbJIhlu0Px3aDXzLRGtF/ZwB1Mt8Zz5/YKRbd2jm5iD8kSQ0fI9/Iony+8gdMlRvsp1kY6LcDf9ING3eoWtmgjUetWwX6w2eG7RqNE4RR0qJEYpyvUM0Iqq6YWf5nAZF/YsgHagYV7S+kcjCYmzZyN84YDJuHZvgzjN+x6f+zhM4qsYaXjWQhj6gN2ayZgBqUe0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwCTbpyv6WcnS0TjV9gYnK5hGLmlJt8RHO5RGhwIQFI=;
 b=oyBvz0uhr+m9WLoeByjcaWC1OBMBzY3TBv6ITAbrxo2ZfjTndk75Qej9KNbEO0DYO6Ajq6XaohwAvOjjGt7jGGaESWqdM0qXJ8UdvuLZGJNJCwdOkKXtmLc7SxEYDSRv31y6+9vzilx5ZhzVTh0Yv8iUseH2b1Jgpto14PI8E33ZrB4GiRTFRaNnW5wuqHCa5N73wTH1dTKT8ceYWc7FcMAq29TfY9MElyc+dW2YD/mDNqnEdewcQFsjdttoXQVdM5GPtpqtz84qVNqvXWTuWZj+VviktAoSZWUsHdtwdLRlHn38dpM6xOw4/SsknFfCQbQilUQoso5U7rfri1YwRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwCTbpyv6WcnS0TjV9gYnK5hGLmlJt8RHO5RGhwIQFI=;
 b=DAnZuRljGLh3A3khH6PUReOT/1ZttZo+edTIs48btcWDDbBs8BDKPOsKMuv89x377xm2XTYiQSEuwi7uKj9+8tsOA9qN6fRx+Bwf+PeHoscchcLmo/HYeWtf7Aon5VnK6A0AGMuFyUIRiw+D65H9tWv0732O3xKL7gRiu4rdH+c=
Received: from MW4PR02CA0007.namprd02.prod.outlook.com (2603:10b6:303:16d::33)
 by SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Sat, 8 Aug
 2026 03:30:04 +0000
Received: from CO1PEPF00012E7D.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::15) by MW4PR02CA0007.outlook.office365.com
 (2603:10b6:303:16d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Sat, 8
 Aug 2026 03:30:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7D.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Sat, 8 Aug 2026 03:30:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 22:30:03 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 22:30:02 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
CC: Harry Wentland <harry.wentland@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH] drm/amd/display: Relax frame size limit for dcn5/6 DML core
 funcs files
Date: Fri, 7 Aug 2026 23:29:58 -0400
Message-ID: <20260808032958.385566-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7D:EE_|SA1PR12MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: 88450da7-8504-4cb2-cac6-08def4fd561a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 8HCT96wfFBLJmEShMr8DFFsoATr+Ml78N7IKPf9QIvPhlP6OkEvxHTVqVx42bjrDpipzjQWTTfG3J/bJMHmS/i6Ih6Awi/jxGeftKID+G1rVpW/aDA9siodAsDI8zrJrx5qsspqBaMV6q6Y3NQxeSwjYGUN593U0lVB3ye9+t+HK3mnts9m9jhvuX2qP2FS/y/K+ziSyvg0n4HsT1vt2U2Y0Rf1gxLVpSLyDCOT9GemoBAeel6aliK5CMXJUgwljqUxLOjPmNLeLAIUKWrfWSM8Pi2rvoJVfmHp5KcvqzaiKD+II145kfQi35jJq38kbB3oT1+bUL/9hwrNZ41XxkPob+QFlFNTJ8DqesSv99NzIXVpt4LJlpV/WQD7nYM3+9c0XuX09Raif60ApqQW19ze6DIvAoWGgNqjTCrtqZD0kpB/jPblCXY/tsWFS93RWeeKdKDlAwg6VoqvkdZIWM35Os+XmfIb/juB2xGt41u9/Bg4lj+CxZKM3e+S87gu07r+RNN9ataBgn7kkE94tYQAa/x2Ev3kFfI1mkQPHz9lrWmnsYXCXbz8O+lvF8YKWuf0ZFn8jl+uKzj2ejAop13NbcbASV/Sm77aeqSnTi8i87cU6UfAT4lthlTh/WtPllQFomXxuICl+xZDqZzzF7s0Kj5jfo1mQpNcZW+P/++oE/1njRO9JJbz0xXL9o3Jj7wXYiOW2fEGXycZjNGHDIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: efFy3HUiOtocbraE86K3Q0scJOewGP9CGnCZngenV1NAX6fT78c/S9YLDSKEte9RdrJBQshdR9wIcceZyivx8VVz6iJsViygpF3KUm6Q96dBNnN2MIN4bu3P8yJ30xdLPHnDL8zHDZfVLvbq8sk6EyyOqieh7bR5HAnIZ9PQhYkLbZTMeYsv9KqQ0dl+ZwU2dqQOBId+4nbnmkn/vGNxAOU4jVAi8soHmK66L7Vt/MJKV9W1+w4YRsCO1ZRqO8oYdHGR5rUR/GBNxZLhY2h2gt1/5WIYJDyxA7T2Lqv+i1+1ODayTqaOGjGY0CJQtNHMgDTGpCO16NHVk0NOaB8tnmzfFTusr2gqvpohguRkeQ9/UMbvlngz0eXDU2DRzfoVlR0YdpeMGjba0rzBwwcpWxgE0OxNcs92QzPicaqOQ8Y0sJg9vGV2zdwkCOk9UNn7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 03:30:04.0383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88450da7-8504-4cb2-cac6-08def4fd561a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why]
During compilation with  allmodconfig with KASAN, there appears a Werror:

  dml2_core_dcn5_funcs_mode_programming.c:11:13: error: stack frame size
  (2400) exceeds limit (2048) in 'dcn5_mode_programming'
  [-Werror,-Wframe-larger-than]

The dcn5/dcn6 dml2_core_*_funcs_mode_{programming,support} files were
split out of dml2_core_dcn4_calcs.o, which carries a relaxed
-Wframe-larger-than limit via $(frame_warn_flag) (2056 normally, or
4096 for clang + KASAN/KCSAN + COMPILE_TEST). The split-out files were
never added to the per-file CFLAGS override list, so they inherited the
strict global default of 2048. This is why these files trip the frame
size warning under KASAN while the larger dml2_core_dcn4_calcs.o does
not.

[How]
Apply the same $(frame_warn_flag) and CFLAGS_REMOVE handling used for
dml2_core_dcn4_calcs.o to the split-out files:
 - dml2_core_dcn5_funcs_mode_programming.o
 - dml2_core_dcn5_funcs_mode_support.o
 - dml2_core_dcn6_funcs_mode_programming.o
 - dml2_core_dcn6_funcs_mode_support.o

Fixes: 7f7d7ea1fa51 ("drm/amd/display: Add new sources for DCN6")

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index 35d697872a9a..5388bf094fbc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -75,11 +75,19 @@ $(foreach obj,$(DML2_RELATIVE_O_FILES),$(eval CFLAGS_REMOVE_$(AMDDALPATH)/$(obj)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/display_mode_core.o := $(dml2_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.o := $(dml2_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.o := $(dml2_ccflags) $(frame_warn_flag)
+CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_programming.o := $(dml2_ccflags) $(frame_warn_flag)
+CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.o := $(dml2_ccflags) $(frame_warn_flag)
+CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.o := $(dml2_ccflags) $(frame_warn_flag)
+CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.o := $(dml2_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml2_wrapper.o := $(dml2_rcflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_wrapper.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/display_mode_core.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.o := $(dml2_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_programming.o := $(dml2_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.o := $(dml2_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.o := $(dml2_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_wrapper.o := $(dml2_ccflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_wrapper.o := $(dml2_ccflags)
 
-- 
2.43.0

