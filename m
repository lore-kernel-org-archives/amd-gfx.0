Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E60C369C2
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 18:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4A4310E33A;
	Fri, 25 Apr 2025 18:39:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DUoU7bdT";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4466710E348
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 18:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bx3rLSE7TlCj+rVugFKIVGOysezAnyAn1zF87BLEddHzMnMW3ejJIsB7QW+1DcwViF88JrlNcoai0i/ILbx13uvnfhjb8Lu/Sa7ufcJWeMweZqGYiuUVWH8a+Yn16e/niphW10IYB/QIxLW3zqDhOcxQUyOkhaxjqCetPU+h6CBflFlR/z2mkge8TA03j1nll9ZySX3GbiesEPRJyLLiJ7oiXa6fy0M6j8dM3lmP2/gO9or94SJLEAfd1fMLNIxN0U0f7YZKaGEibDweRNMktThnnkGW7iAyIUeY+FYRGTRJhUN+N/jM5uI34QI1NuuKpY3up6698aLQIe8MfwpahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgDgVDlzoYLoMgrhZT/cPY1799nwT9F2FKvUbJg1/LU=;
 b=dHkM1lombXaANRwTQDQHagbTxmUOUB5LDKWm9FU1dB6cc0S5Fe4SODHduBTz5YRwtbVQBBO5jcXIw3YPPZ1sfEBuXIMIiW6rtm2ki8T2P2/I7A4URmVelxfZcrVhd/xUq6EOtNJshROwwY6SDmcUAau79rMQV5RM1tToMi+ipSNPoxK5AVs+PvjsZIklV4WuUfuAxT1zEH6GK4GKJC6EX379gclNg+s9naVQMIleCbAvkUoQ4y/MnWJD3aDsm0jqi9/m+UnXmAd1B95Z2dgmj+1LdP6M/NrgPUvZu0owFwmSOpS+0FE68fbKHCDstEbdSLqvcmFcqHk7JEtTfHckhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgDgVDlzoYLoMgrhZT/cPY1799nwT9F2FKvUbJg1/LU=;
 b=DUoU7bdTGhcn8SFG4gqvTPiyB61jWpuNOjYlUzbaQgJAUBVYIbXNUrLFI7TNgkyUkhSQPKEiqlvmnrTALbSaxTaBBaUl4L5tXvlIxSILUL4gSjFUPSiNeM7VHVtJT0lo9cfk306lrflEpbN4opQCUiP5IYzTjaMrDDyTXNpTPJA=
Received: from DS7PR03CA0330.namprd03.prod.outlook.com (2603:10b6:8:2b::22) by
 MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 18:39:09 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::6f) by DS7PR03CA0330.outlook.office365.com
 (2603:10b6:8:2b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Fri,
 25 Apr 2025 18:39:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 18:39:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 13:39:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/9] drm/amdgpu/mes: consolidate on a single mes reset callback
Date: Fri, 25 Apr 2025 14:38:48 -0400
Message-ID: <20250425183855.165199-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425183855.165199-1-alexander.deucher@amd.com>
References: <20250425183855.165199-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf4cc8c-58a7-426a-1710-08dd8428773c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LZSyXvlUKx2j20hhmVsRqfRGXkzvhW7hWXW5Y+dG3VfwfEWZ2Lszg3TGotz0?=
 =?us-ascii?Q?OzNMavXS1UrsZxZPXVlShFk+/GzXeKvtjRoP0RV6Ez8tS6lZeET/3NssROJp?=
 =?us-ascii?Q?J+qyTUkjx3aYBpVqU8zdcWNwQUqckZ0XiO7OpRDvuVGAkWDE+RUjOnmb+MRr?=
 =?us-ascii?Q?LPrn5CNatHOQokxLfhoSYYZ9IO0aB0e6KAoil8TnrUK/textSD7KyfF1O7+V?=
 =?us-ascii?Q?/BgbaaF9V6iJvEu55yUeDyi5GmizWXTJmkgAhAmJ3v/FrmlQC9QTFudbNhEA?=
 =?us-ascii?Q?7cdoJA6X87Z9UuJqGnIa/9MU0XncjjTqI6rRRDp/20iW5VRBKHFD8rBN/pv6?=
 =?us-ascii?Q?WVqAuEKvfImEWlU2upwPKpK9fLKKTGOtXinBbekQnE44glWHPYdYkAiuomBv?=
 =?us-ascii?Q?GnnE6755uHen3b0wAqt54TuRilhzR1lQgZkc4PVCUCPbolKotKGKfnHqUhqA?=
 =?us-ascii?Q?r4jvjG3OtGWfSPlgkPAZ2KGxa3gWLWKW61PpBHlqCWdiWkaTjHTK2YRNtNP0?=
 =?us-ascii?Q?m8yHF9OYpIVeBAkdnYJCXI7fnwwkUHy+zZ+jugN2bNSEsVdDTu6uc4u/GOit?=
 =?us-ascii?Q?ak5WsSOhx64ytC3JY1StahAiIcGw2jhLqGbaUGtFlj95HxNq+z6Tzmtvh2Qq?=
 =?us-ascii?Q?47RxuTaW5OGQl97ZxKFp9KntFu0ymrscgz4S7dSgYhuPplO5U0zKG/kzRqWC?=
 =?us-ascii?Q?+hOW//CMXCpnT4NE1XzM/qSu1k03aFNHDCleynkpunfOPAtp7u6wuaBqbnWE?=
 =?us-ascii?Q?gjpilJRhiJhs+jOrt48U0WNLEWqVqckjY2lRoPGBwyHNMwezlzrzgMtkOIEH?=
 =?us-ascii?Q?qzat0U5il0YhTuvlsrqsyXeShwV3Tm+RRA8vnk73Hap4StQ2yIte79JyG6SK?=
 =?us-ascii?Q?cbWVhL+deH+4O3379o33GjvuXefw6Cefb40wdQvl5dnlOw9DOScmNPT80Y/F?=
 =?us-ascii?Q?X7J0hlLgCvfzYIFK9Op4LGeBPezCp0i2qp39Cl75msbxqphSFMLnr7L7SfEU?=
 =?us-ascii?Q?F2uXcn5BieyMJ7W+ctA1CdjBCh1gKtPV3Mkg04cBYusiLX0my1qvfIQh4nN1?=
 =?us-ascii?Q?3vBeYu09JbulroYzpZQwjgyXVFCcLy/R3GR0hx+8/1/zlMfLGWII9hhiCxkj?=
 =?us-ascii?Q?aZLkPhSvp67KLJgH9CTmX7OC7A1BcqRoZUv7OaO/kve57ow5syFMyRho1qQC?=
 =?us-ascii?Q?0tTp7AMHH4a8UjYrALmtpqu8sjMLUpYFA/srjoxIJmKdgcXnbUjuanFK1ZcI?=
 =?us-ascii?Q?jQ3wfDU12YZAAYZ1yFJ+lW2XcHi9mbImv4ExqaaWqM0lJMkp0LCazB1ozuFg?=
 =?us-ascii?Q?3D9BXOv5rwP1aIdQfDzV985JIfAzrLwtI2TPIENA8L0WSWEG0HYZMPLOzRpr?=
 =?us-ascii?Q?081tS0aZrfWnotKjbg0RBdx/hKhVPTCZC2X7q040NlCQJWvVlWWMf01rT363?=
 =?us-ascii?Q?UK8qIy2VpxCz6LXW9yo39HlFX4yje30ftEJK0jp/G284Lh+/fIR3pHrj9eJk?=
 =?us-ascii?Q?jjP3vEXjjL+mg8Gd8pPfEVK7GaKs4xaqCvly?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:39:08.9682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf4cc8c-58a7-426a-1710-08dd8428773c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
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

Use the legacy one as it covers both kernel queues and
user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 7 ++++---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 8 ++++----
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index b5a7e2ae72aff..be6f3a0e8d438 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -335,7 +335,7 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 				  unsigned int vmid,
 				  bool use_mmio)
 {
-	struct mes_reset_legacy_queue_input queue_input;
+	struct mes_reset_queue_input queue_input;
 	int r;
 
 	memset(&queue_input, 0, sizeof(queue_input));
@@ -349,8 +349,10 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 	queue_input.wptr_addr = ring->wptr_gpu_addr;
 	queue_input.vmid = vmid;
 	queue_input.use_mmio = use_mmio;
+	if (ring->funcs->type == AMDGPU_RING_TYPE_GFX)
+		queue_input.legacy_gfx = true;
 
-	r = adev->mes.funcs->reset_legacy_queue(&adev->mes, &queue_input);
+	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
 	if (r)
 		DRM_ERROR("failed to reset legacy queue\n");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index af6e341f6411e..e98b0d892a593 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -266,7 +266,7 @@ struct mes_resume_gang_input {
 	uint64_t	gang_context_addr;
 };
 
-struct mes_reset_legacy_queue_input {
+struct mes_reset_queue_input {
 	uint32_t                           queue_type;
 	uint32_t                           doorbell_offset;
 	bool                               use_mmio;
@@ -276,6 +276,7 @@ struct mes_reset_legacy_queue_input {
 	uint64_t                           mqd_addr;
 	uint64_t                           wptr_addr;
 	uint32_t                           vmid;
+	bool                               legacy_gfx;
 };
 
 enum mes_misc_opcode {
@@ -363,8 +364,8 @@ struct amdgpu_mes_funcs {
 	int (*misc_op)(struct amdgpu_mes *mes,
 		       struct mes_misc_op_input *input);
 
-	int (*reset_legacy_queue)(struct amdgpu_mes *mes,
-				  struct mes_reset_legacy_queue_input *input);
+	int (*reset_hw_queue)(struct amdgpu_mes *mes,
+			      struct mes_reset_queue_input *input);
 };
 
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 5ce62a3f01e7d..c9eba537de094 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -746,8 +746,8 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
 }
 
-static int mes_v11_0_reset_legacy_queue(struct amdgpu_mes *mes,
-					struct mes_reset_legacy_queue_input *input)
+static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
+				    struct mes_reset_queue_input *input)
 {
 	union MESAPI__RESET mes_reset_queue_pkt;
 
@@ -765,7 +765,7 @@ static int mes_v11_0_reset_legacy_queue(struct amdgpu_mes *mes,
 	mes_reset_queue_pkt.queue_type =
 		convert_to_mes_queue_type(input->queue_type);
 
-	if (mes_reset_queue_pkt.queue_type == MES_QUEUE_TYPE_GFX) {
+	if (input->legacy_gfx) {
 		mes_reset_queue_pkt.reset_legacy_gfx = 1;
 		mes_reset_queue_pkt.pipe_id_lp = input->pipe_id;
 		mes_reset_queue_pkt.queue_id_lp = input->queue_id;
@@ -791,7 +791,7 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.suspend_gang = mes_v11_0_suspend_gang,
 	.resume_gang = mes_v11_0_resume_gang,
 	.misc_op = mes_v11_0_misc_op,
-	.reset_legacy_queue = mes_v11_0_reset_legacy_queue,
+	.reset_hw_queue = mes_v11_0_reset_hw_queue,
 };
 
 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index a3391810c897c..f9f2fbc0a7166 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -836,8 +836,8 @@ static void mes_v12_0_enable_unmapped_doorbell_handling(
 	WREG32_SOC15(GC, 0, regCP_UNMAPPED_DOORBELL, data);
 }
 
-static int mes_v12_0_reset_legacy_queue(struct amdgpu_mes *mes,
-					struct mes_reset_legacy_queue_input *input)
+static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
+				    struct mes_reset_queue_input *input)
 {
 	union MESAPI__RESET mes_reset_queue_pkt;
 	int pipe;
@@ -856,7 +856,7 @@ static int mes_v12_0_reset_legacy_queue(struct amdgpu_mes *mes,
 	mes_reset_queue_pkt.queue_type =
 		convert_to_mes_queue_type(input->queue_type);
 
-	if (mes_reset_queue_pkt.queue_type == MES_QUEUE_TYPE_GFX) {
+	if (input->legacy_gfx) {
 		mes_reset_queue_pkt.reset_legacy_gfx = 1;
 		mes_reset_queue_pkt.pipe_id_lp = input->pipe_id;
 		mes_reset_queue_pkt.queue_id_lp = input->queue_id;
@@ -887,7 +887,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.suspend_gang = mes_v12_0_suspend_gang,
 	.resume_gang = mes_v12_0_resume_gang,
 	.misc_op = mes_v12_0_misc_op,
-	.reset_legacy_queue = mes_v12_0_reset_legacy_queue,
+	.reset_hw_queue = mes_v12_0_reset_hw_queue,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.49.0

