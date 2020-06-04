Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4564C433E1
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89FF92072E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4K8boioB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FF92072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C57E6E192;
	Thu,  4 Jun 2020 04:47:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBA5A6E191
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 04:47:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRhCvyIZtlkl00q+AC1gvCfmgURLqWGVTJd3CvP/WNpfXMIDwMKw1EnHLjy3qPjvfN8qmxLpkLmIf1Pg9E6AwZTZWsP8/lbJMLuXmCIHzIK345sdXI62sE9Md6lntuQzCKFStCDo5A/70m6rTLHciAsH2eP9+VUv3QWukgkYbcYe7akb7fVU2Aw15PvYp6T/D8sOFZMl/W9JoiWCk2oKvVc8G7eIA6ptOwSDUtXopEADWx5wbd2dwG8h3JGYde0FsgQUYFba6LaGq4MB0aMSJxM2VRiDmiJDBeRlaw/Vk+GiVS2NgdJnF5qLWNRhAyIhGzGxFtW+y7UhocN5Nip7rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCaHpUFo3I30BkyxyxPfx82YXiVgkgO+Zz5+vZI2F+M=;
 b=iGtqDoO73oz2a0D+LYFaf498+Z1+gLDcgORjXTeIQH+QquipTPY6Bbiv/e3VT8S1dgQKaNQjKw+LmzSk0QgmkklGk+7ST1gMwe13eneM8LtyoRxq5k3HJt3elHNDLm3CMqQwgq4FP7uwys8FFq8td78qQbz1UCQ6Kn6AJ7fIEkyh70kDIKu44JNagv3dpmrKvRIBlPvwJiGpoEMUyAxNzRm0mItTn/YzxiPAQLwhUuUBpVHKeZ3HHtBP2Ex4qohud3av1oy5qrJHna53Y6gv4DaYn9wVYR2TKlWti4sP0uLUMrvvrZczgnEwdPMq/q6wx7GCARW4k71tXmoHMwrN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCaHpUFo3I30BkyxyxPfx82YXiVgkgO+Zz5+vZI2F+M=;
 b=4K8boioB/d89N5XLh13DGLU9sKCof529XYH/bhrxfEPklcSCWpboISyZyYw6RUCkJCc6OhDIGTlLq457Ab8gibLlu95tP7ZH2PbNIfqJEtetuY16mk3yidXvX/mpX6NOxu+yrcNGqsI+pZZJj5UfK3kmr3plvyNIKBYyi1uqXUA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3002.namprd12.prod.outlook.com (2603:10b6:5:117::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Thu, 4 Jun 2020 04:47:08 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Thu, 4 Jun 2020
 04:47:08 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/16] drm/amd/powerplay: move those operations not needed for
 resume out
Date: Thu,  4 Jun 2020 12:46:12 +0800
Message-Id: <20200604044619.18658-9-evan.quan@amd.com>
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
 Transport; Thu, 4 Jun 2020 04:47:07 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8438d90f-9662-4625-7a64-08d808425670
X-MS-TrafficTypeDiagnostic: DM6PR12MB3002:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB30025477164D40CDC3ADDC98E4890@DM6PR12MB3002.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qN5D7L1FM3zbCrnBtsOFhiL+3hC1205YsAY0mJ/avDdLmeMeh3looGmsfYUiR3+U2q2pECAb4owcu6bxXUoLnwVRcNk6kvRZNYGWqBUnu0jyHzjF9EnzITpaM65YMnih9a4I6qgm4kEkZdI6Ae2hfdgHaZ7kbJwPoY+43X0p6EmBhD4ojrJy2eoPFm2KTEVokvZtGPuIDmtd6Kb9VoCdIYOlcA4BhvUMfTKRNYX8vJPSMRsjL670wnt7uYXnL9LtziAl/vk3ryURfLaljmavynDAasNE5JAmNGjKquG27y9TxzpWe3gi5yTS6iyZ926KqHPUp8Dr+pKwWdYnQ4aKnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(7696005)(1076003)(52116002)(36756003)(2616005)(26005)(316002)(16526019)(83380400001)(6666004)(6486002)(86362001)(5660300002)(186003)(956004)(6916009)(4326008)(66946007)(2906002)(44832011)(8936002)(66476007)(66556008)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: D8zih59gniu/AU1fmhXz//zSsQ7AHlOHmuGGlyqlScNz6CJEE7Syr1pfCa0XZO6seg4XpKHlkrM/xi/jCTGIzwdx0Z7WErc3M0eKcTD4AChOR61QbMlbGrlY2/x0bCNV4xQAS7Jygu7NWBNvalfH//vlJgu6AHKMNFyyZ8w6OEuO2keQwPQmuyvhdGNAxGAd0CiHfyPtNi40YMY4uOIXfxoorRMURWLUNArolpLKg/t/UC/pyYsboeulJSwx9ID0wCiWnUQRwaey3ZFsYDZvZXBbNeBdaLHxdz4d8Wvy1Y4vd+u90bvGPE0Pa1E3ZrWxeANYLojRU1yx9lR94jbFB54zXik7LEfziOw3gYyZs65qaAwySsd9rHOgLrmn0DRN+t6hvTOsC4au4BRQIRRvAvKd6kIhEjFX9CtjNdeV32L5LJ/vpL6ERkOw2bMyaYSxdxgg9YwvHPumXDBGO9rt3+WZLZ3X0IOu8AV1R8su2gdnTQullEXWuc5uz5oyYoAm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8438d90f-9662-4625-7a64-08d808425670
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 04:47:08.6319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbc/WaOhSKHU/q0r7DChob+sOSSigqe9LpFiKkkwqe54BJG14bgcVGsfSUQ6dqdw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3002
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

Since smu_smc_table_hw_init() is needed for both .hw_init and .resume.
By doing this, we can drop unnecessary operations on resume.

Change-Id: I2af6277efaa9adba2de69161e20e54c4aa10a411
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 40 +++++++++++-----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 78fb2b42fc93..3bd6b9a5b63c 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1130,25 +1130,6 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	if (initialize) {
-		/* get boot_values from vbios to set revision, gfxclk, and etc. */
-		ret = smu_get_vbios_bootup_values(smu);
-		if (ret)
-			return ret;
-
-		ret = smu_setup_pptable(smu);
-		if (ret)
-			return ret;
-
-		/*
-		 * Send msg GetDriverIfVersion to check if the return value is equal
-		 * with DRIVER_IF_VERSION of smc header.
-		 */
-		ret = smu_check_fw_version(smu);
-		if (ret)
-			return ret;
-	}
-
 	ret = smu_set_driver_table_location(smu);
 	if (ret)
 		return ret;
@@ -1236,10 +1217,20 @@ static int smu_start_smc_engine(struct smu_context *smu)
 
 	if (smu->ppt_funcs->check_fw_status) {
 		ret = smu->ppt_funcs->check_fw_status(smu);
-		if (ret)
+		if (ret) {
 			pr_err("SMC is not ready\n");
+			return ret;
+		}
 	}
 
+	/*
+	 * Send msg GetDriverIfVersion to check if the return value is equal
+	 * with DRIVER_IF_VERSION of smc header.
+	 */
+	ret = smu_check_fw_version(smu);
+	if (ret)
+		return ret;
+
 	return ret;
 }
 
@@ -1268,6 +1259,15 @@ static int smu_hw_init(void *handle)
 	if (!smu->pm_enabled)
 		return 0;
 
+	/* get boot_values from vbios to set revision, gfxclk, and etc. */
+	ret = smu_get_vbios_bootup_values(smu);
+	if (ret)
+		return ret;
+
+	ret = smu_setup_pptable(smu);
+	if (ret)
+		return ret;
+
 	ret = smu_feature_init_dpm(smu);
 	if (ret)
 		goto failed;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
