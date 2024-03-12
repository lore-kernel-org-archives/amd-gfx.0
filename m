Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06616C54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CD95112D33;
	Tue, 12 Mar 2024 09:24:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GAiZBcju";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4DB4112D33
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:24:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxThycyrQeQGYBLpeUVBecBsSxUEUof4yz5/0gawrKCQVB6md07qhJvHCa3muzuzSxmmNiy/aC0T6gBh3qN9IybdRjHhtWrnQcQfwNj03BiGwWlqiOyrQeJ5a3Dxv0ikTgjeNF2ZBIYCiEXiiX6yEF0H0FqeXch1mD4tmRAL4g9wRBaZuIerMDGgmbmIs7+Ae3wnFFrLHFaOlWhNn3+mEm6bUFyTdc52XPpbv2BYytU2rxEfStxWNTQtU/WK36sdsRbOXI6NPWaOhbG7GOOL8RLjpXTX5suVBfIxjg4ZDtpCT3bx98F35qojbtgvaLesk1vaRaAI18EADVpRStJY4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t59ilhHkhPnvMKAqkKRZO5ttAfs8UhwW4z4ByuZpAfg=;
 b=f6LWj70AhMhuIEdPHlRkXW3DSyvdSiFIHGog6L+NVo9ny23uNhFwG7CdvNs7R/Ga7X/Brlxbchm1bE2yQmEZf/YKA3G1tnZXoEKZf4ysyr9txOeV00rT8DMjVX5CfahxfjR63Vqtrog7y5QtHwyefgINVhgjy6aSmuB3/B4zIcqt40OFw6ndP6NQKFgjEbl9KzzdkIbrgC5ITNXKMn0K5UqRBFhPaZ8HcGifNj7UkfMWTKLBX4Fm8dtxdqWYDS0UmAKCyNNrEsMjpsaarqVl5rAGKBw3p8fIgrI5ejZIm+Vqp2m/rpyFT1MI1uRc9Hkz7BKzX33QmepHtCvduooAVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t59ilhHkhPnvMKAqkKRZO5ttAfs8UhwW4z4ByuZpAfg=;
 b=GAiZBcjuBQV1o9VWLt2/lV+ho5M+nItyiXe0USJ33DlFkoVPcoKb25uKt3AoilR4yjT6zmG8f0WUcBtolEwecCPd/2wvceLCVWhdPxpZCjM63Js7yaGeh81DTFmTDfl7jbRC3sQiit3Fc15zE/zGIEU8Zb+KDoo+uMEhECLKkl0=
Received: from CY8P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::21)
 by CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 09:24:13 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:47:cafe::e1) by CY8P220CA0026.outlook.office365.com
 (2603:10b6:930:47::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Tue, 12 Mar 2024 09:24:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:24:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:24:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:24:11 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:24:07 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Natanel Roizenman
 <natanel.roizenman@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 32/43] drm/amd/display: Increase Z8 watermark times.
Date: Tue, 12 Mar 2024 17:20:25 +0800
Message-ID: <20240312092036.3283319-33-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: ea9ceaa7-d2e6-498f-11ee-08dc42762e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hTu8ugFQUbdo7APbey1xPgkIj33FE7eAzBWdB7SyJrQ9hoLlwx6k8vgSkxauYkuZ7hvN0DZsJI9kDI5/u2V5MO6h99wiGp5foe6px+2Br916WgMxhfnXnEYcA9RWkpshm992SirlV3bmhrDTPjl/zPB9W+xLysbVvO9Ku/5dw6/ms/1tlMlDmeuuEKj0onzyIIMCYd5jpLzslIBe/CenX6UPX5AMZlb8uN2xI7/fI/dv1WI97Auxs/Vkfkd/kJFKtkjQpKWQFix7uHnTbpAHCCXbXGfOGf1ssLpzwxXLTJ5Jfk6z6bCiyW+ihedjXuGZVrUQGAS713EZjzhLtS0nnpgxNT6wGwFLBeE6e/IARb/XxAsHKsMX9Nqk918dRk5iUZwuaE9+HyJbBsmRAvblHscOAejpLzOShTVHSHvHdK8bq7N0mSumC3Mn/JaZBRVP2OWLZzbBCOcpQm+Kg9YXmkLcVIG6JocHNzCpiX+MIPcCKM1mrVgqztf6h+lKwqTgUa8GLumfKABMtzN5f9kvPenV7KCo/1h8ZIdVgfCZLYgPn/cl1ADLgmFEcVXCH4ptGjDh9/qe4mBDVZPqG6mUL6vEmRTMtrTCbKmiU83oBllw2f4B/m88nrSjVK//tQVI1qIE2DWtpE1OPxM7dqnUOxT7R5BLoQila2F8JolJ6Gv/95insga/Aew103gLcIpm/3NLDir2DvFJtLM+LohgFesriH5vDPXM0SKyUqIvTgvqdWgyICx9DDHe2BPI+m2f
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:24:13.0427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9ceaa7-d2e6-498f-11ee-08dc42762e62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754
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

From: Natanel Roizenman <natanel.roizenman@amd.com>

Increase Z8 watermark times from 210->250us and 320->350us.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Natanel Roizenman <natanel.roizenman@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c   | 4 ++--
 drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 9ac3bc6643c3..33ea89f20449 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -166,8 +166,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
 	.num_states = 5,
 	.sr_exit_time_us = 28.0,
 	.sr_enter_plus_exit_time_us = 30.0,
-	.sr_exit_z8_time_us = 210.0,
-	.sr_enter_plus_exit_z8_time_us = 320.0,
+	.sr_exit_z8_time_us = 250.0,
+	.sr_enter_plus_exit_z8_time_us = 350.0,
 	.fclk_change_latency_us = 24.0,
 	.usr_retraining_latency_us = 2,
 	.writeback_latency_us = 12.0,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
index dc9e1b758ed6..7bd67f6b1595 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
@@ -145,8 +145,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_51_soc = {
 	.num_states = 5,
 	.sr_exit_time_us = 28.0,
 	.sr_enter_plus_exit_time_us = 30.0,
-	.sr_exit_z8_time_us = 210.0,
-	.sr_enter_plus_exit_z8_time_us = 320.0,
+	.sr_exit_z8_time_us = 250.0,
+	.sr_enter_plus_exit_z8_time_us = 350.0,
 	.fclk_change_latency_us = 24.0,
 	.usr_retraining_latency_us = 2,
 	.writeback_latency_us = 12.0,
-- 
2.37.3

