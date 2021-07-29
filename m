Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56274C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:37:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D2B860F46
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D2B860F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1C836EE5C;
	Thu, 29 Jul 2021 20:37:18 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 492F46E12D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 20:37:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/tojH/1o3QqIJo7JwizRxOAl4Wq4uGgh8MMHgvgMTpIR3y6C9EWon8rGgMGRQhQJ7wcC1bn6Oeed9RvhyG93jXLnNTn46fEy0s/pj33xSsAshnNFuGJX1V2fFS4otTC/O12XnOMbdhNZawDgF5CUZzv/mrUWmY1JCtZOl9Ql1kcybkqOgjdgAvbf7esARXiR21MEVvOIb1NB3QYth7EVD/6tT8qRbQNP2qtwPF6vEMqpHy7hB7/vLgIusGR4TF6WweZJGVaVuWuR9ep9kS+i5iaPoQDBsNf9gBa1wKFkfAMT4Nihyoy2RdEzAxaY47f6Pi1WINRTXULrQB/NfWXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciVDqthj6AIUd8HHqDGToCH77aNG4yV4rTwKdcKyBRw=;
 b=ENaCM2AnkRNc00fwJF9plvYgYBPJMTWqV/Hgv522f4m3MCmJVZe+/9YOXk6YVivq31FtmknO3d3/Q5xEs7xVJx8TdcPOqsxaQhCX7a8GeCLojkfSA0kURQJqc+fDT3MHq/h+KOtYO1o7f6r7FYLqQnkHNl9Jx/3rrLYyOUONpLn4ZrSAQWa3AaAqTiwPeUhMP/UaTW9pmCl5n613Bsm7iiKgLYvHNkApTtrys1Rtdqu5IRqbxr+JDPpnzJox2m9/RzbWhlOiqqKVu3DMf8iUMtax+OsBG+kpFJcFgx2GjOnfbbG2b9ZeIfyYPGMKIyIu0Us2g2sVOf6PNVdXuUjWLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciVDqthj6AIUd8HHqDGToCH77aNG4yV4rTwKdcKyBRw=;
 b=P1s3ROgfFxaRY+XtlemCwEWd6OMeB9yzi1jYEMGrWucEQF7FUYwKlUOEeuwbU/RdLP89kKP2ppGYN9PzMhNpCyMJrQIWKG3aMwlXVDeNYsJADNr/BykzGRCEXrPjozw+ZU6tPSfUn4AhfCrHiVx2AC6XsgBgcyi3ypeS6Npx6Rg=
Received: from BN0PR04CA0142.namprd04.prod.outlook.com (2603:10b6:408:ed::27)
 by BN8PR12MB3025.namprd12.prod.outlook.com (2603:10b6:408:66::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.22; Thu, 29 Jul
 2021 20:37:15 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::db) by BN0PR04CA0142.outlook.office365.com
 (2603:10b6:408:ed::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend
 Transport; Thu, 29 Jul 2021 20:37:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 20:37:15 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 15:37:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 13:37:14 -0700
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Thu, 29 Jul 2021 15:37:14 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/9] drm/amd/display: Fix Dynamic bpp issue with 8K30 with
 Navi 1X
Date: Thu, 29 Jul 2021 16:37:05 -0400
Message-ID: <20210729203712.1566129-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729203712.1566129-1-aurabindo.pillai@amd.com>
References: <20210729203712.1566129-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 390e84ec-6c24-45e3-5410-08d952d0a6c7
X-MS-TrafficTypeDiagnostic: BN8PR12MB3025:
X-Microsoft-Antispam-PRVS: <BN8PR12MB302535987B45547FEF037BFF8BEB9@BN8PR12MB3025.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P2Jny/2Qi1LwMiyGBMc83ZYxMhqttKkTE87vz+N9SeKk7NpGpSHEN3A82y2k1d1hLq93eG6ja32S6uL+3iRf553QIm0YjDMzKxEQE1pCPoz6uW7uO3wv12iGSc+zoh0QuuIEvAQYtP8FvPuh2+avfz67OE5oj4s4EE0klyIrwQAs0v9KeipXH2jMY6rSWPyxXjslq5f3zSWX5gYROGERFP3Kr7L1BLXbJ2uaWLY07HVeIOjQEhEv6Xjbs916C8FQTNBFMnG1MwiXXXAlc+SJJfHiso4i6Hje5m/CNh4HBPVnNWFYJ5ohGvxVegRS7AF1ScVehM5qDTQDBlTf8Q0MlFmSyVxHcL0SeU/pJYl3xpNIi+4K1jms+V7N4bBeaUD2XM+RvEKSq2YTNh3PUEUDWGAAF5X7Q9RmcAGPUFwssvo5T4r3AKLx2KsrsblPMNhWdB8Pi6e9EZEpJSLug6y+yWxUJc4alJNB2o7BapjNXP11ClWp1ki2jjVTlhX/U7ToAo5ZYdxmmgOZBGiO0LYeiBwK8dwsANUl4Hh3a33RfzGmGTzhGn5eFVCcSbQYxbsQs2kNYU9bFUi2e4X0/6RAF04c3MQl4GHJw19N5Ipl1Ej0TA+MJa9hYQw35Q1n/OPnBHYHJhIIV/lqMMmgCHYLbyUcDp6aw/ZxCJwwkihQ9SZkpwo9Ez8UDQ21N0xvcKtnCe9RI66L0DSvcJ7N0I3mJEiPX1pdPckcQVjCqmxazzI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(46966006)(36840700001)(8676002)(186003)(83380400001)(82310400003)(47076005)(426003)(36860700001)(5660300002)(8936002)(86362001)(26005)(316002)(2616005)(1076003)(36756003)(336012)(70206006)(478600001)(70586007)(44832011)(4326008)(81166007)(7696005)(54906003)(6666004)(82740400003)(6916009)(2906002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 20:37:15.3962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 390e84ec-6c24-45e3-5410-08d952d0a6c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3025
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Martin Leung <martin.leung@amd.com>,
 Bing Guo <bing.guo@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bing Guo <bing.guo@amd.com>

Why:
In DCN2x, HW doesn't automatically divide MASTER_UPDATE_LOCK_DB_X
by the number of pipes ODM Combined.

How:
Set MASTER_UPDATE_LOCK_DB_X to the value that is adjusted by the
number of pipes ODM Combined.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Bing Guo <bing.guo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
index 7fa9fc656b0c..f6e747f25ebe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
@@ -464,7 +464,7 @@ void optc2_lock_doublebuffer_enable(struct timing_generator *optc)
 
 	REG_UPDATE_2(OTG_GLOBAL_CONTROL1,
 			MASTER_UPDATE_LOCK_DB_X,
-			h_blank_start - 200 - 1,
+			(h_blank_start - 200 - 1) / optc1->opp_count,
 			MASTER_UPDATE_LOCK_DB_Y,
 			v_blank_start - 1);
 }
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
