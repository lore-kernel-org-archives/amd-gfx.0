Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24ADC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8E85206D4
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E85206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 544AC89708;
	Fri, 15 Jan 2021 17:31:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 135D389708
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 17:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mh++Pc+gX/rPWJqHK9JJOw33cSHSLvCGHRqhNp23at/kvoQRDEbq7+xrOfWbCXiXAaXcKUCyJRw9lS7d833HXpHnD5lR3vWNzJwJt/dT5aqvBIRMIvG3ID9UgX0ETPSuY4r0cEi8U0nCKKhhOQrJZHushyOxSIYbKiCfD4yOAAwKmY27GScGzbGjPbRxSWKDKs8l7jXbBhDCnny+wBm9zpJKi/32udS1qYEE34Asvtk0fIpyguuziefBqeojetagLhHMakGa6ppliJeodMQgIu5Qk/OhWXLApmqP96uKPK+2qiEF5maAq5OSs14+cyRwJaVKKF588n15xpZhU/k8Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceFKaQ9pGV2mn3AkNL6lCUCebaIjY337fT6en2PDBZA=;
 b=QOJzUxmj+7hHaprUc/1/Y5YFnRL8enSLXdgo8PhQ80bfWB/8WxYfRxN6/8Qg72mIFCnX5ilqjzc24uZJ7CEGUb08uB0XNkyA3qWA1pbySY9gEIF2/vtmvZ7aLFkUVymNWXA1l8Ki63jqjca0S0AaW5p62W5EVZmFVEKmaB1vWZoCLzlfsVEQPztUHeQ0t5KQoZRh4NsV+dgHJX6zpG0iMXKpoJD4450h1ap484n2vvoLDr0WVeOOkTmzD1yiHFnxc4Mxvc5I4SjaIhFs0MbMrbsdeAF3lRTMAltq6NZwZ4WNl8C2xfy1MJrLfc6dCahPgQKTUUSiws9pIhmmOrkqeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceFKaQ9pGV2mn3AkNL6lCUCebaIjY337fT6en2PDBZA=;
 b=S88cbrcnvudCEygEhhy9+unvAiKrQpvYx8wpGqDZ5FWe3Cq8h5Z4TAxrw85Ebo8rBPlrhu6DtWXhNbWHenwkulZumB8fkxY428OqwLGY9TvPiBEeyoTcbhHQ8G1k3XWqnEOXssGMEzLDuHyFfFqHfHypOLgMoP4uc2vc76k2ckI=
Received: from BN1PR13CA0002.namprd13.prod.outlook.com (2603:10b6:408:e2::7)
 by BYAPR12MB4711.namprd12.prod.outlook.com (2603:10b6:a03:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Fri, 15 Jan
 2021 17:31:55 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::d9) by BN1PR13CA0002.outlook.office365.com
 (2603:10b6:408:e2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.4 via Frontend
 Transport; Fri, 15 Jan 2021 17:31:55 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Fri, 15 Jan 2021 17:31:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:31:52 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:31:52 -0600
Received: from ajacob-ThinkPad-X250.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 15 Jan 2021 11:31:46 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/16] drm/amd/display: [FW Promotion] Release 0.0.48
Date: Fri, 15 Jan 2021 12:27:17 -0500
Message-ID: <20210115172714.126866-16-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115172714.126866-1-Anson.Jacob@amd.com>
References: <20210115172714.126866-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5005d631-3ea8-45cb-2716-08d8b97b72c6
X-MS-TrafficTypeDiagnostic: BYAPR12MB4711:
X-Microsoft-Antispam-PRVS: <BYAPR12MB47112935A15F7F5850F109E5EBA70@BYAPR12MB4711.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0/Lo7DInzlvGl2dns4O/xfbGHdXftaediH8V29odov3SOlpYAARqlV2rRKEi59l0KpmApXd2ct+c5FfXMVYMFKu8TXnAgNcTyoWrKu4T0nMV0emVu393CUedrHHOgLEIpgL8xiSgwoiBnbopm5mE7vv9EPNQPUmhZOjqc7LaOm79RTENsKDL83Jpv2SyrR/kCVWLpLffgFsvbORmClyy/y/pby+28+thS/4YquYoCz78Ti/EN+drRYMhqTSU0dFkeaSZ8a1WIP7fl3NrRfFXZKj4p/A8vpLr4Ux1njCzwts8G2M22gBIx7vyVQD6FC26vKlO0RhHry5YQ/Ujxy3lXEyrddAW4+twZ+4CiTVrWW3wiSym+UgJ4rDcODkXNt9Q7VtMgGpLRYEUlnE8yCouBWm/R6YgX5Kzueu7hOr3Fc08GnsWRzZBTf1P4yfJN5NRl8rAxz0AUnSrrTWb6aK01IOzYUYz2tT1YECSWj0uGkMk7bABFXMBVEQNC+o/iwd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(186003)(426003)(8936002)(2616005)(82740400003)(316002)(26005)(82310400003)(70206006)(8676002)(336012)(4326008)(2906002)(70586007)(6666004)(34020700004)(4744005)(6916009)(83380400001)(5660300002)(47076005)(356005)(478600001)(86362001)(7696005)(54906003)(81166007)(36756003)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 17:31:53.0210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5005d631-3ea8-45cb-2716-08d8b97b72c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4711
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
 Anson Jacob <anson.jacob@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Anson Jacob <anson.jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 249a076d6f69..a50bdd6c7131 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xf51b86a
+#define DMUB_FW_VERSION_GIT_HASH 0xf09c02ae3
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 47
+#define DMUB_FW_VERSION_REVISION 48
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
