Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F67AC3601A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Sep 2024 12:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FC7710E3CF;
	Tue, 17 Sep 2024 12:54:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qxnQpoCo";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC43610E3CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Sep 2024 12:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CF9lp33fH5yv+gO12IJqqUBGKZaErJJ4oKf4iHLRiRjSIZbyXVaFlsRPWhsMjT2jftaahFzOnw5Oedz9pJg3HnCwKSJyMQsfhgXgMIt9tERiJjWTWiqkH2fLl6Ebta8iryT4UnvVFY70c7+5hr0zJl08/Tw9EM+HH5+VkxlsUTNmZiXXNJh6ubmjcD7S9R40KYWlhC38vwDyEBacWr/EuBffOkb44N4arH7WNiZtWn32cHuf+4ez8BLn1DCw7aqF5+xtEmLhFCfevFPxOYt29hx93Yh2BXCOeOi03f0uzRI8VTUV6qEFyDGBx9BU37BYyENn6hYyY6raQciQ4wBFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lttPRWDnZ0zgqXPm6X1GkiT+psDIluhtya8eZZ42Dzk=;
 b=EhdifE6o/BsSqBQifP/GzzVg4Z9TIh/xEdRXRi6y/8Oxf96crDWT5IxdK8f4XDpYCZeiVsm7ophBgYGDtJ31D5s7AoB5s58XuMDytPlRKPVF0C3/+hi7MstOH6xmqE6XKQcO9AUyIVDN1py2WYmSPWeX0AXfRWLJw/1y9AFs3YQbwc8EJhDYAjFGxKu7EH70/mkogMopxp0NVLoZI4zfTFVlHmKeqq3G+8rjm1y8GOA88p1HYP27giXbBz1CUQGaH0N5jjhfb96iSOYhBi3756NchI4JLYEA1DzILuZgCiP6Ho9ubJel6j2boPu3fWxv3Hlh6Uh6Hi5m38ej1rnCXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lttPRWDnZ0zgqXPm6X1GkiT+psDIluhtya8eZZ42Dzk=;
 b=qxnQpoCo+6S5iPIXKP3CyCA7hnaLnDwXuF7s8mGFyZu/ylLIOp1oDJd2pjPposcFEmFuB0u+BX744fRfP6QI7/NnHVpUgwmREtGDp/3EsTbPUqn2NklCRwHMOz8bedqZ/I43pKktmJY6SFPi6MbqA6q1CLbzR/+3RoMBPt5N5ms=
Received: from SA0PR11CA0090.namprd11.prod.outlook.com (2603:10b6:806:d2::35)
 by MW5PR12MB5624.namprd12.prod.outlook.com (2603:10b6:303:19d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Tue, 17 Sep
 2024 12:54:52 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::80) by SA0PR11CA0090.outlook.office365.com
 (2603:10b6:806:d2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.29 via Frontend
 Transport; Tue, 17 Sep 2024 12:54:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 17 Sep 2024 12:54:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Sep
 2024 07:54:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: clean up vbios fetching code
Date: Tue, 17 Sep 2024 08:54:28 -0400
Message-ID: <20240917125428.2326410-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|MW5PR12MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: 557c8465-8a3c-4fd3-1e3a-08dcd717ebda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5EdpKxxf0w13tc0Z/8ER8GD0Q43YvAIjAp3yN10YXnX3HUzPiiaJeQ5siH/R?=
 =?us-ascii?Q?bR5LoZMrd64qWxUe510XEPm6HLrTLMEJsem61n2Gz+j1kR0nr/mcedYcW/R8?=
 =?us-ascii?Q?6L/5yGYqS+TWVSjVAs8kWw/uVtZOe+couhOjR0xFRHpyEj4ulXdZC1KvCnrB?=
 =?us-ascii?Q?vkS5qGJXBJGqU2L4iHmH9Jz3EGjLD8gnxG+OeBlTKdaZ9Cyn+uUvGNJnSg83?=
 =?us-ascii?Q?kIYD8R/Vf2CA3izLePDvTQa31xYPhjdxmeuji920bQq3tA+fBx3tS39uab7x?=
 =?us-ascii?Q?A5kyeqwRO1Gjy8JhTqRxcsSS5v0A1eQVCN5yucSg0F6yHh+tc9GgdWDgOgG3?=
 =?us-ascii?Q?P0RB4TR5rhi5tsyn6XHseRSeHk9WTfDH4b/oegsxyBw+iT3vKGfNwavKaGo/?=
 =?us-ascii?Q?ZKW5A2RzguI11Txy2q5wn9ifG+8ApoDUgxcg2iUZrqDhcQm+PgY2v/M4fe6W?=
 =?us-ascii?Q?aD8jDWPSA6fvmoUbSpwhMGnQ+CyTYS6tKKs6qgyYcdDdiYBJHSHBm7LLLIXa?=
 =?us-ascii?Q?smSgTMuq3FEaRqRlUnrHbCjVwdmAvduyZOD/3iBXVWOkdI00RPfF9VPHWfxd?=
 =?us-ascii?Q?Dj4nsrNP138PvtFqdnz+bdNTWU+Wu9dFBC8A0KmoBiFbLeCHwwaG4UxAxZDj?=
 =?us-ascii?Q?bM+aVWx+OdVE5Fz/InHgSwsv4USZ+0CWUMMBErFHPsFFRmPuortbItvrdWu3?=
 =?us-ascii?Q?wIUfTKztrH1Qw69k7R6OH6izLwn+BQqgbeb7ryLF1Cjx4mAshRMbVcDtJ6YF?=
 =?us-ascii?Q?fzig1mGX0s5JJIe/cmkho4jP+XmeLlFX37H+oZofW0SYTbonm/4VtJFnL8TG?=
 =?us-ascii?Q?H/oNuTKa6BOH/Qz2KsfH2aLKczy5631zdxzWz2RIrkVEPZwwZGbjEfgLqtHD?=
 =?us-ascii?Q?nF/3BWUL8P+7FCPJCM1BxWgyKYMO1ZEGmxDkDwA4VDCUE9tvbkY++lgsD6YU?=
 =?us-ascii?Q?+QKTXzzHLLTuVmbAxUzmZgsYRne0rvZvHFfa9q0G/1vKKdH01u8cI0xu5I7U?=
 =?us-ascii?Q?aE9DAzu/1j7zEiDoMUS6KYqNQ40wjfE8NhZkqru0K4Ydpf62ucp1/KGwdQqd?=
 =?us-ascii?Q?YdL0ntNtZOVnf/BVDQpo+WRG35+0rLJmeTWlSZI/F4ZWVDmOnX+ZMEeTHN3d?=
 =?us-ascii?Q?wMG2adaKOhHDOrl/u7FkG7ceafqHJCl6i2WLcnZKXb9pjftES3buuKfoDSPh?=
 =?us-ascii?Q?rp+9Ekcrlf2NaP9BxlabS1lspGjWfFoLd4z8oja8SXUIeNoGERkRB8Y28ZfB?=
 =?us-ascii?Q?V7NRMcfcGsGz+WEHZsXr9h2g90OujpeCd5PXIp615vcst+dr/XEJ+e2oqoXI?=
 =?us-ascii?Q?oh0+dj1nfNOOpvBjFrEHqIc1P1Ne1ahaEvZ2hIlEgzBXKVtPihVNRSaww3Ba?=
 =?us-ascii?Q?XMSgGGDTTdWuD/OikNdrrh9TJn6kTS7LnGkhb9WYnfYhc+kPYgmH3Y9Xsfev?=
 =?us-ascii?Q?LTX0fYcZMebA2H8mVVGkF3I0tQ5SMs+I?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 12:54:52.0146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 557c8465-8a3c-4fd3-1e3a-08dcd717ebda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5624
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

After splitting the logic between APU and dGPU,
clean up some of the APU and dGPU specific logic
that no longer applied.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index e8f62d718167b..46bf623919d7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -284,10 +284,6 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
 	acpi_status status;
 	bool found = false;
 
-	/* ATRM is for the discrete card only */
-	if (adev->flags & AMD_IS_APU)
-		return false;
-
 	/* ATRM is for on-platform devices only */
 	if (dev_is_removable(&adev->pdev->dev))
 		return false;
@@ -343,11 +339,8 @@ static inline bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
 
 static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
 {
-	if (adev->flags & AMD_IS_APU)
-		return igp_read_bios_from_vram(adev);
-	else
-		return (!adev->asic_funcs || !adev->asic_funcs->read_disabled_bios) ?
-			false : amdgpu_asic_read_disabled_bios(adev);
+	return (!adev->asic_funcs || !adev->asic_funcs->read_disabled_bios) ?
+		false : amdgpu_asic_read_disabled_bios(adev);
 }
 
 #ifdef CONFIG_ACPI
@@ -455,11 +448,6 @@ static bool amdgpu_get_bios_dgpu(struct amdgpu_device *adev)
 		goto success;
 	}
 
-	if (igp_read_bios_from_vram(adev)) {
-		dev_info(adev->dev, "Fetched VBIOS from VRAM BAR\n");
-		goto success;
-	}
-
 	if (amdgpu_read_platform_bios(adev)) {
 		dev_info(adev->dev, "Fetched VBIOS from platform\n");
 		goto success;
-- 
2.46.0

