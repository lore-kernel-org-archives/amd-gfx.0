Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0254DCEACFB
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 23:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C92610EB2F;
	Fri, 14 Nov 2025 23:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gZ8v6pRI";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E2C410EB2F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 23:26:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdRB/8hW8Hu7A7n2CW90tF9yxpNeneJpt4wixudODOw3j7iuCmpoL7ht8CYmuFu+rrWfrA1SHHvFfzjZfN6Ty8Des3exPizVW6J6M/EIpI5ZZY7lPW+kqCBzslq7QVxGmuCOL3K9ssEOeaSF9wn5hZeC05grzCpZIE03HniS9HUc4juJGpr16CseNnP62nD2vAXcgi335xwB3zYDG3eFn+qV89y8iDR9QmVUHW/JKxieFLyp+24zVaoIIchymC70sKjBDfi9A8DkxJLdIG931QQ8LSSy+/eCfdW6ZhxJ0eKSyj3YwaD/0xfFjFYoMU7ih7C0JVDGh5oLmWKAILSUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I00V7WNqQSchSYwcogUp/nwTSm/YGRRPjvrRan4tPpQ=;
 b=n/jcpA6PPb5KCvUSp8/oPxooH0JIy++DYEU6VQmDqhPXZxP/oZaR8AXThl+d7habzc+k0lLF94vjmuOgUV3UHBReQXwNmh0/oWIc1WvvzsPQdaUQwTYxmaxpHqohzLYWssWKgYtzS/kb+tATgpPRYsFWhHBHADdhUATZ0TiVwsCgkXPp3PA52q32U25M2X0VLFyYUBWCnMnMIP2qRuH43G0BNx3QA3CmrrV4Quud4sGUV8HTctYVCXfrhM4TYVvLfmMYy+ccXJzmvi20dS7uErvz5+4aEiebJjOFOX1//N7pexw9KdTkh1PtQapwlXwDyE1cwsqx2cbPSO0Aj4ycvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I00V7WNqQSchSYwcogUp/nwTSm/YGRRPjvrRan4tPpQ=;
 b=gZ8v6pRIkWcnfRR6rZZOm3/DWQNl52RHUktYfzmJpqQeCcmkRQVYvQaxRpVUB3mnWD1jcSp0q1F5JpHW6Rjo5UhThfb1ILYFarKxyMl7bx8Xh+S77rFE9Apd4LSAmeFqDZrnazR7/jjCCHyOAJz0L1kEiYB/BEYxpmnHVokxcH4=
Received: from BYAPR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:c0::39)
 by CY3PR12MB9702.namprd12.prod.outlook.com (2603:10b6:930:103::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 23:25:59 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:c0:cafe::7e) by BYAPR05CA0026.outlook.office365.com
 (2603:10b6:a03:c0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.8 via Frontend Transport; Fri,
 14 Nov 2025 23:25:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 23:25:58 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 14 Nov 2025 15:25:57 -0800
From: Andrew Martin <andrew.martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Andrew Martin <andrew.martin@amd.com>
Subject: [PATCH v4] drm/amdgpu: Ignored various return code
Date: Fri, 14 Nov 2025 18:25:46 -0500
Message-ID: <20251114232546.1586273-1-andrew.martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|CY3PR12MB9702:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1fd5d8-ff43-4272-d76c-08de23d52adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0dJCSmYD7jE2JsZS/fU/nwrmYH1tBfEELHV8KMsDvJpgoJwKzSX6hX4BHKLq?=
 =?us-ascii?Q?tDVFnoXZNpF9o8B0+8Xb405qEOAsmkLn/wTJ2HLtf7xfP2Ea4AC7E2ChyuOb?=
 =?us-ascii?Q?V+mYvKDkW4siRjZXsOA9MwOwvdFPTaQJjD0r1okLEn7XqoShfH962TTSXUzx?=
 =?us-ascii?Q?/TJ3/hnmjC5EyNe5U6bP3/cwjgmuRwxC1Oj9ebri5V+mS5l603/usuqNUbeO?=
 =?us-ascii?Q?E5WE3MotMw2hW/i7Bm+LiIwph3OCEcqihrX2Ip0tJI80SwO4dFw5kvzgkytz?=
 =?us-ascii?Q?xPnhmrs2nNa5AN3J8uWWcJ2OP/87+JcLHaoOvr/J2r1LayZ1suYRlpUE7v3d?=
 =?us-ascii?Q?/k22oeZy+FvcFdqIgPU6hCsDntlxoXLbFv1VezR1lpfnZR9uNQ810wh8Qmlu?=
 =?us-ascii?Q?yyDWQRxpzsg1aC0N9A0hGz0tzegGZu0e4R+E3uGygwUP/3DL+8iT3m7M3fYT?=
 =?us-ascii?Q?ZF+5gk3/DZr/VT0AY544/FgFW3ykHIv1eIkZC+ZOKLLRa6vVP7unY90ABf/z?=
 =?us-ascii?Q?oC3r3XP9dktECypxtUhjivrdEvaadYkKpNq35ZiT3WoohJmwapWug63rBT4O?=
 =?us-ascii?Q?ViEtJdcv2N1kipB4r0yrb/6hO/L8bLsRGqfYtFg4wDPiyh62Yz1Y/LBi1EYG?=
 =?us-ascii?Q?9RCo8aVj5zW1/yzvf5rdHcFGhha5YPuVHe6S03uOp/eaS6vZ3u0CVDnnGOmV?=
 =?us-ascii?Q?ovMV7EwdlEOGg1JPF0bQnCUQvAnmAfD8MkdhUocApZ7s2j95mLZQa5xSU3z8?=
 =?us-ascii?Q?9m1WTqEa2JIlRKbqWVaXmijS8uhQ0JRnChLu964wjJ8W01hoJf2Gy5NX47je?=
 =?us-ascii?Q?+Apy+qsKMKrSAVSLkj7f6E10hKMlOLxuVhuk19VPs0YZ5ZnoMxmddSmcliOs?=
 =?us-ascii?Q?fcptv83Wd2SiSFmpBI+1CnhM6PlOQfmsM6wJ3lAnCCnkeWtrhXSIo2Jx3W+c?=
 =?us-ascii?Q?plCe8tLJTBGF4qdEpkPeyCka45yr/rqOOktkc370bMaiBC2O/6XkGtUp7hN+?=
 =?us-ascii?Q?rZ4ITpoAAj7mwQWQ9tFNDG/5uP7TQcxuDkOpQH6PSfaMBfKO5YdWLCRp8UUC?=
 =?us-ascii?Q?spLXNQYs7PPvAA5qcCCZfYXejLHPkgTYufl7I4xm+A9Ls/kPTMrSSlUgRGCf?=
 =?us-ascii?Q?GT3bTmlRtZeg42Ws1ySSw6Vtql09DzoX1gAhiKMJxNSEoP6fxeOuVgo4xdzI?=
 =?us-ascii?Q?b0MQsAo4hSUtVg1Rgk+8kWM/afcVSKK7+WsoSRZaQ/v3mth6ZExvG4bRHrxJ?=
 =?us-ascii?Q?JELz7RTajcczXBIPDsxf7HRzTEDfJgy7rORCO473p3GJ6FPTpcEMpJiI/47q?=
 =?us-ascii?Q?fAZpdMxZAtzrzT9S7kYqx4MnJFYaSboWUJCzAgRCBC8KWmKeRFREBJRK3ctP?=
 =?us-ascii?Q?+C96q8HlRCJLL2Z0BwfZxEqBPJ7WBMSB9pfNGdwCjLA43yGfxoq/PQaSUOIC?=
 =?us-ascii?Q?WVr9Dwm+gjg4L4xcUiI3rlb/nZEyyiBlTy+6g/3tHWRCsNqlIqarUJJZjECZ?=
 =?us-ascii?Q?xxMF4F9KM1twLWGunMqP3+QgN8qkSEGrA7dJsygFLw4b/++e2Q0dtSmEpd7Q?=
 =?us-ascii?Q?wzF4GKPp4ESKLucwpmM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 23:25:58.6159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1fd5d8-ff43-4272-d76c-08de23d52adf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9702
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 8 +++-----
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 5 ++++-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 644f79f3c9af..e1b208aa72c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -313,8 +313,7 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev)
 void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
 {
 	if (amdgpu_device_should_recover_gpu(adev))
-		amdgpu_reset_domain_schedule(adev->reset_domain,
-					     &adev->kfd.reset_work);
+		(void)amdgpu_reset_domain_schedule(adev->reset_domain, &adev->kfd.reset_work);
 }
 
 int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
@@ -715,9 +714,8 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 		if (gfx_block != NULL)
 			gfx_block->version->funcs->set_powergating_state((void *)gfx_block, state);
 	}
-	amdgpu_dpm_switch_power_profile(adev,
-					PP_SMC_POWER_PROFILE_COMPUTE,
-					!idle);
+	(void)amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_COMPUTE, !idle);
+
 }
 
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 22925df6a791..81a3e0aa40a9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2780,7 +2780,10 @@ static int runtime_enable(struct kfd_process *p, uint64_t r_debug,
 		 * saved in MES.
 		 */
 		if (pdd->dev->kfd->shared_resources.enable_mes)
-			kfd_dbg_set_mes_debug_mode(pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
+			ret = kfd_dbg_set_mes_debug_mode(
+				pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
+		if (ret)
+			return ret;
 	}
 
 	p->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;
-- 
2.43.0

