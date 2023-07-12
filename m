Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0B2EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:14:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 488F210E5AF;
	Wed, 12 Jul 2023 17:14:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B858410E5AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:14:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZaue5gsAZ4+JoODBDyQE2OlQierqtT5AXxVWKiiJrfYdviMr4sgZA/f6NBaoRWlg5C3gsV7pBgdtZmXz/hH+RLewUKDXBfZE+Y6bEEdQ2fpg0VWmc1tn9WX1ByLM95F2k4V/mw2fim8jJVz30ZnOC84x0hTnmASMCo+XyJdSuCoJRXA8eNB7Hg47HUGDCd8gvS/l8jE42LR/cxmRBGZAX/e3EArI8uI7gZHaeLpoRbni2Y15oXUqP5YFSRD1UkE+xtoP6YZiaUpo41CWBt77opNLpcSyVXKZzWvwoC39EWIxtujivrda6K+xRFBGGa90YtbL32cJ2vM15uVrUuDAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8reA87/psyIcFsSOZuti83vbhX4hg6cBz4Ej7S/admU=;
 b=Ti9eaUi4eKJrnaSngIdkZgMZy5/d/IOjYmXUnlZF2lRmvxDzzYFy09dvcOqaNrBcCXwMkvsHJ4JeSHDiDURE1BN7K9KwVVYHjypdK03e2thFNij/2iWCGVncjQDOmPBPMJDwuyy1x/P3+rt2OuC4/2Y5ENLFrKXvWmrnrPAEFhbiPchsFq1b3xxvJlC4FjszupYcvERa+F0ZnfKORum3fp/HDwGY16Qu28Y+/vYtMDTuQYXUHRaP19InelMDkpqx/Vlk4lSxZhA01eXjI+894G/QUFQ/u/EI3/QLYFl+PAWXl0IEydrIFhB5wUpLYRb1hHdCMIEnQvH1V6IRzvmI+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8reA87/psyIcFsSOZuti83vbhX4hg6cBz4Ej7S/admU=;
 b=zvFHG13D8jrcjqOIDYd76QC46+NbXA7rR12rZTqoPlG3pJpXqtmQCJw6nNNlCCs5QBAI7wo3aNK/nDMEf3TM1rjHaDQjATUd/aM4eDIwpQQwg+IPbiTyPB8xpYb4emKYU9DIkoVgNt1CqI85rT2mSvT/QYCSJFC/Y1E+2GB0nyg=
Received: from BN6PR17CA0040.namprd17.prod.outlook.com (2603:10b6:405:75::29)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 17:14:09 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::28) by BN6PR17CA0040.outlook.office365.com
 (2603:10b6:405:75::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 17:14:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:14:09 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:14:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 10:14:09 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:14:05 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/33] drm/amd/display: Fix ASIC check in aux timeout
 workaround
Date: Thu, 13 Jul 2023 01:11:27 +0800
Message-ID: <20230712171137.3398344-24-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb46882-08f6-42e0-41a4-08db82fb67f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3C1rEYGTXZo27TJ4GJVuRCxw6zSw9mrHUISbCIqJjGoHNod2n5G/n3NUfKAziUC96RLCejuEZedeATQSQX0Wisx+uA8wlLjgVzimWVIH/7pPRADK3aJzpDoZ236SdyyV4L7XzfRC+ielOfM660eU622fWAaQa9T1932Nq/cBZXr9KnAQWejNQymkBRkdk0jf31kZ6RJt6qf9rcgVMXeV3AxXKedQJIQxnsL8jE/Qzz9klCYuPlKlqlNri1K3YnTz7f81PkBfgpY2mGkS/AUi3ga5T7ygaYA2fFPDFEiF80yNFHxrNyU1R8NkAdb2uie6YPsStLMbgCuOz5iPg6CAdEYpdcQj7xPG922cG4jjtypGZrIhySYk4LYV3HQNVzvXbZhIf1vB6GPlWG08BRiTdJSeT6Mmo8Pnq+ohEUJoMVg0AzCMN713Gcx6ricmmoZAIokPK5+pX8QdOB2g33GCr89W5qekNqdODn1cSNiHIwAIYVmaedChSbsKzLPrxxmIvq7LnrooLb/qSx/HHSXchPhBOn1lBoWq0UsLiauEguoFJScbqh5qwrhqj6gFfv4rItOsi1dHfqReuCHqtsJMQH+oTTs3Ag3GfVj/JtbmLc3LoCz0S5qyIoVapKe51x+Woa2n8dizuv5VVylXA4FlNWE88E0BG+pOjDdxDZB5EwCaeq549rPsa4/HUy7qCtK4dWnL/dc0CT9JdO71uqlyLBv1Zq5lCtN0Lijodhhcw1SikV72c99OFf7adh2PslM/wktbbcJbEoTozKdPXW9EqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(336012)(186003)(1076003)(8936002)(8676002)(26005)(5660300002)(7696005)(40460700003)(41300700001)(86362001)(54906003)(2616005)(81166007)(40480700001)(316002)(426003)(2906002)(83380400001)(356005)(4326008)(6916009)(70206006)(47076005)(36860700001)(70586007)(6666004)(36756003)(478600001)(82740400003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:14:09.5051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb46882-08f6-42e0-41a4-08db82fb67f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Taimur Hassan <syed.hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Michael Strauss <michael.strauss@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <syed.hassan@amd.com>

[Why]
Aux write was meant to be ASIC specific, and is
causing compliance failures on newer parts.

[How]
Make workaround specific to single ASIC.

Reviewed-by: Michael Strauss <michael.strauss@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Taimur Hassan <syed.hassan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
index 0fa1228bc178..0f19c07011b5 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
@@ -427,7 +427,7 @@ bool try_to_configure_aux_timeout(struct ddc_service *ddc,
 
 	if ((ddc->link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
 			!ddc->link->dc->debug.disable_fixed_vs_aux_timeout_wa &&
-			ASICREV_IS_YELLOW_CARP(ddc->ctx->asic_id.hw_internal_rev)) {
+			ddc->ctx->dce_version == DCN_VERSION_3_1) {
 		/* Fixed VS workaround for AUX timeout */
 		const uint32_t fixed_vs_address = 0xF004F;
 		const uint8_t fixed_vs_data[4] = {0x1, 0x22, 0x63, 0xc};
-- 
2.34.1

