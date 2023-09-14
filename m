Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B70AEE0212
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD7E10E211;
	Thu, 14 Sep 2023 02:01:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C64710E211
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:01:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTlzql63IMyhg5eI172FaC/KYNpR0f8K9nL8ieHWaoeWjOlEzJwzsNBsEzY1H3iyHREKeYwkFBb4fhUKFntygxC3hoNNSPS7zluntVJPPD7k/CHKC+jdfuTUypAyIo1WqydNg20IckE9X8MjeGtS9MhzCnqCEDIKHDUl8yQ/CDHlVqmYvkwzwlx9dWn5y3bsZNRFT9RV97AgOl4gg2x0T9ZYAkOtGn+Wb9K03m7FjNO+PVSTcc4rwF21LFXW++lW3/3tM17tp5H4yu5Ydom/maOHDxRZIGPovwl2xIhWQzZTaGhlFfyj+8csGPSlbWLGJGyhWq2jifOVp6dShGAg5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIXcWgbURtQSOV/TOyXzug0y09yOCiZla4bwYVz9K+Y=;
 b=bcTDddZp1ixf7DtwvhmFwIuny80ic8MHBPu6oWVZf0Cw1Gk90Mf4No8c0lXhTyh0ozIJtLjUB61usncqlthPeRSViQu9EZJzcsOkeOV/2fpYDESZg4tqpVzQS00ECUGbJ2ppLhtSjvZpsZ81p1KrKfLZjqSzgEQCKQN409B51KClNcc/Od7aCFxBdJBADTCVXeDrtItDM3B4PN45y7zz/DjzS0g4WNnumUy/FbkyBc5UUdWxMuoymAk2dItRT1H5F6WufzuPXWZzruwqWEWeSGuiMEsZsS+E1VWbcVq3gxldJ7Jw7GalMemVXCtgLvkx/xZSS0V9Oiuo6YufUwEy5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIXcWgbURtQSOV/TOyXzug0y09yOCiZla4bwYVz9K+Y=;
 b=QEQbL6zTW+tKTDLpV7yfdtTWGC0dayxRaE7iTZq0xx30sv3CAq9Dtv9apHa2tniltjy3qC91krUY680VW35z4MPrB9i00tccNoprKHQy58B0XD5kP0o8yvsBdAPvhqe6dpGwQ9Q1VzNeOF/YjmowUwzxoHfiedQTJFqxgEewuJA=
Received: from BY5PR17CA0020.namprd17.prod.outlook.com (2603:10b6:a03:1b8::33)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 14 Sep
 2023 02:01:25 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::a2) by BY5PR17CA0020.outlook.office365.com
 (2603:10b6:a03:1b8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Thu, 14 Sep 2023 02:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:01:24 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:22 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/28] drm/amd/display: Fix dig register undefined
Date: Wed, 13 Sep 2023 19:59:57 -0600
Message-ID: <20230914020021.2890026-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d725eb-f753-44ff-b703-08dbb4c68007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HObR+D5ft95Oj8yKLz3sk3BpPuUhtvhawX6qVxZn2QQyhJPm/tK/96zLmt8gwRU7VACvj+9KyUMBOCuzqBGkShsUX7l+ChZrBk7m79gHoWkLlltX78S86ILEGjncfdJBMhOkrqS50Y3H5mHfzT/1w9xttsZRz0GbJ7Lwm0jsveh06kHb7Q65s/W5OiQLNdY5PfauQUyYj/L2pYC85FWrTUdyBtmmynzO99ExEeN+513PJ7sbclgbvNIFxqfIu8JtpApS/krKme+NecbyqsRE+o6L0pr+2zJtp0+Jf78ylvS22kXmRj+SD2PefeeF7HfohZ1aax8g8AIZiqw0zF08SL4UocAGDZN9SovmYo9w2upeEF3Nh8zbjP+ethep+O2CAprgFntcR4ZuW3vIuU4A3K7R3xrjrvCtE6azgg1dAc88YehN3g2JR2pkAah6uEFWkQ67s65fTIK5MKl1hNK5GB3FKewnNlRrr1ah8fMz9OKe6gXtmXITdtX9f10NkhpkcW3pGsCwhBnzKFgJoJ8vheHZs/3rHumjKWGGxKhO72EOMThiTYsEvLYYoBYizTZT1hbihAmy3aDiVgTyeLMXO+PWGRSmhrwmrCipIC2sr/2sVycVyTiSI/6pzx8paR2+CebKhKfR4iZ4jOKSJH1McmA1wKYJ3oBSvSjKDfNcmxsxlR1s0dwKViZ+38jH3pijUlgclPets5nkEsxCE9QoDHwz9hhti+pDO9q/cpTFxPn+Q0be6UO2g6jqAL7Rn1U8E82lz4Re4mibhdZKdK0jA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(36756003)(86362001)(40480700001)(81166007)(26005)(70586007)(8676002)(5660300002)(54906003)(16526019)(478600001)(6666004)(336012)(316002)(1076003)(426003)(8936002)(6916009)(4326008)(41300700001)(2616005)(47076005)(40460700003)(2906002)(356005)(82740400003)(70206006)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:01:24.6945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d725eb-f753-44ff-b703-08dbb4c68007
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Duncan Ma <duncan.ma@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Duncan Ma <duncan.ma@amd.com>

[Why]
Some of the stream encoder registers have register offset address 0. It
is causing no display in some scenarios due to DIG_FE was not setup
correctly and was not enabled.

[How]
Fix stream encoder register define list.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Duncan Ma <duncan.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 957f39e1381b..aa0c27e76e4e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -308,7 +308,7 @@ static const struct dcn31_apg_mask apg_mask = {
 };
 
 #define stream_enc_regs_init(id)\
-	SE_DCN32_REG_LIST_RI(id)
+	SE_DCN35_REG_LIST_RI(id)
 
 static struct dcn10_stream_enc_registers stream_enc_regs[5];
 
-- 
2.40.1

