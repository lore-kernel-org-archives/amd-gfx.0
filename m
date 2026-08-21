Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AD7C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7595010F36B;
	Fri, 21 Aug 2026 16:10:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5eX9BptW";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAB5510F367
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:10:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXylObBzcnPAw9snrr3IPx90V1PnXqn4ewyZz0SsIhylFfy7P3sbuShUX3Sgua8wvaTM29SOD9Ykr7cvWN756eQC4MAcnLmkUjDhG2SRHDEXm8SQ3ataBt40aooVnWAeACsPL+WgMGfBrB+LaZSXzu2B0r4lqzTuzRzKq3MTKzHjhkwUxnKN3lQZ8zWE3Amec7DN+iB1YmH/7AWqRAZhWJWyj5DkjxrrJo42mDn1htLBeBQnJjyCBmq88ruOGqvMdo2dVIx5i4x9SiCt5HEKUZibeTpyYTeaHYOWfNu6lP+hfcRF5MY2JXJHW5s+hAb1WOM6nYjLtDrHMBuAA9KCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EB+0YkyQxLGLQr/dQNg8QScwATjjcYD7c1OaUJcLNs=;
 b=kVIxSQfuNDJZSpRuMkCwqbeRyfT7Y99vQpVuINqlf27v3+ScXytx6gURaftXTkEmBq6UkRNowecp64Tmbm7MRLqf2GfaEYt8gqc/1rFrA645n17JQraxOwpOjolFSsfJXzUj745VbOZWTEjepxJ1B4JhTQ0FfC6KK5NOpJEkAs5AnwxRqiJuxXnk7iJ/n51cnb+MuLnCkLWpQnXfV2IazX/Qdh1upS3o6gIsZSrUMmhoxmXw/9bTQZaq8Hv52fu/+menrZoXGlpbl5FfvJ8D1w43m2icL/RAzDqg3bHxRaSbH1Zu/vca+JFlwOgj5sqa5tRyyLkaB+L/GAhyX6J+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EB+0YkyQxLGLQr/dQNg8QScwATjjcYD7c1OaUJcLNs=;
 b=5eX9BptWgStkW+zPjNq7jSvKNWnRqC934LreWPyd3iOmguPlQX91QdMg9hefRDq863/vtHxAwLF/eVkOUQirCYaXrDQ8hzdXtQq2/3qmGobsy+1mUHmxR4VxZXOcZtSjIB57+h+vgrSHC1QuttLxe0uUgozBERAHaUQKeElu6L4=
Received: from SA0PR11CA0032.namprd11.prod.outlook.com (2603:10b6:806:d0::7)
 by SJ5PPF6785369A4.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::997) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:10:18 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::9b) by SA0PR11CA0032.outlook.office365.com
 (2603:10b6:806:d0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:10:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:10:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:10:14 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:10:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Philip Yang <philip.yang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 09/13] drm/amdgpu: Drop BUG_ON in PDE address verification for
 GFX 12.1
Date: Fri, 21 Aug 2026 12:09:54 -0400
Message-ID: <20260821160958.753063-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160958.753063-1-alexander.deucher@amd.com>
References: <20260821160958.753063-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|SJ5PPF6785369A4:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce8c696-12d6-4b9c-99f0-08deff9eb05b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JmxIJCk/DRFUDexN1xPXm/OFGDKmCLZ0xD3lOek0wJvRln6vAfqRM8c22jppftM8pVpIZE8sgwXtsDvaBGvN77QJFUGXK1wb4NaEbEkMj1Qz24gClryg0ilfs2qBF1JqBzY3dI86h0yeuFQrtgqzvf5/6AEwUeD5IVwzB/gBZMG0WQo1SZHfga+LHE0Qd6FBznowzcImN8HW0apDO7LBQTQdjAJuj1l0ps55SFfyeuA0eYiBqjxmYB1SiObTJglENhp+L7U0uEM4i9vmO+EHMyjPMSuz++JLmAmhJwX71tTkvhMXJrxz5dDuTFIwy9X6t7isWvGSoRjL5peC0FbtEXmcJ0UPnMjSKrbiqS7mJK5JzbqJXYxoyionQXN/naLmhHhPeLMcC7Tw00aukg0Hnd3GfpkUYxLjQrKnqamcnddlCceruxNT/mitk9rKW2LLoX1locReNV/T80U/MhxDj1KDfzpz/Z7+83MB6pavX9tLNNSxBy/jKeH2+uuWwWkrxSwdOK/TCiKhKr//JrwpGTzLQ/iIaHMnU/OHIDmf/lgWy9KlhkSs1kZDvc85nDtW+ZqvdYJhG2VQtAIxpU76RAe7Ze9q1XqbUI9Y88h0Z8iqA4Zr12e+grn6EMSllZiY5vQr9jSX/nBWa0Z1tNQ5tqnJnMrE3CVMMMEBQ9AIhqOF/j7AuLsCj+0Ysn9yR1whi/ovzgPPGaB3mti1X0041Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lgIZWQ8Lfe55fT1ACktc66wEJWaTxMCItIgYZuaRkyk42/GH3HGSier+ADoBgaQn77FgVWIUulFwqpEpqvwa5kGj9wPG0dXe5cyEs5gl6EwiBTEFVzry0OrXnnUyWLrTf1zI5rxHAvqlrIjiCk0x/X6UFRG5xrSjzoP3bFI2RHh4fXP92yibs53FirdIRa/NlYNhFxQdf0Ky8ZvUVYgf4DraAgh9TdsPnIq2LdmPDlYuwjx1G7bf9fxUDjapkHdoDfQ3SyTEOIdr1t/SBQjXRVg1KZ+EK+UjDfIcX+W32hV2eA91MyxSWaRv+uzpaV8hBBWgjYAgLfFdcx/8rgRopJKj9W2AFZhRRwLSviKv+++vx9Q6+o7Ln78MTUCdpCy7QcNJb4S9md8JSlM8BXtSQevJOsdaMYrpeGP/0bwNWghwsy7Y18ylfOwyIHCfXRE6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:10:15.6435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce8c696-12d6-4b9c-99f0-08deff9eb05b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6785369A4
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

From: Mukul Joshi <mukul.joshi@amd.com>

Update the address mask to support 52-bits addresses when validating the
PDE addresses for GFX 12.1. Currently the address mask was incorrect and
only permitted 48-bits addresses. Additionally, drop the BUG_ON() and
replace it with code to reset the invalid address and valid bit if the
address verification fails. This should help generate a page fault instead
of crashing the kernel.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Philip Yang <philip.yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 0d89cae582a8a..e8e35d1b22765 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -575,7 +575,12 @@ static void gmc_v12_1_get_vm_pde(struct amdgpu_device *adev, int level,
 	if (!(*flags & AMDGPU_PDE_PTE_GFX12) && !(*flags & AMDGPU_PTE_SYSTEM))
 		*addr = adev->vm_manager.vram_base_offset + *addr -
 			adev->gmc.vram_start;
-	BUG_ON(*addr & 0xFFFF00000000003FULL);
+
+	if (*addr & ~adev->gmc.pte_addr_mask) {
+		dev_err(adev->dev, "Invalid PDE address: %llx\n", *addr);
+		*addr = 0;
+		*flags &= ~AMDGPU_PTE_VALID;
+	}
 
 	*flags |= AMDGPU_PTE_SNOOPED;
 
-- 
2.55.0

