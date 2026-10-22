Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E93606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vjaMa2pV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0E7B1123F8;
	Thu, 22 Oct 2026 08:34:08 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010020.outbound.protection.outlook.com
 [40.93.198.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28E91112409
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:34:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLzZQSYt3uMWhNv1W6sd2GnRFR8DAVb6eqxFRCxQfqFnud9OYxczQk0U1ee+rhhUSVJTnWIXj/6MvZdpfIy2kzW9DpPR0uvE4FYy6CO7U0hOQ8/prKvgC4OtncRpRgUrVg9mWueV3gWgeTEDPc1K3VhB2redAb7PeDapgdq59/AisDaz7RT5MpHQH1vt+tEO+e/k4F4VNnpgxlv3ny5JZiCquytZ1G05ny6msGc6w4G5Q+Dh35wQlde695Lw3DGAg/emHVH0Jiz6LUswNP4afu8LRsUZeRh6BnKB/UQVSbtzX2lyHik43t3hoKakFjsDN+u53N1QejS+dp8VFTAY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1PD2Y5dLPbcsWkD4eMNElYygJ6H/CUDBgBkuDXamUg=;
 b=prAIrv8i4/zS1fXPf5LtvyrWyHfN5Vwz1QCyZBIhBRP4Z9rGlxvhjPx2/KVkjPKj1FXNHNakl15tFtZ+U/KX3WmSoSAxN1c3r7BJERdtMqHOi2XY8F3uFb0hiSDCWXIjCRd9XKFZwztbi/n7nhfCvSnMzxOnm60+sWoqXEPhNDvzHNqqGYi5szBpaFGruZdvYavVdkl58CJ6wOLffIbtL0R7UOKKUfkZy1Y+lwtYySy9bYg4+bqRMF0a9hpWoy+hn5teFf0VMOEEw5a3nHUeslLRVLc1rtb/ngrinFsVMONmwMw+JCi8xWoVVDoBpUwmO600HoF62qu+d/o6AP6ucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1PD2Y5dLPbcsWkD4eMNElYygJ6H/CUDBgBkuDXamUg=;
 b=vjaMa2pVb/gieH4mO7Rtea14d2hF8vgVLh4wxLrbQw//2Rdcn9P39CEkt2accY0JLvJX7KxJ/BQsLMVKJRDQzFYMxRZjUzC0EN4UzIc31YjbCm6+9kWCnt6ObN+2+AzqIZs627uQLcIC3QgLvv50SOh3jY9HZTFrcKZYKdlIAFU=
Received: from CH5PR04CA0008.namprd04.prod.outlook.com (2603:10b6:610:1f4::25)
 by DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:33:55 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::98) by CH5PR04CA0008.outlook.office365.com
 (2603:10b6:610:1f4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.18 via Frontend Transport; Thu,
 22 Oct 2026 08:33:55 +0000
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
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:33:55 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:33:53 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 8/9] drm/amdgpu: stop the schedulers before preparing the GPU
 reset
Date: Thu, 22 Oct 2026 16:33:30 +0800
Message-ID: <20261022083331.3019779-8-Prike.Liang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|DS0PR12MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: f55cd608-8d01-411f-cbca-08df30173604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|18002099003|22082099003|11063799006|261009223027099003|261021121427099003|261021123027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: vZPO9yXBabIhdFTNLXIzGawAirLUQ/5Byq6YWJXtrqHw8DBsBbv+OHg9WdoDi6c9WRWlgsHIHCXtT3Y3Xy1Z5d3fsCPQbGG4O38MD3dK3BInxKHdbFI9d1SFL7lWzv/cUfkOwZNMHZbKOXt9MlTqZLD79jzWTIv7848CmfuKKdTh77jo2PUUFZLe1Ph0wXpxOOAaGkTDZPR6N/u2708Z0MFVFcjs/qu8ZDNn2wZlFhMP1YrHvrbsE1rjGRpBB3tiuFFoHijup+QbUjQxAdXD78ygxrHWRX51fYPGTEsRkJZy0gYJAkq3Cq4ireIpVs2//NvX8NqmmJEMAechXsAosGCkjqFp3gX4O1sjhnttiUlPifox4Pp1CyVeK65jkHHioEMwdpmbcXYHANRvMsYnJ7fcbEXlYG1bauhH1su8Dz1+3gISNR/69PbmOmSMoP24Z1jjOqdKrkjKnIC4o1mPOVacbNgCke08truA0HM83x61uLY9KC9I3VCZYOpTy+i6dLOffqCm4YJ+eKenrBjG0WsIhqt+EOAsjUDmqyrQNEaMr1l8eEWeKkWWkgtcomW4VVYQb6ZgkorpoFbvLdyghhVHrb8fQKqkZdbsy2rolod89B+g8tNVny3+z1ZzLbrprX8mNpdD1Vy597nJCoQO4xHqS7aLgdvjnmLkECeq6NyWO3DL7Ec6PJy5hx22zfrw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L+N047z7ZsA0Au+jK2WY2BniFsrCrud3JrE6fB/7X+jjEnQz2zr90m7f72plz0qunVDKMpefaJnVwXeuWrDCfnYPoE/Z0KsA0C5UVUeuLtNeddHR3okQD4tYZz9wgT26pOuFpC3FB8fihyRFy85Eb5FRjcrhyyUbX9wBAWl6Mz1jh3BStU2+jRKx0kQ0joFs/96bjAM+WwsQRPqAPUb+5zzLCOARCAZuemGAoDBxYXzu6DlGPGe7Az4nxeUZNSjkBrclKmVf9BJ0nVN4OOzwGN3XIwJ6TbUIEK0HazlHZyfkSN9RJilXTRe0FCBJAEVzdSEY0nUQabKfz70tP/1m41oMdnQv7e0kI6HwVuBqcOVZGIzJsmG3Yn9bUa5VFw32xj7LSTGrhh6xOfqyg0/Go7CjSlqGgtiLFmqdsTmyd4pl/hBtkfEuIOXULQzBLYjh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:33:55.8227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f55cd608-8d01-411f-cbca-08df30173604
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8442
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

