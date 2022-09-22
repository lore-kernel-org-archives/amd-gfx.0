Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0BBC32771
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B82DF10E9FD;
	Thu, 22 Sep 2022 00:19:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB9010E9F4
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khzxR1w4F1Wig1/jvsu18jBkzeiXiWJUpdkIDybZrnRQBlFZiMf4pj7IGSVXsWgNK3CikndhniPXwgv33F2xfepeXEVxQK9grmpP3budrgTuBJyRZQL9AFwywIXSWM98CpS9Dwc776nd4mpJ19VPd1Ff4q/YFkemV0FskSoM4tdYHcu1C4Uz9CmptY7zFC6eBy95L/vQB00NW19JUMvWk6sLHA7xCQ8HsSSQFnXYv5ucuFMEmR3GSlfJ/2xPoSU1Gs1o6H6RuzwO3WNHvI5TemhHgF0lXH4tE/ZoZxD0DxrKy1vAkySofXaF3XNVGFFJch7aKAg5G+xDnrCZ4IwnHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQ1gHMy/BbmDJunOReYJcO5XtiKyzSs+tfCIDktghXc=;
 b=DNMjfOoxjygyXFu9mH3yNqTok2nA4phJRUmNvcfzMYJQCzd7BGXFH3Wy9f7CTskltBmhELrttF1AmGqaI/zA8+vv8/6o9hit54xHa8imhzTOyxlCakytP1M/RSAFFXG7cCUYplrbMNHDr/XXIvYTtY9aZC9yzHwk0+lrkn9+lCJyUY5J8DUhigETLRE1wl2nmBU06YwNODtc/PapzgzzjnpMDYhAcJvVzW+qXDt5PFA+jOArDVQm1nJb3LLSrxu/Li7UX/gW6ZuIuDZtgQudxm6kAearWybfucmWZj9kuBcqOHkML8uKfeObyniZLCFUtiile0S7K0NrB4fJdUUl9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQ1gHMy/BbmDJunOReYJcO5XtiKyzSs+tfCIDktghXc=;
 b=ik6rOstNvNzsQWRIQ5IujJ9/SewXQtn0j6sj4mEUqdeCqY+IhkNBVDHt4pU+geLIKdKx3NqGev27aNFsXjLSeOLBa5noTeq+N+E4B9nLdCYz+WEFrJo32hWEYJIR3DiK193kKGB1Np6nJwW9I7QU3ohhqL/R489SkInctg+c4Rk=
Received: from BN9PR03CA0653.namprd03.prod.outlook.com (2603:10b6:408:13b::28)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Thu, 22 Sep
 2022 00:19:14 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::9b) by BN9PR03CA0653.outlook.office365.com
 (2603:10b6:408:13b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18 via Frontend
 Transport; Thu, 22 Sep 2022 00:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:19:14 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:19:10 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/31] drm/amd/display: Fix typo in get_pixel_rate_div
Date: Wed, 21 Sep 2022 20:18:06 -0400
Message-ID: <20220922001821.320255-17-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e5c61e7-dd4c-4e76-3ad3-08da9c30147d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GPGQVy9P/EnuPU7SHod7HNL6vPtxaQbURyA8mboN5rA6o4oUWpamvC5K9+vVPiM5QhNSDZ/dOKhHKxkF5+4en0+VpRYuoqlFlhOoIH1bNedFsTKW70MdJDZCEOZyk3Mro41lRZeChg1f9f3RrBsxWnMma6WY/+Ri8bkDZdFswvfP4vl6oxriLwy6P/Rvi6vj0OLOpA9+94MqfjnwUHjUWSIt2s4WKS+Uh9y6Kixzopoz+BJMEulEMTorfJzOSOjp2FaWhtITCO6274iBP3PdATXmnnft2B3IyeUjfW+lvoKP0cKNHvUPDxCosPB8PRHp9K0QB2Bwu9kDAFuJaNuBJikx7VzIOlIWONaRnqSABZxRE9JT5y+lTRP47EwUrplTHTpoRiwHBViM5FEXyELQaLTmgn2FU5YOfhjQrF7tZYVpdmvg0pwVb3dluoz+x8LwXpKlmdNsIXZPmEHY1kT2F2QRf8g3jtp8Y9swXuz/2pzqQenpoMfSpwuEWr6YV+xeOHVqWhNlgBuHp3nYaBzQczrDFl2KJgQTcyTRTv1Q6DJKahEI73TzeLvHNlyMSilHluhCKu6In7F9bCG01sGrHWQnDMmkX49NyFHbDw19wfjWcfCBaPip2d+Zd7mPQOX5Xvxa16OAXr6w5frKpH0R5PgfCbHre59ZCm1EscmGxbVYWzQQrw4Y0UVpkugRJcUYegKDYzt5YkS9zAf7m1+/3mYT6sqrA/IiH/ZCYm9FYkmBx2RSZjEty9HDckw+TLOARH9Uk5T1Zb4zZiXvViQSXUi6TVHox8gEhplv16Ps7rfsTgW5Gqca4HmkXuodMhyh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(2906002)(2616005)(4744005)(41300700001)(70586007)(356005)(16526019)(40480700001)(47076005)(70206006)(4326008)(6666004)(36860700001)(8676002)(83380400001)(82310400005)(54906003)(6916009)(316002)(40460700003)(1076003)(336012)(478600001)(36756003)(186003)(8936002)(5660300002)(426003)(26005)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:19:14.1367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5c61e7-dd4c-4e76-3ad3-08da9c30147d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Taimur Hassan <Syed.Hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why & How]
Some FIFO errors still occur due to reading wrong pixel rate divider.
Fix typo to prevent FIFO error.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index 171e1580291a..1bd7e0f327d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -76,7 +76,7 @@ static void dccg314_get_pixel_rate_div(
 	case 3:
 		REG_GET_2(OTG_PIXEL_RATE_DIV,
 			OTG3_PIXEL_RATE_DIVK1, &val_k1,
-			OTG3_PIXEL_RATE_DIVK2, &val_k1);
+			OTG3_PIXEL_RATE_DIVK2, &val_k2);
 		break;
 	default:
 		BREAK_TO_DEBUGGER();
-- 
2.25.1

