Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730ECC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jun 2022 07:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93922112876;
	Thu, 23 Jun 2022 07:33:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF7C310EC18
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jun 2022 07:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJA9TU7mbHqY8sPoPqmocMT3aHrRsYwBurmj2fC0naLVhSWPLwQJLpxfDTHa5Zpm+ahi1PpfSPqh/xY/prhC1reKfInBRG9U4KE7yFeiTlzoGeP4Nf3aimHp5i5bn0MowDr1emSEqWbJ1jPpqIoBmQdXooWO+JAN59tdoefXuRxtjLdKXw7pq1Ze7YMNf8zTtWNYI+e5KxwebIuEkXfwOiZNW0Wg48ta7uKynIKu7oAGA3cAr2tjB4tItblHrfOhjy+CJU1bgZD5/SGS0zjmK1ZfS7FBRwqlLwQ4pnrRRAdRLB2Wxa3O9fEpOLj/tGa8g3LEoylL4TGx3UsxIDUynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBerbZKyxzRjWBSk9xNXgRADwLYyGAVCB7PZyP6kAe4=;
 b=jqo5x6c2XQPMs17AAdZhjVvdw3I4GAuX1viw//evhIzjTms10cCT3vCu1so0QMGGG5S5j2feovgvvevZlvH5tQI88oV2wJhVsHmO/rn8fTNiVuGUZftAcwFEI6Iz9ejyIOoElbXSD3zjvDrp6CMIPCSPVY/PlDaAJhHkrpN64RziHHqgTR0COSVIBhgy0eYkbOhPq3d0S/cuLQGnjwTVOz3hEaccUnrLLbUB9bIU5ObaiNlX6Q67AN9F+FQqnFOE8xq00Vb8tsIGBcWm7ymFy685FUHlQO178PD47VIzZVgj05WWJhXRvRc5KRxyDO8g/XAY7tOXFMVZ6VMifa9qJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBerbZKyxzRjWBSk9xNXgRADwLYyGAVCB7PZyP6kAe4=;
 b=l6AAraybnelC1s5u5Lpp/qg0BbH1HxnbiXdaIYTb00a0xIgdTTkMAEEr90teEe7BgSKTM05nGDFvUg+NRxUgcCNHyYFIuambZQYDusH6kLH+aF2mjlawA6spmJHrv22JImNvm1x/d2x2LBElvIqspqF4bfwzzLhmLzcEqHYOCzE=
Received: from DM5PR04CA0026.namprd04.prod.outlook.com (2603:10b6:3:12b::12)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 23 Jun
 2022 07:33:49 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::b2) by DM5PR04CA0026.outlook.office365.com
 (2603:10b6:3:12b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Thu, 23 Jun 2022 07:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Thu, 23 Jun 2022 07:33:49 +0000
Received: from ETHANOL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 23 Jun
 2022 02:33:47 -0500
From: Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display : Log DP link training failure reason
Date: Thu, 23 Jun 2022 13:03:20 +0530
Message-ID: <20220623073320.2632780-1-chandan.vurdigerenataraj@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c9e911e-5f01-4fa3-fa66-08da54eab6e3
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB6095119CBDE63F10A54A51DA96B59@DS7PR12MB6095.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/VSvsghg0G8NzcDWeYSBjSrDP3EQAMnw7vGXp3C5sCIbd4RzlF2sZoM2cd3tebDz8r4d/AIEFit8vVv4xHecr/z+Ia64NUJn4B8dRgH/4Q0LGdH01qGfEgXP3oZmSBIaSeayuif8XBjPbraiNQT4+FHcBmdClkEL9X/CR21rkO7WMHif+um0zibaRTwdGIHOJQdjSaWZzfyMc+xXs/TIhel/ZFaJbY2xRhnSrC+foKwDaW2En1W9gEwFjLzw40S9pyz7oWEWw66FGxsjm+R6fBsVaxwDhmxAUCCJSIJNqUm71bxT4zq5Qh3YAtXE76FEpsLBEVaTA0tsqEIx+750Y4Xa7S7f+drBRZcyHLGpH5wTyxU3lV0FTAwuZ1SIzAL4d0F8Fp1RZp7lVMpa4f+h+IS0+ZQSP0by4GwsFr/a8Nw3hbts9TrdyOMWhP5Of8ZFs+r96lpQaMGmkd4wpT2ZlgiJ6+ttAIPVdROI/y7aWTbnFb2abZyh9rcPoC+FiSA1Ch4hvpIHNOyPvCCA9UKwCfHLzuZmNxVQyy8epG+jy+XEoycQkvEPH5AQ7N7GKhez+fugHn4BoPRfdfGAHwn0J7WEcRTePPgPYXfypKZRqBM52XrvHVJsNjHdR9QzkrW8aYkl/dSIZqVBHnp2eo4+HoHLyAuFnH9KwKHEK5q3biAYdowO8HIXBzdVNo9XUoG7TsjNgOwen9826u7wcrhRqfGn6+lcaA5cAmIGSwtkfdAZZbLzdajkpEB0dGOR/CXbqu4N7wq9bXZ1kXZexjPRk5FjigsQUemcjnYVt3jLxY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(396003)(376002)(136003)(46966006)(40470700004)(36840700001)(83380400001)(2616005)(2906002)(86362001)(5660300002)(36756003)(82310400005)(426003)(70206006)(8676002)(110136005)(1076003)(7696005)(356005)(40480700001)(81166007)(36860700001)(82740400003)(6636002)(186003)(47076005)(478600001)(41300700001)(70586007)(16526019)(4744005)(316002)(8936002)(4326008)(40460700003)(54906003)(336012)(6666004)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 07:33:49.2883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9e911e-5f01-4fa3-fa66-08da54eab6e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Existing logs doesn't print DP LT failure reason

[How]
Update the existing log with DP LT failure reason

Signed-off-by: Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 4027f439a5a4..c8355acd3672 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2786,9 +2786,9 @@ bool perform_link_training_with_retries(
 				break;
 		}
 
-		DC_LOG_WARNING("%s: Link(%d) training attempt %u of %d failed @ rate(%d) x lane(%d)\n",
+		DC_LOG_WARNING("%s: Link(%d) training attempt %u of %d failed @ rate(%d) x lane(%d) : fail reason:(%d)\n",
 			__func__, link->link_index, (unsigned int)j + 1, attempts, cur_link_settings.link_rate,
-			cur_link_settings.lane_count);
+			cur_link_settings.lane_count, status);
 
 		dp_disable_link_phy(link, &pipe_ctx->link_res, signal);
 
-- 
2.25.1

