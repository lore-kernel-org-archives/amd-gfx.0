Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A463CD6E75
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 20:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AEEA1129C1;
	Thu,  4 Jun 2026 20:54:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dk1k45f1";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F174D1129C5
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 20:54:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPuBgn3+UxCsQAVhxpsGyDNlha6wB8HGbIMv9QqHMZ2QZ9FJD2dA0azAiJpeTPgYR2ez/+CRKj3iX/sZTR6pJZU4dnJkpDNlYW7gykfivG9sL8ugMMGcVXvQTnn3quLAP3xROXFWqc5CSFNGqEJEKOLmEbD/THWqEzrO1gJAR5qzhJP8Jw2xB8K7SdPwcK+ODRnyGeSRkI1rofe3llcrBl3DPx/lbzFtPLNbZx2Fw+mLi4ecLMRnLCgvgJTLlHkpA26ZkTZ0GSB/Jorz30auwup+Q7PCv1WCNJMJOePvowNOcGyqGy44vrSuNhvZ8j37W+6MX8IdI61d/fVxLHMf6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnChlYlGL93qE3/29ePNeguyKtPfxpY20lN5ku63WSs=;
 b=J0XMZ1K9S38Nqyt6LkbtGhGMbc36T9d1mHOlU4/gyTDV5vPVc4dVd0ngiY06j+7yxEyOEUDfzCnZkAHda0pe975ZncLHevVA0LnfufFvjb7UVxe1EN8+cVVQu5MP4A9sSagpqKHGioreDwNbTjIot4asVsR3MhsgLU9c32WL0wozFrkCWtEGrIaAVIVe+1TaIxfzECaU0REvyg1V7Or44bcGF65TXiadTbJ3dkURc3OLD3xWo4v1wsF9qCK9UrtK1M0fnMajunwlvKBGigm2in//gvQpheFpfoKz5MRGqzcCBRwqu4cqe5JG2uy1wWpDDXf+g0VprOXEHqno/AjTYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnChlYlGL93qE3/29ePNeguyKtPfxpY20lN5ku63WSs=;
 b=dk1k45f162rKE7D1s4/yUufdFQwGz6r4UUONctePEPSRrz7eKwu9bLLEW2PCq5RtIOJ8ogkZVaegZq8oyiJY6v70DPTrjH2D3IX3z8KzU3UJwc7iNTJnBCp2uwxgHlYMNSYQoJC2TL9uds1KuzjLtu+kU4Y+jsS8CXJdaYBev+g=
Received: from DS1P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:451::14) by
 MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Thu, 4 Jun 2026
 20:54:32 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:8:451:cafe::50) by DS1P221CA0012.outlook.office365.com
 (2603:10b6:8:451::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 20:54:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 20:54:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 15:54:31 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 13:54:31 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 4 Jun 2026 15:54:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: remove spurious line in
 amdgpu_ring_find_guilty_fence()
Date: Thu, 4 Jun 2026 16:54:23 -0400
Message-ID: <20260604205423.14358-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: a500858f-5315-409f-0285-08dec27b7a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 9pSX/crwpQSCyP/barSJ3boVy5U4bys9TTxPE6GgQGgzOtddqViXgmS2iDkBO5SmM7n8eOD2fmTLb26QxTZkNZsm1CmHaZYzu928OokwC1kLx+y7Q3fZNBM6It2kq50aStQksmUHWiPmmERqEldPG43DqqyAo8JcpVvq1GykgsgTxZFVZVK04FLlu14mJWyoCbzy1DydusmmqctPW/mmARfQp7eZqJH9Dd5HnuPatXTANw2hUo18O2H6f5/YhDrKZfT/X1Tr1Ombq/+r38RbGGnwp/AjQMOXuWbpcNvPHUfzWcSbSCmHw9EEeu3iH2Vh/GHm6CIInUzx463sCdEtr1MRc+KtRWAEIpHteOsObD8vpAAUF8Sqbx8trDMZD37WdVh0X7q6U0WT+DFXXr2JDrlJCp18HqoAhhDBhf3Pg+lmcYNVXxGb00oxvhd7WwnbVwnr9Ldk5F7dz8jPEi17IIsl8g3LZzCLV08bz9uxct4sTdkCzwKFKG2QUCMz3e2IQY4hUN59Dkt3pUhiAAeGKqQr4RiOw+S7xygXzvyJiIkfrqxz03O0wS4AFie2POwAZR3yLhY7QaVbmhvKxJ9QbW/FrY4w+wkBxv5KnrtXUbIDiqOBDuqrE1pluA0G12OrQ/o1ofJ/ijlX1UcSW6AyNSbEoTxqr4nCQe4klLnpU7bWGpwRZv4X5NqbigZhAgQkYlYvrBli405BEtWap4ItxOITwXPYnrWaY4tC39cpM4k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +/4clQBm8ZL9hNMlBqKRvO7Pc18wag0EQ1B3uYrm7z45ue+ey3u8JzXXSKHFUndrIP+zqIdZtJHhHBPWw9WUWqK5GVlqG15BL6e6d5wFg8tDPF7OHl2KkjHqTWucsbJFF0JLtP82R2Se69MQ9r99AWyPA+AS0rek1HWGcKkaMhgxWq5sQxO4fiu/xdT1gvPMKbAadPRyXpy3O61AAgcOEW0RR9Ckwqx83965mRaH7rCgrOF4J+iMAPW2ho831uoUqYGbZi1vj5O/KCdYnRr0NoCxk+5Zt+23jjS9huSErh9XxzsgGp/Y/NcptRvZ6W7nCedArLDj0jeGsKKVnn6X0We17TgvQIQU+SIc4LrPp4S/6824Cyp4UjvgbZgWfix4es/d/cW+ZWuv/cr4efxfe/PrEFWdPg+J3Fjh+Zd9rSpQqAhiKYU3LbGSx9qTCHNl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 20:54:31.9115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a500858f-5315-409f-0285-08dec27b7a2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
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

Copy-paste error.

Fixes: f647ddad8ace ("drm/amdgpu/fence: add helper to extract the guilty fence")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 8569c1c637a2b..3043ad041bb42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -842,7 +842,6 @@ amdgpu_ring_find_guilty_fence(struct amdgpu_ring *ring)
 
 	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
-	ring->ring_backup_entries_to_copy = 0;
 
 	do {
 		last_seq++;
-- 
2.54.0

