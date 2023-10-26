Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F37C25B67
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6322310E81E;
	Thu, 26 Oct 2023 14:21:00 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D7A10E81A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:20:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbyHAPLHU4GoqyRtWUWmdrjx4d/6+8JJVbwskTS6iZJ0YSYXD5Lt4zL4u9bkujL0iUBfTZy2nSvvPkWsfLEqW97obJprWw3Bp9a6wMcCNQhADOIm2K97gCGMs60SA/XsoBxDW8kqRIKypq+y7FKHhC7t50fIXLySTejG88f4hQ4uGEN7PEcn+eUxPrqgWOXwWaFrJ3h0DOmlvMT2+XJJMYYjpK2xvN/cWXaLPpVGthKidn6zCuNQMKM+fcyMQb5YxyT+AYxvTUftqhVRKGQ0kqtfO1Ygj63QSfEcM2PJHPE6mIzKyfWbIhJJV5A51ltrsnHUwTzfpgdGODsyZ489yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXJJSqgnEYNBkSYdIVPM3hgyPp+tkLMmhxys6uvfcpY=;
 b=Wm1WXSrFi3A3nSDJDu8pyvHXFX5THT9VdXcVJHVbFDcBeJitCrPkuEgOs5QmXQQFMWFJP9oRjOSXbDf1MX8bBDqF5SZ6F+q/dCwB+J4dU0oDF1e0hirMjqONsoQS0imBtaIrlUxx0hcLn6ZnKTfzs4trKJQ2eifCbsD+zSjQ+066NQgwGztU4lTwo7ILvjwjNTV5PvY9Duh0A8KKkdACRLN3465cqd+cOhNtEtWU4CjhX7p/jx6oHcu3h7Jx3lbz/hpFuaOe6eSYfxmUPAUXBsUAJm4dZaonBDEkq8iD594NsCBVWtbEePyRF/+9TzrSvsob7P9dm1qaKSRZJd+ulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXJJSqgnEYNBkSYdIVPM3hgyPp+tkLMmhxys6uvfcpY=;
 b=EzMmpTTP+76ZSUA9GnwYBMYwdDVyxi0KKaY0uu6rM4KSOwBR6rkX95kZy5x3glDysGs0ByKeOSQitFcZqGQK1MPsKCq0kSCs6v0dif2RQ2QEIij5WZzDzbSyY/lTkqcBLVTYPbt+WKYnQTQHjAD5o9JXEA3ngBg86iv/B0OnRWE=
Received: from SN7P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::29)
 by SA3PR12MB8000.namprd12.prod.outlook.com (2603:10b6:806:31f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Thu, 26 Oct
 2023 14:20:54 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:123:cafe::1a) by SN7P220CA0024.outlook.office365.com
 (2603:10b6:806:123::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Thu, 26 Oct 2023 14:20:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:20:53 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 07:20:53 -0700
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:47 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/25] drm/amd/display: Add missing dml2 init value for dcn35
Date: Thu, 26 Oct 2023 10:20:12 -0400
Message-ID: <20231026142020.67861-18-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|SA3PR12MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 61dc978b-1fea-4c36-c1eb-08dbd62ec362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WrPrnAPr3QsYSmk1Y2oMW3/UvhONXyP8eNLo/EDUIValfImHb2uevuppbNpH1tlSed6c37062ULmlNkillLMuoHM+S2C68pi/c64INfzo5Mpxsw7qx540WGqXcIXzgKxrl2MEU78yBmJwWJ3GYeUKEAAEbnM4V1luiU/iIr0i0uF9IelxxRCCAJDSJvZwcRALZRFY4g2iEX3cF8ArLoD8uynusazPGIrbDGu/TNzkFsu9NPt7QpZxQPj0HK5YnGhv8LksPZUyexgTIJuIBL5zj2lzOrPO8f8QkrMj7QCWrSqHCLtP785nPV0KhNWEcUsVEWGivpkfLtTiHuvepoo4JxE1e+u6xQObNHZkvEPM8n1NVGgf34YD3O9Pj+XKdw/b1mtZGyb0iZ93r7WNlRrY7Jk3B7cBVVIegpB0yQObDDqIqIfjUlklRWPxhTSIfXT/EMhgKQdJhsKrny4yXs7n06t5RULIR6UymYXi0+gIn6RpHyYPBx2oPBMoBdWUhNJzaJ81Ur5ROxOjYBdSHEFrNl2/wsRsBGC9Feaie+LEPVrRVs8Z+sc25MNfZC9k0kkgrqJ5M7mSLaN4UL/lEGaWuL5HSJoA7G7xB54DtT2wggxMyNYkp1Df5msm4b4je0srIMoTBbcoDzmYcdBf7N2fnIMPliqn/QhTrnpoCut7m9oDr/OLmoZqi30maiwxsCR6ic1NojWoCk6O4hFCzM512PvF452tYBR1BBbL02Evt/3qeuKLwYUXCVbEaYZ9FJsZTd9PygFdoRUyqne0JMc0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(336012)(426003)(356005)(1076003)(2616005)(47076005)(478600001)(54906003)(26005)(81166007)(6666004)(82740400003)(70206006)(70586007)(36860700001)(316002)(6916009)(8676002)(8936002)(4326008)(5660300002)(41300700001)(2906002)(86362001)(40460700003)(36756003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:20:53.7301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61dc978b-1fea-4c36-c1eb-08dbd62ec362
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8000
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry Wentland <harry.wentland@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
For lighting up, some dml2 params needs to be initialized.
One of them escaped initial patch under:
"drm/amd/display: Add DCN35 DML2 support"

[How]
Add missing initialization.

Fixes: 8e821cf83eed ("drm/amd/display: Add DCN35 DML2 support")

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index f2a91c0c8b3a..eec4799bed61 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -231,6 +231,7 @@ void dml2_init_socbb_params(struct dml2_context *dml2, const struct dc *in_dc, s
 		out->num_chans = 4;
 		out->round_trip_ping_latency_dcfclk_cycles = 106;
 		out->smn_latency_us = 2;
+		out->dispclk_dppclk_vco_speed_mhz = 3600;
 		break;
 
 	case dml_project_dcn351:
-- 
2.25.1

