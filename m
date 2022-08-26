Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0A0ECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C782C10EB68;
	Sat, 27 Aug 2022 02:51:19 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 662D410EB62
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:51:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCI9X++WRX+IOU3i4H85fsxneCNoVUpZQteUCMmiwg8eLT2H/9au2BPMk4YfeSCLJnEYQDf7pnyho8gt4hj0751vyOvoVghQszushWRTQy1fF8l5dRli1Y3X63swUJrL/LotgXBt9L7B3BtBqOkqOKRAoB+rjAp18A3RStujcL499hkPGg9kwACG1Ohw/XfX/y17pmX+aAGTSxPaCa80OyR+3MGw0u35gv9ufo+u6Asl2HoAErcMo731OmKuzLgQi3Ih6LoZ3IbpNdmD9C24u+lxUnZs42fdXFqrKf/jS6PzKUkeRyHGwc7mS7RthbuS59SvQVisSylnrgRmVFoWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9JExdU9IkqnyqzU6bFCDGOTOKLzubNMWvE3gEplnrI=;
 b=ZL1rBO7H61P5fLsodeebeNQLNal/98UvxnrfqcO35Stj3iy2ef6/HAn8JGIPkPa4biJLinbfP6JV+w3Br7l36o/FzRnC9f8zexKPbzoFOxlcoWRfAfy56yjxijAIMxLqKAnOleVU6hU/yDbKGYfTOgWX0uVK6TFwWZpxwWKI99XErA2TNKPM6GCt1ZKHUw2oGfubBiDBojTmBMBAgkRLA6YcxAPMyM4Ztbu1w2osz7lw0ylz738OwTLlunkw7QqOqSbpkur9bLfqY1KMfM5mat9vObYPL5WZadUYPOLLR5m4oCJR5bfWYf0TH135sxHERQonqjZzgAIzQ4qbAwTlOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9JExdU9IkqnyqzU6bFCDGOTOKLzubNMWvE3gEplnrI=;
 b=S9ZdpU8KOi4VKBlRIxu8SeJn8zbLhT7WeVqLX0hYIlvUjF0Ry8hWP+qkn8BbfThkszShkjik3M2cJjcx7m+MmdGTy9Q4hO6YIhz8AYLqEagjLXeO2xtsBpR3X1UIE0xJ8UC6GR4Ol8oN1zcNMapmN0J0BEVjciNOmVGWrz2cKZU=
Received: from DM5PR08CA0032.namprd08.prod.outlook.com (2603:10b6:4:60::21) by
 CH0PR12MB5107.namprd12.prod.outlook.com (2603:10b6:610:be::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.14; Sat, 27 Aug 2022 02:51:01 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::ee) by DM5PR08CA0032.outlook.office365.com
 (2603:10b6:4:60::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 02:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:51:00 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:50:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 19:50:59 -0700
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:50:55
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/33] drm/amd/display: add a override flag as wa for some
 specific dongle
Date: Sat, 27 Aug 2022 06:50:30 +0800
Message-ID: <20220826225053.1435588-11-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 882ecbee-62c5-4b0f-a2f6-08da87d6f997
X-MS-TrafficTypeDiagnostic: CH0PR12MB5107:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wyhG+wAyCN3VhE2mygYHabRnKa26TPFDj6k5J/M4p93Yx1IFmMVT+YdJQh3s8eJE6YNKBTAOfJp06dA1/g0k83T2yNWXLhMaIalntyskH4MswOcGsGBjTbCqe5O/T66tLOMou9xvT6A3bMDtp1hlMRY5LR5VaRsazU3TYB+oylm+j0YJ1QTI/r5aR9ZT03r7vlWONjrB7Of0tKh0fE6eybjyrjipuhtU14GLMJtzArC46mfGkl/Oz4zsrUJj611MWvJvkjOi2/WWTOJmwnKAYdsNfmPIv9bCr04kqTybAArWzeHmUw5Av9KVYSCRqVQ1LL1WcnSmDpRmRc2DgGEwWYX2zZ08LoqRVCubqpVK8sCJaPiDTecWtuhJzMnELMNZSf1dwl1vjbEhXgLeqk5YDCMJOmmhtvP6Wv7V0vmm5Hkz/hbBpBJ0XgwO8yGOkNmL66A5jvOfIk+EhT/eV8/WnsEJm74e/0QR3VF9jx3okZkkBSxvirtMS8BCwpXBJVtVb6uKpMVK4OYM6Jc7yU2L+GlvRzwmtvWiPKOr7iMfzUMJhVuSfJ8YaHqdF256oHbPnNxyMvsN2gBdyPIJG9/5luqK4UyT4t3NfhWFYlntThYI3xnM37NEhghfabgdr7cz/QElid3G8czp4WMBmoDQ11PkHTF7SbdU5Du2sqXGvUm6sE7spKgHf3kWPJCXW3co0FaOL012QxbneWRXDoPEKG/OZZMvOnW9B9zlz6PKCJJu+6VEgN+iLCGYUulcabSd/rBQl6PAkZyzqRntr+RX96f+F2wkL0/F9muJdq0aSw1qRPGUjDt8RdKHjCeyUZoEmCMW8URwWTWNwK7L1uwCvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(136003)(40470700004)(36840700001)(46966006)(2906002)(8936002)(5660300002)(4744005)(86362001)(70206006)(70586007)(8676002)(54906003)(6916009)(81166007)(316002)(4326008)(82740400003)(36860700001)(356005)(40460700003)(82310400005)(40480700001)(336012)(186003)(26005)(41300700001)(426003)(47076005)(36756003)(7696005)(1076003)(2616005)(6666004)(478600001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:51:00.5468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 882ecbee-62c5-4b0f-a2f6-08da87d6f997
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5107
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>, "Chen,
 Leo" <SanChuan.Chen@amd.com>, Brian Chang <Brian.Chang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Leo Chen <sancchen@amd.com>, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Chen, Leo" <SanChuan.Chen@amd.com>

[Why & How]
Add a override flag as wa for some specific dongle

Co-authored-by: Leo Chen <sancchen@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_link.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index b18efe988830..d1214944839f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -224,6 +224,7 @@ struct dc_link {
 		bool dpia_mst_dsc_always_on;
 		/* Forced DPIA into TBT3 compatibility mode. */
 		bool dpia_forced_tbt3_mode;
+		bool dongle_mode_timing_override;
 	} wa_flags;
 	struct link_mst_stream_allocation_table mst_stream_alloc_table;
 
-- 
2.25.1

