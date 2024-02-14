Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45CEC48BEB
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AD2610E396;
	Wed, 14 Feb 2024 18:40:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qr7Rwv4H";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C5110E0AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:40:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAYzImuL2E6gLrHm1efkob1XG3vzH5JsB9lWM1y9JXBD9c0W2kuaNyR3MsKajLaENtXPh15yRDsCqD/O1OoZOpr2d3CgYJy5hZXppqSDCvv165gRZSRtoWV8RccNikQ6XWZqR2sicd1pVM9D0y8oybny8hAatRrjcP3N7LPMa5MbYl7VuC7vSAjm6CsIKhd/WftjIoZXf1BX6O7PLIBMhg7docox7piGRmrq/QDNYoEZnT39JFC2R+5HPDNVePfhycu0/BTrHOGx5D4fjis/FcRn/Mp/AlmBGgF6dUMZMrUvLcCwBs1loR5QjKhu+2NhGn2DipjVIuh+Q3i2kSRU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xdobe9xvSDIlpxWCs8iH+9+DUpDtA4+dcHw4fK5aQlw=;
 b=d8PL0KjD5COhL2ILlnzlkN6y7pBS+5r59J+1HxEanI8odNie5wgR00NOJc2KecLUyfC98i/iWv3cq+oWPaSbQEfvfsdkBLkmaDj/uS2ln6CLOxiRKvK3FIg23NoP1+Hv9pt856LbTO/L2fIxAff4JxOnYTsRZGfKl6d16cT18qlZRPW9lWlRXfgZVdyyi8+zXT7x3giWXHiPsbSE/wrJoINvI1Kgz0R/+wNb5xvDlKbmV6Sqfj/oczrUEfDsNuX/3js3sHhzzkIZDcradJJZaNaNVfO5BwYzS/GjY7wJWDipM7sHhGQMGu6O2y0SPFKXSPOiRLcaEomQA24nIw/r9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xdobe9xvSDIlpxWCs8iH+9+DUpDtA4+dcHw4fK5aQlw=;
 b=qr7Rwv4Hx3QevRNlz2z1r/JEf84EglBBbT+DG0WkTT5wfcBUhUrN8HN8lJWdvCDg4cbyhv1Kv5Tz8SvBD5KgSbf+PeWdKi8BE1ykS3VNi8D6HjjM7PA9fotm9BrhUyOgNIxr6iifsd2MCVtd4ZVy0Kbq5pkES9oMwuQbXNKeri8=
Received: from BYAPR03CA0008.namprd03.prod.outlook.com (2603:10b6:a02:a8::21)
 by IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 18:40:38 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:a02:a8:cafe::2d) by BYAPR03CA0008.outlook.office365.com
 (2603:10b6:a02:a8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Wed, 14 Feb 2024 18:40:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 18:40:37 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 12:40:35 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 05/17] drm/amd/display: Remove redundant FPU guard
Date: Wed, 14 Feb 2024 11:38:36 -0700
Message-ID: <20240214184006.1356137-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|IA0PR12MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1cdc5b-293c-4edc-5d19-08dc2d8c6fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7n8SFVhHbWciOVtYh7Dr7DQeEnwlND5+i1fcfrpHIPlusgePDoaH9OiXE8bKlVbRmIXnoiU0HrIx7u3FOe2f2q9XujnwjBbmr8KWNUnzcQFhpE7YAruUYJX8TGeXNwX9cWIcR++LPgfqiK7qFQFqsoyxKGvbX4LZMQbfgZwc7lRGCyHMwQ+q2ykiT3uQYXNAAh6Hja+qiq3ckVx5sZVuLleqp7NjBpM6NsSirylDujpW1WVKwpNr4mnit8dAPpHEqduELpeWQHpj/A30sZXXpNNn5TFlfDtyB9yuCCCTARJs2+4gq4B80KL2KwyL63AjAH4mpg8e6eMmJu9okRdASRdXz9MI/bOPqsWlpb2Sb1isSPouHtHMJeuIgsS0rGXkmy59FYWh+dFXW5X9fhiPWJ5UBlpWISwA/m4tZBgeA4mkgYhM/p0In9qfBG27y6/Orr8W+EcPTBAyc1z50nSAbHAdCNxEJwLyAgoWEBl2lxRD4MhAkHxdsE9QO98kuik+GReaGGVGZWYNAwrlibbFYxNgk4VdyZxSAgz4EPSW5kkHWxaN3ltxoNS4I7m4q68iZq4EEp7MRrqSqWDy6tZT5sWRDmZdN208GmFnoxUi9A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(4326008)(5660300002)(8936002)(4744005)(41300700001)(8676002)(2906002)(86362001)(356005)(83380400001)(82740400003)(81166007)(36756003)(2616005)(1076003)(54906003)(426003)(316002)(16526019)(70586007)(336012)(6916009)(478600001)(70206006)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:40:37.5394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1cdc5b-293c-4edc-5d19-08dc2d8c6fee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647
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

The function dcn32_build_wm_range_table call DC_FP_START/END. Drop the
unnecessary FPU guard.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index e64e45e4c833..ee5e7512a7ee 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -243,10 +243,8 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 	/* Get UCLK, update bounding box */
 	clk_mgr_base->funcs->get_memclk_states_from_smu(clk_mgr_base);
 
-	DC_FP_START();
 	/* WM range table */
 	dcn32_build_wm_range_table(clk_mgr);
-	DC_FP_END();
 }
 
 static void dcn32_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
-- 
2.43.0

