Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEB5CCF2E0
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 06:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0290D10E7D1;
	Mon, 19 Oct 2026 06:49:21 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010019.outbound.protection.outlook.com
 [52.101.193.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9D3410E7D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 06:49:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unXxvawxyrCaGXeE9p6hJ30a4pOd3qqn9f+Vrltw0sqjhKh1avCYYfVc6hR8od9QqOcM8o8DWlaoi9FdXiLXU4dKT/K+F7UpLVgCisPqYCxCGC9+dVBBSXDSrAn669Fx7Wj9JXqaZdJ9dqKCTNkMCqH1NPSsy9fwY3/UcCdsy0z7kb1N4vpVItI4PdrVNJKTdlNgIsKLr2JuzIsdN4mbJW9w/xmsRo7KWpKoq/c6Ld60RCGCjz4vFm7CHv++GaQHy5iDCD+a+I0zLE50TwsAeSWwK5aBQzeCBxcqRR4ImzksijkhF9PLgvWOzihcXlaTGARj0IYeNGbvl6n11eqy4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPsR/Eksk3rQH1UJSaHYCNM4N6ZD5Siw6K/TC6QNXK4=;
 b=YjyQGVKKRKOA8LN1m+e9gAihepG6W87kPH3aaL7CSsILnQ4GBf9WB56kFVgwqA+QXu7ZaVXBnVXygr1aCZtdMwnIqv7/uPvV8in5YnYGIgiGvJXO0VAfLFK9bcJ+zm3snbItyyuj2DkEH1jil5w/37tsDOGlqoxFixnYUYGbRaXJQjnScIBHnXHcrdqrxOszD3Z1lF0+/NnuRvwz7y22cyfD73aO8eIRFsCs40ILSxqcIetLnUIrMpjJXjtepICTcQK3rUHyNr0k5AeQVj1rlyBF15XJGeCbhp3Ytz5c3NAlC/Fy/s5uMcAa7gUY2j0YPwnAWZ+CBfPbwsNG4M1JNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPsR/Eksk3rQH1UJSaHYCNM4N6ZD5Siw6K/TC6QNXK4=;
 b=blxzco6gzuXxJzqRQR8/iU1qKhlUvMIllz7/l/N0ecJpHoiDItidTDHX2kWbkRXNu79kywl79aXU7JULK2YE8NEkhA4KPjJH7sV/4704HHFMWvJoY0hLvWRA/ETeu/6+J14ECgbWfaurhCBsshRYnPWSp3WTzBXcoO9Q1CNbMBw=
Received: from SJ0PR03CA0332.namprd03.prod.outlook.com (2603:10b6:a03:39c::7)
 by PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Mon, 19 Oct
 2026 06:49:10 +0000
Received: from EA8PEPF00000007.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::1f) by SJ0PR03CA0332.outlook.office365.com
 (2603:10b6:a03:39c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 06:49:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 EA8PEPF00000007.mail.protection.outlook.com (10.167.249.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 06:49:10 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 01:49:00 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 09/10] drm/amdgpu: stop the schedulers before preparing the
 GPU reset
Date: Mon, 19 Oct 2026 14:48:37 +0800
Message-ID: <20261019064838.2577746-9-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019064838.2577746-1-Prike.Liang@amd.com>
References: <20261019064838.2577746-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000007:EE_|PH0PR12MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c478fec-df4a-4e1d-e840-08df2dad1459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|22082099003|10067099003|18002099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Yu48pKEAx7XE5e2+FVo3YAkJ297PqeQ03m7BLzhXhMmT8pAWGos6LyZkjRjTqH5IWw4bjr6cnuMicRVlYLEJhWiJe2PHdnecUCMwMiUiLaXd2PgDvtiCpFq9EWaFG1NaxEUso8MpSgQgNvIGE5CB3SfJhcvzwoMT1w3txvSCn/bRFdN6sn2nn7QZ+lF/giivEEUoC8Ez4GvldclmeG/533bXX1TH2b0qj4S6o5OjZA6cIMI3zj2axeL9UZd6wV9pWBeDPriigAk+rZzS4DX8PtATX94bgwWNqeWIXUkyEjd1hykHrh49pUYtHHjkqgdLObu3G+vsZWlJMuWHX0n+gMnQ+iJ7Ii/4MJR/iW62zuUnC/KMMYMIcjskt36EdPHcnwpOlj6TPzGzl1tSIBVB8XPpaWY6G5q9Oc93EVwcMqKPsmc2Cq/83meAURPJN8M7R5lK07qZkYJCjF5M2O/nkQ1KuvJzkuLv80S5aC0RZDZUrQkdSsK3tDuDlFfovzrkM6xqERHfs+NmtxGiSshABm0nz9ghsNzoBO7EkwO07fFy51eLHE9IveywdH0d5xlbwJKK7YJp8QigtxoCvhQDY2LCvV5hSX2MzVewXwlYSyrJOMFpsGdol6OwjT4H9wb4U2RMLdKcFHUULqrFD8O4LrLxAo8bywaT3SySes3Wbg1QSygVFGCevCPzR2t13KMS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(22082099003)(10067099003)(18002099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NQCIQPDy7UerLby59jL0/SdfGLUJEgyysrHw2Y8WSq61fevNGDEPfmbIEjJP72cba83IWJ3UZxIJ2WmOWXyCRLwyG1KGFC2ort9RsCQhRY8plmwgCdTS6vAOjPGab3cFpGVxTIXLSnC/OwGBi84T+Ddl8zUf65BA/pKB5foXay1Vk1xywfpLF3v7jL0+2ijesugSo2bknNnsFabDJHVbPtnfd1nMbyMcu+Ib4F0iejaeiXYKkb0NbXm9D6SUyhuKRhAMBB4aJoWKbkXckcilW99t3PNGJWh8mPVpdXNnMfEO6WH5WREff/LFrjqXEOxFwlrNE+czPjc9Bn5HK4KqES3n+wcjUZsUXHSKMQ2QbpZi0qeYm4RuWHYS46xPZL9jLe7foB9uqL2vtWcSEtD/fsip1T+qro6VrRNScbav5HUkNgZvhhpUhQccH0kE8shL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 06:49:10.2581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c478fec-df4a-4e1d-e840-08df2dad1459
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000007.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7906
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
index cb2bd4833f2e..72ee43ce664e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5531,7 +5531,21 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
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
 
@@ -5565,18 +5579,6 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
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

