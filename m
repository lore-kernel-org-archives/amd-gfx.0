Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A6EC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 08:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C04510EB2E;
	Fri, 11 Apr 2025 08:30:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UEaHg0zr";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEFB210EB2E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 08:30:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZSx3G313uuLssT0pUnb5U/1VXFLknQQfoW8UaBlmYBW3eEWu/TN5rF9H9MGvdpKd23jYXmSdao0RlHdSffGGlSrWXsLtAbc08GQLUXZNInqly0+GQgChzHNetg/DSAFFfIfo6P/ARX/Ais5fP/zsB+g3a/i45DNUKD3jQ/JzUd+jFl8w++xjM40fld8CcbWlEtwIjRooLdip55Gub06MiZWqQLwva26fQdmDEhPlcH82aizTFJw+Y92kn+7b7pWqvZd+I5FoduJ7jmYakZgVTvddAuw4fFB7rGrQrMHOCZODubuBwurTcEl1kGY9S0u81uCywpA9VOSlgafgoek+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ER8PLLq1jok7uQITAw4mCsKdGZO8s2kpkNejSw6XKmc=;
 b=bWWLo1eNVirgtgR2ivJlP83e3ohLb8OOWBXPbKMh3Op64PQlv68yv7jBwMXrDezQFgyayMwfoheIHDt9y5ZAD64Ye0VaPoyfXChTQ0M9oBWHXon/wfcjATeFaoircEOSf0795bJjUQ7GjEnP1k1DDCRi1p60EqcDuI9Ea7NIhummJN8hzczbnyo/5V32pQhV7dlkvnEea2s1t5GQrLYDNYPuUTg8oYWbAuBhGIKjsbByBS0Z9KPwV117vv2eDB8RNIpj5gujjiTUYssp5ZJLZ0N+KX0il1Xl/dKCoMjOMkAybPWeBGw8I9fHYU8gAHB4R2CqP2WNcw00RZ4pkIkwvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ER8PLLq1jok7uQITAw4mCsKdGZO8s2kpkNejSw6XKmc=;
 b=UEaHg0zrpMOJDnRyORg72/zxccV7GBMUgc2Sft4ravwg8I3Fd3Wq8MMDztfdENGvJgbwSqYZ697+szcZXtaRFkwAD6oLwqCScf3jw7c5jkhzzWxycp/XEjl22pruUeN8SbOlz3ni2DC3sT5sFrxAt9Z367vr7b53wJ7HyP1q0FA=
Received: from SJ0PR13CA0114.namprd13.prod.outlook.com (2603:10b6:a03:2c5::29)
 by MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Fri, 11 Apr
 2025 08:30:00 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::ca) by SJ0PR13CA0114.outlook.office365.com
 (2603:10b6:a03:2c5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Fri,
 11 Apr 2025 08:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 08:29:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 03:29:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 03:29:58 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 11 Apr 2025 03:29:46 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [v5 3/6] drm/amdgpu: switch amdgpu_sdma_reset_engine to use the new
 sdma function pointers
Date: Fri, 11 Apr 2025 16:29:18 +0800
Message-ID: <20250411082921.3228498-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250411082921.3228498-1-jesse.zhang@amd.com>
References: <20250411082921.3228498-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dbd26fc-0fe1-41b8-7cfb-08dd78d30c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q4yGRQGjPWIdKPpyxRi7hmMFaAxMLsI/dw2oeGuD0FfMQhU+EN2Ysv2MX8Il?=
 =?us-ascii?Q?EAIr0/5l1fSyQtbeONtsWXrqe9I9v/4YfAeL7Xhf9HRo8fQqlXVpXeko62b3?=
 =?us-ascii?Q?sr21lx12YOpZdIsCpxUxcn5Ai2Jyo+h48YJhlIO7c5jrOwkVjAoHYbBgWOJ0?=
 =?us-ascii?Q?7Lw7k74zipNH/hjT6bp90fua2TpT4Wj0C4QCHyeVUf4V/FrRL8yQh9AnDsDX?=
 =?us-ascii?Q?2AM57KNJMZ3gM2FJ+zL7L6Ef69Rcjx62b0rvI9S7gtdbU+DTmrUlbDfEszpS?=
 =?us-ascii?Q?zGq7vtPIfBBzwujfWIQjzsjqQroW10qy6OCMIl+rqEAnTINtP5yMEWV1rIF3?=
 =?us-ascii?Q?CnvdQjkNmQGEDQk4O0Rr9LTnXzMv/8T8n7mhT8s02SpNn/8lhyZ6NqKFYn29?=
 =?us-ascii?Q?qBUzzE1kxXOjcna46vs3vOMeDFdF9CU/MeE2rNfPKuePeMtnCPTtarmT3Waz?=
 =?us-ascii?Q?sGqUtemnAn/mCDp1NS06WuULg9ouMra7kX9XqE/Wd+Gfk6z9Xh0W33CqNIs7?=
 =?us-ascii?Q?ZL/AP3fO0ln+4aU5A7aEqJPlLSwcTEiXF+1PJcLjqTCXcv2BJCWBVYnXnwRv?=
 =?us-ascii?Q?6f6RW13O/QPAjziqaywcVGi79HTasTRgX6z0TQFns6SUw5jgeYq0v+ZHUS1N?=
 =?us-ascii?Q?LacRWiPFM0rc96VaiO/wynX6NIyFesSyJlgj7yS5RPhAOHF2f8+MmcNbD+VP?=
 =?us-ascii?Q?YjRfDSJNP8XUSZSmeWCglSGactm+qnIQOYhEWQjZQAvNQnVypcgd2K6SiwN1?=
 =?us-ascii?Q?r5Q1/IuZBwl+A3jlR79uvOO5WwZ+5BNF+gonZOGjUEKVAvf0dhpUwwCytWUS?=
 =?us-ascii?Q?0P6sbGlxCon/C45znSfmpg3Z85JTo4I1d1x59ghKdxFw4t6MxM63Vu+p3Xuf?=
 =?us-ascii?Q?IFVLIBsSHe+wPcTr4d/cgvEdMvrHQOiZFn2k0PcOfOGMg0ysQcYZfT40hIFy?=
 =?us-ascii?Q?U2NanwjzntPm7xDeYAd34/X1NvPysirdj0FVAnp+gggH3UzK7n9eTEI0pRjI?=
 =?us-ascii?Q?Ia625RoNHvUm7Xt0wWS0yqfUWvFUfUXaz6Vvwu8WUbIGRvp0kZ7Ptf7noM3D?=
 =?us-ascii?Q?F6kqd/A9zMEOtMzLUsQdiTlUDBVAxUzhwbsfrEgANPn3OVSXeD/OQjPrn/f0?=
 =?us-ascii?Q?rZq+XHVNYDj/lMkG5lho/I0bXXecHZDb/lwuesibXsfdYT2bgevdhe8eMDTB?=
 =?us-ascii?Q?99hrAU050RUkSnLueU3klRIWt5Zr1b5NA77GADssK/SALvQMZNVi7uZT6TbQ?=
 =?us-ascii?Q?HmonNpUa8l9jV/XE+6vtPZJDTusDU1RHifmOXNlB4G6Xv8m2dtz5CXkYDsro?=
 =?us-ascii?Q?Ie5WidK2RgI6n89zgmE2ZUkuP5OLMGFsOaCMvcleYkS+A+xo1/kSK3ch+WuQ?=
 =?us-ascii?Q?tb1p9IWkLDA5vwGymPNxIF+dgU8B/yTncA2z92S+dT333z7Bjudw4N8J5VQO?=
 =?us-ascii?Q?ak9bShrjPZteBU9GPxTAP3QWH2a8MMZq+iqg8UpZs7iJVnNXOEJkztQyJlpW?=
 =?us-ascii?Q?PGZxn3phrGmTloKR2xUgLSi0dzz+rrqo2lkA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:29:59.6220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbd26fc-0fe1-41b8-7cfb-08dd78d30c61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

Replace old callback mechanism with direct calls to stop/start functions.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 34 +++---------------------
 1 file changed, 4 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index c3c6f03190c8..7139d574c23e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -559,16 +559,10 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
  * @adev: Pointer to the AMDGPU device
  * @instance_id: ID of the SDMA engine instance to reset
  *
- * This function performs the following steps:
- * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU to save their state.
- * 2. Resets the specified SDMA engine instance.
- * 3. Calls all registered post_reset callbacks to allow KFD and AMDGPU to restore their state.
- *
  * Returns: 0 on success, or a negative error code on failure.
  */
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 {
-	struct sdma_on_reset_funcs *funcs;
 	int ret = 0;
 	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
 	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
@@ -590,18 +584,8 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 		page_sched_stopped = true;
 	}
 
-	/* Invoke all registered pre_reset callbacks */
-	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
-		if (funcs->pre_reset) {
-			ret = funcs->pre_reset(adev, instance_id);
-			if (ret) {
-				dev_err(adev->dev,
-				"beforeReset callback failed for instance %u: %d\n",
-					instance_id, ret);
-				goto exit;
-			}
-		}
-	}
+	if (sdma_instance->funcs->stop_kernel_queue)
+		sdma_instance->funcs->stop_kernel_queue(gfx_ring);
 
 	/* Perform the SDMA reset for the specified instance */
 	ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
@@ -610,18 +594,8 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 		goto exit;
 	}
 
-	/* Invoke all registered post_reset callbacks */
-	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
-		if (funcs->post_reset) {
-			ret = funcs->post_reset(adev, instance_id);
-			if (ret) {
-				dev_err(adev->dev,
-				"afterReset callback failed for instance %u: %d\n",
-					instance_id, ret);
-				goto exit;
-			}
-		}
-	}
+	if (sdma_instance->funcs->start_kernel_queue)
+		sdma_instance->funcs->start_kernel_queue(gfx_ring);
 
 exit:
 	/* Restart the scheduler's work queue for the GFX and page rings
-- 
2.25.1

