Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DAEC47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19D1761C53
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D1761C53
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A6416EDD2;
	Wed,  2 Jun 2021 16:51:20 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1069E6EDC7
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrolLFxDHuN3Pa5fzcFqpM/yBzjmSa79AEtLeQCgWgsperIaqmiCXRC61vH3RcSLL1bvJbbBDpf9cyD/j/DX7a3cP2u07flVJwu77u9EweyFGJLU3AwMB7LXWtJ3c837L/nX3qLAI2e0ryxiQVBYypbuSF67rfo28aDeY8Shy2ZlWEutnukK8XF8hkrgCjmK8/cGJWhTyhDhPwSRakFTEjEF46ANcFHyXCcqHIz6NnsfEXALTIT0Zhg1GZY9G52E18vn9WM9bnuKb6Wj0bnM1UVNVxPW7gMoaNIKtllahEjTgLK8w1rA4C9aDzwvvbrPqjAxICyQ51tVlBXrVVHFmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOsu+fB/qz6zXFqCNxNDPBAUJUJJxZ+x9mNNuJDNGf0=;
 b=OoApiPfypkoHm6upj+dU3usdY3gsOmDnyrnuvuhj5YB0sj6TClJBIpphjZb5NSddrMh9bcheeXWvC2DYO+XuyXv2sZnuxsdlYTXtb3U98lxX/1L84jt9oEyWF1h7mkcbqzfO/Kzx8jl2KRw1sbmR2sA6dXi2VeBHI4y3lcy5ryRFLBs8roQ19oo4zxxi4bUkM1WO+JBVJGy4pnN/wsuF8s4i/wriCAZgBewRdOzg9JmGmtO6Gffa5xzp41BKvXUpl0b8NB41aFBBO+NlQXKocu3AnT21HxpCluGuyOXsa2KZs1E0FNZIu1IeKHDpkoduIqjZs4XIcgMGAiJeiCbNjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOsu+fB/qz6zXFqCNxNDPBAUJUJJxZ+x9mNNuJDNGf0=;
 b=VpAvePJw8kgi9zn5Ub/eh0At7VRQbDJY360ztg1w6YTeq8RV1mfiXwU0iijUWOxrhqoyQ7c6c+fED89+6QulshwAORujeV6QtocDzHvI/VmEmzLJ5nd2x29SOIcdHXOGbl6aGg1yLxK/7DWULnk0vacBbi9QLr7+M01pFkj6hA8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2369.namprd12.prod.outlook.com (2603:10b6:207:40::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:51:15 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:15 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 65/89] drm/amd/pm: add set_performance_level function for
 yellow carp
Date: Wed,  2 Jun 2021 12:48:44 -0400
Message-Id: <20210602164908.2848791-65-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:50:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24420be6-f3ab-4a7e-7431-08d925e67d27
X-MS-TrafficTypeDiagnostic: BL0PR12MB2369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB236993F5350170A360461D64F73D9@BL0PR12MB2369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q27+ejMllNIaokd4MQqpP1Bc0Ap3gY85jCVEfFNdw5jhH5Gqiy2YdAJq007Vz2wpF1J4n5L8bM/5G5/UwPZc6r9fAcAIGDGDAjConQVut5+64nZ8U16K0YRjz3qHZEdM8M0OpMCtgWB3cZdLSv6fVUqnp6nbUOJtuBP1eIMgfR7uujiAft5SXMQ7fOrubeNnVJ80+aLgMv0pn3Yvo/HzeuMbCUHaFBuS/nOHG4Lj3R6t6pkPiRVFXvYy49lSo3iylm/Qhm3FKUDFsSmrzwGM1LXxUUQT9OKv8V50BnxHLJIHYJ3MLGFr36w1fuBqmlTe8NNMFTWipyJrtwkTlNOxNNamxj+LyUHVzqUxP/P+1VnqsXnde8qyfIxk7OUOsGcfw3HtDh0WqKJIKRfJyHeMPONCqOn6PQUcIrFqEeCcRClt1iMahHhYTEO6t4PcFly//CRl+dUCBlSZZrRstg/WTTx5EltqcAOjoNXcwdfhb3hqb83yCex2vj4/ZchCkbOgp13ziUKHR1LpeJiMjEqeJx6Ryk9a5/aI6QamfjSZCMRJVhBxy7lg68wJRRbeZVi9KRFbwAyA/n2i8mnRnr4YHGKgG5i11bHG2FnC4dVDOZuOEvL0/5ELKJxAU3E/gFVWTWoTKJfiP9cMk8YS6JATwum/aDuNlY5jMprqY9kVyZtGrzxQPe02Jiecf8W0++Js
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39850400004)(346002)(366004)(396003)(54906003)(1076003)(8676002)(6916009)(956004)(2616005)(478600001)(6512007)(6486002)(86362001)(6506007)(4326008)(6666004)(38100700002)(316002)(38350700002)(52116002)(26005)(186003)(5660300002)(66476007)(66946007)(8936002)(83380400001)(36756003)(66556008)(16526019)(2906002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?o/Rhe1QLH20GnKsFrLI7DEu7wc11iq8mEcDK6eclLKvgwN+NBsLdab8ELRNy?=
 =?us-ascii?Q?4MZ7fzsk6LXoPUdj2bx6cyVKV6JaadrXesou7MFpwD7YH0gc1MidnZyN9pO5?=
 =?us-ascii?Q?pwhJV7dddKSVRLeG8u9BkS9kIGRO6AXpQ7yDxnqjA8rv5nO0qczBrV4PWetZ?=
 =?us-ascii?Q?HM2J3A6pIdCkQ/6lrV0fltrfv+8Zr10nDHDZ8A39iLIou2BmUILKmO3vorCp?=
 =?us-ascii?Q?jqQD1ZMj4FIcnQ1n0XuRzh79scKkzXvFAQF1FsNkkypNMW04D+8yoWl3nlgC?=
 =?us-ascii?Q?mhPohXazyG9tR21r0yGWi/Z0Om5p1AIFgzOVuHDXq/43O91Ru0sH6zh7/zI+?=
 =?us-ascii?Q?lE2NBmIwBS4/OnGiByCnNmd+l6/qeA1666clLIBlTwEas6QDS0LGWOMZ2zRw?=
 =?us-ascii?Q?K3DF6T1hi/3LmDYLPDGQNUJAiXmaP9sfhCwTxjCJ82KD21uHYBxHt0ljMXso?=
 =?us-ascii?Q?5LR2JXKdDnB7ekjLBf0VC1HRq37Fdpf3gJmHDNZlX7ows8v59fDCLu2T/HIt?=
 =?us-ascii?Q?yq0u0uezHy0uONXewzLmwigr0faeSigh3s4Ja8AB7pG5/bRXLzPqWURoaBhk?=
 =?us-ascii?Q?j5b+fuDjvoYj8bjodwD5c0Uaud9a/edIA5Ce49IG4QVORjdy4LSAeePzuG6B?=
 =?us-ascii?Q?y6sVzReYZHlwRZVdWUCwiSXzQARJUX0Yd2nLolDVqIVCxiqAesR1MqCoDW1A?=
 =?us-ascii?Q?U9YjyyqhMYpMHYwwMWqlRX1/8cL1ATiG2RpEdKO8u6kNm3u7diYqqyvcOM9k?=
 =?us-ascii?Q?XzQK944F2NuctZXjNeuXjPqpJ8svxb3SzRhdSYzo5QgPM2MW8ET6oaF+yrt1?=
 =?us-ascii?Q?yHZtXG4808wN6sdWYRREQcLfubSYkRu7J6dGTrKcMKd90T7MPw0VXfAAN6N4?=
 =?us-ascii?Q?4o91gszfa8X8LFtStTJ7Vje7sO0BRfSbmrogz8S7/uUadEbxyzYilTikCP71?=
 =?us-ascii?Q?KD8I+sU4uAhb5w+6qFqbRlu4w4/FIiiYQzR+2VekL5S9khq3QXF+xwdiJgj5?=
 =?us-ascii?Q?SLgI1BUrxgDDIF0GTDgtMk6EUV/a6EEMWhyQQg+2kb3L9lmYMyEiaZPHKBvS?=
 =?us-ascii?Q?iX6pw6tnU6D3OmwKo84IXqPZqj0XNpCBmExtEb2oxIEVtAEp0cweCK/K5jzQ?=
 =?us-ascii?Q?yvk/cSjmG2gZN3WvUmTpWjC/P4rN5k/1FUH8XFW2GlC3GyASfJ1XzjsIY+hA?=
 =?us-ascii?Q?eyL2TvevoHnZYjA53kWWzlbR3AbIZoE95fM0Mla488BgkI7rP/xKrQdFXVJ0?=
 =?us-ascii?Q?Sf1y9pNygD7x38yoP3cCsz9k9YdjIn//uz/KWF4u4pshOzTQQxAf4IBpLIEW?=
 =?us-ascii?Q?PqWstMzkzBVmkz9pvD6FaK36?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24420be6-f3ab-4a7e-7431-08d925e67d27
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:12.4060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7OqAGB2xoTCNFFEtZw4IKfmd3jvKDTxw1zLRZHrgD/kdki4kAu/8aQpmZpx3fIc7CdeysJp6F3KUCoH7+sAEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2369
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>

This patch enables editing sysfs file power_dpm_force_performance_level
for yellow carp. User could thus adjust the dpm forced level.

v2: enable fine grain control of GFXCLK only when in manual performance
level mode. In other mode, the min/max range of GFXCLK will be reset to
corresponding values.

Ex: To enable min 300MHz / max 600MHz gfx clocks

1) echo manual > /sys/bus/pci/devices/.../power_dpm_force_performance_level
2) echo s 0 300 > /sys/bus/pci/devices/.../pp_od_clk_voltage
3) echo s 1 600 > /sys/bus/pci/devices/.../pp_od_clk_voltage
4) echo c > /sys/bus/pci/devices/.../pp_od_clk_voltage

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 24dbd4ce4938..ddf56b31a403 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -602,8 +602,13 @@ static ssize_t yellow_carp_get_gpu_metrics(struct smu_context *smu,
 static int yellow_carp_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABLE_COMMAND type,
 					long input[], uint32_t size)
 {
+	struct smu_dpm_context *smu_dpm = &(smu->smu_dpm);
 	int ret = 0;
 
+	/* Only allowed in manual mode */
+	if (smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL)
+		return -EINVAL;
+
 	switch (type) {
 	case PP_OD_EDIT_SCLK_VDDC_TABLE:
 		if (size != 2) {
@@ -1049,6 +1054,84 @@ static int yellow_carp_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
+static int yellow_carp_set_performance_level(struct smu_context *smu,
+						enum amd_dpm_forced_level level)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t sclk_min = 0, sclk_max = 0;
+	uint32_t mclk_min = 0, mclk_max = 0;
+	uint32_t socclk_min = 0, socclk_max = 0;
+	int ret = 0;
+
+	switch (level) {
+	case AMD_DPM_FORCED_LEVEL_HIGH:
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sclk_max);
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_MCLK, NULL, &mclk_max);
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &socclk_max);
+		sclk_min = sclk_max;
+		mclk_min = mclk_max;
+		socclk_min = socclk_max;
+		break;
+	case AMD_DPM_FORCED_LEVEL_LOW:
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, NULL);
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_MCLK, &mclk_min, NULL);
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, NULL);
+		sclk_max = sclk_min;
+		mclk_max = mclk_min;
+		socclk_max = socclk_min;
+		break;
+	case AMD_DPM_FORCED_LEVEL_AUTO:
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, &sclk_max);
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_MCLK, &mclk_min, &mclk_max);
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, &socclk_max);
+		break;
+	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
+		/* Temporarily do nothing since the optimal clocks haven't been provided yet */
+		break;
+	case AMD_DPM_FORCED_LEVEL_MANUAL:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
+		return 0;
+	default:
+		dev_err(adev->dev, "Invalid performance level %d\n", level);
+		return -EINVAL;
+	}
+
+	if (sclk_min && sclk_max) {
+		ret = yellow_carp_set_soft_freq_limited_range(smu,
+							    SMU_SCLK,
+							    sclk_min,
+							    sclk_max);
+		if (ret)
+			return ret;
+
+		smu->gfx_actual_hard_min_freq = sclk_min;
+		smu->gfx_actual_soft_max_freq = sclk_max;
+	}
+
+	if (mclk_min && mclk_max) {
+		ret = yellow_carp_set_soft_freq_limited_range(smu,
+							    SMU_MCLK,
+							    mclk_min,
+							    mclk_max);
+		if (ret)
+			return ret;
+	}
+
+	if (socclk_min && socclk_max) {
+		ret = yellow_carp_set_soft_freq_limited_range(smu,
+							    SMU_SOCCLK,
+							    socclk_min,
+							    socclk_max);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 static int yellow_carp_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
 {
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
@@ -1088,6 +1171,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.od_edit_dpm_table = yellow_carp_od_edit_dpm_table,
 	.print_clk_levels = yellow_carp_print_clk_levels,
 	.force_clk_levels = yellow_carp_force_clk_levels,
+	.set_performance_level = yellow_carp_set_performance_level,
 	.set_fine_grain_gfx_freq_parameters = yellow_carp_set_fine_grain_gfx_freq_parameters,
 };
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
