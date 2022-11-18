Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BFAC43217
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 16:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23F7910E789;
	Fri, 18 Nov 2022 16:59:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31F8910E786
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 16:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjTDssaMpXu1YK6LXUfMqq0wFRh9BweqMjDhud8KswVmtnF99hrVCURs+G1nB9nEqO2peVFtfevp8SVjXV3b3omGBacgA4/oM64sPPfnjlGc2k9TKsZJGzemYOVW4txLACH3S/XWAp0rrEPMPE4/RpvnPYUKqYzHYqe2XNyr19J7SqwS70n9xrTQn5mIapI9RPbwhOTHrYwnqJfMwmp+0q78TXZOuElFQq+XDvxS7/+Roty7XmrnmXXUXPbQVJxQwPTo21jycdegSjOs5MbFSElnMTsQZaq47OUXDeJXnJ9t5IjCFxowVxLPsUqCymxa8oadLQnJJTMA7yYDXP1IKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRqy6X4Y8MZWVJX8HwYx3AgbNNWZr9hYytJSwsRphmc=;
 b=ArTcizKWyC1g4SX1BYP92XtuTVIh8gIJEjuosfdUgvsmq1yjyUVf7OYCqeAe+PbWRLYnjG51Un88rhyPEL0L6J9Bsa1a3VkjZ8MbsgazFfw6BNcPsapKteeRg7oO6y9nemSYJRgqslbo2EeT7aiT8jk7E0OjUohOc5a5Sl0GZliMyYn0MrmLA0ST4NpbHIELTsRNRt+sJWuEaMKWa5YC50bOB61GU9poZOAYSkhhyjXdfMNg72yg9D+Ir9R5ioMkS5KSRMnaraNUw70ZrcJQSoK+AyUW70KTHxoAM7fkSGNxOjff1cbwVoYtkzZP+AJWhvLajee9ZT92a4yfypO6dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRqy6X4Y8MZWVJX8HwYx3AgbNNWZr9hYytJSwsRphmc=;
 b=y+vFc9XTzFPRDPrMeA3ntXiXrMb7YLpTlIplDUNqXQfCj2FsqwVeDCabJ/e0Pa6zq5GGaGBiFyMElADa2dILwrVqeEeRO0GBrZNwOntllXHHQLiRlf9E37VSYK4TrDQzKWIRQvEjdnJJdi5izzwDPhwSRoWaVodTv/CijnS97gU=
Received: from MW4PR03CA0149.namprd03.prod.outlook.com (2603:10b6:303:8c::34)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 16:59:40 +0000
Received: from CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::89) by MW4PR03CA0149.outlook.office365.com
 (2603:10b6:303:8c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Fri, 18 Nov 2022 16:59:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT096.mail.protection.outlook.com (10.13.175.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 16:59:40 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 10:59:39 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 08:59:39 -0800
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 10:59:35
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/22] drm/amd/display: Update Z8 watermarks for DCN314
Date: Fri, 18 Nov 2022 20:59:18 +0800
Message-ID: <20221118125935.4013669-6-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT096:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: f23cd47a-8f53-4d43-df50-08dac986487b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OIspvbgLXJf7nt+PR1cctgXyz/R8dUKJjVMZuGDw+TKZ9t0kin1/gywKFoFGU69RxDLxno+ruL+sZ3CGV4GmNTFlbsJ9pXuMwlVqPxlPMG2uCAfW+jhhpuLL0vk8Kx+QVEu5Mic8XZEi3ux0//Lb9S2PZBwvdOqhg2r47wZIPv9Uu/v9c2noeBuzp5y/wqSAeNlaXi5lnpXNz+8dR3Da+SySVh59a6aHwEmBb1YUQV9xlQoDFm+VlDyYqXQOFIkLVlubKnI5v61U+PuWiss19+UlqwGwq7jowbnI0NqOJWSn9Znf78DxjFj8nZz5hFi0BW85Qp6XyVP6H5J7m7CIGRMDbSNLmcs4sc9ex16B1xiXqK5DegDVKdVA0S1zETJ1DiMCQGR18Oo8d2WRo/gSLFlTkGSgSSHyYGTM8Y1Pws2FoSc/P7FqUCAlcLhiYVjm8iIlB5XqyTKakixMZ8gI0EivoXxPbAlg7MnWHZH2dG+iTl1r+S/ZUDcgIX8xTiIHVK2ummYV+n9ZW2DyQ4KihMclGfFbzNBHuqlJfbIrB3RHJfbnePkwfN2YTCL9KJKl5cR4Fw6m14Z3QDPLfuipgOj1DBk+IYrCDuPLjd8nJmC7h0+6CXmhXsKFREcTmpwvu0tvD8ACaGVdfVv2RAfirlFDA53JkhTBphXUkIJUa/lE+l7UVmKtSuOqkClBeLqwVHOQ/D/EDhPIs/rieyswTv6tTck7S3I+IyqRqUTxtjE1lsSAxEUjTA0n7ivquyCSwpAnIZKxPoCVqAuTqyLbRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(478600001)(6666004)(26005)(70206006)(4326008)(8936002)(36756003)(8676002)(70586007)(2616005)(5660300002)(1076003)(186003)(336012)(7696005)(6916009)(40460700003)(316002)(54906003)(83380400001)(2906002)(86362001)(82740400003)(15650500001)(40480700001)(426003)(47076005)(36860700001)(82310400005)(41300700001)(81166007)(356005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 16:59:40.3662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f23cd47a-8f53-4d43-df50-08dac986487b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why & How]
Update from HW, need to lower watermarks for enter/enter+exit latency.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 1dd51c4b6804..6a1cf6adea77 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -149,8 +149,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_14_soc = {
 	.num_states = 5,
 	.sr_exit_time_us = 16.5,
 	.sr_enter_plus_exit_time_us = 18.5,
-	.sr_exit_z8_time_us = 442.0,
-	.sr_enter_plus_exit_z8_time_us = 560.0,
+	.sr_exit_z8_time_us = 280.0,
+	.sr_enter_plus_exit_z8_time_us = 350.0,
 	.writeback_latency_us = 12.0,
 	.dram_channel_width_bytes = 4,
 	.round_trip_ping_latency_dcfclk_cycles = 106,
-- 
2.25.1

