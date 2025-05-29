Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BB3C5AD49
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A77810E25D;
	Thu, 29 May 2025 20:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0PDr/CBw";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BA9010E24D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ez9ixaiweYv2kfSthmJeHSis/TcBFx9PybT8HqlLvtgzeZpMdi/IGbLx/w7aKfCn4pzjfuSBfX9dlwyze47R6Fdi2niGQMFe8a9N+USe8hCYk3YyJIPcH8uKwDFAfOFYxzGpd8NBYzjMLhOV+Pn6elRaEZdEB8FQdtF1PNHSvwjH5junzrxAiOnWycOTUMuHKBeHaSzT5OffxVvryQaKVH8kLM0AghTNzfhywB40uGezRxcK6O03ZbIAY/D9rFFYJ8nLvyBcFwqKbcAq67zH+rNSWja9kJvLuYznOuIOG8ZrOSB1YAA0DJnQEccEaEQgWnH9aJvApeKnmmwaM7GUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLVhyEzzs64nsiVq2sr99MeIMiFS7b4du/XkQSMoM7A=;
 b=sulfQvxOjnsAD061wi/yanNBMVPt3QaEaLMILIEWTCUrokL8CikFHOgbaF/y4KjzoE8VGXEVPEkZx3RaRCD2qIaWbL66IS1EEFQfeCmQYAJs+eHlvZUMrHNZNwkboSmYQvuoy80N4n7AQ0qO7Qc1ZBeKZ2mHFi8S+JZygwioc8ExjzkMKEjjgBZs3FWC4Jpl/VgtmA/q+AClsCZXkOu1ZQK5Lpi0cZxVpyFZ+ppURpPJ+RqZrKSsbmOZ6MnfhNuUqFFsTjPqAgBBfFQyFaHJR80RdH8EXFb67DBD1bwPPKucpXhzcEZMwuIIy8a+R0rb1K7BA0AEMAdjVGxvjHQQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLVhyEzzs64nsiVq2sr99MeIMiFS7b4du/XkQSMoM7A=;
 b=0PDr/CBw7Q37U1eROkNADjHFwIB0EHxmk0m6SK7UKdnHefewLe1lr8Fm0UEDTHoF+Do82QzwaeugdmdgJq/kKQZ1CHIIjnD1Lf5tJ9fEG3uWq34GcMMHnsiAS4pcZr3ZQL4qZZECHmmwzHfhOEe6SoEZKmYZs0jTZhl0rPgS1FI=
Received: from MW4PR03CA0045.namprd03.prod.outlook.com (2603:10b6:303:8e::20)
 by SJ0PR12MB8165.namprd12.prod.outlook.com (2603:10b6:a03:4e4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 20:08:28 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:303:8e:cafe::40) by MW4PR03CA0045.outlook.office365.com
 (2603:10b6:303:8e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.22 via Frontend Transport; Thu,
 29 May 2025 20:08:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/28] drm/amdgpu/sdma5.2: re-emit unprocessed state on ring
 reset
Date: Thu, 29 May 2025 16:07:44 -0400
Message-ID: <20250529200758.6326-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|SJ0PR12MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e35089-78ee-4119-d950-08dd9eec93c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I+BXByY9PzX2a8ct5S/Xu0KkrAM+AbZ0/f35ffL+7psqB3E2MO7Vu/NEnE6Y?=
 =?us-ascii?Q?/yVWus6egIt6mlUvuejS/oXtxnc6VOaNQoRJCV6YD37YvqM3WZ3xRyLcSesv?=
 =?us-ascii?Q?dblZINurF4CMBujwNSeronVcoDaikgMCv4z+beBiKySDuP/s3ebb9Kw8cVCb?=
 =?us-ascii?Q?VzWKIqesO44n2xO73Hi9w6EovNFG3THTpBuj7qyCznbyVls0rf5yyHdGag5u?=
 =?us-ascii?Q?40PWXEVmNcbDLM6vIqP2Ss4M8ssOgDs8wIQZ0eYGaU+0TwThni/6dpehvGms?=
 =?us-ascii?Q?hlY5Qq1mwQInTNVFMgNMLwmRPIgpuy0lE/pcKFIEiB5OWYBL/GviRLwVcF0E?=
 =?us-ascii?Q?LYtgbXah9+XvZ9OTpIIcPMxJrZLoA6VbKYUNFr3lJhur/vCWghGZe/US9dUt?=
 =?us-ascii?Q?xLXvcOGVQrhWJySFCIpoCbDJVRWLqfadibT3ysnHSD8fEcOgIvmfYtpNpwpI?=
 =?us-ascii?Q?NwF4Sq3bAi92eGPAfzUFY8q03xJZepOHfEcz9dX2SI/IFRlTdRlxx7tcjqgv?=
 =?us-ascii?Q?ZD6fT5ed5U0NIS7Gh6s5V0zLj0UaVRupyuXojgOw1G37ozY3aieW1FDeEvgT?=
 =?us-ascii?Q?GqZD/oLnN4KzDlhYFnx/ZGp90f1Z5RetQTiaUIjAHW1SiBbjJD+DmBNzejqQ?=
 =?us-ascii?Q?uKinS8gUaQxkuU2skDo445PrqGiDE2fbWKrOYdkMqL/3wWyvvpQRxk/Z9DT8?=
 =?us-ascii?Q?xe+/W34d0EoUUpDVt/j5kQDOQsbK3NBFstpKD9QWx7CYtyb9VgYIumeoW7xi?=
 =?us-ascii?Q?9T+gXdtrllPG6PUaukhItIFwzFA9qprQcUKz9hjiSH/xB1NYiPqipCdn3wgt?=
 =?us-ascii?Q?GS7f9zBRmPGQyxzV5VTil8xE3phDcpbOfRFvMiGQ6JRIhY5gf76gj41FBGxP?=
 =?us-ascii?Q?jRke2jmqmLVuPbzH0joGbvDtbKW/szjZW3CqlKgWEo/e7ZTb5kd8hF6Vk/cS?=
 =?us-ascii?Q?22qXs2uQp9wjTVzeyJOQ5B3UZTknIsF6F2FLeZotAuqYdR6SvC7eaOYkGPaQ?=
 =?us-ascii?Q?mP+31GRsUwpoWA5XiFFt9ZtbbKNr9Z4/1u7BmneqOyHYOv0HoxHTuQFpOv4O?=
 =?us-ascii?Q?FXMAC4wrApaJluUFtGebJCZTtycz8DCrNIppCquweQJtlh0d/pwv9+6T1DUT?=
 =?us-ascii?Q?b843znT17wkhYAenQZwHnLJXWUq0Hnov8zM+A0RkmGmWuCwbgehPL5GNUXrZ?=
 =?us-ascii?Q?OnR3Nm0S9jr48NR6DCyrGTwGtVHEcgLeFSKLTOu84aD3i/B0UJr8kUgXqpux?=
 =?us-ascii?Q?Tix+gFOZ9iicnEQ/sJlPgZ4Kx4WxWV/oOGVdlAV5n1eOBy2lY5FHwM970INH?=
 =?us-ascii?Q?LM7g4ZlXJFVcmKSaUJki1EBW0zLX0R42fO4f077Oc5+ukIeGy1KW7rk6g4Wn?=
 =?us-ascii?Q?w1/JFxMC3iP3k7OsJBo6hSQWtxylbCIvIFc6te0VaSEFtKLmCgM+SVt//Fxm?=
 =?us-ascii?Q?CjAmU3e2Azd89nCLSBgv20rKShiq6ERhpySiMlG0mtKnruiU0BgGcG3htrP7?=
 =?us-ascii?Q?usEOqNflXcgaSl79Fsgl0MYVpoLUBCgceg2W?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:28.3781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e35089-78ee-4119-d950-08dd9eec93c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index ee94e457ee25d..64ccc2c09fa12 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1458,8 +1458,10 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	int r;
 
 	r = amdgpu_sdma_reset_engine(adev, inst_id);
-	amdgpu_fence_driver_force_completion(ring);
-	return r;
+	if (r)
+		return r;
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
-- 
2.49.0

