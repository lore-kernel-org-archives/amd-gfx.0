Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A98C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 05:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B9BA10E47A;
	Wed, 28 Feb 2024 05:05:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KXnD6KkN";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47DB410E47A
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 05:05:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmtQ19MuM5D7aApErggA094ygWsBgdW4+zMSZKjodbQjaTpuXE5iXqTl6EGcLEMGpSAr/iPyRS2iq34JYWvwy+Zjxq20iEa3jJhRs+/kdYfCDS3x0I05pmJ/JFmTEeTAqvOKDonrmtVXAdxHh5gnczwK3BiiBT2Vm4UozuEyRg+4EuhysfCsIV8Xd8OSECmZ+X05ZI7sho2cuBw249wMHeCg1xhxkTbf2G//1OUIG1cbyfeH7J7UfXlzfjOlg2/GoOeNy+3Y98DL0TzNR9Tp818hTzSxsX+36WI+9JI/jzbggmZZdITN6pKkuXLC2Fo8IQECxgufaRPiM0B/45ZC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsAHdgUapKWPHmPDXJeDaq0juDEljhrUpPR973MmaQg=;
 b=NxhH3HtQWx7XYYkHMvxe+EpUxU5tvNwszecAVnY1t9+cm03/3IF36v2fCTX24q0iZbqd9AdbGWfzZLeAiA3UE2ZsXLQRww2rFNKAVyFifd2GUl/+64PZq9J8uQJgN1Sy26vGjNlzR9t0llKU7BQBW3noHbTdIqeVIvOhYMoBnXpdIUNTypov6Me5kIzbfETtVRFtvoGppQU2GKPsM8EhPeC2ZOjlmNiL5mTUCOx8Dl5gO0SYBgFxiXk759vsVElNWtPpkQprtOFpNUaAvUB4x0TfnzcqCjoztazBcVtAJ54JvulEYW1RAUp/lqFHYJ4V1wqtRLbmql6CmRxCe0JB7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsAHdgUapKWPHmPDXJeDaq0juDEljhrUpPR973MmaQg=;
 b=KXnD6KkNKHdBZqoJGSU2kbo5owj2YDa4eU+EqzATV7wNZBXTh3L5G/l9+TYYNtHqqZ2hvhfIQIhJeewMaRb6JhFTsH58Iv/6We7xvv2JhBXYgwZJk8BcQN7ylh9sCE1IAHrmlgP8baps3rMWCm7yX0nbr/s8MSOcmnxQ3XRnmJY=
Received: from BN1PR14CA0015.namprd14.prod.outlook.com (2603:10b6:408:e3::20)
 by CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 05:05:12 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::7d) by BN1PR14CA0015.outlook.office365.com
 (2603:10b6:408:e3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Wed, 28 Feb 2024 05:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.0 via Frontend Transport; Wed, 28 Feb 2024 05:05:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 23:04:48 -0600
Received: from jenkins-vm-jesse.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via
 Frontend Transport; Tue, 27 Feb 2024 23:04:46 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, "Arunpravin Paneer
 Selvam" <Arunpravin.PaneerSelvam@amd.com>, <Yifan1.Zhang@amd.com>,
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: remove vm sanity check from
 amdgpu_vm_make_compute" for Raven
Date: Wed, 28 Feb 2024 13:04:46 +0800
Message-ID: <20240228050446.89436-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|CH0PR12MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: fb34c3e8-84ba-4e74-8795-08dc381ad7d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vqb+ElwZLEGmYUrqKVOiTLe8xbdmzRQxBwsh6ASGVSbOmEbjVnoCQChENG7ofv6NTiv84xWNwgb8MFAGpsrAykk6Nnf1RV1xTA2sJOCqds/e4npwh8fEEYSgamLkOTcWb9Zug6/DfdY5LCBlvxJhOovAuHLYq43P7H9qBtcRuVtcn/twBhXHHamwfOuW8njMbpnu2wJAMgX61C4sQDxsg5e8JTOkY7fXwIwtbBHxYhy/U5R7J8yz1SC/E7SA8DLS+7FdTbkyKPRvEz3l7tche4jFAwbxU7oUqXrmtQ04TS5yyeN8c6zHy6neLituDq9AC2rKpm/1KrUZU8EOlb0bVVtPm/e3iG+LRJ71NmCQ4PGyIbg6DyoLnK7PqhSDtWsSr5c7dTrnqk+0BEHa2D1S41pay9XZsFnE4a5jiWnSv8xp1tkPPvmnSVXz8rsdYGyrDY31x+tMO15p5NGYFq03s0Zu+aQrO0FzXh3iYZW9NrlwDM2Nnjj7hhgfC+813HP38sXl3WW+JN08eDYPUlDSbg9MvD1QQ0muQweatuG65qWU0MTm/bx7w++hy3nqPsthPisKNPZFKkCCBwSpnnoNJSrz1FrORJoHx31olULmrVTAQpwfV5hfWvbdJjg0k3xo8oJrWa5BH0xdg3Rh0oO46PVef7FJ5PIyP4DnNHI317x1OdkUMmiEPaNJRBrQb6H6wG/RkOaSSgBfjGtFKoAley9G2IgxXop3umGFcyRqfwBn+SJDeOMgk2qNbCOLpNt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 05:05:12.0961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb34c3e8-84ba-4e74-8795-08dc381ad7d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463
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

fix the issue when run clinfo:
"amdgpu: Failed to create process VM object".

when amdgpu initialized, seq64 do mampping and update bo mapping in vm page table.
But when clifo run. It also initializes a vm for a process device through the function kfd_process_device_init_vm
and ensure the root PD is clean through the function amdgpu_vm_pt_is_root_clean.
So they have a conflict, and clinfo  always failed.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ed4a8c5d26d7..0bc0bc75be15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2361,12 +2361,6 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	 * changing any other state, in case it fails.
 	 */
 	if (pte_support_ats != vm->pte_support_ats) {
-		/* Sanity checks */
-		if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
-			r = -EINVAL;
-			goto unreserve_bo;
-		}
-
 		vm->pte_support_ats = pte_support_ats;
 		r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo),
 				       false);
-- 
2.34.1

