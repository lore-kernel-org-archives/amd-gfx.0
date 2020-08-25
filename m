Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEE4C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 07:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5CB206EB
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 07:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="K+O1tdJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5CB206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F4826E889;
	Tue, 25 Aug 2020 07:49:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 863516E889
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 07:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2NzsZon5To9mQIjwnIqY0I33ZAUVhGbFMubwAgDBr9TXt1e1kOqoSuHpOdxaJ65AniQXzIZC9dCjN0cPEB5LBSJzFKQkjxxga/hJUcj8QhdFYD5N06kWNPhi6jqrmPHx1qkUD35ise7fCFJonBrjjAUG0BXmCSRHXUlwLtitLXra+Xsb34sG4Vjx6YalB0FlDsm3SAebIx++pvy8lxnKQdVmHisW6atuGJAg9YM/dlUilfigL7kdJroHb4eJaWbNqZrfe7Zr/cgM0eUK/bY6p8pCmVOdMqUqjgXY1qnM6plzQCdvnJfEDLPBOxtGftixy5AMzGclp0tfuKbZevhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp4px4dC4f8VbnDM6Rckn5EKsygFRYGOl+5LD48HJbc=;
 b=TJLkue6zFG560DOTjLOQO8kFAF72fYcUEliyntEj9nKe/PoKCjhgKMSaBckX0bMxFHF8H/oBtZlGHuEKaY7FD6/HGg3H4ReCMU1wpf4zICu1zOheBRvzei7EkvM8Wf1DxZqdnQsbO8cirnJICybg3btAL44FVXVGmxHvHL4H2YV7M8MbkqdrDYI8zjt3hwy9Fy6qczsVbfbFvSJYLfkifbYtw83KIj9+aaQa2uPPQAOgSLzrvnGOlLRbLav8cipr7rluMHaBQhBq5D5wl6gTwK/q7SvHwl+MY+Rd6jRH8bRP9QVRYC6cub6rPgC7mRWCNPj//zR9Lhy7542iF3bFQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp4px4dC4f8VbnDM6Rckn5EKsygFRYGOl+5LD48HJbc=;
 b=K+O1tdJUcvQXT2j5QWcZdIztMmHhodSi5F4tjLVAGliUImR7O9bk53mO6mfoaROGJVWjG9z2+hQmHVrOnYtQNjlfZmKflXXeIbMsQPoOAyNM6us4lM6UV7FL2Aan4Twwl2PYvy1cfYIqkLqQPIpNNHNFUOQSzH3YNybVDsvmeLQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3083.namprd12.prod.outlook.com (2603:10b6:5:11d::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Tue, 25 Aug 2020 07:49:49 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 07:49:49 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amd/pm: drop unnecessary smu_baco->mutex lock
 protections(V2)
Date: Tue, 25 Aug 2020 15:49:21 +0800
Message-Id: <20200825074923.32345-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825074923.32345-1-evan.quan@amd.com>
References: <20200825074923.32345-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0200.apcprd02.prod.outlook.com
 (2603:1096:201:20::12) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HK2PR02CA0200.apcprd02.prod.outlook.com (2603:1096:201:20::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Tue, 25 Aug 2020 07:49:48 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fae5dda6-4bbd-45af-ab22-08d848cb7190
X-MS-TrafficTypeDiagnostic: DM6PR12MB3083:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB308338BC3EE8F32FD100AE9AE4570@DM6PR12MB3083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4PxsCeTGSejyRuqmXNpLlu6V68ZNwIf4hfscDF9c5H8QnrUbRgqiljiq1VJRf35d5Zg74vxgYZxCIxUccUo7+qqYi+5l5HF3w9rnye9NHUvY9wFoDNCmnxhAhTFwGLBORNKOpmJDk1HZ6lQi/N368TUbaLIO5S4RO8IFcuTgz6jgolpJJhlh2ZghgFcDrmR2gX0kjuO9qSj27joSse72fKmh1tgdrSV8Ya3HEqOq30HjpZo8wGQQWxGnvDrhx/5nPmKs9+qb4inGIE+L1uen/CqmBVNFF0BuwF8c+4iqUydRbTDvA/vaezaYnaGAewRx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(6916009)(2616005)(956004)(66556008)(66476007)(66946007)(52116002)(186003)(8676002)(316002)(16576012)(26005)(8936002)(5660300002)(1076003)(83380400001)(86362001)(2906002)(6666004)(44832011)(4326008)(6486002)(36756003)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: EYaKE7Xy86DR6blR4LTvkuNaNC6kUAqoAmFdNYERRLTRntNR8GDIqONRkOrsRYa2jRFhv+p79JxQQ9W8YrCrPtTD4BEkAge6cDf30L3q5TH9p81c95/Cffl1Bc3MSaC/JHh3blxdGTpTY9llYnB/YtAtoSqEXQa36pDRJZX28pT8H9PBrZAb2eOXzPXIsRDaHgK5r9aWoLE+TIVeJ5CEwohF9yrcoR8xJZ5S5wlmuvXa1FOe3jREgbun8Vg6TKsV+DFTzwV+UlhMYg6Fkyz/rvekztH3rJOpC7xVKqcROFphEtce7Jq32vCC34JBtMzZOEvevuSXdqwOrkLkJEJgslesJZEsBr6iUXrIkXc9hEUULN4r2LgEcxhqMVFDFimOYPx2DVGvW7SuKGbbnCImLTh//NBC1X5nFUPPSFkLzz5HY0k0Vvw1c7GNJqzpy+Y02UeAs6+byrNksrBQPnyRxu6RjQZwV0i4Act9xRN32OXHdmOSg0ra7BLMRr6mUcyRRs2dJxf0lQQsXCtEncFC7yi1vUnwvCiriS9gBCVyUVFLlhJ5DnmvYgx45R7n/6ijOFW9fsiQG6uAjojoEv54IisqDmKLOB8OP2sBSA7wvN50gXPUEES6wmeXwTuWVZrJOVpH5ap8y9ua7jSKTBmQsw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae5dda6-4bbd-45af-ab22-08d848cb7190
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 07:49:49.6560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uifBDzmlX16b2ZbjR0GIg5VHX3XY7OVufM0foaQMdhuQW/Qq9zOCEAjZu7Hy8BtP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3083
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

As these operations are performed in hardware setup and there
is actually no race conditions during this period considering:
1. the hardware setup is serial and cannnot be in parallel
2. all other operations can be performed only after hardware
   setup complete.

V2: rich the commit log description

Change-Id: I7078ac26ae71eb6c7cbf918a127adfc2f56acf7d
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c          | 7 +------
 4 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 8347b1f2509f..4195b5b9e8e5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -386,11 +386,9 @@ static int arcturus_check_powerplay_table(struct smu_context *smu)
 		table_context->power_play_table;
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
 
-	mutex_lock(&smu_baco->mutex);
 	if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_BACO ||
 	    powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_MACO)
 		smu_baco->platform_support = true;
-	mutex_unlock(&smu_baco->mutex);
 
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 72f3d68691d8..f4b26399b413 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -347,11 +347,9 @@ static int navi10_check_powerplay_table(struct smu_context *smu)
 	if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_HARDWAREDC)
 		smu->dc_controlled_by_gpio = true;
 
-	mutex_lock(&smu_baco->mutex);
 	if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_BACO ||
 	    powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_MACO)
 		smu_baco->platform_support = true;
-	mutex_unlock(&smu_baco->mutex);
 
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 66d655958a78..c19f526c5a22 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -296,11 +296,9 @@ static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
 		table_context->power_play_table;
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
 
-	mutex_lock(&smu_baco->mutex);
 	if (powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_BACO ||
 	    powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_MACO)
 		smu_baco->platform_support = true;
-	mutex_unlock(&smu_baco->mutex);
 
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 28a19ffd22a1..005673bedc2f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1434,13 +1434,8 @@ static int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu, enum smu_v
 bool smu_v11_0_baco_is_support(struct smu_context *smu)
 {
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
-	bool baco_support;
 
-	mutex_lock(&smu_baco->mutex);
-	baco_support = smu_baco->platform_support;
-	mutex_unlock(&smu_baco->mutex);
-
-	if (!baco_support)
+	if (!smu_baco->platform_support)
 		return false;
 
 	/* Arcturus does not support this bit mask */
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
