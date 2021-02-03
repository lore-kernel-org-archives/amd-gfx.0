Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFA0C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 09:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4581664F61
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 09:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4581664F61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFD8F6EA2F;
	Wed,  3 Feb 2021 09:30:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D415E6EA2F
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 09:30:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtHYoEuws1mB76dll/dVvnH3aDj/CUBAqaXyCoMk3ag/SFUG6/0kYZ2vZM+q4eadXjuu4iw2D4BO9ctyKYvhPDVC+djeRV8DAYPyyc1+ZiiBjJ2YCMPzxqk/jw5vWr8DTGdGEQzrVi9K3sLLSGdng7WVYPyc4FS597iPhmt/AOUcKGi5VYPNQIf++9KvIvMeCbbiVRms6Mg61BXsrp3Xt0mJ/ujkXaJwVTrpDFriNZYWjYc4LpovXXbsCfv/e29Bvnm9A9zNYMeNG6omZtfF+/lUtAoYZw7tiDdT97+rxjX1NPt0ZeBYzBejcMOGltreHsS5JxDWMJ6av+oZNSXlRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPriZ6/lfMP0j02cAnu2imx4KrrDPzEe0OhwVqa41To=;
 b=F+OxV6ktxVyUnzOVupnL9wrTVivkbUA9FznOas5AhcyGjpgfR+n9V0E6JKn+qL0YA8C58ZADp52tv0qp7X6+0/vKO3S5tvakl4Vmexn7tnJh/mYuFVfFTh5AGq6fAs1ie+lVSjdkmXHJmRPfnYhHf+uPGDazq8sRlks+9T0ACMXPRoVxjxM8TzRZcaSCJA4uAYOZ6scI2bky1zOLUXZ6Xs/W+diC+YkGmGVuN9JGsjzIoxUTfZBDZPB6PD9e/FqQR1fMdkOdSHwjjpXQQfI64QZBjl1ag2bSJt3A4avmE5o4BEjymMUcOAzglivG7PzMhTvHt8b0xiJxV00H0mvX5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPriZ6/lfMP0j02cAnu2imx4KrrDPzEe0OhwVqa41To=;
 b=NOcbcyA11rynhjsv2St3i5sCSXousBf6cnI9PQ5uhLc8PqT8q/x7rHDkCPDbox5sMOMVC799UEiNiZ0p9laq5SAqpUHTTpmYywr8EN0f+BuFwsbVYjsVls3/CdgsMMSdRNTXbXO1Lmo8ExFtvKXBXbQ9NyNCVwkPWtW22+5i06E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3213.namprd12.prod.outlook.com (2603:10b6:208:af::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Wed, 3 Feb
 2021 09:30:13 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554%6]) with mapi id 15.20.3805.028; Wed, 3 Feb 2021
 09:30:13 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm/swsmu: unify the init soft gpu metrics function
Date: Wed,  3 Feb 2021 17:29:47 +0800
Message-Id: <20210203092947.14023-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR04CA0062.apcprd04.prod.outlook.com
 (2603:1096:202:14::30) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MZ01-CE0.amd.com (58.247.170.245) by
 HK2PR04CA0062.apcprd04.prod.outlook.com (2603:1096:202:14::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.19 via Frontend Transport; Wed, 3 Feb 2021 09:30:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: de0d3a04-c540-4889-13d0-08d8c8264e81
X-MS-TrafficTypeDiagnostic: MN2PR12MB3213:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3213D63E295F78E87DBA691EA2B49@MN2PR12MB3213.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:144;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q9ejIuSPUx//4RWeGCli/hlp23d6spteu5S1GHySuXa2GMjpCnmSMmpwJr44jkxKBqyJ+IjsFDzz0Ww9SEQYOxwotMmpWEivGuNHI2q3fx1eLGal3rlMT6OveWvNqZiODCkheE2V09YzsP0+rU41Mhn7jzVmgDjjJD87aQDx9pJqZ3GHbezUzEKU/+98XXrn+3+uXV4THzUXvyq9EGOnDjnBubtdSbZXFoYWEXgchJ/2jXlcXZWfT5iOjCyax7whWQVrGZxHUxDrcIIfDjEg58FM0drsBYB9E9DbjJC88bMvdayMLESfQA5OysZR/MQv7LQ2fz4o9fU3aXS87hqgOhnWnj3zD0cl/BWOCdGcDtN7tnzzt3BSyW+HSxHNXDMA0rdzSsv7sAghGL3NvzxMz1CSZV+pDxWAq5H4cMhWGoyBbIi4OFLmqGwWBPD2phdGcAVmW1bUtIav3gUKG1B5F+1iVHA2J4muSCZ37/gwFQHIx6ZczbBIcRq1u2U32v0sS7uOy8pNRTcIMfKtCuED/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(5660300002)(6916009)(7696005)(1076003)(52116002)(6666004)(86362001)(66476007)(66556008)(66946007)(16526019)(316002)(2906002)(956004)(2616005)(6486002)(186003)(26005)(36756003)(478600001)(4326008)(8676002)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qLCCNxcDWdBJoON3bvtZ5EmL8UZumNoHtLZL6wxb7oejgcVHFtu9rm8rBZIq?=
 =?us-ascii?Q?yQFNTmX7xCeotekNgxtzaiILPk33vle5zpak0HrwCemJeJCD6GwAZQjI+KmV?=
 =?us-ascii?Q?WOuHgJmL9yqKoUzNELcc6f77Y3lvW4W4q9KLNjuxtuxxfy8kQqG2Odx04wcv?=
 =?us-ascii?Q?Xkqt2uZz1qlZMdO71VUluSCUSucyblWOMlnKmogEGXS5ihUz+i1Vf/hqkC1a?=
 =?us-ascii?Q?U3HntTuXEqDMBLHF2tP+1g6dOgTzmAg8of4A2TZlgdYk3bNp1Yn8GLsGuTm+?=
 =?us-ascii?Q?FAeDnwLvEYJfC5ipLhWMbOeMkP2m06c/A3JHXPmniedkClknKksTyTgLmfVb?=
 =?us-ascii?Q?qX+Gh4PeKjYxj4tvvseP7PY+YpybyF2AHJy9X5IKjpFaFNOwJpYQp8fWl+mC?=
 =?us-ascii?Q?NKJ68toGRvTInBam2Yl+1bYSV4vH+eP9wekITonXfo4PIR2teDIsqfE/pUTd?=
 =?us-ascii?Q?2zdjnsL+Yez10TXWZgvkpt4byedsYB4UhPdR0+ERPvxmXNrkRaR+NET0SvXW?=
 =?us-ascii?Q?O4JnCsPbYTRUq/jS18mfkq/vdqKNPqiJ/iMpTbOeyvuOy2CK6Vf3e72QBneO?=
 =?us-ascii?Q?4yh0SAHYzuwTQDlPLJGHDUGbKFW+vvnynyFnLXxLteCFoRZNj+CDfoMQcpYw?=
 =?us-ascii?Q?BEFI1kE8jVuIyY7ERjUnlG6BW8OjR86hgseVHJIwzdVibnb4oPhD/5YuRviy?=
 =?us-ascii?Q?bm2Z64Et8+bGzhtlTHo/Cg3Fp1PpRBm1p0HiSYS6UGZ0Mzj+2OURigvS4r2N?=
 =?us-ascii?Q?YrEj/7bXOMPgyrZpL99EuHlr71b3f01r0oS/tSwa1S2uKq6i33FJgfaL3NyR?=
 =?us-ascii?Q?lx7ws/x0+V7Tka17aHYK6YYy0GBFa7z6/fPJ5JvZPLRWotNbrdzh41sr8EFV?=
 =?us-ascii?Q?64BLONzgH0dyVK/QLbJc6w4wWcwFG/A2Y5FzSuhrB0MeZhim/eZYr+MgGXCY?=
 =?us-ascii?Q?XJgOChPKyjUikKpnE04fKNYmE9qY8P2RyO1YUVyXATOhZS0CDgEODux4EMDJ?=
 =?us-ascii?Q?Pu/r4PVddLyehyin8eipyO3V07435ztwG0H15S1L+t1EoKE1wYrRvM/pPSrK?=
 =?us-ascii?Q?8jf+ohLQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0d3a04-c540-4889-13d0-08d8c8264e81
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 09:30:12.9436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ua559OdvBbnC4KtGPWA/lAxULE1WknJ3J0I35mZ7BLNzu+UQ7LkvHmmCIwfEG3zq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3213
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
Cc: Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the soft gpu metrics is not asic related data structure.
unify them to reduce duplicate code.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  4 ---
 drivers/gpu/drm/amd/pm/inc/smu_v12_0.h        |  2 --
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  4 ++-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  4 ++-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  4 ++-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 24 ------------------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  4 ++-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  4 ++-
 .../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    | 12 ---------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 25 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 ++
 11 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index c7d57e9555cc..e49c2d08a983 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -272,10 +272,6 @@ int smu_v11_0_get_current_pcie_link_speed_level(struct smu_context *smu);
 
 int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);
 
-void smu_v11_0_init_gpu_metrics_v1_0(struct gpu_metrics_v1_0 *gpu_metrics);
-
-void smu_v11_0_init_gpu_metrics_v2_0(struct gpu_metrics_v2_0 *gpu_metrics);
-
 int smu_v11_0_gfx_ulv_control(struct smu_context *smu,
 			      bool enablement);
 
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v12_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v12_0.h
index fa2e8cb07967..02de3b6199e5 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v12_0.h
@@ -60,7 +60,5 @@ int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 
 int smu_v12_0_set_driver_table_location(struct smu_context *smu);
 
-void smu_v12_0_init_gpu_metrics_v2_0(struct gpu_metrics_v2_0 *gpu_metrics);
-
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index f0cc4de9ced5..45564a776e9b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2239,7 +2239,7 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_v11_0_init_gpu_metrics_v1_0(gpu_metrics);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2276,6 +2276,8 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->pcie_link_speed =
 			arcturus_get_current_pcie_link_speed(smu);
 
+	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
+
 	*table = (void *)gpu_metrics;
 
 	return sizeof(struct gpu_metrics_v1_0);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f7f78daffd27..6e641f1513d8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2314,7 +2314,7 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_v11_0_init_gpu_metrics_v1_0(gpu_metrics);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2354,6 +2354,8 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->pcie_link_speed =
 			smu_v11_0_get_current_pcie_link_speed(smu);
 
+	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
+
 	*table = (void *)gpu_metrics;
 
 	return sizeof(struct gpu_metrics_v1_0);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index e3ba40d9f83f..34add528d83c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2950,7 +2950,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_v11_0_init_gpu_metrics_v1_0(gpu_metrics);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
 
 	gpu_metrics->temperature_edge = metrics->TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics->TemperatureHotspot;
@@ -2993,6 +2993,8 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->pcie_link_speed =
 			smu_v11_0_get_current_pcie_link_speed(smu);
 
+	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
+
 	*table = (void *)gpu_metrics;
 
 	return sizeof(struct gpu_metrics_v1_0);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index cf6176afd4d5..36d651342a76 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2021,30 +2021,6 @@ int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu)
 	return link_speed[speed_level];
 }
 
-void smu_v11_0_init_gpu_metrics_v1_0(struct gpu_metrics_v1_0 *gpu_metrics)
-{
-	memset(gpu_metrics, 0xFF, sizeof(struct gpu_metrics_v1_0));
-
-	gpu_metrics->common_header.structure_size =
-				sizeof(struct gpu_metrics_v1_0);
-	gpu_metrics->common_header.format_revision = 1;
-	gpu_metrics->common_header.content_revision = 0;
-
-	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
-}
-
-void smu_v11_0_init_gpu_metrics_v2_0(struct gpu_metrics_v2_0 *gpu_metrics)
-{
-	memset(gpu_metrics, 0xFF, sizeof(struct gpu_metrics_v2_0));
-
-	gpu_metrics->common_header.structure_size =
-				sizeof(struct gpu_metrics_v2_0);
-	gpu_metrics->common_header.format_revision = 2;
-	gpu_metrics->common_header.content_revision = 0;
-
-	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
-}
-
 int smu_v11_0_gfx_ulv_control(struct smu_context *smu,
 			      bool enablement)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index f0f06ef47b9e..42271e80c0b4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1406,7 +1406,7 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_v11_0_init_gpu_metrics_v2_0(gpu_metrics);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 0);
 
 	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
 	gpu_metrics->temperature_soc = metrics.SocTemperature;
@@ -1442,6 +1442,8 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
 
+	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
+
 	*table = (void *)gpu_metrics;
 
 	return sizeof(struct gpu_metrics_v2_0);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index ab15570305f7..f2d57900e93e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1257,7 +1257,7 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_v12_0_init_gpu_metrics_v2_0(gpu_metrics);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 0);
 
 	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
 	gpu_metrics->temperature_soc = metrics.SocTemperature;
@@ -1298,6 +1298,8 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->fan_pwm = metrics.FanPwm;
 
+	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
+
 	*table = (void *)gpu_metrics;
 
 	return sizeof(struct gpu_metrics_v2_0);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index 06abf2a7ce9e..6cc4855c8a37 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -278,15 +278,3 @@ int smu_v12_0_set_driver_table_location(struct smu_context *smu)
 
 	return ret;
 }
-
-void smu_v12_0_init_gpu_metrics_v2_0(struct gpu_metrics_v2_0 *gpu_metrics)
-{
-	memset(gpu_metrics, 0xFF, sizeof(struct gpu_metrics_v2_0));
-
-	gpu_metrics->common_header.structure_size =
-				sizeof(struct gpu_metrics_v2_0);
-	gpu_metrics->common_header.format_revision = 2;
-	gpu_metrics->common_header.content_revision = 0;
-
-	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
-}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index d9ecaa04d14e..38bcbe46e809 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -746,3 +746,28 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,
 
 	return ret;
 }
+
+void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
+{
+	struct metrics_table_header *header = (struct metrics_table_header *)table;
+
+	header->format_revision = frev;
+	header->content_revision = crev;
+
+#define METRICS_VERSION(a, b)	((a << 16) | b )
+
+	switch (METRICS_VERSION(frev, crev)) {
+	case METRICS_VERSION(1, 0):
+		header->structure_size = sizeof(struct gpu_metrics_v1_0);
+		break;
+	case METRICS_VERSION(2, 0):
+		header->structure_size = sizeof(struct gpu_metrics_v2_0);
+		break;
+	default:
+		break;
+	}
+
+#undef METRICS_VERSION
+
+	memset(header, 0xFF, header->structure_size);
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 08ccf2d3257c..c69250185575 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -97,5 +97,7 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,
 			      void *metrics_table,
 			      bool bypass_cache);
 
+void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev);
+
 #endif
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
