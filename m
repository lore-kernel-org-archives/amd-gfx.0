Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43827C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 15:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 806F510E63A;
	Thu,  6 Oct 2022 15:32:49 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EDA610E63A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 15:32:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEnrkTzdGm1y5CJ0nCBiTb37tO0KzdwFcRdxrtkOBF8Ap9fs65dyQyx3SzWI2tWGhUNz8mx2tJRGdSopeplKVp5iSO2gYhODrg1Ek/jrauafD+EskswVtoFB8zmiu2YHoJXPHLzv49hab0WY8Mu+Ck9n+OmQclb0jTf9aBImGC+29zuzCS9dFWeorFHVCrW2wARDJXJGawUohky5G/rGNeEl7h18aaXBDx/WqyOEqGfn5tAYR1GK/+kFzm+VWXjVVRTMT5DNKsFPjiF8mJFXX5e1lQfcERJ4TrLLWdfpac7xf1aCm5aSZZotcEeVDwzfgmrDF3b8ZdXSFITopYB9iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZV1opLHHnTqTOdxSZoS8sAZhgME8dLBRMQMf4GPw0CE=;
 b=Iaw9/mpYeBhfbVUtYXrozfpmHLCq/rjX6iqvLQMdWioTgQVXWvgNezYS+BiDixPuIiG2m2W9dJB+sSCZIhOlKACyg/2LtvgdBRlLJYzQchMe+dOUXMuuJiOc42DZ52T68JBzEAK0QVV7Nao7MeCGI4+rWvpTH4gNfQBCKKNfMzuUng+zKULIP72H46l8QHucS/+UM0hfmA0zDsqBcg7UVRuyztfBUtb66PIzFuqaIx3JbKC91rfQ/n3xBgoSuGrLnXkFAqcJ83AI5+M2qc5Nju1nTRHEs/QYN45etNskFIbvDaURiqTczGT6XCvjXf6C7bF+Lkb+2eoVdZBTHsU0bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV1opLHHnTqTOdxSZoS8sAZhgME8dLBRMQMf4GPw0CE=;
 b=e7L9rBp0xYT9n7D61mSxEMPAXerjn65tyepE0kxpbzhHCfI6bi/NcbXKJNaFEN9N6h3jpxOoAOtq3LdiYqhQ2YUZ0GpDvwVk4gQRnT0uBrPbeIg+4cqaH7vy2xy/mlK8nX9/ZwWv0J6SNfXtQgfusJV31WJzVPQ8ExJ9mDmfOSI=
Received: from BN9P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::30)
 by BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Thu, 6 Oct
 2022 15:32:45 +0000
Received: from BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::b4) by BN9P221CA0008.outlook.office365.com
 (2603:10b6:408:10a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36 via Frontend
 Transport; Thu, 6 Oct 2022 15:32:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT082.mail.protection.outlook.com (10.13.176.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 15:32:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 10:32:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix indentation in dc.c
Date: Thu, 6 Oct 2022 11:32:15 -0400
Message-ID: <20221006153215.450989-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT082:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 379ea46a-3053-454f-2922-08daa7b00422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0TtfAOfGQCSQAdrJNcQJIEN4EjQfx59mIC0aSSaGLuLYccMqWhFR2hlRT+LofBOxwun9Qm6aMD/CDq/YkfDQRKkK/0m07fZ4cA4Eaz0oa+cq9KeVcTcglMLoWugNOat0zTLRLwSbcd1uZBWjLsq6MXUIcm8X5Vsbd1iONbbUuAN6m41Z93D65r8hsrrmQUXGDKOUKWIeGFashYfYrZHkJgopZBmFv8SouJKeKWjFs7rVNQUp998rdYtWt/b0KVDn8maLnBUJX9Aqwhb47bxQtJV80886uPkD4roG4o48YmYesNz99W8WNZf+K3/yMjzC788g8SrT2/m14PzisaOMooXWbvdLX5tpERxJ9kiPQ3N71uSpcAl4toc1UwPThhP75KbHFFM/z/o/ASLwqCo9zJUC7yAX4Yxm37ig6I6heUskp/XxjsOj4k4NvPZ3vfIz3XjapdGwIbvDc732wEW2aBT+jJEcU7HnPAKXMj9wTm6xLXQk5w3+yt1+bPP0ZyRG9H9LJiZkyrBjLWMzb2v8u1SB8CUafBv91rsK9XYXPMysKbLG32LC3DjmyOYvNCGuy0+LTm984Q+4mKP25wAuEWTPLe+ygRxZhEAYyvZGbAI6RUge2WWvatyvoUn+m4xH6+AS1To5V5ToHSEKSZybZfkWYtk26Gnrlcz0J3kKO/qH4n7tLJItw6KTsH1PHQTPtcCdKxivbLz0nmJ0Qc8JBrvsyoEixERL373rs1wRCdccwfIV+PEnqSORAmTjmb/QwJLc/wPByrao1wERntafgvuq/9ExOCixr7afysZlpyfNU7MSu7vT78+ZV5MizIFS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(83380400001)(2616005)(186003)(1076003)(336012)(16526019)(426003)(82740400003)(81166007)(356005)(36860700001)(4744005)(2906002)(41300700001)(5660300002)(47076005)(8936002)(82310400005)(40480700001)(40460700003)(86362001)(478600001)(26005)(7696005)(6666004)(70586007)(8676002)(70206006)(316002)(6916009)(4326008)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 15:32:45.0995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 379ea46a-3053-454f-2922-08daa7b00422
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes a warning in dc.c.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 40a34b600c8e..96bba1c8246f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3526,9 +3526,9 @@ static void commit_planes_for_stream(struct dc *dc,
 
 	if (update_type != UPDATE_TYPE_FAST)
 		dc->hwss.post_unlock_program_front_end(dc, context);
-		if (update_type != UPDATE_TYPE_FAST)
-			if (dc->hwss.commit_subvp_config)
-				dc->hwss.commit_subvp_config(dc, context);
+	if (update_type != UPDATE_TYPE_FAST)
+		if (dc->hwss.commit_subvp_config)
+			dc->hwss.commit_subvp_config(dc, context);
 
 	if (update_type != UPDATE_TYPE_FAST)
 		if (dc->hwss.commit_subvp_config)
-- 
2.37.3

