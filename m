Return-Path: <SRS0=eFkV=CN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B68C43461
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 08:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D53206C9
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 08:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3YYXNKIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D53206C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 467206E293;
	Fri,  4 Sep 2020 08:27:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA01E6E293
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2020 08:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kT/QlHdjYiyy8h7nQcZPJgS5LK7jk9V5vy6NH02Zgvd6ZAn38bFA9lHENTShRJzcOmegvUx2nRu6OMcXtc3bFtnEqBa6BqHUNCIiqZmP7HsLndRKD9cRA0Ioi+uDwNbBMxWwo4n7uyYFT2IZKrkUlNkWQKa6Cv6pEUCSWSkb1r8bg7lJ6MzVJTb3w5JERffYaChNnZ5fIbwS0tPz61li/PJCbe1DshDckdvLy98McbFy8Lg4oa6dM6tBMxszE1a8KeW14XWOy3nD0jrqWJIOPWyN2fh3oBeADwNI6sLvFg2qQOyRlZgY26UJibFo/mrDMV7XP3Fy22FMc9O8BNtl2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wfq1ctt0Ku15hER1NvIR6E80REJbcaBBSUxey8+qMaA=;
 b=RQMKHh5894GdYOKKy/bNmpWg/A7146IHvKG06386BOAbtniLlIQoguUVsSwTmkE80Is8+WC4OT7kHJCnjUQwBtyJKo9YwVSoDUfKm+Ck7g5RDVzaUry9y8pLOLinSsA4oJThfXvu1JNbNi2jSL7yo1tsQanEcbbl+IRF592tv0gZT7XdtxjkA6BqHZTEWYwuRNfPPXkiE3snFX2vmury52CluNrGSGKZUxiuRM/tiDzXqy49e0CsSiRjUe2ij9YQ7TBDsWJ9pKbGJuli9MyazqbDzMggd40j7LM/v7/D2sDu2xLbW/tyo6QP9erYCi+aqo9AKuMsvMcOhH57KZa9Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wfq1ctt0Ku15hER1NvIR6E80REJbcaBBSUxey8+qMaA=;
 b=3YYXNKIZQ+TwTCmWzNy23HGEXfjjIM1LYXjboc9sPj1gOFEu7heD0O/pS3L09JboNUjNcw/0MlB4uykfhgT3We8yqwJubozhi2LpxdEiDtWsBsk9h9ZQ6gFE9AvdWZmA/caHdILpIfV2oRQJHt8TBvq1btlMqCEdfbycmWOlbhM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3468.namprd12.prod.outlook.com (2603:10b6:5:38::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.24; Fri, 4 Sep 2020 08:27:40 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3348.015; Fri, 4 Sep 2020
 08:27:40 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amd/pm: move NAVI1X power mode switching workaround
 to post_init
Date: Fri,  4 Sep 2020 16:27:14 +0800
Message-Id: <20200904082714.19995-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904082714.19995-1-evan.quan@amd.com>
References: <20200904082714.19995-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR03CA0043.apcprd03.prod.outlook.com
 (2603:1096:202:17::13) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR03CA0043.apcprd03.prod.outlook.com (2603:1096:202:17::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.7 via Frontend Transport; Fri, 4 Sep 2020 08:27:38 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f0899fa-a909-403f-96a5-08d850ac62c3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3468AEE5247B6CEF523E522BE42D0@DM6PR12MB3468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:248;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EdG1DfpfV7mYxOiXzrCnk1Ov5UwEjgMeGpA0XP4cRH7ePlr+0yxl5tVi1TwqtANe10BJoFE3YfcC8n+KdJjup3gPI9MRQ8XbZr0tyFNy9X5KKtPr59WCBKI1k8yIkk1jj8BEcnJ0SXEPey4syXiY8khFrAYk2mqzDqU3z6hKO8popUi0l5w1w6agMscE4mB5U+y9HA//wPM3ZOE7nrE80LZDZmA4B5y8FY984IgP7b187kbMbAucq2jhLh2pxj1PRg/dMd3C13ANyV5sYLBXq3voV98G2oAruPojHYI0VJ3d0HqSO7dtgDG240zPQlh9TkhFPV91tScEKlgP4Y+GrqztNc3nt8Fi9zRHv9rtyeBiYeu4t6XIJms+mgjvsdAU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(4326008)(8676002)(478600001)(66946007)(36756003)(8936002)(7696005)(44832011)(52116002)(2906002)(316002)(5660300002)(16526019)(1076003)(26005)(2616005)(86362001)(6666004)(6486002)(6916009)(83380400001)(66556008)(956004)(186003)(66476007)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: tIpQRdC67Fqi5N4CIVF0fW+Niz51mxUW/F3jGPU1kYDqlcYRUqDMqk86oi3zrwFfQ/D8Ii/6Ka+v33I/tX23RzhbfwpMkspEnLAfGWX5RtJyMSTgBwA6zmoEX6HMJD8CQj+yH5BrixLGPmIF0KhVtmOvUNL2KbWFsxwszeYz/UESl9yJl6SvJhS23w3q5K7U5FMR5PT27t67uMi9te9k6UM4NrMjqH2CMo57CFPju9kCCl0AZmvuTsRd5hPedS+QwAzTte7tq2Z5H1E1AKA+BY9ZpqCA59llIEA+8OvYtrP2hQxO7zeRTNET5bZ81mq5rnPSnk+u5ylXgH2Q3KgGonBucEwCvjQs/Aj+JfvqyiXpNM3Zx9MLsj83WZJmE4XNoUZ3GwYtrjfd+ANrYnYOx7rzOQ8D6oie+mu21WYHNcPiBoT0cShC2Ys2rBYzrTxV6SuPCRiMUV3yEgufj0AQSjSgzSzT98K3eL9vvv3k7DgZ7/cRmQ17B1boxOW3zZBFoaUZkQjeEkRq0gkCUF3YHdCrn3UX3DqZHF1tS2RlpEsaTelStfzcgtPs5pLwoLhti5Vmv6uLQKyhjIh1er9ftTaKXN+YlVfHa7lZYAM2SNexrgatQEXG7HZPOmxu01DP4uE19HtrhKFZFwMJfPDoJA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0899fa-a909-403f-96a5-08d850ac62c3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 08:27:39.8834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbtHIEpjbT7c7skti6cUsQQhr8ElFsh0YSLvwLQtM933oNm825WFqaJvqRNX6k5A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3468
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

Since that should be the correct place to put ASIC specific
workarounds.

Change-Id: Ia7cf4bfabf85a4409e57542926238c7e196af719
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 14 -------------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 20 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 35258f980de5..5fa80f8e6b44 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1013,20 +1013,6 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
-	if (!smu->dc_controlled_by_gpio) {
-		/*
-		 * For Navi1X, manually switch it to AC mode as PMFW
-		 * may boot it with DC mode.
-		 */
-		ret = smu_set_power_source(smu,
-					   adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
-					   SMU_POWER_SOURCE_DC);
-		if (ret) {
-			dev_err(adev->dev, "Failed to switch to %s mode!\n", adev->pm.ac_power ? "AC" : "DC");
-			return ret;
-		}
-	}
-
 	ret = smu_notify_display_change(smu);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index e82e20f85ef0..42645e2f5419 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2701,8 +2701,26 @@ static int navi10_post_smu_init(struct smu_context *smu)
 	}
 
 	ret = navi10_run_umc_cdr_workaround(smu);
-	if (ret)
+	if (ret) {
 		dev_err(adev->dev, "Failed to apply umc cdr workaround!\n");
+		return ret;
+	}
+
+	if (!smu->dc_controlled_by_gpio) {
+		/*
+		 * For Navi1X, manually switch it to AC mode as PMFW
+		 * may boot it with DC mode.
+		 */
+		ret = smu_v11_0_set_power_source(smu,
+						 adev->pm.ac_power ?
+						 SMU_POWER_SOURCE_AC :
+						 SMU_POWER_SOURCE_DC);
+		if (ret) {
+			dev_err(adev->dev, "Failed to switch to %s mode!\n",
+					adev->pm.ac_power ? "AC" : "DC");
+			return ret;
+		}
+	}
 
 	return ret;
 }
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
