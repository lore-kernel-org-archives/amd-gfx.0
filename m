Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D6FC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 05:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC2860234
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 05:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC2860234
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABB246E4E8;
	Mon,  1 Mar 2021 05:50:46 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750084.outbound.protection.outlook.com [40.107.75.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C73436E4E8
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 05:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jn33ZZ5u/goZoblnCO6Iqyk/EwTQ+bJEPQkSaFMbJj97U6cB83iMiK+rmIfZnVV5oY9PdjWnrjjPO9OkD9+ugIrHksChl5tEFgCRR+nbumB5TtoINLmiMC6gFCBPtakZbKDYXwloEc2uqiq5WG+UsPjdZzFjYRgAW90ZXIhn6IoQkU5fNWLpP34Er4uTvCI711JKbgwRZumA/2zRs9EJzKK1oGPX6YG3y9R+JBipvuWvjjCRtBKBnzkjOoE8P4fg+GAO3htfiP9wKctiLtvw4TciyerHEf3rIaClFjpW+HprpRaTsVcybVB+VKjKc8rTklOSmSRGBYDMRM6pjoN+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wb9eNq3oIRrJhmPrGy0Tojq2ZjHp4hx1RPYceMyTaZY=;
 b=l0/MnkjJLjE2z+DTb1JRGSW2n+nMD8tT7XVKfI2AMleXTMrsp3XfXoO+UKybZ77+euXE1/8tBnXmsimURqB4PKB1acecJGmgGMZGfB5+aglK3pFXDXNSNAfO95TbNZx4fH608JP/PZWaCBgiuV/E41V94DVVZ+YSgRaPk3siENALmeI9rPW32fA/TFOtWrTo9N90AiaZR7XgPnPBRekoD8VShyTnCZeTv2lXyIAvy+QlBG0Gp2mcvIOk/+pupcmGDS183O40DWM3yXvvULz4Y6dBggrXgeeurAAfddhxJPBwl8gLsZ11iv7Kqg5JsZ5TAV/RHVjBvl2ZoOMvG22J3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wb9eNq3oIRrJhmPrGy0Tojq2ZjHp4hx1RPYceMyTaZY=;
 b=KnAcR41VglwZbCVT3hy7PkJn6wfUyDcYe/witMhgbyi+Ux9ZNXcMcYc4p6g2Sal3sk1ZqKuYtEVRUVOq9tB3+WXhKseyYroHSpZlmUmAxLNhWkxSkaWOBLGFFdoQvQfZ090pLKS24AMFsUPkWwdZLJbPNix/YzmppfE0vqmpdSc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1161.namprd12.prod.outlook.com (2603:10b6:3:73::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Mon, 1 Mar 2021 05:50:43 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3868.032; Mon, 1 Mar 2021
 05:50:43 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: update existing gpu_metrics interfaces to fit
 upgraded structures
Date: Mon,  1 Mar 2021 13:50:07 +0800
Message-Id: <20210301055007.69191-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210301055007.69191-1-evan.quan@amd.com>
References: <20210301055007.69191-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:203:b0::18) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR03CA0102.apcprd03.prod.outlook.com (2603:1096:203:b0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 05:50:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 06ac691d-b4c3-4172-7df1-08d8dc75f38c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1161:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1161F9F559D58FEC6DCC03A5E49A9@DM5PR12MB1161.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/B39UjVnvTx3Qv+WePOKSzrcSPnGn/ztxoJMcyiZLAOPh5OdLAhaZfayE8u42AYepRASLhk8hWc3CFPoKpF2sCZcK11NnI9E18jwfP8bo9QLLbPFBUOMQsYYj+bKpwM+EIH6RSDu8TylRlS/qNsudY1fUmBwyRg1HQaQnKAi+QEhC8xKC3NKmhYIcQWBSalSOXl6sjO8pQYC6BdcMMN8rkdDSPtbtYojHIUTnuk615WGtTi+2/99Bag60aRnED3zWYNMIhFYAp5aSstBHIa8cHf8DwkWL6yM9YTQI71uzc6WgeF9rpBjNq6CDj7zAz20KaXP+IOCHklCV6wFYIs4yOZDD5IgBQiESklDFpPqbhhoNU76BR0EZecOQcsLT1qvNZ+MegfhrwJE/p4jE6LctRDUJYeGZ5UIbd4mCAX+slIL7wMIpQt+afc/W0UgUhVzLx0GUUHWliIwTGWtCYhDBvXR069mMisTzVhZs4kBuix6z2a9KrZKk+aXyvCTODuQj5znubfB61c9UVyn1m+Gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(66556008)(956004)(66946007)(478600001)(66476007)(6486002)(316002)(83380400001)(15650500001)(86362001)(36756003)(5660300002)(4326008)(6666004)(7696005)(16526019)(19627235002)(2616005)(52116002)(30864003)(6916009)(2906002)(44832011)(1076003)(186003)(8676002)(8936002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?87Cem6gd6g5BB9LsMTu/f6oJf/bjlMqz0GhMGSgD9a1cxQXgnqGLPsBLljYh?=
 =?us-ascii?Q?gkYRH40BVOyJHYMtmDd8wbi19TEgiPfmLmUvr1s8inVt251SYb1bgoijgAO9?=
 =?us-ascii?Q?15zCoI/Kl2wjhbnmXk6Je8wB9sQOvxpgWlA/jUAGa+GxPRxT4DkZxCZ4Z3te?=
 =?us-ascii?Q?B3gNmKdnRyoIf++3vP7wIzfFz8uX4+4SjPswsKUQ4rtOuqvYGIojKdTMVACj?=
 =?us-ascii?Q?8OCLTFJLgZZYvRnsd9ipjB6hoOyUBynqoUMRXZhgVDo9DQpL1MXH8nzaPCSu?=
 =?us-ascii?Q?4jSzHShPF+lNzBm+IdI0sCIrfAKKPqJ55v4CJZ354qD3qpPJNRQ13HnlEFP5?=
 =?us-ascii?Q?ECh6M9o1ivdFTIEYpukSUZ6EB2KIPI0kzBTmGc9/96YrgcgWkXKRgdJt+BSE?=
 =?us-ascii?Q?lkjMaWzQH8G5KeoZnnXhFGDXYZPWYF9cNfct02NTrjt+qOIOmKwj1p+kagxH?=
 =?us-ascii?Q?+LK/Pd8TrHxv4ewgllaKsmU9Cu5fWjTx1eeF6Qwk0ij+OQOFARsHpag7tczQ?=
 =?us-ascii?Q?wX+KBBHNZVyFTfeeF6Sy0G/zS3RNxYHQzMYY51UR2H+abHw8J1Lnvqagrsnz?=
 =?us-ascii?Q?zb/3kuGt2p11S2h8kIbY5FnCEyZXglotHEJbbCDrWBZYrKM2zJgjILvqubXy?=
 =?us-ascii?Q?OlJSseb/4YIe29RNM0BWk0dGiA3eFx8NrkLS6j+SEjR5pJ+2XE5GA3cvJs87?=
 =?us-ascii?Q?fSFowca2NqVOovJ0opb2751Gq43V20pscjH7GKHy229195p2uITdeqQj4jUP?=
 =?us-ascii?Q?Wqexd3KaYbyPO0/OX6tkKejtjAZYzZG8gF/Wdj+670lgXGgZTgUXV+W06pjT?=
 =?us-ascii?Q?2JEuKnaEYGXXmdY5o6T2Ujudkz/ba3BuHQ3tmKZiv8aLLKiArlJb7w88loD3?=
 =?us-ascii?Q?2ZcdNnMMRiCOVUtovcadnm/4pKTLEVxo3AFAaBSjYO/My06Khp57PS9/Xik5?=
 =?us-ascii?Q?7h2HWou0hKJAvyeUaTDrhNWAIt4PwZ+VCXiILEfwrKPXmXQDK9BYJKwrZ6QA?=
 =?us-ascii?Q?yoaVGSAYtE9URfrJd0guYlLzsKNzn7GANc1V4KXFjv6+bHmS8VZTmxiDHVGm?=
 =?us-ascii?Q?R9e7LCtJoTD/x664Plj9PAU0QKuObMZue48BD3oo8KyRNomsytTLAWUJ1dAe?=
 =?us-ascii?Q?A8IK6HQVdzqGjElsljIqORZTTquE7RC9CdFmfl40Zv3ab0HxxP19gXFIZ7UQ?=
 =?us-ascii?Q?T3T3i/dkkcXpbu82sgeX8BVrX0r5QK81O8lDiK7JC7D6T74TByjzN6/df/D+?=
 =?us-ascii?Q?b4naCCs9ZsKeTXGLgkEbnj5TazE4alD6TR2wkX8Od48/CXN2jhj//GKq84H0?=
 =?us-ascii?Q?AaDicIg59Cc9twwHyG15MVxX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ac691d-b4c3-4172-7df1-08d8dc75f38c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 05:50:43.3447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tx5rmbQj2uKT7ogsgDZPszoU7WVh18DOv5SszKrqBsIvLvvM98trCOjUexgGeX1j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1161
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

Update the gpu_metrics interface implementations to use the latest
upgraded data structures.

Change-Id: Ibdbb1c3386de12c53bea3b8c68bbeebd14787287
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  8 ++--
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 14 +++----
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 38 +++++++++----------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 12 +++---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 10 ++---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 10 ++---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  6 +++
 8 files changed, 54 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index d400f75e9202..b5c4aff501ee 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -61,8 +61,8 @@
 #define LINK_WIDTH_MAX			6
 #define LINK_SPEED_MAX			3
 
-static __maybe_unused uint8_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
-static __maybe_unused uint8_t link_speed[] = {25, 50, 80, 160};
+static __maybe_unused uint16_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
+static __maybe_unused uint16_t link_speed[] = {25, 50, 80, 160};
 
 static const
 struct smu_temperature_range __maybe_unused smu11_thermal_policy[] =
@@ -290,11 +290,11 @@ int smu_v11_0_get_dpm_level_range(struct smu_context *smu,
 
 int smu_v11_0_get_current_pcie_link_width_level(struct smu_context *smu);
 
-uint8_t smu_v11_0_get_current_pcie_link_width(struct smu_context *smu);
+uint16_t smu_v11_0_get_current_pcie_link_width(struct smu_context *smu);
 
 int smu_v11_0_get_current_pcie_link_speed_level(struct smu_context *smu);
 
-uint8_t smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);
+uint16_t smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);
 
 int smu_v11_0_gfx_ulv_control(struct smu_context *smu,
 			      bool enablement);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 50d5f2256480..59b46dd04d88 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -236,7 +236,7 @@ static int arcturus_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_0);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
 		kfree(smu_table->metrics_table);
@@ -2211,7 +2211,7 @@ static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
 	kgd2kfd_smi_event_throttle(smu->adev->kfd.dev, throttler_status);
 }
 
-static int arcturus_get_current_pcie_link_speed(struct smu_context *smu)
+static uint16_t arcturus_get_current_pcie_link_speed(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t esm_ctrl;
@@ -2219,7 +2219,7 @@ static int arcturus_get_current_pcie_link_speed(struct smu_context *smu)
 	/* TODO: confirm this on real target */
 	esm_ctrl = RREG32_PCIE(smnPCIE_ESM_CTRL);
 	if ((esm_ctrl >> 15) & 0x1FFFF)
-		return (((esm_ctrl >> 8) & 0x3F) + 128);
+		return (uint16_t)(((esm_ctrl >> 8) & 0x3F) + 128);
 
 	return smu_v11_0_get_current_pcie_link_speed(smu);
 }
@@ -2228,8 +2228,8 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 					void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_0 *gpu_metrics =
-		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_1 *gpu_metrics =
+		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -2239,7 +2239,7 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2280,7 +2280,7 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_0);
+	return sizeof(struct gpu_metrics_v1_1);
 }
 
 static const struct pptable_funcs arcturus_ppt_funcs = {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 97038e027b39..81a7888b79a0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -481,7 +481,7 @@ static int navi10_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_0);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
@@ -2602,8 +2602,8 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 					     void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_0 *gpu_metrics =
-		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_1 *gpu_metrics =
+		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_legacy_t metrics;
 	int ret = 0;
 
@@ -2621,7 +2621,7 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2658,15 +2658,15 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_0);
+	return sizeof(struct gpu_metrics_v1_1);
 }
 
 static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_0 *gpu_metrics =
-		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_1 *gpu_metrics =
+		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -2684,7 +2684,7 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2716,22 +2716,22 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
-	gpu_metrics->pcie_link_width = metrics.PcieWidth;
+	gpu_metrics->pcie_link_width = (uint16_t)metrics.PcieWidth;
 	gpu_metrics->pcie_link_speed = link_speed[metrics.PcieRate];
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_0);
+	return sizeof(struct gpu_metrics_v1_1);
 }
 
 static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 					     void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_0 *gpu_metrics =
-		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_1 *gpu_metrics =
+		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_NV12_legacy_t metrics;
 	int ret = 0;
 
@@ -2749,7 +2749,7 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2791,15 +2791,15 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_0);
+	return sizeof(struct gpu_metrics_v1_1);
 }
 
 static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_0 *gpu_metrics =
-		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_1 *gpu_metrics =
+		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_NV12_t metrics;
 	int ret = 0;
 
@@ -2817,7 +2817,7 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2854,14 +2854,14 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
-	gpu_metrics->pcie_link_width = metrics.PcieWidth;
+	gpu_metrics->pcie_link_width = (uint16_t)metrics.PcieWidth;
 	gpu_metrics->pcie_link_speed = link_speed[metrics.PcieRate];
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_0);
+	return sizeof(struct gpu_metrics_v1_1);
 }
 
 static ssize_t navi1x_get_gpu_metrics(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index fba741060000..d287448bb0f7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -543,7 +543,7 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_0);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
@@ -3119,8 +3119,8 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 					      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_0 *gpu_metrics =
-		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_1 *gpu_metrics =
+		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
 	SmuMetricsExternal_t metrics_external;
 	SmuMetrics_t *metrics =
 		&(metrics_external.SmuMetrics);
@@ -3134,7 +3134,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
 
 	gpu_metrics->temperature_edge = metrics->TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics->TemperatureHotspot;
@@ -3178,7 +3178,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 
 	if (((adev->asic_type == CHIP_SIENNA_CICHLID) && smu_version > 0x003A1E00) ||
 	      ((adev->asic_type == CHIP_NAVY_FLOUNDER) && smu_version > 0x00410400)) {
-		gpu_metrics->pcie_link_width = metrics->PcieWidth;
+		gpu_metrics->pcie_link_width = (uint16_t)metrics->PcieWidth;
 		gpu_metrics->pcie_link_speed = link_speed[metrics->PcieRate];
 	} else {
 		gpu_metrics->pcie_link_width =
@@ -3191,7 +3191,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_0);
+	return sizeof(struct gpu_metrics_v1_1);
 }
 
 static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 7efb7af51013..9ba4e5980cb0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2128,7 +2128,7 @@ int smu_v11_0_get_current_pcie_link_width_level(struct smu_context *smu)
 		>> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
 }
 
-uint8_t smu_v11_0_get_current_pcie_link_width(struct smu_context *smu)
+uint16_t smu_v11_0_get_current_pcie_link_width(struct smu_context *smu)
 {
 	uint32_t width_level;
 
@@ -2148,7 +2148,7 @@ int smu_v11_0_get_current_pcie_link_speed_level(struct smu_context *smu)
 		>> PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
 }
 
-uint8_t smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu)
+uint16_t smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu)
 {
 	uint32_t speed_level;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 3f815430e67f..95167ff59388 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -210,7 +210,7 @@ static int vangogh_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_0);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
@@ -1401,8 +1401,8 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v2_0 *gpu_metrics =
-		(struct gpu_metrics_v2_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v2_1 *gpu_metrics =
+		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -1410,7 +1410,7 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
 
 	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
 	gpu_metrics->temperature_soc = metrics.SocTemperature;
@@ -1450,7 +1450,7 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v2_0);
+	return sizeof(struct gpu_metrics_v2_1);
 }
 
 static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABLE_COMMAND type,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index c9f766cbe227..e3232295f2bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -151,7 +151,7 @@ static int renoir_init_smc_tables(struct smu_context *smu)
 	if (!smu_table->watermarks_table)
 		goto err2_out;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_0);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err3_out;
@@ -1231,8 +1231,8 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v2_0 *gpu_metrics =
-		(struct gpu_metrics_v2_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v2_1 *gpu_metrics =
+		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -1240,7 +1240,7 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 0);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
 
 	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
 	gpu_metrics->temperature_soc = metrics.SocTemperature;
@@ -1285,7 +1285,7 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v2_0);
+	return sizeof(struct gpu_metrics_v2_1);
 }
 
 static int renoir_gfx_state_change_set(struct smu_context *smu, uint32_t state)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index aaaf9588d921..80555013ccbb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -760,9 +760,15 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	case METRICS_VERSION(1, 0):
 		structure_size = sizeof(struct gpu_metrics_v1_0);
 		break;
+	case METRICS_VERSION(1, 1):
+		structure_size = sizeof(struct gpu_metrics_v1_1);
+		break;
 	case METRICS_VERSION(2, 0):
 		structure_size = sizeof(struct gpu_metrics_v2_0);
 		break;
+	case METRICS_VERSION(2, 1):
+		structure_size = sizeof(struct gpu_metrics_v2_1);
+		break;
 	default:
 		return;
 	}
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
