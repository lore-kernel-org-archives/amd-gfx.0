Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37257C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC7E460F46
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC7E460F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6B156EE60;
	Thu, 29 Jul 2021 20:37:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 192C66EE60
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 20:37:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpMq8LNs91VsjwEMbbkhupJOmlwtli+B1LMOu51yaJk3MbzkQSE84qoSmQxmqsVdY6v/S/inEGeWu5solrdx+Z/dv4Yn6+ILvPD2MnrpUv3hRPXCEN9TETTkB3KfU960qqhJ5z9IJyXg8IRpF3Eh5na2eF1fW6Sw0Gk4GCjSEpUyjkakAVPzbBxfBGVibioI6O11ZQUGMRT1Iy47lf5HDpiFuEmG00OfQqot+Pelkj3yfZgPWGPYt45oDQJCVwn3ajhovK4Ebhu6Kqk9x6Dvec1cObU/4v4fTi57y+l/qzHB4L11vFULSgHrt9yC7LLr1xEz553jjHTe6341dFk8+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yz85/fQiJkC+7n8OjqXKyAt8EOjJ93QPNWNCJSctODQ=;
 b=XmkvAUebiundb3iN9oq6n9BEsjj+zOiPbHl8E97243Atjt5J5m4jgDdj5df1gCWq7k3TMnRAT0fiFgZ2IWWz+/0h8z6LbHlExXhi3bKKl9ltoyGLQlBSF08nqi0t51BbIPORJICR/c7bBlDk+RIEbGOdbrvIAU7SD+3CvuJQ5NG/SJRHk/0XgiBDv7IW1VtlKaNkjXQLnEi3dKj7QD8UnqUibWPB1k8qn+wDQXw+sGbJ57YkFpbK+WIeB3n/mssto56jizUPtR+Js0f9sPbX8tHMGFKR5tIJeOEPHorh6BUBtm7a0lEK7CQpjOH4ras3oUArJeYNH6tnl83LX6Rbuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yz85/fQiJkC+7n8OjqXKyAt8EOjJ93QPNWNCJSctODQ=;
 b=2hUOoH90k57NO41LIt5HOiTCCXFX44o5MklVjlyZROoo7EEhmRu+slfNicBgb3RBgEJnVxg5nttpgxeTL4vEwf7UNKf7kafiFw7xcELi3PDNMhYUGa5/HKVpyxj6bncu3Wvzo4ZWBxuW3xMj+IwHdRefStx4HsTiEZDc/QRkLmk=
Received: from BN9PR03CA0294.namprd03.prod.outlook.com (2603:10b6:408:f5::29)
 by BYAPR12MB3575.namprd12.prod.outlook.com (2603:10b6:a03:ab::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Thu, 29 Jul
 2021 20:37:31 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::32) by BN9PR03CA0294.outlook.office365.com
 (2603:10b6:408:f5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Thu, 29 Jul 2021 20:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 20:37:30 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 15:37:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 13:37:30 -0700
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Thu, 29 Jul 2021 15:37:29 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/9] drm/amd/display: [FW Promotion] Release 0.0.77
Date: Thu, 29 Jul 2021 16:37:11 -0400
Message-ID: <20210729203712.1566129-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729203712.1566129-1-aurabindo.pillai@amd.com>
References: <20210729203712.1566129-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fd7f6e1-de1b-43eb-3557-08d952d0afdd
X-MS-TrafficTypeDiagnostic: BYAPR12MB3575:
X-Microsoft-Antispam-PRVS: <BYAPR12MB35750877E5300360C8359D9B8BEB9@BYAPR12MB3575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fE+4PsnsLgp+mum8EPt7V5HmhCC+gJm54f9GujtJpvPfh2+Ch33yPuBg+faJ8Pjt5vutM0SzXZ5y5x7vpzv92EFxMGRYeYqrIe0RYMUovSUsFxmcJD2Q4MySmU/YC7jELXNOeAslJhuct0ErXqPbTlulVUcsN97jWTKWJDtHt5x0a6xprVcmqE1Zweu/8iX3aWLHzdnqFDUDlwizFIUUOxz9MGe1oXUg18qoHrc/b0vwEbbiMI6RsnbOxJ2nl6v39V3iEIneVDa1ep1qPWOLGP13BvdkqwXkJiW2q2SnLjooUFPezY95EbaOckqXxtibiRdfsdlD4JP3JsL/Ko5ww1R3m88ElEZNY1tcy/dumd1MHS/cILRUw6dR19en8kV5DIf2QMJz0S7gJic7gWuaKkouVSfbBhf7vJCfpgwRVWtNWn2IrAHVZYR2P+ywEOEE7hKNgRgSt31Nz0SHUn/hrRDbm4vQOkGJrpyTQEet2ROnlZfmScmZU3LLXsH2fdVEFKzScb/712ItYwlpIb4DjnYXQ/wlBnIeVk+ECfcroiCk61cHHymXqfy4bL/XEyR4uukKMtwZqF9ZjSZfkOQOkrMXd/4vTqrM3veaFyfujGGfPwNny/4/4jTL5PIY1qHVp2TN2zqdMvEDzFXp4hzm12pR1Gdnt+rcQjfjRpiAt6Igrskq50NXtmAn4N7m3E5SFLEc3Bq1Tat7NJnGYIIKE1X3xP/DbYE0CVYT4TgYxsk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(36840700001)(46966006)(1076003)(44832011)(70586007)(6666004)(36756003)(70206006)(316002)(81166007)(478600001)(186003)(26005)(7696005)(47076005)(4744005)(336012)(2616005)(4326008)(8936002)(86362001)(426003)(54906003)(82740400003)(5660300002)(83380400001)(2906002)(356005)(6916009)(36860700001)(8676002)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 20:37:30.6391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd7f6e1-de1b-43eb-3557-08d952d0afdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3575
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 02921ad22310..aa2707e469c1 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xe599e0896
+#define DMUB_FW_VERSION_GIT_HASH 0x6d13d5e2c
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 76
+#define DMUB_FW_VERSION_REVISION 77
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
