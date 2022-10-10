Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6E3C43217
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Oct 2022 21:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5E1510E728;
	Mon, 10 Oct 2022 21:36:31 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 477B910E726
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Oct 2022 21:36:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kL9sCI4/NlpcUzLkK3oZtFGxtFooQ8RhMAtgydTkFcjEXWvj4RgQNVH91s9nBfXFlp7Z4Ls3lgY427R6GBl+Com3B+tveOXkpPcckw38DXsIPaz3ZSI0azHOuMI4NlZX96UsbgctRmUWbhD21MDAW3BWwzk5iYFuZq4FxLhw6GwMqCHmzRSC9EvKZjG8HF2lL/0qU9Ni+PuCBxjIS6gJ5bzRQvlQd6T5d5iidNr4upJtxzoJn8EMke3XAP+4yK3MKijarlUz/zUOAkF4Ph65rV18zC5S84nZNXFVKMd063NZmKmfHBLVoi0ZmxQYMq4X8ROhF+ohf4+qhZyFoCLQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yhe99KFo20lN3LGZaYPVZ/emLbI2RXs/5JBSn/fJSFI=;
 b=V1+EqgLRWJiIauw8YZBLdayZbu30pSKkohPCZdyWbeQeyPMRtF60GJDAjeUa4yqLpcAIWx9Mu+Rk+4heHNdFUmObjsyyMJlYaTfEf+bnlNG+M0Uuszn88N7tmvmtrpiBdDSHb43dyLXfZJQz6HJv7FyFD3pC5z9lUXqiQ1mpbyiRYBqAHvOcVfPF7Yirjf3WHH92L85RO4uWW4dF19bavY5vat0qTonD1dl5orow4+b72+X1C8F6KUlXm5TknHOcbjMPcsRC5mWxHRqU/oRfEcVJQQXo/miz2mjHlZI2yqZKTQFwcqwTA5TI9VYC1Fw2YZ0NDPI08sCGXX1R2xEJAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yhe99KFo20lN3LGZaYPVZ/emLbI2RXs/5JBSn/fJSFI=;
 b=wobFFe8bKeXUI1yfJHXBWKzqqY+Xuw0ZKCnqzHa65FPh/jsdL5VK5e0VbRExN/BEjbv86tWK3Je55+uXnf9Obh3gaWWYjJ24RxKlvuQqBD8EfzOFsxtYaHyZCdqHJ797FpMVxFXaDIhicNMyiiYjZoTWpNWC0m5xnR7AZ7wL5co=
Received: from DS7PR03CA0106.namprd03.prod.outlook.com (2603:10b6:5:3b7::21)
 by BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 21:36:24 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::2b) by DS7PR03CA0106.outlook.office365.com
 (2603:10b6:5:3b7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 21:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 21:36:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 16:36:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: add a license to cursor_reg_cache.h
Date: Mon, 10 Oct 2022 17:36:08 -0400
Message-ID: <20221010213608.478280-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT027:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8a5919-ebe9-4376-705c-08daab077b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZOT1nSAq8x524Ak/yjWWB/43JQQv/Q3seVZHXUQ0YoH3azcw+uIsuIq0cLZb78BoBggR4M8BGytt0ITFlSyte9LUtBGM0h3gIlWweRcrwNLHwJHs0m/dVpT5kVWdL7j+havGcTGK+Yzeyvi6HHc0yomSobnUIRVJBjvwafBkJsWQ0sH9vV05aLt7eOwTft+42TI9s2j43Atq9y5NIVJtXofmdpAX6ckWt3QD7HbDtO7UcAm/A5BZQ27wn79nlVg33k7J54mS27wuxAAEf5nyfb6nfFsmvF5Wo0Jvi0mMEsiBKAr7IhIMkjvGD/ezU7zLbT0ARCsUmNvM2STN2xOG1nQSNg2C3LIWoBdwjOcFJ3NkvArGZxF14ksoWl7itev2wd2eB9FwZXX6PQulk+mHZny91zbB9mwUJcMfJ/FRSXYizKpgRo1NzVZ9kQoRvDQrN4uaMoXP6gdgx8JZoMnQ1VtUxx9G6tWo03vTU777LAxaCtSUd7ScO1A5X4HgjYL/xTRO//5zUZlD1RNBcadHMox+ViyOkZkdQ2mv2etmjfy2J9VQaXKHaJo8RAUabX0+cS3q0H/n7rvkXnqk1w/Z/QRMNNKqiRtbg/Ugsyibv8p59u0dAOKBwFa1e0k3qUCj8velkxVE6GUGalwzrDVl2eG7WyyUXFPVh5f32d6/qlTSS1BvkkiFOm8aO2LJE+0K45UPJR+qJ0IuEfgTnDlFQFERhsqgBN1xRJjcsQ0KY+p4Zqw6UUljv/XF1uEIQORmHxWk3BKQKYq10eNxHI0cWAnCugb0k71APiGV4S6b4q80JjV7abdQe+u7FZHog3Iu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(478600001)(36860700001)(81166007)(82740400003)(8676002)(86362001)(6666004)(41300700001)(70586007)(4326008)(356005)(70206006)(6916009)(4744005)(316002)(82310400005)(1076003)(426003)(26005)(40460700003)(47076005)(336012)(2906002)(186003)(16526019)(2616005)(8936002)(5660300002)(7696005)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 21:36:24.2640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8a5919-ebe9-4376-705c-08daab077b05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523
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

It's MIT.

Fixes: b73353f7f3d434 ("drm/amd/display: Use the same cursor info across features")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/cursor_reg_cache.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/cursor_reg_cache.h b/drivers/gpu/drm/amd/display/dc/inc/hw/cursor_reg_cache.h
index 0e7c5880e867..45645f9fd86c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/cursor_reg_cache.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/cursor_reg_cache.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: MIT */
 /* Copyright © 2022 Advanced Micro Devices, Inc. All rights reserved. */
 
 #ifndef __DAL_CURSOR_CACHE_H__
-- 
2.37.3

