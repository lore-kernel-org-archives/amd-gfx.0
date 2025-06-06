Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7DDC5B549
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D73A10EA05;
	Fri,  6 Jun 2025 06:44:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AJj3SE7e";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10F3910E9E1
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOhCtHRNcA7oQgYrTwgVFa2d9j/i7hw1zaOB6ihPSppRFnpTdvgPYY7FXuMpeOwmL+D/i0oqtr3hIjMuv1jB4XVDQsvjxlYmDRQ9FCPgKAs5M4nB1nDDghtz0tfgLwRhlW1inN5X+BfDDdmIjL7nUqLNDW3PgmOSL6QUoxr73Zu7q21+FRGXQiMdzfyBq0FE1rc5FUjj21qxdlyIcPEayzSeTrEnbJE5D8FIDbq9N/NYsm6zf+/5A1ukxZQNGIuMWJIwbhHo0GCzdAJ+lJkze9Ng8/MqOaiyj7IG38FrgomnMRiDBHtH5CtkC78V17+5jXbrqFNLMPaof+/MPww/Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qmqc9wf1mmLNDKH9zKbaPz59gLtRrRlmZasuXhiAxO0=;
 b=pKi/rmkqFvc9MBRo+pTLhAAQlj4IoTiz42w8Iq8KZD/58SF8cpOybgtOGXob00JeHLF0m+KN8Ez/GrZseayLDk9O7OxRZOZoYhkWJTXRJHQN56MTV2QoP61JXIN+lERdc55iXBighqZ0Qc5bGq4GWpAQvLXenNjs97QNViFhet+4qhaIVA850cEF7z39u+SqbCEt0OT5cLfYCYrfXDeMpWtSHsakLVGSEmE7hT7K5PoL6eqGivOpMXYyA0OwaJbgYbBjP8nWhJf1TDZ5lfpCWf+GVl8G7/qdUEkjmsNU96s/c7JxYFvTs4fu49QI9pYYg2X6cs3ouo45lbuF16tDig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qmqc9wf1mmLNDKH9zKbaPz59gLtRrRlmZasuXhiAxO0=;
 b=AJj3SE7edqt3d/O6ummAh/zb/sPZRq98gDawThxlcV/C+LJZeTP7jYaY9Ehqraig3t/4JIIUU8GdV/iEjDwV0o7/fnYdq8dQz7wASMQTTRvyVivD6D+UeCneQiRMeiSgdrnWa1tC/rT4L3oFHinGqzuQb3RoufO3ElMqZQhL8TQ=
Received: from SJ0PR05CA0080.namprd05.prod.outlook.com (2603:10b6:a03:332::25)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Fri, 6 Jun
 2025 06:44:27 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::e) by SJ0PR05CA0080.outlook.office365.com
 (2603:10b6:a03:332::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.8 via Frontend Transport; Fri, 6
 Jun 2025 06:44:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 26/29] drm/amdgpu/vcn4: re-emit unprocessed state on ring reset
Date: Fri, 6 Jun 2025 02:43:51 -0400
Message-ID: <20250606064354.5858-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|DM6PR12MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: bb8e5733-6928-46d8-94d9-08dda4c59490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UfZk85LJUDfxyiOHmw3PMR9AJ/ii1BcpfobmDZXzwQrODvEpV4g2BmbSZksr?=
 =?us-ascii?Q?4AHi3SPdHABYBFYsf6TcSyj+tMIi2/BdXjk892ErKQHYX+M37zGtvhmH3Va+?=
 =?us-ascii?Q?dlZQNKgkW37UkT0KWGuWufe7xIFjTwmKmzihOwQ8A9uYSsFv6C3XZ+S4yFLs?=
 =?us-ascii?Q?IX3c8Fx+IBnqkdhUy/MyQEDehnEQEFuddPdprvHMki2xj9mRzndz+CuLktxZ?=
 =?us-ascii?Q?2ZPiaknblZWx4pv/0L0rvjbLDF5TIBQZh8WGrPt+tAOE6B1xIhU/7VJZMTsq?=
 =?us-ascii?Q?FRJkc95L8oPYmnueeqTVQnUf+HPDm92z0zqzRjXaOlpZPzK7JQev3RIySLtm?=
 =?us-ascii?Q?sCbaP3siJ2iKeUrA4EUXZ5stV9xf3hKHyYr2ifZNmXl8qwC/GX9sJQOiCGjT?=
 =?us-ascii?Q?+C1ZbMDcidC8Wxjy1397Fiyv9xCZ6a3Ns5C4QwxxEBCBmx59i8+HoYLdCgBf?=
 =?us-ascii?Q?pWWtKrdHhCgR9lnvsAP+44o+rgQVw0UpEqqZW7oFhV5OiPDlJR3D8YUy8yEB?=
 =?us-ascii?Q?Iu4J9wPpu5wcJqyZy/nFNdD34F0r5aBONXGA2NCqWjwnhRHxnvBTc1LBaRSl?=
 =?us-ascii?Q?1GKRLDKgT1byPRla73QurhVgzh0qv79cS4DR9yPh/4XQZg2y7ov7fGTJxmjy?=
 =?us-ascii?Q?x0ALCVe9lfmvyzNqHaDRyvnC1S/mfsuVGjuMCW3G50HF88Bo9YOodOUr3tCc?=
 =?us-ascii?Q?hILaeIdz4dccj0EsSNFRp1V2HkePFf9E1+zUv4ORFyBXuDVZECQN89eIx6FI?=
 =?us-ascii?Q?dBViQoibJbpXBE7GJvkX60xMmCBi+xc2BqtqbSNtFFgGLpn1tpmuj8YLfewT?=
 =?us-ascii?Q?CRdgDgm6OmrYDH1Nz6Fnqlm7Dfm4wA52x0Mz4Oo8sVIo3DAagD78TM0J6otb?=
 =?us-ascii?Q?8pCaA7ZJL/DB5k1VHcnbHUHK6VLbi0zW9nbdjyS7Re6EivXYnNnR/f+T9YqV?=
 =?us-ascii?Q?HIynmqmNlOeQj2KjdW13SJ7THsFLtMk4hR+zlWxiE5ceDFE0xFiyCLmkTXgn?=
 =?us-ascii?Q?c52rJ4+CRgsS+bPSm7afX7uCdUPvyAOPLnCaNlSNn8D91ufrolsn1ZpXNOOH?=
 =?us-ascii?Q?PNsvtox/3jOHIymQMp+EQTO/EXjgHxt8bOFEoDlZ4+zFHqCb3zeFJ8fZyz+n?=
 =?us-ascii?Q?Pi2IFj6ufnI+1S2HodzNap01zIdFQvfOg880+XVbMEnozOTKnEC1ho9b0+K+?=
 =?us-ascii?Q?eihm+J/Jsv2+e3nrNtU+cXVhbTi+jcKBXBVB4Vti3oxlV/z71Y9LC8T/a0Cg?=
 =?us-ascii?Q?SCYmK+ocghzU33BVtEYWXeXHGZ7gHnhz+QUoCC9G9g5ahAvNUDpuZ6lQ2AkJ?=
 =?us-ascii?Q?okU+cJjZqgThP/m3NoOegJ2fxv//t++xK99wn9X71x1BTAsLWYuPQXwawHYv?=
 =?us-ascii?Q?KOixt0F79eSYzbJSHaXpaWT42cgu6G2LugHpit2XXQ2qsI2aPqIAuparAuJJ?=
 =?us-ascii?Q?SDftIL3A32+r3yIZekdcLu0p080O82ozLJdLEISvH8phxa2LjZfZ9guMkJly?=
 =?us-ascii?Q?UkM+Y28Zzkm462lnzOd3fdtiDcEpDBhkK3M7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:26.3150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8e5733-6928-46d8-94d9-08dda4c59490
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index d68bd82f8eab0..49545772fb630 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1977,15 +1977,22 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
 	vcn_v4_0_stop(vinst);
 	vcn_v4_0_start(vinst);
-
-	r = amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+
 	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
-	amdgpu_fence_driver_force_completion(ring);
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(&job->hw_fence.base);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

