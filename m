Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8BDD75BA7
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 03:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3990A10E83F;
	Thu, 21 Nov 2024 03:43:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MX/DtK/F";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EBD210E83F
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 03:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9etf25lrdfVRVJgOUyk7q3SokQGgS4TIEA/2XNcO1LsMKwrr3eQk9FSTHK+desIxcUWHRLyj4xy13HrhlsNV4+uQiOTxiOeVFyXJJmp2ntRsHJmvH12v1TBkz/fZtF17SfVgcCjbe5MjcVA+RMjUqwiwTRxuX4Gb7eYuXqkp3mSz8zivozMr3WDw2r89WAZWDae4PHIemeAYBnJHEuXdUdJG1d8yyx7GXiEvhl+3+uPGiYfz9fMw+HTn9uhusXKSvXe4W+GT/aVrGw2oDmFv9nOyWwbjFcyjLKTOVmqer8goz9Zjvk+Zx657yTKTdrBXDxnnWRFObO8feDdu1b1Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gciyn9ub8qmek+E0MmmWGnkA3NMA99YiAe1705oRgJ4=;
 b=NmkXQkxOr24GiXfAOJRkFn9ORZnGwZtmCy5AMQcsSAr7+39JugkGpq+KlI81VJZfKHscAZcKs9pqoET29NRtPK6wOqtl9uthgqgTDdYVNxqNNU6r+RtpfjD0yVFeLPSjm/xRbH5TzaVIqBLyAy24bWZ0/bgSz9NXAyl/WVUucIIe6oUpPijuo/9F4jWhDTBfUEXuFa+omxSXeDYHlNTcELKu69dK45sSBqbTSsE1/zrnoXBFWVT7jS8kJovDLkVUtgkG37RLtPh5/ZioVADfKEMmBxRg/hegWqrNFCJE0EJLUVtXQ2CjuSGyowSEx8jCx4RhHSzfH1kTHOSBk/MiUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gciyn9ub8qmek+E0MmmWGnkA3NMA99YiAe1705oRgJ4=;
 b=MX/DtK/FiusVs+s1X0RZQ88AY4EwT/hEIgnC2FkDHeNANKhrt0nUG8YzbdKoeD3uAEL6WhPjVswhTXR8qKG7i5Z+2s0tZbhKgA4Hho+0aS/pNibusyS5H0TMpMNejSUaIwvYF+dW471LK5OLwXw0eZrUP8ryjgOD+iWig8QNkw4=
Received: from BYAPR02CA0070.namprd02.prod.outlook.com (2603:10b6:a03:54::47)
 by SJ0PR12MB8165.namprd12.prod.outlook.com (2603:10b6:a03:4e4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Thu, 21 Nov
 2024 03:43:47 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::23) by BYAPR02CA0070.outlook.office365.com
 (2603:10b6:a03:54::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16 via Frontend
 Transport; Thu, 21 Nov 2024 03:43:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 03:43:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Nov
 2024 21:43:29 -0600
Received: from shikangserver.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 20 Nov 2024 21:43:28 -0600
From: Shikang Fan <shikang.fan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shikang Fan <shikang.fan@amd.com>, Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v3] drm/amdgpu: Check fence emitted count to identify bad jobs
Date: Thu, 21 Nov 2024 11:43:12 +0800
Message-ID: <20241121034312.1010449-1-shikang.fan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: shikang.fan@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|SJ0PR12MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: 818484f5-c272-4f25-2cc6-08dd09deb471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M47m1D5vPMZI/Bpxg12sbhJP6rnKn0JhLjofygXJMreuNjPnuZtn7f788TpH?=
 =?us-ascii?Q?ALWKt5oQzBOPajGY2vkh/BuS6TbYopG274Fus6yTSfEyBW+IarJmLJd2c1VD?=
 =?us-ascii?Q?it04kt+Jw1oNln24FIx+q2lEJfwq8T3XKm8VaY0qYYcdhCurEM1byZ91xLu4?=
 =?us-ascii?Q?/1B5LkWgzUlbwIjMNDFqmhEvjNTprdG3wvGMFW38wh8JX9y4XO0JcZzeYZH1?=
 =?us-ascii?Q?Y4wspeV2gcrFBM77lYmGp3dH8a9u/LsAYUz0Cl9alqR5W7/1xZ9La4+RsY32?=
 =?us-ascii?Q?egsvqH6Qlde8ry1V3QuYTn2prOEgRUMhWFywxSjHg4N5giEYQKGk43W2B17U?=
 =?us-ascii?Q?DvrDF+kvglir5TJX6xT33SlMVWyp8gLyWkGs5LSBEbmBQgE/qhY6ufhnGfzA?=
 =?us-ascii?Q?lxDJXSVEeft9DSpsO/JkFVGpQTMj6tgDk2Y+9Rqp7HlMXE1rlXbQD65E7dxs?=
 =?us-ascii?Q?NXSblqPC03IiISb44LmsfZONJG/4ZFSjfz0U8u0E/+/20xLjBj0cSN+g8m/S?=
 =?us-ascii?Q?/ln8v+Q/XYTcxy1N2ZCtUittmHi08L3/QbWhQ4/PswfIypTPysBV/BqKBpBD?=
 =?us-ascii?Q?lfdZspN7lYT4Nn9L4K9YS31GAPKkgxjwNjFYnMCZPMFJAYLRiQp6Gx09n0S9?=
 =?us-ascii?Q?ZieNpWuBch2I0grSLC2DvoCE73VTpwbe8cYC5aSzU0i/y4CuzW7JklM2hfMU?=
 =?us-ascii?Q?ekzrVKczCFltXLDf0B2zlHqzlwc0F3P1t+yYclZ4xFnjEiJOhquTO9Krn2gE?=
 =?us-ascii?Q?oIpUUfuMQfxheETrfCl4QXh4TxJNstwhFP8YUmT3hlNtTRe8xCJklyiB9Z4a?=
 =?us-ascii?Q?FqUmP2UaWuvk17bmtWn9a7+lvDmk9zydmYp1nyVUCncGwe6orRHX6eviHghI?=
 =?us-ascii?Q?I4fgESl5BLOjdaJYUqs1ocUsV/HbQ8NKKn+suaP+7xROhNt6G3KhwxkV1jwt?=
 =?us-ascii?Q?FlPuqKEcIypeyul+JdR1aL0MTlq2uomfMtpdRRHqexbniGAr/qkbZogNHNHY?=
 =?us-ascii?Q?udB++eZz0JBTDnRmglDj5XeLt76rljpHBEr8spF5KwhKnDZZyB3+CgWjV9Ps?=
 =?us-ascii?Q?bNqi/nBLrQi1fNvSPf8nrceQkaB16SKR2kFml9lf5LemePTUres5QpCGpkMc?=
 =?us-ascii?Q?T+I9kcPPWPgC5fem+VbA7fgnGdC9/6iaEg1zY6r4nvM8qUTSgha1knZ3Mdar?=
 =?us-ascii?Q?8BcHU0/lLL626mKt0Ls24wSl5o/Mgb5SYAsPtmWa9Urevb6nUAf3dAN2Q+9o?=
 =?us-ascii?Q?3nbyT7HbtrrJB9nVw+R7KM4V7KUSEMR2VZymee7tQ+6BLe6d2xqqvjdriAA3?=
 =?us-ascii?Q?xpYeSIkwNSid38rWABo4b0qS36tF7QNQznBxEOgcP/lJ8JlVIpyKEjsoBLIw?=
 =?us-ascii?Q?ac22hBZ2DZvuIF1Bq8F6IF/3JRQzmd0PGa04MFU574sQ/iBMqw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 03:43:46.9621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 818484f5-c272-4f25-2cc6-08dd09deb471
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8165
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

In SRIOV, when host driver performs MODE 1 reset and notifies FLR to
guest driver, there is a small chance that there is no job running on hw
but the driver has not updated the pending list yet, causing the driver
not respond the FLR request. Modify the has_job_running function to
make sure if there is still running job.

v2: Use amdgpu_fence_count_emitted to determine job running status.
v3: Remove the timeout wait in has_job_running

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b3ca911e55d6..ff9995c0f764 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5222,15 +5222,19 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 }
 
 /**
- * amdgpu_device_has_job_running - check if there is any job in mirror list
+ * amdgpu_device_has_job_running - check if there is any unfinished job
  *
  * @adev: amdgpu_device pointer
  *
- * check if there is any job in mirror list
+ * check if there is any job running on the device when guest driver receives
+ * FLR notification from host driver. If there are still jobs running and not
+ * signaled after 1s, the hardware is most likely hung already, then the guest
+ * driver will not respond the FLR reset. Instead, let the job hit the timeout
+ * and guest driver then issue the reset request.
  */
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 {
-	int i;
+	int i, j;
 	struct drm_sched_job *job;
 
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
@@ -5239,11 +5243,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 		if (!amdgpu_ring_sched_ready(ring))
 			continue;
 
-		spin_lock(&ring->sched.job_list_lock);
-		job = list_first_entry_or_null(&ring->sched.pending_list,
-					       struct drm_sched_job, list);
-		spin_unlock(&ring->sched.job_list_lock);
-		if (job)
+		if (amdgpu_fence_count_emitted(ring))
 			return true;
 	}
 	return false;
-- 
2.34.1

