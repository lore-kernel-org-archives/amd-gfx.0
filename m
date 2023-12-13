Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1065FC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 06:13:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAECB10E6F2;
	Wed, 13 Dec 2023 06:13:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFBA210E6F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:13:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmWYSO+tzny3NLozK4czhGpfXkt6t/ZAob2UiSYdCEn9bopBOM+nGIi/HZCpuulp1UMbak841MMFshbMgtMaXEwfDHdFgZGzMWJMgi3pW/it+lant5cdXosyRWb5vh5AQti/M8kfWtWRa5M2c76wjhjsxombstj/Il7A64cjnZkoeNYdvpWuJaW7TNyjzHmNPHWa8tnKMb1WsND9fllz9j5RPcRFJCqsn4lwng5+sEqLovA+E0mDjrN4A0duJzwlLboWGao2M786lyMHbHM4IvKNrUxYZcGOejyq2Le4bF176YZOiFDi82rW1EILBq/zut6AQqeOAPSg9Knv6DeENg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GR2cjXePNmUakPnZUDgGG2eDa7F3VJ48ae2rHGl2ONo=;
 b=gfSCxxBbF9dlgK6eU8OF+wtrMlfjcK15a4yEfTZ8YwacOAsxSHBwXfAnfuAQFlF1dwmhlFWVXDxS+ZWjE9+WW6THjLQr5BNZnSd4SOH7HgpboxJKJX/70HgGaa8RzmlZaANWQ/FbFxNQpgeTPCHrIto2f22QNKK01JWCW99Ef9bt2dURr/0ziAK4PqZPMLiYuLeKjp0SrbDQYNusyaoFqkngEO35MdJnuepBSuBW5uim8k3CemjUn7Ay11RkvwovOMUNGmvzI84FTQNQOs+35HfmhYpqneIC1xahxG4kvZypdiBz+9+sXUmgCLDFVTiJOmIgKQrg+U5045qxMJ4S3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GR2cjXePNmUakPnZUDgGG2eDa7F3VJ48ae2rHGl2ONo=;
 b=aK/3/lF/x7G7Kh308lP4W0YcoShGuDlL24J0bJ7YiZNVrDF1a4c0WIBpVBE2vNIpfV4O/NsFBL2aU68SosreBC7l1we53ia7rN5qDqnF6uKqAOiX9Eaaxd9tQ6RRqOJaaJQLCxiuwsOSP0k+YOSa93IoWINXwgmELJ0hCnVY4z8=
Received: from SJ0P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::25)
 by CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 06:13:53 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::90) by SJ0P220CA0009.outlook.office365.com
 (2603:10b6:a03:41b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Wed, 13 Dec 2023 06:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 06:13:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:13:52 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:13:51 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:13:47 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/25] drm/amd/display: dereference variable before checking
 for zero
Date: Wed, 13 Dec 2023 14:12:12 +0800
Message-ID: <20231213061227.1750663-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|CH3PR12MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: d801c605-8dd8-4d53-68d0-08dbfba2ae86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q62Vq5GjWDK5aBlmrwBGdedL+VB3Zd3PDwCwrZ+vMOwhsJUIXXAxRu3DSFv/aIzD3dipV2KpteHUTb3Xa7UU1D/TD5KB1nAo1Apr8FvBjY7WZSkJDxxKKMu5XtK2mrCxY852inoO+U3HGTpxj4Lm4mDqkjuCdYlq6y/2qRgQPAjqt5lcZjIvz9XkNNsM4NDX7QmBCePD8nGhLzMevHd6pqq7DrRr/yMcLn8wOAgivYZvE5pv3T2ISn7FgJSXm2HqJtYHVhJr//8dQalDzgi6r5eFAldFj/HtD6gu5oYgesg2+mA2mfRmLe1OkHiYpIeHFbR1GRWXSOG9fW1ZEJCnU1UfmDBetxr0gen1IqiDu699FVeri8B9Etp964gO+hbt3o669toJ1zax3ti7TurD8zghlwk9XaWg4nOo8/cpoFIIGc6d4B6uSPtq704PRumDr/Odd2VX2F/jj2J2hQt7M3YfoGNr2DGZlcqkd14MMzwrEijyu8zFsvXFfj2E6nuY+GR93P88ZkbIPhJ9RMIfYYfjaV1NlVanx2wD4v6Wd0Tc/rG6gNxNsrwudOeOUQlrfAqG1LIwR+7qcEUyrsiFQtNCEW2YIDTT9ycna3+m2p1EVnRzOUrHtiTK0KfvumFM8rbTGa30i8lLIFjY3Z/uPgQmqps3oTWgZaG9G5MDlbgSUUJXKCIcRa1bRfX4ajURY0mJsOx8YzGUjgZ+3Qme1QHaE7S7/h4uMFm/sVaEPgwXuSSpttKoSGICBTNTQitoXf37BIbqko6VflPm7J60OA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(1800799012)(186009)(451199024)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(336012)(70586007)(6916009)(54906003)(81166007)(356005)(36756003)(82740400003)(86362001)(70206006)(36860700001)(47076005)(83380400001)(1076003)(426003)(2616005)(7696005)(316002)(2906002)(6666004)(8676002)(478600001)(26005)(4326008)(5660300002)(8936002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:13:53.2812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d801c605-8dd8-4d53-68d0-08dbfba2ae86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Josip
 Pavic <josip.pavic@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Chaitanya Dhere <chaitanya.dhere@amd.com>,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <josip.pavic@amd.com>

[Why]
Driver incorrectly checks if pointer variable OutBpp is null instead of
if the value being pointed to is zero.

[How]
Dereference OutBpp before checking for a value of zero.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Josip Pavic <josip.pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 180f8a98a361..b95bf27f2fe2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -5420,7 +5420,7 @@ static void CalculateOutputLink(
 					*OutBpp = TruncToValidBPP((1 - Downspreading / 100) * 13500, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
 												OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, RequiredSlots);
 
-					if (OutBpp == 0 && PHYCLKD32PerState < 20000 / 32 && DSCEnable == dml_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0) {
+					if (*OutBpp == 0 && PHYCLKD32PerState < 20000 / 32 && DSCEnable == dml_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0) {
 						*RequiresDSC = true;
 						LinkDSCEnable = true;
 						*OutBpp = TruncToValidBPP((1 - Downspreading / 100) * 13500, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
-- 
2.37.3

