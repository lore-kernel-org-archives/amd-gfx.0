Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529BB606A334
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=i3PgWUz8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD79210FD85;
	Wed, 18 Nov 2026 16:25:07 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3006110E569
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 16:25:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjgE7WaQsZoTwucF8+5EUAfnTyNVoLsSSO9TxPoQEwT7dnlEOq7cYToAqjIQJsMdsvJqG/70y2hE3glnVBpV7YjFEGjFdDR+FjwV7GOHESU+2X5i4v9GMG1wTpGd06Mq6jWF8oolBLEqBUI2imyvFqjiflNCX/EgLU2n+OjmECv382g6oPXjFY64fDsswZpQzCjgU7i3w/Wm0QPhr/3De2YTkkTN2Fa90iMm+ylmmQTjof+42BX6chPx+RZaq3l7kukAcazDA2sqXJ6r4TI5SYGJmdk5GG44MAuaEDl2TSwSYQjgWVXmOT2VggDe0LCkR/uNO0Cd2i94Y4ZxbBOTYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1may9meB5Td6c5RChHaR6zEhFyHim1MybmAReKQdXnk=;
 b=wPyDYCjnPn2Q5RZ6OsQkSZXLNlH4gehcqjeV8sJKBPjV9m41oCyEQB+QEI5tQSCIh8xQIx3WFqJzM23c1e3zMqkxtseBVA7jnQk8j0V+eek3a5AtfOwiiB7LkN4N6GyYtqYDDZxOKIWZ1KMvijofcaXBT5v1qvaU9Z/wa3hfMompCOEK7TwQBtv5N54kiuYfgnx/4KN2y7PWQNhR2zReNaNGytubbyTXK0xBFCY7ql/Serbf1J1JGmrjVBmB1Ep24DMEj/jNOBBe8fUbMCHD4Jy9EmVnF/OSfXrJqOIeIkYjJ8uftWqlcF8ji+1HnZFTDz4uhjT9uZCsYISXffeS8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1may9meB5Td6c5RChHaR6zEhFyHim1MybmAReKQdXnk=;
 b=i3PgWUz8oZ3ZNATbhZRM7y3h/MHGQlh0UeU706rwZu0dY8zzj/vR1AnDow5ivXSDAJd56uKkdxz0tzeKUQPDGO6BF8A8MZGeF4rx78xz7hESeSVZEyCnWH+n/aaQlk/4cOLTFI9EoqQBlJp7KcEAEpS6J6gxvZqenFobRtqbrJo=
Received: from CH0PR03CA0363.namprd03.prod.outlook.com (2603:10b6:610:119::32)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 16:24:33 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::4c) by CH0PR03CA0363.outlook.office365.com
 (2603:10b6:610:119::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 18
 Nov 2026 16:24:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Wed, 18 Nov 2026 16:24:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 10:24:32 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 10:24:32 -0600
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 10:24:32 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Sunil
 Khatri" <sunil.khatri@amd.com>, James Zhu <James.Zhu@amd.com>
Subject: [RFC PATCH v3 1/3] drm/amdgpu: pass an XCC mask to the
 setup_vm_pt_regs gfxhub callback
Date: Wed, 18 Nov 2026 11:24:24 -0500
Message-ID: <20261118162426.1642532-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118162426.1642532-1-James.Zhu@amd.com>
References: <20261117165952.3558762-1-James.Zhu@amd.com>
 <20261118162426.1642532-1-James.Zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|SJ2PR12MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc80581-33ac-4ddb-257d-08df45906e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|10067099003|11063799006|5023799004|56012099006|4143699003|261022075727099003|261021121427099003|261021123027099003|261102123227099003|22082099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: lodaAe3YvyzcxPzXFbhKYqrZC7FjMpnd8JuLtrLqFogfwctozzDreS5fpehMRQrXrubBTeQcTz1aF7IsS/ZiFiDvqWgbTNy/WnXyA/7XqWbWVy15Q1dDetkOl8zGUeSAQyWouVccL5QD5J+AT4PP0WXpPbM/DIJX2FkhEcQPBbilASl889UczhsMLJ/Alz3BqYM6OUzJLS8kSiWU4wzUHdR8v1rZ1oKbWDhm7tKVsN4J+uDCigJygVLdmy5Zpo3Ej9/N+B8JjlXsTLEPbrwuuI1kSAkbgCc/Lw6vm6YTzopYKc2BTrrN8MCnGfOx/O86/ARDIUmccZlGsGsJ1xPvXpiuQu1sM7QR2FhS1uXH9OGDz6jPdrBbJF7VGEFjnJC1bL/LXhSE6WfaML57jCIwsxrSkVYGf5NEfywl9xu/p+XtZOX8BY1EAU/UiFsqAaFQ0KpddI2lIlt5qM19/omEtQ5jYGjHRymVbYskcOuu/JfDmqCMiFzioYwmal3F0ZR8m7qm/UjgytLhYY6sp04mmh1i4AylgCt5jsSJyuC+phe8wvnZYtQfhYibxugSl1HxXz9hFgh/fYJb/uJaKj1esvwRV16it8xxAu8Jg42EiYQ5TIWmyGsOximuXPToWrT/ZmdHoakpVPl22/ibmwkf0M/0t6R9t5/BDRL3CTq6yeYi0wFOiVHUO2/aK8Kr2et5X22kRLtIckiS5TjVPzNm9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(10067099003)(11063799006)(5023799004)(56012099006)(4143699003)(261022075727099003)(261021121427099003)(261021123027099003)(261102123227099003)(22082099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1Unbx4/I+hx57U+fR9Uz3rIxgUg++QOWUP3PsVw9QgyEkxs9lqsMXBybROAxyyHjWxYuGdgjhReFcbLq1yTgfzocLsVHxVotwtM86HkqeGGVZ/cFwXFd8/Kxb3kXXopWji6nK7hKSX+58shxDF4xkwuXUI5HN8Qi+XqiVO4pHqA73zGunhKWOuRj9w8+jXqSXwiffPN1RjpatAyd/6mwDITxwD252gcNhHzcH8s4M1giPDkJE5/XANJejasa6C6EOZGUg7REeLUnEX+7uJXI4e3IW3gXE7frzufeHrMJ38ORCKu94ktVwPOeXVBWovjwDBw+XtITf/5QDDcufbZHjk+63cYQDwXv1sp6vqgOLaFoTVSa0qsj6PUUuosLSEwBTghkKJJdlIxDXXcKtxx3ezPUSHltUskcc85233FeVd5PT//iVYnA3ZSLhVXBZM0A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 16:24:33.3344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc80581-33ac-4ddb-257d-08df45906e0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On GFX IPs with multiple XCCs each XCC has an own GFXHUB, but the
setup_vm_pt_regs gfxhub callback programs a VMID's page table base on
every XCC. Callers which bind a VMID on a single VMHUB, like the SPM
VMID binding, have no way to reach one GFXHUB through the callback
interface.

Extend the callback with the mask of logical XCCs to program. gfxhub
v1.2 and v12.1 already implement an XCC-masked variant internally, hook
it up directly and drop their broadcast wrappers; the implementations
for IPs with a single XCC ignore the mask. All callers pass the full
mask, no functional change.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Assisted-by: Claude:claude-fable-5
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c |  3 ++-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c   |  3 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c |  3 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c        | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c        |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c      |  5 +++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c      | 13 +------------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c       |  5 +++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c       | 12 +-----------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c     |  4 ++--
 17 files changed, 48 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 1550e275f0ee..762b3a53ebbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -708,7 +708,8 @@ static void set_vm_context_page_table_base(struct amdgpu_device *adev,
 	}
 
 	/* SDMA is on gfxhub as well for Navi1* series */
-	adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base);
+	adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base,
+			amdgpu_gfx_logical_xcc_mask(adev));
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index 50535563efa8..837a17dd03de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -626,7 +626,8 @@ static void set_vm_context_page_table_base_v10_3(struct amdgpu_device *adev,
 		uint32_t vmid, uint64_t page_table_base)
 {
 	/* SDMA is on gfxhub as well for Navi1* series */
-	adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base);
+	adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base,
+			amdgpu_gfx_logical_xcc_mask(adev));
 }
 
 static void program_trap_handler_settings_v10_3(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index 96a308b94646..0c8983b353f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -606,7 +606,8 @@ static void set_vm_context_page_table_base_v11(struct amdgpu_device *adev,
 	}
 
 	/* SDMA is on gfxhub as well for gfx11 adapters */
-	adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base);
+	adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base,
+			amdgpu_gfx_logical_xcc_mask(adev));
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 0bc8d31081e6..475058562b75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -923,7 +923,8 @@ void kgd_gfx_v9_set_vm_context_page_table_base(struct amdgpu_device *adev,
 
 	adev->mmhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base);
 
-	adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base);
+	adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base,
+			amdgpu_gfx_logical_xcc_mask(adev));
 }
 
 static void lock_spi_csq_mutexes(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c5a2dcff5058..f42fe3510f16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -170,6 +170,24 @@ static bool amdgpu_gfx_is_compute_multipipe_capable(struct amdgpu_device *adev)
 	return adev->gfx.mec.num_mec > 1;
 }
 
+/**
+ * amdgpu_gfx_logical_xcc_mask - mask of the logical XCCs
+ * @adev: amdgpu device pointer
+ *
+ * The GFXHUBs, and everything else going through GET_INST(GC, ...), are
+ * indexed by logical XCC. adev->gfx.xcc_mask holds physical instances
+ * and can be sparse when an XCC is harvested, so it must not be used to
+ * iterate the GFXHUBs.
+ *
+ * Returns: the contiguous mask of the logical XCCs.
+ */
+uint32_t amdgpu_gfx_logical_xcc_mask(struct amdgpu_device *adev)
+{
+	int num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+
+	return num_xcc ? GENMASK(num_xcc - 1, 0) : 0;
+}
+
 bool amdgpu_gfx_is_high_priority_graphics_queue(struct amdgpu_device *adev,
 						struct amdgpu_ring *ring)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 6529c395f5bc..b7354a7dce79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -597,6 +597,7 @@ static inline u32 amdgpu_gfx_create_bitmask(u32 bit_width)
 	return (u32)((1ULL << bit_width) - 1);
 }
 
+uint32_t amdgpu_gfx_logical_xcc_mask(struct amdgpu_device *adev);
 void amdgpu_gfx_parse_disable_cu(struct amdgpu_device *adev, unsigned int *mask,
 				 unsigned int max_se, unsigned int max_sh);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
index c7b44aeb671b..65893a40c959 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
@@ -27,7 +27,7 @@ struct amdgpu_gfxhub_funcs {
 	u64 (*get_fb_location)(struct amdgpu_device *adev);
 	u64 (*get_mc_fb_offset)(struct amdgpu_device *adev);
 	void (*setup_vm_pt_regs)(struct amdgpu_device *adev, uint32_t vmid,
-			uint64_t page_table_base);
+			uint64_t page_table_base, uint32_t xcc_mask);
 	int (*gart_enable)(struct amdgpu_device *adev);
 
 	void (*gart_disable)(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 08d3ff61edcc..c0efb90e1d2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -806,7 +806,8 @@ void amdgpu_gmc_bind_vmid(struct amdgpu_device *adev, unsigned int vmhub,
 	if (is_mmhub)
 		adev->mmhub.funcs->setup_vm_pt_regs(adev, vmid, pd_addr);
 	else
-		adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, pd_addr);
+		adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, pd_addr,
+				amdgpu_gfx_logical_xcc_mask(adev));
 
 	amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, TLB_FLUSH_LEGACY);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
index 8be912d50601..0b7d89d04f4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
@@ -122,7 +122,7 @@ static u64 gfxhub_v11_5_0_get_mc_fb_offset(struct amdgpu_device *adev)
 }
 
 static void gfxhub_v11_5_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
-				uint64_t page_table_base)
+				uint64_t page_table_base, uint32_t xcc_mask)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
@@ -139,7 +139,7 @@ static void gfxhub_v11_5_0_init_gart_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
 
-	gfxhub_v11_5_0_setup_vm_pt_regs(adev, 0, pt_base);
+	gfxhub_v11_5_0_setup_vm_pt_regs(adev, 0, pt_base, BIT(0));
 
 	WREG32_SOC15(GC, 0, regGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
 		     (u32)(adev->gmc.gart_start >> 12));
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
index 4144c1c2ee13..9bfd97671699 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
@@ -125,7 +125,8 @@ static u64 gfxhub_v12_0_get_mc_fb_offset(struct amdgpu_device *adev)
 
 static void gfxhub_v12_0_setup_vm_pt_regs(struct amdgpu_device *adev,
 					  uint32_t vmid,
-					  uint64_t page_table_base)
+					  uint64_t page_table_base,
+					  uint32_t xcc_mask)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
@@ -142,7 +143,7 @@ static void gfxhub_v12_0_init_gart_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
 
-	gfxhub_v12_0_setup_vm_pt_regs(adev, 0, pt_base);
+	gfxhub_v12_0_setup_vm_pt_regs(adev, 0, pt_base, BIT(0));
 
 	WREG32_SOC15(GC, 0, regGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
 		     (u32)(adev->gmc.gart_start >> 12));
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index b13967a1c8fb..afcf7a58cae4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -79,17 +79,6 @@ static void gfxhub_v12_1_xcc_setup_vm_pt_regs(struct amdgpu_device *adev,
 	}
 }
 
-static void gfxhub_v12_1_setup_vm_pt_regs(struct amdgpu_device *adev,
-					  uint32_t vmid,
-					  uint64_t page_table_base)
-{
-	uint32_t xcc_mask;
-
-	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
-	gfxhub_v12_1_xcc_setup_vm_pt_regs(adev, vmid, page_table_base,
-					  xcc_mask);
-}
-
 static void gfxhub_v12_1_xcc_init_gart_aperture_regs(struct amdgpu_device *adev,
 						     uint32_t xcc_mask)
 {
@@ -808,7 +797,7 @@ static void gfxhub_v12_1_init(struct amdgpu_device *adev)
 const struct amdgpu_gfxhub_funcs gfxhub_v12_1_funcs = {
 	.get_fb_location = gfxhub_v12_1_get_fb_location,
 	.get_mc_fb_offset = gfxhub_v12_1_get_mc_fb_offset,
-	.setup_vm_pt_regs = gfxhub_v12_1_setup_vm_pt_regs,
+	.setup_vm_pt_regs = gfxhub_v12_1_xcc_setup_vm_pt_regs,
 	.gart_enable = gfxhub_v12_1_gart_enable,
 	.gart_disable = gfxhub_v12_1_gart_disable,
 	.set_fault_enable_default = gfxhub_v12_1_set_fault_enable_default,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index c35856180c3c..a3ef12d6b20a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -38,7 +38,8 @@ static u64 gfxhub_v1_0_get_mc_fb_offset(struct amdgpu_device *adev)
 
 static void gfxhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev,
 					 uint32_t vmid,
-					 uint64_t page_table_base)
+					 uint64_t page_table_base,
+					 uint32_t xcc_mask)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
@@ -60,7 +61,7 @@ static void gfxhub_v1_0_init_gart_aperture_regs(struct amdgpu_device *adev)
 	else
 		pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
 
-	gfxhub_v1_0_setup_vm_pt_regs(adev, 0, pt_base);
+	gfxhub_v1_0_setup_vm_pt_regs(adev, 0, pt_base, BIT(0));
 
 	/* If use GART for FB translation, vmid0 page table covers both
 	 * vram and system memory (gart)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index e89813590539..79653ffd42b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -62,16 +62,6 @@ static void gfxhub_v1_2_xcc_setup_vm_pt_regs(struct amdgpu_device *adev,
 	}
 }
 
-static void gfxhub_v1_2_setup_vm_pt_regs(struct amdgpu_device *adev,
-					 uint32_t vmid,
-					 uint64_t page_table_base)
-{
-	uint32_t xcc_mask;
-
-	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
-	gfxhub_v1_2_xcc_setup_vm_pt_regs(adev, vmid, page_table_base, xcc_mask);
-}
-
 static void gfxhub_v1_2_xcc_init_gart_aperture_regs(struct amdgpu_device *adev,
 						    uint32_t xcc_mask)
 {
@@ -633,7 +623,7 @@ static int gfxhub_v1_2_get_xgmi_info(struct amdgpu_device *adev)
 
 const struct amdgpu_gfxhub_funcs gfxhub_v1_2_funcs = {
 	.get_mc_fb_offset = gfxhub_v1_2_get_mc_fb_offset,
-	.setup_vm_pt_regs = gfxhub_v1_2_setup_vm_pt_regs,
+	.setup_vm_pt_regs = gfxhub_v1_2_xcc_setup_vm_pt_regs,
 	.gart_enable = gfxhub_v1_2_gart_enable,
 	.gart_disable = gfxhub_v1_2_gart_disable,
 	.set_fault_enable_default = gfxhub_v1_2_set_fault_enable_default,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 04778f9f95bd..0aabd25e1c71 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -118,7 +118,7 @@ static u64 gfxhub_v2_0_get_mc_fb_offset(struct amdgpu_device *adev)
 }
 
 static void gfxhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
-				uint64_t page_table_base)
+				uint64_t page_table_base, uint32_t xcc_mask)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
@@ -135,7 +135,7 @@ static void gfxhub_v2_0_init_gart_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
 
-	gfxhub_v2_0_setup_vm_pt_regs(adev, 0, pt_base);
+	gfxhub_v2_0_setup_vm_pt_regs(adev, 0, pt_base, BIT(0));
 
 	WREG32_SOC15(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
 		     (u32)(adev->gmc.gart_start >> 12));
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 6c77c17878f8..3f2661f8531e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -121,7 +121,7 @@ static u64 gfxhub_v2_1_get_mc_fb_offset(struct amdgpu_device *adev)
 }
 
 static void gfxhub_v2_1_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
-				uint64_t page_table_base)
+				uint64_t page_table_base, uint32_t xcc_mask)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
@@ -138,7 +138,7 @@ static void gfxhub_v2_1_init_gart_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
 
-	gfxhub_v2_1_setup_vm_pt_regs(adev, 0, pt_base);
+	gfxhub_v2_1_setup_vm_pt_regs(adev, 0, pt_base, BIT(0));
 
 	WREG32_SOC15(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
 		     (u32)(adev->gmc.gart_start >> 12));
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index e2b9fd0c8af0..fdb47bf557c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -117,7 +117,7 @@ static u64 gfxhub_v3_0_get_mc_fb_offset(struct amdgpu_device *adev)
 }
 
 static void gfxhub_v3_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
-				uint64_t page_table_base)
+				uint64_t page_table_base, uint32_t xcc_mask)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
@@ -134,7 +134,7 @@ static void gfxhub_v3_0_init_gart_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
 
-	gfxhub_v3_0_setup_vm_pt_regs(adev, 0, pt_base);
+	gfxhub_v3_0_setup_vm_pt_regs(adev, 0, pt_base, BIT(0));
 
 	WREG32_SOC15(GC, 0, regGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
 		     (u32)(adev->gmc.gart_start >> 12));
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index fa8b966b7ea1..4e6e35120b6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -120,7 +120,7 @@ static u64 gfxhub_v3_0_3_get_mc_fb_offset(struct amdgpu_device *adev)
 }
 
 static void gfxhub_v3_0_3_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
-				uint64_t page_table_base)
+				uint64_t page_table_base, uint32_t xcc_mask)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
@@ -137,7 +137,7 @@ static void gfxhub_v3_0_3_init_gart_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
 
-	gfxhub_v3_0_3_setup_vm_pt_regs(adev, 0, pt_base);
+	gfxhub_v3_0_3_setup_vm_pt_regs(adev, 0, pt_base, BIT(0));
 
 	WREG32_SOC15(GC, 0, regGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
 		     (u32)(adev->gmc.gart_start >> 12));
-- 
2.34.1

