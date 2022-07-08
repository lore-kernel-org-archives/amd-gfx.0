Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0013C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 16:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72C7A10E201;
	Fri,  8 Jul 2022 16:36:19 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2051.outbound.protection.outlook.com [40.107.212.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42D2D10E225
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 16:36:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cw8g5EACY/Y74b8+fUPdmX0cpU8KyHvHqLL/1Mn2N0M7bOx3QOmDwiPuozxu8iSuxDrY2VinsoFeRX58IB+fJN10nZapHj7Pg6E4IzFLkuPnM7o2EQO6sP3NzuXZTIuLxA1IZdEIEYJOpcj1wBOregkytkUURwjECn93rzblWHOVZb0Y7oO0lb7N9oId7Fb9L0f7BQbAIVfCveZo+7SW0X2FdOrhmL8hxIlqlAvuxQLg1qFLtrauuGnlODIr15KFZHO30oDrS2v092nT1FdlqyTPE5pp9GXN9udS5ikXU4j7VjGy08Qb8sKqore2QnQ50a/lSxaPzAGTjAX/0Ir2uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHEqhEYyYE8qc9z/ZDi0yn3LV+h6BDGqc7sPkH1uw1s=;
 b=DDO/cHquwKd3KcQu/xWiD0Pdu8iANIqdJqFN0v3RAytCfUt7wB3Gg8hyYKXCwMQYCcEg5Llu202aT78GZoVesfAPqLIfvMR78qI4pY+EHzwfK4HVtUlHBqZrzi991jMimEQKJXH4xmXWj3/7PSGCp8jCMTzR/iHJApTdJu1iyshXCT+nmofgYLmcjyvRVm8Y+8g2jyqMpxF+wQi+JvKA0Gj3iQ8BOVlGE3/YWxa3yCb7Dfy8nkc27jwazfmLdMbeLIamicB74Yzzp4V/fkhxO0TQgakfyxpVv9cvXGq4BKn+Lq8kta9Ln1lXPw8mGGY+1CSE9wUcTULzmU9Cglag3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHEqhEYyYE8qc9z/ZDi0yn3LV+h6BDGqc7sPkH1uw1s=;
 b=4N/xyDKI3xA+AY7I3LhfXnUwPCJwNl2hWTvXVd6GzEciCgEbfp9MpdbWlF/9h6Et8RvtH3svyjOoqaajXVZERAtPbLngiNC8rTCnjVlCx3KqSVFUV2htesaNOYoeofEx7vukpCzTFbEWBtdRiPM6pbBpP56/y/bvXvfX3UZErWE=
Received: from MW4PR04CA0106.namprd04.prod.outlook.com (2603:10b6:303:83::21)
 by SN6PR12MB4751.namprd12.prod.outlook.com (2603:10b6:805:df::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Fri, 8 Jul
 2022 16:36:15 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::10) by MW4PR04CA0106.outlook.office365.com
 (2603:10b6:303:83::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Fri, 8 Jul 2022 16:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 16:36:15 +0000
Received: from ryzen32.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 11:36:09 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/21] drm/amd/display: Check for DP2.0 when checking ODM
 combine
Date: Sat, 9 Jul 2022 00:35:10 +0800
Message-ID: <20220708163529.3534276-3-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708163529.3534276-1-solomon.chiu@amd.com>
References: <20220708163529.3534276-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a57c3420-41fd-4759-8d24-08da60fffa0a
X-MS-TrafficTypeDiagnostic: SN6PR12MB4751:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZdlqpZJ0YRfHyqNi95UcDIetnbijFtAJI1y2T3D/dv4/7sWZU+SttX2NfzgJ3irxOrEsQTpWSMHmNrgHr9TLezv47g6Xy1Dv8mCd3iHr3HyGyIgYVDV+Q/AsMjtqnT3yBgPzdhkoX1MKw8cdzE9CfhQjb5hur3zS03IuaFwwYUtEcC0Ja8bAgK+ZPVMv6uKMKE8UBWXhr8CtydkgwUg9DiSUHCvESA5pIr/GdDOkAiWA2m1blIz7aPLLT37n+PQ013b/8HAGVcm2TfTBdRTuubH1fMoKTODifzrtPwcYSdk8s7VaHe8Ij31E5rIjcIz8JMCKDQB7KGDp2uMv/XyKKbLfJtvy1fXjnHlP9SCQionIfhFEvkur7QPhUkAivszH+sKlF2Owl1KEm36+VdHLhBxL9Mx5bmYSBGuRtTZYuaNiLrpF6BGahBYLXUFtsnz5z5rD+Rdtwbv4LnIeGtJRQ7LzA6W/Nqqd1BFRhZIR5uDLKNXGbCtuPmI1o1vhlmKOFAWk5KY59sw4ozVowZ0tFOIPTN/DSVBA12f1RFovQx+mllLt4tGysouniAfvK6J8OHpX963r0AnusYaR7ejgZsalrg2BaCcoQb/YyL6aIHgk5Vvj/tDKsAwk9QF+VSj6EH86gfgHhitvK93uHldYOC2mFfp4fec2XDzFw+K3SzGK4kCiowfXmjp14ns4vZiHfYZigrOcT3Qg7Qjh8qBbFxpryP4jDB7Xoq3PEhabvHJNUktSFUG57jo77x+chkWPZHeQYGldk8l5tROirJql4PSXTEghoA9fB+xb7OvQR/tKlSm+MOSv7wPyVvZcL0OgJN/ZvtX2S5iuZhYhxlwBKNDcLEr5LKDmdGbi+yR6gv3Ch4hUssBCwgoS1t7r+b8gKgApllVPvbT3k6zPdGcfg30Ze7P5Ag8SmaoZYsS4lM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(40470700004)(36840700001)(70586007)(47076005)(70206006)(82310400005)(2906002)(36756003)(8676002)(426003)(83380400001)(82740400003)(356005)(26005)(8936002)(81166007)(41300700001)(86362001)(40480700001)(5660300002)(336012)(4326008)(2616005)(6666004)(1076003)(40460700003)(54906003)(186003)(44832011)(34020700004)(316002)(7696005)(36860700001)(478600001)(16526019)(6916009)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 16:36:15.2550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a57c3420-41fd-4759-8d24-08da60fffa0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4751
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
Cc: stylon.wang@amd.com, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
Certain DP 2.0 modes may fail validation if DP 2.0 is not considered for
ODM combine.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 448fbbcdf88a..8d4c1cf1b8f3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -4310,6 +4310,7 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 				if (v->ODMCombinePolicy == dm_odm_combine_policy_none
 						|| !(v->Output[k] == dm_dp ||
+						     v->Output[k] == dm_dp2p0 ||
 						     v->Output[k] == dm_edp)) {
 					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
 					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithoutODMCombine;
-- 
2.25.1

