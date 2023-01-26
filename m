Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85114C61D97
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 00:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F5310E8BF;
	Thu, 26 Jan 2023 00:35:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95B2110E8BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 00:35:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjNLRp/OwhffX5PFlfBgZF+sjA7NDyvOZMQZrAQXsSLBXD7+NCvNTU+q1Dr1Mf7vQf3b885jVeslHB/7M3tHQx3+eO/f6TsEvtb6hmPzBYYyjNIL9Cy+fsH8Lm48kDreLPaS6uDRJE6e9OpU+JK2NCfP8GUEnG3JZf7XK/kkpPOuWYR6b100sNHJTc2AUpUQ1APlQjNtZjiKJciclhdIRedQ63jWoqp/L1g7bXsampoln5vzAqWksfMFxOOClQwrU1YBT9/N8IZr3tAu3iWS8G91aEeY8vN0znuXZgsB0xxLADNFBfmQQGsmsC8c6PT9qsHUu5NvrOB04f0UdIo+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtAPVf9h3+ldR+dS6P1tioKvzrWaBcRK8LE1b/yb4zA=;
 b=oPZ6fHxB4VEGA1OaV/i6uFwftEnKepRBmR5dg8vw2BzZxuYQMpc1Ofhe5JoKpC1XHwcw1sY5/IJLh37sQIhU20BCHbPYALes2AjVwSHG6DKn42q+dWTy1Vzu2PHolZRWTit5ytZOdNNEPsPnQIPAPFsD+ZjkWVL+8t6CUlabYFpfhc4dyuJp9D2CZ5+9t5VxkyZpe4mKtbDJzTIbW5maj1yPxrKMBkvOEUO2IOic/my2vXt3J9Nk/Uk1rISREIAea2tjiUWvTIjL30XydMdJ2tB8GzWB4vqBWpO1zMThxBP26yAVo2/Dwnt+UzBGXx7kS8ABaxKDbFKkyfxuP7UE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtAPVf9h3+ldR+dS6P1tioKvzrWaBcRK8LE1b/yb4zA=;
 b=ATAjR2cvaN0XuhUSr47QCIoWmVkAanyIed5we+iB0NBG2/D8gguy4hYESqaLmQfixvMJPGaoWtAXSOHzZ1jYH6di2f/XyYg8UHSc+8YIIMGPhBFlVpTaUQy7KAYPlFCyOTTZF9KTfuI20bNl9oJ7VjRbkK5bmh3y4FaLrURqYlY=
Received: from DS7PR03CA0343.namprd03.prod.outlook.com (2603:10b6:8:55::17) by
 LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 00:35:06 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::c0) by DS7PR03CA0343.outlook.office365.com
 (2603:10b6:8:55::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20 via Frontend
 Transport; Thu, 26 Jan 2023 00:35:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Thu, 26 Jan 2023 00:35:05 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 18:35:03 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/16] drm/amd/display: Add missing brackets in calculation
Date: Wed, 25 Jan 2023 17:32:21 -0700
Message-ID: <20230126003230.4178466-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126003230.4178466-1-alex.hung@amd.com>
References: <20230126003230.4178466-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|LV2PR12MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e6dc581-9acf-4877-b44e-08daff352bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bFPmtx0F4nUonhFjfo8vZZ+ZlWqEDTyLmcLROTf5wmIuXTc1EndjRia5YTowVkLfRV8m6+yBQ0oZHlJfTWkkN/5kVZY5ayIcffhsUmWX5HqAJBf2cVY4oSI+aZMrBdf/yKitBm5TOQmYikODfzdCJWDtohShoU+8Gu/xuxyLbEybooTbbkT8TvQsuYtU3h5Zf6JXMG89Hbm5b/qQibUD/AsKH3/FuQiFPdXL9nS6QfE7F6zsf+6K4vs6xxsdKA6kTVf5e8F0AMKpva4OZlEERUIHl16ecVl2Mk7xH4V2Kfql+IuA5/bUVhz+/rAQ13ngxvFXAKJFKw7wpt88cgj7FJ3VwSiz/RPi74GgrPwBj0ZL8p7kpIHoWpxZtMPIVdf7GIqs30fv2q13EfnSEsg6xWREHQlpqNrEXnCofvtHcMSEMqgSlMR8pRIKarde3qbgYJDCiPzZSVF95OZ+vfk0RJwBhRVRpvYBrwjoV4d5DIi+6y+fMrNPoXtWct/J0xvcU99YTq6X1i0ML9j6CTtEQri2mDGyeSQ0n19FgqOz90EDWxp3N1RQIbhR0wbb8MPALZIzAv2rBxL8loNLH3f/qsOORY/FSvz8FHFxEWMKG3hJE47eJpRDzNDk3d5FN8SYy2bm/y+zqsoQny0ZID7v3pNIDiWikVxRoFL42012bvdhf6UCFHlVCX7Bf3AzAlJlCULTtMhLOkwqDfv36s76YoYNdxsBB15tNmbmSRY25S8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199018)(36840700001)(46966006)(40470700004)(36860700001)(26005)(83380400001)(81166007)(5660300002)(2906002)(82740400003)(7696005)(41300700001)(86362001)(44832011)(8936002)(82310400005)(4326008)(6666004)(16526019)(40460700003)(316002)(40480700001)(356005)(186003)(8676002)(47076005)(2616005)(426003)(336012)(478600001)(54906003)(6916009)(36756003)(70586007)(1076003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 00:35:05.8226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6dc581-9acf-4877-b44e-08daff352bc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944
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
Cc: stylon.wang@amd.com, Daniel Miess <Daniel.Miess@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <Daniel.Miess@amd.com>

[Why]
Brackets missing in the calculation for MIN_DST_Y_NEXT_START

[How]
Add missing brackets for this calculation

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Daniel Miess <Daniel.Miess@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 950669f2c10d..cb7c0c878423 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -3183,7 +3183,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		} else {
 			v->MIN_DST_Y_NEXT_START[k] = v->VTotal[k] - v->VFrontPorch[k] + v->VTotal[k] - v->VActive[k] - v->VStartup[k];
 		}
-		v->MIN_DST_Y_NEXT_START[k] += dml_floor(4.0 * v->TSetup[k] / (double)v->HTotal[k] / v->PixelClock[k], 1.0) / 4.0;
+		v->MIN_DST_Y_NEXT_START[k] += dml_floor(4.0 * v->TSetup[k] / ((double)v->HTotal[k] / v->PixelClock[k]), 1.0) / 4.0;
 		if (((v->VUpdateOffsetPix[k] + v->VUpdateWidthPix[k] + v->VReadyOffsetPix[k]) / v->HTotal[k])
 				<= (isInterlaceTiming ?
 						dml_floor((v->VTotal[k] - v->VActive[k] - v->VFrontPorch[k] - v->VStartup[k]) / 2.0, 1.0) :
-- 
2.39.1

