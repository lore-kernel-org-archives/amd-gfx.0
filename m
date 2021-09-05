Return-Path: <SRS0=lW8h=N3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D29FC433EF
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Sep 2021 23:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E2C60F8F
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Sep 2021 23:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C4E2C60F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4905189728;
	Sun,  5 Sep 2021 23:57:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AFA889728
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Sep 2021 23:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcoJXXyNjdacwR/mobZUIqcBZjA6xdYeuB7JEVoPOOqXqqJR3wGgHEMNsy+qUtoQBqe+Nd1H8DY71dhgjZNTLb3fDI0U8bKulYyKsbXpk4qqyUMOKiHa003xndnYdO27mzHQQwWPQHIIt++GM2I2fU0JiufLg9ktxqstA/10qKJ4SB1CuwJetH3rAODyx2v8Q1ZnkYqscQx2WW7X/9//V935YmByZWdGYN02cQZGKgDR5s7c0gPrRLq2fN+JFSWGM71rGbNLVaPa+rsgTCEJOmgbVeJFXITPY1PGc7AII09dV0pnGNhoIO6jMGzcJJbu4esvjYG/Qd7p5Ar3P1RKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=5tET74/rrzyDXG0/8MusDfcAiQslnoyA+BfYCXgQtTM=;
 b=nJDUsj84bcZ3LOVuFh0onKh/n7iJVL5c4p3T7GKoA52ZPWWtaNx2JToAMvRrr2JbSGbV5zwTyNPMdGH5TDd8b4eYm1zsUA8CxW3cs+rgPXQIked/9brUW8ISRDqB/ywET6A1Owg6T1YZAiY74K8kgRjnFYbA7suL0xSD5seo5S9lVW3EMtPC+Er/vA/39cpLm5uiOvXeL9sPjmL/8I0dTowApl+0TH1Oh2y/1XQHnOirydHmma4CEBmmZ1VqK5SicKGLyTp3e/IdB/l/L1wme1PFs6jVRUQ5dmaTyZEqlwxgwvNHhqDQmSPDKonLdAWfj8bSHOFuHHL8muHR6DM3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tET74/rrzyDXG0/8MusDfcAiQslnoyA+BfYCXgQtTM=;
 b=cthYaGSTGgxqd++FNNDQNlKBDxgyHkfUghxG7yIQmyMDaI6HQDQXsqzw6ktL/ol3IZn53T0FVkBbXXT4V7BitFfk1fYDoxqJiuL9bN2HOK1LjWRmCUZsi6KWWsXkmZ1tEpJxhHJv3WSA8pzwWnCXJFDtuApxoe9HALSVFIOlMSs=
Received: from DM6PR02CA0126.namprd02.prod.outlook.com (2603:10b6:5:1b4::28)
 by SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Sun, 5 Sep
 2021 23:57:11 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::ca) by DM6PR02CA0126.outlook.office365.com
 (2603:10b6:5:1b4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Sun, 5 Sep 2021 23:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Sun, 5 Sep 2021 23:57:10 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 5 Sep 2021
 18:57:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 5 Sep 2021
 16:57:10 -0700
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Sun, 5 Sep 2021 18:57:09 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix the issue of uploading powerplay table
Date: Mon, 6 Sep 2021 07:57:05 +0800
Message-ID: <20210905235705.3583-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07d10a1c-d0cb-44dc-37e6-08d970c8e065
X-MS-TrafficTypeDiagnostic: SA0PR12MB4349:
X-Microsoft-Antispam-PRVS: <SA0PR12MB434900B37F94487FFCEC11898ED19@SA0PR12MB4349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cszdl8l3N7nDlGcgiwGZQ6oImemX9OIh8tyNXJo2cf9q2Mb//waifJF2zfcFoEOLa4CBaP4lm8BKW4o5Rn+oMFEfdHHsQmzqrgSDmkkkg2ITO8W8QKZKPflOMiaSrgdk25Qbq0cZaENdsOZItsLHOQ241DXthHBOauu66e4GolBbQZcFSTQ7sEpXFuweSkG013tv/h0Xe3Fi+DUA5kz9M5J5axyQLOtxEpCSVAi26CODULvnb5PsctLxUVgEiXvnSz9JgZaf8uM/PFtPPpsNzS3ecB1YzprdrgUIjPC6YS2hfXuyqRk43atSxIOu44eV/VJx7cTgwAZEa68iKfZ7ia43Ke+dglKo0g1oHZbYtQOJFBDwLdkgjA1bbCFHJV9FPcLZ1xom94uDOdA3fcrIht213kjz/FyYDpBAfyqJrlE/7B8LaEnG16tIsHslbgmP6yPZ45iH8EzOtiE92OTMqEtjf+u81WNAO/Qj8DUtled/A9UislLlBKarl5af8Q/wN2eJocyJAafJ/IRBp2n5R0nqTjT3/1ZVl6O1QGoPDUNjkZYS/o/gBCuJuRwc5wwU86EHnZL7YJyfxj8URteMVwDGmQNsL6xKC2RRCn56GjAfQAg84RnRaXUmy4UhCV6IMUkfrIjWBkLEARcWKfSfvYvNeKoi8VogiULmoWn7bsoUyz+lo9iS8bWQ6uQmKlk0GXk+fCXm+iWW6vUWE1TddpdpCuqmPXsjHMQOg5pIZk4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(36840700001)(46966006)(70206006)(6916009)(70586007)(1076003)(7696005)(4326008)(8676002)(478600001)(5660300002)(47076005)(86362001)(316002)(2906002)(82740400003)(356005)(81166007)(336012)(36860700001)(2616005)(83380400001)(44832011)(8936002)(4744005)(186003)(6666004)(82310400003)(36756003)(26005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2021 23:57:10.9156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d10a1c-d0cb-44dc-37e6-08d970c8e065
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix the issue of uploading powerplay table due to the dependancy of rlc.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3ab1ce4d3419..04863a797115 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1404,7 +1404,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 */
 	if (smu->uploading_custom_pp_table &&
 	    (adev->asic_type >= CHIP_NAVI10) &&
-	    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH))
+	    (adev->asic_type <= CHIP_BEIGE_GOBY))
 		return smu_disable_all_features_with_exception(smu,
 							       true,
 							       SMU_FEATURE_COUNT);
-- 
2.17.1

