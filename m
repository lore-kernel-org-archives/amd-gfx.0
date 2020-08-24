Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3220C433E3
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 08:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 778D52072D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 08:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kVsM0aWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778D52072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E396E1B8;
	Mon, 24 Aug 2020 08:04:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 537B56E1B8
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 08:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTOoj0cqOwownZR70i7qbx7qfKs/OBM2gqVw05cDGffw03mIJ6pbbkaUVs0W/SNu1BNIZzzaVTzj2E5tAzi+5pBemdcM5fcJ13EUKs7lma1zLtYG0QZWfPuhqArtyFcKO2lWZmdATVX2pBwRSXnLj0o0fVgVgYDN8LT/xpNJQqGEbGCSojroxMNsKc+PnZ4e0Y7F68CVKSZ7K0YlJAVBT+4kCY6vBbcuGKYB5wn5KG6N0NbbPZj7yCydz6ktx3dYsE3aGMncyIzGBuvXSb2ccDf6u6kuYi2pyf8wQA4FW89DjjCqebdtLJrZ5lhrR0Yr4hpAmxAWKJzbsVsCBtPQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHidsrFpadRR4uFdMuCnQX6wN5gRSDVKG6DNPHAXRxA=;
 b=oSEtzLjj9th9MLY3JFwAaH2HgRbXb2xEa7XGlp0dY1dl8biVUv6OVG2i5wk1zx8adoNxc3koQCEw970WkFzgFnJ+EyAYbjqR/VerYxgk5hhq4e8HmaM1oLfcbYXEdceiPBTuHlWwJKZMZ3DepdPDAyz1/boU1F7w1XL0nEToATwSFiY2USR/DxCUw+oSoLK4JM5Sg2SQAHbkON31KS5KDcc7hr4TdfSZE8GgMNK3N2YL6OsglNv3A9j4zNbvOadCqWwvPQ2rDfp5kysYuzo3bu6m5Ii/RsvMlhQeROveBk7OIQQh+h66jVAihj+avom0Vf8RGpiuSVrMRpEsqOT4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHidsrFpadRR4uFdMuCnQX6wN5gRSDVKG6DNPHAXRxA=;
 b=kVsM0aWkTUrsIHCcmbrLBW+GBMNCmKSRWJvMDKTWCnW5gZcQMdnw/Is+cTJ+ZzOpsHwmlRUntumF3KOnAr9J9cZbH27KGpWRm8k7X+6QWIedVCWkugt+LeTDs0KxUNM3LMOC2R8kuaYVt68BjJFlLVIj43eSqDuo/O2tZsvNl08=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Mon, 24 Aug 2020 08:04:14 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 08:04:14 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amd/pm: drop unnecessary smu_baco->mutex lock
 protections
Date: Mon, 24 Aug 2020 16:03:48 +0800
Message-Id: <20200824080350.32504-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824080350.32504-1-evan.quan@amd.com>
References: <20200824080350.32504-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:203:b0::19) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HK0PR03CA0103.apcprd03.prod.outlook.com (2603:1096:203:b0::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 08:04:12 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f0c14d76-b8f7-42ea-4ab9-08d848044a65
X-MS-TrafficTypeDiagnostic: DM6PR12MB2891:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2891B2E8D944F8EBB27F9738E4560@DM6PR12MB2891.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y0fc+8S3YfET9PLGaB7BvNcUAyKlSRdPR8yefK0Tq4NW5BHbH3BB0q6lseX2a4a7KQUnIC4FHN0kXp4iXaY/vogphDFsJqspdSznDVb0ZIjqVVr66v9amSrh9YPc0JZOuOrKA3MIcTNSy3CYYeLF8y4ym334Sq9lP1qyH/+2O+fCtIr4GggMF0zf+bXOd4JZq7WCbKpJtdGtwse/yosNZBR687qujtuCeUrHjWl1S+xXZElb4xKNmEc/KcsZReqaZXOcUAXFiIxaom8K+dKIoHbQHG67r3K6eIHkD5VzimRtD80ntVH6dIKRULC3DLIx78h7ziXWLcoUZPAXH8dLkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(52116002)(1076003)(5660300002)(44832011)(26005)(8936002)(186003)(36756003)(8676002)(66556008)(66476007)(956004)(86362001)(6486002)(478600001)(2906002)(83380400001)(4326008)(2616005)(316002)(16576012)(66946007)(6916009)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bwdk0zXp7gjaT6UsC+PLXwhdhsyqOLjNHY4BPeJSPxtjamzrt79sVZJRlH91LfrOGMm4DhM8rVpz/lCRm8+MNrn82Cz8skOLFrCwgaNUB0V2pCJWsBdYpHfbVTFV/EmRlhSLm7rA1Wpcl/k6bnKbiy/SHFz9dw0FQOMGN1FwVIkHacaYZAGyW0fjbW40ic1Mz12XFGqz9qraOwinpwYUPxvj1eIld9JIgfjPmohLMMG8aJsZAfcL22dVYgchGIyTmIHRt/cJi4EE34lZr9qgjHUNCiVbPZalRWURVHOsqgYACJ7jsNbAvvYVJChmZ3OxHXx6SLR0D8CQANbHXCsi6AWb4gXJFeq8NvjrSTgGQJsjTx8n37OmZjWPfkNyKL+5949QNWa07Z1I+50vXj4z57ToAjXSX/7Pqgjt3xZznHdZqQyodBwv4Qd5U7HM/R56DClMnkGfRLYpN1M8r6Z1+8UCHUomeDgtk8xyE9z70c7l0cdkAvEznWgGWtOionQHn9qLTS4LVWtyI2+7v+aR8gotno3VJwEpqkFCB6DUJroxReyhtKcA8B19auSi48Fn3Rg0YfJQ4IxBu02x5fgiciKZEIFAkcQXhnFsRcaI+AYYvwrY6raajPYT42HQFz/7booRqGX7QfIif/PcmHtIZg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c14d76-b8f7-42ea-4ab9-08d848044a65
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 08:04:14.0854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpO2BbTKGQabvUUAj6TSyltaf08UVUp+HmFkyr5PbSazIHQH+Yj1i4knwKkigXyA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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

As it is confirmed to have no race condition during hw setup
and baco support checking.

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
