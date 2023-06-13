Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F467EB64D0
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 15:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C0D910E021;
	Tue, 13 Jun 2023 15:39:47 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B0810E021
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 15:39:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fn6gg4I2RZduttUPxDZJVU+GjrnbsWUdQVSKqUXWc2JzGBbFAp4+WZg8DwqrYZ7T0aDjYSQHGxmM1IEM0XOKSALufAHCMWgmwrOTKzLlKFKYlaUnE15liWfw3pZe0xSaV06ys0T8OIb4kj6WJgrrHVeaLmh6YTBi+VciNFCRb29qGhyW/lisNc4/9dnQwes8vaaR4iqWcBE95LpmzJr8j59r6Hll0pamPzaMa0GR8ZPEISUGu05PlyZUl5h31RIH5+CHryJLDU4phay90rQVAVnZ1dAc6dg93vJp53EI97SPoZXTkXelM3OdHY8kFB78R4NhafYBE23bDtIV1c1MzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItsIZ4Bx89lcOeCPsRNGPCTzyGRzHj9YZTK5q20s4S4=;
 b=j//TLWEOSgHozzxpWFnpiO0JR64UTJQz32LGEsZdY3aYK7Ne48GO2DY8V6XmK8Ea7UlqjSD9OhP7+Z8M0xCde9Ae0OfoC7G2O9450+1px9Xyz3N8AKVwX1ddYu2GfqHEgxT4m6nwvMaweLDNYeY2ku/XfsW1sEyIcxW6VgH8axwqZSjbRChK7YiGElHUWk1VDLVHJCOBmYgk/d87/xbnlzSsqHpVUS4zD5NIaq1Q7MfdVWNqp1R6vs4oJYrJlk2OcreWgLXsXtuVcdv8HJNJRGxjczh1hmraS763LCnJVMZ1SSt/XaSs6bXrNYoteVqVJ7h9yCSe/N4IdTfSaNUiog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItsIZ4Bx89lcOeCPsRNGPCTzyGRzHj9YZTK5q20s4S4=;
 b=uNUh/mYMEwzTGJBS5C2HMNS4zQs4MPlSn49wc1ep1BqnAwIfgJdQFaHgYNefDboyZsRP29tOdw/8X3bv1DFnOM1oDwcyuypbKC7uj/nCj2TIRikhnUIBT0tb+KkRJFO5FlJBfFXJhKkFglV+v4eOlHOmI6RLWHIkW/4FtnliFko=
Received: from CY5PR15CA0228.namprd15.prod.outlook.com (2603:10b6:930:88::27)
 by SN7PR12MB7132.namprd12.prod.outlook.com (2603:10b6:806:2a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Tue, 13 Jun
 2023 15:39:41 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:88:cafe::74) by CY5PR15CA0228.outlook.office365.com
 (2603:10b6:930:88::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 15:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 15:39:41 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 10:39:34 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCHv3] drm/amdgpu: Update invalid PTE flag setting
Date: Tue, 13 Jun 2023 11:38:58 -0400
Message-ID: <20230613153858.909129-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SN7PR12MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 8334251e-86c0-404d-725f-08db6c246772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m4lOKq3/6cRP6ff9e3vJmL/KEhnLx+WGsemFcxpDKl5M/LtrZ4ZV8I1N9oAMgUlFzoZKix51p97g5a4ivWiCMMQj27U3lVow2r4Arodaazi1oLWg+5KqujCxfqdskAf27Q03qg/NasLuAULrhtgdhA1zORvHJXdvXP4kdVzTu8QmUpTzpKktc7EPsgaLlqF9QI24oboGvdFU7sUOBbRiOkrS0XI8o0uw3+/8yGYD7rHONPx9RrolpcTiGM9ZoKQ/jKscqDMJQebZ+4M9AZlutx6ijrG8lroXEtJrud6II9YFw+FOFoFNQ+C5iqX8N0Y2vKAtJOnBAWb47WrpK7dFOmWqCSRuMjehll0NqcNfoWnuQ8VwzQk/N+SZJzqDr8lV2Cr9Rgq4hUwBmSXYhvtT/wGH5KDgZ5g00aEfcjU+2tlK+oJSnFsrZKyJgfE2eLcFwI6/V0c2OYlAPo1F8MRFOjIKTn+JKFMGzKdU7BKMm+x2df3xVjyKonrlexw+ep6FoOkXY8AI1qx5Nvd5vsLpr4EVG22MoRzx/86kknbWBdlO4XmBlPAxEAz++M3/aTnPfu8IeBW2gwF1m6vm7jNM4b+MwtyLoPItUpe0ipUZ1yg75H/f/sNytJsZFIJ2KDTmD5aQlKXY9li5sC8Lvt8AtZNtIpm2i6M0qVrZq552tt7Vkw57iK5mAuIqop5QYmdlx/ctAZQzEDe8Gs0BwVUm8bwO7y/nm/8je0ArtDSmFBPhO06mHTKRa+N3dulr7Bgc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(1076003)(16526019)(26005)(186003)(2616005)(44832011)(54906003)(426003)(336012)(47076005)(6916009)(83380400001)(6666004)(36756003)(2906002)(82310400005)(7696005)(15650500001)(36860700001)(8676002)(82740400003)(8936002)(40480700001)(478600001)(5660300002)(4326008)(86362001)(316002)(40460700003)(356005)(41300700001)(70206006)(70586007)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 15:39:41.2295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8334251e-86c0-404d-725f-08db6c246772
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7132
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the invalid PTE flag setting with TF enabled.
This is to ensure, in addition to transitioning the
retry fault to a no-retry fault, it also causes the
wavefront to enter the trap handler. With the current
setting, the fault only transitions to a no-retry fault.
Additionally, have 2 sets of invalid PTE settings, one for
TF enabled, the other for TF disabled. The setting with
TF disabled, doesn't work with TF enabled.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Update handling according to Christian's feedback.

v2->v3:
- Remove ASIC specific callback (Felix).

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 21 +++++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 1cb14ea18cd9..ff9db7e5c086 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2583,7 +2583,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		/* Intentionally setting invalid PTE flag
 		 * combination to force a no-retry-fault
 		 */
-		flags = AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT;
+		flags = AMDGPU_VM_NORETRY_FLAGS;
 		value = 0;
 	} else if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_NEVER) {
 		/* Redirect the access to the dummy page */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 9c85d494f2a2..b81fcb962d8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -84,7 +84,13 @@ struct amdgpu_mem_stats;
 /* PDE Block Fragment Size for VEGA10 */
 #define AMDGPU_PDE_BFS(a)	((uint64_t)a << 59)
 
+/* Flag combination to set no-retry with TF disabled */
+#define AMDGPU_VM_NORETRY_FLAGS	(AMDGPU_PTE_EXECUTABLE | AMDGPU_PDE_PTE | \
+				AMDGPU_PTE_TF)
 
+/* Flag combination to set no-retry with TF enabled */
+#define AMDGPU_VM_NORETRY_FLAGS_TF (AMDGPU_PTE_VALID | AMDGPU_PTE_SYSTEM | \
+				   AMDGPU_PTE_PRT)
 /* For GFX9 */
 #define AMDGPU_PTE_MTYPE_VG10(a)	((uint64_t)(a) << 57)
 #define AMDGPU_PTE_MTYPE_VG10_MASK	AMDGPU_PTE_MTYPE_VG10(3ULL)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index dea1a64be44d..45b26cad59cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -778,6 +778,24 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
 					1, 0, flags);
 }
 
+/**
+ * amdgpu_vm_pte_update_noretry_flags - Update PTE no-retry flags
+ *
+ * @adev - amdgpu_device pointer
+ * @flags: pointer to PTE flags
+ *
+ * Update PTE no-retry flags when TF is enabled.
+ */
+static void amdgpu_vm_pte_update_noretry_flags(struct amdgpu_device *adev,
+						uint64_t *flags)
+{
+	/* Update no retry flags when TF is enabled */
+	if ((*flags & AMDGPU_VM_NORETRY_FLAGS) == AMDGPU_VM_NORETRY_FLAGS) {
+		*flags &= ~AMDGPU_VM_NORETRY_FLAGS;
+		*flags |= AMDGPU_VM_NORETRY_FLAGS_TF;
+	}
+}
+
 /*
  * amdgpu_vm_pte_update_flags - figure out flags for PTE updates
  *
@@ -804,6 +822,9 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
 		flags |= AMDGPU_PTE_EXECUTABLE;
 	}
 
+	if (adev->gmc.translate_further && level == AMDGPU_VM_PTB)
+		amdgpu_vm_pte_update_noretry_flags(adev, &flags);
+
 	/* APUs mapping system memory may need different MTYPEs on different
 	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
 	 * to be on the same NUMA node.
-- 
2.35.1

