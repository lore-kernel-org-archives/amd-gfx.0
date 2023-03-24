Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A21C76195
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 22:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E476310ECB1;
	Fri, 24 Mar 2023 22:00:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA2B10E295
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 22:00:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jf5RlWZjwVXX8PuUT77P63n54mr8ow+ZkzQAwgp9bysPCBV+wtLWDSFjWdg6qsl2yHqmtLbAOca0GxDSpza70Olk4167LbDuH+nWGR/QNs+MtYBUx+88qjA7Xb4T3WAn5UjPPb9fGuBkI/IaR7mUCRRKfJdl5oQ5fWrw91FxnyhsEhLWf/Mek2T5o66ehUyuL/0fzGkaBfYG2zBNOjkCnKFndEkL2kpdgO0+AvX8116J0xO53Q5BHWsNNPxcGj0Kj+KYTyhTHEV9vCFpbtvjNdteW+2ioiGkuerdDvnY7BYo59otWwtNOwx6xZQ6n2XHww/qwU3R/mVbwZKLn9weNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wkq1SqX6qAMpnVU36V1ECc5N2TNB4uw22/W1neSOsOs=;
 b=MRGIS5gkJLoLzjPjJae0xHFDVA0QbruRKIcwxyF9QN8ThGHLZdfJdRqhHYeBZNZwTiF+lF1qbqrHpQ27yqaxmc2UAyIcwLmqUqgHQ36/1Vg282Bvsm7GKAncXgZBR+lhGFKk59gZTqwKbD203+U4vPJw5A6fF+XtzmLDpLrwWoE/jg7nVpskuVSZOqzRTxTwExRlABJh7KUIwtOGFYRazr6Izo+5UcX9TjdjhzPrclfOvu9U1cmDb0ROl7BVAT0gdpGs+xj/wfkA7mzfTsbbYbspGC0qG8zXmGPaK4DGQNaWTrTYJJy+owMrVKH2vZ6MPBEqGaF5HvDiOmamnLtbsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wkq1SqX6qAMpnVU36V1ECc5N2TNB4uw22/W1neSOsOs=;
 b=mBaLKzPWn8Ya/GAk/KoeqyKbSKbnqL0onBK+S+BWKR7O7D0DPTvdX3n8D6WC3rqkT6JN/zbCuLkoww6IKVD2Sp7GxobNDfjEEJWzOUfmguJm+LU08ym+sxYjxGSLUHJ88O0JtNpbOcXwFc2KTfez9SyVywP6o1w6id4DOS1zsuE=
Received: from MW4PR04CA0323.namprd04.prod.outlook.com (2603:10b6:303:82::28)
 by DM4PR12MB5868.namprd12.prod.outlook.com (2603:10b6:8:67::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Fri, 24 Mar
 2023 22:00:10 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::41) by MW4PR04CA0323.outlook.office365.com
 (2603:10b6:303:82::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.40 via Frontend
 Transport; Fri, 24 Mar 2023 22:00:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Fri, 24 Mar 2023 22:00:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 17:00:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/9] drm/amdgpu: initialize gfxhub v1_2 and mmhub v1_8 funcs
Date: Fri, 24 Mar 2023 17:59:48 -0400
Message-ID: <20230324215949.2560463-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324215949.2560463-1-alexander.deucher@amd.com>
References: <20230324215949.2560463-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|DM4PR12MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f5597a5-e35c-4ca3-9513-08db2cb322e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SM/8lGnZTNXwhiz+tbcy2XgMvsS4S2UYX+67YiHhYu3ahLe6NU70P5ZIzs4LcwP6Nt+G2Y+GoCB2ziuNcHicXV2xeM6K+B7ec3hGtQQH33LNpWjOy7B4znTlcjxBeTjYPCqb1fxCWbe8cBnBQfEVc0Mqe09tuxi7XoqkliDcnemV54MdbdbZyRfIVMHvRXXxxYx7Egt69UBVMKpIb08wU/UOe/blvkEWXAEuOYT7DaZG0iQiGKZk6AvK/mTc1eXXs0HIWT+dFcg+HDY9cSJbRh5hcvRisFcMHnBtNCa3hmu0ijjLd26GlyOi6O9SYzA7cxkq1DmcxuJXlSRLgiV2790vVvXobvGaqfrg85gjRoC4IPJ4YjqEP0lMN4YIpw/5i+dflHq5w3wXd8KsMTDvx839VBIuW3nDbNwOkGQ2QIz0UxyIjjmgNbrQjRPcfm3A/XQWpDCAaAaWAaG9pya5GNxUQqnZbxhKtm3H8u4gvT8+fZc34rFNonpvJOgkHMX4QI1oZLpuRT0eVDnT+07Ovtv0JUkvTOE2wn34Lf48NW80z8+px92FfV+8qJ5Y37Hx72bQBJnyRBzRJoGjjM0uVDGdh39Fq/053eIs2YjyHl1Fm1Irtg0ONh2gqbVV7WRIfOQFnPHeR7h+KiTW3AEDyCRtDZDkq2K/mOAi6GTvEpwGEZz8vW0Kopod6kUHxukFAR0PqVNwzVJwhLkWv1sRA6g3B44myWEfNhdlvqO6Io=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(2616005)(336012)(26005)(81166007)(426003)(1076003)(478600001)(8936002)(186003)(83380400001)(7696005)(16526019)(316002)(40460700003)(86362001)(36756003)(47076005)(356005)(4326008)(36860700001)(6916009)(40480700001)(2906002)(70206006)(54906003)(82740400003)(5660300002)(41300700001)(6666004)(70586007)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 22:00:09.7446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5597a5-e35c-4ca3-9513-08db2cb322e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5868
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Initialize gfxhub1.2 and mmhub1.8 function calls

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 681233ed2843..67ad92097a65 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -49,8 +49,10 @@
 #include "mmhub_v1_0.h"
 #include "athub_v1_0.h"
 #include "gfxhub_v1_1.h"
+#include "gfxhub_v1_2.h"
 #include "mmhub_v9_4.h"
 #include "mmhub_v1_7.h"
+#include "mmhub_v1_8.h"
 #include "umc_v6_1.h"
 #include "umc_v6_0.h"
 #include "umc_v6_7.h"
@@ -1332,6 +1334,9 @@ static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(9, 4, 2):
 		adev->mmhub.funcs = &mmhub_v1_7_funcs;
 		break;
+	case IP_VERSION(1, 8, 0):
+		adev->mmhub.funcs = &mmhub_v1_8_funcs;
+		break;
 	default:
 		adev->mmhub.funcs = &mmhub_v1_0_funcs;
 		break;
@@ -1358,7 +1363,10 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
 
 static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 {
-	adev->gfxhub.funcs = &gfxhub_v1_0_funcs;
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
+		adev->gfxhub.funcs = &gfxhub_v1_2_funcs;
+	else
+		adev->gfxhub.funcs = &gfxhub_v1_0_funcs;
 }
 
 static void gmc_v9_0_set_hdp_ras_funcs(struct amdgpu_device *adev)
-- 
2.39.2

