Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C1ACD3424
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A64310ECE7;
	Wed,  6 May 2026 07:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LbnNUZ64";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70BBB10ECE7
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSoVcdY+O1NtRXJQOGazUwIcyJOLutif9T7B5df8tj5Fd1xgtJB4VBHfwBq3P6+H4WhI3HS+TtVcvNoXwaeJqFDScqTq5SLBSu6n7uWXliQAZg9yMmbxXhIdYEjW8EaNeMzPsqQBwkA1ZaGF3u3JZCcalEfD77IyQYLNin48MZhl1M85Q4IT+hLixT9hoKiufLccaOYtEOSe5XKqcZrCPh0Fuuk2iOXllXo+KxJZu1ESq+yx83wupMacR5QIv7bWp/tMroWRa/GLY6ErCf9MAcOtDwZ84pS75aZW5Yks5/vFI4+B1cYgu7KaKWkmqXHWEs1TC8JmxdgNlzY5rCy2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9iAZmFtRxZYxjmEn3gaxqiflhoNQLgPYgtE1EfC6HI=;
 b=AqWgGjVcrlF52mrDjeDua+vo82qZ/Wm56gGyGNk7O1gDVSj1U9N6UD3YIvc0AjxnkMaJPhofR+KFw6PTBp5MiphipwRumGBRrS/Ivnhe91yVlru+E9byI2uMtPU1bLsOVeHzXDwxyrE9kl7Wh5QJGjhIIYko/sCD7S841MqV6lffsOBDfLbgEb0gFD+ZnUucnpf4NwGShBR60z5JRArfZDI0nnegn5iDeDHh9qxnU9lj59EbJZbHG2qYuFNYzun/xX8ez0QryBPzxCuO7QwWlJpVPDyRJlU9iZNTnuIkZ28UyhfBvuGoYwSdpec6poef6gPDR9wYUqwDjrrqdV/yKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9iAZmFtRxZYxjmEn3gaxqiflhoNQLgPYgtE1EfC6HI=;
 b=LbnNUZ64vdi4g1IsUAmL/2Y1kDMmL82d6hhlscQA42d7ccL+Y5b7bDobhr1ln+IdGV9/2MhxfNceFbtOQBP5FYMsTlVJ4uSF3hfofIAsVo+QrWLl/s9uH41L5t18AMJWwIFs4Y9dZ1USc5Y02cZD+IsSwmpHh9j1lYBep8utR6o=
Received: from BLAPR03CA0015.namprd03.prod.outlook.com (2603:10b6:208:32b::20)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 07:06:02 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::d3) by BLAPR03CA0015.outlook.office365.com
 (2603:10b6:208:32b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Wed,
 6 May 2026 07:06:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:06:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 6 May
 2026 02:05:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 May
 2026 02:05:59 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Wed, 6 May 2026 02:05:50 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 James Lin <pinglei.lin@amd.com>
Subject: [PATCH 18/20] drm/amd/display: Wrap DCN32 phantom-plane allocation in
 DC_RUN_WITH_PREEMPTION_ENABLED
Date: Wed, 6 May 2026 12:31:16 +0800
Message-ID: <20260506043342.2164710-19-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506043342.2164710-1-PingLei.Lin@amd.com>
References: <20260506043342.2164710-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: PingLei.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|BY5PR12MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: e06d16f7-8171-48bf-7afa-08deab3deec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|22082099003|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: VWFFnv6ch02XXruXteCefaFm5yv88h31qQETYOF4PvU3V18qQwTqvhkKVcQVdoMltrrYcSqPM8j11jC/tcGbdLPXt/WxLyv0b3+71JRMOivgk+awt3RZ0IP70S7GLqhP8bt0CDnsG0S4MEbDGiMYl1CzoYX3tYeMIRQU5x8Ie93drcqRSJGcyza9sLRqldLwkhO92r2KTV5KoneKYQVFeNLeJIH8IACAN1+67hKkCX/bRrjVgxScuQnCxoVbZI8VgpP+uGv3v15HZS/arZ11K7J2VhftUj2VydebObtPc6gIA4qWr3/9KuBiwza3rVC9k5DWq7P/cMRY7zAuK8tVA3pIZnEf4BeR5FevJovlOI99yKp+JKmd6qOhE8Rd5tGlQzJ89C5umrih7PXWA1qAIyEGMUlsfRSm30wdOvVcpoUTeSh+KJKnbTVB3a2J1rCfJVLZHQzPhRRXxQ2Y3vrrWa8rkXcXnQZVka3UjHsNs6uJUYFGdDFqLjiVjDC5cj32RcXdu4DDFY7wGcwKSsPGeUPYtA9EgUjFoe+DD1+o/iMdZVi8Aupx4mNyMsbJJ9FxLGjUgUhJCf0Ntg3NEvq3HxXDPeDevYln2xyiodchmXIty5sJKwt+IGnaEbzgS5j3ecA7KNxsecTj2XsZHbCHHYgChQNBzmjCcevRT3GgNbqBNDKHLwbupOIoxttC8n9j
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(56012099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: win91I0e7za7CgqpmgnOZutOYX+Tuq3fS2FvYT9DDBWW0VHzqku+pr8jhg6sdrh+yjC9u6FdulYiL9ozXFg2vWRN0BeXEwMP/ot7K/gOJZdlte8DL1LXtpy50uhk31WnuQ6gO14Rhbn/GQZq9J0XV47u3ACrZCFlFWRLH8Kw4QwEv4tDW0WsrtUawccPippLo1iBVZr66EqojV2zkHAi46Rd1BFgKEuE83O+bSjGmeVvACiw+4nHm8SPzNA3HfuPIr8qicT+u6/sSwtcaKqB98Qy9na7g1viF/kqAkD/OZFVl242wsVoTq0QnIJIXGY/fh15VAGDPpIBesAspeZC/KZrDwns7QxBi0PiVVL9DG0q3fkQT0i0oRq88lDafpCBj4irLtAmlRqf+7X5oeugW2eCCnou2rXuGivLwG77qkhzG+UyTEidaTHo9tF9ie4+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:06:02.0037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e06d16f7-8171-48bf-7afa-08deab3deec4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
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

From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

[Why]
dcn32_validate_bandwidth() wraps dcn32_internal_validate_bw() with
DC_FP_START()/DC_FP_END(). In x86 non-RT, DC_FP_START takes fpregs_lock(),
which disables local softirqs.

The DML1 path through dcn32_enable_phantom_plane() calls kvzalloc() to
allocate ~335 KiB for dc_plane_state. This triggers the vmalloc path,
which calls BUG_ON(in_interrupt()) because it's invoked within the
FPU-enabled (softirq disabled) region, leading to a kernel crash.

[How]
Wrap the dc_state_create_phantom_plane() call with the
DC_RUN_WITH_PREEMPTION_ENABLED() macro to allow preemption during
this memory allocation.

Fixes: 235c67634230 ("drm/amd/display: add DCN32/321 specific files for Display Core")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4470
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 28d21dd30106..1bdb4ffd2921 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -92,9 +92,14 @@
 #include "dml/dcn32/dcn32_fpu.h"
 
 #include "dc_state_priv.h"
+#include "dc_fpu.h"
 
 #include "dml2_0/dml2_wrapper.h"
 
+#if !defined(DC_RUN_WITH_PREEMPTION_ENABLED)
+#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
+#endif
+
 #define DC_LOGGER_INIT(logger)
 
 enum dcn32_clk_src_array_id {
@@ -1688,7 +1693,8 @@ static void dcn32_enable_phantom_plane(struct dc *dc,
 		if (curr_pipe->top_pipe && curr_pipe->top_pipe->plane_state == curr_pipe->plane_state)
 			phantom_plane = prev_phantom_plane;
 		else
-			phantom_plane = dc_state_create_phantom_plane(dc, context, curr_pipe->plane_state);
+			DC_RUN_WITH_PREEMPTION_ENABLED(phantom_plane =
+				dc_state_create_phantom_plane(dc, context, curr_pipe->plane_state));
 
 		if (!phantom_plane)
 			continue;
-- 
2.43.0

