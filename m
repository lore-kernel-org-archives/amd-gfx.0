Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C78C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 08:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5219410ED52;
	Thu, 30 Mar 2023 08:59:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD95310ED52
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 08:59:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZU6fUGd5RlRo2FVL85s0IVQTdBz0T18gdRP0ULkB/TS0GQULyuMqVBkHZJ09MHIScGTl24F1ZUngumRJDmqJ/eUzS7q7DeE5mP3wFpBsB5TVPPoyzo6vwlhbSl6OL2k8c6CsD6vrkmjWNWSup2nnSXPeau1hjiDvvFmqcBeu7C2LsK63WDpQVCgxIxieWHJX2XOxozlD8yil6/ayIKSdotpQgo9DWkVj5xUSS9jwLL8rh2o9L/erua3DqSl33G2KcGx9kLtxl0SMuEaKK3ZKTvSlKYN6V3HiYmlycdTpzUuFhnqgmPQX7452hnJ8+SIwEz+LCAuouf5CRg41lYxGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTNOdRc6FGZuAxXPOJcOOFk0pBvLc6eFYp+h5mWk8jg=;
 b=IERe3RGVGvm4MPVAy8Vx03fddQhRQY6tGgOCbO7jWW/r6kxezOE8sDKTfvoaY7DXeYteKQyNALR2jPUD7S1LQh90F6GmSPa25gnV7K23UGH4rEhxLtZIJLXPJZiQZ0lOBm0vunM4ir9IpMxAycx9m/4m4gflf3R/5GrbnejsJcQqVdi3T/0sHlSx1v6MIhxBLKMN1q0kk3h0EF9nXUox8jXYQmLvEYacVUCZhEdgVzECvpEq6T0vZusdjPaGRQKpU+thXKY9ts4vdM0ywgExmKxmbuZ66tqovq3P8xF151Lj4iWl2NsiNfhluBxd27qWCPw4r/obEO78thPIYF2ZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTNOdRc6FGZuAxXPOJcOOFk0pBvLc6eFYp+h5mWk8jg=;
 b=dBR9JGCSN7HJAWsBj2K1OvYaRmGjSpUYXxKqNMBkS2RBe3ZOlM94Z+El50PQd55T6WvLK1eDn1sHUYtMBaFQB7Vc5WzqGp2CFikSd2Ej57ahPLMjamcR8ojmd9pCfHAwGmBbfD2laDdSXWlWoLa39zlz/rrvheL5kGvEgMD5q+8=
Received: from BN0PR02CA0055.namprd02.prod.outlook.com (2603:10b6:408:e5::30)
 by IA1PR12MB6457.namprd12.prod.outlook.com (2603:10b6:208:3ab::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Thu, 30 Mar
 2023 08:59:31 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::db) by BN0PR02CA0055.outlook.office365.com
 (2603:10b6:408:e5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 08:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 08:59:31 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 03:59:00 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/10] drm/amd/display: Correct DML calculation to follow HW
 SPEC
Date: Thu, 30 Mar 2023 04:57:14 -0400
Message-ID: <20230330085720.3863-5-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
References: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT049:EE_|IA1PR12MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ec5282-583c-454a-81d0-08db30fd1342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlNwjyNbDirWEoGczcqMPRm2/+W6LLzwzF3mxQbZyzxngi9/becKE6RWOd6vmLPRPD1ehcTkh1NBcuybjDnKxPR47XO3y75dZ0Y96OmTvzQNK86Wr+6dMJfLWXWHi2fVMWSIUn8b8A1nyIsw26hnVSGp1dVV0ug5REpu6adSn1GqY+LYY9vYMqfRhJpqHykjwocWd0OlVEtj6z2ENJCoJnGYD/aOspqzfWup3xOZVx8MeY9nWHPL8vXp/ielJQcSPvvX7NctRj0QOGwP79E+6gv7uFcMHgotEZjbx8oGSikY40xyjqoVlVjQenpK6M/NBcVgSIUI0qZy5QbzXbMUeWvk2Y9X9up4wjwaDAd6XdxnByU+Xr2KGQEteGTMsiuDyYs2bNL0i7EpOXWqh8hnGES5z9wzLDHt5a1LMCivKs4FsG2BggfRX+DyFVgALf1jHaqs4SiBi0v9vAcFCY1VViOcRISNmnVsPL4bK2QhXVMUO1oH71baik01QRaJbJ4f1CxpeR2G5lR07vudqo7IXq1h1cfzlPdWZeDunLW1wUzfq/FoNngCqt8U3yTJmS5eR75jG8+OY2xtchwCzk31Yu83qKLTTGPbzGY+TpT0GoaJAbxQ93Jd1x4MfATxlHfCIcFD3Na0n0nloOHyejWo0Qg2hhQSyl/Rj3t22mCBzvLKlJ1PC1HJI0fB3terk0K5TMqiTdftDHYRSN6MWr95KRwL9Yi8bMc7HmkwmUJDBsw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(8936002)(1076003)(6666004)(336012)(47076005)(8676002)(4326008)(82740400003)(16526019)(40480700001)(6916009)(2906002)(426003)(82310400005)(356005)(81166007)(186003)(316002)(70586007)(36756003)(83380400001)(86362001)(5660300002)(2616005)(36860700001)(54906003)(41300700001)(26005)(70206006)(478600001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 08:59:31.0417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ec5282-583c-454a-81d0-08db30fd1342
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6457
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Paul Hsieh <Paul.Hsieh@amd.com>, Jun
 Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Paul Hsieh <Paul.Hsieh@amd.com>

[Why]
In 2560x1600@240p eDP panel, driver use lowest voltage level
to play 1080p video cause underflow. According to HW SPEC,
the senario should use high voltage level.

[How]
ChromaPre value is zero when bandwidth validation.
Correct ChromaPre calculation.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Paul Hsieh <Paul.Hsieh@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c  | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index d0303173ce80..7d0626e42ea6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -4864,7 +4864,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->DETBufferSizeCThisState[k],
 							&v->UrgentBurstFactorCursorPre[k],
 							&v->UrgentBurstFactorLumaPre[k],
-							&v->UrgentBurstFactorChroma[k],
+							&v->UrgentBurstFactorChromaPre[k],
 							&v->NoUrgentLatencyHidingPre[k]);
 				}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 536a63624595..bd674dc30df3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -5191,7 +5191,7 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->DETBufferSizeCThisState[k],
 							&v->UrgentBurstFactorCursorPre[k],
 							&v->UrgentBurstFactorLumaPre[k],
-							&v->UrgentBurstFactorChroma[k],
+							&v->UrgentBurstFactorChromaPre[k],
 							&v->NotUrgentLatencyHidingPre[k]);
 				}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index daf319370190..7eb2173b7691 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -5288,7 +5288,7 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 							v->DETBufferSizeCThisState[k],
 							&v->UrgentBurstFactorCursorPre[k],
 							&v->UrgentBurstFactorLumaPre[k],
-							&v->UrgentBurstFactorChroma[k],
+							&v->UrgentBurstFactorChromaPre[k],
 							&v->NotUrgentLatencyHidingPre[k]);
 				}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index cb9cb01c52f6..e90ddc33c27e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -3355,7 +3355,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							/* Output */
 							&mode_lib->vba.UrgentBurstFactorCursorPre[k],
 							&mode_lib->vba.UrgentBurstFactorLumaPre[k],
-							&mode_lib->vba.UrgentBurstFactorChroma[k],
+							&mode_lib->vba.UrgentBurstFactorChromaPre[k],
 							&mode_lib->vba.NotUrgentLatencyHidingPre[k]);
 				}
 
-- 
2.34.1

