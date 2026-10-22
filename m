Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435BE606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QwwX/aSb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA462112407;
	Thu, 22 Oct 2026 08:34:03 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012001.outbound.protection.outlook.com
 [40.107.200.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1914112403
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:33:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmAGEIJWj/GOJj115Nszo3GD4y6rqAMq9QVaIvn73LCBFAtmYkbxEt4avKc6iSeOnKuAO6cY35sQbRW6HennKjviZU23csouyUgHO4AXMNaZZlYq9C4ygOSe61Ne6NOQddpxdTT+6TYV09Ye838sXoz7ZLflAjW6pS+kAU3Xd9zg364oNV3NpnrpiDHeMR/iryY6R881alr2f4y+4rnmShulCkYvFJSEwUYQ1zMnZVavuhs9Ce+QXM8mys6V3/ojYUOWiaFWJwSgUGfp7z0bE2pwcRE6nGq5edzmgKSNHV5nmfjOfFHNKIAkN3w39Cn+SIMf3uaa41up6bTD82W0Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9kaW6oQF1/7Ip8JjEmhuNxZmTtFOMnJzol9Ukgxc0M=;
 b=LY2MMFGk6v7CiVFibReOVCKK2hFyizO1jbZlsK+DszvXWcEcAUB8mIGYioFXpbi63bpEc2VoX26MihVVlI3qVWZWsV2k9wEGk4TC1JNZJGL97jGwI0q57/H4gnPDEjAKuNh5hvXQLVXq4YxtYH7IAazNHWZMt4sQ//3ZV1vxUL/ts3AQm5h+TlpX+xeDcgtd5t35wAX6VA6ZkWnNO2Gv6DvdF+1InaBe9VLoQbRxWdKQznLyhOtNnuYXaOziYcZjAWATrtJm7qRTN5PIiq6eCifIEhzDHwtcJUGPJmn8YOhqC82KuXtZENe2Pv6QJEEWkODwjWacZfixMk0A9FSmpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9kaW6oQF1/7Ip8JjEmhuNxZmTtFOMnJzol9Ukgxc0M=;
 b=QwwX/aSbHW3Jb3kZNRHB6/cZWaIFakg4TQIqEmZLmpZpRKcLGSNU7U3RyLdzM2RjPDmTvCKP+9JtisGsfx8L4chJdaoNyrnKebp4CgtIPt671P1B2PBczRxvnQPedmJey8jMYmpxLICzHvXuuHg8qnWK8VU+BkGKFVM9lK0gdro=
Received: from CH5PR04CA0010.namprd04.prod.outlook.com (2603:10b6:610:1f4::18)
 by DSVPR12MB999148.namprd12.prod.outlook.com (2603:10b6:8:38a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Thu, 22 Oct
 2026 08:33:44 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::2) by CH5PR04CA0010.outlook.office365.com
 (2603:10b6:610:1f4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.18 via Frontend Transport; Thu,
 22 Oct 2026 08:33:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:33:43 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:33:41 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 2/9] drm/amdgpu: finish GPU recovery callbacks before
 restarting schedulers
Date: Thu, 22 Oct 2026 16:33:24 +0800
Message-ID: <20261022083331.3019779-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022083331.3019779-1-Prike.Liang@amd.com>
References: <20261022083331.3019779-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|DSVPR12MB999148:EE_
X-MS-Office365-Filtering-Correlation-Id: f01cd349-25c3-43f7-01b4-08df30172ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|261021121427099003|11063799006|261021123027099003|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: mEY9iqyf1GoJpLAhL5bIsDhlHmReoZIoyIPCTPw+U5epVaHldScBkxbu7SCFkIwEZty6HRQ9vSxHz+9SOhwWDR8xeYELKdjrPCKi6G9BLsW5QvuODlN1dJCcBGQqOle4bF6/vzeaMqqHGkXmK1Qzpxzut+WMDJqMpDdPP49bLS9NcB97Jg4x2SOuHLeBXXx1/Mpu34D9Q1Wz9zm5a1L3xxfIYfsw8op+EFolnMgoTh3DLhpWXIk/TP3Ooojq/SXJZR8UO47/49Gp1cpr529c4/oKgI2rlvZmCWafVUHwmYJklM8yH9aZtuQCrbtAT5f7lwKr5fwywpgYb6ugOCqrDrzR0PMDMqtb6Bh5gVyOSuoYGfMAEybJ5CuwV/nF7EjCzlVcNFXKOINLTITuVcaoTf8r3NFda53iTNB4XJeVMe2KCqqGL/YfYGcDFBqLm+wAhLw3nFpLmT0/vQPGt/FIjNo+J9OD0Z/znyj5DF4UCM/aUJGDeNAj0cncSSO1qEGnsd7Z3gIGOX7aO9cTuzeRfG2J8kNJoYsIwUI29PLPzJFwwYho6hENXhkhmFx9gYXS7lhsz+8iraQFW16U+MCk04+bBpC5RhNof5pIh6XzuaHN8MNNplg2QF+euUytHRsFLBwN65BhrZDjf0Hti8v2KOGoKod3ObFzKX/C6A85Sy1Nry9mfSknQDvkOEtfGD8FE04eqQem8M57Oq67A/9KPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(261021121427099003)(11063799006)(261021123027099003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6HheOdhB+RrLT0jtYdyG/gkkkPBgj/GwcDgtCs1fYb5RCIgj7f46sXHFUwjSNrAisdLXJnnilqTZJDweOKO+mIFte1Ph3+Z3KHJtVGll3kO1yj7Sf3KQlTikAuCfyvd9NCzdPRTfZDkubTvsyTcJfBqVJ1Lwya0TpUARnkm/hFhv1GF/kifSWseRJoeuGktGLFQ5EM6+ER/eCX4m7ECorlpI4RP9C/RnHb8Je8A/8UkV20bpXbUNOk3WVGqHgWbctHxnUGn5CDf1XE5PCUFuEKCLHvJ3JnBhd3Sm5p5GzAuVjw4vqXCbRXseJPHcWozllhOGnpHPK7MRKQqjregoAdmxVdEnToxj+P6rcEAkanrkpE1kDS1mE+Tp98xTU3WEkeZAZE8caUYY1K68oWWljxgd/Cam0QKLNnH87slVLRnn38usXFGm069zjJlE2LWJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:33:43.6137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f01cd349-25c3-43f7-01b4-08df30172ec1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999148
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

