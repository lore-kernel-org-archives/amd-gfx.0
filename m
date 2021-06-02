Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8300EC47096
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57CEC61C46
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CEC61C46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 261276ED83;
	Wed,  2 Jun 2021 16:49:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B636ED83
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGMbPkaaKNcFjbf/aZeYzDhlQ0f/Fd/XM0jz9/K1nMCFdS5D5JbMP/wzLET6KsdbY8UJ/jc39YFISL+0/YaUWpHVPAH5BZPiL0neDwdbe6FuyQoLkvkUPbPRPldn/j1Woa/FvUgZbLPl1u8n9h9zgB6MrHIVbyWc66kEw+ISZjSzsMXmFOPk/7BrQ308wDmrBcWUnI8VzVaLDw9y1JetEq+4dw7KaBGxeUIKtu6FIftxEEmBXPpfPgqnZZnlwO1u5XEU8fFAIstJ1sZHmBEer+EVEUjpT88rWd2R2m4wvF0TYBwXQu5KFad+GMaedBzx3bpnS1skILsgsvi2YVkHIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWb3mctzD4GszUzrCDwR96nrdjYZdR1aDjOsNTBfiBE=;
 b=C4i/Z/jfoAO3TSYLlYpfFpImlquDzw1FWw4rgkI0sV0t6aTeJrBeE0uZD1EPCxclcXGyU0v7ns2fgglOLbChIwBcKQY1hWpCi9dx50dkFmVrIE0AOWaZ8HF3IlaHIYTrNooReNC3+LLBTspBfg7oqdyKoXcXoAX8T5BIz8mlk4BjBFm4L6wjX1x93y8MJ1IDhRHYOWRuCrcUL/FsR9dZgWT8Env6643d2YhsnDzDkv9AyWVB23e+qhTjFkNpNQbhyFAeg5iMiblSWcKO8QUtgFuW1qwweWHm1Z3w5aERzgzsKPya2jdxSbKPGe/zgM0dDr5DxR3b2R7Ef2OGdiYyKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWb3mctzD4GszUzrCDwR96nrdjYZdR1aDjOsNTBfiBE=;
 b=NVOYmpiTyWBC0qUHUujejADkrKPErHgpakG5+VRZkAcdeqGn/vQSTCScYf29HQqWioP+gJfsyMXZ2sxnXEA6yEfKs1LOq8uPKOSmDlWnzH1tCfeflmr2Wj0y8AgC6qDaBHRGMqqxOsstJjJhoMlr8e1H2nZqshrucciSsCa4BC8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:49:49 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:49 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 29/89] drm/amdgpu/pm: add set_driver_table_location
 implementation for yellow carp
Date: Wed,  2 Jun 2021 12:48:08 -0400
Message-Id: <20210602164908.2848791-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 210a1244-fe6d-4f14-a5fd-08d925e66f1b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4063826C2724D4A895AEE493F73D9@MN2PR12MB4063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WE/CHEtm5XUn3bT9e5SOWVnhhJAehB47icNoq4QPsmr+kEnzxMEBuYZR/6TNjjiaWZDG/s4jdzZLWiwDv255AqqvKTLjMLjqKvuYUpO4YMlc/Z9WEmx/rChep9eOmLOEpnWTuR80BWtVXbq/9WMQIGApnGQoBVsJDgqAD1lgT2o/vgpKoZtiuPgUyPDZHbSELvqRMHaWVjLmJqs0JAEtgfr5cN3C7YvYvE4rkCWaR5BVtoj/VgVAMzAhDwMlU8EjQs+jKlSmxdJGf21sb/gpM0YB+ENb1mdYOimsDYeqEIIFAKr5REqWRIhYRtNB9RDVV0CiOoPHTDmc+eJDjO1NFePqnmO/vLzNrcdKfntymBdzsd71YdtPUDs2TaaHYykjWlayrf0/KNaYhZyj5iJwgxiQBQuVx4Z7AUE/YehKkd0gvBQ3QAP++DP51fq8YhFa1xKB/fjZDNlvaypFsBVZug8AHt0JgEqINHPHWoBO7NVQt+nt0u8jF/bLNW0PDTmkyHURqtqhVTvmJY5C2C3nem2L5IhRz08A1amOFiq98an59lq6Nu6L9mvbD5ta0xk//DZZ9lVdBBshJJ5LsmjBJSRcAaByXqh/FS7MSML1u9ry1ax/txF4m0K0w7dHVf+4dJmlX2AqtsPpmYC13DwXdSTE2kHjSnQgnEASrdBl9Sd27IRdxQu14QTTvHLYsT2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39850400004)(54906003)(16526019)(186003)(316002)(4326008)(52116002)(38350700002)(66476007)(86362001)(478600001)(38100700002)(2616005)(956004)(36756003)(6506007)(6916009)(2906002)(8936002)(6486002)(6512007)(1076003)(66556008)(6666004)(5660300002)(8676002)(83380400001)(66946007)(26005)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Nouh+ClcTonNmhGEb8hSfS3JVFGHenVQVPHQ4KIjZls0AsbJBAbLB3epPIqo?=
 =?us-ascii?Q?zpnn5FX25/3SXJU2V2gbauAO1XNhZ84qBL9gDEVhCoc7Xi6nP5guaOqh4K9n?=
 =?us-ascii?Q?4Udouw6IXvsq/gT0AolXAadO9toHIpnCqgOUy5hls9YQsjmB0dOjufaWyLIh?=
 =?us-ascii?Q?O64rbk6zm45RiDR8eKDyjs9vJRjXDis/kk95nHq/zhH3M5V4NJM1QzhCQEs1?=
 =?us-ascii?Q?ueikPzgd86WvswedfQurLOC/z4dXLJgyaANb+GtJdCj9zyq+Chxbe4uIoj/d?=
 =?us-ascii?Q?NEgq52NnKnwHwTaUwbTsrII3Ql6bxv4ux/SjMi4itflGxD9NZKaWeZWVo92n?=
 =?us-ascii?Q?dyoQUuRb8nQBED4dcaTJeQfTNL5XszyjDcOT+mJ6yNvnqNeigjvd23p4wh5y?=
 =?us-ascii?Q?DiQ3627mtG15bjKQ+F1z3aFqoZYDOeZKioPObSGpTLpA++qk4rdn5lNMAzsy?=
 =?us-ascii?Q?1PB2rUG1iflghDxB7VdfR0JAOV8rDzX7y9IZHkldjSousjWd80Dkz1qPlkJR?=
 =?us-ascii?Q?HUJGm8dZpEoxLEkiEl6dJGtwFamsuYUeg/Li+5Usv5MNIhOhXg7/sqoXuMsD?=
 =?us-ascii?Q?fGqBG0Pxoa62u/uOoX01OXhKcYx1cscK1glOLCflW5rZom1c99m62J3Nx8PU?=
 =?us-ascii?Q?8JkDr+0XYRgZAvYmO/sODcRf7C+DF3w5xmuQ/sBJLe8B+5B/1T7NeRgn8450?=
 =?us-ascii?Q?4SL7tkHajeOzKfQphmUaH7trCLE2da4JXX6fJAAipP46B+8oSZbDDMsxsqH7?=
 =?us-ascii?Q?eblAJlM6m8qmeNzGN4NqQh+EwpTgo+x3oviO8aAP+6nLgs69l2BmxTALGE4j?=
 =?us-ascii?Q?IZtimdGfTocqBjR2bcGzKJtY6PWn2r3S+IjEWLuTVT3mi+AJ4ko8/fZikjtB?=
 =?us-ascii?Q?xuXjZLyxdYUSxB9f9iC51KbHbUaox686trp+E7NINBWDZOny4uTXkb6GsId4?=
 =?us-ascii?Q?fq7UahYBdfHSD5cHp0EhcFWG8c+aKZgz25W4GURcMkqWDZB9cUwuvKSu508j?=
 =?us-ascii?Q?jqRverzhauVp+IcuqB6D2QZvJmElCJU2wDamup+LIVWtTIdNDjbXQP0yiL5S?=
 =?us-ascii?Q?YDZPHH4tH44kkUn5uGCfmcitLjWpSEe95vuetZigXUhCTpGRfJuQ2DxgEede?=
 =?us-ascii?Q?yqGWMzqehHhChGJHtMYzmF3jmvG1qwwzv2s7JGqkvpEl54INayAFHoyaWDJS?=
 =?us-ascii?Q?lvoi2VJoWPmd/+Kni9wWoEPgjHWWaX8H3BETQjmLg8Em1ptES/zNTL/3ukFg?=
 =?us-ascii?Q?LLo5npvHiyluihmSh26woYaYfkGXUXRKFppVLj/M0AoYuCkOacPkwyqPs6b3?=
 =?us-ascii?Q?Gy4t1u1y2I3X6z3ZKeAfgo57?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210a1244-fe6d-4f14-a5fd-08d925e66f1b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:48.8724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTuwIgexaTi5FXQ9/qJv+RqCZeGdkHs+CzR3QNnCaFicTCPliFtUQfqgILAGHp4AFPYQtLlXcxus7oWobYqJXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

This patch adds set_driver_table_location implementation for yellow
carp.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h      |  1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c  | 23 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  1 +
 3 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
index b2e9258dc06c..9339c39c78fe 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
@@ -48,5 +48,6 @@ int smu_v13_0_1_fini_smc_tables(struct smu_context *smu);
 
 int smu_v13_0_1_set_default_dpm_tables(struct smu_context *smu);
 
+int smu_v13_0_1_set_driver_table_location(struct smu_context *smu);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c
index 6ad2fcb2af2f..4e41c026a2e6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c
@@ -129,3 +129,26 @@ int smu_v13_0_1_set_default_dpm_tables(struct smu_context *smu)
 	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0, smu_table->clocks_table, false);
 }
 
+int smu_v13_0_1_set_driver_table_location(struct smu_context *smu)
+{
+	struct smu_table *driver_table = &smu->smu_table.driver_table;
+	int ret = 0;
+
+	if (!driver_table->mc_address)
+		return 0;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_SetDriverDramAddrHigh,
+			upper_32_bits(driver_table->mc_address),
+			NULL);
+
+	if (ret)
+		return ret;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+			SMU_MSG_SetDriverDramAddrLow,
+			lower_32_bits(driver_table->mc_address),
+			NULL);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index d849fa83f01f..cfe086658ce5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -151,6 +151,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.is_dpm_running = yellow_carp_is_dpm_running,
 	.get_enabled_mask = smu_cmn_get_enabled_32_bits_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
+	.set_driver_table_location = smu_v13_0_1_set_driver_table_location,
 };
 
 void yellow_carp_set_ppt_funcs(struct smu_context *smu)
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
