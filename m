Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCDCC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 10:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C324911329C;
	Tue, 23 Apr 2024 10:25:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oYjPjm9y";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3484611329C
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 10:25:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZw5a2dKN0d+YbJbI+g+PuvsuCE03KbsmpCHVrlBGbCjJQbKASWfiKuIcy08lPy2RDAUEmn45Nkr6aNMl6Dtw8/wxFypmP2OG413XTN2c/tlsteLpQfgnAPN0+gpeugeirf39IxGxQwkSCJqOkI92GjNY5Y92qs0cGxQQda6jyF1JEszqmbG2xk7gawf1f/h2a9nBv0WoCC7d32hcVX1yKl/tqWlIMuXXTvRPyP0alCgsr0TyMWsufAZLlEARYqn1dsEzpFb62jid3TCuOZBxCnjkNNnUz1kGUITmMPXDBX438MGSPuJs3CI2puyXJ8MeFxE4zkEk9E3WtmV3Cjh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvVtJDXULoV7ZPQRdX0ikpikG2rV4tnE1gj2qahvllo=;
 b=JIHlg3zSsQpo5+VnOsGf7TW/SOc/ZRSwcJmzBq0kwVzAjnBka3WChJAeQO2TCDe8GE4uaioGkLxKtcJxYL4fkvkLFy4pfO8TF3sO9Mx4EU4Qv2NLZ2ibulon44SsIV9B6c50u2O8DIbQJQFjF2JkrggxYi25yVt+ENms7UZO8DFiL9r3wWXizDE0NGhlWUDblh+FDPfWNBwrN4n/U+uh3KTyUvLh7zROsP4VgMr0lryao/uXGd8VuavqGdAkx8xgsrjeXbn7060IuWl6c35jz2pqn0Z2Mfgczl6PvxyTW+FBWA7lWcJzaub2L3IqVRw1lIcotXvlsKzZAaDPYRhTjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvVtJDXULoV7ZPQRdX0ikpikG2rV4tnE1gj2qahvllo=;
 b=oYjPjm9yM+kwmiVMXHvh0xNb8OTmuI9M3U5Gae79XcmfAkrRVk+ftjuLrGkkeg0xqNTknyO3VX3M/u0RI+/qSloBFEQ6jOzOZDgQUfV9TQHQML1W7gEKTXKme8NHUJ3FjIXTREd6hQqLO/VDF4zso/3I3HeQlnRx/M4QS0kHAr4=
Received: from BL1PR13CA0389.namprd13.prod.outlook.com (2603:10b6:208:2c0::34)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.45; Tue, 23 Apr
 2024 10:25:10 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::97) by BL1PR13CA0389.outlook.office365.com
 (2603:10b6:208:2c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20 via Frontend
 Transport; Tue, 23 Apr 2024 10:25:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 10:25:09 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 05:25:07 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Arvind Yadav <arvind.yadav@amd.com>
Subject: [PATCH] drm/amdgpu: fix MES GFX mask
Date: Tue, 23 Apr 2024 12:24:30 +0200
Message-ID: <20240423102430.1890-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e691084-2d16-4111-3715-08dc637fa756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d01HWk5mZkdWUU5MZHhMbEJvczlBam5DTkQ1Y2RuMmU5MDRySE9hNnRESWRT?=
 =?utf-8?B?dHBvK09NdkNqQnY1bXBXT3V4QzdEVDlRNHVSaGxoTlg3eXBsdm9qYmVIL1dO?=
 =?utf-8?B?elRDT1ExSWFSTWJaeVNuNFptSlE3YVJRWkM0TFpSbm1UaTJaWW5pTC93MWhU?=
 =?utf-8?B?Wk15SXdSd3N2THlQbVBBRDBoZ09LL2dSbzhxRkV3OTZRRnc4SUIvcVgrcm1H?=
 =?utf-8?B?T0kzUVJ0Ylo5anFWRHp4SjlwZkJRS2dJdjcwOUMrMG9ERDlrSFdEUHZvVldQ?=
 =?utf-8?B?S3JtMWY2U2ZXMWZOSGJDUDFGa3hKa2xUN3NFZDcyWWZLOHNEd0lvcXpIZE9E?=
 =?utf-8?B?NTJBVklSWEhrWElMMXQyQWZIT2pVbTBqUWZaWjhLaml0c0hmZ2FkWmYrUG9R?=
 =?utf-8?B?RzE3K3lMRWFCemdMZXdjTHlVbkJwS1dGZ2lJeTlsTEJUbklqMXluMFYraU9K?=
 =?utf-8?B?elNNN1pWdmtaQ0ZZOTMwWnZOS2RicmNpMHdJNHBQa1JsQittdE4zZmlocVU4?=
 =?utf-8?B?eVBGcGxrQ0VYNnFTQk9KWVFtOW1tRjcwTFkrZGpiK0dsVW94cmZmQTQvYmdV?=
 =?utf-8?B?cnYremc3Yy9PUlJXRUQySXdORHhpM1hpVlpZTmVOdkpKYmR1MXhxOUF2MEw0?=
 =?utf-8?B?WnFRdE1kSWJNdERoRVNoL2R2anpDZjQ3Ym1pU0hOUDdVNmI5c1lTaitvL29S?=
 =?utf-8?B?UjFMSWx5eHI5SjFpdHQ3UW5IMXhNdkRUUnhDR2pIczNIRUhJT1o2NUh6WUpW?=
 =?utf-8?B?OWVCWGt6MVlJb2RBZWY0Q3JmckZWYnQ2SGtHclAvRHd1Y211b1V4TmpVdGE0?=
 =?utf-8?B?ZzV2QitRN1FJSWNmTll6Q2hreUNmSk85ekV5bmlVbFNBSTB6WDhKRG1kc3Bv?=
 =?utf-8?B?OUpFYUJsc2FFbUM5UEJ4Q095WHg1dFFMeDFvbG5iNmc5RUN2bVZCMENsTjFt?=
 =?utf-8?B?NW1iU0hLUTNqdGtWQ0lzd1k3bytmajhoOUhxUTYzeXhZYmtiRjNHWjBHaUwr?=
 =?utf-8?B?SW9QNGFjVnpSWEMxcDgrSHQyT2FZRFAzeWowV2JVT3oxNEp4bW1JbCtHQ0Z6?=
 =?utf-8?B?M1FsdllmYnpFbVY4bGF0MU9IR2VHUlVTdGhVR2x1OFpmVVdTSFcvQW9pekV4?=
 =?utf-8?B?VmtVQ09scUUvanFYSTQvSHJ3Qkh6YVJKNkNwTENzd2RXRlNmQ2xZUEF0cmh2?=
 =?utf-8?B?QzVqMU45bkxYVi9qVGl2RWpmQkYvb1p4M0FUNEhsS0t6K2xjbFdDM0t6dE13?=
 =?utf-8?B?S1RvdkF5N1pTZGR0UlB5Wk0wNEFxRm5DZ1FsN3dsbnBqU3c4eGc2cW1RTVpq?=
 =?utf-8?B?Q3E5M2w1VUFyS0V1dUd4dmxCRERGbjZ1VFdrYnNhNXVXR3kxU3hzZTZKRm9D?=
 =?utf-8?B?OEhmQ1loZk5hdzhOWHg3R3plSzNFRnVWZ1NPOUNtbS81dnVPNmNyWWt5VGtW?=
 =?utf-8?B?Y3pNeUo2WTVIRFJMUzhqTWVuM1dqeGpqOTI2b0t2clVBK01vT2pDem05N1k0?=
 =?utf-8?B?T01NSDcwZjBRemNWandJRHl1QzloRnc2UGM4dWZnMkk0SmpRSUpMVE90KzM4?=
 =?utf-8?B?dmFYVyt3TEZJR3QxeHJqTnhzeW8vQUxpcG1GemFqdFYyMTVNRVNTcEU4emtD?=
 =?utf-8?B?b1VFWGNZWXp6Qm5DejNFYjluSHZNd3gyWEYxV25GcVA3Q1JJVTg4bFo0bmZx?=
 =?utf-8?B?UjRwd1g0N1kxc1k2clJWVFByam9MQTRwN24yaXJDb0pFOGg1elJSQzNaS1gy?=
 =?utf-8?B?WmNVR3VjR1JtR0Q2eUlqU0Nhdmg1dTFCTkNkTzNIeW9BN0lYNVNQNlVlbWdw?=
 =?utf-8?B?cEJ1b2RIOXdtQ1E4cVE3WUxKZHhJU1llb3YxcHVEcUtaRW9GTWgxYjJsVFZo?=
 =?utf-8?Q?SDsQ0HhzXfZ4/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 10:25:09.8740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e691084-2d16-4111-3715-08dc637fa756
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464
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

Current MES GFX mask prevents FW to enable oversubscription. This patch
does the following:
- Fixes the mask values and adds a description for the same
- Removes the central mask setup and makes it IP specific, as it would
  be different when the number of pipes and queues are different.

Cc: Christian König <Christian.Koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 1 -
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 9 +++++++--
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 9 +++++++--
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index da48b6da0107..7db80ffda33f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -148,9 +148,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 		adev->mes.compute_hqd_mask[i] = 0xc;
 	}
 
-	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
-		adev->mes.gfx_hqd_mask[i] = i ? 0 : 0xfffffffe;
-
 	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
 		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) <
 		    IP_VERSION(6, 0, 0))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 7d4f93fea937..e30f5de92c0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -109,7 +109,6 @@ struct amdgpu_mes {
 	uint32_t                        vmid_mask_gfxhub;
 	uint32_t                        vmid_mask_mmhub;
 	uint32_t                        compute_hqd_mask[AMDGPU_MES_MAX_COMPUTE_PIPES];
-	uint32_t                        gfx_hqd_mask[AMDGPU_MES_MAX_GFX_PIPES];
 	uint32_t                        sdma_hqd_mask[AMDGPU_MES_MAX_SDMA_PIPES];
 	uint32_t                        aggregated_doorbells[AMDGPU_MES_PRIORITY_NUM_LEVELS];
 	uint32_t                        sch_ctx_offs;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 1e5ad1e08d2a..4d1121d1a1e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -290,8 +290,13 @@ static int mes_v10_1_set_hw_resources(struct amdgpu_mes *mes)
 		mes_set_hw_res_pkt.compute_hqd_mask[i] =
 			mes->compute_hqd_mask[i];
 
-	for (i = 0; i < MAX_GFX_PIPES; i++)
-		mes_set_hw_res_pkt.gfx_hqd_mask[i] = mes->gfx_hqd_mask[i];
+	/*
+	 * GFX pipe 0 queue 0 is being used by kernel
+	 * Set GFX pipe 0 queue 1 for MES scheduling
+	 * GFX pipe 1 can't be used for MES due to HW limitation.
+	 */
+	mes_set_hw_res_pkt.gfx_hqd_mask[0] = 0x2;
+	mes_set_hw_res_pkt.gfx_hqd_mask[1] = 0;
 
 	for (i = 0; i < MAX_SDMA_PIPES; i++)
 		mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 26d71a22395d..fae6455aa8d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -384,8 +384,13 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 		mes_set_hw_res_pkt.compute_hqd_mask[i] =
 			mes->compute_hqd_mask[i];
 
-	for (i = 0; i < MAX_GFX_PIPES; i++)
-		mes_set_hw_res_pkt.gfx_hqd_mask[i] = mes->gfx_hqd_mask[i];
+	/*
+	 * GFX pipe 0 queue 0 is being used by kernel
+	 * Set GFX pipe 0 queue 1 for MES scheduling
+	 * GFX pipe 1 can't be used for MES due to HW limitation.
+	 */
+	mes_set_hw_res_pkt.gfx_hqd_mask[0] = 0x2;
+	mes_set_hw_res_pkt.gfx_hqd_mask[1] = 0;
 
 	for (i = 0; i < MAX_SDMA_PIPES; i++)
 		mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
-- 
2.43.2

