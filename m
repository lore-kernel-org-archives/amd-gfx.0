Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18CFC83F12
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Aug 2023 04:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B25B10E0E8;
	Tue, 29 Aug 2023 04:51:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3691210E0E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Aug 2023 04:51:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaomjomitcmAQ4D59B4BImUdVnWOf/fEmlAFh+YDIW6donClAOT8PFt/4Wj5Etq8NHK771sY9sHNdoJoc8ITn26V8WDi1OZqtty9jHDhSRyvwchoQ4CxbwCyKph8US2GlqjZUwKelksz1tcJEJDHS1Z7V4DSKAwzh1Tj+FQNbjyUDavil6pZaeUsGU8a+znklpUy+mP8/KfQe+4SpBccyd0NvOgBjiFls053a9Ch9gRKjWONs9YKoh1NEIFRIaAHarnNapPbhoOpAKhZWUDo2PNvYPH8B1SIVG49rS8p8SzU3B1m9Lvk2+Sg63QczyjE/WrN/ocfMdElN0X3dLVlkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3K+dEqFI93meS+xYxonIR84dvCdIcoDP5xZeCS7W5JA=;
 b=XjoIC8mLSD53fGa3ctlRKgA/+/AwkS3xYzlZLR4ZJhbnpLX6x1XXxb8lmZYMuLWWy2IGAk9vhxyAk5Un8xa4RjpJqY1nDNj1xMmnLJ92xuT7LOhSch9J5I+rkQf3TDbK85ZStXV/WSxWW46eEE6dFq5mfWaMP/K1NP/01pit+A1Lx02DxunX90GHO7QJh/iQSitxmgvST+oOybjBW13vDAvCIgI6+7j8xWOxykDyvBx53D8GkBeiDOv8qZkB9KLbL+Qlv6CeICkiU10IIOigMyVd1cmbemrM2pdl8z778n6g08lkbZfBWZh0Rc/u6uZURQMwPjXtG8Z6IbtS6AROaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3K+dEqFI93meS+xYxonIR84dvCdIcoDP5xZeCS7W5JA=;
 b=yEkNWHg6Ppj8DUETcHaBjVYEfUMLs/vBzrS34CYX9hwbRmpq1cPSkXcrnxcTAPYHkWxZ3KvX42KDzvoYQYZtaSeZVXPoVr8imi3F+ffzFRdZ6Gjdp3+5vwkJJYCUB6JDVzY0b9ztV8FozV4+BFTUgfRRw3d6xqrf774/+sqfvcQ=
Received: from DS7PR05CA0092.namprd05.prod.outlook.com (2603:10b6:8:56::10) by
 SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 04:51:28 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:8:56:cafe::7a) by DS7PR05CA0092.outlook.office365.com
 (2603:10b6:8:56::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.17 via Frontend
 Transport; Tue, 29 Aug 2023 04:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 04:51:28 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 23:51:25 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 "Qingqing Zhuo" <Qingqing.Zhuo@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Fix up kdoc for 'optc35_set_odm_combine'
Date: Tue, 29 Aug 2023 10:20:48 +0530
Message-ID: <20230829045048.1369376-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb443ce-0cc6-44e3-5406-08dba84b9b26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dyYFHK6spfhJYdWUXwIW7g6KuyneGDAaSApy+rPKmxC0QJidPYJ5DklOE3i8SBRwFWQdAnMOx+SjVnRzzHmcO6yXNyQz/ZjsHj9hLUXZS0ul7B3HPmU4ZucUpEKA6uXPmRGJAWnn35cATNVyE3k7UonflOkf7Dq5dtsv49ZLH8DDPlY8MYblcWNSsYqJP7EBH09VTo9py3To8IDheZjcHEtm6y0aJ19uVS6dAflOtetDjdxBzRsmHGe2DzU2nCthjmLvFAk66XkxIyVNHSfEn9W06455zQLx+AVVGM/pzS5yMvoPu+++Zv71ziAShge3ahqHnin+B2xxwfKg1cpiDt4r+LJSkaMFzrEysFtOBFd+oFlcmkIIVTgfnO5DVKb2DmjD24F2612UequtD5VGsdaqlkpmVwDws4nDGzWPYvt6Rf/DENvaE4GRm+jB0y02UOMeqiXDh+M9VL/1lfOGJ4BciG+ldox1S4eIdvU8/NGbehn/U0PLc+Jm6D6+v9V2SQ1a3w9+B7s9Cqf4j0LKyv830zez8YIJzafzmIGychCxTH7f5a1aYv+jTqxkoKRvKsQ6FPqlglg9a2iOhTcQqSuEZceDl4sbKNMpP3MyXA//0TKJF60w7rEGC5QpsMjVSNXTpcfQsfuOsXjPlF9bfkbbEPpVSnvLtL2Y3lkCjXUI0yVXxtYPUosZUOMd7pHrUA3+xef1jsYrz2F370WAWBRBZeSkFUtwac+VO7hFDJocw//oeP3rBnN2HbdRyRpJxGGr1wAmk3o/ajhmYhMbjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(36860700001)(40460700003)(41300700001)(356005)(82740400003)(81166007)(6666004)(86362001)(83380400001)(478600001)(47076005)(426003)(26005)(2616005)(16526019)(336012)(1076003)(7696005)(40480700001)(70206006)(70586007)(54906003)(110136005)(2906002)(6636002)(36756003)(316002)(5660300002)(4326008)(8676002)(8936002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 04:51:28.1269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb443ce-0cc6-44e3-5406-08dba84b9b26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following W=1 kernel build warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn35/dcn35_optc.c:46: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
* Enable CRTC

Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
index 5f7adc83258b..294799d8c34e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
@@ -43,10 +43,15 @@
 	optc1->tg_shift->field_name, optc1->tg_mask->field_name
 
 /**
- * Enable CRTC
- * Enable CRTC - call ASIC Control Object to enable Timing generator.
+ * optc35_set_odm_combine() - Enable CRTC - call ASIC Control Object to enable Timing generator.
+ *
+ * @optc: timing_generator instance.
+ * @opp_id: OPP instance.
+ * @opp_cnt: OPP count.
+ * @timing: Timing parameters used to configure DCN blocks.
+ *
+ * Return: void.
  */
-
 static void optc35_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
 		struct dc_crtc_timing *timing)
 {
-- 
2.25.1

