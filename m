Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1347C83F22
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C61A10EAE5;
	Fri, 11 Jul 2025 22:41:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kr4P+vcL";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1BE910EAEE
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:41:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpQU+jnf3Ksjo9PjBbtjkxOE8SnWnMWhiB5ijOqpjrJANfNZn1teUP+JP0PYvv3F7GYXRwSPMV0wDMxkNODCyx+eZQemWMLU0SchOaUSVUfdv8U2HtTDUFN07wX5VIvPbla2bCvYKG4MEL9MYpDKXbIKJezWhPOZmS54dXy4l1S7qJoB19mLHsjQ1DDKsn9VzCCU5aeITEMsk5muQkqdDYl8Yn2VZBVqeeJdJj6Az56Gd1W0aVb7zOnsWIxcCniUeNcAesOBrDIqLugqn6HSR/vifshZBmQW/2aSwLV4dsBOhCU6flxpccrLWmnGC9yXGPUVwRD/t2tfJzE1W/sA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46E8nH9sWDvXFo/ZSzwpwdIYcye14AJ8ItNoitZ42MI=;
 b=GmICwnAz1dPHRffTuM2j3dIY9Kyx2hlM65BT6+w7ZhcLrvNcbGfzbWfu5MpzURnnMp1gNjT7J88ztyQJg8Fw8Ph+kQFScyqFN1+EsF4u4+HSTpSgBD6UKE0o0dYeHXpt9oQWGra9+ADGNbQrBkBzUmKNqZQXElyATEqF8FUGheKHRboiNpfWn38iqvwn0aQ2E7tl6gWsmCif6b3Rr8qUYXwkqa/Rj9EG5WRFvo8kPpeo1Tdxya7rGsStytotqwi0M+BOy/HN2TMrHedDtoCcnl6sG0Opt60FragoRYXwhuwiE+6Fhoc54uLk4AU/uCGri6UysZl0E1pnwCSE3SBcKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46E8nH9sWDvXFo/ZSzwpwdIYcye14AJ8ItNoitZ42MI=;
 b=kr4P+vcLsD5uQI2yjrpgOZnb1FwCLikEx1R64a2L7n88lcKne6Z08vVyWeZX/qKAHoUHgFCyUDVANSDw8b/9gv5lL/L1XTqbVQASbxC4CtuJ+ZgHggDIgpiiCnCKmiL9fA32k1sXGjUASK78oF8A+EoP/rjl+0oAlrYFUid+k5Y=
Received: from SJ0PR03CA0239.namprd03.prod.outlook.com (2603:10b6:a03:39f::34)
 by DS0PR12MB6632.namprd12.prod.outlook.com (2603:10b6:8:d0::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.25; Fri, 11 Jul 2025 22:40:57 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::5e) by SJ0PR03CA0239.outlook.office365.com
 (2603:10b6:a03:39f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 22:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 27/33] drm/amdgpu/vcn4.0.3: re-emit unprocessed state on ring
 reset
Date: Fri, 11 Jul 2025 18:40:18 -0400
Message-ID: <20250711224024.410506-28-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|DS0PR12MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a2fc31-874c-4724-a060-08ddc0cc00ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ueyDHF78w8or4m/vvUed783pgk9YY5VSUui6g55/I9jJSJEqQaUM+M4Twlge?=
 =?us-ascii?Q?Yvh/lcpaYtpPPBY25rWCmyKAR/41vhbi7TP5B7ub99UW03YjdjDyW6UZsKcW?=
 =?us-ascii?Q?4yXQB9wImGySoxFaAFOFOkqtU4z/4pxSUDQaGbOzK4ilKKwN6kY/5sqqu8dp?=
 =?us-ascii?Q?4rXKbloVt+sEOXLBr1SE/AQ09kBhJUzPtxE+e2Qc+zoxZoP2D9RhBKBPVTBZ?=
 =?us-ascii?Q?i6b6z53XURgmt9pRH7jNThP8Ep0SYW8DJqq0XWC3OM75amnJW5lnsKqKNey6?=
 =?us-ascii?Q?ae0SjhNbljkIHJPjt71PNrSPeMmiSt4a7xfpz74rql47PihOR/swjbnkWNwp?=
 =?us-ascii?Q?6aSd5Vjdny7/VK0q1wb3FU2G0axWt3yzOJxdKzDSt4DpgeOswzLzehTg0a6e?=
 =?us-ascii?Q?VOk679/VAgxpy5hKlGWCEogGA+cKA5IZ0KESe3mkf9krmMJBnKop1YLIaoh6?=
 =?us-ascii?Q?L1T0C8Mf8qzDYU+Pt3W6J/rAdwad75DrSncRIU95TL9krn6P3jQkyO2mbx3b?=
 =?us-ascii?Q?CxX9rS0b+Uacu77U/LAXt/87OmSiE/lgMirxWh6U/DmGNg+XyfKRAMjURcjf?=
 =?us-ascii?Q?pxaObJdCWX3QAWToe1pJZDPpqhd/BfW8T0QXBqdK1leFfWjfpH5LHBhl63Ut?=
 =?us-ascii?Q?FUZ5WN8/ZR9J0fRqpwokqfQcTQxE/RUW3b0vqwmVa3V4Oqb91SF8C3bGKOkr?=
 =?us-ascii?Q?cA73ta+k+wry2Cp7xNBW3xyx5RNV8CZZhBvajyhS5N8zojH8t4+hhQOCAg2/?=
 =?us-ascii?Q?Fms0dRk7lAA67evJ4Sr78WJpsO/SoD8Hc1/miHlzFeMiy0FCroxeABtKxHum?=
 =?us-ascii?Q?6N49Bd9CNITn/byz4zC4C+3vB4rZ0uRGeGQtUnJCGFzFZG2vnkNtYfIBtu7U?=
 =?us-ascii?Q?nKxN8e5dMEXm4je5paQWq2kMAIW1S2sDIPMzSue2TLxjEXCso22tdgBwPIqd?=
 =?us-ascii?Q?ynDJYtbsm0/1bEYlWYRwyvNjhXMKooTcXqBsuqDDa3tKhKHj43Ih5O2UNG82?=
 =?us-ascii?Q?eDZH6E0rDKu7rgV6YfIXj3EDcLgQiPoyPpcTJMWCq5jlYgZUd1KYEVIwUn6i?=
 =?us-ascii?Q?UCNBXP3umwoHg9KWEvDOktC6c1Qpz3q3Qqq7yvAuA2KIToF/tGL4cvVddYK4?=
 =?us-ascii?Q?UxxKJRnBykjdqIWn+pk0w2EH3gd4iwpsDh4XOUp0014Sw0LWn+G7iCRSt0aR?=
 =?us-ascii?Q?anJdOc2rgn+6aboUhGC6MeaxCPaUm0XccK6GegwircNWR1pSG/pMy2X/slWm?=
 =?us-ascii?Q?tUfwl5i1ljHvqeh8INaKTsrlqRiihKyO2L7xY1isnMjpGEH2ni6FdhGf3nIa?=
 =?us-ascii?Q?Y8Zccdys91l2qOJ80mlTEgeBxhGbRKz4q9LGCIAw8ZtV2l9cysn5R94CVfya?=
 =?us-ascii?Q?7xFE7RD05f+o+XZWm2KrjN73qNq72g1ZmuIawi/CGb9kMta3laf6wAlKyEX2?=
 =?us-ascii?Q?HdNfcIN5dZY1c67EdduZorOIZQWIujacB4sn2+YFjOg6o6PiCWAqEn2jaoc2?=
 =?us-ascii?Q?HZn4u8q1TM9KQ0oBGuGFkIfg75SjmbLzmsW6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:57.3692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a2fc31-874c-4724-a060-08ddc0cc00ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6632
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
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index d8fd32c1e38ec..3bda19b92cde7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1609,7 +1609,7 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	vcn_inst = GET_INST(VCN, ring->me);
 	r = amdgpu_dpm_reset_vcn(adev, 1 << vcn_inst);
@@ -1624,12 +1624,8 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
 	vcn_v4_0_3_hw_init_inst(vinst);
 	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
-- 
2.50.0

