Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DDEC7EE2A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 20:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADB9810E527;
	Wed, 10 May 2023 20:49:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 564BB10E527
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 20:49:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+7oARWcc2KYAnn8Y7inHO3oUVFxfQQjjLyXeghKXNijqxp7mFgpo9L/iyqRkatnEL3MaCtqgrv3f2NH5ZZHcI34vUnw1PEXNfpstBekn0HoJAQ4VcLbNbaevxONDyLTLvjZOof5884SaozXzQgb/RrQvnM2iYgwNqejE4CeGAnKahQF5Yy7rdKioB83CG9TKPR6Hrz8caPBiEMarrbligyNFkShf6ykU53+jjS/eJ9763XqDmt74TBmu4c432ynEJeRgMrvB8OvMz70RMFnkNiSFkpV9hYiwu5xToYKpGepW+4npYdHs7B6SL6Wo9ZlwpKGx5WhSrlOmuWpuxDagg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISTOLI5guu95MWatC6aRpi/hXwOHN3EjQiwTUupbpk8=;
 b=JDS/6FeIeA2cRLtO2OXWZPSiPY4XEk1+vyru7wprrUYsBkC3jyg0XGXxYW9K+p9LyY2sfumkpF37sKKoq1g1RzTDllwWGrvn4oqXG/81tGeGUiQhcrEmyj6siDw7yd62db9eR/IPSvp4uPzU0qudD85yHZ0VQCyUJwAIZkCzB+ipGyoS6c4cBYCX3DPPcldYuV2+dQTSbU4jHriduhpTDiU5eBDxme58TaIlFb2nElCyhG1WWeBfKaCxwpcS4NgvtZG7kwDiGkmO9bRwfB2VdpplK2ch4ADaf2v1ci/n7AZSbtGWxrU8g8zmfymQQzM4V2/t1KzDtfyMaDd+dkqjVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISTOLI5guu95MWatC6aRpi/hXwOHN3EjQiwTUupbpk8=;
 b=2jaPajSr7EerkUdmVq9BEyzWHzIWuDYVvOnGVkdyEamq3sMy6hUPaOiPA5SK95oEtSGk5TNgunYiIH8ZR3Fe245i8cv+REPgs5EvRHTYiVLJY4v2FiQsDkjGTgQAofPiCqDjw3Il3P5Xbp4vnFQpVA9yTrkJT8vgIJj4uZN10LE=
Received: from BN0PR10CA0007.namprd10.prod.outlook.com (2603:10b6:408:143::25)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 20:49:22 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::fc) by BN0PR10CA0007.outlook.office365.com
 (2603:10b6:408:143::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 20:49:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.19 via Frontend Transport; Wed, 10 May 2023 20:49:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 15:49:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 15:49:22 -0500
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 10 May 2023 15:49:21 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/10] drm/amd/display: 3.2.236
Date: Wed, 10 May 2023 16:49:00 -0400
Message-ID: <20230510204900.949963-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230510204900.949963-1-aurabindo.pillai@amd.com>
References: <20230510204900.949963-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|LV2PR12MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: 8739b9c4-f150-4517-7e8c-08db519808c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0P6x2+yQpI5yC40ImD8KsLiRr483lbTgc6tyCjl0pfRnRZC/hduY4cIDd5Q1xhn65gd/1RKDgZ/yLtsgNP1JOR3adS6mPokYcG11FmkNr7hya8ZtPATx7fsU1G8dZQJAXq8elptgVEQnJxYOLBPsit0q8ty4fm/77EYSiwrsAZBLn4EIMs1rddQjDUXQA2hbbSEOT3FftI3tRy1T5zI5HJkmkhhh79i9oJ10681UDgMb9ZS4zwconUGsrV7amI6r6Gh4MpxSVA+lyjNSnbiiTYOotKDvcYsHdWp2FinZuXOouHujWknvFpzoM2mwCMAO2qrH1/eQuj3x2lpdb1czNioWjTSRBLgV+IDWyAUrWrhNLsUoaVrjbxCOD7dmA46170zIGCcoalmVkoxVBKrwQQBuNAlcAaq4mj0iJvUjFX0HTPpIIR7lFNTP5C97xihlv73YJ/J+8ZANNxfnbACIGJbN3/zhxwOXR1cOQknv5zC6w2U1dEgvCUoUCQlJdNncEop0KMSJfHMYZ6UQy+MYNjzepufbjuWmyWzAiAo57bQTMy6CE1I868DYfVMgB3wsByglOgGQv1VvIJwE6bRUC4uV0rTRNvRjoAmIt/Ux0euACoL26sjFxZxxmBhRId7M26qAuSutxibkakFkAahD4Jbn+JzLS7tv4h+oagIybTZlPmtQK+N5Brwmdsxy4Zj44DKKVEwo+tGOoFw62XwPCHGBx5s3VRvSCIPguOUq++c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(6916009)(2906002)(4744005)(70206006)(4326008)(36756003)(86362001)(82310400005)(44832011)(336012)(426003)(5660300002)(8936002)(2616005)(8676002)(478600001)(316002)(54906003)(40460700003)(40480700001)(41300700001)(70586007)(6666004)(7696005)(1076003)(186003)(47076005)(82740400003)(81166007)(356005)(83380400001)(36860700001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 20:49:22.6365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8739b9c4-f150-4517-7e8c-08db519808c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8be2e6d6d888..2dff1a5cf3b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.235"
+#define DC_VER "3.2.236"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.40.0

