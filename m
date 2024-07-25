Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7E6C52D1E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFCBE10E86A;
	Thu, 25 Jul 2024 15:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f17l1XA8";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5529210E867
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNb3z65cBHsJPlnZkMq/yCvLWlBoMu6kLhk+IKF0f+PlvTpIHwvC/uWfJlVTuqsHgpnJHQutWervRYfgwqM+hiH77Gt8kZ/5yO06/CVlBtgBlO39QabOp6dT3SbTyZGrCAaAqdyxhe/du/ygDcNEz5iNs2NjLLA0IeiDfJ10B7JJ5r5wNA0CUEPeL/6yTXf8p+cy1w4nTe+dde9HVNx/9X7Hz1LtUew/N1vhVH4V409799AD3Zw+W+1IYmpDGOGQkRogrdpZE/zp5KKmLRUJhJI+kd2lcJfXDSXPxMWrkAjx2/MglXRu8vfSNyrqevNAR44ihaTo3kW0A+1xc+Arew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1tf2cDCLHIvkmizOf7UCza4iQlvKyZQxR6FqHGa5FI=;
 b=AYlrS22YUq4eZDTWk9FrjokGece+DAynqY6SK1js2NoLhmUpoB8ibMQA5vNlcUKh/fv+hqGtyF9hsW5dwiGF9krEeFW7VwDjGgI1UULvf78EA4XvcZY1dVAZqarbXLRWd93oHjboLflQFkEGk0ilDxeO0iO5YpkaiBww8qVQYmotbDo0wBrEqn0zeskdevWTf5IBJONh21mRJC8PTZ36WO1S9f/b/ErmcBL4rs0FV/zBHfl43Alk+5wRJhYeQ14I3jtBOWpH9NC3XDAwe1+EQIzkHtcVXocN03Xyh4gE5segcOawo/Aw9MB4Ieqc7+1WDypUGjr++/GA+Xk0bjIRzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1tf2cDCLHIvkmizOf7UCza4iQlvKyZQxR6FqHGa5FI=;
 b=f17l1XA80mk/1Qdrd813/QlBA33+T/VEYGgMzjCZH59RTYgbIPAhD69Jo9ybsy1TqSyjansTj22hYSrl8M3yMc2up/zYVxQkHrhqDjqm7nKOpEglybGafarhpyHYbc7e7dr4onqODHRF7zCEIKmgvgfW5Y2zysQbG8dJkrj0qAU=
Received: from PH7P220CA0031.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::32)
 by CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 15:01:36 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::e) by PH7P220CA0031.outlook.office365.com
 (2603:10b6:510:32b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 47/53] drm/amdgpu/gfx11: use proper rlc safe mode helpers
Date: Thu, 25 Jul 2024 11:00:49 -0400
Message-ID: <20240725150055.1991893-48-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9cb07c-19ea-4cd2-02c2-08dcacbaae24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+iw/Hpz7UmOfEc180alV0RlzMIsNR3yTCFHR52OZBzvLPKJY4BNq9X8NYYl1?=
 =?us-ascii?Q?TXlTqMhpubswUIMCLbvs2mvqbiOANEJqOkaLlZcSWPpbU0q1oiCoi71L1Szr?=
 =?us-ascii?Q?FKH50jayUIMXiL+W0dZsmsPhd5CgGqDZG3SICBYzlrxnjwpGi/+zXW9U8Qg8?=
 =?us-ascii?Q?0k50y4MjYVzuGb4RiLTiGtTxh/8Ad3QtAhrqltHXvVnyaVR0f4qGMP1FJvdW?=
 =?us-ascii?Q?gkdOlk5NgVYy6CDLduhMj1Ql8+uDUv67918/TS9b1m6mev+W56m2GF+wtNsr?=
 =?us-ascii?Q?4dx0p2a0hvYfKeQQz2+TTapM1GJJQILzRG3NZTSQls5vK0D4/nN2kos93z81?=
 =?us-ascii?Q?5Yi9Yi3TMjxw7LapldbFsAzSgjsXZ1asONYPu7Ts4FV+JPBlxvn23RtwelOP?=
 =?us-ascii?Q?BDumewW8cqYPJDh5uMkopHzvzKEwutXP91fkAUQNFiNxIyaocu44C9Obf9Vi?=
 =?us-ascii?Q?KPQhl26TYNwqN06UWWSgMdeYOUApQlU/DDsdl393673RMSWryYczst3Q6xJc?=
 =?us-ascii?Q?+1tMh0vo4jegKPiBtaakI255Z3539/DD39Q9k1JaBOs4KWMQ/a+uTe4kvThg?=
 =?us-ascii?Q?yvxZKteMiGaKOJxbkqLBXed6dhzxFcl9GBRUc8NJMVZh+ZFdJSivOXHh1SXK?=
 =?us-ascii?Q?Qbsv8TQsZgO1GGpUyeIrcwPS3vfmJfAfe7QI7WXDoL9oHxBvmZ//AIUIX5Mq?=
 =?us-ascii?Q?Xq8dLBh/TLRh2+xA4/gQ6ZiR/vczb+tF37vYIjs2itxuA7BRZqarCN/Ywqv2?=
 =?us-ascii?Q?ar+7K80b/E1/LXDV95EwNvN6IAhHNT1AL/000FW2T+A7qeOqtg8bTu0uT693?=
 =?us-ascii?Q?SYkCrtsigJjKdN0SnFw1hKjih9iVZetuitoSuVnJyEcV0X3XZu82yqp3X4ao?=
 =?us-ascii?Q?wwjz4wxnC9YdgQkIZNZLYFcYztX0TwrQZr8He4z6G1sAZ/3/NC03BG9x9LPo?=
 =?us-ascii?Q?HlD6bR/0taVP1t0YI9u0UERGfcRNTGrZhdt8TAymOqF5pkQqlQMcxH/LroKj?=
 =?us-ascii?Q?qBuI/2Trsly7Gd/pc+QlECSNfQvCbF2zw1oWTgvQmPra2vArFHkx+1UjMF1v?=
 =?us-ascii?Q?BeFlQ21VJXeu4JufEHuW8d1QnvYrLUJ72yueX827XimA0enl8fC7nOqHqyDg?=
 =?us-ascii?Q?eIyRTomgFTxvDih+MDhzX8XqB46+lm+7MwjK41eHNwgGr65W08sVck9Do55r?=
 =?us-ascii?Q?7s0TVcY85OZVrEyOPEyzYEp3V7vI5+IR0tHEzt15bF3WEpps9QJEUyu7Kyt1?=
 =?us-ascii?Q?V0AEzj0eeKYF3sGjXb3j8dqlB4P7nDIC2BJkNwDAdWiP2IUalfxxDP1pj4JO?=
 =?us-ascii?Q?Ax5479m0kqOqqsXjrosE2tNH/2n5B14x6N/7qrgde/WPCwrntedh/tOmkeFr?=
 =?us-ascii?Q?YZ0ihK4YII9Q3d50gPULvggSSGSG7a3MWsybdF5YQa+VN1OavInbQzC4OLz+?=
 =?us-ascii?Q?nJpVQXvet2YRetXxQL7v1V6MhjxmekPp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:36.4007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9cb07c-19ea-4cd2-02c2-08dcacbaae24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243
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

Rather than open coding it for the queue reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index c1f799651b25..4198656f9a0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4767,7 +4767,7 @@ static int gfx_v11_0_soft_reset(void *handle)
 	int r, i, j, k;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	gfx_v11_0_set_safe_mode(adev, 0);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	tmp = RREG32_SOC15(GC, 0, regCP_INT_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL, CMP_BUSY_INT_ENABLE, 0);
@@ -4883,7 +4883,7 @@ static int gfx_v11_0_soft_reset(void *handle)
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL, GFX_IDLE_INT_ENABLE, 1);
 	WREG32_SOC15(GC, 0, regCP_INT_CNTL, tmp);
 
-	gfx_v11_0_unset_safe_mode(adev, 0);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
 	return gfx_v11_0_cp_resume(adev);
 }
@@ -6570,7 +6570,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	gfx_v11_0_set_safe_mode(adev, 0);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
 	WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0x2);
@@ -6586,7 +6586,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 		r = -ETIMEDOUT;
 	soc21_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
-	gfx_v11_0_unset_safe_mode(adev, 0);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	if (r) {
 		dev_err(adev->dev, "fail to wait on hqd deactive\n");
 		return r;
-- 
2.45.2

