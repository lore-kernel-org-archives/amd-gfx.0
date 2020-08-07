Return-Path: <SRS0=Hu2c=BR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41446C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 09:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09705206B5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 09:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CMDT6nN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09705206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E68B6E991;
	Fri,  7 Aug 2020 09:30:53 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2AE16E991
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2020 09:30:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7jMVfUgC5FGzUqXWEqH3ssABvWvjPv2Ge18UYILMJE6bo+jNo1yzJRn+LdzpqdwSrU/KiKB88Vlex7Zk0vQumM+2gZYaTnsKvzD6fl6a9Drg3HlC+ylYTU8CzD/Y7kNG4dIjJvahr3OvveEvgndtg1SWU4my5y+iRlSqxjK6CYRYIm5PcVsW4h+OxjdKt5/Y360srjnfXcKZJBYpguUIHciHbloTy8Fw31Q42qlO3wf9sptn97g6soX1h5ZGXLQqjT4ZMoeDEtLkb9a1XrPraQkXEDh3M2J6P4kJU82S0w6g5iNW8Af0yq6blEtSBwMw9blOof59uKTTIx/+jPAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwZpGaZKP2YJfgYFlRpw9rydOqjfAXCrtF7q7427G6E=;
 b=jcK3mant/MOY9iBdd3dPrjXAGr8eKWlndyL5KpMJxExwrsOjDIUFj091WKdmyv7tiQmZFwWgNGJuafxifJfxJxAgde0IUfdEyWzTSkws/oobtkMZP7Ul0nS+pv2s3rx0CNwPKvxYeRhLtR270B2lJCdXzFO7afFqD0TnRVSHctNxgvL+5tWo2JgH4/ZtfUWFC0Qcf83Jwj0zQiFhljMyGNHyzFTKShSObhs2VsQc1sNf1DE4fRFM5wmF0TZg4eOs/GP3bsmN9uHa/w4a+eAOiHn4tOIQQwzGFkel4EGCCVhQnsCpPOvmjllfuaftcZlnNEgT7CubEa5ToetkltBvtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwZpGaZKP2YJfgYFlRpw9rydOqjfAXCrtF7q7427G6E=;
 b=CMDT6nN2R/z8mIGnI/GfxGKwVRvsKKec8LoT1wORLcUmH1Hl5/iMqADkQ1PmylIxS3I+PkRnbbfTDVEyFPD1jJfnFTrqxeh/HJs6Sn/eAjgUnOTA/ce4pSeCTk6v6ck2WIDzhVsGiGsYuxwSSdYj/S+iLbgOOtKdFX2P9088LIc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1644.namprd12.prod.outlook.com (2603:10b6:4:f::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Fri, 7 Aug 2020 09:30:49 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.022; Fri, 7 Aug 2020
 09:30:49 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: correct Vega20 cached smu feature state
Date: Fri,  7 Aug 2020 17:30:27 +0800
Message-Id: <20200807093027.479-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:202:2e::25) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR06CA0013.apcprd06.prod.outlook.com (2603:1096:202:2e::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19 via Frontend Transport; Fri, 7 Aug 2020 09:30:47 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8601e445-f6b5-4f6b-0961-08d83ab491e4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1644:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB16440467F310F54C6AB63620E4490@DM5PR12MB1644.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v22MNo4x+LNX241w8D/CsR18xDTppTz6++nEuklNRsPDVSX9jSLD+ffXNHb1OwZ49JpRyF8PeF4NbnwT9EknLnjbZa0UZtSm9UmKo40mF3LcOwgb4/+/D7wMGHtHTQ+WmZraN8AHtvoViZtSW5jqpLNoY21kxhux+/2QqvPV8RYjQWtcz3/4LkWPic/r/wT5bpDbF/zsGeqdmuGUk5UPaB0JPhPsWzQ+yIlohHjJBmob+FsETaVE/SvHiaMIvi1vBx0/KkNgMpz78ry1vXSTtkHeJfY1bsmchL+pGHZ7lD0Wssb3vdFBheIDjxoJWFsO1TFbfYcIwKhQdvmNl+GR4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(8676002)(83380400001)(7696005)(52116002)(478600001)(8936002)(36756003)(316002)(6916009)(1076003)(2906002)(66476007)(66946007)(6486002)(44832011)(5660300002)(86362001)(2616005)(956004)(16526019)(4326008)(26005)(6666004)(186003)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0CeMCWoAfdt2fvi+a/Q4MHJe216LXvophLCEGTEXRJaF0fH1IvVF+zhI9YGs1CnQyUSUgDRc2KSR3CTxxeh7vZ2/EWDSvMsMTJ6+jcs+p/VXaTO4VMfLRVJVvaGoiYNNmKipgXTJa7AJpuc42/fc69oHZDoiXbm1/m12LhJ0GPf4VzyUVkVi5gMiSF2ilpy0oVP4vfGT0BqL/++0Q4qG2FTVi83Ee+u9poQsksLRICaJ4T1U92Og1cAKCv8qUmG/9HEKNQtv3eTBHePHSQR3Ec8sVO7satM3CFthCng5HWKPEH+b4VFFyj9S1XBZhaNt4IDe97LQYTHvVaFmiSP9Ttm/IaLwPmovTYhrhTZKzPPqi1lLxPo3w9kXSwAhCJuHxIeDRSsw4CcEKwgUB1nMGbMW1C9vaOO8Jcv0SLMflSCtMlPIhz7tqj4IxPk0rm9Oq5DNVQlDmER1rW5QIy59tuOvyZ7+dCTXEC/hdMuyaH+ZFNp1n09p7wq18JbrVoxY6cIRIa2epmosmF884QrafSGYUD/Il55rR/WqYn+6q/ZfFCK49DIUrvIbs+tmMJYf75Vn7oevvB1URQ8T4wCDtcAyXoOcB3RXSvTf7dB7eSMzbd44/JGWna86CWk3iEWYULPoWRW12DqiX6jvINyWqA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8601e445-f6b5-4f6b-0961-08d83ab491e4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 09:30:49.1738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FN5pFdhIZrhrZdFxCuVslNpV32XkYgxeen/41GZcEZnUZwlfkUhfgUlAkxmnFoOk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1644
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct the cached smu feature state on pp_features sysfs
setting.

Change-Id: Icc4c3ce764876a0ffdc86ad4c8a8b9c9f0ed0e97
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c    | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index 90c78f127f7e..acc926c20c55 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -984,10 +984,7 @@ static int vega20_disable_all_smu_features(struct pp_hwmgr *hwmgr)
 {
 	struct vega20_hwmgr *data =
 			(struct vega20_hwmgr *)(hwmgr->backend);
-	uint64_t features_enabled;
-	int i;
-	bool enabled;
-	int ret = 0;
+	int i, ret = 0;
 
 	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_DisableAllSmuFeatures,
@@ -995,17 +992,8 @@ static int vega20_disable_all_smu_features(struct pp_hwmgr *hwmgr)
 			"[DisableAllSMUFeatures] Failed to disable all smu features!",
 			return ret);
 
-	ret = vega20_get_enabled_smc_features(hwmgr, &features_enabled);
-	PP_ASSERT_WITH_CODE(!ret,
-			"[DisableAllSMUFeatures] Failed to get enabled smc features!",
-			return ret);
-
-	for (i = 0; i < GNLD_FEATURES_MAX; i++) {
-		enabled = (features_enabled & data->smu_features[i].smu_feature_bitmap) ?
-			true : false;
-		data->smu_features[i].enabled = enabled;
-		data->smu_features[i].supported = enabled;
-	}
+	for (i = 0; i < GNLD_FEATURES_MAX; i++)
+		data->smu_features[i].enabled = 0;
 
 	return 0;
 }
@@ -3242,10 +3230,11 @@ static int vega20_get_ppfeature_status(struct pp_hwmgr *hwmgr, char *buf)
 
 static int vega20_set_ppfeature_status(struct pp_hwmgr *hwmgr, uint64_t new_ppfeature_masks)
 {
-	uint64_t features_enabled;
-	uint64_t features_to_enable;
-	uint64_t features_to_disable;
-	int ret = 0;
+	struct vega20_hwmgr *data =
+			(struct vega20_hwmgr *)(hwmgr->backend);
+	uint64_t features_enabled, features_to_enable, features_to_disable;
+	int i, ret = 0;
+	bool enabled;
 
 	if (new_ppfeature_masks >= (1ULL << GNLD_FEATURES_MAX))
 		return -EINVAL;
@@ -3274,6 +3263,17 @@ static int vega20_set_ppfeature_status(struct pp_hwmgr *hwmgr, uint64_t new_ppfe
 			return ret;
 	}
 
+	/* Update the cached feature enablement state */
+	ret = vega20_get_enabled_smc_features(hwmgr, &features_enabled);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < GNLD_FEATURES_MAX; i++) {
+		enabled = (features_enabled & data->smu_features[i].smu_feature_bitmap) ?
+			true : false;
+		data->smu_features[i].enabled = enabled;
+	}
+
 	return 0;
 }
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
