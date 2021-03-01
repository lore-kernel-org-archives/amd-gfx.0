Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067D2C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 18:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0292614A7
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 18:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0292614A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FDC16E886;
	Mon,  1 Mar 2021 18:48:03 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ADD06E886
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 18:48:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ttj6hJfzfRiQs5uqTkYGLbbpkgX+JRsVg/i5OgAJYw1LsBs1NTcRBwB9efnqZ0pmR4gCkY9YvQQlfHHJxQMNk/afpaAvt0HL9hbV3njPOZofg1s3vXUB0aphNNw+PFZGlRc7WrDL9NQcy6On6UStof7P90UmEiVkEDbg6uqZkJg7d61KYM5w2X538SViE/wnEtA1k7eyfVTg8tRTngHrlctlcJlr4+iZj9pZZMfDMdsfuqoVOheaWUjgdW3KIzKSyo/m6LouocNsl4zoiov31G3WCl4Smd8wqPpqVXpBHo5ew3omCy9yIGeL5R2lbanWwlZp4LDvwwwnPezEekp+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ndnskPcu2pP2tu/DQ5t40P2WI/DucQA+ZHU1zcRG3U=;
 b=Gp/WJ7K5cjC2j3W9DIUCdfQmzYJ9BQ9doWIOexpFv7lsaDp7MUdKrYQ2FUSCaHYuNlyyZkwVGfN1TR4L4TSkM+GP8ych92+Pyr5zn9wRkg2KV2GMmKUXbr94mZ9VAIpsxH18ZIAyGNFHXk+d3s7kLg/V7QuqxpZvNH5BW/tYmlrX68oUx3BkOKOL4EcpkM2GiqmIkBklkqEmY8M/pVpAnpahDP7DYs9ZW353zeC74JA1HwxQlIfQOV1bVL42v1ysYr4VPnpje7BX+tSItiPvsHpI9T7K1wsn3rh3ljAdd3tUfrkKwnljHmR0uZYZ4nQWXhVSwjI9jqBu/Oo20YFzGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ndnskPcu2pP2tu/DQ5t40P2WI/DucQA+ZHU1zcRG3U=;
 b=EUv5fN9IEYlaczMH0uqLBk+BWSDILu8hhyD5eGQxWfxd/NsS02KK8nt0pY2+hjoRRjtGyDhXe6NjB+UQSfUOVv4xGkWqdUxB2rpVlvv9kfJzlNCTYMgwnpX5GsUhEdIcMLs0zJ60wcb6RasqFiSRE3ik10AA+r86h7ahSraPtHw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18)
 by DM6PR12MB2666.namprd12.prod.outlook.com (2603:10b6:5:4d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Mon, 1 Mar
 2021 18:48:00 +0000
Received: from DM6PR12MB4188.namprd12.prod.outlook.com
 ([fe80::e940:8e3d:17ab:65e5]) by DM6PR12MB4188.namprd12.prod.outlook.com
 ([fe80::e940:8e3d:17ab:65e5%9]) with mapi id 15.20.3890.029; Mon, 1 Mar 2021
 18:48:00 +0000
From: Arunpravin <Arunpravin.PaneerSelvam@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm/swsmu: clean up user profile function
Date: Tue,  2 Mar 2021 00:21:22 +0530
Message-Id: <20210301185122.977-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR0101CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::33) To DM6PR12MB4188.namprd12.prod.outlook.com
 (2603:10b6:5:215::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arun-desktop.amd.com (165.204.156.251) by
 MAXPR0101CA0047.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Mon, 1 Mar 2021 18:47:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 16f4afa0-59a8-488c-f83e-08d8dce289cd
X-MS-TrafficTypeDiagnostic: DM6PR12MB2666:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB26660F54D9FC087376D78D5EE49A9@DM6PR12MB2666.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOf+jRqimYZe7hq9J549UgnmPMedcZc/oK+KNgB8qy/E9C+bcbeYfvr+17e4A/HXOO9IWoQWPT3MreT5Jhq6xCpOY/jrBO+Xj7sptLEVwkbteuIPA7f/vDEHYrFQS54UkoOSyAdV809SFb3odMnXTobKaqEj9Ah7Hn3S9k79YqGcR8jItUokhaS1vAbEyexOr0NvEcF0gcWNaeRh/aPumf4q5sQWRhtcWv005Zotfe1pdwgRFofeAaQIbydFmer9AWuKwv/7dOiDsze8z4ZSeOROijLfHKBuX79I2aD9eMG6rZZeyDnkx7WfNReEDNqxnVLKZxLntURHA5tHDxW7ugT6znGVfShzszJThIwvZPJ14ga9LDwiNsBu0XrJOjUnCnMmPrHT3hrxwj/ikgo3qAlv9tNsS+2rkUauMI+MlIAmmAXg1vK3fYcl54zjXrSVNRQ8p9t5lA0yc4JNfARlx9pyin2F99cwG+gc6afn6KbNL4LZFh5oqXxYdYIuE9X6QSo4lpb+0Gu9WY6H5DK3BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4188.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(6486002)(86362001)(956004)(2616005)(6666004)(36756003)(4326008)(316002)(6916009)(1076003)(5660300002)(8676002)(83380400001)(7696005)(8936002)(52116002)(66556008)(478600001)(66476007)(66946007)(26005)(186003)(16526019)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PyUgPuV8SFFnHEaYDb30MXJN8gSJDeY3NmAkFkGbzX8MR5JK942HyDytfYHM?=
 =?us-ascii?Q?BXgjyx93BlyhgdyLocfwrIBf7Vxas8ByUHREmKDToItUJ9cmBLzPfzOJAkjz?=
 =?us-ascii?Q?nw81x9llxbaaaKT2WeubIb0ESDEDtxXGa+EXYixN7cRfJbr28NS7YD5ThdoY?=
 =?us-ascii?Q?1rbYq6ORPP4x2UPv+CTB40MwYtdef4Di8/fmcfKqnclGtiPMHyFr/yL2uJ0f?=
 =?us-ascii?Q?o1pJqnFaTaMbSRaD6BvVZ43n9ctIgasU6wnQbsUTLsLMKIUgbTeJOR8hPVKy?=
 =?us-ascii?Q?wispx1jpq1d7KwtK9O4k1ZCglVlEm8Ly9IbkiVfmm64iff3hYBzQe05Zs05P?=
 =?us-ascii?Q?sLSGo9KstZyDRIOHL7NX01icd+RyAGgGx1435WbS0Dtmepw8hceBVsRbq43a?=
 =?us-ascii?Q?lhbgMezJDUeBUmwznz7x7WNcHMy4byPxSs3rWS0JUmoQQxGJiDJVc0xQO6kx?=
 =?us-ascii?Q?9isGspRXuayAiKWD2y+6zClnVGiUOwZjVi8NvSyQHolJLD5J/+6LR1GORc0t?=
 =?us-ascii?Q?sFTSfVpw6Ccn4IgrHwZ6MXmpfvZwTYUi2L3GSDRFz7MvR51DhX7oEbos9rN7?=
 =?us-ascii?Q?qyeSfn4pZCS8Y0WGffXVcBuoNYqOwZF8IN8wr6Elr1eXNe3m5xAcsBIbZ2IR?=
 =?us-ascii?Q?qjvnLc+pU2UZ6YO5Ct+57dpXEEwKvlp4DZ4mSAwH+BIAcJhfx4Vprr7eyOKw?=
 =?us-ascii?Q?HP2oYhrOGDqYibRiEepFSTdACTD8x/iVKMaA6dPtY7LkZU9rBjhzVavtXaqT?=
 =?us-ascii?Q?uHzU3O1loduQx4Sjg3BmX4vreg33FqQHmXRaJAoR3IBTf997SSN5j35g8qfF?=
 =?us-ascii?Q?HJ74Iwdp0G1HCXi8/sGiodBhZvpk5kGQfdHozIEuRq5V2uxgy6SJj6ViW7gn?=
 =?us-ascii?Q?klZE8xxf2wLTSiQu/+UDMa184VWaeGSX2aqO0eRRtYTcSWdYxflBHsZ78Y3c?=
 =?us-ascii?Q?Mt5sq5rgyFyaEbKiiRLqznAc/jNFhSZ/0AKlpKmSvVYNEm7YS1sLY6xMYvZ6?=
 =?us-ascii?Q?/QXDaj3cQC1sUgQqSZPtIrRJI3o2grDTU6Tn5SkN5elXI4SUpoP/TDPlp+xy?=
 =?us-ascii?Q?pdQhtTQrmLUYsqWu0IdOAdLZLn1EeFQrX+n7tQMk5cBV1wEA6RfxAN+RDGVe?=
 =?us-ascii?Q?ECYJmuWtbfR+9SacIXwo+dEcIQizEibcxergspmXitRDcA1NPnj20gcb5yAP?=
 =?us-ascii?Q?D8O1ufpToL/Z2SnB5HgAlimSk4PcrD5FG9h4Ky2l8nQVtN8DEBsbXUISsXJ0?=
 =?us-ascii?Q?jQPNVOVFUuXwJm81P+fnkJ7a1my/mFUJHQIuNxOCkXBS1zJd7iQutd/kb4bK?=
 =?us-ascii?Q?iwYBU9akbTqntjvQG6ONg8r3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f4afa0-59a8-488c-f83e-08d8dce289cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 18:48:00.7374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WChTo0ufoxQVHMsCFVAOAxoTuxHv3hXj8wi5izXuDwXAUpoWBmUcDb1FoA4KXNhrA5Ff4agJJciTCvFyqu9yqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2666
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
Cc: alexander.deucher@amd.com, lijo.lazar@amd.com,
 Arunpravin <Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove unnecessary comments, enable restore mode using
'|=' operator, fixes the alignment to improve the code
readability.

Signed-off-by: Arunpravin <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f5d9590f2178..7d7ef4fa2887 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -315,35 +315,25 @@ static void smu_set_user_clk_dependencies(struct smu_context *smu, enum smu_clk_
 	if (smu->adev->in_suspend)
 		return;
 
-	/*
-	 * mclk, fclk and socclk are interdependent
-	 * on each other
-	 */
 	if (clk == SMU_MCLK) {
-		/* reset clock dependency */
 		smu->user_dpm_profile.clk_dependency = 0;
-		/* set mclk dependent clocks(fclk and socclk) */
 		smu->user_dpm_profile.clk_dependency = BIT(SMU_FCLK) | BIT(SMU_SOCCLK);
 	} else if (clk == SMU_FCLK) {
-		/* give priority to mclk, if mclk dependent clocks are set */
+		/* MCLK takes precedence over FCLK */
 		if (smu->user_dpm_profile.clk_dependency == (BIT(SMU_FCLK) | BIT(SMU_SOCCLK)))
 			return;
 
-		/* reset clock dependency */
 		smu->user_dpm_profile.clk_dependency = 0;
-		/* set fclk dependent clocks(mclk and socclk) */
 		smu->user_dpm_profile.clk_dependency = BIT(SMU_MCLK) | BIT(SMU_SOCCLK);
 	} else if (clk == SMU_SOCCLK) {
-		/* give priority to mclk, if mclk dependent clocks are set */
+		/* MCLK takes precedence over SOCCLK */
 		if (smu->user_dpm_profile.clk_dependency == (BIT(SMU_FCLK) | BIT(SMU_SOCCLK)))
 			return;
 
-		/* reset clock dependency */
 		smu->user_dpm_profile.clk_dependency = 0;
-		/* set socclk dependent clocks(mclk and fclk) */
 		smu->user_dpm_profile.clk_dependency = BIT(SMU_MCLK) | BIT(SMU_FCLK);
 	} else
-		/* add clk dependencies here, if any */
+		/* Add clk dependencies here, if any */
 		return;
 }
 
@@ -367,7 +357,7 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 		return;
 
 	/* Enable restore flag */
-	smu->user_dpm_profile.flags = SMU_DPM_USER_PROFILE_RESTORE;
+	smu->user_dpm_profile.flags |= SMU_DPM_USER_PROFILE_RESTORE;
 
 	/* set the user dpm power limit */
 	if (smu->user_dpm_profile.power_limit) {
@@ -390,8 +380,8 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 				ret = smu_force_smuclk_levels(smu, clk_type,
 						smu->user_dpm_profile.clk_mask[clk_type]);
 				if (ret)
-					dev_err(smu->adev->dev, "Failed to set clock type = %d\n",
-							clk_type);
+					dev_err(smu->adev->dev,
+						"Failed to set clock type = %d\n", clk_type);
 			}
 		}
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
