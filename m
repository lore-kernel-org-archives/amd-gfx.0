Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D377CD6E7E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 22:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0EDE11AB86;
	Fri,  5 Jun 2026 22:19:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OF4Tym8L";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F6B711AB88
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 22:19:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcAA11WS+NkoH33RA8QNR7qfoUvjIBm/dKQZgYoEDup9eXuUnxnL3McScp/tRGo2Xt95dpVZuppnDi6ZOWpK5bKtnXsHnXBgddmYzEciRCLdTHrfJavbJGHE4EbY3SRfw7EYfEPoGPRdSzSzXYAL/E4ZJw1ve2PIAn0bd0YaVHoe5DF0VJOLRR7KkiXeXlkfbOyvqFDq5djt+acSXyQySxHstSxATe+MsTmDxLn1liN56zBoGWENaPZ+u3pZb0UEv6nSSPqkOuc6yCehL6LZzku9TTLB/axeipoZ9NTfwfu1QLgN3GKGfddgK2zKTSz2RQcsw8cud8kJuo5MxYxlxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DS5d5eDxmfxaUvDkm12VDn2KWmLCVxgVhJUqqaHGVHU=;
 b=WeDPdjcc7j3Pai9taLr45xPU8PdIgn5qzlP7VcBsz8WFYk8iSdEI9yPWRD6dfbOtKpgota/4PVA3BYBfoDuDzajeDRO02fKokxZcyvOsa4CXiGUofCgO6f5T5Aw7ZWipqUnesAb0dDGEFsDDaDeJmMffADch+VQ8eU7ak04kIrSa+yyPQOqHv/IEYTlIntFceUHKmgqXZlKv1tbDpKULr7JRertvsujAJLzARo9BDXRmGQD3E+ceeSy9iMCzPkk+MPDrWpsOFZYNhN606Wv3bVwbRKbCzpGAhAWgWArwd8vn7nKD1ThJhT8/yQ8XlOOw80oKC0ZkcXMMW/fSPUCvXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DS5d5eDxmfxaUvDkm12VDn2KWmLCVxgVhJUqqaHGVHU=;
 b=OF4Tym8L4svuWzL7/J/6XSqSpY5z7lhrVzrVBtXvajAHX9h99ya1qLHn3/hCk+cXCpwjhJF93ZjY1LeOtNs6yi1PMAwCe71g6WCrKZl5/rnvITmXD0sI0CqSpBU5Yx1frO4a6PZBPMUwOF63bu0LjUjPXyTSZe4ux7urERJd87o=
Received: from BL1PR13CA0097.namprd13.prod.outlook.com (2603:10b6:208:2b9::12)
 by DS0PR12MB8295.namprd12.prod.outlook.com (2603:10b6:8:f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 22:19:06 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::4d) by BL1PR13CA0097.outlook.office365.com
 (2603:10b6:208:2b9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 22:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 22:19:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 17:19:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 15:19:05 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 17:19:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: fix missing check in vm_flush()
Date: Fri, 5 Jun 2026 18:18:52 -0400
Message-ID: <20260605221853.903153-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605221853.903153-1-alexander.deucher@amd.com>
References: <20260605221853.903153-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DS0PR12MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 699c6153-e815-44b8-8417-08dec3507559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Gs5ZsRMt4O/w7+Y3kfMHgzPvlxyNDiuBQtZbrBvMt+B8TfD+jVIJucYLTj71fzeJ2frfeT36sNKvrmjFwC0PZlVwAXjBMy+ndGhB2Uvi04yy3GG0eblZrZt58ag/ChlajORNqJF2hEGJHZi8PE1mxNYopIBhM3JZ44QvKEGWEAkebBUbcZmWFKeLdoB5SmqEvY72qz5zjU6+zG/6TVW1keJnUrPq6zj4Y0HkTSmX0UFFImi2iDUqQr4K0sJMQBTRclBla5S1nx2Y1k/vkqFQpUEJIPQSbEnZZQ4uGoCWXJ4nSUNL1krVjQCiROPcdrRLLi721AIeNxzZUDtpPOLY34UIjXoXTseBPFakTxFOFmNukOa54LPzh7/U/+nEzmrvarG9vOG96Wh8/7NZkJIMTekpJdqxg4SO9ANkVZsVAxvAbVI+ygBhWfp/MIcHvEy5E5U6oA6XAhT7NYur48mHcEMGBd9UunLA+54BtsAo865qE/BZqv2+ejdT6aCbMlFwakTzUTKZnRxWOPHMMZRTngaONEXhtC6ISf29c9iauRpiagg/TR0RU0R/ZVnF9sYr82mY68GI7wwxbt0VgQzVHgU5Zl1z1iBjDE7izL8c6J8CzJrWEXCs4aQijJOVfqrTbLt2PTlnBkN5ejy3qTAGuMelGz/a7JkY/fX6oM0Tlz5oQw7sIHewFKVXrTPMIzrMCpfkb5JBxPirgyZvDO3lm9t30KTSOloY3k0bbUgn7oc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: obX7DmZwNozOrhAVVsp/KUDi1+XVtYPC58JhhcdPJFrpHFi/MMufJ54P56b4k/yNLWroNKJ8oiBYlK3Wwv4Dk/LDkzwvTCFy0JL8H9zlKf3pickjnkcl7k/+GPDlUi4dO/kj7kkjrW/UrO0qOS7DCWlT8dBStxpmSmw07W0bsV+0GFNfZMRXZGJ+GHkL2UeDGlOZ1A+177Iz2re7Hol9RHCNk6pHXYBglluJcuyA8fwyDodmXrk+g6Km1J1dt8Th4DMj2VqYw5XzZPbOVdqMDh6xDVy5JhdFYpAKenrqqr2Q/LjbLdU3DrE+jI4/3NhOiyPZo6D6BMpU46AekLn0+qzrzbgImehZojfSxiJN7N0/pkpY4IAHmVhaiq5Ga1DujZjp6rdhrW4WD8CkhtFkhtB2A2rtrLwdLqXf3ZEXTrZwtpaVKHLOqATsMJi06s6v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 22:19:06.6337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 699c6153-e815-44b8-8417-08dec3507559
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8295
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

We shouldn't return early if we need to emit spm update.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7e0e2281719b1..13031e4b6f1d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -809,7 +809,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		&job->base.s_fence->scheduled == isolation->spearhead;
 
 	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
-	    !cleaner_shader_needed)
+	    !cleaner_shader_needed && !spm_update_needed)
 		return;
 
 	amdgpu_ring_ib_begin(ring);
-- 
2.54.0

