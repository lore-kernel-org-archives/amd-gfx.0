Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D95C432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:07:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE4661BA5
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3AE4661BA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56E476E07B;
	Tue, 24 Aug 2021 17:07:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B81AA6E07B
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 17:07:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHCx9nKkDpopG9OFAfwbE3QrxEgiDB/450V3YJiN2/4BAWsz0TOchtMGswE8SyP+lBVpB9S0Q3dBnX/bKEUNEQxl2PZFp9mscfthKytoW7NLtBYvptkKEqOxSoCGDPDoo/s0nnsv5SnJC5NGWz7AzoEYiwr+fmPjZMsxNWhfNfhO4SDAlocjeTuz43u4OkH2Nu8+95xwxRVu2A00K8bDT7EUwd5siY7v6md8CFP4o5UhUWXLtuHwvZ0KHUjDTkf2gU/TGCPBQO+nS5moT0dAlToZ9XEHUVraPGnuirwU465G/H3kqY7QRpbKebHMb0TboLdy6tGID6LUvzOp6XfVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fOv71sZsywPDzwvhGCd5CzCaoNpeapL6NtxZWLIqO8=;
 b=QH23f1cOqhPi5jebY1A2lChB6TU4ODYob2CIoMa4eP3lM3N/gofNuQeWb0FAnjetvinjL+zOaPRGEbcwkh38wt7PqnE3aO5Bx5IUanJg84vHLFAfe4w2u1Tz62ZY6AHssNGGMqlVadIS2BDQEOsc4aO+3eg8xp00fYweD90sq8hG8+7VKrlkVv/ez3CoO/PWeh9wDxqsr/AIzsZ2v9bLpH6hV8MosPGRAurMLSapU+aAXQaKPHc/Xi3kVx75lYT30KiW/ufKHmay4nweW1gnkP0w0a7ZwVsb6glk4gatyv4rkHCsK7il0QARKYl/RMH2cJh9/yUuo9pH0XLplVGjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fOv71sZsywPDzwvhGCd5CzCaoNpeapL6NtxZWLIqO8=;
 b=bSfnB+ELwXPMFDz6RkcM5aNhQ8jEj70rxxcdVLn+1EsvMbks4+IGgoQe6Pgj2cjyxow2ZE1PiZYAB6Icp17wfnVyuinhTG7V7gdeAm+fdWRZiV2r+A729KFtEBIQ78m1O+vniAv6lkF+fe27sUQPy4bhdNc7io7OXqD6P5L33Pk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Tue, 24 Aug
 2021 16:51:22 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5%4]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 16:51:22 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/8] drm/amdgpu/display: handle all cases in
 decide_cr_training_pattern
Date: Tue, 24 Aug 2021 12:51:00 -0400
Message-Id: <20210824165105.1913700-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210824165105.1913700-1-alexander.deucher@amd.com>
References: <20210824165105.1913700-1-alexander.deucher@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:208:23a::34) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:208:23a::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Tue, 24 Aug 2021 16:51:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18c8d0ac-d836-4d9f-e7ed-08d9671f66e5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5349BA245C26F61587724C3FF7C59@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rTAvFQkOvSH0eMqqHGUzI8JxpAjoKYGf2jxdj6Wky+nv3t4QeUjdMpGbaBv6q4fp4eIpHvVmLlinuz/tmqWwDuny9uuo+mFu+ASusTBvvt7WxSTjUrbELAnOdbEzgvYJ0gYL3H93qsbt+jpk1qeKN8TrB6DbUmHhpqLrbhzCXeS2ZP3CG8+ZoXDbKonbYbzw50YiTOqBPV/Fm7CT4xGFZKV7iBj1rF3pfu3cEPc4Jwr0HQaU5ft7bw/gF5CypuSCxjC7+KhW0lYLXMHgfInD2JjKgw6Ly96fORrDo8SqP62kTMZVpO3lFTz+C2BVPbKTBWMXKYtUtZGFQGkk/8VTTA0keRmTjudl3zA7jXp5NEV1eC741Wuo5yGJ4z3czkKd/rrM+p0N9HzVJ7jr9CbHBT5cSSYAUQ4J0BHgb5gBNIwNwsdEYCrdVGROIk8OIfW5pDzyxpJ+nTzrnaKzxJOwQJlsUbHg7fezz9Id967o5OBfAnsa6U7cX1y6oivTP8UPF1VsfrBSw+eJ/v+Z9hXELDQgrX3XKJ/KV+U9UVuHg3HTmIeUlNAIUuFpwg7++bgZjJLlJIMXPanukHL0h/wqJWR66/7exv61sjTWOVOUGvgjSduBWG7ibeWtnTCg7JECSwanNpi+xeKsCAwuNsSjxVy2x0K8MH/Vk+FuDDRe1JD7kaNJ4pNp5qr4tYiDFxohhgepdXJvhzJlIHlbjiDUnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(7696005)(52116002)(5660300002)(2906002)(66476007)(186003)(66556008)(8936002)(478600001)(36756003)(26005)(83380400001)(38350700002)(6486002)(316002)(8676002)(956004)(6916009)(1076003)(86362001)(2616005)(4326008)(6666004)(38100700002)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fDukN0RuYS7YURb87bTSRgGXAxv8zP4PPbY1jnfvwjSL38Cj+vaOPfV9hOAT?=
 =?us-ascii?Q?gTNYESgjCTBIcpaDr6Xt2H46+0kcAn4DzjbrkJTh7Sh3kBVheAoK0iiMO6ga?=
 =?us-ascii?Q?xyEgip2XcesJdIKd6kIVTsVotATEJO+2PNtI0MkTzwNkTrSHHqRozzpXhxuD?=
 =?us-ascii?Q?UCEfEm4NYiZM8oQpwi8RxJBrAREUqvbMAXXzxl/lZy2N9q3e7hrK9HnC+QV0?=
 =?us-ascii?Q?IaMjjnBTGXJjokSKnZUAvaNvODeliqcQUmEi7ThqVmzYCGvwSPoS2Ow4qZtZ?=
 =?us-ascii?Q?mOIWsBQph3laSjwNtjApFhjHQYYorS4TLWhJHGLldVWJtPzxLA0ZQy0a8krY?=
 =?us-ascii?Q?PNjKCyRosv3zNPYhvPVnsg3Tes4zIBcOVH4uCoyuJ0cNUiAJuONxa83WPxbW?=
 =?us-ascii?Q?8oF3l8KBQNAmrE2ZInNOZhqXYt97BRtyyEbmU6IHeAelokorWe6+FGaki5za?=
 =?us-ascii?Q?59HtMHC3yUyeFNoknKz0Db+5olgMlxDDbHRdgq/8UkgypkiVrH/mdEN0rzNS?=
 =?us-ascii?Q?r9vcB9OLJw7FmoBLEXUz6WvXCj8VWq1+ghMg/18aaPpFD3Aclssy/ArJyuqU?=
 =?us-ascii?Q?3uq77liN1txyxgr/VWjHBGcvj+Wx0XFuYRtOBENQP52wQhoSMGpYGUKE0pMs?=
 =?us-ascii?Q?sg8SMfhXw88KsYWjvouoaq+2BB025UBfGLqPDvuuJ38ll0qNdjMGZu0ZSj3d?=
 =?us-ascii?Q?JJdlyuWyaJHVChf6RsZ4SgMl5P6xDLKq9mJu1rXj58KB6Qy1xm/kUokHENNw?=
 =?us-ascii?Q?ibfgOheX9fNz93w6Mu9Os5hEbPfmRCZwrK2EBBxvmH1IS3ojIoNold7oALI9?=
 =?us-ascii?Q?eBUHOtF9zYCj62j1PMF/WpIrgFO2KKR1u906KGZBj4/UYgxeqqXnASMYawFC?=
 =?us-ascii?Q?zX58nAhP/+wx+OhLL4EfkmsUn9MlGYtK8wdNag6uqtfzvq2gPQBYM4AmtZhi?=
 =?us-ascii?Q?fEVL10jgg0nv7Kvp0GQLRvAhqD+DxnFup3NC+6vCF2RJVLix/0y43JUXvXx6?=
 =?us-ascii?Q?HZozC6LrHilivTNOM1DVIbPlfrspDKSbeuK6qXD0BNiY++DHxJlNcOAxNx4K?=
 =?us-ascii?Q?qe6jShLlnOwUeyjoNe1verV0r70jFVGqjCfsB0L7/7ijxNDHWwas3NOL5q3G?=
 =?us-ascii?Q?2VeAgyzXedrGVleixa4nTqt4k7VlbDN/IZgtOnx6vQC17DdEuJFB4WujvOKX?=
 =?us-ascii?Q?qYOjwWl9PrO1eZSyd9p4U2rdVVtlZ0TAn+0huuXB8bhMyswGMWUheamKuwmf?=
 =?us-ascii?Q?7ts4VuEifh3gZ45iv9KCWoECyD286NjM7FEeIu9RxYoGH8X73yGOQOuGKvhV?=
 =?us-ascii?Q?566o4Ha6EsV74dhNHO+3X1P1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c8d0ac-d836-4d9f-e7ed-08d9671f66e5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 16:51:21.9438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmXNOYhaGfsL++InOTOMheeuOUyXrK/OqwCczkxIFPjrmj1g7wX8T9uj5RU0kLjqPhjj4+XxZnTYsN6T+ZDKxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need a default case to handle the additional enum values.  While
here drop the need for a local variable.

Fixes: 808a662bb3a8 ("drm/amd/display: Add DP 2.0 SST DC Support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index fc122c8c2318..0126e71841fa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -257,20 +257,15 @@ static void dpcd_set_training_pattern(
 static enum dc_dp_training_pattern decide_cr_training_pattern(
 		const struct dc_link_settings *link_settings)
 {
-	enum dc_dp_training_pattern pattern = DP_TRAINING_PATTERN_SEQUENCE_1;
-
 	switch (dp_get_link_encoding_format(link_settings)) {
 	case DP_8b_10b_ENCODING:
-		pattern = DP_TRAINING_PATTERN_SEQUENCE_1;
-		break;
+	default:
+		return DP_TRAINING_PATTERN_SEQUENCE_1;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	case DP_128b_132b_ENCODING:
-		pattern = DP_128b_132b_TPS1;
-		break;
+		return DP_128b_132b_TPS1;
 #endif
 	}
-
-	return pattern;
 }
 
 static enum dc_dp_training_pattern decide_eq_training_pattern(struct dc_link *link,
-- 
2.31.1

