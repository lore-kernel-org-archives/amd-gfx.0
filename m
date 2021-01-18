Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21039C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 01:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C134A222B3
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 01:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C134A222B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61F608981B;
	Mon, 18 Jan 2021 01:55:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D578981B
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 01:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuY/pUZr1L+ObMG6KX92yFKVWT4dCjfq6iPlLFyIPhELjVX+NeoOERkRtuL+0448Jnr8hIYjK7XAM8P1adGSIQuVFk5/23+BO3JuhKXK+ES+O9n/Gs5YGGW8KKly027vEwIETZgHvzdAPY5zAugkYaeWrL2jwbBZ6ly8r3MDnny0DS3UA/G7BKO4RwXVaPXVRA9wfrtX4wZ+Ic2Cp3roH9mxXQ0E+XH4+yqBLWfEsAH8Fz8sm4YoNYjqpgK0U0X0imoOe4Z6HvoGhFgJqm/7VktxvCVXj4Htzv8Zkw5RBCwCrgd1ykfgnq95n55p3/lzbBiGTaSqeIqVRjOI0PY4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QhQ6YsrlOAmSyU9XAIzwDx6fD5eE5cw8KNw2ngG9DI=;
 b=nONRj0okDbJwPKEO/H34nvY7cxG1DUnNVuvDKO+puvWOjFhkOmpRUU00vMoysvD//8v17QEFv8r1s9Ix9wtOo6pRZqcZ1eBH8WQhA6B6QOqSmdhAsTL2c3IxE0j+6cGR39qhk4c7ZYF/8gRHhLfcgGx0YwnARgULOJrTKZFaqv5CAtqEk9f5WN11baTJw8B2i9gQywyC4O4wGErlyjJGGqFf+O1qwGNqrHcfJUbSudEwOW7cjTDfeniEldsFh6DImVnOV8NNfHyzY03heNXbmgRkY76unhR7BQR8cEiyZLs82DAUDiLlsm6uZ1WEz8ZtSi7eBXyYVw9zmzunUWwQFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QhQ6YsrlOAmSyU9XAIzwDx6fD5eE5cw8KNw2ngG9DI=;
 b=y/vJngLK8zx17hLsBibLtL+8PuNL0PR9nw5hS3lkpAYyOnbdNoWNl4xIjzrDTR9Pp4FrP+ygqtsPayR1yOIvoZnoOE4DRENEGuRBYmA219XcnQ56yoeztDnwK4kPcttMcexeyAyo2dDa7JLKMcXZvkOifveuIkftP/YypDL898c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9; Mon, 18 Jan 2021 01:55:13 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 01:55:13 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state
 retrieving(V2)
Date: Mon, 18 Jan 2021 09:54:51 +0800
Message-Id: <20210118015452.418724-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0062.apcprd04.prod.outlook.com
 (2603:1096:202:14::30) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR04CA0062.apcprd04.prod.outlook.com (2603:1096:202:14::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Mon, 18 Jan 2021 01:55:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 43e997e3-1d0c-4dbd-0014-08d8bb541806
X-MS-TrafficTypeDiagnostic: DM6PR12MB4058:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB40589E470D65A9DB376963B0E4A40@DM6PR12MB4058.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7QT9qRWflrK5u63LPe2J5yMSKk8SG8uRdzuP3LTuGGFhBoLuzLeN1m2pGWqZ4FmfRBborCdjcMi9JSTOVKF9WEBXC/q9NYc7lEof2e/REtFhV+abn20piF4qIaoaC1kkumodGKpCATTC2Z/opgwQ0bLIjbidNoq4dl0eML4PYqyrUGpeDxmrelYrnBbOhZ8iF29iaxQqsP4NsJ5KFKX93rmpH04qkhErVKDCj6pr3ee93YPrPvqTHyRsG6vkyLhajvnD+J/ImkjKSaXCUchyrl9bYulq1MR3bkUiPkDgwLBE7zfeldfpEgFpzEd36Q4+ffPxWqpFU6AFN/8jztm8kLWtsKTZjS3FEPh8V6ce5r7T8XYHayqRrJQkqdVV4pxW2vm3BMvISfltCd6Lr733iv89iEqBbC1FTcCFJu4PL4zRxnccTZOK1P0u2b6vkgFt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(8676002)(2616005)(7696005)(6666004)(52116002)(956004)(316002)(86362001)(66556008)(66476007)(44832011)(36756003)(4326008)(478600001)(2906002)(66946007)(8936002)(5660300002)(6486002)(186003)(26005)(6916009)(16526019)(1076003)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oewX7q9sSYjrrSTc4Zq0bcSP1Z2/bJEOwGxky3PvaNbfF2B9EDD3dy0jyalO?=
 =?us-ascii?Q?fF35W4FQU58BrHNYOZK1HNUvznF1IHVotrqMDwQbRaJ1t02PqBsRjQMWs9pn?=
 =?us-ascii?Q?yqBCuhIMXoE6x8J/DXn774ERK15X/y7BNnbCr/tMMd8U4rzMhRVrNsNmlfqz?=
 =?us-ascii?Q?8wCgOFXt15qPDAjnT6CNQRa8Vd2y2i4XAHXHSJunwSueQ9KvSXnfoKXsAkPL?=
 =?us-ascii?Q?hkrnhUpK9jRjZfIfvh4lPUHY2wWuaPSWZxr2mhj6UOO0TMmzZX5GTBK1ZM9M?=
 =?us-ascii?Q?awgYZRJESgDnEURrU8w1gapSR5D6WMeDYBQasKMf/KGhn/8tyzNZMfdnm0Fl?=
 =?us-ascii?Q?hyNxQjWzLx6Mf6x6W584lM5UdCA3Bvi899WNqQHfSb6PLdL4j/tbkble7iYA?=
 =?us-ascii?Q?5y0HrrhijT/X/CA9BQY6mMtUl6AHidmpyYvXZ65B7M3oDnrqeyATjuNAsfct?=
 =?us-ascii?Q?lRyTIHYK3OUzobCPTmy25oQLAL/kCMmPQ9oMhI2qjfcSmVxYDxQ8DtSuUClR?=
 =?us-ascii?Q?J+bhWKqbFlOqxg9qUViX2/uDUPh4FtzxGVsGkE51mYKy3891Ko+NHC2mFvDy?=
 =?us-ascii?Q?/Q+vYLmBFCiReweALdsOuLbvWjG4D/mk8WDjMXTWNNQRgNUUlQmwYHJKFj+E?=
 =?us-ascii?Q?cgwqr2G6FLaud3y0OSYLglU/fw/Zar+Eu2tbHn4/QvBkDdSuraHMnxS1hRqz?=
 =?us-ascii?Q?wJT/WnKjfRoqsEezo4ZloZHcPrFHjn/Di4QV1P3JFgsPAp62hwtGG//hdWEQ?=
 =?us-ascii?Q?bB5VniWNlh18xD8szf1Q2Fhkmz2tnYAwRBXVaeLYXTzn8zTFGxA2fnZ5VBbB?=
 =?us-ascii?Q?qnBZxYxZzH9X4X2J15NyQoBCPBuBrEfaUabcznENI6/+KwWHU1akn55Kepyo?=
 =?us-ascii?Q?pUbeoOQVd51o/c/PzmD7Ed7P7mHbkLQNIvAdeH+SmjVVTn7Od+dG3e5dH0Vl?=
 =?us-ascii?Q?EiTRDWTr71dNsizNwfeh1ron7gcW6Tf3UszDRA1aDFLr/bkhk/jPnqHyrLk/?=
 =?us-ascii?Q?3z7F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e997e3-1d0c-4dbd-0014-08d8bb541806
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 01:55:13.0506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egRkeMc0QPutPhcqUq1MiWBCPIwkaEpqoTVsDZoqFgyMmZp4uQZGqHpVwTJF7jK2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Guchun.Chen@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Support Navi1x gfxoff state retrieving.

V2: some cosmetic fixes

Change-Id: I57aa506b82dc122bbead708c580a4720e536cfce
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 22 +++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 102a0cf12d7a..4d346f289ed8 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -287,5 +287,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 
 void smu_v11_0_interrupt_work(struct smu_context *smu);
 
+uint32_t smu_v11_0_get_gfxoff_status(struct smu_context *smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 7ebf9588983f..93a3b6b60c8f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2482,6 +2482,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_fan_parameters = navi10_get_fan_parameters,
 	.post_init = navi10_post_smu_init,
 	.interrupt_work = smu_v11_0_interrupt_work,
+	.get_gfx_off_status = smu_v11_0_get_gfxoff_status,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 147efe12973c..730a4880af08 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2127,3 +2127,25 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 
 	return ret;
 }
+
+/**
+ * smu_v11_0_get_gfxoff_status - get gfxoff status
+ *
+ * @smu: smu_context pointer
+ *
+ * This function will be used to get gfxoff status
+ *
+ * Returns 0=GFXOFF(default).
+ * Returns 1=Transition out of GFX State.
+ * Returns 2=Not in GFXOFF.
+ * Returns 3=Transition into GFXOFF.
+ */
+uint32_t smu_v11_0_get_gfxoff_status(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t reg;
+
+	reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_EXT_SCRATCH0);
+
+	return reg & 0x3;
+}
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
