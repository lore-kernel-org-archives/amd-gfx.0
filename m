Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37251C433E1
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD342072E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zcqDefQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD342072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A5D89FED;
	Thu,  4 Jun 2020 04:47:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F7346E197
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 04:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEFgjNpL0DjLK+IUfiGNr4pQ/HKOehDmJDDXQ4BZzgif38S/Is337H77XQW8VdtFJ8HsIrYxz/IhHN9fU+pE6XmXt7qP3HfpPMXiRehnk3GHIio3DESM2VIR+8kpKk6Z/D+YhLQSOOIpMkaFcl6u1YOoMI9eoV2Vb7Ftl41sz4lwHBStubrpTYCo1lbzl9ax5jBMXIYbvMkVOQvh4CsubMredAFiXvxNiTQwWgVA4yrffZaqD+paIIWdt1CLIiNxUVKhRiJ6hRnNjywjjP1CyhAsySEu6lvsaM+G5NEXvItYbyH8nt4onEcpu0wOLXhRSZBciKhVyNI25qJfAUDEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcPeLg1CVpSGLyMRjo5fmGELp58XV/6Kj6pE7RQlcSE=;
 b=OG2fF5RwThbfrUcUxndnHIckAE/bTIzpt/Z66oAHaGW70937MZQxajV48YM/Q5YcR+KfSSMmnW0A1kCs5zLxOaHr+sFspE1eU5RA+5cfeHu6wQZAEPRRU9L0iyIQCpx3KqiLoAuGjwS+WZwrbiQ7xGrYf7U5o4bnS2Gcq0XVkJWBg1eq0Dw3RTtjG1r1kFwcKZFbNrSD/6g6hfB+uPA2mXrXiWbnL/7U4I65ACwMDSivdyK0ASPdaNCF5QzsMnZ91bHQ69R9yCWUb4qEGTMHspEdeOIo7kyz6XVuSm3fzphBSz7EawvBvy5SpTc4zcjVmzGzxgHvdjd8QDtHaZw8uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcPeLg1CVpSGLyMRjo5fmGELp58XV/6Kj6pE7RQlcSE=;
 b=zcqDefQgZUyvBAwEFgOU3ldLHqzVCt3Mb4yuDifnDcX2Qur85WTteiI84E1mB/u90aTau7EB1A78Zp73q1SFY+GGrtoFKyRaxXy9q7t2g5WI/onWuEbUdmNVudNfMNvthJOQQo5seuqL4ahiaRSmvHBHGDOTskkLGuUnOEiDlrw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Thu, 4 Jun 2020 04:47:13 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Thu, 4 Jun 2020
 04:47:13 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/16] drm/amd/powerplay: better namings
Date: Thu,  4 Jun 2020 12:46:15 +0800
Message-Id: <20200604044619.18658-12-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200604044619.18658-1-evan.quan@amd.com>
References: <20200604044619.18658-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0071.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::35) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0071.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Thu, 4 Jun 2020 04:47:12 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d4a06b4e-623b-409c-5c7e-08d80842595a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB32128D027858A0C35CAFA387E4890@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:316;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4a6hriwMo5JJs76mj/VYMBqtFfBtMjAfrmCfL7DE3CTGfCND/YOW2x6gJUiS9JdvuOHEiNuoCZ/pJY0K57GxHRUx3FHDiay7+9VM6SrQz+yOWW/W+pAa6x+SR0oshamqnrQtYcambzSYvyyGYSxUlTt6+XeDSFL+0MN4+Y2vDDmxcwtZGxyW74U3c183U1cKaq9i8qowz3JGDFaNFeFW263iSuwMPP55YqNTrEdpL+0Tf+ocarMbmnY73fRadOjvpX5Pf1IHC1wPAu4TH40LJ4JsQ+UIQYtkzknATmLiVHuCAPVQLFBqFE2VyI71C7JLV+vFJgubUCktZRVZOXak9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(8936002)(8676002)(316002)(2906002)(6916009)(956004)(186003)(66556008)(1076003)(6486002)(16526019)(478600001)(52116002)(7696005)(4326008)(83380400001)(36756003)(2616005)(66476007)(66946007)(5660300002)(86362001)(26005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6b7q9eOM6lZsHy06yfLMe5odLBANcsuwJ3KeIfDJGaxmsyfLGV02MgH4nipyIqr05BmVezyRGNvhTcQCEo1yYTVsNMMIkABPfqx6xlI7v2ScH4/tx2+dyXfhyWwjJX04wpvNuZ7s+bw5JaymXY4WD7yqRctOGxfxyrxUQxxfKlPxl8hlqGEmtsmshN2wRxQVJ8WQDH3oyHwfcAOu7SHNYM6bWcdhuy3UOfxFAetSpLLibxrA2w4M2vkW3f5EseuknOK4q7GkfHZ1/vPivQIlNAa+hzAvl5emlgZ+7o+eX7QgWCw0AgQSDyVZrC7f5Jm8Cb1KHahrWGD6ngExsjRhx7143fQ++05i/YjbavWxlyI1huIlIEOm/Ea6CW02MerIyH5agR39qY8iidKq1H/4clfPycqP0BR1tZxqpj2Hiz6PNM1yHA+x5WJe6qOc1iDp0DPVX8fsiOmHDeBFxi1pv2QBuGIK+BYxZZup/7rQh75zWJx1P+riaJa5a5k3LSM4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a06b4e-623b-409c-5c7e-08d80842595a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 04:47:13.4322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMGiOWbes9gyqmSJ0ikLzUz6/UvD0XBfGeqSyZi4HP8xliFq8N6uhD5T3PDgzO1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

And some minor changes as dropping unused parameter and label
internal used API as static.

Change-Id: I0af0aea029dc4fc7d8e150ab6ec984e9a5f1a74a
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 12 +++++-------
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  2 --
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index b3410d111316..55ffbf1cf086 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -638,7 +638,7 @@ int smu_sys_set_pp_table(struct smu_context *smu,  void *buf, size_t size)
 	return ret;
 }
 
-int smu_feature_init_dpm(struct smu_context *smu)
+static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
 {
 	struct smu_feature *feature = &smu->smu_feature;
 	int ret = 0;
@@ -662,7 +662,6 @@ int smu_feature_init_dpm(struct smu_context *smu)
 	return ret;
 }
 
-
 int smu_feature_is_enabled(struct smu_context *smu, enum smu_feature_mask mask)
 {
 	struct smu_feature *feature = &smu->smu_feature;
@@ -1115,8 +1114,7 @@ static int smu_sw_fini(void *handle)
 	return 0;
 }
 
-static int smu_smc_table_hw_init(struct smu_context *smu,
-				 bool initialize)
+static int smu_internal_hw_setup(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret;
@@ -1287,11 +1285,11 @@ static int smu_hw_init(void *handle)
 	if (ret)
 		return ret;
 
-	ret = smu_feature_init_dpm(smu);
+	ret = smu_get_driver_allowed_feature_mask(smu);
 	if (ret)
 		goto failed;
 
-	ret = smu_smc_table_hw_init(smu, true);
+	ret = smu_internal_hw_setup(smu);
 	if (ret)
 		goto failed;
 
@@ -1487,7 +1485,7 @@ static int smu_resume(void *handle)
 		goto failed;
 	}
 
-	ret = smu_smc_table_hw_init(smu, false);
+	ret = smu_internal_hw_setup(smu);
 	if (ret)
 		goto failed;
 
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index b2de042493ad..5f5a210668a1 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -656,8 +656,6 @@ extern const struct amd_ip_funcs smu_ip_funcs;
 extern const struct amdgpu_ip_block_version smu_v11_0_ip_block;
 extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;
 
-extern int smu_feature_init_dpm(struct smu_context *smu);
-
 extern int smu_feature_is_enabled(struct smu_context *smu,
 				  enum smu_feature_mask mask);
 extern int smu_feature_set_enabled(struct smu_context *smu,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
