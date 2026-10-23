Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C02C606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uLcBAZTB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 576DB112A27;
	Fri, 23 Oct 2026 08:34:47 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010039.outbound.protection.outlook.com
 [52.101.193.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D87112A33
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 08:34:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGTJNDEmBry2PLmNGTHrc/LdPx8GVpcZGoTT3tRDfINzx5CqJICIN1JBJM9nLMgtqsUepAfR6I0QEGYKgoR7W3f2zmdJhXUPe70MVIQeDHKtijnh5dnFDgpT2mt1kcPG8C+pNuQnU8oN1g+u8iw0bxdJzKHLLXx9CvG0JpwWSiY83AJDWLSFQqma72uAHkv7QQpFgmcp8P052sGk/RMTsAGPGS/wubQKev7xiWEzVvyG9GplKB/0Yls/aMk98o1r+h3yZDrgX8JxkoprC0wklx5fXYpBVhiwGKn1MmQ4HSpokhBVV/I/MiFZPaBx/xri+c9UtTRSpBdwFci7aOTAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9kaW6oQF1/7Ip8JjEmhuNxZmTtFOMnJzol9Ukgxc0M=;
 b=E0OZEr/0TKurQ8E0J7RdywLdrvBMzJdkfWDETWDqK4mpacUcKFdpg0IXV7yzy1KQ8SHsM0djwX5pOwuEn2qvrhl5lU5Bk7tTWvpSR5rz/1q0DKAAdHv7lKZ22fXQ22qPlZ7Y+tQ40X6fREW6CHmqKIIuroo5Hcy/GqFmN3abTb+eot41k8MxGJjrQvzRkolneE56tixDpEEhSv6aqlVeYrszVaei1nErcTVwD1rDhHGk+8l6rUdIM1yXFid+tifjfEQAG12/M+Y+UmHH1H0MwjLCqv08ihEDaFfFVAftB0Dn75JseM2jczpUk3VqKTbDIVPOkuZDdyXKmPP9PrCIIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9kaW6oQF1/7Ip8JjEmhuNxZmTtFOMnJzol9Ukgxc0M=;
 b=uLcBAZTBoOedvbA/UjWN0GtcMtQQTygdr+A7ZYvVtfXMfYwSB8CGVVjD2HJcOusTfYY/bY3E0qGLinEeXwl5sBT2ImFg4CL+ZIr1GgPPNTNX5JBT/gsdI4OWBNCQkFF7NjbeFI6E7KvaHlAxomTkZSUPRS3UXpor/EVCDLs/whI=
Received: from BY3PR05CA0011.namprd05.prod.outlook.com (2603:10b6:a03:254::16)
 by IA4PR12MB929686.namprd12.prod.outlook.com (2603:10b6:207:110::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 08:34:36 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::26) by BY3PR05CA0011.outlook.office365.com
 (2603:10b6:a03:254::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.3 via Frontend Transport; Fri, 23
 Oct 2026 08:34:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 08:34:36 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 03:34:34 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 2/8] drm/amdgpu: finish GPU recovery callbacks before
 restarting schedulers
Date: Fri, 23 Oct 2026 16:34:16 +0800
Message-ID: <20261023083422.3049246-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023083422.3049246-1-Prike.Liang@amd.com>
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|IA4PR12MB929686:EE_
X-MS-Office365-Filtering-Correlation-Id: cc42f1a8-d804-4c3c-6bb2-08df30e078af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|261022105027099003|56012099006|261022075727099003|261009223027099003|11063799006|261021123027099003|261021121427099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: C3Ztrnlhl1VPF8TKcW0/XdWPPyQ4SssfP6QaoESUil85ecvkuq7f1aGmQHNyP1lcrkvItwteUIBP/CT/J1FquIqnifPGLNNBiulzIzq1jJINAZDGdi8alry8xMigmpPy7lZaFR5wZ/71uNsHlQ+grNYQF2t/T0bxu/bWM8XBl23SFNc9nWrkbHx36xEx2iBVI+XvQ9+WYji+wpOT7fmHgo1mOb3M6g4jHhh7YFMabZrvr/AHF1Kg1R94Hd7y6NjHwRpYXacuwFLQcPzIanM5sn20CG+XlLqOrhVDsj6Gn+mtmoWemsJmiqN5DkAPta40dn53EAlmbqXN6wcxfpLx4T7BMLCqzi/HHfwhqvhY43uHLQgOVNnnaf7eLgJGIitZH4/dOVDc2FfsyLJRvG4L124wClIW0sCPTIvsgoF+sprW3tvPuYlbJgR9q3OQWjjpAOWE9J3DV99KOX4OW0+r66EoOjPg6yO6kagvScowIC85tHjhliBsHmvDonOWJ7EI8xD0B9zKncdwQNE/9Dh1HyFcj9Zkh7I2vAvks+1MDpdOsCk7qK1ztXXbjv95S/ITVWt4ckYkstaOuHPFP94IxFW8tYy5RRwNwDEKt52JNhco1FsAJ7oqFsQME1Wfz+6IIQYYNhH2dGc/Dm5MJlSo+YnXWCP5vHED49+qtq7wzV0k0YrLOaxJT6kCc5QwGAZseirQjBlMXJcnxx+/1b2XpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(261022105027099003)(56012099006)(261022075727099003)(261009223027099003)(11063799006)(261021123027099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jneg8EZz7Ulyx6XVZE/9YCN4quFqYMX2Zok5RbNjqQvUzKSGEkyfJu9qolDiW2SWO5glZLpZJDY1lwyZdp47LNN94KFPgGfHTVwULPFr9GF7R66nIY4h7hCh21r2CXjN5rGNjwLHly4eDbyb3SH9qgp5SBmuNB9e49M1CrGbUsTcZk36b7wlH8BmoFOHOZA7nRHkIsbF5ryWHqAc/mfdrsj+uvRvf1la6MF9qER8fsm65jDuw/+2H5JiRuPjPifOzx4WrMf0L7F71B628kpGqsel3pMlymf7AJyKtB3tCexFDkUu+YsZ39QXcr3NwQqWWYnG1zGl23h+rJ2XkTUc4cNo2jJ9J2Qiph5ona4CEym2rYdOjQmLVhAIXNG+iUJ87f+SjTDvYqeQlUvraP0Q2U8i7GwMQR991ACh6Rsy76wi1LEAf5X92VW9zTxsccjR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 08:34:36.4240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc42f1a8-d804-4c3c-6bb2-08df30e078af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB929686
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 406c5f2fbee1..20f02dd14c41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5816,8 +5816,10 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
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
@@ -5827,18 +5829,17 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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

