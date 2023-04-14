Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77B2C77B71
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D62310EDAF;
	Fri, 14 Apr 2023 15:54:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9436A10EDB4
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:53:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFuoMh1l93+0RspQCZD3nxZChk5G7rdp9MuJKSXEzh9KFC+r5LPbtGybCStBhSiDe5ZEJmIYmS+Jc3UzO79+ESqLYmuus2FWo79R281tUrLLnCuTQaUi93G4+Ww7jLRjfv7ByFozdqYZRcnrzHxxiNchi7kZpoyxvYlIyBkvqboMIejtTjkUqdI+eNRIhsTBT25lc9vTdEpCMq1nbPyMeoykSwZO9mC7EDBTvnoWAEgnmwPXhaXij9dUj+IWQCLHz2s3vPChu8Z3m3xMtIqv7l5bST9THesYJ6g7kdpfsnuYC249A1mNOlE/xjGf1q/Ke8BU+vLJV16of3hO0nJJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZU/8DuoEHJHiQ8XdGObgeO3hdHDjJeZQVF9eSlWG2A=;
 b=f2GkHC4zhSWYKpn9VdUBDzMAMdb99jxX73n8gvmuVRZRCAkNT2eY95yP5P34S3IahhlaYjGdwyluLawi4mUuMJl8wz7D/sXsvQ0gDTjPdZZT8rHHeEaxrSI4ESHP2LMH4gY07b/MjQTOfCVMm6NThRvGJXhUyGCaa5qU3/vwY9GOWnxNMauy3qys2/Bed9K8ukv5o6j+NP0sg5CG81wcEOx+qoWlO9RG0qaYXu3C50N1F9K5+HPzOqO5AcGVYZaQiQi71zrE1DDSCTVC4bOqH1OAaobRxdNBIBTDrLTX+X5Zv4Ro9sJERnlSNvgy13iT7k0Ay3cuo44lG9As7OMd/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZU/8DuoEHJHiQ8XdGObgeO3hdHDjJeZQVF9eSlWG2A=;
 b=wXTgGMSNoDk/InMsqQOJSviP1uw7PCK+Y4eZ6N2e4uMrp3V8f4X6IfA7jEX0BW+eo0dDBgbdcprWK7hEVVKrD5xo7xkNq729sATCiFG7ya/X2/whQx0xGT0WvxujyyLpcJxyb4Nd4OnskQ1HqWMBZsjc6+1MhK1NXON45ymSYMg=
Received: from DM6PR03CA0039.namprd03.prod.outlook.com (2603:10b6:5:100::16)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:53:56 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::14) by DM6PR03CA0039.outlook.office365.com
 (2603:10b6:5:100::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:53:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:53:56 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:53:54 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/66] drm/amd/display: Remove wrong assignment of DP link rate
Date: Fri, 14 Apr 2023 11:52:30 -0400
Message-ID: <20230414155330.5215-7-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|BY5PR12MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: abe591d9-5f20-4c69-cceb-08db3d007437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0BTMWeTjCHvC3DGThNK/2JDTt2S5BpNOuWmxh3kCZVnJ1a+d0SJClZe/1iZ4sKiAGY1ETaeU4S+zcjfXYW+hNKqkgee6FwoQmhS81hQbVJbwatxdvt7Oh2K6ifh/JeIEkJS615QkpQG+ViXLW0zey7KOXuyXZRWuk2piLyAMEfxea4W/dqM/mUN8AKlAhCpmRsF/Pwf+WIT4AfEb3RF8C4rf0P9NC51x+FkvSAG7IKKEXuTXJrB65MJQ4jtkIscdZTg3vbmJ43Ii6RhlvpffVBQZmSfQQwlWBAywOqbUbTkboadzvVMmDYsqxSd4i8avjpIQYLoZb+waf3xk+i51Zzrs8yYxbtDqSXpyH7buvUSFTNT0V6UWYf3XCEgWTWQO9Z7sx1SJSH7ekQetuN7Pv0AWHoglH7tHCAIy3waMlvRGZ0W22+7Gair7uRDdTSVoc/hJfI4rMbV6vMNzcDvMCynjF9xPGIgyWvTmlnBdtQEtU5bP8YDiUAj/u9A++TZ/W046y3O8SSg9hz6NNATQBMJFk12sNHn/XSnNuG6TDrKM5PbSyVIXIUkdG+RR4t/6a+51tTqvN20SA9SP+spuhNvGuboOO5kBjDg8YCA0UYFeD3Esqdd7Dct4xun98G0TJFPLbuQLgo6AqVw3xz0ARLKJTL3UES5R5wvN9wvp0/iuErMMMA6RR3XTlLxCRKM+/qIdJnra18UL5z8XZQc47aroFbLrrcTfboNNG7Of9+s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(8936002)(40460700003)(36860700001)(336012)(36756003)(5660300002)(81166007)(4744005)(2906002)(40480700001)(86362001)(316002)(82310400005)(8676002)(356005)(41300700001)(6916009)(82740400003)(4326008)(70206006)(70586007)(426003)(47076005)(2616005)(83380400001)(186003)(26005)(54906003)(478600001)(1076003)(6666004)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:53:56.1384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abe591d9-5f20-4c69-cceb-08db3d007437
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 9fadac1b4c64..03718cc148e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1360,7 +1360,6 @@ int dcn20_populate_dml_pipes_from_context(struct dc *dc,
 			pipes[pipe_cnt].dout.is_virtual = 1;
 			pipes[pipe_cnt].dout.output_type = dm_dp;
 			pipes[pipe_cnt].dout.dp_lanes = 4;
-			pipes[pipe_cnt].dout.dp_rate = dm_dp_rate_hbr2;
 		}
 
 		switch (res_ctx->pipe_ctx[i].stream->timing.display_color_depth) {
-- 
2.34.1

