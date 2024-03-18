Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6010C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 18:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EB4310F845;
	Mon, 18 Mar 2024 18:56:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CYX4z929";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DDFB10F845
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 18:56:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSi+9ph6ahCKXONv2o7sVfDXEJ3ePlqdHTno0LVgy1ckgdDlEh6li5rJ3CeV291ur6mCo+Vjb9TC/bV5/1Dn2nSl7eQNyLMSvKSDjh8yrH7sr7ze3LNE6DHw7qOmkcFxmoE5EMTyC5eQWwBrSCHT/DMrRF3yjn2rB87k6LGipOM5XzGOYyzfsfMgObj9csmqIpWx+nYZalbEyGlhLAbR/88MpeWYu38v6YtQy6u/hWH5PNpXmni6UffBZO+Du2S6mHOMzjsiX9gBqsmSiKt82G9H2MXCdr+UX8n/WCY87h8Jsnat8tmwUIHlXS9wSiG7rU9H4hgvzAzOr9VxMoBXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cxVQxSOu9hzIoE/wAJilzjUP4pN4Z7yI1U+t5eIu9E=;
 b=Z1MTni54e41k1psPhjlioC2dQVEIKOli8c+LWGiUVGrznMxBxLu5bEIXwJKfspr5sBhgKc1+zD2oSc92/8Ax/Fr5JouehMA4W5lGWMWq8gJd9C4vE/LQrUk/pQDfi/XJjcS6Sk80fjrGU4A1fq7Z7oxjcit5WAdWxyJVLJ8crs3Flp+zE/lapSj5NWGETzY+utbErDRqvNRonWqtgQzWHjmrO2imTAICrXw7ccjZ9mwkO6k6ZHl5/K/v85tGesvLcjJJU1sxuNskE05WnXwOHZoOg2MPqXdlFwRVCeipARfAlH4QuuM/4a7sPiPA59w1OC9Bj/wEqau3MNLk5OjrbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cxVQxSOu9hzIoE/wAJilzjUP4pN4Z7yI1U+t5eIu9E=;
 b=CYX4z929BKdUHz1+r7MlINUO+X/WcIt+kiRSEVwHytmPy9fk0pRNwygDt1U6F5/XdfIAGWzVq6evFK4J3t1WD0CATi1B6jDfwpdnBRVhEuRydjCHWnpgtBUcXKLUd3eC24WdAX8PVvGSYINYft+YdjbIDpsXZ/VPtdNDOIS4EgQ=
Received: from BN8PR15CA0033.namprd15.prod.outlook.com (2603:10b6:408:c0::46)
 by MN0PR12MB6198.namprd12.prod.outlook.com (2603:10b6:208:3c5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 18:56:31 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:c0:cafe::d2) by BN8PR15CA0033.outlook.office365.com
 (2603:10b6:408:c0::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 18:56:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7430.0 via Frontend Transport; Mon, 18 Mar 2024 18:56:30 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 13:56:28 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <samir.dhume@amd.com>, <lijo.lazar@amd.com>, <gavin.wan@amd.com>,
 <leo.liu@amd.com>, <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
Subject: [PATCH v3 1/3] drm/amdgpu: function to read physical xcc_id
Date: Mon, 18 Mar 2024 14:56:13 -0400
Message-ID: <20240318185615.880473-1-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|MN0PR12MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 877991b1-34f1-4a6e-e428-08dc477d1fa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAr6PY7w+hYD7UX6Pohcb68g7+MuMLTdjj3zmA5IPOrmmUa836kdSwFBb+Pm5054YsJNhvqOQCJrVc80JpEFioyv9Q/Ldt9Yn6/Qm0PEJjnslSx9e81N7nxCQftaSFEUKA7af/ulPu9c5kdghOeqZ/AUfJRp4sq8RPAGHWUpFkiK/tC2ta1MqX7i/mdN9j3LKlBa3YV0+YpwjbI5qNKO1khDtqo599KxJNZVJLvJtqYAxuuzcLeIkxfX2PeJp39z9URANQSPDe75PAd5OyXVPU8MS6pP0q5sp7omnnT6LQ5K8irQIBPMn+EPPtXVfPAKPkJ43Zpya4flwK2ijzqYm2H+7N5Av0aK0/FMLu1c5pQRmKEyQBKyqL7FrMLc32Si3BR+xv44V1o0oWvEga0WSv8BMF3np2EV7Mprl+cbCoUnObS2ZynkvtfPuiF8e/pNNa8Y8Fd3ocJmD9DI0YFKXdXlHkrX8Sr+8WI6evzNCpeSkEoY6ZfCxwCsq7xpGiCQMYjXmzZQx7aCFIWJgT6Boz0aS96C7YQ6wXpthQcqUrY9IFBMXbwSNGLqyq9XUCb/GjMzWz9IFOk+YoPLDptLu4z9CACLFY6F/CZkdunhf6KdJF81DeVUOoZEIpP48jV7P60gT86jjZ6vsq5Vae/7aSvP4K7ztpovFlGQhJDWa2KfCcoMAOYRy43HVsu9NIIJV6UKTHkPLoJKbCO8SFjalQnvZY4iEaOPAX6kIkcdCEwnPfuQp7Th95vAk5TgDlSa
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 18:56:30.1889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 877991b1-34f1-4a6e-e428-08dc477d1fa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6198
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

For SRIOV CPX mode, the assignments of jpeg doorbells depends on
whether the VF is even/odd numbered. Physical xcc_id provides
info whether the VF is even/odd.

regCP_PSP_XCP_CTL is RO for VF through rlcg.

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 04a86dff71e6..451192403c24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -297,6 +297,7 @@ struct amdgpu_gfx_funcs {
 	int (*switch_partition_mode)(struct amdgpu_device *adev,
 				     int num_xccs_per_xcp);
 	int (*ih_node_to_logical_xcc)(struct amdgpu_device *adev, int ih_node);
+	int (*get_xcc_id)(struct amdgpu_device *adev, int inst);
 };
 
 struct sq_work {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index b53c8fd4e8cf..68508c19a9b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -669,6 +669,11 @@ static int gfx_v9_4_3_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_node)
 	return xcc - 1;
 }
 
+static int gfx_v9_4_3_get_xcc_id(struct amdgpu_device *adev, int inst)
+{
+	return RREG32_SOC15(GC, GET_INST(GC, inst), regCP_PSP_XCP_CTL);
+}
+
 static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v9_4_3_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v9_4_3_xcc_select_se_sh,
@@ -678,6 +683,7 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
 	.select_me_pipe_q = &gfx_v9_4_3_select_me_pipe_q,
 	.switch_partition_mode = &gfx_v9_4_3_switch_compute_partition,
 	.ih_node_to_logical_xcc = &gfx_v9_4_3_ih_to_xcc_inst,
+	.get_xcc_id = &gfx_v9_4_3_get_xcc_id,
 };
 
 static int gfx_v9_4_3_aca_bank_generate_report(struct aca_handle *handle,
-- 
2.34.1

