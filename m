Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39556CA5FA1
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 03:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6458910EC8F;
	Tue, 29 Sep 2026 03:47:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BiyG4dq6";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78FBD10EC84
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 03:47:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekvESBMADIQZpoRm4rTLJYirIuWbJyx9WAA3E9Wx4RX9vQRayiZMopCDZRvPr5LKiCg1YaLjaMP/0/MPJj8+uH4msb16DNFbmde9lgxFkFkXtZp3MuLAqJ6QZQyVkdc08PWHeZy6DejbwHlLsMokacGYvisM6mhxXag9EB2UcqgvHtm34S4mSRO4otc3VsAuKiKJIsQlcsb+/z2m+wtpCuTcfet/dkU0YyE6LkFNOD4gFzA7L8uQp+Fh7CdMC1XL4G1RWJnijdScz/oFzfNzEQjkPzEImAVaUIz1RhX9kqk3B6o60mU6KDzVd8uPB3ylOblnRBgYm6zTZR/PcUSHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHEi5OIeanD9gHSHoYugxIkJuZFm36t4p3+KlBf10Y0=;
 b=YMfGtojCcbCGJF2fFDfYtRm+xkZEznlNiw46hlUK0vFm0g4BAVXsBgbKBMcgzPus3Xx2Lc0VYFVwM99OsvMIRdLp4wOnd2gOcFUL7ZpnWqcIm2q35cyidLUWnoj4+e8VPaxp2EdN2+0PkQKnbFMqkoZFjvIUodzcExbD55SW2z6P4pwCgIu5qf6O1cnKtH4/eok/WPJnSIH0W7ZqVAOMbhC4xPiQ/ehUpxrGSJFUqGBdIBVMdcWkkohBQjRWKPEvQWzJq9ncLFiC2UYmgcTMrECQbzELYFW8HvaPuYCqfDjyNrTOZWo9KrsAmBqhz/SKSIwa+h4MfjspG3TqmXbr7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHEi5OIeanD9gHSHoYugxIkJuZFm36t4p3+KlBf10Y0=;
 b=BiyG4dq6vrHZuDyUXHYgRAgLcQLP8glFFq8MG2mGbLPkYLTMPXZzMdFsbngEE+X+FJ1ucWUY+UJNne3mEtbDwBr7MKVVXfUY82DRLofSyVEWZ9Ithris5H3Y4x0LeooTI52t7r/f1nsUgfQza2FeWSAVm9yg9ImBnMhqxX8zb1E=
Received: from CH2PR18CA0019.namprd18.prod.outlook.com (2603:10b6:610:4f::29)
 by DSVPR12MB999147.namprd12.prod.outlook.com (2603:10b6:8:38b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 03:47:15 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::8a) by CH2PR18CA0019.outlook.office365.com
 (2603:10b6:610:4f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 03:47:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 03:47:14 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 22:47:09 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 07/14] drm/amdgpu: finish GPU recovery callbacks before
 restarting schedulers
Date: Tue, 29 Sep 2026 11:46:43 +0800
Message-ID: <20260929034650.2393125-7-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929034650.2393125-1-Prike.Liang@amd.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|DSVPR12MB999147:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c27f18e-0182-4c37-e2ec-08df1ddc59fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|22082099003|56012099006|6133799003|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: wWAAvKHrLo06SUMTnzGe9llC0mKmc4b4Wtvi3TWZwF0eXMmPsHZ1y4BlgzwrDVVQWr9pPb0VlDXqoO4+TatBLyfR1eaLKLlJBpI06ablNhltfj9b40vZve3e/4uebimtwBTPtAqb1TojXgW3aGP1T6iZnRXbbbwvuFUKEFnPB1X4dIz9SPn+MneUAzyzcsN63qF79hQPk4QXy+I6vcBskvaFO5lwAg7iMCBstI+aVD/ar7sIS90nyZwl9RK8N4j6vLJBhTtmo3BKRy6xH+v25moK/LYtO9ZD449udlUsZNiNEnk0nd+h8FK97mLztPmSfa2fTCQD7ZVdTvDSs3X/uCsUiJX/aNHlvsjPTBw1vR2N0fdcBk06BiY1WRjnSZBCtBvZPjgZl6NgfyuhhddquCa4dIxyU2IxDUATkOVAFu8oRPueb29xL3C42a1LYnF3SUgo0dnNnlkbg3nVjGLTYMXP9nQ8aR8PuVYsCQf22WKCFT7g4j1ZH2Hau52ub8EDkQJ+aLtSdqQtro4Ox4xZ0FShkfm0uMTCIG5ptjr2WhxucXQS08/K55NaYDRwqpYw8Eti1uoH1DXN1acyAVSjNF+tWMIkRIIIIUZhvZf7sCanb/Q9QcgRQLvkFV5y1Ff9q7R3uxmQ69B543UcWCKj3S31zdPaDXUSVp5Sq0+S+06SDKV5RDjWhJksoeIeDsa5SUI1g7NCIx0y67CWcMzV+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(56012099006)(6133799003)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e086mOdZSaLQxhs072HPapRFrF7O6hwa6TLeiiFRy2P9IwncAXBj3ruD7FNbVOMcSZrLanPQcpU125G0KTWeWOFcoedubSLqTmbeMt5RcxuOgLmnER12AajffMWWd0UWJYhhbFvHIHA79kIu8dFTfS1Kaftwq1JhrqjziWdMsVg+vnE2+Yh8qLtwSvQGua0f4VZxaa53l9XE/PoGyVX6H5GVXrJcWQr09V/1p823n9b7CbSf3dThDZiVPzSRAoX7r6dUlDl90Axr5sulzPu4CDn6gZIoV45s92EvNIqKd42dOyZSZRbY4Sm5w5qzZ/X+8zSzQrGuwSRGMydHdY/WEvnp3djC6EXbsUVb9lB9FRJ5fj8Inl0wZKb3ZgKG976DUJN72d/Grz+1ohQRckXVa3N9DiUIGtyQ84jiXilShQUky0NWCen7gjDvpTuYEVGD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 03:47:14.9227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c27f18e-0182-4c37-e2ec-08df1ddc59fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999147
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

Run GPU post-reset callbacks, including KFD and display-audio resume,
before restarting DRM scheduler workqueues. IP hardware initialization
already happens inside ASIC recovery; this change orders the remaining
callbacks before new scheduler submissions. Preserve the emergency-stop
and guity job completition path's callbacks without starting schedulers,

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fa67de6d066c..83d98c9191b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5783,8 +5783,10 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 	amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
 				      hive, need_emergency_restart);
-	if (need_emergency_restart)
-		goto skip_sched_resume;
+	if (need_emergency_restart) {
+		amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
+		goto reset_unlock;
+	}
 	/*
 	 * Must check guilty signal here since after this point all old
 	 * HW fences are force signaled.
@@ -5794,18 +5796,17 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (job && (dma_fence_get_status(&job->hw_fence->base) > 0)) {
 		job_signaled = true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
-		goto skip_hw_reset;
+		goto post_resume;
 	}
 
 	r = amdgpu_device_asic_reset(adev, &device_list, reset_context);
 	if (r)
 		goto reset_unlock;
-skip_hw_reset:
+post_resume:
+	amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
 	r = amdgpu_device_sched_resume(&device_list, reset_context, job_signaled);
 	if (r)
 		goto reset_unlock;
-skip_sched_resume:
-	amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
 reset_unlock:
 	amdgpu_device_recovery_put_reset_lock(adev, &device_list);
 	amdgpu_ras_post_reset(adev, &device_list);
-- 
2.34.1

