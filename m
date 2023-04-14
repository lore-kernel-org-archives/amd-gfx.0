Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318A7C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABD9710EDA4;
	Fri, 14 Apr 2023 15:53:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99B8F10E1C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:53:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmeowEhvqBg7oni44GKpAifjU7Hw0FnUAxcCBMIEzeLV8OLftRKfi+LSVfIFJbcyRJ88s3zhFogzD4dDNYnyJurfGAy0HScE2j/4Ksp5dHB/XBU6rv65RT8elk78aSxBtjeZKuvVHow0YA56ZFfSaDd92AIeodC0wbZXZkuPMr7a9nJPlJfp1kIpzjzizMmWDQLAVsBe42TZT9Jqb6BQX2ulQDAJKVeU3XvQA0BKqi8at5cSfD/+n9H6FEuqZRuJtEUJd4iNh7iXFbbb/jQw3irIi/x/2kv5PecqOJilyg07L+Y6rFtC8liHLOJaq+j8PcYrM17JtlnP88DMuYSz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLbGWXS+/ngeoVCseVO7FMtXsLcqhe2BJ8p3xZ/8kMI=;
 b=ia1dATtsccGOEwrB6w2B+fr00cPLc+CQG91HEmcoZYZhl0wp77ygzm0lCfrk/PFTUej1HawPP5k+x9Jz78vwmpi8wyWedQebz85X9N4Op5d4FCgsqdzlYbIhlyZb+ke6uEDb2mY8asH3FGpvhnfbiOa1K0jW/Vw46dvkIq66huT64DnBsQ+WOzIRXokYCHCcWGBOmY7ppO6K83ZBsdZ9lU4f4UFgEeJkmofP83jKUQmTaGQSe0P/i2LZbEnAfQp2oqB6uCnnra28ulCpI9hBgaZtp1FP1jOb+lxao9xGJT9ZmZgWj8spCNJsI69pPNiN3KX2AfSsNLmSi1US7BH7/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLbGWXS+/ngeoVCseVO7FMtXsLcqhe2BJ8p3xZ/8kMI=;
 b=yOUvQgl/K+MsOVmbQ5YdTAW/g1oK7yXpfCLm6JbSw9ELofeHmelFSnknlRmTgaQeArHIcfSmiq/te4jED3e8N7VpcMIfMfaQzX88Zk/4C+p1DwREHAc/u5e9OvnegnjhUgea0H+0Q8dlIHhy8a1Xk/U7E13qHCeselsRes8Nfn0=
Received: from DS7PR05CA0098.namprd05.prod.outlook.com (2603:10b6:8:56::8) by
 DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Fri, 14 Apr 2023 15:53:49 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::71) by DS7PR05CA0098.outlook.office365.com
 (2603:10b6:8:56::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.11 via Frontend
 Transport; Fri, 14 Apr 2023 15:53:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 15:53:49 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:53:47 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/66] drm/amd/display: Add missing mclk update
Date: Fri, 14 Apr 2023 11:52:26 -0400
Message-ID: <20230414155330.5215-3-Qingqing.Zhuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT019:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: d100ab01-33f6-46c6-ae66-08db3d00704b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gDXQ8GzPN345FAGaW2PW5nSluUUglinAPwCkAHGpE/8CR1IgXA3i3S02BqIwcH5+YbqTbifX/p7jxbw8Pz2vN80sxZ16NqfFTRvlahUBw+ki9tShWW/WqinxJdfyKRRbQoV2ehOdnpxQiRVw6iQY/GROrbaTmBz29MPzJ3/QiwhiswG/qS21A/GGW6ceaNkztchU5U3OowXtfIsiJjaqTWnQYzxLh7BMdOLQZaakW3Ihb23+7V8vhuh9YhFc3KkazEWDiSH+xXyIpEM2DgyXhonOQ9yPdvdXaWGIrDJSCedVQWv8j645TEHN5gDHz6uzbqr3JFgSAA1hXEiu6bLb46PrIN6/QmnciLMHosTN2GLuYHtL0HzDgdrbqxHietZJMhYpDo4R55VooCQxweLjyUdo0+f43mxY6P+rzX2Ibh6Tw2vvYSks7OkdZDtYPcnARjKtYmcmy+v/PJfGXf9dR6BMYVDOG8iYvfrm6rTBRSlAHa1NfnZmsn3wTSBQZooCIdWyOUBrbCM7FIwnKVTPJZmRFwxOW0jQ9s06lF3Ig9h4QUh6e6EqlpU6yW3qsNmsCaLWhQrYFRqacUXDbaH+0hB/tLcesyzeGcDpkwLcQPctLXUYbtznWyHmVbriycUYfHgoATnEnHCf4+EZI4pZuQybqVFMW7y7Bds9/c73eSWl0P4ssfABJXHxplFqzrlvRT++/I0zwrvBO9SS1Xtu+sxjdN6R2auJ6HemsTtX+kA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(26005)(336012)(426003)(1076003)(54906003)(40480700001)(186003)(47076005)(83380400001)(2616005)(16526019)(36860700001)(40460700003)(6666004)(5660300002)(41300700001)(316002)(8936002)(82740400003)(82310400005)(8676002)(356005)(86362001)(81166007)(478600001)(70586007)(36756003)(4326008)(70206006)(6916009)(2906002)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:53:49.5578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d100ab01-33f6-46c6-ae66-08db3d00704b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
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

When using FPO, there is some misconfiguration that happens for the lack
of configuration of the MCLK switch in some circumstances. This commit
adds the required field update when using the MCLK switch.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index f0037cb43dca..23a972f2885f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1331,6 +1331,11 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb]
 					!= dm_dram_clock_change_unsupported;
 
+	/* Pstate change might not be supported by hardware, but it might be
+	 * possible with firmware driven vertical blank stretching.
+	 */
+	context->bw_ctx.bw.dcn.clk.p_state_change_support |= context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching;
+
 	context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
 	context->bw_ctx.bw.dcn.clk.dtbclk_en = is_dtbclk_required(dc, context);
 	context->bw_ctx.bw.dcn.clk.ref_dtbclk_khz = context->bw_ctx.dml.vba.DTBCLKPerState[vlevel] * 1000;
-- 
2.34.1

