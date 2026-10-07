Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908DECA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 12:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D2A10F55B;
	Wed,  7 Oct 2026 12:21:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wmrqPwJI";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F6A310F55B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 12:21:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUoRBLgoPZN2S2EiE/HSlSGaYpI0N1iCVDvw2WFVmPjqlLA+maTB1179yQ3q6gmY3hZuMok9I+7P/RZXJ/pNdE8l1WegJfchl0d3u0AY7hy0VyXICsL1vN8ZwW+epgXI1brQDa7/bQybWXsSyh4jcI+YS6EvdmaVay2iwlA8YmJmCzFy7gc0LK1917yg9IfexEOGsYxeEG+xDhpCEl3g9jSg4RasXEmKXKfR5yrRIirpuXELcGQr9MCCOXrJt+gTusv1Pn5yZ50r4/zFdCld0uM26bOXxn/Dr0uPnAi7X75EjJTpEct/LTUIXnOBj3Qwnl0nrWyLAu7GtIxKWBKR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hf0UWNy/7E3IMZUIFI9/bphjWcBZZGsOTZjdKDZQ63U=;
 b=PfZiObLpYp4NtJHSYK+wzimgbx3jvC5DyEK3YSP7nNAQuTUuf+3fZhe1R/IiV2QOAzus3Fpxh9Vx/kW1UoBMZWAjP/ORPAoiKAViaP9DLRNx9yZQapub+tK+MfKvMbAqIUNoFz4TRbLsYG4Lo3q4cTqpX8aR6b6LhgFC7zMeVsPiQA8FutN8b0cCIGbTJUz121AmUSYEofUy5gCDEENaaPV23d7zyxqRVGGYOX0oZMZd4A+oBC2fRlPlT4NtkcSWMRBXG0reNZazADscZpShLk2Cz/y98Bu3XbnTCKtMVEkCtuvbtSJLIxQzjc5+XzO8L2VGgFkdfjelE/UoydwoWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hf0UWNy/7E3IMZUIFI9/bphjWcBZZGsOTZjdKDZQ63U=;
 b=wmrqPwJIya5YHNXf23x2oTBUJvnu0lDwGwWwxwLySwMmS+XZBlisEbScR5lB03QSkkPfwBDo95RdmhUeEAvmHTvIEnlHEeZAqspOSpRRvl1cKKqBECQx/cL8yHj7FnCU8hGvXNhygLGt9KlRSBFvgDYcmEgdlCdwWWsA2Pvl9gc=
Received: from BN9PR03CA0535.namprd03.prod.outlook.com (2603:10b6:408:131::30)
 by SJ0PR12MB7084.namprd12.prod.outlook.com (2603:10b6:a03:4ae::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 7 Oct
 2026 12:21:19 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::7e) by BN9PR03CA0535.outlook.office365.com
 (2603:10b6:408:131::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 12:21:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 12:21:17 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 07:21:14 -0500
Received: from rtg-Cloudripper.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Wed, 7 Oct 2026 07:21:11 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Lijo.Lazar@amd.com>, <Christian.Koenig@amd.com>, <Felix.Kuehling@amd.com>
CC: <Priya.Hosur@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH 1/1] drm/amd/pm: report the default performance level after a
 reset
Date: Wed, 7 Oct 2026 17:51:03 +0530
Message-ID: <20261007122103.4019578-2-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007122103.4019578-1-Priya.Hosur@amd.com>
References: <20261007122103.4019578-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|SJ0PR12MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: 63eb67c9-317f-4023-3f51-08df246d7cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|18002099003|22082099003|3023799007|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 5rFXRTLgj0pJXkJepSJP6mB0IvgAnxqXJ9xsr6W4PwdR1zzdXVAJxOde+y/I2WSlrQDv0LYtwVoZKkX0tXYAtDroFPjzBbHFlftZ8TJxRJatbKw5bjCKnR8HTcHr8P+Jq9aHyxd5JxqTlu+bsralyYHpOdvJhuIx+AM42lRjY90zxsdKfqapdvCgQivj//tmKrp9KVOMvIWdRdHRRbfwrh685y8nSWXinLzLsuGCsCroYaL71GHIm8hV/D88K9g2XqZ5c1t1x9zZV1C98s8Rqm8rK3hpRRfNeErr2e/wTxeavSOZEHReQxXRpHyVXKjtdaQKuSPpSp2j+6AWke6tDHx3opI6gpD63Li2uHr5wmvd5g0llF4x+7Viue6RiTjlZ+ykMg62QW7MFs9uRT6/yhb+jBxNC9r9i9Zc+0WXJfMn1IWIYkVdWPWiiHpQ0yXl7J/8ADQdS//VCii5xobC3cUbDnlwHnTf1mifZNteSHo3oAIPHRrd8Uo9zeq63vgQaRvLbs5aKlDFJAkNx048HDsiJfumk0YHNvBOorraMaSdJhCjRnwUkUpQE2Zswcu085vkMmbacfIRkHlFmWMePxCcCznQKLatonudCst//6c4KzaVzioRHOtMCzfT5Dt85uQFO6E3jxH64XsinkwWzw2jQRyGzpm5qitYhO3K1/UOD5st5NLHLG7W1cV9sY22L+o6l6T5OZGvlh4054doUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pSCT3BgrKw9+MRCNE3IviHadkNjKohit0RtIaGZdFVPtiyD7CJxe/cnv82S2obcMFw+5CfIv6qO8aZ+0C9OvtSwxKuc1fgTo1edhVcVb87wgydwlAzys5YCNN6Nq44cbyfN640mM+DJb4DeiZB7cRtOO4v9VH583pIVnJMkVXD170EnZ4xWFAAQ/2pPCrT/4ksrOd4N2iZlga0Ht8gEhaLY/qyIv1XgfqZ60WjdtFB6C4VNmfUyqHj4p3ya0TXAhp/fy3O4KPTbVe9KwcdSbzOlBTJpOVRxMNkNXQ1yI2RN+cy1IChSUMC5l2zYxKjEC+I5B34UYmDMyfNB3fo6UHgicE8IgCBptrECiFfY1awN9ZvMVPLAcxbqJTtAy99wFCZiyTQ8AoCYoB3+7RTnFQIlK219o2imAs7zUzQhGvu1TPTnr3ijDCCYLMZF8im9D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 12:21:17.1484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63eb67c9-317f-4023-3f51-08df246d7cb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7084
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

A GPU reset reinitialises PMFW, which comes back on its default curve, but
smu_dpm.dpm_level still holds the level the user forced. sysfs keeps
reporting that level while the hardware runs at the default one. On an SMU
14.0.1 APU gfxclk drops from 2.8GHz to 600MHz while sysfs still reports
high.

The stale value also stops the user from recovering, as writing the same
level again is dropped by amdgpu_dpm_force_performance_level().

Reset the cached level once PMFW has been reinitialised, so that it
describes the hardware. Suspend/resume is not covered, as PMFW retains its
state across s2idle.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a65aa2129845..371f1b1b383d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -998,6 +998,10 @@ static int smu_late_init(struct amdgpu_ip_block *ip_block)
 
 	smu_get_fan_parameters(smu);
 
+	/* PMFW is reinitialised by the reset, so the cached level must follow */
+	if (amdgpu_reset_in_recovery(adev))
+		smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
+
 	smu_handle_task(smu,
 			smu->smu_dpm.dpm_level,
 			AMD_PP_TASK_COMPLETE_INIT);
-- 
2.43.0

