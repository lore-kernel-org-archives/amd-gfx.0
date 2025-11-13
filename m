Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E07CD8CBD
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 18:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4CA810E147;
	Thu, 13 Nov 2025 18:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cKiOhZZJ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012046.outbound.protection.outlook.com
 [40.93.195.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A9310E147
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 18:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7pZhldQDBsldXSaSzr+MIuE6rzC/Qn+LbUhcHFr5N6nKIhdB1yDrW0depWKdtqPHpSDo3KpgZC1/XxHFbB6UDzRZJiWowJY/yNrUFRwCI3BlWIpqw8CvWboOeBVAb1daAKogFYrH9AnwjEAnp3F0HWxnLGLdecNrZHTK6T3nvi+v5J4nu4kF7UiADw4mKrqMo7R6moTKGKQkaBBrDW+hZ+xgTyvHlwIDiYEmMw7yM17cWAmecarz3b9fO0lMpfxaUqwOPUGVXbvOaaLP1zlC5VikuZevqE5nLszH1VVyhGkbx0jEMmRH8RQZ4/c7rJlX64F3TgoQjTakbOzZETCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyBjp5NU0sPDzJg9Y+Ww1SONBrU8GRDoOMIqgL6jSXo=;
 b=Qbcvc7ekYbINwv9f0pKWUB1ywEtBMmIiMXdkmc5o2fcIHSEkK/WXOFkRnKZNCR61abBq0YVRXVtSAah1nsOzDZPP7S6DG1cC+K6TdHmTcBW/cLqCg1uVIY1ZBtRSP6WqsiFYNPnhoDF8tB8ueRSuvQ2/0tfE6T4Vmql7YxLnHq8Cyw2AelyMOyt1f3jEejMEuOnoasbIPDXqwHjC4aLJq6iHsLz+vKw+try5oRulqHbqLleoggzq9BT+fi8IR/ub/Ileq6tNGmxagcpDNK6DkIMNuJwYyV7yV8XwxGXJgOyn7cwbNeTkZ4ftUzS3FuJbvDv2AwihmxJDknoDAaYT5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyBjp5NU0sPDzJg9Y+Ww1SONBrU8GRDoOMIqgL6jSXo=;
 b=cKiOhZZJxM58gS57hPaROV6V4eYIqjBT1HQSa2Waoq7I7QxuilWfik3vrqrPzVbrazpWyUOzjCeGTy2WPkFccz5osckhGiVQk185KUDK8xBtzwkJ5/FV7u6Jlo5bUKETcL927dkvtbaBJsRzh5W7hoblYW3MfYj7GfM/QJd/fzM=
Received: from DS7P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::35) by
 CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 18:32:11 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::a9) by DS7P222CA0027.outlook.office365.com
 (2603:10b6:8:2e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Thu,
 13 Nov 2025 18:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 18:32:07 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 13 Nov 2025 10:32:07 -0800
From: Andrew Martin <andrew.martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Andrew Martin <andrew.martin@amd.com>
Subject: [PATCH v3] drm/amdkfd: Ignored various return code
Date: Thu, 13 Nov 2025 13:31:55 -0500
Message-ID: <20251113183155.1120872-1-andrew.martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|CH3PR12MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: b2550a89-bd0e-4b00-b68e-08de22e2f3a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NIRYRzeDiynXnWEshs4UH80W551xrQ196LoAXqUemJQB8ZtxuYpifM3Hq65+?=
 =?us-ascii?Q?LiqxtrccO8JqKsV7eQ/M46fM/P6hpjD4RG/wnr/Ax3k1E6NkBLDTs2iVZyLI?=
 =?us-ascii?Q?/yI9e/ZEy1UwLwq3fJfmZePfOIvw7mjaS8HNHMQRN0LwYdztHnU4YFOO3f/G?=
 =?us-ascii?Q?MtXJYtdTW8Ea/+UDN0hbUjwxVvpZpipvheNpInR6jRoRRsEEfU7qtX/kA/9U?=
 =?us-ascii?Q?jp4qiJvxgpXgwFspjOihiqyQSS3cw1GRlHX/8DqdFsjGw16SS8cZldfZKh6I?=
 =?us-ascii?Q?snu2QgsGMTq4Z18XF1va9iLvaeydsq9X4CZ4i20DRMXlrIeuWqzgvzt+cPn0?=
 =?us-ascii?Q?7dvtfzSQCX1xcKyPnYtbxSKEpM+Br6bJTCbhS9DNgm93L8k4knHsFEXd7DYc?=
 =?us-ascii?Q?boAoUAShepPeJlEySwey+/sdYscVvXyoGsAh1MnpMo4tTta+Z7r6TlvTGZXA?=
 =?us-ascii?Q?9fvtFXhAm1eLkYMiAS953ajV2UdvSpc5zPcBdswtOS91waTr1UT9qJLg1+Vn?=
 =?us-ascii?Q?uUqvyh3M/fyccGPpwJIiC6WeOSA5qQWjnoR9zf8HYQyl99Y7o/UkcoKPS9ES?=
 =?us-ascii?Q?/xg7ZAe8shA4l2D4CC05/rFFP/G3W/c8lCFAmm+lX/4pIDSpSAt9QVlvxCrz?=
 =?us-ascii?Q?bBC9kRh+QOYU/URVKsSCXfZrsF+ykoSXf21cHASooFswnM54bI1TG+LpMfu8?=
 =?us-ascii?Q?ijA9ytjq2AzJYuOjwgCFospKinv7LyoUykHwrDgHnh+ay+ZO166/+04TgyPH?=
 =?us-ascii?Q?dxC7+MIoQbFAtwD3JSUlZr/5RUz6wl1NIWSumXxk71pndPvtYHtk46d7Zq72?=
 =?us-ascii?Q?CBxafTFAEw0bIA/R6A15INTjWryHsbucdnZGBYB8Ra81GqqhnwKkhztkRIXx?=
 =?us-ascii?Q?ock7P5vzrm9O47lHhOw+g33H9VI051wU34G053WDXty/PcqxnKWy9o/MaabM?=
 =?us-ascii?Q?un4EjInXLJhG0kUfDAiQArEgsUibQGWytm1mmDyvwGMQy3LYSazzPiG8AOs+?=
 =?us-ascii?Q?ok4m3VlnvM4b+Rlkkkxdqe2nhmN4UaChm8Wtg+56p0S41kUYw/+tyi/Meba7?=
 =?us-ascii?Q?93eYQP+7bXZCuAJw4TgNsKMk9Op57T5m1/ZcVPbZ+8sCeBmJAe5DXxpeXiUG?=
 =?us-ascii?Q?+GjVcj9Ov/HF7y7nAsFBnmw0W1xVcqurX4daLB2Rys5kZ9DWV8zg9AzE+RdH?=
 =?us-ascii?Q?iLse1H8mGCFu34st31CZvL46JgbJ1j/QBDAcUC8NY5al+KAsgcNtUjCYuGAA?=
 =?us-ascii?Q?BtDCERZhOlV9NgjbJS2t65eX8RqH0I5h3iOpUD9nS1XlrY/JcPH9VQNrvn5v?=
 =?us-ascii?Q?PP66J+1GSv7XYcZRE62e99mDBJsI27cjYHdq3Snt2/6T5jq5GwoSdJZrM36t?=
 =?us-ascii?Q?86aUJ0vFlqnofTU2Q+oLGQBER9CUrizAvn/Ahn4hkt+3aBk4PtkQkJIygQ0+?=
 =?us-ascii?Q?VZOWK12Mi7UtgbtLX4jWFfuu0ELVLSzaaFUCGAH9MEQDZIQluivzM3ebD18k?=
 =?us-ascii?Q?VFWzMD8xsXRxRQSJfXVcO1m1GcCaO9P7qFS53C8xXT8Er5TPQNQ7p8jyIoEu?=
 =?us-ascii?Q?6Qo09rgEmLCOSxWCTWU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 18:32:07.8340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2550a89-bd0e-4b00-b68e-08de22e2f3a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546
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

The return code of a non void function should not be ignored. In cases
where we do not care, the code needs to suppress it.

Signed-off-by: Andrew Martin <andrew.martin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 13 ++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   |  3 ++-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 644f79f3c9af..e4438fca6283 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -313,8 +313,10 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev)
 void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
 {
 	if (amdgpu_device_should_recover_gpu(adev))
-		amdgpu_reset_domain_schedule(adev->reset_domain,
-					     &adev->kfd.reset_work);
+		WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
+							&adev->kfd.reset_work),
+							"Failed to queue work! at %s",
+							 __func__);
 }
 
 int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
@@ -715,9 +717,10 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 		if (gfx_block != NULL)
 			gfx_block->version->funcs->set_powergating_state((void *)gfx_block, state);
 	}
-	amdgpu_dpm_switch_power_profile(adev,
-					PP_SMC_POWER_PROFILE_COMPUTE,
-					!idle);
+	WARN_ONCE(!amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_COMPUTE, !idle),
+		  "(%s) failed to disable video power profile mode",
+		  __func__);
+
 }
 
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 22925df6a791..025609a4abcf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2780,7 +2780,8 @@ static int runtime_enable(struct kfd_process *p, uint64_t r_debug,
 		 * saved in MES.
 		 */
 		if (pdd->dev->kfd->shared_resources.enable_mes)
-			kfd_dbg_set_mes_debug_mode(pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
+			(void)kfd_dbg_set_mes_debug_mode(pdd,
+							 !kfd_dbg_has_cwsr_workaround(pdd->dev));
 	}
 
 	p->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;
-- 
2.43.0

