Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B5EC433E3
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 08:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826A42072D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 08:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uML9qV+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826A42072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 084F06E1A3;
	Mon, 24 Aug 2020 08:04:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F41C66E1A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 08:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdPezcDX0FiFCBVCK32SMXG+pGEqVGomntTX5Cwiou7AiRHle5DrsqwzKf6m1oIpPov/1WL1Ax29GCMg3HUGiLP9eM0thUvHZXKI56FzfJsfGXQVe8qEm0+YbDyhKQCBo4UWihjdTSJSQK6HIHauLonJIfqqhsGD+RJNbxqGeX/8qa4FxAlkpzvsxaarRFpqWJ0V2Uq86OzBE7CPoUcatU4LKcD0rq236vw5h1fG2JQ69BUonDV7301fbCU1uon4SKr4agSvgydxYLRbX1Gjyyvgo1hBZQEPYZZGcZTZ/gc1mDXDYnxO6NYxONu0anQ6XwR/KymLOvgT8hMvsouL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdjO6taV/2eziJvFChlM9kJ54LtFmwwaIvKayrB6/Z4=;
 b=NVUuPLnSXrcKuMFX3aFoQQfOLXiLRsXEeo4NnGUtfw3m/wm7tFPzkROBizcxgaAf4S1pMmoScWeYiD459gwInNqHG3uyXy3BmsYcKBgDFcq2sSwBXOvh0aTjiwTLCmcSXH5Pjdat5jdn8S6TpbPVAa7+QhKehdZipQx0YMM5+jeZ98OrdFJiOnNgloEbt9tcJec5drsHwwMu2QVLTUxHgDtPCUEdW7TBF81zSJXu6quONTm8lURnsjYOm4e2UevQm3CFUB+CodI0XSCanOELPLuXyL/UzocvThol7k87Djo9U6e7j7MD0z3XJLXejpnYmdT6FFnZel91pd+F0w8Acg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdjO6taV/2eziJvFChlM9kJ54LtFmwwaIvKayrB6/Z4=;
 b=uML9qV+UNXk0XnU7cwSP+5ZlkWe/S6bE8Cz1rvXgEn0dkVzEQG43O3dc19Y16FeSOG935gxVqkDidkHaIsF+GsJa387KP2g98QMIDA3WyFmuzk71RP5fTQsJu4neAuDFymbvtrmHQGYzndVh3S6dP8H656S7ork0Brsx9zHCoaA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Mon, 24 Aug 2020 08:04:10 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 08:04:10 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amd/pm: drop unnecessary feature->mutex lock
 protections
Date: Mon, 24 Aug 2020 16:03:47 +0800
Message-Id: <20200824080350.32504-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK0PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:203:b0::19) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HK0PR03CA0103.apcprd03.prod.outlook.com (2603:1096:203:b0::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 08:04:08 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fb74c4f9-bdf7-4d8d-acfb-08d84804483f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2891:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2891212E1907815599359B11E4560@DM6PR12MB2891.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MlPt1+ABa0Nu3NdXPN3R90P5tI9UY4jbZ9vS3fCHoq1UecAQiQJXhVFTFBWpRZa/xTXtAKq2wcT/+vLNB1z7Ee4bOv6D9LP7DWmAxuU3/0l+33fLE7iVY63nwDPJb/JdgaDtkhjhkaEIzEl+IsAs/uJl+iABxMK/scoHGMH6/t2FmBb06U4b6TCCIIX7nYqa1lojkYakRSj2JBv7oXJLUjz9kmOMl4xItBtgL00yXnpA+SUsmgJOzYlUxvVU9Rih8MjippLvElrWtfozU8F+d7NBwFhpeaEJ/7ilzCKIpRFTt6/1HWP0QQ1c4lV7lbuDrzHIaozyHMN3MTfpU0etNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(52116002)(1076003)(5660300002)(44832011)(26005)(8936002)(186003)(36756003)(8676002)(66556008)(66476007)(956004)(86362001)(6486002)(478600001)(2906002)(83380400001)(4326008)(2616005)(316002)(16576012)(66946007)(6916009)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: uV/Jitni7PZDtSn2sB8LefmbBV0UkFhHRSGum28EtI4FsUMUMLxjq+DdY3QswUGwmC966d0RMCGkFQSWJ2f1fWiWF+PgaZ7qxlkG+4ay0ye70UM6xOrVIjww/T5lMPlqvMH2DytRKpKUAoRlCb4HqPkPJW1OrlQJePzvdwXy9ZHd4lQm1OM43HFqGR1OVKA4otbbLVVEVl4Dw1u+cw0AI1laW402qXD+OnTPmpMS2ieaCeLYed9hT4hhdpsENREOe09FtZWC03D4VypZQKJPIsEFURhGLDawtpf3/oLxHEWt4wQ55d/JaCqTrSBn7SoJeKFFq8cmhNU5FdjWUrNyqb9Bm6ndGcff7Gve2LMXwzMTlSTwSEcAsqrQ9RSlnUtEC/Ug/CQvmNR76RJ9DUm0dSLB5CzbtLGK+W3PgNZ2/GXE9ABcyGfiMxo/R05G8mXTaJ8kkjFhJcd/WS4u8Zjr3VIF80KusYf+Vc0FqWT24SRLyq9SewA4obrVdiO9AlYkGfYc7iadb1kVT6CFnOjCZIvyyPt36HrpcRPaBN+yYwOQPvlsh1HhAoOUho0MWz5+tkqZi5MvQFAcLeNAo9WcZ69+TRug8L7yMpZu17qlnYoGrt/0ClQT+pngdhAT2zjZyRvaYQ1mpO6P1NPS8Y2hvg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb74c4f9-bdf7-4d8d-acfb-08d84804483f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 08:04:10.4785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCEmlE8BPzQprzSOoOR3HaaUFqFLCnaeU+4qdhDausj2w04Xdw7DO8a+0xr9o+U5
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

As it is confirmed to have no race condition during hw setup.

Change-Id: I096d7ab0855ff59b0ecb56fd9d6d9946b3605fc8
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 4 ----
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 09dc5303762b..b7cad8ef6153 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -361,20 +361,16 @@ static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
 	int ret = 0;
 	uint32_t allowed_feature_mask[SMU_FEATURE_MAX/32];
 
-	mutex_lock(&feature->mutex);
 	bitmap_zero(feature->allowed, SMU_FEATURE_MAX);
-	mutex_unlock(&feature->mutex);
 
 	ret = smu_get_allowed_feature_mask(smu, allowed_feature_mask,
 					     SMU_FEATURE_MAX/32);
 	if (ret)
 		return ret;
 
-	mutex_lock(&feature->mutex);
 	bitmap_or(feature->allowed, feature->allowed,
 		      (unsigned long *)allowed_feature_mask,
 		      feature->feature_num);
-	mutex_unlock(&feature->mutex);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 548db1edd352..28a19ffd22a1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -721,7 +721,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 	int ret = 0;
 	uint32_t feature_mask[2];
 
-	mutex_lock(&feature->mutex);
 	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64)
 		goto failed;
 
@@ -738,7 +737,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 		goto failed;
 
 failed:
-	mutex_unlock(&feature->mutex);
 	return ret;
 }
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
