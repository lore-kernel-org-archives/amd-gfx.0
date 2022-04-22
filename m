Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9B4C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 16:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28F3D10E461;
	Fri, 22 Apr 2022 16:46:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F96810E461
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 16:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6hfJzyDYP8ReibsjPPAejlKh96qn063nI5C9No16EGjDkcdM+1jiEfzllMYLyOAyZkxbMDkgNUuPbkMNKGiHwDbfeiJBlh8wNQgQu8b/o+cXd34l74rhOZ8GIrKlB2x0TSJOaYfmyj7Qbu7ezUiGF+6vIdOeJZi6MMiwJgjiViwCnFuXPauFkbK4rlxvgTxTnwsBCONKsdWygrbB9+7hyBKB6BswbxPHVXsknUN+Lb6W4w6SdZCcimmCKl+xqnd51+mqPlydzIbqgqQiG+7rNplOLLMkBY8F3wWV5XmpZRyEZpiRPDBBxurF3cWjUSxzJ7FSZ0/PssAZWpLsrqQMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zB02AM7NEQoHJ2npBRjchqGnIz+XATSa+L0q5D+hmSc=;
 b=UikHZv4fv1o57cyT6121qbNOMuK7blwieJ3WmKovDVI0Hpy7YBtKr4TVazjUmLhp4PA7v1IPzcr5pCvYIjvBJ3x4bdC/BZDTZUrvpRMRBLgATcBWaKHutkahN9uYgNFmsmwf+mWugog+CPtPhxxcHFtWEEqS28l54szEgBT6g2mNXN/TBP7nnUox3kcNUauICcZi6iYSSP9OK06qpe81K91gfxvJeMMB/DaYM8fU06Xt9eNtcYIkE8hAnPV3PYmmEL3C9P2xoxTTEoo3DMy+xEo97oCY9MAA+7WDGlK9ZPMKoZn/4VPvBdQSek7A6cJEwobFSlpBb5cQNw69kfMtqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB02AM7NEQoHJ2npBRjchqGnIz+XATSa+L0q5D+hmSc=;
 b=Ofqxhd2mfPwGa60aKNxuTTzdcUlgJL6BAEKCWinjjb1BIJqWkPkRdVeJKM0RQdqgmnkQQmq3QrCm+aDIyFS3g1Lwm7jtsgZkJ40TawxSAF1ZPB/tNw2nKs7UzWv+zhl5JgpVWHOs+H4wtx80zKU25K6EksD6jcU46WK8v5fnvpU=
Received: from MW4PR04CA0233.namprd04.prod.outlook.com (2603:10b6:303:87::28)
 by SN1PR12MB2494.namprd12.prod.outlook.com (2603:10b6:802:29::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 16:46:14 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::a2) by MW4PR04CA0233.outlook.office365.com
 (2603:10b6:303:87::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Fri, 22 Apr 2022 16:46:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 16:46:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 11:46:11 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 22 Apr 2022 11:46:07 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/13] drm/amd/display: 3.2.182
Date: Sat, 23 Apr 2022 00:44:47 +0800
Message-ID: <20220422164457.1755751-4-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
References: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1b7f0dc-331f-405c-a706-08da247f9cb4
X-MS-TrafficTypeDiagnostic: SN1PR12MB2494:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2494F32BCAACABDD0DA51EC4E6F79@SN1PR12MB2494.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m0ICRFNLPgBhnmByGMPuQRm3pdNnmiwWZ3Au9vFImJVbxbWwDxCzxDddEYdBvzobu/Jxb55pKAP2EilGVmHxieKo96OkP3MTQXaFe6GlQ4m5GBTkLoqDFxkDpIo5phIZt0hthC4ypz9qbCCT8IYUxV09rjFo30nbb30+e4aW0h8jGLa8e9XTWL6U0ATipzrPCw62W8HvA2MkYdSNnQ8KY92fLXJ1JMkzYxid5no+2dj3KvIY5BroFIwpJCKX4YMvYE2XhLsFBybGxZe169AsyORKNNPt0DPvP2v3hKsloOxLZQS5FlQy3JpTcVPVaEwVq+JmQFZNp6/NcElZLe6JjQ0D6ZyKDgup9nlaRnmW9AJ39A6ra4HcDzyn3rc7xSwljk/r4jKz0Me13KYvru7yvmF1eqNAW34IZT/whyQacf3QmOuJir38nFbHsG5dk0rHxXrOE1m+DYD7DOrtcP+65OJslFrk2OnXTXVpZzbJZu5ubzQVN+5AmWjnuRkiLIoayIf0oVWCRF+YznzdhiEOj+jwF3awpAa9AR2WJo3UsizkRuUJtQtOdJAfvboR+naFfjAIFPvcBvaeEOrVBd1W/3ZCCRA+tFYyph7wCAAPs1mMuyUIGepM3KMUr1B52JaG7W7QFTTcXgeDHDqga1B+ggUq4PFUmlLUtw+4xE/sk1Ko8mjrAi+tgE8VoUnJoOBoYfJgxbMQgzByRe6FOUwEIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(26005)(4744005)(86362001)(356005)(83380400001)(40460700003)(6666004)(508600001)(8936002)(81166007)(70206006)(316002)(7696005)(5660300002)(36860700001)(82310400005)(6916009)(186003)(47076005)(54906003)(70586007)(2906002)(36756003)(426003)(4326008)(336012)(8676002)(2616005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:46:13.3003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b7f0dc-331f-405c-a706-08da247f9cb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2494
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following improvements:
- Fix HDCP QUERY Error for eDP and Tiled
- Insert smu busy status before sending another request

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2f0c436dae4c..5c85e52e5406 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.181"
+#define DC_VER "3.2.182"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

