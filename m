Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25795ECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A61810EB5C;
	Sat, 27 Aug 2022 02:50:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3BDC10EB53
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiaoyytLVaYEn79z9TYlGLFjchwg4NhJR6g5oi8WbVbxZVGn1SOSWxLLAiM/IaQ9b7eyTnnvF2wnK7FaoUv3JGSy+u38vzWURm9Xhoeiz1wNpejSWxfrAXEjEPJhzxY8dR84WvNuy2eZe9UXOIUxde/e4bbMb+klNuFzElPi1lFb9OJrdeU2EkfO5XS5aS7GWRqvpgweFAieHooUiKZMY1+JuFsEi68fcjFT37hReE7G6InabfDTny0BhrwilU/rK1P5nLRDiR7iDhkufHOT4jTzaWOSJy9SWEz1irNWPHBXzO6ldaa0VSJv2st8Syj8PT/9JV8X+FKxaqt6osR2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QO5SV1DgCDgr+6OJQ99v3z4Cc1p/CdOQ6xMOWDAQZpw=;
 b=R5nHZzvtnpvgHjQHZ7EZidAIkDtOYzQI44T5R4tFFn/TicBxSqztzzTNTJRFiO297fsEE6mCLo81zj+RIByGnYUO7AxUOpYYNGWAd9nUhYDPwzn829cDHnHCNeJi14zRRxOx3Tuu0+qRYQEDuLsWAozANLo57WB3sbACihIfj7UwdCb2NxUFC/UpbR/MEUV9Fg/sD5qok2812TUN2hQPzfIxNvY3Pzm6hawLPYcpOlLOLGLdmI9G0ZMp+EIXY80kSzeT6MXEack9XJ4pDDkbMbuyUMBrkHC1x4z1+jTOSNp5k0BTetjTB1ZEj7F2IAnItAV0e2rdH8YNJCmfuwH2tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QO5SV1DgCDgr+6OJQ99v3z4Cc1p/CdOQ6xMOWDAQZpw=;
 b=TcreNT80/Kwmo76e7zEPSEJB3eQRaO8eEezOKTYQpe/1XQtHIw11Uysu/bBEpn3gWtywOi3nIOWibRXmrGVezIpaxCIuQvxu/Oj+lRDRi1rj33nVyBVgzVWD4EAUNkyhGPef9NWUodOydqOAT1JmofStolos6/X6r6+gwe+3WCY=
Received: from DS7PR05CA0021.namprd05.prod.outlook.com (2603:10b6:5:3b9::26)
 by BN9PR12MB5227.namprd12.prod.outlook.com (2603:10b6:408:100::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 02:50:30 +0000
Received: from CY4PEPF0000B8ED.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::d0) by DS7PR05CA0021.outlook.office365.com
 (2603:10b6:5:3b9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.4 via Frontend
 Transport; Sat, 27 Aug 2022 02:50:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000B8ED.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.14 via Frontend Transport; Sat, 27 Aug 2022 02:50:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:50:28 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:50:24
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/33] drm/amd/display: Fix OTG H timing reset for dcn314
Date: Sat, 27 Aug 2022 06:50:25 +0800
Message-ID: <20220826225053.1435588-6-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f21cf14-2a12-4f44-be22-08da87d6e738
X-MS-TrafficTypeDiagnostic: BN9PR12MB5227:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pLrGx3fKlGe6wqVCjc+blppRbnXb9VkoVK+z2Zka3PLSjlymE14pv/5gcvbIC4jWJyUFK1pSjr4JU2YyN4qNrEqrgEgbYRSokHSjfPT2NggK1MYNKMOkg8ysW3TKvpFt5mcN9onARvMH+FcmBQcdHgmGNeAbwxxr3/cGYbteDiFtvbTwLxbxGXMZdUTvxelAmJue/m/PmwAWjC1AkFglX9Hlaokkxy8Px+77A30b6ivMdJT99+D5wDWJvQxLKI8o8DqMgeOCybscanuw3qFCkKhQhvaAVoDhxrAnhrzPavQJZGkfk0Tx2AKnxlFxM5rHgG0W0J019HG2Zz+BCIm4S0GAkQZpUuXPorynYvMz0c/8HqF9xNnV0tCx52CXY2AoK5YC10oeC6ftI+weiQMjeHAi0Xydymi90nxQe2US1TbnspT3LQhaQobHegfqVzmSCA2OHDdIqh7/gkVHieAC7C0iBLCBdaQHIy5VfSdcMyKBlSBYwvJVjkBhEGRKW8ZkpQWmLX5RrMWIDwYrSM/akSqyWGr4ebDUk97E3RDA7ymjltrzuuFPb+kNlZvHuhPqYuLnErDCYqIGj3DPTpkx+4IRNifAoilOelhgx9I9ZcWcoCcaM0sR9yMIypatCEQL4EdmiaGtdkcapqnnrOBcuJ/PGJ/hYhcdO+8mD/jLeflsgSWef6f76V9CXCzyXk+VXjrjuugX+0vqYEAdcXjkrQG75sTZ2Y8JDmkUZvy9GuS19eCgTdLbksdxVFGN2K+bq4+q4GhhELFII3WM2hc2pV1EHhtD66qqx+/bnO956Ag0SWeDsuyMY5NFlO/igL63BiO8TPvAAXG6R2C1ucn8CQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(40470700004)(36840700001)(46966006)(83380400001)(1076003)(82310400005)(47076005)(2616005)(5660300002)(4326008)(70206006)(70586007)(8676002)(2906002)(26005)(7696005)(36756003)(478600001)(40480700001)(336012)(186003)(426003)(41300700001)(8936002)(40460700003)(86362001)(36860700001)(6916009)(54906003)(82740400003)(356005)(81166007)(316002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:50:29.7103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f21cf14-2a12-4f44-be22-08da87d6e738
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5227
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Duncan Ma <duncan.ma@amd.com>, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Duncan Ma <duncan.ma@amd.com>

[Why]
When ODM is enabled, H timing control register reset
to 0. Div mode manual field get overwritten causing
no display on certain modes for dcn314.

[How]
Use REG_UPDATE instead of REG_SET to set div_mode
field.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Duncan Ma <duncan.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
index 0c7980266b85..38aa28ec6b13 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
@@ -98,7 +98,8 @@ static void optc314_set_odm_combine(struct timing_generator *optc, int *opp_id,
 	REG_UPDATE(OPTC_WIDTH_CONTROL,
 			OPTC_SEGMENT_WIDTH, mpcc_hactive);
 
-	REG_SET(OTG_H_TIMING_CNTL, 0, OTG_H_TIMING_DIV_MODE, opp_cnt - 1);
+	REG_UPDATE(OTG_H_TIMING_CNTL,
+			OTG_H_TIMING_DIV_MODE, opp_cnt - 1);
 	optc1->opp_count = opp_cnt;
 }
 
-- 
2.25.1

