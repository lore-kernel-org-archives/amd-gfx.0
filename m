Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3045EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 21:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F10610E5B4;
	Thu, 22 Jun 2023 21:58:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77C2110E5AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 21:58:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0kurFbQAagC9jKkaBq/xuikuIl5j7ZcDCZ58gef/f8httDhUkK2ppiqQW1h3HCqFu+iPFD/B4SFjWsRI0FW4FJBsYYyBkVRR+8M4HxSdB6FIKaCyNhr/vR0yHhtk9QlqSpEnyB4h9UzANlMX3B5iVMyaVcbA6EApAldONQto1ZjMS5pB6yFDGReOOf05KLdsG77kJzXiG0bJfglZ3wrtlGnWWlUKjnrYXJmpr59qRYIbdLt3TYHV3po7pj/X+yzg6RVadfgWj5RvMFCAHdaCVYVgUK8G41Tu2/lk4BNh45Xvfk/awNd+hH+5fZVCIBlORoK0gMlG6uCzmDl67w4Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIANm1aXzOTpeR4iMEjdxpkWfKMGU16taxKx5bpbua4=;
 b=E40C3Wpwf9c3HMkvsoWxDj6Cp0Q6Tll/cUx13huXc6ayOEAWfQcGrzdK98Q/rNctMsFmlns9AMUK5jZnt9dcbFnF+7ddvLH9Y6q9sAEHf2UFxrBUfsRPccwRCCmRmk19ZgnxFEh5LaGxQEzhPCvx1EtBvnKgrW5ioSJ6atUD1x40kcJb9gxXKKffwLeLuce/cWehqvuumanwH+FMCIG5fbgyH4leNvDZDuHk9dRBzvqZuzavu531qqpa+IHJi6Y5/mztC2pTYhPyeEOgCzepsbCDZS8jMkguP/bzz7+/AN6hOj245KVAVEXPIxTEeSuAMc96jrL+zksxV3duE4ndxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIANm1aXzOTpeR4iMEjdxpkWfKMGU16taxKx5bpbua4=;
 b=agXHPRPtXMlV8Ku83tT37KoFfeCLhWRwFfqgvUOb/lJOJeQP2dM33sKj9MBDtuRPp1qUaZZ2UViCuCqQer+cQMiChBRd+vtQSvQU3ZqoXh3Mx+v6aOpmrCh2AfehISsE9W+JHSOZJo1vynHgfkAhG7OljfzqaZ2ACtEuBCqJAJ0=
Received: from DM6PR06CA0096.namprd06.prod.outlook.com (2603:10b6:5:336::29)
 by PH0PR12MB8151.namprd12.prod.outlook.com (2603:10b6:510:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 21:58:22 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::5b) by DM6PR06CA0096.outlook.office365.com
 (2603:10b6:5:336::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 21:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 21:58:22 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 16:58:20 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/11] drm/amd/display: 3.2.241
Date: Thu, 22 Jun 2023 15:57:35 -0600
Message-ID: <20230622215735.2026220-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
References: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|PH0PR12MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: 157ab8d6-c47f-4e4b-2e55-08db736bcbfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7eIRc8o2RIb0P6vJ8c154l/rphj9+xNQaca5BXO9cSMeqVWj0xf+Y8TM2SXIXkCDrtKBS3a8NCRLsaORKE62AItioEzMsozL29Q1I8RNMxCf3P4qr1S/5Y4VA/gH69Prmr4pwX22ezYdBhLylrNnZOJGfC+Pz42PAD3ZgrSyKz+zOOUCGjyP2IRjc6BLnIo1rESVcriXf2J+avqUwhhVuHFccAHqPhVxmyPQt3pxiaFoB+PMOL7U4MT9wjk02+g68NPyjbUyKE76jYLFL/p5+IrtDwkA0qy7TnEoaWuBpdbne99P716/SPJRN7TtT1l24oKOQOsp5TITqLE0BzV5pLRZHO4o4H7kHYtHLEn1mgG22cZc8ReD8RSs/s1+z/4ehuHyHWW2yxIp7hf4wDPWJZ1GHuqVFZMXNJVlHNp/v9AYU+FYLRk9/qbSPvpuJt4FJ2G/4jMYmtN9TtSKHsLjjKmGlBHfQmq3k5S0fYk6E4zAo9j+6VYTUwawvPfofPY7C9rAsEmro1bhuRlEPyPgF3CXo52/ZeMIp0UU6yHvoncD6So+r0dznuJXLM3TdzpnV3NT53YjDN+lPxNXSMxii1idNvXVhti1WUSRa8TFMbrbIMXYfSyW8/vWDvtaq0DH3mAfj2KYvgrQKp5BjnByJwIBZ4WOMpAYw8BEIGXGnXshSE4PivLCrIX4LsPb4GNVXueOkzATkhVU3XZkvQOZBG535kuVRX5oUjj2a4yjs2/L7/uiN5/JwpAh7CZDMbn0IDnLPXDAMo+Wy2RKmF0Dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(356005)(81166007)(82740400003)(40480700001)(2906002)(4744005)(47076005)(36860700001)(426003)(83380400001)(36756003)(86362001)(1076003)(2616005)(16526019)(26005)(186003)(40460700003)(336012)(82310400005)(6666004)(54906003)(478600001)(70586007)(70206006)(41300700001)(8676002)(316002)(6916009)(5660300002)(4326008)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:58:22.3429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 157ab8d6-c47f-4e4b-2e55-08db736bcbfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8151
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:

- Improve debugging mechanism for Gaming FAMS
- Add monitor specific edid quirks
- Fixes for Phantom pipe
- Fixes for Shapper LUT
- Clean up asserts

Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 110ef14445d9..63948170fd6d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.240"
+#define DC_VER "3.2.241"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.39.2

