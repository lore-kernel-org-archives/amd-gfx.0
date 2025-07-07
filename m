Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B44BC83F14
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAADA10E53E;
	Mon,  7 Jul 2025 19:04:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UXbKUs6H";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 931D710E534
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXhTjHKQz1eu6yQJTJQbZuhDjo1iS6jSPBW1gjLnul96aI7lwfN0+doZllHMtyJukeMUq+7geFTpoc57NpewGlz2k0aB02cHfLlTTFrqvCKoNwa2/v0SMeBbKl+7jKeWJWTfO8ell16v6cdEH+/EmgA8Gr62wtVwCYQvq7Wn/scip2NUmXH9ef7PRqIkZtL69NlHXZrJBCHTsbOzOMs+SXV49uZnAeE/T4XqOGyQawBqCqPLgSsyILzT72b5h4y9c7mdcB5NLjDzFtup1WZSDQh0g8nNoqtaNKWpoN+sq82aI1rMZGLeH9nKnBJfzFd9V7PTicmihHXmB9dslyAj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lw1p8sN+gNbCQwpRhbpZZ/wGudgHEHYxqGgd1XE3nI0=;
 b=ttIF17AYqgBEKiQyo/CymmUuNYokq6/OV0/3db7M8HBXl3rXAreZMZL7jv2nORy14ud2EqIThnvm2Ae7r1wPxPw3JqAIdndcOuIRv/Xlo486c2aKt9j0e2jGqhUq6iJuI2YHRsHIf/Jn5Mo4AMTH/WEsa9746ZpOcKzwL5TKO6pDwvvQhSGlkWdR6jOkYNo2Pv8Q4JfDZFhhWY/PuSYVIv3kD03YM55fLJVtNeebz7f1Bs2UV/yZExDSTaGt1vudiPjRKQL9M1gbUPWua8svupGN0BF+omLgDA4ztRbKHLWyvvENW5ixaWakdPAabd9AJF09InWNuvsxrf88ubwA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lw1p8sN+gNbCQwpRhbpZZ/wGudgHEHYxqGgd1XE3nI0=;
 b=UXbKUs6Hqf4sWaLucTUAavRQZ2A2BWwUeZSQXD3PSuPMekpc0Pgix5xbeb4gxB1IKXq/oHgRc9NDgSgQw7IkOz9YHIKXDSUTU0dEYEPjwQ5I9VQ16wMT1DuGWMwBFo+cjhItWOb37/9pIGGsrXxe4b9QmVhHlGvvSXSGF1FfcB8=
Received: from PH7P221CA0077.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::12)
 by CH3PR12MB9283.namprd12.prod.outlook.com (2603:10b6:610:1cd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 19:04:24 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::3f) by PH7P221CA0077.outlook.office365.com
 (2603:10b6:510:328::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 18/36] drm/amdgpu/sdma5.2: re-emit unprocessed state on ring
 reset
Date: Mon, 7 Jul 2025 15:03:37 -0400
Message-ID: <20250707190355.837891-19-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CH3PR12MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: a62796c1-9220-4c30-847d-08ddbd89163d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?971p0lcRCNZRHhlb91haHxOJUiA14JT5Z8RB1N0X9RX7wSYt8/GCAOQ7OMwq?=
 =?us-ascii?Q?69ixTj2D4nQ5LSVl61PePXx3vuggVypEn/rcs9A3666TAOonWCB8/fOk0wmD?=
 =?us-ascii?Q?TQ3WgfTqkr/8WHWIz2nkIwv/4CBSHkK5IYp0cUPCZ7V4X5WI8rosPt9tLEzw?=
 =?us-ascii?Q?pcc10r0GYgoskLckVYrwUyrNsb0lIw3Qs485eoMaBcFrscUxUgTZmJpZSMBe?=
 =?us-ascii?Q?8l2lHXeG+gb1+oxCJGBV4qXAEnVZDUtWPl+XOmbPKM4B35PckuNj7axG+faw?=
 =?us-ascii?Q?JtMJNXrOyZN4T5eQINp6TUgdRVYjMCYGKXfIqCsUXPs4qBO9uegV9mbWiu2V?=
 =?us-ascii?Q?YH/7MQVikgYGT4xpTQs9q73tKBdgWgsKPfwlqRozLSvQw5zN12tOuaEZ3bl4?=
 =?us-ascii?Q?uVQGCKY50p5V0MSLTdzIIblrnBKMF8wGip/nCLEjclsdST9+YvqfAeIwqKzw?=
 =?us-ascii?Q?FeZEvIrqTBRdEOynpZAomofyRoVgljd2r3KAP1Jp4uSzOKkFVYfUaIuMMeQr?=
 =?us-ascii?Q?pHI8A+RQhJp1JNPDrchLnBdLsjrfjmdkA03w0ZhFHcY6eTCyohVASg74jmhH?=
 =?us-ascii?Q?WBz69rkvYHyx+p5KXvlYNVAyJStFtlMB5pRH01Y3XrjClwwLai21sy5cq9j0?=
 =?us-ascii?Q?eVT8DP+JdqJ5MOCFDvrTyMMLkNIZfoA8GEBn2FjFmkah/83LN8DoPbqXb68E?=
 =?us-ascii?Q?1kL/Zzu2Ezwz+LFEPqt0eL2noQKEJ4PBiiALc781/IoVBZKTaBDsjD39xr/T?=
 =?us-ascii?Q?0uF5OPO39PljqGEvG2NGxXfHUJOhbDE6thFfba0YIKf5NQwoW2xcY4xefMmC?=
 =?us-ascii?Q?iUahcok650kGwc+t3SIf/EYGV0F6nKen3gjdaITUCvY4fd/CoNnMxCDqH80q?=
 =?us-ascii?Q?QGHeRDbbtDjQMIDec5NrmvesP52a18as3yr7DIF5hkzfze/cmMJQKUsbePAZ?=
 =?us-ascii?Q?T+aNF0j0rQWufGYTkyGmty8Yz5eUQO9TcuOb+6BagueCrKoekgp6NfjwB2rW?=
 =?us-ascii?Q?fssvEha9R3whLtOOmhA9cDBYUOFkFgNZqqIuN93i3II9dDUn/73ZQ+N7gKNI?=
 =?us-ascii?Q?pluVXtBjDPXFiGKWz4IWVXDuvhwAaYNt/y+W1OlJJEMrzsYOTVi6MAVBUr6X?=
 =?us-ascii?Q?UNE9BQ3NUKDCpWb9RLGsCd1iPPWVtqIc8+hzHRmUR2L616u4vU1Y9Me0Wh1o?=
 =?us-ascii?Q?JyQWpd50Mhk0aT1j/w7vmcC0cdmi/DeOhfzOdBkHtz+JGod2ZgYtN9D0fijr?=
 =?us-ascii?Q?FUb4pBO1J6L1CG5H9liWV/t/FFypeAzTXqr8gGcdhQxdMq34ArpFdemOTLRu?=
 =?us-ascii?Q?wYpjeoXEKfdjK5YhEJeJcFjfi93IepG0cfDI8DAaPW2UnfFl6JZyPxDbciK1?=
 =?us-ascii?Q?I9vdkK2VDWZF3sBEOqFchSqszIeM6tpGYzXxnRT2Lodd0ZuBAP/ZQ53Ejtdo?=
 =?us-ascii?Q?nR6AqUMQ7QflYktxcu2VDTs16xBmbmKE2HfYpjc5V2gvLmrI2NVaaiA084a4?=
 =?us-ascii?Q?tL/UGQ5+t4JrclzTlMab3Zcd44OfKz2b7hfM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:23.6890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a62796c1-9220-4c30-847d-08ddbd89163d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9283
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

Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 908ed8b849376..3011808a6ae20 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1467,11 +1467,15 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+
 	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, ring->me, false);
+	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
 	amdgpu_amdkfd_resume(adev, true);
+	if (r)
+		return r;
 
-	return r;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
-- 
2.50.0

