Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B69CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DE9210E697;
	Fri, 17 Dec 2021 21:24:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F47610E68B
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:24:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bviLlOLJRmTYtNnc9218MFmr/gcGWGXY904dD3sauZI31rM7z8vVg2hF3307VuLOEHktEAkpTewnJ8o7x5ZA5MIGnM8ysqKPORbXgqjURO8Q6SFA19KU14kcpNF5N/xib0srepb9ZiUxZVRb+jpJj9ZBYzhDgKyotC6ThkNIN4hNK9e0tvu8RLGypI7vFpekZZ+EiYf+B2+ET3YA4/yx/XEwN62dlqY4nCRptyU1jpzOh40XrJUHCqjH2ut4WIfgxeeR/gQMvT+I+0i7hsIWimz+ACvhJL6CNt64fTok8mt/TY7z4NtjtgjHnEpu1b6YmWYXkMS4NwPTu7qClegSPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwX36XDNVI4pyScmg0q4Xg2u9ZCdlQ5+mPO4YNlW8ag=;
 b=KMds/I3RGxTEgOSJig8scnakRx76SG5y82mneujTWQCaTSp30KeTuQ78QJVSKKrpLrO4Fw7oXqHj6KcAAojnJNf6P8z9QWlI7GBSFAlSq8w6aW/hEP91lhjVBMGzZgBu5X8KCZG63+gWhrWXGzuP2jdD6TVvmYcO3e3I6v3rxHr2XLcGauv6kvMLl9LM+iK6M1YR6QC+TSAZX6DJtx+SMuw+4yc3WqQRho1/Zutwn4XmBBp/O9g67XJOP6JvL9Hmt72Bj9vZnIE9SIQRp2iU9A1G+NbNAFQDrT/f5qW4sEl2QNNZ6QziyzLrqg53U7edRMMrr8a4fIZ+IjQtZFos3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwX36XDNVI4pyScmg0q4Xg2u9ZCdlQ5+mPO4YNlW8ag=;
 b=vHaNkWM2YZcR3msKGDHH2rncV9bIqEamdzNlEL38XjBs8QMrERlMyHTuuZEjEO7RKG2hQNVGIgtH26M0tIZ1BOg3FxsGCxIF1ZCLID+crOpdzuQUhQsmwpyY4RVrUK38z+/mmk4Qh+hlpOhFbwjRd/kSRK5pW6pePPi3gyqWdFE=
Received: from MW4PR03CA0139.namprd03.prod.outlook.com (2603:10b6:303:8c::24)
 by MWHPR12MB1327.namprd12.prod.outlook.com (2603:10b6:300:11::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 21:24:30 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::ba) by MW4PR03CA0139.outlook.office365.com
 (2603:10b6:303:8c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Fri, 17 Dec 2021 21:24:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 21:24:29 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:24:27 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/19] drm/amd/display: Added power down for DCN10
Date: Fri, 17 Dec 2021 16:23:53 -0500
Message-ID: <20211217212407.3583190-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea0fadd8-42be-4401-3819-08d9c1a39c9d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1327:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1327B7EFE3B621BBD0F2619198789@MWHPR12MB1327.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UeSqcMpLtwNV16QqWllMo5pwtxuGQvlpHqOgFh51sRO+irSxhd6sb8pOfna9HQYRmLfWYuuXYyYGPgkFdqhCmyNREOs/TgmePK0WN5v319SYPCoPzeudSimujvp3EoRMzGqqWFnVrTbI7G5QdcO2YXoQOY1S72X0K5YWzZFKMyxff1IOaBu3kuRyRY8zh5lUOSUzWTsuwJ3G0dJ+zn7hL44elNSYnJilBWNxgosS7YCkQ7qnfeyeWstS1PvujuuhVuKXxqP/ECWT2PIQ3HFiOLoWU2ahqTTtWhfPaM0fKjvUCiBvkcXn3GI7G9xXtGsgYjt9A5aVF8e7hmQcw0C1BF6hJ+Y6X4mCCgx099MlA8mmnyVlhNpAxoFZ4uJE7UrqomBIHGtLCMV5cSu1rfVl6YYroUE1clFNRFjTlWthmBoSwJkpvvQYnjTTNuZlCxE92beehvl35oRtmDheQcb4wATs2MfWXIOMmqEKlzCajhO2W+uoFJw1E1qpnZmGgmsg4pM884qI25Pq4Rdr2/gEka6yYzbZOoYx+D7/Exy1PPA0lscZP7ngOpYG8CResW7f6kOeA/H47q6IrWh1RmYSxfLD3a/lcMm7NVO8ooqJr80Whsy6ZbBpvfjDbpf6nqWuY+bnW4EdzP1PyWQz2LF3Y86egBMeBKuCQa5VvJr6DqGOZXlLnnKnbsGbo0SwUtCJjcI0pak1IS7r3TOjq1N/RTpLsc6+MCX3VS/K4hMeadRXJymita97lFC5bJ+sba2rHsZichgn2L1TybBSmj3WvZTysPLlKkTeWLjPvpPjK0A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(40460700001)(2616005)(6666004)(8936002)(5660300002)(54906003)(82310400004)(1076003)(86362001)(4326008)(508600001)(70586007)(47076005)(36756003)(6916009)(26005)(336012)(426003)(356005)(186003)(70206006)(16526019)(83380400001)(81166007)(2906002)(8676002)(36860700001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 21:24:29.9452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0fadd8-42be-4401-3819-08d9c1a39c9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1327
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
Cc: stylon.wang@amd.com, "Lai, Derek" <Derek.Lai@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Lai, Derek" <Derek.Lai@amd.com>

[Why]
The change of setting a timer callback on boot for 10 seconds is still
working, just lacked power down for DCN10.

[How]
Added power down for DCN10.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Derek Lai <Derek.Lai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index 34001a30d449..10e613ec7d24 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -78,6 +78,7 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.get_clock = dcn10_get_clock,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
+	.power_down = dce110_power_down,
 	.set_backlight_level = dce110_set_backlight_level,
 	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
 	.set_pipe = dce110_set_pipe,
-- 
2.25.1

