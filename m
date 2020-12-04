Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5088CC4361B
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F072522AED
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F072522AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27396EC7D;
	Fri,  4 Dec 2020 21:30:27 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760057.outbound.protection.outlook.com [40.107.76.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55A0A6EC7D
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 21:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2Q4Tp5WLpzvAa4Vh3Qt7/SLzgGJXkes0nPMjOaGIZFik2bRg4GOBE7+D3NisyGRebWF5Fwj3ZsJNOThCnjq7R/nplohhc7iakHZqa8F6pLH+hXrwMGVbwyDBI+0G9GqYLtAjsW1EIgzh0o19l0aVm429j5lBVZ13J8ZI8+78J9y0cNSCmQ3UjBP74cpg/2CAgiOzYiq+OC72k+6WE8n5elQMqSwLiI57BRkO3oGQtHqx5f8vLNUMMPbYKjopYO8GS0UjOMrxvDqgG2JGv2bdxuNFKY2Dxw7PXHaorF+bXYXlutcen+jkUWSe2S6YJCU+BZi/rUWOe5zcJNnT0pTKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwA1SOO4tyE6ivyrAuf3FrxQ00WhuW23HZR+Kl1d2YY=;
 b=fLcnrtvZi46wXJzzSVZO4nc9Ayl3PVdfVJ3hmJi4LBqebYxCEf8mv0y9IbZRLMoWCSpDJ3/jnqudgySWvuQqbBdnLuz9msFShHrCMbw+KVyL6cz+Fdx0LKjzINIEvG5hr9CKU3xe7Ohq1dxaY1xIsrd4dKPt9KaydQFb0puZevxDOMve8FeCKALZeS/6L1Ral7+l92wVTVRoDAnxID10VcCeyg27AubN1PrX0d+0pCrEemfwol2g3MvYWl3YgXE4lv8Y8IQCEYZ8ovtE1xZ1K2O8Fv7IEZy3u1mcI/Ic0Y0UaSOMUddjUDrDF1ZyoPL7Wl/bANhrzf+hFn2o7wVfeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwA1SOO4tyE6ivyrAuf3FrxQ00WhuW23HZR+Kl1d2YY=;
 b=obJgZw6G1PwPM+8yqsaTZ/01Kwxl04C9/LkVvfwnt2AYdR9yWr07m3RTi14cVH5Hzu1xj66gU55//conxRoESahqz+M3S+4taPUJ0bzpa8Dk3WwCOM9POYrYnKsknTtGuYrNqVsSGuq5UMEs0R1Wzq80Jy2Ag277bhH2FVjrgBQ=
Received: from BN7PR06CA0064.namprd06.prod.outlook.com (2603:10b6:408:34::41)
 by CY4PR12MB1398.namprd12.prod.outlook.com (2603:10b6:903:40::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Fri, 4 Dec
 2020 21:30:20 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::60) by BN7PR06CA0064.outlook.office365.com
 (2603:10b6:408:34::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18 via Frontend
 Transport; Fri, 4 Dec 2020 21:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 21:30:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:30:19 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:30:18 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 4 Dec 2020 15:30:13 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/17] drm/amd/display: Set default bits per channel
Date: Fri, 4 Dec 2020 16:28:39 -0500
Message-ID: <20201204212850.224596-7-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204212850.224596-1-eryk.brol@amd.com>
References: <20201204212850.224596-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcd26cb0-057b-4d09-5368-08d8989bccf0
X-MS-TrafficTypeDiagnostic: CY4PR12MB1398:
X-Microsoft-Antispam-PRVS: <CY4PR12MB13982883D28EE846602A541BE5F10@CY4PR12MB1398.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNxQncOjoEmLxg1Yrk7dcO2/35k+2Rg+nO3Tpk0k9lITWKDlyL81M66C4RxZrOASeIxH3GiviMQIebZzeRFEiktq/C0ZFNLIhJBfPn+QaMtcOLELyKY2xQeIhH0i1uzkb0ukQGZ4/FnmTefb1cg7LYeot+6c9A0jsfTf/tam+Yo41/IK6GwzfjFVVCwSuLU8teB0wM7IWWPHEXJsn5meOlNPFzU75faQMj0O/cdNOff2uPqvD+cfLYPjY2Qo3Y5ttGRTbmfBMeL8WdWDLqTVHhH8i8Cr6YvwGizsGT2X9LsvhYihezGyUqAWkRofxX1fMYSXkOpqFVEbjpspYqvtRy735Q7BFrcwCceGEaThSGZdBB9m4r6TuPfnSNmNN/Z+wQaIZGndUHFLeHw62qtkHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966005)(426003)(70206006)(186003)(44832011)(70586007)(2616005)(478600001)(82740400003)(36756003)(336012)(2906002)(82310400003)(47076004)(8936002)(8676002)(6666004)(83380400001)(316002)(54906003)(4326008)(5660300002)(356005)(1076003)(26005)(6916009)(86362001)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 21:30:19.8130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd26cb0-057b-4d09-5368-08d8989bccf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1398
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Jing Zhou <Jing.Zhou@amd.com>,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jing Zhou <Jing.Zhou@amd.com>

[Why]
Bump into calcReducedBlankingTiming because of mode query failed.
In this function,
timing.displayColorDepth == DISPLAY_COLOR_DEPTH_UNDEFINED.
Then req_bw == 0 because of bits_per_channel == 0.
So decide edp link settings, use default RBRx1 for special timing.

[How]
Set default bits_per_channel is 8.

Signed-off-by: Jing Zhou <Jing.Zhou@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c    |  4 ++--
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index a9c52657eb4b..bd004de107b7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3471,11 +3471,11 @@ uint32_t dc_bandwidth_in_kbps_from_timing(
 		bits_per_channel = 16;
 		break;
 	default:
+		ASSERT(bits_per_channel != 0);
+		bits_per_channel = 8;
 		break;
 	}
 
-	ASSERT(bits_per_channel != 0);
-
 	kbps = timing->pix_clk_100hz / 10;
 	kbps *= bits_per_channel;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 93fbc646f53b..dbbc0ec0b699 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1410,15 +1410,24 @@ static void print_status_message(
 	case LINK_RATE_LOW:
 		link_rate = "RBR";
 		break;
+	case LINK_RATE_RATE_2:
+		link_rate = "R2";
+		break;
+	case LINK_RATE_RATE_3:
+		link_rate = "R3";
+		break;
 	case LINK_RATE_HIGH:
 		link_rate = "HBR";
 		break;
-	case LINK_RATE_HIGH2:
-		link_rate = "HBR2";
-		break;
 	case LINK_RATE_RBR2:
 		link_rate = "RBR2";
 		break;
+	case LINK_RATE_RATE_6:
+		link_rate = "R6";
+		break;
+	case LINK_RATE_HIGH2:
+		link_rate = "HBR2";
+		break;
 	case LINK_RATE_HIGH3:
 		link_rate = "HBR3";
 		break;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
