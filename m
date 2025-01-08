Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94850E77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 23:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 178E610E95E;
	Wed,  8 Jan 2025 23:11:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sLgIFxHX";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E46710E95E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 23:11:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyRjxaRT20UtyhsrKwenHYoATb4rcydB7dJTPUQfqoZ2hppVf3jdU4HmTVpExWHGVkwJ52MUXCWuS0DNsArbD+CrEh9PEJukoovDO5k/lviFtAEPKi93TnMs82cO3a78hYTwjeqjGuyHGrXgl697NkYyWisAhxgGNJ9eSlX85q3MEt1+whXg/efGGDDUWLZNiyLUMZ5hW/1/cberQbGgTWI8jDV66EFFvH0zNg23Y27yL4H2uFTvF7OldziFMTE1XdpQGSlk5jz/wtvFQzKjtLtWwQySlGfws+nT1bFgj9OopAwMP86KW/PsgoYeRBymiNuFGBLFj3n0RS/Pp1q9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xetYyTtg2pco/EGmMEnYhp/rgIOEUQDpoV4pBAESJcE=;
 b=Cgrs+9PxeZUrHykzpRQ6GhhBXSM2uiMjJcjlp/TKDYbKXBnOD1/isKnO1H7OkdgM93wVzOKVKI/1btyy4tO524aDIBYAcUBLl9Vv7/jQDSC2v4+AnwhssVxIin/hwbnkCi35qvTlMuiIf6gXY0ep4uSysGrmYeICBSDKsyvYqFlQ1X7JShmf/IdAVZutRn3gfUCJKOVX54+SZOtQpJpg+fj/if3KD+wSaRJUz5g1/cVr9zY6SO5H7xGENdX3zikNQTze9mTJRUxuAi1zA2TssiGXGRl4KiW83PufwUn+ODBAakQDdRklOOg5Tx+nFelVMsQNWQsD/3qi586IbZOxVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xetYyTtg2pco/EGmMEnYhp/rgIOEUQDpoV4pBAESJcE=;
 b=sLgIFxHXdno5LFmojJk+lS75gZ3y1amOYIucbcCe5G96sfKOz3BPmybgDInfd8PEbzBo3PmIDXo77jdnik1+W5Hm74hE5NE0S4n+1sb98KkGaKgnRHMlHF58gCmgkEFIalyBICJ4jT39ScFxDf9Ao9BCuZEARc91qL33JNHjoOo=
Received: from PH3PEPF0000409D.namprd05.prod.outlook.com (2603:10b6:518:1::50)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 22:56:46 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH3PEPF0000409D.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Wed,
 8 Jan 2025 22:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Wed, 8 Jan 2025 22:56:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 16:56:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <aurabindo.pillai@amd.com>, <kenneth.feng@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: add dynamic workload profile switching for
 gfx10
Date: Wed, 8 Jan 2025 17:56:24 -0500
Message-ID: <20250108225627.14063-2-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b09b5c-378c-404f-504b-08dd3037ba1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UZTQuCvoV570KWXhICILkUON6v8o04HAM2RpNAUiFqlXfeT/MJEYHWQNrUBP?=
 =?us-ascii?Q?j7dKGqQtIQmOCj0AEygiwD3t0+1D5LPlt2mJKqbo6x3xUuMcWzpQfatUerIU?=
 =?us-ascii?Q?Q7rwYUCwe7jeLp+FWaV76XwYU+7DAfDQSz+x+X5besuyEQBmHjL/UgD7vZX2?=
 =?us-ascii?Q?V0eQochlI4CEJvLoPXy24c1AYdNKQlVkoL6WifIegEPY2x6IHBhdmHvcwXpD?=
 =?us-ascii?Q?cEZbxq0eC9u/RXfFsXKcqBpPzDhUK4xT7H6NveCF0zXQqiT3qhp5IJnee1Xp?=
 =?us-ascii?Q?fKuxkJ9l0OVXYPjtbgg9127fy47iloXurEEsXTMb3pFNFmUMyAXtLZNG5uB6?=
 =?us-ascii?Q?VHa5qGyDGJ4FZnHk7G8ViAlksl0YgWjX83d0pylnmvY9UswO3VQxCTzmo7An?=
 =?us-ascii?Q?qxfafoeYyinumkPjJSXk8NYYIvnYw3o8hhYqkQtpw26SA2l6tpANYDOEzbOP?=
 =?us-ascii?Q?DggiHYrZPVtc84MFe6tduAu/gbC8vU6GOFUU8u/ow8nQJVkPdP8hqoblzMRE?=
 =?us-ascii?Q?IwyVrJa8mlIvmTKem2HgsWKa4YvAj2ry9sV+ljwlqbyeRu4OZIRFnRbtIO7B?=
 =?us-ascii?Q?khrXEb0MviPGIrhFOtzz93Sxk4pVUrZQcuYPTMjWaAIv3kD+CaMaoS5N+9R5?=
 =?us-ascii?Q?H2jFBMmIeaXmwBHvLo697jeGLFIH1FVVDrWZmqSosyiIsflCHHQrbzKm+6ik?=
 =?us-ascii?Q?lqlSGyyiTKK6UheHrd2IcSdFJcJnI4YSE/UA6c6NMkaUDqhBYq83fx9jRCDR?=
 =?us-ascii?Q?WPreT/Dgg6ZoLc1Yuho1X4ip4QnMClhmZqrWKKPuQMUlxWooHTEKfmtmcrDu?=
 =?us-ascii?Q?zj04Zq1CVZkewVm02T9qjWa5pW+XEe8u57lYyuvWpOPegj0ljQBQ1403nIUB?=
 =?us-ascii?Q?Zh3o1Oq94+RjpwyVcJ8DZad9k0NHRgbTOkdH8KwLyuOCEblAwXs+HRsQBdet?=
 =?us-ascii?Q?hsWsK3zdfoOGDu+9fiukAiVO6AwAwSZFuGe2pmnOlgbk5gU1w7N2Ehd0S5iw?=
 =?us-ascii?Q?+NcwSA1Sxoo7MDKfWA6lwI+xPrgbckhra7pcfdXJpYOOubLYm9WfRNEJ69C3?=
 =?us-ascii?Q?MVt6Tu4ftQgKiyN64FfrnZsVI8L5OMJ6qBgQPU+BBUKJ8qbPkbXdN5LK+ux9?=
 =?us-ascii?Q?MHAIRIeoMjJzIyjlKKr1ee3fdVi5nDM8W6yUGltfsAeaHqZfJxCyQaofeZMV?=
 =?us-ascii?Q?feZOGH53MtaS7Pwh40sci99IhMR0UFEf89nRb1K3OI4zpg1SE4MFSljf9w6z?=
 =?us-ascii?Q?vAcNfuDfqibTcSqOWqbM5oVy0am9krNKkr8LNERxS+5qTMeDzqhOzeHGLOek?=
 =?us-ascii?Q?FhISCBqtAFt+TwAvFsoOqHOz30JHsXdcU4tJD2PyiL1+zFoQ1j7aeSAyLwsT?=
 =?us-ascii?Q?6Oh1jdGN498KpJrE88vGK9Cw0xRIKmUl1/pjyyQtwO9YEpnh5AYkdnwbZW61?=
 =?us-ascii?Q?IGC3QGYn4NPaySWDDdFWzxmB2WlJ/3OkV9Vwzqt0pgv8uhbW4TImuA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 22:56:45.8577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b09b5c-378c-404f-504b-08dd3037ba1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277
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

Enable dynamic workload profile switching for gfx10.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2b3b3f5ffb611..37eab608449ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4701,6 +4701,8 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	int xcc_id = 0;
 	struct amdgpu_device *adev = ip_block->adev;
 
+	INIT_DELAYED_WORK(&adev->gfx.idle_work, amdgpu_gfx_profile_idle_work_handler);
+
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(10, 1, 10):
 	case IP_VERSION(10, 1, 1):
@@ -7467,6 +7469,8 @@ static int gfx_v10_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	cancel_delayed_work_sync(&adev->gfx.idle_work);
+
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
@@ -9748,6 +9752,20 @@ static void gfx_v10_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zero */
 }
 
+static void gfx_v10_0_ring_begin_use(struct amdgpu_ring *ring)
+{
+	amdgpu_gfx_profile_ring_begin_use(ring);
+
+	amdgpu_gfx_enforce_isolation_ring_begin_use(ring);
+}
+
+static void gfx_v10_0_ring_end_use(struct amdgpu_ring *ring)
+{
+	amdgpu_gfx_profile_ring_end_use(ring);
+
+	amdgpu_gfx_enforce_isolation_ring_end_use(ring);
+}
+
 static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
 	.name = "gfx_v10_0",
 	.early_init = gfx_v10_0_early_init,
@@ -9823,8 +9841,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
-	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
-	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
+	.begin_use = gfx_v10_0_ring_begin_use,
+	.end_use = gfx_v10_0_ring_end_use,
 };
 
 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
@@ -9864,8 +9882,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
-	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
-	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
+	.begin_use = gfx_v10_0_ring_begin_use,
+	.end_use = gfx_v10_0_ring_end_use,
 };
 
 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
-- 
2.47.1

