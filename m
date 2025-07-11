Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20320C83F21
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B16D010EAED;
	Fri, 11 Jul 2025 22:41:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SzztWKgY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96EE210EAED
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSlZyRNjbqL9Z1eHDCs3wqr269zoIld9kce7OB1gEJOKUvgjT9Gq+uXlYGewQK2ZZRsdoSmhFHtFHCd8HAxi3Ps6StHYoftCxOpjfv8YgzwvsYYBaosz/NvGjxqsDYGGbQAPG64HpMQ8UTk1RS+kC8dgF8H6+rIKNm1TkQLDtYOjnkkyPucqKWwnKtxZHBu/xQmy+fjIA8rA6P0qtnO+2PPIrVWM1gnMULpIKCSqFoImv7wWUPMdv1Ynk1hDCfTa5/TSzJCq8Mkg9KB2wcJasSuGYcItZp4uDwBg8kXQYkMmNh5ofwbzIY7sINhT6rmW0iW8VaE9Ozrm5t2MT0jzrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHgLySApsSerfufBmRs7PHxmRIXJTC/3FNLK2fApC3w=;
 b=BLX7CIkqc8fBuE/C/uRZJQcBqcfhwTX/x4CRJfXYj8YWGF5qD9xtcRriHQKVf8A37bPCaSZewO/sGyzTXRE+XnSadbybFinCoIFKJlX4JlyMwVQpwExSXgXeWiOXlqX2r+Z9cZSpQnBu1UY0Yu9kMhYjUZw3lb0vrfYfwMh9mNvAV4cUdt+22WZbA0LAFHqx87NfxVdqfE2kNWg6e1JhrB1A8xSwHnMCEaGMCV8mkiTBWrprZY7gzcMPWDFHS+17S0QVseACFqdTBndCysaew7vFfYjWVomeTiMLQd75476MFkPFn/caW30EvUCW4AXp0wndTYg3XqTcBsFbWaK6TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHgLySApsSerfufBmRs7PHxmRIXJTC/3FNLK2fApC3w=;
 b=SzztWKgYbcNt+UKPBfC8cPlkDy1BSFfTSN7BvaJAXmiHkr/tihCKdrn8rARy+sKCkaPgx6rJotblTCRDfz7b+rHIAJaqttYoielNXlsulc6JLq24FphAF3RoChL2Fi02XRsvszvXKR1JnYXmWtzA15hSFmEPY6uEJCxs2LrOYPY=
Received: from SJ0PR03CA0218.namprd03.prod.outlook.com (2603:10b6:a03:39f::13)
 by IA0PPF89A593F05.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Fri, 11 Jul
 2025 22:40:52 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::d2) by SJ0PR03CA0218.outlook.office365.com
 (2603:10b6:a03:39f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 22:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 21/33] drm/amdgpu/jpeg4: re-emit unprocessed state on ring
 reset
Date: Fri, 11 Jul 2025 18:40:12 -0400
Message-ID: <20250711224024.410506-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|IA0PPF89A593F05:EE_
X-MS-Office365-Filtering-Correlation-Id: e86c2ca3-239a-4cd2-f3e7-08ddc0cbfd90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hYaEaeylkm1IXz0bwwpPTPRWYSWEVZtnzR42w1uN3wWMhDQoNwe56wOc3YgV?=
 =?us-ascii?Q?FXh8oCCmB8N3ghEr0kpyJM3SSchAKzAGvKXbWLXtwFmZvedvUcmTTLCXp5TL?=
 =?us-ascii?Q?5EDBEVHooEFRvt19IoRJ1WIY5Bmrggh8CW712Q/UNxPrgVIsK9OgkdbqxD7e?=
 =?us-ascii?Q?j1SHNjJttR1b9HUB0tyq93Cu4d+Jf29hWzAES0iIb3b5Fai2e+XzkD2xG9Ig?=
 =?us-ascii?Q?LtVRkEMDwGdxp+n6Z8fgls9NphZVwKq4PN1LIRP389oeFOK6rDPdbJz9fAfJ?=
 =?us-ascii?Q?jWp8ds0MrW30DgqXqlZUHOxOwm0e4w488E0EcYtTfOYTJu8gs+ybUYWK+0PD?=
 =?us-ascii?Q?zuE82+p15AGzjLWbC1SEJCrNoc9qdGttjTcaNdjNROnXaBk3CgV33oYmw85Q?=
 =?us-ascii?Q?l0IQ2916XED7dD9Gq4iZEr8PFlpZZXHcKBiMXLcBeUqAge054JOIItRC3qgA?=
 =?us-ascii?Q?kipJhct20Oumr5FPO3u5dVuShmY9V9BmPc5RoJNIzH+3HxGCcim97oNzJjuS?=
 =?us-ascii?Q?O383ucuVU1Kriv5GIFivABapkQ5/2v50wBZhpls4A5m0UsQBlnMR0uxeJT/e?=
 =?us-ascii?Q?Jd4DGceC9eA5XXb0I2KIWQprUuOWHvO6X6CbW2z25uf3h0rc5ntY8TDKanJs?=
 =?us-ascii?Q?0virc0H5AgkxmdEVJLT/FR4bFGyHTiaxw+bA9Z2f+ME0sqZ7D0rBajrhNsSN?=
 =?us-ascii?Q?L8+fsoWdsGwYuSKpM4zfDeJvtTX01X3b7N64AAwpkKmj8LfCm3oc2etTpVjX?=
 =?us-ascii?Q?5L4/KJ49aSefy0X7O0tYt+zE+PzqS8zMW8vFQTjdww2DiWHfQtkGIjb9KzkK?=
 =?us-ascii?Q?BmGJ5wAUCbw96r8ulg+c0YsZas3J1VHLJJNh+SiZUq7/248kZDDv9RSBAv7r?=
 =?us-ascii?Q?EfUu2fg9N5hSK2mxHcXaA9Pbwiko99w+1uTC99M6Htil+Y+P1TXjDJNDDN5C?=
 =?us-ascii?Q?eL2METedRKDYGDz28/fXOqnPGEGEDrRKbqlK2iyC9BgGaf9I84Bw14L3PDll?=
 =?us-ascii?Q?hM4axbczOzjawWFxqsUa9yzB0esTfAdsv4QVUfaU1xH9O+5lOLZb2RXWujh+?=
 =?us-ascii?Q?0oVcvQB6N1tTrplVe2IdxWSFdDkfuuzA+mDrxnY9C+9wclxRi697Q6wGFN/p?=
 =?us-ascii?Q?3MMXppL/15eTZYlW1xou4bJPsMLwYWKTXdSnZ9vw+HS+Lfv53ppGXvrfbl7c?=
 =?us-ascii?Q?sdKtkYRVBdUFAZhqZf5ayU7ylBjfoWHsDRAGhtu6ESMr7mmWt1nO0ZmE+sB+?=
 =?us-ascii?Q?tvvpetbC5HonkDDZ6XMjaHIqNiSZTJLBOirrfigs82AUixo2gUpmTsVC3e5M?=
 =?us-ascii?Q?rmBeTbPcYXL4+Urk/wC1sWMMw2rt1dmDuW33Rk770/3jXZ+ZWfF/aqUMABF+?=
 =?us-ascii?Q?KopStUg+rKQYSWcB4f15klPAFkmWwdBdLhum1FVFHOwBH+gyty6m0Pscp4Yj?=
 =?us-ascii?Q?82gixqWEPZNj8owuxnXxCs5l9Scz4b5zEXBdQVo671mUndxGdx6jb4ifAkir?=
 =?us-ascii?Q?kKoKDprywt3Ei/fKbi3bhTAZHNe9ZxbDQwwf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:52.0627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e86c2ca3-239a-4cd2-f3e7-08ddc0cbfd90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF89A593F05
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 5485e983a089f..ca3debe371c5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -730,19 +730,14 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
 	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = jpeg_v4_0_stop(ring->adev);
 	if (r)
 		return r;
 	r = jpeg_v4_0_start(ring->adev);
 	if (r)
 		return r;
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
-- 
2.50.0

