Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0543C3600C
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 13:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6511A10E14F;
	Fri, 28 Mar 2025 13:09:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NHDi+kmW";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE27A10E14F
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 13:09:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WH0PXmYQy8rMdNSBbRXXRBtwZuqI3v3ydk6omy3sfShx0VU38/0K1eKfnIkYlV3S4zAjXeh6XGuQMcrjxUyIlpfApsdiUUIAkZYGdLm/Q4ym5FMG1wbm4K+9YwuBg3ujPJxKbEjHaTO9teUJELqrS45fKT3ZMQ0sL7JifeAT5pCVvAyXSsRFyIJUv8VsPwP/HIBzFEv1RvcUtEVa1+vbFoCpq8gpqnjwrlYKPkYJ2NtXrbOpPCmKJmMcUTpBn8gzm1DTnB3uyb/I0x3jmPcFX7+P6HK1vRZWQoCHGG27rOztLT58GUpgG44rNDPk+Wsz8XYUm9Xk2p2xlaGvLvnZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLdLq+zAWUMWfDe2IheUT+IiF8k1b9VrFLperuEDEXw=;
 b=nBZ4Yo1gUOsrVC/aRkofY3nbGSDlHg9cukm5n3iqnsj/Xx4dpCp0iv6FTSqLiiea8fbqp8sSTO62lMe0Pz+FSEg1K2FguX86pmkEK/gJL4Z3BFXXpym+mgNOLYG7UZRQJ8BcAq1Jf/UF28azRcsg2G0vkWVYd4Byguu1uDo9k+sAWiahknxI9MHN/038D14e3NauCzWRERyQZkcKap3vtsQ4fd5I6IE/Qzh2Wyl40NrZICdKmx7rU0uc9WyOQq/MM4Qvm7LGWCEwpCCTTvLJCR47/1+8qyut1qhrfyKKyo8RFoinRWnLIt/nHwtCROS4TEl5sFzse+qvhANTdARKgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLdLq+zAWUMWfDe2IheUT+IiF8k1b9VrFLperuEDEXw=;
 b=NHDi+kmWQxksDEbZMCaSa6oZr4SNE6F4gEAQaYF7KJVvQk+hu3AvLa+PZUezlrZEbY+YM4KUhpWbx9+0Ui/pJQzXh+Qs9O+icJ9uXwFYc/6jLrBZFtPlreRTgHMJugWk2E3T86sanD3bffziSanLhZfc62l3NgvGJmAJzJ1DReI=
Received: from CH0P221CA0047.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::28)
 by CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Fri, 28 Mar
 2025 13:09:11 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::99) by CH0P221CA0047.outlook.office365.com
 (2603:10b6:610:11d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.45 via Frontend Transport; Fri,
 28 Mar 2025 13:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 28 Mar 2025 13:09:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Mar
 2025 08:09:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/mes12: optimize MES pipe FW version fetching
Date: Fri, 28 Mar 2025 09:08:57 -0400
Message-ID: <20250328130857.4071486-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250328130857.4071486-1-alexander.deucher@amd.com>
References: <20250328130857.4071486-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|CH3PR12MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 257d643b-4afc-41d0-8d8d-08dd6df9bb2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|34020700016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hR9F0kCwuJX/PzEbZJDzulFM1pL6Yan0l2G0s4AzLSwbVin69PanUSlBi/Qs?=
 =?us-ascii?Q?kZn82g6T096smLhoBjjPHo6udSjJJ/+qzHjmlN6bNoQYBrTIyRNt69RCW3SK?=
 =?us-ascii?Q?n9SMEs8Y3xTmSiajXa1hoK8BZBwntwE12YepPh0KtEhzhJLF6JBqtIsX3RBC?=
 =?us-ascii?Q?xSatFFHUFYBWj6SuaroR/kL+d9z9imkjEcKxXkFi19gCdAAh/WVdZ19TYeqm?=
 =?us-ascii?Q?dnopC5Kc2GIBbWlQXRlxWTlSPKIgfAEkidmLU9Ws/1Y/Ds14cNKSFLzP5BKz?=
 =?us-ascii?Q?rT+yT/4hcxM26TXHDxJSzug8wgWGkgNJaLkgT3AkKXi7MaFO7VlMhUH66icK?=
 =?us-ascii?Q?6KGEkWmMwfQlIhvypCQdqM0rjWEAfU1mLZou2yCBl3vNerLOmuI0llB+p8BF?=
 =?us-ascii?Q?A/yMpN+tmYXyv0jjqSr2dNsEegGrAa9VKRlSoQIR4e94WkMzMOWwjlB3K7IN?=
 =?us-ascii?Q?DWrlz5b6xLeKoZPyQztm/jliue5xLTuBTFmlMaqRKMxcYE1mwIT+ZTvqOqup?=
 =?us-ascii?Q?roGyDNSVsHTIhjf2ujY/IuLhMn9rzWFb/pVEHxb1ohSq8ppYvumk9fzgc0Q9?=
 =?us-ascii?Q?x5GzBLmhDIaD6A+awxRgb8XdFLvNjQcrdMcvXV9AgzMBO/HfMbujc/nIva8D?=
 =?us-ascii?Q?FFOlAoJF7u9PiBde0TMPiTBXcCXD7FEtfUKsErKhrGII5JZ0O89PKLLyNuZ8?=
 =?us-ascii?Q?38pvk0vS87N4iJTYj5mTV85DmO7mQPf1kK1dlcrbQtwO09OhivcQzuZ4hDcO?=
 =?us-ascii?Q?LbUIAbkWkzU8YLfvt1lV7+3loX4auWCOmqdXQWC4IKhf0jeD+70kP1ABnC/P?=
 =?us-ascii?Q?NYOCiTRAvFKAB7D2DHdfd+X6pdsYbKq2jy0u1+JGSHHvQppAmR2+MxxaUTfI?=
 =?us-ascii?Q?b64ymf54MPHAkcgtWUy+0qfKPafKdEC/abhq9ZxX1rW7b93E5syyavTKul5o?=
 =?us-ascii?Q?vAEiwIE/6rqyuhvbqiwMem8NwAwAp8mV0fwpJw3YGZ4EFhmW8ZtbmIMXUoVG?=
 =?us-ascii?Q?0SL7DEMzVimXSJb2DyV5Ur0EX4PnnBOwr1lDixb7jPu5oaVjWBAHpFqQQYcp?=
 =?us-ascii?Q?dDpVI5y04Qnmqna6mqdLrj5uIi31Z6NaTDl9ZPoKJLBd+wmYJcrkQeSkGAxD?=
 =?us-ascii?Q?6PbfWUh8evc+T4eHerYm+QIPB5JcFTAzBtiVa6XsxtPqD+ao6kRfRwa+m/6F?=
 =?us-ascii?Q?/KjhMMOvCtfEmu+ZWLpeqtMIg6uz1CK30J09L7S9zSZPzXBpIqB+ruSy44vh?=
 =?us-ascii?Q?TSV0/o0T32c3ozsR75YeeeSRwr0429t+0eoquwoqZlTb3p9YSUxxVAp7TRfK?=
 =?us-ascii?Q?helgFX9UFlSwccIFgS0pqD5/AolBFBzuqiCb72DyIu+YsuxHhZl01UPO6SpQ?=
 =?us-ascii?Q?hLXZ9L8/bxVbganzMtqtDD0DxcRGxcDwgw15rZFmPzQZBnQAEB5lbK5DPB+8?=
 =?us-ascii?Q?iAeJzr8lYurgWYvI08YZsoWNESTFMlKzSWcZ9w7KlrytTVW4UGpdJg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 13:09:11.0150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 257d643b-4afc-41d0-8d8d-08dd6df9bb2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545
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

Don't fetch it again if we already have it.  It seems the
registers don't reliably have the value at resume in some
cases.

Fixes: 785f0f9fe742 ("drm/amdgpu: Add mes v12_0 ip block support (v4)")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index bcabebd18fe84..8892858cfd9ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1392,17 +1392,20 @@ static int mes_v12_0_queue_init(struct amdgpu_device *adev,
 		mes_v12_0_queue_init_register(ring);
 	}
 
-	/* get MES scheduler/KIQ versions */
-	mutex_lock(&adev->srbm_mutex);
-	soc21_grbm_select(adev, 3, pipe, 0, 0);
+	if (((pipe == AMDGPU_MES_SCHED_PIPE) && !adev->mes.sched_version) ||
+	    ((pipe == AMDGPU_MES_KIQ_PIPE) && !adev->mes.kiq_version)) {
+		/* get MES scheduler/KIQ versions */
+		mutex_lock(&adev->srbm_mutex);
+		soc21_grbm_select(adev, 3, pipe, 0, 0);
 
-	if (pipe == AMDGPU_MES_SCHED_PIPE)
-		adev->mes.sched_version = RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
-	else if (pipe == AMDGPU_MES_KIQ_PIPE && adev->enable_mes_kiq)
-		adev->mes.kiq_version = RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
+		if (pipe == AMDGPU_MES_SCHED_PIPE)
+			adev->mes.sched_version = RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
+		else if (pipe == AMDGPU_MES_KIQ_PIPE && adev->enable_mes_kiq)
+			adev->mes.kiq_version = RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
 
-	soc21_grbm_select(adev, 0, 0, 0, 0);
-	mutex_unlock(&adev->srbm_mutex);
+		soc21_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+	}
 
 	return 0;
 }
-- 
2.49.0

