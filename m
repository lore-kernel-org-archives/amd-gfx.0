Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D6CE77199
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 22:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E1CF10EC94;
	Wed,  8 Jan 2025 22:56:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gNUiY/20";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8476710EC94
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 22:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQlH1j8YO5EBgpOjgJ3LhmeQ6vlFvJQVyAfnQmwLLXQTc9F2ZM6qSEPD/uz8AJ1PbfagSa/MfTgSDgT1/dJrFpxxFIB003KLyq0ExHPMyfX+n8MHJ6yNEP05zfOhVg1frOzBMiyikceb9Qw7GHOKcJABaxBAhS08oXax7H/I5pmASCWDpegweioagEDh57xZHL2MZsN6ibxs29vTeoutjZQjXM43wDraQZBTMw/t09LCsebm22ldfOuzsgGjbrGMu5w2n2yJQWsYNfB39edA47iCDxEfzeqqYGmeD0S1wB3SM+Tr0Nh0W1I1niDQBj8Sw8UB7g+aqTWLFDF38ZGApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JrFmR4Ow/SuCwknBqGdPl+B1tbzHRIFtggev6dOP50=;
 b=Xe6q4aSTuviON6WCtCvaTmmZWd0UpSLck38YrccTEp2Heu9RgjJtodD6aWddUNrhBSop6CJHMgHsqX0E53nUkPBSHt9fulqRgaGFJRbOHjZbZffQdkpo6V60WjLPIHd9oQqtr3wdDBbByNmencO6N7jNeq6QaNSoVLsiTglrObCrGxYzRCeYOAQSfmAvzc4Hl2XinymEKdQI/xNJN5d3l0Z+N115fBtf15E9/vLp/AuQTJU37YIknzzJ8EobCHqkezoApUjo4BMohzIfzszGptxYADZmqMokp5bTx/O9K2aBtUYt3lNP5xFG3wIWJZic6tUMLODf5cxutMcAODAT1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JrFmR4Ow/SuCwknBqGdPl+B1tbzHRIFtggev6dOP50=;
 b=gNUiY/2076wLZmJWqb1JidQ2D/PKHBkDBU7IaLWzgOqj1XGZe3oFuWwOe9xOWqKxns+lKXKLbf4/XVp0ym+o9/IdldRg7lD3jvkz9UnOb9SUZkUAGUTeirkHcgRbk/tCryUtd0C/xDybqDjQxh2oYnpZeEgmiyo80X15yrP6BtY=
Received: from PH3PEPF0000409C.namprd05.prod.outlook.com (2603:10b6:518:1::48)
 by DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.12; Wed, 8 Jan 2025 22:56:47 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH3PEPF0000409C.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Wed,
 8 Jan 2025 22:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Wed, 8 Jan 2025 22:56:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 16:56:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <aurabindo.pillai@amd.com>, <kenneth.feng@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: add dynamic workload profile switching for
 gfx11
Date: Wed, 8 Jan 2025 17:56:25 -0500
Message-ID: <20250108225627.14063-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108225627.14063-1-alexander.deucher@amd.com>
References: <20250108225627.14063-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DS0PR12MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: bd3a90c2-20fe-4e33-4951-08dd3037bab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ro8ozY49Z3UOWpnlTKZJo9PMhhKX9Ad5s3doFU5tcFvQX+0OtGCAV8Z5j0R7?=
 =?us-ascii?Q?AswSqPT9IvruXO0ZW0MpTH+L7Ppn/9cQl9ntFewZJ49byvhz4zvtw84/W+N8?=
 =?us-ascii?Q?oKokpOMAWAb079yStTNG0aZcafLnJHf2B5cfpjkZ/KFNnxYZr7LZqXwHv+rI?=
 =?us-ascii?Q?xKGRBPTD0QxZbt77x0iF2uMA2qs11jf1WaZAI44FVago/IikDxrJyutHk4Qw?=
 =?us-ascii?Q?YT+GAMm7qnufx4UZ9KXEOq5KkbirV01+S85VhtTqJ/CxaIjh2YrNcJ0PsxRN?=
 =?us-ascii?Q?zmR69kABM1Je9q71o2Bzfdh7cwEuXxiCCQFaB+hc03Wya6dkr/U07oH14gF+?=
 =?us-ascii?Q?atbw2JmXb9v0erLc/Iod8WjrBv5K/AKa2fdB1pTt1rTHiYB1bD+y/k/HfeZf?=
 =?us-ascii?Q?LLLMTjSDjvpJes9YLmgHm6icKdvxggz1GfPFU+TGALS9y8sV+VVIZ4UHsDh8?=
 =?us-ascii?Q?lfFVlamJPIT+GIBVZLiOk86+yVpqj5GTHVJEnlX2rAkjg1rbo0T4GdTQ2h67?=
 =?us-ascii?Q?D8Ay/5NQWYbdbh9twdXHNBqQFWD2RrEW0w4UsSDZRcU66YEB5rtHyYtb+1ER?=
 =?us-ascii?Q?xXC9eDNBcmntgnKl87OjpwKZbdSM350kgIV83FudOe+rI0YRrYiIHTStqG/9?=
 =?us-ascii?Q?mPtBrwr0jhRZEVxp45r/+pLRqWM392sPOB0+iJUDtOMSbJDyVo8CknKHOUc7?=
 =?us-ascii?Q?cGhKO87oM4l/gU2EwhFqEIad2s876jHnBcPHVbwLuPfhS7xUKyIimq+oDpq1?=
 =?us-ascii?Q?DVnjhCaYMQCR7lMrbEJq4SNpVYE0YiokWtz18lhBUOUdHs0KztbuPEHNJ/76?=
 =?us-ascii?Q?BiYOa3uOCSW6HMxyvfU1s8CPOxszpjecF1dq8NTmNUuZTwKTqUfqfeN5U8DQ?=
 =?us-ascii?Q?toVlOUYv15IFfXQH13tNiEbsjp5N+4ofx7r+DwHQPKuHzwOrjaepDJPkumML?=
 =?us-ascii?Q?mcHHYqR+A2InNgWJllmRAC/Ey1oNvgy+NkiAtCe7FRNKLZ43JhiUu6gpRMjr?=
 =?us-ascii?Q?r/o8lR9MSG7OmDhn5zJoU24hghGi17VK+FjtNSSMjS87KFnXd+t8YOF7s82+?=
 =?us-ascii?Q?9pxaIifFykQheSCiOSdV2ov1M13Gf6QcYx76VaCtTmP3bmTd+xkPiboNsBjF?=
 =?us-ascii?Q?R/8fIHznWk1cHYatWSS3e+10pJ1OGdKwre8IwqebF0rA4fDLpGflLMcuAGBl?=
 =?us-ascii?Q?nMdCLi5D0OLLcZLiiVTRKBpVqU/CF6D0NHZL1Kk6KzV3emWJ0vf+oLMpdSDs?=
 =?us-ascii?Q?KhfHH3r1mVr3aLCH6aQ+tKNV7U00XbQXpBXHEsSWRUlaq14OgZLIyVuN2VqB?=
 =?us-ascii?Q?vYeCqC9kvMhdzxZu6MzWJsyhhoqwCE/Rma9PKYFKdInk71pgg9dfw20pMJqt?=
 =?us-ascii?Q?iJI8wTnBU7kFoKuQNiCI3RO7/CI/hLkhGUt5Iij1Y933/4xObvI8u5yA93Ni?=
 =?us-ascii?Q?KnXz8k+iS/dz2Jd++c/pfgBIf+Zn4FqIkgP26rq5nsFeFetcBKuktg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 22:56:46.8890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3a90c2-20fe-4e33-4951-08dd3037bab8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464
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

Enable dynamic workload profile switching for gfx11.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index dbc82037c4ab9..86310741647b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1561,6 +1561,8 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	int xcc_id = 0;
 	struct amdgpu_device *adev = ip_block->adev;
 
+	INIT_DELAYED_WORK(&adev->gfx.idle_work, amdgpu_gfx_profile_idle_work_handler);
+
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 2):
@@ -4762,6 +4764,8 @@ static int gfx_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	cancel_delayed_work_sync(&adev->gfx.idle_work);
+
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
@@ -6852,6 +6856,20 @@ static void gfx_v11_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zero */
 }
 
+static void gfx_v11_0_ring_begin_use(struct amdgpu_ring *ring)
+{
+	amdgpu_gfx_profile_ring_begin_use(ring);
+
+	amdgpu_gfx_enforce_isolation_ring_begin_use(ring);
+}
+
+static void gfx_v11_0_ring_end_use(struct amdgpu_ring *ring)
+{
+	amdgpu_gfx_profile_ring_end_use(ring);
+
+	amdgpu_gfx_enforce_isolation_ring_end_use(ring);
+}
+
 static const struct amd_ip_funcs gfx_v11_0_ip_funcs = {
 	.name = "gfx_v11_0",
 	.early_init = gfx_v11_0_early_init,
@@ -6926,8 +6944,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
-	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
-	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
+	.begin_use = gfx_v11_0_ring_begin_use,
+	.end_use = gfx_v11_0_ring_end_use,
 };
 
 static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
@@ -6968,8 +6986,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
-	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
-	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
+	.begin_use = gfx_v11_0_ring_begin_use,
+	.end_use = gfx_v11_0_ring_end_use,
 };
 
 static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
-- 
2.47.1

