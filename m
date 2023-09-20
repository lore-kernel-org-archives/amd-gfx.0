Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFFCCE79A9
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 03:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A57C410E41F;
	Wed, 20 Sep 2023 03:17:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3806310E03F
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 03:17:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHKaTU5Ze6TYSzWru/FFkH7ZwMLTSvlsNJcm0nirYBlXtHgOXfXVFk1nHHZmWy7TXtDIw8fQD4SlciCMPLAfKpfvFxUTH6gUAJDWjJinOLSDDBho6tcbqWVg24+QseihKFIWx91/vJ60th3CpJmITj1YZ4GimxLI9ZnUOLXPNJYQgdVyasnfiabWXMCd6XtFwSaNt7kgYmB14D45mfjGM0PtVjZHcoe3+JhX/0+lps4Bm7qmvClIjMk1klUf/UWZG2hz1bzeixovOlCzBvUFIm+dA+AjsJ4LFVz/OJAJbHmhJfx80bqSkhHzB5BRInZZ3806VMXUbflSxHHHjtJGXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRTndiqKx2CDsSRmDSyUeA4LATvEjqUWNfxuSlfcK9o=;
 b=X5Pa2S0Qko7lsQsjAlgivUxjBZ01A0YTD388oWj+GO6GUkK748uBcDpUbHGJn/9xT9uBuSE2gZsaKiqqYeSu/OPFSSMkM9JT5WxF4j5OcZEM6kFBD/RqPhdq8CdpQ7gMJr4UMTCYqHxy4LmyLXu1datQcH3WGUodsDMHKeTJOTLLEKQ1TZfMKNRp6u4xLWBhytJpjSXYoDQZfAIFyicxJd8cY2ictTuSFqicCQ0CQePGL7bJqoI0xrX5OLy2nreXHmxyeNnG1FEJ9qOBKWt1InU30tB5X8doskzzuNfUcuZygdrRFhkyEZjjpmaS98ypTsGeoJUa9eJYwxR1dwfXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRTndiqKx2CDsSRmDSyUeA4LATvEjqUWNfxuSlfcK9o=;
 b=1oxYCw0RGety1sP7hjnNqbgUGf8TU4lEEbVR0k7jROvgL0Bz4KrdsGPwb1PsYtVk15ffsq3zRV4MpxMB8ChZZ0tvEvDpvC48x2k936GLJGIa9Q7OTP0GcBWyeCVNaIUQutOXFTO3CwLYharTFgj83Rs2nPgbxnglfwvibAjcl7k=
Received: from MN2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:208:1a0::32)
 by CH0PR12MB5268.namprd12.prod.outlook.com (2603:10b6:610:d3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 03:17:23 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::7) by MN2PR07CA0022.outlook.office365.com
 (2603:10b6:208:1a0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 03:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 03:17:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:17:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:17:16 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:17:07 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/19] drm/amd/display: remove unused mmhub_reg_offsets
Date: Wed, 20 Sep 2023 11:16:06 +0800
Message-ID: <20230920031624.3129206-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230920031624.3129206-1-Wayne.Lin@amd.com>
References: <20230920031624.3129206-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|CH0PR12MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: cec85f36-90f6-4250-1a64-08dbb9881bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bMuNh6T3wRgIc5rGNnQcMtnFaIYEfN/ffWwFrKqIEsxzWpjiaFR9hpi/r6vrxDIOaXdJAQGJwyIR3QCpdqrJATftTjFOBj4uZCs1Bo05J3cIFBkm4hYGtMzhg7Ep8c/O5FWCCU5eNT281HUOwna8bponcLNKwEWFWS/Rktkujx+KFabvM0wH/xtrZY8ExpYXmEXIBSjCObm10nIbd+SoZ1dxiZwjsOaDZD8mZ5Wj9beyliwQZrtdSi9w6gLcYQBn1uSQjk35S7MsWokjvr3yzcf4kO7k7XVCCLRWkMajMF6p0p7ZTci/lBZLaTU5GDriEFy92FImIZ18HGF8n63sPkOGuCXTgU9vdM/Wdw2yInRzszvZeGeMqYYhpsQM4KCFoeSHsFZPDauueXu5JSL1Wo4g9s58pHEw9qUTbnJMfpmMxMaEV+9CQXMg8rLIeSTwtkYFalKMEt/zUL+ViQVgVmO6KUKb8zP6ilh5Vcp4LBE6NzjDCdHqvXFhqDG94tqLJQqIrBCPIsdZGVwkqsn0CHlEa/hDBm3jH85VOd+gQEnNPcH5fNTKvcU1OtQf9j2i0/4329uIYj2HjRFoHPXt5cU4xcrqac1YBKXLUOuvkGvoDXLl11H7Yfr6jSXbmFogYrfKoIn2QliHfwKvqb1JL+lC4M8y2wj6iJg/CDpsRuu4CkuCGYOQOBi1/fcZR70gBedtooPLdUhluV5mDUdAs4tuRlyP8QApVKtBlPbSvKTTNYfXZs2/KmlYw2stvQA+fjJTU0qdrWsaFEz+XpK2fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(186009)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(7696005)(40460700003)(356005)(86362001)(81166007)(82740400003)(40480700001)(36756003)(36860700001)(1076003)(26005)(2906002)(47076005)(2616005)(336012)(426003)(83380400001)(478600001)(8676002)(5660300002)(8936002)(6916009)(4326008)(41300700001)(316002)(54906003)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:17:23.5443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cec85f36-90f6-4250-1a64-08dbb9881bc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5268
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
 qingqing.zhuo@amd.com, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why & How]
mmhub_reg_offsets never used in code. Remove it.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 961af9e7d5c7..06fd02084d7c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -205,16 +205,6 @@ enum dcn35_clk_src_array_id {
 	REG_STRUCT[id].reg_name = NBIO_BASE(regBIF_BX2_ ## reg_name ## _BASE_IDX) + \
 		regBIF_BX2_ ## reg_name
 
-/* MMHUB */
-#define MMHUB_BASE_INNER(seg) ctx->mmhub_reg_offsets[seg]
-
-#define MMHUB_BASE(seg) \
-	MMHUB_BASE_INNER(seg)
-
-#define MMHUB_SR(reg_name)\
-		REG_STRUCT.reg_name = MMHUB_BASE(reg ## reg_name ## _BASE_IDX) + \
-					reg ## reg_name
-
 #define bios_regs_init() \
 		( \
 		NBIO_SR(BIOS_SCRATCH_3),\
-- 
2.37.3

