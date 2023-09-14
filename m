Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243F8EE0212
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B63810E20F;
	Thu, 14 Sep 2023 02:01:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C0A910E20F
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:01:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDrD4lFkxMc/ySObEVRoyoc2MNMnt1UIf/yi6jCG2BhkBbsL6HM1Y3MG7Tr0w4SeBEztdStf77rldXrodyG5DQ6aHPzlkLCsz+pTPA3niQZNX9/8qAjp+sjTwnqHbIn/UZUYlPPnBcMl59vqbLqNyJYKYlCCpK5VR3YuZpm5i/gijkBO14eElllbE4BcHpcqB7YswZ/gAQoBRh0FB+G0vdPWJGkixWEzop/24Xo4z/HCVqSWkM/EFf6NklA72373uJGAvYACve7yds4NVGz+O7uyw3eq62/12FlJYIT0nO1yJ2x7bEgtLANYQg35ZCtwkTtwKHmXdd8t7+Oo5KgZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqZpxQv0X8MpKqYVu6Z6/G0B91p6r0rCttE6KWqEWl8=;
 b=IRuWT9uJbUJc/hhht+EQCd20kXrJ6pjdpS3LP46Coz8wDDCKDxvlol62JPUWG6KgfzsnueChWvj1f+s3UT+qjyVZQPzaBwc+CCh4gPqNRiqyewU0k1GnCnluHaLWa7S1AuBxIdX2Nvup6vjBQ5L1YbhoelFXM03oKrBQRe9LN4sevbaoptYxV+BjXJQBRfh8W5rXord9sKf4x6cKpwWJowU6FDd5AZ8tEOqu8P+bvWLkonFeSQDMw+gIsQyJZMKCBWcNjp+lqs/vSVeTn18SEa6AN5x7DnbEMdV/ep/DjUwAIoP9blxeb6zcbhXVaPMCJ54bNbO2CGFu7n5UTRQtkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqZpxQv0X8MpKqYVu6Z6/G0B91p6r0rCttE6KWqEWl8=;
 b=OF5cyRyQE8q1ggNby0XQRaT77bGP9Au2H6pElxQYv7l6+1NRWLtC7SItu5EANKVRkGBcOkrmRc34hloE3HuE0Ijq6c4stk27C92SD999l62MjIsnHoe5BOOZv308b0V9uh7P1Bd9pOVeKNHTN0fXNanXt1zPHtD7C+2LRQ3ytWI=
Received: from BY5PR17CA0001.namprd17.prod.outlook.com (2603:10b6:a03:1b8::14)
 by DM4PR12MB6663.namprd12.prod.outlook.com (2603:10b6:8:8f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Thu, 14 Sep
 2023 02:01:19 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::d4) by BY5PR17CA0001.outlook.office365.com
 (2603:10b6:a03:1b8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 02:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:01:18 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:16 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/28] drm/amd/display: Add reset for SYMCLKC_FE_SRC_SEL
Date: Wed, 13 Sep 2023 19:59:54 -0600
Message-ID: <20230914020021.2890026-2-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|DM4PR12MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 6712a9c3-fd2c-4b37-a587-08dbb4c67c89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +yYsXO7Dv8pmpGJY54+fEDxldpl2t4U2iLoAenhlXYXhzqo28uHLKPt3EcohW77Sfq+r13pq2QQVKruyxT+mwkbOJ35Q8rFDgvDmmEisjsEI9emOTVBvcFjxU7WHzMMkwVcpIDy5ZAiSoi+THexRytFuzTaSoBiH1USuHWhWDggeX5W/pfQuSkB4DNV8WBmVRywFM7RYuLutSFUC4jYo5NvZ766IXKmUlivO5MfTh+c6r9eHnqG9GC7dZP5/Oepg1w08K8d9F0kTkYQC9tdb2+KMfxJ2JhOBWFzgURklxScp2SQm2719egn4WaEuWVGSP6fz+eJXXcOJAnbDaklQN7Yy67fhoTrfx2/IQK8i6k+DPvEQDKUpVppXdMzZO4LaSxngDi56mwam3yMAFHB+o6UodF8+aJa/+Rqi7bv75U9skPJdfThizfV2Ej3RyT2o1Ba8bdlb+i5ssaxODtwXjyx02O/t7wRSZYDQEAYoL0zak8tFRbAFaI7S3PmyBKISUudTnMpPFxc7hpEfTZQ3KBimz+IoWF2dFpkzJuMZ9p3jF58WfjfQz3U/mMy1MxuwYd0bwcaG39+6A/lPAdONX0WDsz2+uQtML1uJ4RIZylvCK6DdZjQwfqkV7gc2C9CmyXHNWNj+UQyX/OXN3jHDl0GqMaHqbJlZ+C0ANXdzGKtwg9ebM92kSasADsPMxKqgvAcdWxGw5wyFnoiuZAx1hyj1EVYvWZZs6SO+Euey0Fkc/imYcW0vG8cQMLE5dtb92xKYdDFWx7Yw5QB8yBEGUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199024)(1800799009)(186009)(82310400011)(40470700004)(46966006)(36840700001)(47076005)(70586007)(5660300002)(86362001)(40460700003)(36756003)(356005)(8936002)(4326008)(82740400003)(8676002)(81166007)(36860700001)(54906003)(83380400001)(40480700001)(2906002)(316002)(336012)(41300700001)(6916009)(426003)(1076003)(70206006)(2616005)(26005)(16526019)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:01:18.8352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6712a9c3-fd2c-4b37-a587-08dbb4c67c89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6663
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Taimur Hassan <syed.hassan@amd.com>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <syed.hassan@amd.com>

[Why & How]
To prevent confusion after symclk has already been disabled.

Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Taimur Hassan <syed.hassan@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c | 25 +++++++++++--------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
index 3a322fda35d3..70a66df8315a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
@@ -641,24 +641,29 @@ static void dccg35_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst
 
 	switch (stream_enc_inst) {
 	case 0:
-		REG_UPDATE(SYMCLKA_CLOCK_ENABLE,
-				SYMCLKA_FE_EN, 0);
+		REG_UPDATE_2(SYMCLKA_CLOCK_ENABLE,
+				SYMCLKA_FE_EN, 0,
+				SYMCLKA_FE_SRC_SEL, 0);
 		break;
 	case 1:
-		REG_UPDATE(SYMCLKB_CLOCK_ENABLE,
-				SYMCLKB_FE_EN, 0);
+		REG_UPDATE_2(SYMCLKB_CLOCK_ENABLE,
+				SYMCLKB_FE_EN, 0,
+				SYMCLKB_FE_SRC_SEL, 0);
 		break;
 	case 2:
-		REG_UPDATE(SYMCLKC_CLOCK_ENABLE,
-				SYMCLKC_FE_EN, 0);
+		REG_UPDATE_2(SYMCLKC_CLOCK_ENABLE,
+				SYMCLKC_FE_EN, 0,
+				SYMCLKC_FE_SRC_SEL, 0);
 		break;
 	case 3:
-		REG_UPDATE(SYMCLKD_CLOCK_ENABLE,
-				SYMCLKD_FE_EN, 0);
+		REG_UPDATE_2(SYMCLKD_CLOCK_ENABLE,
+				SYMCLKD_FE_EN, 0,
+				SYMCLKD_FE_SRC_SEL, 0);
 		break;
 	case 4:
-		REG_UPDATE(SYMCLKE_CLOCK_ENABLE,
-				SYMCLKE_FE_EN, 0);
+		REG_UPDATE_2(SYMCLKE_CLOCK_ENABLE,
+				SYMCLKE_FE_EN, 0,
+				SYMCLKE_FE_SRC_SEL, 0);
 		break;
 	}
 
-- 
2.40.1

