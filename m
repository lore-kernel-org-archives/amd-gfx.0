Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B228C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A465A6D18;
	Fri,  5 Aug 2022 18:02:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42DFF8F7E0
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 18:02:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzhcjBGW2mtgYMWxY8VTOWocxb/gYwDMrdPBn/x+2dxqVL+pr3udR3CyoVkTqiwYmEBTg6o3l/emGKVz8ExkjRSH6VARAeFIM0Xlq1ksCY0QXTrly/7aoaSFVS/LL+Z+jRazt5It680b9gPuGuHx08W7apRlO1Rqx8T8J61+/tzxHB8/NkgzTvr+nJH4KmkncxDxFJZPITGWB+GrdbLLFS54P1QfVKss95RiRMiZ1PDcr2f+QoEiXKziaotozJNxe2069lDA6EZBoUJLBxTtSfR97MaS8fyUr8A9IRLhSrEout8CMM9kEU29DWPfeKTgXA7UV6VY9N+QfScOxPApTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PB6FJsLN4FXKi+FWPks3/vWUzPdZf9bRJSXEFL+A8sU=;
 b=LBKbTjRdCG/QPkfO4lfgBd+pDNlCyL+2IcULILS4S9pPEU6Gh1JuTkSLUsRBHhZ7srKw8H4ipGjE56Hf7Lk/AaVyQXAQgpBgERnetX4I6aH7t5IiVT0VL6C0xYgVtMVmXtvzLttDkNhw4GzOfzfNucFXuy2QOYM9tLOEarRBkvgfxNXvhuT3nWkat9TDtQZqxRFy4eUJR7wOMZ8Qi/Yi0P7Pe+Wcxcd2YFse9avcDHJZBNBRPuTqmRWtplysWw4E8OpDmwfkagJ8zbfIZC4hy26bLFhJmb82VmY/s7WMwBOb6NaJdLJu3uHH0G5kO4eoq/69iZUUSBOVHYTfNkfIOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PB6FJsLN4FXKi+FWPks3/vWUzPdZf9bRJSXEFL+A8sU=;
 b=AzbD5Yp5AydxSjXFmdtAJTO7WUGU9QMTf75QZChcPZsWbv2znjQ8QUu4/ZmUok2bMFaZ0rozp7OL1DKXfb3ex1CemhOG4xo+9uzn53tImxxZqzM1UuCLkSg9FrsybjFz2kyqPkN1BbVBTwctj09OuSTN8RhwzRIYo5/n0uUbuuQ=
Received: from DS7PR03CA0284.namprd03.prod.outlook.com (2603:10b6:5:3ad::19)
 by BYAPR12MB3414.namprd12.prod.outlook.com (2603:10b6:a03:aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 18:02:04 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::20) by DS7PR03CA0284.outlook.office365.com
 (2603:10b6:5:3ad::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14 via Frontend
 Transport; Fri, 5 Aug 2022 18:02:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 18:02:03 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:02:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 11:02:01 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 13:01:56 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 32/32] drm/amd/display: 3.2.197
Date: Sat, 6 Aug 2022 01:58:26 +0800
Message-ID: <20220805175826.2992171-33-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 088231f0-401b-4892-a501-08da770c9a41
X-MS-TrafficTypeDiagnostic: BYAPR12MB3414:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/k0GcRe9awq5vSMZndq3WaulFmu1ciXdKnUuHL/U5HDINyx7sLJ0XegeAzJkQZeFrFXe0UAV2pjpcdX198N0p3usGwOH2u7hGcgJg0s4zAHQGGOhXgM+4X3ATscRdofhxS7hMypc0zwfSYOFW2AY67kGKQfOGjClh312un/crCMSgyx6enHe/zeF5oBO/ChhnyBS3Dpe8EAQAYGXPYPQUieWaiELZ46s7pPbysCrS708G/S48VRSrYJ+8MZWuNMWpz4SjrZsKs9UZ1/fXWxhVGFZeKScQAedPiGyzXGbU7peiMKKhuML3XygKXMZ/fRcq0b/qbGMM/IQINhPxF+5lCHAR9KnyFVpgIdtMg+ym6e+GUQ9XlNeAaV9NCVIfHUmFbdfxFwOqL/W1n61HEkk0/Q3PsHe0iLqoRjynCgmTbCELOr1rnmWW4una3B9TjzSK6q2nigifkFSudBPHo3v7L3bbrHrSGStbnBMeoLE7HkDm1Rvn5Jiozf2Sd2hFwlkl7Dk8YWi9uwjBgTBLQeOIEaTrcPyqhRLfQCsyN2PU0mx1E7230H3WaCmwy5Pu8JJzEyQQQWM+LGCdgLD3vBxQEPrEwppgQGh7wl3eTlzPZp3zEJf5REwnB6n3Prcte/oEi535vH4vypyuQM35L4SG7F/7KCY/o0bscdg8xMsey5lGBeJiuUiphhps9VdqHTVNc58I7O4q8Yqg8D4Z3Nt7caTK5oooAKWLEi6xPxYcCiGZU2hVK0FXSDEMQ//ZHoO3qMN4QtbllMiKxk1EmjG+SXkgy3BvwirWGANQTnPzBypsqPzy/pj/6Wn2ATdI1XwNZgrjHNzgVdj8+Q1whthg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(39860400002)(40470700004)(46966006)(36840700001)(8936002)(36860700001)(2906002)(83380400001)(81166007)(356005)(82740400003)(40460700003)(70586007)(70206006)(316002)(54906003)(6916009)(8676002)(478600001)(2616005)(336012)(1076003)(426003)(186003)(47076005)(6666004)(41300700001)(5660300002)(7696005)(26005)(40480700001)(86362001)(82310400005)(36756003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 18:02:03.6715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 088231f0-401b-4892-a501-08da770c9a41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3414
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:

- Move fpu file to dml folder
- Fix CAB allocation for multiple displays
- Add a variable to update FCLK
- Fix TMDS 4K@60Hz YCbCr420 corruption issue
- Fix MPC tree infinite loop in some case
- Fix SubVP calculations
- Fix HDMI VSIF V3 blank screen issue
- Add some documentation to the code
- Allow alternate prefetch modes in DML for DCN32
- Fix VPG instancing for dcn314 HPO
- Check correct bounds for stream encoder instances for DCN303
- Enable SubVP by default on DCN32 & DCN321
- Fix DTBCLK not correct for dcn314
- Fix Compile-time warning
- Fix the stereo mode hang issue
- Fix display light up issue

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 86fe4b9f10c2..792fd57c1615 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.196"
+#define DC_VER "3.2.197"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

