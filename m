Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E4AC433E3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9B920657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pGTbILMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9B920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 058696ED1A;
	Fri, 15 May 2020 18:13:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F7556ED18
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:13:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8hNh4WYIaEBGjrJqL1PxppbCy4OePMwYKCpXEvPjgZP/BVNzMfxN+GBj3IHKPSqtzWQU4n9CQbOJ8MgQcGvuhnMfLNIlmPJgc70UjTKVMFYK/z+tg1/FJIqQ12hTlFI2eQ0Sx7qJS9Df1T3jc+iiYzZ6EvkgeGFZVWnAflDvJctlO7pcarDo+LzZ+m8zIfpL7H/uLXMcbmYJDBc8aXRmCgllVAQnWNpFQznvE2UWWomz5eievnmQrsg5LbRko63zeTflTvAlJvH6RflYyEssKgGtdXhTmkn6uksm3SFIaeK8sL7am3tlkymghMz/zVXdg8X0LJBn5550Opa4xWpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyhD74m9EsamaLSHQjKObpHdhsHS4dEme9o26qk+ekU=;
 b=CcwgyyXuYroUwMO/Hwa7dM+f04Kwy2ipKaqmpTFkcj25aOMfI33V/LzcHAcip+EvMb1LP+WWasmIILFfP6wV26sQ2Csx5NX/bZCu+hIsKZq/0WDehJbwbfAwV88nVtT1gNO55R2FKYiJ84ncDIzjgzSFwH2g7Bmd/tNlcdX02fM5r4o1eC+paUGzInxmzjn9eu+XNd0mBab1Q0yEuufOYnoVxTmiJLzNJh8M8nW07TgeLPEbOzYD3XES5ZY2zO8IBmZ+r0HvFg6Q1jiWKYF2zERq6Pt7g52lYtsvtP6xG/GsyKK45ifwKglMXmj/5aZ1vGh5bQDxz5rgHrU8EhzRyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyhD74m9EsamaLSHQjKObpHdhsHS4dEme9o26qk+ekU=;
 b=pGTbILMfX5lAjOaJ4c560mFqqGUC2Rek3ITOKE9ML3/yFuumWbbZEVUIZ0BXPDMozS1g8pwa4g2ZvGiN0ATbzKD2tykq40dykZdBEHNXLWdUtgCGUzXn3Lit63QbChvFo+Yr2euRiTDafgAPq17VdV3dbZRIZNfplkZnZtMJ+M0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3974.namprd12.prod.outlook.com (2603:10b6:610:2e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 18:13:42 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:13:42 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/27] drm/amd/display: DP training to set properly
 SCRAMBLING_DISABLE
Date: Fri, 15 May 2020 14:12:52 -0400
Message-Id: <20200515181315.1237251-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:41 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9f32d57a-7bdc-4b63-4de4-08d7f8fbb322
X-MS-TrafficTypeDiagnostic: CH2PR12MB3974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB397493DF4C4E20BAB70C14AE98BD0@CH2PR12MB3974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUNLtQGhRr2q2karpTQGBk1jZFkVp2KjTGBW8jsfahWmE2WP476VmdhpSiO7tIwIaN+4zNNrKteam0ksi/3jwC0ISgqUDNNqwgARrPhv7T06cdAX/u/omAhOGiIwB9ULtOPdFMh9gx5afBBc/Fr4lU52pFEGz6tSYsddFWxpoH5D4YHeLhcDESaML5hrsmgaqe+iqn3s3B5Bs5FxqDPcjoHdkuOqFbmuLk5HNGddBoQeODHX50G1YnA2NzpGhKO3jr3+FHvZcvRSc77qC5Xqu5x+YNlr5GaazwFyr7RSdkfs6VYdZtj/9DPLYgLCMn7x9tITnPBAoR/4VhQPLQ5Y1XtZSpL9avS6NakwF7qA0k7UB712POCtBHgzFpASRUX3F/B/3vxEZmg9jY6sWl5sjCCtbpIvhX+qAHHg1aSRFYW4rvePomzXjmeDLayWZGOR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(6506007)(316002)(8676002)(8936002)(86362001)(6486002)(54906003)(6666004)(5660300002)(6916009)(478600001)(6512007)(2906002)(36756003)(66556008)(1076003)(52116002)(16526019)(186003)(2616005)(66476007)(66946007)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: DLlcPnB2kHHCjZWKg65fqd7+kya194pT1N1rMINWxRQp4XPxkfz0GF9NuiJZevYITAiqFjoD9trT4oUG9CWYaJ7V8WfC2G2esr5PPjbwdN6T2zgOcBzgkO6x8bnRqwVkdVy7lgxAVfSvKTIJFoDFZHN8nvAlhAIPmhtqz6gj8L47IonPTmMV1+k48OrbGsWXUKq8M8PnC/Z/DJyM5VD3cZXPepRrJOUM7CKGTiq394gxaEwBAv60xkrQNZgWWqZ9NmGwkw6UZ2pEabMwBV6PYBmp23XEJ8aijK/Te3hEx6SDmduW5MRt8fi6aA2J00yPtZ/sJU3QkZILUqWtzi1KexRoWwGpV60lI9oJOsJKNHrenOPH1e0iBgLNs+Ld1uDmSal7WFGnvGqyUm2CxqTr2oWzCQBO7PG5IxGe7KA45fbsB7fUrvM3sy3+n5WQbEFHbdFaZmux9ucQzBJhO0RkrI6NvkLaAOtmL2+f3+pRSGuUei9XS5D9i5LsqKPuhcTOLeAn1VmuKLU8llitgnBYlA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f32d57a-7bdc-4b63-4de4-08d7f8fbb322
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:42.4189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCz30AYW0xeBS+yxguDFvwxbuVhEunkk9ETJgCZnAqQrDJAU7NljRIVVz+ToQNHcCkgM8+VbZlg9Q2a/pP0l7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3974
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
Cc: Vladimir Stempen <Vladimir.Stempen@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vladimir Stempen <vladimir.stempen@amd.com>

[Why]
DP training sequence to set SCRAMBLING_DISABLE bit properly based on
training pattern - per DP Spec.

[How]
Update dpcd_pattern.v1_4.SCRAMBLING_DISABLE with 1 for TPS1, TPS2, TPS3,
but not for TPS4.

Signed-off-by: Vladimir Stempen <Vladimir.Stempen@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index ebad1787f5cb..6db1f16957ac 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -219,6 +219,30 @@ static enum dpcd_training_patterns
 	return dpcd_tr_pattern;
 }
 
+static uint8_t dc_dp_initialize_scrambling_data_symbols(
+	struct dc_link *link,
+	enum dc_dp_training_pattern pattern)
+{
+	uint8_t disable_scrabled_data_symbols = 0;
+
+	switch (pattern) {
+	case DP_TRAINING_PATTERN_SEQUENCE_1:
+	case DP_TRAINING_PATTERN_SEQUENCE_2:
+	case DP_TRAINING_PATTERN_SEQUENCE_3:
+		disable_scrabled_data_symbols = 1;
+		break;
+	case DP_TRAINING_PATTERN_SEQUENCE_4:
+		disable_scrabled_data_symbols = 0;
+		break;
+	default:
+		ASSERT(0);
+		DC_LOG_HW_LINK_TRAINING("%s: Invalid HW Training pattern: %d\n",
+			__func__, pattern);
+		break;
+	}
+	return disable_scrabled_data_symbols;
+}
+
 static inline bool is_repeater(struct dc_link *link, uint32_t offset)
 {
 	return (!link->is_lttpr_mode_transparent && offset != 0);
@@ -251,6 +275,9 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 	dpcd_pattern.v1_4.TRAINING_PATTERN_SET =
 		dc_dp_training_pattern_to_dpcd_training_pattern(link, pattern);
 
+	dpcd_pattern.v1_4.SCRAMBLING_DISABLE =
+		dc_dp_initialize_scrambling_data_symbols(link, pattern);
+
 	dpcd_lt_buffer[DP_TRAINING_PATTERN_SET - DP_TRAINING_PATTERN_SET]
 		= dpcd_pattern.raw;
 
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
