Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9398C021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 19:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E59D10E9D4;
	Wed, 26 Feb 2025 19:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wZbSK2KY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23EAF10E9D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 19:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBGXnFkhKmZqIKS9BuRdBgRtFLkGazhF0hGROkKQL9XJtrYFsUe2Gi4QPfDlaG0WG6y8yk6zumoWUGv1VlM6JydQoJ4nr5RcYMeb/BrCOj2uNKKXWxJ6rI8l3IDJocmAPjE49YWVE24Wn5jOYkj/qj5/BqX84+WLMprAmUE9galDAcYTc3vXyRokAnMsWAHQa+pPPPq2egf3cIw+7CBng9Q+Up46bwhsGEZzEDKn6IEqS0fK4JuOCvCzvxVTaD3ZLHeNoRgt7ixQh8xIQQQee3tOJ+GDtaxUWPS1SABOtX8NBgan5OGeJcr14hF8zKi1UfFvalcaA3gNRZ3pwrawGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGSCFUylY1/lAtTvtSKqi5ETpHUovLhvYdsdn3BbOpI=;
 b=nTbcp7b5T8yDwQZDJJ6AVrU82D+6LBSplhtDxbnhyEqNkBFUCECHQ7WhhgE1FnJ5U2Qcu8dva0/r8U8V2WPxDxOzVE7OyNB9XShnJWvOwMRab8YFqIyLCJeln+ny4gu4zFtChYSB5fu4QfhMj3pEzD+Kq5gFIy3pAmoCS3/AKeJUCywTEaWu5g5igOZl7/Z3/Z+xJJWYwgDqbEmVy1XwNdgbYEqDQFcczR/1i9icxiQpfvsUaalChLBPT8DF8tzX7HU0PyOR5/mLC3iH3LP8RLzu3xwQH+JpYX0mz9myIxOcZD3P7mncehCi6LZahCovCcmjeFi/FPj6jF2d/7FIVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGSCFUylY1/lAtTvtSKqi5ETpHUovLhvYdsdn3BbOpI=;
 b=wZbSK2KYTcJP8LbbYo5bphCv7uKi6C/MxdcHgp7kSqEOR8wVJNB92/1gC/IyqY9TR1Ic3AT2CUriSKhQj+dgwbiadtP9Aakr5Tv0AvtgvKGfL26pWpI1IVz2+FLCZDhamwGKURs+ComcIECkkFkmjb+pzvhForBLVlE92A+F1Is=
Received: from BYAPR06CA0039.namprd06.prod.outlook.com (2603:10b6:a03:14b::16)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Wed, 26 Feb
 2025 19:23:29 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::4f) by BYAPR06CA0039.outlook.office365.com
 (2603:10b6:a03:14b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Wed,
 26 Feb 2025 19:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 19:23:28 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Feb 2025 13:23:24 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Reduce dequeue retry timeout for gfx9 family
Date: Wed, 26 Feb 2025 14:23:03 -0500
Message-ID: <20250226192303.48552-2-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226192303.48552-1-Harish.Kasiviswanathan@amd.com>
References: <20250226192303.48552-1-Harish.Kasiviswanathan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: e99ae2a1-9bda-4598-6602-08dd569b0c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7mYT1YDrilYF6Pu/NiCWxSVLCExMOU1DCdkF7utcoMiQetogFYNxBAHxanVr?=
 =?us-ascii?Q?RbvveOkhy1z91rdAuL5p3f64Lq+5rkyzJoaTJD0In0Ni2zbxgW5d6+EpTPhH?=
 =?us-ascii?Q?Kcz0Ykr0BBuPzUlZHEA6qUeQ3gvD2maCbUEBR0hvMQp3izWedzp7fL08gAXu?=
 =?us-ascii?Q?RWyY4Q/Xm3R/r8ENou9D1z0UZMqMkzYDvY51D600put81S/Us61ink3fubpN?=
 =?us-ascii?Q?Cr/sUoymbV8RHw8HzORoHonRTGVFX5bJM+Voq2yvZRV/I3fzbMsvI3WEACif?=
 =?us-ascii?Q?S/BV6J403kfVfKh8DnigqIMda/EpLpZYi1VrVv9ICSwUfQ58b5VZxSHBF7CB?=
 =?us-ascii?Q?LIT0cBUWBYT3w0j6TeWuGifO1ZLxwkLFt7YfHqVXp8KzKeuWpk9Sl0bXH8O4?=
 =?us-ascii?Q?mg7Xn5j/huW4tkVLctpS8catJSRG1B7MWkk3jrgbhZNqRFF7dxbfe2+oGmSv?=
 =?us-ascii?Q?GPlwAqmuB8jht2u9L+bPvB9qL9qfTth0xnOa4J4S6Y5IAjgWPZTN+settUmX?=
 =?us-ascii?Q?ZrM7fd+ymGljJygUBeLItqnsMKI1DZStgwFBfHRXc1WFJ/9Bsj7RiFmb+OXh?=
 =?us-ascii?Q?y32JCIB5ItgXaE6xgBPaFHRDMXeXni32UhFR0Qs3Hfn9cBgyWQzg5KxiDv7p?=
 =?us-ascii?Q?STnVI98r9B3MThROl1a8cqaRUQ/lA/4HB9dG4uFjCQcDEanIfYZUXAax7IGO?=
 =?us-ascii?Q?SpqaDpn2XgrX0NJ+HPkSqv1nrA5FjhAc/vufUDIMCsTrnzEgrPTtJP7pdat0?=
 =?us-ascii?Q?OdfIaIP6wiULm5kiWozodiAZip+qe/EdHD8xaajWnRPIdCxkG5L10X/zDaw1?=
 =?us-ascii?Q?Ln6kmt2wCnLPAN6AhPb+qllJupn7hqYzFbWszgvwxZD6VyFxwXn9UUBoPV0D?=
 =?us-ascii?Q?sJQAq4excNJithB+oXKjgiozduu/XymUGYomDkSF9CdZPin2ej4YlUtBv+En?=
 =?us-ascii?Q?Pc9Ye7wbmVDnEQl/Nw2i/95zPx4RjKCbEyaGnyKZ3qL0mnYBzWOO2SqlMOJa?=
 =?us-ascii?Q?ZrEBMkh0d2pIyc0sPJZC6bJoFLQHRPxBg0qOoy3Wd0vBThJKhkLvVK7MVxpd?=
 =?us-ascii?Q?grkk1b6L8tN74YtHFEW1zouPikDZQ+XhsMfvyQLzGJDBBNEjMlG8cO3rvl9a?=
 =?us-ascii?Q?iVv9Q6womUiMKDuW+m6y9HFQOMH7Rias4EKgcmuOKQrjhz9xKm/OVSOaOcqg?=
 =?us-ascii?Q?iMRXpq21F4gBLKv5cX7trwnWMrdQddQJQQCu0L0HZsooBzYhnAFrqxlMAdEt?=
 =?us-ascii?Q?15ehgdpPY/VXjBTmZp9VqDQmDtLMo2nkpah7B8sF6FvHZZbBpOXm0NQsd6J2?=
 =?us-ascii?Q?pqRo/o+6HgR9hzEJO42OSDQd5JGVlpWOc4M0RNDBRcFHEcxJDQz9MRTbnaI3?=
 =?us-ascii?Q?U0jdOytYn4yeVKmjc2wystPPTo4rd7b58oUfnYzfYaWcY7Eph6+V0aRPlfM4?=
 =?us-ascii?Q?whlb4MXKIT8cOXzpH4R3xdU+9kbFXdR0/SkteUfW21ty4jnNMcVLCixYdm/h?=
 =?us-ascii?Q?wMDIhL+srkUFukA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 19:23:28.3094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e99ae2a1-9bda-4598-6602-08dd569b0c67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144
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

Dequeue retry timeout controls the interval between checks for unmet
conditions. On MI series, reduce this from 0x40 to 0x1 (~ 1 uS). The
cost of additional bandwidth consumed by CP when polling memory
shouldn't be substantial.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |  2 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  2 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  4 +--
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 28 ++++++++---------
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |  5 +--
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 28 ++++++++---------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  5 +--
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 31 ++++++++++++++-----
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  5 +--
 10 files changed, 65 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index 8dfdb18197c4..53f5f1885870 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -189,7 +189,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.set_address_watch = kgd_gfx_aldebaran_set_address_watch,
 	.clear_address_watch = kgd_gfx_v9_clear_address_watch,
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
-	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
+	.build_dequeue_wait_counts_packet_info = kgd_gfx_v9_build_dequeue_wait_counts_packet_info,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
 	.hqd_reset = kgd_gfx_v9_hqd_reset,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 9abf29b58ac7..6fd41aece7e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -415,7 +415,7 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 	.set_address_watch = kgd_gfx_v9_set_address_watch,
 	.clear_address_watch = kgd_gfx_v9_clear_address_watch,
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
-	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
+	.build_dequeue_wait_counts_packet_info = kgd_gfx_v9_build_dequeue_wait_counts_packet_info,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index e2ae714a700f..95f249896275 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -530,8 +530,8 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
 	.program_trap_handler_settings =
 				kgd_gfx_v9_program_trap_handler_settings,
-	.build_grace_period_packet_info =
-				kgd_gfx_v9_build_grace_period_packet_info,
+	.build_dequeue_wait_counts_packet_info =
+				kgd_gfx_v9_build_dequeue_wait_counts_packet_info,
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.enable_debug_trap = kgd_aldebaran_enable_debug_trap,
 	.disable_debug_trap = kgd_gfx_v9_4_3_disable_debug_trap,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 62176d607bef..0b03f2e9a858 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -1021,25 +1021,25 @@ void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
 	*wait_times = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2));
 }
 
-void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
+void kgd_gfx_v10_build_dequeue_wait_counts_packet_info(struct amdgpu_device *adev,
 						uint32_t wait_times,
-						uint32_t grace_period,
+						uint32_t sch_wave,
+						uint32_t que_sleep,
 						uint32_t *reg_offset,
 						uint32_t *reg_data)
 {
 	*reg_data = wait_times;
 
-	/*
-	 * The CP cannont handle a 0 grace period input and will result in
-	 * an infinite grace period being set so set to 1 to prevent this.
-	 */
-	if (grace_period == 0)
-		grace_period = 1;
-
-	*reg_data = REG_SET_FIELD(*reg_data,
-			CP_IQ_WAIT_TIME2,
-			SCH_WAVE,
-			grace_period);
+	if (sch_wave)
+		*reg_data = REG_SET_FIELD(*reg_data,
+				CP_IQ_WAIT_TIME2,
+				SCH_WAVE,
+				sch_wave);
+	if (que_sleep)
+		*reg_data = REG_SET_FIELD(*reg_data,
+				CP_IQ_WAIT_TIME2,
+				QUE_SLEEP,
+				que_sleep);
 
 	*reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
 }
@@ -1109,7 +1109,7 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 	.set_address_watch = kgd_gfx_v10_set_address_watch,
 	.clear_address_watch = kgd_gfx_v10_clear_address_watch,
 	.get_iq_wait_times = kgd_gfx_v10_get_iq_wait_times,
-	.build_grace_period_packet_info = kgd_gfx_v10_build_grace_period_packet_info,
+	.build_dequeue_wait_counts_packet_info = kgd_gfx_v10_build_dequeue_wait_counts_packet_info,
 	.program_trap_handler_settings = program_trap_handler_settings,
 	.hqd_get_pq_addr = kgd_gfx_v10_hqd_get_pq_addr,
 	.hqd_reset = kgd_gfx_v10_hqd_reset
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
index 9efd2dd4fdd7..89ae07288b10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
@@ -51,9 +51,10 @@ uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
 void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
 				uint32_t *wait_times,
 				uint32_t inst);
-void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
+void kgd_gfx_v10_build_dequeue_wait_counts_packet_info(struct amdgpu_device *adev,
 					       uint32_t wait_times,
-					       uint32_t grace_period,
+					       uint32_t sch_wave,
+					       uint32_t que_sleep,
 					       uint32_t *reg_offset,
 					       uint32_t *reg_data);
 uint64_t kgd_gfx_v10_hqd_get_pq_addr(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index c718bedda0ca..2c5f22838fe0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -673,7 +673,7 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
 	.set_vm_context_page_table_base = set_vm_context_page_table_base_v10_3,
 	.program_trap_handler_settings = program_trap_handler_settings_v10_3,
 	.get_iq_wait_times = kgd_gfx_v10_get_iq_wait_times,
-	.build_grace_period_packet_info = kgd_gfx_v10_build_grace_period_packet_info,
+	.build_dequeue_wait_counts_packet_info = kgd_gfx_v10_build_dequeue_wait_counts_packet_info,
 	.enable_debug_trap = kgd_gfx_v10_enable_debug_trap,
 	.disable_debug_trap = kgd_gfx_v10_disable_debug_trap,
 	.validate_trap_override_request = kgd_gfx_v10_validate_trap_override_request,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 441568163e20..d2bbe9973c93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1077,25 +1077,25 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
 				adev->gfx.cu_info.max_waves_per_simd;
 }
 
-void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
+void kgd_gfx_v9_build_dequeue_wait_counts_packet_info(struct amdgpu_device *adev,
 		uint32_t wait_times,
-		uint32_t grace_period,
+		uint32_t sch_wave,
+		uint32_t que_sleep,
 		uint32_t *reg_offset,
 		uint32_t *reg_data)
 {
 	*reg_data = wait_times;
 
-	/*
-	 * The CP cannot handle a 0 grace period input and will result in
-	 * an infinite grace period being set so set to 1 to prevent this.
-	 */
-	if (grace_period == 0)
-		grace_period = 1;
-
-	*reg_data = REG_SET_FIELD(*reg_data,
-			CP_IQ_WAIT_TIME2,
-			SCH_WAVE,
-			grace_period);
+	if (sch_wave)
+		*reg_data = REG_SET_FIELD(*reg_data,
+				CP_IQ_WAIT_TIME2,
+				SCH_WAVE,
+				sch_wave);
+	if (que_sleep)
+		*reg_data = REG_SET_FIELD(*reg_data,
+				CP_IQ_WAIT_TIME2,
+				QUE_SLEEP,
+				que_sleep);
 
 	*reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
 }
@@ -1254,7 +1254,7 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.set_address_watch = kgd_gfx_v9_set_address_watch,
 	.clear_address_watch = kgd_gfx_v9_clear_address_watch,
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
-	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
+	.build_dequeue_wait_counts_packet_info = kgd_gfx_v9_build_dequeue_wait_counts_packet_info,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index b6a91a552aa4..54ee8992be5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -97,9 +97,10 @@ uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
 void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev,
 				uint32_t *wait_times,
 				uint32_t inst);
-void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
+void kgd_gfx_v9_build_dequeue_wait_counts_packet_info(struct amdgpu_device *adev,
 					       uint32_t wait_times,
-					       uint32_t grace_period,
+					       uint32_t sch_wave,
+					       uint32_t que_sleep,
 					       uint32_t *reg_offset,
 					       uint32_t *reg_data);
 uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 9cb21af1d0af..f9c302732773 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -298,13 +298,14 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 }
 
 static inline void pm_build_dequeue_wait_counts_packet_info(struct packet_manager *pm,
-			uint32_t sch_value, uint32_t *reg_offset,
+			uint32_t sch_value, uint32_t que_sleep, uint32_t *reg_offset,
 			uint32_t *reg_data)
 {
-	pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
+	pm->dqm->dev->kfd2kgd->build_dequeue_wait_counts_packet_info(
 		pm->dqm->dev->adev,
 		pm->dqm->wait_times,
 		sch_value,
+		que_sleep,
 		reg_offset,
 		reg_data);
 }
@@ -320,26 +321,40 @@ static int pm_config_dequeue_wait_counts_v9(struct packet_manager *pm,
 
 	switch (cmd) {
 	case KFD_DEQUEUE_WAIT_INIT:
+		uint32_t sch_wave = 0, que_sleep = 0;
+		/* Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default 0x40.
+		 * On a 1GHz machine this is roughly 1 microsecond, which is
+		 * about how long it takes to load data out of memory during
+		 * queue connect
+		 * QUE_SLEEP: Wait Count for Dequeue Retry.
+		 */
+		if (KFD_GC_VERSION(pm->dqm->dev) >= IP_VERSION(9, 4, 1) &&
+		    KFD_GC_VERSION(pm->dqm->dev) < IP_VERSION(10, 0, 0))
+			que_sleep = 1;
+
 		/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
 		if (amdgpu_emu_mode == 0 && pm->dqm->dev->adev->gmc.is_app_apu &&
 		   (KFD_GC_VERSION(pm->dqm->dev) == IP_VERSION(9, 4, 3)))
-			pm_build_dequeue_wait_counts_packet_info(pm, 1, &reg_offset, &reg_data);
-		else
-			return 0;
+			sch_wave = 1;
+
+		pm_build_dequeue_wait_counts_packet_info(pm, sch_wave, que_sleep,
+			&reg_offset, &reg_data);
+
 		break;
 	case KFD_DEQUEUE_WAIT_RESET:
 		/* function called only to get reg_offset */
-		pm_build_dequeue_wait_counts_packet_info(pm, 0, &reg_offset, &reg_data);
+		pm_build_dequeue_wait_counts_packet_info(pm, 0, 0, &reg_offset, &reg_data);
 		reg_data = pm->dqm->wait_times;
 		break;
 
 	case KFD_DEQUEUE_WAIT_SET_SCH_WAVE:
 		/* The CP cannot handle value 0 and it will result in
-		 * an infinite grace period being set so set to 1 to prevent this.
+		 * an infinite grace period being set so set to 1 to prevent this. Also
+		 * avoid debugger API breakage as it sets 0 and expects a low value.
 		 */
 		if (!value)
 			value = 1;
-		pm_build_dequeue_wait_counts_packet_info(pm, value, &reg_offset, &reg_data);
+		pm_build_dequeue_wait_counts_packet_info(pm, value, 0, &reg_offset, &reg_data);
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index e3e635a31b8a..4f79e707bc80 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -313,9 +313,10 @@ struct kfd2kgd_calls {
 	void (*get_iq_wait_times)(struct amdgpu_device *adev,
 			uint32_t *wait_times,
 			uint32_t inst);
-	void (*build_grace_period_packet_info)(struct amdgpu_device *adev,
+	void (*build_dequeue_wait_counts_packet_info)(struct amdgpu_device *adev,
 			uint32_t wait_times,
-			uint32_t grace_period,
+			uint32_t sch_wave,
+			uint32_t que_sleep,
 			uint32_t *reg_offset,
 			uint32_t *reg_data);
 	void (*get_cu_occupancy)(struct amdgpu_device *adev,
-- 
2.34.1

