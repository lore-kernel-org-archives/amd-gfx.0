Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCB7C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFE52207DA
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J9R/kFcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE52207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B60996E1A3;
	Fri,  3 Jul 2020 08:54:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 402FB6E081
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:54:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTYFs0QRX1QdjxSKxlKuMN1wc1rqOd7Dtrt2BH94iAyZ22SxtKpg9rUp/0yzOOvAZVef4n8yohXvG1m415/hKSnxvnpCNeyfn7g/T2/W4OXPsTuKEE1dzuOQA/UjPgYU6R0zbqNbekP/GeW2dfKF6/Ax6UI4KD/K0s+J8eMEqJnRX9xMvLB/oeDO+NHaXKJ1Ft69GovY1zmKVPjp2Ynk9iqrBY2EJ78a5WUGg/gT8xY6AfbezdPTi33Go1IrWgax+EkB/JDKhgFMvtOhHW6PKcRCPxlI5g8nTjxV4+NgFgp9Bj6/i7R412u16mohfUanUE+csPtcfi9iUbd5ji5mFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AlNM/TXsPQ89tcHKPX5FeqzwKAOTPGxT+mFrPxc9Pw=;
 b=fD+OdWpkTJUJfupE0RLGFhUuQ2S+diq6q8ijoyTILINqaf35SWaQJGIKe+V/2RB0GHpV+FRItvOhhsSDcmMV/1we/c2kvwthFu8R8sfcym6J9diOiFCdRRv1mS+6EVLOgajYPlHWLNF5F5HvKBVeqgDAyp07L9B866A9muLsJ7J9pZRpyKbc/bpNa99NuzNgpycrH5HDFV8sSdJf7aPUi8wi1DwvUhAUEZPp76zFmz5Y+eEZNlap8sNESTaXg3ymsO2zuzR0Hr/YEeBqqOqPMP5SEU2MdxwGFydHDH3cvP4rFmWmePw4uVp/JOS9C8GhfOpOevUdS0p9qDbXpMpyWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AlNM/TXsPQ89tcHKPX5FeqzwKAOTPGxT+mFrPxc9Pw=;
 b=J9R/kFcwp+HsRgPjEJbyNjgqzfNt7aeH1at8z8u9Pu806AVUk4XdqaTvPbR4AsEPg67mCM3pdYIbSW6/jdJnh9E2jCImWWP4s9rNYAvcbtgYTocZliiwlYbpGN89YuQIzyoV2vF4XRtit/ZlyLDuaE7MTn8oo905dNLtLYyJyBo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.28; Fri, 3 Jul 2020 08:54:12 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:54:12 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: correct the .get_workload_type() pointer
Date: Fri,  3 Jul 2020 16:53:53 +0800
Message-Id: <20200703085353.7429-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:202:2e::21) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR06CA0009.apcprd06.prod.outlook.com (2603:1096:202:2e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.22 via Frontend Transport; Fri, 3 Jul 2020 08:54:10 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 28e0588c-35fe-43e8-125b-08d81f2ea7df
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13545CAC4488E565D03EE96FE46A0@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhvR9dPXjEsELQDM7iMql+F38g1kBN+wuMD2AJCRNe8b2aB3Oq1V3gJAHL9NDq3qN9XJPoDb0bBM1WkTftDb2XAGZ7gS5caCC7JN1DNdRutXred/YQt5wHU2wi7T8bjmRwTl3LQd7JHMq4FNIn67vAwDkac4BMVr14QakoQw73E5U5oELg/+jbcZwN6kq07Me774ZuyyzG16RS2qZ6pCS8DR3YS2V2MhtJwn7Jx6eqenYyEbH+XRpLpdBg6y1PVGP62VcaQv30Znahe6OPYxEG854XxGgX2bEb580vQpP1z0juea49WV4HUllEsuzCel4tniX1bH5Q+5oWIwNbt0nwLL57XvHyb0yLE/VMomKjVAv84cAWN9PiBUM6glSfvq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(6666004)(478600001)(5660300002)(8936002)(4326008)(2616005)(956004)(316002)(7696005)(52116002)(8676002)(6916009)(66574015)(16526019)(186003)(26005)(6486002)(44832011)(66476007)(86362001)(83380400001)(2906002)(36756003)(66556008)(1076003)(66946007)(142923001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: UFOE7V9gPhXNWwPPGUHPk9hVFfmmLxOb2TlAmUqUd9jJHMi2+GM6uNqTocjwno3E0PUqHDUa97ShtYNTWB0ZAbMklqKZ5OJ6xzT5RCsPIecepH01/Fj6cIgclvq+qS/gHFJYrXqmvKt2NmfUYxUKkwSK13r3op7MSJ0r9JZE46ujPcrnrMYzqq+zQjjlvHJvkMXn7djhrEmh36nsoDs2aElcQ7ejBjcJ7bi6donxgsm0LnwSTg2L57EpJ+1wJ/SnqBRgS5SkX9iO6+QHc8ch9a0jCapg1u1eZw5KooHbk73MCJrpF8XjCv1gZZ9xj+ut+TXMz9Tvbt/lyhBfUqlgABlXG5YvqysBCtX5SMLSvXqGpJxx5RbS2aoDw5M8cuyCGIIOWNf8TPifz2x4vrIPBKLtt7aUUG4jIsWO3s4FdZZ++hux6xO1kSr5zXzZo/dTGXNqQQSDf2HSVSPF28nEfj8W8FkM0woMQzShkqSkG4us0A29LB8eSyNTuiXGJ3oE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e0588c-35fe-43e8-125b-08d81f2ea7df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:54:12.3713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmdMyQmoTKQBvmwqRVjqvNljvA7oTFZHVSNHFeQwMdXH6A/L2/kUZuSCb+swAadS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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

This seemed a typo.

Change-Id: I1e4da590829395617e90d0d43562f934a1ae0234
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 8c5cf3860e38..afb3ef874fc5 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -73,7 +73,7 @@
 #define smu_feature_get_index(smu, fea)					smu_ppt_funcs(get_smu_feature_index, -EINVAL, smu, fea)
 #define smu_table_get_index(smu, tab)					smu_ppt_funcs(get_smu_table_index, -EINVAL, smu, tab)
 #define smu_power_get_index(smu, src)					smu_ppt_funcs(get_smu_power_index, -EINVAL, smu, src)
-#define smu_workload_get_type(smu, type)				smu_ppt_funcs(get_smu_power_index, -EINVAL, smu, type)
+#define smu_workload_get_type(smu, type)				smu_ppt_funcs(get_workload_type, -EINVAL, smu, type)
 #define smu_run_btc(smu)						smu_ppt_funcs(run_btc, 0, smu)
 #define smu_get_allowed_feature_mask(smu, feature_mask, num)		smu_ppt_funcs(get_allowed_feature_mask, 0, smu, feature_mask, num)
 #define smu_store_cc6_data(smu, st, cc6_dis, pst_dis, pst_sw_dis)	smu_ppt_funcs(store_cc6_data, 0, smu, st, cc6_dis, pst_dis, pst_sw_dis)
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
