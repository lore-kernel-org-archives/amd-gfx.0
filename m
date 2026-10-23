Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E98606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zHzJjElQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62768112A2E;
	Fri, 23 Oct 2026 08:34:58 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77AD4112A33
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 08:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwbHVUu5aMoYlJ3u/YQ4nz+wFf64EbpWQ22LZQjDMYHRffTdDne0I1D+jqgMNy1qTLjr9tS7UwGbxZ4JxEX1Ehs7HwsAxVwDLB7nu+zkp9KSp26D+WMHwz4ypiO0jsdeg6Z/LZ1eBTwEiS7GnRIkbjRP2nT/IDSWvRQrpFpTsP/VIasMHLTQNE27fmPiOY7Rth6w4NNSeQ1jTmNABGHSuAM9OMK+yFvW9OJTT0ecP6F7qTes8doXIZklN/thJQXKNndXKDrbT27Mf/q9sHuJCjMxaQa6sPBGrChd8M1bs96RH/O2XSxHJDuFOXoC9++JcqiHfKBKyKfeYGJuixtlKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1PD2Y5dLPbcsWkD4eMNElYygJ6H/CUDBgBkuDXamUg=;
 b=WukcrpKibDoccQUcPw6XjFYtZTgMHLiR0wcEKpzSXZlJi+0WuNXs7WDCwQURgtLqnItzNYlw9W63XGPFdLJfzS9Nuf03Cq3kxTVMoGe2zfcKa+GFG5H+KfDsMPovg9rrKQUuATaowTd3/8n8yuykCqi/wgdXqJBlj9NWWFfrZgee+KsP89vEqyqwgLMfaKl0SuDMiZ8jHOSEkj/ZXQ3TLMkAjwcWJZ5x9OvUXdrWD4f+45mt3HZ18VSXPgJZ02xto+Z7BReJ4LwV23GzSp3SuaH9iLWmipfux9OxLbSv5yVwF5hD+TLkrK2daF8kqfAroCgUANeataKiiFm6nrE+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1PD2Y5dLPbcsWkD4eMNElYygJ6H/CUDBgBkuDXamUg=;
 b=zHzJjElQZCasyJvY+n5cg0DcKIeyy6vtdOGhLdl+OOOeXZs2pilxeJnjuFBoz1WMvBGKrhbpMNtgf2/9inSRSR7EkHxlk2VABEvsEl6mr3Pt8n12qoTt6L7dHf1XB7Gk+GjAruGY4vdgGeUL28fQRSHg8lQpLsKxOwOV+VKeZ6U=
Received: from BY3PR05CA0004.namprd05.prod.outlook.com (2603:10b6:a03:254::9)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 08:34:47 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::5c) by BY3PR05CA0004.outlook.office365.com
 (2603:10b6:a03:254::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Fri,
 23 Oct 2026 08:34:47 +0000
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
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 08:34:47 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 03:34:44 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 7/8] drm/amdgpu: stop the schedulers before preparing the GPU
 reset
Date: Fri, 23 Oct 2026 16:34:21 +0800
Message-ID: <20261023083422.3049246-7-Prike.Liang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|PH7PR12MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: 40d876c1-5f45-43ab-a65b-08df30e07f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|11063799006|56012099006|22082099003|18002099003|261022075727099003|10067099003|261021121427099003|261021123027099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 0Z3v5BK5B3Kzm3CiVtKZxnNOVAS2X1RcoWQl2J9WlCH9jnByd8rBh1b6GM+OIC58c1VjbH25Szh0dPM7n29fLn2142M1yK01RyitMoBIU9XD8a+o0IyenBJtJ6N+WyP+dV+dv8rcepgSDv7dN82m0kPYJeh6XcaBDw90QqujiDuVbuwZxwKvC2kjCH8CDNVSQVta2ypW+z2e1dShI5L3ODSG7nqiLGYN5dSS/aGdOnuKjZy6CctaW6OS3Qeq5Kb/NsX+b75BOOxl7HJon5x/z1JmzHXNgMY1lcCE48/CqwXkA/CcPzrAMhzPvF8z3ndmYNLH/mC1OHkEn7EWj6OVf4aOWqZGyHpVyupRfS4kCi5+4S+yCUrV8KnLUGAiaahCe5VJi+AKEmqDAVxlLUwn9O6jxmXWDllKsLTt7VD73HO0z6MOym4HWYU5bagvkx7q6u7p2pYnr1cUk7sUhDFkHCChqMKdCM5YEfN8S9dL/42hx1KiwZfRGRhzbwo+GnhNOo9boXyPwVrVKUdtWc66MhmdboD6jIT/FKXIBevlZKPnXIeeCqzaollgRn7a702Qe5Ok/prU+r+/pDvP+VFzfoTbPwszi5efwTEe84ILFBfU/p5/Z1vkRJljWBlJ5phpSEMDJGHUiA4GqeiQPfEVWpRUhFlF+hfqSA4bXcsHF3eW0RKV6k8zLktSVZY0LPvk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003)(261022075727099003)(10067099003)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7XlRwbHsc2Vh1K7S+LpdAavvRlBBlk7DjrjuTcFtBAIFtJbdJ6Z7MlMhB+o/sGSJ8t43QWFa2mswAtTeeLnR+D8pnXflLIFmlyquRCPKvGoyCW+EdiT8a3sbvsybjUFLhMQnOhfxHE33Oj3JienLRDCk/6R23EFwegCQ6iv5YYxTO8oOkoWHU/ATP6xh/uZPpMdvnuPFNjq55vT5D9Qbqw9oa78Got0Lma9AjMYMC9loGTJZ5/IDxPRPfpyWxsOOV8WGi/rUJ0FQEGi7WbLfABVsZzgN/VRZx3w2ghsB1lZTPz8m3ID+ADofyisu159qMNcB4bT13VTZMX85l8wEfMe9kvtN41xlnM7f4gzoVzqN0hXeX/MR7PeIYL2H44+kcicSutxOFrwRPBt7nCAhUzKm7b02Y/9c8kSzTyj7CyzaKNgI2IO3QQ3zzPZTgDRM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 08:34:47.0291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d876c1-5f45-43ab-a65b-08df30e07f01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126
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

amdgpu_device_halt_activities() only stops the ring schedulers after
amdgpu_amdkfd_pre_reset() and amdgpu_userq_pre_reset(). With a hung MES
every REMOVE_QUEUE in amdgpu_userq_pre_reset() waits for its timeout, so
the schedulers keep pushing jobs to the hardware for seconds after the
reset has started:

  GPU reset begin!. Source:  6
  MES failed to respond to msg=REMOVE_QUEUE fence_wait_ret=528494 status=0x0
  WARNING: amdgpu_device.c:928 at amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
  Workqueue: sdma0 drm_sched_run_job_work [gpu_sched]
  Call Trace:
   amdgpu_mm_wdoorbell64+0x20/0x70 [amdgpu]
   sdma_v6_0_ring_set_wptr+0xa6/0x180 [amdgpu]
   amdgpu_ring_commit+0x5b/0xa0 [amdgpu]
   amdgpu_ib_schedule+0x64a/0x8f0 [amdgpu]
   amdgpu_job_run+0xa2/0x220 [amdgpu]
   drm_sched_run_job_work+0x10c/0x300 [gpu_sched]

Stop the schedulers of all devices in the reset list first. None of the
preparation steps needs them, and jobs submitted meanwhile simply wait
until amdgpu_device_sched_resume().

Fixes: 290f46cf5726 ("drm/amdgpu: Implement user queue reset functionality")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 28 ++++++++++++----------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 20f02dd14c41..08395cca18db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5534,7 +5534,21 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 	struct amdgpu_device *tmp_adev = NULL;
 	int i;
 
-	/* block all schedulers and reset given job's ring */
+	/* Stop job submission first, the preparation below can take seconds */
+	list_for_each_entry(tmp_adev, device_list, reset_list) {
+		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
+			struct amdgpu_ring *ring = tmp_adev->rings[i];
+
+			if (!amdgpu_ring_sched_ready(ring))
+				continue;
+
+			drm_sched_wqueue_stop(&ring->sched);
+
+			if (need_emergency_restart)
+				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
+		}
+	}
+
 	list_for_each_entry(tmp_adev, device_list, reset_list) {
 		amdgpu_device_set_mp1_state(tmp_adev);
 
@@ -5570,18 +5584,6 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 			amdgpu_ras_suspend(tmp_adev);
 
 		amdgpu_userq_pre_reset(tmp_adev);
-
-		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
-			struct amdgpu_ring *ring = tmp_adev->rings[i];
-
-			if (!amdgpu_ring_sched_ready(ring))
-				continue;
-
-			drm_sched_wqueue_stop(&ring->sched);
-
-			if (need_emergency_restart)
-				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
-		}
 		atomic_inc(&tmp_adev->gpu_reset_counter);
 	}
 }
-- 
2.34.1

