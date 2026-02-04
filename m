Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C674E8B399
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 04:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB91B10E33F;
	Wed,  4 Feb 2026 04:44:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LDkpKRW4";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012028.outbound.protection.outlook.com
 [40.93.195.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F0EB10E33F
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 04:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuwmGhFx3jad4B1weIv01svM9Rug2C0rVPPO9CrcD3QjFQN+S5SVVshtvr4JX/7vDUq1Z1WLHHWSYMka/PHNBCKm3poOjqpqYeFSx5Zgt9l8XRWDtWPS966PRbb32iXBxVST36qkvj2ZhF8e0GxDb8a7DJv6Qtzk7Toww3iVNudzBAsNVm9MDFrvml0r2aMpzsY2Kju6G/8cHvi/ctSmNecNSrLQErovJSpiBq7y+ylKa+tfTfBoh4JcxexwGejkDlwERuudcr2TBRc8aXOKeX+9CgPkpebU4CS337VksM/+4CXhtwknf65Ekz17o7BwB3jYJbbhliagkQBIaxMQ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bF6Qzdyx7EBM3HoGEtPRn1thUQkc3EX2GonTEc/PBQ=;
 b=baMKYccAr3E6ayjVzUJ1CEt5WKKmV2PwzPC9TggeWmEfsdppTlahewTVw9uRKvfttTmDat2NOYl5KkHDT29f9xUol0gYOMr734di1zu/yRqhwTpLAwVC6UEo4Ekz9afPLxnSZL2ONXtw7wdDL0lSDADXwCMjrZs1+8uJpvacN0+zb8TO8X3bs2GIt648IGJWpNNj+ACLmYZRYJY04/1l2muhkLtmwp6dT4G7XjX9i0CF01zxC3Pl91g4a9tVF8JSMmY9dHsED0NyVRfxrR3SNn1cdysOGbs5c4LxpFVXE8LosMtp38bNaJCNW0kJckONvCONO0xOncN+WJCVuIPsog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bF6Qzdyx7EBM3HoGEtPRn1thUQkc3EX2GonTEc/PBQ=;
 b=LDkpKRW4XKHj3dOi0WXICJ73RTfJR8Y+r+BK1R3tvNnSgmIk/0Cw0fxNB6kABCdhfY0FTKRi/OWWjf4QulRQHGMoI7gaW+0OKLJ2OBEpbXDY5K0NPBUcFWQNNBHq/z8Th9CoviB4/iBa2at7TgCUdMYKZVQ03P9MeOVTaxnUdfA=
Received: from BN0PR04CA0139.namprd04.prod.outlook.com (2603:10b6:408:ed::24)
 by CY1PR12MB9650.namprd12.prod.outlook.com (2603:10b6:930:105::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 04:44:05 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::9c) by BN0PR04CA0139.outlook.office365.com
 (2603:10b6:408:ed::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 04:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Wed, 4 Feb 2026 04:44:04 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 22:44:03 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v2 06/11] drm/amdgpu: Fix is_dpm_running
Date: Wed, 4 Feb 2026 04:43:33 +0000
Message-ID: <20260204044338.96093-6-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
References: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|CY1PR12MB9650:EE_
X-MS-Office365-Filtering-Correlation-Id: d17721f0-9b09-4c42-7a31-08de63a8068b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kd3mt0hJu27qM0giSozLXO5qW4UHYeZngmmjzNaZqznmAhDUZQABaS5nCWCD?=
 =?us-ascii?Q?fuDitpWZGxRxbp94xqc9EKumgCwfOUGtkFyJrnX1a0xEu0EaCi6FZMnumFWv?=
 =?us-ascii?Q?5V4FWLgu9ZFJCvav85mAyzkvfDN+aQj2lzg9e84ElVXYwxhhVX810Eqjp3e1?=
 =?us-ascii?Q?WflotWo72XRyWI5at5TstK1o4QuE4PAOUz+vcnIJ6LDczQYwShy0WpinRoAa?=
 =?us-ascii?Q?h1BHGTXwWYGO76UkmXxIFCeSY+3ufBf5MCRPYj0qjI8o89Zh1oHu3XHxLYrT?=
 =?us-ascii?Q?24r/M0Fw+JJ8Zji022sfEsqnuB5qxAVQiv4CKSD0Bih5L6MYxn+GHMc0A8wr?=
 =?us-ascii?Q?vjEATHxyfCkcH5kjPua4PZKWcQQ8GuYWe2iPJrqZwESwYgIK/qYZu4y07tA0?=
 =?us-ascii?Q?hpL2kcFU4JsSv2tEyOxrPUEENxswpDwtfUpBbWg4JUEwm/hWa3Wm0uApySDJ?=
 =?us-ascii?Q?gM6NnCve0NNEH4dNojCkGFQqncSYVycKB+w+eYDPKgoaTp3VOOVPilkUNnNp?=
 =?us-ascii?Q?P35tkkaO7RqyTrb66phkHwPtBj+ms3EQELEfc2ydqPwr3a23GY/FIhdJWzvA?=
 =?us-ascii?Q?Pam8TxUFN40XMnsU+aafbAWeaWJYYcn3gAXBkscUYEGX8jtTD0TYKv6q6I1h?=
 =?us-ascii?Q?6SLSFF20+MpZsReQXh3Xo8Ag882AdDuchdoiloTLtwBg7v4aNQBVWlEyUHEC?=
 =?us-ascii?Q?zem73YXNCViIjc03N3US7lkIYzZ8/WKu6ITPtwQYDjonyZemOiglJ+Y68biu?=
 =?us-ascii?Q?MNjLP33FlGrinfgYsUTgdahHfw0NU8+vkI9QnNiDkaD4vMiQHmBhA3L+3pmm?=
 =?us-ascii?Q?WL2g8uQIrdW0lJFMELtx6+rvV/59AEVFN5RooFno88dmxztEdUM9RuGgtUWz?=
 =?us-ascii?Q?JqeOQD9nvm56JDlrPyTzVVCLPeg7+R/JAlpFVAWnrZSZNYGgYZnd+o1D3bDV?=
 =?us-ascii?Q?Ez1UuPZM6N5VrKDUKNYstCatlMMwWYmTG56fk00+wATsf7sd7F+IWwAYQpuD?=
 =?us-ascii?Q?qs/K1ednHCek7I3LNJ4qRGoUeqGDAN29NMsTHohv0pL43iEwOsbkXaVsZLga?=
 =?us-ascii?Q?3fP9rR4KTHWBUVPQAolEmwa4tbVADiHp2gc3Qs7t0jbLThf6IUVpiSINqbEq?=
 =?us-ascii?Q?wmFFFXon9xkFbmDsZUKuGkWI7BE9cVzGZnT4+oW2k7GWF0FuqLGknhQvjz+0?=
 =?us-ascii?Q?Yua+/eZ5gAsRG4M8tK9BUJCmdsKpEJBJX717g6S6TfclwR10PNunkn5jrrMl?=
 =?us-ascii?Q?O3UCKGJrq6Q0qD1kmCKG8ZYnfgIZGVSctEFHX8eubtn8wKqmdj5oSYWd+uPo?=
 =?us-ascii?Q?PdMtbFJ7laOQe+Lm/NXfKawJZZ6QbD9hkWai9mKtpvwgupTGIrmplyAcOFz3?=
 =?us-ascii?Q?ICfzB1nzGGMpOrJGVZbNvrSgdFck5rKI4GX5VhDDmARBuhOwn7bsJ0Ks30oH?=
 =?us-ascii?Q?C0+wXxnfZI1qF3Mloe+EkwIQ+FFlMK7IlYcxQ+aUDlE90Q1hL5ihiHFFnQ8u?=
 =?us-ascii?Q?zFfhPOM6ITvOWDPgKPD6Nrn1rU+qjdLeVaIfceiZfJmPoHez+JAxZP4dvdar?=
 =?us-ascii?Q?xjawCLiC6KLRicoGa/UYdxi0CtXSTJOKTKi1R15x8isGUb/f3fM8Zrs3GUu+?=
 =?us-ascii?Q?TmhQ1bYoQxKG7jQ9vOgZeHdF7E1FpMbAlFP/DHq3OTvWCM3o/hosxdYjh7w/?=
 =?us-ascii?Q?ILNIAQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XaUhAf9sKk8dYH4Ni4GiLvGigpvzKD496vpcy/zww1RZ9PXT+AnxsPDYREWDqTaTdLxcSbYpFUzE2phGBHd7WToQH0r0J+ibLkoFjnp+OjK54EzjBa9RoxVzIIaWPZXiA1KUkKkTYVK+8k9a1Qpt7jOi+/OarRy6WiU96RkORJku4rEKphfKs+tlheKV6BQ+YkzU/lrTpoWsDpRXuQ9Y3SXy1qdsUgYLGE2Lk1P5qv1xzdfixesHa9NnzOzWJZweTOlSNDiuUGzNcVl9QK+MpBAt6Iq/O0pRqTrNROBY+oiPX+dDner5NTS7kNKbbUZpceSSqbVBzZZM6CuB/5yZ90Lcjwnbx9cFPTROZgfRZZS8KGdxQcw2aTgTiP+kUb6WuRcDi10HXtnp9JaKWd1qaITc38VrFv4qqMtQPMLnxhV7iQa5zxb+0TnZZ4cPcqM0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 04:44:04.8221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d17721f0-9b09-4c42-7a31-08de63a8068b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9650
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

Use multi args for get_enabled_mask to fix is_dpm_running

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 35 +++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 2987ff1b13e4..f90d274c0f67 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -479,12 +479,43 @@ static int smu_v15_0_0_read_sensor(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v15_0_0_get_enabled_mask(struct smu_context *smu,
+					struct smu_feature_bits *feature_mask)
+{
+	uint32_t *feature_mask_high;
+	uint32_t *feature_mask_low;
+	int ret = 0;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+
+	if (!feature_mask)
+		return -EINVAL;
+
+	feature_mask_low = &((uint32_t *)feature_mask)[0];
+	feature_mask_high = &((uint32_t *)feature_mask)[1];
+
+	struct smu_msg_args args = {
+		.msg = SMU_MSG_GetEnabledSmuFeatures,
+		.num_args = 0,
+		.num_out_args = 2,
+	};
+
+	ret = ctl->ops->send_msg(ctl, &args);
+
+	if (ret)
+		return ret;
+
+	*feature_mask_low = args.out_args[0];
+	*feature_mask_high = args.out_args[1];
+
+	return ret;
+}
+
 static bool smu_v15_0_0_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	struct smu_feature_bits feature_enabled;
 
-	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
+	ret = smu_v15_0_0_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
 		return false;
@@ -1356,7 +1387,7 @@ static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
 	.is_dpm_running = smu_v15_0_0_is_dpm_running,
 	.set_watermarks_table = smu_v15_0_0_set_watermarks_table,
 	.get_gpu_metrics = smu_v15_0_0_get_gpu_metrics,
-	.get_enabled_mask = smu_cmn_get_enabled_mask,
+	.get_enabled_mask = smu_v15_0_0_get_enabled_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_driver_table_location = smu_v15_0_set_driver_table_location,
 	.gfx_off_control = smu_v15_0_gfx_off_control,
-- 
2.43.0

