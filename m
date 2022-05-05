Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384D7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3136A10E44E;
	Thu,  5 May 2022 20:08:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C9C610E20F
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyL0XV6idE0X19Zy5BpW13+0s1zoRVg72uok4Ra+de8UzbCYerZs2ksZMuvRj366pHPi1b/XsCKzIa1YE46CrYMGcmySy5iQt4mnj5G9M77PYoze9FyBiJdHQZmpmnK0tKQABa+8WkGbCh5FN9D/ajcr6py4f9m/Tyo6fjghW0NL96CkL9Aey7V8VQh0qu7JrlfVJ7UI5u4lqHXQl0N7d0XOPxJvq4HSblq1O/sZW68WLkfnxPBYgueQF+tWP2IqPXnAub5p9CSClXrWSO76gdCxYiuQBPgeY0D3d439i1qyIj+/clMyI+2YFcHAHwvLfXlU+M+FPvI9lfkQDc7NXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NlzMJbKXGpRpq3J2bAecjFcW7D1X0UmgZcrxkBmYRE=;
 b=Whke/DRu1IOTe28+DbtS+eTwVXqfzn9nYn/RrMUR7BzlzkU8JYXE9w3eNig39nydlOvMAzTssPFqvbLeo2D0slE7XJHY9IMAzFbIMzuJDBh+6joQNdHS0Adom/alME4lCmoY4UfUzU1m4By7SGsbEAlIrRRp7EMcsb/XIWH39iS6w+kTu+XGOS+el2qUPbSgCHUlzUOx25qjFga2H1rbqu/vjBKQhvs7Awer6JevgI9ggHEsKL45cy2CbjbYDLFuPbwOgCBkMA0f9+pwGTvzlTORYUd8Tg+GUBEF7PnKq5z+6aS6VBIDbZiTS+vYCGESdtOQSwdVbWZM0jNiULIK8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NlzMJbKXGpRpq3J2bAecjFcW7D1X0UmgZcrxkBmYRE=;
 b=s7nxWvn7RFJrwxE1/VA/EhKQWGeXCYtWD2rEGd8QMSNg81E5QnexExyd8+ALUKU4kVaDPluhwEp/MIDDrKtlYsMCsIF2l+2zgsNNZ1GipVDdtKil4as0GbM0iAWNhO9JsqTrg/hB+aNypnNZHD3uqBJADi41vUlBVCiXxZQtFxU=
Received: from DM6PR06CA0039.namprd06.prod.outlook.com (2603:10b6:5:54::16) by
 MWHPR1201MB2559.namprd12.prod.outlook.com (2603:10b6:300:e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 5 May
 2022 20:08:35 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::c8) by DM6PR06CA0039.outlook.office365.com
 (2603:10b6:5:54::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25 via Frontend
 Transport; Thu, 5 May 2022 20:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:08:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:08:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: correct the way for retrieving current uclk
 frequency
Date: Thu, 5 May 2022 16:07:41 -0400
Message-ID: <20220505200750.1293725-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505200750.1293725-1-alexander.deucher@amd.com>
References: <20220505200750.1293725-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c99f3e3-c1ca-493c-f6e6-08da2ed30922
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2559:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB25595A7938A0F1E6923F3CC0F7C29@MWHPR1201MB2559.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /AuLBD1KqLg9W8F4hIIhizGC/OVXjy40O/OQvoNnwVXGBshkHlcJ0q+pdwNm3MHT0pM/zL7bzYwXDlok95Txo3Q9prtwoaay73yRLR1z4BDcEJU+XfiK/5gTxT3tGMPwK3FtCeMoTPkwyP+i03nAPTFR23E8ntOxcdK46EvYiYYR4j02No7swCDvLmEn1oe1tAW8cO7swMaad1e2nf6Wq8BIonDHw5ZAqe4yrvzfwlT32xqw8skTceprCC4l9sjsLy4fz6vMxosbilSgX0sikjIm+t4kFUeBOdkbWPp2oxHP0nNjo2LLSVfTajoDMoV66pAF/C3c6Hd2wcXH93vtUDDMDU/uHK8STxbPF8nSor3e2f8IUuCeJ6uZxJkIIGefFXTwLuSoV3hO6pljhQ4ybpwZIZVywuP2um4ChYhXVZOAm41rso49KTj21syCXnnbkWE1zsqEwype7AW0cSiI3RkgPkQzP7S6Gh6pw1yeR758ekcZODhe6BJbDG0fPgQ25mUt+Ud1gKIw7jz2gWP12edKaGSxx+ZvlNkn6zKE20UFaMcL+5hO4klOfeW7q+s6KMjv/H9NpoLxBuOLjL4+Ni3VZ+qegsDs69Q1WobVjZzCXgR9i/FSChexqOekH73lLWJGdQ7L8pLoFVddQhyjvUJA2GGv3v29luQhhfCeqKCseBu9ViVvyiM4ueq3xV5OvwmGgv+uXKfMgo7U9gl7Yg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(2616005)(47076005)(26005)(6666004)(7696005)(1076003)(426003)(70206006)(336012)(86362001)(83380400001)(5660300002)(8936002)(4744005)(16526019)(40460700003)(186003)(36860700001)(316002)(82310400005)(508600001)(6916009)(54906003)(81166007)(356005)(36756003)(8676002)(4326008)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:08:35.1516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c99f3e3-c1ca-493c-f6e6-08da2ed30922
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2559
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

There is some problem with average frequency reading for now. So,
we switch to the target frequency reading.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 3fd0ab90b566..f01227e5e96e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -849,7 +849,7 @@ static int smu_v13_0_0_get_current_clk_freq_by_table(struct smu_context *smu,
 		member_type = METRICS_AVERAGE_GFXCLK;
 		break;
 	case PPCLK_UCLK:
-		member_type = METRICS_AVERAGE_UCLK;
+		member_type = METRICS_CURR_UCLK;
 		break;
 	case PPCLK_FCLK:
 		member_type = METRICS_AVERAGE_FCLK;
-- 
2.35.1

