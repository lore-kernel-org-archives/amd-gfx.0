Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20364C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 285F210E8A4;
	Fri,  1 Dec 2023 13:29:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A234210E8A4
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDizFf0yz7r/FCNdy4ns3QXT6X+xw5Q8yik7/XhZI7ZJmLw+XhFLg6rQK7zcxXTS8i0cRsXINMTIddTf2Ido1rEi7kdq/UR4ptrWOQdl3JVMfqzsN80lHz2NZNm+YgP/ZJeCpoLeF9s6E9/+DSF4IlZf6xF8sqU5GSwoXdHf5Fcucou2FOukMZAiy7U8dC4c6+gtsnUG+KFbajyQWzTcwdWPBca7N/TU0cOclg+2jAokQQz2TunbS2dYCqzkiPOqyZ77RKf/1boQJe9o6QeJVuoJOLu6Kf49n9JcgHVkhqoz1jziYWFUvRI336rl2uXHePyGDKuI/emXquXypb47vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=920pEFKDSvj4pYkOGzZ22aENYieUQSY83memj60kzgs=;
 b=P/LLFDGS1eSY1DdV629sOldt//3yE3ye65jaQouIatrfdrzcbCRlN/QncEHaPLHUmIVPkd1Yl3MGiBo6ddPf3bdllC/ZmWX0Wcj0+Qs2g1KB3jkQIVprbbV9q5FvWi5lCaKI20k8riZQiwtixpNrfPR0XLdl0h1cTkKjK9/TqVBjdsGYPv6S8M0O4Bc/vouzVShgZ4UwJSqJreF7QBmPGrXBZtEVhAsTSxawJ7jFwB1+hwkqZ/+i4/igDcvIPj9/C7s6RB+w/faWQWnZIa22rPYyT7YcyC6DxCwaH5riDd5aRNX0yGBcx4tF5xbfXAo+A9OukDhIAXSjC1piZUJZzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=920pEFKDSvj4pYkOGzZ22aENYieUQSY83memj60kzgs=;
 b=xWuL642EXgDirpsX3qLlTmF7kqREI0N3AB6rzt3pTvikBlXI0X+f9DrjPBc4pLtU1IIMCBKz9dYDDyKwV9C+qFttnGzryzJ5IqGdMDJk/1JG5tdV6q0aLsYMgsX/idnxg9ENt0HbEhZ5jx1WW0qxrnFrW0lgz9NUHRnEZW9PTaE=
Received: from CH2PR08CA0030.namprd08.prod.outlook.com (2603:10b6:610:5a::40)
 by PH7PR12MB6492.namprd12.prod.outlook.com (2603:10b6:510:1f3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 13:29:27 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::43) by CH2PR08CA0030.outlook.office365.com
 (2603:10b6:610:5a::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.29 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:27 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:29:24 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 39/47] drm/amd/display: Fix writeback_info is not removed
Date: Fri, 1 Dec 2023 06:25:35 -0700
Message-ID: <20231201132731.2354141-40-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|PH7PR12MB6492:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cef97a9-ab52-4545-4b28-08dbf2718aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mPTszu1/l9hF91xt2ZCci9tx6BYioh/lF9jJsk7SZQ2uaUVFMQpwEgUE+HOEmVGGiuT+KgnpHjAAjJHorQ2xzOosNSXTpqo0XYMhh2yE4sy/SsCVdh2aSaHG8NdxV35UVcqFDcIqZ3Kr2K0xuaZBjR36kTVwfyNYVLsVjrn1raIyUtUwZzAbRFenYfWZFj8jt0vjB/2/4U6ftrYScncJfmzYo1sboTGLOAqCHV1u+Rg1JuQ6RrlMAK3PML4VhSiKp5bdGEkAWwIvMxjBV4XKCD6oAwf35BuflqzMzag6TipoFRxjQi6M58Y493rXPSVv5sIuPP/M5nuuSvjJ4MGZTfmzCDNCAgvei85no7hjVtnLySThFiu6EfwlqS0fJnjRrCeZ+VaxMMVxiJubLPvM5az+zv5zrHgv713FwzULybwsiONphSrVp9UziR58GCsERJK+H/OesL841LyFXeloRdUpUIYHgFcibNH1TS3xlm5EcG5quBKGQgHFTHn5NoJVCGkaRWoH0PFVb5mjza7dygqjSJtuCt/KLbLhZB7dwkqcVDZeOpiyIAkcG59PtOeRQezE/DddCGPXgzjsbR73A+Bg8hkxUsSXqzO/DkW7sJ5NceVzzJUN+8/ENdkqcjTdI7bpZSjKTvfeEkf8x9vp4Lr06ypXMP/DbHKLL9zxUiZh8N9kpLkTaZLoUMYLvBcZPaNpVjriGjNafId7SWn5cRsnspsIailqZHkx0jP8awiGkgnahPckHxuSK3Pv/wCaEOP/IGyyhG9WOKuUjE4fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799012)(46966006)(36840700001)(40470700004)(81166007)(40460700003)(36860700001)(82740400003)(47076005)(356005)(41300700001)(83380400001)(6666004)(316002)(2616005)(70586007)(70206006)(478600001)(6916009)(2906002)(54906003)(5660300002)(426003)(336012)(36756003)(4326008)(26005)(16526019)(86362001)(8676002)(8936002)(1076003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:27.3565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cef97a9-ab52-4545-4b28-08dbf2718aa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6492
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[WHY]
Counter j was not updated to present the num of writeback_info when
writeback pipes are removed.

[HOW]
update j (num of writeback info) under the correct condition.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 8e7bc4a30f27..3dd9f4ab2261 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -516,11 +516,12 @@ bool dc_stream_remove_writeback(struct dc *dc,
 			if (stream->writeback_info[i].dwb_pipe_inst == dwb_pipe_inst)
 				stream->writeback_info[i].wb_enabled = false;
 
-			if (j < i)
-				/* trim the array */
+			/* trim the array */
+			if (j < i) {
 				memcpy(&stream->writeback_info[j], &stream->writeback_info[i],
 						sizeof(struct dc_writeback_info));
-			j++;
+				j++;
+			}
 		}
 	}
 	stream->num_wb_info = j;
-- 
2.42.0

