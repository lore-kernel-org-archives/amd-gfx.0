Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED76AC46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E3C910E623;
	Tue, 10 Jan 2023 16:58:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F06D110E61D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHAQ8MS5A1Mios8NoBozjrD4q2PMo/7uPlYTapptMmbrFxMaVxOjrYZqfUDmBJAZ7K5NwE0r1bG55cbZMTT+hUZ9wWP7DuTh0tCDocmf2IXuaBfgIxth5eOR4SfdjoO/FLyVwTV7610I0WPduPmY0jGKtvqbf7nOffG/aTL8pMTkpLgXP3/OuU2wnOnYJ3ydqVDk08QzPWE+LSiMkW1lIrZSbfB2vnHMSVZh25KuAugvMd1r7Pg2mbPHIWbMY4C3qfJE/dDOCGH2xH0hws1uX+i/rRRP6wCuDj6GdKfjsFmiGmU5DPktro7M/D5TR2b6Cy3A072vFMuAbMIfC3cURQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbBWpHN+Kb3zDLa5KJBk5TOmjVgRE3n08GwPQjDo/wE=;
 b=RxUrlZ9ZxSvblv9DdrQqdpRHSt8qAli185T8Kx0up6lMPOgUgnNYR7mByHDopIdIenHCH5kXWcC9mcH8LelPQyKxk9OZAL1cYdsMTaHi2vbLSVSjqINSeKRLbhtnyMYNX2s7+ifd1gDap/0EEQFJKi9z/dDOvnc+3GDv7ui7OM2wZSichVQTniKJOufgSXX8tFt6ajE1r677B2kLn4Q/7hzd6HvBH/IXXlngP0SiA9KJAztTyxSwk4+SgBylYzH8tlMfGN5/G5uGoZGqAFPzBoWGQEiJsKvaPAZumdupp/eLaORkg5yXpbvA8Y5+lew99bUKyeReZdiG50JcxVQZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbBWpHN+Kb3zDLa5KJBk5TOmjVgRE3n08GwPQjDo/wE=;
 b=QhQuiabLyMk/DTt3yzEUlVvp5dAI7gOchWdJv+wibe+MP2xNtyJGXdbej5xv+YN2N68Z0dD9bzQXtVnKWPqhY6+MYBpmr/HNoJzF2CkMtFV90xi/Un9LdZzvoiuvOTIWILkx2cmidgDhvv4i0QfCiqZ/pzqCD+jDSr4lPD5ChZM=
Received: from MW4PR03CA0023.namprd03.prod.outlook.com (2603:10b6:303:8f::28)
 by BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:58:52 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::a) by MW4PR03CA0023.outlook.office365.com
 (2603:10b6:303:8f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.12 via Frontend Transport; Tue, 10 Jan 2023 16:58:52 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:58:31 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/37] drm/amd/display: contional remove disable dig_fifo when
 blank
Date: Tue, 10 Jan 2023 11:55:27 -0500
Message-ID: <20230110165535.3358492-30-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fdec0f8-c892-41f2-c349-08daf32bf3e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qxk8V7La4pkyLPek1a6pwy0mwG1JRg31Vv+YQui2eDVT32xpMJMP7WsO+kcrjZArFeMk3jPyIwYpqaEFJSm3vAjeCO5HT0ZJYmL0hiZaQ05JKUpTYfBRaLzSsOLQ6YOMW3QMjM/U6Zwtcos7uuK2gzMsED+VtoWekYbzchLRmhAqyQGwdpUFAU+VI3BIyEdTapt2l8nRdBYhBCbHuIMQwTlNoU1U8q1id3rwdym7eXbMfzh3Y+htNMX7cSLxTqNK2h3JJgWWj0gsuEIbhPR3s9XNKAcosjqgu/wqjjqnBj3TeDbHcVzrmP/1TeLdjgVZdUVAmVV2lO/S1uKMHsdPzX+ORUpQmmj2ZJaJbupG8JBRMx+X5XohF86OjsFjJNTk7aCtSnOSXTRK/fb67VYxJQLb5aLhWvUBmW1k/GrpPV2idiupJoUNg0CNLrlEuM3arV61o4lPbEabDw7jjzcFy0/XefVisS2GiFpt25UsJQFhlFl6kbmDWNudt8s5DrnDVmVnGZ123cV8Q656aWXEU1rqm4eQA3+0xfnKplpvPcZ4sqd0mdGmbL4+8L25RTKoUv6MZrq3y51vBY5qtk9IJ/l2nqsw2582iafbuB5FToFhZiNg0x6jlfWUw9gWaR7iY+efIDNVF26leZm+9Y1CWnvhlkMf0z2YlxQEambyy3EhTxtUfom2KMXufsjWLVSpJ74VhUgZIECqAeUthZfGi6Bpaif2dV5RLvuVee+VS0c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(47076005)(6666004)(478600001)(40480700001)(2616005)(1076003)(4326008)(26005)(336012)(186003)(70206006)(316002)(8676002)(6916009)(70586007)(16526019)(54906003)(7696005)(36860700001)(40460700003)(86362001)(82740400003)(356005)(81166007)(426003)(83380400001)(82310400005)(41300700001)(5660300002)(36756003)(2906002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:58:52.5520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdec0f8-c892-41f2-c349-08daf32bf3e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

keep dig_fifo enable for test pattern generation.

Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                            | 1 +
 .../gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c  | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 72963617553e..53f449fa2b71 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -873,6 +873,7 @@ struct dc_debug_options {
 	unsigned int dsc_delay_factor_wa_x1000;
 	unsigned int min_prefetch_in_strobe_ns;
 	bool disable_unbounded_requesting;
+	bool dig_fifo_off_in_blank;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
index 9c9875368bea..67f4589f3e23 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
@@ -281,7 +281,8 @@ static void enc314_stream_encoder_dp_blank(
 	enc1_stream_encoder_dp_blank(link, enc);
 
 	/* Disable FIFO after the DP vid stream is disabled to avoid corruption. */
-	enc314_disable_fifo(enc);
+	if (enc->ctx->dc->debug.dig_fifo_off_in_blank)
+		enc314_disable_fifo(enc);
 }
 
 static void enc314_stream_encoder_dp_unblank(
-- 
2.39.0

