Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5949C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 21:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6720310EB48;
	Fri, 11 Feb 2022 21:52:16 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2061.outbound.protection.outlook.com [40.107.212.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4C2810EB48
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 21:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNkDcwAFhQdtcVm4dItHGx3Y2LAmpJI+BqUIQjKAsn5tCYdIY7U7aRFqBvaTH0agy1IM1nVk8+cUWAyjaYEz3u/sj86StJQHRraSPjYuBckJrFFZ4JGywtI8nsLYx8+4woub5hSYefm2PNz1S9vweB58ch5b94jFtr5sj2ZxSWgPRES/x+sVEvoZP2xJHZ5VJhMBHF1unlMlRkanwXlZNZ+11U4qVSXsSe3sq80nRWFkst0fFGybvSHLxJn1A1/Houmroz0Px9BGs/8ZTDJGkYr2CCOEqxqrPpmysgs9GgX2/1pPXDFdk+CCUhm6TaVbzvIuq0XuGSttZasKU0jA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9K+UEelbvT9aRr7I8J3BNE9J1bW6jQMuXuXG/XHeDw=;
 b=ZetLxX3OPG1Aq8im5ziDYpe3yFuBI+aw3B9HYbE5oWgcRdZTBZ6kBigpNBy0ogAiVMQFMFuFGLhjHPLhwTgbLwaz9u9LXnNadYYb4TUc0aZOz0RX9VUoZlzO4xqX+fygaWwJxiCcFViBORpWD5pXbdmrjGR3x3C3rdnU/qoJVREwxTwvG82rXRbZ3tW1YtkctrdhGKzGWkyZJv4ssYqg/RIIhziJ8qTbVfCY3Oeb8qd7ERI3Qol7bhQ0rYPC1xchuKNV9+hFXXupwTEXsGo2v2Ip6slqmOxsqmNuXTBhHfDw4mWHJpx7TB/rjT4TjdbiyI7q9lB/+9wgz3qUGN8UlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9K+UEelbvT9aRr7I8J3BNE9J1bW6jQMuXuXG/XHeDw=;
 b=XtpG6vue+M/gJu9MGqs5KSr3o47qaG6CIryEEHlbb50hZZV91o20obt5eSvrGsmutJ5gsVQ+zTOUIUKuxph1lMDhqj8vkOjGnoYY7/yXgJD2ukMhRXiM6kwQ28/aZFlE0MpaXCG2h3ICgng4WlrnGw4tweDol3bmlZuj7K23IQ0=
Received: from MWHPR14CA0019.namprd14.prod.outlook.com (2603:10b6:300:ae::29)
 by BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Fri, 11 Feb
 2022 21:52:11 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::d3) by MWHPR14CA0019.outlook.office365.com
 (2603:10b6:300:ae::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 11 Feb 2022 21:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 21:52:10 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 11 Feb 2022 15:52:07 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/11] drm/amd/display: [FW Promotion] Release 0.0.104.0
Date: Fri, 11 Feb 2022 16:51:38 -0500
Message-ID: <20220211215142.94169-8-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211215142.94169-1-jdhillon@amd.com>
References: <20220211215142.94169-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5cbcc43-22b1-4215-9ced-08d9eda8c1b7
X-MS-TrafficTypeDiagnostic: BN9PR12MB5356:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5356156565484A91A6C0DAD6FB309@BN9PR12MB5356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2jMb78IGLa8RCDi63D7ZjAecUPe555Ky7c8Vz2jZIBg8QScmjwDotPbUMyvxvn6rZj1bXBwc8RhOcUt52n7pdlWqH+7eVkZWBpoZqqSwWJ4+6fj4lSKjpYgUM9kLl/ZfLoW1ybGBu6DKEX/mrJ+Tzri9uAq0BjBLHDufwaA8ka1zWa3YfIMbdENawCg1RUhOYFxQCfFRXqVaBTtc/v4vZD0imKiHrqEfgCElplpbKNKZQHk51i9cv96dVCRLua0DqV5w/4/WEJ8hQX6T0HVC1+yOHu3JepXMkNIV2YbC2wnZvxOpUiWNv79LIczjPTISzEFMecTWN5GOgbYtm1pWRH+8vYqyjr1dPhLydyBWwmTrci2Ez5OfITXoFBacvN2ytOawx1K4YDMT3P3nW4xCoE8Sg7bO2J4QEPw1yvqk1SJ12hJLUKMhfVehtISjxpi+jmEY1Ygjr6+eMQH6m2P4pq0aR8ka/pK2FafWpuXpepWjEnHwl47FvCtAM4acLgSuAuQKBVYgmA7n7ZmaXA7/2RFH/8oGSsqgcT0sMLbzvbnLLJGleSmCrI6JrMg7fuRg2EKczLa96FkndaG+gVbfoSyuMj1/BZqtDvpp0Ke+8/idBTB4ipLJtN6BBKp+n5TwUiPoYzztn1w94zb0gDkm3EakbTfR1yHUHEQpLoi6WOK54LnX7iNBY4F4IUgWbcifg6Z6U/Rzj2mFdVM8mwUgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(47076005)(186003)(36756003)(83380400001)(36860700001)(40460700003)(356005)(336012)(2616005)(1076003)(426003)(81166007)(2906002)(26005)(16526019)(8936002)(6916009)(70586007)(70206006)(508600001)(4744005)(316002)(54906003)(82310400004)(6666004)(5660300002)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:52:10.8085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cbcc43-22b1-4215-9ced-08d9eda8c1b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5356
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index c5cbbb0470ee..b01cb5493b76 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x5189adbf
+#define DMUB_FW_VERSION_GIT_HASH 0x1422ef84
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 103
+#define DMUB_FW_VERSION_REVISION 104
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

