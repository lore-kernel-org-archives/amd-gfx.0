Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF58C982D7
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 15:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E87010E733;
	Thu, 17 Sep 2026 15:34:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vpRkJFHU";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0CAC10E72A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 15:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LscUNJ34USRRUje227ZFebnlFd9ey3hAmSl8NAxJBUGlJyQBg/z+yDhAoYpV23XI0WCnF3dtWa8SDh4I7c5fnF/Cm2tvJ69nGX/MX0Cbzo2WwQne0XxFJOpZ/kjjqCLIkinzl9uXniyBr9HD3rjFe6gLazyddjH04DSbVs0mN4F6HXsoJ6kTu4dFPj05X3turA5vT4NeaZ9qauU31fMWh7IK4Jw+Q3YawWe60fhYt/2hL+ApVkq21ma7zqpNOCkxqYw8yOvW7u3ercdLISBrbwIC2/U4i/7RESriWrQQ0DoAzidjHYgQCFNA6ubwlai8Fh3Wmh25g014woTDJsTvzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvufNJiREUzCWF9egbNAm0RDB46VLkWGC8KVr5HvI0g=;
 b=c6FEsfEoh75RTwcKmIxoPek/FEa96EfgF7iPyzS9unl0KRdFDYD2CrQW0C8K9v0NfcmkIQLf8d0W4rNfN+rtQvuVTQVm5ocIapNfRJFq1J7cm2gL1APR2oSKJdAB1c8zFXxtrKNQzC8RaCP9BnMxaUWWDk9LTJMk5EGeiY3Uccsqv/6XiJSJoiYl5dz/uY0jQwjn16bbV0EC7keSiTj+jBrsBrBHeHvSrYYDV3Go66eKpgAym0dV5Jr0P1Zgp/C/BgBucB6/lG8tYh9vbB2bpn7CDWIbbjZOrbZdS9XymTH5yE/kIKtflitREugaZNnx75fSwVdJj1OdAmA1u7cp5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvufNJiREUzCWF9egbNAm0RDB46VLkWGC8KVr5HvI0g=;
 b=vpRkJFHUu54UdVfWVMi8+QALySEpfx9MZ6r2y2GrL2VFXl6/0GWo3OtmIGC9vfXD+ytYwFTqrhSxHsYEM5ZLGa1kSnbbNakxQQ3oacDmWh9mJZPbfC/EhAer7B5rD/H8g7trOKX10wfEnu44zoavNBGR75bWsFOYUA05CtDbiaE=
Received: from BY3PR05CA0041.namprd05.prod.outlook.com (2603:10b6:a03:39b::16)
 by PH0PR12MB8097.namprd12.prod.outlook.com (2603:10b6:510:295::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 15:34:12 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::6d) by BY3PR05CA0041.outlook.office365.com
 (2603:10b6:a03:39b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Thu, 17
 Sep 2026 15:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 15:34:12 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 10:34:09 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 10:34:09 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Prike Liang <prike.liang@amd.com>
Subject: [PATCH 1/3] Revert "drm/amdgpu: reserve root PD fence slots for userq
 eviction-fence rearm"
Date: Thu, 17 Sep 2026 11:32:04 -0400
Message-ID: <20260917153404.17610-2-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917153404.17610-1-vitaly.prosyak@amd.com>
References: <20260917153404.17610-1-vitaly.prosyak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|PH0PR12MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a93c743-0527-4eec-88b9-08df14d11ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|18002099003|10067099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: /Ih9bhhhcdEyf+1xXGqtxxd6l0pakET0Bu8RE1ARbORYobtiFlTARL38K+OZLSedxVqwMyUkZGXMcpoQEbKPcH2IzCIQ5buyDYFA5wmqyy+MUwjRyD03Up4c39t4TCmsVFEbqr9NUvTaS/dDXLAUAeyrgKwwUzg4n7tgdey923WJ3DaByvI4NwDsr1vDVx6imIomEWh8TYl98VriFaUEZ2DzhQYBiI0FEj57i87lrppTcSBxpcYY0l6FMdEmOizTCLqRoQkzYS3veOgbn+jR/omQV15VsGQc75TqcOX+8H7DcGkbiUvoIuS8n+L3SFKvphzRS0aAgGT0PjLpx0srsELm1tcB2EB0kxgNoLfGfd+RUp0axKDbTO/Vs0FDT7gHrjJ1OFuYVD7nSLZXzWBxlejq9prsUAJoUGtfgLB50PuWiGvfA/049ITCYINrD/Wk5Q/yZlOTbfTHEuzWDrESUET7NE5SyHf4SgwhbPJdgsktr8JfL9iHWBozby+j7rV3YJ045tXOV4qgvFO/QDP6WUURFUHOnq2ytwC5fGEm0uZgpSF1ck4qxKVCEvo62CZK1jUNQpCr7S1z6dUXUsNfZ5ydDoYMuOt3DVbPdRhM3uHGtX30rPKlTR4ThAjDf/trWlFOjctVwEFkzjsnK4osarMUbBeRYSKWVgdTNSQHfljj9IMFymmKyMgnQ/5VjFQ0Pi/uevtS4xwrVuLQVnnJTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(18002099003)(10067099003)(56012099006)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fvwcQz/tT3t1ZcAom4v9rzHqeZ+km9cRFI3bFs3lSW40Ux5M1Xxt+36hSN3uk4FMAwUkpbXkRI6NBh6ZiQnOvjFGxdCgwFNVYhwmvlKj58aEf6yz9fhLRpKGm2gpDITPM3M/muKX1RFk4tre1UMY1xi079wgKmuTru/XGNKCm8ZsZXU0fhNj6r5FhogITbbbPxGHng+aOpEnwxluiYJjXQ2K7TVFEAGfbzYR27vUPuBRfAJXQUB4ITwnAQNau0w/tJOAvoRr+klmsudSYeVC5rg3BTsXv7SEowQ0elyervpnPmcn66GhCM4ahnf2HD3tY+QuJjhpV1bPhFNvuKWdwC00ss84WHI7zcwWiTs7l3FWHCgTIVuP/+/qnyzMwkELUlm6NeA8sN5n/UxD0qaYXTenyFB8xalpjy1fLzXgGDPmAnNC2VoBK3jE+4zipYr7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 15:34:12.5890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a93c743-0527-4eec-88b9-08df14d11ffc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8097
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

The root PD reservation is no longer needed after reserving the eviction-fence slot
at the userq rearm attach site. The rearm path now reserves capacity immediately before
attaching the replacement BOOKKEEP fence, where the reservation lifetime and the locked
BO are known. Keeping the caller-side root PD reservation would retain unnecessary fence
capacity and duplicate the protection.

This reverts commit 00af92666f29 ("drm/amdgpu: reserve root PD fence slots for userq eviction-fence rearm").

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Prike Liang <prike.liang@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Change-Id: I98c1c9b096ec03fe8e27eda867ca1836abbe6322
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 5d07320a29b2..d83953a1c076 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1043,11 +1043,7 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 retry_lock:
 	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&exec) {
-		/*
-		 * Rearm adds one BOOKKEEP fence and validation may queue move fences
-		 * on the root PD BO, so reserve caller-side slots accordingly.
-		 */
-		ret = amdgpu_vm_lock_pd(vm, &exec, TTM_NUM_MOVE_FENCES + 1);
+		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(ret))
 			goto unlock_all;
-- 
2.55.0

