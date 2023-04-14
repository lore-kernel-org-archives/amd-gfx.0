Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568E7C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3C1C10EDE7;
	Fri, 14 Apr 2023 15:55:09 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3160710EDE0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:55:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzkSBGuDOBuqApZ8S93A+AI4SwZ6+zx37AJczV6P8U5hbDeOeWtHWLebVzpscp9oSKZOPQx8Zr2V1fVDX9tbW9SKXzXgDx2d31rSCk8EOLuUlvfGWd8nZ0SVWbHS7B6hPtlSsGlS2KPZY+izEpJlWNMWeREaj0hO+ExSkNPvM89xmrqbdfQDHf+M8ntADAYACRqLicyWYt1Zf5Sk/dYTcebl6WCqzhJ2zCy+Vd9v5n2OyyVXut7n+vEiZ7EN1SSMNtFNKR6nXzQyezNHLvDttxqRR1j4/Prkk9UvAfxLTiqcf0dVXeLCF8QXd4hxDh3obfFXrDbj8O5S4p0jyjQs0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+V2LfAzmGag0FOQ3z19fdNnrGnx50AbS+LQD2VJ1moQ=;
 b=kKsDe/p2BRZGOLA0VzrB6GasQKhHTXaqFSlR6cn08lwPuAtSALGxfk4n0TM/FPcPxXmsk5397KVgTENqLM/iIfxDUAAN/StxLTWwNt49r79U29I5JaaPB7esgY1TZPjso/fs/wPFPcGfK3WxsNkimS9bqnbqhNxrG4LVtWLcXgaFb69KibPR5B5RLGj8hldZGY2Bk2+TR1yyXUMOCrlSFGjbWgvgUBLCWGJUFjeV2HUN7qfwGuZL7g8OXLY2m53bg7aAzV/gdmIgfzQHde970vb0nr0DpFZY24ak3fnhlw8M9ZFpMSRf5AfGbL944m53cBZ/x5h55DAZ1PAh74+k7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+V2LfAzmGag0FOQ3z19fdNnrGnx50AbS+LQD2VJ1moQ=;
 b=2GG0vGYar8I8EWVzxjo8buKvi1XzjHDHHbhOGc1vpkQ5H2fz9oaQ7UbBFZcvBhcTFtC0NZ8BJ5uWdfW+yEK8/4OACPTQMwWpoHPsVqqDNn87001VtFk3DV8Z3JVp3Xk6z2MJ+zvsrqqfi9L6KXBAgKKha+pRkSa9cSjGCK7Mzns=
Received: from BN9PR03CA0265.namprd03.prod.outlook.com (2603:10b6:408:ff::30)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:55:03 +0000
Received: from BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::a8) by BN9PR03CA0265.outlook.office365.com
 (2603:10b6:408:ff::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:55:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT077.mail.protection.outlook.com (10.13.177.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:55:03 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:55:01 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 50/66] drm/amd/display: Set DRAM clock if retraining is
 required
Date: Fri, 14 Apr 2023 11:53:14 -0400
Message-ID: <20230414155330.5215-51-Qingqing.Zhuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT077:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: c73d7917-1a01-4aa6-5c72-08db3d009c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sykK9MbUZVGoWAacyZtdVXS+1mR+nj4twu/53GapbcPWloaZbgVVdG8I/g/apsZT9nuzMtr0ubitMJtIOfDDqE1+ry1amLMbKBUdAPz7WYZkD+rs0HalEs5pBxVtakBgCH7P57+Ykfu9ugft2cxpaRiMfzgrND3Wb5pOCdlnx27YVHC0B6zoDYn7N2wDczYoO1twumxexJSaP+pjyZjgdlS94NJP54hBeQu3tIqu3Takd4ghJz+tRJow8rrDb67GT6PmkqfkDqEBbes02DoWeXlqUqZ/7W2oaTZ7/rf0equI/sNyITrtiGd/gofWf+ITDjKdF7i/vteM/k8fCQT2iyL6lZxKXLGxFtaOGO+w9QrYeA6UJgZ36iDtyVg5b2j0ZrfFu1YTm5DUiJMhX8d0o/2AZ4WjB2HRtyzNFGRzKpt+UnV+fcw89dapXq/YrMjzfK/cmKpBRn5fHbv6PO5yWFqbpsPky+23FSMqyhZFp0/3p22ojDWPJwemfM0OaYfnrC5ezv3ctlHTX/udNx42GfI6fYSCVrb8bmPJ3FADSg2MPDey08fxrqPzR6PXPR1vQpj8WU/3Zq7b+Ddn/SJidLEIH2Y0T6hqKE1Wo431oRl2bquL1v5qGCoN0YuxPHe6lePnvTizoxSP/K927FgMWx75ha2QjkuPo4GAg9h+ztAZBmeUiyTyt0Z9HGF1BrYtrrLtSnT9Pj5DOq8oLIPfWO0ZtA7hrQ2yAGMBrv8hf00=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(26005)(336012)(426003)(1076003)(54906003)(40480700001)(186003)(47076005)(83380400001)(2616005)(16526019)(36860700001)(40460700003)(6666004)(5660300002)(41300700001)(316002)(8936002)(82740400003)(82310400005)(8676002)(356005)(86362001)(81166007)(478600001)(70586007)(36756003)(4326008)(70206006)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:55:03.4591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c73d7917-1a01-4aa6-5c72-08db3d009c53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Set DRAM clock change state if retraining is required.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index cad2bc3aea67..d39e77d95fc3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -4338,7 +4338,7 @@ void dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 				+ v->WritebackChunkSize * 1024.0 / 32.0 / SOCCLK;
 	}
 	if (v->USRRetrainingRequiredFinal)
-		v->Watermark.WritebackUrgentWatermark = v->Watermark.WritebackUrgentWatermark
+		v->Watermark.WritebackDRAMClockChangeWatermark = v->Watermark.WritebackDRAMClockChangeWatermark
 				+ mmSOCParameters.USRRetrainingLatency;
 
 	if (TotalActiveWriteback <= 1) {
-- 
2.34.1

