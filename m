Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEF2C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C7661C68
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C7661C68
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A74C96EDB3;
	Wed,  2 Jun 2021 16:51:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BA5B6EDB3
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lq/kJ2jZuKodYrVh9q+Ca9vCqLDXKHjHPJVQMpGLX3QIWhE7O5kMw57bNGI4QPESetKZ8h8VOKudYQRrx5UQpNTC7epPJyP40vFecNp4skstSrRxQyZ49s1tOMOttGPfimUnjNxXfJIPLKwUrUi0ZzJgB4Inb5iGSewYsevM8Ba0zfiBK6a+7NIj9gI0rEhGktK8Enpbzb0nGjO1Kx9dqyrskoYj8z3DsH90TTkxdcd480iHHw2iqYocxwRgWhfcU9EyyG/jdaKfiORt0cyZYIyEBjr7coUN6VDCKh3/1q1wLzoMihgyAl56tt+GlT0qm3Eaj0k15DJLCyqub39zEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9ScS4zy17kc7kLtQ2IjoKjaUIg/9Q0vMe+dS9wa7wQ=;
 b=F38mdNoMmbP/ye13rGNo7dVtrs1SqGmKqXBbRmxIkvIY0QBk4UILgjSnLT1xVUA6tCHxhN9FUGcK+FbLUHeirYtZ2TWpnPkaqXFJbcgk+PNokSVeghTcvbhOBi/5xZowdrRadG6vk7Wouy4CQPty+iUj1Th63jvbg4VXvVozXZuRd/0G1PGQ3C6/JlW2PNsEru1qCDcLSoVnmuEmwf774eNyKfoyB5+tnXcbhMnHnPXaeUzg7l4PyHmkbb8DoMd02NCRzIDtpvXYPoyoQu6t4cM/shNFFaJgF8bE8hX2IP+Xaf+zaj/yYwE5Xw2nJzv553dig27X7YJqx2CP8T1dEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9ScS4zy17kc7kLtQ2IjoKjaUIg/9Q0vMe+dS9wa7wQ=;
 b=OOThVii413mpRmLUcVxg+Q0AuhJp6lljgMZIMCflcoP+2jRh6TVNhTEWuRoSnQpy+HheyvW6Q+A9plPJU1bMFNwkrKZXESr0/Ur9ggZEJ/oqoyJ8DmZ9a3wYtVn0PbsIKGkfUeYEB7jv2Ne1C/ArNiTnKZARfbr/oC5QXLJMceo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4675.namprd12.prod.outlook.com (2603:10b6:207:35::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:51:12 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:12 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 62/89] drm/amd/pm: add the interface to dump smu metrics table
 for yellow carp
Date: Wed,  2 Jun 2021 12:48:41 -0400
Message-Id: <20210602164908.2848791-62-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:50:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1885232-d3fb-4a81-b762-08d925e67c07
X-MS-TrafficTypeDiagnostic: BL0PR12MB4675:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB46758EDE3EC1A63B3A45FC85F73D9@BL0PR12MB4675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2bBqIvUGOj0yg475NjJogJInF3+u7xo6kcHOh7LKtZj8/5XnWtcUbgppkSxr24hV6OmJFZvDgUavyntU7LvKnB/vqFVhoIZAt3r5PEThy9ZDnRQnDeuv+M1RZbHqjynxVsw+dyQr/C4M+MrdLCaEdPwTWKwyYbSWuoJ6KNXHBfBZzSOmlgPFZoGVifGEWf+YvbAvGl2NnWyKdc9UJitNsxw0iykrmEKC673PpWkD0swJ0H/SsFZ9JvK7Ru5ys0kKpFcaejtH2i9/ngG/Aq7quUvTsfUILBMYVQzO+pJpmUwWF/d4OrQ5fT4TyCikIX2CGh6GJGPTXnatwTXawZcKK2D3S7e5z2HukgFLFBqXJ3cX/2JPfkRz3QAozvKlqYm93uuhe/02o99WdD02hWPa1fZD7IKm3h3TE24uebeIcf8J44kFtEs0WY4c+vby1xyhLzNow+CC2ZCzVCtYCAJFmR2+zjA2BP4bjlrZE+g6FskYctTgjaikhGlX9FVa6XUsvIdqZUyJi+WQ9UY6HaqJLQlTV8EcGKZEcQiKmvIL1zfxFgbe4V6xpSOtqrlXVger05tUPPdq08W/i4BdI0sp8L03sm5oYvGY5zASUWVwQQFQN3TheMv+D3g9iUpTqb6uQCjdJOuJSOYqP2mbM1C26FeGcT8WB36vRvPV+6gWBgmKWJu69PE8CD+Jd70S8Fwm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(52116002)(6486002)(956004)(6666004)(26005)(5660300002)(6506007)(2616005)(36756003)(6512007)(478600001)(38350700002)(66476007)(66556008)(83380400001)(8676002)(2906002)(4326008)(86362001)(1076003)(16526019)(316002)(186003)(54906003)(6916009)(66946007)(38100700002)(8936002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pNSlkJuLCoSTERCvk5bXJBvYi3sSGXX4yb4rxhS10OdeB8uXXrJrvZMf/drO?=
 =?us-ascii?Q?JG6a0AI0eegS/UvnLkdGKyNxxXy01OIX/88Osbm9uL1OPkhrvqEzZvZJNOQa?=
 =?us-ascii?Q?o0v0EuqV1UyQg4ABzEdGgEvr2Jx0pRISaPX4lfXJUjCkiKAtMV7fdZXCTNg6?=
 =?us-ascii?Q?06b0uoFTpKOyXOlbx/AMZTzIIYKsmrdQEzSSbWjA+3xeLgJYmYea0iPWfHkQ?=
 =?us-ascii?Q?SQASvp0k4rdvYY3cFOQmSh8LF7miOmPkzdsKRiaNhye5XMb7hVaCBiWovo4K?=
 =?us-ascii?Q?NMNwi9kLsnio+/OhkzdhbN0yx/6eeZCd63yMNJj3D/RLw9rGnwdCXdocZY2A?=
 =?us-ascii?Q?CqQqUOo0IJ7PmHMgNTq0/iaLa+Ws+29weFG9NKShhWpIAyCJICOL1fPNhW1j?=
 =?us-ascii?Q?wsrUv9wXMj6hvCOQfvfKJ1PrQqypp9AQla6d7DryWxFBOBn9kAx5ezmXp6B0?=
 =?us-ascii?Q?Kmw2agvMcJR2MYO4iU4gauledqyEb2oFEZ+yPTrbObJC6HMOz815VK3JwLSH?=
 =?us-ascii?Q?TsiVs+A1v7JWOJXPfgrVWfUu8/OinN+YoUK9V3uk/CoMZDnJM1Stvg3VZSv8?=
 =?us-ascii?Q?lY0phglolOmM4j2gKTqurn84C9+anJUxnAOg1nPIH5V73qicPSrr+PwZntRX?=
 =?us-ascii?Q?jqklqazFdQEku0N+mP4Km0c6lBeiF65ByCt1ZcIXSBapxCr7jRII3JQe1dRu?=
 =?us-ascii?Q?hvc0plI1l4kIHRm2SQk6ASbJ/ZcMLeg7gqesZ7rKPBlHRVlU9Prpz7eyjHfN?=
 =?us-ascii?Q?8iXj4P4ZXzcbl5LafvTGKEQNVCy/wn2rsr53YMaea7MkaQ4cwynd6uZvN9d4?=
 =?us-ascii?Q?gP0NXsbzHofVlbzEYtdf6xeC5Ekt3RZkzWsM9BNvSnoqEZHj+ZEYjQA+9REp?=
 =?us-ascii?Q?smF/a2rjSJXEzTtkoGjnPLfv309d37Q5CCIq5YnXm3lr9x7N5W30dyIgdZqR?=
 =?us-ascii?Q?vWDxtU5TCSQ+I1AkLpojC/evEkv+JQtjl88Bw7Hn/fRKN8HT+dYsdfZ1s0ne?=
 =?us-ascii?Q?gljdp2k1NQFWIry/L5A2My/gExbEu/z/guo2LRP/YvgLaaiHbvAg0bMwNfOV?=
 =?us-ascii?Q?BNrzMlybtYWm3++QcK9dp1v23nwHIOLj/DfI8DlgssoPnjFUof2g7YZwNxbR?=
 =?us-ascii?Q?sFeuKLYPfYl8L3PnJFg1kYKSVYUWz0a7uEMGEmsHFPgCY49C1tcGbnVZuLiv?=
 =?us-ascii?Q?yo76XoqAOjWmrxRSi19s+pE8t0EbI4R4gCSkcUuNeFD3MQsJawMjBym2ezJb?=
 =?us-ascii?Q?IP8tFoiDK63bkZixkJ2IPXerjWUMpZm1CMpCgXyUwy5xAcFYiUfA2H2ToiUe?=
 =?us-ascii?Q?LpqIiHaQS9+0jAZkJ5V2WcFQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1885232-d3fb-4a81-b762-08d925e67c07
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:10.4635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rb80AyfZmG5EKA4SeKMWs+pSSek+NpQRhkZFpdxV4w/efOBiFJQc0Emsw9DF1BX/RDKU8sn5paRk5C4ae0nanw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4675
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

This patch is to add the interface to dump smu metrics table for yellow
carp.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 56 ++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index db1252424f0f..24dbd4ce4938 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -169,7 +169,7 @@ static int yellow_carp_init_smc_tables(struct smu_context *smu)
 	if (!smu_table->watermarks_table)
 		goto err2_out;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_0);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err3_out;
@@ -546,6 +546,59 @@ static int yellow_carp_set_power_profile_mode(struct smu_context *smu,
 	return 0;
 }
 
+static ssize_t yellow_carp_get_gpu_metrics(struct smu_context *smu,
+						void **table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct gpu_metrics_v2_1 *gpu_metrics =
+		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
+	SmuMetrics_t metrics;
+	int ret = 0;
+
+	ret = smu_cmn_get_metrics_table(smu, &metrics, true);
+	if (ret)
+		return ret;
+
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
+
+	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
+	gpu_metrics->temperature_soc = metrics.SocTemperature;
+	memcpy(&gpu_metrics->temperature_core[0],
+		&metrics.CoreTemperature[0],
+		sizeof(uint16_t) * 8);
+	gpu_metrics->temperature_l3[0] = metrics.L3Temperature;
+
+	gpu_metrics->average_gfx_activity = metrics.GfxActivity;
+	gpu_metrics->average_mm_activity = metrics.UvdActivity;
+
+	gpu_metrics->average_socket_power = metrics.CurrentSocketPower;
+	gpu_metrics->average_gfx_power = metrics.Power[0];
+	gpu_metrics->average_soc_power = metrics.Power[1];
+	memcpy(&gpu_metrics->average_core_power[0],
+		&metrics.CorePower[0],
+		sizeof(uint16_t) * 8);
+
+	gpu_metrics->average_gfxclk_frequency = metrics.GfxclkFrequency;
+	gpu_metrics->average_socclk_frequency = metrics.SocclkFrequency;
+	gpu_metrics->average_uclk_frequency = metrics.MemclkFrequency;
+	gpu_metrics->average_fclk_frequency = metrics.MemclkFrequency;
+	gpu_metrics->average_vclk_frequency = metrics.VclkFrequency;
+	gpu_metrics->average_dclk_frequency = metrics.DclkFrequency;
+
+	memcpy(&gpu_metrics->current_coreclk[0],
+		&metrics.CoreFrequency[0],
+		sizeof(uint16_t) * 8);
+	gpu_metrics->current_l3clk[0] = metrics.L3Frequency;
+
+	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+
+	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
+
+	*table = (void *)gpu_metrics;
+
+	return sizeof(struct gpu_metrics_v2_1);
+}
+
 static int yellow_carp_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABLE_COMMAND type,
 					long input[], uint32_t size)
 {
@@ -1025,6 +1078,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.set_watermarks_table = yellow_carp_set_watermarks_table,
 	.get_power_profile_mode = yellow_carp_get_power_profile_mode,
 	.set_power_profile_mode = yellow_carp_set_power_profile_mode,
+	.get_gpu_metrics = yellow_carp_get_gpu_metrics,
 	.get_enabled_mask = smu_cmn_get_enabled_32_bits_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_driver_table_location = smu_v13_0_1_set_driver_table_location,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
