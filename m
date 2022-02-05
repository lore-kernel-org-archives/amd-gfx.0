Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED0DC433F5
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 01:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 084A610E43C;
	Sat,  5 Feb 2022 01:51:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2B6110E43C
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 01:51:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4ZbjZhkHzXec1SEPv8MPkNzV2v4+EeLtGYKYZKa7D8FoEogC56Q9KINs5EtjNcn5Q9KWfpwBS5/ft4OaMUiC2eEhP780FgPFwWNyFZfvyW8pd7VgdYYrQAvvPRANQ4daAMxjT101QPGhS73qaO0Zx6xxS2EnsFvyBJhf1RpJujTcLB2sJnaZDdoSgf3QYd2NoGJ0R/1uZbsAd0CbY3DFKHH5Kca4jeb0g3Tgus32dmuIuBesIQGcjQecZ5TvpWgeVCAjSaV87H6M5YHblZ572jzpJAmU/05nkn9jPpvjB1bo2mUhyEuzIXZnPWKxnnn8YUQSEsACM/IpuOg9UNEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFJ1No7RLzQfHhpiXCzC06hXoZ7FJIXE60em7Gyu8iU=;
 b=GXtc4B8del3PyS4l+QXFIAgyRq0ATB8o225pxg6dgxeocy7SAgrKImBvULyNoXWs/HuQF9m7vaN1FWXfKJ3oc9o7dExRe7+21OWBSwlw85mQwv18orACdkx4Y0/1AijQ4oYNLrmdxK8WYhGOjO2wXmkTz6JKwM9lk9rMvPelwYFsu2O1r57nEPehoeVf0jouyUUpnb3gegN1FLZ6M/w2a2Yq6jIzVgbNZsOOwKzsD5WsAKTT0uDwUSC1GuGtKo4gUlIRMp8AtBtTJVYPxU+f45IRrRhKScIa4GwEnO4x4MOPpoXZxD39ths9UturdRRJLN0xyJzCAcHlQ3SekTTe6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFJ1No7RLzQfHhpiXCzC06hXoZ7FJIXE60em7Gyu8iU=;
 b=R0lYn6LlBuPKu3+UOrUoGtGH5MZLbtXKMs//bPRPKUd34cZ2QTwr7WLmCWHfVSrP1nx+T5WsRElGi+1BB01GJ4xh7/0K1f8Bfsw5RxFBAzYXKyJ+gyuhGCyPDjEsBHJaSaNvD/TutB31j7WLV5+AK252308rDSPciFYq0Do3lpo=
Received: from MWHPR1701CA0001.namprd17.prod.outlook.com
 (2603:10b6:301:14::11) by BYAPR12MB4712.namprd12.prod.outlook.com
 (2603:10b6:a03:9d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 01:51:10 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::b4) by MWHPR1701CA0001.outlook.office365.com
 (2603:10b6:301:14::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Sat, 5 Feb 2022 01:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 01:51:09 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 19:51:05 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/14] SWDEV-321758 - dc: Code clean
Date: Fri, 4 Feb 2022 20:50:29 -0500
Message-ID: <20220205015029.143768-15-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205015029.143768-1-jdhillon@amd.com>
References: <20220205015029.143768-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e20340a8-979a-4963-a952-08d9e849fb9a
X-MS-TrafficTypeDiagnostic: BYAPR12MB4712:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4712A2FFCEE8A40574FD384EFB2A9@BYAPR12MB4712.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:118;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pTlpTwqM85Np1WNf9yxObfgIRT2SR81aId29igpmRePpvU38033cyWsPwsR5Cdwo5BlhWa4OsMgOQjeItUBrlrgdsXuh0TOjaQQcUwZCrB73KuaaURPxzHGcKKcLqRWQ7DbVNP4UzGy6tzDrnalFKlFchHQ8+kV//cLPhPoTKRXnUfWRfhfTmT3wD1H1GD2iEerl3IqfGkykI4Ikg4UyV7XxsQ+1vm33kEvOltqeNxzCFf0Td10t/Gkt+1jHAUaX/B9kxEZNwLbUkqS/Ro9PCIMVXQbpAHAeR1KtTZBi0tsPPXDTptj73Zl+3GAM08niTCj9I/D/QjBUbXT2jUtaUwOc8RIA0+0rxmQAjqA3noQnZRbA3pVzYcR6Yo7uY7eb0u2ad/ZpUZR88VZdF9e3uKGGiUgxR8clqWTaqT34fZG/yiN9czwyqwusagGytxf2JXp4tuqrs+5pInqKcoB9RuXwgi/Tz8fJyhL5yl/ch7h5WldKO16eWtYwpMBMzbAVXDz2nApHnx68zZy8ZAPZBHXRmMMuNt9VERNjGIDC08WtZ8T+pPiYdGH/UXX9CrwBV/HOLGGcSCArdiHsCC+RgySZ23TWVfCtNZ+BRYTT9ueG0EBxdG8L73sSb1uaVerq0mbRhvfDdNziwyXtvolOmlO5XIdj1P/EIf2pJGeIqxRvydn2rsmgVvgf9HuHDGLJhA9W9JNyeDHXnCisCUQTfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(47076005)(36756003)(316002)(6916009)(54906003)(36860700001)(5660300002)(40460700003)(16526019)(4326008)(82310400004)(186003)(8676002)(70586007)(4744005)(356005)(26005)(83380400001)(81166007)(426003)(1076003)(6666004)(336012)(2616005)(70206006)(2906002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 01:51:09.9234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e20340a8-979a-4963-a952-08d9e849fb9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4712
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
Cc: stylon.wang@amd.com, Oliver Logush <oliver.logush@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oliver Logush <oliver.logush@amd.com>

Signed-off-by: Oliver Logush <oliver.logush@amd.com>
---
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index c25bc4d9cd4b..16c5c929e8d5 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -212,7 +212,7 @@ enum {
 #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= GREEN_SARDINE_A0) && (eChipRev < 0xFF))
 #endif
 #define DEVICE_ID_NV_NAVI10_LITE_P_13FE          0x13FE  // CYAN_SKILLFISH
-#define DEVICE_ID_NV_NAVI10_LITE_P_143F			0x143F // ROBIN+
+#define DEVICE_ID_NV_NAVI10_LITE_P_143F			0x143F
 #define FAMILY_VGH 144
 #define DEVICE_ID_VGH_163F 0x163F
 #define VANGOGH_A0 0x01
-- 
2.25.1

