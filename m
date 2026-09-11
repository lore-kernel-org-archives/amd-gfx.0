Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E5FC88E58
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 359F110F16B;
	Fri, 11 Sep 2026 17:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BBJNjSAc";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012038.outbound.protection.outlook.com
 [40.93.195.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA42E10F16B
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKM+vdlrbwr5YSpyUlMRC1JRk6D1wHXXHtvJQoIhKrIGxhjg5bUsTq+7AMBa2FdxAhgeev3STIuvjkF4q+9Z5Vdf6w8FYZQDskz/OuJccReXeCg7NoerWiHYpopC+Wd2kZlMnhwUvvud/RvEDyUex3OEirM1BC+cnJz7E4yD4yxph0iHFTc5j6AJELjqHp7F8xPz0cL6aIlVFBeqIHi4kADGuLdOtcKH9mPoUoFM8yO8xb6bx5h+QW8zVG83FtgMPdh4ikcUBHgeKGXd+5bUBxGROXtqi5/3UDiUoODoG7Le6SyzSpep22Nzny9ccQk6iR678sb+DHd3aTYFnbb5XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hOhX5LR6cBNBKrnd0UkeQdMuYavRjwgYFfL5kAqrgo=;
 b=ncJyznx5eWXDxnzGnIogr+Vims72//+CJDPLuBCk7Yic0wl+47tM5OMoeC0S8u9uYRwJO+WzwsUC7nFkTumxZ/dK0fqSeiJlJaxMbiLbEREGtEQ78xoIpOsjCSzSQz4OtX/7vLCsr758tk93a24C/V5mt9ZywcCoi/ZWjTpgJ3jWZe0W7yGtGSWAz/hQG3nTiJkB7MSE/pyLLp33m9eAUQwdJYerJlJ1ntztMSbQZhd4HleQRiqB7JgfsoBfHUI9dDCtqBxsA0lQmEy96BbjGjaeCQAqMHLOrVTdkg2/H6xtcfFrry69N+Agjac7r4uzmOHyih5pg+FGZHOwQRhYWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hOhX5LR6cBNBKrnd0UkeQdMuYavRjwgYFfL5kAqrgo=;
 b=BBJNjSAczKflI8kOyuJsiR76aEAhg83wxRAkkKDdAWULgVYhw2P2R+18l9/WsAUU0Oyfx66XOJBuAoWKbpSPlgdV5IUCxRCBerJEW7RXYM1FHyNlXdQPeeAswzl1cWdLkFKtTlzApk1g9wSPF36I4NqnNp29zchiJ63th7WyrJg=
Received: from BN9PR03CA0169.namprd03.prod.outlook.com (2603:10b6:408:f4::24)
 by SA5PPFE91247D15.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:56:04 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::6d) by BN9PR03CA0169.outlook.office365.com
 (2603:10b6:408:f4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 17:56:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:03 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:55:57 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:55:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/23] drm/amdgpu/gmc11: disallow gfxoff around TLB flushes
Date: Fri, 11 Sep 2026 13:55:24 -0400
Message-ID: <20260911175544.1314467-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|SA5PPFE91247D15:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a2b615-82b5-477f-5211-08df102df2a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: dczPpk2rb+Ja3m74dxj1pvuVsMzTznAxsoJOdYSPY4BE2zKTkrO59a2IUmvdvdFq/doOJuWivcWD9wokGD8rWwDzIhqB/mVlbRMZ4T/gGzCPcACuLaaSkaMoC4EEBGrfG6hlfDJHwLr+n95+9OOzHTg6VwdRaLwTQ4SRO1EGQtwP2JaxsQDf4dc8oecivJPHNduAJuv5Eq+1j6CwvjsSpB6pxC6l8ICU2Ko8wczrYsdbithwj4AGgQOikbkFifJo4mFn0InVOOZHYkZ3efnIbSLPwU2lFpqmIQnFvmnhDqIKlZbse4ge1gsuuOQ3blqYszvn5BfzhQDWGZMVFhW2Ln9KXyOnrGOElgyuNSyJ5QJRxwAWSqxf3u7uPreUJtIW1F7q4Y4/G9CZvBYlxffhNHGnWpg77d9qnS8nElEBsxCg/6vF0Ynn6oqXnPtudS6eeOT3hSQ4rpZVXc09Ta5Byd+aQWFuEhRPXxM3YsVrVXEQyDw3QJxk3VZBCg86I+Ec+iLM2Or8jc1DsAGklLrvLOlcRLb/tWHes3ChNSzsibG131HJTPFqjuJuDmO9I8wZJMkNSDx0ndv23K+N60301aXefnW//tzXZdpy7W4k1rcyAK7hhuHfOxKqupD/LNYRmhTaw4R8EkpL+/WD3OTSBst0jiJVIgHw5pzIPZEZPIhkw28vmIdq0kl0ZOlkcGSAVy/GK/nW4APqro3sjS7LyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vxt8px761m/ml7Z93Sf/ma4UKXuRlNAHh7P0EFfBDhi5/j4FZLxbmN5AOaZ1lhmIRAajCB+XXGBvPZo+FYXPmn/NPPaqIyuvurS2KkfXFOL7nRd3T9R3pqkjw3pLY6TKHlsqr/vfubTwngJlVswdtYtNDSTG9SERG4OSXUwzNJCOMIr00Y1obH7Y6nkuXu2COPnSridjG1mz4D6OnWs77ZDViTvdA2A3TPjtLYi8BitG/gYCoYsF/vzYqlbEWd8L6CEFzjrHoi+6/iwgxnicL/DDElV6FfiyEV3+x+vD7E/vy09v1lQL3VOF4D3xSPNu8rLUt+T16sgvee85SlDECAF/zLvqSa4tlP7McCVdlAFXBqM0aHz8Vbu2rkfxJ7idbvN1P1NicEBns7LVbZTIB1yyGTsJmcgVkrdx+zgZHDjPZyyurfvr2iJSWRonf2U0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:03.9702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a2b615-82b5-477f-5211-08df102df2a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE91247D15
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

We need to disallow gfxoff if we touch GC MMIO registers.
At the moment we use MES for TLB flushes so no intended
functional change. This just protects the MMIO access if
the MES is not available.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index bee269a8877a5..f7aae39f2d1b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -256,6 +256,10 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* This path is needed before KIQ/MES/GFXOFF are set up */
 	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP;
 
+	/* disabllow gfxoff when we invalidate */
+	if (hub_ip == GC_HWIP)
+		amdgpu_gfx_off_ctrl(adev, false);
+
 	spin_lock(&adev->gmc.invalidate_lock);
 	/*
 	 * It may lose gpuvm invalidate acknowldege state across power-gating
@@ -309,6 +313,9 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	spin_unlock(&adev->gmc.invalidate_lock);
 
+	if (hub_ip == GC_HWIP)
+		amdgpu_gfx_off_ctrl(adev, true);
+
 	if (i >= adev->usec_timeout)
 		dev_err(adev->dev, "Timeout waiting for VM flush ACK!\n");
 }
-- 
2.55.0

