Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E312C021A7
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 05:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9171610E2AC;
	Thu, 13 Feb 2025 05:48:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F2mynQqR";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F05610E2AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 05:48:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MO03K78OuuXijcMym3EcflBGVcQOISfWDAyGqcUqAeyYjvPetwUTKFWiJ3+W1PitsK7nouSRyooyalb1Gh8i1v2QwtqeJ2+wGWqG1TLPlYMOkeLsdtOqpJdTzJEPc96Rvy0RJEKy6BH/PM+mtNCkx4ucZd9ZPgjZ9GXB5y92xs9b1BHR/bhOH7+f3qXwKXzBwzpqpDxGucCiRnLaSU4W44w8VctjMCKcOQJElzIsfpseJ1wriWCyTtLbvQN8FAADTIZ3rULfSFepkuK6nzMe+Wxz9sUUdT/s46Z84TDlYuOZgjFN+9EclZ1pwyBeooz2i6upwcobVCSFEzQRfd2cMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ra5TEo20ylXUJMrB4Ix76/vBT2ck2oSbnV/2tcQtr+k=;
 b=UD2viUil90T2fD1Dl07Qi8OlTUmNxzQE7/s+nzI/TUH7qVoDiAVVR4XomHIFUfrYBWpFazDXheKgQ9H8++7U3Kb3Q3y3yDdpY8bfFzMedOqcj6B50UAmGOXt2iGEUkT2SNIJqujM9ehpPduBGdb1t/KSHyt9GF9kPKvzYegwWo1lp2j/+E32ON+MfBCzG3T7+Yw02t/fNa/u2gdD0+J7x91x1j75k1ldaQ4gHL1Dh1kJbk/XpRwQOV5Q3qexnS8qalDcPYTlUO5/imPOxdli5wu0lzzHEu2DGW6fOESlw+io7jaJqJMdJWBRscF+4CHJoreVTJ02+MOE/0QrKsZm2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ra5TEo20ylXUJMrB4Ix76/vBT2ck2oSbnV/2tcQtr+k=;
 b=F2mynQqRHYnS8FVytND5liPwEtesT6wa9udY+8gdneiGFPPvhd3BqHKhLQ2W76lQTxgWBUC7Y0Qkr/+9ZKsqMpL2ZWpvN9I0QamM0LRE2pGw48pXHSo1WBxKxHWHFbL+ShxzIPwmrpEXmDns151GgH3xBTNCt8V31FJ9IPOIddw=
Received: from DS7PR03CA0235.namprd03.prod.outlook.com (2603:10b6:5:3ba::30)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 05:48:08 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::e6) by DS7PR03CA0235.outlook.office365.com
 (2603:10b6:5:3ba::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Thu,
 13 Feb 2025 05:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 05:48:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 23:48:05 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 23:48:05 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 12 Feb 2025 23:47:53 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH V7 4/9] drm/amdgpu: Introduce cached_rptr and is_guilty
 callback in amdgpu_ring
Date: Thu, 13 Feb 2025 13:47:10 +0800
Message-ID: <20250213054715.3121445-4-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213054715.3121445-1-jesse.zhang@amd.com>
References: <20250213054715.3121445-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa5baa3-a1e3-4219-e09a-08dd4bf1fe6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GMg7RLGd8HAZY620hO3A6eGvAqnZXEYvAbJakjRFjLzVmA4gWW1A4HJSBdxk?=
 =?us-ascii?Q?aEE5G11ixLt8eYp84D5NE1jNrXuk6gqlQflQHe3b16SnIDuZsM3KMnJ0TVwY?=
 =?us-ascii?Q?RSeDjD68TuS/tIzEhFje1a+2/7RY8nMUEm/ekZC1ZN4gHPRejwkfragYyNuA?=
 =?us-ascii?Q?n6eHYlM2I8fMatcp3zsBx6O8ljxIHolk/Ghye5KXPLwW81hwX4b7qPQJ4Qr1?=
 =?us-ascii?Q?VwD2rgFSdNm7xbbgsKcxaxgluyLmMoT6dXNhhBiCng4xlrBI1n/bLXVepe0w?=
 =?us-ascii?Q?9+pIRNfAmbKn5DLXuGEJo5eMfEyUsve38Rmxnr0pfvn5L1wh4OEkUFrjE98n?=
 =?us-ascii?Q?NWjBMiKR29+X6fujjZIoJa7qz3IyUi3Im8Vomv2lG1rqndYedUZftTk7LBZv?=
 =?us-ascii?Q?2Z6kLVUSTcXcKwd2BpreOmJ10UsFLpyod8zEN+tHTqhaOKMO2WTJF6zQRw7P?=
 =?us-ascii?Q?kbFoKkXlwdAd+G6Qjjaa29VnshoNdggmfZWBxJ9cuMcEA9KIyH3mOc6jipwv?=
 =?us-ascii?Q?AOEl+mYs1a+QaYDmWKHylv/FpWjx6wiSImSzMDjsJgMDDfQZIYAzJh4VyVHn?=
 =?us-ascii?Q?LzwAZTGCn1K7wfUQkQRZVPzPNYrwX/a+HMDSAQ5mdEKvLLSV7cvW4rZyNU5l?=
 =?us-ascii?Q?t6id1qbaTZCAJ0PrM42nX731mDAejlaeXY8uFShjQjcS59VSJ00KyJp86To8?=
 =?us-ascii?Q?pfJlnvu0vWbmnzPNN5Iyzxka/qHjLRfsnIlvubFnMU3rKyz51TqB5l16/QLI?=
 =?us-ascii?Q?8zyIegLm86U+llvizA2LnmcT8CObqX3eL5WKemqgcplsC8Olu+pT4BnM2oRq?=
 =?us-ascii?Q?jCU5IacjSYYLpfSvWKAgmpAdcadhATuagq9jfLSWnSIoREob2mQZsacHkN+j?=
 =?us-ascii?Q?GKuqNXMrnhJJTek7r5D+j7HRqIU3CqOmO3SItTdopQqOrp+o6XnnPLu4QJpn?=
 =?us-ascii?Q?m7UvGfkMhwU50mXFN5tnk1wddouSFDUFesrol0TBWpyWax4MDITi3SJOenrt?=
 =?us-ascii?Q?0B6htTwRpaJCrP+E3JUNJmWkDNe1j65ywLqwDnNKLaa7wprQp/BN6LhQWSX4?=
 =?us-ascii?Q?5gEn9fwFrnlAhRJ882kCACkXNsIhpUZ3Pmn4jM8DqVzdW5bI5tn1lhHo+J8o?=
 =?us-ascii?Q?PbTxGvgCrUKTQdIF+VdC/ZECQISieZ1siNPdKKugbig40+bauX4SrWgYUZhn?=
 =?us-ascii?Q?zogMSwTzRdbOXd4+1GOAH4X6F05VL3pAD+gcdOiQWPOUUI0t6XeMtQgMOvE7?=
 =?us-ascii?Q?2cH8oBphRX7ayB8P3/5KcSYSQrebQXq46u1OGiugfcfFdUnrakjY3OYSDUAo?=
 =?us-ascii?Q?Yw6I1R6luMXyLcrvc2iXP069n35tmlC6CIF591+2kQat1B3OIwZegwkja5PX?=
 =?us-ascii?Q?H8vnW6kbvYbdtZS9VD3nQuslH0gnGFAjzCdK0UqdMCrtod0SE/qq9uNwrWE3?=
 =?us-ascii?Q?VPbjdDjMsIAbVxxhemyCptt5b6q9PTI2EdqGh0e/h+LlLHqFeJNgQWk7YxRT?=
 =?us-ascii?Q?yXEX8wwZvzgLbgs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 05:48:08.3068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa5baa3-a1e3-4219-e09a-08dd4bf1fe6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch introduces the following changes:
- Add `cached_rptr` to the `amdgpu_ring` structure to store the read pointer before a reset.
- Add `is_guilty` callback to the `amdgpu_ring_funcs` structure to check if a ring is guilty of causing a timeout.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index a6e28fe3f8d6..20cd21df38ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -342,6 +342,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	ring->buf_mask = (ring->ring_size / 4) - 1;
 	ring->ptr_mask = ring->funcs->support_64bit_ptrs ?
 		0xffffffffffffffff : ring->buf_mask;
+	/*  Initialize cached_rptr to 0 */
+	ring->cached_rptr = 0;
 
 	/* Allocate ring buffer */
 	if (ring->is_mes_queue) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 04af26536f97..182aa535d395 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -237,6 +237,7 @@ struct amdgpu_ring_funcs {
 	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
 	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
 	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
+	bool (*is_guilty)(struct amdgpu_ring *ring);
 };
 
 struct amdgpu_ring {
@@ -306,6 +307,8 @@ struct amdgpu_ring {
 
 	bool            is_sw_ring;
 	unsigned int    entry_index;
+	/* store the cached rptr to restore after reset */
+	uint64_t cached_rptr;
 
 };
 
-- 
2.25.1

