Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6D4C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 08:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0CB22CA1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 08:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0CB22CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A43289755;
	Thu, 10 Dec 2020 08:44:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2101789755
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 08:44:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQF3cTuHOpxySXRmGnneP//p+vVs0rJpbghsGDngG6dj6fzFvFyicyCqSECACpVOybsBQQy2i4KdJj5enGH/H4rZM2AbaH2b7neqWbJybSoQWFL+N7wcURjeLh6AO0QEaTyWCZz7HRs0LsFgo0C6AmCDJuIv0U7QnPlF3OYvoKkD8kYlc09eudUow2aNwuLsYnoNAx7dFrqHpeYTrD7Ne+7VKbFni6DM/1BbD0wnrRgkn7G+XziReL+3Qnh8H0fmVYQPEn4XCBRs7EvBrppMCC9zX3ey/ZAvnX3yxuvSmI7LOzn/4EIhDLWdBxec4Ajil1/pDsJnZg2CvAB5olvL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7muYyuQDHYLsG7GVVaumxpOD8Yd1AWaaPujmKpiv94=;
 b=SLuCp2jfd61R1phv6ZMjsPtz9lJpc0M+0wRvll3jZwQR+vXEinltwLq1DY4chsqeaf5bc5kbqHdEF0iZ6IxDZCj2zfjKKXFvdb660DzIS/+ioeQh3tzens39bVJY/Y1aUPfRRV/ZOeqeFaOqGY5TFQKZeDhYxl051l3Ov5xwlbx1UFoi+SL27ASDgRSv0bYqOLtybXCQ6nKvresuDkYSOqjAQM2AAywBRVWTezicRFek1J6FuLM8g4zQ74+54+P0TB5IzF+20KyoW1/PiKJq3UqdpyKIV7yt1YrIx2pyHVEbMLG/Ws1tY81Y4uELArQHDqQkrDz93BnJmL34hHRCyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7muYyuQDHYLsG7GVVaumxpOD8Yd1AWaaPujmKpiv94=;
 b=Mo11L4bFQ3xJUQLS+BRB7YzsDQFY+gUPfkzgXpVN2l2sl/lTTgyZb9Uz1Aiqoi0ejpAE5mX1pwq6f+zLx/j03v0evC0TKkHgpKEFt8zmlkMywFcy64Ievp7bg4AddUv1uPsJT1EVzlv39t90oDRLusTF0tVMhWwIgvj5M/Y9XgA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3769.namprd12.prod.outlook.com (2603:10b6:5:14a::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12; Thu, 10 Dec 2020 08:44:43 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Thu, 10 Dec 2020
 08:44:43 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: add deep sleep control for uclk and fclk
Date: Thu, 10 Dec 2020 16:44:15 +0800
Message-Id: <20201210084415.206309-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0401CA0024.apcprd04.prod.outlook.com
 (2603:1096:202:2::34) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0401CA0024.apcprd04.prod.outlook.com (2603:1096:202:2::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Thu, 10 Dec 2020 08:44:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9eb808f6-81b6-4fc8-4ebb-08d89ce7d73e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3769:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3769778A0A2442AF5BAE42CAE4CB0@DM6PR12MB3769.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1OqXeB9sqCGy0LbgJE7zbOMvZcnrdK+aJzIsYuFaUiC3HjsfXPNRayEcL1v8wEzmOMd8QzfXOh4jxXacBMFWN/412GyF/o+l4rZeHohU9in1IsgFlOs0KXyPxEFgMVAa060VWeFETWNZSHYW8aouqaRJD3HbU9skxs8bEFK015aP2vJgo0m9fPez3zlMltaBK2MnJ4do/JPuTIzUcN0Sl62ES9AjcvyRxU5ESGGXjhchSf7WQUYLPaa4t/w2JmILps5N8076uQhCbQlLIYrwfH56p8noL+qYflyMqffNVb5boDZOypbqnjK0YslTW0uP4+046jy4aoeYNx1C2Vn00WZvnfQ1HJpqYwhWVk0kBuMrP1YuPLlmes/ep3RC5Pzp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(346002)(8936002)(66946007)(66476007)(186003)(5660300002)(66556008)(52116002)(16526019)(6916009)(8676002)(1076003)(44832011)(7696005)(26005)(2906002)(86362001)(6666004)(508600001)(36756003)(34490700003)(4326008)(2616005)(956004)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kKr1AYKH9GC/LUiVGuNWJR6G8KNuZydlv+afa2/2k5HgplHHTrBHeWKZ/2ZO?=
 =?us-ascii?Q?sGRpErTus1aX7mh60UIeYhU62QVDbworc01s1cbVojdrM/cNArttA17wljsd?=
 =?us-ascii?Q?Re7C1j1fqORgOoYtYQ9l913qChnr3FYW0OU1KYhTVdKwIxXkStPzB0Ks5cwf?=
 =?us-ascii?Q?ev8tZ7+HGOkE2OLe8xXjuvJbQZo9HhswzuYErDyaH3eGFgKN+ZHeZSnp6GU3?=
 =?us-ascii?Q?LlOQhEu6aUK9B+I/j/E5VaVyd51iGrFLs0jsOx+bhqswXN0yBPGBlWNYrLSK?=
 =?us-ascii?Q?hU5f/NHczz3n0DwGiOeNFsYzG4A+hXIjYuTigvipJAu+yl8F4TDukhT7H9wp?=
 =?us-ascii?Q?gJXSe/x4Cpb13BZa4L82gK8wt4qy6Oi4xx0CtH7ZcmG760gaecJnNxmJydQf?=
 =?us-ascii?Q?xT5aPl1yIPDwgmPPVOgpqIrFRLzSEnFilUDX+/B7F8z0PF1niW0hceyyLSz4?=
 =?us-ascii?Q?p86dq60EVXMG036/Xe0rI1HsBnCgXjJ0lpjFnDfiK8J93a1KajXKyp+Jll2m?=
 =?us-ascii?Q?YFyK98xlykd1c0z8VXwfY5LuIV500qTE8lexWkx8deTzRO9ZFhg3yazNHlFK?=
 =?us-ascii?Q?wdrEPK9A7iC728ZWI7KHIUU2Eht3HF5mkZUHEgiKGLX4gpAhoDqcTWO7qaKY?=
 =?us-ascii?Q?kT4DnO0ldN2vwMZ3IUkqHEEgifAuUDzVd1et6egK1Z7eZkkl4kunw0LzjJJN?=
 =?us-ascii?Q?hEdVyrofSux7i4+c36xTYW4RYJe2FE+mpJzl2oXmMmPxGxvOEQJ/GSkDsOvP?=
 =?us-ascii?Q?lDbauad+2sIZaXQisTzcDyhidW1lZ7x8RwQb8h3IAOYvizVL7Pw7LnxFvTZ4?=
 =?us-ascii?Q?XCV+BsAIby0pF2yn0V0UsmMNYIngijNPHXeNWwuNeTHph0AapC2ltc2j2lqP?=
 =?us-ascii?Q?kahnzMdALc2jzif6Fn5J0Lbos9Gd+bMx+DkZjVXxlRxbAFQdVH85LSl5dUfu?=
 =?us-ascii?Q?0Nr4hebO/IDJp6/sZAYqc+rrSp1dIWz1Y5R5QImP5TzdBKfAle7CfZOOr5MM?=
 =?us-ascii?Q?fRVI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 08:44:43.5098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb808f6-81b6-4fc8-4ebb-08d89ce7d73e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9dl871xpFngbDucdEZ77GAduusTLAN8Hgttf2YEaqCTuK4+ujsknYBssyxbrCyR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3769
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These are supported by Sienna Cichlid and should be
taken into consideration during DS control.

Change-Id: I93ed67ae863a91b75d6dfecd87e74029ffafd302
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 45ecd0386e9f..0372cb83cdd9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2087,6 +2087,22 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 		}
 	}
 
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_UCLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_UCLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s UCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_FCLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_FCLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s FCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_SOCCLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_SOCCLK_BIT, enablement);
 		if (ret) {
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
