Return-Path: <SRS0=2dg2=2U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68D6C2D0C2
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2019 10:41:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A8F2071E
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2019 10:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P3/ptlgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A8F2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DC8C891B3;
	Mon, 30 Dec 2019 10:41:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C347891B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Dec 2019 10:41:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCQsPNQrfnwlomngcXcHaJhj+GNWvriYTgIuX0g8DgAQW1g2DD6CrB0z48Uv+ynCViUcJuMkykx/RUiAivi3jJDSnu6OjPTvDQpUhYS6Kg3QWQXbOk0vPWn0+iNVXPjT/rg2SLHyYxmMe/29BzKxqvIi7F95yk6U1DdCfLhhgnrDd8nP+LJDuRZ5f62KqJMA3tCXhJMJuY9crDuM3ZjsiEPTbU0ELufllGiMYKxqKfYWIbsma4DNSPP8+BMDCTaM1++kgDGbfewgiQu5B2xi06haGF3eXzKc1/Q7CLLWMsO4dUMTa+opA6W3uJ8/XrUWfuMF6Enz8T72TDBSMYLFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gc4VlgobEFWLDZjyHcBkInJNEl45UfQ2PoqzD7ct1cM=;
 b=BQfeKUTmeNMWJNClZJD+OgpNt8etTrGy3LHBYT9Ao6DUV0xKjlxmtJ6maL0iJHiVudUx8ZEfHJB9fYA7e9Tp5wMXZibuVsXXHLZRc2ub3N/sgishD/de53eDu1N1ho2lS8Lln8Zsj5T9/RBB+MhF5y5k69QQi6o+z5P9HziUEeqQAHJjp4OuyN+z37BKHRJ88SOddpJyf15TEnFAhKRnZVMXfJGe02lF3o3QmccTEso2C9/2FHcVWYgw896ZH63UmbS6yM6oR+FTdlFLrNerI+PWv/kTmjODF6CH5yYcyskDFYKqK4bDt1QuKUf+X5c2Q8NzCq00/k1X0cpjUm7now==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gc4VlgobEFWLDZjyHcBkInJNEl45UfQ2PoqzD7ct1cM=;
 b=P3/ptlggmdakRX70GI/x+iW2w/P/aj7CZ2z0Iss2nC+ZnjIQQ88rKfUGd8Sv1ybaj/ALsbBYX5/6Xey3H0xjdb68m+/EWSktcSJqP6f1xstN3Xr7s2VfUNaitJzDrYLxwBSUYy0EZLjpDdmUcJPFwfivEIJHwG/D0SvTMM1g9bw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3997.namprd12.prod.outlook.com (10.255.236.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Mon, 30 Dec 2019 10:41:49 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2581.007; Mon, 30 Dec 2019
 10:41:49 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: retrieve the enabled feature mask from
 cache
Date: Mon, 30 Dec 2019 18:41:29 +0800
Message-Id: <20191230104129.28165-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: HK0PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:203:b0::14) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR03CA0098.apcprd03.prod.outlook.com (2603:1096:203:b0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11 via Frontend Transport; Mon, 30 Dec 2019 10:41:47 +0000
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3bb4dd7a-de06-49f1-39e4-08d78d14dfc9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:|MN2PR12MB3997:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3997F8547DF5E87AB7B8DF35E4270@MN2PR12MB3997.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0267E514F9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(189003)(199004)(8676002)(8936002)(66946007)(81166006)(4326008)(66556008)(52116002)(7696005)(81156014)(66476007)(26005)(2906002)(6486002)(2616005)(6666004)(6916009)(86362001)(186003)(478600001)(1076003)(316002)(16526019)(5660300002)(44832011)(36756003)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3997;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O/GllrVr1WZxjSOw7cSCDJp4JYky/mcOV9S4AURqbX3LdQqi7Ny8pNDh7js+xiY3SrW4qRtXX/RB6wvU2xTYtFWHTQUTpMyovdg+zaMd+DrFgIyZ+cX6ghuxC+P8nVMCmO5Xy/Rtqq6IHuKQMYqB4iq22B1srBrQ/KMedSRQ7ueY+810AyMNtLjcLf5edCxTKVXqGnLzHau4AAuSJlklerJ1UfUaVMEzNA/VKNkZJLsUfk7zih1ZYAbLO9ZGl84hyUCekCKvmwobXVbjoIdBja/ByD6+GWWDwiUEevwE2Yc6a5Zfa+9v6J5ma/i+Lf5uTbZTTH30cBqnkNw/S1Uu0aCSlziivv9dFRLVe9h0oRrydNnqzthh6a+u1r6r5Vs8p0yVWhvxkLRXHQb/XBWSN83gPfsZ8xfQbNIh+ln6fluF5GsrTXD57IeRdz/jCw9q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb4dd7a-de06-49f1-39e4-08d78d14dfc9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2019 10:41:49.3461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2O0FADBVtsrqXBWmOKidFv2yK0bBB+FSqXbQ2op/1t3aUc0rC8R73XVcoBPCcH9I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3997
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is why those feature mask members designed for. And this
can reduce the SMU workload.

Change-Id: I2c6e12e945508f7b2fd79bc172efa68bc6150d05
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c |  2 +-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c  | 61 +++++++++++++---------
 2 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 4b686f0af538..290976f5f6c2 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1313,7 +1313,7 @@ static int smu_hw_init(void *handle)
 
 static int smu_stop_dpms(struct smu_context *smu)
 {
-	return smu_send_smc_msg(smu, SMU_MSG_DisableAllSmuFeatures);
+	return smu_system_features_control(smu, false);
 }
 
 static int smu_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 962e97860fe8..e804f9854027 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -855,27 +855,33 @@ int smu_v11_0_get_enabled_mask(struct smu_context *smu,
 				      uint32_t *feature_mask, uint32_t num)
 {
 	uint32_t feature_mask_high = 0, feature_mask_low = 0;
+	struct smu_feature *feature = &smu->smu_feature;
 	int ret = 0;
 
 	if (!feature_mask || num < 2)
 		return -EINVAL;
 
-	ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesHigh);
-	if (ret)
-		return ret;
-	ret = smu_read_smc_arg(smu, &feature_mask_high);
-	if (ret)
-		return ret;
+	if (bitmap_empty(feature->enabled, feature->feature_num)) {
+		ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesHigh);
+		if (ret)
+			return ret;
+		ret = smu_read_smc_arg(smu, &feature_mask_high);
+		if (ret)
+			return ret;
 
-	ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesLow);
-	if (ret)
-		return ret;
-	ret = smu_read_smc_arg(smu, &feature_mask_low);
-	if (ret)
-		return ret;
+		ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesLow);
+		if (ret)
+			return ret;
+		ret = smu_read_smc_arg(smu, &feature_mask_low);
+		if (ret)
+			return ret;
 
-	feature_mask[0] = feature_mask_low;
-	feature_mask[1] = feature_mask_high;
+		feature_mask[0] = feature_mask_low;
+		feature_mask[1] = feature_mask_high;
+	} else {
+		bitmap_copy((unsigned long *)feature_mask, feature->enabled,
+			     feature->feature_num);
+	}
 
 	return ret;
 }
@@ -887,21 +893,24 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
 	uint32_t feature_mask[2];
 	int ret = 0;
 
-	if (smu->pm_enabled) {
-		ret = smu_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
-					     SMU_MSG_DisableAllSmuFeatures));
-		if (ret)
-			return ret;
-	}
-
-	ret = smu_feature_get_enabled_mask(smu, feature_mask, 2);
+	ret = smu_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
+				     SMU_MSG_DisableAllSmuFeatures));
 	if (ret)
 		return ret;
 
-	bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
-		    feature->feature_num);
-	bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
-		    feature->feature_num);
+	if (en) {
+		ret = smu_feature_get_enabled_mask(smu, feature_mask, 2);
+		if (ret)
+			return ret;
+
+		bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
+			    feature->feature_num);
+		bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
+			    feature->feature_num);
+	} else {
+		bitmap_zero(feature->enabled, feature->feature_num);
+		bitmap_zero(feature->supported, feature->feature_num);
+	}
 
 	return ret;
 }
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
