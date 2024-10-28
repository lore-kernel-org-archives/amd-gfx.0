Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C173D33992
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 14:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DED2310E4D5;
	Mon, 28 Oct 2024 14:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N001HI7k";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4626710E4D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 14:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cyc3lES+XaljOBP2Kmtvx/GsiQidQUmqn4XbZmD8eJRheur6RjDvHVXCzUIDE3+DrScr+nyQHgwcynQmvI/X2qBZEw0FuYSKeCuCMgL0M+zPkGVYAkZr/gYOen5IN2SQgjELH9NnbCNbTSnIBG87aUcMZfYoMQZmARltWyKekhwx57QA5JRGTrFY0BtXmq+wVC1xHGIk5M6rYWbzKMY6Q93itquTByIuPGR5sUT5mWlgLS2AZIQCQ5wV1Z3z2+XCTZGV5b9hO9ooErjnVbLsZWMtY6XXUlzANqqKVK7t+sP/4qc5Yfq0u8HU34jA6rM+rdWZUeqiNytjYsi0aslmdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQvLpDrYYdfjUQDvckyA/M7Chb9hpiPmLFxW/xjeUGQ=;
 b=IpZXIHRJtJbzqK9mW7ChTsWyqNFJCCZy4g8nvL7SPeFjuL4bIwK10lBfflAjai6kL7OhicXGipBT2G4MTIFTKfAQN82o91Gncw8ZLROl5CqlGH0GX1S/rpNT7B0Dqnaai02i+5bwsH8EyOoUGBtlZTyVxsRvd+dGvjsVBoAUjgIRAuyyoD9WS5urztsmIZtH1jeNLN1yPH4IsCLY14l9ylGkYNg1VDGxGGE1RLBiYwOruTSXAMj7b/7vVlmLDUKv1lTaC0l7p4aYS/RYvrpWdrmUEO3WKym2XHbtsi82Hx9Y3maB3TyApDAxs6VEBtHXBpJ1jmLovIbIUONt6PwZLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQvLpDrYYdfjUQDvckyA/M7Chb9hpiPmLFxW/xjeUGQ=;
 b=N001HI7kGzIdZf5qcMN+QlODVX4C1PLiTS5nRGvUtHcgvbW8DQu2sssQyTnxR0EHieYxtYGJC3fWIvk0v9yE+Ej7m3VDhnx0wtrlS2W+cYa9gnlFQGV4dDw4SRU4Xx5LfY/kbjvF8eCzYr4PlQIaFNlFcjIbPMJiXrYodWJI1fU=
Received: from DM6PR02CA0160.namprd02.prod.outlook.com (2603:10b6:5:332::27)
 by MW3PR12MB4441.namprd12.prod.outlook.com (2603:10b6:303:59::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Mon, 28 Oct
 2024 14:52:56 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:332:cafe::34) by DM6PR02CA0160.outlook.office365.com
 (2603:10b6:5:332::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29 via Frontend
 Transport; Mon, 28 Oct 2024 14:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 14:52:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 09:52:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix fairness in enforce isolation handling
Date: Mon, 28 Oct 2024 10:52:42 -0400
Message-ID: <20241028145242.3672515-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028145242.3672515-1-alexander.deucher@amd.com>
References: <20241028145242.3672515-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|MW3PR12MB4441:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b01c42-66b2-41b8-7687-08dcf760354e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rrWlXLYMq7ny0bFtEOFlWIlBQRQ/fTxGfWPg76wuo5ebCf11E8PABbxLOAOP?=
 =?us-ascii?Q?ryExcRBcCbcDsHdqDY8wOSZusF3lwbc6/9Hxzu4Pb+NJlrQAv6Og3bhedbPW?=
 =?us-ascii?Q?GFPOo1Oxjry0zxz4IeIZxebxV8LOhXtm7ri/h7hJ12YOtLBNBIkRmI+WAFFC?=
 =?us-ascii?Q?h53g8fM+GATOLS2z5ym3TToKCz1G4+9eScB6rP27n6RecTtPvSoePzsutNRk?=
 =?us-ascii?Q?xCwWJZkKBq7PLVfzvcTRs4ajihnNcgL71YgdJBh9DeUmsd4VHmf/BsauxSOB?=
 =?us-ascii?Q?5kzYfTn6N6A+eADuhXei8yQ/OyVUEK+E6n1Px+wXkYQ5rCs/s4XX8upIMCT5?=
 =?us-ascii?Q?LFYnDHvnGfINCzCHhuVIi1vtqaJ3UzUYggAOz7pk9J+IXoYGFW+TJZsMaiSB?=
 =?us-ascii?Q?QH/Jq+FVOeUoie2Q/TvoF237qGxtCQkU2P+pMBEED21YQccwJPUXjQWdrtg+?=
 =?us-ascii?Q?WR5MuANqpeZauKty+LFoiKLz5sMx8xCUwvVmFJvrjd7EWrMtzXDG9sMPZf3E?=
 =?us-ascii?Q?mfNR3of9s8uHHy2FUhHvu50At61JGfsoXiKjp45RjkMwoxWbYWW0KRqVCyEV?=
 =?us-ascii?Q?b0DpnSwrLlsuWJajJncJYoPLVk4UrU/3NGqBcoYxoPV3sZp0In4lfDm/yk2P?=
 =?us-ascii?Q?nV0Tbxi6uQJywQzQ6eyQlyVF7aCOOlHLc0alDPk+IdnwpgWDKH5bWRzyrAj6?=
 =?us-ascii?Q?MFPfWgDKhDqj+4grkFtMr2Wv1PH6QkqG8GBtCiLoctH89x3h2D1ZygllDMsg?=
 =?us-ascii?Q?VDOiomnHMfULlXpu7fM96V0OSJdzMVKIWmueWuxY8tcCVGQMWP6VZq97PyER?=
 =?us-ascii?Q?Qm2UQ2YN1iBXYxuhp9vgGxXqppdNY4fQ66aOPfeXE4wjg/tW9UH3DBfTh0bC?=
 =?us-ascii?Q?KqVy/WZxurQYQeDpDzolzHfuIswhyCc0+gh4n3A0lLi9ThFEffEfPB3wrnQI?=
 =?us-ascii?Q?nhYpWPLT2RQil6PKfFERRTZoQeb87qrq0IiOk0B+38QdNaJh+2rgjRtXp1JJ?=
 =?us-ascii?Q?UokGCQF+dwwbRVY6dh5JvzDSIcDhYwU1mdDPLyuWaahD/juNL4q5ubC7V35V?=
 =?us-ascii?Q?Ep6XlywItv0uc/iBvgtYaLx56Er2SI5qZzjUd3683WfrjLN9iZ7LvHJ6R5qa?=
 =?us-ascii?Q?fgM/uTVAGKSJUGRdSb0tGd/aCQniDRiINVQt1yDvEPxDxErjSY8s3i/Qfl0R?=
 =?us-ascii?Q?L5NNt6g98/6K9unEfpJUdLdasdkbxIBsyrGDkfdQXRjs/aSPMp5+vIono41h?=
 =?us-ascii?Q?TA1YETrzCAgmidSlKg43DYLlDvbqpe10k790+c57GJPMRZ15CBa+z5PnAfTm?=
 =?us-ascii?Q?jb1yAOOEkW5XB0ATy34aGQa6vGaCbBdcyGmdoH1grAPuHuYcHfjyyes7G/kz?=
 =?us-ascii?Q?ZJNH/3cKk/70bkvN7mgG5HV2BXH5B4wqKXcNelUFyOiKaLgdmw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:52:56.1929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b01c42-66b2-41b8-7687-08dcf760354e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4441
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

Make sure KFD gets a turn when serializing access to
the GC IP.  Currently non-KFD jobs can starve KFD if they
submit often enough.  This patch prevents that by stalling
non-KFD if its time period has elapsed.

v2: fix units
v3: check enablement properly

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 53 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
 3 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ab5524b7a259..2f381848c849 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -119,7 +119,7 @@
 
 #define MAX_GPU_INSTANCE		64
 
-#define GFX_SLICE_PERIOD		msecs_to_jiffies(250)
+#define GFX_SLICE_PERIOD_MS		250
 
 struct amdgpu_gpu_instance {
 	struct amdgpu_device		*adev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e96984c53e72..b8cc4b146bdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1752,7 +1752,7 @@ static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu_device *adev, u32 idx,
 		if (adev->gfx.kfd_sch_req_count[idx] == 0 &&
 		    adev->gfx.kfd_sch_inactive[idx]) {
 			schedule_delayed_work(&adev->gfx.enforce_isolation[idx].work,
-					      GFX_SLICE_PERIOD);
+					      msecs_to_jiffies(adev->gfx.enforce_isolation_time[idx]));
 		}
 	} else {
 		if (adev->gfx.kfd_sch_req_count[idx] == 0) {
@@ -1807,8 +1807,9 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
 			fences += amdgpu_fence_count_emitted(&adev->gfx.compute_ring[i]);
 	}
 	if (fences) {
+		/* we've already had our timeslice, so let's wrap this up */
 		schedule_delayed_work(&adev->gfx.enforce_isolation[idx].work,
-				      GFX_SLICE_PERIOD);
+				      msecs_to_jiffies(1));
 	} else {
 		/* Tell KFD to resume the runqueue */
 		if (adev->kfd.init_complete) {
@@ -1821,6 +1822,51 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
 	mutex_unlock(&adev->enforce_isolation_mutex);
 }
 
+static void
+amdgpu_gfx_enforce_isolation_wait_for_kfd(struct amdgpu_device *adev,
+					  u32 idx)
+{
+	unsigned long cjiffies;
+	bool wait = false;
+
+	mutex_lock(&adev->enforce_isolation_mutex);
+	if (adev->enforce_isolation[idx]) {
+		/* set the initial values if nothing is set */
+		if (!adev->gfx.enforce_isolation_jiffies[idx]) {
+			adev->gfx.enforce_isolation_jiffies[idx] = jiffies;
+			adev->gfx.enforce_isolation_time[idx] =	GFX_SLICE_PERIOD_MS;
+		}
+		/* Make sure KFD gets a chance to run */
+		if (amdgpu_amdkfd_compute_active(adev, idx)) {
+			cjiffies = jiffies;
+			if (time_after(cjiffies, adev->gfx.enforce_isolation_jiffies[idx])) {
+				cjiffies -= adev->gfx.enforce_isolation_jiffies[idx];
+				if ((jiffies_to_msecs(cjiffies) >= GFX_SLICE_PERIOD_MS)) {
+					/* if our time is up, let KGD work drain before scheduling more */
+					wait = true;
+					/* reset the timer period */
+					adev->gfx.enforce_isolation_time[idx] =	GFX_SLICE_PERIOD_MS;
+				} else {
+					/* set the timer period to what's left in our time slice */
+					adev->gfx.enforce_isolation_time[idx] =
+						GFX_SLICE_PERIOD_MS - jiffies_to_msecs(cjiffies);
+				}
+			} else {
+				/* if jiffies wrap around we will just wait a little longer */
+				adev->gfx.enforce_isolation_jiffies[idx] = jiffies;
+			}
+		} else {
+			/* if there is no KFD work, then set the full slice period */
+			adev->gfx.enforce_isolation_jiffies[idx] = jiffies;
+			adev->gfx.enforce_isolation_time[idx] = GFX_SLICE_PERIOD_MS;
+		}
+	}
+	mutex_unlock(&adev->enforce_isolation_mutex);
+
+	if (wait)
+		msleep(GFX_SLICE_PERIOD_MS);
+}
+
 void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -1837,6 +1883,9 @@ void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring)
 	if (idx >= MAX_XCP)
 		return;
 
+	/* Don't submit more work until KFD has had some time */
+	amdgpu_gfx_enforce_isolation_wait_for_kfd(adev, idx);
+
 	mutex_lock(&adev->enforce_isolation_mutex);
 	if (adev->enforce_isolation[idx]) {
 		if (adev->kfd.init_complete)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index f710178a21bc..af9dbd760fee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -472,6 +472,8 @@ struct amdgpu_gfx {
 	struct mutex                    kfd_sch_mutex;
 	u64				kfd_sch_req_count[MAX_XCP];
 	bool				kfd_sch_inactive[MAX_XCP];
+	unsigned long			enforce_isolation_jiffies[MAX_XCP];
+	unsigned long			enforce_isolation_time[MAX_XCP];
 };
 
 struct amdgpu_gfx_ras_reg_entry {
-- 
2.47.0

