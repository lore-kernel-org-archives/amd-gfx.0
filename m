Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A0DC5516F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 03:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15B6110F135;
	Fri, 31 Jul 2026 03:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dfTPN36q";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FF5010F118
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 03:10:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KA42ftiwvspRDdEO8tvRC1AX3hRmthWpSsUepB+9qzJ9JplAQoBfUkhJ2yV31wJ+/oq3p+6wQ1MlCuRqcpzz5oRxLxuoLCIf2EWeNaWOcMsvANViyXm7UR+nTQ8iXKtyQYbMBby1fz40/LqWEf7+dKgFOwIiPgcMYvEDQEgLzgaT0/3IptjIEOEW8toZXAok62WCCFaDmoCppVao6DyFICRlij15e+M6O+FRat4xwuR1EqMBDvgsPY8IV3ItE2/6ivimN8MHnxS7G9rpttbwYpaW/UPMQDDpgPmDJB6pCZXLKKAV+iml5sZYwCiExiHYrnhji/vfvflxg+dmR5T6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQlkiNtrGnrSsf147gnfe5VbjMH1k1gprK7bH8SmBFw=;
 b=ntSjdZSbK9JIMYlORbPR2oeDexc+yZGmSHqBoqA6pzhVhJMvbneYHyiRnHWCBqH/8CQ9C9GossWLdrIL9t0NuP+GuZcnD8sVVDqOSelmuvpJapzIZiYIZZOoFehJ1b8OHfl680L1/jnQQs5uvI0WbyQVCJTIkOAE1hUC0th3EmuTJh7t5njHKk5L124kOj5NPS2D0adCtvU8mu/eohRq3huFlgZGecPPEMR+pevRDkK9Ui00YoUn6Pk75dg1I6UVcrghV+xFQHc9E+SLWhpdkuxqE0Qp3kCjrCFY7TIRkg/rDSPSxrAyepzP60kuSB+at7v7XL7MiRZZjEDhx2V9XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQlkiNtrGnrSsf147gnfe5VbjMH1k1gprK7bH8SmBFw=;
 b=dfTPN36qpc/auNmjA3cUhQkaUHDZJau2wWpmIcs4PbSpitoPJshUjFZyU0GA/iH/CtWvmhhxLDwoa4JB1aLwDJ0SvkkopR1EHbkDmZb+ukkmcpZ0pycYN3X9sSA+iz+VdShsiw7ZFPXuy4/yU5aPN3nYHfNoqOazONs9Emq70Kc=
Received: from SJ0PR03CA0355.namprd03.prod.outlook.com (2603:10b6:a03:39c::30)
 by SA1PR12MB9003.namprd12.prod.outlook.com (2603:10b6:806:389::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 03:10:43 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::8f) by SJ0PR03CA0355.outlook.office365.com
 (2603:10b6:a03:39c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Fri,
 31 Jul 2026 03:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 03:10:42 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 22:10:40 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 4/4] drm/amd/pm: restore user PPT limits after GPU reset
Date: Fri, 31 Jul 2026 11:10:22 +0800
Message-ID: <2df05c6292b039bc894807f28befe9c180d476d9.1785467079.git.kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785467079.git.kevinyang.wang@amd.com>
References: <cover.1785467079.git.kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|SA1PR12MB9003:EE_
X-MS-Office365-Filtering-Correlation-Id: b80ba569-f8ba-47d2-9266-08deeeb14ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rl1Qctx92ey7dQD0CGjmatdE+JLSBuWaM1+4G1H+dInXKqkp+cvSXsqi03scp7fCFJp8bptl1qaY7lZYkCX7/pvJjw6/0Qt+hF8HYF03Doo0ICWF1b8ZgsvI4xrPFBOSi6VrwpYy6oIxR46RMOb91Wj1SQ4oXdVMAoWVskRK+/BV4t+F3JbWFXQs70BYxi51AM4kK+ScjYn/kom7vnseCUTMMUJntXKSW56tpht+rmomrekKQGUi9Y4AqYaeiiRXCbAUw7AEovcNCRpOknDE1iE07nVkpri1thIGFuFhvO0QhYsK63gPHS9OPTye7LHF71XljsDB7kPlHkbY4G5cGiu7qKpHN9hfpMTmoLIoJ/kLI7XP5kF4D3aER8VZQv6GThtFRC1SBV6tXUqC+LmJvGLX6jmOp0iY0ws03VD9HlmezQaz/Jwo7EyR5nNU6kvcvlR2iA0Deo4oIx2W6CqUIRhEV7IX0JRjuej6W/LkUBAheFgf3vZy3XnMUO0D/8NXY2g9PRDwrgE8pPEJzqWi2f3qhmJopF6Vk0ImLxRQFyDUOd/1XixS9/GIkGTdN6FNr0h4plZfNAl+YC2vlW+MpSc5uWzL1HsI8S43cJzPieeWYIYNr0x0ro6OnVoyjvmsWOZ0dftfoiQmVYFY1sJ5lEMupEXUqm3KmF+GPlUByIpu1A6YHR6ak/wlPVN5HFy6isLikLjKOvt+1r4mMV8eDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UT9uPcfQWeheltb55zx8tHy/M/LhPK4af9eS6366RxxSGcX/eNwqYxLqaHPDuuFUy7vNTusDkJVF+cYSo7vsxGtHcuU3djQ65xyD3blFHg1cK6NzEtSittDUXWyMNDzhPCaBEPpnmxxe6rdWq4taYQl6DQXit0VlxD9A9Lr4QuW+cQ8ccqfl3+c12aCBbMyDobgiBm/cp08aW/3gGh5GTkecj/CbvTWmfCiXQdrNS53zvKT+XzbXW73ljcEznwJrElsrONb29cpn2350ftpweK81/nF4kT/3OTlZneZaLkUU5wR03/vksgP6fiVYc2RHClABPqMrCT2O+DzeaY6yMuVDE8mObeuFs9qcY5mh421i1dHxb59gPI+lRtCeZ1cwcO018Iu1euCYs39sS87lt2x1BaPVfX9+vjDFKb9li+qyX6AC/pMj5jLtVgmOkZbj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 03:10:42.7677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b80ba569-f8ba-47d2-9266-08deeeb14ea1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9003
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

GPU reset reinitializes PMFW and reloads the platform power table. The
saved user policy remains valid, but suspend-only restore does not run
because adev->in_suspend is clear.

Restore the active PPT policy from SMU late initialization while the
device is in reset recovery. Route each value through the common range
validation and ASIC setter before updating PMFW.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 43d5dd7dce7e..bfe2c0bf426d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -28,6 +28,7 @@
 #include <linux/reboot.h>
 
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_smu.h"
 #include "smu_internal.h"
 #include "atom.h"
@@ -996,7 +997,7 @@ static int smu_late_init(struct amdgpu_ip_block *ip_block)
 		return ret;
 	}
 
-	if (adev->in_suspend)
+	if (adev->in_suspend || amdgpu_reset_in_recovery(adev))
 		smu_restore_ppt_limits(smu, false);
 	smu_restore_dpm_user_profile(smu);
 
-- 
2.54.0

