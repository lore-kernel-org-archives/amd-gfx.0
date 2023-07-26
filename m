Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290A3C0015E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 19:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2CFD10E4B2;
	Wed, 26 Jul 2023 19:32:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8885C10E4B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 19:32:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABsuCRLMM31r+8mhdcpcNUJWT4qjqK4AUHAF3LIbcuM04yCyjJPOmZwpzQtpuZswb8732g08iPCkc50NL6Oe/+UkcZn1ysHD2zT3fDDCQp0X0XIDjGnxnkJcVT4pGw2w3nPBMG39IfAquGqb4CBdP1DQ/xcMaB1rl8rbsd7ryMlFtNUGgotuQoN6zEm27trV8vL7lPdYb0on3evx7Cq+l9X8mQG0GuwoxfhpbGk7ditfNqKh0LZYyEdBR80o/6Wuxub/mOGtd09IRbimNhcjOgjPkQ6yQAR8H9MFo0Hq1QpCkX5dm7rYD0roFhlABx1+QxsKZi6ovwd7D9UucHaDTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5poAuu4oiSpXMe0js1o3Gvw/Y9Xni67aNs+yBbqza3I=;
 b=eoA7BUqc3H3tSb42PpvtVBnJptMDLrtJeuJAJuhSoqiJoyvgnQZ8+Mu0eDEACLFNpxKPIvkvA06SCdWNM7nZLCEp9ir2HfndfhTKeecF5RdPLEhG0IrFoqXsAVBFUR+4ybZ+wDFhIX6FKoXgh/k1V3OkxK2sC4EWEior0BIrJRv0/MT2+odGLAHZux/+tEOQeQUdRWJ2dEQAiHJPFyR4wKnNkjakf6UxGzAyKHT755zp4YsqBPHoyV0bDlCNeyoTAv97MHZFpyWAkGZ73kPRFZm5olEn2MEL8jffS1GGUAqwCInCjwVkNwu9zh8ydCUvTSb/ARKCfHnQzU+E/RVJMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5poAuu4oiSpXMe0js1o3Gvw/Y9Xni67aNs+yBbqza3I=;
 b=aLTPQjcHV6BcKvjSmuJPqsHRt+xNOmKP7psp8pXmHuulkHO8hgkcdoaktkCpVu51o3UVIephuapR0J96qlUEdXaUS62gUSg5zJkHtEy5Qv9kWowWTjQ79X5miNvrdAc2Be2tcLL6WF7xeDQgIlqdOYkyIWNaAOKHuSga8pu/Mrc=
Received: from BN8PR03CA0004.namprd03.prod.outlook.com (2603:10b6:408:94::17)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 19:32:20 +0000
Received: from BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::1d) by BN8PR03CA0004.outlook.office365.com
 (2603:10b6:408:94::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 19:32:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT076.mail.protection.outlook.com (10.13.176.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 19:32:20 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 14:32:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 12:32:19 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 26 Jul 2023 14:32:19 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] drm/amd/display: Promote DC to 2.3.245
Date: Wed, 26 Jul 2023 15:27:46 -0400
Message-ID: <20230726193155.2525270-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726193155.2525270-1-aurabindo.pillai@amd.com>
References: <20230726193155.2525270-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT076:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e58e99-b24a-4aae-cc45-08db8e0f0787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kiW8QmePFY1bW/2nCqKkK3JNwXl9jKf/J7jamJ9fsyf7Esja+5BY0DAM8ih3RGeB/lfnzZ77i7lsUMSzsPCLsmmhfiZvyyi3GGspMqnmab+2XvIoU4Ayiq5dQfJfvW6jVitDqOOkW2R0W538EW+3HcqES7e9a+MMC/l0SYo4SQjk0Q6XarbB3+2kiKnSXh2GlHX1M4W4Z5/a2oxoJj7oMPeOgreKRV/+z9AGe6i22hiufY75Xo/biYm+nmu2kna5MCSPXPGiks75sTZkJpqrT2IlXYkTfi55hWLee4FFNYE1fDq6SIv12wjHR6rgFbMtnYpEECaPTH5HRasHzLlQRYaHffTj2JBgU8aK+C7neDuYa50d5SnWEaDIMN0rsBxk2wPUrJ7Qk5fn/Rbq5B7TY+MOhYnAwv+Zv8xLC7PUpF9UFCOGj4ggBZAdq3o96Q2x0cSDCEyw1MtwApQPD7i5vike4qPSmUv32iMRrycdQE+CUWT9mJBg0vDyX4YTfaegU9JWVBy3sS3MM8crgQid7XGxhBXHCprwXkxYdS3kzKLOe46Nw+C4v55ylK8hJncbDU5p1W8vOZ0dA1mgo4cXvy3gaNdZnKAbiADn0MV9e/rgc/zXP69TMvPNii6dgHn0yRkgQhezsl7TUpR9tKuqOqVYiY8kPZfhLRGb1RygQnBp20q35cuXRQYQ7JKQlhIHuWEq9XzZvzGxLPwCEpnHpA9sYZ2Z947GGmKyllxHMeyZPr4hGYp2KD5DaSHTG9LGnx+EvDj5uf+Mh7e9O7EwFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(86362001)(356005)(81166007)(36756003)(40460700003)(2906002)(4744005)(54906003)(478600001)(82740400003)(40480700001)(36860700001)(47076005)(186003)(1076003)(2616005)(26005)(336012)(426003)(41300700001)(44832011)(5660300002)(7696005)(6666004)(70206006)(8676002)(70586007)(316002)(83380400001)(6916009)(4326008)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 19:32:20.4582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e58e99-b24a-4aae-cc45-08db8e0f0787
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859
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
index 0b704f1a32a6..ee9226f3ab7c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.244"
+#define DC_VER "3.2.245"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.41.0

