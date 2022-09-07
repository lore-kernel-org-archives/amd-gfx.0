Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEF2C6FA89
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1779610E81D;
	Wed,  7 Sep 2022 18:12:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96D7010E80D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2nFkiRARUZ1WENt93UThBIlY/RJv0ce9cxCE3GiuWHl6fP1OaIlOVN29ZqkUsqZdbtjgeuVOxLpdnmAWpNRsYjhhZTkN9hNpdm2EcPUhsMB4O2bIjv8GH2p38j8FL3uN2Wt34XQlO3QMNCJKsaQzuaI4Mip5Yxll/RHiO36SXQdx83ifpc4p2vCgWm8OI0sjoeerLiAZlk6wKBrN9a+zIFNoKEtMP4rApnOQ9b3aPBHn/XccSUJuakFrwFvSYrRf1qnpZkyDcK4+nF548At2c6azV9/91pj8FKf0cq4tX+kcPI2StmISHu0nVrHE8jpp+bpq202+JUCeh4c0P3pKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMyyFCJgf0zBWhti9XTymTJqan1ol0j5N4YqdXxyxdc=;
 b=F6qNdE+EGvGSMzJK+WA/TMUPxVmbRgGcAvx6bcEYgvYysH4cDzADolkkkzcIPZjfg0AVtOVC7HC/JAtv3mMRKEZpnQTAgLNGzTxwtgTaBhppueaRuS/H2ISRYOGpgIspe9uFL/5DTFnSJc3hS7mFEP0FTaxcHq9WWAf0TJfXP38NhoIYAMrAsBrK0uPn9cD3NpPMkeiUQlvNyAlk48m1lDeAeBTAPJ3R9IuISCkJ+2cN/cpgPFDf3k/dwxTxGZBMZt77eMPl/LQCcifnDp5cHKmTBZz3SUcXi2izNnIAaR/SlWKNDgRF5PzpCYZlWf1ULa9ezsI/BWcHdn/yCH16MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMyyFCJgf0zBWhti9XTymTJqan1ol0j5N4YqdXxyxdc=;
 b=s7A+jdSpozjwAiuxyzmrmTOrTosWHQtixAFMaQK4G5ryoq3WFtpfOjrR50P4XfY363l2x8PMJ1XM2rLnLF/xkbt3MLmKib6oDLsD0ys0yZUWiXR7+BMXQmy74Fc1BZm81rb96SwoMv+yRiGqYPiQHf4OT8qcVHIv0GLh6QXFbOc=
Received: from DM5PR07CA0119.namprd07.prod.outlook.com (2603:10b6:4:ae::48) by
 DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.11; Wed, 7 Sep 2022 18:12:39 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::5d) by DM5PR07CA0119.outlook.office365.com
 (2603:10b6:4:ae::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14 via Frontend
 Transport; Wed, 7 Sep 2022 18:12:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:12:38 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:12:37 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/21] drm/amd/display: 3.2.202
Date: Wed, 7 Sep 2022 14:12:00 -0400
Message-ID: <20220907181200.54726-21-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907181200.54726-1-pavle.kotarac@amd.com>
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|DM4PR12MB5232:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e7d95f-e022-415a-31c1-08da90fc8c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3wKzMukQPwLZa0sdNAo+enPl1we0SVMuasmzOxO4i7xEftLKkkS3JmT0QP3yKrJxrWjoKJt4pJdHka107xmmjreAI0qld11RdbZUEhdd9sEStuYyII3aRj+obEETdU0oSpEcW/4yMIAnEeyrX0qzkeL+LhfDfeVMBDFzL2VSzyzWislc+T7WSXbLUF8f82B/FcfkrZOzlG7eyM3DnU9Z8Km7JprNI5vv3Zgcu8qFJM+vuEjXIXd43DEs/B4P9i/6ADF2S+uRXIe/XcjDVq9ekocpv6KdlGuW087iZP7yiGn00E1uR/jn00C+9QH5T2BpdpxpND6uEWFPht10WPXMzgglHLnUvP1buOtZGunu1E/oapnen4Hyf0+7RZ8T7ff81Lct032Zq0IEKmgAuJ2VJPInAvmlBfW2IpL+cX2ElU0vm5Pvjfc5Hr7Ec8H3kqxXXofbLJkVzKbiO105U3dqs6sT6Edd/83c8ZAG5GE/3gg6W8SQ1LG8OJpPcrlaetSbFTxTVUmpZBU7fj88wxJIf8JF5Ogu3n7KcxbMXPuc6nkFYTw/2MNyLmUyhR+8qo2h/ON09XALCjOGskNDQu8RWdPr764+5aHvZiGl4tFFJlVphzEgaMKFOvZxqx53TIubtgCg8+PGko4V5mW7gaQ+oXVF2ATxeRxaWxVqRZfK2MZw+LHMgT71FgkSe1Xqf4jHddrbFuR1fCx8AhF9sD24Y5bUkzONM7W7nj+0jtvLb1+OA13/qTfNIse3aK08JHUo6DVUMRwid8LKChw+U4F5c57gCsRJXWXtaS0X1uQ/gceMKn0vfbLllDJs9whH7jt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(396003)(376002)(346002)(40470700004)(36840700001)(46966006)(81166007)(26005)(6916009)(54906003)(40460700003)(36756003)(7696005)(40480700001)(83380400001)(316002)(2906002)(82310400005)(82740400003)(356005)(47076005)(478600001)(70206006)(70586007)(8936002)(86362001)(426003)(36860700001)(4744005)(8676002)(4326008)(16526019)(2616005)(44832011)(186003)(6666004)(1076003)(5660300002)(336012)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:12:38.9827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e7d95f-e022-415a-31c1-08da90fc8c90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
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
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
*Fixed register definitions for DCN32/321
*Adding log for spread_spectrum_info
*Reverted DSC programming sequence change
*Correct I2C register offset *Updated DCN30 header files, viewport position for phantom pipes
*Enable dlg and vba compilation for dcn314

Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e8e8e031b9d7..53b13beff0b2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.201"
+#define DC_VER "3.2.202"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

