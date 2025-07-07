Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC95BC83F14
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 612F110E531;
	Mon,  7 Jul 2025 19:04:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QH/4aKDz";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CCB10E52A
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnGGsV2UpVNt5dDixWUxpF/b/hPDpEM0QU0c5rbzMtMd9bzVBaCtoyt+drTz/Mnof3Lxt/FTqMBdCzE2EjLWHyTB8ZxcO36G0Upt15AcpjC5aiDmRYG+u7kg/YcTpHzAk9Y8EiskTJvH7eTytTQYOm8IbkF53YMW1IZw3c36qgnf0wK0Fq5yQc0vKZ12ghkKhyYlMgjJKQZU9ga07DnCS6yIFIObNIFk8hPK/KgtMoORN5C+95XdcxgYHmgohNCqF9NaAvsrP4kVkyMfD36hgySOAyijVGFV3Qp3knvNvJFs75Hvq7F2jfRprZfBl9xfb+qLmIRz1QeuKDBakn2lVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hywv8OE8W6XFXMfgc72RdNpK619tLpIIBbtFhAl+fMc=;
 b=wqpaENCV0sqMXpuw9oo//rbSnNUvV6MeKTAFd22H1hdFCVImzMDNH4yc4uw0jRrwELW03COMEPodNj/LZFooEwZkk3zlzFpO26W7WXC5V/u2HtMysC7WUkS4ooyAwiSd5cmNAS4E5CdqoNmtwYaYPr+9k5KOKFkSDMiOM9vKxD6exCCn3kkc4ovEF5LGugiv42AfeLeQn5D8TYYAx/3TrJ3B0vXO9zfJzbRIqWkJAsKlhyXA4PzcaJiUpK37WfB0jMMAhoZQWto/3APm8NKJl75OO068vLNDyvM1erMiQ4SSFi1wMUsAt47lLSS8GHUsWrXAZ0EDx03Ho0+lMiyxxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hywv8OE8W6XFXMfgc72RdNpK619tLpIIBbtFhAl+fMc=;
 b=QH/4aKDzRHTHM7lhmx4aXOw74SkVTYV6gMxkd3W58dkUTAAe7pjr97lKvZOAuU/Z+7K0im/hRBsLCPL6FHoSoHqXCfkT8sVtzHUcivv6/lbP6W3pEPpgvg5sDJ1ZrDbEEHRrgdT0a1eLyO7KDwn5AQLtsqoeVtr+nqj726Noo2w=
Received: from PH7P221CA0088.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::20)
 by SJ5PPFC41ACEE7B.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 19:04:31 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::21) by PH7P221CA0088.outlook.office365.com
 (2603:10b6:510:328::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 31/36] drm/amdgpu/vcn4.0.5: re-emit unprocessed state on ring
 reset
Date: Mon, 7 Jul 2025 15:03:50 -0400
Message-ID: <20250707190355.837891-32-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SJ5PPFC41ACEE7B:EE_
X-MS-Office365-Filtering-Correlation-Id: a4da7ea2-50e9-454e-92bd-08ddbd891a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QF4KIwWveZFqB7pOuyXJOIqR3/aqAhkxIVSCRkkm6gf/OPTSeKIEPm3Sl2rS?=
 =?us-ascii?Q?0VoeJp2W3NaVxTW8CD93zq3QclCwBwAQLP7icC6YUfWeZnv8gKG7nemSiGt5?=
 =?us-ascii?Q?5ANo1uF7eyF60LoWXI46nQ4deyNLOvoNGB5YOW1jO4qjnjSISM9NkN0ez9cn?=
 =?us-ascii?Q?XQZb7BKZN9ZjaM2a+DQgk97wrnD6+ceShV9BrB4dRLIk03uzw4NlMM72xfun?=
 =?us-ascii?Q?vySrB3tOrPsANBpODXKCjBTDIxcM5entOYilB1IV03T+qXd4tyxUFR98vEbh?=
 =?us-ascii?Q?/JRkLcREjcp89mZryHu6fh2Pe9cUXZdFRyOhf4qiQ/suwu0ZUBKl1sJY4ST/?=
 =?us-ascii?Q?hSaDVPguhCalVD+PoYU9OQpqrFKk3oE/Dcb+RwrTlwTaXIIOeb4nxjRyVHq5?=
 =?us-ascii?Q?lwIXz9bzQBBSVrgpgTM0JeSPjDeLtirMiUfCNGbgiQCoL1adAhNPuKzFJMT7?=
 =?us-ascii?Q?qtrAKEuokFV+LvY9sKINeWQ31A+mOH9rKsTweUyksGi1pbfuyfhSDyrJiIHY?=
 =?us-ascii?Q?7EXOCD4f9xHpqxH6QSbeY802MUizdUVCKKg31BYXtelWKCV1pZ1QRI5TNiDa?=
 =?us-ascii?Q?zZujbIhnEhhyJ6y9FAKM3DAWEk89gfGMTU7LGm5c0POjnsxHaclAohHhA5j8?=
 =?us-ascii?Q?DLDi9qPz2apXlyzbEANo2GYUXKEkD061Pjkpf1AHbraq2ylICMDvo+HUtQai?=
 =?us-ascii?Q?SdZM3xTIV4x3Vyoih45H/gNKKavvUMWJgN6Mnus5/K7BP9mii60LWwh+vdaP?=
 =?us-ascii?Q?yqjuu4AGLjAf7Q8OLA7Fd4aIIcTWLQYMTpTXbm2OONAJUfdKodWyESD8kjps?=
 =?us-ascii?Q?PSPDJmT3bJlLnqwBroWhznmXndXR5ZYFFWKhJrAwtgt2Yo6uFL8OwmDYeb5R?=
 =?us-ascii?Q?1ZaomDj8dgLDLl5PgWd0EsVgFvh/ut8ScEp4yBBUvid0eMeGL/LWlPbl/UjG?=
 =?us-ascii?Q?vs36anpZeGfrdAM+OeNKvw+dJ9EUCSNUobEcKDVIxgPULTu8/CNQEjkkFcba?=
 =?us-ascii?Q?vnhT8omo9iTbljhmbDM+m6HMk1yaxpf6mrnbbS12Bm9BOGrgpqPQa6mKUh/+?=
 =?us-ascii?Q?c0gPp4JwF9f6bDsP0YnOGPW9hUSF/EO5pS6Nae15j73QIi0n3a1g/WGxqtQ3?=
 =?us-ascii?Q?1wAZAcdvITwakOGnRtypIJ3SzJ9V0PjF+zjmRrAVwjV6/IKYGC06udqbIbAs?=
 =?us-ascii?Q?cZ6ZICH0PWcd1WHPjCEAHvNYjnDkD791z9NgSh8+eXvEEMTS3JC7AOQbqXfB?=
 =?us-ascii?Q?VG3NIl0KX2HlbkBZB2aTxRON5MsOQwn7QE+/wjIVLHr6zrb61WkwcR02pNdX?=
 =?us-ascii?Q?3KD5jde1k1MwRP1QeKWuPR39rDGSKhC84bVnzEVklwcfPgmu2m5d8wt4VsAl?=
 =?us-ascii?Q?qqrwuNDE2OpEd5OA59z2c8yq83OUa9SgS4V0j9tnY07MYETsEIOyJdCSBZXo?=
 =?us-ascii?Q?bfSYjXzY2aucXPLzg9KKUiEaLmuHLopLctg+kN1jwOQKK8sin0ij6QKolH6D?=
 =?us-ascii?Q?fkLNTfyDjN0fKoUIM2qQQJWEOCIA7QTnHNzA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:30.7018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4da7ea2-50e9-454e-92bd-08ddbd891a6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC41ACEE7B
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

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 6000c528ad6ae..f42ae56344112 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1476,20 +1476,14 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = vcn_v4_0_5_stop(vinst);
 	if (r)
 		return r;
 	r = vcn_v4_0_5_start(vinst);
 	if (r)
 		return r;
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
-- 
2.50.0

